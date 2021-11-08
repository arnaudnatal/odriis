cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
September 30, 2021
-----
TITLE: Occupation
National Industrial Classification : http://mospi.nic.in/classification/national-industrial-classification
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
global git = "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

*global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*global git ="C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"

cd"$directory\CLEAN"
clear all
****************************************
* END






****************************************
* Clean
****************************************
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
	
gen countoccupation=1


*Cleaning des key
split key, p(/)
egen setofemployment=concat(key1 key2), p(/)
drop key key1 key2 key3
order setofbusinesslabourers setofinfoemployer setofoccupations setofemployment, last
drop keep_occupposition _2keep_occupposition _3keep_occupposition businesslabourers_count infoemployer_count salariedjobgroup2_count

save"NEEMSIS_APPEND-occupations_v2.dta", replace
/*
rename occupationnumber occupationid
tostring occupationid, gen(occupationnumber)
sort setofemployment occupationid

/*
TEST
*/
merge 1:1 setofemployment occupationnumber using "NEEMSIS_APPEND-occupations_old", force
sort _merge setofemployment occupationnumber
*/
****************************************
* END













****************************************
* Occupation
****************************************
use"$directory\CLEAN\NEEMSIS_APPEND-occupations_v2", clear

*Verif occupation
preserve
use"$directory\CLEAN\NEEMSIS2-HH_v9.dta", clear
fre classcompleted
restore

merge m:m setofemployment using "$directory\CLEAN\NEEMSIS2-HH_v9.dta", keepusing(HHID_panel INDID_panel egoid age sex jatis classcompleted everattendedschool canread edulevel caste name)
list setofemployment if _merge==1, clean noobs
/*
                                                             setofemployment  
    uuid:9ecbdaca-ffce-4bbc-a69d-455ea0411977/hhquestionnaire-employment[16]
*/
drop if _merge==1
drop if _merge==2
drop _merge

order HHID_panel INDID_panel
destring hoursayear, replace

gen year=2020

gen occup_sector= .

gen classcompleted10ormore=.
replace classcompleted10ormore=0 if classcompleted<10 & classcompleted!=.
replace classcompleted10ormore=1 if classcompleted>=10 & classcompleted!=.

*drop classcompleted

gen agetowork=.
replace agetowork=0 if age<=14 & age!=.
replace agetowork=0 if age>=71 & age!=.
replace agetowork=1 if age>14 & age<71 & age!=.

drop age

*rename kindofwork kindofwork2020

*Quelles occupations ?
cls
preserve
duplicates drop occupationname kindofwork classcompleted10ormore everattendedschool agetowork, force
keep occupationname kindofwork everattendedschool classcompleted10ormore agetowork
gen profession=.
order kindofwork occupationname profession
*export excel using "$git\_Miscellaneous\Occupations\Occupations.xlsx", sheet("NEEMSIS2") sheetmodify firstrow(variables)

gen year=2020

keep occupationname profession year
save"$git\_Miscellaneous\Occupations\sector2020.dta", replace

/*
sort occupationname
drop if occup_sector!=.
list occupationname, clean noobs
*/
restore

gen toask=0
sort occupationname
order occupationname occup_sector

*to launch
mdesc occup_sector

			
* Cultivators
replace occup_sector= 11 if  ///
(strpos(occupationname,"agri") | strpos(occupationname,"Agri"))  ///
& ///
(strpos(occupationname,"own") | strpos(occupationname,"Own") | strpos(occupationname,"lease"))
replace occup_sector=11 if occupationname=="Farmer"
replace occup_sector=11 if occupationname=="Fermar"
replace occup_sector=11 if occupationname=="Agriculture"
replace occup_sector=11 if occupationname=="Unpaid worker in own farm."
replace occup_sector=11 if occupationname=="Working in own farm"
replace occup_sector=11 if occupationname=="Working on lease land"

* Agricultural labourers
replace  occup_sector= 12  if  ///
(strpos(occupationname,"agri") | strpos(occupationname,"Agri")) ///
& ///
(strpos(occupationname,"cooli") | strpos(occupationname,"Cooli") | strpos(occupationname,"kooli"))
replace occup_sector=12 if occupationname=="Agriculture labour"
replace occup_sector=12 if occupationname=="Kooli"
replace occup_sector=12 if occupationname=="Seeding"
replace occup_sector=12 if occupationname=="Seedling"
replace occup_sector=12 if occupationname=="Weeding"
replace occup_sector=12 if occupationname=="Agricultural weeding"
replace occup_sector=12 if occupationname=="Agriculture activities"
replace occup_sector=12 if occupationname=="Agriculture atto"
replace occup_sector=12 if occupationname=="Agriculture weeding"
replace occup_sector=12 if occupationname=="Agriculture weeding and seedling"
replace occup_sector=12 if occupationname=="Agriculture weeding work"
replace occup_sector=12 if occupationname=="Agriculture work"
replace occup_sector=12 if occupationname=="Agriculture work ( weeding and seedling)"
replace occup_sector=12 if occupationname=="Agriculture work (Andam poduthal)"
replace occup_sector=12 if occupationname=="Agriculture work (weeding and seedling)"
replace occup_sector=12 if occupationname=="Agriculture work seedling"
replace occup_sector=12 if occupationname=="Agriculture work weeding"
replace occup_sector=12 if occupationname=="Andam  poduthal"
replace occup_sector=12 if occupationname=="Andam poduthal"
replace occup_sector=12 if occupationname=="Andamvetuthal"
replace occup_sector=12 if occupationname=="Guava fruit picking"
replace occup_sector=12 if occupationname=="Irrigation work"
replace occup_sector=12 if occupationname=="Plowing"



* Sugarcane worker
replace  occup_sector=13  if  ///
(strpos(occupationname,"sugar") | strpos(occupationname,"Sugar")) ///
& ///
(strpos(occupationname,"cane") | strpos(occupationname,"work"))
replace occup_sector=13 if occupationname=="Karumbu vatuthal"
replace occup_sector=13 if occupationname=="Karumbu vettuthal"


* Other farm workers
replace occup_sector=14 if occupationname=="Tree cutting work"
replace occup_sector=14 if occupationname=="Cow Rearing -own"
replace occup_sector=14 if occupationname=="Land watcher"
replace occup_sector=14 if occupationname=="Goat rearing"
replace occup_sector=14 if occupationname=="Poultry"
replace occup_sector=14 if occupationname=="Rearing cows and goats"


		
**** Production workers, transport equipment operators and labourers

* Bricklayers and construction workers (chamber, roads)	
replace occup_sector=22 if ///
strpos(occupationname,"Construction") ///
| strpos(occupationname,"construction") ///
| strpos(occupationname,"Chamber") ///
| strpos(occupationname,"chamber") ///
| strpos(occupationname,"Brick") ///
| strpos(occupationname,"brick") ///
| strpos(occupationname,"Centring") ///
| strpos(occupationname,"centring") ///
| strpos(occupationname,"Mason") ///
| strpos(occupationname,"mason") ///
| strpos(occupationname,"Maison") ///
| strpos(occupationname,"maison") ///
| strpos(occupationname,"Sentring") ///
| strpos(occupationname,"sentring") ///
| strpos(occupationname,"Paint") ///
| strpos(occupationname,"paint") 
replace occup_sector=22 if occupationname=="Chember work"
replace occup_sector=22 if occupationname=="Kottanar worker"
replace occup_sector=22 if strpos(occupationname,"Kothanar")
replace occup_sector=22 if occupationname=="Tiles work"
replace occup_sector=22 if occupationname=="Pointing  work"
replace occup_sector=22 if occupationname=="Road work"
replace occup_sector=22 if occupationname=="Rode work"
replace occup_sector=22 if occupationname=="Cement slab worker"
replace occup_sector=22 if occupationname=="Compound wall maker"

* Spinners, Weavers, Knitters, Dyers
replace occup_sector=23 if ///
strpos(occupationname,"Weaver") ///
| strpos(occupationname,"weaver") ///
| strpos(occupationname,"Handloom") ///
| (strpos(occupationname,"hand") & strpos(occupationname,"loom")) ///
| (strpos(occupationname,"Hand") & strpos(occupationname,"loom"))
replace occup_sector=23 if occupationname=="Cotton work"
	

	
* Tailors, dress makers, sewers
replace occup_sector=24 if ///
strpos(occupationname,"Tailor") /// 
| strpos(occupationname,"tailor")  
replace occup_sector=24 if occupationname=="Leather designer"
replace occup_sector=24 if occupationname=="Textile designer"



* Clay workers, potters, sculptors, painters
replace occup_sector=25 if  ///
strpos(occupationname,"making") 
replace occup_sector=25 if occupationname=="Clay pot worker"
replace occup_sector=25 if occupationname=="Sculptor"
replace occup_sector=25 if occupationname=="Pot maker"




* Electrical workers
replace occup_sector=26 if ///
strpos(occupationname,"Electric") ///
| strpos(occupationname,"electric")


	
* Mechanic and machinery fitters/assemblers (except electrical)
replace occup_sector=27 if ///
strpos(occupationname,"Mechanic") ///
| strpos(occupationname,"mechanic")
replace occup_sector=27 if occupationname=="A.c machanice"
replace occup_sector=27 if occupationname=="Technician"
replace occup_sector=27 if occupationname=="Marunthu adithall mechine"
replace occup_sector=27 if occupationname=="Motor repair work"
replace occup_sector=27 if occupationname=="Fitter"
replace occup_sector=27 if occupationname=="Salaried job ,own fitter paathur ur"


	
* Transport Equipment operators	
replace occup_sector=28 if  ///
strpos(occupationname,"Tata" "drive") ///
| strpos(occupationname,"TATA" "drive") ///
| strpos(occupationname,"TATA" "Drive") ///
| strpos(occupationname,"Lorry" "driver")
replace occup_sector=28 if occupationname=="Container lorry driver"
replace occup_sector=28 if occupationname=="Lowry driver"
replace occup_sector=28 if occupationname=="Private lorry driver"
replace occup_sector=28 if strpos(occupationname,"Bullock")
replace occup_sector=28 if occupationname=="Tractor driver"


	
* Stationery Engines and related equipment operators
*replace occup_sector=29 if  
	
	
* Material handling and related equipment operators (loaders/unloaders)
replace occup_sector=30 if ///
strpos(occupationname,"load") ///
| strpos(occupationname,"Load")
replace occup_sector=30 if occupationname=="Lorry loder"
replace occup_sector=30 if occupationname=="Cooli work ( lorry stone work)"



* Other Industrial workers (glass, mining, chemicals, printing, welders)
replace occup_sector=31 if ///
strpos(occupationname,"Welder") ///
| strpos(occupationname,"Welding") 
replace occup_sector=31 if occupationname=="Work in private company"
replace occup_sector=31 if occupationname=="Printing operator"
replace occup_sector=31 if occupationname=="Printing worker in dubai"

replace occup_sector=31 if occupationname=="Private company"
replace occup_sector=31 if occupationname=="Private company  cellphone delivery"
replace occup_sector=31 if occupationname=="Private company (Abudhabi)"
replace occup_sector=31 if occupationname=="Private company at Pondy"
replace occup_sector=31 if occupationname=="Private company at Saudi Arabia"
replace occup_sector=31 if occupationname=="Private company at chennai"
replace occup_sector=31 if occupationname=="Private company at pantruti"
replace occup_sector=31 if occupationname=="Private company cellphone  delivery"
replace occup_sector=31 if occupationname=="Private company in pantruti"
replace occup_sector=31 if occupationname=="Private company pantruti"
replace occup_sector=31 if occupationname=="Private company worker"
replace occup_sector=31 if occupationname=="Worker in a UCO4G COMPANY  "
replace occup_sector=31 if occupationname=="Worker in a gas company"
replace occup_sector=31 if occupationname=="Worker in private company"
replace occup_sector=31 if occupationname=="Working at chemical company"
replace occup_sector=31 if occupationname=="Working at computer centre"
replace occup_sector=31 if occupationname=="Working at private company"
replace occup_sector=31 if occupationname=="Working at tolgate"
replace occup_sector=31 if occupationname=="Working in TVS company"
replace occup_sector=31 if occupationname=="Working in cuddalore  sipcot"
replace occup_sector=31 if occupationname=="Working in cuddalore sipcot"
replace occup_sector=31 if occupationname=="Filter company"
replace occup_sector=31 if occupationname=="Work at private company"
replace occup_sector=31 if occupationname=="Work in Private company"
replace occup_sector=31 if occupationname=="Working at banglore"
replace occup_sector=31 if occupationname=="Working at chennai"
replace occup_sector=31 if occupationname=="Working at chennai hundai company"
replace occup_sector=31 if occupationname=="Working at private company in chennai"
replace occup_sector=31 if occupationname=="Working at quatar"
replace occup_sector=31 if occupationname=="Working in a private company"
replace occup_sector=31 if occupationname=="Working in EB"
replace occup_sector=31 if occupationname=="Working in eb"
replace occup_sector=31 if occupationname=="Company wages"
replace occup_sector=31 if occupationname=="Cooperative society worker"
replace occup_sector=31 if occupationname=="Private company in Villupuram"
replace occup_sector=31 if occupationname=="Salaried job, company work"
replace occup_sector=31 if occupationname=="Company wages"
replace occup_sector=31 if occupationname=="Private company work"
replace occup_sector=31 if occupationname=="Salaried job  Chennai work"
replace occup_sector=31 if occupationname=="Salaried job Chennai guduvanchery"
replace occup_sector=31 if occupationname=="Salaried job non agri"
replace occup_sector=31 if occupationname=="Salaried jop"
replace occup_sector=31 if occupationname=="Salaried jop , Villupuram ."
replace occup_sector=31 if occupationname=="Salaried jop, Panruti."
replace occup_sector=31 if occupationname=="Salaried jop, Villupuram"




* Other craftsworkers (Carpenters, tiles workers, Paper product makers)	
replace occup_sector=32 if ///
strpos(occupationname,"Carpent")
replace occup_sector=32 if occupationname=="Working at tiles company"
 
	
* Other labour
replace occup_sector=33 if occupationname=="Cooli work"
replace occup_sector=33 if occupationname=="Cooli worker"
replace occup_sector=33 if occupationname=="Coolie"
replace occup_sector=33 if occupationname=="Coolie  worker"
replace occup_sector=33 if occupationname=="Coolie worker"
replace occup_sector=33 if occupationname=="Coolie worker in market"
replace occup_sector=33 if occupationname=="Delecom cellphone network, thamparam  Chennai"
replace occup_sector=33 if occupationname=="Working at software company"
replace occup_sector=33 if occupationname=="Cinema Theater worker"

	
**** Qualified jobs
* Teachers	
replace occup_sector=41 if ///
strpos(occupationname,"Teacher") ///
| strpos(occupationname,"teacher") 
replace occup_sector=41 if occupationname=="Pravite school system work , panruti"
replace occup_sector=41 if occupationname=="Private school system work ,anguchetipalayam"

* Architects, Engineers, ..
replace occup_sector=42 if  ///
strpos(occupationname,"Engineer") ///
| strpos(occupationname,"engineer") 
/*
Software Engineer
Engineer
Engineering works Sriperumbudur
Engineer
*/

* Engineering technicians
replace occup_sector=43 if occupationname=="Technician in dubai"




* Scientific, medical and technical persons
replace occup_sector=44 if occupationname=="Medical  representative"
replace occup_sector=44 if occupationname=="Pharmist"

				
* Nursing and health technicians
replace occup_sector=45 if  ///
strpos(occupationname,"Nurs") ///
| strpos(occupationname,"nurs")
replace occup_sector=45 if occupationname=="Ward boy"
replace occup_sector=45 if occupationname=="Anganwadi worker"


	
* Economists, Accountants, auditors
*replace occup_sector=46 if occupationname==""



* Jurists
replace occup_sector=47 if strpos(occupationname,"Advo")
	
	
	
**** Administrative, executive and managerial workers
* Administrative and executive officials government and local bodies
replace occup_sector=51 if ///
strpos(occupationname,"Police") ///
| strpos(occupationname,"police") ///
| (strpos(occupationname,"offic") & occupationname!="Loan officer")
replace occup_sector=52 if occupationname=="LIC agent"
replace occup_sector=52 if occupationname=="Social Audit"
replace occup_sector=52 if occupationname=="Project manager"
replace occup_sector=52 if occupationname=="(Equitas Bank) loan collection work"
replace occup_sector=52 if occupationname=="Collection executive"
replace occup_sector=52 if occupationname=="Loan collection job (prayaan capital)"
	
	
**** Independent labour contractors
*replace occup_sector=61 if  // maistry


	 
**** Clerical workers
* Clerical and other supervisors
replace occup_sector=71 if ///
strpos(occupationname,"supervisor") ///
| strpos(occupationname,"Supervisor")
replace occup_sector=71 if occupationname=="Editorial"
replace occup_sector=71 if occupationname=="Panchayat president"
replace occup_sector=71 if occupationname=="Self help group leader"
replace occup_sector=71 if occupationname=="Village Panchayat president"
replace occup_sector=71 if occupationname=="Chef"
replace occup_sector=71 if occupationname=="Kovil poosari"
replace occup_sector=71 if occupationname=="Makkal Nala Paniyalar"




* Other clerical workers
replace occup_sector=72 if ///
strpos(occupationname,"assistant") ///
| strpos(occupationname,"Assistant")
replace occup_sector=72 if occupationname=="Data entry operator"
replace occup_sector=72 if occupationname=="Govt. Job (Clerk in BDO Office)"
replace occup_sector=72 if occupationname=="Government job (agri department)"
replace occup_sector=72 if occupationname=="Government work( paalvadi Samaiyal)"
replace occup_sector=72 if occupationname=="Icp Operator"
replace occup_sector=72 if occupationname=="Browsing center"


/*
 occupationname == "Admin work(Feron tech)" ///
		|  occupationname == "Office assistant in Co-operative bank" |  occupationname == "Secretary(primary agriculture cooperative bank)" ///
		|  occupationname == "Receptionist" ///
		|  occupationname == "Billing staff" ///
		|  occupationname == "Transport company staff" ///
		|  occupationname == "Data entry operater" ///
		|  occupationname == "Post master" |  occupationname == "Mail Gard (central goverment railways dept)"
*/
		
* Transport conductors and guards
replace occup_sector=73 if occupationname=="Private Bus Driver"
replace occup_sector=73 if occupationname=="TNSTC driver"
replace occup_sector=73 if occupationname=="Security"
replace occup_sector=73 if occupationname=="Watch man"
replace occup_sector=73 if occupationname=="Bus driver"
replace occup_sector=73 if occupationname=="Bus conductor"
replace occup_sector=73 if occupationname=="Tamilnadu transport corporation driver"



	
**** Sales workers
* Shop keepers (wholesale and retail) (et coolie in shop ?)
replace occup_sector=81 if  ///
strpos(occupationname,"Shop") ///
| strpos(occupationname,"shop") ///
| strpos(occupationname,"Business") ///
| strpos(occupationname,"business") ///
| strpos(occupationname,"Seller") /// 
| strpos(occupationname,"seller") ///
| strpos(occupationname,"Selling") /// 
| strpos(occupationname,"selling")
replace occup_sector=81 if occupationname=="Grocery store"
replace occup_sector=81 if occupationname=="Milk store"
replace occup_sector=81 if occupationname=="Own grocery store"
replace occup_sector=81 if occupationname=="Fishmonger"
replace occup_sector=81 if occupationname=="Milk man"
replace occup_sector=81 if occupationname=="Mobile tea stall"
replace occup_sector=81 if occupationname=="Mushroom stall"
replace occup_sector=81 if occupationname=="Own Pettis hop"
replace occup_sector=81 if occupationname=="Own photo studio"

	 
* Agri equipment sellers
replace occup_sector=82 if occupationname=="Tractor dealer"


* Rent shop/ activities
replace occup_sector=83 if strpos(occupationname,"Rent") 
replace occup_sector=83 if strpos(occupationname,"rent") 

		
* Salesmen, shop assistants and related workers
replace occup_sector=84 if ///
strpos(occupationname,"Sales") ///
| strpos(occupationname,"sales")
replace occup_sector=84 if occupationname=="Cashier work"
replace occup_sector=84 if occupationname=="Groundnut Sale Assistance"
replace occup_sector=84 if occupationname=="Working in, supermarket, Chennai guduvanchery"


* Technical salesmen & commercial travellers
replace occup_sector=85 if strpos(occupationname,"Contract") & occupationname!="Road contract supervisor"
replace occup_sector=85 if strpos(occupationname,"contract") & occupationname!="Road contract supervisor"
	


* Money lenders and pawn brokers	
replace occup_sector=86 if occupationname=="Broker" 
	
	

			
**** Service workers
* Hotel and restaurant keepers
replace occup_sector=91 if ///
strpos(occupationname,"Hotel") ///
| strpos(occupationname,"hotel")
	
* Cooks, waiters
replace occup_sector=92 if ///
strpos(occupationname,"catering") ///
| strpos(occupationname,"Catering")
replace occup_sector=92 if occupationname=="Hotel Master"
replace occup_sector=92 if occupationname=="Tea master"
replace occup_sector=92 if occupationname=="Cooking master"
replace occup_sector=92 if occupationname=="Mid day meal maker"
replace occup_sector=92 if occupationname=="Patti kadai"



* Building caretakers, sweepers, cleaners	
replace occup_sector=93 if occupationname=="Grass broom work"
replace occup_sector=93 if occupationname=="Sewage cleaner"


* Maids and house keeping service workers
replace occup_sector=94 if strpos(occupationname,"House")
replace occup_sector=94 if strpos(occupationname,"house")


* Hair dressers, barbers..
replace occup_sector=95 if strpos(occupationname,"Hair")
replace occup_sector=95 if strpos(occupationname,"hair")


* Private transportation
replace occup_sector=96 if occupationname=="Private driver"
replace occup_sector=96 if occupationname=="Auto driver"
replace occup_sector=96 if occupationname=="Auto driver own"
replace occup_sector=96 if occupationname=="Car driver"
replace occup_sector=96 if occupationname=="Driver"
replace occup_sector=96 if occupationname=="Driver ( work in private company)"
replace occup_sector=96 if occupationname=="Private  driver"
replace occup_sector=96 if occupationname=="Own van driver"
replace occup_sector=96 if occupationname=="Panruti own auto driver"


	
**** Performing artists
replace occup_sector=101 if strpos(occupationname,"Drum")
replace occup_sector=101 if strpos(occupationname,"drum")
replace occup_sector=101 if strpos(occupationname,"Art's work")
replace occup_sector=101 if strpos(occupationname,"Arts work")
replace occup_sector=101 if strpos(occupationname,"Karagatam")


		
**** Astrologers 
replace occup_sector=102 if strpos(occupationname,"Astro")
replace occup_sector=102 if strpos(occupationname,"astro")



**** Public works/ NREGA
replace occup_sector=111 if strpos(occupationname,"NREG")
replace occup_sector=111 if strpos(occupationname,"Nreg")
replace occup_sector=111 if strpos(occupationname,"nreg")
replace occup_sector=111 if occupationname=="NREga"



********** Label

label define occupation1 11 "Cultivators" 12 "Agricultural labourers" 13"Sugarcane plantation labourers" 14 "Other farm workers" 22 "Bricklayers and construction workers (chamber, roads)" ///
	23 "Spinners, Weavers, Knitters, Dyers" 24 "Tailors, dress makers, sewers" 25 "Clay workers, potters, sculptors, painters" 26 "Electrical workers" 27 "Mechanic and machinery fitters/assemblers (except electrical)" ///
	28 "Transport Equipment operators" 29 "Stationery Engines and related equipment operators" 30 "Material handling and related equipment operators (loaders/unloaders)" ///
	31 "Other Industrial workers (glass, mining, chemicals, printing, welders)" 32 "Other craftsworkers (Carpenters, tiles workers, Paper product makers)" 33 "Other labour" ///
	41 "Teachers" 42 "Architects, Engineers, ..." 43 "Engineering technicians" 44 "Scientific, medical and technical persons" 45 "Nursing and health technicians" 46 "Economists, Accountants, auditors" ///
	47 "Jurists" 51 "Administrative and executive officials government and local bodies" 52 "Working proprietors, directors, managers in mining, construction, manufacturing" ///
	61 "Independent labour contractors" 71 "Clerical and other supervisors" 72 "Other clerical workers" 73 "Transport conductors and guards" 81 "Shop keepers (wholesale and retail)" ///
	82 "Agri equipment sellers" 83 "Rent shop/ activities" 84 "Salesmen, shop assistants and related workers" 85 "Technical salesmen & commercial travellers" 86 "Money lenders and pawn brokers" ///
	91 "Hotel and restaurant keepers" 92 "Cooks, waiters" 93 "Building caretakers, sweepers, cleaners" 94 "Maids and house keeping service workers" 95 "Hair dressers, barbers..." 96 "Private transportation" ///
	97 "Other service workers" 101 "Performing artists" 102 "Astrologers" 111 "Public works/ NREGA"
label value occup_sector occupation1

tab occup_sector, m




*********Appel avec Sébastien le 12/10/2021
order occupationname occup_sector kindofwork HHID_panel INDID_panel occupationnumber
compress 
sort occup_sector occupationname


***** Recoder kindofwork
rename occupationnumber occupationid
tostring occupationid, gen(occupationnumber)
replace kindofwork=3 if HHID_panel=="KUV1" & INDID_panel=="Ind_2" & occupationnumber=="2"



***** Recoder occup_sector
replace occup_sector=11 if HHID_panel=="KAR17" & occupationname=="Agricultural cooli in own farm"
replace occup_sector=11 if HHID_panel=="ORA30" & occupationname=="Agricultural cooli in own farm"
replace occup_sector=11 if HHID_panel=="ORA14" & occupationname=="Agricultural cooli on own land"

replace occup_sector=14 if occupationname=="Samanthi naduthal"

replace occup_sector=26 if occupationname=="TNEB"

replace occup_sector=28 if occupationname=="Cow driving"

replace occup_sector=31 if occupationname=="Hundai company"
replace occup_sector=31 if occupationname=="ITI company Sriram"
replace occup_sector=31 if occupationname=="MRF tyer company"
replace occup_sector=31 if occupationname=="Malar soap company"
replace occup_sector=31 if occupationname=="Plastic company worker"
replace occup_sector=31 if occupationname=="Soap company"
replace occup_sector=31 if occupationname=="Mosquito nets company"
replace occup_sector=31 if occupationname=="Water purifier company"
replace occup_sector=31 if occupationname=="Worker in a UCO4G COMPANY"
replace occup_sector=31 if occupationname=="Godreje"
replace occup_sector=31 if occupationname=="Company"

replace occup_sector=33 if HHID_panel=="MANAM26" & INDID_panel=="Ind_2" & occupationnumber=="2"  // SHG leader

replace occup_sector=41 if HHID_panel=="GOV43" & INDID_panel=="Ind_3" & occupationnumber=="1"  // Assistant professor

replace occup_sector=44 if occupationname=="Pharmacy work"

replace occup_sector=46 if HHID_panel=="KUV43" & INDID_panel=="Ind_3" & occupationnumber=="1"  // LIC agent

replace occup_sector=51 if occupationname=="Municipality worker"
replace occup_sector=51 if occupationname=="NLC Employer"

replace occup_sector=71 if occupationname=="Thinathanthi newspaper"
replace occup_sector=71 if HHID_panel=="KOR7" & INDID_panel=="Ind_5" & occupationnumber=="1"  // Govt. Job (Clerk in BDO Office)


replace occup_sector=72 if occupationname=="Employee in finance company"
replace occup_sector=72 if occupationname=="Loan officer"
replace occup_sector=72 if occupationname=="Operator"

replace occup_sector=73 if occupationname=="Metro Tracking"

replace occup_sector=81 if occupationname=="Self employed"

replace occup_sector=84 if occupationname=="Retailer"

replace occup_sector=92 if occupationname=="Home made items elladai"
replace occup_sector=92 if occupationname=="Running a canteen in Villupuram private hospital"

replace occup_sector=96 if occupationname=="Cooli driver"
replace occup_sector=96 if occupationname=="Driver (own car)"
replace occup_sector=96 if occupationname=="Traiver"


replace occup_sector=901 if occupationname=="Cashew company"
replace occup_sector=901 if occupationname=="Cashew nut company"
replace occup_sector=901 if occupationname=="Cashew nuts company worker"
label define occupation1 901 "Food-processing industry", modify

replace occup_sector=902 if occupationname=="Daily wager"
label define occupation1 902 "Coolie non-agri", modify

replace occup_sector=902 if occupationname=="Labour work"
replace occup_sector=902 if occupationname=="Market"

replace occup_sector=903 if occupationname=="Function decoration labour"
replace occup_sector=903 if occupationname=="Marriage decorator"
label define occupation1 903 "Other salaried, non quali", modify

replace occup_sector=904 if occupationname=="Jeans company production"
replace occup_sector=904 if occupationname=="Textile company @ Thiruppur"
replace occup_sector=904 if occupationname=="Textile company at Thiruppur"
replace occup_sector=904 if occupationname=="Textile company at Thiruppur"
replace occup_sector=904 if occupationname=="Thirupur company"
replace occup_sector=904 if occupationname=="Panjumill"
replace occup_sector=904 if occupationname=="Baniyan company"
replace occup_sector=904 if occupationname=="Baniyan factory"
replace occup_sector=904 if occupationname=="Working at textile"
replace occup_sector=904 if occupationname=="Working at tirupur textile"
replace occup_sector=904 if occupationname=="Private cloth company at chennai"
replace occup_sector=904 if occupationname=="Leather company"
label define occupation1 904 "Textile industry/company", modify

replace occup_sector=905 if occupationname=="Market Labour"
label define occupation1 905 "Non agri regular qualified", modify

replace occup_sector=906 if occupationname=="Rewinding works"
replace occup_sector=906 if occupationname=="Car wiping work"
label define occupation1 906 "Automobile", modify

replace occup_sector=907 if occupationname=="Fisherman"
label define occupation1 907 "Fisherman", modify



********** 2e check
format occup_sector %30.0g
sort occup_sector occupationname HHID_panel INDID_panel occupationid





********** Label
label values occup_sector occupation1
tab occup_sector, m
/*
HHID_panel	INDID_panel	occupationnumber
GOV35	Ind_4	1
GOV9	Ind_4	1
GOV35	Ind_3	1
GOV10	Ind_6	1
MAN47	Ind_3	1
MAN18	Ind_5	1
*/


********** Occup sector 2
gen occup_sector2= 1 if occup_sector==11
replace occup_sector2= 2 if occup_sector>11 & occup_sector<20
replace occup_sector2= 3 if occup_sector>20 & occup_sector<40
replace occup_sector2= 4 if occup_sector>40 & occup_sector<50
replace occup_sector2= 5 if occup_sector>50 & occup_sector<60
replace occup_sector2= 6 if occup_sector>60 & occup_sector<70
replace occup_sector2= 7 if occup_sector>70 & occup_sector<80
replace occup_sector2= 8 if occup_sector>80 & occup_sector<90
replace occup_sector2= 9 if occup_sector>90 & occup_sector<100
replace occup_sector2= 10 if occup_sector>100 & occup_sector<110
replace occup_sector2= 11 if occup_sector>110 & occup_sector<120


label define sector 1 "Cultivators" 2 "Agricultural and plantation labourers" 3 "Production workers, transport equipment operators and labourers" ///
4 "Most qualified workers" 5 "Administrative, executive and managerial workers" 6 "Labour contractors" ///
7 "Clerical workers" 8 "Merchents and sellers" 9 "Service workers" 10 "Artists and astrologers" ///
11 "NREGA"
label values occup_sector2 sector 	


********** Check up
preserve
keep if occup_sector==.
duplicates drop occupationname, force
sort occupationname
list occupationname, clean noobs
restore






* make occup_sector2 comparable to 2010 and 2016 and 2020
clonevar kindofwork_new=kindofwork

replace kindofwork_new=3 if occup_sector2==2 & kindofwork==4
replace kindofwork_new=4 if occup_sector2==3 & kindofwork==3
replace kindofwork_new=4 if kindofwork==3 & occup_sector2==4
replace kindofwork_new=4 if kindofwork==3 & occup_sector2==7
replace kindofwork_new=4 if kindofwork==3 & occup_sector2==9
replace kindofwork_new=2 if occup_sector2==10
* attention !!!! malgré ces changements, details des occupations restent dans catégorie initiale (SE, salaried)

*recode handloom: recode to self-employed when job location is govulapuram or same village
tab joblocation
replace kindofwork=2 if occup_sector==23 & kindofwork!=2 & joblocation=="Same village" ///
| occup_sector==23 & kindofwork!=2 & joblocation=="Govulapuram"		///
| occup_sector==23 & kindofwork!=2 & joblocation=="Same village,own house"		///
| occup_sector==23 & kindofwork!=2 & joblocation=="Same villlage"

**** attention: information about handloom workers will be in salaried workers module instead of self-employed module



********** réduire les colonnes
gen occupcode2020=.

order occupationname occup_sector occup_sector2 kindofwork annualincome salariedjobtype everattendedschool classcompleted10ormore occupcode2020
sort occup_sector2 occup_sector occupationname kindofwork annualincome HHID_panel INDID_panel occupationnumber

*salariedjobtype2 classcompleted 

format occupationname %18s
format occup_sector %18.0g
format occup_sector2 %18.0g
format kindofwork %20.0g
format salariedjobtype %10.0g
format salariedjobtype2 %5.0g
format everattendedschool %3.0g
format classcompleted10ormore %5.0g

fre occup_sector occup_sector2 kindofwork salariedjobtype salariedwagetype, nowrap all



************************ define occupcode2020 (replace occupcode)
**"CULTIVATORS" 
replace occupcode2020=1 if occup_sector2==1


**"AGRI COOLIE" (in occup sector 2 but not self-employed)
replace occupcode2020=2 if occup_sector2==2 & kindofwork!=2


**"COOLIE NON-AGRI" (industry+service): employed, daily/seasonal/occasional job
* industry workers (sector 3) 
* coolies in shops	(sector 8)	
* coolies in service (sector 9)
replace occupcode2020=3 if ///
  occup_sector2==3 & kindofwork!=2 & salariedjobtype>=3 ///
| occup_sector2==8 & kindofwork!=2 & salariedjobtype>=3 ///
| occup_sector2==9 & kindofwork!=2 & salariedjobtype>=3



**"REGULAR NON-QUALIFIED NON-AGRI" (industry+service): employed, fixed/permanent jobs, less than 10std or more than 10std but no monthly wage (only piece rate or daily)	
* regular non qualified industry workers (sector 3): mostly in sector 22, 23= construction, handloom in thirupur)
* Clerical workers (sector 7)
* employed in shops (sector 8)		
* employed service workers (sector 9)
* qualified job but less than 10std (mid wife, assistant) (sector 4)
replace occupcode2020=4 if ///
  occup_sector2==3 & kindofwork!=2 & salariedjobtype<3 & classcompleted<10 ///
| occup_sector2==3 & kindofwork!=2 & salariedjobtype<3 & everattendedschool==0 ///
| occup_sector2==3 & kindofwork!=2 & salariedjobtype<3 & classcompleted>=10 & salariedwagetype!=3 ///
| occup_sector2==4 & classcompleted<10 ///
| occup_sector2==7 & classcompleted<10 ///
| occup_sector2==7 & classcompleted>=10 & salariedwagetype!=3 ///
| occup_sector2==8 & kindofwork!=2 & salariedjobtype<3 ///
| occup_sector2==9 & kindofwork!=2 & salariedjobtype<3 
*On trouve ici, des gens qualifié, mais payé à la tache ou pas payé?

* créer sous catégorie de regular non qualified pour migrants (thiruppur et brick kiln) ??? quelle part représentent-ils dans cette catégorie ?
* using job location
* pour migrants: frontière coolie/regular est floue: une partie déclaré "permanent" jobs but all have piece rate/daily wages


			
**"REGULAR QUALIFIED NON-AGRI" (industry+service): fixed/permanent jobs, more than 10std, and monthly wage
* qualified and regular industry workers (sector 3): mostly in sector 26, 27, 31= electrician, mechanic, private comp)
* Qualified jobs (sector 4), more than 10std
* Administrative, executive and managerial workers (sector 5): all more than 10 std
replace occupcode2020=5 if ///
  occup_sector2==3 & kindofwork!=2 & salariedjobtype<3 & classcompleted>=10 & salariedwagetype==3 ///
| occup_sector2==4 & classcompleted>=10 & salariedwagetype==3 ///
| occup_sector2==5 



**"SELF-EMPLOYMENT" 
*small farm self employment (sector 2)
*non-agri production business (tailoring, carpenter, handloom, pottery, electricians..) (sector 3)
*labour contractors (maistries) (sector 6)
*all kind of vendors/sellers (sector 8)
*service self-employed (sector 9)
*artists (sector 10)
replace occupcode2020=6 if ///
  kindofwork==2 & occup_sector2==2 ///
| kindofwork==2 & occup_sector2==3 ///
| occup_sector2==6 ///
| kindofwork==2 & occup_sector2==8 ///
| kindofwork==2 & occup_sector2==9 ///
| occup_sector2==10


**"NREGA" (sector 11)
replace occupcode2020=7 if occup_sector2==11


********** Checkup Arnaud 1
sort occupcode2020 occup_sector2 occup_sector occupationname kindofwork annualincome HHID_panel INDID_panel occupationnumber
label define occupcode 1 "Agri self-employed" 2 "Agri casual workers" 3 "Non-agri casual workers" 4 "Non-agri regular non-qualified workers" ///
5 "Non-agri regular qualified workers" 6 "Non-agri self-employed" 7 "Public employment scheme workers (NREGA)"
label values occupcode2020 occupcode

replace occupcode2020=5 if occup_sector2==7 & kindofwork==4 & classcompleted>=10 & salariedjobtype<3
replace occupcode2020=3 if occup_sector2==. & kindofwork==4 & salariedjobtype==3
replace occupcode2020=4 if occup_sector2==. & kindofwork==4 & salariedjobtype<3
replace occupcode2020=6 if occup_sector2==. & kindofwork==2


********** Checkup Arnaud 2
sort occupcode2020 occup_sector2 occup_sector occupationname kindofwork annualincome HHID_panel INDID_panel occupationnumber

replace occupcode2020=1 if occup_sector2==. & kindofwork==1

replace occupcode2020=2 if occup_sector2==. & kindofwork==3 & occupationname=="Aasari"

replace kindofwork=4 if HHID_panel=="MAN31" & INDID_panel=="Ind_1" & occupationnumber=="1"

replace kindofwork=4 if occupationname=="Building contractor"

replace kindofwork=4 if occupationname=="Working at tirupur textile"

replace occupcode2020=5 if occup_sector==85 & classcompleted>=10 

replace occupcode2020=3 if HHID_panel=="ORA46" & INDID_panel=="Ind_3" & occupationnumber=="3"

replace occupcode2020=3 if HHID_panel=="SEM36" & INDID_panel=="Ind_4" & occupationnumber=="1"

replace occupcode2020=4 if HHID_panel=="MAN31" & INDID_panel=="Ind_1" & occupationnumber=="1"

replace occupcode2020=4 if occupationname=="Working at tirupur textile"

replace occupcode2020=3 if occupationname=="Tution centre"

sort occupcode2020 occup_sector2 occup_sector occupationname HHID_panel INDID_panel occupationid



********** Checkup Arnaud 3
/*
preserve
gen annualincome10k=annualincome/10000

gen typewage=.
replace typewage=1 if kindofwork==1
replace typewage=2 if kindofwork==2
replace typewage=3 if salariedjobtype==1 | salariedjobtype==2
replace typewage=4 if salariedjobtype==3 | salariedjobtype==4

label define typewage 1"Agri SE" 2"SE" 3"Perm/fix" 4"Day/Seas"
label values typewage typewage
fre typewage

label define occupcode 1 "Agri SE" 2 "Agri cas" 3 "Nagri cas" 4 "Nagri reg nqual" ///
5 "Nagri reg qual" 6 "Nagri SE" 7 "NREGA", modify

label define kindofwork 1"Agri SE" 2"SE" 3"SJ agri" 4"SJ nagri" 5"UW hh busi" 6"UW oth busi" 7"UW own agri" 8"UW oth agri", modify


*** graph
set graph off
log using "$git\Occupations\Stat2020.log", replace
********** Insight
fre occupcode2020
********** Annual income by occupation and wagetype
stripplot annualincome10k, over(occupcode2020) separate(typewage) ///
cumul cumprob box centre refline vertical /// 
xsize(3) xtitle("") xlabel(,angle(45))  ///
ylabel() ymtick() ytitle("Annual income *10k") ///
msymbol(oh oh oh oh) mcolor(plr1 plg1 ply1 pll1) ///
legend(pos(6) col(4)) name(inc_occ, replace)
graph export "$git\Occupations\income_2020.pdf", replace
stripplot annualincome10k if annualincome10k<50, over(occupcode2020) separate(typewage) ///
cumul cumprob box centre refline vertical /// 
xsize(3) xtitle("") xlabel(,angle(45))  ///
ylabel() ymtick() ytitle("Annual income *10k") ///
msymbol(oh oh oh oh) mcolor(plr1 plg1 ply1 pll1) ///
legend(pos(6) col(4)) name(inc_occ_50, replace)
graph export "$git\Occupations\income50_2020.pdf", replace
********** Education
tab occupcode2020 edulevel, row col nofreq
********** Type of wage
tab occupcode2020 typewage, row col nofreq
********** Caste
tab occupcode2020 caste, row col nofreq
********** Sex
tab occupcode2020 sex, row col nofreq
********** Sector
tab occupcode2020 occup_sector2, row col nofreq
********** Kow
tab occupcode2020 kindofwork, row col nofreq

log close
graphlog using "$git\Occupations\Stat2020.log", lspacing(0.5) fsize(10) msize(.1) porientation(landscape) replace
set graph on
restore
*/





********** Database for check
/*
preserve
keep occupationname occup_sector occup_sector2 kindofwork annualincome classcompleted salariedjobtype salariedjobtype2 everattendedschool classcompleted occupcode2020 setofemployment HHID_panel INDID_panel occupationnumber sex caste
order occupationname occup_sector occup_sector2 kindofwork annualincome everattendedschool classcompleted salariedjobtype salariedjobtype2 occupcode2020, first
order HHID_panel INDID_panel occupationnumber sex caste setofemployment, last
format occupationname %100s
format occup_sector %100.0g
format occup_sector2 %100.0g
format salariedjobtype %100.0g
format salariedjobtype2 %100.0g
format everattendedschool %100.0g
compress
foreach x in occup_sector occup_sector2 occupcode2020{
label var `x' "/!\ --> Construction for panel 2010-2016-2020"
}
save "Occupation2020.dta", replace
restore 
*/




************************ same occupcode2 for 2010 & 2016 & 2020
gen occupcode2=occupcode2020 if year==2020
label values occupcode2 occupcode

tab occupcode2 year, column





************************ Define construction sector dummies (sector 22,26,31,32)
 
gen construction_coolie=(occupcode2020==3 & occup_sector==22|occupcode2020==3 & occup_sector==26|occupcode2020==3 & occup_sector==31) if year==2020

  
gen construction_regular=(occupcode2020==4 & occup_sector==22|occupcode2020==4 & occupationname=="Welder"|occupcode2020==4 & occupationname=="Welding labour"|occupcode2020==4 & occup_sector==32) if year==2020


gen construction_qualified = (occupcode2020==5 & occup_sector==26 & occupationname!="Tv mechanic self employed" ///
|occupcode2020==6 & occup_sector==61 & occupationname!="Mason maistry" ///
|occupcode2020==6 & occup_sector==61 & occupationname =="Brickling maistry" | occupcode2020==6 & occup_sector==61 & occupationname =="Maistry (contractor)" ///
|occupcode2020==6 & occup_sector==61 & occupationname == "Construction maistry" |occupcode2020==6 & occup_sector== 85 & occupationname == "Building contractor") if year==2020	



gen cc=.
replace cc=0 if construction_coolie==0 & occupcode2==3
replace cc=1 if construction_coolie==1 & occupcode2==3
drop construction_coolie
ren cc construction_coolie
tab construction_coolie year, column

gen cr=.
replace cr=0 if construction_regular==0 & occupcode2==4
replace cr=1 if construction_regular==1 & occupcode2==4
drop construction_regular
ren cr construction_regular
tab construction_regular year, column

gen cq=.
replace cq=0 if construction_qualified==0 & occupcode2==5
replace cq=1 if construction_qualified==1 & occupcode2==5
drop construction_qualified
ren cq construction_qualified
tab construction_qualified year, column




* Labelisation of key variables of occupations
**label PROFESSION of workers (occup_sector)
rename occup_sector occupation1
label var occupation1 "Detailed occupations of workers"

**label Occupations of workers
rename occupcode2 occupation2
label var occupation2 "Occupations of workers"

rename occupation1 profession
rename occupation2 occupation
rename occup_sector2 sector



*** Verif
fre egoid
sort egoid



save"$directory\CLEAN\NEEMSIS_APPEND-occupations_v3", replace
****************************************
* END
