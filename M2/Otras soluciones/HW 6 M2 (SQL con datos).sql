SELECT COUNT(*) FROM alumno;

/*2.- No se sabe con certeza el lanzamiento de las cohortes N° 1245 y N° 1246, 
se solicita que las elimine de la tabla.*/
DELETE FROM cohorte
WHERE idCohorte IN(1245,1246);

/*3- Se ha decidido retrasar el comienzo de la cohorte N°1243, por lo que la nueva fecha de inicio será el 16/05.
 Se le solicita modificar la fecha de inicio de esos alumnos.*/
 
SELECT * FROM cohorte;

UPDATE cohorte
SET fechaInicio = '2022-05-16'
WHERE idCohorte = 1243;

/*4- El alumno N° 165 solicito el cambio de su Apellido por “Ramirez”.*/
UPDATE alumno
SET apellido = 'Ramirez'
WHERE idAlumno = 165;

/*5- El área de Learning le solicita un listado de alumnos de la 
Cohorte N°1243 que incluya la fecha de ingreso.*/

SELECT nombre, apellido, idCohorte FROM alumno
WHERE idCohorte = 1243;

/*6- Como parte de un programa de actualización, el área de People
 le solicita un listado de los instructores que dictan la carrera 
 de Full Stack Developer.*/
SELECT * FROM carrera;
SELECT idInstructor, idCohorte FROM cohorte WHERE idCarrera = 1;
SELECT * FROM instructor WHERE idInstructor <= 5;

-- JOIN
SELECT DISTINCT instructor.nombre, instructor.apellido, carrera.nombre
FROM instructor 
JOIN cohorte ON cohorte.idInstructor = instructor.idInstructor
JOIN carrera ON carrera.idCarrera = cohorte.idCarrera
WHERE carrera.nombre LIKE 'Full%';

/*7- Se desea saber que alumnos formaron parte de la cohorte N° 1235.
 Elabore un listado.*/
SELECT nombre, apellido
FROM alumno
WHERE idCohorte = 1235;

/*8- Del listado anterior se desea saber quienes ingresaron en el año 2019.*/
SELECT nombre, apellido, fechaIngreso
FROM alumno
WHERE idCohorte=1235 AND YEAR(fechaIngreso) = 2019;

/*9- La siguiente consulta permite acceder a datos de otras tablas y devolver un 
listado con la carrera a la cual pertenece cada alumno:*/

SELECT DISTINCT a.nombre, a.apellido, ca.nombre
FROM alumno as a
JOIN cohorte as c ON c.idCohorte = a.idCohorte
JOIN carrera as ca ON ca.idCarrera = c.idCarrera;
-- Error Code: 1146. Table 'henry.alumnos' doesn't exist

/*Coneste la siguientes interrogantes: 
a. ¿Que campos permiten que se puedan acceder al nombre de la carrera?*/ 

#Respuesta
-- llave de union ca.idCarrera, columna con el nombre ca.nombre

/*b. ¿Que tipo de ralación existe entre el nombre la tabla cohortes y 
alumnos? 
#Respuesta
-- una cohorte muchos alumnos. 1 - N

c. ¿Proponga dos opciones para filtrar el listado solo por los alumnos que 
pertenecen a 'Full Stack Developer', utilizando LIKE y NOT LIKE?, 
¿Cual de las dos opciones es la manera correcta de hacerlo?, ¿Por que? 
d. ¿Proponga dos opciones para filtrar el listado solo por los alumnos
 que pertenecen a 'Full Stack Developer', utilizando " = " y " != "? 
 ¿Cual de las dos opciones es la manera correcta de hacerlo?, ¿Por que? 
 e. ¿Como emplearía el filtrado utilizando el campo idCarrera?*/
SELECT DISTINCT a.nombre, a.apellido, ca.nombre
FROM alumno as a
JOIN cohorte as c ON c.idCohorte = a.idCohorte
JOIN carrera as ca ON ca.idCarrera = c.idCarrera
-- WHERE ca.nombre LIKE '%Full Stack Developer%'; #Correcto
-- WHERE ca.nombre NOT LIKE '%Data%';
-- WHERE ca.nombre = 'Full Stack Developer'; #Correcta
-- WHERE ca.nombre <> 'Data Science'; #!=
WHERE ca.idCarrera = 1;

SELECT DISTINCT a.nombre, a.apellido
FROM alumno as a
JOIN cohorte as c ON c.idCohorte = a.idCohorte
WHERE c.idCarrera != 1;



