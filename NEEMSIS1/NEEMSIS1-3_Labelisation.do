cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
September 16, 2021
-----
TITLE: Other file
-------------------------
*/

clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS1\DATA"

cd"$directory"
clear all





****************************************
* Variables Arnaud
****************************************
use"NEEMSIS1-HH_v7.dta", clear


drop loanbalance_indiv loanamount_wm_indiv mean_yratepaid_indiv mean_monthlyinterestrate_indiv sum_otherlenderservices_1 sum_otherlenderservices_2 sum_otherlenderservices_3 sum_otherlenderservices_4 sum_otherlenderservices_5 sum_borrowerservices_1 sum_borrowerservices_2 sum_borrowerservices_3 sum_borrowerservices_4 sum_plantorepay_1 sum_plantorepay_2 sum_plantorepay_3 sum_plantorepay_4 sum_plantorepay_5 sum_plantorepay_6 sum_settleloanstrategy_1 sum_settleloanstrategy_2 sum_settleloanstrategy_3 sum_settleloanstrategy_4 sum_settleloanstrategy_5 sum_settleloanstrategy_6 sum_settleloanstrategy_7 sum_settleloanstrategy_8 sum_settleloanstrategy_9 sum_settleloanstrategy_10 imp1_ds_tot_HH imp1_is_tot_HH imp1_ds_tot_wm_HH imp1_is_tot_wm_HH informal_HH semiformal_HH formal_HH economic_HH current_HH humancap_HH social_HH house_HH incomegen_HH noincomegen_HH economic_amount_HH current_amount_HH humancap_amount_HH social_amount_HH house_amount_HH incomegen_amount_HH noincomegen_amount_HH informal_amount_HH formal_amount_HH semiformal_amount_HH marriageloan_HH marriageloanamount_HH dummyproblemtorepay_HH dummyhelptosettleloan_HH dummyinterest_HH loans_HH loanamount_HH loanbalance_HH loanamount_wm_HH mean_yratepaid_HH mean_monthlyinterestrate_HH sum_ext_HH

drop amountownland_as2010 amountownlandwet_as2010 assets_as2010 assets_noland panel_2010_2016 panel_2010_2020 panel_2016_2020 panel_2010_2016_2020 remreceivedtotalamount_indiv remreceivedtotalamount_HH incomeassets_HH incomeassets_indiv otherhouserent_HH otherhouserent_indiv pension_indiv pension_HH raw_curious rr_curious raw_interestedbyart rr_interestedbyart raw_repetitivetasks rr_repetitivetasks raw_inventive rr_inventive raw_liketothink rr_liketothink raw_newideas rr_newideas raw_activeimagination rr_activeimagination raw_organized rr_organized raw_makeplans rr_makeplans raw_workhard rr_workhard raw_appointmentontime rr_appointmentontime raw_putoffduties rr_putoffduties raw_easilydistracted rr_easilydistracted raw_completeduties rr_completeduties raw_enjoypeople rr_enjoypeople raw_sharefeelings rr_sharefeelings raw_shywithpeople rr_shywithpeople raw_enthusiastic rr_enthusiastic raw_talktomanypeople rr_talktomanypeople raw_talkative rr_talkative raw_expressingthoughts rr_expressingthoughts raw_workwithother rr_workwithother raw_understandotherfeeling rr_understandotherfeeling raw_trustingofother rr_trustingofother raw_rudetoother rr_rudetoother raw_toleratefaults rr_toleratefaults raw_forgiveother rr_forgiveother raw_helpfulwithothers rr_helpfulwithothers raw_managestress rr_managestress raw_nervous rr_nervous raw_changemood rr_changemood raw_feeldepressed rr_feeldepressed raw_easilyupset rr_easilyupset raw_worryalot rr_worryalot raw_staycalm rr_staycalm raw_tryhard rr_tryhard raw_stickwithgoals rr_stickwithgoals raw_goaftergoal rr_goaftergoal raw_finishwhatbegin rr_finishwhatbegin raw_finishtasks rr_finishtasks raw_keepworking rr_keepworking ars ars2 ars3

drop imrr_curious imrr_interestedbyart imrr_repetitivetasks imrr_inventive imrr_liketothink imrr_newideas imrr_activeimagination imrr_organized imrr_makeplans imrr_workhard imrr_appointmentontime imrr_putoffduties imrr_easilydistracted imrr_completeduties imrr_enjoypeople imrr_sharefeelings imrr_shywithpeople imrr_enthusiastic imrr_talktomanypeople imrr_talkative imrr_expressingthoughts imrr_workwithother imrr_understandotherfeeling imrr_trustingofother imrr_rudetoother imrr_toleratefaults imrr_forgiveother imrr_helpfulwithothers imrr_managestress imrr_nervous imrr_changemood imrr_feeldepressed imrr_easilyupset imrr_worryalot imrr_staycalm imrr_tryhard imrr_stickwithgoals imrr_goaftergoal imrr_finishwhatbegin imrr_finishtasks imrr_keepworking imcr_curious imcr_interestedbyart imcr_repetitivetasks imcr_inventive imcr_liketothink imcr_newideas imcr_activeimagination imcr_organized imcr_makeplans imcr_workhard imcr_appointmentontime imcr_putoffduties imcr_easilydistracted imcr_completeduties imcr_enjoypeople imcr_sharefeelings imcr_shywithpeople imcr_enthusiastic imcr_talktomanypeople imcr_talkative imcr_expressingthoughts imcr_workwithother imcr_understandotherfeeling imcr_trustingofother imcr_rudetoother imcr_toleratefaults imcr_forgiveother imcr_helpfulwithothers imcr_managestress imcr_nervous imcr_changemood imcr_feeldepressed imcr_easilyupset imcr_worryalot imcr_staycalm imcr_tryhard imcr_stickwithgoals imcr_goaftergoal imcr_finishwhatbegin imcr_finishtasks imcr_keepworking

drop dummyinterest_indiv dummyhelptosettleloan_indiv dummyproblemtorepay_indiv marriageloanamount_indiv marriageloan_indiv semiformal_amount_indiv formal_amount_indiv informal_amount_indiv noincomegen_amount_indiv incomegen_amount_indiv house_amount_indiv social_amount_indiv humancap_amount_indiv current_amount_indiv economic_amount_indiv noincomegen_indiv incomegen_indiv house_indiv social_indiv humancap_indiv current_indiv economic_indiv formal_indiv semiformal_indiv informal_indiv imp1_is_tot_wm_indiv imp1_ds_tot_wm_indiv imp1_is_tot_indiv imp1_ds_tot_indiv






global arnaud orga_HHagri mainoccupation_hours_indiv mainoccupation_income_indiv mainoccupation_indiv mainoccupationname_indiv annualincome_indiv nboccupation_indiv labourincome_indiv_agri labourincome_indiv_selfemp labourincome_indiv_sjagri labourincome_indiv_sjnonagri labourincome_indiv_uwhhnonagri labourincome_indiv_uwnonagri labourincome_indiv_uwhhagri labourincome_indiv_uwagri mainoccupation_HH annualincome_HH nboccupation_HH labourincome_HH_agri labourincome_HH_selfemp labourincome_HH_sjagri labourincome_HH_sjnonagri labourincome_HH_uwhhnonagri labourincome_HH_uwnonagri labourincome_HH_uwhhagri labourincome_HH_uwagri dummy_respondent2020 edulevel goodtotalamount2 assets assets_noland ra1 rab1 rb1 ra2 rab2 rb2 ra3 rab3 rb3 ra4 rab4 rb4 ra5 rab5 rb5 ra6 rab6 rb6 ra7 rab7 rb7 ra8 rab8 rb8 ra9 rab9 rb9 ra10 rab10 rb10 ra11 rab11 rb11 ra12 rab12 rb12 set_a set_ab set_b raven_tt refuse num_tt lit_tt ars ars2 ars3 cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot cr_staycalm cr_tryhard cr_stickwithgoals cr_goaftergoal cr_finishwhatbegin cr_finishtasks cr_keepworking cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit OP CO EX AG ES Grit totalincome_indiv totalincome_HH loans_indiv loanamount_indiv caste egoid dummyego

foreach v of varlist $arnaud {
label variable `v' `"Arnaud `: variable label `v''"'
}

order $arnaud, last
order parent_key HHID_panel HHID householdid2020 startdate startquestionnaire enddate endquestionnaire submissiondate version_HH version_agri year

drop orga_HHagri

rename startquestionnaire start_HH_quest
rename endquestionnaire end_HH_quest

rename startdate start_agri_quest
rename enddate end_agri_quest

order start_HH_quest end_HH_quest start_agri_quest end_agri_quest, last


***Preload à ranger
*Comefrom
replace comefrom=comefrompreload2016 if comefrom=="" & comefrompreload2016!=""
drop comefrompreload2016

*Caste
drop castepreload2016 numfamilypreload2016 dummyeverhadlandpreload2016 ownlandpreload2016 sizeownlandpreload2016



***Sort data
sort HHID_panel INDID_panel


***From earlier
drop namefromearlier4 namefromearlier5 workedpastyearfromearlier mainoccupationfromearlier attendedschoolfromearlier namefromearlier sexfromearlier agefromearlier namefromearlier2 livinghomefromearlier2 namefromearlier3


***Selected
foreach x in selected_occupposition selected_occupname selected_months selected_months_monthsid {
rename `x'_ `x'
}


*** Order
order parent_key HHID_panel HHID householdid2020 submissiondate version_HH version_agri year INDID_panel name sex age egoid


save"$directory\CLEAN\NEEMSIS2-HH_v19.dta", replace
save"C:\Users\Arnaud\Dropbox\RUME-NEEMSIS\NEEMSIS2\NEEMSIS-HH_v19.dta", replace

****************************************
* END
