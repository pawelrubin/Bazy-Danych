CREATE TABLE Agenci (
  licencja VARCHAR(40) NOT NULL,
  nazwa VARCHAR(90),
  wiek INT,
  typ ENUM('osoba indywidualna', 'agencja', 'inny'),
  PRIMARY KEY (licencja),
  CHECK (wiek >= 21)
);

CREATE TABLE Kontrakty (
  ID INT NOT NULL AUTO_INCREMENT,
  agent VARCHAR(30),
  aktor INT,
  poczatek DATE,
  koniec DATE,
  gaza INT,
  PRIMARY KEY (ID),
  FOREIGN KEY (aktor) REFERENCES aktorzy(id_aktora),
  FOREIGN KEY (agent) REFERENCES Agenci(licencja),
  CHECK (DATEDIFF(poczatek, koniec) >= 1),
  CHECK (gaza >= 0)
);
