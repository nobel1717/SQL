-- Vistas
use baseII
-- Tabla Colegios
create view vista_colegios as
select idcolegios, nombre, sectorCole, direccionCole, calleCole, numeroCole
from Colegios;

select * from vista_colegios;

-- Tabla Universidades 
create view vista_universidades as 
select iduniversidades, nombre, sitioWeb, sectorUni, direccionUni, calleUni, numeroUni
from Universidades;

select * from vista_universidades;

-- Tabla Empleados
create view vista_empleados as 
select idempleados, nombre, apellido, cedula, departamento, edad, numeroEm, sectorEm, direccionEm, calleEm
from Empleados;

select * from vista_empleados;

-- Tabla Estudiantes
create view vista_estudiantes as
select idestudiantes, cedulae, nombre, apellido, edad, nacimiento, bachiller, numeroEs, genero, gpa, sectorEs, direccionEs, calleEs, idcolegios
from estudiantes;

select * from vista_estudiantes;

-- Tabla Facturación 
create view vista_facturacion as
select idfacturacion, saldo, descuento, total, fecha, modo_pago, idestudiantes
from facturacion;

select * from vista_facturacion;

-- Tabla Carreras
create view vista_carreras as 
select idcarreras, nombre_carrera, facultad, descripcion, nivelAcademico, demandaProfecional
from carreras;

select * from vista_carreras;

-- Tabla Carreras Universidades
create view vista_carreras_uni as
select idcarreras_universidad, iduniversidades, idcarreras, estado, duracion, requisitos_notas, costo
from carreras_universidad;

select * from vista_carreras_uni;

-- Tabla Prueba
create view vista_prueba as 
select idprueba, idestudiantes, area, fecha, puntaje, idempleados
from Prueba;

select * from vista_prueba;

-- Tabla Patrocinadores
create view vista_patrocinadores as
select idpatrocinadores, ruc, nombre, sectorPatro, direccionPatro, callePatro, numeroPatro, correoPatro
from Patrocinadores;

select * from Patrocinadores;

-- Tabla Tutor
create view vista_tutor as 
select idtutor, nombre, apellido, cedulaTutor, numeroTutor, correoTutor,idpatrocinador
from Tutor;

select * from vista_tutor;

-- Tabla Tutoria
create view vista_tutoria as 
select idtutoria, numeroTutoria, idestudiantes, idtutor, area, descripcion
from Tutoria;

select * from vista_tutoria;