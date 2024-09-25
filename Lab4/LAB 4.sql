CREATE DATABASE PAISES_INFO2

USE PAISES_INFO2

--1. Crear un procedimiento que indique e imprima si un número es par o impar

CREATE PROCEDURE PAR_IMPAR

@NUM INT

AS
BEGIN

IF @NUM % 2 = 0
 PRINT 'EL NUMERO '+ CAST (@NUM AS VARCHAR)+ ' ES PAR'

ELSE
 PRINT 'EL NUMERO '+ CAST (@NUM AS VARCHAR)+ ' ES IMPAR'

END

EXEC PAR_IMPAR 10;

/*2. Realizar un procedimiento que proyecte los datos de la tabla país, donde al dar un código de país si se 
encuentra que lo actualice con el que se ingresa, sino que lo inserte como un registro nuevo.*/


--2.1 Crear una BD llamada PAISES_INFO y dentro de ella una tabla llamada PAIS, abajo ejemplo, pero ustedes deben colocar otros datos.
CREATE TABLE PAIS(
	CODIGO VARCHAR (10) PRIMARY KEY,
	NOMBRE VARCHAR (20)
);

INSERT INTO PAIS (CODIGO, NOMBRE)
VALUES
    (1, 'Estados Unidos'),
    (58, 'Venezuela'),
    (52, 'México');

CREATE PROCEDURE INSERTAR_P
	@CODIGO VARCHAR (10),
	@NOMBRE VARCHAR (20)

AS
BEGIN
IF EXISTS (SELECT 1 FROM PAIS WHERE CODIGO = @CODIGO)
BEGIN
UPDATE PAIS SET NOMBRE = @NOMBRE WHERE CODIGO = @CODIGO;
END
ELSE 
BEGIN
INSERT INTO PAIS (CODIGO, NOMBRE) VALUES (@CODIGO,@NOMBRE);
END
END;

SELECT *FROM PAIS

EXEC INSERTAR_P 51,PERU;

/*3. Usando una instrucción select con una estructura CASE, implementar un script sencillo que muestre un 
día de la semana x (en letras), dado un parámetro en número, Ej.: si pongo 1 entonces es ‘Lunes’ y así 
hasta el domingo, si gustan colocar un valor inicial a la variable del día con el valor de 3, adicional que diga 
sino se encuentra entonces no existe un día de la semana para esa opción.*/

DECLARE @NUM_DIA_SEMANA INT = 6;

SELECT CASE @NUM_DIA_SEMANA
	WHEN 1 THEN 'LUNES'
	WHEN 2 THEN 'MARTES'
	WHEN 3 THEN 'MIERCOLES'
	WHEN 4 THEN 'JUEVES'
	WHEN 5 THEN 'VIERNES'
	WHEN 6 THEN 'SABADO'
	WHEN 7 THEN 'DOMINGO'
ELSE 'NO EXISTE'
END AS DIA

/*4. Usando la tabla de Almacén, crear una instrucción select con una estructura CASE, implementar un script 
sencillo que muestre el código del producto, la descripción, el modelo. Y que muestre la respuesta del 
CASE con una columna llamada SIGLAS, donde coloque la primera letra de la descripción, por ejemplo, si 
es Laptop, que ponga L y así con los demás y en de otro modo no está en venta.*/
USE ALMACEN3
SELECT 
 IDPRODUCTO AS CODIGO_PRO,
 DESCRIPCCION AS DESCRIPCCION_PRO,
 MODELO AS MODELO_PRO,

 CASE
	WHEN LEFT(DESCRIPCCION, 1) = 'L' THEN 'L'
	WHEN LEFT(DESCRIPCCION, 1) = 'P' THEN 'P'
	WHEN LEFT(DESCRIPCCION, 1) = 'M' THEN 'M'
	ELSE 'NO ESTÁ EN VENTA'
END AS SIGLAS

FROM PRODUCTO

--5. Ejecutar los siguientes procedimientos almacenados en el sistema y observar los detalles
USE ALMACEN3

EXEC Sp_columns CLIENTE 

EXEC Sp_databases

EXEC Sp_server_info

EXEC Sp_pkeys CLIENTE