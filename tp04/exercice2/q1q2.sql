-- Q1. On considère la requete suivante :
SELECT DISTINCT numetu
FROM notes AS n1
WHERE EXISTS (
    SELECT 1
    FROM notes AS n2
    WHERE n1.numetu = n2.numetu
    AND n2.note > 15
)

-- Q2. Qu’affiche cette requete ?
-- Cette requête affiche les numéros d'étudiants (numetu) qui ont obtenu au moins une note supérieure à 15 dans n'importe quelle matière ou contrôle.