SELECT * 
FROM alumno
ORDER BY fechaIngreso DESC 
LIMIT 3, 10;
-- LIMIT 10 OFFSET 3;
#------

SELECT COUNT(*)
FROM alumno
WHERE idCohorte = 1235;

SELECT COUNT(fechaFinalizacion) FROM cohorte;

SELECT SUM(idAlumno) FROM alumno;

SELECT MIN(idAlumno) FROM alumno;

SELECT AVG(year(current_date()) - year(fechaNacimiento)) FROM alumno;

SELECT idCarrera, count(*) as cantidad
FROM cohorte
GROUP BY idCarrera
HAVING cantidad > 3;





