use "C:\Users\Elena\Documents\these\neemsis\interest2\NEEMSIS-loans_mainloans_arnaud.dta", clear
drop if loanid==.
save "C:\Users\Elena\Documents\these\neemsis\interest2\NEEMSIS-loans_mainloans_arnaud.dta", replace

use "C:\Users\Elena\Documents\these\neemsis\interest2\ALL-LOANS.dta", clear
keep parent_key namenumber loanid months loan_months hh_inc_i hh_tot_income2
merge 1:1 parent_key namenumber loanid using "C:\Users\Elena\Documents\these\neemsis\interest2\NEEMSIS-loans_mainloans_arnaud.dta"
keep if _merge==3
drop _merge


*Mettre missings à la place de 66
replace interestpaid=. if interestpaid==66
replace principalpaid=. if principalpaid==66 
replace totalrepaid=. if totalrepaid==66
*Imputer valeur du total aux interets si il y a des interets, qui sont en miss et que le principale=0
replace interestpaid=totalrepaid if dummyinterest==1 & interestpaid==. & totalrepaid!=. & principalpaid==0
*Imputer val de la diff entre tot et principale au int si ils y a des int et qu'ils sont en .
replace interestpaid=totalrepaid-principalpaid if dummyinterest==1 & interestpaid==.
*La même que précédemment avec le principal
replace principalpaid=totalrepaid-interestpaid if principalpaid==.
*Si miss pour principal.. c'est juste qu'ils n'ont pas commencé à remb si le prêt a été contracté le mois de l'enquête
replace principalpaid=0 if principalpaid==. & submissiondate_month==loandate_month & submissiondate_year==loandate_year 
replace interestpaid=0 if interestpaid==. & dummyinterest==1 & submissiondate_month==loandate_month & submissiondate_year==loandate_year 
replace totalrepaid=0 if totalrepaid==. & submissiondate_month==loandate_month & submissiondate_year==loandate_year 



**** variable duration ELENA + income (annualincome+pensions+remittances) ELENA
preserve
gen 	loanrepay=(totalrepaid/loan_months)*12 	if loan_months>12
replace	loanrepay=totalrepaid 	if loan_months<=12
***********					
keep if lendersex!=.
collapse (sum) loanrepay (mean) hh_tot_inc, by(parent_key)
*J'enlève les revenus à moins de 5000 rs (même 10 000 je pense, mais je reste sur 5000 quand même)
drop if hh_tot_inc<=5000
gen DSR=(loanrepay/hh_tot_inc)*100
tabstat DSR, stat(n mean sd min max q)
restore

/*

    variable |         N      mean        sd       min       max       p25       p50       p75
-------------+--------------------------------------------------------------------------------
         DSR |       445   37.1539  52.27866         0  334.6963  6.329114  18.88172  42.76579
----------------------------------------------------------------------------------------------

*/



**** Variable duration ELENA + income ARNAUD
preserve
gen 	loanrepay=(totalrepaid/loan_months)*12 	if loan_months>12
replace	loanrepay=totalrepaid 	if loan_months<=12			
keep if lendersex!=.
collapse (sum) loanrepay (mean) HH_annualincome, by(parent_key)
*J'enlève les revenus à moins de 5000 rs (même 10 000 je pense, mais je reste sur 5000 quand même)
drop if HH_annualincome<=5000
gen DSR=(loanrepay/HH_annualincome)*100
tabstat DSR, stat(n mean sd min max q)
restore
/*						
						
    variable |         N      mean        sd       min       max       p25       p50       p75
-------------+--------------------------------------------------------------------------------
         DSR |       444  41.13164  61.14349         0  419.5548  6.518651  20.30988  44.71484
----------------------------------------------------------------------------------------------

*/


****** variable duration ARNAUD (INVERSION /*) + income ARNAUD
preserve
*Weeks, and the rest in month..
gen		repayduration_month=repayduration2/4.3 	if repayduration1==1
replace	repayduration_month=repayduration2 		if repayduration1==2
replace repayduration_month=repayduration2*12	if repayduration1==3
replace repayduration_month=repayduration2*6 	if repayduration1==4
*If repay<duration, je l'utilise
gen		loanrepay_month=loanduration_month
replace	loanrepay_month=repayduration_month if repayduration_month<loanduration_month 	
***********
gen 	loanrepay=(totalrepaid/loanrepay_month)*12 	if loanrepay_month>12
replace	loanrepay=totalrepaid 	if loanrepay_month<=12
***********					
keep if lendersex!=.
collapse (sum) loanrepay (mean) HH_annualincome, by(parent_key)
*J'enlève les revenus à moins de 5000 rs (même 10 000 je pense, mais je reste sur 5000 quand même)
drop if HH_annualincome<=5000
gen DSR=(loanrepay/HH_annualincome)*100
tabstat DSR, stat(n mean sd min max q)
restore

/*
    variable |         N      mean        sd       min       max       p25       p50       p75
-------------+--------------------------------------------------------------------------------
         DSR |       444  41.16202  61.75631         0  419.5548   6.41072  19.64647  44.56238
----------------------------------------------------------------------------------------------


*/



****** variable duration ARNAUD + income ARNAUD
preserve
gen		repayduration_month=repayduration2*4.3 	if repayduration1==1
replace	repayduration_month=repayduration2 		if repayduration1==2
replace repayduration_month=repayduration2/12	if repayduration1==3
replace repayduration_month=repayduration2/6 	if repayduration1==4
*If repay<duration, je l'utilise
gen		loanrepay_month=loanduration_month
replace	loanrepay_month=repayduration_month if repayduration_month<loanduration_month 	
***********
gen 	loanrepay=(totalrepaid/loanrepay_month)*12 	if loanrepay_month>12
replace	loanrepay=totalrepaid 	if loanrepay_month<=12
***********					
keep if lendersex!=.
collapse (sum) loanrepay (mean) HH_annualincome, by(parent_key)
*J'enlève les revenus à moins de 5000 rs (même 10 000 je pense, mais je reste sur 5000 quand même)
drop if HH_annualincome<=5000
gen DSR=(loanrepay/HH_annualincome)*100
tabstat DSR, stat(n mean sd min max q)
/*


    variable |         N      mean        sd       min       max       p25       p50       p75
-------------+--------------------------------------------------------------------------------
         DSR |       444  43.42894  65.83295         0  419.5548   6.41072  20.16247  45.23896
----------------------------------------------------------------------------------------------

*/
restore

