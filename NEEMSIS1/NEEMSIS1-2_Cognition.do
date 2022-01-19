cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
16/04/21
-----


description: 	Cog
-------------------------
*/

****************************************
* INITIALIZATION
****************************************
global directory = "C:\Users\Arnaud\Documents\_Thesis\_DATA\NEEMSIS1"


cd "$directory"

*ssc install fre, replace
*ssc install blindschemes, replace
*ssc install mdesc, replace
*ssc install graphlog, replace
set scheme plottig
set graph off
****************************************
* END










****************************************
* Cognitive
****************************************
use"NEEMSIS1-HH_v4.dta", clear

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
****************************************
* END

























****************************************
* Big-5
****************************************

*Macro
global big5 ///
curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts  ///
workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers ///
managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm ///
tryhard  stickwithgoals   goaftergoal finishwhatbegin finishtasks  keepworking

fre $big5
*At baseline, max=never



********** Recode 1
foreach x in $big5 {
clonevar `x'_backup=`x'
replace `x'=. if `x'==99 | `x'==6
}
fre completeduties putoffduties




********* omegacoef
omegacoef curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination, rev(repetitivetasks) // .8684

omegacoef organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties, rev(putoffduties easilydistracted)  // .8513

omegacoef enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts, rev(shywithpeople)  // .7292

omegacoef workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers, rev(rudetoother)  // .5108

omegacoef managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm, rev(managestress staycalm)  // .4794



********** Recode 2: all so that more is better! 
foreach var of varlist $big5 {	
recode `var' (5=1) (4=2) (3=3) (2=4) (1=5)
}
label define big5n 1"5 - Almost never" 2"4 - Rarely" 3"3 - Sometimes" 4"2 - Quite often" 5"1 - Almost always"
foreach x in $big5 {
label values `x' big5n
}




********** Correction du biais d'"acquiescence"
*Paires
local varlist ///
rudetoother helpfulwit~s  ///
putoffduties 	completedut~s /// 
easilydistracted makeplans  ///
shywithpeople talktomany~e ///
repetitive~s curious  ///
nervous staycalm ///  
worryalot managestress 
*moyenne des paires pour savoir si ils sont loin de 3, si oui alors biais
egen ars=rowmean(`varlist') 
tabstat ars, stat(n mean sd q min max)
ttest ars==3
tab ars
gen ars2=ars-3  
gen ars3=abs(ars2)



********** Recode 3: reversely coded items 
foreach var of varlist rudetoother putoffduties easilydistracted shywithpeople repetitive~s nervous changemood feeldepressed easilyupset worryalot {
recode `var' (5=1) (4=2) (3=3) (2=4) (1=5)
}
label define big5n2 5"5 - Almost never" 4"4 - Rarely" 3"3 - Sometimes" 2"2 - Quite often" 1"1 - Almost always"
foreach x in rudetoother putoffduties easilydistracted shywithpeople repetitive~s nervous changemood feeldepressed easilyupset worryalot {
label values `x' big5n2
}
*corrected items: 
foreach var of varlist $big5 {
gen cr_`var'=`var'-ars2 if ars!=. 
}







********** Big-5 taxonomy	
egen cr_OP = rowmean(cr_curious cr_interested~t   cr_repetitive~s cr_inventive cr_liketothink cr_newideas cr_activeimag~n)
egen cr_CO = rowmean(cr_organized  cr_makeplans cr_workhard cr_appointmen~e cr_putoffduties cr_easilydist~d cr_completedu~s) 
egen cr_EX = rowmean(cr_enjoypeople cr_sharefeeli~s cr_shywithpeo~e  cr_enthusiastic  cr_talktomany~e  cr_talkative cr_expressing~s ) 
egen cr_AG = rowmean(cr_workwithot~r   cr_understand~g cr_trustingof~r cr_rudetoother cr_toleratefa~s  cr_forgiveother  cr_helpfulwit~s) 
egen cr_ES = rowmean(cr_managestress  cr_nervous  cr_changemood cr_feeldepres~d cr_easilyupset cr_worryalot  cr_staycalm) 
egen cr_Grit = rowmean(cr_tryhard  cr_stickwithg~s   cr_goaftergoal cr_finishwhat~n cr_finishtasks  cr_keepworking)

egen OP = rowmean(curious interested~t  repetitive~s inventive liketothink newideas activeimag~n)
egen CO = rowmean(organized  makeplans workhard appointmen~e putoffduties easilydistracted completedu~s) 
egen EX = rowmean(enjoypeople sharefeeli~s shywithpeo~e enthusiastic talktomany~e  talkative expressing~s ) 
egen AG = rowmean(workwithot~r understand~g trustingof~r rudetoother toleratefa~s forgiveother helpfulwit~s) 
egen ES = rowmean(managestress nervous changemood feeldepressed easilyupset worryalot staycalm) 
egen Grit = rowmean(tryhard stickwithg~s  goaftergoal finishwhat~n finishtasks keepworking)




********** Indid2016
rename INDID INDID2016
tostring INDID2016, replace

save"NEEMSIS1-HH_v5.dta", replace
****************************************
* END
