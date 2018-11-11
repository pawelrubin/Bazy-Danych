SELECT *
FROM (
  SELECT ac1.first_name AS a1_fn, ac1.last_name AS a1_ln,
         ac2.first_name AS a2_fn, ac2.last_name AS a2_ln,
         count(*) AS num
  FROM film_actor fa1
  JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
  JOIN actor ac1 on fa1.actor_id = ac1.actor_id
  JOIN actor ac2 on fa2.actor_id = ac2.actor_id
  WHERE fa1.actor_id < fa2.actor_id
  GROUP BY fa1.actor_id, fa2.actor_id
) AS fa
WHERE num > 1



