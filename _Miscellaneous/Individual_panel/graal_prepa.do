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



********** Cohérence age
destring age2016 age2010, replace

*** If Died = replace
replace age2016=age2010+6 if livinghome2016=="No, died" & age2010!=. & age2016!=.

gen diff=age2016-age2010
order HHID_panel INDID_panel name2010 name2016 relationshiptohead2010 relationshiptohead2016 age2010 age2016 diff
bysort HHID_panel: egen max_diff=max(diff)
bysort HHID_panel: egen min_diff=min(diff)
gen int_diff=max_diff-min_diff
order min_diff max_diff int_diff, after(diff)
*clonevar age2010panel=age2010
*clonevar age2016panel=age2016
*clonevar age2020panel=age2020
gen age2010panel=.
gen age2016panel=.
order age2010panel age2016panel, after(int_diff)



** Min
sort min_diff HHID_panel INDID_panel

replace age2016panel=age2010+6 if HHID_panel=="MANAM23" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="MANAM23" & INDID_panel=="Ind_3"
replace age2016panel=age2010+6 if HHID_panel=="MANAM23" & INDID_panel=="Ind_4"
replace age2016panel=age2010+6 if HHID_panel=="MANAM23" & INDID_panel=="Ind_5"

replace age2016panel=age2010+6 if HHID_panel=="KOR20" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KOR20" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="KOR20" & INDID_panel=="Ind_3"
replace age2016panel=age2010+6 if HHID_panel=="KOR20" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="ORA26" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="ORA26" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="ELA11" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="ELA11" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="ELA11" & INDID_panel=="Ind_3"
replace age2016panel=age2010+6 if HHID_panel=="ELA11" & INDID_panel=="Ind_4"
replace age2016panel=age2010+6 if HHID_panel=="ELA11" & INDID_panel=="Ind_5"

replace age2010panel=age2016-6 if HHID_panel=="KOR9" & INDID_panel=="Ind_1"
replace age2010panel=age2016-6 if HHID_panel=="KOR9" & INDID_panel=="Ind_2"
replace age2010panel=age2016-6 if HHID_panel=="KOR9" & INDID_panel=="Ind_3"
replace age2010panel=age2016-6 if HHID_panel=="KOR9" & INDID_panel=="Ind_4"
replace age2010panel=age2016-6 if HHID_panel=="KOR9" & INDID_panel=="Ind_7"

replace age2016panel=age2010+6 if HHID_panel=="MAN13" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="MAN13" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="KOR25" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="KOR25" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="ELA6" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="ELA6" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KUV23" & INDID_panel=="Ind_6"

replace age2016panel=age2010+6 if HHID_panel=="NAT1" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="NAT1" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="SEM6" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="SEM6" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KUV22" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KUV22" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="SEM37" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="SEM37" & INDID_panel=="Ind_5"

replace age2016panel=age2010+6 if HHID_panel=="ELA19" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="ELA19" & INDID_panel=="Ind_3"
replace age2016panel=age2010+6 if HHID_panel=="ELA19" & INDID_panel=="Ind_4"
replace age2016panel=age2010+6 if HHID_panel=="ELA19" & INDID_panel=="Ind_5"
replace age2016panel=age2010+6 if HHID_panel=="ELA19" & INDID_panel=="Ind_6"

replace age2016panel=age2010+6 if HHID_panel=="KUV27" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="MAN12" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="MAN12" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="MAN12" & INDID_panel=="Ind_3"
replace age2016panel=age2010+6 if HHID_panel=="MAN12" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="MANAM28" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="GOV41" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KAR2" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="KOR15" & INDID_panel=="Ind_4"
replace age2016panel=age2010+6 if HHID_panel=="KOR15" & INDID_panel=="Ind_5"

replace age2016panel=age2010+6 if HHID_panel=="KUV19" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KUV19" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="MANAM38" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="MANAM38" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="KAR20" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KUV36" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="KUV36" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="NAT46" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="SEM48" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="ELA1" & INDID_panel=="Ind_5"

replace age2016panel=age2010+6 if HHID_panel=="ELA45" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if (diff==0 & age2016panel==. & age2010panel==.)
replace age2016panel=age2010+6 if (diff==1 & age2016panel==. & age2010panel==.)
replace age2016panel=age2010+6 if (diff==2 & age2016panel==. & age2010panel==.)


** Min
sort max_diff HHID_panel INDID_panel

replace age2010panel=age2016-6 if HHID_panel=="SEM40" & INDID_panel=="Ind_1"
replace age2010panel=age2016-6 if HHID_panel=="SEM40" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="ORA18" & INDID_panel=="Ind_5"
replace age2016panel=age2010+6 if HHID_panel=="ORA18" & INDID_panel=="Ind_6"

replace age2016panel=age2010+6 if HHID_panel=="GOV26" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="GOV26" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="ELA35" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="ELA35" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="ELA35" & INDID_panel=="Ind_5"

replace age2016panel=age2010+6 if HHID_panel=="ORA25" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="MANAM17" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="MANAM17" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="GOV29" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="GOV29" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="ORA24" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="ELA7" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="ELA7" & INDID_panel=="Ind_4"
replace age2016panel=age2010+6 if HHID_panel=="ELA7" & INDID_panel=="Ind_5"

replace age2016panel=age2010+6 if HHID_panel=="ELA2" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="ELA2" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="MAN44" & INDID_panel=="Ind_2"

replace age2010panel=age2016-6 if HHID_panel=="NAT51" & INDID_panel=="Ind_1"
replace age2010panel=age2016-6 if HHID_panel=="NAT51" & INDID_panel=="Ind_2"
replace age2010panel=age2016-6 if HHID_panel=="NAT51" & INDID_panel=="Ind_3"
replace age2010panel=age2016-6 if HHID_panel=="NAT51" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="KAR34" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KAR34" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="SEM5" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="SEM5" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="SEM5" & INDID_panel=="Ind_3"
replace age2016panel=age2010+6 if HHID_panel=="SEM5" & INDID_panel=="Ind_4"
replace age2016panel=age2010+6 if HHID_panel=="SEM5" & INDID_panel=="Ind_5"

replace age2016panel=age2010+6 if HHID_panel=="MAN20" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="MAN20" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KOR40" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KOR40" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KAR48" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KAR48" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="SEM46" & INDID_panel=="Ind_3"
replace age2016panel=age2010+6 if HHID_panel=="SEM46" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="ORA15" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="NAT4" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="NAT4" & INDID_panel=="Ind_3"
replace age2016panel=age2010+6 if HHID_panel=="NAT4" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="NAT37" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="NAT35" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="NAT35" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="NAT11" & INDID_panel=="Ind_5"
replace age2016panel=age2010+6 if HHID_panel=="NAT11" & INDID_panel=="Ind_6"

replace age2016panel=age2010+6 if HHID_panel=="MANAM32" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="KUV29" & INDID_panel=="Ind_4"
replace age2016panel=age2010+6 if HHID_panel=="KUV29" & INDID_panel=="Ind_5"

replace age2016panel=age2010+6 if HHID_panel=="KOR26" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KOR26" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KOR23" & INDID_panel=="Ind_5"

replace age2016panel=age2010+6 if HHID_panel=="KAR29" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KAR29" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="GOV32" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="ELA9" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="ELA9" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="ELA9" & INDID_panel=="Ind_3"
replace age2016panel=age2010+6 if HHID_panel=="ELA9" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="ELA45" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="ELA45" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_3"
replace age2016panel=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_4"
replace age2016panel=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_5"
replace age2016panel=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_6"
replace age2016panel=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_7"

replace age2016panel=age2010+6 if HHID_panel=="ORA22" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="ORA22" & INDID_panel=="Ind_4"
replace age2016panel=age2010+6 if HHID_panel=="ORA22" & INDID_panel=="Ind_5"

replace age2016panel=age2010+6 if HHID_panel=="ORA14" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="ORA14" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="MANAM8" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="MANAM8" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="MAN14" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="MAN14" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KUV52" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KUV52" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="KUV52" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="KOR1" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="KOR1" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="KAR7" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="SEM8" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="ORA9" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="NAT28" & INDID_panel=="Ind_5"
replace age2016panel=age2010+6 if HHID_panel=="NAT28" & INDID_panel=="Ind_6"

replace age2016panel=age2010+6 if HHID_panel=="MAN32" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="MAN32" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="MAN32" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="KUV19" & INDID_panel=="Ind_6"

replace age2016panel=age2010+6 if HHID_panel=="KOR10" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="KAR45" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KAR45" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KAR25" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="GOV3" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="ELA30" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="ELA30" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="ELA30" & INDID_panel=="Ind_7"

replace age2016panel=age2010+6 if HHID_panel=="SEM2" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="SEM2" & INDID_panel=="Ind_6"

replace age2016panel=age2010+6 if HHID_panel=="SEM17" & INDID_panel=="Ind_5"
replace age2016panel=age2010+6 if HHID_panel=="SEM17" & INDID_panel=="Ind_6"

replace age2016panel=age2010+6 if HHID_panel=="ORA23" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="ORA2" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="ORA2" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="NAT29" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="NAT29" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="MANAM4" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="MANAM31" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="MAN10" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="KUV43" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KUV14" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="KOR27" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KOR27" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KAR44" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KAR44" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KAR36" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KAR21" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KAR21" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KAR10" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KAR10" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="SEM43" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="SEM22" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="SEM16" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="ORA39" & INDID_panel=="Ind_6"

replace age2016panel=age2010+6 if HHID_panel=="NAT5" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="MANAM51" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="MANAM51" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="MANAM51" & INDID_panel=="Ind_3"
replace age2016panel=age2010+6 if HHID_panel=="MANAM51" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="MANAM20" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="MAN39" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="MAN1" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KUV27" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KUV27" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KUV12" & INDID_panel=="Ind_5"

replace age2016panel=age2010+6 if HHID_panel=="KOR37" & INDID_panel=="Ind_3"
replace age2016panel=age2010+6 if HHID_panel=="KOR37" & INDID_panel=="Ind_5"

replace age2016panel=age2010+6 if HHID_panel=="KAR49" & INDID_panel=="Ind_4"
replace age2016panel=age2010+6 if HHID_panel=="KAR49" & INDID_panel=="Ind_6"

replace age2016panel=age2010+6 if HHID_panel=="KAR42" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="KAR26" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="GOV4" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="GOV4" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="GOV28" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="SEM42" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="SEM36" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="SEM27" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="SEM15" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="SEM15" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="SEM1" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="ORA48" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="ORA30" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="ORA1" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="NAT39" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="NAT16" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="NAT15" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="MANAM45" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="MANAM43" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="MANAM42" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="MANAM10" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="MAN31" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="MAN31" & INDID_panel=="Ind_5"
replace age2016panel=age2010+6 if HHID_panel=="MAN31" & INDID_panel=="Ind_6"

replace age2016panel=age2010+6 if HHID_panel=="MAN21" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="MAN19" & INDID_panel=="Ind_3"
replace age2016panel=age2010+6 if HHID_panel=="MAN19" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="MAN18" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KUV6" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="KUV40" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KUV21" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KOR5" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="KOR3" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="KOR3" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="KAR8" & INDID_panel=="Ind_2"
replace age2016panel=age2010+6 if HHID_panel=="KAR8" & INDID_panel=="Ind_3"

replace age2016panel=age2010+6 if HHID_panel=="KAR47" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="KAR3" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KAR3" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KAR18" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="KAR17" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KAR17" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="KAR15" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="KAR15" & INDID_panel=="Ind_4"

replace age2016panel=age2010+6 if HHID_panel=="GOV39" & INDID_panel=="Ind_1"
replace age2016panel=age2010+6 if HHID_panel=="GOV39" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="GOV38" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="ELA42" & INDID_panel=="Ind_2"

replace age2016panel=age2010+6 if HHID_panel=="ELA33" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="ELA23" & INDID_panel=="Ind_1"

replace age2016panel=age2010+6 if HHID_panel=="ELA15" & INDID_panel=="Ind_5"


********** No pb
replace age2010panel=age2010 if age2010panel==.
replace age2016panel=age2016 if age2016panel==.

********** Verif
gen diffpanel=age2016panel-age2010panel
order HHID_panel INDID_panel relationshiptohead2010 relationshiptohead2016 age2010 age2016 diff age2010panel age2016panel diffpanel

ta diffpanel
sort diffpanel

gen diff2016=age2016-age2016panel
gen diff2010=age2010-age2010panel

ta diff2016
ta diff2010
drop diff diffpanel min_diff max_diff int_diff diff2016 diff2010


/*
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
*/

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


/*

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
