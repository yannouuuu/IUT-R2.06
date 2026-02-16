-- Q1. Calculer la moyenne coefficientée par numetu (154 lignes)
SELECT numetu, ROUND(SUM(note*coeff)*1.0/SUM(coeff),2)
FROM notes AS n, controles AS c
WHERE c.mat = n.mat
AND n.numcont = c.numcont
GROUP BY numetu;