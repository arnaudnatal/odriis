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



*** Effective reason
gen loaneffectivereason=.
replace loaneffectivereason=1 if loaneffectivereasondetails=="ADVANCE FOR SUGARCANE CUTTING"
replace loaneffectivereason=1 if loaneffectivereasondetails=="AGRI"
replace loaneffectivereason=1 if loaneffectivereasondetails=="AGRI CULTURE"
replace loaneffectivereason=1 if loaneffectivereasondetails=="AGRI."
replace loaneffectivereason=1 if loaneffectivereasondetails=="AGRICULTRE"
replace loaneffectivereason=1 if loaneffectivereasondetails=="Agriculture"
replace loaneffectivereason=1 if loaneffectivereasondetails=="agriculture"
replace loaneffectivereason=1 if loaneffectivereasondetails=="AGRICULTURE"
replace loaneffectivereason=1 if loaneffectivereasondetails=="AGRICULTURE AND FAMILY EXPS"
replace loaneffectivereason=1 if loaneffectivereasondetails=="AGRICULTURE AND HEALTH"
replace loaneffectivereason=1 if loaneffectivereasondetails=="AGRICULTURE EXP"
replace loaneffectivereason=1 if loaneffectivereasondetails=="AGRICULTURE EXP & FAMILY EXP"
replace loaneffectivereason=1 if loaneffectivereasondetails=="AGRICUTURAL EXP"
replace loaneffectivereason=1 if loaneffectivereasondetails=="AGRICUTURE"
replace loaneffectivereason=5 if loaneffectivereasondetails=="BATHROOM CONSTRUCTION"
replace loaneffectivereason=2 if loaneffectivereasondetails=="BIKE REPAIR"
replace loaneffectivereason=1 if loaneffectivereasondetails=="bore well"
replace loaneffectivereason=1 if loaneffectivereasondetails=="Borewell"
replace loaneffectivereason=8 if loaneffectivereasondetails=="brother marriage"
replace loaneffectivereason=8 if loaneffectivereasondetails=="BROTHER MARRIAGE"
replace loaneffectivereason=8 if loaneffectivereasondetails=="BROTHERS MARRIAGE"
replace loaneffectivereason=8 if loaneffectivereasondetails=="BROTHES MARRIAGE"
replace loaneffectivereason=1 if loaneffectivereasondetails=="BROUGHT THE PLOT"
replace loaneffectivereason=6 if loaneffectivereasondetails=="BUISINESS"
replace loaneffectivereason=6 if loaneffectivereasondetails=="BUISINESS EXP"
replace loaneffectivereason=6 if loaneffectivereasondetails=="BUISINESS INVESTMENT"
replace loaneffectivereason=6 if loaneffectivereasondetails=="BUSINESS"
replace loaneffectivereason=6 if loaneffectivereasondetails=="BUSINESS EXP"
replace loaneffectivereason=6 if loaneffectivereasondetails=="BUSINESS INPUTS"
replace loaneffectivereason=1 if loaneffectivereasondetails=="BUY COW"
replace loaneffectivereason=6 if loaneffectivereasondetails=="BUY JEWEL"
replace loaneffectivereason=1 if loaneffectivereasondetails=="BUY LAND"
replace loaneffectivereason=7 if loaneffectivereasondetails=="CEREMONIES"
replace loaneffectivereason=6 if loaneffectivereasondetails=="CHAMBER WORK"
replace loaneffectivereason=8 if loaneffectivereasondetails=="COUSIN MARRIAGE"
replace loaneffectivereason=1 if loaneffectivereasondetails=="cow purchasing"
replace loaneffectivereason=4 if loaneffectivereasondetails=="CREDIT SETTILE"
replace loaneffectivereason=4 if loaneffectivereasondetails=="CREDIT SETTLE"
replace loaneffectivereason=4 if loaneffectivereasondetails=="CREDIT SETTLED"
replace loaneffectivereason=2 if loaneffectivereasondetails=="DAUGHTER DELIVERY"
replace loaneffectivereason=2 if loaneffectivereasondetails=="DAUGHTER FUNCTION"
replace loaneffectivereason=8 if loaneffectivereasondetails=="DAUGHTER MARRIAGE"
replace loaneffectivereason=8 if loaneffectivereasondetails=="daughter marriage"
replace loaneffectivereason=8 if loaneffectivereasondetails=="DAUGHTER MARRIGE"
replace loaneffectivereason=7 if loaneffectivereasondetails=="DAUGHTER PUBERTY"
replace loaneffectivereason=7 if loaneffectivereasondetails=="daughter puberyt ceremony"
replace loaneffectivereason=8 if loaneffectivereasondetails=="DAUGHTERMARRIAGE"
replace loaneffectivereason=9 if loaneffectivereasondetails=="daughters education"
replace loaneffectivereason=8 if loaneffectivereasondetails=="DAUGHTERS MARRIAGE"
replace loaneffectivereason=8 if loaneffectivereasondetails=="DAUGHTERS MARRIAGE EXP"
replace loaneffectivereason=11 if loaneffectivereasondetails=="DEATH"
replace loaneffectivereason=11 if loaneffectivereasondetails=="DEATH EXP"
replace loaneffectivereason=2 if loaneffectivereasondetails=="DELIVERY EXP"
replace loaneffectivereason=2 if loaneffectivereasondetails=="DOUGHTER FUNCTION"
replace loaneffectivereason=8 if loaneffectivereasondetails=="DOUGHTER MARRIAGE"
replace loaneffectivereason=7 if loaneffectivereasondetails=="EAR BOREING CEREMONY"
replace loaneffectivereason=7 if loaneffectivereasondetails=="EAR BORING CEREMONY EXP"
replace loaneffectivereason=9 if loaneffectivereasondetails=="education"
replace loaneffectivereason=9 if loaneffectivereasondetails=="EDUCATION"
replace loaneffectivereason=9 if loaneffectivereasondetails=="EDUCATION EXP"
replace loaneffectivereason=9 if loaneffectivereasondetails=="EDUCATION EXPENS"
replace loaneffectivereason=6 if loaneffectivereasondetails=="ELECTION"
replace loaneffectivereason=2 if loaneffectivereasondetails=="FAMILY AND MEDICAL EXP"
replace loaneffectivereason=2 if loaneffectivereasondetails=="FAMILY EXP"
replace loaneffectivereason=2 if loaneffectivereasondetails=="family exp"
replace loaneffectivereason=2 if loaneffectivereasondetails=="FAMILY EXPENS"
replace loaneffectivereason=2 if loaneffectivereasondetails=="FAMILY EXPENSES"
replace loaneffectivereason=2 if loaneffectivereasondetails=="FAMILY EXPS"
replace loaneffectivereason=2 if loaneffectivereasondetails=="FAMILY EXPS AND HOUSE REPAIR"
replace loaneffectivereason=2 if loaneffectivereasondetails=="FAMILY EXPS AND INVESTMENT"
replace loaneffectivereason=2 if loaneffectivereasondetails=="FAMILY EXPS."
replace loaneffectivereason=2 if loaneffectivereasondetails=="FAMILY EXSP"
replace loaneffectivereason=2 if loaneffectivereasondetails=="FAMILY FUNCTION"
replace loaneffectivereason=3 if loaneffectivereasondetails=="FATHER MEDICAL EXPS"
replace loaneffectivereason=7 if loaneffectivereasondetails=="FESTIVAL"
replace loaneffectivereason=7 if loaneffectivereasondetails=="FESTIVAL EXPS"
replace loaneffectivereason=7 if loaneffectivereasondetails=="FESTIVEL"
replace loaneffectivereason=7 if loaneffectivereasondetails=="FESTIVEL EXPENS"
replace loaneffectivereason=7 if loaneffectivereasondetails=="FESTIVELS"
replace loaneffectivereason=6 if loaneffectivereasondetails=="FOR BUSINESS"
replace loaneffectivereason=6 if loaneffectivereasondetails=="FRUTI BUSINESS"
replace loaneffectivereason=11 if loaneffectivereasondetails=="FUNERAL"
replace loaneffectivereason=11 if loaneffectivereasondetails=="FUNERAL EXPENS"
replace loaneffectivereason=6 if loaneffectivereasondetails=="HANDLOOM"
replace loaneffectivereason=6 if loaneffectivereasondetails=="HANDLOOM WORK"
replace loaneffectivereason=3 if loaneffectivereasondetails=="HEALTH"
replace loaneffectivereason=3 if loaneffectivereasondetails=="HEALTH AND FAMILY EXPENS"
replace loaneffectivereason=3 if loaneffectivereasondetails=="HEALTH EXPEN"
replace loaneffectivereason=3 if loaneffectivereasondetails=="HEALTH EXPENS"
replace loaneffectivereason=3 if loaneffectivereasondetails=="HELATH EXPENS"
replace loaneffectivereason=5 if loaneffectivereasondetails=="HOUSE CONSRTUCTION"
replace loaneffectivereason=5 if loaneffectivereasondetails=="HOUSE CONSTRUCTION"
replace loaneffectivereason=5 if loaneffectivereasondetails=="HOUSE CONSTRUCTION EXP"
replace loaneffectivereason=5 if loaneffectivereasondetails=="House repair"
replace loaneffectivereason=5 if loaneffectivereasondetails=="house repair"
replace loaneffectivereason=5 if loaneffectivereasondetails=="HOUSE REPAIR"
replace loaneffectivereason=5 if loaneffectivereasondetails=="HOUSE REPAIRE"
replace loaneffectivereason=5 if loaneffectivereasondetails=="HOUSE REPAIRING"
replace loaneffectivereason=11 if loaneffectivereasondetails=="HUSBAND DEATH EXP"
replace loaneffectivereason=11 if loaneffectivereasondetails=="HUSBAND DEATH EXPENS"
replace loaneffectivereason=4 if loaneffectivereasondetails=="INTEREST SETTLE"
replace loaneffectivereason=6 if loaneffectivereasondetails=="INVESTMEN"
replace loaneffectivereason=6 if loaneffectivereasondetails=="INVESTMENT"
replace loaneffectivereason=6 if loaneffectivereasondetails=="INVESTMENT FOR BUSINESS"
replace loaneffectivereason=6 if loaneffectivereasondetails=="JOB EXP"
replace loaneffectivereason=2 if loaneffectivereasondetails=="KADHU KUTHAL"
replace loaneffectivereason=6 if loaneffectivereasondetails=="LABOUR ADVANCE"
replace loaneffectivereason=1 if loaneffectivereasondetails=="LAND LEASE EXP"
replace loaneffectivereason=3 if loaneffectivereasondetails=="madicla exp"
replace loaneffectivereason=8 if loaneffectivereasondetails=="marriage"
replace loaneffectivereason=8 if loaneffectivereasondetails=="MARRIAGE"
replace loaneffectivereason=8 if loaneffectivereasondetails=="MARRIAGE AND AGRICULTURE"
replace loaneffectivereason=8 if loaneffectivereasondetails=="MARRIAGE EXP"
replace loaneffectivereason=8 if loaneffectivereasondetails=="MARRIAGE EXPENS"
replace loaneffectivereason=8 if loaneffectivereasondetails=="MEDICAL EXP"
replace loaneffectivereason=8 if loaneffectivereasondetails=="MEDICAL EXPENS"
replace loaneffectivereason=8 if loaneffectivereasondetails=="MEDICAL EXPS"
replace loaneffectivereason=3 if loaneffectivereasondetails=="MOTHER HEALTH"
replace loaneffectivereason=11 if loaneffectivereasondetails=="MOTHER IN LAW DEATH EXP"
replace loaneffectivereason=6 if loaneffectivereasondetails=="PAY ADVANCE TO THE LABOUR"
replace loaneffectivereason=6 if loaneffectivereasondetails=="PETTI SHOP"
replace loaneffectivereason=6 if loaneffectivereasondetails=="PLACEMENT"
replace loaneffectivereason=7 if loaneffectivereasondetails=="PUBERTY"
replace loaneffectivereason=7 if loaneffectivereasondetails=="PUBERTY CEREMONIE"
replace loaneffectivereason=7 if loaneffectivereasondetails=="PUBERTY CEREMONIES EXP"
replace loaneffectivereason=7 if loaneffectivereasondetails=="puberty ceremony"
replace loaneffectivereason=7 if loaneffectivereasondetails=="PUBERTY CEREMONY"
replace loaneffectivereason=7 if loaneffectivereasondetails=="PUBERTY CEREMONY EXP"
replace loaneffectivereason=7 if loaneffectivereasondetails=="PUBERTY FUNCTION"
replace loaneffectivereason=7 if loaneffectivereasondetails=="PUBRTY CEREMONY"
replace loaneffectivereason=7 if loaneffectivereasondetails=="PUBRTY CEREMONY EXP"
replace loaneffectivereason=5 if loaneffectivereasondetails=="RECONSTRUCT HOUSE"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATIEVES FUNCTION"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATIEVES MARRIAGE EXP"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATION DEATH"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATION FUNCTION"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATION FUNERAL"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATION MARRIAGE"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATIONS FUNERAL"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATIVE DEATH"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATIVE FUNCTION"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATIVE FUNTION"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATIVE MARRIAGE"
replace loaneffectivereason=10 if loaneffectivereasondetails=="relatives ceremonies"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATIVES DEATH EXP"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATIVES FESTIVALS"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATIVES FESTIVALS EXP"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATIVES FUNCTION"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATIVES FUNCTION EXP"
replace loaneffectivereason=10 if loaneffectivereasondetails=="RELATIVES MARRIAGE EXP"
replace loaneffectivereason=5 if loaneffectivereasondetails=="RENT FOR HOUSE"
replace loaneffectivereason=4 if loaneffectivereasondetails=="REPAYMENT FOR PREVIOUS LOAN"
replace loaneffectivereason=4 if loaneffectivereasondetails=="REPAYMENT FOR PREVIOUS LOAN INTERESTS"
replace loaneffectivereason=4 if loaneffectivereasondetails=="REPAYMENT PREVIOUS LOAN"
replace loaneffectivereason=4 if loaneffectivereasondetails=="REPAYMENTFOR PREVIOUS LOAN"
replace loaneffectivereason=4 if loaneffectivereasondetails=="SETTLED LOAN"
replace loaneffectivereason=6 if loaneffectivereasondetails=="SHOP CONSTRUCTION EXP"
replace loaneffectivereason=8 if loaneffectivereasondetails=="SISTER MARRIAGE"
replace loaneffectivereason=11 if loaneffectivereasondetails=="SISTER PREGNANCY"
replace loaneffectivereason=8 if loaneffectivereasondetails=="SISTERS MARRIAGE"
replace loaneffectivereason=8 if loaneffectivereasondetails=="SISTERS MARRIAGE EXP"
replace loaneffectivereason=3 if loaneffectivereasondetails=="SON ACCIDENT TREATMENT EXPENS"
replace loaneffectivereason=9 if loaneffectivereasondetails=="SON EDUCATION"
replace loaneffectivereason=8 if loaneffectivereasondetails=="SON MARRIAGE"
replace loaneffectivereason=8 if loaneffectivereasondetails=="SON MARRIAGE EXP"
replace loaneffectivereason=2 if loaneffectivereasondetails=="SON PLACEMENT"
replace loaneffectivereason=8 if loaneffectivereasondetails=="SONS MARRIAGE EXP"
replace loaneffectivereason=3 if loaneffectivereasondetails=="SONS MEDICAL EXP"
replace loaneffectivereason=1 if loaneffectivereasondetails=="SUGARCANE EXP"
replace loaneffectivereason=6 if loaneffectivereasondetails=="SULAI PODA"
replace loaneffectivereason=7 if loaneffectivereasondetails=="TEMPLE FESTIVAL"
replace loaneffectivereason=5 if loaneffectivereasondetails=="TO BUILD HOUSE"
replace loaneffectivereason=1 if loaneffectivereasondetails=="TO BUY AGRI LAND"
replace loaneffectivereason=2 if loaneffectivereasondetails=="TO BUY BIKE"
replace loaneffectivereason=1 if loaneffectivereasondetails=="TO BUY BULLOCART VEHICLE"
replace loaneffectivereason=1 if loaneffectivereasondetails=="TO BUY BULLOCK"
replace loaneffectivereason=1 if loaneffectivereasondetails=="TO BUY COW"
replace loaneffectivereason=2 if loaneffectivereasondetails=="TO BUY FUNITURE"
replace loaneffectivereason=5 if loaneffectivereasondetails=="TO BUY HOUSE"
replace loaneffectivereason=1 if loaneffectivereasondetails=="TO BUY LAND"
replace loaneffectivereason=6 if loaneffectivereasondetails=="TO BUY LOAD CARRIER VEHICLE"
replace loaneffectivereason=1 if loaneffectivereasondetails=="TO BUY PLOT"
replace loaneffectivereason=2 if loaneffectivereasondetails=="TO BUY TATA VEHICLE"
replace loaneffectivereason=1 if loaneffectivereasondetails=="TO BUY TRACTOR"
replace loaneffectivereason=6 if loaneffectivereasondetails=="TO EXTEND OUR BUSINESS"
replace loaneffectivereason=10 if loaneffectivereasondetails=="TO GIVE GIFT NEIBHOUR MARRIAGE FUNCTION"
replace loaneffectivereason=2 if loaneffectivereasondetails=="TO GO ABROAD"
replace loaneffectivereason=6 if loaneffectivereasondetails=="TO GO GULF"
replace loaneffectivereason=1 if loaneffectivereasondetails=="TO MAKE BORE"
replace loaneffectivereason=5 if loaneffectivereasondetails=="TO REAIRING HOUSE"
replace loaneffectivereason=5 if loaneffectivereasondetails=="TO REBUILD HOUSE"
replace loaneffectivereason=5 if loaneffectivereasondetails=="TO REPAIR HOUSE"
replace loaneffectivereason=5 if loaneffectivereasondetails=="TO REPAIRE HOUSE"
replace loaneffectivereason=5 if loaneffectivereasondetails=="TO REPAIRING HOUSE"
replace loaneffectivereason=4 if loaneffectivereasondetails=="TO REPAYMENT FOR PREVIOUS LOAN"
replace loaneffectivereason=4 if loaneffectivereasondetails=="TO REPAYMENT PREVIOUS LOAN"
replace loaneffectivereason=4 if loaneffectivereasondetails=="TO SETTLE PREVIOUS LOAN"
replace loaneffectivereason=4 if loaneffectivereasondetails=="TO SETTLE PREVIUOS LOAN"
replace loaneffectivereason=4 if loaneffectivereasondetails=="TO SETTLE THE PREVIOUS LOAN"
replace loaneffectivereason=1 if loaneffectivereasondetails=="TRACTOR"
replace loaneffectivereason=1 if loaneffectivereasondetails=="TRACTOR LOAN"
replace loaneffectivereason=3 if loaneffectivereasondetails=="TREATMENT"
replace loaneffectivereason=3 if loaneffectivereasondetails=="TREATMENT FOR DAUGHTER"
replace loaneffectivereason=7 if loaneffectivereasondetails=="VALAIKAPPU"
replace loaneffectivereason=2 if loaneffectivereasondetails=="VEHICLE MAINTANANCE"
replace loaneffectivereason=8 if loaneffectivereasondetails=="WEEDING"
replace loaneffectivereason=3 if loaneffectivereasondetails=="WIFE HEALTH EXPS"
replace loaneffectivereason=8 if loaneffectivereasondetails=="WIFE SISSTERS MARRIAGE EXP"

*** Effective reason2
gen loaneffectivereason2=.
replace loaneffectivereason2=. if loaneffectivereasondetails=="ADVANCE FOR SUGARCANE CUTTING"
replace loaneffectivereason2=. if loaneffectivereasondetails=="AGRI"
replace loaneffectivereason2=. if loaneffectivereasondetails=="AGRI CULTURE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="AGRI."
replace loaneffectivereason2=. if loaneffectivereasondetails=="AGRICULTRE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="Agriculture"
replace loaneffectivereason2=. if loaneffectivereasondetails=="agriculture"
replace loaneffectivereason2=. if loaneffectivereasondetails=="AGRICULTURE"
replace loaneffectivereason2=2 if loaneffectivereasondetails=="AGRICULTURE AND FAMILY EXPS"
replace loaneffectivereason2=3 if loaneffectivereasondetails=="AGRICULTURE AND HEALTH"
replace loaneffectivereason2=. if loaneffectivereasondetails=="AGRICULTURE EXP"
replace loaneffectivereason2=2 if loaneffectivereasondetails=="AGRICULTURE EXP & FAMILY EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="AGRICUTURAL EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="AGRICUTURE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BATHROOM CONSTRUCTION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BIKE REPAIR"
replace loaneffectivereason2=. if loaneffectivereasondetails=="bore well"
replace loaneffectivereason2=. if loaneffectivereasondetails=="Borewell"
replace loaneffectivereason2=. if loaneffectivereasondetails=="brother marriage"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BROTHER MARRIAGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BROTHERS MARRIAGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BROTHES MARRIAGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BROUGHT THE PLOT"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BUISINESS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BUISINESS EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BUISINESS INVESTMENT"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BUSINESS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BUSINESS EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BUSINESS INPUTS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BUY COW"
replace loaneffectivereason2=2 if loaneffectivereasondetails=="BUY JEWEL"
replace loaneffectivereason2=. if loaneffectivereasondetails=="BUY LAND"
replace loaneffectivereason2=. if loaneffectivereasondetails=="CEREMONIES"
replace loaneffectivereason2=. if loaneffectivereasondetails=="CHAMBER WORK"
replace loaneffectivereason2=. if loaneffectivereasondetails=="COUSIN MARRIAGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="cow purchasing"
replace loaneffectivereason2=. if loaneffectivereasondetails=="CREDIT SETTILE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="CREDIT SETTLE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="CREDIT SETTLED"
replace loaneffectivereason2=. if loaneffectivereasondetails=="DAUGHTER DELIVERY"
replace loaneffectivereason2=. if loaneffectivereasondetails=="DAUGHTER FUNCTION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="DAUGHTER MARRIAGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="daughter marriage"
replace loaneffectivereason2=. if loaneffectivereasondetails=="DAUGHTER MARRIGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="DAUGHTER PUBERTY"
replace loaneffectivereason2=. if loaneffectivereasondetails=="daughter puberyt ceremony"
replace loaneffectivereason2=. if loaneffectivereasondetails=="DAUGHTERMARRIAGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="daughters education"
replace loaneffectivereason2=. if loaneffectivereasondetails=="DAUGHTERS MARRIAGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="DAUGHTERS MARRIAGE EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="DEATH"
replace loaneffectivereason2=. if loaneffectivereasondetails=="DEATH EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="DELIVERY EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="DOUGHTER FUNCTION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="DOUGHTER MARRIAGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="EAR BOREING CEREMONY"
replace loaneffectivereason2=. if loaneffectivereasondetails=="EAR BORING CEREMONY EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="education"
replace loaneffectivereason2=. if loaneffectivereasondetails=="EDUCATION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="EDUCATION EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="EDUCATION EXPENS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="ELECTION"
replace loaneffectivereason2=3 if loaneffectivereasondetails=="FAMILY AND MEDICAL EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FAMILY EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="family exp"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FAMILY EXPENS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FAMILY EXPENSES"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FAMILY EXPS"
replace loaneffectivereason2=5 if loaneffectivereasondetails=="FAMILY EXPS AND HOUSE REPAIR"
replace loaneffectivereason2=6 if loaneffectivereasondetails=="FAMILY EXPS AND INVESTMENT"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FAMILY EXPS."
replace loaneffectivereason2=. if loaneffectivereasondetails=="FAMILY EXSP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FAMILY FUNCTION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FATHER MEDICAL EXPS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FESTIVAL"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FESTIVAL EXPS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FESTIVEL"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FESTIVEL EXPENS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FESTIVELS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FOR BUSINESS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FRUTI BUSINESS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FUNERAL"
replace loaneffectivereason2=. if loaneffectivereasondetails=="FUNERAL EXPENS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HANDLOOM"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HANDLOOM WORK"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HEALTH"
replace loaneffectivereason2=2 if loaneffectivereasondetails=="HEALTH AND FAMILY EXPENS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HEALTH EXPEN"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HEALTH EXPENS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HELATH EXPENS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HOUSE CONSRTUCTION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HOUSE CONSTRUCTION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HOUSE CONSTRUCTION EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="House repair"
replace loaneffectivereason2=. if loaneffectivereasondetails=="house repair"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HOUSE REPAIR"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HOUSE REPAIRE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HOUSE REPAIRING"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HUSBAND DEATH EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="HUSBAND DEATH EXPENS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="INTEREST SETTLE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="INVESTMEN"
replace loaneffectivereason2=. if loaneffectivereasondetails=="INVESTMENT"
replace loaneffectivereason2=. if loaneffectivereasondetails=="INVESTMENT FOR BUSINESS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="JOB EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="KADHU KUTHAL"
replace loaneffectivereason2=. if loaneffectivereasondetails=="LABOUR ADVANCE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="LAND LEASE EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="madicla exp"
replace loaneffectivereason2=. if loaneffectivereasondetails=="marriage"
replace loaneffectivereason2=. if loaneffectivereasondetails=="MARRIAGE"
replace loaneffectivereason2=1 if loaneffectivereasondetails=="MARRIAGE AND AGRICULTURE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="MARRIAGE EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="MARRIAGE EXPENS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="MEDICAL EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="MEDICAL EXPENS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="MEDICAL EXPS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="MOTHER HEALTH"
replace loaneffectivereason2=. if loaneffectivereasondetails=="MOTHER IN LAW DEATH EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="PAY ADVANCE TO THE LABOUR"
replace loaneffectivereason2=. if loaneffectivereasondetails=="PETTI SHOP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="PLACEMENT"
replace loaneffectivereason2=. if loaneffectivereasondetails=="PUBERTY"
replace loaneffectivereason2=. if loaneffectivereasondetails=="PUBERTY CEREMONIE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="PUBERTY CEREMONIES EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="puberty ceremony"
replace loaneffectivereason2=. if loaneffectivereasondetails=="PUBERTY CEREMONY"
replace loaneffectivereason2=. if loaneffectivereasondetails=="PUBERTY CEREMONY EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="PUBERTY FUNCTION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="PUBRTY CEREMONY"
replace loaneffectivereason2=. if loaneffectivereasondetails=="PUBRTY CEREMONY EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RECONSTRUCT HOUSE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATIEVES FUNCTION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATIEVES MARRIAGE EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATION DEATH"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATION FUNCTION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATION FUNERAL"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATION MARRIAGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATIONS FUNERAL"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATIVE DEATH"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATIVE FUNCTION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATIVE FUNTION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATIVE MARRIAGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="relatives ceremonies"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATIVES DEATH EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATIVES FESTIVALS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATIVES FESTIVALS EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATIVES FUNCTION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATIVES FUNCTION EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RELATIVES MARRIAGE EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="RENT FOR HOUSE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="REPAYMENT FOR PREVIOUS LOAN"
replace loaneffectivereason2=. if loaneffectivereasondetails=="REPAYMENT FOR PREVIOUS LOAN INTERESTS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="REPAYMENT PREVIOUS LOAN"
replace loaneffectivereason2=. if loaneffectivereasondetails=="REPAYMENTFOR PREVIOUS LOAN"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SETTLED LOAN"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SHOP CONSTRUCTION EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SISTER MARRIAGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SISTER PREGNANCY"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SISTERS MARRIAGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SISTERS MARRIAGE EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SON ACCIDENT TREATMENT EXPENS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SON EDUCATION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SON MARRIAGE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SON MARRIAGE EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SON PLACEMENT"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SONS MARRIAGE EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SONS MEDICAL EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SUGARCANE EXP"
replace loaneffectivereason2=. if loaneffectivereasondetails=="SULAI PODA"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TEMPLE FESTIVAL"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO BUILD HOUSE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO BUY AGRI LAND"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO BUY BIKE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO BUY BULLOCART VEHICLE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO BUY BULLOCK"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO BUY COW"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO BUY FUNITURE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO BUY HOUSE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO BUY LAND"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO BUY LOAD CARRIER VEHICLE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO BUY PLOT"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO BUY TATA VEHICLE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO BUY TRACTOR"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO EXTEND OUR BUSINESS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO GIVE GIFT NEIBHOUR MARRIAGE FUNCTION"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO GO ABROAD"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO GO GULF"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO MAKE BORE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO REAIRING HOUSE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO REBUILD HOUSE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO REPAIR HOUSE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO REPAIRE HOUSE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO REPAIRING HOUSE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO REPAYMENT FOR PREVIOUS LOAN"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO REPAYMENT PREVIOUS LOAN"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO SETTLE PREVIOUS LOAN"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO SETTLE PREVIUOS LOAN"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TO SETTLE THE PREVIOUS LOAN"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TRACTOR"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TRACTOR LOAN"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TREATMENT"
replace loaneffectivereason2=. if loaneffectivereasondetails=="TREATMENT FOR DAUGHTER"
replace loaneffectivereason2=. if loaneffectivereasondetails=="VALAIKAPPU"
replace loaneffectivereason2=. if loaneffectivereasondetails=="VEHICLE MAINTANANCE"
replace loaneffectivereason2=. if loaneffectivereasondetails=="WEEDING"
replace loaneffectivereason2=. if loaneffectivereasondetails=="WIFE HEALTH EXPS"
replace loaneffectivereason2=. if loaneffectivereasondetails=="WIFE SISSTERS MARRIAGE EXP"

order loaneffectivereason loaneffectivereason2, before(loaneffectivereasondetails)
label values loaneffectivereason loanreasongiven
label values loaneffectivereason2 loanreasongiven


save "_temp\RUME-loans_v5.dta", replace
****************************************
* END










****************************************
* Creation + loanamount + 66 
****************************************
use "_temp\RUME-loans_v5.dta", clear


********** Creation
gen dummyml=0
replace dummyml=1 if lendername!=""
gen corr=0
replace principalpaid=0 if principalpaid==. & dummyml==1
replace interestpaid=0 if interestpaid==. & dummyml==1
gen totalrepaid=principalpaid+interestpaid
foreach x in loanamount loanbalance interestpaid totalrepaid principalpaid interestloan {
gen `x'2=`x'
}
gen loanduration_month=loanduration/30.4167




********** 66
foreach x in loanamount2 totalrepaid2 interestpaid2 principalpaid2 interestloan2 {
replace `x'=. if `x'==66
replace `x'=. if `x'==77
replace `x'=. if `x'==88
replace `x'=. if `x'==99
}



********** Consistency loanamount
sort loanamount
*br HHID2010   loanid   loansettled lender4 loanreasongiven loanduration_month loanamount2 loanbalance2 totalrepaid2 principalpaid2 interestpaid2 interestfrequency interestloan2 termsofrepayment repayduration1 



********** Consistency interestpaid2
sort interestpaid2
*br HHID2010   loanid   loansettled lender4 loanreasongiven loanduration_month loanamount2 loanbalance2 totalrepaid2 principalpaid2 interestpaid2 interestfrequency interestloan2 termsofrepayment repayduration1 



********** Consistency interestloan2
sort interestloan2
*br HHID2010   loanid   loansettled lender4 loanreasongiven loanduration_month loanamount2 loanbalance2 totalrepaid2 principalpaid2 interestpaid2 interestfrequency interestloan2 termsofrepayment repayduration1 


********** Consistency principalpaid2
sort principalpaid2
*br HHID2010   loanid   loansettled lender4 loanreasongiven loanduration_month loanamount2 loanbalance2 totalrepaid2 principalpaid2 interestpaid2 interestfrequency interestloan2 termsofrepayment repayduration1 



save "_temp\RUME-loans_v6.dta", replace
****************************************
* END










****************************************
* Balance / principal / amount
****************************************
use "_temp\RUME-loans_v6.dta", clear

gen test1=loanamount2-loanbalance2-principalpaid2
gen pb1=0 if dummyml==1
replace pb1=1 if test1!=0 & test1!=.
ta pb1
/*
100% des cas c'est ok
*/

drop pb1 test1

save "_temp\RUME-loans_v7.dta", replace
****************************************
* END















****************************************
* Interest consistency
****************************************
use "_temp\RUME-loans_v7.dta", clear


********** Gen interest loan per month
gen interestloan_month=.
replace interestloan_month=interestloan2*4.3452 if interestfrequency==1  // weekly
replace interestloan_month=interestloan2 if interestfrequency==2  // monthly
replace interestloan_month=interestloan2/12 if interestfrequency==3  // yearly
replace interestloan_month=interestloan2/6 if interestfrequency==4  // once in six month


********** Consistency: pb if interest loan > interestpaid
* On accepte 1000 roupies d'erreur
gen test=interestloan_month*loanduration_month  // theoretical interestpaid
gen pb=.
replace pb=0 if test==interestpaid & dummyml==1
replace pb=1 if test>interestpaid & dummyml==1
replace pb=2 if test<interestpaid & dummyml==1

label define pbint 0"No pb" 1"Theo > Paid" 2"Theo < Paid"
label values pb pbint

gen test2=test-interestpaid
replace pb=. if test2<=1000 & test2>=-1000

fre pb
/*
-------------------------------------------------------------------
                      |      Freq.    Percent      Valid       Cum.
----------------------+--------------------------------------------
Valid   1 Theo > Paid |        887      37.02      95.79      95.79
        2 Theo < Paid |         39       1.63       4.21     100.00
        Total         |        926      38.65     100.00           
Missing .             |       1470      61.35                      
Total                 |       2396     100.00                      
-------------------------------------------------------------------
*/

ta lender4 pb
drop interestloan_month pb test test2


********** Mano corr
gen test=interestpaid2/loanamount2
sort test
*br HHID2010   loanid loansettled loanreasongiven lender4 loanamount2 principalpaid2 interestpaid2 test interestfrequency interestloan2 loanduration_month corr




drop test


save "_temp\RUME-loans_v8.dta", replace
****************************************
* END












****************************************
* Interest consistency BIG CLEAN
****************************************
use "_temp\RUME-loans_v8.dta", clear



********** Gen interest loan per month
gen interestloan_month=.
replace interestloan_month=interestloan2*4.3452 if interestfrequency==1  // weekly
replace interestloan_month=interestloan2 if interestfrequency==2  // monthly
replace interestloan_month=interestloan2/12 if interestfrequency==3  // yearly
replace interestloan_month=interestloan2/6 if interestfrequency==4  // once in six month


********** Consistency: pb if interest loan > interestpaid
* On accepte 1000 roupies d'erreur
gen test=interestloan_month*loanduration_month  // theoretical interestpaid
gen pb=.
replace pb=0 if test==interestpaid & dummyml==1
replace pb=1 if test>interestpaid & dummyml==1
replace pb=2 if test<interestpaid & dummyml==1

label define pbint 0"No pb" 1"Theo > Paid" 2"Theo < Paid"
label values pb pbint

gen test2=test-interestpaid
replace pb=. if test2<=1000 & test2>=-1000

fre pb
/*
-------------------------------------------------------------------
                      |      Freq.    Percent      Valid       Cum.
----------------------+--------------------------------------------
Valid   1 Theo > Paid |        887      37.02      95.79      95.79
        2 Theo < Paid |         39       1.63       4.21     100.00
        Total         |        926      38.65     100.00           
Missing .             |       1470      61.35                      
Total                 |       2396     100.00                      
-------------------------------------------------------------------

*/

ta lender4 pb


********** Deux strat
sort test2
sort interestloan
*br HHID2010   loanid loansettled loanamount2 lender4 loanduration_month principalpaid2 interestpaid2 test test2 interestfrequency interestloan2 interestloan_month if pb==1
/*
Garder toujours le plus grand des deux
*/
*replace interestpaid2=interestloan_month*loanduration_month if test2>0 & (interestfrequency==1 | interestfrequency==2 | interestfrequency==3 | interestfrequency==4)
*replace interestloan=interestpaid2/loanduration_month if test2<=0 & (interestfrequency==1 | interestfrequency==2 | interestfrequency==3 | interestfrequency==4)

/*
Garder toujours le plus petit des deux
*/
replace interestpaid2=interestloan_month*loanduration_month if test2<=0 & (interestfrequency==1 | interestfrequency==2 | interestfrequency==3 | interestfrequency==4)
replace interestloan2=interestpaid2/loanduration_month if test2>0 & (interestfrequency==1 | interestfrequency==2 | interestfrequency==3 | interestfrequency==4)


drop interestloan_month pb test test2


save "_temp\RUME-loans_v9.dta", replace
****************************************
* END












****************************************
* Last global consistency
****************************************
use "_temp\RUME-loans_v9.dta", clear


********* Annual rate

*** Duration
gen loan_months=.
replace loan_months=loanduration_month if interestfrequency==1 | interestfrequency==2 | interestfrequency==6
replace loan_months=1 if loan_months<1

gen years=.
replace years=loanduration_month/12 if interestfrequency==3
gen loan_years=floor(years)

gen loan_year2=loan_year
replace loan_year2=1 if loan_year2<1 

*** Rate
gen yratepaid=.
*** if interest paid weekly, monthly or when have money, once in six months
replace yratepaid=(interestpaid2*100/loanamount2)/(loanduration_month/12) if interestfrequency==1 | interestfrequency==2 | interestfrequency==6 | interestfrequency==4


*** if interest paid yearly: interestpaid averaged with an integer for number of years 
replace yratepaid=(interestpaid2/loanamount2)*100/loan_year2 if interestfrequency==3


*** if interest=fixed amount
replace yratepaid=interestpaid2*100/loanamount2 if interestfrequency==5
replace yratepaid=. if dummyinterest==0


*** Results
sort yratepaid
*br HHID2010   loanid loansettled loanreasongiven lender4 loanamount2 loanbalance2  loanduration loanduration_month loan_month principalpaid2 interestpaid2 interestfrequency interestloan2 yratepaid


********** Corr for aberrant values



********** Correction
recode interestpaid2 principalpaid2 totalrepaid2 (.=0)
replace totalrepaid2=principalpaid2+interestpaid2


drop yratepaid loan_months years loan_years loan_year2


save "_temp\RUME-loans_v10.dta", replace
****************************************
* END













****************************************
* Rate
****************************************
use "_temp\RUME-loans_v10.dta", clear

********* Annual rate

*** Duration
gen loan_months=.
replace loan_months=loanduration_month if interestfrequency==1 | interestfrequency==2 | interestfrequency==6
replace loan_months=1 if loan_months<1

gen years=.
replace years=loanduration_month/12 if interestfrequency==3
gen loan_years=floor(years)

gen loan_year2=loan_year
replace loan_year2=1 if loan_year2<1 

*** Rate
gen yratepaid=.
*** if interest paid weekly, monthly or when have money, once in six months
replace yratepaid=(interestpaid2*100/loanamount2)/(loanduration_month/12) if interestfrequency==1 | interestfrequency==2 | interestfrequency==6 | interestfrequency==4


*** if interest paid yearly: interestpaid averaged with an integer for number of years 
replace yratepaid=(interestpaid2/loanamount2)*100/loan_year2 if interestfrequency==3


*** if interest=fixed amount
replace yratepaid=interestpaid2*100/loanamount2 if interestfrequency==5
replace yratepaid=. if dummyinterest==0


*** Results
sort yratepaid
*br HHID2010   loanid loansettled loanreasongiven lender4 loanamount2 loanbalance2  loanduration loanduration_month loan_month principalpaid2 interestpaid2 interestfrequency interestloan2 interestloan_month yratepaid
tabstat yratepaid if interestpaid>0 & interestpaid!=., by(lender4) stat(n mean cv p50 min max)
/*
     lender4 |         N      mean        cv       p50       min       max
-------------+------------------------------------------------------------
         WKP |       172  23.43507   .538818  22.53089  1.857508        72
   Relatives |       139  23.61564  .6219042  21.75499   .999451  104.2848
      Labour |       139  24.72465  .5421196  25.13476  2.786263        75
 Pawn broker |         3  76.18519  1.140034  26.87779  25.20721  176.4706
 Shop keeper |         1        18         .        18        18        18
Moneylenders |        40   33.6521   .746896  30.59044         6  156.4272
     Friends |        16  25.94806  .4162955  25.55151         3        36
 Microcredit |        55  23.31065   .637367  19.50384  .2667482  78.21437
        Bank |        14  14.18031  .6584333  11.69654  1.967068  30.00003
    Neighbor |       275  26.48493  .5686194  25.21384   .484931  156.4272
-------------+------------------------------------------------------------
       Total |       854   25.2013  .6262702  24.06596  .2667482  176.4706
--------------------------------------------------------------------------


ELENA:
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


********** Monthly
gen monthlyinterestrate=.
replace monthlyinterestrate=yratepaid if loanduration<=30.4167
replace monthlyinterestrate=(yratepaid/loanduration)*30.4167 if loanduration>30.4167

sort monthlyinterestrate
*br HHID2010   loanid loansettled loanreasongiven lender4 loanamount2 loanbalance2  loanduration loanduration_month principalpaid2 interestpaid2 interestfrequency interestloan2 interestloan_month yratepaid monthlyinterestrate

tabstat monthlyinterestrate, stat(n mean cv p50 min max) by(lender4)


save "_temp\RUME-loans_v11.dta", replace
****************************************
* END
















****************************************
* Imputations
****************************************
use "_temp\RUME-loans_v11.dta", clear

********** Add income
merge m:1 HHID2010 using "outcomes\RUME-occup_HH.dta", keepusing(annualincome_HH)
drop if _merge==2
drop _merge
ta annualincome_HH



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
replace imp_principal=loanamount2-loanbalance2 if loanduration<=365 & debt_service==.
replace imp_principal=(loanamount2-loanbalance2)*365/loanduration if loanduration>365 & debt_service==.



*** Imputation interest for moneylenders and microcredit
gen imp1_interest=.
replace imp1_interest=0.33*loanamount2 if lender4==6 & loanduration<=365 & debt_service==.
replace imp1_interest=0.33*loanamount2*365/loanduration if lender4==6 & loanduration>365 & debt_service==.
replace imp1_interest=0.23*loanamount2 if lender4==8 & loanduration<=365 & debt_service==.
replace imp1_interest=0.23*loanamount2*365/loanduration if lender4==8 & loanduration>365 & debt_service==.
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


*** Services
bysort HHID2010: egen imp1_ds_tot_HH=sum(imp1_debt_service)
bysort HHID2010: egen imp1_is_tot_HH=sum(imp1_interest_service)


gen dsr=imp1_ds_tot_HH*100/annualincome_HH
gen isr=imp1_is_tot_HH*100/annualincome_HH

preserve
keep HHID2010 dsr isr
duplicates drop
tabstat dsr isr, stat(n mean sd q p90 p95 p99 max)
tabstat dsr isr, stat(n mean sd q p90 p95 p99 max)
restore

/*
   stats |       dsr       isr
---------+--------------------
       N |       405       405
    mean |  33.47363  11.47373
      sd |  47.15226  14.66202
     p25 |  6.631317  1.754069
     p50 |  19.11833  7.252747
     p75 |  43.87097        15
     p90 |  81.65864     27.75
     p95 |  107.1118   37.6863
     p99 |  200.2351    66.875
     max |    482.22  138.5955
------------------------------
*/

drop dsr isr annualincome_HH imp1_ds_tot_HH imp1_is_tot_HH


save "_temp\RUME-loans_v12.dta", replace
****************************************
* END











****************************************
* Other measure
****************************************
use"_temp\RUME-loans_v12.dta", clear


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
gen lenderamt_`x'=loanamount2 if lender_`x'==1
}
foreach x in WKP rela labo pawn shop mone frie micr bank neig {
gen lender4amt_`x'=loanamount2 if lender4_`x'==1
}
foreach x in info semi form {
gen lendercatamt_`x'=loanamount2 if lendercat_`x'==1
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
gen givenamt_`x'=loanamount2 if given_`x'==1
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
gen givencatamt_`x'=loanamount2 if givencat_`x'==1
}




********** Effective
fre loaneffectivereason
ta loaneffectivereason, gen(effective_)
rename effective_1 effective_agri
rename effective_2 effective_fami
rename effective_3 effective_heal
rename effective_4 effective_repa
rename effective_5 effective_hous
rename effective_6 effective_inve
rename effective_7 effective_cere
rename effective_8 effective_marr
rename effective_9 effective_educ
rename effective_10 effective_rela
rename effective_11 effective_deat


*Amt
foreach x in agri fami heal repa hous inve cere marr educ rela deat {
gen effectiveamt_`x'=loanamount2 if effective_`x'==1
}


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
bysort HHID2010: egen loanamount_HH=sum(loanamount2)




*** Services
bysort HHID2010: egen imp1_ds_tot_HH=sum(imp1_debt_service)
bysort HHID2010: egen imp1_is_tot_HH=sum(imp1_interest_service)




********** Individual and HH level for dummies
foreach x in lender_WKP lender_rela lender_empl lender_mais lender_coll lender_pawn lender_shop lender_fina lender_frie lender_SHG lender_bank lender_coop lender_suga lender4_WKP lender4_rela lender4_labo lender4_pawn lender4_shop lender4_mone lender4_frie lender4_micr lender4_bank lender4_neig lendercat_info lendercat_semi lendercat_form given_agri given_fami given_heal given_repa given_hous given_inve given_cere given_marr given_educ given_rela given_deat givencat_econ givencat_curr givencat_huma givencat_soci givencat_hous othlendserv_poli othlendserv_fina othlendserv_guar othlendserv_gene othlendserv_othe othlendserv_6 othlendserv_nrep guarantee_chit guarantee_shg guarantee_both guarantee_none borrservices_free borrservices_work borrservices_supp borrservices_othe borrservices_nrep plantorep_chit plantorep_work plantorep_migr plantorep_asse plantorep_inco plantorep_borr plantorep_noth plantorep_othe plantorep_nrep effective_agri effective_fami effective_heal effective_repa effective_hous effective_inve effective_cere effective_marr effective_educ effective_rela effective_deat {

bysort HHID2010: egen nbHH_`x'=sum(`x')
gen dumHH_`x'=0
replace dumHH_`x'=1 if nbHH_`x'>0
}


foreach x in lenderamt_WKP lenderamt_rela lenderamt_empl lenderamt_mais lenderamt_coll lenderamt_pawn lenderamt_shop lenderamt_fina lenderamt_frie lenderamt_SHG lenderamt_bank lenderamt_coop lenderamt_suga lender4amt_WKP lender4amt_rela lender4amt_labo lender4amt_pawn lender4amt_shop lender4amt_mone lender4amt_frie lender4amt_micr lender4amt_bank lender4amt_neig lendercatamt_info lendercatamt_semi lendercatamt_form givenamt_agri givenamt_fami givenamt_heal givenamt_repa givenamt_hous givenamt_inve givenamt_cere givenamt_marr givenamt_educ givenamt_rela givenamt_deat givencatamt_econ givencatamt_curr givencatamt_huma givencatamt_soci givencatamt_hous effectiveamt_agri effectiveamt_fami effectiveamt_heal effectiveamt_repa effectiveamt_hous effectiveamt_inve effectiveamt_cere effectiveamt_marr effectiveamt_educ effectiveamt_rela effectiveamt_deat {

bysort HHID2010: egen totHH_`x'=sum(`x')
}




*HH
preserve
duplicates drop HHID2010, force
keep HHID2010 nbloans_HH loanamount_HH imp1_ds_tot_HH imp1_is_tot_HH nbHH_lender_WKP dumHH_lender_WKP nbHH_lender_rela dumHH_lender_rela nbHH_lender_empl dumHH_lender_empl nbHH_lender_mais dumHH_lender_mais nbHH_lender_coll dumHH_lender_coll nbHH_lender_pawn dumHH_lender_pawn nbHH_lender_shop dumHH_lender_shop nbHH_lender_fina dumHH_lender_fina nbHH_lender_frie dumHH_lender_frie nbHH_lender_SHG dumHH_lender_SHG nbHH_lender_bank dumHH_lender_bank nbHH_lender_coop dumHH_lender_coop nbHH_lender_suga dumHH_lender_suga nbHH_lender4_WKP dumHH_lender4_WKP nbHH_lender4_rela dumHH_lender4_rela nbHH_lender4_labo dumHH_lender4_labo nbHH_lender4_pawn dumHH_lender4_pawn nbHH_lender4_shop dumHH_lender4_shop nbHH_lender4_mone dumHH_lender4_mone nbHH_lender4_frie dumHH_lender4_frie nbHH_lender4_micr dumHH_lender4_micr nbHH_lender4_bank dumHH_lender4_bank nbHH_lender4_neig dumHH_lender4_neig nbHH_lendercat_info dumHH_lendercat_info nbHH_lendercat_semi dumHH_lendercat_semi nbHH_lendercat_form dumHH_lendercat_form nbHH_given_agri dumHH_given_agri nbHH_given_fami dumHH_given_fami nbHH_given_heal dumHH_given_heal nbHH_given_repa dumHH_given_repa nbHH_given_hous dumHH_given_hous nbHH_given_inve dumHH_given_inve nbHH_given_cere dumHH_given_cere nbHH_given_marr dumHH_given_marr nbHH_given_educ dumHH_given_educ nbHH_given_rela dumHH_given_rela nbHH_given_deat dumHH_given_deat nbHH_givencat_econ dumHH_givencat_econ nbHH_givencat_curr dumHH_givencat_curr nbHH_givencat_huma dumHH_givencat_huma nbHH_givencat_soci dumHH_givencat_soci nbHH_givencat_hous dumHH_givencat_hous nbHH_othlendserv_poli dumHH_othlendserv_poli nbHH_othlendserv_fina dumHH_othlendserv_fina nbHH_othlendserv_guar dumHH_othlendserv_guar nbHH_othlendserv_gene dumHH_othlendserv_gene nbHH_othlendserv_othe dumHH_othlendserv_othe nbHH_othlendserv_6 dumHH_othlendserv_6 nbHH_othlendserv_nrep dumHH_othlendserv_nrep nbHH_guarantee_chit dumHH_guarantee_chit nbHH_guarantee_shg dumHH_guarantee_shg nbHH_guarantee_both dumHH_guarantee_both nbHH_guarantee_none dumHH_guarantee_none nbHH_borrservices_free dumHH_borrservices_free nbHH_borrservices_work dumHH_borrservices_work nbHH_borrservices_supp dumHH_borrservices_supp nbHH_borrservices_othe dumHH_borrservices_othe nbHH_borrservices_nrep dumHH_borrservices_nrep nbHH_plantorep_chit dumHH_plantorep_chit nbHH_plantorep_work dumHH_plantorep_work nbHH_plantorep_migr dumHH_plantorep_migr nbHH_plantorep_asse dumHH_plantorep_asse nbHH_plantorep_inco dumHH_plantorep_inco nbHH_plantorep_borr dumHH_plantorep_borr nbHH_plantorep_noth dumHH_plantorep_noth nbHH_plantorep_othe dumHH_plantorep_othe nbHH_plantorep_nrep dumHH_plantorep_nrep totHH_lenderamt_WKP totHH_lenderamt_rela totHH_lenderamt_empl totHH_lenderamt_mais totHH_lenderamt_coll totHH_lenderamt_pawn totHH_lenderamt_shop totHH_lenderamt_fina totHH_lenderamt_frie totHH_lenderamt_SHG totHH_lenderamt_bank totHH_lenderamt_coop totHH_lenderamt_suga totHH_lender4amt_WKP totHH_lender4amt_rela totHH_lender4amt_labo totHH_lender4amt_pawn totHH_lender4amt_shop totHH_lender4amt_mone totHH_lender4amt_frie totHH_lender4amt_micr totHH_lender4amt_bank totHH_lender4amt_neig totHH_lendercatamt_info totHH_lendercatamt_semi totHH_lendercatamt_form totHH_givenamt_agri totHH_givenamt_fami totHH_givenamt_heal totHH_givenamt_repa totHH_givenamt_hous totHH_givenamt_inve totHH_givenamt_cere totHH_givenamt_marr totHH_givenamt_educ totHH_givenamt_rela totHH_givenamt_deat totHH_givencatamt_econ totHH_givencatamt_curr totHH_givencatamt_huma totHH_givencatamt_soci totHH_givencatamt_hous nbHH_effective_agri dumHH_effective_agri nbHH_effective_fami dumHH_effective_fami nbHH_effective_heal dumHH_effective_heal nbHH_effective_repa dumHH_effective_repa nbHH_effective_hous dumHH_effective_hous nbHH_effective_inve dumHH_effective_inve nbHH_effective_cere dumHH_effective_cere nbHH_effective_marr dumHH_effective_marr nbHH_effective_educ dumHH_effective_educ nbHH_effective_rela dumHH_effective_rela nbHH_effective_deat dumHH_effective_deat totHH_effectiveamt_agri totHH_effectiveamt_fami totHH_effectiveamt_heal totHH_effectiveamt_repa totHH_effectiveamt_hous totHH_effectiveamt_inve totHH_effectiveamt_cere totHH_effectiveamt_marr totHH_effectiveamt_educ totHH_effectiveamt_rela totHH_effectiveamt_deat
save"outcomes\RUME-loans_HH.dta", replace
restore

*************************************
* END




use"outcomes\RUME-loans_HH.dta", clear

