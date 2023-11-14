SELECT
    r.rubr_id,
    r.rubr_detalle,
    count(DISTINCT p.prod_codigo) AS cantidad_articulos,
    sum(stoc_cantidad) AS stock_total
FROM
    Rubro r
    INNER JOIN Producto p ON p.prod_rubro = r.rubr_id
    LEFT JOIN STOCK s ON s.stoc_producto = p.prod_codigo
WHERE
    p.prod_codigo IN (
        SELECT
            s2.stoc_producto
        FROM
            STOCK s2
        GROUP BY
            s2.stoc_producto
        HAVING
            sum(stoc_cantidad) >(
                SELECT
                    s3.stoc_cantidad
                FROM
                    STOCK s3
                WHERE
                    s3.stoc_producto = '00000000'
                    AND s3.stoc_deposito = '00'
            )
    )
GROUP BY
    r.rubr_id,
    r.rubr_detalle