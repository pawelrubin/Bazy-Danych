update film
SET language_id = (SELECT language_id FROM language WHERE name = 'Mandarin')
WHERE title = 'WON DARES';


update film
SET language_id = (SELECT language_id FROM language WHERE name = 'German')
WHERE film_id IN (
  SELECT film_id FROM film_actor JOIN actor a on film_actor.actor_id = a.actor_id
  WHERE first_name = 'NICK' AND last_name = 'WAHLBERG'
);

select *
from language;
