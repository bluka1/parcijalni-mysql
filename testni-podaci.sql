INSERT INTO kategorijeJela (naziv) VALUES ('Predjelo'), ('Glavno jelo'), ('Desert');

INSERT INTO jela (naziv, kategorijaId) VALUES 
('Juha od rajčice', 1),
('Pljukanci s tartufima i biftekom', 2),
('Tiramisu', 3);

INSERT INTO konobari (ime, prezime, spol) VALUES 
('Luka', 'Lukić', 'M'),
('Ana', 'Anić', 'Z');

INSERT INTO stolovi (broj) VALUES (1), (2), (3);

INSERT INTO narudzbe (jeloId, konobarId, stolId, datum) VALUES
(1, 1, 1, '2025-05-01'),
(2, 1, 1, '2025-05-01'),
(3, 2, 2, '2025-05-02');