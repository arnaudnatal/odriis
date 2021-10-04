/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
February 23, 2021
-----
CLEANING ALL LONG FILES OF NEEMSIS2
-----
-------------------------
*/



****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA"

********** Name of the NEEMSIS2 questionnaire version to clean
*global preamble "`dbv'"
global preamble "NEEMSIS2_NEW_JUNE"

****************************************
* END


/*
*foreach x in NEEMSIS2_APRIL NEEMSIS2_DEC NEEMSIS2_DECEMBER NEEMSIS2_FEB NEEMSIS2_FEBRUARY NEEMSIS2_LAST NEEMSIS2_NEW_APRIL NEEMSIS2_NEW_JUNE {
foreach x in  NEEMSIS2_NEW_JUNE {
cd"$directory\\`x'"
do "import_`x'"
}
*/






** AUTOMATIC NOW
**************************************************************************************************************
**************************************************************************************************************
**************************************************************************************************************
**************************************************************************************************************
**************************************************************************************************************



********** AUTO CALCULATION
set obs 1
gen _nbchar=strlen("$preamble")+2
global nbcharact = _nbchar
drop _nbchar
dis $nbcharact

global subdirectory ="$preamble"
global subpath= "$directory" + "\" + "$preamble"






*********** NEW FILES WITH KEY AND SETOF INVERSE (SAVE IN "DIRECTORY" FOLDER)
clear all
filelist, dir("$directory\\$preamble") pattern(*.dta)
split filename, p(-)
gen varname=""
forvalues i=1(1)50{
capture confirm v filename`i'
if !_rc {
global filenamemax "`i'"
}
}

forvalues v=1(1)$filenamemax{
replace varname=filename`v' if substr(filename`v', -4, 4)==".dta"
rename filename`v' filename_`v'
}
split varname, p(.)
sort filename
drop if filename=="$preamble.dta"
*drop if filename=="$preamble-hhquestionnaire-employment.dta"
drop if filename_2=="_3ego1questionnaire"
drop if filename_2=="ego1questionnaire"
drop if filename_2=="ego2questionnaire"
drop if substr(filename_2,1,5)=="_3snr"
drop if substr(filename_2,1,5)=="_2snr"
drop if substr(filename_2,1,3)=="snr"

drop if substr(filename_2,1,6)=="random"
drop if substr(filename_2,1,8)=="_2random"
drop if substr(filename_2,1,8)=="_3random"

drop if filename_4=="migration"
drop if filename_4=="remittances"

tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local k = varname1
	local s = filename
	if substr("`k'", 1, 7)!="details"{
	use "$directory\\$preamble\\`s'", clear
	rename key key_O
	rename setof`k' key
	rename key_O setof`k'
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"
	save "$directory\APPEND\raw\\`s'", replace
	}
	else{
	use "$directory\\$preamble\\`s'", clear
	drop setof`k'
	rename parent_key setof`k'
	split key, p(/)
	rename key1 parent_key
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"
	save "$directory\APPEND\raw\\`s'", replace
	}
	tempfile save`i'
}





********** MANUAL CLEANING FOR IDGROUP
*For preload HH
capture confirm file "$directory\\$preamble\\$preamble-householdquestionnaireold-hhquestionnaire-migration-migrationgroup.dta"
if _rc==0 {
use "$directory\\$preamble\\$preamble-householdquestionnaireold-hhquestionnaire-migration-migrationgroup", clear
rename key setofmigrationidgroup
drop setofmigrationgroup
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"

save"$directory\APPEND\raw\\$preamble-householdquestionnaireold-hhquestionnaire-migration-migrationidgroup.dta", replace
}

capture confirm file "$directory\\$preamble\\$preamble-householdquestionnaireold-hhquestionnaire-remittances-remreceived-remreceivedgroup.dta"
if _rc==0 {
use "$directory\\$preamble\\$preamble-householdquestionnaireold-hhquestionnaire-remittances-remreceived-remreceivedgroup", clear
rename key setofremreceivedidgroup
drop setofremreceivedgroup
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"

save"$directory\APPEND\raw\\$preamble-householdquestionnaireold-hhquestionnaire-remittances-remreceived-remreceivedidgroup", replace
}

capture confirm file "$directory\\$preamble\\$preamble-householdquestionnaireold-hhquestionnaire-remittances-remsent-remsentgroup.dta"
if _rc==0 {
use "$directory\\$preamble\\$preamble-householdquestionnaireold-hhquestionnaire-remittances-remsent-remsentgroup", clear
rename setofremsentidgroup setofremsentidgroup_old
rename key setofremsentidgroup
drop setofremsentgroup
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"
save"$directory\APPEND\raw\\$preamble-householdquestionnaireold-hhquestionnaire-remittances-remsent-remsentidgroup", replace
}



********** For new HH
capture confirm file "$directory\\$preamble\\$preamble-hhquestionnaire-migration-migrationgroup.dta"
if _rc==0 {
use "$directory\\$preamble\\$preamble-hhquestionnaire-migration-migrationgroup", clear
drop setofmigrationgroup
rename key setofmigrationidgroup

	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"

save"$directory\APPEND\raw\\$preamble-hhquestionnaire-migration-migrationgroup.dta", replace
}

capture confirm file "$directory\\$preamble\\$preamble-hhquestionnaire-remittances-remreceived-remreceivedgroup.dta"
if _rc==0 {
use "$directory\\$preamble\\$preamble-hhquestionnaire-remittances-remreceived-remreceivedgroup", clear
drop setofremreceivedgroup
rename key setofremreceivedgroup

	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"

save"$directory\APPEND\raw\\$preamble-hhquestionnaire-remittances-remreceived-remreceivedgroup", replace
}

capture confirm file "$directory\\$preamble\\$preamble-hhquestionnaire-remittances-remsent-remsentgroup.dta"
if _rc==0 {
use "$directory\\$preamble\\$preamble-hhquestionnaire-remittances-remsent-remsentgroup", clear
drop setofremsentgroup
rename key setofremsentgroup
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"

save"$directory\APPEND\raw\\$preamble-hhquestionnaire-remittances-remsent-remsentgroup", replace
}
