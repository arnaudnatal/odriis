*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*November 14, 2022
*-----
*WSPY 2022
*-----
do "https://raw.githubusercontent.com/arnaudnatal/odriis/main/Materials/WSPY2022/_WSPY22.do"
*-------------------------


*net install rqdeco, from("https://raw.githubusercontent.com/bmelly/Stata/main/")



****************************************
* Wave 1
***************************************
use"raw\\$wave1", clear

********** Add panel id
merge m:m HHID2010 using "raw\ODRIIS-HH_wide", keepusing(HHID_panel)
drop if _merge==2
drop _merge

merge 1:m HHID2010 INDID2010 using "raw\ODRIIS-indiv_wide", keepusing(INDID_panel)
drop if _merge==2
drop _merge
order HHID2010 HHID_panel INDID2010 INDID_panel


********** Add income
merge 1:1 HHID2010 INDID2010 using "raw\RUME-occup_indiv"
drop _merge

merge m:1 HHID2010 using "raw\RUME-occup_HH"
drop _merge

********** Add assets
merge m:1 HHID2010 using "raw\RUME-assets"
drop _merge

rename village villageid


********** Add transferts
merge m:1 HHID2010 using "raw\RUME-transferts_HH", keepusing(remittnet_HH)
drop _merge

********** Keep var
fre livinghome
drop if livinghome==0

keep HHID_panel INDID_panel name villageid villagearea mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv shareincomeagri_indiv shareincomenonagri_indiv annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop working_pop dummyworkedpastyear shareincagrise_indiv shareincagricasual_indiv shareincnonagricasual_indiv shareincnonagriregnonquali_indiv shareincnonagriregquali_indiv shareincnonagrise_indiv shareincnrega_indiv shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH incomeagri_indiv incomenonagri_indiv incagrise_indiv incagricasual_indiv incnonagricasual_indiv incnonagriregnonquali_indiv incnonagriregquali_indiv incnonagrise_indiv incnrega_indiv remittnet_HH

merge 1:1 HHID_panel INDID_panel using "raw\ODRIIS-indiv_wide", keepusing(castecorr2010 agecorr2010 sex2010 relationshiptohead2010)
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

bysort HHID_panel: egen size_HH=sum(1)

save"_temp\wave1", replace
****************************************
* END







****************************************
* Wave 2
***************************************
use"raw\\$wave2", clear


********** Add panel id
merge m:m HHID2016 using "raw\ODRIIS-HH_wide", keepusing(HHID_panel)
drop if _merge==2
drop _merge

tostring INDID2016, replace
merge 1:m HHID2016 INDID2016 using "raw\ODRIIS-indiv_wide", keepusing(INDID_panel)
drop if _merge==2
drop _merge
order HHID2016 HHID_panel INDID2016 INDID_panel


********** Add income
destring INDID2016, replace
merge 1:1 HHID2016 INDID2016 using "raw\NEEMSIS1-occup_indiv"
drop _merge

merge m:1 HHID2016 using "raw\NEEMSIS1-occup_HH"
drop _merge

********** Add assets
merge m:1 HHID2016 using "raw\NEEMSIS1-assets"
drop _merge


********** Add transferts
merge m:1 HHID2016 using "raw\NEEMSIS1-transferts_HH", keepusing(transferts_HH remittnet_HH)
drop _merge

********** Keep var
fre livinghome
drop if livinghome==3 | livinghome==4

keep HHID_panel INDID_panel name villageid villagearea mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv shareincomeagri_indiv shareincomenonagri_indiv annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop working_pop dummyworkedpastyear shareincagrise_indiv shareincagricasual_indiv shareincnonagricasual_indiv shareincnonagriregnonquali_indiv shareincnonagriregquali_indiv shareincnonagrise_indiv shareincnrega_indiv shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH incomeagri_indiv incomenonagri_indiv incagrise_indiv incagricasual_indiv incnonagricasual_indiv incnonagriregnonquali_indiv incnonagriregquali_indiv incnonagrise_indiv incnrega_indiv transferts_HH remittnet_HH

merge 1:1 HHID_panel INDID_panel using "raw\ODRIIS-indiv_wide", keepusing(castecorr2016 agecorr2016 sex2016 relationshiptohead2016)
keep if _merge==3
drop _merge
rename sex2016 sex
rename agecorr2016 age
rename relationshiptohead2016 relationshiptohead
rename castecorr2016 caste
gen year=2016

order HHID_panel INDID_panel year name age sex relationshiptohead caste villageid villagearea

fre villageid

bysort HHID_panel: egen size_HH=sum(1)

save"_temp\wave2", replace
****************************************
* END








****************************************
* Wave 3
***************************************
use"raw\\$wave3", clear

********** Add panel id
merge m:m HHID2020 using "raw\ODRIIS-HH_wide", keepusing(HHID_panel)
drop if _merge==2
drop _merge

tostring INDID2020, replace
merge 1:m HHID2020 INDID2020 using "raw\ODRIIS-indiv_wide", keepusing(INDID_panel)
drop if _merge==2
drop _merge
order HHID2020 HHID_panel INDID2020 INDID_panel


********** Add income
destring INDID2020, replace
merge 1:1 HHID2020 INDID2020 using "raw\NEEMSIS2-occup_indiv"
drop _merge

merge m:1 HHID2020 using "raw\NEEMSIS2-occup_HH"
drop _merge

********** Add assets
merge m:1 HHID2020 using "raw\NEEMSIS2-assets"
drop _merge

********** Add transferts
merge m:1 HHID2020 using "raw\NEEMSIS2-transferts_HH", keepusing(transferts_HH remittnet_HH)
drop _merge



********** Add edcuation and Big-5
merge 1:1 HHID2020 INDID2020 using "raw\NEEMSIS2-education"
drop _merge

merge 1:1 HHID2020 INDID2020 using "raw\NEEMSIS2-ptcs"
drop _merge


********** Keep var
fre livinghome
drop if livinghome==3 | livinghome==4
drop if dummylefthousehold==1

keep HHID_panel INDID_panel egoid name villageid villagearea mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv shareincomeagri_indiv shareincomenonagri_indiv annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop working_pop dummyworkedpastyear shareincagrise_indiv shareincagricasual_indiv shareincnonagricasual_indiv shareincnonagriregnonquali_indiv shareincnonagriregquali_indiv shareincnonagrise_indiv shareincnrega_indiv shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH incomeagri_indiv incomenonagri_indiv incagrise_indiv incagricasual_indiv incnonagricasual_indiv incnonagriregnonquali_indiv incnonagriregquali_indiv incnonagrise_indiv incnrega_indiv mainocc_tenureday_indiv cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit locus raven_tt num_tt lit_tt edulevel maritalstatus transferts_HH remittnet_HH

merge 1:1 HHID_panel INDID_panel using "raw\ODRIIS-indiv_wide", keepusing(castecorr2020 agecorr2020 sex2020 relationshiptohead2020)
keep if _merge==3
drop _merge
rename sex2020 sex
rename agecorr2020 age
rename relationshiptohead2020 relationshiptohead
rename castecorr2020 caste
gen year=2020

order HHID_panel INDID_panel year name age sex relationshiptohead caste villageid villagearea

fre villageid

bysort HHID_panel: egen size_HH=sum(1)

save"wave3", replace
****************************************
* END









****************************************
* Panel
***************************************
use"_temp\wave2", clear


********** Indiv
append using "_temp\wave1"
append using "wave3"

drop egoid

*Deflate
foreach x in mainocc_annualincome_indiv annualincome_indiv annualincome_HH assets assets_noland assets_noprop assets1000 assets1000_noland incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH assets1000_noprop transferts_HH remittnet_HH{
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
*replace year=1 if year==2010
*replace year=2 if year==2016
*replace year=3 if year==2020
sort HHID_panel year


*Monthly income
gen monthlyincome_indiv=annualincome_indiv/12
gen monthlyincome_HH=annualincome_HH/12

*Totalincome
gen totinc_HH=annualincome_HH+remittnet_HH
gen totincbis_HH=annualincome_HH+transferts_HH

gen monthlytotinc_HH=totinc_HH/12
gen monthlytotincbis_HH=totincbis_HH/12

*Drop ceux qui n'ont pas de revenus
ta dummyworkedpastyear year, m
ta monthlyincome_indiv dummyworkedpastyear if year==2010, m
ta monthlyincome_indiv dummyworkedpastyear if year==2016, m
ta monthlyincome_indiv dummyworkedpastyear if year==2020, m

drop dummyworkedpastyear
drop if monthlyincome_indiv==0
drop if monthlyincome_indiv==.

save"panel_indiv_long", replace


preserve
drop incomeagri_HH incomenonagri_HH annualincome_HH shareincomeagri_HH shareincomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH nbworker_HH nbnonworker_HH remittnet_HH transferts_HH annualincome1000_HH monthlyincome_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop size_HH totinc_HH totincbis_HH monthlytotinc_HH monthlytotincbis_HH

foreach x in mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv incomeagri_indiv incomenonagri_indiv shareincomeagri_indiv shareincomenonagri_indiv incagrise_indiv incagricasual_indiv incnonagricasual_indiv incnonagriregnonquali_indiv incnonagriregquali_indiv incnonagrise_indiv incnrega_indiv shareincagrise_indiv shareincagricasual_indiv shareincnonagricasual_indiv shareincnonagriregnonquali_indiv shareincnonagriregquali_indiv shareincnonagrise_indiv shareincnrega_indiv mainocc_tenureday_indiv annualincome1000_indiv monthlyincome_indiv {
local new=substr("`x'",1,strlen("`x'")-6)
rename `x' `new'
}

reshape wide name age sex relationshiptohead caste villageid villagearea working_pop mainocc_profession mainocc_occupation mainocc_sector mainocc_annualincome mainocc_occupationname annualincome nboccupation incomeagri incomenonagri shareincomeagri shareincomenonagri incagrise incagricasual incnonagricasual incnonagriregnonquali incnonagriregquali incnonagrise incnrega shareincagrise shareincagricasual shareincnonagricasual shareincnonagriregnonquali shareincnonagriregquali shareincnonagrise shareincnrega maritalstatus mainocc_tenureday edulevel raven_tt num_tt lit_tt cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit locus annualincome1000 monthlyincome, i(HHID_panel INDID_panel) j(year)

foreach x in name relationshiptohead {
gen `x'=""
replace `x'=`x'2010 if `x'=="" & `x'2010!=""
replace `x'=`x'2016 if `x'=="" & `x'2016!=""
replace `x'=`x'2020 if `x'=="" & `x'2020!=""
}
foreach x in caste villageid villagearea sex{
gen `x'=.
replace `x'=`x'2010 if `x'==. & `x'2010!=.
replace `x'=`x'2016 if `x'==. & `x'2016!=.
replace `x'=`x'2020 if `x'==. & `x'2020!=.
}
destring age2010 age2016 age2020, replace
gen age=.
replace age=age2010 if age==. & age2010!=.
replace age=age2016-6 if age==. & age2016!=.
replace age=age2020-10 if age==. & age2020!=.


label values sex sex

order HHID_panel INDID_panel name age sex relationshiptohead caste villageid villagearea

label values caste caste
label values villageid villageid
label values villagearea area2

drop age2010 age2016 age2020 name2010 name2016 name2020 sex2010 sex2016 sex2020 relationshiptohead2010 relationshiptohead2016 relationshiptohead2020 caste2010 caste2016 caste2020 villageid2010 villageid2016 villageid2020 villagearea2010 villagearea2016 villagearea2020 

save"panel_indiv_wide", replace
restore


********** HH

keep HHID_panel year caste villageid villagearea assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop incomeagri_HH incomenonagri_HH annualincome_HH shareincomeagri_HH shareincomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH nbworker_HH nbnonworker_HH remittnet_HH transferts_HH annualincome1000_HH monthlyincome_HH size_HH totinc_HH totincbis_HH monthlytotinc_HH monthlytotincbis_HH
duplicates drop
ta year


foreach x in incomeagri_HH incomenonagri_HH annualincome_HH shareincomeagri_HH shareincomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH nbworker_HH nbnonworker_HH remittnet_HH transferts_HH annualincome1000_HH monthlyincome_HH totinc_HH totincbis_HH monthlytotinc_HH monthlytotincbis_HH {
local new=substr("`x'",1,strlen("`x'")-3)
rename `x' `new'
}

save"panel_HH_long", replace


*** Reshape
reshape wide villageid villagearea incomeagri incomenonagri annualincome shareincomeagri shareincomenonagri incagrise incagricasual incnonagricasual incnonagriregnonquali incnonagriregquali incnonagrise incnrega shareincagrise shareincagricasual shareincnonagricasual shareincnonagriregnonquali shareincnonagriregquali shareincnonagrise shareincnrega nbworker nbnonworker assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop remittnet transferts size_HH annualincome1000 monthlyincome totinc totincbis monthlytotinc monthlytotincbis, i(HHID_panel) j(year)

order HHID_panel caste villageid2010 villageid2016 villageid2020
gen villageid=.
replace villageid=villageid2010 if villageid==. & villageid2010!=.
replace villageid=villageid2016 if villageid==. & villageid2016!=.
replace villageid=villageid2020 if villageid==. & villageid2020!=.
label values villageid villageid
order HHID_panel caste villageid villageid2010 villageid2016 villageid2020
sort villageid HHID_panel
drop villageid2010 villageid2016 villageid2020

save"panel_HH_wide", replace
****************************************
* END
