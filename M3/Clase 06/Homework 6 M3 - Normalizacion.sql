USE empresa_tech;
DROP TABLE Provincias;
DROP TABLE Localidades;
DROP TABLE AuxLocalidades;

CREATE TABLE Provincias (IdProvincia INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
                         Provincia VARCHAR(255));
                         
CREATE TABLE Localidades (IdLocalidad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
						  Localidad VARCHAR(255),
                          Provincia VARCHAR(255),
                          IdProvincia INT);
                          
CREATE TABLE AuxLocalidades (LocOriginal VARCHAR(255),
                             LocNorm VARCHAR(255),
                             IdLocalidad INT,
                             ProvOriginal VARCHAR(255),
                             ProvNorm VARCHAR(255),
                             IdProvincia INT);

ALTER TABLE Proveedores 
RENAME COLUMN Estado TO Provincia;

ALTER TABLE Proveedores 
RENAME COLUMN Ciudad TO Localidad;

ALTER TABLE Proveedores
DROP COLUMN Departamento;

INSERT INTO Provincias (Provincia) 
	SELECT DISTINCT Provincia 
    FROM Proveedores;
INSERT INTO Provincias (Provincia)
VALUES ('ENTRE RIOS'),('NEUQUEN'),('SIN DATO');
DELETE FROM Provincias WHERE Provincia = 'CABA';

INSERT INTO auxLocalidades (LocOriginal, LocNorm, ProvOriginal)
SELECT DISTINCT Localidad, Localidad, Provincia FROM clientes
UNION
SELECT DISTINCT Localidad, Localidad, Provincia FROM sucursales
UNION
SELECT DISTINCT Localidad, Localidad, Provincia FROM proveedores
ORDER BY 2, 1;

UPDATE auxlocalidades SET ProvNorm = 'BUENOS AIRES'
WHERE ProvOriginal IN ('B. Aires',
                            'B.Aires',
                            'Bs As',
                            'Bs.As.',
                            'Bs.As. ',
                            'Buenos Aires',
                            'C Debuenos Aires',
                            'Caba',
                            'Ciudad De Buenos Aires',
                            'Pcia Bs As',
                            'Prov De Bs As.',
                            'Provincia De Buenos Aires');

UPDATE auxlocalidades SET ProvNorm = 'CORDOBA' 
WHERE ProvOriginal = 'Córdoba';

UPDATE auxlocalidades SET ProvNorm = 'MENDOZA' 
WHERE ProvOriginal = 'Mendoza';

UPDATE auxlocalidades SET ProvNorm = 'RIO NEGRO' 
WHERE ProvOriginal = 'Rio negro';

UPDATE auxlocalidades SET ProvNorm = 'SANTA FE' 
WHERE ProvOriginal = 'Santa fe';

UPDATE auxlocalidades SET ProvNorm = 'TUCUMAN' 
WHERE ProvOriginal = 'Tucumán';

UPDATE auxlocalidades SET ProvNorm = 'ENTRE RIOS' 
WHERE ProvOriginal = 'Entre Ríos';

UPDATE auxlocalidades SET ProvNorm = 'NEUQUEN' 
WHERE ProvOriginal = 'Neuquén';

UPDATE auxlocalidades SET ProvNorm = 'SIN DATO' 
WHERE ProvOriginal = 'Sin dato';
                            
UPDATE auxlocalidades SET LocNorm = 'Capital Federal'
WHERE LocOriginal IN ('Boca De Atencion Monte Castro',
                            'Caba',
                            'Cap.   Federal',
                            'Cap. Fed.',
                            'Capfed',
                            'Capital',
                            'Capital ',
                            'Capital Federal',
                            'Cdad De Buenos Aires',
                            'Ciudad De Buenos Aires')
AND ProvNorm = 'BUENOS AIRES';

UPDATE auxlocalidades SET LocNorm = 'Córdoba'
WHERE LocOriginal IN ('Coroba',
					  'Cordoba',
					  'Cã³rdoba',
                      'Córdoba')
AND ProvNorm = 'CORDOBA';

INSERT INTO Localidades (Localidad,Provincia)
	SELECT DISTINCT LocNorm, ProvNorm
    FROM AuxLocalidades;

UPDATE Localidades l
JOIN Provincias p ON l.Provincia = p.Provincia
SET l.IdProvincia = p.IdProvincia;

UPDATE AuxLocalidades aux
JOIN Localidades l ON aux.LocNorm = l.Localidad
SET aux.idLocalidad = l.IdLocalidad;

UPDATE AuxLocalidades aux
JOIN Provincias p ON aux.ProvNorm = p.Provincia
SET aux.IdProvincia = p.IdProvincia;

ALTER TABLE Localidades 
DROP COLUMN Provincia;

-- Crear las columnas nuevas
ALTER TABLE Clientes
ADD COLUMN IdLocalidad INT AFTER Edad;

ALTER TABLE Sucursales
ADD COLUMN IdLocalidad INT AFTER Direccion;

ALTER TABLE Proveedores
ADD COLUMN IdLocalidad INT AFTER Direccion;

-- Llenar los datos de ID
UPDATE Clientes c
JOIN auxlocalidades aux ON c.Localidad = aux.LocOriginal
SET c.idLocalidad = aux.IdLocalidad;

UPDATE Sucursales s
JOIN auxlocalidades aux ON s.Localidad = aux.LocOriginal
SET s.idLocalidad = aux.IdLocalidad;

UPDATE Proveedores p
JOIN auxlocalidades aux ON p.Localidad = aux.LocOriginal
SET p.idLocalidad = aux.IdLocalidad;

-- Borrar columnas de Provincia y Localidad
ALTER TABLE clientes
DROP COLUMN Localidad;
ALTER TABLE clientes
DROP COLUMN Provincia;

ALTER TABLE sucursales
DROP COLUMN Localidad;
ALTER TABLE sucursales
DROP COLUMN Provincia;

ALTER TABLE proveedores
DROP COLUMN Localidad;
ALTER TABLE proveedores
DROP COLUMN Provincia;

-- Discretizacion edades
ALTER TABLE clientes 
ADD RangoEdad VARCHAR(50) AFTER Edad;

UPDATE clientes 
SET RangoEdad = '1: Menor de 20 años' WHERE Edad <= 20;
UPDATE clientes
SET RangoEdad = '2: Entre 21 y 30 años' WHERE Edad >20 AND Edad <= 30;
UPDATE clientes 
SET RangoEdad = '3: Entre 31 y 40 años' WHERE Edad >30 AND Edad <= 40;
UPDATE clientes 
SET RangoEdad = '4: Entre 41 y 50 años' WHERE Edad >40 AND Edad <= 50;
UPDATE clientes 
SET RangoEdad = '5: Entre 51 y 60 años' WHERE Edad >50 AND Edad <= 60;
UPDATE clientes 
SET RangoEdad = '6: Mayor de 60 años' WHERE Edad >60;
