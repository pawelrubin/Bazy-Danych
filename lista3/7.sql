DELIMITER //
CREATE FUNCTION rand_laplace(u FLOAT, b FLOAT, x FLOAT) RETURNS FLOAT DETERMINISTIC
BEGIN
    RETURN (1 / (2 * b)) * EXP(-(ABS(x - u) / b));
END//

DELIMITER //
CREATE PROCEDURE suma_kolumny_dla_zawodu(IN kol VARCHAR(6), IN in_zawod VARCHAR(50), IN epsilon FLOAT)
  BEGIN

    IF kol NOT IN ('wzrost', 'waga', 'pensja') THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mordziu nie ma takiej kolumny, co ty sobie w ogole wyobrazasz?!';
    END IF;
    IF in_zawod NOT IN (SELECT DISTINCT zawod FROM pracownicy) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mordziu nie ma takiego zawodu, co ty sobie w ogole wyobrazasz?!';
    END IF;

    SET @maks = CONCAT('(SELECT MAX(', kol, ') FROM pracownicy JOIN ludzie l ON pracownicy.PESEL = l.PESEL WHERE zawod = \'', in_zawod, '\')');
    SET @minn = CONCAT('(SELECT MIN(', kol, ') FROM pracownicy JOIN ludzie l ON pracownicy.PESEL = l.PESEL WHERE zawod = \'', in_zawod, '\')');
    SET @x = (SELECT SUM(kol) FROM ludzie);
    SET @szum = (SELECT rand_laplace(0, @x, @b));

    SET @str = CONCAT('SELECT rand_laplace(0, (SELECT SUM(',kol,') FROM ludzie), (', @maks, '- ', @minn,')/', epsilon,')',
                      ' + SUM(', kol, ') FROM pracownicy JOIN ludzie l ON pracownicy.PESEL = l.PESEL WHERE zawod = \'', in_zawod, '\';');
    PREPARE stmt FROM @str;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END//
DELIMITER ;\