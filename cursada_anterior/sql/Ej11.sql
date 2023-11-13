USE GD2015C1

SELECT FAM.fami_detalle
    ,COUNT(DISTINCT P.prod_codigo) AS cantidad_diferentes_vendidos
    ,SUM(ITF.item_precio*ITF.item_cantidad) AS monto_ventas_sin_impuestos
FROM Familia FAM
    INNER JOIN Producto P ON FAM.fami_id=P.prod_familia
    INNER JOIN Item_Factura ITF ON P.prod_codigo=ITF.item_producto
    INNER JOIN Factura F ON ITF.item_numero=F.fact_numero
        AND ITF.item_sucursal=F.fact_sucursal
        AND ITF.item_tipo=F.fact_tipo
WHERE YEAR(F.fact_fecha)='2012'
GROUP BY FAM.fami_detalle
HAVING SUM(ITF.item_precio*ITF.item_cantidad)>20000
ORDER BY cantidad_diferentes_vendidos DESC