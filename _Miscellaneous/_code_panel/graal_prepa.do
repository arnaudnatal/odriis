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

global git "C:\Users\Arnaud\Documents\GitHub\odriis\_Miscellaneous\_code_panel"

global rume "C:\Users\Arnaud\Documents\MEGA\Data\Data_RUME\DATA\CLEAN"
global neemsis1 "C:\Users\Arnaud\Documents\MEGA\Data\Data_NEEMSIS1\DATA\CLEAN"
global neemsis2 "C:\Users\Arnaud\Documents\MEGA\Data\Data_NEEMSIS2\DATA\CLEAN"
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
use"$rume\RUME-HH.dta", clear
keep HHID_panel INDID_panel HHID2010 INDID2010 name age sex relationshiptohead jatis caste address villageid villagearea

* All string
tostring *, replace
desc

* Decode
foreach x in relationshiptohead jatis caste sex villageid villagearea {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}
desc

* Wave, year and submissiondate
gen wave="RUME (2010)"
gen submissiondate="2010" 

* Order
order HHID_panel INDID_panel HHID2010 INDID2010 wave submissiondate name age sex relationshiptohead jatis caste address villageid villagearea
compress

foreach x in * {
rename `x' `x'2010
}

foreach x in HHID_panel INDID_panel HHID2010 INDID2010 {
rename `x'2010 `x'
}

save"$git\RUME-HH_indiv.dta", replace



********** NEEMSIS1
use"$neemsis1\NEEMSIS1-HH.dta", clear

rename INDID INDID2016
keep HHID_panel INDID_panel HHID2016 INDID2016 name age sex relationshiptohead jatis caste address villageid submissiondate livinghome lefthomereason villagearea villageid_new

replace lefthomereason="" if livinghome==1
replace lefthomereason="" if livinghome==4

* All string
tostring *, replace
desc

* Decode
foreach x in sex villageid relationshiptohead jatis caste livinghome villagearea {
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
order HHID_panel INDID_panel HHID2016 INDID2016 wave submissiondate name age sex relationshiptohead jatis caste address villageid villagearea
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
use"$neemsis2\\NEEMSIS2-HH_all.dta", clear

keep HHID_panel INDID_panel parent_key INDID2020 INDID_new INDID_former INDID_left name age sex relationshiptohead relationshiptoheadother jatis caste address villageid submissiondate householdid2020 livinghome lefthomereason  dummylefthousehold reasonlefthome reasonlefthomeother villagearea
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
foreach x in sex villageid relationshiptohead jatis caste member_left member_new member_former livinghome reasonlefthome lefthomereason villagearea {
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
order HHID_panel INDID_panel HHID2020 INDID2020 wave submissiondate name age sex relationshiptohead relationshiptoheadother jatis caste address villageid villagearea
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
*clonevar agepanel2010=age2010
*clonevar agepanel2016=age2016
*clonevar age2020panel=age2020
gen agepanel2010=.
gen agepanel2016=.
order agepanel2010 agepanel2016, after(int_diff)



** Min
sort min_diff HHID_panel INDID_panel

replace agepanel2016=age2010+6 if HHID_panel=="MANAM23" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="MANAM23" & INDID_panel=="Ind_3"
replace agepanel2016=age2010+6 if HHID_panel=="MANAM23" & INDID_panel=="Ind_4"
replace agepanel2016=age2010+6 if HHID_panel=="MANAM23" & INDID_panel=="Ind_5"

replace agepanel2016=age2010+6 if HHID_panel=="KOR20" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KOR20" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="KOR20" & INDID_panel=="Ind_3"
replace agepanel2016=age2010+6 if HHID_panel=="KOR20" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="ORA26" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="ORA26" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="ELA11" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="ELA11" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="ELA11" & INDID_panel=="Ind_3"
replace agepanel2016=age2010+6 if HHID_panel=="ELA11" & INDID_panel=="Ind_4"
replace agepanel2016=age2010+6 if HHID_panel=="ELA11" & INDID_panel=="Ind_5"

replace agepanel2010=age2016-6 if HHID_panel=="KOR9" & INDID_panel=="Ind_1"
replace agepanel2010=age2016-6 if HHID_panel=="KOR9" & INDID_panel=="Ind_2"
replace agepanel2010=age2016-6 if HHID_panel=="KOR9" & INDID_panel=="Ind_3"
replace agepanel2010=age2016-6 if HHID_panel=="KOR9" & INDID_panel=="Ind_4"
replace agepanel2010=age2016-6 if HHID_panel=="KOR9" & INDID_panel=="Ind_7"

replace agepanel2016=age2010+6 if HHID_panel=="MAN13" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="MAN13" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="KOR25" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="KOR25" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="ELA6" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="ELA6" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KUV23" & INDID_panel=="Ind_6"

replace agepanel2016=age2010+6 if HHID_panel=="NAT1" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="NAT1" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="SEM6" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="SEM6" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KUV22" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KUV22" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="SEM37" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="SEM37" & INDID_panel=="Ind_5"

replace agepanel2016=age2010+6 if HHID_panel=="ELA19" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="ELA19" & INDID_panel=="Ind_3"
replace agepanel2016=age2010+6 if HHID_panel=="ELA19" & INDID_panel=="Ind_4"
replace agepanel2016=age2010+6 if HHID_panel=="ELA19" & INDID_panel=="Ind_5"
replace agepanel2016=age2010+6 if HHID_panel=="ELA19" & INDID_panel=="Ind_6"

replace agepanel2016=age2010+6 if HHID_panel=="KUV27" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="MAN12" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="MAN12" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="MAN12" & INDID_panel=="Ind_3"
replace agepanel2016=age2010+6 if HHID_panel=="MAN12" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="MANAM28" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="GOV41" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KAR2" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="KOR15" & INDID_panel=="Ind_4"
replace agepanel2016=age2010+6 if HHID_panel=="KOR15" & INDID_panel=="Ind_5"

replace agepanel2016=age2010+6 if HHID_panel=="KUV19" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KUV19" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="MANAM38" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="MANAM38" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="KAR20" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KUV36" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="KUV36" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="NAT46" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="SEM48" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="ELA1" & INDID_panel=="Ind_5"

replace agepanel2016=age2010+6 if HHID_panel=="ELA45" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if (diff==0 & agepanel2016==. & agepanel2010==.)
replace agepanel2016=age2010+6 if (diff==1 & agepanel2016==. & agepanel2010==.)
replace agepanel2016=age2010+6 if (diff==2 & agepanel2016==. & agepanel2010==.)


** Min
sort max_diff HHID_panel INDID_panel

replace agepanel2010=age2016-6 if HHID_panel=="SEM40" & INDID_panel=="Ind_1"
replace agepanel2010=age2016-6 if HHID_panel=="SEM40" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="ORA18" & INDID_panel=="Ind_5"
replace agepanel2016=age2010+6 if HHID_panel=="ORA18" & INDID_panel=="Ind_6"

replace agepanel2016=age2010+6 if HHID_panel=="GOV26" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="GOV26" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="ELA35" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="ELA35" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="ELA35" & INDID_panel=="Ind_5"

replace agepanel2016=age2010+6 if HHID_panel=="ORA25" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="MANAM17" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="MANAM17" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="GOV29" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="GOV29" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="ORA24" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="ELA7" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="ELA7" & INDID_panel=="Ind_4"
replace agepanel2016=age2010+6 if HHID_panel=="ELA7" & INDID_panel=="Ind_5"

replace agepanel2016=age2010+6 if HHID_panel=="ELA2" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="ELA2" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="MAN44" & INDID_panel=="Ind_2"

replace agepanel2010=age2016-6 if HHID_panel=="NAT51" & INDID_panel=="Ind_1"
replace agepanel2010=age2016-6 if HHID_panel=="NAT51" & INDID_panel=="Ind_2"
replace agepanel2010=age2016-6 if HHID_panel=="NAT51" & INDID_panel=="Ind_3"
replace agepanel2010=age2016-6 if HHID_panel=="NAT51" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="KAR34" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KAR34" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="SEM5" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="SEM5" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="SEM5" & INDID_panel=="Ind_3"
replace agepanel2016=age2010+6 if HHID_panel=="SEM5" & INDID_panel=="Ind_4"
replace agepanel2016=age2010+6 if HHID_panel=="SEM5" & INDID_panel=="Ind_5"

replace agepanel2016=age2010+6 if HHID_panel=="MAN20" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="MAN20" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KOR40" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KOR40" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KAR48" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KAR48" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="SEM46" & INDID_panel=="Ind_3"
replace agepanel2016=age2010+6 if HHID_panel=="SEM46" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="ORA15" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="NAT4" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="NAT4" & INDID_panel=="Ind_3"
replace agepanel2016=age2010+6 if HHID_panel=="NAT4" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="NAT37" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="NAT35" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="NAT35" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="NAT11" & INDID_panel=="Ind_5"
replace agepanel2016=age2010+6 if HHID_panel=="NAT11" & INDID_panel=="Ind_6"

replace agepanel2016=age2010+6 if HHID_panel=="MANAM32" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="KUV29" & INDID_panel=="Ind_4"
replace agepanel2016=age2010+6 if HHID_panel=="KUV29" & INDID_panel=="Ind_5"

replace agepanel2016=age2010+6 if HHID_panel=="KOR26" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KOR26" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KOR23" & INDID_panel=="Ind_5"

replace agepanel2016=age2010+6 if HHID_panel=="KAR29" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KAR29" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="GOV32" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="ELA9" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="ELA9" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="ELA9" & INDID_panel=="Ind_3"
replace agepanel2016=age2010+6 if HHID_panel=="ELA9" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="ELA45" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="ELA45" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_3"
replace agepanel2016=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_4"
replace agepanel2016=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_5"
replace agepanel2016=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_6"
replace agepanel2016=age2010+6 if HHID_panel=="ELA26" & INDID_panel=="Ind_7"

replace agepanel2016=age2010+6 if HHID_panel=="ORA22" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="ORA22" & INDID_panel=="Ind_4"
replace agepanel2016=age2010+6 if HHID_panel=="ORA22" & INDID_panel=="Ind_5"

replace agepanel2016=age2010+6 if HHID_panel=="ORA14" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="ORA14" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="MANAM8" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="MANAM8" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="MAN14" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="MAN14" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KUV52" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KUV52" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="KUV52" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="KOR1" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="KOR1" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="KAR7" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="SEM8" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="ORA9" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="NAT28" & INDID_panel=="Ind_5"
replace agepanel2016=age2010+6 if HHID_panel=="NAT28" & INDID_panel=="Ind_6"

replace agepanel2016=age2010+6 if HHID_panel=="MAN32" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="MAN32" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="MAN32" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="KUV19" & INDID_panel=="Ind_6"

replace agepanel2016=age2010+6 if HHID_panel=="KOR10" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="KAR45" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KAR45" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KAR25" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="GOV3" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="ELA30" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="ELA30" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="ELA30" & INDID_panel=="Ind_7"

replace agepanel2016=age2010+6 if HHID_panel=="SEM2" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="SEM2" & INDID_panel=="Ind_6"

replace agepanel2016=age2010+6 if HHID_panel=="SEM17" & INDID_panel=="Ind_5"
replace agepanel2016=age2010+6 if HHID_panel=="SEM17" & INDID_panel=="Ind_6"

replace agepanel2016=age2010+6 if HHID_panel=="ORA23" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="ORA2" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="ORA2" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="NAT29" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="NAT29" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="MANAM4" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="MANAM31" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="MAN10" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="KUV43" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KUV14" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="KOR27" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KOR27" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KAR44" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KAR44" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KAR36" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KAR21" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KAR21" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KAR10" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KAR10" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="SEM43" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="SEM22" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="SEM16" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="ORA39" & INDID_panel=="Ind_6"

replace agepanel2016=age2010+6 if HHID_panel=="NAT5" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="MANAM51" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="MANAM51" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="MANAM51" & INDID_panel=="Ind_3"
replace agepanel2016=age2010+6 if HHID_panel=="MANAM51" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="MANAM20" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="MAN39" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="MAN1" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KUV27" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KUV27" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KUV12" & INDID_panel=="Ind_5"

replace agepanel2016=age2010+6 if HHID_panel=="KOR37" & INDID_panel=="Ind_3"
replace agepanel2016=age2010+6 if HHID_panel=="KOR37" & INDID_panel=="Ind_5"

replace agepanel2016=age2010+6 if HHID_panel=="KAR49" & INDID_panel=="Ind_4"
replace agepanel2016=age2010+6 if HHID_panel=="KAR49" & INDID_panel=="Ind_6"

replace agepanel2016=age2010+6 if HHID_panel=="KAR42" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="KAR26" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="GOV4" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="GOV4" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="GOV28" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="SEM42" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="SEM36" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="SEM27" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="SEM15" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="SEM15" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="SEM1" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="ORA48" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="ORA30" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="ORA1" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="NAT39" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="NAT16" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="NAT15" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="MANAM45" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="MANAM43" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="MANAM42" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="MANAM10" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="MAN31" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="MAN31" & INDID_panel=="Ind_5"
replace agepanel2016=age2010+6 if HHID_panel=="MAN31" & INDID_panel=="Ind_6"

replace agepanel2016=age2010+6 if HHID_panel=="MAN21" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="MAN19" & INDID_panel=="Ind_3"
replace agepanel2016=age2010+6 if HHID_panel=="MAN19" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="MAN18" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KUV6" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="KUV40" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KUV21" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KOR5" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="KOR3" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="KOR3" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="KAR8" & INDID_panel=="Ind_2"
replace agepanel2016=age2010+6 if HHID_panel=="KAR8" & INDID_panel=="Ind_3"

replace agepanel2016=age2010+6 if HHID_panel=="KAR47" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="KAR3" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KAR3" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KAR18" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="KAR17" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KAR17" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="KAR15" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="KAR15" & INDID_panel=="Ind_4"

replace agepanel2016=age2010+6 if HHID_panel=="GOV39" & INDID_panel=="Ind_1"
replace agepanel2016=age2010+6 if HHID_panel=="GOV39" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="GOV38" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="ELA42" & INDID_panel=="Ind_2"

replace agepanel2016=age2010+6 if HHID_panel=="ELA33" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="ELA23" & INDID_panel=="Ind_1"

replace agepanel2016=age2010+6 if HHID_panel=="ELA15" & INDID_panel=="Ind_5"



********** No pb
replace agepanel2010=age2010 if agepanel2010==.
replace agepanel2016=age2016 if agepanel2016==.

********** Verif
gen diffpanel=agepanel2016-agepanel2010
order HHID_panel INDID_panel relationshiptohead2010 relationshiptohead2016 age2010 age2016 diff agepanel2010 agepanel2016 diffpanel

ta diffpanel
sort diffpanel

gen diff2016=age2016-agepanel2016
gen diff2010=age2010-agepanel2010

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

***** age2020panel
gen agepanel2020=agepanel2016+4


********** relationship
replace relationshiptohead2020="Head" if HHID_panel=="SEM46" & INDID_panel=="Ind_1"
replace relationshiptohead2020="Head" if HHID_panel=="SEM28" & INDID_panel=="Ind_1"
replace relationshiptohead2020="Son" if HHID_panel=="ELA25" & INDID_panel=="Ind_4"
replace relationshiptohead2020="Daughter" if HHID_panel=="MAN23" & INDID_panel=="Ind_6"


***** to string
tostring age2010 age2016 age2020, replace
tostring agepanel2010 agepanel2016 agepanel2020, replace

order HHID_panel INDID_panel name2010 name2016 name2020 sex2010 sex2016 sex2020 age2010 age2016 age2020 agepanel2010 agepanel2016 agepanel2020 relationshiptohead2010 relationshiptohead2016 relationshiptohead2020

sort HHID_panel INDID_panel



******************** Names of caste jatis

********** All names
foreach var of varlist jatis2010 jatis2016 jatis2020 {
fre `var', miss 	
}
* No missing value


********** Rename
replace jatis2010="Mudaliar" if jatis2010=="Muthaliyar"
replace jatis2010="Arunthathiyar" if jatis2010=="Arunthatiyar"

********** Backup former typology
foreach x in jatis2010 jatis2016 jatis2020 caste2010 caste2016 caste2020 {
clonevar BU_`x'=`x'
}


******************** Panel consistency of jatis

********** 2016 to 2016-17
gen pb1=1 if jatis2010!=jatis2016 & jatis2010!="" & jatis2016!=""
ta pb1
ta jatis2010 jatis2016 if pb1==1

***** Gramani in 2010 and SC in 2016
ta HHID_panel if jatis2010=="Gramani" & jatis2016=="SC"
replace jatis2010="SC" if HHID_panel=="MANAM28"

***** Other in 2010 and Kulalar in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="Kulalar"
replace jatis2010="Kulalar" if HHID_panel=="GOV38"
replace jatis2016="Kulalar" if HHID_panel=="GOV38"
replace jatis2020="Kulalar" if HHID_panel=="GOV38"

***** Other in 2010 and Muslims in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="Muslims" 
replace jatis2010="Muslims" if HHID_panel=="SEM1" |  HHID_panel=="SEM16" |  HHID_panel=="SEM26" |  HHID_panel=="SEM28" |  HHID_panel=="SEM35" |  HHID_panel=="SEM40" |  HHID_panel=="SEM43"

***** Other in 2010 and Naidu in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="Naidu"
replace jatis2010="Naidu" if HHID_panel=="SEM17"
replace jatis2010="Navithar" if HHID_panel=="ORA10"

***** Other in 2010 and Padayachi in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="Padayachi"  
replace jatis2010="Padayachi" if HHID_panel=="ELA49"

***** Other in 2010 and SC in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="SC"  
replace jatis2010="SC" if HHID_panel=="KOR23" | HHID_panel=="MAN22"

***** Other in 2010 and Vanniyar in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="Vanniyar" 
replace jatis2010="Vanniyar" if HHID_panel=="KUV52"

***** Other in 2010 and Yathavar in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="Yathavar" 
replace jatis2010="Yathavar" if HHID_panel=="KAR48"

***** Settu in 2010 and Chettiyar in 2016
ta HHID_panel if jatis2010=="Settu" & jatis2016=="Chettiyar" 
replace jatis2010="Chettiyar" if HHID_panel=="SEM10" | HHID_panel=="SEM48"

***** Settu in 2010 and Vanniyar in 2016
ta HHID_panel if jatis2010=="Settu" & jatis2016=="Vanniyar" 
replace jatis2010="Vanniyar" if HHID_panel=="MAN18"

***** Vanniyar in 2010 and Padayachi in 2016
ta HHID_panel if jatis2010=="Vanniyar" & jatis2016=="Padayachi" 
replace jatis2010="Padayachi" if HHID_panel=="ELA5" | HHID_panel=="ORA38"



********** 2016-17 to 2020-21
gen pb2=1 if jatis2016!=jatis2020 & jatis2016!="" & jatis2020!=""
ta pb2
ta jatis2016 jatis2020 if pb2==1

***** Asarai in 2016 and Vanniyar in 2020
ta HHID_panel if jatis2016=="Asarai" & jatis2020=="Vanniyar" 
replace jatis2020="Asarai" if HHID_panel=="MANAM11"

***** Gramani in 2016 and Vanniyar in 2020
ta HHID_panel if jatis2016=="Gramani" & jatis2020=="Vanniyar" 
replace jatis2020="Gramani" if HHID_panel=="MANAM12"

***** Mudaliar in 2016 and Padayachi in 2020
ta HHID_panel if jatis2016=="Mudaliar" & jatis2020=="Padayachi" 
replace jatis2020="Mudaliar" if HHID_panel=="GOV19"

***** Mudaliar in 2016 and Vanniyar in 2020
ta HHID_panel if jatis2016=="Mudaliar" & jatis2020=="Vanniyar" 
replace jatis2020="Mudaliar" if HHID_panel=="GOV2"

***** Nattar in 2016 and SC in 2020
ta HHID_panel if jatis2016=="Nattar" & jatis2020=="SC" 
replace jatis2016="SC" if HHID_panel=="MANAM18"

***** Padayachi in 2016 and Vanniyar in 2020
ta HHID_panel if jatis2016=="Padayachi" & jatis2020=="Vanniyar" 
replace jatis2020="Padayachi" if HHID_panel=="KUV42"

***** Vanniyar in 2016 and Padayachi in 2020
ta HHID_panel if jatis2016=="Vanniyar" & jatis2020=="Padayachi" 
replace jatis2020="Vanniyar" if HHID_panel=="ELA16" | HHID_panel=="KAR30"



********** 2010 to 2020-21
gen pb3=1 if jatis2010!=jatis2020 & jatis2010!="" & jatis2020!=""
ta pb3
ta jatis2010 jatis2020 if pb3==1

***** Other in 2010 and Vanniyar in 2020
ta HHID_panel if jatis2010=="Other" & jatis2020=="Vanniyar" 
replace jatis2010="Vanniyar" if HHID_panel=="ORA37"

***** Rediyar in 2010 and Vanniyar in 2020
ta HHID_panel if jatis2010=="Rediyar" & jatis2020=="Vanniyar" 
replace jatis2020="Rediyar" if HHID_panel=="MANAM40"




******************** Panel consistency of caste

********** 2010 
ta jatis2010 caste2010 

***** Muslims as upper?
ta HHID_panel if jatis2010=="Muslims" 
replace caste2010="Dalits" if HHID_panel=="SEM1" | HHID_panel=="SEM16" | HHID_panel=="SEM26" | HHID_panel=="SEM28" 
replace caste2010="Middle" if HHID_panel=="SEM35" | HHID_panel=="SEM40" | HHID_panel=="SEM43"

***** SC as middle?
ta HHID_panel if jatis2010=="SC" & caste2010=="Middle" 
replace caste2010="Dalits" if HHID_panel=="MAN22" | HHID_panel=="MANAM28"

***** Vanniyar as upper?
ta HHID_panel if jatis2010=="Vanniyar" & caste2010=="Upper" 
replace caste2010="Middle" if HHID_panel=="MAN18"

***** Yathavar as middle?
ta HHID_panel if jatis2010=="Yathavar" 
replace caste2010="Upper" if HHID_panel=="KAR48"


******** 2016-17
ta jatis2016 caste2016

***** Muslims as middle?
ta HHID_panel if jatis2016=="Muslims" 
replace caste2016="Dalits" if HHID_panel=="SEM1" | HHID_panel=="SEM16" | HHID_panel=="SEM26" | HHID_panel=="SEM28" 

***** SC as middle?
ta HHID_panel if jatis2016=="SC" & caste2016=="Middle"
replace caste2016="Dalits" if HHID_panel=="MANAM18"


******** 2020-21
ta jatis2020 caste2020

***** Mudaliar as middle?
ta HHID_panel if jatis2020=="Mudaliar" & caste2020=="Middle"
replace caste2020="Upper" if HHID_panel=="GOV19" | HHID_panel=="GOV2"

****** Muslims as middle?
ta HHID_panel if jatis2020=="Muslims" 
replace caste2020="Dalits" if HHID_panel=="SEM1" | HHID_panel=="SEM16" | HHID_panel=="SEM26" | HHID_panel=="SEM28" 

***** Rediyar as middle?
ta HHID_panel if jatis2020=="Rediyar" & caste2020=="Middle"
replace caste2020="Upper" if HHID_panel=="MANAM40" & caste2020=="Middle"


********** Panel
ta caste2010 caste2016
*Ok
ta caste2010 caste2020
*Ok 
ta caste2016 caste2020 
*Ok


********** Relationship
ta relationshiptohead2010 sex2010
ta relationshiptohead2016 sex2016
ta relationshiptohead2020 sex2020

foreach x in 2010 2016 2020 {
replace relationshiptohead`x'="Husband" if relationshiptohead`x'=="Wife" & sex`x'=="Male"
}

drop pb1 pb2 pb3

foreach x in 2010 2016 2020 {
rename agepanel`x' 	agecorr`x'
rename caste`x' 	castecorr`x'
rename jatis`x'		jatiscorr`x'
rename BU_caste`x'	caste`x'
rename BU_jatis`x'	jatis`x'
}


********** Label
foreach x in 2010 2016 2020 {
label var age`x' "Age `x'"
label var agecorr`x' "Age corrected `x'"
label var relationshiptohead`x' "Relationship to head `x'"
label var caste`x' "Caste `x'"
label var castecorr`x' "Caste corrected `x'"
label var jatis`x' "Jatis `x'"
label var jatiscorr`x' "Jatis corrected `x'"
label var villagearea`x' "Area `x'"
label var villageid`x' "Village `x'"
label var sex`x' "Sex `x'"
label var name`x' "Name `x'"
label var HHID`x' "HHID `x'"
label var INDID`x' "INDID `x'"
label var submissiondate`x' "Date `x'"
label var address`x' "Address of HH `x'"
label var wave`x' "Wave survey `x'"
}

label var HHID_panel "HHID in panel"
label var INDID_panel "Indid in panel"

label var lefthomereason2020 "Reason left home 2020"
label var lefthomereason2016 "Reason left home 2016"
label var reasonlefthome2020 "Reason left home (second module) 2020"
label var reasonlefthomeother2020 "Reason left home other (second module) 2020"

label var livinghome2016 "Is X living home? 2016"
label var livinghome2020 "Is X living home? 2020"

label var relationshiptoheadother2020 "Relationship to head other 2020"

label var member_new2020 "Is X a new member? 2020"
label var member_left2020 "Is X left the HH? 2020"

label var indivpanel_10_16_20 "Is X in full panel?"

drop householdid20202020

********** Surplus2020
gen dummysurplus2020="No"
replace dummysurplus2020="Yes" if HHID_panel=="ELA65"
replace dummysurplus2020="Yes" if HHID_panel=="KAR51"
replace dummysurplus2020="Yes" if HHID_panel=="KAR55"
replace dummysurplus2020="Yes" if HHID_panel=="KAR61"
replace dummysurplus2020="Yes" if HHID_panel=="KUV61"
replace dummysurplus2020="Yes" if HHID_panel=="MAN57"
replace dummysurplus2020="Yes" if HHID_panel=="MAN58"
replace dummysurplus2020="Yes" if HHID_panel=="MAN63"
replace dummysurplus2020="Yes" if HHID_panel=="MAN68"
replace dummysurplus2020="Yes" if HHID_panel=="MAN69"
replace dummysurplus2020="Yes" if HHID_panel=="MANAM58"
replace dummysurplus2020="Yes" if HHID_panel=="MANAM62"
replace dummysurplus2020="Yes" if HHID_panel=="ORA57"
replace dummysurplus2020="Yes" if HHID_panel=="ORA58"
replace dummysurplus2020="Yes" if HHID_panel=="ORA60"
replace dummysurplus2020="Yes" if HHID_panel=="ORA64"
replace dummysurplus2020="Yes" if HHID_panel=="ORA69"
replace dummysurplus2020="Yes" if HHID_panel=="SEM59"

label var dummysurplus2020 "HH in suplus in 2020"

foreach x in caste jatis {
replace `x'corr2020=`x'2020 if dummysurplus2020=="Yes"
}

replace agecorr2010=age2010 if agecorr2010=="." & age2010!=""
replace agecorr2016=age2016 if agecorr2016=="." & age2016!=""
replace agecorr2020=age2020 if agecorr2020=="." & age2020!=""


order HHID_panel INDID_panel indivpanel_10_16_20 dummysurplus2020 name* agecorr* age* sex* relationshiptohead* relationshiptoheadother2020 castecorr* jatiscorr* caste* jatis* villageid* villagearea* livinghome2016 lefthomereason2016 livinghome2020 lefthomereason2020 reasonlefthome2020 reasonlefthomeother2020 member_new2020 member_left2020 HHID2010 INDID2010 submissiondate2010 address2010 wave2010 HHID2016 INDID2016 submissiondate2016 address2016 wave2016 HHID2020 INDID2020 submissiondate2020 address2020 wave2020


********** Save
save"$git\ODRIIS-indiv_wide.dta", replace
export excel "$git\ODRIIS-indiv_wide.xlsx", firstrow(var) replace


reshape long wave villageid villagearea submissiondate sex relationshiptoheadother relationshiptohead reasonlefthomeother reasonlefthome name member_new member_left livinghome lefthomereason jatiscorr jatis dummysurplus castecorr caste agecorr age address INDID HHID, i(HHID_panel INDID_panel) j(year)
keep if name!=""

save"$git\ODRIIS-indiv_long.dta", replace
export excel "$git\ODRIIS-indiv_long.xlsx", firstrow(var) replace

****************************************
* END




















****************************************
* HH
****************************************

********** 2010
use"$git\ODRIIS-indiv_long.dta", clear

keep HHID_panel INDID_panel relationshiptohead castecorr caste jatiscorr jatis year
keep if year==2010

gen head=1 if relationshiptohead=="Head"
bysort HHID_panel: egen sum_head=sum(head)

ta HHID_panel if sum_head<1
ta HHID_panel if sum_head>1
list HHID_panel INDID_panel relationshiptohead castecorr caste if HHID_panel=="GOV18", clean noobs

gen castecorr_head=castecorr if relationshiptohead=="Head"
replace castecorr_head="" if HHID_panel=="GOV18" & INDID_panel=="Ind_2"

keep if castecorr_head!=""
keep HHID_panel castecorr_head

save "$git\Caste-HH_2010.dta", replace





********** 2016-17
use"$git\ODRIIS-indiv_long.dta", clear

keep HHID_panel INDID_panel relationshiptohead castecorr caste jatiscorr jatis year
keep if year==2016

gen head=1 if relationshiptohead=="Head"
bysort HHID_panel: egen sum_head=sum(head)

ta HHID_panel if sum_head<1
list HHID_panel INDID_panel relationshiptohead castecorr caste if HHID_panel=="KOR12" | HHID_panel=="KOR15" | HHID_panel=="KUV23" | HHID_panel=="KUV9" | HHID_panel=="MAN3", clean noobs

ta HHID_panel if sum_head>1
list HHID_panel INDID_panel relationshiptohead castecorr caste if HHID_panel=="GOV13" | HHID_panel=="KAR33" | HHID_panel=="KUV36" | HHID_panel=="SEM29", clean noobs

gen castecorr_head=castecorr if relationshiptohead=="Head"
replace castecorr_head="Middle" if HHID_panel=="KOR12" & INDID_panel=="Ind_1"
replace castecorr_head="Dalits" if HHID_panel=="KOR15" & INDID_panel=="Ind_1"
replace castecorr_head="Middle" if HHID_panel=="KUV23" & INDID_panel=="Ind_1"
replace castecorr_head="Dalits" if HHID_panel=="KUV9" & INDID_panel=="Ind_1"
replace castecorr_head="Dalits" if HHID_panel=="MAN3" & INDID_panel=="Ind_1"

replace castecorr_head="" if HHID_panel=="GOV13" & INDID_panel=="Ind_3"
replace castecorr_head="" if HHID_panel=="KAR33" & INDID_panel=="Ind_2"
replace castecorr_head="" if HHID_panel=="KUV36" & INDID_panel=="Ind_5"
replace castecorr_head="" if HHID_panel=="SEM29" & INDID_panel=="Ind_3"

keep if castecorr_head!=""
keep HHID_panel castecorr_head

save "$git\Caste-HH_2016.dta", replace



********** 2020-21
use"$git\ODRIIS-indiv_long.dta", clear

keep HHID_panel INDID_panel relationshiptohead castecorr caste jatiscorr jatis year
keep if year==2020

gen head=1 if relationshiptohead=="Head"
bysort HHID_panel: egen sum_head=sum(head)

ta HHID_panel if sum_head<1
list HHID_panel INDID_panel relationshiptohead castecorr caste if HHID_panel=="ELA30" | HHID_panel=="GOV29" | HHID_panel=="KAR61" | HHID_panel=="SEM50", clean noobs

ta HHID_panel if sum_head>1
list HHID_panel INDID_panel relationshiptohead castecorr caste if HHID_panel=="ELA18", clean noobs

gen castecorr_head=castecorr if relationshiptohead=="Head"
replace castecorr_head="Middle" if HHID_panel=="ELA30" & INDID_panel=="Ind_1"
replace castecorr_head="Upper" if HHID_panel=="GOV29" & INDID_panel=="Ind_1"
replace castecorr_head="Dalits" if HHID_panel=="KAR61" & INDID_panel=="Ind_1"
replace castecorr_head="Middle" if HHID_panel=="SEM50" & INDID_panel=="Ind_1"

replace castecorr_head="" if HHID_panel=="ELA18" & INDID_panel=="Ind_2"


keep if castecorr_head!=""
keep HHID_panel castecorr_head

save "$git\Caste-HH_2020.dta", replace




********** Wave 1
use"$git\RUME-HH_indiv.dta", clear
keep HHID_panel HHID2010 villageid2010 villagearea2010 address2010
duplicates drop
merge 1:1 HHID_panel using  "$git\Caste-HH_2010.dta"
rename castecorr_head castecorr2010
drop _merge
save"$git\Wave1.dta", replace



********** Wave 2
use"$git\NEEMSIS1-HH_indiv.dta", clear
keep HHID_panel HHID2016 villageid2016 villagearea2016 address2016 villageid_new2016
duplicates drop
merge 1:1 HHID_panel using  "$git\Caste-HH_2016.dta"
rename castecorr_head castecorr2016
drop _merge
save"$git\Wave2.dta", replace


********** Wave 3
use"$git\NEEMSIS2-HH_indiv.dta", clear
keep HHID_panel HHID2020 villageid2020 villagearea2020 address2020
duplicates drop
merge 1:1 HHID_panel using  "$git\Caste-HH_2020.dta"
rename castecorr_head castecorr2020
drop _merge
save"$git\Wave3.dta", replace


********* Append
use"$git\Wave1", clear
merge 1:1 HHID_panel using "$git\Wave2"
drop _merge
merge 1:1 HHID_panel using "$git\Wave3"
drop _merge


********** Save
save"$git\ODRIIS-HH_wide.dta", replace
export excel "$git\ODRIIS-HH_wide.xlsx", firstrow(var) replace


*** Long
reshape long HHID address villageid villagearea villageid_new castecorr, j(year) i(HHID_panel)

save"$git\ODRIIS-HH_long.dta", replace
export excel "$git\ODRIIS-HH_long.xlsx", firstrow(var) replace


erase "$git\RUME-HH_indiv.dta"
erase "$git\NEEMSIS1-HH_indiv.dta"
erase "$git\NEEMSIS2-HH_indiv.dta"
erase "$git\Caste-HH_2010.dta"
erase "$git\Caste-HH_2016.dta"
erase "$git\Caste-HH_2020.dta"
erase "$git\Wave1.dta"
erase "$git\Wave2.dta"
erase "$git\Wave3.dta"

****************************************
* END
