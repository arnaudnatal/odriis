*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*XLSform to XLSquest
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\Questionnaire"

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\GitHub\odriis\Questionnaire\XLSform"
cd"$directory"

global file "NEEMSIS_tracking_2022_v10_trans.xlsx"






****************************************
* IMPORT: SURVEY
****************************************
import excel "$file", sheet("survey") firstrow allstring clear
keep type name label constraint relevance required calculation repeat_count
drop if type==""
gen n_survey=_n
order n_survey
*varlabel if one var
split type, p(" ")
order type1 type2, after(type)
replace type1="" if type=="begin group"
replace type2="" if type=="begin group"
replace type1="" if type=="end group"
replace type2="" if type=="end group"
replace type1="" if type=="begin repeat"
replace type2="" if type=="begin repeat"
replace type1="" if type=="end repeat"
replace type2="" if type=="end repeat"
replace type1="" if type1!="select_one" & type1!="select_multiple"
rename type2 list_name

gen groupname=""
replace groupname=name if type=="begin group"
replace groupname=name if type=="end group"

gen repeatname=""
replace repeatname=name if type=="begin repeat"
replace repeatname=name if type=="end repeat"

replace name="" if groupname!=""
replace name="" if repeatname!=""

gen notename=""
replace notename=name if type=="note"
replace name="" if notename!=""

*** Only select
preserve
keep if type1=="select_one" | type1=="select_multiple"
save"survey_select", replace
restore


*** Other quest
preserve
drop if type1=="select_one" | type1=="select_multiple"
keep if type=="date" | type=="geopoint" | type=="text" | type=="integer" | type=="decimal"
save"survey_othquest", replace
restore


*** Only other
preserve
drop if type1=="select_one" | type1=="select_multiple"
drop if type=="date" | type=="geopoint" | type=="text" | type=="integer" | type=="decimal"
save"survey_other", replace
restore

save"survey", replace
clear all
****************************************
* END










****************************************
* IMPORT: CHOICES
****************************************
import excel "$file", sheet("choices") firstrow allstring clear
keep list_name value label
drop if list_name==""

destring value, gen(value_num) force
sort list_name value_num
rename label label_mod

*** Num
preserve
drop if value_num==.
drop value
save"choices_num", replace
restore


*** Str
drop if value_num!=.
drop value_num
bysort list_name: gen value_num=_n
rename value value_str
order list_name value_num value_str 
save"choices_str", replace
clear all


***** Append
use"choices_num", clear
append using "choices_str"
sort list_name value_num

*** gen -666 to have all value + one + one
* one
bysort list_name: gen order=_n
by list_name: gen last=1 if _n==_N
expand 2 if last==1
bysort list_name (value_num) : replace value_num=-666 if _n==_N
replace label_mod="" if value_num==-666
replace value_str="" if value_num==-666
drop order last
sort list_name value_num

* one
/*
bysort list_name: gen order=_n
by list_name: gen last=1 if _n==_N
expand 2 if last==1
bysort list_name (value_num) : replace value_num=-999 if _n==_N
replace label_mod="" if value_num==-999
replace value_str="" if value_num==-999
drop order last
sort list_name value_num
*/
save"choices", replace

*** Reshape to merge without difficulties after
bysort list_name (value_num): gen n=_n
reshape wide value_num label_mod value_str, i(list_name) j(n)
save"choices_wide", replace
clear all

****************************************
* END












****************************************
* ADD ANSWERS WHEN NO DATACHOICELIST
****************************************
use"survey_select", clear

* Relevance below



merge m:1 list_name using "choices_wide"
drop if _merge==2
drop _merge

reshape long value_num label_mod value_str, i(name) j(n)
drop if value_num==.

append using "survey_othquest"
sort n_survey value_num

replace label="" if value_num>-666 & value_num!=.
replace name="" if value_num>-666 & value_num!=.

save"survey_question", replace

clear all
****************************************
* END















****************************************
* QUESTION
****************************************

use"survey_question", clear
rename type1 hide
replace hide=type if hide==""
gen t=""
gen r=""
bysort n_survey (value_num): gen n_survey_p=_n
replace value_num=. if value_num==-666

order hide n_survey n_survey_p t r name label value_num label_mod

drop n type constraint list_name required calculation repeat_count groupname repeatname notename value_str


rename label label1
gen rel="relevance:"
egen label2=concat(rel relevance), p(" ")
drop rel relevance

reshape long label, i(n_survey n_survey_p) j(new)
order hide n_survey n_survey_p new t r name label value_num label_mod
drop if label=="relevance:"

















****************************************
* NUMBERING GROUPS
****************************************
use"survey_other", clear

keep if type=="begin group" | type=="end group"
dropmiss, force
compress



********** Reshape wide to have one group per row
gen type_num=1 if type=="begin group"
replace type_num=2 if type=="end group"
keep n_survey groupname type_num
sort n_survey
reshape wide n_survey, i(groupname) j(type_num)



********** Intermediate storage
save"groups_wide.dta", replace



********** Generate first level of groups
* To initialize futures loops
use"groups_wide.dta", clear
* 9999 repetitions to drop until 9999 groups nested, one by one, to keep only the non-nested groups of the questionnaire and gen level1 var
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
save"temp_gp1.dta", replace
restore
save"temp_groups_wide.dta", replace

* Level1 id variable


********** Generate all others levels of groups
* Merge groups level that are already identified.
* Drop it from the analysis.
* Thus, base with new max level and sub level
* Run the previous code to keep the new max level group that I identify with new level var
* Then, append already identified groups level
* All in a loop: comme ca à chaque tour, ca ajoute les niveaux identifiés, que j'enlève pour n'avoir que les nouveaux à identifier (comme pour générer le niveau 1 précédent).
* Puis je les ajoute aux déjà identifiés.
* Petit à petit j'identifie tous les niveaux
forvalues j=2/10 {
use"groups_wide.dta", clear

* Merge groups that are already identified
merge 1:1 groupname using "temp_groups_wide.dta"
keep if _merge==1
drop _merge

* Loop to identify the new maximum level: deleting groups "one by one" (up to 9999 groups to be deleted, as previously
forvalues i = 1/99999 {
sort n_survey1
drop if n_survey1>n_survey1[_n-1] & n_survey2<n_survey2[_n-1]
}

* Gen new level id variable
gen level`j'=1
preserve
gen title`j'=_n
save"temp_gp`j'.dta", replace
restore

* Merge groups that are alread id to refresh the list and then allow the loop to delete a different level each time
append using "temp_groups_wide.dta"
sort n_survey1
order level`j', last
save"temp_groups_wide.dta", replace
}



********** Generate first level of title
* To initialize loop
use"temp_groups_wide.dta", clear
bysort level1 (n_survey1): gen title1=_n
replace title1=. if level1==.
sort n_survey1
replace title1=title1[_n-1] if title1[_n-1]!=. & title1==.
egen temp1=concat(title1), p(".")
save"groups_wide_v2.dta", replace



********** Generate all others variables of title
use"groups_wide_v2.dta", clear
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
order groupname n_survey* level* title*
sort n_survey1
preserve
gen level=.
forvalues i=1/10 {
replace level`i'=`i' if level`i'==1
replace level=level`i' if level`i'!=. & level==.
drop level`i'
rename title`i' grouptitle`i'
}
rename level grouplevel
save"groups_wide_v3.dta", replace
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
reshape long n_survey, i(groupname) j(type)
tostring type, replace
replace type="begin group" if type=="1"
replace type="end group" if type=="2"
sort n_survey
rename title grouptitle
rename level grouplevel
save"groups_long.dta", replace
****************************************
* END











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
* DESIGN: GROUPS
****************************************

********** Group
use"groups_wide_v3", clear
merge 1:m groupname using "survey_other", keepusing(type label relevance required)
keep if _merge==3
drop _merge
drop if type=="end group"
drop type
compress
sort n_survey1

* Gen group name
egen temp_grouptitle=concat(grouptitle1-grouptitle10), p(".")
forvalues i=1/99 {
replace temp_grouptitle=substr(temp_grouptitle,1,strlen(temp_grouptitle)-1) if substr(temp_grouptitle,strlen(temp_grouptitle)-1,1)=="."
}
egen grouptitle=concat(temp_grouptitle label), p(" ")
*drop temp_grouptitle
*drop label
save"groups_wide_v4", replace
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

save"repeats_final.dta", replace
****************************************
* END





****************************************
* FINAL: GROUPS
****************************************

use"groups_wide_v4", replace
keep if grouplevel<3
drop groupname*
drop grouptitle*
keep relevance required label temp_grouptitle n_survey1
rename temp_grouptitle t
rename n_survey1 n_survey
compress
order n_survey t label relevance required

rename label label1
gen rel="relevance:"
egen label2=concat(rel relevance), p(" ")
drop rel relevance
order label2, after(label1)

reshape long label, i(n_survey) j(group_nb)


replace t="" if group_nb==2
replace required="" if group_nb==2
replace label="" if label=="relevance:"
drop if label=="" & group_nb==2
gen hide="group"

rename group_nb n_survey_p

rename label name

save"groups_final.dta", replace
****************************************
* END
