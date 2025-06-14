OPTIONS (SKIP=1, ERRORS=1000000, DIRECT=TRUE)
LOAD DATA
INFILE 'pliki-csv/rodzaj_zatrudnienia.csv'
DISCARDFILE 'rodzaj_zatrudnienia.dsc'
APPEND
INTO TABLE "rodzaj_zatrudnienia"
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
	"rodzaj_zatrudnienia_id" CHAR, 
	"nazwa" CHAR, 
	"opis" CHAR
)
