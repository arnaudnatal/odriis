*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 11, 2023
*-----
*NEEMSIS-1 survey report
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-1"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\2016-NEEMSIS1\Materials\SurveyReport2\analysis"
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









log using "0_Introduction.log", nomsg replace
****************************************
* 0. Introduction
****************************************
use"NEEMSIS1-HH", clear

* Selection
keep HHID2016 villageid villagearea jatis religion comefrom otherorigin 
duplicates drop

* Tables
tabulate villageid
tabulate villagearea
tabulate jatis
tabulate religion
tabulate comefrom
tabulate otherorigin

****************************************
* END
log close












log using "1-1_Householdmember.log", nomsg replace
****************************************
* 1.1. Household member module
****************************************
use"NEEMSIS1-HH", clear

* Tables
tabulate sex
summarize age
tabulate relationshiptohead
tabulate maritalstatus
tabulate livinghome
tabulate lefthomedurationlessoneyear
tabulate lefthomedurationmoreoneyear
tabulate lefthomedestination
tabulate lefthomereason
tabulate dummypermanentmigrantwork

****************************************
* END
log close









log using "2_Education.log", nomsg replace
****************************************
* 2. Education
****************************************
use"NEEMSIS1-HH", clear

* Selection
drop if age<=5
drop if livinghome==4

* Tables
tabulate canread
tabulate everattendedschool
tabulate classcompleted
tabulate after10thstandard
tabulate durationafter10th
tabulate typeofhigheredu
tabulate subjectsafter10th
tabulate othersubjectsafter10th
tabulate currentlyatschool
summarize educationexpenses amountschoolfees bookscost transportcost
tabulate reasonneverattendedschool_fail
tabulate reasonneverattendedschool_inac
tabulate reasonneverattendedschool_qual 
tabulate reasonneverattendedschool_fina
tabulate reasonneverattendedschool_heal
tabulate reasonneverattendedschool_noin
tabulate reasonneverattendedschool_care
tabulate reasonneverattendedschool_work
tabulate reasonneverattendedschool_girl
tabulate reasonneverattendedschool_marr
tabulate reasonneverattendedschool_noal
tabulate reasonneverattendedschool_pube
tabulate reasonneverattendedschool_baby
tabulate reasondropping_stop
tabulate reasondropping_fail
tabulate reasondropping_inac
tabulate reasondropping_qual
tabulate reasondropping_fina
tabulate reasondropping_heal
tabulate reasondropping_noin
tabulate reasondropping_care
tabulate reasondropping_work
tabulate reasondropping_girl
tabulate reasondropping_marr
tabulate reasondropping_noal
tabulate reasondropping_pube
tabulate reasondropping_baby
tabulate otherreasondroppingschool
tabulate dummyscholarship
summarize scholarshipamount scholarshipduration
tabulate converseinenglish

****************************************
* END
log close












log using "3_Employment.log", nomsg replace
****************************************
* 3. Employment
****************************************

********** Workers
use"NEEMSIS1-HH", clear

* Selection
drop if livinghome==3
drop if livinghome==4
drop if age<=10

* Tables
tabulate dummyworkedpastyear



********** Non-workers
use"NEEMSIS1-HH", clear

* Selection
drop if livinghome==3
drop if livinghome==4
drop if age<=10

* Tables
tabulate reasonnotworkpastyear
tabulate stoppedworking



********** Occupations
use"NEEMSIS1-occupations", clear

* Selection
drop if occupationid==.

* Tables
tabulate kindofwork
summarize monthsayear if monthsayear!=66
summarize daysamonth if daysamonth!=66
summarize hoursaday if hoursaday!=66
summarize hoursayear if hoursayear!=66
summarize annualincome
tabulate datestartoccup
tabulate demooccup

****************************************
* END
log close











log using "3-1-1_Selfemployment.log", nomsg replace
****************************************
* 3.1.1. Self-employment details
* 3.1.2. Self-employment investment details
****************************************
use"NEEMSIS1-occupations", clear

********** Details
* Selection
drop if occupationid==.
keep if kindofwork==2

* Tables
summarize yearestablishment
tabulate businesscastebased
tabulate businessskill_fami
tabulate businessskill_frie
tabulate businessskill_scho
tabulate businessskill_expe
summarize businessamountinvest
tabulate businesslossinvest
summarize businesslossinvestamount demobusinessloss
tabulate businesssourceinvest_rela
tabulate businesssourceinvest_bank
tabulate businesssourceinvest_info
tabulate businesssourceinvest_savi
tabulate businesssourceinvest_inhe
tabulate businesssourceinvest_prof
tabulate businesssourceinvest_inbu
tabulate businesssourceinvest_none
tabulate businesssourceinvest_othe
tabulate otherbusinesssourceinvestment
tabulate demobusinessactivity_lesin
tabulate demobusinessactivity_cainp
tabulate demobusinessactivity_difse
tabulate demobusinessactivity_caspa
tabulate demobusinessactivity_paymo
tabulate demobusinessactivity_frequ
tabulate demobusinessactivity_press
tabulate demobusinessactivity_contr
tabulate demobusinessactivity_other
tabulate demobusinessactivityother
tabulate demobusinesskindofjob



********** Investment
* Selection
keep HHID2016 INDID2016 occupationid namebusinesslender* addressbusinesslender* businesslender* castebusinesslender* occupbusinesslender*
reshape long namebusinesslender addressbusinesslender businesslender castebusinesslender occupbusinesslender, i(HHID2016 INDID2016 occupationid) j(n)

* Tables
tabulate namebusinesslender
tabulate businesslender
tabulate castebusinesslender
tabulate occupbusinesslender

****************************************
* END
log close











log using "3-1-3_Businesslabourer.log", nomsg replace
****************************************
* 3.1.3. Self-employment business labourers
****************************************
use"NEEMSIS1-occupations", clear

* Selection
drop if occupationid==.
keep if kindofwork==2

* Tables
tabulate dummybusinesslabourers
summarize nbbusinesslabourers
tabulate demobusiness

********** Details
* Selection
keep HHID2016 INDID2016 occupationid namebusinesslabourer* dummyhhmember* addressbusinesslabourer* relationshipbusinesslabourer* castebusinesslabourer* businesslabourerdate* businesslabourertypejob* businesslabourerwagetype* businesslabourerbonus* businesslabourerinsurance* businesslabourerpension*

reshape long namebusinesslabourer dummyhhmember addressbusinesslabourer relationshipbusinesslabourer castebusinesslabourer businesslabourerdate businesslabourertypejob businesslabourerwagetype businesslabourerbonus businesslabourerinsurance businesslabourerpension, i(HHID2016 INDID2016 occupationid) j(n)
drop if namebusinesslabourer==""


* Tables
tabulate dummyhhmember
tabulate relationshipbusinesslabourer
tabulate castebusinesslabourer
tabulate businesslabourertypejob
tabulate businesslabourerwagetype
tabulate businesslabourerbonus
tabulate businesslabourerinsurance
tabulate businesslabourerpension

****************************************
* END
log close

















log using "3-2_Salariedjob.log", nomsg replace
****************************************
* 3.1.3. Self-employment business labourers
****************************************
use"NEEMSIS1-occupations", clear

* Selection
drop if occupationid==.
drop if kindofwork==1
drop if kindofwork==2

* Tables
tabulate joblocation
summarize jobdistance
tabulate relationemployer_labo
tabulate relationemployer_rela
tabulate relationemployer_poli
tabulate relationemployer_reli
tabulate relationemployer_neig
tabulate relationemployer_shg
tabulate relationemployer_busi
tabulate relationemployer_wkp
tabulate relationemployer_trad
tabulate relationemployer_frie
tabulate relationemployer_gfin
tabulate relationemployer_na
tabulate relationemployer_nr
tabulate casteemployer_vanni
tabulate casteemployer_sc
tabulate casteemployer_arunt
tabulate casteemployer_rediy
tabulate casteemployer_grama
tabulate casteemployer_naidu
tabulate casteemployer_navit
tabulate casteemployer_asara
tabulate casteemployer_settu
tabulate casteemployer_natta
tabulate casteemployer_mudal
tabulate casteemployer_kulal
tabulate casteemployer_chett
tabulate casteemployer_marwa
tabulate casteemployer_musli
tabulate casteemployer_paday
tabulate casteemployer_na
tabulate casteemployer_other
tabulate othercasteemployer
tabulate salariedjobtype
tabulate demojobtype
tabulate salariedjobtype2
tabulate effetdemowage
tabulate salariedwagetype
tabulate demowagetype
tabulate salariedjobbonus
tabulate salariedjobinsurance
tabulate salariedjobpension
summarize salariedjobtenure
tabulate salariedjobkindbonus
summarize salariedjobbonusamount
tabulate demosalariedjob
tabulate demosalariedjobother

****************************************
* END
log close

















log using "4_Migration.log", nomsg replace
****************************************
* 4. Migration
****************************************

********** Household
* Selection
use"NEEMSIS1-HH", clear
keep HHID2016 dummymigration
duplicates drop

* Tables
tabulate dummymigration



********** Individual
use"NEEMSIS1-HH", clear

* Tables
tabulate migrantlistdummy
tabulate migrationjoblist1
tabulate migrationjoblist2



********** Details
use"NEEMSIS1-migrations", clear

* Tables
tabulate migrationjobid
tabulate migrationarea
tabulate migrationplace
summarize migrationdistance
tabulate migrationtype
tabulate migrationdurationfrequency
summarize migrationdurationinmonth
tabulate dummybacktovillage
summarize migrationtravelcost
tabulate migrationtravelpayment
summarize migrationtenure
tabulate migrationfindjob
tabulate dummyadvance
tabulate demodeclineadvance
tabulate demoadvancereasonrefused
tabulate migrationadvanceprovider
summarize demopreviousadvance migrationadvanceamount
tabulate demoadvancetransfer
tabulate demoadvancevar
tabulate demorefusedadvanceinc
tabulate demoacceptadvanceinc
tabulate demoperceptionadvancedec
tabulate dummyadvancebalance
summarize advanceamountbalance
tabulate advancebalanceproblem
tabulate advancebalanceperception
tabulate migrationjobtype
tabulate migrationjobtime
tabulate migrationwagetype
summarize migrationsalary
tabulate migrationpension
tabulate migrationbonus
tabulate migrationinsurance
tabulate migrationchild
tabulate migrationmainoccup
tabulate migrationskill
tabulate migrationreason
tabulate migrationotherreason

****************************************
* END
log close




















log using "5-1_Remrec.log", nomsg replace
****************************************
* 5.1. Remittances received
****************************************

********** Household
* Selection
use"NEEMSIS1-HH", clear
keep HHID2016 dummyremreceived
duplicates drop

* Tables
tabulate dummyremreceived


********** Individual 
use"NEEMSIS1-HH", clear

* Tables
tabulate remreceivedlistdummy

* Selection
keep HHID2016 INDID2016 remreceivedhhsource* remreceivedothersource* remreceivedsourcename* remreceivedsourcerelation* remreceivedsourceoccup* remreceivedsourceplace* remreceivedfrequency* remreceivedamount* remreceivedtotamount* remreceivedservices* demoremreceived* demoremreceivedamo* demoremreceivedform* remreceivedservices_poli* remreceivedservices_fina* remreceivedservices_guar* remreceivedservices_gene* remreceivedservices_none* remreceivedservices_othe*
reshape long remreceivedhhsource remreceivedothersource remreceivedsourcename remreceivedsourcerelation remreceivedsourceoccup remreceivedsourceplace remreceivedfrequency remreceivedamount remreceivedtotamount remreceivedservices demoremreceived demoremreceivedamo demoremreceivedform remreceivedservices_poli remreceivedservices_fina remreceivedservices_guar remreceivedservices_gene remreceivedservices_none remreceivedservices_othe, i(HHID2016 INDID2016) j(n)
drop if remreceivedhhsource==.

* Tables
tabulate remreceivedhhsource
tabulate remreceivedsourcerelation
tabulate remreceivedsourceoccup
tabulate remreceivedsourceplace
tabulate remreceivedfrequency
summarize remreceivedamount remreceivedtotamount
tabulate demoremreceived
summarize demoremreceivedamo
tabulate demoremreceivedform
tabulate remreceivedservices_poli
tabulate remreceivedservices_fina
tabulate remreceivedservices_guar
tabulate remreceivedservices_gene
tabulate remreceivedservices_none
tabulate remreceivedservices_othe

****************************************
* END
log close





















log using "5-2_Giftreceived.log", nomsg replace
****************************************
* 5.2. Gift received
****************************************

********** Household
* Selection
use"NEEMSIS1-HH", clear
keep HHID2016 dummygiftsreceived 
duplicates drop

* Tables
tabulate dummygiftsreceived


********** Individual 
use"NEEMSIS1-HH", clear

* Tables
tabulate giftsrecipientlistdummy
summarize giftsourcenb_WKP
tabulate giftoccasion_pongal_WKP
tabulate giftoccasion_birth_WKP
tabulate giftoccasion_house_WKP
tabulate giftoccasion_pube_WKP
tabulate giftoccasion_just_WKP
tabulate giftoccasion_other_WKP
tabulate giftoccasionother_WKP
tabulate gifttype_WKP
summarize giftamount_WKP

summarize giftsourcenb_rel
tabulate giftoccasion_pongal_rel
tabulate giftoccasion_birth_rel
tabulate giftoccasion_house_rel
tabulate giftoccasion_pube_rel
tabulate giftoccasion_just_rel
tabulate giftoccasion_other_rel
tabulate giftoccasionother_rel
tabulate gifttype_rel
summarize giftamount_rel goldquantityasgift_rel

summarize giftsourcenb_emp
tabulate giftoccasion_pongal_emp
tabulate giftoccasion_birth_emp
tabulate giftoccasion_house_emp
tabulate giftoccasion_pube_emp
tabulate giftoccasion_just_emp
tabulate giftoccasion_other_emp
tabulate gifttype_emp
summarize giftamount_emp

summarize giftsourcenb_friends
tabulate giftoccasion_pongal_friends
tabulate giftoccasion_birth_friends
tabulate giftoccasion_house_friends
tabulate giftoccasion_pube_friends
tabulate giftoccasion_just_friends
tabulate giftoccasion_other_friends
tabulate giftoccasionother_friends
tabulate gifttype_friends
summarize giftamount_friends
   
****************************************
* END
log close
















log using "5-3_Remittancessent.log", nomsg replace
****************************************
* 5.3. Remittances sent
****************************************

********** Household
* Selection
use"NEEMSIS1-HH", clear
keep HHID2016 dummyremsent 
duplicates drop

* Tables
tabulate dummyremsent



********** Individual
use"NEEMSIS1-HH", clear

* Tables
tabulate remsenderlistdummy

* Selection
keep HHID2016 INDID2016 remsenthhrecipient1 remsentotherrecipient1 remsentrecipientname1 remsentrelation1 remsentoccup1 remsentplace1 remsentfrequency1 remsentamount1 remsenttotalamount1 remsentservices1 remsentoccupother1 remsentservicesother1 remsenthhrecipient2 remsentotherrecipient2 remsentrecipientname2 remsentrelation2 remsentoccup2 remsentplace2 remsentfrequency2 remsentamount2 remsenttotalamount2 remsentservices2 remsentoccupother2 remsentservicesother2 demoremsentamount1 demoremsentform1 demoremsentamount2 demoremsentform2 remsentservices_poli* remsentservices_fina* remsentservices_guar* remsentservices_gene* remsentservices_none* remsentservices_othe*
reshape long remsenthhrecipient remsentotherrecipient remsentrecipientname remsentrelation remsentoccup remsentplace remsentfrequency remsentamount remsenttotalamount remsentservices remsentoccupother remsentservicesother demoremsentamount demoremsentform remsentservices_poli remsentservices_fina remsentservices_guar remsentservices_gene remsentservices_none remsentservices_othe, i(HHID2016 INDID2016) j(n)
drop if remsenthhrecipient==.

* Tables
tabulate remsenthhrecipient
tabulate remsentrelation
tabulate remsentoccup
tabulate remsentplace
tabulate remsentfrequency
summarize remsentamount remsenttotalamount
tabulate remsentservices_poli
tabulate remsentservices_fina
tabulate remsentservices_guar
tabulate remsentservices_gene
tabulate remsentservices_none
tabulate remsentservices_othe
tabulate remsentservicesother
tabulate remsentoccupother
tabulate remsentservicesother
summarize demoremsentamount
tabulate demoremsentform

****************************************
* END
log close























log using "6-1_Loans.log", nomsg replace
****************************************
* 6.1. Loans
* 6.2. Main loans
****************************************

********** Household
* Selection
use"NEEMSIS1-HH", clear
keep HHID2016 dummyloans demootherinc demootherincamount demoexchangeasked demoexchangeaccepted democommissionamount dummyincomeassets incomeassets
duplicates drop

* Tables
tabulate dummyloans
tabulate demootherinc
summarize demootherincamount demoexchangeasked demoexchangeaccepted democommissionamount
tabulate dummyincomeassets
summarize incomeassets



********** Individual
use"NEEMSIS1-HH", clear

* Tables
tabulate borrowerlistdummy
summarize nbloansbyborrower



********** Loans database
use"NEEMSIS1-loans_mainloans", clear

* Tables
summarize loanamount
tabulate demokindloan
tabulate loanreasongiven
tabulate loanotherreasongiven
tabulate loaneffectivereason_agri
tabulate loaneffectivereason_fami
tabulate loaneffectivereason_heal
tabulate loaneffectivereason_repa
tabulate loaneffectivereason_hous
tabulate loaneffectivereason_inve
tabulate loaneffectivereason_cere
tabulate loaneffectivereason_marr
tabulate loaneffectivereason_educ
tabulate loaneffectivereason_rela
tabulate loaneffectivereason_deat
tabulate loaneffectivereason_nore
tabulate loaneffectivereason_othe
tabulate loanothereffectivereason
tabulate demoloanreason_cash
tabulate demoloanreason_acce
tabulate demoloanreason_lowe
tabulate demoloanreason_comm
tabulate demoloanreason_node
tabulate demoloanreason_othe
tabulate demoloanotherreason
tabulate loanlender
tabulate lenderrelation_labo
tabulate lenderrelation_rela
tabulate lenderrelation_poli
tabulate lenderrelation_reli
tabulate lenderrelation_neig
tabulate lenderrelation_shg
tabulate lenderrelation_busi
tabulate lenderrelation_wkp
tabulate lenderrelation_tradi
tabulate lenderrelation_frie
tabulate lenderrelation_gpfi
tabulate lenderrelation_na
tabulate lenderrelation_nr
tabulate lenderscaste
tabulate lenderfrom
tabulate otherlenderservices_poli
tabulate otherlenderservices_fina
tabulate otherlenderservices_guar
tabulate otherlenderservices_gene
tabulate otherlenderservices_none
tabulate otherlenderservices_othe
tabulate otherlenderservicesother
tabulate loansettled
summarize loanbalance 
tabulate demoshg_mback
tabulate demoshg_shgac
tabulate demoshg_newsh
tabulate demoshg_nopro
tabulate demoshg_other



********** Main loans
* Tables
tabulate dummymainloan

* Selection
keep if dummymainloan==1

* Tables
tabulate lendersex
tabulate lenderoccup 
tabulate borrowerservices_free
tabulate borrowerservices_work
tabulate borrowerservices_supp
tabulate borrowerservices_none
tabulate borrowerservices_othe
tabulate borrowerservicesother
tabulate plantorepay_chit
tabulate plantorepay_work
tabulate plantorepay_migr
tabulate plantorepay_asse
tabulate plantorepay_inco
tabulate plantorepay_borr
tabulate plantorepay_othe
tabulate plantorepayother
tabulate termsofrepayment
tabulate repayduration1
summarize repayduration2
tabulate dummyinterest
tabulate interestfrequency
summarize interestloan interestpaid principalpaid totalrepaid
tabulate dummyproblemtorepay
tabulate settleloanstrategy_labo
tabulate settleloanstrategy_sche
tabulate settleloanstrategy_borr
tabulate settleloanstrategy_sell
tabulate settleloanstrategy_land
tabulate settleloanstrategy_cons
tabulate settleloanstrategy_adjo
tabulate settleloanstrategy_work
tabulate settleloanstrategy_supp
tabulate settleloanstrategy_harv
tabulate settleloanstrategy_othe
tabulate settleloanstrategyother
tabulate loanproductpledge_gold
tabulate loanproductpledge_land
tabulate loanproductpledge_car
tabulate loanproductpledge_bike
tabulate loanproductpledge_frid
tabulate loanproductpledge_furn
tabulate loanproductpledge_tail
tabulate loanproductpledge_cell
tabulate loanproductpledge_line
tabulate loanproductpledge_dvd
tabulate loanproductpledge_came
tabulate loanproductpledge_gas
tabulate loanproductpledge_comp
tabulate loanproductpledge_dish
tabulate loanproductpledge_none
summarize loanproductpledgeamount
tabulate dummyhelptosettleloan
tabulate helptosettleloan_mais
tabulate helptosettleloan_chil
tabulate helptosettleloan_sibl
tabulate helptosettleloan_pare
tabulate helptosettleloan_niec
tabulate helptosettleloan_othe
tabulate helptosettleloan_neig
tabulate helptosettleloan_frie
tabulate helptosettleloan_cust
tabulate helptosettleloan_mone
tabulate helptosettleloan_shg
tabulate helptosettleloan_empl
tabulate helptosettleloan_wkp
tabulate helptosettleloan_own
tabulate helptosettleloan_spou
tabulate problemdelayrepayment_noth
tabulate problemdelayrepayment_shou
tabulate problemdelayrepayment_pres
tabulate problemdelayrepayment_comp
tabulate problemdelayrepayment_info
tabulate problemdelayrepayment_othe
tabulate problemdelayrepaymentother
tabulate dummyrecommendation
tabulate dummyguarantor
tabulate recommenddetailscaste
tabulate recommendloanrelation
tabulate recommendloanrelation_labo
tabulate recommendloanrelation_rela
tabulate recommendloanrelation_poli
tabulate recommendloanrelation_reli
tabulate recommendloanrelation_neig
tabulate recommendloanrelation_shg
tabulate recommendloanrelation_busi
tabulate recommendloanrelation_wkp
tabulate recommendloanrelation_trad
tabulate recommendloanrelation_frie
tabulate recommendloanrelation_gpfin
tabulate guarantordetailscaste
tabulate guarantorloanrelation_labo
tabulate guarantorloanrelation_rela
tabulate guarantorloanrelation_poli
tabulate guarantorloanrelation_reli
tabulate guarantorloanrelation_neig
tabulate guarantorloanrelation_shg
tabulate guarantorloanrelation_busi
tabulate guarantorloanrelation_wkp
tabulate guarantorloanrelation_trad
tabulate guarantorloanrelation_frie
tabulate guarantorloanrelation_gpfin
tabulate guarantorloanrelation_nr
tabulate guarantee_docu
tabulate guarantee_chit
tabulate guarantee_shg
tabulate guarantee_pers
tabulate guarantee_jewe
tabulate guarantee_none
tabulate guarantee_other
tabulate guaranteeother
tabulate guaranteetype

****************************************
* END
log close















log using "6-3_Lending.log", nomsg replace
****************************************
* 6.3. Lending
****************************************

********** Household
* Selection
use"NEEMSIS1-HH", clear
keep HHID2016 dummylendingmoney
duplicates drop

* Tables
tabulate dummylendingmoney



********** Individual
use"NEEMSIS1-HH", clear

* Tables
tabulate hhlenderlistdummy
tabulate borrowerscaste
tabulate borrowerssex
tabulate relationwithborrower_mais
tabulate relationwithborrower_chil
tabulate relationwithborrower_sibl
tabulate relationwithborrower_pare
tabulate relationwithborrower_niec
tabulate relationwithborrower_othe
tabulate relationwithborrower_neig
tabulate relationwithborrower_frie
tabulate relationwithborrower_cust
tabulate relationwithborrower_mone
tabulate relationwithborrower_shg
tabulate relationwithborrower_empl
tabulate relationwithborrower_wkp
tabulate relationwithborrower_own
tabulate relationwithborrower_spou
summarize amountlent
tabulate demolendingkind
tabulate demotermslending
tabulate demodummyrepaylending
tabulate demorepaytermslending_payless
tabulate demorepaytermslending_freqext
tabulate demorepaytermslending_stopped
tabulate demorepaytermslending_partial
tabulate demorepaytermslending_totally
summarize interestlending
tabulate demointerestlending
tabulate purposeloanborrower
tabulate problemrepayment
tabulate dummyloanfromborrower
tabulate dummyrecommendgiven

****************************************
* END
log close













log using "6-4_Guarantee.log", nomsg replace
****************************************
* 6.4. Guarantee and recommendation
****************************************

********** Household
* Selection
use"NEEMSIS1-HH", clear
keep HHID2016 dummyrecommendgiven dummyrecommendrefuse reasonrefuserecommend
duplicates drop

* Tables
tabulate dummyrecommendgiven
tabulate dummyrecommendrefuse
tabulate reasonrefuserecommend



********** Individual
use"NEEMSIS1-HH", clear

* Tables
tabulate recommendgivenlistdummy
tabulate recommendgivenrelation
tabulate recommendgivencaste
tabulate dummyrecommendback
tabulate recommendgivenlender
tabulate recommendgivenlendercaste

****************************************
* END
log close




















log using "6-5_Chitfund.log", nomsg replace
****************************************
* 6.5. Chitfund
****************************************

********** Household
* Selection
use"NEEMSIS1-HH", clear
keep HHID2016 dummychitfund
duplicates drop

* Tables
tabulate dummychitfund



********** Individual
use"NEEMSIS1-HH", clear

* Tables
tabulate chitfundbelongerlistdummy
summarize nbchitfunds



********** Chit fund level
* Selection
use"NEEMSIS1-HH", clear
keep HHID2016 INDID2016 chitfundtype* durationchit* nbermemberchit* chitfundpayment* chitfundpaymentamount* chitfundamount*
reshape long chitfundtype durationchit nbermemberchit chitfundpayment chitfundpaymentamount chitfundamount, i(HHID2016 INDID2016) j(n)
drop if chitfundtype==.

* Tables
tabulate chitfundtype
summarize durationchit nbermemberchit
tabulate chitfundpayment
summarize chitfundpaymentamount chitfundamount

****************************************
* END
log close























log using "6-6_Saving.log", nomsg replace
****************************************
* 6.6. Savings
****************************************

********** Household
* Selection
use"NEEMSIS1-HH", clear
keep HHID2016 dummysavingaccount
duplicates drop

* Tables
tabulate dummysavingaccount



********** Individual
use"NEEMSIS1-HH", clear

* Tables
tabulate savingsownerlistdummy
summarize nbsavingaccounts



********** Saving account level
* Selection
use"NEEMSIS1-HH", clear
keep HHID2016 INDID2016 savingsaccounttype* savingsjointaccount* savingsaccountdate* banktype* savingsbankname* savingsbankplace* savingsamount* savingspurpose* dummydebitcard* dummycreditcard* datedebitcard* usedebitcard* reasonnotusedebitcard* demousedebitcard* demousecreditcard* datecreditcard* usecreditcard*
reshape long savingsaccounttype savingsjointaccount savingsaccountdate banktype savingsbankname savingsbankplace savingsamount savingspurpose dummydebitcard dummycreditcard datedebitcard usedebitcard reasonnotusedebitcard demousedebitcard demousecreditcard datecreditcard usecreditcard, i(HHID2016 INDID2016) j(n)
drop if savingsaccounttype==.

* Tables
tabulate savingsaccounttype
tabulate savingsjointaccount
tabulate savingsaccountdate
tabulate banktype
summarize savingsamount
tabulate savingspurpose


tabulate dummydebitcard
tabulate dummycreditcard
tabulate datedebitcard
tabulate usedebitcard

tabulate reasonnotusedebitcard
tabulate demousedebitcard
tabulate demousecreditcard
tabulate datecreditcard
tabulate usecreditcard

****************************************
* END
log close




