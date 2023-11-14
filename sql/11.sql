SELECT
    TOP 100 fam.fami_detalle AS familia,
    count(DISTINCT p.prod_codigo) AS cantidad_productos_vendidos,
    sum(itf.item_precio * itf.item_cantidad) AS monto_ventas
FROM
    Familia fam
    INNER JOIN Producto p ON p.prod_familia = fam.fami_id
    INNER JOIN Item_Factura itf ON itf.item_producto = p.prod_codigo
    INNER JOIN Factura f ON f.fact_numero = itf.item_numero
    AND f.fact_sucursal = itf.item_sucursal
    AND f.fact_tipo = itf.item_tipo
WHERE
    fami_id IN (
        SELECT
            fam2.fami_id
        FROM
            Familia fam2
            INNER JOIN Producto p2 ON p2.prod_familia = fam2.fami_id
            INNER JOIN Item_Factura itf2 ON itf2.item_producto = p2.prod_codigo
            INNER JOIN Factura f2 ON f2.fact_numero = itf2.item_numero
            AND f2.fact_sucursal = itf2.item_sucursal
            AND f2.fact_tipo = itf2.item_tipo
            AND YEAR(f2.fact_fecha) = '2012'
        GROUP BY
            fam2.fami_id
        HAVING
            sum(itf2.item_precio * itf2.item_cantidad) > 20000
    )
GROUP BY
    fam.fami_detalle
ORDER BY
    2 DESC