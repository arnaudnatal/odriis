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
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\Materials\RUME"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\2010-RUME\Data\4team"
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
* RUME-HH.dta
****************************************
use"RUME-HH", clear


********** Intro
rename village villagename


********** Employment
destring creditpercentage*, dpcomma replace

recode creditpercentage* (88=.)

label values ownbusinessinvest yesno

drop kindsalariedjobcat1 kindsalariedjobcat2 kindsalariedjobcat3 kindsalariedjobcat4


********** Migration
destring migrationdurationmonth*, replace



********** Remittances
rename remsentname11 remsentrelation1
rename remsentname12 remsentrelation2
rename remsentname13 remsentrelation3

rename individ1 remsentname1
rename individ2 remsentname2
rename individ3 remsentname3

/*
Add remsentrelation dans questionnaire papier
*/



********** Lending money
gen dummylendingmoney=.
replace dummylendingmoney=1 if amountlent1!=.
replace dummylendingmoney=0 if amountlent1==.
bysort HHID2010: egen max_dummylendingmoney=max(dummylendingmoney)
drop dummylendingmoney
rename max_dummylendingmoney dummylendingmoney
label values dummylendingmoney yesno
order dummylendingmoney, before(borrowerscaste1)






********** Given recommendation
gen dummyrecommendgiven=.
replace dummyrecommendgiven=1 if recommendgivenlist1!=.
replace dummyrecommendgiven=0 if recommendgivenlist1==.
bysort HHID2010: egen max_dummyrecommendgiven=max(dummyrecommendgiven)
drop dummyrecommendgiven
rename max_dummyrecommendgiven dummyrecommendgiven
label values dummyrecommendgiven yesno
order dummyrecommendgiven, before(recommendgivenlist1)

recode recommendgivenlendercaste1 recommendgivenlendercaste2 (11=77)




********** Recommendation received
replace reasonrefuserecommendcat="" if reasonrefuserecommendcat=="66"
recode repaycreditpersorecoamount (0=.)
recode repaycreditpersorecorelation (66=.) // irrelevant to .
recode repaycreditpersorecocaste (66=.) // irrelevant to .
recode repaycreditpersorecoborrower (66=.) // irrelavant to .




********** Savings
recode savingspurposeone* (6=99)




********** Insurance
rename dummyinsurance insuranceownerdummy
bysort HHID2010: egen dummyinsurance=max(insuranceownerdummy)
label values dummyinsurance yesno
order dummyinsurance, before(insuranceownerdummy)







********** Labourers
fre dummylabourers
replace productworkers=. if dummylabourers==0
replace productlabourwage=. if dummylabourers==0
replace productoriginlabourers=. if dummylabourers==0
replace productcastelabourers1=. if dummylabourers==0
replace productcastelabourers2=. if dummylabourers==0
replace productcastelabourers3=. if dummylabourers==0





********** Equipment
recode equipmentpay* (9=99) 





********** House
fre rentalhouse
recode rentalhouse (0=99)
fre otherhouserent
replace otherhouserent="" if otherhouserent=="0"
replace otherhouserent="" if otherhouserent=="66"



********** Loans
gen dummyloans=1
label values dummyloans yesno




********** Caste
merge m:m HHID2010 using "C:\Users\Arnaud\Documents\Dropbox (Personal)\Construction\outcomes\Panel-Caste_HH", keepusing(jatis2010 jatiscorr2010 caste2010)
keep if _merge==3
drop _merge
drop jatis jatis2010 caste
rename jatiscorr2010 jatis
rename caste2010 caste
order jatis caste, after(religion)
label var jatis "Jatis"
label var caste "caste"
label define caste 1"Dalits" 2"Middle castes" 3"Upper castes", replace
label values caste caste


save"Last/RUME-HH", replace
****************************************
* END











****************************************
* RUME-loans_mainloans.dta
****************************************
use"RUME-loans_mainloans", clear



********** Loans
preserve
gen dummyloans=.
replace dummyloans=1 if loanamount!=.

bysort HHID2010: egen sum_dummyloans=sum(dummyloans)
keep HHID2010 sum_dummyloans
duplicates drop
rename sum_dummyloans dummyloans
replace dummyloans=1 if dummyloans>1
/*
405 HH, tout le monde
*/
restore

drop loanlendercat

recode lenderscaste (11=77)

* Loan date
gen loandateday=15
replace loandatemonth="1" if loandatemonth=="JAN"
replace loandatemonth="2" if loandatemonth=="FEB"
replace loandatemonth="3" if loandatemonth=="MAR"
replace loandatemonth="4" if loandatemonth=="APR"
replace loandatemonth="5" if loandatemonth=="MAY"
replace loandatemonth="6" if loandatemonth=="JUN"
replace loandatemonth="7" if loandatemonth=="JUL"
replace loandatemonth="8" if loandatemonth=="aug"
replace loandatemonth="8" if loandatemonth=="AUG"
replace loandatemonth="9" if loandatemonth=="SEP"
replace loandatemonth="10" if loandatemonth=="OCT"
replace loandatemonth="11" if loandatemonth=="NOV"
replace loandatemonth="12" if loandatemonth=="DEC"
destring loandatemonth, replace
recode loandatemonth (88=.) (99=.)
recode loandateyear (88=.) (99=.)
gen loandate2=mdy(loandatemonth, loandateday, loandateyear)
format %td loandate2
order loandate2, after(loandate)
drop loandate loandateday loandatemonth loandateyear
rename loandate2 loandate



********** Main loans
gen dummymainloan=.
replace dummymainloan=0 if borrowerservices==.
replace dummymainloan=1 if borrowerservices!=.
label values dummymainloan yesno
fre dummymainloan


* datecredittaken
gen datecredittakenday=15
replace datecredittakenmonth="1" if datecredittakenmonth=="JAN"
replace datecredittakenmonth="2" if datecredittakenmonth=="FEB"
replace datecredittakenmonth="3" if datecredittakenmonth=="MAR"
replace datecredittakenmonth="4" if datecredittakenmonth=="APR"
replace datecredittakenmonth="5" if datecredittakenmonth=="MAY"
replace datecredittakenmonth="6" if datecredittakenmonth=="JUN"
replace datecredittakenmonth="7" if datecredittakenmonth=="JUL"
replace datecredittakenmonth="8" if datecredittakenmonth=="aug"
replace datecredittakenmonth="8" if datecredittakenmonth=="AUG"
replace datecredittakenmonth="9" if datecredittakenmonth=="SEP"
replace datecredittakenmonth="10" if datecredittakenmonth=="OCT"
replace datecredittakenmonth="11" if datecredittakenmonth=="NOV"
replace datecredittakenmonth="12" if datecredittakenmonth=="DEC"
destring datecredittakenmonth, replace
gen datecredittaken2=mdy(datecredittakenmonth, datecredittakenday, datecredittakenyear)
format %td datecredittaken2
order datecredittaken2, after(datecredittaken)
drop datecredittaken datecredittakenday datecredittakenmonth datecredittakenyear
rename datecredittaken2 datecredittaken

recode recommenddetailscaste (11=77)

gen dummysamepersonreco=.
replace dummysamepersonreco=0 if samepersonreco!=""
replace dummysamepersonreco=0 if samepersonreco=="0"
replace dummysamepersonreco=0 if samepersonreco=="NO"
replace dummysamepersonreco=1 if samepersonreco=="YES"
replace dummysamepersonreco=1 if samepersonreco=="1"
replace dummysamepersonreco=1 if samepersonreco=="2"
replace dummysamepersonreco=1 if samepersonreco=="3"
replace dummysamepersonreco=1 if samepersonreco=="4"
replace dummysamepersonreco=1 if samepersonreco=="5"
replace dummysamepersonreco=1 if samepersonreco=="6"
replace dummysamepersonreco=1 if samepersonreco=="66"
replace samepersonreco="" if samepersonreco=="NO"
replace samepersonreco="66" if samepersonreco=="YES"
replace samepersonreco="" if samepersonreco=="0"
destring samepersonreco, replace
order dummysamepersonreco, before(samepersonreco)

gen dummysamepersonguarantor=.
replace dummysamepersonguarantor=0 if samepersonguarantor!=""
replace dummysamepersonguarantor=0 if samepersonguarantor=="0"
replace dummysamepersonguarantor=0 if samepersonguarantor=="NO"
replace dummysamepersonguarantor=1 if samepersonguarantor=="YES"
replace dummysamepersonguarantor=1 if samepersonguarantor=="1"
replace dummysamepersonguarantor=1 if samepersonguarantor=="2"
replace dummysamepersonguarantor=1 if samepersonguarantor=="3"
replace dummysamepersonguarantor=1 if samepersonguarantor=="4"
replace dummysamepersonguarantor=1 if samepersonguarantor=="5"
replace dummysamepersonguarantor=1 if samepersonguarantor=="6"
replace dummysamepersonguarantor=1 if samepersonguarantor=="66"
replace samepersonguarantor="" if samepersonguarantor=="NO"
replace samepersonguarantor="66" if samepersonguarantor=="YES"
replace samepersonguarantor="" if samepersonguarantor=="0"
destring samepersonguarantor, replace
order dummysamepersonguarantor, before(samepersonguarantor)

ta totalrepaidprincipal
replace totalrepaidprincipal="-99" if totalrepaidprincipal=="SETTLED"
destring totalrepaidprincipal, replace
replace totalrepaidprincipal=loanamount if totalrepaidprincipal==-99

ta repaydecision
recode repaydecision (0=99)

drop settleloanwhoworkmore1

ta problemdelayrepayment
recode problemdelayrepayment (6=99)

save"Last/RUME-loans_mainloans", replace
****************************************
* END


