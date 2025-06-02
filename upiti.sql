-- sve naruzbe s imenima konobara, stolovima i nazivima jela
SELECT 
    k.ime 'Ime konobara',
    s.broj 'Broj Stola',
    j.naziv 'Naziv jela'
FROM narudzbe n
INNER JOIN konobari k ON n.konobarId = k.id
INNER JOIN stolovi s ON n.stolId = s.id
INNER JOIN jela j ON n.jeloId = j.id;

-- broj narudzbi po stolu
SELECT s.broj 'Broj stola', COUNT(*) 'Broj narudzbi po stolu'
FROM narudzbe n
INNER JOIN stolovi s ON n.stolId = s.id
GROUP BY s.broj;

-- procedura
DELIMITER $$
CREATE PROCEDURE narudzbePoKategorijiJela()
BEGIN
    SELECT k.naziv 'Kategorija jela', COUNT(*) 'Broj narudzbi'
    FROM narudzbe n
    INNER JOIN jela j ON n.jeloId = j.id
    INNER JOIN kategorijeJela k ON j.kategorijaId = k.id
    GROUP BY k.naziv;
END $$
DELIMITER ;

CALL narudzbePoKategorijiJela();

-- pogled
CREATE VIEW stoloviBezNarudzbi AS
SELECT s.broj 'Broj stola'
FROM stolovi s
LEFT JOIN narudzbe n ON s.id = n.stolId
WHERE n.id IS NULL;