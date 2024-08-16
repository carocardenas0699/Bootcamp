USE empresa_tec;

LOAD DATA INFILE "Sucursales.csv"
INTO TABLE Sucursales
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(IdSucursal, Sucursal, Direccion, Localidad, Provincia, Latitud, Longitud);
SELECT * FROM Sucursales;

LOAD DATA INFILE "Empleados.csv" -- NO CARGO, VALORES REPETIDOS
INTO TABLE Empleados
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(IdEmpleado, Apellido, Nombre, Sucursal, Sector, Cargo, Salario);
SELECT * FROM Empleados;

LOAD DATA INFILE "Proveedores.csv"
INTO TABLE Proveedores
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(IdProveedor, Nombre, Direccion, Ciudad, Estado, Pais, Departamento);
SELECT * FROM Proveedores;

LOAD DATA INFILE "Clientes.csv"
INTO TABLE Clientes
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(IdCliente, Provincia, NombreCompleto, Domicilio, Telefono, Edad, Localidad, Longitud, Latitud,
@dummy,  @dummy, @dummy, @dummy, @dummy, @dummy);
SELECT * FROM Clientes;

LOAD DATA INFILE "PRODUCTOS.csv"
INTO TABLE Productos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(IdProducto, Concepto, Tipo, Precio);
SELECT * FROM Productos;

LOAD DATA INFILE "CanalDeVenta.csv"
INTO TABLE CanalVentas
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(IdCanal, Descripcion, @dummmy,@dummy);
SELECT * FROM CanalVentas;

LOAD DATA INFILE "Venta.csv" -- NO CARGA POPRQUE EMPLEADOS NO CARGO
INTO TABLE Ventas
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(IdVenta, Fecha, FechaEntrega, IdCanal, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad);
SELECT * FROM Ventas;

LOAD DATA INFILE "TiposDeGasto.csv"
INTO TABLE tipogasto
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(IdTipoGasto, Descripcion, MontoAprox);
SELECT * FROM tipogasto;

LOAD DATA INFILE "Gasto.csv"
INTO TABLE Gastos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(IdGasto, IdSucursal, IdTipoGasto, Fecha, Monto);
SELECT * FROM Gastos;

LOAD DATA INFILE "Compra.csv"
INTO TABLE Compras
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(IdCompra, Fecha, IdProducto, Cantidad, Precio, IdProveedor);
SELECT * FROM Compras;






