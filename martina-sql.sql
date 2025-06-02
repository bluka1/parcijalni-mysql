CREATE DATABASE IF NOT EXISTS `parcijalni-sql`;

USE `parcijalni-sql`; 

-- stvaranje tablica
CREATE TABLE IF NOT EXISTS kategorije (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  ime VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS stolovi (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  naziv VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS konobari (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  ime VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS jela (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  ime VARCHAR(255) NOT NULL,
  kategorija_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (kategorija_id) REFERENCES kategorije(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS narudzbe (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  konobar_id INT UNSIGNED NOT NULL,
  stol_id INT UNSIGNED NOT NULL,
  jelo_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (konobar_id) REFERENCES konobari(id) ON DELETE CASCADE,
  FOREIGN KEY (stol_id) REFERENCES stolovi(id) ON DELETE CASCADE,
  FOREIGN KEY (jelo_id) REFERENCES jela(id) ON DELETE CASCADE
);

-- dodavanje podataka

INSERT INTO kategorije (ime)
VALUES ('Predjelo'), ('Glavno jelo'), ('Desert');

INSERT INTO stolovi (naziv)
VALUES ('Broj 1'), ('Broj 2'), ('Broj 3');

INSERT INTO konobari (ime)
VALUES ('Marko'), ('Luka'), ('Ivan');

INSERT INTO jela (ime, kategorija_id)
VALUES ('Carbonara', 2), ('Ledeni vjetar', 3), ('Hladna plata', 1);

INSERT INTO narudzbe (konobar_id, jelo_id, stol_id)
VALUES (1,1,1), (1,2,1), (2,2,3);

-- Dohvatite sve narudžbe s imenima konobara, stolovima i nazivima jela
SELECT konobari.id AS 'ID Konobara', konobari.ime AS 'Ime konobara', stolovi.naziv AS 'Naziv stola', jela.ime AS 'Ime jela'
FROM narudzbe 
INNER JOIN konobari ON narudzbe.konobar_id = konobari.id
INNER JOIN stolovi ON narudzbe.stol_id = stolovi.id
INNER JOIN jela ON narudzbe.jelo_id = jela.id;

-- Dohvatite broj narudžbi po stolu. 
SELECT stolovi.naziv AS 'Naziv stola', COUNT(*) AS 'Broj narudžbi'
FROM narudzbe
INNER JOIN stolovi ON narudzbe.stol_id = stolovi.id
GROUP BY stolovi.naziv;

-- Kreirajte pohranjenu proceduru koja prikazuje broj narudžbi po kategoriji jela.
DELIMITER //
CREATE PROCEDURE CountOrdersByCat()
BEGIN
SELECT jela.kategorija_id AS 'Id Kategorije', COUNT(*) AS 'Broj narudzbi u kat'
FROM narudzbe
INNER JOIN jela ON narudzbe.jelo_id = jela.id
GROUP BY jela.kategorija_id;
END //
DELIMITER ;

CALL CountOrdersByCat();

-- Dohvatite sve stolove koji trenutno nemaju niti jednu narudžbu.
SELECT stolovi.naziv AS 'Stol bez narudzbi'
FROM stolovi
LEFT JOIN narudzbe ON stolovi.id = narudzbe.stol_id
WHERE narudzbe.id IS NULL;


