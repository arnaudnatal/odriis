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




****************************************
* INITIALIZATION
****************************************
global file "NEEMSIS_tracking_2022_v10_trans.xlsx"
****************************************
* END






****************************************
* IMPORT
****************************************

********** SURVEY
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



********** CHOICES
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

*** gen -666 to have all value + one
bysort list_name: gen order=_n
by list_name: gen last=1 if _n==_N
expand 2 if last==1
bysort list_name (value_num) : replace value_num=-666 if _n==_N
replace label_mod="" if value_num==-666
replace value_str="" if value_num==-666
drop order last
sort list_name value_num
save"choices", replace

*** Reshape to merge without difficulties after
bysort list_name (value_num): gen n=_n
reshape wide value_num label_mod value_str, i(list_name) j(n)
save"choices_wide", replace
clear all

****************************************
* END







****************************************
* 
****************************************

********** Add mod
use"survey_select", clear

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





********** Numbering oth
use"survey_other", clear
drop required
drop if type=="calculate"
dropmiss, force
compress
gen t=""
order n_survey t type t groupname repeatname notename relevance repeat_count label



/*
Idée : Passer les groupes en wide pour avoir pour chaque groupe le coord de dép et celui d'arrivée
Pour ca replace begin group par 1
end group par 2
Puis concat groupname et label que j'encode ensuite
Puis reshape wide n_survey, i(encode) j(begin group end group)

Ensuite, créer autant de col que de groupe 
Puis si un groupe est dans un autre bah je rajoute un niveau de numérotation.....
*/



**********
keep name label value_num label_mod
replace value_num=. if value_num==-666
export excel using "XLSreadable.xlsx", sheetreplace firstrow(variables)

****************************************
* END
