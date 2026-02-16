-- Q6.1. Ils n’ont pas l’air si petits que ça ces noms! Affichez l’inverse (51 lignes)
SELECT nom
FROM etudiants
WHERE LENGTH(nom) > (SELECT AVG(LENGTH(nom)) FROM etudiants);