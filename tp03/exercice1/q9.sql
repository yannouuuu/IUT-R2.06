-- Q9. Lister le nombre de prénoms différents dans la promo (1 ligne, 1 colonne)
SELECT COUNT(DISTINCT prenom) as nb_prenoms
FROM etudiants;