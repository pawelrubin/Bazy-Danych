

DELIMITER //
CREATE PROCEDURE tworzenie_agentow ()
  BEGIN
    SET @id = 1;
    label: LOOP
      IF @id > 1000 THEN
        LEAVE label;
      END IF;

      INSERT INTO agenci (licencja, nazwa, wiek, typ)
        VALUES (
          CONCAT('lic', @id),
          CONCAT_WS(' ',
            ELT(FLOOR(RAND()*13+1), 'Kapitan', 'Inspektor', 'Chorąży', 'Pan', 'Profesor', 'Niezwykły', 'Rychu', 'Steve',
              'Michał', 'Cezary', 'Kierowca', 'Andrzej', 'Zygmunt'),
            ELT(FLOOR(RAND()*13+1), 'Sztorm', 'Gadżet', 'Torpeda', 'Kierownik', 'Zwyczajny', 'Spider Man', 'Peja', 'Jobs',
              'Archanioł', 'Pazura', 'Tira', 'Baltazar', 'Dzwon')),
          FLOOR(RAND()*43+21),
          ELT(FLOOR(RAND()*3+1), 'osoba indywidualna', 'agencja', 'inny')
      );

      SET @id = @id +1;
      ITERATE label;
    END LOOP;
  END //
DELIMITER ;

DELIMITER //
INSERT INTO kontra
CREATE PROCEDURE do_kontraktow ()
  BEGIN
    SET @id = 1;
    label: LOOP
      IF @id > (SELECT COUNT(*) FROM aktorzy) THEN
        LEAVE label;
        INSERT INTO kontrakty (ID, aktor, agent)
        SELECT (
          @id,


                   )
      END IF;
    END LOOP;
  END;