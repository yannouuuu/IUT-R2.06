-- Q8. Lister les numetu et notes des etudiants au controle 2 d’algo , uniquement pour ceux qui ont obtenu plus que la moyenne non coefficientée de ce controle. (74 lignes)
SELECT numetu, note
FROM notes
WHERE mat = 'algo'
AND numcont = 2
AND note > (SELECT AVG(note)
            FROM notes
            WHERE mat = 'algo'
            AND numcont = 2);