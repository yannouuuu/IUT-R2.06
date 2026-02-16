-- Q2. Lister les numetu qui sont dans le même groupe que l’étudiant 111 (26 lignes)
-- Avec jointure
SELECT e1.numetu
FROM etudiants AS e1, etudiants AS e2
WHERE e1.groupe = e2.groupe
AND e2.numetu = 111;