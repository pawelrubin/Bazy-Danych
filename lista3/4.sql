CREATE DATABASE dowolna;

USE dowolna;

SHOW TABLES;

CREATE TABLE Ludzie (
  PESEL CHAR(11) NOT NULL ,
  imie VARCHAR(30),
  nazwisko VARCHAR(30),
  data_urodzenia DATE,
  wzrost FLOAT,
  waga FLOAT,
  rozmiar_buta INT,
  ulubiony_kolor ENUM (
      'czarny', 'czerwony', 'zielony', 'niebieski', 'bialy'
  ),
  PRIMARY KEY(PESEL)
);

CREATE TABLE Pracownicy (
  PESEL CHAR(11) NOT NULL ,
  zawod VARCHAR(50),
  pensja FLOAT,
  PRIMARY KEY (PESEL)
);

DELIMITER //
CREATE TRIGGER ludzie_insert_trigger BEFORE INSERT ON Ludzie
  FOR EACH ROW
  BEGIN
    IF (SUBSTRING(NEW.PESEL, 1, 2) <> SUBSTRING(YEAR(NEW.data_urodzenia), 3, 2)) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PESEL nie zgadza sie z data urodzenia - blad w roku urodzenia.';
    END IF;
    IF (SUBSTRING(NEW.PESEL, 3, 2) <> MONTH(NEW.data_urodzenia)) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PESEL nie zgadza sie z data urodzenia - blad w miesiacu urodzenia.';
    END IF;
    IF (SUBSTRING(NEW.PESEL, 5, 2) <> DAYOFMONTH(NEW.data_urodzenia)) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PESEL nie zgadza sie z data urodzenia - blad w dniu urodzenia.';
    END IF;
    IF MOD(
      9*CAST(SUBSTRING(NEW.PESEL, 1, 1) AS UNSIGNED) +
      7*CAST(SUBSTRING(NEW.PESEL, 2, 1) AS UNSIGNED) +
      3*CAST(SUBSTRING(NEW.PESEL, 3, 1) AS UNSIGNED) +
      1*CAST(SUBSTRING(NEW.PESEL, 4, 1) AS UNSIGNED) +
      9*CAST(SUBSTRING(NEW.PESEL, 5, 1) AS UNSIGNED) +
      7*CAST(SUBSTRING(NEW.PESEL, 6, 1) AS UNSIGNED) +
      3*CAST(SUBSTRING(NEW.PESEL, 7, 1) AS UNSIGNED) +
      1*CAST(SUBSTRING(NEW.PESEL, 8, 1) AS UNSIGNED) +
      9*CAST(SUBSTRING(NEW.PESEL, 9, 1) AS UNSIGNED) +
      7*CAST(SUBSTRING(NEW.PESEL, 10, 1) AS UNSIGNED),
      10) <> SUBSTRING(NEW.PESEL, 11, 1)
    THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Blad sumy kontrolnej numeru PESEL.';
    END IF;
    IF NEW.wzrost < 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Wzrost musi byc dodatni.';
    END IF;
    IF NEW.waga < 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Waga musi byc dodatnia.';
    END IF ;
    IF NEW.rozmiar_buta < 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Rozmiar buta musi byc dodatni.';
    END IF ;
  END;
DELIMITER ;

DELIMITER //
CREATE TRIGGER ludzie_update_trigger AFTER UPDATE ON Ludzie
  FOR EACH ROW
  BEGIN
    IF (SUBSTRING(NEW.PESEL, 1, 2) <> SUBSTRING(YEAR(NEW.data_urodzenia), 3, 2)) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PESEL nie zgadza sie z data urodzenia - blad w roku urodzenia.';
    END IF;
    IF (SUBSTRING(NEW.PESEL, 3, 2) <> MONTH(NEW.data_urodzenia)) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PESEL nie zgadza sie z data urodzenia - blad w miesiacu urodzenia.';
    END IF;
    IF (SUBSTRING(NEW.PESEL, 5, 2) <> DAYOFMONTH(NEW.data_urodzenia)) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PESEL nie zgadza sie z data urodzenia - blad w dniu urodzenia.';
    END IF;
    IF MOD(
      9*CAST(SUBSTRING(NEW.PESEL, 1, 1) AS UNSIGNED) +
      7*CAST(SUBSTRING(NEW.PESEL, 2, 1) AS UNSIGNED) +
      3*CAST(SUBSTRING(NEW.PESEL, 3, 1) AS UNSIGNED) +
      1*CAST(SUBSTRING(NEW.PESEL, 4, 1) AS UNSIGNED) +
      9*CAST(SUBSTRING(NEW.PESEL, 5, 1) AS UNSIGNED) +
      7*CAST(SUBSTRING(NEW.PESEL, 6, 1) AS UNSIGNED) +
      3*CAST(SUBSTRING(NEW.PESEL, 7, 1) AS UNSIGNED) +
      1*CAST(SUBSTRING(NEW.PESEL, 8, 1) AS UNSIGNED) +
      9*CAST(SUBSTRING(NEW.PESEL, 9, 1) AS UNSIGNED) +
      7*CAST(SUBSTRING(NEW.PESEL, 10, 1) AS UNSIGNED),
      10) <> SUBSTRING(NEW.PESEL, 11, 1)
    THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Blad sumy kontrolnej numeru PESEL.';
    END IF;
    IF NEW.wzrost < 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Wzrost musi byc dodatni.';
    END IF;
    IF NEW.waga < 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Waga musi byc dodatnia.';
    END IF ;
    IF NEW.rozmiar_buta < 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Rozmiar buta musi byc dodatni.';
    END IF ;
  END;
DELIMITER ;

# przyklad poprawnego rekordu
INSERT INTO Ludzie(PESEL, imie, nazwisko, data_urodzenia, wzrost, waga, rozmiar_buta, ulubiony_kolor)
VALUES ('99100101234', 'Pawlo', 'Escobar', '1999-10-01', 197, 120, 45, 'czarny');

# przyklad niepoprawnego rekordu
INSERT INTO Ludzie(PESEL, imie, nazwisko, data_urodzenia, wzrost, waga, rozmiar_buta, ulubiony_kolor)
VALUES ('7813101234', 'Jan', 'Tacior', '1876-10-01', -7, 0, 45, 'czarny');

SELECT * FROM Ludzie;
DELETE FROM Ludzie;
