OPTIONS (SKIP=1, ERRORS=1000000, DIRECT=TRUE)
LOAD DATA
INFILE 'pliki-csv/pracownicy_w_projekcie.csv'
DISCARDFILE 'pracownicy_w_projekcie.dsc'
APPEND
INTO TABLE "pracownicy_w_projekcie"
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
	"pracownik_w_projekcie_id" CHAR, 
	"pracownik_id" CHAR, 
	"projekt_id" CHAR
)
