SELECT
    p.prod_codigo,
    p.prod_detalle,
    max(itf.item_precio) AS mayor_precio,
    min(itf.item_precio) AS menor_precio,
    CONCAT(
        (
            MAX(ITF.item_precio) * 100 / MIN(ITF.item_precio) -100
        ),
        ' %'
    ) AS porcentaje_diferencia
FROM
    Producto p
    INNER JOIN Item_Factura itf ON itf.item_producto = p.prod_codigo
    INNER JOIN STOCK s ON s.stoc_producto = p.prod_codigo
WHERE
    s.stoc_cantidad > 0
GROUP BY
    p.prod_codigo,
    p.prod_detalle