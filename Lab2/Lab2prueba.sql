create database Lab2prueba
use lab2prueba

-- Crear la tabla de Personas
CREATE TABLE Personas (
    Codigo INT PRIMARY KEY,
    Email VARCHAR(255),
    Nombres VARCHAR(255),
    Apellidos VARCHAR(255),
    Telefono VARCHAR(20),
    Genero CHAR(1),
    Direccion VARCHAR(255)
);

-- Crear la tabla de Vehiculos
CREATE TABLE Vehiculos (
    Placa VARCHAR(10) PRIMARY KEY,
    CodigoPropietario INT,
    NumeroMotor VARCHAR(20),
    Marca VARCHAR(255),
    Color VARCHAR(50),
    TipoPoliza VARCHAR(20) DEFAULT 'daños a terceros',
    Modelo INT,
    Clase VARCHAR(50),
    FOREIGN KEY (CodigoPropietario) REFERENCES Personas(Codigo)
);

-- Crear la tabla de Multas
CREATE TABLE Multas (
    CodigoMulta INT PRIMARY KEY,
    DescripcionMulta VARCHAR(255),
    Importe DECIMAL(10, 2) CHECK (Importe >= 0),
    Fecha DATE,
    Lugar VARCHAR(255),
    Hora TIME,
    PlacaVehiculo VARCHAR(10),
    CodigoPolicia INT,
    FOREIGN KEY (PlacaVehiculo) REFERENCES Vehiculos(Placa),
    FOREIGN KEY (CodigoPolicia) REFERENCES Policias(Codigo),
    TipoPoliza VARCHAR(20) CHECK (TipoPoliza IN ('full', 'daños a terceros'))
   
);

-- Crear la tabla de Policias
CREATE TABLE Policias (
    Codigo INT PRIMARY KEY,
    NombresApellidos VARCHAR(255),
    Direccion VARCHAR(255),
    Telefono VARCHAR(20),
    Rango VARCHAR(50)
);

-- Crear la tabla de Entidad Encargada
CREATE TABLE EntidadEncargada (
    Nombre VARCHAR(255),
    RUC VARCHAR(20),
    Direccion VARCHAR(255),
    Telefono VARCHAR(20)
);

-- Crear la tabla de Forma de Pago de Multas
CREATE TABLE FormaPagoMultas (
    CodigoMulta INT,
    FormaPago VARCHAR(20),
);


-- 1
-- Crear una llave primaria compuesta en la tabla Multas
ALTER TABLE Multas
ADD CONSTRAINT PK_Multas PRIMARY KEY (CodigoMulta, PlacaVehiculo);

--2 
ALTER TABLE EntidadEncargada
ADD CONSTRAINT PK_EntidadEncargada PRIMARY KEY (RUC);

--3
ALTER TABLE FormaPagoMultas
ADD CONSTRAINT FK_FormaPagoMultas_Multas FOREIGN KEY (CodigoMulta) REFERENCES Multas(CodigoMulta);

--4
-- Agregar restricción UNIQUE al campo Email en la tabla Personas
ALTER TABLE Personas
ADD CONSTRAINT UQ_Personas_Email UNIQUE (Email);

-- Agregar restricción UNIQUE al campo RUC en la tabla EntidadEncargada
ALTER TABLE EntidadEncargada
ADD CONSTRAINT UQ_EntidadEncargada_RUC UNIQUE (RUC);

--5
-- Eliminar la restricción UNIQUE del campo Email en la tabla Personas
ALTER TABLE Personas
DROP CONSTRAINT UQ_Personas_Email;

-- Volver a crear la restricción UNIQUE en el campo Email en la tabla Personas
ALTER TABLE Personas
ADD CONSTRAINT UQ_Personas_Email UNIQUE (Email);

--6
--YA SE HIZO

--7
ALTER TABLE Vehiculos
ADD CONSTRAINT CK_Vehiculos_Modelo CHECK (Modelo >= 2000);

--8
--YA SE HIZO