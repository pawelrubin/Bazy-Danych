CREATE VIEW aktor_agent_konktrakt AS (
  SELECT imie, nazwisko, nazwa, DATEDIFF(koniec, CURDATE())
  FROM aktorzy
    JOIN kontrakty k ON aktorzy.id_aktora = k.aktor
    JOIN agenci a ON k.agent = a.licencja
);

