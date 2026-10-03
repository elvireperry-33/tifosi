-- Création de la base de données Tifosi
CREATE DATABASE IF NOT EXISTS tifosi
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Sélection de la base de données Tifosi
USE tifosi;
-- Création de la table ingredient
CREATE TABLE ingredient (
    id_ingredient INT AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_ingredient),
    UNIQUE (nom)
);

-- Création de la table focaccia
CREATE TABLE focaccia (
    id_focaccia INT AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prix DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (id_focaccia),
    UNIQUE (nom)
);
-- Création de la table marque
CREATE TABLE marque (
    id_marque INT AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_marque),
    UNIQUE (nom)
);

-- Création de la table boisson
CREATE TABLE boisson (
    id_boisson INT AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    id_marque INT NOT NULL,
    PRIMARY KEY (id_boisson),
    UNIQUE (nom),
    CONSTRAINT fk_boisson_marque
        FOREIGN KEY (id_marque)
        REFERENCES marque(id_marque)
);
-- Création de la table client
CREATE TABLE client (
    id_client INT AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL,
    code_postal INT NOT NULL,
    PRIMARY KEY (id_client),
    UNIQUE (email)
);

-- Création de la table menu
CREATE TABLE menu (
    id_menu INT AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prix DECIMAL(5,2) NOT NULL,
    id_focaccia INT NOT NULL,
    PRIMARY KEY (id_menu),
    UNIQUE (nom),

    CONSTRAINT fk_menu_focaccia
        FOREIGN KEY (id_focaccia)
        REFERENCES focaccia(id_focaccia)
);
-- Table de liaison entre focaccia et ingredient
CREATE TABLE comprend (
    id_focaccia INT,
    id_ingredient INT,
    quantite INT NOT NULL,
    PRIMARY KEY (id_focaccia, id_ingredient),

    CONSTRAINT fk_comprend_focaccia
        FOREIGN KEY (id_focaccia)
        REFERENCES focaccia(id_focaccia),

    CONSTRAINT fk_comprend_ingredient
        FOREIGN KEY (id_ingredient)
        REFERENCES ingredient(id_ingredient)
);

-- Relation entre menu et boisson
CREATE TABLE contient (
    id_menu INT,
    id_boisson INT,
    PRIMARY KEY (id_menu, id_boisson),

    FOREIGN KEY (id_menu)
        REFERENCES menu(id_menu),

    FOREIGN KEY (id_boisson)
        REFERENCES boisson(id_boisson)
);

-- Relation entre client et menu
CREATE TABLE achete (
    id_client INT,
    id_menu INT,
    date_achat DATE NOT NULL,
    PRIMARY KEY (id_client, id_menu, date_achat),

    FOREIGN KEY (id_client)
        REFERENCES client(id_client),

    FOREIGN KEY (id_menu)
        REFERENCES menu(id_menu)
);
-- Création de l'utilisateur tifosi
CREATE USER IF NOT EXISTS 'tifosi'@'localhost'
IDENTIFIED BY 'tifosi123';

-- Attribution des droits sur la base tifosi
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';

FLUSH PRIVILEGES;