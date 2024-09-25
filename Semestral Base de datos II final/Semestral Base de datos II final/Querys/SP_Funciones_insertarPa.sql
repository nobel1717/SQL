--FUNCIONES 2

--FUNCION PARA CALCULAR LA EDAD DE ESTUDIANTE
CREATE FUNCTION dbo.CalcularEdad(@fechaNacimiento DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @fechaNacimiento, GETDATE());
END;

CREATE FUNCTION dbo.ConvertirAMayus(@texto VARCHAR(255))
RETURNS VARCHAR(255)
AS
BEGIN
  RETURN upper(@texto);
END;

--funcion para calcular el total de la facturacion
create function dbo.CalcularTotal(@saldo decimal(10,2), @descuento decimal(10,2))
returns decimal(10,2)
as
begin
	return @saldo - @descuento;
end


create function dbo.FormatearLink(@link varchar(200))
returns varchar(200)
as
begin
	if @link not like ('https://www%') and @link not like ('http://www%')
	begin
		if @link like 'http%'
		begin 
			SET @link = replace(@link, 'http://', 'http://www.')
		end

		if @link like 'https%'
		begin
			SET @link = replace(@link, 'https://', 'https://www.')
		end
	end
	return @link
end;




--procedimientos de almacenados
--Colegios@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2
CREATE PROCEDURE InsertarDatosEnColegios
    @IdColegios VARCHAR(6),
    @Nombre VARCHAR(50),
    @SectorCole VARCHAR(50),
    @DireccionCole VARCHAR(50),
    @CalleCole VARCHAR(50),
    @NumeroCole VARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        -- Inserta datos en la tabla Colegios
        INSERT INTO Colegios (idcolegios, nombre, sectorCole, direccionCole, calleCole, numeroCole)
        VALUES (@IdColegios, @Nombre, @SectorCole, @DireccionCole, @CalleCole, @NumeroCole);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error al insertar datos en la tabla Colegios: ' + ERROR_MESSAGE();
    END CATCH;
END;

--Universidad@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
CREATE PROCEDURE InsertarDatosEnUni
    @IdUniversidad NVARCHAR(6),
    @Nombre NVARCHAR(50),
    @SitioWeb VARCHAR(100),
    @SectorUni NVARCHAR(50),
    @DireccionUni NVARCHAR(50),
    @CalleUni NVARCHAR(50),
    @NumeroUni NVARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        -- Inserta datos en la tabla Universidades
		set @SitioWeb = dbo.FormatearLink(@SitioWeb); --actualizar y formatear el link

        INSERT INTO Universidades (iduniversidades, nombre, sitioWeb, sectorUni, direccionUni, calleUni, numeroUni)
        VALUES (@IdUniversidad, @Nombre, @SitioWeb, @SectorUni, @DireccionUni, @CalleUni, @NumeroUni);

        COMMIT;
    END TRY
    BEGIN CATCH

        ROLLBACK;
        PRINT 'Error al insertar datos en la tabla Universidades: ' + ERROR_MESSAGE();
    END CATCH
END;


--Empleado@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
CREATE PROCEDURE InsertarDatosEnEmpleados
    @IdEmpleado VARCHAR(6),
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Cedula VARCHAR(25),
    @Departamento VARCHAR(50),
    @Edad INT,
    @NumeroEm VARCHAR(50),
    @SectorEm VARCHAR(50),
    @DireccionEm VARCHAR(50),
    @CalleEm VARCHAR(50)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		-- Inserta datos en la tabla Empleados
		INSERT INTO Empleados (idempleados, nombre, apellido, cedula, departamento, edad, numeroEm, sectorEm, direccionEm, calleEm)
		VALUES (@IdEmpleado, @Nombre, @Apellido, @Cedula, @Departamento, @Edad, @NumeroEm, @SectorEm, @DireccionEm, @CalleEm);

		COMMIT;
	END TRY
	BEGIN CATCH
		-- Si se produce un error, revierte la transacción
		ROLLBACK;
   		PRINT 'Error al insertar datos en la tabla Empleados: ' + ERROR_MESSAGE();
	END CATCH
END;



--estudainte@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

CREATE PROCEDURE InsertarDatosEnEstudiantes
    @IdEstudiante VARCHAR(10),
    @CedulaE VARCHAR(25),
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Nacimiento DATE,
    @Bachiller VARCHAR(50),
    @NumeroEs VARCHAR(50),
    @Genero VARCHAR(1),
    @GPA DECIMAL(3, 1),
    @SectorEs VARCHAR(50),
    @DireccionEs VARCHAR(50),
    @CalleEs VARCHAR(50),
    @IdColegios VARCHAR(6),
    @IdEmpleado VARCHAR(6)
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
			declare @Edad int
			set @Edad = dbo.CalcularEdad(@Nacimiento) --para calcular la edad sin la necesidad de que lo inserte
        -- Inserta datos en la tabla estudiantes
        INSERT INTO estudiantes (idestudiantes, cedulae, nombre, apellido, edad, nacimiento, bachiller, numeroEs, genero, gpa, sectorEs, direccionEs, calleEs, idcolegios, idempleados)
        VALUES (@IdEstudiante, @CedulaE, @Nombre, @Apellido, @Edad, @Nacimiento, @Bachiller, @NumeroEs, @Genero, @GPA, @SectorEs, @DireccionEs, @CalleEs, @IdColegios, @IdEmpleado);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error al insertar datos en la tabla estudiantes: ' + ERROR_MESSAGE();
    END CATCH
END;


--facturacion@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

CREATE PROCEDURE InsertarDatosEnFacturacion
    @IdFacturacion VARCHAR(10),
    @Saldo DECIMAL(5, 2),
    @Descuento DECIMAL(5, 2),
    @Fecha DATE,
    @ModoPago VARCHAR(50),
    @IdEstudiante VARCHAR(10)
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        -- Inserta datos en la tabla facturacion
		declare @Total decimal(10,2)
		set @Total =dbo.CalcularTotal(@Saldo,@Descuento)
        INSERT INTO facturacion (idfacturacion, saldo, descuento, total, fecha, modo_pago, idestudiantes)
        VALUES (@IdFacturacion, @Saldo, @Descuento, @Total, @Fecha, @ModoPago, @IdEstudiante);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error al insertar datos en la tabla facturacion: ' + ERROR_MESSAGE();
    END CATCH
END;


--carreras @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@]\\

CREATE PROCEDURE InsertarDatosEnCarreras
    @IdCarrera VARCHAR(6),
    @NombreCarrera VARCHAR(50),
    @Facultad VARCHAR(50),
    @Descripcion VARCHAR(200),
    @NivelAcademico VARCHAR(50),
    @DemandaProfesional VARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        -- Inserta datos en la tabla carreras
		set @Descripcion = dbo.ConvertirAMayus(@Descripcion);

        INSERT INTO carreras (idcarreras, nombre_carrera, facultad, descripcion, nivelAcademico, demandaProfecional)
        VALUES (@IdCarrera, @NombreCarrera, @Facultad, @Descripcion, @NivelAcademico, @DemandaProfesional);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error al insertar datos en la tabla carreras: ' + ERROR_MESSAGE();
    END CATCH
END;


--universidad carrera@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

CREATE PROCEDURE InsertarDatosEnCarrerasUniversidad
    @IdCarreraUniversidad VARCHAR(10),
    @IdUniversidad VARCHAR(6),
    @IdCarrera VARCHAR(6),
    @Estado VARCHAR(10),
    @Duracion DECIMAL(3, 1),
    @RequisitosNotas DECIMAL(3, 1),
    @Costo DECIMAL(7, 2)
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        -- Inserta datos en la tabla carreras_universidad
        INSERT INTO carreras_universidad (idcarreras_universidad, iduniversidades, idcarreras, estado, duracion, requisitos_notas, costo)
        VALUES (@IdCarreraUniversidad, @IdUniversidad, @IdCarrera, @Estado, @Duracion, @RequisitosNotas, @Costo);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error al insertar datos en la tabla carreras_universidad: ' + ERROR_MESSAGE();
    END CATCH;
END;


--prueba@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

CREATE PROCEDURE InsertarDatosEnPrueba
    @IdPrueba VARCHAR(10),
    @IdEstudiante VARCHAR(10),
    @Area VARCHAR(20),
    @Fecha DATE,
    @Puntaje DECIMAL(3, 1),
    @IdEmpleado VARCHAR(6)
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        -- Inserta datos en la tabla Prueba
        INSERT INTO Prueba (idprueba, idestudiantes, area, fecha, puntaje, idempleados)
        VALUES (@IdPrueba, @IdEstudiante, @Area, @Fecha, @Puntaje, @IdEmpleado);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error al insertar datos en la tabla Prueba: ' + ERROR_MESSAGE();
    END CATCH;
END;


--patrocinador@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
CREATE PROCEDURE InsertarDatosEnPatrocinadores
    @IdPatrocinadores VARCHAR(6),
    @RUC VARCHAR(30),
    @Nombre VARCHAR(50),
    @SectorPatro VARCHAR(50),
    @DireccionPatro VARCHAR(50),
    @CallePatro VARCHAR(50),
    @NumeroPatro VARCHAR(15),
    @CorreoPatro VARCHAR(40)
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        -- Inserta datos en la tabla Patrocinadores
        INSERT INTO Patrocinadores (idpatrocinadores, ruc, nombre, sectorPatro, direccionPatro, callePatro, numeroPatro, correoPatro)
        VALUES (@IdPatrocinadores, @RUC, @Nombre, @SectorPatro, @DireccionPatro, @CallePatro, @NumeroPatro, @CorreoPatro);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error al insertar datos en la tabla Patrocinadores: ' + ERROR_MESSAGE();
    END CATCH;
END;

--tutor@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
CREATE PROCEDURE InsertarDatosEnTutor
    @IdTutor VARCHAR(10),
    @Nombre VARCHAR(20),
    @Apellido VARCHAR(20),
    @CedulaTutor VARCHAR(20),
    @NumeroTutor VARCHAR(15),
    @CorreoTutor VARCHAR(20)
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        -- Inserta datos en la tabla Tutor
        INSERT INTO Tutor (idtutor, nombre, apellido, cedulaTutor, numeroTutor, correoTutor)
        VALUES (@IdTutor, @Nombre, @Apellido, @CedulaTutor, @NumeroTutor, @CorreoTutor);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error al insertar datos en la tabla Tutor: ' + ERROR_MESSAGE();
    END CATCH;
END;




--tutoria@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
CREATE PROCEDURE InsertarDatosEnTutoria
    @IdTutoria VARCHAR(6),
    @NumeroTutoria VARCHAR(10),
    @IdEstudiante VARCHAR(10),
    @IdTutor VARCHAR(10),
    @Area VARCHAR(20),
    @Descripcion VARCHAR(200)
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        -- Inserta datos en la tabla Tutoria
		set @Descripcion = dbo.ConvertirAMayus(@Descripcion);
        INSERT INTO Tutoria (idtutoria, numeroTutoria, idestudiantes, idtutor, area, descripcion)
        VALUES (@IdTutoria, @NumeroTutoria, @IdEstudiante, @IdTutor, @Area, @Descripcion);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error al insertar datos en la tabla Tutoria: ' + ERROR_MESSAGE();
    END CATCH;
END;

--proba
exec InsertarDatosEnTutoria '223','312','EST1','TUTOR1','Ciencias','mondogo'
exec ImpresionTodoRegistro tutoria



--PRUEBAS ---------------------------------------
DECLARE @fechaNacimiento DATE = '2000-01-01';
DECLARE @edad INT;

SET @edad = dbo.CalcularEdad(@fechaNacimiento);
PRINT 'Edad: ' + CAST(@edad AS VARCHAR(3));





-- Ahora ejecuta tu consulta
SELECT CONVERT(varchar, CAST('01-02-2000' AS datetime), 23) AS NuevaFecha;
