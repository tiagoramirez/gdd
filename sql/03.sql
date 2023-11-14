SELECT
    p.prod_codigo,
    p.prod_detalle,
    sum(s.stoc_cantidad) AS stock_total
FROM
    Producto p
    INNER JOIN STOCK s ON s.stoc_producto = p.prod_codigo
GROUP BY
    p.prod_codigo,
    p.prod_detalle
ORDER BY
    2 ASC