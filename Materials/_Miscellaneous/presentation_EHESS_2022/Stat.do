cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
June 9, 2022
-----
EHESS pres ODRIIS
-----

-------------------------
*/





****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all

global user "Arnaud"
global folder "Documents"

********** Path to folder "data" folder
global directory = "C:\Users\Arnaud\Documents\_Thesis\Research-Employment_evolution\Data"
global git "C:\Users\Arnaud\Documents\GitHub\odriis\_Miscellaneous\Individual_panel"
cd"$directory"

* Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid compact

********** Name of the NEEMSIS2 questionnaire version to clean
global wave1 "RUME-HH"
global wave2 "NEEMSIS1-HH"
global wave3 "NEEMSIS2-HH"
global occ1 "RUME-occupations"
global occ2 "NEEMSIS1-occupation_allwide"
global occ3 "NEEMSIS2-occupation_allwide"


****************************************
* END







****************************************
* Description panel
****************************************
********** HH
cls
use"$git/ODRIIS-HH", clear

ta caste2010
ta caste2016
ta caste2020

ta caste2016 if panel1==1
ta caste2016 if panel2==1
ta caste2016 if panel3==1


********** Indiv
cls
use"$git/ODRIIS-indiv", clear

ta sex2010
ta sex2016
ta sex2020

ta sex2016 if sex2010!=""
ta sex2016 if sex2020!=""
ta sex2016 if sex2010!="" & sex2020!=""

destring age2010 age2016 age2020, replace
tabstat age2010 age2016 age2020, stat(mean)

****************************************
* END








****************************************
* Evolution mainocc
****************************************
use"$wave1", clear
keep HHID_panel INDID_panel caste jatis age sex relationshiptohead villageid working_pop annualincome_indiv annualincome_HH mainocc_occupation_indiv mainocc_profession_indiv mainocc_occupation_HH worker villageid
gen year=2010
save "$wave1-_temp", replace

use"$wave2", clear
keep HHID_panel INDID_panel caste jatis age sex relationshiptohead villageid working_pop annualincome_indiv annualincome_HH mainocc_occupation_indiv mainocc_profession_indiv mainocc_occupation_HH worker villageid livinghome
gen year=2016
save "$wave2-_temp", replace


use"$wave3", clear
keep HHID_panel INDID_panel caste jatis age sex relationshiptohead villageid working_pop annualincome_indiv annualincome_HH mainocc_occupation_indiv mainocc_profession_indiv mainocc_occupation_HH worker villageid livinghome INDID_left
gen dummyleft=0
replace dummyleft=1 if INDID_left!=.
drop INDID_left
gen year=2020


append using "$wave1-_temp"
append using "$wave2-_temp"

sort year HHID_panel INDID_panel
order HHID_panel INDID_panel year


label define occupcode 0"No occ" 1"Agri SE" 2"Agri casual" 3"Casual" 4"Reg non-quali" 5"Reg quali" 6"SE" 7"NREGA", modify



********** Deflater les valeurs
foreach x in annualincome_indiv annualincome_HH {
clonevar `x'_raw=`x'
replace `x'=`x'/10000 if year==2010
replace `x'=(`x'*(100/158))/10000 if year==2016
replace `x'=(`x'*(100/184))/10000 if year==2020
label var `x' "₹10k "
}



********** Time for graph
gen time=0
replace time=1 if year==2010
replace time=2 if year==2016
replace time=3 if year==2020

label define time 1"2010" 2"2016-17" 3"2020-21"
label values time time 



********** Jatis et caste
tab jatis caste
label define castecat 1"Dalits" 2"Middle" 3"Upper" 77"Other", modify


save"panel_v1", replace
erase "$wave1-_temp.dta"
erase "$wave2-_temp.dta"
****************************************
* END













****************************************
* Graph bar INDID
****************************************
use"panel_v1", clear

*set graph off

********** Moc des 15-70: MALE
preserve
drop if mainocc_occupation_indiv==.
drop if working_pop==1
keep if sex==1
*
tab mainocc_occupation_indiv year, m col nofreq
*
contract mainocc_occupation_indiv year, zero freq(moc_freq) perc(moc_pc)
foreach i in 2010 2016 2020{
egen tot_`i'=sum(moc_freq) if year==`i'
replace moc_pc=moc_freq*100/tot_`i' if tot_`i'!=.
}
separate moc_pc, by(year) veryshortlabel
*
graph bar moc_pc2010 moc_pc2016 moc_pc2020, ///
over(mainocc_occupation_indiv, label(angle(45))) ///
bar(1, fcolor(plr1) lcolor(plr1)) ///
bar(2, fcolor(ply1) lcolor(ply1)) ///
bar(3, fcolor(plg1) lcolor(plg1)) ///
bargap(0) intensity(inten30) ///
blabel(bar, format(%5.1f) size(tiny)) ///
ytitle("%") ylabel() ymtick() ///
title("Male") ///
note("Occupation principale des hommes de 15-70 ans.", size(vsmall)) ///
legend(order(1 "2010" 2 "2016-17" 3 "2020-21") pos(6) col(3)) ///
name(evo_moc_1570_male, replace)
*
graph export "evo_moc_1570_male.png", replace
restore





********** Moc des 15-70: FEMALE
preserve
drop if mainocc_occupation_indiv==.
drop if working_pop==1
keep if sex==2
*
tab mainocc_occupation_indiv year, m col nofreq
*
contract mainocc_occupation_indiv year, zero freq(moc_freq) perc(moc_pc)
foreach i in 2010 2016 2020{
egen tot_`i'=sum(moc_freq) if year==`i'
replace moc_pc=moc_freq*100/tot_`i' if tot_`i'!=.
}
separate moc_pc, by(year) veryshortlabel
*
graph bar moc_pc2010 moc_pc2016 moc_pc2020, ///
over(mainocc_occupation_indiv, label(angle(45))) ///
bar(1, fcolor(plr1) lcolor(plr1)) ///
bar(2, fcolor(ply1) lcolor(ply1)) ///
bar(3, fcolor(plg1) lcolor(plg1)) ///
bargap(0) intensity(inten30) ///
blabel(bar, format(%5.1f) size(tiny)) ///
ytitle("%") ylabel() ymtick() ///
title("Female") ///
note("Occupation principale des femmes de 15-70 ans.", size(vsmall)) ///
legend(order(1 "2010" 2 "2016-17" 3 "2020-21") pos(6) col(3)) ///
name(evo_moc_1570_female, replace)
*
graph export "evo_moc_1570_female.png", replace
restore








********** Moc de ceux qui sont occupés: MALE
preserve
drop if mainocc_occupation_indiv==.
drop if working_pop==1
drop if working_pop==2
keep if sex==1
*
tab mainocc_occupation_indiv year, m col nofreq
*
contract mainocc_occupation_indiv year, zero freq(moc_freq) perc(moc_pc)
foreach i in 2010 2016 2020{
egen tot_`i'=sum(moc_freq) if year==`i'
replace moc_pc=moc_freq*100/tot_`i' if tot_`i'!=.
}
separate moc_pc, by(year) veryshortlabel
*
graph bar moc_pc2010 moc_pc2016 moc_pc2020, ///
over(mainocc_occupation_indiv, label(angle(45))) ///
bar(1, fcolor(plr1) lcolor(plr1)) ///
bar(2, fcolor(ply1) lcolor(ply1)) ///
bar(3, fcolor(plg1) lcolor(plg1)) ///
bargap(0) intensity(inten30) ///
blabel(bar, format(%5.1f) size(tiny)) ///
ytitle("%") ylabel() ymtick() ///
title("Male") ///
note("Occupation principale des hommes occupés de 15-70 ans.", size(vsmall)) ///
legend(order(1 "2010" 2 "2016-17" 3 "2020-21") pos(6) col(3)) ///
name(evo_moc_1570act_male, replace)
*
graph export "evo_moc_1570act_male.png", replace
restore






********** Moc de ceux qui sont occupés: FEMALE
preserve
drop if mainocc_occupation_indiv==.
drop if working_pop==1
drop if working_pop==2
keep if sex==2
drop if mainocc_occupation_indiv==0
*
tab mainocc_occupation_indiv year, m col nofreq
*
contract mainocc_occupation_indiv year, zero freq(moc_freq) perc(moc_pc)
foreach i in 2010 2016 2020{
egen tot_`i'=sum(moc_freq) if year==`i'
replace moc_pc=moc_freq*100/tot_`i' if tot_`i'!=.
}
separate moc_pc, by(year) veryshortlabel
*
graph bar moc_pc2010 moc_pc2016 moc_pc2020, ///
over(mainocc_occupation_indiv, label(angle(45))) ///
bar(1, fcolor(plr1) lcolor(plr1)) ///
bar(2, fcolor(ply1) lcolor(ply1)) ///
bar(3, fcolor(plg1) lcolor(plg1)) ///
bargap(0) intensity(inten30) ///
blabel(bar, format(%5.1f) size(tiny)) ///
ytitle("%") ylabel() ymtick() ///
title("Female") ///
note("Occupation principale des femmes occupées de 15-70 ans.", size(vsmall)) ///
legend(order(1 "2010" 2 "2016-17" 3 "2020-21") pos(6) col(3)) ///
name(evo_moc_1570act_female, replace)
*
graph export "evo_moc_1570act_female.png", replace
restore
****************************************
* END













****************************************
* STRIP INDID
****************************************
use"panel_v1", clear

********** Income des INDID
drop if mainocc_occupation_indiv==.
drop if working_pop==1
drop if working_pop==2
tabstat annualincome_indiv, stat(n mean sd p50 p90 p95 p99)
drop if annualincome_indiv>15

***** Male
preserve
keep if sex==1
*
stripplot annualincome_indiv, over(time) separate(sex) ///
cumul cumprob box centre refline vertical /// 
xsize(3) xtitle("") xlabel(,angle())  ///
ylabel() ymtick() ytitle() ///
title("Male") ///
note("Échelle: individu, homme.", size(vsmall)) ///
msymbol(oh) mcolor(plr1) name(inc_indiv_male, replace)
graph export "inc_indiv_male.png", replace
restore


***** Female
preserve
keep if sex==2
*
stripplot annualincome_indiv, over(time) separate(sex) ///
cumul cumprob box centre refline vertical /// 
xsize(3) xtitle("") xlabel(,angle())  ///
ylabel() ymtick() ytitle() ///
title("Female") ///
note("Échelle: individu, femme.", size(vsmall)) ///
msymbol(oh) mcolor(ply1) name(inc_indiv_female, replace)
graph export "inc_indiv_female.png", replace
restore
****************************************
* END








****************************************
* Graph bar HH
****************************************
use"panel_v1", clear


********** Income des HH
duplicates drop HHID_panel year, force
drop if mainocc_occupation_HH==.
drop if annualincome_HH>=50

***** Dalits
preserve
keep if caste==1
*
stripplot annualincome_HH if annualincome_HH<50, over(time) separate(caste) ///
cumul cumprob box centre refline vertical /// 
xsize(3) xtitle("") xlabel(,angle())  ///
ylabel() ymtick() ytitle() ///
title("Dalits") ///
note("Revenus des ménages Dalits.", size(vsmall)) ///
msymbol(oh oh oh oh) mcolor(plr1 plg1 ply1 plb1) name(inc_HH_dalits, replace)
graph export "inc_hh500k_dalits.png", replace
restore


***** Middle
preserve
keep if caste==2
*
stripplot annualincome_HH if annualincome_HH<50, over(time) separate(caste) ///
cumul cumprob box centre refline vertical /// 
xsize(3) xtitle("") xlabel(,angle())  ///
ylabel() ymtick() ytitle() ///
title("Middle") ///
note("Revenus des ménages Middle.", size(vsmall)) ///
msymbol(oh oh oh oh) mcolor(plg1 plg1 ply1 plb1) name(inc_HH_middle, replace)
graph export "inc_hh500k_middle.png", replace
restore


***** Upper
preserve
keep if caste==3
*
stripplot annualincome_HH if annualincome_HH<50, over(time) separate(caste) ///
cumul cumprob box centre refline vertical /// 
xsize(3) xtitle("") xlabel(,angle())  ///
ylabel() ymtick() ytitle() ///
title("Upper") ///
note("Revenus des ménages Upper.", size(vsmall)) ///
msymbol(oh oh oh oh) mcolor(ply1 plg1 ply1 plb1) name(inc_HH_upper, replace)
graph export "inc_hh500k_upper.png", replace
restore

****************************************
* END
