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


****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "C:\Users\Arnaud\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global git = "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

*global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*global git ="C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"

cd"$directory"
clear all
****************************************
* END




****************************************
* Info employer + occupations + business labourer
****************************************
*Info employer
use"$directory\CLEAN\NEEMSIS_APPEND-salaried-infoemployer.dta", clear
drop setofinfoemployer key
rename parent_key setofoccupations
split setofoccupations, p(/)
rename setofoccupations1 parent_key
drop setofoccupations2 setofoccupations3
order parent_key
drop if parent_key==""
order setofoccupations, last

	***** Duplicates
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"  // householdid==36 & name1=="Natesan"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"  // householdid==67 & name1=="Shankar"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"  // householdid==124 & name1=="Subramani"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"  // householdid==246 & name1=="Sornambal"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"  // householdid==343 & name1=="Ramamoorthi"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"  // householdid==348 & name1=="Govindan"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"  // householdid==361 & name1=="Mallika"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"  // householdid==391 & name1=="Balaji"
	*
	drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"  // householdid==532 & name1=="Shakthivel" & name2=="Revathy"
	drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"  // householdid==534 & name1=="Karunanidhi"
	drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"  // householdid==547 & name1=="Surya" (duplicates with "uuid:ae72a34f-f968-45f4-acfa-91f571f54ea8")

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
drop if parent_key==""
order setofemployment setofoccupations, last

	***** Duplicates
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"  // householdid==36 & name1=="Natesan"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"  // householdid==67 & name1=="Shankar"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"  // householdid==124 & name1=="Subramani"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"  // householdid==246 & name1=="Sornambal"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"  // householdid==343 & name1=="Ramamoorthi"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"  // householdid==348 & name1=="Govindan"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"  // householdid==361 & name1=="Mallika"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"  // householdid==391 & name1=="Balaji"
	*
	drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"  // householdid==532 & name1=="Shakthivel" & name2=="Revathy"
	drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"  // householdid==534 & name1=="Karunanidhi"
	drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"  // householdid==547 & name1=="Surya" (duplicates with "uuid:ae72a34f-f968-45f4-acfa-91f571f54ea8")

save"$directory\CLEAN\NEEMSIS_APPEND-occupations_v3.dta", replace


*Business labourer
use"$directory\CLEAN\NEEMSIS_APPEND-selfemploy-labourers-businesslabourers.dta", clear
drop setofbusinesslabourers key
rename parent_key setofoccupations
split setofoccupations, p(/)
rename setofoccupations1 parent_key
drop setofoccupations2 setofoccupations3
order parent_key
drop if parent_key==""
drop forauto
order setofoccupations, last

	***** Duplicates
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"  // householdid==36 & name1=="Natesan"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"  // householdid==67 & name1=="Shankar"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"  // householdid==124 & name1=="Subramani"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"  // householdid==246 & name1=="Sornambal"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"  // householdid==343 & name1=="Ramamoorthi"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"  // householdid==348 & name1=="Govindan"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"  // householdid==361 & name1=="Mallika"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"  // householdid==391 & name1=="Balaji"
	*
	drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"  // householdid==532 & name1=="Shakthivel" & name2=="Revathy"
	drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"  // householdid==534 & name1=="Karunanidhi"
	drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"  // householdid==547 & name1=="Surya" (duplicates with "uuid:ae72a34f-f968-45f4-acfa-91f571f54ea8")

save"$directory\CLEAN\NEEMSIS_APPEND-selfemploy-labourers-businesslabourers_v2.dta", replace



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

	***** Duplicates
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"  // householdid==36 & name1=="Natesan"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"  // householdid==67 & name1=="Shankar"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"  // householdid==124 & name1=="Subramani"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"  // householdid==246 & name1=="Sornambal"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"  // householdid==343 & name1=="Ramamoorthi"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"  // householdid==348 & name1=="Govindan"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"  // householdid==361 & name1=="Mallika"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"  // householdid==391 & name1=="Balaji"
	*
	drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"  // householdid==532 & name1=="Shakthivel" & name2=="Revathy"
	drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"  // householdid==534 & name1=="Karunanidhi"
	drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"  // householdid==547 & name1=="Surya" (duplicates with "uuid:ae72a34f-f968-45f4-acfa-91f571f54ea8")

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

	***** Duplicates
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"  // householdid==36 & name1=="Natesan"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"  // householdid==67 & name1=="Shankar"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"  // householdid==124 & name1=="Subramani"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"  // householdid==246 & name1=="Sornambal"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"  // householdid==343 & name1=="Ramamoorthi"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"  // householdid==348 & name1=="Govindan"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"  // householdid==361 & name1=="Mallika"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"  // householdid==391 & name1=="Balaji"
	*
	drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"  // householdid==532 & name1=="Shakthivel" & name2=="Revathy"
	drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"  // householdid==534 & name1=="Karunanidhi"
	drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"  // householdid==547 & name1=="Surya" (duplicates with "uuid:ae72a34f-f968-45f4-acfa-91f571f54ea8")

save"$directory\CLEAN\NEEMSIS_APPEND-remsentidgroup_v2.dta", replace

*Test
merge m:m setofremsentidgroup using "$directory\CLEAN\NEEMSIS2-HH_v19.dta"
tab remsentid
*Ok

****************************************
* END






****************************************
* Marriagegift + memberlistpreload2016 + migrationjobid
****************************************
*Migration
use"$directory\CLEAN\NEEMSIS_APPEND-migrationjobidgroup.dta", clear
drop setofmigrationjobidgroup key

split parent_key, p(/)
drop parent_key2
rename parent_key setofmigrationidgroup
rename parent_key1 parent_key
order parent_key, first
drop forauto
drop if parent_key==""
drop if migrationarea==""
order setofmigrationidgroup, last

	***** Duplicates
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"  // householdid==36 & name1=="Natesan"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"  // householdid==67 & name1=="Shankar"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"  // householdid==124 & name1=="Subramani"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"  // householdid==246 & name1=="Sornambal"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"  // householdid==343 & name1=="Ramamoorthi"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"  // householdid==348 & name1=="Govindan"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"  // householdid==361 & name1=="Mallika"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"  // householdid==391 & name1=="Balaji"
	*
	drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"  // householdid==532 & name1=="Shakthivel" & name2=="Revathy"
	drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"  // householdid==534 & name1=="Karunanidhi"
	drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"  // householdid==547 & name1=="Surya" (duplicates with "uuid:ae72a34f-f968-45f4-acfa-91f571f54ea8")

save"$directory\CLEAN\NEEMSIS_APPEND-migrationjobidgroup_v2.dta", replace


*Gift
use"$directory\CLEAN\NEEMSIS_APPEND-marriagegift.dta", clear
drop key setofmarriagegift
split parent_key, p(/)
drop parent_key2
rename parent_key setofmarriagegroup
rename parent_key1 parent_key
order parent_key, first
drop forauto
drop if parent_key==""
drop if marriagegiftsourcenb==.
order setofmarriagegroup, last

	***** Duplicates
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"  // householdid==36 & name1=="Natesan"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"  // householdid==67 & name1=="Shankar"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"  // householdid==124 & name1=="Subramani"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"  // householdid==246 & name1=="Sornambal"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"  // householdid==343 & name1=="Ramamoorthi"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"  // householdid==348 & name1=="Govindan"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"  // householdid==361 & name1=="Mallika"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"  // householdid==391 & name1=="Balaji"
	*
	drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"  // householdid==532 & name1=="Shakthivel" & name2=="Revathy"
	drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"  // householdid==534 & name1=="Karunanidhi"
	drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"  // householdid==547 & name1=="Surya" (duplicates with "uuid:ae72a34f-f968-45f4-acfa-91f571f54ea8")

save"$directory\CLEAN\NEEMSIS_APPEND-marriagegift_v2.dta", replace

****************************************
* END
