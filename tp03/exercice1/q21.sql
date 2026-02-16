-- Q2. Lister les numetu qui sont dans le même groupe que l’étudiant 111 (26 lignes)
-- Avec sous requete
SELECT numetu
FROM etudiants
WHERE groupe=(SELECT groupe
							FROM etudiants
							WHERE numetu = 111);