-- Q4.  Créer une requête analyse croisée, qui affiche un tableau 2D récapitulatif du nombre d’étudiants par note et par groupe (105 lignes)
SELECT e.groupe,
       n.note,
       COUNT(*) AS nombre_etudiants
FROM notes n
JOIN etudiants e ON n.numetu = e.numetu
GROUP BY e.groupe, n.note
ORDER BY e.groupe, n.note;