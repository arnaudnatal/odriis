*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 23, 2021
*-----
gl link = "psychodebt"
*Stab
*-----
do "https://raw.githubusercontent.com/arnaudnatal/odriis/main/Materials/WSPY2022/WSPY22.do"
*-------------------------


*ssc install glcurve




****************************************
* Wave 1
***************************************
use"$wave1", clear

********** Add panel id
merge m:m HHID2010 using "ODRIIS-HH_wide", keepusing(HHID_panel)
drop if _merge==2
drop _merge

merge 1:m HHID2010 INDID2010 using "ODRIIS-indiv_wide", keepusing(INDID_panel)
drop if _merge==2
drop _merge
order HHID2010 HHID_panel INDID2010 INDID_panel


********** Add income
preserve
use"$occup1", clear
bysort HHID2010 INDID2010: egen income_indiv=sum(annualincome)
keep HHID2010 INDID2010 income_indiv
duplicates drop
save"temp_occup1", replace
restore

merge 1:1 HHID2010 INDID2010 using "temp_occup1"
drop if _merge==2
drop _merge


********** Add assets
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
gen goldamount=goldquantity*2000

****Total
egen assets=rowtotal(livestockamount goodstotalamount amountownland goldamount housevalue)
egen assets_noland=rowtotal(livestockamount goodstotalamount goldamount housevalue)
egen assets_noprop=rowtotal(livestockamount goodstotalamount goldamount)

***Clean
drop livestockamount_cow livestockamount_goat livestockamount goodsvalue1 goodsvalue2 goodsvalue3 goodsvalue4 goodsvalue5 goodsvalue6 goodsvalue7 goodsvalue8 goodsvalue9 goodsvalue10 goodstotalamount amountownland goldamount


********** Keep var
fre livinghome
drop if livinghome==0

keep HHID_panel INDID_panel village villagearea income_indiv assets
merge 1:1 HHID_panel INDID_panel using "ODRIIS-indiv_wide", keepusing(castecorr2010 agecorr2010 sex2010 relationshiptohead2010)
keep if _merge==3
drop _merge
rename sex2010 sex
rename agecorr2010 age
rename relationshiptohead2010 relationshiptohead
rename castecorr2010 caste
gen year=2010

save"wave1", replace

****************************************
* END




****************************************
* Wave 2
***************************************
use"$wave2", clear

********** Add panel id
tostring INDID2016, replace

merge m:m HHID2016 using "ODRIIS-HH_wide", keepusing(HHID_panel)
drop if _merge==2
drop _merge

merge 1:m HHID2016 INDID2016 using "ODRIIS-indiv_wide", keepusing(INDID_panel)
drop if _merge==2
drop _merge
order HHID2016 HHID_panel INDID2016 INDID_panel


********** Add income
preserve
use"$occup2", clear
tostring INDID2016, replace
bysort HHID2016 INDID2016: egen income_indiv=sum(annualincome)
keep HHID2016 INDID2016 income_indiv
duplicates drop
save"temp_occup2", replace
restore

merge 1:1 HHID2016 INDID2016 using "temp_occup2"
drop if _merge==2
drop _merge


********** Add assets



********** Keep var
fre livinghome
drop if livinghome==3 | livinghome==4

save"wave2", replace
****************************************
* END








****************************************
* Wave 3
***************************************
use"$wave3", clear

********** Add panel id
tostring INDID2020, replace

merge m:m HHID2020 using "ODRIIS-HH_wide", keepusing(HHID_panel)
drop if _merge==2
drop _merge

merge 1:m HHID2020 INDID2020 using "ODRIIS-indiv_wide", keepusing(INDID_panel)
drop if _merge==2
drop _merge
order HHID2020 HHID_panel INDID2020 INDID_panel


********** Add income
preserve
use"$occup3", clear
tostring INDID2020, replace
bysort HHID2020 INDID2020: egen income_indiv=sum(annualincome)
keep HHID2020 INDID2020 income_indiv
duplicates drop
save"temp_occup3", replace
restore

merge 1:1 HHID2020 INDID2020 using "temp_occup3"
drop if _merge==2
drop _merge

fre livinghome
drop if livinghome==3 | livinghome==4

fre dummylefthousehold
drop if dummylefthousehold==1

save"wave3", replace














****************************************
* Lorenz over year
***************************************
use"wave1", clear

glcurve income_indiv, lorenz






****************************************
* END








