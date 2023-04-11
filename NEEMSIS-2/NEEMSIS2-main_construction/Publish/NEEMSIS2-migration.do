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








********** 
use"NEEMSIS2-migration", clear

duplicates report setofmigrationidgroup

rename parent_key HHID2020

duplicates report HHID2020


********** Add INDID
merge m:m setofmigrationidgroup using "temp_NEEMSIS2-HHINDID", keepusing(INDID2020)
keep if _merge==3
drop _merge

order HHID2020 INDID2020
*rename parent_key HHID2020
drop setof*

duplicates report HHID2020 INDID2020 migrationjobid




********** SAVE
save"Last\NEEMSIS2-migrations", replace

