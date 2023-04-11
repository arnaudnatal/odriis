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





****************************************
* Reshape
****************************************

*** Payment
use"NEEMSIS-tracking_wagejobpaymentinkind.dta", clear
drop migwagejobpaymentinkindid
rename migwagejobpaymentinkindvalue wagejobpaykindvalue
reshape wide wagejobpaykindvalue migwagejobpaymentinkindname, i(key indid2) j(wagejobpaymentinkindid)

rename wagejobpaykindvalue1 wagejobpaykindvalue_cloth
rename wagejobpaykindvalue2 wagejobpaykindvalue_food
rename wagejobpaykindvalue3 wagejobpaykindvalue_trspt
rename wagejobpaykindvalue4 wagejobpaykindvalue_acco
rename wagejobpaykindvalue5 wagejobpaykindvalue_labour
rename wagejobpaykindvalue6 wagejobpaykindvalue_other

drop migwagejobpaymentinkindname1 migwagejobpaymentinkindname2 migwagejobpaymentinkindname3 migwagejobpaymentinkindname4 migwagejobpaymentinkindname5 migwagejobpaymentinkindname6

rename key HHID2019
rename indid2 INDID_mig

save "NEEMSIS-tracking_wagejob_wide", replace


*** Contact
use"NEEMSIS-tracking_contact.dta", clear

rename key HHID2019
rename indid2 INDID_mig

reshape wide contactnumber contactname, i(HHID2019 INDID_mig) j(contactid)
rename contactnumber1 contactnumber_head
rename contactnumber2 contactnumber_police
rename contactnumber3 contactnumber_civil
rename contactnumber4 contactnumber_bank
rename contactnumber5 contactnumber_pancha
rename contactnumber6 contactnumber_council
rename contactnumber7 contactnumber_recruiter
rename contactnumber8 contactnumber_trade

drop contactname1 contactname2 contactname3 contactname4 contactname5 contactname6 contactname7 contactname8

save "NEEMSIS-tracking_contactwide", replace
****************************************
* END









****************************************
* Merge reshape
****************************************
use"NEEMSIS-tracking_v7.dta", clear


********** Clean
rename key HHID2019
rename indid INDID_nonmig
rename indid2 INDID_mig

drop caste 
rename jatis caste
rename jatisother casteother
drop if name==""
drop familymembers_count employment_count *fromearlier *fromearlier* index listid edulevel occupationname_moc_indiv annualincome_moc_indiv profession_moc_indiv sector_moc_indiv kindofwork_new_moc_indiv occupation_moc_indiv worker working_pop


merge m:1 HHID2019 INDID_mig using "NEEMSIS-tracking_wagejob_wide"
drop _merge

merge m:1 HHID2019 INDID_mig using "NEEMSIS-tracking_contactwide"
drop _merge

replace religion=religionindividual if religion==. & religionindividual!=.
replace religionother=otherreligionindividual if religionother=="" & otherreligionindividual!=""

drop religionindividual otherreligionindividual

save "NEEMSIS-tracking_v8.dta", replace
****************************************
* END