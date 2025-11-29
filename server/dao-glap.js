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

