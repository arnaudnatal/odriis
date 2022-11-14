*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 23, 2021
*-----
*WSPY 2022
*-----
do "https://raw.githubusercontent.com/arnaudnatal/odriis/main/Materials/WSPY2022/WSPY22.do"
*-------------------------


*ssc install glcurve
*ssc install lorenz
*ssc install ginidesc



****************************************
* Wave 1
***************************************
use"$wave1", clear

********** Add panel id
merge m:m HHID2010 using "ODRIIS-HH_wide", keepusing(HHID_panel)
drop if _merge==2
drop _merge

merge 1:m HHID2010 INDID2010 using "ODRIIS-indiv_wide", keepusing(INDID_panel)
drop if _merge==2
drop _merge
order HHID2010 HHID_panel INDID2010 INDID_panel


********** Add income
merge 1:1 HHID2010 INDID2010 using "RUME-occup_indiv"
drop _merge

merge m:1 HHID2010 using "RUME-occup_HH"
drop _merge

********** Add assets
merge m:1 HHID2010 using "RUME-assets"
drop _merge

rename village villageid


********** Keep var
fre livinghome
drop if livinghome==0

keep HHID_panel INDID_panel name villageid villagearea mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv shareincomeagri_indiv shareincomenonagri_indiv annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop working_pop dummyworkedpastyear shareincagrise_indiv shareincagricasual_indiv shareincnonagricasual_indiv shareincnonagriregnonquali_indiv shareincnonagriregquali_indiv shareincnonagrise_indiv shareincnrega_indiv shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH

merge 1:1 HHID_panel INDID_panel using "ODRIIS-indiv_wide", keepusing(castecorr2010 agecorr2010 sex2010 relationshiptohead2010)
keep if _merge==3
drop _merge
rename sex2010 sex
rename agecorr2010 age
rename relationshiptohead2010 relationshiptohead
rename castecorr2010 caste
gen year=2010

order HHID_panel INDID_panel year name age sex relationshiptohead caste villageid villagearea

fre villageid

recode villageid (6=7) (7=6)

save"wave1", replace
****************************************
* END







****************************************
* Wave 2
***************************************
use"$wave2", clear


********** Add panel id
merge m:m HHID2016 using "ODRIIS-HH_wide", keepusing(HHID_panel)
drop if _merge==2
drop _merge

tostring INDID2016, replace
merge 1:m HHID2016 INDID2016 using "ODRIIS-indiv_wide", keepusing(INDID_panel)
drop if _merge==2
drop _merge
order HHID2016 HHID_panel INDID2016 INDID_panel


********** Add income
destring INDID2016, replace
merge 1:1 HHID2016 INDID2016 using "NEEMSIS1-occup_indiv"
drop _merge

merge m:1 HHID2016 using "NEEMSIS1-occup_HH"
drop _merge

********** Add assets
merge m:1 HHID2016 using "NEEMSIS1-assets"
drop _merge


********** Keep var
fre livinghome
drop if livinghome==3 | livinghome==4

keep HHID_panel INDID_panel name villageid villagearea mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv shareincomeagri_indiv shareincomenonagri_indiv annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop working_pop dummyworkedpastyear shareincagrise_indiv shareincagricasual_indiv shareincnonagricasual_indiv shareincnonagriregnonquali_indiv shareincnonagriregquali_indiv shareincnonagrise_indiv shareincnrega_indiv shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH

merge 1:1 HHID_panel INDID_panel using "ODRIIS-indiv_wide", keepusing(castecorr2016 agecorr2016 sex2016 relationshiptohead2016)
keep if _merge==3
drop _merge
rename sex2016 sex
rename agecorr2016 age
rename relationshiptohead2016 relationshiptohead
rename castecorr2016 caste
gen year=2016

order HHID_panel INDID_panel year name age sex relationshiptohead caste villageid villagearea

fre villageid


save"wave2", replace
****************************************
* END








****************************************
* Wave 3
***************************************
use"$wave3", clear

********** Add panel id
merge m:m HHID2020 using "ODRIIS-HH_wide", keepusing(HHID_panel)
drop if _merge==2
drop _merge

tostring INDID2020, replace
merge 1:m HHID2020 INDID2020 using "ODRIIS-indiv_wide", keepusing(INDID_panel)
drop if _merge==2
drop _merge
order HHID2020 HHID_panel INDID2020 INDID_panel


********** Add income
destring INDID2020, replace
merge 1:1 HHID2020 INDID2020 using "NEEMSIS2-occup_indiv"
drop _merge

merge m:1 HHID2020 using "NEEMSIS2-occup_HH"
drop _merge

********** Add assets
merge m:1 HHID2020 using "NEEMSIS2-assets"
drop _merge


********** Keep var
fre livinghome
drop if livinghome==3 | livinghome==4
drop if dummylefthousehold==1

keep HHID_panel INDID_panel name villageid villagearea mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv shareincomeagri_indiv shareincomenonagri_indiv annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop working_pop dummyworkedpastyear shareincagrise_indiv shareincagricasual_indiv shareincnonagricasual_indiv shareincnonagriregnonquali_indiv shareincnonagriregquali_indiv shareincnonagrise_indiv shareincnrega_indiv shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH

merge 1:1 HHID_panel INDID_panel using "ODRIIS-indiv_wide", keepusing(castecorr2020 agecorr2020 sex2020 relationshiptohead2020)
keep if _merge==3
drop _merge
rename sex2020 sex
rename agecorr2020 age
rename relationshiptohead2020 relationshiptohead
rename castecorr2020 caste
gen year=2020

order HHID_panel INDID_panel year name age sex relationshiptohead caste villageid villagearea

fre villageid

save"wave3", replace
****************************************
* END









****************************************
* Panel
***************************************
use"wave2", clear

append using "wave1"
append using "wave3"

*Deflate
foreach x in mainocc_annualincome_indiv annualincome_indiv annualincome_HH assets assets_noland assets_noprop assets1000 assets1000_noland incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH assets1000_noprop{
replace `x'=`x'*(100/158) if year==2016
replace `x'=`x'*(100/184) if year==2020
}

replace caste="1" if caste=="Dalits"
replace caste="2" if caste=="Middle"
replace caste="3" if caste=="Upper"
destring caste, replace
label define caste 1"Dalits" 2"Middle" 3"Upper"
label values caste caste

save"panel_indiv", replace

keep HHID_panel year caste villageid villagearea annualincome_HH shareincomeagri_HH shareincomenonagri_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH
duplicates drop
ta year


*1000
gen annualincome1000_HH=annualincome_HH/1000

* Recode
replace year=1 if year==2010
replace year=2 if year==2016
replace year=3 if year==2020
sort HHID_panel year

*** Reshape
reshape wide villageid annualincome_HH shareincomeagri_HH shareincomenonagri_HH shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH nbworker_HH nbnonworker_HH assets assets_noland assets_noprop assets1000 assets1000_noland assets1000_noprop annualincome1000_HH incomeagri_HH incomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH, i(HHID_panel) j(year)

order HHID_panel caste villageid1 villageid2 villageid3
gen villageid=.
replace villageid=villageid1 if villageid==. & villageid1!=.
replace villageid=villageid2 if villageid==. & villageid2!=.
replace villageid=villageid3 if villageid==. & villageid3!=.
label values villageid villageid
order HHID_panel caste villageid villageid1 villageid2 villageid3
sort villageid HHID_panel
drop villageid1 villageid2 villageid3


save"panel_HH", replace
****************************************
* END













****************************************
* Ineq at HH level
***************************************
use"panel_HH", clear

/*
- IQR

- Gini
Décomposable par source

- Entropie
Mesure l'état de désordre d'un système
Plus alpha est faible, plus GE sensible à des différences
de revenu dans le bas de la distribution
GE(0) = Theil L
GE(1) = Theil T -> If everyone has the same income, equals 0: plus haut plus inégalités 
GE(2) = Moitité du coefficient de variation au carré
Décomposable par groupe : inégalité totale peut être décomposée en une composante d’inégalité intragroupe et une composante d’inégalité intergroupe


- Atkinson
Range between 0 and 1 (0% and 100%), where 0 indicates perfect equality and 1 (100%) indicates maximum inequality.

*/




********** General ineq of income

***** Kernel
twoway ///
(kdensity annualincome1000_HH1, bwidth(20)) ///
(kdensity annualincome1000_HH2, bwidth(20)) ///
(kdensity annualincome1000_HH3, bwidth(20))
* L'étendue de la fonction de densité augmente avec les années.
* On peut donc supposer que les inégalités augmentent.



**** Boxplot
graph box annualincome1000_HH1 annualincome1000_HH2 annualincome1000_HH3
* On voit que la boite est de plus en plus grande, ce qui signifie que l'IQR est de plus en plus grand, donc que les inégalités augmentent.



***** IQR
tabstat annualincome1000_HH1 annualincome1000_HH2 annualincome1000_HH3, stat(p1 p5 p10 q p90 p95 p99)
dis 98/45
dis 123.37/39.87
dis 138.96/36.28
* Rapport de :
* 2.2 en 2010;
* 3.1 en 2016-17;
* 3.8 en 2020-21.
* L'écart entre les plus riches et les plus pauvres se creuse.
ineqdeco annualincome1000_HH1
ineqdeco annualincome1000_HH2
ineqdeco annualincome1000_HH3
* Also compute percentile ratios



***** CV
tabstat annualincome1000_HH1 annualincome1000_HH2 annualincome1000_HH3, stat(n mean sd cv)
* CV de :
* 0.74 en 2010;
* 1.00 en 2016-17;
* 1.05 en 2020-21.
* Les inégalités de revenu augmentent entre 2010 et 2020-21.



***** Lorenz
lorenz estimate annualincome1000_HH1 annualincome1000_HH2 annualincome1000_HH3
lorenz graph, overlay



***** Gini
pshare estimate annualincome1000_HH1 annualincome1000_HH2 annualincome1000_HH3, gini 


***** Percentile share
pshare estimate annualincome1000_HH1 annualincome1000_HH2 annualincome1000_HH3, gini 
*.0792672
* Les 20 % les plus pauvres en 2010, détiennent 8 % des revenus totaux.
pshare stack
*pshare histogram
* Gini passe de .32 à .44 à .49



***** GE
ineqdeco annualincome1000_HH1
*Theil de 0.18895




***** Est-ce que les riches sont plus riches et les pauvres plus pauvres ?
foreach i in 5 10 {
xtile income2010_q`i'=annualincome1000_HH1, n(`i')
xtile income2016_q`i'=annualincome1000_HH2, n(`i')
xtile income2020_q`i'=annualincome1000_HH3, n(`i')
}

gen diff_inc_10_16=annualincome_HH2-annualincome_HH1
gen diff_inc_16_20=annualincome_HH3-annualincome_HH2

tabstat diff_inc_10_16 if income2010_q5==5, stat(n mean sd p50 min max)








********** Decomposition par groupe

***** GE -> role des castes
ineqdeco annualincome1000_HH1, by(caste)
/*
Disparité entre les castes
Within + Between = Global
Toujours within qui compte le plus.
Between sup à 10-20% 	= très important
Between inf à 5%		= négligeable

Ici, within représente 99% de l'inégalité totale
*/



***** GE -> role des villages
ineqdeco annualincome1000_HH1, by(villageid)




***** Inégalités entre les castes
tabstat annualincome1000_HH1, stat(n mean sd q cv) by(caste)
dis 96/44
dis 95/46
dis 116/44
* IQR :
* 2.2 pour les dalits en 2010;
* 2.1 pour les middles en 2010
* 2.6 pour les uppers en 2010.
* Same with CV.
* En 2010, il y a plus d'inégalités au sein des uppers que des autres.

* Kernel
twoway ///
(kdensity annualincome1000_HH1 if caste==1, bwidth(30)) ///
(kdensity annualincome1000_HH1 if caste==2, bwidth(30)) ///
(kdensity annualincome1000_HH1 if caste==3, bwidth(30))

* Lorenz
lorenz estimate annualincome1000_HH1, over(caste)
lorenz graph, overlay
* IC à 5%, les 3 distributions se regroupent : pas plus d'inégalités chez les uppers que chez les dalits et les middle.

* pshare
pshare estimate annualincome1000_HH1, over(caste) total gini








gen test=annualincome_HH1-incomeagri_HH1-incomenonagri_HH1


********** Décomposition par source

***** Gini -> role des revenus agri
/*
Gini n'est pas décomposable par groupe, uniquement par source
0 eq parfaite
1 ineq parfaite
*/
descogini annualincome_HH1 incomeagri_HH1 incomenonagri_HH1
descogini annualincome_HH2 incomeagri_HH2 incomenonagri_HH2
descogini annualincome_HH3 incomeagri_HH3 incomenonagri_HH3

* En 2010, 21% de l'inégalité totale est liée aux activités agri, 79% au non-agri
* Mettre en perspective avec la part de l'agri et du non-agri dans les revenus.

* Quand Sk est inf à share, alors composante inégalisatrice
/*

share = part de la compo dans l'inégalité totale
28% de l'inega tota est lié au rev agri
donc 72% rev non agri
On compare ca avec Sk
on voit que Sk pour agri = 0.39 donc Sk pour non agri = 0.61
on voit donc que la part dans l'inéga est sup à celle du rev donc
la composante rev non agri est inégalisatrice

si le rev agri augmente de 1% le Gini va baisser de 11% 
% change s'interprete comme une élasticité donc c'est surtout le signe
qui importe, si + alors inégalisatrice si - égalisatrice
*/



****************************************
* END
