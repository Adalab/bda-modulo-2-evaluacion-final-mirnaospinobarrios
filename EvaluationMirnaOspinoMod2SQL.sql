-- EVALUACION FINAL MODULO 2

/*__________Ejercicio 1 __________*/

-- 1 Selecciona todos los nombres de las películas sin que aparezcan duplicados.
-- Para todos los ejercicios usamos la base de datos sakila y la llamamos con USE. En la tabla film utilizamos el operador DISTINCT para identificar y mostrar valores únicos en una columna.

USE sakila;

SELECT DISTINCT `title`
FROM `film`;

/*__________Ejercicio 2 __________*/

-- 2 Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
-- Primero compruebo que corresponde a la clasificación y luego selecciono la tabla que me han pedido.
	
   SELECT `title`, `rating` FROM `film`
       WHERE `rating` = 'PG-13';
        
-- La siguiente es la query solicitada:
   SELECT `title` FROM `film`
        WHERE `rating` = 'PG-13';
        
/*__________Ejercicio 3 __________*/
-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
-- Buscamos patrones con operadores especiales LIKE %a%	El valor a filtrar contiene la 'a' en cualquier posición.

SELECT `title`, `description` FROM `film`
		WHERE `description` LIKE '%amazing%';
        
/*__________Ejercicio 4 __________*/
        
-- 4  Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
-- Utilizamos la tabla film y su columna length contiene la duración de las peliculas. Con el operador WHERE filtramos los resultados según condiciones específicas en este caso mayor que : >.      
-- query intermedia para verificar:
	SELECT `title`, `length` FROM `film`
		WHERE `length` > '120';
        
-- query definitiva solicitada:	        
	SELECT `title` FROM `film`
		WHERE `length` > '120';
        
 /*__________Ejercicio 5 __________*/ 
 
 -- 5. Recupera los nombres de todos los actores.
 -- En este ejercicio en la tabla actor podemos seleccionar el nombre y apellido, en caso que lo quisieramos en una sola columna utilizaremos CONCAT.

SELECT CONCAT(`first_name`, ' ', `last_name`) AS `NOMBRE` FROM `actor`;

-- La query solicitada:
SELECT `first_name`, `last_name` AS `NOMBRE` FROM `actor`;

 /*__________Ejercicio  6__________*/ 

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.    
-- En la tabla actor utilizamos WHERE, con la condición de igualdad de la columna last_name  al patrón "Gibson"
	
   SELECT `first_name`, `last_name` FROM `actor`
	WHERE `last_name` = 'Gibson';

 /*__________Ejercicio 7__________*/ 
 -- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
    
    
-- 7 Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
-- Al referirse  nombres en plural entiendo que necesitais nombres y apellidos, utilizamos CONCAT para dejarlo en una sola columna.
-- Ulilizamos BETWEEN : Permitirá seleccionar registros dentro de un rango específico de valores especialmente usado para fechas y valores numericos.

SELECT  CONCAT(`first_name`, ' ', `last_name`) AS `NOMBRE` FROM `actor`
	WHERE `actor_id` BETWEEN 10 AND 20;
    
 /*__________Ejercicio 8__________*/ 
 --    
-- 8  Encuentra el título de las películas en la tabla `film` que no sean ni "R" ni "PG-13" en cuanto a su clasificación.Encuentra el título de las películas en la tabla filmque no sean ni "R" ni "PG-13" en cuanto a su clasificación.
-- Utilizamos la tabla film, comprobamos que cumple,
SELECT `title`, `rating`
	FROM `film`
	WHERE `rating` NOT IN ('R', 'PG-13');
-- query definitiva:
SELECT `title`
	FROM `film`
	WHERE `rating` NOT IN ('R', 'PG-13');
    
  /*__________Ejercicio 9 __________*/    
-- 9 Encuentra la cantidad total de películas en cada clasificación de la tabla `film` y muestra la clasificación junto con el recuento.    
-- Utilizamos la sentencia GROUP BY Al utilizar GROUP BY, para agrupar filas en función de valores comunes en la columna rating, para saber la cantidad realizamos el conteo de peliculas con COUNT. 
SELECT `rating` AS CLASIFICACION, COUNT(`film_id`) AS CANTIDAD_TOTAL FROM `film`
	 GROUP BY `rating`;

  /*__________Ejercicio 10 __________*/ REVISAR
  
-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
-- Utilizamos LEFT JOIN combinar las tablas customers y rental y ver el resultado de todos los clientes con y sin alquiler.
-- GROUP BY para agrupar peliculas alquiladas por cliente y el conteo con COUNT de cada alquiler.
 SELECT c.`customer_id` AS id_cliente, c.`first_name` AS nombre, c.`last_name` AS apellido, COUNT(rental.`rental_id`) AS Total_peliculas_alquiladas
		FROM `customer` c
		LEFT JOIN `rental`
		ON c.`customer_id` = rental.`customer_id`
		GROUP BY c.`customer_id`, c.`first_name`, c.`last_name`;
        
  /*__________Ejercicio 11 __________*/ REVISAR
-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

	SELECT name, COUNT(r.rental_id) AS cantidad_alquileres FROM  category AS c
     INNER JOIN film_category AS fc
     on c.category_id = fc.category_id
     INNER JOIN inventory AS i
     on fc.film_id = i.film_id
     INNER JOIN rental AS r
     on i.inventory_id = r.inventory_id
     GROUP BY c.name;
     
	/*__________Ejercicio 12 __________*/
-- 12 Encuentra el promedio de duración de las películas para cada clasificación de la tabla `film` y muestra la clasificación junto con el promedio de duración.
-- Agrupamos por rating y obtenemos el promedio de duración mediante la función agregada AVG.
	
    SELECT `rating`, AVG(`length`) AS promedio_duracion
		FROM  `film`
		GROUP BY `rating`; 
        





     
     
     
     

     
     