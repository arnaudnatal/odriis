*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 10, 2023
*-----
*RUME last clean
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
********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020
*-------------------------








****************************************
* NEEMSIS1-HH.dta
****************************************
use"NEEMSIS1-HH", clear


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
keep HHID2016 INDID2016 savingsaccounttype* savingsjointaccount* savingsaccountdate* banktype* savingsbankname* savingsbankplace* savingsamount* savingspurpose* dummydebitcard* dummycreditcard* datedebitcard* usedebitcard* reasonnotusedebitcard* demousedebitcard* demousecreditcard* datecreditcard* usecreditcard*
reshape long savingsaccounttype savingsjointaccount savingsaccountdate banktype savingsbankname savingsbankplace savingsamount savingspurpose dummydebitcard dummycreditcard datedebitcard usedebitcard reasonnotusedebitcard demousedebitcard demousecreditcard datecreditcard usecreditcard, i(HHID2016 INDID2016) j(n)
drop if savingsaccounttype==.


format savingsaccountdate %td
format datedebitcard %td
format datecreditcard %td


*** purpose
ta savingspurpose
split savingspurpose


*** usedebitcard
replace usedebitcard="" if usedebitcard=="."


*** reasonnotusedebitcard
replace reasonnotusedebitcard="" if reasonnotusedebitcard=="."


*** demousedebitcard
replace demousedebitcard="" if demousedebitcard=="."



*** demousecreditcard
replace demousecreditcard="" if demousecreditcard=="."



** label usecreditcard


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
forvalues i=1/7{
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





save"Last/NEEMSIS1-loans_mainloans", replace
****************************************
* END


