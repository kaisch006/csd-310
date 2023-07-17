/*
    Title: db_init_outland_adventures
    Author(s) in Alphabetical Order: Christopher Kaiser, Estiven Hernandez, Juan Taylor, Julia Gonzalez, Michelle Choe
    Date: 9 July 2023
    Description: outland adventures initialization script.
*/

-- drop database user if exists 
DROP USER IF EXISTS 'outland_adventures_user'@'localhost';


-- create movies_user and grant them all privileges to the movies database 
CREATE USER 'outland_adventures_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'cheese1';

-- grant all privileges to the movies database to user movies_user on localhost 
GRANT ALL PRIVILEGES ON outland_adventures.* TO 'outland_adventures_user'@'localhost';

-- drop tables if they are present
DROP TABLE IF EXISTS clients_attending_trip;
DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS guides;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS clients;


-- create clients table
CREATE TABLE clients (
    client_id 	   INT 	  UNIQUE 	   AUTO_INCREMENT  NOT NULL,
    first_name 	   VARCHAR(20),
    last_name 	   VARCHAR(20),
    past_trips 	   VARCHAR(55),

    PRIMARY KEY (client_id)
);

-- create inventory table
CREATE TABLE inventory (
    inventory_id   INT             NOT NULL	   AUTO_INCREMENT,
    product_name 	   VARCHAR(50) 	   NOT NULL,
    purchase_cost 	   float 	   NOT NULL,
    rental_cost 	   float 	   NOT NULL,
    equip_type 	   ENUM('Hiking', 'Camping') 	   NOT NULL,

    PRIMARY KEY (inventory_id)
);

-- create equipment table
CREATE TABLE equipment (
    equipment_id   INT             NOT NULL	   AUTO_INCREMENT,
    client_id 	   INT	   	   NOT NULL,
    inventory_id 	   INT	   	   NOT NULL,
    restock_date     DATE NOT NULL,
    equip_expired  ENUM('Yes', 'No')	   NOT NULL,
    equip_status   ENUM('Purchased', 'Rented'),
  
    PRIMARY KEY (equipment_id),

    CONSTRAINT fk_clients    
    FOREIGN KEY (client_id) 
        REFERENCES clients(client_id),

    CONSTRAINT fk_inventory    
    FOREIGN KEY (inventory_id) 
        REFERENCES inventory(inventory_id)
);

-- create guides table
CREATE TABLE guides (
    guide_id       INT             NOT NULL        AUTO_INCREMENT,
    first_name     VARCHAR(15)     NOT NULL,
    last_name      VARCHAR(15)     NOT NULL,

    PRIMARY KEY(guide_id)
);

-- create country table
CREATE TABLE country (
    country_id     INT             NOT NULL        AUTO_INCREMENT,
    country_name   VARCHAR(15)     NOT NULL,
    continent   VARCHAR(15)     NOT NULL,

    PRIMARY KEY(country_id)
);

-- create trips table
CREATE TABLE trips (
    trip_id        INT             NOT NULL        AUTO_INCREMENT,
    guide_id       INT             NOT NULL,
    country_id     INT             NOT NULL,
    trip_name      VARCHAR(50)     NOT NULL,
    trip_date      DATE,

    PRIMARY KEY(trip_id),

    CONSTRAINT fk_guides
    FOREIGN KEY(guide_id)
        REFERENCES guides(guide_id),

    CONSTRAINT fk_country
    FOREIGN KEY(country_id)
        REFERENCES country(country_id)
); 

-- create clients_attending trips table
CREATE TABLE clients_attending_trip (
    client_id   	   INT,
    trip_id   	   INT,

    PRIMARY KEY(client_id, trip_id),

    CONSTRAINT fk_clients_attending_trip
    FOREIGN KEY(client_id)
        REFERENCES clients(client_id),

    CONSTRAINT fk_trips
    FOREIGN KEY(trip_id)
        REFERENCES trips(trip_id)
);


-- insert clients records
INSERT INTO clients(first_name, last_name, past_trips)
    VALUES('Earl', 'Shaffer', NULL);

INSERT INTO clients(first_name, last_name, past_trips)
    VALUES('Alex', 'Honnold', 'Spain');

INSERT INTO clients(first_name, last_name, past_trips)
    VALUES('Grandma', 'Gatewood', 'Italy');

INSERT INTO clients(first_name, last_name, past_trips)
    VALUES('Jennifer', 'Pharr Davis', 'Thailand, Italy');

INSERT INTO clients(first_name, last_name, past_trips)
    VALUES('Bill', 'Irwin', NULL);

INSERT INTO clients(first_name, last_name, past_trips)
    VALUES('Cheryl', 'Strayed', 'Egypt, Japan');


-- insert inventory records
INSERT INTO inventory(product_name, purchase_cost, rental_cost, equip_type)
    VALUES('Tent', 159.99, 55.00, 'Camping');

INSERT INTO inventory(product_name, purchase_cost, rental_cost, equip_type)
    VALUES('Lantern', 29.99, 10.00, 'Camping');

INSERT INTO inventory(product_name, purchase_cost, rental_cost, equip_type)
    VALUES('Sleeping Bag', 49.99, 25.99, 'Camping');

INSERT INTO inventory(product_name, purchase_cost, rental_cost, equip_type)
    VALUES('Backpack', 24.99, 15.00, 'Hiking');

INSERT INTO inventory(product_name, purchase_cost, rental_cost, equip_type)
    VALUES('Trail Boots', 54.99, 30.00, 'Hiking');

INSERT INTO inventory(product_name, purchase_cost, rental_cost, equip_type)
    VALUES('GPS', 297.95, 100.00, 'Hiking');


-- create equipment table
INSERT INTO equipment(client_id, inventory_id, restock_date, equip_expired, equip_status)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Grandma'), (SELECT inventory_id FROM inventory WHERE product_name = 'Lantern'), '2016-05-15', 'Yes', 'Purchased');

INSERT INTO equipment(client_id, inventory_id, restock_date, equip_expired, equip_status)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Grandma'), (SELECT inventory_id FROM inventory WHERE product_name = 'GPS'), '2006-07-26', 'Yes', 'Purchased');

INSERT INTO equipment(client_id, inventory_id, restock_date, equip_expired, equip_status)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Grandma'), (SELECT inventory_id FROM inventory WHERE product_name = 'Sleeping Bag'), '2019-02-11', 'No', 'Rented');

INSERT INTO equipment(client_id, inventory_id, restock_date, equip_expired, equip_status)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Jennifer'), (SELECT inventory_id FROM inventory WHERE product_name = 'Lantern'), '2019-08-24', 'No', 'Purchased');

INSERT INTO equipment(client_id, inventory_id, restock_date, equip_expired, equip_status)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Alex'), (SELECT inventory_id FROM inventory WHERE product_name = 'Tent'), '2010-11-07', 'Yes', 'Rented');

INSERT INTO equipment(client_id, inventory_id, restock_date, equip_expired, equip_status)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Cheryl'), (SELECT inventory_id FROM inventory WHERE product_name = 'Sleeping Bag'), '2021-01-18', 'No', 'Rented');

INSERT INTO equipment(client_id, inventory_id, restock_date, equip_expired, equip_status)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Cheryl'), (SELECT inventory_id FROM inventory WHERE product_name = 'Backpack'), '2022-04-06', 'No', 'Rented');

INSERT INTO equipment(client_id, inventory_id, restock_date, equip_expired, equip_status)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Cheryl'), (SELECT inventory_id FROM inventory WHERE product_name = 'GPS'), '2022-05-09', 'No','Purchased');

INSERT INTO equipment(client_id, inventory_id, restock_date, equip_expired, equip_status)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Bill'), (SELECT inventory_id FROM inventory WHERE product_name = 'Trail Boots'), '2023-09-20', 'No', 'Rented');

INSERT INTO equipment(client_id, inventory_id, restock_date, equip_expired, equip_status)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Bill'), (SELECT inventory_id FROM inventory WHERE product_name = 'Tent'), '2023-09-20', 'No', 'Rented');


-- insert guides records
INSERT INTO guides(first_name, last_name)
    VALUES('John "Mac"', 'MacNell');

INSERT INTO guides(first_name, last_name)
    VALUES('D.B. "Duke"', 'Marland');


-- insert country records
INSERT INTO country(country_name, continent)
    VALUES('Egypt', 'Africa');

INSERT INTO country(country_name, continent)
    VALUES('Morocco', 'Africa');

INSERT INTO country(country_name, continent)
    VALUES('Japan', 'Asia');

INSERT INTO country(country_name, continent)
    VALUES('Thailand', 'Asia');

INSERT INTO country(country_name, continent)
    VALUES('Italy', 'Europe');

INSERT INTO country(country_name, continent)
    VALUES('Spain', 'Europe');


-- insert trips records
INSERT INTO trips(country_id, guide_id, trip_name, trip_date)
    VALUES((SELECT country_id FROM country WHERE country_name = 'Spain'), (SELECT guide_id FROM guides WHERE last_name = 'MacNell'), 'The Cares Trail', '2023-07-12');

INSERT INTO trips(country_id, guide_id, trip_name, trip_date)
    VALUES((SELECT country_id FROM country WHERE country_name = 'Spain'), (SELECT guide_id FROM guides WHERE last_name = 'MacNell'), 'El Camino de Santiago', '2024-08-02');

INSERT INTO trips(country_id, guide_id, trip_name, trip_date)
    VALUES((SELECT country_id FROM country WHERE country_name = 'Italy'), (SELECT guide_id FROM guides WHERE last_name = 'MacNell'), 'Via Francigena', '2023-03-05');

INSERT INTO trips(country_id, guide_id, trip_name, trip_date)
    VALUES((SELECT country_id FROM country WHERE country_name = 'Thailand'), (SELECT guide_id FROM guides WHERE last_name = 'Marland'), 'Dragon Crest Mountain', '2023-06-25');

INSERT INTO trips(country_id, guide_id, trip_name, trip_date)
    VALUES((SELECT country_id FROM country WHERE country_name = 'Japan'), (SELECT guide_id FROM guides WHERE last_name = 'Marland'), 'Mount Fuji Pilgrimage Trail', '2023-04-14');

INSERT INTO trips(country_id, guide_id, trip_name, trip_date)
    VALUES((SELECT country_id FROM country WHERE country_name = 'Morocco'), (SELECT guide_id FROM guides WHERE last_name = 'MacNell'), 'Toubkal', '2023-10-31');

INSERT INTO trips(country_id, guide_id, trip_name, trip_date)
    VALUES((SELECT country_id FROM country WHERE country_name = 'Egypt'), (SELECT guide_id FROM guides WHERE last_name = 'Marland'), 'Mt. Sinai Trail', '2023-08-03');

INSERT INTO trips(country_id, guide_id, trip_name, trip_date)
    VALUES((SELECT country_id FROM country WHERE country_name = 'Morocco'), (SELECT guide_id FROM guides WHERE last_name = 'MacNell'), 'Giza Trail', '2024-06-10');


-- insert clients_attending_trip records
INSERT INTO clients_attending_trip(client_id, trip_id)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Grandma'), (SELECT trip_id FROM trips WHERE trip_name = 'The Cares Trail'));

INSERT INTO clients_attending_trip(client_id, trip_id)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Cheryl'), (SELECT trip_id FROM trips WHERE trip_name = 'The Cares Trail'));

INSERT INTO clients_attending_trip(client_id, trip_id)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Cheryl'), (SELECT trip_id FROM trips WHERE trip_name = 'Giza Trail'));

INSERT INTO clients_attending_trip(client_id, trip_id)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Bill'), (SELECT trip_id FROM trips WHERE trip_name = 'Via Francigena'));

INSERT INTO clients_attending_trip(client_id, trip_id)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Cheryl'), (SELECT trip_id FROM trips WHERE trip_name = 'Mt. Sinai Trail'));

INSERT INTO clients_attending_trip(client_id, trip_id)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Earl'), (SELECT trip_id FROM trips WHERE trip_name = 'Mt. Sinai Trail'));

INSERT INTO clients_attending_trip(client_id, trip_id)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Alex'), (SELECT trip_id FROM trips WHERE trip_name = 'Mt. Sinai Trail'));

INSERT INTO clients_attending_trip(client_id, trip_id)
    VALUES((SELECT client_id FROM clients WHERE first_name = 'Earl'), (SELECT trip_id FROM trips WHERE trip_name = 'Dragon Crest Mountain'));
