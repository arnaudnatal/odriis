*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 10, 2023
*-----
*RUME last clean
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-1"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\2016-NEEMSIS1\Data\4team"
cd"$directory"
********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid
********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020
*-------------------------








****************************************
* NEEMSIS1-HH.dta
****************************************
use"NEEMSIS1-HH", clear


********** Intro
replace lefthomedestination="" if lefthomedestination=="."
replace lefthomereason="" if lefthomereason=="."




********** Education
foreach x in canread everattendedschool classcompleted currentlyatschool educationexpenses amountschoolfees bookscost transportcost dummyscholarship converseinenglish {
replace `x'=. if age<=5
}
replace reasondropping="" if age<=5
replace reasonneverattendedschool="" if age<=5


ta reasonneverattendedschool
replace reasonneverattendedschool="" if reasonneverattendedschool=="."
forvalues i=1/13 {
gen reasonneverattendedschool_`i'=0 if reasonneverattendedschool!=""
}
split reasonneverattendedschool
forvalues i=1/13 {
replace reasonneverattendedschool_`i'=1 if reasonneverattendedschool1=="`i'"
replace reasonneverattendedschool_`i'=1 if reasonneverattendedschool2=="`i'"
label values reasonneverattendedschool_`i' dummymigration
label var reasonneverattendedschool_`i' "reasonneverattendedschool=`i'"
}
rename reasonneverattendedschool_1 reasonneverattendedschool_fail
rename reasonneverattendedschool_2 reasonneverattendedschool_inac
rename reasonneverattendedschool_3 reasonneverattendedschool_qual
rename reasonneverattendedschool_4 reasonneverattendedschool_fina
rename reasonneverattendedschool_5 reasonneverattendedschool_heal
rename reasonneverattendedschool_6 reasonneverattendedschool_noin
rename reasonneverattendedschool_7 reasonneverattendedschool_care
rename reasonneverattendedschool_8 reasonneverattendedschool_work
rename reasonneverattendedschool_9 reasonneverattendedschool_girl
rename reasonneverattendedschool_10 reasonneverattendedschool_marr
rename reasonneverattendedschool_11 reasonneverattendedschool_noal
rename reasonneverattendedschool_12 reasonneverattendedschool_pube
rename reasonneverattendedschool_13 reasonneverattendedschool_baby
drop reasonneverattendedschool1 reasonneverattendedschool2

ta reasondropping
replace reasondropping="" if reasondropping=="."
forvalues i=1/14 {
gen reasondropping_`i'=0 if reasondropping!=""
}
split reasondropping
forvalues i=1/14 {
replace reasondropping_`i'=1 if reasondropping1=="`i'"
replace reasondropping_`i'=1 if reasondropping2=="`i'"
label values reasondropping_`i' dummymigration
label var reasondropping_`i' "reasondropping=`i'"
}
rename reasondropping_1 reasondropping_stop
rename reasondropping_2 reasondropping_fail
rename reasondropping_3 reasondropping_inac
rename reasondropping_4 reasondropping_qual
rename reasondropping_5 reasondropping_fina
rename reasondropping_6 reasondropping_heal
rename reasondropping_7 reasondropping_noin
rename reasondropping_8 reasondropping_care
rename reasondropping_9 reasondropping_work
rename reasondropping_10 reasondropping_girl
rename reasondropping_11 reasondropping_marr
rename reasondropping_12 reasondropping_noal
rename reasondropping_13 reasondropping_pube
rename reasondropping_14 reasondropping_baby
drop reasondropping1 reasondropping2



save"Last/NEEMSIS1-HH", replace
****************************************
* END






****************************************
* NEEMSIS1-occupations.dta
****************************************
use"NEEMSIS1-occupations", clear

format datestartoccup %td
ta datestartoccup

label define demooccup 1"More" 2"Less" 3"Same" 4"Constrained to stop due to demo" 5"Stopped after demo for other reasons" 6"Stopped before demo"
label values demooccup demooccup
ta demooccup
order demooccup, after(datestartoccup)


********** businessskill
ta businessskill
split businessskill
forvalues i=1/4 {
gen businessskill_`i'=0 if businessskill!=""
}
forvalues i=1/4 {
replace businessskill_`i'=1 if businessskill1=="`i'"
replace businessskill_`i'=1 if businessskill2=="`i'"
label values businessskill_`i' dummybusinesslabourers
label var businessskill_`i' "businessskill=`i'"
}
rename businessskill_1 businessskill_fami
rename businessskill_2 businessskill_frie
rename businessskill_3 businessskill_scho
rename businessskill_4 businessskill_expe
drop businessskill1 businessskill2
order businessskill_fami businessskill_frie businessskill_scho businessskill_expe, after(businessskill)

save"Last/NEEMSIS1-occupations", replace
****************************************
* END






















****************************************
* NEEMSIS1-loans_mainloans.dta
****************************************
use"NEEMSIS1-loans_mainloans", clear




save"Last/NEEMSIS1-loans_mainloans", replace
****************************************
* END


