*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 10, 2023
*-----
*NEEMSIS-1 HH last clean
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-1"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\2016-NEEMSIS1\Data\4team"
cd"$directory"
********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid
********** Program
global prgm = "C:\Users\Arnaud\Documents\GitHub\odriis\_program"
do"$prgm\splitvarmcq.do"
do"$prgm\newn.do"
do"$prgm\repmi.do"
********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020
*-------------------------








****************************************
* NEEMSIS1-HH.dta
****************************************
use"NEEMSIS1-HH", clear

********** . as ""
foreach x in otherorigin giftoccasionother_WKP giftoccasionother_rel giftoccasionother_friends demogoldreasonbuyother landlostreason useincomesaleproperty    {
replace `x'="" if `x'=="."
}


********** Intro
replace lefthomedestination="" if lefthomedestination=="."
replace lefthomereason="" if lefthomereason=="."




********** Education
foreach x in canread everattendedschool classcompleted currentlyatschool educationexpenses amountschoolfees bookscost transportcost dummyscholarship converseinenglish {
replace `x'=. if age<=5
}
replace reasondropping="" if age<=5
replace reasonneverattendedschool="" if age<=5


ta reasonneverattendedschool
replace reasonneverattendedschool="" if reasonneverattendedschool=="."
forvalues i=1/13 {
gen reasonneverattendedschool_`i'=0 if reasonneverattendedschool!=""
}
split reasonneverattendedschool
forvalues i=1/13 {
replace reasonneverattendedschool_`i'=1 if reasonneverattendedschool1=="`i'"
replace reasonneverattendedschool_`i'=1 if reasonneverattendedschool2=="`i'"
label values reasonneverattendedschool_`i' dummymigration
label var reasonneverattendedschool_`i' "reasonneverattendedschool=`i'"
}
rename reasonneverattendedschool_1 reasonneverattendedschool_fail
rename reasonneverattendedschool_2 reasonneverattendedschool_inac
rename reasonneverattendedschool_3 reasonneverattendedschool_qual
rename reasonneverattendedschool_4 reasonneverattendedschool_fina
rename reasonneverattendedschool_5 reasonneverattendedschool_heal
rename reasonneverattendedschool_6 reasonneverattendedschool_noin
rename reasonneverattendedschool_7 reasonneverattendedschool_care
rename reasonneverattendedschool_8 reasonneverattendedschool_work
rename reasonneverattendedschool_9 reasonneverattendedschool_girl
rename reasonneverattendedschool_10 reasonneverattendedschool_marr
rename reasonneverattendedschool_11 reasonneverattendedschool_noal
rename reasonneverattendedschool_12 reasonneverattendedschool_pube
rename reasonneverattendedschool_13 reasonneverattendedschool_baby
drop reasonneverattendedschool1 reasonneverattendedschool2
order reasonneverattendedschool_fail reasonneverattendedschool_inac reasonneverattendedschool_qual reasonneverattendedschool_fina reasonneverattendedschool_heal reasonneverattendedschool_noin reasonneverattendedschool_care reasonneverattendedschool_work reasonneverattendedschool_girl reasonneverattendedschool_marr reasonneverattendedschool_noal reasonneverattendedschool_pube reasonneverattendedschool_baby, after(reasonneverattendedschool)

ta reasondropping
replace reasondropping="" if reasondropping=="."
forvalues i=1/14 {
gen reasondropping_`i'=0 if reasondropping!=""
}
split reasondropping
forvalues i=1/14 {
replace reasondropping_`i'=1 if reasondropping1=="`i'"
replace reasondropping_`i'=1 if reasondropping2=="`i'"
label values reasondropping_`i' dummymigration
label var reasondropping_`i' "reasondropping=`i'"
}
rename reasondropping_1 reasondropping_stop
rename reasondropping_2 reasondropping_fail
rename reasondropping_3 reasondropping_inac
rename reasondropping_4 reasondropping_qual
rename reasondropping_5 reasondropping_fina
rename reasondropping_6 reasondropping_heal
rename reasondropping_7 reasondropping_noin
rename reasondropping_8 reasondropping_care
rename reasondropping_9 reasondropping_work
rename reasondropping_10 reasondropping_girl
rename reasondropping_11 reasondropping_marr
rename reasondropping_12 reasondropping_noal
rename reasondropping_13 reasondropping_pube
rename reasondropping_14 reasondropping_baby
drop reasondropping1 reasondropping2
order reasondropping_stop reasondropping_fail reasondropping_inac reasondropping_qual reasondropping_fina reasondropping_heal reasondropping_noin reasondropping_care reasondropping_work reasondropping_girl reasondropping_marr reasondropping_noal reasondropping_pube reasondropping_baby, after(reasondropping)



********** Migration
recode dummymigration (.=0)
tabulate migrantlist
replace migrantlist="" if migrantlist=="."
split migrantlist
destring migrantlist*, replace
gen migrantlistdummy=0 if dummymigration==1
replace migrantlistdummy=1 if INDID2016==migrantlist1
replace migrantlistdummy=1 if INDID2016==migrantlist2
replace migrantlistdummy=1 if INDID2016==migrantlist3
replace migrantlistdummy=1 if INDID2016==migrantlist4
replace migrantlistdummy=1 if INDID2016==migrantlist5
replace migrantlistdummy=1 if INDID2016==migrantlist6
replace migrantlistdummy=1 if INDID2016==migrantlist7
replace migrantlistdummy=1 if INDID2016==migrantlist8
replace migrantlistdummy=1 if INDID2016==migrantlist9
replace migrantlistdummy=1 if INDID2016==migrantlist10
replace migrantlistdummy=1 if INDID2016==migrantlist11
replace migrantlistdummy=1 if INDID2016==migrantlist12
replace migrantlistdummy=1 if INDID2016==migrantlist13
label values migrantlistdummy dummyinsurance
ta migrantlistdummy
order migrantlistdummy, after(dummymigration)
drop migrantlist1 migrantlist2 migrantlist3 migrantlist4 migrantlist5 migrantlist6 migrantlist7 migrantlist8 migrantlist9 migrantlist10 migrantlist11 migrantlist12 migrantlist13


********** Why migration?
preserve
use"NEEMSIS1-migrations", clear
keep HHID2016 INDID2016 migrationjobid
bysort HHID2016 INDID2016: gen n=_n
reshape wide migrationjobid, i(HHID2016 INDID2016) j(n)
rename migrationjobid1 migrationjoblist1
rename migrationjobid2 migrationjoblist2
save"_temp/_tempmig", replace
restore
merge 1:1 HHID2016 INDID2016 using "_temp/_tempmig"
drop _merge
order migrationjoblist1 migrationjoblist2, after(migrantlistdummy)




********** Remittances sent
tabulate remsenderlist
replace remsenderlist="" if remsenderlist=="."
split remsenderlist
destring remsenderlist*, replace
gen remsenderlistdummy=0 if dummyremsent==1
replace remsenderlistdummy=1 if INDID2016== remsenderlist1
replace remsenderlistdummy=1 if INDID2016== remsenderlist2
label values remsenderlistdummy dummyinsurance
ta remsenderlistdummy
order remsenderlistdummy, after(remsenderlist)
drop remsenderlist1 remsenderlist2

tostring remsentoccupother2, replace
replace remsentoccupother2="" if remsentoccupother2=="."

ta remsentservices1
split remsentservices1
destring remsentservices11 remsentservices12 remsentservices13, replace
recode remsentservices11 remsentservices12 remsentservices13 (77=6)
forvalues i=1/6 {
gen remsentservices_`i'1=0 if remsentservices1!=""
}
forvalues i=1/6 {
replace remsentservices_`i'1=1 if remsentservices11==`i'
replace remsentservices_`i'1=1 if remsentservices12==`i'
replace remsentservices_`i'1=1 if remsentservices13==`i'
label values remsentservices_`i'1 dummymigration
label var remsentservices_`i'1 "remsentservices=`i'"
}
rename remsentservices_11 remsentservices_poli1
rename remsentservices_21 remsentservices_fina1
rename remsentservices_31 remsentservices_guar1
rename remsentservices_41 remsentservices_gene1
rename remsentservices_51 remsentservices_none1
rename remsentservices_61 remsentservices_othe1
drop remsentservices11 remsentservices12 remsentservices13
order remsentservices_poli1 remsentservices_fina1 remsentservices_guar1 remsentservices_gene1 remsentservices_none1 remsentservices_othe1, after(remsentservices1)

ta remsentservices2
split remsentservices2
destring remsentservices21 remsentservices22, replace
recode remsentservices21 remsentservices22 (77=6)
forvalues i=1/6 {
gen remsentservices_`i'2=0 if remsentservices2!=""
}
forvalues i=1/6 {
replace remsentservices_`i'2=1 if remsentservices21==`i'
replace remsentservices_`i'2=1 if remsentservices22==`i'
label values remsentservices_`i'2 dummymigration
label var remsentservices_`i'2 "remsentservices=`i'"
}
rename remsentservices_12 remsentservices_poli2
rename remsentservices_22 remsentservices_fina2
rename remsentservices_32 remsentservices_guar2
rename remsentservices_42 remsentservices_gene2
rename remsentservices_52 remsentservices_none2
rename remsentservices_62 remsentservices_othe2
drop remsentservices21 remsentservices22
order remsentservices_poli2 remsentservices_fina2 remsentservices_guar2 remsentservices_gene2 remsentservices_none2 remsentservices_othe2, after(remsentservices2)





********** Remittances received
tabulate remreceivedlist
replace remreceivedlist="" if remreceivedlist=="."
split remreceivedlist
destring remreceivedlist*, replace
gen remreceivedlistdummy=0 if dummyremreceived==1
replace remreceivedlistdummy=1 if INDID2016==remreceivedlist1
replace remreceivedlistdummy=1 if INDID2016==remreceivedlist2
label values remreceivedlistdummy dummyinsurance
ta remreceivedlistdummy
order remreceivedlistdummy, after(dummyremreceived)
drop remreceivedlist1 remreceivedlist2

label define demoremreceived 1"More" 2"Less" 3"Same"
label values demoremreceived1 demoremreceived
label values demoremreceived2 demoremreceived

ta remreceivedservices1
split remreceivedservices1
destring remreceivedservices1*, replace
recode remreceivedservices11 remreceivedservices12 remreceivedservices13 (77=6)
forvalues i=1/6 {
gen remreceivedservices_`i'1=0 if remreceivedservices1!=""
}
forvalues i=1/6 {
replace remreceivedservices_`i'1=1 if remreceivedservices11==`i'
replace remreceivedservices_`i'1=1 if remreceivedservices12==`i'
replace remreceivedservices_`i'1=1 if remreceivedservices13==`i'
label values remreceivedservices_`i'1 dummymigration
label var remreceivedservices_`i'1 "remreceivedservices=`i'"
}
rename remreceivedservices_11 remreceivedservices_poli1
rename remreceivedservices_21 remreceivedservices_fina1
rename remreceivedservices_31 remreceivedservices_guar1
rename remreceivedservices_41 remreceivedservices_gene1
rename remreceivedservices_51 remreceivedservices_none1
rename remreceivedservices_61 remreceivedservices_othe1
drop remreceivedservices11 remreceivedservices12 remreceivedservices13
order remreceivedservices_poli1 remreceivedservices_fina1 remreceivedservices_guar1 remreceivedservices_gene1 remreceivedservices_none1 remreceivedservices_othe1, after(remreceivedservices1)

ta remreceivedservices2
split remreceivedservices2
destring remreceivedservices21 remreceivedservices22 remreceivedservices23, replace
recode remreceivedservices21 remreceivedservices22 remreceivedservices23 (77=6)
forvalues i=1/6 {
gen remreceivedservices_`i'2=0 if remreceivedservices2!=""
}
forvalues i=1/6 {
replace remreceivedservices_`i'2=1 if remreceivedservices21==`i'
replace remreceivedservices_`i'2=1 if remreceivedservices22==`i'
replace remreceivedservices_`i'2=1 if remreceivedservices23==`i'
label values remreceivedservices_`i'2 dummymigration
label var remreceivedservices_`i'2 "remreceivedservices=`i'"
}
rename remreceivedservices_12 remreceivedservices_poli2
rename remreceivedservices_22 remreceivedservices_fina2
rename remreceivedservices_32 remreceivedservices_guar2
rename remreceivedservices_42 remreceivedservices_gene2
rename remreceivedservices_52 remreceivedservices_none2
rename remreceivedservices_62 remreceivedservices_othe2
drop remreceivedservices21 remreceivedservices22 remreceivedservices23
order remreceivedservices_poli2 remreceivedservices_fina2 remreceivedservices_guar2 remreceivedservices_gene2 remreceivedservices_none2 remreceivedservices_othe2, after(remreceivedservices2)




********** Gifts received
tabulate giftsrecipientlist
destring giftsrecipientlist, replace
gen giftsrecipientlistdummy=0 if dummygiftsreceived==1
replace giftsrecipientlistdummy=1 if INDID2016==giftsrecipientlist
label values giftsrecipientlistdummy dummyinsurance
label values dummygiftsreceived dummyinsurance
ta giftsrecipientlistdummy
order giftsrecipientlistdummy, after(dummygiftsreceived)

ta giftoccasion_WKP
ta giftoccasion_rel
ta giftoccasion_emp
ta giftoccasion_friends

label define giftoccasion 1"Pongal" 2"Birthday function" 3"New house" 4"Puberty" 5"Just like that" 77"Oth"
destring giftoccasion_WKP giftoccasion_rel giftoccasion_emp giftoccasion_friends, replace
label values giftoccasion_WKP giftoccasion
label values giftoccasion_rel giftoccasion
label values giftoccasion_friends giftoccasion

foreach y in WKP rel friends {
gen giftoccasion_pongal_`y'=0 if giftoccasion_`y'!=.
replace giftoccasion_pongal_`y'=1 if giftoccasion_`y'==1
gen giftoccasion_birth_`y'=0 if giftoccasion_`y'!=.
replace giftoccasion_birth_`y'=1 if giftoccasion_`y'==2
gen giftoccasion_house_`y'=0 if giftoccasion_`y'!=.
replace giftoccasion_house_`y'=1 if giftoccasion_`y'==3
gen giftoccasion_pube_`y'=0 if giftoccasion_`y'!=.
replace giftoccasion_pube_`y'=1 if giftoccasion_`y'==4
gen giftoccasion_just_`y'=0 if giftoccasion_`y'!=.
replace giftoccasion_just_`y'=1 if giftoccasion_`y'==5
gen giftoccasion_other_`y'=0 if giftoccasion_`y'!=.
replace giftoccasion_other_`y'=1 if giftoccasion_`y'==77
}


foreach x in WKP rel friends {
label values giftoccasion_pongal_`x' dummymigration
label var giftoccasion_pongal_`x' "giftoccasion_`x'=1"
label values giftoccasion_birth_`x' dummymigration
label var giftoccasion_birth_`x' "giftoccasion_`x'=2"
label values giftoccasion_house_`x' dummymigration
label var giftoccasion_house_`x' "giftoccasion_`x'=3"
label values giftoccasion_pube_`x' dummymigration
label var giftoccasion_pube_`x' "giftoccasion_`x'=4"
label values giftoccasion_just_`x' dummymigration
label var giftoccasion_just_`x' "giftoccasion_`x'=5"
label values giftoccasion_other_`x' dummymigration
label var giftoccasion_other_`x' "giftoccasion_`x'=77"
}



* emp
ta giftoccasion_emp
split giftoccasion_emp
destring giftoccasion_emp1 giftoccasion_emp2 giftoccasion_emp3, replace
recode giftoccasion_emp1 giftoccasion_emp2 giftoccasion_emp3 (77=6)
forvalues i=1/6 {
gen giftoccasion_`i'_emp=0 if giftoccasion_emp!=""
}
forvalues i=1/6 {
replace giftoccasion_`i'_emp=1 if giftoccasion_emp1==`i'
replace giftoccasion_`i'_emp=1 if giftoccasion_emp2==`i'
replace giftoccasion_`i'_emp=1 if giftoccasion_emp3==`i'
label values giftoccasion_`i'_emp dummymigration
label var giftoccasion_`i'_emp "giftoccasion_emp=`i'"
}
rename giftoccasion_1_emp giftoccasion_pongal_emp
rename giftoccasion_2_emp giftoccasion_birth_emp
rename giftoccasion_3_emp giftoccasion_house_emp
rename giftoccasion_4_emp giftoccasion_pube_emp
rename giftoccasion_5_emp giftoccasion_just_emp
rename giftoccasion_6_emp giftoccasion_other_emp
drop giftoccasion_emp1 giftoccasion_emp2 giftoccasion_emp3

order giftoccasion_pongal_WKP giftoccasion_birth_WKP giftoccasion_house_WKP giftoccasion_pube_WKP giftoccasion_just_WKP giftoccasion_other_WKP giftoccasion_pongal_rel giftoccasion_birth_rel giftoccasion_house_rel giftoccasion_pube_rel giftoccasion_just_rel giftoccasion_other_rel giftoccasion_pongal_friends giftoccasion_birth_friends giftoccasion_house_friends giftoccasion_pube_friends giftoccasion_just_friends giftoccasion_other_friends giftoccasion_pongal_emp giftoccasion_birth_emp giftoccasion_house_emp giftoccasion_pube_emp giftoccasion_just_emp giftoccasion_other_emp, after(giftoccasion_friends)



********** Loans list
ta borrowerlist
split borrowerlist
destring borrowerlist1 borrowerlist2 borrowerlist3 borrowerlist4, replace
gen borrowerlistdummy=0 if dummyloans==1
replace borrowerlistdummy=1 if borrowerlist1==INDID2016
replace borrowerlistdummy=1 if borrowerlist2==INDID2016
replace borrowerlistdummy=1 if borrowerlist3==INDID2016
replace borrowerlistdummy=1 if borrowerlist4==INDID2016
label values borrowerlistdummy dummyinsurance
drop borrowerlist1 borrowerlist2 borrowerlist3 borrowerlist4
order borrowerlistdummy, after(borrowerlist)



********** Lender list
ta hhlenderlist
destring hhlenderlist, replace
gen hhlenderlistdummy=0 if dummylendingmoney==1
replace hhlenderlistdummy=1 if hhlenderlist==INDID2016
label values hhlenderlistdummy dummyinsurance
order hhlenderlistdummy, after(hhlenderlist)

ta relationwithborrower
split relationwithborrower, destring
forvalues i=1/15 {
gen relationwithborrower_`i'=0 if relationwithborrower!=""
}
forvalues i=1/15 {
replace relationwithborrower_`i'=1 if relationwithborrower1==`i'
replace relationwithborrower_`i'=1 if relationwithborrower2==`i'
replace relationwithborrower_`i'=1 if relationwithborrower3==`i'
replace relationwithborrower_`i'=1 if relationwithborrower4==`i'
label values relationwithborrower_`i' dummyinsurance
label var relationwithborrower_`i' "relationwithborrower=`i'"
}
rename relationwithborrower_1 relationwithborrower_mais
rename relationwithborrower_2 relationwithborrower_chil
rename relationwithborrower_3 relationwithborrower_sibl
rename relationwithborrower_4 relationwithborrower_pare
rename relationwithborrower_5 relationwithborrower_niec
rename relationwithborrower_6 relationwithborrower_othe
rename relationwithborrower_7 relationwithborrower_neig
rename relationwithborrower_8 relationwithborrower_frie
rename relationwithborrower_9 relationwithborrower_cust
rename relationwithborrower_10 relationwithborrower_mone
rename relationwithborrower_11 relationwithborrower_shg
rename relationwithborrower_12 relationwithborrower_empl
rename relationwithborrower_13 relationwithborrower_wkp
rename relationwithborrower_14 relationwithborrower_own
rename relationwithborrower_15 relationwithborrower_spou
drop relationwithborrower1 relationwithborrower2 relationwithborrower3 relationwithborrower4
order relationwithborrower_mais relationwithborrower_chil relationwithborrower_sibl relationwithborrower_pare relationwithborrower_niec relationwithborrower_othe relationwithborrower_neig relationwithborrower_frie relationwithborrower_cust relationwithborrower_mone relationwithborrower_shg relationwithborrower_empl relationwithborrower_wkp relationwithborrower_own relationwithborrower_spou, after(relationwithborrower)

format datelendingmoney %td
ta datelendingmoney

label define demolendingkind 1"Old notes" 2"New notes" 3"Both" 4"Transfer"
label values demolendingkind demolendingkind

label define demotermslending 1"Weekly" 2"Monthly" 3"Yearly" 4"Once in 6 months" 5"Whenever I ask" 6"When the borrower has money"
label values demotermslending demotermslending

label values demodummyrepaylending dummyinsurance

replace demorepaytermslending="" if demorepaytermslending=="."
split demorepaytermslending, destring
forvalues i=1/5{
gen demorepaytermslending_`i'=0 if demorepaytermslending!=""
}
forvalues i=1/5{
replace demorepaytermslending_`i'=1 if demorepaytermslending1==`i'
replace demorepaytermslending_`i'=1 if demorepaytermslending2==`i'
label var demorepaytermslending_`i' "demorepaytermslending=`i'"
label values demorepaytermslending_`i' dummyinsurance
}
rename demorepaytermslending_1 demorepaytermslending_payless
rename demorepaytermslending_2 demorepaytermslending_freqext
rename demorepaytermslending_3 demorepaytermslending_stopped
rename demorepaytermslending_4 demorepaytermslending_partial
rename demorepaytermslending_5 demorepaytermslending_totally
drop demorepaytermslending1 demorepaytermslending2
order demorepaytermslending_payless demorepaytermslending_freqext demorepaytermslending_stopped demorepaytermslending_partial demorepaytermslending_totally, after(demorepaytermslending)

label define demointerestlending 1"Lower interest rate than before" 2"Same interest rate than before" 3"Higher interest rate than before" 4"Along with commission"
label values demointerestlending demointerestlending




********** Recommend given
gen recommendgivenlistdummy=0 if dummyrecommendgiven==1
replace recommendgivenlistdummy=1 if recommendgivenlist==INDID2016
label values recommendgivenlistdummy dummyinsurance
order recommendgivenlistdummy, after(recommendgivenlist)
ta recommendgivenlistdummy

label define recommendgivenrelation 5"Niece/Nephew not living in the house" 13"WKP"
label values recommendgivenrelation recommendgivenrelation

label define recommendgivenlender 1"WKP" 2"Relatives" 8"Finance"
label values recommendgivenlender recommendgivenlender



********** Chitfund
ta chitfundbelongerlist
replace chitfundbelongerlist="" if chitfundbelongerlist=="."
split chitfundbelongerlist, destring
gen chitfundbelongerlistdummy=0 if dummychitfund==1
replace chitfundbelongerlistdummy=1 if chitfundbelongerlist1==INDID2016
replace chitfundbelongerlistdummy=1 if chitfundbelongerlist2==INDID2016
drop chitfundbelongerlist1 chitfundbelongerlist2
label values chitfundbelongerlistdummy dummyinsurance
ta chitfundbelongerlistdummy



********** Savings
recode dummysavingaccount (.=0)

ta savingsownerlist
replace savingsownerlist="" if savingsownerlist=="."
split savingsownerlist, destring 
gen savingsownerlistdummy=0 if dummysavingaccount==1
replace savingsownerlistdummy=1 if savingsownerlist1==INDID2016
replace savingsownerlistdummy=1 if savingsownerlist2==INDID2016
replace savingsownerlistdummy=1 if savingsownerlist3==INDID2016
replace savingsownerlistdummy=1 if savingsownerlist4==INDID2016
replace savingsownerlistdummy=1 if savingsownerlist5==INDID2016
replace savingsownerlistdummy=1 if savingsownerlist6==INDID2016
replace savingsownerlistdummy=1 if savingsownerlist7==INDID2016
replace savingsownerlistdummy=1 if savingsownerlist8==INDID2016
label values savingsownerlistdummy dummyinsurance
drop savingsownerlist1 savingsownerlist2 savingsownerlist3 savingsownerlist4 savingsownerlist5 savingsownerlist6 savingsownerlist7 savingsownerlist8
order savingsownerlistdummy, after(savingsownerlist)

foreach x in savingspurpose4 usedebitcard3 usedebitcard4 demousecreditcard2 {
tostring `x', replace
replace `x'="" if `x'=="."
}



***** Correction
preserve
use"NEEMSIS1-HH", clear

foreach x in savingspurpose4 usedebitcard3 usedebitcard4 demousecreditcard2 {
tostring `x', replace
replace `x'="" if `x'=="."
}



keep HHID2016 INDID2016 savingsaccounttype* savingsjointaccount* savingsaccountdate* banktype* savingsbankname* savingsbankplace* savingsamount* savingspurpose* dummydebitcard* dummycreditcard* datedebitcard* usedebitcard* reasonnotusedebitcard* demousedebitcard* demousecreditcard* datecreditcard* usecreditcard*
reshape long savingsaccounttype savingsjointaccount savingsaccountdate banktype savingsbankname savingsbankplace savingsamount savingspurpose dummydebitcard dummycreditcard datedebitcard usedebitcard reasonnotusedebitcard demousedebitcard demousecreditcard datecreditcard usecreditcard, i(HHID2016 INDID2016) j(n)
drop if savingsaccounttype==.


format savingsaccountdate %td
format datedebitcard %td
format datecreditcard %td


*** purpose
ta savingspurpose
split savingspurpose, destring
forvalues i=1/6 {
gen savingspurpose_`i'=0 if savingspurpose!=""
}
forvalues i=1/6 {
replace savingspurpose_`i'=1 if savingspurpose1==`i'
replace savingspurpose_`i'=1 if savingspurpose2==`i'
replace savingspurpose_`i'=1 if savingspurpose3==`i'
replace savingspurpose_`i'=1 if savingspurpose4==`i'
replace savingspurpose_`i'=1 if savingspurpose5==`i'
replace savingspurpose_`i'=1 if savingspurpose6==`i'
label var savingspurpose_`i' "savingspurpose=`i'"
label values savingspurpose_`i' dummyinsurance
}
rename savingspurpose_1 savingspurpose_sav
rename savingspurpose_2 savingspurpose_jew
rename savingspurpose_3 savingspurpose_rec
rename savingspurpose_4 savingspurpose_cro
rename savingspurpose_5 savingspurpose_sug
rename savingspurpose_6 savingspurpose_sch
drop savingspurpose1 savingspurpose2 savingspurpose3 savingspurpose4 savingspurpose5 savingspurpose6
order savingspurpose_sav savingspurpose_jew savingspurpose_rec savingspurpose_cro savingspurpose_sug savingspurpose_sch, after(savingspurpose)


*** usedebitcard
ta usedebitcard
replace usedebitcard="" if usedebitcard=="."
split usedebitcard, destring
recode usedebitcard1 usedebitcard2 usedebitcard3 usedebitcard4 usedebitcard5 (77=7)
forvalues i=1/7 {
gen usedebitcard_`i'=0 if usedebitcard!=""
}
forvalues i=1/7 {
replace usedebitcard_`i'=1 if usedebitcard1==`i'
replace usedebitcard_`i'=1 if usedebitcard2==`i'
replace usedebitcard_`i'=1 if usedebitcard3==`i'
replace usedebitcard_`i'=1 if usedebitcard4==`i'
replace usedebitcard_`i'=1 if usedebitcard5==`i'
label var usedebitcard_`i' "usedebitcard=`i'"
label values usedebitcard_`i' dummyinsurance
}
rename usedebitcard_1 usedebitcard_neve
rename usedebitcard_2 usedebitcard_atm
rename usedebitcard_3 usedebitcard_shop
rename usedebitcard_4 usedebitcard_tran
rename usedebitcard_5 usedebitcard_onli
rename usedebitcard_6 usedebitcard_mobi
rename usedebitcard_7 usedebitcard_othe
drop usedebitcard1 usedebitcard2 usedebitcard3 usedebitcard4 usedebitcard5
order usedebitcard_neve usedebitcard_atm usedebitcard_shop usedebitcard_tran usedebitcard_onli usedebitcard_mobi usedebitcard_othe, after(usedebitcard)



*** reasonnotusedebitcard
ta reasonnotusedebitcard
replace reasonnotusedebitcard="" if reasonnotusedebitcard=="."
split reasonnotusedebitcard, destring
forvalues i=1/6 {
gen reasonnotusedebitcard_`i'=0 if reasonnotusedebitcard!=""
}
forvalues i=1/6 {
replace reasonnotusedebitcard_`i'=1 if reasonnotusedebitcard1==`i'
replace reasonnotusedebitcard_`i'=1 if reasonnotusedebitcard2==`i'
label var reasonnotusedebitcard_`i' "reasonnotusedebitcard=`i'"
label values reasonnotusedebitcard_`i' dummyinsurance
}
rename reasonnotusedebitcard_1 reasonnotusedebitcard_none
rename reasonnotusedebitcard_2 reasonnotusedebitcard_dist
rename reasonnotusedebitcard_3 reasonnotusedebitcard_cash
rename reasonnotusedebitcard_4 reasonnotusedebitcard_flex
rename reasonnotusedebitcard_5 reasonnotusedebitcard_diff
rename reasonnotusedebitcard_6 reasonnotusedebitcard_afra
drop reasonnotusedebitcard1 reasonnotusedebitcard2
order reasonnotusedebitcard_none reasonnotusedebitcard_dist reasonnotusedebitcard_cash reasonnotusedebitcard_flex reasonnotusedebitcard_diff reasonnotusedebitcard_afra, after(reasonnotusedebitcard)


*** demousedebitcard
ta demousedebitcard
replace demousedebitcard="" if demousedebitcard=="."
split demousedebitcard, destring
recode demousedebitcard1 demousedebitcard2 demousedebitcard3 demousedebitcard4 demousedebitcard5 (77=9)
forvalues i=1/9 {
gen demousedebitcard_`i'=0 if demousedebitcard!=""
}
forvalues i=1/9 {
replace demousedebitcard_`i'=1 if demousedebitcard1==`i'
replace demousedebitcard_`i'=1 if demousedebitcard2==`i'
replace demousedebitcard_`i'=1 if demousedebitcard3==`i'
replace demousedebitcard_`i'=1 if demousedebitcard4==`i'
replace demousedebitcard_`i'=1 if demousedebitcard5==`i'
label var demousedebitcard_`i' "demousedebitcard=`i'"
label values demousedebitcard_`i' dummyinsurance
}
rename demousedebitcard_1 demousedebitcard_same
rename demousedebitcard_2 demousedebitcard_nonov
rename demousedebitcard_3 demousedebitcard_neve
rename demousedebitcard_4 demousedebitcard_atm
rename demousedebitcard_5 demousedebitcard_shop
rename demousedebitcard_6 demousedebitcard_tran
rename demousedebitcard_7 demousedebitcard_onli
rename demousedebitcard_8 demousedebitcard_mobi
rename demousedebitcard_9 demousedebitcard_other
drop demousedebitcard1 demousedebitcard2 demousedebitcard3 demousedebitcard4 demousedebitcard5
order demousedebitcard_same demousedebitcard_nonov demousedebitcard_neve demousedebitcard_atm demousedebitcard_shop demousedebitcard_tran demousedebitcard_onli demousedebitcard_mobi demousedebitcard_other, after(demousedebitcard)


*** demousecreditcard
ta demousecreditcard
replace demousecreditcard="" if demousecreditcard=="."
split demousecreditcard, destring
forvalues i=1/8 {
gen demousecreditcard_`i'=0 if demousecreditcard!=""
}
forvalues i=1/8 {
replace demousecreditcard_`i'=1 if demousecreditcard1==`i'
replace demousecreditcard_`i'=1 if demousecreditcard2==`i'
label var demousecreditcard_`i' "demousecreditcard=`i'"
label values demousecreditcard_`i' dummyinsurance
}
rename demousecreditcard_1 demousecreditcard_same
rename demousecreditcard_2 demousecreditcard_nonov
rename demousecreditcard_3 demousecreditcard_neve
rename demousecreditcard_4 demousecreditcard_atm
rename demousecreditcard_5 demousecreditcard_shop
rename demousecreditcard_6 demousecreditcard_tran
rename demousecreditcard_7 demousecreditcard_onli
rename demousecreditcard_8 demousecreditcard_mobi
drop demousecreditcard1 demousecreditcard2
order demousecreditcard_same demousecreditcard_nonov demousecreditcard_neve demousecreditcard_atm demousecreditcard_shop demousecreditcard_tran demousecreditcard_onli demousecreditcard_mobi, after(demousecreditcard)


** label usecreditcard
ta usecreditcard
label define usecreditcard 2"To get cash in ATM"
label values usecreditcard usecreditcard


*** Reshape
reshape wide savingsaccounttype banktype savingsbankname savingsbankplace savingsamount savingspurpose savingspurpose_sav savingspurpose_jew savingspurpose_rec savingspurpose_cro savingspurpose_sug savingspurpose_sch dummydebitcard dummycreditcard datedebitcard usedebitcard usedebitcard_neve usedebitcard_atm usedebitcard_shop usedebitcard_tran usedebitcard_onli usedebitcard_mobi usedebitcard_othe savingsjointaccount savingsaccountdate reasonnotusedebitcard reasonnotusedebitcard_none reasonnotusedebitcard_dist reasonnotusedebitcard_cash reasonnotusedebitcard_flex reasonnotusedebitcard_diff reasonnotusedebitcard_afra demousedebitcard demousedebitcard_same demousedebitcard_nonov demousedebitcard_neve demousedebitcard_atm demousedebitcard_shop demousedebitcard_tran demousedebitcard_onli demousedebitcard_mobi demousedebitcard_other demousecreditcard demousecreditcard_same demousecreditcard_nonov demousecreditcard_neve demousecreditcard_atm demousecreditcard_shop demousecreditcard_tran demousecreditcard_onli demousecreditcard_mobi datecreditcard usecreditcard, i(HHID2016 INDID2016) j(n)

save"_temp/_tempsaving", replace
restore


*** Drop
drop savingsaccounttype1 savingsaccounttype2 savingsaccounttype3 savingsaccounttype4 savingsjointaccount1 savingsjointaccount2 savingsaccountdate1 savingsaccountdate2 savingsaccountdate3 banktype1 banktype2 banktype3 banktype4 savingsbankname1 savingsbankname2 savingsbankname3 savingsbankname4 savingsbankplace1 savingsbankplace2 savingsbankplace3 savingsbankplace4 savingsamount1 savingsamount2 savingsamount3 savingsamount4 savingspurpose1 savingspurpose2 savingspurpose3 savingspurpose4 dummydebitcard1 dummydebitcard2 dummydebitcard3 dummydebitcard4 dummycreditcard1 dummycreditcard2 dummycreditcard3 dummycreditcard4 datedebitcard1 datedebitcard2 datedebitcard3 datedebitcard4 usedebitcard1 usedebitcard2 usedebitcard3 usedebitcard4 reasonnotusedebitcard1 demousedebitcard1 demousedebitcard2 datecreditcard1 usecreditcard1 demousecreditcard1 demousecreditcard2

merge 1:1 HHID2016 INDID2016 using "_temp/_tempsaving"
drop _merge
order savingsaccounttype1 banktype1 savingsbankname1 savingsbankplace1 savingsamount1 savingspurpose1 savingspurpose_sav1 savingspurpose_jew1 savingspurpose_rec1 savingspurpose_cro1 savingspurpose_sug1 savingspurpose_sch1 dummydebitcard1 dummycreditcard1 datedebitcard1 usedebitcard1 usedebitcard_neve1 usedebitcard_atm1 usedebitcard_shop1 usedebitcard_tran1 usedebitcard_onli1 usedebitcard_mobi1 usedebitcard_othe1 savingsjointaccount1 savingsaccountdate1 reasonnotusedebitcard1 reasonnotusedebitcard_none1 reasonnotusedebitcard_dist1 reasonnotusedebitcard_cash1 reasonnotusedebitcard_flex1 reasonnotusedebitcard_diff1 reasonnotusedebitcard_afra1 demousedebitcard1 demousedebitcard_same1 demousedebitcard_nonov1 demousedebitcard_neve1 demousedebitcard_atm1 demousedebitcard_shop1 demousedebitcard_tran1 demousedebitcard_onli1 demousedebitcard_mobi1 demousedebitcard_other1 demousecreditcard1 demousecreditcard_same1 demousecreditcard_nonov1 demousecreditcard_neve1 demousecreditcard_atm1 demousecreditcard_shop1 demousecreditcard_tran1 demousecreditcard_onli1 demousecreditcard_mobi1 datecreditcard1 usecreditcard1 savingsaccounttype2 banktype2 savingsbankname2 savingsbankplace2 savingsamount2 savingspurpose2 savingspurpose_sav2 savingspurpose_jew2 savingspurpose_rec2 savingspurpose_cro2 savingspurpose_sug2 savingspurpose_sch2 dummydebitcard2 dummycreditcard2 datedebitcard2 usedebitcard2 usedebitcard_neve2 usedebitcard_atm2 usedebitcard_shop2 usedebitcard_tran2 usedebitcard_onli2 usedebitcard_mobi2 usedebitcard_othe2 savingsjointaccount2 savingsaccountdate2 reasonnotusedebitcard2 reasonnotusedebitcard_none2 reasonnotusedebitcard_dist2 reasonnotusedebitcard_cash2 reasonnotusedebitcard_flex2 reasonnotusedebitcard_diff2 reasonnotusedebitcard_afra2 demousedebitcard2 demousedebitcard_same2 demousedebitcard_nonov2 demousedebitcard_neve2 demousedebitcard_atm2 demousedebitcard_shop2 demousedebitcard_tran2 demousedebitcard_onli2 demousedebitcard_mobi2 demousedebitcard_other2 demousecreditcard2 demousecreditcard_same2 demousecreditcard_nonov2 demousecreditcard_neve2 demousecreditcard_atm2 demousecreditcard_shop2 demousecreditcard_tran2 demousecreditcard_onli2 demousecreditcard_mobi2 datecreditcard2 usecreditcard2 savingsaccounttype3 banktype3 savingsbankname3 savingsbankplace3 savingsamount3 savingspurpose3 savingspurpose_sav3 savingspurpose_jew3 savingspurpose_rec3 savingspurpose_cro3 savingspurpose_sug3 savingspurpose_sch3 dummydebitcard3 dummycreditcard3 datedebitcard3 usedebitcard3 usedebitcard_neve3 usedebitcard_atm3 usedebitcard_shop3 usedebitcard_tran3 usedebitcard_onli3 usedebitcard_mobi3 usedebitcard_othe3 savingsjointaccount3 savingsaccountdate3 reasonnotusedebitcard3 reasonnotusedebitcard_none3 reasonnotusedebitcard_dist3 reasonnotusedebitcard_cash3 reasonnotusedebitcard_flex3 reasonnotusedebitcard_diff3 reasonnotusedebitcard_afra3 demousedebitcard3 demousedebitcard_same3 demousedebitcard_nonov3 demousedebitcard_neve3 demousedebitcard_atm3 demousedebitcard_shop3 demousedebitcard_tran3 demousedebitcard_onli3 demousedebitcard_mobi3 demousedebitcard_other3 demousecreditcard3 demousecreditcard_same3 demousecreditcard_nonov3 demousecreditcard_neve3 demousecreditcard_atm3 demousecreditcard_shop3 demousecreditcard_tran3 demousecreditcard_onli3 demousecreditcard_mobi3 datecreditcard3 usecreditcard3 savingsaccounttype4 banktype4 savingsbankname4 savingsbankplace4 savingsamount4 savingspurpose4 savingspurpose_sav4 savingspurpose_jew4 savingspurpose_rec4 savingspurpose_cro4 savingspurpose_sug4 savingspurpose_sch4 dummydebitcard4 dummycreditcard4 datedebitcard4 usedebitcard4 usedebitcard_neve4 usedebitcard_atm4 usedebitcard_shop4 usedebitcard_tran4 usedebitcard_onli4 usedebitcard_mobi4 usedebitcard_othe4 savingsjointaccount4 savingsaccountdate4 reasonnotusedebitcard4 reasonnotusedebitcard_none4 reasonnotusedebitcard_dist4 reasonnotusedebitcard_cash4 reasonnotusedebitcard_flex4 reasonnotusedebitcard_diff4 reasonnotusedebitcard_afra4 demousedebitcard4 demousedebitcard_same4 demousedebitcard_nonov4 demousedebitcard_neve4 demousedebitcard_atm4 demousedebitcard_shop4 demousedebitcard_tran4 demousedebitcard_onli4 demousedebitcard_mobi4 demousedebitcard_other4 demousecreditcard4 demousecreditcard_same4 demousecreditcard_nonov4 demousecreditcard_neve4 demousecreditcard_atm4 demousecreditcard_shop4 demousecreditcard_tran4 demousecreditcard_onli4 demousecreditcard_mobi4 datecreditcard4 usecreditcard4, after(nbsavingaccounts)



********** Gold
recode dummygold (.=0)
ta goldownerlist
split goldownerlist, destring
gen goldownerlistdummy=0 if dummygold==1
replace goldownerlistdummy=1 if goldownerlist1==INDID2016
replace goldownerlistdummy=1 if goldownerlist2==INDID2016
replace goldownerlistdummy=1 if goldownerlist3==INDID2016
replace goldownerlistdummy=1 if goldownerlist4==INDID2016
replace goldownerlistdummy=1 if goldownerlist5==INDID2016
replace goldownerlistdummy=1 if goldownerlist6==INDID2016
label values goldownerlistdummy dummyinsurance
drop goldownerlist1 goldownerlist2 goldownerlist3 goldownerlist4 goldownerlist5 goldownerlist6
order goldownerlistdummy, after(goldownerlist)


*
replace demogoldreasonbuy="" if demogoldreasonbuy=="."
split demogoldreasonbuy, destring
recode demogoldreasonbuy1 demogoldreasonbuy2 (77=6)
forvalues i=1/6 {
gen demogoldreasonbuy_`i'=0 if demogoldreasonbuy!=""
}
forvalues i=1/6 {
replace demogoldreasonbuy_`i'=1 if demogoldreasonbuy1==`i'
replace demogoldreasonbuy_`i'=1 if demogoldreasonbuy2==`i'
label var demogoldreasonbuy_`i' "demogoldreasonbuy=`i'"
label values demogoldreasonbuy_`i' dummyinsurance
}
rename demogoldreasonbuy_1 demogoldreasonbuy_savi
rename demogoldreasonbuy_2 demogoldreasonbuy_rido
rename demogoldreasonbuy_3 demogoldreasonbuy_gift
rename demogoldreasonbuy_4 demogoldreasonbuy_sell
rename demogoldreasonbuy_5 demogoldreasonbuy_spec
rename demogoldreasonbuy_6 demogoldreasonbuy_othe
drop demogoldreasonbuy1 demogoldreasonbuy2
order demogoldreasonbuy_savi demogoldreasonbuy_rido demogoldreasonbuy_gift demogoldreasonbuy_sell demogoldreasonbuy_spec demogoldreasonbuy_othe, after(demogoldreasonbuy)


*** goldreasonpledge
ta goldreasonpledge
replace goldreasonpledge="" if goldreasonpledge=="."
split goldreasonpledge, destring
forvalues i=1/12 {
gen goldreasonpledge_`i'=0 if goldreasonpledge!=""
}
forvalues i=1/12 {
replace goldreasonpledge_`i'=1 if goldreasonpledge1==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge2==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge3==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge4==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge5==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge6==`i'
label var goldreasonpledge_`i' "goldreasonpledge=`i'"
label values goldreasonpledge_`i' dummyinsurance
}
rename goldreasonpledge_1 goldreasonpledge_agri
rename goldreasonpledge_2 goldreasonpledge_fami
rename goldreasonpledge_3 goldreasonpledge_heal
rename goldreasonpledge_4 goldreasonpledge_repa
rename goldreasonpledge_5 goldreasonpledge_hous
rename goldreasonpledge_6 goldreasonpledge_inve
rename goldreasonpledge_7 goldreasonpledge_cere
rename goldreasonpledge_8 goldreasonpledge_marr
rename goldreasonpledge_9 goldreasonpledge_educ
rename goldreasonpledge_10 goldreasonpledge_rela
rename goldreasonpledge_11 goldreasonpledge_deat
rename goldreasonpledge_12 goldreasonpledge_nore
drop goldreasonpledge1 goldreasonpledge2 goldreasonpledge3 goldreasonpledge4 goldreasonpledge5 goldreasonpledge6
order goldreasonpledge_agri goldreasonpledge_fami goldreasonpledge_heal goldreasonpledge_repa goldreasonpledge_hous goldreasonpledge_inve goldreasonpledge_cere goldreasonpledge_marr goldreasonpledge_educ goldreasonpledge_rela goldreasonpledge_deat goldreasonpledge_nore, after(goldreasonpledge)



**
ta demogoldreasonpledge
replace demogoldreasonpledge="" if demogoldreasonpledge=="."
split demogoldreasonpledge, destring
forvalues i=1/11 {
gen demogoldreasonpledge_`i'=0 if demogoldreasonpledge!=""
}
forvalues i=1/11 {
replace demogoldreasonpledge_`i'=1 if demogoldreasonpledge1==`i'
replace demogoldreasonpledge_`i'=1 if demogoldreasonpledge2==`i'
label var demogoldreasonpledge_`i' "demogoldreasonpledge=`i'"
label values demogoldreasonpledge_`i' dummyinsurance
}
rename demogoldreasonpledge_1 demogoldreasonpledge_agri
rename demogoldreasonpledge_2 demogoldreasonpledge_fami
rename demogoldreasonpledge_3 demogoldreasonpledge_heal
rename demogoldreasonpledge_4 demogoldreasonpledge_repa
rename demogoldreasonpledge_5 demogoldreasonpledge_hous
rename demogoldreasonpledge_6 demogoldreasonpledge_inve
rename demogoldreasonpledge_7 demogoldreasonpledge_cere
rename demogoldreasonpledge_8 demogoldreasonpledge_marr
rename demogoldreasonpledge_9 demogoldreasonpledge_educ
rename demogoldreasonpledge_10 demogoldreasonpledge_rela
rename demogoldreasonpledge_11 demogoldreasonpledge_deat
drop demogoldreasonpledge1 demogoldreasonpledge2
order demogoldreasonpledge_agri demogoldreasonpledge_fami demogoldreasonpledge_heal demogoldreasonpledge_repa demogoldreasonpledge_hous demogoldreasonpledge_inve demogoldreasonpledge_cere demogoldreasonpledge_marr demogoldreasonpledge_educ demogoldreasonpledge_rela demogoldreasonpledge_deat, after(demogoldreasonpledge)




********** Insurance
recode dummyinsurance (.=0)

tab reasonnoinsurance
replace reasonnoinsurance="" if reasonnoinsurance=="."
split reasonnoinsurance, destring
recode reasonnoinsurance1 reasonnoinsurance2 reasonnoinsurance3 (77=4)
forvalues i=1/4 {
gen reasonnoinsurance_`i'=0 if reasonnoinsurance!=""
}
forvalues i=1/4 {
replace reasonnoinsurance_`i'=1 if reasonnoinsurance1==`i'
replace reasonnoinsurance_`i'=1 if reasonnoinsurance2==`i'
replace reasonnoinsurance_`i'=1 if reasonnoinsurance3==`i'
label var reasonnoinsurance_`i' "reasonnoinsurance=`i'"
label values reasonnoinsurance_`i' dummyinsurance
}
rename reasonnoinsurance_1 reasonnoinsurance_noin
rename reasonnoinsurance_2 reasonnoinsurance_mone
rename reasonnoinsurance_3 reasonnoinsurance_dkno
rename reasonnoinsurance_4 reasonnoinsurance_othe
drop reasonnoinsurance1 reasonnoinsurance2 reasonnoinsurance3
order reasonnoinsurance_noin reasonnoinsurance_mone reasonnoinsurance_dkno reasonnoinsurance_othe, after(reasonnoinsurance)


ta insuranceownerlist
replace insuranceownerlist="" if insuranceownerlist=="."
split insuranceownerlist, destring
gen insuranceownerlistdummy=0 if dummyinsurance==1
replace insuranceownerlistdummy=1 if insuranceownerlist1==INDID2016
replace insuranceownerlistdummy=1 if insuranceownerlist2==INDID2016
replace insuranceownerlistdummy=1 if insuranceownerlist3==INDID2016
label values insuranceownerlistdummy dummyinsurance
drop insuranceownerlist1 insuranceownerlist2 insuranceownerlist3
order insuranceownerlistdummy, after(insuranceownerlist)


replace reasonnoinsuranceother="" if reasonnoinsuranceother=="."

sort insurancebenefitamount insurancebenefitamount1 insurancebenefitamount2
replace insurancebenefitamount1=insurancebenefitamount if insurancebenefitamount!=. & insurancebenefitamount1==.
drop insurancebenefitamount

label define insurancetype 1"Life insurance" 2"Health insurance" 3"Crop insurance" 4"Animal insurance" 5"Accident insurance (vehicles/person)" 6"Bike insurance", replace
label values insurancetype1 insurancetype
label values insurancetype2 insurancetype





********** Land
ta drywetownland
label define drywetownland 1"Dry" 2"Wet" 3"Both"
label values drywetownland drywetownland

replace waterfromownland="" if waterfromownland=="."
split waterfromownland, destring
forvalues i=1/5 {
gen waterfromownland_`i'=0 if waterfromownland!=""
}
forvalues i=1/5 {
replace waterfromownland_`i'=1 if waterfromownland1==`i'
replace waterfromownland_`i'=1 if waterfromownland2==`i'
replace waterfromownland_`i'=1 if waterfromownland3==`i'
replace waterfromownland_`i'=1 if waterfromownland4==`i'
label var waterfromownland_`i' "waterfromownland=`i'"
label values waterfromownland_`i' dummyinsurance
}
rename waterfromownland_1 waterfromownland_tank
rename waterfromownland_2 waterfromownland_rive
rename waterfromownland_3 waterfromownland_bore
rename waterfromownland_4 waterfromownland_open
rename waterfromownland_5 waterfromownland_rain
drop waterfromownland1 waterfromownland2 waterfromownland3 waterfromownland4
order waterfromownland_tank waterfromownland_rive waterfromownland_bore waterfromownland_open waterfromownland_rain, after(waterfromownland)


replace drywetleaseland="3" if drywetleaseland=="1 2"
destring drywetleaseland, replace
label define drywetleaseland 1"Dry" 2"Wet" 3"Both"
label values drywetleaseland drywetleaseland

replace  waterfromleaseland="" if  waterfromleaseland=="."
split  waterfromleaseland, destring
forvalues i=1/5 {
gen  waterfromleaseland_`i'=0 if  waterfromleaseland!=""
}
forvalues i=1/5 {
replace  waterfromleaseland_`i'=1 if  waterfromleaseland1==`i'
replace  waterfromleaseland_`i'=1 if  waterfromleaseland2==`i'
replace  waterfromleaseland_`i'=1 if  waterfromleaseland3==`i'
label var  waterfromleaseland_`i' " waterfromleaseland=`i'"
label values  waterfromleaseland_`i' dummyinsurance
}
rename waterfromleaseland_1 waterfromleaseland_tank
rename waterfromleaseland_2 waterfromleaseland_rive
rename waterfromleaseland_3 waterfromleaseland_bore
rename waterfromleaseland_4 waterfromleaseland_open
rename waterfromleaseland_5 waterfromleaseland_rain
drop waterfromleaseland1  waterfromleaseland2  waterfromleaseland3
order waterfromleaseland_tank  waterfromleaseland_rive  waterfromleaseland_bore  waterfromleaseland_open  waterfromleaseland_rain, after(waterfromleaseland)


split landpurchasedhowbuy, destring
forvalues i=1/7 {
gen landpurchasedhowbuy_`i'=0 if landpurchasedhowbuy!=""
}
forvalues i=1/7 {
replace landpurchasedhowbuy_`i'=1 if landpurchasedhowbuy1==`i'
replace landpurchasedhowbuy_`i'=1 if landpurchasedhowbuy2==`i'
label var landpurchasedhowbuy_`i' "landpurchasedhowbuy=`i'"
label values landpurchasedhowbuy_`i' dummyinsurance
}
rename landpurchasedhowbuy_1 landpurchasedhowbuy_here
rename landpurchasedhowbuy_2 landpurchasedhowbuy_savi
rename landpurchasedhowbuy_3 landpurchasedhowbuy_bank
rename landpurchasedhowbuy_4 landpurchasedhowbuy_cred
rename landpurchasedhowbuy_5 landpurchasedhowbuy_fina
rename landpurchasedhowbuy_6 landpurchasedhowbuy_help
rename landpurchasedhowbuy_7 landpurchasedhowbuy_sche
drop landpurchasedhowbuy1 landpurchasedhowbuy2
order landpurchasedhowbuy_here landpurchasedhowbuy_savi landpurchasedhowbuy_bank landpurchasedhowbuy_cred landpurchasedhowbuy_fina landpurchasedhowbuy_help landpurchasedhowbuy_sche, after(landpurchasedhowbuy)

replace landleasername="" if landleasername=="."

label define landleaserrelation 1"Labour relation" 2"Relative" 5"Neighbor" 8"WKP"
label values landleaserrelation landleaserrelation

replace landleasingname="" if landleasingname=="."



split landleasingrelation, destring
forvalues i=1/11 {
gen landleasingrelation_`i'=0 if landleasingrelation!=""
}
forvalues i=1/11 {
replace landleasingrelation_`i'=1 if landleasingrelation1==`i'
replace landleasingrelation_`i'=1 if landleasingrelation2==`i'
label var landleasingrelation_`i' "landleasingrelation=`i'"
label values landleasingrelation_`i' dummyinsurance
}
rename landleasingrelation_1 landleasingrelation_labo
rename landleasingrelation_2 landleasingrelation_rela
rename landleasingrelation_3 landleasingrelation_poli
rename landleasingrelation_4 landleasingrelation_reli
rename landleasingrelation_5 landleasingrelation_neig
rename landleasingrelation_6 landleasingrelation_shg
rename landleasingrelation_7 landleasingrelation_busi
rename landleasingrelation_8 landleasingrelation_wkp
rename landleasingrelation_9 landleasingrelation_trad
rename landleasingrelation_10 landleasingrelation_frie
rename landleasingrelation_11 landleasingrelation_gpfi
drop landleasingrelation1 landleasingrelation2
order landleasingrelation_labo landleasingrelation_rela landleasingrelation_poli landleasingrelation_reli landleasingrelation_neig landleasingrelation_shg landleasingrelation_busi landleasingrelation_wkp landleasingrelation_trad landleasingrelation_frie landleasingrelation_gpfi, after(landleasingrelation)






********** crops
replace productypeland_guava="3" if productypeland_guava=="1 2"
label define landtype 1"Own land" 2"Leased land" 3"Both", replace
foreach x in paddy ragi millets tapioca cotton sugarca savukku guava groundnut {
destring productypeland_`x', replace
label values productypeland_`x' landtype
}

foreach x in productacre productypeland productunit productnbbags productselfconsumption productnbbagssold productpricesold productexpenses productpaidworkers productnbpaidworkers productlabourcost productunpaidworkers productnbunpaidworkers productnbhhmembers productoriginlabourers productcastelabourers {
rename `x'_paddy `x'_pad
rename `x'_ragi `x'_rag
rename `x'_millets `x'_mil
rename `x'_tapioca `x'_tap
rename `x'_cotton `x'_cot
rename `x'_sugarca `x'_sug
rename `x'_savukku `x'_sav
rename `x'_guava `x'_gua
rename `x'_groundnut `x'_gro
}


**
foreach x in pad rag mil tap cot sug sav gua gro {
split productoriginlabourers_`x', destring
forvalues i=1/2 {
gen productoriginlabourers_`i'_`x'=0 if productoriginlabourers_`x'!=""
}
forvalues i=1/2 {
replace productoriginlabourers_`i'_`x'=1 if productoriginlabourers_`x'1==`i'
replace productoriginlabourers_`i'_`x'=1 if productoriginlabourers_`x'2==`i'
label var productoriginlabourers_`i'_`x' "productoriginlabourers_`x'=`i'"
label values productoriginlabourers_`i'_`x' dummyinsurance
}
rename productoriginlabourers_1_`x' productoriginlabourers_in_`x'
rename productoriginlabourers_2_`x' productoriginlabourers_ou_`x'
drop productoriginlabourers_`x'1 productoriginlabourers_`x'2
order productoriginlabourers_in_`x' productoriginlabourers_ou_`x', after(productoriginlabourers_`x')
}

**
foreach x in pad rag mil tap cot sug sav gua gro {
split productcastelabourers_`x', destring
}


** 4
foreach x in pad {
recode productcastelabourers_`x'1 productcastelabourers_`x'2 productcastelabourers_`x'3 productcastelabourers_`x'4 (88=17)
forvalues i=1/17 {
gen productcastelabourers_`i'_`x'=0 if productcastelabourers_`x'!=""
}
forvalues i=1/17 {
replace productcastelabourers_`i'_`x'=1 if productcastelabourers_`x'1==`i'
replace productcastelabourers_`i'_`x'=1 if productcastelabourers_`x'2==`i'
replace productcastelabourers_`i'_`x'=1 if productcastelabourers_`x'3==`i'
replace productcastelabourers_`i'_`x'=1 if productcastelabourers_`x'4==`i'
label var productcastelabourers_`i'_`x' "productcastelabourers_`x'=`i'"
label values productcastelabourers_`i'_`x' dummyinsurance
}
rename productcastelabourers_1_`x' productcastelabourers_van_`x'
rename productcastelabourers_2_`x' productcastelabourers_sc_`x'
rename productcastelabourers_3_`x' productcastelabourers_aru_`x'
rename productcastelabourers_4_`x' productcastelabourers_red_`x'
rename productcastelabourers_5_`x' productcastelabourers_gra_`x'
rename productcastelabourers_6_`x' productcastelabourers_nai_`x'
rename productcastelabourers_7_`x' productcastelabourers_nav_`x'
rename productcastelabourers_8_`x' productcastelabourers_asa_`x'
rename productcastelabourers_9_`x' productcastelabourers_set_`x'
rename productcastelabourers_10_`x' productcastelabourers_nat_`x'
rename productcastelabourers_11_`x' productcastelabourers_mud_`x'
rename productcastelabourers_12_`x' productcastelabourers_kul_`x'
rename productcastelabourers_13_`x' productcastelabourers_che_`x'
rename productcastelabourers_14_`x' productcastelabourers_mar_`x'
rename productcastelabourers_15_`x' productcastelabourers_mus_`x'
rename productcastelabourers_16_`x' productcastelabourers_pad_`x'
rename productcastelabourers_17_`x' productcastelabourers_dk_`x'
drop productcastelabourers_`x'1 productcastelabourers_`x'2 productcastelabourers_`x'3 productcastelabourers_`x'4
order productcastelabourers_van_`x' productcastelabourers_sc_`x' productcastelabourers_aru_`x' productcastelabourers_red_`x' productcastelabourers_gra_`x' productcastelabourers_nai_`x' productcastelabourers_nav_`x' productcastelabourers_asa_`x' productcastelabourers_set_`x' productcastelabourers_nat_`x' productcastelabourers_mud_`x' productcastelabourers_kul_`x' productcastelabourers_che_`x' productcastelabourers_mar_`x' productcastelabourers_mus_`x' productcastelabourers_pad_`x' productcastelabourers_dk_`x', after(productcastelabourers_`x')
}


** 3
foreach x in mil tap cot sug sav gua {
recode productcastelabourers_`x'1 productcastelabourers_`x'2 productcastelabourers_`x'3 (88=17)
forvalues i=1/17 {
gen productcastelabourers_`i'_`x'=0 if productcastelabourers_`x'!=""
}
forvalues i=1/17 {
replace productcastelabourers_`i'_`x'=1 if productcastelabourers_`x'1==`i'
replace productcastelabourers_`i'_`x'=1 if productcastelabourers_`x'2==`i'
replace productcastelabourers_`i'_`x'=1 if productcastelabourers_`x'3==`i'
label var productcastelabourers_`i'_`x' "productcastelabourers_`x'=`i'"
label values productcastelabourers_`i'_`x' dummyinsurance
}
rename productcastelabourers_1_`x' productcastelabourers_van_`x'
rename productcastelabourers_2_`x' productcastelabourers_sc_`x'
rename productcastelabourers_3_`x' productcastelabourers_aru_`x'
rename productcastelabourers_4_`x' productcastelabourers_red_`x'
rename productcastelabourers_5_`x' productcastelabourers_gra_`x'
rename productcastelabourers_6_`x' productcastelabourers_nai_`x'
rename productcastelabourers_7_`x' productcastelabourers_nav_`x'
rename productcastelabourers_8_`x' productcastelabourers_asa_`x'
rename productcastelabourers_9_`x' productcastelabourers_set_`x'
rename productcastelabourers_10_`x' productcastelabourers_nat_`x'
rename productcastelabourers_11_`x' productcastelabourers_mud_`x'
rename productcastelabourers_12_`x' productcastelabourers_kul_`x'
rename productcastelabourers_13_`x' productcastelabourers_che_`x'
rename productcastelabourers_14_`x' productcastelabourers_mar_`x'
rename productcastelabourers_15_`x' productcastelabourers_mus_`x'
rename productcastelabourers_16_`x' productcastelabourers_pad_`x'
rename productcastelabourers_17_`x' productcastelabourers_dk_`x'
drop productcastelabourers_`x'1 productcastelabourers_`x'2 productcastelabourers_`x'3
order productcastelabourers_van_`x' productcastelabourers_sc_`x' productcastelabourers_aru_`x' productcastelabourers_red_`x' productcastelabourers_gra_`x' productcastelabourers_nai_`x' productcastelabourers_nav_`x' productcastelabourers_asa_`x' productcastelabourers_set_`x' productcastelabourers_nat_`x' productcastelabourers_mud_`x' productcastelabourers_kul_`x' productcastelabourers_che_`x' productcastelabourers_mar_`x' productcastelabourers_mus_`x' productcastelabourers_pad_`x' productcastelabourers_dk_`x', after(productcastelabourers_`x')
}


** 2
foreach x in rag gro {
recode productcastelabourers_`x'1 productcastelabourers_`x'2 (88=17)
forvalues i=1/17 {
gen productcastelabourers_`i'_`x'=0 if productcastelabourers_`x'!=""
}
forvalues i=1/17 {
replace productcastelabourers_`i'_`x'=1 if productcastelabourers_`x'1==`i'
replace productcastelabourers_`i'_`x'=1 if productcastelabourers_`x'2==`i'
label var productcastelabourers_`i'_`x' "productcastelabourers_`x'=`i'"
label values productcastelabourers_`i'_`x' dummyinsurance
}
rename productcastelabourers_1_`x' productcastelabourers_van_`x'
rename productcastelabourers_2_`x' productcastelabourers_sc_`x'
rename productcastelabourers_3_`x' productcastelabourers_aru_`x'
rename productcastelabourers_4_`x' productcastelabourers_red_`x'
rename productcastelabourers_5_`x' productcastelabourers_gra_`x'
rename productcastelabourers_6_`x' productcastelabourers_nai_`x'
rename productcastelabourers_7_`x' productcastelabourers_nav_`x'
rename productcastelabourers_8_`x' productcastelabourers_asa_`x'
rename productcastelabourers_9_`x' productcastelabourers_set_`x'
rename productcastelabourers_10_`x' productcastelabourers_nat_`x'
rename productcastelabourers_11_`x' productcastelabourers_mud_`x'
rename productcastelabourers_12_`x' productcastelabourers_kul_`x'
rename productcastelabourers_13_`x' productcastelabourers_che_`x'
rename productcastelabourers_14_`x' productcastelabourers_mar_`x'
rename productcastelabourers_15_`x' productcastelabourers_mus_`x'
rename productcastelabourers_16_`x' productcastelabourers_pad_`x'
rename productcastelabourers_17_`x' productcastelabourers_dk_`x'
drop productcastelabourers_`x'1 productcastelabourers_`x'2
order productcastelabourers_van_`x' productcastelabourers_sc_`x' productcastelabourers_aru_`x' productcastelabourers_red_`x' productcastelabourers_gra_`x' productcastelabourers_nai_`x' productcastelabourers_nav_`x' productcastelabourers_asa_`x' productcastelabourers_set_`x' productcastelabourers_nat_`x' productcastelabourers_mud_`x' productcastelabourers_kul_`x' productcastelabourers_che_`x' productcastelabourers_mar_`x' productcastelabourers_mus_`x' productcastelabourers_pad_`x' productcastelabourers_dk_`x', after(productcastelabourers_`x')
}



*** demo
ta demonbagriworkers
replace demonbagriworkers="" if demonbagriworkers=="."
split demonbagriworkers, destring
forvalues i=1/5 {
gen demonbagriworkers_`i'=0 if demonbagriworkers!=""
}
forvalues i=1/5 {
replace demonbagriworkers_`i'=1 if demonbagriworkers1==`i'
replace demonbagriworkers_`i'=1 if demonbagriworkers2==`i'
label var demonbagriworkers_`i' "demonbagriworkers=`i'"
label values demonbagriworkers_`i' dummyinsurance
}
rename demonbagriworkers_1 demonbagriworkers_hpaid
rename demonbagriworkers_2 demonbagriworkers_dpaid
rename demonbagriworkers_3 demonbagriworkers_hunpa
rename demonbagriworkers_4 demonbagriworkers_dunpa
rename demonbagriworkers_5 demonbagriworkers_same
drop demonbagriworkers1 demonbagriworkers2
order demonbagriworkers_hpaid demonbagriworkers_dpaid demonbagriworkers_hunpa demonbagriworkers_dunpa demonbagriworkers_same,after(demonbagriworkers)


*
ta demoagriactivity
replace demoagriactivity="" if demoagriactivity=="."
split demoagriactivity, destring
recode demoagriactivity1 demoagriactivity2 demoagriactivity3 demoagriactivity4 demoagriactivity5 (77=9)
forvalues i=1/9 {
gen demoagriactivity_`i'=0 if demoagriactivity!=""
}
forvalues i=1/9 {
replace demoagriactivity_`i'=1 if demoagriactivity1==`i'
replace demoagriactivity_`i'=1 if demoagriactivity2==`i'
replace demoagriactivity_`i'=1 if demoagriactivity3==`i'
replace demoagriactivity_`i'=1 if demoagriactivity4==`i'
replace demoagriactivity_`i'=1 if demoagriactivity5==`i'
label values demoagriactivity_`i' dummyinsurance
label var demoagriactivity_`i' "demoagriactivity=`i'"
}
rename demoagriactivity_1 demoagriactivity_lein
rename demoagriactivity_2 demoagriactivity_ncin
rename demoagriactivity_3 demoagriactivity_diff
rename demoagriactivity_4 demoagriactivity_ncpa
rename demoagriactivity_5 demoagriactivity_pmor
rename demoagriactivity_6 demoagriactivity_freq
rename demoagriactivity_7 demoagriactivity_pres
rename demoagriactivity_8 demoagriactivity_cont
rename demoagriactivity_9 demoagriactivity_othe
drop demoagriactivity1 demoagriactivity2 demoagriactivity3 demoagriactivity4 demoagriactivity5
order demoagriactivity_lein demoagriactivity_ncin demoagriactivity_diff demoagriactivity_ncpa demoagriactivity_pmor demoagriactivity_freq demoagriactivity_pres demoagriactivity_cont demoagriactivity_othe, after(demoagriactivity)







********** Cattle
replace cattlesoldreason="" if cattlesoldreason=="."

fre livestockuse_cow livestockuse_goat livestockuse_chicken livestockuse_bullock
foreach x in cow goat chicken {
split livestockuse_`x', destring
}


*** Cow
forvalues i=1/6 {
gen livestockuse_`i'_cow=0 if livestockuse_cow!=""
}
forvalues i=1/6 {
replace livestockuse_`i'_cow=1 if livestockuse_cow1==`i'
replace livestockuse_`i'_cow=1 if livestockuse_cow2==`i'
replace livestockuse_`i'_cow=1 if livestockuse_cow3==`i'
replace livestockuse_`i'_cow=1 if livestockuse_cow4==`i'
label values livestockuse_`i'_cow dummyinsurance
label var livestockuse_`i'_cow "livestockuse_cow=`i'"
}
rename livestockuse_1_cow livestockuse_sold_cow
rename livestockuse_2_cow livestockuse_milk_cow
rename livestockuse_3_cow livestockuse_savi_cow
rename livestockuse_4_cow livestockuse_stat_cow
rename livestockuse_5_cow livestockuse_reli_cow
rename livestockuse_6_cow livestockuse_self_cow
drop livestockuse_cow1 livestockuse_cow2 livestockuse_cow3 livestockuse_cow4
order livestockuse_sold_cow livestockuse_milk_cow livestockuse_savi_cow livestockuse_stat_cow livestockuse_reli_cow livestockuse_self_cow,after(livestockuse_cow)

** Goat
forvalues i=1/6 {
gen livestockuse_`i'_goat=0 if livestockuse_goat!=""
}
forvalues i=1/6 {
replace livestockuse_`i'_goat=1 if livestockuse_goat1==`i'
replace livestockuse_`i'_goat=1 if livestockuse_goat2==`i'
replace livestockuse_`i'_goat=1 if livestockuse_goat3==`i'
label values livestockuse_`i'_goat dummyinsurance
label var livestockuse_`i'_goat "livestockuse_goat=`i'"
}
rename livestockuse_1_goat livestockuse_sold_goat
rename livestockuse_2_goat livestockuse_milk_goat
rename livestockuse_3_goat livestockuse_savi_goat
rename livestockuse_4_goat livestockuse_stat_goat
rename livestockuse_5_goat livestockuse_reli_goat
rename livestockuse_6_goat livestockuse_self_goat
drop livestockuse_goat1 livestockuse_goat2 livestockuse_goat3
order livestockuse_sold_goat livestockuse_milk_goat livestockuse_savi_goat livestockuse_stat_goat livestockuse_reli_goat livestockuse_self_goat,after(livestockuse_goat)

** Chicken
forvalues i=1/6 {
gen livestockuse_`i'_chicken=0 if livestockuse_chicken!=""
}
forvalues i=1/6 {
replace livestockuse_`i'_chicken=1 if livestockuse_chicken1==`i'
replace livestockuse_`i'_chicken=1 if livestockuse_chicken2==`i'
label values livestockuse_`i'_chicken dummyinsurance
label var livestockuse_`i'_chicken "livestockuse_chicken=`i'"
}
rename livestockuse_1_chicken livestockuse_sold_chicken
rename livestockuse_2_chicken livestockuse_milk_chicken
rename livestockuse_3_chicken livestockuse_savi_chicken
rename livestockuse_4_chicken livestockuse_stat_chicken
rename livestockuse_5_chicken livestockuse_reli_chicken
rename livestockuse_6_chicken livestockuse_self_chicken
drop livestockuse_chicken1 livestockuse_chicken2
order livestockuse_sold_chicken livestockuse_milk_chicken livestockuse_savi_chicken livestockuse_stat_chicken livestockuse_reli_chicken livestockuse_self_chicken,after(livestockuse_chicken)

** Bullock
forvalues i=1/6 {
gen livestockuse_`i'_bullock=0 if livestockuse_bullock!=.
}
forvalues i=1/6 {
replace livestockuse_`i'_bullock=1 if livestockuse_bullock==`i'
label values livestockuse_`i'_bullock dummyinsurance
label var livestockuse_`i'_bullock "livestockuse_bullock=`i'"
}
rename livestockuse_1_bullock livestockuse_sold_bullock
rename livestockuse_2_bullock livestockuse_milk_bullock
rename livestockuse_3_bullock livestockuse_savi_bullock
rename livestockuse_4_bullock livestockuse_stat_bullock
rename livestockuse_5_bullock livestockuse_reli_bullock
rename livestockuse_6_bullock livestockuse_self_bullock
order livestockuse_sold_bullock livestockuse_milk_bullock livestockuse_savi_bullock livestockuse_stat_bullock livestockuse_reli_bullock livestockuse_self_bullock,after(livestockuse_bullock)






********** Equipment
split equiownpay_tractor, destring
split equilentlender_tractor, destring

split equilentlender_bullockcart, destring

split equiownpay_ploughmach, destring
split equilentlender_ploughmach, destring


***
foreach x in tractor ploughmach {
forvalues i=1/8 {
gen equiownpay_`i'_`x'=0 if equiownpay_`x'!=""
}
}
forvalues i=1/8 {
gen equiownpay_`i'_bullockcart=0 if equiownpay_bullockcart!=.
}
forvalues i=1/8 {
replace equiownpay_`i'_tractor=1 if equiownpay_tractor1==`i'
replace equiownpay_`i'_tractor=1 if equiownpay_tractor2==`i'
replace equiownpay_`i'_ploughmach=1 if equiownpay_ploughmach1==`i'
replace equiownpay_`i'_ploughmach=1 if equiownpay_ploughmach2==`i'
replace equiownpay_`i'_bullockcart=1 if equiownpay_bullockcart==`i'
label var equiownpay_`i'_tractor "equiownpay_tractor=`i'"
label values equiownpay_`i'_tractor dummyinsurance
label var equiownpay_`i'_bullockcart "equiownpay_bullockcart=`i'"
label values equiownpay_`i'_bullockcart dummyinsurance
label var equiownpay_`i'_ploughmach "equiownpay_ploughmach=`i'"
label values equiownpay_`i'_ploughmach dummyinsurance
}
foreach x in tractor bullockcart ploughmach {
rename equiownpay_1_`x' equiownpay_inc_`x'
rename equiownpay_2_`x' equiownpay_sav_`x'
rename equiownpay_3_`x' equiownpay_ass_`x'
rename equiownpay_4_`x' equiownpay_hel_`x'
rename equiownpay_5_`x' equiownpay_sch_`x'
rename equiownpay_6_`x' equiownpay_ngo_`x'
rename equiownpay_7_`x' equiownpay_cre_`x'
rename equiownpay_8_`x' equiownpay_wor_`x'
}
drop equiownpay_tractor1 equiownpay_tractor2 equiownpay_ploughmach1 equiownpay_ploughmach2
order equiownpay_inc_tractor equiownpay_sav_tractor equiownpay_ass_tractor equiownpay_hel_tractor equiownpay_sch_tractor equiownpay_ngo_tractor equiownpay_cre_tractor equiownpay_wor_tractor, after(equiownpay_tractor)
order equiownpay_inc_ploughmach equiownpay_sav_ploughmach equiownpay_ass_ploughmach equiownpay_hel_ploughmach equiownpay_sch_ploughmach equiownpay_ngo_ploughmach equiownpay_cre_ploughmach equiownpay_wor_ploughmach, after(equiownpay_ploughmach)
order equiownpay_inc_bullockcart equiownpay_sav_bullockcart equiownpay_ass_bullockcart equiownpay_hel_bullockcart equiownpay_sch_bullockcart equiownpay_ngo_bullockcart equiownpay_cre_bullockcart equiownpay_wor_bullockcart, after(equiownpay_bullockcart)


*** lender
ta equilentlender_tractor
ta equilentlender_bullockcart
ta equilentlender_ploughmach
foreach x in tractor bullockcart ploughmach {
forvalues i=1/15 {
gen equilentlender_`i'_`x'=0 if equilentlender_`x'!=""
}
}
forvalues i=1/15 {
replace equilentlender_`i'_tractor=1 if equilentlender_tractor1==`i'
replace equilentlender_`i'_tractor=1 if equilentlender_tractor2==`i'
replace equilentlender_`i'_tractor=1 if equilentlender_tractor3==`i'
replace equilentlender_`i'_tractor=1 if equilentlender_tractor4==`i'
replace equilentlender_`i'_ploughmach=1 if equilentlender_ploughmach1==`i'
replace equilentlender_`i'_ploughmach=1 if equilentlender_ploughmach2==`i'
replace equilentlender_`i'_ploughmach=1 if equilentlender_ploughmach3==`i'
replace equilentlender_`i'_bullockcart=1 if equilentlender_bullockcart1==`i'
replace equilentlender_`i'_bullockcart=1 if equilentlender_bullockcart2==`i'
label var equilentlender_`i'_tractor "equilentlender_tractor=`i'"
label values equilentlender_`i'_tractor dummyinsurance
label var equilentlender_`i'_bullockcart "equilentlender_bullockcart=`i'"
label values equilentlender_`i'_bullockcart dummyinsurance
label var equilentlender_`i'_ploughmach "equilentlender_ploughmach=`i'"
label values equilentlender_`i'_ploughmach dummyinsurance
}
foreach x in tractor bullockcart ploughmach {
rename equilentlender_1_`x' equilentlender_mai_`x'
rename equilentlender_2_`x' equilentlender_chi_`x'
rename equilentlender_3_`x' equilentlender_sib_`x'
rename equilentlender_4_`x' equilentlender_par_`x'
rename equilentlender_5_`x' equilentlender_nie_`x'
rename equilentlender_6_`x' equilentlender_oth_`x'
rename equilentlender_7_`x' equilentlender_nei_`x'
rename equilentlender_8_`x' equilentlender_fri_`x'
rename equilentlender_9_`x' equilentlender_cus_`x'
rename equilentlender_10_`x' equilentlender_mon_`x'
rename equilentlender_11_`x' equilentlender_shg_`x'
rename equilentlender_12_`x' equilentlender_emp_`x'
rename equilentlender_13_`x' equilentlender_wkp_`x'
rename equilentlender_14_`x' equilentlender_own_`x'
rename equilentlender_15_`x' equilentlender_spo_`x'
}
drop equilentlender_tractor1 equilentlender_tractor2 equilentlender_tractor3 equilentlender_tractor4 equilentlender_bullockcart1 equilentlender_bullockcart2 equilentlender_ploughmach1 equilentlender_ploughmach2 equilentlender_ploughmach3
order equilentlender_mai_tractor equilentlender_chi_tractor equilentlender_sib_tractor equilentlender_par_tractor equilentlender_nie_tractor equilentlender_oth_tractor equilentlender_nei_tractor equilentlender_fri_tractor equilentlender_cus_tractor equilentlender_mon_tractor equilentlender_shg_tractor equilentlender_emp_tractor equilentlender_wkp_tractor equilentlender_own_tractor equilentlender_spo_tractor, after(equilentlender_tractor)
order equilentlender_mai_bullockcart equilentlender_chi_bullockcart equilentlender_sib_bullockcart equilentlender_par_bullockcart equilentlender_nie_bullockcart equilentlender_oth_bullockcart equilentlender_nei_bullockcart equilentlender_fri_bullockcart equilentlender_cus_bullockcart equilentlender_mon_bullockcart equilentlender_shg_bullockcart equilentlender_emp_bullockcart equilentlender_wkp_bullockcart equilentlender_own_bullockcart equilentlender_spo_bullockcart, after(equilentlender_ploughmach)
order equilentlender_mai_ploughmach equilentlender_chi_ploughmach equilentlender_sib_ploughmach equilentlender_par_ploughmach equilentlender_nie_ploughmach equilentlender_oth_ploughmach equilentlender_nei_ploughmach equilentlender_fri_ploughmach equilentlender_cus_ploughmach equilentlender_mon_ploughmach equilentlender_shg_ploughmach equilentlender_emp_ploughmach equilentlender_wkp_ploughmach equilentlender_own_ploughmach equilentlender_spo_ploughmach, after(equilentlender_bullockcart)





********** Expenses
label define demoexpenses 1"More" 2"Less" 3"Same"
label values demoexpenses demoexpenses


foreach x in less more same {
ta democonso`x'
replace democonso`x'="" if democonso`x'=="."
split democonso`x', destring
forvalues i=1/9 {
gen democonso`x'_`i'=0 if democonso`x'!=""
}
}

forvalues i=1/9{
replace democonsoless_`i'=1 if democonsoless1==`i'
replace democonsoless_`i'=1 if democonsoless2==`i'
replace democonsoless_`i'=1 if democonsoless3==`i'
replace democonsoless_`i'=1 if democonsoless4==`i'
replace democonsoless_`i'=1 if democonsoless5==`i'
replace democonsomore_`i'=1 if democonsomore1==`i'
replace democonsomore_`i'=1 if democonsomore2==`i'
replace democonsomore_`i'=1 if democonsomore3==`i'
replace democonsosame_`i'=1 if democonsosame1==`i'
replace democonsosame_`i'=1 if democonsosame2==`i'
replace democonsosame_`i'=1 if democonsosame3==`i'
replace democonsosame_`i'=1 if democonsosame4==`i'
replace democonsosame_`i'=1 if democonsosame5==`i'
replace democonsosame_`i'=1 if democonsosame6==`i'
replace democonsosame_`i'=1 if democonsosame7==`i'
replace democonsosame_`i'=1 if democonsosame8==`i'
label var democonsoless_`i' "democonsoless=`i'"
label values democonsoless_`i' dummyinsurance
label var democonsomore_`i' "democonsomore=`i'"
label values democonsomore_`i' dummyinsurance
label var democonsosame_`i' "democonsosame=`i'"
label values democonsosame_`i' dummyinsurance
}
foreach x in less more same {
rename democonso`x'_1 democonso`x'_food
rename democonso`x'_2 democonso`x'_tran
rename democonso`x'_3 democonso`x'_clot
rename democonso`x'_4 democonso`x'_heal
rename democonso`x'_5 democonso`x'_educ
rename democonso`x'_6 democonso`x'_gift
rename democonso`x'_7 democonso`x'_func
rename democonso`x'_8 democonso`x'_good
rename democonso`x'_9 democonso`x'_none
}
drop democonsoless1 democonsoless2 democonsoless3 democonsoless4 democonsoless5 democonsomore1 democonsomore2 democonsomore3 democonsosame1 democonsosame2 democonsosame3 democonsosame4 democonsosame5 democonsosame6 democonsosame7 democonsosame8
foreach x in less more same {
order democonso`x'_food democonso`x'_tran democonso`x'_clot democonso`x'_heal democonso`x'_educ democonso`x'_gift democonso`x'_func democonso`x'_good democonso`x'_none, after(democonso`x')
}


**
ta democonsopractices
replace democonsopractices="" if democonsopractices=="."
split democonsopractices, destring
forvalues i=1/7 {
gen democonsopractices_`i'=0 if democonsopractices!=""
}
forvalues i=1/7 {
replace democonsopractices_`i'=1 if democonsopractices1==`i'
replace democonsopractices_`i'=1 if democonsopractices2==`i'
replace democonsopractices_`i'=1 if democonsopractices3==`i'
replace democonsopractices_`i'=1 if democonsopractices4==`i'
label var democonsopractices_`i' "democonsopractices=`i'"
label values democonsopractices_`i' dummyinsurance
}
rename democonsopractices_1 democonsopractices_lessless
rename democonsopractices_2 democonsopractices_lessbigg
rename democonsopractices_3 democonsopractices_card
rename democonsopractices_4 democonsopractices_morecred
rename democonsopractices_5 democonsopractices_lesscred
rename democonsopractices_6 democonsopractices_advance
rename democonsopractices_7 democonsopractices_nochange
drop democonsopractices1 democonsopractices2 democonsopractices3 democonsopractices4
order democonsopractices_lessless democonsopractices_lessbigg democonsopractices_card democonsopractices_morecred democonsopractices_lesscred democonsopractices_advance democonsopractices_nochange, after(democonsopractices)


***
ta democonsoplace
replace democonsoplace="" if democonsoplace=="."
split democonsoplace, destring
forvalues i=1/6 {
gen democonsoplace_`i'=0 if democonsoplace!=""
}
forvalues i=1/6 {
replace democonsoplace_`i'=1 if democonsoplace1==`i'
replace democonsoplace_`i'=1 if democonsoplace2==`i'
replace democonsoplace_`i'=1 if democonsoplace3==`i'
label var democonsoplace_`i' "democonsoplace=`i'"
label values democonsoplace_`i' dummyinsurance
}
rename democonsoplace_1 democonsoplace_moreins
rename democonsoplace_2 democonsoplace_lessins
rename democonsoplace_3 democonsoplace_moresur
rename democonsoplace_4 democonsoplace_lesssur
rename democonsoplace_5 democonsoplace_moreclo
rename democonsoplace_6 democonsoplace_nochang
drop democonsoplace1 democonsoplace2 democonsoplace3
order democonsoplace_moreins democonsoplace_lessins democonsoplace_moresur democonsoplace_lesssur democonsoplace_moreclo democonsoplace_nochang, after(democonsoplace)







********** Marriage
ta marriedlist
replace marriedlist="" if marriedlist=="."
split marriedlist, destring
gen marriedlistdummy=0 if dummymarriage==1
replace marriedlistdummy=1 if marriedlist1==INDID2016
replace marriedlistdummy=1 if marriedlist2==INDID2016
replace marriedlistdummy=1 if marriedlist3==INDID2016
replace marriedlistdummy=1 if marriedlist4==INDID2016
label values marriedlistdummy dummyinsurance
ta marriedlistdummy
drop marriedlist1 marriedlist2 marriedlist3 marriedlist4
order marriedlistdummy, after(marriedlist)

replace marriageloansource="" if marriageloansource=="."
split marriageloansource, destring
forvalues i=1/14 {
gen marriageloansource_`i'=0 if marriageloansource!=""
}
forvalues i=1/14 {
replace marriageloansource_`i'=1 if marriageloansource1==`i'
replace marriageloansource_`i'=1 if marriageloansource2==`i'
replace marriageloansource_`i'=1 if marriageloansource3==`i'
replace marriageloansource_`i'=1 if marriageloansource4==`i'
label var marriageloansource_`i' "marriageloansource=`i'"
label values marriageloansource_`i' dummyinsurance
}
rename marriageloansource_1 marriageloansource_wkp
rename marriageloansource_2 marriageloansource_rela
rename marriageloansource_3 marriageloansource_empl
rename marriageloansource_4 marriageloansource_mais
rename marriageloansource_5 marriageloansource_coll
rename marriageloansource_6 marriageloansource_pawn
rename marriageloansource_7 marriageloansource_shop
rename marriageloansource_8 marriageloansource_fina
rename marriageloansource_9 marriageloansource_frie
rename marriageloansource_10 marriageloansource_shg
rename marriageloansource_11 marriageloansource_bank
rename marriageloansource_12 marriageloansource_coop
rename marriageloansource_13 marriageloansource_sug
rename marriageloansource_14 marriageloansource_gpfi
drop marriageloansource1 marriageloansource2 marriageloansource3 marriageloansource4
order marriageloansource_wkp marriageloansource_rela marriageloansource_empl marriageloansource_mais marriageloansource_coll marriageloansource_pawn marriageloansource_shop marriageloansource_fina marriageloansource_frie marriageloansource_shg marriageloansource_bank marriageloansource_coop marriageloansource_sug marriageloansource_gpfi, after(marriageloansource)


***
ta marriagegiftsource
replace marriagegiftsource="" if marriagegiftsource=="."
split marriagegiftsource, destring
forvalues i=1/14 {
gen marriagegiftsource_`i'=0 if marriagegiftsource!=""
}
forvalues i=1/14 {
replace marriagegiftsource_`i'=1 if marriagegiftsource1==`i'
replace marriagegiftsource_`i'=1 if marriagegiftsource2==`i'
replace marriagegiftsource_`i'=1 if marriagegiftsource3==`i'
replace marriagegiftsource_`i'=1 if marriagegiftsource4==`i'
replace marriagegiftsource_`i'=1 if marriagegiftsource5==`i'
replace marriagegiftsource_`i'=1 if marriagegiftsource6==`i'
replace marriagegiftsource_`i'=1 if marriagegiftsource7==`i'
label var marriagegiftsource_`i' "marriagegiftsource=`i'"
label values marriagegiftsource_`i' dummyinsurance
}
rename marriagegiftsource_1 marriagegiftsource_wkp
rename marriagegiftsource_2 marriagegiftsource_rela
rename marriagegiftsource_3 marriagegiftsource_empl
rename marriagegiftsource_4 marriagegiftsource_mais
rename marriagegiftsource_5 marriagegiftsource_coll
rename marriagegiftsource_6 marriagegiftsource_pawn
rename marriagegiftsource_7 marriagegiftsource_shop
rename marriagegiftsource_8 marriagegiftsource_fina
rename marriagegiftsource_9 marriagegiftsource_frie
rename marriagegiftsource_10 marriagegiftsource_shg
rename marriagegiftsource_11 marriagegiftsource_bank
rename marriagegiftsource_12 marriagegiftsource_coop
rename marriagegiftsource_13 marriagegiftsource_sug
rename marriagegiftsource_14 marriagegiftsource_gpfi
drop marriagegiftsource1 marriagegiftsource2 marriagegiftsource3 marriagegiftsource4 marriagegiftsource5 marriagegiftsource6 marriagegiftsource7
order marriagegiftsource_wkp marriagegiftsource_rela marriagegiftsource_empl marriagegiftsource_mais marriagegiftsource_coll marriagegiftsource_pawn marriagegiftsource_shop marriagegiftsource_fina marriagegiftsource_frie marriagegiftsource_shg marriagegiftsource_bank marriagegiftsource_coop marriagegiftsource_sug marriagegiftsource_gpfi, after(marriagegiftsource)






********** House
replace howbuyhouse="" if howbuyhouse=="."
split howbuyhouse, destring
forvalues i=1/7 {
gen howbuyhouse_`i'=0 if howbuyhouse!=""
}
forvalues i=1/7 {
replace howbuyhouse_`i'=1 if howbuyhouse1==`i'
replace howbuyhouse_`i'=1 if howbuyhouse2==`i'
replace howbuyhouse_`i'=1 if howbuyhouse3==`i'
label var howbuyhouse_`i' "howbuyhouse=`i'"
label values howbuyhouse_`i' dummyinsurance
}
rename howbuyhouse_1 howbuyhouse_here
rename howbuyhouse_2 howbuyhouse_savi
rename howbuyhouse_3 howbuyhouse_bank
rename howbuyhouse_4 howbuyhouse_cred
rename howbuyhouse_5 howbuyhouse_fina
rename howbuyhouse_6 howbuyhouse_help
rename howbuyhouse_7 howbuyhouse_sche
drop howbuyhouse1 howbuyhouse2 howbuyhouse3
order howbuyhouse_here howbuyhouse_savi howbuyhouse_bank howbuyhouse_cred howbuyhouse_fina howbuyhouse_help howbuyhouse_sche, after(howbuyhouse)








********** Schemes
ta schemeslist
split schemeslist, destring
forvalues i=1/18 {
gen schemeslist_`i'=0 if schemeslist!=""
}
forvalues i=1/18 {
replace schemeslist_`i'=1 if schemeslist1==`i'
replace schemeslist_`i'=1 if schemeslist2==`i'
replace schemeslist_`i'=1 if schemeslist3==`i'
replace schemeslist_`i'=1 if schemeslist4==`i'
replace schemeslist_`i'=1 if schemeslist5==`i'
replace schemeslist_`i'=1 if schemeslist6==`i'
label var schemeslist_`i' "schemestlist=`i'"
label values schemeslist_`i' dummyinsurance
}
rename schemeslist_1 schemeslist_nrega
rename schemeslist_2 schemeslist_ratio
rename schemeslist_3 schemeslist_house
rename schemeslist_4 schemeslist_funer
rename schemeslist_5 schemeslist_anima
rename schemeslist_6 schemeslist_lpgga
rename schemeslist_7 schemeslist_educa
rename schemeslist_8 schemeslist_farme
rename schemeslist_9 schemeslist_land
rename schemeslist_10 schemeslist_sewin
rename schemeslist_11 schemeslist_camar
rename schemeslist_12 schemeslist_gomar
rename schemeslist_13 schemeslist_oldpe
rename schemeslist_14 schemeslist_widpe
rename schemeslist_15 schemeslist_mater
rename schemeslist_16 schemeslist_disab
rename schemeslist_17 schemeslist_retir
rename schemeslist_18 schemeslist_none
drop schemeslist1 schemeslist2 schemeslist3 schemeslist4 schemeslist5 schemeslist6
order schemeslist_nrega schemeslist_ratio schemeslist_house schemeslist_funer schemeslist_anima schemeslist_lpgga schemeslist_educa schemeslist_farme schemeslist_land schemeslist_sewin schemeslist_camar schemeslist_gomar schemeslist_oldpe schemeslist_widpe schemeslist_mater schemeslist_disab schemeslist_retir schemeslist_none, after(schemeslist)

rename schemerecipient_freemachine schemerecipient_sewin
rename schemerecipient_cashmarriage schemerecipient_camar
rename schemerecipient_goldmarriage schemerecipient_gomar
rename schemeyear_goldmarriage schemeyear_gomar
rename schemeyear_cashmarriage schemeyear_camar
rename schemeyear_freemachine schemeyear_sewin
rename schemeyear_cashfunerals schemeyear_funer
rename schemeyear_animals schemeyear_anima
rename schemeyear_freegas schemeyear_lpgga
rename schemeyear_educ schemeyear_educa
rename schemeyear_farmequi schemeyear_farme
rename schemeamount_goldmarriage schemeamount_gomar
rename schemeamount_cashmarriage schemeamount_camar
rename schemeamount_freemachine schemeamount_sewin
rename schemeamount_cashfunerals schemeamount_funer
rename schemeamount_animals schemeamount_anima
rename schemeamount_freegas schemeamount_lpgga
rename schemeamount_educ schemeamount_educa
rename schemeamount_farmequi schemeamount_farme
rename pensionrecipient_oldage pensionrecipient_old
rename pensionrecipient_widows pensionrecipient_wid
rename pensionrecipient_maternity pensionrecipient_mat
rename pensionrecipient_disability pensionrecipient_dis
rename pensionrecipient_retirement pensionrecipient_ret
rename pensionamount_retirement pensionamount_ret
rename pensionamount_disability pensionamount_dis
rename pensionamount_maternity pensionamount_mat
rename pensionamount_widows pensionamount_wid
rename pensionamount_oldage pensionamount_old



********** NREGA
ta nregarecipientlist
replace nregarecipientlist="" if nregarecipientlist=="."
split nregarecipientlist, destring
gen nregarecipientlistdummy=0 if schemeslist_nrega==1
replace nregarecipientlistdummy=1 if nregarecipientlist1==INDID2016
replace nregarecipientlistdummy=1 if nregarecipientlist2==INDID2016
replace nregarecipientlistdummy=1 if nregarecipientlist3==INDID2016
replace nregarecipientlistdummy=1 if nregarecipientlist4==INDID2016
drop nregarecipientlist1 nregarecipientlist2 nregarecipientlist3 nregarecipientlist4
label values nregarecipientlistdummy dummyinsurance
order nregarecipientlistdummy, after(nregarecipientlist)


********** Others schemes
ta schemerecipient_sewin
gen schemerecipientdummy_sewin=0 if schemeslist_sewin==1
replace schemerecipientdummy_sewin=1 if schemerecipient_sewin==INDID2016
label values schemerecipientdummy_sewin dummyinsurance
order schemerecipientdummy_sewin, after(schemerecipient_sewin)

ta schemerecipient_camar
gen schemerecipientdummy_camar=0 if schemeslist_sewin==1
replace schemerecipientdummy_camar=1 if schemerecipient_camar==INDID2016
label values schemerecipientdummy_camar dummyinsurance
order schemerecipientdummy_camar, after(schemerecipient_camar)

ta schemerecipient_gomar
split schemerecipient_gomar, destring
gen schemerecipientdummy_gomar=0 if schemeslist_sewin==1
replace schemerecipientdummy_gomar=1 if schemerecipient_gomar1==INDID2016
replace schemerecipientdummy_gomar=1 if schemerecipient_gomar2==INDID2016
label values schemerecipientdummy_gomar dummyinsurance
drop schemerecipient_gomar1 schemerecipient_gomar2
order schemerecipientdummy_gomar, after(schemerecipient_gomar)


**
foreach x in old wid mat dis ret {
ta pensionrecipient_`x'
}

foreach x in old mat dis {
split pensionrecipient_`x', destring
gen pensionrecipientdummy_`x'=0 if schemeslist_`x'==1
}
foreach x in old mat dis {
replace pensionrecipientdummy_`x'=1 if pensionrecipient_`x'1==INDID2016
replace pensionrecipientdummy_`x'=1 if pensionrecipient_`x'2==INDID2016
label values pensionrecipientdummy_`x' dummyinsurance
drop pensionrecipient_`x'1 pensionrecipient_`x'2
order pensionrecipientdummy_`x', after(pensionrecipient_`x')
}


foreach x in wid ret {
gen pensionrecipientdummy_`x'=0 if schemeslist_`x'==1
}
foreach x in wid ret {
replace pensionrecipientdummy_`x'=1 if pensionrecipient_`x'==INDID2016
label values pensionrecipientdummy_`x' dummyinsurance
order pensionrecipientdummy_`x', after(pensionrecipient_`x')
}


*** Demo
ta demoscheme
replace demoscheme="" if demoscheme=="."
split demoscheme, destring
forvalues i=1/18 {
gen demoscheme_`i'=0 if demoscheme!=""
}
forvalues i=1/18 {
replace demoscheme_`i'=1 if demoscheme1==`i'
replace demoscheme_`i'=1 if demoscheme2==`i'
label var demoscheme_`i' "demoscheme=`i'"
label values demoscheme_`i' dummyinsurance
}
rename demoscheme_1 demoscheme_nrega
rename demoscheme_2 demoscheme_ratio
rename demoscheme_3 demoscheme_house
rename demoscheme_4 demoscheme_funer
rename demoscheme_5 demoscheme_anima
rename demoscheme_6 demoscheme_lpgga
rename demoscheme_7 demoscheme_educa
rename demoscheme_8 demoscheme_farme
rename demoscheme_9 demoscheme_land
rename demoscheme_10 demoscheme_sewin
rename demoscheme_11 demoscheme_camar
rename demoscheme_12 demoscheme_gomar
rename demoscheme_13 demoscheme_oldpe
rename demoscheme_14 demoscheme_widpe
rename demoscheme_15 demoscheme_mater
rename demoscheme_16 demoscheme_disab
rename demoscheme_17 demoscheme_retir
rename demoscheme_18 demoscheme_none
drop demoscheme1 demoscheme2
order demoscheme_nrega demoscheme_ratio demoscheme_house demoscheme_funer demoscheme_anima demoscheme_lpgga demoscheme_educa demoscheme_farme demoscheme_land demoscheme_sewin demoscheme_camar demoscheme_gomar demoscheme_oldpe demoscheme_widpe demoscheme_mater demoscheme_disab demoscheme_retir demoscheme_none,after(demoscheme)



********** Correction suite au rapport stat
* Format
splitvarmcq giftsource 14
newn giftsource 1 wkp
newn giftsource 2 rel
newn giftsource 3 emp
newn giftsource 4 mai
newn giftsource 5 col
newn giftsource 6 paw
newn giftsource 7 sho
newn giftsource 8 fin
newn giftsource 9 fri
newn giftsource 10 shg
newn giftsource 11 ban
newn giftsource 12 coo
newn giftsource 13 sug
newn giftsource 14 gro


* Correction
tabulate interestlending
replace interestlending=(interestlending/amountlent)*100 if interestlending>100
tabulate interestlending


* Var
replace productlist="" if productlist=="."
splitvarmcq productlist 14
newn productlist 1 paddy
newn productlist 2 cotto
newn productlist 3 sugar
newn productlist 4 savuk
newn productlist 5 guava
newn productlist 6 mango
newn productlist 7 sapot
newn productlist 8 banan
newn productlist 9 groun
newn productlist 10 ragi
newn productlist 11 mille
newn productlist 12 cashe
newn productlist 13 cocon
newn productlist 14 none


* livestock
splitvarmcq livestocklist 6
newn livestocklist 1 cow
newn livestocklist 2 goa
newn livestocklist 3 chi
newn livestocklist 4 bul
newn livestocklist 5 plo
newn livestocklist 6 none

* equipment
ta equipmentborrowedlist
replace equipmentborrowedlist="" if equipmentborrowedlist=="."
splitvarmcq equipmentborrowedlist 5
newn equipmentborrowedlist 1 trac
newn equipmentborrowedlist 2 bull
newn equipmentborrowedlist 3 harv
newn equipmentborrowedlist 4 plow
newn equipmentborrowedlist 5 none


* Goods
splitvarmcq listgoods 13
newn listgoods 1 car
newn listgoods 2 bik
newn listgoods 3 fri
newn listgoods 4 fur
newn listgoods 5 tai
newn listgoods 6 cel
newn listgoods 7 lan
newn listgoods 8 dvd
newn listgoods 9 cam
newn listgoods 10 coo
newn listgoods 11 com
newn listgoods 12 dis
newn listgoods 13 non


* Schemes
foreach x in old ret wid {
replace pensionamount_`x'=. if pensionrecipientdummy_`x'==0
replace pensionamount_`x'=. if pensionrecipientdummy_`x'==.
}

recode dummygiftsreceived (.=0)



* Label
label define insurancepublic 0"Private" 1"Public"
label values insurancepublic1 insurancepublic
label values insurancepublic2 insurancepublic




save"Last/NEEMSIS1-HH", replace
****************************************
* END



























****************************************
* NEEMSIS1-occupations.dta
****************************************
use"NEEMSIS1-occupations", clear

format datestartoccup %td
ta datestartoccup

label define demooccup 1"More" 2"Less" 3"Same" 4"Constrained to stop due to demo" 5"Stopped after demo for other reasons" 6"Stopped before demo"
label values demooccup demooccup
ta demooccup
order demooccup, after(datestartoccup)


********** businessskill
ta businessskill
split businessskill
forvalues i=1/4 {
gen businessskill_`i'=0 if businessskill!=""
}
forvalues i=1/4 {
replace businessskill_`i'=1 if businessskill1=="`i'"
replace businessskill_`i'=1 if businessskill2=="`i'"
label values businessskill_`i' dummybusinesslabourers
label var businessskill_`i' "businessskill=`i'"
}
rename businessskill_1 businessskill_fami
rename businessskill_2 businessskill_frie
rename businessskill_3 businessskill_scho
rename businessskill_4 businessskill_expe
drop businessskill1 businessskill2
order businessskill_fami businessskill_frie businessskill_scho businessskill_expe, after(businessskill)


********** businesssourceinvest
ta businesssourceinvest
replace businesssourceinvest="" if businesssourceinvest=="."
split businesssourceinvest
destring businesssourceinvest1 businesssourceinvest2 businesssourceinvest3, replace
recode businesssourceinvest1 businesssourceinvest2 businesssourceinvest3 (77=9)
forvalues i=1/9 {
gen businesssourceinvest_`i'=0 if businesssourceinvest!=""
} 
forvalues i=1/9 {
replace businesssourceinvest_`i'=1 if businesssourceinvest1==`i'
replace businesssourceinvest_`i'=1 if businesssourceinvest2==`i'
replace businesssourceinvest_`i'=1 if businesssourceinvest3==`i'
label values businesssourceinvest_`i' dummybusinesslabourers
label var businesssourceinvest_`i' "businesssourceinvest=`i'"
}
rename businesssourceinvest_1 businesssourceinvest_rela
rename businesssourceinvest_2 businesssourceinvest_bank
rename businesssourceinvest_3 businesssourceinvest_info
rename businesssourceinvest_4 businesssourceinvest_savi
rename businesssourceinvest_5 businesssourceinvest_inhe
rename businesssourceinvest_6 businesssourceinvest_prof
rename businesssourceinvest_7 businesssourceinvest_inbu
rename businesssourceinvest_8 businesssourceinvest_none
rename businesssourceinvest_9 businesssourceinvest_othe
drop businesssourceinvest1 businesssourceinvest2 businesssourceinvest3
order businesssourceinvest_rela businesssourceinvest_bank businesssourceinvest_info businesssourceinvest_savi businesssourceinvest_inhe businesssourceinvest_prof businesssourceinvest_inbu businesssourceinvest_none businesssourceinvest_othe, after(businesssourceinvest)
fre businesssourceinvest*


********** otherbusinesssourceinvestment
replace otherbusinesssourceinvestment="" if otherbusinesssourceinvestment=="."


********** business lender
drop numberbusinessloan_rel namebusinesslender1_rel addressbusinesslender1_rel businesslender1_rel castebusinesslender1_rel occupbusinesslender1_rel numberbusinessloan_bank namebusinesslender1_bank addressbusinesslender1_bank businesslender1_bank castebusinesslender1_bank occupbusinesslender1_bank namebusinesslender2_bank addressbusinesslender2_bank businesslender2_bank castebusinesslender2_bank occupbusinesslender2_bank numberbusinessloan_inf namebusinesslender1_inf addressbusinesslender1_inf businesslender1_inf castebusinesslender1_inf occupbusinesslender1_inf namebusinesslender2_inf addressbusinesslender2_inf businesslender2_inf castebusinesslender2_inf occupbusinesslender2_inf namebusinesslender3_inf addressbusinesslender3_inf businesslender3_inf castebusinesslender3_inf occupbusinesslender3_inf

preserve
use"C:\Users\Arnaud\Documents\Dropbox (Personal)\2016-NEEMSIS1\Data\_raw\NEEMSIS1 Original data by module\NEEMSIS-businessinvestment", clear
sort parent_key namenumber occupationid businessloanid
reshape long namebusinesslender addressbusinesslender businesslender castebusinesslender occupbusinesslender, i(parent_key namenumber occupationid businessloanid) j(n)
drop if namebusinesslender==""
drop businessloanname parent_key_all _merge businessloanid n numberbusinessloan 
bysort parent_key namenumber occupationid: gen n=_n
reshape wide namebusinesslender addressbusinesslender businesslender castebusinesslender occupbusinesslender, i(parent_key namenumber occupationid) j(n)
rename parent_key HHID2016
rename namenumber INDID2016
save"_temp/Businessinvest", replace
restore

merge m:1 HHID2016 INDID2016 occupationid using "_temp/Businessinvest"
drop if occupationid==.
sort _merge
ta _merge
order HHID2016 INDID2016 occupationid _merge
sort HHID2016 INDID2016 occupationid
drop if _merge==2
drop _merge



********** SE labourers
label define demobusiness 1"More labourers" 2"Less labourers" 3"Same number of labourers"
label values demobusiness demobusiness



forvalues i=1/14 {
format businesslabourerdate`i' %td
}




********** Demo
replace demobusinessactivity="" if demobusinessactivity=="."
split demobusinessactivity
destring demobusinessactivity1 demobusinessactivity2 demobusinessactivity3 demobusinessactivity4 demobusinessactivity5 demobusinessactivity6 demobusinessactivity7, replace
recode demobusinessactivity1 demobusinessactivity2 demobusinessactivity3 demobusinessactivity4 demobusinessactivity5 demobusinessactivity6 (77=9)
forvalues i=1/9 {
gen demobusinessactivity_`i'=0 if demobusinessactivity!=""
} 
forvalues i=1/9 {
replace demobusinessactivity_`i'=1 if demobusinessactivity1==`i'
replace demobusinessactivity_`i'=1 if demobusinessactivity2==`i'
replace demobusinessactivity_`i'=1 if demobusinessactivity3==`i'
replace demobusinessactivity_`i'=1 if demobusinessactivity4==`i'
replace demobusinessactivity_`i'=1 if demobusinessactivity5==`i'
replace demobusinessactivity_`i'=1 if demobusinessactivity6==`i'
replace demobusinessactivity_`i'=1 if demobusinessactivity7==`i'
label values demobusinessactivity_`i' dummybusinesslabourers
label var demobusinessactivity_`i' "demobusinessactivity=`i'"
}
rename demobusinessactivity_1 demobusinessactivity_lesin
rename demobusinessactivity_2 demobusinessactivity_cainp
rename demobusinessactivity_3 demobusinessactivity_difse
rename demobusinessactivity_4 demobusinessactivity_caspa
rename demobusinessactivity_5 demobusinessactivity_paymo
rename demobusinessactivity_6 demobusinessactivity_frequ
rename demobusinessactivity_7 demobusinessactivity_press
rename demobusinessactivity_8 demobusinessactivity_contr
rename demobusinessactivity_9 demobusinessactivity_other
drop demobusinessactivity1 demobusinessactivity2 demobusinessactivity3 demobusinessactivity4 demobusinessactivity5 demobusinessactivity6 demobusinessactivity7
order demobusinessactivity_lesin demobusinessactivity_cainp demobusinessactivity_difse demobusinessactivity_caspa demobusinessactivity_paymo demobusinessactivity_frequ demobusinessactivity_press demobusinessactivity_contr demobusinessactivity_other, after(demobusinessactivity)

replace demobusinessactivityother="" if demobusinessactivityother=="."
replace demobusinesskindofjob="" if demobusinesskindofjob=="."



********** Salaried job
replace joblocation="" if (kindofwork==1 | kindofwork==2) & joblocation!=""
replace jobdistance=. if (kindofwork==1 | kindofwork==2)
replace relationemployer="" if relationemployer=="."
replace casteemployer="" if casteemployer=="."

split relationemployer
destring relationemployer1 relationemployer2 relationemployer3 relationemployer4 relationemployer5 relationemployer6, replace
recode relationemployer1 relationemployer2 relationemployer3 relationemployer4 relationemployer5 relationemployer6 (66=12) (99=13)
forvalues i=1/13 {
gen relationemployer_`i'=0 if relationemployer!=""
} 
forvalues i=1/13 {
replace relationemployer_`i'=1 if relationemployer1==`i'
replace relationemployer_`i'=1 if relationemployer2==`i'
replace relationemployer_`i'=1 if relationemployer3==`i'
replace relationemployer_`i'=1 if relationemployer4==`i'
replace relationemployer_`i'=1 if relationemployer5==`i'
replace relationemployer_`i'=1 if relationemployer6==`i'
label values relationemployer_`i' dummybusinesslabourers
label var relationemployer_`i' "relationemployer=`i'"
}
rename relationemployer_1 relationemployer_labo
rename relationemployer_2 relationemployer_rela
rename relationemployer_3 relationemployer_poli
rename relationemployer_4 relationemployer_reli
rename relationemployer_5 relationemployer_neig
rename relationemployer_6 relationemployer_shg
rename relationemployer_7 relationemployer_busi
rename relationemployer_8 relationemployer_wkp
rename relationemployer_9 relationemployer_trad
rename relationemployer_10 relationemployer_frie
rename relationemployer_11 relationemployer_gfin
rename relationemployer_12 relationemployer_na
rename relationemployer_13 relationemployer_nr
drop relationemployer1 relationemployer2 relationemployer3 relationemployer4 relationemployer5 relationemployer6
order relationemployer_labo relationemployer_rela relationemployer_poli relationemployer_reli relationemployer_neig relationemployer_shg relationemployer_busi relationemployer_wkp relationemployer_trad relationemployer_frie relationemployer_gfin relationemployer_na relationemployer_nr, after(relationemployer)

split casteemployer
destring casteemployer*, replace
recode casteemployer1 casteemployer2 casteemployer3 casteemployer4 casteemployer5 casteemployer6 casteemployer7 casteemployer8 casteemployer9 casteemployer10 casteemployer11 (66=17) (77=18)
forvalues i=1/18 {
gen casteemployer_`i'=0 if casteemployer!=""
} 
forvalues i=1/13 {
replace casteemployer_`i'=1 if casteemployer1==`i'
replace casteemployer_`i'=1 if casteemployer2==`i'
replace casteemployer_`i'=1 if casteemployer3==`i'
replace casteemployer_`i'=1 if casteemployer4==`i'
replace casteemployer_`i'=1 if casteemployer5==`i'
replace casteemployer_`i'=1 if casteemployer6==`i'
replace casteemployer_`i'=1 if casteemployer7==`i'
replace casteemployer_`i'=1 if casteemployer8==`i'
replace casteemployer_`i'=1 if casteemployer9==`i'
replace casteemployer_`i'=1 if casteemployer10==`i'
replace casteemployer_`i'=1 if casteemployer11==`i'
label values casteemployer_`i' dummybusinesslabourers
label var casteemployer_`i' "casteemployer=`i'"
}
rename casteemployer_1 casteemployer_vanni
rename casteemployer_2 casteemployer_sc
rename casteemployer_3 casteemployer_arunt
rename casteemployer_4 casteemployer_rediy
rename casteemployer_5 casteemployer_grama
rename casteemployer_6 casteemployer_naidu
rename casteemployer_7 casteemployer_navit
rename casteemployer_8 casteemployer_asara
rename casteemployer_9 casteemployer_settu
rename casteemployer_10 casteemployer_natta
rename casteemployer_11 casteemployer_mudal
rename casteemployer_12 casteemployer_kulal
rename casteemployer_13 casteemployer_chett
rename casteemployer_14 casteemployer_marwa
rename casteemployer_15 casteemployer_musli
rename casteemployer_16 casteemployer_paday
rename casteemployer_17 casteemployer_na
rename casteemployer_18 casteemployer_other
drop casteemployer1 casteemployer2 casteemployer3 casteemployer4 casteemployer5 casteemployer6 casteemployer7 casteemployer8 casteemployer9 casteemployer10 casteemployer11
order casteemployer_vanni casteemployer_sc casteemployer_arunt casteemployer_rediy casteemployer_grama casteemployer_naidu casteemployer_navit casteemployer_asara casteemployer_settu casteemployer_natta casteemployer_mudal casteemployer_kulal casteemployer_chett casteemployer_marwa casteemployer_musli casteemployer_paday casteemployer_na casteemployer_other, after(casteemployer)


********** . as ""
foreach x in othercasteemployer effetdemowage salariedjobkindbonus demosalariedjob demosalariedjobother {
replace `x'="" if `x'=="."
}




********** Suite au rapport stat



*** demojobtype
fre demojobtype
label define demojobtype 1"Permanent" 2"Fixed term" 3"Daily" 4"Seasonal" 5"Occasional"
label values demojobtype demojobtype
ta demojobtype


fre demowagetype
label define demowagetype 1"Daily" 2"Weekly" 3"Monthly" 4"Piece rate" 5"Unpaid"
label values demowagetype demowagetype
ta demowagetype

splitvarmcq effetdemowage 7
newn effetdemowage 1 salinc
newn effetdemowage 2 lessal
newn effetdemowage 3 delay
newn effetdemowage 4 advanc
newn effetdemowage 5 more
newn effetdemowage 6 less
newn effetdemowage 7 noimp

splitvarmcq demosalariedjob 6
newn demosalariedjob 1 morebarg
newn demosalariedjob 2 morediff
newn demosalariedjob 3 moresecu
newn demosalariedjob 4 lesssecu
newn demosalariedjob 5 signwrit
newn demosalariedjob 6 demand

drop casteemployer_vanni casteemployer_sc casteemployer_arunt casteemployer_rediy casteemployer_grama casteemployer_naidu casteemployer_navit casteemployer_asara casteemployer_settu casteemployer_natta casteemployer_mudal casteemployer_kulal casteemployer_chett casteemployer_marwa casteemployer_musli casteemployer_paday casteemployer_na casteemployer_other

ta casteemployer
splitvarmcq casteemployer 16
newn casteemployer 1 van
newn casteemployer 2 sc
newn casteemployer 3 aru
newn casteemployer 4 red
newn casteemployer 5 gra
newn casteemployer 6 nai
newn casteemployer 7 nav
newn casteemployer 8 asa
newn casteemployer 9 set
newn casteemployer 10 nat
newn casteemployer 11 mud
newn casteemployer 12 kul
newn casteemployer 13 che
newn casteemployer 14 mar
newn casteemployer 15 mus
newn casteemployer 16 pad












save"Last/NEEMSIS1-occupations", replace
****************************************
* END






















****************************************
* NEEMSIS1-loans_mainloans.dta
****************************************
use"NEEMSIS1-loans_mainloans", clear

ta demokindloan
label define demokindloan 1"Old notes" 2"New notes" 3"Both" 4"Transfer"
label values demokindloan demokindloan

recode lenderscaste (.=66)


********** Effective
ta loaneffectivereason
split loaneffectivereason
destring loaneffect~1  loaneffect~2  loaneffect~3  loaneffect~4  loaneffect~5  loaneffect~6, replace
recode loaneffect~1  loaneffect~2  loaneffect~3  loaneffect~4  loaneffect~5  loaneffect~6 (77=13)
forvalues i=1/13 {
gen loaneffectivereason_`i'=0 if loaneffectivereason!=""
}
forvalues i=1/13 {
replace loaneffectivereason_`i'=1 if loaneffectivereason1==`i'
replace loaneffectivereason_`i'=1 if loaneffectivereason2==`i'
replace loaneffectivereason_`i'=1 if loaneffectivereason3==`i'
replace loaneffectivereason_`i'=1 if loaneffectivereason4==`i'
replace loaneffectivereason_`i'=1 if loaneffectivereason5==`i'
replace loaneffectivereason_`i'=1 if loaneffectivereason6==`i'
label values loaneffectivereason_`i' dummyinterest
label var loaneffectivereason_`i' "loaneffectivereason=`i'"
}
rename loaneffectivereason_1 loaneffectivereason_agri
rename loaneffectivereason_2 loaneffectivereason_fami
rename loaneffectivereason_3 loaneffectivereason_heal
rename loaneffectivereason_4 loaneffectivereason_repa
rename loaneffectivereason_5 loaneffectivereason_hous
rename loaneffectivereason_6 loaneffectivereason_inve
rename loaneffectivereason_7 loaneffectivereason_cere
rename loaneffectivereason_8 loaneffectivereason_marr
rename loaneffectivereason_9 loaneffectivereason_educ
rename loaneffectivereason_10 loaneffectivereason_rela
rename loaneffectivereason_11 loaneffectivereason_deat
rename loaneffectivereason_12 loaneffectivereason_nore
rename loaneffectivereason_13 loaneffectivereason_othe
drop loaneffectivereason1 loaneffectivereason2 loaneffectivereason3 loaneffectivereason4 loaneffectivereason5 loaneffectivereason6
order loaneffectivereason_agri loaneffectivereason_fami loaneffectivereason_heal loaneffectivereason_repa loaneffectivereason_hous loaneffectivereason_inve loaneffectivereason_cere loaneffectivereason_marr loaneffectivereason_educ loaneffectivereason_rela loaneffectivereason_deat loaneffectivereason_nore loaneffectivereason_othe, after(loaneffectivereason)


replace demoloanreason="" if demoloanreason=="."
split demoloanreason
destring demoloanreason1 demoloanreason2 demoloanreason3, replace
recode demoloanreason1 demoloanreason2 demoloanreason3 (77=6)
forvalues i=1/6 {
gen demoloanreason_`i'=0 if demoloanreason!=""
}
forvalues i=1/6 {
replace demoloanreason_`i'=1 if demoloanreason1==`i'
replace demoloanreason_`i'=1 if demoloanreason2==`i'
replace demoloanreason_`i'=1 if demoloanreason3==`i'
label values demoloanreason_`i' dummyinterest
label var demoloanreason_`i' "demoloanreason=`i'"
}
rename demoloanreason_1 demoloanreason_cash
rename demoloanreason_2 demoloanreason_acce
rename demoloanreason_3 demoloanreason_lowe
rename demoloanreason_4 demoloanreason_comm
rename demoloanreason_5 demoloanreason_node
rename demoloanreason_6 demoloanreason_othe
drop demoloanreason1 demoloanreason2 demoloanreason3
order demoloanreason_cash demoloanreason_acce demoloanreason_lowe demoloanreason_comm demoloanreason_node demoloanreason_othe, after(demoloanreason)

replace loanotherreasongiven="" if loanotherreasongiven=="."

label define loanlender 1"WKP" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn broker" 7"Shop keeper" 8"Finance" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mill loan" 14"Group finance"
label values loanlender loanlender

split lenderrelation
destring lenderrelation1 lenderrelation2 lenderrelation3, replace
recode lenderrelation1 lenderrelation2 lenderrelation3 (66=12) (99=13)
forvalues i=1/13 {
gen lenderrelation_`i'=0 if lenderrelation!=""
}
forvalues i=1/13 {
replace lenderrelation_`i'=1 if lenderrelation1==`i'
replace lenderrelation_`i'=1 if lenderrelation2==`i'
replace lenderrelation_`i'=1 if lenderrelation3==`i'
label values lenderrelation_`i' dummyinterest
label var lenderrelation_`i' "lenderrelation=`i'"
}
rename lenderrelation_1 lenderrelation_labo
rename lenderrelation_2 lenderrelation_rela
rename lenderrelation_3 lenderrelation_poli
rename lenderrelation_4 lenderrelation_reli
rename lenderrelation_5 lenderrelation_neig
rename lenderrelation_6 lenderrelation_shg
rename lenderrelation_7 lenderrelation_busi
rename lenderrelation_8 lenderrelation_wkp
rename lenderrelation_9 lenderrelation_tradi
rename lenderrelation_10 lenderrelation_frie
rename lenderrelation_11 lenderrelation_gpfi
rename lenderrelation_12 lenderrelation_na
rename lenderrelation_13 lenderrelation_nr
drop lenderrelation1 lenderrelation2 lenderrelation3
order lenderrelation_labo lenderrelation_rela lenderrelation_poli lenderrelation_reli lenderrelation_neig lenderrelation_shg lenderrelation_busi lenderrelation_wkp lenderrelation_tradi lenderrelation_frie lenderrelation_gpfi lenderrelation_na lenderrelation_nr, after(lenderrelation)

split otherlenderservices
destring otherlenderservices1 otherlenderservices2 otherlenderservices3, replace
recode otherlenderservices1 otherlenderservices2 otherlenderservices3 (77=6)
forvalues i=1/6 {
gen otherlenderservices_`i'=0 if otherlenderservices!=""
}
forvalues i=1/6 {
replace otherlenderservices_`i'=1 if otherlenderservices1==`i'
replace otherlenderservices_`i'=1 if otherlenderservices2==`i'
replace otherlenderservices_`i'=1 if otherlenderservices3==`i'
label values otherlenderservices_`i' dummyinterest
label var otherlenderservices_`i' "otherlenderservices=`i'"
}
rename otherlenderservices_1 otherlenderservices_poli
rename otherlenderservices_2 otherlenderservices_fina
rename otherlenderservices_3 otherlenderservices_guar
rename otherlenderservices_4 otherlenderservices_gene
rename otherlenderservices_5 otherlenderservices_none
rename otherlenderservices_6 otherlenderservices_othe
drop otherlenderservices1 otherlenderservices2 otherlenderservices3
order otherlenderservices_poli otherlenderservices_fina otherlenderservices_guar otherlenderservices_gene otherlenderservices_none otherlenderservices_othe, after(otherlenderservices)

replace demoshg="" if demoshg=="."
split demoshg
destring demoshg1 demoshg2, replace
forvalues i=1/5 {
gen demoshg_`i'=0 if demoshg!=""
}
forvalues i=1/5 {
replace demoshg_`i'=1 if demoshg1==`i'
replace demoshg_`i'=1 if demoshg2==`i'
label values demoshg_`i' dummyinterest
label var demoshg_`i' "demoshg=`i'"
}
rename demoshg_1 demoshg_mback
rename demoshg_2 demoshg_shgac
rename demoshg_3 demoshg_newsh
rename demoshg_4 demoshg_nopro
rename demoshg_5 demoshg_other
drop demoshg1 demoshg2
order demoshg_mback demoshg_shgac demoshg_newsh demoshg_nopro demoshg_other, after(demoshg)

gen dummymainloan=0
replace dummymainloan=1 if lendersex!=.
label values dummymainloan dummyinterest
ta dummymainloan
order dummymainloan, after(lendername)

tab borrowerservices
split borrowerservices, destring
recode borrowerservices1 borrowerservices2 borrowerservices3 (77=5)
forvalues i=1/5{
gen borrowerservices_`i'=0 if borrowerservices!=""
}
forvalues i=1/5{
replace borrowerservices_`i'=1 if borrowerservices1==`i'
replace borrowerservices_`i'=1 if borrowerservices2==`i'
replace borrowerservices_`i'=1 if borrowerservices3==`i'
label var borrowerservices_`i' "borrowerservices=`i'"
label values borrowerservices_`i' dummyinterest
}
rename borrowerservices_1 borrowerservices_free
rename borrowerservices_2 borrowerservices_work
rename borrowerservices_3 borrowerservices_supp
rename borrowerservices_4 borrowerservices_none
rename borrowerservices_5 borrowerservices_othe
drop borrowerservices1 borrowerservices2 borrowerservices3
order borrowerservices_free borrowerservices_work borrowerservices_supp borrowerservices_none borrowerservices_othe, after(borrowerservices)

***
ta plantorepay
split plantorepay, destring
recode plantorepay1 plantorepay2 plantorepay3 plantorepay4 (77=7)
forvalues i=1/7{
gen plantorepay_`i'=0 if plantorepay!=""
}
forvalues i=1/7 {
replace plantorepay_`i'=1 if plantorepay1==`i'
replace plantorepay_`i'=1 if plantorepay2==`i'
replace plantorepay_`i'=1 if plantorepay3==`i'
replace plantorepay_`i'=1 if plantorepay4==`i'
label values plantorepay_`i' dummyinterest
label var plantorepay_`i' "plantorepay=`i'
}
rename plantorepay_1 plantorepay_chit
rename plantorepay_2 plantorepay_work
rename plantorepay_3 plantorepay_migr
rename plantorepay_4 plantorepay_asse
rename plantorepay_5 plantorepay_inco
rename plantorepay_6 plantorepay_borr
rename plantorepay_7 plantorepay_othe
drop plantorepay1 plantorepay2 plantorepay3 plantorepay4
order plantorepay_chit plantorepay_work plantorepay_migr plantorepay_asse plantorepay_inco plantorepay_borr plantorepay_othe, after(plantorepay)

ta settleloanstrategy
split settleloanstrategy, destring
recode settleloanstrategy1 settleloanstrategy2 settleloanstrategy3 settleloanstrategy4 settleloanstrategy5 settleloanstrategy6 settleloanstrategy7 (77=11)
forvalues i=1/11 {
gen settleloanstrategy_`i'=0 if settleloanstrategy!=""
}
forvalues i=1/11 {
replace settleloanstrategy_`i'=1 if settleloanstrategy1==`i'
replace settleloanstrategy_`i'=1 if settleloanstrategy2==`i'
replace settleloanstrategy_`i'=1 if settleloanstrategy3==`i'
replace settleloanstrategy_`i'=1 if settleloanstrategy4==`i'
replace settleloanstrategy_`i'=1 if settleloanstrategy5==`i'
replace settleloanstrategy_`i'=1 if settleloanstrategy6==`i'
replace settleloanstrategy_`i'=1 if settleloanstrategy7==`i'
label values settleloanstrategy_`i' dummyinterest
label var settleloanstrategy_`i' "settleloanstrategy=`i'"
}
rename settleloanstrategy_1 settleloanstrategy_labo
rename settleloanstrategy_2 settleloanstrategy_sche
rename settleloanstrategy_3 settleloanstrategy_borr
rename settleloanstrategy_4 settleloanstrategy_sell
rename settleloanstrategy_5 settleloanstrategy_land
rename settleloanstrategy_6 settleloanstrategy_cons
rename settleloanstrategy_7 settleloanstrategy_adjo
rename settleloanstrategy_8 settleloanstrategy_work
rename settleloanstrategy_9 settleloanstrategy_supp
rename settleloanstrategy_10 settleloanstrategy_harv
rename settleloanstrategy_11 settleloanstrategy_othe
drop settleloanstrategy1 settleloanstrategy2 settleloanstrategy3 settleloanstrategy4 settleloanstrategy5 settleloanstrategy6 settleloanstrategy7
order settleloanstrategy_labo settleloanstrategy_sche settleloanstrategy_borr settleloanstrategy_sell settleloanstrategy_land settleloanstrategy_cons settleloanstrategy_adjo settleloanstrategy_work settleloanstrategy_supp settleloanstrategy_harv settleloanstrategy_othe, after(settleloanstrategy)


***
ta loanproductpledge
split loanproductpledge, destring
forvalues i=1/15 {
gen loanproductpledge_`i'=0 if loanproductpledge!=""
}
forvalues i=1/15 {
replace loanproductpledge_`i'=1 if loanproductpledge1==`i'
replace loanproductpledge_`i'=1 if loanproductpledge2==`i'
label values loanproductpledge_`i' dummyinterest
label var loanproductpledge_`i' "loanproductpledge=`i'"
}
rename loanproductpledge_1 loanproductpledge_gold
rename loanproductpledge_2 loanproductpledge_land
rename loanproductpledge_3 loanproductpledge_car
rename loanproductpledge_4 loanproductpledge_bike
rename loanproductpledge_5 loanproductpledge_frid
rename loanproductpledge_6 loanproductpledge_furn
rename loanproductpledge_7 loanproductpledge_tail
rename loanproductpledge_8 loanproductpledge_cell
rename loanproductpledge_9 loanproductpledge_line
rename loanproductpledge_10 loanproductpledge_dvd
rename loanproductpledge_11 loanproductpledge_came
rename loanproductpledge_12 loanproductpledge_gas
rename loanproductpledge_13 loanproductpledge_comp
rename loanproductpledge_14 loanproductpledge_dish
rename loanproductpledge_15 loanproductpledge_none
drop loanproductpledge1 loanproductpledge2
order loanproductpledge_gold loanproductpledge_land loanproductpledge_car loanproductpledge_bike loanproductpledge_frid loanproductpledge_furn loanproductpledge_tail loanproductpledge_cell loanproductpledge_line loanproductpledge_dvd loanproductpledge_came loanproductpledge_gas loanproductpledge_comp loanproductpledge_dish loanproductpledge_none, after(loanproductpledge)

rename loanproductpledgeaamount loanproductpledgeamount

ta helptosettleloan
replace helptosettleloan="" if helptosettleloan=="."
split helptosettleloan, destring
forvalues i=1/15 {
gen helptosettleloan_`i'=0 if helptosettleloan!=""
}
forvalues i=1/15 {
replace helptosettleloan_`i'=1 if helptosettleloan1==`i'
replace helptosettleloan_`i'=1 if helptosettleloan2==`i'
replace helptosettleloan_`i'=1 if helptosettleloan3==`i'
label values helptosettleloan_`i' dummyinterest
label var helptosettleloan_`i' "helptosettleloan=`i'"
}
rename helptosettleloan_1 helptosettleloan_mais
rename helptosettleloan_2 helptosettleloan_chil
rename helptosettleloan_3 helptosettleloan_sibl
rename helptosettleloan_4 helptosettleloan_pare
rename helptosettleloan_5 helptosettleloan_niec
rename helptosettleloan_6 helptosettleloan_othe
rename helptosettleloan_7 helptosettleloan_neig
rename helptosettleloan_8 helptosettleloan_frie
rename helptosettleloan_9 helptosettleloan_cust
rename helptosettleloan_10 helptosettleloan_mone
rename helptosettleloan_11 helptosettleloan_shg
rename helptosettleloan_12 helptosettleloan_empl
rename helptosettleloan_13 helptosettleloan_wkp
rename helptosettleloan_14 helptosettleloan_own
rename helptosettleloan_15 helptosettleloan_spou
drop helptosettleloan1 helptosettleloan2 helptosettleloan3
order helptosettleloan_mais helptosettleloan_chil helptosettleloan_sibl helptosettleloan_pare helptosettleloan_niec helptosettleloan_othe helptosettleloan_neig helptosettleloan_frie helptosettleloan_cust helptosettleloan_mone helptosettleloan_shg helptosettleloan_empl helptosettleloan_wkp helptosettleloan_own helptosettleloan_spou, after(helptosettleloan)

replace problemdelayrepayment="" if problemdelayrepayment=="."
split problemdelayrepayment, destring
recode problemdelayrepayment1 problemdelayrepayment2 problemdelayrepayment3 (77=6)
forvalues i=1/6 {
gen problemdelayrepayment_`i'=0 if problemdelayrepayment!=""
}
forvalues i=1/6 {
replace problemdelayrepayment_`i'=1 if problemdelayrepayment1==`i'
replace problemdelayrepayment_`i'=1 if problemdelayrepayment2==`i'
replace problemdelayrepayment_`i'=1 if problemdelayrepayment3==`i'
label values problemdelayrepayment_`i' dummyinterest
label var problemdelayrepayment_`i' "problemdelayrepayment=`i'"
}
rename problemdelayrepayment_1 problemdelayrepayment_noth
rename problemdelayrepayment_2 problemdelayrepayment_shou
rename problemdelayrepayment_3 problemdelayrepayment_pres
rename problemdelayrepayment_4 problemdelayrepayment_comp
rename problemdelayrepayment_5 problemdelayrepayment_info
rename problemdelayrepayment_6 problemdelayrepayment_othe
drop problemdelayrepayment1 problemdelayrepayment2 problemdelayrepayment3
order problemdelayrepayment_noth problemdelayrepayment_shou problemdelayrepayment_pres problemdelayrepayment_comp problemdelayrepayment_info problemdelayrepayment_othe, after(problemdelayrepayment)


***
replace recommendloanrelation="" if recommendloanrelation=="."
split recommendloanrelation, destring
forvalues i=1/11 {
gen recommendloanrelation_`i'=0 if recommendloanrelation!=""
}
forvalues i=1/11 {
replace recommendloanrelation_`i'=1 if recommendloanrelation1==`i'
replace recommendloanrelation_`i'=1 if recommendloanrelation2==`i'
label var recommendloanrelation_`i' "recommendloanrelation=`i'"
label values recommendloanrelation_`i' dummyinterest
}
rename recommendloanrelation_1 recommendloanrelation_labo
rename recommendloanrelation_2 recommendloanrelation_rela
rename recommendloanrelation_3 recommendloanrelation_poli
rename recommendloanrelation_4 recommendloanrelation_reli
rename recommendloanrelation_5 recommendloanrelation_neig
rename recommendloanrelation_6 recommendloanrelation_shg
rename recommendloanrelation_7 recommendloanrelation_busi
rename recommendloanrelation_8 recommendloanrelation_wkp
rename recommendloanrelation_9 recommendloanrelation_trad
rename recommendloanrelation_10 recommendloanrelation_frie
rename recommendloanrelation_11 recommendloanrelation_gpfin
drop recommendloanrelation1 recommendloanrelation2
order recommendloanrelation_labo recommendloanrelation_rela recommendloanrelation_poli recommendloanrelation_reli recommendloanrelation_neig recommendloanrelation_shg recommendloanrelation_busi recommendloanrelation_wkp recommendloanrelation_trad recommendloanrelation_frie recommendloanrelation_gpfin, after(recommendloanrelation)

**
ta guarantorloanrelation
split guarantorloanrelation, destring
recode guarantorloanrelation1 guarantorloanrelation2 (99=12)
forvalues i=1/12 {
gen guarantorloanrelation_`i'=0 if guarantorloanrelation!=""
}
forvalues i=1/12 {
replace guarantorloanrelation_`i'=1 if guarantorloanrelation1==`i'
replace guarantorloanrelation_`i'=1 if guarantorloanrelation2==`i'
label values guarantorloanrelation_`i' dummyinterest
label var guarantorloanrelation_`i' "guarantorloanrelation=`i'"
}
rename guarantorloanrelation_1 guarantorloanrelation_labo
rename guarantorloanrelation_2 guarantorloanrelation_rela
rename guarantorloanrelation_3 guarantorloanrelation_poli
rename guarantorloanrelation_4 guarantorloanrelation_reli
rename guarantorloanrelation_5 guarantorloanrelation_neig
rename guarantorloanrelation_6 guarantorloanrelation_shg
rename guarantorloanrelation_7 guarantorloanrelation_busi
rename guarantorloanrelation_8 guarantorloanrelation_wkp
rename guarantorloanrelation_9 guarantorloanrelation_trad
rename guarantorloanrelation_10 guarantorloanrelation_frie
rename guarantorloanrelation_11 guarantorloanrelation_gpfin
rename guarantorloanrelation_12 guarantorloanrelation_nr
drop guarantorloanrelation1 guarantorloanrelation2
order guarantorloanrelation_labo guarantorloanrelation_rela guarantorloanrelation_poli guarantorloanrelation_reli guarantorloanrelation_neig guarantorloanrelation_shg guarantorloanrelation_busi guarantorloanrelation_wkp guarantorloanrelation_trad guarantorloanrelation_frie guarantorloanrelation_gpfin guarantorloanrelation_nr, after(guarantorloanrelation)

** 
ta guarantee
split guarantee, destring
recode guarantee1 guarantee2 guarantee3 (77=7)
forvalues i=1/7 {
gen guarantee_`i'=0 if guarantee!=""
}
forvalues i=1/7 {
replace guarantee_`i'=1 if guarantee1==`i'
replace guarantee_`i'=1 if guarantee1==`i'
replace guarantee_`i'=1 if guarantee3==`i'
label values guarantee_`i' dummyinterest
label var guarantee_`i' "guarantee=`i'"
}
rename guarantee_1 guarantee_docu
rename guarantee_2 guarantee_chit
rename guarantee_3 guarantee_shg
rename guarantee_4 guarantee_pers
rename guarantee_5 guarantee_jewe
rename guarantee_6 guarantee_none
rename guarantee_7 guarantee_other
drop guarantee1 guarantee2 guarantee3
order guarantee_docu guarantee_chit guarantee_shg guarantee_pers guarantee_jewe guarantee_none guarantee_other, after(guarantee)



********** . as ""
foreach x in loanothereffectivereason demoloanotherreason otherlenderservicesother borrowerservicesother plantorepayother settleloanstrategyother problemdelayrepaymentother guaranteeother {
replace `x'="" if `x'=="."
}




save"Last/NEEMSIS1-loans_mainloans", replace
****************************************
* END
















****************************************
* NEEMSIS1-migrations.dta
****************************************
use"NEEMSIS1-migrations", clear

********** . as ""
foreach x in demoadvancetransfer demorefusedadvanceinc demoacceptadvanceinc demoperceptionadvancedec advancebalanceproblem demoadvancereasonrefused {
replace `x'="" if `x'=="."
}


********** Clean

*
ta migrationarea
split migrationarea, destring
label define migrationarea 1"Around village" 2"Rural area in Tamil Nadu" 3"Small town of the area (Panruti, Cuddalore, Viluppuram, etc.)" 4"Big cities of Tamil Nadu (Chennai, Pondicherry, Madurai, etc.)" 5"Rural area outside Tamil Nadu" 6"Cities outside Tamil Nadu"
label values migrationarea1 migrationarea
label values migrationarea2 migrationarea
label values migrationarea3 migrationarea
order migrationarea1 migrationarea2 migrationarea3, after(migrationarea)
drop migrationarea

*
ta migrationfindjob
split migrationfindjob, destring
forvalues i=1/6 {
gen migrationfindjob_`i'=0 if migrationfindjob!=""
}
forvalues i=1/6 {
replace migrationfindjob_`i'=1 if migrationfindjob1==`i'
replace migrationfindjob_`i'=1 if migrationfindjob1==`i'
replace migrationfindjob_`i'=1 if migrationfindjob3==`i'
label define yesno 0"No" 1"Yes", replace
label values migrationfindjob_`i' yesno
label var migrationfindjob_`i' "migrationfindjob=`i'"
}
rename migrationfindjob_1 migrationfindjob_mais
rename migrationfindjob_2 migrationfindjob_frie
rename migrationfindjob_3 migrationfindjob_know
rename migrationfindjob_4 migrationfindjob_them
rename migrationfindjob_5 migrationfindjob_adve
rename migrationfindjob_6 migrationfindjob_regu
drop migrationfindjob1 migrationfindjob2 migrationfindjob3
order migrationfindjob_mais migrationfindjob_frie migrationfindjob_know migrationfindjob_them migrationfindjob_adve migrationfindjob_regu, after(migrationfindjob)

*
label values demodeclineadvance yesno
ta demodeclineadvance

*
ta demoadvancereasonrefused
destring demoadvancereasonrefused, replace
label define demoadvancereasonrefused 1"Because advance has increased" 2"Don't know how to exchange the cash (if old notes)" 3"Too much advance and don't know how to repay" 4"Afraid of consequences" 5"Support government norms/don't want to receive old notes" 6"Because advance has decreased to much" 7"Because delay payment of advance" 77"Other"
label values demoadvancereasonrefused demoadvancereasonrefused


*
ta demoadvancetransfer
split demoadvancetransfer, destring
forvalues i=1/6 {
gen demoadvancetransfer_`i'=0 if demoadvancetransfer!=""
}
forvalues i=1/6 {
replace demoadvancetransfer_`i'=1 if demoadvancetransfer1==`i'
replace demoadvancetransfer_`i'=1 if demoadvancetransfer2==`i'
replace demoadvancetransfer_`i'=1 if demoadvancetransfer3==`i'
label values demoadvancetransfer_`i' yesno
label var demoadvancetransfer_`i' "demoadvancetransfer=`i'"
}
rename demoadvancetransfer_1 demoadvancetransfer_part
rename demoadvancetransfer_2 demoadvancetransfer_oldn
rename demoadvancetransfer_3 demoadvancetransfer_newn
rename demoadvancetransfer_4 demoadvancetransfer_wire
rename demoadvancetransfer_5 demoadvancetransfer_depo
rename demoadvancetransfer_6 demoadvancetransfer_notr
drop demoadvancetransfer1 demoadvancetransfer2 demoadvancetransfer3
order demoadvancetransfer_part demoadvancetransfer_oldn demoadvancetransfer_newn demoadvancetransfer_wire demoadvancetransfer_depo demoadvancetransfer_notr, after(demoadvancetransfer)


*
ta demoadvancevar
label define demoadvancevar 1"Advance increased and I accepted it" 2"Advance increased but I delined/refused it" 3"Advance is less" 4"Same"
label values demoadvancevar demoadvancevar

* 
ta demoperceptionadvancedec
split demoperceptionadvancedec, destring
forvalues i=1/4 {
gen demoperceptionadvancedec_`i'=0 if demoperceptionadvancedec!=""
}
forvalues i=1/4 {
replace demoperceptionadvancedec_`i'=1 if demoperceptionadvancedec1==`i'
replace demoperceptionadvancedec_`i'=1 if demoperceptionadvancedec2==`i'
label values demoperceptionadvancedec_`i' yesno
label var demoperceptionadvancedec_`i' "demoperceptionadvancedec=`i'"
}
rename demoperceptionadvancedec_1 demoperceptionadvancedec_lessm
rename demoperceptionadvancedec_2 demoperceptionadvancedec_jobse
rename demoperceptionadvancedec_3 demoperceptionadvancedec_repay
rename demoperceptionadvancedec_4 demoperceptionadvancedec_negoc
drop demoperceptionadvancedec1 demoperceptionadvancedec2
order demoperceptionadvancedec_lessm demoperceptionadvancedec_jobse demoperceptionadvancedec_repay demoperceptionadvancedec_negoc, after(demoperceptionadvancedec)


*
ta advancebalanceproblem
split advancebalanceproblem, destring
forvalues i=1/6 {
gen advancebalanceproblem_`i'=0 if advancebalanceproblem!=""
}
forvalues i=1/6 {
replace advancebalanceproblem_`i'=1 if advancebalanceproblem1==`i'
replace advancebalanceproblem_`i'=1 if advancebalanceproblem2==`i'
label values advancebalanceproblem_`i' yesno
label var advancebalanceproblem_`i' "advancebalanceproblem=`i'"
}
rename advancebalanceproblem_1 advancebalanceproblem_same
rename advancebalanceproblem_2 advancebalanceproblem_samele
rename advancebalanceproblem_3 advancebalanceproblem_scoled
rename advancebalanceproblem_4 advancebalanceproblem_neverg
rename advancebalanceproblem_5 advancebalanceproblem_compla
rename advancebalanceproblem_6 advancebalanceproblem_nothin
drop advancebalanceproblem1 advancebalanceproblem2
order advancebalanceproblem_same advancebalanceproblem_samele advancebalanceproblem_scoled advancebalanceproblem_neverg advancebalanceproblem_compla advancebalanceproblem_nothin, after(advancebalanceproblem)

*
ta migrationskill
split migrationskill, destring
forvalues i=1/5 {
gen migrationskill_`i'=0 if migrationskill!=""
}
forvalues i=1/5 {
replace migrationskill_`i'=1 if migrationskill1==`i'
replace migrationskill_`i'=1 if migrationskill2==`i'
replace migrationskill_`i'=1 if migrationskill3==`i'
replace migrationskill_`i'=1 if migrationskill4==`i'
label values migrationskill_`i' yesno
label var migrationskill_`i' "migrationskill=`i'"
}
rename migrationskill_1 migrationskill_expe
rename migrationskill_2 migrationskill_educ
rename migrationskill_3 migrationskill_skil
rename migrationskill_4 migrationskill_netw
rename migrationskill_5 migrationskill_noth
drop migrationskill1 migrationskill2 migrationskill3 migrationskill4
order migrationskill_expe migrationskill_educ migrationskill_skil migrationskill_netw migrationskill_noth, after(migrationskill)


* 
ta migrationreason
split migrationreason, destring
foreach i in 1 2 3 4 5 6 7 8 9 10 77 {
gen migrationreason_`i'=0 if migrationreason!=""
}
foreach i in 1 2 3 4 5 6 7 8 9 10 77 {
replace migrationreason_`i'=1 if migrationreason1==`i'
replace migrationreason_`i'=1 if migrationreason2==`i'
label values migrationreason_`i' yesno
label var migrationreason_`i' "migrationreason=`i'"
}
rename migrationreason_1 migrationreason_nowo
rename migrationreason_2 migrationreason_adva
rename migrationreason_3 migrationreason_assu
rename migrationreason_4 migrationreason_repa
rename migrationreason_5 migrationreason_oppo
rename migrationreason_6 migrationreason_inte
rename migrationreason_7 migrationreason_earn
rename migrationreason_8 migrationreason_dive
rename migrationreason_9 migrationreason_stat
rename migrationreason_10 migrationreason_know
rename migrationreason_77 migrationreason_othe
drop migrationreason1 migrationreason2
order migrationreason_nowo migrationreason_adva migrationreason_assu migrationreason_repa migrationreason_oppo migrationreason_inte migrationreason_earn migrationreason_dive migrationreason_stat migrationreason_know migrationreason_othe, after(migrationreason)


save"Last/NEEMSIS1-migrations", replace
****************************************
* END





