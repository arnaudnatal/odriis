cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
September 30, 2021
-----
TITLE: Occupation

-------------------------
*/

clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global git ="C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

cd"$directory"
clear all





****************************************
* Occupation
****************************************
use"$directory\CLEAN\NEEMSIS_APPEND-occupations_v3", clear

merge m:m setofemployment using "$directory\CLEAN\NEEMSIS2-HH_v14.dta", keepusing(HHID_panel INDID_panel age sex jatis classcompleted everattendedschool canread edulevel)
drop if _merge==2
drop _merge

drop keep_occupposition _2keep_occupposition _3keep_occupposition businesslabourers_count infoemployer_count salariedjobgroup2_count

order HHID_panel INDID_panel
destring hoursayear, replace

gen year=2020

gen occup_sector= .

gen classcompleted10ormore=.
replace classcompleted10ormore=0 if classcompleted<10 & classcompleted!=.
replace classcompleted10ormore=1 if classcompleted>=10 & classcompleted!=.

drop classcompleted

gen agetowork=.
replace agetowork=0 if age<=14 & age!=.
replace agetowork=0 if age>=71 & age!=.
replace agetowork=1 if age>14 & age<71 & age!=.

drop age

rename kindofwork kindofwork2020

*Quelles occupations ?
cls
preserve
duplicates drop occupationname kindofwork2020 classcompleted10ormore everattendedschool agetowork, force
keep occupationname kindofwork2020 everattendedschool classcompleted10ormore agetowork
gen profession=.
order kindofwork occupationname profession
export excel using "$git\Occupations\Occupations.xlsx", sheet("NEEMSIS2") sheetmodify firstrow(variables)

gen year=2020

keep occupationname profession year
save"$git\Occupations\sector2020.dta", replace

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

	
* Other craftsworkers (Carpenters, tiles workers, Paper product makers)	
replace occup_sector=32 if ///
strpos(occupationname,"Carpent")
 
	
* Other labour
replace occup_sector=33 if occupationname=="Cooli work"
replace occup_sector=33 if occupationname=="Cooli worker"
replace occup_sector=33 if occupationname=="Coolie"
replace occup_sector=33 if occupationname=="Coolie  worker"
replace occup_sector=33 if occupationname=="Coolie worker"
replace occup_sector=33 if occupationname=="Coolie worker in market"

replace occup_sector=33 if occupationname=="Private company"
replace occup_sector=33 if occupationname=="Private company  cellphone delivery"
replace occup_sector=33 if occupationname=="Private company (Abudhabi)"
replace occup_sector=33 if occupationname=="Private company at Pondy"
replace occup_sector=33 if occupationname=="Private company at Saudi Arabia"
replace occup_sector=33 if occupationname=="Private company at chennai"
replace occup_sector=33 if occupationname=="Private company at pantruti"
replace occup_sector=33 if occupationname=="Private company cellphone  delivery"
replace occup_sector=33 if occupationname=="Private company in pantruti"
replace occup_sector=33 if occupationname=="Private company pantruti"
replace occup_sector=33 if occupationname=="Private company worker"
replace occup_sector=33 if occupationname=="Worker in a UCO4G COMPANY  "
replace occup_sector=33 if occupationname=="Worker in a gas company"
replace occup_sector=33 if occupationname=="Worker in private company"
replace occup_sector=33 if occupationname=="Working at chemical company"
replace occup_sector=33 if occupationname=="Working at computer centre"
replace occup_sector=33 if occupationname=="Working at private company"
replace occup_sector=33 if occupationname=="Working at textile"
replace occup_sector=33 if occupationname=="Working at tirupur textile"
replace occup_sector=33 if occupationname=="Working at tolgate"
replace occup_sector=33 if occupationname=="Working in TVS company"
replace occup_sector=33 if occupationname=="Working in cuddalore  sipcot"
replace occup_sector=33 if occupationname=="Working in cuddalore sipcot"
		
	
**** Qualified jobs
* Teachers	
replace occup_sector=41 if ///
strpos(occupationname,"Teacher") ///
| strpos(occupationname,"teacher") 


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
*replace occup_sector=43 if ///




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
/*
replace occup_sector=46 if ///
strpos(occupationname,"") ///
*/


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


	
**** Performing artists
replace occup_sector=101 if strpos(occupationname,"Drum")
replace occup_sector=101 if strpos(occupationname,"drum")
replace occup_sector=101 if strpos(occupationname,"Art's work")
replace occup_sector=101 if strpos(occupationname,"Arts work")


		
**** Astrologers 
replace occup_sector=102 if strpos(occupationname,"Astro")
replace occup_sector=102 if strpos(occupationname,"astro")



**** Public works/ NREGA
replace occup_sector=111 if strpos(occupationname,"NREG")
replace occup_sector=111 if strpos(occupationname,"Nreg")
replace occup_sector=111 if strpos(occupationname,"nreg")
replace occup_sector=111 if occupationname=="NREga"


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

preserve
keep if occup_sector==.
duplicates drop occupationname, force
sort occupationname
list occupationname, clean noobs
restore

preserve
rename occup_sector profession
gen codepro=profession+1-1
keep occupationname profession codepro
duplicates drop
sort occupationname





	
	
* make occup_sector2 comparable to 2010 
	
tab kindofwork occup_sector2 

clonevar kindofwork_old=kindofwork

replace kindofwork=3 if occup_sector2==2 & kindofwork==4
replace kindofwork=4 if occup_sector2==3 & kindofwork==3
replace kindofwork=4 if kindofwork==3 & occup_sector2==4
replace kindofwork=4 if kindofwork==3 & occup_sector2==7
replace kindofwork=4 if kindofwork==3 & occup_sector2==9
replace kindofwork=2 if occup_sector2==10
* attention !!!! malgré ces changements, details des occupations restent dans catégorie initiale (SE, salaried)


*recode handloom: recode to self-employed when job location is govulapuram or same village
replace kindofwork=2 if occup_sector==23 & kindofwork!=2 & joblocation=="Same village" ///
| occup_sector==23 & kindofwork!=2 & joblocation=="Govulapuram"		///
| occup_sector==23 & kindofwork!=2 & joblocation=="Same village,own house"		///
| occup_sector==23 & kindofwork!=2 & joblocation=="Same villlage"

**** attention: information about handloom workers will be in salaried workers module instead of self-employed module

rename kindofwork kindofwork_new
rename kindofwork_old kindofwork
	
	
	
	
	
	
	
	
	
************************ define occupcode2016 (replace occupcode)

**"CULTIVATORS" 
gen occupcode2016= 1 if occup_sector2==1

**"AGRI COOLIE" (in occup sector 2 but not self-employed)
replace occupcode2016= 2 if occup_sector2==2 & kindofwork!=2

**"COOLIE NON-AGRI" (industry+service): employed, daily/seasonal/occasional job
* industry workers (sector 3) 
* coolies in shops	(sector 8)	
* coolies in service (sector 9)

replace occupcode2016= 3 if occup_sector2==3 & kindofwork!=2 & salariedjobtype>=3 | occup_sector2==8 & kindofwork!=2 & salariedjobtype>=3 | occup_sector2==9 & kindofwork!=2 & salariedjobtype>=3

**"REGULAR NON-QUALIFIED NON-AGRI" (industry+service): employed, fixed/permanent jobs, less than 10std or more than 10std but no monthly wage (only piece rate or daily)	
* regular non qualified industry workers (sector 3): mostly in sector 22, 23= construction, handloom in thirupur)
* Clerical workers (sector 7)
* employed in shops (sector 8)		
* employed service workers (sector 9)
* qualified job but less than 10std (mid wife, assistant) (sector 4)
	
			
replace occupcode2016=4 if occup_sector2==3 & kindofwork!=2 & salariedjobtype<3 & classcompleted<10 | occup_sector2==3 & kindofwork!=2 & salariedjobtype<3 & everattendedschool==0 ///
			| occup_sector2==3 & kindofwork!=2 & salariedjobtype<3 & classcompleted>=10 & salariedwagetype!=3 ///
			| occup_sector2==7 & classcompleted<10 | occup_sector2==7 & classcompleted>=10 & salariedwagetype!=3 ///
			| occup_sector2==8 & kindofwork!=2 & salariedjobtype<3 | occup_sector2==9 & kindofwork!=2 & salariedjobtype<3 ///
			| occup_sector2==4 & classcompleted<10 

			
* créer sous catégorie de regular non qualified pour migrants (thiruppur et brick kiln) ??? quelle part représentent-ils dans cette catégorie ?
* using job location
* pour migrants: frontière coolie/regular est floue: une partie déclaré "permanent" jobs but all have piece rate/daily wages
			
		**"REGULAR QUALIFIED NON-AGRI" (industry+service): fixed/permanent jobs, more than 10std, and monthly wage
			* qualified and regular industry workers (sector 3): mostly in sector 26, 27, 31= electrician, mechanic, private comp)
			* Qualified jobs (sector 4), more than 10std
			* Administrative, executive and managerial workers (sector 5): all more than 10 std

replace occupcode2016=5 if occup_sector2==3 & kindofwork!=2 & salariedjobtype<3 & classcompleted>=10 & salariedwagetype==3 ///
			| occup_sector2==4 & classcompleted>=10 & salariedwagetype==3 | occup_sector2==5  ///

		
		**"SELF-EMPLOYMENT" 
			*small farm self employment (sector 2)
			*non-agri production business (tailoring, carpenter, handloom, pottery, electricians..) (sector 3)
			*labour contractors (maistries) (sector 6)
			*all kind of vendors/sellers (sector 8)
			*service self-employed (sector 9)
			*artists (sector 10)
		
replace occupcode2016=6 if kindofwork==2 & occup_sector2==2 | kindofwork==2 & occup_sector2==3 | occup_sector2==6 | kindofwork==2 & occup_sector2==8 | kindofwork==2 & occup_sector2==9 | occup_sector2==10


		**"NREGA" (sector 11)
replace occupcode2016=7 if occup_sector2==11


* recode non-agri coolie unpaid in HH/other business (mostly pottery) to self-employed
		* clay toys maker & petty shop, etc: recoded to self-employed (family business)
replace occupcode2016=6 if occupcode2016==3 & kindofwork==5
replace occupcode2016=6 if occupcode2016==3 & kindofwork==6
replace occupcode2016=6 if occupcode2016==3 & kindofwork==7
replace occupcode2016=6 if occupcode2016==4 & kindofwork==5
replace occupcode2016=6 if occupcode2016==4 & kindofwork==6

replace occupcode2016=6 if occupcode2016==3 & occup_sector2==8 & joblocation=="Own"


*** pour indsutry sector: frontiere floue entre non-agri coolie et regular non-qualified 

		*first step: all permanent jobs non-qualified coded in regular non-qualified
			* & non-permanent in non-agri coolie (code occupcode2016 above)	
		*second step: 
			* sector 23-24-28-29 (handloom &tailors labour, drivers, powerloom operators), even if some daily workers => regular non-qualified
			* sector 30 (loading), occasional tractor drivers (28), other coolie/helper, construction => non-agri coolie
			
			
* recode from non-agri coolie to regular non-qualified (drivers(28), tailors(24), construction)
replace occupcode2016=4 if occupcode2016==3 & occup_sector2==9 & occupationname=="Driver"
replace occupcode2016=4 if occupcode2016==3 & occup_sector2==3 & occup_sector==28 & salariedjobtype==3
replace occupcode2016=4 if occupcode2016==3 & occup_sector2==3 & occup_sector==24 & salariedjobtype==3
replace occupcode2016=4 if occupcode2016==3 & occupationname=="Masan"|occupcode2016==3 & occupationname=="Mason"| occupcode2016==3 & occupationname=="Painter" ///
| occupcode2016==3 & occupationname=="Painting work" | occupcode2016==3 & occupationname=="Painting" | occupcode2016==3 & occupationname=="Painting worker" ///
| occupcode2016==3 & occupationname=="Tiles work" | occupcode2016==3 & occupationname=="Construction mason"

* recode from self-employed to regular non-qualified (carpentor): ***this job info will still be in SE!!
replace occupcode2016=4 if occupcode2016==6 & occupationname=="Carpentor"

* recode from self-employed to regular qualified (electricians, mechanics): ***this job info will still be in SE!!
replace occupcode2016=5 if occupcode2016==6 & occupationname=="Elactetion work"|occupcode2016==6 & occupationname== "Electrician" ///
|occupcode2016==6 & occupationname== "A/C Mechanic Own Shop at Chennai" ///
|occupcode2016==6 & occupationname== "Tv mechanic self employed"

* recode from regular qualified to regular non-qualified (tailoring, drivers, operators, other industry labour)
replace occupcode2016=4 if occupcode2016==5 & occup_sector2==3 & occup_sector==24 |occupcode2016==5 & occup_sector2==3 & occup_sector>27

* recode from non-agri coolie to qualified (electricians)
replace occupcode2016=5 if occupcode2016==3 & occup_sector2==3 & occup_sector==26 & occupationname!="Wiring helper"
* recode from regular non-qualified to qualified (electricians, mechanics)
replace occupcode2016=5 if occupcode2016==4 & occup_sector2==3 & occup_sector==26
replace occupcode2016=5 if occupcode2016==4 & occup_sector2==3 & occup_sector==27

* recode from regular non-qualified to non-agri coolie (load man)
replace occupcode2016=3 if occupcode2016==4 & occup_sector2==3 & occup_sector==30
replace occupcode2016=3 if occupcode2016==4 & occup_sector2==3 & occupationname=="Sculpture (coolie)"


* former label
*label define occupcode 1 "Cultivators" 2 "Agri coolie" 3 "Non-agri coolie" 4 "Regular non-qualified" ///
*5 "Regular qualified" 6 "SE" 7 "NREGA"

label define occupcode 1 "Agri self-employed" 2 "Agri casual workers" 3 "Non-agri casual workers" 4 "Non-agri regular non-qualified workers" ///
5 "Non-agri regular qualified workers" 6 "Non-agri self-employed" 7 "Public employment scheme workers (NREGA)"


label values occupcode2016 occupcode

tab occupcode2016 if year==2016



* distinction non-agri coolie & regular non qualified pas très claire...
	* using job location: new category for migrant construction workers
	* shop labour: family business ? 5 are in non-agri coolies
	* occup_sector 31-33: flou


bys occup_sector2: tab occupationname  salariedwagetype  if occupcode2016==3 & occup_sector!=22
* list job coolie non-agri industry hors construction
tab occupationname occup_sector  if occupcode2016==3 & occup_sector2==3 & occup_sector!=22 
tab occupationname salariedwagetype  if occupcode2016==3 & occup_sector2==3 & occup_sector!=22 
tab occupationname salariedjobtype  if occupcode2016==3 & occup_sector2==3 & occup_sector!=22 
tab occupationname annualincome if occupcode2016==3 & occup_sector2==3 & occup_sector!=22 


bys occup_sector2: tab occupationname  salariedwagetype  if occupcode2016==4 & occup_sector!=22
* list job regular non-qualified industry hors construction
tab occupationname occup_sector  if occupcode2016==4 & occup_sector2==3 & occup_sector!=22 
tab occupationname salariedwagetype  if occupcode2016==4 & occup_sector2==3 & occup_sector!=22 
tab occupationname salariedjobtype  if occupcode2016==4 & occup_sector2==3 & occup_sector!=22 
tab occupationname annualincome if occupcode2016==4 & occup_sector2==3 & occup_sector!=22 












************************ same occupcode2 for 2010 & 2016 
 
gen occupcode2=occupcode2016 if year==2016
label values occupcode2 occupcode

replace occupcode2=5 if occupcode2==. & occupationname=="Advocate"
replace occupcode2=4 if occupcode2==. & occupationname=="Bus driver"
replace occupcode2=4 if occupcode2==. & occupationname=="Office assistant in Co-operative bank"
replace occupcode2=4 if occupcode2==. & occupationname=="Water company private"
replace occupcode2=4 if occupcode2==. & occupationname=="Accountant in ration (gov job) no contract yet"
replace occupcode2=4 if occupcode2==. & occupationname=="Secretary(primary agriculture cooperative bank)"


replace occupationid=. if occupationname=="No occupation"


tab occupcode2 year, column















************************ Define construction sector dummies (sector 22,26,31,32)
 
gen construction_coolie=(occupcode2016==3 & occup_sector==22|occupcode2016==3 & occup_sector==26|occupcode2016==3 & occup_sector==31) if year==2016

  
gen construction_regular=(occupcode2016==4 & occup_sector==22|occupcode2016==4 & occupationname=="Welder"|occupcode2016==4 & occupationname=="Welding labour"|occupcode2016==4 & occup_sector==32) if year==2016


gen construction_qualified = (occupcode2016==5 & occup_sector==26 & occupationname!="Tv mechanic self employed" ///
|occupcode2016==6 & occup_sector==61 & occupationname!="Mason maistry" ///
|occupcode2016==6 & occup_sector==61 & occupationname =="Brickling maistry" | occupcode2016==6 & occup_sector==61 & occupationname =="Maistry (contractor)" ///
|occupcode2016==6 & occup_sector==61 & occupationname == "Construction maistry" |occupcode2016==6 & occup_sector== 85 & occupationname == "Building contractor") if year==2016	



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


* occupcode3 includes individuals counted in working pop but not working 
gen occupcode3=occupcode2 
replace occupcode3=0 if occupationid==.

label define occupcode 0 "No occupation", modify
label values occupcode3 occupcode














* Labelisation of key variables of occupations
	
		**label PROFESSION of workers (occup_sector)
	rename occup_sector occupation1
	label var occupation1 "Detailed occupations of workers"
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
	label value occupation1 occupation1

		**label Occupations of workers
	rename occupcode2 occupation2
	label var occupation2 "Occupations of workers"
		
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


rename occupation1 profession
rename occupation2 occupation
rename occupation3 occupa_unemployed
rename occupation4 occupa_unemployed_15_70


save"NEEMSIS-occupation_alllong_v2.dta", replace
****************************************
* END
