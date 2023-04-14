*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 14, 2023
*-----
*NEEMSIS-2 survey report individual
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\2020-NEEMSIS2\Materials\SurveyReport\analysis"
cd"$directory"
********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid
********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020
*-------------------------









log using "1e_Employment.log", nomsg replace
****************************************
* 1. Employment
****************************************
use"NEEMSIS1-ego", clear

tabulate workedpastyear
tabulate everwork
tabulate workpastsevendays
tabulate searchjob
tabulate startbusiness
tabulate reasondontsearchjob_stud
tabulate reasondontsearchjob_hodu
tabulate reasondontsearchjob_reti
tabulate reasondontsearchjob_olda
tabulate reasondontsearchjob_ill
tabulate reasondontsearchjob_disa
tabulate reasondontsearchjob_mili
tabulate reasondontsearchjob_nowa
tabulate reasondontsearchjob_alre
tabulate reasondontsearchjob_resp
tabulate reasondontsearchjob_reca
tabulate reasondontsearchjob_busy
tabulate reasondontsearchjob_chan
tabulate reasondontsearchjob_nojo
tabulate searchjobsince15
tabulate businessafter15
tabulate reasondontsearchjobsince15_stud
tabulate reasondontsearchjobsince15_hodu
tabulate reasondontsearchjobsince15_reti
tabulate reasondontsearchjobsince15_olda
tabulate reasondontsearchjobsince15_ill
tabulate reasondontsearchjobsince15_disa
tabulate reasondontsearchjobsince15_mili
tabulate reasondontsearchjobsince15_nowa
tabulate reasondontsearchjobsince15_alre
tabulate reasondontsearchjobsince15_resp
tabulate reasondontsearchjobsince15_reca
tabulate reasondontsearchjobsince15_busy
tabulate reasondontsearchjobsince15_chan
tabulate reasondontsearchjobsince15_nojo
tabulate reasondontsearchjobsince15_lowp
tabulate nbermonthsearchjob



********** 1.1. Job aspiration
tabulate readystartjob
tabulate methodfindjob_snfrie
tabulate methodfindjob_snrela
tabulate methodfindjob_snothe
tabulate methodfindjob_empdir
tabulate methodfindjob_pubage
tabulate methodfindjob_priage
tabulate methodfindjob_univer
tabulate methodfindjob_media
tabulate methodfindjob_intern
tabulate methodfindjob_na
tabulate methodfindjob_nr
tabulate jobpreference
tabulate moveoutsideforjob
tabulate moveoutsideforjobreason
summarize aspirationminimumwage if aspirationminimumwage!=66 & aspirationminimumwage!=88 & aspirationminimumwage!=99



********** 1.2. First job
tabulate kindofworkfirstjob
tabulate unpaidinbusinessfirstjob
summarize agestartworking agestartworkingpaidjob
tabulate methodfindfirstjob_snfrie
tabulate methodfindfirstjob_snrela
tabulate methodfindfirstjob_snothe
tabulate methodfindfirstjob_empdir
tabulate methodfindfirstjob_pubage
tabulate methodfindfirstjob_priage
tabulate methodfindfirstjob_univer
tabulate methodfindfirstjob_media
tabulate methodfindfirstjob_intern
tabulate methodfindfirstjob_na
tabulate methodfindfirstjob_nr
summarize monthstofindjob



********** 1.3. Main occupation
tabulate kindofwork_ego
tabulate dummyregularmainoccup
tabulate selected_months
summarize inddaysayear2 indhoursaday2 indhoursayear1_ego indhoursayear2_ego indhoursayear_ego
tabulate beforemainoccup
tabulate otherbeforemainoccup
tabulate mainoccuptype
tabulate dummypreviouswagejob
tabulate previousjobcontract
tabulate reasonstoppedwagejob_fired
tabulate reasonstoppedwagejob_endco
tabulate reasonstoppedwagejob_buclo
tabulate reasonstoppedwagejob_reduc
tabulate reasonstoppedwagejob_lowwa
tabulate reasonstoppedwagejob_retir
tabulate reasonstoppedwagejob_pregn
tabulate reasonstoppedwagejob_healt
tabulate reasonstoppedwagejob_famil
tabulate reasonstoppedwagejob_moved
tabulate reasonstoppedwagejob_educa
tabulate reasonstoppedwagejob_selfe
tabulate reasonstoppedwagejob_other
tabulate otherreasonstoppedjob
summarize businessnbworkers
tabulate dummybusinessunpaidworkers
summarize businessnbunpaidworkers businessnbfamilyworkers 
tabulate dummybusinesspaidworkers
summarize businessnbpaidworkers
tabulate businessworkersfreqpayment
summarize businesslaborcost
tabulate frequencygrossreceipt
summarize amountgrossreceipt businessfixedcosts businessfixedcostsamount businessexpenses
tabulate businesssocialsecurity
tabulate businesspaymentinkind
tabulate businesspaymentinkindlist_clo
tabulate businesspaymentinkindlist_foo
tabulate businesspaymentinkindlist_tra
tabulate businesspaymentinkindlist_acc
tabulate businesspaymentinkindlist_lab
tabulate businesspaymentinkindlist_oth
summarize businesspaymentkindvalue_clothes businesspaymentkindvalue_transp businesspaymentkindvalue_food
tabulate wagejobemployer
summarize wagejobnbworkers
tabulate contract
tabulate wagejobtype
tabulate wagejobsocialsecurity
tabulate dummysalary
tabulate jobwagefrequencycash
summarize jobwageamountcash
tabulate wagejobpaymentinkind
tabulate wagejobpaymentinkindlist_clo
tabulate wagejobpaymentinkindlist_foo
tabulate wagejobpaymentinkindlist_tra
tabulate wagejobpaymentinkindlist_acc
tabulate wagejobpaymentinkindlist_lab
tabulate wagejobpaymentinkindlist_oth
summarize wagejobpaymentkindvalue_clothes wagejobpaymentkindvalue_food wagejobpaymentkindvalue_transp wagejobpaymentkindvalue_accom 
tabulate dummyaspirationmorehours
tabulate reasondontworkmore
summarize aspirationminimumwage2

****************************************
* END
log close


















log using "2-1e_FormalSN.log", nomsg replace
****************************************
* 2.1. Formal social networks
****************************************
use"NEEMSIS1-ego", clear

* Tables
tabulate associationlist_yout
tabulate associationlist_shg
tabulate associationlist_trad
tabulate associationlist_farm
tabulate associationlist_panc
tabulate associationlist_poli
tabulate associationlist_prof
tabulate associationlist_mark
tabulate associationlist_reli
tabulate associationlist_hobb
tabulate associationlist_alum
tabulate associationlist_othe
tabulate associationlist_none

* Selection
keep HHID2016 INDID2016 associationid* associationname* assodegreeparticip* assosize* dummyassorecommendation* dummyassohelpjob* dummyassohelpbusiness*
reshape long associationid associationname assodegreeparticip assosize dummyassorecommendation dummyassohelpjob dummyassohelpbusiness, i(HHID2016 INDID2016) j(n)
drop if associationid==.

* Table
tabulate associationid
tabulate assodegreeparticip
tabulate assosize
tabulate dummyassorecommendation
tabulate dummyassohelpbusiness
tabulate dummyassohelpjob

****************************************
* END
log close











log using "2-3e_SizeSN.log", nomsg replace
****************************************
* 2.3. Size of network
****************************************
use"NEEMSIS1-ego", clear

tabulate nbercontactphone
summarize nberpersonfamilyevent

****************************************
* END
log close













log using "2-4e_RessourcesSN.log", nomsg replace
****************************************
* 2.4. Ressources network
****************************************
use"NEEMSIS1-ego", clear

tabulate contactlist_busi
tabulate contactlist_poli
tabulate contactlist_civi
tabulate contactlist_bank
tabulate contactlist_panc
tabulate contactlist_coun
tabulate contactlist_recr
tabulate contactlist_trad
tabulate contactlist_none
summarize nbcontact_headbusiness nbcontact_policeman nbcontact_civilserv nbcontact_bankemployee nbcontact_panchayatcommittee nbcontact_peoplecouncil nbcontact_recruiter nbcontact_headunion
tabulate dummycontactleaders
tabulate contactleaders

****************************************
* END
log close






















log using "2-5e_PerceptionSN.log", nomsg replace
****************************************
* 2.5. Perception of the network
****************************************
use"NEEMSIS1-ego", clear

tabulate trustneighborhood
tabulate demotrustneighborhood
tabulate trustemployees
tabulate demotrustemployees
tabulate networkpeoplehelping
tabulate demonetworkpeoplehelping
tabulate networkhelpkinmember
tabulate demonetworkhelpkinmember
tabulate demotrustbank

****************************************
* END
log close









log using "3e_Personality.log", nomsg replace
****************************************
* 3. Personality and behaviour
****************************************
use"NEEMSIS1-ego", clear

tabulate enjoypeople
tabulate curious
tabulate organized
tabulate managestress
tabulate interestedbyart
tabulate tryhard
tabulate workwithother
tabulate makeplans
tabulate sharefeelings
tabulate nervous
tabulate stickwithgoals
tabulate repetitivetasks
tabulate shywithpeople
tabulate workhard
tabulate changemood
tabulate understandotherfeeling
tabulate inventive
tabulate enthusiastic
tabulate feeldepressed
tabulate appointmentontime
tabulate trustingofother
tabulate goaftergoal
tabulate easilyupset
tabulate talktomanypeople
tabulate liketothink
tabulate finishwhatbegin
tabulate putoffduties
tabulate rudetoother
tabulate finishtasks
tabulate toleratefaults
tabulate worryalot
tabulate easilydistracted
tabulate keepworking
tabulate completeduties
tabulate talkative
tabulate newideas
tabulate staycalm
tabulate forgiveother
tabulate activeimagination
tabulate expressingthoughts
tabulate helpfulwithothers

****************************************
* END
log close
















log using "4e_Skills.log", nomsg replace
****************************************
* 4. Literacy and numeracy
****************************************
use"NEEMSIS1-ego", clear


********** Literacy
tabulate canreadcard1a
tabulate canreadcard1b
tabulate canreadcard1c
tabulate canreadcard2



********** Numeracy
tabulate numeracy1
tabulate numeracy2
tabulate numeracy3
tabulate numeracy4

****************************************
* END
log close

















log using "5e_Raven.log", nomsg replace
****************************************
* 5. Raven tests
****************************************
use"NEEMSIS1-ego", clear


********** Set A
tabulate a1
tabulate a2
tabulate a3
tabulate a4
tabulate a5
tabulate a6
tabulate a7
tabulate a8
tabulate a9
tabulate a10
tabulate a11
tabulate a12



********** Set Ab
tabulate ab1
tabulate ab2
tabulate ab3
tabulate ab4
tabulate ab5
tabulate ab6
tabulate ab7
tabulate ab8
tabulate ab9
tabulate ab10
tabulate ab11
tabulate ab12



********** Set B
tabulate b1
tabulate b2
tabulate b3
tabulate b4
tabulate b5
tabulate b6
tabulate b7
tabulate b8
tabulate b9
tabulate b10
tabulate b11
tabulate b12

****************************************
* END
log close















log using "6e_Demo.log", nomsg replace
****************************************
* 6. General effects of demonetisation
****************************************
use"NEEMSIS1-ego", clear

* Tables
tabulate demogeneralperception_bad
tabulate demogeneralperception_pba
tabulate demogeneralperception_neu
tabulate demogeneralperception_pgo
tabulate demogeneralperception_goo
tabulate demogeneralperception_dk
tabulate demogeneralperception_nr

tabulate demogoodexpectations_noch
tabulate demogoodexpectations_less
tabulate demogoodexpectations_safe
tabulate demogoodexpectations_bank
tabulate demogoodexpectations_easi
tabulate demogoodexpectations_hidd
tabulate demogoodexpectations_form
tabulate demogoodexpectations_gift
tabulate demogoodexpectations_othe
tabulate demogoodexpectations_dk
tabulate demogoodexpectations_nr

tabulate demobadexpectations_noch
tabulate demobadexpectations_taxc
tabulate demobadexpectations_blac
tabulate demobadexpectations_loan
tabulate demobadexpectations_cost
tabulate demobadexpectations_jobo
tabulate demobadexpectations_inco
tabulate demobadexpectations_sche
tabulate demobadexpectations_othe
tabulate demobadexpectations_dk
tabulate demobadexpectations_nr

****************************************
* END
log close













log using "7e_Alters.log", nomsg replace
****************************************
* 7. Alters
****************************************
use"NEEMSIS1-alters", clear

* Tables
tabulate networkpurpose1
tabulate networkpurpose2
tabulate networkpurpose3
tabulate networkpurpose4
tabulate networkpurpose5
tabulate associationid
tabulate relationship
tabulate education
tabulate occupation
tabulate occupother
tabulate place
tabulate ecocondition
tabulate durationknown
tabulate howmet
tabulate howmetother
tabulate meetfrequency
tabulate egoinvite
tabulate alterinvite
tabulate intimacy

****************************************
* END
log close





