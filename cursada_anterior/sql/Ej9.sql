USE GD2015C1

-- 3 Posibles resoluciones de mi parte

SELECT J.empl_codigo AS codigo_jefe
    ,E.empl_codigo AS codigo_empleado
    ,E.empl_nombre AS nombre_empleado
    ,COUNT(DISTINCT depo_codigo) AS cantidad_depositos_empleado
FROM Empleado E
    INNER JOIN Empleado J ON E.empl_jefe=J.empl_codigo
    INNER JOIN DEPOSITO D ON E.empl_codigo=D.depo_encargado
GROUP BY J.empl_codigo
,E.empl_codigo
,E.empl_nombre

SELECT E.empl_jefe AS codigo_jefe
    ,E.empl_codigo AS codigo_empleado
    ,E.empl_nombre AS nombre_empleado
    ,COUNT(DISTINCT depo_codigo) AS cantidad_depositos_empleado
    ,(SELECT COUNT(DISTINCT depo_codigo)
    FROM DEPOSITO
    WHERE depo_encargado=E.empl_jefe) AS cantidad_depositos_jefe
FROM Empleado E
    INNER JOIN DEPOSITO D ON E.empl_codigo=D.depo_encargado
GROUP BY E.empl_jefe
,E.empl_codigo
,E.empl_nombre

SELECT J.empl_codigo AS codigo_jefe
    ,E.empl_codigo AS codigo_empleado
    ,E.empl_nombre AS nombre_empleado
    ,COUNT(DISTINCT depo_codigo) AS  cantidad_depositos
FROM Empleado E JOIN Empleado J ON J.empl_codigo = E.empl_jefe
    JOIN DEPOSITO ON E.empl_jefe = depo_encargado
        OR E.empl_codigo = depo_encargado
GROUP BY J.empl_codigo
    ,E.empl_codigo
    ,E.empl_nombre
