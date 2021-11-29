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
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS1"

cd"$directory"
clear all





****************************************
* Variables Arnaud
****************************************
use"NEEMSIS1-HH_v8.dta", clear


drop loanbalance_indiv loanamount_wm_indiv mean_yratepaid_indiv mean_monthlyinterestrate_indiv sum_otherlenderservices_1 sum_otherlenderservices_2 sum_otherlenderservices_3 sum_otherlenderservices_4 sum_otherlenderservices_5 sum_borrowerservices_1 sum_borrowerservices_2 sum_borrowerservices_3 sum_borrowerservices_4 sum_plantorepay_1 sum_plantorepay_2 sum_plantorepay_3 sum_plantorepay_4 sum_plantorepay_5 sum_plantorepay_6 sum_settleloanstrategy_1 sum_settleloanstrategy_2 sum_settleloanstrategy_3 sum_settleloanstrategy_4 sum_settleloanstrategy_5 sum_settleloanstrategy_6 sum_settleloanstrategy_7 sum_settleloanstrategy_8 sum_settleloanstrategy_9 sum_settleloanstrategy_10 imp1_ds_tot_HH imp1_is_tot_HH imp1_ds_tot_wm_HH imp1_is_tot_wm_HH informal_HH semiformal_HH formal_HH economic_HH current_HH humancap_HH social_HH house_HH incomegen_HH noincomegen_HH economic_amount_HH current_amount_HH humancap_amount_HH social_amount_HH house_amount_HH incomegen_amount_HH noincomegen_amount_HH informal_amount_HH formal_amount_HH semiformal_amount_HH marriageloan_HH marriageloanamount_HH dummyproblemtorepay_HH dummyhelptosettleloan_HH dummyinterest_HH loans_HH loanamount_HH loanbalance_HH loanamount_wm_HH mean_yratepaid_HH mean_monthlyinterestrate_HH sum_ext_HH

drop amountownland_as2010 amountownlandwet_as2010 assets_as2010 assets_noland remreceivedtotalamount_indiv remreceivedtotalamount_HH incomeassets_HH incomeassets_indiv otherhouserent_HH otherhouserent_indiv pension_indiv pension_HH ars ars2 ars3

drop dummyinterest_indiv dummyhelptosettleloan_indiv dummyproblemtorepay_indiv marriageloanamount_indiv marriageloan_indiv semiformal_amount_indiv formal_amount_indiv informal_amount_indiv noincomegen_amount_indiv incomegen_amount_indiv house_amount_indiv social_amount_indiv humancap_amount_indiv current_amount_indiv economic_amount_indiv noincomegen_indiv incomegen_indiv house_indiv social_indiv humancap_indiv current_indiv economic_indiv formal_indiv semiformal_indiv informal_indiv imp1_is_tot_wm_indiv imp1_ds_tot_wm_indiv imp1_is_tot_indiv imp1_ds_tot_indiv




global arnaud occinc_indiv_agri occinc_indiv_agricasual occinc_indiv_nonagricasual occinc_indiv_nonagriregnonqual occinc_indiv_nonagriregqual occinc_indiv_selfemp occinc_indiv_nrega occinc_HH_agri occinc_HH_agricasual occinc_HH_nonagricasual occinc_HH_nonagriregnonqual occinc_HH_nonagriregqual occinc_HH_selfemp occinc_HH_nrega kowinc_indiv_agri kowinc_indiv_selfemp kowinc_indiv_sjagri kowinc_indiv_sjnonagri kowinc_indiv_uwhhnonagri kowinc_indiv_uwnonagri kowinc_indiv_uwhhagri kowinc_indiv_uwagri kowinc_HH_agri kowinc_HH_selfemp kowinc_HH_sjagri kowinc_HH_sjnonagri kowinc_HH_uwhhnonagri kowinc_HH_uwnonagri kowinc_HH_uwhhagri kowinc_HH_uwagri mainocc_kindofwork_indiv mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_hoursayear_indiv mainocc_annualincome_indiv mainocc_jobdistance_indiv mainocc_occupationname_indiv mainocc_kindofwork_HH mainocc_occupation_HH edulevel caste goldquantityamount amountownlanddry amountownlandwet amountownland livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock goodtotalamount assets year totalincome_indiv totalincome_HH ra1 rab1 rb1 ra2 rab2 rb2 ra3 rab3 rb3 ra4 rab4 rb4 ra5 rab5 rb5 ra6 rab6 rb6 ra7 rab7 rb7 ra8 rab8 rb8 ra9 rab9 rb9 ra10 rab10 rb10 ra11 rab11 rb11 ra12 rab12 rb12 set_a set_ab set_b raven_tt refuse num_tt lit_tt cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot cr_staycalm cr_tryhard cr_stickwithgoals cr_goaftergoal cr_finishwhatbegin cr_finishtasks cr_keepworking cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit OP CO EX AG ES Grit loans_indiv loanamount_indiv enjoypeople curious organized managestress interestedbyart tryhard workwithother makeplans sharefeelings nervous stickwithgoals repetitivetasks shywithpeople workhard changemood understandotherfeeling inventive enthusiastic feeldepressed appointmentontime goaftergoal easilyupset talktomanypeople liketothink finishwhatbegin putoffduties rudetoother finishtasks toleratefaults worryalot easilydistracted keepworking completeduties talkative newideas staycalm forgiveother activeimagination expressingthoughts helpfulwithothers

foreach v of varlist $arnaud {
label variable `v' `"Arnaud `: variable label `v''"'
}

order $arnaud, last
order HHID_panel HHID2016 submissiondate year



***Sort data
sort HHID_panel INDID_panel


*** Order
order HHID_panel submissiondate year INDID_panel name sex age egoid jatis address villageid


save"$directory\NEEMSIS1-HH_v9.dta", replace



****************************************
* END










****************************************
* Variables Arnaud
****************************************
use"NEEMSIS1-loans_v4", clear

drop submissiondate_o loan_id lender2 lender3 lender4 totalrepaid2 interestpaid2 principalpaid2 yratepaid monthlyinterestrate ratiotest loanduration_wm totalrepaid2_wm loanamount_wm loanbalance_wm interestpaid2_wm annualincome_indiv annualincome_HH debt_service debt_service_wm interest_service interest_service_wm imp_principal imp1_interest imp1_totalrepaid_year imp1_debt_service imp1_debt_service_wm imp1_interest_service imp1_interest_service_wm imp1_ds_tot_indiv imp1_is_tot_indiv imp1_ds_tot_wm_indiv imp1_is_tot_wm_indiv imp1_ds_tot_HH imp1_is_tot_HH imp1_ds_tot_wm_HH imp1_is_tot_wm_HH marriageloan marriageloanamount loans informal_indiv informal_HH semiformal_indiv semiformal_HH formal_indiv formal_HH economic_indiv economic_HH current_indiv current_HH humancap_indiv humancap_HH social_indiv social_HH house_indiv house_HH incomegen_indiv incomegen_HH noincomegen_indiv noincomegen_HH economic_amount_indiv economic_amount_HH current_amount_indiv current_amount_HH humancap_amount_indiv humancap_amount_HH social_amount_indiv social_amount_HH house_amount_indiv house_amount_HH incomegen_amount_indiv incomegen_amount_HH noincomegen_amount_indiv noincomegen_amount_HH informal_amount_indiv informal_amount_HH formal_amount_indiv formal_amount_HH semiformal_amount_indiv semiformal_amount_HH marriageloan_indiv marriageloan_HH marriageloanamount_indiv marriageloanamount_HH dummyproblemtorepay_indiv dummyproblemtorepay_HH dummyhelptosettleloan_indiv dummyhelptosettleloan_HH dummyinterest_indiv dummyinterest_HH loans_indiv loans_HH loanamount_indiv loanamount_HH loanbalance_indiv loanbalance_HH loanamount_wm_indiv loanamount_wm_HH mean_yratepaid_indiv mean_monthlyinterestrate_indiv mean_yratepaid_HH mean_monthlyinterestrate_HH otherlenderservices_1 otherlenderservices_2 otherlenderservices_3 otherlenderservices_4 otherlenderservices_5 sum_otherlenderservices_1 sum_otherlenderservices_2 sum_otherlenderservices_3 sum_otherlenderservices_4 sum_otherlenderservices_5 borrowerservices_1 borrowerservices_2 borrowerservices_3 borrowerservices_4 sum_borrowerservices_1 sum_borrowerservices_2 sum_borrowerservices_3 sum_borrowerservices_4 plantorepay_1 plantorepay_2 plantorepay_3 plantorepay_4 plantorepay_5 plantorepay_6 sum_plantorepay_1 sum_plantorepay_2 sum_plantorepay_3 sum_plantorepay_4 sum_plantorepay_5 sum_plantorepay_6 settleloanstrategy_1 settleloanstrategy_2 settleloanstrategy_3 settleloanstrategy_4 settleloanstrategy_5 settleloanstrategy_6 settleloanstrategy_7 settleloanstrategy_8 settleloanstrategy_9 settleloanstrategy_10 sum_settleloanstrategy_1 sum_settleloanstrategy_2 sum_settleloanstrategy_3 sum_settleloanstrategy_4 sum_settleloanstrategy_5 sum_settleloanstrategy_6 sum_settleloanstrategy_7 sum_settleloanstrategy_8 sum_settleloanstrategy_9 sum_settleloanstrategy_10




foreach x in dummymainloan year submissiondate loanduration informal semiformal formal economic current humancap social house incomegen noincomegen economic_amount current_amount humancap_amount social_amount house_amount incomegen_amount noincomegen_amount informal_amount formal_amount semiformal_amount {
label variable `x' `"Arnaud `: variable label `v''"'
}

save"NEEMSIS1-loans_v12", replace
****************************************
* END
