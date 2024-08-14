USE adventureworks;

/* 1. Obtener un listado de cuál fue el volumen de ventas (cantidad) por año y método de envío mostrando para cada registro, 
qué porcentaje representa del total del año. Resolver utilizando Subconsultas y Funciones Ventana, 
luego comparar la diferencia en la demora de las consultas.<br> */

-- Subconsulta: 1.797s

SELECT YEAR(sh.OrderDate) AS Año, sm.Name AS MetodoEnvio, SUM(sd.OrderQty) AS VolumenCompra, 
		(SUM(sd.OrderQty) / p.TotalAño) * 100 AS Porcentaje
FROM salesorderdetail sd
JOIN salesorderheader sh ON sh.SalesOrderID = sd.SalesOrderID
JOIN shipmethod sm ON sh.ShipMethodID = sm.ShipMethodID
JOIN (SELECT YEAR(sh.OrderDate) AS Año, SUM(sd.OrderQty) AS TotalAño
	  FROM salesorderdetail sd
      JOIN salesorderheader sh ON sh.SalesOrderID = sd.SalesOrderID
	  GROUP BY YEAR(sh.OrderDate)) p ON p.Año = YEAR(sh.OrderDate)
GROUP BY YEAR(sh.OrderDate), sm.Name, p.TotalAño;

-- Funcion ventana: 0.672s

SELECT  YEAR(OrderDate) as Año, 
        sm.Name as MetodoEnvio, 
        SUM(OrderQty) as VolumenCompra,
        (SUM(OrderQty) / SUM(SUM(OrderQty)) OVER(PARTITION BY  YEAR(OrderDate)) * 100) AS Porcentaje
FROM salesorderheader sh
JOIN salesorderdetail sd ON (sh.SalesOrderID = sd.SalesOrderID)
JOIN shipmethod sm ON (sh.ShipMethodID = sm.ShipMethodID)
GROUP BY Año, MetodoEnvio;

-- Funcion ventana 2: 0.578s
SELECT Año,
        MetodoEnvio,
        VolumenCompra,
        (VolumenCompra / SUM(VolumenCompra) OVER(PARTITION BY Año) * 100) AS Porcentaje
FROM
(SELECT YEAR(sh.OrderDate) AS Año, SUM(sd.OrderQty) AS VolumenCompra, sm.Name AS MetodoEnvio
FROM salesorderheader sh
    JOIN salesorderdetail sd ON(sd.SalesOrderID = sh.SalesOrderID)
    JOIN shipmethod AS sm ON(sm.ShipMethodID = sh.ShipMethodID)
GROUP BY YEAR(sh.OrderDate), sm.Name) as SUB;



/* 2. Obtener un listado por categoría de productos, con el valor total de ventas y productos vendidos, mostrando para ambos, 
su porcentaje respecto del total.*/

SELECT c.Name AS Categoria, SUM(sd.OrderQty) AS ProductosVendidos, SUM(sd.LineTotal) AS TotalVentas, 
	   (SUM(sd.OrderQty) / SUM(SUM(sd.OrderQty)) OVER() * 100) AS PorcentajeProductos, 
	   ROUND((SUM(sd.LineTotal) / SUM(SUM(sd.LineTotal)) OVER() * 100),4) AS PorcentajeVentas 
FROM salesorderdetail sd
JOIN product p ON p.ProductID = sd.ProductID
JOIN productsubcategory sc ON p.ProductSubcategoryID = sc.ProductSubcategoryID
JOIN productcategory c ON sc.ProductCategoryID = c.ProductCategoryID
GROUP BY c.ProductCategoryID;

/* 3. Obtener un listado por país (según la dirección de envío), con el valor total de ventas y productos vendidos, mostrando 
para ambos, su porcentaje respecto del total.*/

SELECT cr.Name AS Pais, SUM(sd.OrderQty) AS ProductosVendidos, ROUND(SUM(sd.LineTotal),4) AS TotalVentas,
	   (SUM(sd.OrderQty) / SUM(SUM(sd.OrderQty)) OVER() * 100) AS PorcentajeProductos, 
	   ROUND((SUM(sd.LineTotal) / SUM(SUM(sd.LineTotal)) OVER() * 100),4) AS PorcentajeVentas
FROM salesorderheader sh
JOIN salesorderdetail sd ON sh.SalesOrderID = sd.SalesOrderID
JOIN address a ON sh.ShipToAddressID = a.AddressID
JOIN stateprovince sp ON a.StateProvinceID = sp.StateProvinceID
JOIN countryregion cr ON sp.CountryRegionCode = cr.CountryRegionCode
GROUP BY Pais;

/* 4. Obtener por ProductID, los valores correspondientes a la mediana de las ventas (LineTotal), sobre las ordenes realizadas. 
Investigar las funciones FLOOR() y CEILING().*/

SELECT h.LineTotal as Mediana
FROM(
SELECT  COUNT(*) OVER () AS Total,
        ROW_NUMBER() OVER (ORDER BY LineTotal) as Fila,
        LineTotal
FROM salesorderdetail
    ) h
WHERE Fila = (Total + 1) / 2;
