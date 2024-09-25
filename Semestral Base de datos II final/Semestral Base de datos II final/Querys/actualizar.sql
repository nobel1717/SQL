--actualizar
use baseII

--colegios$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE PROCEDURE ActualizarColegio
    @idcolegios NVARCHAR(50),
    @nombre NVARCHAR(255),
    @sectorCole NVARCHAR(255),
    @direccionCole NVARCHAR(255),
    @calleCole NVARCHAR(255),
    @numeroCole NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Colegios
        SET
            nombre = @nombre,
            sectorCole = @sectorCole,
            direccionCole = @direccionCole,
            calleCole = @calleCole,
            numeroCole = @numeroCole
        WHERE
            idcolegios = @idcolegios;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error durante la actualización: ' + ERROR_MESSAGE();
    END CATCH
END;


--universidades$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

CREATE PROCEDURE ActualizarUniversidad
    @iduniversidades NVARCHAR(50),
    @nombre NVARCHAR(255),
    @sitioWeb NVARCHAR(255),
    @sectorUni NVARCHAR(255),
    @direccionUni NVARCHAR(255),
    @calleUni NVARCHAR(255),
    @numeroUni NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
				set @SitioWeb = dbo.FormatearLink(@SitioWeb); --actualizar y formatear el link
        UPDATE Universidades
        SET
            nombre = @nombre,
            sitioWeb = @sitioWeb,
            sectorUni = @sectorUni,
            direccionUni = @direccionUni,
            calleUni = @calleUni,
            numeroUni = @numeroUni
        WHERE
            iduniversidades = @iduniversidades;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error durante la actualización: ' + ERROR_MESSAGE();
    END CATCH
END;


--empleado$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE PROCEDURE ActualizarEmpleado
    @idempleados NVARCHAR(50),
    @nombre NVARCHAR(255),
    @apellido NVARCHAR(255),
    @cedula NVARCHAR(255),
    @departamento NVARCHAR(255),
    @edad INT,
    @numeroEm NVARCHAR(255),
    @sectorEm NVARCHAR(255),
    @direccionEm NVARCHAR(255),
    @calleEm NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Empleados
        SET
            nombre = @nombre,
            apellido = @apellido,
            cedula = @cedula,
            departamento = @departamento,
            edad = @edad,
            numeroEm = @numeroEm,
            sectorEm = @sectorEm,
            direccionEm = @direccionEm,
            calleEm = @calleEm
        WHERE
            idempleados = @idempleados;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error durante la actualización: ' + ERROR_MESSAGE();
    END CATCH
END;

--estudiante$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE PROCEDURE ActualizarEmpleado
    @idempleados NVARCHAR(50),
    @nombre NVARCHAR(255),
    @apellido NVARCHAR(255),
    @cedula NVARCHAR(255),
    @departamento NVARCHAR(255),
    @numeroEm NVARCHAR(255),
    @sectorEm NVARCHAR(255),
    @direccionEm NVARCHAR(255),
    @calleEm NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

			declare @Edad int
			set @Edad = dbo.CalcularEdad(@Nacimiento) --para calcular la edad sin la necesidad de que lo inserte

        UPDATE Empleados
        SET
            nombre = @nombre,
            apellido = @apellido,
            cedula = @cedula,
            departamento = @departamento,
            edad = @edad,
            numeroEm = @numeroEm,
            sectorEm = @sectorEm,
            direccionEm = @direccionEm,
            calleEm = @calleEm
        WHERE
            idempleados = @idempleados;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error durante la actualización: ' + ERROR_MESSAGE();
    END CATCH
END;

--facturacion$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE PROCEDURE ActualizarFacturacion
    @idfacturacion NVARCHAR(50),
    @saldo DECIMAL(10, 2),
    @descuento DECIMAL(10, 2),
    @fecha DATE,
    @modo_pago NVARCHAR(255),
    @idestudiantes NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
		declare @Total decimal(10,2)
		set @Total =dbo.CalcularTotal(@Saldo,@Descuento)
        UPDATE facturacion
        SET
            saldo = @saldo,
            descuento = @descuento,
            total = @total,
            fecha = @fecha,
            modo_pago = @modo_pago,
            idestudiantes = @idestudiantes
        WHERE
            idfacturacion = @idfacturacion;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error durante la actualización: ' + ERROR_MESSAGE();
    END CATCH
END;

--carrera$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE PROCEDURE ActualizarCarrera
    @idcarreras NVARCHAR(50),
    @nombre_carrera NVARCHAR(255),
    @facultad NVARCHAR(255),
    @descripcion NVARCHAR(MAX),
    @nivelAcademico NVARCHAR(255),
    @demandaProfecional NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE carreras
        SET
            nombre_carrera = @nombre_carrera,
            facultad = @facultad,
            descripcion = @descripcion,
            nivelAcademico = @nivelAcademico,
            demandaProfecional = @demandaProfecional
        WHERE
            idcarreras = @idcarreras;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error durante la actualización: ' + ERROR_MESSAGE();
    END CATCH
END;

--carrerauni$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE PROCEDURE ActualizarCarreraUniversidad
    @idcarreras_universidad NVARCHAR(50),
    @iduniversidades NVARCHAR(50),
    @idcarreras NVARCHAR(50),
    @estado NVARCHAR(50),
    @duracion DECIMAL(5, 1),
    @requisitos_notas DECIMAL(5, 1),
    @costo DECIMAL(10, 2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE carreras_universidad
        SET
            iduniversidades = @iduniversidades,
            idcarreras = @idcarreras,
            estado = @estado,
            duracion = @duracion,
            requisitos_notas = @requisitos_notas,
            costo = @costo
        WHERE
            idcarreras_universidad = @idcarreras_universidad;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error durante la actualización: ' + ERROR_MESSAGE();
    END CATCH
END;


--prueba$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE PROCEDURE ActualizarPrueba
    @idprueba NVARCHAR(50),
    @idestudiantes NVARCHAR(50),
    @area NVARCHAR(255),
    @fecha DATE,
    @puntaje DECIMAL(5, 1),
    @idempleados NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Prueba
        SET
            idestudiantes = @idestudiantes,
            area = @area,
            fecha = @fecha,
            puntaje = @puntaje,
            idempleados = @idempleados
        WHERE
            idprueba = @idprueba;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error durante la actualización: ' + ERROR_MESSAGE();
    END CATCH
END;


--patrocvinadoresd###############################################################################################################
CREATE PROCEDURE ActualizarPatrocinador
    @idpatrocinadores NVARCHAR(50),
    @ruc NVARCHAR(50),
    @nombre NVARCHAR(255),
    @sectorPatro NVARCHAR(255),
    @direccionPatro NVARCHAR(255),
    @callePatro NVARCHAR(255),
    @numeroPatro NVARCHAR(255),
    @correoPatro NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Patrocinadores
        SET
            ruc = @ruc,
            nombre = @nombre,
            sectorPatro = @sectorPatro,
            direccionPatro = @direccionPatro,
            callePatro = @callePatro,
            numeroPatro = @numeroPatro,
            correoPatro = @correoPatro
        WHERE
            idpatrocinadores = @idpatrocinadores;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error durante la actualización: ' + ERROR_MESSAGE();
    END CATCH
END;


--tutor$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE PROCEDURE ActualizarTutor
    @idtutor NVARCHAR(50),
    @nombre NVARCHAR(255),
    @apellido NVARCHAR(255),
    @cedulaTutor NVARCHAR(50),
    @numeroTutor NVARCHAR(50),
    @correoTutor NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Tutor
        SET
            nombre = @nombre,
            apellido = @apellido,
            cedulaTutor = @cedulaTutor,
            numeroTutor = @numeroTutor,
            correoTutor = @correoTutor
        WHERE
            idtutor = @idtutor;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error durante la actualización: ' + ERROR_MESSAGE();
    END CATCH
END;


--tutoria$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE PROCEDURE ActualizarTutoria
    @idtutoria NVARCHAR(50),
    @numeroTutoria NVARCHAR(50),
    @idestudiantes NVARCHAR(50),
    @idtutor NVARCHAR(50),
    @area NVARCHAR(255),
    @descripcion NVARCHAR(MAX)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Tutoria
        SET
            numeroTutoria = @numeroTutoria,
            idestudiantes = @idestudiantes,
            idtutor = @idtutor,
            area = @area,
            descripcion = @descripcion
        WHERE
            idtutoria = @idtutoria;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error durante la actualización: ' + ERROR_MESSAGE();
    END CATCH
END;























