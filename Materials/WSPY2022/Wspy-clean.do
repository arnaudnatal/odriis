*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 23, 2021
*-----
gl link = "psychodebt"
*Stab
*-----
do "https://raw.githubusercontent.com/arnaudnatal/folderanalysis/main/$link.do"
*-------------------------







****************************************
* PANEL
***************************************
use"$directory\\$wave2", clear
duplicates drop HHID_panel, force
keep HHID_panel year
rename year year2016
save"$wave2~hh", replace

use"$directory\\$wave3", clear
duplicates drop HHID_panel, force
keep HHID_panel year
rename year year2020
save"$wave3~hh", replace

*Merge all
use"$wave2~hh", clear
merge 1:1 HHID_panel using "$wave3~hh"
rename _merge merge_1620

*One var
gen panel=0
replace panel=2 if year2016!=. & year2020!=.
tab panel

keep HHID_panel year2016 year2020 panel

foreach x in 2016 2020{
recode year`x' (.=0) (`x'=1)
}

*
tab year2016
tab year2020
tab year2016 year2020   // 485 en panel 2016-2020

save"panel", replace
****************************************
* END


/*



****************************************
* PREPA
****************************************

********** 2016 prépa
use "$wave2", clear
keep if egoid>0
egen HHINDID=concat(HHID_panel INDID_panel), p(/)
duplicates tag HHINDID, gen(tag)
tab tag

sort lit_tt

save"$wave2~ego", replace


********** 
use"$wave3", clear
/*
global big5 ///
curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts  ///
workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers ///
managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm ///
tryhard  stickwithg~s   goaftergoal finishwhat~n finishtasks  keepworking ars ars2 ars3
*/
merge m:1 HHID_panel using "panel", nogen keep(3)
keep if egoid>0


********** Rename 2020 perso
foreach x in cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit OP CO EX AG ES Grit lit_tt num_tt raven_tt age ars ars2 ars3{
rename `x' `x'_2020
}


********** Merge with 2016 values
merge 1:1 HHID_panel INDID_panel using "$wave2~ego", keepusing (cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit OP CO EX AG ES Grit lit_tt num_tt raven_tt age ars ars2 ars3)


**********Cognitive skills
cls
tab1 raven_tt raven_tt_2020 lit_tt lit_tt_2020 num_tt num_tt_2020
*Dénominateur commun pour num: 12
replace num_tt=num_tt*3
replace num_tt_2020=num_tt_2020*2
tab1 num_tt num_tt_2020

foreach x in lit_tt raven_tt num_tt {
gen diff_`x'=`x'_2020-`x'
tab diff_`x'
}

*** Decreasing
foreach x in lit_tt num_tt raven_tt {
gen dec_`x'=1 if diff_`x'!=.
}
replace dec_lit_tt=0 if diff_lit_tt>=-1 & diff_lit_tt!=.
replace dec_num_tt=0 if diff_num_tt>=-2 & diff_num_tt!=.
replace dec_raven_tt=0 if diff_raven_tt>=-4 & diff_raven_tt!=.

tab1 dec_lit_tt dec_num_tt dec_raven_tt 
/*
lit = 109/651
num = 116/808
rav = 362/835
*/
*Is for those who have one decrease, everything decrease?
egen nbdec=rowtotal(dec_lit_tt dec_num_tt dec_raven_tt)
replace nbdec=. if dec_raven_tt==.
tab nbdec
/*
      nbdec |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |        403       48.26       48.26
          1 |        297       35.57       83.83
          2 |        115       13.77       97.60
          3 |         20        2.40      100.00
------------+-----------------------------------
      Total |        835      100.00
*/
tabstat age, stat(n mean sd p50 min max) by(nbdec)
drop diff_raven_tt diff_num_tt diff_lit_tt
*** Categories
foreach x in raven_tt num_tt lit_tt{
gen delta_`x'=((`x'_2020-`x')*100/`x')
gen diff_`x'=`x'_2020-`x'
gen absdelta_`x'=abs(delta_`x')
gen absdiff_`x'=abs(diff_`x')
gen cat_diff_`x'=0 if _merge==3
}
*Raven
replace cat_diff_raven_tt=1 if diff_raven_tt<=-36 & cat_diff_raven_tt==0  
replace cat_diff_raven_tt=2 if diff_raven_tt<=-14.4 & diff_raven_tt>-36 & cat_diff_raven_tt==0  
replace cat_diff_raven_tt=3 if diff_raven_tt<=-7.2 & diff_raven_tt>-14.4 & cat_diff_raven_tt==0 
replace cat_diff_raven_tt=4 if diff_raven_tt<=-3.6 & diff_raven_tt>-7.2 & cat_diff_raven_tt==0 
replace cat_diff_raven_tt=5 if diff_raven_tt>-3.6 & diff_raven_tt<3.6 & cat_diff_raven_tt==0
replace cat_diff_raven_tt=6 if diff_raven_tt>=3.6 & diff_raven_tt<7.2 & cat_diff_raven_tt==0
replace cat_diff_raven_tt=7 if diff_raven_tt>=7.2 & diff_raven_tt<14.4 & cat_diff_raven_tt==0
replace cat_diff_raven_tt=8 if diff_raven_tt>=14.4 & diff_raven_tt<36 & cat_diff_raven_tt==0
replace cat_diff_raven_tt=9 if diff_raven_tt>=2 & cat_diff_raven_tt==0
replace cat_diff_raven_tt=. if diff_raven_tt==.
*Num
replace cat_diff_num_tt=1 if diff_num_tt<=-6 & cat_diff_num_tt==0  
replace cat_diff_num_tt=2 if diff_num_tt<=-2.4 & diff_num_tt>-6 & cat_diff_num_tt==0  
replace cat_diff_num_tt=3 if diff_num_tt<=-1.2 & diff_num_tt>-2.4 & cat_diff_num_tt==0 
replace cat_diff_num_tt=4 if diff_num_tt<=-0.6 & diff_num_tt>-1.2 & cat_diff_num_tt==0 
replace cat_diff_num_tt=5 if diff_num_tt>-0.6 & diff_num_tt<0.6 & cat_diff_num_tt==0
replace cat_diff_num_tt=6 if diff_num_tt>=0.6 & diff_num_tt<1.2 & cat_diff_num_tt==0
replace cat_diff_num_tt=7 if diff_num_tt>=1.2 & diff_num_tt<2.4 & cat_diff_num_tt==0
replace cat_diff_num_tt=8 if diff_num_tt>=2.4 & diff_num_tt<6 & cat_diff_num_tt==0
replace cat_diff_num_tt=9 if diff_num_tt>=6 & cat_diff_num_tt==0
replace cat_diff_num_tt=. if diff_num_tt==.
*Lit
replace cat_diff_lit_tt=1 if diff_lit_tt<=-4 & cat_diff_lit_tt==0  
replace cat_diff_lit_tt=2 if diff_lit_tt<=-1.6 & diff_lit_tt>-4 & cat_diff_lit_tt==0  
replace cat_diff_lit_tt=3 if diff_lit_tt<=-0.8 & diff_lit_tt>-1.6 & cat_diff_lit_tt==0 
replace cat_diff_lit_tt=4 if diff_lit_tt<=-0.4 & diff_lit_tt>-0.8 & cat_diff_lit_tt==0 
replace cat_diff_lit_tt=5 if diff_lit_tt>-0.4 & diff_lit_tt<0.4 & cat_diff_lit_tt==0
replace cat_diff_lit_tt=6 if diff_lit_tt>=0.4 & diff_lit_tt<0.8 & cat_diff_lit_tt==0
replace cat_diff_lit_tt=7 if diff_lit_tt>=0.8 & diff_lit_tt<1.6 & cat_diff_lit_tt==0
replace cat_diff_lit_tt=8 if diff_lit_tt>=1.6 & diff_lit_tt<4 & cat_diff_lit_tt==0
replace cat_diff_lit_tt=9 if diff_lit_tt>=4 & cat_diff_lit_tt==0
replace cat_diff_lit_tt=. if diff_lit_tt==.
label define varcat 1"[-1;-0.5]" 2"]-0.5;-0.2]" 3"]-0.2;-0.1]" 4"]-0.1;-0.05]" 5"]-0.05;0.05[" 6"[0.05;0.1[" 7"[0.1;0.2[" 8"[0.2;0.5[" 9"[0.5;1]", replace
label values cat_diff_raven_tt varcat
label values cat_diff_num_tt varcat
label values cat_diff_lit_tt varcat



********** Personality traits
foreach x in cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit OP CO EX AG ES Grit ars ars2 ars3{
gen delta_`x'=((`x'_2020-`x')*100/`x')
gen diff_`x'=`x'_2020-`x'
gen absdelta_`x'=abs(delta_`x')
gen absdiff_`x'=abs(diff_`x')
gen cat_diff_`x'=0 if _merge==3
}

foreach x in diff_cr_OP diff_cr_CO diff_cr_EX diff_cr_AG diff_cr_ES diff_cr_Grit diff_OP diff_CO diff_EX diff_AG diff_ES diff_Grit {
replace cat_`x'=1 if `x'<=-2 & cat_`x'==0  // 				]-inf;-50]
replace cat_`x'=2 if `x'<=-0.8 & `x'>-2 & cat_`x'==0  // 	]-50;-20]
replace cat_`x'=3 if `x'<=-0.4 & `x'>-0.8 & cat_`x'==0 //		]-20;-10]
replace cat_`x'=4 if `x'<=-0.2 & `x'>-0.4 & cat_`x'==0 // 		]-10;-5]

replace cat_`x'=5 if `x'>-0.2 & `x'<0.2 & cat_`x'==0 //		]-5;5[

replace cat_`x'=6 if `x'>=0.2 & `x'<0.4 & cat_`x'==0 //			[5;10[
replace cat_`x'=7 if `x'>=0.4 & `x'<0.8 & cat_`x'==0
replace cat_`x'=8 if `x'>=0.8 & `x'<2 & cat_`x'==0
replace cat_`x'=9 if `x'>=2 & cat_`x'==0

replace cat_`x'=. if `x'==.

label values cat_`x' varcat

}

********* Age
gen agecat1=0 		if age_2020<=34
replace agecat1=1 	if age_2020>34 & age_2020!=.
label define age 0"];30] 2016-17" 1"]30;[ 2016-17"
label values agecat1 age

*scatter
set scheme plottig
gen age_2016=age_2020-4
twoway (scatter diff_raven_tt age_2016 if sex==1 & diff_raven_tt<0) 
twoway (scatter diff_raven_tt age_2016 if sex==2 & diff_raven_tt<0)

twoway (scatter diff_raven_tt age_2016 if caste==1 & diff_raven_tt<0)
twoway (scatter diff_raven_tt age_2016 if caste==2 & diff_raven_tt<0)
twoway (scatter diff_raven_tt age_2016 if caste==3 & diff_raven_tt<0)



****************************************
* END















****************************************
* BIAS
****************************************
set graph off
twoway ///
(kdensity ars3, bwidth(0.15)) ///
(kdensity ars3_2020, bwidth(0.15)) ///
, xtitle("Acquiesence bias", size(small)) xlabel(0(0.25)1.75, labsize(vsmall)) legend(order(1 "2016-17" 2 "2020-21") pos(6) col(2)) ytitle("Density", size(small)) ylabel(,labsize(small)) note("Kernel epanechnikov with bandwidth=0.15", size(tiny))
graph save "$git\Analysis\Personality\Big-5\kernel_ars.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\kernel_ars.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\kernel_ars.pdf", as(pdf) replace
set graph on

*** Kernel over sex caste and age per year
set graph off
twoway (kdensity ars3 if sex==1, bwidth(0.15)) (kdensity ars3 if sex==2, bwidth(0.15)) ///
, title("2016-17", size(medium)) xtitle("Acquiesence bias", size(small)) xlabel(0(0.25)1.75, labsize(vsmall)) legend(order(1 "Male" 2 "Female") pos(6) col(1) off) ytitle("Density", size(small)) ylabel(,labsize(small)) name(g1, replace)
twoway (kdensity ars3_2020 if sex==1, bwidth(0.15)) (kdensity ars3_2020 if sex==2, bwidth(0.15)) ///
, title("2020-21", size(medium)) xtitle("Acquiesence bias", size(small)) xlabel(0(0.25)1.75, labsize(vsmall)) legend(order(1 "Male" 2 "Female") pos(6) col(1)) ytitle("Density", size(small)) ylabel(,labsize(small))  name(g2, replace)

twoway (kdensity ars3 if caste==1, bwidth(0.15)) (kdensity ars3 if caste==2, bwidth(0.15)) (kdensity ars3 if caste==3, bwidth(0.15)) ///
, xtitle("Acquiesence bias", size(small)) xlabel(0(0.25)1.75, labsize(vsmall)) legend(order(1 "Dalits" 2 "Middle" 3 "Upper") pos(6) col(1) off) ytitle("Density", size(small)) ylabel(,labsize(small)) name(g3, replace)
twoway (kdensity ars3_2020 if caste==1, bwidth(0.15)) (kdensity ars3_2020 if caste==2, bwidth(0.15)) (kdensity ars3_2020 if caste==3, bwidth(0.15)) ///
, xtitle("Acquiesence bias", size(small)) xlabel(0(0.25)1.75, labsize(vsmall)) legend(order(1 "Dalits" 2 "Middle" 3 "Upper") pos(6) col(1)) ytitle("Density", size(small)) ylabel(,labsize(small)) name(g4, replace)

twoway (kdensity ars3 if caste==1, bwidth(0.15)) (kdensity ars3 if caste==2, bwidth(0.15)) ///
, xtitle("Acquiesence bias", size(small)) xlabel(0(0.25)1.75, labsize(vsmall)) legend(order(1 "];30] 2016-17" 2 "]30;[ 2016-17") pos(6) col(1) off) ytitle("Density", size(small)) ylabel(,labsize(small)) name(g5, replace)
twoway (kdensity ars3_2020 if agecat1==0, bwidth(0.15)) (kdensity ars3_2020 if agecat1==1, bwidth(0.15)) ///
, xtitle("Acquiesence bias", size(small)) xlabel(0(0.25)1.75, labsize(vsmall)) legend(order(1 "];30] 2016-17" 2 "]30;[ 2016-17") pos(6) col(1)) ytitle("Density", size(small)) ylabel(,labsize(small)) name(g6, replace)

grc1leg g1 g2, name(comb1, replace) pos(3)
grc1leg g3 g4, name(comb2, replace) pos(3)
grc1leg g5 g6, name(comb3, replace) pos(3)

graph combine comb1 comb2 comb3, col(1) xcommon note("Kernel epanechnikov with bandwidth=0.15", size(tiny))
graph save "$git\Analysis\Personality\Big-5\kernel_ars_sub.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\kernel_ars_sub.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\kernel_ars_sub.pdf", as(pdf) replace
set graph on



*** Line
pctile ars3_p=ars3, n(20)
pctile ars3_2020_p=ars3_2020, n(20)
gen n=_n*5
replace n=. if n>100

set graph off
twoway (line ars3_p n) (line ars3_2020_p n), xtitle("Percentage of population", size(small)) xlabel(0(10)100, labsize(vsmall)) xmtick(0(5)100) legend(order(1 "2016-17" 2 "2020-21") pos(6) col(2)) ytitle("Acquiesence bias", size(small)) ylabel(0(0.1)1.1, labsize(vsmall)) ymtick(0(0.05)1.1)
graph save "$git\Analysis\Personality\Big-5\curve_ars.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\curve_ars.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\curve_ars.pdf", as(pdf) replace
set graph on

drop n ars3_p ars3_2020_p

*** Variation
gen pathars=.
replace pathars=1 if ars3>=0.5 & ars3_2020>=0.5 & ars3!=. & ars3_2020!=.  // tjrs
replace pathars=2 if ars3<0.5 & ars3_2020>=0.5 & ars3!=. & ars3_2020!=.  // devenu
replace pathars=3 if ars3>=0.5 & ars3_2020<0.5 & ars3!=. & ars3_2020!=.  // sort
replace pathars=4 if ars3<0.5 & ars3_2020<0.5 & ars3!=. & ars3_2020!=.  // jamais
tab pathars sex

label define pathars 1"Always biased" 2"Becomes biased" 3"Leave bias" 4"Never biased"
label values pathars pathars

set graph off
catplot sex pathars, asyvars percent(sex) recast(bar) ///
ylabel(, labsize(vsmall)) ytitle("Percent", size(small)) ///
var2opts(label(labsize(vsmall) angle(45))) ///
name(g1, replace) legend(col(2) pos(6) size(vsmall)) blabel(bar, format(%4.1f) size(tiny) angle(45))

catplot caste pathars, asyvars percent(caste) recast(bar) ///
ylabel(, labsize(vsmall)) ytitle("Percent", size(small)) ///
var2opts(label(labsize(vsmall) angle(45))) ///
name(g2, replace) legend(col(3) pos(6) size(vsmall)) blabel(bar, format(%4.1f) size(tiny) angle(45))

catplot agecat1 pathars, asyvars percent(agecat1) recast(bar) ///
ylabel(, labsize(vsmall)) ytitle("Percent", size(small)) ///
var2opts(label(labsize(vsmall) angle(45))) ///
name(g3, replace) legend(col(2) pos(6) size(vsmall)) blabel(bar, format(%4.1f) size(tiny) angle(45))

graph combine g1 g2 g3, col(3) note("Acquiesence bias", size(tiny))
graph save "$git\Analysis\Personality\Big-5\path_ars.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\path_ars.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\path_ars.pdf", as(pdf) replace
set graph on
****************************************
* END
















****************************************
* CAT PLOT
****************************************

********** Corrected - Non corrected
preserve
foreach x in OP CO EX AG ES Grit {
rename cat_diff_cr_`x' cat_diff_`x'2
rename cat_diff_`x' cat_diff_`x'1
}
gen corr2=1
gen corr1=0
egen HHINDID=concat(HHID_panel INDID_panel), p(/)
order HHINDID
sort HHINDID
reshape long cat_diff_OP cat_diff_CO cat_diff_EX cat_diff_AG cat_diff_ES cat_diff_Grit corr, i(HHINDID) j(n)
order HHINDID corr cat_diff_OP cat_diff_CO cat_diff_EX cat_diff_AG cat_diff_ES cat_diff_Grit
sort HHINDID
*Graph
set graph off
foreach x in OP CO EX AG ES Grit {
catplot corr cat_diff_`x', asyvars percent(corr) recast(bar) ///
ylabel(, labsize(vsmall)) ytitle("Percent", size(small)) ///
var2opts(label(labsize(vsmall) angle(45))) ///
title("`x'", size(small)) ///
name(g_`x', replace) legend(order(1 "Non-corrected" 2 "Corrected") col(3) size(vsmall)) blabel(bar, format(%4.1f) size(tiny) angle(45))
}
grc1leg g_OP g_CO g_EX g_AG g_ES, leg(g_OP) pos(6) cols(3)
graph save "$git\Analysis\Personality\Big-5\diff_cor_ncor.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\diff_cor_ncor.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\diff_cor_ncor.pdf", as(pdf) replace
set graph on
restore



********** Corrected
*ssc install catplot
*Gender
set graph off
foreach x in OP CO EX AG ES {
catplot sex cat_diff_cr_`x', asyvars percent(sex) recast(bar) ///
ylabel(, labsize(vsmall)) ytitle("Percent", size(small)) ///
var2opts(label(labsize(vsmall) angle(45))) ///
title("`x'", size(small)) ///
name(g_`x', replace) legend(col(2) size(vsmall)) blabel(bar, format(%4.1f) size(tiny) angle(45))
}
grc1leg g_OP g_CO g_EX g_AG g_ES, cols(2) name(combage, replace) legend(g_OP) pos(6) note("Traits corrected from acquiesence bias.", size(tiny))
graph save "$git\Analysis\Personality\Big-5\diff_gender_cor.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\diff_gender_cor.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\diff_gender_cor.pdf", as(pdf) replace
set graph on

*Caste
set graph off
foreach x in OP CO EX AG ES {
catplot caste cat_diff_cr_`x', asyvars percent(caste) recast(bar) ///
ylabel(, labsize(vsmall)) ytitle("Percent", size(small)) ///
var2opts(label(labsize(vsmall) angle(45))) ///
title("`x'", size(small)) ///
name(g_`x', replace) legend(col(3) size(vsmall)) blabel(bar, format(%4.1f) size(tiny) angle(45))
}
grc1leg g_OP g_CO g_EX g_AG g_ES, cols(2) name(combage, replace) legend(g_OP) pos(6) note("Traits corrected from acquiesence bias.", size(tiny))
set graph on
graph save "$git\Analysis\Personality\Big-5\diff_caste_cor.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\diff_caste_cor.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\diff_caste_cor.pdf", as(pdf) replace

*Age
set graph off
foreach x in OP CO EX AG ES {
catplot agecat1 cat_diff_cr_`x', asyvars percent(agecat1) recast(bar) ///
ylabel(, labsize(vsmall)) ytitle("Percent", size(small)) ///
var2opts(label(labsize(vsmall) angle(45))) ///
title("`x'", size(small)) ///
name(g_`x', replace) legend(col(2) size(vsmall)) blabel(bar, format(%4.1f) size(tiny) angle(45))
}
grc1leg g_OP g_CO g_EX g_AG g_ES, cols(2) name(combage, replace) legend(g_OP) pos(6) note("Traits corrected from acquiesence bias.", size(tiny))
set graph on
graph save "$git\Analysis\Personality\Big-5\diff_age_cor.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\diff_age_cor.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\diff_age_cor.pdf", as(pdf) replace



********** Raw
*ssc install catplot
*Gender
set graph off
foreach x in OP CO EX AG ES {
catplot sex cat_diff_`x', asyvars percent(sex) recast(bar) ///
ylabel(, labsize(vsmall)) ytitle("Percent", size(small)) ///
var2opts(label(labsize(vsmall) angle(45))) ///
title("`x'", size(small)) ///
name(g_`x', replace) legend(col(2) size(vsmall)) blabel(bar, format(%4.1f) size(tiny) angle(45))
}
grc1leg g_OP g_CO g_EX g_AG g_ES, cols(2) name(combage, replace) legend(g_OP) pos(6) note("Raw traits (non-corrected from acquiesence bias).", size(tiny))
set graph on
graph save "$git\Analysis\Personality\Big-5\diff_gender_raw.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\diff_gender_raw.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\diff_gender_raw.pdf", as(pdf) replace

*Caste
set graph off
foreach x in OP CO EX AG ES {
catplot caste cat_diff_`x', asyvars percent(caste) recast(bar) ///
ylabel(, labsize(vsmall)) ytitle("Percent", size(small)) ///
var2opts(label(labsize(vsmall) angle(45))) ///
title("`x'", size(small)) ///
name(g_`x', replace) legend(col(3) size(vsmall)) blabel(bar, format(%4.1f) size(tiny) angle(45))
}
grc1leg g_OP g_CO g_EX g_AG g_ES, cols(2) name(combage, replace) legend(g_OP) pos(6) note("Raw traits (non-corrected from acquiesence bias).", size(tiny))
set graph on
graph save "$git\Analysis\Personality\Big-5\diff_caste_raw.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\diff_caste_raw.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\diff_caste_raw.pdf", as(pdf) replace

*Age
set graph off
foreach x in OP CO EX AG ES {
catplot agecat1 cat_diff_`x', asyvars percent(agecat1) recast(bar) ///
ylabel(, labsize(vsmall)) ytitle("Percent", size(small)) ///
var2opts(label(labsize(vsmall) angle(45))) ///
title("`x'", size(small)) ///
name(g_`x', replace) legend(col(2) size(vsmall)) blabel(bar, format(%4.1f) size(tiny) angle(45))
}
grc1leg g_OP g_CO g_EX g_AG g_ES, cols(2) name(combage, replace) legend(g_OP) pos(6) note("Raw traits (non-corrected from acquiesence bias).", size(tiny))
set graph on
graph save "$git\Analysis\Personality\Big-5\diff_age_raw.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\diff_age_raw.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\diff_age_raw.pdf", as(pdf) replace


********** Cognitif
*ssc install catplot
*Gender
set graph off
foreach x in raven_tt num_tt lit_tt {
catplot sex cat_diff_`x', asyvars percent(sex) recast(bar) ///
ylabel(, labsize(vsmall)) ytitle("Percent", size(small)) ///
var2opts(label(labsize(vsmall) angle(45))) ///
title("`x'", size(small)) ///
name(g_`x', replace) legend(col(2) size(vsmall)) blabel(bar, format(%4.1f) size(tiny) angle(45))
}
grc1leg g_raven_tt g_num_tt g_lit_tt, cols(3) leg(g_raven_tt) name(combage, replace) pos(6)
set graph on
graph save "$git\Analysis\Personality\Big-5\diff_cog_gender.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\diff_cog_gender.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\diff_cog_gender.pdf", as(pdf) replace

*Caste
set graph off
foreach x in raven_tt num_tt lit_tt {
catplot caste cat_diff_`x', asyvars percent(caste) recast(bar) ///
ylabel(, labsize(vsmall)) ytitle("Percent", size(small)) ///
var2opts(label(labsize(vsmall) angle(45))) ///
title("`x'", size(small)) ///
name(g_`x', replace) legend(col(3) size(vsmall)) blabel(bar, format(%4.1f) size(tiny) angle(45))
}
grc1leg g_raven_tt g_num_tt g_lit_tt, cols(3) leg(g_raven_tt) name(combage, replace) pos(6)
set graph on
graph save "$git\Analysis\Personality\Big-5\diff_cog_caste.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\diff_cog_caste.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\diff_cog_caste.pdf", as(pdf) replace

*Age
set graph off
foreach x in raven_tt num_tt lit_tt {
catplot agecat1 cat_diff_`x', asyvars percent(agecat1) recast(bar) ///
ylabel(, labsize(vsmall)) ytitle("Percent", size(small)) ///
var2opts(label(labsize(vsmall) angle(45))) ///
title("`x'", size(small)) ///
name(g_`x', replace) legend(col(2) size(vsmall)) blabel(bar, format(%4.1f) size(tiny) angle(45))
}
grc1leg g_raven_tt g_num_tt g_lit_tt, cols(3) leg(g_raven_tt) name(combage, replace) pos(6)
set graph on
graph save "$git\Analysis\Personality\Big-5\diff_cog_age.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\diff_cog_age.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\diff_cog_age.pdf", as(pdf) replace

****************************************
* END














****************************************
* HISTOGRAM
****************************************

********** Graphical
*For line 
foreach x in absdiff_cr_OP absdiff_cr_CO absdiff_cr_EX absdiff_cr_AG absdiff_cr_ES absdiff_cr_Grit absdiff_OP absdiff_CO absdiff_EX absdiff_AG absdiff_ES absdiff_Grit {
pctile `x'_p=`x', n(20)
}
gen n=_n*5
replace n=. if n>100


********** Raw traits
*Density
set graph off
histogram diff_OP, percent width(0.1) xlabel(-4(1)4, labsize(vsmall) ang(0)) xmtick(-4(0.2)4) ylabel(, labsize(vsmall)) ymtick() xtitle("slope - OP", size(small)) ytitle(, size(small)) name(g1, replace) note("") title("") legend(off)
histogram diff_CO, percent width(0.1) xlabel(-4(1)4, labsize(vsmall) ang()) xmtick(-4(0.2)4) ylabel(, labsize(vsmall)) ymtick() xtitle("slope -  CO", size(small)) ytitle(, size(small)) name(g2, replace)  note("") title("") legend(off)
histogram diff_EX, percent width(0.1) xlabel(-4(1)4, labsize(vsmall) ang()) xmtick(-4(0.2)4) ylabel(, labsize(vsmall)) ymtick() xtitle("slope -  EX", size(small)) ytitle(, size(small)) name(g3, replace)  note("") title("") legend(off)
histogram diff_AG, percent width(0.1) xlabel(-4(1)4, labsize(vsmall) ang()) xmtick(-4(0.2)4) ylabel(, labsize(vsmall)) ymtick() xtitle("slope -  AG", size(small)) ytitle(, size(small)) name(g4, replace)  note("") title("") legend(off)
histogram diff_ES, percent width(0.1) xlabel(-4(1)4, labsize(vsmall) ang()) xmtick(-4(0.2)-4) ylabel(, labsize(vsmall)) ymtick() xtitle("slope -  ES", size(small)) ytitle(, size(small)) name(g5, replace)  note("") title("") legend(off)
/*
*Line
twoway ///
(line absdiff_OP_p n, lpattern(solid) lcolor(gs0)) ///
(line absdiff_CO_p n, lpattern(shortdash) lcolor(gs4)) ///
(line absdiff_EX_p n, lpattern(shortdash) lcolor(gs10)) ///
(line absdiff_AG_p n, lpattern(dash) lcolor(gs8)) ///
(line absdiff_ES_p n, lpattern(solid) lcolor(gs12)) ///
, xtitle("Percentage of population", size(small)) xlabel(0(10)100, labsize(vsmall) ang()) xmtick(0(2.5)100) ytitle("|slope|", size(small)) ylabel(0(0.2)2.2, labsize(vsmall)) ymtick(0(0.1)2.2) yline() legend(position(6) col(5) size(vsmall) order(1 "OP" 2 "CO" 3 "EX" 4 "AG" 5 "ES")) name(line2, replace)
*/
*Combine
graph combine g1 g2 g3 g4 g5, cols(3) note("Raw traits (non-corrected from acquiesence bias).", size(tiny))
graph save "$git\Analysis\Personality\Big-5\diffcont_raw.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\diffcont_raw.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\diffcont_raw.pdf", as(pdf) replace
set graph on 



********** Cor traits
*Density
set graph off
histogram diff_cr_OP, percent width(0.1) xlabel(-4(1)4, labsize(vsmall) ang(0)) xmtick(-4(0.2)4) ylabel(, labsize(vsmall)) ymtick() xtitle("slope - OP", size(small)) ytitle(, size(small)) name(g1, replace) note("") title("") legend(off)
histogram diff_cr_CO, percent width(0.1) xlabel(-4(1)4, labsize(vsmall) ang()) xmtick(-4(0.2)4) ylabel(, labsize(vsmall)) ymtick() xtitle("slope -  CO", size(small)) ytitle(, size(small)) name(g2, replace)  note("") title("") legend(off)
histogram diff_cr_EX, percent width(0.1) xlabel(-4(1)4, labsize(vsmall) ang()) xmtick(-4(0.2)4) ylabel(, labsize(vsmall)) ymtick() xtitle("slope -  EX", size(small)) ytitle(, size(small)) name(g3, replace)  note("") title("") legend(off)
histogram diff_cr_AG, percent width(0.1) xlabel(-4(1)4, labsize(vsmall) ang()) xmtick(-4(0.2)4) ylabel(, labsize(vsmall)) ymtick() xtitle("slope -  AG", size(small)) ytitle(, size(small)) name(g4, replace)  note("") title("") legend(off)
histogram diff_cr_ES, percent width(0.1) xlabel(-4(1)4, labsize(vsmall) ang()) xmtick(-4(0.2)-4) ylabel(, labsize(vsmall)) ymtick() xtitle("slope -  ES", size(small)) ytitle(, size(small)) name(g5, replace)  note("") title("") legend(off)
/*
*Line
twoway ///
(line absdiff_cr_OP_p n, lpattern(solid) lcolor(gs0)) ///
(line absdiff_cr_CO_p n, lpattern(shortdash) lcolor(gs4)) ///
(line absdiff_cr_EX_p n, lpattern(shortdash) lcolor(gs10)) ///
(line absdiff_cr_AG_p n, lpattern(dash) lcolor(gs8)) ///
(line absdiff_cr_ES_p n, lpattern(solid) lcolor(gs12)) ///
, xtitle("Percentage of population", size(small)) xlabel(0(10)100, labsize(vsmall) ang(45)) xmtick(0(2.5)100) ytitle("|Δ|", size(small)) ylabel(0(10)70, labsize(vsmall)) ymtick(0(5)70) yline() legend(position(6) col(5) size(vsmall) order(1 "Openness" 2 "Conscientiousness" 3 "Extraversion" 4 "Agreeableness" 5 "Emotional stability")) name(line2, replace)
*/
*Combine
graph combine g1 g2 g3 g4 g5, cols(3) note("Traits corrected from acquiesence bias.", size(tiny))
graph save "$git\Analysis\Personality\Big-5\diffcont_cor.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\diffcont_cor.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\diffcont_cor.pdf", as(pdf) replace
set graph on 

drop absdiff_cr_OP_p absdiff_cr_CO_p absdiff_cr_EX_p absdiff_cr_AG_p absdiff_cr_ES_p absdiff_cr_Grit_p absdiff_OP_p absdiff_CO_p absdiff_EX_p absdiff_AG_p absdiff_ES_p absdiff_Grit_p n






********** COGNITIF
tab1 diff_raven_tt diff_num_tt diff_lit_tt
*Density
set graph off
histogram diff_raven_tt, percent width(1) xlabel(-36(6)27, labsize(vsmall) ang(0)) xmtick(-36(1)27) ylabel(, labsize(vsmall)) ymtick() xtitle("slope - Raven", size(small)) ytitle(, size(small)) name(g1, replace) note("") title("") legend(off)
histogram diff_num_tt, percent width(1) xlabel(-12(2)12, labsize(vsmall) ang()) ylabel(, labsize(vsmall)) ymtick() xtitle("slope -  Num", size(small)) ytitle(, size(small)) name(g2, replace)  note("") title("") legend(off)
histogram diff_lit_tt, percent width(0.5) xlabel(-4(1)4, labsize(vsmall) ang()) xmtick(-4(0.2)4) ylabel(, labsize(vsmall)) ymtick() xtitle("slope -  Lit", size(small)) ytitle(, size(small)) name(g3, replace)  note("") title("") legend(off)
*Combine
graph combine g1 g2 g3, cols(3)
graph save "$git\Analysis\Personality\Big-5\diffcont_cog.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\diffcont_cog.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\diffcont_cog.pdf", as(pdf) replace
set graph on 

drop absdiff_raven_tt absdiff_num_tt absdiff_lit_tt

drop absdiff_cr_OP absdiff_cr_CO absdiff_cr_EX absdiff_cr_AG absdiff_cr_ES absdiff_cr_Grit absdiff_OP absdiff_CO absdiff_EX absdiff_AG absdiff_ES absdiff_Grit absdiff_ars absdiff_ars2 absdiff_ars3
****************************************
* END














****************************************
* OMEGA
****************************************
preserve
import delimited "$git\Analysis\Personality\Big-5\_omega.csv", delimiter(";") clear

encode traits, gen(big5)
gen deltaraw=(raw2020-raw2016)*100/raw2016
gen deltacor=(cor2020-cor2016)*100/cor2016

gen delta2016=(cor2016-raw2016)*100/raw2016
gen delta2020=(cor2020-raw2020)*100/raw2020
set graph off
graph bar raw2016 cor2016 raw2020 cor2020, over(traits) blabel(bar, format(%4.2f) size(tiny)) legend(pos(6) col(4) order(1 "Non-cor. 2016-17" 2 "Corr. 2016-17" 3 "Non-cor. 2020-21" 4 "Corr. 2020-21")) name(g1, replace) note("McDonald's Ω", size(tiny))
graph save "$git\Analysis\Personality\Big-5\omega.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\omega.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\omega.pdf", as(pdf) replace

graph bar deltaraw deltacor, over(traits) ylabel(-70(10)80) ymtick(-65(5)75) blabel(bar, format(%4.2f) size(tiny)) legend(pos(6) col(2) order(1 "Non-cor." 2 "Corr.")) title("Variation over time (2016-17 / 2020-21)", size(small)) name(g2, replace)
graph bar delta2016 delta2020, over(traits) ylabel(-70(10)80) blabel(bar, format(%4.2f) size(tiny)) legend(pos(6) col(2) order(1 "2016-17" 2 "2020-21")) title("Variation over correction (Non-cor. / Corr.)", size(small)) name(g3, replace)
graph combine g2 g3, col(3) note("Variation rate of McDonald's Ω", size(tiny))
graph save "$git\Analysis\Personality\Big-5\omega_delta.gph", replace
graph export "$git\RUME-NEEMSIS\Big-5\omega_delta.svg", as(svg) replace
graph export "$git\Analysis\Personality\Big-5\omega_delta.pdf", as(pdf) replace
set graph on

restore
****************************************
* END










****************************************
* TABLE
****************************************
*Nb
tab nbdec  // 0-403; 1-297; 2-115; 3-20
tab1 dec_raven_tt dec_num_tt dec_lit_tt
tab dec_raven_tt if nbdec==1  // 234=78.79
tab dec_num_tt if nbdec==1  // 37=12.46
tab dec_lit_tt if nbdec==1  // 26=8.75

tab dec_raven dec_num if nbdec==2  // 52=45.22
tab dec_raven dec_lit if nbdec==2  // 56=48.69
tab dec_num dec_lit if nbdec==2  // 7=6.09

*By age
stripplot age , over(nbdec) separate() ///
cumul cumprob box centre vertical refline /// 
xsize(4) xtitle("") xlabel(0 "Stable or better" 1 "One decrease" 2 "Two decrease" 3 "Three decrease",angle(45))  ///
ylabel(15(5)90) ytitle("") ///
title("Age in 2016-17") ///
msymbol(oh) mcolor(gs8) name(y1, replace) 
*By gender
tab nbdec sex, col nofreq
*By caste
tab nbdec caste, col nofreq

****************************************
* END
