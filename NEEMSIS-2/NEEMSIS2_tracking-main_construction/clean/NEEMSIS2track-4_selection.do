/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
October 6, 2022
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
*global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\2020-NEEMSIS2\Data\4team"

cd"$directory"

********** Name of the NEEMSIS2 questionnaire version to clean
*global preamble "`dbv'"

****************************************
* END







****************************************
* Tracking main database
****************************************
* Who are the real mig?
use"NEEMSIS2-tracking_migpath", clear
drop if migrationstepid==.
keep HHID2022
gen realmig=1
duplicates drop
save"$directory\_temp\_temprealmig2", replace


*
use"NEEMSIS2-tracking", clear
merge m:1 HHID2022 using "$directory\_temp\_temprealmig2"
drop _merge
recode realmig (.=0)
label values realmig yesno
order HHID2022 realmig
label var realmig "Is the HH a real migrant HH?"
save"Last\NEEMSIS2-tracking", replace

*
use"NEEMSIS2-tracking_alters", clear
merge m:1 HHID2022 using "$directory\_temp\_temprealmig2"
drop _merge
recode realmig (.=0)
label values realmig yesno
order HHID2022 realmig
label var realmig "Is the HH a real migrant HH?"
save"Last\NEEMSIS2-tracking_alters", replace

*
use"NEEMSIS2-tracking_occupations", clear
merge m:1 HHID2022 using "$directory\_temp\_temprealmig2"
drop _merge
recode realmig (.=0)
label values realmig yesno
order HHID2022 realmig
label var realmig "Is the HH a real migrant HH?"
save"Last\NEEMSIS2-tracking_occupations", replace


****************************************
* END
