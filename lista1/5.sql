SELECT first_name, last_name
FROM actor JOIN film_actor fa on actor.actor_id = fa.actor_id JOIN film f on fa.film_id = f.film_id
WHERE special_features LIKE '%Deleted Scenes%';
