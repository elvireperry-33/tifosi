USE tifosi;

-- 1. Afficher la liste des noms des focaccias
-- par ordre alphabétique croissant

SELECT nom
FROM focaccia
ORDER BY nom ASC;
-- Résultat attendu : 8 focaccias classées par ordre alphabétique.
-- Résultat obtenu : 8 focaccias classées par ordre alphabétique.
-- Commentaire : aucun écart constaté.
-- 2. Afficher le nombre total d'ingrédients

SELECT COUNT(*) AS nombre_total_ingredients
FROM ingredient;
-- Résultat attendu : 25 ingrédients.
-- Résultat obtenu : 25 ingrédients.
-- Commentaire : aucun écart constaté.
-- 3. Afficher le prix moyen des focaccias

SELECT AVG(prix) AS prix_moyen
FROM focaccia;
-- Résultat attendu : un prix moyen de 10,35 €.
-- Résultat obtenu : un prix moyen de 10,35 €.
-- Commentaire : aucun écart constaté.
-- 4. Afficher la liste des boissons avec leur marque,
-- triée par nom de boisson

SELECT boisson.nom AS boisson, marque.nom AS marque
FROM boisson
JOIN marque ON boisson.id_marque = marque.id_marque
ORDER BY boisson.nom ASC;
-- Résultat attendu : 12 boissons avec leur marque, triées par nom de boisson.
-- Résultat obtenu : 12 boissons avec leur marque, triées par nom de boisson.
-- Commentaire : aucun écart constaté.
-- 5. Afficher la liste des ingrédients pour une Raclaccia

SELECT ingredient.nom AS ingredient
FROM ingredient
JOIN comprend ON ingredient.id_ingredient = comprend.id_ingredient
JOIN focaccia ON comprend.id_focaccia = focaccia.id_focaccia
WHERE focaccia.nom = 'Raclaccia';
-- Résultat attendu : 7 ingrédients pour la Raclaccia.
-- Résultat obtenu : 7 ingrédients pour la Raclaccia.
-- Commentaire : aucun écart constaté.
-- 6. Afficher le nom et le nombre d'ingrédients pour chaque focaccia

SELECT focaccia.nom AS focaccia,
       COUNT(comprend.id_ingredient) AS nombre_ingredients
FROM focaccia
JOIN comprend ON focaccia.id_focaccia = comprend.id_focaccia
GROUP BY focaccia.id_focaccia, focaccia.nom;
-- Résultat attendu : chaque focaccia avec son nombre d'ingrédients.
-- Résultat obtenu : chaque focaccia apparaît avec son nombre d'ingrédients.
-- Commentaire : aucun écart constaté.
-- 7. Afficher le nom de la focaccia qui a le plus d'ingrédients

SELECT focaccia.nom AS focaccia,
       COUNT(comprend.id_ingredient) AS nombre_ingredients
FROM focaccia
JOIN comprend ON focaccia.id_focaccia = comprend.id_focaccia
GROUP BY focaccia.id_focaccia, focaccia.nom
ORDER BY nombre_ingredients DESC
LIMIT 1;
-- Résultat attendu : Paysanne avec 11 ingrédients.
-- Résultat obtenu : Paysanne avec 11 ingrédients.
-- Commentaire : aucun écart constaté.
-- 8. Afficher la liste des focaccias qui contiennent de l'ail

SELECT DISTINCT focaccia.nom AS focaccia
FROM focaccia
JOIN comprend ON focaccia.id_focaccia = comprend.id_focaccia
JOIN ingredient ON comprend.id_ingredient = ingredient.id_ingredient
WHERE ingredient.nom = 'Ail';
-- Résultat attendu : 3 focaccias contenant de l'ail.
-- Résultat obtenu : 3 focaccias contenant de l'ail.
-- Commentaire : aucun écart constaté.
-- 9. Afficher la liste des ingrédients inutilisés

SELECT ingredient.nom AS ingredient
FROM ingredient
LEFT JOIN comprend
ON ingredient.id_ingredient = comprend.id_ingredient
WHERE comprend.id_ingredient IS NULL;
-- Résultat attendu : 3 focaccias contenant de l'ail.
-- Résultat obtenu : 3 focaccias contenant de l'ail.
-- Commentaire : aucun écart constaté.
-- 10. Afficher la liste des focaccias qui n'ont pas de champignons

SELECT focaccia.nom AS focaccia
FROM focaccia
WHERE NOT EXISTS (
    SELECT 1
    FROM comprend
    JOIN ingredient
    ON comprend.id_ingredient = ingredient.id_ingredient
    WHERE comprend.id_focaccia = focaccia.id_focaccia
    AND ingredient.nom = 'Champignon'
);
-- Résultat attendu : les focaccias qui ne contiennent pas de champignons.
-- Résultat obtenu : les focaccias sans champignons sont correctement affichées.
-- Commentaire : aucun écart constaté.