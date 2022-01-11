cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
January 11, 2022
-----
TITLE: Sex relationship
-------------------------
*/


****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "C:\Users\Arnaud\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directorybis = "C:\Users\Arnaud\Docuements\_Thesis\_DATA\NEEMSIS2\DATA"
global git = "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

*global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*global directorybis = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA"
*global git ="C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"


cd"$directory"
clear all
****************************************
* END







****************************************
* Vérifications Mary
****************************************
use"$directory\CLEAN\_ANALYSIS_HH\NEEMSIS2-HH.dta", clear

drop if INDID_left!=.
fre livinghome
drop if livinghome==3
drop if livinghome==4

*Missings
fre relationshiptohead
ta relationshiptoheadother

*Relationshiptohead
fre relationshiptohead
sort version_HH HHID_panel INDID_panel
list version_HH parent_key INDID2020 egoid sex age indivpanel_10_16_20 if relationshiptohead==., clean noobs

fre relationshiptohead sex
ta relationshiptohead sex

*Drop good one to keep mistakes
drop if sex==2 & relationshiptohead==3
drop if sex==1 & relationshiptohead==4
drop if sex==1 & relationshiptohead==5
drop if sex==2 & relationshiptohead==6
drop if sex==1 & relationshiptohead==7
drop if sex==2 & relationshiptohead==8
drop if sex==2 & relationshiptohead==9
drop if sex==1 & relationshiptohead==10
drop if sex==2 & relationshiptohead==11
drop if sex==1 & relationshiptohead==12
drop if sex==1 & relationshiptohead==15
drop if sex==2 & relationshiptohead==16

drop if relationshiptohead==13
drop if relationshiptohead==17

drop if relationshiptohead==1
drop if relationshiptohead==2

drop if relationshiptohead==.

ta relationshiptohead sex, m

ta indivpanel_10_16_20
list parent_key INDID2020 name sex age relationshiptohead if indivpanel



****************************************
* END




