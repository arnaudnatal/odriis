

cd "C:\Users\Elena\Documents\NEEMSIS2\NEEMSIS2\"




*****************************************************************************************************
***************** I. GOLD loans dans base all loans: semble n'y avoir que les main gold loans


use  "NEEMSIS2-HH.dta", clear

keep if dummygoldpledged==1

*goldamountpledge=total pledged; loanamountgold=amount of main gold loans
g test1=goldamountpledge-loanamountgold
ta test1 //dans 1/3 des cas, <0 ; 44%=0; 21%, >0

*étrange que la question loanbalance soit posée si le prêt est settled???
g test2=goldamountpledge-loanbalancegold
ta test2

keep HHID_panel INDID_panel goldamountpledge loanamountgold loanbalancegold
merge 1:m HHID_panel INDID_panel using "NEEMSIS2-all_loans.dta"
drop _merge

g test1=loanamount-loanamountgold
replace test1=. if loan_database!="GOLD"
ta test1
/*
test1	Freq.	Percent	Cum.
			
0	515	100.00	100.00
			
Total	515	100.00
*/

* => c est donc bien les main gold loans qu'il y a dans la base all loans si je comprends bien ce qu'est la variable loanamountgold dans le questionnaire HH



*******************************************************************************************************
******************** II. Duplicates gold loans entre base gold et base finance 


use "NEEMSIS2-all_loans.dta", clear

* potentiels duplicates pawn 15 cas
g pawn=(loanlender==6)
g fin=(loan_database=="FINANCE" & pawn==1)
g gol=(loan_database=="GOLD" & pawn==1)

bysort HHID_panel INDID_panel: egen nb_pawn=sum(pawn)
bysort HHID_panel INDID_panel: egen nb_fin=sum(fin)
bysort HHID_panel INDID_panel: egen nb_gol=sum(gol)

g dup=(nb_fin>=1 & nb_gol>=1 & nb_pawn>=1)

sort HHID_panel INDID_panel 
br HHID_panel INDID_panel loanamount loandate loanbalance lendername loan_database  loanreasongiven loaneffectivereason  if dup==1 & pawn==1

g dup_ok=0
replace dup_ok=1 if loan_database=="GOLD" & ( ///
	(HHID_panel=="ELA3" &INDID_panel=="Ind_3") | ///
	(HHID_panel=="KAR22" &	INDID_panel=="Ind_1") | ///
	(HHID_panel=="KAR50" & INDID_panel=="Ind_1") | ///
	(HHID_panel=="MAN3" & INDID_panel=="Ind_1") |  ///
	(HHID_panel=="MAN42" & INDID_panel=="Ind_1") |  ///
	(HHID_panel=="MAN45" & INDID_panel=="Ind_3") | ///
	(HHID_panel=="MANAM27" & INDID_panel=="Ind_1") | ///
	(HHID_panel=="NAT30" & INDID_panel=="Ind_5") | ///
	(HHID_panel=="NAT50" & INDID_panel=="Ind_1") | ///	
	(HHID_panel=="ORA23" & INDID_panel=="Ind_3") | ///
	(HHID_panel=="ORA62" & INDID_panel=="Ind_2") ///
)		

/*
g dup_probable=0
*loanreason: house exp/inv	
replace dup_probable=1 if loan_database=="GOLD" & (HHID_panel=="KOR35" & INDID_panel=="Ind_2")
*loanreason: other/house exp
replace dup_probable=1 if loan_database=="GOLD" & (HHID_panel=="ORA10" & INDID_panel=="Ind_2") 
* loan effective reason differe
replace dup_probable=1 if loan_database=="GOLD" & (HHID_panel=="SEM33" & INDID_panel=="Ind_1") 
*loan reason: family/repay loan: but 40 000 INR pour family exp is weird
replace dup_probable=1 if loan_database=="GOLD" & (HHID_panel=="MANAM65" & INDID_panel=="Ind_3") 
*/

drop pawn fin gol nb_pawn nb_fin nb_gol dup



*** potentiels duplicates banks 18 cas

g bank=(loanlender==11)
g fin=(loan_database=="FINANCE" & bank==1)
g gol=(loan_database=="GOLD" & bank==1)

bysort HHID_panel INDID_panel: egen nb_bank=sum(bank)
bysort HHID_panel INDID_panel: egen nb_fin=sum(fin)
bysort HHID_panel INDID_panel: egen nb_gol=sum(gol)

g dup=(nb_fin>=1 & nb_gol>=1 & nb_bank>=1)
br HHID_panel INDID_panel loanamount loandate loanbalance lendername loan_database  loanreasongiven loaneffectivereason  if dup==1 & bank==1


replace dup_ok=1 if loan_database=="GOLD" & bank==1 & ( ///
(HHID_panel=="ELA13" & INDID_panel=="Ind_1") | ///
(HHID_panel=="ELA42" & INDID_panel=="Ind_2") | ///
(HHID_panel=="GOV49" & INDID_panel=="Ind_1") | ///
(HHID_panel=="GOV5" & INDID_panel=="Ind_1") | ///
(HHID_panel=="GOV8" & INDID_panel=="Ind_1") | ///
(HHID_panel=="GOV8" & INDID_panel=="Ind_2") | ///
(HHID_panel=="MANAM6" & INDID_panel=="Ind_1") | ///
(HHID_panel=="NAT1" & INDID_panel=="Ind_1") | ///
(HHID_panel=="MANAM27" & INDID_panel=="Ind_2") | ///
(HHID_panel=="NAT10" & INDID_panel=="Ind_1") | ///
(HHID_panel=="NAT38" & INDID_panel=="Ind_3") | ///
(HHID_panel=="NAT41" & INDID_panel=="Ind_2") | ///
(HHID_panel=="NAT7" & INDID_panel=="Ind_3") | ///
(HHID_panel=="SEM18" & INDID_panel=="Ind_1") | ///
(HHID_panel=="SEM45" & INDID_panel=="Ind_15") | ///
(HHID_panel=="SEM47" & INDID_panel=="Ind_2") ///
)

/*
* loanreason: other:marriage
replace dup_probable=1 if loan_database=="GOLD" & HHID_panel=="SEM48" & INDID_panel=="Ind_5"
*loanreason: family/marriage (montant de 100 000 et 300 000 pour family exp, plus credible que ce soit du marriage)
replace dup_probable=1 if loan_database=="GOLD" & HHID_panel=="GOV43" & (INDID_panel=="Ind_1" | INDID_panel=="Ind_3")
*/

drop bank fin gol nb_bank nb_fin nb_gol dup



*** potentiels duplicates wkp 3 cas

g wkp=(loanlender==1)
g fin=(loan_database=="FINANCE" & wkp==1)
g gol=(loan_database=="GOLD" & wkp==1)

bysort HHID_panel INDID_panel: egen nb_wkp=sum(wkp)
bysort HHID_panel INDID_panel: egen nb_fin=sum(fin)
bysort HHID_panel INDID_panel: egen nb_gol=sum(gol)

g dup=(nb_fin>=1 & nb_gol>=1 & nb_wkp>=1)
br HHID_panel INDID_panel loanamount loandate loanbalance lendername loan_database  loanreasongiven loaneffectivereason  if dup==1 & wkp==1

replace dup_ok=1 if loan_database=="GOLD" & wkp==1 & ( ///
(HHID_panel=="KOR42" & INDID_panel=="Ind_2") | ///
(HHID_panel=="KUV29" & INDID_panel=="Ind_2") | ///
(HHID_panel=="MAN30" & INDID_panel=="Ind_1")  ///
)


drop wkp fin gol nb_wkp nb_fin nb_gol dup





*** potentiels duplicates finance 2 cas


g finance=(loanlender==1)
g fin=(loan_database=="FINANCE" & finance==1)
g gol=(loan_database=="GOLD" & finance==1)

bysort HHID_panel INDID_panel: egen nb_finance=sum(finance)
bysort HHID_panel INDID_panel: egen nb_fin=sum(fin)
bysort HHID_panel INDID_panel: egen nb_gol=sum(gol)

g dup=(nb_fin>=1 & nb_gol>=1 & nb_finance>=1)
br HHID_panel INDID_panel loanamount loandate loanbalance lendername loan_database  loanreasongiven loaneffectivereason  if dup==1 & finance==1

replace dup_ok=1 if loan_database=="GOLD" & HHID_panel=="MAN30" & INDID_panel=="Ind_1"

/*
*loanreason; ceremonies/family (gros montant)
replace dup_prob=1 if loan_database=="GOLD" & HHID_panel=="KAR48" & INDID_panel=="Ind_2"
*/

drop finance fin gol nb_fin nb_finance nb_gol dup



*** potentiels duplicates group loans 1 cas


g group=(loanlender==1)
g fin=(loan_database=="FINANCE" & group==1)
g gol=(loan_database=="GOLD" & group==1)

bysort HHID_panel INDID_panel: egen nb_group=sum(group)
bysort HHID_panel INDID_panel: egen nb_fin=sum(fin)
bysort HHID_panel INDID_panel: egen nb_gol=sum(gol)

g dup=(nb_fin>=1 & nb_gol>=1 & nb_group>=1)

br HHID_panel INDID_panel loanamount loandate loanbalance lendername loan_database  loanreasongiven loaneffectivereason  if dup==1 & group==1

replace dup_ok=1 if loan_database=="GOLD" & group==1 & HHID_panel=="MAN30" &	INDID_panel=="Ind_1"

drop group fin gol nb_fin nb_group nb_gol dup







*************************************************************************************
****************************** III. CLEANING GOLD - a utiliser pour actualiser all loans

use  "NEEMSIS2-HH.dta", clear




/* RQ; les problemes d'incohérence peuvent aussi être liés à la manière de poser la question avec different time frames: goldquantitypledged=now; goldamountpledge=at the time of pledging
 => donc si a remboursé en patie, la quantité ne correspond plus au montant
Cependant il me semble que pour les pawnbrokers en tous cas, l intéret est payé au fur et à mesure et les biens gagés récupérés d'un coup à la fin, donc ce n'est peut etre pas problématique*/


g goldquantitypledge2=goldquantitypledge
g goldamountpledge2=goldamountpledge
g loanamountgold2=loanamountgold
g goldquantity2=goldquantity


**** check consistency total gold / pledged gold

g	unpledged_goldquantity=goldquantity - goldquantitypledge
ta unpledged
/*
unpledged_g |
oldquantity |      Freq.     Percent        Cum.
------------+-----------------------------------
    -139936 |          1        0.19        0.19
        -72 |          1        0.19        0.39
        -26 |          1        0.19        0.58
        -24 |          2        0.39        0.97
        -22 |          1        0.19        1.16
        -21 |          2        0.39        1.55
        -16 |          1        0.19        1.74
        -14 |          2        0.39        2.13
        -12 |          4        0.78        2.91
         -8 |          3        0.58        3.49
         -6 |          1        0.19        3.68
         -4 |          1        0.19        3.88
          0 |         88       17.05       20.93
*/
ta goldquantity goldquantitypledge if unpledged_g<0 
ta goldamountpledge if goldquantitypledge==140000
* 1 cas ou quantité et montant gagés ont été inversés (l inversion est cohérente avec loanamountgold)
replace goldquantitypledge2=48 if HHID_panel=="KOR48" & INDID_panel=="Ind_2"
replace goldamountpledge2=140000 if HHID_panel=="KOR48" & INDID_panel=="Ind_2"


g gold_rate=goldamountpledge2/goldquantitypledge2
ta gold_rate
su gold_rate, d

list HHID_panel INDID_panel goldquantity  goldquantitypledge2 goldamountpledge2  loanamountgold loanbalance gold_rate if unpledged_g<0 
/*

      | HHID_p~l   INDID~el   goldqu~y   goldq~e2   goldam~2   loanam~d   loanba~d   gold_r~e |
      |---------------------------------------------------------------------------------------|
  81. |    KOR55      Ind_1          3         24      30000      30000          .       1250 |
  85. |    KOR52      Ind_1          3         24      50000      50000          .   2083.333 |
 161. |    GOV60      Ind_1          2          8      20000      20000          .       2500 |
 194. |    KAR52      Ind_1          4         16     100000     160000          .       6250 |
 384. |    GOV61      Ind_2         10         24      45000      45000          .       1875 |
      |---------------------------------------------------------------------------------------|
 633. |    ELA38      Ind_4         10         32     120000     120000          .       3750 |
 813. |    KAR59      Ind_2          8         80     173000         66          .     2162.5 |
 817. |    KUV48      Ind_2          8         32      80000      80000          .       2500 |
 922. |  MANAM55      Ind_2         16         40      45000      45000          .       1125 |
1123. |    KOR19      Ind_2          4          8       5500          8          .      687.5 |
      |---------------------------------------------------------------------------------------|
1183. |    KOR29      Ind_2         12         24      25000      25000          .   1041.667 |
1402. |     ORA7      Ind_2          4         16      12000      12000          .        750 |
1940. |    MAN34      Ind_1         16         28      30000      30000          .   1071.429 |
2261. |  MANAM33      Ind_2          2         16      60000     400000          .       3750 |
2290. |    KOR48      Ind_2         64         48     140000     140000          .   2916.667 |
      |---------------------------------------------------------------------------------------|
2726. |    SEM49      Ind_2         16         32      80000      35000          .       2500 |
2756. |    KUV14      Ind_2         16         24      15000      15000          .        625 |
2968. |    SEM62      Ind_2         32         40     100000     100000          .       2500 |
3367. |    ORA24      Ind_2         32         40      70000      30000          .       1750 |
3513. |    KUV18      Ind_1          6         32     125000      10000          .    3906.25 |

*/

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


/* En théorie, on devrait avoir goldamountpledge>=loanamountgold; les 2 font référence au montant au moment de l'emprunt.
mais dans 1/3 des cas, c'est l inverse
=> faut-il considérer que les gens ont répondu pour goldamountpledge le montant gagé NOW et donc  use goldamountpledge to retrieve an upper bound of  main gold loan balance?
(ie au max, il n y a que le main gold loan, donc balance = goldamountpledge)

=> j'aurais tendance à faire ca pour etre sure de ne pas surestimer la dette, qu'en penses tu ?  à voir aussi si ca induit beaucoup de changements
*/



***********************************************************************************
**************************** IV. Cleaning all loans

use "NEEMSIS2-all_loans.dta", clear

g	principalpaid=.
replace principalpaid=totalrepaid - interestpaid
*cas ou total repaid=0 mais interestpaid>0
replace principalpaid=0 if totalrepaid==0 




**** very small values of loanbalance

g loanbalance2=loanbalance


list HHID_panel INDID_panel loanamount loanbalance totalrepaid interestpaid loan_database loanid if loanbalance<100 & loanbalance>0
/*
      | HHID_p~l   INDID~el   loanam~t   loanba~e   totalr~d   intere~d   loan_d~e   loanid |
      |-------------------------------------------------------------------------------------|
 125. |     NAT1      Ind_1       6000         66       6000          .    FINANCE        4 |
 131. |    SEM23      Ind_2         48         48          .          .       GOLD        . |
 173. |    KOR19      Ind_2          8          8          .          .       GOLD        . |
 332. |    SEM65      Ind_4       1000         66          .          .    FINANCE        2 |
 887. |    ORA11      Ind_1        500         55          .          .    FINANCE        5 |
      |-------------------------------------------------------------------------------------|
2013. |    KAR56      Ind_2      20000         12      15000       3885    FINANCE        2 |
2192. |    NAT39      Ind_2       1000          5          .          .    FINANCE        2 |
2724. |   MANAM8      Ind_2         99         99          .          .       GOLD        . |
3330. |    ELA23      Ind_2         24         24          .          .       GOLD        . |
3415. |    MAN67      Ind_1      20000         66          .          .    FINANCE        3 |
      |-------------------------------------------------------------------------------------|
3771. |    KAR59      Ind_2          .         66          .          .       GOLD        . |
4650. |    SEM49      Ind_1       5000          5          .          .    FINANCE        5 |

*/

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


/** si loanbalance > loanamount - principalpaid:  (en gros 10% des prêts)
=> si priorité à principalpaid (ie on ajuste loanbalance à la baisse): risque de surestimer service de la dette (principalpaid > loanamount - loanbalance) et sous estimer dette
=> si priorité à loanbalance: risque de surestimer la dette et sous estimer service
 ** si loanbalance < loanamount - principalpaid (en gros 5%): l'inverse

DONC on peut éventuellement considérer qu estimer le service de la dette est de toute facon foireux avec ce type de données et privilégier le volume de dette, donc faire les choix qui empechent surestimation de la dette:
=> priorité à loanbalance si loanbalance < loanamount - principalpaid 
=> priorité à principalpaid si  loanbalance > loanamount - principalpaid 
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
