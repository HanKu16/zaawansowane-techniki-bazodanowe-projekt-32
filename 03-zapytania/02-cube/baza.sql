--Analiza łącznego czas pracy według kraju, statusu projektu i rodzaju zatrudnienia
SELECT
    NVL((SELECT p."nazwa" FROM "panstwo" p WHERE p."panstwo_id" = g."panstwo_id"), 'Wszystkie kraje') AS "kraj",
    NVL((SELECT sp."nazwa" FROM "status_projektu" sp WHERE sp."status_projektu_id" = g."status_projektu_id"), 'Wszystkie statusy') AS "status_projektu",
    NVL((SELECT rz."nazwa" FROM "rodzaj_zatrudnienia" rz WHERE rz."rodzaj_zatrudnienia_id" = g."rodzaj_zatrudnienia_id"), 'Wszystkie zatrudnienia') AS "rodzaj_zatrudnienia",
    g."suma_godzin" AS "laczny_czas_pracy"
FROM (
    SELECT
        rp."panstwo_id",
        pr."status_projektu_id",
        p."rodzaj_zatrudnienia_id",
        SUM(cp."czas_przepracowany") AS "suma_godzin"
    FROM
        "czas_pracy" cp
        JOIN "pracownicy_w_projekcie" pwp ON cp."pracownik_w_projekcie_id" = pwp."pracownik_w_projekcie_id"
        JOIN "projekt" pr ON pwp."projekt_id" = pr."projekt_id"
        JOIN "pracownik" p ON pwp."pracownik_id" = p."pracownik_id"
        JOIN "oddzial" o ON cp."oddzial_id" = o."oddzial_id"
        JOIN "ulica" u ON o."ulica_id" = u."ulica_id"
        JOIN "miasto" m ON u."miasto_id" = m."miasto_id"
        JOIN "region_panstwa" rp ON m."region_panstwa_id" = rp."region_panstwa_id"
    GROUP BY CUBE(rp."panstwo_id", pr."status_projektu_id", p."rodzaj_zatrudnienia_id")
) g
ORDER BY "kraj", "status_projektu", "rodzaj_zatrudnienia";


--Analiza liczby pracowników według typu pracy, statusu pracownika i rodzaju projektu.
SELECT 
    NVL((SELECT tp."nazwa" FROM "typ_pracy" tp WHERE tp."typ_pracy_id" = g."typ_pracy_id"), 'Wszystkie typy') AS "typ_pracy",
    NVL((SELECT sp."nazwa" FROM "status_pracownika" sp WHERE sp."status_pracownika_id" = g."status_pracownika_id"), 'Wszystkie statusy') AS "status_pracownika",
    NVL((SELECT rp."nazwa" FROM "rodzaj_projektu" rp WHERE rp."rodzaj_projektu_id" = g."rodzaj_projektu_id"), 'Wszystkie rodzaje') AS "rodzaj_projektu",
    g."liczba_pracownikow" AS "liczba_pracowników"
FROM (
    SELECT
        cp."typ_pracy_id",
        p."status_pracownika_id",
        pr."rodzaj_projektu_id",
        COUNT(DISTINCT p."pracownik_id") AS "liczba_pracownikow"
    FROM
        "czas_pracy" cp
        JOIN "pracownicy_w_projekcie" pwp ON cp."pracownik_w_projekcie_id" = pwp."pracownik_w_projekcie_id"
        JOIN "pracownik" p ON pwp."pracownik_id" = p."pracownik_id"
        JOIN "projekt" pr ON pwp."projekt_id" = pr."projekt_id"
    GROUP BY CUBE(cp."typ_pracy_id", p."status_pracownika_id", pr."rodzaj_projektu_id")
) g
ORDER BY "typ_pracy", "status_pracownika", "rodzaj_projektu";


--Raport o sumie czasu przerw według regionu państwa, stanowiska i typu pracy.
SELECT 
    NVL((SELECT rp."nazwa" FROM "region_panstwa" rp WHERE rp."region_panstwa_id" = g."region_panstwa_id"), 'Wszystkie regiony') AS "region_panstwa",
    NVL((SELECT s."nazwa" FROM "stanowisko" s WHERE s."stanowisko_id" = g."stanowisko_id"), 'Wszystkie stanowiska') AS "stanowisko",
    NVL((SELECT tp."nazwa" FROM "typ_pracy" tp WHERE tp."typ_pracy_id" = g."typ_pracy_id"), 'Wszystkie typy pracy') AS "typ_pracy",
    g."suma_przerw" AS "Suma przerw"
FROM (
    SELECT
        m."region_panstwa_id",
        p."stanowisko_id",
        tp."typ_pracy_id",
        SUM(cp."czas_trwania_przerwy") AS "suma_przerw"
    FROM
        "czas_pracy" cp
        JOIN "pracownicy_w_projekcie" pwp ON cp."pracownik_w_projekcie_id" = pwp."pracownik_w_projekcie_id"
        JOIN "pracownik" p ON pwp."pracownik_id" = p."pracownik_id"
        JOIN "oddzial" o ON cp."oddzial_id" = o."oddzial_id"
        JOIN "ulica" u ON o."ulica_id" = u."ulica_id"
        JOIN "miasto" m ON u."miasto_id" = m."miasto_id"
        JOIN "typ_pracy" tp ON tp."typ_pracy_id" = cp."typ_pracy_id"
    GROUP BY CUBE(m."region_panstwa_id", p."stanowisko_id", tp."typ_pracy_id")
) g
ORDER BY "region_panstwa", "stanowisko", "typ_pracy";