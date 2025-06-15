--Raport sumarycznego i średniego czasu pracy pogrupowany według rodzaju projektu, typu pracy i stanowiska.
SELECT
    NVL((SELECT rp."nazwa" FROM "rodzaj_projektu_h" rp WHERE rp."rodzaj_projektu_id" = g."rodzaj_projektu_id"), 'Wszystkie rodzaje') AS "rodzaj_projektu",
    NVL((SELECT tp."nazwa" FROM "typ_pracy_h" tp WHERE tp."typ_pracy_id" = g."typ_pracy_id"), 'Wszystkie typy') AS "typ_pracy",
    NVL((SELECT s."nazwa" FROM "stanowisko_h" s WHERE s."stanowisko_id" = g."stanowisko_id"), 'Wszystkie stanowiska') AS "stanowisko",
    g."suma_godzin" AS "laczny_czas_pracy",
    g."srednia_godzin" AS "sredni_czas_pracy"
FROM (
    SELECT
        cp."rodzaj_projektu_id",
        cp."typ_pracy_id",
        cp."stanowisko_id",
        SUM(cp."czas_przepracowany") AS "suma_godzin",
        ROUND(AVG(cp."czas_przepracowany"), 2) AS "srednia_godzin"
    FROM "czas_pracy_h" cp
    GROUP BY ROLLUP(cp."rodzaj_projektu_id", cp."typ_pracy_id", cp."stanowisko_id")
) g
ORDER BY "rodzaj_projektu", "typ_pracy", "stanowisko";


--Raport średniego czasu pracy pogrupowany według kraju, statusu projektu i zmiany.
SELECT 
    NVL((SELECT pa."nazwa" FROM "panstwo_h" pa WHERE pa."panstwo_id" = g."panstwo_id"), 'Wszystkie kraje') AS "kraj",
    NVL((SELECT sp."nazwa" FROM "status_projektu_h" sp WHERE sp."status_projektu_id" = g."status_projektu_id"), 'Wszystkie statusy') AS "status_projektu",
    NVL((SELECT z."nazwa" FROM "zmiana_h" z WHERE z."zmiana_id" = g."zmiana_id"), 'Wszystkie zmiany') AS "zmiana",
    g."srednia_godzin" AS "średnia_godzin"
FROM (
    SELECT
        cp."panstwo_id",
        cp."status_projektu_id",
        cp."zmiana_id",
        ROUND(AVG(cp."czas_przepracowany"), 2) AS "srednia_godzin"
    FROM "czas_pracy_h" cp
    GROUP BY ROLLUP(cp."panstwo_id", cp."status_projektu_id", cp."zmiana_id")
) g
ORDER BY "kraj", "status_projektu", "zmiana";


--Raport sumy godzin pracy pogrupowany według statusu pracownika, rodzaju zatrudnienia i rodzaju projektu.
SELECT 
    NVL((SELECT sp."nazwa" FROM "status_pracownika_h" sp WHERE sp."status_pracownika_id" = g."status_pracownika_id"), 'Wszystkie statusy') AS "status_pracownika",
    NVL((SELECT rz."nazwa" FROM "rodzaj_zatrudnienia_h" rz WHERE rz."rodzaj_zatrudnienia_id" = g."rodzaj_zatrudnienia_id"), 'Wszystkie rodzaje') AS "rodzaj_zatrudnienia",
    NVL((SELECT rp."nazwa" FROM "rodzaj_projektu_h" rp WHERE rp."rodzaj_projektu_id" = g."rodzaj_projektu_id"), 'Wszystkie typy') AS "rodzaj_projektu",
    g."suma_godzin" AS "Suma godzin"
FROM (
    SELECT
        cp."status_pracownika_id",
        cp."rodzaj_zatrudnienia_id",
        cp."rodzaj_projektu_id",
        SUM(cp."czas_przepracowany") AS "suma_godzin"
    FROM "czas_pracy_h" cp
    GROUP BY ROLLUP(cp."status_pracownika_id", cp."rodzaj_zatrudnienia_id", cp."rodzaj_projektu_id")
) g
ORDER BY "status_pracownika", "rodzaj_zatrudnienia", "rodzaj_projektu";
