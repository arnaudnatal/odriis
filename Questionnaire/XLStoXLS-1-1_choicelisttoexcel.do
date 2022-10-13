****************************************
* IMPORT: DATACHOICELIST
****************************************

********** List for real label used
use"choices_final", clear
drop value_num
keep if value_str!=""
dropmiss, force

rename value_str _var1
rename label_mod _var2

reshape long _var, i(list_name) j(n)
rename _var _var1
gen tokeep=1
save"modtokeep", replace


* Change col and row of label for future merge
import delimited "$dodir\\$choicelist", delimiter(comma) clear varnames(nonames) 
sxpose, clear
save"data_sxpose", replace

merge 1:m _var1 using "modtokeep"
drop if _merge==1
list _var1 if _merge==2
keep if _merge==3
drop _merge

order list_name n tokeep
sort list_name n
tostring n tokeep, replace

forvalues i=1/2734{
rename _var`i' var`i'
}
sxpose, clear
save"temp", replace


* One base with 2 var
use"temp", clear
forvalues i=1(2)302 {
local j=`i'+1

preserve
keep _var`i' _var`j'
drop if _var`i'==""
gen n=_n
drop if n<=3

rename _var`i' var`i'
rename _var`j' var`j'
gen value_str=var`i' if n==4
replace value_str=value_str[_n-1] if value_str=="" & value_str[_n-1]!=""
drop if n==4
drop n
rename var`i' var1
rename var`j' var2
order value_str var1 var2
save"v`i'", replace
restore
}



* Append all
use "v1", clear

forvalues i=1(2)302 {
append using "v`i'"
}

duplicates drop
destring var1, replace
sort value_str var1
rename var2 label_mod
rename var1 value_num

*Reshape
reshape wide label_mod, i(value_str) j(value_num)

save"choicelist_clean", replace

use"choicelist_clean", clear



********** Merge choice list clean with choices
use"choices_final", clear

replace value_num=. if value_str!=""
replace label_mod="" if value_str!=""

keep if value_str!=""
duplicates drop
merge m:1 value_str using "choicelist_clean"
drop _merge
dropmiss, force

reshape long label_mod, i(list_name) j(value_num)
drop if label_mod==""

order list_name value_str value_num label_mod

save "choices_list", replace



********** Add choice that are already read
use"choices_final", clear

drop if value_str!=""
order list_name value_str value_num label_mod
append using "choices_list"

sort list_name value_num

save"choices_final", replace

****************************************
* END
