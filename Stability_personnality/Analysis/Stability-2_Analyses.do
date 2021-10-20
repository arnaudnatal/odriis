cls

/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
October 1, 2021
-----
Stability over time of personality traits: merging des bases
-----

-------------------------
*/


****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\Research-Stability_skills\Analysis"
cd"$directory"
global git "C:\Users\Arnaud\Documents\GitHub"

*Fac
*cd "C:\Users\anatal\Downloads\_Thesis\Research-Skills_and_debt\Analysis"
set scheme plotplain

*global git "C:\Users\anatal\Downloads\GitHub"
*global dropbox "C:\Users\anatal\Downloads\Dropbox"
*global thesis "C:\Users\anatal\Downloads\_Thesis\Research-Skills_and_debt\Analysis"


****************************************
* END









****************************************
* Panel 2016 2020
****************************************
use"panel_stab_v1", clear

global big5 curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts  ///
workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers ///
managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm 

global big5grit curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts  ///
workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers ///
managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm ///
tryhard  stickwithgoals   goaftergoal finishwhatbegin finishtasks  keepworking





********** Recode 1: replace 99 with missing
foreach x in $big5grit {
clonevar `x'_recode=`x'
replace `x'_recode=. if `x'_recode==99 | `x'_recode==6
}







********** Recode 2: all so that more is better! 
foreach x of varlist $big5grit {
clonevar `x'_rec_rev=`x'_recode 
recode `x'_rec_rev (5=1) (4=2) (3=3) (2=4) (1=5)
recode `x'_rec_rev (5=1) (4=2) (3=3) (2=4) (1=5)
}

label define big5n 1"5 - Almost never" 2"4 - Rarely" 3"3 - Sometimes" 4"2 - Quite often" 5"1 - Almost always"
foreach x in $big5grit {
label values `x'_rec_rev big5n
}






********** Passe-passe pour travailler
foreach x in $big5grit {
rename `x' `x'_backup 
rename `x'_rec_rev `x'
}







********** Check missings
forvalues i=16(4)20 {
mdesc $big5grit if year==20`i'
}


mdesc $big5grit if year==2020
mdesc rudetoother helpfulwithothers  ///
putoffduties completeduties /// 
easilydistracted makeplans  ///
shywithpeople talktomanypeople ///
repetitivetasks curious  ///
nervous staycalm ///  
worryalot managestress if year==2020







********** Imputation for missings
fre sex
fre caste
foreach x in $big5grit{
clonevar im`x'=`x'
}

forvalues i=1(1)2{
forvalues j=1(1)3{
forvalues k=16(4)20 {
foreach x in $big5grit{
sum im`x' if sex==`i' & caste==`j' & year==20`k'
replace im`x'=r(mean) if `x'==. & sex==`i' & caste==`j'  & year==20`k'
}
}
}
}





********** Correlation
preserve
cls 
keep if year==2016
pwcorr curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination, star(.01)
*
pwcorr organized makeplans workhard appointmentontime putoffduties easilydistracted completeduties, star(.01)
*
pwcorr enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts, star(.01)
*
pwcorr workwithother understandotherfeeling trustingofother rudetoother toleratefaults forgiveother helpfulwithothers, star(.01)
*
pwcorr managestress nervous changemood feeldepressed easilyupset worryalot  staycalm, star(.01)
*
restore

preserve 
cls
keep if year==2020
pwcorr curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination, star(.01)
*activeimagination est peut-être plus bas que les autres
pwcorr organized makeplans workhard appointmentontime putoffduties easilydistracted completeduties, star(.01)
*puttofduties pas ouf
pwcorr enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts, star(.01)
*shywithpeople
pwcorr workwithother understandotherfeeling trustingofother rudetoother toleratefaults forgiveother helpfulwithothers, star(.01)
*rudetoother
pwcorr managestress nervous changemood feeldepressed easilyupset worryalot  staycalm, star(.01)
*nothing
restore







********** Acquiescence bias measure and correction
/*
Ca fonctionne par paire.
Il n'y a pas de biais, si chaque paire à une moyenne de 3:
- soit l'indiv a répondu une fois 5 et 1
- soit l'indiv a répondu une fois 4 et 2
- soit l'indiv a répondu deux fois 3

Donc plus simplement, pour mesurer le biais moyen, par individu, nous faisons la moyenne de toutes les questions. 
Plus on s'éloigne de 3, plus le biais est important.

Cependant, il ne faut pas oublier que 3 fait office de valeur tranchante : 1 et 2 sont assez similaires, 3 est neutre et 4 et 5 sont assez similaires.
Donc un individu qui répondu 5 et 2 n'a pas vraiment de biais (ou alors 1 et 4).
Si à l'une des questions, l'individu répond 3, le biais augmente, mais n'est pas non plus très grand car il reste neutre.

Le biais devient important lorsque l'individu répond deux choses allant dans le même sens : 1 et 2 (1 et 1, 2 et 2) ou 4 et 5 (4 et 4, 5 et 5).

Pour mieux voir, on retire 3 pour avoir comme base de comparaison 0 et on passe en val abs.

Symétrie à 3

Je calcul aussi le biais par trait de personnalité
*/

local var ///
rudetoother helpfulwithothers  ///
putoffduties completeduties /// 
easilydistracted makeplans  ///
shywithpeople talktomanypeople ///
repetitivetasks curious  ///
nervous staycalm ///  
worryalot managestress 
egen ars=rowmean(`var') 
gen ars2=ars-3  
gen ars3=abs(ars2)






********** Bias by dropping pairs of questions to check the stability of the mean
local var ///
putoffduties completeduties /// 
easilydistracted makeplans  ///
shywithpeople talktomanypeople ///
repetitivetasks curious  ///
nervous staycalm ///  
worryalot managestress 
egen _1_ars=rowmean(`var') 
gen _1_ars2=_1_ars-3  
gen _1_ars3=abs(_1_ars2)

local var ///
rudetoother helpfulwithothers  ///
easilydistracted makeplans  ///
shywithpeople talktomanypeople ///
repetitivetasks curious  ///
nervous staycalm ///  
worryalot managestress 
egen _2_ars=rowmean(`var') 
gen _2_ars2=_2_ars-3  
gen _2_ars3=abs(_2_ars2)

local var ///
rudetoother helpfulwithothers  ///
putoffduties completeduties /// 
shywithpeople talktomanypeople ///
repetitivetasks curious  ///
nervous staycalm ///  
worryalot managestress 
egen _3_ars=rowmean(`var') 
gen _3_ars2=_3_ars-3  
gen _3_ars3=abs(_3_ars2)

local var ///
rudetoother helpfulwithothers  ///
putoffduties completeduties /// 
easilydistracted makeplans  ///
repetitivetasks curious  ///
nervous staycalm ///  
worryalot managestress 
egen _4_ars=rowmean(`var') 
gen _4_ars2=_4_ars-3  
gen _4_ars3=abs(_4_ars2)

local var ///
rudetoother helpfulwithothers  ///
putoffduties completeduties /// 
easilydistracted makeplans  ///
shywithpeople talktomanypeople ///
nervous staycalm ///  
worryalot managestress 
egen _5_ars=rowmean(`var') 
gen _5_ars2=_5_ars-3  
gen _5_ars3=abs(_5_ars2)

local var ///
rudetoother helpfulwithothers  ///
putoffduties completeduties /// 
easilydistracted makeplans  ///
shywithpeople talktomanypeople ///
repetitivetasks curious  ///
worryalot managestress 
egen _6_ars=rowmean(`var') 
gen _6_ars2=_6_ars-3  
gen _6_ars3=abs(_6_ars2)

local var ///
rudetoother helpfulwithothers  ///
putoffduties completeduties /// 
easilydistracted makeplans  ///
shywithpeople talktomanypeople ///
repetitivetasks curious  ///
nervous staycalm
egen _7_ars=rowmean(`var') 
gen _7_ars2=_7_ars-3  
gen _7_ars3=abs(_7_ars2)






********** Bias by trait
egen ars_AG_temp=rowmean(rudetoother helpfulwithothers)
egen ars_CO_temp=rowmean(putoffduties completeduties easilydistracted makeplans)
egen ars_EX_temp=rowmean(shywithpeople talktomanypeople)
egen ars_OP_temp=rowmean(repetitivetasks curious)
egen ars_ES_temp=rowmean(nervous staycalm worryalot managestress)

egen ars_CO1_temp=rowmean(putoffduties completeduties)
egen ars_CO2_temp=rowmean(easilydistracted makeplans)
egen ars_ES1_temp=rowmean(nervous staycalm)
egen ars_ES2_temp=rowmean(worryalot managestress)

foreach x in AG CO EX OP ES {
gen ars2_`x'=ars_`x'_temp-3
drop ars_`x'_temp
gen ars3_`x'=abs(ars2_`x')
}

foreach x in CO ES {
forvalues i=1(1)2{
gen ars2_`x'`i'=ars_`x'`i'_temp-3
drop ars_`x'`i'_temp
gen ars3_`x'`i'=abs(ars2_`x'`i')
}
}

egen ars4=rowmean(ars2_AG ars2_CO ars2_EX ars2_OP ars2_ES)
egen ars5=rowmedian(ars2_AG ars2_CO ars2_EX ars2_OP ars2_ES)


label var _1_ars "bias at 3 without pair 1 of rev question"
label var _1_ars2 "bias at 0 without pair 1 of rev question"
label var _1_ars3 "abs bias at 0 without pair 1 of rev question"
label var _2_ars "bias at 3 without pair 2 of rev question"
label var _2_ars2 "bias at 0 without pair 2 of rev question"
label var _2_ars3 "abs bias at 0 without pair 2 of rev question"
label var _3_ars "bias at 3 without pair 3 of rev question"
label var _3_ars2 "bias at 0 without pair 3 of rev question"
label var _3_ars3 "abs bias at 0 without pair 3 of rev question"
label var _4_ars "bias at 3 without pair 4 of rev question"
label var _4_ars2 "bias at 0 without pair 4 of rev question"
label var _4_ars3 "abs bias at 0 without pair 4 of rev question"
label var _5_ars "bias at 3 without pair 5 of rev question"
label var _5_ars2 "bias at 0 without pair 5 of rev question"
label var _5_ars3 "abs bias at 0 without pair 5 of rev question"
label var _6_ars "bias at 3 without pair 6 of rev question"
label var _6_ars2 "bias at 0 without pair 6 of rev question"
label var _6_ars3 "abs bias at 0 without pair 6 of rev question"
label var _7_ars "bias at 3 without pair 7 of rev question"
label var _7_ars2 "bias at 0 without pair 7 of rev question"
label var _7_ars3 "abs bias at 0 without pair 7 of rev question"

label var ars2_AG "bias at 0 for AG"
label var ars3_AG "abs bias at 0 for AG"
label var ars2_CO "bias at 0 for CO"
label var ars3_CO "abs bias at 0 for CO"
label var ars2_EX "bias at 0 for EX"
label var ars3_EX "abs bias at 0 for EX"
label var ars2_OP "bias at 0 for OP"
label var ars3_OP "abs bias at 0 for OP"
label var ars2_ES "bias at 0 for ES"
label var ars3_ES "abs bias at 0 for ES"
label var ars2_CO1 "bias at 0 for CO1"
label var ars3_CO1 "abs bias at 0 for CO1"
label var ars2_CO2 "bias at 0 for CO2"
label var ars3_CO2 "abs bias at 0 for CO2"
label var ars2_ES1 "bias at 0 for ES1"
label var ars3_ES1 "abs bias at 0 for ES1"
label var ars2_ES2 "bias at 0 for ES2"
label var ars3_ES2 "abs bias at 0 for ES2"
label var ars4 "Mean bias of bias by traits"
label var ars5 "Median bias of bias by traits"

label var ars "bias at 3"
label var ars2 "bias at 0"
label var ars3 "abs bias at 0"
 



********** Graph 
set graph off
stripplot ars3, over(time) separate(caste) ///
cumul cumprob box centre refline vertical /// 
xsize(3) xtitle("") xlabel(,angle())  ///
ylabel(0(.2)1.6) ymtick(0(.1)1.7) ytitle() ///
msymbol(oh oh oh) mcolor(plr1 plg1 ply1) name(boxplotars, replace)
graph export boxplotars.pdf, replace

forvalues i=2016(4)2020 {
stripplot ars3_AG ars3_CO ars3_CO1 ars3_CO2 ars3_EX ars3_OP ars3_ES ars3_ES1 ars3_ES2 if year==`i', over() separate(caste) ///
cumul cumprob box centre refline vertical /// 
xsize(3) xtitle("`i'") xlabel(,angle(45))  ///
ylabel(0(.2)2) ymtick(0(.1)2) ytitle("|ars|") ///
msymbol(oh oh oh) mcolor(plr1 plg1 ply1) ///
legend(pos(6) col(3)) name(boxplotars`i', replace)
graph export boxplotars`i'_det.pdf, replace
}






********** Correlation
corr ars2_AG ars2_CO ars2_EX ars2_OP ars2_ES if year==2016
corr ars2_AG ars2_CO ars2_EX ars2_OP ars2_ES if year==2020
tabstat ars3, stat(n min p1 p5 p10 q p90 p95 p99 max) by(year) long








********** Bias by enumerator
encode username, gen(username_code)

*Abs class bias
qui reg ars3 i.username_code if year==2016
est store res_2016
qui reg ars3 i.username_code if year==2020
est store res_2020

esttab res_2016 using "_reg.csv", ///
	cells("b(fmt(3)star)" "se(fmt(3)par)") /// 
	star(* 0.10 ** 0.05 *** 0.01) ///
	drop() ///
	legend label varlabels(_cons constant) ///
	stats(N r2 r2_a p, fmt(0 3 3 3) labels(`"Observations"' `"\$R^2$"' `"Adjusted \$R^2$"' `"p-value"')) ///
	replace	
	
preserve
import delimited "_reg.csv", delimiter(",") varnames(nonames) clear
qui des
sca def k=r(k)
forvalues i=1(1)`=scalar(k)'{
replace v`i'=substr(v`i',3,.)
replace v`i'=substr(v`i',1,strlen(v`i')-1)
}
export excel using "OLS_username.xlsx", sheet(Class2016,replace)
restore

esttab res_2020 using "_reg.csv", ///
	cells("b(fmt(3)star)" "se(fmt(3)par)") /// 
	star(* 0.10 ** 0.05 *** 0.01) ///
	drop() ///
	legend label varlabels(_cons constant) ///
	stats(N r2 r2_a p, fmt(0 3 3 3) labels(`"Observations"' `"\$R^2$"' `"Adjusted \$R^2$"' `"p-value"')) ///
	replace	
	
preserve
import delimited "_reg.csv", delimiter(",") varnames(nonames) clear
qui des
sca def k=r(k)
forvalues i=1(1)`=scalar(k)'{
replace v`i'=substr(v`i',3,.)
replace v`i'=substr(v`i',1,strlen(v`i')-1)
}
export excel using "OLS_username.xlsx", sheet(Class2020,replace)
restore

estimates clear


*By traits
foreach x in ars3_AG ars3_CO ars3_CO1 ars3_CO2 ars3_EX ars3_OP ars3_ES ars3_ES1 ars3_ES2 {
qui reg `x' i.username_code if year==2016
est store res_2016_`x'
qui reg `x' i.username_code if year==2020
est store res_2020_`x'
}


esttab res_2016_* using "_reg.csv", ///
	cells("b(fmt(3)star)" "se(fmt(3)par)") /// 
	star(* 0.10 ** 0.05 *** 0.01) ///
	drop() ///
	legend label varlabels(_cons constant) ///
	stats(N r2 r2_a p, fmt(0 3 3 3) labels(`"Observations"' `"\$R^2$"' `"Adjusted \$R^2$"' `"p-value"')) ///
	replace	
	
preserve
import delimited "_reg.csv", delimiter(",") varnames(nonames) clear
qui des
sca def k=r(k)
forvalues i=1(1)`=scalar(k)'{
replace v`i'=substr(v`i',3,.)
replace v`i'=substr(v`i',1,strlen(v`i')-1)
}
export excel using "OLS_username.xlsx", sheet(Traits2016,replace)
restore

esttab res_2020_* using "_reg.csv", ///
	cells("b(fmt(3)star)" "se(fmt(3)par)") /// 
	star(* 0.10 ** 0.05 *** 0.01) ///
	drop() ///
	legend label varlabels(_cons constant) ///
	stats(N r2 r2_a p, fmt(0 3 3 3) labels(`"Observations"' `"\$R^2$"' `"Adjusted \$R^2$"' `"p-value"')) ///
	replace	
	
preserve
import delimited "_reg.csv", delimiter(",") varnames(nonames) clear
qui des
sca def k=r(k)
forvalues i=1(1)`=scalar(k)'{
replace v`i'=substr(v`i',3,.)
replace v`i'=substr(v`i',1,strlen(v`i')-1)
}
export excel using "OLS_username.xlsx", sheet(Traits2020,replace)
restore
estimates clear







********** Questions on bias
cls
forvalues i=1(1)7{
ttest ars3==_`i'_ars3 if year==2016
}
*pb avec 1 (AG)
cls
forvalues i=1(1)7{
ttest ars3==_`i'_ars3 if year==2020
}
*pb avec 3 (CO2), 5 (OP) et 7 (ES2)

/*
rudetoother helpfulwithothers  // _1_--> AG
putoffduties completeduties  // _2_--> CO1
easilydistracted makeplans  // _3_--> CO2
shywithpeople talktomanypeople  // _4_--> EX
repetitivetasks curious  // _5_--> OP
nervous staycalm  // _6_--> ES1
worryalot managestress  // _7_--> ES2
*/




********** Recode 3: Reverse coded les items reverses pour que tu sois dans le même sens dans un seul et même trait: que les var tendent vers le traits pour lequel elles ont été posées

foreach x in $big5grit {
clonevar `x'_rec_rev=`x'
}
foreach x of varlist rudetoother putoffduties easilydistracted shywithpeople repetitive~s nervous changemood feeldepressed easilyupset worryalot {
recode `x' (5=1) (4=2) (3=3) (2=4) (1=5)
}
label define big5n2 5"5 - Almost never" 4"4 - Rarely" 3"3 - Sometimes" 2"2 - Quite often" 1"1 - Almost always"
foreach x in rudetoother putoffduties easilydistracted shywithpeople repetitive~s nervous changemood feeldepressed easilyupset worryalot {
label values `x' big5n2
}






log using Desc, replace text
********** Correlation
***2016
preserve
keep if year==2016
*OP
pwcorr curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination, star(.01)

*CO
pwcorr organized makeplans workhard appointmentontime putoffduties easilydistracted completeduties, star(.01)

*EX
pwcorr enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts, star(.01)

*AG
pwcorr workwithother understandotherfeeling trustingofother rudetoother toleratefaults forgiveother helpfulwithothers, star(.01)

*ES
pwcorr managestress nervous changemood feeldepressed easilyupset worryalot  staycalm, star(.01)
restore

***2020
preserve
keep if year==2020
*OP
pwcorr curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination, star(.01)

*CO
pwcorr organized makeplans workhard appointmentontime putoffduties easilydistracted completeduties, star(.01)

*EX
pwcorr enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts, star(.01)

*AG
pwcorr workwithother understandotherfeeling trustingofother rudetoother toleratefaults forgiveother helpfulwithothers, star(.01)

*ES
pwcorr managestress nervous changemood feeldepressed easilyupset worryalot  staycalm, star(.01)
restore
log close








********** Recode 4: corr from acquiescence bias
foreach x of varlist $big5grit {
gen cr_`x'=`x'-ars2 if ars!=.
gen cr2_`x'=.
*gen cr4_`x'=`x'-ars4 if ars!=.
*gen cr5_`x'=`x'-ars5 if ars!=.
}


foreach x in curious interestedbyart  repetitivetasks inventive liketothink newideas activeimagination {
replace cr2_`x'=`x'-ars2_OP if ars!=.
}
foreach x in organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties {
replace cr2_`x'=`x'-ars2_CO if ars!=.
}
foreach x in enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts {
replace cr2_`x'=`x'-ars2_EX if ars!=.
}
foreach x in workwithother understandotherfeeling trustingofother rudetoother toleratefaults forgiveother helpfulwithothers {
replace cr2_`x'=`x'-ars2_AG if ars!=.
}
foreach x in managestress nervous changemood feeldepressed easilyupset worryalot staycalm {
replace cr2_`x'=`x'-ars2_ES if ars!=.
}

foreach x of varlist $big5grit {
replace cr2_`x'=0 if cr2_`x'<0
}





********** Who have the higher bias?
*Sex
tab sex year if ars3>1, col nofreq
*Principalement des hommes

*Age
tabstat age if ars3>1, stat(n mean sd p50 min max) by(year)

*Caste
tab caste year if ars3>1, col nofreq
*Principalement des dalits







********** Test omega imput
/*
preserve
keep if year==2020
*keep if panel==1
putexcel set "omega.xlsx", modify sheet(2020_total)

***OP
omega curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination, rev(repetitivetasks)
putexcel (E2)=matrix(r(omega))
omega cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination, rev(cr_repetitivetasks) 
putexcel (E3)=matrix(r(omega))
omega cr2_curious cr2_interestedbyart cr2_repetitivetasks cr2_inventive cr2_liketothink cr2_newideas cr2_activeimagination, rev(cr2_repetitivetasks) 
putexcel (E4)=matrix(r(omega))

***CO
omega organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties, rev(putoffduties easilydistracted)
putexcel (E5)=matrix(r(omega))
omega cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties, rev(cr_putoffduties cr_easilydistracted) 
putexcel (E6)=matrix(r(omega))
omega cr2_organized cr2_makeplans cr2_workhard cr2_appointmentontime cr2_putoffduties cr2_easilydistracted cr2_completeduties, rev(cr2_putoffduties cr2_easilydistracted) 
putexcel (E7)=matrix(r(omega))

***EX
omega enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts, rev(shywithpeople) 
putexcel (E8)=matrix(r(omega))
omega cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts, rev(cr_shywithpeople) 
putexcel (E9)=matrix(r(omega))
omega cr2_enjoypeople cr2_sharefeelings cr2_shywithpeople cr2_enthusiastic cr2_talktomanypeople cr2_talkative cr2_expressingthoughts, rev(cr2_shywithpeople) 
putexcel (E10)=matrix(r(omega))

***AG
omega workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers, rev(rudetoother) 
putexcel (E11)=matrix(r(omega))
omega cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers, rev(cr_rudetoother) 
putexcel (E12)=matrix(r(omega))
omega cr2_workwithother cr2_understandotherfeeling cr2_trustingofother cr2_rudetoother cr2_toleratefaults cr2_forgiveother cr2_helpfulwithothers, rev(cr2_rudetoother) 
putexcel (E13)=matrix(r(omega))

***ES
omega managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm, rev(managestress staycalm) 
putexcel (E14)=matrix(r(omega))
omega cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot  cr_staycalm, rev(cr_managestress cr_staycalm)  
putexcel (E15)=matrix(r(omega))
omega cr2_managestress cr2_nervous cr2_changemood cr2_feeldepressed cr2_easilyupset cr2_worryalot  cr2_staycalm, rev(cr2_managestress cr2_staycalm)  
putexcel (E16)=matrix(r(omega))
restore
*/




********** Omega as data
preserve
clear all
input panel	traits	correction	year	omega
1	1	1	2016	0.864361921
1	1	2	2016	0.805783057
1	1	3	2016	0.80987671
1	2	1	2016	0.843918601
1	2	2	2016	0.848500949
1	2	3	2016	0.883629311
1	3	1	2016	0.722326272
1	3	2	2016	0.57663988
1	3	3	2016	0.803717672
1	4	1	2016	0.521202368
1	4	2	2016	0.585015614
1	4	3	2016	0.836415401
1	5	1	2016	0.497242214
1	5	2	2016	0.79321718
1	5	3	2016	0.850892239
0	1	1	2016	0.868386175
0	1	2	2016	0.811328043
0	1	3	2016	0.810829871
0	2	1	2016	0.85132604
0	2	2	2016	0.856587504
0	2	3	2016	0.889121278
0	3	1	2016	0.729188007
0	3	2	2016	0.588299672
0	3	3	2016	0.807201466
0	4	1	2016	0.510766933
0	4	2	2016	0.602029083
0	4	3	2016	0.833129231
0	5	1	2016	0.479387466
0	5	2	2016	0.801919231
0	5	3	2016	0.855408328
1	1	1	2020	0.765863028
1	1	2	2020	0.383624434
1	1	3	2020	0.747477791
1	2	1	2020	0.705388653
1	2	2	2020	0.368849752
1	2	3	2020	0.665769886
1	3	1	2020	0.643470461
1	3	2	2020	0.436589964
1	3	3	2020	0.833399312
1	4	1	2020	0.597217979
1	4	2	2020	0.30314471
1	4	3	2020	0.835737224
1	5	1	2020	0.707849376
1	5	2	2020	0.778994403
1	5	3	2020	0.828889273
0	1	1	2020	0.764244248
0	1	2	2020	0.368360137
0	1	3	2020	0.74406823
0	2	1	2020	0.70404754
0	2	2	2020	0.417065151
0	2	3	2020	0.681238123
0	3	1	2020	0.651072121
0	3	2	2020	0.448570114
0	3	3	2020	0.827102195
0	4	1	2020	0.612616194
0	4	2	2020	0.307593575
0	4	3	2020	0.845953408
0	5	1	2020	0.729498845
0	5	2	2020	0.792915118
0	5	3	2020	0.834844869

end

label define traits 1"OP" 2"CO" 3"EX" 4"AG" 5"ES"
label define panel 0"total" 1"panel"
label define correction 1"No" 2"Corr. class" 3"Corr. maison"
label values traits traits 
label values panel panel
label values correction correction


graph bar omega if panel==1, over(correction) over(year, gap(100)) over(traits) ///
bar(1, fcolor(plr1) lcolor(plr1)) ///
bar(2, fcolor(ply1) lcolor(ply1)) ///
bar(3, fcolor(plg1) lcolor(plg1)) ///
bargap(0) intensity(inten30) ///
ytitle("McDonald's Ω") ylabel(0(.1)1) ymtick(0(.05)1) ///
note("Égos en panel", size(small)) ///
legend(pos(6) col(3)) name(omega_panel, replace)
graph export omega_panel.pdf, replace

graph bar omega, over(correction) over(year, gap(100)) over(traits) ///
bar(1, fcolor(plr1) lcolor(plr1)) ///
bar(2, fcolor(ply1) lcolor(ply1)) ///
bar(3, fcolor(plg1) lcolor(plg1)) ///
bargap(0) intensity(inten30) ///
ytitle("McDonald's Ω") ylabel(0(.1)1) ymtick(0(.05)1) ///
note("Tous les égos", size(small)) ///
legend(pos(6) col(3)) name(omega_tot, replace)
graph export omega_tot.pdf, replace

restore








********** Big5 taxonomy
egen OP = rowmean(curious interestedbyart  repetitivetasks inventive liketothink newideas activeimagination)
egen CO = rowmean(organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties) 
egen EX = rowmean(enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts) 
egen AG = rowmean(workwithother understandotherfeeling trustingofother rudetoother toleratefaults forgiveother helpfulwithothers) 
egen ES = rowmean(managestress nervous changemood feeldepressed easilyupset worryalot staycalm) 
egen Grit = rowmean(tryhard stickwithgoals  goaftergoal finishwhat~n finishtasks keepworking)

egen cr_OP = rowmean(cr_curious cr_interested~t   cr_repetitive~s cr_inventive cr_liketothink cr_newideas cr_activeimag~n)
egen cr_CO = rowmean(cr_organized  cr_makeplans cr_workhard cr_appointmen~e cr_putoffduties cr_easilydist~d cr_completedu~s) 
egen cr_EX = rowmean(cr_enjoypeople cr_sharefeeli~s cr_shywithpeo~e  cr_enthusiastic  cr_talktomany~e  cr_talkative cr_expressing~s ) 
egen cr_AG = rowmean(cr_workwithot~r   cr_understand~g cr_trustingof~r cr_rudetoother cr_toleratefa~s  cr_forgiveother  cr_helpfulwit~s) 
egen cr_ES = rowmean(cr_managestress  cr_nervous  cr_changemood cr_feeldepres~d cr_easilyupset cr_worryalot  cr_staycalm) 
egen cr_Grit = rowmean(cr_tryhard  cr_stickwithg~s   cr_goaftergoal cr_finishwhat~n cr_finishtasks  cr_keepworking)

egen cr1_OP = rowmean(cr1_curious cr1_interested~t   cr1_repetitive~s cr1_inventive cr1_liketothink cr1_newideas cr1_activeimag~n)
egen cr1_CO = rowmean(cr1_organized  cr1_makeplans cr1_workhard cr1_appointmen~e cr1_putoffduties cr1_easilydist~d cr1_completedu~s) 
egen cr1_EX = rowmean(cr1_enjoypeople cr1_sharefeeli~s cr1_shywithpeo~e  cr1_enthusiastic  cr1_talktomany~e  cr1_talkative cr1_expressing~s ) 
egen cr1_AG = rowmean(cr1_workwithot~r   cr1_understand~g cr1_trustingof~r cr1_rudetoother cr1_toleratefa~s  cr1_forgiveother  cr1_helpfulwit~s) 
egen cr1_ES = rowmean(cr1_managestress  cr1_nervous  cr1_changemood cr1_feeldepres~d cr1_easilyupset cr1_worryalot  cr1_staycalm) 
egen cr1_Grit = rowmean(cr1_tryhard  cr1_stickwithg~s   cr1_goaftergoal cr1_finishwhat~n cr1_finishtasks  cr1_keepworking)

egen cr2_OP = rowmean(cr2_curious cr2_interested~t   cr2_repetitive~s cr2_inventive cr2_liketothink cr2_newideas cr2_activeimag~n)
egen cr2_CO = rowmean(cr2_organized  cr2_makeplans cr2_workhard cr2_appointmen~e cr2_putoffduties cr2_easilydist~d cr2_completedu~s) 
egen cr2_EX = rowmean(cr2_enjoypeople cr2_sharefeeli~s cr2_shywithpeo~e  cr2_enthusiastic  cr2_talktomany~e  cr2_talkative cr2_expressing~s ) 
egen cr2_AG = rowmean(cr2_workwithot~r   cr2_understand~g cr2_trustingof~r cr2_rudetoother cr2_toleratefa~s  cr2_forgiveother  cr2_helpfulwit~s) 
egen cr2_ES = rowmean(cr2_managestress  cr2_nervous  cr2_changemood cr2_feeldepres~d cr2_easilyupset cr2_worryalot  cr2_staycalm) 
egen cr2_Grit = rowmean(cr2_tryhard  cr2_stickwithg~s   cr2_goaftergoal cr2_finishwhat~n cr2_finishtasks  cr2_keepworking)

save"panel_stab_v2", replace
****************************************
* END







****************************************
* Verif des scores corrigés selon la correction effectuée
****************************************
use"panel_stab_v2", clear
cls
foreach x in OP CO EX ES AG {
tabstat `x' cr_`x' cr1_`x' cr2_`x', stat(n mean cv p50 min max) by(year)
}

save"panel_stab_v2", replace
****************************************
* END







****************************************
* INTERNAL CONSISTENCY
****************************************
use"panel_stab_v2.dta", clear

sort ars3

*Bias
gen indiv_biased=0
replace indiv_biased=1 if ars3>=1

preserve
fre panel
keep if panel==1
tab indiv_biased year
restore




********** Omega values real
/*
forvalues i=1(1)2{
putexcel set "Desc.xlsx", modify sheet(omega_`i')
preserve
keep if year==`i'
***OP
omega curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination, rev(repetitivetasks)
putexcel (C2)=matrix(r(omega))
omega cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination, rev(cr_repetitivetasks) 
putexcel (C3)=matrix(r(omega))
***CO
omega organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties, rev(putoffduties easilydistracted)
putexcel (C4)=matrix(r(omega))
omega cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties, rev(cr_putoffduties cr_easilydistracted) 
putexcel (C5)=matrix(r(omega))
***EX
omega enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts, rev(shywithpeople) 
putexcel (C6)=matrix(r(omega))
omega cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts, rev(cr_shywithpeople) 
putexcel (C7)=matrix(r(omega))
***AG
omega workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers, rev(rudetoother) 
putexcel (C8)=matrix(r(omega))
omega cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers, rev(cr_rudetoother) 
putexcel (C9)=matrix(r(omega))
***ES
omega managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm, rev(managestress staycalm) 
putexcel (C10)=matrix(r(omega))
omega cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot  cr_staycalm, rev(cr_managestress cr_staycalm)  
putexcel (C11)=matrix(r(omega))
***Grit
omega tryhard stickwithgoals goaftergoal finishwhatbegin finishtasks keepworking
putexcel (C12)=matrix(r(omega))
omega cr_tryhard cr_stickwithgoals cr_goaftergoal cr_finishwhatbegin cr_finishtasks cr_keepworking
putexcel (C13)=matrix(r(omega))
restore
}
*/


********** Excel to dta
/*
import excel "D:\Documents\_Thesis\Research-Stability_skills\Analysis\Desc.xlsx", sheet("omega_tot") firstrow clear


*Sample
replace sample="1" if sample=="panel"
replace sample="2" if sample=="total"
destring sample, replace
label define sample 1"panel" 2"total"
label values sample sample

*Traits
replace traits="1" if traits=="OP"
replace traits="2" if traits=="CO"
replace traits="3" if traits=="EX"
replace traits="4" if traits=="AG"
replace traits="5" if traits=="ES"
replace traits="6" if traits=="Grit"
destring traits, replace
label define traits 1"OP" 2"CO" 3"EX" 4"AG" 5"ES" 6"Grit"
label values traits traits

*correction
label define correction 0"No corr" 1"Corr"
label values correction correction

*rename
rename year2016 omega2016
rename year2020 omega2020

*Newbar
foreach x in sample traits correction {
decode `x', gen(`x'_str)
}
egen unique=concat(sample_str traits_str correction_str), p(_)
reshape long omega, i(unique) j(year)
drop unique sample_str traits_str correction_str


save "omega", replace
*/



********** Graph
use"omega", clear

preserve
fre sample
keep if sample==1
graph bar omega, over(correction) over(year) over(traits) blabel(bar, format(%4.2f) size(tiny)) 
restore

preserve
fre sample
keep if sample==2
graph bar omega, over(correction) over(year) over(traits) blabel(bar, format(%4.2f) size(tiny)) 
restore

****************************************
* END

