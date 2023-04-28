USE SCP
GO

CREATE OR ALTER PROCEDURE CalcularImpuestoRentaMesPlanilla (
	@inIdMesPlanilla INT
)
AS BEGIN
SET NOCOUNT ON;
BEGIN TRY

	IF EXISTS (SELECT id_impuesto_renta FROM ImpuestoRenta WHERE id_mes_planilla = @inIdMesPlanilla)
	BEGIN
		SELECT	50001 AS ErrorNumber, 
				'Error: Ya se realizó el cálculo para ese mes' AS ErrorMessage;	
					
	END;
	ELSE BEGIN
		BEGIN TRANSACTION impuestoRenta;
		INSERT INTO ImpuestoRenta (id_mes_planilla, id_empleado, monto, monto_creditos_familiares)
		SELECT	@inIdMesPlanilla,
				E.id_empleado,
				dbo.CalcularImpuestoRenta(E.salario),
				dbo.CalcularMontoCreditosFamiliares(E.conyuge, E.hijos_dependientes)
		FROM Empleado E
		WHERE E.activo = 1 AND E.salario > 0;

		COMMIT TRANSACTION impuestoRenta;

		SELECT	E.cedula cedula,
				IR.monto impuesto_renta,
				IR.monto_creditos_familiares creditos_familiares
		FROM ImpuestoRenta IR
		JOIN Empleado E ON E.id_empleado = IR.id_empleado
		WHERE IR.id_mes_planilla = @inIdMesPlanilla;
	END;

END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION impuestoRenta;
	SELECT	ERROR_NUMBER() AS ErrorNumber, 
			ERROR_MESSAGE() AS ErrorMessage;

END CATCH
SET NOCOUNT OFF;
END;

GO

-- Ejemplo de uso
-- EXEC CalcularImpuestoRentaMesPlanilla 1