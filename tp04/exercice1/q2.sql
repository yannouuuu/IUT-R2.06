-- Q2. Lister les identifiants des controles qui ont des absents (12 lignes)
SELECT DISTINCT c.mat, c.numcont
FROM controles c
WHERE EXISTS (
    SELECT *
    FROM etudiants e
    WHERE NOT EXISTS (
        SELECT *
        FROM notes n
        WHERE n.numetu = e.numetu
        AND n.mat = c.mat
        AND n.numcont = c.numcont
    )
);