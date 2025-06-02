SELECT 
    n.NarudzbaId,
    k.Ime AS KonobarIme,
    k.Prezime AS KonobarPrezime,
    s.StolId AS BrojStola,
    j.Naziv AS NazivJela
FROM 
    Narudzba n
INNER JOIN Konobar k ON n.KonobarId = k.KonobarId
INNER JOIN Stol s ON n.StolId = s.StolId
INNER JOIN Jelo j ON n.JeloId = j.JeloId
ORDER BY n.NarudzbaId;