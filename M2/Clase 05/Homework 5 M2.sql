CREATE DATABASE henry;
USE henry;

CREATE TABLE Carrera (idCarrera INT NOT NULL AUTO_INCREMENT, 
						nombre VARCHAR(50) NOT NULL, PRIMARY KEY(idCarrera));
                        
CREATE TABLE Instructor (idInstructor INT NOT NULL AUTO_INCREMENT, 
							cedulaIdentidad VARCHAR(50), nombre VARCHAR(50), 
							apellido VARCHAR(50), 
							fechaNacimiento DATE, 
                            fechaIncorporacion DATE, 
                            PRIMARY KEY(idInstructor));
                            
CREATE TABLE Cohorte (idCohorte INT NOT NULL AUTO_INCREMENT, 
						codigo VARCHAR(50), 
						idCarrera INT, 
                        fechaInicio DATE, 
                        fechaFinalizacion DATE, 
                        idInstructor INT, 
						PRIMARY KEY(idCohorte), 
                        FOREIGN KEY(idCarrera) REFERENCES Carrera(idCarrera), 
                        FOREIGN KEY(idInstructor) REFERENCES Instructor(idInstructor));
                        
CREATE TABLE Alumno (idAlumno INT NOT NULL AUTO_INCREMENT, 
						cedulaIdentidad VARCHAR(50), 
                        nombre VARCHAR(50), 
                        apellido VARCHAR(50), 
						fechaNacimiento DATE, 	
                        fechaIngreso DATE, idCohorte INT, 
                        PRIMARY KEY(idAlumno), 
                        FOREIGN KEY(idCohorte) REFERENCES Cohorte(idCohorte));




