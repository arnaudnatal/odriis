cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
September 30, 2021
-----
TITLE: Occupation panel

-------------------------
*/

clear all
macro drop _all
cls
********** Path to folder "data" folder.
global git ="C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

cd"$git\Occupations"
clear all





****************************************
* Append
****************************************
use"$git\Occupations\sector2010", clear

append using "$git\Occupations\sector2016"
append using "$git\Occupations\sector2020"

gen codepro=profession+1-1
gen test=codepro-profession
tab test
drop test

save"$git\Occupations\sector_panel", replace
****************************************
* END


****************************************
* To excel
****************************************
use"$git\Occupations\sector_panel", clear

preserve
keep if year==2010
duplicates drop
list occupationname profession codepro, clean noobs
drop year
sort occupationname
export excel using "$git\Occupations\Occupations_v2.xlsx", sheet("RUME") sheetmodify firstrow(variables)
restore

preserve
keep if year==2016
duplicates drop
list occupationname profession codepro, clean noobs
drop year
sort occupationname
export excel using "$git\Occupations\Occupations_v2.xlsx", sheet("NEEMSIS1") sheetmodify firstrow(variables)
restore

preserve
keep if year==2020
duplicates drop
list occupationname profession codepro, clean noobs
drop year
sort occupationname
export excel using "$git\Occupations\Occupations_v2.xlsx", sheet("NEEMSIS2") sheetmodify firstrow(variables)
restore

****************************************
* END
