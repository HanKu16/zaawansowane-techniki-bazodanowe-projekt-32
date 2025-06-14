INSERT INTO "panstwo_h" ("panstwo_id", "nazwa")
SELECT "panstwo_id", "nazwa" FROM "panstwo";

INSERT INTO "region_panstwa_h" ("region_panstwa_id", "nazwa")
SELECT "region_panstwa_id", "nazwa" FROM "region_panstwa";

INSERT INTO "miasto_h" ("miasto_id", "nazwa")
SELECT "miasto_id", "nazwa" FROM "miasto";

INSERT INTO "ulica_h" ("ulica_id", "nazwa")
SELECT "ulica_id", "nazwa" FROM "ulica";

INSERT INTO "oddzial_h" ("oddzial_id", "nazwa")
SELECT "oddzial_id", "nazwa" FROM "oddzial";

INSERT INTO "stanowisko_h" ("stanowisko_id", "nazwa")
SELECT "stanowisko_id", "nazwa" FROM "stanowisko";

INSERT INTO "rodzaj_zatrudnienia_h" ("rodzaj_zatrudnienia_id", "nazwa")
SELECT "rodzaj_zatrudnienia_id", "nazwa" FROM "rodzaj_zatrudnienia";

INSERT INTO "status_pracownika_h" ("status_pracownika_id", "nazwa")
SELECT "status_pracownika_id", "nazwa" FROM "status_pracownika";

INSERT INTO "pracownik_h" ("pracownik_id", "nazwisko")
SELECT "pracownik_id", "nazwisko" FROM "pracownik";

INSERT INTO "typ_pracy_h" ("typ_pracy_id", "nazwa")
SELECT "typ_pracy_id", "nazwa" FROM "typ_pracy";

INSERT INTO "zmiana_h" ("zmiana_id", "nazwa")
SELECT "zmiana_id", "nazwa" FROM "zmiana";

INSERT INTO "status_projektu_h" ("status_projektu_id", "nazwa")
SELECT "status_projektu_id", "nazwa" FROM "status_projektu";

INSERT INTO "rodzaj_projektu_h" ("rodzaj_projektu_id", "nazwa")
SELECT "rodzaj_projektu_id", "nazwa" FROM "rodzaj_projektu";

INSERT INTO "projekt_h" ("projekt_id", "nazwa")
SELECT "projekt_id", "nazwa" FROM "projekt";

INSERT INTO "dzien_miesiaca_h" ("dzien_miesiaca_id", "opis")
SELECT DISTINCT "dzien_miesiaca", 'Dzień ' || "dzien_miesiaca" FROM "czas_pracy";

INSERT INTO "miesiac_h" ("miesiac_id", "opis")
SELECT DISTINCT "miesiac", 
       CASE "miesiac"
         WHEN 1 THEN 'Styczeń'
         WHEN 2 THEN 'Luty'
         WHEN 3 THEN 'Marzec'
         WHEN 4 THEN 'Kwiecień'
         WHEN 5 THEN 'Maj'
         WHEN 6 THEN 'Czerwiec'
         WHEN 7 THEN 'Lipiec'
         WHEN 8 THEN 'Sierpień'
         WHEN 9 THEN 'Wrzesień'
         WHEN 10 THEN 'Październik'
         WHEN 11 THEN 'Listopad'
         WHEN 12 THEN 'Grudzień'
       END
FROM "czas_pracy";

INSERT INTO "rok_h" ("rok_id", "opis")
SELECT DISTINCT "rok", 'Rok ' || "rok" FROM "czas_pracy";

INSERT INTO "czas_pracy_h" (
  "czas_pracy_id",
  "pracownik_id",
  "stanowisko_id",
  "rodzaj_zatrudnienia_id",
  "status_pracownika_id",
  "projekt_id",
  "status_projektu_id",
  "rodzaj_projektu_id",
  "oddzial_id",
  "ulica_id",
  "miasto_id",
  "region_panstwa_id",
  "panstwo_id",
  "typ_pracy_id",
  "zmiana_id",
  "dzien_miesiaca_id",
  "miesiac_id",
  "rok_id",
  "czas_przepracowany",
  "czas_trwania_przerwy",
  "godzina_przyjscia_do_pracy",
  "godzina_wyjscia_z_pracy",
  "godziny_rozpoczecia_przerwy",
  "godziny_zakonczenia_przerwy"
)
SELECT 
  cp."czas_pracy_id",
  p."pracownik_id",
  p."stanowisko_id",
  p."rodzaj_zatrudnienia_id",
  p."status_pracownika_id",
  pr."projekt_id",
  pr."status_projektu_id",
  pr."rodzaj_projektu_id",
  o."oddzial_id",
  u."ulica_id",
  m."miasto_id",
  rp."region_panstwa_id",
  pa."panstwo_id",
  cp."typ_pracy_id",
  cp."zmiana_id",
  cp."dzien_miesiaca",
  cp."miesiac",
  cp."rok",
  cp."czas_przepracowany",
  cp."czas_trwania_przerwy",
  cp."godzina_przyjscia_do_pracy",
  cp."godzina_wyjscia_z_pracy",
  cp."godziny_rozpoczecia_przerwy",
  cp."godziny_zakonczenia_przerwy"
FROM "czas_pracy" cp
JOIN "pracownicy_w_projekcie" pwp ON cp."pracownik_w_projekcie_id" = pwp."pracownik_w_projekcie_id"
JOIN "pracownik" p ON pwp."pracownik_id" = p."pracownik_id"
JOIN "projekt" pr ON pwp."projekt_id" = pr."projekt_id"
JOIN "oddzial" o ON cp."oddzial_id" = o."oddzial_id"
JOIN "ulica" u ON o."ulica_id" = u."ulica_id"
JOIN "miasto" m ON u."miasto_id" = m."miasto_id"
JOIN "region_panstwa" rp ON m."region_panstwa_id" = rp."region_panstwa_id"
JOIN "panstwo" pa ON rp."panstwo_id" = pa."panstwo_id";