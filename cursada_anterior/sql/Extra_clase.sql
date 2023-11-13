-- 1. Realizar una consulta SQL que permita saber si un cliente compro un producto en todos 
-- los meses del 2012.

-- Además, mostrar para el 2012: 

-- 1. El cliente
-- 2. La razón social del cliente
-- 3. El producto comprado
-- 4. El nombre del producto
-- 5. Cantidad de productos distintos comprados por el cliente.
-- 6. Cantidad de productos con composición comprados por el cliente.

-- El resultado deberá ser ordenado poniendo primero aquellos clientes que compraron más de 10 productos distintos en el 2012. 

-- Nota: No se permiten select en el from, es decir, select … from (select …) as T,...

SELECT C.clie_codigo
,C.clie_razon_social
,P.prod_codigo
,P.prod_detalle
,(
  SELECT COUNT(DISTINCT ITFSS.item_producto)
  FROM Factura FSS
    INNER JOIN Item_Factura ITFSS
    ON FSS.fact_numero = ITFSS.item_numero
      AND ITFSS.item_sucursal=FSS.fact_sucursal
      AND FSS.fact_tipo=ITFSS.item_tipo
  WHERE YEAR(FSS.fact_fecha)=2012
    AND FSS.fact_cliente=C.clie_codigo
) AS cant_prod_distintos
,(
  SELECT SUM(ITFSS.item_cantidad)
  FROM Factura FSS
    INNER JOIN Item_Factura ITFSS
    ON FSS.fact_numero = ITFSS.item_numero
      AND FSS.fact_sucursal=ITFSS.item_sucursal
      AND FSS.fact_tipo=ITFSS.item_tipo
    INNER JOIN Composicion COMPSS
    ON COMPSS.comp_producto= ITFSS.item_producto
  WHERE YEAR(FSS.fact_fecha)=2012
    AND FSS.fact_cliente=C.clie_codigo
) AS cant_prod_con_composicion
FROM Cliente C
  INNER JOIN Factura F
  ON F.fact_cliente = C.clie_codigo
  INNER JOIN Item_Factura ITF
  ON ITF.item_numero=F.fact_numero
  INNER JOIN Producto P
  ON P.prod_codigo=ITF.item_producto
WHERE YEAR(F.fact_fecha)=2012
GROUP BY C.clie_codigo
,C.clie_razon_social
,P.prod_codigo
,P.prod_detalle
HAVING COUNT(DISTINCT MONTH(F.fact_fecha))=12
ORDER BY 
  CASE WHEN 
    (
    SELECT COUNT(DISTINCT ITFSS.item_producto)
FROM Factura FSS
  INNER JOIN Item_Factura ITFSS
  ON FSS.fact_numero = ITFSS.item_numero
    AND ITFSS.item_sucursal=FSS.fact_sucursal
    AND FSS.fact_tipo=ITFSS.item_tipo
WHERE YEAR(FSS.fact_fecha)=2012
  AND FSS.fact_cliente=C.clie_codigo
  )>10 THEN 1 ELSE 0 END DESC


-- 2. Implementar una regla de negocio de validación en línea que permita implementar una lógica de 
-- control de precios en las ventas. Se deberá poder seleccionar una lista de rubros y aquellos productos 
-- de los rubros que sean los seleccionados no podrán aumentar por mes más de un 2 %. En caso que no se 
-- tenga referencia del mes anterior no validar dicha regla.



GO
CREATE TRIGGER control_precio
ON Item_Factura
AFTER INSERT, UPDATE
AS
BEGIN TRANSACTION
	
	IF EXISTS(
		SELECT 1 FROM inserted
		JOIN Producto p on p.prod_codigo = item_producto
		JOIN Rubro_Validacion_Precios on rubr_id = prod_rubro
		WHERE item_precio > (
			(SELECT AVG(i.item_precio * 1.2) FROM Item_Factura i
			JOIN Factura f ON  f.fact_numero = i.item_numero AND f.fact_sucursal = i.item_sucursal AND f.fact_tipo = i.item_tipo
			WHERE	i.item_producto = p.prod_codigo AND
					MONTH(f.fact_fecha) = MONTH(DATEADD(MONTH,-1,f.fact_fecha)) AND
					YEAR(f.fact_fecha) = YEAR(DATEADD(MONTH,-1,f.fact_fecha)) AND
					i.item_precio IS NOT NULL 
			)
		)
	)
	BEGIN 
		ROLLBACK
		RETURN
	END
COMMIT