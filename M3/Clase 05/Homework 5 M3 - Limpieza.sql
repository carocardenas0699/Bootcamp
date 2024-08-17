USE empresa_tech;

-- Cambio nombre de columnas
ALTER TABLE Clientes
RENAME COLUMN Domicilio TO Direccion;

ALTER TABLE Productos
RENAME COLUMN Concepto TO Nombre;

-- Cambio de posicion de columnas
ALTER TABLE Compras 
CHANGE COLUMN IdProveedor IdProveedor INT AFTER Fecha;

-- Cambio de tipo de dato de Latitud y Longitud en Clientes
UPDATE Clientes SET Latitud = '0' WHERE Latitud = '';
UPDATE Clientes SET Longitud = '0' WHERE Longitud = '';

UPDATE Clientes SET Latitud = REPLACE(Latitud,',','.');
UPDATE Clientes SET Longitud = REPLACE(Longitud,',','.');

ALTER TABLE Clientes MODIFY COLUMN Latitud DECIMAL(13,10);
ALTER TABLE Clientes MODIFY COLUMN Longitud DECIMAL(13,10);

-- Cambio de tipo de dato de Latitud y Longitud en Sucursales
UPDATE Sucursales SET Latitud = '0' WHERE Latitud = '';
UPDATE Sucursales SET Longitud = '0' WHERE Longitud = '';

UPDATE Sucursales SET Latitud = REPLACE(Latitud,',','.');
UPDATE Sucursales SET Longitud = REPLACE(Longitud,',','.');

ALTER TABLE Sucursales MODIFY COLUMN Latitud DECIMAL(13,10);
ALTER TABLE Sucursales MODIFY COLUMN Longitud DECIMAL(13,10);

-- Cambiar Salario a decimal en Empleados
ALTER TABLE Empleados MODIFY COLUMN Salario DECIMAL(10,2);

-- Cambiar Precio a decimal en Ventas
UPDATE Ventas SET Precio = '0' WHERE Precio = '';
ALTER TABLE Ventas MODIFY COLUMN Precio FLOAT;

-- Imputar valores faltantes
UPDATE Clientes SET Domicilio = 'Sin Dato' WHERE Domicilio = "" OR ISNULL(Domicilio);
UPDATE Clientes SET Localidad = 'Sin Dato' WHERE Localidad = "" OR ISNULL(Localidad);
UPDATE Clientes SET NombreCompleto = 'Sin Dato' WHERE NombreCompleto = "" OR ISNULL(NombreCompleto);
UPDATE Clientes SET Provincia = 'Sin Dato' WHERE Provincia = "" OR ISNULL(Provincia);

UPDATE Productos SET Tipo = 'Sin Dato' WHERE Tipo = "" OR ISNULL(Tipo);
UPDATE Proveedores SET Nombre = 'Sin Dato' WHERE Nombre = "" OR ISNULL(Nombre);

-- Normalizacion de textos
UPDATE Clientes SET  Direccion = TRIM(Direccion), NombreCompleto = TRIM(NombreCompleto);					
UPDATE Sucursales SET Direccion = TRIM(Direccion), Sucursal = TRIM(Sucursal);
UPDATE Proveedores SET Nombre = TRIM(Nombre), Direccion = TRIM(Direccion);
UPDATE Productos SET Nombre = TRIM(Nombre);
UPDATE TipoProducto SET Tipo = TRIM(Tipo);
UPDATE Empleados SET Nombre = TRIM(Nombre), Apellido = TRIM(Apellido);

-- Borrar registros sin informacion
DELETE FROM Productos WHERE Concepto LIKE 'Producto%';

-- Ingresar precios faltantes en Ventas
UPDATE Ventas v JOIN Productos p ON (v.IdProducto = p.IdProducto) 
SET v.Precio = p.Precio
WHERE v.Precio = 0;

-- Cambiar en venta.Cantidad \r por '' 
UPDATE Ventas SET Cantidad = REPLACE(Cantidad, '\r', ''); 
-- Creación tabla auxiliar para guardar las filas con venta.CANTIDAD sin dato 
CREATE TABLE AuxVenta ( IdVenta INT, 
                         Fecha DATE, 
                         FechaEntrega DATE, 
                         IdCanal INT, 
                         IdCliente INT, 
                         IdSucursal INT, 
                         IdEmpleado INT, 
                         IdProducto INT, 
                         Precio DECIMAL(15,3), 
                         Cantidad INT, 
                         Motivo INT ); 

-- Llenado de tabla auxiliar 
INSERT INTO AuxVenta (IdVenta, Fecha, FechaEntrega, IdCanal, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, Motivo)
SELECT IdVenta, Fecha, FechaEntrega, IdCanal, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, 0, 1
FROM Ventas WHERE Cantidad = '' OR Cantidad IS NULL;

-- Cambiar tipo de dato de Cantidad en Ventas
UPDATE Ventas SET Cantidad = '1' WHERE Cantidad = '' OR Cantidad IS NULL; 
ALTER TABLE Ventas 
CHANGE Cantidad Cantidad INT; 

-- Normalizar los espacios en Sucursal
UPDATE Sucursales SET Sucursal = 'Mendoza 1' WHERE Sucursal = 'Mendoza1';
UPDATE Sucursales SET Sucursal = 'Mendoza 2' WHERE Sucursal = 'Mendoza2';

UPDATE Sucursales SET Sucursal = 'Rosario 1' WHERE Sucursal = 'Rosario1';
UPDATE Sucursales SET Sucursal = 'Rosario 2' WHERE Sucursal = 'Rosario2';

UPDATE Empleados SET Sucursal = 'Rosario 1' WHERE Sucursal = 'Rosario1';
UPDATE Empleados SET Sucursal = 'Rosario 2' WHERE Sucursal = 'Rosario2';

UPDATE Sucursales SET Sucursal = 'MDQ 1' WHERE Sucursal = 'MDQ1';
UPDATE Sucursales SET Sucursal = 'MDQ 2' WHERE Sucursal = 'MDQ2';

UPDATE Empleados SET Sucursal = 'MDQ 1' WHERE Sucursal = 'MDQ1';
UPDATE Empleados SET Sucursal = 'MDQ 2' WHERE Sucursal = 'MDQ2';

-- Reemplazar Sucursal por IdSucursal en Empleados
ALTER TABLE Empleados ADD IdSucursal INT NULL DEFAULT '0' AFTER Sucursal;

UPDATE Empleados e JOIN Sucursales s
	ON (e.Sucursal = s.Sucursal)
SET e.IdSucursal = s.IdSucursal;

ALTER TABLE Empleados DROP Sucursal;

-- Clave subrogada
ALTER TABLE Empleados ADD CodEmpleado INT NULL DEFAULT '0' AFTER IdEmpleado;

UPDATE Empleados SET CodEmpleado = IdEmpleado;
UPDATE Empleados SET IdEmpleado = (IdSucursal * 1000000) + CodEmpleado;

-- Chequeo de claves duplicadas
SELECT IdEmpleado, COUNT(*) FROM Empleados GROUP BY IdEmpleado HAVING COUNT(*) > 1;

UPDATE Ventas SET IdEmpleado = (IdSucursal * 1000000) + IdEmpleado;

-- Tablas nuevas para Empleados
CREATE TABLE Cargos (IdCargo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                     Cargo VARCHAR(50) NOT NULL);
                     
CREATE TABLE Sectores (IdSector INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                       Sector VARCHAR(50) NOT NULL);
                       
INSERT INTO Cargos (Cargo) SELECT DISTINCT TRIM(Cargo) FROM Empleados ORDER BY 1;

INSERT INTO Sectores (Sector) SELECT DISTINCT TRIM(Sector) FROM Empleados ORDER BY 1;

ALTER TABLE Empleados ADD IdSector INT NOT NULL DEFAULT '0' AFTER IdSucursal, 
					  ADD IdCargo INT NOT NULL DEFAULT '0' AFTER IdSector;

UPDATE Empleados e JOIN Cargos c ON (c.Cargo = TRIM(e.Cargo)) SET e.IdCargo = c.IdCargo;
UPDATE Empleados e JOIN Sectores s ON (s.Sector = TRIM(e.Sector)) SET e.IdSector = s.IdSector;

ALTER TABLE Empleados DROP Cargo;
ALTER TABLE Empleados DROP Sector;

UPDATE Empleados SET IdCargo = 5 WHERE IdCargo = 0;

-- Tablas nuevas para Producto
ALTER TABLE Productos ADD IdTipoProducto INT NOT NULL DEFAULT '0' AFTER Tipo;

CREATE TABLE TipoProducto (IdTipoProducto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
						   Tipo VARCHAR(50) NOT NULL);
                           
INSERT INTO TipoProducto (Tipo) SELECT DISTINCT TRIM(Tipo) FROM Productos ORDER BY 1;

UPDATE Productos p JOIN TipoProducto t ON (p.Tipo = t.Tipo) SET p.IdTipoProducto = t.IdTipoProducto;