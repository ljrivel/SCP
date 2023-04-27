USE SCP
GO

CREATE OR ALTER PROCEDURE CalcularCargasSocialesPatronales (
	@inIdMesPlanilla INT
)
AS BEGIN
BEGIN TRY
	DECLARE @suma_salarios MONEY;
	SELECT @suma_salarios = SUM(salario)
	FROM Empleado
	WHERE activo = 1;

	BEGIN TRANSACTION cs_patronales;
	INSERT INTO CargasSocialesPatronales (id_mes_planilla, monto)
	VALUES (@inIdMesPlanilla, dbo.CalcularCSPatronales(@suma_salarios)); 

	COMMIT TRANSACTION cs_patronales;

	SELECT	CSP.monto monto_cs_patronales
	FROM CargasSocialesPatronales CSP
	WHERE CSP.id_mes_planilla = @inIdMesPlanilla;

END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION cs_patronales;
	SELECT	ERROR_NUMBER() AS ErrorNumber, 
			ERROR_MESSAGE() AS ErrorMessage;

END CATCH
END;

GO
-- Ejemplo de uso
EXEC CalcularCargasSocialesPatronales 1