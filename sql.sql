DROP DATABASE IF EXISTS restoran;
CREATE DATABASE restoran;
USE restoran;

CREATE TABLE IF NOT EXISTS kategorija (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  naziv VARCHAR(255) NOT NULL
);

INSERT INTO kategorija (naziv)
VALUES ('domace');

INSERT INTO kategorija (naziv)
VALUES ('strano');

CREATE TABLE IF NOT EXISTS jelo (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  naziv VARCHAR(255) NOT NULL,
  cijena INT UNSIGNED NOT NULL,
  kategorija INT UNSIGNED NOT NULL,
  FOREIGN KEY (kategorija) REFERENCES kategorija(id)
);

INSERT INTO jelo (naziv, cijena, kategorija)
VALUES ('sarma', 5, 1);

INSERT INTO jelo (naziv, cijena, kategorija)
VALUES ('kotlovina', 7, 1);

CREATE TABLE IF NOT EXISTS konobar (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  ime VARCHAR(255) NOT NULL,
  prezime VARCHAR(255) NOT NULL
);

INSERT INTO konobar (ime, prezime)
VALUES ('Pero', 'Peric');

INSERT INTO konobar (ime, prezime)
VALUES ('Mato', 'Matic');


CREATE TABLE IF NOT EXISTS stol (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  broj INT UNSIGNED NOT NULL
);



INSERT INTO stol (broj)
VALUES ('2');
INSERT INTO stol (broj)
VALUES ('3');


CREATE TABLE IF NOT EXISTS narudzba (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  stol_id INT UNSIGNED NOT NULL,
  konobar_id INT UNSIGNED NOT NULL,
  jelo_id INT UNSIGNED NOT NULL,
  datum_vrijeme DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (stol_id) REFERENCES stol(id),
  FOREIGN KEY (konobar_id) REFERENCES konobar(id),
  FOREIGN KEY (jelo_id) REFERENCES jelo(id)
);

INSERT INTO narudzba (stol_id, konobar_id, jelo_id)
VALUES (1, 1, 2);
INSERT INTO narudzba (stol_id, konobar_id, jelo_id)
VALUES (2, 2, 1);


SELECT * FROM kategorija;
SELECT * FROM jelo;
SELECT * FROM konobar;
SELECT * FROM stol;
SELECT * FROM narudzba;

SELECT 
k.ime, 
k.prezime, 
s.broj AS stol, 
j.naziv AS jelo
FROM narudzba n
JOIN konobar k ON n.konobar_id = k.id
JOIN stol s ON n.stol_id = s.id
JOIN jelo j ON n.jelo_id = j.id;

SELECT 
s.broj AS stol, 
COUNT(n.id) AS broj_narudzbi
FROM narudzba n
JOIN stol s ON n.stol_id = s.id
GROUP BY s.id, s.broj;

SELECT * FROM narudzba;

DELIMITER $$

CREATE PROCEDURE broj_narudzbi_po_kategoriji()
BEGIN
SELECT 
k.naziv AS kategorija,
COUNT(n.id) AS broj_narudzbi
FROM narudzba n
JOIN jelo j ON n.jelo_id = j.id
JOIN kategorija k ON j.kategorija = k.id
GROUP BY k.id, k.naziv
ORDER BY broj_narudzbi DESC;
END $$

DELIMITER ;

CALL broj_narudzbi_po_kategoriji();


CREATE VIEW stolovi_bez_narudzbi AS
SELECT s.*
FROM stol s
LEFT JOIN narudzba n ON s.id = n.stol_id
WHERE n.id IS NULL;

SELECT * FROM stolovi_bez_narudzbi;







