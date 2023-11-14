SELECT
    p.prod_codigo,
    p.prod_detalle,
    sum(itf.item_cantidad) AS cantidad_egresos
FROM
    Producto p
    INNER JOIN Item_Factura itf ON itf.item_producto = p.prod_codigo
    INNER JOIN Factura f ON f.fact_numero = itf.item_numero
    AND f.fact_sucursal = itf.item_sucursal
    AND f.fact_tipo = itf.item_tipo
    AND YEAR(F.fact_fecha) = 2012
GROUP BY
    p.prod_codigo,
    p.prod_detalle
HAVING
    sum(itf.item_cantidad) > ISNULL(
        (
            SELECT
                sum(itf2.item_cantidad)
            FROM
                Item_Factura itf2
                INNER JOIN Factura f2 ON f2.fact_numero = itf2.item_numero
                AND f2.fact_sucursal = itf2.item_sucursal
                AND f2.fact_tipo = itf2.item_tipo
                AND YEAR(f2.fact_fecha) = 2011
            WHERE
                itf2.item_producto = p.prod_codigo
        ),
        0
    )

-- EVITANDO SUB-SELECT:
SELECT
    P.prod_codigo,
    P.prod_detalle,
    SUM(
        CASE
            WHEN YEAR(F.fact_fecha) = 2012 THEN ITEMF.item_cantidad
            ELSE 0
        END
    ) AS cant_egresos
FROM
    Producto P
    INNER JOIN Item_Factura ITEMF ON P.prod_codigo = ITEMF.item_producto
    INNER JOIN Factura F ON ITEMF.item_numero = F.fact_numero
WHERE
    YEAR(F.fact_fecha) IN (2011, 2012)
GROUP BY
    P.prod_codigo,
    P.prod_detalle
HAVING
    SUM(
        CASE
            WHEN YEAR(F.fact_fecha) = 2012 THEN ITEMF.item_cantidad
            ELSE 0
        END
    ) > SUM(
        CASE
            WHEN YEAR(F.fact_fecha) = 2011 THEN ITEMF.item_cantidad
            ELSE 0
        END
    )