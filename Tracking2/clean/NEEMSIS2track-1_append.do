/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
October 6, 2022
-----
CLEANING ALL LONG FILES OF NEEMSIS2
-----
-------------------------
*/



****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
*global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\Data_Tracking2022\raw"

********** Name of the NEEMSIS2 questionnaire version to clean
*global preamble "`dbv'"
global preamble "NEEMSIS2 tracking 2022"

****************************************
* END






filelist, dir("$directory\NEEMSIS tracking 2022") pattern(*.dta)
/*
NEEMSIS tracking 2022-hhquestionnairemig-detailsgoods.dta
NEEMSIS tracking 2022-hhquestionnairemig-livestockgp-livestock.dta
NEEMSIS tracking 2022-hhquestionnairemig1-familymembers.dta
NEEMSIS tracking 2022-hhquestionnairemig1-individualid.dta
NEEMSIS tracking 2022-migbusinesssourceinvestgroup2-migsnbusilendid.dta
NEEMSIS tracking 2022-migemployment-migoccupations.dta
NEEMSIS tracking 2022-migmigration-migmigrationjobidgroup.dta
NEEMSIS tracking 2022-migmigrationstep.dta
NEEMSIS tracking 2022-migmigrationtrajectory-migsnhelpmigid.dta
NEEMSIS tracking 2022-migquestionnaire-migquestionnaireid.dta
NEEMSIS tracking 2022-migremittances-migremittancessentidgroup.dta
NEEMSIS tracking 2022-migselfemploy-migsourceinvestment-migbusinesssourceinvestgroup.dta
NEEMSIS tracking 2022-migsocialnetworks-migformalsocialcapital.dta
NEEMSIS tracking 2022-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnfindjobgroup.dta
NEEMSIS tracking 2022-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnfindjobid.dta
NEEMSIS tracking 2022-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnrecommendforjobgroup.dta
NEEMSIS tracking 2022-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnrecommendforjobid.dta
NEEMSIS tracking 2022-migsocialnetworks-mignetworkresources-migcontactgroup.dta
NEEMSIS tracking 2022-occupationgp-occupations.dta
NEEMSIS tracking 2022.dta
*/




filelist, dir("$directory\NEEMSIS tracking 2022 new") pattern(*.dta)
/*
NEEMSIS tracking 2022 new-hhquestionnairemig-detailsgoods.dta
NEEMSIS tracking 2022 new-hhquestionnairemig-livestockgp-livestock.dta
NEEMSIS tracking 2022 new-hhquestionnairemig1-familymembers.dta
NEEMSIS tracking 2022 new-hhquestionnairemig1-individualid.dta
NEEMSIS tracking 2022 new-migbusinesssourceinvestgroup2-migsnbusilendid.dta
NEEMSIS tracking 2022 new-migemployment-migoccupations.dta
NEEMSIS tracking 2022 new-migindividualemployment-migcharacteristicsmainjob-migindwagejob-migwagejobpaymentinkindgroup.dta
NEEMSIS tracking 2022 new-migmigration-migmigrationjobidgroup.dta
NEEMSIS tracking 2022 new-migmigrationstep.dta
NEEMSIS tracking 2022 new-migmigrationtrajectory-migsnhelpmigid.dta
NEEMSIS tracking 2022 new-migquestionnaire-migquestionnaireid.dta
NEEMSIS tracking 2022 new-migremittances-migremittancesreceivedsourceidgroup.dta
NEEMSIS tracking 2022 new-migremittances-migremittancessentidgroup.dta
NEEMSIS tracking 2022 new-migselfemploy-miglabourers-migbusinesslabourers.dta
NEEMSIS tracking 2022 new-migselfemploy-migsourceinvestment-migbusinesssourceinvestgroup.dta
NEEMSIS tracking 2022 new-migsnrecommendassoid.dta
NEEMSIS tracking 2022 new-migsocialnetworks-migformalsocialcapital.dta
NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalselfemp-migsnrecruitworkergroup.dta
NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalselfemp-migsnrecruitworkerid.dta
NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalselfemp-migsntechnicalhelpgroup.dta
NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalselfemp-migsntechnicalhelpid.dta
NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnfindjobgroup.dta
NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnfindjobid.dta
NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnrecommendforjobgroup.dta
NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnrecommendforjobid.dta
NEEMSIS tracking 2022 new-migsocialnetworks-mignetworkresources-migcontactgroup.dta
NEEMSIS tracking 2022 new-occupationgp-occupations.dta
NEEMSIS tracking 2022 new.dta
*/







********** Append
cd"C:\Users\Arnaud\Documents\MEGA\Data\Data_Tracking2022\raw\combine"

***** Base 1
use"NEEMSIS tracking 2022-hhquestionnairemig-detailsgoods.dta", clear
gen base="old"
append using "NEEMSIS tracking 2022 new-hhquestionnairemig-detailsgoods.dta"
save"NEEMSIS2track-detailsgoods", replace
erase"NEEMSIS tracking 2022-hhquestionnairemig-detailsgoods.dta"
erase"NEEMSIS tracking 2022 new-hhquestionnairemig-detailsgoods.dta"




***** Base 2
use"NEEMSIS tracking 2022-hhquestionnairemig-livestockgp-livestock.dta", clear
gen base="old"
append using "NEEMSIS tracking 2022 new-hhquestionnairemig-livestockgp-livestock.dta"
save"NEEMSIS2track-livestock", replace
erase"NEEMSIS tracking 2022-hhquestionnairemig-livestockgp-livestock.dta"
erase"NEEMSIS tracking 2022 new-hhquestionnairemig-livestockgp-livestock.dta"



***** Base 3
use"NEEMSIS tracking 2022-hhquestionnairemig1-familymembers.dta", clear
gen base="old"
drop *_label
append using "NEEMSIS tracking 2022 new-hhquestionnairemig1-familymembers.dta"
save"NEEMSIS2track-familymembers", replace
erase"NEEMSIS tracking 2022-hhquestionnairemig1-familymembers.dta"
erase"NEEMSIS tracking 2022 new-hhquestionnairemig1-familymembers.dta"



***** Base 4
use"NEEMSIS tracking 2022-hhquestionnairemig1-individualid.dta", clear
gen base="old"
append using "NEEMSIS tracking 2022 new-hhquestionnairemig1-individualid.dta"
save"NEEMSIS2track-individualid.dta", replace
erase"NEEMSIS tracking 2022-hhquestionnairemig1-individualid.dta"
erase"NEEMSIS tracking 2022 new-hhquestionnairemig1-individualid.dta"



***** Base 5
use"NEEMSIS tracking 2022-migbusinesssourceinvestgroup2-migsnbusilendid.dta", clear
gen base="old"
append using "NEEMSIS tracking 2022 new-migbusinesssourceinvestgroup2-migsnbusilendid.dta"
save"NEEMSIS2track-snbusilendid", replace
erase"NEEMSIS tracking 2022-migbusinesssourceinvestgroup2-migsnbusilendid.dta"
erase"NEEMSIS tracking 2022 new-migbusinesssourceinvestgroup2-migsnbusilendid.dta"



***** Base 6
use"NEEMSIS tracking 2022-migemployment-migoccupations.dta", clear
drop setofmigbusinesslabourers
drop *_label *_labe
gen base="old"
append using "NEEMSIS tracking 2022 new-migemployment-migoccupations.dta"
save"NEEMSIS2track-migoccupations", replace
erase"NEEMSIS tracking 2022-migemployment-migoccupations.dta"
erase"NEEMSIS tracking 2022 new-migemployment-migoccupations.dta"



***** Base 7
use"NEEMSIS tracking 2022-migmigration-migmigrationjobidgroup.dta", clear
gen base="old"
append using "NEEMSIS tracking 2022 new-migmigration-migmigrationjobidgroup.dta"
save"NEEMSIS2track-migrationjobidgroup", replace
erase"NEEMSIS tracking 2022-migmigration-migmigrationjobidgroup.dta"
erase"NEEMSIS tracking 2022 new-migmigration-migmigrationjobidgroup.dta"



***** Base 8
use"NEEMSIS tracking 2022-migmigrationstep.dta", clear
drop *_label
gen base="old"
append using "NEEMSIS tracking 2022 new-migmigrationstep.dta"
save"NEEMSIS2track-migrationstep", replace
erase"NEEMSIS tracking 2022-migmigrationstep.dta"
erase"NEEMSIS tracking 2022 new-migmigrationstep.dta"



***** Base 9
use"NEEMSIS tracking 2022-migmigrationtrajectory-migsnhelpmigid.dta", clear
drop *_label
gen base="old"
append using "NEEMSIS tracking 2022 new-migmigrationtrajectory-migsnhelpmigid.dta"
save"NEEMSIS2track-snhelpmigid", replace
erase"NEEMSIS tracking 2022-migmigrationtrajectory-migsnhelpmigid.dta"
erase"NEEMSIS tracking 2022 new-migmigrationtrajectory-migsnhelpmigid.dta"


***** Base 10
use"NEEMSIS tracking 2022-migquestionnaire-migquestionnaireid.dta", clear
drop *_label *_la *_labe *_lab
drop v451 setofmigwagejobpaymentinkindgrou setofmigremittancesreceivedsourc setofmigsntechnicalhelpid setofmigsntechnicalhelpgroup setofmigsnrecruitworkerid setofmigsnrecruitworkergroup
gen base="old"
append using "NEEMSIS tracking 2022 new-migquestionnaire-migquestionnaireid.dta"
save"NEEMSIS2track-migquestion", replace
erase"NEEMSIS tracking 2022-migquestionnaire-migquestionnaireid.dta"
erase"NEEMSIS tracking 2022 new-migquestionnaire-migquestionnaireid.dta"



***** Base 11
use"NEEMSIS tracking 2022-migremittances-migremittancessentidgroup.dta", clear
gen base="old"
append using "NEEMSIS tracking 2022 new-migremittances-migremittancessentidgroup.dta"
save"NEEMSIS2track-remittancessentidgroup", replace
erase"NEEMSIS tracking 2022-migremittances-migremittancessentidgroup.dta"
erase"NEEMSIS tracking 2022 new-migremittances-migremittancessentidgroup.dta"


***** Base 12
use"NEEMSIS tracking 2022-migselfemploy-migsourceinvestment-migbusinesssourceinvestgroup.dta", clear
gen base="old"
append using "NEEMSIS tracking 2022 new-migselfemploy-migsourceinvestment-migbusinesssourceinvestgroup.dta"
save"NEEMSIS2track-businesssourceinvestgroup", replace
erase"NEEMSIS tracking 2022-migselfemploy-migsourceinvestment-migbusinesssourceinvestgroup.dta"
erase"NEEMSIS tracking 2022 new-migselfemploy-migsourceinvestment-migbusinesssourceinvestgroup.dta"



***** Base 13
use"NEEMSIS tracking 2022-migsocialnetworks-migformalsocialcapital.dta", clear
drop setofmigsnrecommendassoid *_label
gen base="old"
append using "NEEMSIS tracking 2022 new-migsocialnetworks-migformalsocialcapital.dta"
save"NEEMSIS2track-formalsocialcapital", replace
erase"NEEMSIS tracking 2022-migsocialnetworks-migformalsocialcapital.dta"
erase"NEEMSIS tracking 2022 new-migsocialnetworks-migformalsocialcapital.dta"



***** Base 14
use"NEEMSIS tracking 2022-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnfindjobgroup.dta", clear
gen base="old"
append using "NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnfindjobgroup.dta"
save"NEEMSIS2track-snfindjobgroup", replace
erase"NEEMSIS tracking 2022-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnfindjobgroup.dta"
erase"NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnfindjobgroup.dta"



***** Base 15
use"NEEMSIS tracking 2022-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnfindjobid.dta", clear
gen base="old"
append using "NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnfindjobid.dta"
save"NEEMSIS2track-snfindjobid", replace
erase"NEEMSIS tracking 2022-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnfindjobid.dta"
erase"NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnfindjobid.dta"



***** Base 16
use"NEEMSIS tracking 2022-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnrecommendforjobgroup.dta", clear
gen base="old"
append using "NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnrecommendforjobgroup.dta"
save"NEEMSIS2track-snrecommendforjobgroup", replace
erase"NEEMSIS tracking 2022-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnrecommendforjobgroup.dta"
erase"NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnrecommendforjobgroup.dta"



***** Base 17
use"NEEMSIS tracking 2022-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnrecommendforjobid.dta", clear
gen base="old"
append using "NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnrecommendforjobid.dta"
save"NEEMSIS2track-snrecommendforjobid", replace
erase"NEEMSIS tracking 2022-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnrecommendforjobid.dta"
erase"NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalwageworker-migsnrecommendforjobid.dta"



***** Base 18
use"NEEMSIS tracking 2022-migsocialnetworks-mignetworkresources-migcontactgroup.dta", clear
gen base="old"
append using "NEEMSIS tracking 2022 new-migsocialnetworks-mignetworkresources-migcontactgroup.dta"
save"NEEMSIS2track-contactgroup", replace
erase"NEEMSIS tracking 2022-migsocialnetworks-mignetworkresources-migcontactgroup.dta"
erase"NEEMSIS tracking 2022 new-migsocialnetworks-mignetworkresources-migcontactgroup.dta"



***** Base 19
use"NEEMSIS tracking 2022-occupationgp-occupations.dta", clear
gen base="old"
append using "NEEMSIS tracking 2022 new-occupationgp-occupations.dta"
save"NEEMSIS2track-occupations", replace
erase"NEEMSIS tracking 2022-occupationgp-occupations.dta"
erase"NEEMSIS tracking 2022 new-occupationgp-occupations.dta"


***** Base 20
use"NEEMSIS tracking 2022.dta", clear
drop *_label
gen base="old"
append using "NEEMSIS tracking 2022 new.dta"
save"NEEMSIS2track", replace
erase"NEEMSIS tracking 2022.dta"
erase"NEEMSIS tracking 2022 new.dta"




********** Base that are only in new questionnaire

***** Base 1
use"NEEMSIS tracking 2022 new-migindividualemployment-migcharacteristicsmainjob-migindwagejob-migwagejobpaymentinkindgroup", clear
save"NEEMSIS2track-wagejobpaymentinkindgroup", replace
erase"NEEMSIS tracking 2022 new-migindividualemployment-migcharacteristicsmainjob-migindwagejob-migwagejobpaymentinkindgroup.dta"


***** Base 2
use"NEEMSIS tracking 2022 new-migremittances-migremittancesreceivedsourceidgroup", clear
save"NEEMSIS2track-remittancesreceivedsourceidgroup", replace
erase"NEEMSIS tracking 2022 new-migremittances-migremittancesreceivedsourceidgroup.dta"


***** Base 3
use"NEEMSIS tracking 2022 new-migselfemploy-miglabourers-migbusinesslabourers", clear
save"NEEMSIS2track-businesslabourers", replace
erase"NEEMSIS tracking 2022 new-migselfemploy-miglabourers-migbusinesslabourers.dta"


***** Base 4
use"NEEMSIS tracking 2022 new-migsnrecommendassoid", clear
save"NEEMSIS2track-snrecommendassoid", replace
erase"NEEMSIS tracking 2022 new-migsnrecommendassoid.dta"


***** Base 5
use"NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalselfemp-migsnrecruitworkergroup", clear
save"NEEMSIS2track-snrecruitworkergroup", replace
erase"NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalselfemp-migsnrecruitworkergroup.dta"


***** Base 6
use"NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalselfemp-migsnrecruitworkerid", clear
save"NEEMSIS2track-snrecruitworkerid", replace
erase"NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalselfemp-migsnrecruitworkerid.dta"


***** Base 7
use"NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalselfemp-migsntechnicalhelpgroup", clear
save"NEEMSIS2track-sntechnicalhelpgroup", replace
erase"NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalselfemp-migsntechnicalhelpgroup.dta"


***** Base 8
use"NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalselfemp-migsntechnicalhelpid", clear
save"NEEMSIS2track-sntechnicalhelpid", replace
erase"NEEMSIS tracking 2022 new-migsocialnetworks-miginformalsocialcapital-miginformalsocialcapitalselfemp-migsntechnicalhelpid.dta"
