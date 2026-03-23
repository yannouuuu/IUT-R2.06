-- Q8. Lister les prénoms les plus fréquents de base (et uniquement ceux là !) (1 ligne : 'Lucas')
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
);