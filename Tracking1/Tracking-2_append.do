cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
January 29, 2021
-----
Tracking cleaning
-----

-------------------------
*/


****************************************
* INITIALIZATION
****************************************
clear all
global directory "C:\Users\Arnaud\Documents\MEGA\Data\Data_Tracking2019\DATA"
cd"$directory"
****************************************
* END










****************************************
* Database created
****************************************

********** Introduction
*use"NEEMSIS-tracking_intro.dta", clear

********** HH
*use"NEEMSIS-tracking_HH.dta", clear

*use"NEEMSIS-tracking_HH-indiv.dta", clear
*use"NEEMSIS-tracking_HH-HH.dta", clear



********** Migration quest
*use"NEEMSIS-tracking_migr.dta", clear

*use"NEEMSIS-tracking_migr-migr.dta", clear
*use"NEEMSIS-tracking_migr-help.dta", clear



********** Individual
*use"NEEMSIS-tracking_indiv.dta", clear

*use"NEEMSIS-tracking_indiv-charact_p1.dta", clear
use"NEEMSIS-tracking_indiv-occup_main.dta", clear
use"NEEMSIS-tracking_indiv-occup_loan.dta", clear
use"NEEMSIS-tracking_indiv-occup_loan_lender.dta", clear
use"NEEMSIS-tracking_indiv-occup_labourer.dta", clear

use"NEEMSIS-tracking_indiv-migration_job.dta", clear
use"NEEMSIS-tracking_indiv-wagejobpaymentinkind.dta", clear
use"NEEMSIS-tracking_indiv-remtsent.dta", clear
use"NEEMSIS-tracking_indiv-remtreceived.dta", clear
use"NEEMSIS-tracking_indiv-remtreceived_source.dta", clear
use"NEEMSIS-tracking_indiv-asso.dta", clear
use"NEEMSIS-tracking_indiv-asso_reco.dta", clear
use"NEEMSIS-tracking_indiv-contact.dta", clear
****************************************
* END


/*
key											migjobid
uuid:3622a49a-67f7-41ee-bfb3-bc75c71c4bd8	1
uuid:5c386cd5-75e1-4d75-858d-6b68827eb7fe	1
uuid:2c9571e4-3d34-4a78-ad16-72725c7f6476	1
uuid:ea380683-ef0f-40b1-b744-3eda664f27c1	1
*/






****************************************
* Merge and append database
****************************************



********** 
/*
Split individual questionnaire database between 
main migrants and others migrants
and save in two separate database
*/
use"NEEMSIS-tracking_indiv-charact_p1.dta", clear
merge m:1 key using "NEEMSIS-tracking_intro.dta", keepusing(rankingmigrant)
drop _merge

order key rankingmigrant
sort key indid2

decode rankingmigrant, gen(rankingmigrant_str)
order rankingmigrant_str, after(rankingmigrant)

gen dummymainmigrant=0
replace dummymainmigrant=1 if rankingmigrant_str==name
replace dummymainmigrant=1 if rankingmigrant_str==""
replace dummymainmigrant=0 if key=="uuid:5c819ddf-02b7-437b-a828-bd1121ddf5df" & name=="Manju"

preserve
keep if dummymainmigrant==1
save"NEEMSIS-tracking_indiv-main.dta", replace
restore
keep if dummymainmigrant==0
save"NEEMSIS-tracking_indiv-other.dta", replace



********** 
/*
Add migration questionnaire to individual main migrant one
then append the other migrants database
*/
use"NEEMSIS-tracking_indiv-main.dta", clear
merge 1:1 key using "NEEMSIS-tracking_migr-migr.dta"
drop _merge
append using "NEEMSIS-tracking_indiv-other.dta"
save"NEEMSIS-tracking_indiv_migr.dta", replace



********** 
/*
Merge together intro questionnaire (geoloc, etc.),
with HH questionnaire
Because both at household level
*/
use"NEEMSIS-tracking_intro.dta", clear
merge 1:1 key using "NEEMSIS-tracking_HH-HH.dta"
drop _merge
save"NEEMSIS-tracking_HH_v2.dta", replace



********** 
/*
Append all indiv in the same database
(new member + migrants database)
Then add household level variables
Also, remove occupation var to put in another database
*/
use"NEEMSIS-tracking_HH-indiv.dta", clear
gen dummynewmb=1
order key indid dummynewmb
append using "NEEMSIS-tracking_indiv_migr.dta"
drop rankingmigrant rankingmigrant_str

merge m:1 key using "NEEMSIS-tracking_HH_v2.dta"
drop _merge

preserve
keep key indid occupationnumber occupationname kindofwork monthsayear daysamonth hoursaday annualincome hoursayear joblocation
keep if occupationname!=""
restore
save"NEEMSIS-tracking.dta", replace



**********
/*
Add indid2 to migration help database for future 
merging if needed
*/
use"NEEMSIS-tracking.dta", clear
keep if dummymainmigrant==1
keep key indid2
save"NEEMSIS-tracking_indid2.dta", replace

use"NEEMSIS-tracking_migr-help.dta", clear
merge m:1 key using "NEEMSIS-tracking_indid2.dta"
keep if _merge==3
drop _merge
order key indid2
sort key indid2
save"NEEMSIS-tracking_migr-help_v2.dta", replace



**********
/*
Check all the id
*/
use"NEEMSIS-tracking_indiv-occup_main.dta", clear
fre indid2 occupid
order key indid2 occupid
sort key indid2 occupid
save"NEEMSIS-tracking_occupations.dta", replace

use"NEEMSIS-tracking_indiv-occup_loan.dta", clear
fre indid2 occupid loanid
keep if mignumberbusinessloan!=.
save"NEEMSIS-tracking_indiv-occup_loan.dta", replace


use"NEEMSIS-tracking_indiv-occup_loan_lender.dta", clear
use"NEEMSIS-tracking_indiv-occup_labourer.dta", clear

use"NEEMSIS-tracking_indiv-migration_job.dta", clear
use"NEEMSIS-tracking_indiv-wagejobpaymentinkind.dta", clear
use"NEEMSIS-tracking_indiv-remtsent.dta", clear
use"NEEMSIS-tracking_indiv-remtreceived.dta", clear
use"NEEMSIS-tracking_indiv-remtreceived_source.dta", clear
use"NEEMSIS-tracking_indiv-asso.dta", clear
use"NEEMSIS-tracking_indiv-asso_reco.dta", clear
use"NEEMSIS-tracking_indiv-contact.dta", clear






****************************************
* END

