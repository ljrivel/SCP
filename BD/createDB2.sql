USE MASTER
GO

DROP DATABASE IF EXISTS SCP
GO

CREATE DATABASE SCP
GO

USE SCP
GO


CREATE TABLE Empleado (
	id_empleado INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_departamento INT NOT NULL,
	id_organizacion INT NOT NULL,
	activo BIT DEFAULT 1,
	nombre VARCHAR(32) NOT NULL,
	apellido1 VARCHAR(32) NOT NULL,
	apellido2 VARCHAR(32) NOT NULL,
	fecha_nacimiento VARCHAR(32) NOT NULL,
	salario MONEY NOT NULL,
	conyuge BIT NOT NULL,
	hijos_dependientes INT NOT NULL,
	cedula VARCHAR(16) NOT NULL UNIQUE
);

CREATE TABLE MesPlanilla (
	id_mes_planilla INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	inicio DATE NOT NULL,
	fin DATE NOT NULL
);

CREATE TABLE ImpuestoRenta (
	id_impuesto_renta INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_empleado INT NOT NULL FOREIGN KEY REFERENCES Empleado(id_empleado),
	id_mes_planilla INT NOT NULL FOREIGN KEY REFERENCES MesPlanilla(id_mes_planilla),
	monto MONEY NOT NULL,
	monto_creditos_familiares MONEY NOT NULL
);

CREATE TABLE CargasSocialesEmpleado (
	id_cargas_sociales_empleado INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_empleado INT NOT NULL FOREIGN KEY REFERENCES Empleado(id_empleado),
	id_mes_planilla INT NOT NULL FOREIGN KEY REFERENCES MesPlanilla(id_mes_planilla),
	monto MONEY NOT NULL
);

CREATE TABLE CargasSocialesPatronales (
	id_cargas_sociales_patronales INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_mes_planilla INT NOT NULL FOREIGN KEY REFERENCES MesPlanilla (id_mes_planilla),
	monto MONEY NOT NULL
)

GO