cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
January 11, 2022
-----
TITLE: Sex relationship
-------------------------
*/


****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "C:\Users\Arnaud\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directorybis = "C:\Users\Arnaud\Docuements\_Thesis\_DATA\NEEMSIS2\DATA"
global git = "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

*global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*global directorybis = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA"
*global git ="C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"


cd"$directory"
clear all
****************************************
* END







****************************************
* Vérifications Elena
****************************************


********** DUPLICATES
use"$directory\CLEAN\_ANALYSIS_HH\NEEMSIS2-all_loans.dta", clear

keep HHID_panel INDID_panel loanamount loanlender loan_database loanreasongiven loanbalance lendername loandate loanduration loanduration_month loansettled

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
*br

ta tag
dis (96/2)+(3/3)
*49 duplicates?
*Check database
drop if HHID_panel=="KOR42" & INDID_panel=="Ind_2" & loan_database=="FINANCE" & tag==1 & loanamount==45000
drop if HHID_panel=="NAT30" & INDID_panel=="Ind_5" & loan_database=="FINANCE" & tag==1 & loanamount==100000
drop if HHID_panel=="NAT42" & INDID_panel=="Ind_1" & loan_database=="FINANCE" & tag==1 & loanamount==50000
drop if HHID_panel=="NAT50" & INDID_panel=="Ind_1" & loan_database=="FINANCE" & tag==1 & loanamount==30000 & loandate==td(01jan2020)

drop if tag==2

/*
44 cas de doublons sur la base de:
montant, raison, source, date
*/



********** GOLD
/*
Modification des premiers éléments
*/
use"$directory\CLEAN\_ANALYSIS_HH\NEEMSIS2-HH.dta", clear

g goldquantitypledge2=goldquantitypledge
g goldamountpledge2=goldamountpledge
g loanamountgold2=loanamountgold
g goldquantity2=goldquantity


**** check consistency total gold / pledged gold
g	unpledged_goldquantity=goldquantity - goldquantitypledge
ta unpledged
ta goldquantity goldquantitypledge if unpledged_g<0 
ta goldamountpledge if goldquantitypledge==140000
* 1 cas ou quantité et montant gagés ont été inversés (l inversion est cohérente avec loanamountgold)
replace goldquantitypledge2=48 if HHID_panel=="KOR48" & INDID_panel=="Ind_2"
replace goldamountpledge2=140000 if HHID_panel=="KOR48" & INDID_panel=="Ind_2"

g gold_rate=goldamountpledge2/goldquantitypledge2
ta gold_rate
su gold_rate, d

list HHID_panel INDID_panel goldquantity  goldquantitypledge2 goldamountpledge2  loanamountgold loanbalance gold_rate if unpledged_g<0 

*la solution la plus "conservative" consiste à considérer que le goldquantity declaré correspond à unpledged gold au lieu de totalgold (sinon il faut soit multiplier par 8 en considérant que c'est des sovereign, bof)
replace goldquantity2=goldquantity+goldquantitypledge2

***** check loanamountgold 
ta loanamountgold if goldamountpledge!=., mis
//66 peut etre soit une quantité,  soit une NR => vote pour le NR
replace loanamountgold2=goldamountpledge2 if HHID_panel=="KAR59" & INDID_panel=="Ind_2" //celui la est marqué missing dans le fichier all loans
//le 8 ici correspond probablement à la quantité
replace loanamountgold2=goldamountpledge2 if HHID_panel=="KOR19" & INDID_panel=="Ind_2"
//99 n est probablement pas une quantité;  on remplace par goldamountpledged
replace loanamountgold2=goldamountpledge2 if loanamountgold==99

***** check consistency goldamountpledge goldquantitypled
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
list HHID_panel INDID_panel goldquantity  goldquantitypledge2 goldamountpledge2  loanamountgold gold_rate temp if test==1
*vu le goldrate, on peut considérer que goldamountpl a un 0 en trop
replace goldamountpledge2=goldamountpledge2/10 if HHID_panel=="GOV8"  & INDID_panel=="Ind_2" | HHID_panel=="KUV34" & INDID_panel=="Ind_2" | HHID_panel=="ORA47" & INDID_panel=="Ind_2"
* et vice versa, 0 en trop pour loanamount
replace loanamountgold2=loanamountgold2/10 if HHID_panel=="KOR51"  & INDID_panel=="Ind_4" | HHID_panel=="ELA47"  & INDID_panel=="Ind_2"


*** check consistency goldamountpledge loanamountgold - A DETERMINER
gen diff=goldamountpledge2-loanamountgold2
ta diff
gen diff_abs=abs(diff)
replace diff_abs=. if diff>=0
clonevar loanamountgold3=loanamountgold2
replace loanamountgold3=goldamountpledge2 if diff<0
tabstat loanamountgold2 loanamountgold3 diff_abs, stat(n mean sd q min max)


/* En théorie, on devrait avoir goldamountpledge>=loanamountgold; les 2 font référence au montant au moment de l'emprunt.
mais dans 1/3 des cas, c'est l inverse
=> faut-il considérer que les gens ont répondu pour goldamountpledge le montant gagé NOW et donc  use goldamountpledge to retrieve an upper bound of  main gold loan balance?
(ie au max, il n y a que le main gold loan, donc balance = goldamountpledge)

=> j'aurais tendance à faire ca pour etre sure de ne pas surestimer la dette, qu'en penses tu ?  à voir aussi si ca induit beaucoup de changements
*/


/*
En soit, ca ne modifie que 3% des prêts, donc je ne vois pas vraiment de pb, d'autant plus que ca évite une surestimation de la dette et que ca permet de gagner en cohérence.

   stats |  loanam~2  loanam~3  diff_abs
---------+------------------------------
       N |       516       516       175
    mean |   69785.6  52646.65  50535.43
      sd |  112863.4  84127.86  122880.5
     p25 |     20000     10000     13000
     p50 |     35000     25000     20000
     p75 |     75000     50000     37000
     min |        24        24       200
     max |   1200000    900000   1140000
----------------------------------------
*/





use"$directory\CLEAN\_ANALYSIS_HH\NEEMSIS2-all_loans.dta", clear
********** COHERENCE LOANS
g	principalpaid=.
replace principalpaid=totalrepaid - interestpaid
*cas ou total repaid=0 mais interestpaid>0
replace principalpaid=0 if totalrepaid==0 

**** very small values of loanbalance
g loanbalance2=loanbalance

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


	

***** consistency totalrepaid et loanbalance (drame...)

/* intéret théorique */
g	months_diff = round( (submissiondate - loandate)/(365/12))
g	years_diff=round( (submissiondate - loandate)/365)
g	weeks_diff=round( (submissiondate - loandate)/(365/53) )
g	th_interest=.
replace th_interest=weeks_diff*interestloan if interestfreq==1
replace th_interest=months_diff*interestloan if interestfreq==2
replace th_interest=years_diff*interestloan if interestfreq==3


/* recodage interestpaid */ 
g	interestpaid2=interestpaid
/*(semble souvent repondu comme interestloan) - mais on ne peut pas savoir de toute facon;..
replace interestpaid2=. if interestpaid==interestloan & th_interest!=interestpaid & th_interest!=interestpaid+interestloan & (interestfreq==1 | interestfreq==2 | interestfreq==3)
*/

* si loanbalance=loanamount - total repaid & interestpaid>0: on considère que totalrepaid est en fait principalpaid
g	totalrepaid2=totalrepaid
g	principalpaid2=principalpaid

g temp=( (loanbalance2==loanamount - totalrepaid2) & interestpaid2>0 & interestpaid2!=.)
ta temp
replace principalpaid2=totalrepaid2 if temp==1
replace totalrepaid2=principalpaid2+interestpaid2 if principalpaid2!=. & interestpaid2!=.
drop temp


br HHID_panel INDID_panel loanamount loanbalance2 totalrepaid2 interestpaid2 principalpaid2 th_interest interestfrequency interestloan lender4 repayduration2 loanid  months_diff  if principalpaid2<0

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


* check  
g test=loanbalance2 - (loanamount - principalpaid2)
ta test
ta loansettled if test!=0 & test!=., mis //tous unsetteld
ta dummyinterest if test!=0 & test!=., mis //tous à interet


/** si loanbalance > loanamount - principalpaid:  (en gros 10% des prêts): ils surestiment ce qu'ils restent à payer ? ils sous estiment ce qu'ils ont déjà payé ?
=> si priorité à principalpaid (ie on ajuste loanbalance à la baisse): risque de surestimer service de la dette (principalpaid > loanamount - loanbalance) et sous estimer dette
=> si priorité à loanbalance: risque de surestimer la dette et sous estimer service
 ** si loanbalance < loanamount - principalpaid (en gros 5%): l'inverse

DONC on peut éventuellement considérer qu estimer le service de la dette est de toute facon foireux avec ce type de données et privilégier le volume de dette, donc faire les choix qui empechent surestimation de la dette:
=> priorité à loanbalance si loanbalance < loanamount - principalpaid 
=> priorité à principalpaid si  loanbalance > loanamount - principalpaid 
*/



/*
J'ai l'impression qu'il est plus facile de savoir à peu près combien on a versé au prêteur, plutôt que de savoir ce qu'il nous reste à payer...!
Du coup, j'aurai donné la priorité à principaid à chaque fois
Sauf qu'ils ne savent pas vraiment si ils payent de l'intérêt ou du principal..

Peut être effectivement il vaut mieux ne pas surestimer la dette...
*/



/*** ci dessous j ai commencé à recoder à la main quelques cas pour lesquels loanbalance < loanamount - principalpaid 
 mais j'ai abandonné car beaucoup trop fastidieux et surtout, il se trouve que quand c est possible de retrouver les bons montants en croisant les infos, ca revient à faire le choix mentionné ci dessus 
 */

br HHID_panel INDID_panel loanamount loanbalance2 totalrepaid2 interestpaid2 principalpaid2 test th_interest interestfrequency interestloan lender4 repayduration1 repayduration2 loanid  months_diff lendername if test<-1000


/*40 000/24=1667 => loanbalance serait coherent avec 10 mois de principal à payer, donc 14 déjà payés (ok vu que le pret a été contracté il y a 15 mois). donc interestpaid serait 183*14=2562 et principalpaid=230338
mais totalrepaid serait coherent avec 10 mois remboursés (1667+183)*10
donc on y va a la hache et on considere que loanbalance est en fait principalpaid
*/
replace principalpaid2=loanbalance2 if HHID_panel=="SEM8" &	INDID_panel=="Ind_2" & loanid==5
replace interestpaid2=totalrepaid2-principalpaid2 if HHID_panel=="SEM8" & INDID_panel=="Ind_2" & loanid==5
replace loanbalance2=loanamount - principalpaid2 if HHID_panel=="SEM8" & INDID_panel=="Ind_2" & loanid==5

*censé rembourser 2600/mois ((50 000 + 24*516)/24 ), coherent avec 2 mois de remboursement: 4168 est le principal remboursé en 2 mois
replace loanbalance2=loanamount - loanbalance if HHID_panel=="SEM8" & INDID_panel=="Ind_2" & loanid==2

* loanbalance coherent avec 4 mois restant à payer ( 35 000/24)* 4= 5833. donc a déjà payé 20 mois (ok loan a été contracté il y a 23 mois). donc porincipalpaid en 20 mois=29 167. et interet 20 mois en theorie=2840 => ce qui est ok avec interestpaid
replace principalpaid2=29167 if HHID_panel=="ORA10" &	INDID_panel=="Ind_2" & loanid==3
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="ORA10" &	INDID_panel=="Ind_2" & loanid==3

*interestpaid=24*interestloan. donc si loanbalance est ok, signifie qu a payé 10 278 par mois * 24 en principal. ferait un pret de 36 mois. pas absurde.
replace principalpaid2=10278*24 if HHID_panel=="ORA15" & INDID_panel=="Ind_2" & loanid==1
replace totalrepaid2=principalpaid2+interestpaid2 if  HHID_panel=="ORA15" & INDID_panel=="Ind_2" & loanid==1

*interestpaid coherent avec 11 mois payés. et loabalance avec 7 mois restant. => ok pour repayduration de 18 mois
replace principalpaid2=2222*11 if HHID_panel=="SEM29" &	INDID_panel=="Ind_1" & loanid==1
replace  totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="SEM29" &	INDID_panel=="Ind_1" & loanid==1
	
*loanbalance coherent avec 10 mois restant à payer si on considere une durée classique de 24 mois. interestpaid donnerait sur 24 mois un taux à 20%, ok. 
replace principalpaid2=1667*14 if HHID_panel=="KAR28" &	INDID_panel=="Ind_2" & loanid==1
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="KAR28" &	INDID_panel=="Ind_2" & loanid==1

*loanbalance coherent avec 11 mois à payer si repayduration = 24. donnerait un taux de 27%, ok.
replace principalpaid2=13*1667 if HHID_panel=="SEM6" &	INDID_panel=="Ind_2" & loanid==1
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="SEM6" &	INDID_panel=="Ind_2" & loanid==1
	

*loanbalance cogerent avec 2 mois restant à payer. avec interestpaid donnerait un taux d interet a 17%
replace principalpaid2=2084*22 if  HHID_panel=="SEM2" & INDID_panel=="Ind_4" & loanid==8
replace totalrepaid2=principalpaid2+interestpaid2 if   HHID_panel=="SEM2" & INDID_panel=="Ind_4" & loanid==8

*loanbalance cohérent avec 7 mois restant à payer. 
replace principalpaid2=1167*17 if loanid==2 & HHID_panel=="KAR42" &	INDID_panel=="Ind_2"
replace totalrepaid2=principalpaid2+interestpaid2 if  loanid==2 & HHID_panel=="KAR42" &	INDID_panel=="Ind_2"

*loanbalance coherent avec3 mois restant à payer
replace principalpaid2=1250*21 if HHID_panel=="SEM2" &	INDID_panel=="Ind_4" & loanid==9
replace totalrepaid2=principalpaid2+interestpaid2 if HHID_panel=="SEM2" &	INDID_panel=="Ind_4" & loanid==9






***** consistency principalpaid, loanbalance, settled:  certains prets semblent furieusement etre rembourses



g pb=(principalpaid2>=loanamount & principalpaid2!=. & loansettled==0)
ta pb
/*
         pb |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      5,240       98.37       98.37
          1 |         87        1.63      100.00
------------+-----------------------------------
      Total |      5,327      100.00

*/
br HHID_panel INDID_panel loanamount loanbalance2 totalrepaid interestpaid2 principalpaid2 test th_interest interestfrequency interestloan lender4 repayduration2 loanid  months_diff  if pb==1



*si on fait le choix mentionné ci dessus

//priorité à loanbalance si loanbalance < loanamount - principalpaid 
replace interestpaid2=totalrepaid2 - principalpaid2 if loanbalance2 < loanamount - principalpaid2 & principalpaid2<=loanamount //(4 real changes made)
replace principalpaid2=loanamount - loanbalance2 if loanbalance2 < loanamount - principalpaid2 & principalpaid2<=loanamount //89 changes

//priorité à principalpaid si  loanbalance > loanamount - principalpaid 
replace loanbalance2=loanamount - principalpaid2 if loanbalance>loanamount - principalpaid2 & principalpaid2<=loanbalance2 //(67 real changes made)

replace loansettled=1 if loanbalance2==0 & principalpaid2==loanamount //(7 real changes made)


g pb2=(principalpaid2>=loanamount & principalpaid2!=.  & loansettled==0)
ta pb2
/*

        pb2 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      5,243       98.42       98.42
          1 |         84        1.58      100.00
------------+-----------------------------------
      Total |      5,327      100.00

*/
br HHID_panel INDID_panel loanamount loanbalance2 totalrepaid interestpaid2 principalpaid2 test th_interest interestfrequency interestloan lender4 repayduration2 loanid  months_diff  if pb2==1


* je propose d'attribuer le surplus de principalpaidé à interestpaid2, mettre loanbalance=0, et conserver loansettled=0 pour prendre en compte le fait qu il reste surement de l interet à payer




