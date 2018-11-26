DELIMITER //
CREATE FUNCTION srednia(licence VARCHAR(40)) RETURNS INT DETERMINISTIC
  BEGIN
    DECLARE result INT;
    SET result = (
      SELECT AVG(gaza*DATEDIFF(koniec, poczatek))
      FROM `laboratorium-filmoteka`.kontrakty
             JOIN agenci a on kontrakty.agent = a.licencja
      WHERE licencja = licence
      );
    IF isnull(result) THEN
      RETURN '';
    end if;
    RETURN result;
  end //
DELIMITER ;
SELECT srednia('lic206');

select agent, count(agent) as num from kontrakty group by agent having num > 1
