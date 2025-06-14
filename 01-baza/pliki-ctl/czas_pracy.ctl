OPTIONS (SKIP=1, ERRORS=1000000, DIRECT=TRUE)
LOAD DATA
INFILE 'pliki-csv/czas_pracy.csv'
DISCARDFILE 'czas_pracy.dsc'
APPEND
INTO TABLE "czas_pracy"
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
	"czas_pracy_id" CHAR, 
	"pracownik_w_projekcie_id" CHAR, 
	"oddzial_id" CHAR, 
	"typ_pracy_id" CHAR, 
	"zmiana_id" CHAR, 
	"czas_przepracowany" CHAR, 
	"czas_trwania_przerwy" CHAR, 
	"godzina_przyjscia_do_pracy" TIMESTAMP "YYYY-MM-DD HH24:MI:SS",
	"godzina_wyjscia_z_pracy" TIMESTAMP "YYYY-MM-DD HH24:MI:SS",
	"godziny_rozpoczecia_przerwy" TIMESTAMP "YYYY-MM-DD HH24:MI:SS",
	"godziny_zakonczenia_przerwy" TIMESTAMP "YYYY-MM-DD HH24:MI:SS",
	"dzien_miesiaca" CHAR, 
	"miesiac" CHAR, 
	"rok" CHAR
)
