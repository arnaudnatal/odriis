*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Villages construction
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\NEEMSIS-Construction"
cd"$directory"

********** Database names
global data = "NEEMSIS2-HH"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020





****************************************
* xlsx to dta
***************************************
import excel "NEEMSIS2-couples.xlsx", sheet("Sheet1") firstrow clear

drop INDID_husbwife H age sex relationshiptohead HHsize name
rename name_husbwife INDID_husbwife

drop if INDID_husbwife==.
rename INDID INDID1 
rename INDID_husbwife INDID2

bysort HHID_panel: gen n=_n
reshape long INDID, i(HHID_panel n) j(couple)
drop couple
rename n couple
order HHID_panel INDID couple

save "_temp/coupleslong.dta", replace
****************************************
* END








****************************************
* Merge caractéristiques
***************************************
use "_temp/coupleslong.dta", clear

********** Check duplicates
duplicates tag HHID_panel INDID, gen(tag)
ta tag
preserve
keep if tag==1
sort HHID_panel couple INDID
restore
rename tag to_be_checked


********** ID
merge m:1 HHID_panel using "keypanel-HH_wide", keepusing(HHID2020)
keep if _merge==3
drop _merge

* Gen INDID_panel
gen _temp="Ind_"
tostring INDID, replace
egen INDID_panel=concat(_temp INDID)
drop INDID _temp


* Merge
merge m:m HHID2020 INDID_panel using "keypanel-Indiv_wide", keepusing(INDID2020)
drop if _merge==2
replace to_be_checked=2 if _merge==1
drop _merge

order HHID2020 INDID2020 HHID_panel INDID_panel couple to_be_checked
destring INDID2020, replace
drop if INDID2020==.

* Pb
preserve
drop if to_be_checked==1
save "_temp/coupleslong_checked_v2.dta", replace
restore

save "_temp/coupleslong_v2.dta", replace



********** Merge indiv charact
use "NEEMSIS2-HH", clear

keep HHID2020 INDID2020 name age sex relationshiptohead egoid villagename villageid village_new villagearea villageareaid livinghome dummylefthousehold maritalstatus

merge 1:m HHID2020 INDID2020 using "_temp/coupleslong_v2"
drop _merge
bysort HHID2020: egen max_tbc=max(to_be_checked)
drop HHID_panel INDID_panel

save "_temp/_tempmerged.dta", replace

****************************************
* END











****************************************
* CHECKED
****************************************
use "_temp/_tempmerged.dta", clear

drop if max_tbc==1
drop to_be_checked max_tbc

save"_temp/NEEMSIS2-coupleschecked.dta", replace

****************************************
* END














****************************************
* NON-CHECKED
****************************************
use "_temp/_tempmerged.dta", clear

drop if max_tbc==0
drop if max_tbc==.

ta to_be_checked

/*
Il y a 26 individus qui posent pb.
*/


***** Step 1. Sortir les doublons d'abord (ceux mariés avec eux même)
duplicates drop



***** Step 2. Ceux qui sont mariés avec plusieurs personnes 
sort HHID2020 INDID2020
br

replace couple=1 if HHID2020=="uuid:22d52dbd-161f-4111-bd4f-9731398a878c" & INDID2020==2
replace couple=2 if HHID2020=="uuid:23fd63b5-39d4-40c9-810f-193d24449419" & INDID2020==4
replace couple=1 if HHID2020=="uuid:271b70fb-2479-418e-ae78-390b1923d9ba" & INDID2020==1
replace couple=2 if HHID2020=="uuid:271b70fb-2479-418e-ae78-390b1923d9ba" & INDID2020==3
replace couple=2 if HHID2020=="uuid:4542f6cc-debc-4c29-b25c-e7ba253e782d" & INDID2020==17
replace couple=2 if HHID2020=="uuid:4636a314-9b75-4dec-8fea-05335cb99b24" & INDID2020==16
replace couple=1 if HHID2020=="uuid:577e3cb2-4d46-4894-a6a3-cfb8d1529e11" & INDID2020==1
replace couple=1 if HHID2020=="uuid:69694844-ee5e-450a-80cb-81d85c7d7e7e" & INDID2020==5
replace couple=1 if HHID2020=="uuid:752d1e9e-f217-465d-9de1-c30298fae3b5" & INDID2020==2
replace couple=1 if HHID2020=="uuid:b862b0f5-103b-4458-97c1-e52c0d56d3a7" & INDID2020==2
replace couple=2 if HHID2020=="uuid:b862b0f5-103b-4458-97c1-e52c0d56d3a7" & INDID2020==3
replace couple=2 if HHID2020=="uuid:b862b0f5-103b-4458-97c1-e52c0d56d3a7" & INDID2020==4
replace couple=1 if HHID2020=="uuid:f2ce512f-1640-4719-90e0-921980fc6514" & INDID2020==1

duplicates drop
drop to_be_checked max_tbc


***** Step 3. Il y a 2 familles problématiques
br if HHID2020=="uuid:521d316a-3324-4bf7-b4c6-471e58e42962"
replace couple=12 if HHID2020=="uuid:521d316a-3324-4bf7-b4c6-471e58e42962" & INDID2020==1

br if HHID2020=="uuid:8ad24332-a46d-4a5a-82de-79b4a464eb00"
replace couple=12 if HHID2020=="uuid:8ad24332-a46d-4a5a-82de-79b4a464eb00" & INDID2020==1

duplicates drop


save"_temp/NEEMSIS2-couplesnoncheckedchecked.dta", replace
****************************************
* END










****************************************
* APPEND
****************************************
use"_temp/NEEMSIS2-coupleschecked.dta", clear

append using "_temp/NEEMSIS2-couplesnoncheckedchecked.dta"

sort HHID2020 INDID2020
rename couple coupleid

save"_temp/NEEMSIS2-couples_v0", replace
****************************************
* END










****************************************
* Stat
****************************************
use"_temp/NEEMSIS2-couples_v0", clear

*drop if dummylefthousehold==1

ta relationshiptohead coupleid, m
fre relationshiptohead

***** Head with missing
ta maritalstatus if relationshiptohead==1 & coupleid==., m
/*
20 married?
*/


***** Wife with missing
ta maritalstatus if relationshiptohead==2 & coupleid==., m
/*
17 married?
*/


***** Mother with missing
ta maritalstatus if relationshiptohead==3 & coupleid==., m
/*
7 married?
*/


***** Father with missing
ta maritalstatus if relationshiptohead==4 & coupleid==., m
/*
9 married?
*/


***** Son with missing
ta maritalstatus if relationshiptohead==5 & coupleid==., m
/*
37 married?
*/


***** Son-in-law with missing
ta maritalstatus if relationshiptohead==7 & coupleid==., m
/*
1 married?
*/


***** Daughter-in-law with missing
ta maritalstatus if relationshiptohead==8 & coupleid==., m
/*
22 married?
*/





****************************************
* END





