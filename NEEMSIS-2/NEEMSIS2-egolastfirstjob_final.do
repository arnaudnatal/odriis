*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@ifpindia.org
*October 30, 2024
*-----
*NEEMSIS-2 HH last clean
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\2020-NEEMSIS2\Data\4team"
cd"$directory"
********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid
********** Split var
do"C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2\splitvarmcq.do"
do"C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2\newn.do"
do"C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2\repmi.do"
********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020
*-------------------------











****************************************
* Merge first job in ego database
****************************************




***** Prepa 2016
use"C:\Users\Arnaud\Documents\MEGA\Data\2016-NEEMSIS1\Data\2publish\NEEMSIS1-ego", clear

merge m:m HHID2016 using "C:\Users\Arnaud\Documents\MEGA\Data\NEEMSIS-Key_panel\keypanel-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge

tostring INDID2016, replace
merge m:m HHID_panel INDID2016 using "C:\Users\Arnaud\Documents\MEGA\Data\NEEMSIS-Key_panel\keypanel-Indiv_wide", keepusing(INDID_panel)
keep if _merge==3
drop _merge
destring INDID2016, replace

keep HHID_panel INDID_panel kindofworkfirstjob unpaidinbusinessfirstjob agestartworking agestartworkingpaidjob methodfindfirstjob methodfindfirstjob_snfrie methodfindfirstjob_snrela methodfindfirstjob_snothe methodfindfirstjob_empdir methodfindfirstjob_pubage methodfindfirstjob_priage methodfindfirstjob_univer methodfindfirstjob_media methodfindfirstjob_intern methodfindfirstjob_na methodfindfirstjob_nr monthstofindjob
gen year=2016

foreach x in kindofworkfirstjob unpaidinbusinessfirstjob agestartworking agestartworkingpaidjob methodfindfirstjob methodfindfirstjob_snfrie methodfindfirstjob_snrela methodfindfirstjob_snothe methodfindfirstjob_empdir methodfindfirstjob_pubage methodfindfirstjob_priage methodfindfirstjob_univer methodfindfirstjob_media methodfindfirstjob_intern methodfindfirstjob_na methodfindfirstjob_nr monthstofindjob {
rename `x' `x'_2016
}

order HHID_panel INDID_panel year

save"_temp", replace




***** Merger 2016 avec 2020
use"Last\Lastlast\Corrected\Lastcorrection\NEEMSIS2-ego", clear

merge m:m HHID2020 using "C:\Users\Arnaud\Documents\MEGA\Data\NEEMSIS-Key_panel\keypanel-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge

tostring INDID2020, replace
merge m:m HHID_panel INDID2020 using "C:\Users\Arnaud\Documents\MEGA\Data\NEEMSIS-Key_panel\keypanel-Indiv_wide", keepusing(INDID_panel)
keep if _merge==3
drop _merge
destring INDID2020, replace

merge 1:1 HHID_panel INDID_panel using "_temp"
drop if _merge==2
drop _merge
drop year

replace kindofworkfirstjob=kindofworkfirstjob_2016 if kindofworkfirstjob==. & kindofworkfirstjob_2016!=.
replace unpaidinbusinessfirstjob=unpaidinbusinessfirstjob_2016 if unpaidinbusinessfirstjob=="" & unpaidinbusinessfirstjob_2016!=""
replace agestartworking=agestartworking_2016 if agestartworking==. & agestartworking_2016!=.
replace methodfindfirstjob=methodfindfirstjob_2016 if methodfindfirstjob=="" & methodfindfirstjob_2016!=""
replace methodfindfirstjob_snfrien=methodfindfirstjob_snfrie_2016 if methodfindfirstjob_snfrien==. & methodfindfirstjob_snfrie_2016!=.
replace methodfindfirstjob_snrelat=methodfindfirstjob_snrela_2016 if methodfindfirstjob_snrelat==. & methodfindfirstjob_snrela_2016!=.
replace methodfindfirstjob_snother=methodfindfirstjob_snothe_2016 if methodfindfirstjob_snother==. & methodfindfirstjob_snothe_2016!=.
replace methodfindfirstjob_employe=methodfindfirstjob_empdir_2016 if methodfindfirstjob_employe==. & methodfindfirstjob_empdir_2016!=.
replace methodfindfirstjob_pubagen=methodfindfirstjob_pubage_2016 if methodfindfirstjob_pubagen==. & methodfindfirstjob_pubage_2016!=.
replace methodfindfirstjob_priagen=methodfindfirstjob_priage_2016 if methodfindfirstjob_priagen==. & methodfindfirstjob_priage_2016!=.
replace methodfindfirstjob_univers=methodfindfirstjob_univer_2016 if methodfindfirstjob_univers==. & methodfindfirstjob_univer_2016!=.
replace methodfindfirstjob_medipap=methodfindfirstjob_media_2016 if methodfindfirstjob_medipap==. & methodfindfirstjob_media_2016!=.
replace methodfindfirstjob_interne=methodfindfirstjob_intern_2016 if methodfindfirstjob_interne==. & methodfindfirstjob_intern_2016!=.
replace methodfindfirstjob_66=methodfindfirstjob_na_2016 if methodfindfirstjob_66==. & methodfindfirstjob_na_2016!=.
replace methodfindfirstjob_99=methodfindfirstjob_nr_2016 if methodfindfirstjob_99==. & methodfindfirstjob_nr_2016!=.
replace monthstofindjob=monthstofindjob_2016 if monthstofindjob==. & monthstofindjob_2016!=.

drop kindofworkfirstjob_2016 unpaidinbusinessfirstjob_2016 agestartworking_2016 agestartworkingpaidjob_2016 methodfindfirstjob_2016 methodfindfirstjob_snfrie_2016 methodfindfirstjob_snrela_2016 methodfindfirstjob_snothe_2016 methodfindfirstjob_empdir_2016 methodfindfirstjob_pubage_2016 methodfindfirstjob_priage_2016 methodfindfirstjob_univer_2016 methodfindfirstjob_media_2016 methodfindfirstjob_intern_2016 methodfindfirstjob_na_2016 methodfindfirstjob_nr_2016 monthstofindjob_2016
  

* Vérifications
ta everwork // 56
ta dummyworkedpastyear  // 1281

ta kindofworkfirstjob



* Rename
rename methodfindjob_66 methodfindjob_na
rename methodfindfirstjob_66 methodfindfirstjob_na

rename reasonstoppedwagejob_77 reasonstoppedwagejob_oth
rename covdifficulties_77 covdifficulties_oth
rename businesssourceinvest_77 businesssourceinvest_oth
rename covassociationhelptype_77 covassociationhelptype_oth

rename methodfindjob_99 methodfindjob_nr
rename methodfindfirstjob_99 methodfindfirstjob_nr


* Clean
drop version_HH version_agri HHID_panel INDID_panel


save"Last\Lastlast\Corrected\Lastcorrection\Lastlastcorrection\NEEMSIS2-ego", replace
****************************************
* END
