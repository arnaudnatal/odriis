cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
February 23, 2021
-----
OCCUPATION, CASTE, ETC
-----

-------------------------
*/






****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
cd "$directory\CLEAN"

********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

****************************************
* END






****************************************
* 2010 2016 DATA PRELOAD for sex, etc.
****************************************
use"NEEMSIS2-HH_v7.dta", clear

tab name, m
/*
Attention, l'individu GOV43 --> 6 est bizarre
il apparait dans la base lefthome sans prénom (enfin avec "...") en tant que 2 qui part
pour work 
je le drop de la base
je drop aussi les 2 mariages que je ne peux pas identifier
Tout comme les bases agri
Donc je drop 5 obs
*/
drop if name==""

rename INDID INDID2020
tostring INDID2020, replace

preserve
keep HHID_panel INDID2020 name ego livinghome sex age relationshiptohead maritalstatus version_HH relationshiptoheadother
gen year=2020
save"indiv2020_temp", replace
restore


*******
******
*****
****
***
**
*


merge 1:m HHID_panel INDID2020 using "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\Individual_panel\code_indiv_2010_2016_2020_wide", keepusing(age2016 sex2016 age2010 sex2010 INDID_panel)
drop if _merge==2
drop _merge

destring sex, replace
label values sex sex
destring age, replace
tab sex
tab age
replace sex=sex2016 if sex==.
tab sex
replace age=age2016+4 if age==.
replace age=age2010+10 if age==.
sort HHID_panel age
destring agefromearlier1, replace
replace age=agefromearlier1 if age==.
tab age

order HHID_panel INDID_panel INDID2020 sex  age 

sort HHID_panel INDID_panel

drop ego1INDID ego2INDID ego3INDID
drop lefthousehold1 lefthousehold2 lefthousehold3 lefthousehold4 lefthousehold5 lefthousehold6 lefthousehold7 lefthousehold8 lefthousehold9 
rename lefthousehold_ dummylefthousehold

drop newmembernb newmember newmember1 newmember2 newmember3 newmember4 newmember5 newmember6 newmember7 newmember8 name_newmember

drop formermember1 formermember2 formermember3 formermember4 formermember5 formermember6 formermember7 formermember8 formermember9 formermember10 formermember11 formermember12
drop formermember formermember_
drop tot_HH


save"NEEMSIS2-HH_v8.dta", replace
****************************************
* END
















****************************************
* SEX CASTE EDUCATION
****************************************
use"NEEMSIS2-HH_v8.dta", clear

merge m:1 HHID_panel using "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\Individual_panel\code_HH", keepusing(jatis2010 jatis2016)
drop if _merge==2
drop _merge

merge 1:1 HHID_panel INDID_panel using "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\Individual_panel\educ2016"
drop if _merge==2
drop _merge

********** HOW MUCH PRESENT ON NEEMSIS2 survey?
gen respondent2020=.
replace respondent2020=0 if INDID_left!=.
replace respondent2020=1 if INDID_left==.
tab respondent2020, m
tab livinghome respondent2020, m
rename respondent2020 dummy_respondent2020


********** Caste
tab caste
destring castepreload2016, replace
tab castepreload2016
tab jatis2010 jatis2016

replace caste=castepreload2016 if caste==. & castepreload2016!=.
tab caste

gen caste_group=.
foreach x in 2 3{
replace caste_group=1 if caste==`x'
}
foreach x in 1 5 7 8 10 12 15 16{
replace caste_group=2 if caste==`x'
}
foreach x in 4 6 11 13 17{
replace caste_group=3 if caste==`x'
}
label define castecat 1"Dalits" 2"Middle" 3"Upper", replace
label values caste_group castecat
tab caste_group
label list
label values caste caste
rename caste jatis

order parent_key HHID_panel HHID2010 householdid2020 villageid villagearea jatis caste_group , first
rename caste_group caste

drop jatis2010 jatis2016



********** Egoid
rename ego egoid


********** Name
tab name
sort name
sort householdid2020
list marriedid name marriedname marriagesomeoneelse namefrompreload HHID2010 if marriedname!="",clean
replace name=namefrompreload if name=="" & namefrompreload!=""
tab name if dummy_respondent2020==1
tab name



********** Education
foreach x in canread everattendedschool classcompleted after10thstandard durationafter10th typeofhigheredu subjectsafter10th currentlyatschool educationexpenses amountschoolfees bookscost transportcost   dummyscholarship scholarshipamount scholarshipduration converseinenglish{
replace `x'=`x'2016 if `x'==. & `x'2016!=.
}

foreach x in othersubjectsafter10th otherreasondroppingschool reasonneverattendedschool reasondropping {
replace `x'=`x'2016 if `x'=="" & `x'2016!=""
}

gen edulevel=.
replace edulevel = 0 if  everattendedschool == 0
replace edulevel = 0 if classcompleted < 5 & classcompleted != .
replace edulevel= 1 if classcompleted>=5 & classcompleted != .
replace edulevel= 2 if classcompleted>=8 & classcompleted != .
replace edulevel= 3 if classcompleted>=11 & classcompleted != .
replace edulevel= 4 if classcompleted>=15  & classcompleted != .
replace edulevel= 5 if classcompleted>=16  & classcompleted != . //Attention! I recoded here cause otherwise all missing are in 5 (Anne, 20/06/17)
label define edulevel 0 "Below primary" 1 "Primary completed", modify
label define edulevel 2 "High school (8th-10th)", modify
label define edulevel 3 "HSC/Diploma (11th-12th)", modify
label define edulevel 4 "Bachelors (13th-15th)", modify
label define edulevel 5 "Post graduate (15th and more)", modify
label values edulevel edulevel
tab edulevel if dummy_respondent2020==1
tab age if edulevel==.
replace edulevel=0 if edulevel==. & age<4
tab edulevel livinghome, m

list HHID_panel INDID_panel	name age version_HH if livinghome==1 & edulevel==., clean noobs
/*
    HHID_p~l   INDID~el            name   age           version_HH  
       MAN52        In7      Masilamani    68       NEEMSIS2_APRIL  
        MAN9        In4      Pavunambal    65       NEEMSIS2_APRIL  
       KUV38        In5     Machagandhi    77       NEEMSIS2_APRIL  
       NAT49        In6       Vadivelan    33       NEEMSIS2_APRIL  
       GOV13        In1      Anbazhagan    50       NEEMSIS2_APRIL  
       GOV38        In5        Keerthas     4   NEEMSIS2_NEW_APRIL  
       GOV50        In2     Arunachalam    67       NEEMSIS2_APRIL  
       GOV50        In3   Bhuvaneshwari    62       NEEMSIS2_APRIL  
       ELA21        In4     Krishnaveni    65       NEEMSIS2_APRIL  
       ELA21        In3        Munisamy    71       NEEMSIS2_APRIL  
       ELA36        In5      Loganathan    56       NEEMSIS2_APRIL  
       ELA31        In9   Pazhaniyammal    75       NEEMSIS2_APRIL  
       ELA52        In5            Rasu    69       NEEMSIS2_APRIL  
*/

drop sex2010 age2010 HHID2010 dummyeverland2010 dummyHHlost2016
drop canread2016 everattendedschool2016 classcompleted2016 after10thstandard2016 durationafter10th2016 typeofhigheredu2016 subjectsafter10th2016 othersubjectsafter10th2016 currentlyatschool2016 educationexpenses2016 amountschoolfees2016 bookscost2016 transportcost2016 reasonneverattendedschool2016 reasondropping2016 otherreasondroppingschool2016 dummyscholarship2016 scholarshipamount2016 scholarshipduration2016 converseinenglish2016 age2016 sex2016





********** Encode version
tab version_HH
tab version_agri

rename version_HH _version_HH
gen version_HH=.
replace version_HH=1 if _version_HH=="NEEMSIS2_LAST"
replace version_HH=2 if _version_HH=="NEEMSIS2_DEC"
replace version_HH=3 if _version_HH=="NEEMSIS2_DECEMBER"
replace version_HH=4 if _version_HH=="NEEMSIS2_FEB"
replace version_HH=5 if _version_HH=="NEEMSIS2_FEBRUARY"
replace version_HH=6 if _version_HH=="NEEMSIS2_APRIL"
replace version_HH=7 if _version_HH=="NEEMSIS2_NEW_APRIL"
label define version_HH 1"LAST" 2"DEC" 3"DECEMBER" 4"FEB" 5"FEBRUARY" 6"APRIL" 7"NEW_APRIL", replace
label values version_HH version_HH
drop _version_HH

rename version_agri _version_agri
gen version_agri=.
replace version_agri=1 if _version_agri=="NEEMSIS2_Agriculture"
replace version_agri=2 if _version_agri=="NEEMSIS2_DEC_Agriculture"
replace version_agri=3 if _version_agri=="NEEMSIS2_DECEMBER_Agriculture"
replace version_agri=4 if _version_agri=="NEEMSIS2_FEBRUARY_Agriculture"
replace version_agri=5 if _version_agri=="NEEMSIS2_FEB_NEW_Agriculture"
label define version_agri 1"Agriculture" 2"DEC_Agriculture" 3"DECEMBER_Agriculture" 4"FEBRUARY_Agriculture" 5"FEB_NEW_Agriculture", replace
label values version_agri version_agri
drop _version_agri



********** Year
gen year=2020



save"NEEMSIS2-HH_v9.dta", replace
****************************************
* END





















****************************************
* Assets
****************************************
use"NEEMSIS2-HH_v9.dta", clear

**********Equipment
fre equipmentlist
fre equipmentname1 equipmentname2 equipmentname4
foreach x in equipmentname equipmentnb equipmentcost equipmentpledged {
rename `x'1 `x'_tractor
rename `x'2 `x'_bullockcart
capture confirm v `x'3
if _rc==0{
rename `x'3 `x'_harvester
}
rename `x'4 `x'_plowingmach
capture confirm v `x'5
if _rc==0{
rename `x'5 `x'_none
}
}

foreach x in equipmentlist_ equipmentborrowedlist_ covsellequipment_{
rename `x'1 `x'tractor
rename `x'2 `x'bullockcar
rename `x'3 `x'harvester
rename `x'4 `x'plowingmac
rename `x'5 `x'none
}


**********Gold
tab goldquantity
replace goldquantity=25 if goldquantity==120000  //120 000 / 4800 = 25

gen goldquantityamount=goldquantity*4800
bysort HHID_panel : egen goldquantityamount2=max(goldquantityamount)
drop goldquantityamount
rename goldquantityamount2 goldquantityamount
recode goldquantityamount (.=0)

**********Land
tab drywetownland

replace sizedryownland=sizeownland if drywetownland=="1" & sizedryownland==. & sizeownland!=.
replace sizewetownland=sizeownland if drywetownland=="2" & sizewetownland==. & sizeownland!=.

fre villageid
gen amountownlanddry=.
replace amountownlanddry=sizedryownland*900000 if villageid==3 | villageid==9 | villageid==6
replace amountownlanddry=sizedryownland*1000000 if villageid==10 | villageid==7 | villageid==1 | villageid==8
replace amountownlanddry=sizedryownland*800000 if villageid==4 | villageid==5 | villageid==2

gen amountownlandwet=.
replace amountownlandwet=sizewetownland*1600000 if villageid==3 | villageid==9 | villageid==6
replace amountownlandwet=sizewetownland*1500000 if villageid==10 | villageid==7 | villageid==1 | villageid==8
replace amountownlandwet=sizewetownland*1200000 if villageid==4 | villageid==5 | villageid==2


gen amountownland=amountownlanddry+amountownlandwet
*if both half
replace amountownland=sizeownland*1250000 if drywetownland=="1 2" & sizedryownland==. & sizewetownland==. & (villageid==3 | villageid==9 | villageid==6)
replace amountownland=sizeownland*1250000 if drywetownland=="1 2" & sizedryownland==. & sizewetownland==. & (villageid==10 | villageid==7 | villageid==1 | villageid==8)
replace amountownland=sizeownland*1000000 if drywetownland=="1 2" & sizedryownland==. & sizewetownland==. & (villageid==4 | villageid==5 | villageid==2)



**********Livestock
fre livestockname*
foreach x in livestockname livestocknb livestockprice livestockuse {
rename `x'1 `x'_cow
rename `x'2 `x'_goat
rename `x'3 `x'_chicken
rename `x'4 `x'_bullock
rename `x'5 `x'_bullforploughing
}

foreach x in covselllivestock_{
rename `x'1 `x'cow
rename `x'2 `x'goat
rename `x'3 `x'chicken
rename `x'4 `x'bullock
rename `x'5 `x'bullforploughin
rename `x'6 `x'none
}


drop livestocklist_1 livestocklist_2 livestocklist_3 livestocklist_4 livestocklist_5 livestocklist_6
drop livestockname_*

foreach x in cow goat chicken bullock bullforploughing {
clonevar livestockamount_`x'=livestockprice_`x'
recode livestockamount_`x' (.=0)
}


**********Good total amount
fre goodname*
foreach x in goodname numbergoods goodyearpurchased goodtotalamount goodbuying goodsourcecredit goodcreditsettled {
rename `x'1 `x'_car
rename `x'2 `x'_bike
rename `x'3 `x'_fridge
rename `x'4 `x'_furniture
rename `x'5 `x'_tailormach
rename `x'6 `x'_phone
rename `x'7 `x'_landline
capture confirm v `x'8
if _rc==0{
rename `x'8 `x'_DVD
}
capture confirm v `x'9
if _rc==0{
rename `x'9 `x'_camera
}
rename `x'10 `x'_cookgas
rename `x'11 `x'_computer
rename `x'12 `x'_antenna
}

*covid19
foreach x in covsellgoods_{
rename `x'1 `x'car
rename `x'2 `x'bike
rename `x'3 `x'fridge
rename `x'4 `x'furniture
rename `x'5 `x'tailormach
rename `x'6 `x'phone
rename `x'7 `x'landline
rename `x'8 `x'DVD
rename `x'9 `x'camera
rename `x'10 `x'cookgas
rename `x'11 `x'computer
rename `x'12 `x'antenna
rename `x'13 `x'none
rename `x'77 `x'other
}

/*
****Cleaning for goods
*Car
replace numbergoods_car=1 if othergood=="Auto"
replace goodtotalamount_car=100000  if othergood=="Auto"

replace numbergoods_car=1 if othergood=="407 lorry"
replace goodtotalamount_car=100000  if othergood=="407 lorry"

replace numbergoods_car=1 if othergood=="TATA a/c vehicle"
replace goodtotalamount_car=100000 if othergood=="TATA a/c vehicle"

replace numbergoods_car=1 if othergood=="Tata ace vehicle"
replace goodtotalamount_car=100000  if othergood=="Tata ace vehicle"

replace numbergoods_car=1 if othergood=="Television, Auto"
replace goodtotalamount_car=100000 if othergood=="Television, Auto"

replace numbergoods_car=1 if othergood=="Tractor"
replace goodtotalamount_car=100000 if othergood=="Tractor"

replace numbergoods_car=1 if othergood=="Van"
replace goodtotalamount_car=100000 if othergood=="Van"

replace numbergoods_car=1 if strpos(othergood,"Fan, mixey, grinder, auto")
replace goodtotalamount_car=100000  if strpos(othergood,"Fan, mixey, grinder, auto")

replace numbergoods_car=1 if strpos(othergood,"Tv,mixey, grinder, fan,Ac, tractor,")
replace goodtotalamount_car=100000 if strpos(othergood,"Tv,mixey, grinder, fan,Ac, tractor,")

*Bike
*br if strpos(othergood, "Three wheeler scooty for his disable")
replace numbergoods_bike=1 if strpos(othergood,"Three wheeler scooty for his disable")

*We create tv
gen numbergoods_TV=0
replace numbergoods_TV=1 if strpos(othergood,"Television")
replace numbergoods_TV=1 if strpos(othergood,"television")
replace numbergoods_TV=1 if strpos(othergood,"TV")
replace numbergoods_TV=1 if strpos(othergood,"Tv")
replace numbergoods_TV=1 if strpos(othergood,"tv")

gen goodtotalamount_TV=.
replace goodtotalamount_TV=numbergoods_TV*1000


egen goodtotalamount=rowtotal(goodtotalamount_car goodtotalamount_cookgas goodtotalamount_computer goodtotalamount_antenna goodtotalamount_bike goodtotalamount_fridge goodtotalamount_furniture goodtotalamount_tailormach goodtotalamount_phone goodtotalamount_landline goodtotalamount_DVD goodtotalamount_camera goodtotalamount_TV)
recode goodtotalamount (.=0)
*/
*goodtotalamount
gen goodtotalamount_DVD=0
gen goodtotalamount_camera=0


egen goodtotalamount2=rowtotal(goodtotalamount_car goodtotalamount_cookgas goodtotalamount_computer goodtotalamount_antenna goodtotalamount_bike goodtotalamount_fridge goodtotalamount_furniture goodtotalamount_tailormach goodtotalamount_phone goodtotalamount_landline goodtotalamount_DVD goodtotalamount_camera)
recode goodtotalamount2 (.=0)


**********ASSETS
egen assets=rowtotal(amountownland livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock livestockamount_bullforploughing housevalue goldquantityamount goodtotalamount2)
egen assets_noland=rowtotal(livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock housevalue goldquantityamount goodtotalamount2)


save"NEEMSIS2-HH_v10.dta", replace
****************************************
* END











****************************************
* Cognition
****************************************
use"NEEMSIS2-HH_v10.dta", clear

***Raven
*right answers
gen set_a1=4
gen set_a2=5
gen set_a3=1
gen set_a4=2
gen set_a5=6
gen set_a6=3
gen set_a7=6
gen set_a8=2
gen set_a9=1
gen set_a10=3
gen set_a11=4
gen set_a12=5

gen set_ab1=4
gen set_ab2=5
gen set_ab3=1
gen set_ab4=6
gen set_ab5=2
gen set_ab6=1
gen set_ab7=3
gen set_ab8=4
gen set_ab9=6
gen set_ab10=3
gen set_ab11=5
gen set_ab12=2

gen set_b1=2
gen set_b2=6
gen set_b3=1
gen set_b4=2
gen set_b5=1
gen set_b6=3
gen set_b7=5
gen set_b8=6
gen set_b9=4
gen set_b10=3
gen set_b11=4
gen set_b12=5

*Number of correct answers
forval i=1(1)12 {
gen ra`i'=0 	if a`i' !=.
gen rab`i'=0 	if ab`i' !=.
gen rb`i'=0 	if b`i' !=.
}
forval i=1(1)12 {
replace ra`i'=1  if a`i'==set_a`i' 	
replace rab`i'=1 if ab`i'==set_ab`i' 
replace rb`i'=1  if b`i'==set_b`i' 
}	
drop set_a1-set_a12
drop set_ab1-set_ab12
drop set_b1-set_b12

*Total score 
egen set_a = rowtotal (ra1 ra2 ra3 ra4 ra5 ra6 ra7 ra8 ra9 ra10 ra11 ra12), missing
egen set_ab = rowtotal (rab1 rab2 rab3 rab4 rab5 rab6 rab7 rab8 rab9 rab10 rab11 rab12), missing 
egen set_b = rowtotal (rb1 rb2 rb3 rb4 rb5 rb6 rb7 rb8 rb9 rb10 rb11 rb12), missing
egen raven_tt = rowtotal (set_a set_b set_ab)
tab1 set_a set_ab set_b raven_tt


*********Numeracy & literacy
global literacy canreadcard1a canreadcard1b canreadcard1c canreadcard2
global numeracy numeracy1 numeracy2 numeracy3 numeracy4 numeracy5 numeracy6
global cog $literacy $numeracy

*composite score
*recode no response as missing for easier analysis
foreach x of varlist $cog {
recode `x' (99=.) 
}
foreach x of varlist $numeracy {
recode `x' (2=0)
}
foreach x of varlist $literacy {
recode `x' (1=0) (3=1) (2=0.5) 
}
**Look at missing values 	
mdesc $cog

mdesc $literacy if canreadcard1a==. //those are mostly the same people 
tab edulevel if canreadcard1a==. //code as can't read if edulevel max primary completed 
gen refuse=0
replace refuse=1 if (canreadcard1a+canreadcard1b+canreadcard1c+canreadcard2==.)
recode $literacy (.=0) if edulevel<=1

mdesc numeracy6 numeracy5 numeracy4 numeracy3 numeracy2 if numeracy1==. 
tab edulevel if numeracy1==. 
replace refuse=1 if (numeracy1+numeracy2+numeracy3+numeracy4+numeracy5+numeracy6==.)

recode numeracy6 numeracy5 numeracy4 numeracy3 numeracy2 numeracy1 (.=0) if edulevel<=1	

egen num_tt = rowtotal(numeracy1 numeracy2 numeracy3 numeracy4 numeracy5 numeracy6), missing 
egen lit_tt = rowtotal(canreadcard1a canreadcard1b canreadcard1c canreadcard2), missing 


save"NEEMSIS2-HH_v11.dta", replace
****************************************
* END













****************************************
* Big-5
****************************************

use"NEEMSIS2-HH_v11.dta", clear

*use"NEEMSIS2-HH_v5.dta", clear
*drop if ego==0
*ta ego
*ta version

merge 1:1 HHID_panel INDID_panel using "D:\Documents\_Thesis\_DATA\ego2016"
keep if _merge==3


*Macro
global big5 ///
curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts  ///
workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers ///
managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm ///
tryhard  stickwithgoals   goaftergoal finishwhatbegin finishtasks  keepworking

global locus locuscontrol1 locuscontrol2 locuscontrol3 locuscontrol4 locuscontrol5 locuscontrol6 

fre $big5
*At baseline



********** Recode 1
foreach x in $big5 {
clonevar `x'_old=`x'
replace `x'=. if `x'==99 | `x'==6
}
fre completeduties putoffduties
/*
completeduties_old putoffduties_old = max never, with 99 as cat
completeduties putoffduties = max never, with 99 recoded as missing
*/


********* Omega
omega curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination, rev(repetitivetasks) // .7642

omega organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties, rev(putoffduties easilydistracted)  // .7040

omega enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts, rev(shywithpeople)  // .6511

omega workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers, rev(rudetoother)  // .6126

omega managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm, rev(managestress staycalm)  // .7295





********** Recode 2: all so that more is better! 
foreach var of varlist $big5 {
clonevar raw_`var'=`var' 
clonevar raw_rec_`var'=`var' 	
recode `var' (5=1) (4=2) (3=3) (2=4) (1=5)
recode raw_rec_`var' (5=1) (4=2) (3=3) (2=4) (1=5)
}
label define big5n 1"5 - Almost never" 2"4 - Rarely" 3"3 - Sometimes" 4"2 - Quite often" 5"1 - Almost always"
foreach x in $big5 {
label values `x' big5n
label values raw_rec_`x' big5n
}
/*
completeduties_old putoffduties_old = max never, with 99 as cat
raw_completeduties raw_putoffduties = max never, with 99 recoded as missing
raw_rec_completeduties raw_rec_putoffduties = max always, with 99 recoded as missing
completeduties putoffduties = max always, with 99 recoded as missing
*/






********** Correction du biais d'"acquiescence"
*Paires
local varlist ///
rudetoother helpfulwit~s  ///
putoffduties 	completedut~s /// 
easilydistracted makeplans  ///
shywithpeople talktomany~e ///
repetitive~s curious  ///
nervous staycalm ///  
worryalot managestress 
*moyenne des paires pour savoir si ils sont loin de 3, si oui alors biais
egen ars=rowmean(`varlist') 
tabstat ars, stat(n mean sd q min max)
ttest ars==3
tab ars
gen ars2=ars-3  
set graph on
gen ars3=abs(ars2)
pctile ars3_p=ars3, n(20)
gen n=_n*5
replace n=. if n>100
tab ars3
drop ars3_p n
*histogram ars3, width(0.05) percent xtitle("Acquiesence bias") xlabel(0(0.5)2) xmtick(0(0.1)2) ylabel(0(1)14) ymtick(0(0.2)14) note("NEEMSIS-2 (2020-21)", size(small))
*graph export "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\ars2_NEEMSIS2.pdf", replace




********** Recode 3: reversely coded items 
foreach var of varlist rudetoother putoffduties easilydistracted shywithpeople repetitive~s nervous changemood feeldepressed easilyupset worryalot {
recode `var' (5=1) (4=2) (3=3) (2=4) (1=5)
}
label define big5n2 5"5 - Almost never" 4"4 - Rarely" 3"3 - Sometimes" 2"2 - Quite often" 1"1 - Almost always"
foreach x in rudetoother putoffduties easilydistracted shywithpeople repetitive~s nervous changemood feeldepressed easilyupset worryalot {
label values `x' big5n2
}
*corrected items: 
foreach var of varlist $big5 {
gen cr_`var'=`var'-ars2 if ars!=. 
}
/*
completeduties_old putoffduties_old = max never, with 99 as cat
raw_completeduties raw_putoffduties = max never, with 99 recoded as missing
raw_rec_completeduties raw_rec_putoffduties = max always, with 99 recoded as missing

cr_completeduties cr_putoffduties = max always, with 99 recoded as missing and reverse questions recoded for Big-5 corrected from acquiescence bias

completeduties putoffduties = max always, with 99 recoded as missing and reverse questions recoded for Big-5
*/


********** Internal consistency v2

*OP
omega curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination, rev(repetitivetasks) // .7642
alpha curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination // .7624

omega cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination, rev(cr_repetitivetasks) // .3684
alpha cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination // .3189


*CO
omega organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties, rev(putoffduties easilydistracted)  // .7040
alpha organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties  // .7015

omega cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties, rev(cr_putoffduties cr_easilydistracted)  // .4171
alpha cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties  // .4723


*EX
omega enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts, rev(shywithpeople)  // .6511
alpha enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts  // .6511

omega cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts, rev(cr_shywithpeople)  // .4486

alpha cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts  // .4480


*AG
omega workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers, rev(rudetoother)  // .6126
alpha workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers  // .5437

omega cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers, rev(cr_rudetoother)  // .3076
alpha cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers  // .2834

*ES
omega managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm, rev(managestress staycalm)  // .7295
alpha managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm  // .7312

omega cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot  cr_staycalm, rev(cr_managestress cr_staycalm)  // .7929
alpha cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot  cr_staycalm  // .7939






********** Rename
global big5 ///
curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts  ///
workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers ///
managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm ///
tryhard  stickwithgoals   goaftergoal finishwhatbegin finishtasks  keepworking

foreach x in $big5 {
rename raw_rec_`x' rr_`x'
}
/*
completeduties_old putoffduties_old = max never, with 99 as cat
raw_completeduties raw_putoffduties = max never, with 99 recoded as missing
rr_completeduties rr_putoffduties = max always, with 99 recoded as missing

cr_completeduties cr_putoffduties = max always, with 99 recoded as missing and reverse questions recoded for Big-5 corrected from acquiescence bias

completeduties putoffduties = max always, with 99 recoded as missing and reverse questions recoded for Big-5
*/




********** Recode 4: from max=NE to max=ES
foreach x in rr_managestress rr_nervous rr_changemood rr_feeldepressed rr_easilyupset rr_worryalot rr_staycalm {
recode `x' (5=1) (4=2) (3=3) (2=4) (1=5)
}





********** Imputation
global big5rr rr_curious rr_interestedbyart rr_repetitivetasks rr_inventive rr_liketothink rr_newideas rr_activeimagination rr_organized rr_makeplans rr_workhard rr_appointmentontime rr_putoffduties rr_easilydistracted rr_completeduties rr_enjoypeople rr_sharefeelings rr_shywithpeople rr_enthusiastic rr_talktomanypeople rr_talkative rr_expressingthoughts rr_workwithother rr_understandotherfeeling rr_trustingofother rr_rudetoother rr_toleratefaults rr_forgiveother rr_helpfulwithothers rr_managestress rr_nervous rr_changemood rr_feeldepressed rr_easilyupset rr_worryalot rr_staycalm rr_tryhard rr_stickwithgoals rr_goaftergoal rr_finishwhatbegin rr_finishtasks rr_keepworking
foreach x in $big5rr{
gen im`x'=`x'
}
forvalues j=1(1)3{
forvalues i=1(1)2{
foreach x in $big5rr{
sum im`x' if sex==`i' & caste==`j' & egoid!=0 & egoid!=.
replace im`x'=r(mean) if `x'==. & sex==`i' & caste==`j' & egoid!=0 & egoid!=.
}
}
}

foreach x in $big5{
gen imcr_`x'=cr_`x'
}
forvalues j=1(1)3{
forvalues i=1(1)2{
foreach x in $big5i{
sum imcr_`x' if sex==`i' & caste==`j' & egoid!=0 & egoid!=.
replace imcr_`x'=r(mean) if imcr_`x'==. & sex==`i' & caste==`j' & egoid!=0 & egoid!=.
}
}
}
/*
completeduties_old putoffduties_old = max never, with 99 as cat
raw_completeduties raw_putoffduties = max never, with 99 recoded as missing
rr_completeduties raw_rec_putoffduties = max always, with 99 recoded as missing

cr_completeduties cr_putoffduties = max always, with 99 recoded as missing and reverse questions recoded for Big-5 corrected from acquiescence bias

imrr_completeduties imrr_putoffduties = max always, with 99 recoded as missing and imputation to avoid missing

imcr_completeduties imcr_putoffduties = max always, with 99 recoded as missing and reverse questions recoded for Big-5 corrected from acquiescence bias and imputation to avoid missing


completeduties putoffduties = max always, with 99 recoded as missing and reverse questions recoded for Big-5
*/




	
********** Big-5 taxonomy	
egen cr_OP = rowmean(cr_curious cr_interested~t   cr_repetitive~s cr_inventive cr_liketothink cr_newideas cr_activeimag~n)
egen cr_CO = rowmean(cr_organized  cr_makeplans cr_workhard cr_appointmen~e cr_putoffduties cr_easilydist~d cr_completedu~s) 
egen cr_EX = rowmean(cr_enjoypeople cr_sharefeeli~s cr_shywithpeo~e  cr_enthusiastic  cr_talktomany~e  cr_talkative cr_expressing~s ) 
egen cr_AG = rowmean(cr_workwithot~r   cr_understand~g cr_trustingof~r cr_rudetoother cr_toleratefa~s  cr_forgiveother  cr_helpfulwit~s) 
egen cr_ES = rowmean(cr_managestress  cr_nervous  cr_changemood cr_feeldepres~d cr_easilyupset cr_worryalot  cr_staycalm) 
egen cr_Grit = rowmean(cr_tryhard  cr_stickwithg~s   cr_goaftergoal cr_finishwhat~n cr_finishtasks  cr_keepworking)

egen OP = rowmean(curious interested~t  repetitive~s inventive liketothink newideas activeimag~n)
egen CO = rowmean(organized  makeplans workhard appointmen~e putoffduties easilydistracted completedu~s) 
egen EX = rowmean(enjoypeople sharefeeli~s shywithpeo~e enthusiastic talktomany~e  talkative expressing~s ) 
egen AG = rowmean(workwithot~r understand~g trustingof~r rudetoother toleratefa~s forgiveother helpfulwit~s) 
egen ES = rowmean(managestress nervous changemood feeldepressed easilyupset worryalot staycalm) 
egen Grit = rowmean(tryhard stickwithg~s  goaftergoal finishwhat~n finishtasks keepworking)


save"NEEMSIS2-HH_v12.dta", replace
****************************************
* END











****************************************
* CLEANING
****************************************
use"NEEMSIS2-HH_v12.dta", clear

rename marriedid_o old_marriedid
drop loandetails* loanlender* threemainloans_* 
drop *_o
drop selected_index1 selected_index2 selected_index3 selected_name1 selected_name2 selected_name3 selected_index1_2 selected_index2_2 selected_index3_2 selected_name1_2 selected_name2_2 selected_name3_2 selected_index1_3 selected_index2_3 selected_index3_3 selected_name1_3 selected_name2_3 selected_name3_3 _3selected_index1 _3selected_index2 _3selected_index3 _3selected_name1 _3selected_name2 _3selected_name3 _3selected_index1_2 _3selected_index2_2 _3selected_index3_2 _3selected_name1_2 _3selected_name2_2 _3selected_name3_2 _3ego2random_3_2 _3selected_index1_3 _3selected_index2_3 _3selected_index3_3 _3selected_name1_3 _3selected_name2_3 _3selected_name3_3 _3ego2random_1_3 _3ego2random_2_3 _3ego2random_3_3
drop joinnamehhmemberego1 joinnamehhmember join_1825 join_2635 join_36 _3join_1825 _3join_2635 _3join_36
drop setofrandom_draws_3 setofrandom_draws_2 setofrandom_draws setof_3random_draws_3 setof_3random_draws_2 setof_3random_draws random_draws_count random_draws_3_count random_draws_2_count ego2random_3_3 ego2random_3_2 ego2random_3 ego2random_2_3 ego2random_2_2 ego2random_2 ego2random_1_3 ego2random_1_2 ego2random_1 _3random_draws_count _3random_draws_3_count _3random_draws_2_count _3ego2random_3 _3ego2random_2_2 _3ego2random_2 _3ego2random_1_2 _3ego2random_1
drop uniquelistego2 uniquelistego1 unique_draws_3 unique_draws_2 unique_draws _3unique_draws_3 _3unique_draws_2 _3unique_draws

drop _2businessloandetails_count _2contactgroup_count _2covsntypehelpgivengroup_count _2covsntypehelpreceivedgroup_cou _2formalsocialcapital_count _2indoccupmonths_count _3businessloandetails_count _3contactgroup_count _3count_eligible_1825 _3count_eligible_2635 _3count_eligible_36 _3covsntypehelpgivengroup_count _3covsntypehelpreceivedgroup_cou _3ego2index_1825 _3ego2index_2635 _3ego2index_36 _3formalsocialcapital_count _3indoccupmonths_count _3show_draws_2_count _3show_draws_3_count _3show_draws_count


drop reasonnoinsurance_1 reasonnoinsurance_2 reasonnoinsurance_3
drop usemobilefinancetype_1 usemobilefinancetype_4 usemobilefinancetype_3 usemobilefinancetype_2 usemobilefinancetype_77
drop reservationgrade_12 reservationgrade_10 reservationgrade_7 reservationgrade_9 reservationgrade_8 reservationgrade_6 reservationgrade_11 reservationgrade_3 reservationgrade_16 reservationgrade_15 reservationgrade_5 reservationgrade_4 reservationgrade_1 reservationgrade_2 reservationkind_3 reservationkind_1 reservationkind_2 reservationkind_5 reservationkind_77 reasonneverattendedschool_13 reasonneverattendedschool_1 reasonneverattendedschool_7 reasonneverattendedschool_11 reasondropping_1 reasondropping_11 reasondropping_7 reasondropping_2 reasondropping_5 reasondropping_15 reasondropping_9 reasondropping_77 reasondropping_12 kindofworkinactive_1 kindofworkinactive_2 kindofworkinactive_3 kindofworkinactive_4 kindofworkinactive_5 kindofworkinactive_6 kindofworkinactive_7 kindofworkinactive_8 migrationjoblist_1 migrationjoblist_2 migrationjoblist_3 migrationjoblist_4 migrationjoblist_5 migrationjoblist_6 migrationjoblist_7 migrationjoblist_8 migrationjoblist_9
drop relationwithborrower_7 relationwithborrower_3 relationwithborrower_8 relationwithborrower_5
drop goldreasonpledge_1 goldreasonpledge_2 goldreasonpledge_3 goldreasonpledge_4 goldreasonpledge_5 goldreasonpledge_6 goldreasonpledge_7 goldreasonpledge_8 goldreasonpledge_9 goldreasonpledge_10 goldreasonpledge_11 goldreasonpledge_12 goldreasonpledge_77
drop reservationkind_4 reasonneverattendedschool_5 reasonneverattendedschool_4 reasonneverattendedschool_6 reasonneverattendedschool_8 reasonneverattendedschool_3 reasonneverattendedschool_10 reasonneverattendedschool_12 reasondropping_3 reasondropping_4 reasondropping_6 reasondropping_13 reasondropping_10 relationwithborrower_6 relationwithborrower_9 relationwithborrower_2 relationwithborrower_13 relationwithborrower_11 reasondropping_8 relationwithborrower_1
drop reasonnoland_1 reasonnoland_2 reasonnoland_3 reasonnoland_4 reasonnoland_77 drywetownland_2 drywetownland_1 waterfromownland_3 waterfromownland_5 drywetleaseland_1 drywetleaseland_2 waterfromleaseland_5 waterfromleaseland_3 landleaserrelation_8 productlist_1 productlist_2 productlist_3 productlist_4 productlist_5 productlist_6 productlist_7 productlist_8 productlist_9 productlist_10 productlist_11 productlist_12 productlist_13 productlist_14 productlist_77
drop covexpensesdecrease_1 covexpensesdecrease_4 covexpensesdecrease_3 covexpensesdecrease_7 covexpensesdecrease_2 covexpensesdecrease_5 covexpensesdecrease_6 covexpensesdecrease_9 covexpensesdecrease_8 covexpensesincrease_3 covexpensesincrease_8 covexpensesincrease_1 covexpensesincrease_2 covexpensesincrease_9 covexpensesincrease_4 covexpensesincrease_7 covexpensesincrease_6 covexpensesstable_9 covexpensesstable_5 covexpensesstable_3 covexpensesstable_4 covexpensesstable_6 covexpensesstable_8 listgoods_1 listgoods_2 listgoods_3 listgoods_4 listgoods_5 listgoods_6 listgoods_7 listgoods_8 listgoods_9 listgoods_10 listgoods_11 listgoods_12 listgoods_77 listgoods_13
drop howbuyhouse_2 howbuyhouse_7 howbuyhouse_5 howbuyhouse_4 howbuyhouse_1 schemeslist_2 schemeslist_3 schemeslist_4 schemeslist_5 schemeslist_6 schemeslist_7 schemeslist_8 schemeslist_9 schemeslist_18 schemeslist_19 schemeslist_21 schemeslist_23 covrationcarduse_2 covrationcarduse_1 covrationcarduse_3 waterfromownland_1 waterfromownland_2 waterfromownland_4 waterfromleaseland_2 waterfromleaseland_1 landpurchasedhowbuy_2 landpurchasedhowbuy_4 landpurchasedhowbuy_1 landpurchasedhowbuy_3 landleaserrelation_2 landleaserrelation_1 landleaserrelation_10 landleaserrelation_5 landleasingrelation_10 landleasingrelation_2 landleasingrelation_1 landleasingrelation_8 productlist_15 covsubsistencereason_1 covsubsistencereason_2 covsubsistencereason_3 covsubsistencereason_77 covexpensesincrease_5 covexpensesstable_1 covexpensesstable_7 covexpensesstable_2 howbuyhouse_3 howbuyhouse_6 rationcardreasonnouse_6 rationcardreasonnouse_2 rationcardreasonnouse_1
dropmiss, force

tab HHID_panel
duplicates tag HHID_panel INDID_panel, gen(tag)
tab tag
preserve
keep if tag==1
dropmiss, force
restore
drop tag


save"NEEMSIS2-HH_v13.dta", replace
****************************************
* END





****************************************
* Migration
****************************************
use"NEEMSIS_APPEND-migrationjobidgroup.dta", clear
drop forauto
drop key
drop setofmigrationjobidgroup

split parent_key, p(/)
drop parent_key2
rename parent_key setofmigrationidgroup
rename parent_key parent_key
keep if migrationarea!=.

drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"

preserve
use"NEEMSIS2-HH_v13.dta", clear
keep dummymigration migrantlist migrantlist_ migrationgroup_count setofmigrationidgroup migrationjoblist migrationjobidgroup_count setofmigrationjobidgroup householdid2020 parent_key HHID_panel INDID_panel INDID2020 INDID_total INDID_former INDID_new INDID_left egoid name sex age caste jatis villageid villageid_new version_HH 
keep if migrantlist_==1
save"NEEMSIS2-HH_v13_temp.dta", replace
restore

merge m:1 setofmigrationidgroup using "NEEMSIS2-HH_v13_temp.dta"
sort _merge
drop if _merge==2
drop _merge

erase "NEEMSIS2-HH_v13_temp.dta"

save"NEEMSIS2-migration.dta", replace
****************************************
* END










****************************************
* Died
****************************************
use"NEEMSIS2-HH_v13.dta", clear

rename livinghome livinghome2020

merge 1:1 HHID_panel INDID_panel using "D:\Documents\_Thesis\_DATA\NEEMSIS1\NEEMSIS1-HH_v2.dta", keepusing(livinghome)

drop if _merge==2
drop _merge

tab livinghome livinghome2020, m
rename livinghome livinghome2016
rename livinghome2020 livinghome

label var livinghome2016 ""
tab livinghome2016 livinghome, m

fre livinghome
replace livinghome=4 if livinghome2016==4 & livinghome!=. & livinghome2016!=.


save"NEEMSIS2-HH_v14.dta", replace
****************************************
* END
