USE GD2015C1
GO

CREATE FUNCTION ejercicio1 (@cod_producto CHAR(8), @cod_deposito CHAR(2))
RETURNS VARCHAR(30)
AS
BEGIN
    DECLARE @stock_en_deposito FLOAT
        ,@maximo FLOAT
        ,@retorno VARCHAR(30);


    SELECT @stock_en_deposito=ISNULL(S.stoc_cantidad,0)
        ,@maximo=ISNULL(S.stoc_stock_maximo,0)
    FROM STOCK S
    WHERE S.stoc_deposito=@cod_deposito AND s.stoc_producto=@cod_producto

    IF(@stock_en_deposito<@maximo)
    BEGIN
        DECLARE @porcentaje_ocupacion DECIMAL(12,2) = @stock_en_deposito/@maximo*100
        SET @retorno = CONCAT('OCUPACION DEL DEPOSITO ',(@porcentaje_ocupacion),'%');
    END
    ELSE
        SET @retorno = 'DEPOSITO COMPLETO';

    RETURN @retorno;
END
GO