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



****************************************
* END





*2nd test
tostring value_num, replace
egen rep=concat(value_num label_mod), p(" - ")
replace rep="" if rep==". -"
replace label=rep if rep!="" & multi==""
replace label=label_mod if hide=="repeat"
replace hide="_moda" if rep!="" & hide!="repeat"

drop n_survey n_survey_p rep label_mod value_num

gen n=_n
order hide n
export excel using "$dodir\XLSreadable~$file.xlsx", firstrow(variables) replace
