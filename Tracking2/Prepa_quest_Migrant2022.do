cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
July 6, 2022
-----
Migrant questionnaire 2022 preparation
-----

-------------------------
*/



****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
********** Path to folder "data" folder.
global directory = "C:\Users\Arnaud\Documents\_Thesis\_DATA"
*cd"F:\Tracking2"
global git "C:\Users\Arnaud\Documents\GitHub\odriis"
cd"$git"


set scheme plotplain 

*Fac
*cd "C:\Users\anatal\Downloads\_Thesis\Research-Skills_and_debt\Analysis"
*set scheme plotplain

*global git "C:\Users\anatal\Downloads\GitHub"
*global dropbox "C:\Users\anatal\Downloads\Dropbox"
*global thesis "C:\Users\anatal\Downloads\_Thesis\Research-Skills_and_debt\Analysis"

****************************************
* END


/*
Il faudra que je change: 
Replace KAR15 Ind_7 par Ind_6
Replace KOR30 Ind_8 par Ind_6
*/



****************************************
* Tracking 2010-19 --> hhhead
****************************************
import excel "Tracking2\Neemsis_tracking_last_FINAL_V15.xlsx", sheet("choices") firstrow clear

keep if list_name=="hhhead"
drop image filter filter1 filter2 filter3 filter4 filter5 filter6 filter7 filter8 filter9 filter10 labeltamil
split label, p(,)

gen HHID=""
replace HHID=label6 if label5!=""
replace HHID=label5 if label6==""
replace HHID=label4 if label5==""
replace HHID=label3 if label4==""
replace HHID=label2 if label3==""
replace HHID=label1 if label2==""

drop label1 label2 label3 label4 label5 label6

duplicates tag HHID, gen(tag)
ta tag
ta HHID if tag==19
dis 425-20
*405 HH = from RUME

****************************************
* END







****************************************
* Tracking 2010-19 --> householdidoriginal
****************************************
import excel "Tracking2\Neemsis_tracking_last_FINAL_V15.xlsx", sheet("choices") firstrow clear

keep if list_name=="householdidoriginal"
compress label
dropmiss, force
destring value filter, replace
sort filter

clonevar HHID2010=label

preserve
use"RUME\CLEAN\RUME-HH.dta", clear
keep HHID_panel HHID2010 villageid villagearea
duplicates drop
save"Tracking2\_temp_RUME-HH.dta", replace
restore

merge 1:1 HHID2010 using "Tracking2\_temp_RUME-HH.dta"
keep if _merge==3
drop _merge

sort filter

preserve
keep filter villageid
duplicates drop
list filter villageid, clean noobs
restore

/*
filter	villag~d	 
1	MAN	 
2	MANAM	 
3	SEM	 
4	NAT	 
5	GOV	 
6	KAR	 
7	KOR	 
8	KUV	 
9	ELA	 
10	ORA	 
*/

****************************************
* END









****************************************
* Tracking 2010-19 --> householdmigrantslist
****************************************
import excel "Tracking2\Neemsis_tracking_last_FINAL_V15.xlsx", sheet("choices") firstrow clear

keep if list_name=="householdmigrantslist"
drop image filter1 filter2 filter3 filter4 filter5 filter6 filter7 filter8 filter9 filter10 labeltamil
compress label

destring value filter, replace
sort filter value

****************************************
* END







****************************************
* Tracking 2010-19 --> RUME + NEEMSIS-1
****************************************
use"RUME\CLEAN\RUME-HH", clear

keep HHID_panel HHID2010 villageid name



use"NEEMSIS1\CLEAN\NEEMSIS1-HH", clear

keep HHID_panel villageid livinghome lefthomedestination lefthomereason relationshiptohead name
compress


****************************************
* END






****************************************
* Open HH list Gaston
****************************************
import excel "Tracking2\MIgrant_tracking_72.xlsx", sheet("migrant_complement_others") firstrow clear

*** Keep id for migr det
preserve
keep HHID_panel INDID_panel
gen gaston_migr=1
save "Tracking2\migr_id", replace
restore


*** NEEMSIS-2
use"NEEMSIS2\DATA\APPEND\CLEAN\LAST\NEEMSIS2-HH", clear

merge 1:1 HHID_panel INDID_panel using "Tracking2\migr_id"

order HHID_panel INDID_panel INDID_left gaston_migr villageid dummylefthousehold lefthomename reasonlefthome livinghome lefthomedestination lefthomereason relationshiptohead name

ta gaston_migr
ta reasonlefthome
dis 211-116
sort gaston_migr reasonlefthome

gen tokeep=0
replace tokeep=1 if HHID_panel=="KAR15" & (INDID_panel=="Ind_7" | INDID_panel=="Ind_6")
replace tokeep=1 if HHID_panel=="KOR30" & (INDID_panel=="Ind_8" | INDID_panel=="Ind_6")

keep if tokeep==1
drop tokeep

keep HHID_panel INDID_panel name sex age caste address relationshiptohead


*** householdidoriginal
import excel "Tracking2\MIgrant_tracking_72.xlsx", sheet("migrant_complement_others") firstrow clear

keep villagearea HHID_panel name_head address
duplicates drop
egen code=concat(HHID_panel name_head address), p(" --- ")
sort villagearea HHID_panel
keep villagearea HHID_panel code


*** householdmigrantslist
import excel "Tracking2\MIgrant_tracking_72.xlsx", sheet("migrant_complement_others") firstrow clear

keep HHID_panel INDID_panel name villagearea sex age caste
sort villagearea HHID_panel INDID_panel

sencode HHID_panel, gen(n) gsort(villagearea HHID_panel)
_strip_labels n

order HHID_panel name n
sort villagearea HHID_panel INDID_panel

****************************************
* END
