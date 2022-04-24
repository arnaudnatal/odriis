cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
April 24, 2022
-----
Restitutions
-----

-------------------------
*/









****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
********** Path to folder "data" folder.
global directory = "C:\Users\Arnaud\Documents\_Thesis\Restitution_NEEMSIS2"
cd"$directory"
global git "C:\Users\Arnaud\Documents\GitHub"
global dropbox "C:\Users\Arnaud\Documents\Dropbox\RUME-NEEMSIS\Data"


********** Name of the NEEMSIS2 questionnaire version to clean
global wave1 "RUME-HH"
global wave2 "NEEMSIS1-HH"
global wave3 "NEEMSIS2-HH"

global loan1 "RUME-all_loans"
global loan2 "NEEMSIS1-all_loans"
global loan3 "NEEMSIS2-all_loans"


********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020



****************************************
* END








****************************************
* Data
***************************************

***** HH
use"$dropbox\RUME\\$wave1", clear
save"$directory\wave1.dta", replace

use"$dropbox\NEEMSIS1\\$wave2", clear
save"$directory\wave2.dta", replace

use"$dropbox\NEEMSIS2\LAST\\$wave3", clear
save"$directory\wave3.dta", replace


***** Loans
use"$dropbox\RUME\\$loan1", clear
save"$directory\loan1.dta", replace

use"$dropbox\NEEMSIS1\\$loan2", clear
save"$directory\loan2.dta", replace

use"$dropbox\NEEMSIS2\LAST\\$loan3", clear
save"$directory\loan3.dta", replace


***** Panel
use"$dropbox\Panel\ODRIIS-HH.dta", clear
save"$directory\ODRIIS-HH.dta", replace

use"$dropbox\Panel\ODRIIS-indiv.dta", clear
save"$directory\ODRIIS-indiv.dta", replace

****************************************
* END










****************************************
* Nb of HH
****************************************

use "ODRIIS-HH", clear
reshape long caste jatis villagearea HHID address villageid, i(HHID_panel) j(year)

ta villagearea year if villageid=="ORA"

graph bar (count), over(villagearea) over(year)

****************************************
* END





****************************************
* Migration
****************************************

********** 2016-17
use "wave2", clear
fre livinghome
drop if livinghome==1
drop if livinghome==4

ta lefthomereason reasonlefthome
ta villagearea reasonlefthome

keep villagearea reasonlefthome HHID_panel year INDID_panel
save "wave2_tempmigr", replace


********** 2020-21
use"wave3",clear

keep villagearea reasonlefthome HHID_panel year INDID_panel
append using "wave2_tempmigr"

fre reasonlefthome
drop if reasonlefthome==4
drop if reasonlefthome==77
drop if reasonlefthome==.

graph bar (count), over(reasonlefthome) over(year)

erase "wave2_tempmigr.dta"
****************************************
* END







****************************************
* Agri + toilet + items + HH debt
****************************************

********** 2010
use "wave1", clear
duplicates drop HHID_panel, force

keep HHID_panel year villagearea ownland leaseland sizeownland sizeleaseland numbergoods_car numbergoods_bike numbergoods_fridge numbergoods_furniture numbergoods_tailormach numbergoods_phone numbergoods_landline numbergoods_camera numbergoods_cookgas numbergoods_computer numbergoods_antenna loans_HH loanamount_HH villageid

save"wave1_tempagr", replace



********** 2016-17
use "wave2", clear
duplicates drop HHID_panel, force

keep HHID_panel year villagearea ownland leaseland sizeownland sizeleaseland toiletfacility numbergoods_car numbergoods_bike numbergoods_fridge numbergoods_furniture numbergoods_tailormach numbergoods_phone numbergoods_landline numbergoods_camera numbergoods_cookgas numbergoods_computer numbergoods_antenna loans_HH loanamount_HH villageid
save"wave2_tempagr", replace



********** 2020-21
use "wave3", clear
duplicates drop HHID_panel, force

destring ownland leaseland toiletfacility, replace
keep HHID_panel year villagearea ownland leaseland sizeownland sizeleaseland toiletfacility numbergoods_car numbergoods_bike numbergoods_fridge numbergoods_furniture numbergoods_tailormach numbergoods_phone numbergoods_landline numbergoods_camera numbergoods_cookgas numbergoods_computer numbergoods_antenna loans_HH loanamount_HH villageid



********** Append
append using "wave1_tempagr"
append using "wave2_tempagr"



***** Clean
replace ownland=0 if ownland==.
replace leaseland=0 if leaseland==.

ta year



********** Agri
gen haveland=ownland+leaseland
recode haveland (2=1)
recode haveland (.=0)
egen  landsize=rowtotal(sizeownland sizeleaseland)

graph bar haveland, over(year)
preserve
drop if ownland==0 & leaseland==0
graph bar landsize, over(year)
restore


********** Items
foreach x in numbergoods_car numbergoods_bike numbergoods_fridge numbergoods_furniture numbergoods_tailormach numbergoods_phone numbergoods_landline numbergoods_camera numbergoods_cookgas numbergoods_computer numbergoods_antenna {
replace `x'=0 if `x'==.
replace `x'=1 if `x'>1
}


ta villagearea year
foreach x in phone {
graph bar numbergoods_`x' if villagearea==10, over(year)
}







****************************************
* END





****************************************
* Education + Occupation + debt
****************************************
use"wave2", clear

gen edu=.
label define edu 1"Not read" 2"Primary school (1-8)" 3"High-school (9-10)" 4"Higher secondary school (10-12)" 5"Higher (13-)"
label values edu edu
replace edu=1 if canread==1
replace edu=1 if classcompleted==1
replace edu=2 if classcompleted==2
replace edu=2 if classcompleted==3
replace edu=2 if classcompleted==4
replace edu=2 if classcompleted==5
replace edu=2 if classcompleted==6
replace edu=2 if classcompleted==7
replace edu=2 if classcompleted==8
replace edu=3 if classcompleted==9
replace edu=3 if classcompleted==10
replace edu=4 if classcompleted==11
replace edu=4 if classcompleted==12
replace edu=5 if classcompleted==13
replace edu=5 if classcompleted==14
replace edu=5 if classcompleted==15
replace edu=5 if classcompleted==16

ta villagearea edu



********** Job
ta mainocc_occupation_indiv


********** Debt
tabstat loanamount_indiv, stat(n mean) by(mainocc_occupation_indiv)

****************************************
* END
