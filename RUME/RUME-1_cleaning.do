cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
16/04/2021
-----
TITLE: RUME

-------------------------
*/

global directory = "D:\Documents\_Thesis\_DATA\RUME\DATA"
cd "$directory"


****************************************
* RUME check
****************************************
use"Rume.dta", clear

keep HHID2010 _1_1_village _1_1_village_code _1_2_ur_colony _1_4_head_of_family _1_5_address _1_6_a_religion _1_6_b_caste _1_6_b_caste_code _1_7_lived _1_8_village_out year code_id_member name sex _1_d_relation age _1_f_stay _1_g_education _1_h_student_at_present _1_i_skills nuclear_family _18_1_1_a_land_type1 _18_1_2_a_land_type1 _18_1_b_nber_acres1 _18_1_c_water_from_11 _18_1_c_water_from_21 _18_1_1_a_land_type2 _18_1_2_a_land_type2 _18_1_b_nber_acres2 _18_1_c_water_from_12 _18_1_c_water_from_22 _18_1_1_a_land_type3 _18_1_2_a_land_type3 _18_1_b_nber_acres3 _18_1_c_water_from_13 _18_1_c_water_from_23 _15_1_a_house _15_1_d_estimated_value_house _15_1_e_type_house _16_1_c_house_title _16_1_d_own_other_house _13_1_a_quantity_gold__gram_ food_expenses_week__rs_ education_expenses_year__rs_ health_expenses_year__rs_ ceremonies_expenses_year__rs_ death_expenses_year__rs_ _15_1_a_house _15_1_b_how_buy_1 _15_1_b_how_buy_2 _15_1_b_how_buy_3 _15_1_c_rental_amount _15_1_d_estimated_value_house _15_1_e_type_house _15_1_f_size__room_ _16_1_a_electricity _16_1_b_water _16_1_c_house_title _16_1_d_own_other_house _16_1_e_if_yes__rented_income _16_1_e_if_yes__rented_income_co _21__a_goods1 _21__b_nber1 _21__c_year_of_purchase1 _21__d_payment_type1 _21__a_goods10 _21__b_nber10 _21__c_year_of_purchase10 _21__d_payment_type10 _21__a_goods2 _21__b_nber2 _21__c_year_of_purchase2 _21__d_payment_type2 _21__a_goods3 _21__b_nber3 _21__c_year_of_purchase3 _21__d_payment_type3 _21__a_goods4 _21__b_nber4 _21__c_year_of_purchase4 _21__d_payment_type4 _21__a_goods5 _21__b_nber5 _21__c_year_of_purchase5 _21__d_payment_type5 _21__a_goods6 _21__b_nber6 _21__c_year_of_purchase6 _21__d_payment_type6 _21__a_goods7 _21__b_nber7 _21__c_year_of_purchase7 _21__d_payment_type7 _21__a_goods8 _21__b_nber8 _21__c_year_of_purchase8 _21__d_payment_type8 _21__a_goods9 _21__b_nber9 _21__c_year_of_purchase9 _21__d_payment_type9

rename _1_1_village village
rename _1_1_village_code villageid
rename _1_2_ur_colony villagearea
rename _1_4_head_of_family headname
rename _1_5_address address
rename _1_6_a_religion religion
rename _1_6_b_caste jatis
drop _1_6_b_caste_code
rename _1_7_lived living
rename _1_8_village_out comefrom
rename code_id_member INDID
rename _1_d_relation relationshiptohead
rename _1_f_stay livinghome
rename _1_g_education education
label define education 1"Primary" 2"HS" 3"HSC" 4"Diploma" 5"Degree" 6"Post" 7"Engineer" 8"Other" 9"No edu"
label values education education
rename _1_h_student_at_present currentlyatschool
rename _1_i_skills othertypeeducation

rename _18_1_1_a_land_type1 land1type1
rename _18_1_2_a_land_type1 land1type2
rename _18_1_b_nber_acres1 land1acres
rename _18_1_c_water_from_11 land1water
drop _18_1_c_water_from_21
rename _18_1_1_a_land_type2 land2type1
rename _18_1_2_a_land_type2 land2type2
rename _18_1_b_nber_acres2 land2acres
rename _18_1_c_water_from_12 land2water
drop _18_1_c_water_from_22
rename _18_1_1_a_land_type3 land3type1
rename _18_1_2_a_land_type3 land3type2
rename _18_1_b_nber_acres3 land3acres
rename _18_1_c_water_from_13 land3water
drop _18_1_c_water_from_23
rename _13_1_a_quantity_gold__gram_ goldquantity
rename _15_1_a_house house
rename _15_1_d_estimated_value_house housevalue
rename _15_1_e_type_house housetype2
rename _16_1_c_house_title housetitle
rename _16_1_d_own_other_house ownotherhouse
rename _15_1_b_how_buy_1 howbuyhouse
rename _15_1_b_how_buy_2 howbuyhouse2
rename _15_1_b_how_buy_3 howbuyhouse3
rename _15_1_c_rental_amount rentalhouse
rename _15_1_f_size__room_ houseroom
rename _16_1_a_electricity electricity
rename _16_1_b_water water
rename _16_1_e_if_yes__rented_income otherhouserent
drop _16_1_e_if_yes__rented_income_co 
rename food_expenses_week__rs_ foodexpenses
rename education_expenses_year__rs_ educationexpenses
rename health_expenses_year__rs_ healthexpenses
rename ceremonies_expenses_year__rs_ ceremoniesexpenses
rename death_expenses_year__rs_ deathexpenses


*Relation
label define relation 1"Head" 2"Wife" 3"Mother" 4"Father" 5"Son" 6"Daughter" 7"Daughter-in-law" 8"Son-in-law" 9"Sister" 10"Mother-in-law" 11"Father-in-law" 12"Brother elder" 13"Brother younger" 14"Grand children" 15"Nobody" 77"Other"
label values relationshiptohead relation

clonevar relationshiptohead2=relationshiptohead
recode relationshiptohead2 (8=7) (7=8) (12=10) (13=10) (10=11) (11=12) (14=13)
label define relation2 1"Head" 2"Wife" 3"Mother" 4"Father" 5"Son" 6"Daughter" 7"Son-in-law" 8"Daughter-in-law" 9"Sister" 10"Brother" 11"Mother-in-law" 12"Father-in-law" 13"Grandchild" 16"Grandmother" 17"Cousin" 77"Other"
label values relationshiptohead2 relation2

tab relationshiptohead relationshiptohead2

tab livinghome
rename livinghome livinghome2

*Caste
destring jatis, replace
gen caste=.
foreach x in 2 3{
replace caste=1 if jatis==`x'
}
foreach x in 1 5 7 8 10 12 15 16{
replace caste=2 if jatis==`x'
}
foreach x in 4 6 9 11 13 17{
replace caste=3 if jatis==`x'
}
replace caste=77 if jatis==77
label define castecat 1"Dalits" 2"Middle" 3"Upper" 77"Other", replace
label values caste castecat
tab caste

label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"Mudaliar" 12"Kulalar" 13"Chettiyar" 14"Marwari" 15"Muslims" 16"Padayachi" 17"Yathavar" 77"Other", replace
label values jatis caste

*Edulevel
gen edulevel=.
replace edulevel=0 if education==9
replace edulevel=1 if education==1
replace edulevel=2 if education==2
replace edulevel=3 if education==3
replace edulevel=3 if education==4
replace edulevel=4 if education==5
replace edulevel=5 if education==6
replace edulevel=5 if education==7
replace edulevel=5 if education==8

tab education

label define edulevel 0"Below primary" 1"Primary completed" 2"High school (8th-10th)" 3"HSC/Diploma (11th-12th)" 4"Bachelors (13th-15th)" 5"Post graduate (15th and more)", replace
label values edulevel edulevel
tab edulevel


*Housing
recode howbuyhouse (8=7)
recode howbuyhouse2 (8=7)
recode howbuyhouse3 (8=7)

gen housetype=.
foreach x in 1 2 3 4 5{
replace housetype=1 if housetype2==`x'
}
replace housetype=2 if housetype2==7
replace housetype=3 if housetype2==6
label define housetype 1"Concrete house" 2"Government/green house" 3"Thatched roof house"
label values housetype housetype


*Gold
gen goldquantityamount=goldquantity*2000

*Own Land
destring land1acres land2acres land3acres, replace dpcomma
clonevar land1acres_own=land1acres
clonevar land2acres_own=land2acres
clonevar land3acres_own=land3acres

replace land1acres_own=0 if land1type1!=1
replace land2acres_own=0 if land2type1!=1
replace land3acres_own=0 if land3type1!=1

gen landowndry=0
gen landownwet=0

replace landowndry=land1acres_own if land1type2==1
replace landowndry=landowndry+land2acres_own if land2type2==1
replace landowndry=landowndry+land3acres_own if land3type2==1

replace landownwet=land1acres_own if land1type2==2
replace landownwet=landownwet+land2acres_own if land2type2==2
replace landownwet=landownwet+land3acres_own if land3type2==2

gen amountownlanddry=600000*landowndry
gen amountownlandwet=1100000*landownwet
gen amountownland=amountownlanddry+amountownlandwet

*Goods value
gen value1=100000
gen value2=1000
gen value3=5000
gen value4=5000
gen value5=1000
gen value6=1000
gen value7=1000
gen value8=1000
gen value9=5000
gen value10=500
gen value11=10000
gen value12=1000
gen value13=3000

forvalues i=1(1)13{
gen numbergoods_`i'=0
gen goodtotalamount_`i'=0
gen goodyearpurchased_`i'=0
gen goodbuying_`i'=0
}

forvalues j=1(1)10{
forvalues i=1(1)13{
replace numbergoods_`i'=_21__b_nber`j' if _21__a_goods`j'==`i'
replace goodyearpurchased_`i'=_21__c_year_of_purchase`j' if _21__a_goods`j'==`i'
replace goodbuying_`i'=_21__d_payment_type`j' if _21__a_goods`j'==`i'
}
}

forvalues i=1(1)13{
replace goodtotalamount_`i'=numbergoods_`i'*value`i'
drop value`i'
}
forvalues i=1(1)10{
drop _21__a_goods`i' _21__b_nber`i' _21__c_year_of_purchase`i' _21__d_payment_type`i'
}

foreach x in numbergoods goodtotalamount goodyearpurchased goodbuying{
rename `x'_1 `x'_car
rename `x'_2 `x'_bike
rename `x'_3 `x'_fridge
rename `x'_4 `x'_furniture
rename `x'_5 `x'_tailormach
rename `x'_6 `x'_phone
rename `x'_7 `x'_landline
rename `x'_8 `x'_DVD
rename `x'_9 `x'_camera
rename `x'_10 `x'_cookgas
rename `x'_11 `x'_computer
rename `x'_12 `x'_antenna
rename `x'_13 `x'_TV
}

*goodtotalamount
egen goodtotalamount=rowtotal(goodtotalamount_car goodtotalamount_bike goodtotalamount_fridge goodtotalamount_furniture goodtotalamount_tailormach goodtotalamount_phone goodtotalamount_landline goodtotalamount_DVD goodtotalamount_camera goodtotalamount_cookgas goodtotalamount_computer goodtotalamount_antenna goodtotalamount_TV)

save"RUME-HH.dta", replace
****************************************
* END






****************************************
* RUME cattle 
****************************************
use"RUME-HH.dta", clear

merge m:1 HHID2010 using "RUME-cattle.dta"
drop _merge

gen livestockamount_cow=8000*livestocknb_cow
gen livestockamount_goat=1000*livestocknb_goat

save"RUME-HH_v2.dta", replace
****************************************
* END





****************************************
* RUME farmequipment
****************************************
use"RUME-farmequipment.dta", clear

forvalues i=1(1)3{
gen equiownnb_`i'=0
gen equiownpay_`i'=0
gen equiowncost_`i'=0
gen equiownpledged_`i'=0
gen equiownyear_`i'=0
}

forvalues i=1(1)3{
replace equiownnb_`i'=equipmentnb if equipmentlist==`i'
replace equiownpay_`i'=equipmentpay if equipmentlist==`i'
replace equiowncost_`i'=equipmentcost if equipmentlist==`i'
replace equiownpledged_`i'=equipmentpledged if equipmentlist==`i'
replace equiownyear_`i'=equipmentyear if equipmentlist==`i'
}

foreach x in equiownnb equiownpay equiowncost equiownpledged equiownyear{
rename `x'_1 `x'_tractor
}
foreach x in equiownnb equiownpay equiowncost equiownpledged equiownyear{
rename `x'_2 `x'_bullockcart
}
foreach x in equiownnb equiownpay equiowncost equiownpledged equiownyear{
rename `x'_3 `x'_harvester
}

drop equipmentlist equipmentnb equipmentyear equipmentpay equipmentpaycreditfrom equipmentcost equipmentpledged

bysort HHID2010 : gen n=_n

*Reshape
reshape wide  equiownnb_tractor equiownpay_tractor equiowncost_tractor equiownpledged_tractor equiownyear_tractor equiownnb_bullockcart equiownpay_bullockcart equiowncost_bullockcart equiownpledged_bullockcart equiownyear_bullockcart equiownnb_harvester equiownpay_harvester equiowncost_harvester equiownpledged_harvester equiownyear_harvester, i(HHID2010) j(n)

*HH level
foreach x in tractor bullockcart harvester{
egen equiowncost_`x'=rowtotal(equiowncost_`x'1 equiowncost_`x'2)
}

save"RUME-farmequipment_v2.dta", replace

use"RUME-HH_v2.dta", clear
merge m:1 HHID2010 using "RUME-farmequipment_v2.dta"
drop _merge

save"RUME-HH_v3.dta", replace
****************************************
* END









****************************************
* RUME occupations
****************************************
use"RUME-occupations.dta", clear
drop INDID
rename code_id_mb INDID
rename occupation_code2 occupationtype
rename ocupationname occupationname
fre occupationtype
label define occupationtype ///
1"Agriculture" ///
2"Coolie" ///
3"Agri Coolie" ///
4"NREGS" ///
5"Investment" ///
6"Employee" ///
7"Service" ///
8"Self employment" ///
9"Pension" ///
10"No Occupation" ///
66"Irrelevant" ///
77"Other" ///
88"Don't know" ///
99"No response"
label values occupationtype occupationtype
fre occupationtype

**********Indiv
*max income or hours (income only for 2010)
bysort HHID2010 INDID : egen maxincome_indiv=max(annualincome)
*occup name and occup type with the max
gen mainoccup=occupationtype if maxincome_indiv==annualincome
gen mainoccupname=occupationname if maxincome_indiv==annualincome
gen mainoccupation_income_indiv=annualincome if maxincome_indiv==annualincome
*encode name to simplify the procedure
encode mainoccupname, gen(mainoccupnamenumeric)
*put main occupation at indiv level
bysort HHID2010 INDID : egen mainoccupation=max(mainoccup)
bysort HHID2010 INDID : egen mainoccupationname=max(mainoccupnamenumeric)
*put the label
label values mainoccupation occupationtype
label values mainoccupationname mainoccupnamenumeric
*decode the name to compare between the waves
decode mainoccupationname, gen(_mainoccupationname)
drop mainoccupationname
rename _mainoccupationname mainoccupationname
*total income
bysort HHID2010 INDID: egen totalincome_indiv=sum(annualincome)
*nb of income sources
fre occupationtype
gen countoccupation=1 if occupationtype!=10
bysort HHID2010 INDID: egen nboccupation_indiv=sum(countoccupation)
*cleaning
rename mainoccupation mainoccupation_indiv
rename mainoccupationname mainoccupationname_indiv

drop maxincome_indiv mainoccup mainoccupname mainoccupnamenumeric countoccupation




*Agri vs non agri income?
fre occupationtype
forvalues i=1(1)10{
gen labourincome_`i'=.
}

forvalues i=1(1)10{
replace labourincome_`i'=annualincome if occupationtype==`i'
recode labourincome_`i' (.=0)
}
forvalues i=1(1)10{
bysort HHID2010 INDID: egen labourincome_indiv_`i'=sum(labourincome_`i')
bysort HHID2010: egen labourincome_HH_`i'=sum(labourincome_`i')
}

foreach x in labourincome_indiv labourincome_HH{
rename `x'_1 `x'_agri
rename `x'_2 `x'_coolie
rename `x'_3 `x'_agricoolie
rename `x'_4 `x'_nregs
rename `x'_5 `x'_investment
rename `x'_6 `x'_employee
rename `x'_8 `x'_selfemp
rename `x'_9 `x'_pension
rename `x'_10 `x'_nooccup
}

drop labourincome_indiv_7 labourincome_HH_7


**********HH
*max income or hours (income only for 2010)
fre occupationtype
forvalues i=1(1)10{
bysort HHID2010 : egen maxincome_`i'=sum(annualincome) if occupationtype==`i'
}
forvalues i=1(1)10{
bysort HHID2010 : egen maxincome2_`i'=max(maxincome_`i')
recode maxincome2_`i' (.=0)
drop maxincome_`i'
}
*occup type with the max
egen mainoccup=rowmax(maxincome2_1 maxincome2_2 maxincome2_3 maxincome2_4 maxincome2_5 maxincome2_6 maxincome2_7 maxincome2_8 maxincome2_9 maxincome2_10)
*occup name and occup type with the max
gen mainoccup2=.
forvalues i=1(1)10{
replace mainoccup2=`i' if maxincome2_`i'==mainoccup
}
*put the label
label values mainoccup2 occupationtype
drop mainoccup maxincome2_1 maxincome2_2 maxincome2_3 maxincome2_4 maxincome2_5 maxincome2_6 maxincome2_7 maxincome2_8 maxincome2_9 maxincome2_10
rename mainoccup2 mainoccupation_HH
*total income
bysort HHID2010 : egen totalincome_HH=sum(annualincome)
*nb of income sources
fre occupationtype
gen countoccupation=1 if occupationtype!=10
bysort HHID2010 : egen nboccupation_HH=sum(countoccupation)
drop countoccupation
rename totalincome_indiv annualincome_indiv
rename totalincome_HH annualincome_HH


**********Indiv base
bysort HHID2010 INDID: gen n=_n 
keep if n==1
keep mainoccupation_income_indiv mainoccupation_indiv mainoccupationname_indiv annualincome_indiv nboccupation_indiv mainoccupation_HH annualincome_HH nboccupation_HH HHID2010 INDID labourincome_HH_agri labourincome_HH_coolie labourincome_HH_agricoolie labourincome_HH_nregs labourincome_HH_investment labourincome_HH_employee labourincome_HH_selfemp labourincome_HH_pension labourincome_HH_nooccup labourincome_indiv_agri labourincome_indiv_coolie labourincome_indiv_agricoolie labourincome_indiv_nregs labourincome_indiv_investment labourincome_indiv_employee labourincome_indiv_selfemp labourincome_indiv_pension labourincome_indiv_nooccup
save"RUME-occupations_2.dta", replace

bysort HHID2010: gen n=_n 
keep if n==1
keep mainoccupation_HH annualincome_HH nboccupation_HH HHID2010 labourincome_HH_agri labourincome_HH_coolie labourincome_HH_agricoolie labourincome_HH_nregs labourincome_HH_investment labourincome_HH_employee labourincome_HH_selfemp labourincome_HH_pension labourincome_HH_nooccup
save"RUME-occupations_3.dta", replace



**********Merge dans la base HH
use"RUME-HH_v3.dta", clear

merge 1:1 HHID2010 INDID using "RUME-occupations_2.dta", keepusing(mainoccupation_income_indiv mainoccupation_indiv mainoccupationname_indiv annualincome_indiv nboccupation_indiv labourincome_indiv_agri labourincome_indiv_coolie labourincome_indiv_agricoolie labourincome_indiv_nregs labourincome_indiv_investment labourincome_indiv_employee labourincome_indiv_selfemp labourincome_indiv_pension labourincome_indiv_nooccup)
drop _merge

merge m:1 HHID2010 using "RUME-occupations_3.dta", keepusing(mainoccupation_HH annualincome_HH nboccupation_HH labourincome_HH_agri labourincome_HH_coolie labourincome_HH_agricoolie labourincome_HH_nregs labourincome_HH_investment labourincome_HH_employee labourincome_HH_selfemp labourincome_HH_pension labourincome_HH_nooccup)
drop _merge

recode mainoccupation_indiv mainoccupation_HH (.=0)

preserve
bysort HHID2010: gen n=_n
keep if n==1
fre mainoccupation_HH
restore

save"RUME-HH_v4.dta", replace
****************************************
* END















****************************************
* Assets + crisis + chit + gold + savings
****************************************
use"RUME-HH_v4.dta", clear

egen assets=rowtotal(amountownlanddry amountownlandwet livestockamount_goat livestockamount_cow housevalue goldquantityamount goodtotalamount)
gen assets1000=assets/1000

egen assets_noland=rowtotal(livestockamount_goat livestockamount_cow housevalue goldquantityamount goodtotalamount)
gen assets_noland1000=assets_noland/1000

/*
preserve
gen totalincome_HH1000=totalincome_HH/1000
bysort HHID2010: gen n=_n
keep if n==1
tabstat assets1000 totalincome_HH1000, stat(n mean sd p50) by(caste)
restore
*/

********** Crisis
/*
preserve
import excel "$directory\RUME-crisis.xlsx", sheet("T24_Problems_in_work__crisis_") firstrow clear
rename Codefamily HHID2010
rename B effectcrisislostjob
rename C effectcrisislesswork
rename D effectcrisiskindofwork
rename E effectcrisisjoblocation
rename F effectcrisisjoblocation2
save"RUME-crisis.dta", replace
restore
*/
merge m:1 HHID2010 using "RUME-crisis.dta"
drop _merge



********** Chit
/*
preserve
import delimited "$directory\RUME-chitfunds.csv", clear delimiter(";") encoding(utf8)
rename v1 HHID2010
rename v2 dummychitfund
rename v3 INDID
rename v4 chitfundtype
rename v5 durationchit
rename v6 nbermemberchit
rename v7 chitfundpayment
rename v8 chitfundamount
order dummychitfund HHID2010 INDID
keep if INDID!=""
duplicates tag HHID2010 INDID, gen(tag)
tab tag
drop tag
egen HHINDID=concat(HHID2010 INDID), p(/)
bysort HHINDID: gen n=_n
reshape wide chitfundtype durationchit nbermemberchit chitfundpayment chitfundamount, i(HHINDID) j(n)
drop HHINDID 
order dummychitfund HHID2010 INDID
save"$directory\RUME-chitfunds.dta", replace
restore
*/
merge 1:1 HHID2010 INDID using "$directory\RUME-chitfunds.dta"
drop if _merge==2
drop _merge
recode dummychitfund (.=0)
rename dummychitfund chitfundbelongerlist
bysort HHID2010: egen dummychitfund=sum(chitfundbelongerlist)
replace dummychitfund=1 if dummychitfund>1 & dummychitfund!=. & dummychitfund!=0



********** Savings
/*
preserve
import delimited "$directory\RUME-savings.csv", clear delimiter(";") encoding(utf8)
rename v1 HHID2010
rename v2 dummysavingaccount
rename v3 INDID
rename v4 savingsbankname
rename v5 savingsbankplace
rename v6 savingsamount
rename v7 savingspurpose1
rename v8 savingspurpose2
rename v9 dummydebitcard
rename v10 dummycreditcard
egen savingspurpose=concat(savingspurpose1 savingspurpose2), p(" ")
drop savingspurpose1 savingspurpose2
order dummysavingaccount HHID2010 INDID
keep if INDID!=""
duplicates tag HHID2010 INDID, gen(tag)
tab tag
drop tag
egen HHINDID=concat(HHID2010 INDID), p(/)
bysort HHINDID: gen n=_n
reshape wide savingsbankname savingsbankplace savingsamount dummydebitcard dummycreditcard savingspurpose, i(HHINDID) j(n)
drop HHINDID
order dummysavingaccount HHID2010 INDID
save "$directory\RUME-savings.dta", replace
restore
*/
merge 1:1 HHID2010 INDID using "$directory\RUME-savings.dta"
drop if _merge==2
drop _merge
recode dummysavingaccount (.=0)
rename dummysavingaccount saving
bysort HHID2010: egen dummysavingaccount=sum(saving)
tab dummysavingaccount
rename saving savingsownerlist
replace dummysavingaccount=1 if dummysavingaccount>1 & dummysavingaccount!=.
tab dummysavingaccount

********** Gold
/*
preserve
import delimited "$directory\RUME-gold.csv", clear delimiter(";") encoding(utf8)
rename v1 HHID2010
rename v2 goldquantity
rename v3 goldquantitypledge
rename v4 goldamountpledge
drop if HHID2010==""
gen dummygoldpledged=0
replace dummygoldpledged=1 if goldquantitypledge!=0 & goldquantitypledge!=.
save"$directory\RUME-gold.dta", replace
restore
*/
merge m:1 HHID2010 using "$directory\RUME-gold.dta"
drop _merge


********** Insurance
/*
preserve
import delimited "$directory\RUME-insurance.csv", clear delimiter(";") encoding(utf8)
rename v1 HHID2010
rename v2 dummyinsurance
rename v3 INDID
rename v4 insurancename
rename v5 insurancetype
rename v6 insurancebenefit
rename v7 insurancejoineddate
drop if INDID==""
recode insurancetype (1=1) (2=2) (3=3) (4=4) (5=7) (6=.) (77=77)
label define insurance 1"Life insurance" 2"Health insurance" 3"Crop insurance" 4"Animal insurance" 5"Accident insurance (vehicle/person)" 6"Bike insurance" 7"Savings insurance" 77"Other"
label values insurancetype insurance
keep if INDID!=""
bysort HHID2010 INDID: gen n=_n
tab n
egen HHINDID=concat(HHID2010 INDID), p(" ")
reshape wide insurancename insurancetype insurancebenefit insurancejoineddate, i(HHINDID) j(n)
drop HHINDID
order HHID2010 INDID
save"$directory\RUME-insurance.dta", replace
restore
*/
merge 1:1 HHID2010 INDID using "$directory\RUME-insurance.dta"
drop _merge
bysort HHID2010: egen _dummyinsurance=sum(dummyinsurance)
tab _dummyinsurance
rename dummyinsurance insuranceownerlist
rename _dummyinsurance dummyinsurance
replace dummyinsurance=1 if dummyinsurance>1 & dummyinsurance!=.


********** Submission date
gen submissiondate=mdy(03,01,2010)
tab submissiondate
format submissiondate %d

save"RUME-HH_v5.dta", replace
****************************************
* END








****************************************
* HHID_panel
****************************************
use"RUME-HH_v5.dta", clear

merge m:m HHID2010 using "unique_identifier_panel.dta", keepusing(HHID_panel)
keep if _merge==3
drop _merge
preserve
duplicates drop HHID2010, force
tab HHID_panel
restore
preserve
duplicates drop HHID_panel, force
tab HHID2010
restore

save"RUME-HH_v6.dta", replace
****************************************
* END








****************************************
* Panel individuals
****************************************
use"RUME-HH_v6.dta", clear
/*
********** RAW: F1 to 1
split INDID, p(F)
drop INDID1
rename INDID INDID_o
rename INDID2 INDID
destring INDID, replace
*Merge it
merge 1:1 HHID2010 INDID using "NEEMSIS_preload2016.dta", keepusing(name_p16)
drop if _merge==2
drop _merge
sort HHID2010 INDID
keep HHID2010 INDID INDID_o name name_p16
*Export excel pour vérif à la main
export excel using "RUME_name.xlsx", firstrow(variables)


********** VERIFICATION 1
import excel "RUME_name.xlsx", sheet("modif2") firstrow clear
drop K
rename J HH
keep HHID2010 INDID_o INDID_modif
rename INDID_o INDID
save"RUME-name_panel.dta", replace

*Put in the HH base
use"RUME-HH_v6.dta", clear

merge 1:1 HHID2010 INDID using "RUME-name_panel.dta"
drop _merge

*Rename
rename INDID INDID_o
rename INDID_modif INDID
egen INDID2010=concat(HHID2010 INDID), p(/)
tab INDID2010

*Merge with 2016
merge m:1 HHID2010 INDID using "NEEMSIS_preload2016.dta", keepusing(name_p16)
sort HHID2010 INDID
keep HHID2010 INDID INDID_o name name_p16
sort HHID2010 INDID
gen n=_n
drop if n<=528
drop n

*Id 0 and -99
bysort HHID2010 : egen min0=min(INDID)
sort min0 HHID2010 INDID
*verif à la main 2
export excel using "RUME_name_v2.xlsx", firstrow(variables) sheetreplace


********** VERIFICATION 2
import excel "RUME_name_v2.xlsx", sheet("Sheet1") firstrow clear
keep if INDID_o!=""
drop name name_p16 min0 INDID  H I J K
rename modif INDID_modif2
rename INDID_o INDID
save"RUME-name_panel_v2.dta", replace

*Put in the HH base
use"RUME-HH_v6.dta", clear
merge 1:1 HHID2010 INDID using "RUME-name_panel_v2.dta"
drop _merge

*Rename
rename INDID INDID_o
rename INDID_modif INDID
egen INDID2010=concat(HHID2010 INDID), p(/)
tab INDID2010

*Merge with 2016
merge m:1 HHID2010 INDID using "NEEMSIS_preload2016.dta", keepusing(name_p16)

sort HHID2010 INDID
keep HHID2010 INDID INDID_o name name_p16
sort HHID2010 INDID
gen n=_n
drop if n<=528
drop n

*Id 0 and -99
bysort HHID2010 : egen min0=min(INDID)
sort min0 HHID2010 INDID
*verif à la main 2
export excel using "RUME_name_v3.xlsx", firstrow(variables) sheetreplace

********** VERIFICATION 3
/*
OK pour la dernière version (2 donc car en 3 je vérifie 2)
*/
*/

********** MERGER LES NOUVEAUX CODE DONC
use"RUME-HH_v6.dta", clear
merge 1:1 HHID2010 INDID using "RUME-name_panel_v2.dta"
drop _merge
rename INDID INDID_o
rename INDID_modif2 INDID
label var INDID "INDID for 2016 check by Arnaud 04/18/21 : 0 = indiv doesnt exist in the 2016 HH & -99 = HH doesnt exist in 2016 "

order HHID2010 INDID INDID_o name, first

merge m:1 HHID2010 INDID using "NEEMSIS_preload2016.dta", keepusing(name_p16)
drop if _merge==2
drop _merge

order HHID2010 INDID INDID_o name name_p16, first
sort HHID2010 INDID

/*
Check if INDID=0 are in tracking2016
*/


**********Panel ?
merge m:1 HHID2010 using "panel_comp.dta"
keep if _merge==3
drop _merge



**********
drop INDID name_p16
rename INDID_o INDID2010
merge 1:m HHID_panel INDID2010 using "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\Individual_panel\panel_indiv_2010_2016_wide", keepusing(INDID_panel)
keep if _merge==3
drop _merge
sort HHID_panel INDID_panel
order HHID_panel INDID_panel

save"RUME-HH_v7.dta", replace
****************************************
* END



