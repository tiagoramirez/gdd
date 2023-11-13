USE GD2015C1

SELECT C.clie_codigo
,COUNT(DISTINCT F.fact_numero)
,AVG(F.fact_total)
,COUNT(DISTINCT ITF.item_producto)
,(SELECT MAX(fact_total)
    FROM Factura
    WHERE fact_cliente=C.clie_codigo
        AND YEAR(fact_fecha)=(
        SELECT MAX(YEAR(fact_fecha))
        FROM Factura
    )
)
FROM Cliente C
    INNER JOIN Factura F ON C.clie_codigo=F.fact_cliente
    INNER JOIN Item_Factura ITF ON F.fact_numero = ITF.item_numero
        AND F.fact_sucursal = ITF.item_sucursal
        AND F.fact_tipo = ITF.item_tipo
WHERE YEAR(F.fact_fecha) = (
    SELECT MAX(YEAR(fact_fecha))
FROM Factura
)
GROUP BY C.clie_codigo
ORDER BY 2 DESC