USE SCP
GO
-- Funci�n para calcular el monto por cr�ditos familiares
CREATE OR ALTER FUNCTION CalcularMontoCreditosFamiliares (
	@inConyuge BIT,
	@inHijosDependientes INT
)
RETURNS MONEY
BEGIN
	DECLARE @monto MONEY = 0;

	SET @monto = @inConyuge * 2650 + @inHijosDependientes * 1750;
	RETURN @monto;
END
