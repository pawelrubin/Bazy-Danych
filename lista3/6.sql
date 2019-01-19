DELIMITER //
CREATE PROCEDURE wyplata(IN budzet FLOAT, IN in_zawod VARCHAR(30))
  BEGIN
    DECLARE num INT;
    DECLARE cost FLOAT;
    DECLARE i_PESEL CHAR(11);
    DECLARE i INT DEFAULT 0;

    IF in_zawod NOT IN (SELECT DISTINCT zawod FROM pracownicy) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'nie ma takiego zawodu.';
    END IF;

    SET cost = (SELECT SUM(pensja) FROM pracownicy WHERE zawod LIKE in_zawod);
    IF cost > budzet THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'za maly budzet.';
    END IF;

    DROP TEMPORARY TABLE IF EXISTS wynik;
    CREATE TEMPORARY TABLE wynik(pesel CHAR(11), message CHAR(9));

    SET AUTOCOMMIT = 0;
    START TRANSACTION;
    SET num = (SELECT COUNT(zawod) FROM pracownicy WHERE zawod LIKE in_zawod);
      WHILE i < num DO
        SET i_PESEL = (SELECT PESEL FROM pracownicy LIMIT i,1);
        SET @pesel = CONCAT('********', SUBSTRING(i_PESEL, 8, 3));
        INSERT INTO wynik(pesel, message)
            VALUES (@pesel, 'wyplacono');
        SET i = i + 1;
      END WHILE;
    SELECT * FROM wynik;
    COMMIT;

    DROP TEMPORARY TABLE wynik;
  END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE wyplata_z_cursorem(IN budzet FLOAT, IN in_zawod VARCHAR(30))
  BEGIN

    DECLARE temp_pesel CHAR(11);
    DECLARE temp_pensja FLOAT;
    DECLARE temp_budzet FLOAT DEFAULT budzet;

    DECLARE koniec BOOLEAN DEFAULT FALSE;
    DECLARE sukces BOOLEAN DEFAULT TRUE;

    DECLARE cursor_wyplata CURSOR FOR (SELECT pesel, pensja FROM pracownicy WHERE zawod = in_zawod);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET koniec = TRUE;


    IF in_zawod NOT IN (SELECT DISTINCT zawod FROM pracownicy) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'nie ma takiego zawodu.';
    END IF;

    DROP TEMPORARY TABLE IF EXISTS wynik;
    CREATE TEMPORARY TABLE wynik(pesel CHAR(11), message CHAR(9));

    OPEN cursor_wyplata;
    SET AUTOCOMMIT = 0;
    START TRANSACTION;
    wyplata_loop: LOOP

      FETCH cursor_wyplata INTO temp_pesel, temp_pensja;
      IF (koniec)then
        LEAVE wyplata_loop;
      END IF;
      SET temp_budzet = temp_budzet - temp_pensja;
      IF (temp_budzet >= 0) THEN
        SET @pesel = CONCAT('********', SUBSTRING(temp_pesel, 8, 3));
        INSERT INTO wynik VALUES(@pesel, 'wyplacono');
      ELSE
        SET sukces = FALSE;
        LEAVE wyplata_loop;
      END IF;
    END LOOP;
    CLOSE cursor_wyplata;
    IF(sukces = TRUE) THEN
      SELECT * FROM wynik;
      COMMIT;
    ELSE
      ROLLBACK;
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'za maly budzet.';
    END IF;
    DROP TEMPORARY TABLE wynik;
  END //
DELIMITER ;

CALL wyplata(9999999, 'sprzedawca');
CALL wyplata_z_cursorem(999, 'informatyk');