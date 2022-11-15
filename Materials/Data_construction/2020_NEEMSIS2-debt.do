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
global data = "NEEMSIS2-HH"
global loans = "NEEMSIS2-loans_mainloans"


********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020







****************************************
* GOLD
****************************************
use"$data", clear

********** Cleaning Elena

g goldquantitypledge2=goldquantitypledge
g goldamountpledge2=goldamountpledge
g loanamountgold2=loanamountgold
g goldquantity2=goldquantity

*** check consistency total gold / pledged gold
g	unpledged_goldquantity=goldquantity - goldquantitypledge
ta unpledged
ta goldquantity goldquantitypledge if unpledged_g<0 
ta goldamountpledge if goldquantitypledge==140000
list HHID2020 if goldquantitypledge==140000
list INDID2020 if goldquantitypledge==140000
* 1 cas ou quantité et montant gagés ont été inversés (l inversion est cohérente avec loanamountgold)
replace goldquantitypledge2=48 if HHID2020=="uuid:3936b5d3-2709-4669-9986-9f427fac869a" & INDID2020==2
replace goldamountpledge2=140000 if HHID2020=="uuid:3936b5d3-2709-4669-9986-9f427fac869a" & INDID2020==2

g gold_rate=goldamountpledge2/goldquantitypledge2
ta gold_rate
su gold_rate, d

list HHID2020 INDID2020 goldquantity  goldquantitypledge2 goldamountpledge2  loanamountgold loanbalance gold_rate if unpledged_g<0 
*la solution la plus "conservative" consiste à considérer que le goldquantity declaré correspond à unpledged gold au lieu de totalgold (sinon il faut soit multiplier par 8 en considérant que c'est des sovereign, bof)
replace goldquantity2=goldquantity+goldquantitypledge2


*** check loanamountgold 
ta loanamountgold if goldamountpledge!=., mis
//66 peut etre soit une quantité,  soit une NR => vote pour le NR
replace loanamountgold2=goldamountpledge2 if HHID2020=="uuid:9bc0d4be-96cd-4d5e-aa71-98313b21905f " & INDID2020==2 //celui la est marqué missing dans le fichier all loans
//le 8 ici correspond probablement à la quantité
replace loanamountgold2=goldamountpledge2 if HHID2020=="uuid:435ed027-bac6-423b-ad03-8abc0e9aecf7" & INDID2020==1
//99 n est probablement pas une quantité;  on remplace par goldamountpledged
replace loanamountgold2=goldamountpledge2 if loanamountgold==99

fre loanamountgold2
list HHID2020 INDID2020 if loanamountgold2==24
// 24 loanamount ?
*br if HHID2020=="ELA23" & INDID2020=="Ind_2"
replace loanamountgold=goldamountpledge if HHID2020=="uuid:fb3e15f2-aede-49d5-8eee-514affc34b1a" & INDID2020==1
replace loanamountgold2=loanamountgold if HHID2020=="uuid:fb3e15f2-aede-49d5-8eee-514affc34b1a" & INDID2020==1

list HHID2020 INDID2020 if loanamountgold2==48
// 48
*br if HHID2020=="uuid:d98030a0-f814-4723-a35e-972e0eeb47783" & INDID2020=="Ind_2"
replace loanamountgold=goldamountpledge if HHID2020=="uuid:f93966cd-7487-4ab9-992a-a61437b648ff" & INDID2020==2
replace loanamountgold2=loanamountgold if HHID2020=="uuid:f93966cd-7487-4ab9-992a-a61437b648ff" & INDID2020==2

*** check consistency goldamountpledge goldquantitypled
ta goldamountpledge2
ta goldamountpledge2 goldquantitypledge2 if goldamountpledge2<2000
*on considere que répondu en lakh (on a bien des loanamountgold en milliers)
replace goldamountpledge2=8000 if goldamountpledge==8
replace goldamountpledge2=16000 if goldamountpledge==16
replace goldamountpledge2=40000 if goldamountpledge==40
* pour ceux qui ne renseignent pas goldamountpledge: soit on impute sur la base d'une valeur pour l or (difficile vu la variabilité), soit on attribue la value du loanamountgold => c est ce qu on fait ici
replace goldamountpledge2=loanamountgold if goldamountpledge==0 & loanamountgold!=.


*** check problems of 0
g temp=goldamountpledge2/loanamountgold
g test=0
replace test=1 if loanamountgold!=. & goldamountpledge2!=. & (goldamountpledge2==10*loanamountgold | loanamountgold==10*goldamountpledge2)

list HHID2020 INDID2020 goldquantity  goldquantitypledge2 goldamountpledge2  loanamountgold gold_rate temp if test==1
*vu le goldrate, on peut considérer que goldamountpl a un 0 en trop
replace goldamountpledge2=goldamountpledge2/10 if HHID2020=="uuid:4df12d9e-63a9-48e2-a962-517cc3ec8a65"  & INDID2020==2 | HHID2020=="uuid:7b70f238-d8fa-471b-8cd7-f89a30c1f9f4" & INDID2020==2 | HHID2020=="uuid:a2e54cd3-e9ca-4dba-945c-acb552cf74bf" & INDID2020==2
* et vice versa, 0 en trop pour loanamount
replace loanamountgold2=loanamountgold2/10 if HHID2020=="uuid:83d1f6fc-59e8-4afe-b725-2b5eee50cce8"  & INDID2020==4 | HHID2020=="uuid:17e456bc-0327-461c-9782-de911c716e4f"  & INDID2020==2

drop temp test



********** Cleaning Arnaud

*** Balance à corriger
fre loansettledgold
gen loanbalancegold2=.
replace loanbalancegold2=0 if loansettledgold==1
replace loanbalancegold2=loanamountgold2 if loansettledgold==0

*** Forme
*rename goldownername namefromearlier 
*rename goldnumber INDID

*drop goldreasonpledge_1 goldreasonpledge_2 goldreasonpledge_3 goldreasonpledge_4 goldreasonpledge_5 goldreasonpledge_6 goldreasonpledge_7 goldreasonpledge_8 goldreasonpledge_9 goldreasonpledge_10 goldreasonpledge_11 goldreasonpledge_12 goldreasonpledge_77

*** Reste of amount pledge
gen diff_pledge=goldamountpledge2-loanamountgold2
gen pb=0
replace pb=1 if diff_pledge<0
drop diff_pledge
ta pb
/*
pb bc loanamount>pledge
*/

*** Inverser amount pledge et loanamount si loanamount>pledge
gen loanamountgold3=loanamountgold2
replace loanamountgold3=goldamountpledge2 if pb==1

gen goldamountpledge3=goldamountpledge2
replace goldamountpledge3=loanamountgold2 if pb==1

gen diff_pledge2=goldamountpledge2-loanamountgold2
gen diff_pledge3=goldamountpledge3-loanamountgold3
ta diff_pledge2
ta diff_pledge3
drop diff_pledge2 diff_pledge3


*** New loan with diff loan pledge
gen loanamountgoldrest=goldamountpledge3-loanamountgold3
recode loanamountgoldrest (0=.)
ta loanamountgoldrest
gen goldreasonpledgerest=goldreasonpledgemain if loanamountgoldrest!=.
order loanamountgoldrest goldreasonpledgerest
sort goldreasonpledgerest
tostring goldreasonpledgerest, replace
replace goldreasonpledgerest=goldreasonpledge if goldreasonpledgerest=="." & loanamountgoldrest!=.
ta goldreasonpledgerest

replace goldreasonpledgerest="1" if goldreasonpledgerest=="1 2"
replace goldreasonpledgerest="1" if goldreasonpledgerest=="1 2 3 4"
replace goldreasonpledgerest="1" if goldreasonpledgerest=="1 2 4"
replace goldreasonpledgerest="5" if goldreasonpledgerest=="1 2 5 7 10"
replace goldreasonpledgerest="5" if goldreasonpledgerest=="1 3 5 11"
replace goldreasonpledgerest="1" if goldreasonpledgerest=="1 4"
replace goldreasonpledgerest="2" if goldreasonpledgerest=="2 10"
replace goldreasonpledgerest="3" if goldreasonpledgerest=="2 3"
replace goldreasonpledgerest="3" if goldreasonpledgerest=="2 3 10"
replace goldreasonpledgerest="4" if goldreasonpledgerest=="2 3 4"
replace goldreasonpledgerest="5" if goldreasonpledgerest=="2 3 4 5"
replace goldreasonpledgerest="3" if goldreasonpledgerest=="2 3 4 9"
replace goldreasonpledgerest="4" if goldreasonpledgerest=="2 4"
replace goldreasonpledgerest="5" if goldreasonpledgerest=="2 4 5"
replace goldreasonpledgerest="5" if goldreasonpledgerest=="2 4 5 7"
replace goldreasonpledgerest="4" if goldreasonpledgerest=="2 4 7"
replace goldreasonpledgerest="8" if goldreasonpledgerest=="2 4 7 8"
replace goldreasonpledgerest="8" if goldreasonpledgerest=="2 4 7 8 10 11"
replace goldreasonpledgerest="8" if goldreasonpledgerest=="2 4 8"
replace goldreasonpledgerest="8" if goldreasonpledgerest=="2 4 8 10"
replace goldreasonpledgerest="7" if goldreasonpledgerest=="2 7"
replace goldreasonpledgerest="3" if goldreasonpledgerest=="3 4"
replace goldreasonpledgerest="5" if goldreasonpledgerest=="3 5"
replace goldreasonpledgerest="5" if goldreasonpledgerest=="4 5 7"
replace goldreasonpledgerest="6" if goldreasonpledgerest=="4 6"
replace goldreasonpledgerest="8" if goldreasonpledgerest=="5 8"
replace goldreasonpledgerest="9" if goldreasonpledgerest=="9 11"
*replace goldreasonpledgerest="" if goldreasonpledgerest==""

destring goldreasonpledgerest, replace
gen loanlenderrest=6


gen loan_database="GOLD"
drop if loanamountgold==.

rename loanamountgold loanamount
rename loanlendergold loanlender
rename loandategold loandate
rename goldreasonpledge loanreasongiven_MCQ
rename loanbalancegold loanbalance
rename loansettledgold loansettled
rename lenderfromgold lenderfrom
rename lenderscastegold lenderscaste

fre loansettled 

tab loanbalance, m  
tab loanbalance loansettled, m  //  314 loanbalance .
tab loanreasongiven_MCQ
split loanreasongiven_MCQ
destring loanreasongiven_MCQ1, replace
rename loanreasongiven_MCQ1 loanreasongiven
drop loanreasongiven_MCQ2 loanreasongiven_MCQ3 loanreasongiven_MCQ4 loanreasongiven_MCQ5 loanreasongiven_MCQ6 loanreasongiven_MCQ7 loanreasongiven_MCQ8 loanreasongiven_MCQ9 loanreasongiven_MCQ10
replace loanreasongiven=2 if loanreasongiven_MCQ=="1 2 3 4"
replace loanreasongiven=2 if loanreasongiven_MCQ=="1 2 3 4 5 6 9 10"
replace loanreasongiven=4 if loanreasongiven_MCQ=="1 2 4"
replace loanreasongiven=10 if loanreasongiven_MCQ=="1 2 4 10"
replace loanreasongiven=10 if loanreasongiven_MCQ=="1 2 4 9 10"
replace loanreasongiven=4 if loanreasongiven_MCQ=="1 2 5 7 10"
replace loanreasongiven=2 if loanreasongiven_MCQ=="1 2 9 10"
replace loanreasongiven=1 if loanreasongiven_MCQ=="1 3"
replace loanreasongiven=3 if loanreasongiven_MCQ=="1 3 5 11"
replace loanreasongiven=1 if loanreasongiven_MCQ=="1 4"
replace loanreasongiven=8 if loanreasongiven_MCQ=="1 8"
replace loanreasongiven=9 if loanreasongiven_MCQ=="1 9"
replace loanreasongiven=10 if loanreasongiven_MCQ=="2 10"
replace loanreasongiven=3 if loanreasongiven_MCQ=="2 3"
replace loanreasongiven=2 if loanreasongiven_MCQ=="2 3 10"
replace loanreasongiven=4 if loanreasongiven_MCQ=="2 3 4"
replace loanreasongiven=10 if loanreasongiven_MCQ=="2 3 4 10"
replace loanreasongiven=4 if loanreasongiven_MCQ=="2 3 4 5"
replace loanreasongiven=9 if loanreasongiven_MCQ=="2 3 4 9"
replace loanreasongiven=8 if loanreasongiven_MCQ=="2 3 8"
replace loanreasongiven=2 if loanreasongiven_MCQ=="2 4"
replace loanreasongiven=4 if loanreasongiven_MCQ=="2 4 10"
replace loanreasongiven=5 if loanreasongiven_MCQ=="2 4 5"
replace loanreasongiven=10 if loanreasongiven_MCQ=="2 4 5 10"
replace loanreasongiven=2 if loanreasongiven_MCQ=="2 4 5 7"
replace loanreasongiven=7 if loanreasongiven_MCQ=="2 4 7"
replace loanreasongiven=4 if loanreasongiven_MCQ=="2 4 7 10"
replace loanreasongiven=8 if loanreasongiven_MCQ=="2 4 7 8"
replace loanreasongiven=8 if loanreasongiven_MCQ=="2 4 7 8 10 11"
replace loanreasongiven=8 if loanreasongiven_MCQ=="2 4 8"
replace loanreasongiven=8 if loanreasongiven_MCQ=="2 4 8 10"
replace loanreasongiven=9 if loanreasongiven_MCQ=="2 4 9 10"
replace loanreasongiven=5 if loanreasongiven_MCQ=="2 5"
replace loanreasongiven=5 if loanreasongiven_MCQ=="2 5 9"
replace loanreasongiven=7 if loanreasongiven_MCQ=="2 7"
replace loanreasongiven=8 if loanreasongiven_MCQ=="2 8"
replace loanreasongiven=2 if loanreasongiven_MCQ=="2 9"
replace loanreasongiven=3 if loanreasongiven_MCQ=="3 10"
replace loanreasongiven=3 if loanreasongiven_MCQ=="3 4"
replace loanreasongiven=3 if loanreasongiven_MCQ=="3 5"
replace loanreasongiven=3 if loanreasongiven_MCQ=="3 7"
replace loanreasongiven=4 if loanreasongiven_MCQ=="4 10"
replace loanreasongiven=4 if loanreasongiven_MCQ=="4"
replace loanreasongiven=5 if loanreasongiven_MCQ=="4 5"
replace loanreasongiven=7 if loanreasongiven_MCQ=="4 5 7"
replace loanreasongiven=10 if loanreasongiven_MCQ=="4 5 8 10"
replace loanreasongiven=6 if loanreasongiven_MCQ=="4 6"
replace loanreasongiven=6 if loanreasongiven_MCQ=="5 6"
replace loanreasongiven=8 if loanreasongiven_MCQ=="5 8"
replace loanreasongiven=8 if loanreasongiven_MCQ=="8 9"
replace loanreasongiven=9 if loanreasongiven_MCQ=="9 10"
replace loanreasongiven=9 if loanreasongiven_MCQ=="9 11"
replace loanreasongiven=9 if loanreasongiven_MCQ=="9 77"
tab loanreasongiven, m
tab loanlender, m

label list
label define loanlendergold 15"Thandal", modify
ta loanlender, m

tab loanlender, m

clonevar loaneffectivereason=loanreasongiven
rename lenderscaste snmoneylendercastes
rename lenderfrom snmoneylenderliving

*** Var to keep
keep HHID2020 INDID2020 submissiondate version_HH caste jatis loanamount loandate loanreasongiven loaneffectivereason loanlender snmoneylendercastes loansettled loanbalance loan_database loanamountgold2 pb loanamountgold3 loanamountgoldrest loanbalancegold2 goldreasonpledgerest loanlenderrest

order HHID2020 INDID2020 loanamount loanamountgold2 loanamountgold3 loanamountgoldrest loanlender snmoneylendercastes loansettled loanbalance loanbalancegold2

sort loanamountgold3

*** Reshape
foreach x in loanamount loanlender snmoneylendercastes loansettled loanbalance loandate pb loanreasongiven loaneffectivereason {
rename `x' `x'1
}
rename loanamountgold2 loanamount_b1
rename loanamountgold3 loanamount_c1
rename loanbalancegold2 loanbalance_b1

rename loanamountgoldrest loanamount2
rename goldreasonpledgerest loanreasongiven2
rename loanlenderrest loanlender2

gen loandate2=loandate1

egen HHINDID=concat(HHID2020 INDID2020), p(/)

reshape long loanamount loanlender snmoneylendercastes loansettled loanbalance loandate pb loanreasongiven loaneffectivereason loanamount_b loanamount_c loanbalance_b, i(HHINDID) j(num)

*** Order
rename loanamount_b loanamount2
rename loanamount_c loanamount3
rename loanbalance_b loanbalance2

drop if loanamount==. & num==2
drop HHINDID

rename num rest
replace rest=rest-1
label define rest 0"Main gold loan" 1"Rest of pledge"
label values rest rest

order HHID2020 INDID2020 jatis caste rest loanamount* 
order submissiondate, last
order loanbalance2, after(loanbalance)

*** Label
label list
label values loanlender loanlendergold
label values loanreasongiven goldreasonpledgemain
label values loaneffectivereason goldreasonpledgemain
label values snmoneylendercastes casteemployer

*** Date
format loandate %td

*** Rest replace loan
replace loanamount2=loanamount if rest==1
replace loanamount3=loanamount if rest==1
replace loanbalance2=loanamount if rest==1

fre loan_database

save "_temp\NEEMSIS2-gold.dta", replace
****************************************
* END









****************************************
* APPEND
****************************************
use"$loans", clear

fre loan_database

append using "_temp\NEEMSIS2-gold.dta"

fre loan_database

preserve
keep if loan_database=="FINANCE"
*select_one lenders
fre loanlender
restore

preserve
keep if loan_database=="GOLD"
*select_one lenders
fre loanlender
restore

preserve
keep if loan_database=="MARRIAGE"
*select_one lenders
fre loanlender
restore

ta loanlender version_HH

tab loanlender, m
label define loanlender 1"Well known people" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn broker" 7"Shop keeper" 8"Finance (moneylenders)" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mill loan" 14"Group finance" 15"Thandal", replace
label values loanlender loanlender

/*
Dans les analyses, recoder les gold en pawnbroker
*/

tab loanlender loan_database
label variable loanlender "From whom did you get loan?"
tab loanlender

clonevar loanlender_rec=loanlender
replace loanlender_rec=6 if loan_database=="GOLD"

*drop if loansettled==1
tab loanlender loan_database

preserve
use"$data", clear
keep HHID2020 submissiondate
duplicates drop
save"_temp\NEEMSIS2-date", replace
restore

drop submissiondate
merge m:1 HHID2020 using "_temp\NEEMSIS2-date"
drop if _merge==2
drop _merge

gen submissiondate2=dofc(submissiondate) 
format %td submissiondate2

order HHID2020 submissiondate submissiondate2
drop submissiondate
rename submissiondate2 submissiondate

save"_temp\NEEMSIS2-loans_v5.dta", replace
****************************************
* END






****************************************
* Cat
****************************************

use"_temp\NEEMSIS2-loans_v5.dta", clear

********** New var for panel
*** Caste
clonevar lenderscaste=snmoneylendercastes

*** Relation
fre snmoneylenderdummyfam snmoneylenderfriend snmoneylenderwkp snmoneylenderlabourrelation
gen lenderrelation=.
replace lenderrelation=2 if snmoneylenderdummyfam==1
replace lenderrelation=10 if snmoneylenderfriend==1
replace lenderrelation=8 if snmoneylenderwkp==1
replace lenderrelation=1 if snmoneylenderlabourrelation==1

*** Living
fre snmoneylenderliving
gen lenderfrom=.
replace lenderfrom=1 if snmoneylenderliving==1
replace lenderfrom=1 if snmoneylenderliving==2
replace lenderfrom=2 if snmoneylenderliving==3
replace lenderfrom=2 if snmoneylenderliving==4
replace lenderfrom=2 if snmoneylenderliving==5
replace lenderfrom=2 if snmoneylenderliving==6

*** Sex
clonevar lendersex=snmoneylendersex

*** Occupation
clonevar lenderoccup=snmoneylenderoccup


********** Add caste, etc
*merge m:1 HHID2020 INDID2020 using "NEEMSIS2-HH_v16.dta", keepusing(egoid name sex age edulevel)
*drop if _merge==2

save"_temp\NEEMSIS2-loans_v6.dta", replace
****************************************
* END












****************************************
* DATE + DURATION + PURPOSE
****************************************
use"_temp\NEEMSIS2-loans_v6.dta", clear


*** Change date format of submissiondate
rename submissiondate submissiondate_o
gen submissiondate=dofc(submissiondate_o)
format submissiondate %td

*** Loan duration
gen loanduration=submissiondate-loandate

*** Type of loan
fre loanlender
gen lender_cat=.
label define lender_cat 1"Informal" 2"Semi formal" 3"Formal"
label values lender_cat lender_cat

foreach i in 1 2 3 4 5 7 9 13{
replace lender_cat=1 if loanlender_rec==`i'
}
foreach i in 6 10 15{
replace lender_cat=2 if loanlender_rec==`i'
}
foreach i in 8 11 12 14{
replace lender_cat=3 if loanlender_rec==`i'
}
fre lender_cat

*** Purpose of loan
replace loanreasongiven=loanreasongiven2 if loanreasongiven==.
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
save"_temp\NEEMSIS2-loans_v7.dta", replace
****************************************
* END











****************************************
* NEW LENDER VAR
****************************************
use "_temp\NEEMSIS2-loans_v7.dta", clear
fre loanlender
label define loanlender 1"WKP" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn Broker" 7"Shop keeper" 8"Finance (moneylenders)" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mill loan" 14"Group finance" 15"Thandal", replace  // Thandal = daily finance; door to door; small amount; it mean "immediat" in tamil
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
replace lender3=1 if snmoneylenderwkp==1  // WKP
replace lender3=2 if snmoneylenderdummyfam==1  // Relatives
replace lender3=3 if snmoneylenderlabourrelation==1  // labour
replace lender3=7 if snmoneylenderfriend==1  // Friends
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
clonevar lender4_rec=lender4
replace lender4_rec=4 if loan_database=="GOLD"
ta loanlender_rec lender4_rec

save "_temp\NEEMSIS2-loans_v8.dta", replace
****************************************
* END











****************************************
* ORDER + DUPLICATES + BALANCE and AMOUNT for everyone
****************************************
use"_temp\NEEMSIS2-loans_v8.dta", clear

*** Order
order HHID2020 INDID2020 loan_database loanamount loanamount2 loanamount3
sort HHID2020 INDID2020 loan_database loanamount3

gen loanduration_month=loanduration/30.467
replace loanduration_month=1 if loanduration_month<1
tab loanduration_month

dropmiss, force

*** After clean gold, replace in 2 and 3 version
replace loanbalance2=loanbalance if loan_database!="GOLD"
replace loanamount2=loanamount if loan_database!="GOLD"
replace loanamount3=loanamount if loan_database!="GOLD"


********** Duplicates
/*
***
preserve
***
duplicates tag HHID2020 INDID2020 loanamount loanlender loanreasongiven loandate, gen(tag)

bysort HHID2020 INDID2020: egen tokeep=sum(tag)
drop if tokeep==0
drop tokeep

gen gold=0
replace gold=1 if loan_database=="GOLD" & tag!=0 & tag!=.
bysort HHID2020 INDID2020: egen tokeep=sum(gold)
drop if tokeep==0
drop tokeep

ta tag
drop if tag==0
sort HHID2020 INDID2020 tag loanamount loan_database loandate
order HHID2020 INDID2020 loan_database tag

ta tag
drop if HHID2020=="KOR42" & INDID2020=="Ind_2" & loan_database=="FINANCE" & tag==1 & loanamount==45000
drop if HHID2020=="NAT30" & INDID2020=="Ind_5" & loan_database=="FINANCE" & tag==1 & loanamount==100000
drop if HHID2020=="NAT42" & INDID2020=="Ind_1" & loan_database=="FINANCE" & tag==1 & loanamount==50000
drop if HHID2020=="NAT50" & INDID2020=="Ind_1" & loan_database=="FINANCE" & tag==1 & loanamount==30000 & loandate==td(01jan2020)

drop if tag==2

gen duplicates=1
gen duplicatestodrop=0
replace duplicatestodrop=1 if loan_database=="GOLD"

drop tag

save"_temp\NEEMSIS2-loans_duplicates.dta", replace

***
restore
***
*/

*ta _merge
*drop _merge

*merge 1:1 HHID2020 INDID2020 loan_database loanamount loandate loanreasongiven loanlender loanid using "_temp\NEEMSIS2-loans_duplicates.dta", keepusing(duplicates duplicatestodrop)
*drop _merge
*ta duplicates 
*recode duplicates (.=0)
*recode duplicatestodrop (.=0)
*ta duplicates
*ta duplicatestodrop loan_database

save "_temp\NEEMSIS2-loans_v9.dta", replace
****************************************
* END















****************************************
* COHERENCE
****************************************
use"_temp\NEEMSIS2-loans_v9.dta", clear

********** Sample size test + 66 recode
clonevar interestpaid2=interestpaid
clonevar totalrepaid2=totalrepaid

*** Interest
ta dummyinterest
ta interestpaid if loan_database=="FINANCE"
*2819 --> 1442 as 66 --> 1377
replace interestpaid2=. if interestpaid==55 | interestpaid==66

*** Repaid
ta loansettled if loan_database=="FINANCE"
*4303 loans
ta dummyinterest if loansettled==0 & loan_database=="FINANCE"
* 2512 loans non settled with interest........
* =2512 loans with totalrepaid
/*
Il y a une erreur dans le questionnaire ici je suppose, la question ne doit être conditionnée que aux prêts non settled
Même si la personne ne paye pas d'intérêts, la question aurait quand même due être posée
Parce que, du coup, nous ne pouvons pas faire la double vérification pour pas mal de prêts
*/
ta totalrepaid if loan_database=="FINANCE"
*2512 --> 39 as 66 --> 2473
replace totalrepaid2=. if totalrepaid==66

*** Loan amount
replace loanamount=. if loanamount==66




********** Principalpaid creation
*** Generique
g principalpaid=.
replace principalpaid=totalrepaid2-interestpaid2
ta principalpaid

*** Cas ou total repaid=0 mais interestpaid>0
replace principalpaid=0 if totalrepaid2==0 


*** Cas ou il n'y a pas d'intérêts (à voir après)
*replace principalpaid=totalrepaid if principalpaid==. & dummyinterest==1 & totalrepaid!=.

gen test=(totalrepaid2-interestpaid2==loanamount3-loanbalance2)
ta test
/*
       test |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      4,397       75.76       75.76
          1 |      1,407       24.24      100.00
------------+-----------------------------------
      Total |      5,804      100.00
*/
drop test



********** Small amount of loanbalance
list HHID2020 INDID2020 loanamount loanbalance totalrepaid interestpaid loan_database loanid if loanbalance<100 & loanbalance>0, clean noobs

* totalrepaid - interestpaid = 11115, ie principal left=8885
replace loanbalance2=8885 if HHID2020=="uuid:541139fd-a9ac-4595-96af-4fc6f8602f10" & INDID2020==2 & loanid==2
*si valeurs  bizarres: on garde loanamount
replace loanbalance2=loanamount if ///
(HHID2020=="uuid:e929db9e-dcb2-4dc6-b523-4c39c8848ba1" & INDID2020==4 & loanid==2) | ///
(HHID2020=="uuid:441687fe-0f39-4a82-9e6c-2f5ff37c1b0f" & INDID2020==1 & loanid==5) | ///
(HHID2020=="uuid:831ac2d3-8b2f-4936-9c96-515eb3940233" & INDID2020==1 & loanid==2) | ///
(HHID2020=="uuid:e6093a44-2ab5-488d-8f96-62b6ec7cd486" & INDID2020==1 & loanid==3) | ///
(HHID2020=="uuid:bf220e69-6145-4536-9237-2912eb1dda5e" & INDID2020==1 & loanid==5) 




********** Consistency totalrepaid et loanbalance

*** Intéret théorique
g months_diff = round((submissiondate-loandate)/(365/12))
g years_diff=round((submissiondate-loandate)/365)
g weeks_diff=round((submissiondate-loandate)/(365/53))
g th_interest=.
replace th_interest=weeks_diff*interestloan if interestfreq==1
replace th_interest=months_diff*interestloan if interestfreq==2
replace th_interest=years_diff*interestloan if interestfreq==3


*** Recodage 
/*(semble souvent repondu comme interestloan) - mais on ne peut pas savoir de toute facon;..
replace interestpaid2=. if interestpaid==interestloan & th_interest!=interestpaid & th_interest!=interestpaid+interestloan & (interestfreq==1 | interestfreq==2 | interestfreq==3)
*/
* si loanbalance=loanamount - total repaid & interestpaid>0: on considère que totalrepaid est en fait principalpaid
g principalpaid2=principalpaid


*** Cohérence ?
g temp=((loanbalance2==loanamount3-totalrepaid2) & interestpaid2>0 & interestpaid2!=.)
ta temp
order temp loanbalance2 loanamount3 totalrepaid2 interestpaid2 principalpaid2
replace principalpaid2=totalrepaid2 if temp==1
replace totalrepaid2=principalpaid2+interestpaid2 if principalpaid2!=. & interestpaid2!=.
drop temp




********** Principalpaid negatif
*br HHID2020 INDID2020 loanamount loanbalance2 totalrepaid2 interestpaid2 principalpaid2 th_interest interestfrequency interestloan lender4 repayduration2 loanid  months_diff  if principalpaid2<0

*ici interestpaid2=6912 correspond à 24*interestloan (repayduration=27 mois, ca fait un taux d intéret total dans les clous). donc le principal remboursé  (30 000/27)*24=26667 => ce qui au bout de 24 mois nous donne bien loanbalance
replace principalpaid2=26667 if HHID2020=="uuid:54cafca1-f001-489b-ab93-c7752a13617a" & INDID2020==2 & loanid==1
replace totalrepaid2=principalpaid2+interestpaid2 if HHID2020=="uuid:54cafca1-f001-489b-ab93-c7752a13617a" & INDID2020==2 & loanid==1
* interespaid correspond a 22*interestloan. principal paid en 22 mois= (30 000/24)*22=27500 => coherent avec loanbalance
replace principalpaid2=27500 if HHID2020=="uuid:54cafca1-f001-489b-ab93-c7752a13617a" & INDID2020==2 & loanid==2
replace totalrepaid2=principalpaid2+interestpaid2 if HHID2020=="uuid:54cafca1-f001-489b-ab93-c7752a13617a" & INDID2020==2 & loanid==2
*pb de 0
replace totalrepaid2=totalrepaid*10 if HHID2020=="uuid:b311d822-6486-4be6-8134-de502f98c6f7" & INDID2020==1 & loanid==3
replace principalpaid2=totalrepaid2 - interestpaid2 if HHID2020=="uuid:b311d822-6486-4be6-8134-de502f98c6f7" & INDID2020==1  & loanid==3
*interestloan represente très probablement le montant total payé chaque mois (principal + interet). interestpaid est coherent avec 22 mois de paiement (ie 567 INR par mois d interetà. donc principalpaid=(2650-567)*22=45826 => cohérent avec loanbalance
replace interestloan=567 if HHID2020=="uuid:333ee73e-3c9b-460f-954a-497f2c0bade4" &	INDID2020==3 & loanid==2
replace principalpaid2=45826 if HHID2020=="uuid:333ee73e-3c9b-460f-954a-497f2c0bade4" &	INDID2020==3 & loanid==2
replace totalrepaid2=principalpaid2+interestpaid2 if HHID2020=="uuid:333ee73e-3c9b-460f-954a-497f2c0bade4" & INDID2020==3 & loanid==2
* des idées pour les autres ?




********** Balance, amount et principal
g test=loanbalance2-(loanamount3-principalpaid2)
ta loansettled if test!=0 & test!=., mis //tous unsetteld
ta dummyinterest if test!=0 & test!=., mis //tous à interet
ta test

gen test2=.
replace test2=1 if test>0 & test!=.
replace test2=-1 if test<0 & test!=.
ta test2
/** si loanbalance > loanamount - principalpaid:  (en gros 10% des prêts): ils surestiment ce qu'ils restent à payer ? ils sous estiment ce qu'ils ont déjà payé ?
=> si priorité à principalpaid (ie on ajuste loanbalance à la baisse): risque de surestimer service de la dette (principalpaid > loanamount - loanbalance) et sous estimer dette
=> si priorité à loanbalance: risque de surestimer la dette et sous estimer service
 ** si loanbalance < loanamount - principalpaid (en gros 5%): l'inverse

DONC on peut éventuellement considérer qu estimer le service de la dette est de toute facon foireux avec ce type de données et privilégier le volume de dette, donc faire les choix qui empechent surestimation de la dette:
=> priorité à loanbalance si loanbalance < loanamount - principalpaid 
=> priorité à principalpaid si  loanbalance > loanamount - principalpaid 
*/




********** Correction 
/*
Suite à la discussion du 17/1/22, on décide de garder l'approche par balance
However, if loanamount=loanbalance, we use principalpaid
*/
order test test2 loanbalance2 loanamount3 principalpaid2 interestpaid2 totalrepaid2

*** var to create
clonevar principalpaid3=principalpaid2
clonevar loanbalance3=loanbalance2
clonevar totalrepaid3=totalrepaid2


*** if test>0: 189 loans
replace principalpaid3=loanamount3-loanbalance2 if test2==1 & loanamount3!=loanbalance2
*70/189=119 loans?
ta loanamount3 if test2==1 & loanamount3==loanbalance2
*ok

*** if test<0: 104 loans
replace principalpaid3=loanamount3-loanbalance2 if test2==-1 & loanamount3!=loanbalance2
*102/104=2 loans
ta loanamount3 if test2==-1 & loanamount3==loanbalance2
*ok

*** if loanamount=loanbalance with principal positive, priority to principalpaid
*119 loans
list loanamount3 loanbalance2 totalrepaid2 principalpaid3 interestpaid2 loansettled if test2==1 & loanamount3==loanbalance2, clean noobs
*If principal<loanamount
replace loanbalance3=loanamount3-principalpaid3 if test2==1 & loanamount3==loanbalance2 & principalpaid3<loanamount3
*44 changes --> 75
list loanamount3 loanbalance3 totalrepaid2 principalpaid3 interestpaid2 if test2==1 & loanamount3==loanbalance2, clean noobs

* If principal>loanamount
list loanamount3 loanbalance3 totalrepaid2 principalpaid3 interestpaid2 if test2==1 & loanamount3==loanbalance2 & principalpaid3>loanamount3, noobs
list loanamount loanbalance totalrepaid principalpaid interestpaid if test2==1 & loanamount3==loanbalance2 & principalpaid3>loanamount3, noobs
gen pb2=0
replace pb2=1 if test2==1 & loanamount3==loanbalance2 & principalpaid3>=loanamount3


*** if loanamount=loanbalance with principal negative, principal=0 & total=interest
*2 loans
list loanamount3 loanbalance2 totalrepaid2 principalpaid3 interestpaid2 if test2==-1 & loanamount3==loanbalance2, clean noobs
replace totalrepaid3=interestpaid2 if test2==-1 & loanamount3==loanbalance2
replace principalpaid3=0 if test2==-1 & loanamount3==loanbalance2
list loanamount3 loanbalance2 totalrepaid3 principalpaid3 interestpaid2 if test2==-1 & loanamount3==loanbalance2, clean noobs




********** Recodage manuel Elena
/*** ci dessous j ai commencé à recoder à la main quelques cas pour lesquels loanbalance < loanamount - principalpaid 
 mais j'ai abandonné car beaucoup trop fastidieux et surtout, il se trouve que quand c est possible de retrouver les bons montants en croisant les infos, ca revient à faire le choix mentionné ci dessus 
 */
*sort HHID2020 INDID2020
*br HHID2020 INDID2020 loanamount loanbalance2 totalrepaid2 interestpaid2 principalpaid2 test th_interest interestfrequency interestloan lender4 repayduration1 repayduration2 loanid  months_diff lendername if test<-1000

/*40 000/24=1667 => loanbalance serait coherent avec 10 mois de principal à payer, donc 14 déjà payés (ok vu que le pret a été contracté il y a 15 mois). donc interestpaid serait 183*14=2562 et principalpaid=230338
mais totalrepaid serait coherent avec 10 mois remboursés (1667+183)*10
donc on y va a la hache et on considere que loanbalance est en fait principalpaid
*/
replace principalpaid3=loanbalance3 if HHID2020=="uuid:cfd551f7-fe2b-4ea3-99cd-4a0f10ba8a59" &	INDID2020==2 & loanid==5
replace interestpaid2=totalrepaid3-principalpaid3 if HHID2020=="uuid:cfd551f7-fe2b-4ea3-99cd-4a0f10ba8a59" & INDID2020==2 & loanid==5
replace loanbalance3=loanamount3-principalpaid3 if HHID2020=="uuid:cfd551f7-fe2b-4ea3-99cd-4a0f10ba8a59" & INDID2020==2 & loanid==5

*censé rembourser 2600/mois ((50 000 + 24*516)/24 ), coherent avec 2 mois de remboursement: 4168 est le principal remboursé en 2 mois
replace loanbalance3=loanamount3-loanbalance3 if HHID2020=="uuid:cfd551f7-fe2b-4ea3-99cd-4a0f10ba8a59" & INDID2020==2 & loanid==2

* loanbalance coherent avec 4 mois restant à payer ( 35 000/24)* 4= 5833. donc a déjà payé 20 mois (ok loan a été contracté il y a 23 mois). donc porincipalpaid en 20 mois=29 167. et interet 20 mois en theorie=2840 => ce qui est ok avec interestpaid
replace principalpaid3=29167 if HHID2020=="uuid:c6238723-5f23-40e2-aef5-26b21fd13d53" &	INDID2020==2 & loanid==3
replace totalrepaid3=principalpaid3+interestpaid2 if HHID2020=="uuid:c6238723-5f23-40e2-aef5-26b21fd13d53" &	INDID2020==2 & loanid==3

*interestpaid=24*interestloan. donc si loanbalance est ok, signifie qu a payé 10 278 par mois * 24 en principal. ferait un pret de 36 mois. pas absurde.
replace principalpaid3=10278*24 if HHID2020=="uuid:e5d9e97a-f3b9-49e1-9cde-1ad11dc43009" & INDID2020==2 & loanid==1
replace totalrepaid3=principalpaid3+interestpaid2 if  HHID2020=="uuid:e5d9e97a-f3b9-49e1-9cde-1ad11dc43009" & INDID2020==2 & loanid==1

*interestpaid coherent avec 11 mois payés. et loabalance avec 7 mois restant. => ok pour repayduration de 18 mois
replace principalpaid3=2222*11 if HHID2020=="uuid:3c12e85b-1eff-42e2-8f3e-2084211af237" &	INDID2020==1 & loanid==1
replace  totalrepaid3=principalpaid3+interestpaid2 if HHID2020=="uuid:3c12e85b-1eff-42e2-8f3e-2084211af237" &	INDID2020==1 & loanid==1
	
*loanbalance coherent avec 10 mois restant à payer si on considere une durée classique de 24 mois. interestpaid donnerait sur 24 mois un taux à 20%, ok. 
replace principalpaid3=1667*14 if HHID2020=="uuid:d78ff1bf-390f-4942-a783-286f51e59d90" &	INDID2020==2 & loanid==1
replace totalrepaid3=principalpaid3+interestpaid2 if HHID2020=="uuid:d78ff1bf-390f-4942-a783-286f51e59d90" &	INDID2020==2 & loanid==1

*loanbalance coherent avec 11 mois à payer si repayduration = 24. donnerait un taux de 27%, ok.
replace principalpaid3=13*1667 if HHID2020=="uuid:36242106-ac62-4b48-b1b6-9d0a1b288ab2" &	INDID2020==2 & loanid==1
replace totalrepaid3=principalpaid3+interestpaid2 if HHID2020=="uuid:36242106-ac62-4b48-b1b6-9d0a1b288ab2" &	INDID2020==2 & loanid==1
	

*loanbalance cogerent avec 2 mois restant à payer. avec interestpaid donnerait un taux d interet a 17%
replace principalpaid3=2084*22 if  HHID2020=="uuid:d98030a0-f814-4723-a35e-972e0eeb4778" & INDID2020==4 & loanid==8
replace totalrepaid3=principalpaid3+interestpaid2 if   HHID2020=="uuid:d98030a0-f814-4723-a35e-972e0eeb4778" & INDID2020==4 & loanid==8

*loanbalance cohérent avec 7 mois restant à payer. 
replace principalpaid3=1167*17 if loanid==2 & HHID2020=="uuid:a459cae1-9e19-4143-8c1f-2b537f105a4f" &	INDID2020==1
replace totalrepaid3=principalpaid3+interestpaid2 if  loanid==2 & HHID2020=="uuid:a459cae1-9e19-4143-8c1f-2b537f105a4f" &	INDID2020==1

*loanbalance coherent avec3 mois restant à payer
replace principalpaid3=1250*21 if HHID2020=="uuid:d98030a0-f814-4723-a35e-972e0eeb4778" &	INDID2020==4 & loanid==9
replace totalrepaid3=principalpaid3+interestpaid2 if HHID2020=="uuid:d98030a0-f814-4723-a35e-972e0eeb4778" &	INDID2020==4 & loanid==9




********** Ceux qui n'arrivait pas à donner une estimation des intérêts

*On fait confiance à la balance
*comme ça on voit un peu le principal et on en déduit les intérêts?
clonevar principalpaid4=principalpaid3
order principalpaid4, after(principalpaid3)
clonevar interestpaid3=interestpaid2
order interestpaid3, after(interestpaid2)

replace principalpaid4=loanamount3-loanbalance3 if interestpaid==66 | interestpaid==55
replace interestpaid3=totalrepaid3-principalpaid4 if interestpaid==66 | interestpaid==55
sort interestpaid3
*br if loansettled==0 & loan_database=="FINANCE" & dummyinterest==1 & interestpaid==66

replace interestpaid3=0 if interestpaid3<0


********** Consistency principalpaid, loanbalance, settled
*certains prets semblent furieusement etre rembourses

g pb3=(principalpaid4>=loanamount3 & principalpaid4!=. & loansettled==0)
ta pb3
/*
        pb3 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      5,724       98.62       98.62
          1 |         80        1.38      100.00
------------+-----------------------------------
      Total |      5,804      100.00
*/
*br HHID2020 INDID2020 loanamount3 loanbalance3 interestpaid3 principalpaid4 totalrepaid3 test th_interest interestfrequency interestloan lender4 repayduration2 loanid  months_diff  if pb3==1

* je propose d'attribuer le surplus de principalpaid à interestpaid2, mettre loanbalance=0, et conserver loansettled=0 pour prendre en compte le fait qu il reste surement de l interet à payer

replace interestpaid3=principalpaid4-loanamount3 if pb3==1 & principalpaid4>loanamount3
replace principalpaid4=loanamount3 if pb3==1 & principalpaid4>loanamount3
replace loanbalance3=0 if pb3==1 & principalpaid4>loanamount3
gen pb4=1 if pb3==1 & principalpaid4>loanamount3
ta pb4
*br HHID2020 INDID2020 loanamount3 loanbalance3 totalrepaid3 interestpaid3 principalpaid4 test th_interest interestfrequency interestloan lender4 repayduration2 loanid  months_diff  if pb3==1




********** On en est où donc ?
drop test test2

gen test=(totalrepaid3-interestpaid3==loanamount3-loanbalance3)
ta test
/*
       test |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      2,841       48.95       48.95
          1 |      2,963       51.05      100.00
------------+-----------------------------------
      Total |      5,804      100.00
*/

order HHID2020 INDID2020 test loansettled dummyinterest loanamount3 loanbalance3 principalpaid4 interestpaid3 totalrepaid3 lender4 loanlender loan_database
sort test dummyinterest
ta dummyinterest test, m
/*
  Is there |
        an |
  interest |
  rate for |         test
   loan #? |         0          1 |     Total
-----------+----------------------+----------
        No |     1,791        347 |     2,138 
       Yes |       218      2,601 |     2,819 
         . |       832         15 |       847 
-----------+----------------------+----------
     Total |     2,841      2,963 |     5,804 


On a 2844 loans pb
1791 sont sans intérêts, donc je pense que ca peut se corriger facilement car pb vient juste de missing:
	On peut donc tenter loanamount-loanbalance as principalpaid 
	Et donc totalrepaid=principalpaid?
218 à inspecter par contre...! 
*/


*** Ceux sans int
ta totalrepaid3 if dummyinterest==0, m
replace principalpaid4=loanamount3-loanbalance3 if dummyinterest==0 & test==0
replace totalrepaid3=principalpaid4 if dummyinterest==0 & test==0
replace interestpaid3=0 if dummyinterest==0 & test==0

* Vérification
drop test
gen test=(totalrepaid3-interestpaid3==loanamount3-loanbalance3)
ta dummyinterest test, m


*** Les autres ?
gen test2=((loanamount3-principalpaid4)==loanbalance3)
ta test test2
/*
Among les 221, il y en a 209 pour lesquels: 
amount-principal=balance.......!
donc on reste avec ça je pense
*/
drop test test2





********** kézako les 2, 3, 4, etc.
tabstat loanamount loanamount2 loanamount3, stat(n mean sd q min max)
tabstat interestpaid interestpaid2 interestpaid3, stat(n mean sd q min max)
*check interestpaid3<0
tabstat loanbalance loanbalance2 loanbalance3, stat(n mean sd q min max)
tabstat totalrepaid totalrepaid2 totalrepaid3, stat(n mean sd q min max)
tabstat principalpaid principalpaid2 principalpaid3 principalpaid4, stat(n mean sd q min max)


tabstat loanamount loanamount2 loanamount3 if loanamount!=., stat(n mean sd q min max)
/*
   stats |  loanam~t  loanam~2  loanam~3
---------+------------------------------
       N |      5802      5802      5802
    mean |  36944.37  36691.17  35166.91
      sd |  81658.75  80328.04  76635.19
     p25 |      5000      5000      4500
     p50 |     20000     20000     15000
     p75 |     40000     40000     39000
     min |         2         2         2
     max |   1700000   1700000   1700000
----------------------------------------
*/

tabstat interestpaid interestpaid2 interestpaid3 if dummyinterest==1 & interestpaid!=66, stat(n mean sd q min max)
/*
   stats |  intere~d  intere~2  intere~3
---------+------------------------------
       N |      1377      1377      1377
    mean |  9972.118  9973.314  11864.89
      sd |  20840.88  20840.36  31895.59
     p25 |      1000      1000      1000
     p50 |      3600      3600      4350
     p75 |     10000     10000     10800
     min |         0         0         0
     max |    305964    305964    720000
----------------------------------------
*/

tabstat loanbalance loanbalance2 loanbalance3 if loanbalance!=., stat(n mean sd q min max)
/*
   stats |  loanba~e  loanba~2  loanba~3
---------+------------------------------
       N |      4350      4350      4350
    mean |  26401.47  26371.86  24527.54
      sd |  60935.21  60924.99  56174.83
     p25 |      2000      2000      2000
     p50 |     10000     10000     10000
     p75 |     25080     25000     25000
     min |         0         0         0
     max |   1000000   1000000    962000
----------------------------------------
*/
tabstat totalrepaid totalrepaid2 totalrepaid3 if dummyinterest==1, stat(n mean sd q min max)
/*
   stats |  totalr~d  totalr~2  totalr~3
---------+------------------------------
       N |      2512      2473      2473
    mean |  21191.52   21951.4  22059.04
      sd |  58677.17  59089.28  59281.19
     p25 |      1000      2000      2000
     p50 |      9000     10000     10000
     p75 |     23000     24000     24000
     min |         0         0         0
     max |   1480000   1480000   1480000
----------------------------------------
*/

tabstat principalpaid principalpaid2 principalpaid3 principalpaid4 if principalpaid!=., stat(n mean sd q min max)
/*
   stats |  princi~d  princi~2  princi~3  princi~4
---------+----------------------------------------
       N |      1614      1614      1614      1614
    mean |  12116.93   12455.5  14453.55  12795.17
      sd |   62615.9  62601.81  74820.51  61318.73
     p25 |         0         0         0         0
     p50 |         0         0         0         0
     p75 |      3300      4000      5000      5000
     min |    -96564    -96564         0         0
     max |   1480000   1480000   1524596   1524596
--------------------------------------------------
*/

/*
loanamount			classique, original, l'unique
loanamount2			+ (GOLD: Elena consistency)
loanamount3			+ (GOLD: Arnaud reverse pledge et loan parfois)

interestpaid		classique, original, l'unique
interestpaid2		+ (recodage 66 as missing)
interestpaid3		+ =totalrepaid3-principalpaid4 if (interestpaid==66 | interestpaid==55) | =principalpaid4-loanamount3 if pb3==1 | ceux qui ne paient pas d'intérêts: =0 if dummyinterest==0 & test==0

loanbalance			classique, original, l'unique
loanbalance2		+ (GOLD: Arnaud correction) + (FINANCE: corr small amt)
loanbalance3		+ =loanamount3-principalpaid3 if test2==1 & loanamount3==loanbalance2 & principalpaid3<loanamount3 |0 if pb3==1

totalrepaid			classique, original, l'unique
totalrepaid2		+ (recodage 66 as missing) + (recodage manuel Elena quand principalpaid negatif)
totalrepaid3		+ =interestpaid2 if test2==-1 & loanamount3==loanbalance2 | ceux qui ne paient pas d'intérêts: =principalpaid4 if dummyinterest==0 & test==0

principalpaid		totalrepaid2-interestpaid2. If totalrepaid2=0, principalpaid=0.
principalpaid2		+ (recodage manuel Elena quand principalpaid negatif)
principalpaid3		+ =loanamount3-loanbalance2 if test2==1 & loanamount3!=loanbalance2 | =loanamount3-loanbalance2 if test2==-1 & loanamount3!=loanbalance2 | =0 if test2==-1 & loanamount3==loanbalance2
principalpaid4		+ =loanamount3-loanbalance3 if (interestpaid==66 | interestpaid==55) | =loanamount3 if pb3==1 | ceux qui ne paient pas d'intérêts: =loanamount3-loanbalance3 if dummyinterest==0 & test==0

duplicates 			
duplicatestodrop 	
months_diff 		duration loan in month
years_diff 			duration loan in year
weeks_diff 			duration loan in week
th_interest 		intérêts théoriques
pb2 				=1 if test2==1 & loanamount3==loanbalance2 & principalpaid3>=loanamount3
pb3 				=(principalpaid4>=loanamount3 & principalpaid4!=. & loansettled==0)



g test=loanbalance2-(loanamount3-principalpaid2)
ta loansettled if test!=0 & test!=., mis //tous unsetteld
ta dummyinterest if test!=0 & test!=., mis //tous à interet
ta test

gen test2=.
replace test2=1 if test>0 & test!=.
replace test2=-1 if test<0 & test!=.
ta test2
*/




********** Interestpaid3<0
drop pb4
gen pb4=0
replace pb4=1 if interestpaid3<0
order interestpaid interestpaid2, before(interestpaid3)
*br if pb4==1
/*
Pb des 66
Pour eux, pb pour totalrepaid, donc à voir: soit modifier total repaid
Soit ok pour total, mais ne pas faire le calcul total-principal=int
avec principal=amt-bal

Je les recode à 0 dans le doute, ca rpz peu de prêts donc bon.....
*/
replace interestpaid3=. if dummyinterest==0


********** Verif loanbalance loanamount
gen loantest=loanamount-loanbalance
gen loan3test=loanamount3-loanbalance3

preserve
order HHID2020 INDID2020 loanamount loanbalance loantest loanamount3 loanbalance3 loan3test loan_database
sort loan3test
restore

replace loanbalance3=loanamount3 if loanamount3<loanbalance3 & loan_database=="GOLD"
drop if loanamount3==66

drop loantest loan3test


save"_temp\NEEMSIS2-loans_v10.dta", replace
****************************************
* END













****************************************
* ANNUALIZED
****************************************
use"_temp\NEEMSIS2-loans_v10.dta", clear

*****
*Arnaud test yrate
gen yratepaid=interestpaid3*100/loanamount2 if loanduration<=365

gen _yratepaid=interestpaid3*365/loanduration if loanduration>365
gen _loanamount=loanamount3*365/loanduration if loanduration>365

replace yratepaid=_yratepaid*100/_loanamount if loanduration>365
drop _loanamount _yratepaid

tab yratepaid
sort yratepaid
*tab loanamount if loanamount<1000
*drop if loanamount<1000

tabstat yratepaid if interestpaid2>0 & interestpaid3!=., by(lender4) stat(n mean p50 min max)
gen monthlyinterestrate=.
replace monthlyinterestrate=yratepaid if loanduration<=30.4167
replace monthlyinterestrate=(yratepaid/loanduration)*30.4167 if loanduration>30.4167

*****
/*
ALL LOANS

     lender4 |         N      mean       p50       min       max
-------------+--------------------------------------------------
         WKP |       320  35.98926        30         0       600
   Relatives |        87  19.28939        10         0       144
      Labour |       103  21.22654        17         0       108
 Pawn broker |        40  9.101075         0         0       100
Moneylenders |         7  36.95906        36  .9212121  75.42857
     Friends |       676  20.51796        10         0       950
 Microcredit |       798  21.99785        20         0  133.3333
        Bank |       371  6.822225         0         0       100
     Thandal |       125  10.81567        10         0        65
-------------+--------------------------------------------------
       Total |      2527  20.30521  13.33333         0       950
----------------------------------------------------------------
*/

save"_temp\NEEMSIS2-loans_v11.dta", replace
*************************************
* END


















****************************************
* IMPUTATION
****************************************
use"_temp\NEEMSIS2-loans_v11.dta", clear


*** Debt service pour ML
gen debt_service=.
replace debt_service=totalrepaid3 if loanduration<=365
replace debt_service=totalrepaid3*365/loanduration if loanduration>365
replace debt_service=0 if loanduration==0 & totalrepaid3==0 | loanduration==0 & totalrepaid3==.


*** Interest service pour ML
gen interest_service=.
replace interest_service=interestpaid3 if loanduration<=365
replace interest_service=interestpaid3*365/loanduration if loanduration>365
replace interest_service=0 if loanduration==0 & totalrepaid3==0 | loanduration==0 & totalrepaid3==.
replace interest_service=0 if dummyinterest==0 & interestpaid3==0 | dummyinterest==0 & interestpaid3==.



*** Imputation du principal
gen imp_principal=.
replace imp_principal=loanamount3-loanbalance3 if loanduration<=365 & debt_service==.
replace imp_principal=(loanamount3-loanbalance3)*365/loanduration if loanduration>365 & debt_service==.



*** Imputation interest for moneylenders (.17) and microcredit (.19)
gen imp1_interest=.
*Moneylender
replace imp1_interest=0.37*loanamount if lender4==6 & loanduration<=365 & debt_service==.
replace imp1_interest=0.37*loanamount*365/loanduration if lender4==6 & loanduration>365 & debt_service==.
*Microcredit
replace imp1_interest=0.22*loanamount if lender4==8 & loanduration<=365 & debt_service==.
replace imp1_interest=0.22*loanamount*365/loanduration if lender4==8 & loanduration>365 & debt_service==.

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


save"_temp\NEEMSIS2-loans_v12.dta", replace
*************************************
* END














****************************************
* Other measure
****************************************
use"_temp\NEEMSIS2-loans_v12.dta", clear








save"_temp\NEEMSIS2-loans_v13.dta", replace
*************************************
* END

