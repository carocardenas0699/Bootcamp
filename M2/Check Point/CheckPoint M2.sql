USE checkpoint_m2;

SELECT * FROM venta;
SELECT * FROM producto;

-- Punto 1: Cual fue el canal de venta con mayor monto de venta en el año 2015? R/ PRESENCIAL

SELECT idCanal, SUM(Precio) as monto
FROM venta
WHERE YEAR(fecha) = 2015
GROUP BY IdCanal
ORDER BY monto DESC; -- 3

SELECT * FROM canal_venta
WHERE idCanal = 3; -- Presencial

-- Punto 2: Cual es el tipo del producto con quinta menor venta del año 2018? R/ BASES (NO SE PORQUE)
SELECT idProducto, COUNT(cantidad) as monto
FROM venta
WHERE YEAR(fecha) = 2018
GROUP BY idProducto
ORDER BY monto; -- 42926

SELECT DISTINCT Tipo FROM producto;

SELECT * FROM producto
WHERE IDProducto = 42907;

-- Punto 3: Cual es el ID del producto cuyo Concepto es 'FUNDA PARA TABLET CASE LOGIC TS-108'? R/ 42925
SELECT idProducto FROM producto
WHERE Concepto = 'FUNDA PARA TABLET CASE LOGIC TS-108';

-- Punto 4: Cual es el ID edl empleado con la segunda mayor cantidad de productos vendidos en el historico de ventas de la empresa?
--          R/ 3504
SELECT idEmpleado, SUM(cantidad) as num 
FROM venta
GROUP BY idEmpleado
ORDER BY num DESC;

-- Punto 5: Cual es el ID del producto con el segundo mayor monto de venta en 2015? R/ 42811
SELECT idProducto, SUM(Precio) as monto
FROM venta
WHERE YEAR(fecha) = 2015
GROUP BY IdProducto
ORDER BY monto DESC;

-- Punto 6: Cuantos envios con demora de mas de 5 dias se realizaron en 2018? R/?? NO 2018

-- NO ME DIO 
SELECT idVenta, fecha, Fecha_Entrega, TIMESTAMPDIFF(DAY,Fecha,Fecha_Entrega)
FROM venta
WHERE YEAR(fecha) = 2018
AND TIMESTAMPDIFF(DAY,Fecha,Fecha_Entrega) >= 5
ORDER BY TIMESTAMPDIFF(DAY,Fecha,Fecha_Entrega) DESC;

SELECT COUNT(*)
FROM venta
WHERE YEAR(fecha) = 2018
AND TIMESTAMPDIFF(DAY,Fecha,Fecha_Entrega) >= 5;