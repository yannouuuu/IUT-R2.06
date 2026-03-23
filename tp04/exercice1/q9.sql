-- Q9. Noms des étudiants qui ont le(s) prénom(s) le(s) plus fréquent(s) (si c’est Alexandre et Julien les plus
-- fréquents on veut les noms des Alexandre et des Julien) (6 lignes)

SELECT nom
FROM etudiants
WHERE prenom IN (
    SELECT prenom
    FROM etudiants
    GROUP BY prenom
    HAVING COUNT(*) = (
        SELECT MAX(cnt)
        FROM (
            SELECT COUNT(*) as cnt
            FROM etudiants
            GROUP BY prenom
        ) as frequence
    )
);