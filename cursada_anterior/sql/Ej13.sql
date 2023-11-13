USE GD2015C1

SELECT P.prod_detalle
,P.prod_precio
,SUM(P2.prod_precio*C.comp_cantidad)
FROM Composicion C
    INNER JOIN Producto P ON C.comp_producto=P.prod_codigo
    INNER JOIN Producto P2 ON C.comp_componente=P2.prod_codigo
GROUP BY P.prod_detalle
,P.prod_precio
HAVING SUM(C.comp_cantidad)>2
ORDER BY SUM(C.comp_cantidad) DESC