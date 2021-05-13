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
merge m:m parent_key INDID_total using "NEEMSIS2-HH_v7.dta", keepusing(ego mainoccuptype maxhoursayear selected_occupposition_ selected_occupname_ dummymainoccupation2 othermainoccupation2 workedpastyearfromearlier dummyworkedpastyear dummyego)
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


**********Indiv base
bysort parent_key INDID: gen n=_n 
keep if n==1
keep mainoccupation_indiv mainoccupation_hours_indiv mainoccupation_income_indiv mainoccupationname_indiv annualincome_indiv nboccupation_indiv mainoccupation_HH annualincome_HH nboccupation_HH parent_key INDID
save"NEEMSIS_APPEND-occupations_v3.dta", replace

bysort parent_key: gen n=_n 
keep if n==1
keep mainoccupation_HH annualincome_HH nboccupation_HH parent_key INDID
save"NEEMSIS_APPEND-occupations_v4.dta", replace


**********Merge dans la base HH
use"NEEMSIS2-HH_v7.dta", clear
tab dummyworkedpastyear
*1140 indiv ?

merge m:1 parent_key INDID_total using "NEEMSIS_APPEND-occupations_v3.dta", keepusing(mainoccupation_indiv mainoccupation_hours_indiv mainoccupation_income_indiv mainoccupationname_indiv annualincome_indiv nboccupation_indiv)
drop _merge

merge m:1 parent_key using "NEEMSIS_APPEND-occupations_v4.dta", keepusing(mainoccupation_HH annualincome_HH nboccupation_HH)
drop _merge

recode mainoccupation_indiv mainoccupation_HH (.=0)

preserve
bysort parent_key: gen n=_n
keep if n==1
fre mainoccupation_HH
restore

save"NEEMSIS2-HH_v8.dta", replace
****************************************
* END












****************************************
* 2016 DATA PRELOAD for sex, etc.
****************************************
use"NEEMSIS2-HH_v8.dta", clear
merge m:1 INDIDpanel using "$directory\do_not_drop\NEEMSIS_preload2016"
drop if _merge==2
drop HHID
rename _merge preload2016
sort preload2016
recode preload2016 (1=0) (3=1)
label list
label values preload2016 yesno
tab preload2016
rename preload2016 dummy_preload2016

save"NEEMSIS2-HH_v9.dta", replace
****************************************
* END
















****************************************
* SEX CASTE EDUCATION
****************************************
use"NEEMSIS2-HH_v9.dta", clear

********** HOW MUCH PRESENT ON NEEMSIS2 survey?
gen respondent2020=.
replace respondent2020=0 if INDID_left!=.
replace respondent2020=1 if INDID_left==.
tab respondent2020, m
tab livinghome respondent2020, m
rename respondent2020 dummy_respondent2020


********** Caste
tab caste
destring castepreload2016, replace
tab castepreload2016
tab caste_p16

replace caste=castepreload2016 if caste==. & castepreload2016!=.
tab caste

gen caste_group=.
foreach x in 2 3{
replace caste_group=1 if caste==`x'
}
foreach x in 1 5 7 8 10 12 15 16{
replace caste_group=2 if caste==`x'
}
foreach x in 4 6 11 13 17{
replace caste_group=3 if caste==`x'
}
label define castecat 1"Dalits" 2"Middle" 3"Upper", replace
label values caste_group castecat
tab caste_group
label list
label values caste caste
rename caste jatis

order parent_key HHID_panel HHID2010 householdid2020 villageid villagearea jatis caste_group , first
rename caste_group caste





********** Egoid
rename ego egoid






********** Name
tab name
sort name
sort householdid2020
list marriedid name marriedname marriagesomeoneelse namefrompreload name_p16 HHID2010 if marriedname!="",clean
replace name=namefrompreload if name=="" & namefrompreload!=""
tab name if dummy_respondent2020==1



********** Sex
destring sex, replace
replace sex_new=sex_p16 if sex_new==. & sex_p16!=.
replace sex_new=sex if sex_new==. & sex!=.
tab sex_new
drop sex sex_p16 
rename sex_new sex
tab sex if dummy_respondent2020==1





********** Age
destring age, replace
destring agefromearlier1, replace
replace age=agefromearlier1 if age==. & agefromearlier1!=.
replace age=age_p16+3 if age==. & INDID_left!=.
sum age if dummy_respondent2020==1




********** Education
foreach x in everattendedschool classcompleted{
replace `x'=`x'_p16 if `x'==. & `x'_p16!=.
}
gen edulevel=.
replace edulevel = 0 if  everattendedschool == 0
replace edulevel = 0 if classcompleted < 5 & classcompleted != .
replace edulevel= 1 if classcompleted>=5 & classcompleted != .
replace edulevel= 2 if classcompleted>=8 & classcompleted != .
replace edulevel= 3 if classcompleted>=11 & classcompleted != .
replace edulevel= 4 if classcompleted>=15  & classcompleted != .
replace edulevel= 5 if classcompleted>=16  & classcompleted != . //Attention! I recoded here cause otherwise all missing are in 5 (Anne, 20/06/17)
label define edulevel 0 "Below primary" 1 "Primary completed", modify
label define edulevel 2 "High school (8th-10th)", modify
label define edulevel 3 "HSC/Diploma (11th-12th)", modify
label define edulevel 4 "Bachelors (13th-15th)", modify
label define edulevel 5 "Post graduate (15th and more)", modify
label values edulevel edulevel
tab edulevel if dummy_respondent2020==1
tab age if edulevel==.
replace edulevel=0 if edulevel==. & age<4
tab edulevel livinghome, m

list parent_key INDID	INDID_total	INDID_former	INDID_new	INDID_left name version_HH if livinghome==1 & edulevel==., clean noobs
/*
                                   parent_key   INDID   INDID_~l   INDID_~r   INDID_~w   INDID_~t          name           version_HH  
    uuid:cd6b0c54-a3bf-40f5-9a46-4860744cc378       6          6          .          6          .      Keerthas   NEEMSIS2_NEW_APRIL  
*/

order parent_key HHID_panel HHID2010 householdid2020 villageid villagearea jatis caste  INDID INDID_total INDID_former INDID_new INDID_left egoid name sex age edulevel, first






********** Encode version
tab version_HH
tab version_agri

rename version_HH _version_HH
gen version_HH=.
replace version_HH=1 if _version_HH=="NEEMSIS2_LAST"
replace version_HH=2 if _version_HH=="NEEMSIS2_DEC"
replace version_HH=3 if _version_HH=="NEEMSIS2_DECEMBER"
replace version_HH=4 if _version_HH=="NEEMSIS2_FEB"
replace version_HH=5 if _version_HH=="NEEMSIS2_FEBRUARY"
replace version_HH=6 if _version_HH=="NEEMSIS2_APRIL"
replace version_HH=7 if _version_HH=="NEEMSIS2_NEW_APRIL"
label define version_HH 1"LAST" 2"DEC" 3"DECEMBER" 4"FEB" 5"FEBRUARY" 6"APRIL" 7"NEW_APRIL", replace
label values version_HH version_HH
drop _version_HH

rename version_agri _version_agri
gen version_agri=.
replace version_agri=1 if _version_agri=="NEEMSIS2_Agriculture"
replace version_agri=2 if _version_agri=="NEEMSIS2_DEC_Agriculture"
replace version_agri=3 if _version_agri=="NEEMSIS2_DECEMBER_Agriculture"
replace version_agri=4 if _version_agri=="NEEMSIS2_FEBRUARY_Agriculture"
replace version_agri=5 if _version_agri=="NEEMSIS2_FEB_NEW_Agriculture"
label define version_agri 1"Agriculture" 2"DEC_Agriculture" 3"DECEMBER_Agriculture" 4"FEBRUARY_Agriculture" 5"FEB_NEW_Agriculture", replace
label values version_agri version_agri
drop _version_agri



********** Year
gen year=2020






**********Cleaning


save"NEEMSIS2-HH_v10.dta", replace
****************************************
* END





















****************************************
* Assets
****************************************
use"NEEMSIS2-HH_v10.dta", clear

**********Equipment
fre equipmentlist
fre equipmentname1 equipmentname2 equipmentname4
foreach x in equipmentname equipmentnb equipmentcost equipmentpledged {
rename `x'1 `x'_tractor
rename `x'2 `x'_bullockcart
capture confirm v `x'3
if _rc==0{
rename `x'3 `x'_harvester
}
rename `x'4 `x'_plowingmach
capture confirm v `x'5
if _rc==0{
rename `x'5 `x'_none
}
}

foreach x in equipmentlist_ equipmentborrowedlist_ covsellequipment_{
rename `x'1 `x'tractor
rename `x'2 `x'bullockcar
rename `x'3 `x'harvester
rename `x'4 `x'plowingmac
rename `x'5 `x'none
}


**********Gold
tab goldquantity
replace goldquantity=50 if goldquantity==120000  //120 000 / 2700 = 44.4 donc 50

gen goldquantityamount=goldquantity*2700
bysort HHID2010 : egen goldquantityamount2=max(goldquantityamount)
drop goldquantityamount
rename goldquantityamount2 goldquantityamount
recode goldquantityamount (.=0)

**********Land
tab drywetownland

replace sizedryownland=sizeownland if drywetownland=="1" & sizedryownland==. & sizeownland!=.
replace sizewetownland=sizeownland if drywetownland=="2" & sizewetownland==. & sizeownland!=.

gen amountownlanddry=sizedryownland*600000
gen amountownlandwet=sizewetownland*800000
gen amountownland=amountownlanddry+amountownlandwet
*if both half
replace amountownland=sizeownland*700000 if drywetownland=="1 2" & sizedryownland==. & sizewetownland==.


**********Livestock
fre livestockname*
foreach x in livestockname livestocknb livestockprice livestockuse {
rename `x'1 `x'_cow
rename `x'2 `x'_goat
rename `x'3 `x'_chicken
rename `x'4 `x'_bullock
rename `x'5 `x'_bullforploughing
}

foreach x in covselllivestock_{
rename `x'1 `x'cow
rename `x'2 `x'goat
rename `x'3 `x'chicken
rename `x'4 `x'bullock
rename `x'5 `x'bullforploughin
rename `x'6 `x'none
}


drop livestocklist_1 livestocklist_2 livestocklist_3 livestocklist_4 livestocklist_5 livestocklist_6
drop livestockname_*

foreach x in cow goat chicken bullock bullforploughing {
clonevar livestockamount_`x'=livestockprice_`x'
recode livestockamount_`x' (.=0)
}


**********Good total amount
fre goodname*
foreach x in goodname numbergoods goodyearpurchased goodtotalamount goodbuying goodsourcecredit goodcreditsettled {
rename `x'1 `x'_car
rename `x'2 `x'_bike
rename `x'3 `x'_fridge
rename `x'4 `x'_furniture
rename `x'5 `x'_tailormach
rename `x'6 `x'_phone
rename `x'7 `x'_landline
capture confirm v `x'8
if _rc==0{
rename `x'8 `x'_DVD
}
capture confirm v `x'9
if _rc==0{
rename `x'9 `x'_camera
}
rename `x'10 `x'_cookgas
rename `x'11 `x'_computer
rename `x'12 `x'_antenna
}

*covid19
foreach x in covsellgoods_{
rename `x'1 `x'car
rename `x'2 `x'bike
rename `x'3 `x'fridge
rename `x'4 `x'furniture
rename `x'5 `x'tailormach
rename `x'6 `x'phone
rename `x'7 `x'landline
rename `x'8 `x'DVD
rename `x'9 `x'camera
rename `x'10 `x'cookgas
rename `x'11 `x'computer
rename `x'12 `x'antenna
rename `x'13 `x'none
rename `x'77 `x'other
}


****Cleaning for goods
*Car
replace numbergoods_car=1 if othergood=="Auto"
replace goodtotalamount_car=100000  if othergood=="Auto"

replace numbergoods_car=1 if othergood=="407 lorry"
replace goodtotalamount_car=100000  if othergood=="407 lorry"

replace numbergoods_car=1 if othergood=="TATA a/c vehicle"
replace goodtotalamount_car=100000 if othergood=="TATA a/c vehicle"

replace numbergoods_car=1 if othergood=="Tata ace vehicle"
replace goodtotalamount_car=100000  if othergood=="Tata ace vehicle"

replace numbergoods_car=1 if othergood=="Television, Auto"
replace goodtotalamount_car=100000 if othergood=="Television, Auto"

replace numbergoods_car=1 if othergood=="Tractor"
replace goodtotalamount_car=100000 if othergood=="Tractor"

replace numbergoods_car=1 if othergood=="Van"
replace goodtotalamount_car=100000 if othergood=="Van"

replace numbergoods_car=1 if strpos(othergood,"Fan, mixey, grinder, auto")
replace goodtotalamount_car=100000  if strpos(othergood,"Fan, mixey, grinder, auto")

replace numbergoods_car=1 if strpos(othergood,"Tv,mixey, grinder, fan,Ac, tractor,")
replace goodtotalamount_car=100000 if strpos(othergood,"Tv,mixey, grinder, fan,Ac, tractor,")

*Bike
*br if strpos(othergood, "Three wheeler scooty for his disable")
replace numbergoods_bike=1 if strpos(othergood,"Three wheeler scooty for his disable")

*We create tv
gen numbergoods_TV=0
replace numbergoods_TV=1 if strpos(othergood,"Television")
replace numbergoods_TV=1 if strpos(othergood,"television")
replace numbergoods_TV=1 if strpos(othergood,"TV")
replace numbergoods_TV=1 if strpos(othergood,"Tv")
replace numbergoods_TV=1 if strpos(othergood,"tv")

gen goodtotalamount_TV=.
replace goodtotalamount_TV=numbergoods_TV*1000


*goodtotalamount
gen goodtotalamount_DVD=0
gen goodtotalamount_camera=0

egen goodtotalamount=rowtotal(goodtotalamount_car goodtotalamount_cookgas goodtotalamount_computer goodtotalamount_antenna goodtotalamount_bike goodtotalamount_fridge goodtotalamount_furniture goodtotalamount_tailormach goodtotalamount_phone goodtotalamount_landline goodtotalamount_DVD goodtotalamount_camera goodtotalamount_TV)
recode goodtotalamount (.=0)


**********ASSETS
egen assets=rowtotal(amountownland livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock livestockamount_bullforploughing housevalue goldquantityamount goodtotalamount)
egen assets_noland=rowtotal(livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock housevalue goldquantityamount goodtotalamount)


save"NEEMSIS2-HH_v11.dta", replace
****************************************
* END











****************************************
* Cognition
****************************************
use"NEEMSIS2-HH_v11.dta", clear

***Raven
*right answers
gen set_a1=4
gen set_a2=5
gen set_a3=1
gen set_a4=2
gen set_a5=6
gen set_a6=3
gen set_a7=6
gen set_a8=2
gen set_a9=1
gen set_a10=3
gen set_a11=4
gen set_a12=5

gen set_ab1=4
gen set_ab2=5
gen set_ab3=1
gen set_ab4=6
gen set_ab5=2
gen set_ab6=1
gen set_ab7=3
gen set_ab8=4
gen set_ab9=6
gen set_ab10=3
gen set_ab11=5
gen set_ab12=2

gen set_b1=2
gen set_b2=6
gen set_b3=1
gen set_b4=2
gen set_b5=1
gen set_b6=3
gen set_b7=5
gen set_b8=6
gen set_b9=4
gen set_b10=3
gen set_b11=4
gen set_b12=5

*Number of correct answers
forval i=1(1)12 {
gen ra`i'=0 	if a`i' !=.
gen rab`i'=0 	if ab`i' !=.
gen rb`i'=0 	if b`i' !=.
}
forval i=1(1)12 {
replace ra`i'=1  if a`i'==set_a`i' 	
replace rab`i'=1 if ab`i'==set_ab`i' 
replace rb`i'=1  if b`i'==set_b`i' 
}	
drop set_a1-set_a12
drop set_ab1-set_ab12
drop set_b1-set_b12

*Total score 
egen set_a = rowtotal (ra1 ra2 ra3 ra4 ra5 ra6 ra7 ra8 ra9 ra10 ra11 ra12), missing
egen set_ab = rowtotal (rab1 rab2 rab3 rab4 rab5 rab6 rab7 rab8 rab9 rab10 rab11 rab12), missing 
egen set_b = rowtotal (rb1 rb2 rb3 rb4 rb5 rb6 rb7 rb8 rb9 rb10 rb11 rb12), missing
egen raven_tt = rowtotal (set_a set_b set_ab)
tab1 set_a set_ab set_b raven_tt


*********Numeracy & literacy
global literacy canreadcard1a canreadcard1b canreadcard1c canreadcard2
global numeracy numeracy1 numeracy2 numeracy3 numeracy4 numeracy5 numeracy6
global cog $literacy $numeracy

*composite score
*recode no response as missing for easier analysis
foreach x of varlist $cog {
recode `x' (99=.) 
}
foreach x of varlist $numeracy {
recode `x' (2=0)
}
foreach x of varlist $literacy {
recode `x' (1=0) (3=1) (2=0.5) 
}
**Look at missing values 	
mdesc $cog

mdesc $literacy if canreadcard1a==. //those are mostly the same people 
tab edulevel if canreadcard1a==. //code as can't read if edulevel max primary completed 
gen refuse=0
replace refuse=1 if (canreadcard1a+canreadcard1b+canreadcard1c+canreadcard2==.)
recode $literacy (.=0) if edulevel<=1

mdesc numeracy6 numeracy5 numeracy4 numeracy3 numeracy2 if numeracy1==. 
tab edulevel if numeracy1==. 
replace refuse=1 if (numeracy1+numeracy2+numeracy3+numeracy4+numeracy5+numeracy6==.)

recode numeracy6 numeracy5 numeracy4 numeracy3 numeracy2 numeracy1 (.=0) if edulevel<=1	

egen num_tt = rowtotal(numeracy1 numeracy2 numeracy3 numeracy4 numeracy5 numeracy6), missing 
egen lit_tt = rowtotal(canreadcard1a canreadcard1b canreadcard1c canreadcard2), missing 



*********Cleaning
global big5 ///
curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts  ///
workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers ///
managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm ///
tryhard  stickwithg~s   goaftergoal finishwhat~n finishtasks  keepworking

global locus locuscontrol1 locuscontrol2 locuscontrol3 locuscontrol4 locuscontrol5 locuscontrol6 

mdesc $big5 $locus

alpha curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination, casewise  // .74
alpha organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties, casewise  // .65 
alpha enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts, casewise  // .64 
alpha workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers, casewise  // .54 
alpha managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm, casewise  // .66 
alpha tryhard  stickwithg~s   goaftergoal finishwhat~n finishtasks  keepworking, casewise  // .66 
alpha $locus, casewise  // nickel

*recode all so that more is better! 
foreach var of varlist $big5 {
recode `var' (5=1) (4=2) (3=3) (2=4) (1=5)
}


**Correction du biais d'"acquiescence"
*Paires
local varlist ///
rudetoother helpfulwit~s  ///
putoffduties 	completedut~s /// 
easilydistracted makeplans  ///
shywithpeople talktomany~e ///
repetitive~s curious  ///
nervous staycalm ///  
worryalot managestress 

tab rudetoother helpfulwit~s,  cell  // AG
tab putoffduties completedut~s, nofreq cell  // acquiesence bias CO
tab easilydistracted makeplans, nofreq cell  // same.. CO
tab shywithpeople talktomany~e, nofreq cell  // EX
tab repetitive~s curious, nofreq cell  // same.. OP
tab nervous staycalm, nofreq cell  // same.. ES
tab worryalot managestress, nofreq cell  // same.. ES


*moyenne
egen ars=rowmean(`varlist') 
tabstat ars, stat(n mean sd q min max)
ttest ars==3
tab ars
gen ars2=ars-3  
sum ars 
ttest ars=3 
*recode reversely coded items 
foreach var of varlist rudetoother putoffduties easilydistracted shywithpeople repetitive~s nervous changemood feeldepres easilyupset worryalot {
gen raw_`var' = `var' 	
recode `var' (5=1) (4=2) (3=3) (2=4) (1=5)
}
*corrected items: 
foreach var of varlist $big5 {
gen cr_`var'=`var'-ars2 if ars!=. 
}
	
**Moyenne pour avoir les traits
egen cr_OP = rowmean(cr_curious cr_interested~t   cr_repetitive~s cr_inventive cr_liketothink cr_newideas cr_activeimag~n)
egen cr_CO = rowmean(cr_organized  cr_makeplans cr_workhard cr_appointmen~e cr_putoffduties cr_easilydist~d cr_completedu~s) 
egen cr_EX = rowmean(cr_enjoypeople cr_sharefeeli~s cr_shywithpeo~e  cr_enthusiastic  cr_talktomany~e  cr_talkative cr_expressing~s ) 
egen cr_AG = rowmean(cr_workwithot~r   cr_understand~g cr_trustingof~r cr_rudetoother cr_toleratefa~s  cr_forgiveother  cr_helpfulwit~s) 
egen cr_ES = rowmean(cr_managestress  cr_nervous  cr_changemood cr_feeldepres~d cr_easilyupset cr_worryalot  cr_staycalm) 
egen cr_Grit = rowmean(cr_tryhard  cr_stickwithg~s   cr_goaftergoal cr_finishwhat~n cr_finishtasks  cr_keepworking)

egen OP = rowmean(curious interested~t  repetitive~s inventive liketothink newideas activeimag~n)
egen CO = rowmean(organized  makeplans workhard appointmen~e putoffduties easilydist~d completedu~s) 
egen EX = rowmean(enjoypeople sharefeeli~s shywithpeo~e enthusiastic talktomany~e  talkative expressing~s ) 
egen AG = rowmean(workwithot~r understand~g trustingof~r rudetoother toleratefa~s forgiveother helpfulwit~s) 
egen ES = rowmean(managestress nervous changemood feeldepres~d easilyupset worryalot staycalm) 
egen Grit = rowmean(tryhard stickwithg~s  goaftergoal finishwhat~n finishtasks keepworking)


**Alpha
alpha curious 		interested~t   repetitive~s inventive liketothink newideas activeimag~n
alpha cr_curious cr_interested~t   cr_repetitive~s cr_inventive cr_liketothink cr_newideas cr_activeimag~n

alpha organized  makeplans workhard appointmen~e putoffduties easilydist~d completedu~s
alpha cr_organized  cr_makeplans cr_workhard cr_appointmen~e cr_putoffduties cr_easilydist~d cr_completedu~s
	
alpha enjoypeople sharefeeli~s shywithpeo~e  enthusiastic  talktomany~e  talkative expressing~s 
alpha cr_enjoypeople cr_sharefeeli~s cr_shywithpeo~e  cr_enthusiastic  cr_talktomany~e  cr_talkative cr_expressing~s
	
alpha workwithot~r   understand~g trustingof~r rudetoother toleratefa~s  forgiveother  helpfulwit~s
alpha cr_workwithot~r   cr_understand~g cr_trustingof~r cr_rudetoother cr_toleratefa~s  cr_forgiveother  cr_helpfulwit~s 
	
alpha managestress  nervous  changemood feeldepres~d easilyupset worryalot  staycalm 
alpha cr_managestress  cr_nervous  cr_changemood cr_feeldepres~d cr_easilyupset cr_worryalot  cr_staycalm
	
alpha tryhard  stickwithg~s   goaftergoal finishwhat~n finishtasks  keepworking	
alpha cr_tryhard  cr_stickwithg~s   cr_goaftergoal cr_finishwhat~n cr_finishtasks  cr_keepworking


save"NEEMSIS2-HH_v12.dta", replace
****************************************
* END








****************************************
* Cognition imputations for missings
****************************************
use"NEEMSIS2-HH_v12.dta", clear


global big5  ///
	cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts ///
	cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers /// 
	cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot cr_staycalm ///
	cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination ///
	cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties ///
	cr_tryhard cr_stickwithgoals cr_goaftergoal cr_finishwhatbegin cr_finishtasks cr_keepworking

global big5questionsnogrit curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople talkative expressingthoughts ///
workwithother understandotherfeeling trustingofother rudetoother toleratefaults forgiveother ///
helpfulwithothers managestress nervous changemood feeldepressed easilyupset worryalot staycalm
	
*1. Vérif des missings
gen nmiss=0
foreach x in $big5{
replace nmiss=nmiss+1 if `x'==.
}
tab nmiss
*2. Imputation avec les moyennes par sexe pour ne pas perdre des individus
foreach x in $big5{
gen im`x'=`x'
}
global big5i imcr_curious imcr_interestedbyart imcr_repetitivetasks imcr_inventive imcr_liketothink imcr_newideas imcr_activeimagination ///
imcr_organized imcr_makeplans imcr_workhard imcr_appointmentontime imcr_putoffduties imcr_easilydistracted imcr_completeduties ///
imcr_enjoypeople imcr_sharefeelings imcr_shywithpeople imcr_enthusiastic imcr_talktomanypeople imcr_talkative imcr_expressingthoughts ///
imcr_workwithother imcr_understandotherfeeling imcr_trustingofother imcr_rudetoother imcr_toleratefaults imcr_forgiveother ///
imcr_helpfulwithothers imcr_managestress imcr_nervous imcr_changemood imcr_feeldepressed imcr_easilyupset imcr_worryalot imcr_staycalm
forvalues j=1(1)3{
forvalues i=1(1)2{
foreach x in $big5i{
sum `x' if sex==`i' & caste==`j' & egoid!=0 & egoid!=.
replace `x'=r(mean) if `x'==. & sex==`i' & caste==`j' & egoid!=0 & egoid!=.
}
}
}
*3. Check imputations
replace nmiss=0 if egoid!=0 & egoid!=.
foreach x in $big5i{
replace nmiss=nmiss+1 if `x'==.
}
tab nmiss egoid, m
drop nmiss


********** Imputation for non corrected
global big5 ///
curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts  ///
workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers ///
managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm ///
tryhard  stickwithgoals   goaftergoal finishwhatbegin finishtasks  keepworking
foreach x in $big5{
gen im`x'=`x'
}
forvalues j=1(1)3{
forvalues i=1(1)2{
foreach x in $big5{
sum `x' if sex==`i' & caste==`j' & egoid!=0 & egoid!=.
replace `x'=r(mean) if `x'==. & sex==`i' & caste==`j' & egoid!=0 & egoid!=.
}
}
}




global big5i imcr_curious imcr_interestedbyart imcr_repetitivetasks imcr_inventive imcr_liketothink imcr_newideas imcr_activeimagination ///
imcr_organized imcr_makeplans imcr_workhard imcr_appointmentontime imcr_putoffduties imcr_easilydistracted imcr_completeduties ///
imcr_enjoypeople imcr_sharefeelings imcr_shywithpeople imcr_enthusiastic imcr_talktomanypeople imcr_talkative imcr_expressingthoughts ///
imcr_workwithother imcr_understandotherfeeling imcr_trustingofother imcr_rudetoother imcr_toleratefaults imcr_forgiveother ///
imcr_helpfulwithothers imcr_managestress imcr_nervous imcr_changemood imcr_feeldepressed imcr_easilyupset imcr_worryalot imcr_staycalm


factor $big5i, pcf fa(5)
rotate, promax 

save"NEEMSIS2-HH_v13.dta", replace
****************************************
* END






****************************************
* CLEANING
****************************************
use"NEEMSIS2-HH_v13.dta", clear

rename marriedid_o old_marriedid
rename egoid_p16 egoid_panel
drop*_p16
drop loandetails* loanlender* threemainloans_* 
drop *_o
drop selected_index1 selected_index2 selected_index3 selected_name1 selected_name2 selected_name3 selected_index1_2 selected_index2_2 selected_index3_2 selected_name1_2 selected_name2_2 selected_name3_2 selected_index1_3 selected_index2_3 selected_index3_3 selected_name1_3 selected_name2_3 selected_name3_3 _3selected_index1 _3selected_index2 _3selected_index3 _3selected_name1 _3selected_name2 _3selected_name3 _3selected_index1_2 _3selected_index2_2 _3selected_index3_2 _3selected_name1_2 _3selected_name2_2 _3selected_name3_2 _3ego2random_3_2 _3selected_index1_3 _3selected_index2_3 _3selected_index3_3 _3selected_name1_3 _3selected_name2_3 _3selected_name3_3 _3ego2random_1_3 _3ego2random_2_3 _3ego2random_3_3
drop joinnamehhmemberego1 joinnamehhmember join_1825 join_2635 join_36 _3join_1825 _3join_2635 _3join_36
drop setofrandom_draws_3 setofrandom_draws_2 setofrandom_draws setof_3random_draws_3 setof_3random_draws_2 setof_3random_draws random_draws_count random_draws_3_count random_draws_2_count ego2random_3_3 ego2random_3_2 ego2random_3 ego2random_2_3 ego2random_2_2 ego2random_2 ego2random_1_3 ego2random_1_2 ego2random_1 _3random_draws_count _3random_draws_3_count _3random_draws_2_count _3ego2random_3 _3ego2random_2_2 _3ego2random_2 _3ego2random_1_2 _3ego2random_1
drop uniquelistego2 uniquelistego1 unique_draws_3 unique_draws_2 unique_draws _3unique_draws_3 _3unique_draws_2 _3unique_draws

drop _2businessloandetails_count _2contactgroup_count _2covsntypehelpgivengroup_count _2covsntypehelpreceivedgroup_cou _2formalsocialcapital_count _2indoccupmonths_count _3businessloandetails_count _3contactgroup_count _3count_eligible_1825 _3count_eligible_2635 _3count_eligible_36 _3covsntypehelpgivengroup_count _3covsntypehelpreceivedgroup_cou _3ego2index_1825 _3ego2index_2635 _3ego2index_36 _3formalsocialcapital_count _3indoccupmonths_count _3show_draws_2_count _3show_draws_3_count _3show_draws_count


drop reasonnoinsurance_1 reasonnoinsurance_2 reasonnoinsurance_3
drop usemobilefinancetype_1 usemobilefinancetype_4 usemobilefinancetype_3 usemobilefinancetype_2 usemobilefinancetype_77
drop reservationgrade_12 reservationgrade_10 reservationgrade_7 reservationgrade_9 reservationgrade_8 reservationgrade_6 reservationgrade_11 reservationgrade_3 reservationgrade_16 reservationgrade_15 reservationgrade_5 reservationgrade_4 reservationgrade_1 reservationgrade_2 reservationkind_3 reservationkind_1 reservationkind_2 reservationkind_5 reservationkind_77 reasonneverattendedschool_13 reasonneverattendedschool_1 reasonneverattendedschool_7 reasonneverattendedschool_11 reasondropping_1 reasondropping_11 reasondropping_7 reasondropping_2 reasondropping_5 reasondropping_15 reasondropping_9 reasondropping_77 reasondropping_12 kindofworkinactive_1 kindofworkinactive_2 kindofworkinactive_3 kindofworkinactive_4 kindofworkinactive_5 kindofworkinactive_6 kindofworkinactive_7 kindofworkinactive_8 migrationjoblist_1 migrationjoblist_2 migrationjoblist_3 migrationjoblist_4 migrationjoblist_5 migrationjoblist_6 migrationjoblist_7 migrationjoblist_8 migrationjoblist_9
drop relationwithborrower_7 relationwithborrower_3 relationwithborrower_8 relationwithborrower_5
drop goldreasonpledge_1 goldreasonpledge_2 goldreasonpledge_3 goldreasonpledge_4 goldreasonpledge_5 goldreasonpledge_6 goldreasonpledge_7 goldreasonpledge_8 goldreasonpledge_9 goldreasonpledge_10 goldreasonpledge_11 goldreasonpledge_12 goldreasonpledge_77
drop reservationkind_4 reasonneverattendedschool_5 reasonneverattendedschool_4 reasonneverattendedschool_6 reasonneverattendedschool_8 reasonneverattendedschool_3 reasonneverattendedschool_10 reasonneverattendedschool_12 reasondropping_3 reasondropping_4 reasondropping_6 reasondropping_13 reasondropping_10 relationwithborrower_6 relationwithborrower_9 relationwithborrower_2 relationwithborrower_13 relationwithborrower_11 reasondropping_8 relationwithborrower_1
drop reasonnoland_1 reasonnoland_2 reasonnoland_3 reasonnoland_4 reasonnoland_77 drywetownland_2 drywetownland_1 waterfromownland_3 waterfromownland_5 drywetleaseland_1 drywetleaseland_2 waterfromleaseland_5 waterfromleaseland_3 landleaserrelation_8 productlist_1 productlist_2 productlist_3 productlist_4 productlist_5 productlist_6 productlist_7 productlist_8 productlist_9 productlist_10 productlist_11 productlist_12 productlist_13 productlist_14 productlist_77
drop covexpensesdecrease_1 covexpensesdecrease_4 covexpensesdecrease_3 covexpensesdecrease_7 covexpensesdecrease_2 covexpensesdecrease_5 covexpensesdecrease_6 covexpensesdecrease_9 covexpensesdecrease_8 covexpensesincrease_3 covexpensesincrease_8 covexpensesincrease_1 covexpensesincrease_2 covexpensesincrease_9 covexpensesincrease_4 covexpensesincrease_7 covexpensesincrease_6 covexpensesstable_9 covexpensesstable_5 covexpensesstable_3 covexpensesstable_4 covexpensesstable_6 covexpensesstable_8 listgoods_1 listgoods_2 listgoods_3 listgoods_4 listgoods_5 listgoods_6 listgoods_7 listgoods_8 listgoods_9 listgoods_10 listgoods_11 listgoods_12 listgoods_77 listgoods_13
drop howbuyhouse_2 howbuyhouse_7 howbuyhouse_5 howbuyhouse_4 howbuyhouse_1 schemeslist_2 schemeslist_3 schemeslist_4 schemeslist_5 schemeslist_6 schemeslist_7 schemeslist_8 schemeslist_9 schemeslist_18 schemeslist_19 schemeslist_21 schemeslist_23 covrationcarduse_2 covrationcarduse_1 covrationcarduse_3 waterfromownland_1 waterfromownland_2 waterfromownland_4 waterfromleaseland_2 waterfromleaseland_1 landpurchasedhowbuy_2 landpurchasedhowbuy_4 landpurchasedhowbuy_1 landpurchasedhowbuy_3 landleaserrelation_2 landleaserrelation_1 landleaserrelation_10 landleaserrelation_5 landleasingrelation_10 landleasingrelation_2 landleasingrelation_1 landleasingrelation_8 productlist_15 covsubsistencereason_1 covsubsistencereason_2 covsubsistencereason_3 covsubsistencereason_77 covexpensesincrease_5 covexpensesstable_1 covexpensesstable_7 covexpensesstable_2 howbuyhouse_3 howbuyhouse_6 rationcardreasonnouse_6 rationcardreasonnouse_2 rationcardreasonnouse_1
dropmiss, force

tab HHID2010
duplicates tag parent_key INDID, gen(tag)
tab tag
preserve
keep if tag==1
dropmiss, force
restore


save"NEEMSIS2-HH_v14.dta", replace
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


use"NEEMSIS2-HH_v14.dta", clear
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

save"NEEMSIS2-HH_v15.dta", replace
****************************************
* END

