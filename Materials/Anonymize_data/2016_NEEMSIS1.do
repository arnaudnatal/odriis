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
* ASSETS 2016-17
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
egen livestockamount=rowtotal(livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock)

*** Goods
egen goodstotalamount=rowtotal(goodtotalamount_car goodtotalamount_cookgas goodtotalamount_computer goodtotalamount_antenna goodtotalamount_bike goodtotalamount_fridge goodtotalamount_furniture goodtotalamount_tailormach goodtotalamount_phone goodtotalamount_landline goodtotalamount_DVD goodtotalamount_camera)


*** Land
fre sizeownland drywetownland
gen amountownland=.
*600 000 strange bc min 800 000 en 2020...

replace amountownland=600000*sizeownland if drywetownland==1
*In 2016-17, according to Venkat, wet at 800 000 per acre
* Strange une telle deval d'autant plus qu'en 2020 on monte à 1 500.
* Donc on prend la val de 2010 : 1 100
replace amountownland=1100000*sizeownland if drywetownland==2

*For those who have both type of land, I will use land owned in 2010 to try to deduce the share of dry/wet
*If it is new HH, half dry half wet assumption
*New HH
replace amountownland=700000*sizeownland if HHID2016=="uuid:fa73ad2c-c373-4292-96ad-4e4830209e5d"
replace amountownland=700000*sizeownland if HHID2016=="uuid:35591049-0c3e-4dac-836a-958f07745c35"
replace amountownland=700000*sizeownland if HHID2016=="uuid:3f9cffe9-c7a8-4057-afd6-b2e14e4a36b8"
replace amountownland=700000*sizeownland if HHID2016=="uuid:0542e203-ec33-4e6a-8b6a-17b574ce9bf8"
replace amountownland=700000*sizeownland if HHID2016=="uuid:5c1a711d-d214-4c67-94b7-2eb8ed6009cd"
replace amountownland=700000*sizeownland if HHID2016=="uuid:877d0560-5981-491b-b780-6585bf924814"
replace amountownland=700000*sizeownland if HHID2016=="uuid:8961de1a-1258-45d6-8a77-1b3800aa2f8e"
replace amountownland=700000*sizeownland if HHID2016=="uuid:9f14556f-8aa4-42d1-a8e8-d82f3d40e3d3"
replace amountownland=700000*sizeownland if HHID2016=="uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006"
*Former HH
replace amountownland=6*800000+3*600000 if HHID2016=="uuid:6b162917-4b4d-4787-a719-3fe27af6f755"
replace amountownland=5*800000+1*600000 if HHID2016=="uuid:a6097c43-dd3b-40d0-9d42-7350ecbd35ab"
replace amountownland=1*800000+2*600000 if HHID2016=="uuid:89f0734d-db4a-4660-8c9f-c54fcd6f8ddb"
replace amountownland=2.5*800000+2.5*600000 if HHID2016=="uuid:8ddf086d-0993-4ff7-813b-1f63dd46b1bf"
replace amountownland=6*800000+4*600000 if HHID2016=="uuid:31eb18f2-0c0f-40cc-92f8-40289ba87ddb"
replace amountownland=1.75*800000+1.75*600000 if HHID2016=="uuid:4127118b-59ff-4db1-a857-1641b70415c9"
replace amountownland=5*800000+1.5*600000 if HHID2016=="uuid:8aeef32f-8d22-481b-8e71-cbfe49fea98e"
replace amountownland=0.25*800000+0.75*600000 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919"
replace amountownland=6*600000 if HHID2016=="uuid:78817304-5ca2-42d3-9b67-843366b5afde"
replace amountownland=2*800000+2*600000 if HHID2016=="uuid:5ddaed64-11cb-4a8a-a146-951b9d041a2a"
replace amountownland=2*800000 if HHID2016=="uuid:e73b9bd7-f7f3-4ac0-b360-ffcd09758ff4"
replace amountownland=1*800000+0.5*600000 if HHID2016=="uuid:8380069d-0c7d-41f6-b487-dd4e66377170"
replace amountownland=2*800000 if HHID2016=="uuid:3ed13d21-3fbd-4a33-a557-48b68f5ed065"
replace amountownland=0.5*800000+0.5*600000 if HHID2016=="uuid:65046bab-4328-4b56-b76f-1e4144ee8dd0"
replace amountownland=1*600000 if HHID2016=="uuid:96b99b66-dee2-4a30-806e-fd734d974812"
replace amountownland=0.25*800000+1.75*600000 if HHID2016=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c"
replace amountownland=1*800000 if HHID2016=="uuid:e847a4d4-ea2a-4a01-95f2-25a37de516e9"
replace amountownland=2*800000+8*600000 if HHID2016=="uuid:bf24520a-2493-421c-8cdc-cfdea3c93699"



***Gold
merge m:1 HHID2016 using "outcomes/NEEMSIS1-gold_HH", keepusing(goldamount_HH)
drop _merge




****Total
egen assets=rowtotal(livestockamount goodstotalamount amountownland goldamount_HH housevalue)
egen assets_noland=rowtotal(livestockamount goodstotalamount goldamount_HH housevalue)
egen assets_noprop=rowtotal(livestockamount goodstotalamount goldamount_HH)

gen assets1000=assets/1000
gen assets1000_noland=assets_noland/1000
gen assets1000_noprop=assets_noprop/1000



********** Variables
preserve
keep assets* HHID2016
duplicates drop
tabstat assets assets_noland assets_noprop, stat(n mean sd q min max)
tabstat assets1000 assets1000_noland assets1000_noprop, stat(n mean sd q min max)
restore
/*
   stats |  ass~1000  assets..  assets..
---------+------------------------------
       N |       492       492       492
    mean |  1056.785  487.6341  221.0872
      sd |  1955.018  727.2433  405.4324
     p25 |     182.2    164.65     69.25
     p50 |   424.225    315.15     131.1
     p75 |    1094.9     607.6    246.05
     min |         0         0         0
     max |   21561.3    9561.3    7061.3
----------------------------------------
*/

keep HHID2016 assets* livestockamount goodstotalamount amountownland goldamount_HH housevalue sizeownland
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



save"_temp\NEEMSIS1-ass1", replace
****************************************
* END







****************************************
* Expenses 2016
***************************************
use"$data", clear

keep HHID2016 INDID2016 foodexpenses educationexpenses healthexpenses ceremoniesexpenses deathexpenses productexpenses_paddy productexpenses_ragi productexpenses_millets productexpenses_tapioca productexpenses_cotton productexpenses_sugarca productexpenses_savukku productexpenses_guava productexpenses_groundnut marriageexpenses ceremoniesrelativesexpenses


* Annual expenses
foreach x in educationexpenses productexpenses_paddy productexpenses_ragi productexpenses_millets productexpenses_tapioca productexpenses_cotton productexpenses_sugarca productexpenses_savukku productexpenses_guava productexpenses_groundnut foodexpenses healthexpenses ceremoniesexpenses deathexpenses marriageexpenses ceremoniesrelativesexpenses {
replace `x'=0 if `x'==.
}


* HH level for educ and marriage
sort HHID2016 INDID2016

bysort HHID2016: egen expenses_educ=sum(educationexpenses)
bysort HHID2016: egen expenses_marr=sum(marriageexpenses)


gen expenses_total=52*foodexpenses+expenses_educ+healthexpenses+ceremoniesexpenses+deathexpenses+ceremoniesrelativesexpenses


gen expenses_food=52*foodexpenses
gen expenses_heal=healthexpenses
gen expenses_cere=ceremoniesexpenses+deathexpenses+ceremoniesrelativesexpenses

* Agri
egen expenses_agri=rowtotal(productexpenses_paddy productexpenses_ragi productexpenses_millets productexpenses_tapioca productexpenses_cotton productexpenses_sugarca productexpenses_savukku productexpenses_guava productexpenses_groundnut)


drop productexpenses_paddy productexpenses_ragi productexpenses_millets productexpenses_tapioca productexpenses_cotton productexpenses_sugarca productexpenses_savukku productexpenses_guava productexpenses_groundnut educationexpenses foodexpenses healthexpenses ceremoniesexpenses deathexpenses marriageexpenses ceremoniesrelativesexpenses


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
drop INDID2016
duplicates drop

merge 1:1 HHID2016 using "_temp\NEEMSIS1-ass1"
drop _merge

save"outcomes\NEEMSIS1-assets", replace
****************************************
* END
