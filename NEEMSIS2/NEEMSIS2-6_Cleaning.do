/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
February 23, 2021
-----
OCCUPATION, CASTE, ETC
-----

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
* Occupation
****************************************
/*
Ajouter à la base HH une variable d'activité principale
partant du principe que c'est l'activité où avec max hoursayear
*/
use"NEEMSIS_APPEND-occupations.dta", clear
split parent_key, p(/)
drop parent_key parent_key2
rename parent_key1 parent_key
split setofoccupations, p([)
drop setofoccupations1 setofoccupations3
split setofoccupations2, p(])
drop setofoccupations2 setofoccupations22
rename setofoccupations21 INDID_total
destring INDID_total, replace
drop businessskill_2 businessskill_4 businessskill_1 businesslocation_1 businesslocation_2 businesslocation_4 joblocation_1 joblocation_2 joblocation_4 joblocation_5 joblocation_3 joblocation_7 joblocation_6 businesslocation_3 businesslocation_7 businesslocation_5 businesslocation_6
destring occupationnumber, replace
order parent_key INDID_total occupationnumber, first
sort parent_key INDID
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"

gen countoccupation=1
save"NEEMSIS_APPEND-occupations_v2.dta", replace


**********EGO
use"NEEMSIS_APPEND-occupations_v2.dta", clear
/*
   dummyego |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      1,382       55.59       55.59
          1 |      1,104       44.41      100.00
------------+-----------------------------------
      Total |      2,486      100.00
*/
merge m:m parent_key INDID_total using "NEEMSIS_APPEND_v7.dta", keepusing(ego maxhoursayear selected_occupposition_ selected_occupname_ dummymainoccupation2 othermainoccupation2 workedpastyearfromearlier dummyworkedpastyear dummyego)
keep if _merge==3
drop _merge

*Ego moc
destring hoursayear maxhoursayear, replace
gen mainoccup=kindofwork if maxhoursayear==hoursayear & dummymainoccupation2==1
gen mainoccupname=occupationname if maxhoursayear==hoursayear & dummymainoccupation2==1
*If it is not?
tab dummymainoccupation2
gen _tempmocego=1 if othermainoccupation2==occupationname & dummymainoccupation2==0
replace mainoccup=kindofwork if _tempmocego==1
replace mainoccupname=occupationname if _tempmocego==1
*Checking
preserve
bysort parent_key INDID_total: gen n=_n
keep if n==1
tab mainoccup dummyego, m
restore
*For the rest? Alamano
sort parent_key INDID_total
list parent_key INDID_total occupationnumber occupationname kindofwork othermainoccupation2 if dummymainoccupation2==0 & mainoccupname=="", clean noobs
preserve
keep if dummymainoccupation2==0 & mainoccupname==""
keep parent_key occupationnumber INDID_total othermainoccupation2 occupationname kindofwork
order parent_key INDID_total occupationnumber occupationname kindofwork othermainoccupation2
export excel using "NEEMSIS_APPEND-occupations_v2", nolab replace firstrow(var)
restore
*À partir du fichier Excel
replace mainoccup=3 if parent_key=="uuid:11d432e5-b567-4279-9729-36fe097f4cb4" & INDID_total==2 & occupationnumber==1
replace mainoccup=3 if parent_key=="uuid:2ef3acc0-a9f2-4124-bf9a-479f6f13ce50" & INDID_total==1 & occupationnumber==2
replace mainoccup=3 if parent_key=="uuid:2ef3acc0-a9f2-4124-bf9a-479f6f13ce50" & INDID_total==3 & occupationnumber==2
*replace mainoccup=4 if parent_key=="uuid:376b5457-41ac-4c8e-9ba5-2c323d76f757" & INDID_total==2 & occupationnumber==2
*replace mainoccup=3 if parent_key=="uuid:376b5457-41ac-4c8e-9ba5-2c323d76f757" & INDID_total==2 & occupationnumber==1
replace mainoccup=3 if parent_key=="uuid:4adf3c67-9056-4e27-ac96-b21b04458534" & INDID_total==1 & occupationnumber==2
replace mainoccup=3 if parent_key=="uuid:4e56a1a6-6cde-4dbd-881f-d2d0c958ef2b" & INDID_total==1 & occupationnumber==2
replace mainoccup=3 if parent_key=="uuid:5672b71a-0908-47a7-bad7-a2d698f59343" & INDID_total==2 & occupationnumber==1
replace mainoccup=3 if parent_key=="uuid:5a18379c-0a47-4f7d-8b1f-c531563200cb" & INDID_total==2 & occupationnumber==2
replace mainoccup=4 if parent_key=="uuid:5b0b3cb1-c758-499a-8126-2aa9a0348795" & INDID_total==1 & occupationnumber==2
replace mainoccup=4 if parent_key=="uuid:60bb2e46-283a-4d26-935b-d541da45193f" & INDID_total==1 & occupationnumber==2
*replace mainoccup=2 if parent_key=="uuid:633153da-cebf-4f97-8304-d573bd8603c4" & INDID_total==1 & occupationnumber==2
*replace mainoccup=4 if parent_key=="uuid:633153da-cebf-4f97-8304-d573bd8603c4" & INDID_total==1 & occupationnumber==3
replace mainoccup=1 if parent_key=="uuid:633153da-cebf-4f97-8304-d573bd8603c4" & INDID_total==2 & occupationnumber==2
*replace mainoccup=1 if parent_key=="uuid:69694844-ee5e-450a-80cb-81d85c7d7e7e" & INDID_total==2 & occupationnumber==2
*replace mainoccup=4 if parent_key=="uuid:69694844-ee5e-450a-80cb-81d85c7d7e7e" & INDID_total==2 & occupationnumber==1
replace mainoccup=3 if parent_key=="uuid:6eac903a-6982-4424-9d2f-72e59de029e7" & INDID_total==1 & occupationnumber==2
*replace mainoccup=3 if parent_key=="uuid:752d1e9e-f217-465d-9de1-c30298fae3b5" & INDID_total==1 & occupationnumber==1
*replace mainoccup=7 if parent_key=="uuid:752d1e9e-f217-465d-9de1-c30298fae3b5" & INDID_total==1 & occupationnumber==2
replace mainoccup=3 if parent_key=="uuid:7dcd5a01-7a25-47c3-b6c6-74836281cf4b" & INDID_total==2 & occupationnumber==2
replace mainoccup=3 if parent_key=="uuid:82adab4c-fe85-4408-b3b7-2812dee63169" & INDID_total==1 & occupationnumber==1
*replace mainoccup=3 if parent_key=="uuid:82adab4c-fe85-4408-b3b7-2812dee63169" & INDID_total==2 & occupationnumber==1
*replace mainoccup=4 if parent_key=="uuid:82adab4c-fe85-4408-b3b7-2812dee63169" & INDID_total==2 & occupationnumber==3
replace mainoccup=2 if parent_key=="uuid:831ac2d3-8b2f-4936-9c96-515eb3940233" & INDID_total==1 & occupationnumber==2
replace mainoccup=4 if parent_key=="uuid:845162bf-a21a-4003-910b-364e995bf863" & INDID_total==3 & occupationnumber==1
replace mainoccup=3 if parent_key=="uuid:86574ca0-02c2-4e2b-9d3b-f644d9c6da68" & INDID_total==1 & occupationnumber==2
replace mainoccup=7 if parent_key=="uuid:86574ca0-02c2-4e2b-9d3b-f644d9c6da68" & INDID_total==2 & occupationnumber==1
replace mainoccup=3 if parent_key=="uuid:8ad24332-a46d-4a5a-82de-79b4a464eb00" & INDID_total==1 & occupationnumber==2
replace mainoccup=7 if parent_key=="uuid:8ad24332-a46d-4a5a-82de-79b4a464eb00" & INDID_total==2 & occupationnumber==2
*replace mainoccup=3 if parent_key=="uuid:995ac354-9b49-4d48-b138-014ac3c62ad1" & INDID_total==1 & occupationnumber==3
*replace mainoccup=5 if parent_key=="uuid:995ac354-9b49-4d48-b138-014ac3c62ad1" & INDID_total==1 & occupationnumber==2
replace mainoccup=4 if parent_key=="uuid:a01b1cb0-bc31-420c-a1e7-f46d3011c81b" & INDID_total==1 & occupationnumber==1
replace mainoccup=7 if parent_key=="uuid:a5864c62-bf01-4313-a7b4-47985821c1e4" & INDID_total==2 & occupationnumber==1
replace mainoccup=2 if parent_key=="uuid:a7b4d739-b69d-4efb-b34a-0b175dd933fe" & INDID_total==1 & occupationnumber==2
replace mainoccup=3 if parent_key=="uuid:a91affc5-be97-47b4-9e48-4ae070e467a2" & INDID_total==1 & occupationnumber==1
replace mainoccup=3 if parent_key=="uuid:a91affc5-be97-47b4-9e48-4ae070e467a2" & INDID_total==2 & occupationnumber==2
replace mainoccup=7 if parent_key=="uuid:b3e4fe70-f2aa-4e0f-bb6e-8fb57bb6f409" & INDID_total==2 & occupationnumber==1
replace mainoccup=4 if parent_key=="uuid:b3f4653f-719d-4f7a-a0e4-82d8bc04659c" & INDID_total==2 & occupationnumber==3
replace mainoccup=4 if parent_key=="uuid:bcf78ad0-0c91-46d0-9ff9-6fd1b508541c" & INDID_total==5 & occupationnumber==1
*replace mainoccup=1 if parent_key=="uuid:c3b80850-9377-4893-b778-d0300231eede" & INDID_total==1 & occupationnumber==2
*replace mainoccup=4 if parent_key=="uuid:c3b80850-9377-4893-b778-d0300231eede" & INDID_total==1 & occupationnumber==4
*replace mainoccup=3 if parent_key=="uuid:c3b80850-9377-4893-b778-d0300231eede" & INDID_total==1 & occupationnumber==3
replace mainoccup=4 if parent_key=="uuid:c97950f1-4a81-4b10-9f91-be004d7f01c9" & INDID_total==1 & occupationnumber==2
replace mainoccup=3 if parent_key=="uuid:caff5415-5d5c-4932-aff5-903c30c0bc79" & INDID_total==1 & occupationnumber==2
replace mainoccup=2 if parent_key=="uuid:d4a5192d-74e4-4cb8-8b48-1d971f68cb54" & INDID_total==1 & occupationnumber==1
replace mainoccup=3 if parent_key=="uuid:dc69d4b1-2609-4936-890f-3a5ca8bc0ed1" & INDID_total==1 & occupationnumber==2
replace mainoccup=7 if parent_key=="uuid:dc69d4b1-2609-4936-890f-3a5ca8bc0ed1" & INDID_total==2 & occupationnumber==1
replace mainoccup=4 if parent_key=="uuid:ddc4ecff-75f2-4877-8e72-1d100d73c88d" & INDID_total==1 & occupationnumber==1
replace mainoccup=3 if parent_key=="uuid:ddc4ecff-75f2-4877-8e72-1d100d73c88d" & INDID_total==2 & occupationnumber==2
replace mainoccup=3 if parent_key=="uuid:e3ff8654-5079-4cb1-ab14-ce83b63d894a" & INDID_total==2 & occupationnumber==1
replace mainoccup=4 if parent_key=="uuid:e5d9e97a-f3b9-49e1-9cde-1ad11dc43009" & INDID_total==3 & occupationnumber==1
replace mainoccup=2 if parent_key=="uuid:f435ac6b-11a5-4273-a5a0-d7f2bb74b5f6" & INDID_total==3 & occupationnumber==2
replace mainoccup=3 if parent_key=="uuid:f9af2892-dbd1-4027-adcf-8271a87cdc44" & INDID_total==1 & occupationnumber==1
*replace mainoccup=3 if parent_key=="uuid:ff2ee18b-8363-4316-96ea-5a41a37094c0" & INDID_total==1 & occupationnumber==2
*replace mainoccup=4 if parent_key=="uuid:ff2ee18b-8363-4316-96ea-5a41a37094c0" & INDID_total==1 & occupationnumber==3
*replace mainoccup=3 if parent_key=="uuid:ff2ee18b-8363-4316-96ea-5a41a37094c0" & INDID_total==1 & occupationnumber==1
*replace mainoccup=4 if parent_key=="uuid:ff2ee18b-8363-4316-96ea-5a41a37094c0" & INDID_total==1 & occupationnumber==4

replace mainoccupname="Agriculture weeding" if parent_key=="uuid:11d432e5-b567-4279-9729-36fe097f4cb4" & INDID_total==2 & occupationnumber==1
replace mainoccupname="Agriculture activities in own farm" if parent_key=="uuid:2ef3acc0-a9f2-4124-bf9a-479f6f13ce50" & INDID_total==1 & occupationnumber==2
replace mainoccupname="Agriculture activities in own farm unpaid" if parent_key=="uuid:2ef3acc0-a9f2-4124-bf9a-479f6f13ce50" & INDID_total==3 & occupationnumber==2
*replace mainoccupname="Chamber" if parent_key=="uuid:376b5457-41ac-4c8e-9ba5-2c323d76f757" & INDID_total==2 & occupationnumber==2
*replace mainoccupname="Chamber" if parent_key=="uuid:376b5457-41ac-4c8e-9ba5-2c323d76f757" & INDID_total==2 & occupationnumber==1
replace mainoccupname="Agriculture activities in own farm unpaid" if parent_key=="uuid:4adf3c67-9056-4e27-ac96-b21b04458534" & INDID_total==1 & occupationnumber==2
replace mainoccupname="Agriculture activities in own farm" if parent_key=="uuid:4e56a1a6-6cde-4dbd-881f-d2d0c958ef2b" & INDID_total==1 & occupationnumber==2
replace mainoccupname="NREGA" if parent_key=="uuid:5672b71a-0908-47a7-bad7-a2d698f59343" & INDID_total==2 & occupationnumber==1
replace mainoccupname="Agriculture activities in own farm" if parent_key=="uuid:5a18379c-0a47-4f7d-8b1f-c531563200cb" & INDID_total==2 & occupationnumber==2
replace mainoccupname="Agricultural cooli" if parent_key=="uuid:5b0b3cb1-c758-499a-8126-2aa9a0348795" & INDID_total==1 & occupationnumber==2
replace mainoccupname="Road contract supervisor" if parent_key=="uuid:60bb2e46-283a-4d26-935b-d541da45193f" & INDID_total==1 & occupationnumber==2
*replace mainoccupname="Agricultural cooli" if parent_key=="uuid:633153da-cebf-4f97-8304-d573bd8603c4" & INDID_total==1 & occupationnumber==2
*replace mainoccupname="Agricultural cooli" if parent_key=="uuid:633153da-cebf-4f97-8304-d573bd8603c4" & INDID_total==1 & occupationnumber==3
replace mainoccupname="Agricultural cooli" if parent_key=="uuid:633153da-cebf-4f97-8304-d573bd8603c4" & INDID_total==2 & occupationnumber==2
*replace mainoccupname="Housewife" if parent_key=="uuid:69694844-ee5e-450a-80cb-81d85c7d7e7e" & INDID_total==2 & occupationnumber==2
*replace mainoccupname="Housewife" if parent_key=="uuid:69694844-ee5e-450a-80cb-81d85c7d7e7e" & INDID_total==2 & occupationnumber==1
replace mainoccupname="Coolie" if parent_key=="uuid:6eac903a-6982-4424-9d2f-72e59de029e7" & INDID_total==1 & occupationnumber==2
*replace mainoccupname="Samosa seller" if parent_key=="uuid:752d1e9e-f217-465d-9de1-c30298fae3b5" & INDID_total==1 & occupationnumber==1
**replace mainoccupname="Samosa seller" if parent_key=="uuid:752d1e9e-f217-465d-9de1-c30298fae3b5" & INDID_total==1 & occupationnumber==2
replace mainoccupname="Agricultural cooli" if parent_key=="uuid:7dcd5a01-7a25-47c3-b6c6-74836281cf4b" & INDID_total==2 & occupationnumber==2
replace mainoccupname="Agriculture activities in own land" if parent_key=="uuid:82adab4c-fe85-4408-b3b7-2812dee63169" & INDID_total==1 & occupationnumber==1
*replace mainoccupname="Agriculture activities in own land unpaid" if parent_key=="uuid:82adab4c-fe85-4408-b3b7-2812dee63169" & INDID_total==2 & occupationnumber==1
*replace mainoccupname="Agriculture activities in own land unpaid" if parent_key=="uuid:82adab4c-fe85-4408-b3b7-2812dee63169" & INDID_total==2 & occupationnumber==3
replace mainoccupname="Agriculture work in own farm" if parent_key=="uuid:831ac2d3-8b2f-4936-9c96-515eb3940233" & INDID_total==1 & occupationnumber==2
replace mainoccupname="Agricultural cooli" if parent_key=="uuid:845162bf-a21a-4003-910b-364e995bf863" & INDID_total==3 & occupationnumber==1
replace mainoccupname="Agriculture activities in own farm" if parent_key=="uuid:86574ca0-02c2-4e2b-9d3b-f644d9c6da68" & INDID_total==1 & occupationnumber==2
replace mainoccupname="Agriculture activities in own farm" if parent_key=="uuid:86574ca0-02c2-4e2b-9d3b-f644d9c6da68" & INDID_total==2 & occupationnumber==1
replace mainoccupname="Agriculture activities in own farm" if parent_key=="uuid:8ad24332-a46d-4a5a-82de-79b4a464eb00" & INDID_total==1 & occupationnumber==2
replace mainoccupname="Agriculture coolie" if parent_key=="uuid:8ad24332-a46d-4a5a-82de-79b4a464eb00" & INDID_total==2 & occupationnumber==2
*replace mainoccupname="Agriculture coolie" if parent_key=="uuid:995ac354-9b49-4d48-b138-014ac3c62ad1" & INDID_total==1 & occupationnumber==3
*replace mainoccupname="Agriculture coolie" if parent_key=="uuid:995ac354-9b49-4d48-b138-014ac3c62ad1" & INDID_total==1 & occupationnumber==2
replace mainoccupname="NREGA" if parent_key=="uuid:a01b1cb0-bc31-420c-a1e7-f46d3011c81b" & INDID_total==1 & occupationnumber==1
replace mainoccupname="Unpaid worker in own land" if parent_key=="uuid:a5864c62-bf01-4313-a7b4-47985821c1e4" & INDID_total==2 & occupationnumber==1
replace mainoccupname="Electrician" if parent_key=="uuid:a7b4d739-b69d-4efb-b34a-0b175dd933fe" & INDID_total==1 & occupationnumber==2
replace mainoccupname="Agriculture activities in own land" if parent_key=="uuid:a91affc5-be97-47b4-9e48-4ae070e467a2" & INDID_total==1 & occupationnumber==1
replace mainoccupname="Agriculture activities in own land unpaid" if parent_key=="uuid:a91affc5-be97-47b4-9e48-4ae070e467a2" & INDID_total==2 & occupationnumber==2
replace mainoccupname="Agriculture coolie" if parent_key=="uuid:b3e4fe70-f2aa-4e0f-bb6e-8fb57bb6f409" & INDID_total==2 & occupationnumber==1
replace mainoccupname="Agriculture coolie" if parent_key=="uuid:b3f4653f-719d-4f7a-a0e4-82d8bc04659c" & INDID_total==2 & occupationnumber==3
replace mainoccupname="Agricultural cooli" if parent_key=="uuid:bcf78ad0-0c91-46d0-9ff9-6fd1b508541c" & INDID_total==5 & occupationnumber==1
*replace mainoccupname="NREGA" if parent_key=="uuid:c3b80850-9377-4893-b778-d0300231eede" & INDID_total==1 & occupationnumber==2
*replace mainoccupname="NREGA" if parent_key=="uuid:c3b80850-9377-4893-b778-d0300231eede" & INDID_total==1 & occupationnumber==4
*replace mainoccupname="NREGA" if parent_key=="uuid:c3b80850-9377-4893-b778-d0300231eede" & INDID_total==1 & occupationnumber==3
replace mainoccupname="Agriculture own land working" if parent_key=="uuid:c97950f1-4a81-4b10-9f91-be004d7f01c9" & INDID_total==1 & occupationnumber==2
replace mainoccupname="Agriculture activities in own farm" if parent_key=="uuid:caff5415-5d5c-4932-aff5-903c30c0bc79" & INDID_total==1 & occupationnumber==2
replace mainoccupname="Gouva selling" if parent_key=="uuid:d4a5192d-74e4-4cb8-8b48-1d971f68cb54" & INDID_total==1 & occupationnumber==1
replace mainoccupname="Agriculture own land" if parent_key=="uuid:dc69d4b1-2609-4936-890f-3a5ca8bc0ed1" & INDID_total==1 & occupationnumber==2
replace mainoccupname="Agriculture own land unpaid works" if parent_key=="uuid:dc69d4b1-2609-4936-890f-3a5ca8bc0ed1" & INDID_total==2 & occupationnumber==1
replace mainoccupname="Agriculture coolie" if parent_key=="uuid:ddc4ecff-75f2-4877-8e72-1d100d73c88d" & INDID_total==1 & occupationnumber==1
replace mainoccupname="Coolie" if parent_key=="uuid:ddc4ecff-75f2-4877-8e72-1d100d73c88d" & INDID_total==2 & occupationnumber==2
replace mainoccupname="Agricultural cooli" if parent_key=="uuid:e3ff8654-5079-4cb1-ab14-ce83b63d894a" & INDID_total==2 & occupationnumber==1
replace mainoccupname="Agri coolie" if parent_key=="uuid:e5d9e97a-f3b9-49e1-9cde-1ad11dc43009" & INDID_total==3 & occupationnumber==1
replace mainoccupname="Driver (Tata ace own vehicle)" if parent_key=="uuid:f435ac6b-11a5-4273-a5a0-d7f2bb74b5f6" & INDID_total==3 & occupationnumber==2
replace mainoccupname="Agriculture activities in own farm" if parent_key=="uuid:f9af2892-dbd1-4027-adcf-8271a87cdc44" & INDID_total==1 & occupationnumber==1
*replace mainoccupname="Agricultural cooli" if parent_key=="uuid:ff2ee18b-8363-4316-96ea-5a41a37094c0" & INDID_total==1 & occupationnumber==2
*replace mainoccupname="Agricultural cooli" if parent_key=="uuid:ff2ee18b-8363-4316-96ea-5a41a37094c0" & INDID_total==1 & occupationnumber==3
*replace mainoccupname="Agricultural cooli" if parent_key=="uuid:ff2ee18b-8363-4316-96ea-5a41a37094c0" & INDID_total==1 & occupationnumber==1
*replace mainoccupname="Agricultural cooli" if parent_key=="uuid:ff2ee18b-8363-4316-96ea-5a41a37094c0" & INDID_total==1 & occupationnumber==4



**********Indiv
*max income or hours (income only for 2010)
bysort parent_key INDID : egen maxhours_indiv=max(hoursayear)
*occup name and occup type with the max
replace mainoccup=kindofwork if maxhours_indiv==hoursayear & mainoccup==.
replace mainoccupname=occupationname if maxhours_indiv==hoursayear & mainoccupname==""
*encode name to simplify the procedure
encode mainoccupname, gen(mainoccupnamenumeric)
*put main occupation at indiv level
bysort parent_key INDID : egen mainoccupation=max(mainoccup)
bysort parent_key INDID : egen mainoccupationname=max(mainoccupnamenumeric)
*put the label
label values mainoccupation kindofwork
label values mainoccupationname mainoccupnamenumeric
*decode the name to compare between the waves
decode mainoccupationname, gen(_mainoccupationname)
drop mainoccupationname
rename _mainoccupationname mainoccupationname
*total income
bysort parent_key INDID: egen totalincome_indiv=sum(annualincome)
*nb of income sources
fre kindofwork
bysort parent_key INDID: egen nboccupation_indiv=sum(countoccupation)
*cleaning
rename mainoccupation mainoccupation_indiv
rename mainoccupationname mainoccupationname_indiv
drop maxhours_indiv mainoccup mainoccupname mainoccupnamenumeric countoccupation


**********HH
*max income or hours (income only for 2010)
fre kindofwork
forvalues i=1(1)8{
bysort parent_key : egen maxhours_`i'=sum(hoursayear) if kindofwork==`i'
}
forvalues i=1(1)8{
bysort parent_key : egen maxhours2_`i'=max(maxhours_`i')
recode maxhours2_`i' (.=0)
drop maxhours_`i'
}
*occup type with the max
egen mainoccup=rowmax(maxhours2_1 maxhours2_2 maxhours2_3 maxhours2_4 maxhours2_5 maxhours2_6 maxhours2_7 maxhours2_8)
*occup name and occup type with the max
gen mainoccup2=.
forvalues i=1(1)8{
replace mainoccup2=`i' if maxhours2_`i'==mainoccup
}
*put the label
label values mainoccup2 kindofwork
drop mainoccup maxhours2_1 maxhours2_2 maxhours2_3 maxhours2_4 maxhours2_5 maxhours2_6 maxhours2_7 maxhours2_8
rename mainoccup2 mainoccupation_HH
*total income
bysort parent_key : egen totalincome_HH=sum(annualincome)
*nb of income sources
fre kindofwork
gen countoccupation=1
bysort parent_key : egen nboccupation_HH=sum(countoccupation)
drop countoccupation


**********Indiv base
bysort parent_key INDID: gen n=_n 
keep if n==1
keep mainoccupation_indiv mainoccupationname_indiv totalincome_indiv nboccupation_indiv mainoccupation_HH totalincome_HH nboccupation_HH parent_key INDID
save"NEEMSIS_APPEND-occupations_v3.dta", replace
*1135 indiv

**********Merge dans la base HH
use"NEEMSIS_APPEND_v7.dta", clear
tab dummyworkedpastyear
/*
1140 indiv
Why this difference of five?
*/

merge m:1 parent_key INDID_total using "NEEMSIS_APPEND-occupations_v3.dta"
drop _merge

recode mainoccupation_indiv mainoccupation_HH (.=0)

preserve
bysort parent_key: gen n=_n
keep if n==1
fre mainoccupation_HH
restore

save"NEEMSIS_APPEND_v8.dta", replace
****************************************
* END












****************************************
* 2016 DATA PRELOAD for sex, etc.
****************************************
use"NEEMSIS_APPEND_v8.dta", clear
merge m:1 INDIDpanel using "$directory\do_not_drop\NEEMSIS_preload2016"
drop if _merge==2
drop HHID
rename _merge preload2016
sort preload2016
recode preload2016 (1=0) (3=1)
label list
label values preload2016 yesno
tab preload2016
rename preload2016 dummy_preload2016

save"NEEMSIS_APPEND_v9.dta", replace


****************************************
* END
















****************************************
* SEX CASTE EDUCATION
****************************************
use"NEEMSIS_APPEND_v9.dta", clear

********** HOW MUCH PRESENT ON NEEMSIS2 survey?
gen respondent2020=.
replace respondent2020=0 if INDID_left!=.
replace respondent2020=1 if INDID_left==.
tab respondent2020, m
tab livinghome respondent2020, m
rename respondent2020 dummy_respondent2020


********** Caste
tab caste
destring castepreload2016, replace
tab castepreload2016
tab caste_p16

replace caste=castepreload2016 if caste==. & castepreload2016!=.
tab caste

gen caste_group=.
foreach x in 2 3{
replace caste_group=1 if caste==`x'
}
foreach x in 1 5 7 8 10 12 15 16{
replace caste_group=2 if caste==`x'
}
foreach x in 4 6 11 13 17{
replace caste_group=3 if caste==`x'
}
label define castecat 1"Dalits" 2"Middle" 3"Upper", replace
label values caste_group castecat
tab caste_group
label list
label values caste caste
rename caste jatis

order parent_key HHID_panel HHID2010 householdid2020 villageid villagearea jatis caste_group , first
rename caste_group caste





********** Egoid
rename ego egoid






********** Name
tab name
sort name
sort householdid2020
list marriedid name marriedname marriagesomeoneelse namefrompreload name_p16 HHID2010 if marriedname!="",clean
replace name=namefrompreload if name=="" & namefrompreload!=""
tab name if dummy_respondent2020==1



********** Sex
destring sex, replace
replace sex_new=sex_p16 if sex_new==. & sex_p16!=.
replace sex_new=sex if sex_new==. & sex!=.
tab sex_new
drop sex sex_p16 
rename sex_new sex
tab sex if dummy_respondent2020==1





********** Age
destring age, replace
destring agefromearlier1, replace
replace age=agefromearlier1 if age==. & agefromearlier1!=.
replace age=age_p16+3 if age==. & INDID_left!=.
sum age if dummy_respondent2020==1




********** Education
foreach x in everattendedschool classcompleted{
replace `x'=`x'_p16 if `x'==. & `x'_p16!=.
}
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
tab edulevel if dummy_respondent2020==1
tab age if edulevel==.
replace edulevel=0 if edulevel==. & age<4
tab edulevel livinghome, m

list parent_key INDID	INDID_total	INDID_former	INDID_new	INDID_left name version_HH if livinghome==1 & edulevel==., clean noobs
/*
                                   parent_key   INDID   INDID_~l   INDID_~r   INDID_~w   INDID_~t          name           version_HH  
    uuid:cd6b0c54-a3bf-40f5-9a46-4860744cc378       6          6          .          6          .      Keerthas   NEEMSIS2_NEW_APRIL  
*/

order parent_key HHID_panel HHID2010 householdid2020 villageid villagearea jatis caste  INDID INDID_total INDID_former INDID_new INDID_left egoid name sex age edulevel, first






********** Encode version
tab version_HH
tab version_agri

rename version_HH _version_HH
gen version_HH=.
replace version_HH=1 if _version_HH=="NEEMSIS2_LAST"
replace version_HH=2 if _version_HH=="NEEMSIS2_DEC"
replace version_HH=3 if _version_HH=="NEEMSIS2_DECEMBER"
replace version_HH=4 if _version_HH=="NEEMSIS2_FEB"
replace version_HH=5 if _version_HH=="NEEMSIS2_FEBRUARY"
replace version_HH=6 if _version_HH=="NEEMSIS2_APRIL"
replace version_HH=7 if _version_HH=="NEEMSIS2_NEW_APRIL"
label define version_HH 1"LAST" 2"DEC" 3"DECEMBER" 4"FEB" 5"FEBRUARY" 6"APRIL" 7"NEW_APRIL", replace
label values version_HH version_HH
drop _version_HH

rename version_agri _version_agri
gen version_agri=.
replace version_agri=1 if _version_agri=="NEEMSIS2_Agriculture"
replace version_agri=2 if _version_agri=="NEEMSIS2_DEC_Agriculture"
replace version_agri=3 if _version_agri=="NEEMSIS2_DECEMBER_Agriculture"
replace version_agri=4 if _version_agri=="NEEMSIS2_FEBRUARY_Agriculture"
replace version_agri=5 if _version_agri=="NEEMSIS2_FEB_NEW_Agriculture"
label define version_agri 1"Agriculture" 2"DEC_Agriculture" 3"DECEMBER_Agriculture" 4"FEBRUARY_Agriculture" 5"FEB_NEW_Agriculture", replace
label values version_agri version_agri
drop _version_agri



********** Year
gen year=2020






**********Cleaning
rename marriedid_o old_marriedid
rename egoid_p16 egoid_panel
drop*_p16
drop loandetails* loanlender* threemainloans_* 
drop *_o
drop selected_index1 selected_index2 selected_index3 selected_name1 selected_name2 selected_name3 selected_index1_2 selected_index2_2 selected_index3_2 selected_name1_2 selected_name2_2 selected_name3_2 selected_index1_3 selected_index2_3 selected_index3_3 selected_name1_3 selected_name2_3 selected_name3_3 _3selected_index1 _3selected_index2 _3selected_index3 _3selected_name1 _3selected_name2 _3selected_name3 _3selected_index1_2 _3selected_index2_2 _3selected_index3_2 _3selected_name1_2 _3selected_name2_2 _3selected_name3_2 _3ego2random_3_2 _3selected_index1_3 _3selected_index2_3 _3selected_index3_3 _3selected_name1_3 _3selected_name2_3 _3selected_name3_3 _3ego2random_1_3 _3ego2random_2_3 _3ego2random_3_3
drop joinnamehhmemberego1 joinnamehhmember join_1825 join_2635 join_36 _3join_1825 _3join_2635 _3join_36
drop setofrandom_draws_3 setofrandom_draws_2 setofrandom_draws setof_3random_draws_3 setof_3random_draws_2 setof_3random_draws random_draws_count random_draws_3_count random_draws_2_count ego2random_3_3 ego2random_3_2 ego2random_3 ego2random_2_3 ego2random_2_2 ego2random_2 ego2random_1_3 ego2random_1_2 ego2random_1 _3random_draws_count _3random_draws_3_count _3random_draws_2_count _3ego2random_3 _3ego2random_2_2 _3ego2random_2 _3ego2random_1_2 _3ego2random_1
drop uniquelistego2 uniquelistego1 unique_draws_3 unique_draws_2 unique_draws _3unique_draws_3 _3unique_draws_2 _3unique_draws

drop _2businessloandetails_count _2contactgroup_count _2covsntypehelpgivengroup_count _2covsntypehelpreceivedgroup_cou _2formalsocialcapital_count _2indoccupmonths_count _3businessloandetails_count _3contactgroup_count _3count_eligible_1825 _3count_eligible_2635 _3count_eligible_36 _3covsntypehelpgivengroup_count _3covsntypehelpreceivedgroup_cou _3ego2index_1825 _3ego2index_2635 _3ego2index_36 _3formalsocialcapital_count _3indoccupmonths_count _3show_draws_2_count _3show_draws_3_count _3show_draws_count


save"NEEMSIS_APPEND_v10.dta", replace
****************************************
* END





















****************************************
* Assets
****************************************
use"NEEMSIS_APPEND_v10.dta", clear

**********Equipment
fre equipmentlist
fre equipmentname1 equipmentname2 equipmentname4
foreach x in equipmentname equipmentnb equipmentcost equipmentpledged {
rename `x'1 `x'_tractor
rename `x'2 `x'_bullockcart
capture confirm v `x'3
if _rc==0{
rename `x'3 `x'_harvester
}
rename `x'4 `x'_plowingmach
capture confirm v `x'5
if _rc==0{
rename `x'5 `x'_none
}
}

foreach x in equipmentlist_ equipmentborrowedlist_ covsellequipment_{
rename `x'1 `x'tractor
rename `x'2 `x'bullockcar
rename `x'3 `x'harvester
rename `x'4 `x'plowingmac
rename `x'5 `x'none
}


**********Gold
tab goldquantity
replace goldquantity=50 if goldquantity==120000  //120 000 / 2700 = 44.4 donc 50

gen goldquantityamount=goldquantity*2700
bysort HHID2010 : egen goldquantityamount2=max(goldquantityamount)
drop goldquantityamount
rename goldquantityamount2 goldquantityamount
recode goldquantityamount (.=0)

**********Land
tab drywetownland

replace sizedryownland=sizeownland if drywetownland=="1" & sizedryownland==. & sizeownland!=.
replace sizewetownland=sizeownland if drywetownland=="2" & sizewetownland==. & sizeownland!=.

gen amountownlanddry=sizedryownland*600000
gen amountownlandwet=sizewetownland*800000
gen amountownland=amountownlanddry+amountownlandwet
*if both half
replace amountownland=sizeownland*700000 if drywetownland=="1 2" & sizedryownland==. & sizewetownland==.


**********Livestock
fre livestockname*
foreach x in livestockname livestocknb livestockprice livestockuse {
rename `x'1 `x'_cow
rename `x'2 `x'_goat
rename `x'3 `x'_chicken
rename `x'4 `x'_bullock
rename `x'5 `x'_bullforploughing
}

foreach x in covselllivestock_{
rename `x'1 `x'cow
rename `x'2 `x'goat
rename `x'3 `x'chicken
rename `x'4 `x'bullock
rename `x'5 `x'bullforploughin
rename `x'6 `x'none
}


drop livestocklist_1 livestocklist_2 livestocklist_3 livestocklist_4 livestocklist_5 livestocklist_6
drop livestockname_*

foreach x in cow goat chicken bullock bullforploughing {
clonevar livestockamount_`x'=livestockprice_`x'
recode livestockamount_`x' (.=0)
}


**********Good total amount
fre goodname*
foreach x in goodname numbergoods goodyearpurchased goodtotalamount goodbuying goodsourcecredit goodcreditsettled {
rename `x'1 `x'_car
rename `x'2 `x'_bike
rename `x'3 `x'_fridge
rename `x'4 `x'_furniture
rename `x'5 `x'_tailormach
rename `x'6 `x'_phone
rename `x'7 `x'_landline
capture confirm v `x'8
if _rc==0{
rename `x'8 `x'_DVD
}
capture confirm v `x'9
if _rc==0{
rename `x'9 `x'_camera
}
rename `x'10 `x'_cookgas
rename `x'11 `x'_computer
rename `x'12 `x'_antenna
}

*covid19
foreach x in covsellgoods_{
rename `x'1 `x'car
rename `x'2 `x'bike
rename `x'3 `x'fridge
rename `x'4 `x'furniture
rename `x'5 `x'tailormach
rename `x'6 `x'phone
rename `x'7 `x'landline
rename `x'8 `x'DVD
rename `x'9 `x'camera
rename `x'10 `x'cookgas
rename `x'11 `x'computer
rename `x'12 `x'antenna
rename `x'13 `x'none
rename `x'77 `x'other
}


****Cleaning for goods
*Car
replace numbergoods_car=1 if othergood=="Auto"
replace goodtotalamount_car=100000  if othergood=="Auto"

replace numbergoods_car=1 if othergood=="407 lorry"
replace goodtotalamount_car=100000  if othergood=="407 lorry"

replace numbergoods_car=1 if othergood=="TATA a/c vehicle"
replace goodtotalamount_car=100000 if othergood=="TATA a/c vehicle"

replace numbergoods_car=1 if othergood=="Tata ace vehicle"
replace goodtotalamount_car=100000  if othergood=="Tata ace vehicle"

replace numbergoods_car=1 if othergood=="Television, Auto"
replace goodtotalamount_car=100000 if othergood=="Television, Auto"

replace numbergoods_car=1 if othergood=="Tractor"
replace goodtotalamount_car=100000 if othergood=="Tractor"

replace numbergoods_car=1 if othergood=="Van"
replace goodtotalamount_car=100000 if othergood=="Van"

replace numbergoods_car=1 if strpos(othergood,"Fan, mixey, grinder, auto")
replace goodtotalamount_car=100000  if strpos(othergood,"Fan, mixey, grinder, auto")

replace numbergoods_car=1 if strpos(othergood,"Tv,mixey, grinder, fan,Ac, tractor,")
replace goodtotalamount_car=100000 if strpos(othergood,"Tv,mixey, grinder, fan,Ac, tractor,")

*Bike
*br if strpos(othergood, "Three wheeler scooty for his disable")
replace numbergoods_bike=1 if strpos(othergood,"Three wheeler scooty for his disable")

*We create tv
gen numbergoods_TV=0
replace numbergoods_TV=1 if strpos(othergood,"Television")
replace numbergoods_TV=1 if strpos(othergood,"television")
replace numbergoods_TV=1 if strpos(othergood,"TV")
replace numbergoods_TV=1 if strpos(othergood,"Tv")
replace numbergoods_TV=1 if strpos(othergood,"tv")

gen goodtotalamount_TV=.
replace goodtotalamount_TV=numbergoods_TV*1000


*goodtotalamount
gen goodtotalamount_DVD=0
gen goodtotalamount_camera=0

egen goodtotalamount=rowtotal(goodtotalamount_car goodtotalamount_cookgas goodtotalamount_computer goodtotalamount_antenna goodtotalamount_bike goodtotalamount_fridge goodtotalamount_furniture goodtotalamount_tailormach goodtotalamount_phone goodtotalamount_landline goodtotalamount_DVD goodtotalamount_camera goodtotalamount_TV)
recode goodtotalamount (.=0)


**********ASSETS
egen assets=rowtotal(amountownland livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock livestockamount_bullforploughing housevalue goldquantityamount goodtotalamount)
egen assets_noland=rowtotal(livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock housevalue goldquantityamount goodtotalamount)


save"NEEMSIS_APPEND_v11.dta", replace
****************************************
* END











****************************************
* Cognition
****************************************
use"NEEMSIS_APPEND_v11.dta", clear

***Raven
*right answers
gen set_a1=4
gen set_a2=5
gen set_a3=1
gen set_a4=2
gen set_a5=6
gen set_a6=3
gen set_a7=6
gen set_a8=2
gen set_a9=1
gen set_a10=3
gen set_a11=4
gen set_a12=5

gen set_ab1=4
gen set_ab2=5
gen set_ab3=1
gen set_ab4=6
gen set_ab5=2
gen set_ab6=1
gen set_ab7=3
gen set_ab8=4
gen set_ab9=6
gen set_ab10=3
gen set_ab11=5
gen set_ab12=2

gen set_b1=2
gen set_b2=6
gen set_b3=1
gen set_b4=2
gen set_b5=1
gen set_b6=3
gen set_b7=5
gen set_b8=6
gen set_b9=4
gen set_b10=3
gen set_b11=4
gen set_b12=5

*Number of correct answers
forval i=1(1)12 {
gen ra`i'=0 	if a`i' !=.
gen rab`i'=0 	if ab`i' !=.
gen rb`i'=0 	if b`i' !=.
}
forval i=1(1)12 {
replace ra`i'=1  if a`i'==set_a`i' 	
replace rab`i'=1 if ab`i'==set_ab`i' 
replace rb`i'=1  if b`i'==set_b`i' 
}	
drop set_a1-set_a12
drop set_ab1-set_ab12
drop set_b1-set_b12

*Total score 
egen set_a = rowtotal (ra1 ra2 ra3 ra4 ra5 ra6 ra7 ra8 ra9 ra10 ra11 ra12), missing
egen set_ab = rowtotal (rab1 rab2 rab3 rab4 rab5 rab6 rab7 rab8 rab9 rab10 rab11 rab12), missing 
egen set_b = rowtotal (rb1 rb2 rb3 rb4 rb5 rb6 rb7 rb8 rb9 rb10 rb11 rb12), missing
egen raven_tt = rowtotal (set_a set_b set_ab)
tab1 set_a set_ab set_b raven_tt


*********Numeracy & literacy
global literacy canreadcard1a canreadcard1b canreadcard1c canreadcard2
global numeracy numeracy1 numeracy2 numeracy3 numeracy4 numeracy5 numeracy6
global cog $literacy $numeracy

*composite score
*recode no response as missing for easier analysis
foreach x of varlist $cog {
recode `x' (99=.) 
}
foreach x of varlist $numeracy {
recode `x' (2=0)
}
foreach x of varlist $literacy {
recode `x' (1=0) (3=1) (2=0.5) 
}
**Look at missing values 	
mdesc $cog

mdesc $literacy if canreadcard1a==. //those are mostly the same people 
tab edulevel if canreadcard1a==. //code as can't read if edulevel max primary completed 
gen refuse=0
replace refuse=1 if (canreadcard1a+canreadcard1b+canreadcard1c+canreadcard2==.)
recode $literacy (.=0) if edulevel<=1

mdesc numeracy6 numeracy5 numeracy4 numeracy3 numeracy2 if numeracy1==. 
tab edulevel if numeracy1==. 
replace refuse=1 if (numeracy1+numeracy2+numeracy3+numeracy4+numeracy5+numeracy6==.)

recode numeracy6 numeracy5 numeracy4 numeracy3 numeracy2 numeracy1 (.=0) if edulevel<=1	

egen num_tt = rowtotal(numeracy1 numeracy2 numeracy3 numeracy4 numeracy5 numeracy6), missing 
egen lit_tt = rowtotal(canreadcard1a canreadcard1b canreadcard1c canreadcard2), missing 



*********Cleaning
global big5 ///
curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts  ///
workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers ///
managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm ///
tryhard  stickwithg~s   goaftergoal finishwhat~n finishtasks  keepworking

global locus locuscontrol1 locuscontrol2 locuscontrol3 locuscontrol4 locuscontrol5 locuscontrol6 

mdesc $big5 $locus

alpha curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination, casewise  // .74
alpha organized  makeplans workhard appointmentontime putoffduties easilydistracted completeduties, casewise  // .65 
alpha enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople  talkative expressingthoughts, casewise  // .64 
alpha workwithother  understandotherfeeling trustingofother rudetoother toleratefaults  forgiveother  helpfulwithothers, casewise  // .54 
alpha managestress  nervous  changemood feeldepressed easilyupset worryalot  staycalm, casewise  // .66 
alpha tryhard  stickwithg~s   goaftergoal finishwhat~n finishtasks  keepworking, casewise  // .66 
alpha $locus, casewise  // nickel

*recode all so that more is better! 
foreach var of varlist $big5 {
recode `var' (5=1) (4=2) (3=3) (2=4) (1=5)
}


**Correction du biais d'"acquiescence"
*Paires
local varlist ///
rudetoother helpfulwit~s  ///
putoffduties 	completedut~s /// 
easilydistracted makeplans  ///
shywithpeople talktomany~e ///
repetitive~s curious  ///
nervous staycalm ///  
worryalot managestress 

tab rudetoother helpfulwit~s,  cell  // AG
tab putoffduties completedut~s, nofreq cell  // acquiesence bias CO
tab easilydistracted makeplans, nofreq cell  // same.. CO
tab shywithpeople talktomany~e, nofreq cell  // EX
tab repetitive~s curious, nofreq cell  // same.. OP
tab nervous staycalm, nofreq cell  // same.. ES
tab worryalot managestress, nofreq cell  // same.. ES


*moyenne
egen ars=rowmean(`varlist') 
tabstat ars, stat(n mean sd q min max)
ttest ars==3
tab ars
gen ars2=ars-3  
sum ars 
ttest ars=3 
*recode reversely coded items 
foreach var of varlist rudetoother putoffduties easilydistracted shywithpeople repetitive~s nervous changemood feeldepres easilyupset worryalot {
gen raw_`var' = `var' 	
recode `var' (5=1) (4=2) (3=3) (2=4) (1=5)
}
*corrected items: 
foreach var of varlist $big5 {
gen cr_`var'=`var'-ars2 if ars!=. 
}
	
**Moyenne pour avoir les traits
egen cr_OP = rowmean(cr_curious cr_interested~t   cr_repetitive~s cr_inventive cr_liketothink cr_newideas cr_activeimag~n)
egen cr_CO = rowmean(cr_organized  cr_makeplans cr_workhard cr_appointmen~e cr_putoffduties cr_easilydist~d cr_completedu~s) 
egen cr_EX = rowmean(cr_enjoypeople cr_sharefeeli~s cr_shywithpeo~e  cr_enthusiastic  cr_talktomany~e  cr_talkative cr_expressing~s ) 
egen cr_AG = rowmean(cr_workwithot~r   cr_understand~g cr_trustingof~r cr_rudetoother cr_toleratefa~s  cr_forgiveother  cr_helpfulwit~s) 
egen cr_ES = rowmean(cr_managestress  cr_nervous  cr_changemood cr_feeldepres~d cr_easilyupset cr_worryalot  cr_staycalm) 
egen cr_Grit = rowmean(cr_tryhard  cr_stickwithg~s   cr_goaftergoal cr_finishwhat~n cr_finishtasks  cr_keepworking)

egen OP = rowmean(curious interested~t  repetitive~s inventive liketothink newideas activeimag~n)
egen CO = rowmean(organized  makeplans workhard appointmen~e putoffduties easilydist~d completedu~s) 
egen EX = rowmean(enjoypeople sharefeeli~s shywithpeo~e enthusiastic talktomany~e  talkative expressing~s ) 
egen AG = rowmean(workwithot~r understand~g trustingof~r rudetoother toleratefa~s forgiveother helpfulwit~s) 
egen ES = rowmean(managestress nervous changemood feeldepres~d easilyupset worryalot staycalm) 
egen Grit = rowmean(tryhard stickwithg~s  goaftergoal finishwhat~n finishtasks keepworking)


**Alpha
alpha curious 		interested~t   repetitive~s inventive liketothink newideas activeimag~n
alpha cr_curious cr_interested~t   cr_repetitive~s cr_inventive cr_liketothink cr_newideas cr_activeimag~n

alpha organized  makeplans workhard appointmen~e putoffduties easilydist~d completedu~s
alpha cr_organized  cr_makeplans cr_workhard cr_appointmen~e cr_putoffduties cr_easilydist~d cr_completedu~s
	
alpha enjoypeople sharefeeli~s shywithpeo~e  enthusiastic  talktomany~e  talkative expressing~s 
alpha cr_enjoypeople cr_sharefeeli~s cr_shywithpeo~e  cr_enthusiastic  cr_talktomany~e  cr_talkative cr_expressing~s
	
alpha workwithot~r   understand~g trustingof~r rudetoother toleratefa~s  forgiveother  helpfulwit~s
alpha cr_workwithot~r   cr_understand~g cr_trustingof~r cr_rudetoother cr_toleratefa~s  cr_forgiveother  cr_helpfulwit~s 
	
alpha managestress  nervous  changemood feeldepres~d easilyupset worryalot  staycalm 
alpha cr_managestress  cr_nervous  cr_changemood cr_feeldepres~d cr_easilyupset cr_worryalot  cr_staycalm
	
alpha tryhard  stickwithg~s   goaftergoal finishwhat~n finishtasks  keepworking	
alpha cr_tryhard  cr_stickwithg~s   cr_goaftergoal cr_finishwhat~n cr_finishtasks  cr_keepworking


save"NEEMSIS_APPEND_v12.dta", replace
****************************************
* END








****************************************
* Cognition imputations for missings
****************************************
use"NEEMSIS_APPEND_v12.dta", clear


global big5  ///
	cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts ///
	cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers /// 
	cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot cr_staycalm ///
	cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination ///
	cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties ///
	cr_tryhard cr_stickwithgoals cr_goaftergoal cr_finishwhatbegin cr_finishtasks cr_keepworking

global big5questionsnogrit curious interestedbyart repetitivetasks inventive liketothink newideas activeimagination ///
organized makeplans workhard appointmentontime putoffduties easilydistracted completeduties ///
enjoypeople sharefeelings shywithpeople enthusiastic talktomanypeople talkative expressingthoughts ///
workwithother understandotherfeeling trustingofother rudetoother toleratefaults forgiveother ///
helpfulwithothers managestress nervous changemood feeldepressed easilyupset worryalot staycalm
	
*1. Vérif des missings
gen nmiss=0
foreach x in $big5{
replace nmiss=nmiss+1 if `x'==.
}
tab nmiss
*2. Imputation avec les moyennes par sexe pour ne pas perdre des individus
foreach x in $big5{
gen im`x'=`x'
}
global big5i imcr_curious imcr_interestedbyart imcr_repetitivetasks imcr_inventive imcr_liketothink imcr_newideas imcr_activeimagination ///
imcr_organized imcr_makeplans imcr_workhard imcr_appointmentontime imcr_putoffduties imcr_easilydistracted imcr_completeduties ///
imcr_enjoypeople imcr_sharefeelings imcr_shywithpeople imcr_enthusiastic imcr_talktomanypeople imcr_talkative imcr_expressingthoughts ///
imcr_workwithother imcr_understandotherfeeling imcr_trustingofother imcr_rudetoother imcr_toleratefaults imcr_forgiveother ///
imcr_helpfulwithothers imcr_managestress imcr_nervous imcr_changemood imcr_feeldepressed imcr_easilyupset imcr_worryalot imcr_staycalm
forvalues j=1(1)3{
forvalues i=1(1)2{
foreach x in $big5i{
sum `x' if sex==`i' & caste==`j' & egoid!=0 & egoid!=.
replace `x'=r(mean) if `x'==. & sex==`i' & caste==`j' & egoid!=0 & egoid!=.
}
}
}
*3. Check imputations
replace nmiss=0 if egoid!=0 & egoid!=.
foreach x in $big5i{
replace nmiss=nmiss+1 if `x'==.
}
tab nmiss egoid, m
drop nmiss


save"NEEMSIS_APPEND_v13.dta", replace
****************************************
* END






****************************************
* CLEANING
****************************************
use"NEEMSIS_APPEND_v13.dta", clear
drop reasonnoinsurance_1 reasonnoinsurance_2 reasonnoinsurance_3
drop usemobilefinancetype_1 usemobilefinancetype_4 usemobilefinancetype_3 usemobilefinancetype_2 usemobilefinancetype_77
drop reservationgrade_12 reservationgrade_10 reservationgrade_7 reservationgrade_9 reservationgrade_8 reservationgrade_6 reservationgrade_11 reservationgrade_3 reservationgrade_16 reservationgrade_15 reservationgrade_5 reservationgrade_4 reservationgrade_1 reservationgrade_2 reservationkind_3 reservationkind_1 reservationkind_2 reservationkind_5 reservationkind_77 reasonneverattendedschool_13 reasonneverattendedschool_1 reasonneverattendedschool_7 reasonneverattendedschool_11 reasondropping_1 reasondropping_11 reasondropping_7 reasondropping_2 reasondropping_5 reasondropping_15 reasondropping_9 reasondropping_77 reasondropping_12 kindofworkinactive_1 kindofworkinactive_2 kindofworkinactive_3 kindofworkinactive_4 kindofworkinactive_5 kindofworkinactive_6 kindofworkinactive_7 kindofworkinactive_8 migrationjoblist_1 migrationjoblist_2 migrationjoblist_3 migrationjoblist_4 migrationjoblist_5 migrationjoblist_6 migrationjoblist_7 migrationjoblist_8 migrationjoblist_9
drop relationwithborrower_7 relationwithborrower_3 relationwithborrower_8 relationwithborrower_5
drop goldreasonpledge_1 goldreasonpledge_2 goldreasonpledge_3 goldreasonpledge_4 goldreasonpledge_5 goldreasonpledge_6 goldreasonpledge_7 goldreasonpledge_8 goldreasonpledge_9 goldreasonpledge_10 goldreasonpledge_11 goldreasonpledge_12 goldreasonpledge_77
drop reservationkind_4 reasonneverattendedschool_5 reasonneverattendedschool_4 reasonneverattendedschool_6 reasonneverattendedschool_8 reasonneverattendedschool_3 reasonneverattendedschool_10 reasonneverattendedschool_12 reasondropping_3 reasondropping_4 reasondropping_6 reasondropping_13 reasondropping_10 relationwithborrower_6 relationwithborrower_9 relationwithborrower_2 relationwithborrower_13 relationwithborrower_11 reasondropping_8 relationwithborrower_1
drop reasonnoland_1 reasonnoland_2 reasonnoland_3 reasonnoland_4 reasonnoland_77 drywetownland_2 drywetownland_1 waterfromownland_3 waterfromownland_5 drywetleaseland_1 drywetleaseland_2 waterfromleaseland_5 waterfromleaseland_3 landleaserrelation_8 productlist_1 productlist_2 productlist_3 productlist_4 productlist_5 productlist_6 productlist_7 productlist_8 productlist_9 productlist_10 productlist_11 productlist_12 productlist_13 productlist_14 productlist_77
drop covexpensesdecrease_1 covexpensesdecrease_4 covexpensesdecrease_3 covexpensesdecrease_7 covexpensesdecrease_2 covexpensesdecrease_5 covexpensesdecrease_6 covexpensesdecrease_9 covexpensesdecrease_8 covexpensesincrease_3 covexpensesincrease_8 covexpensesincrease_1 covexpensesincrease_2 covexpensesincrease_9 covexpensesincrease_4 covexpensesincrease_7 covexpensesincrease_6 covexpensesstable_9 covexpensesstable_5 covexpensesstable_3 covexpensesstable_4 covexpensesstable_6 covexpensesstable_8 listgoods_1 listgoods_2 listgoods_3 listgoods_4 listgoods_5 listgoods_6 listgoods_7 listgoods_8 listgoods_9 listgoods_10 listgoods_11 listgoods_12 listgoods_77 listgoods_13
drop howbuyhouse_2 howbuyhouse_7 howbuyhouse_5 howbuyhouse_4 howbuyhouse_1 schemeslist_2 schemeslist_3 schemeslist_4 schemeslist_5 schemeslist_6 schemeslist_7 schemeslist_8 schemeslist_9 schemeslist_18 schemeslist_19 schemeslist_21 schemeslist_23 covrationcarduse_2 covrationcarduse_1 covrationcarduse_3 waterfromownland_1 waterfromownland_2 waterfromownland_4 waterfromleaseland_2 waterfromleaseland_1 landpurchasedhowbuy_2 landpurchasedhowbuy_4 landpurchasedhowbuy_1 landpurchasedhowbuy_3 landleaserrelation_2 landleaserrelation_1 landleaserrelation_10 landleaserrelation_5 landleasingrelation_10 landleasingrelation_2 landleasingrelation_1 landleasingrelation_8 productlist_15 covsubsistencereason_1 covsubsistencereason_2 covsubsistencereason_3 covsubsistencereason_77 covexpensesincrease_5 covexpensesstable_1 covexpensesstable_7 covexpensesstable_2 howbuyhouse_3 howbuyhouse_6 rationcardreasonnouse_6 rationcardreasonnouse_2 rationcardreasonnouse_1
dropmiss, force

save"NEEMSIS_APPEND_v14.dta", replace
****************************************
* END