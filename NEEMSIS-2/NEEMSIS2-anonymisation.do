*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@ifpindia
*October 30, 2024
*-----
*NEEMSIS-4 anonymisation
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\2020-NEEMSIS2\Data"
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
use"4team\Last\Lastlast\Corrected\Lastcorrection\NEEMSIS2-HH", clear

sort HHID2020 INDID2020
drop address 
drop loandetails*
drop start_HH_quest start_agri_quest end_HH_quest end_agri_quest version_HH version_agri geopointlatitude geopointlongitude geopointaltitude geopointaccuracy panelHH name interviewer numfamily householdid2020

drop remsentname1 remsentnametwo1 remsentname2 remsentnametwo2 remsentname3 remsentnametwo3 remsentname4 remsentnametwo4 remsentname5 remsentnametwo5
drop remrecipientsourcename1 remrecipientsourcenametwo1 remrecipientsourcename2 remrecipientsourcenametwo2 remrecipientsourcename3 remrecipientsourcenametwo3 remrecipientsourcename4 remrecipientsourcenametwo4
drop marriedname marriagesomeoneelse
drop landleasername landleasingname

* Decode username
encode username, gen(username_code)
order username_code, after(username)
drop username
rename username_code username
label val username
tostring username, replace

save"2publish\NEEMSIS2-HH", replace
****************************************
* END








****************************************
* NEEMSIS2-loans_mainloans.dta
****************************************
use"4team\Last\Lastlast\NEEMSIS2-loans_mainloans", clear

drop lendername

* yesno label
foreach x in otherlenderservices_poli otherlenderservices_fina otherlenderservices_guar otherlenderservices_gene otherlenderservices_none otherlenderservices_othe guarantee_docu guarantee_chit guarantee_shg guarantee_pers guarantee_jewe guarantee_none guarantee_other plantorepay_chit plantorepay_work plantorepay_migr plantorepay_asse plantorepay_inco plantorepay_borr plantorepay_othe {
label val `x' yesno
}

save"2publish\NEEMSIS2-loans_mainloans", replace
****************************************
* END









****************************************
* NEEMSIS2-occupations.dta
****************************************
use"4team\Last\Lastlast\NEEMSIS2-occupations", clear

drop namebusiness* address*

save"2publish\NEEMSIS2-occupations", replace
****************************************
* END








****************************************
* NEEMSIS2-migrations.dta
****************************************
use"4team\Last\Lastlast\Corrected\NEEMSIS2-migrations", clear

*

save"2publish\NEEMSIS2-migrations", replace
****************************************
* END









****************************************
* NEEMSIS1-ego.dta
****************************************
use"4team\Last\Lastlast\Corrected\Lastcorrection\NEEMSIS2-ego", clear

drop snrecruitworkername* snrecommendassoname* snrecommendforjobname*
drop snhelpemergencyname* sncloserelouthhname* covsnhelpreceivedname*
drop snbusinesslender* snfindcurrentjobname* snfindjobname*
drop snrecojobsuccessname* sntalkthemostname*
drop version_HH version_agri

save"2publish\NEEMSIS2-ego", replace
****************************************
* END






****************************************
* NEEMSIS1-alters.dta
****************************************
use"4team\Last\Lastlast\NEEMSIS2-alters_networkpurpose", clear

drop namealter
rename ALTERID alterid 
drop phonenb
drop businessloanid marriageloanid

save"2publish\NEEMSIS2-alters", replace
****************************************
* END
