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


********** Descriptive
tabstat monthlyincome2010 monthlyincome2016 monthlyincome2020, stat(n mean sd cv)
* CV de :
* 0.74 en 2010;
* 1.00 en 2016-17;
* 1.05 en 2020-21.
* Les inégalités de revenu augmentent entre 2010 et 2020-21.

/*
preserve
use"panel_HH_long", clear

twoway ///
(kdensity monthlyincome if year==2010 & monthlyincome<=100000, bwidth(2000)) ///
(kdensity monthlyincome if year==2016 & monthlyincome<=100000, bwidth(2000)) ///
(kdensity monthlyincome if year==2020 & monthlyincome<=100000, bwidth(2000)) ///
, xtitle("Monthly income per household") ytitle("Kernel density") ///
legend(order(1 "2010" 2 "2016-17" 3 "2020-21") pos(6) col(3)) note("Kernel: epanechnikov" "Bandwidth=2000", size(vsmall))
* L'étendue de la fonction de densité augmente avec les années.
* On peut donc supposer que les inégalités augmentent.

recode year (2010=1) (2016=2) (2020=3)

stripplot monthlyincome, over(year) vert ///
stack width(500) jitter(1) ///
box(barw(0.2)) boffset(-0.2) pctile(90) ///
ms(oh) msize(small) mc(black%30) ///
xmtick(0.9(0)2.5) xtitle("") ///
ytitle("Monthly income per household") xlabel(1 "2010" 2 "2016-17" 3 "2020-21",angle(0))

restore
*/


********** Indicators of inequalities

*** Quantile share ratio
foreach i in 2010 2016 2020 {
qui sum monthlyincome`i', det
gl p90p10_`i'=r(p90)/r(p10)
gl p90p50_`i'=r(p90)/r(p50)
gl p75p25_`i'=r(p75)/r(p25)
}

dis $p90p10_2010 
dis $p90p10_2016
dis $p90p10_2020

dis $p90p50_2010 
dis $p90p50_2016
dis $p90p50_2020

dis $p75p25_2010 
dis $p75p25_2016
dis $p75p25_2020


*** Percentile share
pshare estimate monthlyincome2010 monthlyincome2016 monthlyincome2020
*pshare stack
* Les 20 % les plus pauvres en 2010, détiennent 8 % des revenus totaux.

*** Gini
pshare estimate monthlyincome2010 monthlyincome2016 monthlyincome2020, gini 
* Gini passe de .32 à .44 à .49


*** Lorenz
lorenz estimate monthlyincome2010 monthlyincome2016 monthlyincome2020
*lorenz graph, overlay




********** Contribuion of transferts
* Desc
tabstat monthlyincome2010 monthlytotinc2010, stat(n mean sd cv)
tabstat monthlyincome2016 monthlytotincbis2016, stat(n mean sd cv)
tabstat monthlyincome2020 monthlytotincbis2020, stat(n mean sd cv)
* Nothing

* Gini
pshare est monthlyincome2010 monthlytotinc2010, gini
pshare est monthlyincome2016 monthlytotincbis2016, gini
pshare est monthlyincome2020 monthlytotincbis2020, gini 
* Nothing

****************************************
* END



****************************************
* What about individual level?
***************************************
use"panel_indiv_wide", clear

********** Descriptive
tabstat monthlyincome2010 monthlyincome2016 monthlyincome2020, stat(n mean sd cv)
* CV de :
* 1.05 en 2010;
* 1.61 en 2016-17;
* 1.57 en 2020-21.
* Les inégalités de revenu augmentent entre 2010 et 2020-21.
* Beaucoup plus de var que pour les HH

/*
preserve
use"panel_indiv_long", clear

twoway ///
(kdensity monthlyincome_indiv if year==2010 & monthlyincome_indiv<=60000, bwidth(1000)) ///
(kdensity monthlyincome_indiv if year==2016 & monthlyincome_indiv<=60000, bwidth(1000)) ///
(kdensity monthlyincome_indiv if year==2020 & monthlyincome_indiv<=60000, bwidth(1000)) ///
, xtitle("Monthly income per individual") ytitle("Kernel density") ///
legend(order(1 "2010" 2 "2016-17" 3 "2020-21") pos(6) col(3)) note("Kernel: epanechnikov" "Bandwidth=1000", size(vsmall))
* L'étendue de la fonction de densité augmente avec les années.
* On peut donc supposer que les inégalités augmentent.

recode year (2010=1) (2016=2) (2020=3)

stripplot monthlyincome_indiv, over(year) vert ///
stack width(500) jitter(1) ///
box(barw(0.2)) boffset(-0.2) pctile(90) ///
ms(oh) msize(small) mc(black%10) ///
xmtick(0.9(0)2.5) xtitle("") ///
ytitle("Monthly income per individual") xlabel(1 "2010" 2 "2016-17" 3 "2020-21",angle(0))
restore
*/


********** Indicators of inequalities
*** Quantile share ratio
foreach i in 2010 2016 2020 {
qui sum monthlyincome`i', det
gl p90p10_`i'=r(p90)/r(p10)
gl p90p50_`i'=r(p90)/r(p50)
gl p75p25_`i'=r(p75)/r(p25)
}

dis $p90p10_2010 
dis $p90p10_2016
dis $p90p10_2020

dis $p90p50_2010 
dis $p90p50_2016
dis $p90p50_2020

dis $p75p25_2010 
dis $p75p25_2016
dis $p75p25_2020


*** Percentile share
pshare estimate monthlyincome2010 monthlyincome2016 monthlyincome2020
*pshare stack
* Les 20 % les plus pauvres en 2010, détiennent 8 % des revenus totaux.

*** Gini
pshare estimate monthlyincome2010 monthlyincome2016 monthlyincome2020, gini 
* Gini passe de .32 à .44 à .49


*** Lorenz
lorenz estimate monthlyincome2010 monthlyincome2016 monthlyincome2020
*lorenz graph, overlay
****************************************
* END














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


