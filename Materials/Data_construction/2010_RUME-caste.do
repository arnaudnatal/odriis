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
* Caste 2010
***************************************
use"$data", clear

* To keep
keep HHID2010 INDID2010 jatis caste village villagearea

* Classification already in the questionnaire
fre jatis
ta jatis caste

* Merge with panel to consistency + other
merge m:m HHID2010 INDID2010 using "ODRIIS-indiv_wide", keepusing(jatis2010 jatis2016 jatis2020 HHID_panel)
keep if _merge==3
drop _merge

* Corr
gen jatiscorr2010=jatis2010
gen jatiscorr2016=jatis2016
gen jatiscorr2020=jatis2020

order HHID2010 HHID_panel INDID2010 jatis jatis2010 jatis2016 jatis2020 jatiscorr2010 jatiscorr2016 jatiscorr2020
sort jatis HHID2010 INDID2010
replace jatiscorr2020="Vanniyar" if HHID_panel=="KAR30"
replace jatiscorr2020="Vanniyar" if HHID_panel=="ELA16"
replace jatiscorr2020="Mudaliar" if HHID_panel=="GOV19"
replace jatiscorr2020="Mudaliar" if HHID_panel=="GOV2"


replace jatiscorr2010="Padayachi" if HHID2010=="PSEP78"
replace jatiscorr2010="Padayachi" if HHID2010=="VENOR397"
replace jatiscorr2010="SC" if HHID2010=="SIMTP297"
replace jatiscorr2010="Vanniyar" if HHID2010=="ANTMP241"
replace jatiscorr2010="Chettiyar" if HHID2010=="SISEM106"
replace jatiscorr2010="Chettiyar" if HHID2010=="SISEM107"
replace jatiscorr2010="Padayachi" if HHID2010=="PSEP75"
replace jatiscorr2010="SC" if HHID2010=="PSKOR205"
replace jatiscorr2010="Naidu" if HHID2010=="PSSEM90"
replace jatiscorr2010="Muslims" if HHID2010=="PSSEM91"
replace jatiscorr2010="Muslims" if HHID2010=="PSSEM93"
replace jatiscorr2010="Muslims" if HHID2010=="RASEM89"
replace jatiscorr2010="Muslims" if HHID2010=="SISEM104"
replace jatiscorr2010="Yathavar" if HHID2010=="VENKARU272"
replace jatiscorr2010="Vanniyar" if HHID2010=="VENKU244"
replace jatiscorr2010="Navithar" if HHID2010=="VENOR392"
replace jatiscorr2010="Vanniyar" if HHID2010=="VENOR396"
replace jatiscorr2010="Muslims" if HHID2010=="VENSEM111"
replace jatiscorr2010="Muslims" if HHID2010=="VENSEM112"
replace jatiscorr2010="Muslims" if HHID2010=="VENSEM113"
replace jatiscorr2010="Vanniyar" if HHID2010=="ANDMTP324"

drop jatis2010 jatis2016 jatis2020 jatiscorr2016 jatiscorr2020
rename jatiscorr2010 jatiscorr


* Manually classify
fre jatiscorr
gen caste2=.
replace caste2=1 if jatiscorr=="Arunthathiyar"
replace caste2=2 if jatiscorr=="Asarai"
replace caste2=3 if jatiscorr=="Chettiyar"
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

replace caste2=88 if jatiscorr=="Other"
ta caste if caste2==88
replace caste2=2 if jatiscorr=="Other"

replace caste2=1 if HHID_panel=="MAN22"

ta caste caste2

* Clean
rename caste2 castecorr
drop caste villagearea village
rename castecorr caste

preserve
collapse (mean) caste, by(HHID2010)
ta caste
restore

preserve
collapse (mean) caste, by(HHID_panel)
ta caste
restore

save"outcomes\RUME-caste", replace
****************************************
* END






/*
*TEST
use"outcomes\RUME-caste", clear
collapse (mean) caste, by(HHID_panel)
gen t=1
save"_temp\test1", replace


use"outcomes\NEEMSIS1-caste", clear
collapse (mean) caste, by(HHID_panel)
gen t=2
save"_temp\test2", replace

use"outcomes\NEEMSIS2-caste", clear
collapse (mean) caste, by(HHID_panel)
gen t=3
save"_temp\test3", replace


use"_temp\test1", clear
append using "_temp\test2"
append using "_temp\test3"

ta caste t

reshape wide caste, i(HHID_panel) j(t)

ta caste1 caste2
ta caste2 caste3
*/
