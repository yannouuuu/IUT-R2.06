-- Q7. Lister les noms des matières qui ont autant de controles qu’algo (3 lignes)
SELECT mat
FROM controles
GROUP BY mat
HAVING COUNT(*) = (SELECT COUNT(*)
                   FROM controles
                   WHERE mat = 'algo');