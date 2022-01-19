cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
September 30, 2021
-----
TITLE: RUME occupation panel

-------------------------
*/



****************************************
* INITIALIZATION
****************************************

global directory = "C:\Users\Arnaud\Documents\_Thesis\_DATA\RUME\"
global git ="C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"
cd "$directory"
****************************************
* END









****************************************
* SJ
****************************************
import delimited "$directory\RUME-salariedjob1.csv", delimiter(";") clear 
rename codefamily HHID2010
rename v2 INDID
rename v5 occupationname2
rename v3 occupationlocation
rename v4 jobdistance
rename v7 jobcaste
rename v8 jobrelation
rename v9 worktype
rename v10 fulltimejob
rename v11 wagetype

tab v6
drop v6

sort INDID HHID2010
drop if INDID==""

save"RUME-salariedjob1.dta", replace


import delimited "$directory\RUME-salariedjob2.csv", delimiter(";") clear 
rename codefamily HHID2010
rename idmember INDID
rename v3 daysworked
rename v4 salaryreceived
rename v5 pension
rename v6 bonus
rename v7 insurance
rename v8 duration
rename v9 advance
rename v10 advancebalance
rename v11 advanceamount
rename v12 getjob
rename v13 know

drop if INDID==""

save"RUME-salariedjob2.dta", replace







****************************************
* RUME occupations
****************************************
use"RUME-occupations.dta", clear

drop INDID
rename code_id_mb INDID
rename occupation_code2 occupationtype
rename ocupationname occupationname
fre occupationtype
label define occupationtype ///
1"Agriculture" ///
2"Coolie" ///
3"Agri Coolie" ///
4"NREGS" ///
5"Investment" ///
6"Employee" ///
7"Service" ///
8"Self employment" ///
9"Pension" ///
10"No Occupation" ///
66"Irrelevant" ///
77"Other" ///
88"Don't know" ///
99"No response"
label values occupationtype occupationtype
fre occupationtype

gen year=2010

rename INDID INDID2010
merge m:1 HHID2010 INDID2010 using "RUME-HH_v6.dta",keepusing(age education)
drop if _merge==2
drop _merge

/*
drop if occupationtype==10
merge m:m HHID2010 INDID using "RUME-salariedjob1.dta"
sort occupationname
sort _merge
keep if _merge==3
drop _merge

duplicates tag HHID2010 INDID occupationname occupationtype annualincome stopworking, gen(tag)
tab tag
sort tag HHID2010 INDID
*/


********** Panel
**********************************************
**  Create 'occup_sector' variable for 2010 **			!! Pension and no occup not assigned to occup-sector (n=10) !!
**********************************************


drop if occupationtype==10
sort occupationtype HHID2010 INDID2010


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
/*
	*Other Industrial workers (glass, mining, chemicals, printing, welders)
replace occup_sector=31 if year==2010 & ()
*/
*	Other craftsworkers (Carpenters, tiles workers, Paper product makers)
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
replace occup_sector=45 if year==2010 & (occupationname=="ANGANVADI STAFF (NURSERY SCHOOL JOB)" | occupationname=="ANGANWADI HELPER (NURSERY SCHOOL JOB)" ///
| occupationname=="ANGANWADI SERVANT  (NURSERY SCHOOL JOB)")

	*Economists, Accountants, auditors
replace occup_sector=46 if year==2010 & (occupationname=="ACCOUNTS OFFICER")
/*
	*Jurists
replace occup_sector=47 if year==2010 & ()
*/
	*Administrative and executive officials government and local bodies
replace occup_sector=51 if year==2010 & ( occupationname=="VILLAGE ASSISTANED" | occupationname=="VILLAGE ASST." | occupationname=="GOVT SERVANT" | occupationname=="GOVT.DRIVER" ///
|  occupationname=="GOVT.JOB" |  occupationname=="WORKING IN JEWELRY SHOP" | occupationname=="�UDITOR ASSISSTEND" | occupationname=="�UDITOR ASSISSTEND" )
/*
	*Working proprietors, directors, managers in mining, construction, manufacturing
replace occup_sector=52 if year==2010 & ()
*/
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
/*
	*Agri equipment sellers
replace occup_sector=82 if year==2010 & ()

	*Rent shop/ activities
replace occup_sector=83 if year==2010 & ()
*/
	*Salesmen, shop assistants and related workers
replace occup_sector=84 if year==2010 & (occupationname=="BANK WATCHMAN" |  occupationname=="COLLIE IN CLOTH STORE" |  occupationname=="COOLIE IN FANCY STORE" | occupationname=="COOLIE IIN HOTEL" ///
| occupationname=="COOLIE IN CENIMA THEATRE" |  occupationname=="COOLIE IN SWEET STALL" |  occupationname=="FLLOWER SHOP COOLIE" ///
|  occupationname=="FLOOWER SHOP WORK" |  occupationname=="SHOP WORK" |  occupationname=="SHOP WORKER" | occupationname=="WORKING IN WINE SHOP" )
/*
	*Technical salesmen & commercial travellers
replace occup_sector=85 if year==2010 & ()

	*Money lenders and pawn brokers
replace occup_sector=86 if year==2010 & ()
*/
	*Hotel and restaurant keepers
replace occup_sector=91 if year==2010 & (occupationname=="HOTEL BUSINESS" | occupationname=="HOTEL") //vérifier si SE 

	*Cooks, waiters
replace occup_sector=92 if year==2010 & (occupationname=="COOK" | occupationname=="HELPER -COOKING" | occupationname=="HOSTEL COOK" |  occupationname=="COOLIE IN HOTEL" ///
|  occupationname=="HOTEL WORK" |  occupationname=="HOTEL WORKER" |  occupationname=="WORKING IN COOLDRINKS SHOP" |  occupationname=="WORKING IN JEWELLERY SHOP" |  occupationname=="WORKING IN JEWELRY SHOP")

	*Building caretakers, sweepers, cleaners
replace occup_sector=93 if year==2010 & (occupationname=="BUS CLEANER" |  occupationname=="CLEANER IN TRACTOR" )

	*Maids and house keeping service workers
replace occup_sector=94 if year==2010 & (occupationname=="HOUSE KEEPING"  )
/*
	*Hair dressers, barbers...
replace occup_sector=95 if year==2010 & ()
*/
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

*** Sort
sort occupationtype








************************ define occupcode2010
	
/*occupationname_code2 ou occupationtype
1	Agriculture
2	Coolie
3	Agri Coolie
4	NREGS
5&8 S-E Investment
6	Employee
7	Service
9	Pension
10 no occup
*/	


*culti
gen occupcode2010=1 if occupationtype==1
*agri coolie
replace occupcode2010=2 if occupationtype==3 |occupationname=="AGRI COOLIE"

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
replace occupcode2010=5 if occupationname=="AMN ASSISTANT (ARMY WORK)"| occupationname=="ANGANVADI STAFF (NURSERY SCHOOL JOB)" ///
| occupationname=="ANGANWADI HELPER (NURSERY SCHOOL JOB)" | occupationname=="ANGANWADI SERVANT  (NURSERY SCHOOL JOB)" ///
| occupationname=="EID PARRY (sugar mill factory)" | occupationname=="ENGINEER" ///
| occupationname=="PRIVATE COMPANY WORK" & occupationname=="SERVICE ENG LG" ///
| occupationname=="TRAINING TEACHER" | occupationname=="�UDITOR ASSISSTEND"  ///
| occupationname=="PVT CO." | occupationname=="PVT.COMPANY" | occupationname=="WORKING IN PVT COMPANY" | occupationname== "PRIVATE COMPANY WORKER" ///
| occupationname== "PVT COMPANY"  | occupationname== "PVT.CO" ///
| occupationname=="COOPERATIVE BANK WORKER" | occupationname=="GOVT.JOB" | occupationname=="LIC AGENT (INSURANCE)" ///
| occupationname=="MECHANIC" | occupationname=="MECHANIC WORK" ///
| occupationname=="ELECTRECIAN" | occupationname=="ELECTRICIAN" 
*| occupationname=="ENGINEER BUILDING CONSTRUCTION" | occupationname=="ACCOUNTS OFFICER" ///
*| occupationname=="PVT.SCHOOL TEACHER" | occupationname=="PVT.SCHOOL TEACHER" ///
*| occupationname=="SUPERVISOR IN PVT COMPANY" | occupationname=="GOVT.HOSPITAL" ///
*| occupationname=="SERVICE ENG LG"
*| occupationname=="PRIVATE COMPANY WORK" & _23_1_g_work_type==1 | occupationname=="SERVICE ENG LG" ///
 
 
*SE
replace occupcode2010=6 if occupationtype==8| occupationtype==5 |occupationname=="MOTOR WORKSHOP" ///
| occupationname=="CHAMBER MAISTRY" | occupationname=="CONSTRUCTION MAISTRY" |occupationname=="CLAY TOY MAKING" 

* recode from SE to regular non qualified (welders)
replace occupcode2010=4 if occupcode2010==6 & occupationname=="WELDER"|occupcode2010==6 & occupationname=="WELDING" |occupcode2010==6 & occupationname=="WELDING WORKSHOP" 
replace occupcode2010=4 if occupcode2010==6 & occupationname=="CONDUCTOR BUS"|occupcode2010==6 & occupationname=="WELDING" |occupcode2010==6 & occupationname=="WELDING WORKSHOP"

* recode from SE to regular qualified (mechanics)
replace occupcode2010=5 if occupcode2010==6 & occupationname=="AC MECHANIC" |occupcode2010==6 & occupationname=="MOTOR WORKSHOP" |occupcode2010==6 & occupationname=="TV MECHANIC"


*NREGA
replace occupcode2010=7 if occupationtype==4



/*
preserve
keep if occupcode2010==.
drop if occupationtype==9
rename INDID2010 INDID
merge 1:m HHID2010 INDID using "RUME-salariedjob1.dta"
drop if _merge==2
drop _merge
order occupationname occupationtype occup_sector2 worktype fulltimejob
label define fulltimejob 1"Part time" 2"Full time", replace
label define worktype 1"Permanent" 2"Temporal" 3"Seasonal", replace
label values worktype worktype
label values fulltimejob fulltimejob
restore
*/


************************ same occupcode2 for 2010 & 2016 
 
label define occupcode 1 "Agri self-employed" 2 "Agri casual workers" 3 "Non-agri casual workers" 4 "Non-agri regular non-qualified workers" ///
5 "Non-agri regular qualified workers" 6 "Non-agri self-employed" 7 "Public employment scheme workers (NREGA)"

label values occupcode2010 occupcode



********** Verif 2
*reste=pension 
fre education
fre occupationtype
order occupationname occupationtype occupcode2010 education annualincome
sort occupcode2010 HHID2010 INDID2010

replace occupcode2010=3 if occupcode2010==. & occupationtype==2

replace occupcode2010=4 if occupcode2010==. & occupationtype==6 & education==9
replace occupcode2010=4 if occupcode2010==. & occupationtype==6 & education<3

replace occupcode2010=0 if occupationtype==9

replace occupcode2010=5 if occupcode2010==. & occupationtype==6 & education>=3 & education!=9 & education!=.




 
gen occupcode2=occupcode2010 if year==2010
label values occupcode2 occupcode


replace occupcode2=5 if occupcode2==. & occupationname=="Advocate"
replace occupcode2=4 if occupcode2==. & occupationname=="Bus driver"
replace occupcode2=4 if occupcode2==. & occupationname=="Office assistant in Co-operative bank"
replace occupcode2=4 if occupcode2==. & occupationname=="Water company private"
replace occupcode2=4 if occupcode2==. & occupationname=="Accountant in ration (gov job) no contract yet"
replace occupcode2=4 if occupcode2==. & occupationname=="Secretary(primary agriculture cooperative bank)"
replace occupcode2=5 if occupcode2==. & occupationname=="PENSION FOR RETAIRED POST MAN"
replace occupcode2=5 if occupcode2==. & occupationname=="PENSION FOR RETAIRED TEACHER"
replace occupcode2=5 if occupcode2==. & occupationname=="PENTIONER"
replace occupcode2=5 if occupcode2==. & occupationname=="TEACHER Rtd"
replace occupcode2=4 if occupcode2==. & HHID2010=="PSOR384" & INDID=="F3" & year==2010










************************ Define construction sector dummies (sector 22,26,31,32)
 
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
		


rename occupation1 profession
rename occupation2 occupation
rename occup_sector2 sector

save"RUME-occupations_v2.dta", replace
****************************************
* END








/*
****************************************
* Excel
****************************************
use"RUME-occupations_v2.dta", clear

keep occupationname occupationtype profession occupation occupa_unemployed occupa_unemployed_15_70 sector age

foreach x in *{
compress `x'
}

gen agetowork=.
replace agetowork=0 if age<=14 & age!=.
replace agetowork=0 if age>=71 & age!=.
replace agetowork=1 if age>14 & age<71 & age!=.

drop age


rename occupationtype kindofwork2010

drop if occupation==.

order kindofwork2010 occupationname profession occup_sector2 occupation occupa_unemployed occupa_unemployed_15_70 agetowork

duplicates drop occupationname kindofwork2010 profession occup_sector2 occupation occupa_unemployed occupa_unemployed_15_70 agetowork, force


export excel using "$git\Occupations\Occupations.xlsx", sheet("RUME") sheetmodify firstrow(variables)

gen year=2010
keep occupationname profession year

save"$git\Occupations\sector2010.dta", replace
****************************************
* END
