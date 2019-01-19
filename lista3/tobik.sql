DELIMITER //
CREATE TRIGGER pracownicy_insert_trigger BEFORE INSERT ON pracownicy
	FOR EACH ROW
	BEGIN
		DECLARE urodziny DATE;
		DECLARE peselMies INT;
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
			7*CAST(SUBSTRING(NEW.PESEL, 10, 1) AS UNSIGNED) +
			1*CAST(SUBSTRING(NEW.PESEL, 11, 1) AS UNSIGNED),11)<>0
		THEN
		  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Blad sumy kontrolnej PESEL';
		END IF;
		IF MOD(CAST(SUBSTRING(NEW.PESEL, 3, 1) AS UNSIGNED), 2)<>0 THEN
			IF CAST(SUBSTRING(NEW.PESEL, 4, 1) AS UNSIGNED ) > 2 THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Blad miesiac';
			END IF;
		END IF;
		IF CAST(SUBSTRING(NEW.PESEL, 5, 2) AS UNSIGNED ) >31 THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Blad dzien';
		END IF;

		SET peselMies = CAST(SUBSTRING(NEW.PESEL, 3, 2) AS UNSIGNED );
		IF peselMies < 20 THEN
			SET urodziny = STR_TO_DATE(CONCAT(SUBSTRING(NEW.PESEL, 5, 2),'/',SUBSTRING(NEW.PESEL, 3, 2),'/19',SUBSTRING(NEW.PESEL, 1, 2)), '%d/%M/%Y');
		ELSEIF peselMies < 40 THEN
			SET urodziny = STR_TO_DATE(CONCAT(SUBSTRING(NEW.PESEL, 5, 2),'/',CAST(SUBSTRING(NEW.PESEL, 3, 1)AS UNSIGNED )-2,SUBSTRING(NEW.PESEL, 4, 1),'/20',SUBSTRING(NEW.PESEL, 1, 2)), '%d/%M/%Y');
		ELSEIF peselMies > 80 THEN
			SET urodziny = STR_TO_DATE(CONCAT(SUBSTRING(NEW.PESEL, 5, 2),'/',CAST(SUBSTRING(NEW.PESEL, 3, 1)AS UNSIGNED )-8,SUBSTRING(NEW.PESEL, 4, 1),'/18',SUBSTRING(NEW.PESEL, 1, 2)), '%d/%M/%Y');
		ELSE
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'do luftu ten rok';
		END IF;
		IF DATEDIFF(CURDATE(),urodziny)<6574 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'niepelnoletni';
		END IF;
		IF NEW.zawod LIKE 'sprzedawca' THEN
			IF DATEDIFF(CURDATE(),urodziny)>23741 THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'za stary';
			END IF;
		END IF;
	END;