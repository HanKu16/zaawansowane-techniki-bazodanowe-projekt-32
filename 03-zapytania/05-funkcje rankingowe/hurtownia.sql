SELECT
    NVL((SELECT s."nazwa" FROM "status_pracownika_h" s WHERE s."status_pracownika_id" = g."status_pracownika_id"), 'Wszystkie') AS "status",
    NVL((SELECT p."nazwa" FROM "projekt_h" p WHERE p."projekt_id" = g."projekt_id"), 'Wszystkie') AS "projekt",
    NVL((SELECT m."nazwa" FROM "miasto_h" m WHERE m."miasto_id" = g."miasto_id"), 'Wszystkie') AS "miasto",
    g."suma_godzin",
    DENSE_RANK() OVER (PARTITION BY g."status_pracownika_id", g."projekt_id" ORDER BY g."suma_godzin" DESC) AS "ranking_w_grupie"
FROM (
    SELECT
        cp."status_pracownika_id",
        cp."projekt_id",
        cp."miasto_id",
        SUM(cp."czas_przepracowany") AS "suma_godzin"
    FROM "czas_pracy_h" cp
    GROUP BY cp."status_pracownika_id", cp."projekt_id", cp."miasto_id"
) g
ORDER BY "status", "projekt", "ranking_w_grupie";



SELECT 
    NVL((SELECT rz."nazwa" FROM "rodzaj_zatrudnienia_h" rz WHERE rz."rodzaj_zatrudnienia_id" = g."rodzaj_zatrudnienia_id"), 'Wszystkie typy') AS rodzaj_zatrudnienia,
    NVL((SELECT rp."nazwa" FROM "region_panstwa_h" rp WHERE rp."region_panstwa_id" = g."region_panstwa_id"), 'Wszystkie regiony') AS region,
    NVL((SELECT tp."nazwa" FROM "typ_pracy_h" tp WHERE tp."typ_pracy_id" = g."typ_pracy_id"), 'Wszystkie typy') AS typ_pracy,
    (SELECT p."nazwisko" FROM "pracownik_h" p WHERE p."pracownik_id" = g."pracownik_id") AS pracownik,
    g."suma_godzin",
    RANK() OVER (PARTITION BY g."rodzaj_zatrudnienia_id", g."region_panstwa_id" ORDER BY g."suma_godzin" DESC) AS "ranking"
FROM (
    SELECT 
        cp."rodzaj_zatrudnienia_id",
        cp."region_panstwa_id",
        cp."typ_pracy_id",
        cp."pracownik_id",
        SUM(cp."czas_przepracowany") AS "suma_godzin"
    FROM 
        "czas_pracy_h" cp
    GROUP BY cp."rodzaj_zatrudnienia_id", cp."region_panstwa_id",  cp."typ_pracy_id", cp."pracownik_id"
) g
ORDER BY g."rodzaj_zatrudnienia_id", g."region_panstwa_id", "ranking";



SELECT 
    NVL((SELECT p."nazwa" FROM "panstwo_h" p WHERE p."panstwo_id" = g."panstwo_id"), 'Wszystkie kraje') AS kraj,
    NVL((SELECT rz."nazwa" FROM "rodzaj_zatrudnienia_h" rz WHERE rz."rodzaj_zatrudnienia_id" = g."rodzaj_zatrudnienia_id"), 'Wszystkie typy') AS rodzaj_zatrudnienia,
    NVL((SELECT tp."nazwa" FROM "typ_pracy_h" tp WHERE tp."typ_pracy_id" = g."typ_pracy_id"), 'Wszystkie typy') AS typ_pracy,
    (SELECT p."nazwisko" FROM "pracownik_h" p WHERE p."pracownik_id" = g."pracownik_id") AS pracownik,
    g."czas_przepracowany",
    g."czas_przerw",
    g."wspolczynnik_efektywnosci",
    DENSE_RANK() OVER (
        PARTITION BY g."panstwo_id", g."rodzaj_zatrudnienia_id" 
        ORDER BY g."wspolczynnik_efektywnosci" DESC
    ) AS ranking_efektywnosci
FROM (
    SELECT 
        cp."panstwo_id",
        cp."rodzaj_zatrudnienia_id",
        cp."typ_pracy_id",
        cp."pracownik_id",
        SUM(cp."czas_przepracowany") AS "czas_przepracowany",
        SUM(cp."czas_trwania_przerwy") AS "czas_przerw",
        ROUND(
            SUM(cp."czas_przepracowany") / NULLIF(SUM(cp."czas_trwania_przerwy"), 0),
            2
        ) AS "wspolczynnik_efektywnosci"
    FROM "czas_pracy_h" cp
    GROUP BY cp."panstwo_id", cp."rodzaj_zatrudnienia_id", cp."typ_pracy_id", cp."pracownik_id"
) g
WHERE g."czas_przerw" > 0
ORDER BY g."panstwo_id", g."rodzaj_zatrudnienia_id", ranking_efektywnosci;