OPTIONS (SKIP=1, ERRORS=1000000, DIRECT=TRUE)
LOAD DATA
INFILE 'pliki-csv/oddzial.csv'
DISCARDFILE 'oddzial.dsc'
APPEND
INTO TABLE "oddzial"
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
	"oddzial_id" CHAR, 
	"ulica_id" CHAR, 
	"nazwa" CHAR
)
