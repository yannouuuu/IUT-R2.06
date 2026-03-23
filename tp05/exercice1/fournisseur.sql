/*fournisseur(fno,nom,prenom,adresse,tel)
produit(pno,libelle,couleur, poids)
commande(#fno,#pno,prix,qute)*/

CREATE TABLE fournisseur(
    fno serial,
    nom TEXT,
    prenom TEXT,
    adresse TEXT,
    int tel,
    CONSTRAINT pk_fournisseur PRIMARY KEY(fno)
);

CREATE TABLE produit(
    pno serial,
    libelle TEXT,
    couleur TEXT,
    poids int,
    CONSTRAINT pk_produit PRIMARY KEY(pno)
);

CREATE TABLE commande(
    fno int,
    pno int,
    prix int,
    qute int,
    constraint fk_fournisseur FOREIGN KEY(fno) REFERENCES fournisseur(fno),
    constraint fk_produit FOREIGN KEY(pno) REFERENCES produit(pno)
);

INSERT INTO fournisseur(nom, prenom) VALUES ('Dupont', 'paul'),('Durand','pierre'),('Lefebvre','jean');
INSERT INTO produit(libelle, couleur) VALUES ('Chaise','rouge'),('Bureau','gris'),('Armoire','blanc');

INSERT INTO commande (fno, pno, prix, qute)
VALUES
  (1, 1, 10.00,  2),
  (1, 2, 25.50,  5),
  (1, 3, 8.75,  11),
  (2, 1, 10.00,  3),
  (2, 2, 25.50,  7),
  (2, 3, 8.75,  14),
  (3, 1, 10.00,  6),
  (3, 2, 25.50,  9),
  (3, 3, 8.75,  20);

SELECT * FROM fournisseur
NATURAL JOIN produit, commande;