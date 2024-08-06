USE e_commerce;
-- Consulta
SELECT * FROM country;

SELECT * FROM transactions;
-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'SELECT * FROM country' at line 3
SELECT * FROM product ORDER BY price;
-- ACTUALIZAR DATOS
UPDATE product
SET price = 7.50
WHERE product_name = 'Ice Cream Design Garden Parasol';

SELECT product_name, price 
FROM product 
WHERE product_name = 'Ice Cream Design Garden Parasol';

INSERT INTO country(country_id, country) 
VALUE(62345, 'Peru');

INSERT INTO country(country_id, country) 
VALUE(65345, 'Chile'),(678923, 'Colombia');

INSERT INTO country
VALUE(69345, 'Venezuela'),(69645,'Argentina');
-- Error Code: 1062. Duplicate entry '69345' for key 'PRIMARY'

SELECT * FROM country;

SELECT * FROM transactions;

SELECT product_id, price * quantity as Total_Ventas
FROM transactions; 

DELETE FROM country WHERE country_id = 69345;




