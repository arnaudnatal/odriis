cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
August 17, 2021
-----
Stability over time of personality traits: analysis p3
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
set scheme plottig, perm

*global git "C:\Users\anatal\Downloads\GitHub"
*global dropbox "C:\Users\anatal\Downloads\Dropbox"
*global thesis "C:\Users\anatal\Downloads\_Thesis\Research-Skills_and_debt\Analysis"

/*
global big5 ///
curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople talkative expressingthoughts  ///
workwithother understandotherfeeling trustingofother rudetoother toleratefaults forgiveother helpfulwithothers ///
managestress nervous changemood feeldepressed easilyupset worryalot staycalm ///
tryhard stickwithgoals goaftergoal finishwhatbegin finishtasks keepworking
*/

********** Name of the NEEMSIS2 questionnaire version to clean
global wave1 "RUME-HH_v8"
global wave2 "NEEMSIS1-HH_v7"
global wave3 "NEEMSIS2-HH_v17"
****************************************
* END


















****************************************
* Factor analysis 2020-21
****************************************

********** 
use"panel_stab_v4", clear

*Tester var
fre imrr_curious_1 imrr_curious_2

drop *_1
drop if egoid==.

********** Factor analysis 1: with grit for total sample
preserve
global big5 ///
imrr_curious_2 imrr_interestedbyart_2 imrr_repetitivetasks_2 imrr_inventive_2 imrr_liketothink_2 imrr_newideas_2 imrr_activeimagination_2 imrr_organized_2 imrr_makeplans_2 imrr_workhard_2 imrr_appointmentontime_2 imrr_putoffduties_2 imrr_easilydistracted_2 imrr_completeduties_2 imrr_enjoypeople_2 imrr_sharefeelings_2 imrr_shywithpeople_2 imrr_enthusiastic_2 imrr_talktomanypeople_2 imrr_talkative_2 imrr_expressingthoughts_2 imrr_workwithother_2 imrr_understandotherfeeling_2 imrr_trustingofother_2 imrr_rudetoother_2 imrr_toleratefaults_2 imrr_forgiveother_2 imrr_helpfulwithothers_2 imrr_managestress_2 imrr_nervous_2 imrr_changemood_2 imrr_feeldepressed_2 imrr_easilyupset_2 imrr_worryalot_2 imrr_staycalm_2 imrr_tryhard_2 imrr_stickwithgoals_2 imrr_goaftergoal_2 imrr_finishwhatbegin_2 imrr_finishtasks_2 imrr_keepworking_2

minap $big5
factor $big5, pcf fa(6)
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B2)=matrix(e(Ev))
rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B2)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5 f_6
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5 f_6
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa1)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


********** Factor analysis 2: without grit for total sample
preserve
global big5 ///
imrr_curious_2 imrr_interestedbyart_2 imrr_repetitivetasks_2 imrr_inventive_2 imrr_liketothink_2 imrr_newideas_2 imrr_activeimagination_2 imrr_organized_2 imrr_makeplans_2 imrr_workhard_2 imrr_appointmentontime_2 imrr_putoffduties_2 imrr_easilydistracted_2 imrr_completeduties_2 imrr_enjoypeople_2 imrr_sharefeelings_2 imrr_shywithpeople_2 imrr_enthusiastic_2 imrr_talktomanypeople_2 imrr_talkative_2 imrr_expressingthoughts_2 imrr_workwithother_2 imrr_understandotherfeeling_2 imrr_trustingofother_2 imrr_rudetoother_2 imrr_toleratefaults_2 imrr_forgiveother_2 imrr_helpfulwithothers_2 imrr_managestress_2 imrr_nervous_2 imrr_changemood_2 imrr_feeldepressed_2 imrr_easilyupset_2 imrr_worryalot_2 imrr_staycalm_2 

minap $big5
factor $big5, pcf fa(5) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B3)=matrix(e(Ev))
rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B3)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa2)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore



********** Factor analysis 3: with grit for male
preserve
keep if sex==1
global big5 ///
imrr_curious_2 imrr_interestedbyart_2 imrr_repetitivetasks_2 imrr_inventive_2 imrr_liketothink_2 imrr_newideas_2 imrr_activeimagination_2 imrr_organized_2 imrr_makeplans_2 imrr_workhard_2 imrr_appointmentontime_2 imrr_putoffduties_2 imrr_easilydistracted_2 imrr_completeduties_2 imrr_enjoypeople_2 imrr_sharefeelings_2 imrr_shywithpeople_2 imrr_enthusiastic_2 imrr_talktomanypeople_2 imrr_talkative_2 imrr_expressingthoughts_2 imrr_workwithother_2 imrr_understandotherfeeling_2 imrr_trustingofother_2 imrr_rudetoother_2 imrr_toleratefaults_2 imrr_forgiveother_2 imrr_helpfulwithothers_2 imrr_managestress_2 imrr_nervous_2 imrr_changemood_2 imrr_feeldepressed_2 imrr_easilyupset_2 imrr_worryalot_2 imrr_staycalm_2 imrr_tryhard_2 imrr_stickwithgoals_2 imrr_goaftergoal_2 imrr_finishwhatbegin_2 imrr_finishtasks_2 imrr_keepworking_2

qui minap $big5
qui factor $big5, pcf fa(6) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B4)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B4)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5 f_6
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5 f_6
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa3)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


********** Factor analysis 4: without grit for male
preserve
keep if sex==1
global big5 ///
imrr_curious_2 imrr_interestedbyart_2 imrr_repetitivetasks_2 imrr_inventive_2 imrr_liketothink_2 imrr_newideas_2 imrr_activeimagination_2 imrr_organized_2 imrr_makeplans_2 imrr_workhard_2 imrr_appointmentontime_2 imrr_putoffduties_2 imrr_easilydistracted_2 imrr_completeduties_2 imrr_enjoypeople_2 imrr_sharefeelings_2 imrr_shywithpeople_2 imrr_enthusiastic_2 imrr_talktomanypeople_2 imrr_talkative_2 imrr_expressingthoughts_2 imrr_workwithother_2 imrr_understandotherfeeling_2 imrr_trustingofother_2 imrr_rudetoother_2 imrr_toleratefaults_2 imrr_forgiveother_2 imrr_helpfulwithothers_2 imrr_managestress_2 imrr_nervous_2 imrr_changemood_2 imrr_feeldepressed_2 imrr_easilyupset_2 imrr_worryalot_2 imrr_staycalm_2 

qui minap $big5
qui factor $big5, pcf fa(5) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B5)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B5)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa4)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore



********** Factor analysis 5: with grit for female
preserve
keep if sex==2
global big5 ///
imrr_curious_2 imrr_interestedbyart_2 imrr_repetitivetasks_2 imrr_inventive_2 imrr_liketothink_2 imrr_newideas_2 imrr_activeimagination_2 imrr_organized_2 imrr_makeplans_2 imrr_workhard_2 imrr_appointmentontime_2 imrr_putoffduties_2 imrr_easilydistracted_2 imrr_completeduties_2 imrr_enjoypeople_2 imrr_sharefeelings_2 imrr_shywithpeople_2 imrr_enthusiastic_2 imrr_talktomanypeople_2 imrr_talkative_2 imrr_expressingthoughts_2 imrr_workwithother_2 imrr_understandotherfeeling_2 imrr_trustingofother_2 imrr_rudetoother_2 imrr_toleratefaults_2 imrr_forgiveother_2 imrr_helpfulwithothers_2 imrr_managestress_2 imrr_nervous_2 imrr_changemood_2 imrr_feeldepressed_2 imrr_easilyupset_2 imrr_worryalot_2 imrr_staycalm_2 imrr_tryhard_2 imrr_stickwithgoals_2 imrr_goaftergoal_2 imrr_finishwhatbegin_2 imrr_finishtasks_2 imrr_keepworking_2

qui minap $big5
qui factor $big5, pcf fa(6) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B6)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B6)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5 f_6
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5 f_6
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa5)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


********** Factor analysis 6: without grit for female
preserve
keep if sex==2
global big5 ///
imrr_curious_2 imrr_interestedbyart_2 imrr_repetitivetasks_2 imrr_inventive_2 imrr_liketothink_2 imrr_newideas_2 imrr_activeimagination_2 imrr_organized_2 imrr_makeplans_2 imrr_workhard_2 imrr_appointmentontime_2 imrr_putoffduties_2 imrr_easilydistracted_2 imrr_completeduties_2 imrr_enjoypeople_2 imrr_sharefeelings_2 imrr_shywithpeople_2 imrr_enthusiastic_2 imrr_talktomanypeople_2 imrr_talkative_2 imrr_expressingthoughts_2 imrr_workwithother_2 imrr_understandotherfeeling_2 imrr_trustingofother_2 imrr_rudetoother_2 imrr_toleratefaults_2 imrr_forgiveother_2 imrr_helpfulwithothers_2 imrr_managestress_2 imrr_nervous_2 imrr_changemood_2 imrr_feeldepressed_2 imrr_easilyupset_2 imrr_worryalot_2 imrr_staycalm_2  

qui minap $big5
qui factor $big5, pcf fa(5) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B7)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B7)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa6)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


********** Factor analysis 7: with grit for dalit
preserve
keep if caste==1
global big5 ///
imrr_curious_2 imrr_interestedbyart_2 imrr_repetitivetasks_2 imrr_inventive_2 imrr_liketothink_2 imrr_newideas_2 imrr_activeimagination_2 imrr_organized_2 imrr_makeplans_2 imrr_workhard_2 imrr_appointmentontime_2 imrr_putoffduties_2 imrr_easilydistracted_2 imrr_completeduties_2 imrr_enjoypeople_2 imrr_sharefeelings_2 imrr_shywithpeople_2 imrr_enthusiastic_2 imrr_talktomanypeople_2 imrr_talkative_2 imrr_expressingthoughts_2 imrr_workwithother_2 imrr_understandotherfeeling_2 imrr_trustingofother_2 imrr_rudetoother_2 imrr_toleratefaults_2 imrr_forgiveother_2 imrr_helpfulwithothers_2 imrr_managestress_2 imrr_nervous_2 imrr_changemood_2 imrr_feeldepressed_2 imrr_easilyupset_2 imrr_worryalot_2 imrr_staycalm_2 imrr_tryhard_2 imrr_stickwithgoals_2 imrr_goaftergoal_2 imrr_finishwhatbegin_2 imrr_finishtasks_2 imrr_keepworking_2

qui minap $big5
qui factor $big5, pcf fa(6) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B8)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B8)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5 f_6
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5 f_6
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa7)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


********** Factor analysis 8: without grit for dalit
preserve
keep if caste==1
global big5 ///
imrr_curious_2 imrr_interestedbyart_2 imrr_repetitivetasks_2 imrr_inventive_2 imrr_liketothink_2 imrr_newideas_2 imrr_activeimagination_2 imrr_organized_2 imrr_makeplans_2 imrr_workhard_2 imrr_appointmentontime_2 imrr_putoffduties_2 imrr_easilydistracted_2 imrr_completeduties_2 imrr_enjoypeople_2 imrr_sharefeelings_2 imrr_shywithpeople_2 imrr_enthusiastic_2 imrr_talktomanypeople_2 imrr_talkative_2 imrr_expressingthoughts_2 imrr_workwithother_2 imrr_understandotherfeeling_2 imrr_trustingofother_2 imrr_rudetoother_2 imrr_toleratefaults_2 imrr_forgiveother_2 imrr_helpfulwithothers_2 imrr_managestress_2 imrr_nervous_2 imrr_changemood_2 imrr_feeldepressed_2 imrr_easilyupset_2 imrr_worryalot_2 imrr_staycalm_2 

qui minap $big5
qui factor $big5, pcf fa(5) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B9)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B9)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa8)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore



********** Factor analysis 9: with grit for non-dalit
preserve
keep if caste==2 | caste==3
global big5 ///
imrr_curious_2 imrr_interestedbyart_2 imrr_repetitivetasks_2 imrr_inventive_2 imrr_liketothink_2 imrr_newideas_2 imrr_activeimagination_2 imrr_organized_2 imrr_makeplans_2 imrr_workhard_2 imrr_appointmentontime_2 imrr_putoffduties_2 imrr_easilydistracted_2 imrr_completeduties_2 imrr_enjoypeople_2 imrr_sharefeelings_2 imrr_shywithpeople_2 imrr_enthusiastic_2 imrr_talktomanypeople_2 imrr_talkative_2 imrr_expressingthoughts_2 imrr_workwithother_2 imrr_understandotherfeeling_2 imrr_trustingofother_2 imrr_rudetoother_2 imrr_toleratefaults_2 imrr_forgiveother_2 imrr_helpfulwithothers_2 imrr_managestress_2 imrr_nervous_2 imrr_changemood_2 imrr_feeldepressed_2 imrr_easilyupset_2 imrr_worryalot_2 imrr_staycalm_2 imrr_tryhard_2 imrr_stickwithgoals_2 imrr_goaftergoal_2 imrr_finishwhatbegin_2 imrr_finishtasks_2 imrr_keepworking_2

qui minap $big5
qui factor $big5, pcf fa(6) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B10)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B10)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5 f_6
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5 f_6
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa9)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


********** Factor analysis 10: without grit for non-dalit
preserve
keep if caste==2 | caste==3
global big5 ///
imrr_curious_2 imrr_interestedbyart_2 imrr_repetitivetasks_2 imrr_inventive_2 imrr_liketothink_2 imrr_newideas_2 imrr_activeimagination_2 imrr_organized_2 imrr_makeplans_2 imrr_workhard_2 imrr_appointmentontime_2 imrr_putoffduties_2 imrr_easilydistracted_2 imrr_completeduties_2 imrr_enjoypeople_2 imrr_sharefeelings_2 imrr_shywithpeople_2 imrr_enthusiastic_2 imrr_talktomanypeople_2 imrr_talkative_2 imrr_expressingthoughts_2 imrr_workwithother_2 imrr_understandotherfeeling_2 imrr_trustingofother_2 imrr_rudetoother_2 imrr_toleratefaults_2 imrr_forgiveother_2 imrr_helpfulwithothers_2 imrr_managestress_2 imrr_nervous_2 imrr_changemood_2 imrr_feeldepressed_2 imrr_easilyupset_2 imrr_worryalot_2 imrr_staycalm_2  

qui minap $big5
qui factor $big5, pcf fa(5) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B11)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B11)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa10)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


****************************************
* END




















****************************************
* Factor analysis 2016-17
****************************************

********** 
use"panel_stab_v4", clear
drop *_2
drop if egoid==.


********** Factor analysis 1: with grit for total sample
preserve
global big5 ///
imrr_curious_1 imrr_interestedbyart_1 imrr_repetitivetasks_1 imrr_inventive_1 imrr_liketothink_1 imrr_newideas_1 imrr_activeimagination_1 imrr_organized_1 imrr_makeplans_1 imrr_workhard_1 imrr_appointmentontime_1 imrr_putoffduties_1 imrr_easilydistracted_1 imrr_completeduties_1 imrr_enjoypeople_1 imrr_sharefeelings_1 imrr_shywithpeople_1 imrr_enthusiastic_1 imrr_talktomanypeople_1 imrr_talkative_1 imrr_expressingthoughts_1 imrr_workwithother_1 imrr_understandotherfeeling_1 imrr_trustingofother_1 imrr_rudetoother_1 imrr_toleratefaults_1 imrr_forgiveother_1 imrr_helpfulwithothers_1 imrr_managestress_1 imrr_nervous_1 imrr_changemood_1 imrr_feeldepressed_1 imrr_easilyupset_1 imrr_worryalot_1 imrr_staycalm_1 imrr_tryhard_1 imrr_stickwithgoals_1 imrr_goaftergoal_1 imrr_finishwhatbegin_1 imrr_finishtasks_1 imrr_keepworking_1

qui minap $big5
qui factor $big5, pcf fa(6) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B12)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B12)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5 f_6
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5 f_6
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa11)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


********** Factor analysis 2: without grit for total sample
preserve
global big5 ///
imrr_curious_1 imrr_interestedbyart_1 imrr_repetitivetasks_1 imrr_inventive_1 imrr_liketothink_1 imrr_newideas_1 imrr_activeimagination_1 imrr_organized_1 imrr_makeplans_1 imrr_workhard_1 imrr_appointmentontime_1 imrr_putoffduties_1 imrr_easilydistracted_1 imrr_completeduties_1 imrr_enjoypeople_1 imrr_sharefeelings_1 imrr_shywithpeople_1 imrr_enthusiastic_1 imrr_talktomanypeople_1 imrr_talkative_1 imrr_expressingthoughts_1 imrr_workwithother_1 imrr_understandotherfeeling_1 imrr_trustingofother_1 imrr_rudetoother_1 imrr_toleratefaults_1 imrr_forgiveother_1 imrr_helpfulwithothers_1 imrr_managestress_1 imrr_nervous_1 imrr_changemood_1 imrr_feeldepressed_1 imrr_easilyupset_1 imrr_worryalot_1 imrr_staycalm_1

qui minap $big5
qui factor $big5, pcf fa(5) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B13)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B13)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa12)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore



********** Factor analysis 3: with grit for male
preserve
keep if sex==1
global big5 ///
imrr_curious_1 imrr_interestedbyart_1 imrr_repetitivetasks_1 imrr_inventive_1 imrr_liketothink_1 imrr_newideas_1 imrr_activeimagination_1 imrr_organized_1 imrr_makeplans_1 imrr_workhard_1 imrr_appointmentontime_1 imrr_putoffduties_1 imrr_easilydistracted_1 imrr_completeduties_1 imrr_enjoypeople_1 imrr_sharefeelings_1 imrr_shywithpeople_1 imrr_enthusiastic_1 imrr_talktomanypeople_1 imrr_talkative_1 imrr_expressingthoughts_1 imrr_workwithother_1 imrr_understandotherfeeling_1 imrr_trustingofother_1 imrr_rudetoother_1 imrr_toleratefaults_1 imrr_forgiveother_1 imrr_helpfulwithothers_1 imrr_managestress_1 imrr_nervous_1 imrr_changemood_1 imrr_feeldepressed_1 imrr_easilyupset_1 imrr_worryalot_1 imrr_staycalm_1 imrr_tryhard_1 imrr_stickwithgoals_1 imrr_goaftergoal_1 imrr_finishwhatbegin_1 imrr_finishtasks_1 imrr_keepworking_1

qui minap $big5
qui factor $big5, pcf fa(6) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B14)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B14)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5 f_6
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5 f_6
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa13)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


********** Factor analysis 4: without grit for male
preserve
keep if sex==1
global big5 ///
imrr_curious_1 imrr_interestedbyart_1 imrr_repetitivetasks_1 imrr_inventive_1 imrr_liketothink_1 imrr_newideas_1 imrr_activeimagination_1 imrr_organized_1 imrr_makeplans_1 imrr_workhard_1 imrr_appointmentontime_1 imrr_putoffduties_1 imrr_easilydistracted_1 imrr_completeduties_1 imrr_enjoypeople_1 imrr_sharefeelings_1 imrr_shywithpeople_1 imrr_enthusiastic_1 imrr_talktomanypeople_1 imrr_talkative_1 imrr_expressingthoughts_1 imrr_workwithother_1 imrr_understandotherfeeling_1 imrr_trustingofother_1 imrr_rudetoother_1 imrr_toleratefaults_1 imrr_forgiveother_1 imrr_helpfulwithothers_1 imrr_managestress_1 imrr_nervous_1 imrr_changemood_1 imrr_feeldepressed_1 imrr_easilyupset_1 imrr_worryalot_1 imrr_staycalm_1  

qui minap $big5
qui factor $big5, pcf fa(5) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B15)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B15)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa14)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore



********** Factor analysis 5: with grit for female
preserve
keep if sex==2
global big5 ///
imrr_curious_1 imrr_interestedbyart_1 imrr_repetitivetasks_1 imrr_inventive_1 imrr_liketothink_1 imrr_newideas_1 imrr_activeimagination_1 imrr_organized_1 imrr_makeplans_1 imrr_workhard_1 imrr_appointmentontime_1 imrr_putoffduties_1 imrr_easilydistracted_1 imrr_completeduties_1 imrr_enjoypeople_1 imrr_sharefeelings_1 imrr_shywithpeople_1 imrr_enthusiastic_1 imrr_talktomanypeople_1 imrr_talkative_1 imrr_expressingthoughts_1 imrr_workwithother_1 imrr_understandotherfeeling_1 imrr_trustingofother_1 imrr_rudetoother_1 imrr_toleratefaults_1 imrr_forgiveother_1 imrr_helpfulwithothers_1 imrr_managestress_1 imrr_nervous_1 imrr_changemood_1 imrr_feeldepressed_1 imrr_easilyupset_1 imrr_worryalot_1 imrr_staycalm_1 imrr_tryhard_1 imrr_stickwithgoals_1 imrr_goaftergoal_1 imrr_finishwhatbegin_1 imrr_finishtasks_1 imrr_keepworking_1

qui minap $big5
qui factor $big5, pcf fa(6) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B16)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B16)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5 f_6
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5 f_6
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa15)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


********** Factor analysis 6: without grit for female
preserve
keep if sex==2
global big5 ///
imrr_curious_1 imrr_interestedbyart_1 imrr_repetitivetasks_1 imrr_inventive_1 imrr_liketothink_1 imrr_newideas_1 imrr_activeimagination_1 imrr_organized_1 imrr_makeplans_1 imrr_workhard_1 imrr_appointmentontime_1 imrr_putoffduties_1 imrr_easilydistracted_1 imrr_completeduties_1 imrr_enjoypeople_1 imrr_sharefeelings_1 imrr_shywithpeople_1 imrr_enthusiastic_1 imrr_talktomanypeople_1 imrr_talkative_1 imrr_expressingthoughts_1 imrr_workwithother_1 imrr_understandotherfeeling_1 imrr_trustingofother_1 imrr_rudetoother_1 imrr_toleratefaults_1 imrr_forgiveother_1 imrr_helpfulwithothers_1 imrr_managestress_1 imrr_nervous_1 imrr_changemood_1 imrr_feeldepressed_1 imrr_easilyupset_1 imrr_worryalot_1 imrr_staycalm_1 

qui minap $big5
qui factor $big5, pcf fa(5) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B17)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B17)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa16)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


********** Factor analysis 7: with grit for dalit
preserve
keep if caste==1
global big5 ///
imrr_curious_1 imrr_interestedbyart_1 imrr_repetitivetasks_1 imrr_inventive_1 imrr_liketothink_1 imrr_newideas_1 imrr_activeimagination_1 imrr_organized_1 imrr_makeplans_1 imrr_workhard_1 imrr_appointmentontime_1 imrr_putoffduties_1 imrr_easilydistracted_1 imrr_completeduties_1 imrr_enjoypeople_1 imrr_sharefeelings_1 imrr_shywithpeople_1 imrr_enthusiastic_1 imrr_talktomanypeople_1 imrr_talkative_1 imrr_expressingthoughts_1 imrr_workwithother_1 imrr_understandotherfeeling_1 imrr_trustingofother_1 imrr_rudetoother_1 imrr_toleratefaults_1 imrr_forgiveother_1 imrr_helpfulwithothers_1 imrr_managestress_1 imrr_nervous_1 imrr_changemood_1 imrr_feeldepressed_1 imrr_easilyupset_1 imrr_worryalot_1 imrr_staycalm_1 imrr_tryhard_1 imrr_stickwithgoals_1 imrr_goaftergoal_1 imrr_finishwhatbegin_1 imrr_finishtasks_1 imrr_keepworking_1

qui minap $big5
qui factor $big5, pcf fa(6) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B18)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B18)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5 f_6
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5 f_6
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa17)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


********** Factor analysis 8: without grit for dalit
preserve
keep if caste==1
global big5 ///
imrr_curious_1 imrr_interestedbyart_1 imrr_repetitivetasks_1 imrr_inventive_1 imrr_liketothink_1 imrr_newideas_1 imrr_activeimagination_1 imrr_organized_1 imrr_makeplans_1 imrr_workhard_1 imrr_appointmentontime_1 imrr_putoffduties_1 imrr_easilydistracted_1 imrr_completeduties_1 imrr_enjoypeople_1 imrr_sharefeelings_1 imrr_shywithpeople_1 imrr_enthusiastic_1 imrr_talktomanypeople_1 imrr_talkative_1 imrr_expressingthoughts_1 imrr_workwithother_1 imrr_understandotherfeeling_1 imrr_trustingofother_1 imrr_rudetoother_1 imrr_toleratefaults_1 imrr_forgiveother_1 imrr_helpfulwithothers_1 imrr_managestress_1 imrr_nervous_1 imrr_changemood_1 imrr_feeldepressed_1 imrr_easilyupset_1 imrr_worryalot_1 imrr_staycalm_1 

qui minap $big5
qui factor $big5, pcf fa(5) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B19)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B19)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa18)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore



********** Factor analysis 9: with grit for non-dalit
preserve
keep if caste==2 | caste==3
global big5 ///
imrr_curious_1 imrr_interestedbyart_1 imrr_repetitivetasks_1 imrr_inventive_1 imrr_liketothink_1 imrr_newideas_1 imrr_activeimagination_1 imrr_organized_1 imrr_makeplans_1 imrr_workhard_1 imrr_appointmentontime_1 imrr_putoffduties_1 imrr_easilydistracted_1 imrr_completeduties_1 imrr_enjoypeople_1 imrr_sharefeelings_1 imrr_shywithpeople_1 imrr_enthusiastic_1 imrr_talktomanypeople_1 imrr_talkative_1 imrr_expressingthoughts_1 imrr_workwithother_1 imrr_understandotherfeeling_1 imrr_trustingofother_1 imrr_rudetoother_1 imrr_toleratefaults_1 imrr_forgiveother_1 imrr_helpfulwithothers_1 imrr_managestress_1 imrr_nervous_1 imrr_changemood_1 imrr_feeldepressed_1 imrr_easilyupset_1 imrr_worryalot_1 imrr_staycalm_1 imrr_tryhard_1 imrr_stickwithgoals_1 imrr_goaftergoal_1 imrr_finishwhatbegin_1 imrr_finishtasks_1 imrr_keepworking_1

qui minap $big5
qui factor $big5, pcf fa(6) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B20)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B20)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5 f_6
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5 f_6
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa19)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


********** Factor analysis 10: without grit for non-dalit
preserve
keep if caste==2 | caste==3
global big5 ///
imrr_curious_1 imrr_interestedbyart_1 imrr_repetitivetasks_1 imrr_inventive_1 imrr_liketothink_1 imrr_newideas_1 imrr_activeimagination_1 imrr_organized_1 imrr_makeplans_1 imrr_workhard_1 imrr_appointmentontime_1 imrr_putoffduties_1 imrr_easilydistracted_1 imrr_completeduties_1 imrr_enjoypeople_1 imrr_sharefeelings_1 imrr_shywithpeople_1 imrr_enthusiastic_1 imrr_talktomanypeople_1 imrr_talkative_1 imrr_expressingthoughts_1 imrr_workwithother_1 imrr_understandotherfeeling_1 imrr_trustingofother_1 imrr_rudetoother_1 imrr_toleratefaults_1 imrr_forgiveother_1 imrr_helpfulwithothers_1 imrr_managestress_1 imrr_nervous_1 imrr_changemood_1 imrr_feeldepressed_1 imrr_easilyupset_1 imrr_worryalot_1 imrr_staycalm_1 

qui minap $big5
qui factor $big5, pcf fa(5) 
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(eigen)
putexcel (B21)=matrix(e(Ev))
qui rotate, promax
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(promax)
putexcel (B21)=matrix(e(r_Ev))

qui predict f_1 f_2 f_3 f_4 f_5
qui cpcorr $big5 \ f_1 f_2 f_3 f_4 f_5
putexcel set "$git\Analysis\Stability\Analysis\stat.xlsx", modify sheet(fa20)
putexcel (D2)=matrix(r(C))
putexcel (J2)=matrix(r(p))
restore


****************************************
* END













****************************************
* DATABASE
****************************************

********** Data base
forvalues i=1(1)20{
import excel "$git\Analysis\Stability\Analysis\stat.xlsx", sheet("fa`i'") firstrow clear
foreach x in C_F1 C_F2 C_F3 C_F4 C_F5 C_F6 p_F1 p_F2 p_F3 p_F4 p_F5 p_F6 {
rename `x' b`i'_`x'
}
save "$git\Analysis\Stability\Analysis\fa`i'.dta", replace
}

import excel "$git\Analysis\Stability\Analysis\stat.xlsx", sheet("promax") allstring clear
sxpose, clear firstnames
rename _var1 Factor
split Factor, p(F)
order Factor Factor2
drop Factor1 Factor
destring Factor2, replace
rename Factor2 Factor
destring var_mod1 var_mod2 var_mod3 var_mod4 var_mod5 var_mod6 var_mod7 var_mod8 var_mod9 var_mod10 var_mod11 var_mod12 var_mod13 var_mod14 var_mod15 var_mod16 var_mod17 var_mod18 var_mod19 var_mod20, replace
save "$git\Analysis\Stability\Analysis\promax_mod.dta", replace

import excel "$git\Analysis\Stability\Analysis\stat.xlsx", sheet("eigen") allstring clear
sxpose, clear firstnames
rename _var1 Factor
split Factor, p(F)
order Factor Factor2
drop Factor1 Factor
destring Factor2, replace
rename Factor2 Factor
destring ev_mod1 ev_mod2 ev_mod3 ev_mod4 ev_mod5 ev_mod6 ev_mod7 ev_mod8 ev_mod9 ev_mod10 ev_mod11 ev_mod12 ev_mod13 ev_mod14 ev_mod15 ev_mod16 ev_mod17 ev_mod18 ev_mod19 ev_mod20, replace
merge 1:1 Factor using "$git\Analysis\Stability\Analysis\promax_mod.dta", nogen

save "$git\Analysis\Stability\Analysis\promax_eigen.dta", replace
erase"$git\Analysis\Stability\Analysis\promax_mod.dta"


********** Merge
use"$git\Analysis\Stability\Analysis\fa1.dta", clear
forvalues i=2(1)20{
merge 1:1 N using "$git\Analysis\Stability\Analysis\fa`i'.dta", nogen
}
dropmiss, force

forvalues i=1(1)6{
foreach x in C_F p_F {
rename b1_`x'`i' with_tot_2020_`x'`i'
rename b3_`x'`i' with_mal_2020_`x'`i' 
rename b5_`x'`i' with_fem_2020_`x'`i'
rename b7_`x'`i' with_dal_2020_`x'`i'
rename b9_`x'`i' with_nda_2020_`x'`i'

rename b11_`x'`i' with_tot_2016_`x'`i'
rename b13_`x'`i' with_mal_2016_`x'`i' 
rename b15_`x'`i' with_fem_2016_`x'`i'
rename b17_`x'`i' with_dal_2016_`x'`i'
rename b19_`x'`i' with_nda_2016_`x'`i'

}
}

forvalues i=1(1)5{
foreach x in C_F p_F {
rename b2_`x'`i' without_tot_2020_`x'`i'
rename b4_`x'`i' without_mal_2020_`x'`i' 
rename b6_`x'`i' without_fem_2020_`x'`i'
rename b8_`x'`i' without_dal_2020_`x'`i'
rename b10_`x'`i' without_nda_2020_`x'`i'

rename b12_`x'`i' without_tot_2016_`x'`i'
rename b14_`x'`i' without_mal_2016_`x'`i' 
rename b16_`x'`i' without_fem_2016_`x'`i'
rename b18_`x'`i' without_dal_2016_`x'`i'
rename b20_`x'`i' without_nda_2016_`x'`i'

}
}

foreach x in repetitivetasks rudetoother easilydistracted putoffduties shywithpeople staycalm managestress{
replace Variable="`x' (r)" if Variable=="`x'"
}

rename Variable Variable_unique
egen Variable=concat(Variable_unique Big5), p(" - ")

save"factor.dta", replace
save"$git\Analysis\Stability\Analysis\factor.dta", replace

forvalues i=1(1)20{
erase "$git\Analysis\Stability\Analysis\fa`i'.dta"
}

****************************************
* END












****************************************
* GRAPH
****************************************
set graph off

*Graph
*twoway ///
*(connected var_with_`x'_`i'_C_F`j' with_`x'_`i'_C_F`j', msymbol(o) msize(*0.2) lwidth(*0.2)) ///
*(scatter var_with_`x'_`i'_C_F`j' with_`x'_`i'_C_F`j', mlabel(with_`x'_`i'_C_F`j') mlabposition(3) mlabsize(*0.5) mlabangle(0) msymbol(i) xline(0.05, lpattern(solid) lcolor(gs12) lwidth(*0.5))) ///
*(scatter var_with_`x'_`i'_C_F`j' with_`x'_`i'_p_F`j', msymbol(X) mcolor(gs1) msize(*.5) xline(0, lpattern(solid) lcolor(gs1) lwidth(*0.5))) ///
*, ylabel(1(1)35, valuelabel labsize(tiny) angle(0)) ytitle("")  ///
*xlabel(, labsize(tiny) nogrid) xmtick() ///
*title("Factor `j'", size(small)) ///
*legend(order(1 "Correlation with factor" 3 "p-value" 4 ".05 threshold") pos(6) col(3) size(vsmall) off) ///
*name(g_with_`x'_`i'_`j', replace)  // aspectratio(10)
*sort n


*** With
preserve
gen n=_n
foreach x in tot mal fem dal nda {
foreach i in 2016 2020 {
forvalues j=1(1)6{

*Sort
gsort - with_`x'_`i'_C_F`j'
sencode Variable, gen(var_with_`x'_`i'_C_F`j') gsort(with_`x'_`i'_C_F`j')
replace with_`x'_`i'_C_F`j'=round(with_`x'_`i'_C_F`j', 0.01)

*Graph
twoway ///
(connected var_with_`x'_`i'_C_F`j' with_`x'_`i'_C_F`j', msymbol(o) msize(*0.2) lwidth(*0.2)) ///
(scatter var_with_`x'_`i'_C_F`j' with_`x'_`i'_C_F`j', mlabel(with_`x'_`i'_C_F`j') mlabposition(3) mlabsize(*0.5) mlabangle(0) msymbol(i) xline(0, lpattern(solid) lcolor(gs1) lwidth(*0.5))) ///
, ylabel(1(1)41, valuelabel labsize(tiny) angle(0)) ytitle("")  ///
xlabel(, labsize(tiny) nogrid) xmtick() xtitle("") ///
title("Factor `j'", size(small)) ///
legend(order(1 "Correlation with factor") pos(6) col(3) size(vsmall) off) ///
name(g_with_`x'_`i'_`j', replace)  // aspectratio(10)
sort n
}
}

grc1leg g_with_`x'_2016_1 g_with_`x'_2016_2 g_with_`x'_2016_3 g_with_`x'_2016_4 g_with_`x'_2016_5 g_with_`x'_2016_6, note("`x' sample." "NEEMSIS-1 (2016-17) data.", size(tiny)) name(comb_`x'_with_2016, replace)
graph save "$git\Analysis\Stability\Analysis\Graph\factor2016_`x'_with.gph", replace
graph export "$git\Analysis\Stability\Analysis\Graph\factor2016_`x'_with.pdf", as(pdf) replace

grc1leg g_with_`x'_2020_1 g_with_`x'_2020_2 g_with_`x'_2020_3 g_with_`x'_2020_4 g_with_`x'_2020_5 g_with_`x'_2020_6, note("`x' sample." "NEEMSIS-2 (2020-21) data.", size(tiny)) name(comb_`x'_with_2020, replace)
graph save "$git\Analysis\Stability\Analysis\Graph\factor2020_`x'_with.gph", replace
graph export "$git\Analysis\Stability\Analysis\Graph\factor2020_`x'_with.pdf", as(pdf) replace
}
restore


*** Without
preserve
gen n=_n
drop if n>35
foreach x in tot mal fem dal nda {
foreach i in 2016 2020 {
forvalues j=1(1)5{

*Sort
gsort - without_`x'_`i'_C_F`j'
sencode Variable, gen(var_without_`x'_`i'_C_F`j') gsort(without_`x'_`i'_C_F`j')
replace without_`x'_`i'_C_F`j'=round(without_`x'_`i'_C_F`j', 0.01)

*Graph
twoway ///
(connected var_without_`x'_`i'_C_F`j' without_`x'_`i'_C_F`j', msymbol(o) msize(*0.2) lwidth(*0.2)) ///
(scatter var_without_`x'_`i'_C_F`j' without_`x'_`i'_C_F`j', mlabel(without_`x'_`i'_C_F`j') mlabposition(3) mlabsize(*0.5) mlabangle(0) msymbol(i) xline(0, lpattern(solid) lcolor(gs1) lwidth(*0.5))) ///
, ylabel(1(1)35, valuelabel labsize(tiny) angle(0)) ytitle("")  ///
xlabel(, labsize(tiny) nogrid) xmtick() xtitle("")  ///
title("Factor `j'", size(small)) ///
legend(order(1 "Correlation") pos(6) col(3) size(vsmall) off) ///
name(g_without_`x'_`i'_`j', replace)  // aspectratio(10)
sort n
}
}

grc1leg g_without_`x'_2016_1 g_without_`x'_2016_2 g_without_`x'_2016_3 g_without_`x'_2016_4 g_without_`x'_2016_5, note("`x' sample." "NEEMSIS-1 (2016-17) data.", size(tiny)) name(comb_`x'_without_2016, replace)
graph save "$git\Analysis\Stability\Analysis\Graph\factor2016_`x'_without.gph", replace
graph export "$git\Analysis\Stability\Analysis\Graph\factor2016_`x'_without.pdf", as(pdf) replace

grc1leg g_without_`x'_2020_1 g_without_`x'_2020_2 g_without_`x'_2020_3 g_without_`x'_2020_4 g_without_`x'_2020_5, note("`x' sample." "NEEMSIS-2 (2020-21) data.", size(tiny)) name(comb_`x'_without_2020, replace)
graph save "$git\Analysis\Stability\Analysis\Graph\factor2020_`x'_without.gph", replace
graph export "$git\Analysis\Stability\Analysis\Graph\factor2020_`x'_without.pdf", as(pdf) replace
}
restore
****************************************
* END














****************************************
* STAT
****************************************
use"$git\Analysis\Stability\Analysis\promax_eigen.dta", clear

*Nb de fact tot
forvalues i=1(1)20{
egen sum_mod`i'=sum(ev_mod`i')
}

*Replace ev
foreach i in 1 3 5 7 9 11 13 15 17 19 {
replace ev_mod`i'=. if Factor>6
}
foreach i in 2 4 6 8 10 12 14 16 18 20 {
replace ev_mod`i'=. if Factor>5
}

*Clean
drop if Factor>=7

********** Factor analysis
*Prop de la var expliqué par les facteurs
forvalues i=1(1)20{
gen prop_ev_mod`i'=ev_mod`i'*100/sum_mod`i'
}

*Sum explain by factor
forvalues i=1(1)20{
egen sum_ev_mod`i'=sum(prop_ev_mod`i')
}


********** Rotate promax
*Prop de la var expliqué par les facteurs
forvalues i=1(1)20{
gen prop_var_mod`i'=var_mod`i'*100/sum_mod`i'
}

*Sum explain by factor
forvalues i=1(1)20{
egen sum_var_mod`i'=sum(prop_var_mod`i')
}

foreach x in ev var sum prop_ev sum_ev prop_var sum_var {
rename `x'_mod1 `x'_with_tot_2020
rename `x'_mod2 `x'_without_tot_2020
rename `x'_mod3 `x'_with_mal_2020
rename `x'_mod4 `x'_without_mal_2020
rename `x'_mod5 `x'_with_fem_2020
rename `x'_mod6 `x'_without_fem_2020
rename `x'_mod7 `x'_with_dal_2020
rename `x'_mod8 `x'_without_dal_2020
rename `x'_mod9 `x'_with_nda_2020
rename `x'_mod10 `x'_without_nda_2020
rename `x'_mod11 `x'_with_tot_2016
rename `x'_mod12 `x'_without_tot_2016
rename `x'_mod13 `x'_with_mal_2016
rename `x'_mod14 `x'_without_mal_2016
rename `x'_mod15 `x'_with_fem_2016
rename `x'_mod16 `x'_without_fem_2016
rename `x'_mod17 `x'_with_dal_2016
rename `x'_mod18 `x'_without_dal_2016
rename `x'_mod19 `x'_with_nda_2016
rename `x'_mod20 `x'_without_nda_2016
}
rename Factor factor

*
save"$git\Analysis\Stability\Analysis\promax_eigen_v2.dta", replace

use"$git\Analysis\Stability\Analysis\promax_eigen_v2.dta", clear
*Var with only tot
global ok factor sum_ev_with_tot_2020 sum_ev_without_tot_2020 sum_ev_with_mal_2020 sum_ev_without_mal_2020 sum_ev_with_fem_2020 sum_ev_without_fem_2020 sum_ev_with_dal_2020 sum_ev_without_dal_2020 sum_ev_with_nda_2020 sum_ev_without_nda_2020 sum_ev_with_tot_2016 sum_ev_without_tot_2016 sum_ev_with_mal_2016 sum_ev_without_mal_2016 sum_ev_with_fem_2016 sum_ev_without_fem_2016 sum_ev_with_dal_2016 sum_ev_without_dal_2016 sum_ev_with_nda_2016 sum_ev_without_nda_2016 sum_var_with_tot_2020 sum_var_without_tot_2020 sum_var_with_mal_2020 sum_var_without_mal_2020 sum_var_with_fem_2020 sum_var_without_fem_2020 sum_var_with_dal_2020 sum_var_without_dal_2020 sum_var_with_nda_2020 sum_var_without_nda_2020 sum_var_with_tot_2016 sum_var_without_tot_2016 sum_var_with_mal_2016 sum_var_without_mal_2016 sum_var_with_fem_2016 sum_var_without_fem_2016 sum_var_with_dal_2016 sum_var_without_dal_2016 sum_var_with_nda_2016 sum_var_without_nda_2016
keep $ok
tostring $ok, replace force
*Transposer matrice pour faire catplot
sxpose, clear firstnames
keep _var1
destring _var1, gen(ev)
keep ev
gen var=.
replace var=ev[_n+20]
gen subsample=_n
drop if subsample>20
tostring subsample, replace
order subsample
replace subsample="with_tot_2020" if subsample=="1"
replace subsample="without_tot_2020" if subsample=="2"
replace subsample="with_mal_2020" if subsample=="3"
replace subsample="without_mal_2020" if subsample=="4"
replace subsample="with_fem_2020" if subsample=="5"
replace subsample="without_fem_2020" if subsample=="6"
replace subsample="with_dal_2020" if subsample=="7"
replace subsample="without_dal_2020" if subsample=="8"
replace subsample="with_nda_2020" if subsample=="9"
replace subsample="without_nda_2020" if subsample=="10"
replace subsample="with_tot_2016" if subsample=="11"
replace subsample="without_tot_2016" if subsample=="12"
replace subsample="with_mal_2016" if subsample=="13"
replace subsample="without_mal_2016" if subsample=="14"
replace subsample="with_fem_2016" if subsample=="15"
replace subsample="without_fem_2016" if subsample=="16"
replace subsample="with_dal_2016" if subsample=="17"
replace subsample="without_dal_2016" if subsample=="18"
replace subsample="with_nda_2016" if subsample=="19"
replace subsample="without_nda_2016" if subsample=="20"

split subsample, p("_")
encode subsample1, gen(grit)
recode grit (1=1) (2=0)
label define grit 0"Without grit" 1"With grit", replace
label values grit grit

encode subsample2, gen(sample)
recode sample (5=1) (3=2) (2=3) (1=4) (4=5)
label define sample 1"Total" 2"Male" 3"Female" 4"Dalit" 5"Non-dalit", replace
label values sample sample

rename subsample3 year
destring year, replace
drop subsample subsample1 subsample2
order grit sample year

*
save"$git\Analysis\Stability\Analysis\promax_eigen_v3.dta", replace
****************************************
* END












****************************************
* STAT graph
****************************************
use"$git\Analysis\Stability\Analysis\promax_eigen_v2.dta", clear

********** Eigen values
set graph off
foreach x in with without {
foreach y in tot mal fem dal nda {
twoway ///
(connected ev_`x'_`y'_2016 factor) /// 
(connected ev_`x'_`y'_2020 factor), ///
xtitle("Factor") ///
ytitle("") ylabel(0(2)12, angle(0)) ymtick(0(1)11) ///
legend(order(1 "2016-17" 2 "2020-21") pos(6) col(2)) ///
title("`y'") ///
name(g_`x'_`y', replace)
}
grc1leg g_`x'_tot g_`x'_mal g_`x'_fem g_`x'_dal g_`x'_nda, note("`x' Grit.") leg(g_`x'_tot) cols(3) name(g_comb_`x', replace)
graph save "$git\Analysis\Stability\Analysis\Graph\eigen_`x'.gph", replace
graph export "$git\Analysis\Stability\Analysis\Graph\eigen_`x'.pdf", as(pdf) replace
}
set graph on


use"$git\Analysis\Stability\Analysis\promax_eigen_v3.dta", clear
********** Proportion eigen values
set graph off
forvalues i=0(1)1{
foreach x in ev var {
preserve 
keep if grit==`i'
graph bar `x', over(sample, label(labsize(vsmall) angle(45))) over(year, label(labsize(small))) blabel(bar, format(%4.2f) size(tiny)) ///
ytitle("Cumul prop of `x'", size(small)) note("Grit: `i'", size(tiny)) name(g_`x'_`i', replace)
restore
}
}

graph combine g_ev_0 g_ev_1 g_var_0 g_var_1
graph save "$git\Analysis\Stability\Analysis\Graph\cumul.gph", replace
graph export "$git\Analysis\Stability\Analysis\Graph\cumul.pdf", as(pdf) replace
set graph on

****************************************
* END


























****************************************
* Evolution
****************************************
********** 2016-17
global big5 ///
imrr_curious_1 imrr_interestedbyart_1 imrr_repetitivetasks_1 imrr_inventive_1 imrr_liketothink_1 imrr_newideas_1 imrr_activeimagination_1 imrr_organized_1 imrr_makeplans_1 imrr_workhard_1 imrr_appointmentontime_1 imrr_putoffduties_1 imrr_easilydistracted_1 imrr_completeduties_1 imrr_enjoypeople_1 imrr_sharefeelings_1 imrr_shywithpeople_1 imrr_enthusiastic_1 imrr_talktomanypeople_1 imrr_talkative_1 imrr_expressingthoughts_1 imrr_workwithother_1 imrr_understandotherfeeling_1 imrr_trustingofother_1 imrr_rudetoother_1 imrr_toleratefaults_1 imrr_forgiveother_1 imrr_helpfulwithothers_1 imrr_managestress_1 imrr_nervous_1 imrr_changemood_1 imrr_feeldepressed_1 imrr_easilyupset_1 imrr_worryalot_1 imrr_staycalm_1

qui factor $big5, pcf fa(5) 
qui rotate, promax
qui predict f1_1 f2_1 f3_1 f4_1 f5_1



********** 2020-21
global big5 ///
imrr_curious_2 imrr_interestedbyart_2 imrr_repetitivetasks_2 imrr_inventive_2 imrr_liketothink_2 imrr_newideas_2 imrr_activeimagination_2 imrr_organized_2 imrr_makeplans_2 imrr_workhard_2 imrr_appointmentontime_2 imrr_putoffduties_2 imrr_easilydistracted_2 imrr_completeduties_2 imrr_enjoypeople_2 imrr_sharefeelings_2 imrr_shywithpeople_2 imrr_enthusiastic_2 imrr_talktomanypeople_2 imrr_talkative_2 imrr_expressingthoughts_2 imrr_workwithother_2 imrr_understandotherfeeling_2 imrr_trustingofother_2 imrr_rudetoother_2 imrr_toleratefaults_2 imrr_forgiveother_2 imrr_helpfulwithothers_2 imrr_managestress_2 imrr_nervous_2 imrr_changemood_2 imrr_feeldepressed_2 imrr_easilyupset_2 imrr_worryalot_2 imrr_staycalm_2 

factor $big5, pcf fa(5) 
rotate, promax
qui predict f1_2 f2_2 f3_2 f4_2 f5_2



**Label
label var f1_1 "OP-EX"
label var f2_1 "CO"
label var f3_1 "Porupillatavan"
label var f4_1 "ES"
label var f5_1 "AG"

label var f1_2 "OP-AG"
label var f2_2 "CO"
label var f3_2 "ES"
label var f4_2 "Mix"
label var f5_2 "Mix"

gen simplediff_CO=f2_2-f2_1
gen simplediff_ES=f3_2-f4_1

histogram simplediff_CO
histogram simplediff_ES
