*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@ifpindia.org
*October 30, 2024
*-----
*NEEMSIS-2 HH last clean
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\2020-NEEMSIS2\Data\4team"
cd"$directory"
********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid
********** Split var
do"C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2\splitvarmcq.do"
do"C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2\newn.do"
do"C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2\repmi.do"
********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020
*-------------------------











****************************************
* Alters cleaning label et var
****************************************
use"Last\NEEMSIS2-alters_networkpurpose", clear

* Label
label define dummyfam 0"No" 1"Yes"
label define friend 0"No" 1"Yes"
label define wkp 0"No" 1"Yes"
label define labourrelation 0"No" 1"Yes"
label define sex 1"Male" 2"Female"
label define age 1"15-25" 2"26-35" 3"36-45" 4"46-55" 5"56-65" 6"More than 65"
label define labourtype 1"Employer" 2"Colleague" 3"Maistry" 4"Supplier"
label define castes 1"Vanniyar" 2"SC" 3"Arunthathiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"Mudaliar" 12"Kulalar" 13"Chettiyar" 14"Marwari" 15"Muslims" 16"Padayachi" 88"D/K"
label define educ 1"Primary or below" 2"Upper primary" 3"High school" 4"Senior secondary" 5"Bachelor and above" 6"No education" 88"D/K"
label define employertype 1"State admin" 2"State-owned enterprise/farm" 3"Paid public works" 4"An individual" 5"Private firm or plant or farm" 6"Cooperative" 7"NGO" 77"Other"
label define living 1"Same neighborhood" 2"Same village" 3"Same district" 4"Another place in Tamil Nadu" 5"India" 6"Foreign country"
label define ruralurban 1"Urban area" 2"Rural area"
label define district 1"Ariyalur" 2"Chengalpet" 3"Chennai" 4"Coimbatore" 5"Cuddalore" 6"Dharmapuri" 7"Dindigul" 8"Erode" 9"Kallakurichi" 10"Kancheepuram" 11"Karur" 12"Krishnagiri" 13"Madurai" 14"Nagapattinam" 15"Kanyakumari" 16"Nagercoil" 17"Namakkal" 18"Perambalur" 19"Pudukottai" 20"Ramanathapuram" 21"Ranipet" 22"Salem" 23"Sivagangai" 24"Tenkasi" 25"Thanjavur" 26"Theni" 27"Thiruvallur" 28"Tuticorin" 29"Trichirappalli" 30"Thirunelveli" 31"Tirupattur" 32"Tiruppur" 33"Thiruvannamalai" 34"The Nilgiris" 35"Vellore" 36"Viluppuram" 37"Virudhunagar"
label define compared 1"Better situation" 2"Same situation" 3"Worst situation"
label define meet 1"Labour relation" 2"Neighbourhood relation" 3"Introduced by family" 4"Introduce by an acquaintance" 5"Classmate" 6"Through an asso" 77"Other"
label define meetfrequency 1"At least once a week" 2"At least once a month" 3"Every 2-3 months" 4"Every 4-6 months" 5"Once a year" 6"Less than once a year"
label define invite 0"No" 1"Yes"
label define reciprocity1 0"No" 1"Yes"
label define intimacy 1"Not intimate" 2"Intimate" 3"Very intimate"
order meetother, after(meet)
label define dummyhh 0"No" 1"Yes"
label define money 1"Very often" 2"Often" 3"Barely" 4"Never"


foreach x in dummyfam friend wkp labourrelation sex age labourtype castes educ employertype living ruralurban district compared meet meetfrequency invite reciprocity1 intimacy dummyhh money {
label values `x' `x'
}
drop assoid_v1 loanlender businesslender loanmarriageuse snlist typesn businessloanuse1 businessloanuse2 businessloanuse3 businessloanuse4 businessloanuse5 recruitworkeruse associationid assosnuse currentjobuse_ego1 currentjobuse_ego2 currentjobuse_ego3 futurejobuse_ego1 futurejobuse_ego2 futurejobuse_ego3 recommendforjobuse_ego1 recommendforjobuse_ego2 recommendforjobuse_ego3 recojobsuccessuse_ego1 recojobsuccessuse_ego2 recojobsuccessuse_ego3 talkthemostuse_ego1 talkthemostuse_ego2 talkthemostuse_ego3 medicalemergencyuse_ego1 medicalemergencyuse_ego2 medicalemergencyuse_ego3 closerelouthhuse_ego1 closerelouthhuse_ego2 closerelouthhuse_ego3 receivedhelpcov_ego1 receivedhelpcov_ego2 receivedhelpcov_ego3 givehelpcov_ego1 givehelpcov_ego2 givehelpcov_ego3 castesother

********** Drop HH duplicates + HH without HH module
* drop duplicates HH
drop if HHID2020=="uuid:ff95bdde-6012-4cf6-b7e8-be866fbaa68b"
* drop HH without HH module
/*
drop if HHID2020=="uuid:1091f83c-d157-4891-b1ea-09338e91f3ef"
drop if HHID2020=="uuid:21f161fd-9a0c-4436-a416-7e75fad830d7"
drop if HHID2020=="uuid:7373bf3a-f7a4-4d1a-8c12-ccb183b1f4db"
drop if HHID2020=="uuid:aea57b03-83a6-44f0-b59e-706b911484c4"
drop if HHID2020=="uuid:b3e4fe70-f2aa-4e0f-bb6e-8fb57bb6f409"
drop if HHID2020=="uuid:d4b98efb-0cc6-4e82-996a-040ced0cbd52"
*/

save"Last\LastLast\NEEMSIS2-alters_networkpurpose", replace
****************************************
* END













****************************************
* NEEMSIS2-HH.dta : relationshiptohead and sex
****************************************
use"Last\Lastlast\Corrected\NEEMSIS2-HH", clear

global var name age sex relationshiptohead maritalstatus
foreach x in $var {
rename `x' HH_`x'
}

merge 1:1 HHID2020 INDID2020 using "NEEMSIS2-couples", keepusing($var)
drop _merge

cls
ta HH_relationshiptohead relationshiptohead

foreach x in $var {
order `x', before(HH_`x')
}

foreach x in age sex relationshiptohead maritalstatus{
replace `x'=HH_`x' if HH_`x'!=. & `x'==.
}
foreach x in name{
replace `x'=HH_`x' if HH_`x'!="" & `x'==""
}

foreach x in $var{
drop HH_`x'
}

ta relationshiptohead sex

********** Drop HH duplicates + HH without HH module
* drop duplicates HH
drop if HHID2020=="uuid:ff95bdde-6012-4cf6-b7e8-be866fbaa68b"
* drop HH without HH module
/*
drop if HHID2020=="uuid:1091f83c-d157-4891-b1ea-09338e91f3ef"
drop if HHID2020=="uuid:21f161fd-9a0c-4436-a416-7e75fad830d7"
drop if HHID2020=="uuid:7373bf3a-f7a4-4d1a-8c12-ccb183b1f4db"
drop if HHID2020=="uuid:aea57b03-83a6-44f0-b59e-706b911484c4"
drop if HHID2020=="uuid:b3e4fe70-f2aa-4e0f-bb6e-8fb57bb6f409"
drop if HHID2020=="uuid:d4b98efb-0cc6-4e82-996a-040ced0cbd52"
*/
*

save"Last\Lastlast\Corrected\Lastcorrection\NEEMSIS2-HH", replace
****************************************
* END










****************************************
* Loans
****************************************
use"Last\NEEMSIS2-loans_mainloans", clear

* drop duplicates HH
drop if HHID2020=="uuid:ff95bdde-6012-4cf6-b7e8-be866fbaa68b"
*
* drop HH without HH module
/*
drop if HHID2020=="uuid:1091f83c-d157-4891-b1ea-09338e91f3ef"
drop if HHID2020=="uuid:21f161fd-9a0c-4436-a416-7e75fad830d7"
drop if HHID2020=="uuid:7373bf3a-f7a4-4d1a-8c12-ccb183b1f4db"
drop if HHID2020=="uuid:aea57b03-83a6-44f0-b59e-706b911484c4"
drop if HHID2020=="uuid:b3e4fe70-f2aa-4e0f-bb6e-8fb57bb6f409"
drop if HHID2020=="uuid:d4b98efb-0cc6-4e82-996a-040ced0cbd52"
*/
*
save"Last\Lastlast\NEEMSIS2-loans_mainloans", replace
****************************************
* END













****************************************
* Occupations
****************************************
use"Last\NEEMSIS2-occupations", clear
* drop duplicates HH
drop if HHID2020=="uuid:ff95bdde-6012-4cf6-b7e8-be866fbaa68b"
*
* drop HH without HH module
/*
drop if HHID2020=="uuid:1091f83c-d157-4891-b1ea-09338e91f3ef"
drop if HHID2020=="uuid:21f161fd-9a0c-4436-a416-7e75fad830d7"
drop if HHID2020=="uuid:7373bf3a-f7a4-4d1a-8c12-ccb183b1f4db"
drop if HHID2020=="uuid:aea57b03-83a6-44f0-b59e-706b911484c4"
drop if HHID2020=="uuid:b3e4fe70-f2aa-4e0f-bb6e-8fb57bb6f409"
drop if HHID2020=="uuid:d4b98efb-0cc6-4e82-996a-040ced0cbd52"
*/
*
save"Last\Lastlast\NEEMSIS2-occupations", replace
****************************************
* END













****************************************
* Egos
****************************************
use"Last\Lastlast\Corrected\NEEMSIS2-ego", clear
* drop duplicates HH
drop if HHID2020=="uuid:ff95bdde-6012-4cf6-b7e8-be866fbaa68b"
*
* drop HH without HH module
/*
drop if HHID2020=="uuid:1091f83c-d157-4891-b1ea-09338e91f3ef"
drop if HHID2020=="uuid:21f161fd-9a0c-4436-a416-7e75fad830d7"
drop if HHID2020=="uuid:7373bf3a-f7a4-4d1a-8c12-ccb183b1f4db"
drop if HHID2020=="uuid:aea57b03-83a6-44f0-b59e-706b911484c4"
drop if HHID2020=="uuid:b3e4fe70-f2aa-4e0f-bb6e-8fb57bb6f409"
drop if HHID2020=="uuid:d4b98efb-0cc6-4e82-996a-040ced0cbd52"
*/
*
save"Last\Lastlast\Corrected\Lastcorrection\NEEMSIS2-ego", replace
****************************************
* END













****************************************
* Migration
****************************************
use"Last\Lastlast\NEEMSIS2-migrations", clear
* drop duplicates HH
drop if HHID2020=="uuid:ff95bdde-6012-4cf6-b7e8-be866fbaa68b"
*
* drop HH without HH module
/*
drop if HHID2020=="uuid:1091f83c-d157-4891-b1ea-09338e91f3ef"
drop if HHID2020=="uuid:21f161fd-9a0c-4436-a416-7e75fad830d7"
drop if HHID2020=="uuid:7373bf3a-f7a4-4d1a-8c12-ccb183b1f4db"
drop if HHID2020=="uuid:aea57b03-83a6-44f0-b59e-706b911484c4"
drop if HHID2020=="uuid:b3e4fe70-f2aa-4e0f-bb6e-8fb57bb6f409"
drop if HHID2020=="uuid:d4b98efb-0cc6-4e82-996a-040ced0cbd52"
*/
*
save"Last\Lastlast\Corrected\NEEMSIS2-migrations", replace
****************************************
* END









****************************************
* GPS
****************************************
use "Last\NEEMSIS2-GPS_v2", clear

* drop duplicates HH
drop if HHID_panel=="KUV65"
*
* drop HH without HH module
/*
drop if HHID2020=="uuid:1091f83c-d157-4891-b1ea-09338e91f3ef"
drop if HHID2020=="uuid:21f161fd-9a0c-4436-a416-7e75fad830d7"
drop if HHID2020=="uuid:7373bf3a-f7a4-4d1a-8c12-ccb183b1f4db"
drop if HHID2020=="uuid:aea57b03-83a6-44f0-b59e-706b911484c4"
drop if HHID2020=="uuid:b3e4fe70-f2aa-4e0f-bb6e-8fb57bb6f409"
drop if HHID2020=="uuid:d4b98efb-0cc6-4e82-996a-040ced0cbd52"
*/

order jatis jatisdetails, last

**** Pb orthographe
gen jatisdetails2=jatisdetails

ta jatisdetails2

replace jatisdetails2="Chettiyar" if strpos(jatisdetails,"Chetti")

replace jatisdetails2="Gavunder" if strpos(jatisdetails,"Gavu")
replace jatisdetails2="Gavunder" if strpos(jatisdetails,"Gounder")
replace jatisdetails2="Gavunder" if strpos(jatisdetails,"Kavunter")

replace jatisdetails2="Kaikokalar" if strpos(jatisdetails,"Kaikol")

replace jatisdetails2="Kavara" if strpos(jatisdetails,"Kavara")

replace jatisdetails2="Kulalar" if strpos(jatisdetails,"Kulalar")
replace jatisdetails2="Kulalar" if strpos(jatisdetails,"Kuyavar")

replace jatisdetails2="Mudaliar" if strpos(jatisdetails,"Mudali")

replace jatisdetails2="Muslim" if strpos(jatisdetails,"Muslim")

replace jatisdetails2="Naidu" if strpos(jatisdetails,"Naidu")

replace jatisdetails2="Nattar" if strpos(jatisdetails,"Nattar")

replace jatisdetails2="Padayachi" if strpos(jatisdetails,"Padayachi")
replace jatisdetails2="Padayachi" if strpos(jatisdetails,"Padaya")

replace jatisdetails2="Paraiyar" if strpos(jatisdetails,"Para")

replace jatisdetails2="Reddiyar" if strpos(jatisdetails,"Reddi")

replace jatisdetails2="SC" if strpos(jatisdetails,"Sc")

replace jatisdetails2="Sakili" if strpos(jatisdetails,"Sakkili")

replace jatisdetails2="Valluvar" if strpos(jatisdetails,"Valluvan")
replace jatisdetails2="Valluvar" if strpos(jatisdetails,"Valluvar")

replace jatisdetails2="Vanniyar" if strpos(jatisdetails,"Vanni")
replace jatisdetails2="Vanniyar" if jatisdetails=="Tot"

compress

**** Regroupement que je connais
gen jatisdetails3=jatisdetails2

ta jatisdetails3

replace jatisdetails3="Vanniyar" if jatisdetails2=="Padayachi"
replace jatisdetails3="Vanniyar" if jatisdetails2=="Gavunder"
replace jatisdetails3="Mudaliar" if jatisdetails2=="Kaikokalar"
replace jatisdetails3="Paraiyar" if jatisdetails2=="Valluvar"
replace jatisdetails3="Naidu" if jatisdetails2=="Balija"
replace jatisdetails3="Naidu" if jatisdetails2=="Gavara"
replace jatisdetails3="Naidu" if jatisdetails2=="Kavara"
replace jatisdetails3="Arunthathiyar" if jatisdetails2=="Sakili"
replace jatisdetails3="Paraiyar" if jatisdetails2=="SC"


**** Regroupement internet (mais à confirmer avec Venkat)
gen jatisdetails4=jatisdetails3

ta jatisdetails4

replace jatisdetails4="Chettiyar" if jatisdetails3=="Settu"
replace jatisdetails4="Chettiyar" if jatisdetails3=="Kulalar"


/*
Pb :
GOV19	= mudaliar 	ou kaikokalar	?
KAR48 	= yathavar 	ou vanniyar ?
GOV38	= vanniyar	ou kulalar	?
MANAM11	= vanniyar	ou asarai	?
MANAM12	= vanniyar	ou gramani	?

MANAM40 un peu particulier. Le chef est Reddiyar, marié à une Vanniyar et leur fille est mariée à un SC. Donc à voir qui se défini comme chef à chaque fois pour bien modifier la caste.
*/


*
drop n

*
save"Last\Lastlast\NEEMSIS2-GPS", replace
****************************************
* END










****************************************
* Couples
****************************************
use "NEEMSIS2-couples", clear

* drop duplicates HH
drop if HHID_panel=="KUV65"
drop HHID_panel INDID_panel
order HHID2020 INDID2020
sort HHID2020 INDID2020

*
* drop HH without HH module
/*
drop if HHID2020=="uuid:1091f83c-d157-4891-b1ea-09338e91f3ef"
drop if HHID2020=="uuid:21f161fd-9a0c-4436-a416-7e75fad830d7"
drop if HHID2020=="uuid:7373bf3a-f7a4-4d1a-8c12-ccb183b1f4db"
drop if HHID2020=="uuid:aea57b03-83a6-44f0-b59e-706b911484c4"
drop if HHID2020=="uuid:b3e4fe70-f2aa-4e0f-bb6e-8fb57bb6f409"
drop if HHID2020=="uuid:d4b98efb-0cc6-4e82-996a-040ced0cbd52"
*/
*
save"Last\NEEMSIS2-couples", replace
****************************************
* END
