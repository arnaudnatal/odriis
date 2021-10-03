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
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"

cd"$directory"
clear all





****************************************
* Variables Arnaud
****************************************
use"$directory\CLEAN\NEEMSIS2-HH_v19.dta", clear


drop setoffamilymembers setofeducation setofindividualid setoflefthome setofremreceivedidgroup setofremsentidgroup setofmigrationidgroup setofloansbyborrower setoflendingmoney setofrecommendationgiven setofchitfund setofsavings setofgold setofinsurance setofschemenregaind setofcashassistancemarriagegroup setofgoldmarriagegroup setofschemepension1group setofschemepension2group setofschemepension3group setofschemepension4group setofschemepension5group setofschemepension6group setofschemepension7group

drop age_newfromearlier age_autofromearlier agefromearlier1 agefromearlier2

drop marriagegift_count 

drop setofmarriagefinance setofmarriagegift

drop imrr_curious imrr_interestedbyart imrr_repetitivetasks imrr_inventive imrr_liketothink imrr_newideas imrr_activeimagination imrr_organized imrr_makeplans imrr_workhard imrr_appointmentontime imrr_putoffduties imrr_easilydistracted imrr_completeduties imrr_enjoypeople imrr_sharefeelings imrr_shywithpeople imrr_enthusiastic imrr_talktomanypeople imrr_talkative imrr_expressingthoughts imrr_workwithother imrr_understandotherfeeling imrr_trustingofother imrr_rudetoother imrr_toleratefaults imrr_forgiveother imrr_helpfulwithothers imrr_managestress imrr_nervous imrr_changemood imrr_feeldepressed imrr_easilyupset imrr_worryalot imrr_staycalm imrr_tryhard imrr_stickwithgoals imrr_goaftergoal imrr_finishwhatbegin imrr_finishtasks imrr_keepworking imcr_curious imcr_interestedbyart imcr_repetitivetasks imcr_inventive imcr_liketothink imcr_newideas imcr_activeimagination imcr_organized imcr_makeplans imcr_workhard imcr_appointmentontime imcr_putoffduties imcr_easilydistracted imcr_completeduties imcr_enjoypeople imcr_sharefeelings imcr_shywithpeople imcr_enthusiastic imcr_talktomanypeople imcr_talkative imcr_expressingthoughts imcr_workwithother imcr_understandotherfeeling imcr_trustingofother imcr_rudetoother imcr_toleratefaults imcr_forgiveother imcr_helpfulwithothers imcr_managestress imcr_nervous imcr_changemood imcr_feeldepressed imcr_easilyupset imcr_worryalot imcr_staycalm imcr_tryhard imcr_stickwithgoals imcr_goaftergoal imcr_finishwhatbegin imcr_finishtasks imcr_keepworking

drop raw_curious rr_curious raw_interestedbyart rr_interestedbyart raw_repetitivetasks rr_repetitivetasks raw_inventive rr_inventive raw_liketothink rr_liketothink raw_newideas rr_newideas raw_activeimagination rr_activeimagination raw_organized rr_organized raw_makeplans rr_makeplans raw_workhard rr_workhard raw_appointmentontime rr_appointmentontime raw_putoffduties rr_putoffduties raw_easilydistracted rr_easilydistracted raw_completeduties rr_completeduties raw_enjoypeople rr_enjoypeople raw_sharefeelings rr_sharefeelings raw_shywithpeople rr_shywithpeople raw_enthusiastic rr_enthusiastic raw_talktomanypeople rr_talktomanypeople raw_talkative rr_talkative raw_expressingthoughts rr_expressingthoughts raw_workwithother rr_workwithother raw_understandotherfeeling rr_understandotherfeeling raw_trustingofother rr_trustingofother raw_rudetoother rr_rudetoother raw_toleratefaults rr_toleratefaults raw_forgiveother rr_forgiveother raw_helpfulwithothers rr_helpfulwithothers raw_managestress rr_managestress raw_nervous rr_nervous raw_changemood rr_changemood raw_feeldepressed rr_feeldepressed raw_easilyupset rr_easilyupset raw_worryalot rr_worryalot raw_staycalm rr_staycalm raw_tryhard rr_tryhard raw_stickwithgoals rr_stickwithgoals raw_goaftergoal rr_goaftergoal raw_finishwhatbegin rr_finishwhatbegin raw_finishtasks rr_finishtasks raw_keepworking rr_keepworking

drop remreceivedtotalamount_indiv remreceivedtotalamount_HH incomeassets_HH incomeassets_indiv otherhouserent_HH otherhouserent_indiv pension_indiv pension_HH  imp1_ds_tot_indiv imp1_is_tot_indiv informal_indiv semiformal_indiv formal_indiv economic_indiv current_indiv humancap_indiv social_indiv house_indiv incomegen_indiv noincomegen_indiv economic_amount_indiv current_amount_indiv humancap_amount_indiv social_amount_indiv house_amount_indiv incomegen_amount_indiv noincomegen_amount_indiv informal_amount_indiv formal_amount_indiv semiformal_amount_indiv marriageloan_indiv marriageloanamount_indiv dummyproblemtorepay_indiv dummyhelptosettleloan_indiv dummyinterest_indiv loanbalance_indiv mean_yratepaid_indiv mean_monthlyinterestrate_indiv sum_otherlenderservices_1 sum_otherlenderservices_2 sum_otherlenderservices_3 sum_otherlenderservices_4 sum_otherlenderservices_5 sum_borrowerservices_1 sum_borrowerservices_2 sum_borrowerservices_3 sum_borrowerservices_4 sum_plantorepay_1 sum_plantorepay_2 sum_plantorepay_3 sum_plantorepay_4 sum_plantorepay_5 sum_plantorepay_6 sum_settleloanstrategy_1 sum_settleloanstrategy_2 sum_settleloanstrategy_3 sum_settleloanstrategy_4 sum_settleloanstrategy_5 sum_settleloanstrategy_6 sum_settleloanstrategy_7 sum_settleloanstrategy_8 sum_settleloanstrategy_9 sum_settleloanstrategy_10 sum_debtrelation_shame imp1_ds_tot_HH imp1_is_tot_HH informal_HH semiformal_HH formal_HH economic_HH current_HH humancap_HH social_HH house_HH incomegen_HH noincomegen_HH economic_amount_HH current_amount_HH humancap_amount_HH social_amount_HH house_amount_HH incomegen_amount_HH noincomegen_amount_HH informal_amount_HH formal_amount_HH semiformal_amount_HH marriageloan_HH marriageloanamount_HH dummyproblemtorepay_HH dummyhelptosettleloan_HH dummyinterest_HH 

drop memberlistpreload2016_count lefthome_count individualid_count familymembers_count education_count employment_count migrationgroup_count remreceivedgroup_count remsentgroup_count loansbyborrower_count mainloans_count lendingmoney_count recommendationgiven_count chitfund_count savings_count gold_count insurance_count marriagegroup_count schemenregaind_count cashassistancemarriagegroup_coun goldmarriagegroup_count schemepension1group_count schemepension2group_count schemepension3group_count schemepension4group_count schemepension5group_count schemepension6group_count indoccupmonths_count businessloandetails_count businesspaymentinkindgroup_count snrecruitworkergroup_count wagejobpaymentinkindgroup_count formalsocialcapital_count snfindcurrentjobgroup_count snfindjobgroup_count snrecommendforjobgroup_count snrecojobsuccessgroup_count sntalkthemostgroup_count snhelpemergencygroup_count sncloserelouthhgroup_count covsnhelpreceivedgroup_count covsntypehelpreceivedgroup_count covsnhelpgivengroup_count covsntypehelpgivengroup_count contactgroup_count count_eligible_1825 count_eligible_2635 count_eligible_36 show_draws_count show_draws_2_count show_draws_3_count migrationjobidgroup_count detailsloanbyborrower_count detailschitfunds_count detailssavingaccounts_count setofdetailssavingaccounts detailsinsurance_count marriagefinance_count products_count livestock_count equipmentowned_count detailsgoods_count setofmemberlistpreload2016 setofmainloans setofdetailschitfunds setofdetailsinsurance

drop indiv loanbalance_HH mean_yratepaid_HH mean_monthlyinterestrate_HH

drop nameego2fromearlier nameego1fromearlierhh nameego1fromearlier indexego2fromearlier indexego2firststep indexego2 indexego1fromearlier indexego1firststep indexego1finalstep indexego1final indexego1 ego3positionname ego3position ego2position ego2index_36 ego2index_2635 ego2index_1825 ego2herefromearlier ego1herefromearlier

drop familymembersindex educationindex employmentindex sex_new age_new username_str Chithra_and_Radhika Suganya_and_Malarvizhi Vivek_Radja HHID dummynewHH dummydemonetisation villageid_new villageid_new_comments tracked namefrompreload

drop marriagepb adress

foreach x in migrantlist remrecipientlist remsenderlist borrowerlist hhlenderlist recommendgivenlist marriedlist nregarecipientlist schemeslist chitfundbelongerid savingsownerid goldownerid insuranceownerid schemerecipientlist3 schemerecipientlist4 schemerecipientlist5 schemerecipientlist6 schemerecipientlist7 schemerecipientlist8 schemerecipientlist9 schemerecipientlist10 {
rename `x'_ dummy_`x'
}


foreach x in curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination organized makeplans workhard appointmentontime putoffduties easilydistracted completeduties enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople talkative expressingthoughts workwithother understandotherfeeling trustingofother rudetoother toleratefaults forgiveother helpfulwithothers managestress nervous changemood feeldepressed easilyupset worryalot staycalm tryhard stickwithgoals goaftergoal finishwhatbegin finishtasks keepworking {
rename `x' `x'_recode
rename `x'_old `x'
}




global arnaud orga_HHagri mainoccupation_hours_indiv mainoccupation_income_indiv mainoccupation_indiv mainoccupationname_indiv annualincome_indiv nboccupation_indiv labourincome_indiv_agri labourincome_indiv_selfemp labourincome_indiv_sjagri labourincome_indiv_sjnonagri labourincome_indiv_uwhhnonagri labourincome_indiv_uwnonagri labourincome_indiv_uwhhagri labourincome_indiv_uwagri mainoccupation_HH annualincome_HH nboccupation_HH labourincome_HH_agri labourincome_HH_selfemp labourincome_HH_sjagri labourincome_HH_sjnonagri labourincome_HH_uwhhnonagri labourincome_HH_uwnonagri labourincome_HH_uwhhagri labourincome_HH_uwagri dummy_respondent2020 edulevel goodtotalamount2 assets assets_noland ra1 rab1 rb1 ra2 rab2 rb2 ra3 rab3 rb3 ra4 rab4 rb4 ra5 rab5 rb5 ra6 rab6 rb6 ra7 rab7 rb7 ra8 rab8 rb8 ra9 rab9 rb9 ra10 rab10 rb10 ra11 rab11 rb11 ra12 rab12 rb12 set_a set_ab set_b raven_tt refuse num_tt lit_tt ars ars2 ars3 cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot cr_staycalm cr_tryhard cr_stickwithgoals cr_goaftergoal cr_finishwhatbegin cr_finishtasks cr_keepworking cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit OP CO EX AG ES Grit totalincome_indiv totalincome_HH loans_indiv loanamount_indiv caste egoid dummyego understandotherfeeling_recode expressingthoughts_recode helpfulwithothers_recode appointmentontime_recode activeimagination_recode talktomanypeople_recode easilydistracted_recode trustingofother_recode repetitivetasks_recode interestedbyart_recode finishwhatbegin_recode toleratefaults_recode stickwithgoals_recode completeduties_recode workwithother_recode shywithpeople_recode sharefeelings_recode feeldepressed_recode putoffduties_recode managestress_recode forgiveother_recode enthusiastic_recode rudetoother_recode liketothink_recode keepworking_recode goaftergoal_recode finishtasks_recode enjoypeople_recode easilyupset_recode changemood_recode worryalot_recode talkative_recode organized_recode makeplans_recode inventive_recode workhard_recode staycalm_recode newideas_recode tryhard_recode nervous_recode curious_recode

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
order HHID_panel submissiondate year INDID_panel name sex age egoid jatis address villageid


*** Il en reste
drop everattendedschoolfromearlier everattendschoolfinal

*** drop
drop if HHID_panel==""

*** Verif
preserve
sort canread
drop if INDID_left!=.
drop if livinghome==4
drop if livinghome==3
sort canread
restore
/*
HHID_panel	submissiondate	year	INDID_panel
SEM44	10apr2021 18:05:50	2020	Ind_5
GOV5	09apr2021 11:35:51	2020	Ind_8
SEM44	10apr2021 18:05:50	2020	Ind_6
MAN23	11apr2021 19:34:01	2020	Ind_4
GOV38	09apr2021 12:04:57	2020	Ind_6
*/


save"$directory\CLEAN\NEEMSIS2-HH_v20.dta", replace
save"C:\Users\Arnaud\Dropbox\RUME-NEEMSIS\NEEMSIS2\NEEMSIS2-HH_v20.dta", replace

****************************************
* END






****************************************
* Loans
****************************************
use"$directory\CLEAN\NEEMSIS2-loans_v6", clear

drop _merge key3 key2 forauto loanreasongivenlabel

order setofmarriagefinance setofmarriagegroup setofloansbyborrower setofdetailsloanbyborrower setofmainloans, last

foreach v in loan_database version_HH loanlender_new2020 edulevel {
label variable `v' `"Arnaud `: variable label `v''"'
}

order HHID_panel INDID_panel name sex age jatis edulevel egoid loan_database loanamount

drop if HHID_panel==""
drop caste

save"$directory\CLEAN\NEEMSIS2-loans_v6bis", replace
save"C:\Users\Arnaud\Dropbox\RUME-NEEMSIS\NEEMSIS2\NEEMSIS2-loans_v6bis", replace

****************************************
* END
