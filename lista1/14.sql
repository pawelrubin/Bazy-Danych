CREATE VIEW horrors AS
SELECT DISTINCT actor_id, COUNT(film_id) AS hr_num
FROM film_actor
  JOIN film_list ON FID=film_id
WHERE category='Horror'
GROUP BY actor_id
ORDER BY actor_id;

CREATE VIEW actions AS
SELECT DISTINCT actor_id, COUNT(film_id) AS ac_num
FROM film_actor
  JOIN film_list ON FID=film_id
WHERE category='Action'
GROUP BY actor_id
ORDER BY actor_id;

CREATE VIEW horrors_actions AS
SELECT hr.actor_id, hr_num, ac_num
FROM horrors hr LEFT JOIN actions ac ON ac.actor_id = hr.actor_id;

SELECT last_name
FROM horrors_actions
JOIN actor a ON horrors_actions.actor_id = a.actor_id
WHERE hr_num > ac_num OR ISNULL(ac_num)
GROUP BY a.actor_id
ORDER BY last_name;