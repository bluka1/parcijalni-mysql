DROP DATABASE IF EXISTS RestoranDB;
CREATE DATABASE RestoranDB;
USE RestoranDB;

CREATE TABLE Kategorija (
    id_kategorije INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(100) NOT NULL
);

CREATE TABLE Jelo (
    id_jela INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(100) NOT NULL,
    cijena DECIMAL(6,2) NOT NULL,
    id_kategorije INT NOT NULL,
    FOREIGN KEY (id_kategorije) REFERENCES Kategorija(id_kategorije)
);

CREATE TABLE Konobar (
    id_konobara INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(50) NOT NULL,
    prezime VARCHAR(50) NOT NULL
);

CREATE TABLE Stol (
    id_stola INT AUTO_INCREMENT PRIMARY KEY,
    oznaka_stola VARCHAR(20) NOT NULL
);

CREATE TABLE Narudzba (
    id_narudzbe INT AUTO_INCREMENT PRIMARY KEY,
    vrijeme DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_jela INT NOT NULL,
    id_konobara INT NOT NULL,
    id_stola INT NOT NULL,
    FOREIGN KEY (id_jela) REFERENCES Jelo(id_jela),
    FOREIGN KEY (id_konobara) REFERENCES Konobar(id_konobara),
    FOREIGN KEY (id_stola) REFERENCES Stol(id_stola)
);

INSERT INTO Kategorija (naziv) VALUES 
('Predjelo'), ('Glavno jelo'), ('Desert');

INSERT INTO Jelo (naziv, cijena, id_kategorije) VALUES 
('Juha', 3.50, 1),
('Šnicla', 8.90, 2),
('Tiramisu', 4.20, 3),
('Rižoto', 7.50, 2);

INSERT INTO Konobar (ime, prezime) VALUES 
('Ana', 'Horvat'),
('Marko', 'Marić'),
('Iva', 'Kovač');

INSERT INTO Stol (oznaka_stola) VALUES 
('Stol 1'), ('Stol 2'), ('Stol 3'), ('Stol 4');

INSERT INTO Narudzba (id_jela, id_konobara, id_stola) VALUES 
(1, 1, 1),
(2, 2, 1),
(3, 1, 2),
(4, 2, 3);

SELECT n.id_narudzbe, n.vrijeme, 
       k.ime, k.prezime, 
       s.oznaka_stola, 
       j.naziv AS jelo
FROM Narudzba n
JOIN Konobar k ON n.id_konobara = k.id_konobara
JOIN Stol s ON n.id_stola = s.id_stola
JOIN Jelo j ON n.id_jela = j.id_jela;

SELECT s.oznaka_stola, COUNT(n.id_narudzbe) AS broj_narudzbi
FROM Stol s
LEFT JOIN Narudzba n ON s.id_stola = n.id_stola
GROUP BY s.id_stola;

DELIMITER //

CREATE PROCEDURE BrojNarudzbiPoKategoriji()
BEGIN
    SELECT k.naziv AS kategorija, COUNT(n.id_narudzbe) AS broj_narudzbi
    FROM Narudzba n
    JOIN Jelo j ON n.id_jela = j.id_jela
    JOIN Kategorija k ON j.id_kategorije = k.id_kategorije
    GROUP BY k.id_kategorije;
END //

DELIMITER ;


SELECT s.oznaka_stola
FROM Stol s
LEFT JOIN Narudzba n ON s.id_stola = n.id_stola
WHERE n.id_narudzbe IS NULL;
