USE SCP
GO

CREATE OR ALTER PROCEDURE CalcularImpuestoRentaMesPlanilla (
	@inIdMesPlanilla INT
)
AS BEGIN
BEGIN TRY
	BEGIN TRANSACTION impuestoRenta;
	INSERT INTO ImpuestoRenta (id_mes_planilla, id_empleado, monto, monto_creditos_familiares)
	SELECT	@inIdMesPlanilla,
			E.id_empleado,
			dbo.CalcularImpuestoRenta(E.salario),
			dbo.CalcularMontoCreditosFamiliares(E.conyuge, E.hijos_dependientes)
	FROM Empleado E
	WHERE E.activo = 1

	COMMIT TRANSACTION impuestoRenta;

	SELECT	E.cedula cedula,
			IR.monto impuesto_renta,
			IR.monto_creditos_familiares creditos_familiares
	FROM ImpuestoRenta IR
	JOIN Empleado E ON E.id_empleado = IR.id_empleado
	WHERE IR.id_mes_planilla = @inIdMesPlanilla;

END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION impuestoRenta;
	SELECT	ERROR_NUMBER() AS ErrorNumber, 
			ERROR_MESSAGE() AS ErrorMessage;

END CATCH
END;

GO
-- Ejemplo de uso
EXEC CalcularImpuestoRentaMesPlanilla 1