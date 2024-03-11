-- EVALUACION FINAL MODULO 2

/*__________Ejercicio 1 __________*/

-- Selecciona todos los nombres de las películas sin que aparezcan duplicados.

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
        
SELECT title, description FROM film
		WHERE description LIKE '%amazing%';
        
-- 3 Encuentra el título y la descripción de todas las películas que contienen la palabra "amazing" en su descripción.
	
    SELECT `title`, `description` FROM `film`
		WHERE `description` LIKE '%amazing%';
        
-- 4 Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
	SELECT title, length FROM film
		WHERE length > '120';
	        
     SELECT title FROM film
		WHERE length > '120';
		        
-- 5 Recupera los nombres de todos los actores.
	SELECT CONCAT(first_name, ' ', last_name) AS NOMBRE FROM actor;
    
-- 6 Encuentra el nombre y apellido de los actores que tienen "Gibson" en su apellido.
	
   SELECT first_name AS NOMBRE, last_name AS  APELLIDO FROM actor
	WHERE last_name = 'Gibson';
    
-- 7 Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT actor_id, CONCAT(first_name, ' ', last_name) AS NOMBRE FROM actor
	WHERE actor_id BETWEEN 10 AND 20;
SELECT  CONCAT(first_name, ' ', last_name) AS NOMBRE FROM actor
	WHERE actor_id BETWEEN 10 AND 20;
-- 8 Encuentra el título de las películas en la tabla filmque no sean ni "R" ni "PG-13" en cuanto a su clasificación.
SELECT title, rating
	FROM film
	WHERE rating NOT IN ('R', 'PG-13');

SELECT title
	FROM film
	WHERE rating NOT IN ('R', 'PG-13');
-- 9 Encuentra la cantidad total de películas en cada clasificación de la tabla filmy muestra la clasificación junto con el recuento.
SELECT rating AS CLASIFICACION, COUNT(film_id) AS CANTIDAD_TOTAL FROM film
	 GROUP BY rating;

-- 10 Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.     
 
     
     SELECT c.customer_id AS id_cliente , c.first_name AS nombre, c.last_name AS apellido, COUNT(rental.rental_id) as Total_peliculas_alquiladas
			FROM customer c
			INNER JOIN rental
            ON c.customer_id = rental.customer_id
			GROUP BY c.customer_id, c.first_name, c.last_name;
     
 -- 11  Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.    
    
	SELECT name, COUNT(r.rental_id) AS cantidad_alquileres FROM  category AS c
     INNER JOIN film_category AS fc
     on c.category_id = fc.category_id
     INNER JOIN inventory AS i
     on fc.film_id = i.film_id
     INNER JOIN rental AS r
     on i.inventory_id = r.inventory_id
     GROUP BY c.name;
-- 12 Encuentra el promedio de duración de las películas para cada clasificación de la tabla filmy muestra la clasificación junto con el promedio de duración.	-- 
     SELECT 
		rating, AVG(length) AS promedio_duracion
		FROM film
		GROUP BY rating;
        
-- 13 Encuentra el nombre y apellido de los actores que aparecen en la película con título "Indian Love".

SELECT first_name, last_name FROM actor AS a
		INNER JOIN film_actor AS fa
        ON a.actor_id = fa.actor_id
        INNER JOIN film AS f
        ON fa.film_id = f.film_id
        WHERE f.title = "Indian Love";
        
-- 14 Muestra el título de todas las películas que contienen la palabra "perro" o "gato" en su descripción.
SELECT title
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

-- 15 Hay algún actor o actriz que no aparece en ninguna película en la tabla film_actor.
SELECT actor.actor_id, actor.first_name, actor.last_name
FROM actor
right JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.actor_id IS NULL;
-- esta alternativa puede srr too
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id NOT IN (SELECT actor_id FROM film_actor);
-- 16 Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010. 

SELECT title
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

-- 17 Encuentra el título de todas las películas que son de la misma categoría que "Familia".

SELECT title, name
FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c
ON fc.category_id = c.category_id
WHERE c.name = 'Family';

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
SELECT   actor.first_name, actor.last_name
		FROM  actor
		JOIN film_actor ON actor.actor_id = film_actor.actor_id
		GROUP BY actor.actor_id, actor.first_name, actor.last_name
		HAVING COUNT(film_actor.film_id) > 10;
-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
		SELECT title
		FROM film
		WHERE rating = 'R' AND length > 120;
        
-- 20 Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT  c.name AS nombre_categoria, AVG(f.length) AS promedio_duracion
		FROM  category AS c
		JOIN  film_category AS fc 
        ON c.category_id = fc.category_id
		JOIN film AS f ON fc.film_id = f.film_id
		GROUP BY  c.category_id, c.name
		HAVING  AVG(f.length) > 120;
-- 21 Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.

SELECT  a.first_name, a.last_name, COUNT(fa.film_id) AS cantidad_peliculas
		FROM  actor AS a
		JOIN  film_actor AS fa
        ON a.actor_id = fa.actor_id
		GROUP BY  a.actor_id, a.first_name, a.last_name
		HAVING  COUNT(fa.film_id) >= 5;
-- *** PENDIENT
-- 22 Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rent_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
SELECT title
	FROM film
	WHERE film.film_id IN (
    SELECT r.film_id
    FROM rental AS r
    WHERE DATEDIFF(r.return_date, r.rental_date) > 5);
    
-- 23 

-- ACTORES CATEGORIA HORROR
SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Horror'
GROUP BY actor.actor_id
ORDER BY actor.last_name, actor.first_name;

-- 




     
     
     
     

     
     