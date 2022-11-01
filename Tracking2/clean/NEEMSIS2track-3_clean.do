/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
October 6, 2022
-----
CLEANING ALL LONG FILES OF NEEMSIS2
-----
-------------------------
*/



****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
*global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\Data_Tracking2022\raw\combine"

cd"$directory"

********** Name of the NEEMSIS2 questionnaire version to clean
*global preamble "`dbv'"
global preamble "NEEMSIS2 tracking 2022"

****************************************
* END







****************************************
* Tracking main database
****************************************
use "NEEMSIS2-tracking_indiv_v1.dta", clear

********** Clean
drop setofnonmigrants setofmigrants setofoccupations setofmigrationjobidgroup setofmigoccupations setofmigmigrationjobidgroup setofmigindoccupmonths setofmigbusinesspaymentinkindgro setofmigremittancessentidgroup setofmigformalsocialcapital setofmigsnentrustbusinessid setofmigsnentrustbusinessgroup setofmigsnfindsuppliersid setofmigsnfindsuppliersgroup setofmigsnlendtoolsid setofmigmigsnlendtoolsgroup setofmigsnfindjobid setofmigsnfindjobgroup setofmigsnrecommendforjobid setofmigsnrecommendforjobgroup setofmigsnrecojobsuccessid setofmigsnrecojobsuccessgroup setofmigcontactgroup setofmigquestionnaireid setofmigsnrecommendassoid_SHG setofmigsnrecommendassoid_pancha setofmigsnrecommendassoid_polit setofmigsnrecommendassoid_pro setofmigsnrecommendassoid_relig setofindividualid setoffamilymembers setoflivestock setofdetailsgoods setofmigmigrationstep

drop _merge index

drop name1 name2 name3 name4 name5 name6 name7 name8 name9 name10 name11 name12 name13 name14 name15 familymembers_count individualid_count


********** Order
** New
order HHID2022 interviewdate interviewplacemig username otherusername householdvillageoriginal householdidoriginal migrationplacename migrationareatype migrationareaurban migrationarearural migrationaddress householdmigrantslist householdmigrantslistid householdmigrantsnb rankingmigrant othermemberhhmig migrationremark dummymigrants numfamily namenumber name sex age comefrom relationshiptohead maritalstatus casteindividual religionindividual relationshiptoheadother casteindividualother otherreligionindividual husbandspousename dummycastespouse comefromspouse dummyreligionspouse religionspouse castespouse otheroriginspouse everattendedschool classcompleted currentlyatschool educationexpenses reasonneverattendedschool reasondropping otherreasondroppingschool otherreasonneverattendedschool dummygold goldquantity dummyloan totalloanamount dummyworkedpastyear reasonnotworkpastyear dummymigration migrationjoblist migrationjobidgroup_count


** Migration
order migrationarea_brick migrationplace_brick migrationdistance_brick migrationtype_brick migrationdurationfrequency_brick migrationdurationinmonth_brick dummybacktovillage_brick migrationtravelcost_brick migrationtravelpayment_brick migrationtenure_brick migrationfindjob_brick migrationjobtype_brick migrationjobtypetwo_brick migrationwagetype_brick migrationsalary_brick migrationpension_brick migrationbonus_brick migrationinsurance_brick migrationchild_brick migrationmainoccup_brick migrationskill_brick migrationreason_brick migrationotherreason_brick migrationarea_sugar migrationplace_sugar migrationdistance_sugar migrationtype_sugar migrationdurationfrequency_sugar migrationdurationinmonth_sugar dummybacktovillage_sugar migrationtravelcost_sugar migrationtravelpayment_sugar migrationtenure_sugar migrationfindjob_sugar migrationjobtype_sugar migrationjobtypetwo_sugar migrationwagetype_sugar migrationsalary_sugar migrationpension_sugar migrationbonus_sugar migrationinsurance_sugar migrationchild_sugar migrationmainoccup_sugar migrationskill_sugar migrationreason_sugar migrationotherreason_sugar migrationarea_const migrationplace_const migrationdistance_const migrationtype_const migrationdurationfrequency_const migrationdurationinmonth_const dummybacktovillage_const migrationtravelcost_const migrationtravelpayment_const migrationtenure_const migrationfindjob_const migrationjobtype_const migrationjobtypetwo_const migrationwagetype_const migrationsalary_const migrationpension_const migrationbonus_const migrationinsurance_const migrationchild_const migrationmainoccup_const migrationskill_const migrationreason_const migrationotherreason_const migrationarea_nagri migrationplace_nagri migrationdistance_nagri migrationtype_nagri migrationdurationfrequency_nagri migrationdurationinmonth_nagri dummybacktovillage_nagri migrationtravelcost_nagri migrationtravelpayment_nagri migrationtenure_nagri migrationfindjob_nagri migrationjobtype_nagri migrationjobtypetwo_nagri migrationwagetype_nagri migrationsalary_nagri migrationpension_nagri migrationbonus_nagri migrationinsurance_nagri migrationchild_nagri migrationmainoccup_nagri migrationskill_nagri migrationreason_nagri migrationotherreason_nagri migrationarea_agri migrationplace_agri migrationdistance_agri migrationtype_agri migrationdurationfrequency_agri migrationdurationinmonth_agri dummybacktovillage_agri migrationtravelcost_agri migrationtravelpayment_agri migrationtenure_agri migrationfindjob_agri migrationjobtype_agri migrationjobtypetwo_agri migrationwagetype_agri migrationsalary_agri migrationpension_agri migrationbonus_agri migrationinsurance_agri migrationchild_agri migrationmainoccup_agri migrationskill_agri migrationreason_agri migrationotherreason_agri migrationarea_priv migrationplace_priv migrationdistance_priv migrationtype_priv migrationdurationfrequency_priv migrationdurationinmonth_priv dummybacktovillage_priv migrationtravelcost_priv migrationtravelpayment_priv migrationtenure_priv migrationfindjob_priv migrationjobtype_priv migrationjobtypetwo_priv migrationwagetype_priv migrationsalary_priv migrationpension_priv migrationbonus_priv migrationinsurance_priv migrationchild_priv migrationmainoccup_priv migrationskill_priv migrationreason_priv migrationotherreason_priv migrationarea_publi migrationplace_publi migrationdistance_publi migrationtype_publi migrationdurationfrequency_publi migrationdurationinmonth_publi dummybacktovillage_publi migrationtravelcost_publi migrationtravelpayment_publi migrationtenure_publi migrationfindjob_publi migrationjobtype_publi migrationjobtypetwo_publi migrationwagetype_publi migrationsalary_publi migrationpension_publi migrationbonus_publi migrationinsurance_publi migrationchild_publi migrationmainoccup_publi migrationskill_publi migrationreason_publi migrationotherreason_publi migrationarea_self migrationplace_self migrationdistance_self migrationtype_self migrationdurationfrequency_self migrationdurationinmonth_self dummybacktovillage_self migrationtravelcost_self migrationtravelpayment_self migrationtenure_self migrationfindjob_self migrationjobtype_self migrationjobtypetwo_self migrationwagetype_self migrationsalary_self migrationpension_self migrationbonus_self migrationinsurance_self migrationchild_self migrationmainoccup_self migrationskill_self migrationreason_self migrationotherreason_self, after(migrationjobidgroup_count)


** HH
order dummyownland ownland drywetownland sizedryownland sizewetownland sizeownland landpurchased landpurchasedacres landpurchasedamount landpurchasedhowbuy livestocklist livestock_count livestocknb_cows livestockprice_cows livestocknb_goats livestockprice_goats livestocknb_chicken livestockprice_chicken livestocktotalamount foodexpenses healthexpenses ceremoniesexpenses ceremoniesrelativesexpenses deathexpenses listgoods numbergoods_car goodsamount_car numbergoods_bike goodsamount_bike numbergoods_fridge goodsamount_fridge numbergoods_furniture goodsamount_furniture numbergoods_cellphone goodsamount_cellphone numbergoods_cookinggas goodsamount_cookinggas numbergoods_computer goodsamount_computer numbergoods_dishantenna goodsamount_dishantenna numbergoods_none goodsamount_none othergood detailsgoods_count house rentalhouse housevalue housetype housesize housetitle ownotherhouse otherhouserent otherhousevalue electricity water toiletfacility noowntoilet schemeslist, after(migrationotherreason_self)


** Ego
order migstepmigration migstepmigrationdetails marriagedate caste religion casteother religionother canread after10thstandard durationafter10th typeofhigheredu subjectsafter10th othersubjectsafter10th amountschoolfees bookscost transportcost otherreasonneverattendedschoo dummyscholarship scholarshipamount scholarshipduration converseinenglish reasonnotworkpastyearother stoppedworking workpastsixmonth everworksalaried kindofworkinactive, after(schemeslist)


** Remittances sent
order dummyremittancessent compulsoryremittances remsentname1 remsentdummyvillage1 remsentrelation1 remsentoccup1 remsentplace1 remsentfrequency1 remsentamount1 remsenttotalamount1 remsentservices1 remsentsourceoccupoth1 remsentservicesother1, after(kindofworkinactive)


** Remittances received
order dummyremittancesreceived remrecipientsourcenam1 remreceivedsourcedumm1 remreceivedsourcerela1 remreceivedsourcehh1 remreceivedsourceoccu1 remreceivedsourceplac1 remreceivedfrequency1 remreceivedamount1 remreceivedtotalamoun1 remreceivedservices1 remreceivedsourceoccupother1 remreceivedservicesot1 remrecipientsourcenam2 remreceivedsourcedumm2 remreceivedsourcerela2 remreceivedsourcehh2 remreceivedsourceoccu2 remreceivedsourceplac2 remreceivedfrequency2 remreceivedamount2 remreceivedtotalamoun2 remreceivedservices2 remreceivedsourceoccupother2 remreceivedservicesot2, after(remsentservicesother1)


** Ego job
order everwork workpastsevendays searchjob startbusiness reasondontsearchjob searchjobsince15 businessafter15 reasondontsearchjobsince15 nbermonthsearchjob readystartjob methodfindjob jobpreference moveoutsideforjob moveoutsideforjobreason aspirationminimumwage dummyaspirationmorehours reasondontworkmore aspirationminimumwage2 kindofworkfirstjob unpaidinbusinessfirstjob agestartworking agestartworkingpaidjob methodfindfirstjob othermethodfindfirstjob monthstofindjob  dummymainoccupation2 othermainoccupation2 maxhoursayear selected_occupposition selected_occupname occupation1 occupation2 occupation3 occupation4 occupation5 occupation6 occupation7 occupation8 nbofoccupations mainoccupation dummyseasonalmainoccup selected_months selected_months_1 selected_months_2 selected_months_3 selected_months_4 selected_months_5 selected_months_6 selected_months_7 selected_months_8 selected_months_9 selected_months_10 selected_months_11 selected_months_12 indoccupmonths_count inddaysayear2 indhoursaday2 indhoursayear1 indhoursayear2 indhoursayear beforemainoccup otherbeforemainoccup mainoccuptype mainoccuptype2 dummypreviouswagejob previousjobcontract reasonstoppedwagejob otherreasonstoppedjob businessnbworkers dummybusinessunpaidworkers businessnbunpaidworkers businessnbfamilyworkers dummybusinesspaidworkers businessnbpaidworkers businessworkersfrequencypayme businesslaborcost frequencygrossreceipt amountgrossreceipt businessfixedcosts businessfixedcostsamount businessexpenses businesssocialsecurity businesspaymentinkind businesspaymentinkindlist businesspaymentinkindgroup_co, after(remreceivedservicesot2)

rename migwagejobemployer wagejobemployer

order wagejobemployer otherwagejobemployer wagejobnbworkers contract wagejobtype wagejobsocialsecurity dummysalary jobwagefrequencycash jobwageamountcash wagejobpaymentinkind wagejobpaymentinkindlist wagejobpaymentinkindvalue_clot wagejobpaymentinkindvalue_food wagejobpaymentinkindvalue_tran wagejobpaymentinkindgroup_cou , after(businesspaymentinkindgroup_co)


order respect workmate useknowledgeatwork satisfactionprogress satisfyingpurpose schedule takeholiday agreementatwork1 agreementatwork2 agreementatwork3 agreementatwork4 changework happywork satisfactionsalary executionwork1 executionwork2 executionwork3 executionwork4 executionwork5 executionwork6 executionwork7 executionwork8 executionwork9 executionwork10 accidentalinjury losswork lossworknumber mostseriousincident mostseriousinjury seriousinjuryother physicalharm problemwork1 problemwork2 problemwork3 problemwork4 problemwork5 problemwork6 problemwork7 problemwork8 problemwork9 workexposure1 workexposure2 workexposure3 workexposure4 workexposure5 hearworker professionalequipment break retirementwork verbalaggression physicalagression sexualharassment sexualaggression discrimination1 discrimination2 discrimination3 discrimination4 discrimination5 discrimination6 discrimination7 discrimination8 discrimination9 resdiscrimination1 resdiscrimination2 resdiscrimination3 resdiscrimination4 resdiscrimination5 rurallocation lackskill decisionwork decisionearnwork opinionworkingwoman opinionactivewoman decisionworkother associationlist, after(wagejobpaymentinkindgroup_cou)

order associationtype_SHG associationname_SHG assodegreeparticip_SHG assosize_SHG dummyassorecommendation_SHG dummyassohelpjob_SHG assohelpjob_SHG assocotherhelpjob_SHG dummyassohelpbusiness_SHG assohelpbusiness_SHG assootherhelpbusiness_SHG associationtype_pancha associationname_pancha assodegreeparticip_pancha assosize_pancha dummyassorecommendation_pancha dummyassohelpjob_pancha assohelpjob_pancha assocotherhelpjob_pancha dummyassohelpbusiness_pancha assohelpbusiness_pancha assootherhelpbusiness_pancha associationtype_polit associationname_polit assodegreeparticip_polit assosize_polit dummyassorecommendation_polit dummyassohelpjob_polit assohelpjob_polit assocotherhelpjob_polit dummyassohelpbusiness_polit assohelpbusiness_polit assootherhelpbusiness_polit associationtype_pro associationname_pro assodegreeparticip_pro assosize_pro dummyassorecommendation_pro dummyassohelpjob_pro assohelpjob_pro assocotherhelpjob_pro dummyassohelpbusiness_pro assohelpbusiness_pro assootherhelpbusiness_pro associationtype_relig associationname_relig assodegreeparticip_relig assosize_relig dummyassorecommendation_relig dummyassohelpjob_relig assohelpjob_relig assocotherhelpjob_relig dummyassohelpbusiness_relig assohelpbusiness_relig assootherhelpbusiness_relig, after(associationlist)

order snrecommendassoname1 snrecommendassoname2 snrecommendassoname3 snrecommendassoname4 snrecommendassoname5 snrecommendassoname6 snrecommendassoname7 snrecommendassoname8 snrecommendassoname9 snrecommendassoname10 snrecommendassoname11 snrecommendassoname12 snrecommendassoname13 snrecommendassoname14 snrecommendassoname15 snrecommendassoname16 snrecommendassoname17 snrecommendassoname18 snrecommendassoname19 snrecommendassoname20 snrecommendassoname21 snrecommendassoname22 snrecommendassoname23 snrecommendassoname24 sntechnicalhelp sntechnicalhelpnamelist sntechnicalhelpname1 sntechnicalhelpname2 sntechnicalhelpname3 sntechnicalhelpname4 sntechnicalhelpname5 sntechnicalhelpname6 sntechnicalhelpname7 sntechnicalhelpgroup_count snentrustbusiness snentrustbusinessnamelist snentrustbusinessname1 snentrustbusinessname2 snentrustbusinessname3 snentrustbusinessname4 snentrustbusinessname5 snentrustbusinessname6 snentrustbusinessname7 snentrustbusinessgroup_count snrecruitworker snrecruitworkernamelist snrecruitworkername1 snrecruitworkername2 snrecruitworkername3 snrecruitworkername4 snrecruitworkername5 snrecruitworkername6 snrecruitworkername7 snrecruitworkergroup_count snfindsuppliers snfindsuppliersnamelist snfindsuppliersname1 snfindsuppliersname2 snfindsuppliersname3 snfindsuppliersname4 snfindsuppliersname5 snfindsuppliersname6 snfindsuppliersname7 snfindsuppliersgroup_count snlendtools snlendtoolsnamelist snlendtoolsname1 snlendtoolsname2 snlendtoolsname3 snlendtoolsname4 snlendtoolsname5 snlendtoolsname6 snlendtoolsname7 migsnlendtoolsgroup_count snfindjob snfindjobnamelist snfindjobname1 snfindjobname2 snfindjobname3 snfindjobname4 snfindjobname5 snfindjobname6 snfindjobname7 snfindjobgroup_count snrecommendforjob snrecommendforjobnamelist snrecommendforjobname1 snrecommendforjobname2 snrecommendforjobname3 snrecommendforjobname4 snrecommendforjobname5 snrecommendforjobname6 snrecommendforjobname7 snrecommendforjobgroup_count snrecojobsuccess snrecojobsuccessnamelist snrecojobsuccessname1 snrecojobsuccessname2 snrecojobsuccessname3 snrecojobsuccessname4 snrecojobsuccessname5 snrecojobsuccessname6 snrecojobsuccessname7 snrecojobsuccessgroup_count, after(assootherhelpbusiness_relig)

order nbercontactphone nberpersonfamilyevent contactlist contactlist_1 contactlist_2 contactlist_3 contactlist_4 contactlist_5 contactlist_6 contactlist_7 contactlist_8 contactlist_9 contactgroup_count contactnumber_headbusi contactnumber_police contactnumber_civilservant contactnumber_bankemployee contactnumber_panchayat contactnumber_council contactnumber_recruiter contactnumber_trade dummycontactleaders contactleaders networktrustneighborhood networktrustemployees networkpeoplehelping networkhelpkinmember, after(snrecojobsuccessgroup_count)

order enjoypeople curious organized managestress interestedbyart tryhard workwithother makeplans sharefeelings nervous stickwithgoals repetitivetasks shywithpeople workhard changemood understandotherfeeling inventive enthusiastic feeldepressed appointmentontime trustingofother goaftergoal easilyupset talktomanypeople liketothink finishwhatbegin putoffduties rudetoother finishtasks toleratefaults worryalot easilydistracted keepworking completeduties talkative newideas staycalm forgiveother activeimagination expressingthoughts helpfulwithothers locuscontrol1 locuscontrol2 locuscontrol3 locuscontrol4 locuscontrol5 locuscontrol6 canreadcard1a canreadcard1b canreadcard1c canreadcard2 numeracy1 numeracy2 numeracy3 numeracy4 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 ab1 ab2 ab3 ab4 ab5 ab6 ab7 ab8 ab9 ab10 ab11 ab12 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12, after(networkhelpkinmember)


drop migrationjobidgroup_count livestock_count detailsgoods_count indoccupmonths_count businesspaymentinkindgroup_co wagejobpaymentinkindgroup_cou sntechnicalhelpgroup_count snentrustbusinessgroup_count snrecruitworkergroup_count snfindsuppliersgroup_count migsnlendtoolsgroup_count snfindjobgroup_count snrecommendforjobgroup_count snrecojobsuccessgroup_count contactgroup_count formalsocialcapital_count migquestionnaireid_count


********** Caste
bysort HHID2022: egen min_caste=min(caste)
bysort HHID2022: egen max_caste=max(caste)
gen test=min_caste-max_caste
ta test
replace min_caste=. if test!=0
rename min_caste caste2
codebook caste
label values caste2 migcaste 
drop max_caste
order caste2, after(caste)
*replace caste=caste2 if caste2!=. & caste==.

fre caste
sort HHID2022 namenumber
*br HHID2022 namenumber rankingmigrant name age sex relationshiptohead caste caste2

*I replace the relationshiptohead mother to son, parait plus logique
replace relationshiptohead=5 if HHID2022=="uuid:37823aac-d6df-4312-b65c-5b5de5e4d9db" & name=="Veerasekar"

*Caste of father <- the son
replace caste=2 if HHID2022=="uuid:37823aac-d6df-4312-b65c-5b5de5e4d9db" & name=="Pradiksha"
replace caste=2 if HHID2022=="uuid:37823aac-d6df-4312-b65c-5b5de5e4d9db" & name=="Pranav Kumar"

replace caste=caste2 if caste==.
fre caste
drop caste2
drop test



********** religion
bysort HHID2022: egen min_religion=min(religion)
bysort HHID2022: egen max_religion=max(religion)
gen test=min_religion-max_religion
ta test
replace min_religion=. if test!=0
rename min_religion religion2
codebook religion
label values religion2 migreligion 
drop max_religion
order religion2, after(religion)
replace religion=religion2 if religion==.
fre religion
fre religion2
drop religion2



save"CLEAN\NEEMSIS2-tracking.dta", replace
****************************************
* END







****************************************
* Tracking occupations database
****************************************
use "NEEMSIS2-tracking_occupations_v1.dta", clear


********** Clean
order HHID2022
drop setof*
drop businesssourceinvestgroup_cou businesslabourers_count

order HHID2022 occupationid occupationname kindofwork kindofwork2 monthsayear daysamonth hoursaday hoursayear annualincome datestartoccup yearestablishment businesscastebased businessskill businessamountinvest businesslossinvest businessskillother businesslossinvestamount businesssourceinvest otherbusinesssourceinvestment numberbusinessloan_loan numberbusinessloan_capital, first

order dummybusinesslabourers nbbusinesslabourers namebusinesslabourer1 dummybusinesslabourerhhmember1 addressbusinesslabourer1 relationshipbusinesslabourer1 castebusinesslabourer1 businesslabourertypejob1 businesslabourerwagetype1 businesslabourerbonus1 businesslabourerinsurance1 businesslabourerpension1 businesslabourerdate1 namebusinesslabourer2 dummybusinesslabourerhhmember2 addressbusinesslabourer2 relationshipbusinesslabourer2 castebusinesslabourer2 businesslabourertypejob2 businesslabourerwagetype2 businesslabourerbonus2 businesslabourerinsurance2 businesslabourerpension2 businesslabourerdate2, after(numberbusinessloan_capital)

drop parent_key keep_occupposition

order joblocation jobdistance joblocationname typewageemployer relationemployer casteemployer othercasteemployer salariedjobtype salariedwagetype salariedjobbonus salariedjobinsurance salariedjobpension salariedcontract salariedjobtenure salariedjobkindbonus salariedjobbonusamount migrationadvanceamount migrationadvanceprovider migrationadvancefeel dummyadvancebalance advanceamountbalance advancebalanceproblem advancebalanceperception advancebalanceperceptionopen advancebalanceproblemother, after(businesslabourerdate2)


save"CLEAN\NEEMSIS2-tracking_occupations.dta", replace
****************************************
* END








****************************************
* Tracking mig path database
****************************************
use "NEEMSIS2-tracking_migpath_v1.dta", clear

********** Clean
drop migrationstepnumber


********** Order
order HHID2022 


save"CLEAN\NEEMSIS2-tracking_migpath.dta", replace
****************************************
* END







****************************************
* Tracking alter database
****************************************
use "NEEMSIS2-tracking_alter_v1", clear

********** Clean
drop othercaste otheroccup othermeet

fre reciprocity reciprocity1
replace reciprocity=reciprocity1 if reciprocity==. & reciprocity1!=.
drop reciprocity


********** Order
sort HHID2022 snsource alterid name
order HHID2022 snsource alterid name sex age caste casteother occup occupother occupname relationship educ living compared duration meet meetother frequency invite reciprocity intimacy relationship



********** Label
destring findjobhow, replace
label define findjobhow 1"Recommendation" 2 "Hiring" 3 "Share of network" 4"Help you to find out job opportunities" 77 "Other"
label values findjobhow findjobhow


save"CLEAN\NEEMSIS2-tracking_alter", replace
****************************************
* END
