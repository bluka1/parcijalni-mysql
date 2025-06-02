CREATE DATABASE IF NOT EXISTS restoran;
USE restoran;

-- Tablica Konobar
CREATE TABLE Konobar (
    KonobarId INT AUTO_INCREMENT PRIMARY KEY,
    Ime VARCHAR(50),
    Prezime VARCHAR(50)
);

-- Tablica Stol
CREATE TABLE Stol (
    StolId INT AUTO_INCREMENT PRIMARY KEY,
    KonobarId INT,
    FOREIGN KEY (KonobarId) REFERENCES Konobar(KonobarId)
);

-- Tablica Kategorija
CREATE TABLE Kategorija (
    KategorijaId INT AUTO_INCREMENT PRIMARY KEY,
    Naziv VARCHAR(100)
);

-- Tablica Jelo
CREATE TABLE Jelo (
    JeloId INT AUTO_INCREMENT PRIMARY KEY,
    Naziv VARCHAR(100),
    KategorijaId INT,
    FOREIGN KEY (KategorijaId) REFERENCES Kategorija(KategorijaId)
);

-- Tablica Narudzba
CREATE TABLE Narudzba (
    NarudzbaId INT AUTO_INCREMENT PRIMARY KEY,
    KonobarId INT,
    JeloId INT,
    StolId INT,
    FOREIGN KEY (KonobarId) REFERENCES Konobar(KonobarId),
    FOREIGN KEY (JeloId) REFERENCES Jelo(JeloId),
    FOREIGN KEY (StolId) REFERENCES Stol(StolId)
);
