--Lab3 parte 2

--1
SELECT NOMBRE,APELLIDO,IDVENDEDOR,CATEGORIA FROM VENDEDOR 
GROUP BY CATEGORIA,NOMBRE,APELLIDO,IDVENDEDOR 
HAVING CATEGORIA = 'A-3'

--2
SELECT DESCRIPCCI�N,PRECIO FROM PRODUCTO GROUP BY DESCRIPCCI�N,PRECIO HAVING PRECIO >= 579

--3
SELECT DESCRIPCCI�N, SUM(PRECIO) AS [TOTAL PRECIO] FROM PRODUCTO GROUP BY DESCRIPCCI�N HAVING DESCRIPCCI�N IN ('LAPTOP','PANEL') 
Select * FROM VENDEDOR


--PARTE 3

--1
CREATE PROCEDURE SALUDO
AS
BEGIN
PRINT 'Hola Mundo'
END

execute SALUDO

--2
select * from PRODUCTO
CREATE PROCEDURE BUSCAR
    @NombreMarca VARCHAR(30) = 'DELL'
AS
BEGIN
    SELECT MARCA, DESCRIPCCI�N, PRECIO
    FROM PRODUCTO AS P
    WHERE MARCA = @NombreMarca;
END;
EXEC BUSCAR;

--3
CREATE PROCEDURE SumarDosNumeros
    @Numero1 INT = 5,
    @Numero2 INT = 7
AS
BEGIN

    DECLARE @Resultado INT;
    SET @Resultado = @Numero1 + @Numero2;
    PRINT 'El resultado de la suma es: ' + CAST(@Resultado AS VARCHAR);
END;

EXEC SumarDosNumeros

--4
CREATE PROCEDURE DIVIDIR
    @Dividendo DECIMAL(18, 2) = 10,
    @Divisor DECIMAL(18, 2) = 2
AS
BEGIN
    IF @Divisor = 0
    BEGIN
        PRINT('El divisor no puede ser igual a cero.');
        RETURN;
    END
    DECLARE @Resultado DECIMAL(18, 2);
    SET @Resultado = @Dividendo / @Divisor;
    PRINT 'El resultado de la divisi�n es: ' + CAST(@Resultado AS VARCHAR);
END;

EXEC DIVIDIR