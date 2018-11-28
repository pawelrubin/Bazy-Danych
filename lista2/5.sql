

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

CREATE PROCEDURE do_kontraktow ()
  BEGIN
    SET @id = 1;
    SET @lim = (SELECT MAX(id_aktora) FROM aktorzy);
    label: LOOP
      IF @id > @lim THEN
        LEAVE label;
      END IF;
      IF (@id IN (SELECT id_aktora FROM aktorzy)) THEN
        INSERT INTO kontrakty (aktor, agent, koniec, poczatek, gaza) VALUES (
          @id,
          (SELECT licencja FROM agenci ORDER BY RAND() LIMIT 1 ),
          DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY ),
          CURDATE(),
          FLOOR(RAND()*1000 + 1)
        );
      END IF;
      SET @id = @id + 1;
      ITERATE label;
    END LOOP;
  END//