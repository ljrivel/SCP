USE SCP
GO

-- Obtener cálculos de las deducciones a los salarios de los empleados
CREATE OR ALTER PROCEDURE ObtenerImpuestoRentaYCSTrabajador (
	@inIdMesPlanilla INT
)
AS BEGIN
SET NOCOUNT ON;
BEGIN TRY

	-- Retornar resultados del mes planilla
	SELECT	E.cedula cedula,
			IR.monto impuesto_renta,
			IR.monto_creditos_familiares creditos_familiares,
			CSE.monto cargas_sociales_trabajador
	FROM ImpuestoRenta IR
	JOIN Empleado E ON E.id_empleado = IR.id_empleado
	JOIN CargasSocialesEmpleado CSE ON CSE.id_empleado = E.id_empleado
	WHERE IR.id_mes_planilla = @inIdMesPlanilla
	AND CSE.id_mes_planilla = @inIdMesPlanilla;

END TRY
BEGIN CATCH

	-- Manejar errores
	ROLLBACK TRANSACTION impuestoRenta;
	SELECT	ERROR_NUMBER() AS ErrorNumber, 
			ERROR_MESSAGE() AS ErrorMessage;

END CATCH
SET NOCOUNT OFF;
END;

GO

-- Ejemplo de uso
-- EXEC ObtenerImpuestoRentaYCSTrabajador 1