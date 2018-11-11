SELECT DISTINCT last_name
FROM actor JOIN film_actor fa on actor.actor_id = fa.actor_id
WHERE actor.actor_id NOT IN (
  SELECT actor_id
  FROM film_actor JOIN film ON film_actor.film_id = film.film_id
  where title LIKE 'B%'
)