*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Education construction
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox\RUME-NEEMSIS\Data\Construction"
cd"$directory"

********** Database names
global data = "NEEMSIS1-HH"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020



****************************************
* Education
***************************************
use"$data", clear

gen edulevel=.
replace edulevel = 0 if  everattendedschool == 0
replace edulevel = 0 if classcompleted < 5 & classcompleted != .
replace edulevel= 1 if classcompleted>=5 & classcompleted != .
replace edulevel= 2 if classcompleted>=8 & classcompleted != .
replace edulevel= 3 if classcompleted>=11 & classcompleted != .
replace edulevel= 4 if classcompleted>=15  & classcompleted != .
replace edulevel= 5 if classcompleted>=16  & classcompleted != . //Attention! I recoded here cause otherwise all missing are in 5 (Anne, 20/06/17)
label define edulevel 0 "Below primary" 1 "Primary completed", modify
label define edulevel 2 "High school (8th-10th)", modify
label define edulevel 3 "HSC/Diploma (11th-12th)", modify
label define edulevel 4 "Bachelors (13th-15th)", modify
label define edulevel 5 "Post graduate (15th and more)", modify
label values edulevel edulevel
tab edulevel, m
tab edulevel livinghome, m
list INDID2016 age if edulevel==. & livinghome==1, clean noobs
recode edulevel (.=0)
tab edulevel

keep HHID2016 INDID2016 edulevel

save"outcomes\NEEMSIS1-education", replace
****************************************
* END







****************************************
* Education de l'UNESCO
***************************************
use"$data", clear

label define education 0"No education" 1"Pre-primary level" 2"Primary level" 3"Secondary level" 4"Tertiary level"

* Méthode 1: NEEMSIS-1 et NEEMSIS-2
gen educ_attainment=1 if classcompleted>=1&classcompleted<5
replace educ_attainment=2 if classcompleted>=5&classcompleted<10
replace educ_attainment=3 if classcompleted>=10&classcompleted<11
replace educ_attainment=4 if classcompleted>=11
replace educ_attainment=0 if classcompleted==.
label values educ_attainment education

* Méthode 2: RUME, NEEMSIS-1 et NEEMSIS-2
gen educ_attainment2=educ_attainment
replace educ_attainment2=0 if educ_attainment==1
label values educ_attainment2 education

keep HHID2016 INDID2016 educ_attainment educ_attainment2

save"outcomes\NEEMSIS1-education_kilm", replace
****************************************
* END

