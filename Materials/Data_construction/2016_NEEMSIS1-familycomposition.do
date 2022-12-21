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
global data = "NEEMSIS1-HH"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020









****************************************
* Family composition
****************************************
use"$data", clear


*** To keep
keep HHID2016 INDID2016 name age sex relationshiptohead livinghome maritalstatus
fre livinghome
drop if livinghome==3
drop if livinghome==4
drop livinghome


*** Corr
tostring INDID2016, replace
merge m:m HHID2016 using "ODRIIS-HH_wide", keepusing(HHID_panel)
keep if _merge==3
drop _merge
merge m:m HHID_panel INDID2016 using "ODRIIS-Indiv_wide", keepusing(INDID_panel agecorr2016 sex2016 relationshiptohead2016 age2016)
keep if _merge==3
drop _merge
order HHID_panel INDID_panel HHID2016 INDID2016
destring INDID2016, replace

* V1
ta sex sex2016
drop sex2016

* V2
ta relationshiptohead relationshiptohead2016
drop relationshiptohead2016

* V3
destring age2016, replace
gen test=age-age2016
ta test
drop test age2016

* V4
destring agecorr2016, replace
gen test=age-agecorr2016
ta test
drop test age
rename agecorr2016 age


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
rename relation_14 relation_cousin
rename relation_15 relation_other


*** HH level
global var male female age_group agegrp_0_13 agegrp_14_17 agegrp_18_24 agegrp_25_29 agegrp_30_34 agegrp_35_39 agegrp_40_49 agegrp_50_59 agegrp_60_69 agegrp_70_79 agegrp_80_100 male_agegrp_0_13 female_agegrp_0_13 male_agegrp_14_17 female_agegrp_14_17 male_agegrp_18_24 female_agegrp_18_24 male_agegrp_25_29 female_agegrp_25_29 male_agegrp_30_34 female_agegrp_30_34 male_agegrp_35_39 female_agegrp_35_39 male_agegrp_40_49 female_agegrp_40_49 male_agegrp_50_59 female_agegrp_50_59 male_agegrp_60_69 female_agegrp_60_69 male_agegrp_70_79 female_agegrp_70_79 male_agegrp_80_100 female_agegrp_80_100 relation_head relation_wife relation_mother relation_father relation_son relation_daughter relation_soninlaw relation_daughterinlaw relation_sister relation_brother relation_motherinlaw relation_fatherinlaw relation_grandchildren relation_cousin relation_other

foreach x in $var {
bysort HHID2016: egen _temp`x'=sum(`x')
drop `x'
rename _temp`x' `x'
}


********** Corr HH size

* HH size
bysort HHID201: egen HHsize=sum(1)

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



keep HHID201 $var HHsize HH_count_child HH_count_adult equiscale_HHsize equimodiscale_HHsize squareroot_HHsize
duplicates drop



*** Clean
rename male nbmale
rename female nbfemale


save"_temp\NEEMSIS1-family1", replace
****************************************
* END






****************************************
* Type of family
****************************************
use"$data", clear


*** To keep
keep HHID2016 INDID2016 name age sex relationshiptohead livinghome maritalstatus
fre livinghome
drop if livinghome==3
drop if livinghome==4
drop livinghome


*** Reshape
bysort HHID2016 (INDID2016): gen n=_n
rename INDID2016 INDID
reshape wide INDID name age sex relationshiptohead maritalstatus, i(HHID2016) j(n)

forvalues i=1/13 {
decode relationshiptohead`i', gen(relation`i')
}

*** Concat
egen family=concat(relation1 relation2 relation3 relation4 relation5 relation6 relation7 relation8 relation9 relation10 relation11 relation12 relation13), p(" / ")
drop relation1 relation2 relation3 relation4 relation5 relation6 relation7 relation8 relation9 relation10 relation11 relation12 relation13

forvalues i=1/30{
replace family=substr(family, 1, strlen(family)-1) if substr(family,strlen(family),1)=="/"
replace family=substr(family, 1, strlen(family)-1) if substr(family,strlen(family),1)==" "
}

*** Display all choices
preserve
duplicates drop family, force
sort family
*list family, clean noobs
restore

*** Categories
gen typeoffamily=""

replace typeoffamily="nuclear" if family=="Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Son / Daughter-in-law / Grandchild / Cousin"
replace typeoffamily="stem" if family=="Mother / Head"
replace typeoffamily="stem" if family=="Mother / Head / Brother"
replace typeoffamily="stem" if family=="Mother / Head / Sister"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son / Daughter / Daughter / Son / Wife"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Wife"
replace typeoffamily="nuclear" if family=="Head / Wife / Wife"
replace typeoffamily="nuclear" if family=="Head / Wife / Wife / Daughter / Son / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Wife / Son"
replace typeoffamily="stem" if family=="Head / Wife / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace typeoffamily="nuclear" if family=="Wife / Head / Son / Daughter / Wife / Daughter / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Brother"
replace typeoffamily="nuclear" if family=="Father / Mother / Head / Brother / Sister"
replace typeoffamily="stem" if family=="Head / Father / Mother / Wife / Brother / Daughter / Son / Son / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Son / Other / Other / Other / Mother"
replace typeoffamily="joint-stem" if family=="Wife / Head / Son-in-law / Son-in-law"
replace typeoffamily="nuclear" if family=="Head"
replace typeoffamily="nuclear" if family=="Head / Daughter"
replace typeoffamily="nuclear" if family=="Head / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Daughter / Daughter / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Daughter / Mother"
replace typeoffamily="nuclear" if family=="Head / Daughter / Son"
replace typeoffamily="nuclear" if family=="Head / Daughter / Son / Daughter"
replace typeoffamily="nuclear" if family=="Head / Daughter / Son / Son"
replace typeoffamily="stem" if family=="Head / Daughter / Son-in-law"
replace typeoffamily="stem" if family=="Head / Daughter / Son-in-law / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Daughter-in-law / Head / Son / Grandchild / Son / Daughter-in-law / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Father / Mother"
replace typeoffamily="nuclear" if family=="Head / Son"
replace typeoffamily="nuclear" if family=="Head / Son / Daughter"
replace typeoffamily="nuclear" if family=="Head / Son / Daughter / Daughter"
replace typeoffamily="stem" if family=="Head / Son / Daughter-in-law / Daughter / Son / Grandchild"
replace typeoffamily="stem" if family=="Head / Son / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Son / Daughter-in-law / Son"
replace typeoffamily="joint-stem" if family=="Head / Son / Daughter-in-law / Son / Daughter-in-law / Son / Grandchild / Grandchild / Grandchild / Son / Daughter-in-law / Grandchild / Daughter"
replace typeoffamily="stem" if family=="Head / Son / Daughter-in-law / Son / Son"
replace typeoffamily="nuclear" if family=="Head / Son / Son"
replace typeoffamily="stem" if family=="Head / Son / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Son / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild / Daughter-in-law / Grandchild"
replace typeoffamily="nuclear" if family=="Head / Son / Son / Son"
replace typeoffamily="nuclear" if family=="Head / Son / Son / Son / Son"
replace typeoffamily="stem" if family=="Mother / Head / Daughter-in-law / Grandchild / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Son / Daughter-in-law / Grandchild / Grandchild / Head"
replace typeoffamily="stem" if family=="Son / Head / Son / Son / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Daughter / Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Daughter-in-law / Head / Wife / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Daughter-in-law / Head / Wife / Son / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace typeoffamily="nuclear" if family=="Daughter-in-law / Son / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Daughter-in-law / Son / Grandchild / Grandchild / Grandchild / Son / Head / Daughter"
replace typeoffamily="stem" if family=="Daughter-in-law / Son / Grandchild / Grandchild / Grandchild / Wife"
replace typeoffamily="stem" if family=="Daughter-in-law / Son / Grandchild / Grandchild / Son / Wife"
replace typeoffamily="stem" if family=="Daughter-in-law / Son / Head / Wife / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Father / Wife / Son / Daughter / Mother"
replace typeoffamily="stem" if family=="Father / Wife / Son / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Father / Wife / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Mother / Wife"
replace typeoffamily="stem" if family=="Head / Mother / Wife / Brother / Brother"
replace typeoffamily="stem" if family=="Head / Mother / Wife / Daughter"
replace typeoffamily="stem" if family=="Head / Other / Son / Daughter-in-law / Grandchild"
replace typeoffamily="nuclear" if family=="Head / Wife"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Daughter / Daughter / Son"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Daughter / Son"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Son"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Son / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Son / Daughter / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Daughter / Son / Father / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Daughter / Son / Mother"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Daughter / Son / Son"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Father / Mother"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Son"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Son / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Son / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Son / Daughter / Daughter / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Son / Father / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Son / Father-in-law / Mother-in-law"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Son / Mother"
replace typeoffamily="nuclear" if family=="Head / Wife / Daughter / Son / Son"
replace typeoffamily="stem" if family=="Head / Wife / Daughter / Son-in-law / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Father / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Head / Daughter-in-law / Grandchild / Grandchild / Grandchild / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Mother / Brother / Son / Son"
replace typeoffamily="stem" if family=="Head / Wife / Mother / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Wife / Mother / Son / Son / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Mother-in-law / Other / Daughter / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Wife / Sister / Mother"
replace typeoffamily="nuclear" if family=="Head / Wife / Son"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Daughter / Daughter / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Daughter / Son / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Father / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Mother"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter / Son / Daughter / Son / Son / Mother-in-law"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Daughter / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild / Grandchild / Grandchild / Daughter-in-law"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild / Son / Daughter-in-law / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Son"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Son / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Son / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Grandchild / Son / Daughter"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Son / Daughter / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Daughter-in-law / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Son / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Daughter-in-law / Son / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son / Father"
replace typeoffamily="stem" if family=="Head / Wife / Son / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Son / Mother / Brother"
replace typeoffamily="stem" if family=="Head / Wife / Son / Mother / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Brother / Other / Daughter / Other / Father / Mother"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son / Daughter / Daughter"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Daughter / Daughter / Daughter-in-law / Grandchild / Grandchild / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Daughter / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Daughter / Father"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Daughter / Mother"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Daughter / Mother / Brother / Cousin / Daughter-in-law / Daughter-in-law"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son / Daughter / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Daughter / Son / Father / Mother"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Daughter-in-law / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Daughter-in-law / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="joint-stem" if family=="Head / Wife / Son / Son / Daughter-in-law / Son / Daughter-in-law / Daughter-in-law / Grandchild / Grandchild / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Father"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Father / Mother"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Father / Sister"
replace typeoffamily="stem" if family=="Head / Wife / Son / Son / Mother"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son / Son"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son / Son / Daughter"
replace typeoffamily="nuclear" if family=="Head / Wife / Son / Son / Son / Son / Son"
replace typeoffamily="stem" if family=="Head / Wife / Son-in-law / Daughter / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Mother / Head / Wife"
replace typeoffamily="stem" if family=="Mother / Head / Wife / Daughter"
replace typeoffamily="stem" if family=="Mother / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Son / Daughter-in-law / Grandchild / Grandchild / Father / Mother / Brother / Other / Son / Son / Son"
replace typeoffamily="stem" if family=="Son / Daughter-in-law / Grandchild / Grandchild / Grandchild / Head / Wife"
replace typeoffamily="joint-stem" if family=="Son / Daughter-in-law / Grandchild / Grandchild / Grandchild / Head / Wife / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Son / Daughter-in-law / Grandchild / Grandchild / Head / Wife"
replace typeoffamily="stem" if family=="Son / Daughter-in-law / Grandchild / Grandchild / Head / Wife / Son"
replace typeoffamily="stem" if family=="Son / Daughter-in-law / Grandchild / Grandchild / Son / Son / Son / Head / Wife"
replace typeoffamily="stem" if family=="Son / Daughter-in-law / Grandchild / Head / Wife"
replace typeoffamily="stem" if family=="Son / Daughter-in-law / Grandchild / Head / Wife / Son"
replace typeoffamily="stem" if family=="Son / Daughter-in-law / Head / Wife"
replace typeoffamily="joint-stem" if family=="Son / Daughter-in-law / Head / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Son / Daughter-in-law / Grandchild"
replace typeoffamily="joint-stem" if family=="Son / Daughter-in-law / Mother / Daughter / Son / Brother / Other / Other / Other / Other / Brother"
replace typeoffamily="nuclear" if family=="Son / Head / Wife / Son"
replace typeoffamily="nuclear" if family=="Son / Head / Wife / Son / Daughter"
replace typeoffamily="joint-stem" if family=="Son-in-law / Daughter / Grandchild / Grandchild / Daughter-in-law / Son / Grandchild / Grandchild / Grandchild / Head / Wife / Son"
replace typeoffamily="nuclear" if family=="Wife"
replace typeoffamily="nuclear" if family=="Wife / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Wife / Head"
replace typeoffamily="nuclear" if family=="Wife / Head / Daughter"
replace typeoffamily="nuclear" if family=="Wife / Head / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Wife / Head / Daughter / Daughter / Daughter"
replace typeoffamily="nuclear" if family=="Wife / Head / Daughter / Daughter / Daughter / Son"
replace typeoffamily="stem" if family=="Wife / Head / Daughter / Daughter / Daughter / Son / Mother"
replace typeoffamily="stem" if family=="Wife / Head / Daughter / Daughter / Mother-in-law"
replace typeoffamily="nuclear" if family=="Wife / Head / Daughter / Daughter / Son"
replace typeoffamily="nuclear" if family=="Wife / Head / Daughter / Daughter / Son / Son"
replace typeoffamily="stem" if family=="Wife / Head / Daughter / Daughter / Son / Son / Mother"
replace typeoffamily="joint-stem" if family=="Wife / Head / Daughter / Daughter-in-law / Daughter-in-law / Son"
replace typeoffamily="nuclear" if family=="Wife / Head / Daughter / Son"
replace typeoffamily="nuclear" if family=="Wife / Head / Daughter / Son / Daughter"
replace typeoffamily="stem" if family=="Wife / Head / Daughter / Son / Daughter / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Wife / Head / Daughter / Son / Daughter / Mother"
replace typeoffamily="stem" if family=="Wife / Head / Daughter / Son / Father / Mother"
replace typeoffamily="stem" if family=="Wife / Head / Daughter / Son / Father-in-law"
replace typeoffamily="nuclear" if family=="Wife / Head / Daughter / Son / Son"
replace typeoffamily="stem" if family=="Wife / Head / Daughter-in-law / Grandchild / Grandchild / Son"
replace typeoffamily="stem" if family=="Wife / Head / Mother-in-law"
replace typeoffamily="nuclear" if family=="Wife / Head / Son"
replace typeoffamily="nuclear" if family=="Wife / Head / Son / Daughter"
replace typeoffamily="nuclear" if family=="Wife / Head / Son / Daughter / Daughter"
replace typeoffamily="stem" if family=="Wife / Head / Son / Daughter / Other / Mother-in-law"
replace typeoffamily="nuclear" if family=="Wife / Head / Son / Daughter / Son"
replace typeoffamily="stem" if family=="Wife / Head / Son / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Wife / Head / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Wife / Head / Son / Daughter-in-law / Grandchild / Son / Son"
replace typeoffamily="stem" if family=="Wife / Head / Son / Daughter-in-law / Son / Grandchild / Grandchild"
replace typeoffamily="nuclear" if family=="Wife / Head / Son / Son"
replace typeoffamily="nuclear" if family=="Wife / Head / Son / Son / Daughter"
replace typeoffamily="joint-stem" if family=="Wife / Head / Son / Son / Daughter-in-law / Daughter-in-law / Son / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Wife / Head / Son / Son / Daughter-in-law / Grandchild"
replace typeoffamily="stem" if family=="Wife / Head / Son / Son / Father / Mother"
replace typeoffamily="stem" if family=="Wife / Head / Son / Son / Mother-in-law"
replace typeoffamily="nuclear" if family=="Wife / Head / Son / Son / Son"
replace typeoffamily="stem" if family=="Wife / Head / Son / Son / Son / Daughter-in-law / Grandchild / Grandchild"
replace typeoffamily="stem" if family=="Wife / Head / Son / Son / Son / Mother"
replace typeoffamily="nuclear" if family=="Wife / Son"
replace typeoffamily="joint-stem" if family=="Wife / Son / Daughter-in-law / Grandchild / Son / Daughter-in-law / Grandchild / Grandchild"


*** Pb
ta typeoffamily
gen pb=0

replace pb=1 if family=="Son / Daughter-in-law / Grandchild / Grandchild"
replace pb=1 if family=="Head / Son / Daughter-in-law / Grandchild / Cousin"
replace pb=1 if family=="Mother / Head"
replace pb=1 if family=="Mother / Head / Brother"
replace pb=1 if family=="Mother / Head / Sister"
replace pb=1 if family=="Head / Wife / Son / Son / Daughter / Daughter / Son / Wife"
replace pb=1 if family=="Head / Wife / Son / Wife"
replace pb=1 if family=="Head / Wife / Wife"
replace pb=1 if family=="Head / Wife / Wife / Daughter / Son / Daughter"
replace pb=1 if family=="Head / Wife / Wife / Son"
replace pb=1 if family=="Head / Wife / Wife / Son / Daughter-in-law / Grandchild / Grandchild / Grandchild"
replace pb=1 if family=="Wife / Head / Son / Daughter / Wife / Daughter / Daughter"
replace pb=1 if family=="Head / Wife / Brother"
replace pb=1 if family=="Father / Mother / Head / Brother / Sister"
replace pb=1 if family=="Head / Father / Mother / Wife / Brother / Daughter / Son / Son / Son"
replace pb=1 if family=="Head / Wife / Son / Son / Son / Other / Other / Other / Mother"
replace pb=1 if family=="Wife / Head / Son-in-law / Son-in-law"



sort HHID2016
order HHID2016 family
*br if pb==1

replace pb=. if HHID2016=="uuid:0a07e84c-5259-49c3-9e27-826a6e2869b9"

replace typeoffamily="nuclear" if HHID2016=="uuid:0da4d673-37df-4750-a325-e3dc56201480"
replace pb=. if HHID2016=="uuid:0da4d673-37df-4750-a325-e3dc56201480"

replace pb=. if HHID2016=="uuid:187e2011-c2fe-469f-b09d-18a76a4f02a9"

replace typeoffamily="stem" if HHID2016=="uuid:1d812573-8be9-4a1c-948e-1ee90f9ed6e3"
replace pb=. if HHID2016=="uuid:1d812573-8be9-4a1c-948e-1ee90f9ed6e3"

replace pb=. if HHID2016=="uuid:38c74b3e-f359-4015-bffb-b4b5bb0f166d"

replace typeoffamily="nuclear" if HHID2016=="uuid:4a71a117-e7af-4f8d-875d-5a3af05b5694"
replace pb=. if HHID2016=="uuid:4a71a117-e7af-4f8d-875d-5a3af05b5694"

replace pb=. if HHID2016=="uuid:62ad7210-2d2c-4e4d-a8c6-6501a63d2fee"

replace typeoffamily="nuclear" if HHID2016=="uuid:7dff3ca3-e693-4df2-a2bd-a60549a1cae7"
replace pb=. if HHID2016=="uuid:7dff3ca3-e693-4df2-a2bd-a60549a1cae7"

replace pb=. if HHID2016=="uuid:8ebeda34-43ae-4a2c-a133-b955a3ad90da"

replace typeoffamily="nuclear" if HHID2016=="uuid:9a6b611c-4ef6-4fc2-872d-6c25bd2f5406"
replace pb=. if HHID2016=="uuid:9a6b611c-4ef6-4fc2-872d-6c25bd2f5406"

replace pb=. if HHID2016=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185"

replace pb=. if HHID2016=="uuid:a83605b5-7618-41a2-b2b7-0838fe3503da"

replace pb=. if HHID2016=="uuid:d4d18676-ba2d-43fd-8ae2-a5b8c626e3c9"

replace pb=. if HHID2016=="uuid:da893017-2541-42dc-9dab-d517d777b92b"

replace pb=. if HHID2016=="uuid:ee73e76e-b047-4e85-85fd-b3acc589d1b8"

replace pb=. if HHID2016=="uuid:efeede8c-d7d5-472e-a7a1-b69a79b15bc1"

replace typeoffamily="nuclear" if HHID2016=="uuid:f83761be-3362-4e71-b65b-5d72e3f1a014"
replace pb=. if HHID2016=="uuid:f83761be-3362-4e71-b65b-5d72e3f1a014"

drop pb

keep HHID2016 family typeoffamily
ta typeoffamily

save"_temp\NEEMSIS1-family2", replace
****************************************
* END









****************************************
* Type of family p2
****************************************
use"$data", clear

*** To keep
keep HHID2016 INDID2016 name age sex relationshiptohead livinghome maritalstatus
fre livinghome
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
rename relation_14 relation_cousin
rename relation_15 relation_other


*** Merge type of family to count
merge m:1 HHID2016 using "_temp/NEEMSIS1-family2"
drop _merge


*** How many per gen?
foreach x in relation_head relation_wife relation_mother relation_father relation_son relation_daughter relation_soninlaw relation_daughterinlaw relation_sister relation_brother relation_motherinlaw relation_fatherinlaw relation_grandchildren relation_cousin {
bysort HHID2016: egen _temp`x'=sum(`x')
drop `x'
rename _temp`x' `x'
}



gen nbgeneration1=relation_grandchildren
egen nbgeneration2=rowtotal(relation_son relation_daughter relation_daughterinlaw relation_soninlaw)
egen nbgeneration3=rowtotal(relation_head relation_wife relation_sister relation_brother)
egen nbgeneration4=rowtotal(relation_mother relation_father relation_motherinlaw relation_fatherinlaw)


*** How many gen?
forvalues i=1/4 {
gen dummygeneration`i'=0
}

forvalues i=1/4 {
replace dummygeneration`i'=1 if nbgeneration`i'!=0
}

egen nbgeneration=rowtotal(dummygeneration1 dummygeneration2 dummygeneration3 dummygeneration4)


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
bysort HHID2016: egen nbwife=sum(femalewife)
drop femalewife
gen dummypolygamous=0
replace dummypolygamous=1 if nbwife!=1 & nbwife!=0 & nbwife!=. 
drop nbwife



*** Keep
keep HHID2016 family typeoffamily nbgeneration* dummygeneration* nbgeneration waystem dummypolygamous
duplicates drop

ta waystem typeoffamily, m

ta dummypolygamous

list family typeoffamily if dummypolygamous==1, clean noobs

drop family typeoffamily

save"_temp\NEEMSIS1-family3", replace
****************************************
* END















****************************************
* Head characteristics
****************************************
use"$data", clear

*** To keep
keep HHID2016 INDID2016 name age sex relationshiptohead livinghome maritalstatus egoid
fre livinghome
drop if livinghome==3
drop if livinghome==4
drop livinghome
gen pb=0

*** Identified duplicates
preserve
keep if relationshiptohead==1
duplicates tag HHID2016, gen(tag)
ta tag
sort HHID2016
*br HHID2016 INDID2016 name age sex relationshiptohead maritalstatus if tag!=0
restore

replace relationshiptohead=. if HHID2016=="uuid:7f621167-4489-4883-9d0e-280295593d49" & INDID2016==3
replace pb=1 if HHID2016=="uuid:7f621167-4489-4883-9d0e-280295593d49" & INDID2016==3

replace relationshiptohead=. if HHID2016=="uuid:c382b100-2ae2-49a5-a5a0-be7b48fe4e42" & INDID2016==3
replace pb=1 if HHID2016=="uuid:c382b100-2ae2-49a5-a5a0-be7b48fe4e42" & INDID2016==3


*** Identified HH without Head
gen head=0
replace head=1 if relationshiptohead==1
bysort HHID2016: egen head_HH=sum(head)
ta head_HH
recode head_HH (0=1) (1=0)
rename head_HH nohead
ta nohead
drop head

sort HHID2016 INDID2016
*br HHID2016 INDID2016 name age sex egoid relationshiptohead maritalstatus if nohead==1

replace relationshiptohead=1 if HHID2016=="uuid:2c8da432-1be7-4879-b570-dbab81b136ab" & INDID2016==1
replace pb=1 if HHID2016=="uuid:2c8da432-1be7-4879-b570-dbab81b136ab"

replace relationshiptohead=1 if HHID2016=="uuid:4a0b0674-3095-4b92-ab46-2daba0d5414e" & INDID2016==1
replace pb=1 if HHID2016=="uuid:4a0b0674-3095-4b92-ab46-2daba0d5414e"

replace relationshiptohead=1 if HHID2016=="uuid:6058c905-3f35-461f-b0f0-bbcb46308627" & INDID2016==2
replace pb=1 if HHID2016=="uuid:6058c905-3f35-461f-b0f0-bbcb46308627"

replace relationshiptohead=1 if HHID2016=="uuid:61eebc2f-dbcf-4c8d-b1c1-db47af15e320" & INDID2016==2
replace pb=1 if HHID2016=="uuid:61eebc2f-dbcf-4c8d-b1c1-db47af15e320"

replace relationshiptohead=1 if HHID2016=="uuid:676c5651-8aaf-410e-871e-808961fccc69" & INDID2016==1
replace pb=1 if HHID2016=="uuid:676c5651-8aaf-410e-871e-808961fccc69"

replace relationshiptohead=1 if HHID2016=="uuid:7d58fca3-952b-44b7-93a4-b4a30e7b5b95" & INDID2016==2
replace pb=1 if HHID2016=="uuid:7d58fca3-952b-44b7-93a4-b4a30e7b5b95"

replace relationshiptohead=1 if HHID2016=="uuid:8c7e529f-bbc0-4977-b2d6-b2b91addd9e0" & INDID2016==1
replace pb=1 if HHID2016=="uuid:8c7e529f-bbc0-4977-b2d6-b2b91addd9e0"

replace relationshiptohead=1 if HHID2016=="uuid:96becde9-a23f-4f80-a5d0-7adf5ef61a67" & INDID2016==1
replace pb=1 if HHID2016=="uuid:96becde9-a23f-4f80-a5d0-7adf5ef61a67"

replace relationshiptohead=1 if HHID2016=="uuid:9f14556f-8aa4-42d1-a8e8-d82f3d40e3d3" & INDID2016==1
replace pb=1 if HHID2016=="uuid:9f14556f-8aa4-42d1-a8e8-d82f3d40e3d3"

replace relationshiptohead=1 if HHID2016=="uuid:a80735af-38ec-4daa-aca0-4c87c64ea92f" & INDID2016==1
replace p=1 if HHID2016=="uuid:a80735af-38ec-4daa-aca0-4c87c64ea92f"

replace relationshiptohead=1 if HHID2016=="uuid:cc0b53f3-6988-455d-bf5b-7d57ef36521b" & INDID2016==3
replace pb=1 if HHID2016=="uuid:cc0b53f3-6988-455d-bf5b-7d57ef36521b"

replace relationshiptohead=1 if HHID2016=="uuid:da893017-2541-42dc-9dab-d517d777b92b" & INDID2016==1
replace pb=1 if HHID2016=="uuid:da893017-2541-42dc-9dab-d517d777b92b"

replace relationshiptohead=1 if HHID2016=="uuid:ddf8a47d-0f8e-494f-93d4-1e54a0794f71" & INDID2016==2
replace pb=1 if HHID2016=="uuid:ddf8a47d-0f8e-494f-93d4-1e54a0794f71"

replace relationshiptohead=1 if HHID2016=="uuid:ea71f70c-adac-4154-9cfd-36595ce10a6d" & INDID2016==1
replace pb=1 if HHID2016=="uuid:ea71f70c-adac-4154-9cfd-36595ce10a6d"

replace relationshiptohead=1 if HHID2016=="uuid:f7acfeb9-ee27-4196-8d54-a0b41ee17abe" & INDID2016==1
replace pb=1 if HHID2016=="uuid:f7acfeb9-ee27-4196-8d54-a0b41ee17abe"

replace relationshiptohead=1 if HHID2016=="uuid:feea6473-a217-4abf-8a1c-e1dc7cd6b43d" & INDID2016==1
replace pb=1 if HHID2016=="uuid:feea6473-a217-4abf-8a1c-e1dc7cd6b43d"


*** Keep head
keep if relationshiptohead==1
duplicates report HHID2016

keep HHID2016 INDID2016 name age sex relationshiptohead maritalstatus egoid
gen dummyhead=1



*** Add occupation
merge 1:1 HHID2016 INDID2016 using "outcomes/NEEMSIS1-occup_indiv", keepusing(dummyworkedpastyear working_pop mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv)
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
merge 1:1 HHID2016 INDID2016 using "outcomes/NEEMSIS1-education"
drop if _merge==2
drop _merge


*** Rename
foreach x in INDID2016 name sex relationshiptohead age dummyhead dummyworkedpastyear working_pop mocc_profession mocc_occupation mocc_sector mocc_annualincome mocc_occupationname annualincome nboccupation edulevel egoid maritalstatus {
rename `x' head_`x'
}

save"_temp\NEEMSIS1-head", replace
****************************************
* END











****************************************
* Merge all
****************************************
use"$data", clear

keep HHID2016
duplicates drop

merge 1:1 HHID2016 using "_temp\NEEMSIS1-family1"
drop _merge

merge 1:1 HHID2016 using "_temp\NEEMSIS1-family2"
drop _merge

merge 1:1 HHID2016 using "_temp\NEEMSIS1-family3"
drop _merge

merge 1:1 HHID2016 using "_temp\NEEMSIS1-head"
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




save"outcomes\NEEMSIS1-family", replace
****************************************
* END
