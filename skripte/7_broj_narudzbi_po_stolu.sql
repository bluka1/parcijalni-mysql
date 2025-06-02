
SELECT 
    s.StolId AS BrojStola,
    COUNT(n.NarudzbaId) AS BrojNarudzbi
FROM 
    Stol s
LEFT JOIN Narudzba n ON s.StolId = n.StolId
GROUP BY s.StolId
ORDER BY BrojNarudzbi DESC;
