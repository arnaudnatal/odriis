cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
November 12, 2021
-----
Prepa GRAAL
-----

-------------------------
*/






****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
********** Path to folder "data" folder.
*global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*cd "$directory\CLEAN"

global git "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\_Miscellaneous\Individual_panel"

global rume "C:\Users\Arnaud\Documents\_Thesis\_DATA\RUME"
global neemsis1 "C:\Users\Arnaud\Documents\_Thesis\_DATA\NEEMSIS1"
global neemsis2 "C:\Users\Arnaud\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND\CLEAN\LAST"
global tracking1 "C:\Users\Arnaud\Documents\_Thesis\_DATA\Tracking2019\DATA"

global data "C:\Users\Arnaud\Documents\_Thesis\_DATA"
****************************************
* END








****************************************
* PICK-UP ALL basic details
****************************************
/*
/!\ The question of the order is important
The first best option is to do in chronological
order.
But, before cleaning tracking 1, I can NEEMSIS-2 data
So, the order for HHID_panel and INDID_panel is:
RUME
NEEMSIS1
NEEMSIS2
Tracking1
...
Tracking2
NEEMSIS3

From "..." we need to continue in the right order

*/
********** RUME
use"$data\RUME-HH.dta", clear
keep HHID_panel INDID_panel HHID2010 INDID2010 name age sex relationshiptohead jatis caste address villageid

* All string
tostring *, replace
desc

* Decode
foreach x in relationshiptohead jatis caste {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}
desc

* Replace
replace sex="Male" if sex=="1"
replace sex="Female" if sex=="2"

replace villageid="ELA" if villageid=="1"
replace villageid="GOV" if villageid=="2"
replace villageid="KAR" if villageid=="3"
replace villageid="KOR" if villageid=="4"
replace villageid="KUV" if villageid=="5"
replace villageid="MAN" if villageid=="6"
replace villageid="MANAM" if villageid=="7"
replace villageid="NAT" if villageid=="8"
replace villageid="ORA" if villageid=="9"
replace villageid="SEM" if villageid=="10"

* Wave, year and submissiondate
gen wave="RUME"
gen year="2010"
gen submissionyear="2010" 

* Order
order HHID_panel INDID_panel HHID2010 INDID2010 wave year submissionyear name age sex relationshiptohead jatis caste address villageid
compress

foreach x in * {
rename `x' `x'_2010
}

foreach x in HHID_panel INDID_panel HHID2010 INDID2010 {
rename `x'_2010 `x'
}

save"$git\RUME-HH_indiv.dta", replace



********** NEEMSIS1
use"$data\NEEMSIS1-HH.dta", clear

rename INDID INDID2016
keep HHID_panel INDID_panel HHID2016 INDID2016 name age sex relationshiptohead jatis caste address villageid submissiondate

* All string
tostring *, replace
desc

* Decode
foreach x in sex villageid relationshiptohead jatis caste {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}
desc

* Wave, year and submissiondate
gen wave="NEEMSIS-1"
gen year="2016-17"

gen submissiondate_new=dofc(submissiondate)
drop submissiondate
rename submissiondate_new submissiondate
format submissiondate %td
generate submissionyear=year(submissiondate)
drop submissiondate
tostring submissionyear, replace
desc

* Order
order HHID_panel INDID_panel HHID2016 INDID2016 wave year submissionyear name age sex relationshiptohead jatis caste address villageid
compress

foreach x in * {
rename `x' `x'_2016
}

foreach x in HHID_panel INDID_panel HHID2016 INDID2016 {
rename `x'_2016 `x'
}


save"$git\NEEMSIS1-HH_indiv.dta", replace




********** NEEMSIS2
use"$data\NEEMSIS2-HH.dta", clear

keep HHID_panel INDID_panel parent_key INDID2020 name age sex relationshiptohead relationshiptoheadother jatis caste address villageid submissiondate INDID_left householdidparent householdid2020
rename parent_key HHID2020

* All string
tostring *, replace
desc

* Decode
foreach x in sex villageid relationshiptohead jatis caste {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}
desc
replace relationshiptohead="Other" if relationshiptohead=="" & INDID_left=="."

* Dummyleft
gen dummyleft="No"
replace dummyleft="Yes" if INDID_left!="."
drop INDID_left

* Wave, year and submissiondate
gen wave="NEEMSIS-2"
gen year="2020-21"

gen submissiondate_new=dofc(submissiondate)
drop submissiondate
rename submissiondate_new submissiondate
format submissiondate %td
generate submissionyear=year(submissiondate)
drop submissiondate
tostring submissionyear, replace
desc

* Order
order HHID_panel INDID_panel HHID2020 INDID2020 wave year submissionyear name age sex relationshiptohead relationshiptoheadother dummyleft jatis caste address villageid
compress

foreach x in * {
rename `x' `x'_2020
}

foreach x in HHID_panel INDID_panel HHID2020 INDID2020 {
rename `x'_2020 `x'
}


save"$git\NEEMSIS2-HH_indiv.dta", replace




********** Tracking 1
use"$tracking1\NEEMSIS-tracking_comp_v4.dta", clear
keep HHID_panel INDID_panel name sex age HHID2010 INDID2019 key relationshiptohead migrationaddress villageid namemigrant caste casteother

* Cleaning
rename key HHID2019
rename migrationaddress address

rename caste jatis
rename casteother jatisother

* All string
tostring *, replace
desc

* Decode
foreach x in sex relationshiptohead jatis {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}
desc

* Clean
replace jatis=jatisother if jatis=="Other"
drop jatisother

* Wave, year and submissiondate
gen wave="Tracking-1"
gen year="2019"
gen submissionyear="2019"


* Villageid from address
sort HHID_panel INDID_panel
tab address 
gen villageid=""



* Order
order HHID_panel INDID_panel HHID2019 HHID2019other HHID2010 namemigrant INDID2019 wave year submissionyear name age sex relationshiptohead jatis address villageid
compress
drop code

save"$git\Tracking1-HH_indiv.dta", replace
****************************************
* END






****************************************
* APPEND ALL DATASETS
****************************************
use"$git\RUME-HH_indiv.dta", clear

merge 1:1 HHID_panel INDID_panel using "$git\NEEMSIS1-HH_indiv.dta"
drop _merge

merge 1:1 HHID_panel INDID_panel using "$git\NEEMSIS2-HH_indiv.dta"
drop _merge

order HHID_panel INDID_panel wave_2010 wave_2016 wave_2020
fre wave_2010 wave_2016 wave_2020

* Indiv
gen indivpanel_10_16_20="No"
replace indivpanel_10_16_20="Yes" if wave_2010=="RUME" & wave_2016=="NEEMSIS-1" & wave_2020=="NEEMSIS-2"
save"$git\ODRIIS-indiv.dta", replace

* HH
/*
preserve
duplicates drop HHID_panel, force
gen hhpanel_10_16_20="No"
replace hhpanel_10_16_20="Yes" if wave_2010=="RUME" & wave_2016=="NEEMSIS-1" & wave_2020=="NEEMSIS-2"
drop name_2010 age_2010 sex_2010 relationshiptohead_2010 name_2016 age_2016 sex_2016 relationshiptohead_2016 name_2020 age_2020 sex_2020 relationshiptohead_2020 relationshiptoheadother_2020 dummyleft_2020 indivpanel_10_16_20
save"$git\ODRIIS-HH.dta", replace
restore
*/
*save"$git\ODRIIS-HH_indiv.dta", replace
****************************************
* END







****************************************
* APPEND ALL DATASETS
****************************************
use"$git\ODRIIS-indiv.dta", clear
/*
foreach i in 2010 2016 2020 {
gen pb1_`i'=0
}

foreach i in 2010 2016 2020 {
replace pb1_`i'=1 if sex_`i'=="Female" & relationshiptohead_`i'=="Brother"
replace pb1_`i'=1 if sex_`i'=="Male" & relationshiptohead_`i'=="Daughter"
replace pb1_`i'=1 if sex_`i'=="Male" & relationshiptohead_`i'=="Daughter-in-law"
replace pb1_`i'=1 if sex_`i'=="Female" & relationshiptohead_`i'=="Father"
replace pb1_`i'=1 if sex_`i'=="Female" & relationshiptohead_`i'=="Father-in-law"
replace pb1_`i'=1 if sex_`i'=="Male" & relationshiptohead_`i'=="Grandmother"
replace pb1_`i'=1 if sex_`i'=="Male" & relationshiptohead_`i'=="Mother"
replace pb1_`i'=1 if sex_`i'=="Male" & relationshiptohead_`i'=="Mother-in-law"
replace pb1_`i'=1 if sex_`i'=="Male" & relationshiptohead_`i'=="Sister"
replace pb1_`i'=1 if sex_`i'=="Female" & relationshiptohead_`i'=="Son"
replace pb1_`i'=1 if sex_`i'=="Female" & relationshiptohead_`i'=="Son-in-law"
}


********** Coherence sex relationship
*** 2010
ta pb1_2010
ta relationshiptohead_2010 sex_2010

*** 2016-17
ta pb1_2016
ta relationshiptohead_2016 sex_2016
ta relationshiptohead_2016 sex_2016 if pb1_2016==1
list HHID_panel INDID_panel name_2010 sex_2010 relationshiptohead_2010 name_2016 sex_2016 relationshiptohead_2016 name_2020 sex_2020 relationshiptohead_2020 if pb1_2016==1, clean noobs


replace relationshiptohead="Son" if HHID_panel=="KAR18" & INDID_panel=="Ind_3"
replace relationshiptohead="Son" if HHID_panel=="KAR39" & INDID_panel=="Ind_4"
replace relationshiptohead="Daughter" if HHID_panel=="KAR8" & INDID_panel=="Ind_5"  // 2020 aussi
replace relationshiptohead="Son" if HHID_panel=="KOR30" & INDID_panel=="Ind_5"
replace relationshiptohead="Head" if HHID_panel=="KUV20" & INDID_panel=="Ind_1"
replace relationshiptohead="Son" if HHID_panel=="ORA36" & INDID_panel=="Ind_4"
replace relationshiptohead="Son" if HHID_panel=="ORA42" & INDID_panel=="Ind_3"

replace sex="Female" if HHID_panel=="KAR45" & INDID_panel=="Ind_6"  // 2020 aussi
replace sex="Male" if HHID_panel=="NAT27" & INDID_panel=="Ind_3"  // 2020 aussi
replace sex="Male" if HHID_panel=="KAR49" & INDID_panel=="Ind_8"  // 2020 aussi
replace sex="Male" if HHID_panel=="ELA13" & INDID_panel=="Ind_5"  // 2020 aussi
replace sex="Female" if HHID_panel=="MANAM50" & INDID_panel=="Ind_6"  // 2020 aussi
replace sex="Male" if HHID_panel=="NAT42" & INDID_panel=="Ind_4"  // 2020 aussi
replace sex="Male" if HHID_panel=="ORA13" & INDID_panel=="Ind_2"
replace sex="Female" if HHID_panel=="ORA26" & INDID_panel=="Ind_9"  // 2020 aussi




*** 2020-21
ta pb1_2020
ta relationshiptohead_2020 sex_2020
ta relationshiptohead_2020 sex_2020 if pb1_2016==1
list HHID_panel INDID_panel name_2010 sex_2010 relationshiptohead_2010 name_2016 sex_2016 relationshiptohead_2016 name_2020 sex_2020 relationshiptohead_2020 if pb1_2020==1, clean noobs

gen pb=0
replace pb=1 if HHID_panel=="ELA25" & INDID_panel=="Ind_4"  // Arthijara
replace pb=1 if HHID_panel=="MANAM17" & INDID_panel=="Ind_3"  // male son - female daughter - female son * barahti
replace pb=1 if HHID_panel=="SEM28" & INDID_panel=="Ind_1"  // head head daughter
replace pb=1 if HHID_panel=="SEM46" & INDID_panel=="Ind_1"  // head head daughter



replace relationshiptohead="Daughter" if HHID_panel=="KAR8" & INDID_panel=="Ind_5"  // 2020 aussi
replace relationshiptohead="Daughter" if HHID_panel=="ELA9" & INDID_panel=="Ind_3"
replace relationshiptohead="Daughter" if HHID_panel=="GOV17" & INDID_panel=="Ind_8"
replace relationshiptohead="Daughter" if HHID_panel=="GOV51" & INDID_panel=="Ind_4"
replace relationshiptohead="Daughter-in-law" if HHID_panel=="KAR14" & INDID_panel=="Ind_5"
replace relationshiptohead="Daughter" if HHID_panel=="KOR18" & INDID_panel=="Ind_5"
replace relationshiptohead="Daughter" if HHID_panel=="KOR24" & INDID_panel=="Ind_6"
replace relationshiptohead="Son" if HHID_panel=="KOR24" & INDID_panel=="Ind_7"
replace relationshiptohead="Daughter" if HHID_panel=="KOR36" & INDID_panel=="Ind_3"
replace relationshiptohead="Daughter" if HHID_panel=="KOR44" & INDID_panel=="Ind_4"
replace relationshiptohead="Mother-in-law" if HHID_panel=="KUV12" & INDID_panel=="Ind_6"
replace relationshiptohead="Daughter" if HHID_panel=="KUV19" & INDID_panel=="Ind_3"
replace relationshiptohead="Daughter" if HHID_panel=="KUV24" & INDID_panel=="Ind_4"
replace relationshiptohead="Daughter" if HHID_panel=="KUV24" & INDID_panel=="Ind_5"
replace relationshiptohead="Daughter" if HHID_panel=="KUV35" & INDID_panel=="Ind_5"
replace relationshiptohead="Son" if HHID_panel=="KUV44" & INDID_panel=="Ind_3"
replace relationshiptohead="Daughter" if HHID_panel=="KUV6" & INDID_panel=="Ind_3"
replace relationshiptohead="Son" if HHID_panel=="KUV7" & INDID_panel=="Ind_3"
replace relationshiptohead="Daughter" if HHID_panel=="MAN31" & INDID_panel=="Ind_4"
replace relationshiptohead="Daughter" if HHID_panel=="MAN48" & INDID_panel=="Ind_5"
replace relationshiptohead="Grandchild" if HHID_panel=="MANAM15" & INDID_panel=="Ind_5"
replace relationshiptohead="Grandchild" if HHID_panel=="MANAM15" & INDID_panel=="Ind_6"
replace relationshiptohead="Daughter" if HHID_panel=="MANAM22" & INDID_panel=="Ind_3"
replace relationshiptohead="Daughter" if HHID_panel=="NAT11" & INDID_panel=="Ind_4"
replace relationshiptohead="Daughter" if HHID_panel=="ORA30" & INDID_panel=="Ind_3"
replace relationshiptohead="Son" if HHID_panel=="ORA30" & INDID_panel=="Ind_5"
replace relationshiptohead="Son" if HHID_panel=="ORA39" & INDID_panel=="Ind_5"
replace relationshiptohead="Daughter" if HHID_panel=="ORA43" & INDID_panel=="Ind_6"
replace relationshiptohead="Daughter-in-law" if HHID_panel=="SEM14" & INDID_panel=="Ind_2"
replace relationshiptohead="Son" if HHID_panel=="SEM15" & INDID_panel=="Ind_4"



replace sex="Male" if HHID_panel=="GOV33" & INDID_panel=="Ind_3"  // vérifier quand même car chelou son - head - son ?

replace sex="Male" if HHID_panel=="NAT27" & INDID_panel=="Ind_3"  // 2020 aussi
replace sex="Male" if HHID_panel=="KAR49" & INDID_panel=="Ind_8"  // 2020 aussi
replace sex="Male" if HHID_panel=="ELA13" & INDID_panel=="Ind_5"  // 2020 aussi
replace sex="Male" if HHID_panel=="NAT42" & INDID_panel=="Ind_4"  // 2020 aussi
replace sex="Male" if HHID_panel=="MAN56" & INDID_panel=="Ind_4"
replace sex="Male" if HHID_panel=="KAR56" & INDID_panel=="Ind_3"


replace sex="Female" if HHID_panel=="MANAM50" & INDID_panel=="Ind_6"  // 2020 aussi
replace sex="Female" if HHID_panel=="ORA26" & INDID_panel=="Ind_9"  // 2020 aussi
replace sex="Female" if HHID_panel=="KAR45" & INDID_panel=="Ind_6"  // 2020 aussi
replace sex="Female" if HHID_panel=="NAT57" & INDID_panel=="Ind_1"
replace sex="Female" if HHID_panel=="ORA67" & INDID_panel=="Ind_4"
replace sex="Female" if HHID_panel=="KAR61" & INDID_panel=="Ind_3"
*/
****************************************
* END












****************************************
* APPEND ALL DATASETS
****************************************
use"$git\ODRIIS-indiv.dta", clear


order HHID_panel INDID_panel INDID2010 INDID2016 INDID2020 name_2010 age_2010 sex_2010 relationshiptohead_2010 name_2016 age_2016 sex_2016 relationshiptohead_2016 name_2020 age_2020 sex_2020 relationshiptohead_2020

sort HHID_panel INDID_panel
gen n=_n

preserve
drop if n>950
export excel "C:\Users\Arnaud\Downloads\ODRIIS_indiv-Mary-950" , firstrow(variables) replace
restore

preserve
drop if n<=950
drop if n>1900
export excel "C:\Users\Arnaud\Downloads\ODRIIS_indiv-Gaston-1900" , firstrow(variables) replace
restore

preserve
drop if n<=1900
*ok pour la suite


****************************************
* END
