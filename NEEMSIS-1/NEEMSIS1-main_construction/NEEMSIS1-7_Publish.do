cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
September 16, 2021
-----
TITLE: Other file
-------------------------
*/




****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\Publish\NEEMSIS-1\Individual"

cd"$directory"
clear all
****************************************
* END




****************************************
* Backup Big-5
****************************************
use"NEEMSIS1-ego", clear

foreach x in enjoypeople curious organized managestress interestedbyart tryhard workwithother makeplans sharefeelings stickwithgoals workhard understandotherfeeling inventive enthusiastic appointmentontime goaftergoal  talktomanypeople liketothink finishwhatbegin finishtasks toleratefaults keepworking completeduties talkative newideas staycalm forgiveother activeimagination expressingthoughts helpfulwithothers {
recode `x' (1=5) (2=4) (3=3) (4=2) (5=1)
label define big510 1"1 - Almost always" 2"2 - Quite often" 3"3 - Sometimes" 4"4 - Rarely" 5"5 - Almost never", replace
label values `x' big510
*gen test_`x'=`x'-`x'_backup
*ta test_`x'
*drop test_`x' `x'_backup
}



foreach x in nervous repetitivetasks shywithpeople changemood feeldepressed easilyupset putoffduties rudetoother worryalot easilydistracted {
fre `x'
}

fre enjoypeople nervous

/*
* Normal
ta enjoypeople_backup enjoypeople 


* Reverse
ta nervous_backup nervous
/*
Donc, les reverse coded sont déjà à l'endroit
*/

keep enjoypeople curious organized managestress interestedbyart tryhard workwithother makeplans sharefeelings nervous stickwithgoals repetitivetasks shywithpeople workhard changemood understandotherfeeling inventive enthusiastic feeldepressed appointmentontime goaftergoal easilyupset talktomanypeople liketothink finishwhatbegin putoffduties rudetoother finishtasks toleratefaults worryalot easilydistracted keepworking completeduties talkative newideas staycalm forgiveother activeimagination expressingthoughts helpfulwithothers


****************************************
* END
