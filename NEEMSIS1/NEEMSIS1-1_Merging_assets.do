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

global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS1"


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
recode dummydemonetisation (.=0)

*panel unique id
merge m:m HHID using "unique_identifier_panel.dta", keepusing(HHID_panel)
drop if _merge==2
rename HHID parent_key
drop _merge

*indiv panel
rename INDID INDID2016
tostring INDID2016, replace
merge 1:m HHID_panel INDID2016 using "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\Individual_panel\code_indiv_2010_2016_2020_wide.dta", keepusing(INDID_panel)
keep if _merge==3
drop _merge

*year
gen year=2016

rename INDID2016 INDID
destring INDID, replace

save"NEEMSIS1-HH_v2.dta", replace
****************************************
* END











****************************************
* Education & caste
****************************************
use"NEEMSIS1-HH_v2.dta", clear

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


save"NEEMSIS1-HH_v3.dta", replace
****************************************
* END







****************************************
* Assets
****************************************
use"NEEMSIS1-HH_v3.dta", clear

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
gen	amountownlandwet_as2010=1100000*sizeownland if drywetownland==2

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
gen amountownland_as2010=850000*sizeownland if HHID2010=="100" | HHID2010=="22" | HHID2010=="28" | HHID2010=="3" | HHID2010=="39" | HHID2010=="53" | HHID2010=="56" | HHID2010=="65" | HHID2010=="99"

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


********** as 2010

replace amountownland_as2010=6*1100000+3*600000 if HHID2010=="ADGP194"
replace amountownland_as2010=5*1100000+1*600000 if HHID2010=="ADGP197"
replace amountownland_as2010=1*1100000+2*600000 if HHID2010=="ADKU139"
*Half
replace amountownland_as2010=2.5*1100000+2.5*600000 if HHID2010=="ANDMTP322"
replace amountownland_as2010=6*1100000+4*600000 if HHID2010=="ANDMTP323"
*Half
replace amountownland_as2010=1.75*1100000+1.75*600000 if HHID2010=="ANTKARU279"
replace amountownland_as2010=5*1100000+1.5*600000 if HHID2010=="ANTKARU280"
replace amountownland_as2010=0.25*1100000+0.75*600000 if HHID2010=="ANTMP40"
replace amountownland_as2010=6*600000 if HHID2010=="ANTNAT360"
*Half
replace amountownland_as2010=2*1100000+2*600000 if HHID2010=="ANTNAT362"
replace amountownland_as2010=2*1100000 if HHID2010=="PSMPO15"
replace amountownland_as2010=1*1100000+0.5*600000 if HHID2010=="PSSEM91"
replace amountownland_as2010=2*1100000 if HHID2010=="RAKU142"
replace amountownland_as2010=0.5*1100000+0.5*600000 if HHID2010=="SINAT332"
replace amountownland_as2010=1*600000 if HHID2010=="VENKOR221"
replace amountownland_as2010=0.25*1100000+1.75*600000 if HHID2010=="VENMPO29"
replace amountownland_as2010=1*1100000 if HHID2010=="VENMPO34"
replace amountownland_as2010=2*1100000+8*600000 if HHID2010=="VENNAT350"


*For which i have details
recode amountownlanddry amountownlandwet amountownlandwet_as2010 (.=0)
replace amountownland=amountownlanddry+amountownlandwet if amountownland==.
replace amountownland_as2010=amountownlanddry+amountownlandwet_as2010 if amountownland_as2010==.


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

egen assets_as2010=rowtotal(amountownland_as2010 livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock housevalue goldquantityamount goodtotalamount)

egen assets_noland=rowtotal(livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock housevalue goldquantityamount goodtotalamount)



save"NEEMSIS1-HH_v4.dta", replace
****************************************
* END
