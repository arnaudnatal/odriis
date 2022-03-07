cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
16/12/2021
-----
TITLE: Cleaning

-------------------------
*/



****************************************
* INITIALIZATION
****************************************

global directory = "C:\Users\Arnaud\Documents\_Thesis\_DATA\RUME"
cd "$directory"
****************************************
* END













****************************************
* Clean HH
****************************************
use "RUME-HH_v8", replace


*** Recodage Sex relationship
br if HHID2010=="VENGP179"
fre sex relationshiptohead
replace sex=1 if HHID2010=="VENGP179" & name=="THAMIZH"
replace relationshiptohead=5 if HHID2010=="VENGP179" & name=="THAMIZH"

*** Label sex
label define sex 1"Male" 2"Female"
label values sex sex
fre sex


drop jobinc_HH_agri jobinc_HH_coolie jobinc_HH_agricoolie jobinc_HH_nregs jobinc_HH_invest jobinc_HH_employee jobinc_HH_selfemp jobinc_HH_pension jobinc_indiv_agri jobinc_indiv_coolie jobinc_indiv_agricoolie jobinc_indiv_nregs jobinc_indiv_invest jobinc_indiv_employee jobinc_indiv_selfemp jobinc_indiv_pension assets1000 assets_noland1000



global arnaud assets assets_noland goodtotalamount amountownlanddry amountownlandwet amountownland caste edulevel goldquantityamount mainocc_job_indiv mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv occinc_indiv_agri occinc_indiv_agricasual occinc_indiv_nonagricasual occinc_indiv_nonagriregnonqual occinc_indiv_nonagriregqual occinc_indiv_selfemp occinc_indiv_nrega worker mainocc_job_HH mainocc_occupation_HH annualincome_HH nboccupation_HH occinc_HH_agri occinc_HH_agricasual occinc_HH_nonagricasual occinc_HH_nonagriregnonqual occinc_HH_nonagriregqual occinc_HH_selfemp occinc_HH_nrega working_pop loans_HH loanamount_HH imp1_ds_tot_HH imp1_is_tot_HH jatis_codeRUME


foreach x in $arnaud {
label var `x' "Construction -- Arnaud"
}

order $arnaud, last

save "RUME-HH_v9", replace
save "CLEAN\RUME-HH", replace
****************************************
* END







****************************************
* Loan
****************************************
use "RUME-loans_v10.dta", clear
drop annualincome_HH

save"CLEAN\RUME-all_loans.dta", replace
clear all
****************************************
* END
