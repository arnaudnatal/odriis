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

global dodir = "C:\Users\Arnaud\Documents\GitHub\odriis\Questionnaire"
global file "NEEMSIS_tracking_2022_v10_trans.xlsx"















****************************************
* APPEND
****************************************
use"questions_final", replace

append using "repeats_final"
append using "groups_final"

sort n_survey n_survey_p

global toexp hide n_survey n_survey_p t r name label value_num label_mod

export excel $toexp using "$dodir\XLSreadable.xlsx", firstrow(variables) replace




****************************************
* END
