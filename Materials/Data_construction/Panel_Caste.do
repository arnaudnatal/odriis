*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Caste construction
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox\RUME-NEEMSIS\Data\Construction"
cd"$directory"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020





****************************************
* Caste panel
***************************************

***** 2010
use"outcomes\RUME-caste", clear

drop INDID2010
rename HHID2010 HHID
gen year=2010
duplicates drop

save "_temp\RUME-castetp", replace



***** 2016-17
use"outcomes\NEEMSIS1-caste", clear

drop INDID2016
rename HHID2016 HHID
gen year=2016
duplicates drop

save "_temp\NEEMSIS1-castetp", replace



***** 2020-21
use"outcomes\NEEMSIS2-caste", clear

drop INDID2020
rename HHID2020 HHID
gen year=2020
duplicates drop

save "_temp\NEEMSIS2-castetp", replace




***** Panel
use"_temp\RUME-castetp", clear

append using "_temp\NEEMSIS1-castetp"
append using "_temp\NEEMSIS2-castetp"

reshape wide HHID jatis jatiscorr caste, i(HHID_panel) j(year)

ta caste2010 caste2016
ta caste2016 caste2020

save"outcomes\Panel-Caste_HH.dta", replace
****************************************
* END
