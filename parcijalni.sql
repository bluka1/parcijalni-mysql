CREATE TABLE KategorijaJela (
    ID_Kategorije INT AUTO_INCREMENT PRIMARY KEY,
    Naziv VARCHAR(50) NOT NULL
);

CREATE TABLE Jelo (
    ID_Jela INT AUTO_INCREMENT PRIMARY KEY,
    Naziv VARCHAR(100) NOT NULL,
    ID_Kategorije INT,
    FOREIGN KEY (ID_Kategorije) REFERENCES KategorijaJela(ID_Kategorije)
);

CREATE TABLE Konobar (
    ID_Konobara INT AUTO_INCREMENT PRIMARY KEY,
    Ime VARCHAR(50),
    Prezime VARCHAR(50)
);

CREATE TABLE Stol (
    ID_Stola INT AUTO_INCREMENT PRIMARY KEY,
    BrojStola INT NOT NULL
);

CREATE TABLE Narudzba (
    ID_Narudzbe INT AUTO_INCREMENT PRIMARY KEY,
    ID_Jela INT,
    ID_Konobara INT,
    ID_Stola INT,
    DatumVrijeme DATETIME,
    FOREIGN KEY (ID_Jela) REFERENCES Jelo(ID_Jela),
    FOREIGN KEY (ID_Konobara) REFERENCES Konobar(ID_Konobara),
    FOREIGN KEY (ID_Stola) REFERENCES Sto(ID_Stola)
);


INSERT INTO KategorijaJela (Naziv) VALUES ('Predjelo'), ('Glavno jelo'), ('Desert');


INSERT INTO Jelo (Naziv, ID_Kategorije) VALUES ('Juha', 1), ('Piletina', 2), ('Torta', 3);


INSERT INTO Konobar (Ime, Prezime) VALUES ('Ivan', 'Ivić'), ('Ana', 'Anić');


INSERT INTO Stol (BrojStola) VALUES (1), (2), (3);


INSERT INTO Narudzba (ID_Jela, ID_Konobara, ID_Stola, DatumVrijeme) VALUES
(1, 1, 1, '2025-06-02 12:30:00'),
(2, 1, 1, '2025-06-02 12:45:00'),
(3, 2, 2, '2025-06-02 13:00:00');

SELECT n.ID_Narudzbe, k.Ime, k.Prezime, s.BrojStola, j.Naziv AS Jelo, n.DatumVrijeme
FROM Narudzba n
JOIN Konobar k ON n.ID_Konobara = k.ID_Konobara
JOIN Stol s ON n.ID_Stola = s.ID_Stola
JOIN Jelo j ON n.ID_Jela = j.ID_Jela;

SELECT s.BrojStola, COUNT(n.ID_Narudzbe) AS BrojNarudzbi
FROM Stol s
LEFT JOIN Narudzba n ON s.ID_Stola = n.ID_Stola
GROUP BY s.BrojStola;

DELIMITER //
CREATE PROCEDURE BrojNarudzbiPoKategoriji()
BEGIN
    SELECT kj.Naziv AS Kategorija, COUNT(n.ID_Narudzbe) AS BrojNarudzbi
    FROM Narudzba n
    JOIN Jelo j ON n.ID_Jela = j.ID_Jela
    JOIN KategorijaJela kj ON j.ID_Kategorije = kj.ID_Kategorije
    GROUP BY kj.Naziv;
END //
DELIMITER ;

SELECT s.BrojStola
FROM Stol s
LEFT JOIN Narudzba n ON s.ID_Stola = n.ID_Stola
WHERE n.ID_Narudzbe IS NULL;