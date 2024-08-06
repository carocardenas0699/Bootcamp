DROP DATABASE e_commerce;
CREATE DATABASE e_commerce;
USE e_commerce;
-- Creación de tablas
CREATE TABLE country(
	country_id INT PRIMARY KEY,
    country VARCHAR(255)
);

CREATE TABLE product(
	product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(255),
    price FLOAT
);

CREATE TABLE transactions(
	transactions_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id VARCHAR(50),
    price FLOAT,
    quantity INT,
    customerNo VARCHAR(50),
    country_id INT,
	CONSTRAINT pro_trns FOREIGN KEY (product_id) REFERENCES product(product_id),
    CONSTRAINT coun_trns FOREIGN KEY (country_id) REFERENCES country(country_id)
);