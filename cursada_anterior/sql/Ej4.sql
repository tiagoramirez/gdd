USE GD2015C1

SELECT
  P.prod_codigo,
  P.prod_detalle,
  ISNULL(SUM(C.comp_cantidad),1) as cant_componentes
FROM Producto P
  LEFT JOIN Composicion C
  ON P.prod_codigo = C.comp_producto
  INNER JOIN STOCK S
  ON P.prod_codigo=S.stoc_producto
GROUP BY
  P.prod_codigo,
  P.prod_detalle
HAVING AVG(S.stoc_cantidad) > 100
ORDER BY cant_componentes DESC