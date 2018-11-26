DELIMITER //
CREATE TRIGGER aktorzy_insert AFTER INSERT ON zagrali
  FOR EACH ROW
  BEGIN
    UPDATE aktorzy
      SET liczba_filmow = (
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
  END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER aktorzy_update AFTER UPDATE ON zagrali
  FOR EACH ROW
  BEGIN
    UPDATE aktorzy
      SET liczba_filmow = (
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
  END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER aktorzy_update AFTER DELETE ON zagrali
  FOR EACH ROW
  BEGIN
    UPDATE aktorzy
      SET liczba_filmow = (
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
  END//
DELIMITER ;