-- Q10. Afficher pour le controle 2 d’algo la fréquence de chaque note, ordonnée par note. (16 lignes)
SELECT note, COUNT(*) as frequence
FROM notes
WHERE mat = 'algo' AND numcont = 2
GROUP BY note
ORDER BY note;