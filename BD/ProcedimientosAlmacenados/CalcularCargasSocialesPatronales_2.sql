USE SCP
GO

CREATE OR ALTER PROCEDURE CalcularCargasSocialesPatronales (
	@inIdMesPlanilla INT
)
AS BEGIN
SET NOCOUNT ON;
BEGIN TRY
	IF NOT EXISTS (	SELECT id_cargas_sociales_patronales
				FROM CargasSocialesPatronales
				WHERE id_mes_planilla = @inIdMesPlanilla)
	BEGIN
		DECLARE @suma_salarios MONEY;
		SELECT @suma_salarios = SUM(salario)
		FROM Empleado
		WHERE activo = 1 AND salario > 0;

		BEGIN TRANSACTION cs_patronales;
		INSERT INTO CargasSocialesPatronales (id_mes_planilla, monto)
		VALUES (@inIdMesPlanilla, dbo.CalcularCSPatronales(@suma_salarios)); 

		COMMIT TRANSACTION cs_patronales;

	END;

	SELECT	CSP.monto monto_cs_patronales
	FROM CargasSocialesPatronales CSP
	WHERE CSP.id_mes_planilla = @inIdMesPlanilla;

END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION cs_patronales;
	SELECT	ERROR_NUMBER() AS ErrorNumber, 
			ERROR_MESSAGE() AS ErrorMessage;

END CATCH
SET NOCOUNT OFF;
END;

GO
-- Ejemplo de uso
-- EXEC CalcularCargasSocialesPatronales 1