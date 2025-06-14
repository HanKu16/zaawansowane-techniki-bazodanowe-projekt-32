OPTIONS (SKIP=1, ERRORS=1000000, DIRECT=TRUE)
LOAD DATA
INFILE 'pliki-csv/pracownik.csv'
DISCARDFILE 'pracownik.dsc'
APPEND
INTO TABLE "pracownik"
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
	"pracownik_id" CHAR, 
	"stanowisko_id" CHAR, 
	"rodzaj_zatrudnienia_id" CHAR, 
	"status_pracownika_id" CHAR, 
	"imie" CHAR, 
	"nazwisko" CHAR, 
	"mail" CHAR
)
