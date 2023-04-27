USE SCP
GO
-- Función para calcular el monto de las cargas sociales del
-- empleado
CREATE OR ALTER FUNCTION CalcularCSEmpleado (
	@inSalarioBrutoDevengado MONEY
)
RETURNS MONEY
BEGIN
	DECLARE @monto MONEY = 0;
	SET @monto = @inSalarioBrutoDevengado * 0.1067;
	RETURN @monto;
END
