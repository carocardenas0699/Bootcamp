CREATE DATABASE call_center;
USE call_center;

DROP TABLE calls;
CREATE TABLE calls(vru_line VARCHAR(10),
                   call_id INT,
                   customer_id VARCHAR(50),
                   priority TINYINT,
                   tipo VARCHAR(5),
                   fecha DATE,
                   vru_entry VARCHAR(50),
                   vru_exit VARCHAR(50),
                   vru_time INT,
                   q_start VARCHAR(50),
                   q_exit VARCHAR(50),
                   q_time INT,
                   outcome VARCHAR(10),
                   ser_start VARCHAR(50),
                   ser_exit VARCHAR(50),
                   ser_time INT,
                   agente VARCHAR(50),
                   startdate INT);
                   
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Call_Center_1999_DataSet.csv'
INTO TABLE calls
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM calls;

UPDATE calls SET vru_line = REPLACE(vru_line,'"','');
UPDATE calls SET customer_id = REPLACE(customer_id,'"','');
UPDATE calls SET tipo = REPLACE(tipo,'"','');
UPDATE calls SET vru_entry = REPLACE(vru_entry,'"','');
UPDATE calls SET vru_exit = REPLACE(vru_exit,'"','');
UPDATE calls SET q_start = REPLACE(q_start,'"','');
UPDATE calls SET q_exit = REPLACE(q_exit,'"','');
UPDATE calls SET outcome = REPLACE(outcome,'"','');
UPDATE calls SET ser_start = REPLACE(ser_start,'"','');
UPDATE calls SET ser_exit = REPLACE(ser_exit,'"','');
UPDATE calls SET agente = REPLACE(agente,'"','');

ALTER TABLE calls MODIFY COLUMN customer_id INT;