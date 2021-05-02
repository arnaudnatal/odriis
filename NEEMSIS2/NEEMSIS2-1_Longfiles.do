/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
February 23, 2021
-----
CLEANING ALL LONG FILES OF NEEMSIS2
-----
Desc: 
Inverse "key" and "setof" in all
long files in order to facilitate
the merging between the household
data base and the long files.
WORK ONLY FOR PANEL HOUSEHOLD
IF IT IS NEW HOUSEHOLD,
USE Longfiles_blankHH
-------------------------
*/



/*
foreach x in NEEMSIS2_APRIL NEEMSIS2_DEC NEEMSIS2_DECEMBER NEEMSIS2_FEB NEEMSIS2_FEBRUARY NEEMSIS2_LAST NEEMSIS2_NEW_APRIL {
cd"$directory\\`x'"
do "import_`x'"
}
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
global preamble "NEEMSIS2_NEW_APRIL"
****************************************
* END










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








********** Ego cleaning
cd"$directory"
clear all
filelist, dir("$subdirectory") pattern(*.dta)
split filename, p(-)
forvalues i=1(1)50{
capture confirm v filename`i'
if !_rc {
global filenamemax "`i'"
}
}
gen ok=0
replace ok=1 if substr(filename2,1,5)=="_3ego"
replace ok=1 if substr(filename2,1,3)=="ego"
keep if ok==1
*Virer bis or full
clonevar filename33=filename3
replace filename3=filename4 if filename33=="_2ego2questionnairebis"
replace filename4=filename5 if filename33=="_2ego2questionnairebis"
replace filename5=filename6 if filename33=="_2ego2questionnairebis"
capture confirme v filename7
if _rc==0{
replace filename6=filename7 if filename33=="_2ego2questionnairebis"
replace filename7="" if filename33=="_2ego2questionnairebis"
}

replace filename3=filename4 if filename33=="ego2questionnairefull"
replace filename4=filename5 if filename33=="ego2questionnairefull"
replace filename5=filename6 if filename33=="ego2questionnairefull"
capture confirme v filename7
if _rc==0{
replace filename6=filename7 if filename33=="ego2questionnairefull"
replace filename7="" if filename33=="ego2questionnairefull"
}
*Name
gen name=""
forvalues i=1(1)$filenamemax{
replace name=filename`i' if substr(filename`i',strlen(filename`i')-3,4)==".dta"
}
*Egoid
sort name
gen egoid=1
replace egoid=2 if substr(name,1,2)=="_2"
replace egoid=3 if substr(name,1,2)=="_3"
tab egoid
*Construction du nouveau nom de la bdd
egen newname=concat(filename1 filename2 filename3 filename4 filename5 filename6), p(-)
replace newname=substr(newname,1,strlen(newname)-1) if substr(newname,strlen(newname),1)=="-"
replace newname=substr(newname,1,strlen(newname)-1) if substr(newname,strlen(newname),1)=="-"
replace newname=substr(newname,1,strlen(newname)-1) if substr(newname,strlen(newname),1)=="-"

*Implement
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local fold = dirname + "\" + filename
	local fnew = newname
	local e = egoid	
	use "`fold'", clear
	gen egoid=`e'
	foreach x of varlist _all {
	local varnewname=substr("`x'",3,strlen("`x'"))
	if substr("`x'",1,2)=="_2" rename `x' `varnewname'
	if substr("`x'",1,2)=="_3" rename `x' `varnewname'
	}
	drop setof* key
	order parent_key egoid, first
	drop if parent_key==""
	tempfile save`i'
	save "$directory\APPEND\raw\\`fnew'.dta", replace
}





********* Erase file
cd"$directory"
clear all
filelist, dir("$subdirectory") pattern(*.dta)
split filename, p(-)
gen name=""
forvalues i=1(1)$filenamemax{
replace name=filename`i' if substr(filename`i',strlen(filename`i')-3,4)==".dta"
}

replace name=substr(name,3,strlen(name)) if substr(name,1,2)=="_2"
replace name=substr(name,3,strlen(name)) if substr(name,1,2)=="_3"
sort name

cd"$directory\\$preamble"
foreach x in  ///
NEEMSIS2_NEW_APRIL-ego2questionnaire-randomizationego2-randomizationego2full-random_1825-show_draws.dta ///
NEEMSIS2_NEW_APRIL-_3random_1825-_3show_draws.dta ///
NEEMSIS2_NEW_APRIL-ego2questionnaire-randomizationego2-randomizationego2full-random_2635-show_draws_2.dta ///
NEEMSIS2_NEW_APRIL-_3random_2635-_3show_draws_2.dta ///
NEEMSIS2_NEW_APRIL-ego2questionnaire-randomizationego2-randomizationego2full-random_36-show_draws_3.dta ///
NEEMSIS2_NEW_APRIL-_3random_36-_3show_draws_3.dta ///
NEEMSIS2_NEW_APRIL-_3random_1825-_3random_draws.dta ///
NEEMSIS2_NEW_APRIL-ego2questionnaire-randomizationego2-randomizationego2full-random_1825-random_draws.dta ///
NEEMSIS2_NEW_APRIL-_3random_2635-_3random_draws_2.dta ///
NEEMSIS2_NEW_APRIL-ego2questionnaire-randomizationego2-randomizationego2full-random_2635-random_draws_2.dta ///
NEEMSIS2_NEW_APRIL-ego2questionnaire-randomizationego2-randomizationego2full-random_36-random_draws_3.dta ///
NEEMSIS2_NEW_APRIL-_3random_36-_3random_draws_3.dta{
capture confirm file "`x'
if _rc==0{
erase "`x'"
}
}




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
drop if filename=="$preamble-hhquestionnaire-employment.dta"
drop if filename_2=="_3ego1questionnaire"
drop if filename_2=="ego1questionnaire"
drop if filename_2=="ego2questionnaire"
*keep if filename=="NEEMSIS2_NEW_APRIL-hhquestionnaire-familymembers.dta"
*keep if filename_2=="NEEMSIS2_NEW_APRIL-detailsloanbyborrower.dta"

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
	save "$directory\APPEND\raw\\`s'", replace
	}
	else{
	use "$directory\\$preamble\\`s'", clear
	drop setof`k'
	rename parent_key setof`k'
	split key, p(/)
	rename key1 parent_key
	save "$directory\APPEND\raw\\`s'", replace
	}
	tempfile save`i'
}





********** MANUAL CLEANING FOR IDGROUP
*For preload HH
cd"$subpath"
capture confirm file "$preamble-hhquestionnaireold-hhquestionnaire-migration-migrationgroup.dta"
if _rc==0 {
use "$preamble-hhquestionnaireold-hhquestionnaire-migration-migrationgroup", clear
rename setofmigrationgroup setofmigrationidgroup
save"$preamble-hhquestionnaireold-hhquestionnaire-migration-migrationidgroup.dta", replace
erase $preamble-hhquestionnaireold-hhquestionnaire-migration-migrationgroup.dta
}

capture confirm file "$preamble-hhquestionnaireold-hhquestionnaire-remittances-remreceived-remreceivedgroup.dta"
if _rc==0 {
use "$preamble-hhquestionnaireold-hhquestionnaire-remittances-remreceived-remreceivedgroup", clear
rename setofremreceivedgroup setofremreceivedidgroup
save"$preamble-hhquestionnaireold-hhquestionnaire-remittances-remreceived-remreceivedidgroup", replace
erase $preamble-hhquestionnaireold-hhquestionnaire-remittances-remreceived-remreceivedgroup.dta
}

capture confirm file "$preamble-hhquestionnaireold-hhquestionnaire-remittances-remsent-remsentgroup.dta"
if _rc==0 {
use "$preamble-hhquestionnaireold-hhquestionnaire-remittances-remsent-remsentgroup", clear
rename setofremsentidgroup setofremsentidgroup_old
rename setofremsentgroup setofremsentidgroup
save"$preamble-hhquestionnaireold-hhquestionnaire-remittances-remsent-remsentidgroup", replace
erase $preamble-hhquestionnaireold-hhquestionnaire-remittances-remsent-remsentgroup.dta
}



********** For new HH
capture confirm file "$preamble-hhquestionnaire-migration-migrationgroup.dta"
if _rc==0 {
use "$preamble-hhquestionnaire-migration-migrationgroup", clear
rename setofmigrationgroup setofmigrationidgroup
save"$preamble-hhquestionnaire-migration-migrationidgroup.dta", replace
erase $preamble-hhquestionnaire-migration-migrationgroup.dta
}

capture confirm file "$preamble-hhquestionnaire-remittances-remreceived-remreceivedgroup.dta"
if _rc==0 {
use "$preamble-hhquestionnaire-remittances-remreceived-remreceivedgroup", clear
rename setofremreceivedgroup setofremreceivedidgroup
save"$preamble-hhquestionnaire-remittances-remreceived-remreceivedidgroup", replace
erase $preamble-hhquestionnaire-remittances-remreceived-remreceivedgroup.dta
}

capture confirm file "$preamble-hhquestionnaire-remittances-remsent-remsentgroup.dta"
if _rc==0 {
use "$preamble-hhquestionnaire-remittances-remsent-remsentgroup", clear
rename setofremsentidgroup setofremsentidgroup_old
rename setofremsentgroup setofremsentidgroup
save"$preamble-hhquestionnaire-remittances-remsent-remsentidgroup", replace
erase $preamble-hhquestionnaire-remittances-remsent-remsentgroup.dta
}



























/*
********** DROP THE OLD FILES (WHICH IS IN THE "SUBDIRECTORY") (details files)
cd "$directory"
clear all
filelist, dir("$directory") pattern(*.dta)
split filename, p(-)
gen varname=""
forvalues v=1(1)$filenamemax{
replace varname=filename`v' if substr(filename`v', -4, 4)==".dta"
rename filename`v' filename_`v'
}
split varname, p(.)
sort filename
drop if dirname!="$directory"
drop if substr(filename,1,5)=="OTHER"
gen filename_new=substr(filename,9,200)
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local k = varname1
	local f = filename
	if substr("`k'",1,7)!="details" {
    erase `f'
	}
	}
*/	
	
	
	
	
	
	
	
/*	
********** DROP THE OLD FILES (WHICH IS IN THE "SUBDIRECTORY") (others files)
cd "$directory"
clear all
filelist, dir("$directory") pattern(*.dta)
split filename, p(-)
gen varname=""
forvalues v=1(1)$filenamemax{
replace varname=filename`v' if substr(filename`v', -4, 4)==".dta"
rename filename`v' filename_`v'
}
split varname, p(.)
sort filename
drop if dirname!="$directory"
drop if substr(filename,1,5)=="DETAI"
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local k = varname1
	local f = filename
	if substr("`k'",1,7)=="details" {
    erase `f'
	}
	}

*/







/*
********** RENAME THE NEW FILES (DETAI and OTHER) WITH NORMAL NAME (without DETAI of OTHER)
cd "$directory"
clear all
filelist, dir("$directory") pattern(*.dta)
split filename, p(-)
gen varname=""
forvalues v=1(1)$filenamemax{
replace varname=filename`v' if substr(filename`v', -4, 4)==".dta"
rename filename`v' filename_`v'
}
split varname, p(.)
sort filename
drop if dirname!="$directory"
gen filename_new=substr(filename,7,200)
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = dirname + "\" + filename
	local nf= filename_new
	use "`f'", clear
	tempfile save`i'
	save "`nf'", replace
}
*/








/*
********** DROP TEMPORARY FILE
cd "$directory"
clear all
filelist, dir("$directory") pattern(*.dta)
split filename, p(-)
gen varname=""
forvalues v=1(1)$filenamemax{
replace varname=filename`v' if substr(filename`v', -4, 4)==".dta"
rename filename`v' filename_`v'
}
split varname, p(.)
sort filename
drop if dirname!="$directory"
drop if substr(filename,1,8)=="NEEMSIS2"
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local k = varname1
	local f = filename
    erase `f'
	}
*/	
	
	
	
	
	
	
	
	
	
/*	
********** COPY NEW RENAME FILES INTO SUBDIRECTORY FOLDER
cd "$subpath"
clear all
filelist, dir("$directory") pattern(*.dta)
split filename, p(-)
gen varname=""
forvalues v=1(1)$filenamemax{
replace varname=filename`v' if substr(filename`v', -4, 4)==".dta"
rename filename`v' filename_`v'
}
split varname, p(.)
sort filename
drop if dirname!="$directory"
gen filename_new=substr(filename,7,200)
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = dirname + "\" + filename
	local s = filename
	use "`f'", clear
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	tempfile save`i'
	save "$directory\APPEND\raw\`s'", replace
}








********** DELETE NEW FILES FROM DIRECTORY
cd "$directory"
clear all
filelist, dir("$directory") pattern(*.dta)
split filename, p(-)
gen varname=""
forvalues v=1(1)$filenamemax{
replace varname=filename`v' if substr(filename`v', -4, 4)==".dta"
rename filename`v' filename_`v'
}
split varname, p(.)
sort filename
drop if dirname!="$directory"
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	*local f = dirname + "\" + filename
	local s = filename
	erase `s'
	*tempfile save`i'
}
*/






