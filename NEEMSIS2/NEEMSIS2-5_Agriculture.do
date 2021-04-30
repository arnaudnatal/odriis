/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
February 23, 2021
-----
AGRICULTURE DATA BASE CLEANING
-----

-------------------------
*/






****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
cd "$directory"

********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

****************************************
* END









****************************************
* CLEANING
****************************************
/*
Comme précédemment, il faut mettre tous les fichiers des bases agri
dans le sous dossier "agri_raw"
*/
clear all
filelist, dir("$directory\agri_raw") pattern(*.dta)
split filename, p(-)
keep if substr(filename1,strlen(filename1)-3,4)==".dta"
drop filename1 filename2 filename3 filename4
gen versionquestionnaire=substr(filename,1,strlen(filename)-4)
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = filename
	local v = versionquestionnaire
	use "$directory\agri_raw\\`f'"
	split username
	capture confirm v username2
	if !_rc {
	drop username2
	}
	destring username1, replace
	drop username
	rename username1 username
	rename key parent_key
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	gen version="`v'"
	tempfile save`i'
	save "$directory\agri_raw\\new-_`f'", replace
}
****************************************
* END
















****************************************
* APPEND
****************************************

********** ALL NAME AS BEFORE
clear all
filelist, dir("$directory\agri_raw") pattern(*.dta)
split filename, p(-)
drop if filename1=="new"
egen genericname=concat( filename2 filename3 filename4) if substr(filename1,strlen(filename1)-4,4)!=".dta", p(-)
replace genericname=substr(genericname,1,strlen(genericname)-1) if substr(genericname,strlen(genericname),1)=="-"
replace genericname=substr(genericname,1,strlen(genericname)-1) if substr(genericname,strlen(genericname),1)=="-"
replace genericname=substr(genericname,1,strlen(genericname)-1) if substr(genericname,strlen(genericname),1)=="-"
replace genericname="-"+genericname
replace genericname="" if genericname=="-"
keep genericname
duplicates drop
list, clean noobs




********** ALL FILES AS BEFORE 
global genericname -agriculture-equipmentowned.dta -agriculture-landgroup-products.dta -agriculture-livestock.dta -consumptionandassets-detailsgoods.dta  
foreach k in $genericname{
clear all
set obs 1
gen forauto="" in 1
save"$directory/_temp/NEEMSIS2_Agriculture`k'", replace
save"$directory/_temp/NEEMSIS2_DECEMBER_Agriculture`k'", replace
save"$directory/_temp/NEEMSIS2_DEC_Agriculture`k'", replace
save"$directory/_temp/NEEMSIS2_FEB_NEW_Agriculture`k'", replace
save"$directory/_temp/NEEMSIS2_FEBRUARY_Agriculture`k'", replace

}




********** INSTRUCTIONS:
/*
Point sur la situation: 
- Dans le sous-dossier "_temp" il y a tous les fichiers possibles avec une variable vide "forauto" servant uniquement à éviter les erreurs durant le append.
- Dans le sous-dossier "agri_raw" il y a tous les fichiers bruts .dta


Afin que le append fonctionne, nous allons donc déplacer TOUS les .dta du sous-dossier "_temp" (avec forauto donc) dans le dossier agri_raw SANS REMPLACER LES FICHIERS EXISTANTS.
Les fichiers existants contiennent les données, pas ceux de _temp.
Donc nous déplacons UNIQUEMENT ceux qui n'existent pas dans le dossier "agri_raw".
Concretemment, copier coller en demandant au pc de ne pas remplacer si jamais le fichier existe déjà.

Normalement ca deplace peu de fichiers au final car la plupart des versions de l'enquête ont ouvert presque toutes les listes.
*/




********** APPEND ALL LONG FILES
foreach k in $genericname{
use "$directory\agri_raw\NEEMSIS2_Agriculture`k'", clear
append using "$directory\agri_raw\NEEMSIS2_DECEMBER_Agriculture`k'", force
append using "$directory\agri_raw\NEEMSIS2_DEC_Agriculture`k'", force
append using "$directory\agri_raw\NEEMSIS2_FEB_NEW_Agriculture`k'", force
append using "$directory\agri_raw\NEEMSIS2_FEBRUARY_Agriculture`k'", force
do"$directory\do_not_drop\_1-3-datachoicelist_v2.do"
save "$directory\CLEAN\NEEMSIS_Agriculture_APPEND`k'", replace
}




********** APPEND MASTER FILE
use "$directory\agri_raw\new-_NEEMSIS2_Agriculture.dta", clear
append using "$directory\agri_raw\new-_NEEMSIS2_DECEMBER_Agriculture.dta", force
append using "$directory\agri_raw\new-_NEEMSIS2_DEC_Agriculture.dta", force
append using "$directory\agri_raw\new-_NEEMSIS2_FEB_NEW_Agriculture.dta", force
append using "$directory\agri_raw\new-_NEEMSIS2_FEBRUARY_Agriculture.dta", force
do"$directory\do_not_drop\_1-3-datachoicelist_v2.do"




********** INTERMEDIATE CLEANING
label define username1 1"Antoni" 2"Vivek Radja" 3"Venkata" 4"Suganya-Malarvizhi" 5"Rajkumar" 6"Suganya-Malarvizhi" 7"Chithra-Radhika" 8"Raichal" 9"Rajalakschmi" 10"Chithra-Radhika" 11"Mayan" 12"Pazani", replace
label values username username1
fre username
recode username (6=4)
recode username (10=7)
fre username
*drop username_*
decode username, gen(username_str)
tab username_str

gen Chithra_and_Radhika=1 if username_str=="Chithra-Radhika"
replace Chithra_and_Radhika=0 if username_str!="Chithra-Radhika"

gen Raichal=1 if username_str=="Raichal"
replace Raichal=0 if username_str!="Raichal"

gen Mayan=1 if username_str=="Mayan"
replace Mayan=0 if username_str!="Mayan"

gen Pazani=1 if username_str=="Pazani"
replace Pazani=0 if username_str!="Pazani"

gen Rajalakschmi=1 if username_str=="Rajalakschmi"
replace Rajalakschmi=0 if username_str!="Rajalakschmi"

gen Suganya_and_Malarvizhi=1 if username_str=="Suganya-Malarvizhi"
replace Suganya_and_Malarvizhi=0 if username_str!="Suganya-Malarvizhi"

gen Vivek_Radja=1 if username_str=="Vivek Radja"
replace Vivek_Radja=0 if username_str!="Vivek Radja"

egen test=rowtotal(Chithra_and_Radhika Raichal Mayan Pazani Rajalakschmi Suganya_and_Malarvizhi Vivek_Radja)
tab test, m
drop username_str test

preserve
bysort householdid: gen n=_n
bysort householdid: egen nmax=max(n)
keep if nmax==2
list householdid startdate enddate submissiondate version parent_key, clean noobs
/*
We drop it later
*/
restore
global username_dummy Suganya_and_Malarvizhi Raichal Rajalakschmi Chithra_and_Radhika Mayan Pazani
***
rename householdid householdid2020
merge m:1 householdid2020 using "$directory\do_not_drop\unique_identifier_panel.dta", keepusing(villageid villageareaid dummynewHH dummydemonetisation caste HHID2010)
keep if _merge==3
drop _merge
save "$directory/CLEAN/NEEMSIS_Agriculture_APPEND.dta", replace

****************************************
* END














****************************************
* MERGING AGRI
****************************************
/*
We RESHAPE all long file and merge it with the master one
*/
clear all
use"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-equipmentowned.dta", clear
keep if equipmentnb!=.
destring equipmentid, replace
drop forauto setofequipmentowned key
reshape wide equipmentname equipmentnb equipementyear equipmentcost equipmentpledged, i(parent_key) j(equipmentid)
save"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-equipmentowned_WIDE.dta", replace

use"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-landgroup-products.dta", clear
keep if productacre!=.
destring productid, replace
drop productypeland_2 productypeland_1 productoriginlabourers_1 productoriginlabourers_2 productcastelabourers_1 productcastelabourers_2 productcastelabourers_16
drop key setofproducts productypeland_3 productcastelabourers_4 productcastelabourers_88
reshape wide productname productother productacre productypeland productunit productunitchoice productnbchoice productselfconsumption productnbchoicesold productpricesold productexpenses productpaidworkers productnbpaidworkers productlabourcost productunpaidworkers productnbunpaidworkers productnbhhmembers productoriginlabourers  productcastelabourers, i(parent_key) j(productid)
save"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-landgroup-products_WIDE.dta", replace

use"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-livestock.dta", clear
keep if livestocknb!=.
destring livestockid, replace
drop livestockuse_1 livestockuse_2 livestockuse_5 livestockuse_3 key setoflivestock livestockuse_6 livestockuse_4
reshape wide livestockname livestocknb livestockprice livestockuse, i(parent_key) j(livestockid)
save"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-livestock_WIDE.dta", replace

use"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-consumptionandassets-detailsgoods.dta", clear
keep if numbergoods!=.
destring goodid, replace
drop setofdetailsgoods key
reshape wide goodname numbergoods goodyearpurchased goodtotalamount goodbuying goodsourcecredit goodcreditsettled, i(parent_key) j(goodid)
save"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-consumptionandassets-detailsgoods_WIDE.dta", replace

use"$directory\CLEAN\NEEMSIS_Agriculture_APPEND.dta", clear
merge 1:1 parent_key using "$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-equipmentowned_WIDE.dta"
drop _merge
merge 1:1 parent_key using "$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-landgroup-products_WIDE.dta"
drop _merge
merge 1:1 parent_key using "$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-livestock_WIDE.dta"
drop _merge
merge 1:1 parent_key using "$directory\CLEAN\NEEMSIS_Agriculture_APPEND-consumptionandassets-detailsgoods_WIDE.dta"
drop _merge
drop setofproducts setoflivestock setofequipmentowned setofdetailsgoods

********** INTERMEDIATE CLEANING
erase"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-consumptionandassets-detailsgoods_WIDE.dta"
erase"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-livestock_WIDE.dta"
erase"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-landgroup-products_WIDE.dta"
erase"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-equipmentowned_WIDE.dta"

erase"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-consumptionandassets-detailsgoods.dta"
erase"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-livestock.dta"
erase"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-landgroup-products.dta"
erase"$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-equipmentowned.dta"


********** DROP DUPLICATES (AGREE WITH CECILE)
drop if householdid==67 & parent_key=="uuid:7e235580-30be-4dea-8982-68ed963b45c8"
drop if householdid==235 & parent_key=="uuid:ece23449-7f67-4de2-b7da-3ea48d4d33dd"
drop if householdid==246 & parent_key=="uuid:953d8941-5338-4a82-a5d7-2f6e25947e5d"
drop if householdid==343 & parent_key=="uuid:f52b0fb0-064b-4133-a78d-83edcd80b3e1"
drop if householdid==348 & parent_key=="uuid:08b045f7-ca13-429c-b25b-604ed8786a32"
drop if householdid==361 & parent_key=="uuid:332b0700-6bdb-4e66-92ee-7f1e892dae6a"
drop if householdid==391 & parent_key=="uuid:6854d50b-0b75-4b24-a3b8-ee031aa78668"

drop parent_key

save"$directory\CLEAN\NEEMSIS_Agriculture_APPEND_v2.dta", replace
****************************************
* END










****************************************
* MERGING AGRI WITH HH
****************************************
use"$directory\CLEAN\NEEMSIS2-HH_v6.dta", clear
*drop if preload2016==2
tostring castepreload2016, replace
rename version version_HH
merge m:1 householdid2020 using "$directory\CLEAN\NEEMSIS_Agriculture_APPEND_v2.dta"
rename _merge orga_HHagri
label define orga 1"HH only" 2"Agri only" 3"Both"
label values orga_HHagri orga
tab orga_HHagri
destring INDID, replace
destring INDID_new, replace
destring INDID_total, replace
destring INDID_former, replace
destring INDID_left, replace
rename version version_agri

erase"$directory\CLEAN\NEEMSIS_Agriculture_APPEND_v2.dta"
erase"$directory\CLEAN\NEEMSIS_Agriculture_APPEND.dta"

save"$directory\CLEAN\NEEMSIS2-HH_v7.dta", replace
****************************************
* END
