cls
/*
-------------------------
Cécile Mouchel
November 08, 2021
-----
TITLE: CLEANING SN, part 2
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
global directorybis = "D:\Docuements\_Thesis\_DATA\NEEMSIS2\DATA"
global git = "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

*global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*global directorybis = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA"
*global git ="C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"


cd"$directory"
clear all
****************************************
* END










****************************************
* 2. MARRIAGE LOANS
****************************************
use "$directory\CLEAN\NEEMSIS_APPEND-marriagefinance.dta"
keep if marriageloanlistsn!=.
split parent_key, p(/)
drop parent_key2
rename parent_key setofmarriagegroup
rename parent_key1 parent_key
order parent_key
gen position=ustrpos(setofmarriagegroup,"[")
generate test = usubstr(setofmarriagegroup,position,.)
gen INDID_v1 = regexs(0) if(regexm(test , "[0-9]"))
destring INDID_v1, replace
gen INDID_v2 = regexs(0) if(regexm(test , "[0-9][0-9]"))
destring INDID_v2, replace
replace INDID_v1=INDID_v2 if INDID_v2!=.
rename INDID_v1 INDID_total
order INDID_total, before( marriageloanid )
gen loanmarriageuse=1
rename marriageloanlistsn snlist
keep parent_key INDID_total marriageloanid loanmarriageuse snlist
save "$directory\CLEAN\base_alter_B_complete.dta",replace
merge m:1 parent_key snlist using "$directory\CLEAN\base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
decode snlist, gen (snlist_str)
gen egoid_v1= ustrleft(snlist_str, 3)
gen egoid_v2 = regexs(0) if(regexm(egoid_v1 , "[0-9]"))
destring egoid_v2, replace
gen egoid=1 if egoid_v2==.&snlist>80
replace egoid=2 if egoid_v2==2&snlist>80
replace egoid=2 if egoid_v2==3&snlist>80
drop egoid_v1 egoid_v2
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "$directory\CLEAN\base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist snlist_str egoid
* REMARQUE : Suppression ici du marriageloanid pour pouvoir faire mon reshaping et plus tard le merging final
* Je n'ai pas encore tous les éléments en main, mais ça pourrait être problématique par la suite
duplicates tag ALTERID, gen(dup_ALTERID)
replace dup_ALTERID=10 if dup_ALTERID==0
sort dup_ALTERID
gen compteur=_n if dup_ALTERID==1
replace compteur=1 if compteur==.
drop marriageloanid
reshape wide loanmarriageuse , i( ALTERID) j( compteur)
drop dup_ALTERID
save "$directory\CLEAN\base_alter_B_complete.dta",replace
merge m:m parent_key INDID_total using "$directory\CLEAN\NEEMSIS2-HH_v20.dta", keep (1 3) keepusing(egoid)
drop _merge
replace egoid=0 if egoid==.
replace loanmarriageuse1=20 if egoid==0
replace loanmarriageuse1=21 if egoid==1
replace loanmarriageuse1=22 if egoid==2
replace loanmarriageuse1=23 if egoid==3
replace loanmarriageuse2=20 if egoid==0&loanmarriageuse2!=.
replace loanmarriageuse2=21 if egoid==1&loanmarriageuse2!=.
replace loanmarriageuse2=22 if egoid==2&loanmarriageuse2!=.
replace loanmarriageuse2=23 if egoid==3&loanmarriageuse2!=.
save "$directory\CLEAN\base_alter_B_complete.dta",replace
clear
****************************************
* END










****************************************
* 3. BUSINESS LOANS
****************************************
use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemploymentsourceinvestment-businessloandetails_v2.dta"
keep if snbusinesslender!=888
rename snbusinesslender snlist
keep parent_key egoid businessloanid snlist
gen businessloanuse=1
save "$directory\CLEAN\base_alter_C_complete.dta",replace 
merge m:1 parent_key snlist using "$directory\CLEAN\base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "$directory\CLEAN\base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
* REMARQUE : Suppression ici du businessloanid et egoid pour pouvoir faire mon reshaping et plus tard le merging final
* Je n'ai pas encore tous les éléments en main, mais ça pourrait être problématique par la suite
duplicates tag ALTERID, gen(dup_ALTERID)
replace dup_ALTERID=. if dup_ALTERID==0
sort dup_ALTERID ALTERID
by dup_ALTERID ALTERID : gen compteur=_n
drop businessloanid egoid
reshape wide businessloanuse , i( ALTERID) j( compteur)
drop dup_ALTERID
replace businessloanuse1=30 if businessloanuse1!=.
replace businessloanuse2=30 if businessloanuse2!=.
replace businessloanuse3=30 if businessloanuse3!=.
save "$directory\CLEAN\base_alter_C_complete.dta",replace 
clear
****************************************
* END










****************************************
* 4. RECRUIT WORKER
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta"
destring snrecruitworkernamelist, replace
drop if snrecruitworkernamelist==888
keep if snrecruitworkernamelist!=.
keep parent_key egoid INDID_total snrecruitworkernamelist
rename snrecruitworkernamelist snlist
gen recruitworkeruse=1
save "$directory\CLEAN\base_alter_D_complete.dta",replace 
merge m:1 parent_key snlist using "$directory\CLEAN\base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "$directory\CLEAN\base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
replace recruitworkeruse=41 if egoid==1
replace recruitworkeruse=42 if egoid==2
replace recruitworkeruse=43 if egoid==3
save "$directory\CLEAN\base_alter_D_complete.dta",replace 
clear
****************************************
* END










****************************************
* 5. HELP TO JOIN ASSOCIATION
****************************************
use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-formalsocialcapital_v2.dta" 
destring snrecommendasso, replace
drop if snrecommendasso==888
keep if snrecommendasso!=.
rename snrecommendasso snlist
keep parent_key egoid associationid snlist
gen assosnuse=1
save "$directory\CLEAN\base_alter_E_complete.dta",replace
merge m:1 parent_key snlist using "$directory\CLEAN\base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "$directory\CLEAN\base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
replace assosnuse=51 if egoid==1
replace assosnuse=52 if egoid==2
replace assosnuse=53 if egoid==3
save "$directory\CLEAN\base_alter_E_complete.dta",replace
clear
****************************************
* END










****************************************
* 6. CURRENT MAIN OCCUPATION
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab snfindcurrentjobnamelist
split snfindcurrentjobnamelist
foreach var of varlist snfindcurrentjobnamelist1- snfindcurrentjobnamelist3{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid snfindcurrentjobnamelist1- snfindcurrentjobnamelist3
gen compteur=_n
reshape long snfindcurrentjobnamelist, i(compteur) j(alterid_va)
drop if snfindcurrentjobnamelist==.
rename snfindcurrentjobnamelist snlist
drop compteur alterid_va
gen currentjobuse=1
save "$directory\CLEAN\base_alter_F_complete.dta", replace
merge m:1 parent_key snlist using "$directory\CLEAN\base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "$directory\CLEAN\base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
drop if ALTERID==""
* Des missings parmi les ALTERID qui s'expliquent toujours du fait de la présence de seulement 4 alters contre 13 pour les "Recruit worker"
* Je suis obligée de supprimer ces missing pour le moment
save "$directory\CLEAN\base_alter_F_complete.dta", replace
keep if egoid==1
replace currentjobuse=61
rename currentjobuse currentjobuse_ego1
save "$directory\CLEAN\base_alter_F_complete_ego1.dta", replace
use "$directory\CLEAN\base_alter_F_complete.dta"
keep if egoid==2
replace currentjobuse=62
rename currentjobuse currentjobuse_ego2
save "$directory\CLEAN\base_alter_F_complete_ego2.dta", replace
use "$directory\CLEAN\base_alter_F_complete.dta"
keep if egoid==3
replace currentjobuse=63
rename currentjobuse currentjobuse_ego3
save "$directory\CLEAN\base_alter_F_complete_ego3.dta", replace
clear
****************************************
* END










****************************************
* 7. HELP TO FIND JOB IN THE FUTURE
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab snfindjobnamelist
split snfindjobnamelist
foreach var of varlist snfindjobnamelist1- snfindjobnamelist5{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid snfindjobnamelist1- snfindjobnamelist5
gen compteur=_n
reshape long snfindjobnamelist, i(compteur) j(alterid_va)
drop if snfindjobnamelist==.
rename snfindjobnamelist snlist
drop compteur alterid_va
gen futurejobuse=1
save "$directory\CLEAN\base_alter_G_complete.dta", replace
merge m:1 parent_key snlist using "$directory\CLEAN\base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "$directory\CLEAN\base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
drop if ALTERID==""
* Des missings parmi les ALTERID qui s'expliquent toujours du fait de la présence de seulement 4 alters contre 13 pour les "Recruit worker"
save "$directory\CLEAN\base_alter_G_complete.dta", replace
keep if egoid==1
replace futurejobuse=71
rename futurejobuse futurejobuse_ego1
save "$directory\CLEAN\base_alter_G_complete_ego1.dta", replace
use "$directory\CLEAN\base_alter_G_complete.dta"
keep if egoid==2
replace futurejobuse=72
rename futurejobuse futurejobuse_ego2
save "$directory\CLEAN\base_alter_G_complete_ego2.dta", replace
use "$directory\CLEAN\base_alter_G_complete.dta"
keep if egoid==3
replace futurejobuse=73
rename futurejobuse futurejobuse_ego3
save "$directory\CLEAN\base_alter_G_complete_ego3.dta", replace
clear
****************************************
* END










****************************************
* 8. RECOMMEND FOR A JOB
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
split snrecommendforjobnamelist
foreach var of varlist snrecommendforjobnamelist1- snrecommendforjobnamelist4{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid snrecommendforjobnamelist1- snrecommendforjobnamelist4
gen compteur=_n
reshape long snrecommendforjobnamelist, i(compteur) j(alterid_va)
drop if snrecommendforjobnamelist==.
rename snrecommendforjobnamelist snlist
drop compteur alterid_va
gen recommendforjobuse=1
save "$directory\CLEAN\base_alter_H_complete.dta", replace
merge m:1 parent_key snlist using "$directory\CLEAN\base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "$directory\CLEAN\base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
save "$directory\CLEAN\base_alter_H_complete.dta", replace
keep if egoid==1
replace recommendforjobuse=81
rename recommendforjobuse recommendforjobuse_ego1
save "$directory\CLEAN\base_alter_H_complete_ego1.dta", replace
use "$directory\CLEAN\base_alter_H_complete.dta"
keep if egoid==2
replace recommendforjobuse=82
rename recommendforjobuse recommendforjobuse_ego2
save "$directory\CLEAN\base_alter_H_complete_ego2.dta", replace
use "$directory\CLEAN\base_alter_H_complete.dta"
keep if egoid==3
replace recommendforjobuse=83
rename recommendforjobuse recommendforjobuse_ego3
save "$directory\CLEAN\base_alter_H_complete_ego3.dta", replace
clear
****************************************
* END










****************************************
* 9. RECOMMEND SUCCESS
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab snrecojobsuccessnamelist
split snrecojobsuccessnamelist
foreach var of varlist snrecojobsuccessnamelist1- snrecojobsuccessnamelist4{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid snrecojobsuccessnamelist1- snrecojobsuccessnamelist4
gen compteur=_n
reshape long snrecojobsuccessnamelist, i(compteur) j(alterid_va)
drop if snrecojobsuccessnamelist==.
rename snrecojobsuccessnamelist snlist
drop compteur alterid_va
gen recojobsuccessuse=1
save "$directory\CLEAN\base_alter_I_complete.dta", replace
merge m:1 parent_key snlist using "$directory\CLEAN\base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "$directory\CLEAN\base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
save "$directory\CLEAN\base_alter_I_complete.dta", replace
keep if egoid==1
replace recojobsuccessuse=91
rename recojobsuccessuse recojobsuccessuse_ego1
save "$directory\CLEAN\base_alter_I_complete_ego1.dta", replace
use "$directory\CLEAN\base_alter_I_complete.dta"
keep if egoid==2
replace recojobsuccessuse=92
rename recojobsuccessuse recojobsuccessuse_ego2
save "$directory\CLEAN\base_alter_I_complete_ego2.dta", replace
use "$directory\CLEAN\base_alter_I_complete.dta"
keep if egoid==3
replace recojobsuccessuse=93
rename recojobsuccessuse recojobsuccessuse_ego3
save "$directory\CLEAN\base_alter_I_complete_ego3.dta", replace
clear
****************************************
* END










****************************************
* 10. TALK THE MOST
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab sntalkthemost
split sntalkthemost
foreach var of varlist sntalkthemost1- sntalkthemost4{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid sntalkthemost1- sntalkthemost4
gen compteur=_n
reshape long sntalkthemost, i(compteur) j(alterid_va)
drop if sntalkthemost==.
rename sntalkthemost snlist
drop compteur alterid_va
gen talkthemostuse=1
save "$directory\CLEAN\base_alter_J_complete.dta", replace
merge m:1 parent_key snlist using "$directory\CLEAN\base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "$directory\CLEAN\base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
drop if ALTERID==""
save "$directory\CLEAN\base_alter_J_complete.dta", replace
keep if egoid==1
replace talkthemostuse=101
rename talkthemostuse talkthemostuse_ego1
save "$directory\CLEAN\base_alter_J_complete_ego1.dta", replace
use "$directory\CLEAN\base_alter_J_complete.dta"
keep if egoid==2
replace talkthemostuse=102
rename talkthemostuse talkthemostuse_ego2
save "$directory\CLEAN\base_alter_J_complete_ego2.dta", replace
use "$directory\CLEAN\base_alter_J_complete.dta"
keep if egoid==3
replace talkthemostuse=103
rename talkthemostuse talkthemostuse_ego3
save "$directory\CLEAN\base_alter_J_complete_ego3.dta", replace
clear
****************************************
* END










****************************************
* 11. MEDICAL EMERGENCY
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
ta snhelpemergency
split snhelpemergency
foreach var of varlist snhelpemergency1- snhelpemergency4{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid snhelpemergency1- snhelpemergency4
gen compteur=_n
reshape long snhelpemergency, i(compteur) j(alterid_va)
drop if snhelpemergency==.
rename snhelpemergency snlist
drop compteur alterid_va
gen medicalemergencyuse=1
save "$directory\CLEAN\base_alter_K_complete.dta", replace
merge m:1 parent_key snlist using "$directory\CLEAN\base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "$directory\CLEAN\base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
save "$directory\CLEAN\base_alter_K_complete.dta", replace
keep if egoid==1
replace medicalemergencyuse=111
rename medicalemergencyuse medicalemergencyuse_ego1
save "$directory\CLEAN\base_alter_K_complete_ego1.dta", replace
use "$directory\CLEAN\base_alter_K_complete.dta"
keep if egoid==2
replace medicalemergencyuse=112
rename medicalemergencyuse medicalemergencyuse_ego2
save "$directory\CLEAN\base_alter_K_complete_ego2.dta", replace
use "$directory\CLEAN\base_alter_K_complete.dta"
keep if egoid==3
replace medicalemergencyuse=113
rename medicalemergencyuse medicalemergencyuse_ego3
save "$directory\CLEAN\base_alter_K_complete_ego3.dta", replace
clear
****************************************
* END










****************************************
* 12. CLOSE RELATIVES OUTSIDE HH
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab sncloserelouthh
split sncloserelouthh
foreach var of varlist sncloserelouthh1- sncloserelouthh4{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid sncloserelouthh1- sncloserelouthh4
gen compteur=_n
reshape long sncloserelouthh, i(compteur) j(alterid_va)
drop if sncloserelouthh==.
rename sncloserelouthh snlist
drop compteur alterid_va
gen closerelouthhuse=1
save "$directory\CLEAN\base_alter_L_complete.dta", replace
merge m:1 parent_key snlist using "$directory\CLEAN\base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "$directory\CLEAN\base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
save "$directory\CLEAN\base_alter_L_complete.dta", replace
keep if egoid==1
replace closerelouthhuse=121
rename closerelouthhuse closerelouthhuse_ego1
save "$directory\CLEAN\base_alter_L_complete_ego1.dta", replace
use "$directory\CLEAN\base_alter_L_complete.dta"
keep if egoid==2
replace closerelouthhuse=122
rename closerelouthhuse closerelouthhuse_ego2
drop if ALTERID==""
save "$directory\CLEAN\base_alter_L_complete_ego2.dta", replace
use "$directory\CLEAN\base_alter_L_complete.dta"
keep if egoid==3
replace closerelouthhuse=123
rename closerelouthhuse closerelouthhuse_ego3
save "$directory\CLEAN\base_alter_L_complete_ego3.dta", replace
clear
****************************************
* END










****************************************
* 13. RECEIVED HELP DURING COVID-19
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab covsnhelpreceivedlist
split covsnhelpreceivedlist
foreach var of varlist covsnhelpreceivedlist1- covsnhelpreceivedlist5{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid covsnhelpreceivedlist1- covsnhelpreceivedlist5
gen compteur=_n
reshape long covsnhelpreceivedlist, i(compteur) j(alterid_va)
drop if covsnhelpreceivedlist==.
rename covsnhelpreceivedlist snlist
drop compteur alterid_va
gen receivedhelpcov=1
save "$directory\CLEAN\base_alter_M_complete.dta", replace
merge m:1 parent_key snlist using "$directory\CLEAN\base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "$directory\CLEAN\base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
drop if ALTERID==""
save "$directory\CLEAN\base_alter_M_complete.dta", replace
keep if egoid==1
replace receivedhelpcov=131
rename receivedhelpcov receivedhelpcov_ego1
save "$directory\CLEAN\base_alter_M_complete_ego1.dta", replace
use "$directory\CLEAN\base_alter_M_complete.dta"
keep if egoid==2
replace receivedhelpcov=132
rename receivedhelpcov receivedhelpcov_ego2
save "$directory\CLEAN\base_alter_M_complete_ego2.dta", replace
use "$directory\CLEAN\base_alter_M_complete.dta"
keep if egoid==3
replace receivedhelpcov=133
rename receivedhelpcov receivedhelpcov_ego3
save "$directory\CLEAN\base_alter_M_complete_ego3.dta", replace
clear
****************************************
* END










****************************************
* 14. GIVEN HELP COVID-19
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab covsnhelpgiven
tab covsnhelpgivenlist
split covsnhelpgivenlist
foreach var of varlist covsnhelpgivenlist1- covsnhelpgivenlist2{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid covsnhelpgivenlist1- covsnhelpgivenlist2
gen compteur=_n
reshape long covsnhelpgivenlist, i(compteur) j(alterid_va)
drop if covsnhelpgivenlist==.
rename covsnhelpgivenlist snlist
drop compteur alterid_va
gen givehelpcov=1
save "$directory\CLEAN\base_alter_N_complete.dta", replace
merge m:1 parent_key snlist using "$directory\CLEAN\base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "$directory\CLEAN\base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
save "$directory\CLEAN\base_alter_N_complete.dta", replace
keep if egoid==1
replace givehelpcov=141
rename givehelpcov givehelpcov_ego1
save "$directory\CLEAN\base_alter_N_complete_ego1.dta", replace
use "$directory\CLEAN\base_alter_N_complete.dta"
keep if egoid==2
replace givehelpcov=142
rename givehelpcov givehelpcov_ego2
save "$directory\CLEAN\base_alter_N_complete_ego2.dta", replace
use "$directory\CLEAN\base_alter_N_complete.dta"
keep if egoid==3
replace givehelpcov=143
rename givehelpcov givehelpcov_ego3
save "$directory\CLEAN\base_alter_N_complete_ego3.dta", replace
clear
****************************************
* END










****************************************
* MERGING
****************************************
use "$directory\CLEAN\base_alter_VF1.dta", clear
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_B_complete.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_C_complete.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_D_complete.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_E_complete.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_F_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_F_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_F_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_G_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_G_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_G_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_H_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_H_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_H_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_I_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_I_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_I_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_J_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_J_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_J_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:m ALTERID using "$directory\CLEAN\base_alter_K_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_K_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_K_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_L_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_L_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_L_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_M_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_M_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_M_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_N_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_N_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "$directory\CLEAN\base_alter_N_complete_ego3.dta", keep(1 3)
drop _merge
save "$directory\CLEAN\base_alter_VF2.dta", replace
clear
****************************************
* END










****************************************
* ATTENTION ! Toujours un travail de 
* nettoyage de la base alter en créant 
* la variable networkpurpose
****************************************
use "$directory\CLEAN\base_alter_VF2.dta", clear
* Retrait des Alters également membres du ménage
drop if hhmember!=.
* Retrait des prêteurs institutionnels pour les auto-entrepreneurs
drop if businesslender>9&businesslender!=.
* Retrait des ménages dupliqués - Information fournie par Arnaud (à actualiser)
drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"  // householdid==36 & name1=="Natesan"
drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"  // householdid==67 & name1=="Shankar"
drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"  // householdid==124 & name1=="Subramani"
drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"  // householdid==246 & name1=="Sornambal"
drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"  // householdid==343 & name1=="Ramamoorthi"
drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"  // householdid==348 & name1=="Govindan"
drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"  // householdid==361 & name1=="Mallika"
drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"  // householdid==391 & name1=="Balaji"
*
drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"  // householdid==532 & name1=="Shakthivel" & name2=="Revathy"
drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"  // householdid==534 & name1=="Karunanidhi"
drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"  // householdid==547 & name1=="Surya" (duplicates with "uuid:ae72a34f-f968-45f4-acfa-91f571f54ea8")
save "$directory\CLEAN\base_alter_VF2.dta", replace


/* 
Liste des ménages sans info sur les Thandals mais avec la catégorie Thandal
Les versions qui semblent être problématiques sont NEW_APRIL et FEB.
*/

use "$directory\CLEAN\base_alter_VF2.dta", clear
keep if egoid==0
save "$directory\CLEAN\base_alter_VF2_egoid_0.dta", replace
use "$directory\CLEAN\base_alter_VF2.dta", clear
keep if egoid!=0

preserve
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
keep parent_key INDID_total egoid
keep if INDID_total!=.
keep if egoid!=0
duplicates drop
save "$directory\CLEAN\base_indexage_egoid!=0.dta", replace
restore

merge m:1 parent_key egoid using "$directory\CLEAN\base_indexage_egoid!=0.dta"

/* 

Liste des 13 ménages dont le parent_key est absent de la base principale :

uuid:1a634cf9-4476-4ca6-b45e-0c73f978f4a4
uuid:1ea7523b-cad1-44da-9afa-8c4f96189433
uuid:208757f5-b91b-437d-ad82-07e597687cb3
uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d
uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3
uuid:7fc65842-447f-4b1d-806a-863556d03ed3
uuid:8d9dd0b1-a274-4c9a-955b-69ad8695d400
uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f
uuid:b283cb62-a316-418a-80b5-b8fe86585ef8
uuid:b9607c3a-12c6-4c2d-a356-2c9ba06053b5
uuid:c14788bc-235f-4690-b9bf-15bfde3788ef
uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231
uuid:f5367782-940d-46ea-a528-80d4863926ba


*/

codebook parent_key if _merge==1
duplicates list parent_key if _merge==1
keep if _merge==3
drop _merge
append using "$directory\CLEAN\base_alter_VF2_egoid_0.dta"
save "$directory\CLEAN\base_alter_VF3.dta", replace
clear
****************************************
* END
