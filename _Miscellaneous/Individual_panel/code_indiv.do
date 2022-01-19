cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
June 11, 2021
-----
Indiv panel
-----

-------------------------
*/



****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
********** Path to folder "data" folder.
*global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*cd "$directory\CLEAN"

global git "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\_Miscellaneous\Individual_panel"

global data "C:\Users\Arnaud\Documents\_Thesis\_DATA"

********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

/*
Les bases indiv2010 & indiv2016 sont les plus importantes car panel entre les deux pour les individus avec INDID_panel

Le but est donc de compléter ça avec les données 2020 sachant qu'une bonne partie est preload donc INDID2016 et INDID2020 doivent coller

*/

****************************************
* END



****************************************
* Nettoyage précédents pour 2010
****************************************
/*
replace INDID_panel=1 if HHID_panel=="ELA52" & INDID=="F3" & year==2010
replace INDID_panel=5 if HHID_panel=="ELA52" & INDID=="F1" & year==2010
replace INDID_panel=-95 if HHID_panel=="GOV47" & INDID=="F2" & year==2010
replace INDID_panel=-96 if HHID_panel=="GOV47" & INDID=="F3" & year==2010
replace INDID_panel=2 if HHID_panel=="GOV47" & INDID=="F4" & year==2010
replace INDID_panel=-95 if HHID_panel=="GOV48" & INDID=="F2" & year==2010
replace INDID_panel=-95 if HHID_panel=="GOV5" & INDID=="F2" & year==2010
replace INDID_panel=-96 if HHID_panel=="GOV5" & INDID=="F3" & year==2010
replace INDID_panel=-97 if HHID_panel=="GOV5" & INDID=="F4" & year==2010
replace INDID_panel=-95 if HHID_panel=="GOV9" & INDID=="F2" & year==2010
replace INDID_panel=-95 if HHID_panel=="KAR15" & INDID=="F6" & year==2010
replace INDID_panel=-95 if HHID_panel=="ELA13" & INDID=="F3" & year==2010
replace INDID_panel=-99 if HHID_panel=="ELA7" & INDID=="F1" & year==2010
replace INDID_panel=-99 if HHID_panel=="KUV10" & INDID=="F2" & year==2010
replace INDID_panel=-98 if HHID_panel=="KUV10" & INDID=="F3" & year==2010
replace INDID_panel=-97 if HHID_panel=="KUV10" & INDID=="F4" & year==2010
replace INDID_panel=-96 if HHID_panel=="KUV10" & INDID=="F5" & year==2010
replace INDID_panel=-95 if HHID_panel=="KUV10" & INDID=="F6" & year==2010
replace INDID_panel=-99 if HHID_panel=="KUV25" & INDID=="F2" & year==2010
replace INDID_panel=-98 if HHID_panel=="KUV25" & INDID=="F3" & year==2010
replace INDID_panel=-97 if HHID_panel=="KUV25" & INDID=="F4" & year==2010
replace INDID_panel=-99 if HHID_panel=="MANAM34" & INDID=="F2" & year==2010
replace INDID_panel=-99 if HHID_panel=="MANAM40" & INDID=="F3" & year==2010
*/


/*
Bon, je n'ai plus mes codes permettant de lier RUME et NEEMSIS-1
Donc, en partant de la base déjà reliée "code_2010_2016
-> Changer manuellement les Ind_
-> Et donc merger de nouveau avec les bases...
*/


/*
use"$git\code_indiv_2010_2016", clear
sort HHID_panel INDID_panel year

*
br if HHID_panel=="ELA13"
replace INDID_panel="Ind_3" if HHID_panel=="ELA13" & INDID=="5" & year==2016


*
br if HHID_panel=="GOV3"

*
br if HHID_panel=="KAR28"
replace INDID_panel="Ind_6" if HHID_panel=="KAR28" & INDID=="5" & year==2016
replace INDID_panel="Ind_7" if HHID_panel=="KAR28" & INDID=="6" & year==2016

*
br if HHID_panel=="KAR49"
replace INDID_panel="Ind_8" if HHID_panel=="KAR49" & INDID=="7" & year==2016
replace INDID_panel="Ind_9" if HHID_panel=="KAR49" & INDID=="8" & year==2016

*
br if HHID_panel=="KOR23"
replace INDID_panel="Ind_8" if HHID_panel=="KOR23" & INDID=="7" & year==2016

*
br if HHID_panel=="KOR38"
replace INDID_panel="Ind_6" if HHID_panel=="KOR38" & INDID=="4" & year==2016
replace INDID_panel="Ind_5" if HHID_panel=="KOR38" & INDID=="5" & year==2016

*
br if HHID_panel=="KOR9"
replace INDID_panel="Ind_5" if HHID_panel=="KOR9" & INDID=="3" & year==2016
replace INDID_panel="Ind_6" if HHID_panel=="KOR9" & INDID=="4" & year==2016
replace INDID_panel="Ind_7" if HHID_panel=="KOR9" & INDID=="5" & year==2016

*
br if HHID_panel=="KUV29"
replace INDID_panel="Ind_4" if HHID_panel=="KUV29" & INDID=="7" & year==2016
replace INDID_panel="Ind_6" if HHID_panel=="KUV29" & INDID=="4" & year==2016
replace INDID_panel="Ind_7" if HHID_panel=="KUV29" & INDID=="5" & year==2016

*
br if HHID_panel=="MAN16"
replace INDID_panel="Ind_6" if HHID_panel=="MAN16" & INDID=="5" & year==2016

*
br if HHID_panel=="MANAM38"
replace INDID_panel="Ind_7" if HHID_panel=="MANAM38" & INDID=="6" & year==2016

*
br if HHID_panel=="MANAM4"
replace INDID_panel="Ind_6" if HHID_panel=="MANAM4" & INDID=="4" & year==2016
replace INDID_panel="Ind_7" if HHID_panel=="MANAM4" & INDID=="6" & year==2016

*
br if HHID_panel=="NAT1"
replace INDID_panel="Ind_6" if HHID_panel=="NAT1" & INDID=="4" & year==2016

*
br if HHID_panel=="ORA15"
replace INDID_panel="Ind_5" if HHID_panel=="ORA15" & INDID=="4" & year==2016
replace INDID_panel="Ind_6" if HHID_panel=="ORA15" & INDID=="5" & year==2016

*
br if HHID_panel=="SEM26"
replace INDID_panel="Ind_6" if HHID_panel=="SEM26" & INDID=="3" & year==2016
replace INDID_panel="Ind_7" if HHID_panel=="SEM26" & INDID=="5" & year==2016
replace INDID_panel="Ind_8" if HHID_panel=="SEM26" & INDID=="6" & year==2016
replace INDID_panel="" if HHID_panel=="" & INDID=="" & year==2016
replace INDID_panel="" if HHID_panel=="" & INDID=="" & year==2016
replace INDID_panel="" if HHID_panel=="" & INDID=="" & year==2016
replace INDID_panel="" if HHID_panel=="" & INDID=="" & year==2016

drop HHINDID
egen HHINDID=concat(HHID_panel INDID_panel), p(/)

save"$git\code_indiv_2010_2016", replace

use"$git\code_indiv_2010_2016", clear
reshape wide INDID name sex age relationshiptohead dummylivinghome maritalstatus egoid, i(HHINDID) j(year)

save"$git\code_indiv_2010_2016_wide", replace
*/

****************************************
* END





****************************************
* Nettoyage 2020
****************************************
/*
Il faut ouvrir indiv2020_temp créer avec les .do.
*/
cd"$data\NEEMSIS2\DATA\APPEND\CLEAN"
*use"indiv2020_temp.dta", clear

use "NEEMSIS2-HH_v5_bis.dta" , clear

gen year=2020
rename INDID INDID2020
rename ego egoid
destring INDID_total INDID_former INDID_new INDID_left, replace
keep HHID_panel name egoid version relationshiptohead relationshiptoheadother maritalstatus year INDID_total INDID_former INDID_new INDID_left INDID2020 livinghome

mdesc HHID_panel

gen dummyleft_2020=0
replace dummyleft_2020=1 if INDID_left!=.

gen dummynew_2020=0
replace dummynew_2020=1 if INDID_new!=.

gen dummyformer_2020=0
replace dummyformer_2020=1 if INDID_former!=.

drop INDID_total INDID_former INDID_new INDID_left

gen dummylivinghome=.
replace dummylivinghome=0 if livinghome==3 | livinghome==4
replace dummylivinghome=1 if livinghome==1 | livinghome==2

save"indiv2020_temp", replace


use"indiv2020_temp.dta", clear
********** Relationshiptohead2020
fre relationshiptohead
tab relationshiptoheadother 

replace relationshiptohead=20 if HHID_panel=="SEM2" & name=="Priya/Nithya?"  // daughter daughter = grandchild or grandchild in law ?
replace relationshiptohead=21 if HHID_panel=="SEM29" & name=="Valli"  // brother's wife --> sister in law
replace relationshiptohead=21 if HHID_panel=="SEM29" & name=="Sheela"  // brother's wife --> sister in law
replace relationshiptohead=22 if relationshiptoheadother=="Huband"  // husband
replace relationshiptohead=22 if relationshiptoheadother=="Husband"  // husband
replace relationshiptohead=21 if relationshiptoheadother=="Sivakandan's wife"  // sister in law
replace relationshiptohead=23 if relationshiptoheadother=="Sivakandan's daughter"  // nephew, niece
replace relationshiptohead=24 if relationshiptoheadother=="Husband's brother"  // --> brother-in-law
replace relationshiptohead=23 if relationshiptoheadother=="Mangalakshmi is sumathi's younger sister's daughter. Mangalakshmi's parents were died so sumathi taking care of her."  // niece
replace relationshiptohead=21 if relationshiptoheadother=="Anbarasan's wife"  // sister in law
replace relationshiptohead=23 if relationshiptoheadother=="Anbarasan's son"  // nephew, niece
replace relationshiptohead=21 if relationshiptoheadother=="Sister in law"  // sister in law
replace relationshiptohead=21 if relationshiptoheadother=="Murugan's wife"  // sister in law
replace relationshiptohead=23 if relationshiptoheadother=="Murugan's son"  // nephew, niece
tab relationshiptohead if relationshiptoheadother!=""

*
recode relationshiptohead (20=18) (21=19) (22=2) (23=20) (24=21)
label define relationshiptohead 1"Head" 2"Wife/Husband" 3"Mother" 4"Father" 5"Son" 6"Daughter" 7"Son-in-law" 8"Daughter-in-law" 9"Sister" 10"Brother" 11"Mother-in-law" 12"Father-in-law" 13"Grandchild" 15"Grandfather" 16"Grandmother" 17"Cousin" 18"Grandchild-in-law" 19"Sister-in-law" 20"Niece/nephew" 21"Brother-in-law" 77"Other", replace
label values relationshiptohead relationshiptohead
tab relationshiptohead
drop relationshiptoheadother



**********Panel2020
clonevar INDID2016=INDID2020
tostring INDID2016, replace
foreach x in name relationshiptohead maritalstatus egoid dummylivinghome{
rename `x' `x'2020
}

*
*drop INDID_panel

merge 1:m HHID_panel INDID2016 using "$git\code_indiv_2010_2016_wide"

order HHID_panel INDID_panel INDID2010 INDID2016 INDID2020 name2010 name2016 name2020 version
drop year
sort HHID_panel INDID_panel
tab name2010
tab name2016
tab name2020


********** Etape 1: verif les merge
preserve
keep if _merge==3
*Ok
*Donc premiere partie du panel ok
drop INDID2010 name2010 sex2010 age2010 relationshiptohead2010 dummylivinghome2010
drop INDID2016 name2016 sex2016 age2016 relationshiptohead2016 dummylivinghome2016 maritalstatus2016 egoid2016

tostring INDID2020, replace
save"indiv2020_temp2", replace
restore



********** Etape 2: verif les autres
drop if _merge==3
preserve
gen ok2010=1 if name2010!=""
gen ok2016=1 if name2016!=""
gen ok2020=1 if name2020!=""

bysort HHID_panel: egen sum_ok2010=sum(ok2010)
bysort HHID_panel: egen sum_ok2016=sum(ok2016)
bysort HHID_panel: egen sum_ok2020=sum(ok2020)

replace sum_ok2010=1 if sum_ok2010>1
replace sum_ok2016=1 if sum_ok2016>1
replace sum_ok2020=1 if sum_ok2020>1

egen todrop=rowtotal(sum_ok2010 sum_ok2016 sum_ok2020)
drop ok2010 ok2016 ok2020
drop if todrop==1
drop if sum_ok2020==0
br  // regarder qui changer
restore
tab _merge
drop if _merge==2


*Modif car panel avec 2010
tostring INDID2020, replace
replace INDID_panel="Ind_1" if HHID_panel=="GOV10" & INDID2020=="1"
replace INDID_panel="Ind_4" if HHID_panel=="GOV47" & INDID2020=="2"
replace INDID_panel="Ind_1" if HHID_panel=="GOV5" & INDID2020=="1"
replace INDID_panel="Ind_1" if HHID_panel=="GOV9" & INDID2020=="1"
replace INDID_panel="Ind_1" if HHID_panel=="KUV10" & INDID2020=="1"
replace INDID_panel="Ind_1" if HHID_panel=="KUV25" & INDID2020=="1"
replace INDID_panel="Ind_5" if HHID_panel=="MANAM19" & INDID2020=="4"
replace INDID_panel="Ind_1" if HHID_panel=="MANAM19" & INDID2020=="1"
replace INDID_panel="Ind_6" if HHID_panel=="MANAM19" & INDID2020=="5"
replace INDID_panel="Ind_2" if HHID_panel=="MANAM19" & INDID2020=="2"
replace INDID_panel="Ind_4" if HHID_panel=="MANAM19" & INDID2020=="3"
replace INDID_panel="Ind_3" if HHID_panel=="MANAM34" & INDID2020=="1"
replace INDID_panel="Ind_1" if HHID_panel=="MANAM40" & INDID2020=="1"
replace INDID_panel="Ind_2" if HHID_panel=="MANAM40" & INDID2020=="2"
replace INDID_panel="Ind_6" if HHID_panel=="ORA25" & INDID2020=="17"
replace INDID_panel="Ind_5" if HHID_panel=="ORA25" & INDID2020=="16"
replace INDID_panel="Ind_1" if HHID_panel=="ORA37" & INDID2020=="1"
replace INDID_panel="Ind_2" if HHID_panel=="ORA37" & INDID2020=="2"

drop INDID2010 name2010 sex2010 age2010 relationshiptohead2010 dummylivinghome2010
drop INDID2016 name2016 sex2016 age2016 relationshiptohead2016 dummylivinghome2016 maritalstatus2016 egoid2016

append using "indiv2020_temp2"
drop _merge
save"indiv2020", replace
*erase "indiv2020_temp.dta"
*erase "indiv2020_temp2.dta"

********** Cleaning
use"indiv2020", clear

drop HHINDID

tab INDID2020 if INDID_panel==""
*ok

foreach x in INDID name egoid relationshiptohead maritalstatus {
rename `x'2020 `x'
}
gen year=2020

order year HHID_panel INDID_panel INDID name relationshiptohead maritalstatus egoid
drop version
save"indiv2020_v2", replace


use"indiv2020_v2", clear
append using "$git\code_indiv_2010_2016"
drop HHINDID
sort HHID_panel INDID_panel
tab year


********** Creation of id for new member
/*
Ajouter v2 v3 v4 à chaque fois que je relance avec des nouveaux individus
*/
sort HHID_panel INDID_panel
split INDID_panel, p(_)
drop INDID_panel1
rename INDID_panel2 codeid
destring codeid, replace
bysort HHID_panel: egen max_codeid=max(codeid)
recode max_codeid (.=0)

gen INDID2020=INDID if year==2020
destring INDID2020, replace

sort HHID_panel INDID2020

*Lets go
clonevar codeid_save=codeid
bysort HHID_panel codeid (INDID2020): gen n=_n
replace n=. if codeid!=.

replace codeid=max_codeid+n if codeid==.
drop max_codeid INDID2020 n
gen temp="Ind_"
egen INDID_panel_temp=concat(temp codeid)
drop temp codeid codeid_save
order HHID_panel INDID_panel INDID_panel_temp year
tab year
drop INDID_panel
rename INDID_panel_temp INDID_panel

*livinghome
fre livinghome
replace dummylivinghome=0 if livinghome==3
replace dummylivinghome=0 if livinghome==4
replace dummylivinghome=1 if livinghome==1
replace dummylivinghome=2 if livinghome==2

drop dummylivinghome2020
drop livinghome

rename dummyleft_2020 dummyleft
rename dummynew_2020 dummynew
rename dummyformer_2020 dummyformer

save"$git\code_indiv_2010_2016_2020_v2", replace

egen HHINDID=concat(HHID_panel INDID_panel), p(/)

reshape wide INDID name sex age relationshiptohead dummylivinghome maritalstatus egoid dummyleft dummyformer dummynew, i(HHINDID) j(year)
drop HHINDID
order HHID_panel INDID_panel INDID2010 INDID2016 INDID2020

save"$git\code_indiv_2010_2016_2020_wide_v2", replace
****************************************
* END






/*
****************************************
* Vérifier INDID_panel
****************************************
use"$git\code_indiv_2010_2016_2020_wide", clear

rename name2010 name_2010
rename name2016 name_2016
rename name2020 name_2020

merge 1:1 HHID_panel INDID_panel using "$git\code_indiv_2010_2016_2020_wide_v2", keepusing(name2010 name2016 name2020)
keep if _merge==3

foreach x in 10 16 20 {
gen test20`x'=.
}

foreach x in 10 16 20 {
replace test20`x'=1 if name20`x'!=name_20`x'
}

tab1 test2010 test2016 test2020
sort test2020

/*
OK
*/
****************************************
* END
*/










/*

****************************************
* Tracking 2019
****************************************
use"$data\Tracking2019\DATA\NEEMSIS-tracking_comp_v5.dta", clear


keep HHID_panel HHID2019 HHID2019other INDID2019 namemigrant name age sex relationshiptohead caste address villageid HHID2010_origin HHID_panel_origin hhvillage_origin

rename HHID_panel HHID_panel_real
rename HHID_panel_origin HHID_panel

save"$data\Tracking2019\DATA\NEEMSIS-tracking_indiv.dta", replace



********** Merger les id
gen INDID_panel=""
order HHID_panel HHID2010 INDID_panel namemigrant


*INDID_panel
merge m:m HHID_panel using "$git\code_indiv_2010_2016_2020_v2"
keep if _merge==3
drop _merge

gen HHok=1 if dummyego!=.
bysort HHID_panel: egen max_HHok=max(HHok)
*drop if max_HHok==.
sort HHID_panel INDID_panel

order HHID_panel year INDID_panel name sex age relationshiptohead maritalstatus
drop _merge
sort HHID_panel name

split INDID_panel, p(_)
order HHID_panel year INDID_panel INDID_panel1 INDID_panel2
destring INDID_panel2, replace
bysort HHID_panel name: egen max_INDID_panel2=max(INDID_panel2)

gen trackok=.
replace trackok=1 if INDID_panel2==. & max_INDID_panel2!=.
replace trackok=0 if INDID_panel2==. & max_INDID_panel2==.

order HHID_panel year INDID_panel INDID_panel1 INDID_panel2 max_INDID_panel2 name trackok

sort HHID_panel name year
sort HHID_panel max_INDID_panel2 year INDID_panel2 year

tab trackok

*Max par HH
bysort HHID_panel : egen max_INDID=max(INDID_panel2)

*_n pour les missings puis somme
bysort HHID_panel max_INDID_panel2 : gen new_nb=_n if max_INDID_panel2==.

order HHID_panel year INDID_panel INDID_panel1 INDID_panel2 max_INDID_panel2 max_INDID new_nb name trackok namemigrant

replace max_INDID_panel2=max_INDID+new_nb if max_INDID_panel2==.

*Mettre dans la même variable
replace INDID_panel1="Ind" if INDID_panel1==""

egen INDID_panel3=concat(INDID_panel1 max_INDID_panel2), p(_)

clonevar INDID_panel_backup=INDID_panel
order HHID_panel year INDID_panel_backup
replace INDID_panel=INDID_panel3 if INDID_panel=="" 

replace ego=dummyego if ego==. & dummyego!=.

drop HHok max_HHok dummyego trackok dummylivinghome max_merge HHID2010 villageid caste INDID_panel1 INDID_panel2 max_INDID_panel2 max_INDID new_nb INDID_panel3

order namemigrant INDID_panel_backup, last
tab year

sort HHID_panel INDID_panel year

drop if year==.

tab year


save"$git\code_indiv_2010_2016_2020_tracking2019_v2", replace

*Attention à Saravanan
egen HHINDID=concat(HHID_panel INDID_panel), p(/)

duplicates tag HHINDID year, gen(tag)
tab tag
sort tag HHID_panel INDID_panel
gen tracking_pb=.
replace tracking_pb=0 if year==2019
replace tracking_pb=1 if year==2019 & HHID_panel=="GOV7"
replace tracking_pb=1 if year==2019 & HHID_panel=="KOR38"
replace tracking_pb=1 if year==2019 & HHID_panel=="MAN12"
replace tracking_pb=1 if year==2019 & HHID_panel=="NAT18"

rename tag duplicates_tracking

bysort HHID_panel INDID_panel duplicates_tracking: gen n=_n
replace n=. if duplicates_tracking==0

egen INDID_panel2=concat(INDID_panel n), p("_b")
replace INDID_panel=INDID_panel2 if duplicates_tracking==1
drop n INDID_panel2

sort duplicates_tracking HHID_panel INDID_panel

drop HHINDID
egen HHINDID=concat(HHID_panel INDID_panel), p(/)


reshape wide name sex age relationshiptohead maritalstatus relationshiptoheadother INDID egoid dummynew dummyformer dummyleft namemigrant INDID_panel_backup duplicates_tracking tracking_pb, i(HHINDID) j(year)
drop HHINDID
order HHID_panel INDID_panel INDID2010 INDID2016 INDID2020

save"$git\code_indiv_2010_2016_2020_tracking2019_wide_v2", replace
****************************************
* END
