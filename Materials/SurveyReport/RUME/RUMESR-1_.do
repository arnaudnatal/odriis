*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 10, 2023
*-----
*RUME survey report
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\Materials\SurveyReport\RUME"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (IRD)\RUME II\9. En cours\RUME_report\analysis"
cd"$directory"
********** Database names
global household = "RUME-HH"
global loans = "RUME-loans_mainloans"
global occupations = "RUME-occupations"
global lenders = "RUME-lenders"
********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid
********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020
*-------------------------






****************************************
* Merge key + caste corr
****************************************
use"raw/$household", clear

* HHID_panel and INDID_panel
merge 1:m HHID2010 INDID2010 using "raw/keypanel-indiv_wide", keepusing(HHID_panel INDID_panel)
keep if _merge==3
drop _merge
order HHID_panel INDID_panel HHID2010 INDID2010

* Caste
merge m:1 HHID_panel using "raw/Panel-Caste_HH", keepusing(jatis2010 jatiscorr2010 caste2010)
keep if _merge==3
drop _merge

save "RUME-HH", replace
****************************************
* END










****************************************
* Caste module
****************************************
use"RUME-HH", clear

keep HHID2010 caste jatis caste2010 jatis2010 jatiscorr2010
duplicates drop
ta jatis jatis2010


* Check jatis to caste
ta jatis caste
ta jatiscorr2010 caste2010


****************************************
* END









log using "0_Introduction.log", nomsg replace
****************************************
* 0. Introduction
****************************************
use"RUME-HH", clear

* Selection
keep HHID2010 village villagearea jatis caste religion comefrom outsider 
duplicates drop

* Tables
tabulate village
tabulate villagearea
tabulate jatis
tabulate caste
tabulate religion
tabulate comefrom
tabulate outsider

****************************************
* END
log close












log using "1_Family.log", nomsg replace
****************************************
* 1. Family members
****************************************
use"RUME-HH", clear

* Tables
tabulate sex
summarize age
tabulate relationshiptohead
tabulate livinghome
tabulate education
tabulate studentpresent
tabulate typeeducation

****************************************
* END
log close






log using "2_Employment.log", nomsg replace
****************************************
* 2. Employment
****************************************

********** Workers
use"RUME-HH", clear

* Tables
tabulate dummyworkedpastyear



********** Occupations
use"RUME-occupations", clear

* Tables
tabulate kindofwork
summarize annualincome
tabulate stopworking

****************************************
* END
log close









log using "21_Selfemployment.log", nomsg replace
****************************************
* 2.1. Self-employment
****************************************
use"RUME-HH", clear

********** Business
* Selection
keep HHID2010 INDID2010 kindselfemployment* businesscastebased* yearestablishment* businessamountinvest* businesssourceinvest* businesslender* relativesbusinesslender* castebusinesslender* lossbusinessinvest* businessskill*
reshape long kindselfemployment businesscastebased yearestablishment businessamountinvest businesssourceinvest businesslender relativesbusinesslender castebusinesslender lossbusinessinvest businessskill, i(HHID2010 INDID2010) j(n)
drop if kindselfemployment==""

* Tables
tabulate businesscastebased
tabulate yearestablishment
summarize businessamountinvest
tabulate businesssourceinvest
tabulate businesslender
tabulate relativesbusinesslender
tabulate castebusinesslender
tabulate lossbusinessinvest
tabulate businessskill



********** Income
use"RUME-HH", clear

* Selection
keep HHID2010 INDID2010 goodincomeperiod* goodincomeperiodnbmonth* goodincomeamount* averageincomeperiod* averageincomeperiodnbmonth* averageincomeperiodamount* lowincomeperiod* lowincomeperiodnbmonth* lowincomeperiodamount*
reshape long goodincomeperiod goodincomeperiodnbmonth goodincomeamount averageincomeperiod averageincomeperiodnbmonth averageincomeperiodamount lowincomeperiod lowincomeperiodnbmonth lowincomeperiodamount, i(HHID2010 INDID2010) j(n)
drop if goodincomeperiod==""

* Tables
tabulate goodincomeperiod
summarize goodincomeperiodnbmonth goodincomeamount
tabulate averageincomeperiod
summarize averageincomeperiodnbmonth averageincomeperiodamount
tabulate lowincomeperiod
summarize lowincomeperiodnbmonth lowincomeperiodamount



********** Business labourers
use"RUME-HH", clear

* Tables
tabulate dummybusinesslabourers



********** Details business labourers
use"RUME-HH", clear

* Selection
keep HHID2010 INDID2010 namebusinesslabourer* relationshipbusinesslabourer* castebusinesslabourer* businesslabourertypejob* businesslabourerwagetype* businesslabourerbonus* businesslabourerinsurance* businesslabourerpension*
reshape long namebusinesslabourer relationshipbusinesslabourer castebusinesslabourer businesslabourertypejob businesslabourerwagetype businesslabourerbonus businesslabourerinsurance businesslabourerpension, i(HHID2010 INDID2010) j(n)
drop if namebusinesslabourer==""

* Tables
tabulate relationshipbusinesslabourer
tabulate castebusinesslabourer
tabulate businesslabourertypejob
tabulate businesslabourerwagetype
tabulate businesslabourerbonus
tabulate businesslabourerinsurance
tabulate businesslabourerpension



********** Sell the product or service on credit basis
use"RUME-HH", clear

* Selection
keep HHID2010 INDID2010 creditsell* creditperiod* creditcope* creditpercentage* creditbuy*
reshape long creditsell creditperiod creditcope creditpercentage creditbuy, i(HHID2010 INDID2010) j(n)
drop if creditsell==.

* Tables
tabulate creditsell
tabulate creditperiod
tabulate creditcope
summarize creditpercentage
tabulate creditbuy



********** Business in the past
use"RUME-HH", clear

* Tables
tabulate dummypastbusiness
tabulate pastbusinesstype
*tabulate pastbusinessreasonstopped



********** Doing own business
use"RUME-HH", clear

* Tables
tabulate ownbusinessinterested
*tabulate ownbusinesstype
tabulate ownbusinessinvest
summarize ownbusinessinvestamount if ownbusinessinvestamount!=99
tabulate ownbusinesseduc
tabulate ownbusinessexpe
tabulate ownbusinessmarket
tabulate ownbusinessmanpower

****************************************
* END
log close












log using "22_Salaried.log", nomsg replace
****************************************
* 2.2. Salaried
****************************************
use"RUME-HH", clear

* Selection
keep HHID2010 INDID2010 joblocation* jobdistance* kindsalariedjob* casteemployer* relationemployer* salariedjobtype* salariedjobfulltime* salariedwagetype* salariedjobdays* salariedjobsalary* salariedjobpension* salariedjobbonus* salariedjobinsurance* salariedjobtenure* sjdummyadvance* sjadvancebalance* sjadvanceamount* salariedjobhow* salariedjobhowknow*
reshape long joblocation jobdistance kindsalariedjob casteemployer relationemployer salariedjobtype salariedjobfulltime salariedwagetype salariedjobdays salariedjobsalary salariedjobpension salariedjobbonus salariedjobinsurance salariedjobtenure sjdummyadvance sjadvancebalance sjadvanceamount salariedjobhow salariedjobhowknow, i(HHID2010 INDID2010) j(n)
drop if joblocation==""

* Tables
summarize jobdistance
tabulate casteemployer
tabulate relationemployer
tabulate salariedjobtype
tabulate salariedjobfulltime
tabulate salariedwagetype
tabulate salariedjobbonus
tabulate salariedjobinsurance
tabulate salariedjobpension
summarize salariedjobtenure salariedjobdays salariedjobsalary
tabulate sjdummyadvance
tabulate sjadvancebalance
summarize sjadvanceamount
tabulate salariedjobhow if salariedjobhow!=0 & salariedjobhow!=8
tabulate salariedjobhowknow if salariedjobhowknow!=0

****************************************
* END
log close








log using "23_Crisis.log", nomsg replace
****************************************
* 2.3. Problems in your work since 2008
****************************************
use"RUME-HH", clear

* Tables
tabulate crisislostjob
tabulate crisislesswork
tabulate crisiskindofwork
tabulate crisislocation1
tabulate crisislocation2

****************************************
* END
log close








log using "3_Migration.log", nomsg replace
****************************************
* 3. Migration
****************************************
* Household
use"RUME-HH", clear
keep HHID2010 dummymigration
duplicates drop
tabulate dummymigration

* Selection
use"RUME-HH", clear
keep HHID2010 INDID2010 migrationduration* migrationdurationmonth* migrationplace* migrationdistance* migrationusually* migrationtravelcost* migrationtravelpayment* migrationjoblist* migrationtenure* migrationfindjob* migrationhelped* migrationhelpedrelatives* migrationjobtype* migrationjobtypetwo* migrationwagetype* dummyadvance* migrationadvanceprovider* migrationadvanceamount* dummyadvancebalance* migrationsalary* migrationpension* migrationbonus* migrationinsurance*
reshape long migrationduration migrationdurationmonth migrationplace migrationdistance migrationusually migrationtravelcost migrationtravelpayment migrationjoblist migrationtenure migrationfindjob migrationhelped migrationhelpedrelatives migrationjobtype migrationjobtypetwo migrationwagetype dummyadvance migrationadvanceprovider migrationadvanceamount dummyadvancebalance migrationsalary migrationpension migrationbonus migrationinsurance, i(HHID2010 INDID2010) j(n)
drop if migrationduration==""

* Tables
tabulate migrationjoblist
tabulate migrationplace
summarize migrationdistance
tabulate migrationusually
tabulate migrationduration
summarize migrationdurationmonth migrationtravelcost
tabulate migrationtravelpayment
summarize migrationtenure
tabulate migrationfindjob
tabulate migrationhelped
tabulate migrationhelpedrelatives
tabulate migrationjobtype
tabulate migrationjobtypetwo
tabulate migrationwagetype
tabulate dummyadvance
tabulate migrationadvanceprovider
summarize migrationadvanceamount
tabulate dummyadvancebalance
summarize migrationsalary
tabulate migrationpension
tabulate migrationbonus
tabulate migrationinsurance

****************************************
* END
log close









log using "41_Remittancesreceived.log", nomsg replace
****************************************
* 4.1. Remittances received
****************************************
* Household
use"RUME-HH", clear
keep HHID2010 dummyremrec
duplicates drop
tabulate dummyremrec

* Selection
use"RUME-HH", clear
keep HHID2010 INDID2010 remrecsourcename1* remrecourcerelation* remrecsourceplace* remrecfrequency* remrectotalamount* remrecproduct* remrectotalvalue* remrechow* remrecreduc*
reshape long remrecsourcename1 remrecourcerelation remrecsourceplace remrecfrequency remrectotalamount remrecproduct remrectotalvalue remrechow remrecreduc, i(HHID2010 INDID2010) j(n)
drop if remrecsourcename1==""

* Tables
tabulate remrecourcerelation
tabulate remrecfrequency
summarize remrectotalamount
tabulate remrecproduct
summarize remrectotalvalue
tabulate remrechow
tabulate remrecreduc

****************************************
* END
log close









log using "42_Remittancessent.log", nomsg replace
****************************************
* 4.2. Remittances sent
****************************************
* Household
use"RUME-HH", clear
keep HHID2010 dummyremsent
duplicates drop 
tabulate dummyremsent

* Selection
use"RUME-HH", clear
keep HHID2010 INDID2010 remsentname1* remsentlocation* remsentname1* remsenttotalamount* remsentfrequency*
reshape long remsentname1 remsentlocation remsentname1 remsenttotalamount remsentfrequency, i(HHID2010 INDID2010) j(n)
drop if remsentname1==.

* Tables
tabulate remsentname1
tabulate remsentrelation
summarize remsenttotalamount
tabulate remsentfrequency

****************************************
* END
log close










log using "512_Loans.log", nomsg replace
****************************************
* 5.1. Loans and mains loans (5.2)
****************************************
* Household
use"RUME-HH", clear
keep HHID2010 dummyloans
duplicates drop
tabulate dummyloans


********** Loans database
use"RUME-loans_mainloans", clear

* Tables
tabulate loandate
summarize loanamount
tabulate loanreasongiven
tabulate loanlender
tabulate lenderrelatives
tabulate lenderscaste
tabulate lendernativevillage
tabulate lenderrelation
tabulate otherlenderservices
tabulate otherlenderservices2
tabulate loansettled
summarize loanbalance

* Tables main loans
tabulate dummymainloan
tabulate borrowerservices
tabulate effectiveamount
summarize effectivereceived
tabulate amountreceivedmanage
tabulate organiseexpense1
tabulate organiseexpense2
tabulate plantorepay1
tabulate plantorepay2
tabulate plantorepay3
summarize timegetcredit amountgetcredit timewentgetcredit
tabulate datecredittaken
summarize periodwaited
tabulate durationgivenbyyou
tabulate durationgivenbymoneylender
tabulate durationtook
tabulate dummyinterest
summarize interestloan
tabulate interestfrequency
summarize interestpaid principalpaid
tabulate dummyrecommendation
tabulate dummyguarantor
tabulate recommenddetailscaste
tabulate guarantordetailscaste
tabulate recommendloanrelation
tabulate guarantorloanrelation
tabulate samepersonreco
tabulate samepersonguarantor
tabulate dummyguarantee
tabulate loanproductpledgecat
summarize loanproductpledgeamount
tabulate guarantee
tabulate guaranteetype
summarize totalrepaidprincipal
tabulate totalrepaiddummyinterest
summarize totalrepaidinterest
tabulate repayduration1
tabulate repaydecision
tabulate termsofrepayment
tabulate problemrepayment
tabulate dummyrepaysoldproduct
tabulate repaysoldproduct1
tabulate repaysoldproduct2
summarize repaycreditamount
tabulate dummyrepaytakejob
tabulate dummysettleloanworkmore
tabulate helptosettleloan
tabulate helptosettleloanrelatives
tabulate problemdelayrepayment
tabulate lenderaction
tabulate loanfromthesameperson

****************************************
* END
log close












log using "53_Lenders.log", nomsg replace
****************************************
* 5.3. Lenders
****************************************
use"RUME-lenders", clear

* Tables
tabulate mltype
summarize mlfrequency
tabulate mlaction1
tabulate mlaction2
tabulate mlaction3
tabulate mlcontinue
tabulate mlstop
tabulate mlstopyear if mlstop==1
summarize mlnberasked if mlstop==1
tabulate mlstopreason if mlstop==1
tabulate mlstrength1
tabulate mlstrength2
tabulate mlstrength3
tabulate mlweakness1
tabulate mlweakness2
tabulate mlweakness3

****************************************
* END
log close













log using "54_Creditonproduct.log", nomsg replace
****************************************
* 5.4. Credit on product
****************************************
use"RUME-HH", clear

* Selection
keep HHID2010 INDID2010 productname* productlender* productloanamount* productloansettled*
reshape long productname productlender productloanamount productloansettled, i(HHID2010 INDID2010) j(n)
drop if productname==""

* Tables
tabulate productlender
summarize productloanamount
tabulate productloansettled

****************************************
* END
log close












log using "55_Lending.log", nomsg replace
****************************************
* 5.5. Lending money
****************************************
* Household
use"RUME-HH", clear
keep HHID2010 dummylendingmoney
duplicates drop
tabulate dummylendingmoney 


* Selection
use"RUME-HH", clear
keep HHID2010 INDID2010 borrowerscaste* relationwithborrower* amountlent* interestlending* purposeloanborrower* problemrepayment*
reshape long borrowerscaste relationwithborrower amountlent interestlending purposeloanborrower problemrepayment, i(HHID2010 INDID2010) j(n)
drop if borrowerscaste==.

* Tables
tabulate borrowerscaste
tabulate relationwithborrower
summarize amountlent interestlending
tabulate purposeloanborrower
tabulate problemrepayment

****************************************
* END
log close











log using "56_Lending.log", nomsg replace
****************************************
* 5.6. Given recommendation
****************************************
* Household
use"RUME-HH", clear
keep HHID2010 dummyrecommendgiven
duplicates drop 
tabulate dummyrecommendgiven

* Selection
use"RUME-HH", clear
keep HHID2010 INDID2010 recommendgivenlist* recommendgivenrelation* recommendgivencaste* dummyrecommendback* recommendgivenlender* recommendgivenlendercaste*
reshape long recommendgivenlist recommendgivenrelation recommendgivencaste dummyrecommendback recommendgivenlender recommendgivenlendercaste, i(HHID2010 INDID2010) j(n)
drop if recommendgivenlist==.

* Tables
tabulate recommendgivenlist
tabulate recommendgivenrelation
tabulate recommendgivencaste
tabulate dummyrecommendback
tabulate recommendgivenlender
tabulate recommendgivenlendercaste

****************************************
* END
log close











log using "57_Recommendation.log", nomsg replace
****************************************
* 5.7. Recommendation received
****************************************
use"RUME-HH", clear

* Selection
keep HHID2010 dummyrecommendrefuse reasonrefuserecommendcat reasonrefuserecommend repaycreditpersoreco repaycreditpersorecoamount repaycreditpersorecorelation repaycreditpersorecocaste repaycreditpersorecoborrower repaycreditpersorecomanage receivereco
duplicates drop

* Tables
tabulate dummyrecommendreceived
tabulate dummyrecommendrefuse
tabulate reasonrefuserecommendcat
tabulate reasonrefuserecommend
tabulate repaycreditpersoreco
tabulate repaycreditpersorecoamount
tabulate repaycreditpersorecorelation
tabulate repaycreditpersorecocaste
tabulate repaycreditpersorecoborrower
tabulate repaycreditpersorecomanage
tabulate receivereco

****************************************
* END
log close













log using "58_Chitfund.log", nomsg replace
****************************************
* 5.8. Chit fund
****************************************
* Household
use"RUME-HH", clear
keep HHID2010 dummychitfund 
duplicates drop
tabulate dummychitfund

* Individual
use"RUME-HH", clear
tabulate chitfundbelongerdummy

* Selection
keep HHID2010 INDID2010 chitfundtype* durationchit* nbermemberchit* chitfundpayment* chitfundamount*
reshape long chitfundtype durationchit nbermemberchit chitfundpayment chitfundamount, i(HHID2010 INDID2010) j(n)
drop if chitfundtype==.

* Tables
tabulate chitfundtype
summarize durationchit nbermemberchit
tabulate chitfundpayment
summarize chitfundamount

****************************************
* END
log close

















log using "59_Savings.log", nomsg replace
****************************************
* 5.9. Savings
****************************************
* Household
use"RUME-HH", clear
keep HHID2010 dummysavingaccount 
duplicates drop
tabulate dummysavingaccount

* Individual
use"RUME-HH", clear
tabulate savingsownerdummy

* Selection
keep HHID2010 INDID2010 savingsbankname* savingsbankplace* savingsamount* savingspurposeone* savingspurposetwo* dummydebitcard* dummycreditcard*
reshape long savingsbankname savingsbankplace savingsamount savingspurposeone savingspurposetwo dummydebitcard dummycreditcard, i(HHID2010 INDID2010) j(n)
drop if savingsbankname==""

* Tables
tabulate savingsbankname
summarize savingsamount
tabulate savingspurposeone
tabulate savingspurposetwo
tabulate dummydebitcard
tabulate dummycreditcard

****************************************
* END
log close












log using "510_Gold.log", nomsg replace
****************************************
* 5.10. Gold
****************************************
use"RUME-HH", clear


* Selection
keep HHID2010 goldquantity goldquantitypledge goldamountpledge
duplicates drop

* Tables
summarize goldquantity goldquantitypledge goldamountpledge

****************************************
* END
log close









log using "511_Insurance.log", nomsg replace
****************************************
* 5.11. Insurance
****************************************
* Household
use"RUME-HH", clear
keep HHID2010 dummyinsurance
duplicates drop
tabulate dummyinsurance

* Individual
use"RUME-HH", clear
tabulate insuranceownerdummy

* Selection
keep HHID2010 INDID2010 insurancename* insurancetypetwo* insurancebenefit* insurancejoineddate*
reshape long insurancename insurancetypetwo insurancebenefit insurancejoineddate, i(HHID2010 INDID2010) j(n)
drop if insurancename==""

* Tables
tabulate insurancename
tabulate insurancetypetwo
tabulate insurancebenefit
tabulate insurancejoineddate

****************************************
* END
log close













log using "61_Land.log", nomsg replace
****************************************
* 6.1. Land group
****************************************
use"RUME-HH", clear

* Selection
keep HHID2010 ownland sizeownland drywetownland waterfromownland leaseland sizeleaseland drywetleaseland waterfromleaseland dummylandpurchased landpurchasedacres landpurchasedamount landpurchasedhowbuy dummyleasedland landleasername landleasercaste landleaserrelation dummyleasingland landleasingname landleasingcaste landleasingrelation productlist1 productacre1 producttypeland1 productnbbags1 productpricebag1 productpricesold1 productexpenses1 productlabourcost1 productlist2 productacre2 producttypeland2 productnbbags2 productpricebag2 productpricesold2 productexpenses2 productlabourcost2 productlist3 productacre3 producttypeland3 productnbbags3 productpricebag3 productpricesold3 productexpenses3 productlabourcost3 productlist4 productacre4 producttypeland4 productnbbags4 productpricebag4 productpricesold4 productexpenses4 productlabourcost4 productlist5 productacre5 producttypeland5 productnbbags5 productpricebag5 productpricesold5 productexpenses5 productlabourcost5 productlistintstop1 productintstop1 productintstopreason1 productintstopyear1 productlistintstop2 productintstop2 productintstopreason2 productintstopyear2 productlistintstop3 productintstop3 productintstopreason3 productintstopyear3 productlistintstop4 productintstop4 productintstopreason4 productintstopyear4 otherproductname1 otherproductsold1 otherproductown1 otherproductname2 otherproductsold2 otherproductown2 dummylabourers productworkers productlabourwage productoriginlabourers productcastelabourers1 productcastelabourers2 productcastelabourers3 dummylivestock livestocknb_cow livestockprice_cow livestockuse1_cow livestockuse2_cow livestockuse3_cow livestocknb_goat livestockprice_goat livestockuse1_goat livestockuse2_goat livestockuse3_goat dummycattleloss cattlelossnb howlost cattlelossamount cattleinsurance cattleinsuranceamount dummymedicalexpenses medicalexpensesamount notinterestedrearing1 notinterestedrearingreason1 notinterestedrearing2 notinterestedrearingreason2 interestedrearing1 interestedrearingreason1 interestedrearing2 interestedrearingreason2 equipmentlist1 equipmentnb1 equipementyear1 equipmentpay1 equipmentlender1 equipmentcost1 equipmentpledged1 equipmentlist2 equipmentnb2 equipementyear2 equipmentpay2 equipmentlender2 equipmentcost2 equipmentpledged2
duplicates drop

* Tables
tabulate ownland
summarize sizeownland
tabulate drywetownland
tabulate waterfromownland
tabulate leaseland
summarize sizeleaseland
tabulate drywetleaseland
tabulate waterfromleaseland
tabulate dummylandpurchased
summarize landpurchasedacres if landpurchasedacres!=88 & landpurchasedacres!=99
summarize landpurchasedamount
tabulate landpurchasedhowbuy
tabulate dummyleasedland
tabulate landleasercaste
tabulate landleaserrelation
tabulate dummyleasingland
tabulate landleasingcaste
tabulate landleasingrelation

****************************************
* END
log close




















log using "62_Crops.log", nomsg replace
****************************************
* 6.2. Crops
****************************************
use"RUME-HH", clear

* Selection
keep HHID2010 productlist1 productacre1 producttypeland1 productnbbags1 productpricebag1 productpricesold1 productexpenses1 productlabourcost1 productlist2 productacre2 producttypeland2 productnbbags2 productpricebag2 productpricesold2 productexpenses2 productlabourcost2 productlist3 productacre3 producttypeland3 productnbbags3 productpricebag3 productpricesold3 productexpenses3 productlabourcost3 productlist4 productacre4 producttypeland4 productnbbags4 productpricebag4 productpricesold4 productexpenses4 productlabourcost4 productlist5 productacre5 producttypeland5 productnbbags5 productpricebag5 productpricesold5 productexpenses5 productlabourcost5 
duplicates drop
reshape long productlist productacre producttypeland productnbbags productpricebag productpricesold productexpenses productlabourcost, i(HHID2010) j(n)
drop if productlist==.

* Tables
tabulate productlist
summarize productacre
tabulate producttypeland
summarize productnbbags productpricebag
summarize productpricesold if productpricesold!=88 & productpricesold!=99
summarize productexpenses if productexpenses!=99
summarize productlabourcost if productlabourcost!=99

****************************************
* END
log close








log using "62_Cropsstoppedinterested.log", nomsg replace
****************************************
* 6.2. Crops stopped or interested
****************************************
use"RUME-HH", clear

* Selection
keep HHID2010 productlistintstop1 productintstop1 productintstopreason1 productintstopyear1 productlistintstop2 productintstop2 productintstopreason2 productintstopyear2 productlistintstop3 productintstop3 productintstopreason3 productintstopyear3 productlistintstop4 productintstop4 productintstopreason4 productintstopyear4
duplicates drop
reshape long productlistintstop productintstop productintstopreason productintstopyear, i(HHID2010) j(n)
drop if productlistintstop==.

* Tables
tabulate productlistintstop
tabulate productintstop
summarize productintstopyear if productintstopyear!=99

****************************************
* END
log close








log using "62_Othersproducts.log", nomsg replace
****************************************
* 6.2. Other products
****************************************
use"RUME-HH", clear

* Selection
keep HHID2010 otherproductname1 otherproductsold1 otherproductown1 otherproductname2 otherproductsold2 otherproductown2 



****************************************
* END
log close












log using "62_Labourers.log", nomsg replace
****************************************
* 6.2. Labourers
****************************************
use"RUME-HH", clear

* Selection
keep HHID2010 dummylabourers productworkers productlabourwage productoriginlabourers productcastelabourers1 productcastelabourers2 productcastelabourers3

****************************************
* END
log close















log using "63_Livestock.log", nomsg replace
****************************************
* 6.3. Livestock
****************************************
use"RUME-HH", clear

* Selection
keep HHID2010 dummylivestock livestocknb_cow livestockprice_cow livestockuse1_cow livestockuse2_cow livestockuse3_cow livestocknb_goat livestockprice_goat livestockuse1_goat livestockuse2_goat livestockuse3_goat dummycattleloss cattlelossnb howlost cattlelossamount cattleinsurance cattleinsuranceamount dummymedicalexpenses medicalexpensesamount notinterestedrearing1 notinterestedrearingreason1 notinterestedrearing2 notinterestedrearingreason2 interestedrearing1 interestedrearingreason1 interestedrearing2 interestedrearingreason2 
duplicates drop

* Tables
tabulate dummylivestock

****************************************
* END
log close














log using "64_Equipment.log", nomsg replace
****************************************
* 6.4. Equipment
****************************************
use"RUME-HH", clear

* Selection
use"RUME-HH", clear
keep HHID2010 equipmentlist1 equipmentnb1 equipementyear1 equipmentpay1 equipmentlender1 equipmentcost1 equipmentpledged1 equipmentlist2 equipmentnb2 equipementyear2 equipmentpay2 equipmentlender2 equipmentcost2 equipmentpledged2
duplicates drop

****************************************
* END
log close











