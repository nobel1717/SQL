use baseII
-- Tablas de auditoría para cada acción
CREATE TABLE AuditoriaInsercion (
    idAuditoria INT PRIMARY KEY IDENTITY,
    tabla_afectada NVARCHAR(50),
    accion NVARCHAR(20),
    fecha_hora DATETIME DEFAULT GETDATE()
);

CREATE TABLE AuditoriaActualizacion (
    idAuditoria INT PRIMARY KEY IDENTITY,
    tabla_afectada NVARCHAR(50),
    accion NVARCHAR(20),
    fecha_hora DATETIME DEFAULT GETDATE()
);

CREATE TABLE AuditoriaEliminacion (
    idAuditoria INT PRIMARY KEY IDENTITY,
    tabla_afectada NVARCHAR(50),
    accion NVARCHAR(20),
    fecha_hora DATETIME DEFAULT GETDATE()
);
-- Tablas de auditoría para cada acción en la tabla Pruebas
CREATE TABLE AuditoriaInsercionPruebas (
    idAuditoria INT PRIMARY KEY IDENTITY,
    tabla_afectada NVARCHAR(50),
    accion NVARCHAR(20),
    fecha_hora DATETIME DEFAULT GETDATE()
);

CREATE TABLE AuditoriaActualizacionPruebas (
    idAuditoria INT PRIMARY KEY IDENTITY,
    tabla_afectada NVARCHAR(50),
    accion NVARCHAR(20),
    fecha_hora DATETIME DEFAULT GETDATE()
);


-- Tablas de auditoría para cada acción en la tabla Estudiantes
CREATE TABLE AuditoriaInsercionEstudiantes (
    idAuditoria INT PRIMARY KEY IDENTITY,
    tabla_afectada NVARCHAR(50),
    accion NVARCHAR(20),
    fecha_hora DATETIME DEFAULT GETDATE()
);

CREATE TABLE AuditoriaActualizacionEstudiantes (
    idAuditoria INT PRIMARY KEY IDENTITY,
    tabla_afectada NVARCHAR(50),
    accion NVARCHAR(20),
    fecha_hora DATETIME DEFAULT GETDATE()
);

CREATE TABLE AuditoriaEliminacionEstudiantes (
    idAuditoria INT PRIMARY KEY IDENTITY,
    tabla_afectada NVARCHAR(50),
    accion NVARCHAR(20),
    fecha_hora DATETIME DEFAULT GETDATE()
);

-- Trigger para inserciones en Estudiantes
IF OBJECT_ID('InsertTriggerEstudiantes', 'TR') IS NOT NULL
    DROP TRIGGER InsertTriggerEstudiantes;
GO
CREATE TRIGGER InsertTriggerEstudiantes
ON Estudiantes
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditoriaInsercionEstudiantes (tabla_afectada, accion) VALUES ('Estudiantes', 'Inserción');
END;
GO

-- Trigger para actualizaciones en Estudiantes
IF OBJECT_ID('UpdateTriggerEstudiantes', 'TR') IS NOT NULL
    DROP TRIGGER UpdateTriggerEstudiantes;
GO
CREATE TRIGGER UpdateTriggerEstudiantes
ON Estudiantes
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditoriaActualizacionEstudiantes (tabla_afectada, accion) VALUES ('Estudiantes', 'Actualización');
END;
GO

-- Trigger para eliminaciones en Estudiantes
IF OBJECT_ID('DeleteTriggerEstudiantes', 'TR') IS NOT NULL
    DROP TRIGGER DeleteTriggerEstudiantes;
GO
CREATE TRIGGER DeleteTriggerEstudiantes
ON Estudiantes
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditoriaEliminacionEstudiantes (tabla_afectada, accion) VALUES ('Estudiantes', 'Eliminación');
END;
GO



-- Trigger para inserciones en Pruebas
IF OBJECT_ID('InsertTriggerPruebas', 'TR') IS NOT NULL
    DROP TRIGGER InsertTriggerPruebas;
GO
CREATE TRIGGER InsertTriggerPruebas
ON Prueba
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditoriaInsercionPruebas (tabla_afectada, accion) VALUES ('Pruebas', 'Inserción');
END;
GO

-- Trigger para actualizaciones en Pruebas
IF OBJECT_ID('UpdateTriggerPruebas', 'TR') IS NOT NULL
    DROP TRIGGER UpdateTriggerPruebas;
GO
CREATE TRIGGER UpdateTriggerPruebas
ON Prueba
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditoriaActualizacionPruebas (tabla_afectada, accion) VALUES ('Pruebas', 'Actualización');
END;
GO

-- Insertar un nuevo estudiante
INSERT INTO estudiantes (idestudiantes, cedulae, nombre, apellido, edad, nacimiento, bachiller, numeroEs, genero, gpa, sectorEs, direccionEs, calleEs, idcolegios, idempleados)
VALUES 
  ('EST11', '8-2345-6789', 'Laura', 'Gutierrez', 28, '1995-05-15', 'Ciencias', '6666-6666', 'F', 3.8, 'Centro', 'Panama City', '123', 'COL1', 'EMP3');

-- Verificar el registro en la tabla de auditoría de inserciones
SELECT * FROM AuditoriaInsercionEstudiantes;

-- Actualizar la edad de un estudiante existente
UPDATE Estudiantes SET edad = 29 WHERE idestudiantes = 'EST1';

-- Verificar el registro en la tabla de auditoría de actualizaciones
SELECT * FROM AuditoriaActualizacionEstudiantes;

-- Eliminar un estudiante existente
DELETE FROM facturacion WHERE idestudiantes = 'EST2';
DELETE FROM Prueba WHERE idestudiantes = 'EST2';
DELETE FROM Estudiantes WHERE idestudiantes = 'EST2';

-- Verificar el registro en la tabla de auditoría de eliminaciones
SELECT * FROM AuditoriaEliminacionEstudiantes;


-- Insertar nueva prueba
INSERT INTO Prueba (idprueba, idestudiantes, area, fecha, puntaje, idempleados)
VALUES 
  ('PRUEBA10', 'EST10', 'Ciencias', '2023-01-15', 80.0, 'EMP3'),
  ('PRUEBA20', 'EST11', 'Informatica', '2023-02-20', 75.5, 'EMP5'),
  ('PRUEBA30', 'EST9', 'Humanidades', '2023-03-25', 92.0, 'EMP3');

-- Verificar el registro en la tabla de auditoría de inserciones
SELECT * FROM AuditoriaInsercionPruebas;

-- Actualizar una prueba existente
UPDATE Prueba SET area = 'Informatica' WHERE idprueba = 'PRUEBA1';

-- Verificar el registro en la tabla de auditoría de actualizaciones
SELECT * FROM AuditoriaActualizacionPruebas;


--UserCrear 2 triggers más que considere útiles para las tablas, use su creatividad
-- Trigger para contar actualizaciones del GPA en Estudiantes
IF OBJECT_ID('UpdateGPATriggerEstudiantes', 'TR') IS NOT NULL
    DROP TRIGGER UpdateGPATriggerEstudiantes;
GO
CREATE TRIGGER UpdateGPATriggerEstudiantes
ON Estudiantes
AFTER UPDATE
AS
BEGIN
    IF UPDATE(gpa)
    BEGIN
        INSERT INTO AuditoriaActualizacionEstudiantes (tabla_afectada, accion) 
        VALUES ('Estudiantes', 'Actualización de GPA');
    END;
END;
GO

CREATE TABLE AuditoriaCambioPuntajePruebas (
    idAuditoria INT PRIMARY KEY IDENTITY,
    tabla_afectada NVARCHAR(50),
    accion NVARCHAR(100),
    fecha_hora DATETIME DEFAULT GETDATE()
);

-- Trigger para cambios significativos en el puntaje de Pruebas
IF OBJECT_ID('CambioPuntajeTriggerPruebas', 'TR') IS NOT NULL
    DROP TRIGGER CambioPuntajeTriggerPruebas;
GO

CREATE TRIGGER CambioPuntajeTriggerPruebas
ON Prueba
AFTER UPDATE
AS
BEGIN
    IF UPDATE(puntaje) 
    BEGIN
        DECLARE @prevPuntaje FLOAT, @newPuntaje FLOAT;
        SELECT @prevPuntaje = puntaje FROM deleted;
        SELECT @newPuntaje = puntaje FROM inserted;

        IF ABS(@prevPuntaje - @newPuntaje) > 1
        BEGIN
            INSERT INTO AuditoriaCambioPuntajePruebas (tabla_afectada, accion) VALUES ('Pruebas', 'Actualización de puntaje significativo');
        END;
    END;
END;
GO


--verificacion de la actualizacion del gpa
UPDATE Estudiantes SET GPA = 4.0 WHERE idestudiantes = 'EST11';
SELECT * FROM AuditoriaActualizacionEstudiantes WHERE accion = 'Actualización de GPA';



-- Actualizar el puntaje de una prueba a un valor significativamente diferente
UPDATE Prueba SET puntaje = 95.0 WHERE idprueba = 'PRUEBA30';

-- Verificar el registro en la tabla de auditoría de cambios de puntaje significativos
SELECT * FROM AuditoriaCambioPuntajePruebas;
