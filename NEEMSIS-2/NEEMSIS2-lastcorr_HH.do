*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 14, 2023
*-----
*NEEMSIS-2 HH last clean
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\2020-NEEMSIS2\Data\4team"
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
* NEEMSIS2-HH.dta
****************************************
use"NEEMSIS2-HH", clear


*********** Educ preload
merge 1:1 HHID2020 INDID2020 using "C:\Users\Arnaud\Documents\Dropbox (IRD)\RUME II\2. Data\Constructed_data\edupreload\NEEMSIS2-edupreload", keepusing(datafromearlier data)
drop _merge
ta data
ta datafromearlier
rename datafromearlier educpreload
order educpreload, before(canread)
label var educpreload "Does the individual have preloaded data for the education module?"
label values educpreload yesno



recode subjectsafter10th (7=77) (8=77)




ta reservationgrade
split reservationgrade, destring
recode reservationgrade1 reservationgrade2 reservationgrade3 reservationgrade4 reservationgrade5 reservationgrade6 reservationgrade7 reservationgrade8 reservationgrade9 reservationgrade10 reservationgrade11 reservationgrade12 reservationgrade13 reservationgrade14 (15=13) (16=14)
forvalues i=1/14 {
gen reservationgrade_`i'=0 if reservationgrade!=""
}
forvalues i=1/14{
replace reservationgrade_`i'=1 if reservationgrade1==`i'
replace reservationgrade_`i'=1 if reservationgrade2==`i'
replace reservationgrade_`i'=1 if reservationgrade3==`i'
replace reservationgrade_`i'=1 if reservationgrade4==`i'
replace reservationgrade_`i'=1 if reservationgrade5==`i'
replace reservationgrade_`i'=1 if reservationgrade6==`i'
replace reservationgrade_`i'=1 if reservationgrade7==`i'
replace reservationgrade_`i'=1 if reservationgrade8==`i'
replace reservationgrade_`i'=1 if reservationgrade9==`i'
replace reservationgrade_`i'=1 if reservationgrade10==`i'
replace reservationgrade_`i'=1 if reservationgrade11==`i'
replace reservationgrade_`i'=1 if reservationgrade12==`i'
replace reservationgrade_`i'=1 if reservationgrade13==`i'
replace reservationgrade_`i'=1 if reservationgrade14==`i'
label var reservationgrade_`i' "reservationgrade=`i'"
label values reservationgrade_`i' yesno
}
rename reservationgrade_1 reservationgrade_1st
rename reservationgrade_2 reservationgrade_2nd
rename reservationgrade_3 reservationgrade_3rd
rename reservationgrade_4 reservationgrade_4th
rename reservationgrade_5 reservationgrade_5th
rename reservationgrade_6 reservationgrade_6th
rename reservationgrade_7 reservationgrade_7th
rename reservationgrade_8 reservationgrade_8th
rename reservationgrade_9 reservationgrade_9th
rename reservationgrade_10 reservationgrade_10th
rename reservationgrade_11 reservationgrade_11th
rename reservationgrade_12 reservationgrade_12th
rename reservationgrade_13 reservationgrade_bach
rename reservationgrade_14 reservationgrade_abov
drop reservationgrade1 reservationgrade2 reservationgrade3 reservationgrade4 reservationgrade5 reservationgrade6 reservationgrade7 reservationgrade8 reservationgrade9 reservationgrade10 reservationgrade11 reservationgrade12 reservationgrade13 reservationgrade14
order reservationgrade_1st reservationgrade_2nd reservationgrade_3rd reservationgrade_4th reservationgrade_5th reservationgrade_6th reservationgrade_7th reservationgrade_8th reservationgrade_9th reservationgrade_10th reservationgrade_11th reservationgrade_12th reservationgrade_bach reservationgrade_abov, after(reservationgrade)


ta reservationkind
split reservationkind, destring
recode reservationkind1 reservationkind2 reservationkind3 reservationkind4 (77=6)
forvalues i=1/6 {
gen reservationkind_`i'=0 if reservationkind!=""
}
forvalues i=1/6 {
replace reservationkind_`i'=1 if reservationkind1==`i'
replace reservationkind_`i'=1 if reservationkind2==`i'
replace reservationkind_`i'=1 if reservationkind3==`i'
replace reservationkind_`i'=1 if reservationkind4==`i'
label var reservationkind_`i' "reservationkind=`i'"
label values reservationkind_`i' yesno
}
rename reservationkind_1 reservationkind_quot
rename reservationkind_2 reservationkind_free
rename reservationkind_3 reservationkind_scho
rename reservationkind_4 reservationkind_spec
rename reservationkind_5 reservationkind_meal
rename reservationkind_6 reservationkind_othe
drop reservationkind1 reservationkind2 reservationkind3 reservationkind4
order reservationkind_quot reservationkind_free reservationkind_scho reservationkind_spec reservationkind_meal reservationkind_othe, after(reservationkind)



ta reasonneverattendedschool
replace reasonneverattendedschool="" if reasonneverattendedschool=="."
split reasonneverattendedschool, destring
forvalues i=1/13 {
gen reasonneverattendedschool_`i'=0 if reasonneverattendedschool!=""
}
forvalues i=1/13 {
replace reasonneverattendedschool_`i'=1 if reasonneverattendedschool1==`i'
replace reasonneverattendedschool_`i'=1 if reasonneverattendedschool2==`i'
label values reasonneverattendedschool_`i' yesno
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
order reasonneverattendedschool_fail reasonneverattendedschool_inac reasonneverattendedschool_qual reasonneverattendedschool_fina reasonneverattendedschool_heal reasonneverattendedschool_noin reasonneverattendedschool_care reasonneverattendedschool_work reasonneverattendedschool_girl reasonneverattendedschool_marr reasonneverattendedschool_noal reasonneverattendedschool_pube reasonneverattendedschool_baby, after(reasonneverattendedschool)



ta reasondropping
replace reasondropping="" if reasondropping=="."
split reasondropping, destring
recode reasondropping1 reasondropping2 (77=16)
forvalues i=1/16 {
gen reasondropping_`i'=0 if reasondropping!=""
}
forvalues i=1/16 {
replace reasondropping_`i'=1 if reasondropping1==`i'
replace reasondropping_`i'=1 if reasondropping2==`i'
label values reasondropping_`i' yesno
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
rename reasondropping_15 reasondropping_covi
rename reasondropping_16 reasondropping_othe
drop reasondropping1 reasondropping2
order reasondropping_stop reasondropping_fail reasondropping_inac reasondropping_qual reasondropping_fina reasondropping_heal reasondropping_noin reasondropping_care reasondropping_work reasondropping_girl reasondropping_marr reasondropping_noal reasondropping_pube reasondropping_baby reasondropping_covi reasondropping_othe, after(reasondropping)


destring covgoingbackschool, replace
label values covgoingbackschool yesno


ta kindofworkinactive
split kindofworkinactive, destring





save"Last/NEEMSIS2-HH", replace
****************************************
* END


