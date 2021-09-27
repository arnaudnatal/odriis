cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
September 27, 2021
-----
CLEANING Tracking pour indiv en panel
-------------------------
*/



****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all

global data "D:\Documents\_Thesis\_DATA\Tracking2016\DATA"
global git "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\Individual_panel"

****************************************
* END







****************************************
* Deuxième cleaning (en juin pour faire coller avec les autres bases)
****************************************
use"C:\Users\Arnaud\Dropbox\RUME-NEEMSIS\Tracking1\NEEMSIS-tracking_comp_v3.dta", clear

order HHID name
rename HHID HHID2010
decode householdvillageoriginal, gen(villageid)
drop householdvillageoriginal householdidoriginal

order HHID2010 villageid name

drop HHINDIDn

rename submissiondate submissiondate_o
gen submissiondate=dofc(submissiondate_o)
format submissiondate %td
drop submissiondate_o
sort HHID2010

foreach x in submissiondate interviewdate migdatestartoccup_1_1 migdatestartoccup_1_2 migdatestartoccup_2_1 migdatestartoccup_3_1 migdatestartoccup_4_1 migdatestartoccup_5_1 {
bysort HHID2010: egen max_`x'=max(`x')
drop `x'
rename max_`x' `x'
}

foreach x in interviewdate migdatestartoccup_1_1 migdatestartoccup_1_2 migdatestartoccup_2_1 migdatestartoccup_3_1 migdatestartoccup_4_1 migdatestartoccup_5_1 submissiondate {
format `x' %d
}

drop migmigration1reason_1 migmigration1reason_2 migmigration1reason_3 migmigration1reason_4 migmigration1reason_5 migmigration1reason_6 migmigration1reason_7 migmigration1reason_8 migmigration1reason_9 migmigration1reason_10 migmigration1reason_77


drop migsourcemigrationcost_1 migsourcemigrationcost_2 migsourcemigrationcost_3 migsourcemigrationcost_4 migsourcemigrationcost_5 migsourcemigrationcost_66 migsourcemigrationcost_99

drop migmigration1helprelationship_1 migmigration1helprelationship_1_ migmigration1helprelationship_2_ migmigration1helprelationship_3_ migmigration1helprelationship_4_ migmigration1helprelationship_5_ migmigration1helprelationship_6_ migmigration1helprelationship_7_ migmigration1helprelationship_8_ migmigration1helprelationship_9_ migmigration1helprelationship_10 migmigration1helprelationship_11 migmigration1helprelationship_12 migmigration1helprelationship_13 migmigration1helprelationship_14 migmigration1helprelationship_15

drop migmigration1helpfindjobhow_1_1 migmigration1helpfindjobhow_2_1 migmigration1helpfindjobhow_3_1 migmigration1helpfindjobhow_4_1 migmigration1helpfindjobhow_77_1

order HHID2010 strange name namenumber sex age relationshiptohead maritalstatus caste religion familymembers_coun comefrom everattendedschool classcompleted currentlyatschool educationexpenses employment_coun relationshiptoheadother casteother dummyworkedpastyear


********** Pb avec les remittances
drop remittancesreceivedservices_2 remittancesreceivedservices_3 remittancesreceivedservices_4 remittancesreceivedservices_5 remittancesreceivedservices_7
rename remittancesreceivedservices_1 remittancesreceivedservices
drop remittancessentname1

foreach x in remittancessentid remittancessentname remittancessentrelation remittancessentoccup remittancessentplace remittancessentfrequency remittancessentamount remittancessentservices remittancesrecipientid remittancesrecipientname remittancesreceivedamount {
rename `x'_1 `x'
}



********** Merger les id
*HHID_panel
merge m:m HHID2010 using "$git\code_HH", keepusing(HHID_panel)
drop if _merge==2
tab HHID_panel
drop _merge
sort HHID_panel
order HHID_panel HHID2010 namemigrant
gen INDID_panel=""
order HHID_panel HHID2010 INDID_panel namemigrant


*INDID_panel
merge m:m HHID_panel INDID_panel using "$git\code_indiv_2010_2016_2020"

gen HHok=1 if dummyego!=.
bysort HHID_panel: egen max_HHok=max(HHok)
drop if max_HHok==.
sort HHID_panel INDID_panel

order HHID_panel year INDID_panel name namenumber sex age relationshiptohead maritalstatus
drop _merge
sort HHID_panel name

split INDID_panel, p(_)
order HHID_panel year INDID_panel INDID_panel1 INDID_panel2
destring INDID_panel2, replace
bysort HHID_panel name: egen max_INDID_panel2=max(INDID_panel2)

gen trackok=.
replace trackok=1 if INDID_panel2==. & max_INDID_panel2!=.
replace trackok=0 if INDID_panel2==. & max_INDID_panel2==.

order HHID_panel year INDID_panel INDID_panel1 INDID_panel2 max_INDID_panel2 name trackok

sort HHID_panel name year
sort HHID_panel max_INDID_panel2 year INDID_panel2 year

tab trackok

*Max par HH
bysort HHID_panel : egen max_INDID=max(INDID_panel2)

*_n pour les missings puis somme
bysort HHID_panel max_INDID_panel2 : gen new_nb=_n if max_INDID_panel2==.

order HHID_panel year INDID_panel INDID_panel1 INDID_panel2 max_INDID_panel2 max_INDID new_nb name trackok namemigrant

order namenumber, last

replace max_INDID_panel2=max_INDID+new_nb if max_INDID_panel2==.


********** Reshape pour les occupations
preserve
*reshape occupationnumber_1 occupationname_1 kindofwork_1 monthsayear_1 daysamonth_1 hoursaday_1 annualincome_1 hoursayear_1 joblocation_1
restore


********** Reshape pour les business
preserve

restore


save"C:\Users\Arnaud\Dropbox\RUME-NEEMSIS\Tracking1\NEEMSIS-tracking_comp_v4.dta", replace

****************************************
* END
