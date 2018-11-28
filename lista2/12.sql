DELIMITER //
CREATE TRIGGER dowolnyagent BEFORE INSERT ON kontrakty
FOR EACH ROW
BEGIN
    IF ((SELECT * FROM kontrakty WHERE NEW.aktor = aktor AND poczatek < CURDATE() AND koniec > CURDATE()) <> '') THEN
      SIGNAL SQLSTATE '22000' SET MESSAGE_TEXT = 'error';
    END IF;
    INSERT INTO agenci (licencja, nazwa, wiek, typ) VALUES (
        NEW.agent,
        CONCAT_WS(' ',
            ELT(FLOOR(RAND()*13+1), 'Kapitan', 'Inspektor', 'Chorąży', 'Pan', 'Profesor', 'Niezwykły', 'Rychu', 'Steve',
              'Michał', 'Cezary', 'Kierowca', 'Andrzej', 'Zygmunt'),
            ELT(FLOOR(RAND()*13+1), 'Sztorm', 'Gadżet', 'Torpeda', 'Kierownik', 'Zwyczajny', 'Spider Man', 'Peja', 'Jobs',
              'Archanioł', 'Pazura', 'Tira', 'Baltazar', 'Dzwon')),
          FLOOR(RAND()*43+21),
          ELT(FLOOR(RAND()*3+1), 'osoba indywidualna', 'agencja', 'inny')
    );
END;//
DELIMITER ;
drop trigger dowolnyagent;
