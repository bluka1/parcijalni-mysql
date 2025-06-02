DELIMITER //

CREATE PROCEDURE BrojNarudzbiPoKategoriji()
BEGIN
    SELECT 
        k.Naziv AS Kategorija,
        COUNT(n.NarudzbaId) AS BrojNarudzbi
    FROM 
        Kategorija k
    LEFT JOIN Jelo j ON k.KategorijaId = j.KategorijaId
    LEFT JOIN Narudzba n ON j.JeloId = n.JeloId
    GROUP BY k.KategorijaId, k.Naziv
    ORDER BY BrojNarudzbi DESC;
END //

DELIMITER ;