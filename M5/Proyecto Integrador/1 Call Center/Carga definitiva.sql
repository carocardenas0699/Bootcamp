CREATE DATABASE call_center;
USE call_center;

DROP TABLE calls;
CREATE TABLE calls(vru_line VARCHAR(10),
                   call_id INT,
                   customer_id VARCHAR(50),
                   priority TINYINT,
                   tipo VARCHAR(5),
                   fecha DATE,
                   vru_entry TIME,
                   vru_exit TIME,
                   vru_time FLOAT,
                   q_start TIME,
                   q_exit TIME,
                   q_time FLOAT,
                   outcome VARCHAR(10),
                   ser_start TIME,
                   ser_exit TIME,
                   ser_time FLOAT,
                   agente VARCHAR(50),
                   startdate INT);
                   
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Call_Center_1999.csv'
INTO TABLE calls
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES; 

ALTER TABLE calls DROP COLUMN vru_exit;
ALTER TABLE calls DROP COLUMN q_exit;
ALTER TABLE calls DROP COLUMN ser_exit;
ALTER TABLE calls DROP COLUMN q_start;
ALTER TABLE calls DROP COLUMN ser_start;
ALTER TABLE calls DROP COLUMN startdate;

UPDATE calls SET vru_time = vru_time/60;
UPDATE calls SET q_time = q_time/60;
UPDATE calls SET ser_time = ser_time/60;

ALTER TABLE calls
ADD COLUMN cod VARCHAR(50);

UPDATE calls SET cod = CONCAT(vru_line,call_id);

SELECT * FROM calls
WHERE q_time > 400; #Super outliers q_time

DROP TABLE analysis_q_time;
CREATE TABLE analysis_q_time (vru_line VARCHAR(10),
							  call_id INT,
							  customer_id VARCHAR(50),
							  priority TINYINT,
							  tipo VARCHAR(5),
							  fecha DATE,
							  vru_entry TIME,
							  vru_time FLOAT,
							  q_time FLOAT,
							  outcome VARCHAR(10),
							  ser_time FLOAT,
							  agente VARCHAR(50),
                              cod VARCHAR(50),
                              out_sig TINYINT,
                              out_bp TINYINT);

INSERT INTO analysis_q_time 
SELECT vru_line, call_id, customer_id, priority, tipo, fecha, vru_entry, vru_time, q_time, outcome,
	   ser_time, agente, cod, 1, 1
FROM calls;

SELECT * FROM analysis_q_time;

CREATE TABLE Outliers_qTime (vru_line VARCHAR(10),
                   call_id INT,
                   customer_id VARCHAR(50),
                   priority TINYINT,
                   tipo VARCHAR(5),
                   fecha DATE,
                   vru_entry TIME,
                   vru_time FLOAT,
                   q_time FLOAT,
                   outcome VARCHAR(10),
                   ser_time FLOAT,
                   agente VARCHAR(50),
                   cod VARCHAR(60),
                   metodo TINYINT);
                   
#Insertar outliers segun regla de los 3 sigmas en tabla. MAX='6.956914775950615' MIN='-4.990104634804974'
INSERT INTO Outliers_qTime
SELECT vru_line, call_id, customer_id, priority, tipo, fecha, vru_entry, vru_time, q_time, outcome,
	   ser_time, agente, cod, 1
FROM calls
WHERE q_time > (SELECT AVG(q_time) FROM calls) + (3 * (SELECT stddev(q_time) FROM calls)) 
	  OR q_time < (SELECT AVG(q_time) FROM calls) - (3 * (SELECT stddev(q_time) FROM calls)); #5.184 outliers 
							
#Insertar outliers segun BoxPlot. MAX='3.2916675' MIN='0'
INSERT INTO Outliers_qTime
SELECT vru_line, call_id, customer_id, priority, tipo, fecha, vru_entry, vru_time, q_time, outcome,
	   ser_time, agente, cod, 2
FROM calls
WHERE q_time > 3.2916675 OR q_time < 0; #37.237 Outliers

#Asigna metodo de calculo a la tabla de analisis
UPDATE analysis_q_time a
JOIN  Outliers_qTime o ON a.cod = o.cod
SET a.out_sig = 0
WHERE o.metodo = 1;

SELECT * FROM analysis_q_time; #444448
SELECT * FROM Outliers_qTime; #42421

SELECT * FROM Outliers_qTime
WHERE metodo = 1; #5184

SELECT * FROM Outliers_qTime
WHERE metodo = 2; #37237

SELECT * FROM analysis_q_time a
WHERE cod = 'AA02075620'; #1

SELECT * FROM Outliers_qTime
WHERE cod = 'AA02075620'; #2

SELECT * FROM calls c
JOIN  Outliers_qTime o ON c.cod = o.cod
WHERE c.cod = 'AA02075620'; #2

SELECT cod, COUNT(*) FROM calls
GROUP BY cod;

SELECT call_id, COUNT(*) FROM calls
GROUP BY call_id;