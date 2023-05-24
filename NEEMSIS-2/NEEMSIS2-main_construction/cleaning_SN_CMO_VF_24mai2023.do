*************** NETTOYAGE DES DONNÉES SOCIAL NETWORKS - NEEMSIS 2 **************

/* 

************************
Date : Mardi 23 mai 2023
Auteur : Cécile Mouchel
************************

*/

cd "C:\Users\mouch\Dropbox\RUME II\2. Data\Raw\2020-NEEMSIS2\Cécile-alter"

*********
* 1.Loans
*********
use "NEEMSIS_APPEND-detailsloanbyborrower.dta" 
* PB avec la snlist - 132 alters concernés
lab def loanlender 15"Thandal", add
tab loanlender
gen potential_alter=.
replace potential_alter=1 if loanlender<=9|loanlender==15
replace potential_alter=0 if loanlender>10&loanlender<=14
tab potential_alter
keep if potential_alter==1
destring loanid, replace
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
save "base_alter_A.dta", replace

* BASE A UTILISER UNIQUEMENT POUR LES MERGING
drop if snlist==.
save "base_alter_A_singlesnlist.dta", replace
clear
* FIN

use "base_alter_A.dta"
destring *, replace
merge m:m parent_key INDID_total using "base_indexage.dta", keep (3)
drop _merge
rename lendername namealter
keep parent_key INDID_total INDID_v2 egoid loanid loanlender namealter dummyfam friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
* keep parent_key INDID INDID_v2 egoid loanid loanlender namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
save "base_alter_A_append.dta", replace
clear


**********************
* 2.Loans for marriage
**********************
use "NEEMSIS_APPEND-marriagefinance.dta"
tab marriageloanlistsn
* Aucun nouvel alter. Apparemment beaucoup d'aller-retour pour compléter le module marriage.
* Ils ont piqué des alters dans les autres catégories pour les questions SN.


******************
* 3.Business loans
******************
use "NEEMSIS2-HH_v17.dta" 
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

use "NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemploymentsourceinvestment-businessloandetails_v2.dta"
* Incohérence : Pour des Egos 1 et des Egos 3, un alter de la liste des Egos 2 est cité. Je ne vois pas comment c'est techniquement possible
* OK pas de PB avec la snlist
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
save "base_alter_C.dta",replace
rename namebusinesslender namealter
keep parent_key egoid businessloanid businesslender namealter sex age castes castesother educ occup occupother living compared duration meet meetfrequency invite reciprocity1 intimacy  meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother, replace
merge m:m parent_key egoid using "base_indexage.dta", keep (3)
save "base_alter_C_append.dta",replace
clear

***************************
* 4. Help to recruit worker
***************************
use "NEEMSIS2-HH_v17.dta", clear
tab snrecruitworker
destring snrecruitworkernamelist, replace
tab snrecruitworkernamelist
clear
use "NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemploymentinformalsocialcapitalselfemp-snrecruitworkergroup_v2.dta"
* OK pas de PB avec la snlist
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
save "base_alter_D.dta", replace
rename namefromearlier namealter
keep parent_key egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
merge m:m parent_key egoid using "base_indexage.dta", keep (3)
save "base_alter_D_append.dta", replace
clear


*****************************
* 5. Help to join association
*****************************
use "NEEMSIS2-HH_v17.dta", clear
tab associationlist
replace associationlist="" if associationlist=="13"|associationlist=="2 13"
split associationlist
foreach var of varlist associationlist1 associationlist2{
destring `var', replace
}
*
tab associationlist if egoid==1|egoid==2|egoid==3, m
clear

use "NEEMSIS_APPEND-ego123questionnaire-socialnetworks-formalsocialcapital_v2.dta" 
keep if associationname!=""
tab dummyassorecommendation
tab snrecommendasso
clear

use "NEEMSIS_APPEND-ego123questionnaire-snrecommendassogroup_v2.dta"
* OK pas de PB avec la snlist
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
save "base_alter_E.dta", replace
drop parent_key
rename HHID parent_key
rename snrecommandassohhmember hhmember
rename namefromearlier namealter
keep parent_key assoid_v1 egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
merge m:m parent_key egoid using "base_indexage.dta", keep (3)
save "base_alter_E_append.dta", replace
clear


****************************
* 6. Current main occupation
****************************
use "NEEMSIS2-HH_v17.dta", clear
tab snfindcurrentjob
tab snfindcurrentjobnamelist
clear

use "NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindcurrentjobgroup_v2.dta" 
* OK pas de PB avec la snlist
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
save "base_alter_F.dta", replace
rename namefromearlier namealter
replace namealter= namefromearlie if namefromearlie!=""
keep parent_key egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
merge m:m parent_key egoid using "base_indexage.dta", keep (3)
save "base_alter_F_append.dta", replace
clear


***********************************
* 7. Help to find job in the future
***********************************

use "NEEMSIS2-HH_v17.dta", clear
tab snfindjob
tab snfindjobnamelist
clear

use "NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindjobgroup_v2.dta"
* OK pas de PB avec la snlist
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
save "base_alter_G.dta", replace
rename namefromearlier namealter
keep parent_key egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
merge m:m parent_key egoid using "base_indexage.dta", keep (3)
save "base_alter_G_append.dta", replace
clear

************************
* 8. Recommend for a job
************************

use "NEEMSIS2-HH_v17.dta", clear
tab snrecommendforjob
tab snrecommendforjobnamelist
clear

use "NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecommendforjobgroup_v2.dta"
* OK pas de PB avec la snlist
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
save "base_alter_H.dta", replace
rename namefromearli namealter
replace namealter= namefromearlier if namefromearlier!=""
keep parent_key egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
merge m:m parent_key egoid using "base_indexage.dta", keep (3)
save "base_alter_H_append.dta", replace
clear


**********************
* 9. Recommend success
**********************

use "NEEMSIS2-HH_v17.dta", clear
tab snrecojobsuccess
tab snrecojobsuccessnamelist
clear

use "NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecojobsuccessgroup_v2.dta"
* OK pas de PB avec la snlist
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
save "base_alter_I.dta", replace
rename namefromearlier namealter
replace namealter= namefromearlie if namefromearlie!=""
keep parent_key egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
merge m:m parent_key egoid using "base_indexage.dta", keep (3)
save "base_alter_I_append.dta", replace
clear

*******************
* 10. Talk the most
*******************
use "NEEMSIS2-HH_v17.dta", clear
tab sntalkthemost
clear

use "NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sntalkthemostgroup_v2.dta"
* PB avec la snlist pour 7 alters qui n'en font pas partie
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
save "base_alter_J.dta", replace
rename namefromearlier namealter
keep parent_key egoid namealter friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
replace phonenb="0" if phonenb=="0#"
destring *, replace
tostring occupother castesother meetother livingname, replace
merge m:m parent_key egoid using "base_indexage.dta", keep (3)
save "base_alter_J_append.dta", replace
clear

***********************
* 11. Medical emergency
***********************
use "NEEMSIS2-HH_v17.dta", clear
ta snhelpemergency
clear

use "NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snhelpemergencygroup_v2.dta"
* OK pas de PB avec la snlist
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
save "base_alter_K.dta", replace
rename namefromearlier namealter
keep parent_key egoid namealter dummyfam dummyhh hhmember friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
merge m:m parent_key egoid using "base_indexage.dta", keep (3)
save "base_alter_K_append.dta", replace
clear

********************************
* 12. Close relatives outside HH
********************************
use "NEEMSIS2-HH_v17.dta", clear
tab sncloserelouthh
clear

use "NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sncloserelouthhgroup_v2.dta"
* PB avc la snlist pour 6 alters
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
save "base_alter_L.dta", replace
rename namefromearlier namealter
keep parent_key egoid namealter dummyfam friend wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
merge m:m parent_key egoid using "base_indexage.dta", keep (3)
save "base_alter_L_append.dta", replace
clear

****************************
* 13. Received help COVID-19
****************************
use "NEEMSIS2-HH_v17.dta", clear
tab covsnhelpreceived
tab covsnhelpreceivedlist
clear

use "NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-covsnhelpreceivedgroup_v2.dta"
* Pas de PB avec la snlist
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
save "base_alter_M.dta", replace
rename namefromearli namealter
replace labourrelation= labourrelatio if labourrelatio!=""
replace namealter= namefromearlier if namefromearlier!=""
keep parent_key egoid namealter dummyfam wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother living ruralurban district livingname compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother livingname, replace
merge m:m parent_key egoid using "base_indexage.dta", keep (3)
save "base_alter_M_append.dta", replace
clear

*************************
* 14. Given help COVID-19
*************************
use "NEEMSIS2-HH_v17.dta", clear
tab covsnhelpgiven
tab covsnhelpgivenlist
clear

use "NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-covsnhelpgivengroup_v2.dta"
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
save "base_alter_N.dta", replace
rename namefromearlier namealter
keep parent_key egoid namealter dummyfam wkp labourrelation sex age labourtype castes castesother educ occup employertype occupother compared money duration meet meetfrequency invite reciprocity1 intimacy phonenb photo meetother snlist n1 letter ALTERID
destring *, replace
tostring occupother castesother meetother, replace
merge m:m parent_key egoid using "base_indexage.dta", keep (3)
save "base_alter_N_append.dta", replace
clear


**************************************
* ETAPE 2 : Append de toutes les bases
**************************************
use "base_alter_A_append.dta"
destring *, replace
tostring occupother castesother meetother livingname, replace
save "base_alter_A_append.dta", replace
append using "base_alter_C_append.dta"
append using "base_alter_D_append.dta"
append using "base_alter_E_append.dta"
append using "base_alter_F_append.dta"
append using "base_alter_G_append.dta"
append using "base_alter_H_append.dta"
append using "base_alter_I_append.dta"
append using "base_alter_J_append.dta"
append using "base_alter_K_append.dta"
append using "base_alter_L_append.dta"
append using "base_alter_M_append.dta"
append using "base_alter_N_append.dta"
drop _merge
save "base_alter_VF1", replace
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
drop if businesslender==11|businesslender==14
save "base_alter_VF1.dta", replace

* Base alters pour les merging uniquement
use "base_alter_VF1.dta"
drop if letter=="A"
drop if snlist==0
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
save "base_alter_VF1_singlelist.dta", replace
clear

********************************************************************************
/* 

************************
Date : Lundi 24 mai 2021
Auteur : Cécile Mouchel
************************

*/

***********************************************
* ETAPE 3: Base de données - Aides multiples SN
***********************************************

*******************
* 2. Marriage loans
*******************
cd "C:\Users\mouch\Dropbox\RUME II\2. Data\Raw\2020-NEEMSIS2\Cécile-alter"
use "NEEMSIS_APPEND-marriagefinance.dta"
keep if marriageloanlistsn!=.
rename marriageloanlistsn snlist
gen loanmarriageuse=2
gen HHID= ustrleft(parent_key, 41)
drop parent_key
rename HHID parent_key
keep parent_key marriageloanid loanmarriageuse snlist
merge m:1 parent_key using "base_head_HH.dta", keep(3)
drop _merge
save "base_alter_B_complete.dta",replace
merge m:1 parent_key snlist using "base_alter_A_singlesnlist.dta", keepusing(ALTERID) keep(3)
drop _merge
duplicates drop ALTERID, force
save "base_alter_B_complete.dta",replace
clear

*******************
* 3. Business loans
*******************
use "NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemploymentsourceinvestment-businessloandetails_v2.dta"
keep if snbusinesslender!=888
rename snbusinesslender snlist
keep parent_key egoid businessloanid snlist
gen businessloanuse=1
drop if snlist==214
egen parent_key_egoid=concat(parent_key egoid)
drop parent_key egoid
destring businessloanid, replace
save "base_alter_C_snlist.dta", replace
drop snlist
reshape wide businessloanuse, i(parent_key_egoid) j(businessloanid)
merge 1:m parent_key_egoid using "base_alter_C_snlist.dta", keep(3)
drop _merge
gen egoid = usubstr(parent_key_egoid,42,.)
gen parent_key= ustrleft(parent_key_egoid, 41)
drop parent_key_egoid businessloanuse
order parent_key egoid snlist businessloanid , before ( businessloanuse1)
save "base_alter_C_complete.dta",replace 
merge m:1 parent_key snlist using "base_alter_A_singlesnlist.dta", keepusing(ALTERID) keep(3)
drop _merge
duplicates drop ALTERID, force
save "base_alter_C_complete.dta",replace 
clear

*******************
* 4. Recruit worker
*******************
use "NEEMSIS2-HH_v17.dta"
destring snrecruitworkernamelist, replace
drop if snrecruitworkernamelist==888
keep if snrecruitworkernamelist!=.
keep parent_key egoid INDID_total snrecruitworkernamelist
rename snrecruitworkernamelist snlist
gen recruitworkeruse=1
save "base_alter_D_complete.dta",replace 
merge m:1 parent_key snlist using "base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
replace recruitworkeruse=41 if egoid==1
replace recruitworkeruse=42 if egoid==2
replace recruitworkeruse=43 if egoid==3
save "base_alter_D_complete.dta",replace 
clear

*****************************
* 5. Help to join association
*****************************
use "NEEMSIS_APPEND-ego123questionnaire-socialnetworks-formalsocialcapital_v2.dta" 
destring snrecommendasso, replace
drop if snrecommendasso==888
keep if snrecommendasso!=.
rename snrecommendasso snlist
keep parent_key egoid associationid snlist
gen assosnuse=1
save "base_alter_E_complete.dta",replace
merge m:1 parent_key snlist using "base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
replace assosnuse=51 if egoid==1
replace assosnuse=52 if egoid==2
replace assosnuse=53 if egoid==3
save "base_alter_E_complete.dta",replace
clear

****************************
* 6. Current main occupation
****************************
use "NEEMSIS2-HH_v17.dta", clear
tab snfindcurrentjobnamelist
split snfindcurrentjobnamelist
foreach var of varlist snfindcurrentjobnamelist1- snfindcurrentjobnamelist3{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid snfindcurrentjobnamelist1- snfindcurrentjobnamelist3
gen compteur=_n
reshape long snfindcurrentjobnamelist, i(compteur) j(alterid_va)
drop if snfindcurrentjobnamelist==.
rename snfindcurrentjobnamelist snlist
drop compteur alterid_va
gen currentjobuse=1
save "base_alter_F_complete.dta", replace
merge m:1 parent_key snlist using "base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
drop if ALTERID==""
* Des missings parmi les ALTERID qui s'expliquent toujours du fait de la présence de seulement 4 alters contre 13 pour les "Recruit worker"
* Je suis obligée de supprimer ces missing pour le moment
save "base_alter_F_complete.dta", replace
keep if egoid==1
replace currentjobuse=61
rename currentjobuse currentjobuse_ego1
save "base_alter_F_complete_ego1.dta", replace
use "base_alter_F_complete.dta"
keep if egoid==2
replace currentjobuse=62
rename currentjobuse currentjobuse_ego2
save "base_alter_F_complete_ego2.dta", replace
use "base_alter_F_complete.dta"
keep if egoid==3
replace currentjobuse=63
rename currentjobuse currentjobuse_ego3
save "base_alter_F_complete_ego3.dta", replace
clear

***********************************
* 7. Help to find job in the future
***********************************
use "NEEMSIS2-HH_v17.dta", clear
tab snfindjobnamelist
split snfindjobnamelist
foreach var of varlist snfindjobnamelist1- snfindjobnamelist5{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid snfindjobnamelist1- snfindjobnamelist5
gen compteur=_n
reshape long snfindjobnamelist, i(compteur) j(alterid_va)
drop if snfindjobnamelist==.
rename snfindjobnamelist snlist
drop compteur alterid_va
gen futurejobuse=1
save "base_alter_G_complete.dta", replace
merge m:1 parent_key snlist using "base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
drop if ALTERID==""
* Des missings parmi les ALTERID qui s'expliquent toujours du fait de la présence de seulement 4 alters contre 13 pour les "Recruit worker"
save "base_alter_G_complete.dta", replace
keep if egoid==1
replace futurejobuse=71
rename futurejobuse futurejobuse_ego1
save "base_alter_G_complete_ego1.dta", replace
use "base_alter_G_complete.dta"
keep if egoid==2
replace futurejobuse=72
rename futurejobuse futurejobuse_ego2
save "base_alter_G_complete_ego2.dta", replace
use "base_alter_G_complete.dta"
keep if egoid==3
replace futurejobuse=73
rename futurejobuse futurejobuse_ego3
save "base_alter_G_complete_ego3.dta", replace
clear

************************
* 8. Recommend for a job
************************

use "NEEMSIS2-HH_v17.dta", clear
split snrecommendforjobnamelist
foreach var of varlist snrecommendforjobnamelist1- snrecommendforjobnamelist4{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid snrecommendforjobnamelist1- snrecommendforjobnamelist4
gen compteur=_n
reshape long snrecommendforjobnamelist, i(compteur) j(alterid_va)
drop if snrecommendforjobnamelist==.
rename snrecommendforjobnamelist snlist
drop compteur alterid_va
gen recommendforjobuse=1
save "base_alter_H_complete.dta", replace
merge m:1 parent_key snlist using "base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
save "base_alter_H_complete.dta", replace
keep if egoid==1
replace recommendforjobuse=81
rename recommendforjobuse recommendforjobuse_ego1
save "base_alter_H_complete_ego1.dta", replace
use "base_alter_H_complete.dta"
keep if egoid==2
replace recommendforjobuse=82
rename recommendforjobuse recommendforjobuse_ego2
save "base_alter_H_complete_ego2.dta", replace
use "base_alter_H_complete.dta"
keep if egoid==3
replace recommendforjobuse=83
rename recommendforjobuse recommendforjobuse_ego3
save "base_alter_H_complete_ego3.dta", replace
clear

**********************
* 9. Recommend success
**********************

use "NEEMSIS2-HH_v17.dta", clear
tab snrecojobsuccessnamelist
split snrecojobsuccessnamelist
foreach var of varlist snrecojobsuccessnamelist1- snrecojobsuccessnamelist4{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid snrecojobsuccessnamelist1- snrecojobsuccessnamelist4
gen compteur=_n
reshape long snrecojobsuccessnamelist, i(compteur) j(alterid_va)
drop if snrecojobsuccessnamelist==.
rename snrecojobsuccessnamelist snlist
drop compteur alterid_va
gen recojobsuccessuse=1
save "base_alter_I_complete.dta", replace
merge m:1 parent_key snlist using "base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
save "base_alter_I_complete.dta", replace
keep if egoid==1
replace recojobsuccessuse=91
rename recojobsuccessuse recojobsuccessuse_ego1
save "base_alter_I_complete_ego1.dta", replace
use "base_alter_I_complete.dta"
keep if egoid==2
replace recojobsuccessuse=92
rename recojobsuccessuse recojobsuccessuse_ego2
save "base_alter_I_complete_ego2.dta", replace
use "base_alter_I_complete.dta"
keep if egoid==3
replace recojobsuccessuse=93
rename recojobsuccessuse recojobsuccessuse_ego3
save "base_alter_I_complete_ego3.dta", replace
clear


*******************
* 10. Talk the most
*******************
use "NEEMSIS2-HH_v17.dta", clear
tab sntalkthemost
split sntalkthemost
foreach var of varlist sntalkthemost1- sntalkthemost4{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid sntalkthemost1- sntalkthemost4
gen compteur=_n
reshape long sntalkthemost, i(compteur) j(alterid_va)
drop if sntalkthemost==.
rename sntalkthemost snlist
drop compteur alterid_va
gen talkthemostuse=1
save "base_alter_J_complete.dta", replace
merge m:1 parent_key snlist using "base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
drop if ALTERID==""
save "base_alter_J_complete.dta", replace
keep if egoid==1
replace talkthemostuse=101
rename talkthemostuse talkthemostuse_ego1
save "base_alter_J_complete_ego1.dta", replace
use "base_alter_J_complete.dta"
keep if egoid==2
replace talkthemostuse=102
rename talkthemostuse talkthemostuse_ego2
save "base_alter_J_complete_ego2.dta", replace
use "base_alter_J_complete.dta"
keep if egoid==3
replace talkthemostuse=103
rename talkthemostuse talkthemostuse_ego3
save "base_alter_J_complete_ego3.dta", replace
clear


***********************
* 11. Medical emergency
***********************
use "NEEMSIS2-HH_v17.dta", clear
ta snhelpemergency
split snhelpemergency
foreach var of varlist snhelpemergency1- snhelpemergency4{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid snhelpemergency1- snhelpemergency4
gen compteur=_n
reshape long snhelpemergency, i(compteur) j(alterid_va)
drop if snhelpemergency==.
rename snhelpemergency snlist
drop compteur alterid_va
gen medicalemergencyuse=1
save "base_alter_K_complete.dta", replace
merge m:1 parent_key snlist using "base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
save "base_alter_K_complete.dta", replace
keep if egoid==1
replace medicalemergencyuse=111
rename medicalemergencyuse medicalemergencyuse_ego1
drop if ALTERID==""
save "base_alter_K_complete_ego1.dta", replace
use "base_alter_K_complete.dta"
keep if egoid==2
replace medicalemergencyuse=112
rename medicalemergencyuse medicalemergencyuse_ego2
save "base_alter_K_complete_ego2.dta", replace
use "base_alter_K_complete.dta"
keep if egoid==3
replace medicalemergencyuse=113
rename medicalemergencyuse medicalemergencyuse_ego3
save "base_alter_K_complete_ego3.dta", replace
clear

********************************
* 12. Close relatives outside HH
********************************
use "NEEMSIS2-HH_v17.dta", clear
tab sncloserelouthh
split sncloserelouthh
foreach var of varlist sncloserelouthh1- sncloserelouthh4{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid sncloserelouthh1- sncloserelouthh4
gen compteur=_n
reshape long sncloserelouthh, i(compteur) j(alterid_va)
drop if sncloserelouthh==.
rename sncloserelouthh snlist
drop compteur alterid_va
gen closerelouthhuse=1
save "base_alter_L_complete.dta", replace
merge m:1 parent_key snlist using "base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
save "base_alter_L_complete.dta", replace
keep if egoid==1
replace closerelouthhuse=121
rename closerelouthhuse closerelouthhuse_ego1
save "base_alter_L_complete_ego1.dta", replace
use "base_alter_L_complete.dta"
keep if egoid==2
replace closerelouthhuse=122
rename closerelouthhuse closerelouthhuse_ego2
drop if ALTERID==""
save "base_alter_L_complete_ego2.dta", replace
use "base_alter_L_complete.dta"
keep if egoid==3
replace closerelouthhuse=123
rename closerelouthhuse closerelouthhuse_ego3
save "base_alter_L_complete_ego3.dta", replace
clear


***********************************
* 13. Received help during COVID-19
***********************************
use "NEEMSIS2-HH_v17.dta", clear
tab covsnhelpreceivedlist
split covsnhelpreceivedlist
foreach var of varlist covsnhelpreceivedlist1- covsnhelpreceivedlist5{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid covsnhelpreceivedlist1- covsnhelpreceivedlist5
gen compteur=_n
reshape long covsnhelpreceivedlist, i(compteur) j(alterid_va)
drop if covsnhelpreceivedlist==.
rename covsnhelpreceivedlist snlist
drop compteur alterid_va
gen receivedhelpcov=1
save "base_alter_M_complete.dta", replace
merge m:1 parent_key snlist using "base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
drop if ALTERID==""
save "base_alter_M_complete.dta", replace
keep if egoid==1
replace receivedhelpcov=131
rename receivedhelpcov receivedhelpcov_ego1
save "base_alter_M_complete_ego1.dta", replace
use "base_alter_M_complete.dta"
keep if egoid==2
replace receivedhelpcov=132
rename receivedhelpcov receivedhelpcov_ego2
save "base_alter_M_complete_ego2.dta", replace
use "base_alter_M_complete.dta"
keep if egoid==3
replace receivedhelpcov=133
rename receivedhelpcov receivedhelpcov_ego3
save "base_alter_M_complete_ego3.dta", replace
clear

*************************
* 14. Given help COVID-19
*************************
use "NEEMSIS2-HH_v17.dta", clear
tab covsnhelpgiven
tab covsnhelpgivenlist
split covsnhelpgivenlist
foreach var of varlist covsnhelpgivenlist1- covsnhelpgivenlist2{
destring `var', replace
replace `var'=. if `var'==888
}
*
keep parent_key egoid covsnhelpgivenlist1- covsnhelpgivenlist2
gen compteur=_n
reshape long covsnhelpgivenlist, i(compteur) j(alterid_va)
drop if covsnhelpgivenlist==.
rename covsnhelpgivenlist snlist
drop compteur alterid_va
gen givehelpcov=1
save "base_alter_N_complete.dta", replace
merge m:1 parent_key snlist using "base_alter_A_singlesnlist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
rename ALTERID ALTERID_step1
egen HHID_egoid_snlist=concat( parent_key egoid snlist)
merge m:1 HHID_egoid_snlist using "base_alter_VF1_singlelist.dta", keepusing(ALTERID)
keep if _merge==1|_merge==3
drop _merge
replace ALTERID=ALTERID_step1 if ALTERID==""
drop ALTERID_step1 HHID_egoid_snlist
save "base_alter_N_complete.dta", replace
keep if egoid==1
replace givehelpcov=141
rename givehelpcov givehelpcov_ego1
save "base_alter_N_complete_ego1.dta", replace
use "base_alter_N_complete.dta"
keep if egoid==2
replace givehelpcov=142
rename givehelpcov givehelpcov_ego2
save "base_alter_N_complete_ego2.dta", replace
use "base_alter_N_complete.dta"
keep if egoid==3
replace givehelpcov=143
rename givehelpcov givehelpcov_ego3
save "base_alter_N_complete_ego3.dta", replace
clear


*********************************************************
* ETAPE 4: Base de données - Aides multiples SN - Merging 
*********************************************************
use "base_alter_VF1.dta"
merge 1:1 ALTERID using "base_alter_B_complete.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_C_complete.dta", keep(1 3) force
drop _merge
merge 1:1 ALTERID using "base_alter_D_complete.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_E_complete.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_F_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_F_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_F_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_G_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_G_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_G_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_H_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_H_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_H_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_I_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_I_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_I_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_J_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_J_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_J_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_K_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_K_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_K_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_L_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_L_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_L_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_M_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_M_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_M_complete_ego3.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_N_complete_ego1.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_N_complete_ego2.dta", keep(1 3)
drop _merge
merge 1:1 ALTERID using "base_alter_N_complete_ego3.dta", keep(1 3)
drop _merge
save "base_alter_VF2.dta", replace
merge m:1 parent_key INDID_total using "C:\Users\mouch\Dropbox\RUME II\2. Data\Raw\2020-NEEMSIS2\Cécile-alter\NEEMSIS2-HH_v26.dta", keepusing(INDID2020) keep(3)
drop _merge
rename parent_key HHID2020
order HHID2020 INDID2020 egoid snlist, before(ALTERID)
save "base_alter_VF3.dta", replace
clear


/* 

Remarques additionnelles 
Pas de retrait des 309 Alters qui ont été mentionnés mais qui appartiennent au même ménage = partagent la même cuisine.
Toujours besoin d'un travail de nettoyage pour coller parfaitement à la structure de la base de NEEMSIS-1 avec networkpurpose

*/

