PREPARE statement
  FROM '
    SELECT nazwa, licencja, COUNT(DISTINCT aktor)
    FROM `laboratorium-filmoteka`.kontrakty JOIN agenci a on kontrakty.agent = a.licencja
    WHERE nazwa = ?';
set @test = 'Zygmunt Dzwon';
EXECUTE statement using @test;

select * from agenci where licencja LIKE '%312'

