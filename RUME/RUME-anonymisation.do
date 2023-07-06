*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*July 6, 2023
*-----
*RUME anonymisation
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\Materials\RUME"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\2010-RUME\Data"
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
* RUME-HH.dta
****************************************
use"4team\Last\RUME-HH", clear

drop householdid address name namebusinesslabourer1 namebusinesslabourer2 namebusinesslabourer3 namebusinesslabourer4 namebusinesslabourer5 namebusinesslabourer6 namebusinesslabourer7 remrecsourcename11 remrecsourcename12 remrecsourcename13 landleasername landleasingname

save"2publish\RUME-HH", replace
****************************************
* END








****************************************
* RUME-lenders.dta
****************************************
use"4team\Last\RUME-lenders", clear

save"2publish\RUME-lenders", replace
****************************************
* END







****************************************
* RUME-loans_mainloans.dta
****************************************
use"4team\Last\RUME-loans_mainloans", clear

drop lendername

save"2publish\RUME-loans_mainloans", replace
****************************************
* END









****************************************
* RUME-occupations.dta
****************************************
use"4team\Last\RUME-occupations", clear

save"2publish\RUME-occupations", replace
****************************************
* END





