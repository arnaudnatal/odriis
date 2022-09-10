****************************************
* NUMBERING REPEAT
****************************************
*AS FOR GROUPS BUT WITH REPEAT
use"survey_other", clear

keep if type=="begin repeat" | type=="end repeat"
dropmiss, force
compress



********** Reshape wide to have one repeat per row
gen type_num=1 if type=="begin repeat"
replace type_num=2 if type=="end repeat"
keep n_survey repeatname type_num
sort n_survey
reshape wide n_survey, i(repeatname) j(type_num)



********** Intermediate storage
save"repeats_wide.dta", replace



********** Generate first level of repeats
use"repeats_wide.dta", clear
forvalues i = 1/9999 {
sort n_survey1
drop if n_survey1>n_survey1[_n-1] & n_survey2<n_survey2[_n-1]
}
foreach x in n* {
recode `x' (0=.)
}
dropmiss, force
* Level1 id variable
gen level1=1
preserve
gen title1=_n
save"temp_rep1.dta", replace
restore
save"temp_repeats_wide.dta", replace



********** Generate all others levels of repeats
forvalues j=2/10 {
use"repeats_wide.dta", clear

merge 1:1 repeatname using "temp_repeats_wide.dta"
keep if _merge==1
drop _merge

forvalues i = 1/99999 {
sort n_survey1
drop if n_survey1>n_survey1[_n-1] & n_survey2<n_survey2[_n-1]
}

gen level`j'=1
preserve
gen title`j'=_n
save"temp_rep`j'.dta", replace
restore

append using "temp_repeats_wide.dta"
sort n_survey1
order level`j', last
save"temp_repeats_wide.dta", replace
}



********** Generate first level of title
use"temp_repeats_wide.dta", clear
bysort level1 (n_survey1): gen title1=_n
replace title1=. if level1==.
sort n_survey1
replace title1=title1[_n-1] if title1[_n-1]!=. & title1==.
egen temp1=concat(title1), p(".")
save"repeats_wide_v2.dta", replace



********** Generate all others variables of title
use"repeats_wide_v2.dta", clear
forvalues i=2/10 {
local j=`i'-1

sort n_survey1
egen temp`i'=concat(temp`j' level`i'), p("//")
sencode temp`i', gen(temp`i'_code) gsort(n_survey1)
bysort temp`i'_code (n_survey1): gen title`i'=_n
replace title`i'=. if level`i'==.
sort n_survey1
replace title`i'=title`i'[_n-1] if title`i'[_n-1]!=. & title`i'==. & title`j'[_n-1]==title`j'
drop temp`i'*
egen temp`i'=concat(temp`j' title`i'), p(".")
drop temp`j'
}
drop temp*
order repeatname n_survey* level* title*
sort n_survey1
preserve
gen level=.
forvalues i=1/10 {
replace level`i'=`i' if level`i'==1
replace level=level`i' if level`i'!=. & level==.
drop level`i'
rename title`i' repeattitle`i'
}
rename level repeatlevel
save"repeats_wide_v3.dta", replace
restore


***** Clean results then Reshape long to merge with questions
egen title=concat(title1-title10), p(".")
gen level=.
forvalues i=1/10 {
replace level`i'=`i' if level`i'==1
replace level=level`i' if level`i'!=. & level==.
drop level`i' title`i'
}
forvalues i=1/99 {
replace title=substr(title,1,strlen(title)-1) if substr(title,strlen(title)-1,1)=="."
}
reshape long n_survey, i(repeatname) j(type)
tostring type, replace
replace type="begin repeat" if type=="1"
replace type="end repeat" if type=="2"
sort n_survey
rename title repeattitle
rename level repeatlevel
save"repeats_long.dta", replace
****************************************
* END















****************************************
* DESIGN: REPEATS
****************************************
********** Repeat
use"repeats_wide_v3", clear
merge 1:m repeatname using "survey_other", keepusing(type label relevance required repeat_count)
keep if _merge==3
drop _merge
drop if type=="end repeat"
drop type
compress
sort n_survey1

* Gen repeat name
egen temp_repeattitle=concat(repeattitle1-repeattitle10), p(".")
forvalues i=1/99 {
replace temp_repeattitle=substr(temp_repeattitle,1,strlen(temp_repeattitle)-1) if substr(temp_repeattitle,strlen(temp_repeattitle)-1,1)=="."
}
egen repeattitle=concat(temp_repeattitle label), p(" ")
*drop temp_repeattitle
*drop label

save"repeats_wide_v4", replace

****************************************
* END







****************************************
* FINAL: REPEATS
****************************************

forvalues i=1/10{
use"temp_rep`i'", clear
rename repeatname repeatname`i'
rename title`i' repeattitle`i'
save"temp2_rep`i'", replace
}


use"repeats_wide_v4", replace
forvalues i=1/10{
merge m:1 repeattitle`i' using "temp2_rep`i'", keepusing(repeatname`i')
drop if _merge==2
drop _merge
}

sort n_survey1
drop repeattitle*

rename repeatname id
reshape long repeatname, i(id) j(nb)
keep if repeatname!=""
sort n_survey1 nb

* Count and relevance
gen temp_count="count:"
gen temp_rel="relevance:"

egen count=concat(temp_count repeat_count), p(" ")
egen rel=concat(temp_rel relevance), p(" ")
drop temp* repeat_count relevance

foreach x in label rel count {
replace `x'="" if nb!=repeatlevel
}

replace count="" if count=="count:"
*replace rel="" if rel=="relevance:"

rename rel label2

* Name
gen sign=">"
egen temp_name=concat(sign repeatname), p(" ")
sort n_survey1
replace repeatname=temp_name if nb==repeatlevel & repeatlevel>1
drop temp* sign


* N
clonevar n_survey=n_survey1
sencode id, gen(id2) gs(n_survey)
gen id3=strofreal(id2)
drop id id2
destring id3, gen(id)
drop id3


* Reshape for relevance under label
rename label label1
reshape long label, i(id nb) j(nbn)
drop if label=="relevance:"
drop if nbn==2 & label==""
replace repeatname="" if nbn==2



***** Make the data lighter
gen hide="repeat"
gen r="rep."
rename repeatname name
keep id hide nb nbn repeatlevel n_survey1 n_survey2 n_survey r name label count
order id nb nbn hide repeatlevel n_survey1 n_survey2 n_survey r name label count
sort n_survey nb nbn
drop id n_survey1 n_survey2 

***** Final format
order n_survey hide r name label count
rename nb repeat_nb
rename nbn repeat_nb2
rename repeatlevel repeat_level

bysort n_survey (repeat_nb repeat_nb2): gen n_survey_p=_n
order n_survey n_survey_p
sort n_survey n_survey_p
replace r="" if n_survey_p==2
replace r="" if n_survey_p==3


save"repeats_final.dta", replace
****************************************
* END
