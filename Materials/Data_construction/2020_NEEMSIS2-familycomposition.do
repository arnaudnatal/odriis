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
ta relationshiptohead sex

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
rename agegroup_2 agegrp_14_17
rename agegroup_3 agegrp_18_24
rename agegroup_4 agegrp_25_29
rename agegroup_5 agegrp_30_34
rename agegroup_6 agegrp_35_39
rename agegroup_7 agegrp_40_49
rename agegroup_8 agegrp_50_59
rename agegroup_9 agegrp_60_69
rename agegroup_10 agegrp_70_79
rename agegroup_11 agegrp_80_100


*** Age and sex
ta age_group sex
foreach x in agegrp_0_13 agegrp_14_17 agegrp_18_24 agegrp_25_29 agegrp_30_34 agegrp_35_39 agegrp_40_49 agegrp_50_59 agegrp_60_69 agegrp_70_79 agegrp_80_100 {
gen male_`x'=0
gen female_`x'=0
}

foreach x in agegrp_0_13 agegrp_14_17 agegrp_18_24 agegrp_25_29 agegrp_30_34 agegrp_35_39 agegrp_40_49 agegrp_50_59 agegrp_60_69 agegrp_70_79 agegrp_80_100 {
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
global var male female age_group agegrp_0_13 agegrp_14_17 agegrp_18_24 agegrp_25_29 agegrp_30_34 agegrp_35_39 agegrp_40_49 agegrp_50_59 agegrp_60_69 agegrp_70_79 agegrp_80_100 male_agegrp_0_13 female_agegrp_0_13 male_agegrp_14_17 female_agegrp_14_17 male_agegrp_18_24 female_agegrp_18_24 male_agegrp_25_29 female_agegrp_25_29 male_agegrp_30_34 female_agegrp_30_34 male_agegrp_35_39 female_agegrp_35_39 male_agegrp_40_49 female_agegrp_40_49 male_agegrp_50_59 female_agegrp_50_59 male_agegrp_60_69 female_agegrp_60_69 male_agegrp_70_79 female_agegrp_70_79 male_agegrp_80_100 female_agegrp_80_100 relation_head relation_wife relation_mother relation_father relation_son relation_daughter relation_soninlaw relation_daughterinlaw relation_sister relation_brother relation_motherinlaw relation_fatherinlaw relation_grandchildren relation_grandfather relation_grandmother relation_cousin relation_other

foreach x in $var {
bysort HHID2020: egen _temp`x'=sum(`x')
drop `x'
rename _temp`x' `x'
}


********** Corr HH size

* HH size
bysort HHID2020: egen HHsize=sum(1)

* Count child/adult
egen HH_count_child=rowtotal(agegrp_0_13)
egen HH_count_adult=rowtotal(agegrp_14_17 agegrp_18_24 agegrp_25_29 agegrp_30_34 agegrp_35_39 agegrp_40_49 agegrp_50_59 agegrp_60_69 agegrp_70_79 agegrp_80_100)

* Equivalence scale
gen HH_count_adult_equi=((HH_count_adult-1)*0.7)+1
gen HH_count_child_equi=HH_count_child*0.5
gen equiscale_HHsize=HH_count_adult_equi+HH_count_child_equi
drop HH_count_adult_equi HH_count_child_equi

* Equivalence scale modified
gen HH_count_adult_equi=((HH_count_adult-1)*0.5)+1
gen HH_count_child_equi=HH_count_child*0.3
gen equimodiscale_HHsize=HH_count_adult_equi+HH_count_child_equi
drop HH_count_adult_equi HH_count_child_equi

* Square root scale
gen squareroot_HHsize=sqrt(HHsize)



keep HHID2020 $var HHsize HH_count_child HH_count_adult equiscale_HHsize equimodiscale_HHsize squareroot_HHsize
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
keep HHID2020 INDID2020 name age sex relationshiptohead relationshiptoheadother livinghome maritalstatus
fre livinghome
drop if livinghome==.
drop if livinghome==3
drop if livinghome==4
drop livinghome


*** Reshape
bysort HHID2020 (INDID2020): gen n=_n
rename INDID2020 INDID
reshape wide INDID name age sex relationshiptohead relationshiptoheadother maritalstatus, i(HHID2020) j(n)

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
*br family
restore
compress


*** Categories
gen typeoffamily=""

replace typeoffamily="joint-stem" if family=="Cousin / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Daughter / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Daughter / Wife / Son / Son / Daughter-in-law / Daughter-in-law / Grandchild / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Daughter-in-law / Head / Father / Mother / Daughter"
replace typeoffamily="stem" if family=="Daughter-in-law / Head / Son / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Daughter-in-law / Head / Wife / Son"
replace typeoffamily="stem" if family=="Daughter-in-law / Head / Wife / Son / Daughter / Daughter / Son / Grandchild"
replace typeoffamily="stem" if family=="Daughter-in-law / Head / Wife / Son / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Daughter-in-law / Head / Wife / Son / Grandchild / Mother"
replace typeoffamily="stem" if family=="Daughter-in-law / Head / Wife / Son / Son / Grandchild"
replace typeoffamily="stem" if family=="Daughter-in-law / Head / Wife / Son / Son / Son / Son"
replace typeoffamily="stem" if family=="Daughter-in-law / Other / Daughter / Head / Wife"
replace typeoffamily="stem" if family=="Daughter-in-law / Son / Grandchild / Grandchild / Head / Wife"
replace typeoffamily="stem" if family=="Daughter-in-law / Son / Head / Wife / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Daughter-in-law / Son / Head / Wife / Grandchild / Grandchild / Son"
replace typeoffamily="joint-stem" if family=="Daughter-in-law / Son / Head / Wife / Son / Daughter-in-law / Son"
replace typeoffamily="stem" if family=="Daughter-in-law / Wife / Son / Head / Daughter"
replace typeoffamily="nuclear" if family=="Head"
replace typeoffamily="nuclear" if family=="Head / Daughter"
replace typeoffamily="nuclear" if family=="Head / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Daughter / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Daughter / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Daughter / Mother"
replace typeoffamily="nuclear" if family=="Head / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Daughter / Son / Son / Grandchild"
replace typeoffamily="stem" if family=="Head / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Daughter-in-law / Grandchild / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Daughter-in-law / Son / Son / Father"
replace typeoffamily="stem" if family=="Head / Father / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="nuclear" if family=="Head / Father / Mother / Brother"
replace typeoffamily="joint-stem" if family=="Head / Father / Mother / Brother / Cousin / Son-in-law / Son-in-law / Brother / Cousin / Son-in-law"
replace typeoffamily="joint-stem" if family=="Head / Father / Wife / Daughter-in-law / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Grandchild / Grandchild / Grandchild / Grandchild"
replace typeoffamily="nuclear" if family=="Head / Head / Daughter / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Mother / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Mother / Daughter-in-law / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Mother / Son / Daughter-in-law / Son / Daughter-in-law / Grandchild / Grandchild / Daughter-in-law / Grandchild"
replace typeoffamily="nuclear" if family=="Head / Mother / Son / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Mother / Son / Son / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Mother / Wife"
replace typeoffamily="stem" if family=="Head / Mother / Wife / Daughter"
replace typeoffamily="stem" if family=="Head / Mother-in-law / Other / Father-in-law / Other / Other / Other / Other"
replace typeoffamily="stem" if family=="Head / Mother-in-law / Other / Other / Other / Other / Father-in-law / Son"
replace typeoffamily="stem" if family=="Head / Mother-in-law / Son / Daughter / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Other"
replace typeoffamily="stem" if family=="Head / Other / Daughter"
replace typeoffamily="nuclear" if family=="Head / Other / Daughter / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Other / Daughter / Daughter / Daughter / Son"
replace typeoffamily="nuclear" if family=="Head / Other / Daughter / Daughter / Son"
replace typeoffamily="nuclear" if family=="Head / Other / Daughter / Daughter / Son / Son"
replace typeoffamily="nuclear" if family=="Head / Other / Daughter / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Other / Daughter / Father-in-law / Mother-in-law"
replace typeoffamily="nuclear" if family=="Head / Other / Daughter / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Other / Daughter / Son / Father-in-law"
replace typeoffamily="stem" if family=="Head / Other / Daughter / Son / Other / Mother-in-law"
replace typeoffamily="nuclear" if family=="Head / Other / Daughter / Son / Son"
replace typeoffamily="stem" if family=="Head / Other / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Other / Daughter-in-law / Other"
replace typeoffamily="stem" if family=="Head / Other / Father-in-law / Mother-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Other / Father-in-law / Mother-in-law / Other / Daughter / Daughter / Daughter"
replace typeoffamily="stem" if family=="Head / Other / Mother-in-law / Daughter"
replace typeoffamily="stem" if family=="Head / Other / Mother-in-law / Daughter / Daughter"
replace typeoffamily="stem" if family=="Head / Other / Mother-in-law / Other / Other / Daughter"
replace typeoffamily="stem" if family=="Head / Other / Mother-in-law / Other / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Other / Mother-in-law / Son"
replace typeoffamily="stem" if family=="Head / Other / Mother-in-law / Son / Son"
replace typeoffamily="nuclear" if family=="Head / Other / Son"
replace typeoffamily="nuclear" if family=="Head / Other / Son / Daughter"
replace typeoffamily="nuclear" if family=="Head / Other / Son / Daughter / Daughter"
replace typeoffamily="stem" if family=="Head / Other / Son / Daughter / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Other / Son / Daughter / Mother-in-law"
replace typeoffamily="nuclear" if family=="Head / Other / Son / Daughter / Other"
replace typeoffamily="nuclear" if family=="Head / Other / Son / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Other / Son / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Other / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Other / Son / Daughter-in-law / Grandchild / Son / Son / Grandchild / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Other / Son / Mother-in-law"
replace typeoffamily="nuclear" if family=="Head / Other / Son / Son"
replace typeoffamily="nuclear" if family=="Head / Other / Son / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Other / Son / Son / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Other / Son / Son / Mother-in-law"
replace typeoffamily="nuclear" if family=="Head / Other / Son / Son / Son"
replace typeoffamily="stem" if family=="Head / Other / Son / Son / Son / Daughter-in-law / Grandchild / Grandchild / Other"
replace typeoffamily="stem" if family=="Head / Other / Son / Son / Son / Mother-in-law"
replace typeoffamily="nuclear" if family=="Head / Son"
replace typeoffamily="nuclear" if family=="Head / Son / Daughter"
replace typeoffamily="nuclear" if family=="Head / Son / Daughter / Daughter"
replace typeoffamily="stem" if family=="Head / Son / Daughter / Grandchild"
replace typeoffamily="stem" if family=="Head / Son / Daughter / Son / Daughter-in-law / Son / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Son / Daughter / Son / Father / Mother"
replace typeoffamily="stem" if family=="Head / Son / Daughter / Son / Other / Daughter-in-law"
replace typeoffamily="joint-stem" if family=="Head / Son / Daughter / Son-in-law / Grandchild / Grandchild / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Son / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Son / Daughter-in-law / Daughter / Daughter"
replace typeoffamily="stem" if family=="Head / Son / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Son / Daughter-in-law / Grandchild / Daughter"
replace typeoffamily="stem" if family=="Head / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild / Grandchild / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild / Son / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild / Son"
replace typeoffamily="joint-stem" if family=="Head / Son / Daughter-in-law / Grandchild / Son / Daughter-in-law / Grandchild / Grandchild / Son"
replace typeoffamily="stem" if family=="Head / Son / Daughter-in-law / Son"
replace typeoffamily="joint-stem" if family=="Head / Son / Daughter-in-law / Son / Daughter-in-law / Son / Grandchild / Grandchild / Grandchild / Daughter-in-law / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Son / Daughter-in-law / Son / Grandchild / Daughter-in-law / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Son / Daughter-in-law / Son / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="nuclear" if family=="Head / Son / Son"
replace typeoffamily="nuclear" if family=="Head / Son / Son / Daughter"
replace typeoffamily="joint-stem" if family=="Head / Son / Son / Daughter-in-law / Grandchild / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Son / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Son / Son / Daughter-in-law / Grandchild / Grandchild / Daughter-in-law"
replace typeoffamily="nuclear" if family=="Head / Son / Son / Son"
replace typeoffamily="stem" if family=="Head / Son / Son / Son / Daughter-in-law"
replace typeoffamily="joint-stem" if family=="Head / Son / Son / Son / Daughter-in-law / Grandchild / Grandchild / Daughter-in-law"
replace typeoffamily="joint-stem" if family=="Head / Son-in-law / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="nuclear" if family=="Head / Wife"
replace typeoffamily="joint-stem" if family=="Head / Wife / Brother / Other / Son / Other / Daughter-in-law / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Brother / Son"
replace typeoffamily="joint-stem" if family=="Head / Wife / Brother / Son / Daughter / Mother / Other"
replace typeoffamily="joint-stem" if family=="Head / Wife / Brother / Son / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Cousin / Son / Daughter-in-law / Grandchild"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Daughter / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Daughter / Daughter / Daughter / Son / Father"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Daughter / Father / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Daughter / Mother"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Son"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Son / Daughter / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Daughter / Son / Father / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Daughter / Son / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Daughter / Son / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Father / Mother / Son"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Father-in-law"
replace typeoffamily="joint-stem" if family=="Head / Wife / Daughter / Mother / Brother / Daughter-in-law / Grandchild"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Son"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Son / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Son / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Son / Daughter / Son / Son / Wife"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Son / Father / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Son / Father / Mother / Brother / Other / Other / Other / Other"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Son / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Son / Mother"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Son / Son"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Son / Son / Son-in-law"
replace typeoffamily="stem" if family=="Head / Wife / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Daughter-in-law / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Daughter-in-law / Son / Son / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Daughter-in-law / Son / Son / Son / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Father / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Father / Mother / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Wife / Father / Mother / Son"
replace typeoffamily="stem" if family=="Head / Wife / Father / Mother / Son / Son"
replace typeoffamily="stem" if family=="Head / Wife / Mother"
replace typeoffamily="joint-stem" if family=="Head / Wife / Mother / Brother / Son / Son"
replace typeoffamily="joint-stem" if family=="Head / Wife / Mother / Brother / Son-in-law / Other / Other / Daughter-in-law / Son-in-law / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Wife / Mother / Daughter / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Mother / Daughter / Son / Son"
replace typeoffamily="stem" if family=="Head / Wife / Mother / Son"
replace typeoffamily="stem" if family=="Head / Wife / Mother / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Mother / Son / Son"
replace typeoffamily="stem" if family=="Head / Wife / Mother / Son / Son / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Mother-in-law / Son"
replace typeoffamily="stem" if family=="Head / Wife / Sister"
replace typeoffamily="nuclear" if family=="Head / Wife / Son"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Brother / Mother"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Daughter / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Daughter / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Father / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Mother / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Mother-in-law"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Son / Daughter / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Son / Daughter / Son / Son / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Son / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Son / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Daughter / Daughter / Grandchild / Grandchild / Grandchild / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Daughter / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Daughter / Son / Daughter / Son"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Daughter / Son-in-law / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Daughter-in-law / Daughter-in-law / Grandchild / Grandchild / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Son / Daughter-in-law / Grandchild / Daughter"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Son / Daughter-in-law / Grandchild / Grandchild / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Son"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Son / Grandchild / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Other"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Son / Daughter / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Son / Daughter-in-law / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Son / Daughter-in-law / Son / Daughter / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Son / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Son / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Son / Father"
replace typeoffamily="stem" if family=="Head / Wife / Son / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Mother"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Mother / Brother / Other"
replace typeoffamily="stem" if family=="Head / Wife / Son / Mother / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Son / Mother-in-law / Son"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Brother / Brother / Father / Mother"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Brother / Mother"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son / Daughter / Daughter"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Daughter / Daughter / Daughter-in-law / Grandchild / Grandchild / Daughter-in-law / Grandchild / Grandchild / Son-in-law"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Daughter / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Daughter / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Daughter / Father / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Daughter / Grandmother"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Daughter / Son / Father / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Daughter-in-law"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Daughter-in-law / Daughter-in-law / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Daughter-in-law / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Daughter-in-law / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Daughter-in-law / Grandchild / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Daughter-in-law / Grandchild / Grandchild / Daughter-in-law / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Daughter-in-law / Grandchild / Grandchild / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Father"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Father / Sister"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Mother"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son / Other"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son / Son"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Son / Daughter / Daughter-in-law / Daughter-in-law / Grandchild / Daughter-in-law"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Son / Daughter-in-law / Daughter-in-law / Grandchild / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Son / Daughter-in-law / Grandchild"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son / Son / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Son-in-law / Daughter / Mother / Father"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Wife"
replace typeoffamily="stem" if family=="Head / Wife / Son-in-law / Daughter / Grandchild / Grandchild / Grandchild"
replace typeoffamily="nuclear" if family=="Head / Wife / Wife / Son"
replace typeoffamily="nuclear" if family=="Head / Wife / Wife / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Wife / Son / Daughter-in-law / Son / Daughter / Son"
replace typeoffamily="joint-stem" if family=="Mother / Head / Wife / Daughter / Daughter / Brother"
replace typeoffamily="stem" if family=="Mother / Head / Wife / Son / Son"
replace typeoffamily="stem" if family=="Son / Daughter-in-law / Head / Wife"
replace typeoffamily="nuclear" if family=="Son / Head"
replace typeoffamily="nuclear" if family=="Son / Head / Wife / Son"
replace typeoffamily="nuclear" if family=="Wife"
replace typeoffamily="nuclear" if family=="Wife / Head / Daughter / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Wife / Head / Daughter / Daughter / Daughter / Son"
replace typeoffamily="stem" if family=="Wife / Head / Daughter / Daughter / Daughter / Son / Mother"
replace typeoffamily="stem" if family=="Wife / Head / Daughter / Daughter / Mother"
replace typeoffamily="nuclear" if family=="Wife / Head / Daughter / Son"
replace typeoffamily="joint-stem" if family=="Wife / Head / Daughter / Son / Daughter / Brother / Grandfather"
replace typeoffamily="stem" if family=="Wife / Head / Daughter / Son / Daughter / Son-in-law / Grandchild"
replace typeoffamily="stem" if family=="Wife / Head / Father / Mother"
replace typeoffamily="stem" if family=="Wife / Head / Father / Mother / Daughter / Daughter"
replace typeoffamily="stem" if family=="Wife / Head / Father / Mother / Daughter / Daughter / Son"
replace typeoffamily="stem" if family=="Wife / Head / Father / Mother / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Wife / Head / Father / Mother / Son / Son / Son"
replace typeoffamily="stem" if family=="Wife / Head / Mother / Daughter"
replace typeoffamily="stem" if family=="Wife / Head / Mother / Son"
replace typeoffamily="nuclear" if family=="Wife / Head / Son"
replace typeoffamily="nuclear" if family=="Wife / Head / Son / Daughter"
replace typeoffamily="stem" if family=="Wife / Head / Son / Daughter / Mother-in-law / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Wife / Head / Son / Daughter-in-law"
replace typeoffamily="stem" if family=="Wife / Head / Son / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Wife / Head / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Wife / Head / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Wife / Head / Son / Daughter-in-law / Son / Grandchild"
replace typeoffamily="stem" if family=="Wife / Head / Son / Son / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Wife / Mother / Head / Daughter / Daughter"
replace typeoffamily="joint-stem" if family=="Wife / Mother-in-law / Head / Brother / Other / Son / Son / Other / Daughter / Daughter"
replace typeoffamily="stem" if family=="Wife / Mother-in-law / Other / Daughter / Son"
replace typeoffamily="nuclear" if family=="Wife / Son"
replace typeoffamily="stem" if family=="Wife / Son / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Wife / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Wife / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Wife / Son / Daughter-in-law / Son / Daughter-in-law / Grandchild / Grandchild"

ta typeoffamily



*** Pb
ta typeoffamily
gen pb=0

replace pb=1 if family=="Daughter-in-law / Other / Daughter / Head / Wife"
replace pb=1 if family=="Head / Father / Mother / Brother"
replace pb=1 if family=="Head / Father / Mother / Brother / Cousin / Son-in-law / Son-in-law / Brother / Cousin / Son-in-law"
replace pb=1 if family=="Head / Grandchild / Grandchild / Grandchild / Grandchild"
replace pb=1 if family=="Head / Head / Daughter / Daughter / Son"
replace pb=1 if family=="Head / Mother / Daughter / Son"
replace pb=1 if family=="Head / Mother / Daughter-in-law / Grandchild"
replace pb=1 if family=="Head / Mother / Son / Son / Daughter"
replace pb=1 if family=="Head / Mother-in-law / Other / Father-in-law / Other / Other / Other / Other"
replace pb=1 if family=="Head / Mother-in-law / Other / Other / Other / Other / Father-in-law / Son"
replace pb=1 if family=="Head / Mother-in-law / Son / Daughter / Daughter-in-law / Grandchild"
replace pb=1 if family=="Head / Other"
replace pb=1 if family=="Head / Other / Daughter"
replace pb=1 if family=="Head / Other / Daughter / Daughter / Daughter"
replace pb=1 if family=="Head / Other / Daughter / Daughter / Daughter / Son"
replace pb=1 if family=="Head / Other / Daughter / Daughter / Son"
replace pb=1 if family=="Head / Other / Daughter / Daughter / Son / Son"
replace pb=1 if family=="Head / Other / Daughter / Daughter-in-law / Grandchild"
replace pb=1 if family=="Head / Other / Daughter / Son / Daughter"
replace pb=1 if family=="Head / Other / Daughter / Son / Son"
replace pb=1 if family=="Head / Other / Daughter-in-law / Grandchild / Grandchild"
replace pb=1 if family=="Head / Other / Daughter-in-law / Other"
replace pb=1 if family=="Head / Other / Father-in-law / Mother-in-law / Grandchild"
replace pb=1 if family=="Head / Other / Mother-in-law / Other / Other / Daughter"
replace pb=1 if family=="Head / Other / Son"
replace pb=1 if family=="Head / Other / Son / Daughter"
replace pb=1 if family=="Head / Other / Son / Daughter / Daughter"
replace pb=1 if family=="Head / Other / Son / Daughter / Other"
replace pb=1 if family=="Head / Other / Son / Daughter / Son"
replace pb=1 if family=="Head / Other / Son / Son"
replace pb=1 if family=="Head / Other / Son / Son / Daughter"
replace pb=1 if family=="Head / Other / Son / Son / Son"
replace pb=1 if family=="Head / Other / Son / Son / Son / Daughter-in-law / Grandchild / Grandchild / Other"
replace pb=1 if family=="Head / Son-in-law / Daughter-in-law / Grandchild / Grandchild"
replace pb=1 if family=="Head / Wife / Brother / Other / Son / Other / Daughter-in-law / Grandchild"
replace pb=1 if family=="Head / Wife / Brother / Son"
replace pb=1 if family=="Head / Wife / Brother / Son / Daughter-in-law / Grandchild"
replace pb=1 if family=="Head / Wife / Cousin / Son / Daughter-in-law / Grandchild"
replace pb=1 if family=="Head / Wife / Daughter / Daughter / Son / Grandchild / Grandchild / Grandchild"
replace pb=1 if family=="Head / Wife / Daughter / Mother / Brother / Daughter-in-law / Grandchild"
replace pb=1 if family=="Head / Wife / Daughter / Son / Father / Mother / Brother / Other / Other / Other / Other"
replace pb=1 if family=="Head / Wife / Daughter / Son / Grandchild"
replace pb=1 if family=="Head / Wife / Mother / Brother / Son / Son"
replace pb=1 if family=="Head / Wife / Mother / Brother / Son-in-law / Other / Other / Daughter-in-law / Son-in-law / Daughter-in-law"
replace pb=1 if family=="Head / Wife / Son / Mother / Brother / Other"
replace pb=1 if family=="Head / Wife / Son / Son / Brother / Brother / Father / Mother"
replace pb=1 if family=="Head / Wife / Son / Son / Brother / Mother"
replace pb=1 if family=="Head / Wife / Son / Son / Father / Sister"
replace pb=1 if family=="Head / Wife / Son / Son / Other"
replace pb=1 if family=="Mother / Head / Wife / Daughter / Daughter / Brother"
replace pb=1 if family=="Wife / Head / Daughter / Son / Daughter / Brother / Grandfather"
replace pb=1 if family=="Wife / Mother-in-law / Head / Brother / Other / Son / Son / Other / Daughter / Daughter"

sort HHID2020
order HHID2020 family typeoffamily
*br if pb==1

replace pb=. if HHID2020=="uuid:03e32009-5844-412d-a794-19940ae73716"

replace pb=. if HHID2020=="uuid:070fce41-4193-4620-8eb7-60e8c3898201"

replace pb=. if HHID2020=="uuid:25cdd34e-00a0-44b2-bf71-cf9de75221be"

replace pb=. if HHID2020=="uuid:26c10846-8095-4881-8c73-4844d1991bf8"

replace pb=. if HHID2020=="uuid:2abcfcbc-7317-41ba-a857-f76f6e62fc7c"

replace pb=. if HHID2020=="uuid:31c52e14-e00c-4dcd-a2eb-eed5e6210815"

replace typeoffamily="nuclear" if HHID2020=="uuid:39351034-92a0-4681-a206-c3ebeb52653f"
replace pb=. if HHID2020=="uuid:39351034-92a0-4681-a206-c3ebeb52653f"

replace typeoffamily="nuclear" if HHID2020=="uuid:441687fe-0f39-4a82-9e6c-2f5ff37c1b0f"
replace pb=. if HHID2020=="uuid:441687fe-0f39-4a82-9e6c-2f5ff37c1b0f"

replace typeoffamily="nuclear" if HHID2020=="uuid:4ae7e88a-6467-40be-a48a-8f1eaa4a0baf"
replace pb=. if HHID2020=="uuid:4ae7e88a-6467-40be-a48a-8f1eaa4a0baf"

replace pb=. if HHID2020=="uuid:5d241a40-46cf-4508-852d-d3c125e37604"

replace pb=. if HHID2020=="uuid:5f261b0d-6994-4200-b5ca-73e776d149be"

replace pb=. if HHID2020=="uuid:66f42c1b-3d3b-4121-b4bb-249f136d72e5"

replace pb=. if HHID2020=="uuid:678ba5c4-cee2-49fa-b6c7-e1250ce5295b"

replace typeoffamily="nuclear" if HHID2020=="uuid:703d78a1-b9c3-45b5-ac69-163c12745ed0"
replace pb=. if HHID2020=="uuid:703d78a1-b9c3-45b5-ac69-163c12745ed0"

replace pb=. if HHID2020=="uuid:7262fcdc-4ba9-4d04-835e-443a95a0b0c2"

replace pb=. if HHID2020=="uuid:738df800-fa4c-4cee-81f8-72bb53564990"

replace pb=. if HHID2020=="uuid:73f28c3e-e5f1-4951-954a-7ddfc933a11e"

replace typeoffamily="nuclear" if HHID2020=="uuid:74b95f19-a5ed-4cdb-aac8-30ae79a127ca"
replace pb=. if HHID2020=="uuid:74b95f19-a5ed-4cdb-aac8-30ae79a127ca"

replace typeoffamily="nuclear" if HHID2020=="uuid:763e2568-e781-479b-86cb-201f39f2eb3a"
replace pb=. if HHID2020=="uuid:763e2568-e781-479b-86cb-201f39f2eb3a"

replace pb=. if HHID2020=="uuid:7ce6b544-f79d-40ff-8ef5-40dfa02d9465"

replace pb=. if HHID2020=="uuid:83db958d-b1ad-4544-a3d9-5f582dd900c8"

replace pb=. if HHID2020=="uuid:86574ca0-02c2-4e2b-9d3b-f644d9c6da68"

replace typeoffamily="nuclear" if HHID2020=="uuid:86d54bc7-b23c-4ad7-ad47-250404d04ccc"
replace pb=. if HHID2020=="uuid:86d54bc7-b23c-4ad7-ad47-250404d04ccc"

replace pb=. if HHID2020=="uuid:88644fe9-66bb-41c7-afce-7e593439ff27"

replace typeoffamily="nuclear" if HHID2020=="uuid:97438af9-eae1-4e11-9ba7-0a966fcc2a57"
replace pb=. if HHID2020=="uuid:97438af9-eae1-4e11-9ba7-0a966fcc2a57"

replace pb=. if HHID2020=="uuid:aa077042-0015-4f4b-ad9f-8f06c5c8da45"

replace pb=. if HHID2020=="uuid:af69024c-76b5-4331-8c4e-19874ea396e6"

replace pb=. if HHID2020=="uuid:bb31eb37-cb83-489a-b538-13f12f0b5419"

replace pb=. if HHID2020=="uuid:c214c94b-f4e8-4c5d-8118-0fc69e3ae17c"

replace pb=. if HHID2020=="uuid:c42daed4-b508-45c6-afb1-03bf50ed9420"

replace pb=. if HHID2020=="uuid:c73e8633-ddd2-4cc6-bf39-f25b281b146d"

replace pb=. if HHID2020=="uuid:cc11fc8b-7e06-480d-a91b-ccccd1466e66"

replace pb=. if HHID2020=="uuid:ce113294-d940-48a3-bc59-4f042ac193f4"

replace pb=. if HHID2020=="uuid:ddc4ecff-75f2-4877-8e72-1d100d73c88d"

replace pb=. if HHID2020=="uuid:e2e28cbe-6370-4603-98ef-e10cc11f1be8"

replace pb=. if HHID2020=="uuid:e4bae31a-5100-418e-91e1-9255864e93c4"

replace pb=. if HHID2020=="uuid:e5fd3b85-de2e-4842-908e-027bd523d002"

replace pb=. if HHID2020=="uuid:e772b351-ca9e-493d-b927-3397489040cf"

replace typeoffamily="joint-stem" if HHID2020=="uuid:e929db9e-dcb2-4dc6-b523-4c39c8848ba1"
replace pb=. if HHID2020=="uuid:e929db9e-dcb2-4dc6-b523-4c39c8848ba1"

replace typeoffamily="nuclear" if HHID2020=="uuid:effc782f-204c-4056-a893-6d4e9fe8c4b9"
replace pb=. if HHID2020=="uuid:effc782f-204c-4056-a893-6d4e9fe8c4b9"

replace typeoffamily="nuclear" if HHID2020=="uuid:fb3e15f2-aede-49d5-8eee-514affc34b1a"
replace pb=. if HHID2020=="uuid:fb3e15f2-aede-49d5-8eee-514affc34b1a"

replace typeoffamily="stem" if HHID2020=="uuid:fbd9ed1c-4843-43fb-8ad6-d2ee466a9672"
replace pb=. if HHID2020=="uuid:fbd9ed1c-4843-43fb-8ad6-d2ee466a9672"

replace pb=. if HHID2020=="uuid:08805e55-b049-4379-8677-fccd5372fb7d"

replace pb=. if HHID2020=="uuid:12659065-bcc2-4803-92ae-b81b8897ee3d"

replace typeoffamily="joint-stem" if HHID2020=="uuid:26341970-61d5-4447-92b1-09915e0c06ef"
replace pb=. if HHID2020=="uuid:26341970-61d5-4447-92b1-09915e0c06ef"

replace pb=. if HHID2020=="uuid:2ef3acc0-a9f2-4124-bf9a-479f6f13ce50"

replace typeoffamily="joint-stem" if HHID2020=="uuid:33a9630e-ba1c-421a-a540-643552c68906"
replace pb=. if HHID2020=="uuid:33a9630e-ba1c-421a-a540-643552c68906"

replace pb=. if HHID2020=="uuid:3c12e85b-1eff-42e2-8f3e-2084211af237"

replace pb=. if HHID2020=="uuid:40c80fef-29fb-469a-93ec-a88c805e2df4"

replace typeoffamily="stem" if HHID2020=="uuid:4d0712ef-e78d-4199-8498-874050c0aee4"
replace pb=. if HHID2020=="uuid:4d0712ef-e78d-4199-8498-874050c0aee4"

replace pb=. if HHID2020=="uuid:5055d831-694d-47ea-967c-d5c496f18054"

replace pb=. if HHID2020=="uuid:53fb037b-4a2d-43f2-892e-9d9f61a07cd4"

replace pb=. if HHID2020=="uuid:5672b71a-0908-47a7-bad7-a2d698f59343"

replace pb=. if HHID2020=="uuid:5fa75706-2fb9-48df-a3ca-8f1dc20d441f"

replace typeoffamily="joint-stem" if HHID2020=="uuid:6058eb4c-e624-4c9c-9c2b-310ff1e4c31d"
replace pb=. if HHID2020=="uuid:6058eb4c-e624-4c9c-9c2b-310ff1e4c31d"

replace typeoffamily="stem" if HHID2020=="uuid:66442499-ae81-4c2b-9ff7-bd51a34f8b52"
replace pb=. if HHID2020=="uuid:66442499-ae81-4c2b-9ff7-bd51a34f8b52"

replace pb=. if HHID2020=="uuid:6b74f19b-ace7-427b-817d-cf8bb1f4c45c"

replace typeoffamily="stem" if HHID2020=="uuid:7062e9df-c370-49be-b44d-fcff496a841d"
replace pb=. if HHID2020=="uuid:7062e9df-c370-49be-b44d-fcff496a841d"

replace pb=. if HHID2020=="uuid:7e4320c5-0180-41de-b783-0d5babc0c913"

replace pb=. if HHID2020=="uuid:8e101d4b-4f24-4d89-a01a-a3b052a9384f"

replace typeoffamily="joint-stem" if HHID2020=="uuid:98bee3a6-1395-46a9-b5d2-f3b9b4a55c8b"
replace pb=. if HHID2020=="uuid:98bee3a6-1395-46a9-b5d2-f3b9b4a55c8b"

replace pb=. if HHID2020=="uuid:a82dd992-21e1-4ba7-8d4a-cece977e50e0"

replace typeoffamily="stem" if HHID2020=="uuid:b17568cd-919e-49f1-8c09-7ff9e8ccbb4d"
replace pb=. if HHID2020=="uuid:b17568cd-919e-49f1-8c09-7ff9e8ccbb4d"

replace pb=. if HHID2020=="uuid:b48ea7a0-e547-4a77-9448-30d5349af560"

replace pb=. if HHID2020=="uuid:bcc8d5ca-1663-4eed-8b78-d87fe86a32bb"

replace pb=. if HHID2020=="uuid:c14788bc-235f-4690-b9bf-15bfde3788ef"

replace typeoffamily="joint-stem" if HHID2020=="uuid:cc5db495-5a2c-4ea5-9dc3-af828578c005"
replace pb=. if HHID2020=="uuid:cc5db495-5a2c-4ea5-9dc3-af828578c005"

replace pb=. if HHID2020=="uuid:e0e6ea69-9726-429f-8ba3-b9e60a340685"

replace typeoffamily="joint-stem" if HHID2020=="uuid:e4801936-88ec-441b-8b8f-baf943464650"
replace pb=. if HHID2020=="uuid:e4801936-88ec-441b-8b8f-baf943464650"

replace typeoffamily="joint-stem" if HHID2020=="uuid:e63e2564-f65e-44d8-beca-062121a016a5"
replace pb=. if HHID2020=="uuid:e63e2564-f65e-44d8-beca-062121a016a5"

replace pb=. if HHID2020=="uuid:f612acf8-feb5-4d29-824f-6ec5448323e0"


drop pb



*** Pb between joint-stem and stem
gen pb=.
replace pb=1 if strpos(family,"Brother") 
replace pb=1 if strpos(family,"Sister") 

*br if pb==1 & typeoffamily=="stem"

replace typeoffamily="joint-stem" if HHID2020=="uuid:43179492-f693-489b-a554-70bb3e8ae1fa"
replace pb=. if HHID2020=="uuid:43179492-f693-489b-a554-70bb3e8ae1fa"

replace typeoffamily="joint-stem" if HHID2020=="uuid:4d0712ef-e78d-4199-8498-874050c0aee4"
replace pb=. if HHID2020=="uuid:4d0712ef-e78d-4199-8498-874050c0aee4"

replace typeoffamily="joint-stem" if HHID2020=="uuid:66442499-ae81-4c2b-9ff7-bd51a34f8b52"
replace pb=. if HHID2020=="uuid:66442499-ae81-4c2b-9ff7-bd51a34f8b52"

replace typeoffamily="joint-stem" if HHID2020=="uuid:72cbd9f1-7b7e-456b-a173-8bde0c64afbd"
replace pb=. if HHID2020=="uuid:72cbd9f1-7b7e-456b-a173-8bde0c64afbd"

replace typeoffamily="joint-stem" if HHID2020=="uuid:b17568cd-919e-49f1-8c09-7ff9e8ccbb4d"
replace pb=. if HHID2020=="uuid:b17568cd-919e-49f1-8c09-7ff9e8ccbb4d"


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
keep HHID2020 INDID2020 name age sex relationshiptohead* livinghome maritalstatus
fre livinghome
drop if livinghome==.
drop if livinghome==3
drop if livinghome==4
drop livinghome


*** Relationship to head
fre relationshiptohead
ta relationshiptoheadother


* Recode
replace relationshiptohead=1 if HHID2020=="uuid:b71a4b81-2329-483e-b100-f883b48c1a91" & INDID2020==1

replace relationshiptohead=2 if relationshiptohead==77 & relationshiptoheadother=="Husband"  // 2 wife 
replace relationshiptoheadother="" if relationshiptoheadother=="Husband"

replace relationshiptohead=2 if relationshiptohead==77 & relationshiptoheadother=="Huband"  // 2 wife
replace relationshiptoheadother="" if relationshiptoheadother=="Huband"

replace relationshiptohead=13 if relationshiptohead==77 & relationshiptoheadother=="Daughter's daughter"  // 13 grand child
replace relationshiptoheadother="" if relationshiptoheadother=="Daughter's daughter"

replace relationshiptohead=18 if relationshiptohead==77 & relationshiptoheadother=="Brother's wife"  // 18 sister in law
replace relationshiptoheadother="" if relationshiptoheadother=="Brother's wife"

replace relationshiptohead=18 if relationshiptohead==77 & relationshiptoheadother=="Sister in law"  // 18 sister in law
replace relationshiptoheadother="" if relationshiptoheadother=="Sister in law"

replace relationshiptohead=18 if relationshiptohead==77 & relationshiptoheadother=="Murugan's wife"  // 18 sister in law
replace relationshiptoheadother="" if relationshiptoheadother=="Murugan's wife"

replace relationshiptohead=18 if relationshiptohead==77 & relationshiptoheadother=="Sivakandan's wife"  // 18 sister in law
replace relationshiptoheadother="" if relationshiptoheadother=="Sivakandan's wife"

replace relationshiptohead=18 if relationshiptohead==77 & relationshiptoheadother=="Anbarasan's wife"  // 18 sister in law
replace relationshiptoheadother="" if relationshiptoheadother=="Anbarasan's wife"

replace relationshiptohead=19 if relationshiptohead==77 & relationshiptoheadother=="Husband's brother"  // 19 brother in law
replace relationshiptoheadother="" if relationshiptoheadother=="Husband's brother"

replace relationshiptohead=19 if relationshiptohead==77 & relationshiptoheadother=="Brother in law"  // 19 brother in law
replace relationshiptoheadother="" if relationshiptoheadother=="Brother in law"

replace relationshiptohead=20 if relationshiptohead==77 & relationshiptoheadother=="Mother's sister"  // 20 auntie uncle
replace relationshiptoheadother="" if relationshiptoheadother=="Mother's sister"

replace relationshiptohead=21 if relationshiptohead==77 & relationshiptoheadother=="Murugan's son"  // 21 nephew niece
replace relationshiptoheadother="" if relationshiptoheadother=="Murugan's son"

replace relationshiptohead=21 if relationshiptohead==77 & relationshiptoheadother=="Sivakandan's daughter"  // 21 nephew niece
replace relationshiptoheadother="" if relationshiptoheadother=="Sivakandan's daughter"

replace relationshiptohead=21 if relationshiptohead==77 & relationshiptoheadother=="Anbarasan's son"  // 21 nephew niece
replace relationshiptoheadother="" if relationshiptoheadother=="Anbarasan's son"

replace relationshiptohead=21 if relationshiptohead==77 & relationshiptoheadother=="Mangalakshmi is sumathi's younger sister's daughter. Mangalakshmi's parents were died so sumathi taking care of her."  // 21 nephew niece
replace relationshiptoheadother="" if relationshiptoheadother=="Mangalakshmi is sumathi's younger sister's daughter. Mangalakshmi's parents were died so sumathi taking care of her."


gen test1=1 if relationshiptohead==77
bysort HHID2020: egen test2=sum(test1)
ta test2
sort HHID2020 INDID2020
*br if test2!=0
drop test2 test1

* Label
codebook relationshiptohead
label define relationshipwithinhh 18"Sister in law" 19"Brother in law" 20"Auntie/uncle" 21"Nephew/niece", modify
ta relationshiptohead, m

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
rename relation_17 relation_sisterinlaw
rename relation_18 relation_brotherinlaw
rename relation_19 relation_auntieuncle
rename relation_20 relation_nephewniece


*** Merge type of family to count
merge m:1 HHID2020 using "_temp/NEEMSIS2-family2"
drop _merge


*** How many per gen?
foreach x in relation_head relation_wife relation_mother relation_father relation_son relation_daughter relation_soninlaw relation_daughterinlaw relation_sister relation_brother relation_motherinlaw relation_fatherinlaw relation_grandchildren relation_grandfather relation_grandmother relation_cousin relation_sisterinlaw relation_brotherinlaw relation_auntieuncle relation_nephewniece {
bysort HHID2020: egen _temp`x'=sum(`x')
drop `x'
rename _temp`x' `x'
}



gen nbgeneration1=relation_grandchildren
egen nbgeneration2=rowtotal(relation_son relation_daughter relation_daughterinlaw relation_soninlaw relation_nephewniece)
egen nbgeneration3=rowtotal(relation_head relation_wife relation_sister relation_brother relation_cousin relation_sisterinlaw relation_brotherinlaw)
egen nbgeneration4=rowtotal(relation_mother relation_father relation_motherinlaw relation_fatherinlaw relation_auntieuncle)
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
keep HHID2020 INDID2020 name age sex egoid relationshiptohead* livinghome maritalstatus
fre livinghome
drop if livinghome==.
drop if livinghome==3
drop if livinghome==4
drop livinghome


*** Relationship to head
fre relationshiptohead
replace relationshiptohead=1 if HHID2020=="uuid:b71a4b81-2329-483e-b100-f883b48c1a91" & INDID2020==1


*** Identified duplicates
preserve
keep if relationshiptohead==1
duplicates tag HHID2020, gen(tag)
ta tag
sort HHID2020
*br HHID2020 INDID2020 name age sex relationshiptohead maritalstatus if tag!=0
restore

replace relationshiptohead=2 if HHID2020=="uuid:5672b71a-0908-47a7-bad7-a2d698f59343" & INDID2020==1


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

replace relationshiptohead=1 if HHID2020=="uuid:0e75c80d-e953-475e-b5bd-4a5f3b9755e6" & INDID2020==2
replace relationshiptohead=1 if HHID2020=="uuid:16edf956-9689-480c-b1ac-55f13c717186" & INDID2020==2
replace relationshiptohead=1 if HHID2020=="uuid:607b5085-73ed-4c37-9c6f-55e6d4ac7875" & INDID2020==2
replace relationshiptohead=1 if HHID2020=="uuid:a01b1cb0-bc31-420c-a1e7-f46d3011c81b" & INDID2020==2
replace relationshiptohead=1 if HHID2020=="uuid:a4472750-0183-4a1b-9274-8e7ad61732e8" & INDID2020==1
replace relationshiptohead=1 if HHID2020=="uuid:a807111d-42b8-4fca-95f3-6eec9cef337b" & INDID2020==3
replace relationshiptohead=1 if HHID2020=="uuid:b33ac02d-ffe0-4a63-8b4a-1ac442b86cf7" & INDID2020==2
replace relationshiptohead=1 if HHID2020=="uuid:b69ff416-6c97-4406-aa87-375d1d29cdc3" & INDID2020==1
replace relationshiptohead=1 if HHID2020=="uuid:d2c64ab3-d65d-46d7-b65b-4ad2431c436a" & INDID2020==1
replace relationshiptohead=1 if HHID2020=="uuid:f2e2edac-03f6-40f0-ac2a-8718fbd954e2" & INDID2020==2





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
* Dependency ratio
****************************************
use"$data", clear


*** Nb over age
egen dep_group=cut(age), at(0 15 65 100)
ta age dep_group
ta dep_group, gen(dep_group_)

*** Keep
keep HHID2020 dep_group_*
collapse (sum) dep_group_1 dep_group_2 dep_group_3, by(HHID2020)

gen pop_dependents=dep_group_1+dep_group_3
drop dep_group_1 dep_group_3
rename dep_group_2 pop_workingage

gen dependencyratio=pop_dependents/pop_workingage
replace dependencyratio=pop_dependents if pop_workingage==0

sum dependencyratio


save"_temp\NEEMSIS2-depratio", replace
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

merge 1:1 HHID2020 using "_temp\NEEMSIS2-depratio"
drop _merge

********* Type of HH head
*** Head female
ta head_sex
gen dummyheadfemale=0
replace dummyheadfemale=1 if head_sex==2


*** Head widow
gen head_widowseparated=0
replace head_widowseparated=1 if head_maritalstatus==3 | head_maritalstatus==4

ta head_maritalstatus head_widowseparated 
ta head_sex head_widowseparated


********* Adult and childrens
gen test=HH_count_adult+agegrp_14_17
*br family head_sex head_name if test==1

gen dummyoneadult=0
*replace dummyoneadult=1 if test==1
drop test


save"outcomes\NEEMSIS2-family", replace
****************************************
* END
