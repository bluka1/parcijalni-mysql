CREATE DATABASE IF NOT EXISTS restoran;

USE restoran;

CREATE TABLE IF NOT EXISTS kategorijeJela (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    vrsta VARCHAR(255) NOT NULL, 
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS jela (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    naziv VARCHAR(255) NOT NULL,
    kategorijaId INT UNSIGNED NOT NULL,
    cijena INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (kategorijaId) REFERENCES kategorijeJela(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS konobari (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    ime VARCHAR(255) NOT NULL,
    prezime VARCHAR(255) NOT NULL,
    narudzbaId INT UNSIGNED NOT NULL,
    stolId INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (stolId) REFERENCES stolovi(id) ON DELETE CASCADE,
    FOREIGN KEY (narudzbaId) REFERENCES narudzbe(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS stolovi (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    konobarId INT UNSIGNED NOT NULL,
    narudzbaId INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (narudzbaId) REFERENCES narudzbe(id) ON DELETE CASCADE, 
    FOREIGN KEY (konobarId) REFERENCES konobari(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS narudzbe (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    jeloId INT UNSIGNED NOT NULL,
    stolId INT UNSIGNED NOT NULL,
    konobarId INT UNSIGNED NOT NULL,
    vrijemeNarudzbe TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (jeloId) REFERENCES jela(id) ON DELETE CASCADE,
    FOREIGN KEY (stolId) REFERENCES stolovi(id) ON DELETE CASCADE,
    FOREIGN KEY (konobarId) REFERENCES konobari(id) ON DELETE CASCADE
);

INSERT INTO kategorijeJela (vrsta) 
VALUES ('predjelo'), 
('glavno jelo'), 
('desert');

INSERT INTO jela (naziv, kategorijaId, cijena) 
VALUES ('pizza margherita', 2, 8), 
('pohana piletina', 2, 10),
 ('ledene kocke', 3, 7), 
('juneca juha', 1, 6),
('restani krumpir', 1, 5),
('svinjska rebra', 2, 10), 
('Piletina na zaru', 2, 12),
('kuhana junetina', 2, 9), 
('sladoled', 3, 2), 
('pita', 1, 6);

INSERT INTO narudzbe (jeloId, stolId, konobarId, vrijemeNarudzbe)
VALUES (1, 1, 1, '2025-01-01 12:00:00'),
(2, 2, 2, '2025-01-01 13:00:00'),
(3, 3, 3, '2025-01-01 14:00:00'),
(4, 4, 4, '2025-01-01 15:00:00'),
(5, 5, 5, '2025-01-01 16:00:00'),
(6, 6, 6, '2025-01-01 17:00:00'),
(7, 7, 7, '2025-01-01 18:00:00');
