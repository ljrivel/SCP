USE SCP
GO

CREATE OR ALTER FUNCTION GenerarConyuge (
	@inCedula VARCHAR(10)
)
RETURNS BIT
AS BEGIN
	DECLARE @numero INT
	SET @numero = CAST(SUBSTRING(@inCedula, 2, LEN(@inCedula)) AS INT);

	IF @numero % 3 = 0 RETURN 1;

	RETURN 0;
END
GO

CREATE OR ALTER FUNCTION GenerarHijosDependientes (
	@inCedula VARCHAR(10)
)
RETURNS INT
AS BEGIN
	DECLARE @numero INT

	SET @numero = CAST(SUBSTRING(@inCedula, 3, LEN(@inCedula)) AS INT);

	IF @numero % 3 = 0 RETURN 2;

	IF @numero % 2 = 0 RETURN 1;

	RETURN 0;
END;
GO

CREATE OR ALTER PROCEDURE InsertarDatos
AS BEGIN
BEGIN TRY
	CREATE TABLE #temporal (cedula VARCHAR(16), 
								nombre VARCHAR(32), 
								apellido1 VARCHAR(32), 
								apellido2 VARCHAR(32),
								salario MONEY,
								fecha_nacimiento VARCHAR(32),
								Organizacion VARCHAR(10),
								Departamento VARCHAR(10));

	BULK INSERT [#temporal]
	FROM 'C:\Users\50684\Desktop\Datos-Completos.csv'
	WITH (
			FIELDTERMINATOR = ';', 
			ROWTERMINATOR = '\n', 
			FIRSTROW = 2);

	BEGIN TRANSACTION insertar_datos;
	INSERT INTO Empleado (id_departamento, id_organizacion, nombre, apellido1, apellido2, fecha_nacimiento, salario, conyuge, hijos_dependientes, cedula)
	SELECT	CAST(CAST(Departamento AS FLOAT) AS INT)  AS Departamento,
			CAST(CAST(Organizacion AS FLOAT) AS INT), 
			SUBSTRING(nombre, 2, LEN(nombre) - 2), 
			SUBSTRING(apellido1, 2, LEN(apellido1) - 2), 
			SUBSTRING(apellido2, 2, LEN(apellido2) - 2), 
			SUBSTRING(fecha_nacimiento, 2, LEN(fecha_nacimiento) - 2), 
			salario, 
			dbo.GenerarConyuge(cedula),
			dbo.GenerarHijosDependientes(cedula),
			SUBSTRING(cedula, 2, LEN(cedula) - 2)
	FROM #temporal;

	COMMIT TRANSACTION insertar_datos;

	DROP TABLE #temporal;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION insertar_datos;
	SELECT	ERROR_NUMBER() AS ErrorNumber, 
			ERROR_MESSAGE() AS ErrorMessage;

END CATCH
END;
GO

EXEC InsertarDatos
GO

INSERT INTO MesPlanilla (inicio, fin)
VALUES ('2023-01-01', '2023-01-31'),
		('2023-02-01', '2023-02-28'),
		('2023-03-01', '2023-03-31');
GO