cls
/*
-------------------------
Arnaud Natal
November 30, 2021
-----
TITLE: CLEANING Occupations
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
* MERGE Occupation
****************************************
use"$directory\CLEAN\NEEMSIS_APPEND-occupations_v5.dta", clear


preserve
use"$directory\CLEAN\NEEMSIS_APPEND-salaried-infoemployer_v2", clear
drop relationemployer_1 relationemployer_2 relationemployer_66 relationemployer_8 relationemployer_5 relationemployer_11 relationemployer_3 relationemployer_10
drop relationemployer_7 relationemployer_99 relationemployer_9 relationemployer_4 relationemployer_6
destring employerid, replace

label define yesno 0"No" 1"Yes"
ta relationemployer
foreach i in 1 2 3 4 5 6 7 8 9 10 66 99 {
gen relationemployer_`i'=0
}
foreach i in 1 2 3 4 5 6 7 8 9 10 66 99 {
replace relationemployer_`i'=1 if strpos(relationemployer,"`i'")
label values relationemployer_`i' yesno
}
rename relationemployer_1 relationemployer_labour
rename relationemployer_2 relationemployer_relative
rename relationemployer_3 relationemployer_political
rename relationemployer_4 relationemployer_religious
rename relationemployer_5 relationemployer_neighbor
rename relationemployer_6 relationemployer_shg
rename relationemployer_7 relationemployer_businessman
rename relationemployer_8 relationemployer_wkp
rename relationemployer_9 relationemployer_traditional
rename relationemployer_10 relationemployer_friend
rename relationemployer_66 relationemployer_notappli
rename relationemployer_99 relationemployer_noresponse

order relationemployer_labour relationemployer_relative relationemployer_political relationemployer_religious relationemployer_neighbor relationemployer_shg relationemployer_businessman relationemployer_wkp relationemployer_traditional relationemployer_friend relationemployer_notappli relationemployer_noresponse, after(relationemployer)

reshape wide typewageemployer relationemployer relationemployer_labour relationemployer_relative relationemployer_political relationemployer_religious relationemployer_neighbor relationemployer_shg relationemployer_businessman relationemployer_wkp relationemployer_traditional relationemployer_friend relationemployer_notappli relationemployer_noresponse casteemployer othercasteemployer otheremployertype, i(setofoccupations) j(employerid)
drop parent_key
save"$directory\CLEAN\NEEMSIS_APPEND-salaried-infoemployer_wide_v2", replace
*2145
restore
*Merge
merge m:1 setofoccupations using "$directory\CLEAN\NEEMSIS_APPEND-salaried-infoemployer_wide_v2"
drop if _merge==2
drop _merge



preserve
use"$directory\CLEAN\NEEMSIS_APPEND-selfemploy-labourers-businesslabourers_v2", clear
destring businesslabourernumber, replace
reshape wide namebusinesslabourer dummybusinesslabourerhhmember addressbusinesslabourer relationshipbusinesslabourer castebusinesslabourer businesslabourertypejob businesslabourerwagetype businesslabourerbonus businesslabourerinsurance businesslabourerpension businesslabourerdate, i(setofoccupations) j(businesslabourernumber)
drop parent_key
save "$directory\CLEAN\NEEMSIS_APPEND-selfemploy-labourers-businesslabourers_wide_v2", replace
restore
*Merge
merge m:1 setofoccupations using "$directory\CLEAN\NEEMSIS_APPEND-selfemploy-labourers-businesslabourers_wide_v2"
drop _merge



* Clean arnaud
keep if INDID_left==.
order HHID_panel parent_key INDID_panel INDID_left INDID_total jatis caste sex name canread classcompleted edulevel year setofbusinesslabourers setofinfoemployer setofoccupations setofemployment
drop age egoid
drop toask setofbusinesslabourers setofinfoemployer 
drop parent_key INDID_left INDID_total jatis caste sex name canread classcompleted edulevel year
drop jobloc_samevil jobloc_aroundvil jobloc_ruralTN jobloc_smalltownAR jobloc_bigcitiesTN jobloc_ruralOUT jobloc_bigcitiesOUT ext dummyego
drop workedpastyearfromearlier selected_occupposition_ selected_occupname_ min_datestartoccup min_occupationid villageid livinghome relationshiptohead livinghomefromearlier1 livinghomefromearlier2
drop countoccupation

merge m:1 HHID_panel INDID_panel using "$directory\CLEAN\NEEMSIS2-HH_v25.dta", keepusing(name parent_key INDID_total age sex caste jatis relationshiptohead maritalstatus canread edulevel)
drop if _merge==2
drop _merge

order name sex age jatis parent_key INDID_total relationshiptohead maritalstatus canread edulevel caste, after(setofemployment)
order kowinc_1 kowinc_2 kowinc_3 kowinc_4 kowinc_5 kowinc_6 kowinc_7 kowinc_8 kowinc_indiv_agri kowinc_indiv_selfemp kowinc_indiv_sjagri kowinc_indiv_sjnonagri kowinc_indiv_uwagri kowinc_indiv_uwhhagri kowinc_indiv_uwhhnonagri kowinc_indiv_uwnonagri mainocc_annualincome_indiv mainocc_hoursayear_indiv mainocc_jobdistance_indiv mainocc_kindofwork_indiv mainocc_occupation_indiv mainocc_occupationname_indiv mainocc_profession_indiv mainocc_sector_indiv setof*, last

foreach x in kowinc_1 kowinc_2 kowinc_3 kowinc_4 kowinc_5 kowinc_6 kowinc_7 kowinc_8 kowinc_indiv_agri kowinc_indiv_selfemp kowinc_indiv_sjagri kowinc_indiv_sjnonagri kowinc_indiv_uwagri kowinc_indiv_uwhhagri kowinc_indiv_uwhhnonagri kowinc_indiv_uwnonagri mainocc_annualincome_indiv mainocc_hoursayear_indiv mainocc_jobdistance_indiv mainocc_kindofwork_indiv mainocc_occupation_indiv mainocc_occupationname_indiv mainocc_profession_indiv mainocc_sector_indiv {
label var `x' "Arnaud"
}

save"$directory\CLEAN\NEEMSIS_APPEND-occupations_v6.dta", replace
clear all
****************************************
* END







****************************************
* Migration
****************************************
use"$directory\CLEAN\NEEMSIS_APPEND-migrationjobidgroup_v2", clear


rename migrationarea_1 migrationarea_villages
rename migrationarea_2 migrationarea_ruraltn
rename migrationarea_3 migrationarea_smalltown
rename migrationarea_4 migrationarea_bigcitiestn
rename migrationarea_5 migrationarea_ruralout
rename migrationarea_6 migrationarea_citiesout
order migrationarea_*, after(migrationarea)

rename migrationfindjob_1 migrationfindjob_maistry
rename migrationfindjob_2 migrationfindjob_friends
rename migrationfindjob_3 migrationfindjob_knownpers
rename migrationfindjob_4 migrationfindjob_themselves
rename migrationfindjob_5 migrationfindjob_advertis
rename migrationfindjob_6 migrationfindjob_goregular
order migrationfindjob_*, after(migrationfindjob)

rename advancebalanceproblem_1 advancebalanceproblem_same
rename advancebalanceproblem_2 advancebalanceproblem_less
rename advancebalanceproblem_3 advancebalanceproblem_scoled
rename advancebalanceproblem_4 advancebalanceproblem_never
rename advancebalanceproblem_5 advancebalanceproblem_complain
rename advancebalanceproblem_6 advancebalanceproblem_nothing
order advancebalanceproblem_*, after(advancebalanceproblem)

rename migrationskill_1 migrationskill_experience
rename migrationskill_2 migrationskill_education
rename migrationskill_3 migrationskill_skill
rename migrationskill_4 migrationskill_network
rename migrationskill_5 migrationskill_nothing
order migrationskill_*, after(migrationskill)

rename migrationreason_1 migrationreason_nowork
rename migrationreason_2 migrationreason_advance
rename migrationreason_3 migrationreason_assurance
rename migrationreason_4 migrationreason_repay
rename migrationreason_5 migrationreason_opportunity
rename migrationreason_6 migrationreason_interesting
rename migrationreason_7 migrationreason_money
rename migrationreason_8 migrationreason_diversify
rename migrationreason_9 migrationreason_status
rename migrationreason_10 migrationreason_someone
rename migrationreason_11 migrationreason_family
order migrationreason_*, after(migrationreason)

rename covpressuremanage_1 covpressuremanage_balance
rename covpressuremanage_4 covpressuremanage_borrow
order covpressuremanage_*, after(covpressuremanage)

rename covmigrationagainreason_1 covmigrationagainreason_nowork
rename covmigrationagainreason_2 covmigrationagainreason_advanc
rename covmigrationagainreason_3 covmigrationagainreason_assura
rename covmigrationagainreason_4 covmigrationagainreason_repay
rename covmigrationagainreason_5 covmigrationagainreason_opport
rename covmigrationagainreason_6 covmigrationagainreason_intere
rename covmigrationagainreason_7 covmigrationagainreason_money
rename covmigrationagainreason_9 covmigrationagainreason_status
rename covmigrationagainreason_11 covmigrationagainreason_famil
rename covmigrationagainreason_77 covmigrationagainreason_other
order covmigrationagainreason_*, after(covmigrationagainreason)

destring migrationjobid, replace

save"$directory\CLEAN\NEEMSIS_APPEND-migrationjobidgroup_v3", replace
clear all
****************************************
* END
