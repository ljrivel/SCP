USE SCP
GO

CREATE OR ALTER PROCEDURE CalcularCargasSocialesEmpleado (
	@inIdMesPlanilla INT
)
AS BEGIN
SET NOCOUNT ON;
BEGIN TRY

	IF EXISTS (	SELECT id_cargas_sociales_empleado 
				FROM CargasSocialesEmpleado 
				WHERE id_mes_planilla = @inIdMesPlanilla)
	BEGIN
		SELECT	50001 AS ErrorNumber, 
				'Error: Ya se realizó el cálculo de las cargas sociales de los empleados para ese mes' AS ErrorMessage;	
					
	END;
	ELSE
	BEGIN
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
	END;

END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION cs_empleado;
	SELECT	ERROR_NUMBER() AS ErrorNumber, 
			ERROR_MESSAGE() AS ErrorMessage;

END CATCH
SET NOCOUNT OFF;
END;

GO
-- Ejemplo de uso
-- EXEC CalcularCargasSocialesEmpleado 1