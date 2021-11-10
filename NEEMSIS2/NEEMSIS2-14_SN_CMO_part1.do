cls
/*
-------------------------
Cécile Mouchel
November 08, 2021
-----
TITLE: CLEANING SN, part 1
-------------------------
*/




****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directorybis = "D:\Docuements\_Thesis\_DATA\NEEMSIS2\DATA"
global git = "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

*global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*global directorybis = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA"
*global git ="C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"


cd"$directory"
clear all
****************************************
* END









****************************************
* 1. LOANS
****************************************
use "$directory\CLEAN\NEEMSIS_APPEND-detailsloanbyborrower.dta"
destring *, replace
* PB avec la snlist - 132 alters concernés
lab def loanlender 15"Thandal", add
gen potential_alter=.
replace potential_alter=1 if loanlender<=9|loanlender==15
replace potential_alter=0 if loanlender>10&loanlender<=14
keep if potential_alter==1
gen INDID = regexs(0) if(regexm(key2 , "[0-9]"))
gen INDID_v2 = regexs(0) if(regexm(key2 , "[0-9][0-9]"))
replace INDID=INDID_v2 if INDID_v2!=""
destring INDID, replace
gen alterid_v1=regexs(0) if(regexm(key3 , "[0-9]"))
gen alterid_v2=regexs(0) if(regexm(key3 , "[0-9][0-9]"))
destring alterid_v1, replace
destring alterid_v2, replace
replace alterid_v1=alterid_v2 if alterid_v2!=.
gen snlist=.
replace snlist=1 if INDID==1&alterid_v1==1
replace snlist=2 if INDID==1&alterid_v1==2
replace snlist=3 if INDID==1&alterid_v1==3
replace snlist=4 if INDID==1&alterid_v1==4
replace snlist=5 if INDID==1&alterid_v1==5
replace snlist=6 if INDID==1&alterid_v1==6
replace snlist=7 if INDID==1&alterid_v1==7
replace snlist=8 if INDID==1&alterid_v1==8
replace snlist=9 if INDID==2&alterid_v1==1
replace snlist=10 if INDID==2&alterid_v1==2
replace snlist=11 if INDID==2&alterid_v1==3
replace snlist=12 if INDID==2&alterid_v1==4
replace snlist=13 if INDID==2&alterid_v1==5
replace snlist=14 if INDID==2&alterid_v1==6
replace snlist=15 if INDID==2&alterid_v1==7
replace snlist=16 if INDID==2&alterid_v1==8
replace snlist=17 if INDID==3&alterid_v1==1
replace snlist=18 if INDID==3&alterid_v1==2
replace snlist=19 if INDID==3&alterid_v1==3
replace snlist=20 if INDID==3&alterid_v1==4
replace snlist=21 if INDID==3&alterid_v1==5
replace snlist=22 if INDID==3&alterid_v1==6
replace snlist=23 if INDID==3&alterid_v1==7
replace snlist=24 if INDID==3&alterid_v1==8
replace snlist=25 if INDID==4&alterid_v1==1
replace snlist=26 if INDID==4&alterid_v1==2
replace snlist=27 if INDID==4&alterid_v1==3
replace snlist=28 if INDID==4&alterid_v1==4
replace snlist=29 if INDID==4&alterid_v1==5
replace snlist=30 if INDID==4&alterid_v1==6
replace snlist=31 if INDID==4&alterid_v1==7
replace snlist=32 if INDID==4&alterid_v1==8
replace snlist=33 if INDID==5&alterid_v1==1
replace snlist=34 if INDID==5&alterid_v1==2
replace snlist=35 if INDID==5&alterid_v1==3
replace snlist=36 if INDID==5&alterid_v1==4
replace snlist=37 if INDID==5&alterid_v1==5
replace snlist=38 if INDID==5&alterid_v1==6
replace snlist=39 if INDID==5&alterid_v1==7
replace snlist=40 if INDID==5&alterid_v1==8
replace snlist=41 if INDID==6&alterid_v1==1
replace snlist=42 if INDID==6&alterid_v1==2
replace snlist=43 if INDID==6&alterid_v1==3
replace snlist=44 if INDID==6&alterid_v1==4
replace snlist=45 if INDID==6&alterid_v1==5
replace snlist=46 if INDID==6&alterid_v1==6
replace snlist=47 if INDID==6&alterid_v1==7
replace snlist=48 if INDID==6&alterid_v1==8
replace snlist=49 if INDID==7&alterid_v1==1
replace snlist=50 if INDID==7&alterid_v1==2
replace snlist=51 if INDID==7&alterid_v1==3
replace snlist=52 if INDID==7&alterid_v1==4
replace snlist=53 if INDID==7&alterid_v1==5
replace snlist=54 if INDID==7&alterid_v1==6
replace snlist=55 if INDID==7&alterid_v1==7
replace snlist=56 if INDID==7&alterid_v1==8
replace snlist=57 if INDID==15&alterid_v1==1
replace snlist=58 if INDID==15&alterid_v1==2
replace snlist=59 if INDID==15&alterid_v1==3
replace snlist=60 if INDID==15&alterid_v1==4
replace snlist=61 if INDID==15&alterid_v1==5
replace snlist=62 if INDID==15&alterid_v1==6
replace snlist=63 if INDID==15&alterid_v1==7
replace snlist=64 if INDID==15&alterid_v1==8
replace snlist=65 if INDID==16&alterid_v1==1
replace snlist=66 if INDID==16&alterid_v1==2
replace snlist=67 if INDID==16&alterid_v1==3
replace snlist=68 if INDID==16&alterid_v1==4
replace snlist=69 if INDID==16&alterid_v1==5
replace snlist=70 if INDID==16&alterid_v1==6
replace snlist=71 if INDID==16&alterid_v1==7
replace snlist=72 if INDID==16&alterid_v1==8
replace snlist=73 if INDID==17&alterid_v1==1
replace snlist=74 if INDID==17&alterid_v1==2
replace snlist=75 if INDID==17&alterid_v1==3
replace snlist=76 if INDID==17&alterid_v1==4
replace snlist=77 if INDID==17&alterid_v1==5
replace snlist=78 if INDID==17&alterid_v1==6
replace snlist=79 if INDID==17&alterid_v1==7
replace snlist=80 if INDID==17&alterid_v1==8
rename INDID INDID_total
rename snmoneylender* *
gen n1=_n
gen letter="A"
tostring n1, replace
egen ALTERID=concat (letter n1)
save "$directory\CLEAN\base_alter_A.dta", replace

* BASE A UTILISER UNIQUEMENT POUR LES MERGING
drop if snlist==.
save "$directory\CLEAN\base_alter_A_singlesnlist.dta", replace
clear
* FIN

* Récupération du egoid pour les Egos
use "$directory\CLEAN\base_alter_A.dta"
destring *, replace
merge m:m parent_key INDID_total using "$directory\CLEAN\base_indexage.dta", keep (3)
drop _merge
rename lendername namealter
keep parent_key INDID_total INDID_v2 egoid loanid loanlender namealter dummyfam friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
save "$directory\CLEAN\base_alter_A_append.dta", replace
clear
****************************************
* END











****************************************
* 2. LOANS FOR MARRIAGE
****************************************
use "$directory\CLEAN\NEEMSIS_APPEND-marriagefinance.dta"
tab marriageloanlistsn
* Aucun nouvel alter sur les précédentes bases, que d'anciens alters ont été cités. 
* @Arnaud : Si il y a des nouveaux Alters dis moi, et je vais rédiger le dofile correspondant.
****************************************
* END













****************************************
* 3. BUSINESS LOANS
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta" 
destring *, replace
keep if mainoccuptype==2
tab businesssourceinvest
split businesssourceinvest
foreach var of varlist businesssourceinvest1-businesssourceinvest4{
destring `var', replace
}
*
gen rel_loan=1 if businesssourceinvest1==1|businesssourceinvest2==1|businesssourceinvest3==1|businesssourceinvest4==1
replace rel_loan=0 if rel_loan==.
gen bank_loan=1 if businesssourceinvest1==2|businesssourceinvest2==2|businesssourceinvest3==2|businesssourceinvest4==2
replace bank_loan=0 if bank_loan==.
gen inf_loan=1 if businesssourceinvest1==3|businesssourceinvest2==3|businesssourceinvest3==3|businesssourceinvest4==3
replace inf_loan=0 if inf_loan==.
gen businessloan=1 if businesssourceinvest1==1|businesssourceinvest2==1|businesssourceinvest3==1|businesssourceinvest4==1|businesssourceinvest1==2|businesssourceinvest2==2|businesssourceinvest3==2|businesssourceinvest4==2|businesssourceinvest1==3|businesssourceinvest2==3|businesssourceinvest3==3|businesssourceinvest4==3
replace businessloan=0 if businessloan==.
clear

use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemploymentsourceinvestment-businessloandetails_v2.dta"
destring *, replace
keep if namebusinesslender!=""
gen alterid_v1=businessloanid
destring alterid_v1, replace
gen snlist=.
replace snlist=211 if alterid_v1==1&egoid==1
replace snlist=212 if alterid_v1==2&egoid==1
replace snlist=213 if alterid_v1==3&egoid==1
replace snlist=214 if alterid_v1==4&egoid==1
replace snlist=215 if alterid_v1==5&egoid==1
replace snlist=211 if alterid_v1==1&egoid==2
replace snlist=212 if alterid_v1==2&egoid==2
replace snlist=213 if alterid_v1==3&egoid==2
replace snlist=214 if alterid_v1==4&egoid==2
replace snlist=211 if alterid_v1==1&egoid==3
replace snlist=212 if alterid_v1==2&egoid==3
replace snlist=213 if alterid_v1==3&egoid==3
replace snlist=214 if alterid_v1==4&egoid==3
rename castebusinesslender castes
rename othercastebusinesslender castesother
rename occupbusinesslender occup
rename otheroccupbusinesslender occupother
rename sexbusinesslender sex
rename agebusinesslender age
rename educbusinesslender educ
rename livingbusinesslender living
rename comparedbusinesslender compared
rename durationbusinesslender duration
rename meetbusinesslender meet
rename meetfrequemcybusinesslender meetfrequency
rename othermeetbusinesslender meetother
rename invitebusinesslender invite
rename reciprocity1businesslender reciprocity1
rename intimacybusinesslender intimacy
gen n1=_n
gen letter="C"
tostring n1, replace
egen ALTERID=concat (letter n1)
save "$directory\CLEAN\base_alter_C.dta",replace
rename namebusinesslender namealter
keep parent_key egoid businessloanid businesslender namealter sex age castes castesother educ occup occupother living compared duration meet meetfrequency invite reciprocity1 intimacy  meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother, replace
save "$directory\CLEAN\base_alter_C_append.dta",replace
clear
****************************************
* END













****************************************
* 4. HELP TO RECRUIT WORKER
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab snrecruitworker
destring snrecruitworkernamelist, replace
tab snrecruitworkernamelist
clear
use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemploymentinformalsocialcapitalselfemp-snrecruitworkergroup_v2.dta"
destring *, replace
gen position=ustrpos(key,"[")
generate test2 = usubstr(key,position,.)
gen alterid_v1 = regexs(0) if(regexm(test2 , "[0-9]"))
destring alterid_v1, replace
gen snlist=.
replace snlist=110 if alterid_v1==1&egoid==1
replace snlist=111 if alterid_v1==2&egoid==1
replace snlist=112 if alterid_v1==3&egoid==1
replace snlist=113 if alterid_v1==4&egoid==1
replace snlist=114 if alterid_v1==5&egoid==1
replace snlist=110 if alterid_v1==1&egoid==2
replace snlist=111 if alterid_v1==2&egoid==2
replace snlist=112 if alterid_v1==3&egoid==2
replace snlist=113 if alterid_v1==4&egoid==2
replace snlist=114 if alterid_v1==5&egoid==2
replace snlist=110 if alterid_v1==1&egoid==3
replace snlist=111 if alterid_v1==2&egoid==3
replace snlist=112 if alterid_v1==3&egoid==3
replace snlist=113 if alterid_v1==4&egoid==3
replace snlist=114 if alterid_v1==5&egoid==3
rename snrecruitworker* *
gen n1=_n
gen letter="D"
tostring n1, replace
egen ALTERID=concat (letter n1)
save "$directory\CLEAN\base_alter_D.dta", replace
rename namefromearlier namealter
keep parent_key egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
save "$directory\CLEAN\base_alter_D_append.dta", replace
clear
****************************************
* END













****************************************
* 5. HELP TO JOIN ASSOCIATION
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab associationlist
replace associationlist="" if associationlist=="13"|associationlist=="2 13"
split associationlist
foreach var of varlist associationlist1 associationlist2{
destring `var', replace
}
*
tab associationlist if egoid==1|egoid==2|egoid==3, m
clear

use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-formalsocialcapital_v2.dta" 
keep if associationname!=""
tab dummyassorecommendation
tab snrecommendasso
clear

use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-snrecommendassogroup_v2.dta"
gen position=ustrpos(parent_key,"[")
generate test = usubstr(parent_key,position,.)
gen assoid_v1 = regexs(0) if(regexm(test , "[0-9]"))
destring assoid_v1, replace
gen HHID= ustrleft(parent_key, 41)
sort HHID egoid assoid_v1
by HHID egoid assoid_v1: gen alterid_v1=_n
gen snlist=.
replace snlist=131 if assoid_v1==1&alterid_v1==1&egoid==1
replace snlist=132 if assoid_v1==1&alterid_v1==2&egoid==1
replace snlist=133 if assoid_v1==2&alterid_v1==1&egoid==1
replace snlist=134 if assoid_v1==2&alterid_v1==2&egoid==1
replace snlist=135 if assoid_v1==3&alterid_v1==1&egoid==1
replace snlist=136 if assoid_v1==3&alterid_v1==2&egoid==1
replace snlist=137 if assoid_v1==4&alterid_v1==1&egoid==1
replace snlist=138 if assoid_v1==4&alterid_v1==2&egoid==1
replace snlist=139 if assoid_v1==5&alterid_v1==1&egoid==1
replace snlist=140 if assoid_v1==5&alterid_v1==2&egoid==1
replace snlist=141 if assoid_v1==6&alterid_v1==1&egoid==1
replace snlist=142 if assoid_v1==6&alterid_v1==2&egoid==1
replace snlist=143 if assoid_v1==7&alterid_v1==1&egoid==1
replace snlist=144 if assoid_v1==7&alterid_v1==2&egoid==1
replace snlist=145 if assoid_v1==8&alterid_v1==1&egoid==1
replace snlist=146 if assoid_v1==8&alterid_v1==2&egoid==1
replace snlist=147 if assoid_v1==9&alterid_v1==1&egoid==1
replace snlist=148 if assoid_v1==9&alterid_v1==2&egoid==1
replace snlist=149 if assoid_v1==10&alterid_v1==1&egoid==1
replace snlist=150 if assoid_v1==10&alterid_v1==2&egoid==1
replace snlist=151 if assoid_v1==11&alterid_v1==1&egoid==1
replace snlist=152 if assoid_v1==11&alterid_v1==2&egoid==1
replace snlist=153 if assoid_v1==12&alterid_v1==1&egoid==1
replace snlist=154 if assoid_v1==12&alterid_v1==2&egoid==1

replace snlist=131 if assoid_v1==1&alterid_v1==1&egoid==2
replace snlist=132 if assoid_v1==1&alterid_v1==2&egoid==2
replace snlist=133 if assoid_v1==2&alterid_v1==1&egoid==2
replace snlist=134 if assoid_v1==2&alterid_v1==2&egoid==2
replace snlist=135 if assoid_v1==3&alterid_v1==1&egoid==2
replace snlist=136 if assoid_v1==3&alterid_v1==2&egoid==2
replace snlist=137 if assoid_v1==4&alterid_v1==1&egoid==2
replace snlist=138 if assoid_v1==4&alterid_v1==2&egoid==2
replace snlist=139 if assoid_v1==5&alterid_v1==1&egoid==2
replace snlist=140 if assoid_v1==5&alterid_v1==2&egoid==2
replace snlist=141 if assoid_v1==6&alterid_v1==1&egoid==2
replace snlist=142 if assoid_v1==6&alterid_v1==2&egoid==2
replace snlist=143 if assoid_v1==7&alterid_v1==1&egoid==2
replace snlist=144 if assoid_v1==7&alterid_v1==2&egoid==2
replace snlist=145 if assoid_v1==8&alterid_v1==1&egoid==2
replace snlist=146 if assoid_v1==8&alterid_v1==2&egoid==2
replace snlist=147 if assoid_v1==9&alterid_v1==1&egoid==2
replace snlist=148 if assoid_v1==9&alterid_v1==2&egoid==2
replace snlist=149 if assoid_v1==10&alterid_v1==1&egoid==2
replace snlist=150 if assoid_v1==10&alterid_v1==2&egoid==2
replace snlist=151 if assoid_v1==11&alterid_v1==1&egoid==2
replace snlist=152 if assoid_v1==11&alterid_v1==2&egoid==2
replace snlist=153 if assoid_v1==12&alterid_v1==1&egoid==2
replace snlist=154 if assoid_v1==12&alterid_v1==2&egoid==2

replace snlist=131 if assoid_v1==1&alterid_v1==1&egoid==3
replace snlist=132 if assoid_v1==1&alterid_v1==2&egoid==3
replace snlist=133 if assoid_v1==2&alterid_v1==1&egoid==3
replace snlist=134 if assoid_v1==2&alterid_v1==2&egoid==3
replace snlist=135 if assoid_v1==3&alterid_v1==1&egoid==3
replace snlist=136 if assoid_v1==3&alterid_v1==2&egoid==3
replace snlist=137 if assoid_v1==4&alterid_v1==1&egoid==3
replace snlist=138 if assoid_v1==4&alterid_v1==2&egoid==3
replace snlist=139 if assoid_v1==5&alterid_v1==1&egoid==3
replace snlist=140 if assoid_v1==5&alterid_v1==2&egoid==3
replace snlist=141 if assoid_v1==6&alterid_v1==1&egoid==3
replace snlist=142 if assoid_v1==6&alterid_v1==2&egoid==3
replace snlist=143 if assoid_v1==7&alterid_v1==1&egoid==3
replace snlist=144 if assoid_v1==7&alterid_v1==2&egoid==3
replace snlist=145 if assoid_v1==8&alterid_v1==1&egoid==3
replace snlist=146 if assoid_v1==8&alterid_v1==2&egoid==3
replace snlist=147 if assoid_v1==9&alterid_v1==1&egoid==3
replace snlist=148 if assoid_v1==9&alterid_v1==2&egoid==3
replace snlist=149 if assoid_v1==10&alterid_v1==1&egoid==3
replace snlist=150 if assoid_v1==10&alterid_v1==2&egoid==3
replace snlist=151 if assoid_v1==11&alterid_v1==1&egoid==3
replace snlist=152 if assoid_v1==11&alterid_v1==2&egoid==3
replace snlist=153 if assoid_v1==12&alterid_v1==1&egoid==3
replace snlist=154 if assoid_v1==12&alterid_v1==2&egoid==3

rename snrecommendasso* *
gen n1=_n
gen letter="E"
tostring n1, replace
egen ALTERID=concat (letter n1)
save "$directory\CLEAN\base_alter_E.dta", replace
drop parent_key
rename HHID parent_key
rename snrecommandassohhmember hhmember
rename namefromearlier namealter
keep parent_key assoid_v1 egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
save "$directory\CLEAN\base_alter_E_append.dta", replace
clear
****************************************
* END













****************************************
* 6. CURRENT MAIN OCCUPATION
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab snfindcurrentjob
tab snfindcurrentjobnamelist
clear

use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindcurrentjobgroup_v2.dta" 
destring *, replace
egen HHINDID=concat (parent_key egoid)
gen position=ustrpos(key,"[")
generate test = usubstr(key,position,.)
gen alterid_v1 = regexs(0) if(regexm(test , "[0-9]"))
destring alterid_v1, replace
gen snlist=.
replace snlist=155 if alterid_v1==1&egoid==1
replace snlist=156 if alterid_v1==2&egoid==1
replace snlist=157 if alterid_v1==3&egoid==1
replace snlist=158 if alterid_v1==4&egoid==1
replace snlist=159 if alterid_v1==5&egoid==1
replace snlist=155 if alterid_v1==1&egoid==2
replace snlist=156 if alterid_v1==2&egoid==2
replace snlist=157 if alterid_v1==3&egoid==2
replace snlist=158 if alterid_v1==4&egoid==2
replace snlist=159 if alterid_v1==5&egoid==2
replace snlist=155 if alterid_v1==1&egoid==3
replace snlist=156 if alterid_v1==2&egoid==3
replace snlist=157 if alterid_v1==3&egoid==3
replace snlist=158 if alterid_v1==4&egoid==3
replace snlist=159 if alterid_v1==5&egoid==3

rename snfindcurrentjob* *
gen n1=_n
gen letter="F"
tostring n1, replace
egen ALTERID=concat (letter n1)
save "$directory\CLEAN\base_alter_F.dta", replace
rename namefromearlier namealter
replace namealter= namefromearlie if namefromearlie!=""
keep parent_key egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
save "$directory\CLEAN\base_alter_F_append.dta", replace
clear
****************************************
* END













****************************************
* 7. HELP TO FIND JOB IN THE FUTURE
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab snfindjob
tab snfindjobnamelist
clear

use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindjobgroup_v2.dta"
destring *, replace
gen position=ustrpos(key,"[")
generate test = usubstr(key,position,.)
gen alterid_v1 = regexs(0) if(regexm(test , "[0-9]"))
destring alterid_v1, replace
gen snlist=.
replace snlist=162 if alterid_v1==1&egoid==1
replace snlist=163 if alterid_v1==2&egoid==1
replace snlist=164 if alterid_v1==3&egoid==1
replace snlist=165 if alterid_v1==4&egoid==1
replace snlist=166 if alterid_v1==5&egoid==1
replace snlist=162 if alterid_v1==1&egoid==2
replace snlist=163 if alterid_v1==2&egoid==2
replace snlist=164 if alterid_v1==3&egoid==2
replace snlist=165 if alterid_v1==4&egoid==2
replace snlist=166 if alterid_v1==5&egoid==2
replace snlist=162 if alterid_v1==1&egoid==3
replace snlist=163 if alterid_v1==2&egoid==3
replace snlist=164 if alterid_v1==3&egoid==3
replace snlist=165 if alterid_v1==4&egoid==3
replace snlist=166 if alterid_v1==5&egoid==3

rename snfindjob* *
gen n1=_n
gen letter="G"
tostring n1, replace
egen ALTERID=concat (letter n1)
save "$directory\CLEAN\base_alter_G.dta", replace
rename namefromearlier namealter
keep parent_key egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
save "$directory\CLEAN\base_alter_G_append.dta", replace
clear
****************************************
* END













****************************************
* 8. RECOMMEND FOR A JOB
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab snrecommendforjob
tab snrecommendforjobnamelist
clear

use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecommendforjobgroup_v2.dta"
destring *, replace
gen position=ustrpos(key,"[")
generate test = usubstr(key,position,.)
gen alterid_v1 = regexs(0) if(regexm(test , "[0-9]"))
destring alterid_v1, replace
gen snlist=.
replace snlist=169 if alterid_v1==1&egoid==1
replace snlist=170 if alterid_v1==2&egoid==1
replace snlist=171 if alterid_v1==3&egoid==1
replace snlist=172 if alterid_v1==4&egoid==1
replace snlist=173 if alterid_v1==5&egoid==1
replace snlist=169 if alterid_v1==1&egoid==2
replace snlist=170 if alterid_v1==2&egoid==2
replace snlist=171 if alterid_v1==3&egoid==2
replace snlist=172 if alterid_v1==4&egoid==2
replace snlist=173 if alterid_v1==5&egoid==2
replace snlist=169 if alterid_v1==1&egoid==3
replace snlist=170 if alterid_v1==2&egoid==3
replace snlist=171 if alterid_v1==3&egoid==3
replace snlist=172 if alterid_v1==4&egoid==3
replace snlist=173 if alterid_v1==5&egoid==3

rename snrecommendforjob* *
gen n1=_n
gen letter="H"
tostring n1, replace
egen ALTERID=concat (letter n1)
save "$directory\CLEAN\base_alter_H.dta", replace
rename namefromearli namealter
replace namealter= namefromearlier if namefromearlier!=""
keep parent_key egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
save "$directory\CLEAN\base_alter_H_append.dta", replace
clear
****************************************
* END













****************************************
* 9. RECOMMEND SUCCESS
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab snrecojobsuccess
tab snrecojobsuccessnamelist
clear

use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecojobsuccessgroup_v2.dta"
destring *, replace
gen position=ustrpos(key,"[")
generate test = usubstr(key,position,.)
gen alterid_v1 = regexs(0) if(regexm(test , "[0-9]"))
destring alterid_v1, replace
gen snlist=.
replace snlist=176 if alterid_v1==1&egoid==1
replace snlist=177 if alterid_v1==2&egoid==1
replace snlist=178 if alterid_v1==3&egoid==1
replace snlist=179 if alterid_v1==4&egoid==1
replace snlist=180 if alterid_v1==5&egoid==1
replace snlist=176 if alterid_v1==1&egoid==2
replace snlist=177 if alterid_v1==2&egoid==2
replace snlist=178 if alterid_v1==3&egoid==2
replace snlist=179 if alterid_v1==4&egoid==2
replace snlist=180 if alterid_v1==5&egoid==2
replace snlist=176 if alterid_v1==1&egoid==3
replace snlist=177 if alterid_v1==2&egoid==3
replace snlist=178 if alterid_v1==3&egoid==3
replace snlist=179 if alterid_v1==4&egoid==3
replace snlist=180 if alterid_v1==5&egoid==3

rename snrecojobsuccess* *
gen n1=_n
gen letter="I"
tostring n1, replace
egen ALTERID=concat (letter n1)
save "$directory\CLEAN\base_alter_I.dta", replace
rename namefromearlier namealter
replace namealter= namefromearlie if namefromearlie!=""
keep parent_key egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
save "$directory\CLEAN\base_alter_I_append.dta", replace
clear
****************************************
* END













****************************************
* 10. TALK THE MOST
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab sntalkthemost
clear

use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sntalkthemostgroup_v2.dta"
destring *, replace
gen position=ustrpos(key,"[")
generate test = usubstr(key,position,.)
gen alterid_v1 = regexs(0) if(regexm(test , "[0-9]"))
destring alterid_v1, replace
gen snlist=.
replace snlist=183 if alterid_v1==1&egoid==1
replace snlist=184 if alterid_v1==2&egoid==1
replace snlist=185 if alterid_v1==3&egoid==1
replace snlist=186 if alterid_v1==4&egoid==1
replace snlist=183 if alterid_v1==1&egoid==2
replace snlist=184 if alterid_v1==2&egoid==2
replace snlist=185 if alterid_v1==3&egoid==2
replace snlist=186 if alterid_v1==4&egoid==2
replace snlist=183 if alterid_v1==1&egoid==3
replace snlist=184 if alterid_v1==2&egoid==3
replace snlist=185 if alterid_v1==3&egoid==3
replace snlist=186 if alterid_v1==4&egoid==3

rename sntalkthemost* *
gen n1=_n
gen letter="J"
tostring n1, replace
egen ALTERID=concat (letter n1)
save "$directory\CLEAN\base_alter_J.dta", replace
rename namefromearlier namealter
keep parent_key egoid namealter friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
replace phonenb="0" if phonenb=="0#"
destring *, replace
tostring occupother castesother meetother livingname, replace
save "$directory\CLEAN\base_alter_J_append.dta", replace
clear
****************************************
* END













****************************************
* 11. MEDICAL EMERGENCY
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
ta snhelpemergency
clear

use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snhelpemergencygroup_v2.dta"
destring *, replace
gen position=ustrpos(key,"[")
generate test = usubstr(key,position,.)
gen alterid_v1 = regexs(0) if(regexm(test , "[0-9]"))
destring alterid_v1, replace
gen snlist=.
replace snlist=197 if alterid_v1==1&egoid==1
replace snlist=198 if alterid_v1==2&egoid==1
replace snlist=199 if alterid_v1==3&egoid==1
replace snlist=200 if alterid_v1==4&egoid==1
replace snlist=201 if alterid_v1==5&egoid==1
replace snlist=197 if alterid_v1==1&egoid==2
replace snlist=198 if alterid_v1==2&egoid==2
replace snlist=199 if alterid_v1==3&egoid==2
replace snlist=200 if alterid_v1==4&egoid==2
replace snlist=201 if alterid_v1==5&egoid==2
replace snlist=197 if alterid_v1==1&egoid==3
replace snlist=198 if alterid_v1==2&egoid==3
replace snlist=199 if alterid_v1==3&egoid==3
replace snlist=200 if alterid_v1==4&egoid==3
replace snlist=201 if alterid_v1==5&egoid==3

rename snhelpemergency* *
gen n1=_n
gen letter="K"
tostring n1, replace
egen ALTERID=concat (letter n1)
save "$directory\CLEAN\base_alter_K.dta", replace
rename namefromearlier namealter
keep parent_key egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
save "$directory\CLEAN\base_alter_K_append.dta", replace
clear
****************************************
* END













****************************************
* 12. CLOSE RELATIVE OUTSIDE HH
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab sncloserelouthh
clear

use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sncloserelouthhgroup_v2.dta"
destring *, replace
gen position=ustrpos(key,"[")
generate test = usubstr(key,position,.)
gen alterid_v1 = regexs(0) if(regexm(test , "[0-9]"))
destring alterid_v1, replace
gen snlist=.
replace snlist=204 if alterid_v1==1&egoid==1
replace snlist=205 if alterid_v1==2&egoid==1
replace snlist=206 if alterid_v1==3&egoid==1
replace snlist=207 if alterid_v1==4&egoid==1
replace snlist=204 if alterid_v1==1&egoid==2
replace snlist=205 if alterid_v1==2&egoid==2
replace snlist=206 if alterid_v1==3&egoid==2
replace snlist=207 if alterid_v1==4&egoid==2
replace snlist=204 if alterid_v1==1&egoid==3
replace snlist=205 if alterid_v1==2&egoid==3
replace snlist=206 if alterid_v1==3&egoid==3
replace snlist=207 if alterid_v1==4&egoid==3
rename sncloserelouthh* *
gen n1=_n
gen letter="L"
tostring n1, replace
egen ALTERID=concat (letter n1)
save "$directory\CLEAN\base_alter_L.dta", replace
rename namefromearlier namealter
keep parent_key egoid namealter dummyfam friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
save "$directory\CLEAN\base_alter_L_append.dta", replace
clear
****************************************
* END













****************************************
* 13. RECEIVED HELP COVID-19
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab covsnhelpreceived
tab covsnhelpreceivedlist
clear

use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-covsnhelpreceivedgroup_v2.dta"
destring *, replace
gen position=ustrpos(key,"[")
generate test = usubstr(key,position,.)
gen alterid_v1 = regexs(0) if(regexm(test , "[0-9]"))
destring alterid_v1, replace
gen snlist=.
replace snlist=103 if alterid_v1==1&egoid==1
replace snlist=104 if alterid_v1==2&egoid==1
replace snlist=105 if alterid_v1==3&egoid==1
replace snlist=106 if alterid_v1==4&egoid==1
replace snlist=107 if alterid_v1==5&egoid==1
replace snlist=103 if alterid_v1==1&egoid==2
replace snlist=104 if alterid_v1==2&egoid==2
replace snlist=105 if alterid_v1==3&egoid==2
replace snlist=106 if alterid_v1==4&egoid==2
replace snlist=107 if alterid_v1==5&egoid==2
replace snlist=103 if alterid_v1==1&egoid==3
replace snlist=104 if alterid_v1==2&egoid==3
replace snlist=105 if alterid_v1==3&egoid==3
replace snlist=106 if alterid_v1==4&egoid==3
replace snlist=107 if alterid_v1==5&egoid==3

rename covsnhelpreceived* *
gen n1=_n
gen letter="M"
tostring n1, replace
egen ALTERID=concat (letter n1)
save "$directory\CLEAN\base_alter_M.dta", replace
rename namefromearli namealter
replace labourrelation= labourrelatio if labourrelatio!=.
replace namealter= namefromearlier if namefromearlier!=""
keep parent_key egoid namealter dummyfam wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
save "$directory\CLEAN\base_alter_M_append.dta", replace
clear
****************************************
* END













****************************************
* 14. GIVEN HELP COVID-19
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear
tab covsnhelpgiven
tab covsnhelpgivenlist
clear

use "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-covsnhelpgivengroup_v2.dta"
destring *, replace
gen position=ustrpos(key,"[")
generate test = usubstr(key,position,.)
gen alterid_v1 = regexs(0) if(regexm(test , "[0-9]"))
destring alterid_v1, replace
gen snlist=.
rename covsnhelpgiven* *
gen n1=_n
gen letter="N"
tostring n1, replace
egen ALTERID=concat (letter n1)
save "$directory\CLEAN\base_alter_N.dta", replace
rename namefromearlier namealter
keep parent_key egoid namealter dummyfam wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother, replace
save "$directory\CLEAN\base_alter_N_append.dta", replace
clear
****************************************
* END













****************************************
* APPEND DATASETS
****************************************
use "$directory\CLEAN\base_alter_A_append.dta"
destring *, replace
tostring occupother castesother meetother livingname, replace
save "$directory\CLEAN\base_alter_A_append.dta", replace
append using "$directory\CLEAN\base_alter_C_append.dta"
append using "$directory\CLEAN\base_alter_D_append.dta"
append using "$directory\CLEAN\base_alter_E_append.dta"
append using "$directory\CLEAN\base_alter_F_append.dta"
append using "$directory\CLEAN\base_alter_G_append.dta"
append using "$directory\CLEAN\base_alter_H_append.dta"
append using "$directory\CLEAN\base_alter_I_append.dta"
append using "$directory\CLEAN\base_alter_J_append.dta"
append using "$directory\CLEAN\base_alter_K_append.dta"
append using "$directory\CLEAN\base_alter_L_append.dta"
append using "$directory\CLEAN\base_alter_M_append.dta"
append using "$directory\CLEAN\base_alter_N_append.dta"
save "$directory\CLEAN\base_alter_VF1", replace
order parent_key INDID_total egoid snlist ALTERID
order loanid loanlender businessloanid businesslender INDID_v2, last
order n1 letter, last
drop photo
replace snlist=0 if snlist==.
gen typesn=.
replace typesn=1 if letter=="A"
replace typesn=2 if letter=="B"
replace typesn=3 if letter=="C"
replace typesn=4 if letter=="D"
replace typesn=5 if letter=="E"
replace typesn=6 if letter=="F"
replace typesn=7 if letter=="G"
replace typesn=8 if letter=="H"
replace typesn=9 if letter=="I"
replace typesn=10 if letter=="J"
replace typesn=11 if letter=="K"
replace typesn=12 if letter=="L"
replace typesn=13 if letter=="M"
replace typesn=14 if letter=="N"
label define typesn 1"Loan" 2"Marriage loan" 3"Business loan" 4"Help recruit worker" 5"Help join association" 6"Find current job" 7"Find future job" 8"Recommend job opening" 9"Hired on recommendation" 10"Talk the most" 11"Medical emergency" 12"Close relatives" 13"Receive help during COVID" 14"Give help during COVID"
label val typesn typesn
order typesn, before( namealter) 
label variable parent_key "Household identifier Survey CTO - NEEMSIS2 "
label variable INDID_total "Individual identifier"
label variable egoid "Categorical variable for the Egos"
label variable snlist "snlist from SurveyCTO"
label variable ALTERID "Unique identifier for alters"
label variable ALTERID "Unique identifier for alter"
label variable typesn `"Type of "Social Network" questions"'
label variable namealter "Name of alter"
label variable dummyfam "Is alter a family member (blood relation)?"
label variable friend "Is alter a friend?"
label variable wkp "Is alter a therinjavanga i.e. Well Known People?"
label variable labourrelation "Do you have to deal with alter for your work?"
label variable sex "Alter's sex"
label variable age "Alter's age"
label variable labourtype "Kind of labour relation with alter"
label variable castes "Alter's caste"
label variable castesother "If 'Other caste', please specify"
label variable educ "Alter's education Level"
label variable educ "Alter's education level"
label variable occup "Alter's occupation"
label variable employertype "What kind of employer is alter's employer?"
label variable living "Where does alter live ?"
label variable ruralurban "Does alter live in a rural or urban area?"
label variable district "In which district does alter live?"
label variable livingname "Indicate exactly the place where alter lives."
label variable compared "Economic situation of alter"
label variable duration "How many years you know alter for?"
label variable meet "How did you meet alter?"
label variable meetfrequency "How often do you meet or call alter?"
label variable invite "Do you invite alter for your family events ?"
label variable reciprocity1 "Does alter invite you for family events ?"
label variable intimacy "What is the level of intimacy you have with hi"
label variable intimacy "Level of intimacy with alter."
label variable phonenb "Alter's phone number"
label variable dummyhh "Is alter part of the household?"
label variable hhmember "Who is alter in the household ?"
label variable money "Do you exchange money with alter ?"
label variable assoid_v1 "Association identifier"
label variable loanid "Loan identifier"
label variable loanlender "From whom did you get loan #${loanid}?"
label variable businessloanid "Business loan identifier"
label variable businesslender "Relationship with business lender"
label variable INDID_v2 "Individual identifier"
save "$directory\CLEAN\base_alter_VF1.dta", replace

* Base alters pour les merging uniquement
use "$directory\CLEAN\base_alter_VF1.dta"
drop if letter=="A"
drop if snlist==0
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
save "$directory\CLEAN\base_alter_VF1_singlelist.dta", replace
****************************************
* END
