-- Q1. Lister les numetu à qui il manque des notes (7 lignes)
SELECT DISTINCT e.numetu
FROM etudiants e
WHERE EXISTS (
    SELECT *
    FROM controles c
    WHERE NOT EXISTS (
        SELECT *
        FROM notes n
        WHERE n.numetu = e.numetu
        AND n.mat = c.mat
        AND n.numcont = c.numcont
    )
);