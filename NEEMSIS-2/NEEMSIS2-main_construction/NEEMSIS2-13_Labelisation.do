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
global directory = "C:\Users\Arnaud\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directorybis = "C:\Users\Arnaud\Docuements\_Thesis\_DATA\NEEMSIS2\DATA"
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

drop agefromearlier1 agefromearlier2

drop marriagegift_count 

drop setofmarriagefinance setofmarriagegift

drop memberlistpreload2016_count lefthome_count individualid_count familymembers_count education_count employment_count migrationgroup_count remreceivedgroup_count remsentgroup_count loansbyborrower_count mainloans_count lendingmoney_count recommendationgiven_count chitfund_count savings_count gold_count insurance_count marriagegroup_count schemenregaind_count cashassistancemarriagegroup_coun goldmarriagegroup_count schemepension1group_count schemepension2group_count schemepension3group_count schemepension4group_count schemepension5group_count schemepension6group_count indoccupmonths_count businessloandetails_count businesspaymentinkindgroup_count snrecruitworkergroup_count wagejobpaymentinkindgroup_count formalsocialcapital_count snfindcurrentjobgroup_count snfindjobgroup_count snrecommendforjobgroup_count snrecojobsuccessgroup_count sntalkthemostgroup_count snhelpemergencygroup_count sncloserelouthhgroup_count covsnhelpreceivedgroup_count covsntypehelpreceivedgroup_count covsnhelpgivengroup_count covsntypehelpgivengroup_count contactgroup_count count_eligible_1825 count_eligible_2635 count_eligible_36 show_draws_count show_draws_2_count show_draws_3_count migrationjobidgroup_count detailsloanbyborrower_count detailschitfunds_count detailssavingaccounts_count setofdetailssavingaccounts detailsinsurance_count marriagefinance_count products_count livestock_count equipmentowned_count detailsgoods_count setofmemberlistpreload2016 setofmainloans setofdetailschitfunds setofdetailsinsurance


drop nameego2fromearlier nameego1fromearlierhh nameego1fromearlier indexego2fromearlier indexego2firststep indexego2 indexego1fromearlier indexego1firststep indexego1finalstep indexego1final indexego1 ego3positionname ego3position ego2position ego2index_36 ego2index_2635 ego2index_1825 ego2herefromearlier ego1herefromearlier

drop familymembersindex educationindex employmentindex HHID dummydemonetisation villageid_new villageid_new_comments tracked namefrompreload

foreach x in migrantlist remrecipientlist remsenderlist borrowerlist hhlenderlist recommendgivenlist marriedlist nregarecipientlist schemeslist chitfundbelongerid savingsownerid goldownerid insuranceownerid schemerecipientlist3 schemerecipientlist4 schemerecipientlist5 schemerecipientlist6 schemerecipientlist7 schemerecipientlist8 schemerecipientlist9 schemerecipientlist10 {
rename `x'_ dummy_`x'
}

drop kowinc_HH_agri kowinc_HH_selfemp kowinc_HH_sjagri kowinc_HH_sjnonagri kowinc_HH_uwhhnonagri kowinc_HH_uwnonagri kowinc_HH_uwhhagri kowinc_HH_uwagri sum_ext_HH kowinc_indiv_agri kowinc_indiv_selfemp kowinc_indiv_sjagri kowinc_indiv_sjnonagri kowinc_indiv_uwhhnonagri kowinc_indiv_uwnonagri kowinc_indiv_uwhhagri kowinc_indiv_uwagri

global arnaud edulevel version_HH version_agri s_goldquantity goldquantityamount amountownlanddry amountownlandwet amountownland goodtotalamount2 assets assets_noland ra1 rab1 rb1 ra2 rab2 rb2 ra3 rab3 rb3 ra4 rab4 rb4 ra5 rab5 rb5 ra6 rab6 rb6 ra7 rab7 rb7 ra8 rab8 rb8 ra9 rab9 rb9 ra10 rab10 rb10 ra11 rab11 rb11 ra12 rab12 rb12 set_a set_ab set_b raven_tt refuse num_tt lit_tt curious_backup interestedbyart_backup repetitivetasks_backup inventive_backup liketothink_backup newideas_backup activeimagination_backup organized_backup makeplans_backup workhard_backup appointmentontime_backup putoffduties_backup easilydistracted_backup completeduties_backup enjoypeople_backup sharefeelings_backup shywithpeople_backup enthusiastic_backup talktomanypeople_backup talkative_backup expressingthoughts_backup workwithother_backup understandotherfeeling_backup trustingofother_backup rudetoother_backup toleratefaults_backup forgiveother_backup helpfulwithothers_backup managestress_backup nervous_backup changemood_backup feeldepressed_backup easilyupset_backup worryalot_backup staycalm_backup tryhard_backup stickwithgoals_backup goaftergoal_backup finishwhatbegin_backup finishtasks_backup keepworking_backup ars ars2 ars3 cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot cr_staycalm cr_tryhard cr_stickwithgoals cr_goaftergoal cr_finishwhatbegin cr_finishtasks cr_keepworking cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit OP CO EX AG ES Grit mainocc_kindofwork_indiv mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_hoursayear_indiv mainocc_annualincome_indiv mainocc_jobdistance_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv occinc_indiv_agri occinc_indiv_agricasual occinc_indiv_nonagricasual occinc_indiv_nonagriregnonqual occinc_indiv_nonagriregqual occinc_indiv_selfemp occinc_indiv_nrega worker mainocc_kindofwork_HH mainocc_occupation_HH annualincome_HH nboccupation_HH occinc_HH_agri occinc_HH_agricasual occinc_HH_nonagricasual occinc_HH_nonagriregnonqual occinc_HH_nonagriregqual occinc_HH_selfemp occinc_HH_nrega working_pop remreceivedtotalamount_indiv remreceivedtotalamount_HH incomeassets_HH incomeassets_indiv otherhouserent_HH otherhouserent_indiv pension_indiv pension_HH totalincome_indiv totalincome_HH loans_indiv loanamount_indiv imp1_ds_tot_indiv imp1_is_tot_indiv loans_HH loanamount_HH imp1_ds_tot_HH imp1_is_tot_HH


foreach v of varlist $arnaud {
label variable `v' "Construction -- Arnaud"
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
drop namefromearlier4 namefromearlier5 workedpastyearfromearlier mainoccupationfromearlier attendedschoolfromearlier namefromearlier agefromearlier namefromearlier2 livinghomefromearlier2 namefromearlier3

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
use"$directory\CLEAN\NEEMSIS2-loans_v13", clear

drop annualincome_indiv annualincome_HH setofloansbyborrower detailsloanbyborrower_count setofdetailsloanbyborrower loanreasongivenlabel key2 key3 setofmainloans merge_mainloans key householdid2020 submissiondate_o

order HHID_panel INDID_panel INDID2020 INDID_total INDID_former INDID_new borrowerid year sex age name egoid edulevel submissiondate

drop if HHID_panel==""

foreach v in loanlender_rec edulevel loan_database loanduration lender_cat reason_cat lender2 lender3 lender4 lender4_rec loanduration_month yratepaid monthlyinterestrate debt_service interest_service imp_principal imp1_interest imp1_totalrepaid_year imp1_debt_service imp1_interest_service dummymainloans loans_indiv loans_HH loanamount_indiv loanamount_HH loans_HH imp1_ds_tot_indiv imp1_is_tot_indiv imp1_ds_tot_HH imp1_is_tot_HH duplicates duplicatestodrop principalpaid months_diff years_diff weeks_diff th_interest principalpaid3 pb2 pb3 pb4 loanamount3 loanbalance3 principalpaid4 interestpaid2 interestpaid3 totalrepaid3 loanbalance2 principalpaid2 totalrepaid2 loanamount2{
label variable `v' "Construction -- "
}

order HHID_panel INDID_panel version_HH name sex age jatis edulevel egoid loan_database loanamount

global arnaud loanamount3 loanbalance3 principalpaid4 interestpaid2 interestpaid3 totalrepaid3 loanbalance2 principalpaid2 totalrepaid2 loanamount2 loanlender_rec loanduration lender_cat reason_cat lender2 lender3 lender4 lender4_rec loanduration_month yratepaid monthlyinterestrate debt_service interest_service imp_principal imp1_interest imp1_totalrepaid_year imp1_debt_service imp1_interest_service dummymainloans loans_indiv loans_HH loanamount_indiv loanamount_HH imp1_ds_tot_indiv imp1_is_tot_indiv imp1_ds_tot_HH imp1_is_tot_HH

order setofmarriagefinance setofmarriagegroup $arnaud, after(lenderoccup)

drop age INDID2020 INDID_total INDID_former INDID_new name

order caste, before(jatis)
drop months_diff years_diff weeks_diff pb pb2 pb3 pb4 loans
/*
pb--> loanamount>pledge
*/


order loanamount2 loanamount3 interestpaid2 interestpaid3 loanbalance2 loanbalance3 totalrepaid2 totalrepaid3 principalpaid principalpaid2 principalpaid3 principalpaid4 duplicates duplicatestodrop th_interest, after(setofmarriagegroup)


save"$directory\CLEAN\NEEMSIS2-loans_v14", replace
****************************************
* END











****************************************
* PANEL var
****************************************
use"$directory\CLEAN\NEEMSIS2-HH_v20", clear

/*
merge m:1 HHID_panel using "$git\_Miscellaneous\Individual_panel\ODRIIS-HH.dta", keepusing(hhpanel_10_16_20)
keep if _merge==3
drop _merge

merge 1:1 HHID_panel INDID_panel using "$git\_Miscellaneous\Individual_panel\ODRIIS-Indiv.dta", keepusing(indivpanel_10_16_20)
keep if _merge==3
drop _merge
*/
save"$directory\CLEAN\NEEMSIS2-HH_v21.dta", replace
****************************************
* END
