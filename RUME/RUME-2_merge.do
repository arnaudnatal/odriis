cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
16/04/2021
-----
TITLE: RUME

-------------------------
*/




****************************************
* INITIALIZATION
****************************************
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\Data_RUME\DATA"
cd "$directory"
****************************************
* END








****************************************
* Merge all
****************************************
cd "$directory\dta"

********** Indiv level
use"B_family", clear
merge 1:1 HHID2010 INDID2010 using "B_pubservwork"

merge 1:1 HHID2010 INDID2010 using "B_memberships"

merge 1:1 HHID2010 INDID2010 using "B_membershipsasso"

merge 1:1 HHID2010 INDID2010 using "B_lendtoother"

merge 1:1 HHID2010 INDID2010 using "B_chit"

merge 1:1 HHID2010 INDID2010 using "B_savings"

merge 1:1 HHID2010 INDID2010 using "B_insurance"


********** HH
use"B_intro", clear
merge 1:1 HHID2010 using "B_expenses"
drop _merge

merge 1:1 HHID2010 using "B_creditproduct"
drop _merge

merge 1:1 HHID2010 using "B_givenreco"

merge 1:1 HHID2010 using "B_receivedreco"

merge 1:1 HHID2010 using "B_gold"

merge 1:1 HHID2010 using "B_house"

merge 1:1 HHID2010 using "B_otherfacilities"

merge 1:1 HHID2010 using "B_livestock"

merge 1:1 HHID2010 using "B_land"

merge 1:1 HHID2010 using "B_crops"

merge 1:1 HHID2010 using "B_landpurchlease"



********** Occupations
use"B_occupations", clear





********** Loans
use"B_loans", clear

merge 1:1 HHID2010 loanid using "B_mainloans"



********** Lenders
use"B_lenders", clear






****************************************
* END