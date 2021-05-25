cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
4 mars 2021
-----
TITLE: MERGE pour avoir une belle base HH

-------------------------
*/

global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS1\DATA"


cd "$directory"


****************************************
* tracking + EGO + panel unique id
****************************************
use"NEEMSIS-HH.dta", clear
*tracking
merge m:1 HHID2010 using "NEEMSIS-HH_May2019.dta", keepusing(villageid_new villageid_new_comments tracked)
drop _merge

*ego
merge 1:1 HHID INDID using "NEEMSIS-ego_tomerge_panel.dta"
drop _merge
rename HHID parent_key
recode dummydemonetisation (.=0)

*panel unique id
merge m:m HHID2010 using "unique_identifier_panel.dta", keepusing(HHID_panel)
drop if _merge==2
drop _merge

save"NEEMSIS1-HH_v2.dta", replace
****************************************
* END





****************************************
* Occupation
****************************************
use"NEEMSIS-occupation_alllong.dta", clear

rename HHID parent_key
order HHID2010 parent_key INDID INDID2010
destring hoursayear, replace



**********EGO
/*
      egoid |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      1,743       64.65       64.65
          1 |        489       18.14       82.79
          2 |        464       17.21      100.00
------------+-----------------------------------
      Total |      2,696      100.00
*/
merge m:1 parent_key INDID using "NEEMSIS1-HH_v2.dta", keepusing(egoid dummymainoccup mainoccuptype othermainoccup maxhoursayear_ego dummyworkedpastyear workedpastyear_ego)
drop if _merge==2
drop _merge
rename maxhoursayear_ego maxhoursayear

*Ego moc
destring hoursayear maxhoursayear, replace
gen mainoccup=kindofwork if hoursayear==maxhoursayear & dummymainoccup==1
gen mainoccupname=occupationname if hoursayear==maxhoursayear & dummymainoccup==1

*If it is not?
tab dummymainoccup
gen _tempmocego=1 if othermainoccup==occupationname & dummymainoccup==0
replace mainoccup=kindofwork if _tempmocego==1
replace mainoccupname=occupationname if _tempmocego==1
*Checking
preserve
bysort HHID2010 INDID: gen n=_n
keep if n==1
tab mainoccup ego, m
restore
*For the rest? mainoccuptype
bysort HHID2010 INDID: egen mainok=max(mainoccup)
tab mainok, m
replace mainoccup=kindofwork if mainoccuptype==kindofwork & mainok==.
replace mainoccupname=occupationname if mainoccuptype==kindofwork & mainok==.
drop mainok
bysort HHID2010 INDID: egen mainok=max(mainoccup)
tab mainok ego, m
*For the rest rest? Alamano
sort HHID2010 INDID
list HHID2010 INDID occupationid occupationname kindofwork othermainoccup if dummymainoccup==0 & mainoccupname=="", clean noobs
preserve
keep if ego!=0 & mainok==. & othermainoccup!=""
keep HHID2010 occupationid INDID othermainoccup occupationname kindofwork mainoccuptype
order HHID2010 INDID occupationid occupationname kindofwork mainoccuptype othermainoccup
sort HHID2010 INDID occupationid
*export excel using "NEEMSIS-occupations.xlsx", nolab replace firstrow(var)
restore
*À partir du fichier Excel
replace mainoccup=4 if HHID2010=="ANDNAT365" & INDID==3 & occupationid==1
replace mainoccupname="Nrega" if HHID2010=="ANDNAT365" & INDID==3 & occupationid==1

drop mainok
bysort HHID2010 INDID: egen mainok=max(mainoccup)
tab mainok ego, m





**********Indiv
*max income or hours (income only for 2010)
bysort HHID2010 INDID : egen maxhours_indiv=max(hoursayear)
*occup name and occup type with the max
replace mainoccup=kindofwork if maxhours_indiv==hoursayear
replace mainoccupname=occupationname if maxhours_indiv==hoursayear
drop mainok
bysort HHID2010 INDID: egen mainok=max(mainoccup)
tab mainok ego, m
gen dummymoc=0
replace dummymoc=1 if mainoccup!=.
tab dummymoc // 1324 normalement
	*Check duplicates
	duplicates tag HHID2010 INDID egoid if dummymoc==1, gen(tag)
	tab tag
	sort tag HHID2010 INDID occupationid
		*apply max income
		bysort HHID2010 INDID: egen maxincome=max(annualincome) if tag>0
		replace mainoccup=. if maxincome!=annualincome & tag>0
		replace mainoccupname="" if maxincome!=annualincome & tag>0
		drop mainok
		drop dummymoc
		drop tag
		bysort HHID2010 INDID: egen mainok=max(mainoccup)
		tab mainok ego, m
		gen dummymoc=0
		replace dummymoc=1 if mainoccup!=.
		tab dummymoc // 1135 normalement
		*Check duplicates
		duplicates tag HHID2010 INDID ego if dummymoc==1, gen(tag)
		tab tag
		sort tag HHID2010 INDID occupationid
			*apply occupation order
			bysort HHID2010 INDID: egen minnumber=min(occupationid) if tag>0
			replace mainoccup=. if minnumber!=occupationid & tag>0
			replace mainoccupname="" if minnumber!=occupationid & tag>0
			drop mainok
			drop dummymoc
			drop tag
			bysort HHID2010 INDID: egen mainok=max(mainoccup)
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
bysort HHID2010 INDID : egen mainoccupation=max(mainoccup)
bysort HHID2010 INDID : egen mainoccupationname=max(mainoccupnamenumeric)
*put the label
label values mainoccupation kindofwork
label values mainoccupationname mainoccupnamenumeric
*decode the name to compare between the waves
decode mainoccupationname, gen(_mainoccupationname)
drop mainoccupationname
rename _mainoccupationname mainoccupationname
*total income
bysort HHID2010 INDID: egen annualincome_indiv=sum(annualincome)
*nb of income sources
fre kindofwork
gen countoccupation=1
bysort HHID2010 INDID: egen nboccupation_indiv=sum(countoccupation)
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
keep mainoccupation_indiv mainoccupation_hours_indiv mainoccupation_income_indiv mainoccupationname_indiv annualincome_indiv nboccupation_indiv mainoccupation_HH annualincome_HH nboccupation_HH HHID2010 INDID labourincome_indiv_agri labourincome_indiv_selfemp labourincome_indiv_sjagri labourincome_indiv_sjnonagri labourincome_indiv_uwhhnonagri labourincome_indiv_uwnonagri labourincome_indiv_uwhhagri labourincome_indiv_uwagri labourincome_HH_agri labourincome_HH_selfemp labourincome_HH_sjagri labourincome_HH_sjnonagri labourincome_HH_uwhhnonagri labourincome_HH_uwnonagri labourincome_HH_uwhhagri labourincome_HH_uwagri
save"NEEMSIS-occupation_alllong_v2.dta", replace

bysort HHID2010: gen n=_n 
keep if n==1
keep mainoccupation_HH annualincome_HH nboccupation_HH HHID2010 labourincome_HH_agri labourincome_HH_selfemp labourincome_HH_sjagri labourincome_HH_sjnonagri labourincome_HH_uwhhnonagri labourincome_HH_uwnonagri labourincome_HH_uwhhagri labourincome_HH_uwagri
save"NEEMSIS-occupation_alllong_v3.dta", replace


**********Merge dans la base HH
use"NEEMSIS1-HH_v2.dta", clear

merge 1:1 HHID2010 INDID using "NEEMSIS-occupation_alllong_v2.dta", keepusing(mainoccupation_indiv mainoccupation_hours_indiv mainoccupation_income_indiv mainoccupationname_indiv annualincome_indiv nboccupation_indiv labourincome_indiv_agri labourincome_indiv_selfemp labourincome_indiv_sjagri labourincome_indiv_sjnonagri labourincome_indiv_uwhhnonagri labourincome_indiv_uwnonagri labourincome_indiv_uwhhagri labourincome_indiv_uwagri)
drop _merge

merge m:1 HHID2010 using "NEEMSIS-occupation_alllong_v3.dta", keepusing(mainoccupation_HH annualincome_HH nboccupation_HH labourincome_HH_agri labourincome_HH_selfemp labourincome_HH_sjagri labourincome_HH_sjnonagri labourincome_HH_uwhhnonagri labourincome_HH_uwnonagri labourincome_HH_uwhhagri labourincome_HH_uwagri)
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
* Education & caste
****************************************
use"NEEMSIS1-HH_v3.dta", clear

*Education
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
tab edulevel, m
tab edulevel livinghome, m
list INDID2010 age if edulevel==. & livinghome==1, clean noobs
recode edulevel (.=0)
tab edulevel

*Caste
tab caste
gen caste_group=.
foreach x in 2 3{
replace caste_group=1 if caste==`x'
}
foreach x in 1 5 7 8 10 12 15 16{
replace caste_group=2 if caste==`x'
}
foreach x in 4 6 9 11 13 17{
replace caste_group=3 if caste==`x'
}
label define castecat 1"Dalits" 2"Middle" 3"Upper", replace
label values caste_group castecat
tab caste_group
label values caste caste
rename caste jatis
rename caste_group caste
tab jatis caste


save"NEEMSIS1-HH_v4.dta", replace
****************************************
* END







****************************************
* Assets
****************************************
use"NEEMSIS1-HH_v4.dta", clear

**********Gold
gen goldquantityamount=goldquantity*2700
bysort HHID2010 : egen goldquantityamount2=max(goldquantityamount)
drop goldquantityamount
rename goldquantityamount2 goldquantityamount
recode goldquantityamount (.=0)

**********Land
replace drywetownland="3" if drywetownland=="1 2"
destring drywetownland, replace
*in 2016: 6 lakhs for dry land and 8 lakhs for wet land
gen	amountownlanddry=600000*sizeownland if drywetownland==1
gen	amountownlandwet=800000*sizeownland if drywetownland==2
preserve
duplicates drop HHID2010, force
sort HHID2010
list HHID2010 villageid if drywetownland==3
restore
/*

     +-------------------------------------------------------------------+
     |                                      HHID     HHID2010   vill~eid |
     |-------------------------------------------------------------------|
  3. | uuid:fa73ad2c-c373-4292-96ad-4e4830209e5d          100        KOR |
 20. | uuid:35591049-0c3e-4dac-836a-958f07745c35           22        KUV |
 26. | uuid:3f9cffe9-c7a8-4057-afd6-b2e14e4a36b8           28      MANAM |
 28. | uuid:0542e203-ec33-4e6a-8b6a-17b574ce9bf8            3        KAR |
 38. | uuid:5c1a711d-d214-4c67-94b7-2eb8ed6009cd           39        KOR |
     |-------------------------------------------------------------------|
 54. | uuid:877d0560-5981-491b-b780-6585bf924814           53        SEM |
 57. | uuid:8961de1a-1258-45d6-8a77-1b3800aa2f8e           56        KUV |
 67. | uuid:9f14556f-8aa4-42d1-a8e8-d82f3d40e3d3           65        KOR |
104. | uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006           99        KAR |
112. | uuid:6b162917-4b4d-4787-a719-3fe27af6f755      ADGP194        GOV | 6 acre wet and 0 dry in 2010
     |-------------------------------------------------------------------|
115. | uuid:a6097c43-dd3b-40d0-9d42-7350ecbd35ab      ADGP197        GOV | 5W/0D
129. | uuid:89f0734d-db4a-4660-8c9f-c54fcd6f8ddb      ADKU139        KUV | 1W/0D
153. | uuid:8ddf086d-0993-4ff7-813b-1f63dd46b1bf    ANDMTP322      MANAM | 7W/0D
154. | uuid:31eb18f2-0c0f-40cc-92f8-40289ba87ddb    ANDMTP323      MANAM | 6W/0D
187. | uuid:4127118b-59ff-4db1-a857-1641b70415c9   ANTKARU279        KAR | 4.5W/0D
     |-------------------------------------------------------------------| 
188. | uuid:8aeef32f-8d22-481b-8e71-cbfe49fea98e   ANTKARU280        KAR | 5W/0D
199. | uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919      ANTMP40        MAN | 0.25W/0D
207. | uuid:78817304-5ca2-42d3-9b67-843366b5afde    ANTNAT360        NAT | 0W/6D
209. | uuid:5ddaed64-11cb-4a8a-a146-951b9d041a2a    ANTNAT362        NAT | 0W/5D
250. | uuid:e73b9bd7-f7f3-4ac0-b360-ffcd09758ff4      PSMPO15        MAN | 2W/0D
     |-------------------------------------------------------------------|
280. | uuid:8380069d-0c7d-41f6-b487-dd4e66377170      PSSEM91        SEM | 1W/0D
313. | uuid:3ed13d21-3fbd-4a33-a557-48b68f5ed065      RAKU142        KUV | 2W/0D
409. | uuid:65046bab-4328-4b56-b76f-1e4144ee8dd0     SINAT332        NAT | 0W/0D
453. | uuid:96b99b66-dee2-4a30-806e-fd734d974812    VENKOR221        KOR | 0W/1D
463. | uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c     VENMPO29        MAN | 0.25W/0D
     |-------------------------------------------------------------------|
468. | uuid:e847a4d4-ea2a-4a01-95f2-25a37de516e9     VENMPO34        MAN | 1W/0D
473. | uuid:bf24520a-2493-421c-8cdc-cfdea3c93699    VENNAT350        NAT | 0W/8D
     +-------------------------------------------------------------------+
*/
gen amountownland=700000*sizeownland if HHID2010=="100" | HHID2010=="22" | HHID2010=="28" | HHID2010=="3" | HHID2010=="39" | HHID2010=="53" | HHID2010=="56" | HHID2010=="65" | HHID2010=="99"
*For the rest (HH who is interviewed in 2010, I looked at the 2010 values)
*with "Base RUME_Main variables.dta"
preserve
duplicates drop HHID2010, force
sort HHID2010
list HHID2010 sizeownland if drywetownland==3, clean noobs
restore
/*
       ADGP194          9  6W/3D
       ADGP197          6  5W/1D
       ADKU139          3  1W/2D
     ANDMTP322          5  
     ANDMTP323         10  6W/4D
    ANTKARU279        3.5  
    ANTKARU280        6.5  5W/1.5D
       ANTMP40          1  0.25W/0.75D
     ANTNAT360          6  6D
     ANTNAT362          4  
       PSMPO15          2  2W
       PSSEM91        1.5  1W/0.5D
       RAKU142          2  2W
      SINAT332          1  0.5/0.5
     VENKOR221          1  1D
      VENMPO29          2  0.25W/1.75D
      VENMPO34          1  1W
     VENNAT350         10 2W/8D
*/
replace amountownland=6*800000+3*600000 if HHID2010=="ADGP194"
replace amountownland=5*800000+1*600000 if HHID2010=="ADGP197"
replace amountownland=1*800000+2*600000 if HHID2010=="ADKU139"
*Half
replace amountownland=2.5*800000+2.5*600000 if HHID2010=="ANDMTP322"
replace amountownland=6*800000+4*600000 if HHID2010=="ANDMTP323"
*Half
replace amountownland=1.75*800000+1.75*600000 if HHID2010=="ANTKARU279"
replace amountownland=5*800000+1.5*600000 if HHID2010=="ANTKARU280"
replace amountownland=0.25*800000+0.75*600000 if HHID2010=="ANTMP40"
replace amountownland=6*600000 if HHID2010=="ANTNAT360"
*Half
replace amountownland=2*800000+2*600000 if HHID2010=="ANTNAT362"
replace amountownland=2*800000 if HHID2010=="PSMPO15"
replace amountownland=1*800000+0.5*600000 if HHID2010=="PSSEM91"
replace amountownland=2*800000 if HHID2010=="RAKU142"
replace amountownland=0.5*800000+0.5*600000 if HHID2010=="SINAT332"
replace amountownland=1*600000 if HHID2010=="VENKOR221"
replace amountownland=0.25*800000+1.75*600000 if HHID2010=="VENMPO29"
replace amountownland=1*800000 if HHID2010=="VENMPO34"
replace amountownland=2*800000+8*600000 if HHID2010=="VENNAT350"

*For which i have details
recode amountownlanddry amountownlandwet (.=0)
replace amountownland=amountownlanddry+amountownlandwet if amountownland==.

**********Livestock
foreach x in cow goat chicken bullock {
clonevar livestockamount_`x'=livestockprice_`x'
recode livestockamount_`x' (.=0)
}

**********Good total amount

rename numbergoods_frigde numbergoods_fridge
rename goodyearpurchased_frigde goodyearpurchased_fridge
rename goodtotalamount_frigde goodtotalamount_fridge
rename goodbuying_frigde goodbuying_fridge

egen goodtotalamount=rowtotal(goodtotalamount_car goodtotalamount_cookgas goodtotalamount_computer goodtotalamount_antenna goodtotalamount_bike goodtotalamount_fridge goodtotalamount_furniture goodtotalamount_tailormach goodtotalamount_phone goodtotalamount_landline goodtotalamount_DVD goodtotalamount_camera)
recode goodtotalamount (.=0)

egen assets=rowtotal(amountownland livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock housevalue goldquantityamount goodtotalamount)

egen assets_noland=rowtotal(livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock housevalue goldquantityamount goodtotalamount)



gen year=2016


**********Panel?
merge m:1 HHID2010 using "panel_comp.dta"
keep if _merge==3
drop _merge



********** Total income
*Annual income
recode annualincome_indiv annualincome_HH (.=0)

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


*Verif
gen test=totalincome_indiv-annualincome_indiv
tab test
drop test

gen test=totalincome_HH-annualincome_HH
tab test
drop test

tab totalincome_indiv
sort totalincome_indiv
tab totalincome_HH


save"NEEMSIS1-HH_v5.dta", replace
****************************************
* END
