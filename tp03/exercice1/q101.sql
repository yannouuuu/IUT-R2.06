-- Q10.1. La fonction repeat permet de répéter un caractère n fois ( repeat(’*’,5)). Affichez l’histogramme des notes précédentes en affichant des * fonction des fréquences. (16 lignes)
SELECT note,
REPEAT('*', COUNT(*)::int) AS histogramme
FROM notes
WHERE mat = 'algo' AND numcont = 2
GROUP BY note
ORDER BY note;