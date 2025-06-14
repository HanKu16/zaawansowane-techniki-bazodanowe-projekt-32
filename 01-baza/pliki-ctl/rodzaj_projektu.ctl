OPTIONS (SKIP=1, ERRORS=1000000, DIRECT=TRUE)
LOAD DATA
INFILE 'pliki-csv/rodzaj_projektu.csv'
DISCARDFILE 'rodzaj_projektu.dsc'
APPEND
INTO TABLE "rodzaj_projektu"
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
	"rodzaj_projektu_id" CHAR, 
	"nazwa" CHAR, 
	"opis" CHAR
)
