-- Q4. nom et prenom des etudiants qui sont à la note maximum de la base (quelque soit le controle) (85 lignes)

SELECT e.nom, e.prenom
FROM etudiants e
JOIN notes n ON e.numetu = n.numetu
WHERE n.note = (SELECT MAX(note) FROM notes);