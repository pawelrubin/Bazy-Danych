CREATE INDEX idx_filmy_tutyl ON filmy(tytul);

CREATE INDEX idx_aktorzy_nazwisko ON aktorzy(nazwisko, imie(1));

# Indeks na kolumnie id_aktora juz istnial (foreign key).
CREATE INDEX idx_zagrali_id_aktora ON zagrali(id_aktora);

