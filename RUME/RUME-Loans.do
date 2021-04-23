/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
16/04/2021
-----
TITLE: All RUME loans

-------------------------
*/

global directory = "D:\Documents\_Thesis\_DATA\RUME\DATA"
cd "$directory"


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
* INDIV & HH level
****************************************
use"RUME-loans_v3.dta", clear

*Conditions
drop if loansettled==1

*Total loan amount
bysort HHID2010: egen totalloanamount=sum(loanamount)

*Number of loans
gen nbloans=1
bysort HHID2010: egen totalnumberloans=sum(nbloans)
drop nbloans

*Total loan balance
bysort HHID2010: egen totalloanbalance=sum(loanbalance)

*Keep HH level variables
bysort HHID2010: gen n=_n
keep if n==1
keep HHID2010 totalloanamount totalnumberloans totalloanbalance

save"RUME-loans_HHlevel.dta", replace


*Merge with HH base
use"RUME-HH_v7.dta", clear

merge m:1 HHID2010 using "RUME-loans_HHlevel.dta"
drop _merge

save"RUME-HH_v7_loans.dta", replace
****************************************
* END
