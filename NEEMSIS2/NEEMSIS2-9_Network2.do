/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
02/05/21
-----
TITLE: Network
-------------------------
*/


clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"

cd"$directory"
clear all





****************************************
* CLEANING
****************************************
**********Formal social capital:asso
use"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-formalsocialcapital_v2.dta", clear
keep if associationname!=""
dropmiss, force
tab snrecommendasso
drop snrecommendasso_*

* Type
tab associationtype
replace associationtype="4" if associationtype=="Farmer Union"
replace associationtype="10" if associationtype=="Hobby club, sports group, cultural association"
replace associationtype="12" if associationtype=="Other association"
replace associationtype="6" if associationtype=="Political party"
replace associationtype="7" if associationtype=="Professional (occupational) association"
replace associationtype="2" if associationtype=="SHG Group"
replace associationtype="3" if associationtype=="Trade Union"
replace associationtype="5" if associationtype=="Village council (panchayat)"
destring associationtype, replace
label define associationtype 1"Youth Union" 2"SHG Group" 3"Trade Union" 4"Farmer Union" 5"Village council (panchayat)" 6"Political party" 7"Professional association" 8"Market committee" 9"Religious group" 10"Hobby club, sports group, cultural association" 11"Alumni association" 12"Other association" 13"None"
label values associationtype associationtype
tab associationtype

* Degree
tab assodegreeparticip
destring assodegreeparticip, replace
label define assodegreeparticip 1"Leader" 2"Active" 3"Simple member" 
label values assodegreeparticip assodegreeparticip
tab assodegreeparticip

* Size
tab assosize
destring assosize, replace
label define assosize 1"2-10" 2"11-50" 3"51-100" 4">100" 88"D/K"
label values assosize assosize
tab assosize

* Dummy
tab dummyassorecommendation
destring dummyassorecommendation, replace
label define yesno 0"No" 1"Yes"
label values dummyassorecommendation yesno
tab dummyassorecommendation

* Id
destring associationid, replace

* Wide
preserve
tostring egoid, replace
gen indiv=parent_key + "ego" + egoid
keep associationtype associationname assodegreeparticip assosize dummyassorecommendation indiv associationid
reshape wide associationtype associationname assodegreeparticip assosize dummyassorecommendation, i(indiv) j(associationid)
save"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-formalsocialcapital_v2_wide.dta"
restore

****************************************
* END
