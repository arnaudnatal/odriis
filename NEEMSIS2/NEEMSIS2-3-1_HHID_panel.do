cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
October 05, 2021
-----
Ajouter les nouveaux HHID_panel
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
global git "C:\Users\anatal\Downloads\Github\RUME-NEEMSIS\_Miscellaneous\Individual_panel"

********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

****************************************
* END


/*
IL FAUT LANCER LE FICHIER DO (code HH) QUI PERMET DE CREER UN NOUVEL HHIDPANEL POUR LES
NOUVEAUX HH
UNE FOIS FAIT, JE MERGE HHID PANEL JUSTE EN DESSOUS LA
*/




****************************************
* Pseudo HH
****************************************
use"$directory\CLEAN\NEEMSIS2-HH_v5.dta", replace

mdesc HHID_panel
/*
Il manque bien les 690 nouveaux individus
*/

rename HHID_panel HHID_panel_backup
merge m:1 householdid2020 parent_key using "$git\unique_identifier_panel_v2.dta", keepusing(HHID_panel)
drop if _merge==2
drop _merge

replace HHID_panel=HHID_panel_backup if HHID_panel=="" & HHID_panel_backup!=""
mdesc HHID_panel HHID_panel_backup
drop HHID_panel_backup
order HHID_panel
sort HHID_panel
drop if householdid2020==.

tab version



save"$directory\CLEAN\NEEMSIS2-HH_v5_bis.dta", replace
****************************************
* END



/*
PUIS ICI, IL FAUT CONTINUER LA FABRICATION DE INDID PANEL EN LANCANT LE FICHIER DO code_indiv
*/
