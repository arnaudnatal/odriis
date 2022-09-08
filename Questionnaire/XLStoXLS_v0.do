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
rename type2 varlabel
save"survey", replace
clear all


********** CHOICES
import excel "$file", sheet("choices") firstrow allstring clear
keep list_name value label
drop if list_name==""
gen n_choices=_n
order n_choices
save"choices", replace
clear all

****************************************
* END




****************************************
* 
****************************************

**********
use"survey", clear
drop if type=="calculate"
