cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
February 23, 2021
-----
OCCUPATION, CASTE, ETC
-----

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
global git = "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

*global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*global git ="C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"

********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

****************************************
* END








****************************************
* Occupation
****************************************
use"NEEMSIS_APPEND-occupations_v3.dta", clear


**********Jobloc cleaning + ext
tab joblocation

forvalues i=1(1)7{
gen jobloc_`i'=0
}

forvalues i=1(1)7{
replace jobloc_`i'=1 if strpos(joblocation,"`i'")
}

rename jobloc_1 jobloc_samevil
rename jobloc_2 jobloc_aroundvil
rename jobloc_3 jobloc_ruralTN
rename jobloc_4 jobloc_smalltownAR
rename jobloc_5 jobloc_bigcitiesTN
rename jobloc_6 jobloc_ruralOUT
rename jobloc_7 jobloc_bigcitiesOUT


gen ext=0
foreach x in jobloc_aroundvil jobloc_ruralTN jobloc_smalltownAR jobloc_bigcitiesTN jobloc_ruralOUT jobloc_bigcitiesOUT {
replace ext=1 if `x'==1
}

tab ext

bysort parent_key: egen sum_ext_HH=sum(ext)


********** Merger les var ego du questionnaire HH
merge m:1 HHID_panel INDID_panel using "NEEMSIS2-HH_v14.dta", keepusing(mainoccuptype maxhoursayear selected_occupposition_ selected_occupname_ dummymainoccupation2 othermainoccupation2 workedpastyearfromearlier dummyworkedpastyear dummyego)
keep if _merge==3
drop _merge
label values mainoccuptype kindofwork
format mainoccuptype %20.0g

**********Var
gen mainocc=.
preserve
duplicates drop HHID_panel INDID_panel, force
tab egoid, m
/*
      egoid |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |        433       25.23       25.23
          1 |        575       33.51       58.74
          2 |        469       27.33       86.07
          3 |        239       13.93      100.00
------------+-----------------------------------
      Total |      1,716      100.00
*/
restore


**********EGO
sort HHID_panel INDID_panel occupationid
order HHID_panel INDID_panel egoid occupationid kindofwork hoursayear dummymainoccup mainoccuptype maxhoursayear 

*Moc
destring hoursayear maxhoursayear, replace
replace mainocc=1 if hoursayear==maxhoursayear & dummymainoccup==1
tab mainocc
*
gen mainok=0
replace mainok=1 if mainocc!=.
tab mainok egoid, m
bysort HHID_panel INDID_panel: egen mainok_indiv=sum(mainok)
tab mainok_indiv egoid, m
preserve
duplicates drop HHID_panel INDID_panel, force
tab mainok_indiv egoid, m
/*
mainok_ind |                    egoid
        iv |         0          1          2          3 |     Total
-----------+--------------------------------------------+----------
         0 |       433         30         20          3 |       486 
         1 |         0        528        444        234 |     1,206 
         2 |         0         16          5          2 |        23 
         3 |         0          1          0          0 |         1 
-----------+--------------------------------------------+----------
     Total |       433        575        469        239 |     1,716 
*/
restore

*À la main pour ceux qui n'ont pas la bonne main occupation (30+20+3)
gen tokeep=1
replace tokeep=0 if egoid!=0 & mainok_indiv==0
preserve
keep if tokeep==0
duplicates drop HHID_panel INDID_panel, force
tab tokeep, m
restore
gen moctokeep=.
order HHID_panel INDID_panel occupationid occupationname hoursayear othermainoccup maxhoursayear moctokeep tokeep
sort tokeep HHID_panel INDID_panel occupationid
format occupationname %40s
*edit
/*
Je fais correspondre occupationname et othermainoccup
Je mets un 1 à moctokeep
Du coup plus, il faut remplacer la mainoccup pour ceux qui ont 1 à moctokeep et 0 à tokeep 
0 à tokeep c'est pour les égos qui n'ont pas encore de valeurs
Normalement c'est ça:
*/
replace moctokeep=1 if HHID_panel=="ELA18" & INDID_panel=="Ind_2" & occupationid==2
replace moctokeep=1 if HHID_panel=="ELA35" & INDID_panel=="Ind_2" & occupationid==3
replace moctokeep=1 if HHID_panel=="ELA50" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="KAR1" & INDID_panel=="Ind_1" & occupationid==2
replace moctokeep=1 if HHID_panel=="KAR1" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="KAR10" & INDID_panel=="Ind_1" & occupationid==2
replace moctokeep=1 if HHID_panel=="KAR10" & INDID_panel=="Ind_2" & occupationid==2
replace moctokeep=1 if HHID_panel=="KAR2" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="KAR21" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="KAR26" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="KAR33" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="KAR37" & INDID_panel=="Ind_1" & occupationid==1
replace moctokeep=1 if HHID_panel=="KAR5" & INDID_panel=="Ind_4" & occupationid==2
replace moctokeep=1 if HHID_panel=="KOR11" & INDID_panel=="Ind_1" & occupationid==1
replace moctokeep=1 if HHID_panel=="KOR18" & INDID_panel=="Ind_1" & occupationid==1
replace moctokeep=1 if HHID_panel=="KOR20" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="KOR20" & INDID_panel=="Ind_5" & occupationid==1
replace moctokeep=1 if HHID_panel=="KOR34" & INDID_panel=="Ind_1" & occupationid==2
replace moctokeep=1 if HHID_panel=="KOR4" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="KOR42" & INDID_panel=="Ind_1" & occupationid==1
replace moctokeep=1 if HHID_panel=="KOR42" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="KOR43" & INDID_panel=="Ind_1" & occupationid==1
replace moctokeep=1 if HHID_panel=="KOR43" & INDID_panel=="Ind_6" & occupationid==1
replace moctokeep=1 if HHID_panel=="KOR5" & INDID_panel=="Ind_2" & occupationid==2
replace moctokeep=1 if HHID_panel=="KOR51" & INDID_panel=="Ind_3" & occupationid==1
replace moctokeep=1 if HHID_panel=="KUV19" & INDID_panel=="Ind_2" & occupationid==2
replace moctokeep=1 if HHID_panel=="KUV25" & INDID_panel=="Ind_5" & occupationid==2
replace moctokeep=1 if HHID_panel=="KUV27" & INDID_panel=="Ind_1" & occupationid==1
replace moctokeep=1 if HHID_panel=="KUV27" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="KUV28" & INDID_panel=="Ind_1" & occupationid==2
replace moctokeep=1 if HHID_panel=="KUV32" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="KUV37" & INDID_panel=="Ind_1" & occupationid==1
replace moctokeep=1 if HHID_panel=="KUV43" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="KUV9" & INDID_panel=="Ind_2" & occupationid==3
replace moctokeep=1 if HHID_panel=="MAN13" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="MANAM13" & INDID_panel=="Ind_1" & occupationid==1
replace moctokeep=1 if HHID_panel=="MANAM3" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="MANAM35" & INDID_panel=="Ind_1" & occupationid==2
replace moctokeep=1 if HHID_panel=="MANAM35" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="MANAM41" & INDID_panel=="Ind_5" & occupationid==1
replace moctokeep=1 if HHID_panel=="MANAM45" & INDID_panel=="Ind_3" & occupationid==1
replace moctokeep=1 if HHID_panel=="MANAM55" & INDID_panel=="Ind_1" & occupationid==2
replace moctokeep=1 if HHID_panel=="MANAM9" & INDID_panel=="Ind_5" & occupationid==1
replace moctokeep=1 if HHID_panel=="NAT39" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="NAT40" & INDID_panel=="Ind_1" & occupationid==1
replace moctokeep=1 if HHID_panel=="NAT40" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="ORA15" & INDID_panel=="Ind_3" & occupationid==1
replace moctokeep=1 if HHID_panel=="ORA44" & INDID_panel=="Ind_1" & occupationid==1
replace moctokeep=1 if HHID_panel=="ORA46" & INDID_panel=="Ind_3" & occupationid==3
replace moctokeep=1 if HHID_panel=="ORA58" & INDID_panel=="Ind_1" & occupationid==2
replace moctokeep=1 if HHID_panel=="SEM1" & INDID_panel=="Ind_2" & occupationid==1
replace moctokeep=1 if HHID_panel=="SEM42" & INDID_panel=="Ind_1" & occupationid==1
replace moctokeep=1 if HHID_panel=="SEM50" & INDID_panel=="Ind_2" & occupationid==2

replace mainocc=1 if tokeep==0 & moctokeep==1
drop moctokeep tokeep
format othermainoccup %20s
*
drop mainok mainok_indiv
gen mainok=0
replace mainok=1 if mainocc!=.
tab mainok egoid, m
bysort HHID_panel INDID_panel: egen mainok_indiv=sum(mainok)
tab mainok_indiv egoid, m
preserve
duplicates drop HHID_panel INDID_panel, force
tab mainok_indiv egoid, m
/*
mainok_ind |                    egoid
        iv |         0          1          2          3 |     Total
-----------+--------------------------------------------+----------
         0 |       432          0          0          0 |       432 
         1 |         0        556        462        237 |     1,255 
         2 |         0         16          5          2 |        23 
         3 |         0          1          0          0 |         1 
-----------+--------------------------------------------+----------
     Total |       432        573        467        239 |     1,711 
*/
restore


*Correction des deux qui ont le même nb d'heure
tab mainok_indiv
sort mainok_indiv HHID_panel INDID_panel occupationid
replace mainocc=. if mainok_indiv>1 & kindofwork!=mainoccuptype
*
drop mainok mainok_indiv
gen mainok=0
replace mainok=1 if mainocc!=.
tab mainok egoid, m
bysort HHID_panel INDID_panel: egen mainok_indiv=sum(mainok)
tab mainok_indiv egoid, m
preserve
duplicates drop HHID_panel INDID_panel, force
tab mainok_indiv egoid, m
/*
mainok_ind |                    egoid
        iv |         0          1          2          3 |     Total
-----------+--------------------------------------------+----------
         0 |       432          3          0          0 |       435 
         1 |         0        563        465        239 |     1,267 
         2 |         0          6          2          0 |         8 
         3 |         0          1          0          0 |         1 
-----------+--------------------------------------------+----------
     Total |       432        573        467        239 |     1,711 
*/
restore
/*
6+2+1 strange
*/


*Correction des 3 ego 1 qui ont sauté
gen strange=0
replace strange=1 if mainok_indiv==0 & egoid==1
sort strange HHID_panel INDID_panel occupationid
*Je choisis l'occup qui match avec mainoccuptype
replace mainocc=1 if HHID_panel=="KAR11" & INDID_panel=="Ind_1" & occupationid==1
replace mainocc=1 if HHID_panel=="MAN42" & INDID_panel=="Ind_2" & occupationid==3
replace mainocc=1 if HHID_panel=="MANAM54" & INDID_panel=="Ind_1" & occupationid==3
drop strange
*
drop mainok mainok_indiv
gen mainok=0
replace mainok=1 if mainocc!=.
tab mainok egoid, m
bysort HHID_panel INDID_panel: egen mainok_indiv=sum(mainok)
tab mainok_indiv egoid, m
preserve
duplicates drop HHID_panel INDID_panel, force
tab mainok_indiv egoid, m
/*
mainok_ind |                    egoid
        iv |         0          1          2          3 |     Total
-----------+--------------------------------------------+----------
         0 |       432          0          0          0 |       432 
         1 |         0        566        465        239 |     1,270 
         2 |         0          6          2          0 |         8 
         3 |         0          1          0          0 |         1 
-----------+--------------------------------------------+----------
     Total |       432        573        467        239 |     1,711 
*/
restore



*Dernière correction à la main pour les 9 qui ont des doublons (6+2+1)
gen strange=0
replace strange=1 if mainok_indiv>1
sort strange HHID_panel INDID_panel occupationid
order strange mainocc, first
*Je décide que l'activité la plus ancienne constitue l'activité principale du coup
bysort HHID_panel INDID_panel : egen min_datestartoccup=min(datestartoccup) if strange==1
format min_datestartoccup %td
sort strange HHID_panel INDID_panel occupationid
order mainoccuptype, after(kindofwork)
replace mainocc=. if strange==1
replace mainocc=1 if min_datestartoccup==datestartoccup & kindofwork==mainoccuptype & strange==1
*Il y en a toujours un qui pose pb, donc je décide de garder l'occupationid le plus petit
replace mainocc=. if HHID_panel=="ORA2" & INDID_panel=="Ind_1" & occupationid==3
drop strange
*
drop mainok mainok_indiv
gen mainok=0
replace mainok=1 if mainocc!=.
tab mainok egoid, m
bysort HHID_panel INDID_panel: egen mainok_indiv=sum(mainok)
tab mainok_indiv egoid, m
preserve
duplicates drop HHID_panel INDID_panel, force
tab mainok_indiv egoid, m
/*
mainok_ind |                    egoid
        iv |         0          1          2          3 |     Total
-----------+--------------------------------------------+----------
         0 |       432          0          0          0 |       432 
         1 |         0        573        467        239 |     1,279 
-----------+--------------------------------------------+----------
     Total |       432        573        467        239 |     1,711
*/
restore




**********Indiv
***MOC
order HHID_panel INDID_panel egoid
*max income or hours (income only for 2010)
bysort HHID_panel INDID_panel : egen maxhours_indiv=max(hoursayear)
replace maxhours_indiv=. if egoid==1 | egoid==2 | egoid==3
*occup name and occup type with the max
replace mainocc=1 if maxhours_indiv==hoursayear & egoid==0
*
drop mainok mainok_indiv
gen mainok=0
replace mainok=1 if mainocc!=.
tab mainok egoid, m
bysort HHID_panel INDID_panel: egen mainok_indiv=sum(mainok)
tab mainok_indiv egoid, m
preserve
duplicates drop HHID_panel INDID_panel, force
tab mainok_indiv egoid, m
/*
mainok_ind |                    egoid
        iv |         0          1          2          3 |     Total
-----------+--------------------------------------------+----------
         1 |       421        573        467        239 |     1,700 
         2 |        11          0          0          0 |        11 
-----------+--------------------------------------------+----------
     Total |       432        573        467        239 |     1,711 
*/
restore


*Check duplicates
gen strange=0
replace strange=1 if mainok_indiv==2
sort strange HHID_panel INDID_panel occupationid
*Je décide de prendre l'occup avec l'id le plus petit comme main
replace mainocc=. if strange==1
bysort HHID_panel INDID_panel : egen min_occupationid=min(occupationid) if strange==1
replace mainocc=1 if occupationid==min_occupationid & strange==1
drop strange
*
drop mainok mainok_indiv
gen mainok=0
replace mainok=1 if mainocc!=.
tab mainok egoid, m
bysort HHID_panel INDID_panel: egen mainok_indiv=sum(mainok)
tab mainok_indiv egoid, m
preserve
duplicates drop HHID_panel INDID_panel, force
tab mainok_indiv egoid, m
/*
mainok_ind |                    egoid
        iv |         0          1          2          3 |     Total
-----------+--------------------------------------------+----------
         1 |       432        573        467        239 |     1,711
-----------+--------------------------------------------+----------
     Total |       432        573        467        239 |     1,711
*/
restore
tab mainocc, m




*Var to create at occupation level, so it is temporary var
foreach x in kindofwork profession occupation sector hoursayear annualincome jobdistance {
gen temp_mainocc_`x'=.
}
gen temp_mainocc_occupationname=""

foreach x in kindofwork profession occupation sector hoursayear annualincome jobdistance {
replace temp_mainocc_`x'=`x' if mainocc==1 
}
replace temp_mainocc_occupationname=occupationname if mainocc==1





**********Individual level now
foreach x in kindofwork profession occupation sector hoursayear annualincome jobdistance {
bysort HHID_panel INDID_panel: egen mainocc_`x'=max(temp_mainocc_`x')
}

*More tricky for occupname:
encode temp_mainocc_occupationname, gen(mainoccnamenum)
bysort HHID_panel INDID_panel: egen _mainocc_occupationname=max(mainoccnamenum)
label values _mainocc_occupationname mainoccnamenum
decode _mainocc_occupationname, gen(mainocc_occupationname)

*Clean
drop mainocc maxhours_indiv mainok mainok_indiv temp_mainocc_* mainoccnamenum _mainocc_occupationname

*Label
label values mainocc_kindofwork kindofwork
label values mainocc_profession occupation1
label values mainocc_occupation occupcode
label values mainocc_sector sector

*Rename
foreach x in mainocc_kindofwork mainocc_profession mainocc_occupation mainocc_sector mainocc_hoursayear mainocc_annualincome mainocc_jobdistance mainocc_occupationname {
rename `x' `x'_indiv
}


*Nb occupation per indiv + annual income per indiv
bysort HHID_panel INDID_panel: egen annualincome_indiv=sum(annualincome)
bysort HHID_panel INDID_panel: egen nboccupation_indiv=sum(1)






**********HH
***Max hoursayear with maxhours per kindofwork
forvalues i=1(1)8{
bysort HHID_panel : egen maxhours_`i'=sum(hoursayear) if kindofwork==`i'
bysort HHID_panel : egen maxhours2_`i'=max(maxhours_`i')
recode maxhours2_`i' (.=0)
drop maxhours_`i'
}
*Maxhoursoccup
egen maxhoursmainocc=rowmax(maxhours2_1 maxhours2_2 maxhours2_3 maxhours2_4 maxhours2_5 maxhours2_6 maxhours2_7 maxhours2_8)
*Moc kindofwork
gen mainocc_kindofwork_HH=.
forvalues i=1(1)8{
replace mainocc_kindofwork_HH=`i' if maxhours2_`i'==maxhoursmainocc
}

*Label
label values mainocc_kindofwork_HH kindofwork
drop maxhoursmainocc maxhours2_*



***Max hoursayear with maxhours per occupation
forvalues i=1(1)7{
bysort HHID_panel : egen maxhours_`i'=sum(hoursayear) if occupation==`i'
bysort HHID_panel : egen maxhours2_`i'=max(maxhours_`i')
recode maxhours2_`i' (.=0)
drop maxhours_`i'
}
*Maxhoursoccup
egen maxhoursmainocc=rowmax(maxhours2_1 maxhours2_2 maxhours2_3 maxhours2_4 maxhours2_5 maxhours2_6 maxhours2_7)
*Moc occupation
gen mainocc_occupation_HH=.
forvalues i=1(1)7{
replace mainocc_occupation_HH=`i' if maxhours2_`i'==maxhoursmainocc
}

*Label
label values mainocc_occupation_HH occupcode
drop maxhoursmainocc maxhours2_*



***Income  nb occ
bysort HHID_panel: egen annualincome_HH=sum(annualincome)
bysort HHID_panel: egen nboccupation_HH=sum(1)








**********Agri vs non agri income?
***Kindofwork
forvalues i=1(1)8{
gen kowinc_`i'=.
}
forvalues i=1(1)8{
replace kowinc_`i'=annualincome if kindofwork==`i'
recode kowinc_`i' (.=0)
}
forvalues i=1(1)8{
bysort HHID_panel INDID_panel: egen kowinc_indiv_`i'=sum(kowinc_`i')
bysort HHID_panel: egen kowinc_HH_`i'=sum(kowinc_`i')
}
fre kindofwork
foreach x in kowinc_indiv kowinc_HH{
rename `x'_1 `x'_agri
rename `x'_2 `x'_selfemp
rename `x'_3 `x'_sjagri
rename `x'_4 `x'_sjnonagri
rename `x'_5 `x'_uwhhnonagri
rename `x'_6 `x'_uwnonagri
rename `x'_7 `x'_uwhhagri
rename `x'_8 `x'_uwagri
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
bysort HHID_panel INDID_panel: egen occinc_indiv_`i'=sum(occinc_`i')
bysort HHID_panel: egen occinc_HH_`i'=sum(occinc_`i')
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

save"NEEMSIS_APPEND-occupations_v4.dta", replace
****************************************
* END













****************************************
* Occupation + non-worker
****************************************
use"NEEMSIS_APPEND-occupations_v4.dta", clear

merge m:1 HHID_panel INDID_panel using "NEEMSIS2-HH_v14.dta", keepusing(egoid name sex caste jatis age_arnaud age agefromearlier1 agefromearlier2 agecalculation age_new age_newfromearlier age2010 age2016 villageid everattendedschool classcompleted edulevel relationshiptohead dummyworkedpastyear livinghome livinghomefromearlier1 livinghomefromearlier2 INDID_left)

label var age_arnaud "age --> age2016+4 --> age2010+10 --> agefromearlier1"

drop agetowork
order HHID_panel INDID_panel age_arnaud age2010 age2016 age*

preserve
*condition pour que le questionnaire se lance
keep if livinghome==1 | livinghome==2
drop if age_arnaud<=10
*condition à moi
drop if INDID_left!=.
*verdique
ta dummyworkedpastyear, m
tab age_arnaud if dummyworkedpastyear==.
tab agefromearlier2 if dummyworkedpastyear==.
tab age_arnaud if dummyworkedpastyear==1
tab agefromearlier2 if dummyworkedpastyear==1
restore
/*

 age_arnaud |      Freq.     Percent        Cum.
------------+-----------------------------------
         11 |         22       21.78       21.78
         12 |         25       24.75       46.53
         13 |         27       26.73       73.27
         14 |         27       26.73      100.00
------------+-----------------------------------
      Total |        101      100.00

agefromearl |
       ier2 |      Freq.     Percent        Cum.
------------+-----------------------------------
          7 |         22       21.78       21.78
          8 |         25       24.75       46.53
          9 |         27       26.73       73.27
         10 |         27       26.73      100.00
------------+-----------------------------------
      Total |        101      100.00

Décalage de l'âge
*/



preserve
*condition pour que le questionnaire se lance
keep if livinghome==1 | livinghome==2
drop if agefromearlier2<=10
*condition à moi
drop if INDID_left!=.
*verdique
ta dummyworkedpastyear, m
restore


preserve
*101 mal codé de l'age
keep if dummyworkedpastyear!=. & age_arnaud<20
ta age_arnaud
ta agefromearlier2
ta age_arnaud dummyworkedpastyear 
sort HHID_panel INDID_panel occupationid
list sex age_arnaud agefromearlier2 edulevel kindofwork annualincome occupation if dummyworkedpastyear==1, clean noobs
restore
/*
       sex   age_ar~d   agefro~2                        edulevel             kindofwork   annual~e                               occupation  
    Female         19         15          High school (8th-10th)   Salaried job (non-ag      96000   Non-agri regular non-qualified workers  
    Female         16         12          High school (8th-10th)   Salaried job (non-ag      90000   Non-agri regular non-qualified workers  
    Female         15         11         HSC/Diploma (11th-12th)   Salaried job (non-ag      90000   Non-agri regular non-qualified workers  
    Female         18         14   Post graduate (15th and more)   Salaried job (non-ag       6000                  Non-agri casual workers  
      Male         18         14          High school (8th-10th)                      .          .                                        .  
      Male         19         15          High school (8th-10th)   Salaried job (non-ag      60000                   Non-agri self-employed  
      Male         19         15         HSC/Diploma (11th-12th)   Salaried job (non-ag     168000       Non-agri regular qualified workers  
    Female         19         15          High school (8th-10th)   Salaried job (non-ag          0                  Non-agri casual workers  
    Female         15         11          High school (8th-10th)                      .          .                                        .  
      Male         16         12          High school (8th-10th)   Self-employed, own a     129000                   Non-agri self-employed  
    Female         18         14         HSC/Diploma (11th-12th)   Salaried job (agri i      19200                      Agri casual workers  
    Female         15         11          High school (8th-10th)   Salaried job (non-ag          0                  Non-agri casual workers

Je pense que le plus simple sera de coder les 101 "0" à dummyworkedpastyear
Mais le pb c'est que des questions ne seront pas remplis du coup
Je ne touche à rien, il faudra juste noter ça pour les prochaines vagues
*/









rename _merge worker
recode worker (2=0) (3=1)
label define worker 0"No" 1"Yes"
label values worker worker
label var worker "Is the individual a worker?"
fre worker


*occupcode3 includes individuals counted in working pop but not working 
gen occupa_unemployed=occupation 
replace occupa_unemployed=0 if occupationid==.

label define occupcode 0 "No occupation", modify
label values occupa_unemployed occupcode
label var occupa_unemployed "Occupations of workers + unoccupied individuals"


**Generate and label occupation variable only for population on working age (15-60 included)
gen occupa_unemployed_15_70=.
replace occupa_unemployed_15_70=occupa_unemployed if age_arnaud>14 & age_arnaud<71
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

drop sum_ext_HH mainocc_kindofwork_HH mainocc_occupation_HH annualincome_HH nboccupation_HH kowinc_HH_agri kowinc_HH_selfemp kowinc_HH_sjagri kowinc_HH_sjnonagri kowinc_HH_uwhhnonagri kowinc_HH_uwnonagri kowinc_HH_uwhhagri kowinc_HH_uwagri occinc_HH_agri occinc_HH_agricasual occinc_HH_nonagricasual occinc_HH_nonagriregnonqual occinc_HH_nonagriregqual occinc_HH_selfemp occinc_HH_nrega

save"NEEMSIS_APPEND-occupations_v5.dta", replace
****************************************
* END











****************************************
* Indiv dataset
****************************************
use"NEEMSIS_APPEND-occupations_v4.dta", clear
preserve
bysort HHID_panel INDID_panel: gen n=_n 
keep if n==1
keep HHID_panel INDID_panel mainocc_kindofwork_indiv mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_hoursayear_indiv mainocc_annualincome_indiv mainocc_jobdistance_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv kowinc_indiv_agri kowinc_indiv_selfemp kowinc_indiv_sjagri kowinc_indiv_sjnonagri kowinc_indiv_uwhhnonagri kowinc_indiv_uwnonagri kowinc_indiv_uwhhagri kowinc_indiv_uwagri occinc_indiv_agri occinc_indiv_agricasual occinc_indiv_nonagricasual occinc_indiv_nonagriregnonqual occinc_indiv_nonagriregqual occinc_indiv_selfemp occinc_indiv_nrega
save"NEEMSIS_APPEND-occupations_v4_indiv.dta", replace
restore

preserve
bysort HHID_panel: gen n=_n 
keep if n==1
keep HHID_panel sum_ext_HH mainocc_kindofwork_HH mainocc_occupation_HH annualincome_HH nboccupation_HH kowinc_HH_agri kowinc_HH_selfemp kowinc_HH_sjagri kowinc_HH_sjnonagri kowinc_HH_uwhhnonagri kowinc_HH_uwnonagri kowinc_HH_uwhhagri kowinc_HH_uwagri occinc_HH_agri occinc_HH_agricasual occinc_HH_nonagricasual occinc_HH_nonagriregnonqual occinc_HH_nonagriregqual occinc_HH_selfemp occinc_HH_nrega
save"NEEMSIS_APPEND-occupations_v4_HH.dta", replace
restore
****************************************
* END








****************************************
* Merge avec base HH
****************************************
use"NEEMSIS2-HH_v14.dta", clear

merge 1:1 HHID_panel INDID_panel using "NEEMSIS_APPEND-occupations_v4_indiv.dta"
gen worker=.
replace worker=1 if _merge==3
replace worker=0 if _merge==1
drop _merge
merge m:1 HHID_panel using "NEEMSIS_APPEND-occupations_v4_HH.dta"
drop _merge

preserve
duplicates drop HHID_panel, force
tab version_HH mainocc_occupation_HH, m
restore


**Generate active and inactive population in the same variable
gen working_pop=.
replace working_pop=1 if (age_arnaud<=14 & age_arnaud!=.) | (age_arnaud>=71 & age_arnaud!=.)
replace working_pop=2 if age_arnaud>14 & age_arnaud<71 & worker==0
replace working_pop=3 if age_arnaud>14 & age_arnaud<71 & worker==1
replace working_pop=. if INDID_left!=.
replace working_pop=. if livinghome>=3
label define working_pop 1 "Inactive" 2 "Unocc act" 3 "Occ act", modify
label var working_pop "Distribution of inactive and active population accord. to criteria of age 15-70"
label values working_pop working_pop



********** Remplacer occupation principale
replace mainocc_occupation_indiv=0 if mainocc_occupation_indiv==. & INDID_left==. & livinghome<=2 & working_pop>1
tab INDID_left
fre mainocc_occupation_indiv
label define occupcode 0 "No occupation", modify

tab mainocc_occupation_indiv working_pop, m

preserve
*643 missings at working_pop, to check
keep if working_pop==.
keep if INDID_left==.  // 600
keep if livinghome<=2  // 43
restore

save"NEEMSIS2-HH_v15.dta", replace
****************************************
* END











****************************************
* TOTAL INCOME
****************************************

********** Remittances
use"NEEMSIS_APPEND-remreceivedsourceidgroup", clear
rename parent_key setofremreceivedidgroup
split key, p(/)
drop key key2 key3
rename key1 parent_key
sort setofremreceivedidgroup

bysort setofremreceivedidgroup: egen remreceivedtotalamount_indiv=sum(remreceivedtotalamount)
bysort parent_key: egen remreceivedtotalamount_HH=sum(remreceivedtotalamount)
order remreceivedtotalamount remreceivedtotalamount_indiv remreceivedtotalamount_HH, last

keep if remreceivedtotalamount_indiv!=0
keep remreceivedtotalamount_indiv setofremreceivedidgroup
bysort setof: gen n=_n
keep if n==1
drop n

save"NEEMSIS_APPEND-remreceived_indiv", replace


use"NEEMSIS2-HH_v15.dta", clear
merge m:1 setofremreceivedidgroup using "NEEMSIS_APPEND-remreceived_indiv"
drop if _merge==2
drop _merge

bysort parent_key: egen remreceivedtotalamount_HH=sum(remreceivedtotalamount_indiv)
recode remreceivedtotalamount_indiv (.=0)

*Assets
tab incomeassets
gen incomeassets_HH=0
replace incomeassets_HH=incomeassets if incomeassets!=.
bysort parent_key: egen hhsize=sum(1)
gen incomeassets_indiv=incomeassets_HH/hhsize
drop hhsize


*Other house rent
tab otherhouserent
recode otherhouserent (66=.)
gen otherhouserent_HH=0
replace otherhouserent_HH=otherhouserent if otherhouserent!=.
bysort parent_key: egen hhsize=sum(1)
gen otherhouserent_indiv=otherhouserent_HH/hhsize
drop hhsize

*Schemes
recode schemepensionamount1 schemepensionamount2 schemepensionamount5 (.=0)
gen pension_indiv=schemepensionamount1+schemepensionamount2+schemepensionamount5
bysort parent_key: egen pension_HH=sum(pension_indiv)

*TOTAL INCOME
recode annualincome_indiv annualincome_HH (.=0)
gen totalincome_indiv=annualincome_indiv+remreceivedtotalamount_indiv+incomeassets_indiv+otherhouserent_indiv+pension_indiv
gen totalincome_HH=annualincome_HH+remreceivedtotalamount_HH+incomeassets_HH+otherhouserent_HH+pension_HH

gen test=totalincome_indiv-annualincome_indiv
tab test
drop test

********** Insurance
forvalues i=1(1)6{
rename insurancetype`i' insurancepublic`i'
}
forvalues i=1(1)6{
rename insurancetypetwo`i' insurancetype`i'
}



********** Nettoyage INDID + preload
tab version_HH 


save"NEEMSIS2-HH_v16.dta", replace
****************************************
* END
