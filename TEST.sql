CREATE DATABASE IF NOT EXISTS restoran;
USE restoran;

CREATE TABLE IF NOT EXISTS Kategorija (
    id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Jelo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(100) NOT NULL,
    kategorija_id  INT NOT NULL,
    FOREIGN KEY (kategorija_id) REFERENCES Kategorija(id)
);

CREATE TABLE IF NOT EXISTS Konobar (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(50) NOT NULL,
    prezime VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Stol (
    id INT AUTO_INCREMENT PRIMARY KEY,
    oznaka VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS Narudzba (
    id INT AUTO_INCREMENT PRIMARY KEY,
    konobar_id INT NOT NULL,
    stol_id INT NOT NULL,
    jelo_id INT NOT NULL,
    datum_vrijeme DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (konobar_id) REFERENCES Konobar(id),
    FOREIGN KEY (stol_id) REFERENCES Stol(id),
    FOREIGN KEY (jelo_id) REFERENCES Jelo(id)
);

--INSERTI

INSERT INTO Kategorija (naziv) VALUES
('Predjelo'), ('Glavno jelo'), ('Desert');

INSERT INTO Jelo (naziv, kategorija_id) VALUES
('Tiramisu', 3),
('Palačinke s nuttelom', 3),
('Dalmatinska Juha', 1),
('Goveđi gulaš', 2),
('Piletina na naglo s rižom', 2);

INSERT INTO Konobar (ime, prezime) VALUES
('Marko', 'Ivanković'),
('Ivan', 'Marković');

INSERT INTO Stol (oznaka) VALUES
('A1'), ('A2'), ('B1'), ('B2');

INSERT INTO Narudzba (konobar_id, stol_id, jelo_id) VALUES
(1, 1, 1),
(1, 1, 2),
(2, 2, 3),
(2, 2, 5),
(1, 3, 4);

-- DOHVAT NARUDŽBI

SELECT
    n.id AS narudzba_id,
    k.ime AS konobar_ime,
    k.prezime AS konobar_prezime,
    s.oznaka AS stol,
    j.naziv AS jelo,
    n.datum_vrijeme
FROM Narudzba n
JOIN Konobar k ON n.konobar_id = k.id
JOIN Stol s ON n.stol_id = s.id
JOIN Jelo j ON n.jelo_id = j.id;

-- NARUDŽBE PO STOLU

SELECT 
    s.oznaka AS stol,
    COUNT(n.id) AS broj_narudzbi
FROM Stol s
LEFT JOIN Narudzba n ON s.id = n.stol_id
GROUP BY s.id;


-- NARUDŽBE PO KATEGORIJI JELA

DELIMITER $$

CREATE PROCEDURE BrojNarudzbiPoKategoriji()
BEGIN
    SELECT 
        k.naziv AS kategorija,
        COUNT(n.id) AS broj_narudzbi
    FROM Narudzba n
    JOIN Jelo j ON n.jelo_id = j.id
    JOIN Kategorija k ON j.kategorija_id = k.id
    GROUP BY k.id;
END $$

DELIMITER ;

CALL BrojNarudzbiPoKategoriji();

-- STOL BEZ NARUDŽBE
SELECT 
    s.oznaka
FROM Stol s
LEFT JOIN Narudzba n ON s.id = n.stol_id
WHERE n.id IS NULL;

-- VIEW

CREATE VIEW StoloviBezNarudzbi AS
SELECT s.*
FROM Stol s
LEFT JOIN Narudzba n ON s.id = n.stol_id
WHERE n.id IS NULL;


