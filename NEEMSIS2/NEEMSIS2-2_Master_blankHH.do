cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
February 23, 2021
-----
CLEANING HH FILE OF NEEMSIS2
-----
Desc: 
FROM HOUSEHOLD TO INDIVIDUAL
WORK ONLY FOR BLANK HOUSEHOLD
IF IT IS PANEL HOUSEHOLD,
USE Master
-------------------------
*/


****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA"

********** Name of the NEEMSIS2 questionnaire version to clean
global preamble "NEEMSIS2_NEW_JUNE"

********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

****************************************
* END







** AUTOMATIC NOW
**************************************************************************************************************
**************************************************************************************************************
**************************************************************************************************************
**************************************************************************************************************
**************************************************************************************************************



********** AUTO CALCULATION
global subdirectory ="$preamble"
global subpath= "$directory" + "\" + "$subdirectory"
clear all
set maxvar 120000 



/*
Les positions ne sont pas parfaites de base.
En effet, le questionnaire sorti de Survey CTO est en HH ligne.
Pour faire une base analysable, il faut que les individus soient en lignes.
Pour cela, la procédure classique est un reshape.
Le souci étant que les _i associés aux individus ne se suivent pas et décrochent pour les égos:
Si égo 2 est i=3, les variables du questionnaire individuelle ne seront pas respect_3, mais elles seront
_3respect.
Il faut donc remodeler les données pour qu'ils aient la forme:
name_1 sex_1 age_1 name_2 sex_2 age_2
Arnaud Male  23    Raja   Male  99

(Et ainsi devenir
Name 	sex 	age
Arnaud	Male	23
Raja	Male	99)
*/

cd "$subpath"
use"$preamble.dta", clear
destring householdid, gen(householdid_int)

********** DUPLICATES HH TO DROP (AGREE WITH CECILE)
drop if householdid_int==124 & key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
drop if householdid_int==343 & key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
drop if householdid_int==348 & key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
drop if householdid_int==361 & key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
drop if householdid_int==67 & key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
drop if householdid_int==246 & key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
drop if householdid_int==391 & key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
drop if householdid_int==36 & key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"








********** NEW MEMBER LIST (maybe need to add new line)
gen newmember=""
capture confirm v name1
if !_rc {
replace newmember="1" if name1!=""
capture confirm v name2
if !_rc {
replace newmember="1 2" if name1!="" & name2!=""
capture confirm v name3
if !_rc {
replace newmember="1 2 3" if name1!="" & name2!="" & name3!=""
capture confirm v name4
if !_rc {
replace newmember="1 2 3 4" if name1!="" & name2!="" & name3!="" & name4!=""
capture confirm v name5
if !_rc {
replace newmember="1 2 3 4 5" if name1!="" & name2!="" & name3!="" & name4!="" & name5!=""
capture confirm v name6
if !_rc {
replace newmember="1 2 3 4 5 6" if name1!="" & name2!="" & name3!="" & name4!="" & name5!="" & name6!=""
capture confirm v name7
if !_rc {
replace newmember="1 2 3 4 5 6 7" if name1!="" & name2!="" & name3!="" & name4!="" & name5!="" & name6!="" & name7!=""
capture confirm v name8
if !_rc {
replace newmember="1 2 3 4 5 6 7 8" if name1!="" & name2!="" & name3!="" & name4!="" & name5!="" & name6!="" & name7!="" & name8!=""
capture confirm v name9
if !_rc {
replace newmember="1 2 3 4 5 6 7 8 9" if name1!="" & name2!="" & name3!="" & name4!="" & name5!="" & name6!="" & name7!="" & name8!="" & name9!=""
capture confirm v name10
if !_rc {
replace newmember="1 2 3 4 5 6 7 8 9 10" if name1!="" & name2!="" & name3!="" & name4!="" & name5!="" & name6!="" & name7!="" & name8!="" & name9!="" & name10!=""
capture confirm v name11
if !_rc {
replace newmember="1 2 3 4 5 6 7 8 9 10 11" if name1!="" & name2!="" & name3!="" & name4!="" & name5!="" & name6!="" & name7!="" & name8!="" & name9!="" & name10!="" & name11!=""
capture confirm v name12
if !_rc {
replace newmember="1 2 3 4 5 6 7 8 9 10 11 12" if name1!="" & name2!="" & name3!="" & name4!="" & name5!="" & name6!="" & name7!="" & name8!="" & name9!="" & name10!="" & name11!="" & name12!=""
capture confirm v name13
if !_rc {
replace newmember="1 2 3 4 5 6 7 8 9 10 11 12 13" if name1!="" & name2!="" & name3!="" & name4!="" & name5!="" & name6!="" & name7!="" & name8!="" & name9!="" & name10!="" & name11!="" & name12!="" & name13!=""
capture confirm v name14
if !_rc {
replace newmember="1 2 3 4 5 6 7 8 9 10 11 12 13 14" if name1!="" & name2!="" & name3!="" & name4!="" & name5!="" & name6!="" & name7!="" & name8!="" & name9!="" & name10!="" & name11!="" & name12!="" & name13!="" & name14!=""
capture confirm v name15
if !_rc {
replace newmember="1 2 3 4 5 6 7 8 9 10 11 12 13 14" if name1!="" & name2!="" & name3!="" & name4!="" & name5!="" & name6!="" & name7!="" & name8!="" & name9!="" & name10!="" & name11!="" & name12!="" & name13!="" & name14!="" & name15!=""
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}








********** TOTAL INDIVIDUALS LIST
gen formermember=""  // juste pour ne pas avoir à modifier tous les codes
egen tot_HH=concat(formermember newmember) if newmember!="", p(" ")
replace tot_HH=formermember if newmember==""







********** COUNT NUMBER OF INDIVIDUALS IN EACH CATEGORY (TOTAL, FORMER, NEW, LEFT)
*TOTAL
split tot_HH
forvalues i=1(1)50{
capture confirm v tot_HH`i'
if !_rc {
global totmax "`i'"
}
}
dis $totmax
*NEW
dropmiss newmember, force
capture confirm v newmember
if !_rc {
split newmember
forvalues i=1(1)50{
capture confirm v newmember`i'
if !_rc {
global newmax "`i'"
}
}
dis $newmax
}









********** CALCULATION OF ABSOLUT EGO POSITIONS (FOR RESHAPE)
gen ego1position_full=""
forvalues i=1(1)$totmax{
replace ego1position_full=tot_HH`i' if indexego1final=="`i'"
}
gen ego2position_full=""
forvalues i=1(1)$totmax{
replace ego2position_full=tot_HH`i' if ego2position=="`i'"
}
gen ego3position_full=""
forvalues i=1(1)$totmax{
replace ego3position_full=tot_HH`i' if ego3position=="`i'"
}

gen ego3positionname_full=""
forvalues i=1(1)15{
replace ego3positionname_full=name`i' if ego3position_full=="`i'"
}
*
destring ego1position_full, gen(ego1INDID)
destring ego2position_full, gen(ego2INDID)
destring ego3position_full, gen(ego3INDID)
*Pb id avec Cécile
replace ego2position="2" if householdid=="39"
replace ego2position_full="2" if householdid=="39"
replace ego2INDID=2 if householdid=="39"











********** PUT DIFFERENT INDID IN WIDE FORMAT
*TOTAL INDID
forvalues i=1(1)$totmax{
destring tot_HH`i', replace
}
gen INDID_total=.
forvalues i=1(1)32{
gen INDID_total_`i'=.				
}
forvalues j=1(1)$totmax{
forvalues i=1(1)32{
replace INDID_total_`i'=`j' if tot_HH`j'==`i'
}
}
drop INDID_total
forvalues i=1(1)$totmax{
tostring tot_HH`i', replace
}
*NEW INDID
capture confirm v newmember
if !_rc {
	forvalues i=1(1)$newmax{
	destring newmember`i', replace
	}
	gen INDID_new=.
	forvalues i=1(1)32{
	gen INDID_new_`i'=.				
	}
	forvalues j=1(1)$newmax{
	forvalues i=1(1)32{
	replace INDID_new_`i'=`j' if newmember`j'==`i'
	}
	}
	drop INDID_new
	forvalues i=1(1)$newmax{
	tostring newmember`i', replace
	}
}
else {
	forvalues i=1(1)32{
	gen INDID_new_`i'=.				
	} 
}







********** INTERMEDIATE CLEANING
forvalues i=1(1)$totmax{
drop tot_HH`i'
}
drop ego1position_full ego2position_full ego3position_full ego3positionname_full
*Drop a part of dummy variable created by Survey CTO to lighten the data base
forvalues i=1(1)900{
foreach x in a1_`i'	a10_`i'	a11_`i'	a12_`i'	a2_`i'	a3_`i'	a4_`i'	a5_`i'	a6_`i'	a7_`i'	a8_`i'	a9_`i'	ab1_`i'	ab10_`i'	ab11_`i'	ab12_`i'	ab2_`i'	ab3_`i'	ab4_`i'	ab5_`i'	ab6_`i'	ab7_`i'	ab8_`i'	ab9_`i'	accidentalinjury_`i'	activeimagination_`i'	agestartworking_`i'	agestartworkingpaidjob_`i'	agreementatwork1_`i'	agreementatwork2_`i'	agreementatwork3_`i'	agreementatwork4_`i'	amountgrossreceipt_`i'	annualincomeindself_`i'	appointmentontime_`i'	aspirationminimumwage_`i'	aspirationminimumwage2_`i'	associationlist_`i'	attendedschoolfromearlier_`i'	b1_`i'	b10_`i'	b11_`i'	b12_`i'	b2_`i'	b3_`i'	b4_`i'	b5_`i'	b6_`i'	b7_`i'	b8_`i'	b9_`i'	beforemainoccup_`i'	break_`i'	businessafter15_`i'	businessamountinvest_`i'	businessexpenses_`i'	businessfixedcosts_`i'	businessfixedcostsamount_`i'	businesslaborcost_`i'	businesslossinvest_`i'	businesslossinvestamount_`i'	businessnbfamilyworkers_`i'	businessnbpaidworkers_`i'	businessnbunpaidworkers_`i'	businessnbworkers_`i'	businesspaymentinkind_`i'	businesspaymentinkindlist_`i'	businesssocialsecurity_`i'	businesssourceinvest_`i'	businessworkersfrequencypayment_`i'	canreadcard1a_`i'	canreadcard1b_`i'	canreadcard1c_`i'	canreadcard2_`i'	changemood_`i'	changework_`i'	completeduties_`i'	contactleaders_`i'	contactlist_`i'	contract_`i'	countcovsnhelpgiven_`i'	countcovsnhelpreceived_`i'	covassociationhelp_`i'	covassociationhelplist_`i'	covassociationhelplistother_`i'	covassociationhelptype_`i'	covassociationhelptypeother_`i'	covcontactinstitution_`i'	covdifficulties_`i'	covinstit1_`i'	covinstit10_`i'	covinstit2_`i'	covinstit3_`i'	covinstit4_`i'	covinstit5_`i'	covinstit6_`i'	covinstit7_`i'	covinstit8_`i'	covinstit9_`i'	covmostefficienthelp_`i'	covmostefficienthelpfromearlier_`i'	covmostefficienthelpopen_`i'	covmostefficienthelpother_`i'	covnetworkhelpkinmember_`i'	covnetworkpeoplehelping_`i'	covneworktrustneighborhood_`i'	covsnhelpgiven_`i'	covsnhelpgivenlist_`i'	covsnhelpreceived_`i'	covsnhelpreceivedlist_`i'	covsnhelpreceivedname1_`i'	covsnhelpreceivedname2_`i'	covsnhelpreceivedname3_`i'	covsnhelpreceivedname4_`i'	covsnhelpreceivedname5_`i'	curious_`i'	decisionearnwork_`i'	decisionearnworkother_`i'	decisionwork_`i'	decisionworkother_`i'	discrimination1_`i'	discrimination2_`i'	discrimination3_`i'	discrimination4_`i'	discrimination5_`i'	discrimination6_`i'	discrimination7_`i'	discrimination8_`i'	discrimination9_`i'	dummyaspirationmorehours_`i'	dummybusinesspaidworkers_`i'	dummybusinessunpaidworkers_`i'	dummycontactleaders_`i'	dummymainoccupation2_`i'	dummypreviouswagejob_`i'	dummyseasonalmainoccup_`i'	easilydistracted_`i'	easilyupset_`i'	enjoypeople_`i'	enthusiastic_`i'	everwork_`i'	executionwork1_`i'	executionwork2_`i'	executionwork3_`i'	executionwork4_`i'	executionwork5_`i'	executionwork6_`i'	executionwork7_`i'	executionwork8_`i'	executionwork9_`i'	expressingthoughts_`i'	feeldepressed_`i'	finishtasks_`i'	finishwhatbegin_`i'	forgiveother_`i'	frequencygrossreceipt_`i'	goaftergoal_`i'	happywork_`i'	helpfulwithothers_`i'	inddaysamonth3_`i'	inddaysayear2_`i'	indhoursaday2_`i'	indhoursaday3_`i'	indhoursamonth3_`i'	indhoursayear_`i'	indhoursayear1_`i'	indhoursayear2_`i'	indhoursayear3_`i'	interestedbyart_`i'	inventive_`i'	jobfirstwageamountcash_`i'	jobfirstwagefrequencycash_`i'	jobpreference_`i'	jobwageamountcash_`i'	jobwagefrequencycash_`i'	keepworking_`i'	kindofworkfirstjob_`i'	lackskill_`i'	liketothink_`i'	locuscontrol1_`i'	locuscontrol2_`i'	locuscontrol3_`i'	locuscontrol4_`i'	locuscontrol5_`i'	locuscontrol6_`i'	losswork_`i'	lossworknumber_`i'	mainoccupationfromearlier_`i'	mainoccuptype_`i'	makeplans_`i'	managestress_`i'	maxhoursayear_`i'	methodfindfirstjob_`i'	methodfindjob_`i'	monthstofindjob_`i'	mostseriousincident_`i'	mostseriousinjury_`i'	moveoutsideforjob_`i'	moveoutsideforjobreason_`i'	moveoutsideforjobreasonother_`i'	nbercontactphone_`i'	nbermonthsearchjob_`i'	nberpersonfamilyevent_`i'	nbofoccupations_`i'	nervous_`i'	networkhelpkinmember_`i'	networkpeoplehelping_`i'	networktrustemployees_`i'	networktrustneighborhood_`i'	newideas_`i'	numberbusinessloan_`i'	numeracy1_`i'	numeracy2_`i'	numeracy3_`i'	numeracy4_`i'	numeracy5_`i'	numeracy6_`i'	occupation1_`i'	occupation2_`i'	occupation3_`i'	occupation4_`i'	occupation5_`i'	occupation6_`i'	occupation7_`i'	occupation8_`i'	opinionactivewoman_`i'	opinionworkingwoman_`i'	organized_`i'	otherbeforemainoccup_`i'	otherbeforemainoccupduration_`i'	otherbusinesssourceinvestment_`i'	othermainoccupation2_`i'	othermethodfindfirstjob_`i'	otherreasonstoppedjob_`i'	physicalagression_`i'	physicalharm_`i'	previousjobcontract_`i'	problemwork1_`i'	problemwork10_`i'	problemwork2_`i'	problemwork4_`i'	problemwork5_`i'	problemwork6_`i'	problemwork7_`i'	problemwork8_`i'	problemwork9_`i'	professionalequipment_`i'	putoffduties_`i'	readystartjob_`i'	reasondontsearchjob_`i'	reasondontsearchjobsince15_`i'	reasondontworkmore_`i'	reasonnotworkpastyearfromearlier_`i'	reasonstoppedwagejob_`i'	repetitivetasks_`i'	resdiscrimination1_`i'	resdiscrimination2_`i'	resdiscrimination3_`i'	resdiscrimination4_`i'	resdiscrimination5_`i'	respect_`i'	retirementwork_`i'	rudetoother_`i'	rurallocation_`i'	satisfactionsalary_`i'	satisfyingpurpose_`i'	schedule_`i'	searchjob_`i'	searchjobsince15_`i'	seriousinjuryother_`i'	sexualaggression_`i'	sexualharassment_`i'	sharefeelings_`i'	shywithpeople_`i'	snbusinesslender1_`i'	snbusinesslender2_`i'	snbusinesslender3_`i'	snbusinesslender4_`i'	snbusinesslender5_`i'	snbusinesslender6_`i'	sncloserelouthh_`i'	sncloserelouthhname1_`i'	sncloserelouthhname2_`i'	sncloserelouthhname3_`i'	sncloserelouthhname4_`i'	snfindcurrentjob_`i'	snfindcurrentjobname1_`i'	snfindcurrentjobname2_`i'	snfindcurrentjobname3_`i'	snfindcurrentjobname4_`i'	snfindcurrentjobname5_`i'	snfindcurrentjobnamelist_`i'	snfindfirstjob_`i'	snfindjob_`i'	snfindjobname1_`i'	snfindjobname2_`i'	snfindjobname3_`i'	snfindjobname4_`i'	snfindjobname5_`i'	snfindjobnamelist_`i'	snhelpemergency_`i'	snhelpemergencyname1_`i'	snhelpemergencyname2_`i'	snhelpemergencyname3_`i'	snhelpemergencyname4_`i'	snhelpemergencyname5_`i'	snrecojobsuccess_`i'	snrecojobsuccessname1_`i'	snrecojobsuccessname2_`i'	snrecojobsuccessname3_`i'	snrecojobsuccessname4_`i'	snrecojobsuccessname5_`i'	snrecojobsuccessnamelist_`i'	snrecommendassoname1_`i'	snrecommendassoname10_`i'	snrecommendassoname11_`i'	snrecommendassoname12_`i'	snrecommendassoname13_`i'	snrecommendassoname14_`i'	snrecommendassoname15_`i'	snrecommendassoname16_`i'	snrecommendassoname17_`i'	snrecommendassoname18_`i'	snrecommendassoname19_`i'	snrecommendassoname2_`i'	snrecommendassoname20_`i'	snrecommendassoname21_`i'	snrecommendassoname22_`i'	snrecommendassoname23_`i'	snrecommendassoname24_`i'	snrecommendassoname3_`i'	snrecommendassoname4_`i'	snrecommendassoname5_`i'	snrecommendassoname6_`i'	snrecommendassoname7_`i'	snrecommendassoname8_`i'	snrecommendassoname9_`i'	snrecommendforjob_`i'	snrecommendforjobname1_`i'	snrecommendforjobname2_`i'	snrecommendforjobname3_`i'	snrecommendforjobname4_`i'	snrecommendforjobname5_`i'	snrecommendforjobnamelist_`i'	snrecruitworker_`i'	snrecruitworkername1_`i'	snrecruitworkername2_`i'	snrecruitworkername3_`i'	snrecruitworkername4_`i'	snrecruitworkername5_`i'	snrecruitworkernamelist_`i'	sntalkthemost_`i'	sntalkthemostname1_`i'	sntalkthemostname2_`i'	sntalkthemostname3_`i'	sntalkthemostname4_`i'	startbusiness_`i'	staycalm_`i'	stickwithgoals_`i'	sumwagejobpaymentinkindvalue_`i'	takeholiday_`i'	talkative_`i'	talktomanypeople_`i'	toleratefaults_`i'	trustingofother_`i'	tryhard_`i'	understandotherfeeling_`i'	unpaidinbusinessfirstjob_`i'	useknowledgeatwork_`i'	verbalaggression_`i'	wageamountmonth_`i'	wageamountmonth1_`i'	wageamountmonth2_`i'	wageamountmonth3_`i'	wageamountmonth4_`i'	wagejobpaymentinkind_`i'	wagejobpaymentinkindlist_`i'	wagejobsocialsecurity_`i'	wagejobtype_`i'	workedpastyearfromearlier_`i'	workexposure1_`i'	workexposure2_`i'	workexposure3_`i'	workexposure4_`i'	workexposure5_`i'	workhard_`i'	workmate_`i'	workpastsevendays_`i'	workwithother_`i'	worryalot_`i' selected_months_`i' _2selected_months_`i' _3selected_months_`i' {
capture confirm v `x'
if !_rc {
drop `x'				
}
capture confirm v _2`x'
if !_rc {
drop _2`x'				
}
capture confirm v _3`x'
if !_rc {
drop _3`x'				
}
}
}
*Rename variable with too long name
rename reasonnotworkpastyearfromearlier reasonnotworkpastyearfrom
rename covmostefficienthelpfromearlier covmostefficienthelpfrom
rename businessworkersfrequencypayment businessworkersfrequency
*Creation of id ego
gen dummyego=.
gen ego=.











**********GENERATE WIDE VARIABLES FOR EGO
/*
Comme je l'ai dit, les variables de égos ne sont pas en vrai WIDE.
Au lieu que égo 2 (position 3 disons) ait respect_3
Il a _2respect
Je dois donc remodeler pour passer de _2respect à respect_3.
Nous venons d'identifier le vrai code des égos (3 ici).
Nous allons maintenant créer toutes les variables en vrai WIDE (respect_3 par exemple).
(Mais pour faciliter l'identification TOUTES les var égos sont créés: _2respect_1, etc.).
Puis nous basculerons les valeurs des anciennes variables (_2respect) vers les nouvelles (respect_3).
Nous supprimerons ensuite les anciennes variables.

Ici nous générons toutes les variables égos en WIDE
*/
global egovar reasonnotworkpastyearfrom	covmostefficienthelpfrom	businessworkersfrequency	otherbusinesssourceinvestment	sumwagejobpaymentinkindvalue	otherbeforemainoccupduration	moveoutsideforjobreasonother	covassociationhelptypeother	covassociationhelplistother	reasondontsearchjobsince15	dummybusinessunpaidworkers	covneworktrustneighborhood	workedpastyearfromearlier	snrecommendforjobnamelist	mainoccupationfromearlier	jobfirstwagefrequencycash	covmostefficienthelpother	businesspaymentinkindlist	attendedschoolfromearlier	wagejobpaymentinkindlist	unpaidinbusinessfirstjob	snrecojobsuccessnamelist	snfindcurrentjobnamelist	networktrustneighborhood	dummybusinesspaidworkers	dummyaspirationmorehours	covmostefficienthelpopen	businesslossinvestamount	businessfixedcostsamount	snrecruitworkernamelist	othermethodfindfirstjob	moveoutsideforjobreason	covnetworkpeoplehelping	covnetworkhelpkinmember	businessnbunpaidworkers	businessnbfamilyworkers	understandotherfeeling	snrecommendforjobname5	snrecommendforjobname4	snrecommendforjobname3	snrecommendforjobname2	snrecommendforjobname1	jobfirstwageamountcash	dummyseasonalmainoccup	covsnhelpreceivedname5	covsnhelpreceivedname4	covsnhelpreceivedname3	covsnhelpreceivedname2	covsnhelpreceivedname1	covassociationhelptype	covassociationhelplist	countcovsnhelpreceived	businesssocialsecurity	aspirationminimumwage2	agestartworkingpaidjob	wagejobsocialsecurity	snrecommendassoname24	snrecommendassoname23	snrecommendassoname22	snrecommendassoname21	snrecommendassoname20	snrecommendassoname19	snrecommendassoname18	snrecommendassoname17	snrecommendassoname16	snrecommendassoname15	snrecommendassoname14	snrecommendassoname13	snrecommendassoname12	snrecommendassoname11	snrecommendassoname10	snrecojobsuccessname5	snrecojobsuccessname4	snrecojobsuccessname3	snrecojobsuccessname2	snrecojobsuccessname1	snfindcurrentjobname5	snfindcurrentjobname4	snfindcurrentjobname3	snfindcurrentjobname2	snfindcurrentjobname1	professionalequipment	otherreasonstoppedjob	networktrustemployees	nberpersonfamilyevent	frequencygrossreceipt	decisionearnworkother	covsnhelpreceivedlist	covcontactinstitution	businesspaymentinkind	businessnbpaidworkers	aspirationminimumwage	wagejobpaymentinkind	snrecruitworkername5	snrecruitworkername4	snrecruitworkername3	snrecruitworkername2	snrecruitworkername1	snrecommendassoname9	snrecommendassoname8	snrecommendassoname7	snrecommendassoname6	snrecommendassoname5	snrecommendassoname4	snrecommendassoname3	snrecommendassoname2	snrecommendassoname1	snhelpemergencyname5	snhelpemergencyname4	snhelpemergencyname3	snhelpemergencyname2	snhelpemergencyname1	sncloserelouthhname4	sncloserelouthhname3	sncloserelouthhname2	sncloserelouthhname1	reasonstoppedwagejob	othermainoccupation2	otherbeforemainoccup	networkpeoplehelping	networkhelpkinmember	jobwagefrequencycash	dummypreviouswagejob	dummymainoccupation2	covmostefficienthelp	businesssourceinvest	businessamountinvest	reasondontsearchjob	previousjobcontract	opinionworkingwoman	mostseriousincident	dummycontactleaders	countcovsnhelpgiven	annualincomeindself	useknowledgeatwork	sntalkthemostname4	sntalkthemostname3	sntalkthemostname2	sntalkthemostname1	seriousinjuryother	satisfactionsalary	resdiscrimination5	resdiscrimination4	resdiscrimination3	resdiscrimination2	resdiscrimination1	reasondontworkmore	opinionactivewoman	numberbusinessloan	nbermonthsearchjob	methodfindfirstjob	kindofworkfirstjob	expressingthoughts	covsnhelpgivenlist	covassociationhelp	businesslossinvest	businessfixedcosts	amountgrossreceipt	workpastsevendays	snrecommendforjob	snfindjobnamelist	snbusinesslender6	snbusinesslender5	snbusinesslender4	snbusinesslender3	snbusinesslender2	snbusinesslender1	satisfyingpurpose	physicalagression	moveoutsideforjob	mostseriousinjury	jobwageamountcash	helpfulwithothers	decisionworkother	covsnhelpreceived	businessnbworkers	businesslaborcost	appointmentontime	activeimagination	wageamountmonth4	wageamountmonth3	wageamountmonth2	wageamountmonth1	verbalaggression	talktomanypeople	snrecojobsuccess	snfindcurrentjob	sexualharassment	sexualaggression	searchjobsince15	nbercontactphone	easilydistracted	decisionearnwork	businessexpenses	agreementatwork4	agreementatwork3	agreementatwork2	agreementatwork1	accidentalinjury	wageamountmonth	trustingofother	snrecruitworker	snhelpemergency	sncloserelouthh	repetitivetasks	nbofoccupations	monthstofindjob	interestedbyart	indhoursamonth3	finishwhatbegin	discrimination9	discrimination8	discrimination7	discrimination6	discrimination5	discrimination4	discrimination3	discrimination2	discrimination1	covdifficulties	businessafter15	beforemainoccup	associationlist	agestartworking	toleratefaults	stickwithgoals	snfindjobname5	snfindjobname4	snfindjobname3	snfindjobname2	snfindjobname1	snfindfirstjob	retirementwork	lossworknumber	indhoursayear3	indhoursayear2	indhoursayear1	inddaysamonth3	executionwork9	executionwork8	executionwork7	executionwork6	executionwork5	executionwork4	executionwork3	executionwork2	executionwork1	covsnhelpgiven	contactleaders	completeduties	workwithother	workexposure5	workexposure4	workexposure3	workexposure2	workexposure1	startbusiness	sntalkthemost	shywithpeople	sharefeelings	rurallocation	readystartjob	problemwork10	methodfindjob	maxhoursayear	mainoccuptype	locuscontrol6	locuscontrol5	locuscontrol4	locuscontrol3	locuscontrol2	locuscontrol1	jobpreference	indhoursayear	indhoursaday3	indhoursaday2	inddaysayear2	feeldepressed	canreadcard1c	canreadcard1b	canreadcard1a	putoffduties	problemwork9	problemwork8	problemwork7	problemwork6	problemwork5	problemwork4	problemwork2	problemwork1	physicalharm	managestress	forgiveother	enthusiastic	decisionwork	canreadcard2	wagejobtype	takeholiday	rudetoother	occupation8	occupation7	occupation6	occupation5	occupation4	occupation3	occupation2	occupation1	liketothink	keepworking	goaftergoal	finishtasks	enjoypeople	easilyupset	covinstit10	contactlist	covinstit9	covinstit8	covinstit7	covinstit6	covinstit5	covinstit4	covinstit3	covinstit2	covinstit1	changework	changemood	worryalot	talkative	snfindjob	searchjob	organized	numeracy6	numeracy5	numeracy4	numeracy3	numeracy2	numeracy1	makeplans	lackskill	inventive	happywork	workmate	workhard	staycalm	schedule	newideas	losswork	everwork	contract	tryhard	respect	nervous	curious	break	a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 ab1 ab2 ab3 ab4 ab5 ab6 ab7 ab8 ab9 ab10 ab11 ab12 selected_occupposition selected_occupname selected_months selected_months_monthsid
foreach x in $egovar dummyego ego{
forvalues i=1(1)30{
capture confirm numeric variable `x'
if !_rc {
gen `x'_`i'=.				
}
capture confirm string variable `x'
if !_rc {
gen `x'_`i'=""			
}
}
}







********** EGO ID CREATION
forvalues i=1(1)30{
replace dummyego_`i'=1 if ego1INDID==`i'
replace dummyego_`i'=1 if ego2INDID==`i'
replace dummyego_`i'=1 if ego3INDID==`i'
}
drop ego
forvalues i=1(1)30{
replace ego_`i'=1 if ego1INDID==`i'
replace ego_`i'=2 if ego2INDID==`i'
replace ego_`i'=3 if ego3INDID==`i'
}










*********** EGO 1 VAR TO EGO 1 WIDE
foreach x in $egovar {
forvalues i=1(1)30{
replace `x'_`i'=`x' if ego1INDID==`i'
}
capture confirm string variable `x'
if !_rc {
replace `x'=""			
}
capture confirm numeric variable `x'
if !_rc {
replace `x'=.			
}
}






*********** EGO 2 VAR TO EGO 2 WIDE
foreach x in $egovar{
capture confirm v _2`x'
if !_rc {
replace `x'=_2`x'
drop _2`x'
}
forvalues i=1(1)30{
replace `x'_`i'=`x' if ego2INDID==`i'
}
capture confirm string variable `x'
if !_rc {
replace `x'=""			
}
capture confirm numeric variable `x'
if !_rc {
replace `x'=.			
}
}







*********** EGO 3 VAR TO EGO 3 WIDE
foreach x in $egovar{
capture confirm numeric v _3`x'
if !_rc {
capture confirm string v `x'
if !_rc {
tostring _3`x', replace
}
}
capture confirm v _3`x'
if !_rc {
replace `x'=_3`x'
drop _3`x'
}
forvalues i=1(1)30{
replace `x'_`i'=`x' if ego3INDID==`i'
}
capture confirm string variable `x'
if !_rc {
replace `x'=""			
}
capture confirm numeric variable `x'
if !_rc {
replace `x'=.			
}
}











********** DROP OLD VAR
foreach x in $egovar{
capture confirm v `x'
if !_rc {
drop `x'
}
capture confirm v _2`x'
if !_rc {
drop _2`x'
}
capture confirm v _3`x'
if !_rc {
drop _3`x'
}
}
foreach x in dummyego_* ego_*{
recode `x' (.=0)
}
drop dummyego









********** RESHAPE
reshape long reasonnotworkpastyearfrom_ ego_ dummyego_ INDID_total_	covmostefficienthelpfrom_	businessworkersfrequency_	otherbusinesssourceinvestment_	sumwagejobpaymentinkindvalue_	otherbeforemainoccupduration_	moveoutsideforjobreasonother_	covassociationhelptypeother_	covassociationhelplistother_	reasondontsearchjobsince15_	dummybusinessunpaidworkers_	covneworktrustneighborhood_	workedpastyearfromearlier_	snrecommendforjobnamelist_	mainoccupationfromearlier_	jobfirstwagefrequencycash_	covmostefficienthelpother_	businesspaymentinkindlist_	attendedschoolfromearlier_	wagejobpaymentinkindlist_	unpaidinbusinessfirstjob_	snrecojobsuccessnamelist_	snfindcurrentjobnamelist_	networktrustneighborhood_	dummybusinesspaidworkers_	dummyaspirationmorehours_	covmostefficienthelpopen_	businesslossinvestamount_	businessfixedcostsamount_	snrecruitworkernamelist_	othermethodfindfirstjob_	moveoutsideforjobreason_	covnetworkpeoplehelping_	covnetworkhelpkinmember_	businessnbunpaidworkers_	businessnbfamilyworkers_	understandotherfeeling_	snrecommendforjobname5_	snrecommendforjobname4_	snrecommendforjobname3_	snrecommendforjobname2_	snrecommendforjobname1_	jobfirstwageamountcash_	dummyseasonalmainoccup_	covsnhelpreceivedname5_	covsnhelpreceivedname4_	covsnhelpreceivedname3_	covsnhelpreceivedname2_	covsnhelpreceivedname1_	covassociationhelptype_	covassociationhelplist_	countcovsnhelpreceived_	businesssocialsecurity_	aspirationminimumwage2_	agestartworkingpaidjob_	wagejobsocialsecurity_	snrecommendassoname24_	snrecommendassoname23_	snrecommendassoname22_	snrecommendassoname21_	snrecommendassoname20_	snrecommendassoname19_	snrecommendassoname18_	snrecommendassoname17_	snrecommendassoname16_	snrecommendassoname15_	snrecommendassoname14_	snrecommendassoname13_	snrecommendassoname12_	snrecommendassoname11_	snrecommendassoname10_	snrecojobsuccessname5_	snrecojobsuccessname4_	snrecojobsuccessname3_	snrecojobsuccessname2_	snrecojobsuccessname1_	snfindcurrentjobname5_	snfindcurrentjobname4_	snfindcurrentjobname3_	snfindcurrentjobname2_	snfindcurrentjobname1_	professionalequipment_	otherreasonstoppedjob_	networktrustemployees_	nberpersonfamilyevent_	frequencygrossreceipt_	decisionearnworkother_	covsnhelpreceivedlist_	covcontactinstitution_	businesspaymentinkind_	businessnbpaidworkers_	aspirationminimumwage_	wagejobpaymentinkind_	snrecruitworkername5_	snrecruitworkername4_	snrecruitworkername3_	snrecruitworkername2_	snrecruitworkername1_	snrecommendassoname9_	snrecommendassoname8_	snrecommendassoname7_	snrecommendassoname6_	snrecommendassoname5_	snrecommendassoname4_	snrecommendassoname3_	snrecommendassoname2_	snrecommendassoname1_	snhelpemergencyname5_	snhelpemergencyname4_	snhelpemergencyname3_	snhelpemergencyname2_	snhelpemergencyname1_	sncloserelouthhname4_	sncloserelouthhname3_	sncloserelouthhname2_	sncloserelouthhname1_	reasonstoppedwagejob_	othermainoccupation2_	otherbeforemainoccup_	networkpeoplehelping_	networkhelpkinmember_	jobwagefrequencycash_	dummypreviouswagejob_	dummymainoccupation2_	covmostefficienthelp_	businesssourceinvest_	businessamountinvest_	reasondontsearchjob_	previousjobcontract_	opinionworkingwoman_	mostseriousincident_	dummycontactleaders_	countcovsnhelpgiven_	annualincomeindself_	useknowledgeatwork_	sntalkthemostname4_	sntalkthemostname3_	sntalkthemostname2_	sntalkthemostname1_	seriousinjuryother_	satisfactionsalary_	resdiscrimination5_	resdiscrimination4_	resdiscrimination3_	resdiscrimination2_	resdiscrimination1_	reasondontworkmore_	opinionactivewoman_	numberbusinessloan_	nbermonthsearchjob_	methodfindfirstjob_	kindofworkfirstjob_	expressingthoughts_	covsnhelpgivenlist_	covassociationhelp_	businesslossinvest_	businessfixedcosts_	amountgrossreceipt_	workpastsevendays_	snrecommendforjob_	snfindjobnamelist_	snbusinesslender6_	snbusinesslender5_	snbusinesslender4_	snbusinesslender3_	snbusinesslender2_	snbusinesslender1_	satisfyingpurpose_	physicalagression_	moveoutsideforjob_	mostseriousinjury_	jobwageamountcash_	helpfulwithothers_	decisionworkother_	covsnhelpreceived_	businessnbworkers_	businesslaborcost_	appointmentontime_	activeimagination_	wageamountmonth4_	wageamountmonth3_	wageamountmonth2_	wageamountmonth1_	verbalaggression_	talktomanypeople_	snrecojobsuccess_	snfindcurrentjob_	sexualharassment_	sexualaggression_	searchjobsince15_	nbercontactphone_	easilydistracted_	decisionearnwork_	businessexpenses_	agreementatwork4_	agreementatwork3_	agreementatwork2_	agreementatwork1_	accidentalinjury_	wageamountmonth_	trustingofother_	snrecruitworker_	snhelpemergency_	sncloserelouthh_	repetitivetasks_	nbofoccupations_	monthstofindjob_	interestedbyart_	indhoursamonth3_	finishwhatbegin_	discrimination9_	discrimination8_	discrimination7_	discrimination6_	discrimination5_	discrimination4_	discrimination3_	discrimination2_	discrimination1_	covdifficulties_	businessafter15_	beforemainoccup_	associationlist_	agestartworking_	toleratefaults_	stickwithgoals_	snfindjobname5_	snfindjobname4_	snfindjobname3_	snfindjobname2_	snfindjobname1_	snfindfirstjob_	retirementwork_	lossworknumber_	indhoursayear3_	indhoursayear2_	indhoursayear1_	inddaysamonth3_	executionwork9_	executionwork8_	executionwork7_	executionwork6_	executionwork5_	executionwork4_	executionwork3_	executionwork2_	executionwork1_	covsnhelpgiven_	contactleaders_	completeduties_	workwithother_	workexposure5_	workexposure4_	workexposure3_	workexposure2_	workexposure1_	startbusiness_	sntalkthemost_	shywithpeople_	sharefeelings_	rurallocation_	readystartjob_	problemwork10_	methodfindjob_	maxhoursayear_	mainoccuptype_	locuscontrol6_	locuscontrol5_	locuscontrol4_	locuscontrol3_	locuscontrol2_	locuscontrol1_	jobpreference_	indhoursayear_	indhoursaday3_	indhoursaday2_	inddaysayear2_	feeldepressed_	canreadcard1c_	canreadcard1b_	canreadcard1a_	putoffduties_	problemwork9_	problemwork8_	problemwork7_	problemwork6_	problemwork5_	problemwork4_	problemwork2_	problemwork1_	physicalharm_	managestress_	forgiveother_	enthusiastic_	decisionwork_	canreadcard2_	wagejobtype_	takeholiday_	rudetoother_	occupation8_	occupation7_	occupation6_	occupation5_	occupation4_	occupation3_	occupation2_	occupation1_	liketothink_	keepworking_	goaftergoal_	finishtasks_	enjoypeople_	easilyupset_	covinstit10_	contactlist_	covinstit9_	covinstit8_	covinstit7_	covinstit6_	covinstit5_	covinstit4_	covinstit3_	covinstit2_	covinstit1_	changework_	changemood_	worryalot_	talkative_	snfindjob_	searchjob_	organized_	numeracy6_	numeracy5_	numeracy4_	numeracy3_	numeracy2_	numeracy1_	makeplans_	lackskill_	inventive_	happywork_	workmate_	workhard_	staycalm_	schedule_	newideas_	losswork_	everwork_	contract_	tryhard_	respect_	nervous_	curious_	break_	covsickmemberlist_ migrantlist_ remrecipientlist_ remsenderlist_ borrowerlist_ hhlenderlist_ recommendgivenlist_ marriedlist_ schemeslist_ nregarecipientlist_ name username_ namefrompreload formermember_ a1_ a2_ a3_ a4_ a5_ a6_ a7_ a8_ a9_ a10_ a11_ a12_ b1_ b2_ b3_ b4_ b5_ b6_ b7_ b8_ b9_ b10_ b11_ b12_ ab1_ ab2_ ab3_ ab4_ ab5_ ab6_ ab7_ ab8_ ab9_ ab10_ ab11_ ab12_  lefthousehold_ chitfundbelongerid_ savingsownerid_ goldownerid_ insuranceownerid_ schemerecipientlist3_ schemerecipientlist4_ schemerecipientlist5_ schemerecipientlist6_ schemerecipientlist7_ schemerecipientlist8_ schemerecipientlist9_ schemerecipientlist10_ schemerecipientlist11_ selected_occupposition_ selected_occupname_ selected_months_ selected_months_monthsid_ INDID_left_ INDID_new_ INDID_former_, i(key) j(INDID)  // Reshape pour avoir les individus en ligne


********** INTERMEDIATE CLEANING
drop username_ 
rename key parent_key
foreach x in INDID_total INDID_left INDID_new INDID_former {
rename `x'_ `x'
}
order parent_key name namefrompreload INDID INDID_total INDID_former INDID_new INDID_left





********** INTERMEDIATE SAVING
save"$directory\APPEND\raw\\$preamble~_v2.dta", replace






********** CREATION OF UNIQUE SETOF WITH THE GOOD INDID
/*
Pour ne pas faire d'erreur, j'ai vérifier la contrainte depuis
le form de l'enquête.
Normalement c'est bon actuellement.
*/
*Toutes les var en stringtostring INDID, replace
tostring INDID_total, replace
tostring INDID_former, replace
tostring INDID_left, replace
tostring INDID_new, replace
*Renommer ceux ayant un nom un peu long
capture confirm v setof_2wagejobpaymentinkindgroup
if !_rc {
rename setof_2wagejobpaymentinkindgroup setof_2wagejobpaymentkd 
}
capture confirm v setofcashassistancemarriagegroup
if !_rc {
rename setofcashassistancemarriagegroup setofcashassistancemarriage
}
capture confirm v setofcovsntypehelpreceivedgroup
if !_rc {
rename setofcovsntypehelpreceivedgroup setofcovsntypehelpreceived
}
capture confirm v setof_2covsnhelpreceivedgroup
if !_rc {
rename setof_2covsnhelpreceivedgroup setof_2covsnhelpreceived
}
capture confirm v setof_2covsntypehelpgivengroup
if !_rc {
rename setof_2covsntypehelpgivengroup setof_2covsntypehelpgiven
}
capture confirm v setof_2covsntypehelpreceivedgrou
if !_rc {
rename setof_2covsntypehelpreceivedgrou setof_2covsntypehelpreceived
}
capture confirm v setof_3wagejobpaymentinkindgroup
if !_rc {
rename setof_3wagejobpaymentinkindgroup setof_3wagejobpaymentinkind 
}
capture confirm v setof_3covsntypehelpreceivedgrou
if !_rc {
rename setof_3covsntypehelpreceivedgrou setof_3covsntypehelpreceived
}
capture confirm v setof_3covsntypehelpgivengroup
if !_rc {
rename setof_3covsntypehelpgivengroup setof_3covsntypehelpgiven
}
capture confirm v setof_2businesspaymentinkindgrou
if !_rc {
rename setof_2businesspaymentinkindgrou setof_2businesspaymentinkind
}
capture confirm v setof_3businesspaymentinkindgrou
if !_rc {
rename setof_3businesspaymentinkindgrou setof_3businesspaymentinkind
}
capture confirm v setofbusinesspaymentinkindgroup
if !_rc {
rename setofbusinesspaymentinkindgroup setofbusinesspaymentinkind
}
*INDID_total = MEMBRES PRESENTS
foreach v of varlist setoffamilymembers setofeducation setofemployment {
tostring `v', replace
gen `v'_n = `v' + "[" + INDID_total + "]" if `v'!=""
rename `v' `v'_o
rename `v'_n `v'
replace `v'="" if substr(`v',strlen(`v')-2,3)=="[.]"
}
*INDID_new = NOUVEAUX MEMBRES
foreach v of varlist setofindividualid {
tostring `v', replace
gen `v'_n = `v' + "[" + INDID_new + "]" if `v'!=""
rename `v' `v'_o
rename `v'_n `v'
replace `v'="" if substr(`v',strlen(`v')-2,3)=="[.]"
}
/*
*INDID_left = MEMBRES ABSENTS
tostring setoflefthome, replace
gen setoflefthome_n = setoflefthome + "[" + INDID_left + "]" if setoflefthome!=""
rename setoflefthome setoflefthome_o
rename setoflefthome_n setoflefthome
replace setoflefthome="" if substr(setoflefthome,strlen(setoflefthome)-2,3)=="[.]"
*/
*INDID = TOUT LE MONDE
tostring INDID, replace
foreach v in setofremreceivedgroup setofremsentgroup setofmigrationgroup  setofloansbyborrower setoflendingmoney setofrecommendationgiven setofchitfund setofsavings setofgold setofinsurance setofmarriagegroup setofschemenregaind setofcashassistancemarriage setofgoldmarriagegroup setofschemepension1group setofschemepension2group setofschemepension3group setofschemepension4group setofschemepension5group setofschemepension6group setofschemepension7group   {
tostring `v', replace
gen `v'_n = `v' + "[" + INDID + "]" if `v'!=""
rename `v' `v'_o
rename `v'_n `v'
replace `v'="" if substr(`v',strlen(`v')-2,3)=="[.]"
}
*Redonner le nom d'avant
capture confirm v setofbusinesspaymentinkind
if !_rc {
rename setofbusinesspaymentinkind setofbusinesspaymentinkindgroup
}
capture confirm v setof_3businesspaymentinkind
if !_rc {
rename setof_3businesspaymentinkind setof_3businesspaymentinkindgrou
}
capture confirm v setof_2wagejobpaymentkd
if !_rc {
rename setof_2wagejobpaymentkd  setof_2wagejobpaymentinkindgroup
}
capture confirm v setof_2wagejobpaymentkd_o
if !_rc {
rename setof_2wagejobpaymentkd_o setof_2wagejobpaymentinkindgrp_o
}
capture confirm v setofcashassistancemarriage
if !_rc {
rename setofcashassistancemarriage setofcashassistancemarriagegroup
}
capture confirm v setofcovsntypehelpreceived
if !_rc {
rename setofcovsntypehelpreceived setofcovsntypehelpreceivedgroup
}
capture confirm v setof_2covsnhelpreceived
if !_rc {
rename setof_2covsnhelpreceived setof_2covsnhelpreceivedgroup
}
capture confirm v setof_2covsntypehelpgiven
if !_rc {
rename setof_2covsntypehelpgiven setof_2covsntypehelpgivengroup
}
capture confirm v setof_2covsntypehelpreceived
if !_rc {
rename setof_2covsntypehelpreceived setof_2covsntypehelpreceivedgrou
}
capture confirm v setof_3wagejobpaymentinkind
if !_rc {
rename setof_3wagejobpaymentinkind setof_3wagejobpaymentinkindgroup 
}
capture confirm v setof_3covsntypehelpreceived
if !_rc {
rename setof_3covsntypehelpreceived setof_3covsntypehelpreceivedgrou
}
capture confirm v setof_3covsntypehelpgiven
if !_rc {
rename setof_3covsntypehelpgiven setof_3covsntypehelpgivengroup
}
capture confirm v setof_2businesspaymentinkind
if !_rc {
rename setof_2businesspaymentinkind setof_2businesspaymentinkindgrou
}








********** REMOVE UNDERSCORE COMING FROM RESHAPE
foreach x in dummyego_ ego_ reasonnotworkpastyearfrom_	covmostefficienthelpfrom_	businessworkersfrequency_	otherbusinesssourceinvestment_	sumwagejobpaymentinkindvalue_	otherbeforemainoccupduration_	moveoutsideforjobreasonother_	covassociationhelptypeother_	covassociationhelplistother_	reasondontsearchjobsince15_	dummybusinessunpaidworkers_	covneworktrustneighborhood_	workedpastyearfromearlier_	snrecommendforjobnamelist_	mainoccupationfromearlier_	jobfirstwagefrequencycash_	covmostefficienthelpother_	businesspaymentinkindlist_	attendedschoolfromearlier_	wagejobpaymentinkindlist_	unpaidinbusinessfirstjob_	snrecojobsuccessnamelist_	snfindcurrentjobnamelist_	networktrustneighborhood_	dummybusinesspaidworkers_	dummyaspirationmorehours_	covmostefficienthelpopen_	businesslossinvestamount_	businessfixedcostsamount_	snrecruitworkernamelist_	othermethodfindfirstjob_	moveoutsideforjobreason_	covnetworkpeoplehelping_	covnetworkhelpkinmember_	businessnbunpaidworkers_	businessnbfamilyworkers_	understandotherfeeling_	snrecommendforjobname5_	snrecommendforjobname4_	snrecommendforjobname3_	snrecommendforjobname2_	snrecommendforjobname1_	jobfirstwageamountcash_	dummyseasonalmainoccup_	covsnhelpreceivedname5_	covsnhelpreceivedname4_	covsnhelpreceivedname3_	covsnhelpreceivedname2_	covsnhelpreceivedname1_	covassociationhelptype_	covassociationhelplist_	countcovsnhelpreceived_	businesssocialsecurity_	aspirationminimumwage2_	agestartworkingpaidjob_	wagejobsocialsecurity_	snrecommendassoname24_	snrecommendassoname23_	snrecommendassoname22_	snrecommendassoname21_	snrecommendassoname20_	snrecommendassoname19_	snrecommendassoname18_	snrecommendassoname17_	snrecommendassoname16_	snrecommendassoname15_	snrecommendassoname14_	snrecommendassoname13_	snrecommendassoname12_	snrecommendassoname11_	snrecommendassoname10_	snrecojobsuccessname5_	snrecojobsuccessname4_	snrecojobsuccessname3_	snrecojobsuccessname2_	snrecojobsuccessname1_	snfindcurrentjobname5_	snfindcurrentjobname4_	snfindcurrentjobname3_	snfindcurrentjobname2_	snfindcurrentjobname1_	professionalequipment_	otherreasonstoppedjob_	networktrustemployees_	nberpersonfamilyevent_	frequencygrossreceipt_	decisionearnworkother_	covsnhelpreceivedlist_	covcontactinstitution_	businesspaymentinkind_	businessnbpaidworkers_	aspirationminimumwage_	wagejobpaymentinkind_	snrecruitworkername5_	snrecruitworkername4_	snrecruitworkername3_	snrecruitworkername2_	snrecruitworkername1_	snrecommendassoname9_	snrecommendassoname8_	snrecommendassoname7_	snrecommendassoname6_	snrecommendassoname5_	snrecommendassoname4_	snrecommendassoname3_	snrecommendassoname2_	snrecommendassoname1_	snhelpemergencyname5_	snhelpemergencyname4_	snhelpemergencyname3_	snhelpemergencyname2_	snhelpemergencyname1_	sncloserelouthhname4_	sncloserelouthhname3_	sncloserelouthhname2_	sncloserelouthhname1_	reasonstoppedwagejob_	othermainoccupation2_	otherbeforemainoccup_	networkpeoplehelping_	networkhelpkinmember_	jobwagefrequencycash_	dummypreviouswagejob_	dummymainoccupation2_	covmostefficienthelp_	businesssourceinvest_	businessamountinvest_	reasondontsearchjob_	previousjobcontract_	opinionworkingwoman_	mostseriousincident_	dummycontactleaders_	countcovsnhelpgiven_	annualincomeindself_	useknowledgeatwork_	sntalkthemostname4_	sntalkthemostname3_	sntalkthemostname2_	sntalkthemostname1_	seriousinjuryother_	satisfactionsalary_	resdiscrimination5_	resdiscrimination4_	resdiscrimination3_	resdiscrimination2_	resdiscrimination1_	reasondontworkmore_	opinionactivewoman_	numberbusinessloan_	nbermonthsearchjob_	methodfindfirstjob_	kindofworkfirstjob_	expressingthoughts_	covsnhelpgivenlist_	covassociationhelp_	businesslossinvest_	businessfixedcosts_	amountgrossreceipt_	workpastsevendays_	snrecommendforjob_	snfindjobnamelist_	snbusinesslender6_	snbusinesslender5_	snbusinesslender4_	snbusinesslender3_	snbusinesslender2_	snbusinesslender1_	satisfyingpurpose_	physicalagression_	moveoutsideforjob_	mostseriousinjury_	jobwageamountcash_	helpfulwithothers_	decisionworkother_	covsnhelpreceived_	businessnbworkers_	businesslaborcost_	appointmentontime_	activeimagination_	wageamountmonth4_	wageamountmonth3_	wageamountmonth2_	wageamountmonth1_	verbalaggression_	talktomanypeople_	snrecojobsuccess_	snfindcurrentjob_	sexualharassment_	sexualaggression_	searchjobsince15_	nbercontactphone_	easilydistracted_	decisionearnwork_	businessexpenses_	agreementatwork4_	agreementatwork3_	agreementatwork2_	agreementatwork1_	accidentalinjury_	wageamountmonth_	trustingofother_	snrecruitworker_	snhelpemergency_	sncloserelouthh_	repetitivetasks_	nbofoccupations_	monthstofindjob_	interestedbyart_	indhoursamonth3_	finishwhatbegin_	discrimination9_	discrimination8_	discrimination7_	discrimination6_	discrimination5_	discrimination4_	discrimination3_	discrimination2_	discrimination1_	covdifficulties_	businessafter15_	beforemainoccup_	associationlist_	agestartworking_	toleratefaults_	stickwithgoals_	snfindjobname5_	snfindjobname4_	snfindjobname3_	snfindjobname2_	snfindjobname1_	snfindfirstjob_	retirementwork_	lossworknumber_	indhoursayear3_	indhoursayear2_	indhoursayear1_	inddaysamonth3_	executionwork9_	executionwork8_	executionwork7_	executionwork6_	executionwork5_	executionwork4_	executionwork3_	executionwork2_	executionwork1_	covsnhelpgiven_	contactleaders_	completeduties_	workwithother_	workexposure5_	workexposure4_	workexposure3_	workexposure2_	workexposure1_	startbusiness_	sntalkthemost_	shywithpeople_	sharefeelings_	rurallocation_	readystartjob_	problemwork10_	methodfindjob_	maxhoursayear_	mainoccuptype_	locuscontrol6_	locuscontrol5_	locuscontrol4_	locuscontrol3_	locuscontrol2_	locuscontrol1_	jobpreference_	indhoursayear_	indhoursaday3_	indhoursaday2_	inddaysayear2_	feeldepressed_	canreadcard1c_	canreadcard1b_	canreadcard1a_	putoffduties_	problemwork9_	problemwork8_	problemwork7_	problemwork6_	problemwork5_	problemwork4_	problemwork2_	problemwork1_	physicalharm_	managestress_	forgiveother_	enthusiastic_	decisionwork_	canreadcard2_	wagejobtype_	takeholiday_	rudetoother_	occupation8_	occupation7_	occupation6_	occupation5_	occupation4_	occupation3_	occupation2_	occupation1_	liketothink_	keepworking_	goaftergoal_	finishtasks_	enjoypeople_	easilyupset_	covinstit10_	contactlist_	covinstit9_	covinstit8_	covinstit7_	covinstit6_	covinstit5_	covinstit4_	covinstit3_	covinstit2_	covinstit1_	changework_	changemood_	worryalot_	talkative_	snfindjob_	searchjob_	organized_	numeracy6_	numeracy5_	numeracy4_	numeracy3_	numeracy2_	numeracy1_	makeplans_	lackskill_	inventive_	happywork_	workmate_	workhard_	staycalm_	schedule_	newideas_	losswork_	everwork_	contract_	tryhard_	respect_	nervous_	curious_	break_	a1_ a2_ a3_ a4_ a5_ a6_ a7_ a8_ a9_ a10_ a11_ a12_ b1_ b2_ b3_ b4_ b5_ b6_ b7_ b8_ b9_ b10_ b11_ b12_ ab1_ ab2_ ab3_ ab4_ ab5_ ab6_ ab7_ ab8_ ab9_ ab10_ ab11_ ab12_ {
local new=substr("`x'",1,length("`x'")-1) 
rename `x' `new'
}






********** RENAME COG QUESTIONS FOR LABEL (in APPEND do file)
rename a1 A1
rename a2 A2
rename a3 A3
rename a4 A4
rename a5 A5
rename a6 A6
rename a7 A7
rename a8 A8
rename a9 A9
rename a10 A10
rename a11 A11
rename a12 A12
rename b1 B1
rename b2 B2
rename b3 B3
rename b4 B4
rename b5 B5
rename b6 B6
rename b7 B7
rename b8 B8
rename b9 B9
rename b10 B10
rename b11 B11
rename b12 B12
rename ab1 Ab1
rename ab2 Ab2
rename ab3 Ab3
rename ab4 Ab4
rename ab5 Ab5
rename ab6 Ab6
rename ab7 Ab7
rename ab8 Ab8
rename ab9 Ab9
rename ab10 Ab10
rename ab11 Ab11
rename ab12 Ab12









********* DATABASE VERSION
gen version="$preamble"
destring INDID, replace
sort parent_key INDID
drop if INDID_total=="." & INDID_left=="."



********** INTERMEDIATE SAVING
save"$directory\APPEND\raw\\$preamble~_v3.dta", replace







*********MERGING
*LEFT HOME
capture confirm file "$directory\APPEND\raw\\$preamble-generalinformation-lefthome.dta" 
if _rc==0 {
merge m:1 setoflefthome using "$directory\APPEND\raw\\$preamble-generalinformation-lefthome.dta" 
drop if _merge==2
drop _merge
}

*INDIVIDUALID
rename name name_mb
capture confirm file "$directory\APPEND\raw\\$preamble-individualid.dta" 
if _rc==0 {
merge m:1 setofindividualid using "$directory\APPEND\raw\\$preamble-individualid.dta"
drop _merge
}

*FAMILY MEMBERS
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-familymembers.dta" 
if _rc==0 {
merge m:1 setoffamilymembers using "$directory\APPEND\raw\\$preamble-hhquestionnaire-familymembers.dta"
drop _merge
}

*EDUCATION
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-education.dta" 
if _rc==0{
merge m:1 setofeducation using "$directory\APPEND\raw\\$preamble-hhquestionnaire-education.dta"
drop if _merge==2
drop _merge
}

*EMPLOYMENT
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-employment.dta" 
if _rc==0{
merge m:1 setofemployment using "$directory\APPEND\raw\\$preamble-hhquestionnaire-employment.dta"
drop if _merge==2
drop _merge
}

*MIGRATION
rename setofmigrationgroup setofmigrationidgroup
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-migration-migrationidgroup.dta" 
if _rc==0{
merge m:1 setofmigrationidgroup using "$directory\APPEND\raw\\$preamble-hhquestionnaire-migration-migrationidgroup.dta"
drop if _merge==2
drop _merge
}

*REMITTANCES RECEIVED
rename setofremreceivedgroup setofremreceivedidgroup
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-remittances-remreceived-remreceivedidgroup.dta"
if _rc==0{
merge m:1 setofremreceivedidgroup using "$directory\APPEND\raw\\$preamble-hhquestionnaire-remittances-remreceived-remreceivedidgroup.dta"
drop if _merge==2
drop _merge
}

*REMITTANCES SENT
rename setofremsentgroup setofremsentidgroup
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-remittances-remsent-remsentidgroup.dta"
if _rc==0{
merge m:1 setofremsentidgroup using "$directory\APPEND\raw\\$preamble-hhquestionnaire-remittances-remsent-remsentidgroup.dta"
drop if _merge==2
drop _merge
}

*LOANS
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-loans-loansbyborrower.dta" 
if _rc==0{
merge m:1 setofloansbyborrower using "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-loans-loansbyborrower.dta" 
drop if _merge==2
drop _merge
}

*LENDING MONEY
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-lendingmoneygroup-lendingmoney.dta"
if _rc==0{
merge m:1 setoflendingmoney using "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-lendingmoneygroup-lendingmoney.dta"
drop if _merge==2
drop _merge
}


*RECOMM
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-guaranteeandrecommendation-recommendationgiven.dta"
if _rc==0{
merge m:1 setofrecommendationgiven using "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-guaranteeandrecommendation-recommendationgiven.dta"
drop if _merge==2
drop _merge
}


*CHITFUND
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-chitfundgroup-chitfund.dta"
if _rc==0{
merge m:1 setofchitfund using "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-chitfundgroup-chitfund.dta"
drop if _merge==2
drop _merge
}

*SAVING
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-savingsgroup-savings.dta"
if _rc==0{
merge m:1 setofsavings using "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-savingsgroup-savings.dta"
drop if _merge==2
drop _merge
}

*GOLD
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-goldgroup-gold.dta"
if _rc==0{
merge m:1 setofgold using "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-goldgroup-gold.dta"
drop if _merge==2
drop _merge
}

*INSURANCE
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-insurancegroup-insurance.dta"
if _rc==0{
merge m:1 setofinsurance using "$directory\APPEND\raw\\$preamble-hhquestionnaire-financialpracticesgroup-insurancegroup-insurance.dta"
drop if _merge==2
drop _merge
}

*SCHEME NREGA
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-schemes-schemenrega-schemenregaind.dta"
if _rc==0{
merge m:1 setofschemenregaind using "$directory\APPEND\raw\\$preamble-hhquestionnaire-schemes-schemenrega-schemenregaind.dta"
drop if _merge==2
drop _merge
}

*CASH ASSISTANCE
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-schemes-cashassistancemarriage-cashassistancemarriagegroup.dta"
if _rc==0{
merge m:1 setofcashassistancemarriagegroup using "$directory\APPEND\raw\\$preamble-hhquestionnaire-schemes-cashassistancemarriage-cashassistancemarriagegroup.dta"
drop if _merge==2
drop _merge
}

*GOLD MARRIAGE
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-schemes-goldmarriage-goldmarriagegroup.dta"
if _rc==0{
merge m:1 setofgoldmarriagegroup using "$directory\APPEND\raw\\$preamble-hhquestionnaire-schemes-goldmarriage-goldmarriagegroup.dta"
drop if _merge==2
drop _merge
}

*SCHEME PENSION 1 2 3 4 5 6 7
forvalues i=1(1)7{
capture confirm file "$directory\APPEND\raw\\$preamble-hhquestionnaire-schemes-schemepension`i'-schemepension`i'group.dta"
if _rc==0{
merge m:1 setofschemepension`i'group using "$directory\APPEND\raw\\$preamble-hhquestionnaire-schemes-schemepension`i'-schemepension`i'group.dta"
drop if _merge==2
drop _merge
}
}





********** INTERMEDIATE SAVING
save"$directory\APPEND\raw\\$preamble~_v4.dta", replace
