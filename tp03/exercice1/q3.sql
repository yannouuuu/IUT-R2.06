-- Q3. Liste des numetu qui ont au 2ème controle de Math, une note inférieure à 80% de la moyenne de ce controle (41 lignes)
SELECT numetu
FROM notes
WHERE mat = 'maths'
AND numcont = 2
AND note < 0.8 * (SELECT AVG(note)
                  FROM notes
                  WHERE mat = 'maths'
                  AND numcont = 2);