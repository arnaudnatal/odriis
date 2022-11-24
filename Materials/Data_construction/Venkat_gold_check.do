*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Gold
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox\RUME-NEEMSIS\Data\Construction"
cd"$directory"

********** Database names
global data1 = "RUME-HH"
global data2 = "NEEMSIS1-HH"
global data3 = "NEEMSIS2-HH"

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
use"$data1", clear

keep HHID2010 goldquantity sizeownland jatis
decode jatis, gen(jatis_str)
drop jatis
rename jatis_str jatis
duplicates drop

merge 1:m HHID2010 using "ODRIIS-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge
gen year=2010


save"_temp\tempRUME-gold_HH", replace
****************************************
* END








****************************************
* Gold 2016
***************************************
use"$data2", clear

keep HHID2016 INDID2016 goldquantity sizeownland jatis username
foreach x in jatis {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}

bysort HHID2016: egen goldquantity_HH=sum(goldquantity)
drop goldquantity
rename goldquantity_HH goldquantity

keep HHID2016 goldquantity sizeownland jatis username
duplicates drop

merge 1:m HHID2016 using "ODRIIS-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge
gen year=2016


save"_temp\tempNEEMSIS1-gold_HH", replace
****************************************
* END










****************************************
* Gold 2020
***************************************
use"$data3", clear

keep HHID2020 INDID2020 goldquantity sizeownland jatis username
decode jatis, gen(jatis_str)
drop jatis
rename jatis_str jatis

bysort HHID2020: egen goldquantity_HH=sum(goldquantity)
drop goldquantity
rename goldquantity_HH goldquantity

keep HHID2020 goldquantity sizeownland jatis username
duplicates drop

merge 1:m HHID2020 using "ODRIIS-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge
gen year=2020


save"_temp\tempNEEMSIS2-gold_HH", replace
****************************************
* END








****************************************
* Panel gold
***************************************
use"_temp\tempNEEMSIS2-gold_HH", clear

append using "_temp\tempNEEMSIS1-gold_HH"
append using "_temp\tempRUME-gold_HH"

* Merge village caste
tostring year, replace
merge 1:m HHID_panel year using "ODRIIS-HH_long", keepusing(villageid castecorr)
keep if _merge==3
drop _merge
rename castecorr caste
destring year, replace

gen HHID=""
replace HHID=HHID2010 if HHID2010!=""
replace HHID=HHID2016 if HHID2016!=""
replace HHID=HHID2020 if HHID2020!=""
drop HHID2010 HHID2016 HHID2020

order HHID_panel HHID year
sort HHID_panel year

save"_temp\temppanel-gold_HH", replace
****************************************
* END



****************************************
* Labour HH
***************************************
use"outcomes/RUME-occup_indiv", clear
keep HHID2010 INDID2010 mainocc_occupation_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv

append using "outcomes/NEEMSIS1-occup_indiv"
keep HHID2010 INDID2010 HHID2016 INDID2016 mainocc_occupation_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv

append using "outcomes/NEEMSIS2-occup_indiv"
keep HHID2010 INDID2010 HHID2016 INDID2016 HHID2020 INDID2020 mainocc_occupation_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv



****************************************
* END



reshape wide HHID goldquantity sizeownland, i(HHID_panel) j(year)

gen evogold1=goldquantity2016-goldquantity2010
gen evogold2=goldquantity2020-goldquantity2016


* 2010 strange
sort goldquantity2020
order HHID_panel villageid castecorr goldquantity2010 goldquantity2016 goldquantity2020 evogold1 evogold2 sizeownland2010 sizeownland2016 sizeownland2020
br

* 2016 strange
sort goldquantity2016
order HHID_panel villageid castecorr goldquantity2010 goldquantity2016 goldquantity2020 evogold1 evogold2 sizeownland2010 sizeownland2016 sizeownland2020
br

* 2010-16 strange
sort evogold1
order HHID_panel villageid castecorr goldquantity2010 goldquantity2016 goldquantity2020 evogold1 evogold2 sizeownland2010 sizeownland2016 sizeownland2020
br

* 2016 strange
sort goldquantity2016
order HHID_panel villageid castecorr goldquantity2010 goldquantity2016 goldquantity2020 evogold1 evogold2 sizeownland2010 sizeownland2016 sizeownland2020
br

