USE empresa_tech;

-- Calcula Maximos y Minimos basado en Regla de los 3 sigmas e Identificar Outliers
CREATE VIEW ExtremosCantidad AS
SELECT IdProducto, 
       AVG(Cantidad) AS Promedio, 
       AVG(Cantidad) + (3 * stddev(Cantidad)) AS Max,
	   AVG(Cantidad) - (3 * stddev(Cantidad)) AS Min
FROM Ventas
GROUP BY IdProducto;

CREATE VIEW ExtremosPrecio AS
SELECT IdProducto, 
       AVG(Precio) AS Promedio, 
       AVG(Precio) + (3 * stddev(Precio)) AS Max,
	   AVG(Precio) - (3 * stddev(Precio)) AS Min
FROM Ventas
GROUP BY IdProducto;

-- Crear tabla de "Motivos"
CREATE TABLE Motivos (IdMotivo INT, Motivo VARCHAR(100));
INSERT INTO Motivos VALUES (1, 'Cantidad = 0'),(2, 'Outlier Cantidad'),(3, 'Outlier Precio');

-- Agregar Outliers a AuxVentas
INSERT INTO auxVenta
SELECT v.IdVenta, v.Fecha, v.FechaEntrega, v.IdCanal, v.IdCliente, v.IdSucursal, v.IdEmpleado, v.IdProducto, 
       v.Precio, v.Cantidad, 2
FROM Ventas v
JOIN ExtremosCantidad ex ON ex.IdProducto = v.IdProducto
WHERE v.Cantidad > ex.Max OR v.Cantidad < ex.Min OR v.Cantidad < 0;

INSERT INTO auxVenta
SELECT v.IdVenta, v.Fecha, v.FechaEntrega, v.IdCanal, v.IdCliente, v.IdSucursal, v.IdEmpleado, v.IdProducto, 
       v.Precio, v.Cantidad, 3
FROM Ventas v
JOIN ExtremosPrecio ex ON ex.IdProducto = v.IdProducto
WHERE v.Precio > ex.Max OR v.Precio < ex.Min OR v.Precio < 0;

-- Columna de Outlier en tabla Ventas
ALTER TABLE Ventas
ADD COLUMN Outlier TINYINT DEFAULT 1;

UPDATE Ventas v
JOIN AuxVenta aux ON v.IdVenta = aux.IdVenta
SET v.Outlier = 0
WHERE aux.Motivo IN (2,3);

-- Calculo de ventas por Sucursal
CREATE VIEW VentasSucursal AS
SELECT s.IdSucursal, s.Sucursal, ROUND(SUM(v.Precio * v.Cantidad),2) AS VentasConOutliers, ROUND(SUM(v.Precio * v.Cantidad * v.Outlier),2) AS VentasSinOutliers
FROM Sucursales s
JOIN Ventas v ON s.IdSucursal = v.IdSucursal
GROUP BY s.IdSucursal, s.Sucursal;
