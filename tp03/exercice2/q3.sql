-- Q3. Créer une requête analyse croisée, qui affiche un tableau 2D récapitulatif des moyennes par groupe et par matière, 2 chiffres après la virgule (35 lignes)
SELECT e.groupe,
       n.mat,
       ROUND(AVG(n.note), 2) AS moyenne
FROM notes n
JOIN etudiants e ON n.numetu = e.numetu
GROUP BY e.groupe, n.mat
ORDER BY e.groupe, n.mat;