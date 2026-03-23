-- Q6. Réécrire la requete sous une forme simplifiée
SELECT DISTINCT numetu
FROM notes
GROUP BY numetu
HAVING AVG(note) <= 10;