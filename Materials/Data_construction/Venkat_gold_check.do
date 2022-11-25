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

keep HHID2010 sizeownland jatis goldquantity goldquantitypledge goldamountpledge
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

keep HHID2016 INDID2016 goldquantity goldquantitypledge goldamountpledge sizeownland jatis username
foreach x in jatis {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}

foreach x in goldquantity goldquantitypledge goldamountpledge {
bysort HHID2016: egen `x'_HH=sum(`x')
drop `x'
rename `x'_HH `x'
}

keep HHID2016 gold* sizeownland jatis username
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

keep HHID2020 INDID2020 goldquantity goldquantitypledge goldamountpledge sizeownland jatis username goldquantitypledge goldamountpledge
decode jatis, gen(jatis_str)
drop jatis
rename jatis_str jatis

foreach x in goldquantity goldquantitypledge goldamountpledge {
bysort HHID2020: egen `x'_HH=sum(`x')
drop `x'
rename `x'_HH `x'
}


keep HHID2020 goldquantity goldquantitypledge goldamountpledge sizeownland jatis username
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
gen year=2010

append using "outcomes/NEEMSIS1-occup_indiv"
keep year HHID2010 INDID2010 HHID2016 INDID2016 mainocc_occupation_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv
replace year=2016 if year==.

append using "outcomes/NEEMSIS2-occup_indiv"
keep year HHID2010 INDID2010 HHID2016 INDID2016 HHID2020 INDID2020 mainocc_occupation_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv
replace year=2020 if year==.

gen HHID=""
foreach x in 2010 2016 2020 {
replace HHID=HHID`x' if HHID`x'!=""
}

order HHID year HHID2010 HHID2016 HHID2020

tostring INDID2016 INDID2020, replace
replace INDID2016="" if INDID2016=="."
replace INDID2020="" if INDID2020=="."
gen INDID=""
foreach x in 2010 2016 2020 {
replace INDID=INDID`x' if INDID`x'!=""
}
order HHID INDID


*** HHID_panel
tostring year, replace
merge m:m HHID year using "ODRIIS-HH_long", keepusing(HHID_panel)
keep if _merge==3
drop _merge
drop HHID2010 HHID2016 HHID2020 INDID2010 INDID2016 INDID2020
order HHID_panel
sort HHID_panel year INDID
drop if mainocc_occupation_indiv==.
destring year, replace

save"_temp\temppanelworker", replace
****************************************
* END










****************************************
* Labour HH and gold
***************************************
use"_temp\temppanel-gold_HH", clear

merge 1:m HHID_panel year using "_temp\temppanelworker"


gen pbdalits=0
replace pbdalits=1 if (goldquantity>60 & caste=="Dalits")

gen pbnondalits=0
replace pbnondalits=1 if goldquantity>100 & (caste=="Middle" | caste=="Upper")

bysort HHID_panel: egen pbdalits_HH=max(pbdalits)
bysort HHID_panel: egen pbnondalits_HH=max(pbnondalits)


order HHID_panel year caste jatis goldquantity goldquantitypledge goldamountpledge sizeownland mainocc_occupation_indiv annualincome_indiv pbdalits_HH pbnondalits_HH

sort pbdalits_HH HHID_panel year INDID goldquantity
*How many HH?
preserve
keep HHID_panel year goldquantity goldquantitypledge goldamountpledge sizeownland caste jatis villageid pbdalits_HH pbnondalits_HH
duplicates drop
ta year
ta pbdalits year, col
/*
pbdalits_H |               year
         H |      2010       2016       2020 |     Total
-----------+---------------------------------+----------
         0 |       307        373        494 |     1,174 
           |     75.80      75.81      78.16 |     76.78 
-----------+---------------------------------+----------
         1 |        98        119        138 |       355 
           |     24.20      24.19      21.84 |     23.22 
-----------+---------------------------------+----------
     Total |       405        492        632 |     1,529 
           |    100.00     100.00     100.00 |    100.00 
*/
ta pbnondalits year, col
/*
pbnondalit |               year
      s_HH |      2010       2016       2020 |     Total
-----------+---------------------------------+----------
         0 |       335        401        529 |     1,265 
           |     82.72      81.50      83.70 |     82.73 
-----------+---------------------------------+----------
         1 |        70         91        103 |       264 
           |     17.28      18.50      16.30 |     17.27 
-----------+---------------------------------+----------
     Total |       405        492        632 |     1,529 
           |    100.00     100.00     100.00 |    100.00 
*/
restore

save"_temp\corrgoldAntony", replace
****************************************
* END











****************************************
* Corrections
****************************************
use"_temp\corrgoldAntony", clear


********** Dalits
order HHID_panel year caste jatis goldquantity goldquantitypledge goldamountpledge sizeownland mainocc_occupation_indiv annualincome_indiv pbdalits_HH pbnondalits_HH

sort pbdalits_HH HHID_panel year INDID goldquantity



********** Dalits
order HHID_panel year caste jatis goldquantity goldquantitypledge goldamountpledge sizeownland mainocc_occupation_indiv annualincome_indiv pbnondalits_HH pbdalits_HH

sort pbnondalits_HH HHID_panel year INDID goldquantity

keep HHID_panel HHID year goldquantity goldquantitypledge goldamountpledge pbnondalits_HH pbdalits_HH
duplicates drop
ta year

****************************************
* END
















****************************************
* Corrections
****************************************
use"outcomes\Goldpb", clear


ta pbdalits_HH year
ta pbnondalits_HH year



****************************************
* END
