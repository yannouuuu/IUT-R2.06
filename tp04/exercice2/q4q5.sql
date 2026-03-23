-- Q4. On considère la requete suivante :
SELECT DISTINCT numetu
FROM notes
WHERE numetu NOT IN (
    SELECT numetu
    FROM notes
    GROUP BY numetu
    HAVING AVG(note)> 10
)

-- Q5. Qu’affiche cette requete ?
-- Ca affiche les numéros d'étudiants (numetu) qui ont au moins une note, mais dont la moyenne de toutes les notes est inférieure ou égale à 10 donc les étudiants qui n’ont pas la moyenne.