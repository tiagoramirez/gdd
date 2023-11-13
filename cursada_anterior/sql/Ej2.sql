USE GD2015C1

SELECT
  P.prod_codigo,
  P.prod_detalle,
  SUM(ITEMF.item_cantidad) AS cant_vendida
FROM Factura F
  INNER JOIN Item_Factura ITEMF
  ON F.fact_numero = ITEMF.item_numero
    AND F.fact_sucursal = ITEMF.item_sucursal
    AND F.fact_tipo = ITEMF.item_tipo
    AND YEAR(F.fact_fecha) = 2012
  INNER JOIN Producto P
  ON ITEMF.item_producto = P.prod_codigo
GROUP BY 
  P.prod_codigo,
  P.prod_detalle
ORDER BY cant_vendida ASC