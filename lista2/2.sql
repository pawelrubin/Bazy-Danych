CREATE TABLE aktorzy (
  id_aktora INT NOT NULL AUTO_INCREMENT,
  imie VARCHAR(50),
  nazwisko VARCHAR(50),
  PRIMARY KEY (id_aktora)
);

CREATE TABLE filmy (
  id_filmu INT NOT NULL AUTO_INCREMENT,
  tytul varchar(50),
  czas_trwania INT,
  kategoria_wiekowa VARCHAR(50),
  PRIMARY KEY (id_filmu)
);

CREATE TABLE zagrali (
  id_filmu INT,
  id_aktora INT,
  PRIMARY KEY (id_filmu, id_aktora)
);

INSERT INTO `laboratorium-filmoteka`.aktorzy (id_aktora, imie, nazwisko)
SELECT actor_id, first_name, last_name
FROM  sakila.actor
WHERE first_name NOT LIKE '%v%' AND first_name NOT LIKE '%q%' AND first_name NOT LIKE '%x%'
  AND last_name NOT LIKE '%v%' AND last_name NOT LIKE '%q%' AND last_name NOT LIKE '%x%';

INSERT INTO `laboratorium-filmoteka`.filmy (id_filmu, tytul, czas_trwania, kategoria_wiekowa)
SELECT film_id, title, length, rating
FROM sakila.film
WHERE title NOT LIKE '%v%' AND title NOT LIKE '%q%' AND title NOT LIKE '%x%';

INSERT INTO `laboratorium-filmoteka`.zagrali (id_filmu, id_aktora)
SELECT film_id, actor_id
FROM sakila.film_actor
WHERE film_id IN (SELECT id_filmu FROM filmy) AND
      actor_id IN (SELECT id_aktora FROM aktorzy);