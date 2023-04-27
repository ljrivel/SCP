USE SCP
GO

CREATE OR ALTER PROCEDURE CalcularCargasSocialesEmpleado (
	@inIdMesPlanilla INT
)
AS BEGIN
BEGIN TRY
	BEGIN TRANSACTION cs_empleado;
	INSERT INTO CargasSocialesEmpleado (id_empleado, id_mes_planilla, monto)
	SELECT E.id_empleado, @inIdMesPlanilla, dbo.CalcularCSEmpleado(E.salario)
	FROM Empleado E
	WHERE E.activo = 1

	COMMIT TRANSACTION cs_empleado;

	SELECT	E.cedula cedula,
			CSE.monto monto_cargas_sociales
	FROM CargasSocialesEmpleado CSE
	JOIN Empleado E ON E.id_empleado = CSE.id_empleado
	WHERE CSE.id_mes_planilla = @inIdMesPlanilla;

END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION cs_empleado;
	SELECT	ERROR_NUMBER() AS ErrorNumber, 
			ERROR_MESSAGE() AS ErrorMessage;

END CATCH
END;

GO
-- Ejemplo de uso
EXEC CalcularCargasSocialesEmpleado 1