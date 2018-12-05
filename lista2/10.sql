DELIMITER //
CREATE PROCEDURE zad10(OUT agent VARCHAR(30), OUT maks INT)
  BEGIN
    DECLARE il_ag INT DEFAULT 0; # ilosc agentow w tabeli kontrakty
    DECLARE i INT DEFAULT 0; # iterator po agentach
    DECLARE j INT DEFAULT 0; # iterator po aktorach dla i-tego agenta
    DECLARE id_agenta VARCHAR(30); # id i-tego agenta
    DECLARE il_akt_ag INT DEFAULT 0; # ilsoc aktorow dla i-tego agenta
    DECLARE maks_dla_agenta INT DEFAULT 0;
    DECLARE maks_global INT DEFAULT 0;
    DECLARE id_aktora INT DEFAULT 0;
    DECLARE dl_j_akt INT DEFAULT 0; # dlugosc kontraktu dla j tego aktora dla agenta
    DECLARE id_wyniku VARCHAR(30) DEFAULT 'elo'; # id agenta wynikowego

    SELECT COUNT(*) FROM kontrakty INTO il_ag;
    WHILE i < il_ag DO
      SELECT agent FROM kontrakty LIMIT i, 1 INTO id_agenta;
      SELECT COUNT(aktor) FROM kontrakty WHERE agent = id_agenta INTO il_akt_ag;
      SET maks_dla_agenta = 0;
      SET j  = 0;

      WHILE j < il_akt_ag DO
        SELECT t.aktor FROM (SELECT aktor FROM kontrakty WHERE agent = id_agenta) t LIMIT j,1 INTO id_aktora;  # j-oty aktor dla agenta
        SELECT DATEDIFF(koniec, poczatek) FROM kontrakty WHERE agent = id_agenta AND aktor = id_aktora INTO dl_j_akt;
        SET maks_global = maks_global + 1;
        IF dl_j_akt > maks_dla_agenta THEN
          SET maks_dla_agenta = dl_j_akt;
        END IF;
        SET j = j + 1;
      END WHILE;

      IF maks_dla_agenta > maks_global THEN
        SET maks_global = maks_dla_agenta;
        SET id_wyniku = id_agenta;
      END IF;

      SET i = i + 1;
    END WHILE;

    SELECT id_agenta INTO agent;
    SELECT il_akt_ag INTO maks;
  END //
#SET @wynik ='';
call zad10(@wynik, @maks);
SELECT @wynik, @maks;
DROP PROCEDURE zad10;
SELECT agent, COUNT(aktor)
FROM kontrakty
GROUP BY agent;

# SELECT count(id) FROM kontrakty WHERE
SELECT agent, aktor, COUNT(ID)
FROM kontrakty
GROUP BY aktor, agent

Set @a = (SELECT DATEDIFF(koniec, poczatek) FROM kontrakty WHERE agent = 'lic1000' AND aktor = 78)
SELECT @a;

SELECT aktor FROM kontrakty WHERE agent = 'lic1000'

      SELECT COUNT(aktor) FROM kontrakty WHERE agent = 'lic1000'# INTO il_akt_ag;
