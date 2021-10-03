cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
September 30, 2021
-----
TITLE: Occupation

-------------------------
*/

global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS1"
global git ="C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"


cd "$directory"


****************************************
* Occupation
****************************************
use"NEEMSIS-occupation_allwide_v2.dta", clear

compress

*Combien de personne ?
preserve
duplicates drop HHID2010 INDID, force
tab INDID
*1324 individuals
restore

rename HHID2016 parent_key
order HHID2010 parent_key INDID INDID2010 occupationid
destring hoursayear, replace


**********Nb ext
tab joblocation
gen ext=1
replace ext=0 if strpos(joblocation,"Same village")
replace ext=0 if strpos(joblocation,"Same vilage")
replace ext=0 if strpos(joblocation,"Samevillage")
replace ext=0 if strpos(joblocation,"Same house")
replace ext=0 if strpos(joblocation,"Same village ")
replace ext=0 if strpos(joblocation,"Same villages")
replace ext=0 if strpos(joblocation,"Same villgae")
replace ext=0 if strpos(joblocation,"Same villlage")
replace ext=0 if strpos(joblocation,"Same vllage")
replace ext=0 if strpos(joblocation,"Samebvillage")
replace ext=0 if strpos(joblocation,"Samvillage")
replace ext=0 if strpos(joblocation,".Same village")
replace ext=0 if joblocation=="Same"
replace ext=0 if kindofwork==1
replace ext=0 if kindofwork==2
tab ext

bysort parent_key: egen sum_ext_HH=sum(ext)

preserve
duplicates drop parent_key, force
tab sum_ext
restore


**********Missings pour les occupations en panel
mdesc occupation
mdesc kindofwork
tab occupationname if occupation==.



********** Merging 
merge m:1 parent_key INDID2016 using "NEEMSIS1-HH_v5.dta", keepusing(egoid dummymainoccup mainoccuptype othermainoccup maxhoursayear_ego dummyworkedpastyear workedpastyear_ego)
drop if _merge==2
drop _merge
rename maxhoursayear_ego maxhoursayear
tab maxhoursayear


**********Var
gen mainocc=.
preserve
duplicates drop HHID2010 INDID, force
tab egoid, m
/*
      egoid |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |        503       37.99       37.99
          1 |        477       36.03       74.02
          2 |        344       25.98      100.00
------------+-----------------------------------
      Total |      1,324      100.00
*/
restore


**********EGO
*dummymainoccup va se multiplier donc ca sera toujours la même
sort HHID2010 INDID egoid occupationid
order HHID2010 INDID egoid occupationid kindofwork hoursayear dummymainoccup mainoccuptype maxhoursayear 

*Moc
destring hoursayear maxhoursayear, replace
replace mainocc=1 if hoursayear==maxhoursayear & dummymainoccup==1
tab mainocc
*
gen mainok=0
replace mainok=1 if mainocc!=.
tab mainok egoid, m
bysort HHID2010 INDID: egen mainok_indiv=sum(mainok)
tab mainok_indiv egoid, m
preserve
duplicates drop HHID2010 INDID, force
tab mainok_indiv egoid, m
/*
mainok_ind |              egoid
        iv |         0          1          2 |     Total
-----------+---------------------------------+----------
         0 |       503         21         15 |       539 
         1 |         0        456        327 |       783 
         2 |         0          0          2 |         2 
-----------+---------------------------------+----------
     Total |       503        477        344 |     1,324 
*/
restore


*À la main pour ceux qui n'ont pas la bonne main occupation
gen tokeep=1
replace tokeep=0 if egoid!=0 & mainok_indiv==0
preserve
keep if tokeep==0
duplicates drop HHID2010 INDID, force
tab tokeep, m
restore
gen moctokeep=.
order HHID2010 INDID occupationid occupationname hoursayear othermainoccup maxhoursayear moctokeep tokeep
sort tokeep HHID2010 INDID occupationid
*edit
/*
Je fais correspondre occupationname et othermainoccup
Je mets un 1 à moctokeep
Du coup plus, il faut remplacer la mainoccup pour ceux qui ont 1 à moctokeep et 0 à tokeep 
0 à tokeep c'est pour les égos qui n'ont pas encore de valeurs
Normalement c'est ça:
*/
replace moctokeep = 1 in 1
replace moctokeep = 1 in 4
replace moctokeep = 1 in 8
replace moctokeep = 1 in 11
replace moctokeep = 1 in 13
replace moctokeep = 1 in 16
replace moctokeep = 1 in 19
replace moctokeep = 1 in 20
replace moctokeep = 1 in 23
replace moctokeep = 1 in 25
replace moctokeep = 1 in 28
replace moctokeep = 1 in 31
replace moctokeep = 1 in 32
replace moctokeep = 1 in 33
replace moctokeep = 1 in 35
replace moctokeep = 1 in 39
replace moctokeep = 1 in 41
replace moctokeep = 1 in 44
replace moctokeep = 1 in 45
replace moctokeep = 1 in 48
replace moctokeep = 1 in 51
replace moctokeep = 1 in 56
replace moctokeep = 1 in 57
replace moctokeep = 1 in 61
replace moctokeep = 1 in 63
replace moctokeep = 1 in 65
replace moctokeep = 1 in 67
replace moctokeep = 1 in 69
replace moctokeep = 1 in 72
replace moctokeep = 1 in 74
replace moctokeep = 1 in 76
replace moctokeep = 1 in 79
replace moctokeep = 1 in 80
replace moctokeep = 1 in 84
replace moctokeep = 1 in 87
replace moctokeep = 1 in 90

replace mainocc=1 if tokeep==0 & moctokeep==1
drop moctokeep tokeep
*
drop mainok mainok_indiv
gen mainok=0
replace mainok=1 if mainocc!=.
tab mainok egoid, m
bysort HHID2010 INDID: egen mainok_indiv=sum(mainok)
tab mainok_indiv egoid, m
preserve
duplicates drop HHID2010 INDID, force
tab mainok_indiv egoid, m
/*
mainok_ind |              egoid
        iv |         0          1          2 |     Total
-----------+---------------------------------+----------
         0 |       503          0          0 |       503 
         1 |         0        477        342 |       819 
         2 |         0          0          2 |         2 
-----------+---------------------------------+----------
     Total |       503        477        344 |     1,324 
*/
restore


*Correction des deux qui ont le même nb d'heure
tab mainok_indiv
sort mainok_indiv HHID2010 INDID occupationid
replace mainocc=. if mainok_indiv==2 & kindofwork!=mainoccuptype
*
drop mainok mainok_indiv
gen mainok=0
replace mainok=1 if mainocc!=.
tab mainok egoid, m
bysort HHID2010 INDID: egen mainok_indiv=sum(mainok)
tab mainok_indiv egoid, m
preserve
duplicates drop HHID2010 INDID, force
tab mainok_indiv egoid, m
/*
mainok_ind |              egoid
        iv |         0          1          2 |     Total
-----------+---------------------------------+----------
         0 |       503          0          0 |       503 
         1 |         0        477        344 |       821 
-----------+---------------------------------+----------
     Total |       503        477        344 |     1,324 
*/
restore




**********Indiv
order HHID2010 parent_key INDID INDID2010 INDID2016 egoid
*max income or hours (income only for 2010)
bysort HHID2010 INDID : egen maxhours_indiv=max(hoursayear)
replace maxhours_indiv=. if egoid==1 | egoid==2
*occup name and occup type with the max
replace mainocc=1 if maxhours_indiv==hoursayear & egoid==0
*
drop mainok mainok_indiv
gen mainok=0
replace mainok=1 if mainocc!=.
tab mainok egoid, m
bysort HHID2010 INDID: egen mainok_indiv=sum(mainok)
tab mainok_indiv egoid, m
preserve
duplicates drop HHID2010 INDID, force
tab mainok_indiv egoid, m
/*
mainok_ind |              egoid
        iv |         0          1          2 |     Total
-----------+---------------------------------+----------
         1 |       501        477        344 |     1,322 
         2 |         2          0          0 |         2 
-----------+---------------------------------+----------
     Total |       503        477        344 |     1,324
*/
restore

*Check duplicates
list HHID2010 INDID occupationid occupationname kindofwork hoursayear if mainok_indiv==2, clean noobs
replace mainocc=. if mainok_indiv==2 & occupationid==2
*
drop mainok mainok_indiv
gen mainok=0
replace mainok=1 if mainocc!=.
tab mainok egoid, m
bysort HHID2010 INDID: egen mainok_indiv=sum(mainok)
tab mainok_indiv egoid, m
preserve
duplicates drop HHID2010 INDID, force
tab mainok_indiv egoid, m
/*
mainok_ind |              egoid
        iv |         0          1          2 |     Total
-----------+---------------------------------+----------
         1 |       503        477        344 |     1,324 
-----------+---------------------------------+----------
     Total |       503        477        344 |     1,324 
*/
restore
tab mainocc, m

*Var to create
gen mainoccup_kindofwork=.
gen mainoccup_profession=.
gen mainoccup_occupation=.
gen mainoccup_occupsector=.
gen mainoccup_occupname=""
gen mainoccup_hours=.
gen mainoccup_income=.
gen mainoccup_distance=.

replace mainoccup_kindofwork=kindofwork if mainocc==1 
replace mainoccup_profession=profession if mainocc==1
replace mainoccup_occupation=occupation if mainocc==1
replace mainoccup_occupsector=occupsector if mainocc==1
replace mainoccup_occupname=occupationname if mainocc==1
replace mainoccup_hours=hoursayear if mainocc==1
replace mainoccup_income=annualincome if mainocc==1
replace mainoccup_distance=jobdistance if mainocc==1

*Clean
drop mainocc maxhours_indiv mainok mainok_indiv


**********HH
*max income or hours (income only for 2010)
fre kindofwork
forvalues i=1(1)8{
bysort HHID2010 : egen maxhours_`i'=sum(hoursayear) if kindofwork==`i'
}
forvalues i=1(1)8{
bysort HHID2010 : egen maxhours2_`i'=max(maxhours_`i')
recode maxhours2_`i' (.=0)
drop maxhours_`i'
}
*occup type with the max
egen mainoccup=rowmax(maxhours2_1 maxhours2_2 maxhours2_3 maxhours2_4 maxhours2_5 maxhours2_6 maxhours2_7 maxhours2_8)
*occup name and occup type with the max
gen mainoccup2=.
forvalues i=1(1)8{
replace mainoccup2=`i' if maxhours2_`i'==mainoccup
}
*put the label
label values mainoccup2 kindofwork
drop mainoccup maxhours2_1 maxhours2_2 maxhours2_3 maxhours2_4 maxhours2_5 maxhours2_6 maxhours2_7 maxhours2_8
rename mainoccup2 mainoccupation_HH
*total income
bysort HHID2010 : egen annualincome_HH=sum(annualincome)
*nb of income sources
fre kindofwork
gen countoccupation=1
bysort HHID2010 : egen nboccupation_HH=sum(countoccupation)
drop countoccupation



*Agri vs non agri income?
fre kindofwork
forvalues i=1(1)8{
gen labourincome_`i'=.
}

forvalues i=1(1)8{
replace labourincome_`i'=annualincome if kindofwork==`i'
recode labourincome_`i' (.=0)
}
forvalues i=1(1)8{
bysort HHID2010 INDID: egen labourincome_indiv_`i'=sum(labourincome_`i')
bysort HHID2010: egen labourincome_HH_`i'=sum(labourincome_`i')
}


foreach x in labourincome_indiv labourincome_HH{
rename `x'_1 `x'_agri
rename `x'_2 `x'_selfemp
rename `x'_3 `x'_sjagri
rename `x'_4 `x'_sjnonagri
rename `x'_5 `x'_uwhhnonagri
rename `x'_6 `x'_uwnonagri
rename `x'_7 `x'_uwhhagri
rename `x'_8 `x'_uwagri
}



**********Indiv base
bysort HHID2010 INDID: gen n=_n 
keep if n==1
keep mainoccupation_indiv mainoccupation_hours_indiv mainoccupation_income_indiv mainoccupationname_indiv mainoccupation_distance_indiv annualincome_indiv nboccupation_indiv mainoccupation_HH annualincome_HH nboccupation_HH HHID2010 INDID labourincome_indiv_agri labourincome_indiv_selfemp labourincome_indiv_sjagri labourincome_indiv_sjnonagri labourincome_indiv_uwhhnonagri labourincome_indiv_uwnonagri labourincome_indiv_uwhhagri labourincome_indiv_uwagri labourincome_HH_agri labourincome_HH_selfemp labourincome_HH_sjagri labourincome_HH_sjnonagri labourincome_HH_uwhhnonagri labourincome_HH_uwnonagri labourincome_HH_uwhhagri labourincome_HH_uwagri mainoccupation_distance_indiv sum_ext_HH
save"NEEMSIS-occupation_alllong_v2.dta", replace

bysort HHID2010: gen n=_n 
keep if n==1
keep mainoccupation_HH annualincome_HH nboccupation_HH HHID2010 labourincome_HH_agri labourincome_HH_selfemp labourincome_HH_sjagri labourincome_HH_sjnonagri labourincome_HH_uwhhnonagri labourincome_HH_uwnonagri labourincome_HH_uwhhagri labourincome_HH_uwagri sum_ext_HH
save"NEEMSIS-occupation_alllong_v3.dta", replace
****************************************
* END















****************************************
* Merge avec base HH
****************************************
use"NEEMSIS1-HH_v2.dta", clear

merge 1:1 HHID2010 INDID using "NEEMSIS-occupation_alllong_v2.dta", keepusing(mainoccupation_indiv mainoccupation_hours_indiv mainoccupation_income_indiv mainoccupationname_indiv annualincome_indiv nboccupation_indiv labourincome_indiv_agri labourincome_indiv_selfemp labourincome_indiv_sjagri labourincome_indiv_sjnonagri labourincome_indiv_uwhhnonagri labourincome_indiv_uwnonagri labourincome_indiv_uwhhagri labourincome_indiv_uwagri mainoccupation_distance_indiv)
drop _merge

merge m:1 HHID2010 using "NEEMSIS-occupation_alllong_v3.dta", keepusing(mainoccupation_HH annualincome_HH nboccupation_HH labourincome_HH_agri labourincome_HH_selfemp labourincome_HH_sjagri labourincome_HH_sjnonagri labourincome_HH_uwhhnonagri labourincome_HH_uwnonagri labourincome_HH_uwhhagri labourincome_HH_uwagri sum_ext_HH)
drop _merge


recode mainoccupation_indiv mainoccupation_HH (.=0)

preserve
bysort HHID2010: gen n=_n
keep if n==1
fre mainoccupation_HH
restore


save"NEEMSIS1-HH_v3.dta", replace
****************************************
* END
















****************************************
* Total income
****************************************

*Remittances received
recode remreceivedtotamount1 remreceivedtotamount2 (.=0)
gen remreceivedtotalamount_indiv=remreceivedtotamount1+remreceivedtotamount2
bysort HHID2010 : egen remreceivedtotalamount_HH=sum(remreceivedtotalamount_indiv)

*Income assets
tab dummyincomeassets
gen incomeassets_HH=0
gen incomeassets_indiv=0

*Rental
tab otherhouserent
recode otherhouserent (66=0)
gen otherhouserent_HH=0
replace otherhouserent_HH=otherhouserent if otherhouserent!=.
bysort HHID2010: gen hhsize=_N
gen otherhouserent_indiv=otherhouserent_HH/hhsize
drop hhsize
tab otherhouserent_indiv

*Schemes
recode pensionamount_retirement pensionamount_widows pensionamount_oldage (.=0)
gen pension_indiv=pensionamount_retirement+pensionamount_widows+pensionamount_oldage
bysort HHID2010: egen pension_HH=sum(pension_indiv)
tab pension_HH


*TOTAL INCOME
gen totalincome_indiv=annualincome_indiv+remreceivedtotalamount_indiv+incomeassets_indiv+otherhouserent_indiv+pension_indiv
gen totalincome_HH=annualincome_HH+remreceivedtotalamount_HH+incomeassets_HH+otherhouserent_HH+pension_HH


save"NEEMSIS1-HH_v4.dta", replace
****************************************
* END
