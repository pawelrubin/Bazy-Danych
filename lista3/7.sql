DELIMITER //
CREATE PROCEDURE suma_kolumny_dla_zawodu(IN kol VARCHAR(6), IN in_zawod VARCHAR(50), IN epsilon FLOAT)
  BEGIN
    IF kol NOT IN ('wzrost', 'waga', 'pensja') THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mordziu nie ma takiej kolumny, co ty sobie w ogole wyobrazasz?!';
    END IF;
    IF in_zawod NOT IN (SELECT DISTINCT zawod FROM pracownicy) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mordziu nie ma takiego zawodu, co ty sobie w ogole wyobrazasz?!';
    END IF;

    SET @str = CONCAT('SELECT SUM(', kol, ') FROM pracownicy JOIN ludzie ON pracownicy.PESEL = ludzie.PESEL;');
    PREPARE stmt FROM @str;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END//
DELIMITER ;