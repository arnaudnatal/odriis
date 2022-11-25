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
global data = "NEEMSIS1-HH"
global loans = "NEEMSIS1-loans_mainloans"


********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020









****************************************
* FINANCE
****************************************
use"$loans", clear
gen loan_database="FINANCE"
save "_temp\NEEMSIS1-loans_v2.dta", replace
****************************************
* END






****************************************
* GOLD
****************************************
use "$data", clear
keep HHID2016 INDID2016 egoid submissiondate goldamountpledge goldreasonpledge
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

** Append
append using "_temp\NEEMSIS1-loans_v2.dta"
mdesc
save "_temp\NEEMSIS1-loans_v3.dta", replace
****************************************
* END









****************************************
* MARRIAGE
****************************************
use "$data", clear
keep HHID2016 INDID2016 submissiondate marriageloanamount_wellknown marriageloanamount_banks marriageloanamount_coopbanks marriageloanamount_relatives marriageloanamount_employer marriageloanamount_maistry marriageloanamount_colleagues marriageloanamount_pawnbroker marriageloanamount_monlender marriageloanamount_friends
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


reshape long loanamount loanreasongiven loanlender, i(HHID2016 INDID2016)  j(num)
keep if loanamount!=.
drop modmar

clonevar loaneffectivereason=loanreasongiven
tostring loaneffectivereason, replace

append using "_temp\NEEMSIS1-loans_v3.dta"

gen year=2016


save "_temp\NEEMSIS1-loans_v4.dta", replace
****************************************
* END
















****************************************
* CAT VAR
****************************************
use"_temp\NEEMSIS1-loans_v4.dta", clear


*** Change date format of submissiondate
preserve
use "$data", clear
duplicates drop HHID2016, force
keep HHID2016 submissiondate
save"_temp\NEEMSIS1-HH_date.dta", replace
restore

drop submissiondate
merge m:1 HHID2016 using "_temp\NEEMSIS1-HH_date.dta", keepusing(submissiondate)
keep if _merge==3
drop _merge
rename submissiondate submissiondate_o
gen submissiondate=dofc(submissiondate_o)
format submissiondate %td



*** Loan duration
gen loanduration=submissiondate-loandate
replace loanduration=1 if loanduration<1




*** Type of loan
gen lender_cat=.
label define lender_cat 1"Informal" 2"Semi formal" 3"Formal"
label values lender_cat lender_cat

foreach i in 1 2 3 4 5 7 9 13{
replace lender_cat=1 if loanlender==`i'
}
foreach i in 6 10{
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

save"_temp\NEEMSIS1-loans_v5.dta", replace
****************************************
* END















****************************************
* NEW LENDER VAR
****************************************
use "_temp\NEEMSIS1-loans_v5.dta", clear
fre loanlender


***Recode loanlender pour que les intérêts soient plus justes
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

save "_temp\NEEMSIS1-loans_v6.dta", replace
****************************************
* END











****************************************
* Main loan consistency
****************************************
use "_temp\NEEMSIS1-loans_v6.dta", clear

keep if lendername!=""
*1091 ML
*** Loan duration
gen loanduration_month=loanduration/30.4167

/*
Pb majeur:
Il manque des informations pour en vérifier d'autres
C-à-d. qu'on ne peut pas recalculer des informations à la 
main à partir d'autres
D'un côté - total des intérêts payés
D'un autre - montant des intérêt par semaine, mois jours
MAIS on n'a pas la fréquence
--> We cannot calculte interest paid..

Same with the amount:
We have the total repaid
We also have the frequency of the monthly/yearly repayment
BUT not the amount
--> We cannot calculate total repaid

We always need to mix diferent informations
We can only check 2 things:
- the duration
- consistency between total repaid, principal paid and interest paid

Lets first check the consistency between total repaid, principal paid, interest paid as the rest depends on these values.

However, loanamount - loanbalance, suppose to be principal paid, so leths begin with that
*/


********** Consistency --> balance / principal
gen test1=loanamount-loanbalance-principalpaid
ta test1
/*
87% des cas c'est ok
*/
sort HHID2016 INDID2016 loanid
list loanamount loanbalance totalrepaid principalpaid interestpaid interestloan if test1!=0 & test1!=., clean noobs
gen pb1=0
replace pb1=1 if test1!=0 & test1!=.
ta pb1
/*
137 loans with pb
We accept 1000 rs of error in the calculation of balance principal
as principal depends on other variables, I correct loanbalance
*/
replace loanbalance=loanamount-principalpaid if test1<=1000 & test1>=-1000
drop test1 pb1
gen test1=loanamount-loanbalance-principalpaid
ta test1
/*
88% des cas c'est ok
*/
gen pb1=0
replace pb1=1 if test1!=0 & test1!=.




********** Consistency --> Total repaid = Principal + Interest
gen test2=totalrepaid-principalpaid-interestpaid
ta test2
/*
95% des cas c'est ok
*/
sort HHID2016 INDID2016 loanid
list loanamount loanbalance totalrepaid principalpaid interestpaid interestloan if test2!=0 & test2!=., clean noobs
gen pb2=0
replace pb2=1 if test2!=0 & test2!=.
ta pb2
/*
36 loans with
We accept 1000 rs of error in the calculation
*/
replace totalrepaid=principalpaid+interestpaid if test2<=1000 & test2>=-1000
drop test2 pb2
gen test2=totalrepaid-principalpaid-interestpaid
ta test2
/*
98% des cas c'est ok
*/
gen pb2=0
replace pb2=1 if test2!=0 & test2!=.




********** pb1 and pb2 together
ta pb1 pb2
/*
           |          pb2
       pb1 |         0          1 |     Total
-----------+----------------------+----------
         0 |       967         10 |       977 
         1 |       107          7 |       114 
-----------+----------------------+----------
     Total |     1,074         17 |     1,091 
*/

sort HHID2016 INDID2016 loanid
br HHID2016 INDID2016 loanid loansettled loanamount lender4 loanduration_month loanbalance totalrepaid principalpaid interestpaid test1 test2 interestfrequency interestloan termsofrepayment repayduration1 repayduration2 if pb1==1 & pb2==1

* One by one
replace principalpaid=0 if HHID2016=="uuid:da893017-2541-42dc-9dab-d517d777b92b" & INDID2016==1 & loanid==3
replace principalpaid=0 if HHID2016=="uuid:d35fd473-8f07-437a-b6d2-b51962ac7c94" & INDID2016==1 & loanid==2
replace principalpaid=0 if HHID2016=="uuid:b6802956-c0b6-442e-b416-73d9acd4d137" & INDID2016==1 & loanid==1
replace principalpaid=0 if HHID2016=="uuid:9f650881-8382-48ff-8757-9f012a0dfe8f" & INDID2016==1 & loanid==1
replace principalpaid=18000 if HHID2016=="uuid:4e3a8d00-0083-47ce-8acc-4e9e305d68b4" & INDID2016==1 & loanid==3
replace totalrepaid=principalpaid+interestpaid if HHID2016=="uuid:4e3a8d00-0083-47ce-8acc-4e9e305d68b4" & INDID2016==1 & loanid==3
replace principalpaid=0 if HHID2016=="uuid:d92d4760-c143-430d-848d-ae199496a356" & INDID2016==1 & loanid==2
replace repayduration2=0 if HHID2016=="uuid:d92d4760-c143-430d-848d-ae199496a356" & INDID2016==1 & loanid==2
replace principalpaid=0 if HHID2016=="uuid:390905c9-ee49-4e1e-8a4a-80e4741b7140" & INDID2016==1 & loanid==2
replace repayduration2=0 if HHID2016=="uuid:390905c9-ee49-4e1e-8a4a-80e4741b7140" & INDID2016==1 & loanid==2
replace interestpaid=10400 if HHID2016=="uuid:390905c9-ee49-4e1e-8a4a-80e4741b7140" & INDID2016==1 & loanid==2








********** pb1 only
ta pb1 pb2
/*
           |          pb2
       pb1 |         0          1 |     Total
-----------+----------------------+----------
         0 |       967         10 |       977 
         1 |       107          7 |       114 
-----------+----------------------+----------
     Total |     1,074         17 |     1,091 
*/

sort HHID2016 INDID2016 loanid
br HHID2016 INDID2016 loanid loansettled loanamount lender4 loanduration_month loanbalance totalrepaid principalpaid interestpaid test1 test2 interestfrequency interestloan termsofrepayment repayduration1 repayduration2 if pb1==1 & pb2==0















********** pb2 only
ta pb1 pb2
/*
           |          pb2
       pb1 |         0          1 |     Total
-----------+----------------------+----------
         0 |       967         10 |       977 
         1 |       107          7 |       114 
-----------+----------------------+----------
     Total |     1,074         17 |     1,091 
*/

sort HHID2016 INDID2016 loanid
br HHID2016 INDID2016 loanid loansettled loanamount lender4 loanduration_month loanbalance totalrepaid principalpaid interestpaid test1 test2 interestfrequency interestloan termsofrepayment repayduration1 repayduration2 if pb1==0 & pb2==1


replace totalrepaid=principalpaid+interestpaid if HHID2016=="uuid:127cd654-d8fe-470e-811c-f322957b8a1c" & INDID2016==1 & loanid==3
replace totalrepaid=principalpaid+interestpaid if HHID2016=="uuid:22697a91-f33b-4983-809b-c4cfd2041a6f" & INDID2016==1 & loanid==4
replace totalrepaid=principalpaid+interestpaid if HHID2016=="uuid:45b98913-fe19-44bd-b909-b41246240c8a" & INDID2016==1 & loanid==2
replace interestloan=2000 if HHID2016=="uuid:45b98913-fe19-44bd-b909-b41246240c8a" & INDID2016==1 & loanid==2
replace totalrepaid=principalpaid+interestpaid if HHID2016=="uuid:49eaa858-d375-4342-b04c-8ccffa93ea76" & INDID2016==1 & loanid==2
replace totalrepaid=principalpaid+interestpaid if HHID2016=="uuid:7f35c399-5e9d-4d1c-bca8-669afdb94697" & INDID2016==1 & loanid==1
replace interestfrequency=2 if HHID2016=="uuid:7f35c399-5e9d-4d1c-bca8-669afdb94697" & INDID2016==1 & loanid==1
replace totalrepaid=principalpaid+interestpaid if HHID2016=="uuid:b1974dc2-aad3-49fd-bc31-87bd66179c60" & INDID2016==1 & loanid==1
replace totalrepaid=principalpaid+interestpaid if HHID2016=="uuid:c3754c17-d102-41df-93d1-f1bd78466da8" & INDID2016==1 & loanid==1
replace totalrepaid=principalpaid+interestpaid if HHID2016=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" & INDID2016==2 & loanid==4
replace totalrepaid=principalpaid+interestpaid if HHID2016=="uuid:e93eca4e-a0b4-491a-8095-eaf70f0305c2" & INDID2016==1 & loanid==1
replace interestfrequency=2 if HHID2016=="uuid:e93eca4e-a0b4-491a-8095-eaf70f0305c2" & INDID2016==1 & loanid==1
replace interestpaid=totalrepaid if HHID2016=="uuid:ebfb1d75-ba54-49a7-a324-affb036c88aa" & INDID2016==1 & loanid==1
replace interestfrequency=2 if HHID2016=="uuid:ebfb1d75-ba54-49a7-a324-affb036c88aa" & INDID2016==1 & loanid==1






















********** All in months!



*** Repay duration2
gen repayduration2_month=.
replace repayduration2_month=repayduration2/4.3452 if repayduration1==1  // weekly
replace repayduration2_month=repayduration2 if repayduration1==2  // monthly
replace repayduration2_month=repayduration2*12 if repayduration1==3  // yearly
replace repayduration2_month=repayduration2*6 if repayduration1==4  // once in six month

*** Interest loan
gen interestloan_month=.
replace interestloan_month=interestloan*4.3452 if interestfrequency==1  // weekly
replace interestloan_month=interestloan if interestfrequency==2  // monthly
replace interestloan_month=interestloan/12 if interestfrequency==3  // yearly
replace interestloan_month=interestloan/6 if interestfrequency==4  // once in six month



********** Nb month interest payment
gen nbmonth_interest=.
replace nbmonth_interest=interestpaid/interestloan_month if interestpaid!=. & interestloan_month!=.



********** PB DURATION 1: if nb month repay > loan duration
gen pb1=0
replace pb1=1 if repayduration2_month>loanduration_month
ta pb1
/*
Dans 93% des cas, la durée de remboursement est plus ancienne que le prêt.
Ex:
un prêt de 75 mois (6 ans), déclaré rembourser tous les ans, depuis 36 ans.
*/

*** To treat everybody in the same way: if pb1=1, replace by the loan duration
gen repayduration2_month2=repayduration2_month
replace repayduration2_month2=loanduration_month if pb1==1
drop pb1


********** PB DURATION 2: if nb month interest > loan duration
gen pb2=0 if dummyinterest==1
replace pb2=1 if nbmonth_interest>loanduration_month & dummyinterest==1
ta pb2
sort pb2
/*
Dans 25% des cas, la durée théorique de remboursement des intérêts est plus ancienne que le prêt.
Ex: 
un prêt de 8 mois, 4500 roupies d'intérêt déjà payé, à coup de 750 roupies d'intérêt payé tous les ans.
donc 750/12 -> 62.5 d'intérêts par mois
puis 4500/62.5 -> 72.34
Il faut 72 mois, à coup de 62 roupies par mois, pour payer les 4500 roupies déjà payé.
Or, le prêt n'est là que depuis 8 mois
*/


*** To treat everybody in the same way: if pb2=1, replace by the loan duration
gen nbmonth_interest2=nbmonth_interest
replace nbmonth_interest2=loanduration_month if pb2==1






********** Check repayment
gen 

********** Monthly payment
gen monthly_payment=totalrepaid/repayduration2_month2









********** Total repaid, interest paid, principal paid
gen test=totalrepaid-principalpaid-interestpaid
ta test
sort test
list HHID2016 INDID2016 loanid test totalrepaid principalpaid interestpaid if test!=0 & test!=., clean noobs




/*







****************************************
* Cleaning 
****************************************
use "_temp\NEEMSIS1-loans_v6.dta", clear


*NB MONTHS SINCE THE LOAN WAS TAKEN (unavailable for advances and gold loans)

gen diff_month=(submissiondate-loandate)/(365/12)
ta diff_month
list HHID2016 INDID2016 loanid submissiondate loandate if diff_month<0, clean noobs

*diff_month==-7.4958906:
replace diff_month=4.504109 if HHID2016=="uuid:6c722d1f-d5fa-4d1b-aab9-9f6e8d3bcabd" &	INDID2016==2& loanid==1	
*diff_month==-6.969863:
replace diff_month=5.030137 if HHID2016=="uuid:8f9bf965-cb33-4354-a047-cb029a2a43a5" & INDID2016==4	& loanid==1	

*difference en mois entre interview et loandate arrondie a l entier inferieur 
gen months=floor(diff_month)



********** Coherence VALUES INTERESTPAID/PRINCIPALPAID/TOTALREPAID

gen test=totalrepaid-principalpaid - interestpaid
sort test
list HHID2016 INDID2016 loanid test totalrepaid principalpaid interestpaid if test!=. & test!=0, clean noobs


*valeurs 55,66 enregistres a la place de missing value
replace interestpaid=. if interestpaid==55 | interestpaid==66
replace principalpaid=. if principalpaid==55 | principalpaid==66 
replace totalrepaid=. if totalrepaid==66

replace interestpaid=totalrepaid - principalpaid if HHID2016=="uuid:03448664-46ca-4519-8209-de355a7e8b31" & INDID2016==1 & loanid==1
replace interestpaid=9000 if HHID2016=="uuid:0f421b5c-b081-416c-a8ca-93c430d0961e" &	INDID2016==1 &	loanid==1
replace interestpaid=9000 if HHID2016=="uuid:8d63df0f-1b86-4f3a-97fc-2abcf338f8bf" &	INDID2016==2 &	loanid==1
replace interestpaid=20000 if HHID2016=="uuid:9f14556f-8aa4-42d1-a8e8-d82f3d40e3d3" &	INDID2016==5 &	loanid==1

replace interestpaid=14400 if HHID2016=="uuid:0595322c-603f-4c45-a333-9f80c0c140fc" &	INDID2016==1 &	loanid==2
replace interestpaid=50000 if HHID2016=="uuid:dfe09e8d-99df-4b37-a4db-e9343d9a9f13" &	INDID2016==1 &	loanid==1
replace interestpaid=18000 if HHID2016=="uuid:78817304-5ca2-42d3-9b67-843366b5afde" &	INDID2016==1 &	loanid==2
replace interestpaid=1424 if HHID2016=="uuid:e847a4d4-ea2a-4a01-95f2-25a37de516e9" &	INDID2016==2 &	loanid==1
replace interestpaid=totalrepaid if HHID2016=="uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006" &	INDID2016==1 &	loanid==1
replace interestpaid=totalrepaid if HHID2016=="uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006" &	INDID2016==1 &	loanid==2
replace principalpaid=200000 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	INDID2016==1 &	loanid==3
*instead of 1800:
replace principalpaid=18000 if HHID2016=="uuid:4e3a8d00-0083-47ce-8acc-4e9e305d68b4" &	INDID2016==1 &	loanid==3
*looks like a 3 paisa loan, with interest paid monthly on 14 month out of 19:
replace interestpaid=totalrepaid if HHID2016=="uuid:ebfb1d75-ba54-49a7-a324-affb036c88aa" &	INDID2016==1 &	loanid==1
*5 et 4 pe intervertis: (9*500=4500)
replace interestpaid=4500 if HHID2016=="uuid:9fa560ab-71a7-41c5-bdaf-d53da0ad3848" &	INDID2016==1 &	loanid==3

/******for loans that are not microcredit: quand difference entre interest+principal et totalrepaid, ,
privilegie breakdown interest/principal sinon pb pour attribuer la difference dans les deux cat*/
replace totalrepaid=interestpaid+principalpaid if HHID2016=="uuid:3f2b9b0a-a483-4214-9970-f9e2ce19dd2f" &	INDID2016==1 &	loanid==1
replace totalrepaid=interestpaid+principalpaid if HHID2016=="uuid:45b98913-fe19-44bd-b909-b41246240c8a" &	INDID2016==1 &	loanid==2
replace totalrepaid=interestpaid+principalpaid if HHID2016=="uuid:581b659f-1eb0-42d9-90fd-24779962d15c" &	INDID2016==1 &	loanid==1
replace totalrepaid=interestpaid+principalpaid if HHID2016=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" &	INDID2016==2 &	loanid==4
replace totalrepaid=interestpaid+principalpaid if HHID2016=="uuid:49eaa858-d375-4342-b04c-8ccffa93ea76" &	INDID2016==1 &	loanid==2
replace totalrepaid=interestpaid+principalpaid if HHID2016=="uuid:78ace2c6-a0cf-4eb9-8e2e-aa724df3b886" &	INDID2016==1 &	loanid==1
replace totalrepaid=interestpaid+principalpaid if HHID2016=="uuid:b1974dc2-aad3-49fd-bc31-87bd66179c60" &	INDID2016==1 &	loanid==1
replace totalrepaid=interestpaid+principalpaid if HHID2016=="uuid:e93eca4e-a0b4-491a-8095-eaf70f0305c2" &	INDID2016==1 &	loanid==1


******microcredits:
/* 14 months have been repaid. with totalrepaid, seems to repay 1100 per month. [with interest+principal=1177. let s consider 1100 (probable that was easier to add the monthly payments than distinguish between interest and principal]
means for 24 months, a total interest of 32%, which seems plausible. 
if we abandon the fact that interest may be repaid at the beginning: means 267 interest monthly on average (276 declared) and 833 pincipal
*ie principal: 833*14=11662 (declared: 12614); interest 3728 (3864 declared)*/
replace interestpaid=3728 if HHID2016=="uuid:4ab064bb-3340-4bb9-8fe9-933e36cf60e2" &	INDID2016==2 &	loanid==2
replace principalpaid=11662 if HHID2016=="uuid:4ab064bb-3340-4bb9-8fe9-933e36cf60e2" &	INDID2016==2 &	loanid==2

/*6 month old, seems to have repaid 4 months. (interestpaid=356, interestloan=89)
interest+principal=3728 (vs 3428 totalrepaid) => 932 monthly (vs 857, et 3072 principal); principal 843 monthly (vs 768. 20 000/24=833)
albeit total repaid may be more reliable than the breakdown, here it seems that leads to 26 months of settlement, unusual. in both cases, around 12% interest*/
replace totalrepaid=3728 if HHID2016=="uuid:9dc44802-170f-4aa6-9c19-f633fe8eafc2" &	INDID2016==1 &	loanid==5



****** INTERESTPAID/PRINCIPALPAID RECORDED BUT TOTALREPAID=ONLY PRINCIPALPAID/INTERESTPAID (temporarily excluded, but solved below with loanbalance)

******interest payment is recorded, but total repaid=only principal (3 cases)
/*well known person loan contracted 5 years ago with monthly interestloan 2500; totalrepaid (62500)=roughly principalpaid (65000) 
=> plausible that the interest recorded (that is 19*2500) was paid*/
replace totalrepaid=principalpaid+interestpaid if HHID2016=="uuid:127cd654-d8fe-470e-811c-f322957b8a1c" &	INDID2016==1 &	loanid==3
/*5 year old loan of vehicle financier: amount 400 000, to be repaid monthly
interestfreq=fixed amount, worth 3000. unlikely. total interestpaid declared=63000 (ie 3000*21)
=> likely that both  principal and declared interestpaid have been paid*/
replace totalrepaid=principalpaid+interestpaid if HHID2016=="uuid:7f35c399-5e9d-4d1c-bca8-669afdb94697" &	INDID2016==1 &	loanid==1
*well known person, but looks like a thandal: weekly, fixed amount interest of 10% (3000 out a loan of 30 000). 
*repay duration=20, and 8 weeks repaid, and (27000/20)*8=10800. principal paid recorded=10400 
replace totalrepaid=principalpaid+interestpaid if HHID2016=="uuid:22697a91-f33b-4983-809b-c4cfd2041a6f" & INDID2016==1 & loanid==4

******principal payment is recorded, but total repaid=only interest (7cas)
gen diff_tot_i=totalrepaid-interestpaid
gen iok_pabs=0
replace iok_pabs=1 if diff_tot_i==0 & principalpaid!=0 & test<-200


******principal payment is recorded, but total repaid=only interest, AND: principal repaid=loanamount but the loan is marked unsettled (4 cas)
gen diff_loan_p=loanamount-principalpaid
gen iok_set=0
replace iok_set=1 if diff_tot_i==0 & diff_loan_p==0 & test<-200






********** MISSING VALUES 

replace interestpaid=totalrepaid-principalpaid if HHID2016=="uuid:e847a4d4-ea2a-4a01-95f2-25a37de516e9" &	INDID2016==2 &	loanid==2
replace interestpaid=totalrepaid-principalpaid if HHID2016=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	INDID2016==1 &	loanid==1
replace interestpaid=totalrepaid-principalpaid if HHID2016=="uuid:bd0c2b2a-5af6-424e-9448-bab856ba25f2" &	INDID2016==1 &	loanid==3
replace principalpaid=totalrepaid-interestpaid if HHID2016=="uuid:b95c98da-ac19-4b3d-92f5-57ec528ce4cf" *	INDID2016==1 &	loanid==1
replace interestpaid=0 if HHID2016=="uuid:2d42097c-1f31-4bb8-9a08-7bfac56c60aa" &	INDID2016==1 &	loanid==1
replace interestpaid=0 if HHID2016=="uuid:ffefbaf9-67e2-4a91-b067-c7e1aa134efa" &	INDID2016==1 &	loanid==2


replace interestpaid=0 if totalrepaid==0 & interestpaid==. & dummyinterest==1
replace principalpaid=0 if totalrepaid==0 & principalpaid==.

replace principalpaid=0 if totalrepaid==interestpaid & principalpaid==. & totalrepaid!=. & loanbalance==loanamount


*loan contracted the month of interview, interest principal totalrepaid are missing, may not have started to repay
replace interestpaid=0 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" &	INDID2016==1 &	loanid==3
replace principalpaid=0 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" &	INDID2016==1 &	loanid==3
replace totalrepaid=0 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" &	INDID2016==1 &	loanid==3 
*microcredit loan contracted 2 month ago:  interest principal totalrepaid are missing, may not have started to repay
replace interestpaid=0 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" &	INDID2016==1 &	loanid==2
replace principalpaid=0 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" &	INDID2016==1 &	loanid==2
replace totalrepaid=0 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" &	INDID2016==1 &	loanid==2
*2 year old bank loan but declare that totalrepaid=0:
replace interestpaid=0 if HHID2016=="uuid:b95c98da-ac19-4b3d-92f5-57ec528ce4cf" &	INDID2016==4 &	loanid==1
replace principalpaid=0 if HHID2016=="uuid:b95c98da-ac19-4b3d-92f5-57ec528ce4cf" &	INDID2016==4 &	loanid==1

***loan less than 1 year old with yearly interest
replace interestpaid=0 if HHID2016=="uuid:06a570a1-916a-419d-a8ae-5912a8d9002f" &	INDID2016==1 &	loanid==1

***principal missing but totalrepaid=interestpaid
gen temp=totalrepaid-interestpaid
replace principalpaid=0 if principalpaid==. & temp==0

***interest missing but principalpaid=0 et totalrepaid=0
*1 loan of banker, interest to be repaid every six month, loan is less than 6 month old
replace interestpaid=0 if HHID2016=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" &	INDID2016==4 &	loanid==8


*NE FONCTIONNE PAS CAR JE NAI PAS LA VARIABLE EN QUESTION
* loans (by well known person) with interest to be paid yearly, but loan less than 1 year old
replace interestpaid=0 if interestfreq==3 & diff_month<12 & diff_month!=. & dummyinterest==1 & interestpaid==. & principal==0 & totalrepaid==0 



***interestpaid missing but principalpaid=0 et totalrepaid=0 (12 cases) - surprising that nothing has been paid in some cases (2-3 years) but may be possible
replace interestpaid=0 if dummyinterest==1 & interestpaid==. & principal==0 & totalrepaid==0 




***VARIABLE: 
/*bwda microcredit: 20 000 for 24 months. 13 month old. 20 000/24=around 833 monthly. 
interestloan=866: too large. interestpaid=10392, ie around 800 monthly. too large even if assuming that only interest has been paid since the beginning.
principal repaid: 10008. that is roughly 770 monthly.=> unable to impute*/
gen weird=0
replace weird=1 if HHID2016=="uuid:390905c9-ee49-4e1e-8a4a-80e4741b7140" &	INDID2016==1 &	loanid==2
/* 2 year old well known person loan: amount 500 000. yearly interest 15 0000 (0,03 yearly, quite cheap), total repaid 645 000, unsettled. 
=> the amount repaid declared seem far too big??
maybe an interest of 150 000 yearly (30% yearly)? would make something like 445000 interest, 200 000 principal, but cannot tell*/
replace weird=1 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	INDID2016==1 &	loanid==2
*same issue: 2 year  old well knwon person loan: amount 400 000, 12 000 yearly interest (0,03 yearly),totalrepaid==588000:
replace weird=1 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	INDID2016==1 &	loanid==1

*rien ne fait grand sens sur principalpaid, totalrepaid, loanbalance...
replace weird=1 if HHID2016=="uuid:dbc0eae9-310c-42d5-b1d8-e7d15a51a784" &	INDID2016==2 &	loanid==1

*emprunte 100 000: deux semaines plus tard, a paye 40 000 interet 60 000 principal. ???
replace weird=1 if HHID2016=="uuid:cd65012a-e5b1-4f92-8eed-50ba485b62da" &	INDID2016==2 &	loanid==1


************ VARIABLES
gen excl_interest=0
replace excl_interest=1 if dummyinterest==. |  iok_set==1 | iok_pabs==1 | weird==1 | interestpaid==. & dummyinterest==1 & weird==0

gen excl_debtservice=0
replace excl_debtservice=1 if dummyinterest==. |  iok_set==1 | iok_pabs==1 | weird==1 




***********************************************************************************
*************************************** INTEREST BEARING LOAN

*2 microcredits whose repayement has not started and recorded as without interest
replace dummyinterest=1 if lender4==8 & dummyinterest==0




*********************************************************************************
**************************************** ABERRANT VALUES OF INTEREST

*loan of 68 INR (for agri), repayduration2=12, yearly interest 1140 - idem loanbalance=68
* peut etre 68 lakh ? mais fait beaucoup. (ferait sens avec 68 000 - ie 1,7 % yearly interest, plausible pour une coop bank) 
* j ai remplace par 68 000 ici mais peut etre faudrait il mieux l exclure
replace loanamount=68000 if HHID2016=="uuid:d4ece943-b0c3-457c-8328-68333afaab41" &	INDID2016==1 &	loanid==1
replace loanbalance=68000 if HHID2016=="uuid:d4ece943-b0c3-457c-8328-68333afaab41" &	INDID2016==1 &	loanid==1

*interestloan 1500, 1-2 month old: 30 000 interestpaid
replace interestpaid=3000 if HHID2016=="uuid:6ba477f3-8785-4191-a5da-9af17186dfe5" &	INDID2016==3 &	loanid==6
replace totalrepaid=3000 if HHID2016=="uuid:6ba477f3-8785-4191-a5da-9af17186dfe5" &	INDID2016==3 &	loanid==6
*interestloan 1 200, 2 month old: 20 000 interestpaid
replace interestpaid=2000 if HHID2016=="uuid:a049567e-1188-4e9a-8875-4dce306cffdf" &	INDID2016==1 &	loanid==2
replace totalrepaid=2000 if HHID2016=="uuid:a049567e-1188-4e9a-8875-4dce306cffdf" &	INDID2016==1 &	loanid==2
*interestloan 1 800, 1 month old: 10 000 interestpaid (pay interest whenever have money)
replace interestpaid=1000 if HHID2016=="uuid:a80735af-38ec-4daa-aca0-4c87c64ea92f" &	INDID2016==1 &	loanid==1
replace totalrepaid=1000 if HHID2016=="uuid:a80735af-38ec-4daa-aca0-4c87c64ea92f" &	INDID2016==1 &	loanid==1

*moneylenders loan: (completement outliers) enleve un 0 pour tomber sur des taux a 3 paisa au lieu de 30% par mois
replace interestpaid=1500 if HHID2016=="uuid:30187ee9-dd3b-4a82-b20f-6ec0db908a4c" &	INDID2016==1 &	loanid==1
replace interestloan=150 if HHID2016=="uuid:30187ee9-dd3b-4a82-b20f-6ec0db908a4c" &	INDID2016==1 &	loanid==1
replace totalrepaid=1500 if HHID2016=="uuid:30187ee9-dd3b-4a82-b20f-6ec0db908a4c" &	INDID2016==1 &	loanid==1
*idem pour un well-known person:
replace interestpaid=10800 if HHID2016=="uuid:a049567e-1188-4e9a-8875-4dce306cffdf" &	INDID2016==1 &	loanid==1
replace interestloan=450 if HHID2016=="uuid:a049567e-1188-4e9a-8875-4dce306cffdf" &	INDID2016==1 &	loanid==1
replace totalrepaid=10800 if HHID2016=="uuid:a049567e-1188-4e9a-8875-4dce306cffdf" &	INDID2016==1 &	loanid==1

*interestpaid=0 instead of 1:
replace interestpaid=0 if HHID2016=="uuid:877d0560-5981-491b-b780-6585bf924814" &	INDID2016==1 &	loanid==1



/*************************************************************************************
**************************************** CHECK TEMPORALITY OF INTEREST PAYMENT (put value 7 when does not really fall in a precise category)
									+ TEST: compute the precise number of months of interest repaid (using interestloan and interestpaid) 
to check for aberrant values of interest (not taking into account the fact that some monthly repayments may have been forgotten)
=> aim: check for dubious values(to be followed later by test for outliers with the "real" duration - not a good way to do, need to mix the two)
precise number of months will then be kept only for microcredit
for the others, repayduration2 will be tested and if not usable, time between survey and loan is used*/



**** MONTLY REPAYMENT (repayduration1 & interestfreq) 

gen month_repaid=.
replace month_repaid=interestpaid/interestloan if months<=12 & excl_interest==0  & dummyinterest==1 & repayduration1==2 & interestfreq==2
*comme remboursement microcredit reguliers:
replace month_repaid=interestpaid/interestloan if months>12 & months!=. & lender4==8

replace month_repaid=months if HHID2016=="uuid:ccf91767-f881-4a7c-b80a-625bde97a4d1" &	INDID2016==1 &	loanid==3
replace month_repaid=3 if HHID2016=="uuid:c2d03ebc-5c0e-415a-a655-001859f7a68f" *	INDID2016==5 &	loanid==1
replace interestpaid=580 if HHID2016=="uuid:2fed18dd-dce7-44ce-821b-164c65a718b9" &	INDID2016==2 &	loanid==1
replace month_repaid=5 if HHID2016=="uuid:2fed18dd-dce7-44ce-821b-164c65a718b9" &	INDID2016==2 &	loanid==1
/*microcredit: avec le calcul du monthly instalment aec total repaid + interest loan:
(les deux concordent:  total interest sur 2 ans avec total repaid: 75%. total interest avec interestloan: 75%)*/
replace principalpaid=7506 if HHID2016=="uuid:a0c7053d-b228-49e4-ae9e-0188603e1811" &	INDID2016==1 &	loanid==2
replace interestpaid=5580 if HHID2016=="uuid:a0c7053d-b228-49e4-ae9e-0188603e1811" &	INDID2016==1 &	loanid==2
replace month_repaid=9 if HHID2016=="uuid:a0c7053d-b228-49e4-ae9e-0188603e1811" &	INDID2016==1 &	loanid==2
replace month_repaid=6 if HHID2016=="uuid:e73b9bd7-f7f3-4ac0-b360-ffcd09758ff4" &	INDID2016==1 &	loanid==1
replace month_repaid=7 if HHID2016=="uuid:55d4d934-626c-49e7-b1ad-ee4daf8b1a4a" *	INDID2016==1 &	loanid==1
replace month_repaid=10 if HHID2016=="uuid:7dff3ca3-e693-4df2-a2bd-a60549a1cae7" &	INDID2016==1 &	loanid==1
replace month_repaid=10 if HHID2016=="uuid:c2d03ebc-5c0e-415a-a655-001859f7a68f" &	INDID2016==4 &	loanid==2
gen repayduration22=repayduration2
replace repayduration22=27 if HHID2016=="uuid:508123db-1452-4e98-a882-b556f8a91302" &	INDID2016==1 &	loanid==1

replace month_repaid=0 if months==0 & totalrepaid==0
replace month_repaid=1 if months==0 & totalrepaid!=0 & totalrepaid!=. & repayduration1==2
replace month_repaid=0 if HHID2016=="uuid:2d42097c-1f31-4bb8-9a08-7bfac56c60aa" &	INDID2016==1 &	loanid==1
replace month_repaid=1 if HHID2016=="uuid:544225ab-5dc2-4a81-9d0d-cd21b5d749fa" &	INDID2016==1 &	loanid==3
replace month_repaid=0 if HHID2016=="uuid:ffefbaf9-67e2-4a91-b067-c7e1aa134efa" &	INDID2016==1 &	loanid==2
replace month_repaid=4 if HHID2016=="uuid:9dc44802-170f-4aa6-9c19-f633fe8eafc2" &	INDID2016==1 &	loanid==5
replace repayduration22=24 if HHID2016=="uuid:9dc44802-170f-4aa6-9c19-f633fe8eafc2" &	INDID2016==1 &	loanid==5


/*24 month old microcredit: interestpaid, interestloan missing; loanamount=100 000, principalpaid=70 000, totalpaid 100 0000, repayduration 24 months
unsettled. loanamount/repayduration2= roughly 4176. principalpaid/4176 = roughly 16,8.
totalrepaid/16 = 6250 (chiffre rond). principalpaid/16=4375 (idem). would mean: interestpaid=(6250-4575)*16=26800. seems plausible.*/
replace month_repaid=16 if HHID2016=="uuid:8d8cacc3-38f9-4630-9719-edd639102ad0" &	INDID2016==2 &	loanid==1
replace interestpaid=26800 if HHID2016=="uuid:8d8cacc3-38f9-4630-9719-edd639102ad0" &	INDID2016==2 &	loanid==1
replace principalpaid=totalrepaid-26800 if HHID2016=="uuid:8d8cacc3-38f9-4630-9719-edd639102ad0" &	INDID2016==2 &	loanid==1
replace dummyinterest=1 if HHID2016=="uuid:8d8cacc3-38f9-4630-9719-edd639102ad0" &	INDID2016==2 &	loanid==1


gen pb=0
***microcredits: 
*avec les instalments renseignes, le pret ne serait pas rembourse a la fin de la periode
replace pb=1 if HHID2016=="uuid:b14c5315-9be2-4edf-9954-a9cee0e13162" &	INDID2016==2 &	loanid==2
*idem: pour que coherence avec interestloan, il faudrait 51998 totalrepaid au lieu de 49998. mais on aurait un total d interet de 3% pour 39 mois !
replace pb=1 if HHID2016=="uuid:89f0734d-db4a-4660-8c9f-c54fcd6f8ddb" &	INDID2016==1 &	loanid==1
*idem: total<principal, et with interest loan, on arrive a 5% d interet poour 24 mois
*il faudrait 2083 par mois juste pour rembourser le principal; on a ici
replace pb=1 if HHID2016=="uuid:0bd2d8b2-5a95-4f16-b9cc-5414151710d1" &	INDID2016==1 &	loanid==1
*idem: total instalment=pile principal; et selon interest loan, on aurait un total de 5% d interet pour 17 mois
replace pb=1 if HHID2016=="uuid:0742a50d-0a67-46f7-ba6b-b65092b7761b" &	INDID2016==4 &	loanid==1
/*10 month old microcredit: avec interest loan (3000, a remplacer par 300): seems to have paid 10 month, but at this rythm the loan would not be settled
en se basant sur interest loan: would mean 1967 monthly, et 16% d interet pour 12 mois 
=> on pourrait potentiellement imputer completement, mais etrange que le totalrepaid ne fasse pas sens */
replace pb=1 if HHID2016=="uuid:318a9c1c-e92a-4c81-bafe-eb1973e94702" &	INDID2016==1 &	loanid==1
*tres etrange: 5 yearly old microcredit, with 700 yearly interest for a loan of 80 000 (0,9% pa). interestloan has been paid 5 times, but only the interest.
replace pb=1 if HHID2016=="uuid:7e8b1a8c-3964-4a34-abdc-c8c605849b1f" &	INDID2016==2 &	loanid==1

***autres:
*3 month old loan by relative 3 paisa (900 monthly): but 8000 paid: y a t un pb de 0 en trop ?
replace pb=1 if HHID2016=="uuid:4ab064bb-3340-4bb9-8fe9-933e36cf60e2" &	INDID2016==1 &	loanid==1






**** INTEREST WEEKLY REPAYMENT (interestfreq) - LESS THAN ONE YEAR:

replace month_repaid=(interestpaid/interestloan)/4 if months<=12 & excl_interest==0  & dummyinterest==1 & interestfreq==1

*bank loan: repayment interest is recorded weekly, but monthly seems more plausible with the data:
replace interestfreq=2 if HHID2016=="uuid:233d292c-867e-45ef-aad1-af8ee4ef3804" &	INDID2016==1 &	loanid==1
replace month_repaid=4 if HHID2016=="uuid:233d292c-867e-45ef-aad1-af8ee4ef3804" &	INDID2016==1 &	loanid==1
replace repayduration1=2 if HHID2016=="uuid:233d292c-867e-45ef-aad1-af8ee4ef3804" &	INDID2016==1 &	loanid==1



**** INTEREST ONCE IN 6 MONTHS
*16 month old friend loan: interest supposed once in 6 months, but has been paid 12 times (means 3 paisa per month for these 12 months)
replace interestfreq=2 if HHID2016=="uuid:1c8ab7d5-6d4c-41eb-b440-68c930e30c72" &	INDID2016==1 &	loanid==1

*interest paid more often than every six months
replace interestfreq=7 if HHID2016=="uuid:8ddf086d-0993-4ff7-813b-1f63dd46b1bf" &	INDID2016==1 &	loanid==1
replace interestfreq=7 if HHID2016=="uuid:d1f4bc1e-b59a-4ddb-831b-266adc1ba452" &	INDID2016==1 &	loanid==1
replace interestfreq=7 if HHID2016=="uuid:e804beec-7f01-4be3-88d9-fa9ad870149a" &	INDID2016==1 &	loanid==2
replace interestfreq=7 if HHID2016=="uuid:f2a2808d-0a25-4b77-ac03-c50c501987c2" &	INDID2016==1 &	loanid==2


**** INTEREST FIXED AMOUNT
**compare when interestloan different from interestpaid (supposed to be the same if fixed amount):

*4 year old loan with interestloan paid 4 times
replace interestfreq=3 if HHID2016=="uuid:2fd71d69-8643-44bc-93f5-8ea6b8289cf8" &	INDID2016==1 &	loanid==2

*12 month old bank loan with interestloan paid 12 times
replace interestfreq=2 if HHID2016=="uuid:3f9cffe9-c7a8-4057-afd6-b2e14e4a36b8" &	INDID2016==1 &	loanid==2

*19 month old moneylender loan with interestloan paid 15 times
replace interestfreq=2 if HHID2016=="uuid:ebfb1d75-ba54-49a7-a324-affb036c88aa" &	INDID2016==1 &	loanid==1
replace month_repaid=15 if HHID2016=="uuid:ebfb1d75-ba54-49a7-a324-affb036c88aa" &	INDID2016==1 &	loanid==1
 
*microcredits, weekly or monthly
replace interestfreq=1 if HHID2016=="uuid:88f78363-66a3-4359-8e33-af913f9b5699" &	INDID2016==1 &	loanid==2
replace month_repaid=13 if HHID2016=="uuid:88f78363-66a3-4359-8e33-af913f9b5699" &	INDID2016==1 &	loanid==2
replace interestfreq=2 if HHID2016=="uuid:d32ae647-fc9a-40bf-8161-5919a7a1e6ea" & INDID2016==1 &	loanid==1
replace month_repaid=25 if HHID2016=="uuid:d32ae647-fc9a-40bf-8161-5919a7a1e6ea" & INDID2016==1 &	loanid==1
replace interestfreq=2 if HHID2016=="uuid:e847a4d4-ea2a-4a01-95f2-25a37de516e9" &	INDID2016==2 &	loanid==1
replace month_repaid=4 if HHID2016=="uuid:e847a4d4-ea2a-4a01-95f2-25a37de516e9" &	INDID2016==2 &	loanid==1

/*IMPUTATION UN PEU DOUTEUSE, a voir si exclure:
microcredit:with repayduration(24 month) and instalments deducted from totalrepaid, would mean more than 100% interest
and with interestloan and interestpaid, would mean 7% interest in total on the 24 months 
--> if consider that repayduration=12 months, with instalments from total repaid, would mean 11%*/
replace interestfreq=2 if HHID2016=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	INDID2016==1 &	loanid==1
replace repayduration22=12 if HHID2016=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	INDID2016==1 &	loanid==1
replace interestpaid=193 if HHID2016=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	INDID2016==1 &	loanid==1
replace principalpaid=1667 if HHID2016=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	INDID2016==1 &	loanid==1
replace month_repaid=1 if HHID2016=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	INDID2016==1 &	loanid==1

/*65 month old moneylender loan with interestloan paid 21 times: peut etre monthly or whenever have money
->  l essentiel est que ce ne soit pas enregistre en fixed amount, ajout d une valeur dans interestfreq*/
replace interestfreq=7 if HHID2016=="uuid:7f35c399-5e9d-4d1c-bca8-669afdb94697" & INDID2016==1 &	loanid==1

*idem: 25 month old bank loan with interestloan paid roughly 13 times 
replace interestfreq=2 if HHID2016=="uuid:3f9cffe9-c7a8-4057-afd6-b2e14e4a36b8" &	INDID2016==1 &	loanid==1


***************** LOANS MORE THAN ONE YEAR:

**verification duree de remboursement pour microcredit
replace month_repaid=interestpaid/interestloan if lender4==8 & months>12 & months!=. & excl_interest==0 & pb==0 & repayduration1==2
*microcredit contracted 67 months before, put 18 months paid:
replace month_repaid=18 if HHID2016=="uuid:89f0734d-db4a-4660-8c9f-c54fcd6f8ddb" &	INDID2016==1 &	loanid==2

*IMPOSSIBLE DE FAIRE SENS DE REPAYDURATION2 (nb months repaid or total duration of the loan)




*YEARLY INTEREST

*6 year old loan, interest loan paid 12 times:
replace interestfreq=4 if HHID2016=="uuid:059ce108-5334-44cd-840c-2e160267046b" &	INDID2016==1 &	loanid==1
*32 month old loan, interestloan paid 20 times:
replace interestfreq=7 if HHID2016=="uuid:61facd1e-9777-4333-8ec1-f00d45042f60" &	INDID2016==1 &	loanid==1 & loanid==1
*between 12 and 13 month old loan, interest loan paid 13 times (to be recorded below in loan_months)
replace interestfreq=2 if HHID2016=="uuid:6200de71-614d-4732-91e4-b698f362a2c3" &	INDID2016==1 &	loanid==1
*13 month old loan, interestloan paid 12 times (to be recorded below in loan_months)
replace interestfreq=2 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	INDID2016==1 &	loanid==3
*44 month old loan, interestloan paid 30 times
replace interestfreq=7 if HHID2016=="uuid:7ae6bf58-39d2-42ca-a4b8-4c435e1e5a1f" &	INDID2016==1 &	loanid==2
*43 month old loan, interestloan paid 50 times
replace interestfreq=2 if HHID2016=="uuid:7ae6bf58-39d2-42ca-a4b8-4c435e1e5a1f" &	INDID2016==1 &	loanid==3
*44 month old loan, interestloan paid around 26 times
replace interestfreq=7 if HHID2016=="uuid:7ae6bf58-39d2-42ca-a4b8-4c435e1e5a1f" &	INDID2016==1 &	loanid==1
*30 month old loan, interestloan paid 24 times
replace interestfreq=7 if  HHID2016=="uuid:8b248da2-20f8-4d33-b1f1-48b1d1756522" &	INDID2016==1 &	loanid==1
*13 month old loan, interestloan paid 12 times (to be recorded below in loan_months)
replace interestfreq=2 if HHID2016=="uuid:a83605b5-7618-41a2-b2b7-0838fe3503da" &	INDID2016==1 &	loanid==5
*24 month old loan, interestloan paid 12 times
replace interestfreq=7 if HHID2016=="uuid:ba97ea13-f20c-4518-86b9-e29e4e091ce6" &	INDID2016==1 &	loanid==1
*25 month old loan, interestloan paid 12 times
replace interestfreq=7 if HHID2016=="uuid:d3f50299-ac34-4600-a662-d15ba1383d6e" &	INDID2016==8 &	loanid==1
*48 month old loan, interest loan paid 30 times
replace interestfreq=7 if HHID2016=="uuid:e066c0e4-863e-42fe-8f9f-d52486ee5c58" &	INDID2016==1 &	loanid==3
*36 month old loan, interstloan paid 20 times
replace interestfreq=7 if HHID2016=="uuid:ee73e76e-b047-4e85-85fd-b3acc589d1b8" &	INDID2016==1 &	loanid==3
*24 month old loan, interestloan paid 15 times
replace interestfreq=7 if HHID2016=="uuid:ee73e76e-b047-4e85-85fd-b3acc589d1b8" &	INDID2016==1 &	loanid==1
*24 month old, 15 times
replace interestfreq=7 if  HHID2016=="uuid:ee73e76e-b047-4e85-85fd-b3acc589d1b8" &	INDID2016==1 &	loanid==2
*99 month old, around 37 times
replace interestfreq=7 if HHID2016=="uuid:00b05341-085a-46ad-9776-f1272b6872e6" &	INDID2016==1 &	loanid==1
*15 month old, around 6 times
replace interestfreq=7 if HHID2016=="uuid:521600d7-e364-42fc-8f0d-f799e74637e1" &	INDID2016==1 &	loanid==5
*43 month old, around 8 times
replace interestfreq=7 if HHID2016=="uuid:3502a333-6356-4267-ad32-ad6d32029c51" &	INDID2016==1 &	loanid==2
/*60 month old bank loan, 10 months repaid (repayduration 36, according to interest loans: would mean 12% yearly. 
mais on ne sait pas si commence a rembourser il y a 10 mois ou 60...) */
replace interestfreq=7 if HHID2016=="uuid:c2fda044-d053-47b2-b693-58d34e7f70be" &	INDID2016==1 &	loanid==1
*13 month old, 10 times
replace interestfreq=2 if HHID2016=="uuid:e93eca4e-a0b4-491a-8095-eaf70f0305c2" &	INDID2016==1 &	loanid==1

replace interestfreq=7 if HHID2016=="uuid:94e1ec13-3618-4995-bd9d-eb810d9ade40" &	INDID2016==1 &	loanid==2
replace interestfreq=2 if HHID2016=="uuid:c75ad8b5-c773-408f-8066-f8327ccc6bdc" &	INDID2016==1 &	loanid==2
replace interestfreq=7 if HHID2016=="uuid:cb4fe354-df11-45c2-b5e8-17b4ab087187" &	INDID2016==1 &	loanid==1
replace interestfreq=7 if HHID2016=="uuid:f7fae8d2-4c28-44bd-957a-209ed70741f3" &	INDID2016==1 &	loanid==2
replace interestfreq=7 if HHID2016=="uuid:5f4c151e-62e4-4f22-b88f-2aad8e3dc0f3" &	INDID2016==1 &	loanid==3



*18 month old agri coop bank, 1 time paid: but loan amount 100 000, yearly interest 600... (and repayduration2=600...)
replace pb=1 if HHID2016=="uuid:da893017-2541-42dc-9dab-d517d777b92b" &	INDID2016==1 &	loanid==1

replace excl_interest=1 if pb==1
replace excl_debt=1 if pb==1







***************************************************************************************************************************************************************
****************************************************** ECHANTILLON & VARIABLES - FINAL
***************************************************************************************************************************************************************

********************************************************************************
************************************************ ECHANTILLON


*pour ne pas multiplier les details, on s en tient a l echantillon ou on peut calculer le debt service et l interest service
gen included=0
replace included=1 if excl_debt==0 & excl_int==0
replace included=. if dummyinterest==.

*bilan sur les prets exclus:
gen explication=""
replace explication="principalpaid recorded, but total repaid=only interest" if iok_pabs==1
replace explication="principalpaid recorded, but total repaid=only interest, AND: principal repaid=loanamount but loan unsettled" if iok_set==1
replace explication="microcredit pb instalment" if HHID2016=="uuid:390905c9-ee49-4e1e-8a4a-80e4741b7140" &	INDID2016==1 &	loanid==2
replace explication="microcredit pb instalment" if HHID2016=="uuid:b14c5315-9be2-4edf-9954-a9cee0e13162" &	INDID2016==2 &	loanid==2
replace explication="microcredit pb instalment" if HHID2016=="uuid:89f0734d-db4a-4660-8c9f-c54fcd6f8ddb" &	INDID2016==1 &	loanid==1
replace explication="microcredit pb instalment" if HHID2016=="uuid:0bd2d8b2-5a95-4f16-b9cc-5414151710d1" &	INDID2016==1 &	loanid==1
replace explication="microcredit pb instalment" if HHID2016=="uuid:0742a50d-0a67-46f7-ba6b-b65092b7761b" &	INDID2016==4 &	loanid==1
replace explication="microcredit pb instalment" if HHID2016=="uuid:318a9c1c-e92a-4c81-bafe-eb1973e94702" &	INDID2016==1 &	loanid==1
replace explication="what has been repaid is quite higher than expected from interestloan and loanamount, and loan still unsettled" if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	INDID2016==1 &	loanid==2 | HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	INDID2016==1 &	loanid==1
replace explication="incoherence between interestloan, interestpaid and duration" if HHID2016=="uuid:4ab064bb-3340-4bb9-8fe9-933e36cf60e2" &	INDID2016==1 &	loanid==1
replace explication="totalrepaid recorded, not interestpaid" if HHID2016=="uuid:142053fe-243a-4035-8746-93dd30108d22" &	INDID2016==1 &	loanid==2
replace explication="totalrepaid recorded, not interestpaid" if HHID2016=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	INDID2016==2 &	loanid==1
replace explication="interest far too low" if HHID2016=="uuid:da893017-2541-42dc-9dab-d517d777b92b" &	INDID2016==1 &	loanid==1
replace explication="microcredit only interest yearly paid, at a rate pa of 0,9%" if  HHID2016=="uuid:7e8b1a8c-3964-4a34-abdc-c8c605849b1f" &	INDID2016==2 &	loanid==1




********************************************************************************
************************************* LOAN DURATION



****FOR MONTHLY, WEEKLY, WHENEVER HAVE MONEY, OR IMPUTED AS UNCLEAR (interestfreq==7) 

/*for microcredit, since regular repayment, duration considered is the precise number of months repaid. 
for the others, difference between loan date and interview date - arrondi a l entier inferieur*/
gen loan_months=.
replace loan_months=months  if interestfreq==1 | interestfreq==2 | interestfreq==6 | interestfreq==7
replace loan_months=month_repaid if lender4==8 & interestfreq==2


*arrondi a l entier superieur sur la base de interestpaid/interestloan
replace loan_months=13 if HHID2016=="uuid:6200de71-614d-4732-91e4-b698f362a2c3" &	INDID2016==1 &	loanid==1
replace loan_months=12 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	INDID2016==1 &	loanid==3
replace loan_months=12 if HHID2016=="uuid:a83605b5-7618-41a2-b2b7-0838fe3503da" &	INDID2016==1 &	loanid==5
replace loan_month=1 if loan_month<1 & interestfreq==2 & interestpaid!=0 |  loan_month<1 & interestfreq==6 & interestpaid!=0
replace loan_month=2 if HHID2016=="uuid:6ba477f3-8785-4191-a5da-9af17186dfe5" &	INDID2016==3 &	loanid==6



******** USE REPAYDURATION2: 

*if repayduration2 lower than the time since the loan was contracted, may designate the actual time since repayment started (rather than loan total duration)
*consider than when answered 12, 24 or 36 months, liekly to designate the total duration

***** MONTHLY

*month_repaid (or interestpaid/interestloan) and repayduration2 coherents:
replace loan_month=repayduration2 if HHID2016=="uuid:07be751d-08a0-4a5c-b1e5-9634a002969b" &	INDID2016==1 &	loanid==1
replace loan_month=12 if HHID2016=="uuid:3f9cffe9-c7a8-4057-afd6-b2e14e4a36b8" &	INDID2016==1 &	loanid==2
replace loan_month=repayduration2 if HHID2016=="uuid:62ad7210-2d2c-4e4d-a8c6-6501a63d2fee" &	INDID2016==1 &	loanid==2
replace loan_month=repayduration2 if HHID2016=="uuid:bb9aa5b8-af37-40d9-9fab-c6e489a9bdc8" &	INDID2016==1 &	loanid==1
replace loan_month=repayduration2 if HHID2016=="uuid:fb2fc753-1d99-41b9-8d73-89d27b600fd1" &	INDID2016==1 &	loanid==1
replace loan_month=repayduration2 if HHID2016=="uuid:fb2fc753-1d99-41b9-8d73-89d27b600fd1" &	INDID2016==1 &	loanid==2
replace loan_month=repayduration2 if HHID2016=="uuid:f78e2a2e-280c-4f60-b991-76b5968c4b84" &	INDID2016==1 &	loanid==2
replace loan_month=repayduration2 if HHID2016=="uuid:a97afa4a-6283-492c-bf11-dd9269d400da" &	INDID2016==2 &	loanid==2
*56 months old; repayduration1 yearly and repayduration2=2 years, and interestfreq=monthly and 19 months of interestloan paid
replace loan_months=24 if HHID2016=="uuid:127cd654-d8fe-470e-811c-f322957b8a1c" &	INDID2016==1 &	loanid==3
*25 month old loan, repayduration1 yearly and repayduration2=2 years, and interestfreq=monthly and 13 months of interestloan paid
replace loan_months=24 if HHID2016=="uuid:3f9cffe9-c7a8-4057-afd6-b2e14e4a36b8" &	INDID2016==1 &	loanid==1
*bank loan contracted 5 years before: frequency is monthly, repayduration2=7; paid nothing
replace loan_month=repayduration2 if HHID2016=="uuid:c1dc5f5e-c49f-42e2-8460-3b3e2faeb9a9" &	INDID2016==1 &	loanid==1

*if difference between month_repaid and time since the loan was contracted=1 month: take month_repaid 
drop temp
gen temp=loan_months-month_repaid
replace loan_month=month_repaid if temp==1 & interestfreq==2 & totalrepaid!=0 | temp==-1 & interestfreq==2  & totalrepaid!=0
drop temp



******* YEARLY INTEREST PAYMENT


gen years=.
replace years=months/12 if interestfreq==3
gen loan_years=floor(years)

replace loan_years=repayduration2 if HHID2016=="uuid:9dd01961-376f-4f5d-add7-b2af01be9107" &	INDID2016==1 &	loanid==1
replace loan_years=1 if HHID2016=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" &	INDID2016==2 &	loanid==3

*instead of 0 (because has paid):
replace loan_year=1 if HHID2016=="uuid:b6802956-c0b6-442e-b416-73d9acd4d137" &	INDID2016==1 &	loanid==2
replace loan_year=1 if  HHID2016=="uuid:d4ece943-b0c3-457c-8328-68333afaab41" &	INDID2016==1 &	loanid==1
replace loan_year=1 if HHID2016=="uuid:15a2311a-c10d-462d-8a50-29a67b91b739" &	INDID2016==1 &	loanid==3

**repayduration2 missing:
*consider that when start to repay bank loan, repayment is regular (dubidous)
replace loan_year=3 if HHID2016=="uuid:15a2311a-c10d-462d-8a50-29a67b91b739" &	INDID2016==1 &	loanid==1




******* WEEKLY: thandal. consider that interestpaid/interestloan=nb week repaid. arrondi a l entier superieur.

gen weeks=.
replace weeks=interestpaid/interestloan if interestfreq==1
gen loan_weeks=round(weeks,1)




******** FIXED AMOUNT

**repayduration1=weekly 
replace loan_weeks=repayduration2 if HHID2016=="uuid:04126475-75a2-4e1e-9f0d-a5e57163a4e6" &	INDID2016==1 &	loanid==3
replace loan_weeks=months*4 if HHID2016=="uuid:22697a91-f33b-4983-809b-c4cfd2041a6f" &	INDID2016==1 &	loanid==4
replace loan_weeks=repayduration2 if HHID2016=="uuid:f39eabe6-b8cd-4bc6-af03-f6b1bf1384eb" &	INDID2016==1 &	loanid==1
*4 month old thandal. repayduration 30 weeks. 600 principal paid. with 50 weekly, 3 months repaid.
replace loan_weeks=12 if HHID2016=="uuid:287cdedc-cf23-44f2-8e76-55aba844250a" &	INDID2016==1 &	loanid==1

replace loan_months=months if interestfreq==5 & repayduration1==. & repayduration2==. 

*mystere: 9month old microcredit with fixed amount interest. 8 mois parait le plus plausible 
replace loan_months=8 if HHID2016=="uuid:318a9c1c-e92a-4c81-bafe-eb1973e94702" &	INDID2016==1 &	loanid==1

*bank, repayduration1=yearly
replace loan_year=repayduration2 if HHID2016=="uuid:1b1c8141-0b67-42a1-990c-78d15a624f50" &	INDID2016==1 &	loanid==1


***** ONCE IN SIX MONTHS

**si rien n a ete rembourse: duree de remboursement=temps depuis que le pret a ete contracte. pose pas de probleme pour debt service
replace loan_months=months if totalrepaid==0 & repayduration2==. & interestfreq==4
replace loan_months=months if HHID2016=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" &	INDID2016==4 &	loanid==8

**repayduration2 plausible:
replace loan_month=repayduration2 if HHID2016=="uuid:059ce108-5334-44cd-840c-2e160267046b" &	INDID2016==1 &	loanid==1
replace loan_month=repayduration2 if HHID2016=="uuid:241622a1-14b6-4cdd-830e-45ea031ae1f3" &	INDID2016==2 &	loanid==2

***bank loan: consider than repayments are regular when start (dubious. but seems to have a lot of delay). interestloan coherent avec repayduration2.
replace loan_month=12 if HHID2016=="uuid:813a12d2-a425-496e-9441-e3991adb8c30" &	INDID2016==1 &	loanid==1

***repayduration2 missing:
**12 month old loan, interest paid only one time: replace loan_month==11 (vs 12; plausible) juste pour justifier le fait que rembourse une seule fois 
replace loan_month=11 if HHID2016=="uuid:0f421b5c-b081-416c-a8ca-93c430d0961e" &	INDID2016==1 &	loanid==1
**bank loan: consider than repayments are regular when start (dubious. but seems to have a lot of delay)
replace loan_month=18 if HHID2016=="uuid:da893017-2541-42dc-9dab-d517d777b92b" &	INDID2016==1 &	loanid==2
replace loan_month=48 if HHID2016=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" &	INDID2016==2 & loanid==4

replace loan_month=months if HHID2016=="uuid:78817304-5ca2-42d3-9b67-843366b5afde" &	INDID2016==1 &	loanid==2

*74 month old loan; repayduration2=36, but interestloan repaid 72 times
replace loan_month=72 if HHID2016=="uuid:059ce108-5334-44cd-840c-2e160267046b" & INDID2016==1 &	loanid==1



**** INTEREST WHENEVER HAVE MONEY

*repayduration2 credible:
replace loan_month=repayduration2*12 if HHID2016=="uuid:5972238d-013a-411b-8e6e-14da561e45f7" &	INDID2016==1 &	loanid==2
replace loan_month=13 if HHID2016=="uuid:e3d5075a-9dad-4278-a125-a2dd01cdf99b" &	INDID2016==1 &	loanid==1

*interestloan paid aroudn 17 times, loan 21 month old, repay principal and interest whenever have money
replace loan_month=months if HHID2016=="uuid:4e015d7e-1ce4-4f87-bc7d-a9a67c0aab86" &	INDID2016==1 &	loanid==2

/*si repayduration2 seems to represent the total duration of the loan, and is far lower than the time since the loan was contracted:
to limit the downward bias, set a kind of max value for number of months repaid ie repayduration2 (si coherent)*/
replace loan_month=repayduration2 if HHID2016=="uuid:584cb9e3-eb1c-4e6a-b6c7-46a58eb17e46" &	INDID2016==1 &	loanid==1
replace loan_month=repayduration2 if HHID2016=="uuid:8380069d-0c7d-41f6-b487-dd4e66377170" &	INDID2016==2 &	loanid==1



**** interestfreq=7

*repayduration2 credible:
replace loan_month=repayduration2*12 if HHID2016=="uuid:3502a333-6356-4267-ad32-ad6d32029c51" &	INDID2016==1 &	loanid==2
replace loan_month=repayduration2*12 if HHID2016=="uuid:ba97ea13-f20c-4518-86b9-e29e4e091ce6" &	INDID2016==1 &	loanid==1

/*si repayduration2 seems to represent the total duration of the loan, and is far lower than the time since the loan was contracted:
to limit the downward bias, set a kind of max value for number of months repaid ie repayduration2 (si coherent)*/
replace loan_month=repayduration2 if HHID2016=="uuid:5f4c151e-62e4-4f22-b88f-2aad8e3dc0f3" &	INDID2016==1 &	loanid==3
replace loan_month=repayduration2 if HHID2016=="uuid:c2fda044-d053-47b2-b693-58d34e7f70be" & INDID2016==1 &	loanid==1



 
replace loan_months=loan_weeks/4 if loan_weeks!=.
replace loan_months=loan_year*12 if loan_year!=.
replace loan_months=months if loan_year==0

************ INTERESTFREQ MISSING
replace loan_months=months if interestfreq==. & totalrepaid==0 & included==1
replace loan_months=months if dummyinterest==0 & repayduration2==. & included==1
*microcredit: would mean 13 % pa
replace loan_month=repayduration2 if HHID2016=="uuid:8d8cacc3-38f9-4630-9719-edd639102ad0" &	INDID2016==2 &	loanid==1
replace interestfreq=2 if HHID2016=="uuid:8d8cacc3-38f9-4630-9719-edd639102ad0" &	INDID2016==2 &	loanid==1

*repayduration2 useless (total duration)
replace loan_month=months if HHID2016=="uuid:01e2263f-26de-447d-87c5-f9af8c177bbf" &	INDID2016==1 &	loanid==1
replace loan_month=months if HHID2016=="uuid:0e075c0e-4b4a-461b-af2c-b61c39347738" &	INDID2016==1 &	loanid==2

****if repayduration2 lower than time since loan contracted, take repayduration2: either real nb of months repaid, or maximum (if coherent with interest)
replace loan_month=repayduration2*12 if HHID2016=="uuid:127cd654-d8fe-470e-811c-f322957b8a1c" &	INDID2016==1 &	loanid==1

*yearly payment:
gen temp=.
replace temp=repayduration2*12 - months if repayduration1==3
replace temp=. if dummyinterest!=0 | dummyinterest==0 & loan_month!=.
replace loan_month=repayduration2*12 if temp<0
drop temp
*monthly
gen temp=.
replace temp=repayduration2 - months if repayduration1==2
replace temp=. if dummyinterest!=0 | dummyinterest==0 & loan_month!=.
replace loan_month=repayduration2 if temp<0
drop temp
*one in six month:
replace loan_month=repayduration2*6 if HHID2016=="uuid:2fd71d69-8643-44bc-93f5-8ea6b8289cf8" &	INDID2016==1 &	loanid==3
replace loan_month=months if HHID2016=="uuid:3ed13d21-3fbd-4a33-a557-48b68f5ed065" &	INDID2016==1 &	loanid==2
*3 year old loan, repayduration2=2
replace loan_month=24 if HHID2016=="uuid:7271ec5d-69a1-4a3f-949f-3d98fd6efa1c" &	INDID2016==1 &	loanid==1
replace repayduration2=3 if HHID2016=="uuid:7271ec5d-69a1-4a3f-949f-3d98fd6efa1c" &	INDID2016==1 &	loanid==1



*repayduration2> time since loan contracted 
replace loan_month=months if dummyinterest==0 & loan_month==. & included==1



************************************************************************************************************************************************************
*********************************************************** USE LOANBALANCE

replace loanbalance=0 if loansettled==1

**** LOANBALANCE MISSING for unsettled loans: 8 cas


*** ISSUE of 0 in loanamount
*neighbour loan: loanamount 500 000, loanalance 50 000. with 50 000, make monthly interest of 3% instead of 0,3
replace loanamount=50000 if HHID2016=="uuid:5bd7eec6-42a4-4832-abe2-137e512ee78a" &	INDID2016==1 &	loanid==2
*same thing, with interest 2% instead of 0,2
replace loanamount=50000 if HHID2016=="uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006" &	INDID2016==1 &	loanid==1
*loan amount 3000, loan balance 20 000
replace loanamount=10*loanamount if HHID2016=="uuid:a12bbf07-88f1-46fb-a255-6a6b6706f2c3" &	INDID2016==1 &	loanid==2
replace loanamount=10*loanamount if HHID2016=="uuid:fb4500c5-a106-4dcf-a49b-477722865e9f" &	INDID2016==2 &	loanid==3
*loanamount 2000, loanbalance 20 000 
replace loanamount=loanamount*10 if HHID2016=="uuid:e804beec-7f01-4be3-88d9-fa9ad870149a" &	INDID2016==1 &	loanid==3
*300 neighbour loan vs 3000
replace loanamount=loanbalance if HHID2016=="uuid:cd94146d-f48f-475c-8416-78e984a3dccd" &	INDID2016==2 &	loanid==1
*4 ans et qq: loanamount=55, loanbalance =1 000 000, motif: house. si  55 lakh: ca veut dire qu un lakh par an est rembourse ca fait pas mal...
*a voir plus tard avec le revenu/debt service
replace loanamount=5500000 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" &	INDID2016==3 &	loanid==1


*** ISSUE 0 in loanbalance
*12 month old bank loan 700 000 INR, with interest thereby at nearly 1% monthly; principalpaid=0, but loanbalance=60 000
*remplacer loanbalance par 600 000, mais dans le doute ne pas ajouter 100 000 INR dans principalpaid
replace loanbalance=600000 if HHID2016=="uuid:3502a333-6356-4267-ad32-ad6d32029c51" &	INDID2016==1 &	loanid==2
*20 INR loan; 18000 repaid, 2000 balance
replace loanamount=loanamount*1000 if HHID2016=="uuid:abefe76f-bf58-4b71-ab71-1d64a7a33c5e" &	INDID2016==1 &	loanid==1
*loanamount 5000, loanbalance 50 000. 10 month old loan by moneylender for education. interestpaid 1500  (=10*interestloan)
* means 3% monthly interest for a loan of 5000). also 5000 written in loaninfo.
replace loanbalance=loanbalance/10 if HHID2016=="uuid:30187ee9-dd3b-4a82-b20f-6ec0db908a4c" &	INDID2016==1 &	loanid==1
*loanamount 15 000 by well known. loanbalance 150 000. with 15 000, interestloan means 3% monthly.
replace loanbalance=loanbalance/10 if HHID2016=="uuid:a049567e-1188-4e9a-8875-4dce306cffdf" &	INDID2016==1 &	loanid==1
*DOUTEUX: loanamount=33 000, loanbalance 100 000. for agriculture. vu les tailles des prets pour ce moment, semble plus plausible que ce soit 33 000 et non 330 000.
replace loanbalance=loanbalance/10 if HHID2016=="uuid:d8256128-806c-4919-8216-9226c3fdc047" &	INDID2016==1 &	loanid==3



	
********* LOANBALANCE> LOANAMOUNT:

*** avec princpalpaid!=.:  reste 31 cas - dont 21 microcredit

*update loanbalance with principalpaid for microcredits (interest checked, plausible)
replace loanbalance=loanamount-principalpaid if lender4==8 & loanbalance>loanamount & loanbalance!=.

replace loanbalance=loanamount-principalpaid if HHID2016=="uuid:fbe2328b-890f-4bcd-82a1-d033c9986aed" &	INDID2016==1 & loanid==1

*mystere: loanamount = 350 000 (idem loaninfo) and loanbalance=800 000. even including the interest does not yield 800 000. principalpaid=0
replace loanbalance=loanamount-principalpaid if HHID2016=="uuid:15a2311a-c10d-462d-8a50-29a67b91b739" &	INDID2016==1 &	loanid==1
*mystere: seem to include one missed interest payment and ignore the principal repaid. comme principal paid, interestpaid, et totalrepaid coherents:
replace loanbalance=loanamount-principalpaid if HHID2016=="uuid:142053fe-243a-4035-8746-93dd30108d22" &	INDID2016==1 &	loanid==1
*mystere loanamount = 10 000 (idem loaninfo) and loanbalance=14200. if included missed interest payment, would mean like 14% monthly ! en desespoir de cause:
replace loanbalance=loanamount-principalpaid if HHID2016=="uuid:39110c77-6bc2-4c6c-9e78-f8923d54163b" &	INDID2016==1 &	loanid==2

***avec princpalpaid!=.: 3 cas

replace loanbalance=loanamount if loanbalance>loanamount & loanbalance!=. & principalpaid==. 




********* COHERENCE LOANBALANCE & PRINCIPALPAID 

drop test
gen test=loanamount-principalpaid - loanbalance
tab test
* 0 :  89.3 %
*5.9% inf, 4.8% sup
tab lender4 if test!=0 & test!=.
*moitie de microcredit dans ceux qui ne matchent pas


gen ignoreppaid=0
replace ignoreppaid=1 if test==-principalpaid
replace ignoreppaid=. if test==0 | test==.
tab ignoreppaid
* 16 cas


***what is recorded in loanbalance is what has been repaid 
** is totalrepaid:
gen btotalrepaid=0
replace btotalrepaid=1 if loanbalance==totalrepaid & test!=0 & test!=.
replace btotalrepaid=1 if HHID2016=="uuid:35591049-0c3e-4dac-836a-958f07745c35" &	INDID2016==2 &	loanid==1
tab btotalrepaid
*9 cas
**is the principal repaid
gen bprincipalpaid=0
replace bprincipalpaid=1 if loanbalance==principalpaid & test!=0 & test!=.
tab bprincipal
*18 cas

*what is recorded in loanbalance is difference between loanamount and what has been repaid, but including interest (surestime le principal rembourse)
gen mixip=0
replace mixip=1 if loanbalance==loanamount-totalrepaid & dummyinterest==1 & interestpaid!=0 & test!=0 & test!=.
replace mixip=1 if HHID2016=="uuid:62ad7210-2d2c-4e4d-a8c6-6501a63d2fee" &	INDID2016==5 &	loanid==1
replace mixip=1 if HHID2016=="uuid:89f0734d-db4a-4660-8c9f-c54fcd6f8ddb" &	INDID2016==1 &	loanid==2
replace mixip=1 if loanbalance==loanamount-interestpaid & dummyinterest==1 & interestpaid!=0 & test!=0 & test!=.
*29 cas

**according to principalpaid, no principal has been paid, but according to loanbalance, some has been paid (8 CAS)
gen ppaidornot=0
replace ppaidornot=1 if principalpaid==0 & loanbalance<loanamount 
*13 cas

*** RECAP
gen identified=0 
replace identified=1 if ignoreppaid==1 | btotal==1 | bprincipal==1 | mixip==1 | ppaidornot==1
*68 cas
replace test=. if identified==1



*****microcredit: 
*with instlaments recorded, means repayduration2=24 weeks and 625 principal paid monthly. means 13% interet pour 6 mois.
replace loanbalance=loanamount - principalpaid if HHID2016=="uuid:1a8044af-2831-4f69-b815-1acda4e54c8b" &	INDID2016==1 &	loanid==2
replace repayduration2=24 if HHID2016=="uuid:1a8044af-2831-4f69-b815-1acda4e54c8b" &	INDID2016==1 &	loanid==2
replace loanbalance=loanamount-principalpaid if lender4==8 & test!=0 & test!=. & included==1


********* check les excluded:
**totalrepaid recorded, not interestpaid: but can be obtained with loanbalance
replace interestpaid=totalrepaid if HHID2016=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	INDID2016==2 &	loanid==1
replace included=1 if HHID2016=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	INDID2016==2 &	loanid==1
replace interestpaid=300000 if HHID2016=="uuid:142053fe-243a-4035-8746-93dd30108d22" &	INDID2016==1 &	loanid==2
replace principalpaid=200000 if HHID2016=="uuid:142053fe-243a-4035-8746-93dd30108d22" &	INDID2016==1 &	loanid==2
replace included=1 if HHID2016=="uuid:142053fe-243a-4035-8746-93dd30108d22" &	INDID2016==1 &	loanid==2
replace principalpaid=loanamount-loanbalance if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	INDID2016==1 &	loanid==2
*probaly a mistake in total repaid: means 445 000 interest, while probably 345 000 (interestloan*23 for 24 month old loan) 
replace interestpaid=345000 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	INDID2016==1 &	loanid==2
replace included=1 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	INDID2016==1 &	loanid==2
replace principalpaid=loanamount-loanbalance if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	INDID2016==1 &	loanid==1
replace interestpaid=totalrepaid-principalpaid if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	INDID2016==1 &	loanid==1
replace included=1 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	INDID2016==1 &	loanid==1

**those who had principalpaid!=0 et totalrepaid=interestpaid: according to loanbalance, no principal has been paid:
replace principalpaid=0 if HHID2016=="uuid:9f650881-8382-48ff-8757-9f012a0dfe8f" &	INDID2016==1 &	loanid==1
replace included=1 if HHID2016=="uuid:9f650881-8382-48ff-8757-9f012a0dfe8f" &	INDID2016==1 &	loanid==1
replace principalpaid=0 if HHID2016=="uuid:b6802956-c0b6-442e-b416-73d9acd4d137" &	INDID2016==1 &	loanid==1
replace included=1 if HHID2016=="uuid:b6802956-c0b6-442e-b416-73d9acd4d137" &	INDID2016==1 &	loanid==1
replace principalpaid=0 if HHID2016=="uuid:d92d4760-c143-430d-848d-ae199496a356" &	INDID2016==1 &	loanid==2
replace included=1 if HHID2016=="uuid:d92d4760-c143-430d-848d-ae199496a356" &	INDID2016==1 &	loanid==2
replace principalpaid=0 if HHID2016=="uuid:c3754c17-d102-41df-93d1-f1bd78466da8" &	INDID2016==1 &	loanid==1
replace included=1 if HHID2016=="uuid:c3754c17-d102-41df-93d1-f1bd78466da8" &	INDID2016==1 &	loanid==1
replace principalpaid=0 if HHID2016=="uuid:da893017-2541-42dc-9dab-d517d777b92b" &	INDID2016==1 &	loanid==3
replace included=1 if HHID2016=="uuid:da893017-2541-42dc-9dab-d517d777b92b" &	INDID2016==1 &	loanid==3
replace principalpaid=0 if HHID2016=="uuid:d35fd473-8f07-437a-b6d2-b51962ac7c94" &	INDID2016==1 &	loanid==2
replace included=1 if HHID2016=="uuid:d35fd473-8f07-437a-b6d2-b51962ac7c94" &	INDID2016==1 &	loanid==2

replace totalrepaid=1100 if HHID2016=="uuid:8e0b0fc2-c75d-4646-a949-4c7749d6b3cc" &	INDID2016==1 &	loanid==1
replace included=1 if HHID2016=="uuid:8e0b0fc2-c75d-4646-a949-4c7749d6b3cc" &	INDID2016==1 &	loanid==1



*** loans with pb "identified" + POSITIVE AMOUNTS of principal paid different selon principal paid et loanbalance:
*apres check: on ne peut pas faire grand chose. considere que principalpaid prevaut sur loanbalance.
drop test
gen test=loanamount-principalpaid - loanbalance
replace loanbalance=loanamount - principalpaid if test!=0 & test!=.

*(bizarre que principalpaid soit encore missing aurait du etre regle???)
replace principalpaid=totalrepaid-interestpaid if HHID2016=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	INDID2016==2 &	loanid==1










gen yratepaid=.
****if interest paid weekly, monthly or when have money, once in six months, or unclear (interestfreq=7)
replace yratepaid=interestpaid*100*12/(loan_months*loanamount) if interestfreq==1 | interestfreq==2 | interestfreq==6 | interestfreq==7 | interestfreq==4
****if interest paid yearly: interestpaid averaged with an integer for number of years 
gen loan_year2=loan_year
replace loan_year2=1 if loan_year2<1 
replace yratepaid=interestpaid*100/(loan_year2*loanamount) if interestfreq==3
**** if interest=fixed amount
replace yratepaid=interestpaid*100/loanamount if interestfreq==5
replace yratepaid=. if included==0 | dummyinterest==0


********** CHECK FOR OUTLIERS BY CREDIT SOURCES

*loanamount 50 000, and interestloan 10 000. actually, 500 000 [loaninfo=="Sambath 500000 for Agriculture")
replace loanamount=500000 if HHID2016=="uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006" &	INDID2016==1 &	loanid==1
replace loanbalance=loanamount if HHID2016=="uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006" &	INDID2016==1 &	loanid==1 
replace yratepaid=yratepaid/10 if HHID2016=="uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006" &	INDID2016==1 &	loanid==1

gen outlier_yrate=0
replace outlier_yrate=1 if yrate>=240 & lender4==1 & yrate!=.
replace explication="outlier; wkp >240 pa (highest below 115" if yrate>=240 & lender4==1 & yrate!=.
gen yrate_included=included
replace yrate_included=0 if outlier_yrate==1

tab yrate_included
*1078
tab included
*1080

*paid rates for those who started to repay:
tabstat yratepaid if  yrate_included==1 & interestpaid>0 & interestpaid!=., by(lender4) stat(n mean p50 min max)
/*

     lender4 |         N      mean       p50       min       max
-------------+--------------------------------------------------
  Well known |       324  24.28248      21.6  1.463415     115.2
   Relatives |       129  18.83321  16.27119         2        60
      Labour |        31  18.42413  16.36364         5  41.14286
 Pawn broker |         1  23.07692  23.07692  23.07692  23.07692
 Shop keeper |         2  17.32692  17.32692      12.5  22.15385
Moneylenders |        58  27.50972        24  2.907692     79.68
     Friends |        14   20.2881  19.04895   .742268      43.2
 Microcredit |        98  15.63684    13.392     .4992        54
        Bank |        31  10.61372  10.28571        .9        32
    Neighbor |        32  22.23268  22.28572  2.727273  41.14286
-------------+--------------------------------------------------
       Total |       720  21.35884        18     .4992     115.2
----------------------------------------------------------------

*/















































****************************************
* COHERENCE
****************************************
use"_temp\NEEMSIS1-loans_v6.dta", clear

*As Elena, for gold
replace loanbalance=loanamount if loandate==. & loanlender==6  & lenderfrom==.

*Marriage = no loanbalance so drop it..
*drop if loandate==. & loanreasongiven==8 & loanbalance==.


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

save"_temp\NEEMSIS1-loans_v7.dta", replace
****************************************
* END














****************************************
* BALANCE
****************************************
use"_temp\NEEMSIS1-loans_v7.dta", clear

replace loanbalance=0 if loansettled==1



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
save"_temp\NEEMSIS1-loans_v8.dta", replace
*************************************
* END















****************************************
* ANNUALIZED
****************************************
use"_temp\NEEMSIS1-loans_v8.dta", clear

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
     lender4 |         N      mean       p50       min       max
-------------+--------------------------------------------------
         WKP |       316  45.53768        30  1.499985       720
   Relatives |       128  35.01362        25  .0033333       180
      Labour |        31  21.08602  21.66667         4        48
 Pawn broker |         1       100       100       100       100
 Shop keeper |         2        37        37        24        50
Moneylenders |        57  23.30901  11.57895        .5       300
     Friends |        13  29.46154        18         4        90
 Microcredit |       101  13.95773     9.152  .3073846        81
        Bank |        32  66.22486      11.5        .6  1676.471
    Neighbor |        30  41.88889        28       1.5       144
-------------+--------------------------------------------------
       Total |       711  36.84462        21  .0033333  1676.471
----------------------------------------------------------------

*/

save"_temp\NEEMSIS1-loans_v9.dta", replace
*************************************
* END












****************************************
* MARRIAGE LOANS
****************************************
use"_temp\NEEMSIS1-loans_v9.dta", clear

/*
tab loan_database
tab loanreasongiven if loan_database=="FINANCE"
/*
Essayer bricolage pour en tenir compte quand même
Sur 1697 prêts, il y en a eu que 15 de remboursés..
Pourquoi sur les 300, il y en aurait beaucoup ?

1. Je regarde les durée des prêts pour mariage les plus longues : je prends la durée minimale des 25 % des prêts avec la durée la plus longue (ou la durée max des 75 % des prêts avec la durée la plus courte) --> Q3  
2. Je l'impute aux autres (en utilisant p90, je prends volontairement une durée haute afin de réduire le plus possible le remboursement mensuel. Je ne veux pas surestimer le phénomène, je cherche juste à tenir "un peu" compte des prêts pour mariages)
3. Je divise le montant du prêt par la durée pour avoir une sorte de remboursement mensuel
*/

********** 1. vérif de la durée des prêts
tabstat loanduration if loanreasongiven==8, stat(n mean sd p50 p75 p90 p95 p99 max) 
*1400 jours

********** 3. vérif du % repayé sur le montant du prêts
gen ratiotest=totalrepaid/loanamount
tabstat ratiotest if loanreasongiven==8, stat(n mean sd min p1 p5 p10 q p90 p95 p99 max)
*Je prends la valeur de Q1 ici pour réduire le montant au max --> 0.21

********** vérif les intérêts
tab loanlender if loanreasongiven==8
*informel = pas d'intérêts


********** Proba settled
preserve
use"NEEMSIS1-loans_v4.dta", clear
tab loanreasongiven loansettled
*3 sur 298 
dis 1-(3/298)
*disons 0.95
restore


********** Imputation
clonevar loanduration_wm=loanduration
clonevar totalrepaid2_wm=totalrepaid2
clonevar loanamount_wm=loanamount
clonevar loanbalance_wm=loanbalance
clonevar interestpaid2_wm=interestpaid2

replace loanamount=. if loan_database=="MARRIAGE"
replace loanbalance=. if loan_database=="MARRIAGE"


replace loanduration_wm=1400 if loan_database=="MARRIAGE"
replace totalrepaid2_wm=loanamount_wm*0.21*0.95 if loan_database=="MARRIAGE"
replace interestpaid2_wm=loanamount_wm*0.233*0.95 if loan_database=="MARRIAGE" & lender4==6
replace interestpaid2_wm=loanamount_wm*0.139*0.95 if loan_database=="MARRIAGE" & lender4==8
*/

save"_temp\NEEMSIS1-loans_v9-bis.dta", replace
*************************************
* END












****************************************
* IMPUTATION
****************************************
use"_temp\NEEMSIS1-loans_v9-bis.dta", clear


********** Add income
*merge m:1 HHID2016 INDID2016 using "NEEMSIS1-HH_v7.dta", keepusing(annualincome_indiv annualincome_HH)
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
replace imp1_interest=0.233*loanamount if lender4==6 & loanduration<=365 & debt_service==.
replace imp1_interest=0.233*loanamount*365/loanduration if lender4==6 & loanduration>365 & debt_service==.
replace imp1_interest=0.139*loanamount if lender4==8 & loanduration<=365 & debt_service==.
replace imp1_interest=0.139*loanamount*365/loanduration if lender4==8 & loanduration>365 & debt_service==.
replace imp1_interest=0 if lender4!=6 & lender4!=8 & debt_service==. & loandate!=.




*** Imputation total
gen imp1_totalrepaid_year=imp_principal+imp1_interest




*** Calcul service de la dette pour tout
gen imp1_debt_service=debt_service
replace imp1_debt_service=imp1_totalrepaid_year if debt_service==.

replace imp1_debt_service=. if loansettled==1
replace imp1_debt_service=. if loan_database=="MARRIAGE"



*** Calcul service des interets pour tout
gen imp1_interest_service=interest_service
replace imp1_interest_service=imp1_interest if interest_service==.

replace imp1_interest_service=. if loansettled==1
replace imp1_interest_service=. if loan_database=="MARRIAGE"

drop totalrepaid2 interestpaid2 principalpaid2


save"_temp\NEEMSIS1-loans_v10.dta", replace
*************************************
* END










****************************************
* Other measures with dummies, share and amount
****************************************
use"_temp\NEEMSIS1-loans_v10.dta", clear



********** Loanlender
label define loanlender 1"WKP" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn broker" 7"Shop keeper" 8"Finance (moneylenders)" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mill loan" 14"Group finance"
label values loanlender loanlender
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
rename loanlender_14 lender_grou

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
foreach x in WKP rela empl mais coll pawn shop fina frie SHG bank coop suga grou {
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
rename loanreasongiven_12 given_nore
rename loanreasongiven_13 given_othe

*Amt
foreach x in agri fami heal repa hous inve cere marr educ rela deat nore othe {
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
rename loanreasoncat_6 givencat_nore
rename loanreasoncat_7 givencat_othe

*Amt
foreach x in econ curr huma soci hous nore othe {
gen givencatamt_`x'=loanamount if givencat_`x'==1
}



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


*Amt
foreach x in agri fami heal repa hous inve cere marr educ rela deat nore othe {
gen effectiveamt_`x'=loanamount if effective_`x'==1
}

********** Lender service
tab otherlenderservices
gen othlendserv_poli=0
gen othlendserv_fina=0
gen othlendserv_guar=0
gen othlendserv_gene=0
gen othlendserv_none=0
gen othlendserv_othe=0
replace othlendserv_poli=1 if strpos(otherlenderservices,"1")
replace othlendserv_fina=1 if strpos(otherlenderservices,"2")
replace othlendserv_guar=1 if strpos(otherlenderservices,"3")
replace othlendserv_gene=1 if strpos(otherlenderservices,"4")
replace othlendserv_none=1 if strpos(otherlenderservices,"5")
replace othlendserv_othe=1 if strpos(otherlenderservices,"77")



********** Guarantee
ta guarantee
gen guarantee_doc=0
gen guarantee_chit=0
gen guarantee_shg=0
gen guarantee_pers=0
gen guarantee_jewe=0
gen guarantee_none=0
gen guarantee_othe=0

replace guarantee_doc=1 if strpos(guarantee,"1")
replace guarantee_chit=1 if strpos(guarantee,"2")
replace guarantee_shg=1 if strpos(guarantee,"3")
replace guarantee_pers=1 if strpos(guarantee,"4")
replace guarantee_jewe=1 if strpos(guarantee,"5")
replace guarantee_none=1 if strpos(guarantee,"6")
replace guarantee_othe=1 if strpos(guarantee,"77")





********** Borrower services
tab borrowerservices
gen borrservices_free=0
gen borrservices_work=0
gen borrservices_supp=0
gen borrservices_none=0
gen borrservices_othe=0
replace borrservices_free=1 if strpos(borrowerservices,"1")
replace borrservices_work=1 if strpos(borrowerservices,"2")
replace borrservices_supp=1 if strpos(borrowerservices,"3")
replace borrservices_none=1 if strpos(borrowerservices,"4")
replace borrservices_othe=1 if strpos(borrowerservices,"77")





********** Plan to repay
ta plantorepay
gen plantorep_chit=0
gen plantorep_work=0
gen plantorep_migr=0
gen plantorep_asse=0
gen plantorep_inco=0
gen plantorep_borr=0
gen plantorep_othe=0

replace plantorep_chit=1 if strpos(plantorepay,"1")
replace plantorep_work=1 if strpos(plantorepay,"2")
replace plantorep_migr=1 if strpos(plantorepay,"3")
replace plantorep_asse=1 if strpos(plantorepay,"4")
replace plantorep_inco=1 if strpos(plantorepay,"5")
replace plantorep_borr=1 if strpos(plantorepay,"6")
replace plantorep_othe=1 if strpos(plantorepay,"77")




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


*** Clean
drop egoid name jatis sex age villageid villageareaid householdid submissiondate_o

order HHID2016 INDID2016 year


save"outcomes\NEEMSIS1-loans_mainloans_new.dta", replace
*************************************
* END











****************************************
* Indiv and HH level
****************************************
use"outcomes\NEEMSIS1-loans_mainloans_new.dta", clear

*
drop if loansettled==1
drop if loan_database=="MARRIAGE"


*** Indiv + HH level
bysort HHID2016 INDID2016: egen nbloans_indiv=sum(1)
bysort HHID2016: egen nbloans_HH=sum(1)

bysort HHID2016 INDID2016: egen loanamount_indiv=sum(loanamount)
bysort HHID2016: egen loanamount_HH=sum(loanamount)




*** Services
bysort HHID2016 INDID2016: egen imp1_ds_tot_indiv=sum(imp1_debt_service)
bysort HHID2016 INDID2016: egen imp1_is_tot_indiv=sum(imp1_interest_service)

bysort HHID2016: egen imp1_ds_tot_HH=sum(imp1_debt_service)
bysort HHID2016: egen imp1_is_tot_HH=sum(imp1_interest_service)




********** Individual and HH level for dummies
foreach x in lender_WKP lender_rela lender_empl lender_mais lender_coll lender_pawn lender_shop lender_fina lender_frie lender_SHG lender_bank lender_coop lender_suga lender_grou lender4_WKP lender4_rela lender4_labo lender4_pawn lender4_shop lender4_mone lender4_frie lender4_micr lender4_bank lender4_neig given_agri given_fami given_heal given_repa given_hous given_inve given_cere given_marr given_educ given_rela given_deat given_nore given_othe givencat_econ givencat_curr givencat_huma givencat_soci givencat_hous givencat_nore givencat_othe effective_agri effective_fami effective_heal effective_repa effective_hous effective_inve effective_cere effective_marr effective_educ effective_rela effective_deat effective_nore effective_othe othlendserv_poli othlendserv_fina othlendserv_guar othlendserv_gene othlendserv_none othlendserv_othe guarantee_doc guarantee_chit guarantee_shg guarantee_pers guarantee_jewe guarantee_none guarantee_othe borrservices_free borrservices_work borrservices_supp borrservices_none borrservices_othe plantorep_chit plantorep_work plantorep_migr plantorep_asse plantorep_inco plantorep_borr plantorep_othe settlestrat_inco settlestrat_sche settlestrat_borr settlestrat_sell settlestrat_land settlestrat_cons settlestrat_addi settlestrat_work settlestrat_supp settlestrat_harv settlestrat_othe prodpledge_gold prodpledge_land prodpledge_car prodpledge_bike prodpledge_frid prodpledge_furn prodpledge_tail prodpledge_cell prodpledge_line prodpledge_dvd prodpledge_came prodpledge_gas prodpledge_comp prodpledge_dish prodpledge_none prodpledge_othe lendercat_semi lendercat_info lendercat_form  {

bysort HHID2016 INDID2016: egen nbindiv_`x'=sum(`x')
gen dumindiv_`x'=0
replace dumindiv_`x'=1 if nbindiv_`x'>0

bysort HHID2016: egen nbHH_`x'=sum(`x')
gen dumHH_`x'=0
replace dumHH_`x'=1 if nbHH_`x'>0
}



foreach x in lenderamt_WKP lenderamt_rela lenderamt_empl lenderamt_mais lenderamt_coll lenderamt_pawn lenderamt_shop lenderamt_fina lenderamt_frie lenderamt_SHG lenderamt_bank lenderamt_coop lenderamt_suga lenderamt_grou lender4amt_WKP lender4amt_rela lender4amt_labo lender4amt_pawn lender4amt_shop lender4amt_mone lender4amt_frie lender4amt_micr lender4amt_bank lender4amt_neig givenamt_agri givenamt_fami givenamt_heal givenamt_repa givenamt_hous givenamt_inve givenamt_cere givenamt_marr givenamt_educ givenamt_rela givenamt_deat givenamt_nore givenamt_othe givencatamt_econ givencatamt_curr givencatamt_huma givencatamt_soci givencatamt_hous givencatamt_nore givencatamt_othe lendercatamt_semi lendercatamt_info lendercatamt_form effectiveamt_agri effectiveamt_fami effectiveamt_heal effectiveamt_repa effectiveamt_hous effectiveamt_inve effectiveamt_cere effectiveamt_marr effectiveamt_educ effectiveamt_rela effectiveamt_deat effectiveamt_nore effectiveamt_othe {

bysort HHID2016 INDID2016: egen totindiv_`x'=sum(`x')

bysort HHID2016: egen totHH_`x'=sum(`x')
}



*Indiv
preserve
duplicates drop HHID2016 INDID2016, force
keep HHID2016 INDID2016 nbloans_indiv loanamount_indiv imp1_ds_tot_indiv imp1_is_tot_indiv nbindiv_lender_WKP dumindiv_lender_WKP nbindiv_lender_rela dumindiv_lender_rela nbindiv_lender_empl dumindiv_lender_empl nbindiv_lender_mais dumindiv_lender_mais nbindiv_lender_coll dumindiv_lender_coll nbindiv_lender_pawn dumindiv_lender_pawn nbindiv_lender_shop dumindiv_lender_shop nbindiv_lender_fina dumindiv_lender_fina nbindiv_lender_frie dumindiv_lender_frie nbindiv_lender_SHG dumindiv_lender_SHG nbindiv_lender_bank dumindiv_lender_bank nbindiv_lender_coop dumindiv_lender_coop nbindiv_lender_suga dumindiv_lender_suga nbindiv_lender_grou dumindiv_lender_grou nbindiv_lender4_WKP dumindiv_lender4_WKP nbindiv_lender4_rela dumindiv_lender4_rela nbindiv_lender4_labo dumindiv_lender4_labo nbindiv_lender4_pawn dumindiv_lender4_pawn nbindiv_lender4_shop dumindiv_lender4_shop nbindiv_lender4_mone dumindiv_lender4_mone nbindiv_lender4_frie dumindiv_lender4_frie nbindiv_lender4_micr dumindiv_lender4_micr nbindiv_lender4_bank dumindiv_lender4_bank nbindiv_lender4_neig dumindiv_lender4_neig nbindiv_given_agri dumindiv_given_agri nbindiv_given_fami dumindiv_given_fami nbindiv_given_heal dumindiv_given_heal nbindiv_given_repa dumindiv_given_repa nbindiv_given_hous dumindiv_given_hous nbindiv_given_inve dumindiv_given_inve nbindiv_given_cere dumindiv_given_cere nbindiv_given_marr dumindiv_given_marr nbindiv_given_educ dumindiv_given_educ nbindiv_given_rela dumindiv_given_rela nbindiv_given_deat dumindiv_given_deat nbindiv_given_nore dumindiv_given_nore nbindiv_given_othe dumindiv_given_othe nbindiv_givencat_econ dumindiv_givencat_econ nbindiv_givencat_curr dumindiv_givencat_curr nbindiv_givencat_huma dumindiv_givencat_huma nbindiv_givencat_soci dumindiv_givencat_soci nbindiv_givencat_hous dumindiv_givencat_hous nbindiv_givencat_nore dumindiv_givencat_nore nbindiv_givencat_othe dumindiv_givencat_othe nbindiv_effective_agri dumindiv_effective_agri nbindiv_effective_fami dumindiv_effective_fami nbindiv_effective_heal dumindiv_effective_heal nbindiv_effective_repa dumindiv_effective_repa nbindiv_effective_hous dumindiv_effective_hous nbindiv_effective_inve dumindiv_effective_inve nbindiv_effective_cere dumindiv_effective_cere nbindiv_effective_marr dumindiv_effective_marr nbindiv_effective_educ dumindiv_effective_educ nbindiv_effective_rela dumindiv_effective_rela nbindiv_effective_deat dumindiv_effective_deat nbindiv_effective_nore dumindiv_effective_nore nbindiv_effective_othe dumindiv_effective_othe nbindiv_othlendserv_poli dumindiv_othlendserv_poli nbindiv_othlendserv_fina dumindiv_othlendserv_fina nbindiv_othlendserv_guar dumindiv_othlendserv_guar nbindiv_othlendserv_gene dumindiv_othlendserv_gene nbindiv_othlendserv_none dumindiv_othlendserv_none nbindiv_othlendserv_othe dumindiv_othlendserv_othe nbindiv_guarantee_doc dumindiv_guarantee_doc nbindiv_guarantee_chit dumindiv_guarantee_chit nbindiv_guarantee_shg dumindiv_guarantee_shg nbindiv_guarantee_pers dumindiv_guarantee_pers nbindiv_guarantee_jewe dumindiv_guarantee_jewe nbindiv_guarantee_none dumindiv_guarantee_none nbindiv_guarantee_othe dumindiv_guarantee_othe nbindiv_borrservices_free dumindiv_borrservices_free nbindiv_borrservices_work dumindiv_borrservices_work nbindiv_borrservices_supp dumindiv_borrservices_supp nbindiv_borrservices_none dumindiv_borrservices_none nbindiv_borrservices_othe dumindiv_borrservices_othe nbindiv_plantorep_chit dumindiv_plantorep_chit nbindiv_plantorep_work dumindiv_plantorep_work nbindiv_plantorep_migr dumindiv_plantorep_migr nbindiv_plantorep_asse dumindiv_plantorep_asse nbindiv_plantorep_inco dumindiv_plantorep_inco nbindiv_plantorep_borr dumindiv_plantorep_borr nbindiv_plantorep_othe dumindiv_plantorep_othe nbindiv_settlestrat_inco dumindiv_settlestrat_inco nbindiv_settlestrat_sche dumindiv_settlestrat_sche nbindiv_settlestrat_borr dumindiv_settlestrat_borr nbindiv_settlestrat_sell dumindiv_settlestrat_sell nbindiv_settlestrat_land dumindiv_settlestrat_land nbindiv_settlestrat_cons dumindiv_settlestrat_cons nbindiv_settlestrat_addi dumindiv_settlestrat_addi nbindiv_settlestrat_work dumindiv_settlestrat_work nbindiv_settlestrat_supp dumindiv_settlestrat_supp nbindiv_settlestrat_harv dumindiv_settlestrat_harv nbindiv_settlestrat_othe dumindiv_settlestrat_othe nbindiv_prodpledge_gold dumindiv_prodpledge_gold nbindiv_prodpledge_land dumindiv_prodpledge_land nbindiv_prodpledge_car dumindiv_prodpledge_car nbindiv_prodpledge_bike dumindiv_prodpledge_bike nbindiv_prodpledge_frid dumindiv_prodpledge_frid nbindiv_prodpledge_furn dumindiv_prodpledge_furn nbindiv_prodpledge_tail dumindiv_prodpledge_tail nbindiv_prodpledge_cell dumindiv_prodpledge_cell nbindiv_prodpledge_line dumindiv_prodpledge_line nbindiv_prodpledge_dvd dumindiv_prodpledge_dvd nbindiv_prodpledge_came dumindiv_prodpledge_came nbindiv_prodpledge_gas dumindiv_prodpledge_gas nbindiv_prodpledge_comp dumindiv_prodpledge_comp nbindiv_prodpledge_dish dumindiv_prodpledge_dish nbindiv_prodpledge_none dumindiv_prodpledge_none nbindiv_prodpledge_othe dumindiv_prodpledge_othe nbindiv_lendercat_semi dumindiv_lendercat_semi nbindiv_lendercat_info dumindiv_lendercat_info nbindiv_lendercat_form dumindiv_lendercat_form totindiv_lenderamt_WKP totindiv_lenderamt_rela totindiv_lenderamt_empl totindiv_lenderamt_mais totindiv_lenderamt_coll totindiv_lenderamt_pawn totindiv_lenderamt_shop totindiv_lenderamt_fina totindiv_lenderamt_frie totindiv_lenderamt_SHG totindiv_lenderamt_bank totindiv_lenderamt_coop totindiv_lenderamt_suga totindiv_lenderamt_grou totindiv_lender4amt_WKP totindiv_lender4amt_rela totindiv_lender4amt_labo totindiv_lender4amt_pawn totindiv_lender4amt_shop totindiv_lender4amt_mone totindiv_lender4amt_frie totindiv_lender4amt_micr totindiv_lender4amt_bank totindiv_lender4amt_neig totindiv_givenamt_agri totindiv_givenamt_fami totindiv_givenamt_heal totindiv_givenamt_repa totindiv_givenamt_hous totindiv_givenamt_inve totindiv_givenamt_cere totindiv_givenamt_marr totindiv_givenamt_educ totindiv_givenamt_rela totindiv_givenamt_deat totindiv_givenamt_nore totindiv_givenamt_othe totindiv_givencatamt_econ totindiv_givencatamt_curr totindiv_givencatamt_huma totindiv_givencatamt_soci totindiv_givencatamt_hous totindiv_givencatamt_nore totindiv_givencatamt_othe totindiv_lendercatamt_semi totindiv_lendercatamt_info totindiv_lendercatamt_form totindiv_effectiveamt_agri totindiv_effectiveamt_fami totindiv_effectiveamt_heal totindiv_effectiveamt_repa totindiv_effectiveamt_hous totindiv_effectiveamt_inve totindiv_effectiveamt_cere totindiv_effectiveamt_marr totindiv_effectiveamt_educ totindiv_effectiveamt_rela totindiv_effectiveamt_deat totindiv_effectiveamt_nore totindiv_effectiveamt_othe
save"outcomes\NEEMSIS1-loans_indiv.dta", replace
restore

*HH
preserve
duplicates drop HHID2016, force
keep HHID2016 nbloans_HH loanamount_HH imp1_ds_tot_HH imp1_is_tot_HH nbHH_lender_WKP dumHH_lender_WKP nbHH_lender_rela dumHH_lender_rela nbHH_lender_empl dumHH_lender_empl nbHH_lender_mais dumHH_lender_mais nbHH_lender_coll dumHH_lender_coll nbHH_lender_pawn dumHH_lender_pawn nbHH_lender_shop dumHH_lender_shop nbHH_lender_fina dumHH_lender_fina nbHH_lender_frie dumHH_lender_frie nbHH_lender_SHG dumHH_lender_SHG nbHH_lender_bank dumHH_lender_bank nbHH_lender_coop dumHH_lender_coop nbHH_lender_suga dumHH_lender_suga nbHH_lender_grou dumHH_lender_grou nbHH_lender4_WKP dumHH_lender4_WKP nbHH_lender4_rela dumHH_lender4_rela nbHH_lender4_labo dumHH_lender4_labo nbHH_lender4_pawn dumHH_lender4_pawn nbHH_lender4_shop dumHH_lender4_shop nbHH_lender4_mone dumHH_lender4_mone nbHH_lender4_frie dumHH_lender4_frie nbHH_lender4_micr dumHH_lender4_micr nbHH_lender4_bank dumHH_lender4_bank nbHH_lender4_neig dumHH_lender4_neig nbHH_given_agri dumHH_given_agri nbHH_given_fami dumHH_given_fami nbHH_given_heal dumHH_given_heal nbHH_given_repa dumHH_given_repa nbHH_given_hous dumHH_given_hous nbHH_given_inve dumHH_given_inve nbHH_given_cere dumHH_given_cere nbHH_given_marr dumHH_given_marr nbHH_given_educ dumHH_given_educ nbHH_given_rela dumHH_given_rela nbHH_given_deat dumHH_given_deat nbHH_given_nore dumHH_given_nore nbHH_given_othe dumHH_given_othe nbHH_givencat_econ dumHH_givencat_econ nbHH_givencat_curr dumHH_givencat_curr nbHH_givencat_huma dumHH_givencat_huma nbHH_givencat_soci dumHH_givencat_soci nbHH_givencat_hous dumHH_givencat_hous nbHH_givencat_nore dumHH_givencat_nore nbHH_givencat_othe dumHH_givencat_othe nbHH_effective_agri dumHH_effective_agri nbHH_effective_fami dumHH_effective_fami nbHH_effective_heal dumHH_effective_heal nbHH_effective_repa dumHH_effective_repa nbHH_effective_hous dumHH_effective_hous nbHH_effective_inve dumHH_effective_inve nbHH_effective_cere dumHH_effective_cere nbHH_effective_marr dumHH_effective_marr nbHH_effective_educ dumHH_effective_educ nbHH_effective_rela dumHH_effective_rela nbHH_effective_deat dumHH_effective_deat nbHH_effective_nore dumHH_effective_nore nbHH_effective_othe dumHH_effective_othe nbHH_othlendserv_poli dumHH_othlendserv_poli nbHH_othlendserv_fina dumHH_othlendserv_fina nbHH_othlendserv_guar dumHH_othlendserv_guar nbHH_othlendserv_gene dumHH_othlendserv_gene nbHH_othlendserv_none dumHH_othlendserv_none nbHH_othlendserv_othe dumHH_othlendserv_othe nbHH_guarantee_doc dumHH_guarantee_doc nbHH_guarantee_chit dumHH_guarantee_chit nbHH_guarantee_shg dumHH_guarantee_shg nbHH_guarantee_pers dumHH_guarantee_pers nbHH_guarantee_jewe dumHH_guarantee_jewe nbHH_guarantee_none dumHH_guarantee_none nbHH_guarantee_othe dumHH_guarantee_othe nbHH_borrservices_free dumHH_borrservices_free nbHH_borrservices_work dumHH_borrservices_work nbHH_borrservices_supp dumHH_borrservices_supp nbHH_borrservices_none dumHH_borrservices_none nbHH_borrservices_othe dumHH_borrservices_othe nbHH_plantorep_chit dumHH_plantorep_chit nbHH_plantorep_work dumHH_plantorep_work nbHH_plantorep_migr dumHH_plantorep_migr nbHH_plantorep_asse dumHH_plantorep_asse nbHH_plantorep_inco dumHH_plantorep_inco nbHH_plantorep_borr dumHH_plantorep_borr nbHH_plantorep_othe dumHH_plantorep_othe nbHH_settlestrat_inco dumHH_settlestrat_inco nbHH_settlestrat_sche dumHH_settlestrat_sche nbHH_settlestrat_borr dumHH_settlestrat_borr nbHH_settlestrat_sell dumHH_settlestrat_sell nbHH_settlestrat_land dumHH_settlestrat_land nbHH_settlestrat_cons dumHH_settlestrat_cons nbHH_settlestrat_addi dumHH_settlestrat_addi nbHH_settlestrat_work dumHH_settlestrat_work nbHH_settlestrat_supp dumHH_settlestrat_supp nbHH_settlestrat_harv dumHH_settlestrat_harv nbHH_settlestrat_othe dumHH_settlestrat_othe nbHH_prodpledge_gold dumHH_prodpledge_gold nbHH_prodpledge_land dumHH_prodpledge_land nbHH_prodpledge_car dumHH_prodpledge_car nbHH_prodpledge_bike dumHH_prodpledge_bike nbHH_prodpledge_frid dumHH_prodpledge_frid nbHH_prodpledge_furn dumHH_prodpledge_furn nbHH_prodpledge_tail dumHH_prodpledge_tail nbHH_prodpledge_cell dumHH_prodpledge_cell nbHH_prodpledge_line dumHH_prodpledge_line nbHH_prodpledge_dvd dumHH_prodpledge_dvd nbHH_prodpledge_came dumHH_prodpledge_came nbHH_prodpledge_gas dumHH_prodpledge_gas nbHH_prodpledge_comp dumHH_prodpledge_comp nbHH_prodpledge_dish dumHH_prodpledge_dish nbHH_prodpledge_none dumHH_prodpledge_none nbHH_prodpledge_othe dumHH_prodpledge_othe nbHH_lendercat_semi dumHH_lendercat_semi nbHH_lendercat_info dumHH_lendercat_info nbHH_lendercat_form dumHH_lendercat_form totHH_lenderamt_WKP totHH_lenderamt_rela totHH_lenderamt_empl totHH_lenderamt_mais totHH_lenderamt_coll totHH_lenderamt_pawn totHH_lenderamt_shop totHH_lenderamt_fina totHH_lenderamt_frie totHH_lenderamt_SHG totHH_lenderamt_bank totHH_lenderamt_coop totHH_lenderamt_suga totHH_lenderamt_grou totHH_lender4amt_WKP totHH_lender4amt_rela totHH_lender4amt_labo totHH_lender4amt_pawn totHH_lender4amt_shop totHH_lender4amt_mone totHH_lender4amt_frie totHH_lender4amt_micr totHH_lender4amt_bank totHH_lender4amt_neig totHH_givenamt_agri totHH_givenamt_fami totHH_givenamt_heal totHH_givenamt_repa totHH_givenamt_hous totHH_givenamt_inve totHH_givenamt_cere totHH_givenamt_marr totHH_givenamt_educ totHH_givenamt_rela totHH_givenamt_deat totHH_givenamt_nore totHH_givenamt_othe totHH_givencatamt_econ totHH_givencatamt_curr totHH_givencatamt_huma totHH_givencatamt_soci totHH_givencatamt_hous totHH_givencatamt_nore totHH_givencatamt_othe totHH_lendercatamt_semi totHH_lendercatamt_info totHH_lendercatamt_form totHH_effectiveamt_agri totHH_effectiveamt_fami totHH_effectiveamt_heal totHH_effectiveamt_repa totHH_effectiveamt_hous totHH_effectiveamt_inve totHH_effectiveamt_cere totHH_effectiveamt_marr totHH_effectiveamt_educ totHH_effectiveamt_rela totHH_effectiveamt_deat totHH_effectiveamt_nore totHH_effectiveamt_othe
save"outcomes\NEEMSIS1-loans_HH.dta", replace
restore

*************************************
* END
