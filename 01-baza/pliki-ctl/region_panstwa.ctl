OPTIONS (SKIP=1, ERRORS=1000000, DIRECT=TRUE)
LOAD DATA
INFILE 'pliki-csv/region_panstwa.csv'
DISCARDFILE 'region_panstwa.dsc'
APPEND
INTO TABLE "region_panstwa"
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
	"region_panstwa_id" CHAR, 
	"panstwo_id" CHAR, 
	"nazwa" CHAR
)
