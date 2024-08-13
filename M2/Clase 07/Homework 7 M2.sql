USE henry;

-- Punto 1: ¿Cuantas carreas tiene Henry?
SELECT COUNT(*)
FROM carreras;
 
-- Punto 2: ¿Cuantos alumnos hay en total?
SELECT COUNT(*)
FROM alumnos;

-- Punto 3: ¿Cuantos alumnos tiene cada cohorte?
SELECT cohorte, COUNT(*) as TotalAlumnos
FROM alumnos
GROUP BY cohorte;

-- Punto 4: Confecciona un listado de los alumnos ordenado por los últimos alumnos que ingresaron, con nombre y apellido en un solo campo.
SELECT fechaIngreso, CONCAT(nombre, " ", apellido) as NombreCompleto
FROM alumnos
ORDER BY fechaIngreso DESC;

-- Punto 5: ¿Cual es el nombre del primer alumno que ingreso a Henry?
SELECT CONCAT(nombre, " ", apellido) as NombreCompleto
FROM alumnos
ORDER BY fechaIngreso
LIMIT 1;

-- Punto 6: ¿En que fecha ingreso?
SELECT fechaIngreso
FROM alumnos
ORDER BY fechaIngreso
LIMIT 1;

-- Punto 7: ¿Cual es el nombre del ultimo alumno que ingreso a Henry?
SELECT CONCAT(nombre, " ", apellido) as NombreCompleto
FROM alumnos
ORDER BY fechaIngreso DESC
LIMIT 1;

-- Punto 8: La función YEAR le permite extraer el año de un campo date, utilice esta función y 
--          especifique cuantos alumnos ingresarona a Henry por año.
SELECT YEAR(fechaIngreso) as AñoIngreso, COUNT(*) as Alumnos
FROM alumnos
GROUP BY AñoIngreso
ORDER BY AñoIngreso;

-- Punto 9: ¿Cuantos alumnos ingresaron por semana a henry?, indique también el año. WEEKOFYEAR() 
SELECT WEEKOFYEAR(fechaIngreso) as SemanaIngreso,  YEAR(fechaIngreso) as AnioIngreso, COUNT(*) as Alumnos
FROM alumnos
GROUP BY SemanaIngreso, AnioIngreso
ORDER BY SemanaIngreso, AnioIngreso;

-- Punto 10: ¿En que años ingresaron más de 20 alumnos?
SELECT YEAR(fechaIngreso) as AnioIngreso, COUNT(*) as CantidadAlumnos
FROM alumnos
GROUP BY AnioIngreso
HAVING CantidadAlumnos > 20;

/* Punto 11: Investigue las funciones TIMESTAMPDIFF() y CURDATE(). ¿Podría utilizarlas para saber cual es la edad de los instructores?.
			¿Como podrías verificar si la función cálcula años completos? Utiliza DATE_ADD(). */
SELECT CONCAT(nombre, " ", apellido) as NombreCompleto, TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE()) as Edad
FROM instructores;

/* Punto 12: Cálcula:
				- La edad de cada alumno.
				- La edad promedio de los alumnos de henry.
				- La edad promedio de los alumnos de cada cohorte.*/
SELECT CONCAT(nombre, " ", apellido) as NombreCompleto, TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE()) as Edad
FROM alumnos;

SELECT AVG(TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE())) as PromedioEdad
FROM alumnos;

SELECT cohorte, AVG(TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE())) as PromedioEdad
FROM alumnos
GROUP BY cohorte;

SELECT concat(nombre, ' ', apellido) AS NombreCompleto, timestampdiff(YEAR, fechaNacimiento, curdate()) AS Edad,
date_add(fechaNacimiento,interval timestampdiff(Year,fechaNacimiento, curdate()) year) as verificacion,
fechaNacimiento
FROM alumnos
ORDER BY 1;

-- Punto 13: Elabora un listado de los alumnos que superan la edad promedio de Henry. 
SELECT CONCAT(nombre, " ", apellido) AS NombreCompleto, TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) AS Edad
FROM alumnos
WHERE TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) >
      (SELECT AVG(TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()))
       FROM alumnos)
ORDER BY 2;
