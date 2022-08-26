cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
January 29, 2021
-----
Tracking cleaning
-----

-------------------------
*/


****************************************
* INITIALIZATION
****************************************
clear all
global directory "C:\Users\Arnaud\Documents\MEGA\Data\Data_Tracking2019\DATA"
cd"$directory"
****************************************
* END








****************************************
* Place
****************************************
use"NEEMSIS-tracking_v6.dta", clear

ta migrationplacename
*ta migrationaddress

********** Group place name
gen migrationplace=""
replace migrationplace="Chennai" if strpos(migrationplacename,"Chennai")
replace migrationplace="Chennai" if strpos(migrationplacename,"chennai")

replace migrationplace="Panruti" if strpos(migrationplacename,"panruti")
replace migrationplace="Panruti" if strpos(migrationplacename,"Panruti")

replace migrationplace="Panruti" if strpos(migrationplacename,"panruti")
replace migrationplace="Panruti" if strpos(migrationplacename,"Panruti")
replace migrationplace="Panruti" if strpos(migrationplacename,"PANRUTI")

replace migrationplace="Pondicherry" if strpos(migrationplacename,"Pondicherry")
replace migrationplace="Pondicherry" if strpos(migrationplacename,"pondicherry")

replace migrationplace="Tiruppur" if strpos(migrationplacename,"Thirupur")
replace migrationplace="Tiruppur" if strpos(migrationplacename,"Tirupur")
replace migrationplace="Tiruppur" if strpos(migrationplacename,"thiruppur")

replace migrationplace="Chengalpet" if strpos(migrationplacename,"Chengalpet")

replace migrationplace="Villiambakkam" if migrationplacename=="ESK chamber, palur, villiyambakkam"

replace migrationplace="Bengaluru" if migrationplacename=="Bangalore"
replace migrationplace="Coimbatore" if migrationplacename=="Coimbatore"
replace migrationplace="Manapakkam" if migrationplacename=="Manapakkam"
replace migrationplace="Kozhipakkam" if migrationplacename=="Kozhipakkam"
replace migrationplace="Pudupattu" if migrationplacename=="Pudupet"
replace migrationplace="Ku Kallakurichi" if migrationplacename=="Veerasozhapuram, kallakurichy"
replace migrationplace="Velankkanni" if migrationplacename=="Velankkanni"
replace migrationplace="Villupuram" if migrationplacename=="Villupuram"
replace migrationplace="Tiruchirappalli" if migrationplacename=="Trichy"
replace migrationplace="Vellore" if migrationplacename=="Vellore"
replace migrationplace="Thotti" if migrationplacename=="Thotti, palur"

replace migrationplace="All over Tamil Nadu" if migrationplacename=="All over Tamil nadu"

replace migrationplace="Same village" if migrationplacename=="Same village"

replace migrationplace="Salem" if migrationplacename=="Selam"

ta migrationplace migrationareatype if dummymainmigrant==1






save"NEEMSIS-tracking_v7.dta", replace
****************************************
* END
