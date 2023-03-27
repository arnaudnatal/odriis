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
ta subjectafter10th
ta othersubjectafter10th
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
ta otherreasonneverattendedschool
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
keep if reasondropping==15 | currentlyatschool==1
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


*** Where?
preserve
keep if dummymigrantlist==1
drop if migrationjoblist==9
*
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
restore


*** Advance
preserve
keep if dummymigrantlist==1
drop if migrationjoblist==9
*
ta dummyadvance
restore


*** Advance details
preserve
keep if dummymigrantlist==1
drop if migrationjoblist==9
keep if dummyadvance==1
*
ta migrationadvanceprovider
ta migrationadvancereceiver
sum migrationadvanceamount
ta migrationadvancefeel
restore


*** Advance balance
preserve
keep if dummymigrantlist==1
drop if migrationjoblist==9
keep if dummyadvance==1
*
ta dummyadvancebalance
restore


*** Balance details
preserve
keep if dummymigrantlist==1
drop if migrationjoblist==9
keep if dummyadvance==1
keep if dummyadvancebalance==1
*
sum advanceamountbalance
ta advancebalanceproblem
ta advancebalanceperception
restore


*** Migration child
preserve
keep if dummymigrantlist==1
drop if migrationjoblist==9
keep if migrationtype==2
*
ta migrationchild
restore


*** COVID
preserve
keep if dummymigrantlist==1
drop if migrationjoblist==9
*
ta covdealcovid19

restore


****************************************
* END













