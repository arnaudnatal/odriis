*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Debt construction
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox\RUME-NEEMSIS\Data\Construction"
cd"$directory"

********** Database names
global data = "RUME-HH"
global loans = "RUME-loans_mainloans"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020






****************************************
* CLEANING 2
****************************************
use "$loans", clear


*Settled
*drop if loansettled==1

********** Submission darte
gen submissiondate=mdy(03,01,2010)
tab submissiondate
format submissiondate %d

*Loan date
fre loandatemonth
replace loandatemonth="1" if loandatemonth=="JAN"
replace loandatemonth="2" if loandatemonth=="FEB"
replace loandatemonth="3" if loandatemonth=="MAR"
replace loandatemonth="4" if loandatemonth=="APR"
replace loandatemonth="5" if loandatemonth=="MAY"
replace loandatemonth="6" if loandatemonth=="JUN"
replace loandatemonth="7" if loandatemonth=="JUL"
replace loandatemonth="8" if loandatemonth=="AUG"
replace loandatemonth="8" if loandatemonth=="aug"
replace loandatemonth="9" if loandatemonth=="SEP"
replace loandatemonth="10" if loandatemonth=="OCT"
replace loandatemonth="11" if loandatemonth=="NOV"
replace loandatemonth="12" if loandatemonth=="DEC"

replace loandatemonth="6" if loandatemonth=="88"
replace loandatemonth="6" if loandatemonth=="99"

destring loandatemonth, replace
gen loandate2=mdy(loandatemonth,01,loandateyear)
format loandate2 %d
order loandate2, after(loandate)
drop loandate loandatemonth loandateyear
rename loandate2 loandate

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
foreach i in 8 11 12{
replace lender_cat=3 if loanlender==`i'
}
fre lender_cat



*** Purpose of loan
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

save"_temp\RUME-loans_v4.dta", replace
****************************************
* END














****************************************
* NEW LENDER VAR
****************************************
use "_temp\RUME-loans_v4.dta", clear
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

save "_temp\RUME-loans_v5.dta", replace
****************************************
* END


















****************************************
* COHERENCE
****************************************
use"_temp\RUME-loans_v5.dta", clear

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



save"_temp\RUME-loans_v6", replace
****************************************
* END














****************************************
* BALANCE
****************************************
use"_temp\RUME-loans_v6.dta", clear

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
save"_temp\RUME-loans_v7.dta", replace
*************************************
* END















****************************************
* ANNUALIZED
****************************************
use"_temp\RUME-loans_v7.dta", clear

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

save"_temp\RUME-loans_v8.dta", replace
*************************************
* END















****************************************
* IMPUTATION
****************************************
use"_temp\RUME-loans_v8.dta", clear

*** Add income
*preserve
*use"RUME-HH_v7.dta", clear
*duplicates drop HHID2010, force
*keep HHID2010 annualincome_HH
*save"RUME-HH_annualincome.dta", replace
*restore
*merge m:1 HHID using "RUME-HH_annualincome.dta", keepusing(annualincome_HH)
*drop if _merge==2
*drop _merge

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


save"_temp\RUME-loans_v9.dta", replace
*************************************
* END













****************************************
* Other measure
****************************************
use"_temp\RUME-loans_v9.dta", clear


********** Loanlender
fre loanlender lender4

ta loanlender, gen(loanlender_)
rename loanlender_1 lender_WKP
rename loanlender_2 lender_rela
rename loanlender_3 lender_empl
rename loanlender_4 lender_mais
rename loanlender_5 lender_coll
rename loanlender_6 lender_pawn
rename loanlender_7 lender_shop
rename loanlender_8 lender_fina
rename loanlender_9 lender_frie
rename loanlender_10 lender_SHG
rename loanlender_11 lender_bank
rename loanlender_12 lender_coop
rename loanlender_13 lender_suga

ta lender4, gen(lender_)
rename lender_1 lender4_WKP
rename lender_2 lender4_rela
rename lender_3 lender4_labo
rename lender_4 lender4_pawn
rename lender_5 lender4_shop
rename lender_6 lender4_mone
rename lender_7 lender4_frie
rename lender_8 lender4_micr
rename lender_9 lender4_bank
rename lender_10 lender4_neig

ta lender_cat, gen(lendercat_)
rename lendercat_1 lendercat_info
rename lendercat_2 lendercat_semi
rename lendercat_3 lendercat_form



* Amount
foreach x in WKP rela empl mais coll pawn shop fina frie SHG bank coop suga {
gen lenderamt_`x'=loanamount if lender_`x'==1
}
foreach x in WKP rela labo pawn shop mone frie micr bank neig {
gen lender4amt_`x'=loanamount if lender4_`x'==1
}
foreach x in info semi form {
gen lendercatamt_`x'=loanamount if lendercat_`x'==1
}


********** Reason given
fre loanreasongiven
ta loanreasongiven, gen(loanreasongiven_)
rename loanreasongiven_1 given_agri
rename loanreasongiven_2 given_fami
rename loanreasongiven_3 given_heal
rename loanreasongiven_4 given_repa
rename loanreasongiven_5 given_hous
rename loanreasongiven_6 given_inve
rename loanreasongiven_7 given_cere
rename loanreasongiven_8 given_marr
rename loanreasongiven_9 given_educ
rename loanreasongiven_10 given_rela
rename loanreasongiven_11 given_deat

*Amt
foreach x in agri fami heal repa hous inve cere marr educ rela deat {
gen givenamt_`x'=loanamount if given_`x'==1
}



********** Reason given 2
fre reason_cat
ta reason_cat, gen(loanreasoncat_)
rename loanreasoncat_1 givencat_econ
rename loanreasoncat_2 givencat_curr
rename loanreasoncat_3 givencat_huma
rename loanreasoncat_4 givencat_soci
rename loanreasoncat_5 givencat_hous

*Amt
foreach x in econ curr huma soci hous {
gen givencatamt_`x'=loanamount if givencat_`x'==1
}



/*
********** Effective
fre loaneffectivereason
gen effective_agri=0
gen effective_fami=0
gen effective_heal=0
gen effective_repa=0
gen effective_hous=0
gen effective_inve=0
gen effective_cere=0
gen effective_marr=0
gen effective_educ=0
gen effective_rela=0
gen effective_deat=0
gen effective_nore=0
gen effective_othe=0

replace effective_agri=1 if strpos(loaneffectivereason,"1")
replace effective_fami=1 if strpos(loaneffectivereason,"2")
replace effective_heal=1 if strpos(loaneffectivereason,"3")
replace effective_repa=1 if strpos(loaneffectivereason,"4")
replace effective_hous=1 if strpos(loaneffectivereason,"5")
replace effective_inve=1 if strpos(loaneffectivereason,"6")
replace effective_cere=1 if strpos(loaneffectivereason,"7")
replace effective_marr=1 if strpos(loaneffectivereason,"8")
replace effective_educ=1 if strpos(loaneffectivereason,"9")
replace effective_rela=1 if strpos(loaneffectivereason,"10")
replace effective_deat=1 if strpos(loaneffectivereason,"11")
replace effective_nore=1 if strpos(loaneffectivereason,"12")
replace effective_othe=1 if strpos(loaneffectivereason,"77")
*/



********** Lender service
fre otherlenderservices

ta otherlenderservices, gen(othlendserv_)

rename othlendserv_1 othlendserv_poli
rename othlendserv_2 othlendserv_fina
rename othlendserv_3 othlendserv_guar
rename othlendserv_4 othlendserv_gene
rename othlendserv_5 othlendserv_othe
rename othlendserv_7 othlendserv_nrep

replace othlendserv_othe=1 if othlendserv_6==1


********** Guarantee
fre guarantee

ta guarantee, gen(guarantee_)

rename guarantee_1 guarantee_chit
rename guarantee_2 guarantee_shg
rename guarantee_3 guarantee_both
rename guarantee_4 guarantee_none






********** Borrower services
fre borrowerservices

ta borrowerservices, gen(borrservices_)

rename borrservices_1 borrservices_free
rename borrservices_2 borrservices_work
rename borrservices_3 borrservices_supp
*rename borrservices_4 borrservices_none
rename borrservices_4 borrservices_othe
rename borrservices_5 borrservices_nrep




********** Plan to repay
fre plantorepay1 plantorepay2 plantorepay3
gen plantorep_chit=0
gen plantorep_work=0
gen plantorep_migr=0
gen plantorep_asse=0
gen plantorep_inco=0
gen plantorep_borr=0
gen plantorep_noth=0
gen plantorep_othe=0
gen plantorep_nrep=0

replace plantorep_chit=1 if plantorepay1==1
replace plantorep_work=1 if plantorepay1==2
replace plantorep_migr=1 if plantorepay1==3
replace plantorep_asse=1 if plantorepay1==4
replace plantorep_inco=1 if plantorepay1==5
replace plantorep_borr=1 if plantorepay1==6
replace plantorep_noth=1 if plantorepay1==7
replace plantorep_othe=1 if plantorepay1==77
replace plantorep_nrep=1 if plantorepay1==99

replace plantorep_chit=1 if plantorepay2==1
replace plantorep_work=1 if plantorepay2==2
replace plantorep_migr=1 if plantorepay2==3
replace plantorep_asse=1 if plantorepay2==4
replace plantorep_inco=1 if plantorepay2==5
replace plantorep_borr=1 if plantorepay2==6
replace plantorep_noth=1 if plantorepay2==7
replace plantorep_othe=1 if plantorepay2==77
replace plantorep_nrep=1 if plantorepay2==99

replace plantorep_chit=1 if plantorepay3==1
replace plantorep_work=1 if plantorepay3==2
replace plantorep_migr=1 if plantorepay3==3
replace plantorep_asse=1 if plantorepay3==4
replace plantorep_inco=1 if plantorepay3==5
replace plantorep_borr=1 if plantorepay3==6
replace plantorep_noth=1 if plantorepay3==7
replace plantorep_othe=1 if plantorepay3==77
replace plantorep_nrep=1 if plantorepay3==99



/*
********** Settle loan strategy
ta settleloanstrategy
gen settlestrat_inco=0
gen settlestrat_sche=0
gen settlestrat_borr=0
gen settlestrat_sell=0
gen settlestrat_land=0
gen settlestrat_cons=0
gen settlestrat_addi=0
gen settlestrat_work=0
gen settlestrat_supp=0
gen settlestrat_harv=0
gen settlestrat_othe=0

replace settlestrat_inco=1 if strpos(settleloanstrategy,"1")
replace settlestrat_sche=1 if strpos(settleloanstrategy,"2")
replace settlestrat_borr=1 if strpos(settleloanstrategy,"3")
replace settlestrat_sell=1 if strpos(settleloanstrategy,"4")
replace settlestrat_land=1 if strpos(settleloanstrategy,"5")
replace settlestrat_cons=1 if strpos(settleloanstrategy,"6")
replace settlestrat_addi=1 if strpos(settleloanstrategy,"7")
replace settlestrat_work=1 if strpos(settleloanstrategy,"8")
replace settlestrat_supp=1 if strpos(settleloanstrategy,"9")
replace settlestrat_harv=1 if strpos(settleloanstrategy,"10")
replace settlestrat_othe=1 if strpos(settleloanstrategy,"77")
*/



/*
********** Loan product pledge
ta loanproductpledge
gen prodpledge_gold=0
gen prodpledge_land=0
gen prodpledge_car=0
gen prodpledge_bike=0
gen prodpledge_frid=0
gen prodpledge_furn=0
gen prodpledge_tail=0
gen prodpledge_cell=0
gen prodpledge_line=0
gen prodpledge_dvd=0
gen prodpledge_came=0
gen prodpledge_gas=0
gen prodpledge_comp=0
gen prodpledge_dish=0
gen prodpledge_none=0
gen prodpledge_othe=0

replace prodpledge_gold=1 if strpos(loanproductpledge,"1")
replace prodpledge_land=1 if strpos(loanproductpledge,"2")
replace prodpledge_car=1 if strpos(loanproductpledge,"3")
replace prodpledge_bike=1 if strpos(loanproductpledge,"4")
replace prodpledge_frid=1 if strpos(loanproductpledge,"5")
replace prodpledge_furn=1 if strpos(loanproductpledge,"6") 
replace prodpledge_tail=1 if strpos(loanproductpledge,"7") 
replace prodpledge_cell=1 if strpos(loanproductpledge,"8") 
replace prodpledge_line=1 if strpos(loanproductpledge,"9")
replace prodpledge_dvd=1 if strpos(loanproductpledge,"10")
replace prodpledge_came=1 if strpos(loanproductpledge,"11")
replace prodpledge_gas=1 if strpos(loanproductpledge,"12")
replace prodpledge_comp=1 if strpos(loanproductpledge,"13")
replace prodpledge_dish=1 if strpos(loanproductpledge,"14")
replace prodpledge_none=1 if strpos(loanproductpledge,"15")
replace prodpledge_othe=1 if strpos(loanproductpledge,"77")
*/



*** Clean
gen year=2010
order HHID2010 year


save"outcomes\RUME-loans_mainloans_new.dta", replace
*************************************
* END










****************************************
* HH level
****************************************
use"outcomes\RUME-loans_mainloans_new.dta", clear



*
drop if loansettled==1



*** Indiv + HH level
bysort HHID2010: egen nbloans_HH=sum(1)
bysort HHID2010: egen loanamount_HH=sum(loanamount)




*** Services
bysort HHID2010: egen imp1_ds_tot_HH=sum(imp1_debt_service)
bysort HHID2010: egen imp1_is_tot_HH=sum(imp1_interest_service)




********** Individual and HH level for dummies
foreach x in lender_WKP lender_rela lender_empl lender_mais lender_coll lender_pawn lender_shop lender_fina lender_frie lender_SHG lender_bank lender_coop lender_suga lender4_WKP lender4_rela lender4_labo lender4_pawn lender4_shop lender4_mone lender4_frie lender4_micr lender4_bank lender4_neig lendercat_info lendercat_semi lendercat_form given_agri given_fami given_heal given_repa given_hous given_inve given_cere given_marr given_educ given_rela given_deat givencat_econ givencat_curr givencat_huma givencat_soci givencat_hous othlendserv_poli othlendserv_fina othlendserv_guar othlendserv_gene othlendserv_othe othlendserv_6 othlendserv_nrep guarantee_chit guarantee_shg guarantee_both guarantee_none borrservices_free borrservices_work borrservices_supp borrservices_othe borrservices_nrep plantorep_chit plantorep_work plantorep_migr plantorep_asse plantorep_inco plantorep_borr plantorep_noth plantorep_othe plantorep_nrep {

bysort HHID2010: egen nbHH_`x'=sum(`x')
gen dumHH_`x'=0
replace dumHH_`x'=1 if nbHH_`x'>0
}


foreach x in lenderamt_WKP lenderamt_rela lenderamt_empl lenderamt_mais lenderamt_coll lenderamt_pawn lenderamt_shop lenderamt_fina lenderamt_frie lenderamt_SHG lenderamt_bank lenderamt_coop lenderamt_suga lender4amt_WKP lender4amt_rela lender4amt_labo lender4amt_pawn lender4amt_shop lender4amt_mone lender4amt_frie lender4amt_micr lender4amt_bank lender4amt_neig lendercatamt_info lendercatamt_semi lendercatamt_form givenamt_agri givenamt_fami givenamt_heal givenamt_repa givenamt_hous givenamt_inve givenamt_cere givenamt_marr givenamt_educ givenamt_rela givenamt_deat givencatamt_econ givencatamt_curr givencatamt_huma givencatamt_soci givencatamt_hous {

bysort HHID2010: egen totHH_`x'=sum(`x')
}




*HH
preserve
duplicates drop HHID2010, force
keep HHID2010 nbloans_HH loanamount_HH imp1_ds_tot_HH imp1_is_tot_HH nbHH_lender_WKP dumHH_lender_WKP nbHH_lender_rela dumHH_lender_rela nbHH_lender_empl dumHH_lender_empl nbHH_lender_mais dumHH_lender_mais nbHH_lender_coll dumHH_lender_coll nbHH_lender_pawn dumHH_lender_pawn nbHH_lender_shop dumHH_lender_shop nbHH_lender_fina dumHH_lender_fina nbHH_lender_frie dumHH_lender_frie nbHH_lender_SHG dumHH_lender_SHG nbHH_lender_bank dumHH_lender_bank nbHH_lender_coop dumHH_lender_coop nbHH_lender_suga dumHH_lender_suga nbHH_lender4_WKP dumHH_lender4_WKP nbHH_lender4_rela dumHH_lender4_rela nbHH_lender4_labo dumHH_lender4_labo nbHH_lender4_pawn dumHH_lender4_pawn nbHH_lender4_shop dumHH_lender4_shop nbHH_lender4_mone dumHH_lender4_mone nbHH_lender4_frie dumHH_lender4_frie nbHH_lender4_micr dumHH_lender4_micr nbHH_lender4_bank dumHH_lender4_bank nbHH_lender4_neig dumHH_lender4_neig nbHH_lendercat_info dumHH_lendercat_info nbHH_lendercat_semi dumHH_lendercat_semi nbHH_lendercat_form dumHH_lendercat_form nbHH_given_agri dumHH_given_agri nbHH_given_fami dumHH_given_fami nbHH_given_heal dumHH_given_heal nbHH_given_repa dumHH_given_repa nbHH_given_hous dumHH_given_hous nbHH_given_inve dumHH_given_inve nbHH_given_cere dumHH_given_cere nbHH_given_marr dumHH_given_marr nbHH_given_educ dumHH_given_educ nbHH_given_rela dumHH_given_rela nbHH_given_deat dumHH_given_deat nbHH_givencat_econ dumHH_givencat_econ nbHH_givencat_curr dumHH_givencat_curr nbHH_givencat_huma dumHH_givencat_huma nbHH_givencat_soci dumHH_givencat_soci nbHH_givencat_hous dumHH_givencat_hous nbHH_othlendserv_poli dumHH_othlendserv_poli nbHH_othlendserv_fina dumHH_othlendserv_fina nbHH_othlendserv_guar dumHH_othlendserv_guar nbHH_othlendserv_gene dumHH_othlendserv_gene nbHH_othlendserv_othe dumHH_othlendserv_othe nbHH_othlendserv_6 dumHH_othlendserv_6 nbHH_othlendserv_nrep dumHH_othlendserv_nrep nbHH_guarantee_chit dumHH_guarantee_chit nbHH_guarantee_shg dumHH_guarantee_shg nbHH_guarantee_both dumHH_guarantee_both nbHH_guarantee_none dumHH_guarantee_none nbHH_borrservices_free dumHH_borrservices_free nbHH_borrservices_work dumHH_borrservices_work nbHH_borrservices_supp dumHH_borrservices_supp nbHH_borrservices_othe dumHH_borrservices_othe nbHH_borrservices_nrep dumHH_borrservices_nrep nbHH_plantorep_chit dumHH_plantorep_chit nbHH_plantorep_work dumHH_plantorep_work nbHH_plantorep_migr dumHH_plantorep_migr nbHH_plantorep_asse dumHH_plantorep_asse nbHH_plantorep_inco dumHH_plantorep_inco nbHH_plantorep_borr dumHH_plantorep_borr nbHH_plantorep_noth dumHH_plantorep_noth nbHH_plantorep_othe dumHH_plantorep_othe nbHH_plantorep_nrep dumHH_plantorep_nrep totHH_lenderamt_WKP totHH_lenderamt_rela totHH_lenderamt_empl totHH_lenderamt_mais totHH_lenderamt_coll totHH_lenderamt_pawn totHH_lenderamt_shop totHH_lenderamt_fina totHH_lenderamt_frie totHH_lenderamt_SHG totHH_lenderamt_bank totHH_lenderamt_coop totHH_lenderamt_suga totHH_lender4amt_WKP totHH_lender4amt_rela totHH_lender4amt_labo totHH_lender4amt_pawn totHH_lender4amt_shop totHH_lender4amt_mone totHH_lender4amt_frie totHH_lender4amt_micr totHH_lender4amt_bank totHH_lender4amt_neig totHH_lendercatamt_info totHH_lendercatamt_semi totHH_lendercatamt_form totHH_givenamt_agri totHH_givenamt_fami totHH_givenamt_heal totHH_givenamt_repa totHH_givenamt_hous totHH_givenamt_inve totHH_givenamt_cere totHH_givenamt_marr totHH_givenamt_educ totHH_givenamt_rela totHH_givenamt_deat totHH_givencatamt_econ totHH_givencatamt_curr totHH_givencatamt_huma totHH_givencatamt_soci totHH_givencatamt_hous
save"outcomes\RUME-loans_HH.dta", replace
restore

*************************************
* END
