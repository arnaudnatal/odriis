*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*XLSform to XLSquest
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to do
global dofile = "C:\Users\Arnaud\Documents\MEGA\Data\Publish\NEEMSIS-2"

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\Publish\NEEMSIS-2"
cd"$directory"








****************************************
* Alter
****************************************

use"NEEMSIS2-alter.dta", clear

fre egoid

********** ego
preserve
drop if egoid==0
merge m:m parent_key egoid using "NEEMSIS2-HH", keepusing(INDID2020)
keep if _merge==3
drop _merge
drop INDID_total
order parent_key INDID2020
rename parent_key HHID2020
save"temp_NEEMSIS2-alter_ego", replace
restore


********** non-ego
keep if egoid==0
merge m:m parent_key INDID_total using "NEEMSIS2-HH", keepusing(INDID2020)
keep if _merge==3
drop _merge
drop INDID_total
order parent_key INDID2020
rename parent_key HHID2020


append using "temp_NEEMSIS2-alter_ego"



********** Order and rename
rename ALTERID alterid
duplicates report HHID2020 INDID2020 alterid

drop INDID_v2 n1 letter


fre typesn


********** save
save "Last\NEEMSIS2-alter.dta", replace
