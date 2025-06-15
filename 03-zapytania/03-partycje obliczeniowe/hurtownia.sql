--Porównanie sumarycznego czasu pracy według stanowiska, rodzaju projektu i statusu pracownika do średniego dla danego stanowiska.
SELECT
    NVL((SELECT s."nazwa" FROM "stanowisko_h" s WHERE s."stanowisko_id" = z."stanowisko_id"), 'Nieokreślone') AS "stanowisko",
    NVL((SELECT rp."nazwa" FROM "rodzaj_projektu_h" rp WHERE rp."rodzaj_projektu_id" = z."rodzaj_projektu_id"), 'Nieokreślone') AS "rodzaj_projektu",
    NVL((SELECT sp."nazwa" FROM "status_pracownika_h" sp WHERE sp."status_pracownika_id" = z."status_pracownika_id"), 'Nieokreślone') AS "status_pracownika",
    z."suma_czasu",
    z."srednia_dla_stanowiska",
    z."roznica_do_sredniej",
    z."procent_sredniej"
FROM (
    SELECT
        cp."stanowisko_id",
        cp."rodzaj_projektu_id",
        cp."status_pracownika_id",
        SUM(cp."czas_przepracowany") AS "suma_czasu",
        ROUND(AVG(SUM(cp."czas_przepracowany")) OVER (PARTITION BY cp."stanowisko_id"), 2) AS "srednia_dla_stanowiska",
        SUM(cp."czas_przepracowany") - ROUND(AVG(SUM(cp."czas_przepracowany")) OVER (PARTITION BY cp."stanowisko_id"), 2) AS "roznica_do_sredniej",
        ROUND((SUM(cp."czas_przepracowany") / NULLIF(ROUND(AVG(SUM(cp."czas_przepracowany")) OVER (PARTITION BY cp."stanowisko_id"), 2), 0)) * 100, 2) AS "procent_sredniej"
    FROM "czas_pracy_h" cp
    GROUP BY cp."stanowisko_id", cp."rodzaj_projektu_id", cp."status_pracownika_id"
) z
ORDER BY "stanowisko", "rodzaj_projektu", "roznica_do_sredniej" DESC;


--Porównanie czasu pracy według regionu, rodzaju projektu i statusu pracownika
SELECT 
    NVL((SELECT rp."nazwa" FROM "region_panstwa_h" rp WHERE rp."region_panstwa_id" = z."region_panstwa_id"), 'Nieokreślony') AS "region",
    NVL((SELECT rpj."nazwa" FROM "rodzaj_projektu_h" rpj WHERE rpj."rodzaj_projektu_id" = z."rodzaj_projektu_id"), 'Nieokreślony') AS "rodzaj_projektu",
    NVL((SELECT sp."nazwa" FROM "status_pracownika_h" sp WHERE sp."status_pracownika_id" = z."status_pracownika_id"), 'Nieokreślony') AS "status_pracownika",
    z."suma_godzin",
    z."srednia_dla_regionu_i_rodzaju",
    z."suma_dla_regionu"
FROM (
    SELECT
        cp."region_panstwa_id",
        cp."rodzaj_projektu_id",
        cp."status_pracownika_id",
        SUM(cp."czas_przepracowany") AS "suma_godzin",
        ROUND(AVG(SUM(cp."czas_przepracowany")) OVER (
            PARTITION BY cp."region_panstwa_id", cp."rodzaj_projektu_id"
        ), 2) AS "srednia_dla_regionu_i_rodzaju",
        SUM(SUM(cp."czas_przepracowany")) OVER (
            PARTITION BY cp."region_panstwa_id"
        ) AS "suma_dla_regionu"
    FROM "czas_pracy_h" cp
    GROUP BY cp."region_panstwa_id", cp."rodzaj_projektu_id", cp."status_pracownika_id"
) z
ORDER BY "region", "rodzaj_projektu", "status_pracownika";


--Porównanie łącznego czasu pracy ze średnią według kraju, typu projektu i rodzaju zatrudnienia.
SELECT 
    NVL((SELECT p."nazwa" FROM "panstwo_h" p WHERE p."panstwo_id" = g."panstwo_id"), 'Wszystkie kraje') AS kraj,
    NVL((SELECT rp."nazwa" FROM "rodzaj_projektu_h" rp WHERE rp."rodzaj_projektu_id" = g."rodzaj_projektu_id"), 'Wszystkie rodzaje') AS rodzaj_projektu,
    NVL((SELECT rz."nazwa" FROM "rodzaj_zatrudnienia_h" rz WHERE rz."rodzaj_zatrudnienia_id" = g."rodzaj_zatrudnienia_id"), 'Wszystkie typy') AS rodzaj_zatrudnienia,
    g."suma_godzin",
    g."srednia_dla_kombinacji",
    g."roznica_od_sredniej"
FROM (
    SELECT 
        cp."panstwo_id",
        cp."rodzaj_projektu_id",
        cp."rodzaj_zatrudnienia_id",
        SUM(cp."czas_przepracowany") AS "suma_godzin",
        ROUND(AVG(SUM(cp."czas_przepracowany")) OVER (
            PARTITION BY cp."panstwo_id", cp."rodzaj_projektu_id"
        ), 2) AS "srednia_dla_kombinacji",
        SUM(cp."czas_przepracowany") - ROUND(AVG(SUM(cp."czas_przepracowany")) OVER (
            PARTITION BY cp."panstwo_id", cp."rodzaj_projektu_id"
        ), 2) AS "roznica_od_sredniej"
    FROM "czas_pracy_h" cp
    GROUP BY cp."panstwo_id", cp."rodzaj_projektu_id", cp."rodzaj_zatrudnienia_id"
) g
ORDER BY kraj, rodzaj_projektu, rodzaj_zatrudnienia;