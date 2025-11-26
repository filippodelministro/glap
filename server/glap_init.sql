-- CREAZIONE DATABASE
DROP DATABASE IF EXISTS glap;
CREATE DATABASE glap;
USE glap;

-- INIZIO TRANSAZIONE
begin TRANSACTION;

DROP TABLE IF EXISTS team;
CREATE TABLE team (
    id_team INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

DROP TABLE IF EXISTS player;
CREATE TABLE player (
    id_player INT AUTO_INCREMENT PRIMARY KEY,
    id_team INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    number INT,
    role VARCHAR(50),
    FOREIGN KEY (id_team) REFERENCES team(id_team)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS matches;   -- match è parola riservata
CREATE TABLE matches (
    id_match INT AUTO_INCREMENT PRIMARY KEY,
    id_home_team INT NOT NULL,
    id_away_team INT NOT NULL,
    match_date DATETIME NOT NULL,
    home_goals INT DEFAULT 0,
    away_goals INT DEFAULT 0,
    FOREIGN KEY (id_home_team) REFERENCES team(id_team),
    FOREIGN KEY (id_away_team) REFERENCES team(id_team)
) ENGINE=InnoDB;

-- INSERT SQUADRE
INSERT INTO team (name) VALUES
('Tattari'),
('Saetta McTeam'),
('Blancatorres'),
('Sconosciuti'),
('Terroni'),
('Svincolati'),
('***'),
('***');

-- INSERT PARTITE
INSERT INTO matches (id_home_team, id_away_team, match_date, home_goals, away_goals) VALUES
(1, 2, '2024-09-01 19:00:00', 1, 0),
(3, 4, '2024-09-01 19:00:00', 6, 4),
(5, 6, '2024-09-01 19:00:00', 0, 6);

COMMIT;