CREATE DATABASE log;

CREATE TABLE logi_pensji (
  pesel CHAR(11),
  stare FLOAT,
  nowe FLOAT,
  czas_zmiany VARCHAR(20),
  uzytkownik VARCHAR(15)
);

DELIMITER //
CREATE TRIGGER pensja_logger_on_update AFTER UPDATE ON pracownicy
  FOR EACH ROW
  BEGIN
    INSERT INTO log.logi_pensji(pesel, stare, nowe, czas_zmiany, uzytkownik)
      VALUES (
        OLD.PESEL,
        OLD.pensja,
        NEW.pensja,
        NOW(),
        CURRENT_USER
      );
  END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER pensja_logger_on_delete AFTER DELETE ON pracownicy
  FOR EACH ROW
  BEGIN
    INSERT INTO log.logi_pensji(pesel, stare, nowe, czas_zmiany, uzytkownik)
      VALUES (
        OLD.PESEL,
        OLD.pensja,
        NULL,
        NOW(),
        CURRENT_USER
      );
  END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER pensja_logger_on_insert AFTER INSERT ON pracownicy
  FOR EACH ROW
  BEGIN
    INSERT INTO log.logi_pensji(pesel, stare, nowe, czas_zmiany, uzytkownik)
      VALUES (
        NEW.PESEL,
        NULL,
        NEW.pensja,
        NOW(),
        CURRENT_USER
      );
  END//
DELIMITER ;