****************************************
* APPEND
****************************************
use"questions_final", replace

append using "repeats_final"
append using "groups_final"

sort n_survey n_survey_p

global toexp hide n_survey n_survey_p t r name label value_num label_mod

export excel $toexp using "$dodir\XLSreadable~$file.xlsx", firstrow(variables) replace

****************************************
* END
