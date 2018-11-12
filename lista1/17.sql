UPDATE film
SET language_id = (SELECT language_id FROM language WHERE name = 'Mandarin')
WHERE title = 'WON DARES';


UPDATE film
SET language_id = (SELECT language_id FROM language WHERE name = 'German')
WHERE film_id IN (
  SELECT film_id FROM film_actor JOIN actor a ON film_actor.actor_id = a.actor_id
  WHERE first_name = 'NICK' AND last_name = 'WAHLBERG'
);