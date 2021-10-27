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


clear all
macro drop _all
cls
********** Path to folder "data" folder.
*global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"

cd"$directory"
clear all





****************************************
* Formal social capital:asso
****************************************
use"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-formalsocialcapital_v2.dta", clear

keep if associationname!=""
dropmiss, force
tab snrecommendasso
drop snrecommendasso_*

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
tab dummyassorecommendation

* Id
destring associationid, replace
fre associationtype
/*
associationtype
-------------------------------------------------------------------------------------------------------
                                                          |      Freq.    Percent      Valid       Cum.
----------------------------------------------------------+--------------------------------------------
Valid   2  SHG Group                                      |         76      44.44      44.44      44.44
        3  Trade Union                                    |          1       0.58       0.58      45.03
        4  Farmer Union                                   |         12       7.02       7.02      52.05
        5  Village council (panchayat)                    |         10       5.85       5.85      57.89
        6  Political party                                |         58      33.92      33.92      91.81
        7  Professional association                       |         10       5.85       5.85      97.66
        10 Hobby club, sports group, cultural association |          1       0.58       0.58      98.25
        11 Alumni association                             |          1       0.58       0.58      98.83
        12 Other association                              |          2       1.17       1.17     100.00
        Total                                             |        171     100.00     100.00           
-------------------------------------------------------------------------------------------------------
*/					

* Wide
tostring egoid, replace
gen indiv=parent_key + "ego" + egoid
keep associationtype associationname assodegreeparticip assosize dummyassorecommendation indiv associationid
reshape wide associationtype associationname assodegreeparticip assosize dummyassorecommendation, i(indiv) j(associationid)
split indiv, p(ego)
rename indiv1 parent_key
rename indiv2 egoid
destring egoid, replace

foreach x in associationtype associationname assodegreeparticip assosize dummyassorecommendation{
rename `x'2 `x'_shg
rename `x'3 `x'_trade
rename `x'4 `x'_farmer
rename `x'5 `x'_village
rename `x'6 `x'_politic
rename `x'7 `x'_profess
rename `x'10  `x'_hobby
rename `x'11 `x'_alumni
rename `x'12 `x'_other
}

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
