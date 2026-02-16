-- Q4. Lister les étudiants qui n'ont pas de note au 1er contrôle de gestion (3 lignes)
SELECT numetu
FROM etudiants
WHERE numetu NOT IN (SELECT numetu
                     FROM notes
                     WHERE mat = 'gestion'
                     AND numcont = 1);