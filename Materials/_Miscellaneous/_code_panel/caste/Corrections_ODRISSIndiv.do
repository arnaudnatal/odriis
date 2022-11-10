*****************************************
** Base de données d'appariement panel **
*****************************************

use "${raw_dta}\ODRIIS-indiv.dta", clear 

** 1. Vagues **
*-------------*
	* 1.1 Présence à une seule vague *
	codebook wave2010 wave2016 wave2020
	* 1877, 1109, et 158 valeurs manquantes *
		
	g only2010=0
	replace only2010=1 if wave2010=="RUME (2010)" & wave2016=="" & wave2020==""
	
	g only2016=0
	replace only2016=1 if wave2010=="" & wave2016=="NEEMSIS-1 (2016-17)" & wave2020==""
		
	g only2020=0	
	replace only2020=1 if wave2010=="" & wave2016=="" & wave2020=="NEEMSIS-2 (2020-21)"
		
	* 1.2 Présence aux deux vagues *
	g in20102016=0
	replace in20102016=1 if wave2010=="RUME (2010)" & wave2016=="NEEMSIS-1 (2016-17)" & wave2020==""
	
	g in20102020=0
	replace in20102020=1 if wave2010=="RUME (2010)" & wave2016=="" & wave2020=="NEEMSIS-2 (2020-21)"
		
	g in20162020=0
	replace in20162020=1 if wave2010=="" & wave2016=="NEEMSIS-1 (2016-17)" & wave2020=="NEEMSIS-2 (2020-21)"
		
	* 1.3 Présence à toutes les vagues *
	g in20101620=0
	replace in20101620=1 if wave2010=="RUME (2010)" & wave2016=="NEEMSIS-1 (2016-17)" & wave2020=="NEEMSIS-2 (2020-21)"
		
	
codebook only2010 only2016 only2020 in20101620 in20102016 in20102020 in20162020
* Sur 3805 individus du panel :
// 1783 ont été retrouvés à toutes les vagues (RUME-NEEMSIS-1-NEEMSIS-2)
// 845 composent uniquement le panel NEEMSIS (NEEMSIS-1 et NEEMSIS-2)
// 43 ont été interviewés pour RUME en 2010 et l'ont été, à nouveau, en 2016 pour NEEMSIS-1
// 12 ont été interviewés pour RUME en 2010 et l'ont été, à nouveau, pour NEEMSIS-2 en 2020 
// 90 ont été uniquement interviewés pour RUME en 2010
// 25 ont été uniquement interviewés pour NEEMSIS-1 en 2016
// et 1007 ont été uniquement interviewés pour NEEMSIS-2 en 2020
		
		
** 2. Caractéristiques : âge, sexe, prénom, relation au chef de ménage,  **
*------------------------------------*
	* 2.1 Age *
	codebook age2010 age2016 age2020
	foreach var of varlist age2010 age2016 age2020 {
	destring `var', replace 
	codebook `var'
	}
	* 1877, 1109, et 158 valeurs manquantes *
		
		* 2.1.1 RUME comme base de référence *	
			* a- 2010 *
			g m_agepanel2010_r=age2010 if only2010==1 | in20101620==1 | in20102016==1 | in20102020==1 
				** Vérification **
				codebook m_agepanel2010_r
				* 1877 valeurs manquantes (O.K) *
				
				
			* b- 2016 *
			g m_agepanel2016_r=(age2010 + 6) if in20101620==1 | in20102016==1 
			replace m_agepanel2016_r=age2016 if only2016==1 | in20162020==1 
				** Vérification **
				codebook m_agepanel2016_r
				* 1109 valeurs manquantes (O.K) *
				
				
			* c- 2020 *
			g m_agepanel2020_r=(age2010 + 10) if in20101620==1 | in20102020==1 
			replace m_agepanel2020_r=age2020 if only2020==1 | in20162020==1
				** Vérification **
				codebook m_agepanel2020_r
				* 158 valeurs manquantes (O.K) *
				
				
		* 2.1.2 NEEMSIS comme base de référence *	
			* a- 2010 *
			g m_agepanel2010_n=(age2016 - 6) if in20101620==1 | in20102016==1 
			replace m_agepanel2010_n=age2010 if only2010==1 
			replace m_agepanel2010_n=(age2020 - 10) if in20102020==1 
				** Vérification **
				codebook m_agepanel2010_n
				* 1877 valeurs manquantes (O.K) *
				
				
			* b- 2016 *
			g m_agepanel2016_n=age2016 if only2016==1 | in20101620==1 | in20102016==1 | in20162020==1 
				** Vérification **
				codebook m_agepanel2016_n
				* 1109 valeurs manquantes (O.K) *
				
				
			* c- 2020 *
			g m_agepanel2020_n=(age2016 + 4) if in20101620==1 | in20162020==1 
			replace m_agepanel2020_n=age2020 if only2020==1 | in20102020==1
				** Vérification **
				codebook m_agepanel2020_n
				* 158 valeurs manquantes (O.K) *
				
			
		* 2.1.3 Différences entre les deux mesures *
			* a- 2010 *
			g diffagepanel2010=(m_agepanel2010_r - m_agepanel2010_n)
			replace diffagepanel2010=-(diffagepanel2010) if diffagepanel2010<0
			
			* b- 2016 *
			g diffagepanel2016=(m_agepanel2016_r - m_agepanel2016_n)
			replace diffagepanel2016=-(diffagepanel2016) if diffagepanel2016<0
			
			* c- 2020 *
			g diffagepanel2020=(m_agepanel2020_r - m_agepanel2020_n)
			replace diffagepanel2020=-(diffagepanel2020) if diffagepanel2020<0
			
			* d- Statistiques *
			sum(diffagepanel2010),d 
			* Différence moyenne de 1,84 et médiane à 1 *
			sum(diffagepanel2016),d
			* Différence moyenne d'environ 1,3 et médiane à 0 *
			sum(diffagepanel2020),d
			* Différence moyenne de 0,97 et médiane à 0 *
			
			* e- Représentations graphiques *
			kdensity m_agepanel2010_r, addplot(kdensity m_agepanel2010_n)
			kdensity m_agepanel2016_r, addplot(kdensity m_agepanel2016_n)
			kdensity m_agepanel2020_r, addplot(kdensity m_agepanel2020_n)
			* Peu de variation en termes de densité *
			
			
	* 2.2 Sexe *
		* 2.2.1 Cohérence à travers le panel *
		g samesex=0
		replace samesex=1 if (sex2010=="Female" & sex2016=="Female" & sex2020=="Female" & in20101620==1) | (sex2010=="Male" & sex2016=="Male" & sex2020=="Male" & in20101620==1) | (sex2010==sex2016 & in20102016==1) | (sex2010==sex2020 & in20102020==1) | (sex2016==sex2020 & in20162020==1)
		replace samesex=. if only2010==1 | only2016==1 | only2020==1
			
			codebook samesex
			* Pour 8 individus, nous n'avons pas le même sexe à travers le panel (3 points ou 2 points (2010-2016 et 2010-2020)) *
				ta HHID_panel INDID_panel if samesex==0
				* Ind_5 dans le ménage ELA22
				// Ind_4 dans le ménage GOV19
				// les Ind_3 et Ind_6 dans le ménage KUV42 
				// l'Ind_3 dans le ménage MANAM17
				// l'Ind_3 dans le ménage MANAM35
				// l'Ind_6 dans le ménage ORA26 
				// et l'Ind_3 dans le ménage SEM35 * 
				
				* Selon Venkat, 
				// Ind_5 dans le ménage ELA22 is a female 
				// Ind_4 dans le ménage GOV19 is a female 
				// les Ind_3 et Ind_6 dans le ménage KUV42 are males
				// l'Ind_3 dans le ménage MANAM17 is a male
				// l'Ind_3 dans le ménage MANAM35 is a female 
				// l'Ind_6 dans le ménage ORA26 is a male
				// et l'Ind_3 dans le ménage SEM35 is female * 
				replace sex2010="Male" if (HHID_panel=="ORA26" & INDID_panel=="Ind_6")
				replace sex2016="Female" if (HHID_panel=="ELA22" & INDID_panel=="Ind_5") | (HHID_panel=="GOV19" & INDID_panel=="Ind_4") | (HHID_panel=="SEM35" & INDID_panel=="Ind_3")
				replace sex2016="Male" if (HHID_panel=="KUV42" & INDID_panel=="Ind_6") | (HHID_panel=="MANAM17" & INDID_panel=="Ind_3")
				replace sex2020="Female" if (HHID_panel=="ELA22" & INDID_panel=="Ind_5") | (HHID_panel=="MANAM35" & INDID_panel=="Ind_3") | (HHID_panel=="SEM35" & INDID_panel=="Ind_3")
				replace sex2020="Male" if (HHID_panel=="KUV42" & INDID_panel=="Ind_3") | (HHID_panel=="MANAM17" & INDID_panel=="Ind_3")
				
		* 2.2.2 Création d'une nouvelle variable relative au sexe *
		g sex=sex2010 if only2010==1 | in20101620==1 | in20102016==1 | in20102020==1
		replace sex=sex2016 if only2016==1 | in20162020==1
		replace sex=sex2020 if only2020==1
		label var sex "Sex"
		rename sex sex_panel, replace
	
	* 2.3 Relation au chef de ménage * 
		* 2.3.1 Vérification de la cohérence avec le sexe *
		ta relationshiptohead2010 sex2010
		* O.K *
			ta relationshiptohead2010 sex2010 if (HHID_panel=="ORA26" & INDID_panel=="Ind_6")
			* Grandchildren: aucune modif à faire *
		
		ta relationshiptohead2016 sex2016
		* 2 filles sont déclarées comme étant des hommes et deux fils comme étant des femmes *
			ta HHID_panel INDID_panel if relationshiptohead2016=="Daughter" & sex2016=="Male"
			* Ind_6 dans le ménage KUV42 et Ind_3 dans le ménage MANAM17 
			// Ces deux individus sont des hommes dont nous devons remplacer leur relation au chef de ménage par "Son" *
			replace relationshiptohead2016="Son" if (HHID_panel=="KUV42" & INDID_panel=="Ind_6") | (HHID_panel=="MANAM17" & INDID_panel=="Ind_3")
			
			ta HHID_panel INDID_panel if relationshiptohead2016=="Son" & sex2016=="Female"
			* Ind_5 dans le ménage ELA22 et Ind_3 dans le ménage SEM35 
			// Ces deux individus sont des femmes donc nous devons remplacer leur relation au chef de ménage par "Daughter" *
			replace relationshiptohead2016="Daughter" if (HHID_panel=="ELA22" & INDID_panel=="Ind_5") | (HHID_panel=="SEM35" & INDID_panel=="Ind_3")
			
			ta relationshiptohead2016 sex2016 if (HHID_panel=="GOV19" & INDID_panel=="Ind_4")
			* Head : aucune modif à faire *
			
		ta relationshiptohead2020 sex2020
		* 1 fille est déclarée comme étant un homme et deux fils comme étant des femmes *
			ta HHID_panel INDID_panel if relationshiptohead2020=="Daughter" & sex2020=="Male"
			* Ind_3 dans le ménage KUV42
			// Cet individu est un homme donc il faut changer sa relation au chef de ménage par "Son" *
			replace relationshiptohead2020="Son" if (HHID_panel=="KUV42" & INDID_panel=="Ind_3")
			
			ta HHID_panel INDID_panel if relationshiptohead2020=="Son" & sex2020=="Female"
			* Ind_3 dans les ménages MANAM35 et SEM35 
			// Ces deux individus sont des femmes donc il faut changer leur relation au chef de ménage par "Daughter" *
			replace relationshiptohead2020="Daughter" if (HHID_panel=="MANAM35" & INDID_panel=="Ind_3") | (HHID_panel=="SEM35" & INDID_panel=="Ind_3") 
			
			ta relationshiptohead2020 if HHID_panel=="ELA22" & INDID_panel=="Ind_5"
			* Other : aucune modif à faire *
			ta relationshiptohead2020 if (HHID_panel=="MANAM17" & INDID_panel=="Ind_3")
			* Son : aucune modif à faire *

			
	* 2.4 Prénom *
	g name=name2010 if only2010==1 | in20101620==1 | in20102016==1 | in20102020==1
	replace name=name2016 if only2016==1 | in20162020==1
	replace name=name2020 if only2020==1
	label var name "Name"
	rename name name_panel, replace 
	
	
	* 2.5 Jatis et caste * 
		* 2.5.1 Jatis *
		foreach var of varlist jatis2010 jatis2016 jatis2020 {
		ta `var', miss 	
		}
		* No missing value *
		replace jatis2010="Mudaliar" if jatis2010=="Muthaliyar"
		replace jatis2010="Arunthathiyar" if jatis2010=="Arunthatiyar"
		
			* a- Cohérence à travers le panel *
			** 2010 et 2016 ** 
			ta jatis2010 jatis2016
			* 5 obs. qui seraient des Gramani en 2010 et des SC en 2016 *
				ta HHID_panel if jatis2010=="Gramani" & jatis2016=="SC"
				* MANAM28: qui, selon Venkat sont des SC * 
				replace jatis2010="SC" if HHID_panel=="MANAM28"
			* 4 obs. qui seraient des Other en 2010 et des Kulalar en 2016 * 
				ta HHID_panel if jatis2010=="Other" & jatis2016=="Kulalar"
					ta jatis2020 if HHID_panel=="GOV38"
					* Vanniyar en 2020 
					// Mais comme les Kulalar et les Vanniyar sont tous deux des "Middle" caste, cela ne pose pas de pb *
				** GOV38: (après vérif auprès de Venkat) je leur associe le jati des Kulalar **
				foreach var of varlist jatis2010 jatis2020 {
				replace `var'="Kulalar" if HHID_panel=="GOV38"
				}
			* 31 obs. qui seraient des Other en 2010 et des musulmans en 2016 (O.K car pas de catégorie "Muslims" en 2010) * 
				ta HHID_panel if jatis2010=="Other" & jatis2016=="Muslims" 
				* Ménages concernés: SEM1 SEM16 SEM26 SEM28 SEM35 SEM40 SEM43 qui, selon Venkat sont bien des musulmans considérés comme étant de basse caste pour les 4 premiers et de moyenne caste pour les trois derniers *
				replace jatis2010="Muslims" if HHID_panel=="SEM1" |  HHID_panel=="SEM16" |  HHID_panel=="SEM26" |  HHID_panel=="SEM28" |  HHID_panel=="SEM35" |  HHID_panel=="SEM40" |  HHID_panel=="SEM43"
			* 7 obs. qui seraient des Other en 2010 et des Naidu en 2016 *
				ta HHID_panel if jatis2010=="Other" & jatis2016=="Naidu"
				* SEM17 * 
					ta jatis2020 if HHID_panel=="SEM17"
					* Naidu également en 2020 *
				replace jatis2010="Naidu" if HHID_panel=="SEM17"
				* 3 obs. qui seraient des Other en 2010 et des Navithar en 2016 (O.K car pas de catégorie "Navithar" en 2010) * 
					ta HHID_panel if jatis2010=="Other" & jatis2016=="Navithar"  
					* ORA10 *
						ta jatis2020 if HHID_panel=="ORA10"
						* Navithar également en 2020 *
					replace jatis2010="Navithar" if HHID_panel=="ORA10"
				* 4 obs. qui seraient des Other en 2010 et des Padayachi en 2016 (O.K car pas de catégorie "Padayachi" en 2010) * 
					ta HHID_panel if jatis2010=="Other" & jatis2016=="Padayachi"  
					* ELA49 * 
						ta jatis2020 if HHID_panel=="ELA49"
						* Padayachi également en 2020 *
					replace jatis2010="Padayachi" if HHID_panel=="ELA49"
				* 10 obs. qui seraient des Other en 2010 et des SC en 2016 *
					ta HHID_panel if jatis2010=="Other" & jatis2016=="SC"  
					* Ménages concernés : KOR23 et MAN22 *
					* Selon Venkat, le ménage MAN22 est bien SC *
						ta jatis2020 if HHID_panel=="KOR23"
						* K0R23 SC également en 2020 *
					replace jatis2010="SC" if HHID_panel=="KOR23" | HHID_panel=="MAN22"
				* 3 obs. qui seraient des Other en 2010 et des Vanniyar en 2016 *
					ta HHID_panel if jatis2010=="Other" & jatis2016=="Vanniyar" 
					* KUV52 *
						ta jatis2020 if HHID_panel=="KUV52"
						* Vanniyar également en 2020 *
					replace jatis2010="Vanniyar" if HHID_panel=="KUV52"
				* 5 obs. qui seraient des Other en 2010 et des Yathavar en 2016 (O.K car pas de catégorie "Yathavar" en 2010) * 
					ta HHID_panel if jatis2010=="Other" & jatis2016=="Yathavar" 
					* KAR48 qui, selon Venkat est Yathavar *
					replace jatis2010="Yathavar" if HHID_panel=="KAR48"
				* 13 obs. qui seraient des Settu en 2010 et des Chettiyar en 2016 *
					ta HHID_panel if jatis2010=="Settu" & jatis2016=="Chettiyar" 
					* Ménages concernés : SEM10 et SEM48 *
						ta jatis2020 if HHID_panel=="SEM10" | HHID_panel=="SEM48"
						* Chettiyar également en 2020 *
					replace jatis2010="Chettiyar" if HHID_panel=="SEM10" | HHID_panel=="SEM48"
				* 7 obs. qui seraient des Settu en 2010 et des Vanniyar en 2016 *
					ta HHID_panel if jatis2010=="Settu" & jatis2016=="Vanniyar" 
					* MAN18 qui, selon Venkat serait Vanniyar *
					replace jatis2010="Vanniyar" if HHID_panel=="MAN18"
				* 10 obs. qui seraient des Vanniyar en 2010 et des Padayachi en 2016 *
					ta HHID_panel if jatis2010=="Vanniyar" & jatis2016=="Padayachi" 
					* Ménages concernés : ELA5 et ORA38 *
						ta jatis2020 if HHID_panel=="ELA5" | HHID_panel=="ORA38"
						* Padayachi également en 2020 *
					replace jatis2010="Padayachi" if HHID_panel=="ELA5" | HHID_panel=="ORA38"
				
			** 2016 et 2020 ** 
			ta jatis2016 jatis2020
			* 3 obs. qui seraient des Asarai en 2016 et des Vanniyar en 2020 *
				ta HHID_panel if jatis2016=="Asarai" & jatis2020=="Vanniyar" 
				* MANAM11 *
				* Comme les Asarai et les Vanniyar sont tous deux des "Middle" caste, cela ne pose pas de pb *
				** MANAM11 : (après vérif auprès de Venkat) je leur associe le jati des Asarai **
				replace jatis2020="Asarai" if HHID_panel=="MANAM11"
			* 4 obs. qui seraient des Gramani en 2016 et des Vanniyar en 2020 *
				ta HHID_panel if jatis2016=="Gramani" & jatis2020=="Vanniyar" 
				* MANAM12 * 
				* Comme les Gramani et les Vanniyar sont tous deux des "Middle" caste, cela ne pose pas de pb *
				** MANAM12 : (après vérif auprès de Venkat) je leur associe le jati des Gramani **
				replace jatis2020="Gramani" if HHID_panel=="MANAM12"
			* 3 obs. qui seraient des Mudaliar en 2016 et des Padayachi en 2020 *
				ta HHID_panel if jatis2016=="Mudaliar" & jatis2020=="Padayachi" 
				* GOV19 qui, selon Venkat, serait Mudaliar *
				replace jatis2020="Mudaliar" if HHID_panel=="GOV19"
			* 3 obs. qui seraient des Mudaliar en 2016 et des Vanniyar en 2020 *
				ta HHID_panel if jatis2016=="Mudaliar" & jatis2020=="Vanniyar" 
				* GOV2 qui, selon Venkat, serait Mudaliar *
				replace jatis2020="Mudaliar" if HHID_panel=="GOV2"
			* 2 obs. qui seraient des Nattar en 2016 et des SC en 2020 *
				ta HHID_panel if jatis2016=="Nattar" & jatis2020=="SC" 
				* MANAM18 qui, selon Venkat, serait SC *
				replace jatis2016="SC" if HHID_panel=="MANAM18"
			* 8 obs. qui seraient des Padayachi en 2016 et des Vanniyar en 2020 *
				ta HHID_panel if jatis2016=="Padayachi" & jatis2020=="Vanniyar" 
				* KUV42 *
				* Comme les Padayachi et les Vanniyar sont tous deux des "Middle" caste, cela ne pose pas de pb *
				** KUV42 : (après vérif auprès de Venkat) je leur associe le jati des Padayachi **
				replace jatis2020="Padayachi" if HHID_panel=="KUV42"
			* 7 obs. qui seraient des Vanniyar en 2016 et des Padayachi en 2020 *
				ta HHID_panel if jatis2016=="Vanniyar" & jatis2020=="Padayachi" 
				* Ménages concernés : ELA16 et KAR30 *
				* Comme les Padayachi et les Vanniyar sont tous deux des "Middle" caste, cela ne pose pas de pb *
				** ELA16 et KAR30 : (après vérif auprès de Venkat) je leur associe le jati des Vanniyar **
				replace jatis2020="Vanniyar" if HHID_panel=="ELA16" | HHID_panel=="KAR30"
				
			** 2010 et 2020 **
			* 2 obs. qui seraient des Other en 2010 et des Vanniyar en 2020 *
				ta HHID_panel if jatis2010=="Other" & jatis2020=="Vanniyar" 
				* ORA37 : (après vérif auprès de Venkat) je leur associe le jati des Vanniyar *
				replace jatis2010="Vanniyar" if HHID_panel=="ORA37"
			* 2 obs. qui seraient des Rediyar en 2010 et des Vanniyar en 2020 *
				ta HHID_panel if jatis2010=="Rediyar" & jatis2020=="Vanniyar" 
				* MANAM40 : (après vérif auprès de Venkat) je leur associe le jati des Rediyar *
				replace jatis2020="Rediyar" if HHID_panel=="MANAM40"
				
			* b- Labels *
			label var jatis2010 "Jatis in 2010"
			label var jatis2016 "Jatis in 2016"
			label var jatis2020 "Jatis in 2020"
			
			* c- Création d'une nouvelle et unique variable relative au jatis *
			g jatis=jatis2010 if only2010==1 | in20101620==1 | in20102016==1 | in20102020==1
			replace jatis=jatis2016 if only2016==1 | in20162020==1
			replace jatis=jatis2020 if only2020==1
			label var jatis "Jatis"
			rename jatis jatis_panel, replace
				
				
		* 2.5.2 Caste *
		codebook caste2010 caste2016 caste2020 
		foreach var of varlist caste2010 caste2016 caste2020  {
		replace `var'="Lower" if `var'=="Dalits"
		}
			* a- Cohérence avec le jati *
			** 2010 ** 
			ta jatis2010 caste2010 
			* Pour les 32 obs. qui sont des musulmans, elles sont répertoriées en tant que "Upper" - à vérifier *
				ta HHID_panel if jatis2010=="Muslims" 
				* Ménages concernés : SEM1 SEM16 SEM26 SEM28 SEM35 SEM40 SEM43 qui, selon Venkat, sont des "Lower" pour les 4 premiers et des "Middle" pour les 3 derniers *
			replace caste2010="Lower" if HHID_panel=="SEM1" | HHID_panel=="SEM16" | HHID_panel=="SEM26" | HHID_panel=="SEM28" 
			replace caste2010="Middle" if HHID_panel=="SEM35" | HHID_panel=="SEM40" | HHID_panel=="SEM43"
			* Pour 9 obs. SC, elles sont répertoriées en tant que "Middle" - à vérifier *
				ta HHID_panel if jatis2010=="SC" & caste2010=="Middle" 
				* Ménages concernés : MAN22 et MANAM28 qui, selon Venkat, sont des "Lower" car SC *
			replace caste2010="Lower" if HHID_panel=="MAN22" | HHID_panel=="MANAM28"
			* Pour 7 obs. Vanniyar, elles sont répertoriées en tant que "Upper" - à vérifier *
				ta HHID_panel if jatis2010=="Vanniyar" & caste2010=="Upper" 
				* MAN18 qui, selon Venkat sont bien des Vanniyar et donc à modifier par "Middle"
			replace caste2010="Middle" if HHID_panel=="MAN18"
			* Pour les 5 obs. Yathavar, elles sont répertoriées en tant que "Middle" - à vérifier *
				ta HHID_panel if jatis2010=="Yathavar" 
				* KAR48 qui, selon Venkat, sont des "Upper" car Yathavar *
			replace caste2010="Upper" if HHID_panel=="KAR48"
			
			label var caste2010 "Caste in 2010"
			
			** 2016 **
			ta jatis2016 caste2016
			* Pour les 37 obs. qui sont des musulmans, elles sont répertoriées en "Middle" - à vérifier *
				ta HHID_panel if jatis2016=="Muslims" 
				* Ménages concernés : SEM1 SEM16 SEM26 SEM28 SEM35 SEM40 SEM43 qui, selon Venkat, sont des "Lower" pour les 4 premiers et des "Middle" pour les 3 derniers *
			replace caste2016="Lower" if HHID_panel=="SEM1" | HHID_panel=="SEM16" | HHID_panel=="SEM26" | HHID_panel=="SEM28" 
			* Pour 11 obs. SC, elles sont répertoriées en tant que "Middle" - à vérifier *
				ta HHID_panel if jatis2016=="SC" & caste2016=="Middle"
				* MANAM18 qui, selon Venkat sont bien des SC et donc "Lower" caste *
			replace caste2016="Lower" if HHID_panel=="MANAM18"
			
			label var caste2016 "Caste in 2016"
			
			** 2020 ** 
			ta jatis2020 caste2020
			* Pour 6 obs. qui sont des Mudaliar, elles sont répertoriées en "Middle" - à vérifier *
				ta HHID_panel if jatis2020=="Mudaliar" & caste2020=="Middle"
				* Ménages concernés : GOV19 et GOV2 qui, selon Venkat, sont bien des Mudaliar et donc "Upper" *
			replace caste2020="Upper" if HHID_panel=="GOV19" | HHID_panel=="GOV2"
			* Pour les 56 obs. qui sont des musulmans, elles sont répertoriées en "Middle" - à vérifier *
				ta HHID_panel if jatis2020=="Muslims" 
				* Ménages concernés : SEM1 SEM16 SEM26 SEM28 SEM35 SEM40 SEM43 qui, selon Venkat, sont des "Lower" pour les 4 premiers et des "Middle" pour les 3 derniers 
				// Mais aussi : SEM54 SEM62 et SEM63 - (après vérification auprès de Venkat) je les laisse en "Middle" *
			replace caste2020="Lower" if HHID_panel=="SEM1" | HHID_panel=="SEM16" | HHID_panel=="SEM26" | HHID_panel=="SEM28" 
			* Pour 3 obs. qui sont des Rediyar, elles sont répertoriées en "Middle" - à vérifier *
				ta HHID_panel if jatis2020=="Rediyar" & caste2020=="Middle"
				* MANAM40 qui, selon Venkat, sont bien des "Rediyar" et donc "Upper" *
			replace caste2020="Upper" if HHID_panel=="MANAM40" & caste2020=="Middle"
			
			label var caste2020 "Caste in 2020"
			
			* b- Cohérence à travers le panel *
			ta caste2010 caste2016
			* O.K *
			ta caste2010 caste2020
			* O.K * 
			ta caste2016 caste2020 
			* O.K * 
				
			* c- Création d'une nouvelle et unique variable relative à la caste *
			g caste=caste2010 if only2010==1 | in20101620==1 | in20102016==1 | in20102020==1
			replace caste=caste2016 if only2016==1 | in20162020==1
			replace caste=caste2020 if only2020==1
			label var caste "Caste"
			rename caste caste_panel, replace
			

** 3. Modifications **
*--------------------*
	* 3.1 Variables *
		* a- Suppression de variables *
		drop agepanel2010 agepanel2016 agepanel2020 livinghome2016 member_new2020 member_left2020 livinghome2020 HHID2010 INDID2010 submissiondate2010 HHID2016 INDID2016 submissiondate2016 lefthomereason2016 HHID2020 INDID2020 submissiondate2020 relationshiptoheadother2020 householdid20202020 reasonlefthome2020 reasonlefthomeother2020 lefthomereason2020 indivpanel_10_16_20 samesex name2010 name2016 name2020 sex2010 sex2016 sex2020 wave2010 wave2016 wave2020 caste2010 caste2016 caste2020 jatis2010 jatis2016 jatis2020
		
		* b- Labelisation des variables restantes *
		label var HHID_panel "Household panel identifier"
		label var INDID_panel "Individual panel identifier"
		label var age2010 "Age declared in 2010"
		label var age2016 "Age declared in 2016"
		label var age2020 "Age declared in 2020"
		label var relationshiptohead2010 "Relationship to head in 2010"
		label var relationshiptohead2016 "Relationship to head in 2016"
		label var relationshiptohead2020 "Relationship to head in 2020"
		label var address2010 "Address in 2010"
		label var villageid2010 "Village name in 2010"
		label var villagearea2010 "Village area in 2010"
		label var address2016 "Address in 2016"
		label var villageid2016 "Village name in 2016"
		label var villagearea2016 "Village area in 2016"
		label var address2020 "Address in 2020"
		label var villageid2020 "Village name in 2020"
		label var villagearea2020 "Village area in 2020"
		label var only2010 "RUME only"
		label var only2016 "NEEMSIS-1 only"
		label var only2020 "NEEMSIS-2 only"
		label var in20102016 "RUME-NEEMSIS-1-NEEMSIS-2"
		label var in20102020 "RUME-NEEMSIS-2"
		label var in20162020 "NEEMSIS-1-NEEMSIS-2"
		label var in20101620 "RUME-NEEMSIS-1"
		label var m_agepanel2010_r "Age in 2010 w/ RUME as reference"
		label var m_agepanel2016_r "Age in 2016 w/ RUME as reference"
		label var m_agepanel2020_r "Age in 2010 w/ RUME as reference"
		label var m_agepanel2010_n "Age in 2010 w/ NEEMSIS as reference"
		label var m_agepanel2016_n "Age in 2016 w/ NEEMSIS as reference"
		label var m_agepanel2020_n "Age in 2020 w/ NEEMSIS as reference"
		label var diffagepanel2010 "Age difference in 2010 between RUME and NEEMSIS as reference"
		label var diffagepanel2016 "Age difference in 2016 between RUME and NEEMSIS as reference"
		label var diffagepanel2020 "Age difference in 2020 between RUME and NEEMSIS as reference"
		
		* c- Réorganisation des variables par vagues *
		order HHID_panel INDID_panel name_panel sex_panel jatis_panel caste_panel only2010 only2016 only2020 in20102016 in20102020 in20162020 in20101620 age2010 m_agepanel2010_r m_agepanel2010_n diffagepanel2010 relationshiptohead2010 address2010 villageid2010 villagearea2010 age2016 m_agepanel2016_r m_agepanel2016_n diffagepanel2016 relationshiptohead2016 address2016 villageid2016 villagearea2016 age2020 m_agepanel2020_r m_agepanel2020_n diffagepanel2020 relationshiptohead2020 address2020 villageid2020 villagearea2020
		
		
** 4. Sauvegardes **
*------------------*
	* 4.1 Base modifiée *
	save "${mod_dta}\AppariementPanel.dta", replace 
		
		
	* 4.2 Panel *
		* 4.2.1 RUME-NEEMSIS *
		preserve 
			keep if in20101620==1
			count 
			* 1783 observations * 
			
			drop only2010 only2016 only2020 in20102016 in20102020 in20162020 in20101620
		
			save "${mod_dta}\AppariementPanel_IndivPanelRUME-NEEMSISUniquement.dta", replace 
		restore 
		
		* 4.2.2 RUME-NEEMSIS1 *
		preserve 
			keep if in20102016==1
			count 
			* 43 observations * 
		
			drop only2010 only2016 only2020 in20102016 in20102020 in20162020 in20101620
	
			save "${mod_dta}\AppariementPanel_IndivPanelRUME-NEEMSIS1Uniquement.dta", replace 
		restore 
		
		* 4.2.3 RUME-NEEMSIS2 *
		preserve 
			keep if in20102020==1
			count 
			* 12 observations * 
		
			drop only2010 only2016 only2020 in20102016 in20102020 in20162020 in20101620
	
			save "${mod_dta}\AppariementPanel_IndivPanelRUME-NEEMSIS2Uniquement.dta", replace 
		restore 
		
		* 4.2.4 NEEMSIS * 
		preserve 
			keep if in20162020==1
			count 
			* 845 observations * 
		
			drop only2010 only2016 only2020 in20102016 in20102020 in20162020 in20101620
	
			save "${mod_dta}\AppariementPanel_IndivPanelNEEMSISUniquement.dta", replace 
		restore 
		
		
	* 4.3 Par vagues *
		* 4.3.1 RUME *
		preserve 
			keep if only2010==1
			count 
			* 90 observations * 
			
			drop only2010 only2016 only2020 in20102016 in20102020 in20162020 in20101620
		
			save "${mod_dta}\AppariementPanel_IndivRUMEUniquement.dta", replace 
		restore 
		
		* 4.3.2 NEEMSIS-1 *
		preserve 
			keep if only2016==1
			count 
			* 25 observations * 
			
			drop only2010 only2016 only2020 in20102016 in20102020 in20162020 in20101620
		
			save "${mod_dta}\AppariementPanel_IndivNEEMSIS1Uniquement.dta", replace 
		restore 
		
		* 4.3.3 NEEMSIS-2 * 
		preserve 
			keep if only2020==1
			count 
			* 1007 observations * 
			
			drop only2010 only2016 only2020 in20102016 in20102020 in20162020 in20101620
		
			save "${mod_dta}\AppariementPanel_IndivNEEMSIS2Uniquement.dta", replace 
		restore
		
	
		

