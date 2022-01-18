cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
03/03/21
-----
TITLE: PANEL pour dette cog

description: 	Réunir tous les prêts dans la même base
-------------------------
*/



****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "C:\Users\Arnaud\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND\CLEAN"
global git = "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

cd"$directory"

*global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*global git ="C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"

********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

****************************************
* END










****************************************
* MERGING
****************************************
*1. Nettoyage de la base prêts
use "NEEMSIS_APPEND-detailsloanbyborrower.dta", clear
egen setofloansbyborrower=concat(parent_key key2), p(/)
save"NEEMSIS2-loans.dta", replace


*2. Merge: borrower with loan to have indiv details with loan
use "NEEMSIS2-HH_v16.dta", clear
keep if nbloansbyborrower!=.
keep parent_key HHID_panel INDID_panel INDID2020 INDID_total INDID_former INDID_new INDID_left setofloansbyborrower setofdetailsloanbyborrower borrowerid borrowername nbloansbyborrower detailsloanbyborrower_count householdid2020 submissiondate version_HH householdid2020 caste jatis

sort parent_key borrowerid
merge 1:m setofloansbyborrower using "NEEMSIS2-loans.dta"
sort _merge
drop _merge
fre loansettled  // 428
*drop if loansettled==1
tab loanbalance, m  // ok 428
save "NEEMSIS2-loans_v2.dta", replace


*3. Merge: second with main loans 
use "NEEMSIS2-loans_v2.dta", clear
fre loanlender
destring borrowerid, replace  
destring loanid, replace
gen mainloanid=.
replace	mainloanid =	1	if 	borrowerid ==	1	&	loanid ==	1
replace	mainloanid =	2	if 	borrowerid ==	1	&	loanid ==	2
replace	mainloanid =	3	if 	borrowerid ==	1	&	loanid ==	3
replace	mainloanid =	4	if 	borrowerid ==	1	&	loanid ==	4
replace	mainloanid =	5	if 	borrowerid ==	1	&	loanid ==	5
replace	mainloanid =	6	if 	borrowerid ==	1	&	loanid ==	6
replace	mainloanid =	7	if 	borrowerid ==	1	&	loanid ==	7
replace	mainloanid =	8	if 	borrowerid ==	1	&	loanid ==	8
replace	mainloanid =	9	if 	borrowerid ==	2	&	loanid ==	1
replace	mainloanid =	10	if 	borrowerid ==	2	&	loanid ==	2
replace	mainloanid =	11	if 	borrowerid ==	2	&	loanid ==	3
replace	mainloanid =	12	if 	borrowerid ==	2	&	loanid ==	4
replace	mainloanid =	13	if 	borrowerid ==	2	&	loanid ==	5
replace	mainloanid =	14	if 	borrowerid ==	2	&	loanid ==	6
replace	mainloanid =	15	if 	borrowerid ==	2	&	loanid ==	7
replace	mainloanid =	16	if 	borrowerid ==	2	&	loanid ==	8
replace	mainloanid =	17	if 	borrowerid ==	3	&	loanid ==	1
replace	mainloanid =	18	if 	borrowerid ==	3	&	loanid ==	2
replace	mainloanid =	19	if 	borrowerid ==	3	&	loanid ==	3
replace	mainloanid =	20	if 	borrowerid ==	3	&	loanid ==	4
replace	mainloanid =	21	if 	borrowerid ==	3	&	loanid ==	5
replace	mainloanid =	22	if 	borrowerid ==	3	&	loanid ==	6
replace	mainloanid =	23	if 	borrowerid ==	3	&	loanid ==	7
replace	mainloanid =	24	if 	borrowerid ==	3	&	loanid ==	8
replace	mainloanid =	25	if 	borrowerid ==	4	&	loanid ==	1
replace	mainloanid =	26	if 	borrowerid ==	4	&	loanid ==	2
replace	mainloanid =	27	if 	borrowerid ==	4	&	loanid ==	3
replace	mainloanid =	28	if 	borrowerid ==	4	&	loanid ==	4
replace	mainloanid =	29	if 	borrowerid ==	4	&	loanid ==	5
replace	mainloanid =	30	if 	borrowerid ==	4	&	loanid ==	6
replace	mainloanid =	31	if 	borrowerid ==	4	&	loanid ==	7
replace	mainloanid =	32	if 	borrowerid ==	4	&	loanid ==	8
replace	mainloanid =	33	if 	borrowerid ==	5	&	loanid ==	1
replace	mainloanid =	34	if 	borrowerid ==	5	&	loanid ==	2
replace	mainloanid =	35	if 	borrowerid ==	5	&	loanid ==	3
replace	mainloanid =	36	if 	borrowerid ==	5	&	loanid ==	4
replace	mainloanid =	37	if 	borrowerid ==	5	&	loanid ==	5
replace	mainloanid =	38	if 	borrowerid ==	5	&	loanid ==	6
replace	mainloanid =	39	if 	borrowerid ==	5	&	loanid ==	7
replace	mainloanid =	40	if 	borrowerid ==	5	&	loanid ==	8
replace	mainloanid =	41	if 	borrowerid ==	6	&	loanid ==	1
replace	mainloanid =	42	if 	borrowerid ==	6	&	loanid ==	2
replace	mainloanid =	43	if 	borrowerid ==	6	&	loanid ==	3
replace	mainloanid =	44	if 	borrowerid ==	6	&	loanid ==	4
replace	mainloanid =	45	if 	borrowerid ==	6	&	loanid ==	5
replace	mainloanid =	46	if 	borrowerid ==	6	&	loanid ==	6
replace	mainloanid =	47	if 	borrowerid ==	6	&	loanid ==	7
replace	mainloanid =	48	if 	borrowerid ==	6	&	loanid ==	8
replace	mainloanid =	49	if 	borrowerid ==	7	&	loanid ==	1
replace	mainloanid =	50	if 	borrowerid ==	7	&	loanid ==	2
replace	mainloanid =	51	if 	borrowerid ==	7	&	loanid ==	3
replace	mainloanid =	52	if 	borrowerid ==	7	&	loanid ==	4
replace	mainloanid =	53	if 	borrowerid ==	7	&	loanid ==	5
replace	mainloanid =	54	if 	borrowerid ==	7	&	loanid ==	6
replace	mainloanid =	55	if 	borrowerid ==	7	&	loanid ==	7
replace	mainloanid =	56	if 	borrowerid ==	7	&	loanid ==	8
replace	mainloanid =	57	if 	borrowerid ==	15	&	loanid ==	1
replace	mainloanid =	58	if 	borrowerid ==	15	&	loanid ==	2
replace	mainloanid =	59	if 	borrowerid ==	15	&	loanid ==	3
replace	mainloanid =	60	if 	borrowerid ==	15	&	loanid ==	4
replace	mainloanid =	61	if 	borrowerid ==	15	&	loanid ==	5
replace	mainloanid =	62	if 	borrowerid ==	15	&	loanid ==	6
replace	mainloanid =	63	if 	borrowerid ==	15	&	loanid ==	7
replace	mainloanid =	64	if 	borrowerid ==	15	&	loanid ==	8
replace	mainloanid =	65	if 	borrowerid ==	16	&	loanid ==	1
replace	mainloanid =	66	if 	borrowerid ==	16	&	loanid ==	2
replace	mainloanid =	67	if 	borrowerid ==	16	&	loanid ==	3
replace	mainloanid =	68	if 	borrowerid ==	16	&	loanid ==	4
replace	mainloanid =	69	if 	borrowerid ==	16	&	loanid ==	5
replace	mainloanid =	70	if 	borrowerid ==	16	&	loanid ==	6
replace	mainloanid =	71	if 	borrowerid ==	16	&	loanid ==	7
replace	mainloanid =	72	if 	borrowerid ==	16	&	loanid ==	8
replace	mainloanid =	73	if 	borrowerid ==	17	&	loanid ==	1
replace	mainloanid =	74	if 	borrowerid ==	17	&	loanid ==	2
replace	mainloanid =	75	if 	borrowerid ==	17	&	loanid ==	3
replace	mainloanid =	76	if 	borrowerid ==	17	&	loanid ==	4
replace	mainloanid =	77	if 	borrowerid ==	17	&	loanid ==	5
replace	mainloanid =	78	if 	borrowerid ==	17	&	loanid ==	6
replace	mainloanid =	79	if 	borrowerid ==	17	&	loanid ==	7
replace	mainloanid =	80	if 	borrowerid ==	17	&	loanid ==	8
tostring mainloanid, replace
tab loanbalance, m
merge m:m parent_key mainloanid using "NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-loans-mainloans.dta"
drop if _merge==2
rename _merge merge_mainloans
*rename borrowerid INDID
fre loansettled  // 428
tab loanbalance, m  // 428 ok
gen loan_database="FINANCE"

tab loanreasongiven
tab loanreasongiven2 if loanreasongiven==.
fre loanreasongiven2
tab loanotherreasongiven if loanreasongiven==. & loanreasongivenlabel=="Other"

replace loanreasongiven=6 if loanotherreasongiven=="Auto perches"
replace loanreasongiven=2 if loanotherreasongiven=="Baby shower"
replace loanreasongiven=6 if loanotherreasongiven=="Bike perches"
replace loanreasongiven=2 if loanotherreasongiven=="Bike purchase"
replace loanreasongiven=2 if loanotherreasongiven=="Buying Auto"
replace loanreasongiven=2 if loanotherreasongiven=="Buying auto"
replace loanreasongiven=2 if loanotherreasongiven=="Buying bike"
replace loanreasongiven=2 if loanotherreasongiven=="Buying motor"
replace loanreasongiven=2 if loanotherreasongiven=="Buying phone"
replace loanreasongiven=1 if loanotherreasongiven=="Buying tractor"
replace loanreasongiven=5 if loanotherreasongiven=="Buying tv"
replace loanreasongiven=5 if loanotherreasongiven=="Buying washing machine"
replace loanreasongiven=2 if loanotherreasongiven=="Car purchase"
replace loanreasongiven=2 if loanotherreasongiven=="Cell phone due"
replace loanreasongiven=1 if loanotherreasongiven=="Cow purchase"
replace loanreasongiven=1 if loanotherreasongiven=="Crop loan"
replace loanreasongiven=6 if loanotherreasongiven=="Davalap shop"
replace loanreasongiven=6 if loanotherreasongiven=="Develap shop"
replace loanreasongiven=6 if loanotherreasongiven=="Develop shop"
replace loanreasongiven=6 if loanotherreasongiven=="Developed by a shop"
replace loanreasongiven=6 if loanotherreasongiven=="Developed shop"
replace loanreasongiven=8 if loanotherreasongiven=="Engagement"
replace loanreasongiven=5 if loanotherreasongiven=="Exchange of TATA a/c"
replace loanreasongiven=6 if loanotherreasongiven=="Groceries in shop"
replace loanreasongiven=6 if loanotherreasongiven=="Grocery for Rs.1000"
replace loanreasongiven=6 if loanotherreasongiven=="Grocery from uvarani shop for Rs.1000"
replace loanreasongiven=6 if loanotherreasongiven=="Hotel development"
replace loanreasongiven=5 if loanotherreasongiven=="House  construction work"
replace loanreasongiven=5 if loanotherreasongiven=="House built"
replace loanreasongiven=5 if loanotherreasongiven=="House construction"
replace loanreasongiven=5 if loanotherreasongiven=="Housing loan"
replace loanreasongiven=6 if loanotherreasongiven=="Invest in a work"
replace loanreasongiven=6 if loanotherreasongiven=="Land perches"
replace loanreasongiven=2 if loanotherreasongiven=="Milk expenses"
replace loanreasongiven=2 if loanotherreasongiven=="Mobile deu"
replace loanreasongiven=2 if loanotherreasongiven=="Mobile loan"
replace loanreasongiven=5 if loanotherreasongiven=="Purchase TATA ac"
replace loanreasongiven=7 if loanotherreasongiven=="Recover jewelry"
replace loanreasongiven=7 if loanotherreasongiven=="Renewal gold"
replace loanreasongiven=6 if loanotherreasongiven=="School van perches"
replace loanreasongiven=6 if loanotherreasongiven=="Scooter perches"
replace loanreasongiven=6 if loanotherreasongiven=="Shop development"
replace loanreasongiven=5 if loanotherreasongiven=="TATA a/c purchase"
replace loanreasongiven=5 if loanotherreasongiven=="Tata AC purchase"
replace loanreasongiven=6 if loanotherreasongiven=="To buy a Grocery"
replace loanreasongiven=1 if loanotherreasongiven=="To buy a cow"
replace loanreasongiven=7 if loanotherreasongiven=="To buy a new jewel"
replace loanreasongiven=2 if loanotherreasongiven=="To buy auto"
replace loanreasongiven=1 if loanotherreasongiven=="To buy land"
replace loanreasongiven=6 if loanotherreasongiven=="To buy load carrier"
replace loanreasongiven=6 if loanotherreasongiven=="To buy new lorry"
replace loanreasongiven=2 if loanotherreasongiven=="To buy two wheeler"
replace loanreasongiven=1 if loanotherreasongiven=="Tractor purchase"
replace loanreasongiven=2 if loanotherreasongiven=="Two wheeler loan"
replace loanreasongiven=6 if loanotherreasongiven=="Van perches"
tab loanreasongiven, m
sort loanreasongiven
tab loanlender

order INDID_panel , first

global financeloans loanamount loandate loanreasongiven loanreasongiven2 loaneffectivereason loaneffectivereason2 loanotherreasongiven loanothereffectivereason loanlender snmoneylenderdummyfam snmoneylenderfriend snmoneylenderwkp snmoneylenderlabourrelation snmoneylendersex snmoneylenderage snmoneylenderlabourtype snmoneylendercastes snmoneylendercastesother snmoneylendereduc snmoneylenderoccup snmoneylender2 snmoneylenderemployertype snmoneylenderoccupother snmoneylender3 snmoneylenderliving snmoneylenderruralurban snmoneylendermapdistrict snmoneylenderdistrict snmoneylenderlivingname snmoneylendercompared snmoneylenderduration snmoneylendermeet snmoneylendermeetfrequency snmoneylenderinvite snmoneylenderreciprocity1 snmoneylenderintimacy snmoneylenderphonenb snmoneylenderphoto snmoneylendermeetother otherlenderservices guarantee allloans3 guaranteeother otherlenderservicesother guaranteetype loansettled dummyinterest interestpaid covfrequencyinterest covamountinterest alloans4 loanbalance totalrepaid covfrequencyrepayment covrepaymentstop mainloanid mainloanname lenderfirsttime additionalloan borrowerservices borrowerservicesother plantorepay plantorepayother termsofrepayment repayduration1 repayduration2 dummyinteret interestfrequency interestloan dummyproblemtorepay problemdelayrepayment problemdelayrepaymentother settleloanstrategy settleloanstrategyother loanproductpledge loanproductpledgeother loanproductpledgeaamount dummyhelptosettleloan helptosettleloan dummyrecommendation dummyguarantor recommenddetailscaste recommendloanrelation guarantordetailscaste guarantorloanrelation dummyincomeassets incomeassets

foreach x in $financeloans{
capture confirm v `x'
if _rc==0{
}
else{
gen `x'=""
}
}

*All loans
order borrowername nbloansbyborrower loanid loanamount loandate loanreasongiven loanreasongiven2 loaneffectivereason loaneffectivereason2 loanotherreasongiven loanothereffectivereason loanlender lendername snmoneylenderdummyfam snmoneylenderfriend snmoneylenderwkp snmoneylenderlabourrelation snmoneylendersex snmoneylenderage snmoneylenderlabourtype snmoneylendercastes snmoneylendercastesother snmoneylendereduc snmoneylenderoccup snmoneylender2 snmoneylenderemployertype snmoneylenderoccupother snmoneylender3 snmoneylenderliving snmoneylenderruralurban snmoneylendermapdistrict snmoneylenderdistrict snmoneylenderlivingname snmoneylendercompared snmoneylenderduration snmoneylendermeet snmoneylendermeetfrequency snmoneylenderinvite snmoneylenderreciprocity1 snmoneylenderintimacy snmoneylenderphonenb snmoneylenderphoto snmoneylendermeetother otherlenderservices guarantee allloans3 guaranteeother otherlenderservicesother guaranteetype loansettled dummyinterest interestpaid covfrequencyinterest covamountinterest alloans4 loanbalance totalrepaid covfrequencyrepayment covrepaymentstop, after(INDID_panel)



*Mains loans
order mainloanid mainloanname lenderfirsttime additionalloan borrowerservices borrowerservicesother plantorepay plantorepayother termsofrepayment repayduration1 repayduration2 dummyinteret interestfrequency interestloan dummyproblemtorepay problemdelayrepayment problemdelayrepaymentother settleloanstrategy settleloanstrategyother loanproductpledge loanproductpledgeother loanproductpledgeaamount dummyhelptosettleloan helptosettleloan dummyrecommendation dummyguarantor recommenddetailscaste recommendloanrelation guarantordetailscaste guarantorloanrelation dummyincomeassets incomeassets, after(covrepaymentstop)

dropmiss $financeloans, force
drop otherlenderservices_2 otherlenderservices_4 otherlenderservices_5 otherlenderservices_1 otherlenderservices_3 guarantee_1 guarantee_4 guarantee_6 guarantee_5 guarantee_77 guarantee_2 guarantee_3 otherlenderservices_77 borrowerservices_3 borrowerservices_4 borrowerservices_1 plantorepay_77 plantorepay_5 plantorepay_2 plantorepay_6 plantorepay_4 plantorepay_3 plantorepay_1 problemdelayrepayment_1 problemdelayrepayment_2 problemdelayrepayment_3 problemdelayrepayment_4 problemdelayrepayment_5 problemdelayrepayment_77 settleloanstrategy_1 settleloanstrategy_8 settleloanstrategy_7 settleloanstrategy_4 settleloanstrategy_6 settleloanstrategy_3 settleloanstrategy_9 settleloanstrategy_77 settleloanstrategy_10 settleloanstrategy_5 loanproductpledge_16 loanproductpledge_1 loanproductpledge_15 loanproductpledge_8 loanproductpledge_6 helptosettleloan_7 helptosettleloan_1 helptosettleloan_2 helptosettleloan_12 helptosettleloan_3 recommendloanrelation_2 recommendloanrelation_5 recommendloanrelation_10 recommendloanrelation_1 guarantorloanrelation_2 guarantorloanrelation_5 guarantorloanrelation_8 guarantorloanrelation_1 borrowerservices_2 settleloanstrategy_2 helptosettleloan_14 helptosettleloan_13 helptosettleloan_6 helptosettleloan_8 helptosettleloan_4 recommendloanrelation_8 recommendloanrelation_99 guarantorloanrelation_99 recommendloanrelation_6

*destring
foreach x in snmoneylenderdummyfam snmoneylenderfriend snmoneylenderwkp snmoneylenderlabourrelation snmoneylendersex snmoneylenderage snmoneylenderlabourtype snmoneylendercastes snmoneylendereduc snmoneylenderemployertype snmoneylenderoccupother snmoneylenderliving snmoneylenderruralurban snmoneylenderdistrict snmoneylendermeet snmoneylendermeetfrequency snmoneylenderinvite snmoneylenderreciprocity1 snmoneylenderintimacy snmoneylenderphonenb covrepaymentstop mainloanid {
destring `x', replace
}

* Duplicates
drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"
drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f" 
drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
*
drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"
drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66" 
drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"

save "NEEMSIS2-loans_v3.dta", replace
****************************************
* END









****************************************
* MARRIAGE
****************************************
*5. Finance marriage
use"NEEMSIS_APPEND-marriagefinance.dta", clear
gen loan_database="MARRIAGE"
keep if marriageloanid!=""
drop  parent_key
split setofmarriagefinance, p(/)
drop setofmarriagefinance2 setofmarriagefinance3
rename setofmarriagefinance1 parent_key

* Duplicates
drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"
drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f" 
drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
*
drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"
drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66" 
drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"

* Merge
replace setofmarriagefinance=substr(setofmarriagefinance,1,strlen(setofmarriagefinance)-3)

merge m:m setofmarriagefinance using "NEEMSIS2-HH_v16.dta", keepusing(HHID_panel INDID_panel submissiondate version_HH householdid2020 caste jatis)
drop if _merge==2
drop _merge

rename marrigeloandate marriageloandate
foreach x in marriageloanid marriageloanamount marriageloanlender marriageloanlistsn marriageloanlendername marriageloanlendersex marriageloanlenderoccup marriageloancaste marriagelenderfrom marriageloansettled marriageloanbalance marriageloandate{
local newname=substr("`x'",9,.)
rename `x' `newname'
}
gen loanreasongiven=8
gen loaneffectivereason=8
rename loanlendername lendername
rename loanlistsn snmoneylender
rename loanlendersex snmoneylendersex
rename loanlenderoccup snmoneylenderoccup 
rename loancaste snmoneylendercastes
rename lenderfrom snmoneylenderliving

order loanid loanamount loandate loanreasongiven loaneffectivereason loanlender lendername snmoneylender snmoneylendersex snmoneylenderoccup snmoneylendercastes snmoneylenderliving loansettled loanbalance

fre loansettled  // 12
*drop if loansettled==1
tab loanbalance,m  // 12 ok
rename parent_key setofmarriagegroup
split key, p(/)
rename key1 parent_key
drop key2 key3

destring loanid, replace

append using "NEEMSIS2-loans_v3.dta"
tab loanbalance, m  // 12 + 428 = 440 ok
tab loanlender

tab loanlender, m

save"NEEMSIS2-loans_v4.dta", replace
*erase "NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v3.dta"
****************************************
* END










****************************************
* GOLD
****************************************
use"NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-goldgroup-gold.dta", clear
keep if goldquantity!=.

*Duplicates 
drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"
drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f" 
drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3" 
drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3" 
drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231" 
drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b" 
drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"
drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc" 


merge 1:m setofgold using "NEEMSIS2-HH_v16.dta", keepusing(HHID_panel INDID_panel submissiondate version_HH householdid2020 caste jatis)

keep if _merge==3
drop _merge

order HHID_panel INDID_panel, first
sort HHID_panel INDID_panel


********** Cleaning Elena

g goldquantitypledge2=goldquantitypledge
g goldamountpledge2=goldamountpledge
g loanamountgold2=loanamountgold
g goldquantity2=goldquantity

*** check consistency total gold / pledged gold
g	unpledged_goldquantity=goldquantity - goldquantitypledge
ta unpledged
ta goldquantity goldquantitypledge if unpledged_g<0 
ta goldamountpledge if goldquantitypledge==140000
* 1 cas ou quantité et montant gagés ont été inversés (l inversion est cohérente avec loanamountgold)
replace goldquantitypledge2=48 if HHID_panel=="KOR48" & INDID_panel=="Ind_2"
replace goldamountpledge2=140000 if HHID_panel=="KOR48" & INDID_panel=="Ind_2"

g gold_rate=goldamountpledge2/goldquantitypledge2
ta gold_rate
su gold_rate, d

list HHID_panel INDID_panel goldquantity  goldquantitypledge2 goldamountpledge2  loanamountgold loanbalance gold_rate if unpledged_g<0 
*la solution la plus "conservative" consiste à considérer que le goldquantity declaré correspond à unpledged gold au lieu de totalgold (sinon il faut soit multiplier par 8 en considérant que c'est des sovereign, bof)
replace goldquantity2=goldquantity+goldquantitypledge2


*** check loanamountgold 
ta loanamountgold if goldamountpledge!=., mis
//66 peut etre soit une quantité,  soit une NR => vote pour le NR
replace loanamountgold2=goldamountpledge2 if HHID_panel=="KAR59" & INDID_panel=="Ind_2" //celui la est marqué missing dans le fichier all loans
//le 8 ici correspond probablement à la quantité
replace loanamountgold2=goldamountpledge2 if HHID_panel=="KOR19" & INDID_panel=="Ind_2"
//99 n est probablement pas une quantité;  on remplace par goldamountpledged
replace loanamountgold2=goldamountpledge2 if loanamountgold==99

// 24 loanamount ?
*br if HHID_panel=="ELA23" & INDID_panel=="Ind_2"
replace loanamountgold=goldamountpledge if HHID_panel=="ELA23" & INDID_panel=="Ind_2"
replace loanamountgold2=loanamountgold if HHID_panel=="ELA23" & INDID_panel=="Ind_2"

// 48
*br if HHID_panel=="SEM23" & INDID_panel=="Ind_2"
replace loanamountgold=goldamountpledge if HHID_panel=="SEM23" & INDID_panel=="Ind_2"
replace loanamountgold2=loanamountgold if HHID_panel=="SEM23" & INDID_panel=="Ind_2"

*** check consistency goldamountpledge goldquantitypled
ta goldamountpledge2
ta goldamountpledge2 goldquantitypledge2 if goldamountpledge2<2000
*on considere que répondu en lakh (on a bien des loanamountgold en milliers)
replace goldamountpledge2=8000 if goldamountpledge==8
replace goldamountpledge2=16000 if goldamountpledge==16
replace goldamountpledge2=40000 if goldamountpledge==40
* pour ceux qui ne renseignent pas goldamountpledge: soit on impute sur la base d'une valeur pour l or (difficile vu la variabilité), soit on attribue la value du loanamountgold => c est ce qu on fait ici
replace goldamountpledge2=loanamountgold if goldamountpledge==0 & loanamountgold!=.


*** check problems of 0
g temp=goldamountpledge2/loanamountgold
g test=0
replace test=1 if loanamountgold!=. & goldamountpledge2!=. & (goldamountpledge2==10*loanamountgold | loanamountgold==10*goldamountpledge2)

list HHID_panel INDID_panel goldquantity  goldquantitypledge2 goldamountpledge2  loanamountgold gold_rate temp if test==1
*vu le goldrate, on peut considérer que goldamountpl a un 0 en trop
replace goldamountpledge2=goldamountpledge2/10 if HHID_panel=="GOV8"  & INDID_panel=="Ind_2" | HHID_panel=="KUV34" & INDID_panel=="Ind_2" | HHID_panel=="ORA47" & INDID_panel=="Ind_2"
* et vice versa, 0 en trop pour loanamount
replace loanamountgold2=loanamountgold2/10 if HHID_panel=="KOR51"  & INDID_panel=="Ind_4" | HHID_panel=="ELA47"  & INDID_panel=="Ind_2"

drop temp test



********** Cleaning Arnaud

*** Balance à corriger
fre loansettledgold
gen loanbalancegold2=.
replace loanbalancegold2=0 if loansettledgold==1
replace loanbalancegold2=loanamountgold2 if loansettledgold==0

*** Forme
rename goldownername namefromearlier 
rename goldnumber INDID

drop goldreasonpledge_1 goldreasonpledge_2 goldreasonpledge_3 goldreasonpledge_4 goldreasonpledge_5 goldreasonpledge_6 goldreasonpledge_7 goldreasonpledge_8 goldreasonpledge_9 goldreasonpledge_10 goldreasonpledge_11 goldreasonpledge_12 goldreasonpledge_77

*** Reste of amount pledge
gen diff_pledge=goldamountpledge2-loanamountgold2
gen pb=0
replace pb=1 if diff_pledge<0
drop diff_pledge
ta pb
/*
pb bc loanamount>pledge
*/

*** Inverser amount pledge et loanamount si loanamount>pledge
gen loanamountgold3=loanamountgold2
replace loanamountgold3=goldamountpledge2 if pb==1

gen goldamountpledge3=goldamountpledge2
replace goldamountpledge3=loanamountgold2 if pb==1

gen diff_pledge2=goldamountpledge2-loanamountgold2
gen diff_pledge3=goldamountpledge3-loanamountgold3
ta diff_pledge2
ta diff_pledge3
drop diff_pledge2 diff_pledge3


*** New loan with diff loan pledge
gen loanamountgoldrest=goldamountpledge3-loanamountgold3

*** Order
sort HHID_panel INDID_panel

save"NEEMSIS2-gold.dta", replace



********** Prepa pour base all loans
use"NEEMSIS2-gold.dta", clear

gen loan_database="GOLD"
drop if loanamountgold==.

rename loanamountgold loanamount
rename loanlendergold loanlender
rename loandategold loandate
rename goldreasonpledge loanreasongiven_MCQ
rename loanbalancegold loanbalance
rename loansettledgold loansettled
rename lenderfromgold lenderfrom
rename lenderscastegold lenderscaste

destring INDID, replace
fre loansettled 

tab loanbalance, m  
tab loanbalance loansettled, m  //  314 loanbalance .
tab loanreasongiven_MCQ
split loanreasongiven_MCQ
destring loanreasongiven_MCQ1, replace
rename loanreasongiven_MCQ1 loanreasongiven
drop loanreasongiven_MCQ2 loanreasongiven_MCQ3 loanreasongiven_MCQ4 loanreasongiven_MCQ5 loanreasongiven_MCQ6 loanreasongiven_MCQ7 loanreasongiven_MCQ8 loanreasongiven_MCQ9 loanreasongiven_MCQ10
replace loanreasongiven=2 if loanreasongiven_MCQ=="1 2 3 4"
replace loanreasongiven=2 if loanreasongiven_MCQ=="1 2 3 4 5 6 9 10"
replace loanreasongiven=4 if loanreasongiven_MCQ=="1 2 4"
replace loanreasongiven=10 if loanreasongiven_MCQ=="1 2 4 10"
replace loanreasongiven=10 if loanreasongiven_MCQ=="1 2 4 9 10"
replace loanreasongiven=4 if loanreasongiven_MCQ=="1 2 5 7 10"
replace loanreasongiven=2 if loanreasongiven_MCQ=="1 2 9 10"
replace loanreasongiven=1 if loanreasongiven_MCQ=="1 3"
replace loanreasongiven=3 if loanreasongiven_MCQ=="1 3 5 11"
replace loanreasongiven=1 if loanreasongiven_MCQ=="1 4"
replace loanreasongiven=8 if loanreasongiven_MCQ=="1 8"
replace loanreasongiven=9 if loanreasongiven_MCQ=="1 9"
replace loanreasongiven=10 if loanreasongiven_MCQ=="2 10"
replace loanreasongiven=3 if loanreasongiven_MCQ=="2 3"
replace loanreasongiven=2 if loanreasongiven_MCQ=="2 3 10"
replace loanreasongiven=4 if loanreasongiven_MCQ=="2 3 4"
replace loanreasongiven=10 if loanreasongiven_MCQ=="2 3 4 10"
replace loanreasongiven=4 if loanreasongiven_MCQ=="2 3 4 5"
replace loanreasongiven=9 if loanreasongiven_MCQ=="2 3 4 9"
replace loanreasongiven=8 if loanreasongiven_MCQ=="2 3 8"
replace loanreasongiven=2 if loanreasongiven_MCQ=="2 4"
replace loanreasongiven=4 if loanreasongiven_MCQ=="2 4 10"
replace loanreasongiven=5 if loanreasongiven_MCQ=="2 4 5"
replace loanreasongiven=10 if loanreasongiven_MCQ=="2 4 5 10"
replace loanreasongiven=2 if loanreasongiven_MCQ=="2 4 5 7"
replace loanreasongiven=7 if loanreasongiven_MCQ=="2 4 7"
replace loanreasongiven=4 if loanreasongiven_MCQ=="2 4 7 10"
replace loanreasongiven=8 if loanreasongiven_MCQ=="2 4 7 8"
replace loanreasongiven=8 if loanreasongiven_MCQ=="2 4 7 8 10 11"
replace loanreasongiven=8 if loanreasongiven_MCQ=="2 4 8"
replace loanreasongiven=8 if loanreasongiven_MCQ=="2 4 8 10"
replace loanreasongiven=9 if loanreasongiven_MCQ=="2 4 9 10"
replace loanreasongiven=5 if loanreasongiven_MCQ=="2 5"
replace loanreasongiven=5 if loanreasongiven_MCQ=="2 5 9"
replace loanreasongiven=7 if loanreasongiven_MCQ=="2 7"
replace loanreasongiven=8 if loanreasongiven_MCQ=="2 8"
replace loanreasongiven=2 if loanreasongiven_MCQ=="2 9"
replace loanreasongiven=3 if loanreasongiven_MCQ=="3 10"
replace loanreasongiven=3 if loanreasongiven_MCQ=="3 4"
replace loanreasongiven=3 if loanreasongiven_MCQ=="3 5"
replace loanreasongiven=3 if loanreasongiven_MCQ=="3 7"
replace loanreasongiven=4 if loanreasongiven_MCQ=="4 10"
replace loanreasongiven=4 if loanreasongiven_MCQ=="4"
replace loanreasongiven=5 if loanreasongiven_MCQ=="4 5"
replace loanreasongiven=7 if loanreasongiven_MCQ=="4 5 7"
replace loanreasongiven=10 if loanreasongiven_MCQ=="4 5 8 10"
replace loanreasongiven=6 if loanreasongiven_MCQ=="4 6"
replace loanreasongiven=6 if loanreasongiven_MCQ=="5 6"
replace loanreasongiven=8 if loanreasongiven_MCQ=="5 8"
replace loanreasongiven=8 if loanreasongiven_MCQ=="8 9"
replace loanreasongiven=9 if loanreasongiven_MCQ=="9 10"
replace loanreasongiven=9 if loanreasongiven_MCQ=="9 11"
replace loanreasongiven=9 if loanreasongiven_MCQ=="9 77"
tab loanreasongiven, m
tab loanlender, m

label list
label define loanlendergold 15"Thandal", modify
ta loanlender, m

tab loanlender, m

clonevar loaneffectivereason=loanreasongiven
rename lenderscaste snmoneylendercastes
rename lenderfrom snmoneylenderliving

*** Var to keep
keep parent_key HHID_panel INDID_panel submissiondate version_HH householdid2020 caste jatis key loanamount loandate loanreasongiven loaneffectivereason loanlender snmoneylendercastes loansettled loanbalance loan_database loanamountgold2 pb loanamountgold3 loanamountgoldrest loanbalancegold2

order HHID_panel INDID_panel loanamount loanamountgold2 loanamountgold3 loanamountgoldrest loanlender snmoneylendercastes loansettled loanbalance loanbalancegold2

sort loanamountgold3

*** Reshape
foreach x in loanamount loanlender snmoneylendercastes loansettled loanbalance loandate pb loanreasongiven loaneffectivereason {
rename `x' `x'1
}
rename loanamountgold2 loanamount_b1
rename loanamountgold3 loanamount_c1
rename loanbalancegold2 loanbalance_b1

rename loanamountgoldrest loanamount2

gen loandate2=loandate1

egen HHINDID=concat(HHID_panel INDID_panel), p(/)

reshape long loanamount loanlender snmoneylendercastes loansettled loanbalance loandate pb loanreasongiven loaneffectivereason loanamount_b loanamount_c loanbalance_b, i(HHINDID) j(num)

*** Order
rename loanamount_b loanamount2
rename loanamount_c loanamount3
rename loanbalance_b loanbalance2

drop if loanamount==0 & num==2
drop HHINDID

rename num rest
replace rest=rest-1
label define rest 0"Main gold loan" 1"Rest of pledge"
label values rest rest

order HHID_panel INDID_panel jatis caste rest loanamount* 
order submissiondate parent_key key householdid2020, last
order loanbalance2, after(loanbalance)

*** Label
label list
label values loanlender loanlendergold
label values loanreasongiven goldreasonpledgemain
label values loaneffectivereason goldreasonpledgemain
label values snmoneylendercastes casteemployer

*** Date
format loandate %td

*** Rest replace loan
replace loanamount2=loanamount if rest==1
replace loanamount3=loanamount if rest==1
replace loanbalance2=loanamount if rest==1

save"NEEMSIS2-goldloans.dta", replace

append using "NEEMSIS2-loans_v4.dta"
fre loan_database

preserve
keep if loan_database=="FINANCE"
*select_one lenders
fre loanlender
restore

preserve
keep if loan_database=="GOLD"
*select_one lenders
fre loanlender
restore

preserve
keep if loan_database=="MARRIAGE"
*select_one lenders
fre loanlender
restore

ta loanlender version_HH

tab loanlender, m
label define loanlender 1"Well known people" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn broker" 7"Shop keeper" 8"Finance (moneylenders)" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mill loan" 14"Group finance" 15"Thandal", replace
label values loanlender loanlender

/*
Dans les analyses, recoder les gold en pawnbroker
*/

tab loanlender loan_database
label variable loanlender "From whom did you get loan?"
tab loanlender

clonevar loanlender_rec=loanlender
replace loanlender_rec=6 if loan_database=="GOLD"

*drop if loansettled==1
tab loanlender loan_database

save"NEEMSIS2-loans_v5.dta", replace
****************************************
* END












****************************************
* CLEAN + ORDER
****************************************
use"NEEMSIS2-loans_v5.dta", clear

tab loandate, m
tab loanbalance, m

tab caste

gen year=2020

********** Order
global all HHID_panel INDID caste jatis borrowername nbloansbyborrower loanid loanamount loandate loanreasongiven loanreasongiven2 loaneffectivereason loaneffectivereason2 loanotherreasongiven loanothereffectivereason loanlender lendername snmoneylenderdummyfam snmoneylenderfriend snmoneylenderwkp snmoneylenderlabourrelation snmoneylendersex snmoneylenderage snmoneylenderlabourtype snmoneylendercastes snmoneylendercastesother snmoneylendereduc snmoneylenderoccup snmoneylender2 snmoneylenderemployertype snmoneylenderoccupother snmoneylender3 snmoneylenderliving snmoneylenderruralurban snmoneylendermapdistrict snmoneylenderdistrict snmoneylenderlivingname snmoneylendercompared snmoneylenderduration snmoneylendermeet snmoneylendermeetfrequency snmoneylenderinvite snmoneylenderreciprocity1 snmoneylenderintimacy snmoneylenderphonenb snmoneylenderphoto snmoneylendermeetother otherlenderservices guarantee allloans3 guaranteeother otherlenderservicesother guaranteetype loansettled dummyinterest interestpaid covfrequencyinterest covamountinterest alloans4 loanbalance totalrepaid covfrequencyrepayment covrepaymentstop mainloanid mainloanname lenderfirsttime additionalloan borrowerservices borrowerservicesother plantorepay plantorepayother termsofrepayment repayduration1 repayduration2 dummyinteret interestfrequency interestloan dummyproblemtorepay problemdelayrepayment problemdelayrepaymentother settleloanstrategy settleloanstrategyother loanproductpledge loanproductpledgeother loanproductpledgeaamount dummyhelptosettleloan helptosettleloan dummyrecommendation dummyguarantor recommenddetailscaste recommendloanrelation guarantordetailscaste guarantorloanrelation dummyincomeassets incomeassets
foreach x in $all{
capture confirm v `x'
if _rc==0{
}
else{
gen `x'=""
}
}
order $all, first
dropmiss $all, force


********** New var for panel
*** Caste
clonevar lenderscaste=snmoneylendercastes

*** Relation
fre snmoneylenderdummyfam snmoneylenderfriend snmoneylenderwkp snmoneylenderlabourrelation
gen lenderrelation=.
replace lenderrelation=2 if snmoneylenderdummyfam==1
replace lenderrelation=10 if snmoneylenderfriend==1
replace lenderrelation=8 if snmoneylenderwkp==1
replace lenderrelation=1 if snmoneylenderlabourrelation==1

*** Living
fre snmoneylenderliving
gen lenderfrom=.
replace lenderfrom=1 if snmoneylenderliving==1
replace lenderfrom=1 if snmoneylenderliving==2
replace lenderfrom=2 if snmoneylenderliving==3
replace lenderfrom=2 if snmoneylenderliving==4
replace lenderfrom=2 if snmoneylenderliving==5
replace lenderfrom=2 if snmoneylenderliving==6

*** Sex
clonevar lendersex=snmoneylendersex

*** Occupation
clonevar lenderoccup=snmoneylenderoccup


********** Add caste, etc
merge m:1 HHID_panel INDID_panel using "NEEMSIS2-HH_v16.dta", keepusing(egoid name sex age edulevel)
drop if _merge==2

save"NEEMSIS2-loans_v6.dta", replace
****************************************
* END















****************************************
* DATE + DURATION + PURPOSE
****************************************
use"NEEMSIS2-loans_v6.dta", clear


*** Change date format of submissiondate
rename submissiondate submissiondate_o
gen submissiondate=dofc(submissiondate_o)
format submissiondate %td

*** Loan duration
gen loanduration=submissiondate-loandate

*** Type of loan
fre loanlender
gen lender_cat=.
label define lender_cat 1"Informal" 2"Semi formal" 3"Formal"
label values lender_cat lender_cat

foreach i in 1 2 3 4 5 7 9 13{
replace lender_cat=1 if loanlender_rec==`i'
}
foreach i in 6 10 15{
replace lender_cat=2 if loanlender_rec==`i'
}
foreach i in 8 11 12 14{
replace lender_cat=3 if loanlender_rec==`i'
}
fre lender_cat

*** Purpose of loan
replace loanreasongiven=loanreasongiven2 if loanreasongiven==.
label define loanreasongiven 1"Agriculture" 2"Family" 3"Health" 4"Repay previous loan" 5"House expenses" 6"Investment" 7"Ceremonies" 8"Marriage" 9"Education" 10"Relatives" 11"Death" 12"No reason" 77"Other", replace
label values loanreasongiven loanreasongiven
tab loanreasongiven

fre loanreasongiven
gen reason_cat=.
label define reason_cat 1"Economic" 2"Current" 3"Human capital" 4"Social" 5"Housing" 6"No reason" 77"Other"
label values reason_cat reason_cat
foreach i in 1 6{
replace reason_cat=1 if loanreasongiven==`i'
}
foreach i in 2 4 10{
replace reason_cat=2 if loanreasongiven==`i'
}
foreach i in 3 9{
replace reason_cat=3 if loanreasongiven==`i'
}
foreach i in 7 8 11{
replace reason_cat=4 if loanreasongiven==`i'
}
replace reason_cat=5 if loanreasongiven==5
replace reason_cat=6 if loanreasongiven==12
replace reason_cat=77 if loanreasongiven==77

fre reason_cat
save"NEEMSIS2-loans_v7.dta", replace
****************************************
* END











****************************************
* NEW LENDER VAR
****************************************
use "NEEMSIS2-loans_v7.dta", clear
fre loanlender
label define loanlender 1"WKP" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn Broker" 7"Shop keeper" 8"Finance (moneylenders)" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mill loan" 14"Group finance" 15"Thandal", replace  // Thandal = daily finance; door to door; small amount; it mean "immediat" in tamil
label values loanlender loanlender
fre loanlender
*Recode loanlender pour que les intérêts soient plus justes
gen lender2=.
replace lender2=1 if loanlender==1
replace lender2=2 if loanlender==2
replace lender2=3 if loanlender==3 | loanlender==4 | loanlender==5  // labour relation 
replace lender2=4 if loanlender==6
replace lender2=5 if loanlender==7
replace lender2=6 if loanlender==8
replace lender2=7 if loanlender==9
replace lender2=8 if loanlender==10 | loanlender==14  // SHG & group finance
replace lender2=9 if loanlender==11 | loanlender==12 | loanlender==13  // bank & coop & sugar mill loan
replace lender2=10 if loanlender==15  // thandal
label define lender2 1 "WKP" 2 "Relatives" 3 "Labour" 4 "Pawn broker" 5 "Shop keeper" 6 "Moneylenders" 7 "Friends" 8"SHG & grp fin" 9 "Banks" 10"Thandal", replace
label values lender2 lender2
fre lender2

*Including relationship to the lender
gen lender3=lender2
replace lender3=1 if snmoneylenderwkp==1  // WKP
replace lender3=2 if snmoneylenderdummyfam==1  // Relatives
replace lender3=3 if snmoneylenderlabourrelation==1  // labour
replace lender3=7 if snmoneylenderfriend==1  // Friends
label define lender3 1 "WKP" 2 "Relatives" 3 "Labour" 4 "Pawn broker" 5 "Shop keeper" 6 "Moneylenders" 7 "Friends" 8 "Microcredit" 9 "Bank" 10 "Thandal"
label values lender3 lender3
tab lender3 lender2

*correction of the moneylenders category with info from the main loan variable "lendername" 
gen lender4=lender3
tab lendername
replace lender4=8 if strpos(lendername, "finance") & lendername!="Daily finance"
replace lender4=8 if strpos(lendername, "Finance")
replace lender4=8 if strpos(lendername, "Therinjavanga")
replace lender4=10 if strpos(lendername, "thandal")
 replace lender4=10 if strpos(lendername, "Thandal")
label values lender4 lender3
label var lender4 "version def (lendername)"

fre lender4
clonevar lender4_rec=lender4
replace lender4_rec=4 if loan_database=="GOLD"
ta loanlender_rec lender4_rec

save "NEEMSIS2-loans_v8.dta", replace
****************************************
* END











****************************************
* ORDER + DUPLICATES + BALANCE and AMOUNT for everyone
****************************************
use"NEEMSIS2-loans_v8.dta", clear

*** Order
order HHID_panel INDID_panel loan_database loanamount loanamount2 loanamount3
sort HHID_panel INDID_panel loan_database loanamount3

gen loanduration_month=loanduration/30.467
replace loanduration_month=1 if loanduration_month<1
tab loanduration_month

dropmiss, force

*** After clean gold, replace in 2 and 3 version
replace loanbalance2=loanbalance if loan_database!="GOLD"
replace loanamount2=loanamount if loan_database!="GOLD"
replace loanamount3=loanamount if loan_database!="GOLD"

*** Drop
drop if jatis==.
drop guarantorloanrelation_10 helptosettleloan_5 helptosettleloan_10 recommendloanrelation_4 recommendloanrelation_66 recommendloanrelation_7 recommendloanrelation_11 guarantorloanrelation_4 guarantorloanrelation_66 guarantorloanrelation_7


********** Duplicates
***
preserve
***
duplicates tag HHID_panel INDID_panel loanamount loanlender loanreasongiven loandate, gen(tag)

bysort HHID_panel INDID_panel: egen tokeep=sum(tag)
drop if tokeep==0
drop tokeep

gen gold=0
replace gold=1 if loan_database=="GOLD" & tag!=0 & tag!=.
bysort HHID_panel INDID_panel: egen tokeep=sum(gold)
drop if tokeep==0
drop tokeep

ta tag
drop if tag==0
sort HHID_panel INDID_panel tag loanamount loan_database loandate
order HHID_panel INDID_panel loan_database tag

ta tag
drop if HHID_panel=="KOR42" & INDID_panel=="Ind_2" & loan_database=="FINANCE" & tag==1 & loanamount==45000
drop if HHID_panel=="NAT30" & INDID_panel=="Ind_5" & loan_database=="FINANCE" & tag==1 & loanamount==100000
drop if HHID_panel=="NAT42" & INDID_panel=="Ind_1" & loan_database=="FINANCE" & tag==1 & loanamount==50000
drop if HHID_panel=="NAT50" & INDID_panel=="Ind_1" & loan_database=="FINANCE" & tag==1 & loanamount==30000 & loandate==td(01jan2020)

drop if tag==2

gen duplicates=1
gen duplicatestodrop=0
replace duplicatestodrop=1 if loan_database=="GOLD"

drop tag

save"NEEMSIS2-loans_duplicates.dta", replace

***
restore
***

ta _merge
drop _merge

merge 1:1 HHID_panel INDID_panel loan_database loanamount loandate loanreasongiven loanlender loanid using "NEEMSIS2-loans_duplicates.dta", keepusing(duplicates duplicatestodrop)

drop _merge
ta duplicates 
recode duplicates (.=0)
recode duplicatestodrop (.=0)

ta duplicates
ta duplicatestodrop loan_database

save "NEEMSIS2-loans_v9.dta", replace
****************************************
* END















****************************************
* COHERENCE
****************************************
use"NEEMSIS2-loans_v9.dta", clear

********** Sample size test + 66 recode
clonevar interestpaid2=interestpaid
clonevar totalrepaid2=totalrepaid

*** Interest
ta dummyinterest
ta interestpaid if loan_database=="FINANCE"
*2819 --> 1442 as 66 --> 1377
replace interestpaid2=. if interestpaid==55 | interestpaid==66

*** Repaid
ta loansettled if loan_database=="FINANCE"
*4303 loans
ta dummyinterest if loansettled==0 & loan_database=="FINANCE"
* 2512 loans non settled with interest........
* =2512 loans with totalrepaid
/*
Il y a une erreur dans le questionnaire ici je suppose, la question ne doit être conditionnée que aux prêts non settled
Même si la personne ne paye pas d'intérêts, la question aurait quand même due être posée
Parce que, du coup, nous ne pouvons pas faire la double vérification pour pas mal de prêts
*/
ta totalrepaid if loan_database=="FINANCE"
*2512 --> 39 as 66 --> 2473
replace totalrepaid2=. if totalrepaid==66

*** Loan amount
replace loanamount=. if loanamount==66




********** Principalpaid creation
*** Generique
g principalpaid=.
replace principalpaid=totalrepaid2-interestpaid2
ta principalpaid

*** Cas ou total repaid=0 mais interestpaid>0
replace principalpaid=0 if totalrepaid2==0 


*** Cas ou il n'y a pas d'intérêts (à voir après)
*replace principalpaid=totalrepaid if principalpaid==. & dummyinterest==1 & totalrepaid!=.

gen test=(totalrepaid2-interestpaid2==loanamount3-loanbalance2)
ta test
/*
       test |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      4,397       75.76       75.76
          1 |      1,407       24.24      100.00
------------+-----------------------------------
      Total |      5,804      100.00
*/
drop test



********** Small amount of loanbalance
list HHID_panel INDID_panel loanamount loanbalance totalrepaid interestpaid loan_database loanid if loanbalance<100 & loanbalance>0, clean noobs

* totalrepaid - interestpaid = 11115, ie principal left=8885
replace loanbalance2=8885 if HHID_panel=="KAR56" & INDID_panel=="Ind_2" & loanid==2
*si valeurs  bizarres: on garde loanamount
replace loanbalance2=loanamount if ///
(HHID_panel=="SEM65" & INDID_panel=="Ind_4" & loanid==2) | ///
(HHID_panel=="ORA11" & INDID_panel=="Ind_1" & loanid==5) | ///
(HHID_panel=="NAT39" & INDID_panel=="Ind_2" & loanid==2) | ///
(HHID_panel=="MAN67" & INDID_panel=="Ind_1" & loanid==3) | ///
(HHID_panel=="SEM49" & INDID_panel=="Ind_1" & loanid==5) 




********** Consistency totalrepaid et loanbalance

*** Intéret théorique
g months_diff = round((submissiondate-loandate)/(365/12))
g years_diff=round((submissiondate-loandate)/365)
g weeks_diff=round((submissiondate-loandate)/(365/53))
g th_interest=.
replace th_interest=weeks_diff*interestloan if interestfreq==1
replace th_interest=months_diff*interestloan if interestfreq==2
replace th_interest=years_diff*interestloan if interestfreq==3


*** Recodage 
/*(semble souvent repondu comme interestloan) - mais on ne peut pas savoir de toute facon;..
replace interestpaid2=. if interestpaid==interestloan & th_interest!=interestpaid & th_interest!=interestpaid+interestloan & (interestfreq==1 | interestfreq==2 | interestfreq==3)
*/
* si loanbalance=loanamount - total repaid & interestpaid>0: on considère que totalrepaid est en fait principalpaid
g principalpaid2=principalpaid


*** Cohérence ?
g temp=((loanbalance2==loanamount3-totalrepaid2) & interestpaid2>0 & interestpaid2!=.)
ta temp
order temp loanbalance2 loanamount3 totalrepaid2 interestpaid2 principalpaid2
replace principalpaid2=totalrepaid2 if temp==1
replace totalrepaid2=principalpaid2+interestpaid2 if principalpaid2!=. & interestpaid2!=.
drop temp




********** Principalpaid negatif
*br HHID_panel INDID_panel loanamount loanbalance2 totalrepaid2 interestpaid2 principalpaid2 th_interest interestfrequency interestloan lender4 repayduration2 loanid  months_diff  if principalpaid2<0

*ici interestpaid2=6912 correspond à 24*interestloan (repayduration=27 mois, ca fait un taux d intéret total dans les clous). donc le principal remboursé  (30 000/27)*24=26667 => ce qui au bout de 24 mois nous donne bien loabbalance
replace principalpaid2=26667 if HHID_panel=="MANAM25" & INDID_panel=="Ind_2" & loanid==1
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="MANAM25" & INDID_panel=="Ind_2" & loanid==1
* interespaid correspond a 22*interestloan. principal paid en 22 mois= (30 000/24)*22=27500 => coherent avec loanbalance
replace principalpaid2=27500 if HHID_panel=="MANAM25" & INDID_panel=="Ind_2" & loanid==2
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="MANAM25" & INDID_panel=="Ind_2" & loanid==2
*pb de 0
replace totalrepaid2=totalrepaid*10 if HHID_panel=="KUV18" & INDID_panel=="Ind_1" & loanid==3
replace principalpaid2=totalrepaid2 - interestpaid2 if HHID_panel=="KUV18" & INDID_panel=="Ind_1"  & loanid==3
*interestloan represente très probablement le montant total payé chaque mois (principal + interet). interestpaid est coherent avec 22 mois de paiement (ie 567 INR par mois d interetà. donc principalpaid=(2650-567)*22=45826 => cohérent avec loanbalance
replace interestloan=567 if HHID_panel=="MANAM47" &	INDID_panel=="Ind_3" & loanid==2
replace principalpaid2=45826 if HHID_panel=="MANAM47" &	INDID_panel=="Ind_3" & loanid==2
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="MANAM47" & INDID_panel=="Ind_3" & loanid==2
* des idées pour les autres ?




********** Balance, amount et principal
g test=loanbalance2-(loanamount3-principalpaid2)
ta loansettled if test!=0 & test!=., mis //tous unsetteld
ta dummyinterest if test!=0 & test!=., mis //tous à interet
ta test

gen test2=.
replace test2=1 if test>0 & test!=.
replace test2=-1 if test<0 & test!=.
ta test2
/** si loanbalance > loanamount - principalpaid:  (en gros 10% des prêts): ils surestiment ce qu'ils restent à payer ? ils sous estiment ce qu'ils ont déjà payé ?
=> si priorité à principalpaid (ie on ajuste loanbalance à la baisse): risque de surestimer service de la dette (principalpaid > loanamount - loanbalance) et sous estimer dette
=> si priorité à loanbalance: risque de surestimer la dette et sous estimer service
 ** si loanbalance < loanamount - principalpaid (en gros 5%): l'inverse

DONC on peut éventuellement considérer qu estimer le service de la dette est de toute facon foireux avec ce type de données et privilégier le volume de dette, donc faire les choix qui empechent surestimation de la dette:
=> priorité à loanbalance si loanbalance < loanamount - principalpaid 
=> priorité à principalpaid si  loanbalance > loanamount - principalpaid 
*/




********** Correction 
/*
Suite à la discussion du 17/1/22, on décide de garder l'approche par balance
However, if loanamount=loanbalance, we use principalpaid
*/
order test test2 loanbalance2 loanamount3 principalpaid2 interestpaid2 totalrepaid2

*** var to create
clonevar principalpaid3=principalpaid2
clonevar loanbalance3=loanbalance2
clonevar totalrepaid3=totalrepaid2


*** if test>0: 189 loans
replace principalpaid3=loanamount3-loanbalance2 if test2==1 & loanamount3!=loanbalance2
*70/189=119 loans?
ta loanamount3 if test2==1 & loanamount3==loanbalance2
*ok

*** if test<0: 104 loans
replace principalpaid3=loanamount3-loanbalance2 if test2==-1 & loanamount3!=loanbalance2
*102/104=2 loans
ta loanamount3 if test2==-1 & loanamount3==loanbalance2
*ok

*** if loanamount=loanbalance with principal positive, priority to principalpaid
*119 loans
list loanamount3 loanbalance2 totalrepaid2 principalpaid3 interestpaid2 loansettled if test2==1 & loanamount3==loanbalance2, clean noobs
*If principal<loanamount
replace loanbalance3=loanamount3-principalpaid3 if test2==1 & loanamount3==loanbalance2 & principalpaid3<loanamount3
*44 changes --> 75
list loanamount3 loanbalance3 totalrepaid2 principalpaid3 interestpaid2 if test2==1 & loanamount3==loanbalance2, clean noobs

* If principal>loanamount
list loanamount3 loanbalance3 totalrepaid2 principalpaid3 interestpaid2 if test2==1 & loanamount3==loanbalance2 & principalpaid3>loanamount3, noobs
list loanamount loanbalance totalrepaid principalpaid interestpaid if test2==1 & loanamount3==loanbalance2 & principalpaid3>loanamount3, noobs
gen pb2=0
replace pb2=1 if test2==1 & loanamount3==loanbalance2 & principalpaid3>=loanamount3


*** if loanamount=loanbalance with principal negative, principal=0 & total=interest
*2 loans
list loanamount3 loanbalance2 totalrepaid2 principalpaid3 interestpaid2 if test2==-1 & loanamount3==loanbalance2, clean noobs
replace totalrepaid3=interestpaid2 if test2==-1 & loanamount3==loanbalance2
replace principalpaid3=0 if test2==-1 & loanamount3==loanbalance2
list loanamount3 loanbalance2 totalrepaid3 principalpaid3 interestpaid2 if test2==-1 & loanamount3==loanbalance2, clean noobs




********** Recodage manuel Elena
/*** ci dessous j ai commencé à recoder à la main quelques cas pour lesquels loanbalance < loanamount - principalpaid 
 mais j'ai abandonné car beaucoup trop fastidieux et surtout, il se trouve que quand c est possible de retrouver les bons montants en croisant les infos, ca revient à faire le choix mentionné ci dessus 
 */

*br HHID_panel INDID_panel loanamount loanbalance2 totalrepaid2 interestpaid2 principalpaid2 test th_interest interestfrequency interestloan lender4 repayduration1 repayduration2 loanid  months_diff lendername if test<-1000

/*40 000/24=1667 => loanbalance serait coherent avec 10 mois de principal à payer, donc 14 déjà payés (ok vu que le pret a été contracté il y a 15 mois). donc interestpaid serait 183*14=2562 et principalpaid=230338
mais totalrepaid serait coherent avec 10 mois remboursés (1667+183)*10
donc on y va a la hache et on considere que loanbalance est en fait principalpaid
*/
replace principalpaid2=loanbalance2 if HHID_panel=="SEM8" &	INDID_panel=="Ind_2" & loanid==5
replace interestpaid2=totalrepaid2-principalpaid2 if HHID_panel=="SEM8" & INDID_panel=="Ind_2" & loanid==5
replace loanbalance2=loanamount - principalpaid2 if HHID_panel=="SEM8" & INDID_panel=="Ind_2" & loanid==5

*censé rembourser 2600/mois ((50 000 + 24*516)/24 ), coherent avec 2 mois de remboursement: 4168 est le principal remboursé en 2 mois
replace loanbalance2=loanamount - loanbalance if HHID_panel=="SEM8" & INDID_panel=="Ind_2" & loanid==2

* loanbalance coherent avec 4 mois restant à payer ( 35 000/24)* 4= 5833. donc a déjà payé 20 mois (ok loan a été contracté il y a 23 mois). donc porincipalpaid en 20 mois=29 167. et interet 20 mois en theorie=2840 => ce qui est ok avec interestpaid
replace principalpaid2=29167 if HHID_panel=="ORA10" &	INDID_panel=="Ind_2" & loanid==3
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="ORA10" &	INDID_panel=="Ind_2" & loanid==3

*interestpaid=24*interestloan. donc si loanbalance est ok, signifie qu a payé 10 278 par mois * 24 en principal. ferait un pret de 36 mois. pas absurde.
replace principalpaid2=10278*24 if HHID_panel=="ORA15" & INDID_panel=="Ind_2" & loanid==1
replace totalrepaid2=principalpaid2+interestpaid2 if  HHID_panel=="ORA15" & INDID_panel=="Ind_2" & loanid==1

*interestpaid coherent avec 11 mois payés. et loabalance avec 7 mois restant. => ok pour repayduration de 18 mois
replace principalpaid2=2222*11 if HHID_panel=="SEM29" &	INDID_panel=="Ind_1" & loanid==1
replace  totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="SEM29" &	INDID_panel=="Ind_1" & loanid==1
	
*loanbalance coherent avec 10 mois restant à payer si on considere une durée classique de 24 mois. interestpaid donnerait sur 24 mois un taux à 20%, ok. 
replace principalpaid2=1667*14 if HHID_panel=="KAR28" &	INDID_panel=="Ind_2" & loanid==1
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="KAR28" &	INDID_panel=="Ind_2" & loanid==1

*loanbalance coherent avec 11 mois à payer si repayduration = 24. donnerait un taux de 27%, ok.
replace principalpaid2=13*1667 if HHID_panel=="SEM6" &	INDID_panel=="Ind_2" & loanid==1
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="SEM6" &	INDID_panel=="Ind_2" & loanid==1
	

*loanbalance cogerent avec 2 mois restant à payer. avec interestpaid donnerait un taux d interet a 17%
replace principalpaid2=2084*22 if  HHID_panel=="SEM2" & INDID_panel=="Ind_4" & loanid==8
replace totalrepaid2=principalpaid2+interestpaid2 if   HHID_panel=="SEM2" & INDID_panel=="Ind_4" & loanid==8

*loanbalance cohérent avec 7 mois restant à payer. 
replace principalpaid2=1167*17 if loanid==2 & HHID_panel=="KAR42" &	INDID_panel=="Ind_2"
replace totalrepaid2=principalpaid2+interestpaid2 if  loanid==2 & HHID_panel=="KAR42" &	INDID_panel=="Ind_2"

*loanbalance coherent avec3 mois restant à payer
replace principalpaid2=1250*21 if HHID_panel=="SEM2" &	INDID_panel=="Ind_4" & loanid==9
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="SEM2" &	INDID_panel=="Ind_4" & loanid==9




********** Ceux qui n'arrivait pas à donner une estimation des intérêts

*On fait confiance à la balance
*comme ça on voit un peu le principal et on en déduit les intérêts?
clonevar principalpaid4=principalpaid3
order principalpaid4, after(principalpaid3)
clonevar interestpaid3=interestpaid2
order interestpaid3, after(interestpaid2)

replace principalpaid4=loanamount3-loanbalance3 if interestpaid==66 | interestpaid==55
replace interestpaid3=totalrepaid3-principalpaid4 if interestpaid==66 | interestpaid==55
sort interestpaid3
*br if loansettled==0 & loan_database=="FINANCE" & dummyinterest==1 & interestpaid==66




********** Consistency principalpaid, loanbalance, settled
*certains prets semblent furieusement etre rembourses

g pb3=(principalpaid4>=loanamount3 & principalpaid4!=. & loansettled==0)
ta pb3
/*
        pb3 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      5,724       98.62       98.62
          1 |         80        1.38      100.00
------------+-----------------------------------
      Total |      5,804      100.00
*/
br HHID_panel INDID_panel loanamount3 loanbalance3 interestpaid3 principalpaid4 totalrepaid3 test th_interest interestfrequency interestloan lender4 repayduration2 loanid  months_diff  if pb3==1

* je propose d'attribuer le surplus de principalpaid à interestpaid2, mettre loanbalance=0, et conserver loansettled=0 pour prendre en compte le fait qu il reste surement de l interet à payer

replace interestpaid3=principalpaid4-loanamount3 if pb3==1
replace principalpaid4=loanamount3 if pb3==1
replace loanbalance3=0 if pb3==1
*br HHID_panel INDID_panel loanamount3 loanbalance3 totalrepaid3 interestpaid3 principalpaid4 test th_interest interestfrequency interestloan lender4 repayduration2 loanid  months_diff  if pb3==1




********** On en est où donc ?
drop test test2

gen test=(totalrepaid3-interestpaid3==loanamount3-loanbalance3)
ta test
/*
       test |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      2,844       49.00       49.00
          1 |      2,960       51.00      100.00
------------+-----------------------------------
      Total |      5,804      100.00
*/

order HHID_panel INDID_panel test loansettled dummyinterest loanamount3 loanbalance3 principalpaid4 interestpaid3 totalrepaid3 lender4 loanlender loan_database
sort test dummyinterest
ta dummyinterest test, m
/*
  Is there |
        an |
  interest |
  rate for |         test
   loan #? |         0          1 |     Total
-----------+----------------------+----------
        No |     1,791        347 |     2,138 
       Yes |       221      2,598 |     2,819 
         . |       832         15 |       847 
-----------+----------------------+----------
     Total |     2,844      2,960 |     5,804 

On a 2844 loans pb
1791 sont sans intérêts, donc je pense que ca peut se corriger facilement car pb vient juste de missing:
	On peut donc tenter loanamount-loanbalance as principalpaid 
	Et donc totalrepaid=principalpaid?
221 à inspecter par contre...! 
*/


*** Ceux sans int
ta totalrepaid3 if dummyinterest==0, m
replace principalpaid4=loanamount3-loanbalance3 if dummyinterest==0 & test==0
replace totalrepaid3=principalpaid4 if dummyinterest==0 & test==0
replace interestpaid3=0 if dummyinterest==0 & test==0

* Vérification
drop test
gen test=(totalrepaid3-interestpaid3==loanamount3-loanbalance3)
ta dummyinterest test, m


*** Les autres ?
gen test2=((loanamount3-principalpaid4)==loanbalance3)
ta test test2
/*
Among les 221, il y en a 219 pour lesquels: 
amount-principal=balance.......!
donc on reste avec ça je pense
*/
drop test test2





********** kézako les 2, 3, 4, etc.
/*
loanamount			loanamount classique, l'original, le seul et l'unique
loanamount2			
loanamount3

interestpaid
interestpaid2
interestpaid3

loanbalance
loanbalance2
loanbalance3

totalrepaid
totalrepaid2
totalrepaid3

principalpaid
principalpaid2
principalpaid3
principalpaid4

duplicates 
duplicatestodrop 
months_diff 
years_diff 
weeks_diff 
th_interest 
pb2 
pb3 
*/


save"NEEMSIS2-loans_v10.dta", replace
****************************************
* END













****************************************
* ANNUALIZED
****************************************
use"NEEMSIS2-loans_v10.dta", clear

*****
*Arnaud test yrate
gen yratepaid=interestpaid2*100/loanamount if loanduration<=365

gen _yratepaid=interestpaid2*365/loanduration if loanduration>365
gen _loanamount=loanamount*365/loanduration if loanduration>365

replace yratepaid=_yratepaid*100/_loanamount if loanduration>365
drop _loanamount _yratepaid

tab yratepaid
sort yratepaid
*tab loanamount if loanamount<1000
*drop if loanamount<1000

tabstat yratepaid if interestpaid2>0 & interestpaid2!=., by(lender4) stat(n mean p50 min max)
gen monthlyinterestrate=.
replace monthlyinterestrate=yratepaid if loanduration<=30.4167
replace monthlyinterestrate=(yratepaid/loanduration)*30.4167 if loanduration>30.4167

*****
/*
ALL LOANS

     lender4 |         N      mean       p50       min       max
-------------+--------------------------------------------------
         WKP |       280  39.04335        30  .8333333       600
   Relatives |        54  30.33661        25         2       144
      Labour |        95  23.50702        20       2.4       108
 Shop keeper |         6  30.54747        33  .9212121        70
Moneylenders |        32  16.88754  13.32667  .7272727  73.77333
     Friends |       488  25.10458        18  .0057143       500
 Microcredit |        88  18.96117        10   .007875       120
        Bank |       147  20.33835    14.575       .21     122.4
     Thandal |        98  10.93325        10         1        60
-------------+--------------------------------------------------
       Total |      1288  26.01552        18  .0057143       600
----------------------------------------------------------------
*/

save"NEEMSIS2-loans_v11.dta", replace
*************************************
* END


















****************************************
* IMPUTATION
****************************************
use"NEEMSIS2-loans_v11.dta", clear


*** Add income
drop _merge
merge m:1 HHID_panel INDID_panel using "NEEMSIS2-HH_v16.dta", keepusing(annualincome_indiv annualincome_HH) 
drop if _merge==2
drop _merge
tab loansettled
tab householdid2020


*** Debt service pour ML
gen debt_service=.
replace debt_service=totalrepaid2 if loanduration<=365
replace debt_service=totalrepaid2*365/loanduration if loanduration>365
replace debt_service=0 if loanduration==0 & totalrepaid2==0 | loanduration==0 & totalrepaid2==.


*** Interest service pour ML
gen interest_service=.
replace interest_service=interestpaid2 if loanduration<=365
replace interest_service=interestpaid2*365/loanduration if loanduration>365
replace interest_service=0 if loanduration==0 & totalrepaid2==0 | loanduration==0 & totalrepaid2==.
replace interest_service=0 if dummyinterest==0 & interestpaid2==0 | dummyinterest==0 & interestpaid2==.



*** Imputation du principal
gen imp_principal=.
replace imp_principal=loanamount-loanbalance if loanduration<=365 & debt_service==.
replace imp_principal=(loanamount-loanbalance)*365/loanduration if loanduration>365 & debt_service==.



*** Imputation interest for moneylenders (.17) and microcredit (.19)
gen imp1_interest=.
replace imp1_interest=0.17*loanamount if lender4==6 & loanduration<=365 & debt_service==.
replace imp1_interest=0.17*loanamount*365/loanduration if lender4==6 & loanduration>365 & debt_service==.
replace imp1_interest=0.19*loanamount if lender4==8 & loanduration<=365 & debt_service==.
replace imp1_interest=0.19*loanamount*365/loanduration if lender4==8 & loanduration>365 & debt_service==.
replace imp1_interest=0 if lender4!=6 & lender4!=8 & debt_service==. & loandate!=.


*** Imputation total
gen imp1_totalrepaid_year=imp_principal+imp1_interest



*** Calcul service de la dette pour tout
gen imp1_debt_service=debt_service
replace imp1_debt_service=imp1_totalrepaid_year if debt_service==.
replace imp1_debt_service=. if loansettled==1



*** Calcul service des interets pour tout
gen imp1_interest_service=interest_service
replace imp1_interest_service=imp1_interest if interest_service==.
replace imp1_interest_service=. if loansettled==1


save"NEEMSIS2-loans_v12.dta", replace
*************************************
* END














****************************************
* Other measure
****************************************
use"NEEMSIS2-loans_v12.dta", clear


*Nb of ML/indiv/HH
gen dummymainloans=0
replace dummymainloans=1 if mainloanname!=""
tab dummymainloans


*** Nber of loan
gen loans_gm=1
replace loans_gm=. if loansettled==1

gen loans=0
replace loans=1 if loan_database=="FINANCE"
replace loans=. if loansettled==1

gen loans_g=1
replace loans_g=0 if loan_database=="MARRIAGE"
replace loans_g=. if loansettled==1


*** Loan amount
clonevar loanamount_gm=loanamount
replace loanamount_gm=. if loansettled==1

clonevar loanamount_g=loanamount
replace loanamount_g=. if loan_database=="MARRIAGE"
replace loanamount_g=. if loansettled==1

clonevar loanamount_fin=loanamount
replace loanamount_fin=. if loan_database=="MARRIAGE"
replace loanamount_fin=. if loan_database=="GOLD"
replace loanamount_fin=. if loansettled==1

ta loanamount_fin loan_database, m
ta loanamount_g loan_database, m
ta loanamount_gm loan_database, m


*** Indiv + HH level
foreach x in loans loans_gm loans_g loanamount_g loanamount_gm loanamount_fin {
bysort HHID_panel INDID_panel: egen `x'_indiv=sum(`x')
bysort HHID_panel: egen `x'_HH=sum(`x')
}

rename loanamount_fin_indiv loanamount_indiv
rename loanamount_fin_HH loanamount_HH

drop loanamount_fin loans_gm loanamount_gm loans_gm loans loans_g loanamount_g

*** Services
bysort HHID_panel INDID_panel: egen imp1_ds_tot_indiv=sum(imp1_debt_service)
bysort HHID_panel INDID_panel: egen imp1_is_tot_indiv=sum(imp1_interest_service)

bysort HHID_panel: egen imp1_ds_tot_HH=sum(imp1_debt_service)
bysort HHID_panel: egen imp1_is_tot_HH=sum(imp1_interest_service)


save"NEEMSIS2-loans_v13.dta", replace
*************************************
* END
















****************************************
* Individual level
****************************************
use"NEEMSIS2-loans_v13.dta", clear

*Indiv
preserve
duplicates drop HHID_panel INDID_panel, force
keep HHID_panel INDID_panel loans_indiv loans_g_indiv loans_gm_indiv loanamount_gm_indiv  loanamount_g_indiv loanamount_indiv imp1_ds_tot_indiv imp1_is_tot_indiv
save"NEEMSIS2-loans_v13_indiv.dta", replace
restore

*HH
preserve
duplicates drop HHID_panel, force
keep HHID_panel loans_HH loans_gm_HH loans_g_HH loanamount_gm_HH loanamount_g_HH imp1_ds_tot_HH imp1_is_tot_HH loanamount_HH
save"NEEMSIS2-loans_v13_HH.dta", replace
restore


*********** Merge
use"NEEMSIS2-HH_v16.dta", clear

merge 1:1 HHID_panel INDID_panel using "NEEMSIS2-loans_v13_indiv"
drop _merge

merge m:1 HHID_panel using "NEEMSIS2-loans_v13_HH"
drop _merge

drop if parent_key==""

save"NEEMSIS2-HH_v17.dta", replace
*************************************
* END
