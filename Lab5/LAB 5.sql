CREATE DATABASE LAB_5
USE LAB_5



/*1. Se procede a crear el procedimiento almacenado con el nombre de Calculador, este va a recibir 
un parámetro de entrada y tiene otro de salida que es el que queremos usar. Fíjense que 
el parámetro @monto captura el valor de SUM(monto).*/

CREATE PROCEDURE dbo.Calculador
	@id int,
	@monto float OUTPUT
	AS
	BEGIN
		SELECT	@monto=SUM(monto) FROM Sumas WHERE id=@id
	END

/*1. Declaramos una variable escalar de tipo float, ejecutamos el Store Procedure con la palabra 
EXEC, le pasamos el parámetro de entrada y observe que el parámetro de salida monto que 
declaramos en el Store Procedure anteriormente va a ser igual a la variable escalar suma que 
acabamos de declarar y esta será de tipo OUTPUT. Lo que pasa en esta situación es que 
el parámetro de salida del Store Procedure devuelve el resultado de SUM(monto), entonces 
este valor tiene que ser capturado por una variable, esta variable es @suma. Luego usamos 
un PRINT y listo.*/

DECLARE @suma float
EXEC dbo.Calculador 1,@monto=@suma OUTPUT
PRINT 'El monto total de este cliente es:…'

/*2. Crear un procedimiento almacenado al cual le enviamos 2 números decimales y retorna el promedio, 
recuerde declarar el resultado como variable output:*/

CREATE PROCEDURE PROMEDIO
	@NUM1 DECIMAL(10,2),
	@NUM2 DECIMAL(10,2),
	@PROMEDIO DECIMAL (10,2) OUTPUT

	AS 
	BEGIN 
		SET @PROMEDIO = (@Num1 + @Num2) / 2;
		PRINT CAST(@PROMEDIO AS VARCHAR)
	END


EXEC PROMEDIO 20.5 ,20.5


/*2. Crear un procedimiento que imprima los números impares que se encuentran del 1 al 10, usar el ciclo 
While para esto o solo crear el script del ciclo, como Ud. Considere mejor*/

CREATE PROCEDURE IMPRIMIR_NUMEROS_IMPARES
	AS 
	BEGIN
	DECLARE @NUMERO INT =1

	WHILE @NUMERO <=10
		BEGIN
			IF @NUMERO % 2 = 1
				begin
					PRINT CAST(@NUMERO AS VARCHAR(5))
				END
			SET @NUMERO = @NUMERO + 1
		END
	END

EXEC IMPRIMIR_NUMEROS_IMPARES


--3. Realizar un script sencillo mediante el ciclo while que imprima Hola 15 veces.


DECLARE @CONT INT =0
	WHILE @CONT <15
		BEGIN
			SET @CONT = @CONT + 1
			PRINT CAST(@CONT AS VARCHAR)+ '  HOLA'
	END

/*4. Usando las tablas de Almacén, realizar un script (no procedimiento), que mientras el promedio de los 
precios de los productos sea menor que $2000.00 permita aumentar dichos precios en 10%, hacer esta 
actualización solo hasta que algún precio de producto supere el monto de $5000.00, si pasa entonces 
que interrumpa el ciclo, cuando se termine de actualizar dichos valores mostrar el mensaje “ Ya no hay 
más precios que actualizar”*/

USE ALMACEN3

WHILE (SELECT AVG(PRECIO) FROM PRODUCTO) < 2000

	BEGIN
	UPDATE PRODUCTO
	SET PRECIO = PRECIO * 1.10

	IF(SELECT MAX(PRECIO) FROM PRODUCTO) > 5000
		BEGIN
			PRINT 'SE SUPERO EL LIMITE DE 5000'
			BREAK 
		END
	END

	PRINT 'YA NO HAY MÁS PRECIOS QUE ACTUALIZAR'

	DECLARE @NUM1 DECIMAL(10,2) = 2.5;
	DECLARE @NUM2 DECIMAL(10,2) = 2.5;
	DECLARE @RESULT DECIMAL(10,2) ;

	SET @RESULT = (@NUM1 + @NUM2)/2;

	PRINT 'EL PROMEDIO ES: ' + CAST(@RESULT AS VARCHAR);

--5. Ejecutar lo siguiente y segir las indicaciones:
-- Trabajamos con la tabla "libros de una librería.

--6.1 Manera de eliminar una tabla si existe y luego crarla nuevamente

if object_id('libros') is not null
 drop table libros;

--6.2 Crear la tabla

create table libros(
 codigo int identity,
 titulo varchar(40),
 autor varchar(30),
 editorial varchar(20),
 precio decimal(5,2),
 primary key(codigo) 
);

--6.3 Ingrese algunos registros:

insert into libros values ('Uno','Richard Bach','Planeta',15);
insert into libros values ('Ilusiones','Richard Bach','Planeta',12);
insert into libros values ('El aleph','Borges','Emece',25);
insert into libros values ('Aprenda PHP','Mario Molina','Nuevo siglo',50);
insert into libros values ('Matematica estas ahi','Paenza','Nuevo siglo',18);
insert into libros values ('Puente al infinito','Richard Bach','Sudamericana',14);
insert into libros values ('Antología','J. L. Borges','Paidos',24);
insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
insert into libros values ('Antología','Borges','Planeta',34);

--6.4 Eliminamos la tabla "ofertas" si existe y la creamos con los mismos campos de la tabla "libros":

 create table OFERTAS(
 codigo int identity,
 titulo varchar(40),
 autor varchar(30),
 editorial varchar(20),
 precio decimal(5,2),
 primary key(codigo) 
);

--6.5 Crear un procedimiento llamado sp_promo para que seleccione el título, autor, editorial y los libros cuyo precio no superan los 30 dólares

CREATE PROCEDURE SP_PROMO

	AS
	BEGIN
		SELECT titulo, autor, editorial, precio FROM libros WHERE precio <=30.00
    END

EXEC SP_PROMO

--6.6 Ingresar en la tabla "ofertas" el resultado devuelto por el procedimiento almacenado "sp_promo"

INSERT INTO OFERTAS(titulo, autor, editorial, precio)

EXEC SP_PROMO;

--6.7 Visualicen el contenido de la tabla ofertas

SELECT *FROM OFERTAS
