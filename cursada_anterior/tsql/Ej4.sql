USE GD2015C1
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'ejercicio4'
)
DROP PROCEDURE dbo.ejercicio4
GO


-- Cree  el/los  objetos  de  base  de  datos  necesarios  para  actualizar  la  columna  de 
-- empleado  empl_comision  con  la  sumatoria  del  total  de  lo  vendido  por  ese 
-- empleado  a  lo  largo  del último  año.  Se  deberá  retornar  el  código  del  vendedor 
-- que más vendió (en monto) a lo largo del último año


CREATE PROCEDURE dbo.ejercicio4
AS
BEGIN

    

    UPDATE Empleado
    SET empl_comision=
END
GO