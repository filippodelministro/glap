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