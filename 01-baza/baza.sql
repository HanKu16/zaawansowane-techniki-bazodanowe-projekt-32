CREATE TABLE "panstwo" (
  "panstwo_id" CHAR(3) PRIMARY KEY,
  "nazwa" VARCHAR2(50) NOT NULL
);

CREATE TABLE "region_panstwa" (
  "region_panstwa_id" NUMBER(4) PRIMARY KEY,
  "panstwo_id" CHAR(3) NOT NULL,
  "nazwa" VARCHAR2(50) NOT NULL
);

CREATE TABLE "miasto" (
  "miasto_id" NUMBER(5) PRIMARY KEY,
  "region_panstwa_id" NUMBER(4) NOT NULL,
  "nazwa" VARCHAR2(60) NOT NULL
);

CREATE TABLE "ulica" (
  "ulica_id" NUMBER(9) PRIMARY KEY,
  "miasto_id" NUMBER(5) NOT NULL,
  "nazwa" VARCHAR2(100) NOT NULL
);

CREATE TABLE "oddzial" (
  "oddzial_id" NUMBER(5) PRIMARY KEY,
  "ulica_id" NUMBER(9) NOT NULL,
  "nazwa" VARCHAR2(100) NOT NULL
);

CREATE TABLE "stanowisko" (
  "stanowisko_id" NUMBER(3) PRIMARY KEY,
  "nazwa" VARCHAR2(30) NOT NULL,
  "opis" VARCHAR2(1000) NOT NULL
);

CREATE TABLE "rodzaj_zatrudnienia" (
  "rodzaj_zatrudnienia_id" NUMBER(2) PRIMARY KEY,
  "nazwa" VARCHAR2(50) NOT NULL,
  "opis" VARCHAR2(400) NOT NULL
);

CREATE TABLE "status_pracownika" (
  "status_pracownika_id" NUMBER(2) PRIMARY KEY,
  "nazwa" VARCHAR2(50) NOT NULL,
  "opis" VARCHAR2(400) NOT NULL
);

CREATE TABLE "pracownik" (
  "pracownik_id" NUMBER(9) PRIMARY KEY,
  "stanowisko_id" NUMBER(3) NOT NULL,
  "rodzaj_zatrudnienia_id" NUMBER(2) NOT NULL,
  "status_pracownika_id" NUMBER(2) NOT NULL,
  "imie" VARCHAR2(30) NOT NULL,
  "nazwisko" VARCHAR2(55) NOT NULL,
  "mail" VARCHAR2(100) NOT NULL
);

CREATE TABLE "typ_pracy" (
  "typ_pracy_id" NUMBER(2) PRIMARY KEY,
  "nazwa" VARCHAR2(50) NOT NULL,
  "opis" VARCHAR2(500)
);

CREATE TABLE "zmiana" (
  "zmiana_id" NUMBER(2) PRIMARY KEY,
  "nazwa" VARCHAR2(30) NOT NULL,
  "godzina_rozpoczecia" TIMESTAMP NOT NULL,
  "godzina_zakonczenia" TIMESTAMP NOT NULL
);

CREATE TABLE "status_projektu" (
  "status_projektu_id" NUMBER(2) PRIMARY KEY,
  "nazwa" VARCHAR2(50) NOT NULL,
  "opis" VARCHAR2(400) NOT NULL
);

CREATE TABLE "rodzaj_projektu" (
  "rodzaj_projektu_id" NUMBER(2) PRIMARY KEY,
  "nazwa" VARCHAR2(50) NOT NULL,
  "opis" VARCHAR2(400) NOT NULL
);

CREATE TABLE "projekt" (
  "projekt_id" NUMBER(5) PRIMARY KEY,
  "status_projektu_id" NUMBER(2) NOT NULL,
  "rodzaj_projektu_id" NUMBER(2) NOT NULL,
  "nazwa" VARCHAR2(100) NOT NULL,
  "opis" VARCHAR2(2000) NOT NULL
);

CREATE TABLE "pracownicy_w_projekcie" (
  "pracownik_w_projekcie_id" NUMBER(10) PRIMARY KEY,
  "pracownik_id" NUMBER(9) NOT NULL,
  "projekt_id" NUMBER(5) NOT NULL
);

CREATE TABLE "czas_pracy" (
  "czas_pracy_id" NUMBER(20) PRIMARY KEY,
  "pracownik_w_projekcie_id" NUMBER(10) NOT NULL,
  "oddzial_id" NUMBER(5) NOT NULL,
  "typ_pracy_id" NUMBER(2) NOT NULL,
  "zmiana_id" NUMBER(2) NOT NULL,
  "czas_przepracowany" NUMBER(4,2) NOT NULL,
  "czas_trwania_przerwy" NUMBER(4,2) NOT NULL,
  "godzina_przyjscia_do_pracy" TIMESTAMP NOT NULL,
  "godzina_wyjscia_z_pracy" TIMESTAMP NOT NULL,
  "godziny_rozpoczecia_przerwy" TIMESTAMP,
  "godziny_zakonczenia_przerwy" TIMESTAMP,
  "dzien_miesiaca" NUMBER(2) NOT NULL,
  "miesiac" NUMBER(2) NOT NULL,
  "rok" NUMBER(4) NOT NULL
);

ALTER TABLE "region_panstwa" ADD FOREIGN KEY ("panstwo_id") REFERENCES "panstwo" ("panstwo_id");

ALTER TABLE "miasto" ADD FOREIGN KEY ("region_panstwa_id") REFERENCES "region_panstwa" ("region_panstwa_id");

ALTER TABLE "ulica" ADD FOREIGN KEY ("miasto_id") REFERENCES "miasto" ("miasto_id");

ALTER TABLE "oddzial" ADD FOREIGN KEY ("ulica_id") REFERENCES "ulica" ("ulica_id");

ALTER TABLE "pracownik" ADD FOREIGN KEY ("stanowisko_id") REFERENCES "stanowisko" ("stanowisko_id");

ALTER TABLE "pracownik" ADD FOREIGN KEY ("rodzaj_zatrudnienia_id") REFERENCES "rodzaj_zatrudnienia" ("rodzaj_zatrudnienia_id");

ALTER TABLE "pracownik" ADD FOREIGN KEY ("status_pracownika_id") REFERENCES "status_pracownika" ("status_pracownika_id");

ALTER TABLE "projekt" ADD FOREIGN KEY ("status_projektu_id") REFERENCES "status_projektu" ("status_projektu_id");

ALTER TABLE "projekt" ADD FOREIGN KEY ("rodzaj_projektu_id") REFERENCES "rodzaj_projektu" ("rodzaj_projektu_id");

ALTER TABLE "pracownicy_w_projekcie" ADD FOREIGN KEY ("pracownik_id") REFERENCES "pracownik" ("pracownik_id");

ALTER TABLE "pracownicy_w_projekcie" ADD FOREIGN KEY ("projekt_id") REFERENCES "projekt" ("projekt_id");

ALTER TABLE "czas_pracy" ADD FOREIGN KEY ("pracownik_w_projekcie_id") REFERENCES "pracownicy_w_projekcie" ("pracownik_w_projekcie_id");

ALTER TABLE "czas_pracy" ADD FOREIGN KEY ("oddzial_id") REFERENCES "oddzial" ("oddzial_id");

ALTER TABLE "czas_pracy" ADD FOREIGN KEY ("typ_pracy_id") REFERENCES "typ_pracy" ("typ_pracy_id");

ALTER TABLE "czas_pracy" ADD FOREIGN KEY ("zmiana_id") REFERENCES "zmiana" ("zmiana_id");
