USE GD2015C1

SELECT
  P.prod_codigo,
  p.prod_detalle,
  MAX(ITF.item_precio) as prod_precio_max,
  MIN(ITF.item_precio) as prod_precio_min,
  CONCAT((MAX(ITF.item_precio)*100/MIN(ITF.item_precio)-100),'%') AS prod_porcentaje_diferencia
FROM Producto P
  INNER JOIN Item_Factura ITF
  ON P.prod_codigo = ITF.item_producto
  INNER JOIN STOCK S
  ON P.prod_codigo = S.stoc_producto
WHERE S.stoc_cantidad > 0
GROUP BY
  P.prod_codigo,
  p.prod_detalle