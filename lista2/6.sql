# DELIMITER //
#     SET @id = 1;
#     SET @i = 1;
#     SET @lim = 30;
#     label: LOOP
#       IF @i > @lim THEN
#         LEAVE label;
#       END IF;
#       IF (@id IN (SELECT id_aktora FROM aktorzy)) THEN
#         INSERT INTO kontrakty (agent, aktor, poczatek, koniec, gaza)
#         VALUES (
#                 @id,
#                 (SELECT licencja FROM agenci ORDER BY RAND() LIMIT 1),
#                 DATE_ADD(2017, INTERVAL FLOOR(RAND()*365) DAY ),
#                 CURDATE()-1,
#                 FLOOR(RAND()*1000 + 1)
#         );
#         SET @i = @i + 1;
#       END IF;
#       SET @id = @id + 1;
#       ITERATE label;
#     END LOOP;
#   END //
#
# SELECT * FROM kontrakty