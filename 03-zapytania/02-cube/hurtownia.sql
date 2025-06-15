--Analiza łącznego czas pracy według kraju, statusu projektu i rodzaju zatrudnienia
SELECT
    NVL((SELECT p."nazwa" FROM "panstwo_h" p WHERE p."panstwo_id" = g."panstwo_id"), 'Wszystkie kraje') AS "kraj",
    NVL((SELECT sp."nazwa" FROM "status_projektu_h" sp WHERE sp."status_projektu_id" = g."status_projektu_id"), 'Wszystkie statusy') AS "status_projektu",
    NVL((SELECT rz."nazwa" FROM "rodzaj_zatrudnienia_h" rz WHERE rz."rodzaj_zatrudnienia_id" = g."rodzaj_zatrudnienia_id"), 'Wszystkie zatrudnienia') AS "rodzaj_zatrudnienia",
    g."suma_godzin" AS "laczny_czas_pracy"
FROM (
    SELECT
        cp."panstwo_id",
        cp."status_projektu_id",
        cp."rodzaj_zatrudnienia_id",
        SUM(cp."czas_przepracowany") AS "suma_godzin"
    FROM "czas_pracy_h" cp
    GROUP BY CUBE(cp."panstwo_id", cp."status_projektu_id", cp."rodzaj_zatrudnienia_id")
) g
ORDER BY "kraj", "status_projektu", "rodzaj_zatrudnienia";


--Analiza liczby pracowników według typu pracy, statusu pracownika i rodzaju projektu.
SELECT 
    NVL((SELECT tp."nazwa" FROM "typ_pracy_h" tp WHERE tp."typ_pracy_id" = g."typ_pracy_id"), 'Wszystkie typy') AS "typ_pracy",
    NVL((SELECT sp."nazwa" FROM "status_pracownika_h" sp WHERE sp."status_pracownika_id" = g."status_pracownika_id"), 'Wszystkie statusy') AS "status_pracownika",
    NVL((SELECT rp."nazwa" FROM "rodzaj_projektu_h" rp WHERE rp."rodzaj_projektu_id" = g."rodzaj_projektu_id"), 'Wszystkie rodzaje') AS "rodzaj_projektu",
    g."liczba_pracownikow" AS "liczba_pracowników"
FROM (
    SELECT
        cp."typ_pracy_id",
        cp."status_pracownika_id",
        cp."rodzaj_projektu_id",
        COUNT(DISTINCT cp."pracownik_id") AS "liczba_pracownikow"
    FROM "czas_pracy_h" cp
    GROUP BY CUBE(cp."typ_pracy_id", cp."status_pracownika_id", cp."rodzaj_projektu_id")
) g
ORDER BY "typ_pracy", "status_pracownika", "rodzaj_projektu";


--Raport o sumie czasu przerw według regionu państwa, stanowiska i typu pracy.
SELECT 
    NVL((SELECT rp."nazwa" FROM "region_panstwa_h" rp WHERE rp."region_panstwa_id" = g."region_panstwa_id"), 'Wszystkie regiony') AS "region_panstwa",
    NVL((SELECT s."nazwa" FROM "stanowisko_h" s WHERE s."stanowisko_id" = g."stanowisko_id"), 'Wszystkie stanowiska') AS "stanowisko",
    NVL((SELECT tp."nazwa" FROM "typ_pracy_h" tp WHERE tp."typ_pracy_id" = g."typ_pracy_id"), 'Wszystkie typy pracy') AS "typ_pracy",
    g."suma_przerw" AS "Suma przerw"
FROM (
    SELECT
        cp."region_panstwa_id",
        cp."stanowisko_id",
        cp."typ_pracy_id",
        SUM(cp."czas_trwania_przerwy") AS "suma_przerw"
    FROM "czas_pracy_h" cp
    GROUP BY CUBE(cp."region_panstwa_id", cp."stanowisko_id", cp."typ_pracy_id")
) g
ORDER BY "region_panstwa", "stanowisko", "typ_pracy";