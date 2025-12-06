
#DROP DATABASE IF EXISTS GLAP;
#CREATE SCHEMA GLAP;

DROP TABLE IF EXISTS performance;
DROP TABLE IF EXISTS sign;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS team;
DROP TABLE IF EXISTS league;

# Each league have different date and name
CREATE TABLE IF NOT EXISTS league (
    lid INTEGER PRIMARY KEY AUTO_INCREMENT,
    season INTEGER NOT NULL,
    start date not null,
    stop date,
    name TEXT
);

# Players are described by name, surname, ecc.
# They are not linked to any teams by deafult since they can change thorugh years.
# Players are linked to Teams thanks to table 'Sign'
CREATE TABLE IF NOT EXISTS player (
    pid INTEGER PRIMARY KEY AUTO_INCREMENT, 
    name TEXT NOT NULL,
    surname TEXT ,
    nickname TEXT ,
    birthdate DATE ,
    foot TEXT,
    number INT ,
    role TEXT
);

# Each team is identified by 'tid'; for each tid there is only on lid (league) and name
CREATE TABLE IF NOT EXISTS team (
    tid INTEGER PRIMARY KEY AUTO_INCREMENT,
    lid INTEGER NOT NULL,
    name TEXT NOT NULL,
    FOREIGN KEY (lid) REFERENCES league (lid)
);

# Each player can sign for only one team for each league
CREATE TABLE IF NOT EXISTS sign (
    tid INTEGER NOT NULL,
    pid INTEGER NOT NULL,

    FOREIGN KEY (tid) REFERENCES team (tid),
    FOREIGN KEY (pid) REFERENCES player (pid)
);

# Matches table
CREATE TABLE IF NOT EXISTS `matches` (
    mid INTEGER PRIMARY KEY AUTO_INCREMENT,
    league INTEGER NOT NULL,
	`group` TEXT,
    round INTEGER NOT NULL,
    date DATE,
    time TIME ,
    team_home INTEGER NOT NULL,
    team_away INTEGER NOT NULL,
    goals_home INTEGER DEFAULT 0,
    goals_away INTEGER DEFAULT 0,
    winner INTEGER DEFAULT 0,   -- refers to the team_id of the winner team; needed to calculate points when penalties occur
    penalties BIT DEFAULT null,
    FOREIGN KEY (league) REFERENCES league(lid),
    FOREIGN KEY (team_home) REFERENCES team(tid),
    FOREIGN KEY (team_away) REFERENCES team(tid)
);

CREATE TABLE IF NOT EXISTS performance (
    mid INTEGER NOT NULL,
    pid INTEGER NOT NULL,
    goal INTEGER DEFAULT 0,
    grade DOUBLE DEFAULT NULL,
    PRIMARY KEY (mid, pid),
    FOREIGN KEY (mid) REFERENCES matches (mid),
    FOREIGN KEY (pid) REFERENCES player (pid)
);

########################################################################################
########################################################################################

insert into league (season, start, stop, name) values 
/*LID 1*/ (1, '2016-09-01', '2017-04-01', '16/17'),		
/*LID 2*/ (2, '2017-09-01', '2018-04-01', '17/18'),		
/*LID 3*/ (3, '2018-09-01', '2019-04-01', '18/19'),		
/*LID 4*/ (4, '2019-09-01', '2020-04-01', '19/20 A'),		
/*LID 5*/ (4, '2019-09-01', '2020-04-01', '19/20 B'),	
/*LID 6*/ (6, '2021-09-01', '2021-04-01', '21/22 A'),	
/*LID 7*/ (6, '2021-09-01', '2022-04-01', '21/22 B'),	
/*LID 8*/ (7, '2025-02-01', '2025-06-01', '2025'),	
/*LID 9*/ (8, '2025-11-23', null, '25/26');

insert into team (lid, name) values
(1, "Canale"), (1, "Ciardelli"),(1, "Citi"), (1, "Equi"),(1, "Macchi"),(1, "Pardini"),
(2, "Balestri"), (2, "Canale"), (2, "Cecchi"), (2, "Equi"), (2, "Giglia"), (2, "Lupi"), (2, "Macchi"), (2, "Nacci"), (2, "Pardini"), (2, "Vicari"),
(3, "Balestri"), (3, "Botrugno"), (3, "Canale"), (3, "Cecchi"), (3, "Equi"), (3, "Franco"), (3, "Garcea"), (3, "Giani"), (3, "Macchi"), (3, "Pardini"), (3, "Tripiccione"), (3, "Turi"), (3, "Usai"), (3, "Vouk"),
(4, "Aquila"), (4, "Del Punta"), (4, "Domenici"), (4, "Franco"), (4, "Giani"), (4, "Lupi"), (4, "Pardini"), (4, "Rossi"), (4, "Scaglione"), (4, "Vicari"),
(5, "Allegrini"), (5, "Barushi"), (5, "Canale"), (5, "Equi"), (5, "Fiorini"), (5, "Galloni"), (5, "Innocenti"), (5, "Monari"), (5, "Usai"), (5, "Vannini"),
(6, "Aquila"), (6, "Di Pinto"), (6, "Fadda"), (6, "Galloni"), (6, "Gerini"), (6, "Ghelardoni"), (6, "Giani"), (6, "Gullotti"), (6, "Inghirami"), (6, "Rossi"),
(7, "Barushi"), (7, "Marchetti"), (7, "Marranini"), (7, "Monari"), (7, "Nacci"), (7, "Simonetti"), (7, "Sodano"), (7, "Tesi"), (7, "Tognetti"), (7, "Uperi"),
(8, "Airnivol"), (8, "Arancini"), (8, "Brazil"), (8, "CISK La Rissa"), (8, "Deportivo La Dama"), (8, "Five to Torres"), (8, "I pupilli del Marra"), (8, "Leo Infissi"), (8, "Sailpost"), (8, "Svincolati"), (8, "Terroni"), (8, "Wells Fargo"),
(9, "Arancini"), (9, "Blancatorres"), (9, "Legna"), (9, "Saetta Mc Team"), (9, "Sailpost"), (9, "Sconosciuti"), (9, "Sporting Mistona"), (9, "Svincolati"), (9, "Tattari"), (9, "Terroni");

insert into player (name, surname, nickname, birthdate, foot, number, role) VALUES
-- ! IMPORTANT: Always add new players at the end of this block, regardless of alphabetical order or the season they played

("Alberto", "Di Legge", "Albi", null, 'D', null, 'D'),
("Alberto", "Nundini", "NundoJR", null, 'D', null, 'L'),
("Aldo", "Franceschini", null, null, 'D', null, 'A'),
("Alessandro", "Capradossi", null, null, 'D', null, 'D'),
("Alessandro", "Galloni", "Gallo", null, 'D', null, 'D'),
("Alessandro", "Gullotti", "Gullo", null, 'D', null, 'D'),
("Alessandro", "Landucci", "Landu", null, 'S', null, 'L'),
("Alessandro", "Magnozzi", "Magno", null, 'D', 1, 'P'),
("Alessandro", "Matteoni", null, null, 'D', 9, 'A'),
("Alessandro", "Nundini", "Nundo", null, 'D', null, 'D'),
("Alessandro", "Orsitto", null, null, 'D', null, 'D'),
("Alessandro", "Pascuzzo", null, null, 'D', null, 'D'),
("Alessio", "Battimo", null, null, 'D', null, 'D'),
("Alessio", "Bulleri", null, null, 'D', null, 'D'),
("Alessio", "Felice", null, null, 'D', null, 'D'),
("Alessio", "Giugliano", null, null, 'D', null, 'D'),
("Alex", "Cioffi", null, null, 'D', null, 'D'),
("Andrea", "Equi", null, null, 'D', null, 'D'),
("Andrea", "Milano", null, null, 'D', 1, 'P'),
("Andrea", "Nigro", null, null, 'D', null, 'D'),
("Andrea", "Pardini", null, null, 'D', 24, 'D'),
("Andrea", "Vicari", null, null, 'D', 1, 'P'),
("Angelo", "Mandarano", null, null, 'D', null, 'D'),
("Antonio", "Esposito", null, null, 'D', null, 'D'),
("Antonio", "Mangani", null, null, 'D', null, 'D'),
("Bellavia", null, null, null, 'D', null, 'D'),
("Luca", "Benedetti", null, null, 'D', null, 'D'),
("Alberto", "Borghini", null, null, 'D', null, 'D'),
("Cesare", "Parma", null, null, 'D', null, 'D'),
("Cristian", "Librizzi", null, null, 'D', null, 'P/D'),
("Damiano", "Rossi", null, null, 'D', null, 'D'),
("Dario", "Bertelli", null, null, 'D', null, 'D'),
("Dario", "Mennucci", null, null, 'D', null, 'D'),
("Davide", "Bianucci", null, null, 'D', null, 'D'),
("Dominik", "Krasniqi", null, null, 'D', null, 'D'),
("Edoardo", "Di Scalzo", null, null, 'D', null, 'P'),
("Edoardo", "Ruffoli", null, null, 'D', null, 'P'),
("Egi", "Dimo", null, null, 'D', null, 'D'),
("Egon", "Di Marco", null, null, 'D', null, 'D'),
("Elia", "Mazzantini", null, null, 'D', null, 'D'),
("Emilio", "Tesi", null, null, 'D', null, 'P'),
("Enrico", "Tripiccione", null, null, 'D', null, 'P'),
("Erik", "Rexepaj", null, null, 'D', null, 'D'),
("Ettore", "Usai", null, null, 'D', null, 'D'),
("Eugenio", "Casarosa", null, null, 'D', null, 'D'),
("Fabio", "Barushi", null, null, 'D', null, 'D'),
("Fabio", "Mammini", null, null, 'D', null, 'D'),
("Fabio", "Uperi", null, null, 'D', null, 'D'),
("NOME", "Fatticcioni", null, null, 'D', null, 'D'),
("Federico", "Bernardeschi", null, null, 'D', null, 'D'),
("Federico", "Galli", null, null, 'D', null, 'D'),
("Federico", "Vanni", null, null, 'D', null, 'D'),
("Filippo", "Braun", null, null, 'D', null, 'D'),
("Filippo", "Del Ministro", "Pippo", '1999-12-30', 'D', 0, 'D'),
("Filippo", "Fantacci", null, null, 'D', null, 'D'),
("Filippo", "Marchetti", null, null, 'D', null, 'D'),
("Filippo", "Prato", null, null, 'D', null, 'D'),
("Filippo", "Sciubba", null, null, 'D', null, 'D'),
("Filippo", "Scuglia", null, null, 'D', null, 'A'),
("Francesco", "Arrighi", null, null, 'D', null, 'A'),
("Francesco", "Cambi", null, null, 'D', null, 'D'),
("Francesco", "Cecchi", null, null, 'D', null, 'D'),
("Francesco", "Di Lena", null, null, 'D', null, 'D'),
("Francesco", "Ferrarin", null, null, 'D', null, 'D'),
("Francesco", "Fiorini", null, null, 'D', null, 'P'),
("Francesco", "Ghezzi", null, null, 'D', null, 'D'),
("Francesco", "Giussani", null, null, 'D', null, 'P'),
("Francesco", "Inghirami", null, null, 'S', null, 'L'),
("Francesco", "Pappalardo", null, null, 'D', null, 'D'),
("Francesco", "Pellegrini", null, null, 'D', null, 'D'),
("Gabriele", "Garcea", null, null, 'D', 89, 'A'),
("Gabriele", "Ghelardoni", null, null, 'D', null, 'D'),
("Gabriele", "Guidotti", null, null, 'D', null, 'D'),
("Gabriele", "Vannini", null, null, 'D', null, 'D'),
("Galileo", "Leoncini", null, null, 'D', null, 'D'),
("Giacomo", "Ceccanti", null, null, 'D', null, 'D'),
("Giacomo", "Chetoni", null, null, 'D', null, 'L'),
("Giacomo", "Del Corso", null, null, 'D', null, 'D'),
("Giacomo", "Maione", null, null, 'D', null, 'D'),
("Gianluca", "Batini", null, null, 'D', null, 'D'),
("Gianluca", "Bizzarri", null, null, 'D', null, 'D'),
("Gianmarco", "Bianchi", null, null, 'D', null, 'D'),
("Giorgio", "Bellavia", null, null, 'D', null, 'P'),
("Giorgio Charles", "Sorrentini", null, null, 'D', null, 'D'),
("Giovanni", "Ferrarin", null, null, 'D', null, 'D'),
("Giovanni", "Mucci", null, null, 'D', null, 'D'),
("Giulio", "Filippeschi", null, null, 'D', null, 'D'),
("Giulio", "Fuso", null, null, 'D', null, 'D'),
("Giuseppe", "Mesoraca", null, null, 'D', null, 'L'),
("Davide", "Guariniello", null, null, 'D', null, 'D'),
("Mattia", "Iacopini", null, null, 'D', null, 'D'),
("Iacopo", "Michelotti", null, null, 'D', null, 'D'),
("Ivan", "Bioli", null, null, 'D', null, 'P'),
("Jacopo", "Innocenti", null, null, 'D', null, 'D'),
("Jalil", "Fracasso", null, null, 'D', null, 'D'),
("Janvier", "Calabrese", null, null, 'D', null, 'D'),
("Jonas", "Pingitore", null, null, 'D', null, 'D'),
("Khalil", "Berzouz", null, null, 'D', null, 'D'),
("Leonardo", "Aquila", null, null, 'D', 1, 'P/L'),
("Leonardo", "Bartalini", null, null, 'D', null, 'D'),
("Leonardo", "Nacci", null, null, 'D', null, 'D'),
("Leonardo", "Pagliai", null, null, 'D', 8, 'D'),
("Leonardo", "Simoni", null, null, 'D', null, 'D'),
("Leonardo", "Turi", null, null, 'D', null, 'D'),
("Lorenzo", "Barachini", "Bara", null, 'S', null, 'L'),
("Lorenzo", "Barci", null, null, 'D', null, 'D'),
("Lorenzo", "Canale", null, null, 'D', null, 'D'),
("Lorenzo", "Coltelli", null, null, 'D', null, 'D'),
("Lorenzo", "Di Pinto", null, null, 'D', null, 'D'),
("Lorenzo", "Domenici", null, null, 'D', 10, 'L'),
("Lorenzo", "Donadel", null, null, 'D', null, 'D'),
("Lorenzo", "Fiorini", null, null, 'D', null, 'A'),
("Lorenzo", "Franco", null, null, 'D', null, 'D'),
("Lorenzo", "Fumagalli", null, null, 'D', null, 'D'),
("Lorenzo", "Giglia", null, null, 'D', null, 'D'),
("Lorenzo", "Lazzeretti", null, null, 'D', null, 'A'),
("Lorenzo", "Luschi", null, null, 'D', null, 'D'),
("Lorenzo", "Masi", null, null, 'D', null, 'D'),
("Lorenzo", "Punzi", null, null, 'D', null, 'D'),
("Lorenzo", "Ruffi", null, null, 'D', null, 'D'),
("Lorenzo", "Salvini", null, null, 'D', null, 'D'),
("Lorenzo", "Scaglione", null, null, 'D', 5, 'D'),
("Lorenzo", "Tognetti", null, null, 'D', null, 'D'),
("Lorenzo", "Vouk", null, null, 'D', null, 'D'),
("Luca", "Basile", null, null, 'D', null, 'A'),
("Luca", "Bellavia", null, null, 'D', null, 'A'),
("Luca", "Lanza", null, null, 'D', null, 'D'),
("Luca", "Suppressa", null, null, 'D', null, 'D'),
("Luciano", "D'Onofrio", null, null, 'D', null, 'D'),
("Luciano", "Mistretta", null, null, 'D', 11, 'L'),
("Luigi", "Lugaresi", null, null, 'D', null, 'D'),
("Manuel", "Rinaldi", null, null, 'D', null, 'D'),
("Marco", "Allegrini", null, null, 'D', null, 'P'),
("Marco", "Bettini", null, null, 'D', null, 'D'),
("Marco", "Botrugno", null, null, 'D', null, 'D'),
("Marco", "Chiarelli", null, null, 'D', null, 'P'),
("Marco", "Gelli", null, null, 'D', null, 'D'),
("Marco", "Somigli", null, null, 'D', null, 'D'),
("Martino", "Simonetti", null, null, 'D', null, 'D'),
("Mathieu", "Duchenne", null, null, 'D', null, 'D'),
("Matteo", "Atzeni", null, null, 'D', 99, 'D'),
("Matteo", "Ciardelli", null, null, 'D', 1, 'P'),
("Matteo", "Cipolli", null, null, 'D', null, 'D'),
("Matteo", "Colombini", null, null, 'D', null, 'D'),
("Matteo", "Giacomelli", null, null, 'D', null, 'D'),
("Matteo", "Giannetti", null, null, 'D', null, 'D'),
("Matteo", "Maccanti", null, null, 'D', null, 'D'),
("Matteo", "Manca", null, null, 'D', null, 'L'),
("Matteo", "Marrannini", null, null, 'D', null, 'D'),
("Matteo", "Marchetti", null, null, 'D', null, 'D'),
("Matteo", "Pischedda", null, null, 'D', null, 'A'),
("Matteo", "Polizzi", null, null, 'D', null, 'D'),
("Matteo", "Puccio", null, null, 'D', null, 'A'),
("Mattia", "Barbuti", null, null, 'D', null, 'D'),
("Mattia", "Biber", null, null, 'D', null, 'D'),
("Mattia", "Cei", null, null, 'D', null, 'D'),
("Mattia", "Fadda", null, null, 'D', null, 'P'),
("Michele", "Amodio", null, null, 'D', null, 'D'),
("Michele", "Barghini", null, null, 'D', null, 'D'),
("Michele", "Campani", null, null, 'D', null, 'D'),
("Michele", "Pratali", null, null, 'D', null, 'D'),
("Niccolò", "Amato", null, null, 'D', null, 'L'),
("Niccolò", "Bartolommei", null, null, 'D', null, 'D'),
("Niccolò", "Gabbetta", null, null, 'D', null, 'D'),
("Niccolò", "Possenti", null, null, 'D', null, 'D'),
("Niccolò", "Tozzini", null, null, 'D', null, 'D'),
("Niccolò", "Traina", null, null, 'D', null, 'A'),
("Nicola", "Coppo", null, null, 'D', null, 'D'),
("Nicola", "Fabbri", null, null, 'D', null, 'D'),
("Nicola", "Giani", null, null, 'D', 4, 'D'),
("Nicolò", "Alessio", null, null, 'D', null, 'D'),
("Nicolò", "Bigi", null, null, 'D', null, 'D'),
("Nicolò", "Salinari", null, null, 'D', null, 'D'),
("Nicolò", "Stafico", null, null, 'D', null, 'D'),
("Ninni", "Asaro", null, null, 'D', null, 'D'),
("Pierluca", "Morganti", "Pica", null, 'D', 9, 'A'),
("Pierluigi", "Anichini", null, null, 'D', null, 'D'),
("Pietro", "Balestri", null, null, 'D', null, 'D'),
("Pietro", "Brogni", null, null, 'D', null, 'D'),
("Pietro", "Del Prete", null, null, 'D', null, 'D'),
("Pietro", "Gizzi", null, null, 'D', null, 'D'),
("Pietro", "Macchi", null, null, 'D', null, 'D'),
("Pietro", "Marrali", null, null, 'D', null, 'L'),
("Pietro", "Mey", null, null, 'D', null, 'D'),
("Pietro", "Monari", null, null, 'D', null, 'D'),
("Pietro", "Taccola", null, null, 'D', 10, 'D'),
("Pietro", "Vetturini", null, null, 'D', null, 'P'),
("Ranieri", "Leoncini", null, null, 'D', null, 'D'),
("Remi", "Skhreta", null, null, 'D', null, 'D'),
("Renato", "Busco", null, null, 'D', null, 'D'),
("Riccardo", "Almanza", null, null, 'D', 3, 'L'),
("Riccardo", "De Sio", null, null, 'D', null, 'L'),
("Richard", "Harper", null, null, 'D', null, 'D'),
("Roberto", "Barone", null, null, 'D', null, 'A'),
("Sam", "Potortì", null, null, 'D', null, 'L'),
("Samuele", "Barandoni", null, null, 'D', 10, 'L'),
("Samuele", "Ciardelli", null, null, 'D', null, 'A'),
("Simone", "Del Punta", null, null, 'D', 1, 'P'),
("Simone", "Logerfo", null, null, 'D', null, 'D'),
("Simone", "Rossi", null, null, 'D', null, 'D'),
("Simone", "Tonarelli", null, null, 'D', null, 'D'),
("Federico", "Sodano", null, null, 'D', null, 'D'),
("Marco", "Sposato", null, null, 'D', null, 'D'),
("Stivi", "Musta", null, null, 'D', null, 'D'),
("Thomas", "Castellacci", null, null, 'D', 4, 'D'),
("Tommaso", "Bonanni", null, null, 'D', 1, 'P'),
("Tommaso", "Chiappelli", null, null, 'D', null, 'L'),
("Tommaso", "Di Lupo", null, null, 'D', null, 'D'),
("Tommaso", "Ghelardoni", null, null, 'D', null, 'D'),
("Tommaso", "Ghimenti", null, null, 'D', null, 'D'),
("Tommaso", "Giacomelli", null, null, 'D', null, 'D'),
("Tommaso", "Giusti", null, null, 'D', null, 'D'),
("Tommaso", "Guidi", null, null, 'D', null, 'D'),
("Tommaso", "Marrocco", null, null, 'D', null, 'D'),
("Tommaso", "Picci", null, null, 'D', 7, 'A'),
("Tommaso", "Taglioli", null, null, 'D', null, 'L'),
("Tommaso", "Traina", null, null, 'D', null, 'P'),
("Vincenzo", "Maio", null, "1999-12-26", 'D', 7, 'L'),
("Vincenzo", "Sacco", null, null, 'D', null, 'D'),
("Vittorio", "Cibeca", null, null, 'D', null, 'D'),
("Vittorio", "Lupi", null, null, 'D', 1, 'D'),
("Rocco", "Gerini", "Erreocicio", null, 'D', 22, 'D'),
("Bruno", "Fusari", "Burno", null, 'D', 4, 'D'),
("Tommaso", "Giannetti", null, null, 'D', 5, 'D'),
("Marco", "Luschi", null, null, 'D', 1, 'P'),
("Matteo", "Picchetti", "Picche", '1999-03-08', 'D', 3, 'D'),
("Francesco", "Sardi", null, null, 'D', 2, 'D'),
("Leonardo", "Citi", null, null, 'D', null, 'D'),
("Alessandro", "Mazzieri", null, null, null, null, null),
("Lorenzo", "Palomba", null, null, null, null, 'P'),
("NOME", "De Matteis", null, null, null, null, null),
("NOME", "Burroni", null, null, null, null, null),
("NOME", "Tozzi", null, null, null, null, null),
("Giulio", "Bacci", null, null, null, null, null),
("NOME", "Di Marco", null, null, null, null, null),

####### New player, League 2025
("Abderrazak", "Laghcha", null, null, null, null, null),
("Adil", "Laghcha", null, null, null, null, null),
("Alban", "Rexhepaj", null, null, null, null, null),
("Alberto", "Lischi", null, null, null, null, null),
("Alex", "Gneri", null, null, null, null, null),
("Alessio", "Di Francesco", null, null, null, null, null),
("Alessio", "Gignali", null, null, null, null, null),
("Amedeo", "Vizza", null, null, null, null, null),
("Andrea", "Di Lecce", null, null, null, null, null),
("Antonio", "Patania", null, null, null, null, null),
("Daniele", "Di Ciolo", null, null, null, null, null),
("Davide", "Ceccoli", null, null, null, null, null),
("Diego", "Luperini", null, null, null, null, null),
("Diego", "Malgani", null, null, null, null, null),
("Edoardo", "Artigiani", null, null, null, null, null),
("Enrico", "Redini", null, null, null, null, null),
("Emanuele", "Favati", null, null, null, null, null),
("Fabio", "Bartalini", null, null, null, null, null),
("Filippo", "Costamangna", null, null, null, null, null),
("Filippo", "Ricci", null, null, null, null, null),
("Federico", "Pannocchia", null, null, null, null, null),
("Giacomo", "Salvetti", null, null, null, null, 'P'),
("Gino", "Taccini", null, null, null, null, null),
("Leonardo", "Lanzellotti", null, null, null, null, null),
("Lorenzo", "Benvenuti", null, null, null, null, null),
("Lorenzo", "Cioffi", null, null, null, null, null),
("Lorenzo", "Firincelli", null, null, null, null, null),
("Lorenzo", "Galli", null, null, null, null, null),
("Lorenzo", "Landucci", null, null, null, null, null),
("Lorenzo", "Landi", null, null, null, null, null),
("Lorenzo", "Mazzotta", null, null, null, null, null),
("Lorenzo", "Salinardi", null, null, null, null, null),
("Luca", "L'andolina", null, null, null, null, null),
("Luca", "Tedeschi", null, null, null, null, null),
("Manuel", "Giustini", null, null, null, null, null),
("Marco", "Benedetti", null, null, null, null, null),
("Mattia", "Amanati", null, null, null, null, null),
("Mattia", "Crispo", null, null, null, null, null),
("Mattia", "Stefanini", null, null, null, null, null),
("Matteo", "Balduini", null, null, null, null, null),
("Matteo", "Falconetti", null, null, null, null, null),
("Matteo", "L'andolina", null, null, null, null, null),
("Matteo", "Margheri", null, null, null, null, null),
("Mauro", "Mezzapelle", null, null, null, null, null),
("Micheal", "Ghelardoni", null, null, null, null, null),
("Mirko", "Barsotti", null, null, null, null, null),
("Mirko", "Giuffrida", null, null, null, null, null),
("Niccolò", "Viale", null, null, null, null, null),
("Nicola", "Barsi", null, null, null, null, null),
("Nicola", "Dell'Innocenti", null, null, null, null, null),
("Nicola", "Garofalo", null, null, null, null, null),
("Paolo", "Schamous", null, null, null, null, null),
("Pierfrancesco", "Giuliani", null, null, null, null, null),
("Rino", "Motta", null, null, null, null, null),
("Robert", "Dumitrescu", null, null, null, null, null),
("Roberto", "Lampioni", null, null, null, null, null),
("Sandokan", "Kajtazi", null, null, null, null, null),
("Saverio", "Viti", null, null, null, null, null),
("Simone", "Bonifazi", null, null, null, null, null),
("Simone", "Calistri", null, null, null, null, null),
("Valerio", "Ghelardoni", null, null, null, null, null),
("Valerio", "Pecchia", null, null, null, null, null),
("Emanuele", "Cittadini", null, null, null, null, null),
("NOME", "Falconi", null, null, null, null, null),
("NOME", "Pucci", null, null, null, null, null),
("Francesco", "Delmonaco", null, null, null, null, null),
("Francesco", "Pace", null, null, null, null, null),

####### New player League 25/26
("Andrea", "Minnecci", null, null, null, null, null),
("Giacomo", "Rovini", null, null, null, null, null),
("Oussama", "Saber", null, null, null, null, null),
("Simone", "Gionfriddo", null, null, null, null, null),
("Giulio", "Macchi", null, null, null, null, null),
("Matteo", "Allamandri", null, null, null, null, null),
("Davide", "Rullo", null, null, null, null, null),
("Alberto", "Saikali", null, null, null, null, null),
("Federico", "Bernacca", null, null, null, null, null),
("Andrea", "Campanelli", null, null, null, null, null),
("Niccolò", "Galli", null, null, null, null, null),
("Matteo", "Montalbetti", null, null, null, null, null),
("Lorenzo", "Montana", null, null, null, null, null),
("Riccardo", "Carra", null, null, null, null, null),
("Gio", "Lautaro", null, null, null, null, null),
("Dario", "Leggio", null, null, null, null, null),
("Fabio", "Savà", null, null, null, null, null),
("Alessio", "Corsi", null, null, null, null, null),
("Marco", "Lattanzi", null, null, null, null, null),
("Francesco", "Pataro", null, null, null, null, null),
("Rosario Andrea", "Di Stefano", null, null, null, null, null),
("Fabio", "Ziino", null, null, null, null, null),
("El Mehdi", "Beneskhoune", null, null, null, null, null),
("Ludovico", "Giusti", null, null, null, null, null),
("Tommaso", "Napoli", null, null, null, null, null),
("Daniel", "Giannini", null, null, null, null, null),
("Amir", "Nafafaa", null, null, null, null, null),
("Angelo", "Tabbì", null, null, null, null, null),
("Santo", "Plutino", null, null, null, null, null),
("Corrado", "L'Andolina", null, null, null, null, null),
("Enrico", "Campo", null, null, null, null, null),
("Giovanni", "Fulvio", null, null, null, null, null),
("Simone", "Cecchetti", null, null, null, null, null),
("Fernando", "Meini", null, null, null, null, null),
("Giuseppe", "Fanfulla", null, null, null, null, null),
("NOME", "Bellincioni", null, null, null, null, null),
("NOME", "Contini", null, null, null, null, null),
("Francesco", "Gaddini", null, null, null, null, null),
("Samuele", "Lucchesi", null, null, null, null, null);


insert into sign (tid, pid) values 
############## Stagione 2016-2017
/*Canale*/ (1, 107), (1, 71), (1, 180), (1, 222), (1, 34), (1, 101), (1, 150), (1, 22),
/*Ciardelli*/ (2, 142), (2, 115), (2, 181), (2, 89), (2, 74), (2, 178), (2, 29),
/*Citi*/ (3, 228), (3, 62), (3, 169), (3, 133), (3, 87), (3, 122), (3, 338),
/*Equi*/ (4, 18), (4, 17), (4, 134), (4, 161), (4, 177), (4, 195), (4, 221),
/*Macchi*/ (5, 182), (5, 193), (5, 227), (5, 183), (5, 88), (5, 44), (5, 136),
/*Pardini*/ (6, 21), (6, 176), (6, 113), (6, 99), (6, 156), (6, 37),

############## Stagione 2017-2018
-- Da controllare
/*Balestri*/ (7, 178), (7, 93), (7, 169), (7, 196), (7, 122), (7, 62), (7, 231), 
/*Canale*/ (8, 107), (8, 8), (8, 95), (8, 181), (8, 180), (8, 222), (8, 228), 
/*Cecchi*/ (9, 62), (9, 65), (9, 34), (9, 176), (9, 110), (9, 80), (9, 87), 
/*Equi*/ (10, 18), (10, 37), (10, 150), (10, 104), (10, 161), (10, 166), (10, 134), 
/*Giglia*/ (11, 115), (11, 142), (11, 162), (11, 82), (11, 89), (11, 128), (11, 71), 
/*Lupi*/ (12, 221), (12, 124), (12, 200), (12, 64), (12, 85), (12, 229), (12, 156), 
/*Macchi*/ (13, 182), (13, 230), (13, 155), (13, 155), (13, 44), (13, 88), (13, 146), 
/*Nacci*/ (14, 101), (14, 136), (14, 79), (14, 68), (14, 227), (14, 177), (14, 42), 
/*Pardini*/ (15, 21), (15, 133), (15, 99), (15, 183), (15, 137), (15, 40), (15, 29), 
/*Vicari*/ (16, 22), (16, 113), (16, 170), (16, 193), (16, 212), (16, 1), (16, 74),

############## Stagione 2018-2019
/*Balestri*/ (17, 178), (17, 8), (17, 185), (17, 141), (17, 183), (17, 169), (17, 88), 
/*Botrugno*/ (18, 135), (18, 221), (18, 54), (18, 156), (18, 89), (18, 10), (18, 47), 
/*Canale*/ (19, 107), (19, 67), (19, 101), (19, 162), (19, 79), (19, 76), (19, 82), 
/*Cecchi*/ (20, 62), (20, 93), (20, 181), (20, 196), (20, 226), (20, 34), (20, 103), 
/*Equi*/ (21, 18), (21, 187), (21, 200), (21, 30), (21, 207), (21, 55), (21, 72), 
/*Franco*/ (22, 113), (22, 22), (22, 66), (22, 94), (22, 119), (22, 194), (22, 31),
/*Garcea*/ (23, 71), (23, 136), (23, 137), (23, 222), (23, 74), (23, 106), (23, 78), 
/*Giani*/ (24, 170), (24, 133), (24, 110), (24, 46), (24, 150), (24, 192), (24, 165), 
/*Macchi*/ (25, 182), (25, 65), (25, 68), (25, 180), (25, 86), (25, 212), (25, 12), 
/*Pardini*/ (26, 21), (26, 217), (26, 87), (26, 85), (26, 69), (26, 176), (26, 167), 
/*Tripiccione*/ (27, 42), (27, 214), (27, 99), (27, 161), (27, 112), (27, 186), (27, 128), (27,1),
/*Turi*/ (28, 104), (28, 19), (28, 134), (28, 127), (28, 80), (28, 63), (28, 177), 
/*Usai*/ (29, 44), (29, 142), (29, 6), (29, 118), (29, 193), (29, 218), (29, 164), 
/*Vouk*/ (30, 124), (30, 198), (30, 5), (30, 122), (30, 1), (30, 115), (30, 64),

############## Stagione 2019-2020, serie A
/*Aquila*/ (31, 99), (31, 80), (31, 161), (31, 176), (31, 163), (31, 196), (31, 60),
/*Del Punta*/ (32, 198), (32, 54), (32, 148), (32, 125), (32, 222), (32, 215), (32, 47),
/*Domenici*/ (33, 110), (33, 83), (33, 127), (33, 186), (33, 102), (33, 116), (33, 109),
/*Franco*/ (34, 113), (34, 194), (34, 206), (34, 106), (34, 85), (34, 188), (34, 96),
/*Giani*/ (35, 170), (35, 67), (35, 174), (35, 98), (35, 24), (35, 112), (35, 52),
/*Lupi*/ (36, 221), (36, 68), (36, 192), (36, 201), (36, 76), (36, 64), (36, 79),
/*Pardini*/ (37, 21), (37, 217), (37, 72), (37, 182), (37, 167), (37, 162), (37, 10),
/*Rossi*/ (38, 200), (38, 142), (38, 134), (38, 179), (38, 55), (38, 17), (38, 89),
/*Scaglione*/ (39, 122), (39, 8), (39, 135), (39, 130), (39, 207), (39, 9), (39, 104),
/*Vicari*/ (40, 22), (40, 205), (40, 137), (40, 158), (40, 191), (40, 126), (40, 216),

############## Stagione 2019-2020, serie B
/*Allegrini*/ (41, 133), (41, 183), (41, 6), (41, 119), (41, 63), (41, 88), (41, 3), 
/*Barushi*/ (42, 46), (42, 41), (42, 189), (42, 121), (42, 58), (42, 184), (42, 209), 
/*Canale*/ (43, 107), (43, 36), (43, 100), (43, 171), (43, 120), (43, 25), (43, 12), 
/*Equi*/ (44, 18), (44, 42), (44, 145), (44, 212), (44, 30), (44, 78), (44, 75), 
/*Fiorini*/ (45, 65), (45, 70), (45, 199), (45, 143), (45, 73), (45, 69), (45, 147),
/*Galloni*/ (46, 5), (46, 50), (46, 48), (46, 164), (46, 150), (46, 53), (46, 31),
/*Innocenti*/ (47, 94), (47, 225), (47, 34), (47, 141), (47, 66), (47, 139), (47, 111), 
/*Monari*/ (48, 185), (48, 157), (48, 129), (48, 172), (48, 159), (48, 11), (48, 180), 
/*Usai*/ (49, 44), (49, 136), (49, 101), (49, 149), (49, 1), (49, 16), (49, 138), 
/*Vannini*/ (50, 74), (50, 87), (50, 13), (50, 118), (50, 32), (50, 19), (50, 4),

############### Stagione 2020-2021, serie A (annullata)
############### Stagione 2020-2021, serie A (annullata)

############## Stagione 2021-2022, serie A
/*Aquila*/ (51, 99), (51, 21), (51, 112), (51, 89), (51, 107), (51, 32), (51, 108),
/*Di Pinto*/ (52, 109), (52, 45), (52, 122), (52, 110), (52, 154), (52, 72), (52, 145),
/*Fadda*/ (53, 157), (53, 190), (53, 182), (53, 196), (53, 33), (53, 171), (53, 43),
/*Galloni*/ (54, 5), (54, 22), (54, 125), (54, 77), (54, 15), (54, 197), (54, 144),
/*Gerini*/ (55, 222), (55, 221), (55, 162), (55, 220), (55, 147), (55, 194), (55, 192),
/*Ghelardoni*/ (56, 209), (56, 19), (56, 175), (56, 184), (56, 102), (56, 167), (56, 60),
/*Giani*/ (57, 170), (57, 198), (57, 216), (57, 10), (57, 127), (57, 64), (57, 219),
/*Gullotti*/ (58, 6), (58, 203), (58, 57), (58, 17), (58, 66), (58, 81), (58, 16), (58, 339),
/*Inghirami*/ (59, 68), (59, 217), (59, 54), (59, 105), (59, 7), (59, 59), (59, 153),
/*Rossi*/ (60, 200), (60, 186), (60, 8), (60, 9), (60, 79), (60, 148), (60, 76),

############## Stagione 2021-2022, serie B
/*Barushi*/ (61, 46), (61, 20), (61, 35), (61, 2), (61, 168), (61, 23), (61, 38), 
/*Marchetti*/ (62, 150), (62, 173), (62, 44), (62, 221), (62, 97), (62, 213), (62, 126), 
/*Marranini*/ (63, 149), (63, 133), (63, 160), (63, 143), (63, 67), (63, 141), (63, 92), 
/*Monari*/ (64, 185), (64, 28), (64, 234), (64, 204), (64, 4), (64, 132), (64, 1), 
/*Nacci*/ (65, 101), (65, 27), (65, 176), (65, 161), (65, 91), (65, 74), (65, 152), 
/*Simonetti*/ (66, 139), (66, 208), (66, 233), (66, 47), (66, 3), (66, 87), (66, 51), 
/*Sodano*/ (67, 202), (67, 142), (67, 25), (67, 73), (67, 129), (67, 49), (67, 90), 
/*Tesi*/ (68, 41), (68, 120), (68, 180), (68, 94), (68, 111), (68, 131), (68, 232), 
/*Tognetti*/ (69, 123), (69, 84), (69, 114), (69, 172), (69, 164), (69, 14), (69, 88), 
/*Uperi*/ (70, 48), (70, 140), (70, 31), (70, 151), (70, 210), (70, 100), (70, 235),

############## Stagione 2025
/*Airnivol*/ (71, 194), (71, 276), (71, 9), (71, 217), (71, 17), (71, 105), (71, 211), (71, 301), (71, 167), (71, 261), 
/*Arancini*/ (72, 8), (72, 176), (72, 81), (72, 64), (72, 85), (72, 334), (72, 60), (72, 223), (72, 249), (72, 242), (72, 138), (72, 156), (72, 18),
/*Brazil*/ (73, 10), (73, 2), (73, 4), (73, 280), (73, 287), (73, 31), (73, 77), (73, 171), (73, 16), (73, 288), (73, 59), (73, 102), (73, 180),
/*CISK La Rissa*/ (74, 238), (74, 43), (74, 292), (74, 39), (74, 258), (74, 255), (74, 210), (74, 28), (74, 286), (74, 240),
/*Deportivo La Dama*/ (75, 157), (75, 125), (75, 295), (75, 267), (75, 262), (75, 185), (75, 44), (75, 289), (75, 284), (75, 259),
/*Five to Torres*/ (76, 282), (76, 241), (76, 278), (76, 254), (76, 290), (76, 144), (76, 243), (76, 274), (76, 244), (76, 236), (76, 237),
/*I pupilli del Marra*/ (77, 298), (77, 149), (77, 265), (77, 67), (77, 23), (77, 14), (77, 248), (77, 308), (77, 279), (77, 53),
/*Leo Infissi*/ (78, 110), (78, 30), (78, 271), (78, 285), (78, 186), (78, 52), (78, 205), (78, 247), (78, 127), (78, 148), (78, 151), (78, 296),  
/*Sailpost*/ (79, 182), (79, 272), (79, 270), (79, 15), (79, 260), (79, 257), (79, 252), (79, 281), (79, 294), (79, 293),
/*Svincolati*/ (80, 291), (80, 266), (80, 100), (80, 273), (80, 216), (80, 190), (80, 302), (80, 256), (80, 32), (80, 269),
/*Terroni*/ (81, 245), (81, 268), (81, 277), (81, 334), (81, 335), (81, 184), (81, 300), (81, 264), (81, 250), (81, 283),
/*Wells Fargo*/ (82, 72), (82, 251), (82, 246), (82, 170), (82, 100), (82, 222), (82, 239), (82, 275), (82, 297), (82, 263), (82, 341), (82, 340),

############## Stagione 25/26
/*Arancini*/ (83, 176), (83, 194), (83, 81), (83, 211), (83, 9), (83, 18),
/*Blancatorres*/ (84, 282), (84, 303), (84, 304), (84, 17), (84, 261), (84, 236), (84, 237), (84, 305),
/*Legna*/ (85, 2), (85, 122), (85, 135), (85, 306), (85, 10), (85, 307),
/*Saetta Mc Team*/ (86, 67), (86, 308), (86, 298), (86, 263), (86, 309), (86, 310), (86, 311), (86, 312), (86, 313), (86, 314), (86, 315),
/*Sailpost*/ (87, 182), (87, 270), (87, 257), (87, 85), (87, 252), (87, 112), (87, 335), (87, 15), (87, 253),
/*Sconosciuti*/ (88, 72), (88, 41), (88, 316), (88, 317), (88, 318), (88, 319), (88, 23), (88, 53),
/*Sporting Mistona*/ (89, 320), (89, 321), (89, 322), (89, 323), (89, 324), (89, 325), (89, 326),
/*Svincolati*/ (90, 45), (90, 266), (90, 327), (90, 256), (90, 190), (90, 328), (90, 216), (90, 329), (90, 273),
/*Tattari*/ (91, 222), (91, 246), (91, 157), (91, 249), (91, 48), (91, 125), (91, 185), (91, 234), (91, 170), (91, 110),
/*Terroni*/ (92, 245), (92, 268), (92, 277), (92, 330), (92, 331), (92, 332), (92, 333), (92, 334);

INSERT INTO matches (league, `group`, round, date, time, team_home, team_away, goals_home, goals_away, winner, penalties) VALUES
############## 01: 2016/2017 
############## (Girone Unico)
-- GIORNATA 1 -------------------------------------------------------------------
(1, 'Unico', 1, '2016-10-23', '18:00', 4, 1, 6, 7, 1, 0),    -- Equi vs Canale
(1, 'Unico', 1, '2016-10-23', '19:00', 2, 6, 3, 4, 6, 0),    -- Ciardelli vs Pardini
(1, 'Unico', 1, '2016-10-23', '20:00', 3, 5, 9, 12, 5, 0),   -- Citi vs Macchi
-- GIORNATA 2 -------------------------------------------------------------------
(1, 'Unico', 2, '2016-10-30', '18:00', 2, 3, 7, 4, 2, 0),    -- Ciardelli vs Citi
(1, 'Unico', 2, '2016-10-30', '19:00', 6, 1, 4, 5, 1, 0),    -- Pardini vs Canale
(1, 'Unico', 2, '2016-10-30', '20:00', 5, 4, 5, 8, 4, 0),    -- Macchi vs Equi
-- GIORNATA 3 -------------------------------------------------------------------
(1, 'Unico', 3, '2016-11-06', '18:00', 6, 4, 3, 6, 4, 0),    -- Pardini vs Equi
(1, 'Unico', 3, '2016-11-06', '19:00', 1, 3, 25, 7, 1, 0),   -- Canale vs Citi
(1, 'Unico', 3, '2016-11-06', '20:00', 2, 5, 12, 1, 2, 0),   -- Ciardelli vs Macchi
-- GIORNATA 4 -------------------------------------------------------------------
(1, 'Unico', 4, '2016-11-13', '18:00', 2, 4, 6, 16, 4, 0),   -- Ciardelli vs Equi
(1, 'Unico', 4, '2016-11-13', '19:00', 5, 1, 10, 1, 5, 0),   -- Macchi vs Canale
(1, 'Unico', 4, '2016-11-13', '20:00', 6, 3, 12, 6, 6, 0),   -- Pardini vs Citi
-- GIORNATA 5 -------------------------------------------------------------------
(1, 'Unico', 5, '2016-11-20', '18:00', 6, 5, 6, 2, 6, 0),    -- Pardini vs Macchi
(1, 'Unico', 5, '2016-11-20', '19:00', 1, 2, 9, 6, 1, 0),    -- Canale vs Ciardelli
(1, 'Unico', 5,'2016-11-20', '20:00', 3, 4, 6, 12, 4, 0),   -- Citi vs Equi
-- GIORNATA 6 -------------------------------------------------------------------
(1, 'Unico', 6, '2016-11-27', '18:00', 4, 1, 5, 3, 4, 0),    -- Equi vs Canale
(1, 'Unico', 6, '2016-11-27', '19:00', 2, 6, 3, 11, 6, 0),   -- Ciardelli vs Pardini
(1, 'Unico', 6, '2016-11-27', '20:00', 3, 5, 2, 3, 5, 0),    -- Citi vs Macchi
-- GIORNATA 7 -------------------------------------------------------------------
(1, 'Unico', 7, '2016-12-04', '18:00', 2, 3, 9, 6, 2, 0),    -- Ciardelli vs Citi
(1, 'Unico', 7, '2016-12-04', '19:00', 6, 1, 6, 5, 6, 0),    -- Pardini vs Canale
(1, 'Unico', 7, '2016-12-04', '20:00', 5, 4, 4, 4, 0, 0),    -- Macchi vs Equi
-- GIORNATA 8 -------------------------------------------------------------------
(1, 'Unico', 8, '2016-12-11', '18:00', 6, 4, 7, 7, 0, 0),    -- Pardini vs Equi
(1, 'Unico', 8, '2016-12-11', '19:00', 1, 3, 17, 9, 1, 0),   -- Canale vs Citi
(1, 'Unico', 8, '2016-12-11', '20:00', 2, 5, 5, 7, 5, 0),    -- Ciardelli vs Macchi
-- GIORNATA 9 -------------------------------------------------------------------
(1, 'Unico', 9, '2016-12-18', '18:00', 2, 4, 4, 15, 4, 0),   -- Ciardelli vs Equi
(1, 'Unico', 9, '2016-12-18', '19:00', 5, 1, 5, 8, 1, 0),    -- Macchi vs Canale
(1, 'Unico', 9, '2016-12-18', '20:00', 6, 3, 5, 6, 3, 0),    -- Pardini vs Citi
-- GIORNATA 10 ------------------------------------------------------------------
(1, 'Unico', 10, '2016-12-25', '18:00', 6, 5, 10, 6, 6, 0),  -- Pardini vs Macchi
(1, 'Unico', 10, '2016-12-25', '19:00', 1, 2, 16, 6, 1, 0),  -- Canale vs Ciardelli
(1, 'Unico', 10, '2016-12-25', '20:00', 3, 4, 6, 6, 0, 0),   -- Citi vs Equi

############## 02: 2017/2018 (matches and performance data went lost)

############## 03: 2018/2019 

############## (Girone A)
-- GIORNATA 1 -------------------------------------------------------------------
(3, 'A', 1, '2018-09-01', '18:00', 26, 18, 4, 3, 26, 0),    -- Pardini vs Botrugno
(3, 'A', 1, '2018-09-01', '19:00', 27, 28, 8, 8, NULL, 0),  -- Tripiccione vs Turi
(3, 'A', 1, '2018-09-01', '20:00', 17, 30, 1, 2, 30, 0),    -- Balestri vs Vouk
-- GIORNATA 2 -------------------------------------------------------------------
(3, 'A', 2, '2018-09-08', '18:00', 28, 30, 4, 2, 28, 0),    -- Turi vs Vouk
(3, 'A', 2, '2018-09-08', '19:00', 23, 17, 11, 6, 23, 0),   -- Garcea vs Balestri
(3, 'A', 2, '2018-09-08', '20:00', 18, 27, 6, 4, 18, 0),    -- Botrugno vs Tripiccione
-- GIORNATA 3 -------------------------------------------------------------------
(3, 'A', 3, '2018-09-15', '18:00', 28, 26, 2, 4, 26, 0),    -- Turi vs Pardini
(3, 'A', 3, '2018-09-15', '19:00', 23, 27, 15, 6, 23, 0),   -- Garcea vs Tripiccione
(3, 'A', 3, '2018-09-15', '20:00', 17, 18, 4, 5, 18, 0),    -- Balestri vs Botrugno
-- GIORNATA 4 -------------------------------------------------------------------
(3, 'A', 4, '2018-09-22', '18:00', 26, 30, 0, 0, NULL, 0),  -- Pardini vs Vouk
(3, 'A', 4, '2018-09-22', '19:00', 23, 18, 7, 13, 18, 0),   -- Garcea vs Botrugno
(3, 'A', 4, '2018-09-22', '20:00', 17, 27, 7, 5, 17, 0),    -- Balestri vs Tripiccione
-- GIORNATA 5 -------------------------------------------------------------------
(3, 'A', 5, '2018-09-29', '18:00', 26, 27, 9, 2, 26, 0),    -- Pardini vs Tripiccione
(3, 'A', 5, '2018-09-29', '19:00', 28, 18, null, null, null, 0), -- Turi vs Botrugno
(3, 'A', 5, '2018-09-29', '20:00', 23, 30, 8, 2, 23, 0),    -- Garcea vs Vouk
-- GIORNATA 6 -------------------------------------------------------------------
(3, 'A', 6, '2018-10-06', '18:00', 26, 17, 5, 2, 26, 0),    -- Pardini vs Balestri
(3, 'A', 6, '2018-10-06', '19:00', 28, 23, 5, 5, NULL, 0),  -- Turi vs Garcea
(3, 'A', 6, '2018-10-06', '20:00', 18, 30, 5, 2, 18, 0),    -- Botrugno vs Vouk
-- GIORNATA 7 -------------------------------------------------------------------
(3, 'A', 7, '2018-10-13', '18:00', 26, 23, 3, 4, 23, 0),    -- Pardini vs Garcea
(3, 'A', 7, '2018-10-13', '19:00', 17, 28, 2, 3, 28, 0),    -- Balestri vs Turi
(3, 'A', 7, '2018-10-13', '20:00', 27, 30, 4, 13, 30, 0),   -- Tripiccione vs Vouk

############## (Girone B)
-- GIORNATA 1 -------------------------------------------------------------------
(3, 'B', 1, '2018-09-01', '18:00', 19, 21, 3, 8, 21, 0),   -- Canale vs Equi
(3, 'B', 1, '2018-09-01', '19:00', 25, 22, 1, 4, 22, 0),   -- Macchi vs Franco
(3, 'B', 1, '2018-09-01', '20:00', 20, 24, 2, 7, 24, 0),   -- Cecchi vs Giani
-- GIORNATA 2 -------------------------------------------------------------------
(3, 'B', 2, '2018-09-08', '18:00', 29, 19, 5, 6, 19, 0),   -- Usai vs Canale
(3, 'B', 2, '2018-09-08', '19:00', 21, 22, 4, 4, NULL, 0), -- Equi vs Franco
(3, 'B', 2, '2018-09-08', '20:00', 25, 20, 2, 7, 20, 0),   -- Macchi vs Cecchi
-- GIORNATA 3 -------------------------------------------------------------------
(3, 'B', 3, '2018-09-15', '18:00', 24, 25, 6, 2, 24, 0),   -- Giani vs Macchi
(3, 'B', 3, '2018-09-15', '19:00', 19, 20, 6, 6, NULL, 0), -- Canale vs Cecchi
(3, 'B', 3, '2018-09-15', '20:00', 29, 21, 3, 8, 21, 0),   -- Usai vs Equi
-- GIORNATA 4 -------------------------------------------------------------------
(3, 'B', 4, '2018-09-22', '18:00', 22, 20, 4, 6, 20, 0),   -- Franco vs Cecchi
(3, 'B', 4, '2018-09-22', '19:00', 21, 24, 8, 4, 21, 0),   -- Equi vs Giani
(3, 'B', 4, '2018-09-22', '20:00', 25, 29, 5, 6, 29, 0),   -- Macchi vs Usai
-- GIORNATA 5 -------------------------------------------------------------------
(3, 'B', 5, '2018-09-29', '18:00', 20, 21, 7, 5, 20, 0),   -- Cecchi vs Equi
(3, 'B', 5, '2018-09-29', '19:00', 24, 29, 7, 4, 24, 0),   -- Giani vs Usai
(3, 'B', 5, '2018-09-29', '20:00', 22, 19, 7, 2, 22, 0),   -- Franco vs Canale
-- GIORNATA 6 -------------------------------------------------------------------
(3, 'B', 6, '2018-10-06', '18:00', 19, 24, 11, 6, 19, 0),  -- Canale vs Giani
(3, 'B', 6, '2018-10-06', '19:00', 25, 21, 5, 8, 21, 0),   -- Macchi vs Equi
(3, 'B', 6, '2018-10-06', '20:00', 22, 29, 2, 2, NULL, 0), -- Franco vs Usai
-- GIORNATA 7 -------------------------------------------------------------------
(3, 'B', 7, '2018-10-13', '18:00', 25, 19, 5, 3, 25, 0),   -- Macchi vs Canale
(3, 'B', 7, '2018-10-13', '19:00', 24, 22, 8, 10, 22, 0),  -- Giani vs Franco
(3, 'B', 7, '2018-10-13', '20:00', 29, 20, 3, 7, 20, 0),   -- Usai vs Cecchi

############## 04: 2019/2020, serie A
 -- DATI NON COMPLETI; DA RICOSTRUIRE
############## 05: 2019/2020, serie B
 -- DATI NON COMPLETI; DA RICOSTRUIRE

############## 06: 2021/2022, serie A
############## 06: 2021/2022 (Girone A1)
-- GIORNATA 1 -------------------------------------------------------------------
(6, 'A1', 1, '2021-09-01', '18:00', 59, 52, 6, 4, 59, 0),   -- Inghirami vs Di Pinto
(6, 'A1', 1, '2021-09-01', '19:00', 53, 57, 7, 7, NULL, 0), -- Fadda vs Giani
-- GIORNATA 2 -------------------------------------------------------------------
(6, 'A1', 2, '2021-09-08', '18:00', 59, 53, 10, 4, 59, 0),  -- Inghirami vs Fadda
(6, 'A1', 2, '2021-09-08', '19:00', 57, 54, 6, 5, 57, 0),   -- Giani vs Galloni
-- GIORNATA 3 -------------------------------------------------------------------
(6, 'A1', 3, '2021-09-15', '18:00', 59, 57, 4, 2, 59, 0),   -- Inghirami vs Giani
(6, 'A1', 3, '2021-09-15', '19:00', 52, 54, 1, 4, 54, 0),   -- Di Pinto vs Galloni
-- GIORNATA 4 -------------------------------------------------------------------
(6, 'A1', 4, '2021-09-22', '18:00', 59, 54, 9, 5, 59, 0),   -- Inghirami vs Galloni
(6, 'A1', 4, '2021-09-22', '19:00', 53, 52, 6, 2, 53, 0),   -- Fadda vs Di Pinto
-- GIORNATA 5 -------------------------------------------------------------------
(6, 'A1', 5, '2021-09-29', '18:00', 52, 57, 3, 3, NULL, 0), -- Di Pinto vs Giani
(6, 'A1', 5, '2021-09-29', '19:00', 53, 54, 5, 5, NULL, 0), -- Fadda vs Galloni
-- GIORNATA 6 -------------------------------------------------------------------
(6, 'A1', 6, '2021-10-06', '18:00', 59, 52, 6, 7, 52, 0),   -- Inghirami vs Di Pinto
(6, 'A1', 6, '2021-10-06', '19:00', 53, 57, 5, 7, 57, 0),   -- Fadda vs Giani
-- GIORNATA 7 -------------------------------------------------------------------
(6, 'A1', 7, '2021-10-13', '18:00', 59, 53, 1, 3, 53, 0),   -- Inghirami vs Fadda
(6, 'A1', 7, '2021-10-13', '19:00', 57, 54, 0, 6, 54, 0),   -- Giani vs Galloni
-- GIORNATA 8 -------------------------------------------------------------------
(6, 'A1', 8, '2021-10-20', '18:00', 59, 57, 7, 3, 59, 0),   -- Inghirami vs Giani
(6, 'A1', 8, '2021-10-20', '19:00', 52, 54, 2, 8, 54, 0),   -- Di Pinto vs Galloni
-- GIORNATA 9 -------------------------------------------------------------------
(6, 'A1', 9, '2021-10-27', '18:00', 59, 54, 6, 4, 59, 0),   -- Inghirami vs Galloni
(6, 'A1', 9, '2021-10-27', '19:00', 53, 52, 11, 4, 53, 0),  -- Fadda vs Di Pinto
-- GIORNATA 10 -------------------------------------------------------------------
(6, 'A1', 10, '2021-11-03', '18:00', 52, 57, 10, 11, 57, 0),-- Di Pinto vs Giani
(6, 'A1', 10, '2021-11-03', '19:00', 53, 54, 7, 6, 53, 0),  -- Fadda vs Galloni

############## 06: 2021/2022 (Girone A2)
-- GIORNATA 1 -------------------------------------------------------------------
(6, 'A2', 1, '2021-09-01', '18:00', 58, 51, 3, 2, 58, 0),   -- Gullotti vs Aquila
(6, 'A2', 1, '2021-09-01', '19:00', 60, 56, 3, 6, 56, 0),   -- Rossi vs Ghelardoni
-- GIORNATA 2 -------------------------------------------------------------------
(6, 'A2', 2, '2021-09-08', '18:00', 58, 60, 7, 5, 58, 0),   -- Gullotti vs Rossi
(6, 'A2', 2, '2021-09-08', '19:00', 56, 55, 3, 3, NULL, 0), -- Ghelardoni vs Gerini
-- GIORNATA 3 -------------------------------------------------------------------
(6, 'A2', 3, '2021-09-15', '18:00', 58, 56, 5, 9, 56, 0),   -- Gullotti vs Ghelardoni
(6, 'A2', 3, '2021-09-15', '19:00', 51, 55, 4, 3, 51, 0),   -- Aquila vs Gerini
-- GIORNATA 4 -------------------------------------------------------------------
(6, 'A2', 4, '2021-09-22', '18:00', 58, 55, 3, 4, 55, 0),   -- Gullotti vs Gerini
(6, 'A2', 4, '2021-09-22', '19:00', 60, 51, 5, 6, 51, 0),   -- Rossi vs Aquila
-- GIORNATA 5 -------------------------------------------------------------------
(6, 'A2', 5, '2021-09-29', '18:00', 51, 56, 6, 6, NULL, 0), -- Aquila vs Ghelardoni
(6, 'A2', 5, '2021-09-29', '19:00', 60, 55, 5, 0, 60, 0),   -- Rossi vs Gerini
-- GIORNATA 6 -------------------------------------------------------------------
(6, 'A2', 6, '2021-10-06', '18:00', 58, 51, 4, 7, 51, 0),   -- Gullotti vs Aquila
(6, 'A2', 6, '2021-10-06', '19:00', 60, 56, 6, 2, 60, 0),   -- Rossi vs Ghelardoni
-- GIORNATA 7 -------------------------------------------------------------------
(6, 'A2', 7, '2021-10-13', '18:00', 58, 60, 4, 6, 60, 0),   -- Gullotti vs Rossi
(6, 'A2', 7, '2021-10-13', '19:00', 56, 55, 6, 0, 56, 0),   -- Ghelardoni vs Gerini
-- GIORNATA 8 -------------------------------------------------------------------
(6, 'A2', 8, '2021-10-20', '18:00', 58, 56, 2, 2, NULL, 0), -- Gullotti vs Ghelardoni
(6, 'A2', 8, '2021-10-20', '19:00', 51, 55, 3, 4, 55, 0),   -- Aquila vs Gerini
-- GIORNATA 9 -------------------------------------------------------------------
(6, 'A2', 9, '2021-10-27', '18:00', 58, 55, 0, 0, NULL, 0), -- Gullotti vs Gerini
(6, 'A2', 9, '2021-10-27', '19:00', 60, 51, 0, 6, 51, 0),   -- Rossi vs Aquila
-- GIORNATA 10 -------------------------------------------------------------------
(6, 'A2', 10, '2021-11-03', '18:00', 51, 56, 0, 0, NULL, 0), -- Aquila vs Ghelardoni
(6, 'A2', 10, '2021-11-03', '19:00', 60, 55, 6, 0, 60, 0),   -- Rossi vs Gerini
############## 07: 2021/2022, serie B

############## 07: 2021/2022 (Girone B1)
-- GIORNATA 1 -------------------------------------------------------------------
(7, 'B1', 1, '2021-10-03', '18:00', 67, 66, 6, 2, 67, 0),   -- Sodano vs Simonetti
(7, 'B1', 1, '2021-10-03', '19:00', 64, 70, 5, 4, 64, 0),   -- Monari vs Uperi
-- GIORNATA 2 -------------------------------------------------------------------
(7, 'B1', 2, '2021-10-10', '18:00', 67, 64, 8, 3, 67, 0),   -- Sodano vs Monari
(7, 'B1', 2, '2021-10-10', '19:00', 70, 68, 7, 1, 70, 0),   -- Uperi vs Tesi
-- GIORNATA 3 -------------------------------------------------------------------
(7, 'B1', 3, '2021-10-17', '18:00', 67, 70, 4, 2, 67, 0),   -- Sodano vs Uperi
(7, 'B1', 3, '2021-10-17', '19:00', 66, 68, 5, 3, 66, 0),   -- Simonetti vs Tesi
-- GIORNATA 4 -------------------------------------------------------------------
(7, 'B1', 4, '2021-10-24', '18:00', 67, 68, 7, 1, 67, 0),   -- Sodano vs Tesi
(7, 'B1', 4, '2021-10-24', '19:00', 64, 66, 3, 2, 64, 0),   -- Monari vs Simonetti
-- GIORNATA 5 -------------------------------------------------------------------
(7, 'B1', 5, '2021-10-31', '18:00', 66, 70, 1, 7, 70, 0),   -- Simonetti vs Uperi
(7, 'B1', 5, '2021-10-31', '19:00', 64, 68, 2, 2, NULL, 0), -- Monari vs Tesi
-- GIORNATA 6 -------------------------------------------------------------------
(7, 'B1', 6, '2021-11-07', '18:00', 67, 66, 6, 5, 67, 0),   -- Sodano vs Simonetti
(7, 'B1', 6, '2021-11-07', '19:00', 64, 70, 3, 5, 70, 0),   -- Monari vs Uperi
-- GIORNATA 7 -------------------------------------------------------------------
(7, 'B1', 7, '2021-11-14', '18:00', 67, 64, 8, 2, 67, 0),   -- Sodano vs Monari
(7, 'B1', 7, '2021-11-14', '19:00', 70, 68, 3, 0, 70, 0),   -- Uperi vs Tesi
-- GIORNATA 8 -------------------------------------------------------------------
(7, 'B1', 8, '2021-11-21', '18:00', 67, 70, 4, 7, 70, 0),   -- Sodano vs Uperi
(7, 'B1', 8, '2021-11-21', '19:00', 66, 68, 5, 4, 66, 0),   -- Simonetti vs Tesi
-- GIORNATA 9 -------------------------------------------------------------------
(7, 'B1', 9, '2021-11-28', '18:00', 67, 68, 8, 1, 67, 0),   -- Sodano vs Tesi
(7, 'B1', 9, '2021-11-28', '19:00', 64, 66, 4, 4, NULL, 0), -- Monari vs Simonetti
-- GIORNATA 10 -------------------------------------------------------------------
(7, 'B1', 10, '2021-12-05', '18:00', 66, 70, 5, 8, 70, 0),  -- Simonetti vs Uperi
(7, 'B1', 10, '2021-12-05', '19:00', 64, 68, 6, 0, 64, 0),  -- Monari vs Tesi

############## 07: 2021/2022 (Girone B2)
-- GIORNATA 1 -------------------------------------------------------------------
(7, 'B2', 1, '2021-10-03', '18:00', 61, 65, 4, 5, 65, 0),   -- Barushi vs Nacci
(7, 'B2', 1, '2021-10-03', '19:00', 63, 69, 9, 4, 63, 0),   -- Marranini vs Tognetti
-- GIORNATA 2 -------------------------------------------------------------------
(7, 'B2', 2, '2021-10-10', '18:00', 61, 63, 6, 6, NULL, 0), -- Barushi vs Marranini
(7, 'B2', 2, '2021-10-10', '19:00', 69, 62, 11, 4, 69, 0),  -- Tognetti vs Marchetti
-- GIORNATA 3 -------------------------------------------------------------------
(7, 'B2', 3, '2021-10-17', '18:00', 61, 69, 6, 8, 69, 0),   -- Barushi vs Tognetti
(7, 'B2', 3, '2021-10-17', '19:00', 65, 62, 8, 12, 62, 0),  -- Nacci vs Marchetti
-- GIORNATA 4 -------------------------------------------------------------------
(7, 'B2', 4, '2021-10-24', '18:00', 61, 62, 7, 7, NULL, 0), -- Barushi vs Marchetti
(7, 'B2', 4, '2021-10-24', '19:00', 63, 65, 3, 6, 65, 0),   -- Marranini vs Nacci
-- GIORNATA 5 -------------------------------------------------------------------
(7, 'B2', 5, '2021-10-31', '18:00', 65, 69, 8, 10, 69, 0),  -- Nacci vs Tognetti
(7, 'B2', 5, '2021-10-31', '19:00', 63, 62, 15, 10, 63, 0), -- Marranini vs Marchetti
-- GIORNATA 6 -------------------------------------------------------------------
(7, 'B2', 6, '2021-11-07', '18:00', 61, 65, 4, 6, 65, 0),   -- Barushi vs Nacci
(7, 'B2', 6, '2021-11-07', '19:00', 63, 69, 3, 4, 69, 0),   -- Marranini vs Tognetti
-- GIORNATA 7 -------------------------------------------------------------------
(7, 'B2', 7, '2021-11-14', '18:00', 61, 63, 1, 7, 63, 0),   -- Barushi vs Marranini
(7, 'B2', 7, '2021-11-14', '19:00', 69, 62, 4, 7, 62, 0),   -- Tognetti vs Marchetti
-- GIORNATA 8 -------------------------------------------------------------------
(7, 'B2', 8, '2021-11-21', '18:00', 61, 69, 10, 9, 61, 0),  -- Barushi vs Tognetti
(7, 'B2', 8, '2021-11-21', '19:00', 65, 62, 8, 4, 65, 0),   -- Nacci vs Marchetti
-- GIORNATA 9 -------------------------------------------------------------------
(7, 'B2', 9, '2021-11-28', '18:00', 61, 62, 9, 4, 61, 0),   -- Barushi vs Marchetti
(7, 'B2', 9, '2021-11-28', '19:00', 63, 65, 9, 3, 63, 0),   -- Marranini vs Nacci
-- GIORNATA 10 -------------------------------------------------------------------
(7, 'B2', 10, '2021-12-05', '18:00', 65, 69, 11, 5, 65, 0), -- Nacci vs Tognetti
(7, 'B2', 10, '2021-12-05', '19:00', 63, 62, 6, 1, 63, 0),  -- Marranini vs Marchetti


############## 08: 2025
############## 08: 2025/2026 (Girone B – Unico)
-- GIORNATA 1 -------------------------------------------------------------------
(8, 'Unico', 1, '2025-02-09', '18:00', 79, 78, 1, 1, 79, 1),    -- Sailpost vs Leo Infissi
(8, 'Unico', 1, '2025-02-09', '19:00', 75, 82, 1, 13, 82, 0),     -- Deportivo La Dama vs Wells Fargo
(8, 'Unico', 1, '2025-02-09', '20:00', 76, 80, 3, 3, 80, 1),    -- Five to Torres vs Gli Svincolati
(8, 'Unico', 1, '2025-02-16', '18:00', 73, 72, 2, 6, 72, 0),      -- Brazil vs Arancini
(8, 'Unico', 1, '2025-02-16', '19:00', 77, 71, 3, 4, 71, 0),      -- I pupilli del Marra vs Airnivol
(8, 'Unico', 1, '2025-02-16', '20:00', 81, 74, 1, 16, 74, 0),     -- Terroni FC vs CISK La Rissa
-- GIORNATA 2 -------------------------------------------------------------------
(8, 'Unico', 2, '2025-02-23', '18:00', 82, 76, 3, 3, 76, 1),    -- Wells Fargo vs Five to Torres
(8, 'Unico', 2, '2025-02-23', '19:00', 78, 75, 14, 2, 78, 0),     -- Leo Infissi vs Deportivo La Dama
(8, 'Unico', 2, '2025-02-23', '20:00', 80, 79, 5, 3, 80, 0),      -- Gli Svincolati vs Sailpost
(8, 'Unico', 2, '2025-03-02', '18:00', 72, 77, 6, 4, 72, 0),      -- Arancini vs I pupilli del Marra
(8, 'Unico', 2, '2025-03-02', '19:00', 71, 81, 19, 2, 71, 0),     -- Airnivol vs Terroni FC
(8, 'Unico', 2, '2025-03-02', '20:00', 74, 73, 6, 0, 74, 0),      -- CISK La Rissa vs Brazil
-- GIORNATA 3 -------------------------------------------------------------------
(8, 'Unico', 3, '2025-03-09', '18:00', 75, 80, 3, 14, 80, 0),     -- Deportivo La Dama vs Gli Svincolati
(8, 'Unico', 3, '2025-03-09', '19:00', 78, 82, 3, 3, 78, 1),    -- Leo Infissi vs Wells Fargo
(8, 'Unico', 3, '2025-03-09', '20:00', 79, 76, 3, 2, 79, 0),      -- Sailpost vs Five to Torres
(8, 'Unico', 3, '2025-03-16', '18:00', 76, 78, 6, 2, 76, 0),      -- Five to Torres vs Leo Infissi
(8, 'Unico', 3, '2025-03-16', '19:00', 80, 82, 3, 2, 80, 0),      -- Gli Svincolati vs Wells Fargo
(8, 'Unico', 3, '2025-03-16', '20:00', 75, 79, 0, 6, 79, 0),      -- Deportivo La Dama vs Sailpost
-- GIORNATA 4 -------------------------------------------------------------------
(8, 'Unico', 4, '2025-03-23', '18:00', 73, 77, 1, 10, 77, 0),    -- Brazil vs I pupilli del Marra
(8, 'Unico', 4, '2025-03-23', '19:00', 74, 71, 6, 6, 71, 1),    -- CISK La Rissa vs Airnivol
(8, 'Unico', 4, '2025-03-23', '20:00', 72, 81, 6, 1, 72, 0),      -- Arancini vs Terroni FC
(8, 'Unico', 4, '2025-03-30', '18:00', 77, 74, 7, 7, 74, 1),    -- I pupilli del Marra vs CISK La Rissa
(8, 'Unico', 4, '2025-03-30', '19:00', 71, 72, 5, 5, 72, 1),    -- Airnivol vs Arancini
(8, 'Unico', 4, '2025-03-30', '20:00', 73, 81, 8, 4, 73, 0),      -- Brazil vs Terroni FC
-- GIORNATA 5 -------------------------------------------------------------------
(8, 'Unico', 5, '2025-04-06', '18:00', 80, 78, 6, 3, 80, 0),      -- Gli Svincolati vs Leo Infissi
(8, 'Unico', 5, '2025-04-06', '19:00', 76, 75, 14, 0, 76, 0),     -- Five to Torres vs Deportivo La Dama
(8, 'Unico', 5, '2025-04-06', '20:00', 82, 79, 1, 3, 79, 0),      -- Wells Fargo vs Sailpost
(8, 'Unico', 5, '2025-04-13', '18:00', 73, 71, 0, 6, 71, 0),      -- Brazil vs Airnivol
(8, 'Unico', 5, '2025-04-13', '19:00', 72, 74, 6, 0, 72, 0),      -- Arancini vs CISK La Rissa
(8, 'Unico', 5, '2025-04-13', '20:00', 81, 77, 2, 17, 77, 0),     -- Terroni FC vs I pupilli del Marra

############## 09: 2025/2026
-- GIORNATA 1 -------------------------------------------------------------------
(9, 'Unico', 1, '2025-11-23', '18:00', 89, 84, 1, 0, 9, 0),   	-- Tattari vs Saetta MC Team
(9, 'Unico', 1, '2025-11-23', '19:00', 82, 86, 6, 4, 2, 0),   	-- Blancatorres vs Sconosciuti
(9, 'Unico', 1, '2025-11-23', '20:00', 10, 8, 0, 6, 8, 0),   	-- Terroni vs Svincolati
(9, 'Unico', 1, '2025-11-30', '18:00', 87, 83, 0, 0, 0, null),   -- Sporting Mistona vs Legna
(9, 'Unico', 1, '2025-11-30', '19:00', 81, 85, 0, 0, 0, null);   -- Arancini vs Sailpost


INSERT INTO performance (mid, pid, goal, grade) VALUES
############## 01: 2016/2017
# Squadra CANALE
(1, 107, 1, 7), (5, 107, 1, 7), (8, 107, 2, 7), (11, 107, 1, 7), (14, 107, 1, 6.5), (16, 107, 1, 7.5), (20, 107, 0, 8), (23, 107, 1, 7), (26, 107, 2, 7.5), (29, 107, 0, null),
(1, 71, 4, 8), (5, 71, 2, 8.5), (8, 71, 9, 9.5), (11, 71, 0, null), (14, 71, 4, 8), (16, 71, 1, 9), (20, 71, 10, 8.5), (23, 71, 3, 9), (26, 71, 6, 9), (29, 71, 2, 7.5),
(1, 180, 2, 6.5), (5, 180, 0, 7), (8, 180, 2, 4.5), (11, 180, 0, null), (14, 180, 1, 6.5), (16, 180, 0, 6), (20, 180, 2, 6.5), (23, 180, 1, 6.5), (26, 180, 1, 8), (29, 180, 0, 5.5),
(1, 222, 0, null), (5, 222, 1, 8.5), (8, 222, 7, 9), (11, 222, 0, null), (14, 222, 1, 7.5), (16, 222, 1, 7.5), (20, 222, 2, 7), (23, 222, 2, 8.5), (26, 222, 4, 8.5), (29, 222, 2, 7),
(1, 34, 0, 5), (5, 34, 0, 6), (8, 34, 1, 7), (11, 34, 0, 6), (14, 34, 0, 6.5), (16, 34, 0, 6), (20, 34, 1, 7), (23, 34, 0, 7.5), (26, 34, 0, 8), (29, 34, 0, 6.5),
(1, 101, 0, 6), (5, 101, 0, 7.5), (8, 101, 1, 8), (11, 101, 0, 7), (14, 101, 0, 7), (16, 101, 0, 7), (20, 101, 0, 6.5), (23, 101, 0, 6.5), (26, 101, 0, 7), (29, 101, 0, null),
(1, 150, 1, 6.5), (5, 150, 0, 7), (8, 150, 2, 4.5), (11, 150, 2, 5.5), (14, 150, 2, 6), (16, 150, 0, 5), (20, 150, 2, 6.5), (23, 150, 0, null), (26, 150, 1, 6.5), (29, 150, 1, 5.5),
(1, 22, 0, 8.5), (5, 22, 0, 9), (8, 22, 1, 7), (11, 22, 0, 6), (14, 22, 0, 8), (16, 22, 0, 8), (20, 22, 0, null), (23, 22, 0, 7.5), (26, 22, 0, 6.5), (29, 22, 0, null),

-- Squadra CIARDELLLI
(2, 142, 0, 7.5), (4, 142, 0, 7.0), (9, 142, 0, 8.5), (10, 142, 0, 6.5), (14, 142, 0, 7.5), (17, 142, 0, 5.5), (19, 142, 0, 8.5), (24, 142, 0, 7.5), (25, 142, 0, 6.0), (29, 142, 0, null),
(2, 115, 2, 8.0), (4, 115, 1, 7.5), (9, 115, 0, 8.0), (10, 115, 0, 7.5), (14, 115, 0, 6.0), (17, 115, 0, null), (19, 115, 1, 8.0), (24, 115, 1, 8.5), (25, 115, 4, 8.5),
(2, 181, 0, 8.5), (4, 181, 5, 8.0), (9, 181, 7, 9.5), (10, 181, 0, 7.0), (14, 181, 3, 8.0), (17, 181, 2, 7.0), (19, 181, 5, 8.5), (24, 181, 2, 8.0), (25, 181, 0, null),
(2, 178, 0, 6.0), (4, 178, 0, 7.0), (9, 178, 1, 8.5), (10, 178, 2, 6.0), (14, 178, 0, 6.5), (17, 178, 0, 5.5), (19, 178, 1, 7.5), (24, 178, 1, 7.5), (25, 178, 0, null),
(2, 74, 0, 7.0), (4, 74, 0, 6.5), (9, 74, 0, 6.5), (10, 74, 1, 7.0), (14, 74, 0, null), (17, 74, 0, 7.5), (19, 74, 0, 6.5), (24, 74, 0, null), (25, 74, 0, 6.0),
(2, 89, 0, null), (4, 89, 0, null), (9, 89, 0, null), (10, 89, 0, null), (14, 89, 0, null), (17, 89, 1, 6.5), (19, 89, 1, 8.0), (24, 89, 1, 7.0), (25, 89, 0, 7.5),
(2, 29, 0, null), (4, 29, 0, 6.0), (9, 29, 0, null), (10, 29, 0, 6.0), (14, 29, 2, 7.0), (17, 29, 0, null), (19, 29, 0, 5.5), (24, 29, 0, 6.0), (25, 29, 0, 6.0),

-- Squadra CITI
(3, 228, 1, 7), (4, 228, 1, 8), (8, 228, 0, null), (12, 228, 1, 6.5), (15, 228, 0, 8), (18, 228, 0, 7), (19, 228, 0, 7.5), (23, 228, 1, 6), (27, 228, 1, 7.5), (30, 228, 0, 7),
(3, 62, 2, 6.5), (4, 62, 1, 7), (8, 62, 4, 7), (12, 62, 0, 5), (15, 62, 3, 7), (18, 62, 0, 5), (19, 62, 3, 7.5), (23, 62, 2, 5.5), (27, 62, 3, 7), (30, 62, 2, 7),
(3, 79, 0, null), (4, 79, 0, null), (8, 79, 0, null), (12, 79, 0, null), (15, 79, 0, null), (18, 79, 2, 8), (19, 79, 3, 8), (23, 79, 2, 6), (27, 79, 0, null), (30, 79, 0, null),
(3, 169, 3, 8), (4, 169, 2, 8.5), (8, 169, 2, 6.5), (12, 169, 3, 7), (15, 169, 0, null), (18, 169, 0, null), (19, 169, 0, 7.5), (23, 169, 3, 7), (27, 169, 2, 8), (30, 169, 4, 8.5),
(3, 133, 0, 5.5), (4, 133, 0, 7), (8, 133, 0, 4.5), (12, 133, 0, 5), (15, 133, 0, null), (18, 133, 0, 6.5), (19, 133, 0, 6.5), (23, 133, 0, 4), (27, 133, 0, 6.5), (30, 133, 0, 6.5),
(3, 87, 0, 5.5), (4, 87, 0, 6), (8, 87, 0, null), (12, 87, 0, 5.5), (15, 87, 0, 6.5), (18, 87, 0, null), (19, 87, 0, 7.5), (23, 87, 0, 5), (27, 87, 0, 6.5), (30, 87, 0, 7),
(3, 122, 0, null), (4, 122, 0, null), (8, 122, 1, 5), (12, 122, 0, null), (15, 122, 2, 6.5), (18, 122, 0, 7), (19, 122, 0, 7.5), (23, 122, 1, 6), (27, 122, 0, 7.5), (30, 122, 0, null),
(3, 338, 2, 6.5), (4, 338, 0, 6.5), (8, 338, 0, null), (12, 338, 1, 6), (15, 338, 0, null), (18, 338, 0, null), (19, 338, 0, null), (23, 338, 0, null), (27, 338, 0, null), (30, 338, 0, null),
(3, 82, 0, 7.5), (4, 82, 0, null), (8, 82, 0, null), (12, 82, 0, null), (15, 82, 0, null), (18, 82, 0, null), (19, 82, 0, null), (23, 82, 0, null), (27, 82, 0, null), (30, 82, 0, null);

-- Squadra EQUI
-- Squadra MACCHI
-- Squadra PARDINI

############## 02: 2017/2018
-- Squadra GIGLIA
-- Squadra VICARI
-- Squadra CANALE
-- Squadra BALESTRI
-- Squadra LUPI
-- Squadra EQUI
-- Squadra PARDINI
-- Squadra CECCHI
-- Squadra NACCI
-- Squadra MACCHI

############## 03: 2018/2019
-- Squadra GARCEA
-- Squadra PARDINI
-- Squadra BOTRUGNO
-- Squadra TURI
-- Squadra VOUK
-- Squadra BALESTRI
-- Squadra TRIPICCIONE
-- Squadra CECCHI
-- Squadra EQUI
-- Squadra FRANCO
-- Squadra GIANI
-- Squadra CANALE
-- Squadra USAI
-- Squadra MACCHI

############## 04: 2019/2020, serie A
-- Squadra SCAGLIONE
-- Squadra FRANCO
-- Squadra AQUILA
-- Squadra VICARI
-- Squadra ROSSI
-- Squadra PARDINI
-- Squadra LUPI
-- Squadra DOMENICI
-- Squadra DEL PUNTA
-- Squadra GIANI

############## 05: 2019/2020, serie B
-- Squadra FIORINI
-- Squadra EQUI
-- Squadra BARUSHI
-- Squadra CANALE
-- Squadra VANNINI
-- Squadra GALLONI
-- Squadra INNOCENTI
-- Squadra MONARI
-- Squadra USAI
-- Squadra ALLEGRINI

############## 06: 2020/2021, serie A (annullata)
############## 07: 2020/2021, serie B (annullata)

############## 08: 2021/2022, serie A
-- Squadra INGHIRAMI
-- Squadra FADDA
-- Squadra GIANI
-- Squadra GALLONI
-- Squadra DI PINTO
-- Squadra AQUILA
-- Squadra GHELARDONI
-- Squadra ROSSI
-- Squadra GERINI

############## 09: 2021/2022, serie B
-- Squadra GULLOTTI
-- Squadra SODANO
-- Squadra UPERI
-- Squadra MONARI
-- Squadra SIMONETTI
-- Squadra TESI
-- Squadra MARRANINI
-- Squadra NACCI
-- Squadra TOGNETTI
-- Squadra BARUSHI
-- Squadra MARCHETTI

############## 10: 2025

-- Squadra AIRNIVOL
-- Squadra ARANCINI
-- Squadra BRAZIL
-- Squadra CISK LA RISSA
-- Squadra DEPORTIVO LA DAMA
-- Squadra FIVE TO TORRES
-- Squadra I PUPILLI DEL MARRA
-- Squadra SAILPOST
-- Squadra SVINCOLATI
-- Squadra TERRONI

############## 11: 2025/2026
-- Squadra ARANCINI
-- Squadra BLANCATORRES
-- Squadra LEGNA
-- Squadra SAETTA MC TEAM
-- Squadra SAILPOST
-- Squadra SCONOSCIUTI
-- Squadra SPORTING MISTONA
-- Squadra SVINCOLATI
-- Squadra TATTARI
-- Squadra TERRONI


