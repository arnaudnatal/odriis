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
* END