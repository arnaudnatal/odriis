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
global data = "RUME-HH"

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

fre education
*Edulevel
gen edulevel=.
replace edulevel=0 if education==0
replace edulevel=1 if education==1
replace edulevel=2 if education==2
replace edulevel=3 if education==3
replace edulevel=3 if education==4
replace edulevel=4 if education==5
replace edulevel=5 if education==6
replace edulevel=5 if education==7
replace edulevel=5 if education==8

tab education

label define edulevel 0"Below primary" 1"Primary completed" 2"High school (8th-10th)" 3"HSC/Diploma (11th-12th)" 4"Bachelors (13th-15th)" 5"Post graduate (15th and more)", replace
label values edulevel edulevel
tab edulevel

keep HHID2010 INDID2010 edulevel

save"outcomes\RUME-education", replace
****************************************
* END










****************************************
* Education UNESCO
***************************************
*Cécile Mouchel
/*
The six categories of educational attainment  used in KILM 14 are conceptually based on the ten levels of the International Standard  Classification of Education (ISCED).
The ISCED  was designed by the United Nations Educational, Scientific and Cultural Organization (UNESCO) in the early 1970s to serve as an instrument suitable for assembling, compiling and presenting comparable indicators and statistics of education, both within countries and internationally.

Key Indicators of the Labour Market, 9th edition.
International Labour Office.
Geneva, Swiss
2016
ISBN: 978-92-2-030122-7
*/
use"$data", clear

label define education 0"No education" 1"Pre-primary level" 2"Primary level" 3"Secondary level" 4"Tertiary level"

* Méthode 1: NEEMSIS-1 et NEEMSIS-2
gen educ_attainment=.
replace educ_attainment=0 if education==0
replace educ_attainment=2 if education==1
replace educ_attainment=3 if education==2
replace educ_attainment=3 if education==3
replace educ_attainment=4 if education>=4
label values educ_attainment education


* Méthode 2: RUME, NEEMSIS-1 et NEEMSIS-2
gen educ_attainment2=educ_attainment
replace educ_attainment2=0 if educ_attainment==1
label values educ_attainment2 education

ta educ_attainment2

keep HHID2010 INDID2010 educ_attainment educ_attainment2

save"outcomes\RUME-education_kilm", replace
****************************************
* END
