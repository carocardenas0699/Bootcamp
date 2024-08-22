USE empresa_tech;

CREATE TABLE venta_actualizada (
    IdVenta        INT,
    Fecha          DATE,
    Fecha_Entrega  DATE,
    IdCanal        INT,
    IdCliente      INT,
    IdSucursal     INT,
    IdEmpleado     INT,
    IdProducto     INT,
    Precio         VARCHAR(255),
    Cantidad       VARCHAR(255));
    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Venta_Actualizado.csv'
INTO TABLE venta_actualizada
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

--
CREATE TABLE clientes_actualizado (
    IdClientes                      INT,
    Provincia                       VARCHAR(255),
    NombreCompleto                  VARCHAR(255),
    Domicilio                       VARCHAR(255),
    Telefono                        VARCHAR(255),
    Edad                            INT,
    Localidad                       VARCHAR(255),
    Latitud                         VARCHAR(255),
    Longitud                        VARCHAR(255),
    Fecha_Alta                      DATE,
    Usuario_Alta                    VARCHAR(20),
    Fecha_Ultima_Modificacion        DATE,
    Usuario_Ultima_Modificacion        VARCHAR(20),
    Marca_Baja                        TINYINT);
    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Clientes_Actualizado.csv'
INTO TABLE clientes_actualizado
FIELDS TERMINATED BY ';'
IGNORE 1 LINES
(IdClientes, Provincia, NombreCompleto, Domicilio, Telefono, Edad, Localidad, Longitud, 
Latitud, Fecha_Alta, Usuario_Alta, Fecha_Ultima_Modificacion, Usuario_Ultima_Modificacion, Marca_Baja);

-- ACTUALIZAR VENTAS 

-- Borrar filas que ya tengo y dejo solo las 30 que necesito
DELETE FROM venta_actualizada
WHERE IdVenta < 48242;

-- Cambio tipo de dato que no coincide
ALTER TABLE venta_actualizada CHANGE Precio Precio DECIMAL(15,3);
ALTER TABLE venta_actualizada CHANGE Cantidad Cantidad INT;
ALTER TABLE venta_actualizada ADD Outlier TINYINT DEFAULT '1';

-- Normalizamos el IdEmpleado por su clave subrogada correspondiente
UPDATE venta_actualizada SET IdEmpleado = (IdSucursal * 1000000) + IdEmpleado;

-- Desactivo las Foreign Keys
SHOW VARIABLES;
SET foreign_key_checks = 0;

-- Insertamos los datos nuevos en la tabla original
INSERT INTO ventas
SELECT * FROM venta_actualizada;

-- ACTUALIZAR CLIENTES

-- Revisar cuantos registros nuevos hay (10)
SELECT COUNT(*) FROM Clientes;
SELECT COUNT(*) FROM clientes_actualizado;

-- Limpiar y normalizar la nueva tabla
ALTER TABLE clientes_actualizado
RENAME COLUMN Domicilio TO Direccion;

UPDATE clientes_actualizado SET Latitud = '0' WHERE Latitud = '';
UPDATE clientes_actualizado SET Longitud = '0' WHERE Longitud = '';

UPDATE clientes_actualizado SET Latitud = REPLACE(Latitud,',','.');
UPDATE clientes_actualizado SET Longitud = REPLACE(Longitud,',','.');

ALTER TABLE clientes_actualizado MODIFY COLUMN Latitud DECIMAL(13,10);
ALTER TABLE clientes_actualizado MODIFY COLUMN Longitud DECIMAL(13,10);

UPDATE clientes_actualizado SET Direccion = 'Sin Dato' WHERE Direccion = "" OR ISNULL(Direccion);
UPDATE clientes_actualizado SET Localidad = 'Sin Dato' WHERE Localidad = "" OR ISNULL(Localidad);
UPDATE clientes_actualizado SET NombreCompleto = 'Sin Dato' WHERE NombreCompleto = "" OR ISNULL(NombreCompleto);
UPDATE clientes_actualizado SET Provincia = 'Sin Dato' WHERE Provincia = "" OR ISNULL(Provincia);

UPDATE clientes_actualizado SET  Direccion = TRIM(Direccion), NombreCompleto = TRIM(NombreCompleto);

ALTER TABLE clientes_actualizado
ADD COLUMN IdLocalidad INT AFTER Edad;

UPDATE clientes_actualizado c
JOIN auxlocalidades aux ON c.Localidad = aux.LocOriginal
SET c.idLocalidad = aux.IdLocalidad;

ALTER TABLE clientes_actualizado
DROP COLUMN Localidad;
ALTER TABLE clientes_actualizado
DROP COLUMN Provincia;

ALTER TABLE clientes_actualizado
ADD RangoEdad VARCHAR(50) AFTER Edad;

UPDATE clientes_actualizado 
SET RangoEdad = '1: Menor de 20 años' WHERE Edad <= 20;
UPDATE clientes_actualizado 
SET RangoEdad = '2: Entre 21 y 30 años' WHERE Edad >20 AND Edad <= 30;
UPDATE clientes_actualizado 
SET RangoEdad = '3: Entre 31 y 40 años' WHERE Edad >30 AND Edad <= 40;
UPDATE clientes_actualizado 
SET RangoEdad = '4: Entre 41 y 50 años' WHERE Edad >40 AND Edad <= 50;
UPDATE clientes_actualizado 
SET RangoEdad = '5: Entre 51 y 60 años' WHERE Edad >50 AND Edad <= 60;
UPDATE clientes_actualizado 
SET RangoEdad = '6: Mayor de 60 años' WHERE Edad >60;

