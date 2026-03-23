-- Q7. Numéros d’étudiants qui ont une moyenne supérieure à 80% de la moyenne du meilleur étudiant (moyenne
-- non pondérée pour simplifier) (55 lignes)
SELECT numetu
FROM (
    SELECT numetu, AVG(note) as moyenne
    FROM notes
    GROUP BY numetu
) as moyennes_etudiants
WHERE moyenne > 0.8 * (
    SELECT MAX(moyenne)
    FROM (SELECT numetu, AVG(note) as moyenne FROM notes GROUP BY numetu) as moyennes
);