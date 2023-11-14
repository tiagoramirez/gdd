SELECT
    p.prod_codigo,
    p.prod_detalle,
    sum(isnull(c.comp_cantidad, 1)) AS cantidad_componentes
FROM
    Producto p
    LEFT JOIN Composicion c ON c.comp_producto = p.prod_codigo
    INNER JOIN (
        SELECT
            stoc_producto,
            AVG(stoc_cantidad) AS stock_prom
        FROM
            STOCK
        GROUP BY
            stoc_producto
        HAVING
            AVG(stoc_cantidad) > 100
    ) s ON s.stoc_producto = p.prod_codigo
GROUP BY
    p.prod_codigo,
    p.prod_detalle