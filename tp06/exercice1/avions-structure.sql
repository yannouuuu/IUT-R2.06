/*avion(ano, type, places, compagnie)
pilote(pno, nom, prenom, adressep)
aeroport(rno, libelle, ville, adressea)
ligne(lno, depart*, arrivee*)
vol(ano*, pno*, lno*, hdep, harr)*/

CREATE TABLE avion (
    ano       serial,
    type      text,
    places    int,
    compagnie text,
    CONSTRAINT pk_avion PRIMARY KEY (ano)
);

CREATE TABLE pilote (
    pno      serial,
    nom      text,
    prenom   text,
    adressep text,
    CONSTRAINT pk_pilote PRIMARY KEY (pno)
);

CREATE TABLE aeroport (
    rno      serial,
    libelle  text,
    ville    text,
    adressea text,
    CONSTRAINT pk_aeroport PRIMARY KEY (rno)
);

CREATE TABLE ligne (
    lno    serial,
    depart  int,
    arrivee int,
    CONSTRAINT pk_ligne    PRIMARY KEY (lno),
    CONSTRAINT fk_depart   FOREIGN KEY (depart)  REFERENCES aeroport(rno),
    CONSTRAINT fk_arrivee  FOREIGN KEY (arrivee) REFERENCES aeroport(rno)
);

CREATE TABLE vol (
    ano  int,
    pno  int,
    lno  int,
    hdep TIME,
    harr TIME,
    CONSTRAINT pk_vol  PRIMARY KEY (ano, pno, lno),
    CONSTRAINT fk_ano  FOREIGN KEY (ano) REFERENCES avion(ano),
    CONSTRAINT fk_pno  FOREIGN KEY (pno) REFERENCES pilote(pno),
    CONSTRAINT fk_lno  FOREIGN KEY (lno) REFERENCES ligne(lno)
);

TRUNCATE vol, ligne, aeroport, pilote, avion RESTART IDENTITY CASCADE;

-- Création des tables temporaires
CREATE TEMP TABLE noms (nom text);
CREATE TEMP TABLE prenoms (prenom text);
CREATE TEMP TABLE adresses (adresse text);

-- Insertion des valeurs
INSERT INTO noms VALUES
    ('Haddock'),
    ('Tournesol'),
    ('Bergamotte'),
    ('Lampion');

INSERT INTO prenoms VALUES
    ('Tryphon'),
    ('Archibald'),
    ('Hippolyte'),
    ('Séraphin');

INSERT INTO adresses VALUES
    ('Moulinsart'),
    ('Sbrodj'),
    ('Bruxelles'),
    ('Klow');

SELECT nom, prenom, adresse
FROM noms
CROSS JOIN prenoms
CROSS JOIN adresses;

/* Ça génère 4 × 4 × 4 = 64 combinaisons toutes différentes.
Le CROSS JOIN combine chaque ligne de chaque table avec toutes les lignes des autres tables —
   c'est exactement le produit cartésien, sans aucune condition de jointure.
 */

INSERT INTO pilote (nom, prenom, adressep)
SELECT nom, prenom, adresse
FROM noms
CROSS JOIN prenoms
CROSS JOIN adresses;

ALTER SEQUENCE pilote_pno_seq RESTART WITH 100;
/*\d pilote pour verifier le nom de la sequence qu'on a besoin*/
INSERT INTO pilote (nom, prenom, adressep) VALUES ('Test', 'Test', 'Test');
SELECT * FROM pilote WHERE pno >= 100;

INSERT INTO avion VALUES(105, 'A320', 300, 'AIR FRANCE');
INSERT INTO avion VALUES(106, 'A380', 320, 'LUFTHANSA');
INSERT INTO avion VALUES(107, 'B747', 500, 'AIR FRANCE');
INSERT INTO avion VALUES(108, 'A320', 300, 'TWA');
INSERT INTO avion VALUES(109, 'B747', 450, 'PANAM');
INSERT INTO avion VALUES(110, 'A320', 300, 'IBERAMIA');
INSERT INTO avion VALUES(111, 'A320', 300, NULL);


CREATE TABLE compagnies AS
SELECT DISTINCT compagnie
FROM avion;

CREATE TABLE modeles AS
SELECT type, MAX(places) AS places
FROM avion
GROUP BY type;

CREATE SEQUENCE numeros START 130 ;

CREATE SEQUENCE numeros START 130;

INSERT INTO avion (ano, type, places, compagnie)
SELECT nextval('numeros'), m.type, m.places, c.compagnie
FROM modeles m
CROSS JOIN compagnies c;

INSERT INTO aeroport(rno, libelle, ville) VALUES ('JFK','John Fitzgerald Kennedy','New-York') ;
INSERT INTO aeroport(rno, libelle,ville) VALUES ('CDG', 'Roissy Charles de Gaulles','Paris') ;
INSERT INTO aeroport(rno, libelle,ville) VALUES ('MAD', 'Madrid Barajas','Madrid') ;
INSERT INTO aeroport(rno, libelle) VALUES ('BRU', 'Bruxelles') ;
INSERT INTO aeroport(rno, libelle) VALUES ('GVA', 'Genève') ;
INSERT INTO aeroport(rno, libelle, ville) VALUES ('ORY', 'Orly', 'Paris') ;
INSERT INTO aeroport(rno, libelle) VALUES ('LAI', 'Lannion') ;
INSERT INTO aeroport(rno, libelle, ville) VALUES ('LIL', 'Lille-Lesquin', 'Lille') ;

UPDATE aeroport
SET ville = libelle
WHERE ville IS NULL;

CREATE SEQUENCE lignes START 1000;

INSERT INTO ligne (lno, depart, arrivee)
SELECT nextval('lignes'), a1.rno, a2.rno
FROM aeroport a1
CROSS JOIN aeroport a2
WHERE a1.rno <> a2.rno;

INSERT INTO vol (ano, pno, lno)
SELECT a.ano, p.pno, l.lno
FROM ligne l
CROSS JOIN pilote p
CROSS JOIN avion a
WHERE (l.depart IN ('CDG', 'JFK', 'MAD') OR l.arrivee IN ('CDG', 'JFK', 'MAD'))
  AND p.pno % 7 = 0
  AND a.type ILIKE 'A%'
  AND a.compagnie = 'AIR FRANCE';

UPDATE vol
SET hdep = '14:10',
    harr = '16:25'
WHERE pno = 28
  AND lno IN (
      SELECT l.lno
      FROM ligne l
      WHERE l.depart = 'CDG' AND l.arrivee = 'JFK'
  )
  AND ano IN (
      SELECT a.ano
      FROM avion a
      WHERE a.type ILIKE 'A380%'
      AND a.compagnie = 'AIR FRANCE'
  );

-- Créer et remplir la table chomeurs
CREATE TABLE chomeurs AS
SELECT pno, nom, prenom, adressep AS adresse
FROM pilote
WHERE pno NOT IN (
    SELECT DISTINCT pno FROM vol
);

-- Supprimer ces pilotes de la table pilote
DELETE FROM pilote
WHERE pno NOT IN (
    SELECT DISTINCT pno FROM vol
);


DELETE FROM ligne
WHERE (depart = 'LAI' OR arrivee = 'LAI')
  AND depart NOT IN ('ORY', 'CDG')
  AND arrivee NOT IN ('ORY', 'CDG');

CREATE TABLE correspondances AS
SELECT l1.depart, l2.arrivee, l1.arrivee AS escale, l1.lno AS lno1, l2.lno AS lno2
FROM ligne l1
JOIN ligne l2 ON l1.arrivee = l2.depart
WHERE l1.depart <> l2.arrivee
  AND NOT EXISTS (
      SELECT 1 FROM ligne l3
      WHERE l3.depart = l1.depart
        AND l3.arrivee = l2.arrivee
  );

SELECT DISTINCT p.pno, p.nom, p.prenom
FROM pilote p
JOIN vol v ON p.pno = v.pno
JOIN ligne l ON v.lno = l.lno
JOIN aeroport a ON (a.rno = l.depart OR a.rno = l.arrivee)
WHERE a.ville = p.adressep;

SELECT p.pno, p.nom, p.prenom
FROM pilote p
WHERE NOT EXISTS (
    SELECT 1
    FROM vol v
    JOIN ligne l ON v.lno = l.lno
    WHERE v.pno = p.pno
      AND NOT EXISTS (
          SELECT 1
          FROM aeroport a
          WHERE (a.rno = l.depart OR a.rno = l.arrivee)
            AND a.ville = p.adressep
      )
);


SELECT p.pno, p.nom, p.prenom, COUNT(*) AS nb_trajets
FROM pilote p
JOIN vol v ON p.pno = v.pno
JOIN ligne l ON v.lno = l.lno
WHERE l.depart = 'MAD' AND l.arrivee = 'CDG'
GROUP BY p.pno, p.nom, p.prenom
ORDER BY nb_trajets DESC
LIMIT 1;

CREATE TABLE carriere AS
SELECT p.pno, COUNT(DISTINCT v.lno) AS nombre
FROM pilote p
JOIN vol v ON p.pno = v.pno
GROUP BY p.pno;