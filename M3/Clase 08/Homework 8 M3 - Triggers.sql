USE empresa_tech;

CREATE TABLE Audit_FactVenta (Fecha DATE,
							 FechaEntrega DATE,
							 IdCanal INT,
							 IdCliente INT,
							 IdEmpleado INT,
							 IdProducto	INT,
							 Usuario VARCHAR(20),
							 FechaModificacion DATETIME);
                             
CREATE TRIGGER Audit_FactVenta AFTER INSERT ON FactVenta
FOR EACH ROW
INSERT INTO Audit_FactVenta (Fecha, FechaEntrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Usuario, FechaModificacion)
VALUES(NEW.Fecha, NEW.FechaEntrega, NEW.IdCanal, NEW.IdCliente, NEW.IdEmpleado, NEW.IdProducto, CURRENT_USER(), NOW());

CREATE TABLE Registros_FactVenta (Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
								  Cantidad INT,
								  Usuario VARCHAR (20),
								  Fecha DATETIME);

CREATE TRIGGER Registros_FactVenta AFTER INSERT ON FactVenta
FOR EACH ROW
INSERT INTO Registros_FactVenta (Cantidad, Usuario, Fecha)
VALUES ((SELECT COUNT(*) FROM FactVenta),CURRENT_USER,NOW());

CREATE TABLE Audit_Act_FactVenta (Descripcion VARCHAR(50),
								  Fecha DATE,
							 FechaEntrega DATE,
							 IdCanal INT,
							 IdCliente INT,
							 IdEmpleado INT,
							 IdProducto	INT,
                             Precio FLOAT,
                             Cantidad INT,
							 Usuario VARCHAR(20),
							 FechaModificacion DATETIME);
                         
CREATE TRIGGER Act_FactVenta AFTER UPDATE ON FactVenta
FOR EACH ROW
INSERT INTO Audit_Act_FactVenta (Descripcion,Fecha, FechaEntrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad, Usuario, FechaModificacion)
VALUES(CONCAT('Anterior ', OLD.IdVenta),OLD.Fecha, OLD.FechaEntrega, OLD.IdCanal, OLD.IdCliente, OLD.IdEmpleado, OLD.IdProducto, OLD.Precio, OLD.Cantidad, CURRENT_USER(), NOW()),
      (CONCAT('Nuevo ', OLD.IdVenta),NEW.Fecha, NEW.FechaEntrega, NEW.IdCanal, NEW.IdCliente, NEW.IdEmpleado, NEW.IdProducto, NEW.Precio, NEW.Cantidad, CURRENT_USER(), NOW());
