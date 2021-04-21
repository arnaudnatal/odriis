/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
03/03/21
-----
-------------------------
*/


global directory = "C:\Users\Arnaud\Desktop\NEEMSIS1\DATA"
cd "$directory"

use"NEEMSIS1_v1.dta", clear
bysort HHID : gen n=_n
keep if n==1
keep HHID submissiondate
duplicates drop
save"NEEMSIS1_submissiondate.dta", replace

****************************************
* CLEANING
****************************************
use"NEEMSIS-loans_mainloans.dta", clear
rename parent_key HHID
merge m:1 HHID using "NEEMSIS1_submissiondate.dta"
keep if _merge==3  // 27 marriage loan to the bin but anyway
tabstat loanamount, stat(n mean sd p50) by(loanreasongiven)
save"NEEMSIS1_loan_v2.dta", replace

fre loansettled
drop if loansettled==1

*Loan duration
gen date=dofc(submissiondate)
format date %td
drop submissiondate
rename date submissiondate
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

*Other
egen loan_id=concat(HHID namenumber loanid), p({})
replace economic=1 	if loan_id=="uuid:0e0ee627-fa19-4c61-a9c4-cf84afbeecd4{}1{}1"  // 2 3 4 5 7 14 15 16 20 23 27 28 
replace economic=1 	if loan_id=="uuid:c54ffe33-2754-40cf-8eed-8770af2aaecd{}3{}1"  // 2 3 4 5 7 14 15 16 20 23 27 28 
replace economic=1 	if loan_id=="uuid:6bc67b6a-49ef-40ca-89f8-5442f14df1fb{}2{}3"  // 2 3 4 5 7 14 15 16 20 23 27 28 
replace economic=1 	if loan_id=="uuid:bb1bf1a0-5f1c-4070-9d32-b93b07f45e97{}1{}1"  // 2 3 4 5 7 14 15 16 20 23 27 28 
replace economic=1 	if loan_id=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185{}4{}8"  // 2 3 4 5 7 14 15 16 20 23 27 28 
replace economic=1 	if loan_id=="uuid:609efbfc-453a-48d6-a7c1-e7d35e57bfb8{}1{}6"  // 2 3 4 5 7 14 15 16 20 23 27 28 
replace economic=1 	if loan_id=="uuid:f20291ba-73ca-46d4-902c-40bab02e68ec{}1{}3"  // 2 3 4 5 7 14 15 16 20 23 27 28 
replace economic=1 	if loan_id=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb{}1{}2"  // 2 3 4 5 7 14 15 16 20 23 27 28 
replace economic=1 	if loan_id=="uuid:609efbfc-453a-48d6-a7c1-e7d35e57bfb8{}1{}7"  // 2 3 4 5 7 14 15 16 20 23 27 28 
replace economic=1 	if loan_id=="uuid:0e0ee627-fa19-4c61-a9c4-cf84afbeecd4{}1{}2"  // 2 3 4 5 7 14 15 16 20 23 27 28 
replace economic=1 	if loan_id=="uuid:6bc67b6a-49ef-40ca-89f8-5442f14df1fb{}2{}2"  // 2 3 4 5 7 14 15 16 20 23 27 28 
replace economic=1 	if loan_id=="uuid:72b2a3d4-01fc-4e07-b7c6-32a3c86ac31a{}3{}2"  // 2 3 4 5 7 14 15 16 20 23 27 28 
replace current=1 	if loan_id=="uuid:75d61016-374e-48fa-b53c-2b36b3408b52{}2{}1"  // 6 8 9 11 13 17 18 24 26 30
replace current=1 	if loan_id=="uuid:318a9c1c-e92a-4c81-bafe-eb1973e94702{}2{}1"  // 6 8 9 11 13 17 18 24 26 30
replace current=1 	if loan_id=="uuid:1f120ace-1042-4eec-a398-851491a11b30{}1{}4"  // 6 8 9 11 13 17 18 24 26 30
replace current=1 	if loan_id=="uuid:15a2311a-c10d-462d-8a50-29a67b91b739{}1{}1"  // 6 8 9 11 13 17 18 24 26 30
replace current=1 	if loan_id=="uuid:525b2bab-4c97-4479-b8d5-562e3880c56b{}1{}2"  // 6 8 9 11 13 17 18 24 26 30
replace current=1 	if loan_id=="uuid:0742a50d-0a67-46f7-ba6b-b65092b7761b{}4{}1"  // 6 8 9 11 13 17 18 24 26 30
replace current=1 	if loan_id=="uuid:75d61016-374e-48fa-b53c-2b36b3408b52{}1{}1"  // 6 8 9 11 13 17 18 24 26 30
replace current=1 	if loan_id=="uuid:63ad0082-190d-4924-b71c-e40ec4158604{}1{}1"  // 6 8 9 11 13 17 18 24 26 30
replace current=1 	if loan_id=="uuid:c9e92ee0-e449-4d35-ad60-2a3196ba4de6{}1{}2"  // 6 8 9 11 13 17 18 24 26 30
replace current=1 	if loan_id=="uuid:24b8133a-edef-46f2-8b3f-ec350c7b1632{}1{}1"  // 6 8 9 11 13 17 18 24 26 30
replace social=1 	if loan_id=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919{}1{}2"  // 1 19 25
replace social=1 	if loan_id=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919{}1{}3"  // 1 19 25 
replace social=1 	if loan_id=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919{}1{}4"  // 1 19 25 
replace house=1		if loan_id=="uuid:f313dd8b-1b26-4059-b40a-b101a0acfdcb{}1{}1"  // 22
save"NEEMSIS1_loan_v2.dta", replace
****************************************
* END






****************************************
* NEW LENDER VAR
****************************************
use "NEEMSIS1_loan_v2.dta", clear
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
label define lender2 1 "WKP" 2 "Relatives" 3 "Labour" 4 "Pawn broker" 5 "Shop keeper" 6 "Moneylenders" 7 "Friends" 8"SHG & grp fin" 9 "Banks", replace
label values lender2 lender2
fre lender2

*Including relationship to the lender
fre lenderrelation
gen lender3=lender2
replace lender3=2 if lenderrelation=="2" | lenderrelation=="2 3" | lenderrelation=="2 5"  // Relatives
replace lender3=3 if lenderrelation=="1" |lenderrelation=="1 5"| lenderrelation=="1 7" |lenderrelation=="1 8" | lenderrelation=="1 8 10" | lenderrelation=="1 9"  // labour
replace lender3=7 if lenderrelation=="10" | lenderrelation=="3 10"  // Friends
replace lender3=8 if lenderrelation=="11" | lenderrelation=="6"  // SHG & group finance
replace lender3=10 if lenderrelation=="5" | lenderrelation=="5 8"  // New var: Neighbor
label define lender3 1 "WKP" 2 "Relatives" 3 "Labour" 4 "Pawn broker" 5 "Shop keeper" 6 "Moneylenders" 7 "Friends" 8 "Microcredit" 9 "Bank" 10 "Neighbor"
label values lender3 lender3
tab lender3
*In tamil, microcredit = kuzukanam

*correction of the moneylenders category with info from the main loan variable "lendername" 
tab lendername
tab lendername if strpos(lendername, "finance")
tab lendername if strpos(lendername, "finence")
tab lendername if strpos(lendername, "Equidos")
tab lendername if strpos(lendername, "Equitos")
tab lendername if strpos(lendername, "Hdfc")
tab lendername if strpos(lendername, "HDFC")
tab lendername if strpos(lendername, "Ekvidas")
tab lendername if strpos(lendername, "Eqvidas")
tab lendername if strpos(lendername, "Bwda")
tab lendername if strpos(lendername, "Ujji")
gen lender4=lender3
replace lender4=8 if  lendername=="Ujjivan" | lendername=="Ujjivan finence" | lendername=="Ujjivan5" | lendername=="Baroda bank" | lendername=="Bwda finance" | lendername=="Bwda" | lendername=="Danalakshmi finance" | lendername=="Equitos finance" | lendername=="Equitos" | lendername=="Equidos" | lendername=="Ekvidas" | lendername=="Eqvidas"
replace lender4=8 if lendername=="Fin care" | lendername=="HDFC" | lendername=="Hdfc" | lendername=="Logu finance" | lendername=="Loki management" | lendername=="Muthood fincorp" | lendername=="Muthoot finance" | lendername=="Muthu  Finance" | lendername=="Pin care" | lendername=="Rbl (finance)" | lendername=="Sriram finance" | lendername=="Sriram fainance" 
replace lender4=8 if lendername=="Mahendra finance" | lendername=="Mahi ndra finance" 
replace lender4=1 if lendername=="Therinjavanga" 
replace lender4=8 if lendername=="Sundaram finance" |  lendername=="Mahi ndra financeQ" | lendername=="Maglir Mandram"
replace lender4=8 if lendername=="Muthu  Finance" |  lendername=="Logu finance" |  lendername=="Rbl (finance)" |  lendername=="Sriram finance" |  lendername=="Sundaram finance" 
label values lender4 lender3
label var lender4 "version def (lendername)"
tab lender4

save"NEEMSIS1_loan_v3.dta", replace
****************************************
* END




****************************************
* COHERENCE
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS1\DATA"
cd "$directory"
use"NEEMSIS1_loan_v3.dta", clear

*As Elena, for gold
replace loanbalance=loanamount if loandate==. & loanlender==6  & lenderfrom==.

*Marriage = no loanbalance so drop it..
drop if loandate==. & loanreasongiven==8 & loanbalance==.

*Loanbalance>loanamount ?
replace loanbalance=loanamount if loanbalance>loanamount

*66 as .
replace interestpaid=. if interestpaid==55 | interestpaid==66
replace principalpaid=. if principalpaid==55 | principalpaid==66 
replace totalrepaid=. if totalrepaid==66

***Priority to balance or priority to totalrepaid/interestpaid ?
*Test Balance
gen test=loanamount-loanbalance
tab test  // 38/1682 weird loan : 2.26%
drop test

*Test Paid
gen test=totalrepaid-interestpaid-principalpaid
tab test  // 36/710 weird loan : 5.07%
drop test
/*
Check with Isabelle and Elena, but i prefer to use balance as good measure instead of totalrepaid and interestpaid
*/

gen totalrepaid2=totalrepaid
gen interestpaid2=interestpaid
gen principalpaid2=loanamount-loanbalance

*Variable donc pour que le tout soit cohérent
replace totalrepaid2=principalpaid2+interestpaid

*Verif loans to main loans
gen test=totalrepaid2-totalrepaid
tab test // ok dans 82 % des cas donc ca passe !
drop test

*Coherence
gen coherence=loanamount-loanbalance-principalpaid2
tab coherence
drop coherence
gen coherence=totalrepaid2-principalpaid2-interestpaid2
tab coherence
drop coherence

save"NEEMSIS1_loan_v4.dta", replace
****************************************
* END





****************************************
* BALANCE
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS1\DATA"
cd "$directory"
use"NEEMSIS1_loan_v4.dta", clear

replace loanbalance=0 if loansettled==1


/*
*update loanbalance with principalpaid for microcredits (interest checked, plausible)
replace loanbalance=loanamount-principalpaid if lender4==8 & loanbalance>loanamount & loanbalance!=.
replace loanbalance=loanamount if loanbalance>loanamount & loanbalance!=. & principalpaid==. 

*verif balance
gen test=loanamount-principalpaid - loanbalance
tab test
* 0 :  89.3 %
*5.9% inf, 4.8% sup
tab lender4 if test!=0 & test!=.
*moitie de microcredit dans ceux qui ne matchent pas
drop test

*** loans with pb "identified" + POSITIVE AMOUNTS of principal paid different selon principal paid et loanbalance:
*apres check: on ne peut pas faire grand chose. considere que principalpaid prevaut sur loanbalance.
gen test=loanamount-principalpaid - loanbalance
replace loanbalance=loanamount - principalpaid if test!=0 & test!=.
replace loanbalance=0 if loanbalance<0
drop test
*/
save"NEEMSIS1_loan_v5.dta", replace
*************************************
*** END





****************************************
* ANNUALIZED
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS1\DATA"
cd "$directory"
use"NEEMSIS1_loan_v5.dta", clear

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
         WKP |       315  45.61875        30  1.499985  719.9999
   Relatives |       128  35.01362        25  .0033333       180
      Labour |        31  21.08602  21.66667         4        48
 Pawn broker |         1       100       100       100       100
 Shop keeper |         2        37        37        24        50
Moneylenders |        57  23.30901  11.57895        .5       300
     Friends |        13  29.46154        18         4        90
 Microcredit |       101  13.95773     9.152  .3073846        81
        Bank |        31  14.28145        11        .6        80
    Neighbor |        30  41.88889        28       1.5       144
-------------+--------------------------------------------------
       Total |       709  34.55579        21  .0033333  719.9999
----------------------------------------------------------------
*/

save"NEEMSIS1_loan_v6.dta", replace
*************************************
*** END



****************************************
* IMPUTATION
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS1\DATA"
cd "$directory"
use"NEEMSIS1_loan_v6.dta", clear
rename namenumber INDID
merge m:m HHID INDID using "NEEMSIS1_v2.dta", keepusing(totalincome_indiv totalincome_HH) keep(3) nogen

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
replace imp1_interest=0.233*loanamount if lender4==6 & loanduration<=365 & debt_service==.
replace imp1_interest=0.233*loanamount*365/loanduration if lender4==6 & loanduration>365 & debt_service==.
replace imp1_interest=0.139*loanamount if lender4==8 & loanduration<=365 & debt_service==.
replace imp1_interest=0.139*loanamount*365/loanduration if lender4==8 & loanduration>365 & debt_service==.
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
bysort HHID INDID: egen imp1_ds_tot=sum(imp1_debt_service)
bysort HHID INDID: egen imp1_is_tot=sum(imp1_interest_service)
bysort HHID INDID: egen loanamount_indiv=sum(loanamount)

gen IDR=imp1_is_tot*100/loanamount_indiv
gen DSDR=imp1_ds_tot*100/loanamount_indiv
gen DSR=imp1_ds_tot*100/totalincome_indiv
gen ISR=imp1_is_tot*100/totalincome_indiv

*HH
bysort HHID: egen imp1_ds_tot_HH=sum(imp1_debt_service)
bysort HHID: egen imp1_is_tot_HH=sum(imp1_interest_service)
bysort HHID: egen loanamount_HH=sum(loanamount)

gen DSR_HH=imp1_ds_tot_HH*100/totalincome_HH
gen ISR_HH=imp1_is_tot_HH*100/totalincome_HH
gen IDHDR=loanamount_indiv*100/loanamount_HH

*INDIV
preserve
bysort HHID INDID: gen n=_n
keep if n==1
drop n
tabstat IDHDR IDR DSDR DSR ISR, stat(n mean sd q) long
restore
/*
   stats |     IDHDR       IDR      DSDR       DSR       ISR
---------+--------------------------------------------------
       N |       899       899       899       800       800
    mean |  54.06007   6.93332  19.81267  118.2501  49.87713
      sd |  34.82267  10.19293  21.84914  320.2504  201.7869
     p25 |  19.35484         0         0  .1108033         0
     p50 |  54.04255         3  13.96846  27.27716  7.360399
     p75 |  89.79592  11.47333  30.84892  90.06361  33.33333
------------------------------------------------------------
*/

*HH
preserve
bysort HHID: gen n=_n
keep if n==1
drop n
tabstat DSR_HH ISR_HH, stat(n mean sd q min max) long
restore
/*
   stats |    DSR_HH    ISR_HH
---------+--------------------
       N |       485       485
    mean |  49.08616  21.96295
      sd |  85.73939  50.85665
     p25 |  8.547833  1.647682
     p50 |  22.72387  6.637197
     p75 |  53.30253  20.31799
     min |         0         0
     max |  1138.452  700.2764
------------------------------
*/

save"NEEMSIS1_loan_v7.dta", replace
*************************************
*** END




****************************************
* Other measure of debt
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS1\DATA"
cd "$directory"
use"NEEMSIS1_loan_v7.dta", clear

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
recode _temp (2=1) (3=1)
rename _temp PRdummy

*Help to settle loan
bysort HHID INDID: egen _temp=sum(dummyhelptosettleloan)
recode _temp (2=1) (3=1)
rename _temp HSdummy

*Interest
bysort HHID INDID: egen _temp=sum(dummyinterest)
recode _temp (2=1) (3=1)
rename _temp ILdummy

save"NEEMSIS1_loan_v8.dta", replace
*************************************
*** END




****************************************
* Individual level
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS1\DATA"
cd "$directory"
use"NEEMSIS1_loan_v8.dta", clear

bysort HHID INDID: gen n=_n
keep if n==1
drop n
keep HHID INDID imp1_ds_tot imp1_is_tot loanamount_indiv IDR DSDR DSR ISR IDHDR InfoDR FoDR IncDR NoincDR PRdummy HSdummy ILdummy

save"NEEMSIS1_loan_v8_indiv.dta", replace
*************************************
*** END




****************************************
* 
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS1\DATA"
cd "$directory"
