USE adventureworks;

-- Punto 1: Obtener un listado contactos que hayan ordenado productos de la subcategoría "Mountain Bikes", entre los años 2000 y 2003,
--          cuyo método de envío sea "CARGO TRANSPORT 5".

SELECT DISTINCT c.ContactID, c.FirstName, c.LastName, c.EmailAddress, c.Phone
FROM salesorderheader s
JOIN contact c ON s.ContactID = c.ContactID
JOIN salesorderdetail sd ON s.SalesOrderID = sd.SalesOrderID
JOIN product p ON p.ProductID = sd.ProductID
JOIN productsubcategory sc ON sc.ProductSubcategoryID = p.ProductSubcategoryID
JOIN shipmethod sm ON s.ShipMethodID = sm.ShipMethodID
WHERE sm.Name = 'CARGO TRANSPORT 5'
AND YEAR(OrderDate) BETWEEN 2000 AND 2003
AND sc.Name = 'Mountain Bikes'
ORDER BY c.ContactID;

-- Punto 2:  Obtener un listado contactos que hayan ordenado productos de la subcategoría "Mountain Bikes", entre los años 2000 y 2003 
--           con la cantidad de productos adquiridos y ordenado por este valor, de forma descendente.

SELECT c.ContactID, c.FirstName, c.LastName, c.EmailAddress, c.Phone, SUM(sd.OrderQty) AS CantidadProductos
FROM salesorderheader s
JOIN contact c ON s.ContactID = c.ContactID
JOIN salesorderdetail sd ON s.SalesOrderID = sd.SalesOrderID
JOIN product p ON p.ProductID = sd.ProductID
JOIN productsubcategory sc ON sc.ProductSubcategoryID = p.ProductSubcategoryID
WHERE YEAR(OrderDate) BETWEEN 2000 AND 2003
AND sc.Name = 'Mountain Bikes'
GROUP BY c.ContactID
ORDER BY CantidadProductos DESC;

-- Punto 3: Obtener un listado de cual fue el volumen de compra (cantidad) por año y método de envío.

SELECT YEAR(sh.OrderDate) AS Año, sm.Name AS MetodoEnvio, SUM(sd.OrderQty) AS VolumenCompra
FROM salesorderdetail sd
JOIN salesorderheader sh ON sh.SalesOrderID = sd.SalesOrderID
JOIN shipmethod sm ON sh.ShipMethodID = sm.ShipMethodID
GROUP BY YEAR(sh.OrderDate), sh.ShipMethodID;

-- Punto 4: Obtener un listado por categoría de productos, con el valor total de ventas y productos vendidos.

SELECT c.Name AS Categoria, SUM(sd.OrderQty) AS ProductosVendidos, SUM(sd.LineTotal) AS TotalVentas
FROM salesorderdetail sd
JOIN product p ON p.ProductID = sd.ProductID
JOIN productsubcategory sc ON p.ProductSubcategoryID = sc.ProductSubcategoryID
JOIN productcategory c ON sc.ProductCategoryID = c.ProductCategoryID
GROUP BY c.ProductCategoryID;

-- Punto 5: Obtener un listado por país (según la dirección de envío), con el valor total de ventas y productos vendidos, sólo para 
--          aquellos países donde se enviaron más de 15 mil productos.

SELECT cr.Name AS Pais, SUM(sd.OrderQty) AS ProductosVendidos, SUM(sd.LineTotal) AS TotalVentas
FROM salesorderheader sh
JOIN salesorderdetail sd ON sh.SalesOrderID = sd.SalesOrderID
JOIN address a ON sh.ShipToAddressID = a.AddressID
JOIN stateprovince sp ON a.StateProvinceID = sp.StateProvinceID
JOIN countryregion cr ON sp.CountryRegionCode = cr.CountryRegionCode
GROUP BY Pais
HAVING ProductosVendidos > 15000;

-- Punto 6: Obtener un listado de las cohortes que no tienen alumnos asignados, utilizando la base de datos henry, desarrollada en 
--          el módulo anterior.

USE henry;

SELECT * FROM cohorte c
LEFT JOIN alumno a ON c.idCohorte = a.idCohorte
WHERE a.idCohorte IS NULL;
