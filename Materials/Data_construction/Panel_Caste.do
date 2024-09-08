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
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\NEEMSIS-Construction"
cd"$directory"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020







****************************************
* Caste for each year
***************************************

***** 2010
use"RUME-HH", clear

keep HHID2010 jatis
duplicates drop
merge 1:m HHID2010 using "keypanel-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge HHID2010
gen year=2010
order HHID_panel year
decode jatis, gen(jatis_HH)
drop jatis
save"_temp/b1", replace


***** 2016
use"NEEMSIS1-HH", clear

keep HHID2016 jatis
duplicates drop
merge 1:m HHID2016 using "keypanel-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge HHID2016
gen year=2016
order HHID_panel year
decode jatis, gen(jatis_HH)
drop jatis
save"_temp/b2", replace


***** 2020
use"NEEMSIS2-HH", clear

keep HHID2020 jatis
duplicates drop
merge 1:m HHID2020 using "keypanel-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge HHID2020
gen year=2020
order HHID_panel year
decode jatis, gen(jatis_HH)
drop jatis
merge 1:1 HHID_panel using "NEEMSIS2-GPS", keepusing(jatis jatisdetails)
keep if _merge==3
drop _merge
decode jatis, gen(jatis_GPS)
ta jatis_GPS
drop jatis
rename jatisdetails jatisdetails_GPS
save"_temp/b3", replace


***** Append
use"_temp/b1", clear

append using "_temp/b2"
append using "_temp/b3"

* Structure données 1
bysort HHID_panel: gen n=_N
order n, after(HHID_panel)

gen jatis=""
replace jatis=jatis_HH if year==2010
replace jatis=jatis_HH if year==2016
replace jatis=jatis_GPS if year==2020

drop jatis_HH jatisdetails_GPS jatis_GPS

reshape wide jatis, i(HHID_panel) j(year)

* Structure données 2
order HHID_panel n
gen t1=.
replace t1=1 if n==2 & jatis2010!="" & jatis2016!="" & jatis2020==""
replace t1=2 if n==2 & jatis2010=="" & jatis2016!="" & jatis2020!=""
replace t1=3 if n==2 & jatis2010!="" & jatis2016=="" & jatis2020!=""
label define t1 1"2010-2016" 2"2016-2020" 3"2010-2020"
label values t1 t1

gen t2=.
replace t2=1 if n==1 & jatis2010!="" & jatis2016=="" & jatis2020==""
replace t2=2 if n==1 & jatis2010=="" & jatis2016!="" & jatis2020==""
replace t2=3 if n==1 & jatis2010=="" & jatis2016=="" & jatis2020!=""
label define t2 1"2010" 2"2016" 3"2020"
label values t2 t2

order HHID_panel n t1 t2
sort n t1 t2 HHID_panel


* Remplacer les jatis de 2010 et 2016 par celui du GPS 2020 si ménage panel car plus sûr
gen jatisnew2010=jatis2010
gen jatisnew2016=jatis2016
gen jatisnew2020=jatis2020

replace jatisnew2010=jatis2020 if n==3
replace jatisnew2016=jatis2020 if n==3

replace jatisnew2010=jatis2020 if n==2 & t1==3
replace jatisnew2016=jatis2020 if n==2 & t1==2

* Vérifier la cohérence de ceux qui restent, i.e., panel 2010, 2016, mais pas 2020
list jatis2010 jatis2016 if n==2 & t1==1, clean noobs
*Ils sont cohérents

* Vérifier les autres
ta jatisnew2010 // 2
ta jatisnew2016 // 2
ta jatisnew2020 // 2

save"_temp/newjatis_wide", replace


***** Reshape
use"_temp/newjatis_wide", clear

reshape long jatis jatisnew, i(HHID_panel) j(year)
drop if jatis=="" & jatisnew==""
ta year


* Recoder les exceptions à la main :
gen other=.
replace other=1 if jatisnew=="Other"
bysort HHID_panel: egen maxother=max(other)
sort HHID_panel year
list if maxother==1, clean noobs

*
replace jatisnew="Nattar" if HHID_panel=="ELA43"
replace jatisnew="Vanniyar" if HHID_panel=="ORA21"

save"_temp/castepanellong", replace


use"_temp/castepanellong", clear

replace jatisnew="Mudaliar" if jatisnew=="Muthaliyar"
replace jatisnew="Vanniyar" if jatisnew=="Padayachi"
replace jatisnew="Marwari" if jatisnew=="Settu"


keep HHID_panel year jatisnew

gen castenew=.
replace castenew=1 if jatisnew=="SC"
replace castenew=1 if jatisnew=="Arunthathiyar"

replace castenew=2 if jatisnew=="Asarai"
replace castenew=2 if jatisnew=="Kulalar"
replace castenew=2 if jatisnew=="Gramani"
replace castenew=2 if jatisnew=="Vanniyar"
replace castenew=2 if jatisnew=="Nattar"
replace castenew=2 if jatisnew=="Navithar"
replace castenew=2 if jatisnew=="Muslims"

replace castenew=3 if jatisnew=="Rediyar"
replace castenew=3 if jatisnew=="Marwari"
replace castenew=3 if jatisnew=="Naidu"
replace castenew=3 if jatisnew=="Chettiyar"
replace castenew=3 if jatisnew=="Mudaliar"
replace castenew=3 if jatisnew=="Yathavar"

label define caste 1"Dalits" 2"Middle castes" 3"Upper castes"
label values castenew caste

rename jatisnew jatisn
rename castenew casten

ta casten year, col nofreq
ta jatisn casten, col nofreq

save"outcomes/JatisCastePanel", replace

****************************************
* END


















****************************************
* Caste panel
***************************************

***** 2010
use"outcomes\RUME-caste", clear

drop INDID2010
rename HHID2010 HHID
gen year=2010
duplicates drop

save "_temp\RUME-castetp", replace



***** 2016-17
use"outcomes\NEEMSIS1-caste", clear

drop INDID2016
rename HHID2016 HHID
gen year=2016
duplicates drop

save "_temp\NEEMSIS1-castetp", replace



***** 2020-21
use"outcomes\NEEMSIS2-caste", clear

drop INDID2020
rename HHID2020 HHID
gen year=2020
duplicates drop

save "_temp\NEEMSIS2-castetp", replace




***** Panel
use"_temp\RUME-castetp", clear

append using "_temp\NEEMSIS1-castetp"
append using "_temp\NEEMSIS2-castetp"

reshape wide HHID jatis jatiscorr caste, i(HHID_panel) j(year)

ta caste2010 caste2016
ta caste2016 caste2020

save"outcomes\Panel-Caste_HH.dta", replace
****************************************
* END
