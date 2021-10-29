* Création du nouvel identifiant harmonisé entre les vagues 2010, 2016 et 2020
use "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\NEEMSIS-HH-new-villages-INDID1.dta" 
append using "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\lost_HH2016.dta"
replace villageid=1 if villageid_str=="ELA"
replace villageid=2 if villageid_str=="GOV"
replace villageid=3 if villageid_str=="KAR"
replace villageid=5 if villageid_str=="KUV"
replace villageid=6 if villageid_str=="MAN"
replace villageid=7 if villageid_str=="MANAM"
replace villageid=9 if villageid_str=="ORA"
sort villageid
by villageid : gen n1=_n
decode villageid, gen(villageid_lab)
replace villageid_lab=villageid_str if villageid_lab=="."
replace villageid_lab=villageid_str if villageid_lab==""
egen HHID_panel=concat(villageid_lab n1)
keep villageid villageareaid HHID HHID2010 dummynewHH dummydemonetisation INDID INDID2010 egoid name householdid interviewplace address caste numfamily HHID_panel villageid_lab n1 villageid_str tracked villageid_new_comments villageid_new username
gen dummyHHlost2016=1 if villageid_str!=""
replace dummyHHlost2016=0 if dummyHHlost2016==.
tab dummyHHlost2016
merge m:1 HHID using "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\newHH2016.dta"
gen householdid2020=householdid
replace householdid2020= value_householdid_2020 if value_householdid_2020!=.
drop _merge
save "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\unique_identifier_panel.dta", replace
label variable villageid "Village name"
label variable villageid "Original village name"
label variable villageareaid "Original village area"
label variable HHID "PARENT_KEY : Identifier 2016 from SurveyCTO"
label variable HHID2010 "Identifier from 2010"
label variable dummynewHH "New household for NEEMSIS 1 in 2016"
label variable dummydemonetisation "Household surveyed during demonetisation"
label variable dummydemonetisation "Household surveyed after the demonetisation"
label variable INDID "Individual identifier in 2016 for NEEMSIS 1"
label variable INDID2010 "Individual identifier in 2010 for RUME"
label variable villageid "Original village name in RUME"
label variable villageareaid "Original village area in RUME"
label variable HHID "PARENT_KEY : Identifier 2016 in NEEMSIS 1 from SurveyCTO"
label variable HHID2010 "Household identifier for 2010 in RUME"
label variable egoid "Ego identifier for NEEMSIS 1 in 2016"
label variable name "Name "
label variable householdid `"Number associated to the "hhmemberlist" on SurveyCTO for NEEMSIS 1 in 2016"'
label variable interviewplace "Place of interview in 2016"
label variable numfamily "Number of members in the household"
label variable username "Name of the enumerator in 2016 for NEEMSIS 1"
label variable villageid_str ""
label variable villageid_lab "Village Name"
label variable HHID_panel "Unique harmonized household identifier for LAKSMI"
label variable dummyHHlost2016 "Dummy household lost between 2010 and 2016"
label variable value_householdid_2020 `"New value for the "hhhead" in SurveyCTO for the new households"'
label variable householdid2020 `"Value of the "hhhead" list in SurveyCTO in 2020 for NEEMSIS 2"'
label variable householdid `"Value associated to the "hhhead" in SurveyCTO for NEEMSIS 1 in 2016"'
save "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\unique_identifier_panel.dta", replace
* Le nouvel identifiant est créé à partir du label du village d'origine (
* même si le ménage a migré en 2016 de façon permanente) ainsi que d'un numéro allant de 1 à n où n est le nombre de ménages dans le village.
