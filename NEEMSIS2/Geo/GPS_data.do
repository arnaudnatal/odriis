cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
May 5, 2022
-----
GPS data
-----

-------------------------
*/




****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
********** Path to folder "data" folder.

global dropbox "C:\Users\Arnaud\Documents\Dropbox\RUME-NEEMSIS\Data"
global git "C:\Users\Arnaud\Documents\GitHub"


********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020

****************************************
* END





****************************************
* Data
****************************************
cls
clear all
use"$dropbox/NEEMSIS2/LAST/NEEMSIS2-HH.dta"

***** Var to keep
global tokeep1 HHID_panel jatis address villageid submissiondate villagearea geopointlatitude geopointlongitude geopointaltitude geopointaccuracy assets assets_noland annualincome_HH mainocc_occupation_HH loanamount_HH caste

global tokeep2 dummyeverhadland reasonnoland ownland sizeownland drywetownland leaseland sizeleaseland drywetleaseland landpurchased amountownlanddry amountownlandwet amountownland 

global tokeep3 house housevalue housetype housesize housetitle 


keep $tokeep1 $tokeep2 $tokeep3


***** Duplicates to drop
duplicates drop


***** Export data
export delimited "$dropbox/NEEMSIS2/LAST/NEEMSIS2_data.csv", replace
clear all
****************************************
* END
