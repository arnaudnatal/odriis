********************************************************
** PANEL DATA - GENDER & RELATIONSHIPTOHEAD MISCODING **
********************************************************

** 1. RUME **
*-----------*
use "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\RUME\RUME-HH.dta", clear
	
	* 1.1 Checking for potential miscoding *
	ta relationshiptohead2 sex
	* It seems that there is no miscoding between "relationshiptohead" and "sex" in RUME data *
	

** 2. NEEMSIS-1 **
*----------------*
use "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS1\NEEMSIS1-HH.dta", clear
		
	* 2.1 Checking for potential miscoding * 
	ta relationshiptohead sex
	* It seems that there are some miscoding between relationshiptohead and sex:
	// 7 wives who are males
	// 1 father who is a female
	// 5 sons who are females
	// 3 daughters who are males
	// 3 daughters-in-law who are males
	// 3 grandmothers who are males * 
		
	** Which are the households concerned? **
	ta relationshiptohead sex, nolabel 
	// Wife & male 
	codebook HHID_panel if relationshiptohead==2 & sex==1
	*ELA36 KUV14 MAN43 MANAM50 MANAM9 NAT36 ORA7*
		
	// Father & female 
	codebook HHID_panel if relationshiptohead==4 & sex==2
	*NAT27*
		
	// Son & female 
	codebook HHID_panel if relationshiptohead==5 & sex==2
	*ELA13 KAR49 KAR8 NAT42 ORA13*
		
	// Daughter & male 
	codebook HHID_panel if relationshiptohead==6 & sex==1
	*KAR39 KOR30 ORA36*
		
	// Daughter-in-law & male 
	codebook HHID_panel if relationshiptohead==8 & sex==1
	*KAR45 MANAM50 ORA26*
		
	// Grandmother & male 
	codebook HHID_panel if relationshiptohead==16 & sex==1
	*KAR18 KUV20 ORA42*
		
		
	* 2.2 Keeping households of interest *
	**ELA36 KUV14 MAN43 MANAM50 MANAM9 NAT36 ORA7 NAT27 ELA13 KAR49 KAR8 NAT42 ORA13 KAR39 KOR30 ORA36 KAR45 MANAM50 ORA26 KAR18 KUV20 ORA42**
	keep if HHID_panel=="ELA36" | HHID_panel=="KUV14" | HHID_panel=="MAN43" | HHID_panel=="MANAM50" | HHID_panel=="MANAM9" | HHID_panel=="NAT36" | HHID_panel=="ORA7" | HHID_panel=="NAT27" | HHID_panel=="ELA13" | HHID_panel=="KAR49" | HHID_panel=="KAR8" | HHID_panel=="NAT42" | HHID_panel=="ORA13" | HHID_panel=="KAR39" | HHID_panel=="KOR30" | HHID_panel=="ORA36" | HHID_panel=="KAR45" | HHID_panel=="MANAM50" | HHID_panel=="ORA26" | HHID_panel=="KAR18" | HHID_panel=="KUV20" | HHID_panel=="ORA42"
	
	* 2.3 Keeping individuals of interest * 
		* 2.3.1 Targeting individuals of interest *
		// Wife & male 
		preserve 
		keep if HHID_panel=="ELA36" | HHID_panel=="KUV14" | HHID_panel=="MAN43" | HHID_panel=="MANAM50" | HHID_panel=="MANAM9" | HHID_panel=="NAT36" | HHID_panel=="ORA7"
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==2 & sex==1
		* Ind_1: ELA36 KUV14 MAN43 MANAM50 MANAM9 
		// Ind_2: NAT36 ORA7 *
		restore 
		
		// Father & female 
		preserve 
		keep if HHID_panel=="NAT27" 
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==4 & sex==2
		* Ind_3: NAT27 * 
		restore 
		
		// Son & female 
		preserve 
		keep if HHID_panel=="ELA13" | HHID_panel=="KAR49" | HHID_panel=="KAR8" | HHID_panel=="NAT42" | HHID_panel=="ORA13"
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==5 & sex==2
		* Ind_5: ELA13 KAR8
		// Ind_7: KAR49
		// Ind_4: NAT42
		// Ind_2: ORA13 * 
		restore 
		
		// Daughter & male 
		preserve 
		keep if HHID_panel=="KAR39" | HHID_panel=="KOR30" | HHID_panel=="ORA36"
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==6 & sex==1
		* Ind_4: KAR39 ORA36 
		// Ind_5: KOR30 *
		restore 
		
		// Daughter-in-law & male 
		preserve 
		keep if HHID_panel=="KAR45" | HHID_panel=="MANAM50" | HHID_panel=="ORA26"
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==8 & sex==1
		* Ind_6: KAR45 MANAM50 
		// Ind_9: ORA26 *
		restore 
		
		// Grandmother & male 
		preserve 
		keep if HHID_panel=="KAR18" | HHID_panel=="KUV20" | HHID_panel=="ORA42"
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==16 & sex==1
		* Ind_3: KAR18 ORA42 
		// Ind_1: KUV20 *
		restore 
		
		* 2.3.2 Keeping only these individuals *
		**Ind_1: KUV14 MANAM50 ELA36 MANAM9 MAN43 KUV20**
		**Ind_2: ORA7 NAT36 ORA13**
		**Ind_3: NAT27 ORA42 KAR18**
		**Ind_4: NAT42 ORA36 KAR39**
		**Ind_5: ELA13 KAR8 KOR30**
		**Ind_6: KAR45 MANAM50**
		**Ind_7: KAR49**
		**Ind_9: ORA26** 
		keep if (HHID_panel=="KUV14" & INDID_panel=="Ind_1") | (HHID_panel=="MANAM50" & INDID_panel=="Ind_1") | (HHID_panel=="ELA36" & INDID_panel=="Ind_1") | (HHID_panel=="MANAM9" & INDID_panel=="Ind_1") | (HHID_panel=="MAN43" & INDID_panel=="Ind_1") | (HHID_panel=="KUV20" & INDID_panel=="Ind_1") | (HHID_panel=="ORA7" & INDID_panel=="Ind_2") | (HHID_panel=="NAT36" & INDID_panel=="Ind_2") | (HHID_panel=="ORA13" & INDID_panel=="Ind_2") | (HHID_panel=="NAT27" & INDID_panel=="Ind_3") | (HHID_panel=="ORA42" & INDID_panel=="Ind_3") | (HHID_panel=="KAR18" & INDID_panel=="Ind_3") | (HHID_panel=="NAT42" & INDID_panel=="Ind_4") | (HHID_panel=="ORA36" & INDID_panel=="Ind_4") | (HHID_panel=="KAR39" & INDID_panel=="Ind_4") | (HHID_panel=="ELA13" & INDID_panel=="Ind_5") | (HHID_panel=="KAR8" & INDID_panel=="Ind_5") | (HHID_panel=="KOR30" & INDID_panel=="Ind_5") | (HHID_panel=="KAR45" & INDID_panel=="Ind_6") | (HHID_panel=="MANAM50" & INDID_panel=="Ind_6") | (HHID_panel=="KAR49" & INDID_panel=="Ind_7") | (HHID_panel=="ORA26" & INDID_panel=="Ind_9")
	
	* 2.4 Keeping variables of interest *
	keep HHID_panel INDID_panel sex relationshiptohead name
	rename sex sex_NEEMSIS1, replace
	rename relationshiptohead relationshiptohead_NEEMSIS1, replace
	rename name name_NEEMSIS1, replace 
	

save "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS1-Sex&Relationship.dta", replace
	
	
** 3. NEEMSIS-2 **
*----------------*
use "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS2\NEEMSIS2-HH.dta", clear 

	* 3.1 Checking for potential miscoding *
	ta relationshiptohead sex
	* Indeed, we have: 
	//3 wives who are males
	// 1 mother who is a male
	// 1 father who is a female
	// 24 sons who are females 
	// 12 daughters who are males 
	// 6 daughters-in-law who are males 
	// 3 fathers-in-law who are females
	// 2 grandfathers who are females * 
	
	** Which are the households concerned? **
	ta relationshiptohead sex, nolabel
	sort HHID_panel
	// Wife & male
	codebook HHID_panel if relationshiptohead==2 & sex==1
	*NAT31 NAT36 ORA7* 

	// Mother & male
	codebook HHID_panel if relationshiptohead==3 & sex==1
	*ORA67*
			
	// Father & female
	codebook HHID_panel if relationshiptohead==4 & sex==2
	*NAT27*
			
	// Son & female
	ta HHID_panel if relationshiptohead==5 & sex==2
	*ELA13 ELA9 GOV17 GOV33 GOV51 KAR14 KAR49 KAR56 KAR8 KOR18 KOR24 KOR36 KOR44 KUV24 KUV35 KUV6 MAN31 MAN48 MAN56 MANAM17 NAT42 ORA30 ORA43*

	// Daughter & male
	ta HHID_panel if relationshiptohead==6 & sex==1
	*ELA25 KOR24 KUV19 KUV44 KUV7 MANAM22 NAT11 ORA30 ORA39 SEM15 SEM28 SEM46*
			
	// Daughter-in-law & male
	codebook HHID_panel if relationshiptohead==8 & sex==1
	*KAR45 MANAM15 MANAM50 NAT57 ORA26*
			
	// Father-in-law & female
	codebook HHID_panel if relationshiptohead==12 & sex==2
	*KUV12 MAN23 SEM14*
			
	// Grandfather & female
	codebook HHID_panel if relationshiptohead==15 & sex==2
	*MANAM49 MANAM5* 
	
	* 3.2 Keeping households of interest *
	**NAT31 NAT36 ORA7 ORA67 NAT27 ELA13 ELA9 GOV17 GOV33 GOV51 KAR14 KAR49 KAR56 KAR8 KOR18 KOR24 KOR36 KOR44 KUV24 KUV35 KUV6 MAN31 MAN48 MAN56 MANAM17 NAT42 ORA30 ORA43 ELA25 KOR24 KUV19 KUV44 KUV7 MANAM22 NAT11 ORA30 ORA39 SEM15 SEM28 SEM46 KAR45 MANAM15 MANAM50 NAT57 ORA26 KUV12 MAN23 SEM14 MANAM49 MANAM5** 
	keep if HHID_panel=="NAT31" | HHID_panel=="NAT36" | HHID_panel=="ORA7" | HHID_panel=="ORA67" | HHID_panel=="NAT27" | HHID_panel=="ELA13" | HHID_panel=="ELA9" | HHID_panel=="GOV17" | HHID_panel=="GOV33" | HHID_panel=="GOV51" | HHID_panel=="KAR14" | HHID_panel=="KAR49" | HHID_panel=="KAR56" | HHID_panel=="KAR8" | HHID_panel=="KOR18" | HHID_panel=="KOR24" | HHID_panel=="KOR36" |  HHID_panel=="KOR44" | HHID_panel=="KUV24" | HHID_panel=="KUV35" | HHID_panel=="KUV6" | HHID_panel=="MAN31" | HHID_panel=="MAN48" | HHID_panel=="MAN56" | HHID_panel=="MANAM17" | HHID_panel=="NAT42" | HHID_panel=="ORA30" | HHID_panel=="ORA43" | HHID_panel=="ELA25" | HHID_panel=="KOR24" | HHID_panel=="KUV19" | HHID_panel=="KUV44" | HHID_panel=="KUV7" | HHID_panel=="MANAM22" | HHID_panel=="NAT11" | HHID_panel=="ORA30" | HHID_panel=="ORA39" | HHID_panel=="SEM15" | HHID_panel=="SEM28" | HHID_panel=="SEM46" | HHID_panel=="KAR45" | HHID_panel=="MANAM15" | HHID_panel=="MANAM50" | HHID_panel=="NAT57" | HHID_panel=="ORA26" | HHID_panel=="KUV12" | HHID_panel=="MAN23" | HHID_panel=="SEM14" | HHID_panel=="MANAM49" | HHID_panel=="MANAM5"
	
	* 3.3 Keeping individuals of interest * 
		* 3.3.1 Targeting individuals of interest *
		// Wife & male
		preserve 
		keep if HHID_panel=="NAT31" | HHID_panel=="NAT36" | HHID_panel=="ORA7"
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==2 & sex==1
		* Ind_2: NAT36 ORA7
		// Ind_3: NAT31 *
		restore 

		// Mother & male
		preserve 
		keep if HHID_panel=="ORA67"
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==3 & sex==1
		* Ind_4: ORA67 *
		restore 
				
		// Father & female
		preserve 
		keep if HHID_panel=="NAT27"
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==4 & sex==2
		* Ind_3: NAT27 *
		restore 
				
		// Son & female
		preserve 
		keep if HHID_panel=="ELA13" | HHID_panel=="ELA9" | HHID_panel=="GOV17" | HHID_panel=="GOV33" | HHID_panel=="GOV51" | HHID_panel=="KAR14" | HHID_panel=="KAR49" | HHID_panel=="KAR56" | HHID_panel=="KAR8" | HHID_panel=="KOR18" | HHID_panel=="KOR24" | HHID_panel=="KOR36" |  HHID_panel=="KOR44" | HHID_panel=="KUV24" | HHID_panel=="KUV35" | HHID_panel=="KUV6" | HHID_panel=="MAN31" | HHID_panel=="MAN48" | HHID_panel=="MAN56" | HHID_panel=="MANAM17" | HHID_panel=="NAT42" | HHID_panel=="ORA30" | HHID_panel=="ORA43"
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==5 & sex==2
		* Ind_5: ELA13 KAR14 KAR8 KOR18 KUV24 KUV35 MAN48 
		// Ind_3: ELA9 GOV33 KAR56 KOR36 KUV6 ORA30 MANAM17
		// Ind_8: GOV17 
		// Ind_4: GOV51 KOR44 KUV24 MAN31 MAN56 NAT42 
		// Ind_7: KAR49 
		// Ind_6: KOR24 ORA43 *
		restore 
		
		// Daughter & male
		preserve 
		keep if HHID_panel=="ELA25" | HHID_panel=="KOR24" | HHID_panel=="KUV19" | HHID_panel=="KUV44" | HHID_panel=="KUV7" | HHID_panel=="MANAM22" | HHID_panel=="NAT11" | HHID_panel=="ORA30" | HHID_panel=="ORA39" | HHID_panel=="SEM15" | HHID_panel=="SEM28" | HHID_panel=="SEM46" 
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==6 & sex==1
		* Ind_4: ELA25 NAT11 SEM15 
		// Ind_7: KOR24
		// Ind_3: KUV19 KUV44 KUV7 MANAM22 
		// Ind_5: ORA30 ORA39 
		// Ind_1: SEM28 SEM46 * 
		restore 
		
		// Daughter-in-law & male
		preserve 
		keep if HHID_panel=="KAR45" | HHID_panel=="MANAM15" | HHID_panel=="MANAM50" | HHID_panel=="NAT57" | HHID_panel=="ORA26"
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==8 & sex==1
		* Ind_6: KAR45 MANAM15 MANAM50 *
		// Ind_5: MANAM15
		// Ind_1: NAT57
		// Ind_9: ORA26 *
		restore 
				
		// Father-in-law & female
		preserve 
		keep if HHID_panel=="KUV12" | HHID_panel=="MAN23" | HHID_panel=="SEM14"
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==12 & sex==2
		* Ind_6: KUV12
		// Ind_4: MAN23
		// Ind_2: SEM14 * 
		restore 
				
		// Grandfather & female
		preserve 
		keep if HHID_panel=="MANAM49" | HHID_panel=="MANAM5"
		sort HHID_panel
		list HHID_panel INDID_panel if relationshiptohead==15 & sex==2
		* Ind_1: MANAM49
		// Ind_6: MANAM5 *
		restore 
		
		* 3.3.2 Keeping only these individuals *
		**Ind_1: SEM28 SEM46 MANAM49 NAT57**
		**Ind_2: NAT36 ORA7 SEM14**
		**Ind_3: NAT31 ELA9 KAR56 KOR36 KUV6 MANAM17 ORA30 GOV33 KUV19 KUV44 KUV7 MANAM22 NAT27**
		**Ind_4: GOV51 KOR44 KUV24 MAN31 MAN56 NAT42 MAN23 ORA67 ELA25 NAT11 SEM15**
		**Ind_5: ELA13 KAR14 KAR8 KOR18 KUV24 KUV35 MAN48 ORA30 ORA39 MANAM15**
		**Ind_6: KOR24 ORA43 KUV12 MANAM5 KAR45 MANAM15 MANAM50**
		**Ind_7: KAR49 KOR24**
		**Ind_8: GOV17**
		**Ind_9: ORA26** 
		keep if (HHID_panel=="SEM28" & INDID_panel=="Ind_1") | (HHID_panel=="SEM46" & INDID_panel=="Ind_1") | (HHID_panel=="MANAM49" & INDID_panel=="Ind_1") | (HHID_panel=="NAT57" & INDID_panel=="Ind_1") | (HHID_panel=="NAT36" & INDID_panel=="Ind_2") | (HHID_panel=="ORA7" & INDID_panel=="Ind_2") | (HHID_panel=="SEM14" & INDID_panel=="Ind_2") | (HHID_panel=="GOV33" & INDID_panel=="Ind_3") | (HHID_panel=="NAT31" & INDID_panel=="Ind_3") | (HHID_panel=="ELA9" & INDID_panel=="Ind_3") | (HHID_panel=="KAR56" & INDID_panel=="Ind_3") | (HHID_panel=="KOR36" & INDID_panel=="Ind_3") | (HHID_panel=="KUV6" & INDID_panel=="Ind_3") | (HHID_panel=="MANAM17" & INDID_panel=="Ind_3") | (HHID_panel=="ORA30" & INDID_panel=="Ind_3") | (HHID_panel=="KUV19" & INDID_panel=="Ind_3") |  (HHID_panel=="KUV44" & INDID_panel=="Ind_3") | (HHID_panel=="KUV7" & INDID_panel=="Ind_3") | (HHID_panel=="MANAM22" & INDID_panel=="Ind_3") | (HHID_panel=="NAT27" & INDID_panel=="Ind_3") | (HHID_panel=="GOV51" & INDID_panel=="Ind_4") | (HHID_panel=="KOR44" & INDID_panel=="Ind_4") | (HHID_panel=="KUV24" & INDID_panel=="Ind_4") | (HHID_panel=="MAN31" & INDID_panel=="Ind_4") | (HHID_panel=="MAN56" & INDID_panel=="Ind_4") | (HHID_panel=="NAT42" & INDID_panel=="Ind_4") | (HHID_panel=="MAN23" & INDID_panel=="Ind_4") | (HHID_panel=="ORA67" & INDID_panel=="Ind_4") | (HHID_panel=="ELA25" & INDID_panel=="Ind_4") | (HHID_panel=="NAT11" & INDID_panel=="Ind_4") | (HHID_panel=="SEM15" & INDID_panel=="Ind_4") | (HHID_panel=="ELA13" & INDID_panel=="Ind_5") | (HHID_panel=="KAR14" & INDID_panel=="Ind_5") | (HHID_panel=="KAR8" & INDID_panel=="Ind_5") | (HHID_panel=="KOR18" & INDID_panel=="Ind_5") |  (HHID_panel=="KUV24" & INDID_panel=="Ind_5") |  (HHID_panel=="KUV35" & INDID_panel=="Ind_5") |   (HHID_panel=="MAN48" & INDID_panel=="Ind_5") | (HHID_panel=="ORA30" & INDID_panel=="Ind_5") | (HHID_panel=="ORA39" & INDID_panel=="Ind_5") | (HHID_panel=="MANAM15" & INDID_panel=="Ind_5") | (HHID_panel=="KOR24" & INDID_panel=="Ind_6") | (HHID_panel=="ORA43" & INDID_panel=="Ind_6") | (HHID_panel=="KUV12" & INDID_panel=="Ind_6") | (HHID_panel=="MANAM5" & INDID_panel=="Ind_6") | (HHID_panel=="KAR45" & INDID_panel=="Ind_6") | (HHID_panel=="MANAM15" & INDID_panel=="Ind_6") | (HHID_panel=="MANAM50" & INDID_panel=="Ind_6") |(HHID_panel=="KAR49" & INDID_panel=="Ind_7") | (HHID_panel=="KOR24" & INDID_panel=="Ind_7") |(HHID_panel=="GOV17" & INDID_panel=="Ind_8") |(HHID_panel=="ORA26" & INDID_panel=="Ind_9")
		
	* 3.4 Keeping variables of interest *
	keep HHID_panel INDID_panel sex relationshiptohead name
	rename sex sex_NEEMSIS2, replace
	rename relationshiptohead relationshiptohead_NEEMSIS2, replace
	rename name name_NEEMSIS2, replace 
	

save "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS2-Sex&Relationship.dta", replace

** 4. Merging **
*--------------*
	* 4.1 RUME *
	use "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\RUME\RUME-HH.dta", clear
		// Keeping only variables of interest
		keep HHID_panel INDID_panel sex relationshiptohead2 name
		rename relationshiptohead2 relationshiptohead, replace
		save "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\RUME\RUME-Sex&Relationship.dta", replace
	
	* 4.2 Merging with NEEMSIS-1 *
	sort HHID_panel INDID_panel 
	merge m:m HHID_panel INDID_panel using "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS1-Sex&Relationship.dta" 
	* 11 matched obs. out of 22: the 11 not matched obs. refer to newcomers for whom we do not have any reference in matter of sex in RUME *
	
		* 4.2.1 Variables *
		keep if _merge==3
		drop _merge 
		replace sex_NEEMSIS1=sex
		keep HHID_panel INDID_panel sex_NEEMSIS1
		
		* 4.2.2 Database with gender correction * 
		save "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS1-SexCorrection.dta", replace 
		
	
	* 4.3 Merging with NEEMSIS-2 *
	use "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\RUME\RUME-Sex&Relationship.dta", clear
	sort HHID_panel INDID_panel 
	merge m:m HHID_panel INDID_panel using "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS2-Sex&Relationship.dta" 
	* 29 matched obs. out of 52: the 23 not matched obs. refer to newcomers for whom we do not have any reference in matter of sex in RUME *
	
		* 4.3.1 Variables *
		keep if _merge==3 
		drop _merge
		replace sex_NEEMSIS2=sex 
		keep HHID_panel INDID_panel sex_NEEMSIS2
		
		* 4.3.2 Database with gender correction *
		save "C:\Users\disantolo\OneDrive - Université Paris-Dauphine\Thèse\Chpt2\Databases\NEEMSIS2-SexCorrection.dta", replace 
	
		

