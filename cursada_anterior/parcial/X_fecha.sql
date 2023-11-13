-- Realizar una consulta SQL que retorne para los 10 clientes que mas compraron en el 2012 y que 
-- fueron atendidos por mas de 3 vendedores distintos:
--      apellido y nombre del cliente
--      cantidad de productos distintos comprados en el 2012
--      cantidad de unidades compradas dentro del primer semestre del 2012
-- el resultado debera mostrar ordenado la cantidad de ventas descendente del 2012 de cada cliente. 
-- En caso de igualdad de ventas, ordenar por codigo de cliente

SELECT TOP 10
  C.clie_razon_social
,SUM(ITF.item_cantidad)
,SUM(
  CASE
    WHEN MONTH(f.fact_fecha) <= 6 
    THEN itf.item_cantidad
    ELSE 0
  END
) AS 'Unidades compradas'
FROM Cliente C
  INNER JOIN Factura F ON C.clie_codigo=F.fact_cliente
  INNER JOIN Item_Factura ITF ON F.fact_numero=ITF.item_numero
WHERE YEAR(F.fact_fecha)=2012
GROUP BY C.clie_codigo, C.clie_razon_social
HAVING COUNT(DISTINCT F.fact_vendedor)>0
ORDER BY SUM(ITF.item_cantidad) DESC, C.clie_codigo ASC

GO
IF EXISTS (
SELECT *
  FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
  AND SPECIFIC_NAME = N'punto2'
)
DROP PROCEDURE dbo.punto2
GO

-- Realizar un stored procedure que reciba un codigo de producto y una fecha y devuelva la mayor
-- cantidad de dias consecutivos a partir de esa fecha que el producto  tuvo al menos la venta de una
-- unidad en el dia, el sistema de ventas on line esta habilitado 24-7 por lo que se  deben  evaluar 
-- todos los dias incluyendo domingos y feriados

CREATE PROCEDURE dbo.punto2
  @i_cod_producto CHAR(8)
  ,@i_fecha DATE
AS
BEGIN
  DECLARE @max_dias INT = 0;
  DECLARE @max_fecha_inicio DATE = @i_fecha;

  DECLARE @cuenta_dias_actual INT=0;
  DECLARE @fecha_inicio_actual DATE=@i_fecha;

  DECLARE @fecha_actual DATE = GETDATE();
  WHILE @i_fecha<@fecha_actual
  BEGIN
    IF EXISTS
    (
    SELECT 1
    FROM Factura F
      INNER JOIN Item_Factura ITF ON F.fact_numero = ITF.item_numero
    WHERE F.fact_fecha=@i_fecha AND ITF.item_producto = @i_cod_producto
    )
    BEGIN
      IF(@cuenta_dias_actual =0)
          SET @fecha_inicio_actual = @i_fecha;
      SET @cuenta_dias_actual = @cuenta_dias_actual + 1
    END
    ELSE
    BEGIN
      IF (@cuenta_dias_actual > @max_dias)
      BEGIN
        SET @max_dias=@cuenta_dias_actual;
        SET @max_fecha_inicio=@fecha_inicio_actual;
      END
      SET @cuenta_dias_actual=0;
    END

    SET @i_fecha = DATEADD(DAY, 1, @i_fecha);
  END
  SELECT @max_dias,@max_fecha_inicio AS 'Mayor cantidad de dias seguidos'
END

EXECUTE dbo.punto2 '00001718' , '2010-01-01'
GO

SELECT DISTINCT fact_fecha
FROM Item_Factura
inner JOIN Factura on item_numero=fact_numero 
where item_producto='00001718'
Order by fact_fecha desc