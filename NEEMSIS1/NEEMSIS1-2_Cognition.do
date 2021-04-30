/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
16/04/21
-----


description: 	Cog
-------------------------
*/


global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS1\DATA"


cd "$directory"

*ssc install fre, replace
*ssc install blindschemes, replace
*ssc install mdesc, replace
*ssc install graphlog, replace
set scheme plottig
set graph off





****************************************
* PREPA COGNITIVE
****************************************
use"NEEMSIS1-HH_v5.dta", clear

***Raven
/*
preserve 
keep if dummyego==1
mdesc a1-a12 // 10 to 37 but around 20-25
mdesc a2-a12 if a1==. // no-response is not systematic
mdesc ab1-ab12 // 12 to 39
mdesc ab2-ab12 if ab1==. // not too 
mdesc ab1-ab12 if a1==.
mdesc b1-b12  // 2 to 34
mdesc b2-b12 if b1==. // not too 
mdesc b1-b12 if a1==.  
restore
*/
*right answers
gen set_a1=4
gen set_a2=5
gen set_a3=1
gen set_a4=2
gen set_a5=6
gen set_a6=3
gen set_a7=6
gen set_a8=2
gen set_a9=1
gen set_a10=3
gen set_a11=4
gen set_a12=5

gen set_ab1=4
gen set_ab2=5
gen set_ab3=1
gen set_ab4=6
gen set_ab5=2
gen set_ab6=1
gen set_ab7=3
gen set_ab8=4
gen set_ab9=6
gen set_ab10=3
gen set_ab11=5
gen set_ab12=2

gen set_b1=2
gen set_b2=6
gen set_b3=1
gen set_b4=2
gen set_b5=1
gen set_b6=3
gen set_b7=5
gen set_b8=6
gen set_b9=4
gen set_b10=3
gen set_b11=4
gen set_b12=5

*Number of correct answers
forval i=1(1)12 {
gen ra`i'=0 	if a`i' !=.
gen rab`i'=0 	if ab`i' !=.
gen rb`i'=0 	if b`i' !=.
}
forval i=1(1)12 {
replace ra`i'=1  if a`i'==set_a`i' 	
replace rab`i'=1 if ab`i'==set_ab`i' 
replace rb`i'=1  if b`i'==set_b`i' 
}	
drop set_a1-set_a12
drop set_ab1-set_ab12
drop set_b1-set_b12
/*
*Sex verif
graph bar ra1 ra2 ra3 ra4 ra5 ra6 ra7 ra8 ra9 ra10 ra11 ra12, over(sex)
graph export "$directory\raven_seta.pdf", replace
graph bar rab1 rab2 rab3 rab4 rab5 rab6 rab7 rab8 rab9 rab10 rab11 rab12, over(sex)
graph export "$directory\raven_setab.pdf", replace
graph bar rb1 rb2 rb3 rb4 rb5 rb6 rb7 rb8 rb9 rb10 rb11 rb12, over(sex)
graph export "$directory\raven_setb.pdf", replace

*Username verif
tabstat ra1 ra1 ra2 ra4 ra5 ra6 ra7 ra8 ra9 ra10 ra11 ra12, by(username)
tabstat rab1 rab2 rab3 rab4 rab5 rab6 rab7 rab8 rab9 rab10 rab11 rab12, by(username)
tabstat rb1 rb2 rb3 rb4 rb5 rb6 rb7 rb8 rb9 rb10 rb11 rb12, by(username)
*/
*Total score 
egen set_a = rowtotal (ra1 ra2 ra3 ra4 ra5 ra6 ra7 ra8 ra9 ra10 ra11 ra12), missing
egen set_ab = rowtotal (rab1 rab2 rab3 rab4 rab5 rab6 rab7 rab8 rab9 rab10 rab11 rab12), missing 
egen set_b = rowtotal (rb1 rb2 rb3 rb4 rb5 rb6 rb7 rb8 rb9 rb10 rb11 rb12), missing
egen raven_tt = rowtotal (set_a set_b set_ab)
tab1 set_a set_ab set_b raven_tt
/*
tabstat set_a set_ab set_b raven_tt, stat(n mean sd) by(ego)
tabstat set_a set_ab set_b raven_tt, stat(n mean sd) by(sex)
tabstat set_a set_ab set_b raven_tt, stat(n mean sd) by(username)
kdensity raven_tt if sex==1, plot(kdensity raven_tt if sex==2) legend(ring(0) pos(2) label(1 "Male") label(2 "Female"))
graph export "$directory\raven_tot.pdf", replace
*kdensity raven_tt if username==2, plot(kdensity raven_tt if username==4 || kdensity raven_tt if username==7 || kdensity raven_tt if username==8) legend(ring(0) pos(2) label(1 "Vivek") label(2 "Suganya") label(3 "Chithra") label(4 "Raichal"))	
*/








*********Numeracy & literacy
global literacy canreadcard1a canreadcard1b canreadcard1c canreadcard2
global numeracy numeracy1 numeracy2 numeracy3 numeracy4
global cog $literacy $numeracy

*composite score
*recode no response as missing for easier analysis
foreach x of varlist $cog {
recode `x' (99=.) 
}
foreach x of varlist $numeracy {
recode `x' (2=0)
}
foreach x of varlist $literacy {
recode `x' (1=0) (3=1) (2=0.5) 
}
**Look at missing values 	
mdesc $cog

mdesc $literacy if canreadcard1a==. //those are mostly the same people 
tab edulevel if canreadcard1a==. //code as can't read if edulevel max primary completed 
gen refuse=0
replace refuse=1 if (canreadcard1a+canreadcard1b+canreadcard1c+canreadcard2==.)
recode $literacy (.=0) if edulevel<=1

mdesc numeracy4 numeracy3 numeracy2 if numeracy1==. 
tab edulevel if numeracy1==. 
replace refuse=1 if (numeracy1+numeracy2+numeracy3+numeracy4==.)

recode numeracy4 numeracy3 numeracy2 numeracy1 (.=0) if edulevel<=1	

egen num_tt = rowtotal(numeracy1 numeracy2 numeracy3 numeracy4), missing 
egen lit_tt = rowtotal(canreadcard1a canreadcard1b canreadcard1c canreadcard2), missing 
/*
twoway (histogram lit_tt if username==2, w(0.5)) (histogram lit_tt if username==4, color(green) w(0.5)) (histogram lit_tt if username==7, color(blue) w(0.5)) (histogram lit_tt if username==8, color(red) w(0.5)), legend(order(1 "Vivek" 2 "Suganya" 3 "Chithra" 4 "Raichal" ))
twoway (histogram num_tt if username==2, w(1)) (histogram num_tt if username==4, color(green) w(1)) (histogram num_tt if username==7, color(blue) w(1)) (histogram num_tt if username==8, color(red) w(1)), legend(order(1 "Vivek" 2 "Suganya" 3 "Chithra" 4 "Raichal" ))
tabstat lit_tt num_tt, stat(n mean sd q min max) by(username)
*/












*********Cleaning
global big5 ///
curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts  ///
workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers ///
managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm ///
tryhard  stickwithg~s   goaftergoal finishwhat~n finishtasks  keepworking

foreach x in $big5{
recode `x' (99=.)
}

mdesc $big5 

alpha curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination, casewise  // .74
alpha organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties, casewise  // .65 
alpha enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts, casewise  // .64 
alpha workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers, casewise  // .54 
alpha managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm, casewise  // .66 
alpha tryhard  stickwithg~s   goaftergoal finishwhat~n finishtasks  keepworking, casewise  // .66 

*recode all so that more is better! 
foreach var of varlist $big5 {
recode `var' (5=1) (4=2) (3=3) (2=4) (1=5)
}

/*
label define persorecode 1"5 - Almost never" 2"4 - Rarely" 3"3 - Sometimes" 4"2 - Quite often" 5"1 - Almost always"
foreach x in $big5{
label values `x' persorecode
}
*/

**Correction du biais d'"acquiescence"
*Paires
local varlist ///
rudetoother helpfulwit~s  ///
putoffduties 	completedut~s /// 
easilydistracted makeplans  ///
shywithpeople talktomany~e ///
repetitive~s curious  ///
nervous staycalm ///  
worryalot managestress 

tab rudetoother helpfulwit~s,  cell  // AG
tab putoffduties completedut~s, nofreq cell  // acquiesence bias CO
tab easilydistracted makeplans, nofreq cell  // same.. CO
tab shywithpeople talktomany~e, nofreq cell  // EX
tab repetitive~s curious, nofreq cell  // same.. OP
tab nervous staycalm, nofreq cell  // same.. ES
tab worryalot managestress, nofreq cell  // same.. ES


*moyenne
egen ars=rowmean(`varlist') 
tabstat ars, stat(n mean sd q min max)
ttest ars==3
tab ars
gen ars2=ars-3  
sum ars 
ttest ars=3 
*recode reversely coded items 
foreach var of varlist rudetoother putoffduties easilydistracted shywithpeople repetitive~s nervous changemood feeldepres easilyupset worryalot {
gen raw_`var' = `var' 	
recode `var' (5=1) (4=2) (3=3) (2=4) (1=5)
}
*corrected items: 
foreach var of varlist $big5 {
gen cr_`var'=`var'-ars2 if ars!=. 
}
	
**Moyenne pour avoir les traits
egen cr_OP = rowmean(cr_curious cr_interested~t   cr_repetitive~s cr_inventive cr_liketothink cr_newideas cr_activeimag~n)
egen cr_CO = rowmean(cr_organized  cr_makeplans cr_workhard cr_appointmen~e cr_putoffduties cr_easilydist~d cr_completedu~s) 
egen cr_EX = rowmean(cr_enjoypeople cr_sharefeeli~s cr_shywithpeo~e  cr_enthusiastic  cr_talktomany~e  cr_talkative cr_expressing~s ) 
egen cr_AG = rowmean(cr_workwithot~r   cr_understand~g cr_trustingof~r cr_rudetoother cr_toleratefa~s  cr_forgiveother  cr_helpfulwit~s) 
egen cr_ES = rowmean(cr_managestress  cr_nervous  cr_changemood cr_feeldepres~d cr_easilyupset cr_worryalot  cr_staycalm) 
egen cr_Grit = rowmean(cr_tryhard  cr_stickwithg~s   cr_goaftergoal cr_finishwhat~n cr_finishtasks  cr_keepworking)

egen OP = rowmean(curious interested~t  repetitive~s inventive liketothink newideas activeimag~n)
egen CO = rowmean(organized  makeplans workhard appointmen~e putoffduties easilydist~d completedu~s) 
egen EX = rowmean(enjoypeople sharefeeli~s shywithpeo~e enthusiastic talktomany~e  talkative expressing~s ) 
egen AG = rowmean(workwithot~r understand~g trustingof~r rudetoother toleratefa~s forgiveother helpfulwit~s) 
egen ES = rowmean(managestress nervous changemood feeldepres~d easilyupset worryalot staycalm) 
egen Grit = rowmean(tryhard stickwithg~s  goaftergoal finishwhat~n finishtasks keepworking)



**Alpha
alpha curious 		interested~t   repetitive~s inventive liketothink newideas activeimag~n
alpha cr_curious cr_interested~t   cr_repetitive~s cr_inventive cr_liketothink cr_newideas cr_activeimag~n

alpha organized  makeplans workhard appointmen~e putoffduties easilydist~d completedu~s
alpha cr_organized  cr_makeplans cr_workhard cr_appointmen~e cr_putoffduties cr_easilydist~d cr_completedu~s
	
alpha enjoypeople sharefeeli~s shywithpeo~e  enthusiastic  talktomany~e  talkative expressing~s 
alpha cr_enjoypeople cr_sharefeeli~s cr_shywithpeo~e  cr_enthusiastic  cr_talktomany~e  cr_talkative cr_expressing~s
	
alpha workwithot~r   understand~g trustingof~r rudetoother toleratefa~s  forgiveother  helpfulwit~s
alpha cr_workwithot~r   cr_understand~g cr_trustingof~r cr_rudetoother cr_toleratefa~s  cr_forgiveother  cr_helpfulwit~s 
	
alpha managestress  nervous  changemood feeldepres~d easilyupset worryalot  staycalm 
alpha cr_managestress  cr_nervous  cr_changemood cr_feeldepres~d cr_easilyupset cr_worryalot  cr_staycalm
	
alpha tryhard  stickwithg~s   goaftergoal finishwhat~n finishtasks  keepworking	
alpha cr_tryhard  cr_stickwithg~s   cr_goaftergoal cr_finishwhat~n cr_finishtasks  cr_keepworking

save"NEEMSIS1-HH_v6.dta", replace
****************************************
* END




/*
****************************************
* EFA
****************************************
global directory = "C:\Users\Arnaud\Desktop\NEEMSIS2\DATA\APPEND\CLEAN"
cd"$directory"
clear all
use"NEEMSIS_APPEND_v8.dta", clear

global big5  ///
	cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts ///
	cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers /// 
	cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot cr_staycalm ///
	cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination ///
	cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties ///
	cr_tryhard cr_stickwithgoals cr_goaftergoal cr_finishwhatbegin cr_finishtasks cr_keepworking

global big5questionsnogrit curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople talkative expressingthoughts ///
workwithother understandotherfeeling trustingofother rudetoother toleratefaults forgiveother ///
helpfulwithothers managestress nervous changemood feeldepressed easilyupset worryalot staycalm
	
*1. Vérif des missings
gen nmiss=0
foreach x in $big5{
replace nmiss=nmiss+1 if `x'==.
}
tab nmiss
*2. Imputation avec les moyennes par sexe pour ne pas perdre des individus
foreach x in $big5{
gen im`x'=`x'
}
global big5i imcr_curious imcr_interestedbyart imcr_repetitivetasks imcr_inventive imcr_liketothink imcr_newideas imcr_activeimagination ///
imcr_organized imcr_makeplans imcr_workhard imcr_appointmentontime imcr_putoffduties imcr_easilydistracted imcr_completeduties ///
imcr_enjoypeople imcr_sharefeelings imcr_shywithpeople imcr_enthusiastic imcr_talktomanypeople imcr_talkative imcr_expressingthoughts ///
imcr_workwithother imcr_understandotherfeeling imcr_trustingofother imcr_rudetoother imcr_toleratefaults imcr_forgiveother ///
imcr_helpfulwithothers imcr_managestress imcr_nervous imcr_changemood imcr_feeldepressed imcr_easilyupset imcr_worryalot imcr_staycalm
forvalues i=1(1)2{
foreach x in $big5i{
sum `x' if sex==`i'
replace `x'=r(mean) if `x'==. & sex==`i' & egoid!=0 & egoid!=.
}
}
*3. Check imputations
replace nmiss=0 if egoid!=0 & egoid!=.
foreach x in $big5i{
replace nmiss=nmiss+1 if `x'==.
}
tab nmiss
drop nmiss
*3. EFA
factor $big5i, pcf fa(5)
rotate, promax 
putexcel set "C:\Users\Arnaud\Desktop\PANEL_NEEMSIS\EFA.xlsx", modify sheet(2020res)
putexcel (E2)=matrix(e(r_L)) 

factor $big5questionsnogrit, pcf fa(5)
rotate, promax 
putexcel set "C:\Users\Arnaud\Desktop\PANEL_NEEMSIS\EFA.xlsx", modify sheet(2020resnogritnocr)
putexcel (E2)=matrix(e(r_L)) 

*4. Graph
/*
screeplot, neigen(10) yline(1) ylabel(1[1]10) xlabel(1[1]10) 
loadingplot, legend(off) xline(0) yline(0) scale(.8)
scoreplot
*/
*5. Predict
predict f1 f2 f3 f4 f5
global factor f1 f2 f3 f4 f5
sum $factor
sum $big5, sep(50)
sum $big5i, sep(50)
*global naivebig5 EGOcrOP EGOcrEX EGOcrES EGOcrCO EGOcrAG
*pwcorr $naivebig5 $factor, star(.01)

save"NEEMSIS_APPEND_v9.dta", replace
****************************************
* END