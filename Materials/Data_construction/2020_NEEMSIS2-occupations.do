*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Occupations construction
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox\RUME-NEEMSIS\Data\Construction"
cd"$directory"

********** Database names
global data = "NEEMSIS2-HH"
global occupations = "NEEMSIS2-occupations"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2020
*(100/184) if year==2020




****************************************
* Occupations + profession + sector
***************************************
use"$occupations", clear

sort annualincome
replace annualincome=0 if annualincome<100


gen year=2020
drop if occupationname==""

merge m:1 HHID2020 INDID2020 using "$data", keepusing(age classcompleted everattendedschool)
drop if _merge==2
drop _merge

tostring INDID2020, replace
merge m:m HHID2020 INDID2020 using "ODRIIS-indiv_wide", keepusing(HHID_panel INDID_panel)
drop if _merge==2
drop _merge

destring INDID2020, replace

fre kindofwork


********** Occup sectore  
gen occup_sector=.





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
compress 
sort occup_sector occupationname
sort HHID2020 INDID2020 occupationid

***** Recoder kindofwork
replace kindofwork=3 if HHID2020=="uuid:1e92b7e8-0055-44a9-a77a-674c65efb544" & INDID2020==2 & occupationid==2

***** Recoder occup_sector
replace occup_sector=11 if HHID2020=="uuid:96ded94f-86cc-4105-b0af-f1187371cd4e" & occupationname=="Agricultural cooli in own farm"
replace occup_sector=11 if HHID2020=="uuid:e4bae31a-5100-418e-91e1-9255864e93c4" & occupationname=="Agricultural cooli in own farm"
replace occup_sector=11 if HHID2020=="uuid:79cefad2-b1d6-44ea-9d5d-12734c0dffd7" & occupationname=="Agricultural cooli on own land"

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

replace occup_sector=33 if occupationname=="Self help group leader"

replace occup_sector=41 if occupationname=="Assistant professor"

replace occup_sector=44 if occupationname=="Pharmacy work"

replace occup_sector=46 if occupationname=="LIC agent"

replace occup_sector=51 if occupationname=="Municipality worker"
replace occup_sector=51 if occupationname=="NLC Employer"

replace occup_sector=71 if occupationname=="Thinathanthi newspaper"
replace occup_sector=71 if occupationname=="Govt. Job (Clerk in BDO Office)"

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
sort occup_sector occupationname HHID2020 INDID2020 occupationid





********** Label
label values occup_sector occupation1
tab occup_sector, m
/*
HHID2020	INDID2020	occupationid
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






* make occup_sector2 comparable to 2010 and 2020 and 2020
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
sort occup_sector2 occup_sector occupationname kindofwork annualincome HHID2020 INDID2020 occupationid

*salariedjobtype2 classcompleted 

format occupationname %18s
format occup_sector %18.0g
format occup_sector2 %18.0g
format kindofwork %20.0g
format salariedjobtype %10.0g
format salariedjobtype2 %5.0g
format everattendedschool %3.0g

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
sort occupcode2020 occup_sector2 occup_sector occupationname kindofwork annualincome HHID2020 INDID2020 occupationid
label define occupcode 1 "Agri self-employed" 2 "Agri casual workers" 3 "Non-agri casual workers" 4 "Non-agri regular non-qualified workers" ///
5 "Non-agri regular qualified workers" 6 "Non-agri self-employed" 7 "Public employment scheme workers (NREGA)"
label values occupcode2020 occupcode

replace occupcode2020=5 if occup_sector2==7 & kindofwork==4 & classcompleted>=10 & salariedjobtype<3
replace occupcode2020=3 if occup_sector2==. & kindofwork==4 & salariedjobtype==3
replace occupcode2020=4 if occup_sector2==. & kindofwork==4 & salariedjobtype<3
replace occupcode2020=6 if occup_sector2==. & kindofwork==2


********** Checkup Arnaud 2
sort occupcode2020 occup_sector2 occup_sector occupationname kindofwork annualincome HHID2020 INDID2020 occupationid

replace occupcode2020=1 if occup_sector2==. & kindofwork==1

replace occupcode2020=2 if occup_sector2==. & kindofwork==3 & occupationname=="Aasari"

replace kindofwork=4 if HHID2020=="uuid:2abcfcbc-7317-41ba-a857-f76f6e62fc7c" & INDID2020==2 & occupationid==1

replace kindofwork=4 if occupationname=="Building contractor"

replace kindofwork=4 if occupationname=="Working at tirupur textile"

replace occupcode2020=5 if occup_sector==85 & classcompleted>=10 

replace occupcode2020=4 if occupationname=="Working at tirupur textile"

replace occupcode2020=3 if occupationname=="Tution centre"

*** Indiv code
sort HHID2020 INDID2020 occupationid
replace occupcode2020=3 if HHID2020=="uuid:60bb2e46-283a-4d26-935b-d541da45193f" & INDID2020==1 & occupationid==3

replace occupcode2020=3 if HHID2020=="uuid:975dd5f4-3dcf-4502-abfb-f1bde5962657" & INDID2020==4 & occupationid==1

replace occupcode2020=4 if HHID2020=="uuid:2abcfcbc-7317-41ba-a857-f76f6e62fc7c" & INDID2020==2 & occupationid==1


order HHID2020 INDID2020 HHID_panel INDID_panel


sort occupcode2020 occup_sector2 occup_sector occupationname HHID2020 INDID2020 occupationid




************************ same occupcode2 for 2010 & 2020 & 2020
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

drop occupcode2020 HHID_panel INDID_panel

save"_temp\NEEMSIS2-occup1", replace
****************************************
* END











****************************************
* Main occupation
***************************************
use"_temp\NEEMSIS2-occup1", clear
/*
Main occupation is define as the most time consumming occupation.
*/

********** Ego
merge m:1 HHID2020 INDID2020 using "NEEMSIS2-ego.dta", keepusing(egoid selected_occupname dummymainoccupation2 occupation1 occupation2 occupation3 occupation4 occupation5 occupation6 occupation7 occupation8 nbofoccupations othermainoccupation2)
drop if _merge==2
drop _merge occupation1 occupation2 occupation3 occupation4 occupation5 occupation6 occupation7 occupation8
keep HHID2020 INDID2020 occupationid occupationname hoursayear kindofwork_new annualincome year age everattendedschool classcompleted profession sector kindofwork occupation construction_coolie construction_regular construction_qualified egoid selected_occupname dummymainoccupation2 nbofoccupations othermainoccupation2 datestartoccup
sort HHID2020 INDID2020

gen dummymainoccupation=0 if egoid!=.
replace dummymainoccupation=1 if occupationname==selected_occupname & dummymainoccupation2==1
replace dummymainoccupation=1 if occupationname==othermainoccupation2 & dummymainoccupation2==0

order HHID2020 INDID2020 egoid occupationid dummymainoccupation occupationname selected_occupname dummymainoccupation2 othermainoccupation2 

replace dummymainoccupation=0 if occupationid==1 & HHID2020=="uuid:0c90084a-c683-4346-8d93-9665753d7fa3" & INDID2020==1
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:11d432e5-b567-4279-9729-36fe097f4cb4" & INDID2020==2
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:214eb39d-0ba3-4ba0-b0b5-a960ef211eca" & INDID2020==1
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:2b4256be-4c8d-4e08-ab3a-0a935c3dbeec" & INDID2020==2
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:30965eab-e285-48ce-9a2e-bedef927d3ac" & INDID2020==2
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:30bed241-30bc-4213-81c6-0487cb913ca8" & INDID2020==1
replace dummymainoccupation=0 if occupationid==2 & HHID2020=="uuid:31c52e14-e00c-4dcd-a2eb-eed5e6210815" & INDID2020==2
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:32f8ec61-d1cb-4d8a-ab14-62aeaa8570a1" & INDID2020==1
replace dummymainoccupation=1 if occupationid==2 & HHID2020=="uuid:376b5457-41ac-4c8e-9ba5-2c323d76f757" & INDID2020==2
replace dummymainoccupation=1 if occupationid==2 & HHID2020=="uuid:3fe02e46-180b-4f5c-864b-ecda49e97656" & INDID2020==3
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:4e527146-6844-4e21-8f32-f1f9cfedad2a" & INDID2020==1
replace dummymainoccupation=1 if occupationid==2 & HHID2020=="uuid:5dc3364c-92ef-4756-8d98-2dd481a2d075" & INDID2020==1
replace dummymainoccupation=1 if occupationid==2 & HHID2020=="uuid:5f070d84-5bf8-4672-b823-be9057fcde97" & INDID2020==1
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:6319d58c-3f7b-4969-94c0-198e185f63a2" & INDID2020==2
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:69694844-ee5e-450a-80cb-81d85c7d7e7e" & INDID2020==5
replace dummymainoccupation=1 if occupationid==2 & HHID2020=="uuid:7dcd5a01-7a25-47c3-b6c6-74836281cf4b" & INDID2020==1
replace dummymainoccupation=1 if occupationid==2 & HHID2020=="uuid:7dcd5a01-7a25-47c3-b6c6-74836281cf4b" & INDID2020==2
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:845162bf-a21a-4003-910b-364e995bf863" & INDID2020==3
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:86574ca0-02c2-4e2b-9d3b-f644d9c6da68" & INDID2020==2
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:89f0eed8-03fb-4e07-8773-90bd6e4c7530" & INDID2020==1
replace dummymainoccupation=1 if occupationid==2 & HHID2020=="uuid:9539ae39-3424-43c0-9690-51e76b050896" & INDID2020==1
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:9bc0d4be-96cd-4d5e-aa71-98313b21905f" & INDID2020==1
replace dummymainoccupation=1 if occupationid==2 & HHID2020=="uuid:a5864c62-bf01-4313-a7b4-47985821c1e4" & INDID2020==2
replace dummymainoccupation=0 if occupationid==2 & HHID2020=="uuid:a690cb5d-34be-4157-a08d-2c574a5a3cb9" & INDID2020==2
replace dummymainoccupation=1 if occupationid==2 & HHID2020=="uuid:a7b4d739-b69d-4efb-b34a-0b175dd933fe" & INDID2020==1
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:a9c75fcf-6a0a-4731-bf42-1e80752fcc73" & INDID2020==1
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:a9e70587-aa67-4459-a216-4cf2c9d41779" & INDID2020==1
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:b33ac02d-ffe0-4a63-8b4a-1ac442b86cf7" & INDID2020==2
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:bcf78ad0-0c91-46d0-9ff9-6fd1b508541c" & INDID2020==5
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:c50c36f8-7fdc-42f7-8aad-4f597870cdd3" & INDID2020==1
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:c76f8b20-2118-499e-ba30-3666f3f6615a" & INDID2020==2
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:cccb6456-1994-45f8-b6f3-f1777d99483c" & INDID2020==1
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:d4a5192d-74e4-4cb8-8b48-1d971f68cb54" & INDID2020==1
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:dc69d4b1-2609-4936-890f-3a5ca8bc0ed1" & INDID2020==2
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:e3ff8654-5079-4cb1-ab14-ce83b63d894a" & INDID2020==2
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:e5d9e97a-f3b9-49e1-9cde-1ad11dc43009" & INDID2020==3
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:ea20a948-0e03-4bf5-ad8c-abe731ee2fe0" & INDID2020==3
replace dummymainoccupation=1 if occupationid==2 & HHID2020=="uuid:f164c2d2-5994-43cc-909d-7de652709dd0" & INDID2020==1
replace dummymainoccupation=1 if occupationid==2 & HHID2020=="uuid:f435ac6b-11a5-4273-a5a0-d7f2bb74b5f6" & INDID2020==4
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:fa376985-5b91-4eca-bc3d-d3ac3618bcce" & INDID2020==2
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:ff2ee18b-8363-4316-96ea-5a41a37094c0" & INDID2020==1
replace dummymainoccupation=1 if occupationid==1 & HHID2020=="uuid:ff95bdde-6012-4cf6-b7e8-be866fbaa68b" & INDID2020==1

*Test ego
preserve
bysort HHID2020 INDID2020: egen mocindiv=sum(dummymainoccupation)
keep HHID2020 INDID2020 egoid mocindiv
duplicates drop
ta mocindiv egoid
gen pb=1 if mocindiv==0 & egoid!=.
replace pb=1 if mocindiv==2 & egoid!=.
sort pb HHID2020 INDID2020
restore






********** Non-ego
bysort HHID2020 INDID2020: egen maxhours=max(hoursayear)
gen tempdum=1 if maxhours==hoursayear & egoid==.
bysort HHID2020 INDID2020: egen checkhours=sum(tempdum)
replace checkhours=. if egoid!=.
ta checkhours
sort checkhours

bysort HHID2020 INDID2020: egen maxincome=max(annualincome)
gen tempdum2=1 if maxincome==annualincome & egoid==. & checkhours==2
replace tempdum=tempdum2 if checkhours==2

drop checkhours
bysort HHID2020 INDID2020: egen checkhours=sum(tempdum)
replace checkhours=. if egoid!=.
ta checkhours
sort checkhours
drop checkhours
ta tempdum
replace dummymainoccupation=tempdum if egoid==.




********** Gen var
foreach x in kindofwork profession occupation sector annualincome {
gen temp_mainocc_`x'=.
}
gen temp_mainocc_occupationname=""

foreach x in kindofwork profession occupation sector annualincome {
replace temp_mainocc_`x'=`x' if dummymainoccupation==1 
}
replace temp_mainocc_occupationname=occupationname if dummymainoccupation==1


*Individual level now
foreach x in kindofwork profession occupation sector annualincome {
bysort HHID2020 INDID2020: egen mainocc_`x'=max(temp_mainocc_`x')
}

*More tricky for occupname:
encode temp_mainocc_occupationname, gen(mainoccnamenum)
bysort HHID2020 INDID2020: egen _mainocc_occupationname=max(mainoccnamenum)
label values _mainocc_occupationname mainoccnamenum
decode _mainocc_occupationname, gen(mainocc_occupationname)

*Label
label values mainocc_kindofwork occupationtype
label values mainocc_profession occupation1
label values mainocc_occupation occupcode
label values mainocc_sector sector

*Rename
foreach x in mainocc_kindofwork mainocc_profession mainocc_occupation mainocc_sector mainocc_annualincome mainocc_occupationname {
rename `x' `x'_indiv
}


***Nb occupation per indiv + annual income per indiv
bysort HHID2020 INDID2020: egen annualincome_indiv=sum(annualincome)
bysort HHID2020 INDID2020: egen nboccupation_indiv=sum(1)


*Clean
drop maxhours tempdum temp_mainocc_kindofwork temp_mainocc_profession temp_mainocc_occupation temp_mainocc_sector temp_mainocc_annualincome temp_mainocc_occupationname mainoccnamenum _mainocc_occupationname

rename dummymainoccupation dummymainoccupation_indiv

*test
preserve
keep HHID2020 INDID2020
duplicates drop
count
*1711
restore 

preserve
keep if dummymainoccupation_indiv==1
count
*1711
restore


drop egoid selected_occupname dummymainoccupation2 othermainoccupation2 everattendedschool classcompleted maxincome tempdum2

order HHID2020 INDID2020 year age occupationid occupationname hoursayear kindofwork_new annualincome profession sector kindofwork occupation construction_coolie construction_regular construction_qualified dummymainoccupation_indiv mainocc_kindofwork_indiv mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv



********** Tenure
merge m:1 HHID2020 INDID2020 using "$data", keepusing(submissiondate)
drop if _merge==2
drop _merge

format datestartoccup %td
fre datestartoccup
fre submissiondate
rename submissiondate submissiondate_o
gen submissiondate=dofc(submissiondate_o)
format submissiondate %td
drop submissiondate_o

gen tenure=submissiondate-datestartoccup
fre tenure
gen tenure_month=tenure/30.467
gen tenure_year=tenure/365
tabstat tenure_year, stat(min p1 p5 p10 q p90 p95 p99 max)

order datestartoccup submissiondate tenure tenure_month tenure_year, last
sort tenure_year

gen mainocc_tenureday=tenure if dummymainoccupation==1
bysort HHID2020 INDID2020: egen mainocc_tenureday_indiv=max(mainocc_tenureday)
sort HHID2020 INDID2020


********** Check
ta occupation kindofwork
ta occupationname if occupation==1 & kindofwork==3
ta occupationname if occupation==1 & kindofwork==4

gen hourlyincome=annualincome/hoursayear

tabstat annualincome, stat(n mean cv p1 p5 p10 q p90 p95 p99 min max) by(kindofwork)
tabstat hourlyincome, stat(n mean cv p1 p5 p10 q p90 p95 p99 min max) by(kindofwork)
tabstat annualincome, stat(n mean cv p1 p5 p10 q p90 p95 p99 min max) by(occupation)
tabstat hourlyincome, stat(n mean cv p1 p5 p10 q p90 p95 p99 min max) by(occupation)

drop hourlyincome

sort annualincome
order HHID2020 INDID2020 annualincome occupationname kindofwork occupation

save "_temp\NEEMSIS2-occup2", replace
save "outcomes\NEEMSIS2-occupnew", replace
****************************************
* END














****************************************
* Add all
***************************************
use"_temp\NEEMSIS2-occup2", clear


********** Add all
merge m:1 HHID2020 INDID2020 using "$data", keepusing(name age sex relationshiptohead villageid jatis dummyworkedpastyear livinghome dummylefthousehold)
drop _merge

order name age sex relationshiptohead villageid jatis dummyworkedpastyear livinghome dummylefthousehold, after(INDID2020)


* occupcode3 includes individuals counted in working pop but not working 
gen occupcode3=occupation 
replace occupcode3=0 if occupationid==.

label define occupcode 0 "No occupation", modify
label values occupcode3 occupcode


**label Occupations of workers + unoccupied individuals
rename occupcode3 occupation3
label var occupation3 "Occupations of workers + unoccupied individuals"

**Generate and label occupation variable only for population on working age (15-60 included)
gen occupation4=.
replace occupation4=occupation3 if age>14 & age<71
label define occupcode 0 "Unoccupied working age individuals", modify
label var occupation4 "Occupations of workers + unoccupied working age indiv (15-70)"
label values occupation4 occupcode


**Generate active and inactive population in the same variable
gen working_pop=.
replace working_pop = 1 if occupation4==.
replace working_pop = 2 if occupation4==0	
replace working_pop = 3 if occupation4>0 & occupation4!=.
label define working_pop 1 "Inactive" 2 "Unoccupied active" 3 "Occupied active", modify
label var working_pop "Distribution of inactive and active population accord. to criteria of age 15-70"
label values working_pop working_pop


rename occupation3 occupa_unemployed
rename occupation4 occupa_unemployed_15_70


save "_temp\NEEMSIS2-occup3", replace
****************************************
* END








****************************************
* Indiv + HH level
***************************************
use"_temp\NEEMSIS2-occup3", clear

*Agri vs non agri
fre occupation

gen incomeagri=.
gen incomenonagri=.

replace incomeagri=annualincome if occupation==1
replace incomeagri=annualincome if occupation==2

replace incomenonagri=annualincome if occupation==3
replace incomenonagri=annualincome if occupation==4
replace incomenonagri=annualincome if occupation==5
replace incomenonagri=annualincome if occupation==6
replace incomenonagri=annualincome if occupation==7

bysort HHID2020 INDID2020: egen incomeagri_indiv=sum(incomeagri)
bysort HHID2020 INDID2020: egen incomenonagri_indiv=sum(incomenonagri)

bysort HHID2020: egen incomeagri_HH=sum(incomeagri)
bysort HHID2020: egen incomenonagri_HH=sum(incomenonagri)
bysort HHID2020: egen annualincome_HH=sum(annualincome)

drop incomeagri incomenonagri

gen shareincomeagri_indiv=incomeagri_indiv/annualincome_indiv
gen shareincomenonagri_indiv=incomenonagri_indiv/annualincome_indiv
gen shareincomeagri_HH=incomeagri_HH/annualincome_HH
gen shareincomenonagri_HH=incomenonagri_HH/annualincome_HH


*Precision
fre occupation
gen incagrise=annualincome if occupation==1
gen incagricasual=annualincome if occupation==2
gen incnonagricasual=annualincome if occupation==3
gen incnonagriregnonquali=annualincome if occupation==4
gen incnonagriregquali=annualincome if occupation==5
gen incnonagrise=annualincome if occupation==6
gen incnrega=annualincome if occupation==7

foreach x in agrise agricasual nonagricasual nonagriregnonquali nonagriregquali nonagrise nrega {
bysort HHID2020 INDID2020: egen inc`x'_indiv=sum(inc`x')
bysort HHID2020: egen inc`x'_HH=sum(inc`x')
}

foreach x in agrise agricasual nonagricasual nonagriregnonquali nonagriregquali nonagrise nrega {
gen shareinc`x'_indiv=inc`x'_indiv/annualincome_indiv
gen shareinc`x'_HH=inc`x'_HH/annualincome_HH
}


********** Indiv level
preserve
keep HHID2020 INDID2020 dummyworkedpastyear mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv working_pop incomeagri_indiv incomenonagri_indiv shareincomeagri_indiv shareincomenonagri_indiv incagrise_indiv incagricasual_indiv incnonagricasual_indiv incnonagriregnonquali_indiv incnonagriregquali_indiv incnonagrise_indiv incnrega_indiv shareincagrise_indiv shareincagricasual_indiv shareincnonagricasual_indiv shareincnonagriregnonquali_indiv shareincnonagriregquali_indiv shareincnonagrise_indiv shareincnrega_indiv mainocc_tenureday_indiv
duplicates drop
order HHID2020 INDID2020 dummyworkedpastyear working_pop
save"outcomes\NEEMSIS2-occup_indiv", replace
restore

********** HH level
keep HHID2020 INDID2020 dummyworkedpastyear working_pop livinghome dummylefthousehold incomeagri_HH incomenonagri_HH annualincome_HH shareincomeagri_HH shareincomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH  
duplicates drop
drop if livinghome==3 | livinghome==4
drop if dummylefthousehold==1
*Nb workers
fre working_pop
gen nonworker=1 if working_pop==1
gen worker=1 if working_pop==2 | working_pop==3
bysort HHID2020: egen nbworker_HH=sum(worker)
bysort HHID2020: egen nbnonworker_HH=sum(nonworker)

drop INDID2020 dummyworkedpastyear working_pop nonworker worker livinghome dummylefthousehold
duplicates drop
save"outcomes\NEEMSIS2-occup_HH", replace
****************************************
* END
