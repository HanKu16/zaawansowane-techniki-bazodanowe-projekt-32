SELECT
    NVL((SELECT s."nazwa" FROM "status_pracownika" s WHERE s."status_pracownika_id" = g."status_pracownika_id"), 'Wszystkie') AS "status",
    NVL((SELECT p."nazwa" FROM "projekt" p WHERE p."projekt_id" = g."projekt_id"), 'Wszystkie') AS "projekt",
    NVL((SELECT m."nazwa" FROM "miasto" m WHERE m."miasto_id" = g."miasto_id"), 'Wszystkie') AS "miasto",
    g."suma_godzin",
    DENSE_RANK() OVER (PARTITION BY g."status_pracownika_id", g."projekt_id" ORDER BY g."suma_godzin" DESC) AS "ranking_w_grupie"
FROM (
    SELECT
        p."status_pracownika_id",
        pr."projekt_id",
        m."miasto_id",
        SUM(cp."czas_przepracowany") AS "suma_godzin"
    FROM
        "czas_pracy" cp
        JOIN "pracownicy_w_projekcie" pwp ON cp."pracownik_w_projekcie_id" = pwp."pracownik_w_projekcie_id"
        JOIN "projekt" pr ON pwp."projekt_id" = pr."projekt_id"
        JOIN "pracownik" p ON pwp."pracownik_id" = p."pracownik_id"
        JOIN "oddzial" o ON cp."oddzial_id" = o."oddzial_id"
        JOIN "ulica" u ON o."ulica_id" = u."ulica_id"
        JOIN "miasto" m ON u."miasto_id" = m."miasto_id"
    GROUP BY p."status_pracownika_id", pr."projekt_id", m."miasto_id"
) g
ORDER BY "status", "projekt", "ranking_w_grupie";




SELECT 
    NVL((SELECT rz."nazwa" FROM "rodzaj_zatrudnienia" rz WHERE rz."rodzaj_zatrudnienia_id" = g."rodzaj_zatrudnienia_id"), 'Wszystkie typy') AS rodzaj_zatrudnienia,
    NVL((SELECT rp."nazwa" FROM "region_panstwa" rp WHERE rp."region_panstwa_id" = g."region_panstwa_id"), 'Wszystkie regiony') AS region,
    NVL((SELECT tp."nazwa" FROM "typ_pracy" tp WHERE tp."typ_pracy_id" = g."typ_pracy_id"), 'Wszystkie typy') AS typ_pracy,
    (SELECT p."imie" || ' ' || p."nazwisko" FROM "pracownik" p WHERE p."pracownik_id" = g."pracownik_id") AS pracownik,
    g."suma_godzin",
    RANK() OVER (PARTITION BY g."rodzaj_zatrudnienia_id", g."region_panstwa_id" ORDER BY g."suma_godzin" DESC) AS "ranking"
FROM (
    SELECT 
        p."rodzaj_zatrudnienia_id",
        m."region_panstwa_id",
        cp."typ_pracy_id",
        p."pracownik_id",
        SUM(cp."czas_przepracowany") AS "suma_godzin"
    FROM 
        "czas_pracy" cp
        JOIN "pracownicy_w_projekcie" pwp ON cp."pracownik_w_projekcie_id" = pwp."pracownik_w_projekcie_id"
        JOIN "pracownik" p ON pwp."pracownik_id" = p."pracownik_id"
        JOIN "oddzial" o ON cp."oddzial_id" = o."oddzial_id"
        JOIN "ulica" u ON o."ulica_id" = u."ulica_id"
        JOIN "miasto" m ON u."miasto_id" = m."miasto_id"
        JOIN "typ_pracy" tp ON cp."typ_pracy_id" = tp."typ_pracy_id"
    GROUP BY p."rodzaj_zatrudnienia_id", m."region_panstwa_id",  cp."typ_pracy_id", p."pracownik_id"
) g
ORDER BY g."rodzaj_zatrudnienia_id", g."region_panstwa_id", "ranking";



SELECT 
    NVL((SELECT p."nazwa" FROM "panstwo" p WHERE p."panstwo_id" = g."panstwo_id"), 'Wszystkie kraje') AS kraj,
    NVL((SELECT rz."nazwa" FROM "rodzaj_zatrudnienia" rz WHERE rz."rodzaj_zatrudnienia_id" = g."rodzaj_zatrudnienia_id"), 'Wszystkie typy') AS rodzaj_zatrudnienia,
    NVL((SELECT tp."nazwa" FROM "typ_pracy" tp WHERE tp."typ_pracy_id" = g."typ_pracy_id"), 'Wszystkie typy') AS typ_pracy,
    (SELECT p."imie" || ' ' || p."nazwisko" FROM "pracownik" p WHERE p."pracownik_id" = g."pracownik_id") AS pracownik,
    g."czas_przepracowany",
    g."czas_przerw",
    ROUND(g."czas_przepracowany" / NULLIF(g."czas_przerw", 0), 2) AS wspolczynnik_efektywnosci,
    DENSE_RANK() OVER (
        PARTITION BY g."panstwo_id", g."rodzaj_zatrudnienia_id" 
        ORDER BY ROUND(g."czas_przepracowany" / NULLIF(g."czas_przerw", 0), 2) DESC
    ) AS ranking_efektywnosci
FROM (
    SELECT 
        rp."panstwo_id",
        p."rodzaj_zatrudnienia_id",
        cp."typ_pracy_id",
        p."pracownik_id",
        SUM(cp."czas_przepracowany") AS "czas_przepracowany",
        SUM(cp."czas_trwania_przerwy") AS "czas_przerw"
    FROM 
        "czas_pracy" cp
        JOIN "pracownicy_w_projekcie" pwp ON cp."pracownik_w_projekcie_id" = pwp."pracownik_w_projekcie_id"
        JOIN "pracownik" p ON pwp."pracownik_id" = p."pracownik_id"
        JOIN "oddzial" o ON cp."oddzial_id" = o."oddzial_id"
        JOIN "ulica" u ON o."ulica_id" = u."ulica_id"
        JOIN "miasto" m ON u."miasto_id" = m."miasto_id"
        JOIN "region_panstwa" rp ON m."region_panstwa_id" = rp."region_panstwa_id"
        JOIN "typ_pracy" tp ON cp."typ_pracy_id" = tp."typ_pracy_id"
    GROUP BY rp."panstwo_id", p."rodzaj_zatrudnienia_id", cp."typ_pracy_id", p."pracownik_id"
) g
WHERE g."czas_przerw" > 0
ORDER BY g."panstwo_id", g."rodzaj_zatrudnienia_id", ranking_efektywnosci;