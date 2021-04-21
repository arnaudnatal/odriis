/*
NEEMSIS report
March 2020
// Labour Module //
Arnaud NATAL
*/

// Cleaning
use "\NEEMSIS tracking_Append_Last.dta"

keep householdidoriginal individualid_count migsatisfaction migsatisfactionprogress_* migsatisfactionsalary_* migrespect_* migworkmate_* miguseknowledgeatwork_* migsatisfyingpurpose_* migschedule_* migtakeholiday_* migagreementatwork* migchangework_* mighappywork_* migdiscrimination* migexecutionwork* migaccidentalinjury_* miglosswork_* miglossworknumber_* migmostseriousincident_* migmostseriousinjury_* migphysicalharm_* migproblemwork* migworkexposure* mighearworker_* migprofessionalequipment_* migbreak_* migretirementwork_* migverbalaggression_* migphysicalagression_* migsexualharassment_*

*dropmiss, force

// Analysis ?
tab migsatisfaction

tab migrespect_1

*---Begin_Loop---*
foreach var in migrespect migworkmate miguseknowledgeatwork migsatisfactionprogress migsatisfyingpurpose migschedule migtakeholiday migagreementatwork1 migagreementatwork2 migagreementatwork3 migagreementatwork4 migchangework mighappywork migsatisfactionsalary migexecutionwork1 migexecutionwork2 migexecutionwork3 migexecutionwork4 migexecutionwork5 migexecutionwork6 migexecutionwork7 migexecutionwork8 migexecutionwork9 migexecutionwork10 migaccidentalinjury miglosswork miglossworknumber migmostseriousincident migmostseriousinjury migphysicalharm migproblemwork1 migproblemwork2 migproblemwork3 migproblemwork4 migproblemwork5 migproblemwork6 migproblemwork7 migproblemwork8 migproblemwork9 migworkexposure1 migworkexposure2 migworkexposure3 migworkexposure4 migworkexposure5 mighearworker migprofessionalequipment migbreak migretirementwork migverbalaggression migphysicalagression migsexualharassment migdiscrimination1 migdiscrimination2 migdiscrimination3 migdiscrimination4 migdiscrimination5 migdiscrimination6 migdiscrimination7 migdiscrimination8 migdiscrimination9 {
gen `var'=`var'_1 if `var'_1!=.
}
*---End_Loop---*

*Il manque des variables pour que la boucle fonctionne
*forvalues i=2(1)5{ 
*gen miglosswork_`i'=.
*gen miglossworknumber_`i'=.
*gen migmostseriousincident_`i'=.
*gen migmostseriousinjury_`i'=.
*}

*---Begin_Loop---*
foreach var in migrespect migworkmate miguseknowledgeatwork migsatisfactionprogress migsatisfyingpurpose migschedule migtakeholiday migagreementatwork1 migagreementatwork2 migagreementatwork3 migagreementatwork4 migchangework mighappywork migsatisfactionsalary migexecutionwork1 migexecutionwork2 migexecutionwork3 migexecutionwork4 migexecutionwork5 migexecutionwork6 migexecutionwork7 migexecutionwork8 migexecutionwork9 migexecutionwork10 migaccidentalinjury miglosswork miglossworknumber migmostseriousincident migmostseriousinjury migphysicalharm migproblemwork1 migproblemwork2 migproblemwork3 migproblemwork4 migproblemwork5 migproblemwork6 migproblemwork7 migproblemwork8 migproblemwork9 migworkexposure1 migworkexposure2 migworkexposure3 migworkexposure4 migworkexposure5 mighearworker migprofessionalequipment migbreak migretirementwork migverbalaggression migphysicalagression migsexualharassment migdiscrimination1 migdiscrimination2 migdiscrimination3 migdiscrimination4 migdiscrimination5 migdiscrimination6 migdiscrimination7 migdiscrimination8 migdiscrimination9 {
forvalues i=2(1)5{
replace `var'=`var'_`i' if `var'_`i'!=.
}
}
*---End_Loop---*


keep householdidoriginal individualid_count migsatisfaction migrespect migworkmate miguseknowledgeatwork migsatisfactionprogress migsatisfyingpurpose migschedule migtakeholiday migagreementatwork1 migagreementatwork2 migagreementatwork3 migagreementatwork4 migchangework mighappywork migsatisfactionsalary migexecutionwork1 migexecutionwork2 migexecutionwork3 migexecutionwork4 migexecutionwork5 migexecutionwork6 migexecutionwork7 migexecutionwork8 migexecutionwork9 migexecutionwork10 migaccidentalinjury miglosswork miglossworknumber migmostseriousincident migmostseriousinjury migphysicalharm migproblemwork1 migproblemwork2 migproblemwork3 migproblemwork4 migproblemwork5 migproblemwork6 migproblemwork7 migproblemwork8 migproblemwork9 migworkexposure1 migworkexposure2 migworkexposure3 migworkexposure4 migworkexposure5 mighearworker migprofessionalequipment migbreak migretirementwork migverbalaggression migphysicalagression migsexualharassment migdiscrimination1 migdiscrimination2 migdiscrimination3 migdiscrimination4 migdiscrimination5 migdiscrimination6 migdiscrimination7 migdiscrimination8 migdiscrimination9

label var migagreementatwork1 "I do this job because I need the money"
	
*Satisfaction
tab1 migsatisfaction migrespect migworkmate miguseknowledgeatwork migsatisfactionprogress migsatisfyingpurpose migschedule migtakeholiday migagreementatwork* migchangework mighappywork migsatisfactionsalary

*Condition
tab1 migexecutionwork* migaccidentalinjury miglosswork miglossworknumber migmostseriousincident migmostseriousinjury migphysicalharm migproblemwork* migworkexposure* mighearworker migprofessionalequipment migbreak migretirementwork migverbalaggression migphysicalagression migsexualharassment

*Discri
tab1 migdiscrimination*



*Why many missings?
tab migaccidentalinjury
tab miglosswork

gen missing=1 if migaccidentalinjury==1 & miglosswork==.
tab missing
tab householdidoriginal if missing==1

decode householdidoriginal, gen(HHID)
egen HHindid=concat(HHID individualid_count), p(/)

tab HHindid if missing==1
