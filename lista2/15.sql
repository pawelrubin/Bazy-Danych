CREATE VIEW widok_agenci AS
  SELECT nazwa, typ
  FROM agenci;

CREATE VIEW widok_aktorzy AS
  SELECT imie, nazwisko
  FROM aktorzy;

CREATE VIEW widok_filmy AS
  SELECT tytul, czas_trwania, kategoria_wiekowa
  FROM filmy;

CREATE USER 'gosc'@'localhost' IDENTIFIED BY '2137';
GRANT SELECT ON `laboratorium-filmoteka`.widok_agenci TO 'gosc'@'localhost';
GRANT SELECT ON `laboratorium-filmoteka`.widok_aktorzy TO 'gosc'@'localhost';
GRANT SELECT ON `laboratorium-filmoteka`.widok_filmy TO 'gosc'@'localhost';
