
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
# todo: add price for each player ??
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
(1, '2016-09-01', '2017-04-01', '16/17'),
(2, '2017-09-01', '2018-04-01', '17/18'),
(3, '2018-09-01', '2019-04-01', '18/19'),
(4, '2019-09-01', '2020-04-01', '19/20 A'),
(4, '2019-09-01', '2020-04-01', '19/20 B'),
(5, '2020-09-01', '2021-04-01', '20/21 A'), -- annullato
(5, '2020-09-01', '2021-04-01', '20/21 B'), -- annullato
(6, '2021-09-01', '2021-04-01', '21/22 A'),
(6, '2021-09-01', '2022-04-01', '21/22 B'),
(7, '2025-02-01', '2025-06-01', '2025'),
(8, '2025-11-23', null, '25/26');

insert into team (lid, name) values
(1, "Canale"), (1, "Ciardelli"),(1, "Citi"), (1, "Equi"),(1, "Macchi"),(1, "Pardini"),
(2, "Balestri"), (2, "Canale"), (2, "Cecchi"), (2, "Equi"), (2, "Giglia"), (2, "Lupi"), (2, "Macchi"), (2, "Nacci"), (2, "Pardini"), (2, "Vicari"),
(3, "Balestri"), (3, "Botrugno"), (3, "Canale"), (3, "Cecchi"), (3, "Equi"), (3, "Franco"), (3, "Garcea"), (3, "Giani"), (3, "Macchi"), (3, "Pardini"), (3, "Tripiccione"), (3, "Turi"), (3, "Usai"), (3, "Vouk"),
(4, "Aquila"), (4, "Del Punta"), (4, "Domenici"), (4, "Franco"), (4, "Giani"), (4, "Lupi"), (4, "Pardini"), (4, "Rossi"), (4, "Scaglione"), (4, "Vicari"),
(5, "Allegrini"), (5, "Barushi"), (5, "Canale"), (5, "Equi"), (5, "Fiorini"), (5, "Galloni"), (5, "Innocenti"), (5, "Monari"), (5, "Usai"), (5, "Vannini"),
(8, "Aquila"), (8, "Di Pinto"), (8, "Fadda"), (8, "Galloni"), (8, "Gerini"), (8, "Ghelardoni"), (8, "Giani"), (8, "Gullotti"), (8, "Inghirami"), (8, "Rossi"),
(9, "Barushi"), (9, "Marchetti"), (9, "Marranini"), (9, "Monari"), (9, "Nacci"), (9, "Simonetti"), (9, "Sodano"), (9, "Tesi"), (9, "Tognetti"), (9, "Uperi"),
(10, "Airnivol"), (10, "Arancini"), (10, "Brazil"), (10, "CISK La Rissa"), (10, "Deportivo La Dama"), (10, "Five to Torres"), (10, "I pupilli del Marra"), (10, "Sailpost"), (10, "Svincolati"), (10, "Terroni"),
(11, "Arancini"), (11, "Blancatorres"), (11, "Legna"), (11, "Saetta Mc Team"), (11, "Sailpost"), (11, "Sconosciuti"), (11, "Sporting Mistona"), (11, "Svincolati"), (11, "Tattari"), (11, "Terroni");

insert into player (name, surname, nickname, birthdate, foot, number, role) VALUES
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

####### Stagione 2025
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


####### Stagione 25/26
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
("NOME", "Contini", null, null, null, null, null);

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
/*Sailpost*/ (78, 182), (78, 272), (78, 270), (78, 15), (78, 260), (78, 257), (78, 252), (78, 281), (78, 294), (78, 293),
/*Svincolati*/ (79, 291), (79, 266), (79, 100), (79, 273), (79, 216), (79, 190), (79, 302), (79, 256), (79, 32), (79, 269),
/*Terroni*/ (80, 245), (80, 268), (80, 277), (80, 334), (80, 335), (80, 184), (80, 300), (80, 264), (80, 250), (80, 283),

############## Stagione 25/26
/*Arancini*/ (81, 176), (81, 194), (81, 81), (81, 211), (81, 9), (81, 18),
/*Blancatorres*/ (82, 282), (82, 303), (82, 304), (82, 17), (82, 261), (82, 236), (82, 237), (82, 305),
/*Legna*/ (83, 2), (83, 122), (83, 135), (83, 306), (83, 10), (83, 307),
/*Saetta Mc Team*/ (84, 67), (84, 308), (84, 298), (84, 263), (84, 309), (84, 310), (84, 311), (84, 312), (84, 313), (84, 314), (84, 315),
/*Sailpost*/ (85, 182), (85, 270), (85, 257), (85, 85), (85, 252), (85, 112), (85, 335), (85, 15), (85, 253),
/*Sconosciuti*/ (86, 72), (86, 41), (86, 316), (86, 317), (86, 318), (86, 319), (86, 23), (86, 53),
/*Sporting Mistona*/ (87, 320), (87, 321), (87, 322), (87, 323), (87, 324), (87, 325), (87, 326),
/*Svincolati*/ (88, 45), (88, 266), (88, 327), (88, 256), (88, 190), (88, 328), (88, 216), (88, 329), (88, 273),
/*Tattari*/ (89, 222), (89, 246), (89, 157), (89, 249), (89, 48), (89, 125), (89, 185), (89, 234), (89, 170), (89, 110),
/*Terroni*/ (90, 245), (90, 268), (90, 277), (90, 330), (90, 331), (90, 332), (90, 333), (90, 334);


INSERT INTO matches (league, round, date, time, team_home, team_away, goals_home, goals_away, winner, penalties) VALUES
############## 01: 2016/2017
-- GIORNATA 1 -------------------------------------------------------------------
(1, 1, '2016-10-23', '18:00', 4, 1, 6, 7, 1, 0),    -- Equi vs Canale
(1, 1, '2016-10-23', '19:00', 2, 6, 3, 4, 6, 0),    -- Ciardelli vs Pardini
(1, 1, '2016-10-23', '20:00', 3, 5, 9, 12, 5, 0),   -- Citi vs Macchi

-- GIORNATA 2 -------------------------------------------------------------------
(1, 2, '2016-10-30', '18:00', 2, 3, 7, 4, 2, 0),    -- Ciardelli vs Citi
(1, 2, '2016-10-30', '19:00', 6, 1, 4, 5, 1, 0),    -- Pardini vs Canale
(1, 2, '2016-10-30', '20:00', 5, 4, 5, 8, 4, 0),    -- Macchi vs Equi

-- GIORNATA 3 -------------------------------------------------------------------
(1, 3, '2016-11-06', '18:00', 6, 4, 3, 6, 4, 0),    -- Pardini vs Equi
(1, 3, '2016-11-06', '19:00', 1, 3, 25, 7, 1, 0),   -- Canale vs Citi
(1, 3, '2016-11-06', '20:00', 2, 5, 12, 1, 2, 0),   -- Ciardelli vs Macchi

-- GIORNATA 4 -------------------------------------------------------------------
(1, 4, '2016-11-13', '18:00', 2, 4, 6, 16, 4, 0),   -- Ciardelli vs Equi
(1, 4, '2016-11-13', '19:00', 5, 1, 10, 1, 5, 0),   -- Macchi vs Canale
(1, 4, '2016-11-13', '20:00', 6, 3, 12, 6, 6, 0),   -- Pardini vs Citi

-- GIORNATA 5 -------------------------------------------------------------------
(1, 5, '2016-11-20', '18:00', 6, 5, 6, 2, 6, 0),    -- Pardini vs Macchi
(1, 5, '2016-11-20', '19:00', 1, 2, 9, 6, 1, 0),    -- Canale vs Ciardelli
(1, 5, '2016-11-20', '20:00', 3, 4, 6, 12, 4, 0),   -- Citi vs Equi

-- GIORNATA 6 -------------------------------------------------------------------
(1, 6, '2016-11-27', '18:00', 4, 1, 5, 3, 4, 0),    -- Equi vs Canale
(1, 6, '2016-11-27', '19:00', 2, 6, 3, 11, 6, 0),   -- Ciardelli vs Pardini
(1, 6, '2016-11-27', '20:00', 3, 5, 2, 3, 5, 0),    -- Citi vs Macchi

-- GIORNATA 7 -------------------------------------------------------------------
(1, 7, '2016-12-04', '18:00', 2, 3, 9, 6, 2, 0),    -- Ciardelli vs Citi
(1, 7, '2016-12-04', '19:00', 6, 1, 6, 5, 6, 0),    -- Pardini vs Canale
(1, 7, '2016-12-04', '20:00', 5, 4, 4, 4, 0, 0),    -- Macchi vs Equi

-- GIORNATA 8 -------------------------------------------------------------------
(1, 8, '2016-12-11', '18:00', 6, 4, 7, 7, 0, 0),    -- Pardini vs Equi
(1, 8, '2016-12-11', '19:00', 1, 3, 17, 9, 1, 0),   -- Canale vs Citi
(1, 8, '2016-12-11', '20:00', 2, 5, 5, 7, 5, 0),    -- Ciardelli vs Macchi

-- GIORNATA 9 -------------------------------------------------------------------
(1, 9, '2016-12-18', '18:00', 2, 4, 4, 15, 4, 0),   -- Ciardelli vs Equi
(1, 9, '2016-12-18', '19:00', 5, 1, 5, 8, 1, 0),    -- Macchi vs Canale
(1, 9, '2016-12-18', '20:00', 6, 3, 5, 6, 3, 0),    -- Pardini vs Citi

-- GIORNATA 10 ------------------------------------------------------------------
(1, 10, '2016-12-25', '18:00', 6, 5, 10, 6, 6, 0),  -- Pardini vs Macchi
(1, 10, '2016-12-25', '19:00', 1, 2, 16, 6, 1, 0),  -- Canale vs Ciardelli
(1, 10, '2016-12-25', '20:00', 3, 4, 6, 6, 0, 0);   -- Citi vs Equi


############## 02: 2017/2018
############## 03: 2018/2019
############## 04: 2019/2020, serie A
############## 05: 2019/2020, serie B
############## 06: 2020/2021, serie A (annullata)
############## 07: 2020/2021, serie B (annullata)
############## 08: 2021/2022, serie A
############## 09: 2021/2022, serie B
############## 10: 2025

############## 11: 2025/2026
-- GIORNATA 1 -------------------------------------------------------------------
-- (11, 1, '2025-11-23', '18:00', 89, 84, 1, 0, 9, 0),   	-- Tattari vs Saetta MC Team
-- (11, 1, '2025-11-23', '19:00', 82, 86, 6, 4, 2, 0),   	-- Blancatorres vs Sconosciuti
-- (11, 1, '2025-11-23', '20:00', 10, 8, 0, 6, 8, 0),   	-- Terroni vs Svincolati
-- (11, 1, '2025-11-30', '18:00', 87, 83, 0, 0, 0, null),   -- Sporting Mistona vs Legna
-- (11, 1, '2025-11-30', '19:00', 81, 85, 0, 0, 0, null);   -- Arancini vs Sailpost



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



