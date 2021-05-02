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
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
cd "$directory\CLEAN"

********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

****************************************
* END





****************************************
* EGOID
****************************************
filelist, dir("$directory\rename") pattern(*.dta)
split filename, p(-)
*Keep ego
gen ok=0
replace ok=1 if substr(filename2,1,3)=="ego"
replace ok=1 if substr(filename2,1,5)=="_3ego"
replace ok=1 if substr(filename2,1,5)=="_3ran"

keep if ok==1
drop ok
*Keep end of the name
gen name=""
forvalues i=1(1)7{
replace name=filename`i' if substr(filename`i',strlen(filename`i')-3,4)==".dta"
}
*Drop random and show
gen todrop=0
replace todrop=1 if substr(name,1,4)=="show"
replace todrop=2 if substr(name,1,6)=="random"
replace todrop=3 if substr(name,1,6)=="_3show"
replace todrop=3 if substr(name,1,8)=="_3random"
sort todrop

foreach x in NEEMSIS_APPEND-ego2questionnaire-randomizationego2-random_1825-show_draws.dta NEEMSIS_APPEND-ego2questionnaire-randomizationego2-randomizationego2full-random_2635-show_draws_2.dta NEEMSIS_APPEND-ego2questionnaire-randomizationego2-randomizationego2full-random_36-show_draws_3.dta NEEMSIS_APPEND-ego2questionnaire-randomizationego2-randomizationego2full-random_1825-show_draws.dta NEEMSIS_APPEND-ego2questionnaire-randomizationego2-random_36-show_draws_3.dta NEEMSIS_APPEND-ego2questionnaire-randomizationego2-random_2635-show_draws_2.dta NEEMSIS_APPEND-ego2questionnaire-randomizationego2-random_2635-random_draws_2.dta NEEMSIS_APPEND-ego2questionnaire-randomizationego2-random_1825-random_draws.dta NEEMSIS_APPEND-ego2questionnaire-randomizationego2-randomizationego2full-random_2635-random_draws_2.dta NEEMSIS_APPEND-ego2questionnaire-randomizationego2-randomizationego2full-random_1825-random_draws.dta NEEMSIS_APPEND-ego2questionnaire-randomizationego2-random_36-random_draws_3.dta NEEMSIS_APPEND-ego2questionnaire-randomizationego2-randomizationego2full-random_36-random_draws_3.dta NEEMSIS_APPEND-_3random_1825-_3show_draws.dta NEEMSIS_APPEND-_3random_2635-_3random_draws_2.dta NEEMSIS_APPEND-_3random_2635-_3show_draws_2.dta NEEMSIS_APPEND-_3random_36-_3random_draws_3.dta NEEMSIS_APPEND-_3random_36-_3show_draws_3.dta {
*set trace on
capture confirm file "`x'"
if _rc==0{
erase "`x'"
}
}

*Clean var
drop filename1 filename2 filename3 filename4 filename5 filename6 filename7
*Egoid
sort name
gen egoid=1
replace egoid=2 if substr(name,1,2)=="_2"
replace egoid=3 if substr(name,1,2)=="_3"
tab egoid
*New name
split filename, p(.)
drop filename2
drop filename
rename filename1 filename
*Gen egoid
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = dirname + "\" + filename
	local s = filename
	local e = egoid	
	use "`f'", clear
	gen egoid=`e'
	foreach x of varlist _all {
	local newname=substr("`x'",3,strlen("`x'"))
	if substr("`x'",1,2)=="_2" rename `x' `newname'
	if substr("`x'",1,2)=="_3" rename `x' `newname'
	}
	tempfile save`i'
	save "`s'_v2.dta", replace
}
****************************************
* END













****************************************
* APPEND
****************************************
filelist, dir("$directory\CLEAN") pattern(*.dta)
split filename, p(-)
*Keep ego
gen ok=0
replace ok=1 if substr(filename2,1,3)=="ego" 
replace ok=1 if substr(filename2,1,5)=="_3ego"
replace ok=1 if substr(filename2,1,5)=="_3ran"
keep if ok==1
drop ok
*Keep v2
gen ok=0
replace ok=1 if substr(filename,strlen(filename)-6,7)=="_v2.dta"
keep if ok==1
drop ok
*Keep end of the name
gen name=""
forvalues i=1(1)7{
replace name=filename`i' if substr(filename`i',strlen(filename`i')-3,4)==".dta"
}
*New var name for ego2 and ego3
clonevar name2=name
replace name2=substr(name2,3,strlen(name2)) if substr(name2,1,2)=="_2"
replace name2=substr(name2,3,strlen(name2)) if substr(name2,1,2)=="_3"
sort name2

*Pb de ego2questionnairefull
clonevar filename33=filename3
sort name2
replace filename3=filename4 if filename33=="ego2questionnairefull"
replace filename4=filename5 if filename33=="ego2questionnairefull"
replace filename5=filename6 if filename33=="ego2questionnairefull"
replace filename6=filename7 if filename33=="ego2questionnairefull"

*Confirmation of group
forvalues i=4(1)5{
clonevar filename`i'_n=filename`i' 
replace filename`i'_n=substr(filename`i'_n,3,strlen(filename`i'_n)) if substr(filename`i'_n,1,2)=="_2"
replace filename`i'_n=substr(filename`i'_n,3,strlen(filename`i'_n)) if substr(filename`i'_n,1,2)=="_3"
}
gen filecat2="NEEMSIS_APPEND-ego123questionnaire"
egen filecat=concat(filecat2 filename4_n filename5_n name2), p(-)
replace filecat=substr(filecat,1,strlen(filecat)-1) if substr(filecat,strlen(filecat),1)=="-"
replace filecat=substr(filecat,1,strlen(filecat)-1) if substr(filecat,strlen(filecat),1)=="-"
drop filecat2
split filecat, p(.)
drop filecat filecat2
rename filecat1 filecat

encode filecat, gen(filecat_encode)

/*
*File category
egen filecat=concat(filename44 filename55 name2), p(//)
encode filecat, gen(filecat_encode)
*/

*Egoid
sort name
gen egoid=1
replace egoid=2 if substr(name,1,2)=="_2"
replace egoid=3 if substr(name,1,2)=="_3"
tab egoid
sort filecat_encode egoid
*Check
bysort filecat_encode: gen n=_n
bysort filecat_encode: egen nmax=max(n)
tab nmax
drop nmax n
drop filename1 filename2 filename3 filename4 filename5 filename6 filename7 name name2 filecat fsize
drop filename4_n filename5_n
order filecat_encode egoid
sort filecat_encode egoid
*Only one var
split filename, p(.)
drop filename filename2
rename filename1 filename
egen onevar=concat(dirname filename), p(\)
drop dirname filename
*Reshape
drop filecat3 filename33 egoid
bysort filecat_encode: gen n=_n
reshape wide onevar, i(filecat_encode) j(n)

*File 1:
gen firstfile=""
replace firstfile=onevar4 if onevar4!=""
replace firstfile=onevar3 if onevar3!=""
replace firstfile=onevar2 if onevar2!=""
replace firstfile=onevar1 if onevar1!=""

replace onevar1="" if onevar1==firstfile
replace onevar2="" if onevar2==firstfile
replace onevar3="" if onevar3==firstfile
replace onevar4="" if onevar4==firstfile

*File 2:
gen secondfile=""
replace secondfile=onevar4 if onevar4!=""
replace secondfile=onevar3 if onevar3!=""
replace secondfile=onevar2 if onevar2!=""
replace secondfile=onevar1 if onevar1!=""

replace onevar1="" if onevar1==secondfile
replace onevar2="" if onevar2==secondfile
replace onevar3="" if onevar3==secondfile
replace onevar4="" if onevar4==secondfile

*File 3:
gen thirdfile=""
replace thirdfile=onevar4 if onevar4!=""
replace thirdfile=onevar3 if onevar3!=""
replace thirdfile=onevar2 if onevar2!=""
replace thirdfile=onevar1 if onevar1!=""

replace onevar1="" if onevar1==thirdfile
replace onevar2="" if onevar2==thirdfile
replace onevar3="" if onevar3==thirdfile
replace onevar4="" if onevar4==thirdfile

*File 4:
gen fourthfile=""
replace fourthfile=onevar4 if onevar4!=""
replace fourthfile=onevar3 if onevar3!=""
replace fourthfile=onevar2 if onevar2!=""
replace fourthfile=onevar1 if onevar1!=""

replace onevar1="" if onevar1==fourthfile
replace onevar2="" if onevar2==fourthfile
replace onevar3="" if onevar3==fourthfile
replace onevar4="" if onevar4==fourthfile


*Verif
tab1 onevar1 onevar1 onevar3 onevar4
drop onevar1 onevar2 onevar3 onevar4

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
	local f1 = firstfile
	local f2 = secondfile
	local f3 = thirdfile
	local f4 = fourthfile
	use "`f1'.dta", clear	
	*First append
	capture confirm file "`f2'.dta"
	if _rc==0{
	append using "`f2'.dta"
	}
	else{
	save "`fc'.dta", replace
	}
	*Second append	
	capture confirm file "`f3'.dta"
	if _rc==0{
	append using "`f3'.dta"
	}
	else{
	save "`fc'.dta", replace
	}
	*Third append
	capture confirm file "`f4'.dta"
	if _rc==0{
	append using "`f4'.dta"
	}
	else{
	save "`fc'.dta", replace
	}
	tempfile save`i'
	save "`fc'.dta", replace
}
****************************************
* END







****************************************
* CLEANING
****************************************
filelist, dir("$directory\CLEAN") pattern(*.dta)
split filename, p(-)
*Keep append files
keep if filename2=="ego123questionnaire"
drop filename1 filename2 filename3 filename4 filename5 filename6 filename7
split filename, p(_v)
drop filename2 filename
rename filename1 filename
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f= dirname + "/" + filename
	use "`f'_v2.dta", clear	
	drop setof* key
	capture confirm v forauto
	if _rc==0{
	drop forauto
	}
	order parent_key egoid, first
	drop if parent_key==""
	
	tempfile save`i'
	save "`f'_v3.dta", replace
}
****************************************







****************************************
* MERGING
****************************************
use"NEEMSIS2-HH_v15.dta", clear

setofcontactgroup
setofformalsocialcapital



*************************************
* END
