*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Assets construction
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox\RUME-NEEMSIS\Data\Construction"
cd"$directory"

********** Database names
global data = "RUME-HH"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020





****************************************
* Gold 2010
***************************************
use"$data", clear

keep HHID2010 goldquantity goldquantitypledge goldamountpledge
duplicates drop

***** Save
gen goldquantity2=goldquantity
gen goldquantitypledge2=goldquantitypledge
gen goldamountpledge2=goldamountpledge

***** Merge
preserve
use"outcomes/Goldpb_wide", clear
restore

merge 1:m HHID2010 using"outcomes/Goldpb_wide"
keep if _merge==3
drop _merge
drop HHID2016 HHID2020

gen corr=0

***** Realistic quantity? Excel file with Antony
compress 
order HHID2010 goldquantity2 goldquantitypledge2 goldamountpledge2 pbdalits_HH2010 pbnondalits_HH2010 corr goldquantity2016 goldquantitypledge2016 goldamountpledge2016 goldquantity2020 goldquantitypledge2020 goldamountpledge2020
sort HHID2010



********** High amount to clean
order HHID2010 goldquantity2 goldquantitypledge2 goldamountpledge2 pbdalits_HH2010 pbnondalits_HH2010 corr goldquantity2016 goldquantitypledge2016 goldamountpledge2016 goldquantity2020 goldquantitypledge2020 goldamountpledge2020
sort goldquantity2 HHID2010

replace goldquantity2=24 if HHID2010=="ANTSEM98"
replace goldquantitypledge2=12 if HHID2010=="ANTSEM98"
replace goldamountpledge2=15000 if HHID2010=="ANTSEM98"
replace corr=1 if HHID2010=="ANTSEM98"

replace goldquantity2=76 if HHID2010=="VENMPO35"
replace goldquantitypledge2=60 if HHID2010=="VENMPO35"
replace corr=1 if HHID2010=="VENMPO35"

replace goldquantity2=85 if HHID2010=="SIKARU255"
replace goldquantitypledge2=60 if HHID2010=="SIKARU255"
replace corr=1 if HHID2010=="SIKARU255"




********** Pledge vs Owned quantity
gen test=goldquantity2-goldquantitypledge2
/*
Neg means that pledge>total, suppose they reversed, so need to recoded:
*/
order HHID2010 goldquantity2 goldquantitypledge2 goldamountpledge2 pbdalits_HH2010 pbnondalits_HH2010 corr test goldquantity2016 goldquantitypledge2016 goldamountpledge2016 goldquantity2020 goldquantitypledge2020 goldamountpledge2020
sort test HHID2010

replace goldquantitypledge2=9 if HHID2010=="PSEP79"
replace goldamountpledge2=10000 if HHID2010=="PSEP79"
replace corr=1 if HHID2010=="PSEP79"

replace goldquantity2=92 if HHID2010=="ANTMP37"
replace goldquantitypledge2=36 if HHID2010=="ANTMP37"
replace corr=1 if HHID2010=="ANTMP37"

replace goldquantity2=60 if HHID2010=="ANTNAT359"
replace goldquantitypledge2=50 if HHID2010=="ANTNAT359"
replace goldamountpledge2=50000 if HHID2010=="ANTNAT359"
replace corr=1 if HHID2010=="ANTNAT359"

replace goldquantity2=50 if HHID2010=="VENKU125"
replace goldquantitypledge2=48 if HHID2010=="VENKU125"
replace corr=1 if HHID2010=="VENKU125"

replace goldquantity2=36 if HHID2010=="ANTSEM99"
replace goldquantitypledge2=31 if HHID2010=="ANTSEM99"
replace corr=1 if HHID2010=="ANTSEM99"

replace goldquantity2=40 if HHID2010=="ANTNAT362"
replace goldquantitypledge2=26 if HHID2010=="ANTNAT362"
replace corr=1 if HHID2010=="ANTNAT362"

replace goldquantity2=32 if HHID2010=="ANTSEM100"
replace goldquantitypledge2=22 if HHID2010=="ANTSEM100"
replace corr=1 if HHID2010=="ANTSEM100"

replace goldquantity2=32 if HHID2010=="ANTNAT358"
replace goldquantitypledge2=20 if HHID2010=="ANTNAT358"
replace corr=1 if HHID2010=="ANTNAT358"

replace goldquantity2=80 if HHID2010=="PSSEM90"
replace goldquantitypledge2=60 if HHID2010=="PSSEM90"
replace corr=1 if HHID2010=="PSSEM90"

replace goldquantity2=26 if HHID2010=="PSKU127"
replace corr=1 if HHID2010=="PSKU127"

replace goldquantity2=16 if HHID2010=="PSKU130"
replace goldquantitypledge2=12 if HHID2010=="PSKU130"
replace corr=1 if HHID2010=="PSKU130"

replace goldquantity2=32 if HHID2010=="PSSEM93"
replace goldquantitypledge2=20 if HHID2010=="PSSEM93"
replace corr=1 if HHID2010=="PSSEM93"

replace goldquantitypledge2=2 if HHID2010=="ANDOR406"
replace corr=1 if HHID2010=="ANDOR406"

replace goldquantity2=20 if HHID2010=="PSKU128"
replace goldquantitypledge2=12 if HHID2010=="PSKU128"
replace corr=1 if HHID2010=="PSKU128"

replace goldquantity2=24 if HHID2010=="PSSEM95"
replace goldquantitypledge2=16 if HHID2010=="PSSEM95"
replace corr=1 if HHID2010=="PSSEM95"

replace goldquantitypledge2=8 if HHID2010=="ADKOR233"
replace corr=1 if HHID2010=="ADKOR233"

replace goldquantity2=25 if HHID2010=="ANTNAT357"
replace goldquantitypledge2=20 if HHID2010=="ANTNAT357"
replace corr=1 if HHID2010=="ANTNAT357"

replace goldquantity2=15 if HHID2010=="ANTNAT361"
replace goldquantitypledge2=10 if HHID2010=="ANTNAT361"
replace corr=1 if HHID2010=="ANTNAT361"

replace goldquantity2=20 if HHID2010=="PSKU133"
replace goldquantitypledge2=16 if HHID2010=="PSKU133"
replace corr=1 if HHID2010=="PSKU133"

replace goldquantity2=24 if HHID2010=="PSKU135"
replace goldquantitypledge2=20 if HHID2010=="PSKU135"
replace corr=1 if HHID2010=="PSKU135"

replace goldquantity2=15 if HHID2010=="ANTNAT363"
replace goldquantitypledge2=13 if HHID2010=="ANTNAT363"
replace goldamountpledge2=30000 if HHID2010=="ANTNAT363"
replace corr=1 if HHID2010=="ANTNAT363"

drop test




********** Quantity and amount pledge
gen test=goldamountpledge2/goldquantitypledge2
/*
Higher than 2000 strange as 2000 is the gold price
So, need to check the quantity and the price to observe outliers
Below 400 too
*/
order HHID2010 goldquantity2 goldquantitypledge2 goldamountpledge2 pbdalits_HH2010 pbnondalits_HH2010 corr test goldquantity2016 goldquantitypledge2016 goldamountpledge2016 goldquantity2020 goldquantitypledge2020 goldamountpledge2020
sort test HHID2010


replace goldquantitypledge2=20 if HHID2010=="VENGP180"
replace corr=1 if HHID2010=="VENGP180"

replace goldquantitypledge2=36 if HHID2010=="ANTGP163"
replace corr=1 if HHID2010=="ANTGP163"

replace goldquantitypledge2=5 if HHID2010=="RAGP174"
replace corr=1 if HHID2010=="RAGP174"

replace goldquantitypledge2=32 if HHID2010=="SIOR375"
replace corr=1 if HHID2010=="SIOR375"

replace goldamountpledge2=35000 if HHID2010=="RAMPO22"
replace corr=1 if HHID2010=="RAMPO22"

replace goldamountpledge2=30000 if HHID2010=="RAEP70"
replace corr=1 if HHID2010=="SISEM101"

replace goldamountpledge2=17000 if HHID2010=="ADEP43"
replace corr=1 if HHID2010=="ADEP43"

replace goldamountpledge2=15000 if HHID2010=="RAMTP301"
replace corr=1 if HHID2010=="RAMTP301"

replace goldamountpledge2=15000 if HHID2010=="VENMPO32"
replace corr=1 if HHID2010=="VENMPO32"

replace goldamountpledge2=8000 if HHID2010=="ANTMTP317"
replace corr=1 if HHID2010=="ANTMTP317"

replace goldamountpledge2=8000 if HHID2010=="PSKARU265"
replace corr=1 if HHID2010=="PSKARU265"

replace goldamountpledge2=8000 if HHID2010=="PSMTP312"
replace corr=1 if HHID2010=="PSMTP312"

replace goldamountpledge2=8000 if HHID2010=="PSOR390"
replace corr=1 if HHID2010=="PSOR390"

replace goldamountpledge2=8000 if HHID2010=="SISEM101"
replace corr=1 if HHID2010=="SISEM101"

replace goldamountpledge2=20000 if HHID2010=="PSKOR205"
replace corr=1 if HHID2010=="PSKOR205"

drop test


********** Clean
drop goldquantity2016 goldquantitypledge2016 goldamountpledge2016 pbdalits_HH2016 pbnondalits_HH2016 goldquantity22016 goldquantitypledge22016 goldamountpledge22016
drop goldquantity2020 goldquantitypledge2020 goldamountpledge2020 pbdalits_HH2020 pbnondalits_HH2020 goldquantity22020 goldquantitypledge22020 goldamountpledge22020
drop pbdalits_HH2010 pbnondalits_HH2010 goldquantity2010 goldquantitypledge2010 goldamountpledge2010 goldquantity22010 goldquantitypledge22010 goldamountpledge22010

ta corr
* 38 HH corr

tabstat goldquantity goldquantity2 goldquantitypledge goldquantitypledge2 goldamountpledge goldamountpledge2, stat(n mean q)


save"outcomes\RUME-gold", replace


gen goldamount_HH=goldquantity2*2000
rename goldquantity2 goldquantity_HH
rename goldquantitypledge2 goldquantitypledge_HH
rename goldamountpledge2 goldamountpledge_HH

keep HHID2010 goldquantity_HH goldquantitypledge_HH goldamountpledge_HH goldamount_HH

save"outcomes\RUME-gold_HH", replace
****************************************
* END
