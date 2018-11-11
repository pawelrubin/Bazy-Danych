# ALTER TABLE language
#     ADD COLUMN films_no INT NOT NULL AFTER name;
UPDATE language SET films_no = ( SELECT COUNT(title) from film WHERE film.language_id=language.language_id )
