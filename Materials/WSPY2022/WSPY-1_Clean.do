*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 23, 2021
*-----
*WSPY 2022
*-----
do "https://raw.githubusercontent.com/arnaudnatal/odriis/main/Materials/WSPY2022/_WSPY22.do"
*-------------------------


*ssc install glcurve
*ssc install lorenz
*ssc install ginidesc



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

rename village villageid


********** Keep var
fre livinghome
drop if livinghome==0

keep HHID_panel INDID_panel name villageid villagearea mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv shareincomeagri_indiv shareincomenonagri_indiv annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop working_pop dummyworkedpastyear shareincagrise_indiv shareincagricasual_indiv shareincnonagricasual_indiv shareincnonagriregnonquali_indiv shareincnonagriregquali_indiv shareincnonagrise_indiv shareincnrega_indiv shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH incomeagri_indiv incomenonagri_indiv incagrise_indiv incagricasual_indiv incnonagricasual_indiv incnonagriregnonquali_indiv incnonagriregquali_indiv incnonagrise_indiv incnrega_indiv

merge 1:1 HHID_panel INDID_panel using "ODRIIS-indiv_wide", keepusing(castecorr2010 agecorr2010 sex2010 relationshiptohead2010)
keep if _merge==3
drop _merge
rename sex2010 sex
rename agecorr2010 age
rename relationshiptohead2010 relationshiptohead
rename castecorr2010 caste
gen year=2010

order HHID_panel INDID_panel year name age sex relationshiptohead caste villageid villagearea

fre villageid

recode villageid (6=7) (7=6)

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

keep HHID_panel INDID_panel name villageid villagearea mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv shareincomeagri_indiv shareincomenonagri_indiv annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop working_pop dummyworkedpastyear shareincagrise_indiv shareincagricasual_indiv shareincnonagricasual_indiv shareincnonagriregnonquali_indiv shareincnonagriregquali_indiv shareincnonagrise_indiv shareincnrega_indiv shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH incomeagri_indiv incomenonagri_indiv incagrise_indiv incagricasual_indiv incnonagricasual_indiv incnonagriregnonquali_indiv incnonagriregquali_indiv incnonagrise_indiv incnrega_indiv

merge 1:1 HHID_panel INDID_panel using "ODRIIS-indiv_wide", keepusing(castecorr2016 agecorr2016 sex2016 relationshiptohead2016)
keep if _merge==3
drop _merge
rename sex2016 sex
rename agecorr2016 age
rename relationshiptohead2016 relationshiptohead
rename castecorr2016 caste
gen year=2016

order HHID_panel INDID_panel year name age sex relationshiptohead caste villageid villagearea

fre villageid


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

keep HHID_panel INDID_panel name villageid villagearea mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv shareincomeagri_indiv shareincomenonagri_indiv annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop working_pop dummyworkedpastyear shareincagrise_indiv shareincagricasual_indiv shareincnonagricasual_indiv shareincnonagriregnonquali_indiv shareincnonagriregquali_indiv shareincnonagrise_indiv shareincnrega_indiv shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH incomeagri_indiv incomenonagri_indiv incagrise_indiv incagricasual_indiv incnonagricasual_indiv incnonagriregnonquali_indiv incnonagriregquali_indiv incnonagrise_indiv incnrega_indiv

merge 1:1 HHID_panel INDID_panel using "ODRIIS-indiv_wide", keepusing(castecorr2020 agecorr2020 sex2020 relationshiptohead2020)
keep if _merge==3
drop _merge
rename sex2020 sex
rename agecorr2020 age
rename relationshiptohead2020 relationshiptohead
rename castecorr2020 caste
gen year=2020

order HHID_panel INDID_panel year name age sex relationshiptohead caste villageid villagearea

fre villageid

save"wave3", replace
****************************************
* END









****************************************
* Panel
***************************************
use"wave2", clear


********** Indiv
append using "wave1"
append using "wave3"

*Deflate
foreach x in mainocc_annualincome_indiv annualincome_indiv annualincome_HH assets assets_noland assets_noprop assets1000 assets1000_noland incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH assets1000_noprop{
replace `x'=`x'*(100/158) if year==2016
replace `x'=`x'*(100/184) if year==2020
}

replace caste="1" if caste=="Dalits"
replace caste="2" if caste=="Middle"
replace caste="3" if caste=="Upper"
destring caste, replace
label define caste 1"Dalits" 2"Middle" 3"Upper"
label values caste caste

replace sex="1" if sex=="Male"
replace sex="2" if sex=="Female"
destring sex, replace
label define sex 1"Male" 2"Female"
label values sex sex

*1000
gen annualincome1000_HH=annualincome_HH/1000
gen annualincome1000_indiv=annualincome_indiv/1000

* Recode
replace year=1 if year==2010
replace year=2 if year==2016
replace year=3 if year==2020
sort HHID_panel year

save"panel_indiv_long", replace

preserve
drop incomeagri_HH incomenonagri_HH annualincome_HH shareincomeagri_HH shareincomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop annualincome1000_HH

foreach x in mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv incomeagri_indiv incomenonagri_indiv shareincomeagri_indiv shareincomenonagri_indiv incagrise_indiv incagricasual_indiv incnonagricasual_indiv incnonagriregnonquali_indiv incnonagriregquali_indiv incnonagrise_indiv incnrega_indiv shareincagrise_indiv shareincagricasual_indiv shareincnonagricasual_indiv shareincnonagriregnonquali_indiv shareincnonagriregquali_indiv shareincnonagrise_indiv shareincnrega_indiv annualincome1000_indiv {
local new=substr("`x'",1,strlen("`x'")-3)
rename `x' `new'
}

reshape wide name age sex relationshiptohead caste villageid villagearea dummyworkedpastyear working_pop mainocc_profession_in mainocc_occupation_in mainocc_sector_in mainocc_annualincome_in mainocc_occupationname_in annualincome_in nboccupation_in incomeagri_in incomenonagri_in shareincomeagri_in shareincomenonagri_in incagrise_in incagricasual_in incnonagricasual_in incnonagriregnonquali_in incnonagriregquali_in incnonagrise_in incnrega_in shareincagrise_in shareincagricasual_in shareincnonagricasual_in shareincnonagriregnonquali_in shareincnonagriregquali_in shareincnonagrise_in shareincnrega_in annualincome1000_in, i(HHID_panel INDID_panel) j(year)

foreach x in name relationshiptohead {
gen `x'=""
replace `x'=`x'1 if `x'=="" & `x'1!=""
replace `x'=`x'2 if `x'=="" & `x'2!=""
replace `x'=`x'3 if `x'=="" & `x'3!=""
}
foreach x in caste villageid villagearea sex{
gen `x'=.
replace `x'=`x'1 if `x'==. & `x'1!=.
replace `x'=`x'2 if `x'==. & `x'2!=.
replace `x'=`x'3 if `x'==. & `x'3!=.
}
destring age1 age2 age3, replace
gen age=.
replace age=age1 if age==. & age1!=.
replace age=age2-6 if age==. & age2!=.
replace age=age3-10 if age==. & age3!=.


label values sex sex

order HHID_panel INDID_panel name age sex relationshiptohead caste villageid villagearea

label values caste caste
label values villageid villageid
label values villagearea area2

drop age1 age2 age3 name1 name2 name3 sex1 sex2 sex3 relationshiptohead1 relationshiptohead2 relationshiptohead3 caste1 caste2 caste3 villageid1 villageid2 villageid3 villagearea1 villagearea2 villagearea3

save"panel_indiv_wide", replace
restore


********** HH

keep HHID_panel year caste villageid villagearea annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH annualincome1000_HH
duplicates drop
ta year


*** Reshape
reshape wide villageid annualincome_HH shareincomeagri_HH shareincomenonagri_HH shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop annualincome1000_HH incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH, i(HHID_panel) j(year)

order HHID_panel caste villageid1 villageid2 villageid3
gen villageid=.
replace villageid=villageid1 if villageid==. & villageid1!=.
replace villageid=villageid2 if villageid==. & villageid2!=.
replace villageid=villageid3 if villageid==. & villageid3!=.
label values villageid villageid
order HHID_panel caste villageid villageid1 villageid2 villageid3
sort villageid HHID_panel
drop villageid1 villageid2 villageid3


save"panel_HH_wide", replace
****************************************
* END
