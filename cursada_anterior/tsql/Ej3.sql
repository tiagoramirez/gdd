USE GD2015C1
GO

CREATE PROCEDURE ejercicio3
AS
BEGIN
    DECLARE @cod_gerente NUMERIC(6,0),
        @cantidad_empleados_sin_jefe INT;

    SELECT TOP 1
        @cod_gerente=E.empl_codigo
        ,@cantidad_empleados_sin_jefe = COUNT(*)
    FROM Empleado E
    WHERE E.empl_jefe IS NULL
    GROUP BY E.empl_codigo
        ,E.empl_salario
        ,E.empl_ingreso
    ORDER BY E.empl_salario DESC, E.empl_ingreso ASC

    UPDATE Empleado
    SET empl_jefe = @cod_gerente
    WHERE empl_jefe IS NULL AND empl_codigo <> @cod_gerente

    SELECT @cantidad_empleados_sin_jefe AS cantidad_empleados_sin_jefe
END
GO