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

keep key indid indid2 name age sex edulevel caste classcompleted everattendedschool dummynewmb dummymainmigrant dummymainoccupation2 othermainoccupation2 mainoccupation
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
/*
preserve
duplicates drop occupationname kindofwork classcompleted10ormore everattendedschool agetowork, force
keep occupationname kindofwork everattendedschool classcompleted10ormore agetowork
gen profession=.
order kindofwork occupationname profession
export excel using "occupationslist.xlsx", sheet("Tracking1") sheetmodify firstrow(variables)
restore
*/


********** Let's go
replace occup_sector=11 if occupationname=="Agriculture"
replace occup_sector=11 if occupationname=="Agriculture"
replace occup_sector=11 if occupationname=="Agriculture activities in own land"
replace occup_sector=11 if occupationname=="Agriculture activities in own land"
replace occup_sector=11 if occupationname=="Agriculture activities in own land"
replace occup_sector=11 if occupationname=="Agriculture activities in own land (unpaid)"
replace occup_sector=11 if occupationname=="Agriculture activities on own land"
replace occup_sector=12 if occupationname=="Agriculture coolie"
replace occup_sector=12 if occupationname=="Agriculture coolie"
replace occup_sector=12 if occupationname=="Agriculture coolie"
replace occup_sector=22 if occupationname=="Brick kiln"
replace occup_sector=22 if occupationname=="Brick kiln"
replace occup_sector=22 if occupationname=="Brick kiln"
replace occup_sector=22 if occupationname=="Brick kiln work"
replace occup_sector=22 if occupationname=="Brick kiln work"
replace occup_sector=22 if occupationname=="Bricklin work"
replace occup_sector=22 if occupationname=="Centering work"
replace occup_sector=22 if occupationname=="Centering work for buildings"
replace occup_sector=22 if occupationname=="Construction supervisor"
replace occup_sector=22 if occupationname=="Construction work"
replace occup_sector=22 if occupationname=="Maison"
replace occup_sector=22 if occupationname=="Maison"
replace occup_sector=23 if occupationname=="Jacard looming (machine looming)"
replace occup_sector=23 if occupationname=="Jacard looming machine operator (weaving)"
replace occup_sector=26 if occupationname=="Technical assistance in electricity department"
replace occup_sector=27 if occupationname=="Assistant machine operator"
replace occup_sector=27 if occupationname=="Lathe machine operator"
replace occup_sector=27 if occupationname=="Machine operator"
replace occup_sector=27 if occupationname=="Mechanic"
replace occup_sector=27 if occupationname=="Mechanic in Renault Nissan chennai"
replace occup_sector=27 if occupationname=="Mechanical engineer, BHEL"
replace occup_sector=28 if occupationname=="Gas tanker driver"
replace occup_sector=28 if occupationname=="Lorry driver"
replace occup_sector=28 if occupationname=="Lorry driver"
replace occup_sector=30 if occupationname=="Load man"
replace occup_sector=31 if occupationname=="Marketing work"
replace occup_sector=31 if occupationname=="Programmer (CTS)"
replace occup_sector=31 if occupationname=="Tele caller (BPO)"
replace occup_sector=31 if occupationname=="Working in infotech solutions"
replace occup_sector=33 if occupationname=="Assistant in a film company"
replace occup_sector=33 if occupationname=="Helper"
replace occup_sector=33 if occupationname=="Maintenance"
replace occup_sector=33 if occupationname=="Own minidoor (travels)"
replace occup_sector=41 if occupationname=="Teacher"
replace occup_sector=42 if occupationname=="Bio medical engineer"
replace occup_sector=44 if occupationname=="Physiotherapist"
replace occup_sector=46 if occupationname=="Accountant"
replace occup_sector=46 if occupationname=="Chartered accountant"
replace occup_sector=51 if occupationname=="Administration work"
replace occup_sector=51 if occupationname=="Assit director"
replace occup_sector=51 if occupationname=="Military defense"
replace occup_sector=51 if occupationname=="Single window operator (cooperative bank)"
replace occup_sector=51 if occupationname=="Working as a agent in a marketing shop"
replace occup_sector=71 if occupationname=="Clerk"
replace occup_sector=71 if occupationname=="Supervisor"
replace occup_sector=71 if occupationname=="Supervisor in bhel"
replace occup_sector=73 if occupationname=="Bus driver (government bus)"
replace occup_sector=73 if occupationname=="Bus driver (govt. Bus)"
replace occup_sector=73 if occupationname=="Working in a bus company"
replace occup_sector=81 if occupationname=="Grocery shop owner"
replace occup_sector=81 if occupationname=="Unpaid worker in own grocery shop"
replace occup_sector=84 if occupationname=="Cloth shop"
replace occup_sector=84 if occupationname=="Working in a vegetable shop"
replace occup_sector=91 if occupationname=="Cashier in hotel"
replace occup_sector=91 if occupationname=="Hotel assistant (unpaid)"
replace occup_sector=91 if occupationname=="Restaurant worker"
replace occup_sector=91 if occupationname=="Running a hotel"
replace occup_sector=91 if occupationname=="Running canteen in hospital"
replace occup_sector=92 if occupationname=="Cooking master"
replace occup_sector=94 if occupationname=="Childcare worker (creche)"
replace occup_sector=94 if occupationname=="Church maid"
replace occup_sector=94 if occupationname=="House maid"
replace occup_sector=94 if occupationname=="Maid"
replace occup_sector=94 if occupationname=="Room boy (hotel paradise)"
replace occup_sector=96 if occupationname=="Driver"
replace occup_sector=111 if occupationname=="Nrega"



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
fre occup_sector2




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










************************ define occupcode2022 (replace occupcode)
gen occupcode2022=.

**"CULTIVATORS" 
replace occupcode2022=1 if occup_sector2==1


**"AGRI COOLIE" (in occup sector 2 but not self-employed)
replace occupcode2022=2 if occup_sector2==2 & kindofwork!=2


**"COOLIE NON-AGRI" (industry+service): employed, daily/seasonal/occasional job
* industry workers (sector 3) 
* coolies in shops	(sector 8)	
* coolies in service (sector 9)
replace occupcode2022=3 if ///
  occup_sector2==3 & kindofwork!=2 & salariedjobtype>=3 ///
| occup_sector2==8 & kindofwork!=2 & salariedjobtype>=3 ///
| occup_sector2==9 & kindofwork!=2 & salariedjobtype>=3



**"REGULAR NON-QUALIFIED NON-AGRI" (industry+service): employed, fixed/permanent jobs, less than 10std or more than 10std but no monthly wage (only piece rate or daily)	
* regular non qualified industry workers (sector 3): mostly in sector 22, 23= construction, handloom in thirupur)
* Clerical workers (sector 7)
* employed in shops (sector 8)		
* employed service workers (sector 9)
* qualified job but less than 10std (mid wife, assistant) (sector 4)
replace occupcode2022=4 if ///
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
replace occupcode2022=5 if ///
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
replace occupcode2022=6 if ///
  kindofwork==2 & occup_sector2==2 ///
| kindofwork==2 & occup_sector2==3 ///
| occup_sector2==6 ///
| kindofwork==2 & occup_sector2==8 ///
| kindofwork==2 & occup_sector2==9 ///
| occup_sector2==10


**"NREGA" (sector 11)
replace occupcode2022=7 if occup_sector2==11




********** Checkup Arnaud 1
sort occupcode2022 occup_sector2 occup_sector occupationname kindofwork annualincome

label define occupcode 1 "Agri self-employed" 2 "Agri casual workers" 3 "Non-agri casual workers" 4 "Non-agri regular non-qualified workers" ///
5 "Non-agri regular qualified workers" 6 "Non-agri self-employed" 7 "Public employment scheme workers (NREGA)"
label values occupcode2022 occupcode

*order occupcode2022 occup_sector2 occup_sector occupationname kindofwork annualincome

replace occupcode2022=5 if occup_sector2==7 & kindofwork==4 & classcompleted>=10 & salariedjobtype<3
replace occupcode2022=3 if occup_sector2==. & kindofwork==4 & salariedjobtype==3
replace occupcode2022=4 if occup_sector2==. & kindofwork==4 & salariedjobtype<3
replace occupcode2022=6 if occup_sector2==. & kindofwork==2

ta kindofwork occupationname if occupcode2022==.

replace occupcode2022=5 if occup_sector2==4 & classcompleted10ormore==1 & kindofwork==4

fre occupcode2022



************************ Define construction sector dummies (sector 22,26,31,32)
 
gen construction_coolie=(occupcode2022==3 & occup_sector==22|occupcode2022==3 & occup_sector==26|occupcode2022==3 & occup_sector==31) if year==2020

  
gen construction_regular=(occupcode2022==4 & occup_sector==22|occupcode2022==4 & occupationname=="Welder"|occupcode2022==4 & occupationname=="Welding labour"|occupcode2022==4 & occup_sector==32) if year==2020


gen construction_qualified = (occupcode2022==5 & occup_sector==26 & occupationname!="Tv mechanic self employed" ///
|occupcode2022==6 & occup_sector==61 & occupationname!="Mason maistry" ///
|occupcode2022==6 & occup_sector==61 & occupationname =="Brickling maistry" | occupcode2022==6 & occup_sector==61 & occupationname =="Maistry (contractor)" ///
|occupcode2022==6 & occup_sector==61 & occupationname == "Construction maistry" |occupcode2022==6 & occup_sector== 85 & occupationname == "Building contractor") if year==2020	



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

fre profession
fre occupation
fre sector


save"NEEMSIS-tracking_occupations_allwide_v3.dta", replace
****************************************
* END










****************************************
* Main occupations identification
****************************************
use"NEEMSIS-tracking_occupations_allwide_v3.dta", clear

fre indid2 indid
ta mainoccupation
fre dummymainoccupation2

gen dummymainoccupation=0
replace dummymainoccupation=1 if mainoccupation==occupationname & dummymainoccupation2==1
replace dummymainoccupation=1 if othermainoccupation==occupationname & dummymainoccupation2==0


********** Max hoursayear for non-ego individual
replace indid=999-_n if indid==.
ta indid
replace indid2=799-_n if indid2==.
ta indid2
destring hoursayear, replace

bysort key indid: egen maxhoursayear=max(hoursayear)
bysort key indid2: egen maxhoursayear2=max(hoursayear)
replace maxhoursayear=. if indid>100
replace maxhoursayear2=. if indid2>100

replace indid=. if indid>100
replace indid2=. if indid2>100

replace maxhoursayear=maxhoursayear2 if maxhoursayear==. & maxhoursayear2!=.
drop maxhoursayear2

gen dummymaxhoursayear=0
replace dummymaxhoursayear=1 if hoursayear==maxhoursayear

replace dummymainoccupation=1 if dummymainoccupation==0 & dummymaxhoursayear==1


********** Test if it is ok for all individuals
preserve
drop if indid==.
bysort key indid: egen summoc=sum(dummymainoccupation)
duplicates drop key indid, force
ta summoc, m
restore

preserve
drop if indid2==.
bysort key indid2: egen summoc=sum(dummymainoccupation)
duplicates drop key indid2, force
ta summoc, m
list key indid2 if summoc==2, clean noobs
restore




********** 2 individuals with 2 moc
/*
                                          key   indid2  
    uuid:1a9654cf-b3d9-4008-8f7c-0ec3a23eba84        1  
    uuid:2c9571e4-3d34-4a78-ad16-72725c7f6476        1  
*/

*br if key=="uuid:1a9654cf-b3d9-4008-8f7c-0ec3a23eba84" & indid2==1
replace dummymainoccupation=0 if occupationname=="Assistant in a film company" & key=="uuid:1a9654cf-b3d9-4008-8f7c-0ec3a23eba84" & indid2==1

*br if key=="uuid:2c9571e4-3d34-4a78-ad16-72725c7f6476" & indid2==1
replace dummymainoccupation=0 if occupationname=="Nrega" & key=="uuid:2c9571e4-3d34-4a78-ad16-72725c7f6476" & indid2==1


drop dummymaxhoursayear maxhoursayear dummynewmb dummymainoccupation2 othermainoccupation2 mainoccupation



********** Second test if it is ok for all individuals
preserve
drop if indid==.
bysort key indid: egen summoc=sum(dummymainoccupation)
duplicates drop key indid, force
ta summoc, m
restore

preserve
drop if indid2==.
bysort key indid2: egen summoc=sum(dummymainoccupation)
duplicates drop key indid2, force
ta summoc, m
list key indid2 if summoc==2, clean noobs
restore


save"NEEMSIS-tracking_occupations_allwide_v4.dta", replace
****************************************
* END
