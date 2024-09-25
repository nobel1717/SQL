/*
• Procedimiento almacenado para realizar una búsqueda de un registro utilizando su llave primaria. (8)
• Procedimiento almacenado que me devuelva todos los registros de la tabla. (8)
• 2 procedimientos almacenados por cada tabla que haga consultas de acuerdo con una funcionalidad de
la aplicación o la lógica del negocio. (16)
*/
use baseII

CREATE PROCEDURE BorrarRegistro
    @id VARCHAR(6),
    @tabla VARCHAR(20)
AS
BEGIN
    BEGIN TRY
        DECLARE @sqlQuery NVARCHAR(MAX);

        SET @sqlQuery = 
            'delete * FROM ' + QUOTENAME(@tabla) +
            ' WHERE ' + QUOTENAME('id' + LOWER(@tabla)) + ' = @id';

        EXEC sp_executesql @sqlQuery, N'@id VARCHAR(6)', @id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;

CREATE PROCEDURE BuscarRegistro
    @id VARCHAR(6),
    @tabla VARCHAR(20)
AS
BEGIN
    BEGIN TRY
        DECLARE @sqlQuery NVARCHAR(MAX);
			
        SET @sqlQuery = 
            'SELECT * FROM ' + QUOTENAME(@tabla) +
            ' WHERE ' + QUOTENAME('id' + LOWER(@tabla)) + ' = @id';

        EXEC sp_executesql @sqlQuery, N'@id VARCHAR(6)', @id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;


CREATE PROCEDURE ImpresionTodoRegistro
	@tabla varchar(20)
as
begin
	begin try
		declare @sqlQuery nvarchar(max);
		set @sqlQuery = 'select * from ' + QUOTENAME(@tabla);

		exec sp_executesql @sqlQuery;
	end try
	begin catch
		print 'esa tabla no existe'
	end catch;
end;

--pruebas
exec ImpresionTodoRegistro 'colegios'
exec buscarRegistro @id = 'COL1', @tabla = 'colegios'










--colegios#################################################################
exec ImpresionTodoRegistro colegios

--1
CREATE PROCEDURE ObtenerColegiosPorSector
    @sector VARCHAR(50)
AS
BEGIN
    SELECT * FROM Colegios WHERE sectorCole = @sector;
END;

--2
CREATE PROCEDURE ObtenerColegiosPorNombre
    @nombre VARCHAR(50)
AS
BEGIN
    SELECT * FROM Colegios WHERE nombre = @nombre;
END;



--universidad####################################################################
exec ImpresionTodoRegistro universidades

--1
CREATE PROCEDURE ObtenerUniversidadPorSector
    @sector VARCHAR(50)
AS
BEGIN
    SELECT * FROM Universidades WHERE sectorUni = @sector;
END;

--2
CREATE PROCEDURE ObtenerUniversidadPorNombre
    @nombre VARCHAR(50)
AS
BEGIN
    SELECT * FROM Colegios WHERE nombre = @nombre;
END;

--EMPLEADOS############################################################################
EXEC ImpresionTodoRegistrO EMPLEADOS

CREATE PROCEDURE ObtenerEmpleadoPorDepartamento
    @departamento VARCHAR(50)
AS
BEGIN
    SELECT * FROM Empleados WHERE departamento = @departamento;
END;

CREATE PROCEDURE ObtenerCantidadDeEstudiantePorEmpleado
	@id varchar(6)
as
begin
	if not exists (select 1 from Empleados where idempleados = @id and departamento = 'Asesor')
	begin
		print 'no tiene estudiantes a su cargo'
	end
	else
	begin 
	select 
		Empleados.idempleados, 
		estudiantes.nombre,estudiantes.apellido,estudiantes.edad,estudiantes.bachiller,estudiantes.numeroEs,estudiantes.genero,estudiantes.gpa 
	from empleados 
	INNER JOIN estudiantes on Empleados.idempleados = estudiantes.idempleados 
	where Empleados.idempleados = @id;
	end
end;

--estudaintes%$$$$$#^##########################################################################
exec ImpresionTodoRegistro estudiantes
--1
create procedure ObtenerEstudiantesCuadroHonor
	@gpa decimal(3,1)
as
begin
	select * from estudiantes where gpa>4.5
end;
--2
create procedure ObtenerDatosEstudiantesDetallado
	@id varchar(6)
as
begin
	SELECT
    e.idestudiantes,
	e.cedulae,
    e.nombre,
    e.apellido,
    e.edad,
    e.nacimiento,
    e.bachiller,
    e.numeroEs,
    e.genero,
    e.gpa,
    e.sectorEs,
    e.direccionEs,
    e.calleEs,
	e.idcolegios,
    c.nombre AS nombre_colegio,
	e.idempleados,
    em.nombre AS nombre_empleado
FROM
    estudiantes e
 JOIN
    Colegios c ON e.idcolegios = c.idcolegios
 join
	empleados em ON EM.idempleados = E.idempleados
where e.idestudiantes = @id;
end;


--facturacion###############################################################################
exec impresiontodoregistro facturacion
--1
create procedure ObtenerFacturaPorFecha
	@fechaInicio date, 
	@fechaFinal date
as
begin
	select * from facturacion where fecha between @fechaInicio and @fechaFinal;
end

--2
create procedure ObtenerFacturaPorEstudiante
	@id varchar(6)
as
begin
	select*from facturacion where idestudiantes = @id
end

--carreras######################################################################################
exec ImpresionTodoRegistro carreras
--1
create procedure ObtenerCarreraPorDemanda
	@demanda as varchar(50)
as
begin
	if exists (select 1 from carreras where demandaProfecional = @demanda)
	begin 
		select * from carreras where demandaProfecional = @demanda
	end
	else
	begin
		print 'no hay, si cree que es un error revise que es bien escrito| muy alta,media alta,alta,medio,medio bajo,baja,muy baja'
	end
end

--2
create procedure ObtenerCarreraPorNivel
	@nivel varchar(50)
as
begin
		if exists (select 1 from carreras where demandaProfecional = @nivel)
	begin 
		select * from carreras where demandaProfecional = @nivel
	end
	else
	begin
		print 'no hay, si cree que es un error revise que es bien escrito| Tecnico,Licenciatura,Ingenieria'
	end
end

--carrera-uni@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
exec ImpresionTodoRegistro carreras_universidades

--1
-- Procedimiento para buscar carreras por costo
CREATE PROCEDURE ObtenerCarrera_universidadesPorCosto
    @costoMin DECIMAL(10, 2),
    @costoMax DECIMAL(10, 2)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM carreras_universidad WHERE costo BETWEEN @costoMin AND @costoMax)
    BEGIN
        SELECT * FROM carreras_universidad WHERE costo BETWEEN @costoMin AND @costoMax;
    END
    ELSE
    BEGIN
        PRINT 'No hay carreras con ese rango de costo.';
    END
END;

--2
CREATE PROCEDURE ObtenerCarrera_universidadesPorRequisitos
    @notaMin DECIMAL(5, 2),
    @notaMax DECIMAL(5, 2)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM carreras_universidad WHERE requisitos_notas BETWEEN @notaMin AND @notaMax)
    BEGIN
        SELECT * FROM carreras_universidad WHERE requisitos_notas BETWEEN @notaMin AND @notaMax;
    END
    ELSE
    BEGIN
        PRINT 'No hay carreras con ese rango de requisitos de nota.';
    END
END;


--prueba#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

--1
-- Procedimiento para buscar pruebas por puntaje
CREATE PROCEDURE ObtenerPruebaPorPuntaje
    @puntajeMin DECIMAL(5, 2),
    @puntajeMax DECIMAL(5, 2)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Prueba WHERE puntaje BETWEEN @puntajeMin AND @puntajeMax)
    BEGIN
        SELECT * FROM Prueba WHERE puntaje BETWEEN @puntajeMin AND @puntajeMax;
    END
    ELSE
    BEGIN
        PRINT 'No hay pruebas con ese rango de puntaje.';
    END
END;

--2
CREATE PROCEDURE ObtenerPruebaPorArea
    @area VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Prueba WHERE area = @area)
    BEGIN
        SELECT * FROM Prueba WHERE area = @area;
    END
    ELSE
    BEGIN
        PRINT 'No hay pruebas en esa área.';
    END
END;


--patrocinadores######################################################################\

CREATE PROCEDURE ObtenerPatrocinadorPorSector
    @sector VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Patrocinadores WHERE sectorPatro = @sector)
    BEGIN
        SELECT * FROM Patrocinadores WHERE sectorPatro = @sector;
    END
    ELSE
    BEGIN
        PRINT 'No hay patrocinadores en ese sector.';
    END
END;

CREATE PROCEDURE ObtenerPatrocinadorPorNombre
    @nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Patrocinadores WHERE nombre = @nombre)
    BEGIN
        SELECT * FROM Patrocinadores WHERE nombre = @nombre;
    END
    ELSE
    BEGIN
        PRINT 'No hay patrocinadores con ese nombre.';
    END
END;
--tutores#################################################################################
exec ImpresionTodoRegistro tutor

CREATE PROCEDURE ObtenerTutorPorNombre
    @nombre VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Tutor WHERE nombre = @nombre)
    BEGIN
        SELECT * FROM Tutor WHERE nombre = @nombre;
    END
    ELSE
    BEGIN
        PRINT 'No hay tutores con ese nombre.';
    END
END;

CREATE PROCEDURE ObtenerTutorPorApellido
    @apellido VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Tutor WHERE apellido = @apellido)
    BEGIN
        SELECT * FROM Tutor WHERE apellido = @apellido;
    END
    ELSE
    BEGIN
        PRINT 'No hay tutores con ese apellido.';
    END
END;

-- tutoria ##############################################################################'''
--1
CREATE PROCEDURE ObtenerTutoriaPorArea
    @area VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Tutoria WHERE area = @area)
    BEGIN
        SELECT * FROM Tutoria WHERE area = @area;
    END
    ELSE
    BEGIN
        PRINT 'No hay tutorías en esa área.';
    END
END;


--2
CREATE PROCEDURE ObtenerTutoriaPorLlaveCompuesta
    @idtutoria VARCHAR(50),
    @numeroTutoria VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Tutoria WHERE idtutoria = @idtutoria AND numeroTutoria = @numeroTutoria)
    BEGIN
        SELECT * FROM Tutoria WHERE idtutoria = @idtutoria AND numeroTutoria = @numeroTutoria;
    END
    ELSE
    BEGIN
        PRINT 'No hay tutorías con esa llave compuesta.';
    END
END;



