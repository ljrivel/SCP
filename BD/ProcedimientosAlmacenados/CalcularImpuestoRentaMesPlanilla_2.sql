USE SCP
GO

-- Cálculo mensual del Impuesto de Renta al salario
CREATE OR ALTER PROCEDURE CalcularImpuestoRentaMesPlanilla (
	@inIdMesPlanilla INT
)
AS BEGIN
SET NOCOUNT ON;
BEGIN TRY
	
	-- Revisar que no se hayan realizado los cálculos de ese mes
	IF NOT EXISTS (SELECT id_impuesto_renta FROM ImpuestoRenta WHERE id_mes_planilla = @inIdMesPlanilla)
	BEGIN
		-- Realizar los cálculos
		BEGIN TRANSACTION impuestoRenta;
		INSERT INTO ImpuestoRenta (id_mes_planilla, id_empleado, monto, monto_creditos_familiares)
		SELECT	@inIdMesPlanilla,
				E.id_empleado,
				dbo.CalcularImpuestoRenta(E.salario),
				dbo.CalcularMontoCreditosFamiliares(E.conyuge, E.hijos_dependientes)
		FROM Empleado E
		WHERE E.activo = 1 AND E.salario > 0;

		COMMIT TRANSACTION impuestoRenta;
	END;

	-- Retornar los resultados de los cálculos de ese mes
	SELECT	E.cedula cedula,
			IR.monto impuesto_renta,
			IR.monto_creditos_familiares creditos_familiares
	FROM ImpuestoRenta IR
	JOIN Empleado E ON E.id_empleado = IR.id_empleado
	WHERE IR.id_mes_planilla = @inIdMesPlanilla;

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
-- EXEC CalcularImpuestoRentaMesPlanilla 1