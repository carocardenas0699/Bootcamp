USE call_center;

#Cantidad de customers no identificados
SELECT * FROM calls
WHERE customer_id = 0; #227.561

#Cantidad de customers no identificados que no esperaron en cola
SELECT * FROM calls
WHERE customer_id = 0 AND q_time = 0; #168.642

#Cantidad de customers no identificados que son prospectos
SELECT * FROM calls
WHERE customer_id = 0 AND tipo = 'NW'; #67.294

#Cantidad de customers no identificados que esperaron en cola
SELECT * FROM calls
WHERE customer_id = 0 AND q_time != 0; #58.919

#Cantidad de customers no identificados por outcome
SELECT outcome, COUNT(*) FROM calls
WHERE customer_id = 0
GROUP BY outcome;

