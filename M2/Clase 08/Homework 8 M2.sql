
CREATE DATABASE Oferta_Gastronomica;
USE Oferta_Gastronomica;
    
CREATE TABLE oferta (id_local INT NOT NULL, 
					nombre VARCHAR(255), 
					categoria VARCHAR(255), 
					direccion VARCHAR(255), 
					barrio VARCHAR(255), 
					comuna VARCHAR(255));
                        
SELECT * FROM oferta;

-- a) ¿Cuál es el barrio con mayor cantidad de Pubs? 

SELECT barrio, COUNT(*) as cantidad
FROM oferta
WHERE categoria = 'PUB'
GROUP BY barrio
ORDER BY cantidad DESC;

-- b) Obtener la cantidad de locales por categoría 

SELECT categoria, COUNT(*) as cantidad
FROM oferta
GROUP BY categoria
ORDER BY categoria;

-- c) Obtener la cantidad de restaurantes por comuna

SELECT comuna, COUNT(*) as cantidad
FROM oferta
WHERE categoria = 'RESTAURANTE'
GROUP BY comuna
ORDER BY comuna;
