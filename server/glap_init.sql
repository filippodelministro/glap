BEGIN TRANSACTION;


DROP TABLE IF EXISTS users;	
CREATE TABLE users (
	"id"	INTEGER NOT NULL,
	"email"	TEXT NOT NULL,
	"name"	TEXT,
	"hash"	TEXT NOT NULL,
	"salt"	TEXT NOT NULL,
    "level" TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);

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
	foot CHAR, 
    FOREIGN KEY (id_team) REFERENCES team(id_team)
);

DROP TABLE IF EXISTS matches;
CREATE TABLE matches (
    id_match INTEGER PRIMARY KEY AUTOINCREMENT,
    date date NOT NULL,
    team_home INTEGER NOT NULL,
    team_away INTEGER NOT NULL,
    goals_home INTEGER DEFAULT 0,
    goals_away INTEGER DEFAULT 0,
    FOREIGN KEY (team_home) REFERENCES team(id_team),
    FOREIGN KEY (team_away) REFERENCES team(id_team)
);

-- Population

INSERT INTO team (name) VALUES
('Arancini'),
('Blancatorres'),
('Legna'),
('Saetta McTeam'),
('Sailpost'),
('Sconosciuti'),
('Sporting Mistona'),
('Svincolati'),
('Tattari'),
('Terroni');

INSERT INTO player (id_team, name, surname, number, role, foot) VALUES
-- Arancini
(1, "Pierluca", "Morganti", 0, "???", "?"),
(1, "Roberto", "Barone", 0, "???", "?"),
(1, "Gianluca", "Bizzarri", 0, "???", "?"),
(1, "Tommaso", "Giacomelli", 0, "???", "?"),
(1, "Alessandro", "Matteoni", 0, "???", "?"),
(1, "Andrea", "Equi", 0, "???", "?"),

-- Blancatorres
(2, "Mirko", "Giuffrida", 0, "???", "?"),
(2, "Andrea", "Minneci", 0, "???", "?"),
(2, "Giacomo", "Rovini", 0, "???", "?"),
(2, "Alex", "Cioffi", 0, "???", "?"),
(2, "Lorenzo", "Cioffi", 0, "???", "?"),
(2, "Abdel", "Laghcha", 0, "???", "?"),
(2, "Adil", "Laghcha", 0, "???", "?"),
(2, "Oussama", "Saber", 0, "???", "?"),

-- Legna
(3, "Alberto", "Nundini", 0, "???", "?"),
(3, "Lorenzo", "Scaglione", 0, "???", "?"),
(3, "Marco", "Botrugno", 0, "???", "?"),
(3, "Simone", "Gionfriddo", 0, "???", "?"),
(3, "Alessandro", "Nundini", 0, "???", "?"),
(3, "Giulio", "Macchi", 0, "???", "?"),

-- Saetta McTeam
(4, "Francesco", "Giussani", 0, "???", "?"),
(4, "Matteo", "Allamandri", 0, "???", "?"),
(4, "Emanuele", "Cittadini", 0, "???", "?"),
(4, "Lorenzo", "Galli", 0, "???", "?"),
(4, "Davide", "Rullo", 0, "???", "?"),
(4, "Alberto", "Saikali", 0, "???", "?"),
(4, "Federico", "Bernacca", 0, "???", "?"),
(4, "Andrea", "Campanelli", 0, "???", "?"),
(4, "Niccolò", "Galli", 0, "???", "?"),
(4, "Matteo", "Montalbetti", 0, "???", "?"),
(4, "Lorenzo", "Montana", 0, "???", "?"),

-- Sailpost
(5, "Pietro", "Macchi", 0, "???", "?"),
(5, "Manuel", "Giustini", 0, "???", "?"),
(5, "Giacomo", "Salvetti", 0, "???", "?"),
(5, "Giovanni", "Ferrarin", 0, "???", "?"),
(5, "Fabio", "Bartalini", 0, "???", "?"),
(5, "Emanuale", "Favati", 0, "???", "?"),
(5, "Lorenzo", "Fiorini", 0, "???", "?"),
(5, "Simone", "Cecchetti", 0, "???", "?"),
(5, "Alessio", "Felice", 0, "???", "?"),

-- SQUADRA 6
(6, "Gabriele", "Ghelardoni", 0, "???", "?"),
(6, "Emilio", "Tesi", 0, "???", "?"),
(6, "Riccardo", "Carra", 0, "???", "?"),
(6, "Dario", "Leggio", 0, "???", "?"),
(6, "Fabio", "Savà", 0, "???", "?"),
(6, "Gio", "Lautaro", 0, "???", "?"),
(6, "Angelo", "Mandarano", 0, "???", "?"),
(6, "Filippo", "Braun", 0, "???", "?"),

-- Sconosciuti
(7, "Alessio", "Corsi", 0, "???", "?"),
(7, "Marco", "Lattanzi", 0, "???", "?"),
(7, "Francesco", "Pataro", 0, "???", "?"),
(7, "Rosario Andrea", "Di Stefano", 0, "???", "?"),
(7, "Fabio", "Ziino", 0, "???", "?"),
(7, "El Mehdi", "Beneskhoune", 0, "???", "?"),
(7, "Ludovico", "Giusti", 0, "???", "?"),

-- Svincolati
(8, "Eugenio", "Casarosa", 0, "???", "?"),
(8, "Lorenzo", "Mazzotta", 0, "???", "?"),
(8, "Tommaso", "Napoli", 0, "???", "?"),
(8, "Federico", "Pannocchia", 0, "???", "?"),
(8, "Renato", "Busco", 0, "???", "?"),
(8, "Daniel", "Giannini", 0, "???", "?"),
(8, "Tommaso", "Taglioli", 0, "???", "?"),
(8, "Amir", "Nafafaa", 0, "???", "?"),
(8, "Crispo", "Mattia", 0, "???", "?"),

-- Tattari
(9, "Rocco", "Gerini", 0, "???", "?"),
(9, "Daniel", "Di Ciolo", 0, "???", "?"),
(9, "Mattia", "Fadda", 0, "???", "?"),
(9, "Diego", "Malgani", 0, "???", "?"),
(9, "Fabio", "Uperi", 0, "???", "?"),
(9, "Luca", "Basile", 0, "???", "?"),
(9, "Pietro", "Monari", 0, "???", "?"),
(9, "Giulio", "Bacci", 0, "???", "?"),
(9, "Giani", "Nicola", 0, "???", "?"),
(9, "Domenici", "Lorenzo", 0, "???", "?"),

-- Terroni
(10, "Antonio", "Patania", 0, "???", "?"),
(10, "Luca", "L'Andolina", 0, "???", "?"),
(10, "Matteo", "L'Andolina", 0, "???", "?"),
(10, "Angelo", "Tabbì", 0, "???", "?"),
(10, "Santo", "Plutino", 0, "???", "?"),
(10, "Corrado", "L'Andolina", 0, "???", "?"),
(10, "Enrico", "Campo", 0, "???", "?"),
(10, "Fulvio", "Giovanni", 0, "???", "?");


INSERT INTO "users" VALUES (1,'u1@p.it','John','15d3c4fca80fa608dcedeb65ac10eff78d20c88800d016369a3d2963742ea288','72e4eeb14def3b21','premium');
INSERT INTO "users" VALUES (2,'u2@p.it','Alice','1d22239e62539d26ccdb1d114c0f27d8870f70d622f35de0ae2ad651840ee58a','a8b618c717683608','basic');
INSERT INTO "users" VALUES (3,'u3@p.it','George','61ed132df8733b14ae5210457df8f95b987a7d4b8cdf3daf2b5541679e7a0622','e818f0647b4e1fe0','premium');
COMMIT;