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
* ASSETS 2010
***************************************
use"$data", clear

/*
Assets = 
+ house value
+ livestock
+ goods
+ gold
+ land
*/

*** Livestock
gen livestockamount_cow=8000*livestocknb_cow
gen livestockamount_goat=1000*livestocknb_goat
egen livestockamount=rowtotal(livestockamount_cow livestockamount_goat)

*** Goods
forvalues i=1/10 {
gen goodsvalue`i'=.
replace goodsvalue`i'=100000*numbergoods`i' if listgoods`i'==1
replace goodsvalue`i'=1000*numbergoods`i' if listgoods`i'==2
replace goodsvalue`i'=5000*numbergoods`i' if listgoods`i'==3
replace goodsvalue`i'=5000*numbergoods`i' if listgoods`i'==4
replace goodsvalue`i'=1000*numbergoods`i' if listgoods`i'==5
replace goodsvalue`i'=1000*numbergoods`i' if listgoods`i'==6
replace goodsvalue`i'=1000*numbergoods`i' if listgoods`i'==7
replace goodsvalue`i'=1000*numbergoods`i' if listgoods`i'==8
replace goodsvalue`i'=5000*numbergoods`i' if listgoods`i'==9
replace goodsvalue`i'=500*numbergoods`i' if listgoods`i'==10
replace goodsvalue`i'=10000*numbergoods`i' if listgoods`i'==11
replace goodsvalue`i'=1000*numbergoods`i' if listgoods`i'==12
replace goodsvalue`i'=3000*numbergoods`i' if listgoods`i'==13
}
egen goodstotalamount=rowtotal(goodsvalue1 goodsvalue2 goodsvalue3 goodsvalue4 goodsvalue5 goodsvalue6 goodsvalue7 goodsvalue8 goodsvalue9 goodsvalue10)

*** Land
fre sizeownland drywetownland
gen amountownland=.
replace amountownland=600000*sizeownland if drywetownland==1
replace amountownland=1100000*sizeownland if drywetownland==2

***Gold
*Pledge vs Real
ta goldquantity
ta goldquantitypledge 
gen test=goldquantity-goldquantitypledge
ta test
*Neg means that pledge>total, suppose they reversed
replace goldquantity=goldquantitypledge if test<0
drop test
gen test=goldquantitypledge/goldquantity
ta test if goldquantity>200
drop test
*Amount pledge
gen test=goldamountpledge/goldquantitypledge
ta test
*Higher than 2000 strange as 2000 is the gold price
ta goldquantitypledge if test>2000
ta goldamountpledge if test>2000
*Replace with 2000*quantity
replace goldamountpledge=goldquantitypledge*2000 if test>2000

*Amount
gen goldamount=goldquantity*2000


****Total
egen assets=rowtotal(livestockamount goodstotalamount amountownland goldamount housevalue)
egen assets_noland=rowtotal(livestockamount goodstotalamount goldamount housevalue)
egen assets_noprop=rowtotal(livestockamount goodstotalamount goldamount)

gen assets1000=assets/1000
gen assets1000_noland=assets_noland/1000
gen assets1000_noprop=assets_noprop/1000

***Clean
drop livestockamount_cow livestockamount_goat livestockamount goodsvalue1 goodsvalue2 goodsvalue3 goodsvalue4 goodsvalue5 goodsvalue6 goodsvalue7 goodsvalue8 goodsvalue9 goodsvalue10 goodstotalamount amountownland goldamount


********** Variables
preserve
keep assets* HHID2010
duplicates drop
tabstat assets assets_noland assets_noprop, stat(n mean sd q min max)
tabstat assets1000 assets1000_noland assets1000_noprop, stat(n mean sd q min max)
restore
/*
   stats |  ass~1000  assets..  assets..
---------+------------------------------
       N |       405       405       405
    mean |  1272.978  239.8963  97.21728
      sd |  1581.578  140.8426  54.90822
     p25 |     190.5       149      60.5
     p50 |       701       196        85
     p75 |      1823     296.5     118.5
     min |      47.5      47.5        17
     max |   11761.5      1051       451
----------------------------------------
*/


keep assets* HHID2010
duplicates drop
save"outcomes\RUME-assets", replace
****************************************
* END
