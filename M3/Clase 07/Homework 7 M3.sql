USE empresa_tech;

-- Crear las Primary Keys faltantes
ALTER TABLE Clientes 
ADD PRIMARY KEY (IdCliente);

ALTER TABLE Empleados
ADD PRIMARY KEY (IdEmpleado);

-- Crear las Foreign Keys faltantes
ALTER TABLE Clientes
ADD FOREIGN KEY (IdLocalidad) REFERENCES Localidades(IdLocalidad);

ALTER TABLE Clientes
ADD FOREIGN KEY (IdLocalidad) REFERENCES Localidades(IdLocalidad);

ALTER TABLE Empleados
ADD FOREIGN KEY (IdSucursal) REFERENCES Sucursales(IdSucursal);
ALTER TABLE Empleados
ADD FOREIGN KEY (IdSector) REFERENCES Sectores(IdSector);
ALTER TABLE Empleados
ADD FOREIGN KEY (IdCargo) REFERENCES Cargos(IdCargo);

ALTER TABLE Localidades
ADD FOREIGN KEY (IdProvincia) REFERENCES Provincias(IdProvincia);

ALTER TABLE Productos
ADD FOREIGN KEY (IdTipoProducto) REFERENCES TipoProducto(IdTipoProducto);

ALTER TABLE Proveedores
ADD FOREIGN KEY (IdLocalidad) REFERENCES Localidades(IdLocalidad);

ALTER TABLE Sucursales
ADD FOREIGN KEY (IdLocalidad) REFERENCES Localidades(IdLocalidad);

ALTER TABLE Ventas
ADD FOREIGN KEY (IdEmpleado) REFERENCES Empleados(IdEmpleado); -- ERROR
ALTER TABLE Ventas
ADD FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente);

-- Crear indices
ALTER TABLE Ventas ADD INDEX(IdProducto);
ALTER TABLE Ventas ADD INDEX(IdEmpleado);
ALTER TABLE Ventas ADD INDEX(Fecha);
ALTER TABLE Ventas ADD INDEX(Fecha_Entrega);
ALTER TABLE Ventas ADD INDEX(IdCliente);
ALTER TABLE Ventas ADD INDEX(IdSucursal);
ALTER TABLE Ventas ADD INDEX(IdCanal);

ALTER TABLE Productos ADD INDEX(IdTipoProducto);

ALTER TABLE Sucursales ADD INDEX(IdLocalidad);

ALTER TABLE Empleados ADD INDEX(IdSucursal);
ALTER TABLE Empleados ADD INDEX(IdSector);
ALTER TABLE Empleados ADD INDEX(IdCargo);

ALTER TABLE Localidades ADD INDEX(IdProvincia);

ALTER TABLE Proveedores ADD INDEX(IdLocalidad);

ALTER TABLE Gastos ADD INDEX(IdSucursal);
ALTER TABLE Gastos ADD INDEX(IdTipoGasto);
ALTER TABLE Gastos ADD INDEX(Fecha);

ALTER TABLE Clientes ADD INDEX(IdLocalidad);

ALTER TABLE Compras ADD INDEX(Fecha);
ALTER TABLE Compras ADD INDEX(IdProducto);
ALTER TABLE Compras ADD INDEX(IdProveedor);

-- Nueva tabla
CREATE TABLE FactVenta (IdVenta INT,
                        Fecha DATE,
						FechaEntrega DATE,
						IdCanal INT,
						IdCliente INT,
						IdEmpleado INT,
						IdProducto INT,
						Precio FLOAT,
						Cantidad INT);

INSERT INTO factVenta
SELECT IdVenta, Fecha, FechaEntrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
FROM ventas
WHERE YEAR(Fecha) = 2020;
