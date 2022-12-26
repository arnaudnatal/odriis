*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Caste construction
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
* Caste 2016-17
***************************************
use"$data", clear

* To keep
keep HHID2016 INDID2016 jatis villageid villagearea

* Merge with panel to consistency + other
tostring INDID2016, replace
merge m:m HHID2016 INDID2016 using "ODRIIS-indiv_wide", keepusing(jatis2010 jatis2016 jatis2020 HHID_panel)
destring INDID2016, replace
keep if _merge==3
drop _merge

* Corr
gen jatiscorr2010=jatis2010
gen jatiscorr2016=jatis2016
gen jatiscorr2020=jatis2020

order HHID2016 HHID_panel INDID2016 jatis jatiscorr2010 jatiscorr2016 jatiscorr2020
sort jatis HHID2016 INDID2016
replace jatiscorr2020="Vanniyar" if HHID_panel=="KAR30"
replace jatiscorr2020="Vanniyar" if HHID_panel=="ELA16"
replace jatiscorr2020="Mudaliar" if HHID_panel=="GOV19"
replace jatiscorr2020="Mudaliar" if HHID_panel=="GOV2"

replace jatiscorr2016="SC" if HHID2016=="uuid:55d4d934-626c-49e7-b1ad-ee4daf8b1a4a"

drop jatis2010 jatis2016 jatis2020 jatiscorr2010 jatiscorr2020
rename jatiscorr2016 jatiscorr


* Manually classify
fre jatiscorr
gen caste2=.
replace caste2=1 if jatiscorr=="Arunthathiyar"
replace caste2=2 if jatiscorr=="Asarai"
replace caste2=3 if jatiscorr=="Chettiyar"
replace caste2=2 if jatiscorr=="Gramani"
replace caste2=2 if jatiscorr=="Kulalar"
replace caste2=3 if jatiscorr=="Mudaliar"
replace caste2=2 if jatiscorr=="Muslims"
replace caste2=3 if jatiscorr=="Naidu"
replace caste2=2 if jatiscorr=="Nattar"
replace caste2=2 if jatiscorr=="Navithar"
replace caste2=2 if jatiscorr=="Padayachi"
replace caste2=3 if jatiscorr=="Rediyar"
replace caste2=1 if jatiscorr=="SC"
replace caste2=3 if jatiscorr=="Settu"
replace caste2=2 if jatiscorr=="Vanniyar"
replace caste2=3 if jatiscorr=="Yathavar"

* Clean
rename caste2 caste
fre caste
drop villageid villagearea


save"outcomes\NEEMSIS1-caste", replace
****************************************
* END
