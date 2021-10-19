cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
September 30, 2021
-----
TITLE: RUME occupation panel

-------------------------
*/

global directory = "D:\Documents\_Thesis\_DATA\RUME\"
global git ="C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"
cd "$directory"



****************************************
* RUME occupations
****************************************
use"RUME-occupations_v2.dta", clear
fre occupationtype

rename INDID2010 INDID
rename occupationtype job

**********Var
gen mainocc=.
gen mainok=0
preserve
duplicates drop HHID2010 INDID, force
tab INDID, m
*987
restore


**********Indiv
***MOC
order HHID2010 INDID 
*max income or hours (income only for 2010)
bysort HHID2010 INDID : egen maxincome_indiv=max(annualincome)
*occup name and occup type with the max
replace mainocc=1 if maxincome_indiv==annualincome
*
replace mainok=1 if mainocc!=.
bysort HHID2010 INDID: egen mainok_indiv=sum(mainok)
preserve
duplicates drop HHID2010 INDID, force
tab mainok_indiv, m
/*
mainok_indi |
          v |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |        973       98.58       98.58
          2 |         14        1.42      100.00
------------+-----------------------------------
      Total |        987      100.00
*/
restore

*Check duplicates
list HHID2010 INDID occupationname job annualincome if mainok_indiv==2, clean noobs
replace mainocc=. if mainok_indiv==2
replace mainocc=1 if mainok_indiv==2 & HHID2010=="ANDMTP325" & INDID=="F1" & occupationname=="NATURAL MANURE BUSINESS (fertilisant business)"
replace mainocc=1 if mainok_indiv==2 & HHID2010=="PSEP80" & INDID=="F2" & occupationname=="AGRICULTURE"
replace mainocc=1 if mainok_indiv==2 & HHID2010=="PSKOR200" & INDID=="F1" & occupationname=="MAISTHRI"
replace mainocc=1 if mainok_indiv==2 & HHID2010=="PSKU128" & INDID=="F1" & occupationname=="BULLOCART"
replace mainocc=1 if mainok_indiv==2 & HHID2010=="PSNAT347" & INDID=="F1" & occupationname=="SUGARCANE CUTTING"
replace mainocc=1 if mainok_indiv==2 & HHID2010=="PSSEM93" & INDID=="F2" & occupationname=="FANCY STORE"
replace mainocc=1 if mainok_indiv==2 & HHID2010=="RAEP71" & INDID=="F1" & occupationname=="VILLAGE ASSISTANED"
replace mainocc=1 if mainok_indiv==2 & HHID2010=="RANAT337" & INDID=="F1" & occupationname=="AGRICULTURE"
replace mainocc=1 if mainok_indiv==2 & HHID2010=="SIKU152" & INDID=="F1" & occupationname=="TOOK FISH POND LEASE"
replace mainocc=1 if mainok_indiv==2 & HHID2010=="SIMPO5" & INDID=="F1" & occupationname=="VEGETABLE SELLING"
replace mainocc=1 if mainok_indiv==2 & HHID2010=="SINAT330" & INDID=="F2" & occupationname=="AGRICULTURE COOLIE"
replace mainocc=1 if mainok_indiv==2 & HHID2010=="VENNAT352" & INDID=="F1" & occupationname=="AGRICULTURE"
replace mainocc=1 if mainok_indiv==2 & HHID2010=="VENOR395" & INDID=="F1" & occupationname=="LORRY DRIVER"
replace mainocc=1 if mainok_indiv==2 & HHID2010=="VENOR396" & INDID=="F4" & occupationname=="IRNING CLOTHES"
*
drop mainok mainok_indiv
gen mainok=0
replace mainok=1 if mainocc!=.
bysort HHID2010 INDID: egen mainok_indiv=sum(mainok)
preserve
duplicates drop HHID2010 INDID, force
tab mainok_indiv, m
/*
mainok_indi |
          v |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |        987      100.00      100.00
------------+-----------------------------------
      Total |        987      100.00
*/
restore
tab mainocc, m


*Var to create at occupation level, so it is temporary var
foreach x in job profession occupation sector annualincome {
gen temp_mainocc_`x'=.
}
gen temp_mainocc_occupationname=""

foreach x in job profession occupation sector annualincome {
replace temp_mainocc_`x'=`x' if mainocc==1 
}
replace temp_mainocc_occupationname=occupationname if mainocc==1


*Individual level now
foreach x in job profession occupation sector annualincome {
bysort HHID2010 INDID: egen mainocc_`x'=max(temp_mainocc_`x')
}

*More tricky for occupname:
encode temp_mainocc_occupationname, gen(mainoccnamenum)
bysort HHID2010 INDID: egen _mainocc_occupationname=max(mainoccnamenum)
label values _mainocc_occupationname mainoccnamenum
decode _mainocc_occupationname, gen(mainocc_occupationname)

*Clean
drop mainocc maxincome_indiv mainok mainok_indiv temp_mainocc_* mainoccnamenum _mainocc_occupationname

*Label
label values mainocc_job occupationtype
label values mainocc_profession occupation1
label values mainocc_occupation occupcode
label values mainocc_sector sector

*Rename
foreach x in mainocc_job mainocc_profession mainocc_occupation mainocc_sector mainocc_annualincome mainocc_occupationname {
rename `x' `x'_indiv
}


***Nb occupation per indiv + annual income per indiv
bysort HHID2010 INDID: egen annualincome_indiv=sum(annualincome)
bysort HHID2010 INDID: egen nboccupation_indiv=sum(1)




**********HH
***Max hoursayear with maxincome per job
forvalues i=1(1)9{
bysort HHID2010 : egen maxincome_`i'=sum(annualincome) if job==`i'
bysort HHID2010 : egen maxincome2_`i'=max(maxincome_`i')
recode maxincome2_`i' (.=0)
drop maxincome_`i'
}
*Maxincomeoccup
egen maxincomemainocc=rowmax(maxincome2_1 maxincome2_2 maxincome2_3 maxincome2_4 maxincome2_5 maxincome2_6 maxincome2_7 maxincome2_8 maxincome2_9)
*Moc job
gen mainocc_job_HH=.
forvalues i=1(1)9{
replace mainocc_job_HH=`i' if maxincome2_`i'==maxincomemainocc
}

*Label
label values mainocc_job_HH occupationtype
drop maxincomemainocc maxincome2_*


***Max hoursayear with maxhours per occupation
forvalues i=1(1)7{
bysort HHID2010 : egen maxincome_`i'=sum(annualincome) if occupation==`i'
bysort HHID2010 : egen maxincome2_`i'=max(maxincome_`i')
recode maxincome2_`i' (.=0)
drop maxincome_`i'
}
*Maxhoursoccup
egen maxincomemainocc=rowmax(maxincome2_1 maxincome2_2 maxincome2_3 maxincome2_4 maxincome2_5 maxincome2_6 maxincome2_7)
*Moc occupation
gen mainocc_occupation_HH=.
forvalues i=1(1)7{
replace mainocc_occupation_HH=`i' if maxincome2_`i'==maxincomemainocc
}

*Label
label values mainocc_occupation_HH occupcode
drop maxincomemainocc maxincome2_*



***Income  nb occ
bysort HHID2010: egen annualincome_HH=sum(annualincome)
bysort HHID2010: egen nboccupation_HH=sum(1)



**********Agri vs non agri income?
***Job
forvalues i=1(1)9{
gen jobinc_`i'=.
}
forvalues i=1(1)9{
replace jobinc_`i'=annualincome if job==`i'
recode jobinc_`i' (.=0)
}
forvalues i=1(1)9{
bysort HHID2010 INDID: egen jobinc_indiv_`i'=sum(jobinc_`i')
bysort HHID2010: egen jobinc_HH_`i'=sum(jobinc_`i')
}
fre job
foreach x in jobinc_indiv jobinc_HH{
rename `x'_1 `x'_agri
rename `x'_2 `x'_coolie
rename `x'_3 `x'_agricoolie
rename `x'_4 `x'_nregs
rename `x'_5 `x'_invest
rename `x'_6 `x'_employee
rename `x'_7 `x'_todrop
rename `x'_8 `x'_selfemp
rename `x'_9 `x'_pension
}

***Occupation
forvalues i=1(1)7{
gen occinc_`i'=.
}
forvalues i=1(1)7{
replace occinc_`i'=annualincome if occupation==`i'
recode occinc_`i' (.=0)
}
forvalues i=1(1)7{
bysort HHID2010 INDID: egen occinc_indiv_`i'=sum(occinc_`i')
bysort HHID2010: egen occinc_HH_`i'=sum(occinc_`i')
}
fre occupation
foreach x in occinc_indiv occinc_HH{
rename `x'_1 `x'_agri
rename `x'_2 `x'_agricasual
rename `x'_3 `x'_nonagricasual
rename `x'_4 `x'_nonagriregnonqual
rename `x'_5 `x'_nonagriregqual
rename `x'_6 `x'_selfemp
rename `x'_7 `x'_nrega
}

*Clean
drop jobinc_indiv_todrop jobinc_HH_todrop


save"RUME-occupations_v3.dta", replace
****************************************
* END








****************************************
* Occupation + non-worker
****************************************
use"RUME-occupations_v3.dta", clear

rename INDID INDID2010

merge m:1 HHID2010 INDID2010 using "RUME-HH_v6.dta", keepusing(name sex caste jatis age villageid education edulevel relationshiptohead)

rename _merge worker
recode worker (2=0) (3=1)
label define worker 0"No" 1"Yes"
label values worker worker
label var worker "Is the individual a worker?"
fre worker


*occupcode3 includes individuals counted in working pop but not working 
gen occupa_unemployed=occupation 
replace occupa_unemployed=0 if occupationname==""

label define occupcode 0 "No occupation", modify
label values occupa_unemployed occupcode
label var occupa_unemployed "Occupations of workers + unoccupied individuals"


**Generate and label occupation variable only for population on working age (15-60 included)
gen occupa_unemployed_15_70=.
replace occupa_unemployed_15_70=occupa_unemployed if age>14 & age<71
label define occupcode 0 "Unoccupied working age individuals", modify
label var occupa_unemployed_15_70 "Occupations of workers + unoccupied working age indiv (15-70)"
label values occupa_unemployed_15_70 occupcode


**Generate active and inactive population in the same variable
gen working_pop=.
replace working_pop = 1 if occupa_unemployed_15_70==.
replace working_pop = 2 if occupa_unemployed_15_70==0	
replace working_pop = 3 if occupa_unemployed_15_70>0 & occupa_unemployed_15_70!=.
label define working_pop 1 "Inactive" 2 "Unoccupied active" 3 "Occupied active", modify
label var working_pop "Distribution of inactive and active population accord. to criteria of age 15-70"
label values working_pop working_pop




********** Tri
order profession occupation occupa_unemployed occupa_unemployed_15_70, last
fre profession occupation occupa_unemployed occupa_unemployed_15_70

save"RUME-occupations_v4.dta", replace
****************************************
* END









****************************************
* Merge avec base HH
****************************************
use"RUME-occupations_v4.dta", clear

**********Indiv and HH dataset
preserve
bysort HHID2010 INDID: gen n=_n 
keep if n==1
keep HHID2010 INDID mainocc_job_indiv mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv jobinc_indiv_agri jobinc_indiv_coolie jobinc_indiv_agricoolie jobinc_indiv_nregs jobinc_indiv_invest jobinc_indiv_employee jobinc_indiv_selfemp jobinc_indiv_pension occinc_indiv_agri occinc_indiv_agricasual occinc_indiv_nonagricasual occinc_indiv_nonagriregnonqual occinc_indiv_nonagriregqual occinc_indiv_selfemp occinc_indiv_nrega worker
save"RUME-occupations_indiv.dta", replace
restore

preserve
bysort HHID2010: gen n=_n 
keep if n==1
keep HHID2010 mainocc_job_HH mainocc_occupation_HH annualincome_HH nboccupation_HH jobinc_HH_agri jobinc_HH_coolie jobinc_HH_agricoolie jobinc_HH_nregs jobinc_HH_invest jobinc_HH_employee jobinc_HH_selfemp jobinc_HH_pension occinc_HH_agri occinc_HH_agricasual occinc_HH_nonagricasual occinc_HH_nonagriregnonqual occinc_HH_nonagriregqual occinc_HH_selfemp occinc_HH_nrega
save"RUME-occupations_HH.dta", replace
restore
****************************************
* END








****************************************
* Merge avec base HH
****************************************
use"RUME-HH_v6.dta", clear

merge 1:1 HHID2010 INDID2010 using "RUME-occupations_indiv.dta"
drop _merge
merge m:1 HHID2010 using "RUME-occupations_HH.dta"
drop _merge


**Generate active and inactive population in the same variable
gen working_pop=.
replace working_pop=1 if (age<=14 & age!=.) | (age>=71 & age!=.)
replace working_pop=2 if age>14 & age<71 & worker==0
replace working_pop=3 if age>14 & age<71 & worker==1
label define working_pop 1 "Inactive" 2 "Unocc act" 3 "Occ act", modify
label var working_pop "Distribution of inactive and active population accord. to criteria of age 15-70"
label values working_pop working_pop



********** Remplacer occupation principale
fre mainocc_occupation_indiv
replace mainocc_occupation_indiv=0 if mainocc_occupation_indiv==.  & working_pop>1
fre mainocc_occupation_indiv
label define occupcode 0 "No occupation", modify

tab mainocc_occupation_indiv working_pop, m

*4 no occupation alors qu'occ act?
tab mainocc_job_indiv if working_pop==3 & mainocc_occupation_indiv==0
*des pension à recoder
replace working_pop=1 if working_pop==3 & mainocc_occupation_indiv==0



save"RUME-HH_v7.dta", replace
****************************************
* END
