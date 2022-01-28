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

*** Duplicates
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
