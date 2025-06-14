OPTIONS (SKIP=1, ERRORS=1000000, DIRECT=TRUE)
LOAD DATA
INFILE 'pliki-csv/status_projektu.csv'
DISCARDFILE 'status_projektu.dsc'
APPEND
INTO TABLE "status_projektu"
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
   	"status_projektu_id" CHAR, 
	"nazwa" CHAR, 
	"opis" CHAR
)
