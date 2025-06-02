-- Kreiranje baze ako ne postoji
CREATE DATABASE IF NOT EXISTS RestoranDB;
USE RestoranDB;

-- Kategorije jela
CREATE TABLE IF NOT EXISTS Kategorija_jela (
    id_kategorije INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    naziv VARCHAR(50) NOT NULL
);

-- Jela
CREATE TABLE IF NOT EXISTS Jela (
    id_jela INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    naziv VARCHAR(100) NOT NULL,
    id_kategorije INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_kategorije) REFERENCES Kategorija_jela(id_kategorije)
);

-- Konobari
CREATE TABLE IF NOT EXISTS Konobari (
    id_konobara INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    ime VARCHAR(50) NOT NULL,
    prezime VARCHAR(50) NOT NULL
);

-- Stolovi
CREATE TABLE IF NOT EXISTS Stolovi (
    id_stola INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    broj_stola INT UNSIGNED NOT NULL
);

-- Narudžbe
CREATE TABLE IF NOT EXISTS Narudzbe (
    id_narudzbe INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_konobara INT UNSIGNED NOT NULL,
    id_stola INT UNSIGNED NOT NULL,
    id_jela INT UNSIGNED NOT NULL,
    vrijeme_narudzbe DATETIME NOT NULL,
    FOREIGN KEY (id_konobara) REFERENCES Konobari(id_konobara),
    FOREIGN KEY (id_stola) REFERENCES Stolovi(id_stola),
    FOREIGN KEY (id_jela) REFERENCES Jela(id_jela)
);

-- Unos testnih podataka
INSERT INTO Kategorija_jela (naziv) VALUES 
('Predjelo'), 
('Glavno jelo'), 
('Desert');

INSERT INTO Jela (naziv, id_kategorije) VALUES 
('Juha', 1),
('Ćevapi', 2),
('Tiramisu', 3);

INSERT INTO Konobari (ime, prezime) VALUES 
('Ivan', 'Ivić'), 
('Ana', 'Anić');

INSERT INTO Stolovi (broj_stola) VALUES 
(1), (2), (3);

INSERT INTO Narudzbe (id_konobara, id_stola, id_jela, vrijeme_narudzbe) VALUES 
(1, 1, 1, '2025-06-01 12:30:00'),
(2, 1, 2, '2025-06-01 12:35:00'),
(1, 2, 3, '2025-06-01 12:50:00');

-- Sve narudžbe s imenima konobara, stolovima i jelima
SELECT 
    n.id_narudzbe,
    k.ime,
    k.prezime,
    s.broj_stola,
    j.naziv AS jelo,
    n.vrijeme_narudzbe
FROM Narudzbe n
JOIN Konobari k ON n.id_konobara = k.id_konobara
JOIN Stolovi s ON n.id_stola = s.id_stola
JOIN Jela j ON n.id_jela = j.id_jela;

-- Broj narudžbi po stolu
SELECT 
    s.broj_stola,
    COUNT(n.id_narudzbe) AS broj_narudzbi
FROM Stolovi s
LEFT JOIN Narudzbe n ON s.id_stola = n.id_stola
GROUP BY s.id_stola;

-- Pohranjena procedura: broj narudžbi po kategoriji
DELIMITER $$

CREATE PROCEDURE BrojNarudzbiPoKategoriji()
BEGIN
    SELECT 
        kj.naziv AS kategorija,
        COUNT(n.id_narudzbe) AS broj_narudzbi
    FROM Narudzbe n
    JOIN Jela j ON n.id_jela = j.id_jela
    JOIN Kategorija_jela kj ON j.id_kategorije = kj.id_kategorije
    GROUP BY kj.naziv;
END $$

DELIMITER ;

-- Poziv procedure
CALL BrojNarudzbiPoKategoriji();

-- View: svi stolovi koji nemaju nijednu narudžbu
DROP VIEW IF EXISTS StoloviBezNarudzbi;

CREATE VIEW StoloviBezNarudzbi AS
SELECT s.id_stola, s.broj_stola
FROM Stolovi s
LEFT JOIN Narudzbe n ON s.id_stola = n.id_stola
WHERE n.id_narudzbe IS NULL;

-- Prikaz sadržaja view-a
SELECT * FROM StoloviBezNarudzbi;