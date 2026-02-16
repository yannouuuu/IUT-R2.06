-- Q6. Lister les noms des etudiants dont le nom a une taille inférieure à la moyenne des noms (length(chaine) permet d’avoir la taille d’une chaine) (105 lignes)
SELECT nom
FROM etudiants
WHERE LENGTH(nom) < (SELECT AVG(LENGTH(nom)) FROM etudiants);