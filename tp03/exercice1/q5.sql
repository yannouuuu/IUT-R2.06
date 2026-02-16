-- Q5. Lister les noms et prénoms des étudiants qui n'ont passé aucun controle (2 lignes)
SELECT nom, prenom
FROM etudiants
WHERE numetu NOT IN (SELECT numetu
                     FROM notes);