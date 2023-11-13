USE GD2015C1

SELECT P.prod_detalle
 ,MAX(S.stoc_cantidad)
FROM Producto P
    INNER JOIN STOCK S ON P.prod_codigo=S.stoc_producto
WHERE S.stoc_cantidad>0
GROUP BY P.prod_detalle
HAVING 
COUNT(DISTINCT S.stoc_deposito) = (
    SELECT COUNT( DISTINCT D.depo_codigo)
FROM DEPOSITO D
)