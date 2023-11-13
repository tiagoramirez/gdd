USE GD2015C1

SELECT
  P.prod_codigo,
  P.prod_detalle,
  SUM(ITEMF.item_cantidad) cant_egresos
FROM Producto P
  INNER JOIN Item_Factura ITEMF
  ON P.prod_codigo = ITEMF.item_producto
  INNER JOIN Factura F
  ON ITEMF.item_numero = F.fact_numero
WHERE YEAR(F.fact_fecha) = 2012
GROUP BY
  P.prod_codigo,
  P.prod_detalle
HAVING SUM(ITEMF.item_cantidad) > ISNULL((
  SELECT
  SUM(ITEMF2.item_cantidad) cant_egresos
FROM Item_Factura ITEMF2
  INNER JOIN Factura F2
  ON ITEMF2.item_numero = F2.fact_numero
WHERE YEAR(F2.fact_fecha) = 2011 AND P.prod_codigo = ITEMF2.item_producto
GROUP BY ITEMF2.item_producto
), 0)

-- EVITANDO SUB-SELECT:
SELECT
  P.prod_codigo,
  P.prod_detalle,
  SUM(CASE WHEN YEAR(F.fact_fecha) = 2012 THEN ITEMF.item_cantidad ELSE 0 END) as cant_egresos
FROM Producto P
  INNER JOIN Item_Factura ITEMF
  ON P.prod_codigo = ITEMF.item_producto
  INNER JOIN Factura F
  ON ITEMF.item_numero = F.fact_numero
WHERE YEAR(F.fact_fecha) IN (2011, 2012)
GROUP BY
  P.prod_codigo,
  P.prod_detalle
HAVING 
SUM(
  CASE WHEN YEAR(F.fact_fecha) = 2012 THEN ITEMF.item_cantidad ELSE 0 END
)
>
SUM(
  CASE WHEN YEAR(F.fact_fecha) = 2011 THEN ITEMF.item_cantidad ELSE 0 END
)