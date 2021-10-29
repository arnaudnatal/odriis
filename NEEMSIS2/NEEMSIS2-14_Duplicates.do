cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
October 29, 2021
-----
TITLE: Duplicates
-------------------------
*/

clear all
macro drop _all
cls
********** Path to folder "data" folder.
*global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directorybis = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA"
cd"$directory"
clear all












****************************************
* Cleaning for empty parent_key and duplicates one
****************************************
*
clear all
filelist, dir("$directory\CLEAN") pattern(*.dta)
gen agri=0
replace agri=1 if strpos(filename,"Agriculture")
sort agri dirname filename
egen file=concat(dirname filename),p(\)
drop filename

preserve
keep if agri==0
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = file
	use "`f'", clear
	capture confirm v parent_key
	if !_rc {
	drop if parent_key==""
	***** Duplicates
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"  // householdid==36 & name1=="Natesan"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"  // householdid==67 & name1=="Shankar"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"  // householdid==124 & name1=="Subramani"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"  // householdid==246 & name1=="Sornambal"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"  // householdid==343 & name1=="Ramamoorthi"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"  // householdid==348 & name1=="Govindan"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"  // householdid==361 & name1=="Mallika"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"  // householdid==391 & name1=="Balaji"
	*
	drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"  // householdid==532 & name1=="Shakthivel" & name2=="Revathy"
	drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"  // householdid==534 & name1=="Karunanidhi"
	drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"  // householdid==547 & name1=="Surya" (duplicates with "uuid:ae72a34f-f968-45f4-acfa-91f571f54ea8")
	}
	capture confirm v forauto
	if !_rc {
	drop forauto
	}
	save "`f'", replace	
	tempfile save`i'
}
restore


preserve
keep if agri==1
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = file
	use "`f'", clear
	capture confirm v parent_key
	if !_rc {
	drop if parent_key==""
	***** Duplicates
	drop if parent_key=="uuid:244d058e-b68a-4271-bf5f-5332dca88f8f"  // householdid==36
	drop if parent_key=="uuid:7e235580-30be-4dea-8982-68ed963b45c8"  // householdid==67
	drop if parent_key=="uuid:ece23449-7f67-4de2-b7da-3ea48d4d33dd"  // householdid==235
	drop if parent_key=="uuid:953d8941-5338-4a82-a5d7-2f6e25947e5d"  // householdid==246
	drop if parent_key=="uuid:f52b0fb0-064b-4133-a78d-83edcd80b3e1"  // householdid==343
	drop if parent_key=="uuid:08b045f7-ca13-429c-b25b-604ed8786a32"  // householdid==348
	drop if parent_key=="uuid:332b0700-6bdb-4e66-92ee-7f1e892dae6a"  // householdid==361
	drop if parent_key=="uuid:6854d50b-0b75-4b24-a3b8-ee031aa78668"  // householdid==391
	*
	drop if parent_key=="uuid:f98d6d16-e1cb-4504-8475-9414a295c014"  // householdid==534
	drop if parent_key=="uuid:0c5b2989-3bf7-49db-b6e4-ab455dfee7fe"  // householdid==547 (duplicates with "uuid:211fcb9c-19d7-4e89-9285-488a1a6588be")
	}
	capture confirm v forauto
	if !_rc {
	drop forauto
	}
	save "`f'", replace	
	tempfile save`i'
}
restore

****************************************
* END
















****************************************
* Check of duplicates for HH datasets
****************************************

********** Raw datasets
foreach x in APRIL DEC DECEMBER FEB FEBRUARY LAST NEW_APRIL NEW_JUNE {
use"$directorybis\NEEMSIS2_`x'\NEEMSIS2_`x'.dta", clear
gen version="`x'"
save"$directory\CLEAN\_tomove\NEEMSIS2_`x'.dta", replace
}


use"$directory\CLEAN\_tomove\NEEMSIS2_APRIL.dta", clear
foreach x in DEC DECEMBER FEB FEBRUARY LAST NEW_APRIL NEW_JUNE {
append using "$directory\CLEAN\_tomove\NEEMSIS2_`x'.dta", force
}

replace name1=namefrompreload1 if name1=="" & namefrompreload1!=""
replace name2=namefrompreload2 if name2=="" & namefrompreload2!=""
replace name3=namefrompreload3 if name3=="" & namefrompreload3!=""

rename key parent_key
destring householdid, replace
sort householdid
order parent_key householdid name1 name2 name3 submissiondate

***** Duplicates
gen todrop=0

*** Former HH
replace todrop=1 if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"  // householdid==36 & name1=="Natesan"
replace todrop=1 if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"  // householdid==67 & name1=="Shankar"
replace todrop=1 if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"  // householdid==124 & name1=="Subramani"
replace todrop=1 if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"  // householdid==246 & name1=="Sornambal"
replace todrop=1 if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"  // householdid==343 & name1=="Ramamoorthi"
replace todrop=1 if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"  // householdid==348 & name1=="Govindan"
replace todrop=1 if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"  // householdid==361 & name1=="Mallika"
replace todrop=1 if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"  // householdid==391 & name1=="Balaji"

*** New HH
replace todrop=1 if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"  // householdid==532 & name1=="Shakthivel" & name2=="Revathy"
replace todrop=1 if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"  // householdid==534 & name1=="Karunanidhi"
replace todrop=1 if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"  // householdid==547 & name1=="Surya" (duplicates with "uuid:ae72a34f-f968-45f4-acfa-91f571f54ea8")

sort householdid todrop name1
order parent_key householdid todrop name1 name2 name3 submissiondate

drop if todrop==1
ta parent_key, m




********** Clean datasets
use"$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear

preserve
duplicates drop HHID_panel, force
ta caste, m
restore

preserve
duplicates drop parent_key, force
ta caste, m
restore

/*
Total of 643 HH but 11 are duplicates which means that
our total sample is 632 HH
*/
****************************************
* END











****************************************
* Check of duplicates for agri datasets
****************************************

********** Raw datasets
foreach x in Agriculture DEC_Agriculture DECEMBER_Agriculture FEB_NEW_Agriculture FEBRUARY_Agriculture {
use"$directorybis\NEEMSIS2_`x'\NEEMSIS2_`x'.dta", clear
gen version="`x'"
save"$directory\CLEAN\_tomove\NEEMSIS2_`x'.dta", replace
}


use"$directory\CLEAN\_tomove\NEEMSIS2_Agriculture.dta", clear
foreach x in DEC_Agriculture DECEMBER_Agriculture FEB_NEW_Agriculture FEBRUARY_Agriculture {
append using "$directory\CLEAN\_tomove\NEEMSIS2_`x'.dta", force
}

rename key parent_key
destring householdid, replace
sort householdid
order parent_key householdid namenewhead submissiondate

***** Duplicates
gen todrop=0

*** Former HH
replace todrop=1 if parent_key=="uuid:244d058e-b68a-4271-bf5f-5332dca88f8f"  // householdid==36
replace todrop=1 if parent_key=="uuid:7e235580-30be-4dea-8982-68ed963b45c8"  // householdid==67
replace todrop=1 if parent_key=="uuid:ece23449-7f67-4de2-b7da-3ea48d4d33dd"  // householdid==235
replace todrop=1 if parent_key=="uuid:953d8941-5338-4a82-a5d7-2f6e25947e5d"  // householdid==246
replace todrop=1 if parent_key=="uuid:f52b0fb0-064b-4133-a78d-83edcd80b3e1"  // householdid==343
replace todrop=1 if parent_key=="uuid:08b045f7-ca13-429c-b25b-604ed8786a32"  // householdid==348
replace todrop=1 if parent_key=="uuid:332b0700-6bdb-4e66-92ee-7f1e892dae6a"  // householdid==361
replace todrop=1 if parent_key=="uuid:6854d50b-0b75-4b24-a3b8-ee031aa78668"  // householdid==391

*** New HH
replace todrop=1 if parent_key=="uuid:f98d6d16-e1cb-4504-8475-9414a295c014"  // householdid==534
replace todrop=1 if parent_key=="uuid:0c5b2989-3bf7-49db-b6e4-ab455dfee7fe"  // householdid==547 (duplicates with "uuid:211fcb9c-19d7-4e89-9285-488a1a6588be")

sort householdid todrop
order parent_key householdid todrop

drop if todrop==1
ta parent_key, m



********** Clean datasets
use"$directory\CLEAN\_tomove\NEEMSIS_Agriculture_APPEND_v3.dta", clear
*632

/*
Total of 642 HH but 10 are duplicates which means that
our total sample is 632 HH
*/
****************************************
* END
