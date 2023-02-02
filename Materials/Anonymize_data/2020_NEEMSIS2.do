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
merge m:1 HHID2020 using "outcomes/NEEMSIS2-gold_HH", keepusing(goldamount_HH)
drop _merge






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



save"_temp\NEEMSIS2-ass1", replace
****************************************
* END











****************************************
* Expenses 2020
***************************************
use"$data", clear

keep HHID2020 INDID2020 educationexpenses productexpenses_paddy productexpenses_cotton productexpenses_sugarcane productexpenses_savukku productexpenses_guava productexpenses_groundnut productexpenses_millets productexpenses_cashew productexpenses_other foodexpenses healthexpenses ceremoniesexpenses ceremoniesrelativesexpenses deathexpenses marriageexpenses


* Annual expenses
foreach x in educationexpenses productexpenses_paddy productexpenses_cotton productexpenses_sugarcane productexpenses_savukku productexpenses_guava productexpenses_groundnut productexpenses_millets productexpenses_cashew productexpenses_other foodexpenses healthexpenses ceremoniesexpenses ceremoniesrelativesexpenses deathexpenses marriageexpenses {
replace `x'=0 if `x'==.
}


* HH level for educ and marriage
sort HHID2020 INDID2020

bysort HHID2020: egen expenses_educ=sum(educationexpenses)
bysort HHID2020: egen expenses_marr=sum(marriageexpenses)


gen expenses_total=52*foodexpenses+expenses_educ+healthexpenses+ceremoniesexpenses+deathexpenses+ceremoniesrelativesexpenses

gen expenses_food=52*foodexpenses
gen expenses_heal=healthexpenses
gen expenses_cere=ceremoniesexpenses+deathexpenses+ceremoniesrelativesexpenses

* Agri
egen expenses_agri=rowtotal(productexpenses_paddy productexpenses_cotton productexpenses_sugarcane productexpenses_savukku productexpenses_guava productexpenses_groundnut productexpenses_millets productexpenses_cashew productexpenses_other)


drop productexpenses_paddy productexpenses_cotton productexpenses_sugarcane productexpenses_savukku productexpenses_guava productexpenses_groundnut productexpenses_millets productexpenses_cashew productexpenses_other educationexpenses foodexpenses healthexpenses ceremoniesexpenses deathexpenses marriageexpenses ceremoniesrelativesexpenses


foreach x in expenses_total expenses_food expenses_educ expenses_heal expenses_cere {
label var `x' "Annual expenses"
}


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

* Drop
drop INDID2020
duplicates drop

merge 1:1 HHID2020 using "_temp\NEEMSIS2-ass1"
drop _merge

save"outcomes\NEEMSIS2-assets", replace
****************************************
* END
