CREATE DATABASE negHenry;
USE negHenry;

CREATE TABLE Carreras (idCarrera INT NOT NULL auto_increment, nombre varchar(50), PRIMARY KEY(idCarrera));
CREATE TABLE Instructores (idInstructores INT NOT NULL auto_increment, cedulaIdentidad varchar(50), nombre varchar(50), 
apellido varchar(50), fechaNacimiento date, fechaIncorporacion date, PRIMARY KEY(idInstructores));
CREATE TABLE Cohortes (idCohorte INT NOT NULL auto_increment, codigo varchar(50), 
carrera int, fechaInicio date, fechaFinalizacion date, instructor int, 
PRIMARY KEY(idCohorte), FOREIGN KEY(carrera) REFERENCES Carreras(idCarrera), FOREIGN KEY(instructor) REFERENCES Instructores(idInstructores));
CREATE TABLE Alumnos (idAlumnos INT NOT NULL auto_increment, cedulaIdentidad varchar(50), nombre varchar(50), apellido varchar(50), 
fechaNacimiento date, fechaIngreso date, cohorte int, PRIMARY KEY(idAlumnos), FOREIGN KEY(cohorte) REFERENCES Cohortes(idCohorte));




