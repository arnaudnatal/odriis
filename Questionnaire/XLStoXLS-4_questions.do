****************************************
* ADD ANSWERS
****************************************

use"choices_final", clear
bysort list_name (value_num): gen n=_n
reshape wide value_num label_mod value_str, i(list_name) j(n)
save"choices_wide", replace
clear all



use"survey_select", clear

preserve
* Relevance below
gen rel="relevance:"
egen label2=concat(rel relevance), p(" ")
rename label label1
reshape long label, i(n_survey) j(n_survey_p)
drop if label=="relevance:"
keep n_survey n_survey_p label
drop if n_survey_p==1
save"temp_rel_quest", replace
restore

drop rel relevance calculation constraint repeat_count groupname repeatname notename

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

* Relevance
append using "temp_rel_quest"

order n_survey n_survey_p
sort n_survey n_survey_p

replace n_survey_p=1 if n==1
replace n_survey_p=3 if n_survey_p==.

bysort n_survey (n_survey_p n): gen n_survey_pp=_n
drop n_survey_p
rename n_survey_pp n_survey_p
order n_survey n_survey_p
sort n_survey n_survey_p

replace value_num=. if value_num==-666

order hide n_survey n_survey_p t r name label value_num label_mod

sort n_survey n_survey_p

* ID for multiple answer
gen multi=""
replace multi="-(multi.)" if hide=="select_multiple"
replace multi="" if name==""

* Replace type of quest when relevance
forvalues i=1/20{
bysort n_survey: replace hide=hide[_n-1] if hide=="" & hide[_n-1]!=""
}

* Required
fre required
gen req=""
replace req="(req.)" if required=="yes"
replace req="" if name==""

drop n type constraint list_name required calculation repeat_count groupname repeatname notename value_str relevance

save"questions_final", replace
****************************************
* END
