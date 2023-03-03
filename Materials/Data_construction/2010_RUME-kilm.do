*-------------------------
*Cécile Mouchel
*mouchel.cecille@gmail.com
*-----
*KILM
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
global occupations = "RUME-occupations"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020







****************************************
* KILM 14 - Educational attainment and illiteracy
***************************************
/*
The six categories of educational attainment  used in KILM 14 are conceptually based on the ten levels of the International Standard  Classification of Education (ISCED).
The ISCED  was designed by the United Nations Educational, Scientific and Cultural Organization (UNESCO) in the early 1970s to serve as an instrument suitable for assembling, compiling and presenting comparable indicators and statistics of education, both within countries and internationally.

Key Indicators of the Labour Market, 9th edition.
International Labour Office.
Geneva, Swiss
2016
ISBN: 978-92-2-030122-7
*/
use "RUME-HH.dta", clear

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

save"_temp/_temp_RUME-kilm", replace
****************************************
* END







****************************************
* KILM 1 - LFP
****************************************
use "RUME-HH.dta", clear


* Merge Kindofwork de la moc
preserve
use"outcomes/RUME-occupnew.dta", clear
keep if dummymainoccupation==1
keep HHID2010 INDID2010 kindofwork annualincome occupation profession sector occupationname
save"_temp/RUME_kow.dta", replace
restore
merge 1:1 HHID2010 INDID2010 using "_temp/RUME_kow.dta"
drop _merge


* Merge Edu
merge 1:1 HHID2010 INDID2010 using "_temp/_temp_RUME-kilm"
drop _merge



* Age
gen agecat=1 if age<15
replace agecat=2 if age>=15&age<25
replace agecat=3 if age>=25&age<35
replace agecat=4 if age>=35&age<45
replace agecat=5 if age>=45&age<55
replace agecat=6 if age>=55&age<65
replace agecat=7 if age>=65
label define agecat 1"Below 15" 2"15-24" 3"25-34" 4"35-44" 5"45-54" 6"55-64" 7"Above 65"
label values agecat agecat


* Working age
gen workingage=1 if age>=15
replace workingage=0 if workingage==.


* Création des catégories d'âge (II)
gen youth=.
replace youth=1 if agecat==2 & workingage==1
replace youth=0 if youth==. & workingage==1

* Employed
fre kindofwork
gen employed=.
replace employed=0 if dummyworkedpastyear==1 & workingage==1 & kindofwork==5
replace employed=0 if dummyworkedpastyear==1 & workingage==1 & kindofwork==9
replace employed=0 if dummyworkedpastyear==0 & workingage==1
replace employed=1 if dummyworkedpastyear==1 & workingage==1 & kindofwork==1
replace employed=1 if dummyworkedpastyear==1 & workingage==1 & kindofwork==2
replace employed=1 if dummyworkedpastyear==1 & workingage==1 & kindofwork==3
replace employed=1 if dummyworkedpastyear==1 & workingage==1 & kindofwork==4
replace employed=1 if dummyworkedpastyear==1 & workingage==1 & kindofwork==6
replace employed=1 if dummyworkedpastyear==1 & workingage==1 & kindofwork==8

decode kindofwork, gen(str_kindofwork)
keep HHID2010 INDID2010 occupation kindofwork str_kindofwork profession sector occupationname educ_attainment educ_attainment2 agecat workingage youth employed 

*** Stat
ta kindofwork employed

save"_temp/_temp_RUME-kilm_v2.dta", replace
****************************************
* END












****************************************
* KILM 3 - Status in employment
****************************************
use "RUME-HH.dta", clear

* Merge Kindofwork de la moc
merge 1:1 HHID2010 INDID2010 using "_temp/_temp_RUME-kilm_v2.dta"
drop _merge
ta employed

* Emploi salarié NEEMSIS
gen employee=.
replace employee=0 if employed==1 & kindofwork==1
replace employee=0 if employed==1 & kindofwork==5
replace employee=0 if employed==1 & kindofwork==8
replace employee=1 if employed==1 & kindofwork==2
replace employee=1 if employed==1 & kindofwork==3
replace employee=1 if employed==1 & kindofwork==4
replace employee=1 if employed==1 & kindofwork==6
replace employee=1 if employed==1 & kindofwork==7


* Auto-entrepreneur ou employeur
gen selfemployed=.
replace selfemployed=0 if employed==1 & kindofwork==2 
replace selfemployed=0 if employed==1 & kindofwork==3
replace selfemployed=0 if employed==1 & kindofwork==4 
replace selfemployed=0 if employed==1 & kindofwork==5
replace selfemployed=0 if employed==1 & kindofwork==6 
replace selfemployed=0 if employed==1 & kindofwork==7
replace selfemployed=1 if employed==1 & kindofwork==1 
replace selfemployed=1 if employed==1 & kindofwork==8


***
keep HHID2010 INDID2010 occupation kindofwork str_kindofwork profession sector occupationname educ_attainment educ_attainment2 agecat workingage youth employed employee selfemployed


save"_temp/_temp_RUME-kilm_v3.dta", replace
****************************************
* END









****************************************
* KILM 4 - Employment per sector
****************************************
use "RUME-HH.dta", clear

* Merge Kindofwork de la moc
merge 1:1 HHID2010 INDID2010 using "_temp/_temp_RUME-kilm_v3.dta"
drop _merge
ta employed

rename profession profession_mainoccup
rename occupationname occupationname_mainoccup
rename sector sector_mainoccup

* Les dernières corrections sur les variables profession et secteur 
replace profession_mainoccup=92 if occupationname_mainoccup=="Sweet baking master"
replace profession_mainoccup=31 if occupationname_mainoccup=="88"
replace profession_mainoccup=23 if occupationname_mainoccup=="Thari"
replace profession_mainoccup=901 if occupationname_mainoccup=="Cashew company"
replace profession_mainoccup=901 if occupationname_mainoccup=="Cashew nut company"
replace profession_mainoccup=43 if occupationname_mainoccup=="Salaried work in Mascut (abroad)"
replace profession_mainoccup=43 if occupationname_mainoccup=="Maintenance in IT company Chennai"
replace profession_mainoccup=26 if occupationname_mainoccup=="Water company private"
replace profession_mainoccup=26 if occupationname_mainoccup=="Tank operator"
replace profession_mainoccup=33 if occupationname_mainoccup=="Self employee"
replace profession_mainoccup=33 if occupationname_mainoccup=="Self employed"
replace profession_mainoccup=43 if occupationname_mainoccup=="Private company"
replace profession_mainoccup=41 if occupationname_mainoccup=="Tution centre"
replace profession_mainoccup=33 if occupationname_mainoccup=="Eb work"
replace profession_mainoccup=27 if occupationname_mainoccup=="Cycles services  shop"
replace profession_mainoccup=26 if occupationname_mainoccup=="Wiring system work at panruti"
replace profession_mainoccup=26 if occupationname_mainoccup=="Sanitary worker"
replace profession_mainoccup=901 if occupationname_mainoccup=="Cashew nuts company worker"
replace profession_mainoccup=33 if occupationname_mainoccup=="Aasari"
replace profession_mainoccup=85 if occupationname_mainoccup=="TV service center in own"
replace profession_mainoccup=31 if occupationname_mainoccup=="Ford company, Sriperumbudur, Chennai"
replace profession_mainoccup=32 if occupationname_mainoccup=="Doll making assistant"
replace profession_mainoccup=33 if occupationname_mainoccup=="Self employed own work"

replace sector_mainoccup= 1 if profession_mainoccup==11
replace sector_mainoccup= 2 if profession_mainoccup>11 & profession_mainoccup<20
replace sector_mainoccup= 3 if profession_mainoccup>20 & profession_mainoccup<40
replace sector_mainoccup= 4 if profession_mainoccup>40 & profession_mainoccup<50
replace sector_mainoccup= 5 if profession_mainoccup>50 & profession_mainoccup<60
replace sector_mainoccup= 6 if profession_mainoccup>60 & profession_mainoccup<70
replace sector_mainoccup= 7 if profession_mainoccup>70 & profession_mainoccup<80
replace sector_mainoccup= 8 if profession_mainoccup>80 & profession_mainoccup<90
replace sector_mainoccup= 9 if profession_mainoccup>90 & profession_mainoccup<100
replace sector_mainoccup= 10 if profession_mainoccup>100 & profession_mainoccup<110
replace sector_mainoccup= 11 if profession_mainoccup>110 & profession_mainoccup<120


********** Les catégories CITI(Révision 2008) de l'OIT
gen sector_kilm4=.
replace sector_kilm4=1 if sector_mainoccup==1|sector_mainoccup==2|profession_mainoccup==907
replace sector_kilm4=2 if profession_mainoccup==23|profession_mainoccup==24|profession_mainoccup==25|profession_mainoccup==27|profession_mainoccup==29|profession_mainoccup==30|profession_mainoccup==32|profession_mainoccup==52|profession_mainoccup==33|profession_mainoccup>=901&profession_mainoccup<907
replace sector_kilm4=3 if profession_mainoccup==22|profession_mainoccup==42|profession_mainoccup==43
replace sector_kilm4=4 if profession_mainoccup==26
replace sector_kilm4=5 if profession_mainoccup==28|profession_mainoccup==46|profession_mainoccup==47|profession_mainoccup==61|profession_mainoccup==71|profession_mainoccup==72|profession_mainoccup==73|profession_mainoccup>=81&profession_mainoccup<=97|profession_mainoccup==31
replace sector_kilm4=6 if profession_mainoccup==44|profession_mainoccup==45|profession_mainoccup==51|profession_mainoccup==101|profession_mainoccup==102|profession_mainoccup==111|profession_mainoccup==41|profession_mainoccup==999
label def sector_kilm4 1"Agriculture" 2"Fabrication" 3"Construction" 4"Mines et carrières" 5"Services marchands" 6"Services non-marchands"
label val sector_kilm4 sector_kilm4


********** Trois secteurs
* Secteur agricole
gen agri=1 if sector_kilm4==1&employed==1
replace agri=0 if agri!=1&employed==1
* Secteur industriel
gen industry=1 if sector_kilm4==2&employed==1|sector_kilm4==3&employed==1|sector_kilm4==4&employed==1
replace industry=0 if industry!=1&employed==1
* Secteurs des services
gen services=1 if sector_kilm4==5&employed==1|sector_kilm4==6&employed==1
replace services=0 if services!=1&employed==1
gen sector_kilm4_V2=1 if agri==1&employed==1
replace sector_kilm4_V2=2 if industry==1&employed==1
replace sector_kilm4_V2=3 if services==1&employed==1
replace sector_kilm4_V2=0 if sector_kilm4_V2==.&employed==1
label define sector_kilm4_V2 1"Agriculture" 2"Industry" 3"Services"
label val sector_kilm4_V2 sector_kilm4_V2


***
keep HHID2010 INDID2010 occupation kindofwork str_kindofwork profession_mainoccup sector_mainoccup occupationname_mainoccup educ_attainment educ_attainment2 agecat workingage youth employed employee selfemployed sector_kilm4 agri industry services sector_kilm4_V2

save"_temp/_temp_RUME-kilm_v4.dta", replace
****************************************
* END








****************************************
* KILM 5 - Employment by profession
****************************************
use "RUME-HH.dta", clear

* Merge Kindofwork de la moc
merge 1:1 HHID2010 INDID2010 using "_temp/_temp_RUME-kilm_v4.dta"
drop _merge
ta employed

*
gen kilm5=.
replace kilm5=6 if profession_mainoccup==11
replace kilm5=6 if profession_mainoccup==12 & educ_attainment2>2
replace kilm5=9 if profession_mainoccup==12 & educ_attainment2<=2
replace kilm5=6 if profession_mainoccup==13 & educ_attainment2>2
replace kilm5=9 if profession_mainoccup==13 & educ_attainment2<=2
replace kilm5=6 if profession_mainoccup==14 & educ_attainment2>2
replace kilm5=9 if profession_mainoccup==14 & educ_attainment2<=2
replace kilm5=7 if profession_mainoccup==22 & educ_attainment2>2
replace kilm5=9 if profession_mainoccup==22 & educ_attainment2<=2
replace kilm5=7 if profession_mainoccup==23
replace kilm5=7 if profession_mainoccup==24
replace kilm5=7 if profession_mainoccup==25
replace kilm5=7 if profession_mainoccup==26
replace kilm5=8 if profession_mainoccup==27
replace kilm5=8 if profession_mainoccup==28
replace kilm5=8 if profession_mainoccup==29
replace kilm5=8 if profession_mainoccup==30
replace kilm5=7 if profession_mainoccup==31 & educ_attainment2>2
replace kilm5=9 if profession_mainoccup==31 & educ_attainment2<=2
replace kilm5=7 if profession_mainoccup==32 & educ_attainment2>2
replace kilm5=9 if profession_mainoccup==32 & educ_attainment2<=2
replace kilm5=7 if profession_mainoccup==33 & educ_attainment2>2
replace kilm5=9 if profession_mainoccup==33 & educ_attainment2<=2
replace kilm5=2 if profession_mainoccup==41
replace kilm5=2 if profession_mainoccup==42
replace kilm5=2 if profession_mainoccup==43
replace kilm5=2 if profession_mainoccup==44
replace kilm5=2 if profession_mainoccup==45
replace kilm5=2 if profession_mainoccup==46
replace kilm5=2 if profession_mainoccup==47
replace kilm5=2 if profession_mainoccup==51
replace kilm5=1 if profession_mainoccup==52
replace kilm5=3 if profession_mainoccup==61
replace kilm5=3 if profession_mainoccup==71
replace kilm5=3 if profession_mainoccup==72
replace kilm5=8 if profession_mainoccup==73
replace kilm5=5 if profession_mainoccup==81
replace kilm5=5 if profession_mainoccup==82
replace kilm5=5 if profession_mainoccup==83
replace kilm5=5 if profession_mainoccup==84
replace kilm5=5 if profession_mainoccup==85
replace kilm5=4 if profession_mainoccup==86
replace kilm5=1 if profession_mainoccup==91 & educ_attainment2>=4
replace kilm5=5 if profession_mainoccup==91 & educ_attainment2<4
replace kilm5=5 if profession_mainoccup==91 & educ_attainment2>2
replace kilm5=9 if profession_mainoccup==91 & educ_attainment2<=2
replace kilm5=9 if profession_mainoccup==93
replace kilm5=9 if profession_mainoccup==94
replace kilm5=5 if profession_mainoccup==95
replace kilm5=8 if profession_mainoccup==96
replace kilm5=5 if profession_mainoccup==97 & educ_attainment2>2
replace kilm5=9 if profession_mainoccup==97 & educ_attainment2<=2
replace kilm5=2 if profession_mainoccup==101
replace kilm5=5 if profession_mainoccup==102
replace kilm5=9 if profession_mainoccup==111
replace kilm5=9 if profession_mainoccup==901
replace kilm5=9 if profession_mainoccup==902
replace kilm5=9 if profession_mainoccup==903
replace kilm5=7 if profession_mainoccup==904
replace kilm5=7 if profession_mainoccup==905
replace kilm5=7 if profession_mainoccup==906
replace kilm5=6 if profession_mainoccup==907
replace kilm5=9 if profession_mainoccup==999

label define kilm5 1"Directeurs et gérants" 2"Professions intellectuelles et scientifiques" 3"Professions intermédiaires" 4"Employés administratifs" 5"Commerçants et vendeurs" 6"Agriculteurs et ouvriers qualifiés agri" 7"Métiers qualifiés industrie et artisanat" 8"Conducteurs" 9"Professions élémentaires" 10"Professions militaires"
label val kilm5 kilm5

* Elementary occupations
gen elementaryoccup=(kilm5==9) if employed==1


***
keep HHID2010 INDID2010 occupation kindofwork str_kindofwork profession_mainoccup sector_mainoccup occupationname_mainoccup educ_attainment educ_attainment2 agecat workingage youth employed employee selfemployed sector_kilm4 agri industry services sector_kilm4_V2 kilm5 elementaryoccup

save"_temp/_temp_RUME-kilm_v5.dta", replace
save"outcomes/RUME-kilm.dta", replace
****************************************
* END
