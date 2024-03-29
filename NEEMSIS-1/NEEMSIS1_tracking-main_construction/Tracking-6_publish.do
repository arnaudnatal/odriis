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
global directory "C:\Users\Arnaud\Documents\MEGA\Data\Data_NEEMSIS1_Tracking\DATA"
cd"$directory"
****************************************
* END




****************************************
* Tracking
****************************************
use"NEEMSIS-tracking_v8.dta", clear

***
merge m:1 HHID2019 INDID_mig using "NEEMSIStrack-SNindiv"
drop _merge

********** Order
order HHID2019 geolocationlatitude geolocationlongitude geolocationaltitude geolocationaccuracy interviewplacemig username householdvillageoriginal householdidoriginal migrationplacename migrationplace migrationareatype migrationareaurban migrationarearural migrationaddress sharedhhmig householdmigrantslist othermemberhhmig rankingmigrant migrationremark dummynewmb dummymainmigrant INDID_mig INDID_nonmig namenumber name sex age comefrom relationshiptohead maritalstatus caste casteother religion religionother relationshiptoheadother everattendedschool classcompleted currentlyatschool educationexpenses dummyworkedpastyear reasonnotworkpastyear reasonnotworkpastyearother, first


order migrationdummy migrationjobid1 migrationjobname1 migrationarea1 migrationplace1 migrationdistance1 migrationtype1 migrationdurationfreq1 migrationdurationinmonth1 migdummybacktovillage1 migrationtravelcost1 migrationtravelpayment1 migrationtenure1 migrationfindjob1 migrationjobtype1 migrationjobtype21 migrationwagetype1 migrationsalary1, after(reasonnotworkpastyear)

order dummyownland sizeownland landpurchased landpurchasedacres landpurchasedamount foodexpenses healthexpenses ceremoniesexpenses ceremoniesrelativesexpenses deathexpenses house rentalhouse housevalue housetype housesize electricity water toiletfacility noowntoilet schemeslist landpurchasedhowbuy listgoods housetitle ownotherhouse otherhouserent otherhousevalue, after(migrationsalary1)


order lefthomeduration migration1type2 migration1type2other migration1reason migration1reasonother migration1reasonoccup satisfaction migration1type rationhelptrue migration1decision migration1forced migration1cost sourcemigrationcost helpmigration, after(otherhousevalue)

order canread after10thstandard durationafter10th typeofhigheredu subjectsafter10th othersubjectsafter10th amountschoolfees bookscost transportcost otherreasondroppingschool otherreasonneverattschool dummyscholarship scholarshipamount scholarshipduration converseinenglish, after(sourcemigrationcost)

order reasonnotworkpastyearother stoppedworking, after(converseinenglish)

order migrationpension1 migrationbonus1 migrationinsurance1 migrationchild1 migrationmainoccup1 migrationskill1 migrationreason1 migrationotherreason1 dummyremittancessent compulsoryremittances remittancessentid1 remittancessentname1 remittancessentname2 remittancessentname3 remittancessentname4 remittancessentname5 remittancessentname6 remitsentdummyvillage1 remittancessentrelation1 remittancessentoccup1 remittancessentplace1 remittancessentfrequency1 remittancessentamount1 remitsenttotalamount1 remittancessentservices1 remitsentsourceoccupother1 dummyremittancesreceived remittancesrecipientid1 remittancesrecipientname1 remitrecipsourceid1 remitrecipsourcename1 remitrecsourcerelation1 remitrecsourcehh1 remitrecsourceoccup1 remitrecsourceplace1 remitrecfreq1 remitrecamount1 remitrectotalamount1 remitrecservices1 remitrecsourceoccupoth1 remitrecservicesother1, after(stoppedworking)


order everwork workpastsevendays searchjob startbusiness searchjobsince15 businessafter15 nbermonthsearchjob readystartjob jobpreference moveoutsideforjob moveoutsideforjobreason aspirationminimumwage dummyaspirationmorehours reasondontworkmore aspirationminimumwage2 kindofworkfirstjob unpaidinbusinessfirstjob agestartworking agestartworkingpaidjob othermethodfindfirstjob monthstofindjob maxhoursayear selected_occupposition selected_occupname dummymainoccupation2 occupation1 occupation2 occupation3 occupation4 occupation5 occupation6 occupation7 occupation8 nbofoccupations othermainoccupation2 mainoccupation dummyregularmainoccup inddaysayear2 indhoursaday2 indhoursayear1 indhoursayear2 indhoursayear beforemainoccup otherbeforemainoccup mainoccuptype dummypreviouswagejob previousjobcontract otherreasonstoppedjob, after(remitrecservicesother1)

order businessnbworkers dummybusinessunpaidworkers businessnbunpaidworkers businessnbfamilyworkers dummybusinesspaidworkers businessnbpaidworkers businessworkersfreqpayment businesslaborcost frequencygrossreceipt amountgrossreceipt businessfixedcosts businessfixedcostsamount businessexpenses businesssocialsecurity businesspaymentinkind wagejobemployer otherwagejobemployer wagejobnbworkers contract wagejobtype wagejobsocialsecurity dummysalary jobwagefrequencycash jobwageamountcash wagejobpaymentinkind wagejobpaykindvalue_cloth wagejobpaykindvalue_food wagejobpaykindvalue_trspt wagejobpaykindvalue_acco wagejobpaykindvalue_labour wagejobpaykindvalue_other, after(otherreasonstoppedjob)


order respect workmate useknowledgeatwork satisfactionprogress satisfyingpurpose schedule takeholiday agreementatwork1 agreementatwork2 agreementatwork3 agreementatwork4 changework happywork satisfactionsalary executionwork1 executionwork2 executionwork3 executionwork4 executionwork5 executionwork6 executionwork7 executionwork8 executionwork9 executionwork10 accidentalinjury losswork lossworknumber mostseriousincident mostseriousinjury seriousinjuryother physicalharm problemwork1 problemwork2 problemwork3 problemwork4 problemwork5 problemwork6 problemwork7 problemwork8 problemwork9 workexposure1 workexposure2 workexposure3 workexposure4 workexposure5 hearworker professionalequipment break retirementwork verbalaggression physicalagression sexualharassment sexualaggression discrimination1 discrimination2 discrimination3 discrimination4 discrimination5 discrimination6 discrimination7 discrimination8 discrimination9, after(wagejobpaykindvalue_other)

order associationid associationtype associationname assodegreeparticip assosize dummyassorecommendation recoasso snrecommendassoname1 snrecommendassoname2 snrecommendassoname3 snrecommendassoname4 snrecommendassoname5 snrecommendassoname6 snrecommendassoname7 snrecommendassoname8 snrecommendassoname9 snrecommendassoname10 snrecommendassoname11 snrecommendassoname12 snrecommendassoname13 snrecommendassoname14 snrecommendassoname15 snrecommendassoname16 snrecommendassoname17 snrecommendassoname18 snrecommendassoname19 snrecommendassoname20 snrecommendassoname21 snrecommendassoname22 snrecommendassoname23 snrecommendassoname24 dummyassohelpjob assohelpjob assocotherhelpjob dummyassohelpbusiness assohelpbusiness assootherhelpbusiness, after(discrimination9)


order sntechnicalhelp technicalhelp sntechnicalhelpname1 sntechnicalhelpname2 sntechnicalhelpname3 sntechnicalhelpname4 sntechnicalhelpname5 sntechnicalhelpname6 sntechnicalhelpname7 snentrustbusiness entrust snentrustbusinessname1 snentrustbusinessname2 snentrustbusinessname3 snentrustbusinessname4 snentrustbusinessname5 snentrustbusinessname6 snentrustbusinessname7 snrecruitworker recruitworker snrecruitworkername1 snrecruitworkername2 snrecruitworkername3 snrecruitworkername4 snrecruitworkername5 snrecruitworkername6 snrecruitworkername7 snfindsuppliers findsuppliers snfindsuppliersname1 snfindsuppliersname2 snfindsuppliersname3 snfindsuppliersname4 snfindsuppliersname5 snfindsuppliersname6 snfindsuppliersname7 snlendtools lendtools snlendtoolsname1 snlendtoolsname2 snlendtoolsname3 snlendtoolsname4 snlendtoolsname5 snlendtoolsname6 snlendtoolsname7 snfindjob findjob snfindjobname1 snfindjobname2 snfindjobname3 snfindjobname4 snfindjobname5 snfindjobname6 snfindjobname7 snrecommendforjob recojob snrecommendforjobname1 snrecommendforjobname2 snrecommendforjobname3 snrecommendforjobname4 snrecommendforjobname5 snrecommendforjobname6 snrecommendforjobname7 snrecojobsuccess recojobsuccess snrecojobsuccessname1 snrecojobsuccessname2 snrecojobsuccessname3 snrecojobsuccessname4 snrecojobsuccessname5 snrecojobsuccessname6 snrecojobsuccessname7, after(assootherhelpbusiness)

order nbercontactphone nberpersonfamilyevent contactnumber_head contactnumber_police contactnumber_civil contactnumber_bank contactnumber_pancha contactnumber_council contactnumber_recruiter contactnumber_trade dummycontactleaders contactleaders networktrustneighborhood networktrustemployees networkpeoplehelping networkhelpkinmember, after(snrecojobsuccessname7)

order dummyrespondentadult enjoypeople curious organized managestress interestedbyart tryhard workwithother makeplans sharefeelings nervous stickwithgoals repetitivetasks shywithpeople workhard changemood understandotherfeeling inventive enthusiastic feeldepressed appointmentontime trustingofother goaftergoal easilyupset talktomanypeople liketothink finishwhatbegin putoffduties rudetoother finishtasks toleratefaults worryalot easilydistracted keepworking completeduties talkative newideas staycalm forgiveother activeimagination expressingthoughts helpfulwithothers canreadcard1a canreadcard1b canreadcard1c canreadcard2 numeracy1 numeracy2 numeracy3 numeracy4 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 ab1 ab2 ab3 ab4 ab5 ab6 ab7 ab8 ab9 ab10 ab11 ab12 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12, after(networkhelpkinmember)

order helpmigration, after(sourcemigrationcost)


*namelist for sn

preserve
use"NEEMSIS tracking_Append_Last.dta", clear
keep migsntechnicalhelpnamelist_1 migsntechnicalhelpnamelist_2 migsntechnicalhelpnamelist_3 migsntechnicalhelpnamelist_4 migsntechnicalhelpnamelist_5

/*
snlist	1	${migsnrecommendassoname1}
snlist	2	${migsnrecommendassoname2}
snlist	3	${migsnrecommendassoname3}
snlist	4	${migsnrecommendassoname4}
snlist	5	${migsnrecommendassoname5}
snlist	6	${migsnrecommendassoname6}
snlist	7	${migsnrecommendassoname7}
snlist	8	${migsnrecommendassoname8}
snlist	9	${migsnrecommendassoname9}
snlist	10	${migsnrecommendassoname10}
snlist	11	${migsnrecommendassoname11}
snlist	12	${migsnrecommendassoname12}
snlist	13	${migsnrecommendassoname13}
snlist	14	${migsnrecommendassoname14}
snlist	15	${migsnrecommendassoname15}
snlist	16	${migsnrecommendassoname16}
snlist	17	${migsnrecommendassoname17}
snlist	18	${migsnrecommendassoname18}
snlist	19	${migsnrecommendassoname19}
snlist	20	${migsnrecommendassoname20}
snlist	21	${migsnrecommendassoname21}
snlist	22	${migsnrecommendassoname22}
snlist	23	${migsnrecommendassoname23}
snlist	24	${migsnrecommendassoname24}
snlist	25	${migsntechnicalhelpname1}
snlist	26	${migsntechnicalhelpname2}
snlist	27	${migsntechnicalhelpname3}
snlist	28	${migsntechnicalhelpname4}
snlist	29	${migsntechnicalhelpname5}
snlist	30	${migsntechnicalhelpname6}
snlist	31	${migsntechnicalhelpname7}
snlist	32	${migsnentrustbusinessname1}
snlist	33	${migsnentrustbusinessname2}
snlist	34	${migsnentrustbusinessname3}
snlist	35	${migsnentrustbusinessname4}
snlist	36	${migsnentrustbusinessname5}
snlist	37	${migsnentrustbusinessname6}
snlist	38	${migsnentrustbusinessname7}
snlist	39	${migsnrecruitworkername1}
snlist	40	${migsnrecruitworkername2}
snlist	41	${migsnrecruitworkername3}
snlist	42	${migsnrecruitworkername4}
snlist	43	${migsnrecruitworkername5}
snlist	44	${migsnrecruitworkername6}
snlist	45	${migsnrecruitworkername7}
snlist	46	${migsnfindsuppliersname1}
snlist	47	${migsnfindsuppliersname2}
snlist	48	${migsnfindsuppliersname3}
snlist	49	${migsnfindsuppliersname4}
snlist	50	${migsnfindsuppliersname5}
snlist	51	${migsnfindsuppliersname6}
snlist	52	${migsnfindsuppliersname7}
snlist	53	${migsnlendtoolsname1}
snlist	54	${migsnlendtoolsname2}
snlist	55	${migsnlendtoolsname3}
snlist	56	${migsnlendtoolsname4}
snlist	57	${migsnlendtoolsname5}
snlist	58	${migsnlendtoolsname6}
snlist	59	${migsnlendtoolsname7}
snlist	60	${migsnfindjobname1}
snlist	61	${migsnfindjobname2}
snlist	62	${migsnfindjobname3}
snlist	63	${migsnfindjobname4}
snlist	64	${migsnfindjobname5}
snlist	65	${migsnfindjobname6}
snlist	66	${migsnfindjobname7}
snlist	67	${migsnrecommendforjobname1}
snlist	68	${migsnrecommendforjobname2}
snlist	69	${migsnrecommendforjobname3}
snlist	70	${migsnrecommendforjobname4}
snlist	71	${migsnrecommendforjobname5}
snlist	72	${migsnrecommendforjobname6}
snlist	73	${migsnrecommendforjobname7}
snlist	88	New person


*/


save"NEEMSIS-tracking_v9.dta", replace
save"CLEAN\NEEMSIS1-tracking.dta", replace
****************************************
* END







****************************************
* Occupations
****************************************
use"NEEMSIS-tracking_occupations_allwide_v4.dta", clear

drop name caste sex age everattendedschool classcompleted edulevel dummymainmigrant year profession classcompleted10ormore agetowork sector kindofwork_new occupation construction_coolie construction_regular construction_qualified dummymainoccupation

rename key HHID2019
rename indid INDID_nonmig
rename indid2 INDID_mig

save"NEEMSIS-tracking_occupations_allwide_v5.dta", replace
save"CLEAN\NEEMSIS1-tracking_occupations.dta", replace
****************************************
* END









****************************************
* SN
****************************************
use"NEEMSIS1-trackingSN_v2.dta", clear

drop use
encode snsource, gen(snsource_e)
drop snsource
rename snsource_e snsource
fre snsource

drop if namelist==.

order HHID2019 INDID_mig snsource
sort HHID2019 INDID_mig snsource alterid namelist name

save"NEEMSIS1-trackingSN_v3.dta", replace
save"CLEAN\NEEMSIS1-tracking_alters.dta", replace
****************************************
* END
