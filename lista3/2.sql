# korzystamy z btree, poniewaz wykorzystywany jest do porownan,
# ktore korzystaja z operatorow:  =, >, >=, <, <=, BETWEEN
#
CREATE INDEX idx_kontrakty_koniec USING BTREE ON kontrakty(koniec);

SELECT aktor FROM kontrakty WHERE koniec BETWEEN CURDATE() AND ADDDATE(curdate(), INTERVAL 31 DAY);