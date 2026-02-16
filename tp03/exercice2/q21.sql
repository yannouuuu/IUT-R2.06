-- Q2.1. idem mais uniquement pour les compteurs supérieurs à 1 (1 ligne, 1 colonne)
SELECT groupe,
       prenom,
       COUNT(*) AS frequence
FROM etudiants
GROUP BY groupe, prenom
HAVING COUNT(*) > 1
ORDER BY groupe, prenom;