CREATE DATABASE henry;
USE henry;

CREATE TABLE Carreras (idCarrera INT NOT NULL AUTO_INCREMENT, 
						nombre VARCHAR(50) NOT NULL, PRIMARY KEY(idCarrera));
                        
CREATE TABLE Instructores (idInstructores INT NOT NULL AUTO_INCREMENT, 
							cedulaIdentidad VARCHAR(50), nombre VARCHAR(50), 
							apellido VARCHAR(50), 
							fechaNacimiento DATE, 
                            fechaIncorporacion DATE, 
                            PRIMARY KEY(idInstructores));
                            
CREATE TABLE Cohortes (idCohorte INT NOT NULL AUTO_INCREMENT, 
						codigo VARCHAR(50), 
						carrera INT, 
                        fechaInicio DATE, 
                        fechaFinalizacion DATE, 
                        instructor INT, 
						PRIMARY KEY(idCohorte), 
                        FOREIGN KEY(carrera) REFERENCES Carreras(idCarrera), 
                        FOREIGN KEY(instructor) REFERENCES Instructores(idInstructores));
                        
CREATE TABLE Alumnos (idAlumnos INT NOT NULL AUTO_INCREMENT, 
						cedulaIdentidad VARCHAR(50), 
                        nombre VARCHAR(50), 
                        apellido VARCHAR(50), 
						fechaNacimiento DATE, 	
                        fechaIngreso DATE, cohorte INT, 
                        PRIMARY KEY(idAlumnos), 
                        FOREIGN KEY(cohorte) REFERENCES Cohortes(idCohorte));




