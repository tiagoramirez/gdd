SELECT
    p.prod_codigo,
    p.prod_detalle,
    SUM(itf.item_cantidad) AS cant_vendida
FROM
    Producto p
    INNER JOIN Item_Factura itf ON itf.item_producto = p.prod_codigo
    INNER JOIN Factura f ON f.fact_numero = itf.item_numero
    AND F.fact_sucursal = itf.item_sucursal
    AND F.fact_tipo = itf.item_tipo
WHERE
    YEAR(f.fact_fecha) = 2012
GROUP BY
    p.prod_codigo,
    p.prod_detalle
ORDER BY
    3 DESC