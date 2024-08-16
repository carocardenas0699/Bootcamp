DROP DATABASE empresa_tec;
CREATE DATABASE empresa_tec;
USE empresa_tec;

CREATE TABLE Sucursales (IdSucursal INT NOT NULL, 
						 Sucursal VARCHAR(255), 
                         Direccion VARCHAR(255),
                         Localidad VARCHAR(255),
                         Provincia VARCHAR(255),
                         Latitud VARCHAR(255),
                         Longitud VARCHAR(255),
                         PRIMARY KEY(IdSucursal));
                         
CREATE TABLE Empleados (IdEmpleado INT NOT NULL,
						Apellido VARCHAR(255),
                        Nombre VARCHAR(255),
                        Sucursal VARCHAR(255),
                        Sector VARCHAR(255),
                        Cargo VARCHAR(255),
                        Salario INT,
                        PRIMARY KEY(idEmpleado));

CREATE TABLE Proveedores (IdProveedor INT NOT NULL,
						  Nombre VARCHAR(255),
                          Direccion VARCHAR(255),
                          Ciudad VARCHAR(255),
                          Estado VARCHAR(255),
                          Pais VARCHAR(255),
                          Departamento VARCHAR(255),
                          PRIMARY KEY(idProveedor));
                          
CREATE TABLE Clientes (IdCliente INT NOT NULL,
					   Provincia VARCHAR(255),
                       NombreCompleto VARCHAR(255),
                       Domicilio VARCHAR(255),
                       Telefono VARCHAR(255),
                       Edad INT,
                       Localidad VARCHAR(255),
                       Latitud VARCHAR(255),
                       Longitud VARCHAR(255),
                       PRIMARY KEY(IdCliente));
                       
CREATE TABLE Productos (IdProducto INT NOT NULL,
						Concepto VARCHAR(255),
                        Tipo VARCHAR(255),
                        Precio FLOAT,
                        PRIMARY KEY(IdProducto));
                        
CREATE TABLE CanalVentas (IdCanal INT NOT NULL, 
						  Descripcion VARCHAR(50),
                          PRIMARY KEY(IdCanal));
                          
CREATE TABLE Ventas (IdVenta INT NOT NULL,
					 Fecha DATE,
                     FechaEntrega DATE, 
                     IdCanal INT,
                     IdCliente INT,
                     IdSucursal INT,
                     IdEmpleado INT,
                     IdProducto INT,
                     Precio FLOAT,
                     Cantidad INT,
                     PRIMARY KEY(IdVenta),
                     FOREIGN KEY(IdCanal) REFERENCES CanalVentas(IdCanal),
                     FOREIGN KEY(IdCliente) REFERENCES Clientes(IdCliente),
                     FOREIGN KEY(IdSucursal) REFERENCES Sucursales(IdSucursal),
                     FOREIGN KEY(IdEmpleado) REFERENCES Empleados(IdEmpleado),
                     FOREIGN KEY(IdProducto) REFERENCES Productos(IdProducto));
                     
 CREATE TABLE TipoGasto (IdTipoGasto INT NOT NULL,
						 Descripcion VARCHAR(50),
                         MontoAprox INT,
                         PRIMARY KEY(IdTipoGasto));
                         
 CREATE TABLE Gastos (IdGasto INT NOT NULL,
					  IdSucursal INT,
                      IdTipoGasto INT,
                      Fecha DATE,
                      Monto FLOAT,
                      PRIMARY KEY(IdGasto),
                      FOREIGN KEY(IdSucursal) REFERENCES Sucursales(IdSucursal),
                      FOREIGN KEY(IdTipoGasto) REFERENCES TipoGasto(IdTipoGasto));
                      
CREATE TABLE Compras (IdCompra INT NOT NULL,
					  Fecha DATE,
                      IdProducto INT,
                      Cantidad INT,
                      Precio FLOAT,
                      IdProveedor INT,
                      PRIMARY KEY(IdCompra),
                      FOREIGN KEY(IdProducto) REFERENCES Productos(IdProducto),
                      FOREIGN KEY(IdProveedor) REFERENCES Proveedores(IdProveedor));
                     
