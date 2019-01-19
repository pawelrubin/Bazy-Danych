EXPLAIN SELECT imie FROM aktorzy WHERE imie LIKE 'J%';

EXPLAIN SELECT nazwisko FROM aktorzy WHERE liczba_filmow > 12;

EXPLAIN SELECT DISTINCT tytul FROM filmy JOIN zagrali ON filmy.id_filmu = zagrali.id_filmu
WHERE id_aktora IN (
    SELECT DISTINCT id_aktora FROM zagrali z
    WHERE z.id_filmu IN (
        SELECT z.id_filmu FROM zagrali z JOIN aktorzy a ON z.id_aktora = a.id_aktora
        WHERE imie LIKE 'Zero' AND nazwisko LIKE 'Cage'
        )
    );


EXPLAIN SELECT ile FROM (
SELECT aktor, DATEDIFF(koniec, CURDATE()) AS ile FROM kontrakty) AS czasy
WHERE ile > 0
ORDER BY ile ASC LIMIT 1;

EXPLAIN SELECT imie, COUNT(imie) AS num FROM aktorzy GROUP BY imie ORDER BY num DESC LIMIT 1;