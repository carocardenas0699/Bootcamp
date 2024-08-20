
CREATE TABLE clientes_copy AS
    SELECT IdCliente, Provincia, NombreCompleto, Direccion, Telefono, Edad, Localidad, Latitud, Longitud,
Fecha_Alta, Usuario_Alta, Fecha_Ultima_Modificacion, Usuario_Ultima_Modificacion, Marca_Baja
    FROM clientes;

CREATE TABLE sucursales_copy AS
	SELECT IdSucursal, Sucursal, Direccion, Localidad, Provincia, Latitud, Longitud
    FROM sucursales;
    
CREATE TABLE proveedores_copy AS
	SELECT IdProveedor, Nombre, Direccion, Ciudad, Estado, Departamento
    FROM proveedores;
    
    