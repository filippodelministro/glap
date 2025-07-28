'use strict';

/* Data Access Object (DAO) module for accessing users data */

const db = require('./db');
const crypto = require('crypto');

// This function returns user's information given its id.
exports.getUserById = (id) => {
  return new Promise((resolve, reject) => {
    const sql = 'SELECT * FROM users WHERE id=?';
    db.get(sql, [id], (err, row) => {
      if (err)
        reject(err);
      else if (row === undefined)
        resolve({ error: 'User not found.' });
      else {
        // By default, the local strategy looks for "username": 
        // for simplicity, instead of using "email", we create an object with that property.
        const user = { id: row.id, name: row.name }
        resolve(user);
      }
    });
  });
};

// This function is used at log-in time to verify username and password.
exports.getUser = (name, password) => {
  return new Promise((resolve, reject) => {
    const sql = 'SELECT * FROM users WHERE name=?';
    db.get(sql, [name], (err, row) => {
      if (err) {
        reject(err);
      } else if (row === undefined) {
        resolve(false);
      }
      else {
        const user = { id: row.id, username: row.name};

        // Check the hashes with an async call, this operation may be CPU-intensive (and we don't want to block the server)
        crypto.scrypt(password, row.salt, 32, function (err, hashedPassword) { // WARN: it is 64 and not 32 (as in the week example) in the DB
          if (err) reject(err);
          if (!crypto.timingSafeEqual(Buffer.from(row.hash, 'hex'), hashedPassword)) // WARN: it is hash and not password (as in the week example) in the DB
            resolve(false);
          else
            resolve(user);
        });
      }
    });
  });
};

// Check for the availability of the username and then create a new user
exports.createUser = (credentials) => {
  return new Promise((resolve, reject) => {
    const sqlCheck = 'SELECT * FROM users WHERE name=?';
    const sqlInsert = 'INSERT INTO users (name, hash, salt) VALUES (?, ?, ?)';

    const username = credentials.username;
    const password = credentials.password;

    db.get(sqlCheck, [username], (err, row) => {
      if (err) {
        console.error("Error querying database for user:", err);
        return reject(err);
      } else if (row) {
        console.log("User already exists:", username);
        return resolve(false); // L'utente esiste già
      }

      // Generate random salt
      const salt = crypto.randomBytes(16).toString('hex');
      
      // Generate hash of the password using the salt
      crypto.scrypt(password, salt, 32, (err, derivedKey) => { 
        if (err) {
          console.error("Error generating password hash:", err);
          return reject(err);
        }

        const hash = derivedKey.toString('hex');

        // Insert new user by registering the username, hash and salt (NO password is saved)
        db.run(sqlInsert, [username, hash, salt], function(err) {
          if (err) {
            console.error("Error inserting new user:", err);
            return reject(err);
          }

          console.log("New user created with ID:", this.lastID);
          return resolve(true);
        });
      });
    });
  });
};