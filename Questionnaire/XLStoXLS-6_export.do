****************************************
* APPEND
****************************************
use"questions_final", replace

append using "repeats_final"
append using "groups_final"
append using "notes_final"

sort n_survey n_survey_p

* Rep with text
replace r = "rep.: " if r=="rep."
egen namerep=concat(r name) if r=="rep.: "

replace name=namerep if r=="rep.: "
drop namerep
drop r
replace req="(req.)" if required=="yes"
drop required

replace label_mod=count if label_mod=="" & count!=""
drop count

drop repeat_nb repeat_nb2 repeat_level

order hide n_survey n_survey_p t name req multi label value_num label_mod

export excel using "$dodir\XLSreadable~$file.xlsx", firstrow(variables) replace

****************************************
* END
