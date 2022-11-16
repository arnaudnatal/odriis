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



/*
********** Contribution of transferts
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
*/




********** Décomposition par source
descogini annualincome2010 incomeagri2010 incomenonagri2010
sum shareincomeagri2010 shareincomenonagri2010

descogini annualincome2016 incomeagri2016 incomenonagri2016
sum incomeagri2016 incomenonagri2016

descogini annualincome2020 incomeagri2020 incomenonagri2020
sum shareincomeagri2020 shareincomenonagri2020

* En 2010, 21% de l'inégalité totale est liée aux activités agri, 79% au non-agri
* alors que agri rpz en moyenne 43% du revenu total.
* alors que non-agri rpz en moyenne 57% du revenu total.
* Donc non-agri activité inégalisatrice

* Quand Sk est inf à share, alors composante inégalisatrice
* % Change : élasticité, mais signe surtout -> si + alors inegalisatrice, si - égalisatrice





********** Inégalités entre les castes
foreach i in 2010 2016 2020 {
stripplot monthlyincome`i', over(caste) vert ///
stack width(500) jitter(1) ///
box(barw(0.2)) boffset(-0.2) pctile(90) ///
ms(oh) msize(small) mc(black%30) ///
xmtick(0.9(0)2.5) xtitle("") ///
ytitle("Monthly income per household in `i'") xlabel(1 "Dalits" 2 "Middle castes" 3 "Upper castes",angle(0)) name(binccaste_`i', replace)
}

/*
En 2010 : Il semble qu'il y a plus d'inégalités au sein des castes élevés (la boite est plus haute)
De plus, la boite est légèrement au dessus des autres, donc les upper castes sont plus riches


En 2016-17 : Boite middle et upper à peu près la même taille et plus grandes que dalits, donc plus d'inégalités chez les middle et upper que chez les dalits
De plus, boite middle au dessus de dalits et boite upper au dessus de middle
Donc inégalités de revenus en faveurs des uppers et en défaveur des dalits

En 2020-21 : la tendance de 2016-17 se poursuit
*/



****************************************
* END







****************************************
* What about individual level?
***************************************
use"panel_indiv_wide", clear

********** Descriptive
tabstat monthlyincome2010 monthlyincome2016 monthlyincome2020, stat(n mean sd cv min max)
* CV de :
* 1.05 en 2010;
* 1.55 en 2016-17;
* 1.50 en 2020-21.
* Les inégalités de revenu augmentent entre 2010 et 2020-21.
* Beaucoup plus de var que pour les HH


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
* Les 20 % les plus pauvres en 2010, détiennent 4 % des revenus totaux.
* Les 20 % les plus pauvres en 2016-17, détiennent 1.7 % des revenus totaux.
* Les 20 % les plus pauvres en 2020-21, détiennent 2 % % des revenus totaux.


*** Gini
pshare estimate monthlyincome2010 monthlyincome2016 monthlyincome2020, gini 
* Gini passe de .44 à .58 à .57





********** Commentaires
/*
On voit donc qu'il y a beaucoup plus d'inégalités entre les individus plutôt qu'entre les ménages.
Une des principales raisons ?
À l'échelle des ménages, les inégalités entre les sexes sont lissées
*/

foreach i in 2010 2016 2020 {
twoway ///
(kdensity monthlyincome2020 if sex==1 & monthlyincome`i'<=100000, bwidth(2000)) ///
(kdensity monthlyincome2020 if sex==2 & monthlyincome`i'<=100000, bwidth(2000)) ///
, xtitle("Monthly income per individual in `i'") ytitle("Kernel density") ///
legend(order(1 "Male" 2 "Female") pos(6) col(3)) note("Kernel: epanechnikov" "Bandwidth=2000", size(vsmall)) name(kinc_`i', replace)
}

foreach i in 2010 2016 2020 {
stripplot monthlyincome`i', over(sex) vert ///
stack width(500) jitter(1) ///
box(barw(0.2)) boffset(-0.2) pctile(90) ///
ms(oh) msize(small) mc(black%30) ///
xmtick(0.9(0)2.5) xtitle("") ///
ytitle("Monthly income per individual in `i'") xlabel(1 "Male" 2 "Female",angle(0)) ///
name(binc_`i', replace)
}

/*
Poussons un peu pour regarder le gender gap de revenu entre les hommes et femmes
*/
****************************************
* END










****************************************
* Decomposition
***************************************
use"wave3", clear

********** Clean
fre egoid
drop if egoid==0

ta caste, gen(caste_)
ta edulevel, gen(edulevel_)

fre sex
replace sex="1" if sex=="Male"
replace sex="2" if sex=="Female"
destring sex, replace
label define sex 1"Male" 2"Female"
label values sex sex
replace sex=sex-1
fre sex

destring age, replace

drop if mainocc_annualincome_indiv==0
drop if mainocc_annualincome_indiv==.


********** Decomposition
decompose mainocc_annualincome_indiv age caste_2 caste_3 edulevel_2 edulevel_3 edulevel_4 edulevel_5 edulevel_6 mainocc_tenureday_indiv, by(sex)

decompose mainocc_annualincome_indiv age caste_2 caste_3 edulevel_2 edulevel_3 edulevel_4 edulevel_5 edulevel_6 mainocc_tenureday_indiv raven_tt num_tt lit_tt, by(sex)

decompose mainocc_annualincome_indiv age caste_2 caste_3 edulevel_2 edulevel_3 edulevel_4 edulevel_5 edulevel_6 mainocc_tenureday_indiv raven_tt num_tt lit_tt cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit, by(sex)

decompose mainocc_annualincome_indiv age caste_2 caste_3 edulevel_2 edulevel_3 edulevel_4 edulevel_5 edulevel_6 mainocc_tenureday_indiv raven_tt num_tt lit_tt locus, by(sex)

decompose mainocc_annualincome_indiv age caste_2 caste_3 edulevel_2 edulevel_3 edulevel_4 edulevel_5 edulevel_6 mainocc_tenureday_indiv raven_tt num_tt lit_tt cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit locus, by(sex)




****************************************
* END


