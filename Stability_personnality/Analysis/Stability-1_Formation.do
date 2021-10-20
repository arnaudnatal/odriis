cls

/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
October 1, 2021
-----
Stability over time of personality traits: merging des bases
-----

-------------------------
*/


****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\Research-Stability_skills\Analysis"
cd"$directory"
global git "C:\Users\Arnaud\Documents\GitHub"

*Fac
*cd "C:\Users\anatal\Downloads\_Thesis\Research-Skills_and_debt\Analysis"
set scheme plotplain

*global git "C:\Users\anatal\Downloads\GitHub"
*global dropbox "C:\Users\anatal\Downloads\Dropbox"
*global thesis "C:\Users\anatal\Downloads\_Thesis\Research-Skills_and_debt\Analysis"


********** Name of the NEEMSIS2 questionnaire version to clean
global wave2 "NEEMSIS1-HH_v9"
global wave3 "NEEMSIS2-HH_v20"
****************************************
* END







****************************************
* PANEL
***************************************
use"$directory\\$wave2", clear
keep HHID_panel INDID_panel egoid name age sex edulevel jatis caste villageid dummydemonetisation relationshiptohead maritalstatus year
foreach x in egoid name age sex edulevel jatis caste villageid dummydemonetisation relationshiptohead maritalstatus year {
rename `x' `x'_2016
}
save"$wave2-_tempego", replace

use"$directory\\$wave3", clear
keep HHID_panel INDID_panel egoid name age sex edulevel jatis caste villageid relationshiptohead maritalstatus year
foreach x in egoid name age sex edulevel jatis caste villageid relationshiptohead maritalstatus year {
rename `x' `x'_2020
}
save"$wave3-_tempego", replace



*Merge all
use"$directory\\$wave2-_tempego", clear
merge 1:1 HHID_panel INDID_panel using "$directory\\$wave3-_tempego"
rename _merge merge_1620
keep if egoid_2016>0 | egoid_2020>0
keep if year_2016==2016 & year_2020==2020
tab egoid_2016 egoid_2020
order HHID_panel INDID_panel name_2016 egoid_2016 name_2020 egoid_2020

tab egoid_2020


*One var
gen panel=0
replace panel=1 if year_2016!=. & egoid_2016!=0 & year_2020!=. & egoid_2020!=0
tab panel

save"panel", replace
****************************************
* END







****************************************
* PREPA 2016
****************************************
use "$wave2", clear
keep if egoid>0
egen HHINDID=concat(HHID_panel INDID_panel), p(/)
duplicates tag HHINDID, gen(tag)
tab tag
drop tag

*Merge
merge 1:1 HHID_panel INDID_panel using "panel", keepusing(panel)
drop if _merge==2
drop _merge
recode panel (.=0)

global tokeep age edulevel sex caste jatis name address villageid villageareaid villageid_new villageid_new_comments username ///
dummydemonetisation demotrustneighborhood demotrustemployees_ego demotrustbank_ego demonetworkpeoplehelping_ego demonetworkhelpkinmember_ego demogeneralperception demogoodexpectations demobadexpectations ///
curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination organized makeplans workhard appointmentontime putoffduties easilydistracted completeduties enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople talkative expressingthoughts workwithother understandotherfeeling trustingofother rudetoother toleratefaults forgiveother helpfulwithothers managestress nervous changemood feeldepressed easilyupset worryalot staycalm tryhard stickwithgoals goaftergoal finishwhatbegin finishtasks keepworking username
keep HHINDID HHID_panel INDID_panel panel egoid year $tokeep


********** Rename 2016
/*
foreach x in $tokeep{
rename `x' `x'2016
}
*/

order HHINDID HHID_panel INDID_panel
sort HHINDID

save"$wave2-_ego", replace
****************************************
* END










****************************************
* PREPA 2020
****************************************
use"$wave3", clear
keep if egoid>0
egen HHINDID=concat(HHID_panel INDID_panel), p(/)
duplicates tag HHINDID, gen(tag)
tab tag
drop tag

*Merge
merge 1:1 HHID_panel INDID_panel using "panel", keepusing(panel)
drop if _merge==2
drop _merge
recode panel (.=0)

global tokeep age edulevel sex caste jatis name address villageid villageareaid username ///
covsick ///
curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination organized makeplans workhard appointmentontime putoffduties easilydistracted completeduties enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople talkative expressingthoughts workwithother understandotherfeeling trustingofother rudetoother toleratefaults forgiveother helpfulwithothers managestress nervous changemood feeldepressed easilyupset worryalot staycalm tryhard stickwithgoals goaftergoal finishwhatbegin finishtasks keepworking username
keep HHINDID HHID_panel INDID_panel panel egoid year $tokeep


********** Rename 2020
/*
foreach x in $tokeep{
rename `x' `x'2020
}
*/

order HHINDID HHID_panel INDID_panel
sort HHINDID

*Username
fre username
decode username, gen(username_str)
drop username
rename username_str username

save"$wave3-_ego", replace
****************************************
* END










****************************************
* Panel 2016 2020
****************************************
use"$wave2-_ego", clear

drop villageid_new_comments

append using "$wave3-_ego"
tab panel

order HHINDID HHID_panel INDID_panel year egoid name sex age jatis caste edulevel address villageid villageareaid villageid_new username panel

order dummydemonetisation demotrustneighborhood demotrustemployees_ego demotrustbank_ego demonetworkpeoplehelping_ego demonetworkhelpkinmember_ego demogeneralperception demogoodexpectations demobadexpectations covsick, after(panel)

order curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts  ///
workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers ///
managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm ///
tryhard  stickwithgoals   goaftergoal finishwhatbegin finishtasks  keepworking, after(covsick)

sort HHID_panel INDID_panel year

*Clean year
clonevar time=year
recode time (2016=1) (2020=2)
label define time 1"2016" 2"2020"
label values time time


*Clean username 2016
fre username
replace username="Antoni" if username=="1"
replace username="Antoni - Vivek Radja" if username=="1 2"
replace username="Vivek Radja" if username=="2"
replace username="Vivek Radja - Mayan" if username=="2 5"
replace username="Vivek Radja - Raja Annamalai" if username=="2 6"
replace username="Kumaresh" if username=="3"
replace username="Kumaresh - Sithanantham" if username=="3 4"
replace username="Kumaresh - Raja Annamalai" if username=="3 6"
replace username="Sithanantham" if username=="4"
replace username="Sithanantham - Raja Annamalai" if username=="4 6"
replace username="Mayan" if username=="5"
replace username="Mayan - Raja Annamalai" if username=="5 6"
replace username="Raja Annamalai" if username=="6"
replace username="Raja Annamalai - Pazhani" if username=="6 7"
replace username="Pazhani" if username=="7"


save"panel_stab_v1", replace
****************************************
* END
