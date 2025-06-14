OPTIONS (SKIP=1, ERRORS=1000000, DIRECT=TRUE)
LOAD DATA
INFILE 'pliki-csv/zmiana.csv'
DISCARDFILE 'zmiana.dsc'
APPEND
INTO TABLE "zmiana"
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
	"zmiana_id" CHAR, 
	"nazwa" CHAR, 
	"godzina_rozpoczecia" TIMESTAMP "HH24:MI:SS", 
	"godzina_zakonczenia" TIMESTAMP "HH24:MI:SS"
)
