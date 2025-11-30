'use strict';

/* Data Access Object (DAO) module for accessing films data */

const db = require('./db');
const dayjs = require("dayjs");


const convertTeamFromDbRecord = (dbRecord) => {
  const team = {};
  team.id = dbRecord.id_team;
  team.name = dbRecord.name;

  return team;
}


exports.listTeams = () => {
    return new Promise((resolve, reject) => {
        const sql = 'SELECT * FROM team';
        db.all(sql, [], (err, rows) => {
            if (err) {
                reject(err);
            } else {
                const teams = rows.map(convertTeamFromDbRecord);
                console.log(teams);
                resolve(teams);
            }
        });
    });
};

const convertMatchFromDbRecord = (dbRecord) => {
    const match = {};
    match.id = dbRecord.id_match;
    match.round = dbRecord.round;
    match.date = dbRecord.date;
    match.time = dbRecord.time;
    match.team_home_id = dbRecord.team_home_id;
    match.team_away_id = dbRecord.team_away_id;
    match.team_home = dbRecord.team_home;
    match.team_away = dbRecord.team_away;
    match.goals_home = dbRecord.goals_home;
    match.goals_away = dbRecord.goals_away;
    match.winner = dbRecord.winner;
    match.penalties = dbRecord.penalties;

    return match;
};
exports.listMatches = () => {
    return new Promise((resolve, reject) => {
        // const sql = 'SELECT * FROM matches';
        const sql = `
            SELECT 
                m.id_match,
                m.round,
                m.date,
                m.time,
                m.team_home as team_home_id,
                m.team_away as team_away_id,
                th.name AS team_home,
                ta.name AS team_away,
                m.goals_home,
                m.goals_away,
                m.winner,
                m.penalties
            FROM matches m
            JOIN team th ON m.team_home = th.id_team
            JOIN team ta ON m.team_away = ta.id_team
            ORDER BY m.round, m.date, m.time
        `;

        db.all(sql, [], (err, rows) => {
            if (err) {
                reject(err);
            } else {
                const matches = rows.map(convertMatchFromDbRecord); // se vuoi trasformare i campi
                console.log(matches);
                resolve(matches);
            }
        });
    });
};
const convertRankingFromDbRecord = (dbRecord) => ({
    position: dbRecord.position,
    team: dbRecord.team,
    pt: dbRecord.pt,
    played: dbRecord.played,
    wins: dbRecord.wins,
    draws: dbRecord.draws,
    losses: dbRecord.losses,
    gf: dbRecord.gf,
    gs: dbRecord.gs,
    dr: dbRecord.dr
});

exports.getRanking = () => {
    return new Promise((resolve, reject) => {
        const sql = `
            WITH stats AS (
                SELECT
                    t.id_team,
                    t.name AS team,
                    SUM(
                        CASE 
                            WHEN m.goals_home IS NOT NULL AND m.goals_away IS NOT NULL AND 
                                 ((m.team_home = t.id_team AND m.goals_home > m.goals_away) OR
                                  (m.team_away = t.id_team AND m.goals_away > m.goals_home))
                            THEN 3
                            WHEN m.goals_home IS NOT NULL AND m.goals_away IS NOT NULL AND m.goals_home = m.goals_away
                            THEN 1
                            ELSE 0
                        END
                    ) AS pt,
                    COUNT(
                        CASE WHEN m.goals_home IS NOT NULL AND m.goals_away IS NOT NULL THEN 1 END
                    ) AS played,
                    SUM(
                        CASE 
                            WHEN m.goals_home IS NOT NULL AND m.goals_away IS NOT NULL AND 
                                 ((m.team_home = t.id_team AND m.goals_home > m.goals_away) OR
                                  (m.team_away = t.id_team AND m.goals_away > m.goals_home))
                            THEN 1 ELSE 0
                        END
                    ) AS wins,
                    SUM(
                        CASE 
                            WHEN m.goals_home IS NOT NULL AND m.goals_away IS NOT NULL AND m.goals_home = m.goals_away
                            THEN 1 ELSE 0
                        END
                    ) AS draws,
                    SUM(
                        CASE 
                            WHEN m.goals_home IS NOT NULL AND m.goals_away IS NOT NULL AND 
                                 ((m.team_home = t.id_team AND m.goals_home < m.goals_away) OR
                                  (m.team_away = t.id_team AND m.goals_away < m.goals_home))
                            THEN 1 ELSE 0
                        END
                    ) AS losses,
                    SUM(
                        CASE WHEN m.team_home = t.id_team THEN m.goals_home
                             WHEN m.team_away = t.id_team THEN m.goals_away
                             ELSE 0
                        END
                    ) AS gf,
                    SUM(
                        CASE WHEN m.team_home = t.id_team THEN m.goals_away
                             WHEN m.team_away = t.id_team THEN m.goals_home
                             ELSE 0
                        END
                    ) AS gs
                FROM team t
                LEFT JOIN matches m ON t.id_team = m.team_home OR t.id_team = m.team_away
                GROUP BY t.id_team
            )
            SELECT 
                ROW_NUMBER() OVER (ORDER BY pt DESC, (gf - gs) DESC) AS position,
                team, pt, played, wins, draws, losses, gf, gs, (gf - gs) AS dr
            FROM stats
            ORDER BY position
        `;

        db.all(sql, [], (err, rows) => {
            if (err) {
                reject(err);
            } else {
                const ranking = rows.map(convertRankingFromDbRecord);
                resolve(ranking);
            }
        });
    });
};