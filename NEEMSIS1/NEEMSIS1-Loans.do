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
drop interviewplace
order HHID2010, first
recode dummydemonetisation (.=0)
mdesc
gen loan_database="FINANCE"
rename HHID parent_key
save "NEEMSIS1-loans_v2.dta", replace
****************************************
* END
















****************************************
* GOLD
****************************************
use "NEEMSIS-HH.dta", clear
keep HHID2010 HHID INDID dummynewHH dummydemonetisation INDID2010 egoid name submissiondate goldamountpledge goldreasonpledge interviewplace caste sex age
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


rename HHID parent_key

recode dummydemonetisation (.=0)
mdesc
drop interviewplace
append using "NEEMSIS1-loans_v2.dta"
mdesc
save "NEEMSIS1-loans_v3.dta", replace
****************************************
* END

















****************************************
* MARRIAGE
****************************************
use "NEEMSIS-HH.dta", clear
keep HHID2010 HHID INDID dummynewHH dummydemonetisation INDID2010 egoid name submissiondate marriageloanamount_wellknown marriageloanamount_banks marriageloanamount_coopbanks marriageloanamount_relatives marriageloanamount_employer marriageloanamount_maistry marriageloanamount_colleagues marriageloanamount_pawnbroker marriageloanamount_monlender marriageloanamount_friends  caste sex age
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
rename HHID parent_key

append using "NEEMSIS1-loans_v3.dta"

gen year=2016


save "NEEMSIS1-loans_v4.dta", replace
****************************************
* END

















****************************************
* INDIV & HH level
****************************************
use"NEEMSIS1-loans_v4.dta", clear

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

save"NEEMSIS1-loans_v4_indiv.dta", replace


*Merge with HH base
use"NEEMSIS1-HH_v6.dta", clear

merge m:1 INDID2010 using "NEEMSIS1-loans_v4_indiv.dta"
drop _merge

*HH level
bysort HHID2010: egen totalloanamount=sum(totalloanamount_indiv)
bysort HHID2010: egen totalnumberloans=sum(totalnumberloans_indiv)
bysort HHID2010: egen totalloanbalance=sum(totalloanbalance_indiv)


save"NEEMSIS1-HH_v6_loans.dta", replace
****************************************
* END





















****************************************
* CLEANING 2
****************************************
use"NEEMSIS1-loans_v4.dta", clear
fre loansettled
drop if loansettled==1  // 440 + 18 gold

*Change date format of submissiondate
drop submissiondate
merge m:1 INDID2010 using "NEEMSIS1-HH_v6.dta", keepusing(submissiondate) keep(3) nogen
rename submissiondate submissiondate_o
gen submissiondate=dofc(submissiondate_o)
format submissiondate %td

*Loan duration
gen loanduration=submissiondate-loandate
replace loanduration=1 if loanduration<1

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

*label define loanreasongiven 1"Agriculture" 2"Family" 3"Health" 4"Repay previous loan" 5"House expenses" 6"Investment" 7"Ceremonies" 8"Marriage" 9"Education" 10"Relatives" 11"Death" 12"No reason" 77"Other"
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

*Other
egen loan_id=concat(parent_key INDID loanid), p({})
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

save"NEEMSIS1-loans_v5.dta", replace
****************************************
* END














****************************************
* NEW LENDER VAR
****************************************
use "NEEMSIS1-loans_v5.dta", clear
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

save "NEEMSIS1-loans_v6.dta", replace
****************************************
* END


















****************************************
* COHERENCE
****************************************
use"NEEMSIS1-loans_v6.dta", clear

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

save"NEEMSIS1-loans_v7.dta", replace
****************************************
* END














****************************************
* BALANCE
****************************************
use"NEEMSIS1-loans_v7.dta", clear

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
save"NEEMSIS1-loans_v8.dta", replace
*************************************
* END















****************************************
* ANNUALIZED
****************************************
use"NEEMSIS1-loans_v8.dta", clear

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
         WKP |       315  45.61875        30  1.499985       720
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
       Total |       709  34.55579        21  .0033333       720
----------------------------------------------------------------
*/

save"NEEMSIS1-loans_v9.dta", replace
*************************************
* END












****************************************
* IMPUTATION
****************************************
use"NEEMSIS1-loans_v9.dta", clear
*drop num
*rename namenumber INDID
merge m:m HHID INDID using "NEEMSIS1-HH_v6.dta", keepusing(totalincome_indiv totalincome_HH) keep(3) nogen

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
bysort parent_key INDID: egen imp1_ds_tot=sum(imp1_debt_service)
bysort parent_key INDID: egen imp1_is_tot=sum(imp1_interest_service)
bysort parent_key INDID: egen loanamount_indiv=sum(loanamount)

gen IDR=imp1_is_tot*100/loanamount_indiv
gen DSDR=imp1_ds_tot*100/loanamount_indiv
gen DSR=imp1_ds_tot*100/totalincome_indiv
gen ISR=imp1_is_tot*100/totalincome_indiv

*HH
bysort parent_key: egen imp1_ds_tot_HH=sum(imp1_debt_service)
bysort parent_key: egen imp1_is_tot_HH=sum(imp1_interest_service)
bysort parent_key: egen loanamount_HH=sum(loanamount)

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
       N |       933       933       933       822       822
    mean |  52.19721  6.461671  18.44897  114.5458  48.34778
      sd |  34.05395   9.94118  21.01118  316.6182  199.2609
     p25 |  18.64407         0         0         0         0
     p50 |  50.43478  2.390134      12.5  23.48397  5.599252
     p75 |  85.25346  10.69231  29.47097  82.22923  31.25789
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
       N |       461       461
    mean |  48.30532   21.8433
      sd |   86.0834  51.53418
     p25 |  8.356437  1.627819
     p50 |  22.18545  6.371475
     p75 |  52.98203   20.0688
     min |         0         0
     max |  1138.452  700.2764
------------------------------
*/

save"NEEMSIS1-loans_v10.dta", replace
*************************************
* END





















****************************************
* Other measure of debt
****************************************
use"NEEMSIS1-loans_v10.dta", clear

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

save"NEEMSIS1-loans_v11.dta", replace
*************************************
* END






















****************************************
* Individual level
****************************************
use"NEEMSIS1-loans_v11.dta", clear

bysort HHID INDID: gen n=_n
keep if n==1
drop n
keep HHID2010 INDID imp1_ds_tot imp1_is_tot loanamount_indiv IDR DSDR DSR ISR IDHDR InfoDR FoDR IncDR NoincDR PRdummy HSdummy ILdummy DSR_HH ISR_HH

save"NEEMSIS1-loans_v11_indiv.dta", replace

use"NEEMSIS1-HH_v6_loans.dta", clear

merge 1:1 HHID2010 INDID using "NEEMSIS1-loans_v11_indiv.dta"

save"NEEMSIS1-HH_v7.dta", replace
*************************************
* END
