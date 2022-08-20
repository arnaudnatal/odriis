cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
January 29, 2021
-----
Tracking cleaning
-----

-------------------------
*/


****************************************
* INITIALIZATION
****************************************
clear all
global directory "C:\Users\Arnaud\Documents\MEGA\Data\Data_Tracking2019\DATA"
cd"$directory"
****************************************
* END








****************************************
* Occupations
****************************************
use"NEEMSIS-tracking_v5.dta", clear
keep key indid indid2 name age sex edulevel caste classcompleted everattendedschool
preserve
keep if indid!=.
save"NEEMSIS-edu_indid_merge.dta", replace
restore
keep if indid2!=.
save"NEEMSIS-edu_indid2_merge.dta", replace
clear all


use"NEEMSIS-tracking_occupations_allwide.dta", clear
merge m:1 key indid2 using "NEEMSIS-edu_indid2_merge.dta"
drop if _merge==2
drop _merge
foreach x in name caste sex age everattendedschool classcompleted edulevel {
rename `x' `x'2
}
merge m:1 key indid using "NEEMSIS-edu_indid_merge.dta"
drop if _merge==2
drop _merge

replace name=name2 if name==""
replace caste=caste2 if caste==.
replace sex=sex2 if sex==.
replace age=age2 if age==.
replace everattendedschool=everattendedschool2 if everattendedschool==.
replace classcompleted=classcompleted2 if classcompleted==.
replace edulevel=edulevel2 if edulevel==.

fre name caste sex age everattendedschool classcompleted edulevel

drop name2 caste2 sex2 age2 everattendedschool2 classcompleted2 edulevel2

order key indid2 indid name caste sex age everattendedschool classcompleted edulevel occupid
sort key indid2 indid occupid

gen year=2019

save"NEEMSIS-tracking_occupations_allwide_v2.dta", replace


********** Occupations new taxonomy for panel utilisation

***** Age to work and classcompleted for qualified jobs
gen occup_sector= .

gen classcompleted10ormore=.
replace classcompleted10ormore=0 if classcompleted<10 & classcompleted!=.
replace classcompleted10ormore=1 if classcompleted>=10 & classcompleted!=.

gen agetowork=.
replace agetowork=0 if age<=14 & age!=.
replace agetowork=0 if age>=71 & age!=.
replace agetowork=1 if age>14 & age<71 & age!=.

***** List of all occupations
preserve
duplicates drop occupationname kindofwork classcompleted10ormore everattendedschool agetowork, force
keep occupationname kindofwork everattendedschool classcompleted10ormore agetowork
gen profession=.
order kindofwork occupationname profession
export excel using "occupationslist.xlsx", sheet("Tracking1") sheetmodify firstrow(variables)
restore


********** Let's go

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



****************************************
* END