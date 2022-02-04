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
*global tracking1 "C:\Users\Arnaud\Documents\_Thesis\_DATA\Tracking2019\DATA"

*global data "C:\Users\Arnaud\Documents\_Thesis\_DATA"
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
use"$rume\CLEAN\RUME-HH.dta", clear
keep HHID_panel INDID_panel HHID2010 INDID2010 name age sex relationshiptohead jatis caste address villageid

* All string
tostring *, replace
desc

* Decode
foreach x in relationshiptohead jatis caste sex {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}
desc

* Replace
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
gen wave="RUME (2010)"
gen submissiondate="2010" 

* Order
order HHID_panel INDID_panel HHID2010 INDID2010 wave submissiondate name age sex relationshiptohead jatis caste address villageid
compress

foreach x in * {
rename `x' `x'2010
}

foreach x in HHID_panel INDID_panel HHID2010 INDID2010 {
rename `x'2010 `x'
}

save"$git\RUME-HH_indiv.dta", replace



********** NEEMSIS1
use"$neemsis1\CLEAN\NEEMSIS1-HH.dta", clear

rename INDID INDID2016
keep HHID_panel INDID_panel HHID2016 INDID2016 name age sex relationshiptohead jatis caste address villageid submissiondate livinghome lefthomereason
replace lefthomereason="" if livinghome==1
replace lefthomereason="" if livinghome==4

* All string
tostring *, replace
desc

* Decode
foreach x in sex villageid relationshiptohead jatis caste livinghome {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}
desc

* Wave, year and submissiondate
gen wave="NEEMSIS-1 (2016-17)"

gen sub=dofc(submissiondate)
format %td sub
tostring sub, format(%td) replace force
drop submissiondate
rename sub submissiondate
desc

* Order
order HHID_panel INDID_panel HHID2016 INDID2016 wave submissiondate name age sex relationshiptohead jatis caste address villageid
compress

foreach x in * {
rename `x' `x'2016
}

foreach x in HHID_panel INDID_panel HHID2016 INDID2016 {
rename `x'2016 `x'
}

order lefthomereason2016, after(livinghome2016)

save"$git\NEEMSIS1-HH_indiv.dta", replace




********** NEEMSIS2
use"$neemsis2\\NEEMSIS2-HH.dta", clear

keep HHID_panel INDID_panel parent_key INDID2020 INDID_new INDID_former INDID_left name age sex relationshiptohead relationshiptoheadother jatis caste address villageid submissiondate householdid2020 livinghome lefthomereason  dummylefthousehold reasonlefthome reasonlefthomeother
sort HHID_panel INDID_panel

gen member_new=0
gen member_former=0
gen member_left=0
replace member_new=1 if INDID_new!=.
replace member_former=1 if INDID_former!=.
replace member_left=1 if INDID_left!=.
drop INDID_new INDID_former INDID_left

order dummylefthousehold member_left

drop dummylefthousehold 
label define yesno9 0"No" 1"Yes", replace
foreach x in new former left {
label values member_`x' yesno9
}
fre member_*

rename parent_key HHID2020

* All string
tostring *, replace
desc

* Decode
foreach x in sex villageid relationshiptohead jatis caste member_left member_new member_former livinghome reasonlefthome lefthomereason {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}
desc
replace relationshiptohead="Other" if relationshiptohead==""


* Wave, year and submissiondate
gen wave="NEEMSIS-2 (2020-21)"

gen sub=dofc(submissiondate)
format %td sub
tostring sub, format(%td) replace force
drop submissiondate
rename sub submissiondate

* Order
order HHID_panel INDID_panel HHID2020 INDID2020 wave submissiondate name age sex relationshiptohead relationshiptoheadother jatis caste address villageid
compress

foreach x in * {
rename `x' `x'2020
}

foreach x in HHID_panel INDID_panel HHID2020 INDID2020 {
rename `x'2020 `x'
}

order member_left2020 reasonlefthome2020 reasonlefthomeother2020 livinghome2020 lefthomereason2020, after(member_former2020)

drop member_former

save"$git\NEEMSIS2-HH_indiv.dta", replace



/*
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
*/





****************************************
* APPEND ALL DATASETS
****************************************
use"$git\RUME-HH_indiv.dta", clear

merge 1:1 HHID_panel INDID_panel using "$git\NEEMSIS1-HH_indiv.dta"
drop _merge

merge 1:1 HHID_panel INDID_panel using "$git\NEEMSIS2-HH_indiv.dta"
drop _merge

order HHID_panel INDID_panel wave2010 wave2016 wave2020
fre wave2010 wave2016 wave2020

* Indiv
gen indivpanel_10_16_20="No"
replace indivpanel_10_16_20="Yes" if wave2010=="RUME (2010)" & wave2016=="NEEMSIS-1 (2016-17)" & wave2020=="NEEMSIS-2 (2020-21)"

order HHID_panel INDID_panel name2010 name2016 livinghome2016 name2020 member_new2020 member_left2020 livinghome2020

sort HHID_panel INDID_panel



********** Pb
gen pb=.

*** Relationship
replace pb=1 if HHID_panel=="KOR20"  // relationship chaotique en panel
replace pb=1 if HHID_panel=="KOR26"  // relationship idem à recoder

replace pb=1 if HHID_panel=="GOV28"  // grandchild chelou
replace pb=1 if HHID_panel=="MANAM38"
replace pb=1 if HHID_panel=="MANAM2"
replace pb=1 if HHID_panel=="KUV27"
replace pb=1 if HHID_panel=="MAN17"
replace pb=1 if HHID_panel=="MANAM30"
replace pb=1 if HHID_panel=="ELA9"

*** Age
replace pb=1 if HHID_panel=="ELA40"


*** Jatis
replace pb=1 if HHID_panel=="GOV42"  // pb jatis

*** 2010-2020 panel étrange
replace pb=1 if HHID_panel=="GOV5"  // 2010-2020 avec une seule personne en panel
replace pb=1 if HHID_panel=="KUV10"
replace pb=1 if HHID_panel=="KUV25"
replace pb=1 if HHID_panel=="GOV9" 
replace pb=1 if HHID_panel=="GOV10"


*** Avec Youna et Sébastien
*replace pb=1 if HHID_panel=="KAR49"  // 7 et 8 identiques non donc on sort
*replace pb=1 if HHID_panel=="KOR15"  // Kalaimani et différent


*** Apparitions
replace pb=1 if HHID_panel=="ELA40"  // 7 et 8 14 ans en 2016, pq pas là en 2010


*** Disparitions
replace pb=1 if HHID_panel=="ELA9"  // où est le fils ?


********** Save
save"$git\ODRIIS-indiv.dta", replace


export excel "$git\ODRIIS-indiv.xlsx", firstrow(var) replace

****************************************
* END







****************************************
* HH
****************************************
use"$git\RUME-HH_indiv.dta", clear

duplicates drop HHID_panel, force
keep HHID2010 HHID_panel

preserve
use "$git\NEEMSIS1-HH_indiv.dta", clear
duplicates drop HHID_panel, force
keep HHID2016 HHID_panel
save "$git\NEEMSIS1-HH.dta", replace
restore

preserve
use "$git\NEEMSIS2-HH_indiv.dta", clear
duplicates drop HHID_panel, force
keep HHID2020 HHID_panel
save "$git\NEEMSIS2-HH.dta", replace
restore

merge 1:1 HHID_panel using "$git\NEEMSIS1-HH.dta"
drop _merge
merge 1:1 HHID_panel using "$git\NEEMSIS2-HH.dta"
drop _merge

********** panel
gen panel1=1 if HHID2010!="" & HHID2016!=""
gen panel2=1 if HHID2016!="" & HHID2020!=""
gen panel3=1 if HHID2010!="" & HHID2016!="" & HHID2020!=""

gen panel4=1 if HHID2010!="" & HHID2016=="" & HHID2020!=""
list HHID_panel if panel4==1, clean noobs
/*
       GOV10  
       GOV47  
        GOV5  
        GOV9  
       KUV10  
       KUV25  
     MANAM19  
     MANAM34  
     MANAM40  
       ORA37 
*/

********** Save
save"$git\ODRIIS-HH.dta", replace

export excel "$git\ODRIIS-HH.xlsx", firstrow(var) replace

erase "$git\NEEMSIS1-HH.dta"
erase "$git\NEEMSIS2-HH.dta"
****************************************
* END




keep if HHID_panel=="GOV10" | /// 
HHID_panel=="GOV47" |   ///
HHID_panel=="GOV5" |   ///
HHID_panel=="GOV9" |   ///
HHID_panel=="KUV10" |   ///
HHID_panel=="KUV25" |   ///
HHID_panel=="MANAM19" |   ///
HHID_panel=="MANAM34" |   ///
HHID_panel=="MANAM40" |   ///
HHID_panel=="ORA37" 

order HHID_panel INDID_panel name2010 name2020 relationshiptohead2010 relationshiptohead2020 age2010 age2020
