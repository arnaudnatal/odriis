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
global directory = "C:\Users\Arnaud\Documents\MEGA\ODRIIS\Materials\WSPY2022\"
cd"$directory"

********** Database names
global data = "RUME-HH"
global occupations = "RUME-occupations"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020






****************************************
* Occupations + profession + sector
***************************************
use"$occupations", clear

gen year=2010

merge m:1 HHID2010 INDID2010 using "$data", keepusing(age education)
drop if _merge==2
drop _merge

fre kindofwork


********** Occup sectore  
/*
Pension and no occup not assigned to occup-sector
*/
gen occup_sector=.

*Cultivators
replace occup_sector=11 if year==2010 & (occupationname=="AGRI" | occupationname=="AGRI BUSINESS" | occupationname=="AGRI CULTURE" ///
| occupationname=="AGRICULTURE" )

*Agricultural labourers
replace occup_sector=12 if year==2010 & (occupationname=="AGRI COOLI" | occupationname=="AGRI COOLIE" | occupationname=="AGRI COOLLIE"  ///
| occupationname=="AGRI,COOLIE" | occupationname=="AGRI. COOLIE" | occupationname=="AGRI.COOLI" | occupationname=="AGRI.COOLIE" | occupationname=="AGRICOOLIE" ///
| occupationname=="AGRICULTURE COOLIE" | occupationname=="AGRI BASED WORK" | occupationname=="PLOUGHING" |  occupationname=="COOLIE IN KERALA")

*Sugarcane plantation labourers
replace occup_sector=13 if year==2010 & (occupationname=="SUGARCANECUTTING" | occupationname=="SUGARCANE CUTTING" | occupationname=="SUGAR CANE CUTTING")

*Other farm workers
replace occup_sector=14 if year==2010 & (occupationname=="COW REARING" | occupationname=="EID PARRY (sugar mill factory)" | occupationname=="MILK BUSINESS" ///
| occupationname=="MILK COLLECTION" |  occupationname=="FLOUR MILL" |  occupationname=="FRUIT PRODUCTION" |  occupationname=="SELF-POWER TILLER")

*Bricklayers and construction workers (chamber, roads)
replace occup_sector=22 if year==2010 & (occupationname=="CHAMBER" |  occupationname=="CHAMBER OWN" ///
| occupationname=="CHAMBER WORK" | occupationname=="CHAMEBER WORK" |  occupationname=="CONSTRUCTION WORK" | occupationname=="CONSTRUCTION WORKER COOLIE" ///
| occupationname=="CONSTRUCTION WROK" | occupationname=="ROAD WORK" | occupationname=="BRICK WORK" ///
| occupationname=="CENTRING WORK (CONSTRUCTION)" | occupationname=="MASON" | occupationname=="CONSTRUCTION" | occupationname=="SUVELAI (CHAMBER)" | occupationname=="SULAI VELAI (CHAMBER)" ///
| occupationname=="PAINTER" | occupationname=="PAINTER, AGRI COOLIE" | occupationname=="WELDER" | occupationname=="WELDING" ///
| occupationname=="WELDING WORKSHOP") 

*Spinners, Weavers, Knitters, Dyers
replace occup_sector=23 if year==2010 & (occupationname=="HANDLOOM" | occupationname=="HANDLOOM CO-OPRATIVE SOCIETY" | occupationname=="HANDLOOMING" ///
| occupationname=="HANLOOM"  )

*Tailors, dress makers, sewers
replace occup_sector=24 if year==2010 & (occupationname=="TAILOR" | occupationname=="TAILORING" | occupationname=="TAILORING COOLIE" ///
| occupationname=="TYLERING" | occupationname=="TEXTILE SHOP WORK")

*Clay workers, potters, sculptors, painters
replace occup_sector=25 if year==2010 & (occupationname=="CLAY TOY MAKING" | occupationname=="CLAY TOY" | occupationname=="CLAY STOVE" ///
| occupationname=="CLAY TOY SALE" | occupationname=="POT MAKING")

*Electrical workers
replace occup_sector=26 if year==2010 & (occupationname=="ELECTRECIAN" | occupationname=="ELECTRICIAN")

*Mechanic and machinery fitters/assemblers (except electrical)
replace occup_sector=27 if year==2010 & (occupationname=="MECHANIC" | occupationname=="MECHANIC WORK" | occupationname=="MOTOR WORKSHOP" | occupationname=="AC MECHANIC" ///
| occupationname=="TV MECHANIC" |  occupationname=="FITTER IN CHENNAI")

*Transport Equipment operators
replace occup_sector=28 if year==2010 & (occupationname=="BULLACAT" | occupationname=="BULLCART" | occupationname=="BULLOCART" | occupationname=="BULLOCART DRIVER" ///
| occupationname=="BULLOCCART" | occupationname=="BULLOCKCART" | occupationname=="TRACKTER OWN" | occupationname=="TRACTOR" | occupationname=="TRACTOR driver" )

*Stationery Engines and related equipment operators
replace occup_sector=29 if year==2010 & (occupationname=="WATER TANK OPERATOR")

*Material handling and related equipment operators (loaders/unloaders)
replace occup_sector=30 if year==2010 & (occupationname=="LOAD MAN" | occupationname=="LOADMAN" | occupationname=="LOADMAN IN PVT COMPANY")


*Other Industrial workers (glass, mining, chemicals, printing, welders)
*replace occup_sector=31 if year==2010 & ()


*Other craftsworkers (Carpenters, tiles workers, Paper product makers)
replace occup_sector=32 if year==2010 & ( occupationname=="CARPENTAR" | occupationname=="CARPENTER" | occupationname=="CORPENTOR")

*Other labour
replace occup_sector=33 if year==2010 & (occupationname=="LABOUR" | occupationname=="PRIVATE COMPANY" | occupationname=="PRIVATE COMPANY WORK"  ///     Où mettre les "pvt company workers" ??
_| occupationname=="PRIVATE COMPANY WORKER" | occupationname=="PRIVATE COMPONY WORK" | occupationname=="PVT CO." | occupationname=="PVT COMPANY" ///
||occupationname=="PVT SECURITY" | occupationname=="PVT. CO" | occupationname=="PVT.CO" | occupationname=="PVT.CO." | occupationname=="PVT.CO.COOLIE" ///
 | occupationname=="PVT.COMPANY" | occupationname=="SECURITY" | occupationname=="WASHERMAN" | occupationname=="WATCHMAN" | occupationname=="WATERMAN IN BSNL" ///
 | occupationname=="WORK IN GULF" | occupationname=="WORKING IN PVT COMPANY" | occupationname=="WORKING IN WINE SHOP" | occupationname=="COOLIE" | occupationname=="HARTICULTURE WORK" ///
 | occupationname=="TENT HOUSE WORK")

*Teachers
replace occup_sector=41 if year==2010 & (occupationname=="PVT.SCHOOL TEACHER" | occupationname=="TRAINING TEACHER")

*Architects, Engineers, ...
replace occup_sector=42 if year==2010 & (occupationname=="ENGINEER" | occupationname=="ENGINEER BUILDING CONSTRUCTION")

*Engineering technicians
replace occup_sector=43 if year==2010 & ( occupationname=="SERVICE ENG LG")

*Scientific, medical and technical persons
replace occup_sector=44 if year==2010 & ( occupationname=="GOVT.HOSPITAL")

*Nursing and health technicians
replace occup_sector=45 if year==2010 & (occupationname=="ANGANVADI STAFF (NURSERY SCHOOL kindofwork)" | occupationname=="ANGANWADI HELPER (NURSERY SCHOOL kindofwork)" ///
| occupationname=="ANGANWADI SERVANT  (NURSERY SCHOOL kindofwork)")

*Economists, Accountants, auditors
replace occup_sector=46 if year==2010 & (occupationname=="ACCOUNTS OFFICER")


*Jurists
*replace occup_sector=47 if year==2010 & ()

*Administrative and executive officials government and local bodies
replace occup_sector=51 if year==2010 & ( occupationname=="VILLAGE ASSISTANED" | occupationname=="VILLAGE ASST." | occupationname=="GOVT SERVANT" | occupationname=="GOVT.DRIVER" ///
|  occupationname=="GOVT.kindofwork" |  occupationname=="WORKING IN JEWELRY SHOP" | occupationname=="�UDITOR ASSISSTEND" | occupationname=="�UDITOR ASSISSTEND" )

*Working proprietors, directors, managers in mining, construction, manufacturing
*replace occup_sector=52 if year==2010 & ()

*Independent labour contractors
replace occup_sector=61 if year==2010 & (occupationname=="SUGARCANE MAISTHRI" | occupationname=="MAISTHRI" | occupationname=="CHAMBER MAISTRY" /// 
| occupationname=="CONSTRUCTION MAISTRY" )

*Clerical and other supervisors
replace occup_sector=71 if year==2010 & (occupationname=="SUPERVISOR IN PVT COMPANY")

*Other clerical workers
replace occup_sector=72 if year==2010 & (occupationname=="BANK CLERK" | occupationname=="LIC AGENT (INSURANCE)" | occupationname=="POST OFFICE CLERK" ///
| occupationname=="CO-OP BANK" | occupationname=="AMN ASSISTANT (ARMY WORK)" | occupationname=="COOPERATIVE BANK WORKER")

*Transport conductors and guards
replace occup_sector=73 if year==2010 & (occupationname=="BUS CONDUCTOR" | occupationname=="CONDUCTOR BUS" | occupationname=="GOVERNMENT DRVER" ///
| occupationname=="LORRY DRIVER")

*Shop keepers (wholesale and retail)
replace occup_sector=81 if year==2010 & (occupationname=="CAVERING JEWEL BUSINES" | occupationname=="CAVERING JEWELS BUSINESS" | occupationname=="FANCY STORE" ///
| occupationname=="FISH SELLING" | occupationname=="FISH VENDOR" | occupationname=="FLLOWER SHOP" | occupationname=="FRUIT BUSINESS" | occupationname=="FRUIT SELLING" ///
| occupationname=="FRUIT SHOP" | occupationname=="GENERAL STORE" | occupationname=="GROCERY SHOP" | occupationname=="GROSORY SHOP" ///
| occupationname=="GROSSARY SHOP" | occupationname=="IDLY SHOP" | occupationname=="JUTE BAG BUSINES" | occupationname=="JUTE BAG BUSINESS" ///
| occupationname=="JUTEBAG BUSINESS" | occupationname=="PETTI SHOP" | occupationname=="PETTY SHOP" | occupationname=="TEA SHOP" | occupationname=="TEA STALL" ///
| occupationname=="TELEPHONE BOOTH" | occupationname=="VEGETABLE SELLING" | occupationname=="WASTE PAPER BUSINESS" | occupationname=="WASTER PAPER BUSINESS" ///
| occupationname=="TAMERIEND SEED BUSINESS" | occupationname=="COTTON BUSINESS" | occupationname=="CRISTAL BUSINESS" | occupationname=="CROPS BUSINESS" ///
| occupationname=="CYCLE STORE" | occupationname=="PRIVATE  SHOP" | occupationname=="STRAW BUSINESS"  ///
| occupationname=="NATURAL MANURE BUSINESS (fertilisant business)" |  occupationname=="CHAIR BUSINESS" )

*Agri equipment sellers
*replace occup_sector=82 if year==2010 & ()

*Rent shop/ activities
*replace occup_sector=83 if year==2010 & ()

*Salesmen, shop assistants and related workers
replace occup_sector=84 if year==2010 & (occupationname=="BANK WATCHMAN" |  occupationname=="COLLIE IN CLOTH STORE" |  occupationname=="COOLIE IN FANCY STORE" | occupationname=="COOLIE IIN HOTEL" ///
| occupationname=="COOLIE IN CENIMA THEATRE" |  occupationname=="COOLIE IN SWEET STALL" |  occupationname=="FLLOWER SHOP COOLIE" ///
|  occupationname=="FLOOWER SHOP WORK" |  occupationname=="SHOP WORK" |  occupationname=="SHOP WORKER" | occupationname=="WORKING IN WINE SHOP" )

*Technical salesmen & commercial travellers
*replace occup_sector=85 if year==2010 & ()

*Money lenders and pawn brokers
*replace occup_sector=86 if year==2010 & ()

*Hotel and restaurant keepers
*replace occup_sector=91 if year==2010 & (occupationname=="HOTEL BUSINESS" | occupationname=="HOTEL") //vérifier si SE 

*Cooks, waiters
replace occup_sector=92 if year==2010 & (occupationname=="COOK" | occupationname=="HELPER -COOKING" | occupationname=="HOSTEL COOK" |  occupationname=="COOLIE IN HOTEL" ///
|  occupationname=="HOTEL WORK" |  occupationname=="HOTEL WORKER" |  occupationname=="WORKING IN COOLDRINKS SHOP" |  occupationname=="WORKING IN JEWELLERY SHOP" |  occupationname=="WORKING IN JEWELRY SHOP")

*Building caretakers, sweepers, cleaners
replace occup_sector=93 if year==2010 & (occupationname=="BUS CLEANER" |  occupationname=="CLEANER IN TRACTOR" )

*Maids and house keeping service workers
replace occup_sector=94 if year==2010 & (occupationname=="HOUSE KEEPING"  )

*Hair dressers, barbers...
*replace occup_sector=95 if year==2010 & ()

*Private transportation
replace occup_sector=96 if year==2010 & (occupationname=="CAR DRIVER" | occupationname=="TEMPO DRIVER" | occupationname=="TEMPO TRAVEL OWNER" | occupationname=="VAN DRIVER" ///
| occupationname=="DRIVER" | occupationname=="DRIVING")

*Other service workers
replace occup_sector=97 if year==2010 & ( occupationname=="IRNING CLOTHES" | occupationname=="REAL ESTATE" | occupationname=="SHOE MAKER" ///
| occupationname=="SHOE MAKING" | occupationname=="INLAND FISHING" | occupationname=="TOOK FISH POND LEASE" ) ///  ????

*Performing artists
replace occup_sector=101 if year==2010 & (occupationname=="BAND PLAYER" | occupationname=="TEMPLE DRUMS PLAYING" | occupationname=="THAPPU ADITHAL (DRUMER)")

*Astrologers
replace occup_sector=102 if year==2010 & (occupationname=="JOSIYAM (CLAIVOYANT)")	

*Public works/ NREGA
replace occup_sector=111 if year==2010 & (occupationname=="NREGA" | occupationname=="NREGS" | occupationname=="NRGEA")	



********* Group
mdesc occup_sector
list occupationname if occup_sector==., clean
replace occup_sector=999 if occup_sector==.
	
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
replace occup_sector2=999 if occup_sector==999 

label define sector 1 "Cultivators" 2 "Agricultural and plantation labourers" 3 "Production workers, transport equipment operators and labourers" ///
4 "Most qualified workers" 5 "Administrative, executive and managerial workers" 6 "Labour contractors" ///
7 "Clerical workers" 8 "Merchents and sellers" 9 "Service workers" 10 "Artists and astrologers" ///
11 "NREGA" 999"Pension+retirement"
label values occup_sector2 sector 	

mdesc occup_sector2
tab occup_sector2, m









********** occupcode2010

*culti
gen occupcode2010=1 if kindofwork==1

*agri coolie
replace occupcode2010=2 if kindofwork==3 |occupationname=="AGRI COOLIE"

*non-agri coolie (industry, service) ou non-agri casual
replace occupcode2010=3 if occupationname== "CENTRING WORK (CONSTRUCTION)" ///
| occupationname=="CONSTRUCTION WROK"  ///
 | occupationname=="LORRY DRIVER"  ///
 | occupationname=="PRIVATE COMPANY WORK"  ///
 | occupationname=="BRICK WORK" | occupationname=="CHAMBER" | occupationname=="CHAMBER WORK"| occupationname=="CHAMEBER WORK" ///
 | occupationname=="CONSTRUCTION"  | occupationname=="CONSTRUCTION WORK"| occupationname=="CONSTRUCTION WORKER COOLIE" ///
 | occupationname=="COOLIE" | occupationname=="COOLIE IN KERALA" | occupationname=="LABOUR" | occupationname=="LOAD MAN" ///
 | occupationname=="CLEANER IN TRACTOR" | occupationname=="LOADMAN"| occupationname=="LOADMAN IN PVT COMPANY" ///
 | occupationname=="PVT.CO.COOLIE" | occupationname=="ROAD WORK" | occupationname=="SULAI VELAI (CHAMBER)"| occupationname=="SUVELAI (CHAMBER)" ///
 | occupationname=="TAILORING COOLIE"| occupationname=="BULLOCART DRIVER" ///
 |occupationname=="BUS CLEANER" | occupationname=="HELPER -COOKING" ///
 | occupationname=="HOTEL WORK" | occupationname=="HOTEL WORKER" | occupationname=="TEMPO DRIVER" ///
 | occupationname=="COOLIE IIN HOTEL"| occupationname=="COOLIE IN CENIMA THEATRE" | occupationname=="COOLIE IN HOTEL" ///
 | occupationname=="TENT HOUSE WORK"  
* | occupationname=="COOLIE IN FANCY STORE" ///
* | occupationname=="COLLIE IN CLOTH STORE" ///
* | occupationname=="COOLIE IN FANCY STORE" ///
* | occupationname=="COOLIE IN SWEET STALL" 
* | occupationname=="PRIVATE COMPANY WORK" & _23_1_g_work_type!=1 ///
 
* regular non-qualified (clerical, industry, shops)
replace occupcode2010=4 if occupationname=="BANK CLERK" | occupationname=="BANK WATCHMAN" ///
| occupationname=="BUS CONDUCTOR" | occupationname=="GOVT.DRIVER" | occupationname=="GOVERNMENT DRVER" ///
| occupationname== "GOVT SERVANT" ///
| occupationname=="WATCHMAN" | occupationname=="VAN DRIVER" | occupationname=="POST MAN Rtd" |occupationname=="PVT SECURITY" ///
| occupationname=="POST OFFICE CLERK"| occupationname=="VILLAGE ASSISTANED" | occupationname=="VILLAGE ASST."  ///
| occupationname=="WATER TANK OPERATOR" | occupationname=="PAINTER" | occupationname=="MASON" ///
| occupationname=="CARPENTAR" | occupationname=="CARPENTER" | occupationname=="CORPENTOR" ///
| occupationname=="FITTER IN CHENNAI" | occupationname=="FLOUR MILL" ///
| occupationname=="GROSORY SHOP" | occupationname=="WORKING IN COOLDRINKS SHOP" ///
| occupationname=="WORKING IN JEWELLERY SHOP" | occupationname=="WORKING IN JEWELRY SHOP" ///
| occupationname=="WORKING IN WINE SHOP" | occupationname=="FLLOWER SHOP COOLIE"| occupationname=="FLOOWER SHOP WORK" ///
| occupationname=="TEXTILE SHOP WORK" | occupationname=="DRIVER"| occupationname=="DRIVING"  
*| occupationname=="CAR DRIVER" | occupationname=="SECURITY"

* regular qualified  
replace occupcode2010=5 if occupationname=="AMN ASSISTANT (ARMY WORK)"| occupationname=="ANGANVADI STAFF (NURSERY SCHOOL kindofwork)" ///
| occupationname=="ANGANWADI HELPER (NURSERY SCHOOL kindofwork)" | occupationname=="ANGANWADI SERVANT  (NURSERY SCHOOL kindofwork)" ///
| occupationname=="EID PARRY (sugar mill factory)" | occupationname=="ENGINEER" ///
| occupationname=="PRIVATE COMPANY WORK" & occupationname=="SERVICE ENG LG" ///
| occupationname=="TRAINING TEACHER" | occupationname=="�UDITOR ASSISSTEND"  ///
| occupationname=="PVT CO." | occupationname=="PVT.COMPANY" | occupationname=="WORKING IN PVT COMPANY" | occupationname== "PRIVATE COMPANY WORKER" ///
| occupationname== "PVT COMPANY"  | occupationname== "PVT.CO" ///
| occupationname=="COOPERATIVE BANK WORKER" | occupationname=="GOVT.kindofwork" | occupationname=="LIC AGENT (INSURANCE)" ///
| occupationname=="MECHANIC" | occupationname=="MECHANIC WORK" ///
| occupationname=="ELECTRECIAN" | occupationname=="ELECTRICIAN" 
*| occupationname=="ENGINEER BUILDING CONSTRUCTION" | occupationname=="ACCOUNTS OFFICER" ///
*| occupationname=="PVT.SCHOOL TEACHER" | occupationname=="PVT.SCHOOL TEACHER" ///
*| occupationname=="SUPERVISOR IN PVT COMPANY" | occupationname=="GOVT.HOSPITAL" ///
*| occupationname=="SERVICE ENG LG"
*| occupationname=="PRIVATE COMPANY WORK" & _23_1_g_work_type==1 | occupationname=="SERVICE ENG LG" ///
 
 
*SE
replace occupcode2010=6 if kindofwork==8| kindofwork==5 |occupationname=="MOTOR WORKSHOP" ///
| occupationname=="CHAMBER MAISTRY" | occupationname=="CONSTRUCTION MAISTRY" |occupationname=="CLAY TOY MAKING" 

* recode from SE to regular non qualified (welders)
replace occupcode2010=4 if occupcode2010==6 & occupationname=="WELDER"|occupcode2010==6 & occupationname=="WELDING" |occupcode2010==6 & occupationname=="WELDING WORKSHOP" 
replace occupcode2010=4 if occupcode2010==6 & occupationname=="CONDUCTOR BUS"|occupcode2010==6 & occupationname=="WELDING" |occupcode2010==6 & occupationname=="WELDING WORKSHOP"

* recode from SE to regular qualified (mechanics)
replace occupcode2010=5 if occupcode2010==6 & occupationname=="AC MECHANIC" |occupcode2010==6 & occupationname=="MOTOR WORKSHOP" |occupcode2010==6 & occupationname=="TV MECHANIC"

*NREGA
replace occupcode2010=7 if kindofwork==4






********** same occupcode2 for 2010 & 2016 
label define occupcode 1 "Agri self-employed" 2 "Agri casual workers" 3 "Non-agri casual workers" 4 "Non-agri regular non-qualified workers" ///
5 "Non-agri regular qualified workers" 6 "Non-agri self-employed" 7 "Public employment scheme workers (NREGA)"

label values occupcode2010 occupcode



********** Check no. 1
replace occupcode2010=3 if occupcode2010==. & kindofwork==2
replace occupcode2010=4 if occupcode2010==. & kindofwork==6 & education==9
replace occupcode2010=4 if occupcode2010==. & kindofwork==6 & education<3
replace occupcode2010=0 if kindofwork==9
replace occupcode2010=5 if occupcode2010==. & kindofwork==6 & education>=3 & education!=9 & education!=.


********** Occupcode2
gen occupcode2=occupcode2010 if year==2010
label values occupcode2 occupcode

replace occupcode2=5 if occupcode2==. & occupationname=="Advocate"
replace occupcode2=4 if occupcode2==. & occupationname=="Bus driver"
replace occupcode2=4 if occupcode2==. & occupationname=="Office assistant in Co-operative bank"
replace occupcode2=4 if occupcode2==. & occupationname=="Water company private"
replace occupcode2=4 if occupcode2==. & occupationname=="Accountant in ration (gov kindofwork) no contract yet"
replace occupcode2=4 if occupcode2==. & occupationname=="Secretary(primary agriculture cooperative bank)"
replace occupcode2=5 if occupcode2==. & occupationname=="PENSION FOR RETAIRED POST MAN"
replace occupcode2=5 if occupcode2==. & occupationname=="PENSION FOR RETAIRED TEACHER"
replace occupcode2=5 if occupcode2==. & occupationname=="PENTIONER"
replace occupcode2=5 if occupcode2==. & occupationname=="TEACHER Rtd"
replace occupcode2=4 if occupcode2==. & HHID2010=="PSOR384" & INDID=="F3" & year==2010





********** Construction sector dummies
/*
Define construction sector dummies (sector 22,26,31,32)
 */
gen construction_coolie=( occupationname== "CENTRING WORK (CONSTRUCTION)"| occupationname=="CONSTRUCTION WROK"  ///
 | occupationname=="BRICK WORK" | occupationname=="CHAMBER" | occupationname=="CHAMBER WORK"| occupationname=="CHAMEBER WORK" ///
 | occupationname=="CONSTRUCTION"  | occupationname=="CONSTRUCTION WORK"| occupationname=="CONSTRUCTION WORKER COOLIE" ///
 | occupationname=="ROAD WORK" | occupationname=="SULAI VELAI (CHAMBER)"| occupationname=="SUVELAI (CHAMBER)") if occupcode2010==3
  
gen construction_regular = (occupationname=="PAINTER" | occupationname=="MASON" ///
| occupationname=="CARPENTAR" | occupationname=="CARPENTER" | occupationname=="CORPENTOR") if occupcode2010==4


gen construction_qualified = ( occupationname=="ELECTRECIAN" | occupationname=="ELECTRICIAN" ///
| occupationname=="CHAMBER MAISTRY" | occupationname=="CONSTRUCTION MAISTRY" | occupationname=="REAL ESTATE" ///
| occupationname=="CHAMBER OWN") if occupcode2010==5| occupcode2010==6

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



********** Labelisation of key variables of occupations
*label PROFESSION of workers (occup_sector)
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

*label Occupations of workers
rename occupcode2 occupation2
label var occupation2 "Occupations of workers"
		

********** Rename var
rename occupation1 profession
rename occupation2 occupation
rename occup_sector2 sector

save"_tempRUME-occup1", replace
****************************************
* END






****************************************
* Main occupation
***************************************
use"_tempRUME-occup1", clear
/*
Main occupation is define as the most income generating occupation.
*/

********** Indiv
bysort HHID2010 INDID2010: egen max_income=max(annualincome)
gen dummymainoccupation=0
replace dummymainoccupation=1 if max_income==annualincome

*** Check no duplicates
bysort HHID2010 INDID2010: egen test=sum(dummymainoccupation)
ta test
replace dummymainoccupation=0 if HHID2010=="ANDMTP325" & INDID=="F1" & occupationname!="NATURAL MANURE BUSINESS (fertilisant business)"
replace dummymainoccupation=0 if HHID2010=="PSEP80" & INDID=="F2" & occupationname!="AGRICULTURE"
replace dummymainoccupation=0 if HHID2010=="PSKOR200" & INDID=="F1" & occupationname!="MAISTHRI"
replace dummymainoccupation=0 if HHID2010=="PSKU128" & INDID=="F1" & occupationname!="BULLOCART"
replace dummymainoccupation=0 if HHID2010=="PSNAT347" & INDID=="F1" & occupationname!="SUGARCANE CUTTING"
replace dummymainoccupation=0 if HHID2010=="PSSEM93" & INDID=="F2" & occupationname!="FANCY STORE"
replace dummymainoccupation=0 if HHID2010=="RAEP71" & INDID=="F1" & occupationname!="VILLAGE ASSISTANED"
replace dummymainoccupation=0 if HHID2010=="RANAT337" & INDID=="F1" & occupationname!="AGRICULTURE"
replace dummymainoccupation=0 if HHID2010=="SIKU152" & INDID=="F1" & occupationname!="TOOK FISH POND LEASE"
replace dummymainoccupation=0 if HHID2010=="SIMPO5" & INDID=="F1" & occupationname!="VEGETABLE SELLING"
replace dummymainoccupation=0 if HHID2010=="SINAT330" & INDID=="F2" & occupationname!="AGRICULTURE COOLIE"
replace dummymainoccupation=0 if HHID2010=="VENNAT352" & INDID=="F1" & occupationname!="AGRICULTURE"
replace dummymainoccupation=0 if HHID2010=="VENOR395" & INDID=="F1" & occupationname!="LORRY DRIVER"
replace dummymainoccupation=0 if HHID2010=="VENOR396" & INDID=="F4" & occupationname!="IRNING CLOTHES"
drop test

*** Gen var
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
bysort HHID2010 INDID2010: egen mainocc_`x'=max(temp_mainocc_`x')
}

*More tricky for occupname:
encode temp_mainocc_occupationname, gen(mainoccnamenum)
bysort HHID2010 INDID2010: egen _mainocc_occupationname=max(mainoccnamenum)
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
bysort HHID2010 INDID: egen annualincome_indiv=sum(annualincome)
bysort HHID2010 INDID: egen nboccupation_indiv=sum(1)


********** Clean
drop max_income temp_mainocc_kindofwork temp_mainocc_profession temp_mainocc_occupation temp_mainocc_sector temp_mainocc_annualincome temp_mainocc_occupationname mainoccnamenum _mainocc_occupationname occupcode2010

rename dummymainoccupation dummymainoccupation_indiv


drop education

order HHID2010 INDID2010 year age occupationid occupationname kindofwork annualincome profession sector kindofwork occupation construction_coolie construction_regular construction_qualified dummymainoccupation_indiv mainocc_kindofwork_indiv mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv

save "_tempRUME-occup2", replace
****************************************
* END













****************************************
* Add all
***************************************
use"_tempRUME-occup2", clear


********** Add all
merge m:1 HHID2010 INDID2010 using "$data", keepusing(name sex relationshiptohead village jatis dummyworkedpastyear livinghome)
drop _merge


order name age sex relationshiptohead village jatis dummyworkedpastyear livinghome, after(INDID2010)


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


save "_tempRUME-occup3", replace
****************************************
* END









****************************************
* Indiv + HH level
***************************************
use"_tempRUME-occup3", clear

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

bysort HHID2010 INDID2010: egen incomeagri_indiv=sum(incomeagri)
bysort HHID2010 INDID2010: egen incomenonagri_indiv=sum(incomenonagri)

bysort HHID2010: egen incomeagri_HH=sum(incomeagri)
bysort HHID2010: egen incomenonagri_HH=sum(incomenonagri)
bysort HHID2010: egen annualincome_HH=sum(annualincome)

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
bysort HHID2010 INDID2010: egen inc`x'_indiv=sum(inc`x')
bysort HHID2010: egen inc`x'_HH=sum(inc`x')
}

foreach x in agrise agricasual nonagricasual nonagriregnonquali nonagriregquali nonagrise nrega {
gen shareinc`x'_indiv=inc`x'_indiv/annualincome_indiv
gen shareinc`x'_HH=inc`x'_HH/annualincome_HH
}


********** Indiv level
preserve
keep HHID2010 INDID2010 dummyworkedpastyear mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_annualincome_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv working_pop incomeagri_indiv incomenonagri_indiv shareincomeagri_indiv shareincomenonagri_indiv incagrise_indiv incagricasual_indiv incnonagricasual_indiv incnonagriregnonquali_indiv incnonagriregquali_indiv incnonagrise_indiv incnrega_indiv shareincagrise_indiv shareincagricasual_indiv shareincnonagricasual_indiv shareincnonagriregnonquali_indiv shareincnonagriregquali_indiv shareincnonagrise_indiv shareincnrega_indiv   
duplicates drop
order HHID2010 INDID2010 dummyworkedpastyear working_pop
duplicates report HHID2010 INDID2010
duplicates list HHID2010 INDID2010
drop if HHID2010=="VENNAT350" & INDID2010=="F1" & working_pop==2
save"RUME-occup_indiv", replace
restore

********** HH level
keep HHID2010 INDID2010 dummyworkedpastyear working_pop livinghome incomeagri_HH incomenonagri_HH annualincome_HH shareincomeagri_HH shareincomenonagri_HH incagrise_HH incagricasual_HH incnonagricasual_HH incnonagriregnonquali_HH incnonagriregquali_HH incnonagrise_HH incnrega_HH shareincagrise_HH shareincagricasual_HH shareincnonagricasual_HH shareincnonagriregnonquali_HH shareincnonagriregquali_HH shareincnonagrise_HH shareincnrega_HH  
duplicates drop
drop if livinghome==0
*Nb workers
fre working_pop
gen nonworker=1 if working_pop==1
gen worker=1 if working_pop==2 | working_pop==3
bysort HHID2010: egen nbworker_HH=sum(worker)
bysort HHID2010: egen nbnonworker_HH=sum(nonworker)

drop INDID2010 dummyworkedpastyear working_pop nonworker worker livinghome
duplicates drop
save"RUME-occup_HH", replace
****************************************
* END
