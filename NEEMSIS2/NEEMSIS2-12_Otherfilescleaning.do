cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
September 16, 2021
-----
TITLE: Other file
-------------------------
*/

clear all
macro drop _all
cls
********** Path to folder "data" folder.
*global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"

cd"$directory"
clear all





****************************************
* Info employer + occupations
****************************************
*Info employer
use"$directory\CLEAN\NEEMSIS_APPEND-salaried-infoemployer.dta", clear
drop setofinfoemployer key
rename parent_key setofoccupations
split setofoccupations, p(/)
rename setofoccupations1 parent_key
drop setofoccupations2 setofoccupations3
order parent_key
order setofoccupations, last

	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"

save"$directory\CLEAN\NEEMSIS_APPEND-salaried-infoemployer_v2.dta", replace


*Occupations
use"$directory\CLEAN\NEEMSIS_APPEND-occupations.dta", clear
drop setofbusinesslabourers setofinfoemployer key
order parent_key
rename parent_key setofemployment
split setofemployment, p(/)
rename setofemployment1 parent_key
drop setofemployment2 
order parent_key
order setofemployment setofoccupations, last

	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"

save"$directory\CLEAN\NEEMSIS_APPEND-occupations_v3.dta", replace



*Tester le merging
use"$directory\CLEAN\NEEMSIS_APPEND-salaried-infoemployer_v2.dta", clear
merge m:1 setofoccupations using "$directory\CLEAN\NEEMSIS_APPEND-occupations_v3.dta"
/*
Pour merger avec la base HH on utilise setofemployment
*/

use"$directory\CLEAN\NEEMSIS_APPEND-occupations_v3.dta", clear
merge m:m setofemployment using "$directory\CLEAN\NEEMSIS2-HH_v18.dta"
*Ok

*Sortir setofoccupations pour ne pas induire en erreur
use"$directory\CLEAN\NEEMSIS2-HH_v18.dta", clear
drop setofoccupations
save"$directory\CLEAN\NEEMSIS2-HH_v19.dta", replace
****************************************
* END













****************************************
* Remittances
****************************************
*Received
use"$directory\CLEAN\NEEMSIS_APPEND-remreceivedsourceidgroup.dta", clear
drop setofremreceivedsourceidgroup key

split parent_key, p(/)
drop parent_key2
rename parent_key setofremreceivedidgroup
rename parent_key1 parent_key
order parent_key, first
order setofremreceivedidgroup, last

	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"

save"$directory\CLEAN\NEEMSIS_APPEND-remreceivedsourceidgroup_v2.dta", replace

*Test
merge m:m setofremreceivedidgroup using "$directory\CLEAN\NEEMSIS2-HH_v19.dta"
*Ok


*Sent
use"$directory\CLEAN\NEEMSIS_APPEND-remsentidgroup.dta", clear
drop key setofremsentidgroup

split parent_key, p(/)
drop parent_key2
rename parent_key setofremsentidgroup
rename parent_key1 parent_key
order parent_key, first
order setofremsentidgroup, last

	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"

save"$directory\CLEAN\NEEMSIS_APPEND-remsentidgroup_v2.dta", replace

*Test
merge m:m setofremsentidgroup using "$directory\CLEAN\NEEMSIS2-HH_v19.dta"
tab remsentid
*Ok

****************************************
* END
