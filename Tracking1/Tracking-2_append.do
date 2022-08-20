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
save"NEEMSIS-tracking_occup_new.dta", replace
restore
drop occupationnumber occupationname kindofwork monthsayear daysamonth hoursaday annualincome hoursayear joblocation

save"NEEMSIS-tracking.dta", replace





********** 
/*
Occup database with all occup + loan database
*/
use"NEEMSIS-tracking_indiv-occup_main.dta", clear
append using "NEEMSIS-tracking_occup_new.dta"
order key indid indid2
label define kindofwork 1"Agri SE" 2"SE" 3"SJ agri in another farm" 4"SJ non-agri" 5"UW non-agri in HH business" 6"UW non-agri in other business" 7"UW agri in own farm" 8"UW agri in another farm"
label values kindofwork kindofwork

fre salariedjobtype
label define typejob 1"Permanent/ long term (i.e. government job)" 2"Fixed term (limited contract) (i.e. NREGA)" 3"Daily (i.e. agri coolie)" 4"Seasonal (i.e. brick kiln)"
label values salariedjobtype typejob

fre salariedwagetype
label define typejob2 1"Full time" 2"Part time"
label values salariedwagetype typejob2

fre salariedjobbonus
label define yesno 0"No" 1"Yes"
label values salariedjobbonus yesno
label values salariedjobinsurance yesno
label values salariedjobpension yesno
label values dummyadvance yesno

preserve
use"NEEMSIS-tracking_indiv-occup_loan.dta", clear
rename migbusinessloannumber businessloannumber
rename migbusinessloanname businessloanname
rename mignumberbusinessloan numberbusinessloan
keep if numberbusinessloan!=.
order key indid2 occupid loanid
reshape wide businessloannumber businessloanname numberbusinessloan, i(key indid2 occupid) j(loanid)
save"NEEMSIS-tracking_occupations_loanwide.dta", replace
restore


preserve
use"NEEMSIS-tracking_indiv-occup_loan_lender.dta", clear
rename migbusinesslenderid businesslenderid
rename mignamebusinesslender namebusinesslender
rename migaddressbusinesslender addressbusinesslender
rename migbusinesslender businesslender
rename migcastebusinesslender castebusinesslender
rename migoccupbusinesslender occupbusinesslender
order key indid2 occupid loanid lenderid
sort key indid2 occupid loanid lenderid
drop lenderid
reshape wide businesslenderid namebusinesslender addressbusinesslender businesslender castebusinesslender occupbusinesslender, i(key indid2 occupid) j(loanid)
merge 1:1 key indid2 occupid using "NEEMSIS-tracking_occupations_loanwide.dta"
drop _merge
order key indid2 occupid  businessloannumber1 businessloanname1 numberbusinessloan1 businesslenderid1 namebusinesslender1 addressbusinesslender1 businesslender1 castebusinesslender1 occupbusinesslender1 businessloannumber2 businessloanname2 numberbusinessloan2 businesslenderid2 namebusinesslender2 addressbusinesslender2 businesslender2 castebusinesslender2 occupbusinesslender2 businessloannumber3 businessloanname3 numberbusinessloan3 businesslenderid3 namebusinesslender3 addressbusinesslender3 businesslender3 castebusinesslender3 occupbusinesslender3
save"NEEMSIS-tracking_occupations_loanwide_v2.dta", replace
restore

preserve
use"NEEMSIS-tracking_indiv-occup_labourer.dta", clear
foreach x in migbusinesslabourernumber mignamebusinesslabourer migdummybusilabhhmb migaddressbusinesslabourer migcastebusinesslabourer migbusinesslabourertypejob migbusinesslabourerbonus migbusinesslabourerpension migbusinesslabwagetype migbusinesslabinsurance {
local newname=substr("`x'",4,strlen("`x'"))
rename `x' `newname'
}
order key indid2 occupid labourerid
reshape wide businesslabourernumber namebusinesslabourer dummybusilabhhmb addressbusinesslabourer castebusinesslabourer businesslabourertypejob businesslabourerbonus businesslabourerpension businesslabwagetype businesslabinsurance, i(key indid2 occupid) j(labourerid)
save"NEEMSIS-tracking_occupation_labourerwide.dta", replace
restore

merge m:1 key indid2 occupid using "NEEMSIS-tracking_occupations_loanwide_v2.dta"
drop _merge

merge m:1 key indid2 occupid using "NEEMSIS-tracking_occupation_labourerwide.dta"
drop _merge

save"NEEMSIS-tracking_occupations_allwide.dta", replace







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

foreach x in migration1helpname migration1helprelationship migration1helpsex migration1helpage migration1helpcastes migration1helpcastesother migration1helpeduc migration1helpoccuptype migration1helpoccupname migration1helpliving migration1helpcompared migration1helpduration migration1helpmeet migration1helpmeetother migration1helpmeetfrequency migration1helpinvite migration1helpreciprocity1 migration1helpintimacy migration1helpfindjob migration1helpfindjobhow migration1helpfindjobhowother migration1helpmoney migration1helprecommendations migration1helpsn {
local newname=substr("`x'",15,strlen("`x'"))
rename `x' `newname'
}
drop migration1helnamenb
save"NEEMSIS-tracking_helpmigration.dta", replace




**********
/*
Migration in wide then merge with hh database
*/
use"NEEMSIS-tracking_indiv-migration_job.dta", clear
order key indid2 migjobid
sort key indid2 migjobid
foreach x in migmigrationjobid migmigrationjobname migmigrationarea migmigrationplace migmigrationdistance migmigrationtype migmigrationdurationfreq migmigrationdurationinmonth migmigrationtravelcost migmigrationtravelpayment migmigrationtenure migmigrationfindjob migmigrationjobtype migmigrationjobtype2 migmigrationwagetype migmigrationsalary migmigrationpension migmigrationbonus migmigrationinsurance migmigrationchild migmigrationmainoccup migmigrationskill migmigrationreason migmigrationotherreason {
local newname=substr("`x'",4,strlen("`x'"))
rename `x' `newname'
}

ta migjobid
reshape wide migrationjobid migrationjobname migrationarea migrationplace migrationdistance migrationtype migrationdurationfreq migrationdurationinmonth migdummybacktovillage migrationtravelcost migrationtravelpayment migrationtenure migrationfindjob migrationjobtype migrationjobtype2 migrationwagetype migrationsalary migrationpension migrationbonus migrationinsurance migrationchild migrationmainoccup migrationskill migrationreason migrationotherreason, i(key indid2) j(migjobid)
save"NEEMSIS-tracking_migrationjobwide.dta", replace

use"NEEMSIS-tracking.dta", clear
merge m:1 key indid2 using "NEEMSIS-tracking_migrationjobwide.dta",
drop _merge
save"NEEMSIS-tracking_v2.dta", replace




**********
/*
Wagejobpaymentinkind details
*/
use"NEEMSIS-tracking_indiv-wagejobpaymentinkind.dta", clear
save"NEEMSIS-tracking_wagejobpaymentinkind.dta", replace





**********
/*
Remittances sent to merge with tracking data
*/
use"NEEMSIS-tracking_indiv-remtsent.dta", clear
order key indid2 remtsentid

foreach x in migremittancessentid migremittancessentname migremitsentdummyvillage migremittancessentrelation migremittancessentoccup migremittancessentplace migremittancessentfrequency migremittancessentamount migremitsenttotalamount migremittancessentservices migremitsentsourceoccupother {
local newname=substr("`x'",4,strlen("`x'"))
rename `x' `newname'
}

reshape wide remittancessentid remittancessentname remitsentdummyvillage remittancessentrelation remittancessentoccup remittancessentplace remittancessentfrequency remittancessentamount remitsenttotalamount remittancessentservices remitsentsourceoccupother, i(key indid2) j(remtsentid)
save"NEEMSIS-tracking_remitsentwide.dta", replace

use"NEEMSIS-tracking_v2.dta", clear
merge m:1 key indid2 using "NEEMSIS-tracking_remitsentwide.dta",
drop _merge
save"NEEMSIS-tracking_v3.dta", replace




**********
/*
Remittances received in HH
*/
use"NEEMSIS-tracking_indiv-remtreceived.dta", clear
order key indid2 remtreceivedid

rename migremittancesrecipientid remittancesrecipientid
rename migremittancesrecipientname remittancesrecipientname

reshape wide remittancesrecipientid remittancesrecipientname, i(key indid2) j(remtreceivedid)

preserve
use"NEEMSIS-tracking_indiv-remtreceived_source.dta", clear
order key indid2 remtreceivedid remtreceivedsourceid
foreach x in migremitrecipsourceid migremitrecipsourcename1 migremitrecsourcerelation migremitrecsourcehh migremitrecsourceoccup migremitrecsourceplace migremitrecfreq migremitrecamount migremitrectotalamount migremitrecservices migremitrecsourceoccupoth migremitrecservicesother {
local newname=substr("`x'",4,strlen("`x'"))
rename `x' `newname'
}
drop remtreceivedsourceid
rename remitrecipsourcename1 remitrecipsourcename
reshape wide remitrecipsourceid remitrecipsourcename remitrecsourcerelation remitrecsourcehh remitrecsourceoccup remitrecsourceplace remitrecfreq remitrecamount remitrectotalamount remitrecservices remitrecsourceoccupoth remitrecservicesother, i(key indid2) j(remtreceivedid)
save"NEEMSIS-tracking_remitreceived_sourcewide.dta", replace
restore

merge 1:1 key indid2 using "NEEMSIS-tracking_remitreceived_sourcewide.dta"
drop _merge
save"NEEMSIS-tracking_remitrecwide.dta", replace

use"NEEMSIS-tracking_v3.dta", clear
merge m:1 key indid2 using "NEEMSIS-tracking_remitrecwide.dta"
drop _merge
save"NEEMSIS-tracking_v3.dta", replace





**********
/*
Asso in HH
*/
use"NEEMSIS-tracking_indiv-asso.dta", clear
duplicates report key indid2

use"NEEMSIS-tracking_v3.dta", clear
merge m:1 key indid2 using "NEEMSIS-tracking_indiv-asso.dta"
drop _merge
foreach x in migassociationid migassociationtype migassociationname migassodegreeparticip migassosize migdummyassorecommendation migdummyassohelpjob migassohelpjob migassocotherhelpjob migdummyassohelpbusiness migassohelpbusiness migassootherhelpbusiness {
local newname=substr("`x'",4,strlen("`x'"))
rename `x' `newname'
}
drop assoid
save"NEEMSIS-tracking_v4.dta", replace


use"NEEMSIS-tracking_indiv-asso_reco.dta", clear

foreach x in migsnrecommendassonber migsnrecommendassoname migsnrecoassorelationship migsnrecommendassosex migsnrecommendassoage migsnrecommendassocastes migsnrecommendassoeduc migsnrecommendassooccup migsnrecommendassoliving migsnrecommendassocompared migsnrecommendassoduration migsnrecommendassomeet migsnrecoassomeetfreq migsnrecommendassoinvite migsnrecoassoreciprocity1 migsnrecommendassointimacy {
local newname=substr("`x'",4,strlen("`x'"))
rename `x' `newname'
}
save"NEEMSIS-tracking_snrecoasso.dta", replace




**********
/*
Contact in HH
*/

use"NEEMSIS-tracking_indiv-contact.dta", clear
duplicates report key indid2
order key indid2 contactid
rename migcontactname contactname
rename migcontactnumber contactnumber
drop migcontactid

save"NEEMSIS-tracking_contact.dta", replace

****************************************
* END










****************************************
* Caste, jatis, edulevel
****************************************
use"NEEMSIS-tracking_v4.dta", clear


********** 
***** Jatis
fre caste casteindividual
gen jatis=caste if caste!=.
replace jatis=casteindividual if casteindividual!=.
codebook caste
ta jatis
label values jatis migcaste_5
gen jatisother=casteindividualother if casteindividual==77
replace jatisother=casteother if caste==77
ta jatisother
drop casteindividual casteindividualother caste casteother

***** Caste
gen caste=.
replace caste=1 if jatis==2

replace caste=2 if jatis==1
replace caste=2 if jatis==12
replace caste=2 if jatis==16

replace caste=3 if jatis==4
replace caste=3 if jatis==6
replace caste=3 if jatis==11
replace caste=3 if jatis==77 & jatisother=="Yadhavar"
label define caste 1"Dalits" 2"Middle" 3"Upper"
label values caste caste
fre caste


********* Edulevel
gen edulevel=.
replace edulevel = 0 if  everattendedschool == 0
replace edulevel = 0 if classcompleted < 5 & classcompleted != .
replace edulevel= 1 if classcompleted>=5 & classcompleted != .
replace edulevel= 2 if classcompleted>=8 & classcompleted != .
replace edulevel= 3 if classcompleted>=11 & classcompleted != .
replace edulevel= 4 if classcompleted>=15  & classcompleted != .
replace edulevel= 5 if classcompleted>=16  & classcompleted != . //Attention! I recoded here cause otherwise all missing are in 5 (Anne, 20/06/17)
label define edulevel 0 "Below primary" 1 "Primary completed", modify
label define edulevel 2 "High school (8th-10th)", modify
label define edulevel 3 "HSC/Diploma (11th-12th)", modify
label define edulevel 4 "Bachelors (13th-15th)", modify
label define edulevel 5 "Post graduate (15th and more)", modify
label values edulevel edulevel
ta edulevel
ta age edulevel, m


********** Order
order key indid indid2 dummynewmb dummymainmigrant rankingmigrant name jatis jatisother caste

save"NEEMSIS-tracking_v5.dta", replace
****************************************
* END














****************************************
* CLEAN folder
****************************************


use"NEEMSIS-tracking_v4.dta", clear
save"CLEAN\NEEMSIS-tracking_HH.dta", replace

use"NEEMSIS-tracking_helpmigration.dta", clear
save"CLEAN\NEEMSIS-tracking_helpmigration.dta", replace

use"NEEMSIS-tracking_occupations_allwide.dta", clear
save"CLEAN\NEEMSIS-tracking_occupations_allwide.dta", replace

use"NEEMSIS-tracking_wagejobpaymentinkind.dta", clear
save"CLEAN\NEEMSIS-tracking_wagejobpaymentinkind.dta", replace

use"NEEMSIS-tracking_snrecoasso.dta", clear
save"CLEAN\NEEMSIS-tracking_snrecoasso.dta", replace

use"NEEMSIS-tracking_contact.dta", clear
save"CLEAN\NEEMSIS-tracking_contact.dta", replace

****************************************
* END





