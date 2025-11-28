DROP TABLE IF EXISTS team;
CREATE TABLE team (
    id_team INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

DROP TABLE IF EXISTS player;
CREATE TABLE player (
    id_player INTEGER PRIMARY KEY AUTOINCREMENT,
    id_team INTEGER NOT NULL,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    number INTEGER,
    role TEXT,
    FOREIGN KEY (id_team) REFERENCES team(id_team)
);

DROP TABLE IF EXISTS matches;
CREATE TABLE matches (
    id_match INTEGER PRIMARY KEY AUTOINCREMENT,
    id_home_team INTEGER NOT NULL,
    id_away_team INTEGER NOT NULL,
    match_date TEXT NOT NULL,
    home_goals INTEGER DEFAULT 0,
    away_goals INTEGER DEFAULT 0,
    FOREIGN KEY (id_home_team) REFERENCES team(id_team),
    FOREIGN KEY (id_away_team) REFERENCES team(id_team)
);

INSERT INTO team (name) VALUES
('Tattari'),
('Saetta McTeam'),
('Blancatorres'),
('Sconosciuti'),
('Terroni'),
('Svincolati'),
('***'),
('***');

INSERT INTO matches (id_home_team, id_away_team, match_date, home_goals, away_goals) VALUES
(1, 2, '2024-09-01 19:00:00', 1, 0),
(3, 4, '2024-09-01 19:00:00', 6, 4),
(5, 6, '2024-09-01 19:00:00', 0, 6);