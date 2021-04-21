/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
16/04/21
-----


description: 	Réunir tous les prêts dans la même base
-------------------------
*/


global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS1\DATA"

cd "$directory"

****************************************
* FINANCE
****************************************
use"NEEMSIS-loans_mainloans.dta", clear
drop HHID interviewplace
order HHID2010, first
recode dummydemonetisation (.=0)
mdesc
gen loan_database="FINANCE"
save "NEEMSIS-loans_mainloans_v2.dta", replace
****************************************
* END





****************************************
* GOLD
****************************************
use "NEEMSIS-HH.dta", clear
keep HHID2010 dummynewHH dummydemonetisation INDID2010 egoid name submissiondate goldamountpledge goldreasonpledge interviewplace caste sex age
gen loan_database="GOLD"

rename goldamountpledge loanamount
rename goldreasonpledge loanreasongiven
gen loanlender=6

keep if loanamount!=.

split loanreasongiven
destring loanreasongiven*, replace
tab loanreasongiven1 if loanreasongiven2==.

tab loanreasongiven if loanreasongiven2!=. & loanreasongiven3==.
tab loanreasongiven if loanreasongiven3!=. & loanreasongiven4==.


gen loanreasongivenOK=loanreasongiven1 if loanreasongiven2==.  // try to add loans 
replace loanreasongivenOK=loanreasongiven2 if loanreasongiven1==2 & loanreasongiven2==3 & loanreasongiven3==.  // 12
replace loanreasongivenOK=loanreasongiven2 if loanreasongiven1==2 & loanreasongiven2==4 & loanreasongiven3==.  // 9
replace loanreasongivenOK=loanreasongiven2 if loanreasongiven1==2 & loanreasongiven2==5 & loanreasongiven3==.  // 6
replace loanreasongivenOK=loanreasongiven2 if loanreasongiven1==2 & loanreasongiven2==7 & loanreasongiven3==.  // 11
replace loanreasongivenOK=loanreasongiven2 if loanreasongiven1==2 & loanreasongiven2==8 & loanreasongiven3==.  // 4
replace loanreasongivenOK=loanreasongiven2 if loanreasongiven1==2 & loanreasongiven2==9 & loanreasongiven3==.  // 10
replace loanreasongivenOK=loanreasongiven2 if loanreasongiven1==2 & loanreasongiven2==10 & loanreasongiven3==.  // 3
replace loanreasongivenOK=loanreasongiven2 if loanreasongiven1==2 & loanreasongiven2==11 & loanreasongiven3==.  // 2
replace loanreasongivenOK=loanreasongiven1 if loanreasongiven1==7 & loanreasongiven2==12 & loanreasongiven3==.  // 1
replace loanreasongivenOK=loanreasongiven1 if loanreasongiven1==1 & loanreasongiven2==2 & loanreasongiven3==.  // 4
replace loanreasongivenOK=loanreasongiven2 if loanreasongiven1==3 & loanreasongiven2==7 & loanreasongiven3==.  // 4
replace loanreasongivenOK=loanreasongiven3 if loanreasongiven1==2 & loanreasongiven2==3 & loanreasongiven3==4 & loanreasongiven4==.  // 4

tab loanreasongivenOK, m
tab loanreasongiven if loanreasongivenOK==.
replace loanreasongivenOK=1 if loanreasongiven=="1 2 3"
replace loanreasongivenOK=1 if loanreasongiven=="1 2 3 5"
replace loanreasongivenOK=2 if loanreasongiven=="1 2 3 7 10"
replace loanreasongivenOK=4 if loanreasongiven=="1 2 4"
replace loanreasongivenOK=4 if loanreasongiven=="1 2 4 10 11"
replace loanreasongivenOK=1 if loanreasongiven=="1 2 5"
replace loanreasongivenOK=8 if loanreasongiven=="1 2 5 8"
replace loanreasongivenOK=7 if loanreasongiven=="1 2 7"
replace loanreasongivenOK=9 if loanreasongiven=="1 2 9"
replace loanreasongivenOK=10 if loanreasongiven=="1 2 9 10 11"
replace loanreasongivenOK=1 if loanreasongiven=="1 3 5 7"
replace loanreasongivenOK=1 if loanreasongiven=="1 5"
replace loanreasongivenOK=1 if loanreasongiven=="1 5 9"
replace loanreasongivenOK=6 if loanreasongiven=="1 6"
replace loanreasongivenOK=8 if loanreasongiven=="1 8"
replace loanreasongivenOK=1 if loanreasongiven=="1 9"
replace loanreasongivenOK=2 if loanreasongiven1==2 & loanreasongivenOK==.
replace loanreasongivenOK=3 if loanreasongiven1==3 & loanreasongivenOK==.
replace loanreasongivenOK=4 if loanreasongiven1==4 & loanreasongivenOK==.
replace loanreasongivenOK=5 if loanreasongiven1==5 & loanreasongivenOK==.
replace loanreasongivenOK=6 if loanreasongiven1==6 & loanreasongivenOK==.
replace loanreasongivenOK=7 if loanreasongiven1==7 & loanreasongivenOK==.

drop loanreasongiven1 loanreasongiven2 loanreasongiven3 loanreasongiven4 loanreasongiven5 loanreasongiven6 loanreasongiven

rename loanreasongivenOK loanreasongiven


*String and effective
clonevar loaneffectivereason=loanreasongiven
tostring loaneffectivereason, replace


recode dummydemonetisation (.=0)
mdesc
drop interviewplace
append using "NEEMSIS-loans_mainloans_v2.dta"
mdesc
save "NEEMSIS-loans_mainloans_v3.dta", replace
****************************************
* END




****************************************
* MARRIAGE
****************************************
use "NEEMSIS-HH.dta", clear
keep HHID2010 dummynewHH dummydemonetisation INDID2010 egoid name submissiondate marriageloanamount_wellknown marriageloanamount_banks marriageloanamount_coopbanks marriageloanamount_relatives marriageloanamount_employer marriageloanamount_maistry marriageloanamount_colleagues marriageloanamount_pawnbroker marriageloanamount_monlender marriageloanamount_friends  caste sex age
gen loan_database="MARRIAGE"

gen loanamount1=marriageloanamount_wellknown
gen loanreasongiven1=8 if loanamount1!=.
gen loanlender1=1 if loanamount1!=.

gen loanamount2=marriageloanamount_relatives
gen loanreasongiven2=8 if loanamount2!=.
gen loanlender2=2 if loanamount2!=.

gen loanamount3=marriageloanamount_employer
gen loanreasongiven3=8 if loanamount3!=.
gen loanlender3=3 if loanamount3!=.

gen loanamount4=marriageloanamount_maistry
gen loanreasongiven4=8 if loanamount4!=.
gen loanlender4=4 if loanamount4!=.

gen loanamount5=marriageloanamount_colleagues
gen loanreasongiven5=8 if loanamount5!=.
gen loanlender5=5 if loanamount5!=.

gen loanamount6=marriageloanamount_pawnbroker
gen loanreasongiven6=8 if loanamount6!=.
gen loanlender6=6 if loanamount6!=.

gen loanamount7=marriageloanamount_monlender
gen loanreasongiven7=8 if loanamount7!=.
gen loanlender7=8 if loanamount7!=.

gen loanamount8=marriageloanamount_friends
gen loanreasongiven8=8 if loanamount8!=.
gen loanlender8=9 if loanamount8!=.

gen loanamount9=marriageloanamount_banks
gen loanreasongiven9=8 if loanamount9!=.
gen loanlender9=11 if loanamount9!=.

gen loanamount10=marriageloanamount_coopbanks
gen loanreasongiven10=8 if loanamount10!=.
gen loanlender10=12 if loanamount10!=.

gen modmar=1 if loanreasongiven1==8
foreach num of numlist 2(1)10{
replace modmar=1 if loanreasongiven`num'==8
}

drop marriageloanamount_wellknown marriageloanamount_banks marriageloanamount_coopbanks marriageloanamount_relatives marriageloanamount_employer marriageloanamount_maistry marriageloanamount_colleagues marriageloanamount_pawnbroker marriageloanamount_monlender marriageloanamount_friends


reshape long loanamount loanreasongiven loanlender, i(INDID2010)  j(num)
keep if loanamount!=.
drop modmar

clonevar loaneffectivereason=loanreasongiven
tostring loaneffectivereason, replace

append using "NEEMSIS-loans_mainloans_v3.dta"

gen year=2016

save "NEEMSIS-loans_mainloans_v4.dta", replace
****************************************
* END





****************************************
* INDIV & HH level
****************************************
use"NEEMSIS-loans_mainloans_v4.dta", clear

fre loan_database
replace loansettled=0 if loan_database=="GOLD"
replace loansettled=1 if loan_database=="MARRIAGE"

*Conditions
drop if loansettled==1

*Total loan amount
bysort INDID2010: egen totalloanamount_indiv=sum(loanamount)

*Number of loans
gen nbloans=1
bysort INDID2010: egen totalnumberloans_indiv=sum(nbloans)
drop nbloans

*Total loan balance
bysort INDID2010: egen totalloanbalance_indiv=sum(loanbalance)

*Keep HH level variables
bysort INDID2010: gen n=_n
keep if n==1
keep INDID2010 totalloanamount_indiv totalnumberloans_indiv totalloanbalance_indiv

save"NEEMSIS-loans_mainloans_v4_indiv.dta", replace


*Merge with HH base
use"NEEMSIS-HH_v6.dta", clear

merge m:1 INDID2010 using "NEEMSIS-loans_mainloans_v4_indiv.dta"
drop _merge

*HH level
bysort HHID2010: egen totalloanamount=sum(totalloanamount_indiv)
bysort HHID2010: egen totalnumberloans=sum(totalnumberloans_indiv)
bysort HHID2010: egen totalloanbalance=sum(totalloanbalance_indiv)


save"NEEMSIS-HH_v6_loans.dta", replace
****************************************
* END










/*
****************************************
* CLEANING 2
****************************************
use"NEEMSIS2_loan_v4.dta", clear
fre loansettled
drop if loansettled==1  // 440 + 18 gold

*Loan duration
gen loanduration=submissiondate-loandate

*Type of loan
gen informal=.
gen semiformal=.
gen formal=.
foreach i in 1 2 3 4 5 7 9 13{
replace informal=1 if loanlender==`i'
}
foreach i in 6 10{
replace semiformal=1 if loanlender==`i'
}
foreach i in 8 11 12 14{
replace formal=1 if loanlender==`i'
}

*Purpose of loan
replace loanreasongiven=loanreasongiven2 if loanreasongiven==. & loanreasongiven2!=.

label define loanreasongiven 1"Agriculture" 2"Family" 3"Health" 4"Repay previous loan" 5"House expenses" 6"Investment" 7"Ceremonies" 8"Marriage" 9"Education" 10"Relatives" 11"Death" 12"No reason" 77"Other"
label values loanreasongiven loanreasongiven
tab loanreasongiven

gen economic=.
gen current=.
gen humancap=.
gen social=.
gen house=.
foreach i in 1 6{
replace economic=1 if loanreasongiven==`i'
}
foreach i in 2 4 10{
replace current=1 if loanreasongiven==`i'
}
foreach i in 3 9{
replace humancap=1 if loanreasongiven==`i'
}
foreach i in 7 8 11{
replace social=1 if loanreasongiven==`i'
}
foreach i in 5{
replace house=1 if loanreasongiven==`i'
}

*Verif
egen test=rowtotal(informal semiformal formal economic current humancap social house)
tab test
sort test
drop test

*Purpose of loan 2
gen incomegen=.
gen noincomegen=.
replace incomegen=1 if economic==1
replace noincomegen=1 if current==1 | humancap==1 | social==1 | house==1

*In amount
foreach x in economic current humancap social house incomegen noincomegen informal formal semiformal{
gen `x'_amount=loanamount if `x'==1
}

save"NEEMSIS2_loan_v5.dta", replace
****************************************
* END




global directory = "C:\Users\Arnaud\Desktop\NEEMSIS2\DATA\APPEND\CLEAN"
cd "$directory"
****************************************
* NEW LENDER VAR
****************************************
use "NEEMSIS2_loan_v5.dta", clear
fre loanlender
label define loanlender 1"WKP" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn Broker" 7"Shop keeper" 8"Finance (moneylenders)" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 14"Group finance" 15"Thandal"  // Thandal = daily finance; door to door; small amount; it mean "immediat" in tamil
label values loanlender loanlender
fre loanlender
*Recode loanlender pour que les intérêts soient plus justes
gen lender2=.
replace lender2=1 if loanlender==1
replace lender2=2 if loanlender==2
replace lender2=3 if loanlender==3 | loanlender==4 | loanlender==5  // labour relation 
replace lender2=4 if loanlender==6
replace lender2=5 if loanlender==7
replace lender2=6 if loanlender==8
replace lender2=7 if loanlender==9
replace lender2=8 if loanlender==10 | loanlender==14  // SHG & group finance
replace lender2=9 if loanlender==11 | loanlender==12 | loanlender==13  // bank & coop & sugar mill loan
replace lender2=10 if loanlender==15  // thandal
label define lender2 1 "WKP" 2 "Relatives" 3 "Labour" 4 "Pawn broker" 5 "Shop keeper" 6 "Moneylenders" 7 "Friends" 8"SHG & grp fin" 9 "Banks" 10"Thandal", replace
label values lender2 lender2
fre lender2

*Including relationship to the lender
gen lender3=lender2
replace lender3=1 if snmoneylenderwkp=="1"  // WKP
replace lender3=2 if snmoneylenderdummyfam=="1"  // Relatives
replace lender3=3 if snmoneylenderlabourrelation=="1"  // labour
replace lender3=7 if snmoneylenderfriend=="1"  // Friends
label define lender3 1 "WKP" 2 "Relatives" 3 "Labour" 4 "Pawn broker" 5 "Shop keeper" 6 "Moneylenders" 7 "Friends" 8 "Microcredit" 9 "Bank" 10 "Thandal"
label values lender3 lender3
tab lender3 lender2

*correction of the moneylenders category with info from the main loan variable "lendername" 
gen lender4=lender3
tab lendername
replace lender4=8 if strpos(lendername, "finance") & lendername!="Daily finance"
replace lender4=8 if strpos(lendername, "Finance")
replace lender4=8 if strpos(lendername, "Therinjavanga")
replace lender4=10 if strpos(lendername, "thandal")
 replace lender4=10 if strpos(lendername, "Thandal")
label values lender4 lender3
label var lender4 "version def (lendername)"
fre lender4

save "NEEMSIS2_loan_v6.dta", replace
****************************************
* END



****************************************
* COHERENCE
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS2\DATA\APPEND\CLEAN"
cd "$directory"
use"NEEMSIS2_loan_v6.dta", clear
*label define loanreasongiven 1"Agriculture" 2"Family expenses" 3"Health" 4"Repay previous" 5"House" 6"Investment" 7"Ceremonies" 8"Marriage" 9"Education" 10"Relatives" 11"Death" 12"No reason" 77"Other"
*label values loanreasongiven loanreasongiven
gen loanduration_month=loanduration/30.467
replace loanduration_month=1 if loanduration_month<1
tab loanduration_month

dropmiss, force

*As Elena, for gold
replace loanbalance=loanamount if loan_database=="GOLD"

*66 as .
replace interestpaid=. if interestpaid==55 | interestpaid==66
replace totalrepaid=. if totalrepaid==66
replace loanamount=. if loanamount==66
drop if loanamount==.

***Priority to balance or priority to totalrepaid/interestpaid ?
*Test Balance
gen test=loanamount-loanbalance
tab test  // 1/2228 weird loan : 0.04%
drop test

*Test Paid
gen test=totalrepaid-interestpaid
tab test  // 43/650 weird loan : 6.61%
drop test
/*
Check with Isabelle and Elena, but i prefer to use balance as good measure instead of totalrepaid and interestpaid
*/

*Cleaning for coherence
gen totalrepaid2=totalrepaid
gen interestpaid2=interestpaid
gen principalpaid=loanamount-loanbalance


*replace totalrepaid2=interestpaid if interestpaid>=totalrepaid

replace totalrepaid2=principalpaid+interestpaid // if interestpaid>=totalrepaid

*replace interestpaid2=totalrepaid-principalpaid if interestpaid<totalrepaid

*Coherence
gen coherence=loanamount-loanbalance-principalpaid
tab coherence
drop coherence
gen coherence=totalrepaid2-principalpaid-interestpaid2
tab coherence
drop coherence

save "NEEMSIS2_loan_v7.dta", replace
****************************************
* END



****************************************
* BALANCE
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS2\DATA\APPEND\CLEAN"
cd "$directory"
use"NEEMSIS2_loan_v7.dta", clear

replace loanbalance=0 if loansettled==1
/*
*update loanbalance with principalpaid for microcredits (interest checked, plausible)
replace loanbalance=loanamount-principalpaid if lender4==8 & loanbalance>loanamount & loanbalance!=.
replace loanbalance=loanamount if loanbalance>loanamount & loanbalance!=. & principalpaid==. 

*verif balance
gen test=loanamount-principalpaid - loanbalance
tab test
gen test2=test*100/loanamount
tab test2
* 0 :  55 %
*20% inf, 25% sup
tab lender4 if test!=0 & test!=.
*1/3 de microcredit dans ceux qui ne matchent pas
drop test

*** loans with pb "identified" + POSITIVE AMOUNTS of principal paid different selon principal paid et loanbalance:
*apres check: on ne peut pas faire grand chose. considere que principalpaid prevaut sur loanbalance.

gen test=loanamount-principalpaid - loanbalance
tab test
replace loanbalance=loanamount - principalpaid if test!=0 & test!=. &
drop test
gen test=loanamount-principalpaid - loanbalance
tab test
drop test

tab loanbalance
*/
save "NEEMSIS2_loan_v8.dta", replace
*************************************
*** END





****************************************
* ANNUALIZED
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS2\DATA\APPEND\CLEAN"
cd "$directory"
use"NEEMSIS2_loan_v8.dta", clear

*****
*Arnaud test yrate
gen yratepaid=interestpaid2*100/loanamount if loanduration<=365

gen _yratepaid=interestpaid2*365/loanduration if loanduration>365
gen _loanamount=loanamount*365/loanduration if loanduration>365

replace yratepaid=_yratepaid*100/_loanamount if loanduration>365
drop _loanamount _yratepaid

tab yratepaid
sort yratepaid
tab loanamount if loanamount<1000
drop if loanamount<1000

tabstat yratepaid if interestpaid2>0 & interestpaid2!=., by(lender4) stat(n mean p50 min max)
drop yratepaid
*****
/*
     lender4 |         N      mean       p50       min       max
-------------+--------------------------------------------------
         WKP |       136  40.39122        30  .8333333       600
   Relatives |        14  30.59562  23.33333         3        72
      Labour |        36  21.07407        20       2.4        50
 Pawn broker |         1       100       100       100       100
Moneylenders |         4      36.5        33        10        70
     Friends |       183  19.50317      13.5  .0057143       100
 Microcredit |       115  16.66142      12.4       .21  86.66667
        Bank |        30  19.52206  11.22056   .007875        60
     Thandal |        63  10.95765        10         2        60
-------------+--------------------------------------------------
       Total |       582  23.51778        15  .0057143       600
----------------------------------------------------------------
*/

save"NEEMSIS2_loan_v9.dta", replace
*************************************
*** END




****************************************
* IMPUTATION
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS2\DATA\APPEND\CLEAN"
cd "$directory"
use"NEEMSIS2_loan_v9.dta", clear
merge m:m HHID2010 INDID using "NEEMSIS_APPEND_v5.dta", keepusing(totalincome_indiv totalincome_HH) keep(3) nogen

*Debt service pour ML
gen debt_service=.
replace debt_service=totalrepaid2 if loanduration<=365
replace debt_service=totalrepaid2*365/loanduration if loanduration>365
replace debt_service=0 if loanduration==0 & totalrepaid2==0 | loanduration==0 & totalrepaid2==.

*Interest service pour ML
gen interest_service=.
replace interest_service=interestpaid2 if loanduration<=365
replace interest_service=interestpaid2*365/loanduration if loanduration>365
replace interest_service=0 if loanduration==0 & totalrepaid2==0 | loanduration==0 & totalrepaid2==.
replace interest_service=0 if dummyinterest==0 & interestpaid2==0 | dummyinterest==0 & interestpaid2==.

*Imputation du principal
gen imp_principal=.
replace imp_principal=loanamount-loanbalance if loanduration<=365 & debt_service==.
replace imp_principal=(loanamount-loanbalance)*365/loanduration if loanduration>365 & debt_service==.

*Imputation interest for moneylenders and microcredit
gen imp1_interest=.
replace imp1_interest=0.365*loanamount if lender4==6 & loanduration<=365 & debt_service==.
replace imp1_interest=0.365*loanamount*365/loanduration if lender4==6 & loanduration>365 & debt_service==.
replace imp1_interest=0.167*loanamount if lender4==8 & loanduration<=365 & debt_service==.
replace imp1_interest=0.167*loanamount*365/loanduration if lender4==8 & loanduration>365 & debt_service==.
replace imp1_interest=0 if lender4!=6 & lender4!=8 & debt_service==. & loandate!=.

*Imputation total
gen imp1_totalrepaid_year=imp_principal+imp1_interest

*Calcul service de la dette pour tout
gen imp1_debt_service=debt_service
replace imp1_debt_service=imp1_totalrepaid_year if debt_service==.

*Calcul service des interets pour tout
gen imp1_interest_service=interest_service
replace imp1_interest_service=imp1_interest if debt_service==.

*INDIV
bysort HHID2010 INDID: egen imp1_ds_tot=sum(imp1_debt_service)
bysort HHID2010 INDID: egen imp1_is_tot=sum(imp1_interest_service)
bysort HHID2010 INDID: egen loanamount_indiv=sum(loanamount)

gen IDR=imp1_is_tot*100/loanamount_indiv
gen DSDR=imp1_ds_tot*100/loanamount_indiv
gen DSR=imp1_ds_tot*100/totalincome_indiv
gen ISR=imp1_is_tot*100/totalincome_indiv

*HH
bysort HHID2010: egen imp1_ds_tot_HH=sum(imp1_debt_service)
bysort HHID2010: egen imp1_is_tot_HH=sum(imp1_interest_service)
bysort HHID2010: egen loanamount_HH=sum(loanamount)

gen DSR_HH=imp1_ds_tot_HH*100/totalincome_HH
gen ISR_HH=imp1_is_tot_HH*100/totalincome_HH
gen IDHDR=loanamount_indiv*100/loanamount_HH


*INDIV
preserve
bysort HHID2010 INDID: gen n=_n
keep if n==1
drop n
tabstat IDHDR IDR DSDR DSR ISR, stat(n mean sd q) long
restore
/*
   stats |     IDHDR       IDR      DSDR       DSR       ISR
---------+--------------------------------------------------
       N |       572       572       572       518       518
    mean |  51.22378  5.933965  17.02289  211.6141   79.0367
      sd |   33.1335  7.197055  16.19863  507.9003  305.2893
     p25 |   20.2916         0  1.757195   2.54902         0
     p50 |   49.3192  3.451605  14.42491  31.35456  7.051661
     p75 |  83.28344  10.05666  27.38868  185.1564  54.82353
------------------------------------------------------------
*/

*HH
preserve
bysort HHID2010: gen n=_n
keep if n==1
drop n
tabstat DSR_HH ISR_HH, stat(n mean sd q min max) long
restore
/*
   stats |    DSR_HH    ISR_HH
---------+--------------------
       N |       291       291
    mean |  90.72405  39.41052
      sd |  226.2905  165.0881
     p25 |  11.38461  1.075703
     p50 |  28.69775  8.805568
     p75 |  91.08466  26.37301
     min |         0         0
     max |  2984.689  2560.829
------------------------------
*/

save"NEEMSIS2_loan_v10.dta", replace
*************************************
*** END



****************************************
* Other measure
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS2\DATA\APPEND\CLEAN"
cd "$directory"
use"NEEMSIS2_loan_v10.dta", clear

rename HHID2010 HHID

*Informal debt ratio
bysort HHID INDID: egen _temp1=sum(informal_amount)
bysort HHID INDID: egen _temp2=sum(semiformal_amount)
gen InfoDR=(_temp1+_temp2)*100/loanamount_indiv
drop _temp1 _temp2

*Formal debt ratio
bysort HHID INDID: egen _temp=sum(formal_amount)
gen FoDR=_temp*100/loanamount_indiv
drop _temp

*Income gen debt ratio
bysort HHID INDID: egen _temp=sum(incomegen_amount)
gen IncDR=_temp*100/loanamount_indiv
drop _temp

*Non income gen debt ratio
bysort HHID INDID: egen _temp=sum(noincomegen_amount)
gen NoincDR=_temp*100/loanamount_indiv
drop _temp

*Problem to repay loan
bysort HHID INDID: egen _temp=sum(dummyproblemtorepay)
tab _temp
recode _temp (2=1) (3=1)
rename _temp PRdummy

*Help to settle loan
bysort HHID INDID: egen _temp=sum(dummyhelptosettleloan)
tab _temp
recode _temp (2=1) (3=1)
rename _temp HSdummy

*Interest
bysort HHID INDID: egen _temp=sum(dummyinterest)
tab _temp
forvalues i=1(1)11{
recode _temp (`i'=1)
}
tab _temp
rename _temp ILdummy

rename HHID HHID2010

save"NEEMSIS2_loan_v11.dta", replace
*************************************
*** END



****************************************
* Individual level
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS2\DATA\APPEND\CLEAN"
cd "$directory"
use"NEEMSIS2_loan_v11.dta", clear

bysort HHID2010 INDID: gen n=_n
keep if n==1
drop n
keep HHID2010 householdid2020 INDID imp1_ds_tot imp1_is_tot loanamount_indiv IDR DSDR DSR ISR IDHDR InfoDR FoDR IncDR NoincDR PRdummy HSdummy ILdummy

save"NEEMSIS2_loan_v11_indiv.dta", replace
*************************************
*** END



****************************************
* 
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS2\DATA\APPEND\CLEAN"
cd "$directory"
