DELIMITER //
CREATE PROCEDURE wyplata(IN budzet FLOAT, IN in_zawod VARCHAR(30))
  BEGIN
    DECLARE num INT;
    DECLARE cost FLOAT;
    DECLARE i_PESEL CHAR(11);
    DECLARE i INT DEFAULT 0;

    IF in_zawod NOT IN (SELECT DISTINCT zawod FROM pracownicy) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mordziu nie ma takiego zawodu, co ty sobie w ogole wyobrazasz?!';
    END IF;

    SET cost = (SELECT SUM(pensja) FROM pracownicy WHERE zawod LIKE in_zawod);
    IF cost > budzet THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mordziu masz 48h na splate siana.';
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