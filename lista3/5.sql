DELIMITER //
CREATE PROCEDURE agreguj_kolumne(IN agg VARCHAR(15), IN kol VARCHAR(50))
  BEGIN
    IF agg IN ('MIN', 'MAX', 'SUM', 'COUNT', 'AVG', 'STD') AND
       kol IN ('PESEL', 'imie', 'nazwisko', 'data_urodzenia',
               'wzrost', 'waga', 'rozmiar_buta', 'ulubiony_kolor') THEN
      SET @str = CONCAT('SELECT \'', kol, '\', \'', agg, '\', ', agg, '(', kol, ') ', 'FROM Ludzie;' ) ;
      PREPARE stmt FROM @str;
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
    ELSE
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O ty gagatku.';
    END IF;
  END //
DELIMITER ;