-- Q5. Lister les groupes avec leur nombre d’étudiants, ordonné par nombre croissant (6 lignes sans le )

SELECT groupe, COUNT(*) as nombre_etudiants
FROM etudiants
GROUP BY groupe
ORDER BY nombre_etudiants ASC;