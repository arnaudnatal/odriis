cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
September 30, 2021
-----
TITLE: Occupation

-------------------------
*/

clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global git ="C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

cd"$directory"
clear all





****************************************
* Occupation
****************************************
use"$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear

duplicates drop HHID_panel, force
keep HHID_panel villageid villagearea jatis caste geopointlatitude geopointlongitude geopointaltitude geopointaccuracy address
keep if HHID_panel!=""

rename geopointlatitude LATITUDE
rename geopointlongitude LONGITUDE
rename geopointaltitude ALTITUDE
rename geopointaccuracy ACCURACY

order HHID_panel LATITUDE LONGITUDE ALTITUDE ACCURACY

mdesc LATITUDE
*116 sans coordonnées
drop if LATITUDE==.


export delimited using "D:\Documents\_Thesis\Research-Global_intro\HH_list.csv", replace

****************************************
* END
