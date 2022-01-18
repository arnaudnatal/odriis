cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
03/03/21
-----
TITLE: PANEL pour dette cog

description: 	Réunir tous les prêts dans la même base
-------------------------
*/



****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "C:\Users\Arnaud\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND\CLEAN"
global git = "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

cd"$directory"

*global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*global git ="C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"

********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

****************************************
* END





****************************************
* DATE + DURATION + PURPOSE
****************************************
use"NEEMSIS2-loans_v6.dta", clear


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
save"NEEMSIS2-loans_v7.dta", replace
****************************************
* END











****************************************
* NEW LENDER VAR
****************************************
use "NEEMSIS2-loans_v7.dta", clear
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

save "NEEMSIS2-loans_v8.dta", replace
****************************************
* END











****************************************
* ORDER + DUPLICATES + BALANCE and AMOUNT for everyone
****************************************
use"NEEMSIS2-loans_v8.dta", clear

*** Order
order HHID_panel INDID_panel loan_database loanamount loanamount2 loanamount3
sort HHID_panel INDID_panel loan_database loanamount3

gen loanduration_month=loanduration/30.467
replace loanduration_month=1 if loanduration_month<1
tab loanduration_month

dropmiss, force

*** After clean gold, replace in 2 and 3 version
replace loanbalance2=loanbalance if loan_database!="GOLD"
replace loanamount2=loanamount if loan_database!="GOLD"
replace loanamount3=loanamount if loan_database!="GOLD"

*** Drop
drop if jatis==.
drop guarantorloanrelation_10 helptosettleloan_5 helptosettleloan_10 recommendloanrelation_4 recommendloanrelation_66 recommendloanrelation_7 recommendloanrelation_11 guarantorloanrelation_4 guarantorloanrelation_66 guarantorloanrelation_7


********** Duplicates
***
preserve
***
duplicates tag HHID_panel INDID_panel loanamount loanlender loanreasongiven loandate, gen(tag)

bysort HHID_panel INDID_panel: egen tokeep=sum(tag)
drop if tokeep==0
drop tokeep

gen gold=0
replace gold=1 if loan_database=="GOLD" & tag!=0 & tag!=.
bysort HHID_panel INDID_panel: egen tokeep=sum(gold)
drop if tokeep==0
drop tokeep

ta tag
drop if tag==0
sort HHID_panel INDID_panel tag loanamount loan_database loandate
order HHID_panel INDID_panel loan_database tag

ta tag
drop if HHID_panel=="KOR42" & INDID_panel=="Ind_2" & loan_database=="FINANCE" & tag==1 & loanamount==45000
drop if HHID_panel=="NAT30" & INDID_panel=="Ind_5" & loan_database=="FINANCE" & tag==1 & loanamount==100000
drop if HHID_panel=="NAT42" & INDID_panel=="Ind_1" & loan_database=="FINANCE" & tag==1 & loanamount==50000
drop if HHID_panel=="NAT50" & INDID_panel=="Ind_1" & loan_database=="FINANCE" & tag==1 & loanamount==30000 & loandate==td(01jan2020)

drop if tag==2

gen duplicates=1
gen duplicatestodrop=0
replace duplicatestodrop=1 if loan_database=="GOLD"

drop tag

save"NEEMSIS2-loans_duplicates.dta", replace

***
restore
***

ta _merge
drop _merge

merge 1:1 HHID_panel INDID_panel loan_database loanamount loandate loanreasongiven loanlender loanid using "NEEMSIS2-loans_duplicates.dta", keepusing(duplicates duplicatestodrop)

drop _merge
ta duplicates 
recode duplicates (.=0)
recode duplicatestodrop (.=0)

ta duplicates
ta duplicatestodrop loan_database

save "NEEMSIS2-loans_v9.dta", replace
****************************************
* END















****************************************
* COHERENCE
****************************************
use"NEEMSIS2-loans_v9.dta", clear

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
list HHID_panel INDID_panel loanamount loanbalance totalrepaid interestpaid loan_database loanid if loanbalance<100 & loanbalance>0, clean noobs

* totalrepaid - interestpaid = 11115, ie principal left=8885
replace loanbalance2=8885 if HHID_panel=="KAR56" & INDID_panel=="Ind_2" & loanid==2
*si valeurs  bizarres: on garde loanamount
replace loanbalance2=loanamount if ///
(HHID_panel=="SEM65" & INDID_panel=="Ind_4" & loanid==2) | ///
(HHID_panel=="ORA11" & INDID_panel=="Ind_1" & loanid==5) | ///
(HHID_panel=="NAT39" & INDID_panel=="Ind_2" & loanid==2) | ///
(HHID_panel=="MAN67" & INDID_panel=="Ind_1" & loanid==3) | ///
(HHID_panel=="SEM49" & INDID_panel=="Ind_1" & loanid==5) 




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
*br HHID_panel INDID_panel loanamount loanbalance2 totalrepaid2 interestpaid2 principalpaid2 th_interest interestfrequency interestloan lender4 repayduration2 loanid  months_diff  if principalpaid2<0

*ici interestpaid2=6912 correspond à 24*interestloan (repayduration=27 mois, ca fait un taux d intéret total dans les clous). donc le principal remboursé  (30 000/27)*24=26667 => ce qui au bout de 24 mois nous donne bien loabbalance
replace principalpaid2=26667 if HHID_panel=="MANAM25" & INDID_panel=="Ind_2" & loanid==1
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="MANAM25" & INDID_panel=="Ind_2" & loanid==1
* interespaid correspond a 22*interestloan. principal paid en 22 mois= (30 000/24)*22=27500 => coherent avec loanbalance
replace principalpaid2=27500 if HHID_panel=="MANAM25" & INDID_panel=="Ind_2" & loanid==2
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="MANAM25" & INDID_panel=="Ind_2" & loanid==2
*pb de 0
replace totalrepaid2=totalrepaid*10 if HHID_panel=="KUV18" & INDID_panel=="Ind_1" & loanid==3
replace principalpaid2=totalrepaid2 - interestpaid2 if HHID_panel=="KUV18" & INDID_panel=="Ind_1"  & loanid==3
*interestloan represente très probablement le montant total payé chaque mois (principal + interet). interestpaid est coherent avec 22 mois de paiement (ie 567 INR par mois d interetà. donc principalpaid=(2650-567)*22=45826 => cohérent avec loanbalance
replace interestloan=567 if HHID_panel=="MANAM47" &	INDID_panel=="Ind_3" & loanid==2
replace principalpaid2=45826 if HHID_panel=="MANAM47" &	INDID_panel=="Ind_3" & loanid==2
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="MANAM47" & INDID_panel=="Ind_3" & loanid==2
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

*br HHID_panel INDID_panel loanamount loanbalance2 totalrepaid2 interestpaid2 principalpaid2 test th_interest interestfrequency interestloan lender4 repayduration1 repayduration2 loanid  months_diff lendername if test<-1000

/*40 000/24=1667 => loanbalance serait coherent avec 10 mois de principal à payer, donc 14 déjà payés (ok vu que le pret a été contracté il y a 15 mois). donc interestpaid serait 183*14=2562 et principalpaid=230338
mais totalrepaid serait coherent avec 10 mois remboursés (1667+183)*10
donc on y va a la hache et on considere que loanbalance est en fait principalpaid
*/
replace principalpaid3=loanbalance3 if HHID_panel=="SEM8" &	INDID_panel=="Ind_2" & loanid==5
replace interestpaid2=totalrepaid3-principalpaid3 if HHID_panel=="SEM8" & INDID_panel=="Ind_2" & loanid==5
replace loanbalance3=loanamount3-principalpaid3 if HHID_panel=="SEM8" & INDID_panel=="Ind_2" & loanid==5

*censé rembourser 2600/mois ((50 000 + 24*516)/24 ), coherent avec 2 mois de remboursement: 4168 est le principal remboursé en 2 mois
replace loanbalance3=loanamount3-loanbalance3 if HHID_panel=="SEM8" & INDID_panel=="Ind_2" & loanid==2

* loanbalance coherent avec 4 mois restant à payer ( 35 000/24)* 4= 5833. donc a déjà payé 20 mois (ok loan a été contracté il y a 23 mois). donc porincipalpaid en 20 mois=29 167. et interet 20 mois en theorie=2840 => ce qui est ok avec interestpaid
replace principalpaid3=29167 if HHID_panel=="ORA10" &	INDID_panel=="Ind_2" & loanid==3
replace totalrepaid3=principalpaid3+interestpaid2 if HHID_panel=="ORA10" &	INDID_panel=="Ind_2" & loanid==3

*interestpaid=24*interestloan. donc si loanbalance est ok, signifie qu a payé 10 278 par mois * 24 en principal. ferait un pret de 36 mois. pas absurde.
replace principalpaid3=10278*24 if HHID_panel=="ORA15" & INDID_panel=="Ind_2" & loanid==1
replace totalrepaid3=principalpaid3+interestpaid2 if  HHID_panel=="ORA15" & INDID_panel=="Ind_2" & loanid==1

*interestpaid coherent avec 11 mois payés. et loabalance avec 7 mois restant. => ok pour repayduration de 18 mois
replace principalpaid3=2222*11 if HHID_panel=="SEM29" &	INDID_panel=="Ind_1" & loanid==1
replace  totalrepaid3=principalpaid3+interestpaid2 if HHID_panel=="SEM29" &	INDID_panel=="Ind_1" & loanid==1
	
*loanbalance coherent avec 10 mois restant à payer si on considere une durée classique de 24 mois. interestpaid donnerait sur 24 mois un taux à 20%, ok. 
replace principalpaid3=1667*14 if HHID_panel=="KAR28" &	INDID_panel=="Ind_2" & loanid==1
replace totalrepaid3=principalpaid3+interestpaid2 if HHID_panel=="KAR28" &	INDID_panel=="Ind_2" & loanid==1

*loanbalance coherent avec 11 mois à payer si repayduration = 24. donnerait un taux de 27%, ok.
replace principalpaid3=13*1667 if HHID_panel=="SEM6" &	INDID_panel=="Ind_2" & loanid==1
replace totalrepaid3=principalpaid3+interestpaid2 if HHID_panel=="SEM6" &	INDID_panel=="Ind_2" & loanid==1
	

*loanbalance cogerent avec 2 mois restant à payer. avec interestpaid donnerait un taux d interet a 17%
replace principalpaid3=2084*22 if  HHID_panel=="SEM2" & INDID_panel=="Ind_4" & loanid==8
replace totalrepaid3=principalpaid3+interestpaid2 if   HHID_panel=="SEM2" & INDID_panel=="Ind_4" & loanid==8

*loanbalance cohérent avec 7 mois restant à payer. 
replace principalpaid3=1167*17 if loanid==2 & HHID_panel=="KAR42" &	INDID_panel=="Ind_2"
replace totalrepaid3=principalpaid3+interestpaid2 if  loanid==2 & HHID_panel=="KAR42" &	INDID_panel=="Ind_2"

*loanbalance coherent avec3 mois restant à payer
replace principalpaid3=1250*21 if HHID_panel=="SEM2" &	INDID_panel=="Ind_4" & loanid==9
replace totalrepaid3=principalpaid3+interestpaid2 if HHID_panel=="SEM2" &	INDID_panel=="Ind_4" & loanid==9




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
*br HHID_panel INDID_panel loanamount3 loanbalance3 interestpaid3 principalpaid4 totalrepaid3 test th_interest interestfrequency interestloan lender4 repayduration2 loanid  months_diff  if pb3==1

* je propose d'attribuer le surplus de principalpaid à interestpaid2, mettre loanbalance=0, et conserver loansettled=0 pour prendre en compte le fait qu il reste surement de l interet à payer

replace interestpaid3=principalpaid4-loanamount3 if pb3==1 & principalpaid4>loanamount3
replace principalpaid4=loanamount3 if pb3==1 & principalpaid4>loanamount3
replace loanbalance3=0 if pb3==1 & principalpaid4>loanamount3
gen pb4=1 if pb3==1 & principalpaid4>loanamount3
ta pb4
*br HHID_panel INDID_panel loanamount3 loanbalance3 totalrepaid3 interestpaid3 principalpaid4 test th_interest interestfrequency interestloan lender4 repayduration2 loanid  months_diff  if pb3==1




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

order HHID_panel INDID_panel test loansettled dummyinterest loanamount3 loanbalance3 principalpaid4 interestpaid3 totalrepaid3 lender4 loanlender loan_database
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


save"NEEMSIS2-loans_v10.dta", replace
****************************************
* END













****************************************
* ANNUALIZED
****************************************
use"NEEMSIS2-loans_v10.dta", clear

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
         WKP |       280  39.04335        30  .8333333       600
   Relatives |        54  30.33661        25         2       144
      Labour |        95  23.50702        20       2.4       108
 Shop keeper |         6  30.54747        33  .9212121        70
Moneylenders |        32  16.88754  13.32667  .7272727  73.77333
     Friends |       488  25.10458        18  .0057143       500
 Microcredit |        88  18.96117        10   .007875       120
        Bank |       147  20.33835    14.575       .21     122.4
     Thandal |        98  10.93325        10         1        60
-------------+--------------------------------------------------
       Total |      1288  26.01552        18  .0057143       600
----------------------------------------------------------------
*/

save"NEEMSIS2-loans_v11.dta", replace
*************************************
* END


















****************************************
* IMPUTATION
****************************************
use"NEEMSIS2-loans_v11.dta", clear


*** Add income
drop _merge
merge m:1 HHID_panel INDID_panel using "NEEMSIS2-HH_v16.dta", keepusing(annualincome_indiv annualincome_HH) 
drop if _merge==2
drop _merge
tab loansettled
tab householdid2020


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



*** Imputation interest for moneylenders (.17) and microcredit (.19)
gen imp1_interest=.
replace imp1_interest=0.17*loanamount if lender4==6 & loanduration<=365 & debt_service==.
replace imp1_interest=0.17*loanamount*365/loanduration if lender4==6 & loanduration>365 & debt_service==.
replace imp1_interest=0.19*loanamount if lender4==8 & loanduration<=365 & debt_service==.
replace imp1_interest=0.19*loanamount*365/loanduration if lender4==8 & loanduration>365 & debt_service==.
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


save"NEEMSIS2-loans_v12.dta", replace
*************************************
* END














****************************************
* Other measure
****************************************
use"NEEMSIS2-loans_v12.dta", clear


*Nb of ML/indiv/HH
gen dummymainloans=0
replace dummymainloans=1 if mainloanname!=""
tab dummymainloans


*** Nber of loan
gen loans_gm=1
replace loans_gm=. if loansettled==1

gen loans=0
replace loans=1 if loan_database=="FINANCE"
replace loans=. if loansettled==1

gen loans_g=1
replace loans_g=0 if loan_database=="MARRIAGE"
replace loans_g=. if loansettled==1


*** Loan amount
clonevar loanamount_gm=loanamount
replace loanamount_gm=. if loansettled==1

clonevar loanamount_g=loanamount
replace loanamount_g=. if loan_database=="MARRIAGE"
replace loanamount_g=. if loansettled==1

clonevar loanamount_fin=loanamount
replace loanamount_fin=. if loan_database=="MARRIAGE"
replace loanamount_fin=. if loan_database=="GOLD"
replace loanamount_fin=. if loansettled==1

ta loanamount_fin loan_database, m
ta loanamount_g loan_database, m
ta loanamount_gm loan_database, m


*** Indiv + HH level
foreach x in loans loans_gm loans_g loanamount_g loanamount_gm loanamount_fin {
bysort HHID_panel INDID_panel: egen `x'_indiv=sum(`x')
bysort HHID_panel: egen `x'_HH=sum(`x')
}

rename loanamount_fin_indiv loanamount_indiv
rename loanamount_fin_HH loanamount_HH

drop loanamount_fin loans_gm loanamount_gm loans_gm loans loans_g loanamount_g

*** Services
bysort HHID_panel INDID_panel: egen imp1_ds_tot_indiv=sum(imp1_debt_service)
bysort HHID_panel INDID_panel: egen imp1_is_tot_indiv=sum(imp1_interest_service)

bysort HHID_panel: egen imp1_ds_tot_HH=sum(imp1_debt_service)
bysort HHID_panel: egen imp1_is_tot_HH=sum(imp1_interest_service)


save"NEEMSIS2-loans_v13.dta", replace
*************************************
* END
















****************************************
* Individual level
****************************************
use"NEEMSIS2-loans_v13.dta", clear

*Indiv
preserve
duplicates drop HHID_panel INDID_panel, force
keep HHID_panel INDID_panel loans_indiv loans_g_indiv loans_gm_indiv loanamount_gm_indiv  loanamount_g_indiv loanamount_indiv imp1_ds_tot_indiv imp1_is_tot_indiv
save"NEEMSIS2-loans_v13_indiv.dta", replace
restore

*HH
preserve
duplicates drop HHID_panel, force
keep HHID_panel loans_HH loans_gm_HH loans_g_HH loanamount_gm_HH loanamount_g_HH imp1_ds_tot_HH imp1_is_tot_HH loanamount_HH
save"NEEMSIS2-loans_v13_HH.dta", replace
restore


*********** Merge
use"NEEMSIS2-HH_v16.dta", clear

merge 1:1 HHID_panel INDID_panel using "NEEMSIS2-loans_v13_indiv"
drop _merge

merge m:1 HHID_panel using "NEEMSIS2-loans_v13_HH"
drop _merge

drop if parent_key==""

save"NEEMSIS2-HH_v17.dta", replace
*************************************
* END
