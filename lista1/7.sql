SELECT DISTINCT title
FROM film JOIN inventory i ON film.film_id = i.film_id JOIN rental r ON i.inventory_id = r.inventory_id
WHERE rental_date BETWEEN '2005-05-25 00:00:00' AND '2005-05-30 23:59:59' ORDER BY title;