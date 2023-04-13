*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*NEEMSIS-2 GPS
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (IRD)\RUME II\2. Data\Raw\2020-NEEMSIS2_GPS"
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
* Who?
***************************************
use "NEEMSIS2-HH", clear

keep HHID2020 address village_new villagearea
duplicates drop

*Head
merge 1:1 HHID2020 using "NEEMSIS2-family", keepusing(head_name head_sex head_age)
drop _merge

* Jatis 
merge 1:m HHID2020 using "Panel-Caste_HH", keepusing(jatiscorr2020)
keep if _merge==3
drop _merge


* HHID_panel
merge 1:m HHID2020 using "keypanel-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge


* Order
order HHID_panel village_new villagearea address head_name head_sex head_age jatiscorr2020


* Already done?
merge 1:1 HHID_panel using "NEEMSIS2-GPS_done"
drop _merge


* Remaining?
drop if done==1
drop HHID2020 done

sort village_new HHID_panel
save"NEEMSIS2-GPS_remaining", replace
export excel using "NEEMSIS2-GPS_remaining.xlsx", replace firstrow(variables)


****************************************
* END
