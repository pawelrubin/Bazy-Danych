UPDATE language SET films_no = (SELECT COUNT(title) from film WHERE film.language_id=language.language_id )
select * from language