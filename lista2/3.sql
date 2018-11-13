ALTER TABLE aktorzy
ADD COLUMN liczba_filmow INT,
ADD COLUMN tytuly VARCHAR(128);

UPDATE aktorzy
SET aktorzy.liczba_filmow = (
  SELECT COUNT(id_filmu) liczba
  FROM zagrali
  WHERE aktorzy.id_aktora = zagrali.id_aktora
);

UPDATE aktorzy
SET tytuly = (
  SELECT tytul
  FROM filmy JOIN zagrali ON filmy.id_filmu = zagrali.id_filmu
  WHERE aktorzy.id_aktora = zagrali.id_aktora AND
  aktorzy.liczba_filmow < 4
);