USE SCP
GO
-- Función para calcular el monto del impuesto de renta
-- a partir de un salario bruto devengado
CREATE OR ALTER FUNCTION CalcularImpuestoRenta (
	@inSalarioBrutoDevengado MONEY
)
RETURNS MONEY
BEGIN
	DECLARE @salarioBrutoAuxiliar MONEY = @inSalarioBrutoDevengado;
	DECLARE @montoImpuesto MONEY = 0;

	IF @salarioBrutoAuxiliar > 4845000
	BEGIN
		SET @montoImpuesto = @montoImpuesto + ((@salarioBrutoAuxiliar - 4845000) * 0.25);
		SET @salarioBrutoAuxiliar = 4845000;
	END

	IF @salarioBrutoAuxiliar > 2423000
	BEGIN
		SET @montoImpuesto = @montoImpuesto + ((@salarioBrutoAuxiliar - 2423000) * 0.20);
		SET @salarioBrutoAuxiliar = 2423000;
	END

	IF @salarioBrutoAuxiliar > 1381000
	BEGIN
		SET @montoImpuesto = @montoImpuesto + ((@salarioBrutoAuxiliar - 1381000) * 0.15);
		SET @salarioBrutoAuxiliar = 1381000;
	END

	IF @salarioBrutoAuxiliar > 941000
	BEGIN
		SET @montoImpuesto = @montoImpuesto + ((@salarioBrutoAuxiliar - 941000) * 0.10);
		SET @salarioBrutoAuxiliar = 941000;
	END

	RETURN @montoImpuesto;
END
