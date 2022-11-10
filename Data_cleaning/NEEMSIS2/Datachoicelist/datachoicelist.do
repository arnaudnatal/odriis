*** Ouverture de la base de données INDID2020 ***
use "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\INDID2020.dta"

*** Création de dummy pour savoir si dans le ménage Ego 1/Ego 2/Les deux on été interrogés ***
gen ego1id=1 if egoid==1
replace ego1id=0 if ego1id==.
tab ego1id
gen ego2id=1 if egoid==2
replace ego2id=0 if ego2id==.
tab ego2id
sort HHID
gen bothego=1 if ego1id==1|ego2id==1
tab bothego
replace bothego=0 if bothego==.
sort HHID
by HHID:egen bothegohere=sum(bothego)
sort HHID
by HHID:egen ego1here=sum(ego1id)
tab ego1here
by HHID:egen ego2here=sum(ego2id)
tab ego2here
drop ego1id ego2id bothego
save "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\INDID2020.dta", replace

*** Création des variables doubles pour faire les choice lists du questionnaire NEEMSIS 2 ***
* CHOICE LIST "villages"
label define villagename 1 "Elanthalmpattu" 2 "Govulapuram" 3 "Karumbur" 4 "Korattore" 5 "Kuvagam" 6 "Manapakkam" 7 "Manamthavizhinthaputhur" 8 "Natham" 9 "Oraiyure" 10 "Semakottai"
label values villageid villagename
decode villageid, gen(villagename)

* CHOICE LIST "villagelocation"
label define villagearea 1 "Elanthalmpattu Colony" 2 "Elanthalmpattu Ur" 3 "Govulapuram Ur" 4 "Karumbur Colony" 5 "Karumbur Ur" 6 "Korattore Colony" 7 "Korattore Ur" 8 "Kuvagam Colony" 9 "Kuvagam Ur" 10 "Manamthavizhinthaputhur Colony" 11 "Manamthavizhinthaputhur Ur" 12 "Manapakkam Colony" 13 "Manapakkam Ur" 14 "Natham Colony" 15 "Natham Ur" 16 "Oraiyure Colony" 17 "Oraiyure Ur" 18 "Semakottai Colony" 19 "Semakottai Ur"
label values villageareaid villagearea
decode villageareaid, gen(villagearea)

* CHOICE LIST "hhhead"
* Manipulation sur excel
gen dot1=","
gen dot2=","
gen brack1="("
gen brack2=")"
gen namehhhead=name if INDID==1
gen addresshhhead=address if INDID==1
gen uniqueidhhhead= HHID_panel if INDID==1
egen hhheadfinale=concat(namehhhead dot1 brack1 addresshhhead brack2 dot2 uniqueidhhhead)
* Fin des manipulations sur excel.

* CHOICE LIST "reasondontsearchjob"
gen reasondontsearchjobid=_n
replace reasondontsearchjobid=. if reasondontsearchjobid>15
label define reasondontsearchjob 1 "Studying/In school (student)" 2 "Home duties (housewife)" 3"In retirement" 4"Old age" 5"Ill" 6"Have a disability" 7"In compulsory military service" 8"Do not want to work" 9"Have already found a job which will start later" 10"Awaiting response from employer" 11"Awaiting recall by employer" 12"Waiting for busy season" 13"Believe I do not have any chance to get a job" 14"There are no jobs" 15"Refuse to work for low paid job"
label values reasondontsearchjobid reasondontsearchjob
decode reasondontsearchjobid, gen(reasondontsearchjob)
label define reasondontsearchjob_tamil 1"படித்து கொண்டிருத்தல் / பள்ளி (மாணவன்)" 2"வீட்டு கடமை (ஹவுஸ் ஒய்ப்)" 3"பணி ஓய்வு" 4"முதியோர்" 5"நோயுற்று" 6"உடல் ஊனமுற்றதால்" 7"கட்டாயமான இராணுவ சேவை" 8"வேலை செய்ய விருப்பமில்லை" 9"கிடைத்து விட்டது அப்புறம்" 10".முதலாளியின் பதிலுக்காக காத்திருத்தல்" 11"முதலாளியின் மறுபடியும் கூப்பிடுவார் என்று காத்திருத்தல்" 12"பிஸியான காலத்திற்காக காத்திருத்தல்" 13"வேலை கிடைக்க வாய்ப்பு இல்லை என நினைக்கிறேன்." 14"வேலை இல்லை" 15"REFUSE TO WORK FOR LOW PAID JOB"
label values reasondontsearchjobid reasondontsearchjob_tamil
decode reasondontsearchjobid, gen(reasondontsearchjob_tamil)
**Arnaud:pb with label 15 in tamil

* CHOICE LIST "relationshipwithinhh"
gen relationshipwithinhhid=_n
replace relationshipwithinhhid=. if  relationshipwithinhhid>18
replace relationshipwithinhhid=77 if relationshipwithinhhid==18
label define relationshipwithinhh 1"Head" 2"Wife" 3"Mother" 4"Father" 5"Son" 6"Daughter" 7"Son-in-law" 8"Daughter-in-law" 9"Sister" 10"Brother" 11"Mother-in-law" 12"Father-in-law" 13"Grandchild" 15"Grandfather" 16"Grandmother" 17"Cousin" 77"Other"
replace relationshipwithinhhid=. if relationshipwithinhhid==14
label values relationshipwithinhhid relationshipwithinhh
decode relationshipwithinhhid, gen(relationshipwithinhh)
label define relationshipwithinhh_tamil 1"தலைவர்" 2"மனைவி" 3"அம்மா" 4"அப்பா" 5"மகன்" 6"மகள்" 7"மருமகன்" 8"மருமகள்" 9"சகோதரி" 10"சகோதரன்" 11"மாமியார்" 12"மாமனார்" 13"பேரக் குழந்தை" 15"தாத்தா" 16"பாட்டி" 17"உறவினர்" 77"மற்றவை"
label values relationshipwithinhhid relationshipwithinhh_tamil
decode relationshipwithinhhid, gen(relationshipwithinhh_tamil)

* CHOICE LIST "classlist"
gen classlistid=_n
replace classlistid=. if classlistid>16
label define classlist 1"1st class" 2"2nd class" 3" 3rd class" 4"4st class" 5"5th class (primary school)" 6"6th class" 7"7th class" 8"8th class (upper primary)" 9"9th class" 10"10th class (high school/ITI)" 11"11th class" 12"12th class (senior secondary/technical training)" 15"Bachelors" 16"Above Bachelors"
replace classlistid=. if classlistid==14|classlistid==13
label values classlistid classlist
decode classlistid, gen(classlist)
label define classlist_tamil 1"முதலாம் வகுப்பு (அல்லது அதற்கும் குறைவு)" 2"இரண்டாம் வகுப்பு" 3"மூன்றாம் வகுப்பு" 4"நான்காம் வகுப்பு" 5"ஐந்தாம் வகுப்பு" 6"ஆறாம் வகுப்பு" 7"ஏழாம் வகுப்பு" 8"எட்டாம் வகுப்பு (நடுநிலை பள்ளி)" 9"ஒன்பதாம் வகுப்பு" 10"பத்தாம் வகுப்பு (மேல் நிலைப் பள்ளி / தொழிற் கல்வி ITI)" 11"பதினொன்றாம் வகுப்பு" 12"பண்ணிரெண்டாம் வகுப்பு (உயர்நிலை பள்ளி/ தொழில் நுட்ப பயிற்சி)" 15"இளங்களை டிகிரி படிப்பு" 16"அதற்கும் மேல்"
label values classlistid classlist_tamil
decode classlistid, gen(classlist_tamil)

* CHOICE LIST "lenders"
gen lendersid=_n
replace lendersid=. if lendersid>16
label define lenders 1"Well-know people" 2"Relatives" 3"Friend" 4"Employer" 5"Maistry" 6"Colleague" 7"Pawnbroker" 8"Shop keeper" 9"Microcredit: individual loan" 10"Microcredit: non-SHG group loan" 11"Microcredit: SHG" 12"Finance: daily finance/thandal" 13"Finance: other type of finance" 14"Bank: no coop" 15"Bank: coop" 16"Sugar mill loan"
label values lendersid lenders
decode lendersid, gen(lenders)
label define lenders_tamil 1"நன்றாக தெரிஞ்சவங்க"	2"உறவினர்கள்" 3"நண்பர்கள்" 4"முதலாளி" 5"மேஸ்திரி" 6"உடன் வேலை செய்பவர்" 7"அடகு பிடிப்பவர்" 8"கடைக்காரர்" 9"Microcredit: individual loan" 10"Microcredit: non-SHG group loan" 11"Microcredit: SHG" 12"Finance: daily finance/thandal" 13"Finance: other type of finance" 14"வங்கி" 15"கூட்டுறவு வங்கி" 16"சக்கரை ஆலை கடன்"
label values lendersid lenders_tamil
decode lendersid, gen(lenders_tamil)
**Arnaud:pb

* CHOICE LIST "castes"
gen castesid=_n
replace castesid=. if castesid>17
replace castesid=88 if castesid==17
label define castes 1"Vanniyar" 2"SC" 3"Arunthathiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"Mudaliar" 12"Kulalar" 13"Chettiyar" 14"Marwari" 15"Muslims" 16"Padayachi" 88"Don't know"
label values castesid castes
decode castesid, gen(castes)
label define castes_tamil 1"வன்னியர்"	2"(SC)ஆதி திராவிடர்"	3"அருந்ததியினர்"	4"ரெட்டியார்"	5"கிராமணி"	6"நாயுடு"	7"நாவிதர்"	8"ஆசாரி" 9"சேட்டு" 10"நாட்டார்" 11"முதலியார்" 12"குலாளர்" 13"செட்டியார்" 14"மார்வாரி" 15"முஸ்லிம்" 16"படையாட்சி" 88"தெரியவில்லை"
label values castesid castes_tamil
decode castesid, gen(castes_tamil)

* CHOICE LIST "productpledge"
gen productpledgeid=_n
replace productpledgeid=. if productpledgeid>16
replace productpledgeid=77 if productpledgeid==16
label define productpledge 1"Gold" 2"Land" 3"Car" 4"Bike" 5"Fridge" 6"Costly furniture (>10 000 rupees)" 7"Tailoring machine" 8"Cell phone" 9"Land line phone" 10"DVD" 11"Camera" 12"Cooking gas" 13"Computer" 14"Dish antenna" 15"None" 77"Other"
label values productpledgeid productpledge
decode productpledgeid, gen(productpledge)
label define productpledge_tamil 1"Gold"	2"நிலம்"	3"கார்"	4"பைக்"	5"பிரிட்ஸ்"	6"விலையுயர்ந்த நார்காலி, மேசைகள்"	7"டைலரிங் மிஷின்"	8"செல்போன்"	9"வீட்டு தொலைபேசி"	10"DVD"	11"கேமரா"	12"சமயல் கேஸ்"	13"கம்யூட்டர்"	14"டிஷ் ஆன்டனா"	15"ஒன்றும் இல்லை"	77"மற்றவை"
label values productpledgeid productpledge_tamil
decode productpledgeid, gen(productpledge_tamil)
**Arnaud:pb

* CHOICE LIST "listgoods"
gen listgoodsid=_n
replace listgoodsid=. if listgoodsid>17
replace listgoodsid=77 if listgoodsid==17
label define listgoods 1"Car" 2"Bike" 3"Fridge" 4"Costly furniture (>10 000 rupees)" 5"Tailoring machine" 6"Cell phone" 7"Landline phone" 8"DVD" 9"Camera" 10"Cooking gas" 11"Computer" 12"Dish antenna" 13"Air conditioner" 14"TV" 15"TV" 16"None" 77"Other"
label values listgoodsid listgoods
decode listgoodsid, gen(listgoods)
label define listgoods_tamil 1"கார்"	2"பைக்"	3"பிரிட்ஜ்"	4"விலை அதிகமான மேசை, நார்க்காலிகள் (ரு 10,000)"	5"டைலரிங் மிஷன்"	6"செல்போன்"	7"வீட்டு போன் (தொலைபேசி)"	8"DVD"	9"கேமரா"	10"சமயல் கேஸ்"	11"கம்யூட்டர்"	12"டிஷ் ஆண்டெனா"	13"Air conditioner" 14"TV" 15"TV" 16"ஒன்றும் இல்லை" 77"மற்றவை"
label values listgoodsid listgoods_tamil
decode listgoodsid, gen(listgoods_tamil)
**Arnaud:pb

* CHOICE LIST "casteemployer"
gen casteemployerid=_n
replace casteemployerid=. if casteemployerid>18
replace casteemployerid=66 if casteemployerid==17
replace casteemployerid=77 if casteemployerid==18
label define casteemployer 1"Vanniyar" 2"SC" 3"Arunthathiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"Mudaliar" 12"Kulalar" 13"Chettiyar" 14"Marwari" 15"Muslims" 16"Padayachi" 66"N/A" 77"Other"
label values casteemployerid casteemployer
decode casteemployerid, gen(casteemployer)
label define casteemployer_tamil 1"வன்னியர்"	2"SC"	3"அருந்ததியர்"	4"ரெட்டியார்"	5"கிராமிணி"	6"நாயுடு"	7"நாவிதர்"	8"ஆசாரி"	9"சேட்டு"	10"நாட்டார்"	11"முதலியார்"	12"குயவர்" 13"செட்டியார்"	14"மார்வாரி"	15"முஸ்லிம்"	16"படையாச்சி"	66"N/A"	77"மற்றவை"
label values casteemployerid casteemployer_tamil
decode casteemployerid, gen(casteemployer_tamil)

* CHOICE LIST "nbworkers"
gen nbworkersid=_n
replace nbworkersid=. if nbworkersid>16
label define nbworkers 16"More than 15" 1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 7"7" 8"8" 9"9" 10"10" 11"11" 12"12" 13"13" 14"14" 15"15"
label values nbworkersid nbworkers
decode nbworkersid, gen(nbworkers)
label define nbworkers_tamil 16"15க்கு மேல்" 1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 7"7" 8"8" 9"9" 10"10" 11"11" 12"12" 13"13" 14"14" 15"15"
label values nbworkersid nbworkers_tamil
decode nbworkersid, gen(nbworkers_tamil)


* CHOICE LIST "district"
gen districtid=_n
replace districtid=. if districtid>37
label define district 1"Ariyalur" 2"Chengalpet" 3"Chennai" 4"Coimbatore" 5"Cuddalore" 6"Dharmapuri" 7"Dindigul" 8"Erode" 9"Kallakurichi" 10"Kancheepuram" 11"Karur" 12"Krishnagiri" 13"Madurai" 14"Nagapattinam" 15"Kanyakumari" 16"Nagercoil" 17"Namakkal" 18"Perambalur" 19"Pudukottai" 20"Ramanathapuram" 21"Ranipet" 22"Salem" 23"Sivagangai" 24"Tenkasi" 25"Thanjavur" 26"Theni" 27"Thiruvallur" 28"Tuticorin" 29"Trichirappalli" 30"Thirunelveli" 31"Tirupattur" 32"Tiruppur" 33"Thiruvannamalai" 34"The Nilgiris" 35"Vellore" 36"Viluppuram" 37"Virudhunagar"
label values districtid district
decode districtid, gen(district)

save "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\INDID2020.dta", replace

***************

* Traitement des anciens ménages dont hhheadfinale n'a pas pu être reconstituée à partir des données de NEEMSIS 1
decode householdid, gen(householdidstr)
replace hhheadfinale=householdidstr if hh2016==0
save "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\INDID2020.dta", replace

*Traitement des nouveaux ménages potentiels
append using "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\hhheadfinale_newhousehold.dta"
save "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\INDID2020.dta", replace

* Réduction du nombre de variables dans la base INDID2020
drop HHID2010 dummynewHH dummydemonetisation INDID2010 interviewplace lefthomedurationlessoneyear lefthomedurationmoreoneyear lefthomedestination lefthomereason dummypermanentmigrantwork canread classcompleted after10thstandard durationafter10th typeofhigheredu subjectsafter10th othersubjectsafter10th currentlyatschool educationexpenses amountschoolfees bookscost transportcost reasonneverattendedschool reasondropping otherreasondroppingschool dummyscholarship scholarshipamount scholarshipduration converseinenglish dummyworkedpastyear reasonnotworkpastyear stoppedworking username submissiondate villageid_new villageid_new_comments tracked
drop villageid_str n1 villageid_lab value_householdid_2020 dummyHHlost2016 sex1 dot1 dot2 brack1 brack2 namehhhead addresshhhead uniqueidhhhead _merge


*******************

*** Retrait de tous les choice lists excédentaires du forme design ***

* CHOICE LIST "yesno"
gen yesnoid=_n
replace yesnoid=. if yesnoid>2
replace yesnoid=0 if yesnoid==2
label define yesno 0"No" 1"Yes"
label values yesnoid yesno
decode yesnoid, gen (yesno)
label define yesno_tamil 1"சரி" 0"இல்லை"
label values yesnoid yesno_tamil
decode yesnoid, gen(yesno_tamil)

* CHOICE LIST "Sex"
gen sexid=_n
replace sexid=. if sexid>2
label define sex 1"Male" 2"Female"
label values sexid sex
decode sexid, gen (sex)
label define sex_tamil 1"ஆண்" 2"பெண்"
label values sexid sex_tamil
decode sexid, gen(sex_tamil)

* CHOICE LIST "Sex1"
gen sex1id=_n
replace sex1id=. if sex1id>3
replace sex1id=66 if sex1id==3
label define sex1 1"Male" 2"Female" 66"N/A"
label values sex1id sex1
decode sex1id, gen (sex1)
label define sex1_tamil 1"ஆண்" 2"பெண்" 66"எதுவும் இல்லை"
label values sex1id sex1_tamil
decode sex1id, gen(sex1_tamil)

* CHOICE LIST "religion"
gen religionid=_n
replace religionid=. if religionid>4
replace religionid=77 if religionid==4
label define religion 1"Hindu" 2"Christian" 3"Muslim" 77"Other"
label values religionid religion
decode religionid, gen (religion)
label define religion_tamil 1"இந்து"	2"கிறிஸ்டியன்"	3"முஸ்லிம்"	4"மற்றவை"
label values religionid religion_tamil
decode religionid, gen(religion_tamil)

* CHOICE LIST "frequency"
gen frequencyid=_n
replace frequencyid=. if frequencyid>6
label define frequency 1"Weekly" 2"Monthly" 3"Yearly" 4"Once in 6 months" 5"Fixed amount" 6"Pay whenever have money"
label values frequencyid frequency
decode frequencyid, gen (frequency)
label define frequency_tamil 1"வாரம்"	2"மாதம்"	3"ஆண்டு"	4"6 மாதத்திற்கு ஒரு முறை"	5"நிலையான தொகை"	6"பணம் இருக்கும் போது அளிப்பது"
label values frequencyid frequency_tamil
decode frequencyid, gen(frequency_tamil)

* CHOICE LIST "maritalstatus"
gen maritalstatusid=_n
replace maritalstatusid=. if maritalstatusid>5
replace maritalstatusid=66 if maritalstatusid==5
label define maritalstatus 1"Married" 2"Unmarried (above 10)" 3"Widowed" 4"Separated/divorced" 66"N/A (if below 10)"
label values maritalstatusid maritalstatus
decode maritalstatusid, gen (maritalstatus)
label define maritalstatus_tamil 1"திருமணம் ஆனவர்"	2"திருமணம் ஆகாதவர் (10 வயதுக்கு மேல்)"	3"விதவை"	4"பிரிந்து இருத்தல் / விவாகரத்து"	5"எதுவும் இல்லை (10 வயதுக்கு குறைவாக இருந்தால்)"
label values maritalstatusid maritalstatus_tamil
decode maritalstatusid, gen(maritalstatus_tamil)

* CHOICE LIST "username"
gen usernameid=_n
replace usernameid=. if usernameid>8
label define username 1"Antoni" 2"Vivek Radja" 3"Venkata"
label values usernameid username
decode usernameid , gen (username)
label define username_tamil 1"அந்தோணி ராஜ்"	2"விவேக் ராஜா"	3"குமரேசன்"	4"சித்தானந்தம்"	5"மாயன்"	6"ராஜா அண்ணாமலை"	7"பழனி"	8"வெங்கட்"
label values usernameid username_tamil
decode usernameid, gen(username_tamil)

* CHOICE LIST "subjects"
gen subjectsid=_n
replace subjectsid=. if subjectsid>8
replace subjectsid=66 if subjectsid==7
replace subjectsid=77 if subjectsid==8
label define subjects 1"Arts (social sciences, economics, commerce)" 2"Science (biology, chemistry, physics)" 3"Engineering" 4"Medical/Nursing school" 5"Industrial/technical institutions (ITI)" 6"Home sciences/Craft/Design" 66"N/A" 77"Other"
label values subjectsid subjects
decode subjectsid, gen (subjects)
label define subjects_tamil 1"கலை (சமூக அறிவியல், பொருளாதாரம், காமர்ஸ் வணிகம்)"	2"அறிவியல் (உயிரியல், வேதியியல், இயற்பியல்)"	3"இன்ஜினியரிங் (பொறியியல்)"	4"மருத்துவம் / நர்சிங் பள்ளி"	5"தொழில் துறை / தொழில் நுட்ப கல்வி (ITI)"	6"ஹோம் சயன்ஸ் / கைவினை (கிராப்ட்) / டிசைன்"	66"எதுவும் இல்லை" 77"மற்றவை"
label values subjectsid subjects_tamil
decode subjectsid, gen(subjects_tamil)

* CHOICE LIST "reasondroppingout"
gen reasondroppingoutid=_n
replace reasondroppingoutid=. if reasondroppingoutid>15
replace reasondroppingoutid=77 if reasondroppingoutid==15
label define reasondroppingout 1"Stopped after end of education cycle" 2"Failed" 3"Too far/ Inaccessible" 4"Poor quality/lack of facilities" 5"Financial problems" 6"Health problems" 7"Not interested in school" 8"Household work / Child care" 9"Work for pay" 10"Lack of separate school/college for girls" 11"Marriage" 12"Parents/husband didn't allow studying further" 13"Puberty / Gender" 14"Too young" 77"Other"
label values reasondroppingoutid reasondroppingout
decode reasondroppingoutid, gen (reasondroppingout)
label define reasondroppingout_tamil 1"படிப்பு முடிந்தவுடன் நிறுத்திவிட்டார்"	2"பெயில்"	3"தொலைதூரம் / வசதி இல்லை"	4"தரம் இல்லாமை / வசதி இல்லாமை"	5"நிதி (பினான்சியல்) பிரச்சனை"	6"உடல் நிலை குறைவு பிரச்சனை"	7"பள்ளிக்கு செல்ல ஆர்வம் இல்லை"	8"வீட்டு வேலை / குழந்தைகளை பார்த்துகொள்ளுதல்"	9"சம்பளத்திற்கான வேலை"	10"தனியாக பள்ளி இல்லாமை / பெண்களுக்கான கல்லூரி"	11"திருமணம்"	12"பெற்றோர் / கணவன் படிக்க அனுமதிக்கவில்லை"	13"மஞ்சள் நீர் / பாலினம்" 14"மிகவும் இளமை" 77"மற்றவை"
label values reasondroppingoutid reasondroppingout_tamil
decode reasondroppingoutid, gen(reasondroppingout_tamil)


* CHOICE LIST "reasonneverattendedschool"
gen reasonneverattendedschoolid=_n
replace reasonneverattendedschoolid=. if reasonneverattendedschoolid>13
label define reasonneverattendedschool 1"Failed" 2"Too far/ Inaccessible" 3"Poor quality/lack of facilities" 4"Financial problems" 5"Health problems" 6"Not interested in school" 7"Household work / Child care" 8"Work for pay" 9"Lack of separate school/college for girls" 10"Marriage" 11"Parents/husband didn't allow studying further" 12"Puberty / Gender" 13"Too young (baby)"
label values reasonneverattendedschoolid reasonneverattendedschool
decode reasonneverattendedschoolid, gen (reasonneverattendedschool)
label define reasonneverattendedschool_tamil 1"பெயில்"	2"தொலைதூரம் / வசதி இல்லை"	3"தரம் இல்லாமை / வசதி இல்லாமை"	4"நிதி (பினான்சியல்) பிரச்சனை"	5"உடல் நிலை குறைவு பிரச்சனை"	6"பள்ளிக்கு செல்ல ஆர்வம் இல்லை"	7"வீட்டு வேலை / குழந்தைகளை பார்த்துகொள்ளுதல்"	8"சம்பளத்திற்கான வேலை"	9"தனியாக பள்ளி இல்லாமை / பெண்களுக்கான கல்லூரி"	10"திருமணம்"	11"பெற்றோர் / கணவன் படிக்க அனுமதிக்கவில்லை"	12"மஞ்சள் நீர் / பாலினம்"	13"குழந்தை"
label values reasonneverattendedschoolid reasonneverattendedschool_tamil
decode reasonneverattendedschoolid, gen(reasonneverattendedschool_tamil)

* CHOICE LIST "nbermonth"
gen nbermonthid=_n
replace nbermonthid=. if nbermonthid>14
replace nbermonthid=0 if nbermonthid==14
label define nbermonth 0"<1 month" 1"1 month" 2"2 months" 3"3 months" 4"4 months" 5"5 months" 6"6 months" 7"7 months" 8"8 months" 9"9 months" 10"10 months" 11"11 months" 12"12 months" 13"More than 1 year"
label values nbermonthid nbermonth
decode nbermonthid, gen (nbermonth)
label define nbermonth_tamil 0"ஒரு மாதத்திற்கும் குறைவு"	1"1 மாதம்"	2"2 மாதங்கள்"	3"3 மாதங்கள்"	4"4 மாதங்கள்"	5"5 மாதங்கள்"	6"6 மாதங்கள்"	7"7 மாதங்கள்"	8"8 மாதங்கள்"	9"9 மாதங்கள்"	10"10 மாதங்கள்"	11"11 மாதங்கள்"	12"12 மாதங்கள்"	13"ஓராண்டிற்கு மேலாக"
label values nbermonthid nbermonth_tamil
decode nbermonthid, gen(nbermonth_tamil)

* CHOICE LIST "methodfindjob"
gen methodfindjobid=_n
replace methodfindjobid=. if methodfindjobid>11
replace methodfindjobid=66 if methodfindjobid==10
replace methodfindjobid=99 if methodfindjobid==11
label define methodfindjob 1"THROUGH SOCIAL NETWORK: FRIENDS" 2"THROUGH SOCIAL NETWORK: RELATIVES" 3"THROUGH SOCIAL NETWORK: OTHER" 4"CONTACT EMPLOYERS DIRECTLY (VISIT/SEND LETTERS/APPLICATION)" 5"THROUGH PUBLIC EMPLOYMENT AGENCY" 6"THROUGH PRIVATE EMPLOYMENT AGENCY" 7"THROUGH UNIVERSITY/SCHOOL CAREERS' OFFICE" 8"RESPOND TO MEDIA AD/ PUT AD IN PAPER" 9"SEARCH ON INTERNET/ POSTED ON INTERNET" 66"N/A" 99"No response"
label values methodfindjobid methodfindjob
decode methodfindjobid, gen (methodfindjob)
label define methodfindjob_tamil 1"வெளியுலக தொடர்பு: நண்பர்கள்"	2"வெளியுலக தொடர்பு: உறவினர்கள்"	3"வெளியுலக தொடர்பு: மற்றவை"	4"நேரடியாக முதலாளியை தொடர்பு கொள்ளுதல்"	5"பொது வேலை வாய்ப்பு நிறுவனம் மூலமாக"	6"தனியார் வேலை வாய்ப்பு நிறுவனம் மூலமாக"	7"பல்கலைகழகம் மூலமாக / பள்ளியின் வேலைவாய்ப்பு நிறுவனம்"	8"ஊடகம் (மீடியா) மூலம் விளம்பரம் / செய்தித்தாளில் விளம்பரம்"	9"இன்டர்நெட் மூலம் தேடுதல்/இன்டர்நெட்டில்"	99"பதில் இல்லை"	66"N/A"
label values methodfindjobid methodfindjob_tamil
decode methodfindjobid, gen(methodfindjob_tamil)

* CHOICE LIST "startbusinessorfarm"
gen startbusinessorfarmid=_n
replace startbusinessorfarmid=. if startbusinessorfarmid>3
label define startbusinessorfarm 1"YES, I DID SET UP A BUSINESS/FARM" 2"YES I TRIED BUT DID NOT SUCCEED IN SETTING UP A BUSINESS/FARM" 3"NO, I NEVER TRIED" 
label values startbusinessorfarmid startbusinessorfarm
decode startbusinessorfarmid, gen (startbusinessorfarm)
label define startbusinessorfarm_tamil 1"ஆம். நான் தொழில் நிறுவனத்தை அமைத்தேன்/தொழில்" 2"ஆம், நான் தொழில் / நிறுவனத்தை அமைக்க முயற்சி செய்தேன் ஆனால் வெற்றி அடையவில்லை" 3"இல்லை, நான் முயற்சிக்க வில்லை"
label values startbusinessorfarmid startbusinessorfarm_tamil
decode startbusinessorfarmid, gen(startbusinessorfarm_tamil)

* CHOICE LIST "personalityandbehavior"
gen personalityandbehaviorid=_n
replace personalityandbehaviorid=. if personalityandbehaviorid>6
replace personalityandbehaviorid=99 if personalityandbehaviorid==6
label define personalityandbehavior 1"1 - Almost always" 2"2 - Quite often" 3"3 - Sometimes" 4"4 - Rarely" 5"5 - Almost never" 99"No response"
label values personalityandbehaviorid personalityandbehavior
decode personalityandbehaviorid, gen (personalityandbehavior)
label define personalityandbehavior_tamil 1"1. எப்பொழுதும்"	2"2. அடிக்கடி"	3"3. சில நேரங்களில்"	4"4. எப்பொழுதாவது"	5"5. எப்பொழுதும் இல்லை"	99"6. பதில் இல்லை"
label values personalityandbehaviorid personalityandbehavior_tamil
decode personalityandbehaviorid, gen(personalityandbehavior_tamil)

* CHOICE LIST "kindofwork"
gen kindofworkid=_n
replace kindofworkid=. if kindofworkid>8
label define kindofwork 1"Agricultural activity on own household farm" 2"Self-employed, own account worker, an owner with or without hired labour (non-agri)" 3"Salaried job (agri in another farm)" 4"Salaried job (non-agri, in industry, services...)" 5"Unpaid worker in household business (non-agri)" 6"Unpaid worker in other business (non-agri)" 7"Unpaid worker in own farm" 8"Unpaid worker in another farm"
label values kindofworkid kindofwork
decode kindofworkid, gen (kindofwork)
label define kindofwork_tamil 1"உங்கள் சொந்த நிலத்தில் விவசாயம்"	2"சுய தொழில், முதலாளி, பணி ஆட்களை நியமிக்கும் அல்லது நியமிக்காத முதலாளி (விவசாயம் சாராத)"	3"சம்பள வேலை (வேறு நிலத்தில் விவசாயம் அல்லது விவசாயம் சாராதது)"	4"சம்பள வேலை ( விவசாயம் அல்லாத, தொழிற்சாலை...)"	5"குடும்ப தொழிலின் கூலி வாங்காத வேலை ஆள் (விவசாயம் சாரதது)" 6"கூலி வாங்காத வேலையாள் (விவசாயம் சாராத)" 7"சொந்த நிலத்தில் வேலை செய்யும் சம்பளம் வாங்காத வேலையாள்" 8"வேறொருவர் நிலத்தில் வேலை செய்யும் சம்பளம் வாங்காத வேலையாள்"
label values kindofworkid kindofwork_tamil
decode kindofworkid, gen(kindofwork_tamil)

* CHOICE LIST "sourceinvestment"
gen sourceinvestmentid=_n
replace sourceinvestmentid=. if sourceinvestmentid>10
replace sourceinvestmentid=77 if sourceinvestmentid==10
label define sourceinvestment 1"Loans or grants from relatives" 2"Bank loan (private bank, coop bank, SHG loan)" 3"Informal loan (traders, landlords, moneylenders)" 4"Household savings or sails of assets" 5"Money from inheritance" 6"Profits from other household enterprises" 7"Did not need funds to start it because inherited business" 8"Did not need funds to start it because it didn't need much capital" 9"Goverment schemes/Public subsidies" 77"Other"
label values sourceinvestmentid sourceinvestment
decode sourceinvestmentid, gen (sourceinvestment)
label define sourceinvestment_tamil 1"உறவினர்களிடமிருந்து கடன்கள் அல்லது மானியம்" 2"வாங்கி கடன் (தனியார் வங்கி, கூட்டுறவு வாங்கி, சுய உதவி குழு கடன்)" 3"முறைசாரா கடன் (வர்த்தகர்கள், நில உரிமையாளர்கள், வட்டிக்கு பணம் கொடுப்பவர்கள்)" 4"குடும்ப சேமிப்பு மற்றும் சொத்துக்கள்" 5"பரம்பரை சொத்து" 6"வீட்டில் உள்ளவர்களின் தொழிலில் இருந்து வரும் லாபம்" 7"தொழில் ஆரமிக்க பணம் தேவை இல்லை ஏனெனில் இது பரம்பரை தொழில்" 8"தொழில் ஆரமிக்க பணம் தேவை இல்லை ஏனெனில் இந்த தொழிலுக்கு அதிக பணம் தேவை இல்லை" 9"அரசு திட்டங்கள் / பொது மானியங்கள்" 77"மற்றவை"
label values sourceinvestmentid sourceinvestment_tamil
decode sourceinvestmentid, gen(sourceinvestment_tamil)

* CHOICE LIST "skillbusiness"
gen skillbusinessid=_n
replace skillbusinessid=. if skillbusinessid>4
label define skillbusiness 1"From family" 2"From friends" 3"From school" 4"Experience"
label values skillbusinessid skillbusiness
decode skillbusinessid, gen (skillbusiness)
label  define skillbusiness_tamil 1"குடும்பத்திலிருந்து"	2"நண்பர்களிடமிருந்து"	3"பள்ளியிலிருந்து"	4"அனுபவம்"
label values skillbusinessid skillbusiness_tamil
decode skillbusinessid, gen(skillbusiness_tamil)

* CHOICE LIST "yesno3"
gen yesno3id=_n
replace yesno3id=. if yesno3id>3
replace yesno3id=0 if yesno3id==1
replace yesno3id=1 if yesno3id==2
replace yesno3id=99 if yesno3id==3
label define yesno3 0"No" 1"Yes" 99"No response"
label values yesno3id yesno3
decode yesno3id, gen (yesno3)
label define yesno3_tamil 0"இல்லை" 1"ஆம்" 99"பதில் இல்லை"
label values yesno3id yesno3_tamil
decode yesno3id, gen(yesno3_tamil)

* CHOICE LIST "typejob"
gen typejobid=_n
replace typejobid=. if typejobid>4
label define typejob 1"Permanent/ long term (i.e. government job)" 2"Fixed term (limited contract) (i.e. NREGA)" 3"Daily (i.e. agri coolie)" 4"Seasonal (i.e. brick kiln)"
label values typejobid typejob
decode typejobid, gen (typejob)
label define typejob_tamil 1"நிரந்தரம் / நீண்ட காலம் உதாரணம் (அரசாங்க வேலை)"	2"குறிப்பிட்ட காலம் (குறிப்பிட்ட ஒப்பந்தம்) உதாரணம் NREGA)"	3"தினமும் (உதாரணம் விவசாய கூலி)"	4"சீசனல் (பருவ காலம்) (செங்கல் வேலை)"
label values typejobid typejob_tamil
decode typejobid, gen(typejob_tamil)
**Arnaud:pb with 5"Occasional" ?

* CHOICE LIST "wagetype"
gen wagetypeid=_n
replace wagetypeid=. if wagetypeid>5
label define wagetype 1"Daily" 2"Weekly" 3"Monthly" 4"Piece rate" 5"Unpaid"
label values wagetypeid wagetype
decode wagetypeid, gen (wagetype)
label define wagetype_tamil 1"தினமும்"	2"வாரம்"	3"மாதம்"	4"வேலை செய்ததற்கு ஏற்ற கூலி"	5"சம்பளம் இல்லாத"
label values wagetypeid wagetype_tamil
decode wagetypeid, gen(wagetype_tamil)

* CHOICE LIST "relation"
gen relationid=_n
replace relationid=. if relationid>13
replace relationid=66 if relationid==12
replace relationid=99 if relationid==13
label define relation 1"Labour relation" 2"Relative" 3"Political" 4"Religious" 5"Neighbor" 6"SHG" 7"Business man" 8"Therinjavanga (well-known people)" 9"Traditional" 10"Friend" 11"Group finance" 66"N/A (if scheme, institution, big company...)" 99"No response"
label values relationid relation
decode relationid, gen (relation)
label define relation_tamil 1"தொழிலாளர் உறவு"	2"உறவினர்கள்"	3"அரசியல்"	4"மதம் சார்ந்த"	5"அக்கம் பக்கத்தினர்"	6"சுய உதவிக்குழு "	7"தொழிலதிபர்"	8"தெரிஞ்சவங்க"	9"பாரம்பரியம்"	10"நண்பர்கள்"	11"கூட்டு கடன்"	66"ஒன்றும் இல்லை (திட்டங்கள், நிறுவனம், பெரிய கம்பெனி.....)" 99"No response"
label values relationid relation_tamil
decode relationid, gen(relation_tamil)
**Arnaud:pb

* CHOICE LIST "relationlabourer"
gen relationlabourerid=_n
replace relationlabourerid=. if relationlabourerid>9
label define relationlabourer 1"Household member" 2"Relative" 3"Labour relation" 4"Political" 5"Religious" 6"Neighbor" 7"SHG member" 8"Traditional" 9"Friend"
label values relationlabourerid relationlabourer
decode relationlabourerid, gen (relationlabourer)
label define relationlabourer_tamil 1"குடும்ப உறுப்பினர்"	2"உறவினர்கள்"	3"தொழிலாளர் உறவு"	4"அரசியல்"	5"மதம் சார்ந்த"	6"அக்கம் பக்கத்தினர்"	7"சுய உதவிக்குழு உறுப்பினர்"	8"பாரம்பரியம்"	9"நண்பர்கள்"
label values relationlabourerid relationlabourer_tamil
decode relationlabourerid, gen(relationlabourer_tamil)

* CHOICE LIST "typejob2"
gen typejob2id=_n
replace typejob2id=. if typejob2id>2
label define typejob2 1"Full time" 2"Part time"
label values typejob2id typejob2
decode typejob2id, gen (typejob2)
label define typejob2_tamil 1"முமூ நேரம்" 2"பகுதி நேரம்"
label values typejob2id typejob2_tamil
decode typejob2id, gen(typejob2_tamil)

* CHOICE LIST "associationlist"
gen associationlistid=_n
replace associationlistid=. if associationlistid>13
label define associationlist 1"Youth Union" 2"SHG Group" 3"Trade Union" 4"Farmer Union" 5"Village council (panchayat)" 6"Political party" 7"Professional (occupational) association" 8"Market committee" 9"Religious group" 10"Hobby club, sports group, cultural association" 11"Alumni association" 12"Other association" 13"None"
label values associationlistid associationlist
decode associationlistid, gen (associationlist)
label define associationlist_tamil 1"இளைஞர் ஒன்றியம்"	2"சுய உதவிகுழு"	3"தொழிற் சங்கம்"	4"விவசாயம் சங்கம்"	5"கிராம சபை"	6"அரசியல் கட்சி"	7"தொழில் முறை (தொழில்சார்) சங்கம்"	8"சந்தை குழு"	9"மதம் சார்ந்த குழு பொழுது போக்கு கிளப், விளையாட்டு குழு, கலாச்சார சங்கம்"	10"பொழுது போக்கு கிளப், விளையாட்டு குழு, கலாச்சார சங்கம்"	11"முன்னாள் மாணவர்கள் சங்கம்"	12"மற்ற சங்கம்"	13"ஒன்றும் இல்லை"
label values associationlistid associationlist_tamil
decode associationlistid, gen(associationlist_tamil)

* CHOICE LIST "assodegreeparticip"
gen assodegreeparticipid=_n
replace assodegreeparticipid=. if assodegreeparticipid>3
label define assodegreeparticip 1"Leader" 2"Active" 3"Simple member"
label values assodegreeparticipid assodegreeparticip
decode assodegreeparticipid, gen (assodegreeparticip)
label define assodegreeparticip_tamil 1"தலைவர் (வழிகாட்டி)" 2"சுறுசுறுப்பான" 3"சாதாரண உறுப்பினர்"
label values assodegreeparticipid assodegreeparticip_tamil
decode assodegreeparticipid, gen(assodegreeparticip_tamil)

* CHOICE LIST "nbpeople"
gen nbpeopleid=_n
replace nbpeopleid=. if nbpeopleid>5
replace nbpeopleid=88 if nbpeopleid==5
label define nbpeople 1"2-10 " 2"11-50" 3"51-100" 4">100" 88"Don't know"
label values nbpeopleid nbpeople
decode nbpeopleid, gen (nbpeople)
label define nbpeople_tamil 1"2-10 "	2"11-50 "	3"51-100"	4"100க்கு மேல்"	88"தெரியவில்லை"
label values nbpeopleid nbpeople_tamil
decode nbpeopleid, gen(nbpeople_tamil)

* CHOICE LIST "assohelpjob"
gen assohelpjobid=_n
replace assohelpjobid=. if assohelpjobid>6
replace assohelpjobid=77 if assohelpjobid==6
label define assohelpjob 1"Someone from association hired you" 2"Someone from association referred you" 3"Someone from association shared job openings" 4"Help with application (prep documents)" 5"Emotional support" 77"Other"
label values assohelpjobid assohelpjob
decode assohelpjobid, gen (assohelpjob)
label define assohelpjob_tamil 1"சங்கத்தில் உள்ள ஒருவர் உங்களுக்கு வேலை கொடுத்தல்"	2"சங்கத்தில் உள்ள ஒருவர் உங்களுக்கு சிபாரிசு செய்தல்"	3"சங்கத்தில் உள்ள ஒருவர் வேலை வாய்ப்புகளை பகிர்ந்து கொள்ளுதல்"	4"விண்ணப்பங்களுக்கு உதவி செய்தல் (ஆவணங்களை தயார் செய்ய)"	5"எந்த சூழலிலும் உடன் இருப்பார்களா"	77"மற்றவை"
label values assohelpjobid assohelpjob_tamil
decode assohelpjobid, gen(assohelpjob_tamil)

* CHOICE LIST "assohelpbusiness"
gen assohelpbusinessid=_n
replace assohelpbusinessid=. if assohelpbusinessid>8
replace assohelpbusinessid=77 if assohelpbusinessid==8
label define assohelpbusiness 1"Advice on how to run business (managerial support, accounting)" 2"New information useful for business" 3"New customers/suppliers" 4"Find/Improve premises" 5"Financial support" 6"Other material support" 7"Emotional support" 77"Other"
label values assohelpbusinessid assohelpbusiness
decode assohelpbusinessid, gen (assohelpbusiness)
label define assohelpbusiness_tamil 1"எப்படி தொழில் செய்வது என்று ஆலோசனை வழங்குதல். (நிர்வாக ஆதரவு, கணக்கியலில்)"	2"தொழிலுக்கான பயனுள்ள புதிய தகவல்கள்"	3"புதிய வாடிக்கையாளர்கள் / வினியோகஸ்தர்கள்"	4"வியாபார இடத்தை சிறப்பாக்க உதவி செய்தல்"	5"நிதி உதவி"	6"மற்ற பொருட்கள் உதவி"	7"எந்த சூழலிலும் உடன் இருப்பார்களா"	77"மற்றவை"
label values assohelpbusinessid assohelpbusiness_tamil
decode assohelpbusinessid, gen(assohelpbusiness_tamil)

* CHOICE LIST "contactlist"
gen contactlistid=_n
replace contactlistid=. if contactlistid>9
label define contactlist 1"Head of business in the same sector" 2"Policeman" 3"Civil servant" 4"Formal bank employee or microcredit institution" 5"Village committe (panchayat)" 6"People council (caste-based)" 7"Recruiter for a firm or in employment office" 8"Head of a trade union" 9"None"
label values contactlistid contactlist
decode contactlistid, gen (contactlist)
label define contactlist_tamil 1"அதே தொழிலின் தலைவர்"	2"போலிஸ்"	3"சிவில் பணியாளர்"	4"முறையான வங்கி ஊழியர் அல்லது சிறுகடன் நிறுவனம் (SGH, NGO, சிறுகடன் அளிக்கும் வங்கி)"	5"கிராம குழு (பஞ்சாயத்து)"	6"மக்கள் சபை"	7"வேலை வாய்ப்பு அலுவலகத்திலோ அல்லது நிறுவனத்திலே வேலை வாய்ப்பை தேடி தருபவர்"	8"தொழிற் சங்க தலைவர்"	9"ஒன்றும் இல்லை"
label values contactlistid contactlist_tamil
decode contactlistid, gen(contactlist_tamil)

* CHOICE LIST "months"
gen monthsid=_n
replace monthsid=. if monthsid>12
label define months 1"Chithirai (april-may)" 2"Vaikasi (may-june)" 3"Aani (june-july)" 4"Aadi (july-august)" 5"Aavani (august-september)" 6"Purataasi (september-october)" 7"Iypasi (october-november)" 8"Karthigai (november-december)" 9"Maargazhi (december-january)" 10"Thai (january-february)" 11"Maasi (february-march)" 12"Panguni (march-april)"
label values monthsid months
decode monthsid, gen (months)
label define months_tamil 1"சித்திரை (ஏப்ரல் - மே)"	2"வைகாசி (மே- ஜூன்)"	3"ஆனி (ஜூன் - ஜூலை)"	4"ஆடி (ஜூலை - ஆகஸ்ட்)"	5"ஆவணி (அகஸ்ட் – செப்டம்பர்)"	6"புரட்டாசி (செப்டம்பர் - அக்டோபர்)"	7"ஐப்படி (அக்டோபர் - நவம்பர்)"	8"கார்த்திகை (நவம்பர் - டிசம்பர்)"	9"மார்கழி (டிசம்பர் - ஜனவரி)"	10"தை (ஜனவரி - பிப்ரவரி)"	11"மாசி (பிப்ரவரி - மார்ச்)"	12"பங்குனி (மார்ச் - ஏப்ரல்)"
label values monthsid months_tamil
decode monthsid, gen(months_tamil)

* CHOICE LIST "raventest"
gen raventestid=_n
replace raventestid=. if raventestid>7
replace raventestid=99 if raventestid==7
label define raventest 1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 99"No response"
label values raventestid raventest
decode raventestid, gen (raventest)
label define raventest_tamil 1"1"	2"2"	3"3"	4"4"	5"5"	6"6"	99"பதில் இல்லை"
label values raventestid raventest_tamil
decode raventestid, gen(raventest_tamil)

* CHOICE LIST "waterfrom"
gen waterfromid=_n
replace waterfromid=. if waterfromid>5
label define waterfrom 1"Tank" 2"River/Canal" 3"Bore well" 4"Open well" 5"Only rain"
label values waterfromid waterfrom
decode waterfromid, gen (waterfrom)
label define waterfrom_tamil 1"ஏரி"	2"ஆறு/ வாய்க்கால்"	3"போர்"	4"கிணறு"	5"மழை நீர் மட்டும்"
label values waterfromid waterfrom_tamil
decode waterfromid, gen(waterfrom_tamil)

* CHOICE LIST "drywet"
gen drywetid=_n
replace drywetid=. if drywetid>2
label define drywet 1"Dry land" 2"Wet land"
label values drywetid drywet
decode drywetid, gen (drywet)
label define drywet_tamil 1"புன்சை நிலம்" 2"நன்சை நிலம்"
label values drywetid drywet_tamil
decode drywetid, gen(drywet_tamil)

* CHOICE LIST "numeracy"
gen numeracyid=_n
replace numeracyid=. if numeracyid>3
replace numeracyid=99 if numeracyid==3
label define numeracy 1"Correct" 2"Incorrect" 99"No response"
label values numeracyid numeracy
decode numeracyid, gen (numeracy)
label define numeracy_tamil 1"சரி" 2"தவறு" 99"பதில் இல்லை"
label values numeracyid numeracy_tamil
decode numeracyid, gen(numeracy_tamil)

* CHOICE LIST "houseproperty"
gen housepropertyid=_n
replace housepropertyid=. if housepropertyid>4
label define houseproperty 1"Own house" 2"Joint property between wife and husband's families" 3"Family property inherited at a parent's death" 4"Rental"
label values housepropertyid houseproperty
decode housepropertyid, gen (houseproperty)
label define houseproperty_tamil 1"சொந்த வீடு"	2"கூட்டு சொத்து"	3"குடும்ப சொத்து"	4"வாடகை"
label values housepropertyid houseproperty_tamil
decode housepropertyid, gen(houseproperty_tamil)

* CHOICE LIST "housetype"
gen housetypeid=_n
replace housetypeid=. if housetypeid>2
label define housetype 1"Concrete house" 2"Thatched roof house"
label values housetypeid housetype
decode housetypeid, gen (housetype)
label define housetype_tamil 1"கான்கிரீட் வீடு (அரசாங்கம் அல்லாத )" 2"கூரை வீடு" 3"அரசாங்கம்/பசுமை வீடு"
label values housetypeid housetype_tamil
decode housetypeid, gen(housetype_tamil)
**Arnaud:pb

* CHOICE LIST "howbuyhouse"
gen howbuyhouseid=_n
replace howbuyhouseid=. if howbuyhouseid>7
label define howbuyhouse 1"Hereditary" 2"Savings" 3"Bank loan" 4"Credit from relatives/terinjavanga" 5"Finance" 6"Help from children" 7"Government scheme"
label values howbuyhouseid howbuyhouse
decode howbuyhouseid, gen (howbuyhouse)
label define howbuyhouse_tamil 1"பாரம்பரியம்"	2"சேமிப்பு"	3"வங்கி கடன்"	4"உறவினர்களிடம் கடன் / தெரிஞ்சவங்க"	5"பைனான்ஸ்"	6"பிள்ளைகளிடமிருந்து உதவி"	7"அரசாங்க திட்டம்"
label values howbuyhouseid howbuyhouse_tamil
decode howbuyhouseid, gen(howbuyhouse_tamil)

* CHOICE LIST "electricity"
gen electricityid=_n
replace electricityid=. if electricityid>3
label define electricity 1"General electricity" 2"Single line" 3"No electricity"
label values electricityid electricity
decode electricityid, gen (electricity)
label define electricity_tamil 1"பொது மின்சாரம்"	2"ஒரு லைன் (one phase)"	3"மின்சாரம் இல்லை"
label values electricityid electricity_tamil
decode electricityid, gen(electricity_tamil)

* CHOICE LIST "water"
gen waterid=_n
replace waterid=. if waterid>2
label define water 1"Own tap" 2"Public tap"
label values waterid water
decode waterid, gen (water)
label define water_tamil 1"சொந்த குடிநீர்" 2"பொது குடிநீர்"
label values waterid water_tamil
decode waterid, gen(water_tamil)

* CHOICE LIST "toiletfacility"
gen toiletfacilityid=_n
replace toiletfacilityid=. if toiletfacilityid>
label define toiletfacility 1"No facilities" 2"Traditional pit latrine" 3"Semi-flush (Septic tank) latrine" 4"Flush toilet"
label values toiletfacilityid toiletfacility
decode toiletfacilityid, gen (toiletfacility)
label define toiletfacility_tamil 1"வசதிகள் இல்லை"	2"பாரம்பரிய குழி கழிவரை"	3"சாதரணமான பிளஷ் செய்யப்படும் கழிவரை"	4"பிளஷ் கழிவரை"
label values toiletfacilityid toiletfacility_tamil
decode toiletfacilityid, gen(toiletfacility_tamil)

* CHOICE LIST "noowntoilet"
gen noowntoiletid=_n
replace noowntoiletid=. if noowntoiletid>4
label define noowntoilet 1"None" 2"Shared toilet in building/chawl" 3"Shared toilet outside building" 4"Puclic/Govt. toilet"
label values noowntoiletid noowntoilet
decode noowntoiletid, gen (noowntoilet)
label define noowntoilet_tamil 1"ஒன்றும் இல்லை"	2"கட்டிடத்தில் பொதுவாக பயன்படுத்தப்படும் கழிவரை"	3"கட்டடத்திற்கு வெளியே பொது கழிவரை"	4"பொது / அரசாங்க கழிவரை"
label values noowntoiletid noowntoilet_tamil
decode noowntoiletid, gen(noowntoilet_tamil)

* CHOICE LIST "howpaymarriage"
gen howpaymarriageid=_n
replace howpaymarriageid=. if howpaymarriageid>3
label define howpaymarriage 1"Loan" 2"Own capital / Savings" 3"Both" 
label values howpaymarriageid howpaymarriage
decode howpaymarriageid, gen (howpaymarriage)
label define howpaymarriage_tamil 1"கடன்"	2"சொந்த முதலீடு / சேமிப்பு"	3"இரண்டும்"
label values howpaymarriageid howpaymarriage_tamil
decode howpaymarriageid, gen(howpaymarriage_tamil)

* CHOICE LIST "gifttype"
gen gifttypeid=_n
replace gifttypeid=. if gifttypeid>6
replace gifttypeid=77 if gifttypeid==6
label define gifttype 1"Gold" 2"Cash" 3"Clothes" 4"Almera / furniture" 5"Vessels" 77"Other"
label values gifttypeid gifttype
decode gifttypeid, gen (gifttype)
label define gifttype_tamil 1"நகை"	2"பணம்"	3"உடைகள்"	4"அலமாரி / மரச்சாமான்"	5"பாத்திரங்கள்"	77"மற்றவை"
label values gifttypeid gifttype_tamil
decode gifttypeid, gen(gifttype_tamil)

* CHOICE LIST "literacy2"
gen literacy2id=_n
replace literacy2id=. if literacy2id>4
replace literacy2id=99 if literacy2id==4
label define literacy2 1"No" 2"Yes, with difficulty" 3"Yes, without difficulty/errors" 99"Refuse"
label values literacy2id literacy2
decode literacy2id, gen (literacy2)
label define literacy2_tamil 1"எதுவும் படிக்க தெரியாது"	2"எழுத்துக்களை படித்தல்"	3"வார்த்தைகள் படித்தல்"	4"வாக்கியத்தை படித்தல்"	99"மறுத்தல்"
label values literacy2id literacy2_tamil
decode literacy2id, gen(literacy2_tamil)

* CHOICE LIST "lenderfrom"
gen lenderfromid=_n
replace lenderfromid=. if lenderfromid>4
replace lenderfromid=66 if lenderfromid==3
replace lenderfromid=88 if lenderfromid==4
label define lenderfrom 1"Inside village" 2"Outside village" 66"N/A (if institution)" 88"Don't know"
label values lenderfromid lenderfrom
decode lenderfromid, gen (lenderfrom)
label define lenderfrom_tamil 1"கிராமத்துக்குள்"	2"கிராமத்துக்கு வெளியில்"	66"ஒன்றும் இல்லை (நிறுவனமாக இருந்தால்)"	88"தெரியாது"
label values lenderfromid lenderfrom_tamil
decode lenderfromid, gen(lenderfrom_tamil)

* CHOICE LIST "reasonborrowing"
gen reasonborrowingid=_n
replace reasonborrowingid=. if reasonborrowingid>13
replace reasonborrowingid=77 if reasonborrowingid==13
label define reasonborrowing 1"Agriculture" 2"Family expenses (food, transport, hidden payback, etc.)" 3"Health expenses" 4"Repay previous loan" 5"House expenses" 6"Investment" 7"Ceremonies" 8"Marriage" 9"Education" 10"Relatives expenses" 11"Death expenses"  12"No reason" 77"Other"
label values reasonborrowingid reasonborrowing
decode reasonborrowingid, gen (reasonborrowing)
label define reasonborrowing_tamil 1"விவசயாம்"	2"குடும்ப செலவுகள் (உணவு, போக்குவரத்து, பாக்கி திருப்பி அளிப்பது, இதர)"	3"மருத்துவ செலவு"	4"பழைய கடனை திருப்பி அளித்தல்"	5"வீட்டு செலவு"	6"மூதலீடு"	7"சடங்குகள்"	8"திருமணம்"	9"கல்வி"	10"உறவினர்கள் செலவு"	11"இறப்பு செலவுகள்"	12"காரணம் இல்லை"	77"மற்றவை"
label values reasonborrowingid reasonborrowing_tamil
decode reasonborrowingid, gen(reasonborrowing_tamil)

* CHOICE LIST "reasonborrowing2"
gen reasonborrowing2id=_n
replace reasonborrowing2id=. if reasonborrowing2id>
label define reasonborrowing2 1"Agriculture" 2"Family expenses (food, transport, hidden payback, etc.)" 3"Health expenses" 4"Repay previous loan" 5"House expenses" 6"Investment" 7"Ceremonies" 8"Marriage" 9"Education" 10"Relatives expenses" 11"Death expenses" 12"No reason"
label values reasonborrowing2id reasonborrowing2
decode reasonborrowing2id, gen (reasonborrowing2)
label define reasonborrowing2id_tamil 1"விவசாயம்"	2"குடும்ப செலவுகள் (உணவு, போக்குவரத்து, பாக்கி திருப்பி அளிப்பது, இதர)"	3"மருத்துவ செலவு"	4"பழைய கடனை திருப்பி அளித்தல்"	5"வீட்டு செலவு"	6"முதலீடு"	7"சடங்குகள்"	8"திருமணம்"	9"கல்வி"	10"உறவினர்கள் செலவு"	11"இறப்பு செலவுகள்"	12"காரணம் இல்லை"
label values reasonborrowing2id reasonborrowing2id_tamil
decode reasonborrowing2id, gen(reasonborrowing2id_tamil)

* CHOICE LIST "otherlenderservices"
gen otherlenderservicesid=_n
replace otherlenderservicesid=. if otherlenderservicesid>6
replace otherlenderservicesid=77 if otherlenderservicesid==6
label define otherlenderservices 1"Political support" 2"Financial support" 3"Guarantor" 4"General informant" 5"None" 77"Other"
label values otherlenderservicesid otherlenderservices
decode otherlenderservicesid, gen (otherlenderservices)
label define otherlenderservices_tamil 1"அரசியல் ஆதரவு"	2"நிதி உதவி"	3"உத்திரவாதம் அளிப்பவர்"	4"பொது தகவல் அளிப்பவர்"	5"ஒன்றும் இல்லை"	77"மற்றவை"
label values otherlenderservicesid otherlenderservices_tamil
decode otherlenderservicesid, gen(otherlenderservices_tamil)

* CHOICE LIST "reasondontworkmore"
gen reasondontworkmoreid=_n
replace reasondontworkmoreid=. if reasondontworkmoreid>13
label define reasondontworkmore 1"Studying/in school" 2"Housewife/home duties" 3"In retirement" 4"Old age" 5"Ill" 6"Have a disability" 7"In compulsory military service" 8"Believe I do not have any chance to get a job" 9"Work depends on demand/not enough jobs" 10"Lack of flexibility to work irregular hours (eg night shift) or long hours (more than 40 hours a week)" 11"Lack of flexibility to do more than one hour of commute" 12"A high probability of being discriminated because of your caste group or gender" 13"Already has a job"
label values reasondontworkmoreid reasondontworkmore
decode reasondontworkmoreid, gen (reasondontworkmore)
label define reasondontworkmore_tamil 1"படித்துக் கொண்டிருத்தல்/பள்ளி"	2"வீட்டு கடமை"	3"பணி ஓய்வு"	4"முதியோர்"	5"நோயுற்று"	6"உடல் ஊனமுற்றதால்"	7"கட்டாயமான இராணுவ சேவை"	8"எனக்கு வேலை கிடைக்க வாய்ப்பு இல்லை என நினைக்கிறேன்"	9"தேவைக்கேற்ற வேலை / தேவையான வேலை இல்லை"	10"அதிக நேரங்களை வேலை செய்ய வசதி இல்லாமை (உதாரணம் இரவு நேரப் பணி (நயிட் ஷிப்ட்)) அல்லது அதிக நேரம் (வாரத்தில் 40 மணி நேரத்துக்கும் மேல்)"	11"குறிப்பிடப்பட்ட ஒரு மணி நேரத்துக்கு மேலாக செய்யக்கூடிய வசதி இல்லாமை"	12"ஜாதி அல்லது பாலினத்தை வைத்து உங்களை வேறுபடுத்துவது"	13"ஏற்கனவே வேலை இருக்கிறது"
label values reasondontworkmoreid reasondontworkmore_tamil
decode reasondontworkmoreid, gen(reasondontworkmore_tamil)

* CHOICE LIST "kindofwork2"
gen kindofwork2id=_n
replace kindofwork2id=. if kindofwork2id>13
replace kindofwork2id=77 if kindofwork2id==13
label define kindofwork2 1"Agricultural activity on own household farm/own farm business" 2"Self-employed, own account worker, an owner with or without hired labour (non-agri)" 3"Salaried job (agri in another farm)" 4"Salaried job (non-agri, in industry or services)" 5"Unpaid worker in household business (non-agri)" 6"Unpaid worker in other business (non-agri)" 7"Unpaid worker in own farm (agri)" 8"Unpaid worker in another farm (agri)" 9"Unemployed/not working but actively looking for work" 10"Full-time student" 11"Apprenticeship/Training " 12"Not working and not looking for a job" 77"Other"
label values kindofwork2id kindofwork2
decode kindofwork2id, gen (kindofwork2)
label define kindofwork2_tamil 1"உங்கள் சொந்த நிலத்தில் விவசாயம்/சொந்த பண்ணை தொழில்"	2"சுய தொழில், முதலாளி, பணி ஆட்களை நியமிக்கும் அல்லது நியமிக்காத முதலாளி (விவசாயம் சாராத)"	3"சம்பள வேலை (வேறு நிலத்தில் விவசாயம் அல்லது விவசாயம் சாராதது)"	4"சம்பள வேலை (விவசாயம் அல்லாத, தொழிற்சாலை அல்லது சர்விஸ்...)"	5"குடும்ப தொழிலின் கூலி வாங்காத வேலை ஆள் (விவசாயம் சாரதது)"	6"கூலி வாங்காத வேலையாள் (விவசாயம் சாராத)"	7"சொந்த நிலத்தில் கூலி வாங்காத வேலையாள் (விவசாயம்)"	8"வேறு ஒருவர் நிலத்தில் வேலை செய்யும் சம்பளம் வாங்காத வேலையாள் (விவசாயம்)"	9"வேலை இல்லாத / வேலை செய்யவில்லை ஆனால் தீவரமாக வேலை தேடிக் கொண்டிருத்தல்"	10"முழு நேர மாணவர்"	11"பயிற்சி / (அப்பரண்டீஸ்)"	12"வேலை செய்யவில்லை மற்றும் வேலை தேடவும் இல்லை"	77"மற்றவை"
label values kindofwork2id kindofwork2_tamil
decode kindofwork2id, gen(kindofwork2_tamil)

* CHOICE LIST "reasonstoppedjob"
gen reasonstoppedjobid=_n
replace reasonstoppedjobid=. if reasonstoppedjobid>13
replace reasonstoppedjobid=77 if reasonstoppedjobid==13
label define reasonstoppedjob 1"Fired" 2"End of contract/business slowdown" 3"Business you worked for closed" 4"Employer reduced your work hours" 5"Low wage/ bad working conditions" 6"Retired" 7"Pregnancy/ child birth" 8"Health (ill/disabled)" 9"Looking after family/children" 10"Moved to another area" 11"To continue education/training" 12"Preferred to work in self-employment" 77"Other"
label values reasonstoppedjobid reasonstoppedjob
decode reasonstoppedjobid, gen (reasonstoppedjob)
label define reasonstoppedjob_tamil 1"பதவி நீக்கம்"	2"ஒப்பந்தம் முடிந்தது / தொழில் மந்தம்"	3"வேலை செய்த தொழில் மூடப்பட்டுவிட்டது"	4"முதலாளி வெலை நேரத்தை குறைத்துவிட்டார்"	5"குறைவான சம்பளம் / மோசமான வேலை நிலை"	6"ஓய்வு பெற்றுவிட்டது. (பணி ஓய்வு)"	7"கர்பமாக இருத்தல் / குழந்தை பிறப்பு"	8"உடல் நிலை (நோயுற்று இருந்தல் / ஊனமுற்றிருத்தல்)"	9"குடும்பத்திஅ கவனித்துக் கொள்ளுதல் / குழந்தைகள்"	10"வேறு இடத்திற்கு சென்றுவிட்டது"	11"படிக்க / பயிர்ச்சி பெற விருப்பம் வேறுப்பகுதிக்கு செல்லப்பட்டது"	12"சுயதொழில் செய்ய விருப்பம்"	77"மற்றவை"
label values reasonstoppedjobid reasonstoppedjob_tamil
decode reasonstoppedjobid, gen(reasonstoppedjob_tamil)

* CHOICE LIST "frequency5"
gen frequency5id=_n
replace frequency5id=. if frequency5id>4
label define frequency5 1"Month" 2"Fortnight (2 weeks)" 3"Week" 4"Day"
label values frequency5id frequency5
decode frequency5id, gen (frequency5)
label define frequency5_tamil 1"மாதம்"	2"15 நாளுக்கு ஒருமுறை"	3"வாரம்"	4"நாள்"
label values frequency5id frequency5_tamil
decode frequency5id, gen(frequency5_tamil)

* CHOICE LIST "contracttype"
gen contracttypeid=_n
replace contracttypeid=. if contracttypeid>3
label define contracttype 1"Yes, a signed/written contract/agreement" 2"Yes, an oral agreement" 3"No"
label values contracttypeid contracttype
decode contracttypeid, gen (contracttype)
label define contracttype_tamil 1"ஆம், கையெழுத்திட்ட / எழுதப்பட்ட / ஒப்பந்தம்"	2"ஆம், வாய்மொழி ஒப்பந்தம்"	3"இல்லை"
label values contracttypeid contracttype_tamil
decode contracttypeid, gen(contracttype_tamil)

* CHOICE LIST "employertype"
gen employertypeid=_n
replace employertypeid=. if employertypeid>8
replace employertypeid=77 if employertypeid==8
gen employertypeid_1=1 if employertypeid!=.
label define employertype 1"State administration (including military)" 2"State-owned enterprise/farm or joint state-private entreprise" 3"Paid public works" 4"An individual (maistry...)" 5"Private firm or plant or farm" 6"Cooperative firm/farm" 7"NGO/ international, political, humanitarian organization" 77"Other"
label values employertypeid employertype
decode employertypeid, gen (employertype)
label define employertype_tamil 1"அரசாங்க நிறுவனம் (ராணுவம் உட்பட)"	2"அரசாங்கத்தின் அல்லது அரசு/ தனியார் நிறுவனம்"	3"பணம் கட்டிய பொது வேலை"	4"தனி நபர் (மேஸ்திரி....)"	5"தனியார் தொழில் அல்லது நிறுவனம்"	6"கூட்டுறவு நிறுவனம்"	7"NGO / உலக, அரசியல், மனித உரிமை நிறுவனங்கள்"	77"மற்றவை"
label values employertypeid employertype_tamil
decode employertypeid, gen(employertype_tamil)

* CHOICE LIST "nbworkers2"
gen nbworkers2id=_n
replace nbworkers2id=. if nbworkers2id>8
label define nbworkers2 1"Only Yourself" 2"2-5" 3"6-9" 4"10-15" 5"16-25" 6"26-50" 7"51-200" 8"More than 200"
label values nbworkers2id nbworkers2
decode nbworkers2id, gen (nbworkers2)
label define nbworkers2_tamil 1"உங்களுக்காக மட்டும்"	2"2-5"	3"6-9"	4"10-15"	5"16-25"	6"26-50"	7"51-200"	8"200 க்கும் அதிகமாக"
label values nbworkers2id nbworkers2_tamil
decode nbworkers2id, gen(nbworkers_tamil)

* CHOICE LIST "salaryincash"
gen salaryincashid=_n
replace salaryincashid=. if salaryincashid>2
replace salaryincashid=0 if salaryincashid==2
label define salaryincash 1"Yes, I receive monetary payment from my employer" 0"No"
label values salaryincashid salaryincash
decode salaryincashid, gen (salaryincash)
label define salaryincash_tamil 1"ஆமாம், எனது முதலாலியிடம் இருந்து பண உதவி பெற்றேன்" 0"இல்லை"
label values salaryincashid salaryincash_tamil
decode salaryincashid, gen(salaryincash_tamil)

* CHOICE LIST "borrowerservices"
gen borrowerservicesid=_n
replace borrowerservicesid=. if borrowerservicesid>5
replace borrowerservicesid=77 if borrowerservicesid==5
label define borrowerservices 1"Free service" 2"Work for less wage" 3"Provide support whenever he need" 4"None (don't provide any services)" 77"Other" 
label values borrowerservicesid borrowerservices
decode borrowerservicesid, gen (borrowerservices)
label define borrowerservices_tamil 1"இலவச சேவை"	2"குறைந்த சம்பளத்திற்கு வேலை செய்தல்"	3"தேவையான பொது உதவி செய்தல்"	4"இல்லை (எந்த சேவைகளை வழங்க வில்லை )"	77"மற்றவை"
label values borrowerservicesid borrowerservices_tamil
decode borrowerservicesid, gen(borrowerservices_tamil)

* CHOICE LIST "plantorepay"
gen plantorepayid=_n
replace plantorepayid=. if plantorepayid>7
replace plantorepayid=77 if plantorepayid==7
label define plantorepay 1"Joining a chit fund" 2"Someone from the household working more" 3"Someone from the household migrating" 4"Selling assets" 5"Using normal income from labour" 6"Borrowing elsewhere" 77"Other"
label values plantorepayid plantorepay
decode plantorepayid, gen (plantorepay)
label define plantorepay_tamil 1"சீட்டில் சேறுதல்"	2"குடும்ப உறுப்பினர் அதிகமாக வேலை செய்தல்"	3"குடும்ப உறுப்பினர் வேலைக்காக வெளியே செல்லுதல்"	4"சொத்துக்களை விற்றல்"	5"சாதாரண கூலி வருமானம்"	6"மற்ற இடங்களில் கடன் வாங்குவது"	77"மற்றவை"
label values plantorepayid plantorepay_tamil
decode plantorepayid, gen(plantorepay_tamil)

* CHOICE LIST "chitfundtype"
gen chitfundtypeid=_n
replace chitfundtypeid=. if chitfundtypeid>4
label define chitfundtype 1"Auction chit" 2"Jewel chit" 3"Vessels chit" 4"Tourism chit"
label values chitfundtypeid chitfundtype
decode chitfundtypeid, gen (chitfundtype)
label define chitfundtype_tamil 1"ஏல சீட்டு"	2"நகை சீட்டு"	3"பத்திரசீட்டு"	4"சுற்றுலாசீட்டு"
label values chitfundtypeid chitfundtype_tamil
decode chitfundtypeid, gen(chitfundtype_tamil)

* CHOICE LIST "frequency2"
gen frequency2id=_n
replace frequency2id=. if frequency2id>5
label define frequency2 1"Weekly" 2"Monthly" 3"Yearly" 4"Once in 6 months" 5"Pay whenever have money"
label values frequency2id frequency2
decode frequency2id, gen (frequency2)
label define frequency2_tamil 1"வாரம்"	2"மாதம்"	3"ஆண்டு"	4"6 மாதத்திற்கு ஒரு முறை"	5"பணம் இருக்கும் போது அளிப்பது"
label values frequency2id frequency2_tamil
decode frequency2id, gen(frequency2_tamil)

* CHOICE LIST "purposebankaccount"
gen purposebankaccountid=_n
replace purposebankaccountid=. if purposebankaccountid>6
label define purposebankaccount 1"Savings" 2"Jewel pledge" 3"Receive credit" 4"Crop loans" 5"Sugar mill loan" 6"Get welfare scheme"
label values purposebankaccountid purposebankaccount
decode purposebankaccountid, gen (purposebankaccount)
label define purposebankaccount_tamil 1"சேமிப்பு"	2"நகை அடமானம்"	3"கடன் பெறுதல்"	4"பயிர் கடன்"	5"சக்கரை ஆலை கடன்"	6"அரசாங்க திட்டம் பெறுதல்"
label values purposebankaccountid purposebankaccount_tamil
decode purposebankaccountid, gen(purposebankaccount_tamil)

* CHOICE LIST "banktype"
gen banktypeid=_n
replace banktypeid=. if banktypeid>3
label define banktype 1"Cooperative Bank" 2"Nationalized Bank" 3"Private Bank"
label values banktypeid banktype
decode banktypeid, gen (banktype)
label define banktype_tamil 1"கூட்டுறவு வங்கி"	2"தேசிய வங்கி"	3"தனியார் வங்கி"
label values banktypeid banktype_tamil
decode banktypeid, gen(banktype_tamil)

* CHOICE LIST "savingsaccounttype"
gen savingsaccounttypeid=_n
replace savingsaccounttypeid=. if savingsaccounttypeid>2
label define savingsaccounttype 1"Individual account" 2"Joint account"
label values savingsaccounttypeid savingsaccounttype
decode savingsaccounttypeid, gen (savingsaccounttype)
label define savingsaccounttype_tamil 1"தனிநபர் கணக்கு" 2"கூட்டுக்கணக்கு"
label values savingsaccounttypeid savingsaccounttype_tamil
decode savingsaccounttypeid, gen(savingsaccounttype_tamil)

* CHOICE LIST "insurancetype"
gen insurancetypeid=_n
replace insurancetypeid=. if insurancetypeid>2
label define insurancetype 1"Private" 2"Public"
label values insurancetypeid insurancetype
decode insurancetypeid, gen (insurancetype)
label define insurancetype_tamil 1"தனியார்" 2"பொது"
label values insurancetypeid insurancetype_tamil
decode insurancetypeid, gen(insurancetype_tamil)

* CHOICE LIST "insurancetype2"
gen insurancetype2id=_n
replace insurancetype2id=. if insurancetype2id>6
label define insurancetype2 1"Life insurance" 2"Health insurance" 3"Crop insurance" 4"Animal insurance" 5"Accident insurance (vehicles/person)" 6"Bike Insurance"
label values insurancetype2id insurancetype2
decode insurancetype2id, gen (insurancetype2)
label define insurancetype2_tamil 1"LIC இன்சூரன்ஸ்"	2"உடல்நல இன்சூரன்ஸ்"	3"பயிர் இன்சூரன்ஸ்"	4"கால்நடைகள் இன்சூரன்ஸ்"	5"விபத்து இன்சூரன்ஸ் (வண்டி/ஆள்)"	6"வண்டி இன்சூரன்ஸ்"
label values insurancetype2id insurancetype2_tamil
decode insurancetype2id, gen(insurancetype2_tamil)

* CHOICE LIST "frequency3"
gen frequency3id=_n
replace frequency3id=. if frequency3id>4
label define frequency3 1"Monthly" 2"Every 3 months" 3"Every 6 months" 4"Yearly"
label values frequency3id frequency3
decode frequency3id, gen (frequency3)
label define frequency3_tamil 1"மாதம்"	2"ஒவ்வொரு 3 மாததிர்க்கும்"	3"ஒவ்வொரு 6 மாததிர்க்கும்"	4"ஆண்டு"
label values frequency3id frequency3_tamil
decode frequency3id, gen(frequency3_tamil)

* CHOICE LIST "reasonnoinsurance"
gen reasonnoinsuranceid=_n
replace reasonnoinsuranceid=. if reasonnoinsuranceid>4
replace reasonnoinsuranceid=77 if reasonnoinsuranceid==4
label define  reasonnoinsurance 1"Not interested" 2"Do not have enough money" 3"Don't know about insurance" 77"Other"
label values reasonnoinsuranceid reasonnoinsurance
decode reasonnoinsuranceid, gen (reasonnoinsurance)
label define reasonnoinsurance_tamil 1"விருப்பம் இல்லை"	2"தேவையான பணம் இல்லை"	3"இன்சூரன்ஸ் பற்றி தெரியாது"	77"மற்றவை"
label values reasonnoinsuranceid reasonnoinsurance_tamil
decode reasonnoinsuranceid, gen(reasonnoinsurance_tamil)

* CHOICE LIST "guarantee"
gen guaranteeid=_n
replace guaranteeid=. if guaranteeid>7
replace guaranteeid=77 if guaranteeid==7
label define guarantee 77"Other"
label values guaranteeid guarantee
decode guaranteeid, gen (guarantee)
label define guarantee_tamil 1"பத்திரங்கள்"	2"சிட்டு (பணத்திற்க்கான உத்திரவாதம்)"	3"சுய உதவி குழு"	4"தனிப்பட்ட (உத்திரவாதம்)"	5"நகை/தங்கம்"	6"ஒன்றும் இல்லை (உத்திரவாதம் எதுவும் இல்லை)"	77"மற்றவை"
label values guaranteeid guarantee_tamil
decode guaranteeid, gen(guarantee_tamil)

* CHOICE LIST "guaranteetype"
gen guaranteetypeid=_n
replace guaranteetypeid=. if guaranteetypeid>2
label define guaranteetype 1"Guarantee of money" 2"Guarantee of trust"
label values guaranteetypeid guaranteetype
decode guaranteetypeid, gen (guaranteetype)
label define guaranteetype_tamil 1"பணத்திற்க்கான உத்திரவாதம்" 2"நம்பிக்கைகான உத்திரவாதம்"
label values guaranteetypeid guaranteetype_tamil
decode guaranteetypeid, gen(guaranteetype_tamil)

* CHOICE LIST "termsofrepayment"
gen termsofrepaymentid=_n
replace termsofrepaymentid=. if termsofrepaymentid>3
label define termsofrepayment 1"Fixed duration" 2"Repay when have money" 3"Repay when asked by the lender"
label values termsofrepaymentid termsofrepayment
decode termsofrepaymentid, gen (termsofrepayment)
label define termsofrepayment_tamil 1"குறிப்பிட்ட நாட்கள்"	2"பணம் இருக்கும் போது அளிப்பது"	3"கடன் கொடுத்தவர் கேட்கும் போது திருப்பி கொடுத்தல்"
label values termsofrepaymentid termsofrepayment_tamil
decode termsofrepaymentid, gen(termsofrepayment_tamil)

* CHOICE LIST "settleloanstrategy"
gen settleloanstrategyid=_n
replace settleloanstrategyid=. if settleloanstrategyid>11
replace settleloanstrategyid=77 if settleloanstrategyid==11
label define settleloanstrategy 77"Other" 1"Using normal income from labour" 2"Using income from schemes/pensions (i.e retirement pension, widow pension...)" 3"Borrowing elsewhere" 4"Selling something which was not planned" 5"Lease land" 6"Consumption reduction" 7"Take an additional job" 8"Work more" 9"Relative or friends support" 10"Selling the harvest in advance"
label values settleloanstrategyid settleloanstrategy
decode settleloanstrategyid, gen (settleloanstrategy)
label define settleloanstrategy_tamil 1"வேலை செய்பரின் சாதாரண வருமானத்தில் இருந்து"	2"ஓய்வூதியம்/ திட்டங்கள் வருமானத்தை பயன்படுத்தி (எடுத்துக்காட்டாக ஓய்வூதிய பென்ஷன்/விதவை பென்ஷன்)"	3"வேறு எங்கேயாவது கடன் வாங்குதல்"	4"திட்டமிடாத ஏதோ ஒன்றை விற்றல்"	5"நிலம் குத்தகை விடுதல்"	6"செலவை குறைத்தல்"	7"வேறு ஒரு வேலையும் செய்தல்"	8"அதிகமான வேலை செய்தல்"	9"உறவினர் மற்றும் நண்பர்கள் உதவி"	10"மகசூலை முன்பே விற்றுவிடுதல்"	77"மற்றவை"
label values settleloanstrategyid settleloanstrategy_tamil
decode settleloanstrategyid, gen(settleloanstrategy_tamil)

* CHOICE LIST "problemdelayrepayment"
gen problemdelayrepaymentid=_n
replace problemdelayrepaymentid=. if problemdelayrepaymentid>6
replace problemdelayrepaymentid=77 if problemdelayrepaymentid==6
label define problemdelayrepayment 1"Nothing" 2"Shouting" 3"Put the pressure through the guarantor/person who recommended you" 4"Compromise" 5"Inform to all our relatives" 77"Other"
label values problemdelayrepaymentid problemdelayrepayment
decode problemdelayrepaymentid, gen (problemdelayrepayment)
label define problemdelayrepayment_tamil 1"ஒன்றுமில்லை"	2"சத்தம் போடுதல்"	3"உங்களுக்கு சிபாரிசு செய்த நபர் மூலம் அதிக அமுத்தம் தருதல்"	4"சமாதானம்"	5"அனைத்து உறவினர்களுடன் சொல்லப்பட்டது"	77"மற்றவை"
label values problemdelayrepaymentid problemdelayrepayment_tamil
decode problemdelayrepaymentid, gen(problemdelayrepayment_tamil)

* CHOICE LIST "goodbuying"
gen goodbuyingid=_n
replace goodbuyingid=. if goodbuyingid>4
label define goodbuying 1"Credit" 2"Instalment" 3"Ready cash" 4"Did not pay for this good (from dowry, gift, etc.)"
label values goodbuyingid goodbuying
decode goodbuyingid, gen (goodbuying)
label define goodbuying_tamil 1"கடன்"	2"தவணை முறை"	3"உடனடி பணம்"	4"இந்த பொருளுக்கு பணம் கொடுக்கவில்லை (சீர்வரிசை, பரிசு, இதர...)"
label values goodbuyingid goodbuying_tamil
decode goodbuyingid, gen(goodbuying_tamil)

* CHOICE LIST "goodcreditsource"
gen goodcreditsourceid=_n
replace goodcreditsourceid=. if goodcreditsourceid>4
replace goodcreditsourceid=77 if goodcreditsourceid==4
label define goodcreditsource 1"Shop keeper" 2"Credit vendor" 3"Finance company" 77"Other"
label values goodcreditsourceid goodcreditsource
decode goodcreditsourceid, gen (goodcreditsource)
label define goodcreditsource_tamil 1"கடைக்காரர்"	2"கடன் கொடுப்பவர்"	3"பைனான்ஸ் கம்பெனி"	77"மற்றவை"
label values goodcreditsourceid goodcreditsource_tamil
decode goodcreditsourceid, gen(goodcreditsource_tamil)

* CHOICE LIST "post10thstandard"
gen post10thstandardid=_n
replace post10thstandardid=. if post10thstandardid>5
label define post10thstandard 1"Regular senior secondary/ college" 2"Technical degree" 3"Private lesson at home" 4"Distance education/open university/correspondance" 5"Stopped education"
label values post10thstandardid post10thstandard
decode post10thstandardid, gen (post10thstandard)
label define post10thstandard_tamil 1"பள்ளிப்படிப்பு / காலேஜ்"	2"தொழில்நுட்ப டிகிரி"	3"வீட்டில் தனிப்பட்ட முறையில் படிப்பு"	4"தொலைதூர / அஞ்சல் வழியில் படிப்பு"	5"படிப்பு நிறுத்தம்"
label values post10thstandardid post10thstandard_tamil
decode post10thstandardid, gen(post10thstandard_tamil)

* CHOICE LIST "durationafter10thstandard"
gen durationafter10thstandardid=_n
replace durationafter10thstandardid=. if durationafter10thstandardid>2
label define durationafter10thstandard 1"Degree in 3 years or less" 2"Degree in more than 3 years"
label values durationafter10thstandardid durationafter10thstandard
decode durationafter10thstandardid, gen (durationafter10thstandard)
label define durationafter10thstandard_tamil 1"3.ஆண்டு அல்லது குறைவான வருடத்தில் பட்டப்படிப்பு" 2"3 ஆண்டுக்கு மேல் பட்டப்படிப்பு"
label values durationafter10thstandardid durationafter10thstandard_tamil
decode durationafter10thstandardid, gen(durationafter10thstandard_tamil)

* CHOICE LIST "typeschool"
gen typeschoolid=_n
replace typeschoolid=. if typeschoolid>2
label define typeschool 1"Private" 2"Public" 
label values typeschoolid typeschool
decode typeschoolid, gen (typeschool)
label define typeschool_tamil 1"தனியார்" 2"பொது"
label values typeschoolid typeschool_tamil
decode typeschoolid, gen(typeschool_tamil)

* CHOICE LIST "nbercontactphone"
gen nbercontactphoneid=_n
replace nbercontactphoneid=. if nbercontactphoneid>7
label define nbercontactphone 1"0-20" 2"21-50" 3"51-100" 4"101-200" 5"201-500" 6"501 and more" 7"No mobile phone" 
label values nbercontactphoneid nbercontactphone
decode nbercontactphoneid, gen (nbercontactphone)
label define nbercontactphone_tamil 1"0-20"	2"21-50"	3"51-100"	4"101-200"	5"201-500"	6"501 மற்றும் அதிகமாக"	7"தொலைபேசி இல்லை"
label values nbercontactphoneid nbercontactphone_tamil
decode nbercontactphoneid, gen(nbercontactphone_tamil)

* CHOICE LIST "yesnosocialnetwork"
gen yesnosocialnetworkid=_n
replace yesnosocialnetworkid=. if yesnosocialnetworkid>3
label define yesnosocialnetwork 1"Yes" 2"No need" 3"Nobody"
label values yesnosocialnetworkid yesnosocialnetwork
decode yesnosocialnetworkid, gen (yesnosocialnetwork)
label define yesnosocialnetwork_tamil 1"ஆம்"	2"தேவையில்லை"	3"யாருமில்லை"
label values yesnosocialnetworkid yesnosocialnetwork_tamil
decode yesnosocialnetworkid, gen(yesnosocialnetwork_tamil)

* CHOICE LIST "agelist"
gen agelistid=_n
replace agelistid=. if agelistid>6
label define agelist 1"15-25" 2"26-35" 3"36-45" 4"46-55" 5"56-65" 6"More than 65"
label values agelistid agelist
decode agelistid, gen (agelist)
label define agelist_tamil 1"15-25"	2"26-35"	3"36-45"	4"46-55"	5"56-65"	6"65க்கு மேல்"
label values agelistid agelist_tamil
decode agelistid, gen(agelist_tamil)

* CHOICE LIST "educlist"
gen educlistid=_n
replace educlistid=. if educlistid>7
replace educlistid=88 if educlistid==7
label define educlist 1"Primary education or below (5th std or less)" 2"Upper primary (8th std)" 3"High school/ITI (10th std)" 4"Senior secondary/Technical education (12th)" 5"Bachelor and above (15th)" 6"No education" 88"Don't know"
label values educlistid educlist
decode educlistid, gen (educlist)
label define educlist_tamil 1"ஆரம்பக் கல்வி அல்லது குறைவான (5-ம் அல்லது குறைவு)"	2"8-ம் வகுப்பு வரை"	3"பத்தாம் வகுப்பு / ITI"	4"மேல் நிலைப்பள்ளி / தொழில்நுட்ப்ப படிப்பு (12)"	5"பட்டபடிப்பு மற்றும் மேலே (15)"	6"கல்வி தகுதி இல்லை"	88"தெரியாது"
label values educlistid educlist_tamil
decode educlistid, gen(educlist_tamil)

* CHOICE LIST "occuplist2"
gen occuplist2id=_n
replace occuplist2id=. if occuplist2id>8
replace occuplist2id=77 if occuplist2id==8
label define occuplist2 77"Other" 1"Civil servant" 2"Salaried job (agri)" 3"Salaried job (non-agri, in industry or services)" 4"Self-employed" 5"Works in household business" 6"Farmer" 7"Unemployed / Not active"
label values occuplist2id occuplist2
decode occuplist2id, gen (occuplist2)
label define occuplist2_tamil 1"அரசு வேலை"	2"சம்பள வேலை ஆள்"	3"சுயவேலை"	4"குடும்ப தொழில் வேலை"	5"விவசாயம்"	6"வேலை இல்லை/ செயல்படாத"	77"மற்றவை"
label values occuplist2id occuplist2_tamil
decode occuplist2id, gen(occuplist2_tamil)

* CHOICE LIST "living"
gen livingid=_n
replace livingid=. if livingid>6
label define living 1"Same neighborhood (less than 2-3 km)" 2"In the same village" 3"In the same district" 4"In another place in Tamil Nadu" 5"Elsewhere in India" 6"Foreign country"
label values livingid living
decode livingid, gen (living)
label define living_tamil 1"அதே ஊர் (2-3 கிலோ மீட்டர் குறைவு)" 2"அதே ஊர்" 3"அதே மாவட்டம்" 4"தமிழ் நாட்டில் வேறொரு இடம்" 5"இந்தியாவில் மற்ற இடங்களில்" 6"வெளிநாடு"
label values livingid living_tamil
decode livingid, gen(living_tamil)

* CHOICE LIST "compared"
gen comparedid=_n
replace comparedid=. if comparedid>3
label define compared 1"In a better economic situation than you?" 2"In the same economic situation than you?" 3"In a worst economic situation than you?" 
label values comparedid compared
decode comparedid, gen (compared)
label define compared_tamil 1"உங்களை விட உயர்ந்த பொருளாதார நிலை"	2"உங்களுக்கு சமமான பொருளாதார நிலை"	3"உங்களை விட பொருளாதாரத்தில் குறைந்த நிலை"
label values comparedid compared_tamil
decode comparedid, gen(compared_tamil)

* CHOICE LIST "meet"
gen meetid=_n
replace meetid=. if meetid>7
replace meetid=77 if meetid==7
label define meet 1"Labour relation" 2"Neighbourhood relation" 3"Introduced by family member (blood relationships)" 4"Introduced by an acquaintance (sontham)" 5"Classmate" 6"Through an association" 77"Other"
label values meetid meet
decode meetid, gen (meet)
label define meet_tamil 1"தொழிலாளி உறவுமுறை" 2"அக்கம் பக்கத்தினர் உறவுமுறை" 3"உறவினர்களால் அறிமுகப்படுத்தப்பட்டவர் (ரத்த சொந்தம்)" 4"அறிமுகமானவர் மூலம் அறிமுகப்படுத்தப்பட்டவர் (சொந்தம்)" 5"உடன் படித்தவர்" 6"சங்கம் மூலமாக அறிமுகமானவர்" 77"மற்றவை"
label values meetid meet_tamil
decode meetid, gen(meet_tamil)

* CHOICE LIST "meetfrequency"
gen meetfrequencyid=_n
replace meetfrequencyid=. if meetfrequencyid>6
label define meetfrequency 1"At least once a week" 2"At least once a month" 3"Every 2-3 months" 4"Every 4-6 months" 5"Once a year" 6"Less than once a year"
label values meetfrequencyid meetfrequency
decode meetfrequencyid, gen (meetfrequency)
label define meetfrequency_tamil 1"குறைந்த பட்சம் வாரம் ஒரு முறை"	2"குறைந்த பட்சம் மாதத்திற்கு ஒருமுறை"	3"ஒவ்வொரு 2-3 மாதம்"	4"ஒவ்வொரு 4-6 மாதம்"	5"ஆண்டுக்கு ஒருமுறை மட்டும்"	6"ஒரு ஆண்டுக்கு குறைவான"
label values meetfrequencyid meetfrequency_tamil
decode meetfrequencyid, gen(meetfrequency_tamil)

* CHOICE LIST "intimacydegree"
gen intimacydegreeid=_n
replace intimacydegreeid=. if intimacydegreeid>3
label define intimacydegree 1"Not intimate" 2"Intimate" 3"Very intimate"
label values intimacydegreeid intimacydegree
decode intimacydegreeid, gen (intimacydegree)
label define intimacydegree_tamil 1"நெருக்கமில்லாத"	2"நெருக்கமான"	3"மிகவும் நெருக்கமான"
label values intimacydegreeid intimacydegree_tamil
decode intimacydegreeid, gen(intimacydegree_tamil)

* CHOICE LIST "relation3"
gen relation3id=_n
replace relation3id=. if relation3id>14
label define relation3 1"Maistry" 2"Own child not living in the house" 3"Sibling not living in the house" 4"Parent not living in the house" 5"Niece/Nephew not living in the house" 6"Other family member not living in the house" 7"Neighbor" 8"Friend" 9"Customer/supplier/colleague" 10"Moneylender" 11"SHG member" 12"Employer" 13"Well known people" 14"Spouse"
label values relation3id relation3
decode relation3id, gen (relation3)
label define relation3_tamil 1"மேஸ்திரி"	2"உங்களுடன் வசிக்காத குழந்தைகள்"	3"உங்களுடன் வசிக்காத சகோதரன் / சகோதரிகள்"	4"உங்களுடன் வசிக்காத பெற்றோர்கள்"	5".உங்களுடன் வசிக்காத மாமன் / மச்சான்"	6"குடும்பத்தில் வசிக்காத மற்ற குடும்ப உறுப்பினர்"	7"அக்கம் பக்கத்தினர்"	8"நண்பர்கள்"	9"வாடிக்கையாளர் / பொருள்களை கொடுப்பவர் / உடன் வேலை செய்பவர்"	10"பணம் வட்டிக்கு கொடுப்பவர்"	11"சுய உதவிகுழு உறுப்பினர்"	12"வேலை கொடுப்பவர்"	13"தெரிந்தவர்கள்"	14"கணவன்/மனைவி"
label values relation3id relation3_tamil
decode relation3id, gen(relation3_tamil)

* CHOICE LIST "yesno5"
gen yesno5id=_n
replace yesno5id=. if yesno5id>3
replace yesno5id=0 if yesno5id==2
replace yesno5id=99 if yesno5id==3
label define yesno5 0"No" 1"Yes" 99"No response"
label values yesno5id yesno5
decode yesno5id, gen (yesno5)
label define yesno5_tamil 1"ஆம்"	0"இல்லை"	99"பதில் இல்லை"
label values yesno5id yesno5_tamil
decode yesno5id, gen(yesno5_tamil)

* CHOICE LIST "rationcardreasonnouse"
gen rationcardreasonnouseid=_n
replace rationcardreasonnouseid=. if rationcardreasonnouseid>7
label define rationcardreasonnouse 1"Too far" 2"No time" 3"Financial constraints" 4"Irregular supply" 5"Poor quality" 6"No need" 7"Insufficient quantity" 
label values rationcardreasonnouseid rationcardreasonnouse
decode rationcardreasonnouseid, gen (rationcardreasonnouse)
label define rationcardreasonnouse_tamil 1"மிகவும் தொலைவு"	2"நேரமில்லை"	3"பண பிரச்சனை"	4"தேவைக்கு குறைவாக கிடைத்தல்"	5"தரம் குறைந்த"	6"தேவை இல்லை"	7"தேவைக்கு குறைவாக"
label values rationcardreasonnouseid rationcardreasonnouse_tamil
decode rationcardreasonnouseid, gen(rationcardreasonnouse_tamil)

* CHOICE LIST "freehousescheme"
gen freehouseschemeid=_n
replace freehouseschemeid=. if freehouseschemeid>3
label define freehousescheme 1"Green house scheme" 2"Thane - house scheme" 3"Other free house scheme"
label values freehouseschemeid freehousescheme
decode freehouseschemeid, gen (freehousescheme)
label define freehousescheme_tamil 1"அம்மா பசுமை வீடு திட்டம்"	2"”தானே” வீட்டுத்திட்டம்"	3"இலவச வீட்டுத்திட்டம்"
label values freehouseschemeid freehousescheme_tamil
decode freehouseschemeid, gen(freehousescheme_tamil)

* CHOICE LIST "freehousebenefittype"
gen freehousebenefittypeid=_n
replace freehousebenefittypeid=. if freehousebenefittypeid>3
label define freehousebenefittype 1"In cash" 2"In kind" 3"Both"
label values freehousebenefittypeid freehousebenefittype
decode freehousebenefittypeid, gen (freehousebenefittype)
label define freehousebenefittype_tamil 1"பணமாக"	2"பொருளாக"	3"இரண்டும்"
label values freehousebenefittypeid freehousebenefittype_tamil
decode freehousebenefittypeid, gen(freehousebenefittype_tamil)

* CHOICE LIST "livestock"
gen livestockid=_n
replace livestockid=. if livestockid>6
label define livestock 1"cows" 2"goats" 3"poultry/chicken" 4"bullock" 5"bull for ploughing" 6"None"
label values livestockid livestock
decode livestockid, gen (livestock)
label define livestock_tamil 1"மாடுகள்"	2"ஆடுகள்"	3"கோழி"	4"காளை"	5"உழவுக்காக காளை"	6"ஒன்று இல்லை"
label values livestockid livestock_tamil
decode livestockid, gen(livestock_tamil)

* CHOICE LIST "livestockuse"
gen livestockuseid=_n
replace livestockuseid=. if livestockuseid>6
label define livestockuse 1"To be sold" 2"For Milk" 3"As savings" 4"Keep status" 5"Religious purpose" 6"Self-consumption"
label values livestockuseid livestockuse
decode livestockuseid, gen (livestockuse)
label define livestockuse_tamil 1"விற்க"	2"பால்"	3"சேமிப்பு"	4"கவுரமாக இருப்பதற்கு"	5"கோயில் பயன்பாடு"	6"சொந்த பயன்பாடு"
label values livestockuseid livestockuse_tamil
decode livestockuseid, gen(livestockuse_tamil)

* CHOICE LIST "productlist"
gen productlistid=_n
replace productlistid=. if productlistid>15
replace productlistid=77 if productlistid==15
label define productlist 77"Other" 1"Paddy" 2"Cotton" 3"Sugarcane" 4"Savukku tree" 5"Guava" 6"Mango" 7"Sapotta fruit" 8"Banana/Plantain" 9"Ground nut" 10"Ragi" 11"Millets" 12"Cashewnut" 13"Coconut" 14"None"
label values productlistid productlist
decode productlistid, gen (productlist)
label define productlist_tamil 1"நெல்"	2"பருத்தி"	3"கரும்பு"	4"சவுக்கு"	5"கொய்யா"	6"மாமரம்"	7"சப்போட்டா"	8"வாழைமரம்"	9"வேர்கடலை"	10"கேழ்வரகு"	11"சிறு தானியம்"	12"முந்திரி தோப்பு"	13"தென்னை மரம்"	14"ஒன்றும் இல்லை"	77"மற்றவை"
label values productlistid productlist_tamil
decode productlistid, gen(productlist_tamil)

* CHOICE LIST "productypeland"
gen productypelandid=_n
replace productypelandid=. if productypelandid>3
label define productypeland 1"Own land" 2"Leased land" 3"Both"
label values productypelandid productypeland
decode productypelandid, gen (productypeland)
label define productypeland_tamil 1"சொந்த நிலம்"	2"குத்தகை நிலம்"	3"இரண்டும்"
label values productypelandid productypeland_tamil
decode productypelandid, gen(productypeland_tamil)

* CHOICE LIST "originlabourers"
gen originlabourersid=_n
replace originlabourersid=. if originlabourersid>2
label define originlabourers 1"Inside the village" 2"Outside the village"
label values originlabourersid originlabourers
decode originlabourersid, gen (originlabourers)
label define originlabourers_tamil 1"கிராமத்திற்க்கு உள்ளே" 2"கிராமத்தின் வெளியே"
label values originlabourersid originlabourers_tamil
decode originlabourersid, gen(originlabourers_tamil)

* CHOICE LIST "equipmentlist"
gen equipmentlistid=_n
replace equipmentlistid=. if equipmentlistid>5
label define equipmentlist 1"Tractor" 2"Bullock cart" 3"Harvester" 4"Plowing machine" 5"None"
label values equipmentlistid equipmentlist
decode equipmentlistid, gen (equipmentlist)
label define equipmentlist_tamil 1"டிராக்டர்"	2"மாட்டு வண்டி"	3"பயிர் அறுவடை செய்யும் மிஷின்"	4"உழவு இயந்திரம்"	5"ஒன்றும் இல்லை"
label values equipmentlistid equipmentlist_tamil
decode equipmentlistid, gen(equipmentlist_tamil)

* CHOICE LIST "paymentinkind"
gen paymentinkindid=_n
replace paymentinkindid=. if paymentinkindid>6
replace paymentinkindid=77 if paymentinkindid==6
label define paymentinkind 1"Clothes" 2"Food" 3"Transport" 4"Accommodation" 5"Labour in exchange" 77"Other"
label values paymentinkindid paymentinkind
decode paymentinkindid, gen (paymentinkind)
label define paymentinkind_tamil 1"உடை"	2"உணவு"	3"போக்குவரத்து"	4"உறைவிடம்"	5"வேலையாட்களை மாற்றிக்கொள்வது"	77"மற்றவை"
label values paymentinkindid paymentinkind_tamil
decode paymentinkindid, gen(paymentinkind_tamil)

* CHOICE LIST "migrationduration"
gen migrationdurationid=_n
replace migrationdurationid=. if migrationdurationid>4
label define migrationduration 1"Several days (max 7 days)" 2"Several weeks (max 8 weeks = 2 months)" 3"Several months (between 2 and 12 months)" 4"More (Up to 12 months = up to 1 year)"
label values migrationdurationid migrationduration
decode migrationdurationid, gen (migrationduration)
label define migrationduration_tamil 1"பல நாட்கள்"	2"பல வாரங்கள்"	3"பல மாதங்கள்"	4"அதிகமாக"
label values migrationdurationid migrationduration_tamil
decode migrationdurationid, gen(migrationduration_tamil)

* CHOICE LIST "migrationtravelpayment"
gen migrationtravelpaymentid=_n
replace migrationtravelpaymentid=. if migrationtravelpaymentid>4
label define migrationtravelpayment 1"Yourself" 2"Employer" 3"Maistry" 4"Family"
label values migrationtravelpaymentid migrationtravelpayment
decode migrationtravelpaymentid, gen (migrationtravelpayment)
label define migrationtravelpayment_tamil 1"தாங்களே (நீங்களே)"	2"முதலாளி"	3"மேஸ்திரி"	4"குடும்பம்"
label values migrationtravelpaymentid migrationtravelpayment_tamil
decode migrationtravelpaymentid, gen(migrationtravelpayment_tamil)

* CHOICE LIST "migrationjoblist"
gen migrationjoblistid=_n
replace migrationjoblistid=. if migrationjoblistid>9
label define migrationjoblist 1"Brick Kiln" 2"Sugar Cane Cutting" 3"Construction work" 4"Coolie non-agri" 5"Agri. Coolie" 6"Work in private company" 7"Work in public institution" 8"Self-employment" 9"Following family members"
label values migrationjoblistid migrationjoblist
decode migrationjoblistid, gen (migrationjoblist)
label define migrationjoblist_tamil 1"செங்கள் வேலை"	2"கரும்பு வெட்டுதல்"	3"கன்ஸ்டரஷன் வேலை"	4"விவசாயம் அல்லாது கூலி வேலை"	5"விவசாய கூலி"	6"தனியார் நிறுவனத்தில் வேலை"	7"பொது நிறுவனத்தில் வேலை"	8"சுய தொழில்"	9"குடும்ப உறுப்பினர்களை பின்தொடர்தல்"
label values migrationjoblistid migrationjoblist_tamil
decode migrationjoblistid, gen(migrationjoblist_tamil)

* CHOICE LIST "migrationfindjob"
gen migrationfindjobid=_n
replace migrationfindjobid=. if migrationfindjobid>6
label define migrationfindjob 1"Maistry" 2"Friends" 3"Known Person" 4"Themselves" 5"Advertisement (newspaper, internet, etc.)" 6"Go regular (no introduction, traditional migration)"
label values migrationfindjobid migrationfindjob
decode migrationfindjobid, gen (migrationfindjob)
label define migrationfindjob_tamil 1"மேஸ்திரி"	2"நண்பர்கள்"	3"தெரிஞ்சவங்க"	4"தாஙகளாகவே (நீங்களே)"	5"விளம்பரம் (செய்தித்தாள், இண்டர்நெட்.....)"	6"எப்பொழுதும்"
label values migrationfindjobid migrationfindjob_tamil
decode migrationfindjobid, gen(migrationfindjob_tamil)

* CHOICE LIST "advanceprovider"
gen advanceproviderid=_n
replace advanceproviderid=. if advanceproviderid>2
label define advanceprovider 1"Maistry" 2"Employer"
label values advanceproviderid advanceprovider
decode advanceproviderid, gen (advanceprovider)
label define advanceprovider_tamil 1"மேஸ்திரி" 2"முதலாளி"
label values advanceproviderid advanceprovider_tamil
decode advanceproviderid, gen(advanceprovider_tamil)

* CHOICE LIST "migrationtype"
gen migrationtypeid=_n
replace migrationtypeid=. if migrationtypeid>2
label define migrationtype 1"Individual" 2"Familial"
label values migrationtypeid migrationtype
decode migrationtypeid, gen (migrationtype)
label define migrationtype_tamil 1"தனியாக" 2"குடும்பத்துடன்"
label values migrationtypeid migrationtype_tamil
decode migrationtypeid, gen(migrationtype_tamil)

* CHOICE LIST "unbalancedadvance"
gen unbalancedadvanceid=_n
replace unbalancedadvanceid=. if unbalancedadvanceid>3
label define unbalancedadvance 1"Good" 2"Neutral" 3"Bad"
label values unbalancedadvanceid unbalancedadvance
decode unbalancedadvanceid, gen (unbalancedadvance)
label define unbalancedadvance_tamil 1"நல்லது"	2"நடுத்தரமானது"	3"கெட்டது"
label values unbalancedadvanceid unbalancedadvance_tamil
decode unbalancedadvanceid, gen(unbalancedadvance_tamil)

* CHOICE LIST "unbalancedadvanceproblem"
gen unbalancedadvanceproblemid=_n
replace unbalancedadvanceproblemid=. if unbalancedadvanceproblemid>6
label define unbalancedadvanceproblem 1"Work again with the same maistry/employer next year" 2"Work again with the same maistry/employer next year, but with less advance" 3"Get scoled in front of people" 4"Never give work anymore" 5"If go to another place for or another maistry, maistry/employer will complain about you" 6"Nothing"
label values unbalancedadvanceproblemid unbalancedadvanceproblem
decode unbalancedadvanceproblemid, gen (unbalancedadvanceproblem)
label define unbalancedadvanceproblem_tamil 1"அதே மேஸ்திரி / முதலாளியுடன் அடுத்த வருடமும் வேலை செய்ய வேண்டும்"	2"அதே மேஸ்திரியிடம் அடுத்த வருடமும் வேலை செய்ய வேண்டும் / முதலாளி குறைந்த முன் பணத்துடன்"	3"மக்கள் முன்னாடி திட்டுவார்"	4"வேலை தரவே மாட்டார்"	5"வேறு இடத்திற்கு அல்லது மேஸ்திரியிடமோ நீங்கள் சென்றால் முதலாளி உங்களை பற்றி புகார் செய்வார்"	6"ஒன்றும் இல்லை"
label values unbalancedadvanceproblemid unbalancedadvanceproblem_tamil
decode unbalancedadvanceproblemid, gen(unbalancedadvanceproblem_tamil)

* CHOICE LIST "migrationskill"
gen migrationskillid=_n
replace migrationskillid=. if migrationskillid>5
label define migrationskill 1"Experience" 2"Good education" 3"Specific skill/knowledge" 4"Good network" 5"Nothing"
label values migrationskillid migrationskill
decode migrationskillid, gen (migrationskill)
label define migrationskill_tamil 1"அனுபவம்"	2"நல்ல படிப்பு"	3"குறிப்பிட்ட திறமை / அறிவு"	4"நல்ல தொடர்பு"	5"ஒன்றும் இல்லை"
label values migrationskillid migrationskill_tamil
decode migrationskillid, gen(migrationskill_tamil)

* CHOICE LIST "migrationplace2"
gen migrationplace2id=_n
replace migrationplace2id=. if migrationplace2id>7
label define migrationplace2 1"Same Village" 2"Around villages" 3"Rural area in Tamil Nadu" 4"Small town of the area (Panruti, etc.)" 5"Big cities of Tamil Nadu (Chennai, etc.)" 6"Rural area outside Tamil Nadu" 7"Cities outside Tamil Nadu"
label values migrationplace2id migrationplace2
decode migrationplace2id, gen (migrationplace2)
label define migrationplace2_tamil 1"அதே கிராமம்"	2"கிராமத்தை சுற்றி"	3"தமிழ்நாட்டில் உள்ள கிராமங்கள்"	4"சிறிய நகரங்கள் (பண்ருட்டி ....)"	5"தமிழ்நாட்டின் பெரிய நகரங்கள் (சென்னை....)"	6"தமிழ்நாட்டிற்கு வெளியே உள்ள கிராமம்"	7"தமிழ்நாட்டிற்கு வெளியே உள்ள நகரம்"
label values migrationplace2id migrationplace2_tamil
decode migrationplace2id, gen(migrationplace2_tamil)

* CHOICE LIST "migrationplace"
gen migrationplaceid=_n
replace migrationplaceid=. if migrationplaceid>6
label define migrationplace 1"Around villages" 2"Rural area in Tamil Nadu" 3"Small town of the area (Panruti, Cuddalore, Villupuram, etc.)" 4"Big cities of Tamil Nadu (Chennai, Pondicherry, Madurai, etc.)" 5"Rural area outside Tamil Nadu" 6"Cities outside Tamil Nadu"
label values migrationplaceid migrationplace
decode migrationplaceid, gen (migrationplace)
label define migrationplace_tamil 1"கிராமத்தை சுற்றி"	2"தமிழ்நாட்டில் உள்ள கிராமங்கள்"	3"சிறிய நகரங்கள் (பண்ருட்டி, கடலூர், விழுப்புரம்....)"	4"தமிழ்நாட்டின் பெரிய நகரங்கள் (சென்னை, பாண்டிச்சேரி, மதுரை....)"	5"தமிழ்நாட்டிற்கு வெளியே உள்ள கிராமம்"	6"தமிழ்நாட்டிற்கு வெளியே உள்ள நகரம்"
label values migrationplaceid migrationplace_tamil
decode migrationplaceid, gen(migrationplace_tamil)

* CHOICE LIST "productunit"
gen productunitid=_n
replace productunitid=. if productunitid>3
label define productunit 1"Bags" 2"Kilos" 3"Tons"
label values productunitid productunit
decode productunitid, gen (productunit)
label define productunit_tamil 1"மூட்டை"	2"கிலோ"	3"டன்"
label values productunitid productunit_tamil
decode productunitid, gen(productunit_tamil)

* CHOICE LIST "livinghome"
gen livinghomeid=_n
replace livinghomeid=. if livinghomeid>4
label define livinghome 1"Yes (i.e. share meals or/and income)" 2"Yes, temporarily migrating (less than 1 year and share income)" 3"No, left permanently (new household/got married/ left more than 1 year)" 4"No died"
label values livinghomeid livinghome
decode livinghomeid, gen (livinghome)
label define livinghome_tamil 1"ஆம், உணவும் வருமானத்தையும் பகிர்ந்துகொள்ளுதல்"	2"ஆம், தற்காலிகமாக குடிபெயர்தல் (1 வருடத்திற்கும் குறைவாக) மற்றும் வருமானத்தை பகிர்ந்து கொள்ளுதல்"	3"இல்லை, நிரந்தரமாக குடி பெயர்தல் (புதிய குடும்பம்/திருமணம் ஆகிவிட்டது/ஒரு வருடத்திற்கும் மேல் குடி பெயர்த்துவிடுதல்)"	4"இல்லை இறந்துவிட்டார்"
label values livinghomeid livinghome_tamil
decode livinghomeid, gen(livinghome_tamil)

* CHOICE LIST "migrationreason"
gen migrationreasonid=_n
replace migrationreasonid=. if migrationreasonid>11
replace migrationreasonid=77 if migrationreasonid==11
label define migrationreason 1"Not enough work in local area" 2"Get advance" 3"Job assurance" 4"Have to repay previous advance" 5"Better opportunity in the migration place" 6"More interesting job in the migration place" 7"Can earn more money than local place" 8"Diversify activities" 9"Get better status" 10"Know someone in migration place who can help me" 77"Other"
label values migrationreasonid migrationreason
decode migrationreasonid, gen (migrationreason)
label define migrationreason_tamil  1"உள்ளூரில் போதுமான வேலை இல்லை"	2"முன்பணம் கிடைக்கும்"	3"வேலைக்கான உத்திரவாதம்"	4"முந்தய முன்பணத்தை திருப்பி செலுத்த வேண்டும்"	5"இடம்பெயர்வு இடத்தில் நல்ல வாய்ப்பு"	6"இடம்பெயர்வு இடத்தில் சுவாரசியமான வேலை"	7"உள்ளூரை விட அதிகமாக சம்பாதிக்க முடியும்"	8"பன்முகத்தன்மை நடவடிக்கைகள்"	9"நல்ல நிலையை பெற"	10"இடம் பெயர்ந்த இடத்தில் உதவி செய்ய ஆள் இருக்கிறார்கள்"	77"மற்றவை"
label values migrationreasonid migrationreason_tamil
decode migrationreasonid, gen(migrationreason_tamil)
 
***** END ARNAUD'S WORK *** 
 
* CHOICE LIST "demo6"
gen demo6id=_n
replace demo6id=. if demo6id>7
replace demo6id=77 if demo6id==7
label define demo6 77"Other" 1"Never used it" 2"To get cash in ATM" 3"Payment in shops" 4"Transfer money/receive money in ATMs" 5"Payment online" 6"Mobile payment (Paytm or other apps)"
label values demo6id demo6
decode demo6id, gen (demo6)
label define demo6_tamil 77"மற்றவை" 1"பயன்படுத்தியது இல்லை" 2"ATM இல் இருந்து பணம் எடுக்க வேண்டும்" 3"கடையில் பணம் கொடுக்க வேண்டும்" 4"ATM இல் இருந்து பணம் கொடுக்க/மாற்ற வேண்டும்" 5"பணத்தை கம்ப்யூட்டர் மூலம் செலுத்த வேண்டும்" 6"செல் போன் மூலம் பணம் செலுத்துதல்"
label values demo6id demo6_tamil
decode demo6id, gen(demo6_tamil)

* CHOICE LIST "demo7"
gen demo7id=_n
replace demo7id=. if demo7id>7
replace demo7id=77 if demo7id==7
label define demo7 77"Other" 1"No need" 2"Distrust money transactions by card" 3"Prefer cash transactions " 4"Less flexilibty of transactions (ex: less bargaining, possible arrangments, defering payments..)" 5"Difficult access to ATM/banking infrastructures" 6"Afraid to use it / Don't know how to use it"
label values demo7id demo7
decode demo7id, gen (demo7)
label define demo7_tamil 77"மற்றவை" 1"தேவை இல்லை" 2"கார்டின் மூலம் பண பரிவர்த்தனை நம்பிக்கை இல்லை" 3"பணமாக கொடுப்பதை விரும்புகிறேன்" 4"பணம் கொடுப்பதில் குறைந்த அளவு வாய்ப்பு உள்ளது (உதாரணம் குறைவான பேரம் பேசுதல், உடனடியாக கொடுத்தல், நாள் தவறி கொடுத்தல்...) " 5"ATM உபயோகிப்பதில் கஷ்டம்/ வங்கியின் கட்டமைப்பு" 6"உபயோகிப்பதற்கு பயம்/எப்படி உபயோகிப்பது என்று தெரிய வில்லை"
label values demo7id demo7_tamil
decode demo7id, gen(demo7_tamil)


* CHOICE LIST "migrationreason2"
gen migrationreason2id=_n
replace migrationreason2id=. if migrationreason2id>12
replace migrationreason2id=77 if migrationreason2id==12
label define migrationreason2 1"Not enough work in local area" 2"Get advance" 3"Job assurance" 4"Have to repay previous advance" 
5"Better opportunity in the migration place" 6"More interesting job in the migration place" 7"Can earn more money than local place" 8"Diversify activities" 9"Get better status" 
10"Know someone in migration place who can help me" 11"Joining a family member living there alone" 77"Other"
label values migrationreason2id migrationreason2
decode migrationreason2id, gen (migrationreason2)
label define migrationreason2_tamil 77"மற்றவை" 1"உள்ளூரில் போதுமான வேலை இல்லை" 2"முன்பணம் வாங்க" 3"வேலைக்கு உத்திரவாதம்" 4"பழைய முன்பணத்தை அடைக்க வேண்டும்" 5"வெளியூர் செல்வதால் நல்ல வாய்ப்புகள் கிடைக்கும்" 6"வெளியூர் செல்லும் இடத்தில் சுவாரஸ்யமான வேலைகள் கிடைக்கும்" 7"உள்ளூரில் வேலை செய்வதை விட வெளியூரில் அதிக  சம்பளம் கிடைக்கும் " 8"பலதரப்பட்ட செயல்பாடுகள்" 9"சிறந்த அந்தஸ்தை பெறலாம்" 10"வெளியூர் செல்லும் இடத்தில் உதவி செய்ய தெரிந்தவர் இருக்கிறார்" 11"குடும்ப உறுப்பினர் தனியாக இருக்கிறார் அவரிடம் தங்கி கொள்வேன்"
label values migrationreason2id migrationreason2_tamil
decode migrationreason2id, gen(migrationreason2_tamil)


* CHOICE LIST "advancereceiver"
gen advancereceiverid=_n
replace advancereceiverid=. if advancereceiverid>3
label define advancereceiver 1"Husband" 2"Wife" 3"Shared advance with both"
label values advancereceiverid advancereceiver
decode advancereceiverid, gen (advancereceiver)
label define advancereceiver_tamil 1"கணவர்" 2"மனைவி" 3"முன்பணம் இருவருக்கும் சேர்த்து"
label values advancereceiverid advancereceiver_tamil
decode advancereceiverid, gen(advancereceiver_tamil)


* CHOICE LIST "marriagetype"
gen marriagetypeid=_n
replace marriagetypeid=. if marriagetypeid>2
label define marriagetype 1"Blood or family relationship" 2"Outside the family"
label values marriagetypeid marriagetype
decode marriagetypeid, gen (marriagetype)
label define marriagetype_tamil 1"ரத்தம் அல்லது குடும்ப உறவு முறை (சொந்தம்)" 2"குடும்பத்திற்கு வெளியே உள்ள உறவு ("அசல்")"
label values marriagetypeid marriagetype_tamil
decode marriagetypeid, gen(marriagetype_tamil)


* CHOICE LIST "bloodrelationship"
gen bloodrelationshipid=_n
replace bloodrelationshipid=. if bloodrelationshipid>2
label define bloodrelationship 1"Father's side" 2"Mother's side"
label values bloodrelationshipid bloodrelationship
decode bloodrelationshipid, gen (bloodrelationship)
label define bloodrelationship_tamil 1"தந்தை வழி உறவு" 2"தாய் வழி உறவு"
label values bloodrelationshipid bloodrelationship_tamil
decode bloodrelationshipid, gen(bloodrelationship_tamil)


* CHOICE LIST "labourrelation"
gen labourrelationid=_n
replace labourrelationid=. if labourrelationid>4
label define labourrelation 1"Employer" 2"Colleague" 3"Maistry" 4"Supplier"
label values labourrelationid labourrelation
decode labourrelationid, gen (labourrelation)
label define labourrelation_tamil 1"முதலாளி" 2"உடன் வேலை செய்பவர்" 3"மேஸ்திரி" 4"சப்ளையர்"
label values labourrelationid labourrelation_tamil
decode labourrelationid, gen(labourrelation_tamil)

* CHOICE LIST "rural"
gen ruralid=_n
replace ruralid=. if ruralid>2
label define rural 1"Urban area" 2"Rural area"
label values ruralid rural
decode ruralid, gen (rural)
label define rural_tamil 1"நகர பகுதி" 2"கிராம பகுதி"
label values ruralid rural_tamil
decode ruralid, gen(rural_tamil)

* CHOICE LIST "satisfaction"
gen satisfactionid=_n
replace satisfactionid=. if satisfactionid>4
label define satisfactionid 1"Always" 2"Frequently" 3"Occasionally" 4"Never"
label values satisfactionid satisfaction
decode satisfactionid, gen (satisfaction)
label define satisfaction_tamil 1"எப்பொழுதும்" 2"அடிக்கடி" 3"எப்பொழுதாவது" 4"ஒருபொழுதும் இல்லை"
label values satisfactionid satisfaction_tamil
decode satisfactionid, gen(satisfaction_tamil)

* CHOICE LIST "satisfaction2"
gen satisfaction2id=_n
replace satisfaction2id=. if satisfaction2id>4
label define satisfaction2 1"Not true at all" 2"Somewhat true" 3"Quite true" 4"Completely true"
label values satisfaction2id satisfaction2
decode satisfaction2id, gen (satisfaction2)
label define satisfaction2_tamil 1"முற்றிலுமாக உண்மை இல்லை" 2"ஏதோ உண்மை" 3"கொஞ்சம் உண்மை" 4"முற்றிலுமாக உண்மை"
label values satisfaction2id satisfaction2_tamil
decode satisfaction2id, gen(satisfaction2_tamil)

* CHOICE LIST "agreementwork"
gen agreementworkid=_n
replace agreementworkid=. if agreementworkid>4
label define agreementwork 1"1 - Strongly disagree" 2"2 - Disagree" 3"3 - Agree" 4"4 - Strongly agree"
label values agreementworkid agreementwork
decode agreementworkid, gen (agreementwork)
label define agreementwork_tamil 1"கண்டிப்பாக ஒப்பு கொள்ள  மாட்டேன்" 2"ஒப்பு கிள்ள மாட்டேன்" 3"ஒப்பு கொள்கிறேன்" 4"முழுமையாக ஒப்பு கொள்கிறேன்"
label values agreementworkid agreementwork_tamil
decode agreementworkid, gen(agreementwork_tamil)

* CHOICE LIST "satisfaction3"
gen satisfaction3id=_n
replace satisfaction3id=. if satisfaction3id>4
label define satisfaction3 1"Very happy" 2"Fairly happy" 3"Not very happy" 4"Not at all happy" 
label values satisfaction3id satisfaction3
decode satisfaction3id, gen (satisfaction3)
label define satisfaction3_tamil 1"ரொம்ப மகிழ்ச்சி" 2"மகிழ்ச்சி" 3"அந்த அளவுக்கு சந்தோஷம் இல்லை" 4"சுத்தமாக சந்தோஷமாக இல்லை" 
label values satisfaction3id satisfaction3_tamil
decode satisfaction3id, gen(satisfaction3_tamil)


* CHOICE LIST "satisfaction4"
gen satisfaction4id=_n
replace satisfaction4id=. if satisfaction4id>5
replace satisfaction4id=66 if satisfaction4id==5
label define satisfaction4 66"Irrelevant" 1"Very satisfied" 2"Fairly satisfied" 3"Not very satisfied" 4"Not at all satisfied"
label values satisfaction4id satisfaction4
decode satisfaction4id, gen (satisfaction4)
label define satisfaction4_tamil 66"பொருத்தமற்றது" 1"மிகவும் திருப்தி" 2"திருப்தியாக இருந்தது" 3"அந்த அளவுக்கு திருப்தி இல்லை" 4"சுத்தமாக திருப்தி இல்லை"
label values satisfaction4id satisfaction4_tamil
decode satisfaction4id, gen(satisfaction4_tamil)

* CHOICE LIST "execution"
gen executionid=_n
replace executionid=. if executionid>4
replace executionid=66 if executionid==4
label define execution 1"Always" 2"Sometimes" 3"Never" 66"Irrelevant"
label values executionid execution
decode executionid, gen (execution)
label define execution_tamil 1"எப்பொழுதும்" 2"எப்பொழுதாவது" 3"ஒருபொழுதும் இல்லை" 66"பொருத்தமற்றது"
label values executionid execution_tamil
decode executionid, gen(execution_tamil)

* CHOICE LIST "seriousincident"
gen seriousincidentid=_n
replace seriousincidentid=. if seriousincidentid>6
replace seriousincidentid=66 if seriousincidentid==5
replace seriousincidentid=99 if seriousincidentid==6
label define seriousincident 66"Irrelevant" 99"No response" 1"No permanent effect" 2"A permanent effect but you are able to carry on with the same job" 3"A permanent effect but you are able to work although not in the same job" 4"A permanent effect that prevent you from working at all"
label values seriousincidentid seriousincident
decode seriousincidentid, gen (seriousincident)
label define seriousincident_tamil 66"பொருத்தமற்றது" 99"பதில் இல்லை" 1"நிரந்தர விளைவு இல்லை" 2"இந்த வேலையே செய்ய தொடர்ந்து முயற்சி" 3"தொடர்ந்து முயற்சி ஆனால் இதே வேலை இல்லை" 4"நீங்கள் வேலை செய்வதிலிருந்து தடுக்கும் ஒரு நிரந்தர விளைவு"
label values seriousincidentid seriousincident_tamil
decode seriousincidentid, gen(seriousincident_tamil)

* CHOICE LIST "seriousinjury"
gen seriousinjuryid=_n
replace seriousinjuryid=. if seriousinjuryid>13
replace seriousinjuryid=66 if seriousinjuryid==11
replace seriousinjuryid=77 if seriousinjuryid==12
replace seriousinjuryid=99 if seriousinjuryid==13
label define seriousinjury 66"Irrelevant" 99"No response" 77"Other" 1"Bone, joint or muscle problem which may affect (or is mainly connected with) arms, hands, neck, or shoulder" 2"Bone, joint or muscle problem which may affect (or is mainly connected with) hips, legs or feet" 3"Bone, joint or muscle problem which may affect (or is mainly connected with) the back" 4"Breathing or lung problems" 5"Skin problem" 6"Hearing problem" 7"Stress, depression or anxiety " 8"Headache or eye strain" 9"Heart disease/attack, other circulatory system" 10"Infectious disease"
label values seriousinjuryid seriousinjury
decode seriousinjuryid, gen (seriousinjury)
label define seriousinjury_tamil 66"பொருத்தமற்றது" 99"பதில் இல்லை" 77"மற்றவை" 1"எலும்பு, உறுப்பு இணைப்புகள் அல்லது தசைகள் பாதிக்கப்படலாம் (அல்லது முக்கியமாக இவைகளுடன் இணைக்கப்பட்டது) கைகள், கழுத்து அல்லது தோள்பட்டை" 2"எலும்பு, உறுப்பு இணைப்புகள் அல்லது தசைகள் பாதிக்கப்படலாம் (அல்லது முக்கியமாக இவைகளுடன் இணைக்கப்பட்டது) இடுப்பு, கால்கள் அல்லது பாதங்கள்" 3"எலும்பு, உறுப்பு இணைப்புகள் அல்லது தசைகள் பாதிக்கப்படலாம் (அல்லது முக்கியமாக இவைகளுடன் இணைக்கப்பட்டது) முதுகு தண்டு" 4"சுவாசம் அல்லது நுரையீரல் பிரச்சனைகள்" 5"தோல் பிரச்சனை" 6"கேட்டல் பிரச்சனை" 7"மன அழுத்தம், மன அழுத்தம் அல்லது பதட்டம்" 8"தலைவலி அல்லது கண் சிரமம்" 9"இதய நோய் / மாரடைப்பு, மற்ற இரத்த ஓட்ட அமைப்பு" 10"தொற்று நோய்"
label values seriousinjuryid seriousinjury_tamil
decode seriousinjuryid, gen(seriousinjury_tamil)


* CHOICE LIST "physicalharm"
gen physicalharmid=_n
replace physicalharmid=. if physicalharmid>6
replace physicalharmid=66 if physicalharmid==5
replace physicalharmid=99 if physicalharmid==6
label define physicalharm 66"Irrelevant" 99"No response" 1"Very concerned" 2"Somewhat concerned" 3"Not very concerned" 4"Not concerned"
label values physicalharmid physicalharm
decode physicalharmid, gen (physicalharm)
label define physicalharm_tamil 66"பொருத்தமற்றது" 99"பதில் இல்லை" 1"முக்கியமாக கருத்தில் கொள்ளுதல்" 2"சுமாராக கருத்தில் கொள்ளுதல்" 3"கருத்தில் எதுவும் கொள்ளவில்லை" 4"கருத்தில்  கொள்ளவில்லை"
label values physicalharmid physicalharm_tamil
decode physicalharmid, gen(physicalharm_tamil)

* CHOICE LIST "problemwork"
gen problemworkid=_n
replace problemworkid=. if problemworkid>5
replace problemworkid=66 if problemworkid==4
replace problemworkid=99 if problemworkid==5
label define problemwork 66"Irrelevant" 99"No response" 1"A big problem" 2"A surmountable problem" 3"Not a problem at all"
label values problemworkid problemwork
decode problemworkid, gen (problemwork)
label define problemwork_tamil 66"பொருத்தமற்றது" 99"பதில் இல்லை" 1"பெரிய பிரச்சனை" 2"ஒரு சிக்கலான அதிக பிரச்சனை" 3"பிரச்சினையே இல்லை"
label values problemworkid problemwork_tamil
decode problemworkid, gen(problemwork_tamil)

* CHOICE LIST "graduation"
gen graduationid=_n
replace graduationid=. if graduationid>5
replace graduationid=66 if graduationid==4
replace graduationid=99 if graduationid==5
label define graduation 66"Irrelevant" 99"No response" 1"Always" 2"Sometimes" 3"Never"
label values graduationid graduation
decode graduationid, gen (graduation)
label define graduation_tamil 66"பொருத்தமற்றது" 99"பதில் இல்லை" 1"எப்பொழுதும்" 2"அடிக்கடி" 3"ஒருபொழுதும் இல்லை"
label values graduationid graduation_tamil
decode graduationid, gen(graduation_tamil)


* CHOICE LIST "hearsomeone"
gen hearsomeoneid=_n
replace hearsomeoneid=. if hearsomeoneid>5
replace hearsomeoneid=66 if hearsomeoneid==4
replace hearsomeoneid=99 if hearsomeoneid==5
label define hearsomeone 1"You can hear him normally" 2"You can hear him if he speaks loudly" 3"You can't hear him" 66"Irrelevant" 99"No response"
label values hearsomeoneid hearsomeone
decode hearsomeoneid, gen (hearsomeone)
label define hearsomeone_tamil 66"பொருத்தமற்றது" 99"பதில் இல்லை" 1"சாதாரணமாக பேசினாலே கேட்கும்" 2"சத்தமாக பேசினால் தான் கேட்கும்" 3"அவர் பேசுவதை கேட்கவே  முடியாது"
label values hearsomeoneid hearsomeone_tamil
decode hearsomeoneid, gen(hearsomeone_tamil)

* CHOICE LIST "graduation2"
gen graduation2id=_n
replace graduation2id=. if graduation2id>6
replace graduation2id=66 if graduation2id==5
replace graduation2id=99 if graduation2id==6
label define graduation2 66"Irrelevant" 99"No response" 1"Always" 2"Often" 3"Sometimes" 4"Never"
label values graduation2id graduation2
decode graduation2id, gen (graduation2)
label define graduation2_tamil 66"பொருத்தமற்றது" 99"பதில் இல்லை" 1"எப்பொழுதும்" 3"எப்பொழுதாவது" 4"ஒருபொழுதும் இல்லை" 2"அடிக்கடி"
label values graduation2id graduation2_tamil
decode graduation2id, gen(graduation2_tamil)


* CHOICE LIST "sexualagression"
gen sexualagressionid=_n
replace sexualagressionid=. if sexualagressionid>5
replace sexualagressionid=66 if sexualagressionid==4
replace sexualagressionid=99 if sexualagressionid==5
label define sexualagression 66"Irrelevant" 99"No response" 1"Over the last month" 2"Over the last year" 3"More than 1 year ago"
label values sexualagressionid sexualagression
decode sexualagressionid, gen (sexualagression)
label define sexualagression_tamil 66"பொருத்தமற்றது" 99"பதில் இல்லை" 1"கடந்த மாதம்" 2"கடந்த வருடம்" 3"ஒரு வருடத்திற்கு முன்பு"
label values sexualagressionid sexualagression_tamil
decode sexualagressionid, gen(sexualagression_tamil)

* CHOICE LIST "importantdecision"
gen importantdecisionid=_n
replace importantdecisionid=. if importantdecisionid>6
replace importantdecisionid=7 if importantdecisionid==6
label define importantdecision 77"Other" 1"Job" 2"Family events" 3"Education" 4"Health" 5"Marriage"
label values importantdecisionid importantdecision
decode importantdecisionid, gen (importantdecision)
label define importantdecision_tamil 77"மற்றவை" 1"வேலை" 2"குடும்ப நிகழ்வுகள்" 3"படிப்பு" 4"உடல் நிலை/ஆரோக்கியம்" 5"திருமணம்"
label values importantdecisionid importantdecision_tamil
decode importantdecisionid, gen(importantdecision_tamil)

* CHOICE LIST "locusscale"
gen locusscaleid=_n
replace locusscaleid=. if locusscaleid>5
label define locusscale 1"Applies to me with a very large extent " 2"Applies to me in a great extent" 3"Applies to me in some extent" 4"Hardly applies to me at all" 5"Does not apply to me at all"
label values locusscaleid locusscale
decode locusscaleid, gen (locusscale)
label define locusscale_tamil 1"மிகப் பெரிய அளவில் எனக்கு பொருந்தும்" 2"எனக்குப் பெரிய அளவில் பொருந்தும்" 3"ஓரளவிற்கு எனக்கு பொருந்தும்" 4"எனக்குப் பொருந்தாது" 5"எனக்கு பொருந்தவே பொருந்தாது"
label values locusscaleid locusscale_tamil
decode locusscaleid, gen(locusscale_tamil)

* CHOICE LIST "decisioneducation"
gen decisioneducationid=_n
replace decisioneducationid=. if decisioneducationid>6
replace decisioneducationid=77 if decisioneducationid==6
label define decisioneducation 77"Other" 1"Yourself" 2"Parents/Other family elders" 3"Both parents/other family elders and yourself jointly" 4"Teachers" 5"Spouse/In-laws"
label values decisioneducationid decisioneducation
decode decisioneducationid, gen (decisioneducation)
label define decisioneducation_tamil 77"மற்றவை" 1"நீங்களே" 2"பெற்றோர் / பிற குடும்ப பெரியவர்கள்" 3"பெற்றோர் / பிற குடும்ப பெரியவர்கள் மற்றும் நீங்களும்" 4"ஆசிரியர்கள்" 5"மனைவி / மாமியார்"
label values decisioneducationid decisioneducation_tamil
decode decisioneducationid, gen(decisioneducation_tamil)


* CHOICE LIST "deconsumption"
gen deconsumptionid=_n
replace deconsumptionid=. if deconsumptionid>6
replace deconsumptionid=77 if deconsumptionid==6
label define deconsumption 77"Other" 1"Yourself - Household head" 2"Spouse (Husband/Wife)" 3"Your spouse and yourseld jointly" 4"Someone else" 5"Yourself and someone else jointly"
label values deconsumptionid deconsumption
decode deconsumptionid, gen (deconsumption)
label define deconsumption_tamil 77"மற்றவை" 1"நீங்களே - வீட்டுத் தலைவர்" 2"மனைவி (கணவன் / மனைவி)" 3"நீங்களும் உங்கள் கணவன்/மனைவியும் சேர்ந்து" 4"வேறு யாரோ ஒருவர்" 5"நீங்களும் வேறு யாரோ ஒருவரும் சேர்ந்து"
label values deconsumptionid deconsumption_tamil
decode deconsumptionid, gen(deconsumption_tamil)


* CHOICE LIST "decisionwork"
gen decisionworkid=_n
replace decisionworkid=. if decisionworkid>6
replace decisionworkid=77 if decisionworkid==6
label define decisionwork 77"Other" 1"Yourself" 2"Husband/Wife" 3"Parents or step-parents" 4"Children" 5"Someone else"
label values decisionworkid decisionwork
decode decisionworkid, gen (decisionwork)
label define decisionwork_tamil 77"மற்றவை" 1"நீங்களே" 2"மனைவி (கணவன் / மனைவி)" 3"பெற்றோர்கள் அல்லது வளர்ப்பு பெற்றோர்கள்" 4"குழந்தைகள்" 5"வேறு யாரோ ஒருவர்"
label values decisionworkid decisionwork_tamil
decode decisionworkid, gen(decisionwork_tamil)

* CHOICE LIST "opinionwork"
gen opinionworkid=_n
replace opinionworkid=. if opinionworkid>4
label define opinionwork 1"Strongly agree" 2"Agree" 3"Disagree" 4"Strongly disagree"
label values opinionworkid opinionwork
decode opinionworkid, gen (opinionwork)
label define opinionwork_tamil 1"முற்றிலுமாக ஒப்புக்கொள்கிறேன்" 2"ஒப்புக்கொள்கிறேன்" 3"ஒப்புக்கொள்ளமாட்டேன்" 4"முற்றிலுமாக ஒப்புக்கொள்கிறேன்"
label values opinionworkid opinionwork_tamil
decode opinionworkid, gen(opinionwork_tamil)

* CHOICE LIST "loseland"
gen loselandid=_n
replace loselandid=. if loselandid>5
replace loselandid=77 if loselandid==5
label define loseland 77"Other" 1"Unable to provide property document" 2"Sell the land pledged to the lender because unable  to pay loan(s) - interest or principal" 3"Sell the land outside of pawnbroking" 4"Given to the governement with a compensation"
label values loselandid loseland
decode loselandid, gen (loseland)
label define loseland_tamil 77"மற்றவை" 1"சொத்து பாத்திரத்தை கொடுக்க முடியவில்லை" 2"அடமானம் வைத்த நிலத்தை விற்பது ஏனெனில் வட்டியையும் அசலையும் கடன் திருப்பி கொடுக்க முடியவில்லை." 3"நிலத்தை விற்று வேறு கடனை/செலவை சரிக்கட்டுதல்" 4"இழப்பீட்டு தொகைக்காக அரசாங்கத்திடம் கொடுத்தது"
label values loselandid loseland_tamil
decode loselandid, gen(loseland_tamil)

* CHOICE LIST "notoilet"
gen notoiletid=_n
replace notoiletid=. if notoiletid>4
replace notoiletid=77 if notoiletid==4
label define notoilet 77"Other" 1"Don’t want to by habits" 2"Don’t want to because of water problems" 3"Don’t want to because there is no space"
label values notoiletid notoilet
decode notoiletid, gen (notoilet)
label define notoilet_tamil 77"மற்றவை" 1"பழக்கவழக்கங்களால் தேவையில்லை" 2"தேவையில்லை ஏனெனில் தண்ணீர் பிரச்சனை" 3"தேவையில்லை ஏனெனில் தேவையான இட வசதி இல்லை"
label values notoiletid notoilet_tamil
decode notoiletid, gen(notoilet_tamil)

* CHOICE LIST "decisionwork2"
gen decisionwork2id=_n
replace decisionwork2id=. if decisionwork2id>10
replace decisionwork2id=77 if decisionwork2id==10
label define decisionwork2 77"Other" 1"Yourself" 2"Spouse" 3"Your spouse and yourself jointly" 4"Your parents/parents-in-law and yourself jointly" 5"Your parents or parents-in-law" 6"Children" 7"Your children and yourself jointly" 8"Someone else" 9"Someone else and yourself jointly" 
label values decisionwork2id decisionwork2
decode decisionwork2id, gen (decisionwork2)
label define decisionwork2_tamil 77"மற்றவை" 1"நீங்களே" 2"மனைவி" 3"உங்கள் மனைவியும் நீங்களும் சேர்ந்து" 4"உங்கள் பெற்றோர் / பெற்றோர் மாமியார் மற்றும் நீங்களும் சேர்ந்து" 5"உங்கள் பெற்றோர் அல்லது பெற்றோர் மாமியார்" 6"குழந்தைகள்" 7"உங்கள் குழந்தைகளும் நீங்களும் சேர்ந்து" 8"வேறு யாரோ ஒருவர்" 9"நீங்களும் வேறு யாரோ ஒருவரும் சேர்ந்து"
label values decisionwork2id decisionwork2_tamil
decode decisionwork2id, gen(decisionwork2_tamil)

* CHOICE LIST "interviewplace"
gen interviewplaceid=_n
replace interviewplaceid=. if interviewplaceid>3
gen interviewplaceid_1=1 if interviewplaceid!=.
label define interviewplace 1"Inside village" 2"New place of permanent residency outside village" 3"Migration workplace"
label values interviewplaceid interviewplace
decode interviewplaceid, gen (interviewplace)
label define interviewplace_tamil 1"கிராமத்தின் உள்ளே" 2"கிராமத்திற்கு வெளியே நிரந்தர வசிப்பிடத்தின்  புதிய இடம்" 3"இடம்பெயர்வு பணியிடம்"
label values interviewplaceid interviewplace_tamil
decode interviewplaceid, gen(interviewplace_tamil)


************ MODIFICATIONS SUPPLÉMENTAIRES POUR TENIR COMPTE DES LIMITES DE SURVEY CTO pour fichier .CVS **************
merge m:1 householdid2020 using "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\hhheadfinale_VF.dta"
replace HHID_panel="." if HHID_panel==""
replace hhheadfinale="New household" if HHID_panel=="."& _merge==1
replace hhheadfinale=householdidstr if _merge==1&HHID_panel!="."
drop householdidstr

* Drop des variables avec trop de caractères dans la choice list (au dessus de 60)
drop demo7id demo7 demo7_tamil contactlistid contactlist contactlist_tamil methodfindjobid methodfindjob methodfindjob_tamil migrationreasonid migrationreason migrationreason_tamil reasondontworkmoreid reasondontworkmore reasondontworkmore_tamil address associationlistid associationlist associationlist_tamil sourceinvestmentid sourceinvestment sourceinvestment_tamil seriousincidentid seriousincident seriousincident_tamil employertypeid employertype employertype_tamil problemdelayrepaymentid problemdelayrepayment problemdelayrepayment_tamil assohelpbusinessid assohelpbusiness assohelpbusiness_tamil unbalancedadvanceproblemid unbalancedadvanceproblem unbalancedadvanceproblem_tamil kindofwork kindofworkid kindofwork_tamil kindofwork2id kindofwork2 kindofwork2_tamil settleloanstrategyid settleloanstrategy settleloanstrategy_tamil livinghomeid livinghome livinghome_tamil loselandid loseland loseland_tamil startbusinessorfarmid startbusinessorfarm startbusinessorfarm_tamil reasonborrowingid reasonborrowing reasonborrowing_tamil reasonborrowing2id reasonborrowing2 reasonborrowing2id_tamil
drop decisionwork2id decisionwork2 decisionwork2_tamil reasonstoppedjobid reasonstoppedjob reasonstoppedjob_tamil


* CHOICE LIST "migrationplace2"
drop migrationplace2
label define migrationplace2 1"Same Village" 2"Around villages" 3"Rural area in Tamil Nadu" 4"Small town of the area (Panruti, etc.)" 5"Big cities of Tamil Nadu (Chennai, etc.)" 6"Rural area outside Tamil Nadu" 7"Cities outside Tamil Nadu"
label values migrationplace2id migrationplace2
decode migrationplace2id, gen (migrationplace2)
label drop migrationplace2_tamil
drop migrationplace2_tamil
label define migrationplace2_tamil 1"அதே கிராமம்"	2"கிராமத்தை சுற்றி"	3"தமிழ்நாட்டில் உள்ள கிராமங்கள்"	4"சிறிய நகரங்கள் (பண்ருட்டி ....)"	5"தமிழ்நாட்டின் பெரிய நகரங்கள் (சென்னை....)"	6"தமிழ்நாட்டிற்கு வெளியே உள்ள கிராமம்"	7"தமிழ்நாட்டிற்கு வெளியே உள்ள நகரம்"
label values migrationplace2id migrationplace2_tamil
decode migrationplace2id, gen(migrationplace2_tamil)

* CHOICE LIST "migrationplace"
label define migrationplace 1"Around villages" 2"Rural area in Tamil Nadu" 3"Small town of the area (Panruti, etc.)" 4"Big cities of Tamil Nadu (Chennai,etc.)" 5"Rural area outside Tamil Nadu" 6"Cities outside Tamil Nadu"
label values migrationplaceid migrationplace
drop migrationplace
decode migrationplaceid, gen (migrationplace)
label drop migrationplace_tamil
label define migrationplace_tamil 1"கிராமத்தை சுற்றி"	2"தமிழ்நாட்டில் உள்ள கிராமங்கள்"	3"சிறிய நகரங்கள் (பண்ருட்டி,....)"	4"தமிழ்நாட்டின் பெரிய நகரங்கள் (சென்னை,...)"	5"தமிழ்நாட்டிற்கு வெளியே உள்ள கிராமம்"	6"தமிழ்நாட்டிற்கு வெளியே உள்ள நகரம்"
label values migrationplaceid migrationplace_tamil
drop migrationplace_tamil
decode migrationplaceid, gen(migrationplace_tamil)

* CHOICE LIST "goodbuying"
drop goodbuying
label drop goodbuying
label define goodbuying 1"Credit" 2"Instalment" 3"Ready cash" 4"Did not pay for this good"
label values goodbuyingid goodbuying
decode goodbuyingid, gen (goodbuying)
drop goodbuying_tamil
label drop goodbuying_tamil
label define goodbuying_tamil 1"கடன்"	2"தவணை முறை"	3"உடனடி பணம்"	4"இந்த பொருளுக்கு பணம் கொடுக்கவில்லை"
label values goodbuyingid goodbuying_tamil
decode goodbuyingid, gen(goodbuying_tamil)

save "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\INDID2020.dta"
drop _merge
drop seriousinjuryid seriousinjury seriousinjury_tamil
drop interviewplaceid interviewplace interviewplace_tamil migrationreason2id migrationreason2 migrationreason2_tamil


***** Création d'une base de données externe pour les choice lists"
keep reasondontsearchjobid - goodbuying_tamil
drop if district==""

foreach var of varlist*id {
gen `var'_1=1 if `var'!=.
}
//

* Modification : CHOICE LIST "username"
drop usernameid
drop username
gen usernameid=_n
replace usernameid=. if usernameid>12
label drop username
label define username 1"Antoni" 2"Vivek Radja" 3"Venkata" 4"Suganya" 5"Rajkumar" 6"Malarvizhi" 7"Chithra" 8"Raichal" 9"Rajalakschmi" 10"Radhika" 11"Mayan" 12"Pazani"
label values usernameid username
decode usernameid , gen (username)
 
* Modification : CHOICE LIST "guarantee"
drop guarantee
label define guarantee 77"Other" 1"Documents" 2"Chittu (as an assurance for repayment)" 3"SHG" 4"Personal (informal agreement)" 5"Jewel/Gold" 6"Didn't use any guarantee"
label values guaranteeid guarantee
decode guaranteeid, gen (guarantee)
label define guarantee_tamil 1"பத்திரங்கள்"	2"சிட்டு (பணத்திற்க்கான உத்திரவாதம்)"	3"சுய உதவி குழு"	4"தனிப்பட்ட (உத்திரவாதம்)"	5"நகை/தங்கம்"	6"ஒன்றும் இல்லை (உத்திரவாதம் எதுவும் இல்லை)"	77"மற்றவை"
label values guaranteeid guarantee_tamil
decode guaranteeid, gen(guarantee_tamil)

* Modification : CHOICE LIST "termsofrepayment"
drop termsofrepaymentid termsofrepayment termsofrepayment_tamil termsofrepaymentid_1
gen termsofrepaymentid=_n
replace termsofrepaymentid=. if termsofrepaymentid>4
replace termsofrepaymentid=66 if termsofrepaymentid==4
label define termsofrepayment 1"Fixed duration" 2"Repay when have money" 3"Repay when asked by the lender" 66"N/A" 
label values termsofrepaymentid termsofrepayment
decode termsofrepaymentid, gen (termsofrepayment)
label drop termsofrepayment_tamil
drop termsofrepayment_tamil
label define termsofrepayment_tamil 1"குறிப்பிட்ட நாட்கள்"	2"பணம் இருக்கும் போது அளிப்பது"	3"கடன் கொடுத்தவர் கேட்கும் போது திருப்பி கொடுத்தல்" 66"எதுவும் இல்லை"
label values termsofrepaymentid termsofrepayment_tamil
decode termsofrepaymentid, gen(termsofrepayment_tamil)
gen termsofrepaymentid_1=1 if termsofrepaymentid!=.

* CHOICE LIST "importantdecision"
drop importantdecisionid importantdecision importantdecision_tamil importantdecisionid_1
gen importantdecisionid=_n
replace importantdecisionid=. if importantdecisionid>6
replace importantdecisionid=77 if importantdecisionid==6
label define importantdecision 77"Other" 1"Job" 2"Family events" 3"Education" 4"Health" 5"Marriage"
label values importantdecisionid importantdecision
decode importantdecisionid, gen (importantdecision)
label define importantdecision_tamil 77"மற்றவை" 1"வேலை" 2"குடும்ப நிகழ்வுகள்" 3"படிப்பு" 4"உடல் நிலை/ஆரோக்கியம்" 5"திருமணம்"
label values importantdecisionid importantdecision_tamil
decode importantdecisionid, gen(importantdecision_tamil)
gen importantdecisionid_1=1 if importantdecisionid!=.

**** COVID-19 : Ajout des questions sur le COVID-19 ****
* Retrait du CHOICE LIST "yesno5"
drop yesno5id yesno5 yesno5_tamil yesno5id_1

* CHOICE LIST "yesnona"
gen yesnonaid=_n
replace yesnonaid=. if yesnonaid>3
gen yesnonaid_1=1 if yesnonaid!=.
replace yesnonaid=66 if yesnonaid==3
label define yesnona 1"Yes" 2"No" 66"N/A"
label values yesnonaid yesnona
decode yesnonaid, gen (yesnona)
label define yesnona_tamil 1"சரி" 2"இல்லை" 66"N/A"
label values yesnonaid yesnona_tamil
decode yesnonaid, gen(yesnona_tamil)

* Modification CHOICE LIST "reasondroppingout"
drop reasondroppingoutid reasondroppingout reasondroppingout_tamil reasondroppingoutid_1
gen reasondroppingoutid=_n
replace reasondroppingoutid=. if reasondroppingoutid>16
replace reasondroppingoutid=77 if reasondroppingoutid==16
gen reasondroppingoutid_1=1 if reasondroppingoutid!=.
label drop reasondroppingout
label define reasondroppingout 1"Stopped after end of education cycle" 2"Failed" 3"Too far/ Inaccessible" 4"Poor quality/lack of facilities" 5"Financial problems" 6"Health problems" 7"Not interested in school" 8"Household work / Child care" 9"Work for pay" 10"Lack of separate school/college for girls" 11"Marriage" 12"Parents/husband didn't allow studying further" 13"Puberty / Gender" 14"Too young" 15"School closure due to COVID-19" 77"Other"
label values reasondroppingoutid reasondroppingout
decode reasondroppingoutid, gen (reasondroppingout)
label drop reasondroppingout_tamil
label define reasondroppingout_tamil 1"படிப்பு முடிந்தவுடன் நிறுத்திவிட்டார்"	2"பெயில்"	3"தொலைதூரம் / வசதி இல்லை"	4"தரம் இல்லாமை / வசதி இல்லாமை"	5"நிதி (பினான்சியல்) பிரச்சனை"	6"உடல் நிலை குறைவு பிரச்சனை"	7"பள்ளிக்கு செல்ல ஆர்வம் இல்லை"	8"வீட்டு வேலை / குழந்தைகளை பார்த்துகொள்ளுதல்"	9"சம்பளத்திற்கான வேலை"	10"தனியாக பள்ளி இல்லாமை / பெண்களுக்கான கல்லூரி"	11"திருமணம்"	12"பெற்றோர் / கணவன் படிக்க அனுமதிக்கவில்லை"	13"மஞ்சள் நீர் / பாலினம்" 14"Too young" 15"ஆம்/இல்லை" 77"மற்றவை"
label values reasondroppingoutid reasondroppingout_tamil
decode reasondroppingoutid, gen(reasondroppingout_tamil)


* CHOICE LIST : "covidscale"
gen covidscaleid=_n
replace covidscaleid=. if covidscaleid>3
gen covidscaleid_1=1 if covidscaleid!=.
label define covidscale 1"More" 2"Less" 3"Same"
label values covidscaleid covidscale
decode covidscaleid, gen (covidscale)
label define covidscale_tamil 1"அதிகம்" 2"குறைவு" 3"அதே அளவு"
label values covidscaleid covidscale_tamil
decode covidscaleid, gen(covidscale_tamil)

* CHOICE LIST : "covidscale2"
gen covidscale2id=_n
replace covidscale2id=. if covidscale2id>3
gen covidscale2id_1=1 if covidscale2id!=.
label define covidscale2 1"Increase" 2"Drecrease" 3"Remain stable"
label values covidscale2id covidscale2
decode covidscale2id, gen (covidscale2)
label define covidscale2id_tamil 1"அதிகரித்துள்ளது " 2"குறைந்துள்ளது " 3"அதே அளவு "
label values covidscale2id covidscale2id_tamil
decode covidscale2id, gen(covidscale2id_tamil)


* CHOICE LIST : "expenseslist"
gen expenseslistid=_n
replace expenseslistid=. if expenseslistid>9
gen expenseslistid_1=1 if expenseslistid!=.
label define expenseslist 1"Food" 2"Transportation" 3"Clothes" 4"Health" 5"Education" 6"Gifts" 7"Ceremonies" 8"Goods" 9"None"
label values expenseslistid expenseslist
decode expenseslistid, gen (expenseslist)
label define expenseslist_tamil 1"உணவு" 2"போக்குவரத்து" 3"ஆடைகள்" 4"ஆரோக்கியம்" 5"கல்வி" 6"பரிசுகள்" 7"விழாக்கள்" 8"பொருட்கள்" 9"எதுவுமில்லை"
label values expenseslistid expenseslist_tamil
decode expenseslistid, gen(expenseslist_tamil)


* CHOICE LIST : "covlending"
gen covlendingid=_n
replace covlendingid=. if covlendingid>3
gen covlendingid_1=1 if covlendingid!=.
label define covlending 1"Lower interest rate" 2"Same interest rate" 3"higher interest rate"
label values covlendingid covlending
decode covlendingid, gen (covlending)
label define covlending_tamil 1"குறைந்த வட்டி விகிதம்" 2"அதே வட்டி விகிதம்" 3"அதிக வட்டி விகிதம்"
label values covlendingid covlending_tamil
decode covlendingid, gen(covlending_tamil)


* CHOICE LIST : "difficultycovid"
gen difficultycovidid=_n
replace difficultycovidid=. if difficultycovidid>10
replace difficultycovidid=77 if difficultycovidid==10
gen difficultycovidid_1=1 if difficultycovidid!=.
label define difficultycovid 1"Less inputs available" 2"No cash to get inputs" 3"Difficulty to sell products" 4"Difficulty to pay labourers" 5"Had to change frequency of payment of labourers" 6"Pressure from labourers on wage" 7"Had to change type of contract for labourers" 8"Lack of skilled labour" 9"None" 77"Other"
label values difficultycovidid difficultycovid
decode difficultycovidid, gen (difficultycovid)
label define difficultycovid_tamil 1"உரம் குறைவாக உள்ளது" 2"உரம் வாங்க பணம் இல்லை" 3"பொருட்களை விற்பதில் சிரமம் " 4"வேலையாட்களுக்கு சம்பளம் கொடுக்க முடியவில்லை" 5"வேலையாட்களுக்கு சம்பளம் கொடுக்கும் முறையில் மாற்றம்" 6"வேலையாட்கள் சம்பளம் கொடுக்க சொல்லி நெருக்கடி கொடுத்தல்" 7"தொழிலாளர்களுக்கான ஒப்பந்த வகையை மாற்ற வேண்டியிருந்தது" 8"திறமையான உழைப்பு இல்லாமை" 9"எதுவுமில்லை" 77"மற்றவை"
label values difficultycovidid difficultycovid_tamil
decode difficultycovidid, gen(difficultycovid_tamil)

* CHOICE LIST : "workcovid"
gen workcovidid=_n
replace workcovidid=. if workcovidid>6
replace workcovidid=66 if workcovidid==6
gen workcovidid_1=1 if workcovidid!=.
label define workcovid 1"More" 2"Less" 3"Same" 4"Constrained to stop due to COVID-19 lockdown" 5"Never start due to COVID-19 lockdown" 66"N/A"
label values workcovidid workcovid
decode workcovidid, gen (workcovid)
label define workcovid_tamil 1"அதிகம்" 2"குறைவாக" 3"அதே" 4"COVID-19  காரணமாக நிறுத்த தடை விதிக்கப்பட்டுள்ளது" 5"COVID-19  காரணமாக ஒருபோதும் தொடங்கப்படவில்லை" 66"N/A"
label values workcovidid workcovid_tamil
decode workcovidid, gen(workcovid_tamil)


* CHOICE LIST : "institution"
gen institutionid=_n
replace institutionid=. if institutionid>5
gen institutionid_1=1 if institutionid!=.
label define institution 1"Your community council" 2"Tamil Nadu government" 3"The police" 4"Traditional leaders" 5"Religious leaders"
label values institutionid institution
decode institutionid, gen (institution)
label define institution_tamil 1"உங்கள் சமூக சபை" 2"தமிழக அரசு" 3"காவல்துறை" 4"பாரம்பரிய தலைவர்கள்" 5"மதத் தலைவர்கள்"
label values institutionid institution_tamil
decode institutionid, gen(institution_tamil)

* CHOICE LIST : "covinstit"
gen covinstitid=_n
replace covinstitid=. if covinstitid>4
gen covinstitid_1=1 if covinstitid!=.
label define covinstit 1"முழு நம்பிக்கை" 2"போன்ற" 3"உண்மையில் இல்லை" 4"இல்லவே இல்லை"
label values covinstitid covinstit
decode covinstitid, gen (covinstit)
label define covinstit_tamil 1"முழு நம்பிக்கை" 2"போன்ற" 3"உண்மையில் இல்லை" 4"இல்லவே இல்லை"
label values covinstitid covinstit_tamil
decode covinstitid, gen(covinstit_tamil)

* Réintroduction de la CHOICE LIST "assohelpbusiness"
gen assohelpbusinessid=_n
replace assohelpbusinessid=. if assohelpbusinessid>8
replace assohelpbusinessid=77 if assohelpbusinessid==8
gen assohelpbusinessid_1=1 if assohelpbusinessid!=.
label define assohelpbusiness 1"Advice on how to run business" 2"New information useful for business" 3"New customers/suppliers" 4"Find/Improve premises" 5"Financial support" 6"Other material support" 7"Emotional support" 77"Other"
label values assohelpbusinessid assohelpbusiness
decode assohelpbusinessid, gen (assohelpbusiness)
label define assohelpbusiness_tamil 1"எப்படி தொழில் செய்வது என்று ஆலோசனை வழங்குதல்"	2"தொழிலுக்கான பயனுள்ள புதிய தகவல்கள்"	3"புதிய வாடிக்கையாளர்கள் / வினியோகஸ்தர்கள்"	4"வியாபார இடத்தை சிறப்பாக்க உதவி செய்தல்"	5"நிதி உதவி"	6"மற்ற பொருட்கள் உதவி"	7"எந்த சூழலிலும் உடன் இருப்பார்களா"	77"மற்றவை"
label values assohelpbusinessid assohelpbusiness_tamil
decode assohelpbusinessid, gen(assohelpbusiness_tamil)

* Réintroduction de la CHOICE LIST "settleloanstrategy"
gen settleloanstrategyid=_n
replace settleloanstrategyid=. if settleloanstrategyid>11
gen settleloanstrategyid_1=1 if settleloanstrategyid!=.
replace settleloanstrategyid=77 if settleloanstrategyid==11
label define settleloanstrategy 77"Other" 1"Using normal income from labour" 2"Using income from schemes/pensions" 3"Borrowing elsewhere" 4"Selling something which was not planned" 5"Lease land" 6"Consumption reduction" 7"Take an additional job" 8"Work more" 9"Relative or friends support" 10"Selling the harvest in advance"
label values settleloanstrategyid settleloanstrategy
decode settleloanstrategyid, gen (settleloanstrategy)
label define settleloanstrategy_tamil 1"வேலை செய்பரின் சாதாரண வருமானத்தில் இருந்து"	2"ஓய்வூதியம்/ திட்டங்கள் வருமானத்தை பயன்படுத்தி "	3"வேறு எங்கேயாவது கடன் வாங்குதல்"	4"திட்டமிடாத ஏதோ ஒன்றை விற்றல்"	5"நிலம் குத்தகை விடுதல்"	6"செலவை குறைத்தல்"	7"வேறு ஒரு வேலையும் செய்தல்"	8"அதிகமான வேலை செய்தல்"	9"உறவினர் மற்றும் நண்பர்கள் உதவி"	10"மகசூலை முன்பே விற்றுவிடுதல்"	77"மற்றவை"
label values settleloanstrategyid settleloanstrategy_tamil
decode settleloanstrategyid, gen(settleloanstrategy_tamil)

* Réintroduction de la CHOICE LIST "reasonborrowing"
gen reasonborrowingid=_n
replace reasonborrowingid=. if reasonborrowingid>13
replace reasonborrowingid=77 if reasonborrowingid==13
gen reasonborrowingid_1=1 if reasonborrowingid!=.
label define reasonborrowing 1"Agriculture" 2"Family expenses" 3"Health expenses" 4"Repay previous loan" 5"House expenses" 6"Investment" 7"Ceremonies" 8"Marriage" 9"Education" 10"Relatives expenses" 11"Death expenses"  12"No reason" 77"Other"
label values reasonborrowingid reasonborrowing
decode reasonborrowingid, gen (reasonborrowing)
label define reasonborrowing_tamil 1"விவசயாம்"	2"குடும்ப செலவுகள்"	3"மருத்துவ செலவு"	4"பழைய கடனை திருப்பி அளித்தல்"	5"வீட்டு செலவு"	6"மூதலீடு"	7"சடங்குகள்"	8"திருமணம்"	9"கல்வி"	10"உறவினர்கள் செலவு"	11"இறப்பு செலவுகள்"	12"காரணம் இல்லை"	77"மற்றவை"
label values reasonborrowingid reasonborrowing_tamil
decode reasonborrowingid, gen(reasonborrowing_tamil)


* Réintroduction de la CHOICE LIST "demo7"
gen demo7id=_n
replace demo7id=. if demo7id>7
replace demo7id=77 if demo7id==7
gen demo7id_1=1 if demo7id!=.
label define demo7 77"Other" 1"No need" 2"Distrust money transactions by card" 3"Prefer cash transactions " 4"Less flexilibty of transactions" 5"Difficult access to ATM/banking infrastructures" 6"Afraid to use it / Don't know how to use it"
label values demo7id demo7
decode demo7id, gen (demo7)
label define demo7_tamil 77"மற்றவை" 1"தேவை இல்லை" 2"கார்டின் மூலம் பண பரிவர்த்தனை நம்பிக்கை இல்லை" 3"பணமாக கொடுப்பதை விரும்புகிறேன்" 4"பணம் கொடுப்பதில் குறைந்த அளவு வாய்ப்பு உள்ளது" 5"ATM உபயோகிப்பதில் கஷ்டம்/ வங்கியின் கட்டமைப்பு" 6"உபயோகிப்பதற்கு பயம்/எப்படி உபயோகிப்பது என்று தெரிய வில்லை"
label values demo7id demo7_tamil
decode demo7id, gen(demo7_tamil)


* Réintroduction de la CHOICE LIST "methodfindjob"
gen methodfindjobid=_n
replace methodfindjobid=. if methodfindjobid>11
replace methodfindjobid=66 if methodfindjobid==10
replace methodfindjobid=99 if methodfindjobid==11
gen methodfindjobid_1=1 if methodfindjobid!=.
label define methodfindjob 1"THROUGH SOCIAL NETWORK: FRIENDS" 2"THROUGH SOCIAL NETWORK: RELATIVES" 3"THROUGH SOCIAL NETWORK: OTHER" 4"CONTACT EMPLOYERS DIRECTLY (VISIT/SEND LETTERS/APPLICATION)" 5"THROUGH PUBLIC EMPLOYMENT AGENCY" 6"THROUGH PRIVATE EMPLOYMENT AGENCY" 7"THROUGH UNIVERSITY/SCHOOL CAREERS' OFFICE" 8"RESPOND TO MEDIA AD/ PUT AD IN PAPER" 9"SEARCH ON INTERNET/ POSTED ON INTERNET" 66"N/A" 99"No response"
label values methodfindjobid methodfindjob
decode methodfindjobid, gen (methodfindjob)
label define methodfindjob_tamil 1"வெளியுலக தொடர்பு: நண்பர்கள்"	2"வெளியுலக தொடர்பு: உறவினர்கள்"	3"வெளியுலக தொடர்பு: மற்றவை"	4"நேரடியாக முதலாளியை தொடர்பு கொள்ளுதல் (ghh;j;jy; / fbjk; mspj;jy; / tpz;zg;gk;)"	5"பொது வேலை வாய்ப்பு நிறுவனம் மூலமாக"	6"தனியார் வேலை வாய்ப்பு நிறுவனம் மூலமாக"	7"பல்கலைகழகம் மூலமாக / பள்ளியின் வேலைவாய்ப்பு நிறுவனம்"	8"ஊடகம் (மீடியா) மூலம் விளம்பரம் / செய்தித்தாளில் விளம்பரம்"	9"இன்டர்நெட் மூலம் தேடுதல்/இன்டர்நெட்டில்"	99"பதில் இல்லை"	66"N/A"
label values methodfindjobid methodfindjob_tamil
decode methodfindjobid, gen(methodfindjob_tamil)


* Réhanilitation de la CHOICE LIST "migrationreason"
gen migrationreasonid=_n
replace migrationreasonid=. if migrationreasonid>11
replace migrationreasonid=77 if migrationreasonid==11
gen migrationreasonid_1=1 if migrationreasonid!=.
label define migrationreason 1"Not enough work in local area" 2"Get advance" 3"Job assurance" 4"Have to repay previous advance" 5"Better opportunity in the migration place" 6"More interesting job in the migration place" 7"Can earn more money than local place" 8"Diversify activities" 9"Get better status" 10"Know someone in migration place who can help me" 77"Other"
label values migrationreasonid migrationreason
decode migrationreasonid, gen (migrationreason)
label define migrationreason_tamil  1"உள்ளூரில் போதுமான வேலை இல்லை"	2"முன்பணம் கிடைக்கும்"	3"வேலைக்கான உத்திரவாதம்"	4"முந்தய முன்பணத்தை திருப்பி செலுத்த வேண்டும்"	5"இடம்பெயர்வு இடத்தில் நல்ல வாய்ப்பு"	6"இடம்பெயர்வு இடத்தில் சுவாரசியமான வேலை"	7"உள்ளூரை விட அதிகமாக சம்பாதிக்க முடியும்"	8"பன்முகத்தன்மை நடவடிக்கைகள்"	9"நல்ல நிலையை பெற"	10"இடம் பெயர்ந்த இடத்தில் உதவி செய்ய ஆள் இருக்கிறார்கள்"	77"மற்றவை"
label values migrationreasonid migrationreason_tamil
decode migrationreasonid, gen(migrationreason_tamil)

* Réhabilitation de la CHOICE LIST "decisionwork2"
gen decisionwork2id=_n
replace decisionwork2id=. if decisionwork2id>10
replace decisionwork2id=77 if decisionwork2id==10
gen decisionwork2id_1=1 if decisionwork2id!=.
label define decisionwork2 77"Other" 1"Yourself" 2"Spouse" 3"Your spouse and yourself jointly" 4"Your parents/parents-in-law and yourself jointly" 5"Your parents or parents-in-law" 6"Children" 7"Your children and yourself jointly" 8"Someone else" 9"Someone else and yourself jointly" 
label values decisionwork2id decisionwork2
decode decisionwork2id, gen (decisionwork2)
*label define decisionwork2_tamil 77"மற்றவை" 1"நீங்களே" 2"மனைவி" 3"உங்கள் மனைவியும் நீங்களும் சேர்ந்து" 4"உங்கள் பெற்றோர் / பெற்றோர் மாமியார் மற்றும் நீங்களும் சேர்ந்து" 5"உங்கள் பெற்றோர் அல்லது பெற்றோர் மாமியார்" 6"குழந்தைகள்" 7"உங்கள் குழந்தைகளும் நீங்களும் சேர்ந்து" 8"வேறு யாரோ ஒருவர்" 9"நீங்களும் வேறு யாரோ ஒருவரும் சேர்ந்து"
*label values decisionwork2id decisionwork2_tamil
*decode decisionwork2id, gen(decisionwork2_tamil)

* Réhabilitation de la CHOICE LIST "reasonstoppedjob"
gen reasonstoppedjobid=_n
replace reasonstoppedjobid=. if reasonstoppedjobid>13
replace reasonstoppedjobid=77 if reasonstoppedjobid==13
gen reasonstoppedjobid_1=1 if reasonstoppedjobid!=.
label define reasonstoppedjob 1"Fired" 2"End of contract/business slowdown" 3"Business you worked for closed" 4"Employer reduced your work hours" 5"Low wage/ bad working conditions" 6"Retired" 7"Pregnancy/ child birth" 8"Health (ill/disabled)" 9"Looking after family/children" 10"Moved to another area" 11"To continue education/training" 12"Preferred to work in self-employment" 77"Other"
label values reasonstoppedjobid reasonstoppedjob
decode reasonstoppedjobid, gen (reasonstoppedjob)
*label define reasonstoppedjob_tamil 1"பதவி நீக்கம்"	2"ஒப்பந்தம் முடிந்தது / தொழில் மந்தம்"	3"வேலை செய்த தொழில் மூடப்பட்டுவிட்டது"	4"முதலாளி வெலை நேரத்தை குறைத்துவிட்டார்"	5"குறைவான சம்பளம் / மோசமான வேலை நிலை"	6"ஓய்வு பெற்றுவிட்டது. (பணி ஓய்வு)"	7"கர்பமாக இருத்தல் / குழந்தை பிறப்பு"	8"உடல் நிலை (நோயுற்று இருந்தல் / ஊனமுற்றிருத்தல்)"	9"குடும்பத்திஅ கவனித்துக் கொள்ளுதல் / குழந்தைகள்"	10"வேறு இடத்திற்கு சென்றுவிட்டது"	11"படிக்க / பயிர்ச்சி பெற விருப்பம் வேறுப்பகுதிக்கு செல்லப்பட்டது"	12"சுயதொழில் செய்ய விருப்பம்"	77"மற்றவை"
*label values reasonstoppedjobid reasonstoppedjob_tamil
*decode reasonstoppedjobid, gen(reasonstoppedjob_tamil)


* Réhabilitation CHOICE LIST "interviewplace"
gen interviewplaceid=_n
replace interviewplaceid=. if interviewplaceid>3
gen interviewplaceid_1=1 if interviewplaceid!=.
label define interviewplace 1"Inside village" 2"New place of permanent residency outside village" 3"Migration workplace"
label values interviewplaceid interviewplace
decode interviewplaceid, gen (interviewplace)
label define interviewplace_tamil 1"கிராமத்தின் உள்ளே" 2"கிராமத்திற்கு வெளியே நிரந்தர வசிப்பிடத்தின்  புதிய இடம்" 3"இடம்பெயர்வு பணியிடம்"
label values interviewplaceid interviewplace_tamil
decode interviewplaceid, gen(interviewplace_tamil)

* Réhabilitation employertypeid
gen employertypeid=_n
replace employertypeid=. if employertypeid>8
replace employertypeid=77 if employertypeid==8
gen employertypeid_1=1 if employertypeid!=.
label define employertype 1"State administration (including military)" 2"State-owned enterprise/farm or joint state-private entreprise" 3"Paid public works" 4"An individual (maistry...)" 5"Private firm or plant or farm" 6"Cooperative firm/farm" 7"NGO/ international, political, humanitarian organization" 77"Other"
label values employertypeid employertype
decode employertypeid, gen (employertype)
label define employertype_tamil 1"அரசாங்க நிறுவனம் (ராணுவம் உட்பட)"	2"அரசாங்கத்தின் அல்லது அரசு/ தனியார் நிறுவனம்"	3"பணம் கட்டிய பொது வேலை"	4"தனி நபர் (மேஸ்திரி....)"	5"தனியார் தொழில் அல்லது நிறுவனம்"	6"கூட்டுறவு நிறுவனம்"	7"NGO / உலக, அரசியல், மனித உரிமை நிறுவனங்கள்"	77"மற்றவை"
label values employertypeid employertype_tamil
decode employertypeid, gen(employertype_tamil)


* Correction et ajout du 20 aout 2020
drop usernameid_1
tab usernameid, nol
gen usernameid_1=1 if usernameid!=.


***** Discriminations positives - Thèse Mary *******
gen reservationid=_n
replace reservationid=. if reservationid>5
gen reservationid_1=1 if reservationid!=.
label define reservation 1"Quotas in higher education institutions" 2"Free secondary schooling" 3"Scholarships" 4"Specific schools" 5"Hostels and free mid day meals"
label values reservationid reservation
decode reservationid, gen (reservation)
label define reservation_tamil 1"உயர்கல்வி நிறுவனங்களில் ஒதுக்கீடுகள்" 2"இலவச மேல்நிலைப் பள்ளி கல்வி" 3"உதவித்தொகை" 4"குறிப்பிட்ட பள்ளிகள்" 5"விடுதிகள் மற்றும் இலவச மதிய உணவு"
label values reservationid reservation_tamil
decode reservationid, gen (reservation_tamil)

************** 24 août 2020 : Journée des tests *************	
* Oubli d'une variable avec liste de choix 
gen reasondroppingoutid_1=1 if reasondroppingoutid!=.
gen tamil_district= district
*ATTENTION: Ptet à supprimer si liste de districts en tamil


* CHOICE LIST : "covidscale"
drop covidscaleid covidscale covidscaleid_tamil covidscaleid_1
gen covidscaleid=_n
replace covidscaleid=. if covidscaleid>3
gen covidscaleid_1=1 if covidscaleid!=.
label define covidscale 1"More" 2"Less" 3"Same"
label values covidscaleid covidscale
decode covidscaleid, gen (covidscale)
label define covidscale_tamil 1"அதிகம்" 2"குறைவு" 3"அதே அளவு"
label values covidscaleid covidscale_tamil
decode covidscaleid, gen(covidscale_tamil)


* CHOICE LIST "occuplist2"
drop occuplist2id occuplist2id_1 occuplist2 occuplist2_tamil
label drop occuplist2 occuplist2_tamil
gen occuplist2id=_n
replace occuplist2id=. if occuplist2id>8
replace occuplist2id=77 if occuplist2id==8
gen occuplist2id_1=1 if occuplist2id!=.
label define occuplist2 77"Other" 1"Civil servant" 2"Salaried job (agri)" 3"Salaried job (non-agri, in industry or services)" 4"Self-employed" 5"Works in household business" 6"Farmer" 7"Unemployed / Not active"
label values occuplist2id occuplist2
decode occuplist2id, gen (occuplist2)
label define occuplist2_tamil 1"அரசு வேலை"	2"சம்பள வேலை ஆள்"	3"சுயவேலை"	4"குடும்ப தொழில் வேலை"	5"விவசாயம்"	6"வேலை இல்லை/ செயல்படாத" 7"வேலை இல்லை/ செயல்படாத"	77"மற்றவை"
label values occuplist2id occuplist2_tamil
decode occuplist2id, gen(occuplist2_tamil)


* CHOICE LIST "jobpreference"
gen jobpreferenceid=_n
replace jobpreferenceid=. if jobpreferenceid>4
replace jobpreferenceid=99 if jobpreferenceid==3
replace jobpreferenceid=66 if jobpreferenceid==4
gen jobpreferenceid_1=1 if jobpreferenceid!=.
label define jobpreference 1"Self-employed" 2"Employee / Salaried worker" 99"No response" 66"N/A"
label values jobpreferenceid jobpreference
decode jobpreferenceid, gen(jobpreference)
label define jobpreference_tamil 1"சுய தொழில்" 2"ஊழியர் / சம்பள வேலையாள்" 99"பதில் இல்லை" 66"N/A"
label values jobpreferenceid jobpreference_tamil
decode jobpreferenceid, gen(jobpreference_tamil)


* One missing option for this CHOICE LIST "institution"
drop institutionid institutionid_1 institution institution_tamil
label drop institution
label drop institution_tamil
gen institutionid=_n
replace institutionid=. if institutionid>6
gen institutionid_1=1 if institutionid!=.
label define institution 1"Your community council" 2"Tamil Nadu government" 3"The police" 4"Traditional leaders" 5"Religious leaders" 6"None"
label values institutionid institution
decode institutionid, gen (institution)
label define institution_tamil 1"உங்கள் சமூக சபை" 2"தமிழக அரசு" 3"காவல்துறை" 4"பாரம்பரிய தலைவர்கள்" 5"மதத் தலைவர்கள்" 6"ஒன்றும் இல்லை"
label values institutionid institution_tamil
decode institutionid, gen(institution_tamil)


* One error with this CHOICE LIST in Tamil "methodfindjob"
drop methodfindjobid methodfindjob methodfindjob_tamil
label drop methodfindjob
label drop methodfindjob_tamil
gen methodfindjobid=_n
replace methodfindjobid=. if methodfindjobid>11
replace methodfindjobid=66 if methodfindjobid==10
replace methodfindjobid=99 if methodfindjobid==11
label define methodfindjob 1"THROUGH SOCIAL NETWORK: FRIENDS" 2"THROUGH SOCIAL NETWORK: RELATIVES" 3"THROUGH SOCIAL NETWORK: OTHER" 4"CONTACT EMPLOYERS DIRECTLY (VISIT/SEND LETTERS/APPLICATION)" 5"THROUGH PUBLIC EMPLOYMENT AGENCY" 6"THROUGH PRIVATE EMPLOYMENT AGENCY" 7"THROUGH UNIVERSITY/SCHOOL CAREERS' OFFICE" 8"RESPOND TO MEDIA AD/ PUT AD IN PAPER" 9"SEARCH ON INTERNET/ POSTED ON INTERNET" 66"N/A" 99"No response"
label values methodfindjobid methodfindjob
decode methodfindjobid, gen (methodfindjob)
label define methodfindjob_tamil 1"வெளியுலக தொடர்பு: நண்பர்கள்"	2"வெளியுலக தொடர்பு: உறவினர்கள்"	3"வெளியுலக தொடர்பு: மற்றவை"	4"நேரடியாக முதலாளியை தொடர்பு கொள்ளுதல்"	5"பொது வேலை வாய்ப்பு நிறுவனம் மூலமாக"	6"தனியார் வேலை வாய்ப்பு நிறுவனம் மூலமாக"	7"பல்கலைகழகம் மூலமாக / பள்ளியின் வேலைவாய்ப்பு நிறுவனம்"	8"ஊடகம் (மீடியா) மூலம் விளம்பரம் / செய்தித்தாளில் விளம்பரம்"	9"இன்டர்நெட் மூலம் தேடுதல்/இன்டர்நெட்டில்"	99"பதில் இல்லை"	66"N/A"
label values methodfindjobid methodfindjob_tamil
decode methodfindjobid, gen(methodfindjob_tamil)


**** INDID2020: Création d'une base de données avec les pre-loaded data"
keep villageid- villagearea hhheadfinale
gen villagename_tamil= villagename
gen villagearea_tamil= villagearea
gen hhheadfinale_tamil= hhheadfinale
export delimited using "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\INDID2020.csv", nolabel replace
merge m:m HHID_panel using "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\Questionnaire individuel - Database\INDID2020_agriculture.dta"
replace ownland=0 if ownland==.

*** INDID2020: Ajout des données pre-loaded pour le module agriculture***
use "C:\Users\Cecile\Documents\NEEMSIS IFP\Data\NEEMSIS Databases-last\NEEMSIS-HH.dta"
keep dummyeverhadland ownland sizeownland HHID householdid INDID
merge m:m HHID using "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\Questionnaire individuel - Database\unique_identifier_3W.dta"
save "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\Questionnaire individuel - Database\INDID2020_agriculture.dta", replace


**** ADDITIONAL MODIFICATIONS FOLLOWING THE PILOT PHASE ****
* Modification : CHOICE LIST "howpaymarriage"
drop howpaymarriageid howpaymarriage howpaymarriage_tamil howpaymarriageid_1
label drop howpaymarriage howpaymarriage_tamil
gen howpaymarriageid=_n
replace howpaymarriageid=. if howpaymarriageid>4
gen howpaymarriageid_1=1 if howpaymarriageid!=.
label define howpaymarriage 1"Loan" 2"Own capital / Savings" 3"Gift" 4"Both"
label values howpaymarriageid howpaymarriage
decode howpaymarriageid, gen (howpaymarriage)
label define howpaymarriage_tamil 1"கடன்" 2"சொந்த முதலீடு / சேமிப்பு" 4"இரண்டும்" 3"சொந்தக்காரர்கள் உதவி"
label values howpaymarriageid howpaymarriage_tamil
decode howpaymarriageid, gen(howpaymarriage_tamil)

save "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\datachoicelist.dta", replace
export delimited using "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\datachoicelist.csv", replace
* Enregistrement d'une copie de la version de la base de données datachoicelist du mardi 27 octobre en version .csv et en version .dta

* Modification : CHOICE LIST "productpledge"
drop productpledgeid productpledgeid_1 productpledge productpledge_tamil
label drop productpledge_tamil
gen productpledgeid=_n
replace productpledgeid=. if productpledgeid>17
gen productpledgeid_1=1 if productpledgeid!=.
replace productpledgeid=77 if productpledgeid==17
label define productpledge 1"Gold" 2"Land" 3"Car" 4"Bike" 5"Fridge" 6"Costly furniture (>10 000 rupees)" 7"Tailoring machine" 8"Cell phone" 9"Land line phone" 10"DVD" 11"Camera" 12"Cooking gas" 13"Computer" 14"Dish antenna" 15"Silver" 16"None" 77"Other"
label values productpledgeid productpledge
decode productpledgeid, gen(productpledge)
label define productpledge_tamil 1"நகை"	2"நிலம்"	3"கார்"	4"பைக்"	5"பிரிட்ஸ்"	6"விலையுயர்ந்த நார்காலி, மேசைகள்"	7"டைலரிங் மிஷின்"	8"செல்போன்"	9"வீட்டு தொலைபேசி"	10"DVD"	11"கேமரா" 12"சமயல் கேஸ்" 13"கம்யூட்டர்" 14"டிஷ் ஆன்டனா" 15"வெள்ளி" 16"ஒன்றும் இல்லை"	77"மற்றவை"
label values productpledgeid productpledge_tamil
decode productpledgeid, gen(productpledge_tamil)

save "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\datachoicelist.dta", replace
export delimited using "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\datachoicelist.csv", replace

* Modification : CHOICE LIST "reservation" - Discriminations positives Thèse Mary
drop reservationid reservationid_1 reservation reservation_tamil
label drop reservation_tamil
gen reservationid=_n
replace reservationid=. if reservationid>6
replace reservationid=77 if reservationid==6
gen reservationid_1=1 if reservationid!=.
label define reservation 1"Quotas in higher education institutions" 2"Free secondary schooling" 3"Scholarships" 4"Specific schools" 5"Hostels and free mid day meals" 77"Other"
label values reservationid reservation
decode reservationid, gen (reservation)
label define reservation_tamil 1"உயர்கல்வி நிறுவனங்களில் ஒதுக்கீடுகள்" 2"இலவச மேல்நிலைப் பள்ளி கல்வி" 3"உதவித்தொகை" 4"குறிப்பிட்ட பள்ளிகள்" 5"விடுதிகள் மற்றும் இலவச மதிய உணவு" 77"மற்றவை"
label values reservationid reservation_tamil
decode reservationid, gen (reservation_tamil)

save "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\datachoicelist.dta", replace
export delimited using "C:\Users\Cecile\Documents\NEEMSIS IFP\Questionnaires\datachoicelist.csv", replace







