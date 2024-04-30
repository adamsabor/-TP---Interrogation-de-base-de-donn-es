-- Ecrire les requêtes SQL répondant aux questions suivantes :

-- Partie 1:

-- 1. Quels sont les noms et les adresses des pilotes ?
SELECT NOMPILOTE, ADRESSE 
FROM PILOTE;

-- 2. Quelles sont les différentes villes de départ ?
SELECT DISTINCT VILLEDEP 
FROM VOL;

-- 3. Quels sont les vols (numéro, villedep, villearr, heuredep, heurearr) au départ de Paris entre 14h et 16h ?
SELECT NUMVOL, VILLEDEP, VILLEARR, HEUREDEP, HEUREARR
FROM VOL
WHERE VILLEDEP = 'Paris' AND HEUREDEP BETWEEN '14:00' AND '16:00';

-- 4. Quels sont les avions de type Airbus ?
SELECT * 
FROM AVION 
WHERE NOMAVION LIKE 'Airbus%';

-- 5. Quels sont les pilotes dont le nom comprend un “i” en 2ème position ?
SELECT * 
FROM PILOTE 
WHERE NOMPILOTE LIKE '_i%';

-- 6. Quels sont les avions qui ont une capacité entre 200 et 300 passagers ?
SELECT * 
FROM AVION 
WHERE CAPACITE BETWEEN 200 AND 300;

-- 7. Quels sont les noms d’avion avec leur numéro et leur localisations (autre que Nice), ayant une capacité supérieure à 200 avec un tri décroissant sur le numéro ?
SELECT NOMAVION, NUMAVION, LOCALISATION 
FROM AVION
WHERE CAPACITE > 200 AND LOCALISATION <> 'Nice'
ORDER BY NUMAVION DESC;

-- 8. Quels sont les noms des pilotes qui assurent un vol au départ de Paris ?
SELECT DISTINCT NOMPILOTE
FROM PILOTE P
JOIN VOL V ON P.NUMPILOTE = V.NUMPILOTE
WHERE VILLEDEP = 'Paris';

-- 9. Quels sont les noms des pilotes qui habitent dans la ville de localisation d’un Airbus ?
SELECT DISTINCT NOMPILOTE
FROM PILOTE P
JOIN AVION A ON P.ADRESSE = A.LOCALISATION
WHERE NOMAVION LIKE 'Airbus%';

-- 10. Quels sont les noms des pilotes qui pilotent un avion piloté aussi par le pilote n°2 ?
SELECT DISTINCT P.NOMPILOTE
FROM PILOTE P
JOIN VOL V ON P.NUMPILOTE = V.NUMPILOTE
WHERE V.NUMAVION IN (SELECT NUMAVION FROM VOL WHERE NUMPILOTE = 2);

-- 11. Quels sont les avions (Numéro et Nom) dont la capacité est comprise entre 200 et 300 et dont la localisation correspond à la ville de départ du vol “USA050” ?
SELECT A.NUMAVION, A.NOMAVION
FROM AVION A
JOIN VOL V ON A.LOCALISATION = V.VILLEDEP
WHERE A.CAPACITE BETWEEN 200 AND 300 AND V.NUMVOL = 'USA050';

-- 12. Quels sont les avions dont la capacité est supérieure à toutes les capacités des avions localisés à Nice ?
SELECT *
FROM AVION A1
WHERE A1.CAPACITE > ALL (SELECT CAPACITE FROM AVION WHERE LOCALISATION = 'Nice');

-- 13. Quels sont les avions dont la capacité est supérieure à au moins celle d’un avion localisé à Nice ?
SELECT *
FROM AVION A1
WHERE A1.CAPACITE > ANY (SELECT CAPACITE FROM AVION WHERE LOCALISATION = 'Nice');

-- 14. Quels sont les pilotes qui habitent la ville de localisation d’un Airbus et qui sont en service au départ d’une ville desservie (Villearr) par Ader ?
SELECT DISTINCT P.NOMPILOTE
FROM PILOTE P
JOIN AVION A ON P.ADRESSE = A.LOCALISATION
JOIN VOL V ON P.NUMPILOTE = V.NUMPILOTE AND V.VILLEARR = 'Ader'
WHERE A.NOMAVION LIKE 'Airbus%';

-- Partie 2 :

-- 15. Quel est le nombre de pilotes différents en service ?
SELECT COUNT(DISTINCT NUMPILOTE) AS Nombre_Pilotes 
FROM VOL;

   -- 16. Quels sont les numéros d’avion dont la capacité est supérieure ou égale à la moyenne des avions localisés dans la même ville ?
   SELECT NUMAVION
FROM AVION
WHERE CAPACITE >= ALL (
  SELECT AVG(CAPACITE) FROM AVION AS A WHERE A.LOCALISATION = AVION.LOCALISATION
);

   -- 17. Quels sont les avions (Numéro et Nom) qui avec une augmentation de 10% de leur capacité ont une capacité supérieure à 250 ?
   SELECT NUMAVION, NOMAVION
FROM AVION
WHERE CAPACITE * 1.1 > 250;

    --18. Quels sont les pilotes dont le nom ressemble phonétiquement à “Blériaud” ? (fonction SOUNDEX)
    SELECT NUMPILOTE, NOMPILOTE
FROM PILOTE
WHERE SOUNDEX(NOMPILOTE) = SOUNDEX('Blériaud');
    --19. Quels sont les avions dont la capacité est supérieure à 10% de la moyenne des capacités des avions ?
SELECT NUMAVION
FROM AVION
WHERE CAPACITE > (SELECT AVG(CAPACITE) * 1.1 FROM AVION);

    --20. Pour chaque pilote en service, quel est le nombre de vols assurés ?
SELECT NUMPILOTE, COUNT(NUMVOL) AS Nombre_Vols
FROM VOL
GROUP BY NUMPILOTE;

   -- 21. Quelle est la capacité maximum des avions par ville de localisation ?
SELECT LOCALISATION, MAX(CAPACITE) AS Capacite_Max
FROM AVION
GROUP BY LOCALISATION;

    --22. Quelle est la capacité moyenne des avions par ville et par type ?
-- Note: Ajout d'une colonne TYPE dans la table AVION serait nécessaire pour exécuter cette requête exactement comme demandé.


    --23. Pour chaque ville de localisation sauf “Paris” de la compagnie, donner les capacités minimum et maximum des avions qui s’y trouvent ?


    --24. Quelle est la capacité moyenne des avions pour chaque ville ayant plus de 5 avions localisés ?



    --25. Quels sont les pilotes (avec leur nombre de vols) parmis 1, 4,9 et 12 qui assurent plus de 3 vols ?
