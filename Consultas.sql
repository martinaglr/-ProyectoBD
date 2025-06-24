

---Consulta 1: Buscar reparaciones de un cliente específico por su nombre---

-- Activar profiling
SET PROFILING = 1; --copia de aqui, es para el tiempo

-- Consulta no optimizada
SELECT r.*
FROM Reparacion r
JOIN Cotizacion c ON r.ID_Cotizacion = c.ID
JOIN Cliente cl ON c.ID_Cliente = cl.ID
WHERE cl.Nombre LIKE '%Juan%';

-- Ver el tiempo de ejecución
SHOW PROFILES;--- hasta aca y asi con todos los codigos

--------------------0--------------------------------------
-- Activar profiling
SET PROFILING = 1; 

-- Consulta optimizada (usa índice y operador `=`)
SELECT r.*
FROM Reparacion r
JOIN Cotizacion c ON r.ID_Cotizacion = c.ID
JOIN Cliente cl ON c.ID_Cliente = cl.ID
WHERE cl.Nombre = 'Juan Pérez';

-- Ver el tiempo de ejecución
SHOW PROFILES;











--Consulta 2: Total de pagos realizados por cliente---

-- Activar profiling
SET PROFILING = 1;

-- Consulta no optimizada
SELECT cl.Nombre, SUM(p.Costo) AS TotalPagado
FROM Pago p
JOIN Cliente cl ON p.ID_Cliente = cl.ID
GROUP BY cl.Nombre;

-- Ver el tiempo de ejecución
SHOW PROFILES;

--------------------0--------------------------------------

-- Activar profiling
SET PROFILING = 1;

-- Consulta optimizada
SELECT cl.ID, cl.Nombre, SUM(p.Costo) AS TotalPagado
FROM Pago p
JOIN Cliente cl ON p.ID_Cliente = cl.ID
GROUP BY cl.ID, cl.Nombre;

-- Ver el tiempo de ejecución
SHOW PROFILES;







--Consulta 3: Listar los clientes que no han realizado ningún pago, pero sí han tenido una cotización registrada
--No Optimizada
SELECT cl.Nombre
FROM Cliente cl
WHERE cl.ID IN (
    SELECT ID_Cliente FROM Cotizacion
)
AND cl.ID NOT IN (
    SELECT ID_Cliente FROM Pago
);

--Optimizada 
-- Índices recomendados
CREATE INDEX idx_pago_idcliente ON Pago(ID_Cliente);
CREATE INDEX idx_cotizacion_idcliente ON Cotizacion(ID_Cliente);

SELECT DISTINCT cl.Nombre
FROM Cliente cl
JOIN Cotizacion c ON cl.ID = c.ID_Cliente
LEFT JOIN Pago p ON cl.ID = p.ID_Cliente
WHERE p.ID IS NULL;








--Consulta 4: Por cada cliente, mostrar el total pagado, el monto más alto, el más bajo y el promedio, solo si tiene más de 3 pagos y todos están completados (Estado = 'C')

SET PROFILING = 1;
--No Optimizada
SELECT 
    cl.Nombre,
    SUM(p.Costo),
    MAX(p.Costo),
    MIN(p.Costo),
    AVG(p.Costo)
FROM Cliente cl
JOIN Pago p ON cl.ID = p.ID_Cliente
WHERE p.Estado = 'C'
GROUP BY cl.Nombre
HAVING COUNT(p.ID) > 3;

SHOW PROFILES;
--------------------0--------------------------------------

SET PROFILING = 1;
--Optimizada
CREATE INDEX idx_pago_estado ON Pago(Estado);

SELECT 
    cl.ID,
    cl.Nombre,
    COUNT(p.ID) AS NumPagos,
    SUM(p.Costo) AS TotalPagado,
    MAX(p.Costo) AS PagoMaximo,
    MIN(p.Costo) AS PagoMinimo,
    AVG(p.Costo) AS PromedioPago
FROM Cliente cl
JOIN Pago p ON cl.ID = p.ID_Cliente
WHERE p.Estado = 'C'
GROUP BY cl.ID, cl.Nombre
HAVING COUNT(p.ID) > 3;
SHOW PROFILES;



--Consulta 5: Clientes que han tenido reparaciones en más de 3 áreas diferentes de mecánicos en los últimos 2 años

SET PROFILING = 1;
--No optimizada
SELECT cl.Nombre
FROM Cliente cl
JOIN Auto a ON cl.ID = a.ID_Cliente
JOIN Cotizacion c ON a.ID = c.ID_Auto
JOIN Reparacion r ON c.ID = r.ID_Cotizacion
JOIN Mecanico m ON r.ID_Mecanico = m.ID
WHERE r.Fecha_Inicio >= DATE_SUB(NOW(), INTERVAL 2 YEAR)
GROUP BY cl.ID, cl.Nombre
HAVING COUNT(DISTINCT m.Area) > 3;
SHOW PROFILES;


--------------------0--------------------------------------

SET PROFILING = 1;
--Optimizada
CREATE INDEX idx_reparacion_fechainicio ON Reparacion(Fecha_Inicio);
CREATE INDEX idx_mecanico_area ON Mecanico(Area);

SELECT cl.Nombre
FROM Cliente cl
JOIN Auto a ON cl.ID = a.ID_Cliente
JOIN Cotizacion c ON a.ID = c.ID_Auto
JOIN Reparacion r ON c.ID = r.ID_Cotizacion
JOIN Mecanico m ON r.ID_Mecanico = m.ID
WHERE r.Fecha_Inicio >= CURDATE() - INTERVAL 2 YEAR
GROUP BY cl.ID, cl.Nombre
HAVING COUNT(DISTINCT m.Area) > 3;
SHOW PROFILES;







--Consulta 6: Para cada mecánico, calcular el tiempo promedio en días que tarda en completar una reparación

SET PROFILING = 1;
--No Optimizado
SELECT m.Nombre, AVG(DATEDIFF(r.Fecha_Termino, r.Fecha_Inicio)) AS PromedioDias
FROM Reparacion r
JOIN Mecanico m ON r.ID_Mecanico = m.ID
GROUP BY m.Nombre;

SHOW PROFILES;



--------------------0--------------------------------------

SET PROFILING = 1;
--Optimizada
SELECT m.ID, m.Nombre, AVG(DATEDIFF(r.Fecha_Termino, r.Fecha_Inicio)) AS PromedioDias
FROM Reparacion r
JOIN Mecanico m ON r.ID = r.ID_Mecanico
GROUP BY m.ID, m.Nombre;
SHOW PROFILES;






--Consulta 7: Ranking global de los 10 repuestos más usados en reparaciones, junto con el ingreso total generado

SET PROFILING = 1;
--No Optmizado
SELECT rep.Nombre, COUNT(r.ID) AS VecesUsado, SUM(r.Costo) AS TotalIngreso
FROM Reparacion r
JOIN Repuesto rep ON r.ID_Repuesto = rep.ID
GROUP BY rep.Nombre
ORDER BY VecesUsado DESC
LIMIT 10;
SHOW PROFILES;


--------------------0--------------------------------------


SET PROFILING = 1;
--Optimizado
SELECT rep.ID, rep.Nombre, COUNT(r.ID) AS VecesUsado, SUM(r.Costo) AS TotalIngreso
FROM Reparacion r
JOIN Repuesto rep ON r.ID_Repuesto = rep.ID
GROUP BY rep.ID, rep.Nombre
ORDER BY VecesUsado DESC
LIMIT 10;
SHOW PROFILES;


