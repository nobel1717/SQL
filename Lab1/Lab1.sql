--Lab1
use BANCO5

--1
Select getdate() as 'Hora exacta';

--2
Select datepart(month,getdate()); 

--3
Select DATEPART(DAY,GETDATE());

--4
Select datename(month,getdate()); 

--5
Select DATENAME(DAY,GETDATE());

--6
Select day(getdate());

--7
Select month(getdate());

--8
SELECT NOMBRE,FECHA_NAC FROM CLIENTE WHERE MONTH(FECHA_NAC) = (2) or  MONTH(FECHA_NAC) = 7 or  MONTH(FECHA_NAC) = 11;

--9
Select year(getdate());

--10
SELECT * FROM PRESTAMO WHERE YEAR(FECHA) = 2012

--11
SELECT 9.5 AS Original, CONVERT(int, 9.5) AS int

--12
Select Convert(Int, Convert(Varchar(25), getdate(), 112))

--13 
SELECT CONVERT(VARCHAR,RIGHT(IDCLIENTE,4),4) from CLIENTE

--14
SELECT ROUND(AVG(MONTO),3) AS 'PROMEDIO DE MONTO' FROM PRESTAMO 

--15
SELECT COUNT(IDSUCURSAL) FROM SUCURSAL

--16
SELECT MIN(SALDO) AS 'ElMin' FROM CUENTA

--17
SELECT MAX(MONTO) AS 'ElMax' FROM PRESTAMO WHERE NOMBRE = 'Jorge'


Select * from PRESTAMO
Select * From CUENTA