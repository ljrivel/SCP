USE SCP
GO

CREATE OR ALTER PROCEDURE CalcularImpuestoRentaMesPlanilla (
	@inIdMesPlanilla INT
)
AS BEGIN
BEGIN TRY
	BEGIN TRANSACTION impuestoRenta;
	INSERT INTO ImpuestoRenta (idMesPlanillaXEmpleado, monto, montoCreditosFamiliares)
	SELECT	MPxE.idMesPlanillaXEmpleado,
			dbo.CalcularImpuestoRenta(MPxE.salarioBrutoDevengado),
			(P.conyuge * 2650 + P.hijosDependientes * 1750)
	FROM MesPlanillaXEmpleado MPxE
	JOIN MesPlanilla MP ON MP.idMesPlanilla = MPxE.idMesPlanilla
	JOIN Persona P ON P.idPersona = MPxE.idPersona
	WHERE MPxE.idMesPlanilla = @inIdMesPlanilla;

	COMMIT TRANSACTION impuestoRenta;

	SELECT	P.numeroCedula identificacion,
			IR.monto montoImpuestoRenta,
			IR.montoCreditosFamiliares montoCreditosFamiliares
	FROM ImpuestoRenta IR
	JOIN MesPlanillaXEmpleado MPxE ON MPxE.idMesPlanillaXEmpleado = IR.idMesPlanillaXEmpleado
	JOIN Persona P ON P.idPersona = MPxE.idPersona
	WHERE MPxE.idMesPlanilla = @inIdMesPlanilla;

END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION impuestoRenta;
	SELECT	ERROR_NUMBER() AS ErrorNumber, 
			ERROR_MESSAGE() AS ErrorMessage;

END CATCH
END;