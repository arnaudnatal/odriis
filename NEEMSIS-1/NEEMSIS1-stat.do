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
keep HHID2016 INDID2016 savingsaccounttype* banktype* savingsbankname* savingsbankplace* savingsamount* savingspurpose* savingspurpose_sav* savingspurpose_jew* savingspurpose_rec* savingspurpose_cro* savingspurpose_sug* savingspurpose_sch* dummydebitcard* dummycreditcard* datedebitcard* usedebitcard* usedebitcard_neve* usedebitcard_atm* usedebitcard_shop* usedebitcard_tran* usedebitcard_onli* usedebitcard_mobi* usedebitcard_othe* savingsjointaccount* savingsaccountdate* reasonnotusedebitcard* reasonnotusedebitcard_none* reasonnotusedebitcard_dist* reasonnotusedebitcard_cash* reasonnotusedebitcard_flex* reasonnotusedebitcard_diff* reasonnotusedebitcard_afra* demousedebitcard* demousedebitcard_same* demousedebitcard_nonov* demousedebitcard_neve* demousedebitcard_atm* demousedebitcard_shop* demousedebitcard_tran* demousedebitcard_onli* demousedebitcard_mobi* demousedebitcard_other* demousecreditcard* demousecreditcard_same* demousecreditcard_nonov* demousecreditcard_neve* demousecreditcard_atm* demousecreditcard_shop* demousecreditcard_tran* demousecreditcard_onli* demousecreditcard_mobi* datecreditcard* usecreditcard*
reshape long savingsaccounttype banktype savingsbankname  savingsbankplace  savingsamount  savingspurpose  savingspurpose_sav  savingspurpose_jew  savingspurpose_rec  savingspurpose_cro  savingspurpose_sug  savingspurpose_sch  dummydebitcard  dummycreditcard  datedebitcard  usedebitcard  usedebitcard_neve  usedebitcard_atm  usedebitcard_shop  usedebitcard_tran  usedebitcard_onli  usedebitcard_mobi  usedebitcard_othe  savingsjointaccount  savingsaccountdate  reasonnotusedebitcard  reasonnotusedebitcard_none  reasonnotusedebitcard_dist  reasonnotusedebitcard_cash  reasonnotusedebitcard_flex  reasonnotusedebitcard_diff  reasonnotusedebitcard_afra  demousedebitcard  demousedebitcard_same  demousedebitcard_nonov  demousedebitcard_neve  demousedebitcard_atm  demousedebitcard_shop  demousedebitcard_tran  demousedebitcard_onli  demousedebitcard_mobi  demousedebitcard_other  demousecreditcard  demousecreditcard_same  demousecreditcard_nonov  demousecreditcard_neve  demousecreditcard_atm  demousecreditcard_shop  demousecreditcard_tran  demousecreditcard_onli  demousecreditcard_mobi  datecreditcard  usecreditcard , i(HHID2016 INDID2016) j(n)
drop if savingsaccounttype==.

* Tables
tabulate savingsaccounttype
tabulate savingsjointaccount
tabulate savingsaccountdate
tabulate banktype
summarize savingsamount
tabulate savingspurpose_sav
tabulate savingspurpose_jew
tabulate savingspurpose_rec
tabulate savingspurpose_cro
tabulate savingspurpose_sug
tabulate savingspurpose_sch
tabulate dummydebitcard
tabulate dummycreditcard
tabulate datedebitcard
tabulate usedebitcard_neve
tabulate usedebitcard_atm
tabulate usedebitcard_shop
tabulate usedebitcard_tran
tabulate usedebitcard_onli
tabulate usedebitcard_mobi
tabulate usedebitcard_othe
tabulate reasonnotusedebitcard_none
tabulate reasonnotusedebitcard_dist
tabulate reasonnotusedebitcard_cash
tabulate reasonnotusedebitcard_flex
tabulate reasonnotusedebitcard_diff
tabulate reasonnotusedebitcard_afra
tabulate demousedebitcard_same
tabulate demousedebitcard_nonov
tabulate demousedebitcard_neve
tabulate demousedebitcard_atm
tabulate demousedebitcard_shop
tabulate demousedebitcard_tran
tabulate demousedebitcard_onli
tabulate demousedebitcard_mobi
tabulate demousedebitcard_other
tabulate demousecreditcard_same
tabulate demousecreditcard_nonov
tabulate demousecreditcard_neve
tabulate demousecreditcard_atm
tabulate demousecreditcard_shop
tabulate demousecreditcard_tran
tabulate demousecreditcard_onli
tabulate demousecreditcard_mobi
tabulate datecreditcard
tabulate usecreditcard

****************************************
* END
log close




















log using "6-7_Gold.log", nomsg replace
****************************************
* 6.7. Gold
****************************************

********** Household
* Selection
use"NEEMSIS1-HH", clear
keep HHID2016 dummygold
duplicates drop

* Tables
tabulate dummygold



********** Individual
use"NEEMSIS1-HH", clear

* Tables
tabulate goldownerlistdummy
summarize goldquantity demogoldquanti
tabulate demogoldreasonbuy_savi
tabulate demogoldreasonbuy_rido
tabulate demogoldreasonbuy_gift
tabulate demogoldreasonbuy_sell
tabulate demogoldreasonbuy_spec
tabulate demogoldreasonbuy_othe
tabulate demogoldreasonbuyother
tabulate dummygoldpledged
summarize goldquantitypledge goldamountpledge
tabulate goldreasonpledge_agri
tabulate goldreasonpledge_fami
tabulate goldreasonpledge_heal
tabulate goldreasonpledge_repa
tabulate goldreasonpledge_hous
tabulate goldreasonpledge_inve
tabulate goldreasonpledge_cere
tabulate goldreasonpledge_marr
tabulate goldreasonpledge_educ
tabulate goldreasonpledge_rela
tabulate goldreasonpledge_deat
tabulate goldreasonpledge_nore
summarize demogoldpledged
tabulate demogoldreasonpledge_agri
tabulate demogoldreasonpledge_fami
tabulate demogoldreasonpledge_heal
tabulate demogoldreasonpledge_repa
tabulate demogoldreasonpledge_hous
tabulate demogoldreasonpledge_inve
tabulate demogoldreasonpledge_cere
tabulate demogoldreasonpledge_marr
tabulate demogoldreasonpledge_educ
tabulate demogoldreasonpledge_rela
tabulate demogoldreasonpledge_deat

****************************************
* END
log close






















log using "6-8_Insurance.log", nomsg replace
****************************************
* 6.8. Insurance
****************************************

********** Household
* Selection
use"NEEMSIS1-HH", clear
keep HHID2016 dummyinsurance reasonnoinsurance_* reasonnoinsuranceother
duplicates drop

* Tables
tabulate dummyinsurance
tabulate reasonnoinsurance_noin
tabulate reasonnoinsurance_mone
tabulate reasonnoinsurance_dkno
tabulate reasonnoinsurance_othe
tabulate reasonnoinsuranceother


********** Individual
use"NEEMSIS1-HH", clear


* Tables
tabulate insuranceownerlistdummy
summarize nbinsurance



********** Insurance level
* Selection
keep HHID2016 INDID2016 insurancepublic1 insurancepublic2 insurancename1 insurancename2 insurancejoineddate1 insurancejoineddate2 insurancetype1 insurancetype2 insurancepaymentfrequency1 insurancepaymentfrequency2 insuranceamount1 insuranceamount2 insurancebenefit1 insurancebenefitamount1 insurancebenefit2 insurancebenefitamount2
reshape long insurancepublic insurancename insurancejoineddate insurancetype insurancepaymentfrequency insuranceamount insurancebenefitamount insurancebenefit, i(HHID2016 INDID2016) j(n)
drop if insurancename==""

* Tables
tabulate insurancepublic
tabulate insurancename
tabulate insurancetype
tabulate insurancepaymentfrequency
summarize insuranceamount
tabulate insurancebenefit
summarize insurancebenefitamount

****************************************
* END
log close














log using "7-1_Land.log", nomsg replace
****************************************
* 7.1. Land
****************************************
use"NEEMSIS1-HH", clear

* Selection
keep HHID2016 dummyeverhadland ownland sizeownland drywetownland waterfromownland_* leaseland sizeleaseland drywetleaseland waterfromleaseland_* landpurchased landpurchasedacres landpurchasedamount landpurchasedhowbuy_here landpurchasedhowbuy_savi landpurchasedhowbuy_bank landpurchasedhowbuy_cred landpurchasedhowbuy_fina landpurchasedhowbuy_help landpurchasedhowbuy_sche landlost landlostreason dummyleasedland landleasername landleaserrelation landleasercaste landleaserothercaste dummyleasingland landleasingname landleasingrelation_* landleasingcaste landleasingrothercaste
duplicates drop

* Tables
tabulate dummyeverhadland
tabulate ownland
summarize sizeownland
tabulate drywetownland
tabulate waterfromownland_tank
tabulate waterfromownland_rive
tabulate waterfromownland_bore
tabulate waterfromownland_open
tabulate waterfromownland_rain

tabulate leaseland
summarize sizeleaseland
tabulate drywetleaseland
tabulate waterfromleaseland_tank
tabulate waterfromleaseland_rive
tabulate waterfromleaseland_bore
tabulate waterfromleaseland_open
tabulate waterfromleaseland_rain

tabulate landpurchased
summarize landpurchasedacres landpurchasedamount
tabulate landpurchasedhowbuy_here
tabulate landpurchasedhowbuy_savi
tabulate landpurchasedhowbuy_bank
tabulate landpurchasedhowbuy_cred
tabulate landpurchasedhowbuy_fina
tabulate landpurchasedhowbuy_help
tabulate landpurchasedhowbuy_sche
tabulate landlost
tabulate landlostreason
tabulate dummyleasedland
tabulate landleasername
tabulate landleaserrelation
tabulate landleasercaste
tabulate landleaserothercaste
tabulate dummyleasingland
tabulate landleasingname
tabulate landleasingrelation_labo
tabulate landleasingrelation_rela
tabulate landleasingrelation_poli
tabulate landleasingrelation_reli
tabulate landleasingrelation_neig
tabulate landleasingrelation_shg
tabulate landleasingrelation_busi
tabulate landleasingrelation_wkp
tabulate landleasingrelation_trad
tabulate landleasingrelation_frie
tabulate landleasingrelation_gpfi
tabulate landleasingcaste
tabulate landleasingrothercaste

****************************************
* END
log close











log using "7-2_Crops.log", nomsg replace
****************************************
* 7.2. Cropping
****************************************
use"NEEMSIS1-HH", clear

* Selection
keep HHID2016 productlist productacre_pad productacre_rag productacre_mil productacre_tap productacre_cot productacre_sug productacre_sav productacre_gua productacre_gro productypeland_pad productypeland_rag productypeland_mil productypeland_tap productypeland_cot productypeland_sug productypeland_sav productypeland_gua productypeland_gro productunit_pad productunit_rag productunit_mil productunit_tap productunit_cot productunit_sug productunit_sav productunit_gua productunit_gro productnbbags_pad productnbbags_rag productnbbags_mil productnbbags_tap productnbbags_cot productnbbags_sug productnbbags_sav productnbbags_gua productnbbags_gro productselfconsumption_pad productselfconsumption_rag productselfconsumption_mil productselfconsumption_tap productselfconsumption_cot productselfconsumption_sug productselfconsumption_sav productselfconsumption_gua productselfconsumption_gro productnbbagssold_pad productnbbagssold_rag productnbbagssold_mil productnbbagssold_tap productnbbagssold_cot productnbbagssold_sug productnbbagssold_sav productnbbagssold_gua productnbbagssold_gro productpricesold_pad productpricesold_rag productpricesold_mil productpricesold_tap productpricesold_cot productpricesold_sug productpricesold_sav productpricesold_gua productpricesold_gro productexpenses_pad productexpenses_rag productexpenses_mil productexpenses_tap productexpenses_cot productexpenses_sug productexpenses_sav productexpenses_gua productexpenses_gro productpaidworkers_pad productpaidworkers_rag productpaidworkers_mil productpaidworkers_tap productpaidworkers_cot productpaidworkers_sug productpaidworkers_sav productpaidworkers_gua productpaidworkers_gro productnbpaidworkers_pad productnbpaidworkers_rag productnbpaidworkers_mil productnbpaidworkers_tap productnbpaidworkers_cot productnbpaidworkers_sug productnbpaidworkers_sav productnbpaidworkers_gua productnbpaidworkers_gro productlabourcost_pad productlabourcost_rag productlabourcost_mil productlabourcost_tap productlabourcost_cot productlabourcost_sug productlabourcost_sav productlabourcost_gua productlabourcost_gro productunpaidworkers_pad productunpaidworkers_rag productunpaidworkers_mil productunpaidworkers_tap productunpaidworkers_cot productunpaidworkers_sug productunpaidworkers_sav productunpaidworkers_gua productunpaidworkers_gro productnbunpaidworkers_pad productnbunpaidworkers_rag productnbunpaidworkers_mil productnbunpaidworkers_tap productnbunpaidworkers_cot productnbunpaidworkers_sug productnbunpaidworkers_sav productnbunpaidworkers_gua productnbunpaidworkers_gro productnbhhmembers_pad productnbhhmembers_rag productnbhhmembers_mil productnbhhmembers_tap productnbhhmembers_cot productnbhhmembers_sug productnbhhmembers_sav productnbhhmembers_gua productnbhhmembers_gro productoriginlabourers_pad productoriginlabourers_in_pad productoriginlabourers_ou_pad productoriginlabourers_rag productoriginlabourers_in_rag productoriginlabourers_ou_rag productoriginlabourers_mil productoriginlabourers_in_mil productoriginlabourers_ou_mil productoriginlabourers_tap productoriginlabourers_in_tap productoriginlabourers_ou_tap productoriginlabourers_cot productoriginlabourers_in_cot productoriginlabourers_ou_cot productoriginlabourers_sug productoriginlabourers_in_sug productoriginlabourers_ou_sug productoriginlabourers_sav productoriginlabourers_in_sav productoriginlabourers_ou_sav productoriginlabourers_gua productoriginlabourers_in_gua productoriginlabourers_ou_gua productoriginlabourers_gro productoriginlabourers_in_gro productoriginlabourers_ou_gro productcastelabourers_pad productcastelabourers_van_pad productcastelabourers_sc_pad productcastelabourers_aru_pad productcastelabourers_red_pad productcastelabourers_gra_pad productcastelabourers_nai_pad productcastelabourers_nav_pad productcastelabourers_asa_pad productcastelabourers_set_pad productcastelabourers_nat_pad productcastelabourers_mud_pad productcastelabourers_kul_pad productcastelabourers_che_pad productcastelabourers_mar_pad productcastelabourers_mus_pad productcastelabourers_pad_pad productcastelabourers_dk_pad productcastelabourers_rag productcastelabourers_van_rag productcastelabourers_sc_rag productcastelabourers_aru_rag productcastelabourers_red_rag productcastelabourers_gra_rag productcastelabourers_nai_rag productcastelabourers_nav_rag productcastelabourers_asa_rag productcastelabourers_set_rag productcastelabourers_nat_rag productcastelabourers_mud_rag productcastelabourers_kul_rag productcastelabourers_che_rag productcastelabourers_mar_rag productcastelabourers_mus_rag productcastelabourers_pad_rag productcastelabourers_dk_rag productcastelabourers_mil productcastelabourers_van_mil productcastelabourers_sc_mil productcastelabourers_aru_mil productcastelabourers_red_mil productcastelabourers_gra_mil productcastelabourers_nai_mil productcastelabourers_nav_mil productcastelabourers_asa_mil productcastelabourers_set_mil productcastelabourers_nat_mil productcastelabourers_mud_mil productcastelabourers_kul_mil productcastelabourers_che_mil productcastelabourers_mar_mil productcastelabourers_mus_mil productcastelabourers_pad_mil productcastelabourers_dk_mil productcastelabourers_tap productcastelabourers_van_tap productcastelabourers_sc_tap productcastelabourers_aru_tap productcastelabourers_red_tap productcastelabourers_gra_tap productcastelabourers_nai_tap productcastelabourers_nav_tap productcastelabourers_asa_tap productcastelabourers_set_tap productcastelabourers_nat_tap productcastelabourers_mud_tap productcastelabourers_kul_tap productcastelabourers_che_tap productcastelabourers_mar_tap productcastelabourers_mus_tap productcastelabourers_pad_tap productcastelabourers_dk_tap productcastelabourers_cot productcastelabourers_van_cot productcastelabourers_sc_cot productcastelabourers_aru_cot productcastelabourers_red_cot productcastelabourers_gra_cot productcastelabourers_nai_cot productcastelabourers_nav_cot productcastelabourers_asa_cot productcastelabourers_set_cot productcastelabourers_nat_cot productcastelabourers_mud_cot productcastelabourers_kul_cot productcastelabourers_che_cot productcastelabourers_mar_cot productcastelabourers_mus_cot productcastelabourers_pad_cot productcastelabourers_dk_cot productcastelabourers_sug productcastelabourers_van_sug productcastelabourers_sc_sug productcastelabourers_aru_sug productcastelabourers_red_sug productcastelabourers_gra_sug productcastelabourers_nai_sug productcastelabourers_nav_sug productcastelabourers_asa_sug productcastelabourers_set_sug productcastelabourers_nat_sug productcastelabourers_mud_sug productcastelabourers_kul_sug productcastelabourers_che_sug productcastelabourers_mar_sug productcastelabourers_mus_sug productcastelabourers_pad_sug productcastelabourers_dk_sug productcastelabourers_sav productcastelabourers_van_sav productcastelabourers_sc_sav productcastelabourers_aru_sav productcastelabourers_red_sav productcastelabourers_gra_sav productcastelabourers_nai_sav productcastelabourers_nav_sav productcastelabourers_asa_sav productcastelabourers_set_sav productcastelabourers_nat_sav productcastelabourers_mud_sav productcastelabourers_kul_sav productcastelabourers_che_sav productcastelabourers_mar_sav productcastelabourers_mus_sav productcastelabourers_pad_sav productcastelabourers_dk_sav productcastelabourers_gua productcastelabourers_van_gua productcastelabourers_sc_gua productcastelabourers_aru_gua productcastelabourers_red_gua productcastelabourers_gra_gua productcastelabourers_nai_gua productcastelabourers_nav_gua productcastelabourers_asa_gua productcastelabourers_set_gua productcastelabourers_nat_gua productcastelabourers_mud_gua productcastelabourers_kul_gua productcastelabourers_che_gua productcastelabourers_mar_gua productcastelabourers_mus_gua productcastelabourers_pad_gua productcastelabourers_dk_gua productcastelabourers_gro productcastelabourers_van_gro productcastelabourers_sc_gro productcastelabourers_aru_gro productcastelabourers_red_gro productcastelabourers_gra_gro productcastelabourers_nai_gro productcastelabourers_nav_gro productcastelabourers_asa_gro productcastelabourers_set_gro productcastelabourers_nat_gro productcastelabourers_mud_gro productcastelabourers_kul_gro productcastelabourers_che_gro productcastelabourers_mar_gro productcastelabourers_mus_gro productcastelabourers_pad_gro productcastelabourers_dk_gro ///
demonbagriworkers_hpaid demonbagriworkers_dpaid demonbagriworkers_hunpa demonbagriworkers_dunpa demonbagriworkers_same demoagriactivity_lein demoagriactivity_ncin demoagriactivity_diff demoagriactivity_ncpa demoagriactivity_pmor demoagriactivity_freq demoagriactivity_pres demoagriactivity_cont demoagriactivity_othe
duplicates drop

* Tables
summarize productacre_pad
tabulate productypeland_pad
tabulate productunit_pad
summarize productnbbags_pad productselfconsumption_pad productnbbagssold_pad productpricesold_pad productexpenses_pad
tabulate productpaidworkers_pad
summarize productnbpaidworkers_pad productlabourcost_pad
tabulate productunpaidworkers_pad
summarize productnbunpaidworkers_pad productnbhhmembers_pad
tabulate productoriginlabourers_in_pad
tabulate productoriginlabourers_ou_pad
tabulate productcastelabourers_van_pad
tabulate productcastelabourers_sc_pad
tabulate productcastelabourers_aru_pad
tabulate productcastelabourers_red_pad
tabulate productcastelabourers_gra_pad
tabulate productcastelabourers_nai_pad
tabulate productcastelabourers_nav_pad
tabulate productcastelabourers_asa_pad
tabulate productcastelabourers_set_pad
tabulate productcastelabourers_nat_pad
tabulate productcastelabourers_mud_pad
tabulate productcastelabourers_kul_pad
tabulate productcastelabourers_che_pad
tabulate productcastelabourers_mar_pad
tabulate productcastelabourers_mus_pad
tabulate productcastelabourers_pad_pad
tabulate productcastelabourers_dk_pad

summarize productacre_rag
tabulate productypeland_rag
tabulate productunit_rag
summarize productnbbags_rag productselfconsumption_rag productnbbagssold_rag productpricesold_rag productexpenses_rag
tabulate productpaidworkers_rag
summarize productnbpaidworkers_rag productlabourcost_rag
tabulate productunpaidworkers_rag
summarize productnbunpaidworkers_rag productnbhhmembers_rag
tabulate productoriginlabourers_in_rag
tabulate productoriginlabourers_ou_rag
tabulate productcastelabourers_van_rag
tabulate productcastelabourers_sc_rag
tabulate productcastelabourers_aru_rag
tabulate productcastelabourers_red_rag
tabulate productcastelabourers_gra_rag
tabulate productcastelabourers_nai_rag
tabulate productcastelabourers_nav_rag
tabulate productcastelabourers_asa_rag
tabulate productcastelabourers_set_rag
tabulate productcastelabourers_nat_rag
tabulate productcastelabourers_mud_rag
tabulate productcastelabourers_kul_rag
tabulate productcastelabourers_che_rag
tabulate productcastelabourers_mar_rag
tabulate productcastelabourers_mus_rag
tabulate productcastelabourers_pad_rag
tabulate productcastelabourers_dk_rag

summarize productacre_mil
tabulate productypeland_mil
tabulate productunit_mil
summarize productnbbags_mil productselfconsumption_mil productnbbagssold_mil productpricesold_mil productexpenses_mil
tabulate productpaidworkers_mil
summarize productnbpaidworkers_mil productlabourcost_mil
tabulate productunpaidworkers_mil
summarize productnbunpaidworkers_mil productnbhhmembers_mil
tabulate productoriginlabourers_in_mil
tabulate productoriginlabourers_ou_mil
tabulate productcastelabourers_van_pad
tabulate productcastelabourers_sc_mil
tabulate productcastelabourers_aru_mil
tabulate productcastelabourers_red_mil
tabulate productcastelabourers_gra_mil
tabulate productcastelabourers_nai_mil
tabulate productcastelabourers_nav_mil
tabulate productcastelabourers_asa_mil
tabulate productcastelabourers_set_mil
tabulate productcastelabourers_nat_mil
tabulate productcastelabourers_mud_mil
tabulate productcastelabourers_kul_mil
tabulate productcastelabourers_che_mil
tabulate productcastelabourers_mar_mil
tabulate productcastelabourers_mus_mil
tabulate productcastelabourers_pad_mil
tabulate productcastelabourers_dk_mil

summarize productacre_tap
tabulate productypeland_tap
tabulate productunit_tap
summarize productnbbags_tap productselfconsumption_tap productnbbagssold_tap productpricesold_tap productexpenses_tap
tabulate productpaidworkers_tap
summarize productnbpaidworkers_tap productlabourcost_tap
tabulate productunpaidworkers_tap
summarize productnbunpaidworkers_tap productnbhhmembers_tap
tabulate productoriginlabourers_in_tap
tabulate productoriginlabourers_ou_tap
tabulate productcastelabourers_van_tap
tabulate productcastelabourers_sc_tap
tabulate productcastelabourers_aru_tap
tabulate productcastelabourers_red_tap
tabulate productcastelabourers_gra_tap
tabulate productcastelabourers_nai_tap
tabulate productcastelabourers_nav_tap
tabulate productcastelabourers_asa_tap
tabulate productcastelabourers_set_tap
tabulate productcastelabourers_nat_tap
tabulate productcastelabourers_mud_tap
tabulate productcastelabourers_kul_tap
tabulate productcastelabourers_che_tap
tabulate productcastelabourers_mar_tap
tabulate productcastelabourers_mus_tap
tabulate productcastelabourers_pad_tap
tabulate productcastelabourers_dk_tap

summarize productacre_pad
tabulate productypeland_pad
tabulate productunit_pad
summarize productnbbags_pad productselfconsumption_pad productnbbagssold_pad productpricesold_pad productexpenses_pad
tabulate productpaidworkers_pad
summarize productnbpaidworkers_pad productlabourcost_pad
tabulate productunpaidworkers_pad
summarize productnbunpaidworkers_pad productnbhhmembers_pad
tabulate productoriginlabourers_in_pad
tabulate productoriginlabourers_ou_cot
tabulate productcastelabourers_van_cot
tabulate productcastelabourers_sc_cot
tabulate productcastelabourers_aru_cot
tabulate productcastelabourers_red_cot
tabulate productcastelabourers_gra_cot
tabulate productcastelabourers_nai_cot
tabulate productcastelabourers_nav_cot
tabulate productcastelabourers_asa_cot
tabulate productcastelabourers_set_cot
tabulate productcastelabourers_nat_cot
tabulate productcastelabourers_mud_cot
tabulate productcastelabourers_kul_cot
tabulate productcastelabourers_che_cot
tabulate productcastelabourers_mar_cot
tabulate productcastelabourers_mus_cot
tabulate productcastelabourers_pad_cot
tabulate productcastelabourers_dk_cot

summarize productacre_sug
tabulate productypeland_sug
tabulate productunit_sug
summarize productnbbags_sug productselfconsumption_sug productnbbagssold_sug productpricesold_sug productexpenses_sug
tabulate productpaidworkers_sug
summarize productnbpaidworkers_sug productlabourcost_sug
tabulate productunpaidworkers_sug
summarize productnbunpaidworkers_sug productnbhhmembers_sug
tabulate productoriginlabourers_in_sug
tabulate productoriginlabourers_ou_sug
tabulate productcastelabourers_van_sug
tabulate productcastelabourers_sc_sug
tabulate productcastelabourers_aru_sug
tabulate productcastelabourers_red_sug
tabulate productcastelabourers_gra_sug
tabulate productcastelabourers_nai_sug
tabulate productcastelabourers_nav_sug
tabulate productcastelabourers_asa_sug
tabulate productcastelabourers_set_sug
tabulate productcastelabourers_nat_sug
tabulate productcastelabourers_mud_sug
tabulate productcastelabourers_kul_sug
tabulate productcastelabourers_che_sug
tabulate productcastelabourers_mar_sug
tabulate productcastelabourers_mus_sug
tabulate productcastelabourers_pad_sug
tabulate productcastelabourers_dk_sug

summarize productacre_sav
tabulate productypeland_sav
tabulate productunit_sav
summarize productnbbags_sav productselfconsumption_sav productnbbagssold_sav productpricesold_sav productexpenses_sav
tabulate productpaidworkers_sav
summarize productnbpaidworkers_sav productlabourcost_sav
tabulate productunpaidworkers_sav
summarize productnbunpaidworkers_sav productnbhhmembers_sav
tabulate productoriginlabourers_in_sav
tabulate productoriginlabourers_ou_sav
tabulate productcastelabourers_van_sav
tabulate productcastelabourers_sc_sav
tabulate productcastelabourers_aru_sav
tabulate productcastelabourers_red_sav
tabulate productcastelabourers_gra_sav
tabulate productcastelabourers_nai_sav
tabulate productcastelabourers_nav_sav
tabulate productcastelabourers_asa_sav
tabulate productcastelabourers_set_sav
tabulate productcastelabourers_nat_sav
tabulate productcastelabourers_mud_sav
tabulate productcastelabourers_kul_sav
tabulate productcastelabourers_che_sav
tabulate productcastelabourers_mar_sav
tabulate productcastelabourers_mus_sav
tabulate productcastelabourers_pad_sav
tabulate productcastelabourers_dk_sav

summarize productacre_gua
tabulate productypeland_gua
tabulate productunit_gua
summarize productnbbags_gua productselfconsumption_gua productnbbagssold_gua productpricesold_gua productexpenses_gua
tabulate productpaidworkers_gua
summarize productnbpaidworkers_gua productlabourcost_gua
tabulate productunpaidworkers_gua
summarize productnbunpaidworkers_gua productnbhhmembers_gua
tabulate productoriginlabourers_in_gua
tabulate productoriginlabourers_ou_gua
tabulate productcastelabourers_van_gua
tabulate productcastelabourers_sc_gua
tabulate productcastelabourers_aru_gua
tabulate productcastelabourers_red_gua
tabulate productcastelabourers_gra_gua
tabulate productcastelabourers_nai_gua
tabulate productcastelabourers_nav_gua
tabulate productcastelabourers_asa_gua
tabulate productcastelabourers_set_gua
tabulate productcastelabourers_nat_gua
tabulate productcastelabourers_mud_gua
tabulate productcastelabourers_kul_gua
tabulate productcastelabourers_che_gua
tabulate productcastelabourers_mar_gua
tabulate productcastelabourers_mus_gua
tabulate productcastelabourers_pad_gua
tabulate productcastelabourers_dk_gua

summarize productacre_gro
tabulate productypeland_gro
tabulate productunit_gro
summarize productnbbags_gro productselfconsumption_gro productnbbagssold_gro productpricesold_gro productexpenses_gro
tabulate productpaidworkers_gro
summarize productnbpaidworkers_gro productlabourcost_gro
tabulate productunpaidworkers_gro
summarize productnbunpaidworkers_gro productnbhhmembers_gro
tabulate productoriginlabourers_in_gro
tabulate productoriginlabourers_ou_gro
tabulate productcastelabourers_van_gro
tabulate productcastelabourers_sc_gro
tabulate productcastelabourers_aru_gro
tabulate productcastelabourers_red_gro
tabulate productcastelabourers_gra_gro
tabulate productcastelabourers_nai_gro
tabulate productcastelabourers_nav_gro
tabulate productcastelabourers_asa_gro
tabulate productcastelabourers_set_gro
tabulate productcastelabourers_nat_gro
tabulate productcastelabourers_mud_gro
tabulate productcastelabourers_kul_gro
tabulate productcastelabourers_che_gro
tabulate productcastelabourers_mar_gro
tabulate productcastelabourers_mus_gro
tabulate productcastelabourers_pad_gro
tabulate productcastelabourers_dk_gro

tabulate demonbagriworkers_hpaid
tabulate demonbagriworkers_dpaid
tabulate demonbagriworkers_hunpa
tabulate demonbagriworkers_dunpa
tabulate demonbagriworkers_same

tabulate demoagriactivity_lein
tabulate demoagriactivity_ncin
tabulate demoagriactivity_diff
tabulate demoagriactivity_ncpa
tabulate demoagriactivity_pmor
tabulate demoagriactivity_freq
tabulate demoagriactivity_pres
tabulate demoagriactivity_cont
tabulate demoagriactivity_othe

****************************************
* END
log close

















log using "7-3_Livestock.log", nomsg replace
****************************************
* 7.3. Livestock
****************************************
use"NEEMSIS1-HH", clear

* Selection 
keep HHID2016 livestocklist livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock livestocknb_cow livestocknb_goat livestocknb_chicken livestocknb_bullock livestockprice_cow livestockprice_goat livestockprice_chicken livestockprice_bullock livestockuse_cow livestockuse_sold_cow livestockuse_milk_cow livestockuse_savi_cow livestockuse_stat_cow livestockuse_reli_cow livestockuse_self_cow livestockuse_goat livestockuse_sold_goat livestockuse_milk_goat livestockuse_savi_goat livestockuse_stat_goat livestockuse_reli_goat livestockuse_self_goat livestockuse_chicken livestockuse_sold_chicken livestockuse_milk_chicken livestockuse_savi_chicken livestockuse_stat_chicken livestockuse_reli_chicken livestockuse_self_chicken livestockuse_bullock livestockuse_sold_bullock livestockuse_milk_bullock livestockuse_savi_bullock livestockuse_stat_bullock livestockuse_reli_bullock livestockuse_self_bullock livestockprofit_cow livestockprofit_goat livestockprofit_chicken livestockprofit_bullock livestockspent_cow livestockspent_goat livestockspent_chicken livestockspent_bullock livestockbuy_cow livestockbuy_goat livestockbuy_chicken livestockbuy_bullock dummycattleloss cattlelossnb cattlelossamount cattleinsurance cattleinsuranceamount dummycattlesold cattlesoldnb cattlesoldamount cattlesoldreason
duplicates drop

* Tables
summarize livestocknb_cow livestockprice_cow
tabulate livestockuse_sold_cow
tabulate livestockuse_milk_cow
tabulate livestockuse_savi_cow
tabulate livestockuse_stat_cow
tabulate livestockuse_reli_cow
tabulate livestockuse_self_cow
summarize livestockprofit_cow livestockspent_cow livestockbuy_cow

summarize livestocknb_goat livestockprice_goat
tabulate livestockuse_sold_goat
tabulate livestockuse_milk_goat
tabulate livestockuse_savi_goat
tabulate livestockuse_stat_goat
tabulate livestockuse_reli_goat
tabulate livestockuse_self_goat
summarize livestockprofit_goat livestockspent_goat livestockbuy_goat

summarize livestocknb_chicken livestockprice_chicken
tabulate livestockuse_sold_chicken
tabulate livestockuse_milk_chicken
tabulate livestockuse_savi_chicken
tabulate livestockuse_stat_chicken
tabulate livestockuse_reli_chicken
tabulate livestockuse_self_chicken
summarize livestockprofit_chicken livestockspent_chicken livestockbuy_chicken

summarize livestocknb_bullock livestockprice_bullock
tabulate livestockuse_sold_bullock
tabulate livestockuse_milk_bullock
tabulate livestockuse_savi_bullock
tabulate livestockuse_stat_bullock
tabulate livestockuse_reli_bullock
tabulate livestockuse_self_bullock
summarize livestockprofit_bullock livestockspent_bullock livestockbuy_bullock

tabulate dummycattleloss
summarize cattlelossnb cattlelossamount
tabulate cattleinsurance
summarize cattleinsuranceamount
tabulate dummycattlesold
summarize cattlesoldnb cattlesoldamount
tabulate cattlesoldreason

****************************************
* END
log close













log using "7-4_Equipment.log", nomsg replace
****************************************
* 7.4. Equipment
****************************************
use"NEEMSIS1-HH", clear

* Selection
keep HHID2016 equipmentlist equiownnb_tractor equiownnb_bullockcart equiownnb_ploughmach equiownyear_tractor equiownyear_bullockcart equiownyear_ploughmach equiownpay_tractor equiownpay_inc_tractor equiownpay_sav_tractor equiownpay_ass_tractor equiownpay_hel_tractor equiownpay_sch_tractor equiownpay_ngo_tractor equiownpay_cre_tractor equiownpay_wor_tractor equiownpay_bullockcart equiownpay_inc_bullockcart equiownpay_sav_bullockcart equiownpay_ass_bullockcart equiownpay_hel_bullockcart equiownpay_sch_bullockcart equiownpay_ngo_bullockcart equiownpay_cre_bullockcart equiownpay_wor_bullockcart equiownpay_ploughmach equiownpay_inc_ploughmach equiownpay_sav_ploughmach equiownpay_ass_ploughmach equiownpay_hel_ploughmach equiownpay_sch_ploughmach equiownpay_ngo_ploughmach equiownpay_cre_ploughmach equiownpay_wor_ploughmach equiowncost_tractor equiowncost_bullockcart equiowncost_ploughmach equiownpledged_tractor equiownpledged_bullockcart equiownpledged_ploughmach equipmentborrowedlist equilentnb_tractor equilentnb_bullockcart equilentnb_harvester equilentnb_ploughmach equilentlender_tractor equilentlender_mai_tractor equilentlender_chi_tractor equilentlender_sib_tractor equilentlender_par_tractor equilentlender_nie_tractor equilentlender_oth_tractor equilentlender_nei_tractor equilentlender_fri_tractor equilentlender_cus_tractor equilentlender_mon_tractor equilentlender_shg_tractor equilentlender_emp_tractor equilentlender_wkp_tractor equilentlender_own_tractor equilentlender_spo_tractor equilentlender_bullockcart equilentlender_mai_ploughmach equilentlender_chi_ploughmach equilentlender_sib_ploughmach equilentlender_par_ploughmach equilentlender_nie_ploughmach equilentlender_oth_ploughmach equilentlender_nei_ploughmach equilentlender_fri_ploughmach equilentlender_cus_ploughmach equilentlender_mon_ploughmach equilentlender_shg_ploughmach equilentlender_emp_ploughmach equilentlender_wkp_ploughmach equilentlender_own_ploughmach equilentlender_spo_ploughmach equilentlender_harvester equilentlender_ploughmach equilentlender_mai_bullockcart equilentlender_chi_bullockcart equilentlender_sib_bullockcart equilentlender_par_bullockcart equilentlender_nie_bullockcart equilentlender_oth_bullockcart equilentlender_nei_bullockcart equilentlender_fri_bullockcart equilentlender_cus_bullockcart equilentlender_mon_bullockcart equilentlender_shg_bullockcart equilentlender_emp_bullockcart equilentlender_wkp_bullockcart equilentlender_own_bullockcart equilentlender_spo_bullockcart
duplicates drop

* Tables
summarize equiownnb_tractor 
summarize equiownyear_tractor 
tabulate equiownpay_inc_tractor
tabulate equiownpay_sav_tractor
tabulate equiownpay_ass_tractor
tabulate equiownpay_hel_tractor
tabulate equiownpay_sch_tractor
tabulate equiownpay_ngo_tractor
tabulate equiownpay_cre_tractor
tabulate equiownpay_wor_tractor 
summarize equiowncost_tractor equiownpledged_tractor equilentnb_tractor 
tabulate equilentlender_mai_tractor
tabulate equilentlender_chi_tractor
tabulate equilentlender_sib_tractor
tabulate equilentlender_par_tractor
tabulate equilentlender_nie_tractor
tabulate equilentlender_oth_tractor
tabulate equilentlender_nei_tractor
tabulate equilentlender_fri_tractor
tabulate equilentlender_cus_tractor
tabulate equilentlender_mon_tractor
tabulate equilentlender_shg_tractor
tabulate equilentlender_emp_tractor
tabulate equilentlender_wkp_tractor
tabulate equilentlender_own_tractor
tabulate equilentlender_spo_tractor 

summarize equiownnb_ploughmach 
summarize equiownyear_ploughmach 
tabulate equiownpay_inc_ploughmach
tabulate equiownpay_sav_ploughmach
tabulate equiownpay_ass_ploughmach
tabulate equiownpay_hel_ploughmach
tabulate equiownpay_sch_ploughmach
tabulate equiownpay_ngo_ploughmach
tabulate equiownpay_cre_ploughmach
tabulate equiownpay_wor_ploughmach 
summarize equiowncost_ploughmach equiownpledged_ploughmach equilentnb_ploughmach 
tabulate equilentlender_mai_ploughmach
tabulate equilentlender_chi_ploughmach
tabulate equilentlender_sib_ploughmach
tabulate equilentlender_par_ploughmach
tabulate equilentlender_nie_ploughmach
tabulate equilentlender_oth_ploughmach
tabulate equilentlender_nei_ploughmach
tabulate equilentlender_fri_ploughmach
tabulate equilentlender_cus_ploughmach
tabulate equilentlender_mon_ploughmach
tabulate equilentlender_shg_ploughmach
tabulate equilentlender_emp_ploughmach
tabulate equilentlender_wkp_ploughmach
tabulate equilentlender_own_ploughmach
tabulate equilentlender_spo_ploughmach 

summarize equiownnb_bullockcart 
summarize equiownyear_bullockcart 
tabulate equiownpay_inc_bullockcart
tabulate equiownpay_sav_bullockcart
tabulate equiownpay_ass_bullockcart
tabulate equiownpay_hel_bullockcart
tabulate equiownpay_sch_bullockcart
tabulate equiownpay_ngo_bullockcart
tabulate equiownpay_cre_bullockcart
tabulate equiownpay_wor_bullockcart 
summarize equiowncost_bullockcart equiownpledged_bullockcart equilentnb_bullockcart 
tabulate equilentlender_mai_bullockcart
tabulate equilentlender_chi_bullockcart
tabulate equilentlender_sib_bullockcart
tabulate equilentlender_par_bullockcart
tabulate equilentlender_nie_bullockcart
tabulate equilentlender_oth_bullockcart
tabulate equilentlender_nei_bullockcart
tabulate equilentlender_fri_bullockcart
tabulate equilentlender_cus_bullockcart
tabulate equilentlender_mon_bullockcart
tabulate equilentlender_shg_bullockcart
tabulate equilentlender_emp_bullockcart
tabulate equilentlender_wkp_bullockcart
tabulate equilentlender_own_bullockcart
tabulate equilentlender_spo_bullockcart 

****************************************
* END
log close




















log using "8-1_Expenses.log", nomsg replace
****************************************
* 8.1. Expenses
****************************************
use"NEEMSIS1-HH", clear

* Selection
keep HHID2016 foodexpenses healthexpenses ceremoniesexpenses ceremoniesrelativesexpenses deathexpenses demoexpenses democonsoless democonsoless_food democonsoless_tran democonsoless_clot democonsoless_heal democonsoless_educ democonsoless_gift democonsoless_func democonsoless_good democonsoless_none democonsomore democonsomore_food democonsomore_tran democonsomore_clot democonsomore_heal democonsomore_educ democonsomore_gift democonsomore_func democonsomore_good democonsomore_none democonsosame democonsosame_food democonsosame_tran democonsosame_clot democonsosame_heal democonsosame_educ democonsosame_gift democonsosame_func democonsosame_good democonsosame_none democonsopractices democonsopractices_lessless democonsopractices_lessbigg democonsopractices_card democonsopractices_morecred democonsopractices_lesscred democonsopractices_advance democonsopractices_nochange democonsoplace democonsoplace_moreins democonsoplace_lessins democonsoplace_moresur democonsoplace_lesssur democonsoplace_moreclo democonsoplace_nochang
duplicates drop

* Tables
summarize foodexpenses healthexpenses ceremoniesexpenses ceremoniesrelativesexpenses deathexpenses
tabulate demoexpenses
tabulate democonsoless_food
tabulate democonsoless_tran
tabulate democonsoless_clot
tabulate democonsoless_heal
tabulate democonsoless_educ
tabulate democonsoless_gift
tabulate democonsoless_func
tabulate democonsoless_good
tabulate democonsoless_none
tabulate democonsomore_food
tabulate democonsomore_tran
tabulate democonsomore_clot
tabulate democonsomore_heal
tabulate democonsomore_educ
tabulate democonsomore_gift
tabulate democonsomore_func
tabulate democonsomore_good
tabulate democonsomore_none
tabulate democonsosame_food
tabulate democonsosame_tran
tabulate democonsosame_clot
tabulate democonsosame_heal
tabulate democonsosame_educ
tabulate democonsosame_gift
tabulate democonsosame_func
tabulate democonsosame_good
tabulate democonsosame_none
tabulate democonsopractices_lessless
tabulate democonsopractices_lessbigg
tabulate democonsopractices_card
tabulate democonsopractices_morecred
tabulate democonsopractices_lesscred
tabulate democonsopractices_advance
tabulate democonsopractices_nochange
tabulate democonsoplace_moreins
tabulate democonsoplace_lessins
tabulate democonsoplace_moresur
tabulate democonsoplace_lesssur
tabulate democonsoplace_moreclo
tabulate democonsoplace_nochang

****************************************
* END
log close













log using "8-2_Goods.log", nomsg replace
****************************************
* 8.2. Goods
****************************************
use"NEEMSIS1-HH", clear

* Selection
keep HHID2016 listgoods numbergoods_car numbergoods_cookgas numbergoods_computer numbergoods_antenna numbergoods_bike numbergoods_fridge numbergoods_furniture numbergoods_tailormach numbergoods_phone numbergoods_landline numbergoods_DVD numbergoods_camera goodyearpurchased_car goodyearpurchased_cookgas goodyearpurchased_computer goodyearpurchased_antenna goodyearpurchased_bike goodyearpurchased_fridge goodyearpurchased_furniture goodyearpurchased_tailormach goodyearpurchased_phone goodyearpurchased_landline goodyearpurchased_DVD goodyearpurchased_camera goodtotalamount_car goodtotalamount_cookgas goodtotalamount_computer goodtotalamount_antenna goodtotalamount_bike goodtotalamount_fridge goodtotalamount_furniture goodtotalamount_tailormach goodtotalamount_phone goodtotalamount_landline goodtotalamount_DVD goodtotalamount_camera goodbuying_car goodbuying_cookgas goodbuying_computer goodbuying_antenna goodbuying_bike goodbuying_fridge goodbuying_furniture goodbuying_tailormach goodbuying_phone goodbuying_landline goodbuying_DVD goodbuying_camera goodsourcecredit_bike goodsourcecredit_tailormach goodcreditsettled_bike goodcreditsettled_tailormach
duplicates drop

* Tables
summarize numbergoods_car goodyearpurchased_car goodtotalamount_car
tabulate goodbuying_car

summarize numbergoods_cookgas goodyearpurchased_cookgas goodtotalamount_cookgas
tabulate goodbuying_cookgas

summarize numbergoods_computer goodyearpurchased_computer goodtotalamount_computer
tabulate goodbuying_computer

summarize numbergoods_antenna goodyearpurchased_antenna goodtotalamount_antenna
tabulate goodbuying_antenna

summarize numbergoods_bike goodyearpurchased_bike goodtotalamount_bike
tabulate goodbuying_bike
tabulate goodsourcecredit_bike
tabulate goodcreditsettled_bike

summarize numbergoods_fridge goodyearpurchased_fridge goodtotalamount_fridge
tabulate goodbuying_fridge

summarize numbergoods_furniture goodyearpurchased_furniture goodtotalamount_furniture
tabulate goodbuying_furniture

summarize numbergoods_tailormach goodyearpurchased_tailormach goodtotalamount_tailormach
tabulate goodbuying_tailormach
tabulate goodsourcecredit_tailormach
tabulate goodcreditsettled_tailormach

summarize numbergoods_phone goodyearpurchased_phone goodtotalamount_phone
tabulate goodbuying_phone

summarize numbergoods_landline goodyearpurchased_landline goodtotalamount_landline
tabulate goodbuying_landline

summarize numbergoods_DVD goodyearpurchased_DVD goodtotalamount_DVD
tabulate goodbuying_DVD

summarize numbergoods_camera goodyearpurchased_camera goodtotalamount_camera
tabulate goodbuying_camera

****************************************
* END
log close













log using "9_Marriage.log", nomsg replace
****************************************
* 9. Marriage
****************************************

********** Household
use"NEEMSIS1-HH", clear

* Selection
keep HHID2016 dummymarriage
duplicates drop

* Tables
tabulate dummymarriage



********** Individual
use"NEEMSIS1-HH", clear

* Tables
tabulate marriedlistdummy
tabulate husbandwifecaste
summarize marriagedowry marriagetotalcost
tabulate howpaymarriage
tabulate marriageloansource_wkp
tabulate marriageloansource_rela
tabulate marriageloansource_empl
tabulate marriageloansource_mais
tabulate marriageloansource_coll
tabulate marriageloansource_pawn
tabulate marriageloansource_shop
tabulate marriageloansource_fina
tabulate marriageloansource_frie
tabulate marriageloansource_shg
tabulate marriageloansource_bank
tabulate marriageloansource_coop
tabulate marriageloansource_sug
tabulate marriageloansource_gpfi
summarize marriageloannb_wellknown marriageloannb_banks marriageloannb_coopbanks marriageloannb_relatives marriageloannb_employer marriageloannb_maistry marriageloannb_colleagues marriageloannb_pawnbroker marriageloannb_monlender marriageloannb_friends marriageloanamount_wellknown marriageloanamount_banks marriageloanamount_coopbanks marriageloanamount_relatives marriageloanamount_employer marriageloanamount_maistry marriageloanamount_colleagues marriageloanamount_pawnbroker marriageloanamount_monlender marriageloanamount_friends
summarize marriageexpenses
tabulate dummymarriagegift
tabulate marriagegiftsource_wkp
tabulate marriagegiftsource_rela
tabulate marriagegiftsource_empl
tabulate marriagegiftsource_mais
tabulate marriagegiftsource_coll
tabulate marriagegiftsource_pawn
tabulate marriagegiftsource_shop
tabulate marriagegiftsource_fina
tabulate marriagegiftsource_frie
tabulate marriagegiftsource_shg
tabulate marriagegiftsource_bank
tabulate marriagegiftsource_coop
tabulate marriagegiftsource_sug
tabulate marriagegiftsource_gpfi
summarize marriagegiftnb_wellknown marriagegiftnb_shg marriagegiftnb_relatives marriagegiftnb_employer marriagegiftnb_maistry marriagegiftnb_colleagues marriagegiftnb_shopkeeper marriagegiftnb_friends 
tabulate marriagegifttype_wellknown
tabulate marriagegifttype_shg
tabulate marriagegifttype_relatives
tabulate marriagegifttype_employer
tabulate marriagegifttype_maistry
tabulate marriagegifttype_colleagues
tabulate marriagegifttype_shopkeeper
tabulate marriagegifttype_friends
summarize marriagegiftamount_wellknown marriagegiftamount_shg marriagegiftamount_relatives marriagegiftamount_employer marriagegiftamount_maistry marriagegiftamount_colleagues marriagegiftamount_shopkeeper marriagegiftamount_friends marriagegoldamount_wellknown marriagegoldamount_relatives marriagegoldamount_employer marriagegoldamount_friends

****************************************
* END
log close
















log using "10_Housing.log", nomsg replace
****************************************
* 10. Housing and facilities
****************************************
use"NEEMSIS1-HH", clear

* Selection
keep HHID2016 house howbuyhouse_* rentalhouse housevalue housetype housesize houseroom housetitle ownotherhouse otherhouserent otherhousevalue dummysaleproperty incomesaleproperty useincomesaleproperty electricity water toiletfacility noowntoilet
duplicates drop 

* Tables
tabulate house
tabulate howbuyhouse_here
tabulate howbuyhouse_savi
tabulate howbuyhouse_bank
tabulate howbuyhouse_cred
tabulate howbuyhouse_fina
tabulate howbuyhouse_help
tabulate howbuyhouse_sche
summarize rentalhouse housevalue
tabulate housetype
summarize housesize houseroom
tabulate housetitle
tabulate ownotherhouse
summarize otherhouserent otherhousevalue
tabulate dummysaleproperty
summarize incomesaleproperty
tabulate useincomesaleproperty
tabulate electricity
tabulate water
tabulate toiletfacility
tabulate noowntoilet

****************************************
* END
log close












log using "11_Schemes.log", nomsg replace
****************************************
* 11. Schemes
****************************************
********** Household
use"NEEMSIS1-HH", clear

* Selection
keep HHID2016 schemeslist_nrega schemeslist_ratio schemeslist_house schemeslist_funer schemeslist_anima schemeslist_lpgga schemeslist_educa schemeslist_farme schemeslist_land schemeslist_sewin schemeslist_camar schemeslist_gomar schemeslist_oldpe schemeslist_widpe schemeslist_mater schemeslist_disab schemeslist_retir schemeslist_none rationcardnber rationcardmembers rationcarduse rationcardreasonnouse housingscheme housingschemetype housingschemeamount housingschemedate landschemesize landschemeyearbenefited schemeyear_funer schemeamount_funer schemeyear_anima schemeamount_anima schemeyear_lpgga schemeamount_lpgga schemeyear_educa schemeamount_educa schemeyear_farme schemeamount_farme demoscheme_*
duplicates drop


* Tables
tabulate schemeslist_nrega
tabulate schemeslist_ratio
tabulate schemeslist_house
tabulate schemeslist_funer
tabulate schemeslist_anima
tabulate schemeslist_lpgga
tabulate schemeslist_educa
tabulate schemeslist_farme
tabulate schemeslist_land
tabulate schemeslist_sewin
tabulate schemeslist_camar
tabulate schemeslist_gomar
tabulate schemeslist_oldpe
tabulate schemeslist_widpe
tabulate schemeslist_mater
tabulate schemeslist_disab
tabulate schemeslist_retir
tabulate schemeslist_none

summarize rationcardnber rationcardmembers
tabulate rationcarduse
tabulate rationcardreasonnouse
tabulate housingscheme
tabulate housingschemetype
summarize housingschemeamount
tabulate housingschemedate
summarize landschemesize
tabulate landschemeyearbenefited
tabulate schemeyear_funer
summarize schemeamount_funer
tabulate schemeyear_anima
summarize schemeamount_anima
tabulate schemeyear_lpgga
summarize schemeamount_lpgga
tabulate schemeyear_educa
summarize schemeamount_educa
tabulate schemeyear_farme
summarize schemeamount_farme

tabulate demoscheme_nrega
tabulate demoscheme_ratio
tabulate demoscheme_house
tabulate demoscheme_funer
tabulate demoscheme_anima
tabulate demoscheme_lpgga
tabulate demoscheme_educa
tabulate demoscheme_farme
tabulate demoscheme_land
tabulate demoscheme_sewin
tabulate demoscheme_camar
tabulate demoscheme_gomar
tabulate demoscheme_oldpe
tabulate demoscheme_widpe
tabulate demoscheme_mater
tabulate demoscheme_disab
tabulate demoscheme_retir
tabulate demoscheme_none



****************************************
* END
log close











log using "12_Schemesind.log", nomsg replace
****************************************
* 11. Schemes individual level
****************************************
use"NEEMSIS1-HH", clear

* Selection
keep HHID2016 INDID2016 ///
schemerecipientdummy_sewin schemeyear_sewin schemeamount_sewin ///
schemerecipientdummy_camar schemeyear_camar schemeamount_camar ///
schemerecipientdummy_gomar schemeyear_gomar schemeamount_gomar ///
pensionrecipientdummy_old pensionamount_old ///
pensionrecipientdummy_wid pensionamount_wid ///
pensionrecipientdummy_mat pensionamount_mat ///
pensionrecipientdummy_dis pensionamount_dis ///
pensionrecipientdummy_ret pensionamount_ret

* Tables
tabulate schemerecipientdummy_sewin
tabulate schemeyear_sewin
summarize schemeamount_sewin
tabulate schemerecipientdummy_camar
tabulate schemeyear_camar
summarize schemeamount_camar
tabulate schemerecipientdummy_gomar
tabulate schemeyear_gomar
summarize schemeamount_gomar

tabulate pensionrecipientdummy_old
summarize pensionamount_old
tabulate pensionrecipientdummy_wid
summarize pensionamount_wid
tabulate pensionrecipientdummy_mat
summarize pensionamount_mat
tabulate pensionrecipientdummy_dis
summarize pensionamount_dis
tabulate pensionrecipientdummy_ret
summarize pensionamount_ret

****************************************
* END
log close















log using "13_Nrega.log", nomsg replace
****************************************
* 11. NREGA
****************************************
use"NEEMSIS1-HH", clear

* Tables
tabulate nregarecipientlistdummy
summarize nreganberdaysworked nregaincome


****************************************
* END
log close














