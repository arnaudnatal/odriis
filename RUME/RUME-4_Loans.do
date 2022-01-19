cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
16/04/2021
-----
TITLE: All RUME loans

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
* Loans with mainloans
****************************************
use"RUME-loans.dta", clear

merge 1:1 HHID2010 loanid using "RUME-mainloans.dta"
drop _merge

save"RUME-loans_v2.dta", replace
****************************************
* END






****************************************
* Cleaning
****************************************
use"RUME-loans_v2.dta", clear
tab loanlender loanlender_code
/*
loanlender |         1          2          3 |     Total
-----------+---------------------------------+----------
         1 |       872          0          0 |       872 
         2 |       355          0          0 |       355 
         3 |       101          0          0 |       101 
         4 |        78          0          0 |        78 
         5 |        82          0          0 |        82 
         6 |         0        278          0 |       278 
         7 |        26          0          0 |        26 
         8 |         0        165          0 |       165 
         9 |       128          0          0 |       128 
        10 |         0          0        168 |       168 
        11 |         0          0         95 |        95 
        12 |         0          0         36 |        36 
        13 |         0          0         12 |        12 
-----------+---------------------------------+----------
     Total |     1,642        443        311 |     2,396 
*/
drop loanlender_code loanreasongiven_det  lenderrelation_relatives
drop v15
*Mains loans surtout
rename iresponsible_1 INDID_o
rename iresponsible_2 borrowername2 
rename iresponsible_3 borrowername3
rename mgetamountexpected amountexpected
rename nifnotamountreceived amountreceived
rename oremaining manageremaining
rename p1expensesbeforeloan expensesbeforeloan
rename p2expensesbeforeloan expensesbeforeloan2
rename q1repay plantorepay
rename q2repay plantorepay2
rename q3repay plantorepay3
rename rtimetogetcreditdays daytogetcredit
rename samounttogetcreditrs amounttogetcredit
rename ttimeyouwentcredit timewenttogetcredit
drop ucredittaken ucredittaken_month ucredittaken_year
rename vperiodbetweenaskandaccesscre daybetweendemandaccess
rename wduration durationbyborrower
rename xduration durationbylender
rename ytimetorepay repayduration2
rename zpaidinterest dummyinterest
rename aaifyesamount interestloan
rename abfrequency interestfrequency
rename acamountinterest interestpaid
rename adprincipalamountrepaid principalpaid
drop aecreditsettled 
rename af1needrecommendation dummyrecommendation
rename af2needguarantor dummyguarantor
rename ag1recommendationcaste recommenddetailscaste
rename ag2guarantorscaste guarantordetailscaste
rename ah1relationshipwithpersrecom recommendloanrelation
rename ah2relationshipwithguarantor guarantorloanrelation
rename ai1samepersrecommend sameothercreditrecommend
rename ai2samepersguarantor sameothercreditguarantor
rename ajusedocument dummydocument // à mélanger
rename akproductpledgedcode dummyproduct // à mélange avec dummydoc
rename akproductpledged productpledge
rename alvaluationofproductsrs amountproductpledge
rename amused dummyshgchittu // à mélanger avec dummyproduct
rename anusedshgas guaranteetype
rename aoamountprincipal repayprincipalamount
label var repayprincipal "How much do you have to pay towards interest and the principal amount?"
rename aointerest  repayinterest
label var repayinterest "How much do you have to pay towards interest and the principal amount?"
rename aoifyeshowmuch repayinterestamount
label var repayinterestamount "How much do you have to pay towards interest and the principal amount?"
rename apfrequency repayduration1
rename aqwhodecidesmanner repaydecide
rename artermsrepayment termsofrepayment
rename asproblem dummyproblemtorepay
rename atsoldproduct settleloanstrategy_prodamt  // settleloanstrategy
rename au1product settleloanstrategy_prod1
rename au2product settleloanstrategy_prod2
rename avamountrs settleloanstrategy_credit
rename awtakejob settleloanstrategy_job
rename awjob settleloanstrategy_jobdetails
rename ax1who settleloanstrategy_jobindiv1
rename ax2who settleloanstrategy_jobindiv2
rename ax3who settleloanstrategy_jobindiv3
rename ay1needsbdyworkmore helptosettleloan_Y1
rename ay2occupation helptosettleloan_Y2
rename az1who helptosettleloan_Z1
rename az2who helptosettleloan_Z2
rename az3who helptosettleloan_Z3
rename bamembershelp helptosettleloan_support
rename bbrelatives helptosettleloan_relasupport
rename bcdelay problemdelayrepayment
rename bdhappen happenlender
rename becreditfromsamepers creditfromsameperson

*Modif pour 2016
rename repayduration2 repayduration22
foreach x in lenderrelation otherlenderservices borrowerservices plantorepay problemdelayrepayment recommendloanrelation guarantorloanrelation{
tostring `x', replace
}


*Split loanid
split loanid, p(L)
drop loanid loanid1
rename loanid2 loanid
destring loanid, replace

order HHID2010 INDID_o loanid

save"RUME-loans_v3.dta", replace
****************************************
* END












****************************************
* CLEANING 2
****************************************
use "RUME-loans_v3.dta", clear


*Settled
*drop if loansettled==1

********** Submission darte
gen submissiondate=mdy(03,01,2010)
tab submissiondate
format submissiondate %d

*Loan duration
gen loanduration=submissiondate-loandate
replace loanduration=1 if loanduration<1

*** Type of loan
fre loanlender
gen lender_cat=.
label define lender_cat 1"Informal" 2"Semi formal" 3"Formal"
label values lender_cat lender_cat

foreach i in 1 2 3 4 5 7 9 13{
replace lender_cat=1 if loanlender==`i'
}
foreach i in 6 10 15{
replace lender_cat=2 if loanlender==`i'
}
foreach i in 8 11 12 14{
replace lender_cat=3 if loanlender==`i'
}
fre lender_cat



*** Purpose of loan
label define loanreasongiven 1"Agriculture" 2"Family" 3"Health" 4"Repay previous loan" 5"House expenses" 6"Investment" 7"Ceremonies" 8"Marriage" 9"Education" 10"Relatives" 11"Death" 12"No reason" 77"Other", replace
label values loanreasongiven loanreasongiven
tab loanreasongiven

fre loanreasongiven
gen reason_cat=.
label define reason_cat 1"Economic" 2"Current" 3"Human capital" 4"Social" 5"Housing" 6"No reason" 77"Other"
label values reason_cat reason_cat
foreach i in 1 6{
replace reason_cat=1 if loanreasongiven==`i'
}
foreach i in 2 4 10{
replace reason_cat=2 if loanreasongiven==`i'
}
foreach i in 3 9{
replace reason_cat=3 if loanreasongiven==`i'
}
foreach i in 7 8 11{
replace reason_cat=4 if loanreasongiven==`i'
}
replace reason_cat=5 if loanreasongiven==5
replace reason_cat=6 if loanreasongiven==12
replace reason_cat=77 if loanreasongiven==77

fre reason_cat

save"RUME-loans_v4.dta", replace
****************************************
* END














****************************************
* NEW LENDER VAR
****************************************
use "RUME-loans_v4.dta", clear
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
destring lenderrelation, replace
fre lenderrelation
label define lenderrelation 1"Colleague" 2"Relative" 3"Labour" 4"Political" 5"Religious" 6"Neighbour" 7"SHG member" 8"Businessman" 9"Therinjavanga" 10"Financial" 11"Bank" 12"DK him/her" 13"Traditional" 66"Irrelevant" 77"Other" 88"DK" 99"NR", replace
label values lenderrelation lenderrelation
fre lenderrelation
gen lender3=lender2
replace lender3=2 if lenderrelation==2  // Relatives
replace lender3=3 if lenderrelation==1 | lenderrelation==3  // Labour
replace lender3=8 if lenderrelation==7 | lenderrelation==10  // SHG & group finance
replace lender3=10 if lenderrelation==6  // New var: Neighbor
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

save "RUME-loans_v5.dta", replace
****************************************
* END


















****************************************
* COHERENCE
****************************************
use"RUME-loans_v5.dta", clear

*As Elena, for gold
replace loanbalance=loanamount if loandate==. & loanlender==6
*Marriage = no loanbalance so drop it..
*drop if loandate==. & loanreasongiven==8 & loanbalance==.


*Loanbalance>loanamount ?
replace loanbalance=loanamount if loanbalance>loanamount

*66 as .
replace interestpaid=. if interestpaid==55 | interestpaid==66
replace principalpaid=. if principalpaid==55 | principalpaid==66 
gen totalrepaid=interestpaid+principalpaid

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



save"RUME-loans_v6", replace
****************************************
* END














****************************************
* BALANCE
****************************************
use"RUME-loans_v6.dta", clear

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
save"RUME-loans_v7.dta", replace
*************************************
* END















****************************************
* ANNUALIZED
****************************************
use"RUME-loans_v7.dta", clear

*****
*Arnaud test yrate
gen yratepaid=interestpaid2*100/loanamount if loanduration<=365

gen _yratepaid=interestpaid2*365/loanduration if loanduration>365
gen _loanamount=loanamount*365/loanduration if loanduration>365

replace yratepaid=_yratepaid*100/_loanamount if loanduration>365
drop _loanamount _yratepaid

tab yratepaid
sort yratepaid
*tab loanamount if loanamount<1000
*drop if loanamount<1000

tabstat yratepaid if interestpaid2>0 & interestpaid2!=., by(lender4) stat(n mean p50 min max)
gen monthlyinterestrate=.
replace monthlyinterestrate=yratepaid if loanduration<=30.4167
replace monthlyinterestrate=(yratepaid/loanduration)*30.4167 if loanduration>30.4167

*****
/*
2010
     lender4 |         N      mean       p50       min       max
-------------+--------------------------------------------------
         WKP |       162   20.1878  15.19231       1.5  116.6667
   Relatives |       131   19.3611  15.55556  .2933333       108
      Labour |       120  18.50312        15         3        72
 Pawn broker |         2  94.48529  94.48529      12.5  176.4706
 Shop keeper |         1        18        18        18        18
Moneylenders |        37  29.88986        21         3       150
     Friends |        15  14.89524        15         3        35
 Microcredit |        51  14.28715  10.55556       1.2        60
        Bank |        13  11.25972  6.993007       1.8        30
    Neighbor |       260  21.72951        18      1.75        96
-------------+--------------------------------------------------
       Total |       792  20.31328      17.5  .2933333  176.4706
----------------------------------------------------------------

*/

save"RUME-loans_v8.dta", replace

*************************************
* END















****************************************
* IMPUTATION
****************************************
use"RUME-loans_v8.dta", clear

*** Add income
preserve
use"RUME-HH_v7.dta", clear
duplicates drop HHID2010, force
keep HHID2010 annualincome_HH
save"RUME-HH_annualincome.dta", replace
restore

merge m:1 HHID using "RUME-HH_annualincome.dta", keepusing(annualincome_HH)
drop if _merge==2
drop _merge

*** Debt service pour ML
gen debt_service=.
replace debt_service=totalrepaid2 if loanduration<=365
replace debt_service=totalrepaid2*365/loanduration if loanduration>365
replace debt_service=0 if loanduration==0 & totalrepaid2==0 | loanduration==0 & totalrepaid2==.



*** Interest service pour ML
gen interest_service=.
replace interest_service=interestpaid2 if loanduration<=365
replace interest_service=interestpaid2*365/loanduration if loanduration>365
replace interest_service=0 if loanduration==0 & totalrepaid2==0 | loanduration==0 & totalrepaid2==.
replace interest_service=0 if dummyinterest==0 & interestpaid2==0 | dummyinterest==0 & interestpaid2==.



*** Imputation du principal
gen imp_principal=.
replace imp_principal=loanamount-loanbalance if loanduration<=365 & debt_service==.
replace imp_principal=(loanamount-loanbalance)*365/loanduration if loanduration>365 & debt_service==.




*** Imputation interest for moneylenders and microcredit
gen imp1_interest=.
replace imp1_interest=0.299*loanamount if lender4==6 & loanduration<=365 & debt_service==.
replace imp1_interest=0.299*loanamount*365/loanduration if lender4==6 & loanduration>365 & debt_service==.
replace imp1_interest=0.149*loanamount if lender4==8 & loanduration<=365 & debt_service==.
replace imp1_interest=0.149*loanamount*365/loanduration if lender4==8 & loanduration>365 & debt_service==.
replace imp1_interest=0 if lender4!=6 & lender4!=8 & debt_service==. & loandate!=.




*** Imputation total
gen imp1_totalrepaid_year=imp_principal+imp1_interest



*** Calcul service de la dette pour tout
gen imp1_debt_service=debt_service
replace imp1_debt_service=imp1_totalrepaid_year if debt_service==.
replace imp1_debt_service=. if loansettled==1


*** Calcul service des interets pour tout
gen imp1_interest_service=interest_service
replace imp1_interest_service=imp1_interest if interest_service==.
replace imp1_interest_service=. if loansettled==1


save"RUME-loans_v9.dta", replace
*************************************
* END













****************************************
* Other measure
****************************************
use"RUME-loans_v9.dta", clear


*Nb of ML/indiv/HH
gen dummymainloans=0
replace dummymainloans=1 if lendername!=""
tab dummymainloans


*** Nber of loan
gen loans=1
replace loans=0 if loansettled==1
ta loans


*** Amount
clonevar loanamount_fin=loanamount
replace loanamount_fin=. if loansettled==1

*** Indiv + HH level
foreach x in loans loanamount_fin {
bysort HHID2010: egen `x'_HH=sum(`x')
}

rename loanamount_fin_HH loanamount_HH
drop loans loanamount_fin

*** Services
bysort HHID2010: egen imp1_ds_tot_HH=sum(imp1_debt_service)
bysort HHID2010: egen imp1_is_tot_HH=sum(imp1_interest_service)



********** Clean
drop totalrepaid2 interestpaid2 principalpaid2

global arnaud loanduration lender_cat reason_cat lender2 lender3 lender4 yratepaid monthlyinterestrate debt_service interest_service imp_principal imp1_interest imp1_totalrepaid_year imp1_debt_service imp1_interest_service dummymainloans loans_HH loanamount_HH imp1_ds_tot_HH imp1_is_tot_HH

foreach x in $arnaud {
label var `x' "Construction -- Arnaud"
}

save"RUME-loans_v10.dta", replace
*************************************
* END











****************************************
* Individual level
****************************************
use"RUME-loans_v10.dta", clear

*HH
preserve
duplicates drop HHID2010, force
keep HHID2010 loans_HH imp1_ds_tot_HH imp1_is_tot_HH loanamount_HH
save"RUME-loans_v10_HH.dta", replace
restore


*********** Merge
use"RUME-HH_v7.dta", clear

merge m:1 HHID2010 using "RUME-loans_v10_HH.dta"
drop _merge



save"RUME-HH_v8.dta", replace
*************************************
* END
