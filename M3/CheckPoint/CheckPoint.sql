USE new_checkpoint_m3;

-- Porcentaje de platos que contengan Pollo del total de platos
SELECT nombre_plato FROM restaurante_platos
WHERE nombre_plato LIKE '%pollo%'; -- 85

SELECT nombre_plato FROM restaurante_platos
WHERE nombre_plato LIKE 'pollo%'; -- 42

SELECT nombre_plato FROM restaurante_platos
WHERE nombre_plato LIKE '%pollo'; -- 11

SELECT nombre_plato FROM restaurante_platos
WHERE nombre_plato LIKE '%pollo%'
UNION ALL
SELECT nombre_plato FROM restaurante_platos
WHERE nombre_plato LIKE 'pollo%'
UNION ALL
SELECT nombre_plato FROM restaurante_platos
WHERE nombre_plato LIKE '%pollo'; -- 138

SELECT nombre_plato FROM restaurante_platos
WHERE nombre_plato LIKE '%pollo%'
UNION
SELECT nombre_plato FROM restaurante_platos
WHERE nombre_plato LIKE 'pollo%'
UNION
SELECT nombre_plato FROM restaurante_platos
WHERE nombre_plato LIKE '%pollo'; -- 16 (8.25%)

SELECT DISTINCT nombre_plato FROM restaurante_platos; -- 194

SELECT nombre_plato, COUNT(*) FROM restaurante_platos 
GROUP BY nombre_plato;

-- 

SELECT * FROM reserva r 
JOIN hoteles_habitaciones h ON h.habid = r.habid
WHERE YEAR(r.fecha_inicio) = 2023
AND h.estrellas = 4; -- 132

-- 

SELECT AVG(Precio)
FROM hoteles_habitaciones
WHERE rid = 2
AND estrellas = 4; -- 80798.882578


--

SELECT DISTINCT COUNT(*) 
FROM Reserva
WHERE uid = 71;

-- 

SELECT DISTINCT COUNT(*) 
FROM  hoteles_habitaciones
WHERE estrellas = 4; -- 12000

--

SELECT COUNT(*) FROM reserva r 
JOIN hoteles_habitaciones h ON h.habid = r.habid
WHERE h.estrellas = 4
AND h.rid != 0; -- 11400 (95% de todas las habitaciones de 4 estrellas estan reserrvadas)

SELECT COUNT(*) FROM hoteles_habitaciones
WHERE rid != 0; -- 56250 habitaciones reservadas (20.27% de las habitaciones reservadas son de 4 estrellas)

SELECT habid FROM hoteles_habitaciones
UNION
SELECT habid FROM reserva;

SELECT estrellas, COUNT(*)
FROM hoteles_habitaciones
GROUP BY estrellas;

--

SELECT DISTINCT YEAR(fecha_inicio), COUNT(*)
FROM reserva
GROUP BY YEAR(fecha_inicio);


--

SELECT AVG (Precio)
FROM hoteles_habitaciones
WHERE estrellas = 2
AND rid = 11; -- '75606.422747'

-- 


