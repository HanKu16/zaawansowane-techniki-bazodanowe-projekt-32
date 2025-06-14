@echo off
REM Rozpoczynam ładowanie danych do Oracle DB z kontenera Dockera.

REM Parametry połączenia:
set ORACLE_USER=system
set ORACLE_PASS=oracle
set ORACLE_HOST=localhost
set ORACLE_PORT=1521
set ORACLE_SID=ORCLCDB

set ORACLE_CONN=%ORACLE_USER%/%ORACLE_PASS%@%ORACLE_HOST%:%ORACLE_PORT%/%ORACLE_SID%

echo Ładowanie danych do bazy danych Oracle (%ORACLE_CONN%)...

REM Ładowanie plików .ctl z podkatalogu ../pliki-ctl/
sqlldr %ORACLE_CONN% control=pliki-ctl/panstwo.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/region_panstwa.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/miasto.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/ulica.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/oddzial.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/stanowisko.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/rodzaj_zatrudnienia.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/status_pracownika.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/typ_pracy.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/zmiana.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/status_projektu.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/rodzaj_projektu.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/pracownik.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/projekt.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/pracownicy_w_projekcie.ctl
sqlldr %ORACLE_CONN% control=pliki-ctl/czas_pracy.ctl errors=100000

echo Ładowanie zakończone.
pause