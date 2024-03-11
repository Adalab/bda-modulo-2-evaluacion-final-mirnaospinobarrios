-- EVALUACION FINAL MODULO 2

/*__________Ejercicio 1 __________*/

-- 1 Selecciona todos los nombres de las películas sin que aparezcan duplicados.
-- Para todos los ejercicios usamos la base de datos sakila y la llamamos con USE. En la tabla film utilizamos el operador DISTINCT para identificar y mostrar valores únicos en una columna.

USE sakila;

SELECT DISTINCT `title`
	FROM `film`;

/*__________Ejercicio 2 __________*/

-- 2 Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
-- Primero comprobamos que corresponde a la clasificación y luego seleccionamos la tabla que nos han pedido.
	
SELECT `title`, `rating`
	FROM `film`
	WHERE `rating` = 'PG-13';
        
-- La siguiente es la query solicitada:
SELECT `title`
	FROM `film`
	WHERE `rating` = 'PG-13';
        
/*__________Ejercicio 3 __________*/
-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
-- Buscamos patrones con operadores especiales LIKE %a%	El valor a filtrar contiene la 'a' en cualquier posición.

SELECT `title`, `description`
	FROM `film`
	WHERE `description` LIKE '%amazing%';
        
/*__________Ejercicio 4 __________*/
        
-- 4  Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
-- Utilizamos la tabla film y su columna length contiene la duración de las peliculas. Con el operador WHERE filtramos los resultados según condiciones específicas en este caso mayor que : >.      
-- query intermedia para verificar:

SELECT `title`, `length`
	FROM `film`
	WHERE `length` > '120';
        
-- query definitiva solicitada:	        
SELECT `title`
	FROM `film`
	WHERE `length` > '120';
        
 /*__________Ejercicio 5 __________*/ 
 
 -- 5. Recupera los nombres de todos los actores.
 -- En este ejercicio en la tabla actor podemos seleccionar el nombre y apellido, en caso que lo quisieramos en una sola columna utilizaremos CONCAT.

SELECT CONCAT(`first_name`, ' ', `last_name`) AS `NOMBRE`
	FROM `actor`;

-- La query solicitada:
SELECT `first_name`, `last_name` AS `NOMBRE`
	FROM `actor`;

 /*__________Ejercicio  6__________*/ 

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.    
-- En la tabla actor utilizamos WHERE, con la condición de igualdad de la columna last_name  y el  patrón "Gibson"
	
SELECT `first_name`, `last_name`
	FROM `actor`
	WHERE `last_name` = 'Gibson';

 /*__________Ejercicio 7__________*/ 
   
-- 7 Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
-- Al referirse  nombres en plural entendemos que necesitais nombres y apellidos, utilizamos CONCAT para dejarlo en una sola columna.
-- Ulilizamos BETWEEN : Permitirá seleccionar registros dentro de un rango específico de valores especialmente usado para fechas y valores numericos.

SELECT  CONCAT(`first_name`, ' ', `last_name`) AS `NOMBRE`
	FROM `actor`
	WHERE `actor_id` BETWEEN 10 AND 20;
    
 /*__________Ejercicio 8__________*/ 
   
-- 8  Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
-- Utilizamos WHERE Y NOT IN para excluir los films con clasificación "R" y "PG-13"
-- Podemos  comprobamor el resultado visualizando la columna rating,
SELECT `title`, `rating`
	FROM `film`
	WHERE `rating` NOT IN ('R', 'PG-13');
    
-- query definitiva:
SELECT `title`
	FROM `film`
	WHERE `rating` NOT IN ('R', 'PG-13');
    
  /*__________Ejercicio 9 __________*/  
  
-- 9 Encuentra la cantidad total de películas en cada clasificación de la tabla `film` y muestra la clasificación junto con el recuento.    
-- Utilizamos la sentencia GROUP BY Al utilizar GROUP BY, para agrupar filas en función de valores comunes en la columna rating, para saber la cantidad
-- realizamos el conteo de peliculas con COUNT. 

SELECT `rating` AS CLASIFICACION, COUNT(`film_id`) AS CANTIDAD_TOTAL
	FROM `film`
	GROUP BY `rating`;

  /*__________Ejercicio 10 __________*/ 
  
-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
-- Utilizamos LEFT JOIN combinar las tablas customers y rental y ver el resultado de todos los clientes con y sin alquiler.
-- GROUP BY para agrupar peliculas alquiladas por cliente y el conteo con COUNT de cada alquiler.
-- Compruebo el contador de peliculas
 SELECT COUNT(inventory_id), COUNT(rental_id)
	FROM rental;

-- query definitiva:
 SELECT c.`customer_id` AS id_cliente, c.`first_name` AS nombre, c.`last_name` AS apellido, COUNT(r.`rental_id`) AS Total_peliculas_alquiladas
	FROM `customer` AS c
	LEFT JOIN `rental` AS r
	ON c.`customer_id` = r.`customer_id`
	GROUP BY c.`customer_id`, c.`first_name`, c.`last_name`;
   
        
  /*__________Ejercicio 11 __________*/ 
-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
-- Renombramos las tablas category, film_category, inventory, rental como, c,fc,i,r necesitamos unir estas tablas a través de INNER JOIN, para poder 
-- obtener de la tabla category la columna name y de la tabla rental rental_id, hecha esta unión agrupamos por el nombre de la categoría(name) y obtenemos
-- la cantidad realizando el conteo de rental_id o inventory_id de la tabla rental.
-- realizo esta consula para ver "solo" las peliculas que han sido alquiladas por categoria
SELECT `name`, COUNT(`r`.`rental_id`) AS cantidad_alquileres
	FROM  `category` AS `c`
	INNER JOIN `film_category` AS `fc`
	ON `c`.`category_id` = `fc`.`category_id`
	INNER JOIN `inventory` AS `i`
	ON `fc`.`film_id` = `i`.`film_id`
	INNER JOIN `rental` AS `r`
	ON `i`.`inventory_id` = `r`.`inventory_id`
	GROUP BY `c`.`name`;
    
-- query definitiva: En este caso tenemos el mismo resultado con el INNER Y CON LEFT, porque se han alquilado en todas las categorias, sin embargo
-- con left podriamos ver tambien las categorias de las peliculas que no se han alquilado en caso que se incorporen nuevas peliculas en principio sin alquilar.
    
SELECT `name`, COUNT(`r`.`rental_id`) AS cantidad_alquileres
	FROM  `category` AS `c`
	left JOIN `film_category` AS `fc`
	ON `c`.`category_id` = `fc`.`category_id`
	LEFT JOIN `inventory` AS `i`
	ON `fc`.`film_id` = `i`.`film_id`
	LEFT JOIN `rental` AS `r`
	ON `i`.`inventory_id` = `r`.`inventory_id`
	GROUP BY `c`.`name`;
   
	/*__________Ejercicio 12 __________*/
-- 12 Encuentra el promedio de duración de las películas para cada clasificación de la tabla `film` y muestra la clasificación junto con el promedio de duración.
-- Agrupamos por rating y obtenemos el promedio de duración mediante la función agregada AVG.
	
SELECT `rating`, AVG(`length`) AS promedio_duracion
	FROM  `film`
	GROUP BY `rating`; 
        
	/*__________Ejercicio 13 __________*/
    
-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
-- Utilizamos INNER JOIN para juntar las tablas actor con film_actor mediante la columna actor_id, luego juntamos  la tabla
--  film  con la tabla film_actor mediante la columna film_id, con los datos de  film podemos preguntar por el title que sea igual 
-- al patron 'Indian Love'.(Renombramos las tablas para poder visualizar de mejor manera: actor:a, film_actor:fa, film:f)

SELECT `first_name`, `last_name`
	FROM `actor` AS `a`
	INNER JOIN `film_actor` AS `fa`
    ON `a`.`actor_id` = `fa`.`actor_id`
	INNER JOIN `film` AS `f`
    ON `fa`.`film_id` = `f`.`film_id`
	WHERE `f`.`title` = 'Indian Love';
	
    	/*__________Ejercicio 14 __________*/
-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
-- Como en ejercicio 3 buscamos patrones %a%	El valor a filtrar contiene la 'a' en cualquier posición. La siguiente 

-- query solicitada
SELECT `title`
	FROM `film`
	WHERE `description` LIKE '%dog%' OR `description` LIKE '%cat%';
    
-- -- esta es una query de comprobación.
SELECT `description`
	FROM `FILM`
	WHERE `title` = "ALAMO VIDEOTAPE";
    
        	/*__________Ejercicio 15 __________*/ por revisar
-- 15 Hay algún actor o actriz que no apareca en ninguna película en la tabla `film_actor`. 
-- Con esta query al realizar un left se incluyen los actores de la tabla actores, si no exisen en la tabla film_actor el resultado seria NULL lo que permite hacer la pregunta con WHERE.

-- L a query solicitada :

SELECT `actor`.`actor_id`, `actor`.`first_name`, `actor`.`last_name`
	FROM `actor`
	LEFT JOIN `film_actor` ON `actor`.`actor_id` = `film_actor`.`actor_id`
	WHERE `film_actor`.`actor_id` IS NULL;

-- Otra query para llegar al mismo resultado sería:

SELECT `actor_id`, `first_name`, `last_name`
	FROM `actor`
	WHERE `actor_id` NOT IN (SELECT `actor_id` FROM `film_actor`);

        	/*__________Ejercicio 16 __________*/ 
-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
--  De la tabla film buscamos la columna del año de lanzamiento release_year y utilizamos BETWEEN para estableceer el rango. 

SELECT `title`
	FROM `film`
	WHERE `release_year` BETWEEN 2005 AND 2010;
    
            	/*__________Ejercicio 17 __________*/ 

-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family". juntamos las tablas film,film_category,category
-- con sus respectivos alias f, fc,c y asi llegamos a la columna name de la tabla category para igualar al patrón 'Family'.
-- La siguiente es una query de comprobación:
SELECT f.`title`, c.`name`
	FROM `film` AS f
	INNER JOIN `film_category` AS fc
	ON f.`film_id` = fc.`film_id`
	INNER JOIN `category` AS c
	ON fc.`category_id` = c.`category_id`
	WHERE c.`name` = 'Family';
    
-- query definitiva:
            
SELECT f.`title`
	FROM `film` AS f
	INNER JOIN `film_category` AS fc
	ON f.`film_id` = fc.`film_id`
	INNER JOIN `category` AS c
	ON fc.`category_id` = c.`category_id`
	WHERE c.`name` = 'Family';

        	/*__________Ejercicio 18 __________*/ 
-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas. 
-- Juntamos la tabla actor con film_actor, agrupamos con GROUP BY actor.actor_id  utilizamos HAVING para filtrar y no WHERE que solo permite filtrar filas individuales
-- la query solicitada sería la siguiente:

SELECT  `actor`.`first_name`, `actor`.`last_name`
	FROM  `actor`
	INNER JOIN `film_actor`
    ON `actor`.`actor_id` = `film_actor`.`actor_id`
	GROUP BY `actor`.`actor_id`, `actor`.`first_name`, `actor`.`last_name`
	HAVING COUNT(`film_actor`.`film_id`) > 10;
        
                	/*__________Ejercicio 19__________*/ 

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
-- utilizando la tabla film establecemos dos condiciones con WHERE .. AND en las columnas rating y length
  
SELECT `title`
	FROM `film`
	WHERE `rating` = 'R' AND `length` > 120;
    
                    	/*__________Ejercicio 20__________*/
                        
-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría
-- junto con el promedio de duración.
--  Utilizamos las tablas category, film_category, film, con sus respectivos alias c,fc,f, agrupamos por las columnas category_id y name y utilizamos
--   having para establecer  la condición del promedio de la duración que podemos obtenerlo de la columna length que ya esta asociada a esta consulta 
--  por la unión realizada con la tabla film
 
SELECT  c.`name` AS nombre_categoria, AVG(f.`length`) AS promedio_duracion
	FROM  `category` AS c
	INNER JOIN  `film_category` AS fc 
	ON c.`category_id` = fc.`category_id`
	INNER JOIN `film` AS f ON fc.`film_id` = f.`film_id`
	GROUP BY  c.`category_id`, c.`name`
	HAVING  AVG(f.`length`) > 120; 
    
                        	/*__________Ejercicio 21__________*/
                            
-- 21 Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.
--  Utilizamos las tablas actor y film_actor definidas como a y fa respectivamente, las unimos mediante INNER JOIN para poder realizar la consulta del nombre que obtenemos
-- de la tabla actor y el contador COUNT de peliculas que ademas permite filtrar la condición > 5 utilizando HAVING.

SELECT `a`.`first_name`, `a`.`last_name`, COUNT(`fa`.`film_id`) AS cantidad_peliculas
	FROM `actor` AS `a`
	INNER JOIN `film_actor` AS `fa` ON `a`.`actor_id` = `fa`.`actor_id`
	GROUP BY `a`.`actor_id`, `a`.`first_name`, `a`.`last_name`
	HAVING COUNT(`fa`.`film_id`) >= 5;

                        	/*__________Ejercicio 22__________*/
-- 22 Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rent_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
-- Primero encontramos las peliculas que cumplen con la condición, para ello utilizamos La función DATEDIFF en SQL se utiliza para calcular la diferencia entre dos fechas en términos de un intervalo de tiempo específico, como días, meses, años.
-- En esta misma consula unimos con INNER JOIN las tablas inventory y  rental para poder obtener la columna film_id 
SELECT `i`.`film_id`
    FROM `inventory` AS `i`
    INNER JOIN `rental` AS `r`
    ON `i`.`inventory_id` = `r`.`inventory_id`
    WHERE DATEDIFF(`r`.`return_date`, `r`.`rental_date`) > 5;
 
 -- La query definitiva seria la siguiente donde seleccionariamos los titulos que cumplan con la query anterior:
SELECT `title`
FROM `film`
WHERE `film_id` IN (
    SELECT `i`.`film_id`
    FROM `inventory` AS `i`
    INNER JOIN `rental` AS `r`
    ON `i`.`inventory_id` = `r`.`inventory_id`
    WHERE DATEDIFF(`r`.`return_date`, `r`.`rental_date`) > 5);
    
-- 23 Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta
--  para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.

-- Primero realizaremos una query para determinar la lista de actores que si han actuado en la categoria Horror:

SELECT `actor`.`first_name`, `actor`.`last_name`
	FROM `actor`
	INNER JOIN `film_actor` ON `actor`.`actor_id` = `film_actor`.`actor_id`
	INNER JOIN `film` ON `film_actor`.`film_id` = `film`.`film_id`
	INNER JOIN `film_category` ON `film`.`film_id` = `film_category`.`film_id`
	INNER JOIN `category` ON `film_category`.`category_id` = `category`.`category_id`
	WHERE `category`.`name` = 'Horror'
	GROUP BY `actor`.`actor_id`
	ORDER BY `actor`.`last_name`, `actor`.`first_name`;

-- En la siguiene query buscamos los actores que no han actuado en la categoría horror utilizando la anterior consulta. Para evitar duplicidad le damos otro nombre a actor en la subconsulta:   

SELECT `a`.`first_name`, `a`.`last_name`
FROM `actor` AS `a`
WHERE `a`.`actor_id` NOT IN (
    SELECT `a1`.`actor_id`
    FROM `actor` AS `a1`
    INNER JOIN `film_actor` ON `a1`.`actor_id` = `film_actor`.`actor_id`
    INNER JOIN `film` ON `film_actor`.`film_id` = `film`.`film_id`
    INNER JOIN `film_category` ON `film`.`film_id` = `film_category`.`film_id`
    INNER JOIN `category` ON `film_category`.`category_id` = `category`.`category_id`
    WHERE `category`.`name` = 'Horror'
    GROUP BY `a1`.`actor_id`
)
ORDER BY `a`.`last_name`, `a`.`first_name`;   
    
    
    
    
    
    
    
    
    
    
    
    
    


        
        
        





     
     
     
     

     
     
