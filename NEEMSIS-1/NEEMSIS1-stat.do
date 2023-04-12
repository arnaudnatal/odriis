*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 11, 2023
*-----
*NEEMSIS-1 survey report
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-1"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\2016-NEEMSIS1\Materials\SurveyReport2\analysis"
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









log using "0_Introduction.log", nomsg replace
****************************************
* 0. Introduction
****************************************
use"NEEMSIS1-HH", clear

* Selection
keep HHID2016 villageid villagearea jatis religion comefrom otherorigin 
duplicates drop

* Tables
tabulate villageid
tabulate villagearea
tabulate jatis
tabulate religion
tabulate comefrom
tabulate otherorigin

****************************************
* END
log close












log using "1-1_Householdmember.log", nomsg replace
****************************************
* 1.1. Household member module
****************************************
use"NEEMSIS1-HH", clear

* Tables
tabulate sex
summarize age
tabulate relationshiptohead
tabulate maritalstatus
tabulate livinghome
tabulate lefthomedurationlessoneyear
tabulate lefthomedurationmoreoneyear
tabulate lefthomedestination
tabulate lefthomereason
tabulate dummypermanentmigrantwork

****************************************
* END
log close









log using "2_Education.log", nomsg replace
****************************************
* 2. Education
****************************************
use"NEEMSIS1-HH", clear

* Selection
drop if age<=5
drop if livinghome==4

* Tables
tabulate canread
tabulate everattendedschool
tabulate classcompleted
tabulate after10thstandard
tabulate durationafter10th
tabulate typeofhigheredu
tabulate subjectsafter10th
tabulate othersubjectsafter10th
tabulate currentlyatschool
summarize educationexpenses amountschoolfees bookscost transportcost
tabulate reasonneverattendedschool_fail
tabulate reasonneverattendedschool_inac
tabulate reasonneverattendedschool_qual 
tabulate reasonneverattendedschool_fina
tabulate reasonneverattendedschool_heal
tabulate reasonneverattendedschool_noin
tabulate reasonneverattendedschool_care
tabulate reasonneverattendedschool_work
tabulate reasonneverattendedschool_girl
tabulate reasonneverattendedschool_marr
tabulate reasonneverattendedschool_noal
tabulate reasonneverattendedschool_pube
tabulate reasonneverattendedschool_baby
tabulate reasondropping_stop
tabulate reasondropping_fail
tabulate reasondropping_inac
tabulate reasondropping_qual
tabulate reasondropping_fina
tabulate reasondropping_heal
tabulate reasondropping_noin
tabulate reasondropping_care
tabulate reasondropping_work
tabulate reasondropping_girl
tabulate reasondropping_marr
tabulate reasondropping_noal
tabulate reasondropping_pube
tabulate reasondropping_baby
tabulate otherreasondroppingschool
tabulate dummyscholarship
summarize scholarshipamount scholarshipduration
tabulate converseinenglish

****************************************
* END
log close












log using "3_Employment.log", nomsg replace
****************************************
* 3. Employment
****************************************

********** Workers
use"NEEMSIS1-HH", clear

* Selection
drop if livinghome==3
drop if livinghome==4
drop if age<=10

* Tables
tabulate dummyworkedpastyear



********** Non-workers
use"NEEMSIS1-HH", clear

* Selection
drop if livinghome==3
drop if livinghome==4
drop if age<=10

* Tables
tabulate reasonnotworkpastyear
tabulate stoppedworking



********** Occupations
use"NEEMSIS1-occupations", clear

* Selection
drop if occupationid==.

* Tables
tabulate kindofwork
summarize monthsayear if monthsayear!=66
summarize daysamonth if daysamonth!=66
summarize hoursaday if hoursaday!=66
summarize hoursayear if hoursayear!=66
summarize annualincome
tabulate datestartoccup
tabulate demooccup

****************************************
* END
log close











log using "3-1-1_Selfemployment.log", nomsg replace
****************************************
* 3.1.1. Self-employment details
* 3.1.2. Self-employment investment details
****************************************
use"NEEMSIS1-occupations", clear

********** Details
* Selection
drop if occupationid==.
keep if kindofwork==2

* Tables
summarize yearestablishment
tabulate businesscastebased
tabulate businessskill_fami
tabulate businessskill_frie
tabulate businessskill_scho
tabulate businessskill_expe
summarize businessamountinvest
tabulate businesslossinvest
summarize businesslossinvestamount demobusinessloss
tabulate businesssourceinvest_rela
tabulate businesssourceinvest_bank
tabulate businesssourceinvest_info
tabulate businesssourceinvest_savi
tabulate businesssourceinvest_inhe
tabulate businesssourceinvest_prof
tabulate businesssourceinvest_inbu
tabulate businesssourceinvest_none
tabulate businesssourceinvest_othe
tabulate otherbusinesssourceinvestment
tabulate demobusinessactivity_lesin
tabulate demobusinessactivity_cainp
tabulate demobusinessactivity_difse
tabulate demobusinessactivity_caspa
tabulate demobusinessactivity_paymo
tabulate demobusinessactivity_frequ
tabulate demobusinessactivity_press
tabulate demobusinessactivity_contr
tabulate demobusinessactivity_other
tabulate demobusinessactivityother
tabulate demobusinesskindofjob



********** Investment
* Selection
keep HHID2016 INDID2016 occupationid namebusinesslender* addressbusinesslender* businesslender* castebusinesslender* occupbusinesslender*
reshape long namebusinesslender addressbusinesslender businesslender castebusinesslender occupbusinesslender, i(HHID2016 INDID2016 occupationid) j(n)

* Tables
tabulate namebusinesslender
tabulate businesslender
tabulate castebusinesslender
tabulate occupbusinesslender

****************************************
* END
log close











log using "3-1-3_Businesslabourer.log", nomsg replace
****************************************
* 3.1.3. Self-employment business labourers
****************************************
use"NEEMSIS1-occupations", clear

* Selection
drop if occupationid==.
keep if kindofwork==2

* Tables
tabulate dummybusinesslabourers
summarize nbbusinesslabourers
tabulate demobusiness

********** Details
* Selection
keep HHID2016 INDID2016 occupationid namebusinesslabourer* dummyhhmember* addressbusinesslabourer* relationshipbusinesslabourer* castebusinesslabourer* businesslabourerdate* businesslabourertypejob* businesslabourerwagetype* businesslabourerbonus* businesslabourerinsurance* businesslabourerpension*

reshape long namebusinesslabourer dummyhhmember addressbusinesslabourer relationshipbusinesslabourer castebusinesslabourer businesslabourerdate businesslabourertypejob businesslabourerwagetype businesslabourerbonus businesslabourerinsurance businesslabourerpension, i(HHID2016 INDID2016 occupationid) j(n)
drop if namebusinesslabourer==""


* Tables
tabulate dummyhhmember
tabulate relationshipbusinesslabourer
tabulate castebusinesslabourer
tabulate businesslabourertypejob
tabulate businesslabourerwagetype
tabulate businesslabourerbonus
tabulate businesslabourerinsurance
tabulate businesslabourerpension

****************************************
* END
log close

















log using "3-2_Salariedjob.log", nomsg replace
****************************************
* 3.1.3. Self-employment business labourers
****************************************
use"NEEMSIS1-occupations", clear

* Selection
drop if occupationid==.
drop if kindofwork==1
drop if kindofwork==2

* Tables
tabulate joblocation
summarize jobdistance
tabulate relationemployer_labo
tabulate relationemployer_rela
tabulate relationemployer_poli
tabulate relationemployer_reli
tabulate relationemployer_neig
tabulate relationemployer_shg
tabulate relationemployer_busi
tabulate relationemployer_wkp
tabulate relationemployer_trad
tabulate relationemployer_frie
tabulate relationemployer_gfin
tabulate relationemployer_na
tabulate relationemployer_nr
tabulate casteemployer_vanni
tabulate casteemployer_sc
tabulate casteemployer_arunt
tabulate casteemployer_rediy
tabulate casteemployer_grama
tabulate casteemployer_naidu
tabulate casteemployer_navit
tabulate casteemployer_asara
tabulate casteemployer_settu
tabulate casteemployer_natta
tabulate casteemployer_mudal
tabulate casteemployer_kulal
tabulate casteemployer_chett
tabulate casteemployer_marwa
tabulate casteemployer_musli
tabulate casteemployer_paday
tabulate casteemployer_na
tabulate casteemployer_other
tabulate othercasteemployer
tabulate salariedjobtype
tabulate demojobtype
tabulate salariedjobtype2
tabulate effetdemowage
tabulate salariedwagetype
tabulate demowagetype
tabulate salariedjobbonus
tabulate salariedjobinsurance
tabulate salariedjobpension
summarize salariedjobtenure
tabulate salariedjobkindbonus
summarize salariedjobbonusamount
tabulate demosalariedjob
tabulate demosalariedjobother

****************************************
* END
log close

















log using "4_Migration.log", nomsg replace
****************************************
* 4. Migration
****************************************
* Household
use"NEEMSIS1-HH", clear
keep HHID2016 dummymigration
duplicates drop
tabulate dummymigration

* Individual
use"NEEMSIS1-HH", clear
tabulate migrantlistdummy

********** Details
use"NEEMSIS1-migrations", clear


****************************************
* END
log close
























