USE GD2015C1

SELECT
  P.prod_codigo,
  P.prod_detalle,
  SUM(S.stoc_cantidad)
FROM Producto P
  INNER JOIN STOCK S
  ON P.prod_codigo = S.stoc_producto
GROUP BY
  P.prod_codigo,
  P.prod_detalle
ORDER BY prod_detalle ASC