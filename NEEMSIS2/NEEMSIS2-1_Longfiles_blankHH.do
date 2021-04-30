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
WORK ONLY FOR NEW HOUSEHOLD
IF IT IS PANEL HOUSEHOLD USE
Longiles
-------------------------
*/


****************************************
* INITIALIZATION
****************************************
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA"

********** Name of the NEEMSIS2 questionnaire version to clean
global preamble "NEEMSIS2_NEW_"
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
global subpath= "$directory" + "\" + "$subdirectory"












********** RENAME FILES WITH A TOO LONG NAME
cd "$subpath"
capture confirm file "$preamble-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3covsntypehelpreceivedgroup.dta"
if _rc==0 {
use "$preamble-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3covsntypehelpreceivedgroup.dta", clear
save"$preamble-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3covsntypehelpreceivedgrou.dta", replace
erase $preamble-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3covsntypehelpreceivedgroup.dta
}
capture confirm file "$preamble-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsntypehelpreceivedgroup.dta"
if _rc==0 {
use "$preamble-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsntypehelpreceivedgroup.dta", clear
save"$preamble-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsntypehelpreceivedgrou.dta", replace
erase $preamble-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsntypehelpreceivedgroup.dta
}
capture confirm file "$preamble-ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2indselfemployment-_2businesspaymentinkindgroup.dta"
if _rc==0 {
use "$preamble-ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2indselfemployment-_2businesspaymentinkindgroup.dta", clear
save"$preamble-ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2indselfemployment-_2businesspaymentinkindgrou.dta", replace
erase $preamble-ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2indselfemployment-_2businesspaymentinkindgroup.dta
}
capture confirm file "$preamble-ego2questionnaire-_2ego2questionnairebis-_2socialnetworks-_2informalsocialcapital-_2covsnhelpreceivedgroup.dta"
if _rc==0 {
use "$preamble-ego2questionnaire-_2ego2questionnairebis-_2socialnetworks-_2informalsocialcapital-_2covsnhelpreceivedgroup.dta", clear
save"$preamble-ego2questionnaire-_2ego2questionnairebis-_2socialnetworks-_2informalsocialcapital-_2covsnhelpreceivedgrou.dta", replace
erase $preamble-ego2questionnaire-_2ego2questionnairebis-_2socialnetworks-_2informalsocialcapital-_2covsnhelpreceivedgroup.dta
}
capture confirm file "$preamble-ego2questionnaire-_2ego2questionnairebis-_2socialnetworks-_2informalsocialcapital-_2covsntypehelpreceivedgroup.dta"
if _rc==0 {
use "$preamble-ego2questionnaire-_2ego2questionnairebis-_2socialnetworks-_2informalsocialcapital-_2covsntypehelpreceivedgroup.dta", clear
save"$preamble-ego2questionnaire-_2ego2questionnairebis-_2socialnetworks-_2informalsocialcapital-_2covsntypehelpreceivedgrou.dta", replace
erase $preamble-ego2questionnaire-_2ego2questionnairebis-_2socialnetworks-_2informalsocialcapital-_2covsntypehelpreceivedgroup.dta
}





*********** NEW FILES WITH KEY AND SETOF INVERSE (SAVE IN "DIRECTORY" FOLDER)
cd"$directory"
clear all
filelist, dir("$subdirectory") pattern(*.dta)
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
drop if filename=="$preamble~_v2.dta"
drop if filename=="$preamble~_v3.dta"
drop if filename=="$preamble~_v4.dta"
*keep if filename=="NEEMSIS2_NEW_APRIL-hhquestionnaire-employment.dta"
*drop if filename=="$preamble-hhquestionnaire-employment.dta"
*drop if filename=="$preamble-householdquestionnaireold-hhquestionnaire-familymembers_v2.dta"
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = dirname + "\" + filename
	local k = varname1
	local s = filename
	use "`f'" if substr("`k'", 1, 7)!="details", clear
	rename key key_O
	rename setof`k' key
	rename key_O setof`k'
	save "OTHER_`s'", replace
	use "`f'" if substr("`k'", 1, 7)=="details", clear
	rename parent_key parent_key_O
	rename setof`k' parent_key
	rename parent_key_O setof`k'
	tempfile save`i'
	save "DETAI_`s'", replace
}










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
	tempfile save`i'
	save "`s'", replace
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







********** MANUAL CLEANING FOR IDGROUP
cd"$subpath"
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
