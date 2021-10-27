cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
February 23, 2021
-----
SOMEONE ELSE CLEANING
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
*global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
cd"$directory"
********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

****************************************
* END












****************************************
* MARRIAGE CLEANING
****************************************

********** TEMPORARY PANEL DATA BASE TO HAVE ALL INDIVIDUALS
use"$directory\CLEAN\NEEMSIS2-HH_v5_bis.dta", clear

*replace INDID=. if version=="NEEMSIS2_NEW_APRIL"
*replace INDIDpanel="" if version=="NEEMSIS2_NEW_APRIL"

tostring INDID, replace
drop sex age

merge m:1 INDID HHID_panel using "$directory\do_not_drop\preload2016"
drop _merge
*
save"$directory\CLEAN\NEEMSIS2-HH_v6.dta", replace






********* TEMPORARY CLEANING OF MARRIAGE DATABASE & LIST OF HH WITH SOMEONE ELSE
use"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup.dta", clear
keep if marriagedate!=.
drop forauto howpaymarriage_4 howpaymarriage_2 howpaymarriage_1 howpaymarriage_3 
drop marriageloanlendername1 marriageloanlendername2 marriageloanlendername3 marriageloanlendername4 marriageloanlendername5 marriageloanlendername6 marriageloanlendername7 marriageloanlendername8 marriageloanlendername9 marriageloanlendername10 marriageloanlendername11 marriageloanlendername12 marriageloanlendername13 marriageloanlendername14 marriageloanlendername15
drop marriagegiftsource_1 marriagegiftsource_2 marriagegiftsource_3 marriagegiftsource_4 marriagegiftsource_5 marriagegiftsource_6 marriagegiftsource_7 marriagegiftsource_8 marriagegiftsource_9 marriagegiftsource_10 marriagegiftsource_11 marriagegiftsource_12 marriagegiftsource_13 marriagegiftsource_14 marriagegiftsource_15

*replace marriedname=marriagesomeoneelse if marriedname=="Someone else 1" & marriagesomeoneelse!=""
*replace marriedname=marriagesomeoneelse if marriedname=="Someone else 2" & marriagesomeoneelse!=""

merge m:1 parent_key using "$directory\CLEAN\NEEMSIS_APPEND.dta", keepusing(householdid2020 HHID2010 HHID_panel startquestionnaire version)
keep if _merge==3
drop _merge

* INTERMEDIATE SAVING
save"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v2.dta", replace

* LIST OF SOMEONE ELSE HH
keep if marriagedate!=.
sort HHID_panel marriagesomeoneelse
list HHID_panel version if (marriedid=="31" | marriedid=="32" | marriedid=="33") & marriagesomeoneelse=="", clean noobs
list HHID_panel marriedname marriagesomeoneelse marriedid version if marriagesomeoneelse!="" & (marriedid=="31" | marriedid=="32" | marriedid=="33"), clean noobs // & (version=="NEEMSIS2_APRIL" | version=="NEEMSIS2_NEW_APRIL" | version=="NEEMSIS2_FEBRUARY") , clean noobs

/*
    HHID_p~l      marriedname   marriagesomeon~e   marrie~d             version  
       ELA12   Someone else 1            Lakshmi         31      NEEMSIS2_APRIL  
       ELA14   Someone else 1           Anbarasi         31      NEEMSIS2_APRIL  
        ELA4   Someone else 1              Selvi         31      NEEMSIS2_APRIL  
       GOV11   Someone else 1      Bhuvaneshwari         31   NEEMSIS2_FEBRUARY  
       GOV13   Someone else 1        Udhayakumar         31      NEEMSIS2_APRIL  
       GOV27   Someone else 1              Deepa         31   NEEMSIS2_FEBRUARY  
       GOV28   Someone else 1          Govinthan         31   NEEMSIS2_FEBRUARY  
       GOV37   Someone else 1            Revathy         31      NEEMSIS2_APRIL  
       GOV45   Someone else 1            Thamizh         31   NEEMSIS2_FEBRUARY  
       GOV49   Someone else 1        Mahalakshmi         31   NEEMSIS2_FEBRUARY  
       KAR27   Someone else 1        Sivashakthi         31   NEEMSIS2_FEBRUARY  
       KAR29   Someone else 1         Mahalashmi         31   NEEMSIS2_FEBRUARY  
       KAR47   Someone else 1            Nagamma         31   NEEMSIS2_FEBRUARY  
        KAR8   Someone else 1            Kavitha         31   NEEMSIS2_FEBRUARY  
        KAR8   Someone else 2            Savitha         33   NEEMSIS2_FEBRUARY  
        KAR9   Someone else 1             Vijaya         31      NEEMSIS2_APRIL  
       KOR26   Someone else 1       Bakyalakshmi         31   NEEMSIS2_FEBRUARY  
       KOR31   Someone else 1     Santhosh Kumar         31   NEEMSIS2_FEBRUARY  
       KOR37   Someone else 1        Porcheselvi         31   NEEMSIS2_FEBRUARY  
       KOR43   Someone else 1          Banumathy         31   NEEMSIS2_FEBRUARY  
       KOR43   Someone else 2   Santhosh kumarie         33   NEEMSIS2_FEBRUARY  
       KUV47   Someone else 2        Mahalakshmi         33      NEEMSIS2_APRIL  
       KUV47   Someone else 1       Mangalakshmi         31      NEEMSIS2_APRIL  
       MAN17   Someone else 1        Manimegalai         31      NEEMSIS2_APRIL  
        MAN2   Someone else 1           Santhiya         31      NEEMSIS2_APRIL  
       MAN45   Someone else 1               Vasu         31   NEEMSIS2_FEBRUARY  
     MANAM21   Someone else 1              Kuppu         31   NEEMSIS2_FEBRUARY  
     MANAM38   Someone else 1            Lakshmi         31   NEEMSIS2_FEBRUARY  
     MANAM43   Someone else 1          Kalaivani         31   NEEMSIS2_FEBRUARY  
     MANAM51   Someone else 1           Vasantha         31   NEEMSIS2_FEBRUARY  
        NAT2   Someone else 1       Thamizhselvi         31   NEEMSIS2_FEBRUARY  
       NAT49   Someone else 1          Vadivelan         31      NEEMSIS2_APRIL  
       ORA20   Someone else 1             Sarasu         31   NEEMSIS2_FEBRUARY  
       ORA48   Someone else 1         Ajithkumar         31   NEEMSIS2_FEBRUARY  
       SEM20   Someone else 1         Sagunthala         31   NEEMSIS2_FEBRUARY  
       SEM34   Someone else 1             Geetha         31      NEEMSIS2_APRIL 
*/






********** BACK TO TEMPORARY PANEL DATA BASE TO CHECK ALL INDIVIDUALS
/*
Someone else without indications
*/
use"$directory\CLEAN\NEEMSIS2-HH_v6.dta", clear
gen mar=0

replace mar=1 if HHID_panel=="ELA2"  
replace mar=1 if HHID_panel=="ELA23"  
replace mar=1 if HHID_panel=="ELA27"  
replace mar=1 if HHID_panel=="ELA28"
replace mar=1 if HHID_panel=="ELA34" 
replace mar=1 if HHID_panel=="ELA51"  
replace mar=1 if HHID_panel=="KAR24" 
replace mar=1 if HHID_panel=="KAR5"
replace mar=1 if HHID_panel=="MANAM25"
replace mar=1 if HHID_panel=="NAT22"
replace mar=1 if HHID_panel=="NAT26" 
replace mar=1 if HHID_panel=="NAT31"   
replace mar=1 if HHID_panel=="SEM30"  
replace mar=1 if HHID_panel=="SEM43" 
replace mar=1 if HHID_panel=="SEM48" 
*
preserve
keep if mar==1
sort HHID_panel INDID
*list HHID_panel INDID INDID_p16 INDID_left reasonlefthome name_p16 name maritalstatus_p16 maritalstatus sex_p16, clean noobs
restore






********** BACK TO TEMPORARY PANEL DATA BASE TO CHECK ALL INDIVIDUALS
/*
Someone else with indications
*/
use"$directory\CLEAN\NEEMSIS2-HH_v6.dta", clear
gen mar=0

replace mar=1 if HHID_panel=="ELA12"
replace mar=1 if HHID_panel=="ELA14"
replace mar=1 if HHID_panel=="ELA4"
replace mar=1 if HHID_panel=="GOV11"
replace mar=1 if HHID_panel=="GOV13"
replace mar=1 if HHID_panel=="GOV27"
replace mar=1 if HHID_panel=="GOV28"
replace mar=1 if HHID_panel=="GOV37"
replace mar=1 if HHID_panel=="GOV45"
replace mar=1 if HHID_panel=="GOV49"
replace mar=1 if HHID_panel=="KAR27"
replace mar=1 if HHID_panel=="KAR29"
replace mar=1 if HHID_panel=="KAR47"
replace mar=1 if HHID_panel=="KAR8"
replace mar=1 if HHID_panel=="KAR8"
replace mar=1 if HHID_panel=="KAR9"
replace mar=1 if HHID_panel=="KOR26"
replace mar=1 if HHID_panel=="KOR31"
replace mar=1 if HHID_panel=="KOR37"
replace mar=1 if HHID_panel=="KOR43"
replace mar=1 if HHID_panel=="KOR43"
replace mar=1 if HHID_panel=="KUV47"
replace mar=1 if HHID_panel=="KUV47"
replace mar=1 if HHID_panel=="MAN17"
replace mar=1 if HHID_panel=="MAN2"
replace mar=1 if HHID_panel=="MAN45"
replace mar=1 if HHID_panel=="MANAM21"
replace mar=1 if HHID_panel=="MANAM38"
replace mar=1 if HHID_panel=="MANAM43"
replace mar=1 if HHID_panel=="MANAM51"
replace mar=1 if HHID_panel=="NAT2"
replace mar=1 if HHID_panel=="NAT49"
replace mar=1 if HHID_panel=="ORA20"
replace mar=1 if HHID_panel=="ORA48"
replace mar=1 if HHID_panel=="SEM20"
replace mar=1 if HHID_panel=="SEM34"

*
preserve
keep if mar==1
sort HHID_panel
list HHID_panel INDID INDID_total INDID_former INDID_new INDID_left INDID_panel name sex maritalstatus reasonlefthome reasonlefthomeother, clean noobs
list HHID_panel INDID INDID_left reasonlefthome, clean noobs
restore







********** CHANGE CODE IN MARRIAGE DATA BASE

use"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v2.dta", replace
destring marriedid, replace
clonevar marriedid_o=marriedid

replace marriedid=3 if HHID_panel=="ELA2" & marriedname=="Someone else"
replace marriedid=3 if HHID_panel=="ELA23" & marriedname=="Someone else"
replace marriedid=5 if HHID_panel=="ELA27" & marriedname=="Someone else"
replace marriedid=3 if HHID_panel=="ELA28" & marriedname=="Someone else"
replace marriedid=3 if HHID_panel=="ELA34" & marriedname=="Someone else"
replace marriedid=4 if HHID_panel=="ELA51" & marriedname=="Someone else"
*replace marriedid=3 if HHID_panel=="KAR24" & marriedname=="Someone else"
replace marriedid=3 if HHID_panel=="KAR5" & marriedname=="Someone else"
*replace marriedid=3 if HHID_panel=="MANAM25" & marriedname=="Someone else"
replace marriedid=3 if HHID_panel=="NAT22" & marriedname=="Someone else"
replace marriedid=3 if HHID_panel=="NAT26" & marriedname=="Someone else"
replace marriedid=7 if HHID_panel=="NAT31" & marriedname=="Someone else"
replace marriedid=4 if HHID_panel=="SEM30" & marriedname=="Someone else"
replace marriedid=3 if HHID_panel=="SEM43" & marriedname=="Someone else"
replace marriedid=6 if HHID_panel=="SEM48" & marriedname=="Someone else"


replace marriedid=4 if HHID_panel=="ELA12" & marriedid_o==31
replace marriedid=5 if HHID_panel=="ELA14" & marriedid_o==31
replace marriedid=4 if HHID_panel=="ELA4" & marriedid_o==31
replace marriedid=3 if HHID_panel=="GOV11" & marriedid_o==31
replace marriedid=3 if HHID_panel=="GOV13" & marriedid_o==31
replace marriedid=3 if HHID_panel=="GOV27" & marriedid_o==31
replace marriedid=6 if HHID_panel=="GOV28" & marriedid_o==31
replace marriedid=4 if HHID_panel=="GOV37" & marriedid_o==31
replace marriedid=4 if HHID_panel=="GOV45" & marriedid_o==31
replace marriedid=5 if HHID_panel=="GOV49" & marriedid_o==31
replace marriedid=5 if HHID_panel=="KAR27" & marriedid_o==31
replace marriedid=6 if HHID_panel=="KAR29" & marriedid_o==31
replace marriedid=3 if HHID_panel=="KAR47" & marriedid_o==31
replace marriedid=2 if HHID_panel=="KAR8" & marriedid_o==31
replace marriedid=3 if HHID_panel=="KAR8" & marriedid_o==33
replace marriedid=5 if HHID_panel=="KAR9" & marriedid_o==31
replace marriedid=2 if HHID_panel=="KOR26" & marriedid_o==31
replace marriedid=6 if HHID_panel=="KOR31" & marriedid_o==31
replace marriedid=6 if HHID_panel=="KOR37" & marriedid_o==31
replace marriedid=4 if HHID_panel=="KOR43" & marriedid_o==31
replace marriedid=5 if HHID_panel=="KOR43" & marriedid_o==33
replace marriedid=4 if HHID_panel=="KUV47" & marriedid_o==33
replace marriedid=3 if HHID_panel=="KUV47" & marriedid_o==31
replace marriedid=5 if HHID_panel=="MAN17" & marriedid_o==31
replace marriedid=3 if HHID_panel=="MAN2" & marriedid_o==31
replace marriedid=3 if HHID_panel=="MAN45" & marriedid_o==31
replace marriedid=3 if HHID_panel=="MANAM21" & marriedid_o==31
replace marriedid=4 if HHID_panel=="MANAM38" & marriedid_o==31
replace marriedid=3 if HHID_panel=="MANAM43" & marriedid_o==31
replace marriedid=4 if HHID_panel=="MANAM51" & marriedid_o==31
replace marriedid=5 if HHID_panel=="NAT2" & marriedid_o==31
replace marriedid=4 if HHID_panel=="NAT49" & marriedid_o==31
replace marriedid=3 if HHID_panel=="ORA20" & marriedid_o==31
replace marriedid=4 if HHID_panel=="ORA48" & marriedid_o==31
replace marriedid=3 if HHID_panel=="SEM20" & marriedid_o==31
replace marriedid=4 if HHID_panel=="SEM34" & marriedid_o==31

sort householdid2020

clonevar INDID=marriedid
order HHID_panel INDID marriedname marriagesomeoneelse
sort HHID_panel INDID
save"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v3.dta", replace

****************************************
* END














****************************************
* MERGE MARRIAGE WITH HOUSEHOLD DATA BASE
****************************************
use"$directory\CLEAN\NEEMSIS2-HH_v5_bis.dta", clear
drop INDID2010

merge 1:m INDID parent_key using "$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v3.dta"

preserve
keep if _merge==2
dropmiss, force
/*
Pb avec :
MANAM25 -- 31
KAR24  	-- 31
*/
restore

rename _merge marriagepb
label define marriagepb 1"No marriage" 2"Someone else" 3"Merge marriage ok"
label values marriagepb marriagepb

save"$directory\CLEAN\NEEMSIS2-HH_v6.dta", replace
****************************************
* END
