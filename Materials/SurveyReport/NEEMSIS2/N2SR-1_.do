*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 01, 2023
*-----
*NEEMSIS-2 survey report
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\Materials\SurveyReport\NEEMSIS2"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (IRD)\RUME II\9. En cours\NEEMSIS2_report\analysis"
cd"$directory"
********** Database names
global household = "NEEMSIS2-HH"
global loans = "NEEMSIS2-loans_mainloans"
global occupations = "NEEMSIS2-occupations"
global migrations = "NEEMSIS2-migrations"
global egos = "NEEMSIS2-ego"
global alters = "NEEMSIS2-alters"
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
* Education module
****************************************
use"raw/$household", clear



*** Basic selection to remove those who were not here in 20202-21
drop if dummylefthousehold==1
drop if livinghome==3
drop if livinghome==4



*** General
drop if age<=5
ta canread
ta everattendedschool
ta converseinenglish


*** For those who have attended school
preserve
keep if everattendedschool==1
*
ta classcompleted
restore


*** After 10th standard
preserve
keep if everattendedschool==1
keep if classcompleted>9
*
ta after10thstandard
restore


*** After 12th standard
preserve
keep if everattendedschool==1
keep if classcompleted>12
keep if after10thstandard<3
*
ta durationafter10th
restore


*** Type of higher edu
preserve
keep if everattendedschool==1
keep if classcompleted>9
keep if after10thstandard==1 | after10thstandard==2
*
ta typeofhigheredu
restore


*** Subject after 10th standard
preserve
keep if everattendedschool==1
keep if classcompleted>9
keep if after10thstandard!=5
*
ta subjectsafter10th
ta othersubjectsafter10th
restore


*** Training
preserve
keep if age>=25
*
ta newtraining
restore


*** Reservation
preserve
keep if everattendedschool==1
*
ta reservation
restore


*** Reservation details
preserve
keep if everattendedschool==1
keep if reservation==1
*
ta reservationgrade
ta reservationkind
ta reservationother
restore


*** Currently at school
preserve
keep if everattendedschool==1 | newtraining==1
*
ta currentlyatschool
restore


*** Currently at school details
preserve
keep if everattendedschool==1 | newtraining==1
keep if currentlyatschool==1
*
sum educationexpenses amountschoolfees bookscost transportcost
restore


*** For those who have never attended school
preserve
keep if everattendedschool==0
*
ta reasonneverattendedschool
*ta otherreasonneverattendedschool
restore


*** For those who have dropped school
preserve
keep if currentlyatschool==0
*
ta reasondropping
ta otherreasondroppingschool
restore


*** COVID
preserve
keep if strpos(reasondropping,"15") | currentlyatschool==1
*
ta covgoingbackschool
restore


*** Decision dropping
preserve
keep if everattendedschool==0 | currentlyatschool==0
*
ta decisiondropping
ta decisiondroppingother
restore


*** Scholarship
preserve
keep if everattendedschool==1
*
ta dummyscholarship
restore


*** Scholarship details
preserve
keep if everattendedschool==1
keep if dummyscholarship==1
*
sum scholarshipamount scholarshipduration
restore

****************************************
* END













****************************************
* Employment module
****************************************
use"raw/$household", clear



*** Basic selection to remove those who were not here in 20202-21
drop if dummylefthousehold==1
drop if livinghome==3
drop if livinghome==4
drop if age<15



*** Workers
ta dummyworkedpastyear
ta reservationemployment


*** Non-workers
preserve
keep if dummyworkedpastyear==0
*
ta reasonnotworkpastyear
ta stoppedworking
restore

*** Work past 6 month
preserve
keep if dummyworkedpastyear==0
keep if reasonnotworkpastyear==2 | reasonnotworkpastyear==5 | reasonnotworkpastyear==6
*
ta workpastsixmonth
restore


*** Ever work
preserve
keep if dummyworkedpastyear==0
*
ta everworksalaried
restore

*** Ever work details
preserve
keep if dummyworkedpastyear==0
keep if everworksalaried==1
*
ta kindofworkinactive
restore


****************************************
* END














****************************************
* Migration module
****************************************
use"raw/$household", clear



*** Basic selection to remove those who were not here in 20202-21
drop if dummylefthousehold==1
drop if livinghome==3
drop if livinghome==4
drop if age<15



*** How many HH?
preserve
duplicates drop HHID2020, force
ta dummymigration
restore


*** How many individuals?
ta dummymigrantlist


*** Job?
preserve
keep if dummymigrantlist==1
*
ta migrationjoblist
restore


****************************************
* END















****************************************
* Migration database
****************************************
use"raw/$migrations", clear


*** Details
ta migrationarea
ta migrationplace
sum migrationdistance
ta migrationtype
ta migrationdurationfrequency
ta migrationdurationinmonth
ta dummybacktovillage
sum migrationtravelcost
ta migrationtravelcost
ta migrationtravelpayment
ta migrationtenure
ta migrationfindjob
ta migrationjobtype2
ta migrationwagetype
sum migrationsalary
ta migrationpension
ta migrationbonus
ta migrationinsurance
ta migrationmainoccup
ta migrationskill
ta migrationreason
ta migrationotherreason
ta dummyadvance


*** Advance details
preserve
keep if dummyadvance==1
*
ta migrationadvanceprovider
ta migrationadvancereceiver
sum migrationadvanceamount
ta migrationadvancefeel
ta dummyadvancebalance
restore

*** Balance details
preserve
keep if dummyadvance==1
keep if dummyadvancebalance==1
*
sum advanceamountbalance
ta advancebalanceproblem
ta advancebalanceperception
restore


*** Migration child
preserve
keep if migrationtype==2
*
ta migrationchild
restore


*** COVID
ta covdealcovid19


*** COVID details
preserve
keep if strpos(covdealcovid19,"2")
*
ta covmealemployer
restore


*** If meal yes COVID details
preserve
keep if strpos(covdealcovid19,"2")
keep if strpos(covmealemployer,"1")
*
ta covmealemployerfree
restore


*** COVID advance
preserve
keep if dummyadvance==1
*
ta covpressureadvance
restore


*** COVID advance details
preserve
keep if dummyadvance==1
keep if covpressureadvance==1
*
ta covpressuremanage
ta covpressuremanageother
restore


*** COVID migration
preserve
keep if strpos(covdealcovid19,"3") | strpos(covdealcovid19,"4")
*
ta covmigrationagain
restore


*** COVID migration details
preserve
keep if strpos(covdealcovid19,"3") | strpos(covdealcovid19,"4")
keep if covmigrationagain=="1"
*
ta covmigrationagaindate
ta covmigrationagainreason
ta covmigrationotherreason
restore


*** COVID work again
ta covstayworkagain


****************************************
* END

















****************************************
* Remittances received module
****************************************
use"raw/$household", clear



*** Basic selection to remove those who were not here in 20202-21
drop if dummylefthousehold==1
drop if livinghome==3
drop if livinghome==4
drop if age<15



*** How many HH?
preserve
duplicates drop HHID2020, force
ta dummyremreceived
restore


*** How many individuals?
ta dummyremrecipientlist



*** Reshape
keep HHID2020 INDID2020 dummyremreceived dummyremrecipientlist remrecipientsourcename1 remrecipientsourcenametwo1 remreceivedsourcerelation1 remreceivedsourceoccup1 remreceivedsourceplace1 remreceivedmoney1 remgift1 remreceivedservices1 remreceivedfrequency1 remreceivedamount1 remreceivedtotalamount1 remreceivedmean1 remgiftnb1 remgiftamount1 remreceivedsourceoccupother1 remreceivedservicesother1 covremreceived1 remrecipientsourcename2 remrecipientsourcenametwo2 remreceivedsourcerelation2 remreceivedsourceoccup2 remreceivedsourceplace2 remreceivedmoney2 remgift2 remreceivedservices2 remreceivedfrequency2 remreceivedamount2 remreceivedtotalamount2 remreceivedmean2 remgiftnb2 remgiftamount2 remreceivedsourceoccupother2 remreceivedservicesother2 covremreceived2 remrecipientsourcename3 remrecipientsourcenametwo3 remreceivedsourcerelation3 remreceivedsourceoccup3 remreceivedsourceplace3 remreceivedmoney3 remgift3 remreceivedservices3 remreceivedfrequency3 remreceivedamount3 remreceivedtotalamount3 remreceivedmean3 remgiftnb3 remgiftamount3 remreceivedsourceoccupother3 remreceivedservicesother3 covremreceived3 remrecipientsourcename4 remrecipientsourcenametwo4 remreceivedsourcerelation4 remreceivedsourceoccup4 remreceivedsourceplace4 remreceivedmoney4 remgift4 remreceivedservices4 remreceivedfrequency4 remreceivedamount4 remreceivedtotalamount4 remreceivedmean4 remgiftnb4 remgiftamount4 remreceivedsourceoccupother4 remreceivedservicesother4 covremreceived4

reshape long remrecipientsourcename remrecipientsourcenametwo remreceivedsourcerelation remreceivedsourceoccup remreceivedsourceplace remreceivedmoney remgift remreceivedservices remreceivedfrequency remreceivedamount remreceivedtotalamount remreceivedmean remgiftnb remgiftamount remreceivedsourceoccupother remreceivedservicesother covremreceived, i(HHID2020 INDID2020) j(remrec)

keep if remrecipientsourcename!=.



*** Info
ta remrecipientsourcename
ta remrecipientsourcenametwo
ta remreceivedsourceoccup
ta remreceivedsourceoccupother
ta remreceivedmoney
ta remgift
ta remreceivedservices
ta remreceivedservicesother
ta covremreceived


*** Specific for other relation
preserve
keep if remrecipientsourcename==31
*
ta remreceivedsourcerelation
ta remreceivedsourceplace
restore


*** For those who received money
preserve
keep if remreceivedmoney==1
*
ta remreceivedfrequency
ta remreceivedamount
ta remreceivedtotalamount
ta remreceivedmean
ta remgiftnb
restore


*** For those who received gift
preserve
keep if remgift==1
*
ta remgiftnb
ta remgiftamount
restore

****************************************
* END




















****************************************
* Remittances sent module
****************************************
use"raw/$household", clear



*** Basic selection to remove those who were not here in 20202-21
drop if dummylefthousehold==1
drop if livinghome==3
drop if livinghome==4
drop if age<15



*** How many HH?
preserve
duplicates drop HHID2020, force
ta dummyremsent
restore


*** How many individuals?
ta dummyremsenderlist


*** Reshape
keep HHID2020 INDID2020 dummyremsent dummyremsenderlist remsentname1 remsentnametwo1 remsentdummyvillage1 remsentrelation1 remsentoccup1 remsentplace1 remsentmoney1 remsentgift1 remsentservices1 remsentsourceoccupother1 remsentservicesother1 remsentfrequency1 remsentamount1 remsenttotalamount1 remsentmean1 remsentgiftnb1 remsentgiftamount1 covremsent1 remsentname2 remsentnametwo2 remsentdummyvillage2 remsentrelation2 remsentoccup2 remsentplace2 remsentmoney2 remsentgift2 remsentservices2 remsentsourceoccupother2 remsentservicesother2 remsentfrequency2 remsentamount2 remsenttotalamount2 remsentmean2 remsentgiftnb2 remsentgiftamount2 covremsent2 remsentname3 remsentnametwo3 remsentdummyvillage3 remsentrelation3 remsentoccup3 remsentplace3 remsentmoney3 remsentgift3 remsentservices3 remsentsourceoccupother3 remsentservicesother3 remsentfrequency3 remsentamount3 remsenttotalamount3 remsentmean3 remsentgiftnb3 remsentgiftamount3 covremsent3 remsentname4 remsentnametwo4 remsentdummyvillage4 remsentrelation4 remsentoccup4 remsentplace4 remsentmoney4 remsentgift4 remsentservices4 remsentsourceoccupother4 remsentservicesother4 remsentfrequency4 remsentamount4 remsenttotalamount4 remsentmean4 remsentgiftnb4 remsentgiftamount4 covremsent4 remsentname5 remsentnametwo5 remsentdummyvillage5 remsentrelation5 remsentoccup5 remsentplace5 remsentmoney5 remsentgift5 remsentservices5 remsentsourceoccupother5 remsentservicesother5 remsentfrequency5 remsentamount5 remsenttotalamount5 remsentmean5 remsentgiftnb5 remsentgiftamount5 covremsent5

reshape long remsentname remsentnametwo remsentdummyvillage remsentrelation remsentoccup remsentplace remsentmoney remsentgift remsentservices remsentsourceoccupother remsentservicesother remsentfrequency remsentamount remsenttotalamount remsentmean remsentgiftnb remsentgiftamount covremsent, i(HHID2020 INDID2020) j(remsent)

keep if remsentname!=.




*** Info
ta remsentname
ta remsentnametwo
ta remsentdummyvillage
ta remsentmoney
ta remsentgift
ta remsentservices
ta remsentservicesother
ta covremsent


*** For others name
preserve
keep if remsentname==31
keep if remsentdummyvillage==0
*
ta remsentrelation
ta remsentoccup
ta remsentsourceoccupother
ta remsentplace
restore


*** If sent money
preserve
keep if remsentmoney==1
*
ta remsentfrequency
sum remsentamount remsenttotalamount
ta remsentmean
restore


*** If gift
preserve
keep if remsentgift==1
*
sum remsentgiftnb remsentgiftamount
restore

****************************************
* END
















****************************************
* Financial practices (loans)
****************************************
use"raw/$household", clear



*** Basic selection to remove those who were not here in 20202-21
drop if dummylefthousehold==1
drop if livinghome==3
drop if livinghome==4
drop if age<15



*** Loans HH
preserve
duplicates drop HHID2020, force
ta dummyloans
ta covrefusalloan
restore


*** Loans indiv
ta dummyborrowerlist
sum nbloansbyborrower


*** Main loans
ta threemainloans


****************************************
* END












****************************************
* Financial practices (income assets)
****************************************
use"raw/$household", clear



*** Basic selection to remove those who were not here in 20202-21
drop if dummylefthousehold==1
drop if livinghome==3
drop if livinghome==4
drop if age<15



*** Income assets
preserve
duplicates drop HHID2020, force
*
ta dummyincomeassets
restore


*** Amount income assets
preserve
duplicates drop HHID2020, force
keep if dummyincomeassets==1
*
sum incomeassets
restore

****************************************
* END

















****************************************
* Financial practices (lending)
****************************************
use"raw/$household", clear



*** Basic selection to remove those who were not here in 20202-21
drop if dummylefthousehold==1
drop if livinghome==3
drop if livinghome==4
drop if age<15




*** Lending money
preserve
duplicates drop HHID2020, force
*
ta dummylendingmoney
restore


*** Lender
ta dummyhhlenderlist


*** Lending details
preserve
keep if dummyhhlenderlist==1
*
ta borrowerscaste
ta borrowerssex
ta relationwithborrower
sum amoutlent interestlending
ta purposeloanborrower
ta problemrepayment
ta dummyloanfromborrower
ta covlendrepayment
ta covlending
ta datelendingmoney
restore


****************************************
* END
















****************************************
* Financial practices (recommendations)
****************************************
use"raw/$household", clear



*** Basic selection to remove those who were not here in 20202-21
drop if dummylefthousehold==1
drop if livinghome==3
drop if livinghome==4
drop if age<15



*** Recommendations
preserve
duplicates drop HHID2020, force
*
ta dummyrecommendgiven
restore


*** Individual details
ta dummyrecommendgivenlist


*** Recommendations details
preserve
keep if dummyrecommendgivenlist==1
*
ta dummyrecommendrefuse
restore


*** Why refuse?
preserve
keep if dummyrecommendgivenlist==1
keep if dummyrecommendrefuse==1
*
ta reasonrefuserecommend
restore


****************************************
* END

















****************************************
* Financial practices (chitfund)
****************************************
use"raw/$household", clear



*** Basic selection to remove those who were not here in 20202-21
drop if dummylefthousehold==1
drop if livinghome==3
drop if livinghome==4
drop if age<15



*** Chitfund
preserve
duplicates drop HHID2020, force
ta dummychitfund
restore


*** Chitfund individual level
ta dummychitfundbelongerlist


*** Chitfund number
preserve
keep if dummychitfundbelongerlist==1
*
ta nbchitfunds
restore


*** Chitfund details
preserve
keep HHID2020 INDID2020 dummychitfund dummychitfundbelongerlist chitfundbelongernumber nbchitfunds chitfundtype1 durationchit1 nbermemberchit1 chitfundpayment1 chitfundpaymentamount1 chitfundamount1 covchitfundstop1 covchitfundreturn1 chitfundtype2 durationchit2 nbermemberchit2 chitfundpayment2 chitfundpaymentamount2 chitfundamount2 covchitfundstop2 covchitfundreturn2 chitfundtype3 durationchit3 nbermemberchit3 chitfundpayment3 chitfundpaymentamount3 chitfundamount3 covchitfundstop3

reshape long chitfundtype durationchit nbermemberchit chitfundpayment chitfundpaymentamount chitfundamount covchitfundstop covchitfundreturn, i(HHID2020 INDID2020) j(chitnb)
keep if chitfundtype!=.

ta chitfundtype
sum durationchit nbermemberchit
ta chitfundpayment
sum chitfundpaymentamount chitfundamount
ta covchitfundstop

keep if covchitfundstop=="1"
ta covchitfundreturn
restore


****************************************
* END


















****************************************
* Financial practices (savings)
****************************************
use"raw/$household", clear



*** Basic selection to remove those who were not here in 20202-21
drop if dummylefthousehold==1
drop if livinghome==3
drop if livinghome==4
drop if age<15




****************************************
* END



