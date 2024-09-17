USE call_center;

######### OUTLIERS

#Se crea una copia de la tabla para evaluar los outliers de q_time
CREATE TABLE analysis_ser_time LIKE calls;
ALTER TABLE analysis_ser_time ADD COLUMN out_sig TINYINT;
ALTER TABLE analysis_ser_time ADD COLUMN out_bp TINYINT;

INSERT INTO analysis_ser_time 
SELECT *, 1, 1 FROM calls;

SELECT * FROM analysis_ser_time; #444.4483

#Se crea tabla que guarda los outliers de q_time
DROP TABLE outliers_ser_time; 
CREATE TABLE outliers_ser_time LIKE calls;
ALTER TABLE outliers_ser_time ADD COLUMN metodo TINYINT;

#Insertar outliers segun regla de los 3 sigmas en tabla. MAX='16.661318412545157' MIN='-11.575925895853311'
INSERT INTO outliers_ser_time
SELECT *, 1
FROM calls
WHERE ser_time > (SELECT AVG(ser_time) FROM calls) + (3 * (SELECT stddev(ser_time) FROM calls)) 
	  OR ser_time < (SELECT AVG(ser_time) FROM calls) - (3 * (SELECT stddev(ser_time) FROM calls))
      OR ser_time < 0; #5.815 outliers (1.31%)
							
#Insertar outliers segun BoxPlot. MAX='7.408333333333333' MIN='0'
INSERT INTO outliers_ser_time
SELECT *, 2
FROM calls
WHERE ser_time > 7.408333333333333 OR ser_time < 0; #32.381 Outliers (7.29%)

SELECT * FROM outliers_ser_time; #38.196

#Crear indice porque si no se putea
CREATE INDEX i_calls ON analysis_ser_time(cod);

#Asigna metodo de calculo a la tabla de analisis
UPDATE analysis_ser_time a
JOIN  outliers_ser_time o ON a.cod = o.cod
SET a.out_sig = 0
WHERE o.metodo=1;

UPDATE analysis_ser_time a
JOIN  outliers_ser_time o ON a.cod = o.cod
SET a.out_bp = 0
WHERE o.metodo=2;

#Calculo de promedios
#Normal
SELECT AVG(ser_time) FROM analysis_ser_time; #'2.542696258345923'
#Sin outliers sigma
SELECT AVG(ser_time*out_sig)FROM analysis_ser_time; #'2.1977074557892458'
#Sin outliers BoxPlot
SELECT AVG(ser_time*out_bp)FROM analysis_ser_time; #'1.5724910826836664'

#Calculo de desviaciones
#Normal
SELECT stddev(ser_time) FROM analysis_ser_time; #'4.706207384733078'
#Sin outliers sigma
SELECT stddev(ser_time*out_sig)FROM analysis_ser_time; #'2.742399817511373'
#Sin outliers BoxPlot
SELECT stddev(ser_time*out_bp)FROM analysis_ser_time; #'1.727896919444546'
