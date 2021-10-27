cls
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
*global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
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
rename adress address
sort version householdid2020 namenewhead
order householdid2020 address namenewhead version


save "$directory/CLEAN/NEEMSIS_Agriculture_APPEND.dta", replace


********** Faire matcher la base agri avec la base HH pour les nouveaux HH
preserve
use"$directory\CLEAN\NEEMSIS2-HH_v6.dta", clear
order HHID_panel householdid2020 version
destring householdid2020, replace
sort version householdid2020
gen HHname=name if relationshiptohead==1
sort HHID_panel
bysort HHID_panel (HHname) : replace HHname=HHname[_N] if missing(HHname)
duplicates drop parent_key, force
duplicates tag householdid2020, gen(tag)
tab tag
sort householdid2020 HHname
list householdid2020 HHID_panel HHname address tag if tag>1, clean noobs
restore


********** Ceux pour qui le merge fonctionne
use "$directory/CLEAN/NEEMSIS_Agriculture_APPEND.dta", clear
merge m:1 householdid2020 using "$directory\do_not_drop\unique_identifier_panel.dta", keepusing(villageid villageareaid dummynewHH dummydemonetisation caste HHID2010 HHID_panel)
sort _merge
drop if _merge==1
save "$directory/CLEAN/NEEMSIS_Agriculture_APPEND_merge23.dta", replace



********** Les nouveaux ménages pour lesquels le merge ne fonctionne pas car ils ont le même householid2020
use "$directory/CLEAN/NEEMSIS_Agriculture_APPEND.dta", clear
merge m:1 householdid2020 using "$directory\do_not_drop\unique_identifier_panel.dta", keepusing(villageid villageareaid dummynewHH dummydemonetisation caste HHID2010 HHID_panel)
sort _merge
keep if _merge==1
sort householdid2020 namenewhead
order householdid2020 HHID_panel namenewhead address
gen attention=0

replace HHID_panel="ELA55" if householdid2020==530 & namenewhead=="Asaimani"
replace HHID_panel="ELA63" if householdid2020==530 & namenewhead=="Balu"
replace HHID_panel="ELA54" if householdid2020==530 & namenewhead=="Kannan"
replace HHID_panel="ELA58" if householdid2020==530 & namenewhead=="Silambarasi"
replace HHID_panel="ELA56" if householdid2020==530 & namenewhead=="Sobana"
replace HHID_panel="ELA60" if householdid2020==530 & namenewhead=="Theiveegam"
replace HHID_panel="ELA65" if householdid2020==530 & namenewhead=="Velu"
replace HHID_panel="ELA57" if householdid2020==531 & namenewhead=="Bremsheela"
replace attention=1 if householdid2020==531 & namenewhead=="Bremsheela"
replace HHID_panel="ELA59" if householdid2020==531 & namenewhead=="Kamalavalli"
replace HHID_panel="ELA62" if householdid2020==531 & namenewhead=="Murugadass"
replace HHID_panel="ELA64" if householdid2020==531 & namenewhead=="Pachaiyappan"
replace HHID_panel="ELA61" if householdid2020==531 & namenewhead=="Padmavathi"
replace HHID_panel="ELA53" if householdid2020==531 & namenewhead=="Raji"
replace HHID_panel="GOV54" if householdid2020==532 & namenewhead=="Amutha"
replace HHID_panel="GOV60" if householdid2020==532 & namenewhead=="Anusuya"
replace HHID_panel="GOV55" if householdid2020==532 & namenewhead=="Duraimurugan"
replace HHID_panel="GOV62" if householdid2020==532 & namenewhead=="Ezhumalai"
replace HHID_panel="GOV57" if householdid2020==532 & namenewhead=="Inbaraja"
replace HHID_panel="GOV64" if householdid2020==532 & namenewhead=="Kumar"
replace HHID_panel="GOV63" if householdid2020==532 & namenewhead=="Manikandan"
replace HHID_panel="GOV58" if householdid2020==532 & namenewhead=="Murugadass"
replace HHID_panel="GOV56" if householdid2020==532 & namenewhead=="Murugavel"
replace HHID_panel="GOV53" if householdid2020==532 & namenewhead=="Pannerselvam"
replace HHID_panel="GOV59" if householdid2020==532 & namenewhead=="Sakthivel"
replace attention=1 if householdid2020==532 & namenewhead=="Sakthivel"
replace HHID_panel="KAR62" if householdid2020==534 & namenewhead=="Kanadhasan"
replace HHID_panel="KAR66" if householdid2020==534 & namenewhead=="Karthikeyan"
replace HHID_panel="KAR51" if householdid2020==534 & namenewhead=="Karunanidhi" & address=="Mariyamman Kovil street, karumbur colony"
replace HHID_panel="KAR59" if householdid2020==534 & namenewhead=="Karunanidhi" & address=="Maariyamman koil street"
replace HHID_panel="KAR52" if householdid2020==534 & namenewhead=="Keerthika"
replace HHID_panel="KAR56" if householdid2020==534 & namenewhead=="Muralidharan"
replace HHID_panel="KAR60" if householdid2020==534 & namenewhead=="Nagappan"
replace HHID_panel="KAR61" if householdid2020==534 & namenewhead=="Radhakrishnan"
replace HHID_panel="KAR65" if householdid2020==534 & namenewhead=="Vengatesan"
replace HHID_panel="KAR55" if householdid2020==535 & namenewhead=="Ananthan"
replace HHID_panel="KAR54" if householdid2020==535 & namenewhead=="Jayan"
replace HHID_panel="KAR53" if householdid2020==535 & namenewhead=="Manimuthu"
replace HHID_panel="KAR64" if householdid2020==535 & namenewhead=="Nirmal Kumar"
replace HHID_panel="KAR63" if householdid2020==535 & namenewhead=="Pazhani"
replace HHID_panel="KAR58" if householdid2020==535 & namenewhead=="Senthilmurugan"
replace HHID_panel="KAR57" if householdid2020==535 & namenewhead=="Thirumalai"
replace HHID_panel="KOR46" if householdid2020==536 & namenewhead=="Arumugam"
replace HHID_panel="KOR47" if householdid2020==536 & namenewhead=="Jenifer"
replace HHID_panel="KOR56" if householdid2020==536 & namenewhead=="Kuppu"
replace HHID_panel="KOR53" if householdid2020==536 & namenewhead=="Rajagopal"
replace HHID_panel="KOR54" if householdid2020==536 & namenewhead=="S.Murugan"
replace HHID_panel="KOR57" if householdid2020==536 & namenewhead=="Thenaruvi"
replace HHID_panel="KOR55" if householdid2020==537 & namenewhead=="Anandthavalli"
replace HHID_panel="KOR51" if householdid2020==537 & namenewhead=="Jayapriya"
replace HHID_panel="KOR49" if householdid2020==537 & namenewhead=="Kesavan"
replace HHID_panel="KOR52" if householdid2020==537 & namenewhead=="Mangayarkarasi"
replace HHID_panel="KOR48" if householdid2020==537 & namenewhead=="Ravichandran"
replace HHID_panel="KOR50" if householdid2020==537 & namenewhead=="Shanthy"
replace HHID_panel="KUV57" if householdid2020==538 & namenewhead=="Ananthi"
replace HHID_panel="KUV61" if householdid2020==538 & namenewhead=="Arumugam"
replace HHID_panel="KUV63" if householdid2020==538 & namenewhead=="Koothaiyan"
replace HHID_panel="KUV55" if householdid2020==538 & namenewhead=="Krishnan"
replace HHID_panel="KUV65" if householdid2020==538 & namenewhead=="Raja"
replace HHID_panel="KUV54" if householdid2020==538 & namenewhead=="Settu"
replace HHID_panel="KUV59" if householdid2020==538 & namenewhead=="Shalini"
replace HHID_panel="KUV60" if householdid2020==539 & namenewhead=="Athilakshmi"
replace HHID_panel="KUV58" if householdid2020==539 & namenewhead=="Ganesan"
replace HHID_panel="KUV56" if householdid2020==539 & namenewhead=="Jayaraman"
replace HHID_panel="KUV64" if householdid2020==539 & namenewhead=="Paranthaman"
replace HHID_panel="KUV62" if householdid2020==539 & namenewhead=="Tamizselvi"
replace HHID_panel="KUV53" if householdid2020==539 & namenewhead=="Venkatesan"
replace HHID_panel="MAN69" if householdid2020==540 & namenewhead=="Bhoominathan"
replace HHID_panel="MAN68" if householdid2020==540 & namenewhead=="Gayathri"
replace HHID_panel="MAN65" if householdid2020==540 & namenewhead=="Govinthan"
replace HHID_panel="MAN64" if householdid2020==540 & namenewhead=="Nirmala"
replace HHID_panel="MAN57" if householdid2020==540 & namenewhead=="Nithiya"
replace HHID_panel="MAN59" if householdid2020==540 & namenewhead=="Panjavarnam"
replace HHID_panel="MAN58" if householdid2020==540 & namenewhead=="Priya"
replace HHID_panel="MAN62" if householdid2020==540 & namenewhead=="Ramesh"
replace HHID_panel="MAN61" if householdid2020==540 & namenewhead=="Senthamizhan"
replace HHID_panel="MAN63" if householdid2020==540 & namenewhead=="Suganya"
replace HHID_panel="MAN56" if householdid2020==540 & namenewhead=="Vadivel"
replace HHID_panel="MAN66" if householdid2020==541 & namenewhead=="Arumugam"
replace HHID_panel="MAN67" if householdid2020==541 & namenewhead=="Dhurai"
replace HHID_panel="MAN54" if householdid2020==541 & namenewhead=="Jayaprakash"
replace HHID_panel="MAN53" if householdid2020==541 & namenewhead=="Kalaiyarasi"
replace HHID_panel="MAN60" if householdid2020==541 & namenewhead=="Kalpana"
replace HHID_panel="MAN55" if householdid2020==541 & namenewhead=="Sekar"
replace HHID_panel="MANAM55" if householdid2020==542 & namenewhead=="Dayal"
replace HHID_panel="MANAM54" if householdid2020==542 & namenewhead=="Gomathi"
replace HHID_panel="MANAM59" if householdid2020==542 & namenewhead=="Indhumathi"
replace HHID_panel="MANAM52" if householdid2020==542 & namenewhead=="Kalaiselvan"
replace HHID_panel="MANAM56" if householdid2020==542 & namenewhead=="Poomadevi"
replace HHID_panel="MANAM62" if householdid2020==543 & namenewhead=="Datchnamoorthy"
replace HHID_panel="MANAM58" if householdid2020==543 & namenewhead=="Janagiraman @arul"
replace HHID_panel="MANAM53" if householdid2020==543 & namenewhead=="Kaliyaperumal"
replace HHID_panel="MANAM60" if householdid2020==543 & namenewhead=="Narasingaperumal"
replace HHID_panel="MANAM64" if householdid2020==543 & namenewhead=="Porkalai"
replace HHID_panel="MANAM63" if householdid2020==543 & namenewhead=="Prakash"
replace HHID_panel="MANAM61" if householdid2020==543 & namenewhead=="Rajasekar"
replace HHID_panel="MANAM57" if householdid2020==543 & namenewhead=="Sivakozhundhu"
replace HHID_panel="NAT63" if householdid2020==544 & namenewhead=="Gopi"
replace HHID_panel="NAT58" if householdid2020==544 & namenewhead=="Gunasundari"
replace HHID_panel="NAT56" if householdid2020==544 & namenewhead=="Perumal"
replace HHID_panel="NAT61" if householdid2020==544 & namenewhead=="Praba"
replace HHID_panel="NAT62" if householdid2020==544 & namenewhead=="Singaravelu"
replace HHID_panel="NAT59" if householdid2020==544 & namenewhead=="Thamizhselvi"
replace HHID_panel="NAT52" if householdid2020==545 & namenewhead=="Devi"
replace HHID_panel="NAT53" if householdid2020==545 & namenewhead=="Kasinathan"
replace HHID_panel="NAT54" if householdid2020==545 & namenewhead=="Lakshmi Narayan"
replace HHID_panel="NAT55" if householdid2020==545 & namenewhead=="Osaimani"
replace HHID_panel="NAT57" if householdid2020==545 & namenewhead=="Revathi"
replace HHID_panel="NAT60" if householdid2020==545 & namenewhead=="Saranya"
replace HHID_panel="ORA54" if householdid2020==546 & namenewhead=="Arunpandi"
replace HHID_panel="ORA65" if householdid2020==546 & namenewhead=="Buvaneshwari"
replace HHID_panel="ORA70" if householdid2020==546 & namenewhead=="Gopalakrishnan"
replace HHID_panel="ORA59" if householdid2020==546 & namenewhead=="Manikandan"
replace HHID_panel="ORA56" if householdid2020==546 & namenewhead=="Maruthavel"
replace HHID_panel="ORA57" if householdid2020==546 & namenewhead=="Pichaikaran"
replace HHID_panel="ORA68" if householdid2020==546 & namenewhead=="Priya@Banupriya"
replace HHID_panel="ORA53" if householdid2020==546 & namenewhead=="Shakthivel"
replace HHID_panel="ORA60" if householdid2020==546 & namenewhead=="Thandapani"
replace HHID_panel="ORA69" if householdid2020==546 & namenewhead=="Thangadurai"
replace HHID_panel="ORA55" if householdid2020==547 & namenewhead=="Arulnadhan"
replace HHID_panel="ORA61" if householdid2020==547 & namenewhead=="Dhanapal"
replace HHID_panel="ORA67" if householdid2020==547 & namenewhead=="Gajendiran"
replace HHID_panel="ORA66" if householdid2020==547 & namenewhead=="Kandhan"
replace HHID_panel="ORA63" if householdid2020==547 & namenewhead=="Kumar"
replace HHID_panel="ORA58" if householdid2020==547 & namenewhead=="Surya"
replace HHID_panel="ORA62" if householdid2020==547 & namenewhead=="Thanush"
replace HHID_panel="ORA64" if householdid2020==547 & namenewhead=="Vijayakumar"
replace HHID_panel="SEM65" if householdid2020==548 & namenewhead=="Ezhilvani"
replace HHID_panel="SEM60" if householdid2020==548 & namenewhead=="Marimuthu"
replace HHID_panel="SEM53" if householdid2020==548 & namenewhead=="Parimala"
replace HHID_panel="SEM56" if householdid2020==548 & namenewhead=="Pichaiammal"
replace HHID_panel="SEM55" if householdid2020==548 & namenewhead=="Sasireka"
replace HHID_panel="SEM57" if householdid2020==548 & namenewhead=="Vishvanathan"
replace HHID_panel="SEM62" if householdid2020==549 & namenewhead=="Beer Mohammed"
replace HHID_panel="SEM54" if householdid2020==549 & namenewhead=="Jasmine roja"
replace HHID_panel="SEM59" if householdid2020==549 & namenewhead=="Krishnamoorthy"
replace HHID_panel="SEM63" if householdid2020==549 & namenewhead=="Mathina begam"
replace HHID_panel="SEM61" if householdid2020==549 & namenewhead=="Paranthaman"
replace HHID_panel="SEM64" if householdid2020==549 & namenewhead=="Sankar"
replace HHID_panel="SEM58" if householdid2020==549 & namenewhead=="Valarmathi"

save "$directory/CLEAN/NEEMSIS_Agriculture_APPEND_merge1.dta", replace


********** APPEND les 2
use"$directory/CLEAN/NEEMSIS_Agriculture_APPEND_merge1.dta", clear
append using "$directory/CLEAN/NEEMSIS_Agriculture_APPEND_merge23.dta"


*** Cleaning 
rename _merge merge_HHID
label define modif 1"Manually recoded" 2"Only HH" 3"Merging ok"
label values merge_HHID modif


*** Verif parent_key HHID_panel
order HHID_panel parent_key
sort HHID_panel


save"$directory/CLEAN/NEEMSIS_Agriculture_APPEND_v2", replace
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
drop key setofproducts productypeland_3 productcastelabourers_4 productcastelabourers_88 productcastelabourers_12 productcastelabourers_6
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

use"$directory\CLEAN\NEEMSIS_Agriculture_APPEND_v2.dta", clear
merge m:1 parent_key using "$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-equipmentowned_WIDE.dta"
drop _merge
merge m:1 parent_key using "$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-landgroup-products_WIDE.dta"
drop _merge
merge m:1 parent_key using "$directory\CLEAN\NEEMSIS_Agriculture_APPEND-agriculture-livestock_WIDE.dta"
drop _merge
merge m:1 parent_key using "$directory\CLEAN\NEEMSIS_Agriculture_APPEND-consumptionandassets-detailsgoods_WIDE.dta"
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
drop if householdid==36 & parent_key=="uuid:244d058e-b68a-4271-bf5f-5332dca88f8f"

foreach x in geopointlatitude geopointlongitude geopointaltitude geopointaccuracy villagename villagearea parent_key address {
rename `x' `x'_BaseAgri
}

sort householdid2020
order householdid2020 namenewhead version
sort version
drop if version==""

save"$directory\CLEAN\NEEMSIS_Agriculture_APPEND_v3.dta", replace
****************************************
* END










****************************************
* MERGING AGRI WITH HH
****************************************
use"$directory\CLEAN\NEEMSIS2-HH_v6.dta", clear
tab version

*drop if preload2016==2
tostring castepreload2016, replace
rename version version_HH
merge m:1 HHID_panel using "$directory\CLEAN\NEEMSIS_Agriculture_APPEND_v3.dta"
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

*erase"$directory\CLEAN\NEEMSIS_Agriculture_APPEND_v2.dta"
*erase"$directory\CLEAN\NEEMSIS_Agriculture_APPEND.dta"

save"$directory\CLEAN\NEEMSIS2-HH_v7.dta", replace
****************************************
* END
