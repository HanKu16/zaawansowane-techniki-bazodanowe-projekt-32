OPTIONS (SKIP=1, ERRORS=1000000, DIRECT=TRUE)
LOAD DATA
INFILE 'pliki-csv/projekt.csv'
DISCARDFILE 'projekt.dsc'
APPEND
INTO TABLE "projekt"
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
	"projekt_id" CHAR, 
	"status_projektu_id" CHAR, 
	"rodzaj_projektu_id" CHAR, 
	"nazwa" CHAR, 
	"opis" CHAR
)
