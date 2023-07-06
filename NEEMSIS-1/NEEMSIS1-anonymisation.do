*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*July 10, 2023
*-----
*NEEMSIS-1 HH last clean
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-1"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\2016-NEEMSIS1\Data"
cd"$directory"
********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid
********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020
*-------------------------








****************************************
* NEEMSIS1-HH.dta
****************************************
use"4team\Last\NEEMSIS1-HH", clear

drop address instancename formdef_version villageid_new_comments name remsentrecipientname1 remsentrecipientname2 landleasername landleasingname

save"2publish\NEEMSIS1-HH", replace
****************************************
* END








****************************************
* NEEMSIS1-loans_mainloans.dta
****************************************
use"4team\Last\NEEMSIS1-loans_mainloans", clear

drop name villageid villageareaid householdid lendername jatis sex age


save"2publish\NEEMSIS1-loans_mainloans", replace
****************************************
* END









****************************************
* NEEMSIS1-occupations.dta
****************************************
use"4team\Last\NEEMSIS1-occupations", clear

drop namebusiness* address*

save"2publish\NEEMSIS1-occupations", replace
****************************************
* END








****************************************
* NEEMSIS1-migrations.dta
****************************************
use"4team\Last\NEEMSIS1-migrations", clear




save"2publish\NEEMSIS1-migrations", replace
****************************************
* END









****************************************
* NEEMSIS1-ego.dta
****************************************
use"4team\Last\NEEMSIS1-ego", clear

drop name 

save"2publish\NEEMSIS1-ego", replace
****************************************
* END






****************************************
* NEEMSIS1-alters.dta
****************************************
use"4team\Last\NEEMSIS1-alters", clear

drop altername alterid_byNP1 nb_ntwother snTHnamelist snEBnamelist snRWnamelist snFSnamelist snLTnamelist snFJnamelist snRJnamelist snRJSnamelist snDAnamelist snDGnamelist sndemogivennber sndemoaskednber snrecommendforjobnber snfindjobnber snfindsuppliersnber sntechnicalhelpnber snrecommendassonber snrecojobsuccessnber snlendtoolsnber snrecruitworkernber snentrustbusinessnber

save"2publish\NEEMSIS1-alters", replace
****************************************
* END
