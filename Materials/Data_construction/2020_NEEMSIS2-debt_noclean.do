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

*drop if rest==1


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
fre submissiondate

*** Loan duration
gen loanduration=submissiondate-loandate
fre loanduration

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

sum loanamount loanamount2 loanamount3

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
replace imp1_interest=0.37*loanamount3 if lender4==6 & loanduration<=365 & debt_service==.
replace imp1_interest=0.37*loanamount3*365/loanduration if lender4==6 & loanduration>365 & debt_service==.
*Microcredit
replace imp1_interest=0.22*loanamount3 if lender4==8 & loanduration<=365 & debt_service==.
replace imp1_interest=0.22*loanamount3*365/loanduration if lender4==8 & loanduration>365 & debt_service==.

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


********** Loanlender
fre loanlender lender4 lender_cat

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
rename loanlender_15 lender_than

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
foreach x in WKP rela empl mais coll pawn shop fina frie SHG bank coop suga grou than {
gen lenderamt_`x'=loanamount3 if lender_`x'==1
}
foreach x in WKP rela labo pawn shop mone frie micr bank neig {
gen lender4amt_`x'=loanamount3 if lender4_`x'==1
}
foreach x in info semi form {
gen lendercatamt_`x'=loanamount3 if lendercat_`x'==1
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
gen givenamt_`x'=loanamount3 if given_`x'==1
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
gen givencatamt_`x'=loanamount3 if givencat_`x'==1
}



********** Effective
fre loaneffectivereason

ta loanreasongiven, gen(effective_)

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
rename effective_12 effective_nore
rename effective_13 effective_othe

*Amt
foreach x in agri fami heal repa hous inve cere marr educ rela deat nore othe {
gen effectiveamt_`x'=loanamount3 if effective_`x'==1
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
gen prodpledge_silv=0
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
replace prodpledge_silv=1 if strpos(loanproductpledge,"15")
replace prodpledge_none=1 if strpos(loanproductpledge,"16")
replace prodpledge_othe=1 if strpos(loanproductpledge,"77")


drop jatis caste version_HH pb pb2 pb3 pb4


save"outcomes\NEEMSIS2-loans_mainloans_new.dta", replace
*************************************
* END










****************************************
* Indiv and HH level
****************************************
use"outcomes\NEEMSIS2-loans_mainloans_new.dta", clear

*
*keep if HHID2020=="uuid:17e456bc-0327-461c-9782-de911c716e4f"

fre loansettled
ta loanreasongiven if loansettled==1

ta loandate loansettled

*
drop if loansettled==1
*drop if loan_database=="MARRIAGE"



*** Indiv + HH level
bysort HHID2020 INDID2020: egen nbloans_indiv=sum(1)
bysort HHID2020: egen nbloans_HH=sum(1)

bysort HHID2020 INDID2020: egen loanamount_indiv=sum(loanamount3)
bysort HHID2020: egen loanamount_HH=sum(loanamount3)


*** Services
bysort HHID2020 INDID2020: egen imp1_ds_tot_indiv=sum(imp1_debt_service)
bysort HHID2020 INDID2020: egen imp1_is_tot_indiv=sum(imp1_interest_service)

bysort HHID2020: egen imp1_ds_tot_HH=sum(imp1_debt_service)
bysort HHID2020: egen imp1_is_tot_HH=sum(imp1_interest_service)
*order HHID2020 loan_database imp1_debt_service imp1_is_tot_HH loansettled loanamount loanbalance loanlender


*** Loan amount
rename loanamount loanamount_o
rename loanamount3 loanamount

********** Individual and HH level for dummies
foreach x in lender_WKP lender_rela lender_empl lender_mais lender_coll lender_pawn lender_shop lender_fina lender_frie lender_SHG lender_bank lender_coop lender_suga lender_grou lender_than lender4_WKP lender4_rela lender4_labo lender4_pawn lender4_shop lender4_mone lender4_frie lender4_micr lender4_bank lender4_neig lendercat_info lendercat_semi lendercat_form  given_agri given_fami given_heal given_repa given_hous given_inve given_cere given_marr given_educ given_rela given_deat given_nore given_othe givencat_econ givencat_curr givencat_huma givencat_soci givencat_hous givencat_nore givencat_othe effective_agri effective_fami effective_heal effective_repa effective_hous effective_inve effective_cere effective_marr effective_educ effective_rela effective_deat effective_nore effective_othe othlendserv_poli othlendserv_fina othlendserv_guar othlendserv_gene othlendserv_none othlendserv_othe guarantee_doc guarantee_chit guarantee_shg guarantee_pers guarantee_jewe guarantee_none guarantee_othe borrservices_free borrservices_work borrservices_supp borrservices_none borrservices_othe plantorep_chit plantorep_work plantorep_migr plantorep_asse plantorep_inco plantorep_borr plantorep_othe settlestrat_inco settlestrat_sche settlestrat_borr settlestrat_sell settlestrat_land settlestrat_cons settlestrat_addi settlestrat_work settlestrat_supp settlestrat_harv settlestrat_othe prodpledge_gold prodpledge_land prodpledge_car prodpledge_bike prodpledge_frid prodpledge_furn prodpledge_tail prodpledge_cell prodpledge_line prodpledge_dvd prodpledge_came prodpledge_gas prodpledge_comp prodpledge_dish prodpledge_silv prodpledge_none prodpledge_othe {

bysort HHID2020 INDID2020: egen nbindiv_`x'=sum(`x')
gen dumindiv_`x'=0
replace dumindiv_`x'=1 if nbindiv_`x'>0

bysort HHID2020: egen nbHH_`x'=sum(`x')
gen dumHH_`x'=0
replace dumHH_`x'=1 if nbHH_`x'>0
}

foreach x in lenderamt_WKP lenderamt_rela lenderamt_empl lenderamt_mais lenderamt_coll lenderamt_pawn lenderamt_shop lenderamt_fina lenderamt_frie lenderamt_SHG lenderamt_bank lenderamt_coop lenderamt_suga lenderamt_grou lenderamt_than lender4amt_WKP lender4amt_rela lender4amt_labo lender4amt_pawn lender4amt_shop lender4amt_mone lender4amt_frie lender4amt_micr lender4amt_bank lender4amt_neig lendercatamt_info lendercatamt_semi lendercatamt_form givenamt_agri givenamt_fami givenamt_heal givenamt_repa givenamt_hous givenamt_inve givenamt_cere givenamt_marr givenamt_educ givenamt_rela givenamt_deat givenamt_nore givenamt_othe givencatamt_econ givencatamt_curr givencatamt_huma givencatamt_soci givencatamt_hous givencatamt_nore givencatamt_othe effectiveamt_agri effectiveamt_fami effectiveamt_heal effectiveamt_repa effectiveamt_hous effectiveamt_inve effectiveamt_cere effectiveamt_marr effectiveamt_educ effectiveamt_rela effectiveamt_deat effectiveamt_nore effectiveamt_othe {

bysort HHID2020 INDID2020: egen totindiv_`x'=sum(`x')

bysort HHID2020: egen totHH_`x'=sum(`x')
}



*Indiv
preserve
duplicates drop HHID2020 INDID2020, force
keep HHID2020 INDID2020 nbloans_indiv loanamount_indiv imp1_ds_tot_indiv imp1_is_tot_indiv nbindiv_lender_WKP dumindiv_lender_WKP nbindiv_lender_rela dumindiv_lender_rela nbindiv_lender_empl dumindiv_lender_empl nbindiv_lender_mais dumindiv_lender_mais nbindiv_lender_coll dumindiv_lender_coll nbindiv_lender_pawn dumindiv_lender_pawn nbindiv_lender_shop dumindiv_lender_shop nbindiv_lender_fina dumindiv_lender_fina nbindiv_lender_frie dumindiv_lender_frie nbindiv_lender_SHG dumindiv_lender_SHG nbindiv_lender_bank dumindiv_lender_bank nbindiv_lender_coop dumindiv_lender_coop nbindiv_lender_suga dumindiv_lender_suga nbindiv_lender_grou dumindiv_lender_grou nbindiv_lender_than dumindiv_lender_than nbindiv_lender4_WKP dumindiv_lender4_WKP nbindiv_lender4_rela dumindiv_lender4_rela nbindiv_lender4_labo dumindiv_lender4_labo nbindiv_lender4_pawn dumindiv_lender4_pawn nbindiv_lender4_shop dumindiv_lender4_shop nbindiv_lender4_mone dumindiv_lender4_mone nbindiv_lender4_frie dumindiv_lender4_frie nbindiv_lender4_micr dumindiv_lender4_micr nbindiv_lender4_bank dumindiv_lender4_bank nbindiv_lender4_neig dumindiv_lender4_neig nbindiv_lendercat_info dumindiv_lendercat_info nbindiv_lendercat_semi dumindiv_lendercat_semi nbindiv_lendercat_form dumindiv_lendercat_form nbindiv_given_agri dumindiv_given_agri nbindiv_given_fami dumindiv_given_fami nbindiv_given_heal dumindiv_given_heal nbindiv_given_repa dumindiv_given_repa nbindiv_given_hous dumindiv_given_hous nbindiv_given_inve dumindiv_given_inve nbindiv_given_cere dumindiv_given_cere nbindiv_given_marr dumindiv_given_marr nbindiv_given_educ dumindiv_given_educ nbindiv_given_rela dumindiv_given_rela nbindiv_given_deat dumindiv_given_deat nbindiv_given_nore dumindiv_given_nore nbindiv_given_othe dumindiv_given_othe nbindiv_givencat_econ dumindiv_givencat_econ nbindiv_givencat_curr dumindiv_givencat_curr nbindiv_givencat_huma dumindiv_givencat_huma nbindiv_givencat_soci dumindiv_givencat_soci nbindiv_givencat_hous dumindiv_givencat_hous nbindiv_givencat_nore dumindiv_givencat_nore nbindiv_givencat_othe dumindiv_givencat_othe nbindiv_effective_agri dumindiv_effective_agri nbindiv_effective_fami dumindiv_effective_fami nbindiv_effective_heal dumindiv_effective_heal nbindiv_effective_repa dumindiv_effective_repa nbindiv_effective_hous dumindiv_effective_hous nbindiv_effective_inve dumindiv_effective_inve nbindiv_effective_cere dumindiv_effective_cere nbindiv_effective_marr dumindiv_effective_marr nbindiv_effective_educ dumindiv_effective_educ nbindiv_effective_rela dumindiv_effective_rela nbindiv_effective_deat dumindiv_effective_deat nbindiv_effective_nore dumindiv_effective_nore nbindiv_effective_othe dumindiv_effective_othe nbindiv_othlendserv_poli dumindiv_othlendserv_poli nbindiv_othlendserv_fina dumindiv_othlendserv_fina nbindiv_othlendserv_guar dumindiv_othlendserv_guar nbindiv_othlendserv_gene dumindiv_othlendserv_gene nbindiv_othlendserv_none dumindiv_othlendserv_none nbindiv_othlendserv_othe dumindiv_othlendserv_othe nbindiv_guarantee_doc dumindiv_guarantee_doc nbindiv_guarantee_chit dumindiv_guarantee_chit nbindiv_guarantee_shg dumindiv_guarantee_shg nbindiv_guarantee_pers dumindiv_guarantee_pers nbindiv_guarantee_jewe dumindiv_guarantee_jewe nbindiv_guarantee_none dumindiv_guarantee_none nbindiv_guarantee_othe dumindiv_guarantee_othe nbindiv_borrservices_free dumindiv_borrservices_free nbindiv_borrservices_work dumindiv_borrservices_work nbindiv_borrservices_supp dumindiv_borrservices_supp nbindiv_borrservices_none dumindiv_borrservices_none nbindiv_borrservices_othe dumindiv_borrservices_othe nbindiv_plantorep_chit dumindiv_plantorep_chit nbindiv_plantorep_work dumindiv_plantorep_work nbindiv_plantorep_migr dumindiv_plantorep_migr nbindiv_plantorep_asse dumindiv_plantorep_asse nbindiv_plantorep_inco dumindiv_plantorep_inco nbindiv_plantorep_borr dumindiv_plantorep_borr nbindiv_plantorep_othe dumindiv_plantorep_othe nbindiv_settlestrat_inco dumindiv_settlestrat_inco nbindiv_settlestrat_sche dumindiv_settlestrat_sche nbindiv_settlestrat_borr dumindiv_settlestrat_borr nbindiv_settlestrat_sell dumindiv_settlestrat_sell nbindiv_settlestrat_land dumindiv_settlestrat_land nbindiv_settlestrat_cons dumindiv_settlestrat_cons nbindiv_settlestrat_addi dumindiv_settlestrat_addi nbindiv_settlestrat_work dumindiv_settlestrat_work nbindiv_settlestrat_supp dumindiv_settlestrat_supp nbindiv_settlestrat_harv dumindiv_settlestrat_harv nbindiv_settlestrat_othe dumindiv_settlestrat_othe nbindiv_prodpledge_gold dumindiv_prodpledge_gold nbindiv_prodpledge_land dumindiv_prodpledge_land nbindiv_prodpledge_car dumindiv_prodpledge_car nbindiv_prodpledge_bike dumindiv_prodpledge_bike nbindiv_prodpledge_frid dumindiv_prodpledge_frid nbindiv_prodpledge_furn dumindiv_prodpledge_furn nbindiv_prodpledge_tail dumindiv_prodpledge_tail nbindiv_prodpledge_cell dumindiv_prodpledge_cell nbindiv_prodpledge_line dumindiv_prodpledge_line nbindiv_prodpledge_dvd dumindiv_prodpledge_dvd nbindiv_prodpledge_came dumindiv_prodpledge_came nbindiv_prodpledge_gas dumindiv_prodpledge_gas nbindiv_prodpledge_comp dumindiv_prodpledge_comp nbindiv_prodpledge_dish dumindiv_prodpledge_dish nbindiv_prodpledge_silv dumindiv_prodpledge_silv nbindiv_prodpledge_none dumindiv_prodpledge_none nbindiv_prodpledge_othe dumindiv_prodpledge_othe totindiv_lenderamt_WKP totindiv_lenderamt_rela totindiv_lenderamt_empl totindiv_lenderamt_mais totindiv_lenderamt_coll totindiv_lenderamt_pawn totindiv_lenderamt_shop totindiv_lenderamt_fina totindiv_lenderamt_frie totindiv_lenderamt_SHG totindiv_lenderamt_bank totindiv_lenderamt_coop totindiv_lenderamt_suga totindiv_lenderamt_grou totindiv_lenderamt_than totindiv_lender4amt_WKP totindiv_lender4amt_rela totindiv_lender4amt_labo totindiv_lender4amt_pawn totindiv_lender4amt_shop totindiv_lender4amt_mone totindiv_lender4amt_frie totindiv_lender4amt_micr totindiv_lender4amt_bank totindiv_lender4amt_neig totindiv_lendercatamt_info totindiv_lendercatamt_semi totindiv_lendercatamt_form totindiv_givenamt_agri totindiv_givenamt_fami totindiv_givenamt_heal totindiv_givenamt_repa totindiv_givenamt_hous totindiv_givenamt_inve totindiv_givenamt_cere totindiv_givenamt_marr totindiv_givenamt_educ totindiv_givenamt_rela totindiv_givenamt_deat totindiv_givenamt_nore totindiv_givenamt_othe totindiv_givencatamt_econ totindiv_givencatamt_curr totindiv_givencatamt_huma totindiv_givencatamt_soci totindiv_givencatamt_hous totindiv_givencatamt_nore totindiv_givencatamt_othe totindiv_effectiveamt_agri totindiv_effectiveamt_fami totindiv_effectiveamt_heal totindiv_effectiveamt_repa totindiv_effectiveamt_hous totindiv_effectiveamt_inve totindiv_effectiveamt_cere totindiv_effectiveamt_marr totindiv_effectiveamt_educ totindiv_effectiveamt_rela totindiv_effectiveamt_deat totindiv_effectiveamt_nore totindiv_effectiveamt_othe
save"outcomes\NEEMSIS2-loans_indiv.dta", replace
restore

*HH
preserve
duplicates drop HHID2020, force
keep HHID2020 nbloans_HH loanamount_HH imp1_ds_tot_HH imp1_is_tot_HH nbHH_lender_WKP dumHH_lender_WKP nbHH_lender_rela dumHH_lender_rela nbHH_lender_empl dumHH_lender_empl nbHH_lender_mais dumHH_lender_mais nbHH_lender_coll dumHH_lender_coll nbHH_lender_pawn dumHH_lender_pawn nbHH_lender_shop dumHH_lender_shop nbHH_lender_fina dumHH_lender_fina nbHH_lender_frie dumHH_lender_frie nbHH_lender_SHG dumHH_lender_SHG nbHH_lender_bank dumHH_lender_bank nbHH_lender_coop dumHH_lender_coop nbHH_lender_suga dumHH_lender_suga nbHH_lender_grou dumHH_lender_grou nbHH_lender_than dumHH_lender_than nbHH_lender4_WKP dumHH_lender4_WKP nbHH_lender4_rela dumHH_lender4_rela nbHH_lender4_labo dumHH_lender4_labo nbHH_lender4_pawn dumHH_lender4_pawn nbHH_lender4_shop dumHH_lender4_shop nbHH_lender4_mone dumHH_lender4_mone nbHH_lender4_frie dumHH_lender4_frie nbHH_lender4_micr dumHH_lender4_micr nbHH_lender4_bank dumHH_lender4_bank nbHH_lender4_neig dumHH_lender4_neig nbHH_lendercat_info dumHH_lendercat_info nbHH_lendercat_semi dumHH_lendercat_semi nbHH_lendercat_form dumHH_lendercat_form nbHH_given_agri dumHH_given_agri nbHH_given_fami dumHH_given_fami nbHH_given_heal dumHH_given_heal nbHH_given_repa dumHH_given_repa nbHH_given_hous dumHH_given_hous nbHH_given_inve dumHH_given_inve nbHH_given_cere dumHH_given_cere nbHH_given_marr dumHH_given_marr nbHH_given_educ dumHH_given_educ nbHH_given_rela dumHH_given_rela nbHH_given_deat dumHH_given_deat nbHH_given_nore dumHH_given_nore nbHH_given_othe dumHH_given_othe nbHH_givencat_econ dumHH_givencat_econ nbHH_givencat_curr dumHH_givencat_curr nbHH_givencat_huma dumHH_givencat_huma nbHH_givencat_soci dumHH_givencat_soci nbHH_givencat_hous dumHH_givencat_hous nbHH_givencat_nore dumHH_givencat_nore nbHH_givencat_othe dumHH_givencat_othe nbHH_effective_agri dumHH_effective_agri nbHH_effective_fami dumHH_effective_fami nbHH_effective_heal dumHH_effective_heal nbHH_effective_repa dumHH_effective_repa nbHH_effective_hous dumHH_effective_hous nbHH_effective_inve dumHH_effective_inve nbHH_effective_cere dumHH_effective_cere nbHH_effective_marr dumHH_effective_marr nbHH_effective_educ dumHH_effective_educ nbHH_effective_rela dumHH_effective_rela nbHH_effective_deat dumHH_effective_deat nbHH_effective_nore dumHH_effective_nore nbHH_effective_othe dumHH_effective_othe nbHH_othlendserv_poli dumHH_othlendserv_poli nbHH_othlendserv_fina dumHH_othlendserv_fina nbHH_othlendserv_guar dumHH_othlendserv_guar nbHH_othlendserv_gene dumHH_othlendserv_gene nbHH_othlendserv_none dumHH_othlendserv_none nbHH_othlendserv_othe dumHH_othlendserv_othe nbHH_guarantee_doc dumHH_guarantee_doc nbHH_guarantee_chit dumHH_guarantee_chit nbHH_guarantee_shg dumHH_guarantee_shg nbHH_guarantee_pers dumHH_guarantee_pers nbHH_guarantee_jewe dumHH_guarantee_jewe nbHH_guarantee_none dumHH_guarantee_none nbHH_guarantee_othe dumHH_guarantee_othe nbHH_borrservices_free dumHH_borrservices_free nbHH_borrservices_work dumHH_borrservices_work nbHH_borrservices_supp dumHH_borrservices_supp nbHH_borrservices_none dumHH_borrservices_none nbHH_borrservices_othe dumHH_borrservices_othe nbHH_plantorep_chit dumHH_plantorep_chit nbHH_plantorep_work dumHH_plantorep_work nbHH_plantorep_migr dumHH_plantorep_migr nbHH_plantorep_asse dumHH_plantorep_asse nbHH_plantorep_inco dumHH_plantorep_inco nbHH_plantorep_borr dumHH_plantorep_borr nbHH_plantorep_othe dumHH_plantorep_othe nbHH_settlestrat_inco dumHH_settlestrat_inco nbHH_settlestrat_sche dumHH_settlestrat_sche nbHH_settlestrat_borr dumHH_settlestrat_borr nbHH_settlestrat_sell dumHH_settlestrat_sell nbHH_settlestrat_land dumHH_settlestrat_land nbHH_settlestrat_cons dumHH_settlestrat_cons nbHH_settlestrat_addi dumHH_settlestrat_addi nbHH_settlestrat_work dumHH_settlestrat_work nbHH_settlestrat_supp dumHH_settlestrat_supp nbHH_settlestrat_harv dumHH_settlestrat_harv nbHH_settlestrat_othe dumHH_settlestrat_othe nbHH_prodpledge_gold dumHH_prodpledge_gold nbHH_prodpledge_land dumHH_prodpledge_land nbHH_prodpledge_car dumHH_prodpledge_car nbHH_prodpledge_bike dumHH_prodpledge_bike nbHH_prodpledge_frid dumHH_prodpledge_frid nbHH_prodpledge_furn dumHH_prodpledge_furn nbHH_prodpledge_tail dumHH_prodpledge_tail nbHH_prodpledge_cell dumHH_prodpledge_cell nbHH_prodpledge_line dumHH_prodpledge_line nbHH_prodpledge_dvd dumHH_prodpledge_dvd nbHH_prodpledge_came dumHH_prodpledge_came nbHH_prodpledge_gas dumHH_prodpledge_gas nbHH_prodpledge_comp dumHH_prodpledge_comp nbHH_prodpledge_dish dumHH_prodpledge_dish nbHH_prodpledge_silv dumHH_prodpledge_silv nbHH_prodpledge_none dumHH_prodpledge_none nbHH_prodpledge_othe dumHH_prodpledge_othe totHH_lenderamt_WKP totHH_lenderamt_rela totHH_lenderamt_empl totHH_lenderamt_mais totHH_lenderamt_coll totHH_lenderamt_pawn totHH_lenderamt_shop totHH_lenderamt_fina totHH_lenderamt_frie totHH_lenderamt_SHG totHH_lenderamt_bank totHH_lenderamt_coop totHH_lenderamt_suga totHH_lenderamt_grou totHH_lenderamt_than totHH_lender4amt_WKP totHH_lender4amt_rela totHH_lender4amt_labo totHH_lender4amt_pawn totHH_lender4amt_shop totHH_lender4amt_mone totHH_lender4amt_frie totHH_lender4amt_micr totHH_lender4amt_bank totHH_lender4amt_neig totHH_lendercatamt_info totHH_lendercatamt_semi totHH_lendercatamt_form totHH_givenamt_agri totHH_givenamt_fami totHH_givenamt_heal totHH_givenamt_repa totHH_givenamt_hous totHH_givenamt_inve totHH_givenamt_cere totHH_givenamt_marr totHH_givenamt_educ totHH_givenamt_rela totHH_givenamt_deat totHH_givenamt_nore totHH_givenamt_othe totHH_givencatamt_econ totHH_givencatamt_curr totHH_givencatamt_huma totHH_givencatamt_soci totHH_givencatamt_hous totHH_givencatamt_nore totHH_givencatamt_othe totHH_effectiveamt_agri totHH_effectiveamt_fami totHH_effectiveamt_heal totHH_effectiveamt_repa totHH_effectiveamt_hous totHH_effectiveamt_inve totHH_effectiveamt_cere totHH_effectiveamt_marr totHH_effectiveamt_educ totHH_effectiveamt_rela totHH_effectiveamt_deat totHH_effectiveamt_nore totHH_effectiveamt_othe
save"outcomes\NEEMSIS2-loans_HH.dta", replace
restore

*************************************
* END
