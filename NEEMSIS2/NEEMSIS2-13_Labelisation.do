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


****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directorybis = "D:\Docuements\_Thesis\_DATA\NEEMSIS2\DATA"
global git = "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

*global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*global directorybis = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA"
*global git ="C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"


cd"$directory"
clear all
****************************************
* END




****************************************
* Variables Arnaud
****************************************
use"$directory\CLEAN\NEEMSIS2-HH_v19.dta", clear


drop setoffamilymembers setofeducation setofindividualid setoflefthome setofremreceivedidgroup setofremsentidgroup setofmigrationidgroup setofloansbyborrower setoflendingmoney setofrecommendationgiven setofchitfund setofsavings setofgold setofinsurance setofschemenregaind setofcashassistancemarriagegroup setofgoldmarriagegroup setofschemepension1group setofschemepension2group setofschemepension3group setofschemepension4group setofschemepension5group setofschemepension6group setofschemepension7group

drop age_newfromearlier age_autofromearlier agefromearlier1 agefromearlier2

drop marriagegift_count 

drop setofmarriagefinance setofmarriagegift


global drop1 remreceivedtotalamount_indiv remreceivedtotalamount_HH incomeassets_HH incomeassets_indiv otherhouserent_HH otherhouserent_indiv pension_indiv pension_HH  imp1_ds_tot_indiv imp1_is_tot_indiv informal_indiv semiformal_indiv formal_indiv economic_indiv current_indiv humancap_indiv social_indiv house_indiv incomegen_indiv noincomegen_indiv economic_amount_indiv current_amount_indiv humancap_amount_indiv social_amount_indiv house_amount_indiv incomegen_amount_indiv noincomegen_amount_indiv informal_amount_indiv formal_amount_indiv semiformal_amount_indiv marriageloan_indiv marriageloanamount_indiv dummyproblemtorepay_indiv dummyhelptosettleloan_indiv dummyinterest_indiv loanbalance_indiv mean_yratepaid_indiv mean_monthlyinterestrate_indiv sum_otherlenderservices_1 sum_otherlenderservices_2 sum_otherlenderservices_3 sum_otherlenderservices_4 sum_otherlenderservices_5 sum_borrowerservices_1 sum_borrowerservices_2 sum_borrowerservices_3 sum_borrowerservices_4 sum_plantorepay_1 sum_plantorepay_2 sum_plantorepay_3 sum_plantorepay_4 sum_plantorepay_5 sum_plantorepay_6 sum_settleloanstrategy_1 sum_settleloanstrategy_2 sum_settleloanstrategy_3 sum_settleloanstrategy_4 sum_settleloanstrategy_5 sum_settleloanstrategy_6 sum_settleloanstrategy_7 sum_settleloanstrategy_8 sum_settleloanstrategy_9 sum_settleloanstrategy_10 sum_debtrelation_shame imp1_ds_tot_HH imp1_is_tot_HH informal_HH semiformal_HH formal_HH economic_HH current_HH humancap_HH social_HH house_HH incomegen_HH noincomegen_HH economic_amount_HH current_amount_HH humancap_amount_HH social_amount_HH house_amount_HH incomegen_amount_HH noincomegen_amount_HH informal_amount_HH formal_amount_HH semiformal_amount_HH marriageloan_HH marriageloanamount_HH dummyproblemtorepay_HH dummyhelptosettleloan_HH dummyinterest_HH loanbalance_HH mean_yratepaid_HH mean_monthlyinterestrate_HH

foreach x in $drop1 {
capture confirm v `x'
if _rc==0 {
drop `x'
}
}

drop memberlistpreload2016_count lefthome_count individualid_count familymembers_count education_count employment_count migrationgroup_count remreceivedgroup_count remsentgroup_count loansbyborrower_count mainloans_count lendingmoney_count recommendationgiven_count chitfund_count savings_count gold_count insurance_count marriagegroup_count schemenregaind_count cashassistancemarriagegroup_coun goldmarriagegroup_count schemepension1group_count schemepension2group_count schemepension3group_count schemepension4group_count schemepension5group_count schemepension6group_count indoccupmonths_count businessloandetails_count businesspaymentinkindgroup_count snrecruitworkergroup_count wagejobpaymentinkindgroup_count formalsocialcapital_count snfindcurrentjobgroup_count snfindjobgroup_count snrecommendforjobgroup_count snrecojobsuccessgroup_count sntalkthemostgroup_count snhelpemergencygroup_count sncloserelouthhgroup_count covsnhelpreceivedgroup_count covsntypehelpreceivedgroup_count covsnhelpgivengroup_count covsntypehelpgivengroup_count contactgroup_count count_eligible_1825 count_eligible_2635 count_eligible_36 show_draws_count show_draws_2_count show_draws_3_count migrationjobidgroup_count detailsloanbyborrower_count detailschitfunds_count detailssavingaccounts_count setofdetailssavingaccounts detailsinsurance_count marriagefinance_count products_count livestock_count equipmentowned_count detailsgoods_count setofmemberlistpreload2016 setofmainloans setofdetailschitfunds setofdetailsinsurance


drop nameego2fromearlier nameego1fromearlierhh nameego1fromearlier indexego2fromearlier indexego2firststep indexego2 indexego1fromearlier indexego1firststep indexego1finalstep indexego1final indexego1 ego3positionname ego3position ego2position ego2index_36 ego2index_2635 ego2index_1825 ego2herefromearlier ego1herefromearlier

drop familymembersindex educationindex employmentindex sex_new age_new HHID dummydemonetisation villageid_new villageid_new_comments tracked namefrompreload

foreach x in migrantlist remrecipientlist remsenderlist borrowerlist hhlenderlist recommendgivenlist marriedlist nregarecipientlist schemeslist chitfundbelongerid savingsownerid goldownerid insuranceownerid schemerecipientlist3 schemerecipientlist4 schemerecipientlist5 schemerecipientlist6 schemerecipientlist7 schemerecipientlist8 schemerecipientlist9 schemerecipientlist10 {
rename `x'_ dummy_`x'
}

global arnaud orga_HHagri nboccupation_indiv nboccupation_HH occinc_indiv_agri occinc_indiv_agricasual occinc_indiv_nonagricasual occinc_indiv_nonagriregnonqual occinc_indiv_nonagriregqual occinc_indiv_selfemp occinc_indiv_nrega occinc_HH_agri occinc_HH_agricasual occinc_HH_nonagricasual occinc_HH_nonagriregnonqual occinc_HH_nonagriregqual occinc_HH_selfemp occinc_HH_nrega mainocc_kindofwork_indiv mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_hoursayear_indiv mainocc_annualincome_indiv mainocc_jobdistance_indiv mainocc_occupationname_indiv mainocc_kindofwork_HH mainocc_occupation_HH dummy_respondent2020 edulevel goodtotalamount2 assets assets_noland ra1 rab1 rb1 ra2 rab2 rb2 ra3 rab3 rb3 ra4 rab4 rb4 ra5 rab5 rb5 ra6 rab6 rb6 ra7 rab7 rb7 ra8 rab8 rb8 ra9 rab9 rb9 ra10 rab10 rb10 ra11 rab11 rb11 ra12 rab12 rb12 set_a set_ab set_b raven_tt refuse num_tt lit_tt ars ars2 ars3 cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot cr_staycalm cr_tryhard cr_stickwithgoals cr_goaftergoal cr_finishwhatbegin cr_finishtasks cr_keepworking cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit OP CO EX AG ES Grit totalincome_indiv totalincome_HH loans_indiv loanamount_indiv caste egoid dummyego  enjoypeople curious organized managestress interestedbyart tryhard workwithother makeplans sharefeelings nervous stickwithgoals repetitivetasks shywithpeople workhard changemood understandotherfeeling inventive enthusiastic feeldepressed appointmentontime goaftergoal easilyupset talktomanypeople liketothink finishwhatbegin putoffduties rudetoother finishtasks toleratefaults worryalot easilydistracted keepworking completeduties talkative newideas staycalm forgiveother activeimagination expressingthoughts helpfulwithothers goldquantityamount amountownlanddry amountownlandwet amountownland

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

*** The rest?
drop everattendedschoolfromearlier everattendschoolfinal

*** Drop
drop if HHID_panel==""

*** Check
preserve
sort canread
drop if INDID_left!=.
drop if livinghome==4
drop if livinghome==3
sort canread
restore

*** householdid to parent_key for parent hh


save"$directory\CLEAN\NEEMSIS2-HH_v20.dta", replace
****************************************
* END












****************************************
* Loans
****************************************
use"$directory\CLEAN\NEEMSIS2-loans_v11", clear

drop _merge key3 key2 loanreasongivenlabel

order setofmarriagefinance setofmarriagegroup setofloansbyborrower setofdetailsloanbyborrower setofmainloans, last

foreach v in loan_database version_HH edulevel {
label variable `v' `"Arnaud `: variable label `v''"'
}

order HHID_panel INDID_panel name sex age jatis edulevel egoid loan_database loanamount

drop if HHID_panel==""

global drop2 caste informal semiformal formal economic current humancap social house incomegen noincomegen economic_amount current_amount humancap_amount social_amount house_amount incomegen_amount noincomegen_amount informal_amount formal_amount semiformal_amount lender2 lender3 detailsloanbyborrower_count totalrepaid2 interestpaid2 principalpaid yratepaid monthlyinterestrate setofmarriagefinance setofmarriagegroup setofloansbyborrower setofdetailsloanbyborrower setofmainloans

foreach x in $drop2 {
capture confirm v `x'
if _rc==0 {
drop `x'
}
}


save"$directory\CLEAN\NEEMSIS2-loans_v14", replace
****************************************
* END











****************************************
* PANEL var
****************************************
use"$directory\CLEAN\NEEMSIS2-HH_v20", clear

merge m:1 HHID_panel using "$git\_Miscellaneous\Individual_panel\ODRIIS-HH.dta", keepusing(hhpanel_10_16_20)
keep if _merge==3
drop _merge

merge 1:1 HHID_panel INDID_panel using "$git\_Miscellaneous\Individual_panel\ODRIIS-Indiv.dta", keepusing(indivpanel_10_16_20)
keep if _merge==3
drop _merge

save"$directory\CLEAN\NEEMSIS2-HH_v21.dta", replace
****************************************
* END
