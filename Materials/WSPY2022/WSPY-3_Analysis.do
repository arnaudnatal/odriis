*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*November 15, 2022
*-----
*WSPY 2022
*-----
do "https://raw.githubusercontent.com/arnaudnatal/odriis/main/Materials/WSPY2022/_WSPY22.do"
*-------------------------






****************************************
* Ineq at HH level
***************************************
use"panel_HH_wide", clear




********** Step1: Desc

*** Stat et CV
tabstat annualincome1000_HH1 annualincome1000_HH2 annualincome1000_HH3, stat(n mean sd cv)
* CV de :
* 0.74 en 2010;
* 1.00 en 2016-17;
* 1.05 en 2020-21.
* Les inégalités de revenu augmentent entre 2010 et 2020-21.


*** Kernel
twoway ///
(kdensity annualincome1000_HH1, bwidth(20)) ///
(kdensity annualincome1000_HH2, bwidth(20)) ///
(kdensity annualincome1000_HH3, bwidth(20))
* L'étendue de la fonction de densité augmente avec les années.
* On peut donc supposer que les inégalités augmentent.

preserve
use"panel_HH_long", clear
replace annualincome1000_HH=annualincome1000_HH/12
twoway ///
(kdensity annualincome1000_HH if year==1 & annualincome1000_HH<80, bwidth(5)) ///
(kdensity annualincome1000_HH if year==2 & annualincome1000_HH<80, bwidth(5)) ///
(kdensity annualincome1000_HH if year==3 & annualincome1000_HH<80, bwidth(5))
tabstat annualincome1000_HH, stat(n mean sd p50 min max) by(year)
restore



*** Boxplot
graph box annualincome1000_HH1 annualincome1000_HH2 annualincome1000_HH3
*stripplot annualincome1000_HH1 annualincome1000_HH2, box centre vertical cumul cumpr
* On voit que la boite est de plus en plus grande, ce qui signifie que l'IQR est de plus en plus grand, donc que les inégalités augmentent.



********** Step2: Indicators of inequalities

*** IQR
ineqdeco annualincome1000_HH1
ineqdeco annualincome1000_HH2
ineqdeco annualincome1000_HH3
* Rapport de :
* 2.2 en 2010;
* 3.1 en 2016-17;
* 3.8 en 2020-21.
* L'écart entre les plus riches et les plus pauvres se creuse.


*** Lorenz
lorenz estimate annualincome1000_HH1 annualincome1000_HH2 annualincome1000_HH3
lorenz graph, overlay


*** Gini
pshare estimate annualincome1000_HH1 annualincome1000_HH2 annualincome1000_HH3, gini 
* Gini passe de .32 à .44 à .49


*** Percentile share
pshare estimate annualincome1000_HH1 annualincome1000_HH2 annualincome1000_HH3
* Les 20 % les plus pauvres en 2010, détiennent 8 % des revenus totaux.
pshare stack
*pshare histogram



*** GE
ineqdeco annualincome1000_HH1
*Theil de 0.18895





********** Step3: Decomposition par groupe

*** Desc
tabstat annualincome1000_HH1 annualincome1000_HH2 annualincome1000_HH3, stat(n mean sd cv) by(caste)

*** IQR
tabstat annualincome1000_HH1 annualincome1000_HH2 annualincome1000_HH3, stat(q) by(caste)

*** Lorenz
lorenz estimate annualincome1000_HH1, over(caste)
lorenz graph, overlay
lorenz estimate annualincome1000_HH2, over(caste) 
lorenz graph, overlay
lorenz estimate annualincome1000_HH3, over(caste)
lorenz graph, overlay


*** Gini
pshare estimate annualincome1000_HH1, over(caste) gini
pshare estimate annualincome1000_HH2, over(caste) gini
pshare estimate annualincome1000_HH3, over(caste) gini


*** Percentile share
pshare estimate annualincome1000_HH1, over(caste)
pshare stack
pshare estimate annualincome1000_HH2, over(caste) 
pshare stack
pshare estimate annualincome1000_HH3, over(caste)
pshare stack


*** GE
ineqdeco annualincome1000_HH1, by(caste)
/*
Disparité entre les castes
Within + Between = Global
Toujours within qui compte le plus.
Between sup à 10-20% 	= très important
Between inf à 5%		= négligeable
Ici, within représente 99% de l'inégalité totale
*/
ineqdeco annualincome1000_HH2, by(caste)
ineqdeco annualincome1000_HH3, by(caste)









********** Step4: Décomposition par source

*** Gini
/*
Gini n'est pas décomposable par groupe, uniquement par source
0 eq parfaite
1 ineq parfaite
*/
descogini annualincome_HH1 incomeagri_HH1 incomenonagri_HH1
sum shareincomeagri_HH1 shareincomenonagri_HH1
descogini annualincome_HH2 incomeagri_HH2 incomenonagri_HH2
sum shareincomeagri_HH2 shareincomenonagri_HH2
descogini annualincome_HH3 incomeagri_HH3 incomenonagri_HH3
sum shareincomeagri_HH3 shareincomenonagri_HH3

* En 2010, 21% de l'inégalité totale est liée aux activités agri, 79% au non-agri
* alors que agri rpz en moyenne 43% du revenu total.
* alors que non-agri rpz en moyenne 57% du revenu total.
* Donc non-agri activité inégalisatrice

* Quand Sk est inf à share, alors composante inégalisatrice

* % Change : élasticité, mais signe surtout -> si + alors inegalisatrice, si - égalisatrice






********** Step5: Profitons du panel pour voir les trajectoires indiv dans l'évolution des inégalités
/*
On va prendre le top riche en 2010, regarder l'évo entre 2010 et 2016.
On va prendre le top pauvre en 2010, regarder l'évo entre 2010 et 2016.
*/

*** Creation des quantiles
foreach i in 5 10 20 100 {
xtile income2010_q`i'=annualincome1000_HH1, n(`i')
xtile income2016_q`i'=annualincome1000_HH2, n(`i')
xtile income2020_q`i'=annualincome1000_HH3, n(`i')
}

*** Création des différences
gen diff_inc_10_16=annualincome_HH2-annualincome_HH1
gen diff_inc_16_20=annualincome_HH3-annualincome_HH2

*** Dichotomise diff
gen diff_inc_dich_10_16=.
replace diff_inc_dich_10_16=1 if diff_inc_10_16>=0
replace diff_inc_dich_10_16=2 if diff_inc_10_16<0

gen diff_inc_dich_16_20=.
replace diff_inc_dich_16_20=1 if diff_inc_16_20>=0
replace diff_inc_dich_16_20=2 if diff_inc_16_20<0

label define inc_dich 1"Increase" 2"Decrease"
label values diff_inc_dich_10_16 inc_dich
label values diff_inc_dich_16_20 inc_dich


*** Observations
ta income2010_q5 diff_inc_dich_10_16, nofreq row
/*
Parmi les 20% les plus riches de 2010, 66% ont perdu du revenu entre 2010 et 2016-17
*/
ta income2010_q10 diff_inc_dich_10_16, nofreq row

ta income2016_q5 diff_inc_dich_16_20, nofreq row


****************************************
* END














****************************************
* Ineq at indiv level
***************************************
use"panel_indiv_wide", clear


********** Step1: Desc
foreach x in annualincome1000_in1 annualincome1000_in2 annualincome1000_in3 {
replace `x'=`x'*1000/12
}
tabstat annualincome1000_in1 annualincome1000_in2 annualincome1000_in3, stat(n mean sd p50 min max)

tabstat annualincome1000_in1 annualincome1000_in2 annualincome1000_in3, stat(n mean sd q cv)

* Kernel
twoway ///
(kdensity annualincome1000_in1, bwidth(10)) ///
(kdensity annualincome1000_in2, bwidth(10)) ///
(kdensity annualincome1000_in3, bwidth(10))



********** Step2: Lorenz, Gini, percentiles share
lorenz estimate annualincome1000_in1 annualincome1000_in2 annualincome1000_in3
lorenz graph, overlay

pshare estimate annualincome1000_in1 annualincome1000_in2 annualincome1000_in3, gini
pshare stack



********** Step3: Between groups
* Decomposition by group
ineqdeco annualincome1000_in1, by(caste)
ineqdeco annualincome1000_in1, by(sex)

ineqdeco annualincome1000_in2, by(caste)
ineqdeco annualincome1000_in2, by(sex)

ineqdeco annualincome1000_in3, by(caste)
ineqdeco annualincome1000_in3, by(sex)

cls
preserve
qreg annualincome1000_in2 i.sex, q(.10)
qreg annualincome1000_in2 i.sex, q(.25)
qreg annualincome1000_in2 i.sex, q(.50) 
qreg annualincome1000_in2 i.sex, q(.75)
qreg annualincome1000_in2 i.sex, q(.90)
restore

* Gini, Lorenz
lorenz estimate annualincome1000_in1, over(caste)
lorenz graph, overlay

pshare estimate annualincome1000_in1, over(caste) total gini
pshare stack
*...


tabstat annualincome1000_in1 annualincome1000_in2 annualincome1000_in3, stat(n mean sd p50 min max) by(sex)

lorenz estimate annualincome1000_in1, over(sex)
lorenz graph, overlay

lorenz estimate annualincome1000_in2, over(sex)
lorenz graph, overlay

lorenz estimate annualincome1000_in3, over(sex)
lorenz graph, overlay






********** Step4: Decomposition by source
descogini annualincome_in1 incomeagri_in1 incomenonagri_in1
sum shareincomeagri_in1 shareincomenonagri_in1

descogini annualincome_in2 incomeagri_in2 incomenonagri_in2
sum shareincomeagri_in2 shareincomenonagri_in2

descogini annualincome_in2 incomeagri_in2 incomenonagri_in2
sum shareincomeagri_in2 shareincomenonagri_in2




********** Step5: Panel trajectory

*** Creation des quantiles
foreach i in 5 10 20 100 {
xtile income2010_q`i'=annualincome1000_in1, n(`i')
xtile income2016_q`i'=annualincome1000_in2, n(`i')
xtile income2020_q`i'=annualincome1000_in3, n(`i')
}

*** Création des différences
gen diff_inc_10_16=annualincome_in2-annualincome_in1
gen diff_inc_16_20=annualincome_in3-annualincome_in2

*** Dichotomise diff
gen diff_inc_dich_10_16=.
replace diff_inc_dich_10_16=1 if diff_inc_10_16>=0
replace diff_inc_dich_10_16=2 if diff_inc_10_16<0

gen diff_inc_dich_16_20=.
replace diff_inc_dich_16_20=1 if diff_inc_16_20>=0
replace diff_inc_dich_16_20=2 if diff_inc_16_20<0

label define inc_dich 1"Increase" 2"Decrease"
label values diff_inc_dich_10_16 inc_dich
label values diff_inc_dich_16_20 inc_dich

*** Observations
ta income2010_q5 diff_inc_dich_10_16, nofreq row
/*
Parmi les 20% les plus riches de 2010, 66% ont perdu du revenu entre 2010 et 2016-17
*/
ta income2010_q10 diff_inc_dich_10_16, nofreq row

ta income2010_q20 diff_inc_dich_10_16, nofreq row

ta income2010_q100 diff_inc_dich_10_16, nofreq row









********** Step6: Econometric decomposition
gen log_inc1000_2010=log(annualincome1000_in1)
gen log_inc1000_2016=log(annualincome1000_in2)
gen log_inc1000_2020=log(annualincome1000_in3)

gen log_inc1000_2010=log(annualincome1000_in1)

oaxaca annualincome1000_in1 age caste_2 caste_3, by(sex) noisily

ta caste, gen(caste_)

decompose annualincome1000_in1 age caste_2 caste_3, by(sex)

****************************************
* END


