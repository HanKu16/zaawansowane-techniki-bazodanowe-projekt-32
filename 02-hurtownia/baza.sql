CREATE TABLE "panstwo_h" (
  "panstwo_id" CHAR(3) PRIMARY KEY,
  "nazwa" VARCHAR2(50) NOT NULL
);

CREATE TABLE "region_panstwa_h" (
  "region_panstwa_id" NUMBER(4) PRIMARY KEY,
  "nazwa" VARCHAR2(50) NOT NULL
);

CREATE TABLE "miasto_h" (
  "miasto_id" NUMBER(5) PRIMARY KEY,
  "nazwa" VARCHAR2(60) NOT NULL
);

CREATE TABLE "ulica_h" (
  "ulica_id" NUMBER(9) PRIMARY KEY,
  "nazwa" VARCHAR2(100) NOT NULL
);

CREATE TABLE "oddzial_h" (
  "oddzial_id" NUMBER(5) PRIMARY KEY,
  "nazwa" VARCHAR2(100) NOT NULL
);

CREATE TABLE "stanowisko_h" (
  "stanowisko_id" NUMBER(3) PRIMARY KEY,
  "nazwa" VARCHAR2(30) NOT NULL
);

CREATE TABLE "rodzaj_zatrudnienia_h" (
  "rodzaj_zatrudnienia_id" NUMBER(2) PRIMARY KEY,
  "nazwa" VARCHAR2(50) NOT NULL
);

CREATE TABLE "status_pracownika_h" (
  "status_pracownika_id" NUMBER(2) PRIMARY KEY,
  "nazwa" VARCHAR2(50) NOT NULL
);

CREATE TABLE "pracownik_h" (
  "pracownik_id" NUMBER(9) PRIMARY KEY,
  "nazwisko" VARCHAR2(55) NOT NULL
);

CREATE TABLE "typ_pracy_h" (
  "typ_pracy_id" NUMBER(2) PRIMARY KEY,
  "nazwa" VARCHAR2(50) NOT NULL
);

CREATE TABLE "zmiana_h" (
  "zmiana_id" NUMBER(2) PRIMARY KEY,
  "nazwa" VARCHAR2(30) NOT NULL
);

CREATE TABLE "status_projektu_h" (
  "status_projektu_id" NUMBER(2) PRIMARY KEY,
  "nazwa" VARCHAR2(50) NOT NULL
);

CREATE TABLE "rodzaj_projektu_h" (
  "rodzaj_projektu_id" NUMBER(2) PRIMARY KEY,
  "nazwa" VARCHAR2(50) NOT NULL
);

CREATE TABLE "projekt_h" (
  "projekt_id" NUMBER(5) PRIMARY KEY,
  "nazwa" VARCHAR2(100) NOT NULL
);

CREATE TABLE "dzien_miesiaca_h" (
  "dzien_miesiaca_id" NUMBER(2) PRIMARY KEY,
  "opis" VARCHAR2(100) NOT NULL
);

CREATE TABLE "miesiac_h" (
  "miesiac_id" NUMBER(2) PRIMARY KEY,
  "opis" VARCHAR2(100) NOT NULL
);

CREATE TABLE "rok_h" (
  "rok_id" NUMBER(4) PRIMARY KEY,
  "opis" VARCHAR2(100) NOT NULL
);

CREATE TABLE "czas_pracy_h" (
  "czas_pracy_id" NUMBER(20) PRIMARY KEY,
  "pracownik_id" NUMBER(9) NOT NULL,
  "stanowisko_id" NUMBER(3) NOT NULL,
  "rodzaj_zatrudnienia_id" NUMBER(2) NOT NULL,
  "status_pracownika_id" NUMBER(2) NOT NULL,
  "projekt_id" NUMBER(5) NOT NULL,
  "status_projektu_id" NUMBER(2) NOT NULL,
  "rodzaj_projektu_id" NUMBER(2) NOT NULL,
  "oddzial_id" NUMBER(5) NOT NULL,
  "ulica_id" NUMBER(9) NOT NULL,
  "miasto_id" NUMBER(5) NOT NULL,
  "region_panstwa_id" NUMBER(4) NOT NULL,
  "panstwo_id" CHAR(3) NOT NULL,
  "typ_pracy_id" NUMBER(2) NOT NULL,
  "zmiana_id" NUMBER(2) NOT NULL,
  "dzien_miesiaca_id" NUMBER(2) NOT NULL,
  "miesiac_id" NUMBER(2) NOT NULL,
  "rok_id" NUMBER(4) NOT NULL,
  "czas_przepracowany" NUMBER(4,2) NOT NULL,
  "czas_trwania_przerwy" NUMBER(4,2) NOT NULL,
  "godzina_przyjscia_do_pracy" TIMESTAMP NOT NULL,
  "godzina_wyjscia_z_pracy" TIMESTAMP NOT NULL,
  "godziny_rozpoczecia_przerwy" TIMESTAMP,
  "godziny_zakonczenia_przerwy" TIMESTAMP
);

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("pracownik_id") REFERENCES "pracownik_h" ("pracownik_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("stanowisko_id") REFERENCES "stanowisko_h" ("stanowisko_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("rodzaj_zatrudnienia_id") REFERENCES "rodzaj_zatrudnienia_h" ("rodzaj_zatrudnienia_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("status_pracownika_id") REFERENCES "status_pracownika_h" ("status_pracownika_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("projekt_id") REFERENCES "projekt_h" ("projekt_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("status_projektu_id") REFERENCES "status_projektu_h" ("status_projektu_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("rodzaj_projektu_id") REFERENCES "rodzaj_projektu_h" ("rodzaj_projektu_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("oddzial_id") REFERENCES "oddzial_h" ("oddzial_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("ulica_id") REFERENCES "ulica_h" ("ulica_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("miasto_id") REFERENCES "miasto_h" ("miasto_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("region_panstwa_id") REFERENCES "region_panstwa_h" ("region_panstwa_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("panstwo_id") REFERENCES "panstwo_h" ("panstwo_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("typ_pracy_id") REFERENCES "typ_pracy_h" ("typ_pracy_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("zmiana_id") REFERENCES "zmiana_h" ("zmiana_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("dzien_miesiaca_id") REFERENCES "dzien_miesiaca_h" ("dzien_miesiaca_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("miesiac_id") REFERENCES "miesiac_h" ("miesiac_id");

ALTER TABLE "czas_pracy_h" ADD FOREIGN KEY ("rok_id") REFERENCES "rok_h" ("rok_id");
