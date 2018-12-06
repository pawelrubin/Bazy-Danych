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
  PRIMARY KEY (PESEL),
  FOREIGN KEY (PESEL) REFERENCES Ludzie(PESEL)
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

DELIMITER //
CREATE PROCEDURE reprodukcja(IN ile INT)
  BEGIN
    DECLARE new_imie VARCHAR(30);
    DECLARE new_nazwisko VARCHAR(30);
    DECLARE new_data_urodzenia DATE;
    DECLARE new_wzrost FLOAT;
    DECLARE new_waga FLOAT;
    DECLARE new_rozmiar_buta INT(11);
    DECLARE new_ulubiony_kolor VARCHAR(10);
    DECLARE new_PESEL CHAR(11);
    DECLARE PESEL_data CHAR(6);
    DECLARE PESEL_seria CHAR(4);
    DECLARE PESEL_suma CHAR(1);

    DECLARE i INT DEFAULT 0;
    WHILE i < ile DO
      SET new_imie = ELT(FLOOR(1 + RAND() * 13), 'Kapitan', 'Inspektor', 'Chorąży', 'Pan', 'Profesor', 'Niezwykły', 'Rychu', 'Steve',
              'Michał', 'Cezary', 'Kierowca', 'Andrzej', 'Zygmunt');
      SET new_nazwisko = ELT(FLOOR(1 + RAND() * 13), 'Sztorm', 'Gadżet', 'Torpeda', 'Kierownik', 'Zwyczajny', 'Spider Man', 'Peja', 'Jobs',
              'Archanioł', 'Pazura', 'Tira', 'Baltazar', 'Dzwon');
      SET new_data_urodzenia = CURDATE() - INTERVAL FLOOR(18 + RAND() * 52) YEAR - INTERVAL FLOOR(RAND() * 365) DAY;
      SET new_wzrost = FLOOR(140 + RAND() * 80);
      SET new_waga = FLOOR(40 + RAND() * 100);
      SET new_rozmiar_buta = FLOOR(36 + RAND() * 10);
      SET new_ulubiony_kolor = ELT(FLOOR(1 + RAND() * 5), 'czarny', 'czerwony', 'zielony', 'niebieski','biały');
      SET PESEL_data = CONCAT(
        SUBSTRING(new_data_urodzenia, 3, 2),
        SUBSTRING(new_data_urodzenia, 6, 2),
        SUBSTRING(new_data_urodzenia, 9, 2));
      SET PESEL_seria = CONCAT(
          FLOOR(RAND() * 10),
          FLOOR(RAND() * 10),
          FLOOR(RAND() * 10),
          FLOOR(RAND() * 10)
        );
      SET PESEL_suma = CAST(MOD(
        9*CAST(SUBSTRING(PESEL_data, 1, 1) AS UNSIGNED) +
        7*CAST(SUBSTRING(PESEL_data, 2, 1) AS UNSIGNED) +
        3*CAST(SUBSTRING(PESEL_data, 3, 1) AS UNSIGNED) +
        1*CAST(SUBSTRING(PESEL_data, 4, 1) AS UNSIGNED) +
        9*CAST(SUBSTRING(PESEL_data, 5, 1) AS UNSIGNED) +
        7*CAST(SUBSTRING(PESEL_data, 6, 1) AS UNSIGNED) +
        3*CAST(SUBSTRING(PESEL_seria, 1, 1) AS UNSIGNED) +
        1*CAST(SUBSTRING(PESEL_seria, 2, 1) AS UNSIGNED) +
        9*CAST(SUBSTRING(PESEL_seria, 3, 1) AS UNSIGNED) +
        7*CAST(SUBSTRING(PESEL_seria, 4, 1) AS UNSIGNED),
        10) AS CHAR);
      SET new_PESEL = CONCAT(PESEL_data, PESEL_seria, PESEL_suma);

      INSERT INTO Ludzie(PESEL, imie, nazwisko, data_urodzenia, wzrost, waga, rozmiar_buta, ulubiony_kolor)
      VALUES (new_PESEL, new_imie, new_nazwisko, new_data_urodzenia, new_wzrost, new_waga, new_rozmiar_buta, new_ulubiony_kolor);
      SET i = i + 1;
    END WHILE;
  END //

CALL reprodukcja(200);

