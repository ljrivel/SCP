USE SCP
GO
-- Función para calcular el monto de las cargas sociales del
-- patrono
CREATE OR ALTER FUNCTION CalcularCSPatronales (
	@inSumatoriaSalariosBrutos MONEY
)
RETURNS MONEY
BEGIN
	DECLARE @monto MONEY = 0;
	SET @monto = @inSumatoriaSalariosBrutos * 0.2667;
	RETURN @monto;
END