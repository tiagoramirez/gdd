USE GD2015C1

SELECT P.prod_detalle
,COUNT(DISTINCT C.clie_codigo) AS cantidad_clientes_distintos
,SUM(ITF.item_cantidad*ITF.item_precio)/SUM(ITF.item_cantidad) AS prromedio_pagado
,COUNT(S.stoc_deposito) AS cantidad_depositos_con_stock
,SUM(S.stoc_cantidad) AS stock_actual_en_depositos
FROM Producto P
    INNER JOIN Item_Factura ITF ON P.prod_codigo=ITF.item_producto
    INNER JOIN Factura F ON ITF.item_numero=F.fact_numero
        AND ITF.item_sucursal=F.fact_sucursal
        AND ITF.item_tipo=F.fact_tipo
    INNER JOIN Cliente C ON F.fact_cliente=C.clie_codigo
    LEFT JOIN STOCK S ON P.prod_codigo=S.stoc_producto
WHERE S.stoc_cantidad>0 AND YEAR(F.fact_fecha)='2012'
GROUP BY P.prod_detalle
ORDER BY SUM(ITF.item_cantidad * ITF.item_precio) DESC