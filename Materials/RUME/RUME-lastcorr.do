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
destring creditpercentage, dpcomma replace
recode creditpercentage (88=.)
label values ownbusinessinvest yesno
drop kindsalariedjobcat


********** Migration
destring migrationdurationmonth, replace



********** Remittances
rename remsentname1 remsentrelation
rename individ remsentname1
/*
Add remsentrelation dans questionnaire papier
*/




********** Loans
/*
Create newvar dummyloans
*/
drop loanlendercat


ta lenderscaste if lenderscaste==11


/*
corriger loandate
*/




********** Main loans
gen dummymainloan=.
replace dummymainloan=0 if 
replace dummymainloan=1 if 

/*
corriger datecredittaken
*/

ta recommenddetailscaste if recommenddetailscaste==1


/*
corriger 
samepersonreco
samepersonguarantor
totalrepaidprincipal
repaydecision

*/


/*
Recoder tous les "0" en No response
*/

/*
Drop settleloanwhoworkmore1
*/

/*
cat "6" problemdelayrepayment
*/




********** Lending money
/*
Create dummylendingmoney
*/





********** Given recommendation
/*
Create dummyrecommendgiven
recommendgivenlendercaste "11"
*/



********** Recommendation received
recode reasonrefuserecommendcat (66=.)
recode repaycreditpersorecoamount (0=.)
recode repaycreditpersorecorelation // irrelevant to .
recode repaycreditpersorecocaste // irrelevant to .
recode repaycreditpersorecoborrower // irrelavant to .






********** Savings
/*
savingspurposeone pb du 6 savingspurposetwo
*/




********** Insurance
/*
create insuranceownerdummy
*/






********** Labourers
/*
Recoder productworkers productlabourwage productoriginlabourers productcastelabourers1 productcastelabourers2 productcastelabourers3 . if dummylabourers==No
*/




********** Equipment
/*
equipmentpay recoder le 9
*/






********** House
/*
rentalhouse recoder 0=.
otherhouserent 0 =. 66 = .
*/












