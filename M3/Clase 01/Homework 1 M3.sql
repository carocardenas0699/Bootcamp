USE adventureworks;

-- Punto 1 : Crear un procedimiento que recibe como parámetro una fecha y muestre la cantidad de órdenes ingresadas en esa fecha.

DELIMITER $$

CREATE PROCEDURE ordenes_ingresadas(IN fecha DATE)
BEGIN
	SELECT COUNT(*)
    FROM salesorderheader
    WHERE DATE(OrderDate) = fecha;
    
END $$

DELIMITER ;

CALL ordenes_ingresadas('2001-06-30');

-- Punto 2:Crear una función que calcule el valor nominal de un margen bruto determinado por el usuario a partir del precio 
--         de lista de los productos.

DELIMITER $$

CREATE FUNCTION valor_nominal(precio double, margen double) RETURNS DOUBLE DETERMINISTIC
BEGIN
	DECLARE resultado DOUBLE;
    SET resultado = precio * margen;
    RETURN resultado;
    
END $$

DELIMITER ;

-- Punto 3: Obtener un listado de productos en orden alfabético que muestre cuál debería ser el valor de precio de lista, 
--          si se quiere aplicar un margen bruto del 20%, utilizando la función creada en el punto 2, sobre el campo StandardCost. 
--          Mostrando tambien el campo ListPrice y la diferencia con el nuevo campo creado.

SELECT Name, StandardCost, ListPrice, ListPrice - valor_nominal(StandardCost, 1.2) AS Precio
FROM product
ORDER BY Name;

-- Punto 4: Crear un procedimiento que reciba como parámetro una fecha desde y una hasta, y muestre un listado con los Id de los 
--          diez Clientes que más costo de transporte tienen entre esas fechas (campo Freight).

DELIMITER $$

CREATE PROCEDURE costo_transporte (IN antes DATE, IN despues DATE)
BEGIN
	SELECT CustomerID, Freight
    FROM salesorderheader
    WHERE DATE(OrderDate) > antes AND DATE(OrderDate) < despues
    ORDER BY Freight
    LIMIT 10;
END $$
DELIMITER ;

SELECT * FROM salesorderheader;

CALL costo_transporte ('2001-07-15','2001-08-31');

-- Punto 5: Crear un procedimiento que permita realizar la insercción de datos en la tabla shipmethod.

SELECT * FROM shipmethod;

DELIMITER $$

CREATE PROCEDURE insercion_datos(IN nombre VARCHAR(50), IN val_shipbase DOUBLE, IN val_shiprate DOUBLE)
BEGIN 
	INSERT INTO shipmethod (Name,ShipBase,ShipRate) VALUES (nombre, val_shipbase, val_shiprate);
END $$

DELIMITER ;

CALL insercion_datos('nombre',0.4,95.34);

