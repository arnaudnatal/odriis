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

global rume "D:\Documents\_Thesis\_DATA\RUME"
global neemsis1 "D:\Documents\_Thesis\_DATA\NEEMSIS1"
global neemsis2 "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND\CLEAN\LAST"
global tracking1 "D:\Documents\_Thesis\_DATA\Tracking2019\DATA"


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
use"$rume\RUME-HH_v8.dta", clear
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

save"$git\RUME-HH_indiv.dta", replace



********** NEEMSIS1
use"$neemsis1\NEEMSIS1-HH_v9.dta", clear
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

save"$git\NEEMSIS1-HH_indiv.dta", replace




********** NEEMSIS2
use"$neemsis2\NEEMSIS2-HH_v21.dta", clear

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

append using "$git\NEEMSIS1-HH_indiv.dta"
append using "$git\NEEMSIS2-HH_indiv.dta"
append using "$git\Tracking1-HH_indiv.dta"

order HHID_panel INDID_panel HHID2010 HHID2016 HHID2020 HHID2019

save"$git\ODRIIS-HH_indiv.dta", replace
****************************************
* END

