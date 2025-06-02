CREATE DATABASE IF NOT EXISTS restoran;

USE restoran;

CREATE TABLE IF NOT EXISTS kategorijeJela (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  naziv VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS jela (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  naziv VARCHAR(255) NOT NULL,
  kategorijaId INT UNSIGNED NOT NULL,
  FOREIGN KEY (kategorijaId) REFERENCES kategorijeJela(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS konobari (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  ime VARCHAR(255) NOT NULL,
  prezime VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS stolovi (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  brojStola INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS narudzbe (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  jeloId INT UNSIGNED NOT NULL,
  konobarId INT UNSIGNED NOT NULL,
  stolId INT UNSIGNED NOT NULL,  
  FOREIGN KEY (jeloId) REFERENCES jela(id) ON DELETE CASCADE,
  FOREIGN KEY (konobarId) REFERENCES konobari(id) ON DELETE CASCADE,
  FOREIGN KEY (stolId) REFERENCES stolovi(id) ON DELETE CASCADE
);

------------------------------------------

INSERT INTO kategorijeJela (naziv) 
VALUES ('Predjelo'), ('Glavno jelo'), ('Desert'); 

INSERT INTO jela (naziv, kategorijaId) 
VALUES ('Salata', 1), 
('Pršut i sir', 1), 
('Juha', 1),
('Teletina', 2),
('Janjetina', 2),
('Hobotnica', 2),
('Musaka', 2),
('Peka', 2),
('Palačinke', 3),
('Sladoled', 3),
('Štrudel', 3); 

INSERT INTO konobari (ime, prezime) 
VALUES ('Ante', 'Antić'), 
('Mate', 'Matić'), 
('Jela', 'Jelić'),
('Ivan', 'Ivić'),
('Mara', 'Marić');

INSERT INTO stolovi (brojStola) 
VALUES (1), (2), (3), (4), (5); 

INSERT INTO narudzbe (jeloId, konobarId, stolId) 
VALUES (1, 1, 1), (5, 1, 1), 
(2, 2, 2), (4, 2, 2), (10, 2, 2), 
(3, 3, 3), (5, 3, 3), 
(4, 5, 5), (7, 5, 5), (9, 2, 5);

select * from narudzbe;

------------------------------------------

SELECT CONCAT(kon.ime, ' ', kon.prezime) 'konobar', st.brojStola 'stol', jela.naziv 'jelo' 
FROM narudzbe nar
INNER JOIN jela ON nar.jeloId = jela.id
INNER JOIN konobari kon ON nar.konobarId = kon.id
INNER JOIN stolovi st ON nar.stolId = st.id;

SELECT st.brojStola 'stol', COUNT(*) 'broj narudzbi'
FROM narudzbe nar
INNER JOIN stolovi st ON nar.stolId = st.id
GROUP BY st.id;


DELIMITER $$
CREATE PROCEDURE narudzbePoKategoriji()
BEGIN
	SELECT kat.naziv 'kategorija jela', COUNT(*) 'broj narudzbi'
	FROM narudzbe nar
	INNER JOIN jela ON nar.jeloId = jela.id
    INNER JOIN kategorijeJela kat ON jela.kategorijaId = kat.id
	GROUP BY kat.id;	
END$$
DELIMITER ;

CALL narudzbePoKategoriji();


CREATE OR REPLACE VIEW stoloviBezNarudzbi AS
SELECT DISTINCT st.brojStola 'stolovi bez narudzbi', nar.id
FROM stolovi st
LEFT JOIN narudzbe nar ON nar.stolId = st.id
WHERE nar.id IS NULL;

SELECT * FROM stoloviBezNarudzbi;








