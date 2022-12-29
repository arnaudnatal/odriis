*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Covid tempo
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
* COVID exposure
***************************************
use"$data", clear

keep HHID2020 INDID2020 start_HH_quest end_HH_quest covsoldgold covlostgold covsellland covfoodenough covfoodquality covgenexpenses covsick covsellgoods_car covsellgoods_bike covsellgoods_fridge covsellgoods_furniture covsellgoods_tailormach covsellgoods_phone covsellgoods_landline covsellgoods_DVD covsellgoods_camera covsellgoods_cookgas covsellgoods_computer covsellgoods_antenna covsellgoods_other covsellgoods_none covsellhouse covsellplot covselllivestock_cow covselllivestock_goat covselllivestock_chicken covselllivestock_bullock covselllivestock_bullforploughin covselllivestock_none covsellequipment_tractor covsellequipment_bullockcar covsellequipment_harvester covsellequipment_plowingmac covsellequipment_none


********** Timing
gen start_HH=dofc(start_HH_quest)
format start_HH %td
gen end_HH=dofc(end_HH_quest)
format end_HH %td
drop start_HH_quest end_HH_quest

* Duration quest
gen duration=end_HH-start_HH

* Covid tempo
ta start_HH if start_HH<d(01jan2021)
ta start_HH if start_HH>d(01jun2021)

gen secondlockdownexposure=.
replace secondlockdownexposure=1 if start_HH<d(05apr2021)
replace secondlockdownexposure=2 if start_HH>d(15jun2021)
replace secondlockdownexposure=3 if start_HH>=d(05apr2021) & start_HH<=d(15jun2021)

label define exposure 1"Before" 2"During" 3"After"
label values secondlockdownexposure exposure

ta secondlockdownexposure
gen dummyexposure=secondlockdownexposure
recode dummyexposure (1=0) (2=.) (3=1)
label values dummyexposure yesno



********* Exposure
destring covsoldgold covlostgold covsellland covfoodenough covfoodquality covgenexpenses covsellhouse covsellplot, replace
drop covselllivestock_none covsellequipment_none covsellgoods_none

* HH level transfo 
rename covselllivestock_bullforploughin covselllivestock_bullforplough
foreach x in covselllivestock_cow covselllivestock_goat covselllivestock_chicken covselllivestock_bullock covselllivestock_bullforplough covsellequipment_tractor covsellequipment_bullockcar covsellequipment_harvester covsellequipment_plowingmac covsellgoods_car covsellgoods_bike covsellgoods_fridge covsellgoods_furniture covsellgoods_tailormach covsellgoods_phone covsellgoods_landline covsellgoods_DVD covsellgoods_camera covsellgoods_cookgas covsellgoods_computer covsellgoods_antenna covsellgoods_other {
bysort HHID2020: egen _`x'=sum(`x')
drop `x'
rename _`x' `x'
replace `x'=1 if `x'>1
}
rename covselllivestock_bullforplough covselllivestock_bullforploughin

* HH level
drop INDID2020
duplicates drop

* Clean
recode covsellland (2=0) (66=0)
recode covsellhouse (2=0) (66=0)
recode covsellplot (2=0) (66=0)
recode covsellland (2=0) (.=0)
recode covsellhouse (2=0) (.=0)
recode covsellplot (2=0) (.=0)
recode covfoodenough (.=66)
recode covfoodquality (.=66)
recode covgenexpenses (.=66)
recode covsick (.=66)

foreach x in covsellland covselllivestock_cow covselllivestock_goat covselllivestock_chicken covselllivestock_bullock covselllivestock_bullforploughin covsellequipment_tractor covsellequipment_bullockcar covsellequipment_harvester covsellequipment_plowingmac covsellgoods_car covsellgoods_bike covsellgoods_fridge covsellgoods_furniture covsellgoods_tailormach covsellgoods_phone covsellgoods_landline covsellgoods_DVD covsellgoods_camera covsellgoods_cookgas covsellgoods_computer covsellgoods_antenna covsellgoods_other covsoldgold covlostgold covsellhouse covsellplot {
label values `x' yesno
}

label define enough 1"Yes" 2"Often" 3"Barely" 4"No" 66"NR"
label values covfoodenough enough

label define quality 1"Increase" 2"Decrease" 3"Remain stable" 66"NR"
label values covfoodquality quality

label define genexpenses 1"More" 2"Less" 3"Same" 66"NR"
label values covgenexpenses genexpenses

label define yesnosick 0"No" 1"Yes" 66"NR" 
label values covsick yesnosick
mdesc


* Aggregate livestock
egen covselllivestock=rowtotal(covselllivestock_cow covselllivestock_goat covselllivestock_chicken covselllivestock_bullock covselllivestock_bullforploughin)
replace covselllivestock=1 if covselllivestock>1
drop covselllivestock_cow covselllivestock_goat covselllivestock_chicken covselllivestock_bullock covselllivestock_bullforploughin
ta covselllivestock
label values covselllivestock yesno

* Aggregagte equipment
egen covsellequipment=rowtotal(covsellequipment_tractor covsellequipment_bullockcar covsellequipment_harvester covsellequipment_plowingmac)
replace covsellequipment=1 if covsellequipment>1
drop covsellequipment_tractor covsellequipment_bullockcar covsellequipment_harvester covsellequipment_plowingmac
ta covsellequipment
label values covsellequipment yesno

* Aggregate goods
egen covsellgoods=rowtotal(covsellgoods_car covsellgoods_bike covsellgoods_fridge covsellgoods_furniture covsellgoods_tailormach covsellgoods_phone covsellgoods_landline covsellgoods_DVD covsellgoods_camera covsellgoods_cookgas covsellgoods_computer covsellgoods_antenna covsellgoods_other)
replace covsellgoods=1 if covsellgoods>1
drop covsellgoods_car covsellgoods_bike covsellgoods_fridge covsellgoods_furniture covsellgoods_tailormach covsellgoods_phone covsellgoods_landline covsellgoods_DVD covsellgoods_camera covsellgoods_cookgas covsellgoods_computer covsellgoods_antenna covsellgoods_other
ta covsellgoods
label values covsellgoods yesno

* Total
fre covselllivestock covsellequipment covsellgoods covsoldgold covsellland covsellhouse covsellplot
egen dummysell=rowtotal(covselllivestock covsellequipment covsellgoods covsoldgold covsellland covsellhouse covsellplot)
replace dummysell=1 if dummysell>1
label values dummysell yesno

* Clean
rename covselllivestock dummysell_live
rename covsellequipment dummysell_equi
rename covsellgoods dummysell_good
rename covsoldgold dummysell_gold
rename covsellland dummysell_land
rename covsellhouse dummysell_hous
rename covsellplot dummysell_plot

order HHID2020 dummyexposure secondlockdownexposure start_HH end_HH duration dummysell dummysell_gold dummysell_land dummysell_hous dummysell_plot dummysell_live dummysell_equi dummysell_good


********** Other measures
fre covlostgold covfoodenough covfoodquality covgenexpenses covsick
drop covlostgold covfoodenough covfoodquality covgenexpenses covsick


save"outcomes\NEEMSIS2-covid", replace
****************************************
* END
