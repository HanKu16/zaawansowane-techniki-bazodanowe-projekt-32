OPTIONS (SKIP=1, ERRORS=1000000, DIRECT=TRUE)
LOAD DATA
INFILE 'pliki-csv/status_pracownika.csv'
DISCARDFILE 'status_pracownika.dsc'
APPEND
INTO TABLE "status_pracownika"
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
	"status_pracownika_id" CHAR, 
	"nazwa" CHAR, 
	"opis" CHAR
)
