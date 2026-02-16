-- Q1. Créer une requête analyse croisée (pivot table), qui affiche un tableau 2D récapitulatif des moyennes par étudiants et par matière, avec uniquement 2 chiffres après la virgule. (770 lignes)
SELECT numetu,
       mat,
       ROUND(AVG(note), 2) AS moyenne
FROM notes
GROUP BY numetu, mat
ORDER BY numetu, mat;