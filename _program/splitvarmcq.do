/*
Program that create dummy var from a MCQ variable
*/

program define splitvarmcq
	version 15.1
	args arg1 arg2
	
	* Attribution des noms
	local var="`arg1'"  // Variable à diviser
	local nc="`arg2'"  // Nb de modalités
	local gp=""  // Groupe de variable pour le bon ordre après
	
	* Début du prgm
	split `var', destring
	local nnv=`r(nvars)'  // On stock le nb de var créée

	* Vérifier les 66, 77, 88, 99
	foreach x in 66 77 88 99 {
	local count`x'=0
	forvalues j=1/`nnv' {
	if `var'`j'==`x' {
	local count`x'=`count'`x'+1 
	}
	}
	}
	
	* Faire les dummies
	forvalues i=1/`nc' {
	gen `var'_`i'=0 if `var'!=""
	}

	* Egal à 1 si présent
	forvalues i=1/`nc' {
	forvalues j=1/`nnv' {
	replace `var'_`i'=1 if `var'`j'==`i'
	label var `var'_`i' "`var'=`i'"
	label define pgyesno 0"No" 1"Yes", replace
	label values `var'_`i' pgyesno
	}
	loca gp="`gp'"+" `var'_`i'"
	}
	
	* Gérer les 66, 77, 88, 99
	foreach x in 66 77 88 99 {
	gen `var'_`x'=0 if `var'!=""
	}
	foreach x in 66 77 88 99 {
	forvalues j=1/`nnv' {
	replace `var'_`x'=1 if `var'`j'==`x'
	label define pgyesno 0"No" 1"Yes", replace
	label values `var'_`x' pgyesno
	}
	}
	
	* Supprimer et ordonner les variables
	forvalues j=1/`nnv' {
	drop `var'`j'	
	}
	order `gp' `var'_66 `var'_77 `var'_88 `var'_99, after(`var')
	
	* Supprimer les 66, 77, 88, 99 si nécessaire
	foreach x in 66 77 88 99 {
	qui sum `var'_`x'
	if `r(max)'==0 {
	drop `var'_`x'
	}
	}
end
