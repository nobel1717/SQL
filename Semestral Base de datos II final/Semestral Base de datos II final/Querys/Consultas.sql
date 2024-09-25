use baseII

	/*Consulta 1 
	Mostrar el total de estudiantes por género*/
	SELECT genero, COUNT(*) AS total_estudiantes
	FROM estudiantes
	GROUP BY genero;

	/*Consulta 2
	Calcular el promedio de GPA por bachillerato (redondeando a dos decimales)*/
	SELECT bachiller, CAST(AVG(gpa) AS DECIMAL(10, 2)) AS promedio_gpa
	FROM estudiantes
	GROUP BY bachiller;

	/*consulta 3
	Saber el costo promedio de las carreras por universidad*/
	SELECT U.nombre, CAST(AVG(CU.costo) AS DECIMAL (10,2)) AS costo_promedio
	FROM carreras_universidad CU
	INNER JOIN Universidades U ON CU.iduniversidades = U.iduniversidades
	GROUP BY U.nombre;

	/*Consulta 4
	Saber la cantidad de estudiantes por colegio*/
	SELECT c.nombre, COUNT(e.idestudiantes) AS cantidadDeestudiantes
	FROM colegios c
	LEFT JOIN estudiantes e ON c.idcolegios = e.idcolegios
	GROUP BY c.nombre;


	/*consulta 5
	Calcular el promedio de puntajes de pruebas por área de estudio*/
	SELECT area, AVG(puntaje) AS puntaje_promedio
	FROM Prueba
	GROUP BY area;

	/*consulta 6
	Mostrar las universidades que ofrecen carreras con duración menor a 4 años*/
	SELECT DISTINCT u.nombre, cu.duracion
	FROM Universidades u
	INNER JOIN carreras_universidad cu ON u.iduniversidades = cu.iduniversidades
	WHERE cu.duracion < 4;

	/*consulta 6
	Saber en que area  los estudiantes obtuvieron el puntaje máximo en pruebas*/
	SELECT area, MAX(puntaje) AS puntaje_maximo
	FROM Prueba
	GROUP BY area
	HAVING MAX(puntaje) = (SELECT MAX(puntaje) FROM Prueba);

	/*consulta 7
	Identificar el promedio de GPA por rango de edad de los estudiantes*/
	SELECT CASE
         WHEN edad BETWEEN 18 AND 21 THEN '18-21'
         WHEN edad BETWEEN 22 AND 25 THEN '22-25'
         ELSE '26+'
       END AS rango_edad,
       AVG(gpa) AS promedio_gpa
	FROM estudiantes
	GROUP BY CASE
           WHEN edad BETWEEN 18 AND 21 THEN '18-21'
           WHEN edad BETWEEN 22 AND 25 THEN '22-25'
           ELSE '26+'
         END;


		 /*consulta 8
		 Identificar los estudiantes que no han realizado ninguna prueba*/
		 SELECT idestudiantes, nombre, apellido
		FROM estudiantes
		WHERE idestudiantes NOT IN (SELECT DISTINCT idestudiantes FROM Prueba);

		/*consula 9
		Identificar estudiantes que están en la tabla de facturación o en la tabla de Prueba*/
		SELECT idestudiantes, nombre, apellido
		FROM estudiantes
		WHERE idestudiantes IN (SELECT idestudiantes FROM facturacion)
		UNION
		SELECT idestudiantes, nombre, apellido
		FROM estudiantes
		WHERE idestudiantes IN (SELECT idestudiantes FROM Prueba);

		/*consulta 10
		 mostrars bachilleratos con un promedio superior a 4.0*/
		SELECT bachiller, AVG(gpa) AS promedio_gpa
		FROM estudiantes
		GROUP BY bachiller
		HAVING AVG(gpa) > 4.0;

		/*consulta 11
		Calcular el total de facturación por modo de pago y determinar cuántos estudiantes utilizaron cada modo de pago*/
		SELECT modo_pago, COUNT(idestudiantes) AS cantidad_estudiantes, SUM(total) AS total_facturacion
		FROM facturacion
		GROUP BY modo_pago
		HAVING COUNT(idestudiantes) > 1
		ORDER BY total_facturacion DESC;

		/*consulta 12
		Listar los colegios con su respectiva dirección ordenados alfabéticamente por nombre de colegio*/
		SELECT nombre, direccionCole
		FROM Colegios
		ORDER BY nombre;


		/*consulta 13
		Obtener los nombres y áreas de las pruebas realizadas por los estudiantes*/
		SELECT idestudiantes, area
        FROM Prueba;

		/*consulta 14
		Mostrar los nombres y sitios web de las universidades que están ubicadas en la Ciudad de Panamá*/
		SELECT nombre, sitioWeb
		FROM Universidades
		WHERE direccionUni LIKE '%Ciudad de Panama%';

		/*consulta 15
		Encontrar los nombres y saldos de facturación de los estudiantes que hayan pagado más de $200 en total*/
		SELECT estudiantes.nombre, facturacion.saldo
		FROM facturacion
		JOIN estudiantes ON facturacion.idestudiantes = estudiantes.idestudiantes
		GROUP BY estudiantes.nombre, facturacion.saldo
		HAVING SUM(facturacion.total) > 200;

		/*consulta 16
		Encontrar la cantidad de pruebas realizadas por área y su promedio de puntaje*/
		SELECT area, COUNT(*) AS cantidad_pruebas, AVG(puntaje) AS promedio_puntaje
		FROM Prueba
		GROUP BY area;

		/*consulta 17
		Mostrar el nombre, la dirección y el número de teléfono de los patrocinadores que se encuentrene en la Ciudad de Panamá*/
		SELECT nombre, CONCAT(direccionPatro, ', ', callePatro) AS direccion_completa, numeroPatro
		FROM Patrocinadores
		WHERE direccionPatro = 'Ciudad de Panama';

		/*consulta 18
		Encontrar el nombre y el área de las tutorías ofrecidas a cada estudiante*/
		SELECT e.nombre, t.area
		FROM estudiantes e
		JOIN Tutoria t ON e.idestudiantes = t.idestudiantes;

		/*consulta 19
		Calcular el total de facturación por mes y año*/
		SELECT YEAR(fecha) AS year, MONTH(fecha) AS month, SUM(total) AS total_facturacion
		FROM facturacion
		GROUP BY YEAR(fecha), MONTH(fecha)
		ORDER BY year, month;

		/*consulta 20
		Encontrar el nombre y apellido de los tutores que tienen al menos una tutoría en el área de Ciencias*/
		SELECT DISTINCT t.nombre, t.apellido, tu.area AS area_de_tutoria
		FROM Tutor t
		JOIN Tutoria tu ON t.idtutor = tu.idtutor
		WHERE tu.area = 'Ciencias';
















