cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
August 17, 2021
-----
Stability over time of personality traits: analysis p2
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


********** Name of the NEEMSIS2 questionnaire version to clean
global wave1 "RUME-HH_v8"
global wave2 "NEEMSIS1-HH_v7"
global wave3 "NEEMSIS2-HH_v17"
****************************************
* END









****************************************
* OMEGA
****************************************
use"panel_stab_v4", clear

********** LOOP

fre caste
clonevar dalit=caste
recode dalit (3=2)
tab dalit
tab agecat_1

/*
cls
forvalues x=2(1)2{ 
preserve
keep if sex==`x'
forvalues i=1(1)1{

omega raw_curious_`i' rr_interestedbyart_`i' rr_repetitivetasks_`i' rr_inventive_`i' rr_liketothink_`i' rr_newideas_`i' rr_activeimagination_`i', rev(rr_repetitivetasks_`i')
omega cr_curious_`i' cr_interestedbyart_`i' cr_repetitivetasks_`i' cr_inventive_`i' cr_liketothink_`i' cr_newideas_`i' cr_activeimagination_`i'

omega rr_organized_`i' rr_makeplans_`i' rr_workhard_`i' rr_appointmentontime_`i' rr_putoffduties_`i' rr_easilydistracted_`i' rr_completeduties_`i', rev(rr_putoffduties_`i' rr_easilydistracted_`i')
omega cr_organized_`i' cr_makeplans_`i' cr_workhard_`i' cr_appointmentontime_`i' cr_putoffduties_`i' cr_easilydistracted_`i' cr_completeduties_`i'

omega rr_enjoypeople_`i' rr_sharefeelings_`i' rr_shywithpeople_`i' rr_enthusiastic_`i' rr_talktomanypeople_`i' rr_talkative_`i' rr_expressingthoughts_`i', rev(rr_shywithpeople_`i')
omega cr_enjoypeople_`i' cr_sharefeelings_`i' cr_shywithpeople_`i' cr_enthusiastic_`i' cr_talktomanypeople_`i' cr_talkative_`i' cr_expressingthoughts_`i'

omega rr_workwithother_`i' rr_understandotherfeeling_`i' rr_trustingofother_`i' rr_rudetoother_`i' rr_toleratefaults_`i' rr_forgiveother_`i' rr_helpfulwithothers_`i', rev(rr_rudetoother_`i')
omega cr_workwithother_`i' cr_understandotherfeeling_`i' cr_trustingofother_`i' cr_rudetoother_`i' cr_toleratefaults_`i' cr_forgiveother_`i' cr_helpfulwithothers_`i'

omega rr_managestress_`i' rr_nervous_`i' rr_changemood_`i' rr_feeldepressed_`i' rr_easilyupset_`i' rr_worryalot_`i' rr_staycalm_`i', rev(rr_managestress_`i' rr_staycalm_`i')
omega cr_managestress_`i' cr_nervous_`i' cr_changemood_`i' cr_feeldepressed_`i' cr_easilyupset_`i' cr_worryalot_`i' cr_staycalm_`i'

omega rr_tryhard_`i' rr_stickwithgoals_`i' rr_goaftergoal_`i' rr_finishwhatbegin_`i' rr_finishtasks_`i' rr_keepworking_`i'
omega cr_tryhard_`i' cr_stickwithgoals_`i' cr_goaftergoal_`i' cr_finishwhatbegin_`i' cr_finishtasks_`i' cr_keepworking_`i'
}
restore
}
*/

****************************************
* END


















****************************************
* OMEGA RPZ
****************************************
import excel "$git\Analysis\Stability\Analysis\stat.xlsx", sheet("omega") firstrow clear

foreach x in Female Nondalit {
replace `x'="." if `x'=="X"
destring `x', replace
}
gen traits=.
replace traits=1 if Traits=="OP"
replace traits=2 if Traits=="CO"
replace traits=3 if Traits=="EX"
replace traits=4 if Traits=="AG"
replace traits=5 if Traits=="ES"
replace traits=6 if Traits=="Grit"
label define traits 1"OP" 2"CO" 3"EX" 4"AG" 5"ES" 6"Grit"
label values traits traits
drop Traits
gen year=.
replace year=2016 if Year=="2016-17"
replace year=2020 if Year=="2020-21"
drop Year
gen type=.
replace type=1 if Type=="Raw"
replace type=2 if Type=="Cor"
label define type 1"Raw" 2"Cor"
label values type type
drop Type
order type year traits
rename Totalsample total
rename Male male
rename Female female
rename Dalit dalit
rename Nondalit nondalit

save "$git\Analysis\Stability\Analysis\omega.dta", replace

********** Graph
set graph off
foreach x in total male female dalit nondalit {
graph bar `x', over(year) over(type) over(traits)  blabel(bar, format(%4.2f) size(tiny)) legend(pos(6) col(4) order(1 "2016-17" 2 "2020-21")) ytitle("McDonald's Ω") note("`x'", size(tiny)) name(g_`x', replace)
graph save "$git\Analysis\Stability\Analysis\Graph\omega_`x'.gph", replace
graph export "$git\Analysis\Stability\Analysis\Graph\omega_`x'.pdf", as(pdf) replace
}


*Only for corrected items
set graph off
preserve
keep if type==2
foreach x in total male female dalit nondalit {
graph bar `x', over(year) over(traits)  blabel(bar, format(%4.2f) size(tiny)) legend(pos(6) col(4) order(1 "2016-17" 2 "2020-21")) ytitle("McDonald's Ω") note("`x'", size(tiny)) name(g_`x', replace)
graph save "$git\Analysis\Stability\Analysis\Graph\omega_corr_`x'.gph", replace
graph export "$git\Analysis\Stability\Analysis\Graph\omega_corr_`x'.pdf", as(pdf) replace
}
restore

****************************************
* END
