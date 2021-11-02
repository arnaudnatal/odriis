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
global git = "C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"
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
	*** Duplicates
	drop if parent_key=="uuid:244d058e-b68a-4271-bf5f-5332dca88f8f"  // householdid==36
	drop if parent_key=="uuid:7e235580-30be-4dea-8982-68ed963b45c8"  // householdid==67
	drop if parent_key=="uuid:ece23449-7f67-4de2-b7da-3ea48d4d33dd"  // householdid==235
	drop if parent_key=="uuid:953d8941-5338-4a82-a5d7-2f6e25947e5d"  // householdid==246
	drop if parent_key=="uuid:f52b0fb0-064b-4133-a78d-83edcd80b3e1"  // householdid==343
	drop if parent_key=="uuid:08b045f7-ca13-429c-b25b-604ed8786a32"  // householdid==348
	drop if parent_key=="uuid:332b0700-6bdb-4e66-92ee-7f1e892dae6a"  // householdid==361
	drop if parent_key=="uuid:6854d50b-0b75-4b24-a3b8-ee031aa78668"  // householdid==391
	*
	drop if parent_key=="uuid:f98d6d16-e1cb-4504-8475-9414a295c014"  // householdid==534
	drop if parent_key=="uuid:0c5b2989-3bf7-49db-b6e4-ab455dfee7fe"  // householdid==547 (duplicates with "uuid:211fcb9c-19d7-4e89-9285-488a1a6588be")
	
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
do "$git\_Miscellaneous\Datachoicelist_NEEMSIS2\NEEMSIS2-Label"
save "$directory\CLEAN\NEEMSIS_Agriculture_APPEND`k'", replace
}




********** APPEND MASTER FILE
use "$directory\agri_raw\new-_NEEMSIS2_Agriculture.dta", clear
append using "$directory\agri_raw\new-_NEEMSIS2_DECEMBER_Agriculture.dta", force
append using "$directory\agri_raw\new-_NEEMSIS2_DEC_Agriculture.dta", force
append using "$directory\agri_raw\new-_NEEMSIS2_FEB_NEW_Agriculture.dta", force
append using "$directory\agri_raw\new-_NEEMSIS2_FEBRUARY_Agriculture.dta", force
do "$git\_Miscellaneous\Datachoicelist_NEEMSIS2\NEEMSIS2-Label"




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
use"$directory\CLEAN\NEEMSIS2-HH_v6.dta", clear
order HHID_panel householdid2020 version
destring householdid2020, replace
sort householdid2020 HHID_panel name

preserve
keep if householdid2020==542
keep HHID_panel householdid2020 parent_key name INDID relationshiptohead
restore

preserve
keep if householdid2020==532
keep HHID_panel householdid2020 parent_key name INDID relationshiptohead
restore

gen HHname=name if relationshiptohead==1
sort HHID_panel
bysort HHID_panel (HHname) : replace HHname=HHname[_N] if missing(HHname)
duplicates drop parent_key, force
duplicates tag householdid2020, gen(tag)
tab tag
sort householdid2020 HHname
list householdid2020 HHID_panel HHname address tag if tag>1, clean noobs


********** Ceux pour qui le merge fonctionne
use "$directory/CLEAN/NEEMSIS_Agriculture_APPEND.dta", clear
ta version
sort householdid2020 namenewhead
keep if householdid2020<530
duplicates tag householdid2020, gen(tag)
ta tag
sort tag householdid2020 submissiondate
order tag householdid2020 submissiondate version parent_key namenewhead
	*** Duplicates
	drop if parent_key=="uuid:244d058e-b68a-4271-bf5f-5332dca88f8f"  // householdid==36
	drop if parent_key=="uuid:7e235580-30be-4dea-8982-68ed963b45c8"  // householdid==67
	drop if parent_key=="uuid:ece23449-7f67-4de2-b7da-3ea48d4d33dd"  // householdid==235
	drop if parent_key=="uuid:953d8941-5338-4a82-a5d7-2f6e25947e5d"  // householdid==246
	drop if parent_key=="uuid:f52b0fb0-064b-4133-a78d-83edcd80b3e1"  // householdid==343
	drop if parent_key=="uuid:08b045f7-ca13-429c-b25b-604ed8786a32"  // householdid==348
	drop if parent_key=="uuid:332b0700-6bdb-4e66-92ee-7f1e892dae6a"  // householdid==361
	drop if parent_key=="uuid:6854d50b-0b75-4b24-a3b8-ee031aa78668"  // householdid==391
	*
	drop if parent_key=="uuid:f98d6d16-e1cb-4504-8475-9414a295c014"  // householdid==534
	drop if parent_key=="uuid:0c5b2989-3bf7-49db-b6e4-ab455dfee7fe"  // householdid==547 (duplicates with "uuid:211fcb9c-19d7-4e89-9285-488a1a6588be")
	
drop tag
duplicates report householdid2020
*
merge m:1 householdid2020 using "$git\_Miscellaneous\Individual_panel\unique_identifier_panel.dta", keepusing(villageid villageareaid dummynewHH dummydemonetisation caste HHID2010 HHID_panel)
sort _merge
keep if _merge==3
save "$directory/CLEAN/NEEMSIS_Agriculture_APPEND_merge23.dta", replace



********** Les nouveaux ménages pour lesquels le merge ne fonctionne pas car ils ont le même householid2020
use "$directory/CLEAN/NEEMSIS_Agriculture_APPEND.dta", clear
ta version
sort namenewhead
keep if householdid2020>=530
sort householdid2020 submissiondate
order householdid2020 namenewhead submissiondate version namenewhead
sort householdid2020 namenewhead
gen HHID_panel=""
order householdid2020 HHID_panel namenewhead address submissiondate
	*** Duplicates
	drop if parent_key=="uuid:244d058e-b68a-4271-bf5f-5332dca88f8f"  // householdid==36
	drop if parent_key=="uuid:7e235580-30be-4dea-8982-68ed963b45c8"  // householdid==67
	drop if parent_key=="uuid:ece23449-7f67-4de2-b7da-3ea48d4d33dd"  // householdid==235
	drop if parent_key=="uuid:953d8941-5338-4a82-a5d7-2f6e25947e5d"  // householdid==246
	drop if parent_key=="uuid:f52b0fb0-064b-4133-a78d-83edcd80b3e1"  // householdid==343
	drop if parent_key=="uuid:08b045f7-ca13-429c-b25b-604ed8786a32"  // householdid==348
	drop if parent_key=="uuid:332b0700-6bdb-4e66-92ee-7f1e892dae6a"  // householdid==361
	drop if parent_key=="uuid:6854d50b-0b75-4b24-a3b8-ee031aa78668"  // householdid==391
	*
	drop if parent_key=="uuid:f98d6d16-e1cb-4504-8475-9414a295c014"  // householdid==534
	drop if parent_key=="uuid:0c5b2989-3bf7-49db-b6e4-ab455dfee7fe"  // householdid==547 (duplicates with "uuid:211fcb9c-19d7-4e89-9285-488a1a6588be")

replace HHID_panel="ELA55" if householdid2020==530 & namenewhead=="Asaimani"  // Krishnaraj
replace HHID_panel="ELA63" if householdid2020==530 & namenewhead=="Balu"  // OK
replace HHID_panel="ELA54" if householdid2020==530 & namenewhead=="Kannan"  // OK
replace HHID_panel="ELA58" if householdid2020==530 & namenewhead=="Silambarasi"  // Saravanan
replace HHID_panel="ELA56" if householdid2020==530 & namenewhead=="Sobana"  // Ravichandran
replace HHID_panel="ELA60" if householdid2020==530 & namenewhead=="Theiveegam"  // Sathiyamoorthy
replace HHID_panel="ELA65" if householdid2020==530 & namenewhead=="Velu"  // OK
replace HHID_panel="ELA57" if householdid2020==531 & namenewhead=="Bremsheela"  // Pb car réside à Gucfuccu
replace HHID_panel="ELA59" if householdid2020==531 & namenewhead=="Kamalavalli"  // OK
replace HHID_panel="ELA62" if householdid2020==531 & namenewhead=="Murugadass"  // OK
replace HHID_panel="ELA64" if householdid2020==531 & namenewhead=="Pachaiyappan"  // OK
replace HHID_panel="ELA61" if householdid2020==531 & namenewhead=="Padmavathi"  // OK
replace HHID_panel="ELA53" if householdid2020==531 & namenewhead=="Raji"  // OK
replace HHID_panel="GOV54" if householdid2020==532 & namenewhead=="Amutha"  // Babu
replace HHID_panel="GOV60" if householdid2020==532 & namenewhead=="Anusuya"  // Raguraman
replace HHID_panel="GOV55" if householdid2020==532 & namenewhead=="Duraimurugan"  // OK
replace HHID_panel="GOV61" if householdid2020==532 & namenewhead=="Ezhumalai"  // OK
replace HHID_panel="GOV57" if householdid2020==532 & namenewhead=="Inbaraja"  // OK
replace HHID_panel="GOV63" if householdid2020==532 & namenewhead=="Kumar"  // OK
replace HHID_panel="GOV62" if householdid2020==532 & namenewhead=="Manikandan"  // OK
replace HHID_panel="GOV58" if householdid2020==532 & namenewhead=="Murugadass"  // OK
replace HHID_panel="GOV56" if householdid2020==532 & namenewhead=="Murugavel"  // OK
replace HHID_panel="GOV53" if householdid2020==532 & namenewhead=="Pannerselvam"  // OK
replace HHID_panel="GOV59" if householdid2020==532 & namenewhead=="Sakthivel"  // OK
replace HHID_panel="KAR61" if householdid2020==534 & namenewhead=="Kanadhasan"  // "Only blank"
replace HHID_panel="KAR65" if householdid2020==534 & namenewhead=="Karthikeyan"  // OK
replace HHID_panel="KAR51" if householdid2020==534 & namenewhead=="Karunanidhi"  // OK
replace HHID_panel="KAR52" if householdid2020==534 & namenewhead=="Keerthika"  // Pandydurai
replace HHID_panel="KAR56" if householdid2020==534 & namenewhead=="Muralidharan"  // OK
replace HHID_panel="KAR59" if householdid2020==534 & namenewhead=="Nagappan"  // OK
replace HHID_panel="KAR60" if householdid2020==534 & namenewhead=="Radhakrishnan"  // OK
replace HHID_panel="KAR64" if householdid2020==534 & namenewhead=="Vengatesan"  // OK
replace HHID_panel="KAR55" if householdid2020==535 & namenewhead=="Ananthan"  // Anandan
replace HHID_panel="KAR54" if householdid2020==535 & namenewhead=="Jayan"  // OK
replace HHID_panel="KAR53" if householdid2020==535 & namenewhead=="Manimuthu"  // OK
replace HHID_panel="KAR63" if householdid2020==535 & namenewhead=="Nirmal Kumar"  // OK
replace HHID_panel="KAR62" if householdid2020==535 & namenewhead=="Pazhani"  // OK
replace HHID_panel="KAR58" if householdid2020==535 & namenewhead=="Senthilmurugan"  // OK
replace HHID_panel="KAR57" if householdid2020==535 & namenewhead=="Thirumalai"  // OK
replace HHID_panel="KOR46" if householdid2020==536 & namenewhead=="Arumugam"  // OK
replace HHID_panel="KOR47" if householdid2020==536 & namenewhead=="Jenifer"  // OK
replace HHID_panel="KOR56" if householdid2020==536 & namenewhead=="Kuppu"  // OK
replace HHID_panel="KOR53" if householdid2020==536 & namenewhead=="Rajagopal"  // OK
replace HHID_panel="KOR54" if householdid2020==536 & namenewhead=="S.Murugan"  // OK
replace HHID_panel="KOR57" if householdid2020==536 & namenewhead=="Thenaruvi"  // OK
replace HHID_panel="KOR55" if householdid2020==537 & namenewhead=="Anandthavalli"  // Sampath
replace HHID_panel="KOR51" if householdid2020==537 & namenewhead=="Jayapriya"  // Dinesh
replace HHID_panel="KOR49" if householdid2020==537 & namenewhead=="Kesavan"  // OK
replace HHID_panel="KOR52" if householdid2020==537 & namenewhead=="Mangayarkarasi"  // Narayanan
replace HHID_panel="KOR48" if householdid2020==537 & namenewhead=="Ravichandran"  // OK
replace HHID_panel="KOR50" if householdid2020==537 & namenewhead=="Shanthy"  // OK
replace HHID_panel="KUV57" if householdid2020==538 & namenewhead=="Ananthi"  // OK
replace HHID_panel="KUV61" if householdid2020==538 & namenewhead=="Arumugam"  // OK
replace HHID_panel="KUV63" if householdid2020==538 & namenewhead=="Koothaiyan"  // OK
replace HHID_panel="KUV55" if householdid2020==538 & namenewhead=="Krishnan"  // OK
replace HHID_panel="KUV65" if householdid2020==538 & namenewhead=="Raja"  // OK
replace HHID_panel="KUV54" if householdid2020==538 & namenewhead=="Settu"  // OK
replace HHID_panel="KUV59" if householdid2020==538 & namenewhead=="Shalini"  // Koothan
replace HHID_panel="KUV60" if householdid2020==539 & namenewhead=="Athilakshmi"  // Kannan
replace HHID_panel="KUV58" if householdid2020==539 & namenewhead=="Ganesan"  // OK
replace HHID_panel="KUV56" if householdid2020==539 & namenewhead=="Jayaraman"  // OK
replace HHID_panel="KUV64" if householdid2020==539 & namenewhead=="Paranthaman"  // OK
replace HHID_panel="KUV62" if householdid2020==539 & namenewhead=="Tamizselvi"  // OK
replace HHID_panel="KUV53" if householdid2020==539 & namenewhead=="Venkatesan"  // Manikandan
replace HHID_panel="MAN69" if householdid2020==540 & namenewhead=="Bhoominathan"  // OK
replace HHID_panel="MAN68" if householdid2020==540 & namenewhead=="Gayathri"  // OK
replace HHID_panel="MAN65" if householdid2020==540 & namenewhead=="Govinthan"  // OK
replace HHID_panel="MAN64" if householdid2020==540 & namenewhead=="Nirmala"  // OK
replace HHID_panel="MAN57" if householdid2020==540 & namenewhead=="Nithiya"  // Ramesh
replace HHID_panel="MAN59" if householdid2020==540 & namenewhead=="Panjavarnam"  // OK
replace HHID_panel="MAN58" if householdid2020==540 & namenewhead=="Priya"  // Suthakar
replace HHID_panel="MAN62" if householdid2020==540 & namenewhead=="Ramesh"  // OK
replace HHID_panel="MAN61" if householdid2020==540 & namenewhead=="Senthamizhan"  // OK
replace HHID_panel="MAN63" if householdid2020==540 & namenewhead=="Suganya"  // Supash
replace HHID_panel="MAN56" if householdid2020==540 & namenewhead=="Vadivel"  // OK
replace HHID_panel="MAN66" if householdid2020==541 & namenewhead=="Arumugam"  // OK
replace HHID_panel="MAN67" if householdid2020==541 & namenewhead=="Dhurai"  // OK
replace HHID_panel="MAN54" if householdid2020==541 & namenewhead=="Jayaprakash"  // OK
replace HHID_panel="MAN53" if householdid2020==541 & namenewhead=="Kalaiyarasi"  // Silambarasan
replace HHID_panel="MAN60" if householdid2020==541 & namenewhead=="Kalpana"  // OK
replace HHID_panel="MAN55" if householdid2020==541 & namenewhead=="Sekar"  // OK
replace HHID_panel="MANAM55" if householdid2020==542 & namenewhead=="Dayal"  // OK
replace HHID_panel="MANAM54" if householdid2020==542 & namenewhead=="Gomathi"  // Sakkarapani
replace HHID_panel="MANAM59" if householdid2020==542 & namenewhead=="Indhumathi"  // Mani
replace HHID_panel="MANAM52" if householdid2020==542 & namenewhead=="Kalaiselvan"  // OK
replace HHID_panel="MANAM56" if householdid2020==542 & namenewhead=="Poomadevi"  // OK
replace HHID_panel="MANAM63" if householdid2020==542 & namenewhead=="Ravi"  // OK
replace HHID_panel="MANAM62" if householdid2020==543 & namenewhead=="Datchnamoorthy"  // OK
replace HHID_panel="MANAM58" if householdid2020==543 & namenewhead=="Janagiraman @arul"  // OK
replace HHID_panel="MANAM53" if householdid2020==543 & namenewhead=="Kaliyaperumal"  // OK
replace HHID_panel="MANAM60" if householdid2020==543 & namenewhead=="Narasingaperumal"  // OK
replace HHID_panel="MANAM65" if householdid2020==543 & namenewhead=="Porkalai"  // OK
replace HHID_panel="MANAM64" if householdid2020==543 & namenewhead=="Prakash"  // OK
replace HHID_panel="MANAM61" if householdid2020==543 & namenewhead=="Rajasekar"  // OK
replace HHID_panel="MANAM57" if householdid2020==543 & namenewhead=="Sivakozhundhu"  // OK
replace HHID_panel="NAT63" if householdid2020==544 & namenewhead=="Gopi"  // OK
replace HHID_panel="NAT58" if householdid2020==544 & namenewhead=="Gunasundari"  // OK
replace HHID_panel="NAT56" if householdid2020==544 & namenewhead=="Perumal"  // OK
replace HHID_panel="NAT61" if householdid2020==544 & namenewhead=="Praba"  // Sarankumar
replace HHID_panel="NAT62" if householdid2020==544 & namenewhead=="Singaravelu"  // OK
replace HHID_panel="NAT59" if householdid2020==544 & namenewhead=="Thamizhselvi"  // Chandran
replace HHID_panel="NAT52" if householdid2020==545 & namenewhead=="Devi"  // OK
replace HHID_panel="NAT53" if householdid2020==545 & namenewhead=="Kasinathan"  // OK
replace HHID_panel="NAT54" if householdid2020==545 & namenewhead=="Lakshmi Narayan"  // OK
replace HHID_panel="NAT55" if householdid2020==545 & namenewhead=="Osaimani"  // OK
replace HHID_panel="NAT57" if householdid2020==545 & namenewhead=="Revathi"  // Devaraj
replace HHID_panel="NAT60" if householdid2020==545 & namenewhead=="Saranya"  // Shanti
replace HHID_panel="ORA54" if householdid2020==546 & namenewhead=="Arunpandi"  // OK
replace HHID_panel="ORA64" if householdid2020==546 & namenewhead=="Buvaneshwari"  // Perumal
replace HHID_panel="ORA69" if householdid2020==546 & namenewhead=="Gopalakrishnan"  // OK
replace HHID_panel="ORA58" if householdid2020==546 & namenewhead=="Manikandan"  // OK
replace HHID_panel="ORA56" if householdid2020==546 & namenewhead=="Maruthavel"  // OK
replace HHID_panel="ORA57" if householdid2020==546 & namenewhead=="Pichaikaran"  // OK
replace HHID_panel="ORA67" if householdid2020==546 & namenewhead=="Priya@Banupriya"  // Kamalraj
replace HHID_panel="ORA53" if householdid2020==546 & namenewhead=="Shakthivel"  // OK
replace HHID_panel="ORA59" if householdid2020==546 & namenewhead=="Thandapani"  // OK
replace HHID_panel="ORA68" if householdid2020==546 & namenewhead=="Thangadurai"  // OK
replace HHID_panel="ORA55" if householdid2020==547 & namenewhead=="Arulnadhan"  // OK
replace HHID_panel="ORA60" if householdid2020==547 & namenewhead=="Dhanapal"  // OK
replace HHID_panel="ORA66" if householdid2020==547 & namenewhead=="Gajendiran"  // OK
replace HHID_panel="ORA65" if householdid2020==547 & namenewhead=="Kandhan"  // OK
replace HHID_panel="ORA62" if householdid2020==547 & namenewhead=="Kumar"  // OK
replace HHID_panel="ORA61" if householdid2020==547 & namenewhead=="Thanush"  // OK
replace HHID_panel="ORA63" if householdid2020==547 & namenewhead=="Vijayakumar"  // OK
replace HHID_panel="SEM65" if householdid2020==548 & namenewhead=="Ezhilvani"  // OK
replace HHID_panel="SEM60" if householdid2020==548 & namenewhead=="Marimuthu"  // OK
replace HHID_panel="SEM53" if householdid2020==548 & namenewhead=="Parimala"  // OK
replace HHID_panel="SEM56" if householdid2020==548 & namenewhead=="Pichaiammal"  // OK
replace HHID_panel="SEM55" if householdid2020==548 & namenewhead=="Sasireka"  // Manivelu
replace HHID_panel="SEM57" if householdid2020==548 & namenewhead=="Vishvanathan"  // OK
replace HHID_panel="SEM62" if householdid2020==549 & namenewhead=="Beer Mohammed"  // OK
replace HHID_panel="SEM54" if householdid2020==549 & namenewhead=="Jasmine roja"  // Bakrudeen
replace HHID_panel="SEM59" if householdid2020==549 & namenewhead=="Krishnamoorthy"  // OK
replace HHID_panel="SEM63" if householdid2020==549 & namenewhead=="Mathina begam"  // OK
replace HHID_panel="SEM61" if householdid2020==549 & namenewhead=="Paranthaman"  // OK
replace HHID_panel="SEM64" if householdid2020==549 & namenewhead=="Sankar"  // OK
replace HHID_panel="SEM58" if householdid2020==549 & namenewhead=="Valarmathi"  // OK

*** Checkup pour le dernier
mdesc HHID_panel

save "$directory/CLEAN/NEEMSIS_Agriculture_APPEND_merge1.dta", replace


********** APPEND les 2
use"$directory/CLEAN/NEEMSIS_Agriculture_APPEND_merge1.dta", clear
append using "$directory/CLEAN/NEEMSIS_Agriculture_APPEND_merge23.dta"
drop _merge


*** Verif parent_key HHID_panel
order HHID_panel parent_key
sort HHID_panel
duplicates tag HHID_panel, gen(tag)
sort tag HHID_panel
order tag HHID_panel


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
	*** Duplicates
	drop if parent_key=="uuid:244d058e-b68a-4271-bf5f-5332dca88f8f"  // householdid==36
	drop if parent_key=="uuid:7e235580-30be-4dea-8982-68ed963b45c8"  // householdid==67
	drop if parent_key=="uuid:ece23449-7f67-4de2-b7da-3ea48d4d33dd"  // householdid==235
	drop if parent_key=="uuid:953d8941-5338-4a82-a5d7-2f6e25947e5d"  // householdid==246
	drop if parent_key=="uuid:f52b0fb0-064b-4133-a78d-83edcd80b3e1"  // householdid==343
	drop if parent_key=="uuid:08b045f7-ca13-429c-b25b-604ed8786a32"  // householdid==348
	drop if parent_key=="uuid:332b0700-6bdb-4e66-92ee-7f1e892dae6a"  // householdid==361
	drop if parent_key=="uuid:6854d50b-0b75-4b24-a3b8-ee031aa78668"  // householdid==391
	*
	drop if parent_key=="uuid:f98d6d16-e1cb-4504-8475-9414a295c014"  // householdid==534
	drop if parent_key=="uuid:0c5b2989-3bf7-49db-b6e4-ab455dfee7fe"  // householdid==547 (duplicates with "uuid:211fcb9c-19d7-4e89-9285-488a1a6588be")

foreach x in geopointlatitude geopointlongitude geopointaltitude geopointaccuracy villagename villagearea parent_key address submissiondate {
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
