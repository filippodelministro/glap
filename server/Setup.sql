
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
    mid INTEGER PRIMARY KEY AUTO_INCREMENT,
    pid INTEGER NOT NULL,
    goal INTEGER DEFAULT 0,
    grade DOUBLE DEFAULT NULL,
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
(5, '2020-09-01', '2021-04-01', '20/21 A'),
(5, '2020-09-01', '2021-04-01', '20/21 B'),
(6, '2021-09-01', '2021-04-01', '21/22 A'),
(6, '2021-09-01', '2022-04-01', '21/22 B'),
(7, '2025-02-01', '2025-06-01', '2025'),
(8, '2025-11-23', null, '25/26');

insert into team (lid, name) values
(1, "Equi"),(1, "Canale"),(1, "Pardini"),(1, "Citi"),(1, "Macchi"),(1, "Ciardelli"),
(2, "Giglia"), (2, "Vicari"), (2, "Canale"), (2, "Balestri"), (2, "Lupi"), (2, "Equi"), (2, "Pardini"), (2, "Cecchi"), (2, "Nacci"), (2, "Macchi"),
(3, "Garcea"), (3, "Pardini"), (3, "Botrugno"), (3, "Turi"), (3, "Vouk"), (3, "Balestri"), (3, "Tripiccione"), (3, "Cecchi"), (3, "Equi"), (3, "Franco"), (3, "Giani"), (3, "Canale"), (3, "Usai"), (3, "Macchi"),
(4, "Scaglione"), (4, "Franco"), (4, "Aquila"), (4, "Vicari"), (4, "Rossi"), (4, "Pardini"), (4, "Lupi"), (4, "Domenici"), (4, "Del Punta"), (4, "Giani"),
(5, "Fiorini"), (5, "Equi"), (5, "Barushi"), (5, "Canale"), (5, "Vannini"), (5, "Galloni"), (5, "Innocenti"), (5, "Monari"), (5, "Usai"), (5, "Allegrini"),
(8, "Inghirami"), (8, "Fadda"), (8, "Giani"), (8, "Galloni"), (8, "Di Pinto"), (8, "Aquila"), (8, "Ghelardoni"), (8, "Rossi"), (8, "Gerini"), (8, "Gullotti"),
(9, "Sodano"), (9, "Uperi"), (9, "Monari"), (9, "Simonetti"), (9, "Tesi"), (9, "Marranini"), (9, "Nacci"), (9, "Tognetti"), (9, "Barushi"), (9, "Marchetti"),
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
("Sposato", "Marco", null, null, 'D', null, 'D'),
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
("Giuseppe", "Fanfulla", null, null, null, null, null);

insert into sign (tid, pid) values 
############## Stagione 2016-2017
/*Equi*/
/*Canale*/
/*Pardini*/
/*Macchi*/
/*Ciardelli*/
/*Citi*/

############## Stagione 2017-2018
/*Giglia*/ (7, 115), (7, 142), (7, 162), (7, 82), (7, 89), (7, 128), (7, 71), 
/*Vicari*/ (8, 22), (8, 113), (8, 170), (8, 193), (8, 212), (8, 1), (8, 74), 
/*Canale*/ (9, 107), (9, 8), (9, 95), (9, 181), (9, 180), (9, 222), (9, 228), 
/*Balestri*/ (10, 178), (10, 93), (10, 169), (10, 196), (10, 122), (10, 62), (10, 231), 
/*Lupi*/ (11, 221), (11, 124), (11, 200), (11, 64), (11, 85), (11, 229), (11, 156), 
/*Equi*/ (12, 18), (12, 37), (12, 150), (12, 104), (12, 161), (12, 166), (12, 134),
/*Pardini*/ (13, 21), (13, 133), (13, 99), (13, 183), (13, 137), (13, 40), (13, 29), 
/*Cecchi*/ (14, 62), (14, 65), (14, 34), (14, 176), (14, 110), (14, 80), (14, 87), 
/*Nacci*/ (15, 101), (15, 136), (15, 79), (15, 68), (15, 227), (15, 177), (15, 42), 
/*Macchi*/ (16, 182) , (16, 230), (16, 155), (16, 155), (16, 44), (16, 88), (16, 146), 

############## Stagione 2018-2019
/*Garcea*/ (17, 71), (17, 136), (17, 137), (17, 222), (17, 74), (17, 106), (17, 78), 
/*Pardini*/ (18, 21), (18, 217), (18, 87), (18, 85), (18, 69), (18, 176), (18, 167), 
/*Botrugno*/ (19, 135), (19, 221), (19, 54), (19, 156), (19, 89), (19, 10), (19, 47), 
/*Turi*/ (20, 104), (20, 19), (20, 134), (20, 127), (20, 80), (20, 63), (20, 177), 
/*Vouk*/ (21, 124), (21, 198), (21, 5), (21, 122), (21, 1), (21, 115), (21, 64), 
/*Balestri*/ (22, 178), (22, 8), (22, 185), (22, 141), (22, 183), (22, 169), (22, 88), 
/*Tripiccione*/ (23, 42), (23, 214), (23, 99), (23, 161), (23, 112), (23, 186), (23, 128), 

/*Cecchi*/ (24, 62), (24, 93), (24, 181), (24, 196), (24, 226), (24, 34), (24, 103), 
/*Equi*/ (25, 18), (25, 187), (25, 200), (25, 30), (25, 207), (25, 55), (25, 72), 
/*Franco*/ (26, 113), (26, 22), (26, 66), (26, 94), (26, 119), (26, 194), 
/*Giani*/ (27, 170), (27, 133), (27, 110), (27, 46), (27, 150), (27, 192), (27, 165), 
/*Canale*/ (28, 107), (28, 67), (28, 101), (28, 162), (28, 79), (28, 76), (28, 115), (28, 82), 
/*Usai*/ (29, 44), (29, 142), (29, 6), (29, 118), (29, 193), (29, 218), (29, 164), 
/*Macchi*/ (30, 182), (30, 65), (30, 68), (30, 180), (30, 86), (30, 212), (30, 12), 

############## Stagione 2019-2020, serie A
/*Scaglione*/ (31, 122), (31, 8), (31, 135), (31, 130), (31, 207), (31, 9), (31, 104), 
/*Franco*/ (32, 113), (32, 194), (32, 206), (32, 106), (32, 85), (32, 188), (32, 223), 
/*Aquila*/ (33, 99), (33, 80), (33, 161), (33, 176), (33, 163), (33, 196), (33, 60),
/*Vicari*/ (34, 22), (34, 205), (34, 137), (34, 158), (34, 191), (34, 126), (34, 216), 
/*Rossi*/ (35, 200), (35, 142), (35, 134), (35, 179), (35, 55), (35, 17), (35, 89), 
/*Pardini*/ (36, 21), (36, 217), (36, 72), (36, 182), (36, 167), (36, 162), (36, 10), 
/*Lupi*/ (37, 221), (37, 68), (37, 192), (37, 201), (37, 76), (37, 64), (37, 79), 
/*Domenici*/ (38, 110), (38, 83), (38, 127), (38, 186), (38, 102), (38, 81), (38, 109),
/*Del Punta*/ (39, 198), (39, 54), (39, 148), (39, 125), (39, 222), (39, 215), (39, 47),
/*Giani*/ (40, 170), (40, 67), (40, 174), (40, 98), (40, 24), (40, 112), (40, 52), 

############## Stagione 2019-2020, serie B
/*Fiorini*/ (41, 65), (41, 70), (41, 199), (41, 143), (41, 73), (41, 69),
/*Equi*/ (42, 18), (42, 42), (42, 145), (42, 212), (42, 30), (42, 78), (42, 75), 
/*Barushi*/ (43, 46), (43, 41), (43, 189), (43, 121), (43, 58), (43, 31), (43, 209), 
/*Canale*/ (44, 107), (44, 36), (44, 100), (44, 171), (44, 120), (44, 25), (44, 12), 
/*Vannini*/ (45, 74), (45, 87), (45, 13), (45, 118), (45, 32), (45, 19), (45, 224), 
/*Galloni*/ (46, 5), (46, 50), (46, 48), (46, 164), (46, 150), (46, 53), #manca una persona
/*Innocenti*/ (47, 94), (47, 225), (47, 34), (47, 141), (47, 66), (47, 139), (47, 111), 
/*Monari*/ (48, 185), (48, 157), (48, 129), (48, 172), (48, 159), (48, 11), (48,180), 
/*Usai*/ (49, 44), (49, 136), (49, 101), (49, 149), (49, 1), (49, 16), (49, 138), 
/*Allegrini*/ (50, 133), (50, 183), (50, 6), (50, 119), (50, 63), (50, 88), (50, 3), 

############### Stagione 2020-2021, serie A (annullata)
############### Stagione 2020-2021, serie A (annullata)

############## Stagione 2021-2022, serie A
/*Inghirami*/ (51, 68), (51, 217), (51, 54), (51, 105), (51, 7), (51, 59), (51, 153),
/*Fadda*/ (52, 157), (52, 190), (52, 182), (52, 196), (52, 33), (52, 171), (52, 43),
/*Giani*/ (53, 170), (53, 198), (53, 216), (53, 10), (53, 127), (53, 64), (53, 219),
/*Galloni*/ (54, 5), (54, 22), (54, 125), (54, 77), (54, 15), (54, 197), (54, 144),
/*Di Pinto*/ (55, 109), (55, 45), (55, 122), (55, 110), (55, 154), (55, 72), (55, 145),

/*Aquila*/ (56, 99), (56, 21), (56, 112), (56, 89), (56, 107), (56, 32), (56, 108),
/*Ghelardoni*/ (57, 209), (57, 19), (57, 175), (57, 184), (57, 102), (57, 167), (57, 60),
/*Rossi*/ (58, 200), (58, 186), (58, 8), (58, 9), (58, 79), (58, 148), (58, 76),
/*Gerini*/ (59, 222), (59, 221), (59, 162), (59, 220), (59, 147), (59, 194), (59, 192),
/*Gullotti*/ (60, 6), (60, 203), (60, 57), (60, 17), (60, 66), (60, 81), (60, 16),

############## Stagione 2021-2022, serie B
/*Sodano*/ (61, 202), (61, 142), (61, 25), (61, 73), (61, 129), (61, 49), (61, 90),
/*Uperi*/ (62, 48), (62, 140), (62, 31), (62, 151), (62, 210), (62, 100), (62, 235), 
/*Monari*/ (63, 185), (63, 28), (63, 234), (63, 204), (63, 4), (63, 132), (63, 1), 
/*Simonetti*/ (64, 139), (64, 208), (64, 233), (64, 47), (64, 3), (64, 87), (64, 51), 
/*Tesi*/ (65, 41), (65, 120), (65, 180), (65, 94), (65, 111), (65, 131), (65, 232), 

/*Marranini*/ (66, 149), (66, 133), (66, 160), (66, 143), (66, 67), (66, 141), (66, 92), 
/*Nacci*/ (67, 101), (67, 27), (67, 176), (67, 161), (67, 91), (67, 74), (67, 152), 
/*Tognetti*/ (68, 123), (68, 84), (68, 114), (68, 172), (68, 164), (68, 14), (68, 88), 
/*Barushi*/ (69, 46), (69, 20), (69, 35), (69, 2), (69, 168), (69, 23), (69, 38), 
/*Marchetti*/ (70, 150), (70, 173), (70, 44), (70, 221), (70, 97), (70, 213), (70, 126),

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
(11, 1, '2025-11-23', '18:00',  89,  84, 1, 0, 9, 0),   -- Tattari vs Saetta MC Team
(11, 1, '2025-11-23', '19:00',  82,  86, 6, 4, 2, 0),   -- Blancatorres vs Sconosciuti
(11, 1, '2025-11-23', '20:00', 10,  8, 0, 6, 8, 0),   -- Terroni vs Svincolati
(11, 1, '2025-11-30', '18:00',  87,  83, 0, 0, 0, null),   -- Sporting Mistona vs Legna
(11, 1, '2025-11-30', '19:00',  81,  85, 0, 0, 0, null);   -- Arancini vs Sailpost



INSERT INTO performance (mid, pid, goal, grade) VALUES

(1, 282, 0, 8);

############## 01: 2016/2017
############## 02: 2017/2018
############## 03: 2018/2019
############## 04: 2019/2020, serie A
############## 05: 2019/2020, serie B
############## 06: 2020/2021, serie A (annullata)
############## 07: 2020/2021, serie B (annullata)
############## 08: 2021/2022, serie A
############## 09: 2021/2022, serie B
############## 10: 2025
