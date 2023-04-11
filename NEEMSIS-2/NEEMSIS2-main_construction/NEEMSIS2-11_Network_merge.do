cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
02/05/21
-----
TITLE: Network
-------------------------
*/



****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "C:\Users\Arnaud\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global git = "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

*global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*global git ="C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"

cd"$directory"
clear all
****************************************
* END




****************************************
* Formal social capital:asso
****************************************
use"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-formalsocialcapital_v2.dta", clear

global tokeep parent_key egoid associationid associationtype associationname assodegreeparticip assosize dummyassorecommendation snrecommendasso dummyassohelpjob assohelpjob assocotherhelpjob dummyassohelpbusiness assohelpbusiness assootherhelpbusiness key setof_2snrecommendassoid setof_2snrecommendassogroup setof_2formalsocialcapital setofsnrecommendassoid setofsnrecommendassogroup setofformalsocialcapital setof_3snrecommendassoid setof_3snrecommendassogroup setof_3formalsocialcapital snrecommendassogroup_count
keep $tokeep
order $tokeep
keep if associationname!=""
destring assodegreeparticip assosize dummyassorecommendation snrecommendasso dummyassohelpjob assohelpjob dummyassohelpbusiness assohelpbusiness assohelpjob associationid, replace
drop setof_2snrecommendassoid setof_2snrecommendassogroup setof_2formalsocialcapital setofsnrecommendassoid setofsnrecommendassogroup setofformalsocialcapital setof_3snrecommendassoid setof_3snrecommendassogroup setof_3formalsocialcapital snrecommendassogroup_count
sort parent_key egoid associationid


* Type
tab associationtype
replace associationtype="2" if associationtype=="SHG Group"
replace associationtype="3" if associationtype=="Trade Union"
replace associationtype="4" if associationtype=="Farmer Union"
replace associationtype="5" if associationtype=="Village council (panchayat)"
replace associationtype="6" if associationtype=="Political party"
replace associationtype="7" if associationtype=="Professional (occupational) association"
replace associationtype="10" if associationtype=="Hobby club, sports group, cultural association"
replace associationtype="11" if associationtype=="Alumni association"
replace associationtype="12" if associationtype=="Other association"
tab associationtype
destring associationtype, replace
label define associationtype 1"Youth Union" 2"SHG Group" 3"Trade Union" 4"Farmer Union" 5"Village council (panchayat)" 6"Political party" 7"Professional association" 8"Market committee" 9"Religious group" 10"Hobby club, sports group, cultural association" 11"Alumni association" 12"Other association" 13"None"
label values associationtype associationtype
tab associationtype

* Degree
tab assodegreeparticip
destring assodegreeparticip, replace
label define assodegreeparticip 1"Leader" 2"Active" 3"Simple member" 
label values assodegreeparticip assodegreeparticip
tab assodegreeparticip

* Size
tab assosize
destring assosize, replace
label define assosize 1"2-10" 2"11-50" 3"51-100" 4">100" 88"D/K"
label values assosize assosize
tab assosize

* Dummy
tab dummyassorecommendation
destring dummyassorecommendation, replace
label define yesno 0"No" 1"Yes"
label values dummyassorecommendation yesno
label values dummyassohelpjob yesno
label values dummyassohelpbusiness yesno
fre dummyassorecommendation dummyassohelpjob dummyassohelpbusiness


* Asso job
ta assohelpjob
foreach i in 1 2 3 4 77 {
gen assohelpjob_`i'=.
}
foreach i in 1 2 3 4 77 {
replace assohelpjob_`i'=0 if dummyassohelpjob==1
replace assohelpjob_`i'=1 if strpos(assohelpjob,"`i'")
label values assohelpjob_`i' yesno
}
rename assohelpjob_1 assohelpjob_hiredyou
rename assohelpjob_2 assohelpjob_referredyou
rename assohelpjob_3 assohelpjob_sharedjob
rename assohelpjob_4 assohelpjob_helpwithappli
rename assohelpjob_77 assohelpjob_other
fre assohelpjob_hiredyou

order assohelpjob_hiredyou assohelpjob_referredyou assohelpjob_sharedjob assohelpjob_helpwithappli assohelpjob_other, after(assohelpjob)

* Asso helpbusiness
fre assohelpbusiness
label define assohelpbusiness 1"Advice on how to run business (managerial support, accounting)" 2"New information useful for business" 3"New customers/suppliers" 4"Find/Improve premises" 5"Financial support" 6"Other material support" 7"Emotional support" 77"Other"
label values assohelpbusiness assohelpbusiness
fre assohelpbusiness


* Wide
tostring egoid, replace
gen indiv=parent_key + "ego" + egoid
drop key
drop associationid
bysort indiv: gen associationid=_n
fre associationid
order indiv parent_key egoid associationid
sort indiv associationid

reshape wide associationtype associationname assodegreeparticip assosize dummyassorecommendation snrecommendasso dummyassohelpjob assohelpjob assohelpjob_hiredyou assohelpjob_referredyou assohelpjob_sharedjob assohelpjob_helpwithappli assohelpjob_other assocotherhelpjob dummyassohelpbusiness assohelpbusiness assootherhelpbusiness, i(indiv) j(associationid)
drop indiv
destring egoid, replace
order parent_key egoid
sort parent_key egoid


save"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-formalsocialcapital_v2_wide.dta", replace
****************************************
* END





****************************************
* Contact
****************************************
use"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-networkresources-contactgroup_v2", clear
destring contactid, replace
sort parent_key egoid contactid
keep if contactnumber!=.
tab contactname contactid

drop key setof_2contactgroup setof_3contactgroup setofcontactgroup
egen indiv=concat(parent_key egoid), p(ego)
drop parent_key egoid contactname
reshape wide contactnumber, i(indiv) j(contactid)

rename contactnumber1 nbcontact_headbusiness
rename contactnumber2 nbcontact_policeman
rename contactnumber3 nbcontact_civilserv
rename contactnumber4 nbcontact_bankemployee
rename contactnumber5 nbcontact_panchayatcommittee
rename contactnumber6 nbcontact_peoplecouncil
rename contactnumber7 nbcontact_recruiter
rename contactnumber8 nbcontact_headunion

split indiv, p(ego)
rename indiv1 parent_key
rename indiv2 egoid
destring egoid, replace
drop indiv
order parent_key egoid

save"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-networkresources-contactgroup_v2_wide.dta", replace
****************************************
* END









****************************************
* Merging with HH database
****************************************
use"$directory\CLEAN\NEEMSIS2-HH_v17.dta", clear

merge m:1 parent_key egoid using "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-formalsocialcapital_v2_wide.dta"
drop if _merge==2
drop _merge

merge m:1 parent_key egoid using "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-networkresources-contactgroup_v2_wide.dta"
drop if _merge==2
drop _merge

*Cleaning des set of au passage
drop setofbusinessloandetails setofwagejobpaymentinkindgroup setofcovoccupationfieldlist setofformalsocialcapital setofsnfindcurrentjobid setofsnfindcurrentjobgroup setofsnfindjobid setofsnfindjobgroup setofsnrecommendforjobid setofsnrecommendforjobgroup setofsntalkthemostid setofsntalkthemostgroup setofsncloserelouthhid setofsncloserelouthhgroup setofcovsntypehelpreceivedgroup setofcovsntypehelpgivengroup setofcontactgroup setofshow_draws setofshow_draws_2 setofshow_draws_3 setof_2wagejobpaymentinkindgroup setof_2covoccupationfieldlist setof_2formalsocialcapital setof_2snfindcurrentjobid setof_2snfindcurrentjobgroup setof_2snfindjobid setof_2snfindjobgroup setof_2sntalkthemostid setof_2sntalkthemostgroup setof_2snhelpemergencyid setof_2snhelpemergencygroup setof_2sncloserelouthhid setof_2sncloserelouthhgroup setof_2covsnhelpreceivedid setof_2covsnhelpreceivedgroup setof_2covsntypehelpreceivedgrou setof_2covsntypehelpgivengroup setof_2contactgroup setof_3show_draws setof_3show_draws_2 setof_3show_draws_3 setof_3wagejobpaymentinkindgroup setof_3covoccupationfield setof_3formalsocialcapital setof_3snfindcurrentjobid setof_3snfindcurrentjobgroup setof_3snfindjobid setof_3snfindjobgroup setof_3sntalkthemostid setof_3sntalkthemostgroup setof_3snhelpemergencyid setof_3snhelpemergencygroup setof_3sncloserelouthhid setof_3sncloserelouthhgroup setof_3covsntypehelpreceivedgrou setof_3covsntypehelpgivengroup setof_3contactgroup

save"$directory\CLEAN\NEEMSIS2-HH_v18.dta", replace
*save"C:\Users\Arnaud\Dropbox\RUME-NEEMSIS\NEEMSIS2\NEEMSIS2-HH_v18.dta", replace
****************************************
* END
