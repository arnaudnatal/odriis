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

global git "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\Individual_panel"

global directory "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND\CLEAN"

global neemsis "NEEMSIS2-HH_v5.dta"


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
* CONTINUE Cécile class
****************************************
*use"unique_identifier_panel", clear



********** Avoir une base pour append
use"$directory\\$neemsis", clear

tab version
keep if version=="NEEMSIS2_NEW_JUNE"
destring villagename, replace
replace villageid=villagename if villageid==. & villagename!=.
sort villageid
keep villageid householdid2020 HHID2010 HHID_panel interviewplace address villagearea parent_key HHID householdidparent caste username numfamily

*Clean
destring numfamily, replace
gen username_str=username+1-1
tab username_str username
drop username
rename username_str username
tostring username, replace

*Area
fre villagearea
rename villagearea villageareaid

duplicates drop
sort householdid2020

save"$directory\\$neemsis-_tocomp", replace




********** Append la base
use"$git\unique_identifier_panel", clear
fre villageareaid
append using "$directory\\$neemsis-_tocomp"




********** Continuer code Cécile
sort villageid n1 parent_key
order villageid n1

*Max ?
bysort villageid: egen max_n1=max(n1)
order villageid n1 max_n1

*On continue
bysort villageid n1: gen ntemp=_n
replace ntemp=. if n1!=.
order villageid n1 max_n1 ntemp

gen n2=.
replace n2=n1 if n1!=.
replace n2=max_n1 + ntemp if n1==.

order villageid n1 max_n1 ntemp n2


****************************************
* END
