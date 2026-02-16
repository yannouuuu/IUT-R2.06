-- Q2. Créer une requête analyse croisée (pivot table), qui affiche un tableau 2D récapitulatif de la fréquence d’apparation de chaque prénom dans chaque groupe (155 lignes)
SELECT groupe,
       prenom,
       COUNT(*) AS frequence
FROM etudiants
GROUP BY groupe, prenom
ORDER BY groupe, prenom;