cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
02/05/21
-----
TITLE: Network
-------------------------
*/











****************************************
* LOOP pour prendre les long sn
****************************************
foreach dbv in NEEMSIS2_APRIL NEEMSIS2_DEC NEEMSIS2_DECEMBER NEEMSIS2_FEB NEEMSIS2_FEBRUARY NEEMSOS2_LAST NEEMSIS2_NEW_APRIL {

clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA"




global preamble "`dbv'"
*global preamble "NEEMSIS2_APRIL"

********** AUTO CALCULATION
set obs 1
gen _nbchar=strlen("$preamble")+2
global nbcharact = _nbchar
drop _nbchar
dis $nbcharact

global subdirectory ="$preamble"
global subpath= "$directory" + "\" + "$preamble"

********** Ego cleaning
cd"$directory"
clear all
filelist, dir("$subdirectory") pattern(*.dta)
split filename, p(-)
forvalues i=1(1)50{
capture confirm v filename`i'
if !_rc {
global filenamemax "`i'"
}
}
gen ok=0
replace ok=1 if substr(filename2,1,5)=="_3ego"
replace ok=1 if substr(filename2,1,5)=="_2ego"
replace ok=1 if substr(filename2,1,3)=="ego"

replace ok=1 if substr(filename2,1,5)=="_3snr"
replace ok=1 if substr(filename2,1,5)=="_2snr"
replace ok=1 if substr(filename2,1,3)=="snr"
keep if ok==1
*Virer bis or full
clonevar filename33=filename3
replace filename3=filename4 if filename33=="_2ego2questionnairebis"
replace filename4=filename5 if filename33=="_2ego2questionnairebis"
replace filename5=filename6 if filename33=="_2ego2questionnairebis"
capture confirme v filename7
if _rc==0{
replace filename6=filename7 if filename33=="_2ego2questionnairebis"
replace filename7="" if filename33=="_2ego2questionnairebis"
}

replace filename3=filename4 if filename33=="ego2questionnairefull"
replace filename4=filename5 if filename33=="ego2questionnairefull"
replace filename5=filename6 if filename33=="ego2questionnairefull"
capture confirme v filename7
if _rc==0{
replace filename6=filename7 if filename33=="ego2questionnairefull"
replace filename7="" if filename33=="ego2questionnairefull"
}
*Name
gen name=""
forvalues i=1(1)$filenamemax{
replace name=filename`i' if substr(filename`i',strlen(filename`i')-3,4)==".dta"
}
*Egoid
sort name
gen egoid=1
replace egoid=2 if substr(name,1,2)=="_2"
replace egoid=3 if substr(name,1,2)=="_3"
tab egoid

*Prepa pour nouveau nom
forvalues i=2(1)$filenamemax{
replace filename`i'="" if substr(filename`i',strlen(filename`i')-3,4)==".dta"
replace filename`i'="-"+filename`i'
replace filename`i'="" if filename`i'=="-"
}
replace name="-"+name

*Construction du nouveau nom de la bdd
replace filename6="" if filename6==filename5
replace filename5="" if filename5==filename4
egen newname=concat(filename1 filename2 filename3 filename4 filename5 filename6 name)
replace newname=substr(newname,1,strlen(newname)-1) if substr(newname,strlen(newname),1)=="-"
replace newname=substr(newname,1,strlen(newname)-1) if substr(newname,strlen(newname),1)=="-"
replace newname=substr(newname,1,strlen(newname)-1) if substr(newname,strlen(newname),1)=="-"

*Implement
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local fold = dirname + "\" + filename
	local fnew = newname
	local e = egoid	
	use "`fold'", clear
	capture confirm v egoid
	if _rc==0{
	}
	else{
	gen egoid=`e'
	foreach x of varlist _all {
	local varnewname=substr("`x'",3,strlen("`x'"))
	if substr("`x'",1,2)=="_2" rename `x' `varnewname'
	if substr("`x'",1,2)=="_3" rename `x' `varnewname'
	}
	}
	capture confirm v parent_key
	if _rc==0{
	order parent_key egoid, first
	drop if parent_key==""
	}
	tempfile save`i'
	save "$directory\APPEND\ego_raw\\`fnew'", replace
}
}
****************************************
* END










****************************************
* DROP RANDOM
****************************************
cd"$directory"
clear all
filelist, dir("$directory\APPEND\ego_raw") pattern(*.dta)
split filename, p(-)
gen name=""
forvalues i=1(1)7{
replace name=filename`i' if substr(filename`i',strlen(filename`i')-3,4)==".dta"
}
replace name=substr(name,3,strlen(name)) if substr(name,1,2)=="_2"
replace name=substr(name,3,strlen(name)) if substr(name,1,2)=="_3"
sort name
keep if substr(name,1,6)=="random" | filename1=="NEEMSIS_APPEND"
*Implement
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = dirname + "\" + filename
	erase "`f'"
	tempfile save`i'
}
****************************************
* END


















****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
cd "$directory\ego_raw"

********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

****************************************
* END










****************************************
* EGOID
****************************************
filelist, dir("$directory\ego_raw") pattern(*.dta)
split filename, p(-)
*Generic name more complete
egen filenamecomp=concat(filename2 filename3 filename4 filename5 filename6 filename7), p(-)
replace filenamecomp=substr(filenamecomp,1,strlen(filenamecomp)-1) if substr(filenamecomp,strlen(filenamecomp),1)=="-"
replace filenamecomp=substr(filenamecomp,1,strlen(filenamecomp)-1) if substr(filenamecomp,strlen(filenamecomp),1)=="-"
replace filenamecomp=substr(filenamecomp,1,strlen(filenamecomp)-1) if substr(filenamecomp,strlen(filenamecomp),1)=="-"
replace filenamecomp=substr(filenamecomp,1,strlen(filenamecomp)-1) if substr(filenamecomp,strlen(filenamecomp),1)=="-"
replace filenamecomp=substr(filenamecomp,1,strlen(filenamecomp)-1) if substr(filenamecomp,strlen(filenamecomp),1)=="-"
replace filenamecomp=substr(filenamecomp,1,strlen(filenamecomp)-1) if substr(filenamecomp,strlen(filenamecomp),1)=="-"

duplicates drop filenamecomp, force
gen attheline="///"
list filenamecomp attheline, clean noobs

********** CREATION OF ALL FILES (forauto seulement) IN _temp FOLDER
global genericname	///
_3ego1questionnaire-_3individualemployment-_3characteristicsmainjob-_3indwagejob-_3wagejobpaymentinkindgroup.dta	///	 
_3ego1questionnaire-_3individualemployment-_3covoccupationfield.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3covsntypehelpreceivedgroup.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3sncloserelouthhgroup.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3sncloserelouthhid.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snhelpemergencygroup.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snhelpemergencyid.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3sntalkthemostgroup.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3sntalkthemostid.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3networkresources-_3contactgroup.dta	///	 
ego1questionnaire-individualemployment-characteristicsmainjob-indwagejob-wagejobpaymentinkindgroup.dta	///	 
ego1questionnaire-individualemployment-characteristicsmainjob-informalsocialcapitalselfemp-snrecruitworkergroup.dta	///	 
ego1questionnaire-individualemployment-characteristicsmainjob-informalsocialcapitalselfemp-snrecruitworkerid.dta	///	 
ego1questionnaire-individualemployment-covoccupationfieldlist.dta	///	 
ego1questionnaire-socialnetworks-formalsocialcapital.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-covsntypehelpgivengroup.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-covsntypehelpreceivedgroup.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sncloserelouthhgroup.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sncloserelouthhid.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindcurrentjobgroup.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindcurrentjobid.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snhelpemergencygroup.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snhelpemergencyid.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sntalkthemostgroup.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-sntalkthemostid.dta	///	 
ego1questionnaire-socialnetworks-networkresources-contactgroup.dta	///	 
ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2indwagejob-_2wagejobpaymentinkindgroup.dta	///	 
ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2informalsocialcapitalselfemp-_2snrecruitworkergroup.dta	///	 
ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2informalsocialcapitalselfemp-_2snrecruitworkerid.dta	///	 
ego2questionnaire-_2individualemployment-_2covoccupationfieldlist.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsnhelpreceivedgroup.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsnhelpreceivedid.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsntypehelpreceivedgroup.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2sncloserelouthhgroup.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2sncloserelouthhid.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snfindcurrentjobgroup.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snfindcurrentjobid.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snhelpemergencygroup.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snhelpemergencyid.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2sntalkthemostgroup.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2sntalkthemostid.dta	///	 
ego2questionnaire-_2socialnetworks-_2networkresources-_2contactgroup.dta	///	 
ego2questionnaire-randomizationego2-random_1825-show_draws.dta	///	 
ego2questionnaire-randomizationego2-random_2635-show_draws_2.dta	///	 
ego2questionnaire-randomizationego2-random_36-show_draws_3.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecommendforjobgroup.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecommendforjobid.dta	///	 
_2snrecommendassogroup.dta	///	 
_2snrecommendassoid.dta	///	 
_3ego1questionnaire-_3individualemployment-_3characteristicsmainjob-_3indselfemployment-_3informalsocialcapitalselfemp-_3snrecruitworkergroup.dta	///	 
_3ego1questionnaire-_3individualemployment-_3characteristicsmainjob-_3indselfemployment-_3informalsocialcapitalselfemp-_3snrecruitworkerid.dta	///	 
_3ego1questionnaire-_3individualemployment-_3characteristicsmainjob-_3indselfemployment-_3sourceinvestment-_3businessloandetails.dta	///	 
_3ego1questionnaire-_3individualemployment-_3mainoccupschedule-_3indoccupmonths.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3formalsocialcapital.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3covsnhelpreceivedgroup.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3covsnhelpreceivedid.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3covsntypehelpgivengroup.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snfindcurrentjobgroup.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snfindcurrentjobid.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snfindjobgroup.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snfindjobid.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snrecommendforjobgroup.dta	///	 
_3ego1questionnaire-_3socialnetworks-_3informalsocialcapital-_3informalsocialcapitalwageworker-_3snrecommendforjobid.dta	///	 
ego1questionnaire-individualemployment-characteristicsmainjob-indselfemployment-informalsocialcapitalselfemp-snrecruitworkergroup.dta	///	 
ego1questionnaire-individualemployment-characteristicsmainjob-indselfemployment-informalsocialcapitalselfemp-snrecruitworkerid.dta	///	 
ego1questionnaire-individualemployment-characteristicsmainjob-indselfemployment-sourceinvestment-businessloandetails.dta	///	 
ego1questionnaire-individualemployment-mainoccupschedule-indoccupmonths.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-covsnhelpgivengroup.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-covsnhelpgivenid.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-covsnhelpreceivedgroup.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-covsnhelpreceivedid.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindjobgroup.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snfindjobid.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecojobsuccessgroup.dta	///	 
ego1questionnaire-socialnetworks-informalsocialcapital-informalsocialcapitalwageworker-snrecojobsuccessid.dta	///	 
ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2indselfemployment-_2businesspaymentinkindgroup.dta	///	 
ego2questionnaire-_2individualemployment-_2characteristicsmainjob-_2indselfemployment-_2sourceinvestment-_2businessloandetails.dta	///	 
ego2questionnaire-_2individualemployment-_2mainoccupschedule-_2indoccupmonths.dta	///	 
ego2questionnaire-_2socialnetworks-_2formalsocialcapital.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsnhelpgivengroup.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsnhelpgivenid.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsntypehelpgivengroup.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snfindjobgroup.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snfindjobid.dta	///	 
snrecommendassogroup.dta	///	 
snrecommendassoid.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snrecojobsuccessgroup.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snrecojobsuccessid.dta	///	 
_3snrecommendassogroup.dta	///	 
_3snrecommendassoid.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snrecommendforjobgroup.dta	///	 
ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2informalsocialcapitalwageworker-_2snrecommendforjobid.dta	/// 


foreach k in $genericname{
clear all
set obs 1
gen forauto="" in 1
save"$directory/_egotemp/NEEMSIS2_LAST-`k'", replace
save"$directory/_egotemp/NEEMSIS2_DECEMBER-`k'", replace
save"$directory/_egotemp/NEEMSIS2_DEC-`k'", replace
save"$directory/_egotemp/NEEMSIS2_FEB-`k'", replace
save"$directory/_egotemp/NEEMSIS2_FEBRUARY-`k'", replace
save"$directory/_egotemp/NEEMSIS2_NEW_APRIL-`k'", replace
save"$directory/_egotemp/NEEMSIS2_APRIL-`k'", replace

}

********** INSTRUCTIONS:
/*
COPIER ET REMPLACER LES FICHIERS DE EGO RAW VERS EGO TEMP
*/


********** APPEND PAR VERSION
foreach k in $genericname{
use "$directory\_egotemp\NEEMSIS2_LAST-`k'", clear
append using "$directory\_egotemp\NEEMSIS2_DECEMBER-`k'", force
append using "$directory\_egotemp\NEEMSIS2_DEC-`k'", force
append using "$directory\_egotemp\NEEMSIS2_FEB-`k'", force
append using "$directory\_egotemp\NEEMSIS2_FEBRUARY-`k'", force
append using "$directory\_egotemp\NEEMSIS2_NEW_APRIL-`k'", force
append using "$directory\_egotemp\NEEMSIS2_APRIL-`k'", force
save "$directory/_egotemp/inprogress/NEEMSIS_APPEND-`k'", replace
}

********** Merger les égos
filelist, dir("$directory\_egotemp\inprogress") pattern(*.dta)
split filename, p(-)
*Identify generic name
forvalues i=1(1)50{
capture confirm v filename`i'
if !_rc {
global filenamemax "`i'"
}
}
dis $filenamemax
gen name=""
forvalues i=1(1)$filenamemax{
replace name=filename`i' if substr(filename`i',strlen(filename`i')-3,4)==".dta"
}
sort name
*New var name for ego2 and ego3
clonevar name2=name
replace name2=substr(name2,3,strlen(name2)) if substr(name2,1,2)=="_2"
replace name2=substr(name2,3,strlen(name2)) if substr(name2,1,2)=="_3"
sort name2
forvalues i=3(1)7{
replace filename`i'=substr(filename`i',3,strlen(filename`i')) if substr(filename`i',1,2)=="_2"
replace filename`i'=substr(filename`i',3,strlen(filename`i')) if substr(filename`i',1,2)=="_3"
}
*Remove .dta for concat (new name)
forvalues i=1(1)7{
replace filename`i'="" if substr(filename`i',strlen(filename`i')-3,4)==".dta"
}
*Drop show and random
drop if substr(name2,1,4)=="show"
drop if substr(name2,1,6)=="random"
*Add -
forvalues i=3(1)5{
replace filename`i'="-"+filename`i'
replace filename`i'="" if filename`i'=="-"
}
replace name2="-"+name2
*How much per name?
bysort name2: gen n=_n
tab n
*New name
gen filecat2="NEEMSIS_APPEND-ego123questionnaire"
egen filecat=concat(filecat2 filename3 filename4 filename5 filename6 name2)
replace filecat=substr(filecat,1,strlen(filecat)-1) if substr(filecat,strlen(filecat),1)=="-"
replace filecat=substr(filecat,1,strlen(filecat)-1) if substr(filecat,strlen(filecat),1)=="-"
drop filecat2
split filecat, p(.)
drop filecat filecat2
rename filecat1 filecat

encode filecat, gen(filecat_encode)

*Cleaning
drop filename1 filename2 filename3 filename4 filename5 filename6 filename7 name name2 n filecat fsize
tab filecat_encode
*Only one var
split filename, p(.)
drop filename filename2
rename filename1 filename
egen onevar=concat(dirname filename), p(\)
drop dirname filename
*Reshape
bysort filecat_encode: gen n=_n
tab n
reshape wide onevar, i(filecat_encode) j(n)

*Decode filecat for generic name
decode filecat_encode, gen(filecat)
drop filecat_encode
order filecat, first

*Append
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local fc = filecat
	local f1 = onevar1
	local f2 = onevar2
	local f3 = onevar3
	*local f4 = onevar4
	use "`f1'.dta", clear	
	*First append
	capture confirm file "`f2'.dta"
	if _rc==0{
	append using "`f2'.dta"
	}
	else{
	save "$directory\_egotemp\inprogress\\`fc'.dta", replace
	}
	*Second append	
	capture confirm file "`f3'.dta"
	if _rc==0{
	append using "`f3'.dta"
	}
	else{
	save "$directory\_egotemp\inprogress\\`fc'.dta", replace
	}
	*Third append
	/*
	capture confirm file "`f4'.dta"
	if _rc==0{
	append using "`f4'.dta"
	}
	else{
	save "$directory\_egotemp\inprogress\\`fc'.dta", replace
	}
	*/
	tempfile save`i'
	save "$directory\_egotemp\inprogress\\`fc'.dta", replace
}
****************************************
* END











****************************************
* CLEANING
****************************************
********** Drop duplicates
filelist, dir("$directory\_egotemp") pattern(*.dta)
split filename, p(-)
drop if filename2=="ego123questionnaire"
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f= dirname + "/" + filename
	erase "`f'"	
	tempfile save`i'
}



********** Remove blank and forauto
filelist, dir("$directory\_egotemp\inprogress") pattern(*.dta)
split filename, p(.)
drop filename2
rename filename1 filenamenew
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f=dirname + "/" + filename
	local f2=filenamenew + "_v2.dta"
	use"`f'", replace
	capture confirm v parent_key
	if _rc==0{
	drop if parent_key==""
	}
	*save "$directory\CLEAN\\`f2'", replace
	*tempfile save`i'
	*}
	
	capture confirm v forauto
	if _rc==0{
	drop forauto
	}
	save "$directory\CLEAN\\`f2'", replace
	tempfile save`i'
}
****************************************
* END





/*
****************************************
* CLEANING
****************************************
use"$directory\APPEND\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-formalsocialcapital_v2.dta", clear
