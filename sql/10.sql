SELECT
    p.prod_codigo,
    p.prod_detalle,
    (
        SELECT
            Top 1 f.fact_cliente
        FROM
            Item_Factura itf
            INNER JOIN Factura f ON f.fact_numero = itf.item_numero
            AND f.fact_sucursal = itf.item_sucursal
            AND f.fact_tipo = itf.item_tipo
            AND itf.item_producto = p.prod_codigo
        GROUP BY
            f.fact_cliente
        ORDER BY
            SUM(itf.item_cantidad) DESC
    )
FROM
    Producto p
WHERE
    p.prod_codigo IN(
        SELECT
            top 10 item_producto
        FROM
            Item_Factura
        GROUP BY
            item_producto
        ORDER BY
            SUM(item_cantidad) DESC
    )
    OR p.prod_codigo IN(
        SELECT
            top 10 item_producto
        FROM
            Item_Factura
        GROUP BY
            item_producto
        ORDER BY
            SUM(item_cantidad) ASC
    )