SELECT 
    s.StolId AS BrojStola
FROM 
    Stol s
LEFT JOIN Narudzba n ON s.StolId = n.StolId
WHERE 
    n.NarudzbaId IS NULL;
