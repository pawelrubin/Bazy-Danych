DELIMITER //
CREATE TRIGGER usuniete_filmy AFTER DELETE ON filmy
  FOR EACH ROW
  BEGIN
    DELETE FROM zagrali
        where OLD.id_filmu = zagrali.id_filmu;
  END;//
DELIMITER ;
/* trigger w zadaniu 11 */