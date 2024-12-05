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
* Base simple
****************************************

********** NEEMSIS-2
use"NEEMSIS2-jatis_raw", clear

decode jatis, gen(jatis_str)
drop jatis
rename jatis_str jatis

merge 1:m HHID2020 using "keypanel-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge
drop HHID2020
rename jatis jatis2020
order HHID_panel

save "_temp\N2_c", replace




********** NEEMSIS-2 GPS
use"NEEMSIS2-GPS", clear

keep HHID_panel jatisdetails3
rename jatisdetails3 jatis2023
order HHID_panel

save "_temp\N2G_c", replace




********** NEEMSIS-1
use"NEEMSIS1-jatis_raw", clear

decode jatis, gen(jatis_str)
drop jatis
rename jatis_str jatis

merge m:m HHID2016 using "keypanel-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge
drop HHID2016
rename jatis jatis2016
order HHID_panel
drop if jatis==""

save "_temp\N1_c", replace




********** RUME
use"RUME-jatis_raw", clear

decode jatis, gen(jatis_str)
drop jatis
rename jatis_str jatis

merge 1:m HHID2010 using "keypanel-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge
drop HHID2010
rename jatis jatis2010
order HHID_panel

save "_temp\R_c", replace

****************************************
* END










****************************************
* Tout mettre ensemble et corriger
****************************************
use"_temp\N2_c", clear

merge 1:1 HHID_panel using "_temp\N2G_c"
drop _merge

merge 1:1 HHID_panel using "_temp\N1_c"
drop _merge

merge 1:1 HHID_panel using "_temp\R_c"
drop _merge

order HHID_panel jatis2010 jatis2016 jatis2020 jatis2023
sort HHID_panel


* Replace jatis
replace jatis2023="Muslims" if jatis2023=="Muslim"
replace jatis2023="Rediyar" if jatis2023=="Reddiyar"
replace jatis2010="Mudaliar" if jatis2010=="Muthaliyar"

* Jatis to check
gen tocheck=0
replace tocheck=1 if HHID_panel=="ELA11"
replace tocheck=1 if HHID_panel=="ELA21"
replace tocheck=1 if HHID_panel=="ELA39"
replace tocheck=1 if HHID_panel=="GOV13"
replace tocheck=1 if HHID_panel=="GOV14"
replace tocheck=1 if HHID_panel=="GOV16"
replace tocheck=1 if HHID_panel=="GOV19"
replace tocheck=1 if HHID_panel=="GOV38"
replace tocheck=1 if HHID_panel=="GOV39"
replace tocheck=1 if HHID_panel=="GOV58"
replace tocheck=1 if HHID_panel=="GOV59"
replace tocheck=1 if HHID_panel=="GOV61"
replace tocheck=1 if HHID_panel=="GOV62"
replace tocheck=1 if HHID_panel=="GOV63"
replace tocheck=1 if HHID_panel=="KAR24"
replace tocheck=1 if HHID_panel=="KAR48"
replace tocheck=1 if HHID_panel=="KUV33"
replace tocheck=1 if HHID_panel=="KUV63"
replace tocheck=1 if HHID_panel=="MANAM11"
replace tocheck=1 if HHID_panel=="MANAM12"
replace tocheck=1 if HHID_panel=="NAT39"
replace tocheck=1 if HHID_panel=="NAT45"
replace tocheck=1 if HHID_panel=="NAT51"
replace tocheck=1 if HHID_panel=="ORA10"
replace tocheck=1 if HHID_panel=="ORA21"
replace tocheck=1 if HHID_panel=="ORA51"
replace tocheck=1 if HHID_panel=="SEM4"

*
gen jatispanel=""
replace jatispanel="Nattar" if HHID_panel=="ELA1"
replace jatispanel="Nattar" if HHID_panel=="ELA10"
replace jatispanel="Nattar" if HHID_panel=="ELA13"
replace jatispanel="Vanniyar" if HHID_panel=="ELA33"
replace jatispanel="Nattar" if HHID_panel=="ELA42"
replace jatispanel="Nattar" if HHID_panel=="ELA43"
replace jatispanel="Vanniyar" if HHID_panel=="ELA49"
replace jatispanel="Nattar" if HHID_panel=="ELA7"
replace jatispanel="Mudaliar" if HHID_panel=="GOV2"
replace jatispanel="Mudaliar" if HHID_panel=="GOV28"
replace jatispanel="Mudaliar" if HHID_panel=="GOV34"
replace jatispanel="Mudaliar" if HHID_panel=="GOV40"
replace jatispanel="Mudaliar" if HHID_panel=="GOV42"
replace jatispanel="Mudaliar" if HHID_panel=="GOV45"
replace jatispanel="Mudaliar" if HHID_panel=="GOV48"
replace jatispanel="Mudaliar" if HHID_panel=="GOV50"
replace jatispanel="Mudaliar" if HHID_panel=="GOV51"
replace jatispanel="Mudaliar" if HHID_panel=="GOV53"
replace jatispanel="Mudaliar" if HHID_panel=="GOV45"
replace jatispanel="Mudaliar" if HHID_panel=="GOV6"
replace jatispanel="Arunthathiyar" if HHID_panel=="KAR13"
replace jatispanel="Paraiyar" if HHID_panel=="KAR9"
replace jatispanel="Paraiyar" if HHID_panel=="KOR23"
replace jatispanel="Naidu" if HHID_panel=="KOR33"
replace jatispanel="Vanniyar" if HHID_panel=="KUV13"
replace jatispanel="Vanniyar" if HHID_panel=="KUV52"
replace jatispanel="Vanniyar" if HHID_panel=="MAN18"
replace jatispanel="Paraiyar" if HHID_panel=="MAN22"
replace jatispanel="Paraiyar" if HHID_panel=="MANAM18"
replace jatispanel="Arunthathiyar" if HHID_panel=="MANAM26"
replace jatispanel="Arunthathiyar" if HHID_panel=="MANAM28"
replace jatispanel="Naidu" if HHID_panel=="MANAM31"
replace jatispanel="Naidu" if HHID_panel=="MANAM50"
replace jatispanel="Naidu" if HHID_panel=="MANAM6"
replace jatispanel="Naidu" if HHID_panel=="MANAM64"
replace jatispanel="Arunthathiyar" if HHID_panel=="ORA12"
replace jatispanel="Vanniyar" if HHID_panel=="ORA37"
replace jatispanel="Muslims" if HHID_panel=="SEM1"
replace jatispanel="Chettiyar" if HHID_panel=="SEM10"
replace jatispanel="Valluvar" if HHID_panel=="SEM12"
replace jatispanel="Valluvar" if HHID_panel=="SEM14"
replace jatispanel="Muslims" if HHID_panel=="SEM16"
replace jatispanel="Naidu" if HHID_panel=="SEM17"
replace jatispanel="Muslims" if HHID_panel=="SEM26"
replace jatispanel="Muslims" if HHID_panel=="SEM28"
replace jatispanel="Muslims" if HHID_panel=="SEM35"
replace jatispanel="Muslims" if HHID_panel=="SEM40"
replace jatispanel="Valluvar" if HHID_panel=="SEM42"
replace jatispanel="Muslims" if HHID_panel=="SEM43"
replace jatispanel="Valluvar" if HHID_panel=="SEM46"
replace jatispanel="Chettiyar" if HHID_panel=="SEM48"
replace jatispanel="Valluvar" if HHID_panel=="SEM5"
replace jatispanel="Valluvar" if HHID_panel=="SEM6"
replace jatispanel="Kulalar" if HHID_panel=="SEM7"
replace jatispanel="Valluvar" if HHID_panel=="SEM8"

* Pour le reste
replace jatispanel=jatis2023 if tocheck==0 & jatispanel=="" & jatis2023!=""
fre jatispanel
ta tocheck
replace jatispanel=jatis2016 if tocheck==0 & jatispanel=="" & jatis2023=="" & jatis2016!=""
replace jatispanel=jatis2010 if tocheck==0 & jatispanel=="" & jatis2023=="" & jatis2016=="" & jatis2010!=""
sort jatispanel

* Les SC de 2010 et 2016 sont des paraiyars car ils ne sont pas arunthathiy a priori
replace jatispanel="Paraiyar" if jatispanel=="SC"
sort jatispanel HHID_panel

ta jatispanel
replace jatispanel="Paraiyar" if jatispanel=="Valluvar"

order tocheck, last

save"_temp\Panelcorr_v1", replace
****************************************
* END











****************************************
* Charact of those to check with Venkat
****************************************
***
use"NEEMSIS2-HH", clear

keep HHID2020 address village_new villagename villagearea username
duplicates drop

merge 1:1 HHID2020 using "outcomes/NEEMSIS2-family", keepusing(head_name head_sex head_age)
drop _merge

order HHID2020 username villagename villagearea village_new address head_name head_sex head_age 

rename village_new interviewplace

* Merge panel
merge 1:m HHID2020 using "keypanel-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge
order HHID2020 HHID_panel

save"_temp\tempHHcharact", replace


**
use"_temp\Panelcorr_v1", clear

keep if tocheck==1
drop tocheck jatispanel

merge 1:1 HHID_panel using "_temp\tempHHcharact"
keep if _merge==3
drop _merge
order jatis*, last
order HHID2020 HHID_panel
sort HHID_panel

save"_temp\Verif_Venkat", replace
export excel using "_temp\Castetocheck.xlsx", firstrow(variables) replace

****************************************
* END






