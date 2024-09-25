create database baseII
use baseII
-- Creación de la tabla colegios
CREATE TABLE Colegios (
  idcolegios VARCHAR(6) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  sectorCole VARCHAR(50),
  direccionCole VARCHAR(50),
  calleCole VARCHAR(50),
  numeroCole VARCHAR(50),
  --TODAS LAS CONSTRAINT
  CONSTRAINT PK_COLEGIOS PRIMARY KEY (idcolegios), --LLAVE PRIMARIA

    CONSTRAINT UNIQUE_COLEGIOS_NUMERO UNIQUE (numeroCole) --VALORES UNICOS EN LOS NUMEROS TELEFONICOS
);
go
-- Creación de la tabla universidades
CREATE TABLE Universidades (
  iduniversidades VARCHAR(6) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  sitioWeb VARCHAR(100),
  sectorUni VARCHAR(50),
  direccionUni VARCHAR(50),
  calleUni VARCHAR(50),
  numeroUni VARCHAR(50),
  --TODAS LAS CONSTRAINT
	CONSTRAINT PK_UNIVERSIDADES PRIMARY KEY(iduniversidades), --LLAVE PRIMARIA

	CONSTRAINT UNIQUE_SITIO_WEB UNIQUE (sitioWeb), --valores unicos para los sitios webs 

	CONSTRAINT UNIQUE_UNIVERSIDAD_NUMERO UNIQUE (numeroUni) --VALORES UNICOS EN LOS NUMEROS TELEFONICOS
);
go
-- Creación de la tabla empleados
CREATE TABLE Empleados (
  idempleados VARCHAR(6) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  cedula VARCHAR(25) NOT NULL,
  departamento VARCHAR(50) NOT NULL,
  edad INT,
  numeroEm VARCHAR(50),
  sectorEm VARCHAR(50),
  direccionEm VARCHAR(50),
  calleEm VARCHAR(50),
  --TODAS LAS CONSTRAINT
  CONSTRAINT PK_EMPLEADOS PRIMARY KEY (idempleados), --llave primaria

    CONSTRAINT UNIQUE_EMPLEADO_NUMERO UNIQUE (numeroEm), --VALORES UNICOS EN LOS NUMEROS TELEFONICOS
  CONSTRAINT UNIQUE_EMPLEADO_CEDULA UNIQUE (cedula), --VALORES UNICOS PARA LA CEDULA

  CONSTRAINT CHECK_DEPARTAMENTO CHECK (departamento in('Asesor','Contabilidad', 'Desarrollador Software','Tecnico','Gerente')) --check a los departamentos

);


go
-- Creación de la tabla estudiantes
CREATE TABLE estudiantes (
  idestudiantes VARCHAR(10) NOT NULL,
  cedulae VARCHAR(25) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  edad INT,
  nacimiento DATE,
  bachiller VARCHAR(50),
  numeroEs VARCHAR(50),
  genero VARCHAR(1),
  gpa DECIMAL(3, 1) NOT NULL,
  sectorEs VARCHAR(50),
  direccionEs VARCHAR(50),
  calleEs VARCHAR(50),
  idcolegios VARCHAR(6),
  idempleados VARCHAR(6) NOT NULL,

  --TODOS LOS CONSTRAINT
  CONSTRAINT PK_ESTUDIANTES PRIMARY KEY (idestudiantes), --llave primaria

  CONSTRAINT FK_ESTUDIANTES_COLEGIOS FOREIGN KEY (idcolegios) REFERENCES colegios(idcolegios), --LAVE FORANEA
  CONSTRAINT FK_ESTUDIANTES_EMPLEADO FOREIGN KEY (idempleados) REFERENCES empleados(idempleados),--LAVE FORANEA

  CONSTRAINT UNIQUE_CEDULAE UNIQUE (cedulae), --VALORES UNICOS PARA LA CEDULA DEESTUDIANTE
    CONSTRAINT UNIQUE_ESTUDIANTE_NUMERO UNIQUE (numeroEs), --VALORES UNICOS EN LOS NUMEROS TELEFONICOS

  CONSTRAINT CHECK_BACHILLER CHECK (BACHILLER IN ('Ciencias', 'Informatica','Humanidades','Marina','Comercio')), --CHECK PARA LOS TIPOS DE BACHILLER
  CONSTRAINT CHECK_GPA CHECK (gpa BETWEEN 0 AND 5), --CHECK PARA QUE GPA NO SE PASE DEL RANGO
  CONSTRAINT CHECK_GENERO CHECK (genero in ('F','M','HELICOPTERO')) --CHECK PARA GENERO
);
go

-- Creación de la tabla facturacion
CREATE TABLE facturacion (
  idfacturacion VARCHAR(10) NOT NULL,
  saldo DECIMAL(5, 2),
  descuento DECIMAL(5,2),
  total DECIMAL(7,2),
  fecha DATE,
  modo_pago varchar(50) DEFAULT 'Efectivo', --DEFAULT DE MODO DE PAGO
  idestudiantes VARCHAR(10) NOT NULL,

  --TODOS LOS CONSTRAINT
  CONSTRAINT PK_FACTURACION PRIMARY KEY (idfacturacion), --LLAVE PRIMARIA
  CONSTRAINT FK_FACTURACION_ESTUDAINTE FOREIGN KEY (idestudiantes) REFERENCES estudiantes(idestudiantes), --LLAVE FORANEA

  CONSTRAINT CHECK_MODO_PAGO CHECK (modo_pago in ('Efectivo','Tarjeta','Transferencia','Yappy')) --check de modo de pago
);
go


-- Creación de la tabla carreras
CREATE TABLE carreras (
  idcarreras VARCHAR(6) NOT NULL,
  nombre_carrera VARCHAR(50) NOT NULL,
  facultad VARCHAR(50),
  descripcion VARCHAR(200) DEFAULT 'Carreras Universitarias', --CREAR UN DEFAULT PARA LA DESCRIPCION
  nivelAcademico VARCHAR(50) NOT NULL,
  demandaProfecional VARCHAR(50),


  --TODOS LOS CONTEAINT
  CONSTRAINT PK_CARRERAS PRIMARY KEY (idcarreras), --LLAVE PRIMARIA
  
  CONSTRAINT CHECK_NIVELACADEMICO CHECK (nivelAcademico in ('Tecnico','Licenciatura','Ingenieria')),
  CONSTRAINT CHECK_DEMANDA CHECK (demandaProfecional in ('muy alta','media alta','alta','medio','medio bajo','baja','muy baja'))
);
go
create table carreras_universidad(
	idcarreras_universidad varchar(10) not null,
	iduniversidades VARCHAR(6),
	idcarreras VARCHAR(6),
	estado VARCHAR(10),
	duracion DECIMAL(3, 1),
	requisitos_notas DECIMAL(3,1),
	costo DECIMAL(7,2),
	--TODOS LOS CONSTRAINT
	CONSTRAINT PK_CARRERAS_UNIVERSIDAD PRIMARY KEY (idcarreras_universidad),

	CONSTRAINT PK_CARRERAS_UNIVERSIDAD_UNIVERSIDADES FOREIGN KEY (iduniversidades) REFERENCES universidades(iduniversidades),--LAVE FORANEA
    CONSTRAINT PK_CARRERAS_UNIVERSIDAD_CARRERAS FOREIGN KEY (idcarreras) REFERENCES carreras(idcarreras),--LAVE FORANEA

	CONSTRAINT CHECK_ESTADO CHECK (estado in('inactivo','activo','eliminado'))
);
GO
--Creacion de la tabla Prueba
CREATE TABLE Prueba(
idprueba VARCHAR(10) not null,
idestudiantes VARCHAR(10),
area VARCHAR(20),
fecha DATE NOT NULL,
puntaje DECIMAL(3,1) DEFAULT 0,  --DEFAULT QUE SEA 0
idempleados VARCHAR(6),
--todas las constraint 
  CONSTRAINT PK_PRUEBA PRIMARY KEY (idprueba), --LLAVE PRIMARIA

  CONSTRAINT FK_PRUEBA_ESTUDIANTE FOREIGN KEY (idestudiantes) REFERENCES estudiantes(idestudiantes), --llave foranea
  CONSTRAINT FK_PRUEBA_EMPLEADO FOREIGN KEY (idempleados) REFERENCES empleados(idempleados), --llave foranea

  CONSTRAINT CHECK_PRUEBA_AREA_UNi CHECK (area IN ('Ciencias', 'Informatica','Humanidades','Artes')), --CHECK PARA LOS TIPOS DE area de estudio
  CONSTRAINT FK_PRUEBA_CARRERA_UNIVERSIDAD FOREIGN KEY (idempleados) REFERENCES empleados(idempleados),--LAVE FORANEA
);


--Creacion de tabla patrocinadores
CREATE TABLE Patrocinadores(
idpatrocinadores VARCHAR(6) NOT NULL,
ruc VARCHAR (30),
nombre  VARCHAR(50)NOT NULL,
  sectorPatro VARCHAR(50),
  direccionPatro VARCHAR(50),
  callePatro VARCHAR(50),
numeroPatro VARCHAR(15),
correoPatro  VARCHAR(40),

--todas las constraint 
CONSTRAINT PK_PATROCINADORES PRIMARY KEY (idpatrocinadores), --LLAVE PRIMARIA

CONSTRAINT UNIQUE_RUC UNIQUE (ruc),
CONSTRAINT UNQUE_CORREO UNIQUE (correoPatro)

);

--Creacion de tabla tutor
CREATE TABLE Tutor(
idtutor VARCHAR(10) NOT NULL,
nombre VARCHAR(20) NOT NULL,
apellido VARCHAR(20),
cedulaTutor VARCHAR(20) NOT NULL,
numeroTutor VARCHAR(15)NOT NULL,
correoTutor VARCHAR(20),
idpatrocinadores varchar(6),
CONSTRAINT PK_TUTOR PRIMARY KEY (idtutor), --LLAVE PRIMARIA
    
    CONSTRAINT UNIQUE_TUTOR_CEDULA UNIQUE (cedulaTutor), --VALORES UNICOS EN LOS CEDULA
	CONSTRAINT UNIQUE_TUTOR_NUMERO UNIQUE (numeroTutor), --VALORES UNICOS EN LOS NUMEROS TELEFONICOS
    CONSTRAINT UNIQUE_TUTOR_CORREO UNIQUE (correoTutor), --VALORES UNICOS EN LOS CORREOS
	CONSTRAINT FK_TUTOR_PATROCINADORES FOREIGN KEY (idpatrocinadores) REFERENCES patrocinadores(idpatrocinadores), --llavae foranea


);--ponerlo como unique

--Creacion de la tabla Tutoria
CREATE TABLE Tutoria(
idtutoria VARCHAR(6) NOT NULL,
numeroTutoria VARCHAR(10) NOT NULL,
idestudiantes VARCHAR(10) NOT NULL,
idtutor VARCHAR(10) NOT NULL,
area varchar(20),--check de Ciencias, Humanidades,Artes,Ciencias Tecnologica
descripcion VARCHAR(200), 


--TODOS LOS CONSTRAINT 
CONSTRAINT PK_TUTORIA PRIMARY KEY (idtutoria, numeroTutoria), --LLAVE PRIMARIA

CONSTRAINT FK_TUTORIA_ESTUDIANTES FOREIGN KEY (idestudiantes) REFERENCES estudiantes(idestudiantes), --llavae foranea
CONSTRAINT FK_TUTORIA_TUTOR FOREIGN KEY (idtutor) REFERENCES Tutor(idtutor), --llavae foranea


CONSTRAINT CHECK_TUTORIA_AREA_UNi CHECK (area IN ('Ciencias', 'Informatica','Humanidades','Artes')), --CHECK PARA LOS TIPOS DE area de estudio

);




--Insercion de los datos--

  -- Inserciones en la tabla Colegios
INSERT INTO Colegios (idcolegios, nombre, sectorCole, direccionCole, calleCole, numeroCole)
VALUES 
  ('COL1', 'CTG', 'Guadalupe', 'La Chorrera', '123', '6972-2367'),
  ('COL2', 'PPS', 'Barrio Balboa', 'La Chorrera', '456', '6538-2938'),
  ('COL3', 'MCO', 'Barrio Colon', 'La Chorrera', '789', '6792-2874'),
  ('COL4', 'IPTCH', 'La Polvadera', 'La Chorrera', '123', '6309-2389'),
  ('COL5', 'IPTC', 'Capira', 'Capira', '456', '6834-5456'),
  ('COL6', 'IESJ', 'Nuevo Reparto El Carmen', 'Panama', '789', '6131-1244');
  
-- Inserciones en la tabla Universidades
INSERT INTO Universidades (iduniversidades, nombre,sitioWeb, sectorUni, direccionUni, calleUni, numeroUni)
VALUES 
  ('UNI1', 'UTP', 'https://utp.ac.pa', 'Via Transismica', 'Centro Metropolitno Victor Levi Saso', '987','6728-2342'),
  ('UNI2', 'UP', 'https://www.up.ac.pa', 'Via transismica', 'Urbanizacion El Cangrejo', '25','6459-9876'),
  ('UNI3', 'UMIP', 'https://www.umip.ac.pa', 'La Boca', 'Edificio 1033', '26','6198-8545'),
  ('UNI4', 'UIP', 'https://uip.edu.pa', 'Boulevard Costa Verde', 'La Chorrera', '98','6095-2565'),
  ('UNI5', 'UI', 'https://www.udelistmo.edu', 'Metromall', 'Ciudad de Panama', '76','6632-3529'),
  ('UNI6', 'UNAM', 'https://uam.edu.pa', 'Colonia Villa Quietud', 'Ciudad de Panama', '326','6709-8764');

-- Inserciones en la tabla Empleados
INSERT INTO Empleados (idempleados, nombre, apellido, cedula, departamento, edad, numeroEm, sectorEm, direccionEm, calleEm)
VALUES 
  ('EMP1', 'Juan', 'Perez', '8-2453-3452', 'Desarrollador Software', 30, '6999-9999', 'El Coco', 'La Chorrea','78'),
  ('EMP2', 'Maria', 'Gomez', '8-235-7688', 'Contabilidad', 35, '6394-9347', 'Guadalupe', 'La Chorrera','34'),
  ('EMP3', 'Carlos', 'Rodriguez', '7-9743-2494', 'Asesor', 40, '6910-0308', 'El Dorado', 'Ciudad de Panama','08'),
  ('EMP4', 'Esteban', 'Madero', '3-0924-2764', 'Gerente', 30, '6103-0347', 'El Espino', 'La Chorrera','23'),
  ('EMP5', 'Lucas', 'Alonzo', '8-8364-9264', 'Asesor', 35, '6027-9284', 'La Pintada', 'Cocle','35'),
  ('EMP6', 'Rosmeri', 'Lu', '8-9273-3263', 'Tecnico', 40, '6823-2374', 'Santiago', 'Veraguas','52');
;

-- Inserciones en la tabla estudiantes
INSERT INTO estudiantes (idestudiantes, cedulae, nombre, apellido, edad, nacimiento, bachiller, numeroEs, genero, gpa, sectorEs, direccionEs, calleEs, idcolegios, idempleados)
VALUES 
  ('EST1', '8-247-7854', 'Ana', 'Lopez', 18, '2001-01-01', 'Ciencias', '6790-9435', 'F', 4.0, 'Penonome', 'Cocle', '12', 'COL1', 'EMP5'),
  ('EST2', '5-6445-4324', 'Pedro', 'Ramirez', 20, '2003-02-01', 'Informatica', '6334-3453', 'M', 3.5, 'La Pita', 'Capira', '01', 'COL4', 'EMP3'),
  ('EST3', '8-454-4666', 'Laura', 'Garcia', 25, '1998-03-01', 'Humanidades', '6623-4234', 'F', 4.5, 'Trapichito', 'La Chorrera', '20', 'COL2', 'EMP3'),
  ('EST4', '8-2890-2350', 'Mitzi', 'Anel', 19, '2004-01-01', 'Ciencias', '6123-4640', 'F', 4.9, 'Guadalupe', 'La Chorrera', '23', 'COL2', 'EMP5'),
  ('EST5', '3-2436-7890', 'Brayan', 'Smit', 19, '2004-02-01', 'Informatica', '6223-4353', 'M', 3.9, 'Balboa', 'Ciudad de Panama', '24', 'COL6', 'EMP3'),
  ('EST6', '2-2344-5480', 'Tomas', 'Chan', 20, '2003-03-01', 'Humanidades', '6023-7682', 'M', 4.8, 'Costa Verde', 'La Chorrera', '234', 'COL6', 'EMP5'),
  ('EST7', '9-454-4666', 'Sintia', 'Mal', 20, '2003-03-01', 'Humanidades', '6443-4264', 'F', 4.9, 'Trapichito', 'La Chorrera', '20', 'COL2', 'EMP3'),
  ('EST8', '2-2890-2350', 'Kevin', 'Mar', 19, '2004-01-24', 'Ciencias', '6223-4644', 'M', 4.9, 'El Coco', 'La Chorrera', '23', 'COL1', 'EMP5'),
  ('EST9', '13-2436-7890', 'Mateo', 'Ramos', 19, '2004-02-12', 'Informatica', '6222-2253', 'M', 4.7, 'Via Argentina', 'Ciudad de Panama', '54', 'COL6', 'EMP3'),
  ('EST10', '8-2344-5480', 'Maria', 'Mas', 20, '2003-07-08', 'Humanidades', '6076-7682', 'F', 4.8, 'Vacamonte', 'La Chorrera', '234', 'COL6', 'EMP5');


-- Inserciones en la tabla facturacion
INSERT INTO facturacion (idfacturacion, saldo, descuento, total, fecha, modo_pago, idestudiantes)
VALUES 
  ('FAC1', 100.0, 10.0, 90.0, '2023-01-04', 'Tarjeta', 'EST1'),
  ('FAC2', 150.0, 00.0, 150.0, '2023-02-01', 'Transferencia', 'EST2'),
  ('FAC3', 200.0, 00.0, 200.0, '2023-03-07', 'Yappy', 'EST3'),
  ('FAC4', 300.0, 10.0, 290.0, '2023-04-10', 'Tarjeta','EST5'),
  ('FAC5', 476.0, 00.0, 476.0, '2023-05-03', 'Transferencia','EST6'),
  ('FAC6', 200.0, 00.0, 200.0, '2023-05-09', 'Yappy', 'EST4');

  SELECT*FROM facturacion


  -- Inserciones en la tabla carreras
INSERT INTO carreras (idcarreras, nombre_carrera, facultad,descripcion,nivelAcademico, demandaProfecional)
VALUES 
  ('CARR1', 'Ingeniería Informática', 'Facultad de Ingeniería','Carreras Universitarias', 'Ingenieria', 'muy alta'),
  ('CARR2', 'Licenciatura en Ciencias Sociales', 'Facultad de Ciencias Sociales', 'Carreras Universitarias','Licenciatura', 'media alta'),
  ('CARR3', 'Técnico en Programación', 'Facultad de Tecnología','Carreras Universitarias', 'Tecnico', 'alta'),
  ('CARR4', 'Enfermeria', 'Facultad de Enfermeria', 'Carreras Universitarias', 'Licenciatura','muy alta'),
  ('CARR5', 'Pasicologia', 'Facultad de Ciencias Sociales','Carreras Universitarias', 'Licenciatura', 'media alta'),
  ('CARR6', 'Actuacion', 'Facultad de Artes','Carreras Universitarias', 'Tecnico', 'alta');

-- Inserciones en la tabla carreras_universidad
INSERT INTO carreras_universidad (idcarreras_universidad, iduniversidades, idcarreras, estado, duracion, requisitos_notas, costo)
VALUES 
  ('CARR_UNI1', 'UNI1', 'CARR1', 'activo', 5.0, 90.0, 500.0),
  ('CARR_UNI2', 'UNI2', 'CARR4', 'activo', 5.0, 90.0, 7500.0),
  ('CARR_UNI3', 'UNI4', 'CARR3', 'activo', 3.0, 70.0, 4000.0),
  ('CARR_UNI4', 'UNI5', 'CARR5', 'activo', 5.0, 80.0, 5000.0),
  ('CARR_UNI5', 'UNI3', 'CARR2', 'activo', 4.0, 75.0, 4500.0),
  ('CARR_UNI6', 'UNI6', 'CARR6', 'activo', 3.0, 70.0, 4000.0);

 
-- Inserciones en la tabla Prueba
INSERT INTO Prueba (idprueba, idestudiantes, area, fecha, puntaje, idempleados)
VALUES 
  ('PRUEBA1', 'EST1', 'Ciencias', '2023-01-15', 80.0, 'EMP3'),
  ('PRUEBA2', 'EST2', 'Informatica', '2023-02-20', 75.5, 'EMP5'),
  ('PRUEBA3', 'EST7', 'Humanidades', '2023-03-25', 92.0, 'EMP3'),
  ('PRUEBA4', 'EST4', 'Ciencias', '2023-05-09', 95.0, 'EMP5'),
  ('PRUEBA5', 'EST5', 'Informatica', '2023-06-26', 75.5, 'EMP5'),
  ('PRUEBA6', 'EST6', 'Humanidades', '2023-06-12', 93.0, 'EMP3'),
  ('PRUEBA7', 'EST8', 'Informatica', '2023-05-09', 95.0, 'EMP5'),
  ('PRUEBA8', 'EST9', 'Informatica', '2023-06-26', 98.5, 'EMP5'),
  ('PRUEBA9', 'EST10', 'Ciencias', '2023-06-12', 93.0, 'EMP3');

-- Inserciones en la tabla Patrocinadores
INSERT INTO Patrocinadores (idpatrocinadores, ruc, nombre, sectorPatro, direccionPatro, callePatro, numeroPatro, correoPatro)
VALUES 
  ('PATRO1', '1234567', 'Super 99', 'El Coco', 'La Chorrera', '123','234-231', 'super99@gmail.com'),
  ('PATRO2', '9876543', 'El Costo', 'Plaza Italia', 'La Chorrera', '456','435-352', 'elcosto@hotmail.com'),
  ('PATRO3', '5555555', 'Felipe Motta ', 'Tocumen', 'Ciudad de Panama', '789','236-743' ,'felipemotta@icloud.com'),
  ('PATRO4', '1985678', 'Ricardo Perez S.A', 'El Dorado', 'Ciudad de Panama', '09','895-342' ,'ricardoperez@gmail.com'),
  ('PATRO5', '09598', 'El Rey', 'Costa Verde', 'La Chorrera', '96','262-235', 'supermercadorey@outlook.com'),
  ('PATRO6', '78655', 'Samsung ', 'Albrook', 'Ciudad de Panama', '76','389-466','samsunglatin@hotmail.com');


-- Inserciones en la tabla Tutor
INSERT INTO Tutor (idtutor, nombre, apellido, cedulaTutor, numeroTutor, correoTutor,idpatrocinadores)
VALUES 
  ('TUTOR1', 'Esteban', 'Solis', '8-324-532', '6483-4928', 'salisest@gmail.com', 'PATRO1'),
  ('TUTOR2', 'Maca', 'Serrano', '4-434-3425', '6502-8735', 'serrano34@gmail.com', 'PATRO2'),
  ('TUTOR3', 'Tobias', 'Sol', '8-2456-5664', '743-733', 'tobisol2@gmail.com', 'PATRO3'),
  ('TUTOR4', 'Oscar', 'Sanjur', '8-2373-895', '6803-6270', 'oscarl@gmail.com', 'PATRO4'),
  ('TUTOR5', 'Tadeo', 'Williams', '8-7049-5465', '6123-4825', 'willdeo@icloud.com', 'PATRO5'),
  ('TUTOR6', 'Luna', 'Moran', '8-6712-6982', '6028-4725', 'lucimoran@gmail.com', 'PATRO6');

-- Inserciones en la tabla Tutoria
INSERT INTO Tutoria (idtutoria, numeroTutoria, idestudiantes, idtutor, area, descripcion)
VALUES 
  ('TUTO1', 'T1', 'EST4', 'TUTOR1', 'Ciencias', 'Tutoría para reforzar conocimientos en quimica y fisica'),
  ('TUTO2', 'T2', 'EST6', 'TUTOR5', 'Humanidades', 'Tutoría de derecho penal basico'),
  ('TUTO3', 'T3', 'EST7', 'TUTOR3', 'Humanidades', 'Tutoría para redacción de ensayos'),
  ('TUTO4', 'T4', 'EST10', 'TUTOR4', 'Ciencias', 'Tutoría para reforzar conocimientos en matemáticas'),
  ('TUTO5', 'T5', 'EST8', 'TUTOR2', 'Informatica', 'Tutoría para proyectos de programación'),
  ('TUTO6', 'T6', 'EST9', 'TUTOR6', 'Informatica', 'Tutoría en desarrollo UML');
