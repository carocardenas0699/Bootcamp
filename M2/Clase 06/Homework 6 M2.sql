USE henry;

SELECT * FROM alumnos;
SELECT * FROM cohortes;

-- Punto 2: No se sabe con certeza el lanzamiento de las cohortes N° 1245 y N° 1246, se solicita que las elimine de la tabla.
-- DELETE FROM cohortes WHERE idCohorte = 1246;

-- Punto 3: Se ha decidido retrasar el comienzo de la cohorte N°1243, por lo que la nueva fecha de inicio será el 16/05. 
--          Se le solicita modificar la fecha de inicio de esos alumnos.
UPDATE cohortes
SET fechaInicio ='2022-05-16'
WHERE idCohorte = 1243;

-- Punto 4: El alumno N° 165 solicito el cambio de su Apellido por “Ramirez”.
UPDATE alumnos
SET apellido = 'Ramirez'
WHERE idAlumnos = 165;

-- Punto 5: El área de Learning le solicita un listado de alumnos de la Cohorte N°1243 que incluya la fecha de ingreso.
SELECT nombre, apellido, fechaIngreso FROM alumnos
WHERE cohorte = 1243;

-- Punto 6: Como parte de un programa de actualización, el área de People le solicita un listado de los instructores
--          que dictan la carrera de Full Stack Developer.
-- Op 1 (Soy Henry)
SELECT instructor FROM cohortes
WHERE carrera = 1;

SELECT *
FROM instructores
WHERE idInstructores <= 5;

-- Punto 6 Op 2
SELECT DISTINCT instructores.nombre, instructores.apellido, carreras.nombre
FROM cohortes
JOIN instructores ON instructores.IdInstructores = cohortes.instructor
JOIN carreras ON carreras.idCarrera = cohortes.carrera
WHERE cohortes.carrera = 1;

-- Punto 7: Se desea saber que alumnos formaron parte de la cohorte N° 1235. Elabore un listado.
SELECT * FROM alumnos
WHERE cohorte = 1235;

-- Punto 8: Del listado anterior se desea saber quienes ingresaron en el año 2019.
SELECT * FROM alumnos
WHERE cohorte = 1235 AND YEAR(fechaIngreso)=2019;

-- Punto 9: Un listado con la carrera a la cual pertenece cada alumno
SELECT alumnos.nombre, apellido, fechaNacimiento, carreras.nombre
FROM alumnos
INNER JOIN cohortes
ON cohorte=idCohorte
INNER JOIN carreras
ON carrera = idCarrera;

/*Coneste la siguientes interrogantes: 
a. ¿Que campos permiten que se puedan acceder al nombre de la carrera? 
	llave de union idCarrera, columna con el nombre nombre
b. ¿Que tipo de relación existe entre el nombre la tabla cohortes y alumnos? 
	1 - N: 1 cohorte - muchos alumnos
c. ¿Proponga dos opciones para filtrar el listado solo por los alumnos que pertenecen a 'Full Stack Developer', 
utilizando LIKE y NOT LIKE?, ¿Cual de las dos opciones es la manera correcta de hacerlo?, ¿Por que? 
	WHERE ca.nombre LIKE '%Full Stack Developer%'; #Correcto
    WHERE ca.nombre NOT LIKE '%Data%'; "No es eficiente si hay muchas opciones
d. ¿Proponga dos opciones para filtrar el listado solo por los alumnos que pertenecen a 'Full Stack Developer',
 utilizando " = " y " != "? ¿Cual de las dos opciones es la manera correcta de hacerlo?, ¿Por que? 
	WHERE ca.nombre = 'Full Stack Developer'; #Correcta
    WHERE ca.nombre != 'Data Science'; #Es igual que usar <>
e. ¿Como emplearía el filtrado utilizando el campo idCarrera?
	WHERE carrera.idCarrera = 1;
    WHERE c.idCarrera != 1;*/
