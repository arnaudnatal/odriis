cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
January 29, 2021
-----
Tracking cleaning
-----

-------------------------
*/


****************************************
* INITIALIZATION
****************************************
clear all
global directory "C:\Users\Arnaud\Documents\MEGA\Data\Data_Tracking2019\DATA"
cd"$directory"
****************************************
* END








****************************************
* Tracking
****************************************
use"NEEMSIS-tracking_v7.dta", clear

rename key HHID2019
drop if name==""




use"NEEMSIS-tracking_wagejobpaymentinkind.dta", clear

use"NEEMSIS-tracking_contact.dta", clear


****************************************
* END




****************************************
* Occupations
****************************************
use"NEEMSIS-tracking_occupations_allwide_v4.dta", clear

****************************************
* END





****************************************
* Alter
****************************************
use"NEEMSIS-tracking_helpmigration.dta", clear
use"NEEMSIS-tracking_snrecoasso.dta", clear
****************************************
* END
