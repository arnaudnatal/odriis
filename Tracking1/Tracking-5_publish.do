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

********** Clean
rename key HHID2019
drop caste 
rename jatis caste
rename jatisother casteother
drop if name==""
drop familymembers_count employment_count *fromearlier *fromearlier* index listid


** replace religion et religion individual


********** Order
order HHID2019 geolocationlatitude geolocationlongitude geolocationaltitude geolocationaccuracy interviewplacemig username householdvillageoriginal householdidoriginal migrationplacename migrationareatype migrationareaurban migrationarearural migrationaddress sharedhhmig householdmigrantslist othermemberhhmig rankingmigrant migrationremark dummynewmb dummymainmigrant indid indid2 namenumber name sex age comefrom relationshiptohead maritalstatus caste casteother religionindividual religion religionother relationshiptoheadother otherreligionindividual everattendedschool classcompleted currentlyatschool educationexpenses dummyworkedpastyear reasonnotworkpastyear, first


order migrationjobid1 migrationjobname1 migrationarea1 migrationplace1 migrationdistance1 migrationtype1 migrationdurationfreq1 migrationdurationinmonth1 migdummybacktovillage1 migrationtravelcost1 migrationtravelpayment1 migrationtenure1 migrationfindjob1 migrationjobtype1 migrationjobtype21 migrationwagetype1 migrationsalary1, after(reasonnotworkpastyear)

order dummyownland sizeownland landpurchased landpurchasedacres landpurchasedamount foodexpenses healthexpenses ceremoniesexpenses ceremoniesrelativesexpenses deathexpenses house rentalhouse housevalue housetype housesize electricity water toiletfacility noowntoilet schemeslist landpurchasedhowbuy listgoods housetitle ownotherhouse otherhouserent otherhousevalue, after(migrationsalary1)








migrationpension1 migrationbonus1 migrationinsurance1 migrationchild1 migrationmainoccup1 migrationskill1 migrationreason1 migrationotherreason1 remittancessentid1 remitsentdummyvillage1 remittancessentrelation1 remittancessentoccup1 remittancessentplace1 remittancessentfrequency1 remittancessentamount1 remitsenttotalamount1 remittancessentservices1 remitsentsourceoccupother1 remittancesrecipientid1 remittancesrecipientname1 remitrecipsourceid1 remitrecipsourcename1 remitrecsourcerelation1 remitrecsourcehh1 remitrecsourceoccup1 remitrecsourceplace1 remitrecfreq1 remitrecamount1 remitrectotalamount1 remitrecservices1 remitrecsourceoccupoth1 remitrecservicesother1


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
