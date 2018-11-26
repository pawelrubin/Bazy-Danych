DELIMITER //
CREATE FUNCTION daj_konktrakt(imie VARCHAR(50), nazwisko VARCHAR(50)) RETURNS  VARCHAR(100) DETERMINISTIC
  BEGIN
    DECLARE result VARCHAR(100) DEFAULT '';
    SET result = (
      SELECT CONCAT(nazwa, ' ', DATEDIFF(koniec, curdate()))
      FROM kontrakty
      JOIN aktorzy a on kontrakty.aktor = a.id_aktora
      JOIN agenci a2 on kontrakty.agent = a2.licencja
      WHERE a.imie = imie AND a.nazwisko = nazwisko
    );
    RETURN result;
  END //

SELECT daj_konktrakt('PENELOPE', 'GUINESS');
SELECT * from aktorzy
