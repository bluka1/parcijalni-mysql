DROP DATABASE IF EXISTS restoran;
CREATE DATABASE restoran;
USE restoran;


-- Kreiranje tablica

CREATE TABLE stolovi (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    brojStola INT UNSIGNED UNIQUE NOT NULL
);

CREATE TABLE konobari (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(255) NOT NULL,
    prezime VARCHAR(255) NOT NULL
);

CREATE TABLE kategorije (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(255) NOT NULL
);

CREATE TABLE jela (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(255) NOT NULL,
    kategorijaId INT UNSIGNED,
    FOREIGN KEY (kategorijaId) REFERENCES kategorije(id) ON DELETE CASCADE
);

CREATE TABLE narudzbe (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    datumVrijeme DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    stolId INT UNSIGNED,
    konobarId INT UNSIGNED,
    jeloId INT UNSIGNED,
    FOREIGN KEY (stolId) REFERENCES stolovi(id) ON DELETE CASCADE,
    FOREIGN KEY (konobarId) REFERENCES konobari(id) ON DELETE CASCADE,
    FOREIGN KEY (jeloId) REFERENCES jela(id) ON DELETE CASCADE
);


-- Dodavanje podataka

INSERT INTO stolovi (id,brojStola) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

SELECT * FROM stolovi;

INSERT INTO konobari (id, ime, prezime) VALUES
(1, 'Marko', 'Novak'),
(2, 'Ana', 'Babić'),
(3, 'Nikola', 'Perić');

SELECT * FROM konobari;

INSERT INTO kategorije (id,naziv) VALUES
(1, 'Predjelo'),
(2, 'Glavno jelo'),
(3, 'Desert');

SELECT * FROM kategorije;

INSERT INTO jela (id, naziv, kategorijaId) VALUES
(1, 'Juha', 1),
(2, 'Pršut s maslinama', 1),
(3, 'Piletina s rižom', 2),
(4, 'Riba na žaru', 2),
(5, 'Sacher Torta', 3),
(6, 'Palačinke', 3);

SELECT * FROM jela;

INSERT INTO narudzbe (id, stolId, konobarId, jeloId) VALUES
(1, 1, 1, 1),
(2, 1, 1, 2),
(3, 2, 2, 4),
(4, 4, 1, 1),
(5, 4, 1, 2),
(6, 5, 2, 3),
(7, 5, 2, 4),
(8, 2, 3, 5),
(9, 3, 3, 6);

SELECT * FROM narudzbe;


-- Sve narudžbe s imenima konobara, stolovimna i jelima

SELECT n.id 'Narudzba broj', k.ime 'Ime', k.prezime 'Prezime', s.brojStola 'Broj stola', j.naziv 'Jelo' FROM narudzbe n
INNER JOIN Konobari k ON n.konobarId = k.id
INNER JOIN Stolovi s ON n.stolId = s.id
INNER JOIN Jela j ON n.jeloId = j.id;

-- Broj narudzbi po stolu

SELECT s.brojStola, COUNT(n.id) 'Broj narudzbi' FROM stolovi s
LEFT JOIN narudzbe n ON s.id = n.stolId
GROUP BY s.brojStola;


-- Procedura koja pokazuje broj narudzbi po kategoriji

DELIMITER $$
CREATE PROCEDURE brojNarudzbiPoKategoriji()
BEGIN
    SELECT ka.naziv 'Kategorija', COUNT(n.id) 'Broj narudzbi' FROM kategorije ka
    LEFT JOIN jela j ON ka.id = j.kategorijaId
    LEFT JOIN narudzbe n ON j.id = n.jeloId
    GROUP BY ka.naziv;
END$$
DELIMITER ;

CALL brojNarudzbiPoKategoriji();


-- view stolova bez narudžbi

CREATE OR REPLACE VIEW bezNarudzbi AS
SELECT s.brojStola FROM stolovi s
LEFT JOIN narudzbe n ON s.id = n.stolId
WHERE n.id IS NULL;

SELECT * FROM bezNarudzbi;
