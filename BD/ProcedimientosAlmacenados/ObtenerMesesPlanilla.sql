CREATE OR ALTER PROCEDURE ObtenerMesesPlanilla
AS BEGIN
SET NOCOUNT ON;
BEGIN TRY
	SELECT	id_mes_planilla id_mes_planilla,
			CONCAT('INICIO: ', CAST(inicio AS VARCHAR(32)), ' - FIN: ', CAST(fin AS VARCHAR(32))) rango
	FROM MesPlanilla
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION insertar_datos;
	SELECT	ERROR_NUMBER() AS ErrorNumber, 
			ERROR_MESSAGE() AS ErrorMessage;

END CATCH
SET NOCOUNT OFF;
END;
GO

EXEC ObtenerMesesPlanilla