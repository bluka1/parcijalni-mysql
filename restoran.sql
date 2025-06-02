CREATE DATABASE IF NOT EXISTS restoran;

CREATE TABLE IF NOT EXISTS konobari (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
ime VARCHAR(255) NOT NULL,
prezime VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS stolovi (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
broj INT UNSIGNED NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS kategorije_jela (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
naziv VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS jela (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
naziv VARCHAR(255) NOT NULL,
cijena DECIMAL(10, 2) NOT NULL,
kategorijaID INT UNSIGNED NOT NULL,
FOREIGN KEY (kategorijaID) REFERENCES kategorije_jela(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS narudzbe (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
konobarID INT UNSIGNED NOT NULL,
stolID INT UNSIGNED NOT NULL,
jeloID INT UNSIGNED NOT NULL,
FOREIGN KEY (konobarID) REFERENCES konobari(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (stolID) REFERENCES stolovi(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (jeloID) REFERENCES jela(id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO konobari (ime, prezime) 
VALUES
('Ana', 'Marić'),
('Ivan', 'Kovač'),
('Petra', 'Babić');

INSERT INTO stolovi (broj) 
VALUES
(1),
(2),
(3),
(4),
(5),
(6);

INSERT INTO kategorije_jela (naziv) 
VALUES
('Predjelo'),
('Glavno jelo'),
('Desert'),
('Piće');

INSERT INTO jela (naziv, cijena, kategorijaID) VALUES
('Juha', 4.50, 1),  
('Bečki odrezak', 9.80, 2), 
('Palačinke', 3.00, 3),  
('Fanta', 2.00, 4),  
('Pizza', 7.50, 2),  
('Čokoladni kolač', 5.00, 3);   

INSERT INTO narudzbe (konobarID, stolID, jeloID) VALUES
(1, 1, 1),  
(2, 2, 2), 
(3, 3, 3),  
(1, 1, 4),  
(2, 4, 5),  
(3, 3, 6);  

SELECT n.id 'ID narudžbe', CONCAT(k.ime, ' ', k.prezime) 'Konobar', s.broj 'Broj stola', j.naziv 'Jelo'
FROM narudzbe n
INNER JOIN konobari k ON k.id = n.konobarID
INNER JOIN stolovi s ON s.id = n.stolID
INNER JOIN jela j ON j.id = n.jeloID;

SELECT s.id 'Broj stola',
COUNT(n.id) 'Broj narudžbi po stolu'
FROM narudzbe n
INNER JOIN stolovi s ON s.id = n.stolID
GROUP BY s.id;

DELIMITER $$
CREATE PROCEDURE brojJelaPoNarudzbi ()
BEGIN
	SELECT k.id AS 'ID kategorije jela', k.naziv AS 'Kategorija jela',
	COUNT(n.id) AS 'Broj narudžbi po kategoriji'
	FROM narudzbe n
	INNER JOIN jela j ON n.jeloID = j.id
	INNER JOIN kategorije_jela k ON j.kategorijaID = k.id
	GROUP BY k.id, k.naziv;
END $$
DELIMITER ;

CALL brojJelaPoNarudzbi();

INSERT INTO stolovi (broj)
VALUES
(7);

CREATE VIEW stoloviBezNarudzbi AS
SELECT s.id 'ID_stola',
s.broj 'Broj_stola'
FROM stolovi s
LEFT JOIN narudzbe n ON s.id = n.stolID
WHERE n.id IS NULL;

SELECT * FROM stolovibeznarudzbi;
