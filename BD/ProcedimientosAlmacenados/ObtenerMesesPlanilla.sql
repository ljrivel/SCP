-- Obtener meses planilla registrados
CREATE OR ALTER PROCEDURE ObtenerMesesPlanilla
AS BEGIN
SET NOCOUNT ON;
BEGIN TRY
	
	-- Retornar meses planilla con sus rangos de fechas
	SELECT	id_mes_planilla id_mes_planilla,
			CONCAT('INICIO: ', CAST(inicio AS VARCHAR(32)), ' - FIN: ', CAST(fin AS VARCHAR(32))) rango
	FROM MesPlanilla
END TRY
BEGIN CATCH
	
	-- Manejar errores
	SELECT	ERROR_NUMBER() AS ErrorNumber, 
			ERROR_MESSAGE() AS ErrorMessage;

END CATCH
SET NOCOUNT OFF;
END;
GO

-- EXEC ObtenerMesesPlanilla