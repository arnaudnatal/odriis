*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Anonymize data
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\RUME-NEEMSIS\Data"
cd"$directory"



*drop livinghome
****************************************
* To publish
***************************************

*HH
use"RUME/Household/RUME-HH", clear

drop name address householdid

save"Anonymised/RUME/RUME-HH", replace


*

****************************************
* END
