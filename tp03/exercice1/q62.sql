-- Q6.2. Afficher le nom le plus long (et uniquement celui là) (1 ligne)
SELECT nom
FROM etudiants
WHERE LENGTH(nom) = (SELECT MAX(LENGTH(nom)) FROM etudiants);