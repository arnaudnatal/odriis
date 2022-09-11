****************************************
* NOTES
****************************************
use"survey_other", clear

keep if type=="note"
dropmiss, force
compress

keep n_survey type label

rename type name
replace name="-note-"

gen hide="note"

save"notes_final.dta", replace
****************************************
* END
