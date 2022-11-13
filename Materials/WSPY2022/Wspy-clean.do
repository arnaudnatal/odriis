*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 23, 2021
*-----
gl link = "psychodebt"
*Stab
*-----
do "https://raw.githubusercontent.com/arnaudnatal/odriis/main/Materials/WSPY2022/WSPY22.do"
*-------------------------


*ssc install glcurve




****************************************
* Wave 1
***************************************
use"$wave1", clear

********** Add panel id
merge m:m HHID2010 using "ODRIIS-HH_wide", keepusing(HHID_panel)
drop if _merge==2
drop _merge

merge 1:m HHID2010 INDID2010 using "ODRIIS-indiv_wide", keepusing(INDID_panel)
drop if _merge==2
drop _merge
order HHID2010 HHID_panel INDID2010 INDID_panel


********** Add income
merge 1:1 HHID2010 INDID2010 using "RUME-occup_indiv"
drop _merge

merge m:1 HHID2010 using "RUME-occup_HH"
drop _merge

********** Add assets
merge m:1 HHID2010 using "RUME-assets"
drop _merge


********** Keep var
fre livinghome
drop if livinghome==0

keep HHID_panel INDID_panel name village villagearea mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv incomeagri_indiv incomenonagri_indiv shareincomeagri_indiv shareincomenonagri_indiv incomeagri_HH incomenonagri_HH annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop working_pop dummyworkedpastyear

merge 1:1 HHID_panel INDID_panel using "ODRIIS-indiv_wide", keepusing(castecorr2010 agecorr2010 sex2010 relationshiptohead2010)
keep if _merge==3
drop _merge
rename sex2010 sex
rename agecorr2010 age
rename relationshiptohead2010 relationshiptohead
rename castecorr2010 caste
gen year=2010

order HHID_panel INDID_panel year name age sex relationshiptohead caste village villagearea

rename village villageid

save"wave1", replace
****************************************
* END







****************************************
* Wave 2
***************************************
use"$wave2", clear


********** Add panel id
merge m:m HHID2016 using "ODRIIS-HH_wide", keepusing(HHID_panel)
drop if _merge==2
drop _merge

tostring INDID2016, replace
merge 1:m HHID2016 INDID2016 using "ODRIIS-indiv_wide", keepusing(INDID_panel)
drop if _merge==2
drop _merge
order HHID2016 HHID_panel INDID2016 INDID_panel


********** Add income
destring INDID2016, replace
merge 1:1 HHID2016 INDID2016 using "NEEMSIS1-occup_indiv"
drop _merge

merge m:1 HHID2016 using "NEEMSIS1-occup_HH"
drop _merge

********** Add assets
merge m:1 HHID2016 using "NEEMSIS1-assets"
drop _merge


********** Keep var
fre livinghome
drop if livinghome==3 | livinghome==4

keep HHID_panel INDID_panel name villageid villagearea mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv incomeagri_indiv incomenonagri_indiv shareincomeagri_indiv shareincomenonagri_indiv incomeagri_HH incomenonagri_HH annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop working_pop dummyworkedpastyear

merge 1:1 HHID_panel INDID_panel using "ODRIIS-indiv_wide", keepusing(castecorr2016 agecorr2016 sex2016 relationshiptohead2016)
keep if _merge==3
drop _merge
rename sex2016 sex
rename agecorr2016 age
rename relationshiptohead2016 relationshiptohead
rename castecorr2016 caste
gen year=2016

order HHID_panel INDID_panel year name age sex relationshiptohead caste villageid villagearea


save"wave2", replace
****************************************
* END








****************************************
* Wave 3
***************************************
use"$wave3", clear

********** Add panel id
merge m:m HHID2020 using "ODRIIS-HH_wide", keepusing(HHID_panel)
drop if _merge==2
drop _merge

tostring INDID2020, replace
merge 1:m HHID2020 INDID2020 using "ODRIIS-indiv_wide", keepusing(INDID_panel)
drop if _merge==2
drop _merge
order HHID2020 HHID_panel INDID2020 INDID_panel


********** Add income
destring INDID2020, replace
merge 1:1 HHID2020 INDID2020 using "NEEMSIS2-occup_indiv"
drop _merge

merge m:1 HHID2020 using "NEEMSIS2-occup_HH"
drop _merge

********** Add assets
merge m:1 HHID2020 using "NEEMSIS2-assets"
drop _merge


********** Keep var
fre livinghome
drop if livinghome==3 | livinghome==4
drop if dummylefthousehold==1

keep HHID_panel INDID_panel name villageid villagearea mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv incomeagri_indiv incomenonagri_indiv shareincomeagri_indiv shareincomenonagri_indiv incomeagri_HH incomenonagri_HH annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop working_pop dummyworkedpastyear

merge 1:1 HHID_panel INDID_panel using "ODRIIS-indiv_wide", keepusing(castecorr2020 agecorr2020 sex2020 relationshiptohead2020)
keep if _merge==3
drop _merge
rename sex2020 sex
rename agecorr2020 age
rename relationshiptohead2020 relationshiptohead
rename castecorr2020 caste
gen year=2020

order HHID_panel INDID_panel year name age sex relationshiptohead caste villageid villagearea


save"wave3", replace
****************************************
* END









****************************************
* Panel
***************************************
use"wave1", clear

append using "wave2"
append using "wave3"

*Deflate
foreach x in mainocc_annualincome_indiv annualincome_indiv incomeagri_indiv incomenonagri_indiv incomeagri_HH incomenonagri_HH annualincome_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop{
replace `x'=`x'*(100/158) if year==2016
replace `x'=`x'*(100/184) if year==2020
}
save"panel_indiv", replace

keep HHID_panel year caste villageid villagearea incomeagri_HH incomenonagri_HH annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop
duplicates drop
ta year

save"panel_HH", replace
****************************************
* END






****************************************
* Ineq at indiv level
***************************************
use"panel_indiv", clear

sort HHID_panel INDID_panel year

* Kernel
twoway ///
(kdensity annualincome_indiv if year==2010, bwidth(20000)) ///
(kdensity annualincome_indiv if year==2016, bwidth(20000)) ///
(kdensity annualincome_indiv if year==2020, bwidth(20000))

* CV
tabstat annualincome_indiv, stat(n mean sd q cv) by(year)



****************************************
* END







****************************************
* Ineq at HH level
***************************************
use"panel_HH", clear

sort HHID_panel year

* Kernel
twoway ///
(kdensity annualincome_HH if year==2010, bwidth(20000)) ///
(kdensity annualincome_HH if year==2016, bwidth(20000)) ///
(kdensity annualincome_HH if year==2020, bwidth(20000))

mean shareincomeagri_HH shareincomenonagri_HH, over(year)
/*
Diminution de la part des rev agri dans le temps (plus de 20 pts de pource)
Ménages ruraux deviennent de moins en moins dep des activités agricoles
Monter en puissance des acti non agri
On va aller plus précis avec les non agri
*/


* CV
tabstat annualincome_HH, stat(n mean sd q cv) by(year)




* Lorenz
glcurve annualincome_HH, lorenz by(year) split






****************************************
* END








