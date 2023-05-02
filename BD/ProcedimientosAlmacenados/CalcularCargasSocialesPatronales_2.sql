USE SCP
GO

-- Cálculo mensual de las Cargas Sociales Patronales
CREATE OR ALTER PROCEDURE CalcularCargasSocialesPatronales (
	@inIdMesPlanilla INT
)
AS BEGIN
SET NOCOUNT ON;
BEGIN TRY

	-- Revisar que no se hayan realizado los cálculos
	IF NOT EXISTS (	SELECT id_cargas_sociales_patronales
				FROM CargasSocialesPatronales
				WHERE id_mes_planilla = @inIdMesPlanilla)
	BEGIN
		-- Obtener la suma de los salarios del mes
		DECLARE @suma_salarios MONEY;
		SELECT @suma_salarios = SUM(salario)
		FROM Empleado
		WHERE activo = 1 AND salario > 0;

		-- Realizar el cálculo de las Cargas Sociales Patronales
		BEGIN TRANSACTION cs_patronales;
		INSERT INTO CargasSocialesPatronales (id_mes_planilla, monto)
		VALUES (@inIdMesPlanilla, dbo.CalcularCSPatronales(@suma_salarios)); 

		COMMIT TRANSACTION cs_patronales;

	END;

	-- Retornar resultados de los cálculos
	SELECT	CSP.monto monto_cs_patronales
	FROM CargasSocialesPatronales CSP
	WHERE CSP.id_mes_planilla = @inIdMesPlanilla;

END TRY
BEGIN CATCH

	-- Manejar errores
	ROLLBACK TRANSACTION cs_patronales;
	SELECT	ERROR_NUMBER() AS ErrorNumber, 
			ERROR_MESSAGE() AS ErrorMessage;

END CATCH
SET NOCOUNT OFF;
END;

GO
-- Ejemplo de uso
-- EXEC CalcularCargasSocialesPatronales 1