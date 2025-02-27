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
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\NEEMSIS-Construction"
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


fre listgoods1

*** Goods
forvalues i=1/10 {
gen goodsvalue`i'=.
replace goodsvalue`i'=100000*numbergoods`i' if listgoods`i'==1
replace goodsvalue`i'=1000*numbergoods`i' if listgoods`i'==2
replace goodsvalue`i'=5000*numbergoods`i' if listgoods`i'==3
replace goodsvalue`i'=5000*numbergoods`i' if listgoods`i'==4
replace goodsvalue`i'=4000*numbergoods`i' if listgoods`i'==5
replace goodsvalue`i'=3500*numbergoods`i' if listgoods`i'==6
replace goodsvalue`i'=1000*numbergoods`i' if listgoods`i'==7
replace goodsvalue`i'=1000*numbergoods`i' if listgoods`i'==8
replace goodsvalue`i'=5000*numbergoods`i' if listgoods`i'==9
replace goodsvalue`i'=3000*numbergoods`i' if listgoods`i'==10
replace goodsvalue`i'=14000*numbergoods`i' if listgoods`i'==11
replace goodsvalue`i'=1000*numbergoods`i' if listgoods`i'==12
replace goodsvalue`i'=5000*numbergoods`i' if listgoods`i'==13

* gen goodsvaluebis`i'=.
* replace goodsvaluebis`i'=150000*numbergoods`i' if listgoods`i'==1
* replace goodsvaluebis`i'=30000*numbergoods`i' if listgoods`i'==2
* replace goodsvaluebis`i'=5000*numbergoods`i' if listgoods`i'==3
* replace goodsvaluebis`i'=5000*numbergoods`i' if listgoods`i'==4
* replace goodsvaluebis`i'=3000*numbergoods`i' if listgoods`i'==5
* replace goodsvaluebis`i'=2000*numbergoods`i' if listgoods`i'==6
* replace goodsvaluebis`i'=1000*numbergoods`i' if listgoods`i'==7
* replace goodsvaluebis`i'=1000*numbergoods`i' if listgoods`i'==8
* replace goodsvaluebis`i'=5000*numbergoods`i' if listgoods`i'==9
* replace goodsvaluebis`i'=2000*numbergoods`i' if listgoods`i'==10
* replace goodsvaluebis`i'=15000*numbergoods`i' if listgoods`i'==11
* replace goodsvaluebis`i'=1000*numbergoods`i' if listgoods`i'==12
* replace goodsvaluebis`i'=3000*numbergoods`i' if listgoods`i'==13
}

egen goodstotalamount=rowtotal(goodsvalue1 goodsvalue2 goodsvalue3 goodsvalue4 goodsvalue5 goodsvalue6 goodsvalue7 goodsvalue8 goodsvalue9 goodsvalue10)

* egen goodsbistotalamount=rowtotal(goodsvaluebis1 goodsvaluebis2 goodsvaluebis3 goodsvaluebis4 goodsvaluebis5 goodsvaluebis6 goodsvaluebis7 goodsvaluebis8 goodsvalue9 goodsvaluebis10)

* preserve
* keep HHID2010 goodstotalamount goodsbistotalamount
* duplicates drop
* tabstat goodstotalamount goodsbistotalamount, stat(n mean q)
* restore


*** Land
fre sizeownland drywetownland
gen amountownland=.
replace amountownland=600000*sizeownland if drywetownland==1
replace amountownland=1100000*sizeownland if drywetownland==2

gen sizedryownland=sizeownland if drywetownland==1
gen sizewetownland=sizeownland if drywetownland==2

***Gold
merge m:1 HHID2010 using "outcomes/RUME-gold_HH", keepusing(goldamount_HH)
drop _merge


****Total
egen assets=rowtotal(livestockamount goodstotalamount amountownland goldamount_HH housevalue)
egen assets_noland=rowtotal(livestockamount goodstotalamount goldamount_HH housevalue)
egen assets_noprop=rowtotal(livestockamount goodstotalamount goldamount_HH)


* egen assetsbis=rowtotal(livestockamount goodsbistotalamount amountownland goldamount_HH housevalue)
* egen assetsbis_noland=rowtotal(livestockamount goodsbistotalamount goldamount_HH housevalue)
* egen assetsbis_noprop=rowtotal(livestockamount goodsbistotalamount goldamount_HH)

gen assets1000=assets/1000
gen assets1000_noland=assets_noland/1000
gen assets1000_noprop=assets_noprop/1000

* gen assetsbis1000=assetsbis/1000
* gen assetsbis1000_noland=assetsbis_noland/1000
* gen assetsbis1000_noprop=assetsbis_noprop/1000

***Clean
drop livestockamount_cow livestockamount_goat goodsvalue1 goodsvalue2 goodsvalue3 goodsvalue4 goodsvalue5 goodsvalue6 goodsvalue7 goodsvalue8 goodsvalue9 goodsvalue10

* drop goodsvaluebis1 goodsvaluebis2 goodsvaluebis3 goodsvaluebis4 goodsvaluebis5 goodsvaluebis6 goodsvaluebis7 goodsvaluebis8 goodsvaluebis9 goodsvaluebis10


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


keep HHID2010 assets* livestockamount goodstotalamount amountownland goldamount_HH housevalue sizeownland
* goodsbistotalamount
rename goldamount_HH goldamount
duplicates drop

* Rename
rename sizeownland assets_sizeownland
rename housevalue assets_housevalue
rename livestockamount assets_livestock
rename goodstotalamount assets_goods
rename amountownland assets_ownland
rename goldamount assets_gold
rename assets_noland assets_totalnoland
rename assets_noprop assets_totalnoprop
rename assets assets_total
rename assets1000 assets_total1000
rename assets1000_noland assets_totalnoland1000
rename assets1000_noprop assets_totalnoprop1000

* rename goodsbistotalamount assets_goodsbis
* rename assetsbis_noland assets_totalnolandbis
* rename assetsbis_noprop assets_totalnopropbis
* rename assetsbis assets_totalbis
* rename assetsbis1000 assets_totalbis1000
* rename assetsbis1000_noland assets_totalnolandbis1000
* rename assetsbis1000_noprop assets_totalnopropbis1000



* Share
foreach x in housevalue livestock goods ownland gold {
gen shareassets_`x'=assets_`x'*100/assets_total
replace shareassets_`x'=round(shareassets_`x',0.01)
}

gen test=100-shareassets_housevalue-shareassets_livestock-shareassets_goods-shareassets_ownland-shareassets_gold
ta test
drop test

recode shareassets_housevalue shareassets_livestock shareassets_goods shareassets_ownland shareassets_gold (.=0)

tabstat shareassets_housevalue shareassets_livestock shareassets_goods shareassets_ownland shareassets_gold, stat(n mean cv p50)

save"_temp\RUME-ass1", replace
****************************************
* END









****************************************
* Expenses 2010
***************************************
use"$data", clear

keep HHID2010 foodexpenses educationexpenses healthexpenses ceremoniesexpenses deathexpenses productexpenses1 productexpenses2 productexpenses3 productexpenses4 productexpenses5 

duplicates drop


* Annual expenses
foreach x in productexpenses1 productexpenses2 productexpenses3 productexpenses4 productexpenses5 foodexpenses educationexpenses healthexpenses ceremoniesexpenses deathexpenses {
replace `x'=0 if `x'==.
}

gen expenses_total=52*foodexpenses+educationexpenses+healthexpenses+ceremoniesexpenses+deathexpenses

gen expenses_food=52*foodexpenses
gen expenses_educ=educationexpenses
gen expenses_heal=healthexpenses
gen expenses_cere=ceremoniesexpenses+deathexpenses

* Agri
egen expenses_agri=rowtotal(productexpenses1 productexpenses2 productexpenses3 productexpenses4 productexpenses5)



drop productexpenses1 productexpenses2 productexpenses3 productexpenses4 productexpenses5 foodexpenses educationexpenses healthexpenses ceremoniesexpenses deathexpenses

foreach x in expenses_food expenses_educ expenses_heal expenses_cere {
label var `x' "Annual expenses"
}

label var expenses_total "food+educ+heal+cere+deat"


* Share
foreach x in food educ heal cere {
gen shareexpenses_`x'=expenses_`x'*100/expenses_total
}


* Test
gen test1=100-shareexpenses_food-shareexpenses_educ-shareexpenses_heal-shareexpenses_cere
ta test1
drop test1

* Reduce
foreach x in shareexpenses_food shareexpenses_educ shareexpenses_heal shareexpenses_cere {
replace `x'=round(`x',0.01)
}


merge 1:1 HHID2010 using "_temp\RUME-ass1"
drop _merge

save"outcomes\RUME-assets", replace
****************************************
* END
