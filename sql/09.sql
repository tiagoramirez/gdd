SELECT
    e2.empl_codigo AS codigo_jefe,
    e.empl_codigo AS codigo_empleado,
    e.empl_nombre AS nombre_empleado,
    count(DISTINCT d.depo_codigo) AS cantidad_depositos_empleado,
    (
        SELECT
            count(DISTINCT depo_codigo)
        FROM
            DEPOSITO
        WHERE
            depo_encargado = e2.empl_codigo
    ) AS cantidad_depositos_jefe
FROM
    Empleado e
    INNER JOIN Empleado e2 ON e2.empl_codigo = e.empl_jefe
    INNER JOIN DEPOSITO d ON d.depo_encargado = e.empl_codigo
GROUP BY
    e2.empl_codigo,
    e.empl_codigo,
    e.empl_nombre