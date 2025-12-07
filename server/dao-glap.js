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
                // console.log(teams);
                resolve(teams);
            }
        });
    });
};

const convertMatchFromDbRecord = (dbRecord) => {
    return {
        id: dbRecord.id_match,
        league: dbRecord.league,
        group: dbRecord.group_name,
        round: dbRecord.round,
        date: dbRecord.date,
        time: dbRecord.time,
        team_home_id: dbRecord.team_home_id,
        team_away_id: dbRecord.team_away_id,
        team_home: dbRecord.team_home,
        team_away: dbRecord.team_away,
        goals_home: dbRecord.goals_home,
        goals_away: dbRecord.goals_away,
        winner: dbRecord.winner,
        penalties: dbRecord.penalties
    };
};

// MATCHES STRUCTURE(league, `group`, round, date, time, team_home, team_away, goals_home, goals_away, winner, penalties)
exports.listMatches = () => {
    return new Promise((resolve, reject) => {
        const sql = `
            SELECT 
                m.mid AS id_match,
                m.league,
                m.\`group\` AS group_name,
                m.round,
                m.date,
                m.time,
                m.team_home AS team_home_id,
                m.team_away AS team_away_id,
                th.name AS team_home,
                ta.name AS team_away,
                m.goals_home,
                m.goals_away,
                m.winner,
                m.penalties
            FROM matches m
            JOIN team th ON m.team_home = th.tid
            JOIN team ta ON m.team_away = ta.tid;
            -- WHERE m.league = 9;
        `;

        db.all(sql, [], (err, rows) => {
            if (err) return reject(err);
            resolve(rows.map(convertMatchFromDbRecord));
        });
    });
};


const convertRankingFromDbRecord = (dbRecord) => ({
    position: dbRecord.position,
    team_id: dbRecord.tid, 
    team: dbRecord.team,
    league: dbRecord.league, 
    group: dbRecord.group,   
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
                    t.tid,
                    t.name AS team,
                    m.league,
                    m."group",
                    SUM(
                        CASE 
                            WHEN m.winner != 0 AND m.penalties = 0 AND t.tid = m.winner THEN 3
                            WHEN m.winner != 0 AND m.penalties = 1 AND t.tid = m.winner THEN 2
                            WHEN m.winner != 0 AND m.penalties = 1 AND t.tid != m.winner THEN 1
                            ELSE 0
                        END
                    ) AS pt,
                    COUNT(CASE WHEN m.winner != 0 THEN 1 END) AS played,
                    SUM(
                        CASE 
                            WHEN m.winner != 0 AND m.penalties = 0 AND t.tid = m.winner THEN 1
                            WHEN m.winner != 0 AND m.penalties = 1 AND t.tid = m.winner THEN 1
                            ELSE 0
                        END
                    ) AS wins,
                    SUM(
                        CASE 
                            WHEN m.winner != 0 AND m.penalties = 1 AND t.tid != m.winner THEN 1
                            ELSE 0
                        END
                    ) AS draws_or_pen_losses,
                    SUM(
                        CASE 
                            WHEN m.winner != 0 AND m.penalties = 0 AND t.tid != m.winner THEN 1
                            ELSE 0
                        END
                    ) AS losses,
                    SUM(
                        CASE WHEN m.team_home = t.tid THEN m.goals_home
                            WHEN m.team_away = t.tid THEN m.goals_away
                            ELSE 0
                        END
                    ) AS gf,
                    SUM(
                        CASE WHEN m.team_home = t.tid THEN m.goals_away
                            WHEN m.team_away = t.tid THEN m.goals_home
                            ELSE 0
                        END
                    ) AS gs
                FROM team t
                INNER JOIN matches m ON t.tid = m.team_home OR t.tid = m.team_away
                GROUP BY t.tid, m.league, m."group"
            )
            SELECT 
                ROW_NUMBER() OVER (PARTITION BY league, "group" ORDER BY pt DESC, (gf - gs) DESC, gf DESC) AS position,
                league,
                "group",
                team, 
                tid, 
                pt, 
                played, 
                wins, 
                draws_or_pen_losses AS draws, 
                losses, 
                gf, 
                gs, 
                (gf - gs) AS dr
            FROM stats
            ORDER BY league, "group", position;
        `;

        db.all(sql, [], (err, rows) => {
            if (err) {
                reject(err);
            } else {
                const ranking = rows.map(convertRankingFromDbRecord);
                console.log(ranking);
                resolve(ranking);
            }
        });
    });
};