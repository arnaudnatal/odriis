cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
April 24, 2022
-----
Restitutions
-----

-------------------------
*/









****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
********** Path to folder "data" folder.
global directory = "C:\Users\Arnaud\Documents\_Thesis\Restitution_NEEMSIS2"
cd"$directory"
global git "C:\Users\Arnaud\Documents\GitHub"
global dropbox "C:\Users\Arnaud\Documents\Dropbox\RUME-NEEMSIS\Data"


********** Name of the NEEMSIS2 questionnaire version to clean
global wave1 "RUME-HH"
global wave2 "NEEMSIS1-HH"
global wave3 "NEEMSIS2-HH"

global loan1 "RUME-all_loans"
global loan2 "NEEMSIS1-all_loans"
global loan3 "NEEMSIS2-all_loans"


********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020



****************************************
* END








****************************************
* Data
***************************************

***** HH
use"$dropbox\RUME\\$wave1", clear
save"$directory\wave1.dta", replace

use"$dropbox\NEEMSIS1\\$wave2", clear
save"$directory\wave2.dta", replace

use"$dropbox\NEEMSIS2\LAST\\$wave3", clear
save"$directory\wave3.dta", replace


***** Loans
use"$dropbox\RUME\\$loan1", clear
save"$directory\loan1.dta", replace

use"$dropbox\NEEMSIS1\\$loan2", clear
save"$directory\loan2.dta", replace

use"$dropbox\NEEMSIS2\LAST\\$loan3", clear
save"$directory\loan3.dta", replace


***** Panel
use"$dropbox\Panel\ODRIIS-HH.dta", clear
save"$directory\ODRIIS-HH.dta", replace

use"$dropbox\Panel\ODRIIS-indiv.dta", clear
save"$directory\ODRIIS-indiv.dta", replace

****************************************
* END










****************************************
* 
****************************************

********** Nb obs
use "ODRIIS-HH", clear
reshape long caste jatis villagearea HHID address villageid, i(HHID_panel) j(year)
ta villagearea year if villageid=="ORA"



********** Migration
use "wave2", clear
fre livinghome
drop if livinghome==1
drop if livinghome==4

gen lefthomereason_code=.
label define lefthomereasoncode 1"Permanent job" 2"Marriage" 3"Study" 77"Other"
label values lefthomereason_code lefthomereasoncode
replace lefthomereason_code=1 if strpos(lefthomereason,"work")
replace lefthomereason_code=1 if strpos(lefthomereason,"job")
replace lefthomereason_code=1 if lefthomereason=="ForJob"
replace lefthomereason_code=1 if lefthomereason=="For Job"
replace lefthomereason_code=1 if lefthomereason=="Job"
replace lefthomereason_code=1 if lefthomereason=="Job and settled with his family"
replace lefthomereason_code=1 if lefthomereason=="Job for construction labour"
replace lefthomereason_code=1 if lefthomereason=="Job"
replace lefthomereason_code=1 if lefthomereason=="Job"
replace lefthomereason_code=1 if lefthomereason=="Job"
replace lefthomereason_code=1 if lefthomereason=="For Work"
replace lefthomereason_code=1 if lefthomereason=="Construction Worker"
replace lefthomereason_code=1 if lefthomereason=="Doing Worker"
replace lefthomereason_code=1 if lefthomereason=="Police training"
replace lefthomereason_code=1 if lefthomereason=="Professional"
replace lefthomereason_code=1 if lefthomereason=="Software company staff"
replace lefthomereason_code=1 if lefthomereason=="Doing Worker"
replace lefthomereason_code=1 if lefthomereason=="Doing Work"
replace lefthomereason_code=1 if lefthomereason=="Work"
replace lefthomereason_code=1 if strpos(lefthomereason,"Work , stay there and come back to th")
replace lefthomereason_code=1 if lefthomereason=="Work and setled"
replace lefthomereason_code=1 if lefthomereason=="Work and setteled"
replace lefthomereason_code=1 if lefthomereason=="Work and settled"
replace lefthomereason_code=1 if strpos(lefthomereason,"Try to get chance in cinema field")
replace lefthomereason_code=1 if lefthomereason=="To collect tamarind seeds for subramani business"

replace lefthomereason_code=2 if strpos(lefthomereason,"marriage")
replace lefthomereason_code=2 if strpos(lefthomereason,"married")
replace lefthomereason_code=2 if strpos(lefthomereason,"marriage")
replace lefthomereason_code=2 if strpos(lefthomereason,"wedding")
replace lefthomereason_code=2 if lefthomereason=="Marriage"
replace lefthomereason_code=2 if lefthomereason=="Married"
replace lefthomereason_code=2 if lefthomereason=="Got Married"
replace lefthomereason_code=2 if lefthomereason=="For Married"
replace lefthomereason_code=2 if lefthomereason=="Married and got new family"
replace lefthomereason_code=2 if lefthomereason=="Married and got nuclear family"
replace lefthomereason_code=2 if lefthomereason=="Married and left"
replace lefthomereason_code=2 if lefthomereason=="Married and settled there"


replace lefthomereason_code=3 if strpos(lefthomereason,"school")
replace lefthomereason_code=3 if strpos(lefthomereason,"study")
replace lefthomereason_code=3 if strpos(lefthomereason,"education")
replace lefthomereason_code=3 if lefthomereason=="For Training"
replace lefthomereason_code=3 if lefthomereason=="For training"
replace lefthomereason_code=3 if lefthomereason=="For Studying"
replace lefthomereason_code=3 if lefthomereason=="For higher studies"
replace lefthomereason_code=3 if lefthomereason=="For studies"
replace lefthomereason_code=3 if lefthomereason=="For nursing apprentice"
replace lefthomereason_code=3 if lefthomereason=="For nursing training"
replace lefthomereason_code=3 if lefthomereason=="ITI Aprentice Training"
replace lefthomereason_code=3 if lefthomereason=="Study"
replace lefthomereason_code=3 if lefthomereason=="Studying"
replace lefthomereason_code=3 if lefthomereason=="Studying in 12 Th"
replace lefthomereason_code=3 if strpos(lefthomereason,"Study and stay with sister for some m")
replace lefthomereason_code=3 if lefthomereason=="Training"


replace lefthomereason_code=. if lefthomereason=="Following her husband and also for work"
replace lefthomereason_code=. if lefthomereason=="Following his parents and also for work"
replace lefthomereason_code=. if lefthomereason=="For Husband job"
replace lefthomereason_code=. if lefthomereason=="Following her husband family and also for work"
replace lefthomereason_code=. if lefthomereason=="Following his wife's family, work localy"
replace lefthomereason_code=. if lefthomereason=="Following her parents and also for work"
replace lefthomereason_code=. if lefthomereason=="Family problem,and also for her daughter's education."
replace lefthomereason_code=. if lefthomereason=="Following her mother and also for education"


ta lefthomereason if lefthomereason_code==.

ta lefthomereason lefthomereason_code


reshape long name sex age relationshiptohead livinghome wave HHID INDID submissiondate jatis caste address villageid villagearea lefthomereason reasonlefthome, i(HHID_panel INDID_panel) j(year)

ta reasonlefthome year if villageid=="MAN"


****************************************
* END
