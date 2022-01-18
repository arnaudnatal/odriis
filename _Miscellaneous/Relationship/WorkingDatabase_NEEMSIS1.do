********************************
** WORKING DATABASE NEEMSIS-1 **
********************************

** 1. Household database **
*-------------------------*
use "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS1\NEEMSIS1-HH.dta", clear 

	* 1.1 Droping individuals who left the household * 
	codebook livinghome
	drop if livinghome==3 | livinghome==4
	
	* 1.2 Dealing with miscoding between gender and relationship to head *
	sort HHID_panel INDID_panel 
	merge m:m HHID_panel INDID_panel using "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS1-SexCorrection.dta"
	drop if _merge==2 
		
		* 1.2.1 Gender correction * 
		replace sex=sex_NEEMSIS1 if _merge==3
		drop _merge 
		drop sex_NEEMSIS1
		
		* 1.2.2 Relationship to head correction *
		ta relationshiptohead sex
		* 3 wives who are males 
		// 1 father who is a female 
		// 4 sons who are females 
		// 3 daughters who are males 
		// 3 daughters-in-law who are males 
		// 3 grandmothers who are males 
		
		ta relationshiptohead sex, nolabel
		// Wife & male -> husband 
		replace relationshiptohead=0 if relationshiptohead==2 & sex==1
		// Father & female -> mother 
		replace relationshiptohead=3 if relationshiptohead==4 & sex==2
		// Son & female -> daughter 
		replace relationshiptohead=6 if relationshiptohead==5 & sex==2
		// Daughter & male -> son 
		replace relationshiptohead=5 if relationshiptohead==6 & sex==1
		// Daughter-in-law & male -> son-in-law
		replace relationshiptohead=7 if relationshiptohead==8 & sex==1
		// Grandmother & male -> grandfather 
		replace relationshiptohead=15 if relationshiptohead==16 & sex==1
		
		// Labels
		label define relationshiptoheadlbl 0 "Husband" 1 "Head" 2 "Wife" 3 "Mother" 4 "Father" 5 "Son" 6 "Daughter" 7 "Son-in-law" 8 "Daughter-in-law" 9 "Sister" 10 "Brother" 11 "Mother-in-law" 12 "Father-in-law" 13 "Grandchild" 15 "Grandfather" 16 "Grandmother" 17 "Cousin" 77 "Other"
		label values relationshiptohead relationshiptoheadlbl
	
	* 1.3 Database saving *
	save "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS1\NEEMSIS1-HH-WRKNGDATABASE.dta", replace 
	
	