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
cd "$directory\CLEAN"

********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

****************************************
* END














****************************************
* Occupation
****************************************
/*
Ajouter à la base HH une variable d'activité principale
partant du principe que c'est l'activité où avec max hoursayear
*/
use"NEEMSIS_APPEND-occupations.dta", clear
split parent_key, p(/)
drop parent_key parent_key2
rename parent_key1 parent_key
split setofoccupations, p([)
drop setofoccupations1 setofoccupations3
split setofoccupations2, p(])
drop setofoccupations2 setofoccupations22
rename setofoccupations21 INDID_total
destring INDID_total, replace
drop businessskill_2 businessskill_4 businessskill_1 businesslocation_1 businesslocation_2 businesslocation_4 joblocation_1 joblocation_2 joblocation_4 joblocation_5 joblocation_3 joblocation_7 joblocation_6 businesslocation_3 businesslocation_7 businesslocation_5 businesslocation_6
destring occupationnumber, replace
order parent_key INDID_total occupationnumber, first
sort parent_key INDID
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"
gen countoccupation=1
save"NEEMSIS_APPEND-occupations_v2.dta", replace


**********EGO
use"NEEMSIS_APPEND-occupations_v2.dta", clear
/*
   dummyego |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      1,382       55.59       55.59
          1 |      1,104       44.41      100.00
------------+-----------------------------------
      Total |      2,486      100.00
*/
merge m:m parent_key INDID_total using "NEEMSIS2-HH_v14.dta", keepusing(ego mainoccuptype maxhoursayear selected_occupposition_ selected_occupname_ dummymainoccupation2 othermainoccupation2 workedpastyearfromearlier dummyworkedpastyear dummyego)
keep if _merge==3
drop _merge

*Ego moc
destring hoursayear maxhoursayear selected_occupposition_, replace
gen mainoccup=kindofwork if selected_occupposition_==occupationnumber & dummymainoccupation2==1
gen mainoccupname=occupationname if selected_occupposition_==occupationnumber & dummymainoccupation2==1

*If it is not?
tab dummymainoccupation2
gen _tempmocego=1 if othermainoccupation2==occupationname & dummymainoccupation2==0
replace mainoccup=kindofwork if _tempmocego==1
replace mainoccupname=occupationname if _tempmocego==1
*Checking
preserve
bysort parent_key INDID_total: gen n=_n
keep if n==1
tab mainoccup dummyego, m
restore
*For the rest? mainoccuptype
bysort parent_key INDID_total: egen mainok=max(mainoccup)
tab mainok, m
replace mainoccup=kindofwork if mainoccuptype==kindofwork & mainok==.
replace mainoccupname=occupationname if mainoccuptype==kindofwork & mainok==.
drop mainok
bysort parent_key INDID_total: egen mainok=max(mainoccup)
tab mainok ego, m
*For the rest rest? Alamano
sort parent_key INDID_total
list parent_key INDID_total occupationnumber occupationname kindofwork othermainoccupation2 if dummymainoccupation2==0 & mainoccupname=="", clean noobs
preserve
keep if ego!=0 & mainok==. & othermainoccupation2!=""
keep parent_key occupationnumber INDID_total othermainoccupation2 occupationname kindofwork mainoccuptype
order parent_key INDID_total occupationnumber occupationname kindofwork mainoccuptype othermainoccupation2
sort parent_key INDID_total occupationnumber
*export excel using "NEEMSIS_APPEND-occupations_v2.xlsx", nolab replace firstrow(var)
restore
*À partir du fichier Excel
replace mainoccup=4 if parent_key=="uuid:845162bf-a21a-4003-910b-364e995bf863" & INDID_total==3 & occupationnumber==1
replace mainoccup=7 if parent_key=="uuid:86574ca0-02c2-4e2b-9d3b-f644d9c6da68" & INDID_total==2 & occupationnumber==1
replace mainoccup=4 if parent_key=="uuid:bcf78ad0-0c91-46d0-9ff9-6fd1b508541c" & INDID_total==5 & occupationnumber==1
replace mainoccup=4 if parent_key=="uuid:e5d9e97a-f3b9-49e1-9cde-1ad11dc43009" & INDID_total==3 & occupationnumber==1
replace mainoccup=2 if parent_key=="uuid:f435ac6b-11a5-4273-a5a0-d7f2bb74b5f6" & INDID_total==3 & occupationnumber==2

replace mainoccupname="Car driver" if parent_key=="uuid:845162bf-a21a-4003-910b-364e995bf863" & INDID_total==3 & occupationnumber==1
replace mainoccupname="Agriculture activities in own farm unpaid" if parent_key=="uuid:86574ca0-02c2-4e2b-9d3b-f644d9c6da68" & INDID_total==2 & occupationnumber==1
replace mainoccupname="NREGA" if parent_key=="uuid:bcf78ad0-0c91-46d0-9ff9-6fd1b508541c" & INDID_total==5 & occupationnumber==1
replace mainoccupname="NREGs work as coolie" if parent_key=="uuid:e5d9e97a-f3b9-49e1-9cde-1ad11dc43009" & INDID_total==3 & occupationnumber==1
replace mainoccupname="Tata ace driver (own vehicle)" if parent_key=="uuid:f435ac6b-11a5-4273-a5a0-d7f2bb74b5f6" & INDID_total==3 & occupationnumber==2
drop mainok
bysort parent_key INDID_total: egen mainok=max(mainoccup)
tab mainok ego, m


**********Indiv
*max income or hours (income only for 2010)
bysort parent_key INDID : egen maxhours_indiv=max(hoursayear)
*occup name and occup type with the max
replace mainoccup=kindofwork if maxhours_indiv==hoursayear & mainok==.
replace mainoccupname=occupationname if maxhours_indiv==hoursayear & mainok==.
drop mainok
bysort parent_key INDID_total: egen mainok=max(mainoccup)
tab mainok ego, m
gen dummymoc=0
replace dummymoc=1 if mainoccup!=.
tab dummymoc // 1135 normalement
	*Check duplicates
	duplicates tag parent_key INDID_total ego if dummymoc==1, gen(tag)
	tab tag
	sort tag parent_key INDID_total occupationnumber
		*apply max income
		bysort parent_key INDID_total: egen maxincome=max(annualincome) if tag>0
		replace mainoccup=. if maxincome!=annualincome & tag>0
		replace mainoccupname="" if maxincome!=annualincome & tag>0
		drop mainok
		drop dummymoc
		drop tag
		bysort parent_key INDID_total: egen mainok=max(mainoccup)
		tab mainok ego, m
		gen dummymoc=0
		replace dummymoc=1 if mainoccup!=.
		tab dummymoc // 1135 normalement
		*Check duplicates
		duplicates tag parent_key INDID_total ego if dummymoc==1, gen(tag)
		tab tag
		sort tag parent_key INDID_total occupationnumber
			*apply occupation order
			bysort parent_key INDID_total: egen minnumber=min(occupationnumber) if tag>0
			replace mainoccup=. if minnumber!=occupationnumber & tag>0
			replace mainoccupname="" if minnumber!=occupationnumber & tag>0
			drop mainok
			drop dummymoc
			drop tag
			bysort parent_key INDID_total: egen mainok=max(mainoccup)
			tab mainok ego, m
			gen dummymoc=0
			replace dummymoc=1 if mainoccup!=.
			tab dummymoc // 1135 normalement
			drop mainok minnumber maxincome maxhours_indiv _tempmocego

*hours and income of main
gen mainoccup_hours=.
gen mainoccup_income=.
replace mainoccup_hours=hoursayear if dummymoc==1
replace mainoccup_income=annualincome if dummymoc==1
	
*encode name to simplify the procedure
encode mainoccupname, gen(mainoccupnamenumeric)
*put main occupation at indiv level
bysort parent_key INDID : egen mainoccupation=max(mainoccup)
bysort parent_key INDID : egen mainoccupationname=max(mainoccupnamenumeric)
*put the label
label values mainoccupation kindofwork
label values mainoccupationname mainoccupnamenumeric
*decode the name to compare between the waves
decode mainoccupationname, gen(_mainoccupationname)
drop mainoccupationname
rename _mainoccupationname mainoccupationname
*total income
bysort parent_key INDID: egen annualincome_indiv=sum(annualincome)
*nb of income sources
fre kindofwork
bysort parent_key INDID: egen nboccupation_indiv=sum(countoccupation)

*cleaning
rename mainoccupation mainoccupation_indiv
rename mainoccupationname mainoccupationname_indiv
rename mainoccup_hours mainoccupation_hours_indiv
rename mainoccup_income mainoccupation_income_indiv
drop mainoccup mainoccupname mainoccupnamenumeric countoccupation


**********HH
*max income or hours (income only for 2010)
fre kindofwork
forvalues i=1(1)8{
bysort parent_key : egen maxhours_`i'=sum(hoursayear) if kindofwork==`i'
}
forvalues i=1(1)8{
bysort parent_key : egen maxhours2_`i'=max(maxhours_`i')
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
bysort parent_key : egen annualincome_HH=sum(annualincome)
*nb of income sources
fre kindofwork
gen countoccupation=1
bysort parent_key : egen nboccupation_HH=sum(countoccupation)
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
bysort parent_key INDID: egen labourincome_indiv_`i'=sum(labourincome_`i')
bysort parent_key: egen labourincome_HH_`i'=sum(labourincome_`i')
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
bysort parent_key INDID: gen n=_n 
keep if n==1
keep mainoccupation_indiv mainoccupation_hours_indiv mainoccupation_income_indiv mainoccupationname_indiv annualincome_indiv nboccupation_indiv mainoccupation_HH annualincome_HH nboccupation_HH parent_key INDID labourincome_indiv_agri labourincome_indiv_selfemp labourincome_indiv_sjagri labourincome_indiv_sjnonagri labourincome_indiv_uwhhnonagri labourincome_indiv_uwnonagri labourincome_indiv_uwhhagri labourincome_indiv_uwagri labourincome_HH_agri labourincome_HH_selfemp labourincome_HH_sjagri labourincome_HH_sjnonagri labourincome_HH_uwhhnonagri labourincome_HH_uwnonagri labourincome_HH_uwhhagri labourincome_HH_uwagri
save"NEEMSIS_APPEND-occupations_v3.dta", replace

bysort parent_key: gen n=_n 
keep if n==1
keep mainoccupation_HH annualincome_HH nboccupation_HH parent_key INDID labourincome_HH_agri labourincome_HH_selfemp labourincome_HH_sjagri labourincome_HH_sjnonagri labourincome_HH_uwhhnonagri labourincome_HH_uwnonagri labourincome_HH_uwhhagri labourincome_HH_uwagri
save"NEEMSIS_APPEND-occupations_v4.dta", replace


**********Merge dans la base HH
use"NEEMSIS2-HH_v14.dta", clear
tab dummyworkedpastyear
*1140 indiv ?

merge m:1 parent_key INDID_total using "NEEMSIS_APPEND-occupations_v3.dta", keepusing(mainoccupation_indiv mainoccupation_hours_indiv mainoccupation_income_indiv mainoccupationname_indiv annualincome_indiv nboccupation_indiv labourincome_indiv_agri labourincome_indiv_selfemp labourincome_indiv_sjagri labourincome_indiv_sjnonagri labourincome_indiv_uwhhnonagri labourincome_indiv_uwnonagri labourincome_indiv_uwhhagri labourincome_indiv_uwagri)
drop _merge

merge m:1 parent_key using "NEEMSIS_APPEND-occupations_v4.dta", keepusing(mainoccupation_HH annualincome_HH nboccupation_HH labourincome_HH_agri labourincome_HH_selfemp labourincome_HH_sjagri labourincome_HH_sjnonagri labourincome_HH_uwhhnonagri labourincome_HH_uwnonagri labourincome_HH_uwhhagri labourincome_HH_uwagri)
drop _merge

recode mainoccupation_indiv mainoccupation_HH (.=0)

preserve
bysort parent_key: gen n=_n
keep if n==1
fre mainoccupation_HH
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