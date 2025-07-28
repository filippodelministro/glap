BEGIN TRANSACTION;

-- Creation of tables
DROP TABLE IF EXISTS sessions;
CREATE TABLE IF NOT EXISTS sessions (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT, -- Uso di AUTOINCREMENT per SQLite
    "data" DATE NOT NULL,
    "user" TEXT NOT NULL,
    "car" TEXT NOT NULL,
    "circuit" TEXT NOT NULL,
    "condition" TEXT,
    "laps" INT NOT NULL,
    "best" TIME(3) NOT NULL,
    "total_time" TIME(3)
);

DROP TABLE IF EXISTS sessions2;
CREATE TABLE IF NOT EXISTS sessions2 (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT, -- Uso di AUTOINCREMENT per SQLite
    "data" DATE NOT NULL,
    "user" INTEGER NOT NULL,
    "car" INTEGER NOT NULL,
    "circuit" INTEGER NOT NULL,
    "condition" TEXT,
    "laps" INT NOT NULL,
    "best" TIME(3) NOT NULL,
    "total_time" TIME(3),

    FOREIGN KEY ("user") REFERENCES user ("id"),
    FOREIGN KEY ("car") REFERENCES cars ("id"),
    FOREIGN KEY ("circuit") REFERENCES circuits ("id")
);

DROP TABLE IF EXISTS users;
create table if not exists users (
	"id"    INTEGER PRIMARY KEY AUTOINCREMENT,
	"name"	TEXT NOT NULL,
	"hash"	TEXT NOT NULL,
	"salt"	TEXT NOT NULL
);

DROP TABLE IF EXISTS cars;
create table if not exists cars (
	"id"        INTEGER PRIMARY KEY AUTOINCREMENT,
	"factory"	TEXT NOT NULL,
	"model"	    TEXT NOT NULL,
	"version"   TEXT,
    "cc"	    INTEGER,
    "gears"     INTEGER,
    "weight"	INTEGER
);

DROP TABLE IF EXISTS circuits;
create table if not exists circuits (
	"id"        INTEGER PRIMARY KEY AUTOINCREMENT,
	"name"	    TEXT NOT NULL,
	"length"    INTEGER NOT NULL,
	"country"   TEXT
);

-- Population of DB
INSERT INTO sessions (data, user, car, circuit, condition, laps, best, total_time) VALUES
('2024-09-07', 'Pippo', 'Abarth AC', 'Mugello', 'Asciutto', 45, '02:17.220', '01:30'),
('2024-09-08', 'Pippo', 'Abarth AC', 'Mugello', 'Asciutto', 15, '02:17.745', '00:30'),
('2024-09-09', 'Pippo', 'Abarth AC', 'Mugello', 'Asciutto', 70, '02:15.465', '02:20'),
('2024-09-12', 'Pippo', 'Abarth AC', 'Mugello', 'Asciutto', 31, '02:15.621', '01:30'),
('2024-09-16', 'Pippo', 'Abarth AC', 'Vallelunga', 'Asciutto', 15, '01:57.075', '00:30'),
('2024-09-16', 'Pippo', 'Ferrari 458', 'Mugello', 'Asciutto', 10, '02:10.322', '00:20'),
('2024-09-17', 'Pippo', 'Abarth AC', 'Vallelunga', 'Asciutto', 10, '02:16.743', '00:25'),
('2024-09-18', 'Pippo', 'Abarth AC', 'Mugello', 'Asciutto', 10, '02:14.587', '00:25'),
('2024-09-19', 'Pippo', 'Abarth AC', 'Mugello', 'Asciutto', 12, '02:14.112', '00:25'),
('2024-09-19', 'Pippo', 'Abarth AC', 'Vallelunga', 'Asciutto', 6, '01:56.468', '00:15'),
('2024-09-19', 'Pippo', 'AR Giulia', 'Mugello', 'Asciutto', 7, '02:12.237', '00:15'),
('2024-09-20', 'Pippo', 'AR Giulia', 'Mugello', 'Asciutto', 13, '02:11.143', '00:25'),
('2024-09-20', 'Pippo', 'BMW M3 E30 Step1', 'Nordschleife', 'Asciutto', 10, '09:00.851', '01:00'),
('2024-09-20', 'Pippo', 'Lotus Elise SC1', 'Zanvoort', 'Asciutto', 24, '02:02.693', '01:00'),
('2024-09-23', 'Pippo', 'Lotus Elise SC1', 'Mugello', 'Asciutto', 15, '02:15.558', '00:30'),
('2024-09-23', 'Pippo', 'Lotus Elise SC1', 'Zanvoort', 'Asciutto', 20, '02:01.997', '00:40'),
('2024-09-24', 'Pippo', 'Lotus Elise SC1', 'Zanvoort', 'Asciutto', 10, '02:02.081', '00:15'),
('2024-09-26', 'Pippo', 'BMW M3 E30 Step1', 'Nordschleife', 'Asciutto', 4, '08:59.253', '00:40');

INSERT INTO sessions2 (data, user, car, circuit, condition, laps, best, total_time) VALUES
('2024-09-07', 1, 1, 1, 'Asciutto', 45, '02:17.220', '01:30'),
('2024-09-08', 1, 1, 1, 'Asciutto', 15, '02:17.745', '00:30'),
('2024-09-09', 1, 1, 1, 'Asciutto', 70, '02:15.465', '02:20'),
('2024-09-12', 1, 1, 1, 'Asciutto', 31, '02:15.621', '01:30'),
('2024-09-16', 1, 1, 4, 'Asciutto', 15, '01:57.075', '00:30'),
('2024-09-16', 1, 2, 1, 'Asciutto', 10, '02:10.322', '00:20'),
('2024-09-17', 1, 1, 4, 'Asciutto', 10, '02:16.743', '00:25'),
('2024-09-18', 1, 1, 1, 'Asciutto', 10, '02:14.587', '00:25'),
('2024-09-19', 1, 1, 1, 'Asciutto', 12, '02:14.112', '00:25'),
('2024-09-19', 1, 1, 4, 'Asciutto', 6, '01:56.468', '00:15'),
('2024-09-19', 1, 3, 1, 'Asciutto', 7, '02:12.237', '00:15'),
('2024-09-20', 1, 3, 1, 'Asciutto', 13, '02:11.143', '00:25'),
('2024-09-20', 1, 4, 5, 'Asciutto', 10, '09:00.851', '01:00'),
('2024-09-20', 1, 5, 6, 'Asciutto', 24, '02:02.693', '01:00'),
('2024-09-23', 1, 5, 1, 'Asciutto', 15, '02:15.558', '00:30'),
('2024-09-23', 1, 5, 6, 'Asciutto', 20, '02:01.997', '00:40'),
('2024-09-24', 1, 5, 6, 'Asciutto', 10, '02:02.081', '00:15'),
('2024-09-26', 1, 4, 5, 'Asciutto', 4, '08:59.253', '00:40');


INSERT INTO users (name, hash, salt) VALUES
('Pippo','15d3c4fca80fa608dcedeb65ac10eff78d20c88800d016369a3d2963742ea288','72e4eeb14def3b21'),
('Ciccio','1d22239e62539d26ccdb1d114c0f27d8870f70d622f35de0ae2ad651840ee58a','a8b618c717683608'),
('Vince','61ed132df8733b14ae5210457df8f95b987a7d4b8cdf3daf2b5541679e7a0622','e818f0647b4e1fe0');

INSERT INTO cars (factory, model, version, cc, gears, weight) VALUES
('Abarth', '500', 'AC', 1000, 6, 500),
('Ferrari', '458', null, 3000, 6, 500),
('Alfa Romeo', 'Giulia', null, 2000, 5, 700),
('BMW', 'M3 E30', 'Step1', 8000, 6, 650),
('Lotus', 'Elise', 'Step1', 850, 6, 600);

INSERT INTO circuits (name, length, country) VALUES
('Mugello', 5245, 'Italy'),
('Monza', 5793, 'Italy'),
('Imola', 4909, 'Italy'),
('Vallelunga', 4085, 'Italy'),
('Nordschleife', 20832, 'Germany'),
('Zandvoort', 1, 'Netherlands');


COMMIT;
