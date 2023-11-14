SELECT
    p.prod_detalle,
    max(s.stoc_cantidad)
FROM
    Producto p
    INNER JOIN STOCK s ON s.stoc_producto = p.prod_codigo
GROUP BY
    p.prod_detalle
HAVING
    COUNT(DISTINCT S.stoc_deposito) = (
        SELECT
            COUNT(DISTINCT D.depo_codigo)
        FROM
            DEPOSITO D
    )