USE GD2015C1

SELECT P.prod_codigo
,(
    SELECT TOP 1
        F.fact_cliente
    FROM Factura F
        INNER JOIN Item_Factura ITEMF
        ON F.fact_numero = ITEMF.item_numero
            AND F.fact_sucursal = ITEMF.item_sucursal
            AND F.fact_tipo = ITEMF.item_tipo
    WHERE ITEMF.item_producto=P.prod_codigo
    GROUP BY F.fact_cliente
    ORDER BY SUM(ITEMF.item_cantidad) DESC
)
FROM Producto P
WHERE P.prod_codigo IN
(
    SELECT TOP 10
        item_producto
    FROM Item_Factura
    GROUP BY item_producto
    ORDER BY SUM(item_cantidad) DESC
)
    OR
    P.prod_codigo IN
(
    SELECT TOP 10
        item_producto
    FROM Item_Factura
    GROUP BY item_producto
    ORDER BY SUM(item_cantidad) ASC
)