*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*NEEMSIS-2 GPS
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (IRD)\RUME II\2. Data\Raw\2020-NEEMSIS2_GPS"
cd"$directory"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020







****************************************
* GPS
***************************************
import excel "NEEMSIS2_GPS_2023mar6.xlsx", sheet("NEEMSIS2 GPS") firstrow clear

* Clean
drop username1 username2 username3 username4 username5 username6 username7 username8 username9 username10 username77
drop _validation_status _notes _status _submitted_by _tags _index _id


* Label define
do "C:\Users\Arnaud\Documents\GitHub\odriis\Data_cleaning\NEEMSIS2_GPS\2020_NEEMSIS2-GPS_label.do"


* Label values
label values jatis jatislabel
label values username usernamelabel
label values dummypresent yesno
label values householdvillageoriginal loclabel
label values householdidoriginal hhid


* Rename order
rename _uuid HHID2023
rename _submission_time submissiondate
rename _housegeolocation_latitude gps_latitude
rename _housegeolocation_longitude gps_longitude
rename _housegeolocation_altitude gps_altitude
rename _housegeolocation_precision gps_precision

* Decode
decode householdvillageoriginal, gen(householdvillageoriginal_str)
split householdvillageoriginal_str, p(--)
rename householdvillageoriginal_str1 village
rename householdvillageoriginal_str2 villagearea

decode householdidoriginal, gen(householdidoriginal_str)
split householdidoriginal_str, p(-/)
rename householdidoriginal_str1 address
rename householdidoriginal_str3 HHID_panel


* Head
rename householdidoriginal_str2 hhhead
split hhhead, p(,)
split hhhead2, p(" ")
drop hhhead2 hhhead22
rename hhhead21 head_age
destring head_age, replace

split hhhead1, p("(")
rename hhhead11 head_name
rename hhhead12 head_sex
drop hhhead hhhead1
replace head_sex="1" if head_sex=="Male"
replace head_sex="2" if head_sex=="Female"
destring head_sex, replace
label define sex 1"Male" 2"Female"
label values head_sex sex
fre head_sex


* Village space
replace village=substr(village,1,strlen(village)-1)


* HHID_panel space
replace HHID_panel=substr(HHID_panel,2,strlen(HHID_panel))



* Size
compress
format address %50s
format placeatpresent %50s
format housecomments %50s
format comments %50s
format houseaddress %50s



* Order
order HHID2023 HHID_panel username otherusername recordingdate village villagearea address head_name head_sex head_age dummypresent placeatpresent jatisdetails jatis houseaddress housegeolocation gps_latitude gps_longitude gps_altitude gps_precision housecomments comments submissiondate

drop householdvillageoriginal householdidoriginal housegeolocation
rename householdvillageoriginal_str householdvillageoriginal
rename householdidoriginal_str householdidoriginal

sort HHID_panel

save"NEEMSIS2-GPS_2023.dta", replace
****************************************
* END











****************************************
* Offline form
***************************************
/*
Venkat, Antony, and Vivek does not have the good version of the form.
Thus, it was impossible to send finalized form to the Kobo server.
Arnaud has manually created a xlsx file with the 15 households surveyed.
*/
import excel "Offline_form/NEEMSIS2_GPS_2023feb24", sheet("NEEMSIS2 GPS") firstrow clear

drop if username==.
drop placeatpresent
gen placeatpresent=""
gen date="24feb2023"
gen submissiondate=date(date, "DMY")
drop date
format submissiondate %td

* Label define
do "C:\Users\Arnaud\Documents\GitHub\odriis\Data_cleaning\NEEMSIS2_GPS\2020_NEEMSIS2-GPS_label.do"


* Label values
label values jatis jatislabel
label values username usernamelabel
label values dummypresent yesno
label values householdvillageoriginal loclabel
label values householdidoriginal hhid

* Geolocation
split housegeolocation
rename housegeolocation1 gps_latitude
rename housegeolocation2 gps_longitude
rename housegeolocation3 gps_altitude
rename housegeolocation4 gps_precision
destring gps_latitude gps_longitude gps_altitude gps_precision, replace


* Decode
decode householdvillageoriginal, gen(householdvillageoriginal_str)
split householdvillageoriginal_str, p(--)
rename householdvillageoriginal_str1 village
rename householdvillageoriginal_str2 villagearea

decode householdidoriginal, gen(householdidoriginal_str)
split householdidoriginal_str, p(-/)
rename householdidoriginal_str1 address
rename householdidoriginal_str3 HHID_panel


* Head
rename householdidoriginal_str2 hhhead
split hhhead, p(,)
split hhhead2, p(" ")
drop hhhead2 hhhead22
rename hhhead21 head_age
destring head_age, replace

split hhhead1, p("(")
rename hhhead11 head_name
rename hhhead12 head_sex
drop hhhead hhhead1
replace head_sex="1" if head_sex=="Male"
replace head_sex="2" if head_sex=="Female"
destring head_sex, replace
label define sex 1"Male" 2"Female"
label values head_sex sex
fre head_sex


* Village space
replace village=substr(village,1,strlen(village)-1)


* HHID_panel space
replace HHID_panel=substr(HHID_panel,2,strlen(HHID_panel))



* Size
compress
format address %50s
format placeatpresent %50s
format housecomments %50s
format comments %50s
format houseaddress %50s



* Order
order HHID_panel username recordingdate village villagearea address head_name head_sex head_age dummypresent placeatpresent jatisdetails jatis houseaddress housegeolocation gps_latitude gps_longitude gps_altitude gps_precision housecomments comments submissiondate

drop householdvillageoriginal householdidoriginal housegeolocation
rename householdvillageoriginal_str householdvillageoriginal
rename householdidoriginal_str householdidoriginal

sort HHID_panel


********** Vivek told Arnaud that MAN30 and MAN48 are brother and they were not present
replace dummypresent=0 if HHID_panel=="MAN30"
replace dummypresent=0 if HHID_panel=="MAN48"
/*
What is the new address?
Arnaud will ask to Vivek
*/


save"NEEMSIS2-GPS_2023feb24_offline.dta", replace
****************************************
* END












****************************************
* Clean Jatis
****************************************
use"NEEMSIS2-GPS_2023.dta", clear


append using "NEEMSIS2-GPS_2023feb24_offline.dta"




********** Label coord
label var gps_latitude "y-var"
label var gps_longitude "x-var"

rename gps_latitude gps_latitude_Y
rename gps_longitude gps_longitude_X


********** Drop duplicates
preserve
sort jatisdetails
keep jatisdetails
duplicates drop
list jatisdetails, clean noobs
*export excel "jatis.xlsx", replace
restore



********** Replace
* Gounder
replace jatisdetails="Gounder" if jatisdetails=="Gounder"
replace jatisdetails="Gounder" if strpos(jatisdetails,"Gounder")

* Kavara
replace jatisdetails="Kavara" if jatisdetails=="Kavara"
replace jatisdetails="Kavara" if jatisdetails=="Kavara "

* Kavunter
replace jatisdetails="Kavunter" if jatisdetails=="Kavunter"

* Padayachi
replace jatisdetails="Padayachi" if jatisdetails=="Padayachi"
replace jatisdetails="Padayachi" if jatisdetails=="Padayachi"
replace jatisdetails="Padayachi" if jatisdetails=="Padayatchi"
replace jatisdetails="Padayachi" if strpos(jatisdetails,"Padayachi")

* Paraiyar
replace jatisdetails="Paraiyar" if jatisdetails=="Para"
replace jatisdetails="Paraiyar" if jatisdetails=="Parayar"
replace jatisdetails="Paraiyar" if jatisdetails=="Parayar "

* Rediyar
replace jatisdetails="Rediyar" if jatisdetails=="Reddi"
replace jatisdetails="Rediyar" if jatisdetails=="Reddiar"

* SC
replace jatisdetails="SC" if jatisdetails=="SC"
replace jatisdetails="SC" if jatisdetails=="Sc"

* Sakkiliar
replace jatisdetails="Sakkiliar" if jatisdetails=="Sakili"
replace jatisdetails="Sakkiliar" if jatisdetails=="Sakkili"

* Valluvan
replace jatisdetails="Valluvan" if jatisdetails=="Valluvan"

* Vanniyar
replace jatisdetails="Vanniyar" if jatisdetails=="Vanniar"
replace jatisdetails="Vanniyar" if jatisdetails=="Vaniar"
replace jatisdetails="Vanniyar" if jatisdetails=="Vanniar"
replace jatisdetails="Vanniyar" if jatisdetails=="Vanniar"
replace jatisdetails="Vanniyar" if jatisdetails=="Vanniarr"
replace jatisdetails="Vanniyar" if jatisdetails=="Vanniat"
replace jatisdetails="Vanniyar" if jatisdetails=="Vanniatlr"
replace jatisdetails="Vanniyar" if jatisdetails=="Vanniyar"
replace jatisdetails="Vanniyar" if jatisdetails=="Vanniyar "
replace jatisdetails="Vanniyar" if strpos(jatisdetails,"Vanniar")


********** Desc
fre jatisdetails




********** Correction Antony - 8 feb 2023
/*
ORA12 is Sakkiliar, which is a subcaste of Arunthatiyar.
However, other households "SC" from Oraiyure are Paraiyar.
*/
ta HHID_panel if jatisdetails=="Sakkiliar" & village=="Oraiyure"

replace jatisdetails="Paraiyar" if HHID_panel=="ORA17"
replace jatisdetails="Paraiyar" if HHID_panel=="ORA29"
replace jatisdetails="Paraiyar" if HHID_panel=="ORA3"
replace jatisdetails="Paraiyar" if jatisdetails=="SC" & village=="Oraiyure"
fre jatisdetails


save"NEEMSIS2-GPS.dta", replace
****************************************
* END










****************************************
* Loc
****************************************
use"NEEMSIS2-GPS.dta", clear

keep HHID_panel gps_latitude_Y gps_longitude_X

export delimited using "projection.csv", replace

****************************************
* END
