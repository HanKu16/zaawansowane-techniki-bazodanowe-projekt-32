SELECT
    NVL((SELECT s."nazwa" FROM "stanowisko" s WHERE s."stanowisko_id" = z."stanowisko_id"), 'Nieokreślone') AS "stanowisko",
    NVL((SELECT rp."nazwa" FROM "rodzaj_projektu" rp WHERE rp."rodzaj_projektu_id" = z."rodzaj_projektu_id"), 'Nieokreślone') AS "rodzaj_projektu",
    NVL((SELECT sp."nazwa" FROM "status_pracownika" sp WHERE sp."status_pracownika_id" = z."status_pracownika_id"), 'Nieokreślone') AS "status_pracownika",
    z."suma_czasu",
    z."srednia_dla_stanowiska",
    z."suma_czasu" - z."srednia_dla_stanowiska" AS "roznica_do_sredniej",
    ROUND((z."suma_czasu" / NULLIF(z."srednia_dla_stanowiska", 0)) * 100, 2) AS "procent_sredniej"
FROM (
    SELECT
        p."stanowisko_id",
        pr."rodzaj_projektu_id",
        p."status_pracownika_id",
        SUM(cp."czas_przepracowany") AS "suma_czasu",
        ROUND(AVG(SUM(cp."czas_przepracowany")) OVER (
            PARTITION BY p."stanowisko_id"
        ), 2) AS "srednia_dla_stanowiska"
    FROM "czas_pracy" cp
    JOIN "pracownicy_w_projekcie" pwp ON cp."pracownik_w_projekcie_id" = pwp."pracownik_w_projekcie_id"
    JOIN "pracownik" p ON pwp."pracownik_id" = p."pracownik_id"
    JOIN "projekt" pr ON pwp."projekt_id" = pr."projekt_id"
    GROUP BY p."stanowisko_id", pr."rodzaj_projektu_id", p."status_pracownika_id"
) z
ORDER BY "stanowisko", "rodzaj_projektu", "roznica_do_sredniej" DESC;



SELECT 
    (SELECT rp."nazwa" FROM "region_panstwa" rp WHERE rp."region_panstwa_id" = m."region_panstwa_id") AS "region",
    (SELECT rpj."nazwa" FROM "rodzaj_projektu" rpj WHERE rpj."rodzaj_projektu_id" = p."rodzaj_projektu_id") AS "rodzaj_projektu",
    (SELECT sp."nazwa" FROM "status_pracownika" sp WHERE sp."status_pracownika_id" = pr."status_pracownika_id") AS "status_pracownika",
    SUM(cp."czas_przepracowany") AS "suma_godzin",
    ROUND(AVG(SUM(cp."czas_przepracowany")) OVER (
        PARTITION BY m."region_panstwa_id", p."rodzaj_projektu_id"
    ), 2) AS "średnia_dla_regionu_i_rodzaju",
    SUM(SUM(cp."czas_przepracowany")) OVER (
        PARTITION BY m."region_panstwa_id"
    ) AS "suma_dla_regionu"
FROM 
    "czas_pracy" cp
    JOIN "pracownicy_w_projekcie" pwp ON cp."pracownik_w_projekcie_id" = pwp."pracownik_w_projekcie_id"
    JOIN "projekt" p ON pwp."projekt_id" = p."projekt_id"
    JOIN "pracownik" pr ON pwp."pracownik_id" = pr."pracownik_id"
    JOIN "oddzial" o ON cp."oddzial_id" = o."oddzial_id"
    JOIN "ulica" u ON o."ulica_id" = u."ulica_id"
    JOIN "miasto" m ON u."miasto_id" = m."miasto_id"
GROUP BY m."region_panstwa_id", p."rodzaj_projektu_id", pr."status_pracownika_id"
ORDER BY "region", "rodzaj_projektu", "status_pracownika";



SELECT 
    NVL((SELECT p."nazwa" FROM "panstwo" p WHERE p."panstwo_id" = g."panstwo_id"), 'Wszystkie kraje') AS kraj,
    NVL((SELECT rp."nazwa" FROM "rodzaj_projektu" rp WHERE rp."rodzaj_projektu_id" = g."rodzaj_projektu_id"), 'Wszystkie rodzaje') AS rodzaj_projektu,
    NVL((SELECT rz."nazwa" FROM "rodzaj_zatrudnienia" rz WHERE rz."rodzaj_zatrudnienia_id" = g."rodzaj_zatrudnienia_id"), 'Wszystkie typy') AS rodzaj_zatrudnienia,
    g."suma_godzin",
    g."srednia_dla_kombinacji",
    g."suma_godzin" - g."srednia_dla_kombinacji" AS "roznica_od_sredniej"
FROM (
    SELECT 
        rp."panstwo_id",
        pr."rodzaj_projektu_id",
        p."rodzaj_zatrudnienia_id",
        SUM(cp."czas_przepracowany") AS "suma_godzin",
        AVG(SUM(cp."czas_przepracowany")) OVER (
            PARTITION BY rp."panstwo_id", pr."rodzaj_projektu_id"
        ) AS "srednia_dla_kombinacji"
    FROM 
        "czas_pracy" cp
        JOIN "pracownicy_w_projekcie" pwp ON cp."pracownik_w_projekcie_id" = pwp."pracownik_w_projekcie_id"
        JOIN "pracownik" p ON pwp."pracownik_id" = p."pracownik_id"
        JOIN "projekt" pr ON pwp."projekt_id" = pr."projekt_id"
        JOIN "oddzial" o ON cp."oddzial_id" = o."oddzial_id"
        JOIN "ulica" u ON o."ulica_id" = u."ulica_id"
        JOIN "miasto" m ON u."miasto_id" = m."miasto_id"
        JOIN "region_panstwa" rp ON m."region_panstwa_id" = rp."region_panstwa_id"
    GROUP BY rp."panstwo_id", pr."rodzaj_projektu_id", p."rodzaj_zatrudnienia_id"
) g
ORDER BY g."panstwo_id", g."rodzaj_projektu_id", g."rodzaj_zatrudnienia_id";