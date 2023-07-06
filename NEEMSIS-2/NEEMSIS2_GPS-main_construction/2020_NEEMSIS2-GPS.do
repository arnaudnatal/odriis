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
import excel "NEEMSIS2_GPS_2023apr13.xlsx", sheet("NEEMSIS2 GPS") firstrow clear

* Clean
drop username1 username2 username3 username4 username5 username6 username7 username8 username9 username10 username77
drop _validation_status _notes _status _submitted_by _tags _index _id


* Label define
do "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2\NEEMSIS2_GPS-main_construction\2020_NEEMSIS2-GPS_label.do"


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
do "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2\NEEMSIS2_GPS-main_construction\2020_NEEMSIS2-GPS_label.do"


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

* Gen HHID2023
gen n=_n
tostring n, replace
gen n2="vivekoffline_"
egen HHID2023=concat(n2 n)
order HHID2023
drop n n2




save"NEEMSIS2-GPS_2023feb24_offline.dta", replace
****************************************
* END











****************************************
* Offline form part 2
***************************************
/*
Venkat, Antony, and Vivek does not have the good version of the form.
Thus, it was impossible to send finalized form to the Kobo server.
Arnaud has manually created a xlsx file with the 15 households surveyed.
*/
import excel "Offline_form/NEEMSIS2-GPS_remaining_Venkat", sheet("Sheet1") firstrow clear

replace J="." if J=="NA"
destring J, replace
rename J gps_latitude
rename K gps_longitude

**** Clean
*
gen n=_n
tostring n, replace
gen text="venkatoffline_"
egen HHID2023=concat(text n)
drop n text
*
gen otherusername="Venkat"
gen username=77
*
gen _recordingdate="01jun2023"
generate recordingdate = date(_recordingdate, "DMY")
format %td recordingdate
drop _recordingdate
*
rename village_new village
drop villagearea
*
rename I jatisdetails
*
rename jatiscorr2020 jatis
*
label define head_sex 1"Male" 2"Female"
replace head_sex="1" if head_sex=="Male"
replace head_sex="2" if head_sex=="Female"
destring head_sex, replace
label values head_sex head_sex
* jatis
replace jatis="1" if jatis=="Vanniyar"
replace jatis="2" if jatis=="SC"
replace jatis="6" if jatis=="Naidu"
replace jatis="8" if jatis=="Asarai"
replace jatis="11" if jatis=="Mudaliar"
replace jatis="13" if jatis=="Chettiyar"
replace jatis="15" if jatis=="Muslims"
replace jatis="16" if jatis=="Padayachi"
destring jatis, replace

* Order
order HHID2023 HHID_panel username otherusername recordingdate village address head_name head_sex head_age jatisdetails jatis gps_latitude gps_longitude


save"NEEMSIS2-GPS_2023jun19_offline.dta", replace
****************************************
* END














****************************************
* Clean Jatis
****************************************
use"NEEMSIS2-GPS_2023.dta", clear


append using "NEEMSIS2-GPS_2023feb24_offline.dta"
append using "NEEMSIS2-GPS_2023jun19_offline.dta"




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
/*
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
replace jatisdetails="Padayachi" if jatisdetails=="Padayarltchi"
replace jatisdetails="Padayachi" if jatisdetails=="Padayatch"
replace jatisdetails="Padayachi" if jatisdetails=="Padayatch"
replace jatisdetails="Padayachi" if jatisdetails=="Padayatchi "

* Paraiyar
replace jatisdetails="Paraiyar" if jatisdetails=="Para"
replace jatisdetails="Paraiyar" if jatisdetails=="Parayar"
replace jatisdetails="Paraiyar" if jatisdetails=="Parayar "
replace jatisdetails="Paraiyar" if jatisdetails=="Paarayar"



* Rediyar
replace jatisdetails="Rediyar" if jatisdetails=="Reddi"
replace jatisdetails="Rediyar" if jatisdetails=="Reddiar"
replace jatisdetails="Rediyar" if jatisdetails=="Reddiyar"


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

* Gavunter
replace jatisdetails="Gavunter" if jatisdetails=="Gavunder"
replace jatisdetails="Gavunter" if jatisdetails=="Gavunnter"
replace jatisdetails="Gavunter" if jatisdetails=="Gavuntet"
replace jatisdetails="Gavunter" if jatisdetails=="Kavunter"


* Chettiyar
replace jatisdetails="Chettiyar" if jatisdetails=="Chetti"
replace jatisdetails="Chettiyar" if jatisdetails=="Chettiyar "
*/

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


********** 
decode jatis, gen(_jatis)
replace jatisdetails=_jatis if jatisdetails=="" & _jatis!=""
drop _jatis


save"NEEMSIS2-GPS_temp.dta", replace
****************************************
* END













****************************************
* Duplicates v1
****************************************
use"NEEMSIS2-GPS_temp.dta", clear

*
bysort HHID_panel: gen tag=_N
order tag, after(username)
sort tag HHID_panel
ta tag

* Who?
preserve
duplicates drop HHID_panel, force
ta tag
keep HHID_panel
gen done=1
save"NEEMSIS2-GPS_done", replace
restore


* Clean
drop __version__

* Drop duplicates
preserve
import excel "NEEMSIS2-GPS_duplicates", firstrow clear
drop tokeep
rename AB tokeep

order tokeep, after(HHID_panel)
sort HHID_panel

keep HHID2023 tokeep
save"NEEMSIS2-GPS_duplicates", replace
restore

merge 1:1 HHID2023 using "NEEMSIS2-GPS_duplicates"
drop _merge
ta tokeep
drop if tokeep==0
order HHID2023 HHID_panel tokeep tag
drop tokeep tag


*** Last dupli
drop if HHID2023=="2c8ab9f7-5109-4c32-9549-f93ccdaa5c9c"
drop if HHID2023=="213a2d61-eb5d-41df-9ecd-f9b127603ffd"

save"NEEMSIS2-GPS_v0.dta", replace
****************************************
* END
















****************************************
* Duplicates v2
****************************************
use"NEEMSIS2-GPS_v0.dta", clear


********** Duplicates
bysort HHID_panel: gen n=_N
ta n
preserve
keep if n==2
*export excel using "NEEMSIS2-GPS_duplicates_v2.xlsx", firstrow(variables) replace
restore


********** To do
preserve
keep HHID_panel
duplicates drop
gen done=1
save"NEEMSIS2-GPS_done", replace
restore


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
