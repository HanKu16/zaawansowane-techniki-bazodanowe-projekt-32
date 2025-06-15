--Porównanie miesięcznego czasu pracy ze średnią 3-miesięczną ze względu na stanowisko, oddział i rodzaj projektu.
SELECT
    NVL((SELECT s."nazwa" FROM "stanowisko_h" s WHERE s."stanowisko_id" = z."stanowisko_id"), 'Nieokreślone') AS stanowisko,
    NVL((SELECT rp."nazwa" FROM "rodzaj_projektu_h" rp WHERE rp."rodzaj_projektu_id" = z."rodzaj_projektu_id"), 'Nieokreślone') AS rodzaj_projektu,
    NVL((SELECT o."nazwa" FROM "oddzial_h" o WHERE o."oddzial_id" = z."oddzial_id"), 'Nieokreślone') AS oddzial,
    z."suma_czasu",
    z."srednia_3_miesiace",
    z."suma_czasu" - z."srednia_3_miesiace" AS "roznica_do_sredniej",
    ROUND((z."suma_czasu" / NULLIF(z."srednia_3_miesiace", 0)) * 100, 2) AS "procent_sredniej",
    z."rok",
    z."miesiac"
FROM (
    SELECT
        cp."stanowisko_id",
        cp."rodzaj_projektu_id",
        cp."oddzial_id",
        cp."rok_id" AS "rok",
        cp."miesiac_id" AS "miesiac",
        SUM(cp."czas_przepracowany") AS "suma_czasu",
        ROUND(AVG(SUM(cp."czas_przepracowany")) OVER (
            PARTITION BY cp."stanowisko_id", cp."rodzaj_projektu_id"
            ORDER BY cp."rok_id", cp."miesiac_id"
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2) AS "srednia_3_miesiace"
    FROM "czas_pracy_h" cp
    GROUP BY cp."stanowisko_id", cp."rodzaj_projektu_id", cp."oddzial_id", cp."rok_id", cp."miesiac_id"
) z
ORDER BY stanowisko, oddzial, rodzaj_projektu, z."rok", z."miesiac";


--Analiza średniej kroczącej czasu pracy dla rodzaju projektu, statusu projektu i kraju (3 miesiące).
SELECT 
    NVL((SELECT rp."nazwa" FROM "rodzaj_projektu_h" rp WHERE rp."rodzaj_projektu_id" = g."rodzaj_projektu_id"), 'Wszystkie rodzaje') AS rodzaj_projektu,
    NVL((SELECT sp."nazwa" FROM "status_projektu_h" sp WHERE sp."status_projektu_id" = g."status_projektu_id"), 'Wszystkie statusy') AS status_projektu,
    NVL((SELECT p."nazwa" FROM "panstwo_h" p WHERE p."panstwo_id" = g."panstwo_id"), 'Wszystkie kraje') AS kraj,
    g."rok",
    g."miesiac",
    g."suma_godzin",
    g."srednia_kroczaca_3miesiace"
FROM (
    SELECT 
        cp."rodzaj_projektu_id",
        cp."status_projektu_id",
        cp."panstwo_id",
        cp."rok_id" AS "rok",
        cp."miesiac_id" AS "miesiac",
        SUM(cp."czas_przepracowany") AS "suma_godzin",
        ROUND(AVG(SUM(cp."czas_przepracowany")) OVER (
            PARTITION BY cp."rodzaj_projektu_id", cp."status_projektu_id", cp."panstwo_id"
            ORDER BY cp."rok_id", cp."miesiac_id"
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2) AS "srednia_kroczaca_3miesiace"
    FROM "czas_pracy_h" cp
    GROUP BY cp."rodzaj_projektu_id", cp."status_projektu_id", cp."panstwo_id", cp."rok_id", cp."miesiac_id"
) g
ORDER BY g."rodzaj_projektu_id", g."status_projektu_id", g."panstwo_id", g."rok", g."miesiac";


--Raport średniej krocząca czasu przerwy dla typu zatrudnienia, regionu i miesiaca (3 miesiące).
SELECT 
    NVL((SELECT rz."nazwa" FROM "rodzaj_zatrudnienia_h" rz WHERE rz."rodzaj_zatrudnienia_id" = g."rodzaj_zatrudnienia_id"), 'Wszystkie typy') AS rodzaj_zatrudnienia,
    NVL((SELECT rp."nazwa" FROM "region_panstwa_h" rp WHERE rp."region_panstwa_id" = g."region_panstwa_id"), 'Wszystkie regiony') AS region,
    g."rok",
    g."miesiac",
    g."srednia_przerwa",
    g."srednia_kroczaca_3m"
FROM (
    SELECT 
        cp."rodzaj_zatrudnienia_id",
        cp."region_panstwa_id",
        cp."rok_id" AS "rok",
        cp."miesiac_id" AS "miesiac",
        ROUND(AVG(cp."czas_trwania_przerwy"), 2) AS "srednia_przerwa",
        ROUND(AVG(AVG(cp."czas_trwania_przerwy")) OVER (
            PARTITION BY cp."rodzaj_zatrudnienia_id", cp."region_panstwa_id"
            ORDER BY cp."rok_id", cp."miesiac_id"
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2) AS "srednia_kroczaca_3m"
    FROM 
        "czas_pracy_h" cp
    GROUP BY cp."rodzaj_zatrudnienia_id", cp."region_panstwa_id", cp."rok_id", cp."miesiac_id"
) g
ORDER BY g."rodzaj_zatrudnienia_id", g."region_panstwa_id", g."rok", g."miesiac";