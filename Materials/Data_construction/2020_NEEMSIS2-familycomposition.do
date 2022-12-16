*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Family composition
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox\RUME-NEEMSIS\Data\Construction"
cd"$directory"

********** Database names
global data = "NEEMSIS2-HH"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2020
*(100/184) if year==2020









****************************************
* Family composition
****************************************
use"$data", clear


*** To keep
keep HHID2020 INDID2020 name age sex relationshiptohead livinghome maritalstatus
fre livinghome
drop if livinghome==.
drop if livinghome==3
drop if livinghome==4
drop livinghome


*** Corr
tostring INDID2020, replace
merge m:m HHID2020 using "ODRIIS-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge
merge m:m HHID_panel INDID2020 using "ODRIIS-Indiv_wide", keepusing(INDID_panel agecorr2020 sex2020 relationshiptohead2020 age2020)
keep if _merge==3
drop _merge
order HHID_panel INDID_panel HHID2020 INDID2020
destring INDID2020, replace

* V1
ta sex sex2020
drop sex2020

* V2
ta relationshiptohead relationshiptohead2020
drop relationshiptohead2020

* V3
destring age2020, replace
gen test=age-age2020
ta test
drop test age2020

* V4
destring agecorr2020, replace
gen test=age-agecorr2020
ta test
drop test age
rename agecorr2020 age


*** Nb male/female
fre sex
gen male=0
replace male=1 if sex==1

gen female=0
replace female=1 if sex==2


*** Nb over age
egen age_group=cut(age), at(0 14 18 25 30 35 40 50 60 70 80 100)
ta age_group
ta age age_group
ta age_group, gen(agegroup_)
rename agegroup_1 agegrp_0_13
rename agegroup_2 agrgrp_14_17
rename agegroup_3 agegrp_18_24
rename agegroup_4 agrgrp_25_29
rename agegroup_5 agrgrp_30_34
rename agegroup_6 agegrp_35_39
rename agegroup_7 agegrp_40_49
rename agegroup_8 agegrp_50_59
rename agegroup_9 agegrp_60_69
rename agegroup_10 agegrp_70_79
rename agegroup_11 agegrp_80_100


*** Age and sex
ta age_group sex
foreach x in agegrp_0_13 agrgrp_14_17 agegrp_18_24 agrgrp_25_29 agrgrp_30_34 agegrp_35_39 agegrp_40_49 agegrp_50_59 agegrp_60_69 agegrp_70_79 agegrp_80_100 {
gen male_`x'=0
gen female_`x'=0
}

foreach x in agegrp_0_13 agrgrp_14_17 agegrp_18_24 agrgrp_25_29 agrgrp_30_34 agegrp_35_39 agegrp_40_49 agegrp_50_59 agegrp_60_69 agegrp_70_79 agegrp_80_100 {
replace male_`x'=1 if male==1 & `x'==1
replace female_`x'=1 if female==1 & `x'==1 
}


*** Relationship to head
ta relationshiptohead
fre relationshiptohead
ta relationshiptohead, gen(relation_)
rename relation_1 relation_head
rename relation_2 relation_wife
rename relation_3 relation_mother
rename relation_4 relation_father
rename relation_5 relation_son
rename relation_6 relation_daughter
rename relation_7 relation_soninlaw
rename relation_8 relation_daughterinlaw
rename relation_9 relation_sister
rename relation_10 relation_brother
rename relation_11 relation_motherinlaw
rename relation_12 relation_fatherinlaw
rename relation_13 relation_grandchildren
rename relation_14 relation_grandfather
rename relation_15 relation_grandmother
rename relation_16 relation_cousin
rename relation_17 relation_other


*** HH level
global var male female agegrp_0_13 agrgrp_14_17 agegrp_18_24 agrgrp_25_29 agrgrp_30_34 agegrp_35_39 agegrp_40_49 agegrp_50_59 agegrp_60_69 agegrp_70_79 agegrp_80_100 male_agegrp_0_13 female_agegrp_0_13 male_agrgrp_14_17 female_agrgrp_14_17 male_agegrp_18_24 female_agegrp_18_24 male_agrgrp_25_29 female_agrgrp_25_29 male_agrgrp_30_34 female_agrgrp_30_34 male_agegrp_35_39 female_agegrp_35_39 male_agegrp_40_49 female_agegrp_40_49 male_agegrp_50_59 female_agegrp_50_59 male_agegrp_60_69 female_agegrp_60_69 male_agegrp_70_79 female_agegrp_70_79 male_agegrp_80_100 female_agegrp_80_100 relation_head relation_wife relation_mother relation_father relation_son relation_daughter relation_soninlaw relation_daughterinlaw relation_sister relation_brother relation_motherinlaw relation_fatherinlaw relation_grandchildren relation_grandfather relation_grandmother relation_cousin relation_other

foreach x in $var {
bysort HHID2020: egen _temp`x'=sum(`x')
drop `x'
rename _temp`x' `x'
}


*** HH size
bysort HHID2020: egen HHsize=sum(1)

keep HHID2020 $var HHsize
duplicates drop


*** Clean
rename male nbmale
rename female nbfemale


save"_temp\NEEMSIS2-family1", replace
****************************************
* END








****************************************
* Type of family
****************************************
use"$data", clear


*** To keep
keep HHID2020 INDID2020 name age sex relationshiptohead livinghome maritalstatus
fre livinghome
drop if livinghome==.
drop if livinghome==3
drop if livinghome==4
drop livinghome


*** Reshape
bysort HHID2020 (INDID2020): gen n=_n
rename INDID2020 INDID
reshape wide INDID name age sex relationshiptohead maritalstatus, i(HHID2020) j(n)

forvalues i=1/14 {
decode relationshiptohead`i', gen(relation`i')
}

*** Concat
egen family=concat(relation1 relation2 relation3 relation4 relation5 relation6 relation7 relation8 relation9 relation10 relation11 relation12 relation13 relation14), p(" / ")
drop relation1 relation2 relation3 relation4 relation5 relation6 relation7 relation8 relation9 relation10 relation11 relation12 relation13 relation14

forvalues i=1/30{
replace family=substr(family, 1, strlen(family)-1) if substr(family,strlen(family),1)=="/"
replace family=substr(family, 1, strlen(family)-1) if substr(family,strlen(family),1)==" "
}

*** Display all choices
preserve
duplicates drop family, force
sort family
br family
restore

*** Categories
gen typeoffamily=""




*** Pb
ta typeoffamily
gen pb=0



sort HHID2020
order HHID2020 family
*br if pb==1




drop pb

keep HHID2020 family typeoffamily
ta typeoffamily

save"_temp\NEEMSIS2-family2", replace
****************************************
* END









****************************************
* Type of family p2
****************************************
use"$data", clear

*** To keep
keep HHID2020 INDID2020 name age sex relationshiptohead livinghome maritalstatus
fre livinghome
drop if livinghome==.
drop if livinghome==3
drop if livinghome==4
drop livinghome


*** Relationship to head
ta relationshiptohead
fre relationshiptohead
ta relationshiptohead, gen(relation_)
rename relation_1 relation_head
rename relation_2 relation_wife
rename relation_3 relation_mother
rename relation_4 relation_father
rename relation_5 relation_son
rename relation_6 relation_daughter
rename relation_7 relation_soninlaw
rename relation_8 relation_daughterinlaw
rename relation_9 relation_sister
rename relation_10 relation_brother
rename relation_11 relation_motherinlaw
rename relation_12 relation_fatherinlaw
rename relation_13 relation_grandchildren
rename relation_14 relation_grandfather
rename relation_15 relation_grandmother
rename relation_16 relation_cousin
rename relation_17 relation_other


*** Merge type of family to count
merge m:1 HHID2020 using "_temp/NEEMSIS2-family2"
drop _merge


*** How many per gen?
foreach x in relation_head relation_wife relation_mother relation_father relation_son relation_daughter relation_soninlaw relation_daughterinlaw relation_sister relation_brother relation_motherinlaw relation_fatherinlaw relation_grandchildren relation_grandfather relation_grandmother relation_cousin {
bysort HHID2020: egen _temp`x'=sum(`x')
drop `x'
rename _temp`x' `x'
}



gen nbgeneration1=relation_grandchildren
egen nbgeneration2=rowtotal(relation_son relation_daughter relation_daughterinlaw relation_soninlaw)
egen nbgeneration3=rowtotal(relation_head relation_wife relation_sister relation_brother)
egen nbgeneration4=rowtotal(relation_mother relation_father relation_motherinlaw relation_fatherinlaw)
egen nbgeneration5=rowtotal(relation_grandmother relation_grandfather)



*** How many gen?
forvalues i=1/5 {
gen dummygeneration`i'=0
}

forvalues i=1/5 {
replace dummygeneration`i'=1 if nbgeneration`i'!=0
}

egen nbgeneration=rowtotal(dummygeneration1 dummygeneration2 dummygeneration3 dummygeneration4 dummygeneration5)


*** Way for stem
gen waystem=""
replace waystem="head-up" if dummygeneration1==0 & dummygeneration2==0 & dummygeneration3==1 & dummygeneration4==1 
replace waystem="head-down" if dummygeneration1==0 & dummygeneration2==1 & dummygeneration3==1 & dummygeneration4==0
replace waystem="head-down" if dummygeneration1==1 & dummygeneration2==1 & dummygeneration3==1 & dummygeneration4==0
replace waystem="head-down" if dummygeneration1==1 & dummygeneration2==0 & dummygeneration3==1 & dummygeneration4==0
replace waystem="head-both" if dummygeneration1==0 & dummygeneration2==1 & dummygeneration3==1 & dummygeneration4==1
replace waystem="head-both" if dummygeneration1==1 & dummygeneration2==1 & dummygeneration3==1 & dummygeneration4==1
replace waystem="head-both" if dummygeneration1==1 & dummygeneration2==0 & dummygeneration3==1 & dummygeneration4==1
replace waystem="head-both" if dummygeneration1==1 & dummygeneration2==1 & dummygeneration3==0 & dummygeneration4==1
replace waystem="head-both" if dummygeneration1==1 & dummygeneration2==0 & dummygeneration3==0 & dummygeneration4==1
replace waystem="head-level" if dummygeneration1==0 & dummygeneration2==0 & dummygeneration3==1 & dummygeneration4==0 & typeoffamily=="stem"
replace waystem="head-level" if dummygeneration1==0 & dummygeneration2==0 & dummygeneration3==1 & dummygeneration4==0 & typeoffamily=="joint-stem"

replace waystem="" if typeoffamily=="nuclear"


*** Polygamous
fre sex relationshiptohead
gen femalewife=0
replace femalewife=1 if sex==2 & relationshiptohead==2
bysort HHID2020: egen nbwife=sum(femalewife)
drop femalewife
gen dummypolygamous=0
replace dummypolygamous=1 if nbwife!=1 & nbwife!=0 & nbwife!=. 
drop nbwife



*** Keep
keep HHID2020 family typeoffamily nbgeneration* dummygeneration* nbgeneration waystem dummypolygamous
duplicates drop

ta waystem typeoffamily, m

ta dummypolygamous

list family typeoffamily if dummypolygamous==1, clean noobs

drop family typeoffamily

save"_temp\NEEMSIS2-family3", replace
****************************************
* END















****************************************
* Head characteristics
****************************************
use"$data", clear

*** To keep
keep HHID2020 INDID2020 name age sex relationshiptohead livinghome maritalstatus egoid
fre livinghome
drop if livinghome==3
drop if livinghome==4
drop livinghome
gen pb=0

*** Identified duplicates
preserve
keep if relationshiptohead==1
duplicates tag HHID2020, gen(tag)
ta tag
sort HHID2020
*br HHID2020 INDID2020 name age sex relationshiptohead maritalstatus if tag!=0
restore




*** Identified HH without Head
gen head=0
replace head=1 if relationshiptohead==1
bysort HHID2020: egen head_HH=sum(head)
ta head_HH
recode head_HH (0=1) (1=0)
rename head_HH nohead
ta nohead
drop head

sort HHID2020 INDID2020
*br HHID2020 INDID2020 name age sex egoid relationshiptohead maritalstatus if nohead==1








*** Keep head
keep if relationshiptohead==1
duplicates report HHID2020

keep HHID2020 INDID2020 name age sex relationshiptohead maritalstatus egoid
gen dummyhead=1



*** Add occupation
merge 1:1 HHID2020 INDID2020 using "outcomes/NEEMSIS2-occup_indiv", keepusing(dummyworkedpastyear working_pop mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv)
drop if _merge==2
drop _merge

rename mainocc_profession_indiv mocc_profession
rename mainocc_occupation_indiv mocc_occupation
rename mainocc_sector_indiv mocc_sector
rename mainocc_annualincome_indiv mocc_annualincome
rename mainocc_occupationname_indiv mocc_occupationname
rename annualincome_indiv annualincome
rename nboccupation_indiv nboccupation

*** Add education
merge 1:1 HHID2020 INDID2020 using "outcomes/NEEMSIS2-education"
drop if _merge==2
drop _merge


*** Rename
foreach x in INDID2020 name sex relationshiptohead age dummyhead dummyworkedpastyear working_pop mocc_profession mocc_occupation mocc_sector mocc_annualincome mocc_occupationname annualincome nboccupation edulevel egoid maritalstatus {
rename `x' head_`x'
}

save"_temp\NEEMSIS2-head", replace
****************************************
* END












****************************************
* Merge all
****************************************
use"$data", clear

keep HHID2020
duplicates drop

merge 1:1 HHID2020 using "_temp\NEEMSIS2-family1"
drop _merge

merge 1:1 HHID2020 using "_temp\NEEMSIS2-family2"
drop _merge

merge 1:1 HHID2020 using "_temp\NEEMSIS2-family3"
drop _merge

merge 1:1 HHID2020 using "_temp\NEEMSIS2-head"
drop _merge

save"outcomes\NEEMSIS2-family", replace
****************************************
* END
