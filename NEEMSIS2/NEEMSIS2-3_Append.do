/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
February 23, 2021
-----
APPEND ALL VERSION
-----
Pas 100% automatique ici, il faut faire deux ou trois trucs.
La première chose est de copier coller tous les .dta des différentes version HH
dans le dossier "raw" de "APPEND".


-------------------------
*/






****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"

********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

****************************************
* END








****************************************
* AUTOCALCULATION DO NOT CHANGE /!\*
****************************************
global preamble "NEEMSIS2_LAST"
global nbcharact "15"
cd "$directory"
****************************************
* END
















****************************************
* APPEND ALL LONG FILES
****************************************
********** Lister tous les fichiers
/*
Étant donné qu'il y a une différence entre le questionnair vierge et celui avec preload,
les fichiers n'ont pas le même nom (householdquestionnaireold en plus dans les fichiers avec preload).
Donc au passage je renomme ceux avec "householdquestionnaireold" --> les fichiers vont donc 
dans le subfolder "rename".
*/
clear all
filelist, dir("$directory\raw") pattern(*.dta)
split filename, p(-)
*
egen filename_new=concat(filename1 filename2 filename3 filename4 filename5 filename6 filename7) if filename2!="householdquestionnaireold", p(-)
egen filename_new2=concat(filename1 filename3 filename4 filename5 filename6 filename7) if filename2=="householdquestionnaireold", p(-)
gen filename_new3=""
replace filename_new3=filename_new if filename_new!=""
replace filename_new3=filename_new2 if filename_new2!=""
drop filename_new filename_new2
rename filename_new3 filename_new
*Drop "-" en trop
replace filename_new=substr(filename_new,1,strlen(filename_new)-1) if substr(filename_new,strlen(filename_new),1)=="-"
replace filename_new=substr(filename_new,1,strlen(filename_new)-1) if substr(filename_new,strlen(filename_new),1)=="-"
replace filename_new=substr(filename_new,1,strlen(filename_new)-1) if substr(filename_new,strlen(filename_new),1)=="-"
replace filename_new=substr(filename_new,1,strlen(filename_new)-1) if substr(filename_new,strlen(filename_new),1)=="-"
replace filename_new=substr(filename_new,1,strlen(filename_new)-1) if substr(filename_new,strlen(filename_new),1)=="-"
replace filename_new=substr(filename_new,1,strlen(filename_new)-1) if substr(filename_new,strlen(filename_new),1)=="-"
replace filename_new=substr(filename_new,1,strlen(filename_new)-1) if substr(filename_new,strlen(filename_new),1)=="-"
replace filename_new=substr(filename_new,1,strlen(filename_new)-1) if substr(filename_new,strlen(filename_new),1)=="-"
replace filename_new=substr(filename_new,1,strlen(filename_new)-1) if substr(filename_new,strlen(filename_new),1)=="-"
drop filename1 filename2 filename3 filename4 filename5 filename6 filename7

tab filename
tab filename_new
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	use "`myfiles'" in `i', clear
	local f = filename
	local fn = filename_new
	use "$directory\raw\\`f'", clear
	save "$directory\rename\\`fn'", replace
}





********** APPEND WORK ONLY IF THE FILE EXIST IN RENAME
/*
ONLY IF THE FILE EXIST, il est donc nécessaire de créer tous les fichiers possibles par base de données.
Ce seront des fichiers avec une variable vide qui s'appelle "forauto".
Ils permettent uniquement de ne pas avoir de rouges sur Stata et pour éviter de tout se taper à la main.

Ici on regarde tous les noms génériques de fichiers qui existent, quelque soit la version du questionnaire
*/
clear all
filelist, dir("$directory\rename") pattern(*.dta)
split filename, p(-)

egen genericname=concat( filename2 filename3 filename4 filename5 filename6 filename7) if substr(filename1,strlen(filename1)-4,4)!=".dta", p(-)
replace genericname=substr(genericname,1,strlen(genericname)-1) if substr(genericname,strlen(genericname),1)=="-"
replace genericname=substr(genericname,1,strlen(genericname)-1) if substr(genericname,strlen(genericname),1)=="-"
replace genericname=substr(genericname,1,strlen(genericname)-1) if substr(genericname,strlen(genericname),1)=="-"
replace genericname=substr(genericname,1,strlen(genericname)-1) if substr(genericname,strlen(genericname),1)=="-"
replace genericname=substr(genericname,1,strlen(genericname)-1) if substr(genericname,strlen(genericname),1)=="-"
replace genericname=substr(genericname,1,strlen(genericname)-1) if substr(genericname,strlen(genericname),1)=="-"
replace genericname="-"+genericname
replace genericname="" if genericname=="-"
*replace genericname=filename1 if substr(filename1,strlen(filename1)-3,4)==".dta"
keep genericname
duplicates drop
list, clean






********** CREATION OF ALL FILES (forauto seulement) IN _temp FOLDER
global genericname	-detailsinsurance.dta	-detailsloanbyborrower.dta	-detailssavingaccounts.dta	-ego1questionnaire-individualemployment-covoccupationfieldlist.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-covsntypehelpreceivedgroup.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sncloserelouthhgroup.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sncloserelouthhid.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecommendforjobgroup.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecommendforjobid.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sntalkthemostgroup.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sntalkthemostid.dta	-generalinformation-lefthome.dta	-hhquestionnaire-education.dta	-hhquestionnaire-employment.dta	-hhquestionnaire-familymembers.dta	-hhquestionnaire-financialpracticesgroup-goldgroup-gold.dta	-hhquestionnaire-financialpracticesgroup-guaranteeandrecommendation-recommendationgiven.dta	-hhquestionnaire-financialpracticesgroup-insurancegroup-insurance.dta	-hhquestionnaire-financialpracticesgroup-loans-loansbyborrower.dta	-hhquestionnaire-financialpracticesgroup-loans-mainloans.dta	-hhquestionnaire-financialpracticesgroup-savingsgroup-savings.dta	-hhquestionnaire-remittances-remreceived-remreceivedidgroup.dta	-hhquestionnaire-schemes-schemenrega-schemenregaind.dta	-memberlistpreload2016.dta	-occupations.dta	-remreceivedsourceidgroup.dta	-salaried-infoemployer.dta		-_2snrecommendassogroup.dta	-_2snrecommendassoid.dta	-_3ego1questionnaire-_3individualemployment-_3characteristicsmainjob-_3indselfemployment-_3informalsocialcapitalselfemp-_3snrecruitworkergroup.dta	-_3ego1questionnaire-_3individualemployment-_3characteristicsmainjob-_3indselfemployment-_3informalsocialcapitalselfemp-_3snrecruitworkerid.dta	-_3ego1questionnaire-_3individualemployment-_3characteristicsmainjob-_3indselfemployment-_3sourceinvestment-_3businessloandetails.dta	-_3ego1questionnaire-_3individualemployment-_3characteristicsmainjob-_3indwagejob-_3wagejobpaymentinkindgroup.dta	-_3ego1questionnaire-_3individualemployment-_3covoccupationfield.dta	-_3ego1questionnaire-_3individualemployment-_3mainoccupschedule-_3indoccupmonths.dta	-_3ego1questionnaire-_3socialnetworks-_3formalsocialcapital.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3covsnhelpreceivedgroup.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3covsnhelpreceivedid.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3covsntypehelpgivengroup.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3covsntypehelpreceivedgrou.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3sncloserelouthhgroup.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3sncloserelouthhid.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snfindcurrentjobgroup.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snfindcurrentjobid.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snfindjobgroup.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snfindjobid.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snhelpemergencygroup.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snhelpemergencyid.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snrecommendforjobgroup.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snrecommendforjobid.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3sntalkthemostgroup.dta	-_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3sntalkthemostid.dta	-_3ego1questionnaire-_3socialnetworks-_3networkresources-_3contactgroup.dta	-_3random_1825-_3random_draws.dta	-_3random_1825-_3show_draws.dta	-_3random_2635-_3random_draws_2.dta	-_3random_2635-_3show_draws_2.dta	-_3random_36-_3random_draws_3.dta	-_3random_36-_3show_draws_3.dta	-detailschitfunds.dta	-ego1questionnaire-individualemployment-characteristicsmainjob-indselfemployment-informalsocialcapitalselfemp-snrecruitworkergroup.dta	-ego1questionnaire-individualemployment-characteristicsmainjob-indselfemployment-informalsocialcapitalselfemp-snrecruitworkerid.dta	-ego1questionnaire-individualemployment-characteristicsmainjob-indselfemployment-sourceinvestment-businessloandetails.dta	-ego1questionnaire-individualemployment-characteristicsmainjob-indwagejob-wagejobpaymentinkindgroup.dta	-ego1questionnaire-individualemployment-mainoccupschedule-indoccupmonths.dta	-ego1questionnaire-socialnetworks-formalsocialcapital.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-covsnhelpgivengroup.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-covsnhelpgivenid.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-covsnhelpreceivedgroup.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-covsnhelpreceivedid.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-covsntypehelpgivengroup.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindcurrentjobgroup.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindcurrentjobid.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindjobgroup.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindjobid.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snhelpemergencygroup.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snhelpemergencyid.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecojobsuccessgroup.dta	-ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecojobsuccessid.dta	-ego1questionnaire-socialnetworks-networkresources-contactgroup.dta	-ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2indselfemployment-_2businesspaymentinkindgrou.dta	-ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2indselfemployment-_2sourceinvestment-_2businessloandetails.dta	-ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2indwagejob-_2wagejobpaymentinkindgroup.dta	-ego2questionnaire-_2individualemployment-_2covoccupationfieldlist.dta	-ego2questionnaire-_2individualemployment-_2mainoccupschedule-_2indoccupmonths.dta	-ego2questionnaire-_2socialnetworks-_2formalsocialcapital.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsnhelpgivengroup.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsnhelpgivenid.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsnhelpreceivedgroup.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsnhelpreceivedid.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsntypehelpgivengroup.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsntypehelpreceivedgrou.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2sncloserelouthhgroup.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2sncloserelouthhid.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snfindcurrentjobgroup.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snfindcurrentjobid.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snfindjobgroup.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snfindjobid.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snhelpemergencygroup.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snhelpemergencyid.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2sntalkthemostgroup.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2sntalkthemostid.dta	-ego2questionnaire-_2socialnetworks-_2networkresources-_2contactgroup.dta	-ego2questionnaire-randomizationego2-random_1825-random_draws.dta	-ego2questionnaire-randomizationego2-random_1825-show_draws.dta	-ego2questionnaire-randomizationego2-random_2635-random_draws_2.dta	-ego2questionnaire-randomizationego2-random_2635-show_draws_2.dta	-ego2questionnaire-randomizationego2-random_36-random_draws_3.dta	-ego2questionnaire-randomizationego2-random_36-show_draws_3.dta	-hhquestionnaire-financialpracticesgroup-chitfundgroup-chitfund.dta	-hhquestionnaire-financialpracticesgroup-lendingmoneygroup-lendingmoney.dta	-hhquestionnaire-marriage-marriagegroup.dta	-hhquestionnaire-migration-migrationidgroup.dta	-hhquestionnaire-remittances-remsent-remsentidgroup.dta	-hhquestionnaire-schemes-cashassistancemarriage-cashassistancemarriagegroup.dta	-hhquestionnaire-schemes-goldmarriage-goldmarriagegroup.dta	-hhquestionnaire-schemes-schemepension1-schemepension1group.dta	-hhquestionnaire-schemes-schemepension2-schemepension2group.dta	-hhquestionnaire-schemes-schemepension3-schemepension3group.dta	-hhquestionnaire-schemes-schemepension4-schemepension4group.dta	-hhquestionnaire-schemes-schemepension5-schemepension5group.dta	-hhquestionnaire-schemes-schemepension6-schemepension6group.dta	-individualid.dta	-marriagefinance.dta	-marriagegift.dta	-migrationjobidgroup.dta	-remsentidgroup.dta	-selfemploy-labourers-businesslabourers.dta	-snrecommendassogroup.dta	-snrecommendassoid.dta	-ego2questionnaire-ego2questionnairefull-_2individualemployment-_2characteristicsmainjob-_2indwagejob-_2wagejobpaymentinkindgroup.dta	-ego2questionnaire-ego2questionnairefull-_2individualemployment-_2covoccupationfieldlist.dta	-ego2questionnaire-ego2questionnairefull-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2sncloserelouthhgroup.dta	-ego2questionnaire-ego2questionnairefull-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2sncloserelouthhid.dta	-ego2questionnaire-ego2questionnairefull-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snfindcurrentjobgroup.dta	-ego2questionnaire-ego2questionnairefull-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snfindcurrentjobid.dta	-ego2questionnaire-ego2questionnairefull-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snhelpemergencygroup.dta	-ego2questionnaire-ego2questionnairefull-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snhelpemergencyid.dta	-ego2questionnaire-ego2questionnairefull-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2sntalkthemostgroup.dta	-ego2questionnaire-ego2questionnairefull-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2sntalkthemostid.dta	-ego1questionnaire-individualemployment-characteristicsmainjob-informalsocialcapitalselfemp-snrecruitworkergroup.dta	-ego1questionnaire-individualemployment-characteristicsmainjob-informalsocialcapitalselfemp-snrecruitworkerid.dta	-ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2informalsocialcapitalselfemp-_2snrecruitworkergroup.dta	-ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2informalsocialcapitalselfemp-_2snrecruitworkerid.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snrecojobsuccessgroup.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snrecojobsuccessid.dta	-_3snrecommendassogroup.dta	-_3snrecommendassoid.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snrecommendforjobgroup.dta	-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snrecommendforjobid.dta	-ego2questionnaire-ego2questionnairefull-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snfindjobgroup.dta	-ego2questionnaire-ego2questionnairefull-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snfindjobid.dta	-ego2questionnaire-ego2questionnairefull-_2socialnetworks-_2networkresources-_2contactgroup.dta	-ego2questionnaire-randomizationego2-randomizationego2full-random_1825-random_draws.dta	-ego2questionnaire-randomizationego2-randomizationego2full-random_1825-show_draws.dta	-ego2questionnaire-randomizationego2-randomizationego2full-random_2635-random_draws_2.dta	-ego2questionnaire-randomizationego2-randomizationego2full-random_2635-show_draws_2.dta	-ego2questionnaire-randomizationego2-randomizationego2full-random_36-random_draws_3.dta	-ego2questionnaire-randomizationego2-randomizationego2full-random_36-show_draws_3.dta
foreach k in $genericname{
clear all
set obs 1
gen forauto="" in 1
save"$directory/_temp/NEEMSIS2_LAST`k'", replace
save"$directory/_temp/NEEMSIS2_DECEMBER`k'", replace
save"$directory/_temp/NEEMSIS2_DEC`k'", replace
save"$directory/_temp/NEEMSIS2_FEB`k'", replace
save"$directory/_temp/NEEMSIS2_FEBRUARY`k'", replace
save"$directory/_temp/NEEMSIS2_NEW_APRIL`k'", replace
save"$directory/_temp/NEEMSIS2_APRIL`k'", replace

}




********** INSTRUCTIONS:
/*
Point sur la situation: 
- Dans le sous-dossier "_temp" il y a tous les fichiers possibles avec une variable vide "forauto" servant uniquement à éviter les erreurs durant le append.
- Dans le sous-dossier "raw" il y a tous les fichiers bruts .dta
- Dans le sous-dossier "rename" il y a les même fichiers que dans "raw", mais ils sont renommer (nous avons enlever le householdquestionnaireold)

L'idée est de ne pas toucher au dossier raw car si il y a un foirage (et j'en ai eu pas mal au début) dans les prochains .do, il n'y a pas besoin de refaire les copier coller depuis les différents sous-dossiers de version.

Afin que le append fonctionne, nous allons donc déplacer TOUS les .dta du sous-dossier "_temp" (avec forauto donc) dans le dossier rename SANS REMPLACER LES FICHIERS EXISTANTS.
Les fichiers existants contiennent les données, pas ceux de _temp.
Donc nous déplacons UNIQUEMENT ceux qui n'existent pas dans le dossier "rename".
Concretemment, copier coller en demandant au pc de ne pas remplacer si jamais le fichier existe déjà.

Normalement ca deplace peu de fichiers au final car la plupart des versions de l'enquête ont ouvert presque toutes les listes.
*/








********** APPEND LONG FILES
/*
On peut donc assembler les données des différentes versions qui iront dans un nouveau dossier CLEAN
*/
foreach k in $genericname{
use "$directory\rename\NEEMSIS2_LAST`k'", clear
append using "$directory\rename\NEEMSIS2_DECEMBER`k'", force
append using "$directory\rename\NEEMSIS2_DEC`k'", force
append using "$directory\rename\NEEMSIS2_FEB`k'", force
append using "$directory\rename\NEEMSIS2_FEBRUARY`k'", force
append using "$directory\rename\NEEMSIS2_NEW_APRIL`k'", force
append using "$directory\rename\NEEMSIS2_APRIL`k'", force
do "$directory\do_not_drop\_1-3-datachoicelist_v2"
save "$directory/CLEAN/NEEMSIS_APPEND`k'", replace
}
****************************************
* END

















****************************************
* APPEND HOUSEHOLD DATA BASE (SCTO version)
****************************************

********** APPEND
/*
APPEND la base HH de survey cto (celle avec les HH en lignes)
*/

foreach x in NEEMSIS2_LAST NEEMSIS2_DECEMBER NEEMSIS2_DEC NEEMSIS2_FEB NEEMSIS2_FEBRUARY NEEMSIS2_NEW_APRIL NEEMSIS2_APRIL{
use"$directory\rename\\`x'.dta", clear
gen version="`x'"
save"$directory\rename\\`x'.dta", replace
}
use"$directory\rename\NEEMSIS2_LAST.dta", clear
append using "$directory\rename\NEEMSIS2_DECEMBER.dta", force
append using "$directory\rename\NEEMSIS2_DEC.dta", force
append using "$directory\rename\NEEMSIS2_FEB.dta", force
append using "$directory\rename\NEEMSIS2_FEBRUARY.dta", force
append using "$directory\rename\NEEMSIS2_NEW_APRIL.dta", force
append using "$directory\rename\NEEMSIS2_APRIL.dta", force




********** DROP DUPLICATES (AGREE WITH CECILE)
drop if householdid=="67" & key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
drop if householdid=="124" & key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
drop if householdid=="343" & key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
drop if householdid=="348" & key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
drop if householdid=="361" & key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
drop if householdid=="246" & key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
drop if householdid=="391" & key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"




********** USERNAME CLEANING (AGREE WITH CECILE)
split username
destring username1, replace
label define username1 1"Antoni" 2"Vivek Radja" 3"Venkata" 4"Suganya-Malarvizhi" 5"Rajkumar" 6"Suganya-Malarvizhi" 7"Chithra-Radhika" 8"Raichal" 9"Rajalakschmi" 10"Chithra-Radhika" 11"Mayan" 12"Pazani", replace
label values username1 username1
fre username1
recode username1 (6=4)
recode username1 (10=7)
fre username1
drop username username2
rename username1 username
decode username, gen(username_str)
tab username_str

gen Chithra_and_Radhika=1 if username_str=="Chithra-Radhika"
replace Chithra_and_Radhika=0 if username_str!="Chithra-Radhika"

gen Raichal=1 if username_str=="Raichal"
replace Raichal=0 if username_str!="Raichal"

gen Mayan=1 if username_str=="Mayan"
replace Mayan=0 if username_str!="Mayan"

gen Pazani=1 if username_str=="Pazani"
replace Pazani=0 if username_str!="Pazani"

gen Rajalakschmi=1 if username_str=="Rajalakschmi"
replace Rajalakschmi=0 if username_str!="Rajalakschmi"

gen Suganya_and_Malarvizhi=1 if username_str=="Suganya-Malarvizhi"
replace Suganya_and_Malarvizhi=0 if username_str!="Suganya-Malarvizhi"

gen Vivek_Radja=1 if username_str=="Vivek Radja"
replace Vivek_Radja=0 if username_str!="Vivek Radja"
global username_dummy Suganya_and_Malarvizhi Raichal Rajalakschmi Chithra_and_Radhika Mayan Pazani





********** LABEL
/*
Pour les labels, il faut placer le fichier "" dans le dossier do_not_drop
*/
do"$directory\do_not_drop\_1-3-datachoicelist_v2.do"




********** INTERMEDIATE CHECKING
rename householdid householdid2020
destring caste, replace
duplicates tag key, gen(tag)
tab tag
drop tag





********** MERGE WITH UNIQUE IDENTIFIER PANEL
merge m:1 householdid2020 using "$directory\do_not_drop\unique_identifier_panel.dta", keepusing(villageid villageareaid HHID HHID2010 dummynewHH dummydemonetisation caste villageid_new villageid_new_comments tracked HHID_panel dummyHHlost2016 value_householdid_2020 householdid2020)
keep if _merge==3
drop _merge
rename key parent_key
order parent_key householdid2020 HHID2010, first
recast str20 HHID2010

********** INTERMEDIATE SAVING
save "$directory/CLEAN/NEEMSIS_APPEND.dta", replace
****************************************
* END
















****************************************
* APPEND HOUSEHOLD DATA BASE (indiv)
****************************************

********** APPEND
/*
APPEND la bonne base HH 
*/
use"$directory\rename\NEEMSIS2_LAST~_v4.dta", clear
append using "$directory\rename\NEEMSIS2_DECEMBER~_v4.dta", force
append using "$directory\rename\NEEMSIS2_DEC~_v4.dta", force
append using "$directory\rename\NEEMSIS2_FEB~_v4.dta", force
append using "$directory\rename\NEEMSIS2_FEBRUARY~_v4.dta", force
append using "$directory\rename\NEEMSIS2_NEW_APRIL~_v4.dta", force
append using "$directory\rename\NEEMSIS2_APRIL~_v4.dta", force
duplicates tag parent_key name, gen(tag)
tab tag
drop tag

********** DROP DUPLICATES (AGREE WITH CECILE)
drop if householdid=="67" & key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
drop if householdid=="124" & key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
drop if householdid=="343" & key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
drop if householdid=="348" & key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
drop if householdid=="361" & key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
drop if householdid=="246" & key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
drop if householdid=="391" & key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"





********** USERNAME CLEANING (AGREE WITH CECILE)
split username
destring username1, replace
label define username1 1"Antoni" 2"Vivek Radja" 3"Venkata" 4"Suganya-Malarvizhi" 5"Rajkumar" 6"Suganya-Malarvizhi" 7"Chithra-Radhika" 8"Raichal" 9"Rajalakschmi" 10"Chithra-Radhika" 11"Mayan" 12"Pazani", replace
label values username1 username1
fre username1
recode username1 (6=4)
recode username1 (10=7)
fre username1
drop username username2
rename username1 username
decode username, gen(username_str)
tab username_str

gen Chithra_and_Radhika=1 if username_str=="Chithra-Radhika"
replace Chithra_and_Radhika=0 if username_str!="Chithra-Radhika"

gen Raichal=1 if username_str=="Raichal"
replace Raichal=0 if username_str!="Raichal"

gen Mayan=1 if username_str=="Mayan"
replace Mayan=0 if username_str!="Mayan"

gen Pazani=1 if username_str=="Pazani"
replace Pazani=0 if username_str!="Pazani"

gen Rajalakschmi=1 if username_str=="Rajalakschmi"
replace Rajalakschmi=0 if username_str!="Rajalakschmi"

gen Suganya_and_Malarvizhi=1 if username_str=="Suganya-Malarvizhi"
replace Suganya_and_Malarvizhi=0 if username_str!="Suganya-Malarvizhi"

gen Vivek_Radja=1 if username_str=="Vivek Radja"
replace Vivek_Radja=0 if username_str!="Vivek Radja"
global username_dummy Suganya_and_Malarvizhi Raichal Rajalakschmi Chithra_and_Radhika Mayan Pazani




********** LABEL
do "$directory\do_not_drop\_1-3-datachoicelist_v2"






********** LABEL OK DONC RENAME AS I NOTED PREVIOUSLY
rename A1 a1
rename A2 a2
rename A3 a3
rename A4 a4
rename A5 a5
rename A6 a6
rename A7 a7
rename A8 a8
rename A9 a9
rename A10 a10
rename A11 a11
rename A12 a12
rename B1 b1
rename B2 b2
rename B3 b3
rename B4 b4
rename B5 b5
rename B6 b6
rename B7 b7
rename B8 b8
rename B9 b9
rename B10 b10
rename B11 b11
rename B12 b12
rename Ab1 ab1
rename Ab2 ab2
rename Ab3 ab3
rename Ab4 ab4
rename Ab5 ab5
rename Ab6 ab6
rename Ab7 ab7
rename Ab8 ab8
rename Ab9 ab9
rename Ab10 ab10
rename Ab11 ab11
rename Ab12 ab12






********** INTERMEDIATE CLEANING
rename householdid householdid2020
destring caste, replace
destring castepreload2016, replace
replace castepreload2016=caste if castepreload2016==.
duplicates tag parent_key name, gen(tag)
tab tag
drop tag





********** MERGE UNIQUE PANEL IDENTIFIER
merge m:1 householdid2020 using "$directory\do_not_drop\unique_identifier_panel.dta", keepusing(villageid villageareaid HHID HHID2010 dummynewHH dummydemonetisation caste villageid_new villageid_new_comments tracked HHID_panel dummyHHlost2016 value_householdid_2020 householdid2020)
keep if _merge==3
drop _merge
order parent_key householdid2020 HHID2010 name namefrompreload INDID INDID_former INDID_left ego, first
recast str20 HHID2010




********** INTERMEDIATE CLEANING
*Duplicates checking
duplicates tag householdid2020 HHID2010 name namefrompreload INDID INDID_former ego, gen(tag)
tab tag
sort householdid2020 INDID
list parent_key householdid2020 HHID2010 address version name submissiondate if tag==1, clean noobs
drop tag
order parent_key householdid2020 HHID2010 HHID_panel name INDID INDID_total INDID_former INDID_new INDID_left ego submissiondate

*Pb version of questionnaire for this var name donc je change ici
replace maritalstatusdate=marriagedateall if maritalstatusdate==.
drop marriagedateall

*INDID2010 creation
egen INDID2010=concat(HHID2010 INDID), p(/)
egen INDIDpanel=concat(HHID_panel INDID), p(/)
replace INDID2010="" if INDID_new!="."
replace INDIDpanel="" if INDID_new!="."
rename name_mb name_newmember
replace name=namefrompreload if name=="" & namefrompreload!=""





********** INTERMEDIATE SAVING
save"$directory\CLEAN\NEEMSIS2-HH_v4.dta", replace
****************************************
* END




********** BIG CLEANING
/*
We drop all files that are already merge with the database
We just put them together, but it is easier to drop file from here
*/

erase"$directory\CLEAN\NEEMSIS_APPEND-generalinformation-lefthome.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-individualid.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-familymembers.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-education.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-employment.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-migration-migrationidgroup.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-remittances-remreceived-remreceivedidgroup.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-remittances-remsent-remsentidgroup.dta"
*erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-loans-loansbyborrower.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-lendingmoneygroup-lendingmoney.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-guaranteeandrecommendation-recommendationgiven.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-chitfundgroup-chitfund.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-savingsgroup-savings.dta"
*erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-goldgroup-gold.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-insurancegroup-insurance.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-schemes-schemenrega-schemenregaind.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-schemes-cashassistancemarriage-cashassistancemarriagegroup.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-schemes-goldmarriage-goldmarriagegroup.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-memberlistpreload2016.dta"
forvalues i=1(1)7{
capture confirm file "$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension`i'-schemepension`i'group.dta"
if _rc==0{
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension`i'-schemepension`i'group.dta"
}
}












****************************************
* MERGING CHITFUND INSURANCE AND SAVINGS
****************************************

**********Chitfund
use"$directory\CLEAN\NEEMSIS_APPEND-detailschitfunds.dta", clear
drop parent_key forauto key
destring chitfundgroupid, replace
drop if chitfundgroupid==.
reshape wide chitfundtype durationchit nbermemberchit chitfundpayment chitfundpaymentamount chitfundamount covchitfundstop covchitfundreturn, i(setofdetailschitfunds) j(chitfundgroupid)
rename setofdetailschitfunds setofchitfund 
save"$directory\CLEAN\NEEMSIS_APPEND-detailschitfunds_wide.dta", replace


**********Savings
use"$directory\CLEAN\NEEMSIS_APPEND-detailssavingaccounts.dta", clear
drop savingsjointaccount_1 savingsjointaccount_2 savingsjointaccount_3 savingsjointaccount_4 savingsjointaccount_5 savingsjointaccount_6 savingsjointaccount_7 savingsjointaccount_8 savingsjointaccount_9 savingsjointaccount_10 savingsjointaccount_11 savingsjointaccount_12 savingsjointaccount_13 savingsjointaccount_14 savingsjointaccount_15 savingsjointaccount_16 savingsjointaccount_17 savingsjointaccount_18 savingsjointaccount_19 savingsjointaccount_20 savingsjointaccount_21 savingsjointaccount_22 savingsjointaccount_23 savingsjointaccount_24 savingsjointaccount_25 savingsjointaccount_26 savingsjointaccount_27 savingsjointaccount_28 savingsjointaccount_29 savingsjointaccount_30 savingsjointaccount_31 savingsjointaccount_32
drop savingspurpose_1 savingspurpose_3 savingspurpose_6 savingspurpose_2 savingspurpose_4 savingspurpose_5
drop usedebitcard_2 usedebitcard_5 usedebitcard_4 usedebitcard_6 usedebitcard_3
drop usecreditcard_2 usecreditcard_4
drop usedebitcard_77 usedebitcard_1 reasonnotusedebitcard_2 usecreditcard_3 usecreditcard_5 savingsjointaccount_33 savingsjointaccount_34 reasonnotusedebitcard_1
drop parent_key key
destring savingaccountid, replace
reshape wide savingsaccounttype savingsjointaccount banktype savingsbankname savingsbankplace savingsamount savingspurpose covsavinguse dummydebitcard dummycreditcard covsavinguseamount usedebitcard usedebitcardother reasonnotusedebitcard reasonnotusedebitcardother usecreditcard usecreditcardother reasonnotusedcreditcard reasonnotusedcreditcardother savingsaccountdate datedebitcard datecreditcard, i(setofdetailssavingaccounts ) j(savingaccountid)
rename setofdetailssavingaccounts setofsavings
save"$directory\CLEAN\NEEMSIS_APPEND-detailssavingaccounts_wide.dta", replace

**********Insurance
use"$directory\CLEAN\NEEMSIS_APPEND-detailsinsurance.dta", clear
drop parent_key key
destring insuranceid, replace
rename insurancetype2 insurancetypetwo
reshape wide insurancetype insurancename insurancetypetwo insurancepaymentfrequency insuranceamount insurancebenefit insurancebenefitamount insurancejoineddate, i(setofdetailsinsurance) j(insuranceid)
rename setofdetailsinsurance setofinsurance
save"$directory\CLEAN\NEEMSIS_APPEND-detailsinsurance_wide.dta", replace



**********Merge with 
use"$directory\CLEAN\NEEMSIS2-HH_v4.dta", clear

merge m:1 setofchitfund using "$directory\CLEAN\NEEMSIS_APPEND-detailschitfunds_wide.dta"
drop if _merge==2
drop _merge

merge m:1 setofsavings using "$directory\CLEAN\NEEMSIS_APPEND-detailssavingaccounts_wide.dta"
drop if _merge==2
drop _merge

merge m:1 setofinsurance using "$directory\CLEAN\NEEMSIS_APPEND-detailsinsurance_wide.dta"
drop if _merge==2
drop _merge

********** INTERMEDIATE SAVING
save"$directory\CLEAN\NEEMSIS2-HH_v5.dta", replace




********** BIG CLEANING
erase"$directory\CLEAN\NEEMSIS_APPEND-detailschitfunds_wide.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-detailssavingaccounts_wide.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-detailsinsurance_wide.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-detailschitfunds.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-detailssavingaccounts.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-detailsinsurance.dta"

****************************************
* END

