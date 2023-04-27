USE MASTER
GO

DROP DATABASE SCP
GO

CREATE DATABASE SCP
GO

USE SCP
GO


CREATE TABLE Puesto (
	idPuesto INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	activo BIT NOT NULL DEFAULT 1,
	nombre VARCHAR(64) NOT NULL,
	salarioBase MONEY NOT NULL
);

CREATE TABLE Persona (
	idPersona INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	activo BIT DEFAULT 1,
	nombre VARCHAR(32) NOT NULL,
	apellido1 VARCHAR(32) NOT NULL,
	apellido2 VARCHAR(32) NOT NULL,
	fechaNacimiento DATETIME NOT NULL,
	conyuge BIT NOT NULL,
	hijosDependientes INT NOT NULL,
	numeroCedula VARCHAR(16) NOT NULL,
	numeroTelefono VARCHAR(16) NOT NULL
);


CREATE TABLE PuestoXPersona (
	idPuestoXPersona INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	idPersona INT NOT NULL FOREIGN KEY REFERENCES Persona(idPersona),
	idPuesto INT NOT NULL FOREIGN KEY REFERENCES Puesto(idPuesto),
	activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE MesPlanilla (
	idMesPlanilla INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	inicio DATE NOT NULL,
	fin DATE NOT NULL
);

CREATE TABLE MesPlanillaXEmpleado (
	idMesPlanillaXEmpleado INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	idPersona INT NOT NULL FOREIGN KEY REFERENCES Persona(idPersona),
	idMesPlanilla INT NOT NULL FOREIGN KEY REFERENCES MesPlanilla(idMesPlanilla),
	salarioBrutoDevengado MONEY NOT NULL
);

CREATE TABLE ImpuestoRenta (
	idImpuestoRenta INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	idMesPlanillaXEmpleado INT NOT NULL FOREIGN KEY REFERENCES MesPlanillaXEmpleado (idMesPlanillaXEmpleado),
	monto MONEY NOT NULL,
	montoCreditosFamiliares MONEY NOT NULL
);

CREATE TABLE CargasSocialesEmpleado (
	idCargasSocialesEmpleado INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	idMesPlanillaXEmpleado INT NOT NULL FOREIGN KEY REFERENCES MesPlanillaXEmpleado (idMesPlanillaXEmpleado),
	monto MONEY NOT NULL
);

CREATE TABLE CargasSocialesPatronales (
	idCargasSocialesPatronales INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	idMesPlanilla INT NOT NULL FOREIGN KEY REFERENCES MesPlanilla (idMesPlanilla),
	monto MONEY NOT NULL
)

GO


