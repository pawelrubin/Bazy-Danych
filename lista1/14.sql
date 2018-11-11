CREATE VIEW horrors AS
SELECT DISTINCT a.actor_id, COUNT(f.film_id) as hr_num
FROM film_actor
  JOIN actor a on film_actor.actor_id = a.actor_id
  JOIN film f on film_actor.film_id = f.film_id
  JOIN film_category f2 on f.film_id = f2.film_id
  JOIN category c on f2.category_id = c.category_id
WHERE c.name='Horror'
  GROUP BY a.actor_id
  ORDER BY a.actor_id;

CREATE VIEW actions AS
SELECT DISTINCT a.actor_id, COUNT(f.film_id) as ac_num
FROM film_actor
  JOIN actor a on film_actor.actor_id = a.actor_id
  JOIN film f on film_actor.film_id = f.film_id
  JOIN film_category f2 on f.film_id = f2.film_id
  JOIN category c on f2.category_id = c.category_id
WHERE c.name='Action'
  GROUP BY a.actor_id
  ORDER BY a.actor_id;

CREATE VIEW horrors_actions AS
SELECT hr.actor_id, hr_num, ac_num FROM horrors hr left JOIN actions ac ON ac.actor_id = hr.actor_id;

SELECT *
FROM horrors_actions
JOIN actor a ON horrors_actions.actor_id = a.actor_id
WHERE hr_num > ac_num OR (ISNULL(ac_num) AND ISNULL(hr_num))
GROUP BY a.actor_id
ORDER BY last_name

