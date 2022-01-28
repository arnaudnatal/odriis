cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
October 29, 2021
-----
TITLE: Duplicates
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
* Cleaning for empty parent_key and duplicates one
****************************************
*
clear all
filelist, dir("$directory\CLEAN") pattern(*.dta)
gen agri=0
replace agri=1 if strpos(filename,"Agriculture")
sort agri dirname filename
egen file=concat(dirname filename),p(\)
split dirname, p(/)
capture confirm v dirname2 
if _rc==0 {
drop if dirname2=="LAST"
}

********** HH datatsets
preserve
keep if agri==0
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = file
	local d = dirname
	local v = filename
	use "`f'", clear
	capture confirm v parent_key
	if !_rc {
	drop if parent_key==""
	***** Duplicates
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"  // householdid==36 & name1=="Natesan"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"  // householdid==67 & name1=="Shankar"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"  // householdid==124 & name1=="Subramani"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"  // householdid==246 & name1=="Sornambal"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"  // householdid==343 & name1=="Ramamoorthi"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"  // householdid==348 & name1=="Govindan"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"  // householdid==361 & name1=="Mallika"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"  // householdid==391 & name1=="Balaji"
	*
	drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"  // householdid==532 & name1=="Shakthivel" & name2=="Revathy"
	drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"  // householdid==534 & name1=="Karunanidhi"
	drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"  // householdid==547 & name1=="Surya" (duplicates with "uuid:ae72a34f-f968-45f4-acfa-91f571f54ea8")
	}
	capture confirm v forauto
	if !_rc {
	drop forauto
	}
	save "`d'\LAST\\`v'", replace	
	tempfile save`i'
}
restore


********** AGRI datasets
preserve
keep if agri==1
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = file
	local d = dirname
	local v = filename
	use "`f'", clear
	capture confirm v parent_key
	if !_rc {
	drop if parent_key==""
	***** Duplicates
	drop if parent_key=="uuid:244d058e-b68a-4271-bf5f-5332dca88f8f"
	drop if parent_key=="uuid:7e235580-30be-4dea-8982-68ed963b45c8"
	drop if parent_key=="uuid:ece23449-7f67-4de2-b7da-3ea48d4d33dd"
	drop if parent_key=="uuid:953d8941-5338-4a82-a5d7-2f6e25947e5d"
	drop if parent_key=="uuid:f52b0fb0-064b-4133-a78d-83edcd80b3e1"
	drop if parent_key=="uuid:08b045f7-ca13-429c-b25b-604ed8786a32"
	drop if parent_key=="uuid:332b0700-6bdb-4e66-92ee-7f1e892dae6a"
	drop if parent_key=="uuid:6854d50b-0b75-4b24-a3b8-ee031aa78668"
	*
	drop if parent_key=="uuid:f98d6d16-e1cb-4504-8475-9414a295c014"
	drop if parent_key=="uuid:0c5b2989-3bf7-49db-b6e4-ab455dfee7fe"
	}
	capture confirm v forauto
	if !_rc {
	drop forauto
	}
	save "`d'\LAST\\`v'", replace	
	tempfile save`i'
}
restore





********** Drop les mauvais pour ne garder que les trucs à partager
clear all
filelist, dir("$directory\CLEAN\LAST") pattern(*.dta)
egen file=concat(dirname filename),p(\)

gen todrop=0
replace todrop=1 if filename=="NEEMSIS1_temp.dta"
replace todrop=1 if filename=="RUME_temp.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v13.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v12.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v11.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v10.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v9.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v8.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v7.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v6.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v5.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v4.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v3.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v2.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v13_indiv.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v13_HH.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v9.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v8.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v7.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v6.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v5-_tocomp.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v5_bis.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v5_bis2.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v5.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v4.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v24.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v23.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v22.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v21.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v20.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v19.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v18.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v17.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v16.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v15.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v14.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v13.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v12.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v11.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v10.dta"
replace todrop=1 if filename=="NEEMSIS2_NEW_JUNE.dta"
replace todrop=1 if filename=="NEEMSIS2_NEW_APRIL.dta"
replace todrop=1 if filename=="NEEMSIS2_LAST.dta"
replace todrop=1 if filename=="NEEMSIS2_FEBRUARY_Agriculture.dta"
replace todrop=1 if filename=="NEEMSIS2_FEBRUARY.dta"
replace todrop=1 if filename=="NEEMSIS2_FEB_NEW_Agriculture.dta"
replace todrop=1 if filename=="NEEMSIS2_FEB.dta"
replace todrop=1 if filename=="NEEMSIS2_DECEMBER_Agriculture.dta"
replace todrop=1 if filename=="NEEMSIS2_DECEMBER.dta"
replace todrop=1 if filename=="NEEMSIS2_DEC_Agriculture.dta"
replace todrop=1 if filename=="NEEMSIS2_DEC.dta"
replace todrop=1 if filename=="NEEMSIS2_APRIL.dta"
replace todrop=1 if filename=="NEEMSIS2_Agriculture.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-selfemploy-labourers-businesslabourers.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-salaried-infoemployer.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-remsentidgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-remreceivedsourceidgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-remreceived_indiv.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations_v5.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations_v4.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations_v4_indiv.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations_v4_HH.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations_v3.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-migrationjobidgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-memberlistpreload2016.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-marriagegift.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-individualid.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension6-schemepension6group.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension5-schemepension5group.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension4-schemepension4group.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension3-schemepension3group.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension2-schemepension2group.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension1-schemepension1group.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemenrega-schemenregaind.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-goldmarriage-goldmarriagegroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-cashassistancemarriage-cashassistancemarriagegroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-savingsgroup-savings.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-loans-mainloans.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-loans-loansbyborrower.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-lendingmoneygroup-lendingmoney.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-insurancegroup-insurance.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-guaranteeandrecommendation-recommendationgiven.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-goldgroup-gold.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-chitfundgroup-chitfund.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-familymembers.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-employment.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-education.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-generalinformation-lefthome.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailssavingaccounts_wide.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailssavingaccounts.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailsloanbyborrower.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailsinsurance_wide.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailsinsurance.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailschitfunds_wide.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailschitfunds.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND.dta"
replace todrop=1 if filename=="NEEMSIS_Agriculture_APPEND_v3.dta"
replace todrop=1 if filename=="NEEMSIS_Agriculture_APPEND_v2.dta"
replace todrop=1 if filename=="NEEMSIS_Agriculture_APPEND_merge23.dta"
replace todrop=1 if filename=="NEEMSIS_Agriculture_APPEND_merge1.dta"
replace todrop=1 if filename=="NEEMSIS_Agriculture_APPEND.dta"
replace todrop=1 if filename=="indiv2020_v2.dta"
replace todrop=1 if filename=="indiv2020_temp2.dta"
replace todrop=1 if filename=="indiv2020_temp.dta"
replace todrop=1 if filename=="indiv2020.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-networkresources-contactgroup_v2_wide.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-migration-migrationgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-migration-migrationidgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-remittances-remreceived-remreceivedgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-remittances-remreceived-remreceivedidgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-remittances-remsent-remsentgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-remittances-remsent-remsentidgroup.dta"
replace todrop=1 if filename=="base_alter_A.dta"
replace todrop=1 if filename=="base_alter_A_append.dta"
replace todrop=1 if filename=="base_alter_A_singlesnlist.dta"
replace todrop=1 if filename=="base_alter_B_complete.dta"
replace todrop=1 if filename=="base_alter_C.dta"
replace todrop=1 if filename=="base_alter_C_append.dta"
replace todrop=1 if filename=="base_alter_C_complete.dta"
replace todrop=1 if filename=="base_alter_D.dta"
replace todrop=1 if filename=="base_alter_D_append.dta"
replace todrop=1 if filename=="base_alter_D_complete.dta"
replace todrop=1 if filename=="base_alter_E.dta"
replace todrop=1 if filename=="base_alter_E_append.dta"
replace todrop=1 if filename=="base_alter_E_complete.dta"
replace todrop=1 if filename=="base_alter_F.dta"
replace todrop=1 if filename=="base_alter_F_append.dta"
replace todrop=1 if filename=="base_alter_F_complete.dta"
replace todrop=1 if filename=="base_alter_F_complete_ego1.dta"
replace todrop=1 if filename=="base_alter_F_complete_ego2.dta"
replace todrop=1 if filename=="base_alter_F_complete_ego3.dta"
replace todrop=1 if filename=="base_alter_G.dta"
replace todrop=1 if filename=="base_alter_G_append.dta"
replace todrop=1 if filename=="base_alter_G_complete.dta"
replace todrop=1 if filename=="base_alter_G_complete_ego1.dta"
replace todrop=1 if filename=="base_alter_G_complete_ego2.dta"
replace todrop=1 if filename=="base_alter_G_complete_ego3.dta"
replace todrop=1 if filename=="base_alter_H.dta"
replace todrop=1 if filename=="base_alter_H_append.dta"
replace todrop=1 if filename=="base_alter_H_complete.dta"
replace todrop=1 if filename=="base_alter_H_complete_ego1.dta"
replace todrop=1 if filename=="base_alter_H_complete_ego2.dta"
replace todrop=1 if filename=="base_alter_H_complete_ego3.dta"
replace todrop=1 if filename=="base_alter_I.dta"
replace todrop=1 if filename=="base_alter_I_append.dta"
replace todrop=1 if filename=="base_alter_I_complete.dta"
replace todrop=1 if filename=="base_alter_I_complete_ego1.dta"
replace todrop=1 if filename=="base_alter_I_complete_ego2.dta"
replace todrop=1 if filename=="base_alter_I_complete_ego3.dta"
replace todrop=1 if filename=="base_alter_J.dta"
replace todrop=1 if filename=="base_alter_J_append.dta"
replace todrop=1 if filename=="base_alter_J_complete.dta"
replace todrop=1 if filename=="base_alter_J_complete_ego1.dta"
replace todrop=1 if filename=="base_alter_J_complete_ego2.dta"
replace todrop=1 if filename=="base_alter_J_complete_ego3.dta"
replace todrop=1 if filename=="base_alter_K.dta"
replace todrop=1 if filename=="base_alter_K_append.dta"
replace todrop=1 if filename=="base_alter_K_complete.dta"
replace todrop=1 if filename=="base_alter_K_complete_ego1.dta"
replace todrop=1 if filename=="base_alter_K_complete_ego2.dta"
replace todrop=1 if filename=="base_alter_K_complete_ego3.dta"
replace todrop=1 if filename=="base_alter_L.dta"
replace todrop=1 if filename=="base_alter_L_append.dta"
replace todrop=1 if filename=="base_alter_L_complete.dta"
replace todrop=1 if filename=="base_alter_L_complete_ego1.dta"
replace todrop=1 if filename=="base_alter_L_complete_ego2.dta"
replace todrop=1 if filename=="base_alter_L_complete_ego3.dta"
replace todrop=1 if filename=="base_alter_M.dta"
replace todrop=1 if filename=="base_alter_M_append.dta"
replace todrop=1 if filename=="base_alter_M_complete.dta"
replace todrop=1 if filename=="base_alter_M_complete_ego1.dta"
replace todrop=1 if filename=="base_alter_M_complete_ego2.dta"
replace todrop=1 if filename=="base_alter_M_complete_ego3.dta"
replace todrop=1 if filename=="base_alter_N.dta"
replace todrop=1 if filename=="base_alter_N_append.dta"
replace todrop=1 if filename=="base_alter_N_complete.dta"
replace todrop=1 if filename=="base_alter_N_complete_ego1.dta"
replace todrop=1 if filename=="base_alter_N_complete_ego2.dta"
replace todrop=1 if filename=="base_alter_N_complete_ego3.dta"

replace todrop=1 if filename=="base_indexage_egoid!=0.dta"
replace todrop=1 if filename=="base_alter_VF2_egoid_0.dta"
replace todrop=1 if filename=="base_alter_VF1_singlelist.dta"
replace todrop=1 if filename=="base_alter_VF1.dta"
replace todrop=1 if filename=="base_alter_VF2.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemploymentinformalsocialcapitalselfemp-snrecruitworkergroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemploymentinformalsocialcapitalselfemp-snrecruitworkerid_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-snrecruitworkerid.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-snrecruitworkergroup.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemploymentsourceinvestment-businessloandetails_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-informalsocialcapitalselfemp-snrecruitworkergroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-informalsocialcapitalselfemp-snrecruitworkerid_v2.dta"



replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-snrecommendassogroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-snrecommendassoid_v2.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-covsnhelpgivengroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-covsnhelpgivenid_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-covsnhelpreceivedgroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-covsnhelpreceivedid_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-covsntypehelpgivengroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-covsntypehelpreceivedgroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sncloserelouthhgroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sncloserelouthhid_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindcurrentjobgroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindcurrentjobid_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindjobgroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindjobid_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snhelpemergencygroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snhelpemergencyid_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecojobsuccessgroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecojobsuccessid_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecommendforjobgroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecommendforjobid_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sntalkthemostgroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sntalkthemostid_v2.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-networkresources-contactgroup_v2.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-formalsocialcapital_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-formalsocialcapital_v2_wide.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-covoccupationfieldlist_v2.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-covoccupationfield_v2.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-mainoccupschedule-indoccupmonths_wide_v2.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-mainoccupschedule-indoccupmonths_v2.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indwagejob-wagejobpaymentinkindgroup_wide_v2.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indwagejob-wagejobpaymentinkindgroup_v2.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemployment-businesspaymentinkindgroup_wide_v2.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemployment-businesspaymentinkindgroup_v2.dta"

replace todrop=1 if filename=="NEEMSIS_APPEND-salaried-infoemployer_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-salaried-infoemployer_wide_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-selfemploy-labourers-businesslabourers_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-selfemploy-labourers-businesslabourers_wide_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-migrationjobidgroup_v2.dta"


********** To drop
preserve
keep if todrop==1
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = file
	use "`f'", clear
	erase "`f'"	
	tempfile save`i'
}
restore


********** To keep and rename
keep if todrop==0
list filename, clean noobs
/*
filename                                                                        
NEEMSIS2-HH_v24.dta                                                             
NEEMSIS2-loans.dta                                                              
NEEMSIS2-loans_v14.dta                                                          
NEEMSIS_APPEND-ego123questionnaire-individualemployment-covoccupationfield.dta  
NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v3.dta                    
NEEMSIS_APPEND-marriagefinance.dta                                              
NEEMSIS_APPEND-marriagegift_v2.dta                                              
NEEMSIS_APPEND-migrationjobidgroup_v2.dta                                       
NEEMSIS_APPEND-occupations_v6.dta                                               
NEEMSIS_APPEND-remreceivedsourceidgroup_v2.dta                                  
NEEMSIS_APPEND-remsentidgroup_v2.dta                                            
base_alter_VF3.dta 
*/

use"$directory\CLEAN\LAST\NEEMSIS2-HH_v25.dta", clear
save"$directory\CLEAN\LAST\NEEMSIS2-HH", replace
erase"$directory\CLEAN\LAST\NEEMSIS2-HH_v25.dta"

*use"$directory\CLEAN\LAST\NEEMSIS2-loans.dta", clear
*save"$directory\CLEAN\LAST\NEEMSIS2-loans.dta", replace
*erase"$directory\CLEAN\LAST\NEEMSIS2-loans.dta"

use"$directory\CLEAN\LAST\NEEMSIS2-loans_v14.dta", clear
save"$directory\CLEAN\LAST\NEEMSIS2-all_loans.dta", replace
erase"$directory\CLEAN\LAST\NEEMSIS2-loans_v14.dta"


use"$directory\CLEAN\LAST\NEEMSIS_APPEND-ego123questionnaire-individualemployment-covoccupationfield.dta", clear
save"$directory\CLEAN\LAST\NEEMSIS2-covoccupation.dta", replace
erase"$directory\CLEAN\LAST\NEEMSIS_APPEND-ego123questionnaire-individualemployment-covoccupationfield.dta"


use"$directory\CLEAN\LAST\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v3.dta", clear
save"$directory\CLEAN\LAST\NEEMSIS2-marriage.dta", replace
erase"$directory\CLEAN\LAST\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v3.dta"

use"$directory\CLEAN\LAST\NEEMSIS_APPEND-marriagefinance.dta", clear
save"$directory\CLEAN\LAST\NEEMSIS2-marriagefinance.dta", replace
erase"$directory\CLEAN\LAST\NEEMSIS_APPEND-marriagefinance.dta"

use"$directory\CLEAN\LAST\NEEMSIS_APPEND-marriagegift_v2.dta", clear
save"$directory\CLEAN\LAST\NEEMSIS2-marriagegift.dta", replace
erase"$directory\CLEAN\LAST\NEEMSIS_APPEND-marriagegift_v2.dta"

use"$directory\CLEAN\LAST\NEEMSIS_APPEND-migrationjobidgroup_v3.dta", clear
save"$directory\CLEAN\LAST\NEEMSIS2-migration.dta", replace
erase"$directory\CLEAN\LAST\NEEMSIS_APPEND-migrationjobidgroup_v3.dta"

use"$directory\CLEAN\LAST\NEEMSIS_APPEND-occupations_v6.dta", clear
save"$directory\CLEAN\LAST\NEEMSIS2-occupations_allwide.dta", replace
erase"$directory\CLEAN\LAST\NEEMSIS_APPEND-occupations_v6.dta"

use"$directory\CLEAN\LAST\NEEMSIS_APPEND-remreceivedsourceidgroup_v2.dta", clear
save"$directory\CLEAN\LAST\NEEMSIS2-remreceived.dta", replace
erase"$directory\CLEAN\LAST\NEEMSIS_APPEND-remreceivedsourceidgroup_v2.dta"

use"$directory\CLEAN\LAST\NEEMSIS_APPEND-remsentidgroup_v2.dta", clear
save"$directory\CLEAN\LAST\NEEMSIS2-remsent.dta", replace
erase"$directory\CLEAN\LAST\NEEMSIS_APPEND-remsentidgroup_v2.dta"

use"$directory\CLEAN\LAST\base_alter_VF3.dta", clear
save"$directory\CLEAN\LAST\NEEMSIS2-alter.dta", replace
erase"$directory\CLEAN\LAST\base_alter_VF3.dta"


****************************************
* END










****************************************
* Split sample between HH to keep and 
* HH to put in another folder
****************************************
*
clear all
filelist, dir("$directory\CLEAN\LAST") pattern(*.dta)

********** SURPLUS HH
preserve
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local d = dirname
	local f = filename
	use "`d'\\`f'", clear
	keep if ///
	parent_key=="uuid:f2ce512f-1640-4719-90e0-921980fc6514" || ///
	parent_key=="uuid:1d1d2df6-0b97-4490-b2e1-1a218d665abd" || ///
	parent_key=="uuid:4fee9bff-9ecb-4639-ae0f-b2e2404aff5e" || ///
	parent_key=="uuid:d2c64ab3-d65d-46d7-b65b-4ad2431c436a" || ///
	parent_key=="uuid:835fd736-70e9-4770-8df0-d8c02ebf0ffe" || ///
	parent_key=="uuid:7609358f-d758-47a8-ae0b-4a45e6062f4b" || ///
	parent_key=="uuid:78824e3c-aa97-4f9b-82c9-4dc91da45a2d" || ///
	parent_key=="uuid:a9e70587-aa67-4459-a216-4cf2c9d41779" || ///
	parent_key=="uuid:e772b351-ca9e-493d-b927-3397489040cf" || ///
	parent_key=="uuid:e85fb3fd-0c10-48b2-a552-4871b1dbe380" || ///
	parent_key=="uuid:aba029f6-b4c8-4507-a922-cfb3731fcecc" || ///
	parent_key=="uuid:e9ea6091-71fb-4cc4-bd67-c609b3bd7df2" || ///
	parent_key=="uuid:5fa75706-2fb9-48df-a3ca-8f1dc20d441f" || ///
	parent_key=="uuid:66442499-ae81-4c2b-9ff7-bd51a34f8b52" || ///
	parent_key=="uuid:78cac18d-65a1-439d-8459-81556f91c469" || ///
	parent_key=="uuid:b9ce5c9b-fdf6-40d2-9784-be3904293ee5" || ///
	parent_key=="uuid:fc31833e-cd7b-403f-899f-da99863ddc13" || ///
	parent_key=="uuid:7761b0f9-98a1-42d7-8e92-f77d7fccc9e9"

	save "$directory\CLEAN\_SURPLUS_HH\\`f'", replace	
	tempfile save`i'
}
restore




********** ANALAYSIS HH
preserve
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local d = dirname
	local f = filename
	use "`d'\\`f'", clear
	
	drop if parent_key=="uuid:f2ce512f-1640-4719-90e0-921980fc6514"
	drop if parent_key=="uuid:1d1d2df6-0b97-4490-b2e1-1a218d665abd"
	drop if parent_key=="uuid:4fee9bff-9ecb-4639-ae0f-b2e2404aff5e"
	drop if parent_key=="uuid:d2c64ab3-d65d-46d7-b65b-4ad2431c436a"
	drop if parent_key=="uuid:835fd736-70e9-4770-8df0-d8c02ebf0ffe"
	drop if parent_key=="uuid:7609358f-d758-47a8-ae0b-4a45e6062f4b"
	drop if parent_key=="uuid:78824e3c-aa97-4f9b-82c9-4dc91da45a2d"
	drop if parent_key=="uuid:a9e70587-aa67-4459-a216-4cf2c9d41779"
	drop if parent_key=="uuid:e772b351-ca9e-493d-b927-3397489040cf"
	drop if parent_key=="uuid:e85fb3fd-0c10-48b2-a552-4871b1dbe380"
	drop if parent_key=="uuid:aba029f6-b4c8-4507-a922-cfb3731fcecc"
	drop if parent_key=="uuid:e9ea6091-71fb-4cc4-bd67-c609b3bd7df2"
	drop if parent_key=="uuid:5fa75706-2fb9-48df-a3ca-8f1dc20d441f"
	drop if parent_key=="uuid:66442499-ae81-4c2b-9ff7-bd51a34f8b52"
	drop if parent_key=="uuid:78cac18d-65a1-439d-8459-81556f91c469"
	drop if parent_key=="uuid:b9ce5c9b-fdf6-40d2-9784-be3904293ee5"
	drop if parent_key=="uuid:fc31833e-cd7b-403f-899f-da99863ddc13"
	drop if parent_key=="uuid:7761b0f9-98a1-42d7-8e92-f77d7fccc9e9"

	save "$directory\CLEAN\_ANALYSIS_HH\\`f'", replace	
	tempfile save`i'
}
restore

****************************************
* END




/*


****************************************
* Check Gaston issues with missings values
****************************************
use "$directory\CLEAN\_ANALYSIS_HH\NEEMSIS2-HH_v22.dta", clear

fre reasonlefthome

keep if reasonlefthome==2 | reasonlefthome==77
duplicates drop HHID_panel, force


********** Left home
fre reasonlefthome
fre lefthomedurationmoreoneyear
fre lefthomedestinationfirst



********** Left home 2
fre lefthomereason



/*

* Drop indiv who not live in the HH
drop if INDID_left!=.
drop if livinghome==3 | livinghome==4

* How much individuals with which version of questionnaire?
fre version_HH
/*
-----------------------------------------------------------------
                    |      Freq.    Percent      Valid       Cum.
--------------------+--------------------------------------------
Valid   1 LAST      |        170       5.85       5.85       5.85
        2 DEC       |          1       0.03       0.03       5.88
        3 DECEMBER  |       1149      39.54      39.54      45.42
        4 FEB       |         28       0.96       0.96      46.39
        5 FEBRUARY  |        482      16.59      16.59      62.97
        6 APRIL     |        308      10.60      10.60      73.57
        7 NEW_APRIL |        136       4.68       4.68      78.25
        8 NEW_JUNE  |        632      21.75      21.75     100.00
        Total       |       2906     100.00     100.00           
-----------------------------------------------------------------
*/

* How much missings on NEW_JUNE questionnaire?
preserve
keep if version_HH==8

unab all : _all
global vars `all'
gen nmissing=.
gen varname=""

set obs 1401
gen n=_n

local i=1
qui foreach v in $vars {
count if missing(`v')
replace nmissing = r(N) in `i'
replace varname="`v'" in `i'
local ++i
}

gen perc_nmissing=(nmissing/_N)*100
format perc_nmissing %4.2f
sort perc_nmissing n
list varname nmissing perc_nmissing if inrange(nmissing, 1, .) , noobs clean
restore
/*
Pb with:
villageid

reasonnoland
sizeownland
--> need to check if they have land or not
--> same with livestock and equipment

for the rest it is ok!
*/


****************************************
* END
