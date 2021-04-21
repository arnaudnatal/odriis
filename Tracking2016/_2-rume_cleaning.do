*Arnaud Natal
*04 février 2021

clear all
global name "Arnaud"
global directory "C:\Users\\$name\Downloads\track"

cd"$directory"
*use"NEEMSIS-tracking_comp_v3.dta",clear

**********MERGING des bases RUME
use"RUME_familymembers.dta", clear
des
merge m:1 HHID using"RUME_general.dta"
drop _merge
merge m:1 HHID using"RUME_house.dta"
drop _merge
save"RUME-tracking_p1.dta", replace
*********************************************


**********RESHAPE occupation
use"RUME_occupation.dta", clear
des
egen HHINDID=concat(HHID namenumber),p(/)
sort HHINDID
bysort HHINDID: gen occupnb=_n
order HHINDID occupnb
rename occupationname occupationname_
rename kindofwork kindofwork2010_
rename annualincome annualincome_
rename stop_work stoppedworking
reshape wide indiv_involved occupationname_ kindofwork2010_ annualincome_ stoppedworking, i(HHINDID) j(occupnb)
save"RUME-occupation_wide.dta", replace
use"RUME-tracking_p1.dta", clear
egen HHINDID=concat(HHID namenumber), p(/)
tab HHINDID
/*
VENGP165/1 & VENGP165/2
*/
gen namenumber_old=namenumber
sort HHINDID
gen n=_n
br if HHID=="VENGP165"
replace namenumber = "2" if n==1667
replace namenumber = "3" if n==1668
replace namenumber = "4" if n==1669
replace namenumber = "5" if n==1670
replace namenumber = "6" if n==1671
drop n
save"RUME-tracking_p1.dta", replace
list HHID name age namenumber namenumber_old if HHID=="VENGP165", clean
/*
		HHID		name		namenu~r	namenu~d	 
1666.	VENGP165	JAYARAMAN	1			1	 
1667.	VENGP165	SAKTHIVEL	2			1	 
1668.	VENGP165	SUGUNA		3			2	 
1669.	VENGP165	SIVAKAMI	4			2	 
1670.	VENGP165	SIVAKUMAR	5			3	 
1671.	VENGP165	ARUN KUMAR	6			4	 
Je dois aussi remplacer dans la base occupation wide
*/
use"RUME-occupation_wide.dta", clear
gen namenumber_old=namenumber
sort HHINDID
gen n=_n
br if HHID=="VENGP165"
replace namenumber="5" if n==1663
replace namenumber="6" if n==1664
save"RUME-occupation_wide.dta", replace
use"RUME-tracking_p1.dta", clear
merge 1:1 HHID namenumber using"RUME-occupation_wide.dta"
br if _merge==1
drop _merge
drop M
save"RUME-tracking_p1_v2.dta"
*********************************************

**********ELEC, etc.
use"RUME-tracking_p1_v2.dta", clear
rename HHID HHID2010
merge 1:1 HHID name using "Rume.dta", keepusing(food_expenses_week__rs_ education_expenses_year__rs_ health_expenses_year__rs_ ceremonies_expenses_year__rs_ death_expenses_year__rs_ _16_1_a_electricity _16_1_b_water _21__a_goods1 _21__b_nber1 _21__c_year_of_purchase1 _21__d_payment_type1 _21__a_goods10 _21__b_nber10 _21__c_year_of_purchase10 _21__d_payment_type10 _21__a_goods2 _21__b_nber2 _21__c_year_of_purchase2 _21__d_payment_type2 _21__a_goods3 _21__b_nber3 _21__c_year_of_purchase3 _21__d_payment_type3 _21__a_goods4 _21__b_nber4 _21__c_year_of_purchase4 _21__d_payment_type4 _21__a_goods5 _21__b_nber5 _21__c_year_of_purchase5 _21__d_payment_type5 _21__a_goods6 _21__b_nber6 _21__c_year_of_purchase6 _21__d_payment_type6 _21__a_goods7 _21__b_nber7 _21__c_year_of_purchase7 _21__d_payment_type7 _21__a_goods8 _21__b_nber8 _21__c_year_of_purchase8 _21__d_payment_type8 _21__a_goods9 _21__b_nber9 _21__c_year_of_purchase9 _21__d_payment_type9)
drop _merge
rename HHID2010 HHID
merge m:1 HHID using "Base RUME_Main variables", keepusing(land_own_dry land_own_dry-land_lease)
drop _merge
save"RUME-tracking_p1_v3.dta", replace
*********************************************


**********CLEANING
use"RUME-tracking_p1_v3.dta", clear
global pb21 _21__a_goods1 _21__b_nber1 _21__c_year_of_purchase1 _21__d_payment_type1 _21__a_goods10 _21__b_nber10 _21__c_year_of_purchase10 _21__d_payment_type10 _21__a_goods2 _21__b_nber2 _21__c_year_of_purchase2 _21__d_payment_type2 _21__a_goods3 _21__b_nber3 _21__c_year_of_purchase3 _21__d_payment_type3 _21__a_goods4 _21__b_nber4 _21__c_year_of_purchase4 _21__d_payment_type4 _21__a_goods5 _21__b_nber5 _21__c_year_of_purchase5 _21__d_payment_type5 _21__a_goods6 _21__b_nber6 _21__c_year_of_purchase6 _21__d_payment_type6 _21__a_goods7 _21__b_nber7 _21__c_year_of_purchase7 _21__d_payment_type7 _21__a_goods8 _21__b_nber8 _21__c_year_of_purchase8 _21__d_payment_type8 _21__a_goods9 _21__b_nber9 _21__c_year_of_purchase9 _21__d_payment_type9
foreach x in $pb21{
set trace on
local new=substr("`x'",8,strlen("`x'"))
rename `x' `new'
}
rename _16_1_a_electricity electricity
rename _16_1_b_water water
/*
global pb18 _18_1_1_a_land_type1 _18_1_2_a_land_type1 _18_1_b_nber_acres1 _18_1_c_water_from_11 _18_1_c_water_from_21 _18_1_1_a_land_type2 _18_1_2_a_land_type2 _18_1_b_nber_acres2 _18_1_c_water_from_12 _18_1_c_water_from_22 _18_1_1_a_land_type3 _18_1_2_a_land_type3 _18_1_b_nber_acres3 _18_1_c_water_from_13 _18_1_c_water_from_23
foreach x in $pb18{
set trace on
local new=substr("`x'",6,strlen("`x'"))
rename `x' `new'
}
*/
save"RUME-tracking_p1_v4.dta", replace
*********************************************


**********MERGING with migrant HH
use"RUME-tracking_p1_v4.dta", clear
merge m:1 HHID using"NEEMSIS-tracking_HH.dta"
keep if _merge==3
drop _merge
preserve
bysort HHID: gen count=_n
keep if count==1
tab HHID  // ok 67
restore
drop ratio* skill* nuclear
dropmiss, force
sort HHID name
save"RUME-tracking_comp_v1.dta", replace
*********************************************


**********NAME changing
use"RUME-tracking_comp_v1.dta", clear
do "RUME_replace-name"
sort HHID name
/*
preserve 
keep HHID name
gen year=2010
save"RUME-tracking_comp_verifname.dta", replace
restore
*/
save"RUME-tracking_comp_v2.dta", replace
*********************************************

/*
**********Test matching name
use"RUME-tracking_comp_verifname.dta", clear
gen name2010=name
merge 1:1 HHID name using"NEEMSIS-tracking_comp_verifname.dta"
sort HHID name _merge
save"NEEMSIS-RUME-tracking_verifname.dta", replace
*********************************************
*/






**********Test matching name
*Rume creation
use"RUME-tracking_comp_v2.dta", clear
keep HHID name sex relationshiptohead age education
gen year=2010
egen HHINDIDs=concat(HHID name), p(/)
*duplicates list HHINDID
drop HHINDID
gen name2010=name
rename sex sex2010 
rename relationshiptohead relationshiptohead2010
rename age age2010
rename education education2010
rename year year2010
save"RUME-tracking_comp_verifname.dta", replace
*Neemsis creation
use"NEEMSIS-tracking_comp_v3.dta", clear
gen dummymigrant=0
replace dummymigrant=1 if namemigrant==name
keep HHID strange name sex relationshiptohead age classcompleted year dummymigrant
egen HHINDID=concat(HHID name), p(/)
duplicates list
sort HHINDID
gen n=_n
duplicates tag HHID year name sex age relationshiptohead classcompleted HHINDID, gen(tag)
tab tag
list if tag==1
drop if n==9 | n==10 | n==205 | n==206
drop n tag 
drop HHINDID
duplicates list
gen name2019=name
rename sex sex2019
rename relationshiptohead relationshiptohead2019
rename age age2019
rename classcompleted education2019
rename year year2019
tab HHID strange
*Je sors les ménages étranges
drop if strange==1
drop strange
rename dummymigrant mig
save"NEEMSIS-tracking_comp_verifname.dta", replace
*Merging
use"RUME-tracking_comp_verifname.dta", clear
merge 1:1 HHID name using"NEEMSIS-tracking_comp_verifname.dta"
/*
Result					# of obs.			
not matched				406
	from master			274	(_merge==1)
	from using			132	(_merge==2)
matched					73	(_merge==3)
*/
sort HHID name _merge
order HHID name mig name2010 name2019 year2010 year2019 sex2010 sex2019 age2010 age2019 relationshiptohead2010 relationshiptohead2019 education2010 education2019
label define sex2010 1"Male" 2"Female"
label values sex2010 sex2010
label define relationshiptohead2010 1"Head" 2"Wife" 3"Mother" 4"Father" 5"Son" 6"Daughter" 7"Daughter-in-law" 8"Son-in-law" 9"Sister" 10"Mother-in-law" 11"Father-in-law" 12"Brother older" 13"Brother younger" 14"Grand children" 15"Nobody" 66"Irrelevant" 77"Other" 88"DK" 99"NR" 
label values relationshiptohead2010 relationshiptohead2010
label define education2010 1"Primary" 2"High School" 3"HSC" 4"Diploma" 5"Degree" 6"Post graduate" 7"Enginering" 8"Others" 9"No education" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label values education2010 education2010
gen agetest=age2019-age2010
gen agetest2=1 if agetest>7 & agetest<11
replace agetest2=0 if agetest!=. & agetest2==.
tab agetest HHID if agetest2==0
drop agetest agetest2
save"NEEMSIS-RUME-tracking_verifname.dta", replace
export excel using "verifname_v2.xlsx", firstrow(var) replace
*********************************************







**********Rename indiv
use"RUME-tracking_comp_v2.dta", clear
*Suite au merging, il y a des trucs qui ne matchent pas
*car pb deans le nom, donc je change avec les valeurs de 2019
replace name="Suresh babu" if HHID=="ANTMP242" & name=="Sureshbabu"
replace name="Purushoth" if HHID=="ANTMP39" & name=="Purushothaman"
replace name="Vishanthi" if HHID=="ADMPO10" & name=="Vishasanthi"
replace name="Vishadhani" if HHID=="ADMPO10" & name=="Vishathani"
replace name="Vinothkumar" if HHID=="SIKARU255" & name=="Vinodhkumar"
replace name="Vijaya kumar" if HHID=="ANDOR402" & name=="Vijayakumar"
replace name="Vijalakshmi" if HHID=="RASEM85" & name=="Vijayalakshmi"
replace name="Vengadesan" if HHID=="ANTOR400" & name=="Vengadesssan"
replace name="Thamizhmanidass" if HHID=="VENSEM115" & name=="Tamizhmanidass"
replace name="Sudakar" if HHID=="PSMTP313" & name=="Sudagar"
replace name="Sudagar" if HHID=="SIGP187" & name=="Sundhar"
replace name="Siva@sivalingam" if HHID=="ANTMTP319" & name=="Siva"
replace name="Sathyasundaram" if HHID=="ADMPO10" & name=="Sathiya Sundaram"
replace name="Saroja jayaraman" if HHID=="VENOR391" & name=="Saroja Jayaraman"
replace name="Rajeshwari_wife" if HHID=="PSOR387" & name=="Rajeshwari"
replace name="Rajavelu" if HHID=="RASEM85" & name=="Rajavel"
replace name="Raghavan" if HHID=="ANTEP56" & name=="Ragavan"
replace name="Prakash" if HHID=="ANDMTP322" & name=="Pirakash"
replace name="Prakash" if HHID=="ANTMP39" & name=="Pragash"
replace name="Parthiban" if HHID=="SIGP186" & name=="Parthipan"
replace name="Parameswari" if HHID=="SIMTP297" & name=="Parameshwari"
replace name="Manohar" if HHID=="RASEM88" & name=="Manogar"
replace name="Krishanamoorthi" if HHID=="VENMPO32" & name=="Krishnamurthi"
replace name="Kirushnan" if HHID=="PSMPO20" & name=="Krishnan"
replace name="Kavidha" if HHID=="PSMPO20" & name=="Kavitha"
replace name="Karthikeyan" if HHID=="ANTGP236" & name=="Karthik"
replace name="Jeyan" if HHID=="SIKARU255" & name=="Jayan"
replace name="Jayashree" if HHID=="VENOR391" & name=="Jayasri"
replace name="Iyyappan" if HHID=="ANTKARU277" & name=="Iyappan"
replace name="Iyyappan" if HHID=="PSKU131" & name=="Iyappan"
replace name="Iyyapan" if HHID=="ANDKARU288" & name=="Iyappan"
replace name="Iyappan" if HHID=="SIMTP297" & name=="Ayyappan"
replace name="Gowri" if HHID=="VENMTP315" & name=="Cauvery"
replace name="Ezhumalai" if HHID=="PSMPO21" & name=="Eazhumalai"
replace name="Eganayaki" if HHID=="SIEP60" & name=="Eganayagi"
replace name="Channathambi" if HHID=="SIMPO1" & name=="Chinnathambi"
replace name="Barathi" if HHID=="VENGP178" & name=="Bharathi"
replace name="Balaganapathi" if HHID=="ANTGP237" & name=="Balaganabathi"
replace name="Bakiyaraj" if HHID=="ANTMP36" & name=="Bakyaraj"
replace name="Anjaladevi" if HHID=="SIKU154" & name=="Anjalaidevi"
/*
*Verif name
keep HHID name sex relationshiptohead age education
gen year=2010
egen HHINDIDs=concat(HHID name), p(/)
*duplicates list HHINDID
drop HHINDID
gen name2010=name
rename sex sex2010 
rename relationshiptohead relationshiptohead2010
rename age age2010
rename education education2010
rename year year2010
merge 1:1 HHID name using"NEEMSIS-tracking_comp_verifname.dta"
/*
Result					# of obs.
not matched				330
	from master			236	(_merge==1)
	from using			94	(_merge==2)
matched					111	(_merge==3)

*/
*/
gen year=2010
*Rename les var pour que ca colle avec 2010
rename food_expenses_week__rs_ foodexpenses
rename health_expenses_year__rs_ healthexpenses
rename ceremonies_expenses_year__rs_ ceremoniesexpenses
rename education_expenses_year__rs_ educationexpenses
rename death_expenses_year__rs_ deathexpenses
*On ne trouve pas les membres en 2010
gen nomatch_rume_tracking=0
replace nomatch_rume_tracking=1 if HHID=="ANTMTP318"
replace nomatch_rume_tracking=1 if HHID=="PSKOR203"
replace nomatch_rume_tracking=1 if HHID=="RAEP68"

***Recode relationshiptohead
*relation
tab relationshiptohead
gen _rela=.
replace _rela=1 if relationshiptohead==1  // head
replace _rela=2 if relationshiptohead==2  // wife
replace _rela=3 if relationshiptohead==3  // mother
replace _rela=4 if relationshiptohead==4  // father
replace _rela=5 if relationshiptohead==5  // son
replace _rela=6 if relationshiptohead==6  // daughter
replace _rela=8 if relationshiptohead==7  // daughter in law
replace _rela=7 if relationshiptohead==8  // son in law
replace _rela=9 if relationshiptohead==9  // sister
replace _rela=10 if relationshiptohead==13  // brother younger
replace _rela=77 if relationshiptohead==14  // others
replace _rela=77 if relationshiptohead==77  // oth
tab _rela relationshiptohead
rename relationshiptohead relation2010
rename _rela relationshiptohead
drop relation2010
*education
tab education
rename education education2010
*Land
gen dummyownland=1 if land_own>0
replace dummyownland=0 if land_own==0
tab dummyownland
gen sizeownland=land_own
tab sizeownland
drop land_own_dry land_own_wet land_own land_lease
*save"RUME-tracking_comp_v3.dta", replace
*use"RUME-tracking_comp_v3.dta", clear
*Goods
tab goods1
forvalues i=1(1)8{
replace goods`i'=77 if goods`i'==13
replace goods`i'=13 if goods`i'==14
tostring goods`i', replace
replace goods`i'="" if goods`i'=="."
}
tab goods1
egen listgoods=concat(goods1 goods2 goods3 goods4 goods5 goods6 goods7 goods8), p(" ")
tab listgoods
drop goods1 nber1 year_of_purchase1 payment_type1 goods2 nber2 year_of_purchase2 payment_type2 goods3 nber3 year_of_purchase3 payment_type3 goods4 nber4 year_of_purchase4 payment_type4 goods5 nber5 year_of_purchase5 payment_type5 goods6 nber6 year_of_purchase6 payment_type6 goods7 nber7 year_of_purchase7 payment_type7 goods8 nber8 year_of_purchase8 payment_type8
*house
recode howbuyhouse (8=7)
tab housetype
gen _housetype=.
replace _housetype=1 if housetype==1 | housetype==2 | housetype==3 | housetype==4 | housetype==5
replace _housetype=2 if housetype==7
replace _housetype=3 if housetype==6
drop housetype
rename _housetype housetype
tab housetype
drop howbuy2 howbuy3
drop HHINDID
save"RUME-tracking_comp_v3.dta", replace
*********************************************





**********APPEND 
use"NEEMSIS-tracking_comp_v3.dta", clear
tab year
decode householdvillageoriginal, gen(village)
append using "RUME-tracking_comp_v3.dta"
save"Panel-tracking_comp_v1.dta", replace
*********************************************



**********FIRST CLEANING
use"Panel-tracking_comp_v1.dta", clear
/*
Première chose à faire, j'identifie ceux (les HH) qui posent problèmes 
les 4 types Saravanan + les trois qui ne matchent pas entre le tracking et Rume
*/
bysort HHID: egen strange_HH=sum(strange)
bysort HHID: egen nomatch_HH=sum(nomatch_rume_tracking)
replace strange_HH=1 if strange_HH>=1
replace nomatch_HH=1 if nomatch_HH>=1
tab HHID if strange_HH==1
tab HHID if nomatch_HH==1
drop strange nomatch_rume_tracking
gen dropofanalysis=0
replace dropofanalysis=1 if strange_HH==1 | nomatch_HH==1
tab dropofanalysis
tab year
tab age
egen HHINDID=concat(HHID name), p(/)
tab HHINDID
*DIMENSION DU PANEL EN SORTANT LES HH BIZARRES !
bysort HHINDID: gen dim_panel_indiv=_N if dropofanalysis==0
tab dim_panel_indiv year
/*
111 individus en panel
*/
sort HHINDID
*Je peux recoder namemigrant pour simplifier le panel
bysort HHID (namemigrant): replace namemigrant=namemigrant[_N] if dropofanalysis==0
*Idem avec former et new
bysort HHINDID: egen formermb_HH=sum(formermb) if dropofanalysis==0
drop formermb
rename formermb_HH formermb
replace formermb=1 if formermb>=1
order HHID village year name formermb namenumber namenumber_old HHINDID age relationshiptohead formermb namemigrant caste religion currentlyatschool geolocationlatitude geolocationlongitude geolocationaltitude geolocationaccuracy interviewplacemig username householdvillageoriginal householdidoriginal migrationplacename migrationareatype migrationareaurban migrationarearural migrationaddress sharedhhmig householdmigrantslist othermemberhhmig migrationremark numfamily dummyownland sizeownland landpurchased landpurchasedacres landpurchasedamount landpurchasedhowbuy foodexpenses healthexpenses ceremoniesexpenses ceremoniesrelativesexpenses deathexpenses listgoods house rentalhouse housevalue housetype housesize housetitle ownotherhouse otherhouserent otherhousevalue electricity water toiletfacility noowntoilet schemeslist occupationnumber_1 occupationname_1 kindofwork_1 monthsayear_1 daysamonth_1 hoursaday_1 annualincome_1 hoursayear_1 joblocation_1 reasonnotworkpastyear occupationnumber_2 occupationname_2 kindofwork_2 monthsayear_2 daysamonth_2 hoursaday_2 annualincome_2 hoursayear_2 joblocation_2, first
save"Panel-tracking_comp_v2.dta", replace
*********************************************



**********EGO
use"Panel-tracking_comp_v2.dta", clear
*Dummy ego
drop dummyego
sort HHID migsatisfaction
gen dummyego=1 if ab1!=. & year==2019 & dropofanalysis==0
replace dummyego=0 if ab1==. & year==2019 & dropofanalysis==0
tab dummyego year  // ok
*Gen ego1
gen ego1=1 if dummyego==1 & name==namemigrant & dropofanalysis==0
*Desc
tab relationshiptohead if dummyego==1 & ego1==.
/*
            ead |      Freq.     Percent        Cum.
----------------+-----------------------------------
           Head |          1        2.86        2.86
            Son |          8       22.86       25.71
Daughter-in-law |         19       54.29       80.00
     Grandchild |          7       20.00      100.00
----------------+-----------------------------------
          Total |         35      100.00
*/
tabstat age if dummyego==1 & ego1==. & dropofanalysis==0, stat(n mean sd p50) 
/*
    variable |         N      mean        sd       p50
-------------+----------------------------------------
         age |        35  30.02857  11.08387        32
*/
tab sex if dummyego==1 & ego1==. & dropofanalysis==0
/*
        sex |      Freq.     Percent        Cum.
------------+-----------------------------------
       Male |         11       31.43       31.43
     Female |         24       68.57      100.00
------------+-----------------------------------
      Total |         35      100.00
*/
tab dummyego dim_panel_indiv if dropofanalysis==0
/*
Sur les 95 égo, il y en a 4 qui sont là que en 2019, 91 en panel
*/
*Dumy ego en panel
bysort HHINDID: egen _dum=sum(dummyego) if dropofanalysis==0
replace _dum=1 if _dum>=1 & dropofanalysis==0
drop dummyego
rename _dum dummyego
tab dummyego year if dim_panel_indiv==2 & dropofanalysis==0
/*
  dummyego |      2010       2019 |     Total
-----------+----------------------+----------
         0 |        20         20 |        40 
         1 |        91         91 |       182 
-----------+----------------------+----------
     Total |       111        111 |       222 
*/
*Verif
sort HHINDID
gen dummyego_corr=dummyego
replace dummyego_corr=0 if dummyego==1 & age<=11 & dropofanalysis==0
tab age if dummyego_corr==1 & dropofanalysis==0
list HHINDID if dummyego_corr==1 & age<=15, clean
/*
                      HHINDID  
141.   ANTGP237/Balaganapathi  
411.        SIGP186/Parthiban  
*/
*Verif des doublons
/*
preserve
keep if dummyego_corr==1
duplicates tag HHID enjoypeople curious organized managestress interestedbyart tryhard workwithother makeplans sharefeelings nervous stickwithgoals repetitivetasks shywithpeople workhard changemood understandotherfeeling inventive enthusiastic feeldepressed appointmentontime trustingofother goaftergoal easilyupset talktomanypeople liketothink finishwhatbegin putoffduties rudetoother finishtasks toleratefaults worryalot easilydistracted keepworking completeduties talkative newideas staycalm forgiveother activeimagination expressingthoughts helpfulwithothers, gen(tag_perso)
duplicates tag HHID canreadcard1a canreadcard1b canreadcard1c canreadcard2 numeracy1 numeracy2 numeracy3 numeracy4, gen(tag_cog)
duplicates tag HHID a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 ab1 ab2 ab3 ab4 ab5 ab6 ab7 ab8 ab9 ab10 ab11 ab12 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12, gen(tag_raven)
tab tag_perso
tab tag_cog 
list HHID name age tag_cog dropofanalysis if tag_cog==1 | tag_cog==2, clean
tab tag_raven  
list HHID name age tag_raven dropofanalysis if tag_raven==1, clean
restore
*/
save"Panel-tracking_comp_v3.dta", replace
*********************************************




**********PANEL CLEAN
use"Panel-tracking_comp_v3.dta", replace
drop if dropofanalysis==1
keep if dim_panel_indiv==2
tab HHINDID
tab dummyego dummyego_corr
global perso enjoypeople curious organized managestress interestedbyart tryhard workwithother makeplans sharefeelings nervous stickwithgoals repetitivetasks shywithpeople workhard changemood understandotherfeeling inventive enthusiastic feeldepressed appointmentontime trustingofother goaftergoal easilyupset talktomanypeople liketothink finishwhatbegin putoffduties rudetoother finishtasks toleratefaults worryalot easilydistracted keepworking completeduties talkative newideas staycalm forgiveother activeimagination expressingthoughts helpfulwithothers canreadcard1a canreadcard1b canreadcard1c canreadcard2 numeracy1 numeracy2 numeracy3 numeracy4 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 ab1 ab2 ab3 ab4 ab5 ab6 ab7 ab8 ab9 ab10 ab11 ab12 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12
foreach x in $perso{
replace `x'=. if dummyego_corr==0
}
drop dummyego
rename dummyego_corr dummyego
keep if dummyego==1
drop dummyego
sort HHID name year
tab year
save"Panel-tracking_comp_v1_clean.dta", replace
*********************************************
