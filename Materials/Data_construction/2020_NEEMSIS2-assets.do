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
global data = "NEEMSIS2-HH"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020



****************************************
* ASSETS 2020-21
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
egen livestockamount=rowtotal(livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock livestockamount_bullforploughing)

*** Goods
egen goodstotalamount=rowtotal(goodtotalamount_car goodtotalamount_bike goodtotalamount_fridge goodtotalamount_furniture goodtotalamount_tailormach goodtotalamount_phone goodtotalamount_landline goodtotalamount_camera goodtotalamount_cookgas goodtotalamount_computer goodtotalamount_antenna)


*** Land
tab drywetownland

replace sizedryownland=sizeownland if drywetownland=="1" & sizedryownland==. & sizeownland!=.
replace sizewetownland=sizeownland if drywetownland=="2" & sizewetownland==. & sizeownland!=.

egen sizeownland_temp=rowtotal(sizedryownland sizewetownland)
replace sizeownland=sizeownland_temp if sizeownland==. & sizeownland_temp!=0
drop sizeownland_temp

gen amountownlanddry=.
replace amountownlanddry=sizedryownland*900000 if villageid==3 | villageid==9 | villageid==6
replace amountownlanddry=sizedryownland*1000000 if villageid==10 | villageid==7 | villageid==1 | villageid==8
replace amountownlanddry=sizedryownland*800000 if villageid==4 | villageid==5 | villageid==2

gen amountownlandwet=.
replace amountownlandwet=sizewetownland*1600000 if villageid==3 | villageid==9 | villageid==6
replace amountownlandwet=sizewetownland*1500000 if villageid==10 | villageid==7 | villageid==1 | villageid==8
replace amountownlandwet=sizewetownland*1200000 if villageid==4 | villageid==5 | villageid==2

egen amountownland=rowtotal(amountownlanddry amountownlandwet)
*if both half
replace amountownland=sizeownland*1250000 if drywetownland=="1 2" & sizedryownland==. & sizewetownland==. & (villageid==3 | villageid==9 | villageid==6)
replace amountownland=sizeownland*1250000 if drywetownland=="1 2" & sizedryownland==. & sizewetownland==. & (villageid==10 | villageid==7 | villageid==1 | villageid==8)
replace amountownland=sizeownland*1000000 if drywetownland=="1 2" & sizedryownland==. & sizewetownland==. & (villageid==4 | villageid==5 | villageid==2)

fre ownland
desc sizeownland amountownlanddry amountownlandwet amountownland ownland
foreach x in sizeownland amountownlanddry amountownlandwet amountownland {
replace `x'=. if `x'==0 & ownland=="0"
}



***Gold
*merge m:1 HHID2020 using "outcomes/NEEMSIS2-gold_HH", keepusing(goldamount_HH)
*drop _merge

bysort HHID2020: egen goldquantity_HH=sum(goldquantity)
gen goldamount_HH=goldquantity_HH*2700





****Total
egen assets=rowtotal(livestockamount goodstotalamount amountownland goldamount_HH housevalue)
egen assets_noland=rowtotal(livestockamount goodstotalamount goldamount_HH housevalue)
egen assets_noprop=rowtotal(livestockamount goodstotalamount goldamount_HH)

gen assets1000=assets/1000
gen assets1000_noland=assets_noland/1000
gen assets1000_noprop=assets_noprop/1000

***Clean
drop amountownlanddry amountownlandwet


********** Variables
preserve
keep assets* HHID2020
duplicates drop
tabstat assets assets_noland assets_noprop, stat(n mean sd q min max)
tabstat assets1000 assets1000_noland assets1000_noprop, stat(n mean sd q min max)
restore
/*
   stats |  ass~1000  assets..  assets..
---------+------------------------------
       N |       632       632       632
    mean |  1361.496  571.0121  271.3237
      sd |  2106.882  480.4355   284.931
     p25 |    332.55     295.1     137.8
     p50 |     592.6     450.9    211.25
     p75 |    1515.3    701.85     331.7
     min |         0         0         0
     max |   18059.4    5773.3    4173.3
----------------------------------------
*/

keep HHID2020 assets* livestockamount goodstotalamount amountownland goldamount_HH housevalue sizeownland
rename goldamount_HH goldamount
duplicates drop
save"outcomes\NEEMSIS2-assets", replace

****************************************
* END
