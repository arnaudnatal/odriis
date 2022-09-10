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

* Check duplicates
preserve
duplicates report groupname type_num
duplicates list groupname type_num
restore

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
