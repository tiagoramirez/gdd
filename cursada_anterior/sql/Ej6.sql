USE GD2015C1

SELECT
  R.rubr_id,
  R.rubr_detalle,
  COUNT(DISTINCT P.prod_codigo) as rubr_cantidad_articulos,
  ISNULL(SUM(s.stoc_cantidad),0) as rubr_stock_total
FROM Rubro R
  INNER JOIN Producto P
  ON P.prod_rubro = R.rubr_id
  INNER JOIN STOCK S
  ON S.stoc_producto = P.prod_codigo
WHERE
  P.prod_codigo IN (
    SELECT
      s2.stoc_producto
    FROM STOCK s2
    GROUP BY s2.stoc_producto
    HAVING SUM(stoc_cantidad) >
    (
      SELECT s3.stoc_cantidad
      FROM STOCK s3
      WHERE s3.stoc_producto = '00000000' and s3.stoc_deposito = '00'
    )
  )
GROUP BY 
  R.rubr_id,
  R.rubr_detalle