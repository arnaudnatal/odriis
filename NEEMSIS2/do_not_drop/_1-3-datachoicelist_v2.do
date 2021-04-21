/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
23 février 2021
-----
TITLE: LABEL

description: 	Fichier qui se lance tout seul à partir de
				_1-1-MERGE.do
-------------------------
*/

label define yesnosocialnetwork 1"Yes" 2"No need" 3"Nobody", replace
label define employertype 1"State administration (including military)" 2"State-owned enterprise/farm or joint state-private entreprise" 3"Paid public works" 4"An individual (maistry...)" 5"Private firm or plant or farm" 6"Cooperative firm/farm" 7"NGO/ international, political, humanitarian organization" 77"Other", replace
label define deconsumption 77"Other" 1"Yourself - Household head" 2"Spouse (Husband/Wife)" 3"Your spouse and yourseld jointly" 4"Someone else" 5"Yourself and someone else jointly", replace
label define reasonborrowing 1"Agriculture" 2"Family expenses (food, transport, hidden payback, etc.)" 3"Health expenses" 4"Repay previous loan" 5"House expenses" 6"Investment" 7"Ceremonies" 8"Marriage" 9"Education" 10"Relatives expenses" 11"Death expenses"  12"No reason" 77"Other", replace
label define associationlist 1"Youth Union" 2"SHG Group" 3"Trade Union" 4"Farmer Union" 5"Village council (panchayat)" 6"Political party" 7"Professional (occupational) association" 8"Market committee" 9"Religious group" 10"Hobby club, sports group, cultural association" 11"Alumni association" 12"Other association" 13"None", replace
label define durationafter10thstandard 1"Degree in 3 years or less" 2"Degree in more than 3 years", replace
label define lenderfrom 1"Inside village" 2"Outside village" 66"N/A (if institution)" 88"Don't know", replace
label define seriousinjury 66"Irrelevant" 99"No response" 77"Other" 1"Bone, joint or muscle problem which may affect (or is mainly connected with) arms, hands, neck, or shoulder" 2"Bone, joint or muscle problem which may affect (or is mainly connected with) hips, legs or feet" 3"Bone, joint or muscle problem which may affect (or is mainly connected with) the back" 4"Breathing or lung problems" 5"Skin problem" 6"Hearing problem" 7"Stress, depression or anxiety " 8"Headache or eye strain" 9"Heart disease/attack, other circulatory system" 10"Infectious disease", replace
label define frequency5 1"Month" 2"Fortnight (2 weeks)" 3"Week" 4"Day", replace
label define listgoods 1"Car" 2"Bike" 3"Fridge" 4"Costly furniture (>10 000 rupees)" 5"Tailoring machine" 6"Cell phone" 7"Landline phone" 8"DVD" 9"Camera" 10"Cooking gas" 11"Computer" 12"Dish antenna" 13"Air conditioner" 14"TV" 15"TV" 16"None" 77"Other", replace
label define rationcardreasonnouse 1"Too far" 2"No time" 3"Financial constraints" 4"Irregular supply" 5"Poor quality" 6"No need" 7"Insufficient quantity", replace
label define sex1 1"Male" 2"Female" 66"N/A", replace
label define freehousebenefittype 1"In cash" 2"In kind" 3"Both", replace
label define labourrelation 1"Employer" 2"Colleague" 3"Maistry" 4"Supplier", replace
label define subjects 1"Arts (social sciences, economics, commerce)" 2"Science (biology, chemistry, physics)" 3"Engineering" 4"Medical/Nursing school" 5"Industrial/technical institutions (ITI)" 6"Home sciences/Craft/Design" 66"N/A" 77"Other", replace
label define migrationduration 1"Several days (max 7 days)" 2"Several weeks (max 8 weeks = 2 months)" 3"Several months (between 2 and 12 months)" 4"More (Up to 12 months = up to 1 year)", replace
label define unbalancedadvanceproblem 1"Work again with the same maistry/employer next year" 2"Work again with the same maistry/employer next year, but with less advance" 3"Get scoled in front of people" 4"Never give work anymore" 5"If go to another place for or another maistry, maistry/employer will complain about you" 6"Nothing", replace
label define guarantee 77"Other" 1"Documents" 2"Chittu (as an assurance for repayment)" 3"SHG" 4"Personal (informal agreement)" 5"Jewel/Gold" 6"Didn't use any guarantee", replace
label define graduation2 66"Irrelevant" 99"No response" 1"Always" 2"Often" 3"Sometimes" 4"Never", replace
label define drywet 1"Dry land" 2"Wet land", replace
label define yesno3 0"No" 1"Yes" 99"No response", replace
label define migrationplace 1"Around villages" 2"Rural area in Tamil Nadu" 3"Small town of the area (Panruti, Cuddalore, Villupuram, etc.)" 4"Big cities of Tamil Nadu (Chennai, Pondicherry, Madurai, etc.)" 5"Rural area outside Tamil Nadu" 6"Cities outside Tamil Nadu", replace
label define nbworkers2 1"Only Yourself" 2"2-5" 3"6-9" 4"10-15" 5"16-25" 6"26-50" 7"51-200" 8"More than 200", replace
label define frequency 1"Weekly" 2"Monthly" 3"Yearly" 4"Once in 6 months" 5"Fixed amount" 6"Pay whenever have money", replace
label define typejob2 1"Full time" 2"Part time", replace
label define migrationskill 1"Experience" 2"Good education" 3"Specific skill/knowledge" 4"Good network" 5"Nothing", replace
label define migrationtype 1"Individual" 2"Familial", replace
label define noowntoilet 1"None" 2"Shared toilet in building/chawl" 3"Shared toilet outside building" 4"Puclic/Govt. toilet", replace
label define execution 1"Always" 2"Sometimes" 3"Never" 66"Irrelevant", replace
label define contracttype 1"Yes, a signed/written contract/agreement" 2"Yes, an oral agreement" 3"No", replace
label define electricity 1"General electricity" 2"Single line" 3"No electricity", replace
label define productunit 1"Bags" 2"Kilos" 3"Tons", replace
label define skillbusiness 1"From family" 2"From friends" 3"From school" 4"Experience", replace
label define migrationreason2 1"Not enough work in local area" 2"Get advance" 3"Job assurance" 4"Have to repay previous advance", replace
label define kindofwork 1"Agricultural activity on own household farm" 2"Self-employed, own account worker, an owner with or without hired labour (non-agri)" 3"Salaried job (agri in another farm)" 4"Salaried job (non-agri, in industry, services...)" 5"Unpaid worker in household business (non-agri)" 6"Unpaid worker in other business (non-agri)" 7"Unpaid worker in own farm" 8"Unpaid worker in another farm", replace
label define covlending 1"Lower interest rate" 2"Same interest rate" 3"higher interest rate", replace
label define banktype 1"Cooperative Bank" 2"Nationalized Bank" 3"Private Bank", replace
label define gifttype 1"Gold" 2"Cash" 3"Clothes" 4"Almera / furniture" 5"Vessels" 77"Other", replace
label define satisfaction3 1"Very happy" 2"Fairly happy" 3"Not very happy" 4"Not at all happy", replace
label define migrationreason 1"Not enough work in local area" 2"Get advance" 3"Job assurance" 4"Have to repay previous advance" 5"Better opportunity in the migration place" 6"More interesting job in the migration place" 7"Can earn more money than local place" 8"Diversify activities" 9"Get better status" 10"Know someone in migration place who can help me" 77"Other", replace
label define occuplist2 77"Other" 1"Civil servant" 2"Salaried job (agri)" 3"Salaried job (non-agri, in industry or services)" 4"Self-employed" 5"Works in household business" 6"Farmer" 7"Unemployed / Not active", replace
label define kindofwork2 1"Agricultural activity on own household farm/own farm business" 2"Self-employed, own account worker, an owner with or without hired labour (non-agri)" 3"Salaried job (agri in another farm)" 4"Salaried job (non-agri, in industry or services)" 5"Unpaid worker in household business (non-agri)" 6"Unpaid worker in other business (non-agri)" 7"Unpaid worker in own farm (agri)" 8"Unpaid worker in another farm (agri)" 9"Unemployed/not working but actively looking for work" 10"Full-time student" 11"Apprenticeship/Training " 12"Not working and not looking for a job" 77"Other", replace
label define demo7 77"Other" 1"No need" 2"Distrust money transactions by card" 3"Prefer cash transactions " 4"Less flexilibty of transactions (ex: less bargaining, possible arrangments, defering payments..)" 5"Difficult access to ATM/banking infrastructures" 6"Afraid to use it / Don't know how to use it", replace
label define typejob 1"Permanent/ long term (i.e. government job)" 2"Fixed term (limited contract) (i.e. NREGA)" 3"Daily (i.e. agri coolie)" 4"Seasonal (i.e. brick kiln)", replace
label define sexualagression 66"Irrelevant" 99"No response" 1"Over the last month" 2"Over the last year" 3"More than 1 year ago", replace
label define howbuyhouse 1"Hereditary" 2"Savings" 3"Bank loan" 4"Credit from relatives/terinjavanga" 5"Finance" 6"Help from children" 7"Government scheme", replace
label define savingsaccounttype 1"Individual account" 2"Joint account", replace
label define livestockuse 1"To be sold" 2"For Milk" 3"As savings" 4"Keep status" 5"Religious purpose" 6"Self-consumption", replace
label define rural 1"Urban area" 2"Rural area", replace
label define water 1"Own tap" 2"Public tap", replace
label define migrationjoblist 1"Brick Kiln" 2"Sugar Cane Cutting" 3"Construction work" 4"Coolie non-agri" 5"Agri. Coolie" 6"Work in private company" 7"Work in public institution" 8"Self-employment" 9"Following family members", replace
label define graduation 66"Irrelevant" 99"No response" 1"Always" 2"Sometimes" 3"Never", replace
label define problemwork 66"Irrelevant" 99"No response" 1"A big problem" 2"A surmountable problem" 3"Not a problem at all", replace
label define migrationfindjob 1"Maistry" 2"Friends" 3"Known Person" 4"Themselves" 5"Advertisement (newspaper, internet, etc.)" 6"Go regular (no introduction, traditional migration)", replace
label define livestock 1"cows" 2"goats" 3"poultry/chicken" 4"bullock" 5"bull for ploughing" 6"None", replace
label define meet 1"Labour relation" 2"Neighbourhood relation" 3"Introduced by family member (blood relationships)" 4"Introduced by an acquaintance (sontham)" 5"Classmate" 6"Through an association" 77"Other", replace
label define  reasonnoinsurance 1"Not interested" 2"Do not have enough money" 3"Don't know about insurance" 77"Other", replace
label define nbermonth 0"<1 month" 1"1 month" 2"2 months" 3"3 months" 4"4 months" 5"5 months" 6"6 months" 7"7 months" 8"8 months" 9"9 months" 10"10 months" 11"11 months" 12"12 months" 13"More than 1 year", replace
label define typeschool 1"Private" 2"Public", replace
label define livinghome 1"Yes (i.e. share meals or/and income)" 2"Yes, temporarily migrating (less than 1 year and share income)" 3"No, left permanently (new household/got married/ left more than 1 year)" 4"No died", replace
label define yesno5 0"No" 1"Yes" 99"No response", replace
label define agelist 1"15-25" 2"26-35" 3"36-45" 4"46-55" 5"56-65" 6"More than 65", replace
label define paymentinkind 1"Clothes" 2"Food" 3"Transport" 4"Accommodation" 5"Labour in exchange" 77"Other", replace
label define reasonneverattendedschool 1"Failed" 2"Too far/ Inaccessible" 3"Poor quality/lack of facilities" 4"Financial problems" 5"Health problems" 6"Not interested in school" 7"Household work / Child care" 8"Work for pay" 9"Lack of separate school/college for girls" 10"Marriage" 11"Parents/husband didn't allow studying further" 12"Puberty / Gender" 13"Too young (baby)", replace
label define villagearea 1 "Elanthalmpattu Colony" 2 "Elanthalmpattu Ur" 3 "Govulapuram Ur" 4 "Karumbur Colony" 5 "Karumbur Ur" 6 "Korattore Colony" 7 "Korattore Ur" 8 "Kuvagam Colony" 9 "Kuvagam Ur" 10 "Manamthavizhinthaputhur Colony" 11 "Manamthavizhinthaputhur Ur" 12 "Manapakkam Colony" 13 "Manapakkam Ur" 14 "Natham Colony" 15 "Natham Ur" 16 "Oraiyure Colony" 17 "Oraiyure Ur" 18 "Semakottai Colony" 19 "Semakottai Ur", replace
label define reservation 1"Quotas in higher education institutions" 2"Free secondary schooling" 3"Scholarships" 4"Specific schools" 5"Hostels and free mid day meals" 77"Other", replace
label define migrationtravelpayment 1"Yourself" 2"Employer" 3"Maistry" 4"Family", replace
label define reasondontworkmore 1"Studying/in school" 2"Housewife/home duties" 3"In retirement" 4"Old age" 5"Ill" 6"Have a disability" 7"In compulsory military service" 8"Believe I do not have any chance to get a job" 9"Work depends on demand/not enough jobs" 10"Lack of flexibility to work irregular hours (eg night shift) or long hours (more than 40 hours a week)" 11"Lack of flexibility to do more than one hour of commute" 12"A high probability of being discriminated because of your caste group or gender" 13"Already has a job", replace
label define raventest 1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 99"No response", replace
label define hearsomeone 1"You can hear him normally" 2"You can hear him if he speaks loudly" 3"You can't hear him" 66"Irrelevant" 99"No response", replace
label define nbworkers 16"More than 15" 1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 7"7" 8"8" 9"9" 10"10" 11"11" 12"12" 13"13" 14"14" 15"15", replace
label define goodcreditsource 1"Shop keeper" 2"Credit vendor" 3"Finance company" 77"Other", replace
label define post10thstandard 1"Regular senior secondary/ college" 2"Technical degree" 3"Private lesson at home" 4"Distance education/open university/correspondance" 5"Stopped education", replace
label define yesnona 1"Yes" 2"No" 66"N/A", replace
label define assohelpbusiness 1"Advice on how to run business (managerial support, accounting)" 2"New information useful for business" 3"New customers/suppliers" 4"Find/Improve premises" 5"Financial support" 6"Other material support" 7"Emotional support" 77"Other", replace
label define reasonborrowing 1"Agriculture" 2"Family expenses" 3"Health expenses" 4"Repay previous loan" 5"House expenses" 6"Investment" 7"Ceremonies" 8"Marriage" 9"Education" 10"Relatives expenses" 11"Death expenses"  12"No reason" 77"Other", replace
label define bloodrelationship 1"Father's side" 2"Mother's side", replace
label define villagename 1 "Elanthalmpattu" 2 "Govulapuram" 3 "Karumbur" 4 "Korattore" 5 "Kuvagam" 6 "Manapakkam" 7 "Manamthavizhinthaputhur" 8 "Natham" 9 "Oraiyure" 10 "Semakottai", replace
label define productlist 77"Other" 1"Paddy" 2"Cotton" 3"Sugarcane" 4"Savukku tree" 5"Guava" 6"Mango" 7"Sapotta fruit" 8"Banana/Plantain" 9"Ground nut" 10"Ragi" 11"Millets" 12"Cashewnut" 13"Coconut" 14"None", replace
label define insurancetype2 1"Life insurance" 2"Health insurance" 3"Crop insurance" 4"Animal insurance" 5"Accident insurance (vehicles/person)" 6"Bike Insurance", replace
label define startbusinessorfarm 1"YES, I DID SET UP A BUSINESS/FARM" 2"YES I TRIED BUT DID NOT SUCCEED IN SETTING UP A BUSINESS/FARM" 3"NO, I NEVER TRIED", replace
label define problemdelayrepayment 1"Nothing" 2"Shouting" 3"Put the pressure through the guarantor/person who recommended you" 4"Compromise" 5"Inform to all our relatives" 77"Other", replace
label define opinionwork 1"Strongly agree" 2"Agree" 3"Disagree" 4"Strongly disagree", replace
label define nbercontactphone 1"0-20" 2"21-50" 3"51-100" 4"101-200" 5"201-500" 6"501 and more" 7"No mobile phone", replace
label define methodfindjob 1"THROUGH SOCIAL NETWORK: FRIENDS" 2"THROUGH SOCIAL NETWORK: RELATIVES" 3"THROUGH SOCIAL NETWORK: OTHER" 4"CONTACT EMPLOYERS DIRECTLY (VISIT/SEND LETTERS/APPLICATION)" 5"THROUGH PUBLIC EMPLOYMENT AGENCY" 6"THROUGH PRIVATE EMPLOYMENT AGENCY" 7"THROUGH UNIVERSITY/SCHOOL CAREERS' OFFICE" 8"RESPOND TO MEDIA AD/ PUT AD IN PAPER" 9"SEARCH ON INTERNET/ POSTED ON INTERNET" 66"N/A" 99"No response", replace
label define settleloanstrategy 77"Other" 1"Using normal income from labour" 2"Using income from schemes/pensions (i.e retirement pension, widow pension...)" 3"Borrowing elsewhere" 4"Selling something which was not planned" 5"Lease land" 6"Consumption reduction" 7"Take an additional job" 8"Work more" 9"Relative or friends support" 10"Selling the harvest in advance", replace
label define purposebankaccount 1"Savings" 2"Jewel pledge" 3"Receive credit" 4"Crop loans" 5"Sugar mill loan" 6"Get welfare scheme", replace
label define migrationplace2 1"Same Village" 2"Around villages" 3"Rural area in Tamil Nadu" 4"Small town of the area (Panruti, etc.)" 5"Big cities of Tamil Nadu (Chennai, etc.)" 6"Rural area outside Tamil Nadu" 7"Cities outside Tamil Nadu", replace
label define relationlabourer 1"Household member" 2"Relative" 3"Labour relation" 4"Political" 5"Religious" 6"Neighbor" 7"SHG member" 8"Traditional" 9"Friend", replace
label define satisfactionid 1"Always" 2"Frequently" 3"Occasionally" 4"Never", replace
label define advanceprovider 1"Maistry" 2"Employer", replace
label define decisioneducation 77"Other" 1"Yourself" 2"Parents/Other family elders" 3"Both parents/other family elders and yourself jointly" 4"Teachers" 5"Spouse/In-laws", replace
label define classlist 1"1st class" 2"2nd class" 3" 3rd class" 4"4st class" 5"5th class (primary school)" 6"6th class" 7"7th class" 8"8th class (upper primary)" 9"9th class" 10"10th class (high school/ITI)" 11"11th class" 12"12th class (senior secondary/technical training)" 15"Bachelors" 16"Above Bachelors", replace
label define difficultycovid 1"Less inputs available" 2"No cash to get inputs" 3"Difficulty to sell products" 4"Difficulty to pay labourers" 5"Had to change frequency of payment of labourers" 6"Pressure from labourers on wage" 7"Had to change type of contract for labourers" 8"Lack of skilled labour" 9"None" 77"Other", replace
label define personalityandbehavior 1"1 - Almost always" 2"2 - Quite often" 3"3 - Sometimes" 4"4 - Rarely" 5"5 - Almost never" 99"No response", replace
label define relation 1"Labour relation" 2"Relative" 3"Political" 4"Religious" 5"Neighbor" 6"SHG" 7"Business man" 8"Therinjavanga (well-known people)" 9"Traditional" 10"Friend" 11"Group finance" 66"N/A (if scheme, institution, big company...)" 99"No response", replace
label define equipmentlist 1"Tractor" 2"Bullock cart" 3"Harvester" 4"Plowing machine" 5"None", replace
label define institution 1"Your community council" 2"Tamil Nadu government" 3"The police" 4"Traditional leaders" 5"Religious leaders", replace
label define sex 1"Male" 2"Female", replace
label define workcovid 1"More" 2"Less" 3"Same" 4"Constrained to stop due to COVID-19 lockdown" 5"Never start due to COVID-19 lockdown" 66"N/A", replace
*label define username 1"Antoni" 2"Vivek Radja" 3"Venkata", replace
label define howpaymarriage 1"Loan" 2"Own capital / Savings" 3"Both", replace
label define relationshipwithinhh 1"Head" 2"Wife" 3"Mother" 4"Father" 5"Son" 6"Daughter" 7"Son-in-law" 8"Daughter-in-law" 9"Sister" 10"Brother" 11"Mother-in-law" 12"Father-in-law" 13"Grandchild" 15"Grandfather" 16"Grandmother" 17"Cousin" 77"Other", replace
label define reasonstoppedjob 1"Fired" 2"End of contract/business slowdown" 3"Business you worked for closed" 4"Employer reduced your work hours" 5"Low wage/ bad working conditions" 6"Retired" 7"Pregnancy/ child birth" 8"Health (ill/disabled)" 9"Looking after family/children" 10"Moved to another area" 11"To continue education/training" 12"Preferred to work in self-employment" 77"Other", replace
label define notoilet 77"Other" 1"Donât want to by habits" 2"Donât want to because of water problems" 3"Donât want to because there is no space", replace
label define demo7 77"Other" 1"No need" 2"Distrust money transactions by card" 3"Prefer cash transactions " 4"Less flexilibty of transactions" 5"Difficult access to ATM/banking infrastructures" 6"Afraid to use it / Don't know how to use it", replace
label define district 1"Ariyalur" 2"Chengalpet" 3"Chennai" 4"Coimbatore" 5"Cuddalore" 6"Dharmapuri" 7"Dindigul" 8"Erode" 9"Kallakurichi" 10"Kancheepuram" 11"Karur" 12"Krishnagiri" 13"Madurai" 14"Nagapattinam" 15"Kanyakumari" 16"Nagercoil" 17"Namakkal" 18"Perambalur" 19"Pudukottai" 20"Ramanathapuram" 21"Ranipet" 22"Salem" 23"Sivagangai" 24"Tenkasi" 25"Thanjavur" 26"Theni" 27"Thiruvallur" 28"Tuticorin" 29"Trichirappalli" 30"Thirunelveli" 31"Tirupattur" 32"Tiruppur" 33"Thiruvannamalai" 34"The Nilgiris" 35"Vellore" 36"Viluppuram" 37"Virudhunagar", replace
label define literacy2 1"No" 2"Yes, with difficulty" 3"Yes, without difficulty/errors" 99"Refuse", replace
label define salaryincash 1"Yes, I receive monetary payment from my employer" 0"No", replace
label define advancereceiver 1"Husband" 2"Wife" 3"Shared advance with both", replace
label define freehousescheme 1"Green house scheme" 2"Thane - house scheme" 3"Other free house scheme", replace
label define satisfaction2 1"Not true at all" 2"Somewhat true" 3"Quite true" 4"Completely true", replace
label define borrowerservices 1"Free service" 2"Work for less wage" 3"Provide support whenever he need" 4"None (don't provide any services)" 77"Other", replace
label define religion 1"Hindu" 2"Christian" 3"Muslim" 77"Other", replace
label define covidscale 1"More" 2"Less" 3"Same", replace
label define jobpreference 1"Self-employed" 2"Employee / Salaried worker" 99"No response" 66"N/A", replace
label define reasondroppingout 1"Stopped after end of education cycle" 2"Failed" 3"Too far/ Inaccessible" 4"Poor quality/lack of facilities" 5"Financial problems" 6"Health problems" 7"Not interested in school" 8"Household work / Child care" 9"Work for pay" 10"Lack of separate school/college for girls" 11"Marriage" 12"Parents/husband didn't allow studying further" 13"Puberty / Gender" 14"Too young" 15"School closure due to COVID-19" 77"Other", replace
label define plantorepay 1"Joining a chit fund" 2"Someone from the household working more" 3"Someone from the household migrating" 4"Selling assets" 5"Using normal income from labour" 6"Borrowing elsewhere" 77"Other", replace
*label define username 1"Antoni" 2"Vivek Radja" 3"Venkata" 4"Suganya" 5"Rajkumar" 6"Malarvizhi" 7"Chithra" 8"Raichal" 9"Rajalakschmi" 10"Radhika" 11"Mayan" 12"Pazani", replace
label define otherlenderservices 1"Political support" 2"Financial support" 3"Guarantor" 4"General informant" 5"None" 77"Other", replace
label define assodegreeparticip 1"Leader" 2"Active" 3"Simple member", replace
label define relation3 1"Maistry" 2"Own child not living in the house" 3"Sibling not living in the house" 4"Parent not living in the house" 5"Niece/Nephew not living in the house" 6"Other family member not living in the house" 7"Neighbor" 8"Friend" 9"Customer/supplier/colleague" 10"Moneylender" 11"SHG member" 12"Employer" 13"Well known people" 14"Spouse", replace
label define reasondontsearchjob 1 "Studying/In school (student)" 2 "Home duties (housewife)" 3"In retirement" 4"Old age" 5"Ill" 6"Have a disability" 7"In compulsory military service" 8"Do not want to work" 9"Have already found a job which will start later" 10"Awaiting response from employer" 11"Awaiting recall by employer" 12"Waiting for busy season" 13"Believe I do not have any chance to get a job" 14"There are no jobs" 15"Refuse to work for low paid job", replace
label define living 1"Same neighborhood (less than 2-3 km)" 2"In the same village" 3"In the same district" 4"In another place in Tamil Nadu" 5"Elsewhere in India" 6"Foreign country", replace
label define casteemployer 1"Vanniyar" 2"SC" 3"Arunthathiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"Mudaliar" 12"Kulalar" 13"Chettiyar" 14"Marwari" 15"Muslims" 16"Padayachi" 66"N/A" 77"Other", replace
label define wagetype 1"Daily" 2"Weekly" 3"Monthly" 4"Piece rate" 5"Unpaid", replace
label define educlist 1"Primary education or below (5th std or less)" 2"Upper primary (8th std)" 3"High school/ITI (10th std)" 4"Senior secondary/Technical education (12th)" 5"Bachelor and above (15th)" 6"No education" 88"Don't know", replace
label define goodbuying 1"Credit" 2"Instalment" 3"Ready cash" 4"Did not pay for this good (from dowry, gift, etc.)", replace
label define waterfrom 1"Tank" 2"River/Canal" 3"Bore well" 4"Open well" 5"Only rain", replace
label define decisionwork2 77"Other" 1"Yourself" 2"Spouse" 3"Your spouse and yourself jointly" 4"Your parents/parents-in-law and yourself jointly" 5"Your parents or parents-in-law" 6"Children" 7"Your children and yourself jointly" 8"Someone else" 9"Someone else and yourself jointly", replace
label define houseproperty 1"Own house" 2"Joint property between wife and husband's families" 3"Family property inherited at a parent's death" 4"Rental", replace
label define agreementwork 1"1 - Strongly disagree" 2"2 - Disagree" 3"3 - Agree" 4"4 - Strongly agree", replace
label define termsofrepayment 1"Fixed duration" 2"Repay when have money" 3"Repay when asked by the lender", replace
label define reasondroppingout 1"Stopped after end of education cycle" 2"Failed" 3"Too far/ Inaccessible" 4"Poor quality/lack of facilities" 5"Financial problems" 6"Health problems" 7"Not interested in school" 8"Household work / Child care" 9"Work for pay" 10"Lack of separate school/college for girls" 11"Marriage" 12"Parents/husband didn't allow studying further" 13"Puberty / Gender" 14"Too young" 77"Other", replace
label define loseland 77"Other" 1"Unable to provide property document" 2"Sell the land pledged to the lender because unable  to pay loan(s) - interest or principal" 3"Sell the land outside of pawnbroking" 4"Given to the governement with a compensation", replace
label define months 1"Chithirai (april-may)" 2"Vaikasi (may-june)" 3"Aani (june-july)" 4"Aadi (july-august)" 5"Aavani (august-september)" 6"Purataasi (september-october)" 7"Iypasi (october-november)" 8"Karthigai (november-december)" 9"Maargazhi (december-january)" 10"Thai (january-february)" 11"Maasi (february-march)" 12"Panguni (march-april)", replace
label define guaranteetype 1"Guarantee of money" 2"Guarantee of trust", replace
label define expenseslist 1"Food" 2"Transportation" 3"Clothes" 4"Health" 5"Education" 6"Gifts" 7"Ceremonies" 8"Goods" 9"None", replace
label define migrationplace 1"Around villages" 2"Rural area in Tamil Nadu" 3"Small town of the area (Panruti, etc.)" 4"Big cities of Tamil Nadu (Chennai,etc.)" 5"Rural area outside Tamil Nadu" 6"Cities outside Tamil Nadu", replace
label define sourceinvestment 1"Loans or grants from relatives" 2"Bank loan (private bank, coop bank, SHG loan)" 3"Informal loan (traders, landlords, moneylenders)" 4"Household savings or sails of assets" 5"Money from inheritance" 6"Profits from other household enterprises" 7"Did not need funds to start it because inherited business" 8"Did not need funds to start it because it didn't need much capital" 9"Goverment schemes/Public subsidies" 77"Other", replace
label define frequency3 1"Monthly" 2"Every 3 months" 3"Every 6 months" 4"Yearly", replace
label define guarantee 77"Other", replace
label define covinstit 1"à®®à¯à®´à¯ à®¨à®®à¯à®ªà®¿à®à¯à®à¯" 2"à®ªà¯à®¾à®©à¯à®±" 3"à®à®£à¯à®®à¯à®¯à®¿à®²à¯ à®à®²à¯à®²à¯" 4"à®à®²à¯à®²à®µà¯ à®à®²à¯à®²à¯", replace
label define interviewplace 1"Inside village" 2"New place of permanent residency outside village" 3"Migration workplace", replace
label define seriousincident 66"Irrelevant" 99"No response" 1"No permanent effect" 2"A permanent effect but you are able to carry on with the same job" 3"A permanent effect but you are able to work although not in the same job" 4"A permanent effect that prevent you from working at all", replace
label define compared 1"In a better economic situation than you?" 2"In the same economic situation than you?" 3"In a worst economic situation than you?", replace
label define reasonborrowing2 1"Agriculture" 2"Family expenses (food, transport, hidden payback, etc.)" 3"Health expenses" 4"Repay previous loan" 5"House expenses" 6"Investment" 7"Ceremonies" 8"Marriage" 9"Education" 10"Relatives expenses" 11"Death expenses" 12"No reason", replace
label define intimacydegree 1"Not intimate" 2"Intimate" 3"Very intimate", replace
label define meetfrequency 1"At least once a week" 2"At least once a month" 3"Every 2-3 months" 4"Every 4-6 months" 5"Once a year" 6"Less than once a year", replace
label define insurancetype 1"Private" 2"Public", replace
label define numeracy 1"Correct" 2"Incorrect" 99"No response", replace
label define unbalancedadvance 1"Good" 2"Neutral" 3"Bad", replace
label define covidscale2 1"Increase" 2"Drecrease" 3"Remain stable", replace
label define goodbuying 1"Credit" 2"Instalment" 3"Ready cash" 4"Did not pay for this good", replace
label define contactlist 1"Head of business in the same sector" 2"Policeman" 3"Civil servant" 4"Formal bank employee or microcredit institution" 5"Village committe (panchayat)" 6"People council (caste-based)" 7"Recruiter for a firm or in employment office" 8"Head of a trade union" 9"None", replace
label define importantdecision 77"Other" 1"Job" 2"Family events" 3"Education" 4"Health" 5"Marriage", replace
label define frequency2 1"Weekly" 2"Monthly" 3"Yearly" 4"Once in 6 months" 5"Pay whenever have money", replace
label define housetype 1"Concrete house" 2"Thatched roof house", replace
label define maritalstatus 1"Married" 2"Unmarried (above 10)" 3"Widowed" 4"Separated/divorced" 66"N/A (if below 10)", replace
label define productypeland 1"Own land" 2"Leased land" 3"Both", replace
label define demo6 77"Other" 1"Never used it" 2"To get cash in ATM" 3"Payment in shops" 4"Transfer money/receive money in ATMs" 5"Payment online" 6"Mobile payment (Paytm or other apps)", replace
label define castes 1"Vanniyar" 2"SC" 3"Arunthathiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"Mudaliar" 12"Kulalar" 13"Chettiyar" 14"Marwari" 15"Muslims" 16"Padayachi" 88"Don't know", replace
label define nbpeople 1"2-10 " 2"11-50" 3"51-100" 4">100" 88"Don't know", replace
label define assohelpbusiness 1"Advice on how to run business" 2"New information useful for business" 3"New customers/suppliers" 4"Find/Improve premises" 5"Financial support" 6"Other material support" 7"Emotional support" 77"Other", replace
label define chitfundtype 1"Auction chit" 2"Jewel chit" 3"Vessels chit" 4"Tourism chit", replace
label define howpaymarriage 1"Loan" 2"Own capital / Savings" 3"Gift" 4"Both", replace
label define productpledge 1"Gold" 2"Land" 3"Car" 4"Bike" 5"Fridge" 6"Costly furniture (>10 000 rupees)" 7"Tailoring machine" 8"Cell phone" 9"Land line phone" 10"DVD" 11"Camera" 12"Cooking gas" 13"Computer" 14"Dish antenna" 15"Silver" 16"None" 77"Other", replace
label define productpledge 1"Gold" 2"Land" 3"Car" 4"Bike" 5"Fridge" 6"Costly furniture (>10 000 rupees)" 7"Tailoring machine" 8"Cell phone" 9"Land line phone" 10"DVD" 11"Camera" 12"Cooking gas" 13"Computer" 14"Dish antenna" 15"None" 77"Other", replace
label define termsofrepayment 1"Fixed duration" 2"Repay when have money" 3"Repay when asked by the lender" 66"N/A", replace
label define reservation 1"Quotas in higher education institutions" 2"Free secondary schooling" 3"Scholarships" 4"Specific schools" 5"Hostels and free mid day meals", replace
label define locusscale 1"Applies to me with a very large extent " 2"Applies to me in a great extent" 3"Applies to me in some extent" 4"Hardly applies to me at all" 5"Does not apply to me at all", replace
label define assohelpjob 1"Someone from association hired you" 2"Someone from association referred you" 3"Someone from association shared job openings" 4"Help with application (prep documents)" 5"Emotional support" 77"Other", replace
label define marriagetype 1"Blood or family relationship" 2"Outside the family", replace
label define decisionwork 77"Other" 1"Yourself" 2"Husband/Wife" 3"Parents or step-parents" 4"Children" 5"Someone else", replace
label define satisfaction4 66"Irrelevant" 1"Very satisfied" 2"Fairly satisfied" 3"Not very satisfied" 4"Not at all satisfied", replace
label define physicalharm 66"Irrelevant" 99"No response" 1"Very concerned" 2"Somewhat concerned" 3"Not very concerned" 4"Not concerned", replace
label define lenders 1"Well-know people" 2"Relatives" 3"Friend" 4"Employer" 5"Maistry" 6"Colleague" 7"Pawnbroker" 8"Shop keeper" 9"Microcredit: individual loan" 10"Microcredit: non-SHG group loan" 11"Microcredit: SHG" 12"Finance: daily finance/thandal" 13"Finance: other type of finance" 14"Bank: no coop" 15"Bank: coop" 16"Sugar mill loan", replace
label define originlabourers 1"Inside the village" 2"Outside the village", replace
label define settleloanstrategy 77"Other" 1"Using normal income from labour" 2"Using income from schemes/pensions" 3"Borrowing elsewhere" 4"Selling something which was not planned" 5"Lease land" 6"Consumption reduction" 7"Take an additional job" 8"Work more" 9"Relative or friends support" 10"Selling the harvest in advance", replace
label define yesno 0"No" 1"Yes", replace
label define institution 1"Your community council" 2"Tamil Nadu government" 3"The police" 4"Traditional leaders" 5"Religious leaders" 6"None", replace
label define toiletfacility 1"No facilities" 2"Traditional pit latrine" 3"Semi-flush (Septic tank) latrine" 4"Flush toilet", replace
*capture confirm v username
*if !_rc {
*destring username, replace
*}
*else {
*
*}
capture confirm v compensation
if !_rc {
destring compensation, replace
}
else {

}
capture confirm v villagearea
if !_rc {
destring villagearea, replace
}
else {

}
capture confirm v householdid
if !_rc {
destring householdid, replace
}
else {

}
capture confirm v interviewplace
if !_rc {
destring interviewplace, replace
}
else {

}
capture confirm v lefthomereason
if !_rc {
destring lefthomereason, replace
}
else {

}
capture confirm v dummypermanentmigrantwork
if !_rc {
destring dummypermanentmigrantwork, replace
}
else {

}
capture confirm v sex_new
if !_rc {
destring sex_new, replace
}
else {

}
capture confirm v relationshiptohead
if !_rc {
destring relationshiptohead, replace
}
else {

}
capture confirm v maritalstatus
if !_rc {
destring maritalstatus, replace
}
else {

}
capture confirm v dummycastespouse
if !_rc {
destring dummycastespouse, replace
}
else {

}
capture confirm v comefromspouse
if !_rc {
destring comefromspouse, replace
}
else {

}
capture confirm v dummyreligionspouse
if !_rc {
destring dummyreligionspouse, replace
}
else {

}
capture confirm v religionspouse
if !_rc {
destring religionspouse, replace
}
else {

}
capture confirm v castespouse
if !_rc {
destring castespouse, replace
}
else {

}
capture confirm v covsick
if !_rc {
destring covsick, replace
}
else {

}
capture confirm v covtest
if !_rc {
destring covtest, replace
}
else {

}
capture confirm v canread
if !_rc {
destring canread, replace
}
else {

}
capture confirm v everattendedschool
if !_rc {
destring everattendedschool, replace
}
else {

}
capture confirm v classcompleted
if !_rc {
destring classcompleted, replace
}
else {

}
capture confirm v after10thstandard
if !_rc {
destring after10thstandard, replace
}
else {

}
capture confirm v durationafter10th
if !_rc {
destring durationafter10th, replace
}
else {

}
capture confirm v typeofhigheredu
if !_rc {
destring typeofhigheredu, replace
}
else {

}
capture confirm v subjectsafter10th
if !_rc {
destring subjectsafter10th, replace
}
else {

}
capture confirm v newtraining
if !_rc {
destring newtraining, replace
}
else {

}
capture confirm v reservation
if !_rc {
destring reservation, replace
}
else {

}
capture confirm v reservationgrade
if !_rc {
destring reservationgrade, replace
}
else {

}
capture confirm v reservationkind
if !_rc {
destring reservationkind, replace
}
else {

}
capture confirm v currentlyatschool
if !_rc {
destring currentlyatschool, replace
}
else {

}
capture confirm v reasonneverattendedschool
if !_rc {
destring reasonneverattendedschool, replace
}
else {

}
capture confirm v reasondropping
if !_rc {
destring reasondropping, replace
}
else {

}
capture confirm v goingbackschool
if !_rc {
destring goingbackschool, replace
}
else {

}
capture confirm v decisiondropping
if !_rc {
destring decisiondropping, replace
}
else {

}
capture confirm v dummyscholarship
if !_rc {
destring dummyscholarship, replace
}
else {

}
capture confirm v converseinenglish
if !_rc {
destring converseinenglish, replace
}
else {

}
capture confirm v dummyworkedpastyear
if !_rc {
destring dummyworkedpastyear, replace
}
else {

}
capture confirm v reservationemployment
if !_rc {
destring reservationemployment, replace
}
else {

}
capture confirm v businesscastebased
if !_rc {
destring businesscastebased, replace
}
else {

}
capture confirm v businessskill
if !_rc {
destring businessskill, replace
}
else {

}
capture confirm v businesslocation
if !_rc {
destring businesslocation, replace
}
else {

}
capture confirm v dummybusinesslabourers
if !_rc {
destring dummybusinesslabourers, replace
}
else {

}
capture confirm v dummybusinesslabourerhhmember
if !_rc {
destring dummybusinesslabourerhhmember, replace
}
else {

}
capture confirm v relationshipbusinesslabourer
if !_rc {
destring relationshipbusinesslabourer, replace
}
else {

}
capture confirm v castebusinesslabourer
if !_rc {
destring castebusinesslabourer, replace
}
else {

}
capture confirm v businesslabourertypejob
if !_rc {
destring businesslabourertypejob, replace
}
else {

}
capture confirm v businesslabourerwagetype
if !_rc {
destring businesslabourerwagetype, replace
}
else {

}
capture confirm v businesslabourerbonus
if !_rc {
destring businesslabourerbonus, replace
}
else {

}
capture confirm v businesslabourerinsurance
if !_rc {
destring businesslabourerinsurance, replace
}
else {

}
capture confirm v businesslabourerpension
if !_rc {
destring businesslabourerpension, replace
}
else {

}
capture confirm v joblocation
if !_rc {
destring joblocation, replace
}
else {

}
capture confirm v wagejobnbworker
if !_rc {
destring wagejobnbworker, replace
}
else {

}
capture confirm v typewageemployer
if !_rc {
destring typewageemployer, replace
}
else {

}
capture confirm v relationemployer
if !_rc {
destring relationemployer, replace
}
else {

}
capture confirm v casteemployer
if !_rc {
destring casteemployer, replace
}
else {

}
capture confirm v salariedjobtype
if !_rc {
destring salariedjobtype, replace
}
else {

}
capture confirm v salariedjobtype2
if !_rc {
destring salariedjobtype2, replace
}
else {

}
capture confirm v salariedwagetype
if !_rc {
destring salariedwagetype, replace
}
else {

}
capture confirm v salariedjobbonus
if !_rc {
destring salariedjobbonus, replace
}
else {

}
capture confirm v salariedjobinsurance
if !_rc {
destring salariedjobinsurance, replace
}
else {

}
capture confirm v salariedjobpension
if !_rc {
destring salariedjobpension, replace
}
else {

}
capture confirm v salariedcontract
if !_rc {
destring salariedcontract, replace
}
else {

}
capture confirm v reasonnotworkpastyear
if !_rc {
destring reasonnotworkpastyear, replace
}
else {

}
capture confirm v stoppedworking
if !_rc {
destring stoppedworking, replace
}
else {

}
capture confirm v workpastsixmonth
if !_rc {
destring workpastsixmonth, replace
}
else {

}
capture confirm v everworksalaried
if !_rc {
destring everworksalaried, replace
}
else {

}
capture confirm v dummymigration
if !_rc {
destring dummymigration, replace
}
else {

}
capture confirm v migrationarea
if !_rc {
destring migrationarea, replace
}
else {

}
capture confirm v migrationtype
if !_rc {
destring migrationtype, replace
}
else {

}
capture confirm v migrationdurationfrequency
if !_rc {
destring migrationdurationfrequency, replace
}
else {

}
capture confirm v dummybacktovillage
if !_rc {
destring dummybacktovillage, replace
}
else {

}
capture confirm v migrationtravelpayment
if !_rc {
destring migrationtravelpayment, replace
}
else {

}
capture confirm v migrationfindjob
if !_rc {
destring migrationfindjob, replace
}
else {

}
capture confirm v dummyadvance
if !_rc {
destring dummyadvance, replace
}
else {

}
capture confirm v migrationadvanceprovider
if !_rc {
destring migrationadvanceprovider, replace
}
else {

}
capture confirm v migrationadvancereceiver
if !_rc {
destring migrationadvancereceiver, replace
}
else {

}
capture confirm v migrationadvancefeel
if !_rc {
destring migrationadvancefeel, replace
}
else {

}
capture confirm v dummyadvancebalance
if !_rc {
destring dummyadvancebalance, replace
}
else {

}
capture confirm v advancebalanceperception
if !_rc {
destring advancebalanceperception, replace
}
else {

}
capture confirm v migrationjobtype
if !_rc {
destring migrationjobtype, replace
}
else {

}
capture confirm v migrationjobtype2
if !_rc {
destring migrationjobtype2, replace
}
else {

}
capture confirm v migrationwagetype
if !_rc {
destring migrationwagetype, replace
}
else {

}
capture confirm v migrationpension
if !_rc {
destring migrationpension, replace
}
else {

}
capture confirm v migrationbonus
if !_rc {
destring migrationbonus, replace
}
else {

}
capture confirm v migrationinsurance
if !_rc {
destring migrationinsurance, replace
}
else {

}
capture confirm v migrationchild
if !_rc {
destring migrationchild, replace
}
else {

}
capture confirm v migrationmainoccup
if !_rc {
destring migrationmainoccup, replace
}
else {

}
capture confirm v migrationskill
if !_rc {
destring migrationskill, replace
}
else {

}
capture confirm v migrationreason
if !_rc {
destring migrationreason, replace
}
else {

}
capture confirm v covforcedbackhome
if !_rc {
destring covforcedbackhome, replace
}
else {

}
capture confirm v covpressureadvance
if !_rc {
destring covpressureadvance, replace
}
else {

}
capture confirm v dummyremreceived
if !_rc {
destring dummyremreceived, replace
}
else {

}
capture confirm v remreceivedsourcerelation
if !_rc {
destring remreceivedsourcerelation, replace
}
else {

}
capture confirm v remreceivedsourceoccup
if !_rc {
destring remreceivedsourceoccup, replace
}
else {

}
capture confirm v remreceivedsourceplace
if !_rc {
destring remreceivedsourceplace, replace
}
else {

}
capture confirm v remreceivedmoney
if !_rc {
destring remreceivedmoney, replace
}
else {

}
capture confirm v remgift
if !_rc {
destring remgift, replace
}
else {

}
capture confirm v remreceivedservices
if !_rc {
destring remreceivedservices, replace
}
else {

}
capture confirm v remreceivedfrequency
if !_rc {
destring remreceivedfrequency, replace
}
else {

}
capture confirm v covremreceived
if !_rc {
destring covremreceived, replace
}
else {

}
capture confirm v dummyremsent
if !_rc {
destring dummyremsent, replace
}
else {

}
capture confirm v remsentdummyvillage
if !_rc {
destring remsentdummyvillage, replace
}
else {

}
capture confirm v remsentrelation
if !_rc {
destring remsentrelation, replace
}
else {

}
capture confirm v remsentoccup
if !_rc {
destring remsentoccup, replace
}
else {

}
capture confirm v remsentplace
if !_rc {
destring remsentplace, replace
}
else {

}
capture confirm v remsentmoney
if !_rc {
destring remsentmoney, replace
}
else {

}
capture confirm v remsentgift
if !_rc {
destring remsentgift, replace
}
else {

}
capture confirm v remsentservices
if !_rc {
destring remsentservices, replace
}
else {

}
capture confirm v remsentfrequency
if !_rc {
destring remsentfrequency, replace
}
else {

}
capture confirm v dummyloans
if !_rc {
destring dummyloans, replace
}
else {

}
capture confirm v covrefusalloan
if !_rc {
destring covrefusalloan, replace
}
else {

}
capture confirm v loanreasongiven
if !_rc {
destring loanreasongiven, replace
}
else {

}
capture confirm v loanreasongiven2
if !_rc {
destring loanreasongiven2, replace
}
else {

}
capture confirm v loaneffectivereason
if !_rc {
destring loaneffectivereason, replace
}
else {

}
capture confirm v loaneffectivereason2
if !_rc {
destring loaneffectivereason2, replace
}
else {

}
capture confirm v lenderrelation
if !_rc {
destring lenderrelation, replace
}
else {

}
capture confirm v lenderscaste
if !_rc {
destring lenderscaste, replace
}
else {

}
capture confirm v lenderfrom
if !_rc {
destring lenderfrom, replace
}
else {

}
capture confirm v otherlenderservices
if !_rc {
destring otherlenderservices, replace
}
else {

}
capture confirm v guarantee
if !_rc {
destring guarantee, replace
}
else {

}
capture confirm v guaranteetype
if !_rc {
destring guaranteetype, replace
}
else {

}
capture confirm v loansettled
if !_rc {
destring loansettled, replace
}
else {

}
capture confirm v dummyinterest
if !_rc {
destring dummyinterest, replace
}
else {

}
capture confirm v lendersex
if !_rc {
destring lendersex, replace
}
else {

}
capture confirm v lenderoccup
if !_rc {
destring lenderoccup, replace
}
else {

}
capture confirm v additionalloan
if !_rc {
destring additionalloan, replace
}
else {

}
capture confirm v borrowerservices
if !_rc {
destring borrowerservices, replace
}
else {

}
capture confirm v plantorepay
if !_rc {
destring plantorepay, replace
}
else {

}
capture confirm v termsofrepayment
if !_rc {
destring termsofrepayment, replace
}
else {

}
capture confirm v repayduration1
if !_rc {
destring repayduration1, replace
}
else {

}
capture confirm v covfrequencyrepayment
if !_rc {
destring covfrequencyrepayment, replace
}
else {

}
capture confirm v dummyinteret
if !_rc {
destring dummyinteret, replace
}
else {

}
capture confirm v interestfrequency
if !_rc {
destring interestfrequency, replace
}
else {

}
capture confirm v covfrequencyinterest
if !_rc {
destring covfrequencyinterest, replace
}
else {

}
capture confirm v covamountinterest
if !_rc {
destring covamountinterest, replace
}
else {

}
capture confirm v dummyproblemtorepay
if !_rc {
destring dummyproblemtorepay, replace
}
else {

}
capture confirm v settleloanstrategy
if !_rc {
destring settleloanstrategy, replace
}
else {

}
capture confirm v loanproductpledge
if !_rc {
destring loanproductpledge, replace
}
else {

}
capture confirm v dummyhelptosettleloan
if !_rc {
destring dummyhelptosettleloan, replace
}
else {

}
capture confirm v helptosettleloan
if !_rc {
destring helptosettleloan, replace
}
else {

}
capture confirm v dummyrecommendation
if !_rc {
destring dummyrecommendation, replace
}
else {

}
capture confirm v dummyguarantor
if !_rc {
destring dummyguarantor, replace
}
else {

}
capture confirm v recommenddetailscaste
if !_rc {
destring recommenddetailscaste, replace
}
else {

}
capture confirm v recommendloanrelation
if !_rc {
destring recommendloanrelation, replace
}
else {

}
capture confirm v guarantordetailscaste
if !_rc {
destring guarantordetailscaste, replace
}
else {

}
capture confirm v guarantorloanrelation
if !_rc {
destring guarantorloanrelation, replace
}
else {

}
capture confirm v dummyincomeassets
if !_rc {
destring dummyincomeassets, replace
}
else {

}
capture confirm v dummylendingmoney
if !_rc {
destring dummylendingmoney, replace
}
else {

}
capture confirm v borrowerscaste
if !_rc {
destring borrowerscaste, replace
}
else {

}
capture confirm v borrowerssex
if !_rc {
destring borrowerssex, replace
}
else {

}
capture confirm v relationwithborrower
if !_rc {
destring relationwithborrower, replace
}
else {

}
capture confirm v purposeloanborrower
if !_rc {
destring purposeloanborrower, replace
}
else {

}
capture confirm v problemrepayment
if !_rc {
destring problemrepayment, replace
}
else {

}
capture confirm v dummyloanfromborrower
if !_rc {
destring dummyloanfromborrower, replace
}
else {

}
capture confirm v covlendrepayment
if !_rc {
destring covlendrepayment, replace
}
else {

}
capture confirm v covlending
if !_rc {
destring covlending, replace
}
else {

}
capture confirm v dummyrecommendgiven
if !_rc {
destring dummyrecommendgiven, replace
}
else {

}
capture confirm v dummyrecommendrefuse
if !_rc {
destring dummyrecommendrefuse, replace
}
else {

}
capture confirm v dummychitfund
if !_rc {
destring dummychitfund, replace
}
else {

}
capture confirm v chitfundtype
if !_rc {
destring chitfundtype, replace
}
else {

}
capture confirm v chitfundpayment
if !_rc {
destring chitfundpayment, replace
}
else {

}
capture confirm v dummysavingaccount
if !_rc {
destring dummysavingaccount, replace
}
else {

}
capture confirm v savingsaccounttype
if !_rc {
destring savingsaccounttype, replace
}
else {

}
capture confirm v banktype
if !_rc {
destring banktype, replace
}
else {

}
capture confirm v savingspurpose
if !_rc {
destring savingspurpose, replace
}
else {

}
capture confirm v dummydebitcard
if !_rc {
destring dummydebitcard, replace
}
else {

}
capture confirm v dummycreditcard
if !_rc {
destring dummycreditcard, replace
}
else {

}
capture confirm v usedebitcard
if !_rc {
destring usedebitcard, replace
}
else {

}
capture confirm v reasonnotusedebitcard
if !_rc {
destring reasonnotusedebitcard, replace
}
else {

}
capture confirm v usecreditcard
if !_rc {
destring usecreditcard, replace
}
else {

}
capture confirm v reasonnotusedcreditcard
if !_rc {
destring reasonnotusedcreditcard, replace
}
else {

}
capture confirm v dummygold
if !_rc {
destring dummygold, replace
}
else {

}
capture confirm v dummygoldpledged
if !_rc {
destring dummygoldpledged, replace
}
else {

}
capture confirm v goldreasonpledge
if !_rc {
destring goldreasonpledge, replace
}
else {

}
capture confirm v lenderscastegold
if !_rc {
destring lenderscastegold, replace
}
else {

}
capture confirm v lenderfromgold
if !_rc {
destring lenderfromgold, replace
}
else {

}
capture confirm v loansettledgold
if !_rc {
destring loansettledgold, replace
}
else {

}
capture confirm v dummyinsurance
if !_rc {
destring dummyinsurance, replace
}
else {

}
capture confirm v reasonnoinsurance
if !_rc {
destring reasonnoinsurance, replace
}
else {

}
capture confirm v insurancetype
if !_rc {
destring insurancetype, replace
}
else {

}
capture confirm v insurancetype2
if !_rc {
destring insurancetype2, replace
}
else {

}
capture confirm v insurancepaymentfrequency
if !_rc {
destring insurancepaymentfrequency, replace
}
else {

}
capture confirm v insurancebenefit
if !_rc {
destring insurancebenefit, replace
}
else {

}
capture confirm v dummymarriage
if !_rc {
destring dummymarriage, replace
}
else {

}
capture confirm v husbandwifecaste
if !_rc {
destring husbandwifecaste, replace
}
else {

}
capture confirm v marriagetype
if !_rc {
destring marriagetype, replace
}
else {

}
capture confirm v marriageblood
if !_rc {
destring marriageblood, replace
}
else {

}
capture confirm v marriagearranged
if !_rc {
destring marriagearranged, replace
}
else {

}
capture confirm v marriagespousefamily
if !_rc {
destring marriagespousefamily , replace
}
else {

}
capture confirm v howpaymarriage
if !_rc {
destring howpaymarriage, replace
}
else {

}
capture confirm v marriageloanlendersex
if !_rc {
destring marriageloanlendersex, replace
}
else {

}
capture confirm v marriageloancaste
if !_rc {
destring marriageloancaste, replace
}
else {

}
capture confirm v marriagelenderfrom
if !_rc {
destring marriagelenderfrom, replace
}
else {

}
capture confirm v marriageloansettled
if !_rc {
destring marriageloansettled, replace
}
else {

}
capture confirm v dummymarriagegift
if !_rc {
destring dummymarriagegift, replace
}
else {

}
capture confirm v marriagegifttype
if !_rc {
destring marriagegifttype, replace
}
else {

}
capture confirm v rationcarduse
if !_rc {
destring rationcarduse, replace
}
else {

}
capture confirm v rationcardreasonnouse
if !_rc {
destring rationcardreasonnouse, replace
}
else {

}
capture confirm v freehousescheme
if !_rc {
destring freehousescheme, replace
}
else {

}
capture confirm v freehousebenefittype
if !_rc {
destring freehousebenefittype, replace
}
else {

}
capture confirm v dummyhhrespondentego1
if !_rc {
destring dummyhhrespondentego1, replace
}
else {

}
capture confirm v everwork
if !_rc {
destring everwork, replace
}
else {

}
capture confirm v workpastsevendays
if !_rc {
destring workpastsevendays, replace
}
else {

}
capture confirm v searchjob
if !_rc {
destring searchjob, replace
}
else {

}
capture confirm v startbusiness
if !_rc {
destring startbusiness, replace
}
else {

}
capture confirm v reasondontsearchjob
if !_rc {
destring reasondontsearchjob, replace
}
else {

}
capture confirm v searchjobsince15
if !_rc {
destring searchjobsince15, replace
}
else {

}
capture confirm v reasondontsearchjobsince15
if !_rc {
destring reasondontsearchjobsince15, replace
}
else {

}
capture confirm v nbermonthsearchjob
if !_rc {
destring nbermonthsearchjob, replace
}
else {

}
capture confirm v methodfindfirstjob
if !_rc {
destring methodfindfirstjob, replace
}
else {

}
capture confirm v jobfirstwagefrequencycash
if !_rc {
destring jobfirstwagefrequencycash, replace
}
else {

}
capture confirm v dummymainoccupation2
if !_rc {
destring dummymainoccupation2, replace
}
else {

}
capture confirm v dummyseasonalmainoccup
if !_rc {
destring dummyseasonalmainoccup, replace
}
else {

}
capture confirm v dummypreviouswagejob
if !_rc {
destring dummypreviouswagejob, replace
}
else {

}
capture confirm v previousjobcontract
if !_rc {
destring previousjobcontract, replace
}
else {

}
capture confirm v reasonstoppedwagejob
if !_rc {
destring reasonstoppedwagejob, replace
}
else {

}
capture confirm v businesslossinvest
if !_rc {
destring businesslossinvest, replace
}
else {

}
capture confirm v covdifficulties
if !_rc {
destring covdifficulties, replace
}
else {

}
capture confirm v castebusinesslender
if !_rc {
destring castebusinesslender, replace
}
else {

}
capture confirm v sexbusinesslender
if !_rc {
destring sexbusinesslender, replace
}
else {

}
capture confirm v agebusinesslender
if !_rc {
destring agebusinesslender, replace
}
else {

}
capture confirm v educbusinesslender
if !_rc {
destring educbusinesslender, replace
}
else {

}
capture confirm v livingbusinesslender
if !_rc {
destring livingbusinesslender, replace
}
else {

}
capture confirm v comparedbusinesslender
if !_rc {
destring comparedbusinesslender, replace
}
else {

}
capture confirm v meetbusinesslender
if !_rc {
destring meetbusinesslender, replace
}
else {

}
capture confirm v meetfrequemcybusinesslender
if !_rc {
destring meetfrequemcybusinesslender, replace
}
else {

}
capture confirm v invitebusinesslender
if !_rc {
destring invitebusinesslender, replace
}
else {

}
capture confirm v reciprocity1businesslender
if !_rc {
destring reciprocity1businesslender, replace
}
else {

}
capture confirm v intimacybusinesslender
if !_rc {
destring intimacybusinesslender, replace
}
else {

}
capture confirm v businessnbworkers
if !_rc {
destring businessnbworkers, replace
}
else {

}
capture confirm v dummybusinessunpaidworkers
if !_rc {
destring dummybusinessunpaidworkers, replace
}
else {

}
capture confirm v businessnbunpaidworkers
if !_rc {
destring businessnbunpaidworkers, replace
}
else {

}
capture confirm v dummybusinesspaidworkers
if !_rc {
destring dummybusinesspaidworkers, replace
}
else {

}
capture confirm v businessnbpaidworkers
if !_rc {
destring businessnbpaidworkers, replace
}
else {

}
capture confirm v businessworkersfrequencypayment
if !_rc {
destring businessworkersfrequencypayment, replace
}
else {

}
capture confirm v frequencygrossreceipt
if !_rc {
destring frequencygrossreceipt, replace
}
else {

}
capture confirm v businesssocialsecurity
if !_rc {
destring businesssocialsecurity, replace
}
else {

}
capture confirm v businesspaymentinkind
if !_rc {
destring businesspaymentinkind, replace
}
else {

}
capture confirm v businesspaymentinkindlist
if !_rc {
destring businesspaymentinkindlist, replace
}
else {

}
capture confirm v snentrustbusiness
if !_rc {
destring snentrustbusiness, replace
}
else {

}
capture confirm v snentrustbusinessdummyfam
if !_rc {
destring snentrustbusinessdummyfam, replace
}
else {

}
capture confirm v snentrustbusinessdummyhh
if !_rc {
destring snentrustbusinessdummyhh, replace
}
else {

}
capture confirm v snentrustbusinessfriend
if !_rc {
destring snentrustbusinessfriend, replace
}
else {

}
capture confirm v snentrustbusinesswkp
if !_rc {
destring snentrustbusinesswkp, replace
}
else {

}
capture confirm v snentrustbusinesslabourrelation
if !_rc {
destring snentrustbusinesslabourrelation, replace
}
else {

}
capture confirm v snentrustbusinesssex
if !_rc {
destring snentrustbusinesssex, replace
}
else {

}
capture confirm v snentrustbusinessage
if !_rc {
destring snentrustbusinessage, replace
}
else {

}
capture confirm v snentrustbusinesslabourtype
if !_rc {
destring snentrustbusinesslabourtype, replace
}
else {

}
capture confirm v snentrustbusinesscastes
if !_rc {
destring snentrustbusinesscastes, replace
}
else {

}
capture confirm v snentrustbusinesseduc
if !_rc {
destring snentrustbusinesseduc, replace
}
else {

}
capture confirm v snentrustbusinessemployertype
if !_rc {
destring snentrustbusinessemployertype, replace
}
else {

}
capture confirm v snentrustbusinessliving
if !_rc {
destring snentrustbusinessliving, replace
}
else {

}
capture confirm v snentrustbusinessruralurban
if !_rc {
destring snentrustbusinessruralurban, replace
}
else {

}
capture confirm v snentrustbusinessdistrict
if !_rc {
destring snentrustbusinessdistrict, replace
}
else {

}
capture confirm v snentrustbusinesscompared
if !_rc {
destring snentrustbusinesscompared, replace
}
else {

}
capture confirm v snentrustbusinessmeet
if !_rc {
destring snentrustbusinessmeet, replace
}
else {

}
capture confirm v snentrustbusinessmeetfrequency
if !_rc {
destring snentrustbusinessmeetfrequency, replace
}
else {

}
capture confirm v snentrustbusinessinvite
if !_rc {
destring snentrustbusinessinvite, replace
}
else {

}
capture confirm v snentrustbusinessreciprocity1
if !_rc {
destring snentrustbusinessreciprocity1, replace
}
else {

}
capture confirm v snentrustbusinessintimacy
if !_rc {
destring snentrustbusinessintimacy, replace
}
else {

}
capture confirm v snrecruitworker
if !_rc {
destring snrecruitworker, replace
}
else {

}
capture confirm v snrecruitworkerdummyfam
if !_rc {
destring snrecruitworkerdummyfam, replace
}
else {

}
capture confirm v snrecruitworkerdummyhh
if !_rc {
destring snrecruitworkerdummyhh, replace
}
else {

}
capture confirm v snrecruitworkerfriend
if !_rc {
destring snrecruitworkerfriend, replace
}
else {

}
capture confirm v snrecruitworkerwkp
if !_rc {
destring snrecruitworkerwkp, replace
}
else {

}
capture confirm v snrecruitworkerlabourrelation
if !_rc {
destring snrecruitworkerlabourrelation, replace
}
else {

}
capture confirm v snrecruitworkersex
if !_rc {
destring snrecruitworkersex, replace
}
else {

}
capture confirm v snrecruitworkerage
if !_rc {
destring snrecruitworkerage, replace
}
else {

}
capture confirm v snrecruitworkerlabourtype
if !_rc {
destring snrecruitworkerlabourtype, replace
}
else {

}
capture confirm v snrecruitworkercastes
if !_rc {
destring snrecruitworkercastes, replace
}
else {

}
capture confirm v snrecruitworkereduc
if !_rc {
destring snrecruitworkereduc, replace
}
else {

}
capture confirm v snrecruitworkeremployertype
if !_rc {
destring snrecruitworkeremployertype, replace
}
else {

}
capture confirm v snrecruitworkerliving
if !_rc {
destring snrecruitworkerliving, replace
}
else {

}
capture confirm v snrecruitworkerruralurban
if !_rc {
destring snrecruitworkerruralurban, replace
}
else {

}
capture confirm v snrecruitworkerdistrict
if !_rc {
destring snrecruitworkerdistrict, replace
}
else {

}
capture confirm v snrecruitworkercompared
if !_rc {
destring snrecruitworkercompared, replace
}
else {

}
capture confirm v snrecruitworkermeet
if !_rc {
destring snrecruitworkermeet, replace
}
else {

}
capture confirm v snrecruitworkermeetfrequency
if !_rc {
destring snrecruitworkermeetfrequency, replace
}
else {

}
capture confirm v snrecruitworkerinvite
if !_rc {
destring snrecruitworkerinvite, replace
}
else {

}
capture confirm v snrecruitworkerreciprocity1
if !_rc {
destring snrecruitworkerreciprocity1, replace
}
else {

}
capture confirm v snrecruitworkerintimacy
if !_rc {
destring snrecruitworkerintimacy, replace
}
else {

}
capture confirm v snfindsuppliers
if !_rc {
destring snfindsuppliers, replace
}
else {

}
capture confirm v snfindsuppliersdummyfam
if !_rc {
destring snfindsuppliersdummyfam, replace
}
else {

}
capture confirm v snfindsuppliersdummyhh
if !_rc {
destring snfindsuppliersdummyhh, replace
}
else {

}
capture confirm v snfindsuppliersfriend
if !_rc {
destring snfindsuppliersfriend, replace
}
else {

}
capture confirm v snfindsupplierswkp
if !_rc {
destring snfindsupplierswkp, replace
}
else {

}
capture confirm v snfindsupplierslabourrelation
if !_rc {
destring snfindsupplierslabourrelation, replace
}
else {

}
capture confirm v snfindsupplierssex
if !_rc {
destring snfindsupplierssex, replace
}
else {

}
capture confirm v snfindsuppliersage
if !_rc {
destring snfindsuppliersage, replace
}
else {

}
capture confirm v snfindsupplierslabourtype
if !_rc {
destring snfindsupplierslabourtype, replace
}
else {

}
capture confirm v snfindsupplierscastes
if !_rc {
destring snfindsupplierscastes, replace
}
else {

}
capture confirm v snfindsupplierseduc
if !_rc {
destring snfindsupplierseduc, replace
}
else {

}
capture confirm v snfindsuppliersemployertype
if !_rc {
destring snfindsuppliersemployertype, replace
}
else {

}
capture confirm v snfindsuppliersliving
if !_rc {
destring snfindsuppliersliving, replace
}
else {

}
capture confirm v snfindsuppliersruralurban
if !_rc {
destring snfindsuppliersruralurban, replace
}
else {

}
capture confirm v snfindsuppliersdistrict
if !_rc {
destring snfindsuppliersdistrict, replace
}
else {

}
capture confirm v snfindsupplierscompared
if !_rc {
destring snfindsupplierscompared, replace
}
else {

}
capture confirm v snfindsuppliersmeet
if !_rc {
destring snfindsuppliersmeet, replace
}
else {

}
capture confirm v snfindsuppliersmeetfrequency
if !_rc {
destring snfindsuppliersmeetfrequency, replace
}
else {

}
capture confirm v snfindsuppliersinvite
if !_rc {
destring snfindsuppliersinvite, replace
}
else {

}
capture confirm v snfindsuppliersreciprocity1
if !_rc {
destring snfindsuppliersreciprocity1, replace
}
else {

}
capture confirm v snfindsuppliersintimacy
if !_rc {
destring snfindsuppliersintimacy, replace
}
else {

}
capture confirm v contract
if !_rc {
destring contract, replace
}
else {

}
capture confirm v wagejobtype
if !_rc {
destring wagejobtype, replace
}
else {

}
capture confirm v wagejobsocialsecurity
if !_rc {
destring wagejobsocialsecurity, replace
}
else {

}
capture confirm v jobwagefrequencycash
if !_rc {
destring jobwagefrequencycash, replace
}
else {

}
capture confirm v wagejobpaymentinkind
if !_rc {
destring wagejobpaymentinkind, replace
}
else {

}
capture confirm v wagejobpaymentinkindlist
if !_rc {
destring wagejobpaymentinkindlist, replace
}
else {

}
capture confirm v covworkeffort
if !_rc {
destring covworkeffort, replace
}
else {

}
capture confirm v decisionwork
if !_rc {
destring decisionwork, replace
}
else {

}
capture confirm v decisionearnwork
if !_rc {
destring decisionearnwork, replace
}
else {

}
capture confirm v opinionworkingwoman
if !_rc {
destring opinionworkingwoman, replace
}
else {

}
capture confirm v opinionactivewoman
if !_rc {
destring opinionactivewoman, replace
}
else {

}
capture confirm v readystartjob
if !_rc {
destring readystartjob, replace
}
else {

}
capture confirm v methodfindjob
if !_rc {
destring methodfindjob, replace
}
else {

}
capture confirm v jobpreference
if !_rc {
destring jobpreference, replace
}
else {

}
capture confirm v moveoutsideforjob
if !_rc {
destring moveoutsideforjob, replace
}
else {

}
capture confirm v dummyaspirationmorehours
if !_rc {
destring dummyaspirationmorehours, replace
}
else {

}
capture confirm v respect
if !_rc {
destring respect, replace
}
else {

}
capture confirm v workmate
if !_rc {
destring workmate, replace
}
else {

}
capture confirm v useknowledgeatwork
if !_rc {
destring useknowledgeatwork, replace
}
else {

}
capture confirm v satisfyingpurpose
if !_rc {
destring satisfyingpurpose, replace
}
else {

}
capture confirm v schedule
if !_rc {
destring schedule, replace
}
else {

}
capture confirm v takeholiday
if !_rc {
destring takeholiday, replace
}
else {

}
capture confirm v agreementatwork1
if !_rc {
destring agreementatwork1, replace
}
else {

}
capture confirm v agreementatwork2
if !_rc {
destring agreementatwork2, replace
}
else {

}
capture confirm v agreementatwork3
if !_rc {
destring agreementatwork3, replace
}
else {

}
capture confirm v agreementatwork4
if !_rc {
destring agreementatwork4, replace
}
else {

}
capture confirm v changework
if !_rc {
destring changework, replace
}
else {

}
capture confirm v happywork
if !_rc {
destring happywork, replace
}
else {

}
capture confirm v satisfactionsalary
if !_rc {
destring satisfactionsalary, replace
}
else {

}
capture confirm v executionwork1
if !_rc {
destring executionwork1, replace
}
else {

}
capture confirm v executionwork2
if !_rc {
destring executionwork2, replace
}
else {

}
capture confirm v executionwork3
if !_rc {
destring executionwork3, replace
}
else {

}
capture confirm v executionwork4
if !_rc {
destring executionwork4, replace
}
else {

}
capture confirm v executionwork5
if !_rc {
destring executionwork5, replace
}
else {

}
capture confirm v executionwork6
if !_rc {
destring executionwork6, replace
}
else {

}
capture confirm v executionwork7
if !_rc {
destring executionwork7, replace
}
else {

}
capture confirm v executionwork8
if !_rc {
destring executionwork8, replace
}
else {

}
capture confirm v executionwork9
if !_rc {
destring executionwork9, replace
}
else {

}
capture confirm v accidentalinjury
if !_rc {
destring accidentalinjury, replace
}
else {

}
capture confirm v losswork
if !_rc {
destring losswork, replace
}
else {

}
capture confirm v physicalharm
if !_rc {
destring physicalharm, replace
}
else {

}
capture confirm v problemwork1
if !_rc {
destring problemwork1, replace
}
else {

}
capture confirm v problemwork2
if !_rc {
destring problemwork2, replace
}
else {

}
capture confirm v problemwork4
if !_rc {
destring problemwork4, replace
}
else {

}
capture confirm v problemwork5
if !_rc {
destring problemwork5, replace
}
else {

}
capture confirm v problemwork6
if !_rc {
destring problemwork6, replace
}
else {

}
capture confirm v problemwork7
if !_rc {
destring problemwork7, replace
}
else {

}
capture confirm v problemwork8
if !_rc {
destring problemwork8, replace
}
else {

}
capture confirm v problemwork9
if !_rc {
destring problemwork9, replace
}
else {

}
capture confirm v problemwork10
if !_rc {
destring problemwork10, replace
}
else {

}
capture confirm v workexposure1
if !_rc {
destring workexposure1, replace
}
else {

}
capture confirm v workexposure2
if !_rc {
destring workexposure2, replace
}
else {

}
capture confirm v workexposure3
if !_rc {
destring workexposure3, replace
}
else {

}
capture confirm v workexposure4
if !_rc {
destring workexposure4, replace
}
else {

}
capture confirm v workexposure5
if !_rc {
destring workexposure5, replace
}
else {

}
capture confirm v professionalequipment
if !_rc {
destring professionalequipment, replace
}
else {

}
capture confirm v break
if !_rc {
destring break, replace
}
else {

}
capture confirm v retirementwork
if !_rc {
destring retirementwork, replace
}
else {

}
capture confirm v verbalaggression
if !_rc {
destring verbalaggression, replace
}
else {

}
capture confirm v physicalagression
if !_rc {
destring physicalagression, replace
}
else {

}
capture confirm v sexualharassment
if !_rc {
destring sexualharassment, replace
}
else {

}
capture confirm v sexualaggression
if !_rc {
destring sexualaggression, replace
}
else {

}
capture confirm v discrimination1
if !_rc {
destring discrimination1, replace
}
else {

}
capture confirm v discrimination2
if !_rc {
destring discrimination2, replace
}
else {

}
capture confirm v discrimination3
if !_rc {
destring discrimination3, replace
}
else {

}
capture confirm v discrimination4
if !_rc {
destring discrimination4, replace
}
else {

}
capture confirm v discrimination5
if !_rc {
destring discrimination5, replace
}
else {

}
capture confirm v discrimination6
if !_rc {
destring discrimination6, replace
}
else {

}
capture confirm v discrimination7
if !_rc {
destring discrimination7, replace
}
else {

}
capture confirm v discrimination8
if !_rc {
destring discrimination8, replace
}
else {

}
capture confirm v discrimination9
if !_rc {
destring discrimination9, replace
}
else {

}
capture confirm v resdiscrimination1
if !_rc {
destring resdiscrimination1, replace
}
else {

}
capture confirm v resdiscrimination2
if !_rc {
destring resdiscrimination2, replace
}
else {

}
capture confirm v resdiscrimination3
if !_rc {
destring resdiscrimination3, replace
}
else {

}
capture confirm v resdiscrimination4
if !_rc {
destring resdiscrimination4, replace
}
else {

}
capture confirm v resdiscrimination5
if !_rc {
destring resdiscrimination5, replace
}
else {

}
capture confirm v rurallocation
if !_rc {
destring rurallocation, replace
}
else {

}
capture confirm v lackskill
if !_rc {
destring lackskill, replace
}
else {

}
capture confirm v A1
if !_rc {
destring A1, replace
}
else {

}
capture confirm v A2
if !_rc {
destring A2, replace
}
else {

}
capture confirm v A3
if !_rc {
destring A3, replace
}
else {

}
capture confirm v A4
if !_rc {
destring A4, replace
}
else {

}
capture confirm v A5
if !_rc {
destring A5, replace
}
else {

}
capture confirm v A6
if !_rc {
destring A6, replace
}
else {

}
capture confirm v A7
if !_rc {
destring A7, replace
}
else {

}
capture confirm v A8
if !_rc {
destring A8, replace
}
else {

}
capture confirm v A9
if !_rc {
destring A9, replace
}
else {

}
capture confirm v A10
if !_rc {
destring A10, replace
}
else {

}
capture confirm v A11
if !_rc {
destring A11, replace
}
else {

}
capture confirm v A12
if !_rc {
destring A12, replace
}
else {

}
capture confirm v locuscontrol1
if !_rc {
destring locuscontrol1, replace
}
else {

}
capture confirm v locuscontrol2
if !_rc {
destring locuscontrol2, replace
}
else {

}
capture confirm v locuscontrol3
if !_rc {
destring locuscontrol3, replace
}
else {

}
capture confirm v locuscontrol4
if !_rc {
destring locuscontrol4, replace
}
else {

}
capture confirm v locuscontrol5
if !_rc {
destring locuscontrol5, replace
}
else {

}
capture confirm v locuscontrol6
if !_rc {
destring locuscontrol6, replace
}
else {

}
capture confirm v assodegreeparticip
if !_rc {
destring assodegreeparticip, replace
}
else {

}
capture confirm v assosize
if !_rc {
destring assosize, replace
}
else {

}
capture confirm v dummyassorecommendation
if !_rc {
destring dummyassorecommendation, replace
}
else {

}
capture confirm v snrecommendassodummyfam
if !_rc {
destring snrecommendassodummyfam, replace
}
else {

}
capture confirm v snrecommendassodummyhh
if !_rc {
destring snrecommendassodummyhh, replace
}
else {

}
capture confirm v snrecommendassofriend
if !_rc {
destring snrecommendassofriend, replace
}
else {

}
capture confirm v snrecommendassowkp
if !_rc {
destring snrecommendassowkp, replace
}
else {

}
capture confirm v snrecommendassolabourrelation
if !_rc {
destring snrecommendassolabourrelation, replace
}
else {

}
capture confirm v snrecommendassosex
if !_rc {
destring snrecommendassosex, replace
}
else {

}
capture confirm v snrecommendassoage
if !_rc {
destring snrecommendassoage, replace
}
else {

}
capture confirm v snrecommendassolabourtype
if !_rc {
destring snrecommendassolabourtype, replace
}
else {

}
capture confirm v snrecommendassocastes
if !_rc {
destring snrecommendassocastes, replace
}
else {

}
capture confirm v snrecommendassoeduc
if !_rc {
destring snrecommendassoeduc, replace
}
else {

}
capture confirm v snrecommendassoemployertype
if !_rc {
destring snrecommendassoemployertype, replace
}
else {

}
capture confirm v snrecommendassoliving
if !_rc {
destring snrecommendassoliving, replace
}
else {

}
capture confirm v snrecommendassoruralurban
if !_rc {
destring snrecommendassoruralurban, replace
}
else {

}
capture confirm v snrecommendassodistrict
if !_rc {
destring snrecommendassodistrict, replace
}
else {

}
capture confirm v snrecommendassocompared
if !_rc {
destring snrecommendassocompared, replace
}
else {

}
capture confirm v snrecommendassomeet
if !_rc {
destring snrecommendassomeet, replace
}
else {

}
capture confirm v snrecommendassomeetfrequency
if !_rc {
destring snrecommendassomeetfrequency, replace
}
else {

}
capture confirm v snrecommendassoinvite
if !_rc {
destring snrecommendassoinvite, replace
}
else {

}
capture confirm v snrecommendassoreciprocity1
if !_rc {
destring snrecommendassoreciprocity1, replace
}
else {

}
capture confirm v snrecommendassointimacy
if !_rc {
destring snrecommendassointimacy, replace
}
else {

}
capture confirm v dummyassohelpjob
if !_rc {
destring dummyassohelpjob, replace
}
else {

}
capture confirm v assohelpjob
if !_rc {
destring assohelpjob, replace
}
else {

}
capture confirm v dummyassohelpbusiness
if !_rc {
destring dummyassohelpbusiness, replace
}
else {

}
capture confirm v assohelpbusiness
if !_rc {
destring assohelpbusiness, replace
}
else {

}
capture confirm v snfindcurrentjob
if !_rc {
destring snfindcurrentjob, replace
}
else {

}
capture confirm v snfindcurrentjobdummyfam
if !_rc {
destring snfindcurrentjobdummyfam, replace
}
else {

}
capture confirm v snfindcurrentjobdummyhh
if !_rc {
destring snfindcurrentjobdummyhh, replace
}
else {

}
capture confirm v snfindcurrentjobfriend
if !_rc {
destring snfindcurrentjobfriend, replace
}
else {

}
capture confirm v snfindcurrentjobwkp
if !_rc {
destring snfindcurrentjobwkp, replace
}
else {

}
capture confirm v snfindcurrentjoblabourrelation
if !_rc {
destring snfindcurrentjoblabourrelation, replace
}
else {

}
capture confirm v snfindcurrentjobsex
if !_rc {
destring snfindcurrentjobsex, replace
}
else {

}
capture confirm v snfindcurrentjobage
if !_rc {
destring snfindcurrentjobage, replace
}
else {

}
capture confirm v snfindcurrentjoblabourtype
if !_rc {
destring snfindcurrentjoblabourtype, replace
}
else {

}
capture confirm v snfindcurrentjobcastes
if !_rc {
destring snfindcurrentjobcastes, replace
}
else {

}
capture confirm v snfindcurrentjobeduc
if !_rc {
destring snfindcurrentjobeduc, replace
}
else {

}
capture confirm v snfindcurrentjobemployertype
if !_rc {
destring snfindcurrentjobemployertype, replace
}
else {

}
capture confirm v snfindcurrentjobliving
if !_rc {
destring snfindcurrentjobliving, replace
}
else {

}
capture confirm v snfindcurrentjobruralurban
if !_rc {
destring snfindcurrentjobruralurban, replace
}
else {

}
capture confirm v snfindcurrentjobdistrict
if !_rc {
destring snfindcurrentjobdistrict, replace
}
else {

}
capture confirm v snfindcurrentjobcompared
if !_rc {
destring snfindcurrentjobcompared, replace
}
else {

}
capture confirm v snfindcurrentjobmeet
if !_rc {
destring snfindcurrentjobmeet, replace
}
else {

}
capture confirm v snfindcurrentjobmeetfrequency
if !_rc {
destring snfindcurrentjobmeetfrequency, replace
}
else {

}
capture confirm v snfindcurrentjobinvite
if !_rc {
destring snfindcurrentjobinvite, replace
}
else {

}
capture confirm v snfindcurrentjobreciprocity1
if !_rc {
destring snfindcurrentjobreciprocity1, replace
}
else {

}
capture confirm v snfindcurrentjobintimacy
if !_rc {
destring snfindcurrentjobintimacy, replace
}
else {

}
capture confirm v snfindjob
if !_rc {
destring snfindjob, replace
}
else {

}
capture confirm v snfindjobdummyfam
if !_rc {
destring snfindjobdummyfam, replace
}
else {

}
capture confirm v snfindjobdummyhh
if !_rc {
destring snfindjobdummyhh, replace
}
else {

}
capture confirm v snfindjobfriend
if !_rc {
destring snfindjobfriend, replace
}
else {

}
capture confirm v snfindjobwkp
if !_rc {
destring snfindjobwkp, replace
}
else {

}
capture confirm v snfindjoblabourrelation
if !_rc {
destring snfindjoblabourrelation, replace
}
else {

}
capture confirm v snfindjobsex
if !_rc {
destring snfindjobsex, replace
}
else {

}
capture confirm v snfindjobage
if !_rc {
destring snfindjobage, replace
}
else {

}
capture confirm v snfindjoblabourtype
if !_rc {
destring snfindjoblabourtype, replace
}
else {

}
capture confirm v snfindjobcastes
if !_rc {
destring snfindjobcastes, replace
}
else {

}
capture confirm v snfindjobeduc
if !_rc {
destring snfindjobeduc, replace
}
else {

}
capture confirm v snfindjobemployertype
if !_rc {
destring snfindjobemployertype, replace
}
else {

}
capture confirm v snfindjobliving
if !_rc {
destring snfindjobliving, replace
}
else {

}
capture confirm v snfindjobruralurban
if !_rc {
destring snfindjobruralurban, replace
}
else {

}
capture confirm v snfindjobdistrict
if !_rc {
destring snfindjobdistrict, replace
}
else {

}
capture confirm v snfindjobcompared
if !_rc {
destring snfindjobcompared, replace
}
else {

}
capture confirm v snfindjobmeet
if !_rc {
destring snfindjobmeet, replace
}
else {

}
capture confirm v snfindjobmeetfrequency
if !_rc {
destring snfindjobmeetfrequency, replace
}
else {

}
capture confirm v snfindjobinvite
if !_rc {
destring snfindjobinvite, replace
}
else {

}
capture confirm v snfindjobreciprocity1
if !_rc {
destring snfindjobreciprocity1, replace
}
else {

}
capture confirm v snfindjobintimacy
if !_rc {
destring snfindjobintimacy, replace
}
else {

}
capture confirm v snrecommendforjob
if !_rc {
destring snrecommendforjob, replace
}
else {

}
capture confirm v snrecommendforjobdummyfam
if !_rc {
destring snrecommendforjobdummyfam, replace
}
else {

}
capture confirm v snrecommendforjobdummyhh
if !_rc {
destring snrecommendforjobdummyhh, replace
}
else {

}
capture confirm v snrecommendforjobfriend
if !_rc {
destring snrecommendforjobfriend, replace
}
else {

}
capture confirm v snrecommendforjobwkp
if !_rc {
destring snrecommendforjobwkp, replace
}
else {

}
capture confirm v snrecommendforjoblabourrelation
if !_rc {
destring snrecommendforjoblabourrelation, replace
}
else {

}
capture confirm v snrecommendforjobsex
if !_rc {
destring snrecommendforjobsex, replace
}
else {

}
capture confirm v snrecommendforjobage
if !_rc {
destring snrecommendforjobage, replace
}
else {

}
capture confirm v snrecommendforjoblabourtype
if !_rc {
destring snrecommendforjoblabourtype, replace
}
else {

}
capture confirm v snrecommendforjobcastes
if !_rc {
destring snrecommendforjobcastes, replace
}
else {

}
capture confirm v snrecommendforjobeduc
if !_rc {
destring snrecommendforjobeduc, replace
}
else {

}
capture confirm v snrecommendforjobemployertype
if !_rc {
destring snrecommendforjobemployertype, replace
}
else {

}
capture confirm v snrecommendforjobliving
if !_rc {
destring snrecommendforjobliving, replace
}
else {

}
capture confirm v snrecommendforjobruralurban
if !_rc {
destring snrecommendforjobruralurban, replace
}
else {

}
capture confirm v snrecommendforjobdistrict
if !_rc {
destring snrecommendforjobdistrict, replace
}
else {

}
capture confirm v snrecommendforjobcompared
if !_rc {
destring snrecommendforjobcompared, replace
}
else {

}
capture confirm v snrecommendforjobmeet
if !_rc {
destring snrecommendforjobmeet, replace
}
else {

}
capture confirm v snrecommendforjobmeetfrequency
if !_rc {
destring snrecommendforjobmeetfrequency, replace
}
else {

}
capture confirm v snrecommendforjobinvite
if !_rc {
destring snrecommendforjobinvite, replace
}
else {

}
capture confirm v snrecommendforjobreciprocity1
if !_rc {
destring snrecommendforjobreciprocity1, replace
}
else {

}
capture confirm v snrecommendforjobintimacy
if !_rc {
destring snrecommendforjobintimacy, replace
}
else {

}
capture confirm v snrecojobsuccess
if !_rc {
destring snrecojobsuccess, replace
}
else {

}
capture confirm v snrecojobsuccessdummyfam
if !_rc {
destring snrecojobsuccessdummyfam, replace
}
else {

}
capture confirm v snrecojobsuccessdummyhh
if !_rc {
destring snrecojobsuccessdummyhh, replace
}
else {

}
capture confirm v snrecojobsuccessfriend
if !_rc {
destring snrecojobsuccessfriend, replace
}
else {

}
capture confirm v snrecojobsuccesswkp
if !_rc {
destring snrecojobsuccesswkp, replace
}
else {

}
capture confirm v snrecojobsuccesslabourrelation
if !_rc {
destring snrecojobsuccesslabourrelation, replace
}
else {

}
capture confirm v snrecojobsuccesssex
if !_rc {
destring snrecojobsuccesssex, replace
}
else {

}
capture confirm v snrecojobsuccessage
if !_rc {
destring snrecojobsuccessage, replace
}
else {

}
capture confirm v snrecojobsuccesslabourtype
if !_rc {
destring snrecojobsuccesslabourtype, replace
}
else {

}
capture confirm v snrecojobsuccesscastes
if !_rc {
destring snrecojobsuccesscastes, replace
}
else {

}
capture confirm v snrecojobsuccesseduc
if !_rc {
destring snrecojobsuccesseduc, replace
}
else {

}
capture confirm v snrecojobsuccessemployertype
if !_rc {
destring snrecojobsuccessemployertype, replace
}
else {

}
capture confirm v snrecojobsuccessliving
if !_rc {
destring snrecojobsuccessliving, replace
}
else {

}
capture confirm v snrecojobsuccessruralurban
if !_rc {
destring snrecojobsuccessruralurban, replace
}
else {

}
capture confirm v snrecojobsuccessdistrict
if !_rc {
destring snrecojobsuccessdistrict, replace
}
else {

}
capture confirm v snrecojobsuccesscompared
if !_rc {
destring snrecojobsuccesscompared, replace
}
else {

}
capture confirm v snrecojobsuccessmeet
if !_rc {
destring snrecojobsuccessmeet, replace
}
else {

}
capture confirm v snrecojobsuccessmeetfrequency
if !_rc {
destring snrecojobsuccessmeetfrequency, replace
}
else {

}
capture confirm v snrecojobsuccessinvite
if !_rc {
destring snrecojobsuccessinvite, replace
}
else {

}
capture confirm v snrecojobsuccessreciprocity1
if !_rc {
destring snrecojobsuccessreciprocity1, replace
}
else {

}
capture confirm v snrecojobsuccessintimacy
if !_rc {
destring snrecojobsuccessintimacy, replace
}
else {

}
capture confirm v sntalkthemostfriend
if !_rc {
destring sntalkthemostfriend, replace
}
else {

}
capture confirm v sntalkthemostwkp
if !_rc {
destring sntalkthemostwkp, replace
}
else {

}
capture confirm v sntalkthemostlabourrelation
if !_rc {
destring sntalkthemostlabourrelation, replace
}
else {

}
capture confirm v sntalkthemostsex
if !_rc {
destring sntalkthemostsex, replace
}
else {

}
capture confirm v sntalkthemostage
if !_rc {
destring sntalkthemostage, replace
}
else {

}
capture confirm v sntalkthemostlabourtype
if !_rc {
destring sntalkthemostlabourtype, replace
}
else {

}
capture confirm v sntalkthemostcastes
if !_rc {
destring sntalkthemostcastes, replace
}
else {

}
capture confirm v sntalkthemosteduc
if !_rc {
destring sntalkthemosteduc, replace
}
else {

}
capture confirm v sntalkthemostemployertype
if !_rc {
destring sntalkthemostemployertype, replace
}
else {

}
capture confirm v sntalkthemostliving
if !_rc {
destring sntalkthemostliving, replace
}
else {

}
capture confirm v sntalkthemostruralurban
if !_rc {
destring sntalkthemostruralurban, replace
}
else {

}
capture confirm v sntalkthemostdistrict
if !_rc {
destring sntalkthemostdistrict, replace
}
else {

}
capture confirm v sntalkthemostcompared
if !_rc {
destring sntalkthemostcompared, replace
}
else {

}
capture confirm v sntalkthemostmeet
if !_rc {
destring sntalkthemostmeet, replace
}
else {

}
capture confirm v sntalkthemostmeetfrequency
if !_rc {
destring sntalkthemostmeetfrequency, replace
}
else {

}
capture confirm v sntalkthemostinvite
if !_rc {
destring sntalkthemostinvite, replace
}
else {

}
capture confirm v sntalkthemostreciprocity1
if !_rc {
destring sntalkthemostreciprocity1, replace
}
else {

}
capture confirm v sntalkthemostintimacy
if !_rc {
destring sntalkthemostintimacy, replace
}
else {

}
capture confirm v snhelpemergencydummyfam
if !_rc {
destring snhelpemergencydummyfam, replace
}
else {

}
capture confirm v snhelpemergencydummyhh
if !_rc {
destring snhelpemergencydummyhh, replace
}
else {

}
capture confirm v snhelpemergencyfriend
if !_rc {
destring snhelpemergencyfriend, replace
}
else {

}
capture confirm v snhelpemergencywkp
if !_rc {
destring snhelpemergencywkp, replace
}
else {

}
capture confirm v snhelpemergencylabourrelation
if !_rc {
destring snhelpemergencylabourrelation, replace
}
else {

}
capture confirm v snhelpemergencysex
if !_rc {
destring snhelpemergencysex, replace
}
else {

}
capture confirm v snhelpemergencyage
if !_rc {
destring snhelpemergencyage, replace
}
else {

}
capture confirm v snhelpemergencylabourtype
if !_rc {
destring snhelpemergencylabourtype, replace
}
else {

}
capture confirm v snhelpemergencycastes
if !_rc {
destring snhelpemergencycastes, replace
}
else {

}
capture confirm v snhelpemergencyeduc
if !_rc {
destring snhelpemergencyeduc, replace
}
else {

}
capture confirm v snhelpemergencyemployertype
if !_rc {
destring snhelpemergencyemployertype, replace
}
else {

}
capture confirm v snhelpemergencyliving
if !_rc {
destring snhelpemergencyliving, replace
}
else {

}
capture confirm v snhelpemergencyruralurban
if !_rc {
destring snhelpemergencyruralurban, replace
}
else {

}
capture confirm v snhelpemergencydistrict
if !_rc {
destring snhelpemergencydistrict, replace
}
else {

}
capture confirm v snhelpemergencycompared
if !_rc {
destring snhelpemergencycompared, replace
}
else {

}
capture confirm v snhelpemergencymeet
if !_rc {
destring snhelpemergencymeet, replace
}
else {

}
capture confirm v snhelpemergencymeetfrequency
if !_rc {
destring snhelpemergencymeetfrequency, replace
}
else {

}
capture confirm v snhelpemergencyinvite
if !_rc {
destring snhelpemergencyinvite, replace
}
else {

}
capture confirm v snhelpemergencyreciprocity1
if !_rc {
destring snhelpemergencyreciprocity1, replace
}
else {

}
capture confirm v snhelpemergencyintimacy
if !_rc {
destring snhelpemergencyintimacy, replace
}
else {

}
capture confirm v sncloserelouthhdummyfam
if !_rc {
destring sncloserelouthhdummyfam, replace
}
else {

}
capture confirm v sncloserelouthhfriend
if !_rc {
destring sncloserelouthhfriend, replace
}
else {

}
capture confirm v sncloserelouthhwkp
if !_rc {
destring sncloserelouthhwkp, replace
}
else {

}
capture confirm v sncloserelouthhlabourrelation
if !_rc {
destring sncloserelouthhlabourrelation, replace
}
else {

}
capture confirm v sncloserelouthhsex
if !_rc {
destring sncloserelouthhsex, replace
}
else {

}
capture confirm v sncloserelouthhage
if !_rc {
destring sncloserelouthhage, replace
}
else {

}
capture confirm v sncloserelouthhlabourtype
if !_rc {
destring sncloserelouthhlabourtype, replace
}
else {

}
capture confirm v sncloserelouthhcastes
if !_rc {
destring sncloserelouthhcastes, replace
}
else {

}
capture confirm v sncloserelouthheduc
if !_rc {
destring sncloserelouthheduc, replace
}
else {

}
capture confirm v sncloserelouthhemployertype
if !_rc {
destring sncloserelouthhemployertype, replace
}
else {

}
capture confirm v sncloserelouthhliving
if !_rc {
destring sncloserelouthhliving, replace
}
else {

}
capture confirm v sncloserelouthhruralurban
if !_rc {
destring sncloserelouthhruralurban, replace
}
else {

}
capture confirm v sncloserelouthhdistrict
if !_rc {
destring sncloserelouthhdistrict, replace
}
else {

}
capture confirm v sncloserelouthhcompared
if !_rc {
destring sncloserelouthhcompared, replace
}
else {

}
capture confirm v sncloserelouthhmeet
if !_rc {
destring sncloserelouthhmeet, replace
}
else {

}
capture confirm v sncloserelouthhmeetfrequency
if !_rc {
destring sncloserelouthhmeetfrequency, replace
}
else {

}
capture confirm v sncloserelouthhinvite
if !_rc {
destring sncloserelouthhinvite, replace
}
else {

}
capture confirm v sncloserelouthhreciprocity1
if !_rc {
destring sncloserelouthhreciprocity1, replace
}
else {

}
capture confirm v sncloserelouthhintimacy
if !_rc {
destring sncloserelouthhintimacy, replace
}
else {

}
capture confirm v nbercontactphone
if !_rc {
destring nbercontactphone, replace
}
else {

}
capture confirm v dummycontactleaders
if !_rc {
destring dummycontactleaders, replace
}
else {

}
capture confirm v networktrustneighborhood
if !_rc {
destring networktrustneighborhood, replace
}
else {

}
capture confirm v covneworktrustneighborhood
if !_rc {
destring covneworktrustneighborhood, replace
}
else {

}
capture confirm v networktrustemployees
if !_rc {
destring networktrustemployees, replace
}
else {

}
capture confirm v networkpeoplehelping
if !_rc {
destring networkpeoplehelping, replace
}
else {

}
capture confirm v covnetworkpeoplehelping
if !_rc {
destring covnetworkpeoplehelping, replace
}
else {

}
capture confirm v networkhelpkinmember
if !_rc {
destring networkhelpkinmember, replace
}
else {

}
capture confirm v covnetworkhelpkinmember
if !_rc {
destring covnetworkhelpkinmember, replace
}
else {

}
capture confirm v covinstit1
if !_rc {
destring covinstit1, replace
}
else {

}
capture confirm v covinstit2
if !_rc {
destring covinstit2, replace
}
else {

}
capture confirm v covinstit3
if !_rc {
destring covinstit3, replace
}
else {

}
capture confirm v covinstit4
if !_rc {
destring covinstit4, replace
}
else {

}
capture confirm v covinstit5
if !_rc {
destring covinstit5, replace
}
else {

}
capture confirm v covcontactinstitution
if !_rc {
destring covcontactinstitution, replace
}
else {

}
capture confirm v covinstit6
if !_rc {
destring covinstit6, replace
}
else {

}
capture confirm v covinstit7
if !_rc {
destring covinstit7, replace
}
else {

}
capture confirm v covinstit8
if !_rc {
destring covinstit8, replace
}
else {

}
capture confirm v covinstit9
if !_rc {
destring covinstit9, replace
}
else {

}
capture confirm v covinstit10
if !_rc {
destring covinstit10, replace
}
else {

}
capture confirm v B1
if !_rc {
destring B1, replace
}
else {

}
capture confirm v B2
if !_rc {
destring B2, replace
}
else {

}
capture confirm v B3
if !_rc {
destring B3, replace
}
else {

}
capture confirm v B4
if !_rc {
destring B4, replace
}
else {

}
capture confirm v B5
if !_rc {
destring B5, replace
}
else {

}
capture confirm v B6
if !_rc {
destring B6, replace
}
else {

}
capture confirm v B7
if !_rc {
destring B7, replace
}
else {

}
capture confirm v B8
if !_rc {
destring B8, replace
}
else {

}
capture confirm v B9
if !_rc {
destring B9, replace
}
else {

}
capture confirm v B10
if !_rc {
destring B10, replace
}
else {

}
capture confirm v B11
if !_rc {
destring B11, replace
}
else {

}
capture confirm v B12
if !_rc {
destring B12, replace
}
else {

}
capture confirm v enjoypeople
if !_rc {
destring enjoypeople, replace
}
else {

}
capture confirm v curious
if !_rc {
destring curious, replace
}
else {

}
capture confirm v organized
if !_rc {
destring organized, replace
}
else {

}
capture confirm v managestress
if !_rc {
destring managestress, replace
}
else {

}
capture confirm v interestedbyart
if !_rc {
destring interestedbyart, replace
}
else {

}
capture confirm v tryhard
if !_rc {
destring tryhard, replace
}
else {

}
capture confirm v workwithother
if !_rc {
destring workwithother, replace
}
else {

}
capture confirm v makeplans
if !_rc {
destring makeplans, replace
}
else {

}
capture confirm v sharefeelings
if !_rc {
destring sharefeelings, replace
}
else {

}
capture confirm v nervous
if !_rc {
destring nervous, replace
}
else {

}
capture confirm v stickwithgoals
if !_rc {
destring stickwithgoals, replace
}
else {

}
capture confirm v repetitivetasks
if !_rc {
destring repetitivetasks, replace
}
else {

}
capture confirm v shywithpeople
if !_rc {
destring shywithpeople, replace
}
else {

}
capture confirm v workhard
if !_rc {
destring workhard, replace
}
else {

}
capture confirm v changemood
if !_rc {
destring changemood, replace
}
else {

}
capture confirm v understandotherfeeling
if !_rc {
destring understandotherfeeling, replace
}
else {

}
capture confirm v inventive
if !_rc {
destring inventive, replace
}
else {

}
capture confirm v enthusiastic
if !_rc {
destring enthusiastic, replace
}
else {

}
capture confirm v feeldepressed
if !_rc {
destring feeldepressed, replace
}
else {

}
capture confirm v appointmentontime
if !_rc {
destring appointmentontime, replace
}
else {

}
capture confirm v trustingofother
if !_rc {
destring trustingofother, replace
}
else {

}
capture confirm v goaftergoal
if !_rc {
destring goaftergoal, replace
}
else {

}
capture confirm v easilyupset
if !_rc {
destring easilyupset, replace
}
else {

}
capture confirm v talktomanypeople
if !_rc {
destring talktomanypeople, replace
}
else {

}
capture confirm v liketothink
if !_rc {
destring liketothink, replace
}
else {

}
capture confirm v finishwhatbegin
if !_rc {
destring finishwhatbegin, replace
}
else {

}
capture confirm v putoffduties
if !_rc {
destring putoffduties, replace
}
else {

}
capture confirm v rudetoother
if !_rc {
destring rudetoother, replace
}
else {

}
capture confirm v finishtasks
if !_rc {
destring finishtasks, replace
}
else {

}
capture confirm v toleratefaults
if !_rc {
destring toleratefaults, replace
}
else {

}
capture confirm v worryalot
if !_rc {
destring worryalot, replace
}
else {

}
capture confirm v easilydistracted
if !_rc {
destring easilydistracted, replace
}
else {

}
capture confirm v keepworking
if !_rc {
destring keepworking, replace
}
else {

}
capture confirm v completeduties
if !_rc {
destring completeduties, replace
}
else {

}
capture confirm v talkative
if !_rc {
destring talkative, replace
}
else {

}
capture confirm v newideas
if !_rc {
destring newideas, replace
}
else {

}
capture confirm v staycalm
if !_rc {
destring staycalm, replace
}
else {

}
capture confirm v forgiveother
if !_rc {
destring forgiveother, replace
}
else {

}
capture confirm v activeimagination
if !_rc {
destring activeimagination, replace
}
else {

}
capture confirm v expressingthoughts
if !_rc {
destring expressingthoughts, replace
}
else {

}
capture confirm v helpfulwithothers
if !_rc {
destring helpfulwithothers, replace
}
else {

}
capture confirm v canreadcard1a
if !_rc {
destring canreadcard1a, replace
}
else {

}
capture confirm v canreadcard1b
if !_rc {
destring canreadcard1b, replace
}
else {

}
capture confirm v canreadcard1c
if !_rc {
destring canreadcard1c, replace
}
else {

}
capture confirm v canreadcard2
if !_rc {
destring canreadcard2, replace
}
else {

}
capture confirm v numeracy1
if !_rc {
destring numeracy1, replace
}
else {

}
capture confirm v numeracy2
if !_rc {
destring numeracy2, replace
}
else {

}
capture confirm v numeracy5
if !_rc {
destring numeracy5, replace
}
else {

}
capture confirm v numeracy6
if !_rc {
destring numeracy6, replace
}
else {

}
capture confirm v numeracy3
if !_rc {
destring numeracy3, replace
}
else {

}
capture confirm v numeracy4
if !_rc {
destring numeracy4, replace
}
else {

}
capture confirm v Ab1
if !_rc {
destring Ab1, replace
}
else {

}
capture confirm v Ab2
if !_rc {
destring Ab2, replace
}
else {

}
capture confirm v Ab3
if !_rc {
destring Ab3, replace
}
else {

}
capture confirm v Ab4
if !_rc {
destring Ab4, replace
}
else {

}
capture confirm v Ab5
if !_rc {
destring Ab5, replace
}
else {

}
capture confirm v Ab6
if !_rc {
destring Ab6, replace
}
else {

}
capture confirm v Ab7
if !_rc {
destring Ab7, replace
}
else {

}
capture confirm v Ab8
if !_rc {
destring Ab8, replace
}
else {

}
capture confirm v Ab9
if !_rc {
destring Ab9, replace
}
else {

}
capture confirm v Ab10
if !_rc {
destring Ab10, replace
}
else {

}
capture confirm v Ab11
if !_rc {
destring Ab11, replace
}
else {

}
capture confirm v Ab12
if !_rc {
destring Ab12, replace
}
else {

}
capture confirm v ego2random_1
if !_rc {
destring ego2random_1, replace
}
else {

}
capture confirm v ego2random_2
if !_rc {
destring ego2random_2, replace
}
else {

}
capture confirm v ego2random_3
if !_rc {
destring ego2random_3, replace
}
else {

}
capture confirm v ego2random_1_2
if !_rc {
destring ego2random_1_2, replace
}
else {

}
capture confirm v ego2random_2_2
if !_rc {
destring ego2random_2_2, replace
}
else {

}
capture confirm v ego2random_3_2
if !_rc {
destring ego2random_3_2, replace
}
else {

}
capture confirm v ego2random_1_3
if !_rc {
destring ego2random_1_3, replace
}
else {

}
capture confirm v ego2random_2_3
if !_rc {
destring ego2random_2_3, replace
}
else {

}
capture confirm v ego2random_3_3
if !_rc {
destring ego2random_3_3, replace
}
else {

}
capture confirm v _2everwork
if !_rc {
destring _2everwork, replace
}
else {

}
capture confirm v _2workpastsevendays
if !_rc {
destring _2workpastsevendays, replace
}
else {

}
capture confirm v _2searchjob
if !_rc {
destring _2searchjob, replace
}
else {

}
capture confirm v _2startbusiness
if !_rc {
destring _2startbusiness, replace
}
else {

}
capture confirm v _2reasondontsearchjob
if !_rc {
destring _2reasondontsearchjob, replace
}
else {

}
capture confirm v _2searchjobsince15
if !_rc {
destring _2searchjobsince15, replace
}
else {

}
capture confirm v _2reasondontsearchjobsince15
if !_rc {
destring _2reasondontsearchjobsince15, replace
}
else {

}
capture confirm v _2nbermonthsearchjob
if !_rc {
destring _2nbermonthsearchjob, replace
}
else {

}
capture confirm v _2methodfindfirstjob
if !_rc {
destring _2methodfindfirstjob, replace
}
else {

}
capture confirm v _2jobfirstwagefrequencycash
if !_rc {
destring _2jobfirstwagefrequencycash, replace
}
else {

}
capture confirm v _2dummymainoccupation2
if !_rc {
destring _2dummymainoccupation2, replace
}
else {

}
capture confirm v _2dummyseasonalmainoccup
if !_rc {
destring _2dummyseasonalmainoccup, replace
}
else {

}
capture confirm v _2dummypreviouswagejob
if !_rc {
destring _2dummypreviouswagejob, replace
}
else {

}
capture confirm v _2previousjobcontract
if !_rc {
destring _2previousjobcontract, replace
}
else {

}
capture confirm v _2reasonstoppedwagejob
if !_rc {
destring _2reasonstoppedwagejob, replace
}
else {

}
capture confirm v _2businesslossinvest
if !_rc {
destring _2businesslossinvest, replace
}
else {

}
capture confirm v _2covdifficulties
if !_rc {
destring _2covdifficulties, replace
}
else {

}
capture confirm v _2castebusinesslender
if !_rc {
destring _2castebusinesslender, replace
}
else {

}
capture confirm v _2sexbusinesslender
if !_rc {
destring _2sexbusinesslender, replace
}
else {

}
capture confirm v _2agebusinesslender
if !_rc {
destring _2agebusinesslender, replace
}
else {

}
capture confirm v _2educbusinesslender
if !_rc {
destring _2educbusinesslender, replace
}
else {

}
capture confirm v _2livingbusinesslender
if !_rc {
destring _2livingbusinesslender, replace
}
else {

}
capture confirm v _2comparedbusinesslender
if !_rc {
destring _2comparedbusinesslender, replace
}
else {

}
capture confirm v _2meetbusinesslender
if !_rc {
destring _2meetbusinesslender, replace
}
else {

}
capture confirm v _2meetfrequemcybusinesslender
if !_rc {
destring _2meetfrequemcybusinesslender, replace
}
else {

}
capture confirm v _2invitebusinesslender
if !_rc {
destring _2invitebusinesslender, replace
}
else {

}
capture confirm v _2reciprocity1businesslender
if !_rc {
destring _2reciprocity1businesslender, replace
}
else {

}
capture confirm v _2intimacybusinesslender
if !_rc {
destring _2intimacybusinesslender, replace
}
else {

}
capture confirm v _2businessnbworkers
if !_rc {
destring _2businessnbworkers, replace
}
else {

}
capture confirm v _2dummybusinessunpaidworkers
if !_rc {
destring _2dummybusinessunpaidworkers, replace
}
else {

}
capture confirm v _2businessnbunpaidworkers
if !_rc {
destring _2businessnbunpaidworkers, replace
}
else {

}
capture confirm v _2dummybusinesspaidworkers
if !_rc {
destring _2dummybusinesspaidworkers, replace
}
else {

}
capture confirm v _2businessnbpaidworkers
if !_rc {
destring _2businessnbpaidworkers, replace
}
else {

}
capture confirm v _2businessworkersfrequencypayment
if !_rc {
destring _2businessworkersfrequencypayment, replace
}
else {

}
capture confirm v _2frequencygrossreceipt
if !_rc {
destring _2frequencygrossreceipt, replace
}
else {

}
capture confirm v _2businesssocialsecurity
if !_rc {
destring _2businesssocialsecurity, replace
}
else {

}
capture confirm v _2businesspaymentinkind
if !_rc {
destring _2businesspaymentinkind, replace
}
else {

}
capture confirm v _2businesspaymentinkindlist
if !_rc {
destring _2businesspaymentinkindlist, replace
}
else {

}
capture confirm v _2snentrustbusiness
if !_rc {
destring _2snentrustbusiness, replace
}
else {

}
capture confirm v _2snentrustbusinessdummyfam
if !_rc {
destring _2snentrustbusinessdummyfam, replace
}
else {

}
capture confirm v _2snentrustbusinessdummyhh
if !_rc {
destring _2snentrustbusinessdummyhh, replace
}
else {

}
capture confirm v _2snentrustbusinessfriend
if !_rc {
destring _2snentrustbusinessfriend, replace
}
else {

}
capture confirm v _2snentrustbusinesswkp
if !_rc {
destring _2snentrustbusinesswkp, replace
}
else {

}
capture confirm v _2snentrustbusinesslabourrelation
if !_rc {
destring _2snentrustbusinesslabourrelation, replace
}
else {

}
capture confirm v _2snentrustbusinesssex
if !_rc {
destring _2snentrustbusinesssex, replace
}
else {

}
capture confirm v _2snentrustbusinessage
if !_rc {
destring _2snentrustbusinessage, replace
}
else {

}
capture confirm v _2snentrustbusinesslabourtype
if !_rc {
destring _2snentrustbusinesslabourtype, replace
}
else {

}
capture confirm v _2snentrustbusinesscastes
if !_rc {
destring _2snentrustbusinesscastes, replace
}
else {

}
capture confirm v _2snentrustbusinesseduc
if !_rc {
destring _2snentrustbusinesseduc, replace
}
else {

}
capture confirm v _2snentrustbusinessemployertype
if !_rc {
destring _2snentrustbusinessemployertype, replace
}
else {

}
capture confirm v _2snentrustbusinessliving
if !_rc {
destring _2snentrustbusinessliving, replace
}
else {

}
capture confirm v _2snentrustbusinessruralurban
if !_rc {
destring _2snentrustbusinessruralurban, replace
}
else {

}
capture confirm v _2snentrustbusinessdistrict
if !_rc {
destring _2snentrustbusinessdistrict, replace
}
else {

}
capture confirm v _2snentrustbusinesscompared
if !_rc {
destring _2snentrustbusinesscompared, replace
}
else {

}
capture confirm v _2snentrustbusinessmeet
if !_rc {
destring _2snentrustbusinessmeet, replace
}
else {

}
capture confirm v _2snentrustbusinessmeetfrequency
if !_rc {
destring _2snentrustbusinessmeetfrequency, replace
}
else {

}
capture confirm v _2snentrustbusinessinvite
if !_rc {
destring _2snentrustbusinessinvite, replace
}
else {

}
capture confirm v _2snentrustbusinessreciprocity1
if !_rc {
destring _2snentrustbusinessreciprocity1, replace
}
else {

}
capture confirm v _2snentrustbusinessintimacy
if !_rc {
destring _2snentrustbusinessintimacy, replace
}
else {

}
capture confirm v _2snrecruitworker
if !_rc {
destring _2snrecruitworker, replace
}
else {

}
capture confirm v _2snrecruitworkerdummyfam
if !_rc {
destring _2snrecruitworkerdummyfam, replace
}
else {

}
capture confirm v _2snrecruitworkerdummyhh
if !_rc {
destring _2snrecruitworkerdummyhh, replace
}
else {

}
capture confirm v _2snrecruitworkerfriend
if !_rc {
destring _2snrecruitworkerfriend, replace
}
else {

}
capture confirm v _2snrecruitworkerwkp
if !_rc {
destring _2snrecruitworkerwkp, replace
}
else {

}
capture confirm v _2snrecruitworkerlabourrelation
if !_rc {
destring _2snrecruitworkerlabourrelation, replace
}
else {

}
capture confirm v _2snrecruitworkersex
if !_rc {
destring _2snrecruitworkersex, replace
}
else {

}
capture confirm v _2snrecruitworkerage
if !_rc {
destring _2snrecruitworkerage, replace
}
else {

}
capture confirm v _2snrecruitworkerlabourtype
if !_rc {
destring _2snrecruitworkerlabourtype, replace
}
else {

}
capture confirm v _2snrecruitworkercastes
if !_rc {
destring _2snrecruitworkercastes, replace
}
else {

}
capture confirm v _2snrecruitworkereduc
if !_rc {
destring _2snrecruitworkereduc, replace
}
else {

}
capture confirm v _2snrecruitworkeremployertype
if !_rc {
destring _2snrecruitworkeremployertype, replace
}
else {

}
capture confirm v _2snrecruitworkerliving
if !_rc {
destring _2snrecruitworkerliving, replace
}
else {

}
capture confirm v _2snrecruitworkerruralurban
if !_rc {
destring _2snrecruitworkerruralurban, replace
}
else {

}
capture confirm v _2snrecruitworkerdistrict
if !_rc {
destring _2snrecruitworkerdistrict, replace
}
else {

}
capture confirm v _2snrecruitworkercompared
if !_rc {
destring _2snrecruitworkercompared, replace
}
else {

}
capture confirm v _2snrecruitworkermeet
if !_rc {
destring _2snrecruitworkermeet, replace
}
else {

}
capture confirm v _2snrecruitworkermeetfrequency
if !_rc {
destring _2snrecruitworkermeetfrequency, replace
}
else {

}
capture confirm v _2snrecruitworkerinvite
if !_rc {
destring _2snrecruitworkerinvite, replace
}
else {

}
capture confirm v _2snrecruitworkerreciprocity1
if !_rc {
destring _2snrecruitworkerreciprocity1, replace
}
else {

}
capture confirm v _2snrecruitworkerintimacy
if !_rc {
destring _2snrecruitworkerintimacy, replace
}
else {

}
capture confirm v _2snfindsuppliers
if !_rc {
destring _2snfindsuppliers, replace
}
else {

}
capture confirm v _2snfindsuppliersdummyfam
if !_rc {
destring _2snfindsuppliersdummyfam, replace
}
else {

}
capture confirm v _2snfindsuppliersdummyhh
if !_rc {
destring _2snfindsuppliersdummyhh, replace
}
else {

}
capture confirm v _2snfindsuppliersfriend
if !_rc {
destring _2snfindsuppliersfriend, replace
}
else {

}
capture confirm v _2snfindsupplierswkp
if !_rc {
destring _2snfindsupplierswkp, replace
}
else {

}
capture confirm v _2snfindsupplierslabourrelation
if !_rc {
destring _2snfindsupplierslabourrelation, replace
}
else {

}
capture confirm v _2snfindsupplierssex
if !_rc {
destring _2snfindsupplierssex, replace
}
else {

}
capture confirm v _2snfindsuppliersage
if !_rc {
destring _2snfindsuppliersage, replace
}
else {

}
capture confirm v _2snfindsupplierslabourtype
if !_rc {
destring _2snfindsupplierslabourtype, replace
}
else {

}
capture confirm v _2snfindsupplierscastes
if !_rc {
destring _2snfindsupplierscastes, replace
}
else {

}
capture confirm v _2snfindsupplierseduc
if !_rc {
destring _2snfindsupplierseduc, replace
}
else {

}
capture confirm v _2snfindsuppliersemployertype
if !_rc {
destring _2snfindsuppliersemployertype, replace
}
else {

}
capture confirm v _2snfindsuppliersliving
if !_rc {
destring _2snfindsuppliersliving, replace
}
else {

}
capture confirm v _2snfindsuppliersruralurban
if !_rc {
destring _2snfindsuppliersruralurban, replace
}
else {

}
capture confirm v _2snfindsuppliersdistrict
if !_rc {
destring _2snfindsuppliersdistrict, replace
}
else {

}
capture confirm v _2snfindsupplierscompared
if !_rc {
destring _2snfindsupplierscompared, replace
}
else {

}
capture confirm v _2snfindsuppliersmeet
if !_rc {
destring _2snfindsuppliersmeet, replace
}
else {

}
capture confirm v _2snfindsuppliersmeetfrequency
if !_rc {
destring _2snfindsuppliersmeetfrequency, replace
}
else {

}
capture confirm v _2snfindsuppliersinvite
if !_rc {
destring _2snfindsuppliersinvite, replace
}
else {

}
capture confirm v _2snfindsuppliersreciprocity1
if !_rc {
destring _2snfindsuppliersreciprocity1, replace
}
else {

}
capture confirm v _2snfindsuppliersintimacy
if !_rc {
destring _2snfindsuppliersintimacy, replace
}
else {

}
capture confirm v _2contract
if !_rc {
destring _2contract, replace
}
else {

}
capture confirm v _2wagejobtype
if !_rc {
destring _2wagejobtype, replace
}
else {

}
capture confirm v _2wagejobsocialsecurity
if !_rc {
destring _2wagejobsocialsecurity, replace
}
else {

}
capture confirm v _2jobwagefrequencycash
if !_rc {
destring _2jobwagefrequencycash, replace
}
else {

}
capture confirm v _2wagejobpaymentinkind
if !_rc {
destring _2wagejobpaymentinkind, replace
}
else {

}
capture confirm v _2wagejobpaymentinkindlist
if !_rc {
destring _2wagejobpaymentinkindlist, replace
}
else {

}
capture confirm v _2covworkeffort
if !_rc {
destring _2covworkeffort, replace
}
else {

}
capture confirm v _2decisionwork
if !_rc {
destring _2decisionwork, replace
}
else {

}
capture confirm v _2opinionworkingwoman
if !_rc {
destring _2opinionworkingwoman, replace
}
else {

}
capture confirm v _2opinionactivewoman
if !_rc {
destring _2opinionactivewoman, replace
}
else {

}
capture confirm v _2readystartjob
if !_rc {
destring _2readystartjob, replace
}
else {

}
capture confirm v _2methodfindjob
if !_rc {
destring _2methodfindjob, replace
}
else {

}
capture confirm v _2jobpreference
if !_rc {
destring _2jobpreference, replace
}
else {

}
capture confirm v _2moveoutsideforjob
if !_rc {
destring _2moveoutsideforjob, replace
}
else {

}
capture confirm v _2dummyaspirationmorehours
if !_rc {
destring _2dummyaspirationmorehours, replace
}
else {

}
capture confirm v _2respect
if !_rc {
destring _2respect, replace
}
else {

}
capture confirm v _2workmate
if !_rc {
destring _2workmate, replace
}
else {

}
capture confirm v _2useknowledgeatwork
if !_rc {
destring _2useknowledgeatwork, replace
}
else {

}
capture confirm v _2satisfyingpurpose
if !_rc {
destring _2satisfyingpurpose, replace
}
else {

}
capture confirm v _2schedule
if !_rc {
destring _2schedule, replace
}
else {

}
capture confirm v _2takeholiday
if !_rc {
destring _2takeholiday, replace
}
else {

}
capture confirm v _2agreementatwork1
if !_rc {
destring _2agreementatwork1, replace
}
else {

}
capture confirm v _2agreementatwork2
if !_rc {
destring _2agreementatwork2, replace
}
else {

}
capture confirm v _2agreementatwork3
if !_rc {
destring _2agreementatwork3, replace
}
else {

}
capture confirm v _2agreementatwork4
if !_rc {
destring _2agreementatwork4, replace
}
else {

}
capture confirm v _2changework
if !_rc {
destring _2changework, replace
}
else {

}
capture confirm v _2happywork
if !_rc {
destring _2happywork, replace
}
else {

}
capture confirm v _2satisfactionsalary
if !_rc {
destring _2satisfactionsalary, replace
}
else {

}
capture confirm v _2executionwork1
if !_rc {
destring _2executionwork1, replace
}
else {

}
capture confirm v _2executionwork2
if !_rc {
destring _2executionwork2, replace
}
else {

}
capture confirm v _2executionwork3
if !_rc {
destring _2executionwork3, replace
}
else {

}
capture confirm v _2executionwork4
if !_rc {
destring _2executionwork4, replace
}
else {

}
capture confirm v _2executionwork5
if !_rc {
destring _2executionwork5, replace
}
else {

}
capture confirm v _2executionwork6
if !_rc {
destring _2executionwork6, replace
}
else {

}
capture confirm v _2executionwork7
if !_rc {
destring _2executionwork7, replace
}
else {

}
capture confirm v _2executionwork8
if !_rc {
destring _2executionwork8, replace
}
else {

}
capture confirm v _2executionwork9
if !_rc {
destring _2executionwork9, replace
}
else {

}
capture confirm v _2accidentalinjury
if !_rc {
destring _2accidentalinjury, replace
}
else {

}
capture confirm v _2losswork
if !_rc {
destring _2losswork, replace
}
else {

}
capture confirm v _2physicalharm
if !_rc {
destring _2physicalharm, replace
}
else {

}
capture confirm v _2problemwork1
if !_rc {
destring _2problemwork1, replace
}
else {

}
capture confirm v _2problemwork2
if !_rc {
destring _2problemwork2, replace
}
else {

}
capture confirm v _2problemwork4
if !_rc {
destring _2problemwork4, replace
}
else {

}
capture confirm v _2problemwork5
if !_rc {
destring _2problemwork5, replace
}
else {

}
capture confirm v _2problemwork6
if !_rc {
destring _2problemwork6, replace
}
else {

}
capture confirm v _2problemwork7
if !_rc {
destring _2problemwork7, replace
}
else {

}
capture confirm v _2problemwork8
if !_rc {
destring _2problemwork8, replace
}
else {

}
capture confirm v _2problemwork9
if !_rc {
destring _2problemwork9, replace
}
else {

}
capture confirm v _2problemwork10
if !_rc {
destring _2problemwork10, replace
}
else {

}
capture confirm v _2workexposure1
if !_rc {
destring _2workexposure1, replace
}
else {

}
capture confirm v _2workexposure2
if !_rc {
destring _2workexposure2, replace
}
else {

}
capture confirm v _2workexposure3
if !_rc {
destring _2workexposure3, replace
}
else {

}
capture confirm v _2workexposure4
if !_rc {
destring _2workexposure4, replace
}
else {

}
capture confirm v _2workexposure5
if !_rc {
destring _2workexposure5, replace
}
else {

}
capture confirm v _2professionalequipment
if !_rc {
destring _2professionalequipment, replace
}
else {

}
capture confirm v _2break
if !_rc {
destring _2break, replace
}
else {

}
capture confirm v _2retirementwork
if !_rc {
destring _2retirementwork, replace
}
else {

}
capture confirm v _2verbalaggression
if !_rc {
destring _2verbalaggression, replace
}
else {

}
capture confirm v _2physicalagression
if !_rc {
destring _2physicalagression, replace
}
else {

}
capture confirm v _2sexualharassment
if !_rc {
destring _2sexualharassment, replace
}
else {

}
capture confirm v _2sexualaggression
if !_rc {
destring _2sexualaggression, replace
}
else {

}
capture confirm v _2discrimination1
if !_rc {
destring _2discrimination1, replace
}
else {

}
capture confirm v _2discrimination2
if !_rc {
destring _2discrimination2, replace
}
else {

}
capture confirm v _2discrimination3
if !_rc {
destring _2discrimination3, replace
}
else {

}
capture confirm v _2discrimination4
if !_rc {
destring _2discrimination4, replace
}
else {

}
capture confirm v _2discrimination5
if !_rc {
destring _2discrimination5, replace
}
else {

}
capture confirm v _2discrimination6
if !_rc {
destring _2discrimination6, replace
}
else {

}
capture confirm v _2discrimination7
if !_rc {
destring _2discrimination7, replace
}
else {

}
capture confirm v _2discrimination8
if !_rc {
destring _2discrimination8, replace
}
else {

}
capture confirm v _2discrimination9
if !_rc {
destring _2discrimination9, replace
}
else {

}
capture confirm v _2resdiscrimination1
if !_rc {
destring _2resdiscrimination1, replace
}
else {

}
capture confirm v _2resdiscrimination2
if !_rc {
destring _2resdiscrimination2, replace
}
else {

}
capture confirm v _2resdiscrimination3
if !_rc {
destring _2resdiscrimination3, replace
}
else {

}
capture confirm v _2resdiscrimination4
if !_rc {
destring _2resdiscrimination4, replace
}
else {

}
capture confirm v _2resdiscrimination5
if !_rc {
destring _2resdiscrimination5, replace
}
else {

}
capture confirm v _2rurallocation
if !_rc {
destring _2rurallocation, replace
}
else {

}
capture confirm v _2lackskill
if !_rc {
destring _2lackskill, replace
}
else {

}
capture confirm v _2A1
if !_rc {
destring _2A1, replace
}
else {

}
capture confirm v _2A2
if !_rc {
destring _2A2, replace
}
else {

}
capture confirm v _2A3
if !_rc {
destring _2A3, replace
}
else {

}
capture confirm v _2A4
if !_rc {
destring _2A4, replace
}
else {

}
capture confirm v _2A5
if !_rc {
destring _2A5, replace
}
else {

}
capture confirm v _2A6
if !_rc {
destring _2A6, replace
}
else {

}
capture confirm v _2A7
if !_rc {
destring _2A7, replace
}
else {

}
capture confirm v _2A8
if !_rc {
destring _2A8, replace
}
else {

}
capture confirm v _2A9
if !_rc {
destring _2A9, replace
}
else {

}
capture confirm v _2A10
if !_rc {
destring _2A10, replace
}
else {

}
capture confirm v _2A11
if !_rc {
destring _2A11, replace
}
else {

}
capture confirm v _2A12
if !_rc {
destring _2A12, replace
}
else {

}
capture confirm v _2locuscontrol1
if !_rc {
destring _2locuscontrol1, replace
}
else {

}
capture confirm v _2locuscontrol2
if !_rc {
destring _2locuscontrol2, replace
}
else {

}
capture confirm v _2locuscontrol3
if !_rc {
destring _2locuscontrol3, replace
}
else {

}
capture confirm v _2locuscontrol4
if !_rc {
destring _2locuscontrol4, replace
}
else {

}
capture confirm v _2locuscontrol5
if !_rc {
destring _2locuscontrol5, replace
}
else {

}
capture confirm v _2locuscontrol6
if !_rc {
destring _2locuscontrol6, replace
}
else {

}
capture confirm v _2assodegreeparticip
if !_rc {
destring _2assodegreeparticip, replace
}
else {

}
capture confirm v _2assosize
if !_rc {
destring _2assosize, replace
}
else {

}
capture confirm v _2dummyassorecommendation
if !_rc {
destring _2dummyassorecommendation, replace
}
else {

}
capture confirm v _2snrecommendassodummyfam
if !_rc {
destring _2snrecommendassodummyfam, replace
}
else {

}
capture confirm v _2snrecommendassodummyhh
if !_rc {
destring _2snrecommendassodummyhh, replace
}
else {

}
capture confirm v _2snrecommendassofriend
if !_rc {
destring _2snrecommendassofriend, replace
}
else {

}
capture confirm v _2snrecommendassowkp
if !_rc {
destring _2snrecommendassowkp, replace
}
else {

}
capture confirm v _2snrecommendassolabourrelation
if !_rc {
destring _2snrecommendassolabourrelation, replace
}
else {

}
capture confirm v _2snrecommendassosex
if !_rc {
destring _2snrecommendassosex, replace
}
else {

}
capture confirm v _2snrecommendassoage
if !_rc {
destring _2snrecommendassoage, replace
}
else {

}
capture confirm v _2snrecommendassolabourtype
if !_rc {
destring _2snrecommendassolabourtype, replace
}
else {

}
capture confirm v _2snrecommendassocastes
if !_rc {
destring _2snrecommendassocastes, replace
}
else {

}
capture confirm v _2snrecommendassoeduc
if !_rc {
destring _2snrecommendassoeduc, replace
}
else {

}
capture confirm v _2snrecommendassoemployertype
if !_rc {
destring _2snrecommendassoemployertype, replace
}
else {

}
capture confirm v _2snrecommendassoliving
if !_rc {
destring _2snrecommendassoliving, replace
}
else {

}
capture confirm v _2snrecommendassoruralurban
if !_rc {
destring _2snrecommendassoruralurban, replace
}
else {

}
capture confirm v _2snrecommendassodistrict
if !_rc {
destring _2snrecommendassodistrict, replace
}
else {

}
capture confirm v _2snrecommendassocompared
if !_rc {
destring _2snrecommendassocompared, replace
}
else {

}
capture confirm v _2snrecommendassomeet
if !_rc {
destring _2snrecommendassomeet, replace
}
else {

}
capture confirm v _2snrecommendassomeetfrequency
if !_rc {
destring _2snrecommendassomeetfrequency, replace
}
else {

}
capture confirm v _2snrecommendassoinvite
if !_rc {
destring _2snrecommendassoinvite, replace
}
else {

}
capture confirm v _2snrecommendassoreciprocity1
if !_rc {
destring _2snrecommendassoreciprocity1, replace
}
else {

}
capture confirm v _2snrecommendassointimacy
if !_rc {
destring _2snrecommendassointimacy, replace
}
else {

}
capture confirm v _2dummyassohelpjob
if !_rc {
destring _2dummyassohelpjob, replace
}
else {

}
capture confirm v _2assohelpjob
if !_rc {
destring _2assohelpjob, replace
}
else {

}
capture confirm v _2dummyassohelpbusiness
if !_rc {
destring _2dummyassohelpbusiness, replace
}
else {

}
capture confirm v _2assohelpbusiness
if !_rc {
destring _2assohelpbusiness, replace
}
else {

}
capture confirm v _2snfindcurrentjob
if !_rc {
destring _2snfindcurrentjob, replace
}
else {

}
capture confirm v _2snfindcurrentjobdummyfam
if !_rc {
destring _2snfindcurrentjobdummyfam, replace
}
else {

}
capture confirm v _2snfindcurrentjobdummyhh
if !_rc {
destring _2snfindcurrentjobdummyhh, replace
}
else {

}
capture confirm v _2snfindcurrentjobfriend
if !_rc {
destring _2snfindcurrentjobfriend, replace
}
else {

}
capture confirm v _2snfindcurrentjobwkp
if !_rc {
destring _2snfindcurrentjobwkp, replace
}
else {

}
capture confirm v _2snfindcurrentjoblabourrelation
if !_rc {
destring _2snfindcurrentjoblabourrelation, replace
}
else {

}
capture confirm v _2snfindcurrentjobsex
if !_rc {
destring _2snfindcurrentjobsex, replace
}
else {

}
capture confirm v _2snfindcurrentjobage
if !_rc {
destring _2snfindcurrentjobage, replace
}
else {

}
capture confirm v _2snfindcurrentjoblabourtype
if !_rc {
destring _2snfindcurrentjoblabourtype, replace
}
else {

}
capture confirm v _2snfindcurrentjobcastes
if !_rc {
destring _2snfindcurrentjobcastes, replace
}
else {

}
capture confirm v _2snfindcurrentjobeduc
if !_rc {
destring _2snfindcurrentjobeduc, replace
}
else {

}
capture confirm v _2snfindcurrentjobemployertype
if !_rc {
destring _2snfindcurrentjobemployertype, replace
}
else {

}
capture confirm v _2snfindcurrentjobliving
if !_rc {
destring _2snfindcurrentjobliving, replace
}
else {

}
capture confirm v _2snfindcurrentjobruralurban
if !_rc {
destring _2snfindcurrentjobruralurban, replace
}
else {

}
capture confirm v _2snfindcurrentjobdistrict
if !_rc {
destring _2snfindcurrentjobdistrict, replace
}
else {

}
capture confirm v _2snfindcurrentjobcompared
if !_rc {
destring _2snfindcurrentjobcompared, replace
}
else {

}
capture confirm v _2snfindcurrentjobmeet
if !_rc {
destring _2snfindcurrentjobmeet, replace
}
else {

}
capture confirm v _2snfindcurrentjobmeetfrequency
if !_rc {
destring _2snfindcurrentjobmeetfrequency, replace
}
else {

}
capture confirm v _2snfindcurrentjobinvite
if !_rc {
destring _2snfindcurrentjobinvite, replace
}
else {

}
capture confirm v _2snfindcurrentjobreciprocity1
if !_rc {
destring _2snfindcurrentjobreciprocity1, replace
}
else {

}
capture confirm v _2snfindcurrentjobintimacy
if !_rc {
destring _2snfindcurrentjobintimacy, replace
}
else {

}
capture confirm v _2snfindjob
if !_rc {
destring _2snfindjob, replace
}
else {

}
capture confirm v _2snfindjobdummyfam
if !_rc {
destring _2snfindjobdummyfam, replace
}
else {

}
capture confirm v _2snfindjobdummyhh
if !_rc {
destring _2snfindjobdummyhh, replace
}
else {

}
capture confirm v _2snfindjobfriend
if !_rc {
destring _2snfindjobfriend, replace
}
else {

}
capture confirm v _2snfindjobwkp
if !_rc {
destring _2snfindjobwkp, replace
}
else {

}
capture confirm v _2snfindjoblabourrelation
if !_rc {
destring _2snfindjoblabourrelation, replace
}
else {

}
capture confirm v _2snfindjobsex
if !_rc {
destring _2snfindjobsex, replace
}
else {

}
capture confirm v _2snfindjobage
if !_rc {
destring _2snfindjobage, replace
}
else {

}
capture confirm v _2snfindjoblabourtype
if !_rc {
destring _2snfindjoblabourtype, replace
}
else {

}
capture confirm v _2snfindjobcastes
if !_rc {
destring _2snfindjobcastes, replace
}
else {

}
capture confirm v _2snfindjobeduc
if !_rc {
destring _2snfindjobeduc, replace
}
else {

}
capture confirm v _2snfindjobemployertype
if !_rc {
destring _2snfindjobemployertype, replace
}
else {

}
capture confirm v _2snfindjobliving
if !_rc {
destring _2snfindjobliving, replace
}
else {

}
capture confirm v _2snfindjobruralurban
if !_rc {
destring _2snfindjobruralurban, replace
}
else {

}
capture confirm v _2snfindjobdistrict
if !_rc {
destring _2snfindjobdistrict, replace
}
else {

}
capture confirm v _2snfindjobcompared
if !_rc {
destring _2snfindjobcompared, replace
}
else {

}
capture confirm v _2snfindjobmeet
if !_rc {
destring _2snfindjobmeet, replace
}
else {

}
capture confirm v _2snfindjobmeetfrequency
if !_rc {
destring _2snfindjobmeetfrequency, replace
}
else {

}
capture confirm v _2snfindjobinvite
if !_rc {
destring _2snfindjobinvite, replace
}
else {

}
capture confirm v _2snfindjobreciprocity1
if !_rc {
destring _2snfindjobreciprocity1, replace
}
else {

}
capture confirm v _2snfindjobintimacy
if !_rc {
destring _2snfindjobintimacy, replace
}
else {

}
capture confirm v _2snrecommendforjob
if !_rc {
destring _2snrecommendforjob, replace
}
else {

}
capture confirm v _2snrecommendforjobdummyfam
if !_rc {
destring _2snrecommendforjobdummyfam, replace
}
else {

}
capture confirm v _2snrecommendforjobdummyhh
if !_rc {
destring _2snrecommendforjobdummyhh, replace
}
else {

}
capture confirm v _2snrecommendforjobfriend
if !_rc {
destring _2snrecommendforjobfriend, replace
}
else {

}
capture confirm v _2snrecommendforjobwkp
if !_rc {
destring _2snrecommendforjobwkp, replace
}
else {

}
capture confirm v _2snrecommendforjoblabourrelation
if !_rc {
destring _2snrecommendforjoblabourrelation, replace
}
else {

}
capture confirm v _2snrecommendforjobsex
if !_rc {
destring _2snrecommendforjobsex, replace
}
else {

}
capture confirm v _2snrecommendforjobage
if !_rc {
destring _2snrecommendforjobage, replace
}
else {

}
capture confirm v _2snrecommendforjoblabourtype
if !_rc {
destring _2snrecommendforjoblabourtype, replace
}
else {

}
capture confirm v _2snrecommendforjobcastes
if !_rc {
destring _2snrecommendforjobcastes, replace
}
else {

}
capture confirm v _2snrecommendforjobeduc
if !_rc {
destring _2snrecommendforjobeduc, replace
}
else {

}
capture confirm v _2snrecommendforjobemployertype
if !_rc {
destring _2snrecommendforjobemployertype, replace
}
else {

}
capture confirm v _2snrecommendforjobliving
if !_rc {
destring _2snrecommendforjobliving, replace
}
else {

}
capture confirm v _2snrecommendforjobruralurban
if !_rc {
destring _2snrecommendforjobruralurban, replace
}
else {

}
capture confirm v _2snrecommendforjobdistrict
if !_rc {
destring _2snrecommendforjobdistrict, replace
}
else {

}
capture confirm v _2snrecommendforjobcompared
if !_rc {
destring _2snrecommendforjobcompared, replace
}
else {

}
capture confirm v _2snrecommendforjobmeet
if !_rc {
destring _2snrecommendforjobmeet, replace
}
else {

}
capture confirm v _2snrecommendforjobmeetfrequency
if !_rc {
destring _2snrecommendforjobmeetfrequency, replace
}
else {

}
capture confirm v _2snrecommendforjobinvite
if !_rc {
destring _2snrecommendforjobinvite, replace
}
else {

}
capture confirm v _2snrecommendforjobreciprocity1
if !_rc {
destring _2snrecommendforjobreciprocity1, replace
}
else {

}
capture confirm v _2snrecommendforjobintimacy
if !_rc {
destring _2snrecommendforjobintimacy, replace
}
else {

}
capture confirm v _2snrecojobsuccess
if !_rc {
destring _2snrecojobsuccess, replace
}
else {

}
capture confirm v _2snrecojobsuccessdummyfam
if !_rc {
destring _2snrecojobsuccessdummyfam, replace
}
else {

}
capture confirm v _2snrecojobsuccessdummyhh
if !_rc {
destring _2snrecojobsuccessdummyhh, replace
}
else {

}
capture confirm v _2snrecojobsuccessfriend
if !_rc {
destring _2snrecojobsuccessfriend, replace
}
else {

}
capture confirm v _2snrecojobsuccesswkp
if !_rc {
destring _2snrecojobsuccesswkp, replace
}
else {

}
capture confirm v _2snrecojobsuccesslabourrelation
if !_rc {
destring _2snrecojobsuccesslabourrelation, replace
}
else {

}
capture confirm v _2snrecojobsuccesssex
if !_rc {
destring _2snrecojobsuccesssex, replace
}
else {

}
capture confirm v _2snrecojobsuccessage
if !_rc {
destring _2snrecojobsuccessage, replace
}
else {

}
capture confirm v _2snrecojobsuccesslabourtype
if !_rc {
destring _2snrecojobsuccesslabourtype, replace
}
else {

}
capture confirm v _2snrecojobsuccesscastes
if !_rc {
destring _2snrecojobsuccesscastes, replace
}
else {

}
capture confirm v _2snrecojobsuccesseduc
if !_rc {
destring _2snrecojobsuccesseduc, replace
}
else {

}
capture confirm v _2snrecojobsuccessemployertype
if !_rc {
destring _2snrecojobsuccessemployertype, replace
}
else {

}
capture confirm v _2snrecojobsuccessliving
if !_rc {
destring _2snrecojobsuccessliving, replace
}
else {

}
capture confirm v _2snrecojobsuccessruralurban
if !_rc {
destring _2snrecojobsuccessruralurban, replace
}
else {

}
capture confirm v _2snrecojobsuccessdistrict
if !_rc {
destring _2snrecojobsuccessdistrict, replace
}
else {

}
capture confirm v _2snrecojobsuccesscompared
if !_rc {
destring _2snrecojobsuccesscompared, replace
}
else {

}
capture confirm v _2snrecojobsuccessmeet
if !_rc {
destring _2snrecojobsuccessmeet, replace
}
else {

}
capture confirm v _2snrecojobsuccessmeetfrequency
if !_rc {
destring _2snrecojobsuccessmeetfrequency, replace
}
else {

}
capture confirm v _2snrecojobsuccessinvite
if !_rc {
destring _2snrecojobsuccessinvite, replace
}
else {

}
capture confirm v _2snrecojobsuccessreciprocity1
if !_rc {
destring _2snrecojobsuccessreciprocity1, replace
}
else {

}
capture confirm v _2snrecojobsuccessintimacy
if !_rc {
destring _2snrecojobsuccessintimacy, replace
}
else {

}
capture confirm v _2sntalkthemostfriend
if !_rc {
destring _2sntalkthemostfriend, replace
}
else {

}
capture confirm v _2sntalkthemostwkp
if !_rc {
destring _2sntalkthemostwkp, replace
}
else {

}
capture confirm v _2sntalkthemostlabourrelation
if !_rc {
destring _2sntalkthemostlabourrelation, replace
}
else {

}
capture confirm v _2sntalkthemostsex
if !_rc {
destring _2sntalkthemostsex, replace
}
else {

}
capture confirm v _2sntalkthemostage
if !_rc {
destring _2sntalkthemostage, replace
}
else {

}
capture confirm v _2sntalkthemostlabourtype
if !_rc {
destring _2sntalkthemostlabourtype, replace
}
else {

}
capture confirm v _2sntalkthemostcastes
if !_rc {
destring _2sntalkthemostcastes, replace
}
else {

}
capture confirm v _2sntalkthemosteduc
if !_rc {
destring _2sntalkthemosteduc, replace
}
else {

}
capture confirm v _2sntalkthemostemployertype
if !_rc {
destring _2sntalkthemostemployertype, replace
}
else {

}
capture confirm v _2sntalkthemostliving
if !_rc {
destring _2sntalkthemostliving, replace
}
else {

}
capture confirm v _2sntalkthemostruralurban
if !_rc {
destring _2sntalkthemostruralurban, replace
}
else {

}
capture confirm v _2sntalkthemostdistrict
if !_rc {
destring _2sntalkthemostdistrict, replace
}
else {

}
capture confirm v _2sntalkthemostcompared
if !_rc {
destring _2sntalkthemostcompared, replace
}
else {

}
capture confirm v _2sntalkthemostmeet
if !_rc {
destring _2sntalkthemostmeet, replace
}
else {

}
capture confirm v _2sntalkthemostmeetfrequency
if !_rc {
destring _2sntalkthemostmeetfrequency, replace
}
else {

}
capture confirm v _2sntalkthemostinvite
if !_rc {
destring _2sntalkthemostinvite, replace
}
else {

}
capture confirm v _2sntalkthemostreciprocity1
if !_rc {
destring _2sntalkthemostreciprocity1, replace
}
else {

}
capture confirm v _2sntalkthemostintimacy
if !_rc {
destring _2sntalkthemostintimacy, replace
}
else {

}
capture confirm v _2snhelpemergencydummyfam
if !_rc {
destring _2snhelpemergencydummyfam, replace
}
else {

}
capture confirm v _2snhelpemergencydummyhh
if !_rc {
destring _2snhelpemergencydummyhh, replace
}
else {

}
capture confirm v _2snhelpemergencyfriend
if !_rc {
destring _2snhelpemergencyfriend, replace
}
else {

}
capture confirm v _2snhelpemergencywkp
if !_rc {
destring _2snhelpemergencywkp, replace
}
else {

}
capture confirm v _2snhelpemergencylabourrelation
if !_rc {
destring _2snhelpemergencylabourrelation, replace
}
else {

}
capture confirm v _2snhelpemergencysex
if !_rc {
destring _2snhelpemergencysex, replace
}
else {

}
capture confirm v _2snhelpemergencyage
if !_rc {
destring _2snhelpemergencyage, replace
}
else {

}
capture confirm v _2snhelpemergencylabourtype
if !_rc {
destring _2snhelpemergencylabourtype, replace
}
else {

}
capture confirm v _2snhelpemergencycastes
if !_rc {
destring _2snhelpemergencycastes, replace
}
else {

}
capture confirm v _2snhelpemergencyeduc
if !_rc {
destring _2snhelpemergencyeduc, replace
}
else {

}
capture confirm v _2snhelpemergencyemployertype
if !_rc {
destring _2snhelpemergencyemployertype, replace
}
else {

}
capture confirm v _2snhelpemergencyliving
if !_rc {
destring _2snhelpemergencyliving, replace
}
else {

}
capture confirm v _2snhelpemergencyruralurban
if !_rc {
destring _2snhelpemergencyruralurban, replace
}
else {

}
capture confirm v _2snhelpemergencydistrict
if !_rc {
destring _2snhelpemergencydistrict, replace
}
else {

}
capture confirm v _2snhelpemergencycompared
if !_rc {
destring _2snhelpemergencycompared, replace
}
else {

}
capture confirm v _2snhelpemergencymeet
if !_rc {
destring _2snhelpemergencymeet, replace
}
else {

}
capture confirm v _2snhelpemergencymeetfrequency
if !_rc {
destring _2snhelpemergencymeetfrequency, replace
}
else {

}
capture confirm v _2snhelpemergencyinvite
if !_rc {
destring _2snhelpemergencyinvite, replace
}
else {

}
capture confirm v _2snhelpemergencyreciprocity1
if !_rc {
destring _2snhelpemergencyreciprocity1, replace
}
else {

}
capture confirm v _2snhelpemergencyintimacy
if !_rc {
destring _2snhelpemergencyintimacy, replace
}
else {

}
capture confirm v _2sncloserelouthhdummyfam
if !_rc {
destring _2sncloserelouthhdummyfam, replace
}
else {

}
capture confirm v _2sncloserelouthhfriend
if !_rc {
destring _2sncloserelouthhfriend, replace
}
else {

}
capture confirm v _2sncloserelouthhwkp
if !_rc {
destring _2sncloserelouthhwkp, replace
}
else {

}
capture confirm v _2sncloserelouthhlabourrelation
if !_rc {
destring _2sncloserelouthhlabourrelation, replace
}
else {

}
capture confirm v _2sncloserelouthhsex
if !_rc {
destring _2sncloserelouthhsex, replace
}
else {

}
capture confirm v _2sncloserelouthhage
if !_rc {
destring _2sncloserelouthhage, replace
}
else {

}
capture confirm v _2sncloserelouthhlabourtype
if !_rc {
destring _2sncloserelouthhlabourtype, replace
}
else {

}
capture confirm v _2sncloserelouthhcastes
if !_rc {
destring _2sncloserelouthhcastes, replace
}
else {

}
capture confirm v _2sncloserelouthheduc
if !_rc {
destring _2sncloserelouthheduc, replace
}
else {

}
capture confirm v _2sncloserelouthhemployertype
if !_rc {
destring _2sncloserelouthhemployertype, replace
}
else {

}
capture confirm v _2sncloserelouthhliving
if !_rc {
destring _2sncloserelouthhliving, replace
}
else {

}
capture confirm v _2sncloserelouthhruralurban
if !_rc {
destring _2sncloserelouthhruralurban, replace
}
else {

}
capture confirm v _2sncloserelouthhdistrict
if !_rc {
destring _2sncloserelouthhdistrict, replace
}
else {

}
capture confirm v _2sncloserelouthhcompared
if !_rc {
destring _2sncloserelouthhcompared, replace
}
else {

}
capture confirm v _2sncloserelouthhmeet
if !_rc {
destring _2sncloserelouthhmeet, replace
}
else {

}
capture confirm v _2sncloserelouthhmeetfrequency
if !_rc {
destring _2sncloserelouthhmeetfrequency, replace
}
else {

}
capture confirm v _2sncloserelouthhinvite
if !_rc {
destring _2sncloserelouthhinvite, replace
}
else {

}
capture confirm v _2sncloserelouthhreciprocity1
if !_rc {
destring _2sncloserelouthhreciprocity1, replace
}
else {

}
capture confirm v _2sncloserelouthhintimacy
if !_rc {
destring _2sncloserelouthhintimacy, replace
}
else {

}
capture confirm v _2nbercontactphone
if !_rc {
destring _2nbercontactphone, replace
}
else {

}
capture confirm v _2dummycontactleaders
if !_rc {
destring _2dummycontactleaders, replace
}
else {

}
capture confirm v _2networktrustneighborhood
if !_rc {
destring _2networktrustneighborhood, replace
}
else {

}
capture confirm v _2covneworktrustneighborhood
if !_rc {
destring _2covneworktrustneighborhood, replace
}
else {

}
capture confirm v _2networktrustemployees
if !_rc {
destring _2networktrustemployees, replace
}
else {

}
capture confirm v _2networkpeoplehelping
if !_rc {
destring _2networkpeoplehelping, replace
}
else {

}
capture confirm v _2covnetworkpeoplehelping
if !_rc {
destring _2covnetworkpeoplehelping, replace
}
else {

}
capture confirm v _2networkhelpkinmember
if !_rc {
destring _2networkhelpkinmember, replace
}
else {

}
capture confirm v _2covnetworkhelpkinmember
if !_rc {
destring _2covnetworkhelpkinmember, replace
}
else {

}
capture confirm v _2covinstit1
if !_rc {
destring _2covinstit1, replace
}
else {

}
capture confirm v _2covinstit2
if !_rc {
destring _2covinstit2, replace
}
else {

}
capture confirm v _2covinstit3
if !_rc {
destring _2covinstit3, replace
}
else {

}
capture confirm v _2covinstit4
if !_rc {
destring _2covinstit4, replace
}
else {

}
capture confirm v _2covinstit5
if !_rc {
destring _2covinstit5, replace
}
else {

}
capture confirm v _2covcontactinstitution
if !_rc {
destring _2covcontactinstitution, replace
}
else {

}
capture confirm v _2covinstit6
if !_rc {
destring _2covinstit6, replace
}
else {

}
capture confirm v _2covinstit7
if !_rc {
destring _2covinstit7, replace
}
else {

}
capture confirm v _2covinstit8
if !_rc {
destring _2covinstit8, replace
}
else {

}
capture confirm v _2covinstit9
if !_rc {
destring _2covinstit9, replace
}
else {

}
capture confirm v _2covinstit10
if !_rc {
destring _2covinstit10, replace
}
else {

}
capture confirm v _2B1
if !_rc {
destring _2B1, replace
}
else {

}
capture confirm v _2B2
if !_rc {
destring _2B2, replace
}
else {

}
capture confirm v _2B3
if !_rc {
destring _2B3, replace
}
else {

}
capture confirm v _2B4
if !_rc {
destring _2B4, replace
}
else {

}
capture confirm v _2B5
if !_rc {
destring _2B5, replace
}
else {

}
capture confirm v _2B6
if !_rc {
destring _2B6, replace
}
else {

}
capture confirm v _2B7
if !_rc {
destring _2B7, replace
}
else {

}
capture confirm v _2B8
if !_rc {
destring _2B8, replace
}
else {

}
capture confirm v _2B9
if !_rc {
destring _2B9, replace
}
else {

}
capture confirm v _2B10
if !_rc {
destring _2B10, replace
}
else {

}
capture confirm v _2B11
if !_rc {
destring _2B11, replace
}
else {

}
capture confirm v _2B12
if !_rc {
destring _2B12, replace
}
else {

}
capture confirm v _2enjoypeople
if !_rc {
destring _2enjoypeople, replace
}
else {

}
capture confirm v _2curious
if !_rc {
destring _2curious, replace
}
else {

}
capture confirm v _2organized
if !_rc {
destring _2organized, replace
}
else {

}
capture confirm v _2managestress
if !_rc {
destring _2managestress, replace
}
else {

}
capture confirm v _2interestedbyart
if !_rc {
destring _2interestedbyart, replace
}
else {

}
capture confirm v _2tryhard
if !_rc {
destring _2tryhard, replace
}
else {

}
capture confirm v _2workwithother
if !_rc {
destring _2workwithother, replace
}
else {

}
capture confirm v _2makeplans
if !_rc {
destring _2makeplans, replace
}
else {

}
capture confirm v _2sharefeelings
if !_rc {
destring _2sharefeelings, replace
}
else {

}
capture confirm v _2nervous
if !_rc {
destring _2nervous, replace
}
else {

}
capture confirm v _2stickwithgoals
if !_rc {
destring _2stickwithgoals, replace
}
else {

}
capture confirm v _2repetitivetasks
if !_rc {
destring _2repetitivetasks, replace
}
else {

}
capture confirm v _2shywithpeople
if !_rc {
destring _2shywithpeople, replace
}
else {

}
capture confirm v _2workhard
if !_rc {
destring _2workhard, replace
}
else {

}
capture confirm v _2changemood
if !_rc {
destring _2changemood, replace
}
else {

}
capture confirm v _2understandotherfeeling
if !_rc {
destring _2understandotherfeeling, replace
}
else {

}
capture confirm v _2inventive
if !_rc {
destring _2inventive, replace
}
else {

}
capture confirm v _2enthusiastic
if !_rc {
destring _2enthusiastic, replace
}
else {

}
capture confirm v _2feeldepressed
if !_rc {
destring _2feeldepressed, replace
}
else {

}
capture confirm v _2appointmentontime
if !_rc {
destring _2appointmentontime, replace
}
else {

}
capture confirm v _2trustingofother
if !_rc {
destring _2trustingofother, replace
}
else {

}
capture confirm v _2goaftergoal
if !_rc {
destring _2goaftergoal, replace
}
else {

}
capture confirm v _2easilyupset
if !_rc {
destring _2easilyupset, replace
}
else {

}
capture confirm v _2talktomanypeople
if !_rc {
destring _2talktomanypeople, replace
}
else {

}
capture confirm v _2liketothink
if !_rc {
destring _2liketothink, replace
}
else {

}
capture confirm v _2finishwhatbegin
if !_rc {
destring _2finishwhatbegin, replace
}
else {

}
capture confirm v _2putoffduties
if !_rc {
destring _2putoffduties, replace
}
else {

}
capture confirm v _2rudetoother
if !_rc {
destring _2rudetoother, replace
}
else {

}
capture confirm v _2finishtasks
if !_rc {
destring _2finishtasks, replace
}
else {

}
capture confirm v _2toleratefaults
if !_rc {
destring _2toleratefaults, replace
}
else {

}
capture confirm v _2worryalot
if !_rc {
destring _2worryalot, replace
}
else {

}
capture confirm v _2easilydistracted
if !_rc {
destring _2easilydistracted, replace
}
else {

}
capture confirm v _2keepworking
if !_rc {
destring _2keepworking, replace
}
else {

}
capture confirm v _2completeduties
if !_rc {
destring _2completeduties, replace
}
else {

}
capture confirm v _2talkative
if !_rc {
destring _2talkative, replace
}
else {

}
capture confirm v _2newideas
if !_rc {
destring _2newideas, replace
}
else {

}
capture confirm v _2staycalm
if !_rc {
destring _2staycalm, replace
}
else {

}
capture confirm v _2forgiveother
if !_rc {
destring _2forgiveother, replace
}
else {

}
capture confirm v _2activeimagination
if !_rc {
destring _2activeimagination, replace
}
else {

}
capture confirm v _2expressingthoughts
if !_rc {
destring _2expressingthoughts, replace
}
else {

}
capture confirm v _2helpfulwithothers
if !_rc {
destring _2helpfulwithothers, replace
}
else {

}
capture confirm v _2canreadcard1a
if !_rc {
destring _2canreadcard1a, replace
}
else {

}
capture confirm v _2canreadcard1b
if !_rc {
destring _2canreadcard1b, replace
}
else {

}
capture confirm v _2canreadcard1c
if !_rc {
destring _2canreadcard1c, replace
}
else {

}
capture confirm v _2canreadcard2
if !_rc {
destring _2canreadcard2, replace
}
else {

}
capture confirm v _2numeracy1
if !_rc {
destring _2numeracy1, replace
}
else {

}
capture confirm v _2numeracy2
if !_rc {
destring _2numeracy2, replace
}
else {

}
capture confirm v _2numeracy5
if !_rc {
destring _2numeracy5, replace
}
else {

}
capture confirm v _2numeracy6
if !_rc {
destring _2numeracy6, replace
}
else {

}
capture confirm v _2numeracy3
if !_rc {
destring _2numeracy3, replace
}
else {

}
capture confirm v _2numeracy4
if !_rc {
destring _2numeracy4, replace
}
else {

}
capture confirm v _2Ab1
if !_rc {
destring _2Ab1, replace
}
else {

}
capture confirm v _2Ab2
if !_rc {
destring _2Ab2, replace
}
else {

}
capture confirm v _2Ab3
if !_rc {
destring _2Ab3, replace
}
else {

}
capture confirm v _2Ab4
if !_rc {
destring _2Ab4, replace
}
else {

}
capture confirm v _2Ab5
if !_rc {
destring _2Ab5, replace
}
else {

}
capture confirm v _2Ab6
if !_rc {
destring _2Ab6, replace
}
else {

}
capture confirm v _2Ab7
if !_rc {
destring _2Ab7, replace
}
else {

}
capture confirm v _2Ab8
if !_rc {
destring _2Ab8, replace
}
else {

}
capture confirm v _2Ab9
if !_rc {
destring _2Ab9, replace
}
else {

}
capture confirm v _2Ab10
if !_rc {
destring _2Ab10, replace
}
else {

}
capture confirm v _2Ab11
if !_rc {
destring _2Ab11, replace
}
else {

}
capture confirm v _2Ab12
if !_rc {
destring _2Ab12, replace
}
else {

}
capture confirm v ego3potential
if !_rc {
destring ego3potential, replace
}
else {

}
capture confirm v _3ego2random_1
if !_rc {
destring _3ego2random_1, replace
}
else {

}
capture confirm v _3ego2random_2
if !_rc {
destring _3ego2random_2, replace
}
else {

}
capture confirm v _3ego2random_3
if !_rc {
destring _3ego2random_3, replace
}
else {

}
capture confirm v _3ego2random_1_2
if !_rc {
destring _3ego2random_1_2, replace
}
else {

}
capture confirm v _3ego2random_2_2
if !_rc {
destring _3ego2random_2_2, replace
}
else {

}
capture confirm v _3ego2random_3_2
if !_rc {
destring _3ego2random_3_2, replace
}
else {

}
capture confirm v _3ego2random_1_3
if !_rc {
destring _3ego2random_1_3, replace
}
else {

}
capture confirm v _3ego2random_2_3
if !_rc {
destring _3ego2random_2_3, replace
}
else {

}
capture confirm v _3ego2random_3_3
if !_rc {
destring _3ego2random_3_3, replace
}
else {

}
capture confirm v _3everwork
if !_rc {
destring _3everwork, replace
}
else {

}
capture confirm v _3workpastsevendays
if !_rc {
destring _3workpastsevendays, replace
}
else {

}
capture confirm v _3searchjob
if !_rc {
destring _3searchjob, replace
}
else {

}
capture confirm v _3startbusiness
if !_rc {
destring _3startbusiness, replace
}
else {

}
capture confirm v _3reasondontsearchjob
if !_rc {
destring _3reasondontsearchjob, replace
}
else {

}
capture confirm v _3searchjobsince15
if !_rc {
destring _3searchjobsince15, replace
}
else {

}
capture confirm v _3reasondontsearchjobsince15
if !_rc {
destring _3reasondontsearchjobsince15, replace
}
else {

}
capture confirm v _3nbermonthsearchjob
if !_rc {
destring _3nbermonthsearchjob, replace
}
else {

}
capture confirm v _3methodfindfirstjob
if !_rc {
destring _3methodfindfirstjob, replace
}
else {

}
capture confirm v _3jobfirstwagefrequencycash
if !_rc {
destring _3jobfirstwagefrequencycash, replace
}
else {

}
capture confirm v _3dummymainoccupation2
if !_rc {
destring _3dummymainoccupation2, replace
}
else {

}
capture confirm v _3dummyseasonalmainoccup
if !_rc {
destring _3dummyseasonalmainoccup, replace
}
else {

}
capture confirm v _3dummypreviouswagejob
if !_rc {
destring _3dummypreviouswagejob, replace
}
else {

}
capture confirm v _3previousjobcontract
if !_rc {
destring _3previousjobcontract, replace
}
else {

}
capture confirm v _3reasonstoppedwagejob
if !_rc {
destring _3reasonstoppedwagejob, replace
}
else {

}
capture confirm v _3businesslossinvest
if !_rc {
destring _3businesslossinvest, replace
}
else {

}
capture confirm v _3covdifficulties
if !_rc {
destring _3covdifficulties, replace
}
else {

}
capture confirm v _3castebusinesslender
if !_rc {
destring _3castebusinesslender, replace
}
else {

}
capture confirm v _3sexbusinesslender
if !_rc {
destring _3sexbusinesslender, replace
}
else {

}
capture confirm v _3agebusinesslender
if !_rc {
destring _3agebusinesslender, replace
}
else {

}
capture confirm v _3educbusinesslender
if !_rc {
destring _3educbusinesslender, replace
}
else {

}
capture confirm v _3livingbusinesslender
if !_rc {
destring _3livingbusinesslender, replace
}
else {

}
capture confirm v _3comparedbusinesslender
if !_rc {
destring _3comparedbusinesslender, replace
}
else {

}
capture confirm v _3meetbusinesslender
if !_rc {
destring _3meetbusinesslender, replace
}
else {

}
capture confirm v _3meetfrequemcybusinesslender
if !_rc {
destring _3meetfrequemcybusinesslender, replace
}
else {

}
capture confirm v _3invitebusinesslender
if !_rc {
destring _3invitebusinesslender, replace
}
else {

}
capture confirm v _3reciprocity1businesslender
if !_rc {
destring _3reciprocity1businesslender, replace
}
else {

}
capture confirm v _3intimacybusinesslender
if !_rc {
destring _3intimacybusinesslender, replace
}
else {

}
capture confirm v _3businessnbworkers
if !_rc {
destring _3businessnbworkers, replace
}
else {

}
capture confirm v _3dummybusinessunpaidworkers
if !_rc {
destring _3dummybusinessunpaidworkers, replace
}
else {

}
capture confirm v _3businessnbunpaidworkers
if !_rc {
destring _3businessnbunpaidworkers, replace
}
else {

}
capture confirm v _3dummybusinesspaidworkers
if !_rc {
destring _3dummybusinesspaidworkers, replace
}
else {

}
capture confirm v _3businessnbpaidworkers
if !_rc {
destring _3businessnbpaidworkers, replace
}
else {

}
capture confirm v _3businessworkersfrequencypayment
if !_rc {
destring _3businessworkersfrequencypayment, replace
}
else {

}
capture confirm v _3frequencygrossreceipt
if !_rc {
destring _3frequencygrossreceipt, replace
}
else {

}
capture confirm v _3businesssocialsecurity
if !_rc {
destring _3businesssocialsecurity, replace
}
else {

}
capture confirm v _3businesspaymentinkind
if !_rc {
destring _3businesspaymentinkind, replace
}
else {

}
capture confirm v _3businesspaymentinkindlist
if !_rc {
destring _3businesspaymentinkindlist, replace
}
else {

}
capture confirm v _3snentrustbusiness
if !_rc {
destring _3snentrustbusiness, replace
}
else {

}
capture confirm v _3snentrustbusinessdummyfam
if !_rc {
destring _3snentrustbusinessdummyfam, replace
}
else {

}
capture confirm v _3snentrustbusinessdummyhh
if !_rc {
destring _3snentrustbusinessdummyhh, replace
}
else {

}
capture confirm v _3snentrustbusinessfriend
if !_rc {
destring _3snentrustbusinessfriend, replace
}
else {

}
capture confirm v _3snentrustbusinesswkp
if !_rc {
destring _3snentrustbusinesswkp, replace
}
else {

}
capture confirm v _3snentrustbusinesslabourrelation
if !_rc {
destring _3snentrustbusinesslabourrelation, replace
}
else {

}
capture confirm v _3snentrustbusinesssex
if !_rc {
destring _3snentrustbusinesssex, replace
}
else {

}
capture confirm v _3snentrustbusinessage
if !_rc {
destring _3snentrustbusinessage, replace
}
else {

}
capture confirm v _3snentrustbusinesslabourtype
if !_rc {
destring _3snentrustbusinesslabourtype, replace
}
else {

}
capture confirm v _3snentrustbusinesscastes
if !_rc {
destring _3snentrustbusinesscastes, replace
}
else {

}
capture confirm v _3snentrustbusinesseduc
if !_rc {
destring _3snentrustbusinesseduc, replace
}
else {

}
capture confirm v _3snentrustbusinessemployertype
if !_rc {
destring _3snentrustbusinessemployertype, replace
}
else {

}
capture confirm v _3snentrustbusinessliving
if !_rc {
destring _3snentrustbusinessliving, replace
}
else {

}
capture confirm v _3snentrustbusinessruralurban
if !_rc {
destring _3snentrustbusinessruralurban, replace
}
else {

}
capture confirm v _3snentrustbusinessdistrict
if !_rc {
destring _3snentrustbusinessdistrict, replace
}
else {

}
capture confirm v _3snentrustbusinesscompared
if !_rc {
destring _3snentrustbusinesscompared, replace
}
else {

}
capture confirm v _3snentrustbusinessmeet
if !_rc {
destring _3snentrustbusinessmeet, replace
}
else {

}
capture confirm v _3snentrustbusinessmeetfrequency
if !_rc {
destring _3snentrustbusinessmeetfrequency, replace
}
else {

}
capture confirm v _3snentrustbusinessinvite
if !_rc {
destring _3snentrustbusinessinvite, replace
}
else {

}
capture confirm v _3snentrustbusinessreciprocity1
if !_rc {
destring _3snentrustbusinessreciprocity1, replace
}
else {

}
capture confirm v _3snentrustbusinessintimacy
if !_rc {
destring _3snentrustbusinessintimacy, replace
}
else {

}
capture confirm v _3snrecruitworker
if !_rc {
destring _3snrecruitworker, replace
}
else {

}
capture confirm v _3snrecruitworkerdummyfam
if !_rc {
destring _3snrecruitworkerdummyfam, replace
}
else {

}
capture confirm v _3snrecruitworkerdummyhh
if !_rc {
destring _3snrecruitworkerdummyhh, replace
}
else {

}
capture confirm v _3snrecruitworkerfriend
if !_rc {
destring _3snrecruitworkerfriend, replace
}
else {

}
capture confirm v _3snrecruitworkerwkp
if !_rc {
destring _3snrecruitworkerwkp, replace
}
else {

}
capture confirm v _3snrecruitworkerlabourrelation
if !_rc {
destring _3snrecruitworkerlabourrelation, replace
}
else {

}
capture confirm v _3snrecruitworkersex
if !_rc {
destring _3snrecruitworkersex, replace
}
else {

}
capture confirm v _3snrecruitworkerage
if !_rc {
destring _3snrecruitworkerage, replace
}
else {

}
capture confirm v _3snrecruitworkerlabourtype
if !_rc {
destring _3snrecruitworkerlabourtype, replace
}
else {

}
capture confirm v _3snrecruitworkercastes
if !_rc {
destring _3snrecruitworkercastes, replace
}
else {

}
capture confirm v _3snrecruitworkereduc
if !_rc {
destring _3snrecruitworkereduc, replace
}
else {

}
capture confirm v _3snrecruitworkeremployertype
if !_rc {
destring _3snrecruitworkeremployertype, replace
}
else {

}
capture confirm v _3snrecruitworkerliving
if !_rc {
destring _3snrecruitworkerliving, replace
}
else {

}
capture confirm v _3snrecruitworkerruralurban
if !_rc {
destring _3snrecruitworkerruralurban, replace
}
else {

}
capture confirm v _3snrecruitworkerdistrict
if !_rc {
destring _3snrecruitworkerdistrict, replace
}
else {

}
capture confirm v _3snrecruitworkercompared
if !_rc {
destring _3snrecruitworkercompared, replace
}
else {

}
capture confirm v _3snrecruitworkermeet
if !_rc {
destring _3snrecruitworkermeet, replace
}
else {

}
capture confirm v _3snrecruitworkermeetfrequency
if !_rc {
destring _3snrecruitworkermeetfrequency, replace
}
else {

}
capture confirm v _3snrecruitworkerinvite
if !_rc {
destring _3snrecruitworkerinvite, replace
}
else {

}
capture confirm v _3snrecruitworkerreciprocity1
if !_rc {
destring _3snrecruitworkerreciprocity1, replace
}
else {

}
capture confirm v _3snrecruitworkerintimacy
if !_rc {
destring _3snrecruitworkerintimacy, replace
}
else {

}
capture confirm v _3snfindsuppliers
if !_rc {
destring _3snfindsuppliers, replace
}
else {

}
capture confirm v _3snfindsuppliersdummyfam
if !_rc {
destring _3snfindsuppliersdummyfam, replace
}
else {

}
capture confirm v _3snfindsuppliersdummyhh
if !_rc {
destring _3snfindsuppliersdummyhh, replace
}
else {

}
capture confirm v _3snfindsuppliersfriend
if !_rc {
destring _3snfindsuppliersfriend, replace
}
else {

}
capture confirm v _3snfindsupplierswkp
if !_rc {
destring _3snfindsupplierswkp, replace
}
else {

}
capture confirm v _3snfindsupplierslabourrelation
if !_rc {
destring _3snfindsupplierslabourrelation, replace
}
else {

}
capture confirm v _3snfindsupplierssex
if !_rc {
destring _3snfindsupplierssex, replace
}
else {

}
capture confirm v _3snfindsuppliersage
if !_rc {
destring _3snfindsuppliersage, replace
}
else {

}
capture confirm v _3snfindsupplierslabourtype
if !_rc {
destring _3snfindsupplierslabourtype, replace
}
else {

}
capture confirm v _3snfindsupplierscastes
if !_rc {
destring _3snfindsupplierscastes, replace
}
else {

}
capture confirm v _3snfindsupplierseduc
if !_rc {
destring _3snfindsupplierseduc, replace
}
else {

}
capture confirm v _3snfindsuppliersemployertype
if !_rc {
destring _3snfindsuppliersemployertype, replace
}
else {

}
capture confirm v _3snfindsuppliersliving
if !_rc {
destring _3snfindsuppliersliving, replace
}
else {

}
capture confirm v _3snfindsuppliersruralurban
if !_rc {
destring _3snfindsuppliersruralurban, replace
}
else {

}
capture confirm v _3snfindsuppliersdistrict
if !_rc {
destring _3snfindsuppliersdistrict, replace
}
else {

}
capture confirm v _3snfindsuppliersmeetfrequency
if !_rc {
destring _3snfindsuppliersmeetfrequency, replace
}
else {

}
capture confirm v _3snfindsuppliersinvite
if !_rc {
destring _3snfindsuppliersinvite, replace
}
else {

}
capture confirm v _3snfindsuppliersreciprocity1
if !_rc {
destring _3snfindsuppliersreciprocity1, replace
}
else {

}
capture confirm v _3snfindsuppliersintimacy
if !_rc {
destring _3snfindsuppliersintimacy, replace
}
else {

}
capture confirm v _3snfindsupplierscompared
if !_rc {
destring _3snfindsupplierscompared, replace
}
else {

}
capture confirm v _3snfindsuppliersmeet
if !_rc {
destring _3snfindsuppliersmeet, replace
}
else {

}
capture confirm v _3contract
if !_rc {
destring _3contract, replace
}
else {

}
capture confirm v _3wagejobtype
if !_rc {
destring _3wagejobtype, replace
}
else {

}
capture confirm v _3wagejobsocialsecurity
if !_rc {
destring _3wagejobsocialsecurity, replace
}
else {

}
capture confirm v _3jobwagefrequencycash
if !_rc {
destring _3jobwagefrequencycash, replace
}
else {

}
capture confirm v _3wagejobpaymentinkind
if !_rc {
destring _3wagejobpaymentinkind, replace
}
else {

}
capture confirm v _3wagejobpaymentinkindlist
if !_rc {
destring _3wagejobpaymentinkindlist, replace
}
else {

}
capture confirm v _3covworkeffort
if !_rc {
destring _3covworkeffort, replace
}
else {

}
capture confirm v _3decisionwork
if !_rc {
destring _3decisionwork, replace
}
else {

}
capture confirm v _3opinionworkingwoman
if !_rc {
destring _3opinionworkingwoman, replace
}
else {

}
capture confirm v _3opinionactivewoman
if !_rc {
destring _3opinionactivewoman, replace
}
else {

}
capture confirm v _3readystartjob
if !_rc {
destring _3readystartjob, replace
}
else {

}
capture confirm v _3methodfindjob
if !_rc {
destring _3methodfindjob, replace
}
else {

}
capture confirm v _3jobpreference
if !_rc {
destring _3jobpreference, replace
}
else {

}
capture confirm v _3moveoutsideforjob
if !_rc {
destring _3moveoutsideforjob, replace
}
else {

}
capture confirm v _3dummyaspirationmorehours
if !_rc {
destring _3dummyaspirationmorehours, replace
}
else {

}
capture confirm v _3respect
if !_rc {
destring _3respect, replace
}
else {

}
capture confirm v _3workmate
if !_rc {
destring _3workmate, replace
}
else {

}
capture confirm v _3useknowledgeatwork
if !_rc {
destring _3useknowledgeatwork, replace
}
else {

}
capture confirm v _3satisfyingpurpose
if !_rc {
destring _3satisfyingpurpose, replace
}
else {

}
capture confirm v _3schedule
if !_rc {
destring _3schedule, replace
}
else {

}
capture confirm v _3takeholiday
if !_rc {
destring _3takeholiday, replace
}
else {

}
capture confirm v _3agreementatwork1
if !_rc {
destring _3agreementatwork1, replace
}
else {

}
capture confirm v _3agreementatwork2
if !_rc {
destring _3agreementatwork2, replace
}
else {

}
capture confirm v _3agreementatwork3
if !_rc {
destring _3agreementatwork3, replace
}
else {

}
capture confirm v _3agreementatwork4
if !_rc {
destring _3agreementatwork4, replace
}
else {

}
capture confirm v _3changework
if !_rc {
destring _3changework, replace
}
else {

}
capture confirm v _3happywork
if !_rc {
destring _3happywork, replace
}
else {

}
capture confirm v _3satisfactionsalary
if !_rc {
destring _3satisfactionsalary, replace
}
else {

}
capture confirm v _3executionwork1
if !_rc {
destring _3executionwork1, replace
}
else {

}
capture confirm v _3executionwork2
if !_rc {
destring _3executionwork2, replace
}
else {

}
capture confirm v _3executionwork3
if !_rc {
destring _3executionwork3, replace
}
else {

}
capture confirm v _3executionwork4
if !_rc {
destring _3executionwork4, replace
}
else {

}
capture confirm v _3executionwork5
if !_rc {
destring _3executionwork5, replace
}
else {

}
capture confirm v _3executionwork6
if !_rc {
destring _3executionwork6, replace
}
else {

}
capture confirm v _3executionwork7
if !_rc {
destring _3executionwork7, replace
}
else {

}
capture confirm v _3executionwork8
if !_rc {
destring _3executionwork8, replace
}
else {

}
capture confirm v _3executionwork9
if !_rc {
destring _3executionwork9, replace
}
else {

}
capture confirm v _3accidentalinjury
if !_rc {
destring _3accidentalinjury, replace
}
else {

}
capture confirm v _3losswork
if !_rc {
destring _3losswork, replace
}
else {

}
capture confirm v _3physicalharm
if !_rc {
destring _3physicalharm, replace
}
else {

}
capture confirm v _3problemwork1
if !_rc {
destring _3problemwork1, replace
}
else {

}
capture confirm v _3problemwork2
if !_rc {
destring _3problemwork2, replace
}
else {

}
capture confirm v _3problemwork4
if !_rc {
destring _3problemwork4, replace
}
else {

}
capture confirm v _3problemwork5
if !_rc {
destring _3problemwork5, replace
}
else {

}
capture confirm v _3problemwork6
if !_rc {
destring _3problemwork6, replace
}
else {

}
capture confirm v _3problemwork7
if !_rc {
destring _3problemwork7, replace
}
else {

}
capture confirm v _3problemwork8
if !_rc {
destring _3problemwork8, replace
}
else {

}
capture confirm v _3problemwork9
if !_rc {
destring _3problemwork9, replace
}
else {

}
capture confirm v _3problemwork10
if !_rc {
destring _3problemwork10, replace
}
else {

}
capture confirm v _3workexposure1
if !_rc {
destring _3workexposure1, replace
}
else {

}
capture confirm v _3workexposure2
if !_rc {
destring _3workexposure2, replace
}
else {

}
capture confirm v _3workexposure3
if !_rc {
destring _3workexposure3, replace
}
else {

}
capture confirm v _3workexposure4
if !_rc {
destring _3workexposure4, replace
}
else {

}
capture confirm v _3workexposure5
if !_rc {
destring _3workexposure5, replace
}
else {

}
capture confirm v _3professionalequipment
if !_rc {
destring _3professionalequipment, replace
}
else {

}
capture confirm v _3break
if !_rc {
destring _3break, replace
}
else {

}
capture confirm v _3retirementwork
if !_rc {
destring _3retirementwork, replace
}
else {

}
capture confirm v _3verbalaggression
if !_rc {
destring _3verbalaggression, replace
}
else {

}
capture confirm v _3physicalagression
if !_rc {
destring _3physicalagression, replace
}
else {

}
capture confirm v _3sexualharassment
if !_rc {
destring _3sexualharassment, replace
}
else {

}
capture confirm v _3sexualaggression
if !_rc {
destring _3sexualaggression, replace
}
else {

}
capture confirm v _3discrimination1
if !_rc {
destring _3discrimination1, replace
}
else {

}
capture confirm v _3discrimination2
if !_rc {
destring _3discrimination2, replace
}
else {

}
capture confirm v _3discrimination3
if !_rc {
destring _3discrimination3, replace
}
else {

}
capture confirm v _3discrimination4
if !_rc {
destring _3discrimination4, replace
}
else {

}
capture confirm v _3discrimination5
if !_rc {
destring _3discrimination5, replace
}
else {

}
capture confirm v _3discrimination6
if !_rc {
destring _3discrimination6, replace
}
else {

}
capture confirm v _3discrimination7
if !_rc {
destring _3discrimination7, replace
}
else {

}
capture confirm v _3discrimination8
if !_rc {
destring _3discrimination8, replace
}
else {

}
capture confirm v _3discrimination9
if !_rc {
destring _3discrimination9, replace
}
else {

}
capture confirm v _3resdiscrimination1
if !_rc {
destring _3resdiscrimination1, replace
}
else {

}
capture confirm v _3resdiscrimination2
if !_rc {
destring _3resdiscrimination2, replace
}
else {

}
capture confirm v _3resdiscrimination3
if !_rc {
destring _3resdiscrimination3, replace
}
else {

}
capture confirm v _3resdiscrimination4
if !_rc {
destring _3resdiscrimination4, replace
}
else {

}
capture confirm v _3resdiscrimination5
if !_rc {
destring _3resdiscrimination5, replace
}
else {

}
capture confirm v _3rurallocation
if !_rc {
destring _3rurallocation, replace
}
else {

}
capture confirm v _3lackskill
if !_rc {
destring _3lackskill, replace
}
else {

}
capture confirm v _3A1
if !_rc {
destring _3A1, replace
}
else {

}
capture confirm v _3A2
if !_rc {
destring _3A2, replace
}
else {

}
capture confirm v _3A3
if !_rc {
destring _3A3, replace
}
else {

}
capture confirm v _3A4
if !_rc {
destring _3A4, replace
}
else {

}
capture confirm v _3A5
if !_rc {
destring _3A5, replace
}
else {

}
capture confirm v _3A6
if !_rc {
destring _3A6, replace
}
else {

}
capture confirm v _3A7
if !_rc {
destring _3A7, replace
}
else {

}
capture confirm v _3A8
if !_rc {
destring _3A8, replace
}
else {

}
capture confirm v _3A9
if !_rc {
destring _3A9, replace
}
else {

}
capture confirm v _3A10
if !_rc {
destring _3A10, replace
}
else {

}
capture confirm v _3A11
if !_rc {
destring _3A11, replace
}
else {

}
capture confirm v _3A12
if !_rc {
destring _3A12, replace
}
else {

}
capture confirm v _3locuscontrol1
if !_rc {
destring _3locuscontrol1, replace
}
else {

}
capture confirm v _3locuscontrol2
if !_rc {
destring _3locuscontrol2, replace
}
else {

}
capture confirm v _3locuscontrol3
if !_rc {
destring _3locuscontrol3, replace
}
else {

}
capture confirm v _3locuscontrol4
if !_rc {
destring _3locuscontrol4, replace
}
else {

}
capture confirm v _3locuscontrol5
if !_rc {
destring _3locuscontrol5, replace
}
else {

}
capture confirm v _3locuscontrol6
if !_rc {
destring _3locuscontrol6, replace
}
else {

}
capture confirm v _3assodegreeparticip
if !_rc {
destring _3assodegreeparticip, replace
}
else {

}
capture confirm v _3assosize
if !_rc {
destring _3assosize, replace
}
else {

}
capture confirm v _3dummyassorecommendation
if !_rc {
destring _3dummyassorecommendation, replace
}
else {

}
capture confirm v _3snrecommendassodummyfam
if !_rc {
destring _3snrecommendassodummyfam, replace
}
else {

}
capture confirm v _3snrecommendassodummyhh
if !_rc {
destring _3snrecommendassodummyhh, replace
}
else {

}
capture confirm v _3snrecommendassofriend
if !_rc {
destring _3snrecommendassofriend, replace
}
else {

}
capture confirm v _3snrecommendassowkp
if !_rc {
destring _3snrecommendassowkp, replace
}
else {

}
capture confirm v _3snrecommendassolabourrelation
if !_rc {
destring _3snrecommendassolabourrelation, replace
}
else {

}
capture confirm v _3snrecommendassosex
if !_rc {
destring _3snrecommendassosex, replace
}
else {

}
capture confirm v _3snrecommendassoage
if !_rc {
destring _3snrecommendassoage, replace
}
else {

}
capture confirm v _3snrecommendassolabourtype
if !_rc {
destring _3snrecommendassolabourtype, replace
}
else {

}
capture confirm v _3snrecommendassocastes
if !_rc {
destring _3snrecommendassocastes, replace
}
else {

}
capture confirm v _3snrecommendassoeduc
if !_rc {
destring _3snrecommendassoeduc, replace
}
else {

}
capture confirm v _3snrecommendassoemployertype
if !_rc {
destring _3snrecommendassoemployertype, replace
}
else {

}
capture confirm v _3snrecommendassoliving
if !_rc {
destring _3snrecommendassoliving, replace
}
else {

}
capture confirm v _3snrecommendassoruralurban
if !_rc {
destring _3snrecommendassoruralurban, replace
}
else {

}
capture confirm v _3snrecommendassodistrict
if !_rc {
destring _3snrecommendassodistrict, replace
}
else {

}
capture confirm v _3snrecommendassocompared
if !_rc {
destring _3snrecommendassocompared, replace
}
else {

}
capture confirm v _3snrecommendassomeet
if !_rc {
destring _3snrecommendassomeet, replace
}
else {

}
capture confirm v _3snrecommendassomeetfrequency
if !_rc {
destring _3snrecommendassomeetfrequency, replace
}
else {

}
capture confirm v _3snrecommendassoinvite
if !_rc {
destring _3snrecommendassoinvite, replace
}
else {

}
capture confirm v _3snrecommendassoreciprocity1
if !_rc {
destring _3snrecommendassoreciprocity1, replace
}
else {

}
capture confirm v _3snrecommendassointimacy
if !_rc {
destring _3snrecommendassointimacy, replace
}
else {

}
capture confirm v _3dummyassohelpjob
if !_rc {
destring _3dummyassohelpjob, replace
}
else {

}
capture confirm v _3assohelpjob
if !_rc {
destring _3assohelpjob, replace
}
else {

}
capture confirm v _3dummyassohelpbusiness
if !_rc {
destring _3dummyassohelpbusiness, replace
}
else {

}
capture confirm v _3assohelpbusiness
if !_rc {
destring _3assohelpbusiness, replace
}
else {

}
capture confirm v _3snfindcurrentjob
if !_rc {
destring _3snfindcurrentjob, replace
}
else {

}
capture confirm v _3snfindcurrentjobdummyfam
if !_rc {
destring _3snfindcurrentjobdummyfam, replace
}
else {

}
capture confirm v _3snfindcurrentjobdummyhh
if !_rc {
destring _3snfindcurrentjobdummyhh, replace
}
else {

}
capture confirm v _3snfindcurrentjobfriend
if !_rc {
destring _3snfindcurrentjobfriend, replace
}
else {

}
capture confirm v _3snfindcurrentjobwkp
if !_rc {
destring _3snfindcurrentjobwkp, replace
}
else {

}
capture confirm v _3snfindcurrentjoblabourrelation
if !_rc {
destring _3snfindcurrentjoblabourrelation, replace
}
else {

}
capture confirm v _3snfindcurrentjobsex
if !_rc {
destring _3snfindcurrentjobsex, replace
}
else {

}
capture confirm v _3snfindcurrentjobage
if !_rc {
destring _3snfindcurrentjobage, replace
}
else {

}
capture confirm v _3snfindcurrentjoblabourtype
if !_rc {
destring _3snfindcurrentjoblabourtype, replace
}
else {

}
capture confirm v _3snfindcurrentjobcastes
if !_rc {
destring _3snfindcurrentjobcastes, replace
}
else {

}
capture confirm v _3snfindcurrentjobeduc
if !_rc {
destring _3snfindcurrentjobeduc, replace
}
else {

}
capture confirm v _3snfindcurrentjobemployertype
if !_rc {
destring _3snfindcurrentjobemployertype, replace
}
else {

}
capture confirm v _3snfindcurrentjobliving
if !_rc {
destring _3snfindcurrentjobliving, replace
}
else {

}
capture confirm v _3snfindcurrentjobruralurban
if !_rc {
destring _3snfindcurrentjobruralurban, replace
}
else {

}
capture confirm v _3snfindcurrentjobdistrict
if !_rc {
destring _3snfindcurrentjobdistrict, replace
}
else {

}
capture confirm v _3snfindcurrentjobcompared
if !_rc {
destring _3snfindcurrentjobcompared, replace
}
else {

}
capture confirm v _3snfindcurrentjobmeet
if !_rc {
destring _3snfindcurrentjobmeet, replace
}
else {

}
capture confirm v _3snfindcurrentjobmeetfrequency
if !_rc {
destring _3snfindcurrentjobmeetfrequency, replace
}
else {

}
capture confirm v _3snfindcurrentjobinvite
if !_rc {
destring _3snfindcurrentjobinvite, replace
}
else {

}
capture confirm v _3snfindcurrentjobreciprocity1
if !_rc {
destring _3snfindcurrentjobreciprocity1, replace
}
else {

}
capture confirm v _3snfindcurrentjobintimacy
if !_rc {
destring _3snfindcurrentjobintimacy, replace
}
else {

}
capture confirm v _3snfindjob
if !_rc {
destring _3snfindjob, replace
}
else {

}
capture confirm v _3snfindjobdummyfam
if !_rc {
destring _3snfindjobdummyfam, replace
}
else {

}
capture confirm v _3snfindjobdummyhh
if !_rc {
destring _3snfindjobdummyhh, replace
}
else {

}
capture confirm v _3snfindjobfriend
if !_rc {
destring _3snfindjobfriend, replace
}
else {

}
capture confirm v _3snfindjobwkp
if !_rc {
destring _3snfindjobwkp, replace
}
else {

}
capture confirm v _3snfindjoblabourrelation
if !_rc {
destring _3snfindjoblabourrelation, replace
}
else {

}
capture confirm v _3snfindjobsex
if !_rc {
destring _3snfindjobsex, replace
}
else {

}
capture confirm v _3snfindjobage
if !_rc {
destring _3snfindjobage, replace
}
else {

}
capture confirm v _3snfindjoblabourtype
if !_rc {
destring _3snfindjoblabourtype, replace
}
else {

}
capture confirm v _3snfindjobcastes
if !_rc {
destring _3snfindjobcastes, replace
}
else {

}
capture confirm v _3snfindjobeduc
if !_rc {
destring _3snfindjobeduc, replace
}
else {

}
capture confirm v _3snfindjobemployertype
if !_rc {
destring _3snfindjobemployertype, replace
}
else {

}
capture confirm v _3snfindjobliving
if !_rc {
destring _3snfindjobliving, replace
}
else {

}
capture confirm v _3snfindjobruralurban
if !_rc {
destring _3snfindjobruralurban, replace
}
else {

}
capture confirm v _3snfindjobdistrict
if !_rc {
destring _3snfindjobdistrict, replace
}
else {

}
capture confirm v _3snfindjobcompared
if !_rc {
destring _3snfindjobcompared, replace
}
else {

}
capture confirm v _3snfindjobmeet
if !_rc {
destring _3snfindjobmeet, replace
}
else {

}
capture confirm v _3snfindjobmeetfrequency
if !_rc {
destring _3snfindjobmeetfrequency, replace
}
else {

}
capture confirm v _3snfindjobinvite
if !_rc {
destring _3snfindjobinvite, replace
}
else {

}
capture confirm v _3snfindjobreciprocity1
if !_rc {
destring _3snfindjobreciprocity1, replace
}
else {

}
capture confirm v _3snfindjobintimacy
if !_rc {
destring _3snfindjobintimacy, replace
}
else {

}
capture confirm v _3snrecommendforjob
if !_rc {
destring _3snrecommendforjob, replace
}
else {

}
capture confirm v _3snrecommendforjobdummyfam
if !_rc {
destring _3snrecommendforjobdummyfam, replace
}
else {

}
capture confirm v _3snrecommendforjobdummyhh
if !_rc {
destring _3snrecommendforjobdummyhh, replace
}
else {

}
capture confirm v _3snrecommendforjobfriend
if !_rc {
destring _3snrecommendforjobfriend, replace
}
else {

}
capture confirm v _3snrecommendforjobwkp
if !_rc {
destring _3snrecommendforjobwkp, replace
}
else {

}
capture confirm v _3snrecommendforjoblabourrelation
if !_rc {
destring _3snrecommendforjoblabourrelation, replace
}
else {

}
capture confirm v _3snrecommendforjobsex
if !_rc {
destring _3snrecommendforjobsex, replace
}
else {

}
capture confirm v _3snrecommendforjobage
if !_rc {
destring _3snrecommendforjobage, replace
}
else {

}
capture confirm v _3snrecommendforjoblabourtype
if !_rc {
destring _3snrecommendforjoblabourtype, replace
}
else {

}
capture confirm v _3snrecommendforjobcastes
if !_rc {
destring _3snrecommendforjobcastes, replace
}
else {

}
capture confirm v _3snrecommendforjobeduc
if !_rc {
destring _3snrecommendforjobeduc, replace
}
else {

}
capture confirm v _3snrecommendforjobemployertype
if !_rc {
destring _3snrecommendforjobemployertype, replace
}
else {

}
capture confirm v _3snrecommendforjobliving
if !_rc {
destring _3snrecommendforjobliving, replace
}
else {

}
capture confirm v _3snrecommendforjobruralurban
if !_rc {
destring _3snrecommendforjobruralurban, replace
}
else {

}
capture confirm v _3snrecommendforjobdistrict
if !_rc {
destring _3snrecommendforjobdistrict, replace
}
else {

}
capture confirm v _3snrecommendforjobcompared
if !_rc {
destring _3snrecommendforjobcompared, replace
}
else {

}
capture confirm v _3snrecommendforjobmeet
if !_rc {
destring _3snrecommendforjobmeet, replace
}
else {

}
capture confirm v _3snrecommendforjobmeetfrequency
if !_rc {
destring _3snrecommendforjobmeetfrequency, replace
}
else {

}
capture confirm v _3snrecommendforjobinvite
if !_rc {
destring _3snrecommendforjobinvite, replace
}
else {

}
capture confirm v _3snrecommendforjobreciprocity1
if !_rc {
destring _3snrecommendforjobreciprocity1, replace
}
else {

}
capture confirm v _3snrecommendforjobintimacy
if !_rc {
destring _3snrecommendforjobintimacy, replace
}
else {

}
capture confirm v _3snrecojobsuccess
if !_rc {
destring _3snrecojobsuccess, replace
}
else {

}
capture confirm v _3snrecojobsuccessdummyfam
if !_rc {
destring _3snrecojobsuccessdummyfam, replace
}
else {

}
capture confirm v _3snrecojobsuccessdummyhh
if !_rc {
destring _3snrecojobsuccessdummyhh, replace
}
else {

}
capture confirm v _3snrecojobsuccessfriend
if !_rc {
destring _3snrecojobsuccessfriend, replace
}
else {

}
capture confirm v _3snrecojobsuccesswkp
if !_rc {
destring _3snrecojobsuccesswkp, replace
}
else {

}
capture confirm v _3snrecojobsuccesslabourrelation
if !_rc {
destring _3snrecojobsuccesslabourrelation, replace
}
else {

}
capture confirm v _3snrecojobsuccesssex
if !_rc {
destring _3snrecojobsuccesssex, replace
}
else {

}
capture confirm v _3snrecojobsuccessage
if !_rc {
destring _3snrecojobsuccessage, replace
}
else {

}
capture confirm v _3snrecojobsuccesslabourtype
if !_rc {
destring _3snrecojobsuccesslabourtype, replace
}
else {

}
capture confirm v _3snrecojobsuccesscastes
if !_rc {
destring _3snrecojobsuccesscastes, replace
}
else {

}
capture confirm v _3snrecojobsuccesseduc
if !_rc {
destring _3snrecojobsuccesseduc, replace
}
else {

}
capture confirm v _3snrecojobsuccessemployertype
if !_rc {
destring _3snrecojobsuccessemployertype, replace
}
else {

}
capture confirm v _3snrecojobsuccessliving
if !_rc {
destring _3snrecojobsuccessliving, replace
}
else {

}
capture confirm v _3snrecojobsuccessruralurban
if !_rc {
destring _3snrecojobsuccessruralurban, replace
}
else {

}
capture confirm v _3snrecojobsuccessdistrict
if !_rc {
destring _3snrecojobsuccessdistrict, replace
}
else {

}
capture confirm v _3snrecojobsuccesscompared
if !_rc {
destring _3snrecojobsuccesscompared, replace
}
else {

}
capture confirm v _3snrecojobsuccessmeet
if !_rc {
destring _3snrecojobsuccessmeet, replace
}
else {

}
capture confirm v _3snrecojobsuccessmeetfrequency
if !_rc {
destring _3snrecojobsuccessmeetfrequency, replace
}
else {

}
capture confirm v _3snrecojobsuccessinvite
if !_rc {
destring _3snrecojobsuccessinvite, replace
}
else {

}
capture confirm v _3snrecojobsuccessreciprocity1
if !_rc {
destring _3snrecojobsuccessreciprocity1, replace
}
else {

}
capture confirm v _3snrecojobsuccessintimacy
if !_rc {
destring _3snrecojobsuccessintimacy, replace
}
else {

}
capture confirm v _3sntalkthemostfriend
if !_rc {
destring _3sntalkthemostfriend, replace
}
else {

}
capture confirm v _3sntalkthemostwkp
if !_rc {
destring _3sntalkthemostwkp, replace
}
else {

}
capture confirm v _3sntalkthemostlabourrelation
if !_rc {
destring _3sntalkthemostlabourrelation, replace
}
else {

}
capture confirm v _3sntalkthemostsex
if !_rc {
destring _3sntalkthemostsex, replace
}
else {

}
capture confirm v _3sntalkthemostage
if !_rc {
destring _3sntalkthemostage, replace
}
else {

}
capture confirm v _3sntalkthemostlabourtype
if !_rc {
destring _3sntalkthemostlabourtype, replace
}
else {

}
capture confirm v _3sntalkthemostcastes
if !_rc {
destring _3sntalkthemostcastes, replace
}
else {

}
capture confirm v _3sntalkthemosteduc
if !_rc {
destring _3sntalkthemosteduc, replace
}
else {

}
capture confirm v _3sntalkthemostemployertype
if !_rc {
destring _3sntalkthemostemployertype, replace
}
else {

}
capture confirm v _3sntalkthemostliving
if !_rc {
destring _3sntalkthemostliving, replace
}
else {

}
capture confirm v _3sntalkthemostruralurban
if !_rc {
destring _3sntalkthemostruralurban, replace
}
else {

}
capture confirm v _3sntalkthemostdistrict
if !_rc {
destring _3sntalkthemostdistrict, replace
}
else {

}
capture confirm v _3sntalkthemostcompared
if !_rc {
destring _3sntalkthemostcompared, replace
}
else {

}
capture confirm v _3sntalkthemostmeet
if !_rc {
destring _3sntalkthemostmeet, replace
}
else {

}
capture confirm v _3sntalkthemostmeetfrequency
if !_rc {
destring _3sntalkthemostmeetfrequency, replace
}
else {

}
capture confirm v _3sntalkthemostinvite
if !_rc {
destring _3sntalkthemostinvite, replace
}
else {

}
capture confirm v _3sntalkthemostreciprocity1
if !_rc {
destring _3sntalkthemostreciprocity1, replace
}
else {

}
capture confirm v _3sntalkthemostintimacy
if !_rc {
destring _3sntalkthemostintimacy, replace
}
else {

}
capture confirm v _3snhelpemergencydummyfam
if !_rc {
destring _3snhelpemergencydummyfam, replace
}
else {

}
capture confirm v _3snhelpemergencydummyhh
if !_rc {
destring _3snhelpemergencydummyhh, replace
}
else {

}
capture confirm v _3snhelpemergencyfriend
if !_rc {
destring _3snhelpemergencyfriend, replace
}
else {

}
capture confirm v _3snhelpemergencywkp
if !_rc {
destring _3snhelpemergencywkp, replace
}
else {

}
capture confirm v _3snhelpemergencylabourrelation
if !_rc {
destring _3snhelpemergencylabourrelation, replace
}
else {

}
capture confirm v _3snhelpemergencysex
if !_rc {
destring _3snhelpemergencysex, replace
}
else {

}
capture confirm v _3snhelpemergencyage
if !_rc {
destring _3snhelpemergencyage, replace
}
else {

}
capture confirm v _3snhelpemergencylabourtype
if !_rc {
destring _3snhelpemergencylabourtype, replace
}
else {

}
capture confirm v _3snhelpemergencycastes
if !_rc {
destring _3snhelpemergencycastes, replace
}
else {

}
capture confirm v _3snhelpemergencyeduc
if !_rc {
destring _3snhelpemergencyeduc, replace
}
else {

}
capture confirm v _3snhelpemergencyemployertype
if !_rc {
destring _3snhelpemergencyemployertype, replace
}
else {

}
capture confirm v _3snhelpemergencyliving
if !_rc {
destring _3snhelpemergencyliving, replace
}
else {

}
capture confirm v _3snhelpemergencyruralurban
if !_rc {
destring _3snhelpemergencyruralurban, replace
}
else {

}
capture confirm v _3snhelpemergencydistrict
if !_rc {
destring _3snhelpemergencydistrict, replace
}
else {

}
capture confirm v _3snhelpemergencycompared
if !_rc {
destring _3snhelpemergencycompared, replace
}
else {

}
capture confirm v _3snhelpemergencymeet
if !_rc {
destring _3snhelpemergencymeet, replace
}
else {

}
capture confirm v _3snhelpemergencymeetfrequency
if !_rc {
destring _3snhelpemergencymeetfrequency, replace
}
else {

}
capture confirm v _3snhelpemergencyinvite
if !_rc {
destring _3snhelpemergencyinvite, replace
}
else {

}
capture confirm v _3snhelpemergencyreciprocity1
if !_rc {
destring _3snhelpemergencyreciprocity1, replace
}
else {

}
capture confirm v _3snhelpemergencyintimacy
if !_rc {
destring _3snhelpemergencyintimacy, replace
}
else {

}
capture confirm v _3sncloserelouthhdummyfam
if !_rc {
destring _3sncloserelouthhdummyfam, replace
}
else {

}
capture confirm v _3sncloserelouthhfriend
if !_rc {
destring _3sncloserelouthhfriend, replace
}
else {

}
capture confirm v _3sncloserelouthhwkp
if !_rc {
destring _3sncloserelouthhwkp, replace
}
else {

}
capture confirm v _3sncloserelouthhlabourrelation
if !_rc {
destring _3sncloserelouthhlabourrelation, replace
}
else {

}
capture confirm v _3sncloserelouthhsex
if !_rc {
destring _3sncloserelouthhsex, replace
}
else {

}
capture confirm v _3sncloserelouthhage
if !_rc {
destring _3sncloserelouthhage, replace
}
else {

}
capture confirm v _3sncloserelouthhlabourtype
if !_rc {
destring _3sncloserelouthhlabourtype, replace
}
else {

}
capture confirm v _3sncloserelouthhcastes
if !_rc {
destring _3sncloserelouthhcastes, replace
}
else {

}
capture confirm v _3sncloserelouthheduc
if !_rc {
destring _3sncloserelouthheduc, replace
}
else {

}
capture confirm v _3sncloserelouthhemployertype
if !_rc {
destring _3sncloserelouthhemployertype, replace
}
else {

}
capture confirm v _3sncloserelouthhliving
if !_rc {
destring _3sncloserelouthhliving, replace
}
else {

}
capture confirm v _3sncloserelouthhruralurban
if !_rc {
destring _3sncloserelouthhruralurban, replace
}
else {

}
capture confirm v _3sncloserelouthhdistrict
if !_rc {
destring _3sncloserelouthhdistrict, replace
}
else {

}
capture confirm v _3sncloserelouthhcompared
if !_rc {
destring _3sncloserelouthhcompared, replace
}
else {

}
capture confirm v _3sncloserelouthhmeet
if !_rc {
destring _3sncloserelouthhmeet, replace
}
else {

}
capture confirm v _3sncloserelouthhmeetfrequency
if !_rc {
destring _3sncloserelouthhmeetfrequency, replace
}
else {

}
capture confirm v _3sncloserelouthhinvite
if !_rc {
destring _3sncloserelouthhinvite, replace
}
else {

}
capture confirm v _3sncloserelouthhreciprocity1
if !_rc {
destring _3sncloserelouthhreciprocity1, replace
}
else {

}
capture confirm v _3sncloserelouthhintimacy
if !_rc {
destring _3sncloserelouthhintimacy, replace
}
else {

}
capture confirm v _3nbercontactphone
if !_rc {
destring _3nbercontactphone, replace
}
else {

}
capture confirm v _3dummycontactleaders
if !_rc {
destring _3dummycontactleaders, replace
}
else {

}
capture confirm v _3networktrustneighborhood
if !_rc {
destring _3networktrustneighborhood, replace
}
else {

}
capture confirm v _3covneworktrustneighborhood
if !_rc {
destring _3covneworktrustneighborhood, replace
}
else {

}
capture confirm v _3networktrustemployees
if !_rc {
destring _3networktrustemployees, replace
}
else {

}
capture confirm v _3networkpeoplehelping
if !_rc {
destring _3networkpeoplehelping, replace
}
else {

}
capture confirm v _3covnetworkpeoplehelping
if !_rc {
destring _3covnetworkpeoplehelping, replace
}
else {

}
capture confirm v _3networkhelpkinmember
if !_rc {
destring _3networkhelpkinmember, replace
}
else {

}
capture confirm v _3covnetworkhelpkinmember
if !_rc {
destring _3covnetworkhelpkinmember, replace
}
else {

}
capture confirm v _3covinstit1
if !_rc {
destring _3covinstit1, replace
}
else {

}
capture confirm v _3covinstit2
if !_rc {
destring _3covinstit2, replace
}
else {

}
capture confirm v _3covinstit3
if !_rc {
destring _3covinstit3, replace
}
else {

}
capture confirm v _3covinstit4
if !_rc {
destring _3covinstit4, replace
}
else {

}
capture confirm v _3covinstit5
if !_rc {
destring _3covinstit5, replace
}
else {

}
capture confirm v _3covcontactinstitution
if !_rc {
destring _3covcontactinstitution, replace
}
else {

}
capture confirm v _3covinstit6
if !_rc {
destring _3covinstit6, replace
}
else {

}
capture confirm v _3covinstit7
if !_rc {
destring _3covinstit7, replace
}
else {

}
capture confirm v _3covinstit8
if !_rc {
destring _3covinstit8, replace
}
else {

}
capture confirm v _3covinstit9
if !_rc {
destring _3covinstit9, replace
}
else {

}
capture confirm v _3covinstit10
if !_rc {
destring _3covinstit10, replace
}
else {

}
capture confirm v _3B1
if !_rc {
destring _3B1, replace
}
else {

}
capture confirm v _3B2
if !_rc {
destring _3B2, replace
}
else {

}
capture confirm v _3B3
if !_rc {
destring _3B3, replace
}
else {

}
capture confirm v _3B4
if !_rc {
destring _3B4, replace
}
else {

}
capture confirm v _3B5
if !_rc {
destring _3B5, replace
}
else {

}
capture confirm v _3B6
if !_rc {
destring _3B6, replace
}
else {

}
capture confirm v _3B7
if !_rc {
destring _3B7, replace
}
else {

}
capture confirm v _3B8
if !_rc {
destring _3B8, replace
}
else {

}
capture confirm v _3B9
if !_rc {
destring _3B9, replace
}
else {

}
capture confirm v _3B10
if !_rc {
destring _3B10, replace
}
else {

}
capture confirm v _3B11
if !_rc {
destring _3B11, replace
}
else {

}
capture confirm v _3B12
if !_rc {
destring _3B12, replace
}
else {

}
capture confirm v _3enjoypeople
if !_rc {
destring _3enjoypeople, replace
}
else {

}
capture confirm v _3curious
if !_rc {
destring _3curious, replace
}
else {

}
capture confirm v _3organized
if !_rc {
destring _3organized, replace
}
else {

}
capture confirm v _3managestress
if !_rc {
destring _3managestress, replace
}
else {

}
capture confirm v _3interestedbyart
if !_rc {
destring _3interestedbyart, replace
}
else {

}
capture confirm v _3tryhard
if !_rc {
destring _3tryhard, replace
}
else {

}
capture confirm v _3workwithother
if !_rc {
destring _3workwithother, replace
}
else {

}
capture confirm v _3makeplans
if !_rc {
destring _3makeplans, replace
}
else {

}
capture confirm v _3sharefeelings
if !_rc {
destring _3sharefeelings, replace
}
else {

}
capture confirm v _3nervous
if !_rc {
destring _3nervous, replace
}
else {

}
capture confirm v _3stickwithgoals
if !_rc {
destring _3stickwithgoals, replace
}
else {

}
capture confirm v _3repetitivetasks
if !_rc {
destring _3repetitivetasks, replace
}
else {

}
capture confirm v _3shywithpeople
if !_rc {
destring _3shywithpeople, replace
}
else {

}
capture confirm v _3workhard
if !_rc {
destring _3workhard, replace
}
else {

}
capture confirm v _3changemood
if !_rc {
destring _3changemood, replace
}
else {

}
capture confirm v _3understandotherfeeling
if !_rc {
destring _3understandotherfeeling, replace
}
else {

}
capture confirm v _3inventive
if !_rc {
destring _3inventive, replace
}
else {

}
capture confirm v _3enthusiastic
if !_rc {
destring _3enthusiastic, replace
}
else {

}
capture confirm v _3feeldepressed
if !_rc {
destring _3feeldepressed, replace
}
else {

}
capture confirm v _3appointmentontime
if !_rc {
destring _3appointmentontime, replace
}
else {

}
capture confirm v _3trustingofother
if !_rc {
destring _3trustingofother, replace
}
else {

}
capture confirm v _3goaftergoal
if !_rc {
destring _3goaftergoal, replace
}
else {

}
capture confirm v _3easilyupset
if !_rc {
destring _3easilyupset, replace
}
else {

}
capture confirm v _3talktomanypeople
if !_rc {
destring _3talktomanypeople, replace
}
else {

}
capture confirm v _3liketothink
if !_rc {
destring _3liketothink, replace
}
else {

}
capture confirm v _3finishwhatbegin
if !_rc {
destring _3finishwhatbegin, replace
}
else {

}
capture confirm v _3putoffduties
if !_rc {
destring _3putoffduties, replace
}
else {

}
capture confirm v _3rudetoother
if !_rc {
destring _3rudetoother, replace
}
else {

}
capture confirm v _3finishtasks
if !_rc {
destring _3finishtasks, replace
}
else {

}
capture confirm v _3toleratefaults
if !_rc {
destring _3toleratefaults, replace
}
else {

}
capture confirm v _3worryalot
if !_rc {
destring _3worryalot, replace
}
else {

}
capture confirm v _3easilydistracted
if !_rc {
destring _3easilydistracted, replace
}
else {

}
capture confirm v _3keepworking
if !_rc {
destring _3keepworking, replace
}
else {

}
capture confirm v _3completeduties
if !_rc {
destring _3completeduties, replace
}
else {

}
capture confirm v _3talkative
if !_rc {
destring _3talkative, replace
}
else {

}
capture confirm v _3newideas
if !_rc {
destring _3newideas, replace
}
else {

}
capture confirm v _3staycalm
if !_rc {
destring _3staycalm, replace
}
else {

}
capture confirm v _3forgiveother
if !_rc {
destring _3forgiveother, replace
}
else {

}
capture confirm v _3activeimagination
if !_rc {
destring _3activeimagination, replace
}
else {

}
capture confirm v _3expressingthoughts
if !_rc {
destring _3expressingthoughts, replace
}
else {

}
capture confirm v _3helpfulwithothers
if !_rc {
destring _3helpfulwithothers, replace
}
else {

}
capture confirm v _3canreadcard1a
if !_rc {
destring _3canreadcard1a, replace
}
else {

}
capture confirm v _3canreadcard1b
if !_rc {
destring _3canreadcard1b, replace
}
else {

}
capture confirm v _3canreadcard1c
if !_rc {
destring _3canreadcard1c, replace
}
else {

}
capture confirm v _3canreadcard2
if !_rc {
destring _3canreadcard2, replace
}
else {

}
capture confirm v _3numeracy1
if !_rc {
destring _3numeracy1, replace
}
else {

}
capture confirm v _3numeracy2
if !_rc {
destring _3numeracy2, replace
}
else {

}
capture confirm v _3numeracy5
if !_rc {
destring _3numeracy5, replace
}
else {

}
capture confirm v _3numeracy6
if !_rc {
destring _3numeracy6, replace
}
else {

}
capture confirm v _3numeracy3
if !_rc {
destring _3numeracy3, replace
}
else {

}
capture confirm v _3numeracy4
if !_rc {
destring _3numeracy4, replace
}
else {

}
capture confirm v _3Ab1
if !_rc {
destring _3Ab1, replace
}
else {

}
capture confirm v _3Ab2
if !_rc {
destring _3Ab2, replace
}
else {

}
capture confirm v _3Ab3
if !_rc {
destring _3Ab3, replace
}
else {

}
capture confirm v _3Ab4
if !_rc {
destring _3Ab4, replace
}
else {

}
capture confirm v _3Ab5
if !_rc {
destring _3Ab5, replace
}
else {

}
capture confirm v _3Ab6
if !_rc {
destring _3Ab6, replace
}
else {

}
capture confirm v _3Ab7
if !_rc {
destring _3Ab7, replace
}
else {

}
capture confirm v _3Ab8
if !_rc {
destring _3Ab8, replace
}
else {

}
capture confirm v _3Ab9
if !_rc {
destring _3Ab9, replace
}
else {

}
capture confirm v _3Ab10
if !_rc {
destring _3Ab10, replace
}
else {

}
capture confirm v _3Ab11
if !_rc {
destring _3Ab11, replace
}
else {

}
capture confirm v _3Ab12
if !_rc {
destring _3Ab12, replace
}
else {

}
capture confirm numeric v businesscastebased
if !_rc {
replace businesscastebased =. if businesscastebased >2
}
else {

}
capture confirm numeric v businessnbpaidworkers
if !_rc {
replace businessnbpaidworkers =. if businessnbpaidworkers >16
}
else {

}
capture confirm numeric v snfindcurrentjobmeet
if !_rc {
replace snfindcurrentjobmeet =77 if snfindcurrentjobmeet ==7
}
else {

}
capture confirm numeric v snhelpemergencydistrict
if !_rc {
replace snhelpemergencydistrict =. if snhelpemergencydistrict >37
}
else {

}
capture confirm numeric v remsentmoney
if !_rc {
replace remsentmoney =. if remsentmoney >2
}
else {

}
capture confirm numeric v businessnbworkers
if !_rc {
replace businessnbworkers =. if businessnbworkers >16
}
else {

}
capture confirm numeric v inventive
if !_rc {
replace inventive =. if inventive >6
}
else {

}
capture confirm numeric v dummyloanfromborrower
if !_rc {
replace dummyloanfromborrower =. if dummyloanfromborrower >2
}
else {

}
capture confirm numeric v _2resdiscrimination1
if !_rc {
replace _2resdiscrimination1 =. if _2resdiscrimination1 >2
}
else {

}
capture confirm numeric v _3businessnbunpaidworkers
if !_rc {
replace _3businessnbunpaidworkers =. if _3businessnbunpaidworkers >16
}
else {

}
capture confirm numeric v guaranteetype
if !_rc {
replace guaranteetype =. if guaranteetype >2
}
else {

}
capture confirm numeric v otherlenderservices
if !_rc {
replace otherlenderservices =77 if otherlenderservices ==6
}
else {

}
capture confirm numeric v decisionearnwork
if !_rc {
replace decisionearnwork =. if decisionearnwork >10
}
else {

}
capture confirm numeric v snfindcurrentjobruralurban
if !_rc {
replace snfindcurrentjobruralurban =. if snfindcurrentjobruralurban >2
}
else {

}
capture confirm numeric v _3snfindcurrentjobdistrict
if !_rc {
replace _3snfindcurrentjobdistrict =. if _3snfindcurrentjobdistrict >37
}
else {

}
capture confirm numeric v canreadcard1b
if !_rc {
replace canreadcard1b =. if canreadcard1b >4
}
else {

}
capture confirm numeric v respect
if !_rc {
replace respect =. if respect >4
}
else {

}
capture confirm numeric v loanproductpledge
if !_rc {
replace loanproductpledge =. if loanproductpledge >17
}
else {

}
capture confirm numeric v rationcarduse
if !_rc {
replace rationcarduse =. if rationcarduse >2
}
else {

}
capture confirm numeric v sncloserelouthhlabourrelation
if !_rc {
replace sncloserelouthhlabourrelation =. if sncloserelouthhlabourrelation >2
}
else {

}
capture confirm numeric v additionalloan
if !_rc {
replace additionalloan =. if additionalloan >2
}
else {

}
capture confirm numeric v migrationtype
if !_rc {
replace migrationtype =. if migrationtype >2
}
else {

}
capture confirm numeric v _3enthusiastic
if !_rc {
replace _3enthusiastic =. if _3enthusiastic >6
}
else {

}
capture confirm numeric v workmate
if !_rc {
replace workmate =. if workmate >4
}
else {

}
capture confirm numeric v _2jobpreference
if !_rc {
replace _2jobpreference =99 if _2jobpreference ==3
}
else {

}
capture confirm numeric v marriagegifttype
if !_rc {
replace marriagegifttype =. if marriagegifttype >6
}
else {

}
capture confirm numeric v locuscontrol6
if !_rc {
replace locuscontrol6 =. if locuscontrol6 >5
}
else {

}
capture confirm numeric v sntalkthemostage
if !_rc {
replace sntalkthemostage =. if sntalkthemostage >6
}
else {

}
capture confirm numeric v ego2random_3
if !_rc {
replace ego2random_3 =. if ego2random_3 >2
}
else {

}
capture confirm numeric v completeduties
if !_rc {
replace completeduties =. if completeduties >6
}
else {

}
capture confirm numeric v joblocation
if !_rc {
replace joblocation =. if joblocation >7
}
else {

}
capture confirm numeric v reasondontsearchjobsince15
if !_rc {
replace reasondontsearchjobsince15 =. if reasondontsearchjobsince15 >15
}
else {

}
capture confirm numeric v migrationdurationfrequency
if !_rc {
replace migrationdurationfrequency =. if migrationdurationfrequency >4
}
else {

}
capture confirm numeric v usecreditcard
if !_rc {
replace usecreditcard =. if usecreditcard >7
}
else {

}
capture confirm numeric v sncloserelouthhmeetfrequency
if !_rc {
replace sncloserelouthhmeetfrequency =. if sncloserelouthhmeetfrequency >6
}
else {

}
capture confirm numeric v lenderscastegold
if !_rc {
replace lenderscastegold =66 if lenderscastegold ==17
}
else {

}
capture confirm numeric v _2snhelpemergencyage
if !_rc {
replace _2snhelpemergencyage =. if _2snhelpemergencyage >6
}
else {

}
capture confirm numeric v snrecojobsuccesssex
if !_rc {
replace snrecojobsuccesssex =. if snrecojobsuccesssex >2
}
else {

}
capture confirm numeric v _3sntalkthemostintimacy
if !_rc {
replace _3sntalkthemostintimacy =. if _3sntalkthemostintimacy >3
}
else {

}
capture confirm numeric v _2snfindcurrentjobfriend
if !_rc {
replace _2snfindcurrentjobfriend =. if _2snfindcurrentjobfriend >2
}
else {

}
capture confirm numeric v loaneffectivereason2
if !_rc {
replace loaneffectivereason2 =. if loaneffectivereason2 >13
}
else {

}
capture confirm numeric v _2locuscontrol6
if !_rc {
replace _2locuscontrol6 =. if _2locuscontrol6 >5
}
else {

}
capture confirm numeric v Ab9
if !_rc {
replace Ab9 =. if Ab9 >7
}
else {

}
capture confirm numeric v marriagetype
if !_rc {
replace marriagetype =. if marriagetype >2
}
else {

}
capture confirm numeric v _3stickwithgoals
if !_rc {
replace _3stickwithgoals =. if _3stickwithgoals >6
}
else {

}
capture confirm numeric v _2snfindsuppliersmeet
if !_rc {
replace _2snfindsuppliersmeet =77 if _2snfindsuppliersmeet ==7
}
else {

}
capture confirm numeric v covtest
if !_rc {
replace covtest =66 if covtest ==3
}
else {

}
capture confirm numeric v _3sntalkthemostwkp
if !_rc {
replace _3sntalkthemostwkp =. if _3sntalkthemostwkp >2
}
else {

}
capture confirm numeric v sncloserelouthhemployertype
if !_rc {
replace sncloserelouthhemployertype =. if sncloserelouthhemployertype >8
}
else {

}
capture confirm numeric v snfindjoblabourrelation
if !_rc {
replace snfindjoblabourrelation =. if snfindjoblabourrelation >2
}
else {

}
capture confirm numeric v _2snrecommendforjobintimacy
if !_rc {
replace _2snrecommendforjobintimacy =. if _2snrecommendforjobintimacy >3
}
else {

}
capture confirm numeric v _3A3
if !_rc {
replace _3A3 =. if _3A3 >7
}
else {

}
capture confirm numeric v insurancetype
if !_rc {
replace insurancetype =. if insurancetype >2
}
else {

}
capture confirm numeric v _3snrecommendforjoblabourrelation
if !_rc {
replace _3snrecommendforjoblabourrelation =. if _3snrecommendforjoblabourrelation >2
}
else {

}
capture confirm numeric v _2B4
if !_rc {
replace _2B4 =. if _2B4 >7
}
else {

}
capture confirm numeric v _3snfindsupplierseduc
if !_rc {
replace _3snfindsupplierseduc =. if _3snfindsupplierseduc >7
}
else {

}
capture confirm numeric v snfindjobinvite
if !_rc {
replace snfindjobinvite =. if snfindjobinvite >2
}
else {

}
capture confirm numeric v _3snfindjobintimacy
if !_rc {
replace _3snfindjobintimacy =. if _3snfindjobintimacy >3
}
else {

}
capture confirm numeric v helptosettleloan
if !_rc {
replace helptosettleloan =. if helptosettleloan >14
}
else {

}
capture confirm numeric v snrecruitworkerdummyhh
if !_rc {
replace snrecruitworkerdummyhh =. if snrecruitworkerdummyhh >2
}
else {

}
capture confirm numeric v _2meetbusinesslender
if !_rc {
replace _2meetbusinesslender =77 if _2meetbusinesslender ==7
}
else {

}
capture confirm numeric v snhelpemergencyintimacy
if !_rc {
replace snhelpemergencyintimacy =. if snhelpemergencyintimacy >3
}
else {

}
capture confirm numeric v _2losswork
if !_rc {
replace _2losswork =. if _2losswork >2
}
else {

}
capture confirm numeric v _2discrimination2
if !_rc {
replace _2discrimination2 =. if _2discrimination2 >2
}
else {

}
capture confirm numeric v snentrustbusinessinvite
if !_rc {
replace snentrustbusinessinvite =. if snentrustbusinessinvite >2
}
else {

}
capture confirm numeric v _2snrecommendassomeet
if !_rc {
replace _2snrecommendassomeet =77 if _2snrecommendassomeet ==7
}
else {

}
capture confirm numeric v _3snrecruitworkereduc
if !_rc {
replace _3snrecruitworkereduc =. if _3snrecruitworkereduc >7
}
else {

}
capture confirm numeric v _2snfindcurrentjobmeet
if !_rc {
replace _2snfindcurrentjobmeet =77 if _2snfindcurrentjobmeet ==7
}
else {

}
capture confirm numeric v _2snfindjoblabourrelation
if !_rc {
replace _2snfindjoblabourrelation =. if _2snfindjoblabourrelation >2
}
else {

}
capture confirm numeric v workexposure3
if !_rc {
replace workexposure3 =. if workexposure3 >5
}
else {

}
capture confirm numeric v easilydistracted
if !_rc {
replace easilydistracted =. if easilydistracted >6
}
else {

}
capture confirm numeric v snhelpemergencymeet
if !_rc {
replace snhelpemergencymeet =77 if snhelpemergencymeet ==7
}
else {

}
capture confirm numeric v _3covcontactinstitution
if !_rc {
replace _3covcontactinstitution =. if _3covcontactinstitution >6
}
else {

}
capture confirm numeric v snhelpemergencymeetfrequency
if !_rc {
replace snhelpemergencymeetfrequency =. if snhelpemergencymeetfrequency >6
}
else {

}
capture confirm numeric v sntalkthemostmeet
if !_rc {
replace sntalkthemostmeet =77 if sntalkthemostmeet ==7
}
else {

}
capture confirm numeric v _3sntalkthemostmeet
if !_rc {
replace _3sntalkthemostmeet =77 if _3sntalkthemostmeet ==7
}
else {

}
capture confirm numeric v liketothink
if !_rc {
replace liketothink =. if liketothink >6
}
else {

}
capture confirm numeric v dummymarriagegift
if !_rc {
replace dummymarriagegift =. if dummymarriagegift >2
}
else {

}
capture confirm numeric v termsofrepayment
if !_rc {
replace termsofrepayment =66 if termsofrepayment ==4
}
else {

}
capture confirm numeric v _3snrecommendassoage
if !_rc {
replace _3snrecommendassoage =. if _3snrecommendassoage >6
}
else {

}
capture confirm numeric v _2snfindcurrentjobliving
if !_rc {
replace _2snfindcurrentjobliving =. if _2snfindcurrentjobliving >6
}
else {

}
capture confirm numeric v snrecojobsuccessinvite
if !_rc {
replace snrecojobsuccessinvite =. if snrecojobsuccessinvite >2
}
else {

}
capture confirm numeric v _3sntalkthemostmeetfrequency
if !_rc {
replace _3sntalkthemostmeetfrequency =. if _3sntalkthemostmeetfrequency >6
}
else {

}
capture confirm numeric v borrowerscaste
if !_rc {
replace borrowerscaste =. if borrowerscaste >17
}
else {

}
capture confirm numeric v A1
if !_rc {
replace A1 =. if A1 >7
}
else {

}
capture confirm numeric v snrecruitworkercompared
if !_rc {
replace snrecruitworkercompared =. if snrecruitworkercompared >3
}
else {

}
capture confirm numeric v sntalkthemostliving
if !_rc {
replace sntalkthemostliving =. if sntalkthemostliving >6
}
else {

}
capture confirm numeric v _3snrecojobsuccessreciprocity1
if !_rc {
replace _3snrecojobsuccessreciprocity1 =. if _3snrecojobsuccessreciprocity1 >2
}
else {

}
capture confirm numeric v dummybusinessunpaidworkers
if !_rc {
replace dummybusinessunpaidworkers =. if dummybusinessunpaidworkers >2
}
else {

}
capture confirm numeric v _2snfindsuppliersmeetfrequency
if !_rc {
replace _2snfindsuppliersmeetfrequency =. if _2snfindsuppliersmeetfrequency >6
}
else {

}
capture confirm numeric v dummypreviouswagejob
if !_rc {
replace dummypreviouswagejob =. if dummypreviouswagejob >2
}
else {

}
capture confirm numeric v _2numeracy6
if !_rc {
replace _2numeracy6 =. if _2numeracy6 >3
}
else {

}
capture confirm numeric v _2snfindcurrentjobmeetfrequency
if !_rc {
replace _2snfindcurrentjobmeetfrequency =. if _2snfindcurrentjobmeetfrequency >6
}
else {

}
capture confirm numeric v snrecommendforjobcastes
if !_rc {
replace snrecommendforjobcastes =. if snrecommendforjobcastes >17
}
else {

}
capture confirm numeric v _3snhelpemergencymeetfrequency
if !_rc {
replace _3snhelpemergencymeetfrequency =. if _3snhelpemergencymeetfrequency >6
}
else {

}
capture confirm numeric v snrecommendassomeetfrequency
if !_rc {
replace snrecommendassomeetfrequency =. if snrecommendassomeetfrequency >6
}
else {

}
capture confirm numeric v _3sntalkthemostreciprocity1
if !_rc {
replace _3sntalkthemostreciprocity1 =. if _3sntalkthemostreciprocity1 >2
}
else {

}
capture confirm numeric v networkpeoplehelping
if !_rc {
replace networkpeoplehelping =. if networkpeoplehelping >6
}
else {

}
capture confirm numeric v _3worryalot
if !_rc {
replace _3worryalot =. if _3worryalot >6
}
else {

}
capture confirm numeric v sntalkthemostmeetfrequency
if !_rc {
replace sntalkthemostmeetfrequency =. if sntalkthemostmeetfrequency >6
}
else {

}
capture confirm numeric v executionwork4
if !_rc {
replace executionwork4 =. if executionwork4 >2
}
else {

}
capture confirm numeric v snentrustbusinessmeetfrequency
if !_rc {
replace snentrustbusinessmeetfrequency =. if snentrustbusinessmeetfrequency >6
}
else {

}
capture confirm numeric v resdiscrimination5
if !_rc {
replace resdiscrimination5 =. if resdiscrimination5 >2
}
else {

}
capture confirm numeric v _3snhelpemergencymeet
if !_rc {
replace _3snhelpemergencymeet =77 if _3snhelpemergencymeet ==7
}
else {

}
capture confirm numeric v snfindsupplierswkp
if !_rc {
replace snfindsupplierswkp =. if snfindsupplierswkp >2
}
else {

}
capture confirm numeric v banktype
if !_rc {
replace banktype =. if banktype >3
}
else {

}
capture confirm numeric v _3snrecommendforjobmeetfrequency
if !_rc {
replace _3snrecommendforjobmeetfrequency =. if _3snrecommendforjobmeetfrequency >6
}
else {

}
capture confirm numeric v _2useknowledgeatwork
if !_rc {
replace _2useknowledgeatwork =. if _2useknowledgeatwork >4
}
else {

}
capture confirm numeric v snrecommendforjobmeet
if !_rc {
replace snrecommendforjobmeet =77 if snrecommendforjobmeet ==7
}
else {

}
capture confirm numeric v Ab4
if !_rc {
replace Ab4 =. if Ab4 >7
}
else {

}
capture confirm numeric v lenderfrom
if !_rc {
replace lenderfrom =. if lenderfrom >4
}
else {

}
capture confirm numeric v remsentplace
if !_rc {
replace remsentplace =. if remsentplace >6
}
else {

}
capture confirm numeric v ego2random_1_3
if !_rc {
replace ego2random_1_3 =. if ego2random_1_3 >2
}
else {

}
capture confirm numeric v _3sncloserelouthhmeet
if !_rc {
replace _3sncloserelouthhmeet =77 if _3sncloserelouthhmeet ==7
}
else {

}
capture confirm numeric v _3snentrustbusinessmeetfrequency
if !_rc {
replace _3snentrustbusinessmeetfrequency =. if _3snentrustbusinessmeetfrequency >6
}
else {

}
capture confirm numeric v _2sharefeelings
if !_rc {
replace _2sharefeelings =. if _2sharefeelings >6
}
else {

}
capture confirm numeric v _3snrecruitworker
if !_rc {
replace _3snrecruitworker =. if _3snrecruitworker >3
}
else {

}
capture confirm numeric v _3snfindsuppliersdummyhh
if !_rc {
replace _3snfindsuppliersdummyhh =. if _3snfindsuppliersdummyhh >2
}
else {

}
capture confirm numeric v snfindcurrentjobdummyhh
if !_rc {
replace snfindcurrentjobdummyhh =. if snfindcurrentjobdummyhh >2
}
else {

}
capture confirm numeric v _2snrecommendforjobcastes
if !_rc {
replace _2snrecommendforjobcastes =. if _2snrecommendforjobcastes >17
}
else {

}
capture confirm numeric v _2resdiscrimination4
if !_rc {
replace _2resdiscrimination4 =. if _2resdiscrimination4 >2
}
else {

}
capture confirm numeric v _3locuscontrol4
if !_rc {
replace _3locuscontrol4 =. if _3locuscontrol4 >5
}
else {

}
capture confirm numeric v _2snrecruitworkermeet
if !_rc {
replace _2snrecruitworkermeet =77 if _2snrecruitworkermeet ==7
}
else {

}
capture confirm numeric v _2networktrustneighborhood
if !_rc {
replace _2networktrustneighborhood =. if _2networktrustneighborhood >6
}
else {

}
capture confirm numeric v _3snrecommendforjobmeet
if !_rc {
replace _3snrecommendforjobmeet =77 if _3snrecommendforjobmeet ==7
}
else {

}
capture confirm numeric v _2snentrustbusinessage
if !_rc {
replace _2snentrustbusinessage =. if _2snentrustbusinessage >6
}
else {

}
capture confirm numeric v migrationinsurance
if !_rc {
replace migrationinsurance =. if migrationinsurance >2
}
else {

}
capture confirm numeric v _3ego2random_3_2
if !_rc {
replace _3ego2random_3_2 =. if _3ego2random_3_2 >2
}
else {

}
capture confirm numeric v _3sntalkthemostfriend
if !_rc {
replace _3sntalkthemostfriend =. if _3sntalkthemostfriend >2
}
else {

}
capture confirm numeric v sntalkthemostruralurban
if !_rc {
replace sntalkthemostruralurban =. if sntalkthemostruralurban >2
}
else {

}
capture confirm numeric v snrecommendassointimacy
if !_rc {
replace snrecommendassointimacy =. if snrecommendassointimacy >3
}
else {

}
capture confirm numeric v B7
if !_rc {
replace B7 =. if B7 >7
}
else {

}
capture confirm numeric v _3locuscontrol5
if !_rc {
replace _3locuscontrol5 =. if _3locuscontrol5 >5
}
else {

}
capture confirm numeric v _3executionwork1
if !_rc {
replace _3executionwork1 =. if _3executionwork1 >2
}
else {

}
capture confirm numeric v _2snentrustbusinessinvite
if !_rc {
replace _2snentrustbusinessinvite =. if _2snentrustbusinessinvite >2
}
else {

}
capture confirm numeric v snfindsuppliersreciprocity1
if !_rc {
replace snfindsuppliersreciprocity1 =. if snfindsuppliersreciprocity1 >2
}
else {

}
capture confirm numeric v A2
if !_rc {
replace A2 =. if A2 >7
}
else {

}
capture confirm numeric v _2decisionwork
if !_rc {
replace _2decisionwork =77 if _2decisionwork ==6
}
else {

}
capture confirm numeric v _3snhelpemergencydummyhh
if !_rc {
replace _3snhelpemergencydummyhh =. if _3snhelpemergencydummyhh >2
}
else {

}
capture confirm numeric v readystartjob
if !_rc {
replace readystartjob =. if readystartjob >2
}
else {

}
capture confirm numeric v problemwork6
if !_rc {
replace problemwork6 =66 if problemwork6 ==4
}
else {

}
capture confirm numeric v _2snfindjobintimacy
if !_rc {
replace _2snfindjobintimacy =. if _2snfindjobintimacy >3
}
else {

}
capture confirm numeric v _3rurallocation
if !_rc {
replace _3rurallocation =. if _3rurallocation >2
}
else {

}
capture confirm numeric v _3helpfulwithothers
if !_rc {
replace _3helpfulwithothers =. if _3helpfulwithothers >6
}
else {

}
capture confirm numeric v dummybusinesspaidworkers
if !_rc {
replace dummybusinesspaidworkers =. if dummybusinesspaidworkers >2
}
else {

}
capture confirm numeric v dummyproblemtorepay
if !_rc {
replace dummyproblemtorepay =. if dummyproblemtorepay >2
}
else {

}
capture confirm numeric v _2snrecommendassosex
if !_rc {
replace _2snrecommendassosex =. if _2snrecommendassosex >2
}
else {

}
capture confirm numeric v _3sncloserelouthhlabourtype
if !_rc {
replace _3sncloserelouthhlabourtype =. if _3sncloserelouthhlabourtype >4
}
else {

}
capture confirm numeric v _2snfindjobage
if !_rc {
replace _2snfindjobage =. if _2snfindjobage >6
}
else {

}
capture confirm numeric v _2dummyseasonalmainoccup
if !_rc {
replace _2dummyseasonalmainoccup =. if _2dummyseasonalmainoccup >2
}
else {

}
capture confirm numeric v loanproductpledge
if !_rc {
replace loanproductpledge =77 if loanproductpledge ==17
}
else {

}
capture confirm numeric v remreceivedsourceoccup
if !_rc {
replace remreceivedsourceoccup =. if remreceivedsourceoccup >8
}
else {

}
capture confirm numeric v _2dummybusinesspaidworkers
if !_rc {
replace _2dummybusinesspaidworkers =. if _2dummybusinesspaidworkers >2
}
else {

}
capture confirm numeric v canreadcard1c
if !_rc {
replace canreadcard1c =99 if canreadcard1c ==4
}
else {

}
capture confirm numeric v _2B6
if !_rc {
replace _2B6 =. if _2B6 >7
}
else {

}
capture confirm numeric v snfindjobintimacy
if !_rc {
replace snfindjobintimacy =. if snfindjobintimacy >3
}
else {

}
capture confirm numeric v snfindcurrentjobage
if !_rc {
replace snfindcurrentjobage =. if snfindcurrentjobage >6
}
else {

}
capture confirm numeric v snfindjobliving
if !_rc {
replace snfindjobliving =. if snfindjobliving >6
}
else {

}
capture confirm numeric v _3snfindcurrentjobintimacy
if !_rc {
replace _3snfindcurrentjobintimacy =. if _3snfindcurrentjobintimacy >3
}
else {

}
capture confirm numeric v _2snrecojobsuccessliving
if !_rc {
replace _2snrecojobsuccessliving =. if _2snrecojobsuccessliving >6
}
else {

}
capture confirm numeric v _2executionwork9
if !_rc {
replace _2executionwork9 =. if _2executionwork9 >2
}
else {

}
capture confirm numeric v salariedjobbonus
if !_rc {
replace salariedjobbonus =. if salariedjobbonus >2
}
else {

}
capture confirm numeric v canreadcard1a
if !_rc {
replace canreadcard1a =99 if canreadcard1a ==4
}
else {

}
capture confirm numeric v _3snhelpemergencyemployertype
if !_rc {
replace _3snhelpemergencyemployertype =. if _3snhelpemergencyemployertype >8
}
else {

}
capture confirm numeric v _3Ab1
if !_rc {
replace _3Ab1 =. if _3Ab1 >7
}
else {

}
capture confirm numeric v _3problemwork7
if !_rc {
replace _3problemwork7 =66 if _3problemwork7 ==4
}
else {

}
capture confirm numeric v _2rudetoother
if !_rc {
replace _2rudetoother =. if _2rudetoother >6
}
else {

}
capture confirm numeric v snfindcurrentjobintimacy
if !_rc {
replace snfindcurrentjobintimacy =. if snfindcurrentjobintimacy >3
}
else {

}
capture confirm numeric v ego2random_3_2
if !_rc {
replace ego2random_3_2 =. if ego2random_3_2 >2
}
else {

}
capture confirm numeric v _2snhelpemergencyliving
if !_rc {
replace _2snhelpemergencyliving =. if _2snhelpemergencyliving >6
}
else {

}
capture confirm numeric v interestedbyart
if !_rc {
replace interestedbyart =. if interestedbyart >6
}
else {

}
capture confirm numeric v _3wagejobpaymentinkind
if !_rc {
replace _3wagejobpaymentinkind =. if _3wagejobpaymentinkind >2
}
else {

}
capture confirm numeric v _3sncloserelouthhliving
if !_rc {
replace _3sncloserelouthhliving =. if _3sncloserelouthhliving >6
}
else {

}
capture confirm numeric v marriagelenderfrom
if !_rc {
replace marriagelenderfrom =. if marriagelenderfrom >6
}
else {

}
capture confirm numeric v snfindcurrentjob
if !_rc {
replace snfindcurrentjob =. if snfindcurrentjob >3
}
else {

}
capture confirm numeric v agebusinesslender
if !_rc {
replace agebusinesslender =. if agebusinesslender >6
}
else {

}
capture confirm numeric v covinstit9
if !_rc {
replace covinstit9 =. if covinstit9 >3
}
else {

}
capture confirm numeric v numeracy6
if !_rc {
replace numeracy6 =. if numeracy6 >3
}
else {

}
capture confirm numeric v _2businessnbworkers
if !_rc {
replace _2businessnbworkers =. if _2businessnbworkers >16
}
else {

}
capture confirm numeric v _3snrecommendassodummyfam
if !_rc {
replace _3snrecommendassodummyfam =. if _3snrecommendassodummyfam >2
}
else {

}
capture confirm numeric v _3snfindjobruralurban
if !_rc {
replace _3snfindjobruralurban =. if _3snfindjobruralurban >2
}
else {

}
capture confirm numeric v _2covinstit1
if !_rc {
replace _2covinstit1 =. if _2covinstit1 >4
}
else {

}
capture confirm numeric v _3canreadcard1b
if !_rc {
replace _3canreadcard1b =99 if _3canreadcard1b ==4
}
else {

}
capture confirm numeric v canreadcard2
if !_rc {
replace canreadcard2 =99 if canreadcard2 ==4
}
else {

}
capture confirm numeric v advancebalanceperception
if !_rc {
replace advancebalanceperception =. if advancebalanceperception >3
}
else {

}
capture confirm numeric v snrecojobsuccessruralurban
if !_rc {
replace snrecojobsuccessruralurban =. if snrecojobsuccessruralurban >2
}
else {

}
capture confirm numeric v snentrustbusinessintimacy
if !_rc {
replace snentrustbusinessintimacy =. if snentrustbusinessintimacy >3
}
else {

}
capture confirm numeric v _3snentrustbusinesscastes
if !_rc {
replace _3snentrustbusinesscastes =. if _3snentrustbusinesscastes >17
}
else {

}
capture confirm numeric v chitfundtype
if !_rc {
replace chitfundtype =. if chitfundtype >4
}
else {

}
capture confirm numeric v lefthomereason
if !_rc {
replace lefthomereason =. if lefthomereason >11
}
else {

}
capture confirm numeric v _2searchjob
if !_rc {
replace _2searchjob =. if _2searchjob >2
}
else {

}
capture confirm numeric v _2snrecommendforjobdummyhh
if !_rc {
replace _2snrecommendforjobdummyhh =. if _2snrecommendforjobdummyhh >2
}
else {

}
capture confirm numeric v numeracy3
if !_rc {
replace numeracy3 =. if numeracy3 >3
}
else {

}
capture confirm numeric v _3numeracy3
if !_rc {
replace _3numeracy3 =. if _3numeracy3 >3
}
else {

}
capture confirm numeric v covinstit8
if !_rc {
replace covinstit8 =. if covinstit8 >3
}
else {

}
capture confirm numeric v migrationwagetype
if !_rc {
replace migrationwagetype =. if migrationwagetype >5
}
else {

}
capture confirm numeric v snrecommendassoliving
if !_rc {
replace snrecommendassoliving =. if snrecommendassoliving >6
}
else {

}
capture confirm numeric v _3numeracy6
if !_rc {
replace _3numeracy6 =. if _3numeracy6 >3
}
else {

}
capture confirm numeric v snfindsupplierscastes
if !_rc {
replace snfindsupplierscastes =. if snfindsupplierscastes >17
}
else {

}
capture confirm numeric v _3sncloserelouthhmeetfrequency
if !_rc {
replace _3sncloserelouthhmeetfrequency =. if _3sncloserelouthhmeetfrequency >6
}
else {

}
capture confirm numeric v _3wagejobtype
if !_rc {
replace _3wagejobtype =. if _3wagejobtype >4
}
else {

}
capture confirm numeric v _3agreementatwork4
if !_rc {
replace _3agreementatwork4 =. if _3agreementatwork4 >4
}
else {

}
capture confirm numeric v _3useknowledgeatwork
if !_rc {
replace _3useknowledgeatwork =. if _3useknowledgeatwork >4
}
else {

}
capture confirm numeric v _2snrecojobsuccess
if !_rc {
replace _2snrecojobsuccess =. if _2snrecojobsuccess >3
}
else {

}
capture confirm numeric v _3ego2random_1_3
if !_rc {
replace _3ego2random_1_3 =. if _3ego2random_1_3 >2
}
else {

}
capture confirm numeric v _3snrecommendassosex
if !_rc {
replace _3snrecommendassosex =. if _3snrecommendassosex >2
}
else {

}
capture confirm numeric v _2covinstit4
if !_rc {
replace _2covinstit4 =. if _2covinstit4 >4
}
else {

}
capture confirm numeric v _2opinionworkingwoman
if !_rc {
replace _2opinionworkingwoman =. if _2opinionworkingwoman >4
}
else {

}
capture confirm numeric v borrowerservices
if !_rc {
replace borrowerservices =77 if borrowerservices ==5
}
else {

}
capture confirm numeric v discrimination9
if !_rc {
replace discrimination9 =. if discrimination9 >2
}
else {

}
capture confirm numeric v _2A7
if !_rc {
replace _2A7 =. if _2A7 >7
}
else {

}
capture confirm numeric v sexualharassment
if !_rc {
replace sexualharassment =. if sexualharassment >2
}
else {

}
capture confirm numeric v physicalagression
if !_rc {
replace physicalagression =. if physicalagression >6
}
else {

}
capture confirm numeric v putoffduties
if !_rc {
replace putoffduties =. if putoffduties >6
}
else {

}
capture confirm numeric v _2expressingthoughts
if !_rc {
replace _2expressingthoughts =. if _2expressingthoughts >6
}
else {

}
capture confirm numeric v _3happywork
if !_rc {
replace _3happywork =. if _3happywork >4
}
else {

}
capture confirm numeric v wagejobpaymentinkindlist
if !_rc {
replace wagejobpaymentinkindlist =. if wagejobpaymentinkindlist >6
}
else {

}
capture confirm numeric v _2searchjobsince15
if !_rc {
replace _2searchjobsince15 =. if _2searchjobsince15 >2
}
else {

}
capture confirm numeric v snfindjobfriend
if !_rc {
replace snfindjobfriend =. if snfindjobfriend >2
}
else {

}
capture confirm numeric v _2covinstit8
if !_rc {
replace _2covinstit8 =. if _2covinstit8 >3
}
else {

}
capture confirm numeric v _3covinstit1
if !_rc {
replace _3covinstit1 =. if _3covinstit1 >4
}
else {

}
capture confirm numeric v enthusiastic
if !_rc {
replace enthusiastic =. if enthusiastic >6
}
else {

}
capture confirm numeric v _2snrecruitworkerinvite
if !_rc {
replace _2snrecruitworkerinvite =. if _2snrecruitworkerinvite >2
}
else {

}
capture confirm numeric v _2dummybusinessunpaidworkers
if !_rc {
replace _2dummybusinessunpaidworkers =. if _2dummybusinessunpaidworkers >2
}
else {

}
capture confirm numeric v relationshipbusinesslabourer
if !_rc {
replace relationshipbusinesslabourer =. if relationshipbusinesslabourer >9
}
else {

}
capture confirm numeric v _2networkhelpkinmember
if !_rc {
replace _2networkhelpkinmember =. if _2networkhelpkinmember >6
}
else {

}
capture confirm numeric v _2liketothink
if !_rc {
replace _2liketothink =. if _2liketothink >6
}
else {

}
capture confirm numeric v loansettled
if !_rc {
replace loansettled =. if loansettled >2
}
else {

}
capture confirm numeric v snfindcurrentjobsex
if !_rc {
replace snfindcurrentjobsex =. if snfindcurrentjobsex >2
}
else {

}
capture confirm numeric v _3finishtasks
if !_rc {
replace _3finishtasks =. if _3finishtasks >6
}
else {

}
capture confirm numeric v _3problemwork4
if !_rc {
replace _3problemwork4 =66 if _3problemwork4 ==4
}
else {

}
capture confirm numeric v _2makeplans
if !_rc {
replace _2makeplans =. if _2makeplans >6
}
else {

}
capture confirm numeric v methodfindjob
if !_rc {
replace methodfindjob =99 if methodfindjob ==11
}
else {

}
capture confirm numeric v finishtasks
if !_rc {
replace finishtasks =. if finishtasks >6
}
else {

}
capture confirm numeric v _3snrecommendforjobcastes
if !_rc {
replace _3snrecommendforjobcastes =. if _3snrecommendforjobcastes >17
}
else {

}
capture confirm numeric v snrecojobsuccesswkp
if !_rc {
replace snrecojobsuccesswkp =. if snrecojobsuccesswkp >2
}
else {

}
capture confirm numeric v migrationreason
if !_rc {
replace migrationreason =77 if migrationreason ==11
}
else {

}
capture confirm numeric v comefromspouse
if !_rc {
replace comefromspouse =. if comefromspouse >2
}
else {

}
capture confirm numeric v _3Ab6
if !_rc {
replace _3Ab6 =. if _3Ab6 >7
}
else {

}
capture confirm numeric v after10thstandard
if !_rc {
replace after10thstandard =. if after10thstandard >5
}
else {

}
capture confirm numeric v snhelpemergencyinvite
if !_rc {
replace snhelpemergencyinvite =. if snhelpemergencyinvite >2
}
else {

}
capture confirm numeric v resdiscrimination4
if !_rc {
replace resdiscrimination4 =. if resdiscrimination4 >2
}
else {

}
capture confirm numeric v _3rudetoother
if !_rc {
replace _3rudetoother =. if _3rudetoother >6
}
else {

}
capture confirm numeric v relationshiptohead
if !_rc {
replace relationshiptohead =. if relationshiptohead ==14
}
else {

}
capture confirm numeric v _2sncloserelouthhreciprocity1
if !_rc {
replace _2sncloserelouthhreciprocity1 =. if _2sncloserelouthhreciprocity1 >2
}
else {

}
capture confirm numeric v _3resdiscrimination4
if !_rc {
replace _3resdiscrimination4 =. if _3resdiscrimination4 >2
}
else {

}
capture confirm numeric v _2agreementatwork1
if !_rc {
replace _2agreementatwork1 =. if _2agreementatwork1 >4
}
else {

}
capture confirm numeric v _2Ab7
if !_rc {
replace _2Ab7 =. if _2Ab7 >7
}
else {

}
capture confirm numeric v Ab11
if !_rc {
replace Ab11 =. if Ab11 >7
}
else {

}
capture confirm numeric v snfindjobdummyhh
if !_rc {
replace snfindjobdummyhh =. if snfindjobdummyhh >2
}
else {

}
capture confirm numeric v satisfactionsalary
if !_rc {
replace satisfactionsalary =. if satisfactionsalary >5
}
else {

}
capture confirm numeric v migrationadvancereceiver
if !_rc {
replace migrationadvancereceiver =. if migrationadvancereceiver >3
}
else {

}
capture confirm numeric v finishwhatbegin
if !_rc {
replace finishwhatbegin =. if finishwhatbegin >6
}
else {

}
capture confirm numeric v _3shywithpeople
if !_rc {
replace _3shywithpeople =. if _3shywithpeople >6
}
else {

}
capture confirm numeric v numeracy1
if !_rc {
replace numeracy1 =. if numeracy1 >3
}
else {

}
capture confirm numeric v castebusinesslender
if !_rc {
replace castebusinesslender =77 if castebusinesslender ==18
}
else {

}
capture confirm numeric v B11
if !_rc {
replace B11 =. if B11 >7
}
else {

}
capture confirm numeric v _2accidentalinjury
if !_rc {
replace _2accidentalinjury =. if _2accidentalinjury >2
}
else {

}
capture confirm numeric v _2B9
if !_rc {
replace _2B9 =. if _2B9 >7
}
else {

}
capture confirm numeric v snrecommendforjobruralurban
if !_rc {
replace snrecommendforjobruralurban =. if snrecommendforjobruralurban >2
}
else {

}
capture confirm numeric v keepworking
if !_rc {
replace keepworking =. if keepworking >6
}
else {

}
capture confirm numeric v snhelpemergencyruralurban
if !_rc {
replace snhelpemergencyruralurban =. if snhelpemergencyruralurban >2
}
else {

}
capture confirm numeric v _3takeholiday
if !_rc {
replace _3takeholiday =66 if _3takeholiday ==5
}
else {

}
capture confirm numeric v loaneffectivereason
if !_rc {
replace loaneffectivereason =. if loaneffectivereason >13
}
else {

}
capture confirm numeric v snfindjobsex
if !_rc {
replace snfindjobsex =. if snfindjobsex >2
}
else {

}
capture confirm numeric v typeofhigheredu
if !_rc {
replace typeofhigheredu =. if typeofhigheredu >2
}
else {

}
capture confirm numeric v remreceivedmoney
if !_rc {
replace remreceivedmoney =. if remreceivedmoney >2
}
else {

}
capture confirm numeric v _3discrimination7
if !_rc {
replace _3discrimination7 =. if _3discrimination7 >2
}
else {

}
capture confirm numeric v _3snrecojobsuccesscastes
if !_rc {
replace _3snrecojobsuccesscastes =. if _3snrecojobsuccesscastes >17
}
else {

}
capture confirm numeric v _3decisionwork
if !_rc {
replace _3decisionwork =. if _3decisionwork >6
}
else {

}
capture confirm numeric v settleloanstrategy
if !_rc {
replace settleloanstrategy =. if settleloanstrategy >11
}
else {

}
capture confirm numeric v _3changemood
if !_rc {
replace _3changemood =. if _3changemood >6
}
else {

}
capture confirm numeric v _2finishtasks
if !_rc {
replace _2finishtasks =. if _2finishtasks >6
}
else {

}
capture confirm numeric v _3executionwork2
if !_rc {
replace _3executionwork2 =. if _3executionwork2 >2
}
else {

}
capture confirm numeric v _3snrecommendassolabourtype
if !_rc {
replace _3snrecommendassolabourtype =. if _3snrecommendassolabourtype >4
}
else {

}
capture confirm numeric v locuscontrol5
if !_rc {
replace locuscontrol5 =. if locuscontrol5 >5
}
else {

}
capture confirm numeric v _2B1
if !_rc {
replace _2B1 =. if _2B1 >7
}
else {

}
capture confirm numeric v locuscontrol2
if !_rc {
replace locuscontrol2 =. if locuscontrol2 >5
}
else {

}
capture confirm numeric v feeldepressed
if !_rc {
replace feeldepressed =. if feeldepressed >6
}
else {

}
capture confirm numeric v dummyremreceived
if !_rc {
replace dummyremreceived =. if dummyremreceived >2
}
else {

}
capture confirm numeric v B6
if !_rc {
replace B6 =. if B6 >7
}
else {

}
capture confirm numeric v _3covneworktrustneighborhood
if !_rc {
replace _3covneworktrustneighborhood =. if _3covneworktrustneighborhood >3
}
else {

}
capture confirm numeric v _3snentrustbusinesscompared
if !_rc {
replace _3snentrustbusinesscompared =. if _3snentrustbusinesscompared >3
}
else {

}
capture confirm numeric v sncloserelouthheduc
if !_rc {
replace sncloserelouthheduc =. if sncloserelouthheduc >7
}
else {

}
capture confirm numeric v _2snrecommendforjobwkp
if !_rc {
replace _2snrecommendforjobwkp =. if _2snrecommendforjobwkp >2
}
else {

}
capture confirm numeric v discrimination8
if !_rc {
replace discrimination8 =. if discrimination8 >2
}
else {

}
capture confirm numeric v _2executionwork6
if !_rc {
replace _2executionwork6 =. if _2executionwork6 >2
}
else {

}
capture confirm numeric v dummyaspirationmorehours
if !_rc {
replace dummyaspirationmorehours =0 if dummyaspirationmorehours ==1
}
else {

}
capture confirm numeric v _2B2
if !_rc {
replace _2B2 =. if _2B2 >7
}
else {

}
capture confirm numeric v _3snentrustbusinesssex
if !_rc {
replace _3snentrustbusinesssex =. if _3snentrustbusinesssex >2
}
else {

}
capture confirm numeric v snrecruitworkerage
if !_rc {
replace snrecruitworkerage =. if snrecruitworkerage >6
}
else {

}
capture confirm numeric v sntalkthemostfriend
if !_rc {
replace sntalkthemostfriend =. if sntalkthemostfriend >2
}
else {

}
capture confirm numeric v snentrustbusinessruralurban
if !_rc {
replace snentrustbusinessruralurban =. if snentrustbusinessruralurban >2
}
else {

}
capture confirm numeric v stoppedworking
if !_rc {
replace stoppedworking =. if stoppedworking >2
}
else {

}
capture confirm numeric v _2snrecojobsuccesscompared
if !_rc {
replace _2snrecojobsuccesscompared =. if _2snrecojobsuccesscompared >3
}
else {

}
capture confirm numeric v _3snrecommendassomeet
if !_rc {
replace _3snrecommendassomeet =77 if _3snrecommendassomeet ==7
}
else {

}
capture confirm numeric v migrationmainoccup
if !_rc {
replace migrationmainoccup =. if migrationmainoccup >2
}
else {

}
capture confirm numeric v _3snhelpemergencyruralurban
if !_rc {
replace _3snhelpemergencyruralurban =. if _3snhelpemergencyruralurban >2
}
else {

}
capture confirm numeric v _2snfindcurrentjobwkp
if !_rc {
replace _2snfindcurrentjobwkp =. if _2snfindcurrentjobwkp >2
}
else {

}
capture confirm numeric v _2snentrustbusinesslabourtype
if !_rc {
replace _2snentrustbusinesslabourtype =. if _2snentrustbusinesslabourtype >4
}
else {

}
capture confirm numeric v _2A4
if !_rc {
replace _2A4 =. if _2A4 >7
}
else {

}
capture confirm numeric v _2snentrustbusinessdummyfam
if !_rc {
replace _2snentrustbusinessdummyfam =. if _2snentrustbusinessdummyfam >2
}
else {

}
capture confirm numeric v _3snrecruitworkerlabourtype
if !_rc {
replace _3snrecruitworkerlabourtype =. if _3snrecruitworkerlabourtype >4
}
else {

}
capture confirm numeric v _3snentrustbusinessdistrict
if !_rc {
replace _3snentrustbusinessdistrict =. if _3snentrustbusinessdistrict >37
}
else {

}
capture confirm numeric v _2easilyupset
if !_rc {
replace _2easilyupset =. if _2easilyupset >6
}
else {

}
capture confirm numeric v reasonnoinsurance
if !_rc {
replace reasonnoinsurance =77 if reasonnoinsurance ==4
}
else {

}
capture confirm numeric v executionwork2
if !_rc {
replace executionwork2 =. if executionwork2 >2
}
else {

}
capture confirm numeric v snrecommendforjobdistrict
if !_rc {
replace snrecommendforjobdistrict =. if snrecommendforjobdistrict >37
}
else {

}
capture confirm numeric v Ab3
if !_rc {
replace Ab3 =. if Ab3 >7
}
else {

}
capture confirm numeric v _3covinstit8
if !_rc {
replace _3covinstit8 =. if _3covinstit8 >3
}
else {

}
capture confirm numeric v talktomanypeople
if !_rc {
replace talktomanypeople =. if talktomanypeople >6
}
else {

}
capture confirm numeric v _2snrecommendforjobfriend
if !_rc {
replace _2snrecommendforjobfriend =. if _2snrecommendforjobfriend >2
}
else {

}
capture confirm numeric v _3resdiscrimination1
if !_rc {
replace _3resdiscrimination1 =. if _3resdiscrimination1 >2
}
else {

}
capture confirm numeric v organized
if !_rc {
replace organized =. if organized >6
}
else {

}
capture confirm numeric v _2livingbusinesslender
if !_rc {
replace _2livingbusinesslender =. if _2livingbusinesslender >6
}
else {

}
capture confirm numeric v _2snrecruitworkermeetfrequency
if !_rc {
replace _2snrecruitworkermeetfrequency =. if _2snrecruitworkermeetfrequency >6
}
else {

}
capture confirm numeric v _3contract
if !_rc {
replace _3contract =. if _3contract >3
}
else {

}
capture confirm numeric v _2snfindjobmeetfrequency
if !_rc {
replace _2snfindjobmeetfrequency =. if _2snfindjobmeetfrequency >6
}
else {

}
capture confirm numeric v _3putoffduties
if !_rc {
replace _3putoffduties =. if _3putoffduties >6
}
else {

}
capture confirm numeric v guarantorloanrelation
if !_rc {
replace guarantorloanrelation =99 if guarantorloanrelation ==13
}
else {

}
capture confirm numeric v _3covnetworkhelpkinmember
if !_rc {
replace _3covnetworkhelpkinmember =. if _3covnetworkhelpkinmember >3
}
else {

}
capture confirm numeric v snrecommendassocastes
if !_rc {
replace snrecommendassocastes =. if snrecommendassocastes >17
}
else {

}
capture confirm numeric v _2snrecruitworkerwkp
if !_rc {
replace _2snrecruitworkerwkp =. if _2snrecruitworkerwkp >2
}
else {

}
capture confirm numeric v snentrustbusinesseduc
if !_rc {
replace snentrustbusinesseduc =. if snentrustbusinesseduc >7
}
else {

}
capture confirm numeric v sntalkthemostlabourrelation
if !_rc {
replace sntalkthemostlabourrelation =. if sntalkthemostlabourrelation >2
}
else {

}
capture confirm numeric v locuscontrol4
if !_rc {
replace locuscontrol4 =. if locuscontrol4 >5
}
else {

}
capture confirm numeric v _2organized
if !_rc {
replace _2organized =. if _2organized >6
}
else {

}
capture confirm numeric v _2snfindcurrentjobdummyfam
if !_rc {
replace _2snfindcurrentjobdummyfam =. if _2snfindcurrentjobdummyfam >2
}
else {

}
capture confirm numeric v _2A10
if !_rc {
replace _2A10 =. if _2A10 >7
}
else {

}
capture confirm numeric v _2problemwork5
if !_rc {
replace _2problemwork5 =66 if _2problemwork5 ==4
}
else {

}
capture confirm numeric v _3snrecruitworkerdummyfam
if !_rc {
replace _3snrecruitworkerdummyfam =. if _3snrecruitworkerdummyfam >2
}
else {

}
capture confirm numeric v _2B7
if !_rc {
replace _2B7 =. if _2B7 >7
}
else {

}
capture confirm numeric v _3B4
if !_rc {
replace _3B4 =. if _3B4 >7
}
else {

}
capture confirm numeric v lackskill
if !_rc {
replace lackskill =. if lackskill >2
}
else {

}
capture confirm numeric v _3snfindjobemployertype
if !_rc {
replace _3snfindjobemployertype =. if _3snfindjobemployertype >8
}
else {

}
capture confirm numeric v howpaymarriage
if !_rc {
replace howpaymarriage =. if howpaymarriage >3
}
else {

}
capture confirm numeric v covinstit1
if !_rc {
replace covinstit1 =. if covinstit1 >4
}
else {

}
capture confirm numeric v marriageloansettled
if !_rc {
replace marriageloansettled =. if marriageloansettled >2
}
else {

}
capture confirm numeric v _2contract
if !_rc {
replace _2contract =. if _2contract >3
}
else {

}
capture confirm numeric v reservationgrade classlistid
if !_rc {
replace reservationgrade =. if reservationgrade ==14|classlistid
}
else {

}
capture confirm numeric v _2nervous
if !_rc {
replace _2nervous =. if _2nervous >6
}
else {

}
capture confirm numeric v reasondropping
if !_rc {
replace reasondropping =77 if reasondropping ==15
}
else {

}
capture confirm numeric v _2discrimination9
if !_rc {
replace _2discrimination9 =. if _2discrimination9 >2
}
else {

}
capture confirm numeric v sexbusinesslender
if !_rc {
replace sexbusinesslender =. if sexbusinesslender >2
}
else {

}
capture confirm numeric v _2reciprocity1businesslender
if !_rc {
replace _2reciprocity1businesslender =. if _2reciprocity1businesslender >2
}
else {

}
capture confirm numeric v toleratefaults
if !_rc {
replace toleratefaults =. if toleratefaults >6
}
else {

}
capture confirm numeric v _2snrecojobsuccessdummyhh
if !_rc {
replace _2snrecojobsuccessdummyhh =. if _2snrecojobsuccessdummyhh >2
}
else {

}
capture confirm numeric v sncloserelouthhinvite
if !_rc {
replace sncloserelouthhinvite =. if sncloserelouthhinvite >2
}
else {

}
capture confirm numeric v _3snrecruitworkerinvite
if !_rc {
replace _3snrecruitworkerinvite =. if _3snrecruitworkerinvite >2
}
else {

}
capture confirm numeric v _2Ab2
if !_rc {
replace _2Ab2 =. if _2Ab2 >7
}
else {

}
capture confirm numeric v _3jobwagefrequencycash
if !_rc {
replace _3jobwagefrequencycash =. if _3jobwagefrequencycash >4
}
else {

}
capture confirm numeric v B1
if !_rc {
replace B1 =. if B1 >7
}
else {

}
capture confirm numeric v _2snrecommendforjobage
if !_rc {
replace _2snrecommendforjobage =. if _2snrecommendforjobage >6
}
else {

}
capture confirm numeric v _3nbermonthsearchjob
if !_rc {
replace _3nbermonthsearchjob =. if _3nbermonthsearchjob >14
}
else {

}
capture confirm numeric v networktrustneighborhood
if !_rc {
replace networktrustneighborhood =. if networktrustneighborhood >6
}
else {

}
capture confirm numeric v _3snentrustbusinessreciprocity1
if !_rc {
replace _3snentrustbusinessreciprocity1 =. if _3snentrustbusinessreciprocity1 >2
}
else {

}
capture confirm numeric v _3completeduties
if !_rc {
replace _3completeduties =. if _3completeduties >6
}
else {

}
capture confirm numeric v _3snrecommendforjobdistrict
if !_rc {
replace _3snrecommendforjobdistrict =. if _3snrecommendforjobdistrict >37
}
else {

}
capture confirm numeric v _2problemwork6
if !_rc {
replace _2problemwork6 =66 if _2problemwork6 ==4
}
else {

}
capture confirm numeric v wagejobnbworker
if !_rc {
replace wagejobnbworker =. if wagejobnbworker >8
}
else {

}
capture confirm numeric v _2helpfulwithothers
if !_rc {
replace _2helpfulwithothers =. if _2helpfulwithothers >6
}
else {

}
capture confirm numeric v _2snfindcurrentjob
if !_rc {
replace _2snfindcurrentjob =. if _2snfindcurrentjob >3
}
else {

}
capture confirm numeric v _2numeracy3
if !_rc {
replace _2numeracy3 =. if _2numeracy3 >3
}
else {

}
capture confirm numeric v _3makeplans
if !_rc {
replace _3makeplans =. if _3makeplans >6
}
else {

}
capture confirm numeric v _3moveoutsideforjob
if !_rc {
replace _3moveoutsideforjob =. if _3moveoutsideforjob >2
}
else {

}
capture confirm numeric v _3easilyupset
if !_rc {
replace _3easilyupset =. if _3easilyupset >6
}
else {

}
capture confirm numeric v snrecommendforjobdummyhh
if !_rc {
replace snrecommendforjobdummyhh =. if snrecommendforjobdummyhh >2
}
else {

}
capture confirm numeric v businesslabourerpension
if !_rc {
replace businesslabourerpension =. if businesslabourerpension >2
}
else {

}
capture confirm numeric v _3snfindsuppliersliving
if !_rc {
replace _3snfindsuppliersliving =. if _3snfindsuppliersliving >6
}
else {

}
capture confirm numeric v _3snrecommendforjobdummyfam
if !_rc {
replace _3snrecommendforjobdummyfam =. if _3snrecommendforjobdummyfam >2
}
else {

}
capture confirm numeric v snfindcurrentjobeduc
if !_rc {
replace snfindcurrentjobeduc =. if snfindcurrentjobeduc >7
}
else {

}
capture confirm numeric v _3meetbusinesslender
if !_rc {
replace _3meetbusinesslender =77 if _3meetbusinesslender ==7
}
else {

}
capture confirm numeric v ego2random_1_2
if !_rc {
replace ego2random_1_2 =. if ego2random_1_2 >2
}
else {

}
capture confirm numeric v _3problemwork5
if !_rc {
replace _3problemwork5 =66 if _3problemwork5 ==4
}
else {

}
capture confirm numeric v _2snfindcurrentjobdummyhh
if !_rc {
replace _2snfindcurrentjobdummyhh =. if _2snfindcurrentjobdummyhh >2
}
else {

}
capture confirm numeric v reservation
if !_rc {
replace reservation =. if reservation >2
}
else {

}
capture confirm numeric v problemwork4
if !_rc {
replace problemwork4 =99 if problemwork4 ==5
}
else {

}
capture confirm numeric v _2snhelpemergencycastes
if !_rc {
replace _2snhelpemergencycastes =. if _2snhelpemergencycastes >17
}
else {

}
capture confirm numeric v _3B9
if !_rc {
replace _3B9 =. if _3B9 >7
}
else {

}
capture confirm numeric v snrecojobsuccessmeet
if !_rc {
replace snrecojobsuccessmeet =77 if snrecojobsuccessmeet ==7
}
else {

}
capture confirm numeric v migrationadvanceprovider
if !_rc {
replace migrationadvanceprovider =. if migrationadvanceprovider >2
}
else {

}
capture confirm numeric v _2snhelpemergencyemployertype
if !_rc {
replace _2snhelpemergencyemployertype =. if _2snhelpemergencyemployertype >8
}
else {

}
capture confirm numeric v _2snrecruitworkerdistrict
if !_rc {
replace _2snrecruitworkerdistrict =. if _2snrecruitworkerdistrict >37
}
else {

}
capture confirm numeric v _3snfindsuppliersemployertype
if !_rc {
replace _3snfindsuppliersemployertype =. if _3snfindsuppliersemployertype >8
}
else {

}
capture confirm numeric v B5
if !_rc {
replace B5 =99 if B5 ==7
}
else {

}
capture confirm numeric v _2problemwork10
if !_rc {
replace _2problemwork10 =66 if _2problemwork10 ==4
}
else {

}
capture confirm numeric v _3problemwork9
if !_rc {
replace _3problemwork9 =66 if _3problemwork9 ==4
}
else {

}
capture confirm numeric v _2snfindsupplierscompared
if !_rc {
replace _2snfindsupplierscompared =. if _2snfindsupplierscompared >3
}
else {

}
capture confirm numeric v _2snfindsuppliersintimacy
if !_rc {
replace _2snfindsuppliersintimacy =. if _2snfindsuppliersintimacy >3
}
else {

}
capture confirm numeric v _2numeracy4
if !_rc {
replace _2numeracy4 =99 if _2numeracy4 ==3
}
else {

}
capture confirm numeric v useknowledgeatwork
if !_rc {
replace useknowledgeatwork =. if useknowledgeatwork >4
}
else {

}
capture confirm numeric v _3problemwork10
if !_rc {
replace _3problemwork10 =66 if _3problemwork10 ==4
}
else {

}
capture confirm numeric v _3snrecommendassowkp
if !_rc {
replace _3snrecommendassowkp =. if _3snrecommendassowkp >2
}
else {

}
capture confirm numeric v _3snrecommendassoemployertype
if !_rc {
replace _3snrecommendassoemployertype =. if _3snrecommendassoemployertype >8
}
else {

}
capture confirm numeric v snfindcurrentjobwkp
if !_rc {
replace snfindcurrentjobwkp =. if snfindcurrentjobwkp >2
}
else {

}
capture confirm numeric v _2snentrustbusinesssex
if !_rc {
replace _2snentrustbusinesssex =. if _2snentrustbusinesssex >2
}
else {

}
capture confirm numeric v _3snfindcurrentjobage
if !_rc {
replace _3snfindcurrentjobage =. if _3snfindcurrentjobage >6
}
else {

}
capture confirm numeric v sntalkthemostcompared
if !_rc {
replace sntalkthemostcompared =. if sntalkthemostcompared >3
}
else {

}
capture confirm numeric v _3satisfactionsalary
if !_rc {
replace _3satisfactionsalary =. if _3satisfactionsalary >5
}
else {

}
capture confirm numeric v _3physicalharm
if !_rc {
replace _3physicalharm =99 if _3physicalharm ==6
}
else {

}
capture confirm numeric v _3numeracy2
if !_rc {
replace _3numeracy2 =. if _3numeracy2 >3
}
else {

}
capture confirm numeric v snrecommendforjobcompared
if !_rc {
replace snrecommendforjobcompared =. if snrecommendforjobcompared >3
}
else {

}
capture confirm numeric v _2snfindjoblabourtype
if !_rc {
replace _2snfindjoblabourtype =. if _2snfindjoblabourtype >4
}
else {

}
capture confirm numeric v migrationadvancefeel
if !_rc {
replace migrationadvancefeel =. if migrationadvancefeel >3
}
else {

}
capture confirm numeric v snrecojobsuccessdummyfam
if !_rc {
replace snrecojobsuccessdummyfam =. if snrecojobsuccessdummyfam >2
}
else {

}
capture confirm numeric v _2discrimination1
if !_rc {
replace _2discrimination1 =. if _2discrimination1 >2
}
else {

}
capture confirm numeric v sntalkthemostinvite
if !_rc {
replace sntalkthemostinvite =. if sntalkthemostinvite >2
}
else {

}
capture confirm numeric v covcontactinstitution
if !_rc {
replace covcontactinstitution =. if covcontactinstitution >5
}
else {

}
capture confirm numeric v _3snfindsupplierslabourtype
if !_rc {
replace _3snfindsupplierslabourtype =. if _3snfindsupplierslabourtype >4
}
else {

}
capture confirm numeric v sncloserelouthhcompared
if !_rc {
replace sncloserelouthhcompared =. if sncloserelouthhcompared >3
}
else {

}
capture confirm numeric v _3methodfindjob
if !_rc {
replace _3methodfindjob =. if _3methodfindjob >11
}
else {

}
capture confirm numeric v _2covinstit9
if !_rc {
replace _2covinstit9 =. if _2covinstit9 >3
}
else {

}
capture confirm numeric v _2snrecommendassointimacy
if !_rc {
replace _2snrecommendassointimacy =. if _2snrecommendassointimacy >3
}
else {

}
capture confirm numeric v resdiscrimination3
if !_rc {
replace resdiscrimination3 =. if resdiscrimination3 >2
}
else {

}
capture confirm numeric v _3snrecommendforjob
if !_rc {
replace _3snrecommendforjob =. if _3snrecommendforjob >3
}
else {

}
capture confirm numeric v snrecojobsuccessdistrict
if !_rc {
replace snrecojobsuccessdistrict =. if snrecojobsuccessdistrict >37
}
else {

}
capture confirm numeric v _3workhard
if !_rc {
replace _3workhard =. if _3workhard >6
}
else {

}
capture confirm numeric v _3snentrustbusinesslabourtype
if !_rc {
replace _3snentrustbusinesslabourtype =. if _3snentrustbusinesslabourtype >4
}
else {

}
capture confirm numeric v _3snrecruitworkerdummyhh
if !_rc {
replace _3snrecruitworkerdummyhh =. if _3snrecruitworkerdummyhh >2
}
else {

}
capture confirm numeric v _3networkpeoplehelping
if !_rc {
replace _3networkpeoplehelping =. if _3networkpeoplehelping >6
}
else {

}
capture confirm numeric v snrecruitworkeremployertype
if !_rc {
replace snrecruitworkeremployertype =. if snrecruitworkeremployertype >8
}
else {

}
capture confirm numeric v _3sntalkthemosteduc
if !_rc {
replace _3sntalkthemosteduc =. if _3sntalkthemosteduc >7
}
else {

}
capture confirm numeric v covinstit2
if !_rc {
replace covinstit2 =. if covinstit2 >4
}
else {

}
capture confirm numeric v _3workpastsevendays
if !_rc {
replace _3workpastsevendays =. if _3workpastsevendays >2
}
else {

}
capture confirm numeric v _3workexposure1
if !_rc {
replace _3workexposure1 =. if _3workexposure1 >5
}
else {

}
capture confirm numeric v _2snrecojobsuccessfriend
if !_rc {
replace _2snrecojobsuccessfriend =. if _2snrecojobsuccessfriend >2
}
else {

}
capture confirm numeric v savingsaccounttype
if !_rc {
replace savingsaccounttype =. if savingsaccounttype >2
}
else {

}
capture confirm numeric v numeracy5
if !_rc {
replace numeracy5 =. if numeracy5 >3
}
else {

}
capture confirm numeric v plantorepay
if !_rc {
replace plantorepay =. if plantorepay >7
}
else {

}
capture confirm numeric v _3schedule
if !_rc {
replace _3schedule =. if _3schedule >4
}
else {

}
capture confirm numeric v _3snrecruitworkersex
if !_rc {
replace _3snrecruitworkersex =. if _3snrecruitworkersex >2
}
else {

}
capture confirm numeric v sexualaggression
if !_rc {
replace sexualaggression =66 if sexualaggression ==4
}
else {

}
capture confirm numeric v _2snfindjobsex
if !_rc {
replace _2snfindjobsex =. if _2snfindjobsex >2
}
else {

}
capture confirm numeric v _2executionwork4
if !_rc {
replace _2executionwork4 =. if _2executionwork4 >2
}
else {

}
capture confirm numeric v _3snrecojobsuccesslabourtype
if !_rc {
replace _3snrecojobsuccesslabourtype =. if _3snrecojobsuccesslabourtype >4
}
else {

}
capture confirm numeric v nbermonthsearchjob
if !_rc {
replace nbermonthsearchjob =0 if nbermonthsearchjob ==14
}
else {

}
capture confirm numeric v _2snrecojobsuccessintimacy
if !_rc {
replace _2snrecojobsuccessintimacy =. if _2snrecojobsuccessintimacy >3
}
else {

}
capture confirm numeric v trustingofother
if !_rc {
replace trustingofother =. if trustingofother >6
}
else {

}
capture confirm numeric v lenderoccup
if !_rc {
replace lenderoccup =77 if lenderoccup ==8
}
else {

}
capture confirm numeric v _3snentrustbusinessruralurban
if !_rc {
replace _3snentrustbusinessruralurban =. if _3snentrustbusinessruralurban >2
}
else {

}
capture confirm numeric v snfindcurrentjobemployertype
if !_rc {
replace snfindcurrentjobemployertype =. if snfindcurrentjobemployertype >8
}
else {

}
capture confirm numeric v sncloserelouthhintimacy
if !_rc {
replace sncloserelouthhintimacy =. if sncloserelouthhintimacy >3
}
else {

}
capture confirm numeric v _3snrecommendforjobliving
if !_rc {
replace _3snrecommendforjobliving =. if _3snrecommendforjobliving >6
}
else {

}
capture confirm numeric v _3retirementwork
if !_rc {
replace _3retirementwork =. if _3retirementwork >2
}
else {

}
capture confirm numeric v dummyinteret
if !_rc {
replace dummyinteret =. if dummyinteret >2
}
else {

}
capture confirm numeric v _2snrecommendassolabourtype
if !_rc {
replace _2snrecommendassolabourtype =. if _2snrecommendassolabourtype >4
}
else {

}
capture confirm numeric v _2snhelpemergencydummyhh
if !_rc {
replace _2snhelpemergencydummyhh =. if _2snhelpemergencydummyhh >2
}
else {

}
capture confirm numeric v _2locuscontrol5
if !_rc {
replace _2locuscontrol5 =. if _2locuscontrol5 >5
}
else {

}
capture confirm numeric v _3sntalkthemostcompared
if !_rc {
replace _3sntalkthemostcompared =. if _3sntalkthemostcompared >3
}
else {

}
capture confirm numeric v covnetworkhelpkinmember
if !_rc {
replace covnetworkhelpkinmember =. if covnetworkhelpkinmember >3
}
else {

}
capture confirm numeric v snentrustbusinesssex
if !_rc {
replace snentrustbusinesssex =. if snentrustbusinesssex >2
}
else {

}
capture confirm numeric v _2discrimination3
if !_rc {
replace _2discrimination3 =. if _2discrimination3 >2
}
else {

}
capture confirm numeric v _3snrecruitworkerdistrict
if !_rc {
replace _3snrecruitworkerdistrict =. if _3snrecruitworkerdistrict >37
}
else {

}
capture confirm numeric v remreceivedsourceplace
if !_rc {
replace remreceivedsourceplace =. if remreceivedsourceplace >6
}
else {

}
capture confirm numeric v _2businessworkersfrequencypayment
if !_rc {
replace _2businessworkersfrequencypayment =. if _2businessworkersfrequencypayment >4
}
else {

}
capture confirm numeric v _3snentrustbusinessintimacy
if !_rc {
replace _3snentrustbusinessintimacy =. if _3snentrustbusinessintimacy >3
}
else {

}
capture confirm numeric v _3ego2random_3
if !_rc {
replace _3ego2random_3 =. if _3ego2random_3 >2
}
else {

}
capture confirm numeric v _2locuscontrol1
if !_rc {
replace _2locuscontrol1 =. if _2locuscontrol1 >5
}
else {

}
capture confirm numeric v _2snfindjobfriend
if !_rc {
replace _2snfindjobfriend =. if _2snfindjobfriend >2
}
else {

}
capture confirm numeric v _2agreementatwork3
if !_rc {
replace _2agreementatwork3 =. if _2agreementatwork3 >4
}
else {

}
capture confirm numeric v dummyassorecommendation
if !_rc {
replace dummyassorecommendation =. if dummyassorecommendation >2
}
else {

}
capture confirm numeric v _3snrecommendassodistrict
if !_rc {
replace _3snrecommendassodistrict =. if _3snrecommendassodistrict >37
}
else {

}
capture confirm numeric v _2B8
if !_rc {
replace _2B8 =. if _2B8 >7
}
else {

}
capture confirm numeric v snrecommendforjobdummyfam
if !_rc {
replace snrecommendforjobdummyfam =. if snrecommendforjobdummyfam >2
}
else {

}
capture confirm numeric v snrecommendassofriend
if !_rc {
replace snrecommendassofriend =. if snrecommendassofriend >2
}
else {

}
capture confirm numeric v _2snfindsuppliersage
if !_rc {
replace _2snfindsuppliersage =. if _2snfindsuppliersage >6
}
else {

}
capture confirm numeric v _3snfindjobcastes
if !_rc {
replace _3snfindjobcastes =. if _3snfindjobcastes >17
}
else {

}
capture confirm numeric v _2snentrustbusinessintimacy
if !_rc {
replace _2snentrustbusinessintimacy =. if _2snentrustbusinessintimacy >3
}
else {

}
capture confirm numeric v _3snfindsuppliersdistrict
if !_rc {
replace _3snfindsuppliersdistrict =. if _3snfindsuppliersdistrict >37
}
else {

}
capture confirm numeric v _3executionwork3
if !_rc {
replace _3executionwork3 =. if _3executionwork3 >2
}
else {

}
capture confirm numeric v executionwork1
if !_rc {
replace executionwork1 =. if executionwork1 >2
}
else {

}
capture confirm numeric v _3professionalequipment
if !_rc {
replace _3professionalequipment =. if _3professionalequipment >5
}
else {

}
capture confirm numeric v _3snentrustbusinessage
if !_rc {
replace _3snentrustbusinessage =. if _3snentrustbusinessage >6
}
else {

}
capture confirm numeric v _2snrecojobsuccesssex
if !_rc {
replace _2snrecojobsuccesssex =. if _2snrecojobsuccesssex >2
}
else {

}
capture confirm numeric v _3snrecruitworkerintimacy
if !_rc {
replace _3snrecruitworkerintimacy =. if _3snrecruitworkerintimacy >3
}
else {

}
capture confirm numeric v _3snhelpemergencycastes
if !_rc {
replace _3snhelpemergencycastes =. if _3snhelpemergencycastes >17
}
else {

}
capture confirm numeric v snrecojobsuccesslabourtype
if !_rc {
replace snrecojobsuccesslabourtype =. if snrecojobsuccesslabourtype >4
}
else {

}
capture confirm numeric v goaftergoal
if !_rc {
replace goaftergoal =. if goaftergoal >6
}
else {

}
capture confirm numeric v _2snrecommendassocompared
if !_rc {
replace _2snrecommendassocompared =. if _2snrecommendassocompared >3
}
else {

}
capture confirm numeric v _2workexposure5
if !_rc {
replace _2workexposure5 =. if _2workexposure5 >5
}
else {

}
capture confirm numeric v snrecruitworkerwkp
if !_rc {
replace snrecruitworkerwkp =. if snrecruitworkerwkp >2
}
else {

}
capture confirm numeric v _2professionalequipment
if !_rc {
replace _2professionalequipment =. if _2professionalequipment >5
}
else {

}
capture confirm numeric v snrecojobsuccessreciprocity1
if !_rc {
replace snrecojobsuccessreciprocity1 =. if snrecojobsuccessreciprocity1 >2
}
else {

}
capture confirm numeric v _3snrecommendassomeetfrequency
if !_rc {
replace _3snrecommendassomeetfrequency =. if _3snrecommendassomeetfrequency >6
}
else {

}
capture confirm numeric v covforcedbackhome
if !_rc {
replace covforcedbackhome =. if covforcedbackhome >2
}
else {

}
capture confirm numeric v _3covinstit3
if !_rc {
replace _3covinstit3 =. if _3covinstit3 >4
}
else {

}
capture confirm numeric v executionwork7
if !_rc {
replace executionwork7 =. if executionwork7 >2
}
else {

}
capture confirm numeric v _2workexposure3
if !_rc {
replace _2workexposure3 =. if _2workexposure3 >5
}
else {

}
capture confirm numeric v decisionwork
if !_rc {
replace decisionwork =. if decisionwork >6
}
else {

}
capture confirm numeric v _2covinstit2
if !_rc {
replace _2covinstit2 =. if _2covinstit2 >4
}
else {

}
capture confirm numeric v _3changework
if !_rc {
replace _3changework =. if _3changework >2
}
else {

}
capture confirm numeric v _2snrecommendassoreciprocity1
if !_rc {
replace _2snrecommendassoreciprocity1 =. if _2snrecommendassoreciprocity1 >2
}
else {

}
capture confirm numeric v _2snrecojobsuccessdistrict
if !_rc {
replace _2snrecojobsuccessdistrict =. if _2snrecojobsuccessdistrict >37
}
else {

}
capture confirm numeric v _2snfindjobreciprocity1
if !_rc {
replace _2snfindjobreciprocity1 =. if _2snfindjobreciprocity1 >2
}
else {

}
capture confirm numeric v _3sncloserelouthhfriend
if !_rc {
replace _3sncloserelouthhfriend =. if _3sncloserelouthhfriend >2
}
else {

}
capture confirm numeric v snrecommendforjobliving
if !_rc {
replace snrecommendforjobliving =. if snrecommendforjobliving >6
}
else {

}
capture confirm numeric v _3physicalagression
if !_rc {
replace _3physicalagression =99 if _3physicalagression ==6
}
else {

}
capture confirm numeric v _2workmate
if !_rc {
replace _2workmate =. if _2workmate >4
}
else {

}
capture confirm numeric v _2executionwork7
if !_rc {
replace _2executionwork7 =. if _2executionwork7 >2
}
else {

}
capture confirm numeric v snrecommendforjoblabourrelation
if !_rc {
replace snrecommendforjoblabourrelation =. if snrecommendforjoblabourrelation >2
}
else {

}
capture confirm numeric v _3snfindcurrentjobdummyfam
if !_rc {
replace _3snfindcurrentjobdummyfam =. if _3snfindcurrentjobdummyfam >2
}
else {

}
capture confirm numeric v covpressureadvance
if !_rc {
replace covpressureadvance =. if covpressureadvance >2
}
else {

}
capture confirm numeric v decisiondropping
if !_rc {
replace decisiondropping =77 if decisiondropping ==6
}
else {

}
capture confirm numeric v frequencygrossreceipt
if !_rc {
replace frequencygrossreceipt =. if frequencygrossreceipt >6
}
else {

}
capture confirm numeric v _2snhelpemergencymeet
if !_rc {
replace _2snhelpemergencymeet =77 if _2snhelpemergencymeet ==7
}
else {

}
capture confirm numeric v interestfrequency
if !_rc {
replace interestfrequency =. if interestfrequency >6
}
else {

}
capture confirm numeric v reciprocity1businesslender
if !_rc {
replace reciprocity1businesslender =. if reciprocity1businesslender >2
}
else {

}
capture confirm numeric v reservationkind
if !_rc {
replace reservationkind =. if reservationkind >6
}
else {

}
capture confirm numeric v _3snfindjobwkp
if !_rc {
replace _3snfindjobwkp =. if _3snfindjobwkp >2
}
else {

}
capture confirm numeric v _3searchjob
if !_rc {
replace _3searchjob =. if _3searchjob >2
}
else {

}
capture confirm numeric v _3agreementatwork3
if !_rc {
replace _3agreementatwork3 =. if _3agreementatwork3 >4
}
else {

}
capture confirm numeric v _2meetfrequemcybusinesslender
if !_rc {
replace _2meetfrequemcybusinesslender =. if _2meetfrequemcybusinesslender >6
}
else {

}
capture confirm numeric v workexposure5
if !_rc {
replace workexposure5 =. if workexposure5 >5
}
else {

}
capture confirm numeric v _3A4
if !_rc {
replace _3A4 =. if _3A4 >7
}
else {

}
capture confirm numeric v _3B7
if !_rc {
replace _3B7 =. if _3B7 >7
}
else {

}
capture confirm numeric v _2readystartjob
if !_rc {
replace _2readystartjob =. if _2readystartjob >2
}
else {

}
capture confirm numeric v _3snrecojobsuccesseduc
if !_rc {
replace _3snrecojobsuccesseduc =. if _3snrecojobsuccesseduc >7
}
else {

}
capture confirm numeric v migrationfindjob
if !_rc {
replace migrationfindjob =. if migrationfindjob >6
}
else {

}
capture confirm numeric v _3finishwhatbegin
if !_rc {
replace _3finishwhatbegin =. if _3finishwhatbegin >6
}
else {

}
capture confirm numeric v _3locuscontrol1
if !_rc {
replace _3locuscontrol1 =. if _3locuscontrol1 >5
}
else {

}
capture confirm numeric v snrecojobsuccessemployertype
if !_rc {
replace snrecojobsuccessemployertype =. if snrecojobsuccessemployertype >8
}
else {

}
capture confirm numeric v _3A2
if !_rc {
replace _3A2 =. if _3A2 >7
}
else {

}
capture confirm numeric v _2snentrustbusinesscastes
if !_rc {
replace _2snentrustbusinesscastes =. if _2snentrustbusinesscastes >17
}
else {

}
capture confirm numeric v _2rurallocation
if !_rc {
replace _2rurallocation =. if _2rurallocation >2
}
else {

}
capture confirm numeric v _2snfindcurrentjobintimacy
if !_rc {
replace _2snfindcurrentjobintimacy =. if _2snfindcurrentjobintimacy >3
}
else {

}
capture confirm numeric v _2sncloserelouthhlabourtype
if !_rc {
replace _2sncloserelouthhlabourtype =. if _2sncloserelouthhlabourtype >4
}
else {

}
capture confirm numeric v snhelpemergencyemployertype
if !_rc {
replace snhelpemergencyemployertype =. if snhelpemergencyemployertype >8
}
else {

}
capture confirm numeric v _2snfindjobemployertype
if !_rc {
replace _2snfindjobemployertype =. if _2snfindjobemployertype >8
}
else {

}
capture confirm numeric v _3sncloserelouthhemployertype
if !_rc {
replace _3sncloserelouthhemployertype =. if _3sncloserelouthhemployertype >8
}
else {

}
capture confirm numeric v _3covinstit5
if !_rc {
replace _3covinstit5 =. if _3covinstit5 >4
}
else {

}
capture confirm numeric v _3dummybusinessunpaidworkers
if !_rc {
replace _3dummybusinessunpaidworkers =. if _3dummybusinessunpaidworkers >2
}
else {

}
capture confirm numeric v _3snfindcurrentjoblabourrelation
if !_rc {
replace _3snfindcurrentjoblabourrelation =. if _3snfindcurrentjoblabourrelation >2
}
else {

}
capture confirm numeric v _2snrecruitworkercompared
if !_rc {
replace _2snrecruitworkercompared =. if _2snrecruitworkercompared >3
}
else {

}
capture confirm numeric v _3sncloserelouthhage
if !_rc {
replace _3sncloserelouthhage =. if _3sncloserelouthhage >6
}
else {

}
capture confirm numeric v executionwork8
if !_rc {
replace executionwork8 =. if executionwork8 >2
}
else {

}
capture confirm numeric v snrecommendassodistrict
if !_rc {
replace snrecommendassodistrict =. if snrecommendassodistrict >37
}
else {

}
capture confirm numeric v _3appointmentontime
if !_rc {
replace _3appointmentontime =. if _3appointmentontime >6
}
else {

}
capture confirm numeric v _2enjoypeople
if !_rc {
replace _2enjoypeople =. if _2enjoypeople >6
}
else {

}
capture confirm numeric v reasonneverattendedschool
if !_rc {
replace reasonneverattendedschool =. if reasonneverattendedschool >13
}
else {

}
capture confirm numeric v durationafter10th
if !_rc {
replace durationafter10th =. if durationafter10th >2
}
else {

}
capture confirm numeric v networktrustemployees
if !_rc {
replace networktrustemployees =. if networktrustemployees >6
}
else {

}
capture confirm numeric v dummyreligionspouse
if !_rc {
replace dummyreligionspouse =. if dummyreligionspouse >2
}
else {

}
capture confirm numeric v _2snfindsupplierslabourrelation
if !_rc {
replace _2snfindsupplierslabourrelation =. if _2snfindsupplierslabourrelation >2
}
else {

}
capture confirm numeric v snfindcurrentjobdummyfam
if !_rc {
replace snfindcurrentjobdummyfam =. if snfindcurrentjobdummyfam >2
}
else {

}
capture confirm numeric v sncloserelouthhlabourtype
if !_rc {
replace sncloserelouthhlabourtype =. if sncloserelouthhlabourtype >4
}
else {

}
capture confirm numeric v _3Ab2
if !_rc {
replace _3Ab2 =. if _3Ab2 >7
}
else {

}
capture confirm numeric v _3snrecojobsuccesscompared
if !_rc {
replace _3snrecojobsuccesscompared =. if _3snrecojobsuccesscompared >3
}
else {

}
capture confirm numeric v snfindsuppliersage
if !_rc {
replace snfindsuppliersage =. if snfindsuppliersage >6
}
else {

}
capture confirm numeric v _2snrecojobsuccessmeet
if !_rc {
replace _2snrecojobsuccessmeet =77 if _2snrecojobsuccessmeet ==7
}
else {

}
capture confirm numeric v _3snfindsupplierswkp
if !_rc {
replace _3snfindsupplierswkp =. if _3snfindsupplierswkp >2
}
else {

}
capture confirm numeric v dummyhelptosettleloan
if !_rc {
replace dummyhelptosettleloan =. if dummyhelptosettleloan >2
}
else {

}
capture confirm numeric v sncloserelouthhwkp
if !_rc {
replace sncloserelouthhwkp =. if sncloserelouthhwkp >2
}
else {

}
capture confirm numeric v _3dummyassohelpjob
if !_rc {
replace _3dummyassohelpjob =. if _3dummyassohelpjob >2
}
else {

}
capture confirm numeric v _2sntalkthemosteduc
if !_rc {
replace _2sntalkthemosteduc =. if _2sntalkthemosteduc >7
}
else {

}
capture confirm numeric v relationemployer
if !_rc {
replace relationemployer =. if relationemployer >13
}
else {

}
capture confirm numeric v recommenddetailscaste
if !_rc {
replace recommenddetailscaste =. if recommenddetailscaste >17
}
else {

}
capture confirm numeric v _2snhelpemergencydistrict
if !_rc {
replace _2snhelpemergencydistrict =. if _2snhelpemergencydistrict >37
}
else {

}
capture confirm numeric v _3networkhelpkinmember
if !_rc {
replace _3networkhelpkinmember =. if _3networkhelpkinmember >6
}
else {

}
capture confirm numeric v _3businesslossinvest
if !_rc {
replace _3businesslossinvest =1 if _3businesslossinvest ==2
}
else {

}
capture confirm numeric v snrecruitworkerdistrict
if !_rc {
replace snrecruitworkerdistrict =. if snrecruitworkerdistrict >37
}
else {

}
capture confirm numeric v sncloserelouthhfriend
if !_rc {
replace sncloserelouthhfriend =. if sncloserelouthhfriend >2
}
else {

}
capture confirm numeric v helpfulwithothers
if !_rc {
replace helpfulwithothers =. if helpfulwithothers >6
}
else {

}
capture confirm numeric v forgiveother
if !_rc {
replace forgiveother =. if forgiveother >6
}
else {

}
capture confirm numeric v _3snfindsuppliersinvite
if !_rc {
replace _3snfindsuppliersinvite =. if _3snfindsuppliersinvite >2
}
else {

}
capture confirm numeric v snfindjobeduc
if !_rc {
replace snfindjobeduc =. if snfindjobeduc >7
}
else {

}
capture confirm numeric v migrationarea
if !_rc {
replace migrationarea =. if migrationarea >6
}
else {

}
capture confirm numeric v _3numeracy4
if !_rc {
replace _3numeracy4 =. if _3numeracy4 >3
}
else {

}
capture confirm numeric v _3sncloserelouthhcompared
if !_rc {
replace _3sncloserelouthhcompared =. if _3sncloserelouthhcompared >3
}
else {

}
capture confirm numeric v _3verbalaggression
if !_rc {
replace _3verbalaggression =99 if _3verbalaggression ==6
}
else {

}
capture confirm numeric v snrecommendforjobfriend
if !_rc {
replace snrecommendforjobfriend =. if snrecommendforjobfriend >2
}
else {

}
capture confirm numeric v _2tryhard
if !_rc {
replace _2tryhard =. if _2tryhard >6
}
else {

}
capture confirm numeric v _3sncloserelouthhinvite
if !_rc {
replace _3sncloserelouthhinvite =. if _3sncloserelouthhinvite >2
}
else {

}
capture confirm numeric v _2sncloserelouthhruralurban
if !_rc {
replace _2sncloserelouthhruralurban =. if _2sncloserelouthhruralurban >2
}
else {

}
capture confirm numeric v covinstit6
if !_rc {
replace covinstit6 =. if covinstit6 >3
}
else {

}
capture confirm numeric v freehousebenefittype
if !_rc {
replace freehousebenefittype =. if freehousebenefittype >3
}
else {

}
capture confirm numeric v _2snentrustbusinesseduc
if !_rc {
replace _2snentrustbusinesseduc =. if _2snentrustbusinesseduc >7
}
else {

}
capture confirm numeric v ego2random_2
if !_rc {
replace ego2random_2 =. if ego2random_2 >2
}
else {

}
capture confirm numeric v _3snhelpemergencydistrict
if !_rc {
replace _3snhelpemergencydistrict =. if _3snhelpemergencydistrict >37
}
else {

}
capture confirm numeric v covnetworkpeoplehelping
if !_rc {
replace covnetworkpeoplehelping =. if covnetworkpeoplehelping >3
}
else {

}
capture confirm numeric v _2snrecruitworkereduc
if !_rc {
replace _2snrecruitworkereduc =. if _2snrecruitworkereduc >7
}
else {

}
capture confirm numeric v snhelpemergencyeduc
if !_rc {
replace snhelpemergencyeduc =. if snhelpemergencyeduc >7
}
else {

}
capture confirm numeric v break
if !_rc {
replace break =. if break >2
}
else {

}
capture confirm numeric v _2snfindcurrentjobcompared
if !_rc {
replace _2snfindcurrentjobcompared =. if _2snfindcurrentjobcompared >3
}
else {

}
capture confirm numeric v _3snhelpemergencyeduc
if !_rc {
replace _3snhelpemergencyeduc =. if _3snhelpemergencyeduc >7
}
else {

}
capture confirm numeric v contract
if !_rc {
replace contract =. if contract >3
}
else {

}
capture confirm numeric v _3Ab10
if !_rc {
replace _3Ab10 =. if _3Ab10 >7
}
else {

}
capture confirm numeric v _2sntalkthemostage
if !_rc {
replace _2sntalkthemostage =. if _2sntalkthemostage >6
}
else {

}
capture confirm numeric v dummyrecommendgiven
if !_rc {
replace dummyrecommendgiven =. if dummyrecommendgiven >2
}
else {

}
capture confirm numeric v _2snfindjobdistrict
if !_rc {
replace _2snfindjobdistrict =. if _2snfindjobdistrict >37
}
else {

}
capture confirm numeric v _2snentrustbusinesslabourrelation
if !_rc {
replace _2snentrustbusinesslabourrelation =. if _2snentrustbusinesslabourrelation >2
}
else {

}
capture confirm numeric v _2locuscontrol4
if !_rc {
replace _2locuscontrol4 =. if _2locuscontrol4 >5
}
else {

}
capture confirm numeric v _2covinstit3
if !_rc {
replace _2covinstit3 =. if _2covinstit3 >4
}
else {

}
capture confirm numeric v sncloserelouthhdummyfam
if !_rc {
replace sncloserelouthhdummyfam =. if sncloserelouthhdummyfam >2
}
else {

}
capture confirm numeric v A8
if !_rc {
replace A8 =. if A8 >7
}
else {

}
capture confirm numeric v snrecommendforjoblabourtype
if !_rc {
replace snrecommendforjoblabourtype =. if snrecommendforjoblabourtype >4
}
else {

}
capture confirm numeric v snrecommendforjobmeetfrequency
if !_rc {
replace snrecommendforjobmeetfrequency =. if snrecommendforjobmeetfrequency >6
}
else {

}
capture confirm numeric v _3everwork
if !_rc {
replace _3everwork =. if _3everwork >2
}
else {

}
capture confirm numeric v _3executionwork6
if !_rc {
replace _3executionwork6 =. if _3executionwork6 >2
}
else {

}
*capture confirm numeric v username
*if !_rc {
*replace username =. if username >12
*}
*else {
*
*}
capture confirm numeric v _2sncloserelouthhintimacy
if !_rc {
replace _2sncloserelouthhintimacy =. if _2sncloserelouthhintimacy >3
}
else {

}
capture confirm numeric v opinionactivewoman
if !_rc {
replace opinionactivewoman =. if opinionactivewoman >4
}
else {

}
capture confirm numeric v dummygoldpledged
if !_rc {
replace dummygoldpledged =. if dummygoldpledged >2
}
else {

}
capture confirm numeric v _3snfindsuppliersmeetfrequency
if !_rc {
replace _3snfindsuppliersmeetfrequency =. if _3snfindsuppliersmeetfrequency >6
}
else {

}
capture confirm numeric v _2snentrustbusinessmeet
if !_rc {
replace _2snentrustbusinessmeet =77 if _2snentrustbusinessmeet ==7
}
else {

}
capture confirm numeric v _2resdiscrimination5
if !_rc {
replace _2resdiscrimination5 =. if _2resdiscrimination5 >2
}
else {

}
capture confirm numeric v snfindjobwkp
if !_rc {
replace snfindjobwkp =. if snfindjobwkp >2
}
else {

}
capture confirm numeric v _2frequencygrossreceipt
if !_rc {
replace _2frequencygrossreceipt =. if _2frequencygrossreceipt >6
}
else {

}
capture confirm numeric v covlendrepayment
if !_rc {
replace covlendrepayment =. if covlendrepayment >3
}
else {

}
capture confirm numeric v _3sncloserelouthhdistrict
if !_rc {
replace _3sncloserelouthhdistrict =. if _3sncloserelouthhdistrict >37
}
else {

}
capture confirm numeric v _2sntalkthemostdistrict
if !_rc {
replace _2sntalkthemostdistrict =. if _2sntalkthemostdistrict >37
}
else {

}
capture confirm numeric v A5
if !_rc {
replace A5 =. if A5 >7
}
else {

}
capture confirm numeric v _2snrecommendforjobdistrict
if !_rc {
replace _2snrecommendforjobdistrict =. if _2snrecommendforjobdistrict >37
}
else {

}
capture confirm numeric v snentrustbusinessreciprocity1
if !_rc {
replace snentrustbusinessreciprocity1 =. if snentrustbusinessreciprocity1 >2
}
else {

}
capture confirm numeric v snfindjobemployertype
if !_rc {
replace snfindjobemployertype =. if snfindjobemployertype >8
}
else {

}
capture confirm numeric v _3snhelpemergencyliving
if !_rc {
replace _3snhelpemergencyliving =. if _3snhelpemergencyliving >6
}
else {

}
capture confirm numeric v _2snrecommendassowkp
if !_rc {
replace _2snrecommendassowkp =. if _2snrecommendassowkp >2
}
else {

}
capture confirm numeric v _2workwithother
if !_rc {
replace _2workwithother =. if _2workwithother >6
}
else {

}
capture confirm numeric v businesslabourerwagetype
if !_rc {
replace businesslabourerwagetype =. if businesslabourerwagetype >5
}
else {

}
capture confirm numeric v _3snentrustbusinesseduc
if !_rc {
replace _3snentrustbusinesseduc =. if _3snentrustbusinesseduc >7
}
else {

}
capture confirm numeric v problemrepayment
if !_rc {
replace problemrepayment =. if problemrepayment >2
}
else {

}
capture confirm numeric v _2snrecruitworkerlabourrelation
if !_rc {
replace _2snrecruitworkerlabourrelation =. if _2snrecruitworkerlabourrelation >2
}
else {

}
capture confirm numeric v _3toleratefaults
if !_rc {
replace _3toleratefaults =. if _3toleratefaults >6
}
else {

}
capture confirm numeric v _3ego2random_1
if !_rc {
replace _3ego2random_1 =. if _3ego2random_1 >2
}
else {

}
capture confirm numeric v _2snrecruitworkerreciprocity1
if !_rc {
replace _2snrecruitworkerreciprocity1 =. if _2snrecruitworkerreciprocity1 >2
}
else {

}
capture confirm numeric v _3reasonstoppedwagejob
if !_rc {
replace _3reasonstoppedwagejob =77 if _3reasonstoppedwagejob ==13
}
else {

}
capture confirm numeric v _2snhelpemergencysex
if !_rc {
replace _2snhelpemergencysex =. if _2snhelpemergencysex >2
}
else {

}
capture confirm numeric v salariedjobpension
if !_rc {
replace salariedjobpension =. if salariedjobpension >2
}
else {

}
capture confirm numeric v snfindcurrentjobliving
if !_rc {
replace snfindcurrentjobliving =. if snfindcurrentjobliving >6
}
else {

}
capture confirm numeric v _2changemood
if !_rc {
replace _2changemood =. if _2changemood >6
}
else {

}
capture confirm numeric v decisiondropping
if !_rc {
replace decisiondropping =. if decisiondropping >6
}
else {

}
capture confirm numeric v _3snrecojobsuccessdummyhh
if !_rc {
replace _3snrecojobsuccessdummyhh =. if _3snrecojobsuccessdummyhh >2
}
else {

}
capture confirm numeric v snrecommendforjobeduc
if !_rc {
replace snrecommendforjobeduc =. if snrecommendforjobeduc >7
}
else {

}
capture confirm numeric v covinstit5
if !_rc {
replace covinstit5 =. if covinstit5 >4
}
else {

}
capture confirm numeric v _3Ab5
if !_rc {
replace _3Ab5 =. if _3Ab5 >7
}
else {

}
capture confirm numeric v _3covinstit2
if !_rc {
replace _3covinstit2 =. if _3covinstit2 >4
}
else {

}
capture confirm numeric v snrecommendassomeet
if !_rc {
replace snrecommendassomeet =77 if snrecommendassomeet ==7
}
else {

}
capture confirm numeric v _3numeracy5
if !_rc {
replace _3numeracy5 =. if _3numeracy5 >3
}
else {

}
capture confirm numeric v salariedjobtype2
if !_rc {
replace salariedjobtype2 =. if salariedjobtype2 >2
}
else {

}
capture confirm numeric v _3nbercontactphone
if !_rc {
replace _3nbercontactphone =. if _3nbercontactphone >7
}
else {

}
capture confirm numeric v _3snfindjobreciprocity1
if !_rc {
replace _3snfindjobreciprocity1 =. if _3snfindjobreciprocity1 >2
}
else {

}
capture confirm numeric v _2snhelpemergencyinvite
if !_rc {
replace _2snhelpemergencyinvite =. if _2snhelpemergencyinvite >2
}
else {

}
capture confirm numeric v _2snrecommendforjobeduc
if !_rc {
replace _2snrecommendforjobeduc =. if _2snrecommendforjobeduc >7
}
else {

}
capture confirm numeric v _3break
if !_rc {
replace _3break =. if _3break >2
}
else {

}
capture confirm numeric v classcompleted
if !_rc {
replace classcompleted =. if classcompleted >16
}
else {

}
capture confirm numeric v covinstit3
if !_rc {
replace covinstit3 =. if covinstit3 >4
}
else {

}
capture confirm numeric v _2networkpeoplehelping
if !_rc {
replace _2networkpeoplehelping =. if _2networkpeoplehelping >6
}
else {

}
capture confirm numeric v _2sncloserelouthhsex
if !_rc {
replace _2sncloserelouthhsex =. if _2sncloserelouthhsex >2
}
else {

}
capture confirm numeric v snfindsuppliersfriend
if !_rc {
replace snfindsuppliersfriend =. if snfindsuppliersfriend >2
}
else {

}
capture confirm numeric v _3businessnbworkers
if !_rc {
replace _3businessnbworkers =. if _3businessnbworkers >16
}
else {

}
capture confirm numeric v _3snrecojobsuccessage
if !_rc {
replace _3snrecojobsuccessage =. if _3snrecojobsuccessage >6
}
else {

}
capture confirm numeric v _3snfindjobfriend
if !_rc {
replace _3snfindjobfriend =. if _3snfindjobfriend >2
}
else {

}
capture confirm numeric v snfindsupplierseduc
if !_rc {
replace snfindsupplierseduc =. if snfindsupplierseduc >7
}
else {

}
capture confirm numeric v _3snrecojobsuccessdistrict
if !_rc {
replace _3snrecojobsuccessdistrict =. if _3snrecojobsuccessdistrict >37
}
else {

}
capture confirm numeric v _3problemwork2
if !_rc {
replace _3problemwork2 =66 if _3problemwork2 ==4
}
else {

}
capture confirm numeric v snrecojobsuccessfriend
if !_rc {
replace snrecojobsuccessfriend =. if snrecojobsuccessfriend >2
}
else {

}
capture confirm numeric v termsofrepayment
if !_rc {
replace termsofrepayment =. if termsofrepayment >3
}
else {

}
capture confirm numeric v snfindsupplierscompared
if !_rc {
replace snfindsupplierscompared =. if snfindsupplierscompared >3
}
else {

}
capture confirm numeric v _3sntalkthemostliving
if !_rc {
replace _3sntalkthemostliving =. if _3sntalkthemostliving >6
}
else {

}
capture confirm numeric v _2snrecojobsuccessmeetfrequency
if !_rc {
replace _2snrecojobsuccessmeetfrequency =. if _2snrecojobsuccessmeetfrequency >6
}
else {

}
capture confirm numeric v _3covinstit7
if !_rc {
replace _3covinstit7 =. if _3covinstit7 >3
}
else {

}
capture confirm numeric v _3snfindcurrentjobruralurban
if !_rc {
replace _3snfindcurrentjobruralurban =. if _3snfindcurrentjobruralurban >2
}
else {

}
capture confirm numeric v _3sncloserelouthhsex
if !_rc {
replace _3sncloserelouthhsex =. if _3sncloserelouthhsex >2
}
else {

}
capture confirm numeric v _3comparedbusinesslender
if !_rc {
replace _3comparedbusinesslender =. if _3comparedbusinesslender >3
}
else {

}
capture confirm numeric v _3snfindcurrentjobliving
if !_rc {
replace _3snfindcurrentjobliving =. if _3snfindcurrentjobliving >6
}
else {

}
capture confirm numeric v _3snrecommendforjobemployertype
if !_rc {
replace _3snrecommendforjobemployertype =. if _3snrecommendforjobemployertype >8
}
else {

}
capture confirm numeric v _2dummyassohelpjob
if !_rc {
replace _2dummyassohelpjob =. if _2dummyassohelpjob >2
}
else {

}
capture confirm numeric v _2feeldepressed
if !_rc {
replace _2feeldepressed =. if _2feeldepressed >6
}
else {

}
capture confirm numeric v _3covinstit9
if !_rc {
replace _3covinstit9 =. if _3covinstit9 >3
}
else {

}
capture confirm numeric v _3sexualaggression
if !_rc {
replace _3sexualaggression =99 if _3sexualaggression ==5
}
else {

}
capture confirm numeric v reasondropping
if !_rc {
replace reasondropping =77 if reasondropping ==16
}
else {

}
capture confirm numeric v snfindsuppliersemployertype
if !_rc {
replace snfindsuppliersemployertype =. if snfindsuppliersemployertype >8
}
else {

}
capture confirm numeric v _2snfindcurrentjobsex
if !_rc {
replace _2snfindcurrentjobsex =. if _2snfindcurrentjobsex >2
}
else {

}
capture confirm numeric v snrecojobsuccesseduc
if !_rc {
replace snrecojobsuccesseduc =. if snrecojobsuccesseduc >7
}
else {

}
capture confirm numeric v _2workexposure2
if !_rc {
replace _2workexposure2 =. if _2workexposure2 >5
}
else {

}
capture confirm numeric v _3snfindsupplierscompared
if !_rc {
replace _3snfindsupplierscompared =. if _3snfindsupplierscompared >3
}
else {

}
capture confirm numeric v rurallocation
if !_rc {
replace rurallocation =. if rurallocation >2
}
else {

}
capture confirm numeric v remreceivedfrequency
if !_rc {
replace remreceivedfrequency =. if remreceivedfrequency >6
}
else {

}
capture confirm numeric v _3workmate
if !_rc {
replace _3workmate =. if _3workmate >4
}
else {

}
capture confirm numeric v everattendedschool
if !_rc {
replace everattendedschool =. if everattendedschool >2
}
else {

}
capture confirm numeric v _2verbalaggression
if !_rc {
replace _2verbalaggression =99 if _2verbalaggression ==6
}
else {

}
capture confirm numeric v _3A7
if !_rc {
replace _3A7 =. if _3A7 >7
}
else {

}
capture confirm numeric v _2snfindsuppliersinvite
if !_rc {
replace _2snfindsuppliersinvite =. if _2snfindsuppliersinvite >2
}
else {

}
capture confirm numeric v snrecruitworkersex
if !_rc {
replace snrecruitworkersex =. if snrecruitworkersex >2
}
else {

}
capture confirm numeric v reservationkind
if !_rc {
replace reservationkind =. if reservationkind >5
}
else {

}
capture confirm numeric v snrecojobsuccesscompared
if !_rc {
replace snrecojobsuccesscompared =. if snrecojobsuccesscompared >3
}
else {

}
capture confirm numeric v _2changework
if !_rc {
replace _2changework =. if _2changework >2
}
else {

}
capture confirm numeric v _2snhelpemergencycompared
if !_rc {
replace _2snhelpemergencycompared =. if _2snhelpemergencycompared >3
}
else {

}
capture confirm numeric v snfindsuppliersinvite
if !_rc {
replace snfindsuppliersinvite =. if snfindsuppliersinvite >2
}
else {

}
capture confirm numeric v _3snfindcurrentjobcompared
if !_rc {
replace _3snfindcurrentjobcompared =. if _3snfindcurrentjobcompared >3
}
else {

}
capture confirm numeric v sntalkthemostdistrict
if !_rc {
replace sntalkthemostdistrict =. if sntalkthemostdistrict >37
}
else {

}
capture confirm numeric v sntalkthemosteduc
if !_rc {
replace sntalkthemosteduc =. if sntalkthemosteduc >7
}
else {

}
capture confirm numeric v _3snrecruitworkercompared
if !_rc {
replace _3snrecruitworkercompared =. if _3snrecruitworkercompared >3
}
else {

}
capture confirm numeric v _2B3
if !_rc {
replace _2B3 =. if _2B3 >7
}
else {

}
capture confirm numeric v _2A11
if !_rc {
replace _2A11 =. if _2A11 >7
}
else {

}
capture confirm numeric v snrecojobsuccessintimacy
if !_rc {
replace snrecojobsuccessintimacy =. if snrecojobsuccessintimacy >3
}
else {

}
capture confirm numeric v _3snfindjobcompared
if !_rc {
replace _3snfindjobcompared =. if _3snfindjobcompared >3
}
else {

}
capture confirm numeric v _3snhelpemergencycompared
if !_rc {
replace _3snhelpemergencycompared =. if _3snhelpemergencycompared >3
}
else {

}
capture confirm numeric v executionwork6
if !_rc {
replace executionwork6 =. if executionwork6 >2
}
else {

}
capture confirm numeric v marriagearranged
if !_rc {
replace marriagearranged =. if marriagearranged >2
}
else {

}
capture confirm numeric v Ab7
if !_rc {
replace Ab7 =. if Ab7 >7
}
else {

}
capture confirm numeric v _3accidentalinjury
if !_rc {
replace _3accidentalinjury =. if _3accidentalinjury >2
}
else {

}
capture confirm numeric v snrecommendforjobwkp
if !_rc {
replace snrecommendforjobwkp =. if snrecommendforjobwkp >2
}
else {

}
capture confirm numeric v snrecommendassoeduc
if !_rc {
replace snrecommendassoeduc =. if snrecommendassoeduc >7
}
else {

}
capture confirm numeric v reasonnotusedebitcard
if !_rc {
replace reasonnotusedebitcard =. if reasonnotusedebitcard >7
}
else {

}
capture confirm numeric v _2Ab3
if !_rc {
replace _2Ab3 =. if _2Ab3 >7
}
else {

}
capture confirm numeric v snentrustbusinesslabourtype
if !_rc {
replace snentrustbusinesslabourtype =. if snentrustbusinesslabourtype >4
}
else {

}
capture confirm numeric v _3Ab11
if !_rc {
replace _3Ab11 =. if _3Ab11 >7
}
else {

}
capture confirm numeric v discrimination4
if !_rc {
replace discrimination4 =. if discrimination4 >2
}
else {

}
capture confirm numeric v _2problemwork4
if !_rc {
replace _2problemwork4 =66 if _2problemwork4 ==4
}
else {

}
capture confirm numeric v discrimination2
if !_rc {
replace discrimination2 =. if discrimination2 >2
}
else {

}
capture confirm numeric v sncloserelouthhcastes
if !_rc {
replace sncloserelouthhcastes =. if sncloserelouthhcastes >17
}
else {

}
capture confirm numeric v _3goaftergoal
if !_rc {
replace _3goaftergoal =. if _3goaftergoal >6
}
else {

}
capture confirm numeric v _3snrecojobsuccessmeetfrequency
if !_rc {
replace _3snrecojobsuccessmeetfrequency =. if _3snrecojobsuccessmeetfrequency >6
}
else {

}
capture confirm numeric v rationcardreasonnouse
if !_rc {
replace rationcardreasonnouse =. if rationcardreasonnouse >7
}
else {

}
capture confirm numeric v _3snhelpemergencyreciprocity1
if !_rc {
replace _3snhelpemergencyreciprocity1 =. if _3snhelpemergencyreciprocity1 >2
}
else {

}
capture confirm numeric v converseinenglish
if !_rc {
replace converseinenglish =. if converseinenglish >2
}
else {

}
capture confirm numeric v _2B10
if !_rc {
replace _2B10 =. if _2B10 >7
}
else {

}
capture confirm numeric v migrationbonus
if !_rc {
replace migrationbonus =. if migrationbonus >2
}
else {

}
capture confirm numeric v _2assohelpjob
if !_rc {
replace _2assohelpjob =. if _2assohelpjob >6
}
else {

}
capture confirm numeric v covamountinterest
if !_rc {
replace covamountinterest =. if covamountinterest >3
}
else {

}
capture confirm numeric v borrowerservices
if !_rc {
replace borrowerservices =. if borrowerservices >5
}
else {

}
capture confirm numeric v _3B3
if !_rc {
replace _3B3 =. if _3B3 >7
}
else {

}
capture confirm numeric v snentrustbusinesscastes
if !_rc {
replace snentrustbusinesscastes =. if snentrustbusinesscastes >17
}
else {

}
capture confirm numeric v _3problemwork1
if !_rc {
replace _3problemwork1 =66 if _3problemwork1 ==4
}
else {

}
capture confirm numeric v _3B6
if !_rc {
replace _3B6 =. if _3B6 >7
}
else {

}
capture confirm numeric v jobpreference
if !_rc {
replace jobpreference =66 if jobpreference ==4
}
else {

}
capture confirm numeric v _3snfindsupplierssex
if !_rc {
replace _3snfindsupplierssex =. if _3snfindsupplierssex >2
}
else {

}
capture confirm numeric v _2trustingofother
if !_rc {
replace _2trustingofother =. if _2trustingofother >6
}
else {

}
capture confirm numeric v shywithpeople
if !_rc {
replace shywithpeople =. if shywithpeople >6
}
else {

}
capture confirm numeric v _3snrecruitworkerfriend
if !_rc {
replace _3snrecruitworkerfriend =. if _3snrecruitworkerfriend >2
}
else {

}
capture confirm numeric v relationshiptohead
if !_rc {
replace relationshiptohead =77 if relationshiptohead ==18
}
else {

}
capture confirm numeric v migrationjobtype2
if !_rc {
replace migrationjobtype2 =. if migrationjobtype2 >2
}
else {

}
capture confirm numeric v covrefusalloan
if !_rc {
replace covrefusalloan =66 if covrefusalloan ==3
}
else {

}
capture confirm numeric v _2snfindcurrentjobreciprocity1
if !_rc {
replace _2snfindcurrentjobreciprocity1 =. if _2snfindcurrentjobreciprocity1 >2
}
else {

}
capture confirm numeric v snrecommendassoinvite
if !_rc {
replace snrecommendassoinvite =. if snrecommendassoinvite >2
}
else {

}
capture confirm numeric v _3snhelpemergencydummyfam
if !_rc {
replace _3snhelpemergencydummyfam =. if _3snhelpemergencydummyfam >2
}
else {

}
capture confirm numeric v repayduration1
if !_rc {
replace repayduration1 =. if repayduration1 >5
}
else {

}
capture confirm numeric v guarantordetailscaste
if !_rc {
replace guarantordetailscaste =. if guarantordetailscaste >17
}
else {

}
capture confirm numeric v _2finishwhatbegin
if !_rc {
replace _2finishwhatbegin =99 if _2finishwhatbegin ==6
}
else {

}
capture confirm numeric v _3businessnbpaidworkers
if !_rc {
replace _3businessnbpaidworkers =. if _3businessnbpaidworkers >16
}
else {

}
capture confirm numeric v _3workexposure2
if !_rc {
replace _3workexposure2 =. if _3workexposure2 >5
}
else {

}
capture confirm numeric v _3snrecommendforjobreciprocity1
if !_rc {
replace _3snrecommendforjobreciprocity1 =. if _3snrecommendforjobreciprocity1 >2
}
else {

}
capture confirm numeric v _3organized
if !_rc {
replace _3organized =. if _3organized >6
}
else {

}
capture confirm numeric v _2snrecojobsuccesslabourtype
if !_rc {
replace _2snrecojobsuccesslabourtype =. if _2snrecojobsuccesslabourtype >4
}
else {

}
capture confirm numeric v snhelpemergencyage
if !_rc {
replace snhelpemergencyage =. if snhelpemergencyage >6
}
else {

}
capture confirm numeric v _3snrecruitworkerlabourrelation
if !_rc {
replace _3snrecruitworkerlabourrelation =. if _3snrecruitworkerlabourrelation >2
}
else {

}
capture confirm numeric v discrimination1
if !_rc {
replace discrimination1 =. if discrimination1 >2
}
else {

}
capture confirm numeric v _2locuscontrol3
if !_rc {
replace _2locuscontrol3 =. if _2locuscontrol3 >5
}
else {

}
capture confirm numeric v _3executionwork5
if !_rc {
replace _3executionwork5 =. if _3executionwork5 >2
}
else {

}
capture confirm numeric v _2castebusinesslender
if !_rc {
replace _2castebusinesslender =77 if _2castebusinesslender ==18
}
else {

}
capture confirm numeric v _2sntalkthemostmeetfrequency
if !_rc {
replace _2sntalkthemostmeetfrequency =. if _2sntalkthemostmeetfrequency >6
}
else {

}
capture confirm numeric v _2snrecruitworkercastes
if !_rc {
replace _2snrecruitworkercastes =. if _2snrecruitworkercastes >17
}
else {

}
capture confirm numeric v goldreasonpledge
if !_rc {
replace goldreasonpledge =. if goldreasonpledge >13
}
else {

}
capture confirm numeric v snentrustbusiness
if !_rc {
replace snentrustbusiness =. if snentrustbusiness >3
}
else {

}
capture confirm numeric v _3snfindjobmeetfrequency
if !_rc {
replace _3snfindjobmeetfrequency =. if _3snfindjobmeetfrequency >6
}
else {

}
capture confirm numeric v _2appointmentontime
if !_rc {
replace _2appointmentontime =. if _2appointmentontime >6
}
else {

}
capture confirm numeric v _3snfindjoblabourrelation
if !_rc {
replace _3snfindjoblabourrelation =. if _3snfindjoblabourrelation >2
}
else {

}
capture confirm numeric v _3assohelpjob
if !_rc {
replace _3assohelpjob =. if _3assohelpjob >6
}
else {

}
capture confirm numeric v _3sncloserelouthhruralurban
if !_rc {
replace _3sncloserelouthhruralurban =. if _3sncloserelouthhruralurban >2
}
else {

}
capture confirm numeric v discrimination3
if !_rc {
replace discrimination3 =. if discrimination3 >2
}
else {

}
capture confirm numeric v _2snrecommendforjobmeet
if !_rc {
replace _2snrecommendforjobmeet =77 if _2snrecommendforjobmeet ==7
}
else {

}
capture confirm numeric v _3snrecojobsuccessliving
if !_rc {
replace _3snrecojobsuccessliving =. if _3snrecojobsuccessliving >6
}
else {

}
capture confirm numeric v _3snrecommendforjobintimacy
if !_rc {
replace _3snrecommendforjobintimacy =. if _3snrecommendforjobintimacy >3
}
else {

}
capture confirm numeric v _2sexualharassment
if !_rc {
replace _2sexualharassment =. if _2sexualharassment >2
}
else {

}
capture confirm numeric v _3A10
if !_rc {
replace _3A10 =. if _3A10 >7
}
else {

}
capture confirm numeric v agreementatwork4
if !_rc {
replace agreementatwork4 =. if agreementatwork4 >4
}
else {

}
capture confirm numeric v _3snfindcurrentjobmeetfrequency
if !_rc {
replace _3snfindcurrentjobmeetfrequency =. if _3snfindcurrentjobmeetfrequency >6
}
else {

}
capture confirm numeric v sntalkthemostwkp
if !_rc {
replace sntalkthemostwkp =. if sntalkthemostwkp >2
}
else {

}
capture confirm numeric v _3snrecommendassointimacy
if !_rc {
replace _3snrecommendassointimacy =. if _3snrecommendassointimacy >3
}
else {

}
capture confirm numeric v agreementatwork1
if !_rc {
replace agreementatwork1 =. if agreementatwork1 >4
}
else {

}
capture confirm numeric v _3snfindjobdummyhh
if !_rc {
replace _3snfindjobdummyhh =. if _3snfindjobdummyhh >2
}
else {

}
capture confirm numeric v maritalstatus
if !_rc {
replace maritalstatus =66 if maritalstatus ==5
}
else {

}
capture confirm numeric v _3canreadcard1c
if !_rc {
replace _3canreadcard1c =99 if _3canreadcard1c ==4
}
else {

}
capture confirm numeric v remsentfrequency
if !_rc {
replace remsentfrequency =. if remsentfrequency >6
}
else {

}
capture confirm numeric v _3snrecojobsuccess
if !_rc {
replace _3snrecojobsuccess =. if _3snrecojobsuccess >3
}
else {

}
capture confirm numeric v _3discrimination8
if !_rc {
replace _3discrimination8 =. if _3discrimination8 >2
}
else {

}
capture confirm numeric v _2sntalkthemostemployertype
if !_rc {
replace _2sntalkthemostemployertype =. if _2sntalkthemostemployertype >8
}
else {

}
capture confirm numeric v _3sharefeelings
if !_rc {
replace _3sharefeelings =. if _3sharefeelings >6
}
else {

}
capture confirm numeric v businesslabourertypejob
if !_rc {
replace businesslabourertypejob =. if businesslabourertypejob >4
}
else {

}
capture confirm numeric v _2canreadcard1c
if !_rc {
replace _2canreadcard1c =99 if _2canreadcard1c ==4
}
else {

}
capture confirm numeric v snfindjobage
if !_rc {
replace snfindjobage =. if snfindjobage >6
}
else {

}
capture confirm numeric v remsentrelation
if !_rc {
replace remsentrelation =. if remsentrelation >14
}
else {

}
capture confirm numeric v _3dummyseasonalmainoccup
if !_rc {
replace _3dummyseasonalmainoccup =. if _3dummyseasonalmainoccup >2
}
else {

}
capture confirm numeric v _3snentrustbusinessliving
if !_rc {
replace _3snentrustbusinessliving =. if _3snentrustbusinessliving >6
}
else {

}
capture confirm numeric v snrecruitworkerinvite
if !_rc {
replace snrecruitworkerinvite =. if snrecruitworkerinvite >2
}
else {

}
capture confirm numeric v _2snrecommendassofriend
if !_rc {
replace _2snrecommendassofriend =. if _2snrecommendassofriend >2
}
else {

}
capture confirm numeric v schedule
if !_rc {
replace schedule =. if schedule >4
}
else {

}
capture confirm numeric v _2physicalharm
if !_rc {
replace _2physicalharm =. if _2physicalharm >6
}
else {

}
capture confirm numeric v snrecruitworkereduc
if !_rc {
replace snrecruitworkereduc =. if snrecruitworkereduc >7
}
else {

}
capture confirm numeric v sntalkthemostintimacy
if !_rc {
replace sntalkthemostintimacy =. if sntalkthemostintimacy >3
}
else {

}
capture confirm numeric v snrecommendforjobintimacy
if !_rc {
replace snrecommendforjobintimacy =. if snrecommendforjobintimacy >3
}
else {

}
capture confirm numeric v _2methodfindjob
if !_rc {
replace _2methodfindjob =66 if _2methodfindjob ==10
}
else {

}
capture confirm numeric v _2snrecommendassolabourrelation
if !_rc {
replace _2snrecommendassolabourrelation =. if _2snrecommendassolabourrelation >2
}
else {

}
capture confirm numeric v snrecommendforjobinvite
if !_rc {
replace snrecommendforjobinvite =. if snrecommendforjobinvite >2
}
else {

}
capture confirm numeric v _2executionwork5
if !_rc {
replace _2executionwork5 =. if _2executionwork5 >2
}
else {

}
capture confirm numeric v activeimagination
if !_rc {
replace activeimagination =. if activeimagination >6
}
else {

}
capture confirm numeric v _3covnetworkpeoplehelping
if !_rc {
replace _3covnetworkpeoplehelping =. if _3covnetworkpeoplehelping >3
}
else {

}
capture confirm numeric v _2agebusinesslender
if !_rc {
replace _2agebusinesslender =. if _2agebusinesslender >6
}
else {

}
capture confirm numeric v sncloserelouthhage
if !_rc {
replace sncloserelouthhage =. if sncloserelouthhage >6
}
else {

}
capture confirm numeric v professionalequipment
if !_rc {
replace professionalequipment =. if professionalequipment >5
}
else {

}
capture confirm numeric v _2snfindjobcompared
if !_rc {
replace _2snfindjobcompared =. if _2snfindjobcompared >3
}
else {

}
capture confirm numeric v covremreceived
if !_rc {
replace covremreceived =. if covremreceived >3
}
else {

}
capture confirm numeric v Ab2
if !_rc {
replace Ab2 =. if Ab2 >7
}
else {

}
capture confirm numeric v _3snfindsuppliersintimacy
if !_rc {
replace _3snfindsuppliersintimacy =. if _3snfindsuppliersintimacy >3
}
else {

}
capture confirm numeric v sntalkthemostreciprocity1
if !_rc {
replace sntalkthemostreciprocity1 =. if sntalkthemostreciprocity1 >2
}
else {

}
capture confirm numeric v reservationkind
if !_rc {
replace reservationkind =77 if reservationkind ==6
}
else {

}
capture confirm numeric v _2Ab8
if !_rc {
replace _2Ab8 =. if _2Ab8 >7
}
else {

}
capture confirm numeric v _3wagejobsocialsecurity
if !_rc {
replace _3wagejobsocialsecurity =. if _3wagejobsocialsecurity >2
}
else {

}
capture confirm numeric v snentrustbusinessage
if !_rc {
replace snentrustbusinessage =. if snentrustbusinessage >6
}
else {

}
capture confirm numeric v _3sntalkthemostinvite
if !_rc {
replace _3sntalkthemostinvite =. if _3sntalkthemostinvite >2
}
else {

}
capture confirm numeric v _2A3
if !_rc {
replace _2A3 =. if _2A3 >7
}
else {

}
capture confirm numeric v _3snrecommendforjobwkp
if !_rc {
replace _3snrecommendforjobwkp =. if _3snrecommendforjobwkp >2
}
else {

}
capture confirm numeric v _2everwork
if !_rc {
replace _2everwork =. if _2everwork >2
}
else {

}
capture confirm numeric v _2takeholiday
if !_rc {
replace _2takeholiday =. if _2takeholiday >5
}
else {

}
capture confirm numeric v _2snrecommendassoeduc
if !_rc {
replace _2snrecommendassoeduc =. if _2snrecommendassoeduc >7
}
else {

}
capture confirm numeric v _2happywork
if !_rc {
replace _2happywork =. if _2happywork >4
}
else {

}
capture confirm numeric v _3discrimination1
if !_rc {
replace _3discrimination1 =. if _3discrimination1 >2
}
else {

}
capture confirm numeric v _3Ab3
if !_rc {
replace _3Ab3 =. if _3Ab3 >7
}
else {

}
capture confirm numeric v _2snrecojobsuccessinvite
if !_rc {
replace _2snrecojobsuccessinvite =. if _2snrecojobsuccessinvite >2
}
else {

}
capture confirm numeric v _3sncloserelouthhdummyfam
if !_rc {
replace _3sncloserelouthhdummyfam =. if _3sncloserelouthhdummyfam >2
}
else {

}
capture confirm numeric v _3snrecruitworkerwkp
if !_rc {
replace _3snrecruitworkerwkp =. if _3snrecruitworkerwkp >2
}
else {

}
capture confirm numeric v _3snrecommendassoinvite
if !_rc {
replace _3snrecommendassoinvite =. if _3snrecommendassoinvite >2
}
else {

}
capture confirm numeric v A9
if !_rc {
replace A9 =. if A9 >7
}
else {

}
capture confirm numeric v _2snrecommendassoruralurban
if !_rc {
replace _2snrecommendassoruralurban =. if _2snrecommendassoruralurban >2
}
else {

}
capture confirm numeric v businesslocation
if !_rc {
replace businesslocation =. if businesslocation >7
}
else {

}
capture confirm numeric v _2snfindsuppliersfriend
if !_rc {
replace _2snfindsuppliersfriend =. if _2snfindsuppliersfriend >2
}
else {

}
capture confirm numeric v _2problemwork8
if !_rc {
replace _2problemwork8 =66 if _2problemwork8 ==4
}
else {

}
capture confirm numeric v _3snfindsuppliersruralurban
if !_rc {
replace _3snfindsuppliersruralurban =. if _3snfindsuppliersruralurban >2
}
else {

}
capture confirm numeric v salariedjobinsurance
if !_rc {
replace salariedjobinsurance =. if salariedjobinsurance >2
}
else {

}
capture confirm numeric v _3A1
if !_rc {
replace _3A1 =. if _3A1 >7
}
else {

}
capture confirm numeric v chitfundpayment
if !_rc {
replace chitfundpayment =. if chitfundpayment >5
}
else {

}
capture confirm numeric v marriageblood
if !_rc {
replace marriageblood =. if marriageblood >2
}
else {

}
capture confirm numeric v _3snrecruitworkerreciprocity1
if !_rc {
replace _3snrecruitworkerreciprocity1 =. if _3snrecruitworkerreciprocity1 >2
}
else {

}
capture confirm numeric v snrecruitworkerliving
if !_rc {
replace snrecruitworkerliving =. if snrecruitworkerliving >6
}
else {

}
capture confirm numeric v _3snrecojobsuccessdummyfam
if !_rc {
replace _3snrecojobsuccessdummyfam =. if _3snrecojobsuccessdummyfam >2
}
else {

}
capture confirm numeric v sncloserelouthhsex
if !_rc {
replace sncloserelouthhsex =. if sncloserelouthhsex >2
}
else {

}
capture confirm numeric v _2Ab4
if !_rc {
replace _2Ab4 =. if _2Ab4 >7
}
else {

}
capture confirm numeric v _2snrecruitworkerintimacy
if !_rc {
replace _2snrecruitworkerintimacy =. if _2snrecruitworkerintimacy >3
}
else {

}
capture confirm numeric v insurancepaymentfrequency
if !_rc {
replace insurancepaymentfrequency =. if insurancepaymentfrequency >4
}
else {

}
capture confirm numeric v _3snfindjobliving
if !_rc {
replace _3snfindjobliving =. if _3snfindjobliving >6
}
else {

}
capture confirm numeric v snrecojobsuccesslabourrelation
if !_rc {
replace snrecojobsuccesslabourrelation =. if snrecojobsuccesslabourrelation >2
}
else {

}
capture confirm numeric v locuscontrol3
if !_rc {
replace locuscontrol3 =. if locuscontrol3 >5
}
else {

}
capture confirm numeric v _2snfindcurrentjobemployertype
if !_rc {
replace _2snfindcurrentjobemployertype =. if _2snfindcurrentjobemployertype >8
}
else {

}
capture confirm numeric v dummymainoccupation2
if !_rc {
replace dummymainoccupation2 =. if dummymainoccupation2 >2
}
else {

}
capture confirm numeric v _3snrecruitworkermeet
if !_rc {
replace _3snrecruitworkermeet =77 if _3snrecruitworkermeet ==7
}
else {

}
capture confirm numeric v Ab8
if !_rc {
replace Ab8 =. if Ab8 >7
}
else {

}
capture confirm numeric v comparedbusinesslender
if !_rc {
replace comparedbusinesslender =. if comparedbusinesslender >3
}
else {

}
capture confirm numeric v _2snrecruitworkerage
if !_rc {
replace _2snrecruitworkerage =. if _2snrecruitworkerage >6
}
else {

}
capture confirm numeric v _3snfindcurrentjobdummyhh
if !_rc {
replace _3snfindcurrentjobdummyhh =. if _3snfindcurrentjobdummyhh >2
}
else {

}
capture confirm numeric v snrecojobsuccessliving
if !_rc {
replace snrecojobsuccessliving =. if snrecojobsuccessliving >6
}
else {

}
capture confirm numeric v _2snrecommendforjobemployertype
if !_rc {
replace _2snrecommendforjobemployertype =. if _2snrecommendforjobemployertype >8
}
else {

}
capture confirm numeric v _3ego2random_2_3
if !_rc {
replace _3ego2random_2_3 =. if _3ego2random_2_3 >2
}
else {

}
capture confirm numeric v _2schedule
if !_rc {
replace _2schedule =. if _2schedule >4
}
else {

}
capture confirm numeric v snfindsuppliersdistrict
if !_rc {
replace snfindsuppliersdistrict =. if snfindsuppliersdistrict >37
}
else {

}
capture confirm numeric v _3snrecruitworkerage
if !_rc {
replace _3snrecruitworkerage =. if _3snrecruitworkerage >6
}
else {

}
capture confirm numeric v _2executionwork1
if !_rc {
replace _2executionwork1 =. if _2executionwork1 >2
}
else {

}
capture confirm numeric v _2comparedbusinesslender
if !_rc {
replace _2comparedbusinesslender =. if _2comparedbusinesslender >3
}
else {

}
capture confirm numeric v dummyinterest
if !_rc {
replace dummyinterest =. if dummyinterest >2
}
else {

}
capture confirm numeric v snrecommendassodummyfam
if !_rc {
replace snrecommendassodummyfam =. if snrecommendassodummyfam >2
}
else {

}
capture confirm numeric v _3snentrustbusinesslabourrelation
if !_rc {
replace _3snentrustbusinesslabourrelation =. if _3snentrustbusinesslabourrelation >2
}
else {

}
capture confirm numeric v snrecommendassoreciprocity1
if !_rc {
replace snrecommendassoreciprocity1 =. if snrecommendassoreciprocity1 >2
}
else {

}
capture confirm numeric v _3snhelpemergencyage
if !_rc {
replace _3snhelpemergencyage =. if _3snhelpemergencyage >6
}
else {

}
capture confirm numeric v snfindjobmeetfrequency
if !_rc {
replace snfindjobmeetfrequency =. if snfindjobmeetfrequency >6
}
else {

}
capture confirm numeric v jobfirstwagefrequencycash
if !_rc {
replace jobfirstwagefrequencycash =. if jobfirstwagefrequencycash >4
}
else {

}
capture confirm numeric v _2snrecommendassoinvite
if !_rc {
replace _2snrecommendassoinvite =. if _2snrecommendassoinvite >2
}
else {

}
capture confirm numeric v _3snrecommendforjobdummyhh
if !_rc {
replace _3snrecommendforjobdummyhh =. if _3snrecommendforjobdummyhh >2
}
else {

}
capture confirm numeric v dummyrecommendation
if !_rc {
replace dummyrecommendation =. if dummyrecommendation >2
}
else {

}
capture confirm numeric v _2covinstit7
if !_rc {
replace _2covinstit7 =. if _2covinstit7 >3
}
else {

}
capture confirm numeric v _3snfindcurrentjobfriend
if !_rc {
replace _3snfindcurrentjobfriend =. if _3snfindcurrentjobfriend >2
}
else {

}
capture confirm numeric v _3intimacybusinesslender
if !_rc {
replace _3intimacybusinesslender =. if _3intimacybusinesslender >3
}
else {

}
capture confirm numeric v _2sntalkthemostfriend
if !_rc {
replace _2sntalkthemostfriend =. if _2sntalkthemostfriend >2
}
else {

}
capture confirm numeric v _3snfindcurrentjobinvite
if !_rc {
replace _3snfindcurrentjobinvite =. if _3snfindcurrentjobinvite >2
}
else {

}
capture confirm numeric v insurancebenefit
if !_rc {
replace insurancebenefit =. if insurancebenefit >2
}
else {

}
capture confirm numeric v snrecommendassoage
if !_rc {
replace snrecommendassoage =. if snrecommendassoage >6
}
else {

}
capture confirm numeric v problemwork8
if !_rc {
replace problemwork8 =66 if problemwork8 ==4
}
else {

}
capture confirm numeric v casteemployer
if !_rc {
replace casteemployer =77 if casteemployer ==18
}
else {

}
capture confirm numeric v snrecruitworkercastes
if !_rc {
replace snrecruitworkercastes =. if snrecruitworkercastes >17
}
else {

}
capture confirm numeric v _2snrecommendforjobsex
if !_rc {
replace _2snrecommendforjobsex =. if _2snrecommendforjobsex >2
}
else {

}
capture confirm numeric v migrationjobtype
if !_rc {
replace migrationjobtype =. if migrationjobtype >4
}
else {

}
capture confirm numeric v A3
if !_rc {
replace A3 =. if A3 >7
}
else {

}
capture confirm numeric v _3snfindsuppliersmeet
if !_rc {
replace _3snfindsuppliersmeet =77 if _3snfindsuppliersmeet ==7
}
else {

}
capture confirm numeric v covdifficulties
if !_rc {
replace covdifficulties =. if covdifficulties >10
}
else {

}
capture confirm numeric v ego2random_3_3
if !_rc {
replace ego2random_3_3 =. if ego2random_3_3 >2
}
else {

}
capture confirm numeric v _2sntalkthemostreciprocity1
if !_rc {
replace _2sntalkthemostreciprocity1 =. if _2sntalkthemostreciprocity1 >2
}
else {

}
capture confirm numeric v _2snhelpemergencyreciprocity1
if !_rc {
replace _2snhelpemergencyreciprocity1 =. if _2snhelpemergencyreciprocity1 >2
}
else {

}
capture confirm numeric v _3discrimination2
if !_rc {
replace _3discrimination2 =. if _3discrimination2 >2
}
else {

}
capture confirm numeric v _3sncloserelouthheduc
if !_rc {
replace _3sncloserelouthheduc =. if _3sncloserelouthheduc >7
}
else {

}
capture confirm numeric v _3snfindcurrentjobemployertype
if !_rc {
replace _3snfindcurrentjobemployertype =. if _3snfindcurrentjobemployertype >8
}
else {

}
capture confirm numeric v _2workexposure1
if !_rc {
replace _2workexposure1 =. if _2workexposure1 >5
}
else {

}
capture confirm numeric v remreceivedservices
if !_rc {
replace remreceivedservices =. if remreceivedservices >6
}
else {

}
capture confirm numeric v _2sntalkthemostliving
if !_rc {
replace _2sntalkthemostliving =. if _2sntalkthemostliving >6
}
else {

}
capture confirm numeric v _3assosize
if !_rc {
replace _3assosize =88 if _3assosize ==5
}
else {

}
capture confirm numeric v _2dummyassorecommendation
if !_rc {
replace _2dummyassorecommendation =. if _2dummyassorecommendation >2
}
else {

}
capture confirm numeric v reasonnotworkpastyear
if !_rc {
replace reasonnotworkpastyear =. if reasonnotworkpastyear >15
}
else {

}
capture confirm numeric v talkative
if !_rc {
replace talkative =. if talkative >6
}
else {

}
capture confirm numeric v sncloserelouthhmeet
if !_rc {
replace sncloserelouthhmeet =77 if sncloserelouthhmeet ==7
}
else {

}
capture confirm numeric v _3keepworking
if !_rc {
replace _3keepworking =. if _3keepworking >6
}
else {

}
capture confirm numeric v covinstit10
if !_rc {
replace covinstit10 =. if covinstit10 >3
}
else {

}
capture confirm numeric v snfindsuppliers
if !_rc {
replace snfindsuppliers =. if snfindsuppliers >3
}
else {

}
capture confirm numeric v startbusiness
if !_rc {
replace startbusiness =. if startbusiness >2
}
else {

}
capture confirm numeric v _2snfindsupplierslabourtype
if !_rc {
replace _2snfindsupplierslabourtype =. if _2snfindsupplierslabourtype >4
}
else {

}
capture confirm numeric v _3startbusiness
if !_rc {
replace _3startbusiness =. if _3startbusiness >2
}
else {

}
capture confirm numeric v snhelpemergencywkp
if !_rc {
replace snhelpemergencywkp =. if snhelpemergencywkp >2
}
else {

}
capture confirm numeric v snrecommendassolabourtype
if !_rc {
replace snrecommendassolabourtype =. if snrecommendassolabourtype >4
}
else {

}
capture confirm numeric v _2snfindjobwkp
if !_rc {
replace _2snfindjobwkp =. if _2snfindjobwkp >2
}
else {

}
capture confirm numeric v dummyassohelpjob
if !_rc {
replace dummyassohelpjob =. if dummyassohelpjob >2
}
else {

}
capture confirm numeric v _3snrecruitworkeremployertype
if !_rc {
replace _3snrecruitworkeremployertype =. if _3snrecruitworkeremployertype >8
}
else {

}
capture confirm numeric v covneworktrustneighborhood
if !_rc {
replace covneworktrustneighborhood =. if covneworktrustneighborhood >3
}
else {

}
capture confirm numeric v _3ego2random_1_2
if !_rc {
replace _3ego2random_1_2 =. if _3ego2random_1_2 >2
}
else {

}
capture confirm numeric v _2numeracy1
if !_rc {
replace _2numeracy1 =. if _2numeracy1 >3
}
else {

}
capture confirm numeric v dummyseasonalmainoccup
if !_rc {
replace dummyseasonalmainoccup =. if dummyseasonalmainoccup >2
}
else {

}
capture confirm numeric v dummycastespouse
if !_rc {
replace dummycastespouse =. if dummycastespouse >2
}
else {

}
capture confirm numeric v _3inventive
if !_rc {
replace _3inventive =. if _3inventive >6
}
else {

}
capture confirm numeric v _2sncloserelouthhdistrict
if !_rc {
replace _2sncloserelouthhdistrict =. if _2sncloserelouthhdistrict >37
}
else {

}
capture confirm numeric v _2snentrustbusinessdummyhh
if !_rc {
replace _2snentrustbusinessdummyhh =. if _2snentrustbusinessdummyhh >2
}
else {

}
capture confirm numeric v covinstit7
if !_rc {
replace covinstit7 =. if covinstit7 >3
}
else {

}
capture confirm numeric v _2networktrustemployees
if !_rc {
replace _2networktrustemployees =. if _2networktrustemployees >6
}
else {

}
capture confirm numeric v remreceivedsourcerelation
if !_rc {
replace remreceivedsourcerelation =. if remreceivedsourcerelation >14
}
else {

}
capture confirm numeric v dummyhhrespondentego1
if !_rc {
replace dummyhhrespondentego1 =. if dummyhhrespondentego1 >2
}
else {

}
capture confirm numeric v remgift
if !_rc {
replace remgift =. if remgift >2
}
else {

}
capture confirm numeric v snfindcurrentjobmeetfrequency
if !_rc {
replace snfindcurrentjobmeetfrequency =. if snfindcurrentjobmeetfrequency >6
}
else {

}
capture confirm numeric v dummyscholarship
if !_rc {
replace dummyscholarship =. if dummyscholarship >2
}
else {

}
capture confirm numeric v Ab10
if !_rc {
replace Ab10 =. if Ab10 >7
}
else {

}
capture confirm numeric v newideas
if !_rc {
replace newideas =. if newideas >6
}
else {

}
capture confirm numeric v religionspouse
if !_rc {
replace religionspouse =. if religionspouse >4
}
else {

}
capture confirm numeric v _2discrimination7
if !_rc {
replace _2discrimination7 =. if _2discrimination7 >2
}
else {

}
capture confirm numeric v _2snfindcurrentjoblabourtype
if !_rc {
replace _2snfindcurrentjoblabourtype =. if _2snfindcurrentjoblabourtype >4
}
else {

}
capture confirm numeric v _2B11
if !_rc {
replace _2B11 =. if _2B11 >7
}
else {

}
capture confirm numeric v sntalkthemostcastes
if !_rc {
replace sntalkthemostcastes =. if sntalkthemostcastes >17
}
else {

}
capture confirm numeric v _3locuscontrol2
if !_rc {
replace _3locuscontrol2 =. if _3locuscontrol2 >5
}
else {

}
capture confirm numeric v _2snhelpemergencymeetfrequency
if !_rc {
replace _2snhelpemergencymeetfrequency =. if _2snhelpemergencymeetfrequency >6
}
else {

}
capture confirm numeric v _3assodegreeparticip
if !_rc {
replace _3assodegreeparticip =. if _3assodegreeparticip >3
}
else {

}
capture confirm numeric v makeplans
if !_rc {
replace makeplans =. if makeplans >6
}
else {

}
capture confirm numeric v _3resdiscrimination5
if !_rc {
replace _3resdiscrimination5 =. if _3resdiscrimination5 >2
}
else {

}
capture confirm numeric v snhelpemergencylabourrelation
if !_rc {
replace snhelpemergencylabourrelation =. if snhelpemergencylabourrelation >2
}
else {

}
capture confirm numeric v snfindsuppliersruralurban
if !_rc {
replace snfindsuppliersruralurban =. if snfindsuppliersruralurban >2
}
else {

}
capture confirm numeric v covfrequencyrepayment
if !_rc {
replace covfrequencyrepayment =66 if covfrequencyrepayment ==3
}
else {

}
capture confirm numeric v snrecruitworkermeet
if !_rc {
replace snrecruitworkermeet =77 if snrecruitworkermeet ==7
}
else {

}
capture confirm numeric v snrecojobsuccessmeetfrequency
if !_rc {
replace snrecojobsuccessmeetfrequency =. if snrecojobsuccessmeetfrequency >6
}
else {

}
capture confirm numeric v _2snrecommendforjobdummyfam
if !_rc {
replace _2snrecommendforjobdummyfam =. if _2snrecommendforjobdummyfam >2
}
else {

}
capture confirm numeric v _3snentrustbusiness
if !_rc {
replace _3snentrustbusiness =. if _3snentrustbusiness >3
}
else {

}
capture confirm numeric v _3respect
if !_rc {
replace _3respect =. if _3respect >4
}
else {

}
capture confirm numeric v migrationchild
if !_rc {
replace migrationchild =. if migrationchild >2
}
else {

}
capture confirm numeric v snrecommendassoruralurban
if !_rc {
replace snrecommendassoruralurban =. if snrecommendassoruralurban >2
}
else {

}
capture confirm numeric v previousjobcontract
if !_rc {
replace previousjobcontract =. if previousjobcontract >2
}
else {

}
capture confirm numeric v reasonstoppedwagejob
if !_rc {
replace reasonstoppedwagejob =77 if reasonstoppedwagejob ==13
}
else {

}
capture confirm numeric v workexposure1
if !_rc {
replace workexposure1 =99 if workexposure1 ==5
}
else {

}
capture confirm numeric v _2snfindsuppliersemployertype
if !_rc {
replace _2snfindsuppliersemployertype =. if _2snfindsuppliersemployertype >8
}
else {

}
capture confirm numeric v _3repetitivetasks
if !_rc {
replace _3repetitivetasks =. if _3repetitivetasks >6
}
else {

}
capture confirm numeric v appointmentontime
if !_rc {
replace appointmentontime =. if appointmentontime >6
}
else {

}
capture confirm numeric v _3snrecruitworkermeetfrequency
if !_rc {
replace _3snrecruitworkermeetfrequency =. if _3snrecruitworkermeetfrequency >6
}
else {

}
capture confirm numeric v snfindjobdummyfam
if !_rc {
replace snfindjobdummyfam =. if snfindjobdummyfam >2
}
else {

}
capture confirm numeric v _3snfindjobmeet
if !_rc {
replace _3snfindjobmeet =. if _3snfindjobmeet >7
}
else {

}
capture confirm numeric v snhelpemergencyreciprocity1
if !_rc {
replace snhelpemergencyreciprocity1 =. if snhelpemergencyreciprocity1 >2
}
else {

}
capture confirm numeric v _3agreementatwork2
if !_rc {
replace _3agreementatwork2 =. if _3agreementatwork2 >4
}
else {

}
capture confirm numeric v assodegreeparticip
if !_rc {
replace assodegreeparticip =. if assodegreeparticip >3
}
else {

}
capture confirm numeric v _2snfindsuppliersdummyfam
if !_rc {
replace _2snfindsuppliersdummyfam =. if _2snfindsuppliersdummyfam >2
}
else {

}
capture confirm numeric v _3snentrustbusinessmeet
if !_rc {
replace _3snentrustbusinessmeet =77 if _3snentrustbusinessmeet ==7
}
else {

}
capture confirm numeric v _3snhelpemergencyinvite
if !_rc {
replace _3snhelpemergencyinvite =. if _3snhelpemergencyinvite >2
}
else {

}
capture confirm numeric v snfindsuppliersintimacy
if !_rc {
replace snfindsuppliersintimacy =. if snfindsuppliersintimacy >3
}
else {

}
capture confirm numeric v subjectsafter10th
if !_rc {
replace subjectsafter10th =66 if subjectsafter10th ==7
}
else {

}
capture confirm numeric v _3snfindcurrentjob
if !_rc {
replace _3snfindcurrentjob =. if _3snfindcurrentjob >3
}
else {

}
capture confirm numeric v snentrustbusinesscompared
if !_rc {
replace snentrustbusinesscompared =. if snentrustbusinesscompared >3
}
else {

}
capture confirm numeric v _2snhelpemergencyfriend
if !_rc {
replace _2snhelpemergencyfriend =. if _2snhelpemergencyfriend >2
}
else {

}
capture confirm numeric v salariedcontract
if !_rc {
replace salariedcontract =. if salariedcontract >2
}
else {

}
capture confirm numeric v castespouse
if !_rc {
replace castespouse =. if castespouse >17
}
else {

}
capture confirm numeric v _2snrecojobsuccesslabourrelation
if !_rc {
replace _2snrecojobsuccesslabourrelation =. if _2snrecojobsuccesslabourrelation >2
}
else {

}
capture confirm numeric v A10
if !_rc {
replace A10 =. if A10 >7
}
else {

}
capture confirm numeric v snfindjobcastes
if !_rc {
replace snfindjobcastes =. if snfindjobcastes >17
}
else {

}
capture confirm numeric v _2understandotherfeeling
if !_rc {
replace _2understandotherfeeling =. if _2understandotherfeeling >6
}
else {

}
capture confirm numeric v _3snrecojobsuccessmeet
if !_rc {
replace _3snrecojobsuccessmeet =77 if _3snrecojobsuccessmeet ==7
}
else {

}
capture confirm numeric v _3Ab8
if !_rc {
replace _3Ab8 =. if _3Ab8 >7
}
else {

}
capture confirm numeric v snrecruitworkerintimacy
if !_rc {
replace snrecruitworkerintimacy =. if snrecruitworkerintimacy >3
}
else {

}
capture confirm numeric v _2satisfactionsalary
if !_rc {
replace _2satisfactionsalary =. if _2satisfactionsalary >5
}
else {

}
capture confirm numeric v _3B8
if !_rc {
replace _3B8 =. if _3B8 >7
}
else {

}
capture confirm numeric v snrecommendforjobemployertype
if !_rc {
replace snrecommendforjobemployertype =. if snrecommendforjobemployertype >8
}
else {

}
capture confirm numeric v _2invitebusinesslender
if !_rc {
replace _2invitebusinesslender =. if _2invitebusinesslender >2
}
else {

}
capture confirm numeric v _2sncloserelouthhwkp
if !_rc {
replace _2sncloserelouthhwkp =. if _2sncloserelouthhwkp >2
}
else {

}
capture confirm numeric v snrecojobsuccessdummyhh
if !_rc {
replace snrecojobsuccessdummyhh =. if snrecojobsuccessdummyhh >2
}
else {

}
capture confirm numeric v _3locuscontrol3
if !_rc {
replace _3locuscontrol3 =. if _3locuscontrol3 >5
}
else {

}
capture confirm numeric v _2opinionactivewoman
if !_rc {
replace _2opinionactivewoman =. if _2opinionactivewoman >4
}
else {

}
capture confirm numeric v _2snfindsupplierseduc
if !_rc {
replace _2snfindsupplierseduc =. if _2snfindsupplierseduc >7
}
else {

}
capture confirm numeric v _2problemwork2
if !_rc {
replace _2problemwork2 =66 if _2problemwork2 ==4
}
else {

}
capture confirm numeric v _2covnetworkpeoplehelping
if !_rc {
replace _2covnetworkpeoplehelping =. if _2covnetworkpeoplehelping >3
}
else {

}
capture confirm numeric v dummygold
if !_rc {
replace dummygold =. if dummygold >2
}
else {

}
capture confirm numeric v _3forgiveother
if !_rc {
replace _3forgiveother =. if _3forgiveother >6
}
else {

}
capture confirm numeric v _2sntalkthemostsex
if !_rc {
replace _2sntalkthemostsex =. if _2sntalkthemostsex >2
}
else {

}
capture confirm numeric v covfrequencyinterest
if !_rc {
replace covfrequencyinterest =66 if covfrequencyinterest ==3
}
else {

}
capture confirm numeric v _3A5
if !_rc {
replace _3A5 =. if _3A5 >7
}
else {

}
capture confirm numeric v _3liketothink
if !_rc {
replace _3liketothink =. if _3liketothink >6
}
else {

}
capture confirm numeric v _2workhard
if !_rc {
replace _2workhard =. if _2workhard >6
}
else {

}
capture confirm numeric v snfindcurrentjobreciprocity1
if !_rc {
replace snfindcurrentjobreciprocity1 =. if snfindcurrentjobreciprocity1 >2
}
else {

}
capture confirm numeric v _2snrecruitworkerdummyfam
if !_rc {
replace _2snrecruitworkerdummyfam =. if _2snrecruitworkerdummyfam >2
}
else {

}
capture confirm numeric v executionwork9
if !_rc {
replace executionwork9 =. if executionwork9 >2
}
else {

}
*capture confirm numeric v username
*if !_rc {
*replace username =. if username >8
*}
*else {
*
*}
capture confirm numeric v _3workexposure5
if !_rc {
replace _3workexposure5 =. if _3workexposure5 >5
}
else {

}
capture confirm numeric v nervous
if !_rc {
replace nervous =. if nervous >6
}
else {

}
capture confirm numeric v _3tryhard
if !_rc {
replace _3tryhard =. if _3tryhard >6
}
else {

}
capture confirm numeric v _2snfindsupplierswkp
if !_rc {
replace _2snfindsupplierswkp =. if _2snfindsupplierswkp >2
}
else {

}
capture confirm numeric v dummydebitcard
if !_rc {
replace dummydebitcard =. if dummydebitcard >2
}
else {

}
capture confirm numeric v _2Ab12
if !_rc {
replace _2Ab12 =. if _2Ab12 >7
}
else {

}
capture confirm numeric v dummybusinesslabourers
if !_rc {
replace dummybusinesslabourers =. if dummybusinesslabourers >2
}
else {

}
capture confirm numeric v _3lackskill
if !_rc {
replace _3lackskill =. if _3lackskill >2
}
else {

}
capture confirm numeric v _3covinstit10
if !_rc {
replace _3covinstit10 =. if _3covinstit10 >3
}
else {

}
capture confirm numeric v _3snfindjobdistrict
if !_rc {
replace _3snfindjobdistrict =. if _3snfindjobdistrict >37
}
else {

}
capture confirm numeric v _2sncloserelouthhcastes
if !_rc {
replace _2sncloserelouthhcastes =. if _2sncloserelouthhcastes >17
}
else {

}
capture confirm numeric v _3sexbusinesslender
if !_rc {
replace _3sexbusinesslender =. if _3sexbusinesslender >2
}
else {

}
capture confirm numeric v _3A11
if !_rc {
replace _3A11 =. if _3A11 >7
}
else {

}
capture confirm numeric v _3snhelpemergencyfriend
if !_rc {
replace _3snhelpemergencyfriend =. if _3snhelpemergencyfriend >2
}
else {

}
capture confirm numeric v _2workpastsevendays
if !_rc {
replace _2workpastsevendays =. if _2workpastsevendays >2
}
else {

}
capture confirm numeric v _2businesspaymentinkindlist
if !_rc {
replace _2businesspaymentinkindlist =77 if _2businesspaymentinkindlist ==6
}
else {

}
capture confirm numeric v snentrustbusinessfriend
if !_rc {
replace snentrustbusinessfriend =. if snentrustbusinessfriend >2
}
else {

}
capture confirm numeric v usedebitcard
if !_rc {
replace usedebitcard =77 if usedebitcard ==7
}
else {

}
capture confirm numeric v _3sntalkthemostemployertype
if !_rc {
replace _3sntalkthemostemployertype =. if _3sntalkthemostemployertype >8
}
else {

}
capture confirm numeric v _2snfindjobdummyhh
if !_rc {
replace _2snfindjobdummyhh =. if _2snfindjobdummyhh >2
}
else {

}
capture confirm numeric v dummymarriage
if !_rc {
replace dummymarriage =. if dummymarriage >2
}
else {

}
capture confirm numeric v dummymigration
if !_rc {
replace dummymigration =. if dummymigration >2
}
else {

}
capture confirm numeric v businesspaymentinkind
if !_rc {
replace businesspaymentinkind =. if businesspaymentinkind >2
}
else {

}
capture confirm numeric v _2keepworking
if !_rc {
replace _2keepworking =. if _2keepworking >6
}
else {

}
capture confirm numeric v _3snrecommendassoruralurban
if !_rc {
replace _3snrecommendassoruralurban =. if _3snrecommendassoruralurban >2
}
else {

}
capture confirm numeric v _3snfindsuppliersreciprocity1
if !_rc {
replace _3snfindsuppliersreciprocity1 =. if _3snfindsuppliersreciprocity1 >2
}
else {

}
capture confirm numeric v searchjobsince15
if !_rc {
replace searchjobsince15 =. if searchjobsince15 >2
}
else {

}
capture confirm numeric v religionspouse
if !_rc {
replace religionspouse =77 if religionspouse ==4
}
else {

}
capture confirm numeric v _2retirementwork
if !_rc {
replace _2retirementwork =. if _2retirementwork >2
}
else {

}
capture confirm numeric v _3A6
if !_rc {
replace _3A6 =. if _3A6 >7
}
else {

}
capture confirm numeric v snfindcurrentjobinvite
if !_rc {
replace snfindcurrentjobinvite =. if snfindcurrentjobinvite >2
}
else {

}
capture confirm numeric v snrecruitworkerfriend
if !_rc {
replace snrecruitworkerfriend =. if snrecruitworkerfriend >2
}
else {

}
capture confirm numeric v _3sntalkthemostruralurban
if !_rc {
replace _3sntalkthemostruralurban =. if _3sntalkthemostruralurban >2
}
else {

}
capture confirm numeric v _3executionwork4
if !_rc {
replace _3executionwork4 =. if _3executionwork4 >2
}
else {

}
capture confirm numeric v workhard
if !_rc {
replace workhard =. if workhard >6
}
else {

}
capture confirm numeric v lendersex
if !_rc {
replace lendersex =66 if lendersex ==3
}
else {

}
capture confirm numeric v _2curious
if !_rc {
replace _2curious =. if _2curious >6
}
else {

}
capture confirm numeric v _2sncloserelouthheduc
if !_rc {
replace _2sncloserelouthheduc =. if _2sncloserelouthheduc >7
}
else {

}
capture confirm numeric v snentrustbusinessdistrict
if !_rc {
replace snentrustbusinessdistrict =. if snentrustbusinessdistrict >37
}
else {

}
capture confirm numeric v _3discrimination4
if !_rc {
replace _3discrimination4 =. if _3discrimination4 >2
}
else {

}
capture confirm numeric v _2canreadcard1b
if !_rc {
replace _2canreadcard1b =99 if _2canreadcard1b ==4
}
else {

}
capture confirm numeric v relationwithborrower
if !_rc {
replace relationwithborrower =. if relationwithborrower >14
}
else {

}
capture confirm numeric v migrationskill
if !_rc {
replace migrationskill =. if migrationskill >5
}
else {

}
capture confirm numeric v _2intimacybusinesslender
if !_rc {
replace _2intimacybusinesslender =. if _2intimacybusinesslender >3
}
else {

}
capture confirm numeric v discrimination5
if !_rc {
replace discrimination5 =. if discrimination5 >2
}
else {

}
capture confirm numeric v dummyremsent
if !_rc {
replace dummyremsent =. if dummyremsent >2
}
else {

}
capture confirm numeric v _2snfindsuppliersliving
if !_rc {
replace _2snfindsuppliersliving =. if _2snfindsuppliersliving >6
}
else {

}
capture confirm numeric v _3sntalkthemostcastes
if !_rc {
replace _3sntalkthemostcastes =. if _3sntalkthemostcastes >17
}
else {

}
capture confirm numeric v B12
if !_rc {
replace B12 =. if B12 >7
}
else {

}
capture confirm numeric v _3sncloserelouthhlabourrelation
if !_rc {
replace _3sncloserelouthhlabourrelation =. if _3sncloserelouthhlabourrelation >2
}
else {

}
capture confirm numeric v sntalkthemostsex
if !_rc {
replace sntalkthemostsex =. if sntalkthemostsex >2
}
else {

}
capture confirm numeric v _2covdifficulties
if !_rc {
replace _2covdifficulties =77 if _2covdifficulties ==10
}
else {

}
capture confirm numeric v _2covcontactinstitution
if !_rc {
replace _2covcontactinstitution =. if _2covcontactinstitution >5
}
else {

}
capture confirm numeric v _2snrecommendforjobliving
if !_rc {
replace _2snrecommendforjobliving =. if _2snrecommendforjobliving >6
}
else {

}
capture confirm numeric v B4
if !_rc {
replace B4 =. if B4 >7
}
else {

}
capture confirm numeric v _3dummyaspirationmorehours
if !_rc {
replace _3dummyaspirationmorehours =0 if _3dummyaspirationmorehours ==1
}
else {

}
capture confirm numeric v _3sexualharassment
if !_rc {
replace _3sexualharassment =. if _3sexualharassment >2
}
else {

}
capture confirm numeric v _3discrimination5
if !_rc {
replace _3discrimination5 =. if _3discrimination5 >2
}
else {

}
capture confirm numeric v _2dummymainoccupation2
if !_rc {
replace _2dummymainoccupation2 =. if _2dummymainoccupation2 >2
}
else {

}
capture confirm numeric v agreementatwork2
if !_rc {
replace agreementatwork2 =. if agreementatwork2 >4
}
else {

}
capture confirm numeric v wagejobpaymentinkind
if !_rc {
replace wagejobpaymentinkind =. if wagejobpaymentinkind >2
}
else {

}
capture confirm numeric v snentrustbusinessdummyfam
if !_rc {
replace snentrustbusinessdummyfam =. if snentrustbusinessdummyfam >2
}
else {

}
capture confirm numeric v _2respect
if !_rc {
replace _2respect =. if _2respect >4
}
else {

}
capture confirm numeric v _2problemwork7
if !_rc {
replace _2problemwork7 =66 if _2problemwork7 ==4
}
else {

}
capture confirm numeric v _3snentrustbusinesswkp
if !_rc {
replace _3snentrustbusinesswkp =. if _3snentrustbusinesswkp >2
}
else {

}
capture confirm numeric v _3ego2random_3_3
if !_rc {
replace _3ego2random_3_3 =. if _3ego2random_3_3 >2
}
else {

}
capture confirm numeric v _2nbermonthsearchjob
if !_rc {
replace _2nbermonthsearchjob =0 if _2nbermonthsearchjob ==14
}
else {

}
capture confirm numeric v losswork
if !_rc {
replace losswork =. if losswork >2
}
else {

}
capture confirm numeric v compensation
if !_rc {
replace compensation =. if compensation >2
}
else {

}
capture confirm numeric v snfindjobcompared
if !_rc {
replace snfindjobcompared =. if snfindjobcompared >3
}
else {

}
capture confirm numeric v migrationpension
if !_rc {
replace migrationpension =. if migrationpension >2
}
else {

}
capture confirm numeric v _2snrecojobsuccesswkp
if !_rc {
replace _2snrecojobsuccesswkp =. if _2snrecojobsuccesswkp >2
}
else {

}
capture confirm numeric v _2B5
if !_rc {
replace _2B5 =. if _2B5 >7
}
else {

}
capture confirm numeric v _2sntalkthemostintimacy
if !_rc {
replace _2sntalkthemostintimacy =. if _2sntalkthemostintimacy >3
}
else {

}
capture confirm numeric v _2agreementatwork4
if !_rc {
replace _2agreementatwork4 =. if _2agreementatwork4 >4
}
else {

}
capture confirm numeric v _3opinionworkingwoman
if !_rc {
replace _3opinionworkingwoman =. if _3opinionworkingwoman >4
}
else {

}
capture confirm numeric v savingspurpose
if !_rc {
replace savingspurpose =. if savingspurpose >6
}
else {

}
capture confirm numeric v executionwork3
if !_rc {
replace executionwork3 =. if executionwork3 >2
}
else {

}
capture confirm numeric v _3sncloserelouthhreciprocity1
if !_rc {
replace _3sncloserelouthhreciprocity1 =. if _3sncloserelouthhreciprocity1 >2
}
else {

}
capture confirm numeric v moveoutsideforjob
if !_rc {
replace moveoutsideforjob =. if moveoutsideforjob >2
}
else {

}
capture confirm numeric v snrecojobsuccessage
if !_rc {
replace snrecojobsuccessage =. if snrecojobsuccessage >6
}
else {

}
capture confirm numeric v _3snrecruitworkercastes
if !_rc {
replace _3snrecruitworkercastes =. if _3snrecruitworkercastes >17
}
else {

}
capture confirm numeric v changemood
if !_rc {
replace changemood =. if changemood >6
}
else {

}
capture confirm numeric v _2sncloserelouthhliving
if !_rc {
replace _2sncloserelouthhliving =. if _2sncloserelouthhliving >6
}
else {

}
capture confirm numeric v _2snrecruitworkerliving
if !_rc {
replace _2snrecruitworkerliving =. if _2snrecruitworkerliving >6
}
else {

}
capture confirm numeric v snfindjob
if !_rc {
replace snfindjob =. if snfindjob >3
}
else {

}
capture confirm numeric v _3dummymainoccupation2
if !_rc {
replace _3dummymainoccupation2 =. if _3dummymainoccupation2 >2
}
else {

}
capture confirm numeric v everwork
if !_rc {
replace everwork =. if everwork >2
}
else {

}
capture confirm numeric v _2A6
if !_rc {
replace _2A6 =. if _2A6 >7
}
else {

}
capture confirm numeric v _3businesspaymentinkind
if !_rc {
replace _3businesspaymentinkind =. if _3businesspaymentinkind >2
}
else {

}
capture confirm numeric v _2inventive
if !_rc {
replace _2inventive =. if _2inventive >6
}
else {

}
capture confirm numeric v _2snrecommendforjoblabourtype
if !_rc {
replace _2snrecommendforjoblabourtype =. if _2snrecommendforjoblabourtype >4
}
else {

}
capture confirm numeric v _2snrecojobsuccessemployertype
if !_rc {
replace _2snrecojobsuccessemployertype =. if _2snrecojobsuccessemployertype >8
}
else {

}
capture confirm numeric v _2A5
if !_rc {
replace _2A5 =. if _2A5 >7
}
else {

}
capture confirm numeric v marriageloanlendersex
if !_rc {
replace marriageloanlendersex =. if marriageloanlendersex >2
}
else {

}
capture confirm numeric v _2problemwork1
if !_rc {
replace _2problemwork1 =66 if _2problemwork1 ==4
}
else {

}
capture confirm numeric v _2snrecommendforjobreciprocity1
if !_rc {
replace _2snrecommendforjobreciprocity1 =. if _2snrecommendforjobreciprocity1 >2
}
else {

}
capture confirm numeric v _3discrimination3
if !_rc {
replace _3discrimination3 =. if _3discrimination3 >2
}
else {

}
capture confirm numeric v dummycontactleaders
if !_rc {
replace dummycontactleaders =. if dummycontactleaders >2
}
else {

}
capture confirm numeric v _3snentrustbusinessdummyfam
if !_rc {
replace _3snentrustbusinessdummyfam =. if _3snentrustbusinessdummyfam >2
}
else {

}
capture confirm numeric v castebusinesslabourer
if !_rc {
replace castebusinesslabourer =88 if castebusinesslabourer ==17
}
else {

}
capture confirm numeric v _3talktomanypeople
if !_rc {
replace _3talktomanypeople =. if _3talktomanypeople >6
}
else {

}
capture confirm numeric v _3snfindcurrentjobmeet
if !_rc {
replace _3snfindcurrentjobmeet =77 if _3snfindcurrentjobmeet ==7
}
else {

}
capture confirm numeric v _2snentrustbusinessreciprocity1
if !_rc {
replace _2snentrustbusinessreciprocity1 =. if _2snentrustbusinessreciprocity1 >2
}
else {

}
capture confirm numeric v businessworkersfrequencypayment
if !_rc {
replace businessworkersfrequencypayment =. if businessworkersfrequencypayment >4
}
else {

}
capture confirm numeric v _3snrecommendassofriend
if !_rc {
replace _3snrecommendassofriend =. if _3snrecommendassofriend >2
}
else {

}
capture confirm numeric v _3snrecojobsuccesslabourrelation
if !_rc {
replace _3snrecojobsuccesslabourrelation =. if _3snrecojobsuccesslabourrelation >2
}
else {

}
capture confirm numeric v _2staycalm
if !_rc {
replace _2staycalm =. if _2staycalm >6
}
else {

}
capture confirm numeric v _2snfindcurrentjobcastes
if !_rc {
replace _2snfindcurrentjobcastes =. if _2snfindcurrentjobcastes >17
}
else {

}
capture confirm numeric v insurancetype2
if !_rc {
replace insurancetype2 =. if insurancetype2 >6
}
else {

}
capture confirm numeric v loanproductpledge
if !_rc {
replace loanproductpledge =77 if loanproductpledge ==16
}
else {

}
capture confirm numeric v intimacybusinesslender
if !_rc {
replace intimacybusinesslender =. if intimacybusinesslender >3
}
else {

}
capture confirm numeric v _3staycalm
if !_rc {
replace _3staycalm =. if _3staycalm >6
}
else {

}
capture confirm numeric v _3snrecommendassoeduc
if !_rc {
replace _3snrecommendassoeduc =88 if _3snrecommendassoeduc ==7
}
else {

}
capture confirm numeric v _3workexposure3
if !_rc {
replace _3workexposure3 =66 if _3workexposure3 ==4
}
else {

}
capture confirm numeric v _3sntalkthemostage
if !_rc {
replace _3sntalkthemostage =. if _3sntalkthemostage >6
}
else {

}
capture confirm numeric v _2covworkeffort
if !_rc {
replace _2covworkeffort =66 if _2covworkeffort ==6
}
else {

}
capture confirm numeric v _2sncloserelouthhfriend
if !_rc {
replace _2sncloserelouthhfriend =. if _2sncloserelouthhfriend >2
}
else {

}
capture confirm numeric v dummyincomeassets
if !_rc {
replace dummyincomeassets =. if dummyincomeassets >2
}
else {

}
capture confirm numeric v covsick
if !_rc {
replace covsick =. if covsick >2
}
else {

}
capture confirm numeric v _2snentrustbusiness
if !_rc {
replace _2snentrustbusiness =. if _2snentrustbusiness >3
}
else {

}
capture confirm numeric v _2Ab1
if !_rc {
replace _2Ab1 =. if _2Ab1 >7
}
else {

}
capture confirm numeric v remsentservices
if !_rc {
replace remsentservices =77 if remsentservices ==6
}
else {

}
capture confirm numeric v _2sntalkthemostcastes
if !_rc {
replace _2sntalkthemostcastes =. if _2sntalkthemostcastes >17
}
else {

}
capture confirm numeric v _3agebusinesslender
if !_rc {
replace _3agebusinesslender =. if _3agebusinesslender >6
}
else {

}
capture confirm numeric v invitebusinesslender
if !_rc {
replace invitebusinesslender =. if invitebusinesslender >2
}
else {

}
capture confirm numeric v snrecommendassocompared
if !_rc {
replace snrecommendassocompared =. if snrecommendassocompared >3
}
else {

}
capture confirm numeric v _2satisfyingpurpose
if !_rc {
replace _2satisfyingpurpose =. if _2satisfyingpurpose >4
}
else {

}
capture confirm numeric v takeholiday
if !_rc {
replace takeholiday =. if takeholiday >5
}
else {

}
capture confirm numeric v snfindcurrentjoblabourrelation
if !_rc {
replace snfindcurrentjoblabourrelation =. if snfindcurrentjoblabourrelation >2
}
else {

}
capture confirm numeric v reasondropping
if !_rc {
replace reasondropping =. if reasondropping >16
}
else {

}
capture confirm numeric v remsentoccup
if !_rc {
replace remsentoccup =77 if remsentoccup ==8
}
else {

}
capture confirm numeric v _3B12
if !_rc {
replace _3B12 =. if _3B12 >7
}
else {

}
capture confirm numeric v _3snfindcurrentjobsex
if !_rc {
replace _3snfindcurrentjobsex =. if _3snfindcurrentjobsex >2
}
else {

}
capture confirm numeric v _2sncloserelouthhmeetfrequency
if !_rc {
replace _2sncloserelouthhmeetfrequency =. if _2sncloserelouthhmeetfrequency >6
}
else {

}
capture confirm numeric v repetitivetasks
if !_rc {
replace repetitivetasks =. if repetitivetasks >6
}
else {

}
capture confirm numeric v sncloserelouthhreciprocity1
if !_rc {
replace sncloserelouthhreciprocity1 =. if sncloserelouthhreciprocity1 >2
}
else {

}
capture confirm numeric v _2nbercontactphone
if !_rc {
replace _2nbercontactphone =. if _2nbercontactphone >7
}
else {

}
capture confirm numeric v _3snrecojobsuccesssex
if !_rc {
replace _3snrecojobsuccesssex =. if _3snrecojobsuccesssex >2
}
else {

}
capture confirm numeric v B9
if !_rc {
replace B9 =. if B9 >7
}
else {

}
capture confirm numeric v _2methodfindfirstjob
if !_rc {
replace _2methodfindfirstjob =66 if _2methodfindfirstjob ==10
}
else {

}
capture confirm numeric v _2reasondontsearchjobsince15
if !_rc {
replace _2reasondontsearchjobsince15 =. if _2reasondontsearchjobsince15 >15
}
else {

}
capture confirm numeric v A12
if !_rc {
replace A12 =. if A12 >7
}
else {

}
capture confirm numeric v snrecommendassowkp
if !_rc {
replace snrecommendassowkp =. if snrecommendassowkp >2
}
else {

}
capture confirm numeric v settleloanstrategy
if !_rc {
replace settleloanstrategy =77 if settleloanstrategy ==11
}
else {

}
capture confirm numeric v reasonnoinsurance
if !_rc {
replace reasonnoinsurance =. if reasonnoinsurance >4
}
else {

}
capture confirm numeric v _3nervous
if !_rc {
replace _3nervous =. if _3nervous >6
}
else {

}
capture confirm numeric v _2snfindsuppliersdistrict
if !_rc {
replace _2snfindsuppliersdistrict =. if _2snfindsuppliersdistrict >37
}
else {

}
capture confirm numeric v dummysavingaccount
if !_rc {
replace dummysavingaccount =. if dummysavingaccount >2
}
else {

}
capture confirm numeric v _2snrecommendassoemployertype
if !_rc {
replace _2snrecommendassoemployertype =. if _2snrecommendassoemployertype >8
}
else {

}
capture confirm numeric v _2completeduties
if !_rc {
replace _2completeduties =. if _2completeduties >6
}
else {

}
capture confirm numeric v snrecruitworkerruralurban
if !_rc {
replace snrecruitworkerruralurban =. if snrecruitworkerruralurban >2
}
else {

}
capture confirm numeric v snfindcurrentjoblabourtype
if !_rc {
replace snfindcurrentjoblabourtype =. if snfindcurrentjoblabourtype >4
}
else {

}
capture confirm numeric v guarantee
if !_rc {
replace guarantee =. if guarantee >7
}
else {

}
capture confirm numeric v _2businessnbunpaidworkers
if !_rc {
replace _2businessnbunpaidworkers =. if _2businessnbunpaidworkers >16
}
else {

}
capture confirm numeric v discrimination6
if !_rc {
replace discrimination6 =. if discrimination6 >2
}
else {

}
capture confirm numeric v _3snrecommendforjoblabourtype
if !_rc {
replace _3snrecommendforjoblabourtype =. if _3snrecommendforjoblabourtype >4
}
else {

}
capture confirm numeric v _3snfindjobeduc
if !_rc {
replace _3snfindjobeduc =. if _3snfindjobeduc >7
}
else {

}
capture confirm numeric v termsofrepayment
if !_rc {
replace termsofrepayment =. if termsofrepayment >4
}
else {

}
capture confirm numeric v problemwork9
if !_rc {
replace problemwork9 =66 if problemwork9 ==4
}
else {

}
capture confirm numeric v resdiscrimination2
if !_rc {
replace resdiscrimination2 =. if resdiscrimination2 >2
}
else {

}
capture confirm numeric v _2snfindjobruralurban
if !_rc {
replace _2snfindjobruralurban =. if _2snfindjobruralurban >2
}
else {

}
capture confirm numeric v snfindsuppliersmeet
if !_rc {
replace snfindsuppliersmeet =77 if snfindsuppliersmeet ==7
}
else {

}
capture confirm numeric v _2Ab9
if !_rc {
replace _2Ab9 =. if _2Ab9 >7
}
else {

}
capture confirm numeric v salariedwagetype
if !_rc {
replace salariedwagetype =. if salariedwagetype >5
}
else {

}
capture confirm numeric v _3snrecommendforjobsex
if !_rc {
replace _3snrecommendforjobsex =. if _3snrecommendforjobsex >2
}
else {

}
capture confirm numeric v _2snhelpemergencydummyfam
if !_rc {
replace _2snhelpemergencydummyfam =. if _2snhelpemergencydummyfam >2
}
else {

}
capture confirm numeric v _3snentrustbusinessemployertype
if !_rc {
replace _3snentrustbusinessemployertype =. if _3snentrustbusinessemployertype >8
}
else {

}
capture confirm numeric v snentrustbusinesswkp
if !_rc {
replace snentrustbusinesswkp =. if snentrustbusinesswkp >2
}
else {

}
capture confirm numeric v worryalot
if !_rc {
replace worryalot =. if worryalot >6
}
else {

}
capture confirm numeric v problemwork10
if !_rc {
replace problemwork10 =66 if problemwork10 ==4
}
else {

}
capture confirm numeric v expressingthoughts
if !_rc {
replace expressingthoughts =. if expressingthoughts >6
}
else {

}
capture confirm numeric v _2dummyassohelpbusiness
if !_rc {
replace _2dummyassohelpbusiness =. if _2dummyassohelpbusiness >2
}
else {

}
capture confirm numeric v _3A9
if !_rc {
replace _3A9 =. if _3A9 >7
}
else {

}
capture confirm numeric v snrecojobsuccess
if !_rc {
replace snrecojobsuccess =. if snrecojobsuccess >3
}
else {

}
capture confirm numeric v _3resdiscrimination2
if !_rc {
replace _3resdiscrimination2 =. if _3resdiscrimination2 >2
}
else {

}
capture confirm numeric v _3dummyassorecommendation
if !_rc {
replace _3dummyassorecommendation =. if _3dummyassorecommendation >2
}
else {

}
capture confirm numeric v jobwagefrequencycash
if !_rc {
replace jobwagefrequencycash =. if jobwagefrequencycash >4
}
else {

}
capture confirm numeric v accidentalinjury
if !_rc {
replace accidentalinjury =. if accidentalinjury >2
}
else {

}
capture confirm numeric v _3discrimination6
if !_rc {
replace _3discrimination6 =. if _3discrimination6 >2
}
else {

}
capture confirm numeric v _3agreementatwork1
if !_rc {
replace _3agreementatwork1 =. if _3agreementatwork1 >4
}
else {

}
capture confirm numeric v _3B10
if !_rc {
replace _3B10 =. if _3B10 >7
}
else {

}
capture confirm numeric v _3locuscontrol6
if !_rc {
replace _3locuscontrol6 =. if _3locuscontrol6 >5
}
else {

}
capture confirm numeric v _3Ab7
if !_rc {
replace _3Ab7 =. if _3Ab7 >7
}
else {

}
capture confirm numeric v lenderfromgold
if !_rc {
replace lenderfromgold =88 if lenderfromgold ==4
}
else {

}
capture confirm numeric v maritalstatus
if !_rc {
replace maritalstatus =. if maritalstatus >5
}
else {

}
capture confirm numeric v _2resdiscrimination2
if !_rc {
replace _2resdiscrimination2 =. if _2resdiscrimination2 >2
}
else {

}
capture confirm numeric v _3snrecommendforjobeduc
if !_rc {
replace _3snrecommendforjobeduc =. if _3snrecommendforjobeduc >7
}
else {

}
capture confirm numeric v interviewplace
if !_rc {
replace interviewplace =. if interviewplace >3
}
else {

}
capture confirm numeric v _3snrecommendforjobage
if !_rc {
replace _3snrecommendforjobage =. if _3snrecommendforjobage >6
}
else {

}
capture confirm numeric v snhelpemergencyfriend
if !_rc {
replace snhelpemergencyfriend =. if snhelpemergencyfriend >2
}
else {

}
capture confirm numeric v _3interestedbyart
if !_rc {
replace _3interestedbyart =. if _3interestedbyart >6
}
else {

}
capture confirm numeric v snrecruitworkerreciprocity1
if !_rc {
replace snrecruitworkerreciprocity1 =0 if snrecruitworkerreciprocity1 ==2
}
else {

}
capture confirm numeric v howpaymarriage
if !_rc {
replace howpaymarriage =. if howpaymarriage >4
}
else {

}
capture confirm numeric v _2snentrustbusinessliving
if !_rc {
replace _2snentrustbusinessliving =. if _2snentrustbusinessliving >6
}
else {

}
capture confirm numeric v plantorepay
if !_rc {
replace plantorepay =77 if plantorepay ==7
}
else {

}
capture confirm numeric v purposeloanborrower
if !_rc {
replace purposeloanborrower =. if purposeloanborrower >13
}
else {

}
capture confirm numeric v _3B1
if !_rc {
replace _3B1 =. if _3B1 >7
}
else {

}
capture confirm numeric v _3ego2random_2_2
if !_rc {
replace _3ego2random_2_2 =. if _3ego2random_2_2 >2
}
else {

}
capture confirm numeric v _3A12
if !_rc {
replace _3A12 =. if _3A12 >7
}
else {

}
capture confirm numeric v _2snfindjob
if !_rc {
replace _2snfindjob =. if _2snfindjob >3
}
else {

}
capture confirm numeric v _2A9
if !_rc {
replace _2A9 =. if _2A9 >7
}
else {

}
capture confirm numeric v _2assohelpbusiness
if !_rc {
replace _2assohelpbusiness =77 if _2assohelpbusiness ==8
}
else {

}
capture confirm numeric v snrecommendforjobage
if !_rc {
replace snrecommendforjobage =. if snrecommendforjobage >6
}
else {

}
capture confirm numeric v recommendloanrelation
if !_rc {
replace recommendloanrelation =99 if recommendloanrelation ==13
}
else {

}
capture confirm numeric v managestress
if !_rc {
replace managestress =. if managestress >6
}
else {

}
capture confirm numeric v lenderscaste
if !_rc {
replace lenderscaste =77 if lenderscaste ==18
}
else {

}
capture confirm numeric v reasonnotusedcreditcard
if !_rc {
replace reasonnotusedcreditcard =77 if reasonnotusedcreditcard ==7
}
else {

}
capture confirm numeric v _3dummybusinesspaidworkers
if !_rc {
replace _3dummybusinesspaidworkers =. if _3dummybusinesspaidworkers >2
}
else {

}
capture confirm numeric v _2discrimination6
if !_rc {
replace _2discrimination6 =. if _2discrimination6 >2
}
else {

}
capture confirm numeric v currentlyatschool
if !_rc {
replace currentlyatschool =. if currentlyatschool >2
}
else {

}
capture confirm numeric v _3snhelpemergencyintimacy
if !_rc {
replace _3snhelpemergencyintimacy =. if _3snhelpemergencyintimacy >3
}
else {

}
capture confirm numeric v _2numeracy5
if !_rc {
replace _2numeracy5 =. if _2numeracy5 >3
}
else {

}
capture confirm numeric v verbalaggression
if !_rc {
replace verbalaggression =99 if verbalaggression ==6
}
else {

}
capture confirm numeric v businesslabourerbonus
if !_rc {
replace businesslabourerbonus =. if businesslabourerbonus >2
}
else {

}
capture confirm numeric v _3easilydistracted
if !_rc {
replace _3easilydistracted =. if _3easilydistracted >6
}
else {

}
capture confirm numeric v _3feeldepressed
if !_rc {
replace _3feeldepressed =. if _3feeldepressed >6
}
else {

}
capture confirm numeric v _2snrecojobsuccessage
if !_rc {
replace _2snrecojobsuccessage =. if _2snrecojobsuccessage >6
}
else {

}
capture confirm numeric v _2discrimination8
if !_rc {
replace _2discrimination8 =. if _2discrimination8 >2
}
else {

}
capture confirm numeric v _2enthusiastic
if !_rc {
replace _2enthusiastic =. if _2enthusiastic >6
}
else {

}
capture confirm numeric v snentrustbusinessliving
if !_rc {
replace snentrustbusinessliving =. if snentrustbusinessliving >6
}
else {

}
capture confirm numeric v curious
if !_rc {
replace curious =. if curious >6
}
else {

}
capture confirm numeric v A11
if !_rc {
replace A11 =. if A11 >7
}
else {

}
capture confirm numeric v workexposure4
if !_rc {
replace workexposure4 =. if workexposure4 >5
}
else {

}
capture confirm numeric v _3previousjobcontract
if !_rc {
replace _3previousjobcontract =. if _3previousjobcontract >2
}
else {

}
capture confirm numeric v problemwork1
if !_rc {
replace problemwork1 =66 if problemwork1 ==4
}
else {

}
capture confirm numeric v _3expressingthoughts
if !_rc {
replace _3expressingthoughts =. if _3expressingthoughts >6
}
else {

}
capture confirm numeric v snfindsupplierslabourrelation
if !_rc {
replace snfindsupplierslabourrelation =. if snfindsupplierslabourrelation >2
}
else {

}
capture confirm numeric v _2dummyaspirationmorehours
if !_rc {
replace _2dummyaspirationmorehours =. if _2dummyaspirationmorehours >3
}
else {

}
capture confirm numeric v _3snrecojobsuccessintimacy
if !_rc {
replace _3snrecojobsuccessintimacy =. if _3snrecojobsuccessintimacy >3
}
else {

}
capture confirm numeric v _3wagejobpaymentinkindlist
if !_rc {
replace _3wagejobpaymentinkindlist =. if _3wagejobpaymentinkindlist >6
}
else {

}
capture confirm numeric v _3Ab4
if !_rc {
replace _3Ab4 =. if _3Ab4 >7
}
else {

}
capture confirm numeric v _3workexposure4
if !_rc {
replace _3workexposure4 =. if _3workexposure4 >5
}
else {

}
capture confirm numeric v _2toleratefaults
if !_rc {
replace _2toleratefaults =. if _2toleratefaults >6
}
else {

}
capture confirm numeric v _3snentrustbusinessfriend
if !_rc {
replace _3snentrustbusinessfriend =. if _3snentrustbusinessfriend >2
}
else {

}
capture confirm numeric v _3readystartjob
if !_rc {
replace _3readystartjob =. if _3readystartjob >2
}
else {

}
capture confirm numeric v _3dummyassohelpbusiness
if !_rc {
replace _3dummyassohelpbusiness =. if _3dummyassohelpbusiness >2
}
else {

}
capture confirm numeric v snrecommendforjobsex
if !_rc {
replace snrecommendforjobsex =. if snrecommendforjobsex >2
}
else {

}
capture confirm numeric v _3businesspaymentinkindlist
if !_rc {
replace _3businesspaymentinkindlist =. if _3businesspaymentinkindlist >6
}
else {

}
capture confirm numeric v workexposure2
if !_rc {
replace workexposure2 =. if workexposure2 >5
}
else {

}
capture confirm numeric v _3snfindsuppliersdummyfam
if !_rc {
replace _3snfindsuppliersdummyfam =. if _3snfindsuppliersdummyfam >2
}
else {

}
capture confirm numeric v _3B11
if !_rc {
replace _3B11 =. if _3B11 >7
}
else {

}
capture confirm numeric v _2snrecommendassomeetfrequency
if !_rc {
replace _2snrecommendassomeetfrequency =. if _2snrecommendassomeetfrequency >6
}
else {

}
capture confirm numeric v _2lackskill
if !_rc {
replace _2lackskill =. if _2lackskill >2
}
else {

}
capture confirm numeric v snrecommendforjobreciprocity1
if !_rc {
replace snrecommendforjobreciprocity1 =. if snrecommendforjobreciprocity1 >2
}
else {

}
capture confirm numeric v _2managestress
if !_rc {
replace _2managestress =. if _2managestress >6
}
else {

}
capture confirm numeric v understandotherfeeling
if !_rc {
replace understandotherfeeling =. if understandotherfeeling >6
}
else {

}
capture confirm numeric v _3canreadcard2
if !_rc {
replace _3canreadcard2 =99 if _3canreadcard2 ==4
}
else {

}
capture confirm numeric v _3snfindjoblabourtype
if !_rc {
replace _3snfindjoblabourtype =. if _3snfindjoblabourtype >4
}
else {

}
capture confirm numeric v snentrustbusinessdummyhh
if !_rc {
replace snentrustbusinessdummyhh =. if snentrustbusinessdummyhh >2
}
else {

}
capture confirm numeric v _2businesslossinvest
if !_rc {
replace _2businesslossinvest =99 if _2businesslossinvest ==3
}
else {

}
capture confirm numeric v _3sntalkthemostdistrict
if !_rc {
replace _3sntalkthemostdistrict =. if _3sntalkthemostdistrict >37
}
else {

}
capture confirm numeric v snrecommendassodummyhh
if !_rc {
replace snrecommendassodummyhh =. if snrecommendassodummyhh >2
}
else {

}
capture confirm numeric v _3snrecojobsuccessinvite
if !_rc {
replace _3snrecojobsuccessinvite =. if _3snrecojobsuccessinvite >2
}
else {

}
capture confirm numeric v _2snrecommendassoage
if !_rc {
replace _2snrecommendassoage =. if _2snrecommendassoage >6
}
else {

}
capture confirm numeric v sharefeelings
if !_rc {
replace sharefeelings =. if sharefeelings >6
}
else {

}
capture confirm numeric v remsentdummyvillage
if !_rc {
replace remsentdummyvillage =. if remsentdummyvillage >2
}
else {

}
capture confirm numeric v changework
if !_rc {
replace changework =. if changework >2
}
else {

}
capture confirm numeric v _2snfindjobinvite
if !_rc {
replace _2snfindjobinvite =. if _2snfindjobinvite >2
}
else {

}
capture confirm numeric v enjoypeople
if !_rc {
replace enjoypeople =. if enjoypeople >6
}
else {

}
capture confirm numeric v _3dummypreviouswagejob
if !_rc {
replace _3dummypreviouswagejob =. if _3dummypreviouswagejob >2
}
else {

}
capture confirm numeric v dummyrecommendrefuse
if !_rc {
replace dummyrecommendrefuse =. if dummyrecommendrefuse >2
}
else {

}
capture confirm numeric v _2sntalkthemostcompared
if !_rc {
replace _2sntalkthemostcompared =. if _2sntalkthemostcompared >3
}
else {

}
capture confirm numeric v happywork
if !_rc {
replace happywork =. if happywork >4
}
else {

}
capture confirm numeric v _3sncloserelouthhcastes
if !_rc {
replace _3sncloserelouthhcastes =. if _3sncloserelouthhcastes >17
}
else {

}
capture confirm numeric v dummycreditcard
if !_rc {
replace dummycreditcard =. if dummycreditcard >2
}
else {

}
capture confirm numeric v snhelpemergencycompared
if !_rc {
replace snhelpemergencycompared =. if snhelpemergencycompared >3
}
else {

}
capture confirm numeric v _3invitebusinesslender
if !_rc {
replace _3invitebusinesslender =. if _3invitebusinesslender >2
}
else {

}
capture confirm numeric v _3meetfrequemcybusinesslender
if !_rc {
replace _3meetfrequemcybusinesslender =. if _3meetfrequemcybusinesslender >6
}
else {

}
capture confirm numeric v discrimination7
if !_rc {
replace discrimination7 =. if discrimination7 >2
}
else {

}
capture confirm numeric v canread
if !_rc {
replace canread =. if canread >2
}
else {

}
capture confirm numeric v dummyassohelpbusiness
if !_rc {
replace dummyassohelpbusiness =. if dummyassohelpbusiness >2
}
else {

}
capture confirm numeric v dummyguarantor
if !_rc {
replace dummyguarantor =. if dummyguarantor >2
}
else {

}
capture confirm numeric v _2executionwork3
if !_rc {
replace _2executionwork3 =. if _2executionwork3 >2
}
else {

}
capture confirm numeric v snfindsupplierslabourtype
if !_rc {
replace snfindsupplierslabourtype =. if snfindsupplierslabourtype >4
}
else {

}
capture confirm numeric v _3snfindjobdummyfam
if !_rc {
replace _3snfindjobdummyfam =. if _3snfindjobdummyfam >2
}
else {

}
capture confirm numeric v _2businessnbpaidworkers
if !_rc {
replace _2businessnbpaidworkers =. if _2businessnbpaidworkers >16
}
else {

}
capture confirm numeric v salariedjobtype
if !_rc {
replace salariedjobtype =. if salariedjobtype >4
}
else {

}
capture confirm numeric v _3snfindcurrentjobwkp
if !_rc {
replace _3snfindcurrentjobwkp =. if _3snfindcurrentjobwkp >2
}
else {

}
capture confirm numeric v _2problemwork9
if !_rc {
replace _2problemwork9 =66 if _2problemwork9 ==4
}
else {

}
capture confirm numeric v _3canreadcard1a
if !_rc {
replace _3canreadcard1a =99 if _3canreadcard1a ==4
}
else {

}
capture confirm numeric v _3snfindsuppliersfriend
if !_rc {
replace _3snfindsuppliersfriend =. if _3snfindsuppliersfriend >2
}
else {

}
capture confirm numeric v snrecruitworkerdummyfam
if !_rc {
replace snrecruitworkerdummyfam =. if snrecruitworkerdummyfam >2
}
else {

}
capture confirm numeric v snentrustbusinesslabourrelation
if !_rc {
replace snentrustbusinesslabourrelation =. if snentrustbusinesslabourrelation >2
}
else {

}
capture confirm numeric v _2wagejobtype
if !_rc {
replace _2wagejobtype =. if _2wagejobtype >4
}
else {

}
capture confirm numeric v _3snfindsupplierslabourrelation
if !_rc {
replace _3snfindsupplierslabourrelation =. if _3snfindsupplierslabourrelation >2
}
else {

}
capture confirm numeric v searchjob
if !_rc {
replace searchjob =. if searchjob >2
}
else {

}
capture confirm numeric v _3snrecommendforjobinvite
if !_rc {
replace _3snrecommendforjobinvite =. if _3snrecommendforjobinvite >2
}
else {

}
capture confirm numeric v _2snrecommendassodummyhh
if !_rc {
replace _2snrecommendassodummyhh =. if _2snrecommendassodummyhh >2
}
else {

}
capture confirm numeric v reservationemployment
if !_rc {
replace reservationemployment =. if reservationemployment >2
}
else {

}
capture confirm numeric v _2snfindjobdummyfam
if !_rc {
replace _2snfindjobdummyfam =. if _2snfindjobdummyfam >2
}
else {

}
capture confirm numeric v snfindsuppliersdummyhh
if !_rc {
replace snfindsuppliersdummyhh =. if snfindsuppliersdummyhh >2
}
else {

}
capture confirm numeric v _2snrecommendforjob
if !_rc {
replace _2snrecommendforjob =. if _2snrecommendforjob >3
}
else {

}
capture confirm numeric v _3problemwork8
if !_rc {
replace _3problemwork8 =66 if _3problemwork8 ==4
}
else {

}
capture confirm numeric v businessskill
if !_rc {
replace businessskill =. if businessskill >4
}
else {

}
capture confirm numeric v executionwork5
if !_rc {
replace executionwork5 =. if executionwork5 >2
}
else {

}
capture confirm numeric v _2sntalkthemostwkp
if !_rc {
replace _2sntalkthemostwkp =. if _2sntalkthemostwkp >2
}
else {

}
capture confirm numeric v _3snrecojobsuccessemployertype
if !_rc {
replace _3snrecojobsuccessemployertype =. if _3snrecojobsuccessemployertype >8
}
else {

}
capture confirm numeric v _3searchjobsince15
if !_rc {
replace _3searchjobsince15 =. if _3searchjobsince15 >2
}
else {

}
capture confirm numeric v networkhelpkinmember
if !_rc {
replace networkhelpkinmember =. if networkhelpkinmember >6
}
else {

}
capture confirm numeric v snrecruitworker
if !_rc {
replace snrecruitworker =. if snrecruitworker >3
}
else {

}
capture confirm numeric v _2goaftergoal
if !_rc {
replace _2goaftergoal =. if _2goaftergoal >6
}
else {

}
capture confirm numeric v _3snfindsuppliers
if !_rc {
replace _3snfindsuppliers =. if _3snfindsuppliers >3
}
else {

}
capture confirm numeric v _2worryalot
if !_rc {
replace _2worryalot =. if _2worryalot >6
}
else {

}
capture confirm numeric v _2Ab11
if !_rc {
replace _2Ab11 =. if _2Ab11 >7
}
else {

}
capture confirm numeric v _2sncloserelouthhmeet
if !_rc {
replace _2sncloserelouthhmeet =77 if _2sncloserelouthhmeet ==7
}
else {

}
capture confirm numeric v dummychitfund
if !_rc {
replace dummychitfund =. if dummychitfund >2
}
else {

}
capture confirm numeric v _3ego2random_2
if !_rc {
replace _3ego2random_2 =. if _3ego2random_2 >2
}
else {

}
capture confirm numeric v _3snhelpemergencysex
if !_rc {
replace _3snhelpemergencysex =. if _3snhelpemergencysex >2
}
else {

}
capture confirm numeric v _3sntalkthemostlabourtype
if !_rc {
replace _3sntalkthemostlabourtype =. if _3sntalkthemostlabourtype >4
}
else {

}
capture confirm numeric v dummyworkedpastyear
if !_rc {
replace dummyworkedpastyear =. if dummyworkedpastyear >2
}
else {

}
capture confirm numeric v covlending
if !_rc {
replace covlending =. if covlending >3
}
else {

}
capture confirm numeric v _2snrecojobsuccesseduc
if !_rc {
replace _2snrecojobsuccesseduc =. if _2snrecojobsuccesseduc >7
}
else {

}
capture confirm numeric v snhelpemergencydummyhh
if !_rc {
replace snhelpemergencydummyhh =. if snhelpemergencydummyhh >2
}
else {

}
capture confirm numeric v _2A1
if !_rc {
replace _2A1 =. if _2A1 >7
}
else {

}
capture confirm numeric v _2snfindcurrentjobruralurban
if !_rc {
replace _2snfindcurrentjobruralurban =. if _2snfindcurrentjobruralurban >2
}
else {

}
capture confirm numeric v loanreasongiven2
if !_rc {
replace loanreasongiven2 =77 if loanreasongiven2 ==13
}
else {

}
capture confirm numeric v husbandwifecaste
if !_rc {
replace husbandwifecaste =. if husbandwifecaste >17
}
else {

}
capture confirm numeric v _3snfindjobinvite
if !_rc {
replace _3snfindjobinvite =. if _3snfindjobinvite >2
}
else {

}
capture confirm numeric v _3reasondontsearchjob
if !_rc {
replace _3reasondontsearchjob =. if _3reasondontsearchjob >15
}
else {

}
capture confirm numeric v _2sntalkthemostlabourrelation
if !_rc {
replace _2sntalkthemostlabourrelation =. if _2sntalkthemostlabourrelation >2
}
else {

}
capture confirm numeric v _2Ab10
if !_rc {
replace _2Ab10 =. if _2Ab10 >7
}
else {

}
capture confirm numeric v _3jobpreference
if !_rc {
replace _3jobpreference =. if _3jobpreference >4
}
else {

}
capture confirm numeric v _3trustingofother
if !_rc {
replace _3trustingofother =. if _3trustingofother >6
}
else {

}
capture confirm numeric v _2snrecommendassodistrict
if !_rc {
replace _2snrecommendassodistrict =. if _2snrecommendassodistrict >37
}
else {

}
capture confirm numeric v snhelpemergencylabourtype
if !_rc {
replace snhelpemergencylabourtype =. if snhelpemergencylabourtype >4
}
else {

}
capture confirm numeric v snhelpemergencydummyfam
if !_rc {
replace snhelpemergencydummyfam =. if snhelpemergencydummyfam >2
}
else {

}
capture confirm numeric v reasondropping
if !_rc {
replace reasondropping =. if reasondropping >15
}
else {

}
capture confirm numeric v rudetoother
if !_rc {
replace rudetoother =. if rudetoother >6
}
else {

}
capture confirm numeric v _2snfindsupplierssex
if !_rc {
replace _2snfindsupplierssex =. if _2snfindsupplierssex >2
}
else {

}
capture confirm numeric v _2sntalkthemostinvite
if !_rc {
replace _2sntalkthemostinvite =. if _2sntalkthemostinvite >2
}
else {

}
capture confirm numeric v _3snfindsuppliersage
if !_rc {
replace _3snfindsuppliersage =. if _3snfindsuppliersage >6
}
else {

}
capture confirm numeric v _2snrecommendforjoblabourrelation
if !_rc {
replace _2snrecommendforjoblabourrelation =. if _2snrecommendforjoblabourrelation >2
}
else {

}
capture confirm numeric v _3assohelpbusiness
if !_rc {
replace _3assohelpbusiness =. if _3assohelpbusiness >8
}
else {

}
capture confirm numeric v _3snhelpemergencylabourtype
if !_rc {
replace _3snhelpemergencylabourtype =. if _3snhelpemergencylabourtype >4
}
else {

}
capture confirm numeric v _2workexposure4
if !_rc {
replace _2workexposure4 =. if _2workexposure4 >5
}
else {

}
capture confirm numeric v _2repetitivetasks
if !_rc {
replace _2repetitivetasks =. if _2repetitivetasks >6
}
else {

}
capture confirm numeric v _2businesspaymentinkind
if !_rc {
replace _2businesspaymentinkind =. if _2businesspaymentinkind >2
}
else {

}
capture confirm numeric v _3snentrustbusinessdummyhh
if !_rc {
replace _3snentrustbusinessdummyhh =. if _3snentrustbusinessdummyhh >2
}
else {

}
capture confirm numeric v _3snrecommendassoliving
if !_rc {
replace _3snrecommendassoliving =. if _3snrecommendassoliving >6
}
else {

}
capture confirm numeric v _3snrecommendassoreciprocity1
if !_rc {
replace _3snrecommendassoreciprocity1 =. if _3snrecommendassoreciprocity1 >2
}
else {

}
capture confirm numeric v loanproductpledge
if !_rc {
replace loanproductpledge =. if loanproductpledge >16
}
else {

}
capture confirm numeric v _3executionwork9
if !_rc {
replace _3executionwork9 =. if _3executionwork9 >2
}
else {

}
capture confirm numeric v covworkeffort
if !_rc {
replace covworkeffort =. if covworkeffort >6
}
else {

}
capture confirm numeric v _2stickwithgoals
if !_rc {
replace _2stickwithgoals =. if _2stickwithgoals >6
}
else {

}
capture confirm numeric v _2snhelpemergencywkp
if !_rc {
replace _2snhelpemergencywkp =. if _2snhelpemergencywkp >2
}
else {

}
capture confirm numeric v relationshiptohead
if !_rc {
replace relationshiptohead =. if relationshiptohead >18
}
else {

}
capture confirm numeric v subjectsafter10th
if !_rc {
replace subjectsafter10th =. if subjectsafter10th >8
}
else {

}
capture confirm numeric v _2sntalkthemostruralurban
if !_rc {
replace _2sntalkthemostruralurban =. if _2sntalkthemostruralurban >2
}
else {

}
capture confirm numeric v freehousescheme
if !_rc {
replace freehousescheme =. if freehousescheme >3
}
else {

}
capture confirm numeric v sntalkthemostemployertype
if !_rc {
replace sntalkthemostemployertype =. if sntalkthemostemployertype >8
}
else {

}
capture confirm numeric v _2assosize
if !_rc {
replace _2assosize =. if _2assosize >5
}
else {

}
capture confirm numeric v businessnbunpaidworkers
if !_rc {
replace businessnbunpaidworkers =. if businessnbunpaidworkers >16
}
else {

}
capture confirm numeric v workpastsixmonth
if !_rc {
replace workpastsixmonth =. if workpastsixmonth >2
}
else {

}
capture confirm numeric v _2reasondontsearchjob
if !_rc {
replace _2reasondontsearchjob =. if _2reasondontsearchjob >15
}
else {

}
capture confirm numeric v staycalm
if !_rc {
replace staycalm =. if staycalm >6
}
else {

}
capture confirm numeric v _3snrecommendassolabourrelation
if !_rc {
replace _3snrecommendassolabourrelation =. if _3snrecommendassolabourrelation >2
}
else {

}
capture confirm numeric v _2covinstit5
if !_rc {
replace _2covinstit5 =. if _2covinstit5 >4
}
else {

}
capture confirm numeric v _2wagejobsocialsecurity
if !_rc {
replace _2wagejobsocialsecurity =. if _2wagejobsocialsecurity >2
}
else {

}
capture confirm numeric v _3opinionactivewoman
if !_rc {
replace _3opinionactivewoman =. if _3opinionactivewoman >4
}
else {

}
capture confirm numeric v _2sncloserelouthhinvite
if !_rc {
replace _2sncloserelouthhinvite =. if _2sncloserelouthhinvite >2
}
else {

}
capture confirm numeric v snfindsuppliersliving
if !_rc {
replace snfindsuppliersliving =. if snfindsuppliersliving >6
}
else {

}
capture confirm numeric v opinionworkingwoman
if !_rc {
replace opinionworkingwoman =. if opinionworkingwoman >4
}
else {

}
capture confirm numeric v _2break
if !_rc {
replace _2break =. if _2break >2
}
else {

}
capture confirm numeric v _3B2
if !_rc {
replace _3B2 =. if _3B2 >7
}
else {

}
capture confirm numeric v _2snrecommendassodummyfam
if !_rc {
replace _2snrecommendassodummyfam =. if _2snrecommendassodummyfam >2
}
else {

}
capture confirm numeric v retirementwork
if !_rc {
replace retirementwork =. if retirementwork >2
}
else {

}
capture confirm numeric v _3executionwork8
if !_rc {
replace _3executionwork8 =. if _3executionwork8 >2
}
else {

}
capture confirm numeric v _3workwithother
if !_rc {
replace _3workwithother =. if _3workwithother >6
}
else {

}
capture confirm numeric v _2snrecojobsuccessdummyfam
if !_rc {
replace _2snrecojobsuccessdummyfam =. if _2snrecojobsuccessdummyfam >2
}
else {

}
capture confirm numeric v _2dummycontactleaders
if !_rc {
replace _2dummycontactleaders =. if _2dummycontactleaders >2
}
else {

}
capture confirm numeric v B2
if !_rc {
replace B2 =. if B2 >7
}
else {

}
capture confirm numeric v _3snrecommendforjobruralurban
if !_rc {
replace _3snrecommendforjobruralurban =. if _3snrecommendforjobruralurban >2
}
else {

}
capture confirm numeric v educbusinesslender
if !_rc {
replace educbusinesslender =. if educbusinesslender >7
}
else {

}
capture confirm numeric v _3executionwork7
if !_rc {
replace _3executionwork7 =. if _3executionwork7 >2
}
else {

}
capture confirm numeric v physicalharm
if !_rc {
replace physicalharm =66 if physicalharm ==5
}
else {

}
capture confirm numeric v _3methodfindfirstjob
if !_rc {
replace _3methodfindfirstjob =66 if _3methodfindfirstjob ==10
}
else {

}
capture confirm numeric v _3discrimination9
if !_rc {
replace _3discrimination9 =. if _3discrimination9 >2
}
else {

}
capture confirm numeric v businesslabourerinsurance
if !_rc {
replace businesslabourerinsurance =. if businesslabourerinsurance >2
}
else {

}
capture confirm numeric v _2wagejobpaymentinkind
if !_rc {
replace _2wagejobpaymentinkind =. if _2wagejobpaymentinkind >2
}
else {

}
capture confirm numeric v _3jobfirstwagefrequencycash
if !_rc {
replace _3jobfirstwagefrequencycash =. if _3jobfirstwagefrequencycash >4
}
else {

}
capture confirm numeric v sncloserelouthhliving
if !_rc {
replace sncloserelouthhliving =. if sncloserelouthhliving >6
}
else {

}
capture confirm numeric v _2snfindcurrentjobinvite
if !_rc {
replace _2snfindcurrentjobinvite =. if _2snfindcurrentjobinvite >2
}
else {

}
capture confirm numeric v _2snentrustbusinessemployertype
if !_rc {
replace _2snentrustbusinessemployertype =. if _2snentrustbusinessemployertype >8
}
else {

}
capture confirm numeric v _2snfindsuppliersreciprocity1
if !_rc {
replace _2snfindsuppliersreciprocity1 =. if _2snfindsuppliersreciprocity1 >2
}
else {

}
capture confirm numeric v _2snentrustbusinessfriend
if !_rc {
replace _2snentrustbusinessfriend =. if _2snentrustbusinessfriend >2
}
else {

}
capture confirm numeric v _2snentrustbusinesswkp
if !_rc {
replace _2snentrustbusinesswkp =. if _2snentrustbusinesswkp >2
}
else {

}
capture confirm numeric v Ab12
if !_rc {
replace Ab12 =. if Ab12 >7
}
else {

}
capture confirm numeric v _2Ab5
if !_rc {
replace _2Ab5 =. if _2Ab5 >7
}
else {

}
capture confirm numeric v assohelpbusiness
if !_rc {
replace assohelpbusiness =. if assohelpbusiness >8
}
else {

}
capture confirm numeric v _2snfindjobeduc
if !_rc {
replace _2snfindjobeduc =. if _2snfindjobeduc >7
}
else {

}
capture confirm numeric v _3snhelpemergencywkp
if !_rc {
replace _3snhelpemergencywkp =. if _3snhelpemergencywkp >2
}
else {

}
capture confirm numeric v _2forgiveother
if !_rc {
replace _2forgiveother =. if _2forgiveother >6
}
else {

}
capture confirm numeric v lendersex
if !_rc {
replace lendersex =. if lendersex >3
}
else {

}
capture confirm numeric v _2newideas
if !_rc {
replace _2newideas =. if _2newideas >6
}
else {

}
capture confirm numeric v _2snrecruitworkerdummyhh
if !_rc {
replace _2snrecruitworkerdummyhh =. if _2snrecruitworkerdummyhh >2
}
else {

}
capture confirm numeric v _2reasonstoppedwagejob
if !_rc {
replace _2reasonstoppedwagejob =. if _2reasonstoppedwagejob >13
}
else {

}
capture confirm numeric v snfindjobreciprocity1
if !_rc {
replace snfindjobreciprocity1 =. if snfindjobreciprocity1 >2
}
else {

}
capture confirm numeric v _2educbusinesslender
if !_rc {
replace _2educbusinesslender =. if _2educbusinesslender >7
}
else {

}
capture confirm numeric v _2snfindjobcastes
if !_rc {
replace _2snfindjobcastes =. if _2snfindjobcastes >17
}
else {

}
capture confirm numeric v _3snrecojobsuccesswkp
if !_rc {
replace _3snrecojobsuccesswkp =. if _3snrecojobsuccesswkp >2
}
else {

}
capture confirm numeric v covinstit4
if !_rc {
replace covinstit4 =. if covinstit4 >4
}
else {

}
capture confirm numeric v lenderfromgold
if !_rc {
replace lenderfromgold =66 if lenderfromgold ==3
}
else {

}
capture confirm numeric v _2locuscontrol2
if !_rc {
replace _2locuscontrol2 =. if _2locuscontrol2 >5
}
else {

}
capture confirm numeric v _3covworkeffort
if !_rc {
replace _3covworkeffort =. if _3covworkeffort >6
}
else {

}
capture confirm numeric v _2sncloserelouthhdummyfam
if !_rc {
replace _2sncloserelouthhdummyfam =. if _2sncloserelouthhdummyfam >2
}
else {

}
capture confirm numeric v _2activeimagination
if !_rc {
replace _2activeimagination =. if _2activeimagination >6
}
else {

}
capture confirm numeric v snfindsuppliersmeetfrequency
if !_rc {
replace snfindsuppliersmeetfrequency =. if snfindsuppliersmeetfrequency >6
}
else {

}
capture confirm numeric v _2previousjobcontract
if !_rc {
replace _2previousjobcontract =. if _2previousjobcontract >2
}
else {

}
capture confirm numeric v _2canreadcard1a
if !_rc {
replace _2canreadcard1a =99 if _2canreadcard1a ==4
}
else {

}
capture confirm numeric v _3covinstit6
if !_rc {
replace _3covinstit6 =. if _3covinstit6 >3
}
else {

}
capture confirm numeric v _2snhelpemergencyruralurban
if !_rc {
replace _2snhelpemergencyruralurban =. if _2snhelpemergencyruralurban >2
}
else {

}
capture confirm numeric v snrecruitworkerlabourtype
if !_rc {
replace snrecruitworkerlabourtype =. if snrecruitworkerlabourtype >4
}
else {

}
capture confirm numeric v _2snentrustbusinessruralurban
if !_rc {
replace _2snentrustbusinessruralurban =. if _2snentrustbusinessruralurban >2
}
else {

}
capture confirm numeric v _2putoffduties
if !_rc {
replace _2putoffduties =. if _2putoffduties >6
}
else {

}
capture confirm numeric v _3snfindsupplierscastes
if !_rc {
replace _3snfindsupplierscastes =. if _3snfindsupplierscastes >17
}
else {

}
capture confirm numeric v _2snfindcurrentjoblabourrelation
if !_rc {
replace _2snfindcurrentjoblabourrelation =. if _2snfindcurrentjoblabourrelation >2
}
else {

}
capture confirm numeric v wagejobtype
if !_rc {
replace wagejobtype =. if wagejobtype >4
}
else {

}
capture confirm numeric v _3snrecommendforjobfriend
if !_rc {
replace _3snrecommendforjobfriend =. if _3snrecommendforjobfriend >2
}
else {

}
capture confirm numeric v _2snfindjobmeet
if !_rc {
replace _2snfindjobmeet =77 if _2snfindjobmeet ==7
}
else {

}
capture confirm numeric v snentrustbusinessmeet
if !_rc {
replace snentrustbusinessmeet =77 if snentrustbusinessmeet ==7
}
else {

}
capture confirm numeric v _3sntalkthemostsex
if !_rc {
replace _3sntalkthemostsex =. if _3sntalkthemostsex >2
}
else {

}
capture confirm numeric v subjectsafter10th
if !_rc {
replace subjectsafter10th =77 if subjectsafter10th ==8
}
else {

}
capture confirm numeric v sncloserelouthhdistrict
if !_rc {
replace sncloserelouthhdistrict =. if sncloserelouthhdistrict >37
}
else {

}
capture confirm numeric v _2agreementatwork2
if !_rc {
replace _2agreementatwork2 =. if _2agreementatwork2 >4
}
else {

}
capture confirm numeric v _3networktrustemployees
if !_rc {
replace _3networktrustemployees =. if _3networktrustemployees >6
}
else {

}
capture confirm numeric v _2sexualaggression
if !_rc {
replace _2sexualaggression =. if _2sexualaggression >5
}
else {

}
capture confirm numeric v _3sncloserelouthhwkp
if !_rc {
replace _3sncloserelouthhwkp =. if _3sncloserelouthhwkp >2
}
else {

}
capture confirm numeric v _2sexbusinesslender
if !_rc {
replace _2sexbusinesslender =. if _2sexbusinesslender >2
}
else {

}
capture confirm numeric v snfindcurrentjobdistrict
if !_rc {
replace snfindcurrentjobdistrict =. if snfindcurrentjobdistrict >37
}
else {

}
capture confirm numeric v _3covdifficulties
if !_rc {
replace _3covdifficulties =. if _3covdifficulties >10
}
else {

}
capture confirm numeric v snrecommendforjob
if !_rc {
replace snrecommendforjob =. if snrecommendforjob >3
}
else {

}
capture confirm numeric v snfindsupplierssex
if !_rc {
replace snfindsupplierssex =. if snfindsupplierssex >2
}
else {

}
capture confirm numeric v numeracy4
if !_rc {
replace numeracy4 =. if numeracy4 >3
}
else {

}
capture confirm numeric v snhelpemergencysex
if !_rc {
replace snhelpemergencysex =. if snhelpemergencysex >2
}
else {

}
capture confirm numeric v dummybacktovillage
if !_rc {
replace dummybacktovillage =. if dummybacktovillage >2
}
else {

}
capture confirm numeric v _3snfindjobsex
if !_rc {
replace _3snfindjobsex =. if _3snfindjobsex >2
}
else {

}
capture confirm numeric v problemwork2
if !_rc {
replace problemwork2 =. if problemwork2 >5
}
else {

}
capture confirm numeric v snrecruitworkerlabourrelation
if !_rc {
replace snrecruitworkerlabourrelation =. if snrecruitworkerlabourrelation >2
}
else {

}
capture confirm numeric v _2jobfirstwagefrequencycash
if !_rc {
replace _2jobfirstwagefrequencycash =. if _2jobfirstwagefrequencycash >4
}
else {

}
capture confirm numeric v A6
if !_rc {
replace A6 =. if A6 >7
}
else {

}
capture confirm numeric v tryhard
if !_rc {
replace tryhard =. if tryhard >6
}
else {

}
capture confirm numeric v _3covinstit4
if !_rc {
replace _3covinstit4 =. if _3covinstit4 >4
}
else {

}
capture confirm numeric v snrecommendassosex
if !_rc {
replace snrecommendassosex =. if snrecommendassosex >2
}
else {

}
capture confirm numeric v agreementatwork3
if !_rc {
replace agreementatwork3 =. if agreementatwork3 >4
}
else {

}
capture confirm numeric v snrecommendassolabourrelation
if !_rc {
replace snrecommendassolabourrelation =. if snrecommendassolabourrelation >2
}
else {

}
capture confirm numeric v _3sntalkthemostlabourrelation
if !_rc {
replace _3sntalkthemostlabourrelation =. if _3sntalkthemostlabourrelation >2
}
else {

}
capture confirm numeric v A7
if !_rc {
replace A7 =. if A7 >7
}
else {

}
capture confirm numeric v _2snfindsuppliersdummyhh
if !_rc {
replace _2snfindsuppliersdummyhh =. if _2snfindsuppliersdummyhh >2
}
else {

}
capture confirm numeric v loanreasongiven
if !_rc {
replace loanreasongiven =. if loanreasongiven >13
}
else {

}
capture confirm numeric v _2snfindcurrentjobdistrict
if !_rc {
replace _2snfindcurrentjobdistrict =. if _2snfindcurrentjobdistrict >37
}
else {

}
capture confirm numeric v _2snrecommendassocastes
if !_rc {
replace _2snrecommendassocastes =. if _2snrecommendassocastes >17
}
else {

}
capture confirm numeric v dummyadvance
if !_rc {
replace dummyadvance =. if dummyadvance >2
}
else {

}
capture confirm numeric v _3snrecommendassodummyhh
if !_rc {
replace _3snrecommendassodummyhh =. if _3snrecommendassodummyhh >2
}
else {

}
capture confirm numeric v _2snentrustbusinesscompared
if !_rc {
replace _2snentrustbusinesscompared =. if _2snentrustbusinesscompared >3
}
else {

}
capture confirm numeric v locuscontrol1
if !_rc {
replace locuscontrol1 =. if locuscontrol1 >5
}
else {

}
capture confirm numeric v _2sncloserelouthhcompared
if !_rc {
replace _2sncloserelouthhcompared =. if _2sncloserelouthhcompared >3
}
else {

}
capture confirm numeric v dummyloans
if !_rc {
replace dummyloans =. if dummyloans >2
}
else {

}
capture confirm numeric v _2businesssocialsecurity
if !_rc {
replace _2businesssocialsecurity =. if _2businesssocialsecurity >2
}
else {

}
capture confirm numeric v _2discrimination5
if !_rc {
replace _2discrimination5 =. if _2discrimination5 >2
}
else {

}
capture confirm numeric v sex_new
if !_rc {
replace sex_new =. if sex_new >2
}
else {

}
capture confirm numeric v _2snfindsupplierscastes
if !_rc {
replace _2snfindsupplierscastes =. if _2snfindsupplierscastes >17
}
else {

}
capture confirm numeric v businesspaymentinkindlist
if !_rc {
replace businesspaymentinkindlist =. if businesspaymentinkindlist >6
}
else {

}
capture confirm numeric v _2snrecruitworkersex
if !_rc {
replace _2snrecruitworkersex =. if _2snrecruitworkersex >2
}
else {

}
capture confirm numeric v businesssocialsecurity
if !_rc {
replace businesssocialsecurity =. if businesssocialsecurity >2
}
else {

}
capture confirm numeric v _2covinstit10
if !_rc {
replace _2covinstit10 =. if _2covinstit10 >3
}
else {

}
capture confirm numeric v wagejobsocialsecurity
if !_rc {
replace wagejobsocialsecurity =. if wagejobsocialsecurity >2
}
else {

}
capture confirm numeric v _2sncloserelouthhemployertype
if !_rc {
replace _2sncloserelouthhemployertype =. if _2sncloserelouthhemployertype >8
}
else {

}
capture confirm numeric v dummyadvancebalance
if !_rc {
replace dummyadvancebalance =. if dummyadvancebalance >2
}
else {

}
capture confirm numeric v easilyupset
if !_rc {
replace easilyupset =. if easilyupset >6
}
else {

}
capture confirm numeric v _3understandotherfeeling
if !_rc {
replace _3understandotherfeeling =. if _3understandotherfeeling >6
}
else {

}
capture confirm numeric v _3snfindcurrentjobreciprocity1
if !_rc {
replace _3snfindcurrentjobreciprocity1 =. if _3snfindcurrentjobreciprocity1 >2
}
else {

}
capture confirm numeric v snfindcurrentjobcompared
if !_rc {
replace snfindcurrentjobcompared =. if snfindcurrentjobcompared >3
}
else {

}
capture confirm numeric v Ab5
if !_rc {
replace Ab5 =. if Ab5 >7
}
else {

}
capture confirm numeric v snhelpemergencyliving
if !_rc {
replace snhelpemergencyliving =. if snhelpemergencyliving >6
}
else {

}
capture confirm numeric v _2jobwagefrequencycash
if !_rc {
replace _2jobwagefrequencycash =. if _2jobwagefrequencycash >4
}
else {

}
capture confirm numeric v _2snfindsuppliers
if !_rc {
replace _2snfindsuppliers =. if _2snfindsuppliers >3
}
else {

}
capture confirm numeric v _3snhelpemergencylabourrelation
if !_rc {
replace _3snhelpemergencylabourrelation =. if _3snhelpemergencylabourrelation >2
}
else {

}
capture confirm numeric v nbercontactphone
if !_rc {
replace nbercontactphone =. if nbercontactphone >7
}
else {

}
capture confirm numeric v borrowerssex
if !_rc {
replace borrowerssex =. if borrowerssex >2
}
else {

}
capture confirm numeric v problemwork5
if !_rc {
replace problemwork5 =66 if problemwork5 ==4
}
else {

}
capture confirm numeric v _2snfindjobliving
if !_rc {
replace _2snfindjobliving =. if _2snfindjobliving >6
}
else {

}
capture confirm numeric v _2easilydistracted
if !_rc {
replace _2easilydistracted =. if _2easilydistracted >6
}
else {

}
capture confirm numeric v dummybusinesslabourerhhmember
if !_rc {
replace dummybusinesslabourerhhmember =. if dummybusinesslabourerhhmember >2
}
else {

}
capture confirm numeric v _2snrecommendforjobmeetfrequency
if !_rc {
replace _2snrecommendforjobmeetfrequency =. if _2snrecommendforjobmeetfrequency >6
}
else {

}
capture confirm numeric v dummylendingmoney
if !_rc {
replace dummylendingmoney =. if dummylendingmoney >2
}
else {

}
capture confirm numeric v satisfyingpurpose
if !_rc {
replace satisfyingpurpose =. if satisfyingpurpose >4
}
else {

}
capture confirm numeric v _3snrecommendassocastes
if !_rc {
replace _3snrecommendassocastes =. if _3snrecommendassocastes >17
}
else {

}
capture confirm numeric v _3numeracy1
if !_rc {
replace _3numeracy1 =. if _3numeracy1 >3
}
else {

}
capture confirm numeric v remsentgift
if !_rc {
replace remsentgift =. if remsentgift >2
}
else {

}
capture confirm numeric v snfindjoblabourtype
if !_rc {
replace snfindjoblabourtype =. if snfindjoblabourtype >4
}
else {

}
capture confirm numeric v _3networktrustneighborhood
if !_rc {
replace _3networktrustneighborhood =. if _3networktrustneighborhood >6
}
else {

}
capture confirm numeric v _3snfindjob
if !_rc {
replace _3snfindjob =. if _3snfindjob >3
}
else {

}
capture confirm numeric v _2snrecruitworkerruralurban
if !_rc {
replace _2snrecruitworkerruralurban =. if _2snrecruitworkerruralurban >2
}
else {

}
capture confirm numeric v _3frequencygrossreceipt
if !_rc {
replace _3frequencygrossreceipt =. if _3frequencygrossreceipt >6
}
else {

}
capture confirm numeric v marriagespousefamily
if !_rc {
replace marriagespousefamily  =. if marriagespousefamily  >3
}
else {

}
capture confirm numeric v _2executionwork8
if !_rc {
replace _2executionwork8 =. if _2executionwork8 >2
}
else {

}
capture confirm numeric v snfindcurrentjobfriend
if !_rc {
replace snfindcurrentjobfriend =. if snfindcurrentjobfriend >2
}
else {

}
capture confirm numeric v _3snentrustbusinessinvite
if !_rc {
replace _3snentrustbusinessinvite =. if _3snentrustbusinessinvite >2
}
else {

}
capture confirm numeric v snfindjobdistrict
if !_rc {
replace snfindjobdistrict =. if snfindjobdistrict >37
}
else {

}
capture confirm numeric v _3snfindcurrentjobcastes
if !_rc {
replace _3snfindcurrentjobcastes =. if _3snfindcurrentjobcastes >17
}
else {

}
capture confirm numeric v _2snrecruitworkerlabourtype
if !_rc {
replace _2snrecruitworkerlabourtype =. if _2snrecruitworkerlabourtype >4
}
else {

}
capture confirm numeric v _2numeracy2
if !_rc {
replace _2numeracy2 =. if _2numeracy2 >3
}
else {

}
capture confirm numeric v ego2random_1
if !_rc {
replace ego2random_1 =. if ego2random_1 >2
}
else {

}
capture confirm numeric v _3reasondontsearchjobsince15
if !_rc {
replace _3reasondontsearchjobsince15 =. if _3reasondontsearchjobsince15 >15
}
else {

}
capture confirm numeric v livingbusinesslender
if !_rc {
replace livingbusinesslender =. if livingbusinesslender >6
}
else {

}
capture confirm numeric v _3snrecruitworkerliving
if !_rc {
replace _3snrecruitworkerliving =. if _3snrecruitworkerliving >6
}
else {

}
capture confirm numeric v _2startbusiness
if !_rc {
replace _2startbusiness =. if _2startbusiness >2
}
else {

}
capture confirm numeric v B3
if !_rc {
replace B3 =. if B3 >7
}
else {

}
capture confirm numeric v snfindjobruralurban
if !_rc {
replace snfindjobruralurban =. if snfindjobruralurban >2
}
else {

}
capture confirm numeric v _2moveoutsideforjob
if !_rc {
replace _2moveoutsideforjob =. if _2moveoutsideforjob >2
}
else {

}
capture confirm numeric v lenderrelation
if !_rc {
replace lenderrelation =66 if lenderrelation ==12
}
else {

}
capture confirm numeric v _2snrecommendforjobruralurban
if !_rc {
replace _2snrecommendforjobruralurban =. if _2snrecommendforjobruralurban >2
}
else {

}
capture confirm numeric v sncloserelouthhruralurban
if !_rc {
replace sncloserelouthhruralurban =. if sncloserelouthhruralurban >2
}
else {

}
capture confirm numeric v _2talktomanypeople
if !_rc {
replace _2talktomanypeople =. if _2talktomanypeople >6
}
else {

}
capture confirm numeric v _2snfindsuppliersruralurban
if !_rc {
replace _2snfindsuppliersruralurban =. if _2snfindsuppliersruralurban >2
}
else {

}
capture confirm numeric v assohelpjob
if !_rc {
replace assohelpjob =77 if assohelpjob ==6
}
else {

}
capture confirm numeric v snentrustbusinessemployertype
if !_rc {
replace snentrustbusinessemployertype =77 if snentrustbusinessemployertype ==8
}
else {

}
capture confirm numeric v _2snrecojobsuccessruralurban
if !_rc {
replace _2snrecojobsuccessruralurban =. if _2snrecojobsuccessruralurban >2
}
else {

}
capture confirm numeric v _2snrecojobsuccesscastes
if !_rc {
replace _2snrecojobsuccesscastes =. if _2snrecojobsuccesscastes >17
}
else {

}
capture confirm numeric v newtraining
if !_rc {
replace newtraining =. if newtraining >2
}
else {

}
capture confirm numeric v dummypermanentmigrantwork
if !_rc {
replace dummypermanentmigrantwork =. if dummypermanentmigrantwork >2
}
else {

}
capture confirm numeric v _2A12
if !_rc {
replace _2A12 =. if _2A12 >7
}
else {

}
capture confirm numeric v _3snrecommendassocompared
if !_rc {
replace _3snrecommendassocompared =. if _3snrecommendassocompared >3
}
else {

}
capture confirm numeric v _3snrecojobsuccessfriend
if !_rc {
replace _3snrecojobsuccessfriend =. if _3snrecojobsuccessfriend >2
}
else {

}
capture confirm numeric v _3snfindcurrentjobeduc
if !_rc {
replace _3snfindcurrentjobeduc =. if _3snfindcurrentjobeduc >7
}
else {

}
capture confirm numeric v _2discrimination4
if !_rc {
replace _2discrimination4 =. if _2discrimination4 >2
}
else {

}
capture confirm numeric v _2shywithpeople
if !_rc {
replace _2shywithpeople =. if _2shywithpeople >6
}
else {

}
capture confirm numeric v _3satisfyingpurpose
if !_rc {
replace _3satisfyingpurpose =. if _3satisfyingpurpose >4
}
else {

}
capture confirm numeric v _2snentrustbusinessdistrict
if !_rc {
replace _2snentrustbusinessdistrict =. if _2snentrustbusinessdistrict >37
}
else {

}
capture confirm numeric v methodfindfirstjob
if !_rc {
replace methodfindfirstjob =66 if methodfindfirstjob ==10
}
else {

}
capture confirm numeric v _2snrecommendforjobcompared
if !_rc {
replace _2snrecommendforjobcompared =. if _2snrecommendforjobcompared >3
}
else {

}
capture confirm numeric v snrecruitworkermeetfrequency
if !_rc {
replace snrecruitworkermeetfrequency =. if snrecruitworkermeetfrequency >6
}
else {

}
capture confirm numeric v _2snrecruitworker
if !_rc {
replace _2snrecruitworker =. if _2snrecruitworker >3
}
else {

}
capture confirm numeric v Ab1
if !_rc {
replace Ab1 =. if Ab1 >7
}
else {

}
capture confirm numeric v snrecommendassoemployertype
if !_rc {
replace snrecommendassoemployertype =. if snrecommendassoemployertype >8
}
else {

}
capture confirm numeric v snfindcurrentjobcastes
if !_rc {
replace snfindcurrentjobcastes =. if snfindcurrentjobcastes >17
}
else {

}
capture confirm numeric v businesslossinvest
if !_rc {
replace businesslossinvest =0 if businesslossinvest ==1
}
else {

}
capture confirm numeric v meetbusinesslender
if !_rc {
replace meetbusinesslender =77 if meetbusinesslender ==7
}
else {

}
capture confirm numeric v reasondontsearchjob
if !_rc {
replace reasondontsearchjob =. if reasondontsearchjob >15
}
else {

}
capture confirm numeric v Ab6
if !_rc {
replace Ab6 =. if Ab6 >7
}
else {

}
capture confirm numeric v _2resdiscrimination3
if !_rc {
replace _2resdiscrimination3 =. if _2resdiscrimination3 >2
}
else {

}
capture confirm numeric v _2snrecommendforjobinvite
if !_rc {
replace _2snrecommendforjobinvite =. if _2snrecommendforjobinvite >2
}
else {

}
capture confirm numeric v dummyinsurance
if !_rc {
replace dummyinsurance =. if dummyinsurance >2
}
else {

}
capture confirm numeric v _3castebusinesslender
if !_rc {
replace _3castebusinesslender =. if _3castebusinesslender >18
}
else {

}
capture confirm numeric v _3snfindjobage
if !_rc {
replace _3snfindjobage =. if _3snfindjobage >6
}
else {

}
capture confirm numeric v _2Ab6
if !_rc {
replace _2Ab6 =. if _2Ab6 >7
}
else {

}
capture confirm numeric v _2snfindcurrentjobeduc
if !_rc {
replace _2snfindcurrentjobeduc =. if _2snfindcurrentjobeduc >7
}
else {

}
capture confirm numeric v _2sncloserelouthhlabourrelation
if !_rc {
replace _2sncloserelouthhlabourrelation =. if _2sncloserelouthhlabourrelation >2
}
else {

}
capture confirm numeric v ego2random_2_2
if !_rc {
replace ego2random_2_2 =. if ego2random_2_2 >2
}
else {

}
capture confirm numeric v stickwithgoals
if !_rc {
replace stickwithgoals =. if stickwithgoals >6
}
else {

}
capture confirm numeric v _2sncloserelouthhage
if !_rc {
replace _2sncloserelouthhage =. if _2sncloserelouthhage >6
}
else {

}
capture confirm numeric v _3businessworkersfrequencypayment
if !_rc {
replace _3businessworkersfrequencypayment =. if _3businessworkersfrequencypayment >4
}
else {

}
capture confirm numeric v _3sncloserelouthhintimacy
if !_rc {
replace _3sncloserelouthhintimacy =. if _3sncloserelouthhintimacy >3
}
else {

}
capture confirm numeric v _2snhelpemergencylabourrelation
if !_rc {
replace _2snhelpemergencylabourrelation =. if _2snhelpemergencylabourrelation >2
}
else {

}
capture confirm numeric v _3businesssocialsecurity
if !_rc {
replace _3businesssocialsecurity =. if _3businesssocialsecurity >2
}
else {

}
capture confirm numeric v snfindsuppliersdummyfam
if !_rc {
replace snfindsuppliersdummyfam =. if snfindsuppliersdummyfam >2
}
else {

}
capture confirm numeric v _3newideas
if !_rc {
replace _3newideas =. if _3newideas >6
}
else {

}
capture confirm numeric v everworksalaried
if !_rc {
replace everworksalaried =. if everworksalaried >2
}
else {

}
capture confirm numeric v ego3potential
if !_rc {
replace ego3potential =. if ego3potential >2
}
else {

}
capture confirm numeric v _3educbusinesslender
if !_rc {
replace _3educbusinesslender =. if _3educbusinesslender >7
}
else {

}
capture confirm numeric v _3managestress
if !_rc {
replace _3managestress =. if _3managestress >6
}
else {

}
capture confirm numeric v _3Ab9
if !_rc {
replace _3Ab9 =. if _3Ab9 >7
}
else {

}
capture confirm numeric v _2dummypreviouswagejob
if !_rc {
replace _2dummypreviouswagejob =. if _2dummypreviouswagejob >2
}
else {

}
capture confirm numeric v decisionearnwork
if !_rc {
replace decisionearnwork =77 if decisionearnwork ==10
}
else {

}
capture confirm numeric v problemwork7
if !_rc {
replace problemwork7 =66 if problemwork7 ==4
}
else {

}
capture confirm numeric v workpastsevendays
if !_rc {
replace workpastsevendays =. if workpastsevendays >2
}
else {

}
capture confirm numeric v _2A2
if !_rc {
replace _2A2 =. if _2A2 >7
}
else {

}
capture confirm numeric v _2assodegreeparticip
if !_rc {
replace _2assodegreeparticip =. if _2assodegreeparticip >3
}
else {

}
capture confirm numeric v resdiscrimination1
if !_rc {
replace resdiscrimination1 =. if resdiscrimination1 >2
}
else {

}
capture confirm numeric v _2snentrustbusinessmeetfrequency
if !_rc {
replace _2snentrustbusinessmeetfrequency =. if _2snentrustbusinessmeetfrequency >6
}
else {

}
capture confirm numeric v migrationtravelpayment
if !_rc {
replace migrationtravelpayment =. if migrationtravelpayment >4
}
else {

}
capture confirm numeric v _2snhelpemergencylabourtype
if !_rc {
replace _2snhelpemergencylabourtype =. if _2snhelpemergencylabourtype >4
}
else {

}
capture confirm numeric v _2snrecruitworkeremployertype
if !_rc {
replace _2snrecruitworkeremployertype =. if _2snrecruitworkeremployertype >8
}
else {

}
capture confirm numeric v assosize
if !_rc {
replace assosize =88 if assosize ==5
}
else {

}
capture confirm numeric v _3talkative
if !_rc {
replace _3talkative =. if _3talkative >6
}
else {

}
capture confirm numeric v B10
if !_rc {
replace B10 =. if B10 >7
}
else {

}
capture confirm numeric v _2covinstit6
if !_rc {
replace _2covinstit6 =. if _2covinstit6 >3
}
else {

}
capture confirm numeric v _2B12
if !_rc {
replace _2B12 =. if _2B12 >7
}
else {

}
capture confirm numeric v _2interestedbyart
if !_rc {
replace _2interestedbyart =. if _2interestedbyart >6
}
else {

}
capture confirm numeric v _3dummycontactleaders
if !_rc {
replace _3dummycontactleaders =. if _3dummycontactleaders >2
}
else {

}
capture confirm numeric v guarantee
if !_rc {
replace guarantee =77 if guarantee ==7
}
else {

}
capture confirm numeric v _2snhelpemergencyintimacy
if !_rc {
replace _2snhelpemergencyintimacy =. if _2snhelpemergencyintimacy >3
}
else {

}
capture confirm numeric v _3livingbusinesslender
if !_rc {
replace _3livingbusinesslender =. if _3livingbusinesslender >6
}
else {

}
capture confirm numeric v _3curious
if !_rc {
replace _3curious =. if _3curious >6
}
else {

}
capture confirm numeric v _3activeimagination
if !_rc {
replace _3activeimagination =. if _3activeimagination >6
}
else {

}
capture confirm numeric v _3B5
if !_rc {
replace _3B5 =. if _3B5 >7
}
else {

}
capture confirm numeric v ego2random_2_3
if !_rc {
replace ego2random_2_3 =. if ego2random_2_3 >2
}
else {

}
capture confirm numeric v _2wagejobpaymentinkindlist
if !_rc {
replace _2wagejobpaymentinkindlist =. if _2wagejobpaymentinkindlist >6
}
else {

}
capture confirm numeric v _2snrecojobsuccessreciprocity1
if !_rc {
replace _2snrecojobsuccessreciprocity1 =. if _2snrecojobsuccessreciprocity1 >2
}
else {

}
capture confirm numeric v _2A8
if !_rc {
replace _2A8 =. if _2A8 >7
}
else {

}
capture confirm numeric v _3problemwork6
if !_rc {
replace _3problemwork6 =66 if _3problemwork6 ==4
}
else {

}
capture confirm numeric v _2canreadcard2
if !_rc {
replace _2canreadcard2 =99 if _2canreadcard2 ==4
}
else {

}
capture confirm numeric v _2covnetworkhelpkinmember
if !_rc {
replace _2covnetworkhelpkinmember =. if _2covnetworkhelpkinmember >3
}
else {

}
capture confirm numeric v goingbackschool
if !_rc {
replace goingbackschool =. if goingbackschool >2
}
else {

}
capture confirm numeric v _3losswork
if !_rc {
replace _3losswork =. if _3losswork >2
}
else {

}
capture confirm numeric v snhelpemergencycastes
if !_rc {
replace snhelpemergencycastes =. if snhelpemergencycastes >17
}
else {

}
capture confirm numeric v _2snrecruitworkerfriend
if !_rc {
replace _2snrecruitworkerfriend =. if _2snrecruitworkerfriend >2
}
else {

}
capture confirm numeric v sntalkthemostlabourtype
if !_rc {
replace sntalkthemostlabourtype =. if sntalkthemostlabourtype >4
}
else {

}
capture confirm numeric v _2covneworktrustneighborhood
if !_rc {
replace _2covneworktrustneighborhood =. if _2covneworktrustneighborhood >3
}
else {

}
capture confirm numeric v _2sntalkthemostmeet
if !_rc {
replace _2sntalkthemostmeet =77 if _2sntalkthemostmeet ==7
}
else {

}
capture confirm numeric v numeracy2
if !_rc {
replace numeracy2 =. if numeracy2 >3
}
else {

}
capture confirm numeric v marriageloancaste
if !_rc {
replace marriageloancaste =. if marriageloancaste >17
}
else {

}
capture confirm numeric v snfindjobmeet
if !_rc {
replace snfindjobmeet =77 if snfindjobmeet ==7
}
else {

}
capture confirm numeric v _3snrecojobsuccessruralurban
if !_rc {
replace _3snrecojobsuccessruralurban =. if _3snrecojobsuccessruralurban >2
}
else {

}
capture confirm numeric v _2executionwork2
if !_rc {
replace _2executionwork2 =. if _2executionwork2 >2
}
else {

}
capture confirm numeric v _3reciprocity1businesslender
if !_rc {
replace _3reciprocity1businesslender =. if _3reciprocity1businesslender >2
}
else {

}
capture confirm numeric v _2sntalkthemostlabourtype
if !_rc {
replace _2sntalkthemostlabourtype =. if _2sntalkthemostlabourtype >4
}
else {

}
capture confirm numeric v snrecojobsuccesscastes
if !_rc {
replace snrecojobsuccesscastes =. if snrecojobsuccesscastes >17
}
else {

}
capture confirm numeric v loansettledgold
if !_rc {
replace loansettledgold =. if loansettledgold >2
}
else {

}
capture confirm numeric v _3resdiscrimination3
if !_rc {
replace _3resdiscrimination3 =. if _3resdiscrimination3 >2
}
else {

}
capture confirm numeric v marriagegifttype
if !_rc {
replace marriagegifttype =77 if marriagegifttype ==6
}
else {

}
capture confirm numeric v _2physicalagression
if !_rc {
replace _2physicalagression =66 if _2physicalagression ==5
}
else {

}
capture confirm numeric v _2snrecommendassoliving
if !_rc {
replace _2snrecommendassoliving =. if _2snrecommendassoliving >6
}
else {

}
capture confirm numeric v _3snrecommendforjobcompared
if !_rc {
replace _3snrecommendforjobcompared =. if _3snrecommendforjobcompared >3
}
else {

}
capture confirm numeric v typewageemployer
if !_rc {
replace typewageemployer =. if typewageemployer >8
}
else {

}
capture confirm numeric v A4
if !_rc {
replace A4 =. if A4 >7
}
else {

}
capture confirm numeric v _2snhelpemergencyeduc
if !_rc {
replace _2snhelpemergencyeduc =. if _2snhelpemergencyeduc >7
}
else {

}
capture confirm numeric v _3snrecruitworkerruralurban
if !_rc {
replace _3snrecruitworkerruralurban =. if _3snrecruitworkerruralurban >2
}
else {

}
capture confirm numeric v _3A8
if !_rc {
replace _3A8 =. if _3A8 >7
}
else {

}
capture confirm numeric v workwithother
if !_rc {
replace workwithother =. if workwithother >6
}
else {

}
capture confirm numeric v B8
if !_rc {
replace B8 =. if B8 >7
}
else {

}
capture confirm numeric v _3snfindcurrentjoblabourtype
if !_rc {
replace _3snfindcurrentjoblabourtype =. if _3snfindcurrentjoblabourtype >4
}
else {

}
capture confirm numeric v _3enjoypeople
if !_rc {
replace _3enjoypeople =. if _3enjoypeople >6
}
else {

}
capture confirm numeric v _3Ab12
if !_rc {
replace _3Ab12 =. if _3Ab12 >7
}
else {

}
capture confirm numeric v _2talkative
if !_rc {
replace _2talkative =. if _2talkative >6
}
else {

}
capture confirm numeric v _2snfindcurrentjobage
if !_rc {
replace _2snfindcurrentjobage =. if _2snfindcurrentjobage >6
}
else {

}
capture confirm numeric v meetfrequemcybusinesslender
if !_rc {
replace meetfrequemcybusinesslender =. if meetfrequemcybusinesslender >6
}
else {

}
capture confirm numeric v _2covneworktrustneighborhood
if !_rc {
label values _2covneworktrustneighborhood covidscale
}
else {

}
capture confirm numeric v _2snfindjobfriend
if !_rc {
label values _2snfindjobfriend yesno
}
else {

}
capture confirm numeric v _2forgiveother
if !_rc {
label values _2forgiveother personalityandbehavior
}
else {

}
capture confirm numeric v _2snfindjobage
if !_rc {
label values _2snfindjobage agelist
}
else {

}
capture confirm numeric v _3sntalkthemostliving
if !_rc {
label values _3sntalkthemostliving living
}
else {

}
capture confirm numeric v relationshiptohead
if !_rc {
label values relationshiptohead relationshipwithinhh
}
else {

}
capture confirm numeric v numeracy6
if !_rc {
label values numeracy6 numeracy
}
else {

}
capture confirm numeric v _3meetbusinesslender
if !_rc {
label values _3meetbusinesslender meet
}
else {

}
capture confirm numeric v reservationemployment
if !_rc {
label values reservationemployment yesno
}
else {

}
capture confirm numeric v _2discrimination4
if !_rc {
label values _2discrimination4 yesno
}
else {

}
capture confirm numeric v _3ego2random_3_2
if !_rc {
label values _3ego2random_3_2 yesno
}
else {

}
capture confirm numeric v _2executionwork2
if !_rc {
label values _2executionwork2 yesno
}
else {

}
capture confirm numeric v snrecommendforjobemployertype
if !_rc {
label values snrecommendforjobemployertype employertype
}
else {

}
capture confirm numeric v _2workhard
if !_rc {
label values _2workhard personalityandbehavior
}
else {

}
capture confirm numeric v ego3potential
if !_rc {
label values ego3potential yesno
}
else {

}
capture confirm numeric v _2changemood
if !_rc {
label values _2changemood personalityandbehavior
}
else {

}
capture confirm numeric v snfindsupplierscompared
if !_rc {
label values snfindsupplierscompared compared
}
else {

}
capture confirm numeric v _3nbermonthsearchjob
if !_rc {
label values _3nbermonthsearchjob nbermonth
}
else {

}
capture confirm numeric v _2sharefeelings
if !_rc {
label values _2sharefeelings personalityandbehavior
}
else {

}
capture confirm numeric v _3snrecruitworkerliving
if !_rc {
label values _3snrecruitworkerliving living
}
else {

}
capture confirm numeric v _3sexualharassment
if !_rc {
label values _3sexualharassment yesno
}
else {

}
capture confirm numeric v _2snrecruitworkerliving
if !_rc {
label values _2snrecruitworkerliving living
}
else {

}
capture confirm numeric v tryhard
if !_rc {
label values tryhard personalityandbehavior
}
else {

}
capture confirm numeric v organized
if !_rc {
label values organized personalityandbehavior
}
else {

}
capture confirm numeric v snhelpemergencysex
if !_rc {
label values snhelpemergencysex sex
}
else {

}
capture confirm numeric v _2snfindsupplierseduc
if !_rc {
label values _2snfindsupplierseduc educlist
}
else {

}
capture confirm numeric v _2Ab1
if !_rc {
label values _2Ab1 raventest
}
else {

}
capture confirm numeric v wagejobpaymentinkind
if !_rc {
label values wagejobpaymentinkind yesno
}
else {

}
capture confirm numeric v _3snrecommendassoliving
if !_rc {
label values _3snrecommendassoliving living
}
else {

}
capture confirm numeric v ego2random_3
if !_rc {
label values ego2random_3 yesno
}
else {

}
capture confirm numeric v _3snrecruitworkercastes
if !_rc {
label values _3snrecruitworkercastes castes
}
else {

}
capture confirm numeric v networktrustemployees
if !_rc {
label values networktrustemployees personalityandbehavior
}
else {

}
capture confirm numeric v snfindcurrentjobruralurban
if !_rc {
label values snfindcurrentjobruralurban rural
}
else {

}
capture confirm numeric v canreadcard1a
if !_rc {
label values canreadcard1a literacy2
}
else {

}
capture confirm numeric v _2Ab8
if !_rc {
label values _2Ab8 raventest
}
else {

}
capture confirm numeric v freehousebenefittype
if !_rc {
label values freehousebenefittype freehousebenefittype
}
else {

}
capture confirm numeric v _2sntalkthemostlabourtype
if !_rc {
label values _2sntalkthemostlabourtype labourrelation
}
else {

}
capture confirm numeric v _2finishtasks
if !_rc {
label values _2finishtasks personalityandbehavior
}
else {

}
capture confirm numeric v _2reasonstoppedwagejob
if !_rc {
label values _2reasonstoppedwagejob reasonstoppedjob
}
else {

}
capture confirm numeric v plantorepay
if !_rc {
label values plantorepay plantorepay
}
else {

}
capture confirm numeric v _3enjoypeople
if !_rc {
label values _3enjoypeople personalityandbehavior
}
else {

}
capture confirm numeric v _3snfindjobreciprocity1
if !_rc {
label values _3snfindjobreciprocity1 yesno
}
else {

}
capture confirm numeric v freehousescheme
if !_rc {
label values freehousescheme freehousescheme
}
else {

}
capture confirm numeric v A5
if !_rc {
label values A5 raventest
}
else {

}
capture confirm numeric v _2snentrustbusinessruralurban
if !_rc {
label values _2snentrustbusinessruralurban rural
}
else {

}
capture confirm numeric v _2assosize
if !_rc {
label values _2assosize nbpeople
}
else {

}
capture confirm numeric v _2workexposure5
if !_rc {
label values _2workexposure5 graduation
}
else {

}
capture confirm numeric v _2networktrustneighborhood
if !_rc {
label values _2networktrustneighborhood personalityandbehavior
}
else {

}
capture confirm numeric v snrecojobsuccessruralurban
if !_rc {
label values snrecojobsuccessruralurban rural
}
else {

}
capture confirm numeric v _2snfindjobwkp
if !_rc {
label values _2snfindjobwkp yesno
}
else {

}
capture confirm numeric v _2agreementatwork1
if !_rc {
label values _2agreementatwork1 agreementwork
}
else {

}
capture confirm numeric v _2snrecojobsuccessage
if !_rc {
label values _2snrecojobsuccessage agelist
}
else {

}
capture confirm numeric v _2B6
if !_rc {
label values _2B6 raventest
}
else {

}
capture confirm numeric v _3snfindsuppliersmeetfrequency
if !_rc {
label values _3snfindsuppliersmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _2sncloserelouthhruralurban
if !_rc {
label values _2sncloserelouthhruralurban rural
}
else {

}
capture confirm numeric v snfindjoblabourrelation
if !_rc {
label values snfindjoblabourrelation yesno
}
else {

}
capture confirm numeric v snentrustbusinessruralurban
if !_rc {
label values snentrustbusinessruralurban rural
}
else {

}
capture confirm numeric v _3discrimination7
if !_rc {
label values _3discrimination7 yesno
}
else {

}
capture confirm numeric v borrowerservices
if !_rc {
label values borrowerservices borrowerservices
}
else {

}
capture confirm numeric v reasondropping
if !_rc {
label values reasondropping reasondroppingout
}
else {

}
capture confirm numeric v dummysavingaccount
if !_rc {
label values dummysavingaccount yesno
}
else {

}
capture confirm numeric v _2dummypreviouswagejob
if !_rc {
label values _2dummypreviouswagejob yesno
}
else {

}
capture confirm numeric v _3numeracy2
if !_rc {
label values _3numeracy2 numeracy
}
else {

}
capture confirm numeric v snfindsuppliersintimacy
if !_rc {
label values snfindsuppliersintimacy intimacydegree
}
else {

}
capture confirm numeric v _2numeracy2
if !_rc {
label values _2numeracy2 numeracy
}
else {

}
capture confirm numeric v _2snfindjobintimacy
if !_rc {
label values _2snfindjobintimacy intimacydegree
}
else {

}
capture confirm numeric v B9
if !_rc {
label values B9 raventest
}
else {

}
capture confirm numeric v stickwithgoals
if !_rc {
label values stickwithgoals personalityandbehavior
}
else {

}
capture confirm numeric v _2verbalaggression
if !_rc {
label values _2verbalaggression graduation2
}
else {

}
capture confirm numeric v snhelpemergencydummyhh
if !_rc {
label values snhelpemergencydummyhh yesno
}
else {

}
capture confirm numeric v numeracy1
if !_rc {
label values numeracy1 numeracy
}
else {

}
capture confirm numeric v _3snfindjobliving
if !_rc {
label values _3snfindjobliving living
}
else {

}
capture confirm numeric v _2snrecommendforjobdistrict
if !_rc {
label values _2snrecommendforjobdistrict district
}
else {

}
capture confirm numeric v _3makeplans
if !_rc {
label values _3makeplans personalityandbehavior
}
else {

}
capture confirm numeric v repayduration1
if !_rc {
label values repayduration1 frequency2
}
else {

}
capture confirm numeric v businesspaymentinkindlist
if !_rc {
label values businesspaymentinkindlist paymentinkind
}
else {

}
capture confirm numeric v _2covinstit1
if !_rc {
label values _2covinstit1 covinstit
}
else {

}
capture confirm numeric v _2snrecommendassoreciprocity1
if !_rc {
label values _2snrecommendassoreciprocity1 yesno
}
else {

}
capture confirm numeric v _3businesspaymentinkindlist
if !_rc {
label values _3businesspaymentinkindlist paymentinkind
}
else {

}
capture confirm numeric v talkative
if !_rc {
label values talkative personalityandbehavior
}
else {

}
capture confirm numeric v snrecommendforjobruralurban
if !_rc {
label values snrecommendforjobruralurban rural
}
else {

}
capture confirm numeric v otherlenderservices
if !_rc {
label values otherlenderservices otherlenderservices
}
else {

}
capture confirm numeric v snfindsuppliersdistrict
if !_rc {
label values snfindsuppliersdistrict district
}
else {

}
capture confirm numeric v opinionworkingwoman
if !_rc {
label values opinionworkingwoman opinionwork
}
else {

}
capture confirm numeric v _3locuscontrol1
if !_rc {
label values _3locuscontrol1 locusscale
}
else {

}
capture confirm numeric v snrecojobsuccessmeet
if !_rc {
label values snrecojobsuccessmeet meet
}
else {

}
capture confirm numeric v _3opinionactivewoman
if !_rc {
label values _3opinionactivewoman opinionwork
}
else {

}
capture confirm numeric v _3executionwork1
if !_rc {
label values _3executionwork1 yesno
}
else {

}
capture confirm numeric v _3dummyseasonalmainoccup
if !_rc {
label values _3dummyseasonalmainoccup yesno
}
else {

}
capture confirm numeric v _2opinionworkingwoman
if !_rc {
label values _2opinionworkingwoman opinionwork
}
else {

}
capture confirm numeric v snfindcurrentjoblabourrelation
if !_rc {
label values snfindcurrentjoblabourrelation yesno
}
else {

}
capture confirm numeric v _2snhelpemergencyinvite
if !_rc {
label values _2snhelpemergencyinvite yesno
}
else {

}
capture confirm numeric v snentrustbusinessliving
if !_rc {
label values snentrustbusinessliving living
}
else {

}
capture confirm numeric v reasonnotusedcreditcard
if !_rc {
label values reasonnotusedcreditcard demo7
}
else {

}
capture confirm numeric v _2Ab5
if !_rc {
label values _2Ab5 raventest
}
else {

}
capture confirm numeric v reasonnotusedebitcard
if !_rc {
label values reasonnotusedebitcard demo7
}
else {

}
capture confirm numeric v numeracy3
if !_rc {
label values numeracy3 numeracy
}
else {

}
capture confirm numeric v businesslabourerpension
if !_rc {
label values businesslabourerpension yesno
}
else {

}
capture confirm numeric v _3snrecommendassolabourtype
if !_rc {
label values _3snrecommendassolabourtype labourrelation
}
else {

}
capture confirm numeric v numeracy4
if !_rc {
label values numeracy4 numeracy
}
else {

}
capture confirm numeric v _3numeracy3
if !_rc {
label values _3numeracy3 numeracy
}
else {

}
capture confirm numeric v _2workpastsevendays
if !_rc {
label values _2workpastsevendays yesno
}
else {

}
capture confirm numeric v agebusinesslender
if !_rc {
label values agebusinesslender agelist
}
else {

}
capture confirm numeric v snentrustbusinesslabourrelation
if !_rc {
label values snentrustbusinesslabourrelation yesno
}
else {

}
capture confirm numeric v enjoypeople
if !_rc {
label values enjoypeople personalityandbehavior
}
else {

}
capture confirm numeric v _2snrecojobsuccessreciprocity1
if !_rc {
label values _2snrecojobsuccessreciprocity1 yesno
}
else {

}
capture confirm numeric v _2jobpreference
if !_rc {
label values _2jobpreference jobpreference
}
else {

}
capture confirm numeric v _2snfindcurrentjobdummyfam
if !_rc {
label values _2snfindcurrentjobdummyfam yesno
}
else {

}
capture confirm numeric v loansettled
if !_rc {
label values loansettled yesno
}
else {

}
capture confirm numeric v snrecruitworkermeet
if !_rc {
label values snrecruitworkermeet meet
}
else {

}
capture confirm numeric v _3dummypreviouswagejob
if !_rc {
label values _3dummypreviouswagejob yesno
}
else {

}
capture confirm numeric v B2
if !_rc {
label values B2 raventest
}
else {

}
capture confirm numeric v _3snfindjobinvite
if !_rc {
label values _3snfindjobinvite yesno
}
else {

}
capture confirm numeric v numeracy5
if !_rc {
label values numeracy5 numeracy
}
else {

}
capture confirm numeric v executionwork1
if !_rc {
label values executionwork1 yesno
}
else {

}
capture confirm numeric v _3numeracy1
if !_rc {
label values _3numeracy1 numeracy
}
else {

}
capture confirm numeric v _3snfindcurrentjobfriend
if !_rc {
label values _3snfindcurrentjobfriend yesno
}
else {

}
capture confirm numeric v _3sntalkthemostruralurban
if !_rc {
label values _3sntalkthemostruralurban rural
}
else {

}
capture confirm numeric v _3snrecommendassoreciprocity1
if !_rc {
label values _3snrecommendassoreciprocity1 yesno
}
else {

}
capture confirm numeric v _2businessnbunpaidworkers
if !_rc {
label values _2businessnbunpaidworkers nbworkers
}
else {

}
capture confirm numeric v _2snfindjobruralurban
if !_rc {
label values _2snfindjobruralurban rural
}
else {

}
capture confirm numeric v _3businessnbworkers
if !_rc {
label values _3businessnbworkers nbworkers
}
else {

}
capture confirm numeric v _2snrecruitworkersex
if !_rc {
label values _2snrecruitworkersex sex
}
else {

}
capture confirm numeric v _2workmate
if !_rc {
label values _2workmate satisfaction
}
else {

}
capture confirm numeric v remsentmoney
if !_rc {
label values remsentmoney yesno
}
else {

}
capture confirm numeric v _2businessnbpaidworkers
if !_rc {
label values _2businessnbpaidworkers nbworkers
}
else {

}
capture confirm numeric v _3discrimination2
if !_rc {
label values _3discrimination2 yesno
}
else {

}
capture confirm numeric v _3assosize
if !_rc {
label values _3assosize nbpeople
}
else {

}
capture confirm numeric v assohelpjob
if !_rc {
label values assohelpjob assohelpjob
}
else {

}
capture confirm numeric v nbermonthsearchjob
if !_rc {
label values nbermonthsearchjob nbermonth
}
else {

}
capture confirm numeric v _3snfindjobcastes
if !_rc {
label values _3snfindjobcastes castes
}
else {

}
capture confirm numeric v _3agreementatwork1
if !_rc {
label values _3agreementatwork1 agreementwork
}
else {

}
capture confirm numeric v _2readystartjob
if !_rc {
label values _2readystartjob yesno
}
else {

}
capture confirm numeric v _2snrecommendforjobruralurban
if !_rc {
label values _2snrecommendforjobruralurban rural
}
else {

}
capture confirm numeric v snfindjobdistrict
if !_rc {
label values snfindjobdistrict district
}
else {

}
capture confirm numeric v _3understandotherfeeling
if !_rc {
label values _3understandotherfeeling personalityandbehavior
}
else {

}
capture confirm numeric v businessskill
if !_rc {
label values businessskill skillbusiness
}
else {

}
capture confirm numeric v _2snrecommendassoruralurban
if !_rc {
label values _2snrecommendassoruralurban rural
}
else {

}
capture confirm numeric v _2snhelpemergencyintimacy
if !_rc {
label values _2snhelpemergencyintimacy intimacydegree
}
else {

}
capture confirm numeric v changemood
if !_rc {
label values changemood personalityandbehavior
}
else {

}
capture confirm numeric v sntalkthemostmeet
if !_rc {
label values sntalkthemostmeet meet
}
else {

}
capture confirm numeric v migrationreason
if !_rc {
label values migrationreason migrationreason
}
else {

}
capture confirm numeric v _2Ab2
if !_rc {
label values _2Ab2 raventest
}
else {

}
capture confirm numeric v savingspurpose
if !_rc {
label values savingspurpose purposebankaccount
}
else {

}
capture confirm numeric v usedebitcard
if !_rc {
label values usedebitcard demo6
}
else {

}
capture confirm numeric v classcompleted
if !_rc {
label values classcompleted classlist
}
else {

}
capture confirm numeric v _2rurallocation
if !_rc {
label values _2rurallocation yesno
}
else {

}
capture confirm numeric v _3feeldepressed
if !_rc {
label values _3feeldepressed personalityandbehavior
}
else {

}
capture confirm numeric v _2snfindsuppliersruralurban
if !_rc {
label values _2snfindsuppliersruralurban rural
}
else {

}
capture confirm numeric v marriagelenderfrom
if !_rc {
label values marriagelenderfrom living
}
else {

}
capture confirm numeric v _3B11
if !_rc {
label values _3B11 raventest
}
else {

}
capture confirm numeric v _3dummybusinessunpaidworkers
if !_rc {
label values _3dummybusinessunpaidworkers yesno
}
else {

}
capture confirm numeric v _3methodfindjob
if !_rc {
label values _3methodfindjob methodfindjob
}
else {

}
capture confirm numeric v _2trustingofother
if !_rc {
label values _2trustingofother personalityandbehavior
}
else {

}
capture confirm numeric v _3discrimination5
if !_rc {
label values _3discrimination5 yesno
}
else {

}
capture confirm numeric v remsentservices
if !_rc {
label values remsentservices otherlenderservices
}
else {

}
capture confirm numeric v _2snhelpemergencysex
if !_rc {
label values _2snhelpemergencysex sex
}
else {

}
capture confirm numeric v _3snrecommendassomeet
if !_rc {
label values _3snrecommendassomeet meet
}
else {

}
capture confirm numeric v methodfindjob
if !_rc {
label values methodfindjob methodfindjob
}
else {

}
capture confirm numeric v _3ego2random_1_3
if !_rc {
label values _3ego2random_1_3 yesno
}
else {

}
capture confirm numeric v _2executionwork6
if !_rc {
label values _2executionwork6 yesno
}
else {

}
capture confirm numeric v _3sncloserelouthhemployertype
if !_rc {
label values _3sncloserelouthhemployertype employertype
}
else {

}
capture confirm numeric v _2covinstit9
if !_rc {
label values _2covinstit9 covidscale
}
else {

}
capture confirm numeric v snentrustbusinessmeet
if !_rc {
label values snentrustbusinessmeet meet
}
else {

}
capture confirm numeric v _3snrecommendforjoblabourrelation
if !_rc {
label values _3snrecommendforjoblabourrelation yesno
}
else {

}
capture confirm numeric v snfindjobintimacy
if !_rc {
label values snfindjobintimacy intimacydegree
}
else {

}
capture confirm numeric v _2putoffduties
if !_rc {
label values _2putoffduties personalityandbehavior
}
else {

}
capture confirm numeric v dummyinsurance
if !_rc {
label values dummyinsurance yesno
}
else {

}
capture confirm numeric v _2A3
if !_rc {
label values _2A3 raventest
}
else {

}
capture confirm numeric v forgiveother
if !_rc {
label values forgiveother personalityandbehavior
}
else {

}
capture confirm numeric v _3intimacybusinesslender
if !_rc {
label values _3intimacybusinesslender intimacydegree
}
else {

}
capture confirm numeric v snfindcurrentjobmeet
if !_rc {
label values snfindcurrentjobmeet meet
}
else {

}
capture confirm numeric v _2Ab11
if !_rc {
label values _2Ab11 raventest
}
else {

}
capture confirm numeric v _3snrecojobsuccessmeetfrequency
if !_rc {
label values _3snrecojobsuccessmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _2snrecruitworkerlabourtype
if !_rc {
label values _2snrecruitworkerlabourtype labourrelation
}
else {

}
capture confirm numeric v maritalstatus
if !_rc {
label values maritalstatus maritalstatus
}
else {

}
capture confirm numeric v snhelpemergencyage
if !_rc {
label values snhelpemergencyage agelist
}
else {

}
capture confirm numeric v _2discrimination6
if !_rc {
label values _2discrimination6 yesno
}
else {

}
capture confirm numeric v snhelpemergencymeet
if !_rc {
label values snhelpemergencymeet meet
}
else {

}
capture confirm numeric v _2snfindsuppliersfriend
if !_rc {
label values _2snfindsuppliersfriend yesno
}
else {

}
capture confirm numeric v _3Ab7
if !_rc {
label values _3Ab7 raventest
}
else {

}
capture confirm numeric v meetbusinesslender
if !_rc {
label values meetbusinesslender meet
}
else {

}
capture confirm numeric v snfindjobliving
if !_rc {
label values snfindjobliving living
}
else {

}
capture confirm numeric v workwithother
if !_rc {
label values workwithother personalityandbehavior
}
else {

}
capture confirm numeric v intimacybusinesslender
if !_rc {
label values intimacybusinesslender intimacydegree
}
else {

}
capture confirm numeric v _3snrecommendforjobinvite
if !_rc {
label values _3snrecommendforjobinvite yesno
}
else {

}
capture confirm numeric v _3snfindcurrentjobcastes
if !_rc {
label values _3snfindcurrentjobcastes castes
}
else {

}
capture confirm numeric v _3snentrustbusinessmeet
if !_rc {
label values _3snentrustbusinessmeet meet
}
else {

}
capture confirm numeric v _2physicalharm
if !_rc {
label values _2physicalharm physicalharm
}
else {

}
capture confirm numeric v sncloserelouthhmeetfrequency
if !_rc {
label values sncloserelouthhmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v snhelpemergencyreciprocity1
if !_rc {
label values snhelpemergencyreciprocity1 yesno
}
else {

}
capture confirm numeric v invitebusinesslender
if !_rc {
label values invitebusinesslender yesno
}
else {

}
capture confirm numeric v _3snfindsuppliersdummyhh
if !_rc {
label values _3snfindsuppliersdummyhh yesno
}
else {

}
capture confirm numeric v castebusinesslender
if !_rc {
label values castebusinesslender casteemployer
}
else {

}
capture confirm numeric v _2easilyupset
if !_rc {
label values _2easilyupset personalityandbehavior
}
else {

}
capture confirm numeric v _3covinstit8
if !_rc {
label values _3covinstit8 covidscale
}
else {

}
capture confirm numeric v inventive
if !_rc {
label values inventive personalityandbehavior
}
else {

}
capture confirm numeric v _2staycalm
if !_rc {
label values _2staycalm personalityandbehavior
}
else {

}
capture confirm numeric v _2wagejobtype
if !_rc {
label values _2wagejobtype typejob
}
else {

}
capture confirm numeric v _3startbusiness
if !_rc {
label values _3startbusiness yesno
}
else {

}
capture confirm numeric v _3snrecruitworkerruralurban
if !_rc {
label values _3snrecruitworkerruralurban rural
}
else {

}
capture confirm numeric v _3locuscontrol4
if !_rc {
label values _3locuscontrol4 locusscale
}
else {

}
capture confirm numeric v _3managestress
if !_rc {
label values _3managestress personalityandbehavior
}
else {

}
capture confirm numeric v interviewplace
if !_rc {
label values interviewplace interviewplace
}
else {

}
capture confirm numeric v _2covnetworkpeoplehelping
if !_rc {
label values _2covnetworkpeoplehelping covidscale
}
else {

}
capture confirm numeric v _2networktrustemployees
if !_rc {
label values _2networktrustemployees personalityandbehavior
}
else {

}
capture confirm numeric v snfindjobsex
if !_rc {
label values snfindjobsex sex
}
else {

}
capture confirm numeric v sncloserelouthhlabourtype
if !_rc {
label values sncloserelouthhlabourtype labourrelation
}
else {

}
capture confirm numeric v remreceivedsourcerelation
if !_rc {
label values remreceivedsourcerelation relation3
}
else {

}
capture confirm numeric v _3staycalm
if !_rc {
label values _3staycalm personalityandbehavior
}
else {

}
capture confirm numeric v _3networkpeoplehelping
if !_rc {
label values _3networkpeoplehelping personalityandbehavior
}
else {

}
capture confirm numeric v _3repetitivetasks
if !_rc {
label values _3repetitivetasks personalityandbehavior
}
else {

}
capture confirm numeric v helpfulwithothers
if !_rc {
label values helpfulwithothers personalityandbehavior
}
else {

}
capture confirm numeric v snrecojobsuccesslabourtype
if !_rc {
label values snrecojobsuccesslabourtype labourrelation
}
else {

}
capture confirm numeric v _3numeracy4
if !_rc {
label values _3numeracy4 numeracy
}
else {

}
capture confirm numeric v A3
if !_rc {
label values A3 raventest
}
else {

}
capture confirm numeric v _3snfindsupplierscastes
if !_rc {
label values _3snfindsupplierscastes castes
}
else {

}
capture confirm numeric v _3snentrustbusinessintimacy
if !_rc {
label values _3snentrustbusinessintimacy intimacydegree
}
else {

}
capture confirm numeric v snrecommendassointimacy
if !_rc {
label values snrecommendassointimacy intimacydegree
}
else {

}
capture confirm numeric v sntalkthemosteduc
if !_rc {
label values sntalkthemosteduc educlist
}
else {

}
capture confirm numeric v physicalharm
if !_rc {
label values physicalharm physicalharm
}
else {

}
capture confirm numeric v banktype
if !_rc {
label values banktype banktype
}
else {

}
capture confirm numeric v snrecommendassocompared
if !_rc {
label values snrecommendassocompared compared
}
else {

}
capture confirm numeric v _3activeimagination
if !_rc {
label values _3activeimagination personalityandbehavior
}
else {

}
capture confirm numeric v _2nervous
if !_rc {
label values _2nervous personalityandbehavior
}
else {

}
capture confirm numeric v _3worryalot
if !_rc {
label values _3worryalot personalityandbehavior
}
else {

}
capture confirm numeric v sexbusinesslender
if !_rc {
label values sexbusinesslender sex
}
else {

}
capture confirm numeric v discrimination8
if !_rc {
label values discrimination8 yesno
}
else {

}
capture confirm numeric v _2snentrustbusinesswkp
if !_rc {
label values _2snentrustbusinesswkp yesno
}
else {

}
capture confirm numeric v snrecommendassomeet
if !_rc {
label values snrecommendassomeet meet
}
else {

}
capture confirm numeric v salariedwagetype
if !_rc {
label values salariedwagetype wagetype
}
else {

}
capture confirm numeric v migrationadvancereceiver
if !_rc {
label values migrationadvancereceiver advancereceiver
}
else {

}
capture confirm numeric v snfindsupplierssex
if !_rc {
label values snfindsupplierssex sex
}
else {

}
capture confirm numeric v _3sncloserelouthhlabourrelation
if !_rc {
label values _3sncloserelouthhlabourrelation yesno
}
else {

}
capture confirm numeric v _3newideas
if !_rc {
label values _3newideas personalityandbehavior
}
else {

}
capture confirm numeric v snfindjobmeet
if !_rc {
label values snfindjobmeet meet
}
else {

}
capture confirm numeric v _3workhard
if !_rc {
label values _3workhard personalityandbehavior
}
else {

}
capture confirm numeric v snfindsuppliersemployertype
if !_rc {
label values snfindsuppliersemployertype employertype
}
else {

}
capture confirm numeric v _2snrecommendassowkp
if !_rc {
label values _2snrecommendassowkp yesno
}
else {

}
capture confirm numeric v _3snfindcurrentjobage
if !_rc {
label values _3snfindcurrentjobage agelist
}
else {

}
capture confirm numeric v typeofhigheredu
if !_rc {
label values typeofhigheredu typeschool
}
else {

}
capture confirm numeric v _2activeimagination
if !_rc {
label values _2activeimagination personalityandbehavior
}
else {

}
capture confirm numeric v _2reasondontsearchjob
if !_rc {
label values _2reasondontsearchjob reasondontsearchjob
}
else {

}
capture confirm numeric v migrationfindjob
if !_rc {
label values migrationfindjob migrationfindjob
}
else {

}
capture confirm numeric v _3workexposure3
if !_rc {
label values _3workexposure3 graduation
}
else {

}
capture confirm numeric v _3executionwork6
if !_rc {
label values _3executionwork6 yesno
}
else {

}
capture confirm numeric v _3snfindsuppliersinvite
if !_rc {
label values _3snfindsuppliersinvite yesno
}
else {

}
capture confirm numeric v _2snfindjobmeetfrequency
if !_rc {
label values _2snfindjobmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _2businessworkersfrequencypayment
if !_rc {
label values _2businessworkersfrequencypayment frequency5
}
else {

}
capture confirm numeric v _2canreadcard1c
if !_rc {
label values _2canreadcard1c literacy2
}
else {

}
capture confirm numeric v _3snfindjobmeetfrequency
if !_rc {
label values _3snfindjobmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v covfrequencyrepayment
if !_rc {
label values covfrequencyrepayment yesnona
}
else {

}
capture confirm numeric v covrefusalloan
if !_rc {
label values covrefusalloan yesnona
}
else {

}
capture confirm numeric v snrecruitworkerliving
if !_rc {
label values snrecruitworkerliving living
}
else {

}
capture confirm numeric v _2snrecojobsuccessruralurban
if !_rc {
label values _2snrecojobsuccessruralurban rural
}
else {

}
capture confirm numeric v _2organized
if !_rc {
label values _2organized personalityandbehavior
}
else {

}
capture confirm numeric v snrecruitworker
if !_rc {
label values snrecruitworker yesnosocialnetwork
}
else {

}
capture confirm numeric v _3B4
if !_rc {
label values _3B4 raventest
}
else {

}
capture confirm numeric v _3covcontactinstitution
if !_rc {
label values _3covcontactinstitution institution
}
else {

}
capture confirm numeric v assodegreeparticip
if !_rc {
label values assodegreeparticip assodegreeparticip
}
else {

}
capture confirm numeric v _3snfindcurrentjobdummyhh
if !_rc {
label values _3snfindcurrentjobdummyhh yesno
}
else {

}
capture confirm numeric v snrecojobsuccessdistrict
if !_rc {
label values snrecojobsuccessdistrict district
}
else {

}
capture confirm numeric v _3wagejobpaymentinkind
if !_rc {
label values _3wagejobpaymentinkind yesno
}
else {

}
capture confirm numeric v shywithpeople
if !_rc {
label values shywithpeople personalityandbehavior
}
else {

}
capture confirm numeric v goldreasonpledge
if !_rc {
label values goldreasonpledge reasonborrowing
}
else {

}
capture confirm numeric v snrecruitworkerage
if !_rc {
label values snrecruitworkerage agelist
}
else {

}
capture confirm numeric v _3canreadcard2
if !_rc {
label values _3canreadcard2 literacy2
}
else {

}
capture confirm numeric v _2shywithpeople
if !_rc {
label values _2shywithpeople personalityandbehavior
}
else {

}
capture confirm numeric v _3snfindsuppliersruralurban
if !_rc {
label values _3snfindsuppliersruralurban rural
}
else {

}
capture confirm numeric v dummyadvance
if !_rc {
label values dummyadvance yesno
}
else {

}
capture confirm numeric v recommendloanrelation
if !_rc {
label values recommendloanrelation relation
}
else {

}
capture confirm numeric v assosize
if !_rc {
label values assosize nbpeople
}
else {

}
capture confirm numeric v insurancetype
if !_rc {
label values insurancetype insurancetype
}
else {

}
capture confirm numeric v _3physicalharm
if !_rc {
label values _3physicalharm physicalharm
}
else {

}
capture confirm numeric v rationcardreasonnouse
if !_rc {
label values rationcardreasonnouse rationcardreasonnouse
}
else {

}
capture confirm numeric v _2sntalkthemostmeet
if !_rc {
label values _2sntalkthemostmeet meet
}
else {

}
capture confirm numeric v snrecommendassodummyhh
if !_rc {
label values snrecommendassodummyhh yesno
}
else {

}
capture confirm numeric v _2businesssocialsecurity
if !_rc {
label values _2businesssocialsecurity yesno
}
else {

}
capture confirm numeric v discrimination4
if !_rc {
label values discrimination4 yesno
}
else {

}
capture confirm numeric v contract
if !_rc {
label values contract contracttype
}
else {

}
capture confirm numeric v _2Ab7
if !_rc {
label values _2Ab7 raventest
}
else {

}
capture confirm numeric v _3snfindcurrentjobreciprocity1
if !_rc {
label values _3snfindcurrentjobreciprocity1 yesno
}
else {

}
capture confirm numeric v problemwork4
if !_rc {
label values problemwork4 problemwork
}
else {

}
capture confirm numeric v _3snrecruitworkerreciprocity1
if !_rc {
label values _3snrecruitworkerreciprocity1 yesno
}
else {

}
capture confirm numeric v A6
if !_rc {
label values A6 raventest
}
else {

}
capture confirm numeric v _3problemwork10
if !_rc {
label values _3problemwork10 problemwork
}
else {

}
capture confirm numeric v _2problemwork7
if !_rc {
label values _2problemwork7 problemwork
}
else {

}
capture confirm numeric v snfindsupplierslabourtype
if !_rc {
label values snfindsupplierslabourtype labourrelation
}
else {

}
capture confirm numeric v problemwork10
if !_rc {
label values problemwork10 problemwork
}
else {

}
capture confirm numeric v dummyproblemtorepay
if !_rc {
label values dummyproblemtorepay yesno
}
else {

}
capture confirm numeric v snrecommendassodummyfam
if !_rc {
label values snrecommendassodummyfam yesno
}
else {

}
capture confirm numeric v problemwork7
if !_rc {
label values problemwork7 problemwork
}
else {

}
capture confirm numeric v problemwork5
if !_rc {
label values problemwork5 problemwork
}
else {

}
capture confirm numeric v _2sntalkthemostliving
if !_rc {
label values _2sntalkthemostliving living
}
else {

}
capture confirm numeric v _2worryalot
if !_rc {
label values _2worryalot personalityandbehavior
}
else {

}
capture confirm numeric v covnetworkpeoplehelping
if !_rc {
label values covnetworkpeoplehelping covidscale
}
else {

}
capture confirm numeric v _2snrecruitworkerdummyfam
if !_rc {
label values _2snrecruitworkerdummyfam yesno
}
else {

}
capture confirm numeric v _3snrecruitworkermeetfrequency
if !_rc {
label values _3snrecruitworkermeetfrequency meetfrequency
}
else {

}
capture confirm numeric v dummyinteret
if !_rc {
label values dummyinteret yesno
}
else {

}
capture confirm numeric v educbusinesslender
if !_rc {
label values educbusinesslender educlist
}
else {

}
capture confirm numeric v _3covinstit10
if !_rc {
label values _3covinstit10 covidscale
}
else {

}
capture confirm numeric v _3snrecruitworkerdistrict
if !_rc {
label values _3snrecruitworkerdistrict district
}
else {

}
capture confirm numeric v dummyaspirationmorehours
if !_rc {
label values dummyaspirationmorehours yesno3
}
else {

}
capture confirm numeric v snentrustbusinessfriend
if !_rc {
label values snentrustbusinessfriend yesno
}
else {

}
capture confirm numeric v reservationgrade
if !_rc {
label values reservationgrade classlist
}
else {

}
capture confirm numeric v lendersex
if !_rc {
label values lendersex sex1
}
else {

}
capture confirm numeric v _3snrecojobsuccessmeet
if !_rc {
label values _3snrecojobsuccessmeet meet
}
else {

}
capture confirm numeric v _2snhelpemergencyruralurban
if !_rc {
label values _2snhelpemergencyruralurban rural
}
else {

}
capture confirm numeric v _2snrecojobsuccesseduc
if !_rc {
label values _2snrecojobsuccesseduc educlist
}
else {

}
capture confirm numeric v snrecruitworkerdummyfam
if !_rc {
label values snrecruitworkerdummyfam yesno
}
else {

}
capture confirm numeric v _2B11
if !_rc {
label values _2B11 raventest
}
else {

}
capture confirm numeric v _2sntalkthemostlabourrelation
if !_rc {
label values _2sntalkthemostlabourrelation yesno
}
else {

}
capture confirm numeric v resdiscrimination1
if !_rc {
label values resdiscrimination1 yesno
}
else {

}
capture confirm numeric v salariedjobbonus
if !_rc {
label values salariedjobbonus yesno
}
else {

}
capture confirm numeric v _3inventive
if !_rc {
label values _3inventive personalityandbehavior
}
else {

}
capture confirm numeric v relationshipbusinesslabourer
if !_rc {
label values relationshipbusinesslabourer relationlabourer
}
else {

}
capture confirm numeric v sntalkthemostdistrict
if !_rc {
label values sntalkthemostdistrict district
}
else {

}
capture confirm numeric v insurancepaymentfrequency
if !_rc {
label values insurancepaymentfrequency frequency3
}
else {

}
capture confirm numeric v interestfrequency
if !_rc {
label values interestfrequency frequency
}
else {

}
capture confirm numeric v _3B1
if !_rc {
label values _3B1 raventest
}
else {

}
capture confirm numeric v sncloserelouthhdistrict
if !_rc {
label values sncloserelouthhdistrict district
}
else {

}
capture confirm numeric v remreceivedsourceplace
if !_rc {
label values remreceivedsourceplace migrationplace
}
else {

}
capture confirm numeric v _2snfindcurrentjobdistrict
if !_rc {
label values _2snfindcurrentjobdistrict district
}
else {

}
capture confirm numeric v snhelpemergencylabourrelation
if !_rc {
label values snhelpemergencylabourrelation yesno
}
else {

}
capture confirm numeric v savingsaccounttype
if !_rc {
label values savingsaccounttype savingsaccounttype
}
else {

}
capture confirm numeric v salariedcontract
if !_rc {
label values salariedcontract yesno
}
else {

}
capture confirm numeric v _3B2
if !_rc {
label values _3B2 raventest
}
else {

}
capture confirm numeric v _2snrecojobsuccessdummyhh
if !_rc {
label values _2snrecojobsuccessdummyhh yesno
}
else {

}
capture confirm numeric v A9
if !_rc {
label values A9 raventest
}
else {

}
capture confirm numeric v snrecommendforjobdistrict
if !_rc {
label values snrecommendforjobdistrict district
}
else {

}
capture confirm numeric v dummyloans
if !_rc {
label values dummyloans yesno
}
else {

}
capture confirm numeric v marriagegifttype
if !_rc {
label values marriagegifttype gifttype
}
else {

}
capture confirm numeric v _2snfindsupplierslabourtype
if !_rc {
label values _2snfindsupplierslabourtype labourrelation
}
else {

}
capture confirm numeric v _2snrecommendforjobcastes
if !_rc {
label values _2snrecommendforjobcastes castes
}
else {

}
capture confirm numeric v locuscontrol4
if !_rc {
label values locuscontrol4 locusscale
}
else {

}
capture confirm numeric v _2dummyassohelpjob
if !_rc {
label values _2dummyassohelpjob yesno
}
else {

}
capture confirm numeric v satisfactionsalary
if !_rc {
label values satisfactionsalary satisfaction4
}
else {

}
capture confirm numeric v marriageblood
if !_rc {
label values marriageblood bloodrelationship
}
else {

}
capture confirm numeric v snfindjobage
if !_rc {
label values snfindjobage agelist
}
else {

}
capture confirm numeric v reasonnoinsurance
if !_rc {
label values reasonnoinsurance reasonnoinsurance
}
else {

}
capture confirm numeric v dummyincomeassets
if !_rc {
label values dummyincomeassets yesno
}
else {

}
capture confirm numeric v migrationadvanceprovider
if !_rc {
label values migrationadvanceprovider advanceprovider
}
else {

}
capture confirm numeric v snfindsuppliersage
if !_rc {
label values snfindsuppliersage agelist
}
else {

}
capture confirm numeric v snentrustbusinesssex
if !_rc {
label values snentrustbusinesssex sex
}
else {

}
capture confirm numeric v assohelpbusiness
if !_rc {
label values assohelpbusiness assohelpbusiness
}
else {

}
capture confirm numeric v _2snrecruitworkerreciprocity1
if !_rc {
label values _2snrecruitworkerreciprocity1 yesno
}
else {

}
capture confirm numeric v _3snfindsuppliersliving
if !_rc {
label values _3snfindsuppliersliving living
}
else {

}
capture confirm numeric v _2problemwork1
if !_rc {
label values _2problemwork1 problemwork
}
else {

}
capture confirm numeric v B8
if !_rc {
label values B8 raventest
}
else {

}
capture confirm numeric v _3snrecruitworker
if !_rc {
label values _3snrecruitworker yesnosocialnetwork
}
else {

}
capture confirm numeric v _3Ab12
if !_rc {
label values _3Ab12 raventest
}
else {

}
capture confirm numeric v B10
if !_rc {
label values B10 raventest
}
else {

}
capture confirm numeric v _2A2
if !_rc {
label values _2A2 raventest
}
else {

}
capture confirm numeric v _3sncloserelouthhdistrict
if !_rc {
label values _3sncloserelouthhdistrict district
}
else {

}
capture confirm numeric v _3A3
if !_rc {
label values _3A3 raventest
}
else {

}
capture confirm numeric v _2snrecojobsuccessmeetfrequency
if !_rc {
label values _2snrecojobsuccessmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _3reciprocity1businesslender
if !_rc {
label values _3reciprocity1businesslender yesno
}
else {

}
capture confirm numeric v _2snrecommendassomeetfrequency
if !_rc {
label values _2snrecommendassomeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _3snfindsuppliersemployertype
if !_rc {
label values _3snfindsuppliersemployertype employertype
}
else {

}
capture confirm numeric v _2problemwork2
if !_rc {
label values _2problemwork2 problemwork
}
else {

}
capture confirm numeric v _3searchjob
if !_rc {
label values _3searchjob yesno
}
else {

}
capture confirm numeric v _3A6
if !_rc {
label values _3A6 raventest
}
else {

}
capture confirm numeric v _3executionwork3
if !_rc {
label values _3executionwork3 yesno
}
else {

}
capture confirm numeric v _2discrimination7
if !_rc {
label values _2discrimination7 yesno
}
else {

}
capture confirm numeric v snfindcurrentjobage
if !_rc {
label values snfindcurrentjobage agelist
}
else {

}
capture confirm numeric v _3A8
if !_rc {
label values _3A8 raventest
}
else {

}
capture confirm numeric v snrecommendforjobcastes
if !_rc {
label values snrecommendforjobcastes castes
}
else {

}
capture confirm numeric v locuscontrol5
if !_rc {
label values locuscontrol5 locusscale
}
else {

}
capture confirm numeric v Ab1
if !_rc {
label values Ab1 raventest
}
else {

}
capture confirm numeric v executionwork4
if !_rc {
label values executionwork4 yesno
}
else {

}
capture confirm numeric v _3B12
if !_rc {
label values _3B12 raventest
}
else {

}
capture confirm numeric v _3Ab9
if !_rc {
label values _3Ab9 raventest
}
else {

}
capture confirm numeric v _3educbusinesslender
if !_rc {
label values _3educbusinesslender educlist
}
else {

}
capture confirm numeric v _3sntalkthemostmeetfrequency
if !_rc {
label values _3sntalkthemostmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v Ab12
if !_rc {
label values Ab12 raventest
}
else {

}
capture confirm numeric v _2B8
if !_rc {
label values _2B8 raventest
}
else {

}
capture confirm numeric v _3A11
if !_rc {
label values _3A11 raventest
}
else {

}
capture confirm numeric v _3problemwork1
if !_rc {
label values _3problemwork1 problemwork
}
else {

}
capture confirm numeric v _2snfindcurrentjobfriend
if !_rc {
label values _2snfindcurrentjobfriend yesno
}
else {

}
capture confirm numeric v _2A4
if !_rc {
label values _2A4 raventest
}
else {

}
capture confirm numeric v _3locuscontrol3
if !_rc {
label values _3locuscontrol3 locusscale
}
else {

}
capture confirm numeric v _2wagejobpaymentinkindlist
if !_rc {
label values _2wagejobpaymentinkindlist paymentinkind
}
else {

}
capture confirm numeric v _3Ab11
if !_rc {
label values _3Ab11 raventest
}
else {

}
capture confirm numeric v _3Ab1
if !_rc {
label values _3Ab1 raventest
}
else {

}
capture confirm numeric v _3changework
if !_rc {
label values _3changework yesno
}
else {

}
capture confirm numeric v Ab9
if !_rc {
label values Ab9 raventest
}
else {

}
capture confirm numeric v _2snfindsuppliersinvite
if !_rc {
label values _2snfindsuppliersinvite yesno
}
else {

}
capture confirm numeric v _3sncloserelouthhage
if !_rc {
label values _3sncloserelouthhage agelist
}
else {

}
capture confirm numeric v _3networktrustemployees
if !_rc {
label values _3networktrustemployees personalityandbehavior
}
else {

}
capture confirm numeric v _2snhelpemergencymeetfrequency
if !_rc {
label values _2snhelpemergencymeetfrequency meetfrequency
}
else {

}
capture confirm numeric v executionwork6
if !_rc {
label values executionwork6 yesno
}
else {

}
capture confirm numeric v discrimination5
if !_rc {
label values discrimination5 yesno
}
else {

}
capture confirm numeric v _3snfindsuppliers
if !_rc {
label values _3snfindsuppliers yesnosocialnetwork
}
else {

}
capture confirm numeric v snfindcurrentjobmeetfrequency
if !_rc {
label values snfindcurrentjobmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v snrecojobsuccessmeetfrequency
if !_rc {
label values snrecojobsuccessmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _2snentrustbusinessmeetfrequency
if !_rc {
label values _2snentrustbusinessmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v dummyassorecommendation
if !_rc {
label values dummyassorecommendation yesno
}
else {

}
capture confirm numeric v _3sncloserelouthhsex
if !_rc {
label values _3sncloserelouthhsex sex
}
else {

}
capture confirm numeric v _3snrecommendforjoblabourtype
if !_rc {
label values _3snrecommendforjoblabourtype labourrelation
}
else {

}
capture confirm numeric v snfindsupplierslabourrelation
if !_rc {
label values snfindsupplierslabourrelation yesno
}
else {

}
capture confirm numeric v activeimagination
if !_rc {
label values activeimagination personalityandbehavior
}
else {

}
capture confirm numeric v _3snhelpemergencyage
if !_rc {
label values _3snhelpemergencyage agelist
}
else {

}
capture confirm numeric v _2snfindcurrentjobcompared
if !_rc {
label values _2snfindcurrentjobcompared compared
}
else {

}
capture confirm numeric v _2assohelpbusiness
if !_rc {
label values _2assohelpbusiness assohelpbusiness
}
else {

}
capture confirm numeric v snfindsuppliersreciprocity1
if !_rc {
label values snfindsuppliersreciprocity1 yesno
}
else {

}
capture confirm numeric v _2sncloserelouthhdummyfam
if !_rc {
label values _2sncloserelouthhdummyfam yesno
}
else {

}
capture confirm numeric v _3snrecojobsuccessfriend
if !_rc {
label values _3snrecojobsuccessfriend yesno
}
else {

}
capture confirm numeric v _2wagejobpaymentinkind
if !_rc {
label values _2wagejobpaymentinkind yesno
}
else {

}
capture confirm numeric v reasonnotworkpastyear
if !_rc {
label values reasonnotworkpastyear reasondontsearchjob
}
else {

}
capture confirm numeric v _3locuscontrol2
if !_rc {
label values _3locuscontrol2 locusscale
}
else {

}
capture confirm numeric v covneworktrustneighborhood
if !_rc {
label values covneworktrustneighborhood covidscale
}
else {

}
capture confirm numeric v _3snrecommendassoinvite
if !_rc {
label values _3snrecommendassoinvite yesno
}
else {

}
capture confirm numeric v _3snfindsupplierslabourtype
if !_rc {
label values _3snfindsupplierslabourtype labourrelation
}
else {

}
capture confirm numeric v covlendrepayment
if !_rc {
label values covlendrepayment yesnona
}
else {

}
capture confirm numeric v _3rudetoother
if !_rc {
label values _3rudetoother personalityandbehavior
}
else {

}
capture confirm numeric v snfindcurrentjobfriend
if !_rc {
label values snfindcurrentjobfriend yesno
}
else {

}
capture confirm numeric v _3snentrustbusinessmeetfrequency
if !_rc {
label values _3snentrustbusinessmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _2meetfrequemcybusinesslender
if !_rc {
label values _2meetfrequemcybusinesslender meetfrequency
}
else {

}
capture confirm numeric v salariedjobtype
if !_rc {
label values salariedjobtype typejob
}
else {

}
capture confirm numeric v _2opinionactivewoman
if !_rc {
label values _2opinionactivewoman opinionwork
}
else {

}
capture confirm numeric v _2businesspaymentinkindlist
if !_rc {
label values _2businesspaymentinkindlist paymentinkind
}
else {

}
capture confirm numeric v _2locuscontrol5
if !_rc {
label values _2locuscontrol5 locusscale
}
else {

}
capture confirm numeric v _2sntalkthemostwkp
if !_rc {
label values _2sntalkthemostwkp yesno
}
else {

}
capture confirm numeric v _3accidentalinjury
if !_rc {
label values _3accidentalinjury yesno
}
else {

}
capture confirm numeric v remreceivedfrequency
if !_rc {
label values remreceivedfrequency meetfrequency
}
else {

}
capture confirm numeric v _2snrecommendforjobdummyhh
if !_rc {
label values _2snrecommendforjobdummyhh yesno
}
else {

}
capture confirm numeric v _3shywithpeople
if !_rc {
label values _3shywithpeople personalityandbehavior
}
else {

}
capture confirm numeric v locuscontrol3
if !_rc {
label values locuscontrol3 locusscale
}
else {

}
capture confirm numeric v _3snrecommendforjobeduc
if !_rc {
label values _3snrecommendforjobeduc educlist
}
else {

}
capture confirm numeric v _2networkpeoplehelping
if !_rc {
label values _2networkpeoplehelping personalityandbehavior
}
else {

}
capture confirm numeric v covinstit9
if !_rc {
label values covinstit9 covidscale
}
else {

}
capture confirm numeric v snrecruitworkerdummyhh
if !_rc {
label values snrecruitworkerdummyhh yesno
}
else {

}
capture confirm numeric v snrecommendassomeetfrequency
if !_rc {
label values snrecommendassomeetfrequency meetfrequency
}
else {

}
capture confirm numeric v decisionearnwork
if !_rc {
label values decisionearnwork decisionwork2
}
else {

}
capture confirm numeric v A1
if !_rc {
label values A1 raventest
}
else {

}
capture confirm numeric v covworkeffort
if !_rc {
label values covworkeffort workcovid
}
else {

}
capture confirm numeric v _2networkhelpkinmember
if !_rc {
label values _2networkhelpkinmember personalityandbehavior
}
else {

}
capture confirm numeric v _3businessnbpaidworkers
if !_rc {
label values _3businessnbpaidworkers nbworkers
}
else {

}
capture confirm numeric v jobwagefrequencycash
if !_rc {
label values jobwagefrequencycash frequency5
}
else {

}
capture confirm numeric v _3snhelpemergencyintimacy
if !_rc {
label values _3snhelpemergencyintimacy intimacydegree
}
else {

}
capture confirm numeric v _2sncloserelouthhintimacy
if !_rc {
label values _2sncloserelouthhintimacy intimacydegree
}
else {

}
capture confirm numeric v _3meetfrequemcybusinesslender
if !_rc {
label values _3meetfrequemcybusinesslender meetfrequency
}
else {

}
capture confirm numeric v settleloanstrategy
if !_rc {
label values settleloanstrategy settleloanstrategy
}
else {

}
capture confirm numeric v _2problemwork10
if !_rc {
label values _2problemwork10 problemwork
}
else {

}
capture confirm numeric v sncloserelouthhliving
if !_rc {
label values sncloserelouthhliving living
}
else {

}
capture confirm numeric v _3sncloserelouthhreciprocity1
if !_rc {
label values _3sncloserelouthhreciprocity1 yesno
}
else {

}
capture confirm numeric v marriagetype
if !_rc {
label values marriagetype marriagetype
}
else {

}
capture confirm numeric v _2snfindsupplierswkp
if !_rc {
label values _2snfindsupplierswkp yesno
}
else {

}
capture confirm numeric v _2agreementatwork3
if !_rc {
label values _2agreementatwork3 agreementwork
}
else {

}
capture confirm numeric v _2startbusiness
if !_rc {
label values _2startbusiness yesno
}
else {

}
capture confirm numeric v _3snfindjobage
if !_rc {
label values _3snfindjobage agelist
}
else {

}
capture confirm numeric v _2workexposure1
if !_rc {
label values _2workexposure1 graduation
}
else {

}
capture confirm numeric v _3snentrustbusinessliving
if !_rc {
label values _3snentrustbusinessliving living
}
else {

}
capture confirm numeric v _3snrecojobsuccessinvite
if !_rc {
label values _3snrecojobsuccessinvite yesno
}
else {

}
capture confirm numeric v snhelpemergencyeduc
if !_rc {
label values snhelpemergencyeduc educlist
}
else {

}
capture confirm numeric v snrecommendforjobliving
if !_rc {
label values snrecommendforjobliving living
}
else {

}
capture confirm numeric v _3snrecommendforjobfriend
if !_rc {
label values _3snrecommendforjobfriend yesno
}
else {

}
capture confirm numeric v livingbusinesslender
if !_rc {
label values livingbusinesslender living
}
else {

}
capture confirm numeric v _3sncloserelouthhcompared
if !_rc {
label values _3sncloserelouthhcompared compared
}
else {

}
capture confirm numeric v _2snfindjoblabourtype
if !_rc {
label values _2snfindjoblabourtype labourrelation
}
else {

}
capture confirm numeric v _2snrecommendassoliving
if !_rc {
label values _2snrecommendassoliving living
}
else {

}
capture confirm numeric v snentrustbusinesslabourtype
if !_rc {
label values snentrustbusinesslabourtype labourrelation
}
else {

}
capture confirm numeric v _2snfindcurrentjobeduc
if !_rc {
label values _2snfindcurrentjobeduc educlist
}
else {

}
capture confirm numeric v B5
if !_rc {
label values B5 raventest
}
else {

}
capture confirm numeric v snrecojobsuccessliving
if !_rc {
label values snrecojobsuccessliving living
}
else {

}
capture confirm numeric v toleratefaults
if !_rc {
label values toleratefaults personalityandbehavior
}
else {

}
capture confirm numeric v _3sncloserelouthhliving
if !_rc {
label values _3sncloserelouthhliving living
}
else {

}
capture confirm numeric v _3previousjobcontract
if !_rc {
label values _3previousjobcontract yesno
}
else {

}
capture confirm numeric v _2canreadcard2
if !_rc {
label values _2canreadcard2 literacy2
}
else {

}
capture confirm numeric v _3A4
if !_rc {
label values _3A4 raventest
}
else {

}
capture confirm numeric v canreadcard1b
if !_rc {
label values canreadcard1b literacy2
}
else {

}
capture confirm numeric v lefthomereason
if !_rc {
label values lefthomereason migrationreason
}
else {

}
capture confirm numeric v _2snfindjoblabourrelation
if !_rc {
label values _2snfindjoblabourrelation yesno
}
else {

}
capture confirm numeric v snrecommendassocastes
if !_rc {
label values snrecommendassocastes castes
}
else {

}
capture confirm numeric v migrationskill
if !_rc {
label values migrationskill migrationskill
}
else {

}
capture confirm numeric v _3locuscontrol6
if !_rc {
label values _3locuscontrol6 locusscale
}
else {

}
capture confirm numeric v newtraining
if !_rc {
label values newtraining yesno
}
else {

}
capture confirm numeric v _3easilydistracted
if !_rc {
label values _3easilydistracted personalityandbehavior
}
else {

}
capture confirm numeric v _2previousjobcontract
if !_rc {
label values _2previousjobcontract yesno
}
else {

}
capture confirm numeric v compensation
if !_rc {
label values compensation yesno
}
else {

}
capture confirm numeric v advancebalanceperception
if !_rc {
label values advancebalanceperception unbalancedadvance
}
else {

}
capture confirm numeric v businesslossinvest
if !_rc {
label values businesslossinvest yesno3
}
else {

}
capture confirm numeric v _3snrecruitworkerdummyfam
if !_rc {
label values _3snrecruitworkerdummyfam yesno
}
else {

}
capture confirm numeric v B1
if !_rc {
label values B1 raventest
}
else {

}
capture confirm numeric v _2snentrustbusinesscompared
if !_rc {
label values _2snentrustbusinesscompared compared
}
else {

}
capture confirm numeric v _2problemwork4
if !_rc {
label values _2problemwork4 problemwork
}
else {

}
capture confirm numeric v snfindcurrentjoblabourtype
if !_rc {
label values snfindcurrentjoblabourtype labourrelation
}
else {

}
capture confirm numeric v _3snentrustbusinesslabourtype
if !_rc {
label values _3snentrustbusinesslabourtype labourrelation
}
else {

}
capture confirm numeric v _3snfindjoblabourtype
if !_rc {
label values _3snfindjoblabourtype labourrelation
}
else {

}
capture confirm numeric v _2sncloserelouthhwkp
if !_rc {
label values _2sncloserelouthhwkp yesno
}
else {

}
capture confirm numeric v Ab3
if !_rc {
label values Ab3 raventest
}
else {

}
capture confirm numeric v _3sncloserelouthhlabourtype
if !_rc {
label values _3sncloserelouthhlabourtype labourrelation
}
else {

}
capture confirm numeric v ego2random_2_2
if !_rc {
label values ego2random_2_2 yesno
}
else {

}
capture confirm numeric v _3problemwork2
if !_rc {
label values _3problemwork2 problemwork
}
else {

}
capture confirm numeric v after10thstandard
if !_rc {
label values after10thstandard post10thstandard
}
else {

}
capture confirm numeric v _2A7
if !_rc {
label values _2A7 raventest
}
else {

}
capture confirm numeric v lenderscastegold
if !_rc {
label values lenderscastegold casteemployer
}
else {

}
capture confirm numeric v discrimination3
if !_rc {
label values discrimination3 yesno
}
else {

}
capture confirm numeric v professionalequipment
if !_rc {
label values professionalequipment graduation
}
else {

}
capture confirm numeric v snfindsuppliersdummyhh
if !_rc {
label values snfindsuppliersdummyhh yesno
}
else {

}
capture confirm numeric v _2sncloserelouthhreciprocity1
if !_rc {
label values _2sncloserelouthhreciprocity1 yesno
}
else {

}
capture confirm numeric v migrationchild
if !_rc {
label values migrationchild yesno
}
else {

}
capture confirm numeric v _2sncloserelouthhage
if !_rc {
label values _2sncloserelouthhage agelist
}
else {

}
capture confirm numeric v _2discrimination8
if !_rc {
label values _2discrimination8 yesno
}
else {

}
capture confirm numeric v snfindcurrentjobintimacy
if !_rc {
label values snfindcurrentjobintimacy intimacydegree
}
else {

}
capture confirm numeric v howpaymarriage
if !_rc {
label values howpaymarriage howpaymarriage
}
else {

}
capture confirm numeric v _3snrecommendforjobmeetfrequency
if !_rc {
label values _3snrecommendforjobmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _2snentrustbusinessdummyfam
if !_rc {
label values _2snentrustbusinessdummyfam yesno
}
else {

}
capture confirm numeric v _2snrecruitworkerfriend
if !_rc {
label values _2snrecruitworkerfriend yesno
}
else {

}
capture confirm numeric v _2takeholiday
if !_rc {
label values _2takeholiday satisfaction4
}
else {

}
capture confirm numeric v _2snfindcurrentjobintimacy
if !_rc {
label values _2snfindcurrentjobintimacy intimacydegree
}
else {

}
capture confirm numeric v _3problemwork9
if !_rc {
label values _3problemwork9 problemwork
}
else {

}
capture confirm numeric v schedule
if !_rc {
label values schedule satisfaction3
}
else {

}
capture confirm numeric v lenderrelation
if !_rc {
label values lenderrelation relation
}
else {

}
capture confirm numeric v _3snrecruitworkerdummyhh
if !_rc {
label values _3snrecruitworkerdummyhh yesno
}
else {

}
capture confirm numeric v _3executionwork2
if !_rc {
label values _3executionwork2 yesno
}
else {

}
capture confirm numeric v _2snrecommendforjobintimacy
if !_rc {
label values _2snrecommendforjobintimacy intimacydegree
}
else {

}
capture confirm numeric v _2repetitivetasks
if !_rc {
label values _2repetitivetasks personalityandbehavior
}
else {

}
capture confirm numeric v _2snentrustbusinesssex
if !_rc {
label values _2snentrustbusinesssex sex
}
else {

}
capture confirm numeric v _3businessnbunpaidworkers
if !_rc {
label values _3businessnbunpaidworkers nbworkers
}
else {

}
capture confirm numeric v snhelpemergencyintimacy
if !_rc {
label values snhelpemergencyintimacy intimacydegree
}
else {

}
capture confirm numeric v snrecruitworkerintimacy
if !_rc {
label values snrecruitworkerintimacy intimacydegree
}
else {

}
capture confirm numeric v B7
if !_rc {
label values B7 raventest
}
else {

}
capture confirm numeric v _3snrecruitworkerwkp
if !_rc {
label values _3snrecruitworkerwkp yesno
}
else {

}
capture confirm numeric v _2assodegreeparticip
if !_rc {
label values _2assodegreeparticip assodegreeparticip
}
else {

}
capture confirm numeric v snentrustbusinessintimacy
if !_rc {
label values snentrustbusinessintimacy intimacydegree
}
else {

}
capture confirm numeric v _3wagejobtype
if !_rc {
label values _3wagejobtype typejob
}
else {

}
capture confirm numeric v A2
if !_rc {
label values A2 raventest
}
else {

}
capture confirm numeric v _3trustingofother
if !_rc {
label values _3trustingofother personalityandbehavior
}
else {

}
capture confirm numeric v snfindcurrentjobwkp
if !_rc {
label values snfindcurrentjobwkp yesno
}
else {

}
capture confirm numeric v snrecommendassofriend
if !_rc {
label values snrecommendassofriend yesno
}
else {

}
capture confirm numeric v _2problemwork8
if !_rc {
label values _2problemwork8 problemwork
}
else {

}
capture confirm numeric v sntalkthemostreciprocity1
if !_rc {
label values sntalkthemostreciprocity1 yesno
}
else {

}
capture confirm numeric v Ab2
if !_rc {
label values Ab2 raventest
}
else {

}
capture confirm numeric v _2locuscontrol1
if !_rc {
label values _2locuscontrol1 locusscale
}
else {

}
capture confirm numeric v _2executionwork9
if !_rc {
label values _2executionwork9 yesno
}
else {

}
capture confirm numeric v _2snhelpemergencylabourtype
if !_rc {
label values _2snhelpemergencylabourtype labourrelation
}
else {

}
capture confirm numeric v _2covinstit8
if !_rc {
label values _2covinstit8 covidscale
}
else {

}
capture confirm numeric v dummyadvancebalance
if !_rc {
label values dummyadvancebalance yesno
}
else {

}
capture confirm numeric v _3locuscontrol5
if !_rc {
label values _3locuscontrol5 locusscale
}
else {

}
capture confirm numeric v _2snfindcurrentjobwkp
if !_rc {
label values _2snfindcurrentjobwkp yesno
}
else {

}
capture confirm numeric v purposeloanborrower
if !_rc {
label values purposeloanborrower reasonborrowing
}
else {

}
capture confirm numeric v _3sntalkthemostemployertype
if !_rc {
label values _3sntalkthemostemployertype employertype
}
else {

}
capture confirm numeric v covcontactinstitution
if !_rc {
label values covcontactinstitution institution
}
else {

}
capture confirm numeric v _2covcontactinstitution
if !_rc {
label values _2covcontactinstitution institution
}
else {

}
capture confirm numeric v completeduties
if !_rc {
label values completeduties personalityandbehavior
}
else {

}
capture confirm numeric v _3professionalequipment
if !_rc {
label values _3professionalequipment graduation
}
else {

}
capture confirm numeric v _3workexposure5
if !_rc {
label values _3workexposure5 graduation
}
else {

}
capture confirm numeric v _2workexposure3
if !_rc {
label values _2workexposure3 graduation
}
else {

}
capture confirm numeric v reasondontsearchjobsince15
if !_rc {
label values reasondontsearchjobsince15 reasondontsearchjob
}
else {

}
capture confirm numeric v migrationdurationfrequency
if !_rc {
label values migrationdurationfrequency migrationduration
}
else {

}
capture confirm numeric v _2snrecruitworkerage
if !_rc {
label values _2snrecruitworkerage agelist
}
else {

}
capture confirm numeric v helptosettleloan
if !_rc {
label values helptosettleloan relation3
}
else {

}
capture confirm numeric v _2professionalequipment
if !_rc {
label values _2professionalequipment graduation
}
else {

}
capture confirm numeric v _2easilydistracted
if !_rc {
label values _2easilydistracted personalityandbehavior
}
else {

}
capture confirm numeric v _2liketothink
if !_rc {
label values _2liketothink personalityandbehavior
}
else {

}
capture confirm numeric v migrationwagetype
if !_rc {
label values migrationwagetype wagetype
}
else {

}
capture confirm numeric v _2snrecommendforjobwkp
if !_rc {
label values _2snrecommendforjobwkp yesno
}
else {

}
capture confirm numeric v workexposure3
if !_rc {
label values workexposure3 graduation
}
else {

}
capture confirm numeric v _2snhelpemergencyliving
if !_rc {
label values _2snhelpemergencyliving living
}
else {

}
capture confirm numeric v _3B5
if !_rc {
label values _3B5 raventest
}
else {

}
capture confirm numeric v _3workexposure1
if !_rc {
label values _3workexposure1 graduation
}
else {

}
capture confirm numeric v _3snrecojobsuccessdummyfam
if !_rc {
label values _3snrecojobsuccessdummyfam yesno
}
else {

}
capture confirm numeric v dummyloanfromborrower
if !_rc {
label values dummyloanfromborrower yesno
}
else {

}
capture confirm numeric v _2businesslossinvest
if !_rc {
label values _2businesslossinvest yesno3
}
else {

}
capture confirm numeric v keepworking
if !_rc {
label values keepworking personalityandbehavior
}
else {

}
capture confirm numeric v _2A8
if !_rc {
label values _2A8 raventest
}
else {

}
capture confirm numeric v _3snfindcurrentjobdummyfam
if !_rc {
label values _3snfindcurrentjobdummyfam yesno
}
else {

}
capture confirm numeric v _3opinionworkingwoman
if !_rc {
label values _3opinionworkingwoman opinionwork
}
else {

}
capture confirm numeric v _2feeldepressed
if !_rc {
label values _2feeldepressed personalityandbehavior
}
else {

}
capture confirm numeric v _2snfindcurrentjobmeetfrequency
if !_rc {
label values _2snfindcurrentjobmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _2frequencygrossreceipt
if !_rc {
label values _2frequencygrossreceipt frequency
}
else {

}
capture confirm numeric v _2numeracy3
if !_rc {
label values _2numeracy3 numeracy
}
else {

}
capture confirm numeric v businesslabourerwagetype
if !_rc {
label values businesslabourerwagetype wagetype
}
else {

}
capture confirm numeric v _2snentrustbusinessfriend
if !_rc {
label values _2snentrustbusinessfriend yesno
}
else {

}
capture confirm numeric v rationcarduse
if !_rc {
label values rationcarduse yesno
}
else {

}
capture confirm numeric v resdiscrimination4
if !_rc {
label values resdiscrimination4 yesno
}
else {

}
capture confirm numeric v _2problemwork5
if !_rc {
label values _2problemwork5 problemwork
}
else {

}
capture confirm numeric v _3resdiscrimination1
if !_rc {
label values _3resdiscrimination1 yesno
}
else {

}
capture confirm numeric v _2A10
if !_rc {
label values _2A10 raventest
}
else {

}
capture confirm numeric v _3discrimination8
if !_rc {
label values _3discrimination8 yesno
}
else {

}
capture confirm numeric v _3snrecojobsuccessemployertype
if !_rc {
label values _3snrecojobsuccessemployertype employertype
}
else {

}
capture confirm numeric v sncloserelouthhage
if !_rc {
label values sncloserelouthhage agelist
}
else {

}
capture confirm numeric v _2sncloserelouthheduc
if !_rc {
label values _2sncloserelouthheduc educlist
}
else {

}
capture confirm numeric v snfindsuppliersruralurban
if !_rc {
label values snfindsuppliersruralurban rural
}
else {

}
capture confirm numeric v _3satisfactionsalary
if !_rc {
label values _3satisfactionsalary satisfaction4
}
else {

}
capture confirm numeric v _3snentrustbusinesslabourrelation
if !_rc {
label values _3snentrustbusinesslabourrelation yesno
}
else {

}
capture confirm numeric v snfindcurrentjobemployertype
if !_rc {
label values snfindcurrentjobemployertype employertype
}
else {

}
capture confirm numeric v snrecojobsuccessemployertype
if !_rc {
label values snrecojobsuccessemployertype employertype
}
else {

}
capture confirm numeric v lenderfrom
if !_rc {
label values lenderfrom lenderfrom
}
else {

}
capture confirm numeric v castespouse
if !_rc {
label values castespouse castes
}
else {

}
capture confirm numeric v _3snentrustbusinessemployertype
if !_rc {
label values _3snentrustbusinessemployertype employertype
}
else {

}
capture confirm numeric v _3snhelpemergencyruralurban
if !_rc {
label values _3snhelpemergencyruralurban rural
}
else {

}
capture confirm numeric v _2snentrustbusinessemployertype
if !_rc {
label values _2snentrustbusinessemployertype employertype
}
else {

}
capture confirm numeric v _3snrecojobsuccesslabourrelation
if !_rc {
label values _3snrecojobsuccesslabourrelation yesno
}
else {

}
capture confirm numeric v _3snfindsupplierslabourrelation
if !_rc {
label values _3snfindsupplierslabourrelation yesno
}
else {

}
capture confirm numeric v everwork
if !_rc {
label values everwork yesno
}
else {

}
capture confirm numeric v _2searchjob
if !_rc {
label values _2searchjob yesno
}
else {

}
capture confirm numeric v _3snfindjobruralurban
if !_rc {
label values _3snfindjobruralurban rural
}
else {

}
capture confirm numeric v _3problemwork8
if !_rc {
label values _3problemwork8 problemwork
}
else {

}
capture confirm numeric v snfindjoblabourtype
if !_rc {
label values snfindjoblabourtype labourrelation
}
else {

}
capture confirm numeric v _2snfindcurrentjobruralurban
if !_rc {
label values _2snfindcurrentjobruralurban rural
}
else {

}
capture confirm numeric v _2snhelpemergencyemployertype
if !_rc {
label values _2snhelpemergencyemployertype employertype
}
else {

}
capture confirm numeric v A12
if !_rc {
label values A12 raventest
}
else {

}
capture confirm numeric v _2snfindsupplierscompared
if !_rc {
label values _2snfindsupplierscompared compared
}
else {

}
capture confirm numeric v _3snfindsuppliersmeet
if !_rc {
label values _3snfindsuppliersmeet meet
}
else {

}
capture confirm numeric v _3snentrustbusinesssex
if !_rc {
label values _3snentrustbusinesssex sex
}
else {

}
capture confirm numeric v _2snfindsuppliersmeetfrequency
if !_rc {
label values _2snfindsuppliersmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v loanreasongiven2
if !_rc {
label values loanreasongiven2 reasonborrowing
}
else {

}
capture confirm numeric v _2snentrustbusinessintimacy
if !_rc {
label values _2snentrustbusinessintimacy intimacydegree
}
else {

}
capture confirm numeric v dummymarriagegift
if !_rc {
label values dummymarriagegift yesno
}
else {

}
capture confirm numeric v _2snfindsuppliersliving
if !_rc {
label values _2snfindsuppliersliving living
}
else {

}
capture confirm numeric v snentrustbusinessdistrict
if !_rc {
label values snentrustbusinessdistrict district
}
else {

}
capture confirm numeric v goaftergoal
if !_rc {
label values goaftergoal personalityandbehavior
}
else {

}
capture confirm numeric v _2snrecojobsuccessemployertype
if !_rc {
label values _2snrecojobsuccessemployertype employertype
}
else {

}
capture confirm numeric v snrecommendforjobeduc
if !_rc {
label values snrecommendforjobeduc educlist
}
else {

}
capture confirm numeric v _3snfindsupplierseduc
if !_rc {
label values _3snfindsupplierseduc educlist
}
else {

}
capture confirm numeric v _3snrecojobsuccesseduc
if !_rc {
label values _3snrecojobsuccesseduc educlist
}
else {

}
capture confirm numeric v sntalkthemostlabourrelation
if !_rc {
label values sntalkthemostlabourrelation yesno
}
else {

}
capture confirm numeric v religionspouse
if !_rc {
label values religionspouse religion
}
else {

}
capture confirm numeric v _2snrecommendforjobeduc
if !_rc {
label values _2snrecommendforjobeduc educlist
}
else {

}
capture confirm numeric v _3workmate
if !_rc {
label values _3workmate satisfaction
}
else {

}
capture confirm numeric v _2snhelpemergencyreciprocity1
if !_rc {
label values _2snhelpemergencyreciprocity1 yesno
}
else {

}
capture confirm numeric v _2snrecruitworkermeetfrequency
if !_rc {
label values _2snrecruitworkermeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _2snrecommendassoeduc
if !_rc {
label values _2snrecommendassoeduc educlist
}
else {

}
capture confirm numeric v _3snrecommendforjobdistrict
if !_rc {
label values _3snrecommendforjobdistrict district
}
else {

}
capture confirm numeric v _2snhelpemergencyeduc
if !_rc {
label values _2snhelpemergencyeduc educlist
}
else {

}
capture confirm numeric v _2problemwork9
if !_rc {
label values _2problemwork9 problemwork
}
else {

}
capture confirm numeric v snentrustbusinessreciprocity1
if !_rc {
label values snentrustbusinessreciprocity1 yesno
}
else {

}
capture confirm numeric v snrecojobsuccesssex
if !_rc {
label values snrecojobsuccesssex sex
}
else {

}
capture confirm numeric v _2snentrustbusinessdistrict
if !_rc {
label values _2snentrustbusinessdistrict district
}
else {

}
capture confirm numeric v wagejobnbworker
if !_rc {
label values wagejobnbworker nbworkers2
}
else {

}
capture confirm numeric v reservation
if !_rc {
label values reservation yesno
}
else {

}
capture confirm numeric v _3snrecojobsuccessruralurban
if !_rc {
label values _3snrecojobsuccessruralurban rural
}
else {

}
capture confirm numeric v _3executionwork9
if !_rc {
label values _3executionwork9 yesno
}
else {

}
capture confirm numeric v villagearea
if !_rc {
label values villagearea villagearea
}
else {

}
capture confirm numeric v canread
if !_rc {
label values canread yesno
}
else {

}
capture confirm numeric v dummybusinessunpaidworkers
if !_rc {
label values dummybusinessunpaidworkers yesno
}
else {

}
capture confirm numeric v _3covinstit1
if !_rc {
label values _3covinstit1 covinstit
}
else {

}
capture confirm numeric v dummyscholarship
if !_rc {
label values dummyscholarship yesno
}
else {

}
capture confirm numeric v _3snrecommendassofriend
if !_rc {
label values _3snrecommendassofriend yesno
}
else {

}
capture confirm numeric v _3agreementatwork3
if !_rc {
label values _3agreementatwork3 agreementwork
}
else {

}
capture confirm numeric v _3sexualaggression
if !_rc {
label values _3sexualaggression sexualagression
}
else {

}
capture confirm numeric v _3B8
if !_rc {
label values _3B8 raventest
}
else {

}
capture confirm numeric v subjectsafter10th
if !_rc {
label values subjectsafter10th subjects
}
else {

}
capture confirm numeric v agreementatwork2
if !_rc {
label values agreementatwork2 agreementwork
}
else {

}
capture confirm numeric v _3snrecojobsuccesswkp
if !_rc {
label values _3snrecojobsuccesswkp yesno
}
else {

}
capture confirm numeric v _2snfindsuppliersage
if !_rc {
label values _2snfindsuppliersage agelist
}
else {

}
capture confirm numeric v _2snrecojobsuccesssex
if !_rc {
label values _2snrecojobsuccesssex sex
}
else {

}
capture confirm numeric v _3snhelpemergencymeet
if !_rc {
label values _3snhelpemergencymeet meet
}
else {

}
capture confirm numeric v _2retirementwork
if !_rc {
label values _2retirementwork yesno
}
else {

}
capture confirm numeric v sncloserelouthhlabourrelation
if !_rc {
label values sncloserelouthhlabourrelation yesno
}
else {

}
capture confirm numeric v lackskill
if !_rc {
label values lackskill yesno
}
else {

}
capture confirm numeric v _3Ab5
if !_rc {
label values _3Ab5 raventest
}
else {

}
capture confirm numeric v snfindsuppliersmeetfrequency
if !_rc {
label values snfindsuppliersmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _2wagejobsocialsecurity
if !_rc {
label values _2wagejobsocialsecurity yesno
}
else {

}
capture confirm numeric v snrecruitworkerlabourtype
if !_rc {
label values snrecruitworkerlabourtype labourrelation
}
else {

}
capture confirm numeric v _2snrecojobsuccessintimacy
if !_rc {
label values _2snrecojobsuccessintimacy intimacydegree
}
else {

}
capture confirm numeric v snhelpemergencydistrict
if !_rc {
label values snhelpemergencydistrict district
}
else {

}
capture confirm numeric v remreceivedservices
if !_rc {
label values remreceivedservices otherlenderservices
}
else {

}
capture confirm numeric v _2snrecommendassofriend
if !_rc {
label values _2snrecommendassofriend yesno
}
else {

}
capture confirm numeric v _3searchjobsince15
if !_rc {
label values _3searchjobsince15 yesno
}
else {

}
capture confirm numeric v covinstit3
if !_rc {
label values covinstit3 covinstit
}
else {

}
capture confirm numeric v _2B9
if !_rc {
label values _2B9 raventest
}
else {

}
capture confirm numeric v _2executionwork3
if !_rc {
label values _2executionwork3 yesno
}
else {

}
capture confirm numeric v _3snrecommendassodistrict
if !_rc {
label values _3snrecommendassodistrict district
}
else {

}
capture confirm numeric v sex_new
if !_rc {
label values sex_new sex
}
else {

}
capture confirm numeric v snrecommendassoliving
if !_rc {
label values snrecommendassoliving living
}
else {

}
capture confirm numeric v _3snhelpemergencyeduc
if !_rc {
label values _3snhelpemergencyeduc educlist
}
else {

}
capture confirm numeric v loanproductpledge
if !_rc {
label values loanproductpledge productpledge
}
else {

}
capture confirm numeric v newideas
if !_rc {
label values newideas personalityandbehavior
}
else {

}
capture confirm numeric v _3businesspaymentinkind
if !_rc {
label values _3businesspaymentinkind yesno
}
else {

}
capture confirm numeric v _2sntalkthemostdistrict
if !_rc {
label values _2sntalkthemostdistrict district
}
else {

}
capture confirm numeric v decisionwork
if !_rc {
label values decisionwork decisionwork
}
else {

}
capture confirm numeric v _2decisionwork
if !_rc {
label values _2decisionwork decisionwork
}
else {

}
capture confirm numeric v snfindcurrentjobreciprocity1
if !_rc {
label values snfindcurrentjobreciprocity1 yesno
}
else {

}
capture confirm numeric v _2covinstit7
if !_rc {
label values _2covinstit7 covidscale
}
else {

}
capture confirm numeric v _2snfindsuppliersintimacy
if !_rc {
label values _2snfindsuppliersintimacy intimacydegree
}
else {

}
capture confirm numeric v _3covinstit2
if !_rc {
label values _3covinstit2 covinstit
}
else {

}
capture confirm numeric v lenderfromgold
if !_rc {
label values lenderfromgold lenderfrom
}
else {

}
capture confirm numeric v _2snrecommendassodummyhh
if !_rc {
label values _2snrecommendassodummyhh yesno
}
else {

}
capture confirm numeric v _3snrecommendassomeetfrequency
if !_rc {
label values _3snrecommendassomeetfrequency meetfrequency
}
else {

}
capture confirm numeric v Ab4
if !_rc {
label values Ab4 raventest
}
else {

}
capture confirm numeric v _3covinstit4
if !_rc {
label values _3covinstit4 covinstit
}
else {

}
capture confirm numeric v _2covinstit4
if !_rc {
label values _2covinstit4 covinstit
}
else {

}
capture confirm numeric v _2discrimination3
if !_rc {
label values _2discrimination3 yesno
}
else {

}
capture confirm numeric v executionwork7
if !_rc {
label values executionwork7 yesno
}
else {

}
capture confirm numeric v _2snfindcurrentjob
if !_rc {
label values _2snfindcurrentjob yesnosocialnetwork
}
else {

}
capture confirm numeric v _2covinstit5
if !_rc {
label values _2covinstit5 covinstit
}
else {

}
capture confirm numeric v _3snfindjobwkp
if !_rc {
label values _3snfindjobwkp yesno
}
else {

}
capture confirm numeric v covinstit1
if !_rc {
label values covinstit1 covinstit
}
else {

}
capture confirm numeric v typewageemployer
if !_rc {
label values typewageemployer employertype
}
else {

}
capture confirm numeric v _2snfindjobdummyfam
if !_rc {
label values _2snfindjobdummyfam yesno
}
else {

}
capture confirm numeric v _2sntalkthemostreciprocity1
if !_rc {
label values _2sntalkthemostreciprocity1 yesno
}
else {

}
capture confirm numeric v _2curious
if !_rc {
label values _2curious personalityandbehavior
}
else {

}
capture confirm numeric v _2interestedbyart
if !_rc {
label values _2interestedbyart personalityandbehavior
}
else {

}
capture confirm numeric v _2snfindsupplierscastes
if !_rc {
label values _2snfindsupplierscastes castes
}
else {

}
capture confirm numeric v _2Ab6
if !_rc {
label values _2Ab6 raventest
}
else {

}
capture confirm numeric v _2satisfyingpurpose
if !_rc {
label values _2satisfyingpurpose satisfaction2
}
else {

}
capture confirm numeric v discrimination1
if !_rc {
label values discrimination1 yesno
}
else {

}
capture confirm numeric v covnetworkhelpkinmember
if !_rc {
label values covnetworkhelpkinmember covidscale
}
else {

}
capture confirm numeric v _2methodfindfirstjob
if !_rc {
label values _2methodfindfirstjob methodfindjob
}
else {

}
capture confirm numeric v additionalloan
if !_rc {
label values additionalloan yesno
}
else {

}
capture confirm numeric v workmate
if !_rc {
label values workmate satisfaction
}
else {

}
capture confirm numeric v _2Ab10
if !_rc {
label values _2Ab10 raventest
}
else {

}
capture confirm numeric v _3A9
if !_rc {
label values _3A9 raventest
}
else {

}
capture confirm numeric v rudetoother
if !_rc {
label values rudetoother personalityandbehavior
}
else {

}
capture confirm numeric v worryalot
if !_rc {
label values worryalot personalityandbehavior
}
else {

}
capture confirm numeric v currentlyatschool
if !_rc {
label values currentlyatschool yesno
}
else {

}
capture confirm numeric v _3discrimination1
if !_rc {
label values _3discrimination1 yesno
}
else {

}
capture confirm numeric v reciprocity1businesslender
if !_rc {
label values reciprocity1businesslender yesno
}
else {

}
capture confirm numeric v _2snrecruitworkerdummyhh
if !_rc {
label values _2snrecruitworkerdummyhh yesno
}
else {

}
capture confirm numeric v sntalkthemostcastes
if !_rc {
label values sntalkthemostcastes castes
}
else {

}
capture confirm numeric v _2problemwork6
if !_rc {
label values _2problemwork6 problemwork
}
else {

}
capture confirm numeric v _2sexualaggression
if !_rc {
label values _2sexualaggression sexualagression
}
else {

}
capture confirm numeric v _3sntalkthemostreciprocity1
if !_rc {
label values _3sntalkthemostreciprocity1 yesno
}
else {

}
capture confirm numeric v snrecruitworkermeetfrequency
if !_rc {
label values snrecruitworkermeetfrequency meetfrequency
}
else {

}
capture confirm numeric v marriagearranged
if !_rc {
label values marriagearranged yesno
}
else {

}
capture confirm numeric v _3comparedbusinesslender
if !_rc {
label values _3comparedbusinesslender compared
}
else {

}
capture confirm numeric v _2snentrustbusinessreciprocity1
if !_rc {
label values _2snentrustbusinessreciprocity1 yesno
}
else {

}
capture confirm numeric v _2jobwagefrequencycash
if !_rc {
label values _2jobwagefrequencycash frequency5
}
else {

}
capture confirm numeric v _2sntalkthemostcompared
if !_rc {
label values _2sntalkthemostcompared compared
}
else {

}
capture confirm numeric v _2snhelpemergencycompared
if !_rc {
label values _2snhelpemergencycompared compared
}
else {

}
capture confirm numeric v _3snrecommendforjobage
if !_rc {
label values _3snrecommendforjobage agelist
}
else {

}
capture confirm numeric v snentrustbusinessmeetfrequency
if !_rc {
label values snentrustbusinessmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v sntalkthemostruralurban
if !_rc {
label values sntalkthemostruralurban rural
}
else {

}
capture confirm numeric v _3snhelpemergencydummyhh
if !_rc {
label values _3snhelpemergencydummyhh yesno
}
else {

}
capture confirm numeric v _2snfindjobeduc
if !_rc {
label values _2snfindjobeduc educlist
}
else {

}
capture confirm numeric v borrowerssex
if !_rc {
label values borrowerssex sex
}
else {

}
capture confirm numeric v _3A1
if !_rc {
label values _3A1 raventest
}
else {

}
capture confirm numeric v _3Ab6
if !_rc {
label values _3Ab6 raventest
}
else {

}
capture confirm numeric v _3snfindjobcompared
if !_rc {
label values _3snfindjobcompared compared
}
else {

}
capture confirm numeric v A4
if !_rc {
label values A4 raventest
}
else {

}
capture confirm numeric v _3snfindcurrentjobsex
if !_rc {
label values _3snfindcurrentjobsex sex
}
else {

}
capture confirm numeric v _3snentrustbusinesswkp
if !_rc {
label values _3snentrustbusinesswkp yesno
}
else {

}
capture confirm numeric v _3sntalkthemostmeet
if !_rc {
label values _3sntalkthemostmeet meet
}
else {

}
capture confirm numeric v wagejobpaymentinkindlist
if !_rc {
label values wagejobpaymentinkindlist paymentinkind
}
else {

}
capture confirm numeric v sncloserelouthhinvite
if !_rc {
label values sncloserelouthhinvite yesno
}
else {

}
capture confirm numeric v _3snrecruitworkercompared
if !_rc {
label values _3snrecruitworkercompared compared
}
else {

}
capture confirm numeric v _2snrecommendforjobcompared
if !_rc {
label values _2snrecommendforjobcompared compared
}
else {

}
capture confirm numeric v _3snrecommendforjobcompared
if !_rc {
label values _3snrecommendforjobcompared compared
}
else {

}
capture confirm numeric v _2dummyseasonalmainoccup
if !_rc {
label values _2dummyseasonalmainoccup yesno
}
else {

}
*capture confirm numeric v username
*if !_rc {
*label values username username
*}
*else {
*
*}
capture confirm numeric v snrecommendforjobcompared
if !_rc {
label values snrecommendforjobcompared compared
}
else {

}
capture confirm numeric v nbercontactphone
if !_rc {
label values nbercontactphone nbercontactphone
}
else {

}
capture confirm numeric v interestedbyart
if !_rc {
label values interestedbyart personalityandbehavior
}
else {

}
capture confirm numeric v _3problemwork7
if !_rc {
label values _3problemwork7 problemwork
}
else {

}
capture confirm numeric v snhelpemergencycastes
if !_rc {
label values snhelpemergencycastes castes
}
else {

}
capture confirm numeric v snrecruitworkercastes
if !_rc {
label values snrecruitworkercastes castes
}
else {

}
capture confirm numeric v _3appointmentontime
if !_rc {
label values _3appointmentontime personalityandbehavior
}
else {

}
capture confirm numeric v _2A5
if !_rc {
label values _2A5 raventest
}
else {

}
capture confirm numeric v _3sntalkthemostfriend
if !_rc {
label values _3sntalkthemostfriend yesno
}
else {

}
capture confirm numeric v _3executionwork7
if !_rc {
label values _3executionwork7 yesno
}
else {

}
capture confirm numeric v _3snfindsupplierswkp
if !_rc {
label values _3snfindsupplierswkp yesno
}
else {

}
capture confirm numeric v jobfirstwagefrequencycash
if !_rc {
label values jobfirstwagefrequencycash frequency5
}
else {

}
capture confirm numeric v A8
if !_rc {
label values A8 raventest
}
else {

}
capture confirm numeric v snhelpemergencydummyfam
if !_rc {
label values snhelpemergencydummyfam yesno
}
else {

}
capture confirm numeric v _2snrecojobsuccesscastes
if !_rc {
label values _2snrecojobsuccesscastes castes
}
else {

}
capture confirm numeric v _2discrimination5
if !_rc {
label values _2discrimination5 yesno
}
else {

}
capture confirm numeric v snrecojobsuccessage
if !_rc {
label values snrecojobsuccessage agelist
}
else {

}
capture confirm numeric v _3takeholiday
if !_rc {
label values _3takeholiday satisfaction4
}
else {

}
capture confirm numeric v snrecojobsuccesslabourrelation
if !_rc {
label values snrecojobsuccesslabourrelation yesno
}
else {

}
capture confirm numeric v _3snfindsuppliersintimacy
if !_rc {
label values _3snfindsuppliersintimacy intimacydegree
}
else {

}
capture confirm numeric v _3snrecojobsuccessreciprocity1
if !_rc {
label values _3snrecojobsuccessreciprocity1 yesno
}
else {

}
capture confirm numeric v _2appointmentontime
if !_rc {
label values _2appointmentontime personalityandbehavior
}
else {

}
capture confirm numeric v _3snrecojobsuccessintimacy
if !_rc {
label values _3snrecojobsuccessintimacy intimacydegree
}
else {

}
capture confirm numeric v _3snrecommendassoemployertype
if !_rc {
label values _3snrecommendassoemployertype employertype
}
else {

}
capture confirm numeric v _3wagejobpaymentinkindlist
if !_rc {
label values _3wagejobpaymentinkindlist paymentinkind
}
else {

}
capture confirm numeric v businesslabourerbonus
if !_rc {
label values businesslabourerbonus yesno
}
else {

}
capture confirm numeric v _2covinstit10
if !_rc {
label values _2covinstit10 covidscale
}
else {

}
capture confirm numeric v _3snrecommendassocastes
if !_rc {
label values _3snrecommendassocastes castes
}
else {

}
capture confirm numeric v _2sntalkthemostmeetfrequency
if !_rc {
label values _2sntalkthemostmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _3snfindjoblabourrelation
if !_rc {
label values _3snfindjoblabourrelation yesno
}
else {

}
capture confirm numeric v marriagespousefamily
if !_rc {
label values marriagespousefamily  compared
}
else {

}
capture confirm numeric v accidentalinjury
if !_rc {
label values accidentalinjury yesno
}
else {

}
capture confirm numeric v _2losswork
if !_rc {
label values _2losswork yesno
}
else {

}
capture confirm numeric v sntalkthemostage
if !_rc {
label values sntalkthemostage agelist
}
else {

}
capture confirm numeric v _3snrecommendassoruralurban
if !_rc {
label values _3snrecommendassoruralurban rural
}
else {

}
capture confirm numeric v _3sncloserelouthhcastes
if !_rc {
label values _3sncloserelouthhcastes castes
}
else {

}
capture confirm numeric v _3verbalaggression
if !_rc {
label values _3verbalaggression graduation2
}
else {

}
capture confirm numeric v _3sncloserelouthhinvite
if !_rc {
label values _3sncloserelouthhinvite yesno
}
else {

}
capture confirm numeric v _2snfindjob
if !_rc {
label values _2snfindjob yesnosocialnetwork
}
else {

}
capture confirm numeric v Ab5
if !_rc {
label values Ab5 raventest
}
else {

}
capture confirm numeric v _3snfindjobemployertype
if !_rc {
label values _3snfindjobemployertype employertype
}
else {

}
capture confirm numeric v _2workexposure2
if !_rc {
label values _2workexposure2 graduation
}
else {

}
capture confirm numeric v snrecommendassoreciprocity1
if !_rc {
label values snrecommendassoreciprocity1 yesno
}
else {

}
capture confirm numeric v _3snrecojobsuccessdistrict
if !_rc {
label values _3snrecojobsuccessdistrict district
}
else {

}
capture confirm numeric v joblocation
if !_rc {
label values joblocation migrationplace2
}
else {

}
capture confirm numeric v makeplans
if !_rc {
label values makeplans personalityandbehavior
}
else {

}
capture confirm numeric v _2assohelpjob
if !_rc {
label values _2assohelpjob assohelpjob
}
else {

}
capture confirm numeric v _3snrecommendassoeduc
if !_rc {
label values _3snrecommendassoeduc educlist
}
else {

}
capture confirm numeric v _3assohelpbusiness
if !_rc {
label values _3assohelpbusiness assohelpbusiness
}
else {

}
capture confirm numeric v _3finishtasks
if !_rc {
label values _3finishtasks personalityandbehavior
}
else {

}
capture confirm numeric v sntalkthemostintimacy
if !_rc {
label values sntalkthemostintimacy intimacydegree
}
else {

}
capture confirm numeric v _3assodegreeparticip
if !_rc {
label values _3assodegreeparticip assodegreeparticip
}
else {

}
capture confirm numeric v snfindsuppliersinvite
if !_rc {
label values snfindsuppliersinvite yesno
}
else {

}
capture confirm numeric v remsentoccup
if !_rc {
label values remsentoccup occuplist2
}
else {

}
capture confirm numeric v _3snrecommendforjobcastes
if !_rc {
label values _3snrecommendforjobcastes castes
}
else {

}
capture confirm numeric v easilydistracted
if !_rc {
label values easilydistracted personalityandbehavior
}
else {

}
capture confirm numeric v _2nbermonthsearchjob
if !_rc {
label values _2nbermonthsearchjob nbermonth
}
else {

}
capture confirm numeric v _2executionwork5
if !_rc {
label values _2executionwork5 yesno
}
else {

}
capture confirm numeric v _2agreementatwork2
if !_rc {
label values _2agreementatwork2 agreementwork
}
else {

}
capture confirm numeric v _3agreementatwork2
if !_rc {
label values _3agreementatwork2 agreementwork
}
else {

}
capture confirm numeric v Ab11
if !_rc {
label values Ab11 raventest
}
else {

}
capture confirm numeric v B3
if !_rc {
label values B3 raventest
}
else {

}
capture confirm numeric v snrecojobsuccessinvite
if !_rc {
label values snrecojobsuccessinvite yesno
}
else {

}
capture confirm numeric v snhelpemergencyinvite
if !_rc {
label values snhelpemergencyinvite yesno
}
else {

}
capture confirm numeric v snfindsupplierscastes
if !_rc {
label values snfindsupplierscastes castes
}
else {

}
capture confirm numeric v snrecommendforjobage
if !_rc {
label values snrecommendforjobage agelist
}
else {

}
capture confirm numeric v _3snrecruitworkerinvite
if !_rc {
label values _3snrecruitworkerinvite yesno
}
else {

}
capture confirm numeric v _3dummycontactleaders
if !_rc {
label values _3dummycontactleaders yesno
}
else {

}
capture confirm numeric v _3forgiveother
if !_rc {
label values _3forgiveother personalityandbehavior
}
else {

}
capture confirm numeric v _2snhelpemergencywkp
if !_rc {
label values _2snhelpemergencywkp yesno
}
else {

}
capture confirm numeric v _3frequencygrossreceipt
if !_rc {
label values _3frequencygrossreceipt frequency
}
else {

}
capture confirm numeric v migrationpension
if !_rc {
label values migrationpension yesno
}
else {

}
capture confirm numeric v snrecommendassoinvite
if !_rc {
label values snrecommendassoinvite yesno
}
else {

}
capture confirm numeric v _2A6
if !_rc {
label values _2A6 raventest
}
else {

}
capture confirm numeric v snrecruitworkersex
if !_rc {
label values snrecruitworkersex sex
}
else {

}
capture confirm numeric v _3snentrustbusinessage
if !_rc {
label values _3snentrustbusinessage agelist
}
else {

}
capture confirm numeric v snrecruitworkercompared
if !_rc {
label values snrecruitworkercompared compared
}
else {

}
capture confirm numeric v _3canreadcard1c
if !_rc {
label values _3canreadcard1c literacy2
}
else {

}
capture confirm numeric v _3snrecruitworkerintimacy
if !_rc {
label values _3snrecruitworkerintimacy intimacydegree
}
else {

}
capture confirm numeric v snrecommendassoruralurban
if !_rc {
label values snrecommendassoruralurban rural
}
else {

}
capture confirm numeric v sharefeelings
if !_rc {
label values sharefeelings personalityandbehavior
}
else {

}
capture confirm numeric v _2snhelpemergencydistrict
if !_rc {
label values _2snhelpemergencydistrict district
}
else {

}
capture confirm numeric v _3sntalkthemostcompared
if !_rc {
label values _3sntalkthemostcompared compared
}
else {

}
capture confirm numeric v _2snentrustbusinessage
if !_rc {
label values _2snentrustbusinessage agelist
}
else {

}
capture confirm numeric v snfindcurrentjob
if !_rc {
label values snfindcurrentjob yesnosocialnetwork
}
else {

}
capture confirm numeric v dummybacktovillage
if !_rc {
label values dummybacktovillage yesno
}
else {

}
capture confirm numeric v _3snrecruitworkerage
if !_rc {
label values _3snrecruitworkerage agelist
}
else {

}
capture confirm numeric v _3jobpreference
if !_rc {
label values _3jobpreference jobpreference
}
else {

}
capture confirm numeric v _2Ab9
if !_rc {
label values _2Ab9 raventest
}
else {

}
capture confirm numeric v _3enthusiastic
if !_rc {
label values _3enthusiastic personalityandbehavior
}
else {

}
capture confirm numeric v insurancetype2
if !_rc {
label values insurancetype2 insurancetype2
}
else {

}
capture confirm numeric v A10
if !_rc {
label values A10 raventest
}
else {

}
capture confirm numeric v _2B12
if !_rc {
label values _2B12 raventest
}
else {

}
capture confirm numeric v snrecruitworkereduc
if !_rc {
label values snrecruitworkereduc educlist
}
else {

}
capture confirm numeric v snrecojobsuccessreciprocity1
if !_rc {
label values snrecojobsuccessreciprocity1 yesno
}
else {

}
capture confirm numeric v _3snrecommendassointimacy
if !_rc {
label values _3snrecommendassointimacy intimacydegree
}
else {

}
capture confirm numeric v wagejobtype
if !_rc {
label values wagejobtype typejob
}
else {

}
capture confirm numeric v _3snrecommendassowkp
if !_rc {
label values _3snrecommendassowkp yesno
}
else {

}
capture confirm numeric v _3ego2random_3
if !_rc {
label values _3ego2random_3 yesno
}
else {

}
capture confirm numeric v _2contract
if !_rc {
label values _2contract contracttype
}
else {

}
capture confirm numeric v A11
if !_rc {
label values A11 raventest
}
else {

}
capture confirm numeric v _3workexposure2
if !_rc {
label values _3workexposure2 graduation
}
else {

}
capture confirm numeric v covinstit6
if !_rc {
label values covinstit6 covidscale
}
else {

}
capture confirm numeric v reasonneverattendedschool
if !_rc {
label values reasonneverattendedschool reasonneverattendedschool
}
else {

}
capture confirm numeric v _3executionwork5
if !_rc {
label values _3executionwork5 yesno
}
else {

}
capture confirm numeric v snrecommendassoeduc
if !_rc {
label values snrecommendassoeduc educlist
}
else {

}
capture confirm numeric v _2snfindsuppliersdummyfam
if !_rc {
label values _2snfindsuppliersdummyfam yesno
}
else {

}
capture confirm numeric v remreceivedmoney
if !_rc {
label values remreceivedmoney yesno
}
else {

}
capture confirm numeric v frequencygrossreceipt
if !_rc {
label values frequencygrossreceipt frequency
}
else {

}
capture confirm numeric v B11
if !_rc {
label values B11 raventest
}
else {

}
capture confirm numeric v _2snrecommendassomeet
if !_rc {
label values _2snrecommendassomeet meet
}
else {

}
capture confirm numeric v snrecommendforjobreciprocity1
if !_rc {
label values snrecommendforjobreciprocity1 yesno
}
else {

}
capture confirm numeric v _2snrecommendforjobreciprocity1
if !_rc {
label values _2snrecommendforjobreciprocity1 yesno
}
else {

}
capture confirm numeric v _2canreadcard1a
if !_rc {
label values _2canreadcard1a literacy2
}
else {

}
capture confirm numeric v searchjob
if !_rc {
label values searchjob yesno
}
else {

}
capture confirm numeric v Ab6
if !_rc {
label values Ab6 raventest
}
else {

}
capture confirm numeric v guaranteetype
if !_rc {
label values guaranteetype guaranteetype
}
else {

}
capture confirm numeric v loanreasongiven
if !_rc {
label values loanreasongiven reasonborrowing
}
else {

}
capture confirm numeric v dummycontactleaders
if !_rc {
label values dummycontactleaders yesno
}
else {

}
capture confirm numeric v _2snrecommendassointimacy
if !_rc {
label values _2snrecommendassointimacy intimacydegree
}
else {

}
capture confirm numeric v _2B4
if !_rc {
label values _2B4 raventest
}
else {

}
capture confirm numeric v feeldepressed
if !_rc {
label values feeldepressed personalityandbehavior
}
else {

}
capture confirm numeric v _3reasonstoppedwagejob
if !_rc {
label values _3reasonstoppedwagejob reasonstoppedjob
}
else {

}
capture confirm numeric v sncloserelouthhreciprocity1
if !_rc {
label values sncloserelouthhreciprocity1 yesno
}
else {

}
capture confirm numeric v _3snhelpemergencyinvite
if !_rc {
label values _3snhelpemergencyinvite yesno
}
else {

}
capture confirm numeric v salariedjobpension
if !_rc {
label values salariedjobpension yesno
}
else {

}
capture confirm numeric v _3sncloserelouthhdummyfam
if !_rc {
label values _3sncloserelouthhdummyfam yesno
}
else {

}
capture confirm numeric v _2covnetworkhelpkinmember
if !_rc {
label values _2covnetworkhelpkinmember covidscale
}
else {

}
capture confirm numeric v _3B6
if !_rc {
label values _3B6 raventest
}
else {

}
capture confirm numeric v _2snentrustbusinessdummyhh
if !_rc {
label values _2snentrustbusinessdummyhh yesno
}
else {

}
capture confirm numeric v sexualharassment
if !_rc {
label values sexualharassment yesno
}
else {

}
capture confirm numeric v easilyupset
if !_rc {
label values easilyupset personalityandbehavior
}
else {

}
capture confirm numeric v snrecommendassoage
if !_rc {
label values snrecommendassoage agelist
}
else {

}
capture confirm numeric v _3snfindcurrentjoblabourrelation
if !_rc {
label values _3snfindcurrentjoblabourrelation yesno
}
else {

}
capture confirm numeric v _2snhelpemergencyfriend
if !_rc {
label values _2snhelpemergencyfriend yesno
}
else {

}
capture confirm numeric v _2snrecruitworkereduc
if !_rc {
label values _2snrecruitworkereduc educlist
}
else {

}
capture confirm numeric v _2snfindjobcastes
if !_rc {
label values _2snfindjobcastes castes
}
else {

}
capture confirm numeric v _3snfindcurrentjobinvite
if !_rc {
label values _3snfindcurrentjobinvite yesno
}
else {

}
capture confirm numeric v sntalkthemostlabourtype
if !_rc {
label values sntalkthemostlabourtype labourrelation
}
else {

}
capture confirm numeric v _3Ab4
if !_rc {
label values _3Ab4 raventest
}
else {

}
capture confirm numeric v _2snrecruitworkerlabourrelation
if !_rc {
label values _2snrecruitworkerlabourrelation yesno
}
else {

}
capture confirm numeric v snrecommendforjobdummyfam
if !_rc {
label values snrecommendforjobdummyfam yesno
}
else {

}
capture confirm numeric v _2snrecruitworkercastes
if !_rc {
label values _2snrecruitworkercastes castes
}
else {

}
capture confirm numeric v _3snrecommendforjobdummyfam
if !_rc {
label values _3snrecommendforjobdummyfam yesno
}
else {

}
capture confirm numeric v snrecommendforjobmeet
if !_rc {
label values snrecommendforjobmeet meet
}
else {

}
capture confirm numeric v canreadcard2
if !_rc {
label values canreadcard2 literacy2
}
else {

}
capture confirm numeric v snentrustbusinesswkp
if !_rc {
label values snentrustbusinesswkp yesno
}
else {

}
capture confirm numeric v dummycreditcard
if !_rc {
label values dummycreditcard yesno
}
else {

}
capture confirm numeric v sncloserelouthhintimacy
if !_rc {
label values sncloserelouthhintimacy intimacydegree
}
else {

}
capture confirm numeric v nervous
if !_rc {
label values nervous personalityandbehavior
}
else {

}
capture confirm numeric v sncloserelouthhemployertype
if !_rc {
label values sncloserelouthhemployertype employertype
}
else {

}
capture confirm numeric v dummyremreceived
if !_rc {
label values dummyremreceived yesno
}
else {

}
capture confirm numeric v _2locuscontrol6
if !_rc {
label values _2locuscontrol6 locusscale
}
else {

}
capture confirm numeric v everworksalaried
if !_rc {
label values everworksalaried yesno
}
else {

}
capture confirm numeric v _2snrecojobsuccesswkp
if !_rc {
label values _2snrecojobsuccesswkp yesno
}
else {

}
capture confirm numeric v _2workexposure4
if !_rc {
label values _2workexposure4 graduation
}
else {

}
capture confirm numeric v jobpreference
if !_rc {
label values jobpreference jobpreference
}
else {

}
capture confirm numeric v _3talkative
if !_rc {
label values _3talkative personalityandbehavior
}
else {

}
capture confirm numeric v _3snhelpemergencymeetfrequency
if !_rc {
label values _3snhelpemergencymeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _3contract
if !_rc {
label values _3contract contracttype
}
else {

}
capture confirm numeric v loaneffectivereason2
if !_rc {
label values loaneffectivereason2 reasonborrowing
}
else {

}
capture confirm numeric v sntalkthemostinvite
if !_rc {
label values sntalkthemostinvite yesno
}
else {

}
capture confirm numeric v dummypermanentmigrantwork
if !_rc {
label values dummypermanentmigrantwork yesno
}
else {

}
capture confirm numeric v moveoutsideforjob
if !_rc {
label values moveoutsideforjob yesno
}
else {

}
capture confirm numeric v snentrustbusinesscompared
if !_rc {
label values snentrustbusinesscompared compared
}
else {

}
capture confirm numeric v _2educbusinesslender
if !_rc {
label values _2educbusinesslender educlist
}
else {

}
capture confirm numeric v snrecruitworkerruralurban
if !_rc {
label values snrecruitworkerruralurban rural
}
else {

}
capture confirm numeric v searchjobsince15
if !_rc {
label values searchjobsince15 yesno
}
else {

}
capture confirm numeric v _2snrecommendforjoblabourrelation
if !_rc {
label values _2snrecommendforjoblabourrelation yesno
}
else {

}
capture confirm numeric v _3snrecommendassocompared
if !_rc {
label values _3snrecommendassocompared compared
}
else {

}
capture confirm numeric v snfindsuppliersmeet
if !_rc {
label values snfindsuppliersmeet meet
}
else {

}
capture confirm numeric v reasondontsearchjob
if !_rc {
label values reasondontsearchjob reasondontsearchjob
}
else {

}
capture confirm numeric v _3completeduties
if !_rc {
label values _3completeduties personalityandbehavior
}
else {

}
capture confirm numeric v covinstit7
if !_rc {
label values covinstit7 covidscale
}
else {

}
capture confirm numeric v snrecommendforjobintimacy
if !_rc {
label values snrecommendforjobintimacy intimacydegree
}
else {

}
capture confirm numeric v _2satisfactionsalary
if !_rc {
label values _2satisfactionsalary satisfaction4
}
else {

}
capture confirm numeric v _3snentrustbusinessinvite
if !_rc {
label values _3snentrustbusinessinvite yesno
}
else {

}
capture confirm numeric v _3talktomanypeople
if !_rc {
label values _3talktomanypeople personalityandbehavior
}
else {

}
capture confirm numeric v dummyseasonalmainoccup
if !_rc {
label values dummyseasonalmainoccup yesno
}
else {

}
capture confirm numeric v remsentfrequency
if !_rc {
label values remsentfrequency meetfrequency
}
else {

}
capture confirm numeric v _3snfindcurrentjobemployertype
if !_rc {
label values _3snfindcurrentjobemployertype employertype
}
else {

}
capture confirm numeric v appointmentontime
if !_rc {
label values appointmentontime personalityandbehavior
}
else {

}
capture confirm numeric v _2snrecojobsuccessfriend
if !_rc {
label values _2snrecojobsuccessfriend yesno
}
else {

}
capture confirm numeric v snfindsupplierseduc
if !_rc {
label values snfindsupplierseduc educlist
}
else {

}
capture confirm numeric v _3finishwhatbegin
if !_rc {
label values _3finishwhatbegin personalityandbehavior
}
else {

}
capture confirm numeric v _2A1
if !_rc {
label values _2A1 raventest
}
else {

}
capture confirm numeric v _2snrecommendforjobage
if !_rc {
label values _2snrecommendforjobage agelist
}
else {

}
capture confirm numeric v covinstit2
if !_rc {
label values covinstit2 covinstit
}
else {

}
capture confirm numeric v _3snhelpemergencydistrict
if !_rc {
label values _3snhelpemergencydistrict district
}
else {

}
capture confirm numeric v sncloserelouthheduc
if !_rc {
label values sncloserelouthheduc educlist
}
else {

}
capture confirm numeric v _3snentrustbusinessdistrict
if !_rc {
label values _3snentrustbusinessdistrict district
}
else {

}
capture confirm numeric v covinstit8
if !_rc {
label values covinstit8 covidscale
}
else {

}
capture confirm numeric v durationafter10th
if !_rc {
label values durationafter10th durationafter10thstandard
}
else {

}
capture confirm numeric v _3businesslossinvest
if !_rc {
label values _3businesslossinvest yesno3
}
else {

}
capture confirm numeric v networkhelpkinmember
if !_rc {
label values networkhelpkinmember personalityandbehavior
}
else {

}
capture confirm numeric v _3nervous
if !_rc {
label values _3nervous personalityandbehavior
}
else {

}
capture confirm numeric v _2snrecommendassolabourrelation
if !_rc {
label values _2snrecommendassolabourrelation yesno
}
else {

}
capture confirm numeric v _2snrecruitworkerinvite
if !_rc {
label values _2snrecruitworkerinvite yesno
}
else {

}
capture confirm numeric v _3covinstit6
if !_rc {
label values _3covinstit6 covidscale
}
else {

}
capture confirm numeric v _3snhelpemergencydummyfam
if !_rc {
label values _3snhelpemergencydummyfam yesno
}
else {

}
capture confirm numeric v covlending
if !_rc {
label values covlending covlending
}
else {

}
capture confirm numeric v businesssocialsecurity
if !_rc {
label values businesssocialsecurity yesno
}
else {

}
capture confirm numeric v _2goaftergoal
if !_rc {
label values _2goaftergoal personalityandbehavior
}
else {

}
capture confirm numeric v snhelpemergencyliving
if !_rc {
label values snhelpemergencyliving living
}
else {

}
capture confirm numeric v snentrustbusinessinvite
if !_rc {
label values snentrustbusinessinvite yesno
}
else {

}
capture confirm numeric v _3snfindjobintimacy
if !_rc {
label values _3snfindjobintimacy intimacydegree
}
else {

}
capture confirm numeric v _2sntalkthemostintimacy
if !_rc {
label values _2sntalkthemostintimacy intimacydegree
}
else {

}
capture confirm numeric v dummymigration
if !_rc {
label values dummymigration yesno
}
else {

}
capture confirm numeric v _3businesssocialsecurity
if !_rc {
label values _3businesssocialsecurity yesno
}
else {

}
capture confirm numeric v _3interestedbyart
if !_rc {
label values _3interestedbyart personalityandbehavior
}
else {

}
capture confirm numeric v _2snhelpemergencylabourrelation
if !_rc {
label values _2snhelpemergencylabourrelation yesno
}
else {

}
capture confirm numeric v _2covdifficulties
if !_rc {
label values _2covdifficulties difficultycovid
}
else {

}
capture confirm numeric v _2snrecruitworkerruralurban
if !_rc {
label values _2snrecruitworkerruralurban rural
}
else {

}
capture confirm numeric v numeracy2
if !_rc {
label values numeracy2 numeracy
}
else {

}
capture confirm numeric v snrecruitworkerdistrict
if !_rc {
label values snrecruitworkerdistrict district
}
else {

}
capture confirm numeric v _2numeracy5
if !_rc {
label values _2numeracy5 numeracy
}
else {

}
capture confirm numeric v _3discrimination9
if !_rc {
label values _3discrimination9 yesno
}
else {

}
capture confirm numeric v B6
if !_rc {
label values B6 raventest
}
else {

}
capture confirm numeric v _2snfindcurrentjobreciprocity1
if !_rc {
label values _2snfindcurrentjobreciprocity1 yesno
}
else {

}
capture confirm numeric v _3snrecommendforjobliving
if !_rc {
label values _3snrecommendforjobliving living
}
else {

}
capture confirm numeric v _2B7
if !_rc {
label values _2B7 raventest
}
else {

}
capture confirm numeric v snfindcurrentjobinvite
if !_rc {
label values snfindcurrentjobinvite yesno
}
else {

}
capture confirm numeric v _3Ab10
if !_rc {
label values _3Ab10 raventest
}
else {

}
capture confirm numeric v _2snfindcurrentjobemployertype
if !_rc {
label values _2snfindcurrentjobemployertype employertype
}
else {

}
capture confirm numeric v _2everwork
if !_rc {
label values _2everwork yesno
}
else {

}
capture confirm numeric v _3snhelpemergencycastes
if !_rc {
label values _3snhelpemergencycastes castes
}
else {

}
capture confirm numeric v _3snrecojobsuccesssex
if !_rc {
label values _3snrecojobsuccesssex sex
}
else {

}
capture confirm numeric v B12
if !_rc {
label values B12 raventest
}
else {

}
capture confirm numeric v methodfindfirstjob
if !_rc {
label values methodfindfirstjob methodfindjob
}
else {

}
capture confirm numeric v _2snrecojobsuccessliving
if !_rc {
label values _2snrecojobsuccessliving living
}
else {

}
capture confirm numeric v _2respect
if !_rc {
label values _2respect satisfaction
}
else {

}
capture confirm numeric v chitfundtype
if !_rc {
label values chitfundtype chitfundtype
}
else {

}
capture confirm numeric v locuscontrol2
if !_rc {
label values locuscontrol2 locusscale
}
else {

}
capture confirm numeric v remreceivedsourceoccup
if !_rc {
label values remreceivedsourceoccup occuplist2
}
else {

}
capture confirm numeric v _3readystartjob
if !_rc {
label values _3readystartjob yesno
}
else {

}
capture confirm numeric v satisfyingpurpose
if !_rc {
label values satisfyingpurpose satisfaction2
}
else {

}
capture confirm numeric v _3tryhard
if !_rc {
label values _3tryhard personalityandbehavior
}
else {

}
capture confirm numeric v _3goaftergoal
if !_rc {
label values _3goaftergoal personalityandbehavior
}
else {

}
capture confirm numeric v workexposure1
if !_rc {
label values workexposure1 graduation
}
else {

}
capture confirm numeric v decisiondropping
if !_rc {
label values decisiondropping decisioneducation
}
else {

}
capture confirm numeric v sntalkthemostmeetfrequency
if !_rc {
label values sntalkthemostmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _2snrecruitworkercompared
if !_rc {
label values _2snrecruitworkercompared compared
}
else {

}
capture confirm numeric v _2snrecommendassoage
if !_rc {
label values _2snrecommendassoage agelist
}
else {

}
capture confirm numeric v _3snfindcurrentjobeduc
if !_rc {
label values _3snfindcurrentjobeduc educlist
}
else {

}
capture confirm numeric v _3jobfirstwagefrequencycash
if !_rc {
label values _3jobfirstwagefrequencycash frequency5
}
else {

}
capture confirm numeric v _3workwithother
if !_rc {
label values _3workwithother personalityandbehavior
}
else {

}
capture confirm numeric v _2covinstit6
if !_rc {
label values _2covinstit6 covidscale
}
else {

}
capture confirm numeric v _2covinstit2
if !_rc {
label values _2covinstit2 covinstit
}
else {

}
capture confirm numeric v _2sntalkthemostruralurban
if !_rc {
label values _2sntalkthemostruralurban rural
}
else {

}
capture confirm numeric v _3snrecommendassodummyhh
if !_rc {
label values _3snrecommendassodummyhh yesno
}
else {

}
capture confirm numeric v snentrustbusinessdummyhh
if !_rc {
label values snentrustbusinessdummyhh yesno
}
else {

}
capture confirm numeric v _2nbercontactphone
if !_rc {
label values _2nbercontactphone nbercontactphone
}
else {

}
capture confirm numeric v dummychitfund
if !_rc {
label values dummychitfund yesno
}
else {

}
capture confirm numeric v _3snentrustbusinessreciprocity1
if !_rc {
label values _3snentrustbusinessreciprocity1 yesno
}
else {

}
capture confirm numeric v _3sntalkthemostsex
if !_rc {
label values _3sntalkthemostsex sex
}
else {

}
capture confirm numeric v everattendedschool
if !_rc {
label values everattendedschool yesno
}
else {

}
capture confirm numeric v reasonstoppedwagejob
if !_rc {
label values reasonstoppedwagejob reasonstoppedjob
}
else {

}
capture confirm numeric v agreementatwork1
if !_rc {
label values agreementatwork1 agreementwork
}
else {

}
capture confirm numeric v _2talktomanypeople
if !_rc {
label values _2talktomanypeople personalityandbehavior
}
else {

}
capture confirm numeric v _2agebusinesslender
if !_rc {
label values _2agebusinesslender agelist
}
else {

}
capture confirm numeric v snfindsuppliers
if !_rc {
label values snfindsuppliers yesnosocialnetwork
}
else {

}
capture confirm numeric v _3A7
if !_rc {
label values _3A7 raventest
}
else {

}
capture confirm numeric v migrationjobtype2
if !_rc {
label values migrationjobtype2 typejob2
}
else {

}
capture confirm numeric v _3satisfyingpurpose
if !_rc {
label values _3satisfyingpurpose satisfaction2
}
else {

}
capture confirm numeric v _3sncloserelouthhwkp
if !_rc {
label values _3sncloserelouthhwkp yesno
}
else {

}
capture confirm numeric v _3snhelpemergencysex
if !_rc {
label values _3snhelpemergencysex sex
}
else {

}
capture confirm numeric v _2snrecommendassoinvite
if !_rc {
label values _2snrecommendassoinvite yesno
}
else {

}
capture confirm numeric v guarantee
if !_rc {
label values guarantee guarantee
}
else {

}
capture confirm numeric v _2snrecommendassocastes
if !_rc {
label values _2snrecommendassocastes castes
}
else {

}
capture confirm numeric v snrecojobsuccesscompared
if !_rc {
label values snrecojobsuccesscompared compared
}
else {

}
capture confirm numeric v _3resdiscrimination5
if !_rc {
label values _3resdiscrimination5 yesno
}
else {

}
capture confirm numeric v _3break
if !_rc {
label values _3break yesno
}
else {

}
capture confirm numeric v resdiscrimination3
if !_rc {
label values resdiscrimination3 yesno
}
else {

}
capture confirm numeric v _2snrecommendassodistrict
if !_rc {
label values _2snrecommendassodistrict district
}
else {

}
capture confirm numeric v locuscontrol1
if !_rc {
label values locuscontrol1 locusscale
}
else {

}
capture confirm numeric v _2snrecommendforjobsex
if !_rc {
label values _2snrecommendforjobsex sex
}
else {

}
capture confirm numeric v snfindjobfriend
if !_rc {
label values snfindjobfriend yesno
}
else {

}
capture confirm numeric v _3snentrustbusinessfriend
if !_rc {
label values _3snentrustbusinessfriend yesno
}
else {

}
capture confirm numeric v _3sntalkthemosteduc
if !_rc {
label values _3sntalkthemosteduc educlist
}
else {

}
capture confirm numeric v _3dummyassohelpbusiness
if !_rc {
label values _3dummyassohelpbusiness yesno
}
else {

}
capture confirm numeric v _3snrecruitworkeremployertype
if !_rc {
label values _3snrecruitworkeremployertype employertype
}
else {

}
capture confirm numeric v _2resdiscrimination4
if !_rc {
label values _2resdiscrimination4 yesno
}
else {

}
capture confirm numeric v workhard
if !_rc {
label values workhard personalityandbehavior
}
else {

}
capture confirm numeric v liketothink
if !_rc {
label values liketothink personalityandbehavior
}
else {

}
capture confirm numeric v _2snfindsupplierslabourrelation
if !_rc {
label values _2snfindsupplierslabourrelation yesno
}
else {

}
capture confirm numeric v _3snhelpemergencyemployertype
if !_rc {
label values _3snhelpemergencyemployertype employertype
}
else {

}
capture confirm numeric v recommenddetailscaste
if !_rc {
label values recommenddetailscaste castes
}
else {

}
capture confirm numeric v _2executionwork4
if !_rc {
label values _2executionwork4 yesno
}
else {

}
capture confirm numeric v discrimination7
if !_rc {
label values discrimination7 yesno
}
else {

}
capture confirm numeric v snrecommendforjobsex
if !_rc {
label values snrecommendforjobsex sex
}
else {

}
capture confirm numeric v _3snrecommendforjobwkp
if !_rc {
label values _3snrecommendforjobwkp yesno
}
else {

}
capture confirm numeric v _3nbercontactphone
if !_rc {
label values _3nbercontactphone nbercontactphone
}
else {

}
capture confirm numeric v _3ego2random_2_2
if !_rc {
label values _3ego2random_2_2 yesno
}
else {

}
capture confirm numeric v marriageloanlendersex
if !_rc {
label values marriageloanlendersex sex
}
else {

}
capture confirm numeric v snrecruitworkerreciprocity1
if !_rc {
label values snrecruitworkerreciprocity1 yesno
}
else {

}
capture confirm numeric v _2snfindcurrentjoblabourtype
if !_rc {
label values _2snfindcurrentjoblabourtype labourrelation
}
else {

}
capture confirm numeric v reservationkind
if !_rc {
label values reservationkind reservation
}
else {

}
capture confirm numeric v _3covinstit9
if !_rc {
label values _3covinstit9 covidscale
}
else {

}
capture confirm numeric v _2snrecruitworkeremployertype
if !_rc {
label values _2snrecruitworkeremployertype employertype
}
else {

}
capture confirm numeric v _3snfindcurrentjobdistrict
if !_rc {
label values _3snfindcurrentjobdistrict district
}
else {

}
capture confirm numeric v snrecommendassoemployertype
if !_rc {
label values snrecommendassoemployertype employertype
}
else {

}
capture confirm numeric v ego2random_1_3
if !_rc {
label values ego2random_1_3 yesno
}
else {

}
capture confirm numeric v executionwork8
if !_rc {
label values executionwork8 yesno
}
else {

}
capture confirm numeric v sntalkthemostliving
if !_rc {
label values sntalkthemostliving living
}
else {

}
capture confirm numeric v snrecojobsuccessfriend
if !_rc {
label values snrecojobsuccessfriend yesno
}
else {

}
capture confirm numeric v _2snrecommendassosex
if !_rc {
label values _2snrecommendassosex sex
}
else {

}
capture confirm numeric v snfindcurrentjobsex
if !_rc {
label values snfindcurrentjobsex sex
}
else {

}
capture confirm numeric v _2changework
if !_rc {
label values _2changework yesno
}
else {

}
capture confirm numeric v _3snrecruitworkerlabourrelation
if !_rc {
label values _3snrecruitworkerlabourrelation yesno
}
else {

}
capture confirm numeric v useknowledgeatwork
if !_rc {
label values useknowledgeatwork satisfaction
}
else {

}
capture confirm numeric v covinstit4
if !_rc {
label values covinstit4 covinstit
}
else {

}
capture confirm numeric v _2enthusiastic
if !_rc {
label values _2enthusiastic personalityandbehavior
}
else {

}
capture confirm numeric v _2Ab12
if !_rc {
label values _2Ab12 raventest
}
else {

}
capture confirm numeric v dummycastespouse
if !_rc {
label values dummycastespouse yesno
}
else {

}
capture confirm numeric v A7
if !_rc {
label values A7 raventest
}
else {

}
capture confirm numeric v _2snhelpemergencydummyhh
if !_rc {
label values _2snhelpemergencydummyhh yesno
}
else {

}
capture confirm numeric v covremreceived
if !_rc {
label values covremreceived covidscale
}
else {

}
capture confirm numeric v _2snfindsupplierssex
if !_rc {
label values _2snfindsupplierssex sex
}
else {

}
capture confirm numeric v _3snrecojobsuccesscompared
if !_rc {
label values _3snrecojobsuccesscompared compared
}
else {

}
capture confirm numeric v _3covdifficulties
if !_rc {
label values _3covdifficulties difficultycovid
}
else {

}
capture confirm numeric v snfindjobmeetfrequency
if !_rc {
label values snfindjobmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v covamountinterest
if !_rc {
label values covamountinterest covidscale
}
else {

}
capture confirm numeric v _2moveoutsideforjob
if !_rc {
label values _2moveoutsideforjob yesno
}
else {

}
capture confirm numeric v _3A12
if !_rc {
label values _3A12 raventest
}
else {

}
capture confirm numeric v snfindjobemployertype
if !_rc {
label values snfindjobemployertype employertype
}
else {

}
capture confirm numeric v migrationtype
if !_rc {
label values migrationtype migrationtype
}
else {

}
capture confirm numeric v _3snfindsuppliersfriend
if !_rc {
label values _3snfindsuppliersfriend yesno
}
else {

}
capture confirm numeric v _3snfindsuppliersdistrict
if !_rc {
label values _3snfindsuppliersdistrict district
}
else {

}
capture confirm numeric v relationwithborrower
if !_rc {
label values relationwithborrower relation3
}
else {

}
capture confirm numeric v problemwork2
if !_rc {
label values problemwork2 problemwork
}
else {

}
capture confirm numeric v _3snhelpemergencyliving
if !_rc {
label values _3snhelpemergencyliving living
}
else {

}
capture confirm numeric v _3resdiscrimination3
if !_rc {
label values _3resdiscrimination3 yesno
}
else {

}
capture confirm numeric v _3sncloserelouthhintimacy
if !_rc {
label values _3sncloserelouthhintimacy intimacydegree
}
else {

}
capture confirm numeric v previousjobcontract
if !_rc {
label values previousjobcontract yesno
}
else {

}
capture confirm numeric v businesslabourerinsurance
if !_rc {
label values businesslabourerinsurance yesno
}
else {

}
capture confirm numeric v _3moveoutsideforjob
if !_rc {
label values _3moveoutsideforjob yesno
}
else {

}
capture confirm numeric v _3snfindjobdummyhh
if !_rc {
label values _3snfindjobdummyhh yesno
}
else {

}
capture confirm numeric v _3sntalkthemostdistrict
if !_rc {
label values _3sntalkthemostdistrict district
}
else {

}
capture confirm numeric v snentrustbusinesseduc
if !_rc {
label values snentrustbusinesseduc educlist
}
else {

}
capture confirm numeric v _3snfindjobmeet
if !_rc {
label values _3snfindjobmeet meet
}
else {

}
capture confirm numeric v _3covnetworkpeoplehelping
if !_rc {
label values _3covnetworkpeoplehelping covidscale
}
else {

}
capture confirm numeric v _3toleratefaults
if !_rc {
label values _3toleratefaults personalityandbehavior
}
else {

}
capture confirm numeric v _2locuscontrol2
if !_rc {
label values _2locuscontrol2 locusscale
}
else {

}
capture confirm numeric v _3snfindcurrentjobmeetfrequency
if !_rc {
label values _3snfindcurrentjobmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v snfindcurrentjobdistrict
if !_rc {
label values snfindcurrentjobdistrict district
}
else {

}
capture confirm numeric v snhelpemergencycompared
if !_rc {
label values snhelpemergencycompared compared
}
else {

}
capture confirm numeric v _2dummyassohelpbusiness
if !_rc {
label values _2dummyassohelpbusiness yesno
}
else {

}
capture confirm numeric v snfindjobdummyfam
if !_rc {
label values snfindjobdummyfam yesno
}
else {

}
capture confirm numeric v managestress
if !_rc {
label values managestress personalityandbehavior
}
else {

}
capture confirm numeric v _3snfindsupplierssex
if !_rc {
label values _3snfindsupplierssex sex
}
else {

}
capture confirm numeric v snfindcurrentjobliving
if !_rc {
label values snfindcurrentjobliving living
}
else {

}
capture confirm numeric v ego2random_3_3
if !_rc {
label values ego2random_3_3 yesno
}
else {

}
capture confirm numeric v businesscastebased
if !_rc {
label values businesscastebased yesno
}
else {

}
capture confirm numeric v snfindsupplierswkp
if !_rc {
label values snfindsupplierswkp yesno
}
else {

}
capture confirm numeric v snrecommendforjobdummyhh
if !_rc {
label values snrecommendforjobdummyhh yesno
}
else {

}
capture confirm numeric v _2sntalkthemostemployertype
if !_rc {
label values _2sntalkthemostemployertype employertype
}
else {

}
capture confirm numeric v snrecojobsuccesseduc
if !_rc {
label values snrecojobsuccesseduc educlist
}
else {

}
capture confirm numeric v _2snfindcurrentjobsex
if !_rc {
label values _2snfindcurrentjobsex sex
}
else {

}
capture confirm numeric v _2lackskill
if !_rc {
label values _2lackskill yesno
}
else {

}
capture confirm numeric v _3sharefeelings
if !_rc {
label values _3sharefeelings personalityandbehavior
}
else {

}
capture confirm numeric v _2executionwork8
if !_rc {
label values _2executionwork8 yesno
}
else {

}
capture confirm numeric v dummyrecommendrefuse
if !_rc {
label values dummyrecommendrefuse yesno
}
else {

}
capture confirm numeric v remsentplace
if !_rc {
label values remsentplace migrationplace
}
else {

}
capture confirm numeric v _3sntalkthemostlabourrelation
if !_rc {
label values _3sntalkthemostlabourrelation yesno
}
else {

}
capture confirm numeric v snrecommendassodistrict
if !_rc {
label values snrecommendassodistrict district
}
else {

}
capture confirm numeric v _2B3
if !_rc {
label values _2B3 raventest
}
else {

}
capture confirm numeric v covforcedbackhome
if !_rc {
label values covforcedbackhome yesno
}
else {

}
capture confirm numeric v _3snhelpemergencylabourtype
if !_rc {
label values _3snhelpemergencylabourtype labourrelation
}
else {

}
capture confirm numeric v _3snrecommendassosex
if !_rc {
label values _3snrecommendassosex sex
}
else {

}
capture confirm numeric v repetitivetasks
if !_rc {
label values repetitivetasks personalityandbehavior
}
else {

}
capture confirm numeric v _2discrimination1
if !_rc {
label values _2discrimination1 yesno
}
else {

}
capture confirm numeric v _2snfindcurrentjobdummyhh
if !_rc {
label values _2snfindcurrentjobdummyhh yesno
}
else {

}
capture confirm numeric v _3snhelpemergencywkp
if !_rc {
label values _3snhelpemergencywkp yesno
}
else {

}
capture confirm numeric v snfindjobcompared
if !_rc {
label values snfindjobcompared compared
}
else {

}
capture confirm numeric v _3snfindcurrentjobintimacy
if !_rc {
label values _3snfindcurrentjobintimacy intimacydegree
}
else {

}
capture confirm numeric v agreementatwork3
if !_rc {
label values agreementatwork3 agreementwork
}
else {

}
capture confirm numeric v _3snrecommendforjobreciprocity1
if !_rc {
label values _3snrecommendforjobreciprocity1 yesno
}
else {

}
capture confirm numeric v snhelpemergencyruralurban
if !_rc {
label values snhelpemergencyruralurban rural
}
else {

}
capture confirm numeric v staycalm
if !_rc {
label values staycalm personalityandbehavior
}
else {

}
capture confirm numeric v takeholiday
if !_rc {
label values takeholiday satisfaction4
}
else {

}
capture confirm numeric v sntalkthemostsex
if !_rc {
label values sntalkthemostsex sex
}
else {

}
capture confirm numeric v sntalkthemostcompared
if !_rc {
label values sntalkthemostcompared compared
}
else {

}
capture confirm numeric v _3snrecommendforjobmeet
if !_rc {
label values _3snrecommendforjobmeet meet
}
else {

}
capture confirm numeric v _2snentrustbusinesslabourtype
if !_rc {
label values _2snentrustbusinesslabourtype labourrelation
}
else {

}
capture confirm numeric v _2snrecojobsuccesscompared
if !_rc {
label values _2snrecojobsuccesscompared compared
}
else {

}
capture confirm numeric v remsentrelation
if !_rc {
label values remsentrelation relation3
}
else {

}
capture confirm numeric v husbandwifecaste
if !_rc {
label values husbandwifecaste castes
}
else {

}
capture confirm numeric v _3snentrustbusinesseduc
if !_rc {
label values _3snentrustbusinesseduc educlist
}
else {

}
capture confirm numeric v finishtasks
if !_rc {
label values finishtasks personalityandbehavior
}
else {

}
capture confirm numeric v meetfrequemcybusinesslender
if !_rc {
label values meetfrequemcybusinesslender meetfrequency
}
else {

}
capture confirm numeric v _2newideas
if !_rc {
label values _2newideas personalityandbehavior
}
else {

}
capture confirm numeric v _3snfindsuppliersage
if !_rc {
label values _3snfindsuppliersage agelist
}
else {

}
capture confirm numeric v snrecojobsuccess
if !_rc {
label values snrecojobsuccess yesnosocialnetwork
}
else {

}
capture confirm numeric v _3snentrustbusinessdummyhh
if !_rc {
label values _3snentrustbusinessdummyhh yesno
}
else {

}
capture confirm numeric v _2numeracy1
if !_rc {
label values _2numeracy1 numeracy
}
else {

}
capture confirm numeric v _2snfindjobreciprocity1
if !_rc {
label values _2snfindjobreciprocity1 yesno
}
else {

}
capture confirm numeric v _3covnetworkhelpkinmember
if !_rc {
label values _3covnetworkhelpkinmember covidscale
}
else {

}
capture confirm numeric v dummyrecommendgiven
if !_rc {
label values dummyrecommendgiven yesno
}
else {

}
capture confirm numeric v _2expressingthoughts
if !_rc {
label values _2expressingthoughts personalityandbehavior
}
else {

}
capture confirm numeric v _2snfindsuppliersemployertype
if !_rc {
label values _2snfindsuppliersemployertype employertype
}
else {

}
capture confirm numeric v _2snfindsuppliersdummyhh
if !_rc {
label values _2snfindsuppliersdummyhh yesno
}
else {

}
capture confirm numeric v _3snrecruitworkermeet
if !_rc {
label values _3snrecruitworkermeet meet
}
else {

}
capture confirm numeric v _3networktrustneighborhood
if !_rc {
label values _3networktrustneighborhood personalityandbehavior
}
else {

}
capture confirm numeric v _3everwork
if !_rc {
label values _3everwork yesno
}
else {

}
capture confirm numeric v break
if !_rc {
label values break yesno
}
else {

}
capture confirm numeric v _2snfindjobinvite
if !_rc {
label values _2snfindjobinvite yesno
}
else {

}
capture confirm numeric v _2sntalkthemostfriend
if !_rc {
label values _2sntalkthemostfriend yesno
}
else {

}
capture confirm numeric v enthusiastic
if !_rc {
label values enthusiastic personalityandbehavior
}
else {

}
capture confirm numeric v snhelpemergencymeetfrequency
if !_rc {
label values snhelpemergencymeetfrequency meetfrequency
}
else {

}
capture confirm numeric v dummybusinesslabourers
if !_rc {
label values dummybusinesslabourers yesno
}
else {

}
capture confirm numeric v comparedbusinesslender
if !_rc {
label values comparedbusinesslender compared
}
else {

}
capture confirm numeric v _3decisionwork
if !_rc {
label values _3decisionwork decisionwork
}
else {

}
capture confirm numeric v _3assohelpjob
if !_rc {
label values _3assohelpjob assohelpjob
}
else {

}
capture confirm numeric v _3A10
if !_rc {
label values _3A10 raventest
}
else {

}
capture confirm numeric v startbusiness
if !_rc {
label values startbusiness yesno
}
else {

}
capture confirm numeric v migrationarea
if !_rc {
label values migrationarea migrationplace
}
else {

}
capture confirm numeric v _2locuscontrol4
if !_rc {
label values _2locuscontrol4 locusscale
}
else {

}
capture confirm numeric v sncloserelouthhmeet
if !_rc {
label values sncloserelouthhmeet meet
}
else {

}
capture confirm numeric v problemwork9
if !_rc {
label values problemwork9 problemwork
}
else {

}
capture confirm numeric v snfindjobruralurban
if !_rc {
label values snfindjobruralurban rural
}
else {

}
capture confirm numeric v _3snentrustbusinesscastes
if !_rc {
label values _3snentrustbusinesscastes castes
}
else {

}
capture confirm numeric v Ab10
if !_rc {
label values Ab10 raventest
}
else {

}
capture confirm numeric v _2snrecojobsuccessdistrict
if !_rc {
label values _2snrecojobsuccessdistrict district
}
else {

}
capture confirm numeric v trustingofother
if !_rc {
label values trustingofother personalityandbehavior
}
else {

}
capture confirm numeric v _2snrecommendassoemployertype
if !_rc {
label values _2snrecommendassoemployertype employertype
}
else {

}
capture confirm numeric v snhelpemergencyemployertype
if !_rc {
label values snhelpemergencyemployertype employertype
}
else {

}
capture confirm numeric v snrecommendassolabourtype
if !_rc {
label values snrecommendassolabourtype labourrelation
}
else {

}
capture confirm numeric v snrecruitworkeremployertype
if !_rc {
label values snrecruitworkeremployertype employertype
}
else {

}
capture confirm numeric v _2sntalkthemostinvite
if !_rc {
label values _2sntalkthemostinvite yesno
}
else {

}
capture confirm numeric v _2snfindcurrentjobmeet
if !_rc {
label values _2snfindcurrentjobmeet meet
}
else {

}
capture confirm numeric v _2businesspaymentinkind
if !_rc {
label values _2businesspaymentinkind yesno
}
else {

}
capture confirm numeric v _3snrecojobsuccessage
if !_rc {
label values _3snrecojobsuccessage agelist
}
else {

}
capture confirm numeric v _2useknowledgeatwork
if !_rc {
label values _2useknowledgeatwork satisfaction
}
else {

}
capture confirm numeric v _2snrecommendforjobmeetfrequency
if !_rc {
label values _2snrecommendforjobmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v discrimination9
if !_rc {
label values discrimination9 yesno
}
else {

}
capture confirm numeric v _3numeracy6
if !_rc {
label values _3numeracy6 numeracy
}
else {

}
capture confirm numeric v _3sncloserelouthheduc
if !_rc {
label values _3sncloserelouthheduc educlist
}
else {

}
capture confirm numeric v _2sexbusinesslender
if !_rc {
label values _2sexbusinesslender sex
}
else {

}
capture confirm numeric v executionwork5
if !_rc {
label values executionwork5 yesno
}
else {

}
capture confirm numeric v _3snrecojobsuccessdummyhh
if !_rc {
label values _3snrecojobsuccessdummyhh yesno
}
else {

}
capture confirm numeric v snrecojobsuccesswkp
if !_rc {
label values snrecojobsuccesswkp yesno
}
else {

}
capture confirm numeric v _2A9
if !_rc {
label values _2A9 raventest
}
else {

}
capture confirm numeric v relationemployer
if !_rc {
label values relationemployer relation
}
else {

}
capture confirm numeric v _2snrecommendassolabourtype
if !_rc {
label values _2snrecommendassolabourtype labourrelation
}
else {

}
capture confirm numeric v talktomanypeople
if !_rc {
label values talktomanypeople personalityandbehavior
}
else {

}
capture confirm numeric v _3snentrustbusiness
if !_rc {
label values _3snentrustbusiness yesnosocialnetwork
}
else {

}
capture confirm numeric v _2discrimination2
if !_rc {
label values _2discrimination2 yesno
}
else {

}
capture confirm numeric v _3reasondontsearchjob
if !_rc {
label values _3reasondontsearchjob reasondontsearchjob
}
else {

}
capture confirm numeric v _2covworkeffort
if !_rc {
label values _2covworkeffort workcovid
}
else {

}
capture confirm numeric v _3snrecruitworkereduc
if !_rc {
label values _3snrecruitworkereduc educlist
}
else {

}
capture confirm numeric v _2break
if !_rc {
label values _2break yesno
}
else {

}
capture confirm numeric v snrecommendforjobmeetfrequency
if !_rc {
label values snrecommendforjobmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v _3snfindsuppliersreciprocity1
if !_rc {
label values _3snfindsuppliersreciprocity1 yesno
}
else {

}
capture confirm numeric v _3sncloserelouthhmeet
if !_rc {
label values _3sncloserelouthhmeet meet
}
else {

}
capture confirm numeric v _2reasondontsearchjobsince15
if !_rc {
label values _2reasondontsearchjobsince15 reasondontsearchjob
}
else {

}
capture confirm numeric v _2snrecommendforjobfriend
if !_rc {
label values _2snrecommendforjobfriend yesno
}
else {

}
capture confirm numeric v _3snrecommendassodummyfam
if !_rc {
label values _3snrecommendassodummyfam yesno
}
else {

}
capture confirm numeric v _3B7
if !_rc {
label values _3B7 raventest
}
else {

}
capture confirm numeric v covdifficulties
if !_rc {
label values covdifficulties difficultycovid
}
else {

}
capture confirm numeric v _2snrecruitworker
if !_rc {
label values _2snrecruitworker yesnosocialnetwork
}
else {

}
capture confirm numeric v _2snentrustbusinesscastes
if !_rc {
label values _2snentrustbusinesscastes castes
}
else {

}
capture confirm numeric v _3snfindsupplierscompared
if !_rc {
label values _3snfindsupplierscompared compared
}
else {

}
capture confirm numeric v castebusinesslabourer
if !_rc {
label values castebusinesslabourer castes
}
else {

}
capture confirm numeric v _2snrecojobsuccess
if !_rc {
label values _2snrecojobsuccess yesnosocialnetwork
}
else {

}
capture confirm numeric v _3A2
if !_rc {
label values _3A2 raventest
}
else {

}
capture confirm numeric v _2schedule
if !_rc {
label values _2schedule satisfaction3
}
else {

}
capture confirm numeric v dummyrecommendation
if !_rc {
label values dummyrecommendation yesno
}
else {

}
capture confirm numeric v happywork
if !_rc {
label values happywork satisfaction3
}
else {

}
capture confirm numeric v snentrustbusiness
if !_rc {
label values snentrustbusiness yesnosocialnetwork
}
else {

}
capture confirm numeric v termsofrepayment
if !_rc {
label values termsofrepayment termsofrepayment
}
else {

}
capture confirm numeric v _2snrecommendforjob
if !_rc {
label values _2snrecommendforjob yesnosocialnetwork
}
else {

}
capture confirm numeric v _2snentrustbusiness
if !_rc {
label values _2snentrustbusiness yesnosocialnetwork
}
else {

}
capture confirm numeric v _2snrecommendforjobliving
if !_rc {
label values _2snrecommendforjobliving living
}
else {

}
capture confirm numeric v _2comparedbusinesslender
if !_rc {
label values _2comparedbusinesslender compared
}
else {

}
capture confirm numeric v _3snfindcurrentjobliving
if !_rc {
label values _3snfindcurrentjobliving living
}
else {

}
capture confirm numeric v snfindjob
if !_rc {
label values snfindjob yesnosocialnetwork
}
else {

}
capture confirm numeric v _3snrecojobsuccess
if !_rc {
label values _3snrecojobsuccess yesnosocialnetwork
}
else {

}
capture confirm numeric v discrimination2
if !_rc {
label values discrimination2 yesno
}
else {

}
capture confirm numeric v salariedjobtype2
if !_rc {
label values salariedjobtype2 typejob2
}
else {

}
capture confirm numeric v converseinenglish
if !_rc {
label values converseinenglish yesno
}
else {

}
capture confirm numeric v _3snrecommendassolabourrelation
if !_rc {
label values _3snrecommendassolabourrelation yesno
}
else {

}
capture confirm numeric v _3snfindjobdummyfam
if !_rc {
label values _3snfindjobdummyfam yesno
}
else {

}
capture confirm numeric v _3sntalkthemostinvite
if !_rc {
label values _3sntalkthemostinvite yesno
}
else {

}
capture confirm numeric v _3sntalkthemostcastes
if !_rc {
label values _3sntalkthemostcastes castes
}
else {

}
capture confirm numeric v _3snrecommendforjobintimacy
if !_rc {
label values _3snrecommendforjobintimacy intimacydegree
}
else {

}
capture confirm numeric v businessnbunpaidworkers
if !_rc {
label values businessnbunpaidworkers nbworkers
}
else {

}
capture confirm numeric v _2snfindjobmeet
if !_rc {
label values _2snfindjobmeet meet
}
else {

}
capture confirm numeric v _3snfindcurrentjobcompared
if !_rc {
label values _3snfindcurrentjobcompared compared
}
else {

}
capture confirm numeric v workexposure5
if !_rc {
label values workexposure5 graduation
}
else {

}
capture confirm numeric v snfindjobdummyhh
if !_rc {
label values snfindjobdummyhh yesno
}
else {

}
capture confirm numeric v dummyassohelpbusiness
if !_rc {
label values dummyassohelpbusiness yesno
}
else {

}
capture confirm numeric v _3useknowledgeatwork
if !_rc {
label values _3useknowledgeatwork satisfaction
}
else {

}
capture confirm numeric v _3expressingthoughts
if !_rc {
label values _3expressingthoughts personalityandbehavior
}
else {

}
capture confirm numeric v _2snentrustbusinesslabourrelation
if !_rc {
label values _2snentrustbusinesslabourrelation yesno
}
else {

}
capture confirm numeric v _2snrecommendforjobinvite
if !_rc {
label values _2snrecommendforjobinvite yesno
}
else {

}
capture confirm numeric v _2snhelpemergencycastes
if !_rc {
label values _2snhelpemergencycastes castes
}
else {

}
capture confirm numeric v snrecommendforjobwkp
if !_rc {
label values snrecommendforjobwkp yesno
}
else {

}
capture confirm numeric v _3snrecojobsuccesslabourtype
if !_rc {
label values _3snrecojobsuccesslabourtype labourrelation
}
else {

}
capture confirm numeric v chitfundpayment
if !_rc {
label values chitfundpayment frequency2
}
else {

}
capture confirm numeric v _3sncloserelouthhmeetfrequency
if !_rc {
label values _3sncloserelouthhmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v snfindsuppliersfriend
if !_rc {
label values snfindsuppliersfriend yesno
}
else {

}
capture confirm numeric v _2dummyassorecommendation
if !_rc {
label values _2dummyassorecommendation yesno
}
else {

}
capture confirm numeric v finishwhatbegin
if !_rc {
label values finishwhatbegin personalityandbehavior
}
else {

}
capture confirm numeric v _3resdiscrimination4
if !_rc {
label values _3resdiscrimination4 yesno
}
else {

}
capture confirm numeric v _2helpfulwithothers
if !_rc {
label values _2helpfulwithothers personalityandbehavior
}
else {

}
capture confirm numeric v snrecojobsuccessdummyfam
if !_rc {
label values snrecojobsuccessdummyfam yesno
}
else {

}
capture confirm numeric v _2keepworking
if !_rc {
label values _2keepworking personalityandbehavior
}
else {

}
capture confirm numeric v workexposure2
if !_rc {
label values workexposure2 graduation
}
else {

}
capture confirm numeric v dummyreligionspouse
if !_rc {
label values dummyreligionspouse yesno
}
else {

}
capture confirm numeric v _2snrecommendassocompared
if !_rc {
label values _2snrecommendassocompared compared
}
else {

}
capture confirm numeric v guarantorloanrelation
if !_rc {
label values guarantorloanrelation relation
}
else {

}
capture confirm numeric v _2B5
if !_rc {
label values _2B5 raventest
}
else {

}
capture confirm numeric v _2executionwork1
if !_rc {
label values _2executionwork1 yesno
}
else {

}
capture confirm numeric v snfindjobinvite
if !_rc {
label values snfindjobinvite yesno
}
else {

}
capture confirm numeric v _2snfindcurrentjobinvite
if !_rc {
label values _2snfindcurrentjobinvite yesno
}
else {

}
capture confirm numeric v _2snfindjobdummyhh
if !_rc {
label values _2snfindjobdummyhh yesno
}
else {

}
capture confirm numeric v _2dummyaspirationmorehours
if !_rc {
label values _2dummyaspirationmorehours yesno3
}
else {

}
capture confirm numeric v stoppedworking
if !_rc {
label values stoppedworking yesno
}
else {

}
capture confirm numeric v comefromspouse
if !_rc {
label values comefromspouse yesno
}
else {

}
capture confirm numeric v remsentgift
if !_rc {
label values remsentgift yesno
}
else {

}
capture confirm numeric v _2snrecruitworkermeet
if !_rc {
label values _2snrecruitworkermeet meet
}
else {

}
capture confirm numeric v _2invitebusinesslender
if !_rc {
label values _2invitebusinesslender yesno
}
else {

}
capture confirm numeric v putoffduties
if !_rc {
label values putoffduties personalityandbehavior
}
else {

}
capture confirm numeric v _2sntalkthemostcastes
if !_rc {
label values _2sntalkthemostcastes castes
}
else {

}
capture confirm numeric v _3snfindcurrentjobruralurban
if !_rc {
label values _3snfindcurrentjobruralurban rural
}
else {

}
capture confirm numeric v _2snhelpemergencydummyfam
if !_rc {
label values _2snhelpemergencydummyfam yesno
}
else {

}
capture confirm numeric v _3covinstit3
if !_rc {
label values _3covinstit3 covinstit
}
else {

}
capture confirm numeric v _2snrecommendforjoblabourtype
if !_rc {
label values _2snrecommendforjoblabourtype labourrelation
}
else {

}
capture confirm numeric v _3Ab3
if !_rc {
label values _3Ab3 raventest
}
else {

}
capture confirm numeric v understandotherfeeling
if !_rc {
label values understandotherfeeling personalityandbehavior
}
else {

}
capture confirm numeric v _3problemwork4
if !_rc {
label values _3problemwork4 problemwork
}
else {

}
capture confirm numeric v dummyinterest
if !_rc {
label values dummyinterest yesno
}
else {

}
capture confirm numeric v _3snfindcurrentjob
if !_rc {
label values _3snfindcurrentjob yesnosocialnetwork
}
else {

}
capture confirm numeric v _3snentrustbusinessdummyfam
if !_rc {
label values _3snentrustbusinessdummyfam yesno
}
else {

}
capture confirm numeric v _2snrecojobsuccessinvite
if !_rc {
label values _2snrecojobsuccessinvite yesno
}
else {

}
capture confirm numeric v dummyguarantor
if !_rc {
label values dummyguarantor yesno
}
else {

}
capture confirm numeric v _3easilyupset
if !_rc {
label values _3easilyupset personalityandbehavior
}
else {

}
capture confirm numeric v snfindjobeduc
if !_rc {
label values snfindjobeduc educlist
}
else {

}
capture confirm numeric v resdiscrimination2
if !_rc {
label values resdiscrimination2 yesno
}
else {

}
capture confirm numeric v businessworkersfrequencypayment
if !_rc {
label values businessworkersfrequencypayment frequency5
}
else {

}
capture confirm numeric v _3executionwork8
if !_rc {
label values _3executionwork8 yesno
}
else {

}
capture confirm numeric v _3snfindjob
if !_rc {
label values _3snfindjob yesnosocialnetwork
}
else {

}
capture confirm numeric v _2covinstit3
if !_rc {
label values _2covinstit3 covinstit
}
else {

}
capture confirm numeric v _3respect
if !_rc {
label values _3respect satisfaction
}
else {

}
capture confirm numeric v _3canreadcard1b
if !_rc {
label values _3canreadcard1b literacy2
}
else {

}
capture confirm numeric v _3B3
if !_rc {
label values _3B3 raventest
}
else {

}
capture confirm numeric v _2searchjobsince15
if !_rc {
label values _2searchjobsince15 yesno
}
else {

}
capture confirm numeric v snfindcurrentjobcompared
if !_rc {
label values snfindcurrentjobcompared compared
}
else {

}
capture confirm numeric v _2snfindjobemployertype
if !_rc {
label values _2snfindjobemployertype employertype
}
else {

}
capture confirm numeric v _2resdiscrimination2
if !_rc {
label values _2resdiscrimination2 yesno
}
else {

}
capture confirm numeric v _2canreadcard1b
if !_rc {
label values _2canreadcard1b literacy2
}
else {

}
capture confirm numeric v _2resdiscrimination3
if !_rc {
label values _2resdiscrimination3 yesno
}
else {

}
capture confirm numeric v _3keepworking
if !_rc {
label values _3keepworking personalityandbehavior
}
else {

}
capture confirm numeric v _3snrecruitworkerlabourtype
if !_rc {
label values _3snrecruitworkerlabourtype labourrelation
}
else {

}
capture confirm numeric v dummyassohelpjob
if !_rc {
label values dummyassohelpjob yesno
}
else {

}
capture confirm numeric v _2snfindsuppliersmeet
if !_rc {
label values _2snfindsuppliersmeet meet
}
else {

}
capture confirm numeric v _3snhelpemergencycompared
if !_rc {
label values _3snhelpemergencycompared compared
}
else {

}
capture confirm numeric v snentrustbusinesscastes
if !_rc {
label values snentrustbusinesscastes castes
}
else {

}
capture confirm numeric v snfindcurrentjobeduc
if !_rc {
label values snfindcurrentjobeduc educlist
}
else {

}
capture confirm numeric v _2B1
if !_rc {
label values _2B1 raventest
}
else {

}
capture confirm numeric v _3schedule
if !_rc {
label values _3schedule satisfaction3
}
else {

}
capture confirm numeric v _2snhelpemergencyage
if !_rc {
label values _2snhelpemergencyage agelist
}
else {

}
capture confirm numeric v _2intimacybusinesslender
if !_rc {
label values _2intimacybusinesslender intimacydegree
}
else {

}
capture confirm numeric v usecreditcard
if !_rc {
label values usecreditcard demo6
}
else {

}
capture confirm numeric v _2resdiscrimination1
if !_rc {
label values _2resdiscrimination1 yesno
}
else {

}
capture confirm numeric v _2snfindjobdistrict
if !_rc {
label values _2snfindjobdistrict district
}
else {

}
capture confirm numeric v problemwork6
if !_rc {
label values problemwork6 problemwork
}
else {

}
capture confirm numeric v snrecommendforjoblabourtype
if !_rc {
label values snrecommendforjoblabourtype labourrelation
}
else {

}
capture confirm numeric v covpressureadvance
if !_rc {
label values covpressureadvance yesno
}
else {

}
capture confirm numeric v loaneffectivereason
if !_rc {
label values loaneffectivereason reasonborrowing
}
else {

}
capture confirm numeric v _2numeracy6
if !_rc {
label values _2numeracy6 numeracy
}
else {

}
capture confirm numeric v _2sncloserelouthhmeet
if !_rc {
label values _2sncloserelouthhmeet meet
}
else {

}
capture confirm numeric v _2toleratefaults
if !_rc {
label values _2toleratefaults personalityandbehavior
}
else {

}
capture confirm numeric v _3sncloserelouthhruralurban
if !_rc {
label values _3sncloserelouthhruralurban rural
}
else {

}
capture confirm numeric v snhelpemergencylabourtype
if !_rc {
label values snhelpemergencylabourtype labourrelation
}
else {

}
capture confirm numeric v snrecommendforjob
if !_rc {
label values snrecommendforjob yesnosocialnetwork
}
else {

}
capture confirm numeric v lenderscaste
if !_rc {
label values lenderscaste casteemployer
}
else {

}
capture confirm numeric v snrecruitworkerlabourrelation
if !_rc {
label values snrecruitworkerlabourrelation yesno
}
else {

}
capture confirm numeric v dummybusinesslabourerhhmember
if !_rc {
label values dummybusinesslabourerhhmember yesno
}
else {

}
capture confirm numeric v _2A11
if !_rc {
label values _2A11 raventest
}
else {

}
capture confirm numeric v _3canreadcard1a
if !_rc {
label values _3canreadcard1a literacy2
}
else {

}
capture confirm numeric v _3organized
if !_rc {
label values _3organized personalityandbehavior
}
else {

}
capture confirm numeric v _2locuscontrol3
if !_rc {
label values _2locuscontrol3 locusscale
}
else {

}
capture confirm numeric v _3snfindjobeduc
if !_rc {
label values _3snfindjobeduc educlist
}
else {

}
capture confirm numeric v _3jobwagefrequencycash
if !_rc {
label values _3jobwagefrequencycash frequency5
}
else {

}
capture confirm numeric v sntalkthemostwkp
if !_rc {
label values sntalkthemostwkp yesno
}
else {

}
capture confirm numeric v losswork
if !_rc {
label values losswork yesno
}
else {

}
capture confirm numeric v _2livingbusinesslender
if !_rc {
label values _2livingbusinesslender living
}
else {

}
capture confirm numeric v covsick
if !_rc {
label values covsick yesno
}
else {

}
capture confirm numeric v dummyworkedpastyear
if !_rc {
label values dummyworkedpastyear yesno
}
else {

}
capture confirm numeric v _3happywork
if !_rc {
label values _3happywork satisfaction3
}
else {

}
capture confirm numeric v _3businessworkersfrequencypayment
if !_rc {
label values _3businessworkersfrequencypayment frequency5
}
else {

}
capture confirm numeric v snfindcurrentjobdummyhh
if !_rc {
label values snfindcurrentjobdummyhh yesno
}
else {

}
capture confirm numeric v _3sntalkthemostage
if !_rc {
label values _3sntalkthemostage agelist
}
else {

}
capture confirm numeric v _3snrecommendforjobemployertype
if !_rc {
label values _3snrecommendforjobemployertype employertype
}
else {

}
capture confirm numeric v snrecruitworkerinvite
if !_rc {
label values snrecruitworkerinvite yesno
}
else {

}
capture confirm numeric v _2snentrustbusinessliving
if !_rc {
label values _2snentrustbusinessliving living
}
else {

}
capture confirm numeric v dummybusinesspaidworkers
if !_rc {
label values dummybusinesspaidworkers yesno
}
else {

}
capture confirm numeric v _2snfindjobliving
if !_rc {
label values _2snfindjobliving living
}
else {

}
capture confirm numeric v problemwork1
if !_rc {
label values problemwork1 problemwork
}
else {

}
capture confirm numeric v B4
if !_rc {
label values B4 raventest
}
else {

}
capture confirm numeric v _3helpfulwithothers
if !_rc {
label values _3helpfulwithothers personalityandbehavior
}
else {

}
capture confirm numeric v _2sexualharassment
if !_rc {
label values _2sexualharassment yesno
}
else {

}
capture confirm numeric v _3covneworktrustneighborhood
if !_rc {
label values _3covneworktrustneighborhood covidscale
}
else {

}
capture confirm numeric v networkpeoplehelping
if !_rc {
label values networkpeoplehelping personalityandbehavior
}
else {

}
capture confirm numeric v _3dummyassorecommendation
if !_rc {
label values _3dummyassorecommendation yesno
}
else {

}
capture confirm numeric v _2snrecojobsuccessdummyfam
if !_rc {
label values _2snrecojobsuccessdummyfam yesno
}
else {

}
capture confirm numeric v _2discrimination9
if !_rc {
label values _2discrimination9 yesno
}
else {

}
capture confirm numeric v snfindcurrentjobdummyfam
if !_rc {
label values snfindcurrentjobdummyfam yesno
}
else {

}
capture confirm numeric v _3discrimination6
if !_rc {
label values _3discrimination6 yesno
}
else {

}
capture confirm numeric v snrecojobsuccessdummyhh
if !_rc {
label values snrecojobsuccessdummyhh yesno
}
else {

}
capture confirm numeric v _3ego2random_2_3
if !_rc {
label values _3ego2random_2_3 yesno
}
else {

}
capture confirm numeric v agreementatwork4
if !_rc {
label values agreementatwork4 agreementwork
}
else {

}
capture confirm numeric v sncloserelouthhruralurban
if !_rc {
label values sncloserelouthhruralurban rural
}
else {

}
capture confirm numeric v _3stickwithgoals
if !_rc {
label values _3stickwithgoals personalityandbehavior
}
else {

}
capture confirm numeric v _3covinstit7
if !_rc {
label values _3covinstit7 covidscale
}
else {

}
capture confirm numeric v snrecommendassowkp
if !_rc {
label values snrecommendassowkp yesno
}
else {

}
capture confirm numeric v sncloserelouthhfriend
if !_rc {
label values sncloserelouthhfriend yesno
}
else {

}
capture confirm numeric v _3ego2random_2
if !_rc {
label values _3ego2random_2 yesno
}
else {

}
capture confirm numeric v rurallocation
if !_rc {
label values rurallocation yesno
}
else {

}
capture confirm numeric v _2B10
if !_rc {
label values _2B10 raventest
}
else {

}
capture confirm numeric v _2snhelpemergencymeet
if !_rc {
label values _2snhelpemergencymeet meet
}
else {

}
capture confirm numeric v _3workexposure4
if !_rc {
label values _3workexposure4 graduation
}
else {

}
capture confirm numeric v _2numeracy4
if !_rc {
label values _2numeracy4 numeracy
}
else {

}
capture confirm numeric v _3agebusinesslender
if !_rc {
label values _3agebusinesslender agelist
}
else {

}
capture confirm numeric v borrowerscaste
if !_rc {
label values borrowerscaste castes
}
else {

}
capture confirm numeric v _2enjoypeople
if !_rc {
label values _2enjoypeople personalityandbehavior
}
else {

}
capture confirm numeric v lenderoccup
if !_rc {
label values lenderoccup occuplist2
}
else {

}
capture confirm numeric v _3Ab2
if !_rc {
label values _3Ab2 raventest
}
else {

}
capture confirm numeric v dummylendingmoney
if !_rc {
label values dummylendingmoney yesno
}
else {

}
capture confirm numeric v _3snfindcurrentjobmeet
if !_rc {
label values _3snfindcurrentjobmeet meet
}
else {

}
capture confirm numeric v dummyhhrespondentego1
if !_rc {
label values dummyhhrespondentego1 yesno
}
else {

}
capture confirm numeric v snrecruitworkerwkp
if !_rc {
label values snrecruitworkerwkp yesno
}
else {

}
capture confirm numeric v _2happywork
if !_rc {
label values _2happywork satisfaction3
}
else {

}
capture confirm numeric v _3snfindcurrentjobwkp
if !_rc {
label values _3snfindcurrentjobwkp yesno
}
else {

}
capture confirm numeric v remsentdummyvillage
if !_rc {
label values remsentdummyvillage yesno
}
else {

}
capture confirm numeric v _3snfindjobfriend
if !_rc {
label values _3snfindjobfriend yesno
}
else {

}
capture confirm numeric v _3ego2random_1_2
if !_rc {
label values _3ego2random_1_2 yesno
}
else {

}
capture confirm numeric v resdiscrimination5
if !_rc {
label values resdiscrimination5 yesno
}
else {

}
capture confirm numeric v _2snentrustbusinessmeet
if !_rc {
label values _2snentrustbusinessmeet meet
}
else {

}
capture confirm numeric v _2Ab4
if !_rc {
label values _2Ab4 raventest
}
else {

}
capture confirm numeric v _3snentrustbusinessruralurban
if !_rc {
label values _3snentrustbusinessruralurban rural
}
else {

}
capture confirm numeric v _3numeracy5
if !_rc {
label values _3numeracy5 numeracy
}
else {

}
capture confirm numeric v _3executionwork4
if !_rc {
label values _3executionwork4 yesno
}
else {

}
capture confirm numeric v _3liketothink
if !_rc {
label values _3liketothink personalityandbehavior
}
else {

}
capture confirm numeric v _2sncloserelouthhdistrict
if !_rc {
label values _2sncloserelouthhdistrict district
}
else {

}
capture confirm numeric v _2physicalagression
if !_rc {
label values _2physicalagression graduation2
}
else {

}
capture confirm numeric v dummydebitcard
if !_rc {
label values dummydebitcard yesno
}
else {

}
capture confirm numeric v _3methodfindfirstjob
if !_rc {
label values _3methodfindfirstjob methodfindjob
}
else {

}
capture confirm numeric v _3putoffduties
if !_rc {
label values _3putoffduties personalityandbehavior
}
else {

}
capture confirm numeric v snrecommendassolabourrelation
if !_rc {
label values snrecommendassolabourrelation yesno
}
else {

}
capture confirm numeric v snrecommendassosex
if !_rc {
label values snrecommendassosex sex
}
else {

}
capture confirm numeric v _3snrecruitworkersex
if !_rc {
label values _3snrecruitworkersex sex
}
else {

}
capture confirm numeric v _3snhelpemergencylabourrelation
if !_rc {
label values _3snhelpemergencylabourrelation yesno
}
else {

}
capture confirm numeric v businessnbpaidworkers
if !_rc {
label values businessnbpaidworkers nbworkers
}
else {

}
capture confirm numeric v _2stickwithgoals
if !_rc {
label values _2stickwithgoals personalityandbehavior
}
else {

}
capture confirm numeric v _3snhelpemergencyreciprocity1
if !_rc {
label values _3snhelpemergencyreciprocity1 yesno
}
else {

}
capture confirm numeric v _2snfindcurrentjobage
if !_rc {
label values _2snfindcurrentjobage agelist
}
else {

}
capture confirm numeric v _3snrecommendforjob
if !_rc {
label values _3snrecommendforjob yesnosocialnetwork
}
else {

}
capture confirm numeric v _2dummymainoccupation2
if !_rc {
label values _2dummymainoccupation2 yesno
}
else {

}
capture confirm numeric v dummygold
if !_rc {
label values dummygold yesno
}
else {

}
capture confirm numeric v snentrustbusinessdummyfam
if !_rc {
label values snentrustbusinessdummyfam yesno
}
else {

}
capture confirm numeric v discrimination6
if !_rc {
label values discrimination6 yesno
}
else {

}
capture confirm numeric v snentrustbusinessemployertype
if !_rc {
label values snentrustbusinessemployertype employertype
}
else {

}
capture confirm numeric v problemrepayment
if !_rc {
label values problemrepayment yesno
}
else {

}
capture confirm numeric v _2snfindcurrentjoblabourrelation
if !_rc {
label values _2snfindcurrentjoblabourrelation yesno
}
else {

}
capture confirm numeric v snrecommendforjobfriend
if !_rc {
label values snrecommendforjobfriend yesno
}
else {

}
capture confirm numeric v wagejobsocialsecurity
if !_rc {
label values wagejobsocialsecurity yesno
}
else {

}
capture confirm numeric v _3dummybusinesspaidworkers
if !_rc {
label values _3dummybusinesspaidworkers yesno
}
else {

}
capture confirm numeric v dummypreviouswagejob
if !_rc {
label values dummypreviouswagejob yesno
}
else {

}
capture confirm numeric v _3sexbusinesslender
if !_rc {
label values _3sexbusinesslender sex
}
else {

}
capture confirm numeric v _2talkative
if !_rc {
label values _2talkative personalityandbehavior
}
else {

}
capture confirm numeric v _3snentrustbusinesscompared
if !_rc {
label values _3snentrustbusinesscompared compared
}
else {

}
capture confirm numeric v _3dummymainoccupation2
if !_rc {
label values _3dummymainoccupation2 yesno
}
else {

}
capture confirm numeric v _3B9
if !_rc {
label values _3B9 raventest
}
else {

}
capture confirm numeric v _2snfindcurrentjobliving
if !_rc {
label values _2snfindcurrentjobliving living
}
else {

}
capture confirm numeric v _2businessnbworkers
if !_rc {
label values _2businessnbworkers nbworkers
}
else {

}
capture confirm numeric v _3ego2random_1
if !_rc {
label values _3ego2random_1 yesno
}
else {

}
capture confirm numeric v _3rurallocation
if !_rc {
label values _3rurallocation yesno
}
else {

}
capture confirm numeric v ego2random_2
if !_rc {
label values ego2random_2 yesno
}
else {

}
capture confirm numeric v dummygoldpledged
if !_rc {
label values dummygoldpledged yesno
}
else {

}
capture confirm numeric v snrecojobsuccesscastes
if !_rc {
label values snrecojobsuccesscastes castes
}
else {

}
capture confirm numeric v migrationmainoccup
if !_rc {
label values migrationmainoccup yesno
}
else {

}
capture confirm numeric v Ab8
if !_rc {
label values Ab8 raventest
}
else {

}
capture confirm numeric v businesspaymentinkind
if !_rc {
label values businesspaymentinkind yesno
}
else {

}
capture confirm numeric v _3snhelpemergencyfriend
if !_rc {
label values _3snhelpemergencyfriend yesno
}
else {

}
capture confirm numeric v _2agreementatwork4
if !_rc {
label values _2agreementatwork4 agreementwork
}
else {

}
capture confirm numeric v _2castebusinesslender
if !_rc {
label values _2castebusinesslender casteemployer
}
else {

}
capture confirm numeric v _3B10
if !_rc {
label values _3B10 raventest
}
else {

}
capture confirm numeric v _3networkhelpkinmember
if !_rc {
label values _3networkhelpkinmember personalityandbehavior
}
else {

}
capture confirm numeric v _2snrecruitworkerintimacy
if !_rc {
label values _2snrecruitworkerintimacy intimacydegree
}
else {

}
capture confirm numeric v insurancebenefit
if !_rc {
label values insurancebenefit yesno
}
else {

}
capture confirm numeric v covtest
if !_rc {
label values covtest yesnona
}
else {

}
capture confirm numeric v _3workpastsevendays
if !_rc {
label values _3workpastsevendays yesno
}
else {

}
capture confirm numeric v _2sncloserelouthhcompared
if !_rc {
label values _2sncloserelouthhcompared compared
}
else {

}
capture confirm numeric v _2jobfirstwagefrequencycash
if !_rc {
label values _2jobfirstwagefrequencycash frequency5
}
else {

}
capture confirm numeric v _3A5
if !_rc {
label values _3A5 raventest
}
else {

}
capture confirm numeric v businessnbworkers
if !_rc {
label values businessnbworkers nbworkers
}
else {

}
capture confirm numeric v _2snentrustbusinesseduc
if !_rc {
label values _2snentrustbusinesseduc educlist
}
else {

}
capture confirm numeric v executionwork9
if !_rc {
label values executionwork9 yesno
}
else {

}
capture confirm numeric v _2snrecommendforjobemployertype
if !_rc {
label values _2snrecommendforjobemployertype employertype
}
else {

}
capture confirm numeric v snentrustbusinessage
if !_rc {
label values snentrustbusinessage agelist
}
else {

}
capture confirm numeric v _3problemwork6
if !_rc {
label values _3problemwork6 problemwork
}
else {

}
capture confirm numeric v _3snfindcurrentjoblabourtype
if !_rc {
label values _3snfindcurrentjoblabourtype labourrelation
}
else {

}
capture confirm numeric v covinstit5
if !_rc {
label values covinstit5 covinstit
}
else {

}
capture confirm numeric v _2snrecommendassodummyfam
if !_rc {
label values _2snrecommendassodummyfam yesno
}
else {

}
capture confirm numeric v sncloserelouthhdummyfam
if !_rc {
label values sncloserelouthhdummyfam yesno
}
else {

}
capture confirm numeric v _2workwithother
if !_rc {
label values _2workwithother personalityandbehavior
}
else {

}
capture confirm numeric v _3snrecojobsuccessliving
if !_rc {
label values _3snrecojobsuccessliving living
}
else {

}
capture confirm numeric v retirementwork
if !_rc {
label values retirementwork yesno
}
else {

}
capture confirm numeric v salariedjobinsurance
if !_rc {
label values salariedjobinsurance yesno
}
else {

}
capture confirm numeric v _2snrecojobsuccesslabourtype
if !_rc {
label values _2snrecojobsuccesslabourtype labourrelation
}
else {

}
capture confirm numeric v opinionactivewoman
if !_rc {
label values opinionactivewoman opinionwork
}
else {

}
capture confirm numeric v _2tryhard
if !_rc {
label values _2tryhard personalityandbehavior
}
else {

}
capture confirm numeric v _2snentrustbusinessinvite
if !_rc {
label values _2snentrustbusinessinvite yesno
}
else {

}
capture confirm numeric v _2sntalkthemostsex
if !_rc {
label values _2sntalkthemostsex sex
}
else {

}
capture confirm numeric v respect
if !_rc {
label values respect satisfaction
}
else {

}
capture confirm numeric v _3snfindjobsex
if !_rc {
label values _3snfindjobsex sex
}
else {

}
capture confirm numeric v dummymainoccupation2
if !_rc {
label values dummymainoccupation2 yesno
}
else {

}
capture confirm numeric v migrationadvancefeel
if !_rc {
label values migrationadvancefeel unbalancedadvance
}
else {

}
capture confirm numeric v executionwork2
if !_rc {
label values executionwork2 yesno
}
else {

}
capture confirm numeric v readystartjob
if !_rc {
label values readystartjob yesno
}
else {

}
capture confirm numeric v _3snrecojobsuccesscastes
if !_rc {
label values _3snrecojobsuccesscastes castes
}
else {

}
capture confirm numeric v _3livingbusinesslender
if !_rc {
label values _3livingbusinesslender living
}
else {

}
capture confirm numeric v _3snfindsuppliersdummyfam
if !_rc {
label values _3snfindsuppliersdummyfam yesno
}
else {

}
capture confirm numeric v _2methodfindjob
if !_rc {
label values _2methodfindjob methodfindjob
}
else {

}
capture confirm numeric v _2meetbusinesslender
if !_rc {
label values _2meetbusinesslender meet
}
else {

}
capture confirm numeric v remgift
if !_rc {
label values remgift yesno
}
else {

}
capture confirm numeric v _2finishwhatbegin
if !_rc {
label values _2finishwhatbegin personalityandbehavior
}
else {

}
capture confirm numeric v _2sncloserelouthhlabourrelation
if !_rc {
label values _2sncloserelouthhlabourrelation yesno
}
else {

}
capture confirm numeric v _3problemwork5
if !_rc {
label values _3problemwork5 problemwork
}
else {

}
capture confirm numeric v snhelpemergencyfriend
if !_rc {
label values snhelpemergencyfriend yesno
}
else {

}
capture confirm numeric v snhelpemergencywkp
if !_rc {
label values snhelpemergencywkp yesno
}
else {

}
capture confirm numeric v _2sncloserelouthhlabourtype
if !_rc {
label values _2sncloserelouthhlabourtype labourrelation
}
else {

}
capture confirm numeric v workpastsixmonth
if !_rc {
label values workpastsixmonth yesno
}
else {

}
capture confirm numeric v _2snfindsuppliersreciprocity1
if !_rc {
label values _2snfindsuppliersreciprocity1 yesno
}
else {

}
capture confirm numeric v _3snfindjobdistrict
if !_rc {
label values _3snfindjobdistrict district
}
else {

}
capture confirm numeric v _3sncloserelouthhfriend
if !_rc {
label values _3sncloserelouthhfriend yesno
}
else {

}
capture confirm numeric v _2sncloserelouthhsex
if !_rc {
label values _2sncloserelouthhsex sex
}
else {

}
capture confirm numeric v dummyhelptosettleloan
if !_rc {
label values dummyhelptosettleloan yesno
}
else {

}
capture confirm numeric v _3reasondontsearchjobsince15
if !_rc {
label values _3reasondontsearchjobsince15 reasondontsearchjob
}
else {

}
capture confirm numeric v _2snfindjobsex
if !_rc {
label values _2snfindjobsex sex
}
else {

}
capture confirm numeric v _3changemood
if !_rc {
label values _3changemood personalityandbehavior
}
else {

}
capture confirm numeric v _2inventive
if !_rc {
label values _2inventive personalityandbehavior
}
else {

}
capture confirm numeric v _2completeduties
if !_rc {
label values _2completeduties personalityandbehavior
}
else {

}
capture confirm numeric v _2Ab3
if !_rc {
label values _2Ab3 raventest
}
else {

}
capture confirm numeric v ego2random_1_2
if !_rc {
label values ego2random_1_2 yesno
}
else {

}
capture confirm numeric v workexposure4
if !_rc {
label values workexposure4 graduation
}
else {

}
capture confirm numeric v _3discrimination4
if !_rc {
label values _3discrimination4 yesno
}
else {

}
capture confirm numeric v _2B2
if !_rc {
label values _2B2 raventest
}
else {

}
capture confirm numeric v businesslabourertypejob
if !_rc {
label values businesslabourertypejob typejob
}
else {

}
capture confirm numeric v _2snrecruitworkerwkp
if !_rc {
label values _2snrecruitworkerwkp yesno
}
else {

}
capture confirm numeric v _2sncloserelouthhemployertype
if !_rc {
label values _2sncloserelouthhemployertype employertype
}
else {

}
capture confirm numeric v expressingthoughts
if !_rc {
label values expressingthoughts personalityandbehavior
}
else {

}
capture confirm numeric v migrationtravelpayment
if !_rc {
label values migrationtravelpayment migrationtravelpayment
}
else {

}
capture confirm numeric v _3dummyaspirationmorehours
if !_rc {
label values _3dummyaspirationmorehours yesno3
}
else {

}
capture confirm numeric v dummyremsent
if !_rc {
label values dummyremsent yesno
}
else {

}
capture confirm numeric v _2snrecommendforjobmeet
if !_rc {
label values _2snrecommendforjobmeet meet
}
else {

}
capture confirm numeric v businesslocation
if !_rc {
label values businesslocation migrationplace2
}
else {

}
capture confirm numeric v Ab7
if !_rc {
label values Ab7 raventest
}
else {

}
capture confirm numeric v _3snrecruitworkerfriend
if !_rc {
label values _3snrecruitworkerfriend yesno
}
else {

}
capture confirm numeric v _2snrecojobsuccessmeet
if !_rc {
label values _2snrecojobsuccessmeet meet
}
else {

}
capture confirm numeric v guarantordetailscaste
if !_rc {
label values guarantordetailscaste castes
}
else {

}
capture confirm numeric v _2sntalkthemostage
if !_rc {
label values _2sntalkthemostage agelist
}
else {

}
capture confirm numeric v curious
if !_rc {
label values curious personalityandbehavior
}
else {

}
capture confirm numeric v _2snfindsuppliers
if !_rc {
label values _2snfindsuppliers yesnosocialnetwork
}
else {

}
capture confirm numeric v _2A12
if !_rc {
label values _2A12 raventest
}
else {

}
capture confirm numeric v _3sntalkthemostwkp
if !_rc {
label values _3sntalkthemostwkp yesno
}
else {

}
capture confirm numeric v _2dummycontactleaders
if !_rc {
label values _2dummycontactleaders yesno
}
else {

}
capture confirm numeric v sexualaggression
if !_rc {
label values sexualaggression sexualagression
}
else {

}
capture confirm numeric v _3invitebusinesslender
if !_rc {
label values _3invitebusinesslender yesno
}
else {

}
capture confirm numeric v _3Ab8
if !_rc {
label values _3Ab8 raventest
}
else {

}
capture confirm numeric v loansettledgold
if !_rc {
label values loansettledgold yesno
}
else {

}
capture confirm numeric v _2snfindsuppliersdistrict
if !_rc {
label values _2snfindsuppliersdistrict district
}
else {

}
capture confirm numeric v ego2random_3_2
if !_rc {
label values ego2random_3_2 yesno
}
else {

}
capture confirm numeric v _2snrecruitworkerdistrict
if !_rc {
label values _2snrecruitworkerdistrict district
}
else {

}
capture confirm numeric v ego2random_1
if !_rc {
label values ego2random_1 yesno
}
else {

}
capture confirm numeric v snfindjobreciprocity1
if !_rc {
label values snfindjobreciprocity1 yesno
}
else {

}
capture confirm numeric v goingbackschool
if !_rc {
label values goingbackschool yesno
}
else {

}
capture confirm numeric v verbalaggression
if !_rc {
label values verbalaggression graduation2
}
else {

}
capture confirm numeric v ego2random_2_3
if !_rc {
label values ego2random_2_3 yesno
}
else {

}
capture confirm numeric v problemwork8
if !_rc {
label values problemwork8 problemwork
}
else {

}
capture confirm numeric v snfindjobcastes
if !_rc {
label values snfindjobcastes castes
}
else {

}
capture confirm numeric v snrecojobsuccessintimacy
if !_rc {
label values snrecojobsuccessintimacy intimacydegree
}
else {

}
capture confirm numeric v marriageloancaste
if !_rc {
label values marriageloancaste castes
}
else {

}
capture confirm numeric v _3losswork
if !_rc {
label values _3losswork yesno
}
else {

}
capture confirm numeric v executionwork3
if !_rc {
label values executionwork3 yesno
}
else {

}
capture confirm numeric v _2sncloserelouthhliving
if !_rc {
label values _2sncloserelouthhliving living
}
else {

}
capture confirm numeric v _3sntalkthemostlabourtype
if !_rc {
label values _3sntalkthemostlabourtype labourrelation
}
else {

}
capture confirm numeric v snrecruitworkerfriend
if !_rc {
label values snrecruitworkerfriend yesno
}
else {

}
capture confirm numeric v sntalkthemostfriend
if !_rc {
label values sntalkthemostfriend yesno
}
else {

}
capture confirm numeric v _3retirementwork
if !_rc {
label values _3retirementwork yesno
}
else {

}
capture confirm numeric v networktrustneighborhood
if !_rc {
label values networktrustneighborhood personalityandbehavior
}
else {

}
capture confirm numeric v _3snrecommendforjobdummyhh
if !_rc {
label values _3snrecommendforjobdummyhh yesno
}
else {

}
capture confirm numeric v migrationinsurance
if !_rc {
label values migrationinsurance yesno
}
else {

}
capture confirm numeric v _3lackskill
if !_rc {
label values _3lackskill yesno
}
else {

}
capture confirm numeric v sncloserelouthhwkp
if !_rc {
label values sncloserelouthhwkp yesno
}
else {

}
capture confirm numeric v casteemployer
if !_rc {
label values casteemployer casteemployer
}
else {

}
capture confirm numeric v _3discrimination3
if !_rc {
label values _3discrimination3 yesno
}
else {

}
capture confirm numeric v sncloserelouthhcompared
if !_rc {
label values sncloserelouthhcompared compared
}
else {

}
capture confirm numeric v _2rudetoother
if !_rc {
label values _2rudetoother personalityandbehavior
}
else {

}
capture confirm numeric v snrecommendforjoblabourrelation
if !_rc {
label values snrecommendforjoblabourrelation yesno
}
else {

}
capture confirm numeric v _2snfindcurrentjobcastes
if !_rc {
label values _2snfindcurrentjobcastes castes
}
else {

}
capture confirm numeric v _2understandotherfeeling
if !_rc {
label values _2understandotherfeeling personalityandbehavior
}
else {

}
capture confirm numeric v _3wagejobsocialsecurity
if !_rc {
label values _3wagejobsocialsecurity yesno
}
else {

}
capture confirm numeric v _3physicalagression
if !_rc {
label values _3physicalagression graduation2
}
else {

}
capture confirm numeric v physicalagression
if !_rc {
label values physicalagression graduation2
}
else {

}
capture confirm numeric v _2sncloserelouthhfriend
if !_rc {
label values _2sncloserelouthhfriend yesno
}
else {

}
capture confirm numeric v sncloserelouthhsex
if !_rc {
label values sncloserelouthhsex sex
}
else {

}
capture confirm numeric v snrecommendforjobinvite
if !_rc {
label values snrecommendforjobinvite yesno
}
else {

}
capture confirm numeric v canreadcard1c
if !_rc {
label values canreadcard1c literacy2
}
else {

}
capture confirm numeric v _2managestress
if !_rc {
label values _2managestress personalityandbehavior
}
else {

}
capture confirm numeric v _2executionwork7
if !_rc {
label values _2executionwork7 yesno
}
else {

}
capture confirm numeric v marriageloansettled
if !_rc {
label values marriageloansettled yesno
}
else {

}
capture confirm numeric v snfindsuppliersdummyfam
if !_rc {
label values snfindsuppliersdummyfam yesno
}
else {

}
capture confirm numeric v sncloserelouthhcastes
if !_rc {
label values sncloserelouthhcastes castes
}
else {

}
capture confirm numeric v migrationjobtype
if !_rc {
label values migrationjobtype typejob
}
else {

}
capture confirm numeric v dummymarriage
if !_rc {
label values dummymarriage yesno
}
else {

}
capture confirm numeric v _2resdiscrimination5
if !_rc {
label values _2resdiscrimination5 yesno
}
else {

}
capture confirm numeric v _2sncloserelouthhinvite
if !_rc {
label values _2sncloserelouthhinvite yesno
}
else {

}
capture confirm numeric v _2accidentalinjury
if !_rc {
label values _2accidentalinjury yesno
}
else {

}
capture confirm numeric v _2sncloserelouthhcastes
if !_rc {
label values _2sncloserelouthhcastes castes
}
else {

}
capture confirm numeric v _3curious
if !_rc {
label values _3curious personalityandbehavior
}
else {

}
capture confirm numeric v snfindsuppliersliving
if !_rc {
label values snfindsuppliersliving living
}
else {

}
capture confirm numeric v _2snrecommendforjobdummyfam
if !_rc {
label values _2snrecommendforjobdummyfam yesno
}
else {

}
capture confirm numeric v _3castebusinesslender
if !_rc {
label values _3castebusinesslender casteemployer
}
else {

}
capture confirm numeric v _3ego2random_3_3
if !_rc {
label values _3ego2random_3_3 yesno
}
else {

}
capture confirm numeric v _3covworkeffort
if !_rc {
label values _3covworkeffort workcovid
}
else {

}
capture confirm numeric v changework
if !_rc {
label values changework yesno
}
else {

}
capture confirm numeric v sntalkthemostemployertype
if !_rc {
label values sntalkthemostemployertype employertype
}
else {

}
capture confirm numeric v _2sntalkthemosteduc
if !_rc {
label values _2sntalkthemosteduc educlist
}
else {

}
capture confirm numeric v _2makeplans
if !_rc {
label values _2makeplans personalityandbehavior
}
else {

}
capture confirm numeric v _2sncloserelouthhmeetfrequency
if !_rc {
label values _2sncloserelouthhmeetfrequency meetfrequency
}
else {

}
capture confirm numeric v snfindjobwkp
if !_rc {
label values snfindjobwkp yesno
}
else {

}
capture confirm numeric v _3sntalkthemostintimacy
if !_rc {
label values _3sntalkthemostintimacy intimacydegree
}
else {

}
capture confirm numeric v _2reciprocity1businesslender
if !_rc {
label values _2reciprocity1businesslender yesno
}
else {

}
capture confirm numeric v covfrequencyinterest
if !_rc {
label values covfrequencyinterest yesnona
}
else {

}
capture confirm numeric v _3snrecommendforjobsex
if !_rc {
label values _3snrecommendforjobsex sex
}
else {

}
capture confirm numeric v _2dummybusinesspaidworkers
if !_rc {
label values _2dummybusinesspaidworkers yesno
}
else {

}
capture confirm numeric v _3covinstit5
if !_rc {
label values _3covinstit5 covinstit
}
else {

}
capture confirm numeric v snfindcurrentjobcastes
if !_rc {
label values snfindcurrentjobcastes castes
}
else {

}
capture confirm numeric v covinstit10
if !_rc {
label values covinstit10 covidscale
}
else {

}
capture confirm numeric v workpastsevendays
if !_rc {
label values workpastsevendays yesno
}
else {

}
capture confirm numeric v _2snrecojobsuccesslabourrelation
if !_rc {
label values _2snrecojobsuccesslabourrelation yesno
}
else {

}
capture confirm numeric v _2snfindjobcompared
if !_rc {
label values _2snfindjobcompared compared
}
else {

}
capture confirm numeric v _3resdiscrimination2
if !_rc {
label values _3resdiscrimination2 yesno
}
else {

}
capture confirm numeric v _3agreementatwork4
if !_rc {
label values _3agreementatwork4 agreementwork
}
else {

}
capture confirm numeric v locuscontrol6
if !_rc {
label values locuscontrol6 locusscale
}
else {

}
capture confirm numeric v _3snrecommendforjobruralurban
if !_rc {
label values _3snrecommendforjobruralurban rural
}
else {

}
capture confirm numeric v migrationbonus
if !_rc {
label values migrationbonus yesno
}
else {

}
capture confirm numeric v _2dummybusinessunpaidworkers
if !_rc {
label values _2dummybusinessunpaidworkers yesno
}
else {

}
capture confirm numeric v _3dummyassohelpjob
if !_rc {
label values _3dummyassohelpjob yesno
}
else {

}
capture confirm numeric v _3snrecommendassoage
if !_rc {
label values _3snrecommendassoage agelist
}
else {

}


***AJOUT DU 25-02-2021
label define leftreason 1"Studies" 2"To work permanently outside the village" 3"Get married" 4"Died" 77"Other"
capture confirm v reasonlefthome
if !_rc {
destring reasonlefthome, replace
}
else {

}
capture confirm numeric v reasonlefthome
if !_rc {
label values reasonlefthome leftreason
}
else {

}
