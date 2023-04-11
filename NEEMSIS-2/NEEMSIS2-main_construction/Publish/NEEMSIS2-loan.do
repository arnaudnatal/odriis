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
global dofile = "C:\Users\Arnaud\Documents\MEGA\Data\Publish\NEEMSIS-2"

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\Publish\NEEMSIS-2"
cd"$directory"





********** Drop var
use"NEEMSIS2-all_loans.dta", clear

drop version_HH sex caste jatis edulevel egoid year

drop loanamount2 loanamount3 interestpaid2 interestpaid3 loanbalance2 loanbalance3 totalrepaid2 totalrepaid3 principalpaid principalpaid2 principalpaid3 principalpaid4 duplicates duplicatestodrop th_interest loanlender_rec loanduration lender_cat reason_cat lender2 lender3 lender4 lender4_rec loanduration_month yratepaid monthlyinterestrate debt_service interest_service imp_principal imp1_interest imp1_totalrepaid_year imp1_debt_service imp1_interest_service dummymainloans loans_indiv loans_HH loanamount_indiv loanamount_HH imp1_ds_tot_indiv imp1_is_tot_indiv imp1_ds_tot_HH imp1_is_tot_HH


drop setofmarriagefinance setofmarriagegroup

drop parent_key

drop submissiondate

drop borrowerid borrowername nbloansbyborrower

drop mainloanid mainloanname

drop lenderscaste lendersex lenderoccup

drop loaninfo

drop lenderrelation lenderfrom



********** Drop rest from gold
fre rest
drop if rest==1
drop rest
drop if loan_database=="GOLD"
fre loan_database



********** Order
order HHID_panel INDID_panel loan_database loanid loanamount loandate loanreasongiven loanreasongiven2 loaneffectivereason loaneffectivereason2 loanotherreasongiven loanothereffectivereason loanlender lendername snmoneylenderdummyfam snmoneylenderfriend snmoneylenderwkp snmoneylenderlabourrelation snmoneylendersex snmoneylenderage snmoneylenderlabourtype snmoneylendercastes snmoneylendereduc snmoneylenderoccup snmoneylenderemployertype snmoneylenderoccupother snmoneylenderliving snmoneylenderruralurban snmoneylenderdistrict snmoneylenderlivingname snmoneylendercompared snmoneylenderduration snmoneylendermeet snmoneylendermeetfrequency snmoneylenderinvite snmoneylenderreciprocity1 snmoneylenderintimacy snmoneylenderphonenb snmoneylendermeetother otherlenderservices guarantee guaranteeother otherlenderservicesother guaranteetype loansettled dummyinterest interestpaid, first



********** DUplicates
duplicates report HHID_panel INDID_panel loan_database loanid



********** ID
merge m:m HHID_panel INDID_panel using "temp_NEEMSIS2-HHINDID", keepusing(HHID2020 INDID2020)
keep if _merge==3
drop _merge

order HHID2020 INDID2020
drop HHID_panel INDID_panel

duplicates report HHID2020 INDID2020 loan_database loanid




********** SAVE
save"Last\NEEMSIS2-loans_mainloans", replace
