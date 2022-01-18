********************************
** WORKING DATABASE NEEMSIS-2 **
********************************

** 1. Household database **
*-------------------------*
use "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS2\NEEMSIS2-HH.dta", clear 

	* 1.1 Droping individuals who left the household * 
	codebook INDID_left livinghome
	drop if INDID_left!=. | livinghome==3 | livinghome==4
	
	* 1.2 Dealing with miscoding between gender and relationship to head *
	sort HHID_panel INDID_panel 
	merge m:m HHID_panel INDID_panel using "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS2-SexCorrection.dta"
	drop if _merge==2 
		
		* 1.2.1 Gender correction * 
		replace sex=sex_NEEMSIS2 if _merge==3
		drop _merge 
		drop sex_NEEMSIS2
		
		* 1.2.2 Relationship to head correction *
		ta relationshiptohead sex
		* 3 wives who are males 
		// 1 mother who is a male 
		// 1 father who is a female 
		// 21 sons who are females 
		// 12 daughters who are males 
		// 6 daughters-in-law who are males 
		// 3 fathers-in-law who are females 
		// 2 grandfathers who are females 
		
		ta relationshiptohead sex, nolabel
		// Wife & male -> husband 
		replace relationshiptohead=0 if relationshiptohead==2 & sex==1
		// Mother & male -> father 
		replace relationshiptohead=4 if relationshiptohead==3 & sex==1
		// Father & female -> mother 
		replace relationshiptohead=3 if relationshiptohead==4 & sex==2
		// Son & female -> daughter 
		replace relationshiptohead=6 if relationshiptohead==5 & sex==2
		// Daughter & male -> son 
		replace relationshiptohead=5 if relationshiptohead==6 & sex==1
		// Daughter-in-law & male -> son-in-law
		replace relationshiptohead=7 if relationshiptohead==8 & sex==1
		// Father-in-law & female -> mother-in-law
		replace relationshiptohead=11 if relationshiptohead==12 & sex==2
		// Grandfather & female -> grandmother 
		replace relationshiptohead=16 if relationshiptohead==15 & sex==2
		
		// Labels
		label define relationshiptoheadlbl 0 "Husband" 1 "Head" 2 "Wife" 3 "Mother" 4 "Father" 5 "Son" 6 "Daughter" 7 "Son-in-law" 8 "Daughter-in-law" 9 "Sister" 10 "Brother" 11 "Mother-in-law" 12 "Father-in-law" 13 "Grandchild" 15 "Grandfather" 16 "Grandmother" 17 "Cousin"
		label values relationshiptohead relationshiptoheadlbl
	
	* 1.3 Database saving *
	save "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS2\NEEMSIS2-HH-WRKNGDATABASE.dta", replace 
	
	