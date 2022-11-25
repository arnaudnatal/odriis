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
merge 1:m HHID2010 using"outcomes/Goldpb_wide"
keep if _merge==3
drop _merge
drop HHID2016 HHID2020


***** Realistic quantity? Excel file with Antony
compress 
order HHID2010 goldquantity2 goldquantitypledge2 goldamountpledge2 pbdalits_HH2010 pbnondalits_HH2010 goldquantity2016 goldquantitypledge2016 goldamountpledge2016 goldquantity2020 goldquantitypledge2020 goldamountpledge2020
sort HHID2010







********** Corr
ta pb 
sort pb HHID2010
list HHID2010 goldquantity2 goldquantitypledge2 goldamountpledge2 pb if pb!=0, clean noobs







***** Pledge vs Owned quantity:
gen test=goldquantity-goldquantitypledge
ta test
/*
Neg means that pledge>total, suppose they reversed, so need to recoded:
*/
replace goldquantity2=goldquantitypledge if test<0
drop test


***** Quantity and amount pledge
gen test=goldamountpledge/goldquantitypledge
ta test
/*
Higher than 2000 strange as 2000 is the gold price
So, need to check the quantity and the price to observe outliers
*/
ta goldquantitypledge if test>2000
ta goldamountpledge if test>2000
/*
It seems that the quantity is good, so replace the price
*/
replace goldamountpledge2=goldquantitypledge*2000 if test>2000
drop test

gen goldamount=goldquantity*2000

tabstat goldquantity goldquantity2, stat(n mean cv q)

save"outcomes\RUME-gold", replace


gen goldamount_HH=goldquantity2*2000
rename goldquantity2 goldquantity_HH
rename goldquantitypledge2 goldquantitypledge_HH
rename goldamountpledge2 goldamountpledge_HH

keep HHID2010 goldquantity_HH goldquantitypledge_HH goldamountpledge_HH goldamount_HH

save"outcomes\RUME-gold_HH", replace
****************************************
* END
