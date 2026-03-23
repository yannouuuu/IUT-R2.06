-- Q6. Lister uniquement le nom du (ou des) groupes qui a le moins d’étudiants ( lignes)

SELECT groupe
FROM etudiants
GROUP BY groupe
HAVING COUNT(*) <= ALL (
    SELECT COUNT(*)
    FROM etudiants
    GROUP BY groupe
);