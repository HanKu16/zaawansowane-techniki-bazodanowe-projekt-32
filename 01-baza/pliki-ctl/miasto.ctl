OPTIONS (SKIP=1, ERRORS=1000000, DIRECT=TRUE)
LOAD DATA
INFILE 'pliki-csv/miasto.csv'
DISCARDFILE 'miasto.dsc'
APPEND
INTO TABLE "miasto"
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
	"miasto_id" CHAR, 
	"region_panstwa_id" CHAR, 
	"nazwa" CHAR
)
