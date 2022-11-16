*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Transferts construction
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox\RUME-NEEMSIS\Data\Construction"
cd"$directory"

********** Database names
global data = "NEEMSIS1-HH"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020



****************************************
* Remittances net
***************************************
use"$data", clear


sort HHID2016 INDID2016
egen remreceived_indiv=rowtotal(remreceivedtotamount1 remreceivedtotamount2)
bysort HHID2016: egen remreceived_HH=sum(remreceived_indiv)

egen remsent_indiv=rowtotal(remsenttotalamount1 remsenttotalamount2)
bysort HHID2016: egen remsent_HH=sum(remsent_indiv)


gen remittnet_indiv=remreceived_indiv-remsent_indiv
gen remittnet_HH=remreceived_HH-remsent_HH

save"_temp\NEEMSIS1-remit", replace
****************************************
* END






****************************************
* Schemes
***************************************
use"_temp\NEEMSIS1-remit", clear


* Old age pension
* Widow pension
* National maternity
* Disability pension
* Retirement pension

*** Indiv
egen pension_indiv=rowtotal(pensionamount_oldage pensionamount_widows pensionamount_maternity pensionamount_disability pensionamount_retirement)

*** HH
bysort HHID2016: egen pension_HH=sum(pension_indiv)



***** Total
egen transferts_indiv=rowtotal(remittnet_indiv pension_indiv)
egen transferts_HH=rowtotal(remittnet_HH pension_HH)
sort HHID2016 INDID2016


*** Indiv level
preserve
keep HHID2016 INDID2016 remreceived_indiv remsent_indiv remittnet_indiv pension_indiv transferts_indiv
duplicates drop
save"outcomes\NEEMSIS1-transferts_indiv", replace
restore


*** HH
preserve
keep HHID2016 remreceived_HH remsent_HH remittnet_HH pension_HH transferts_HH
duplicates drop
save"outcomes\NEEMSIS1-transferts_HH", replace
restore


****************************************
* END
