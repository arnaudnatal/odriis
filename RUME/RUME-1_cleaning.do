cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
16/04/2021
-----
TITLE: RUME

-------------------------
*/




****************************************
* INITIALIZATION
****************************************
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\Data_RUME\DATA"
cd "$directory"
****************************************
* END



****************************************
* RUME xlsx to dta
****************************************
forvalues i=1/43 {
import excel "xlsx\B`i'.xlsx", firstrow clear
capture confirm v Codefamily 
if _rc==0 {
rename Codefamily HHID2010
}
capture confirm v CodeFamily 
if _rc==0 {
rename CodeFamily HHID2010
}
save"dta\B`i'", replace
}
****************************************
* END



****************************************
* Rename var
****************************************
********** Code indiv
use"dta\B43", clear
rename CodeIDMember INDID2010
rename Personinvolved individ

save"dta\B_INDIDindiv", replace


********** Intro
use"dta\B1", clear


*Rename
rename B villagename
rename C village
rename D villagearea
rename E householdid
rename F address
rename G religion
rename H caste
rename I castecode
rename J comefrom
rename _8Villageout outsider


*Label
label define village 1"ELANTHALMPATTU" 2"GOVULAPURAM" 3"KARUMBUR" 4"KORATTORE" 5"KUVAGAM" 6"MANAMTHAVIZHINTHAPUTHUR" 7"MANAPAKKAM" 8"NATHAM" 9"ORAIYURE" 10"SEMAKOTTAI"
label define villagearea 1"Ur" 2"Colony"
label define religion 1"Hindu" 2"Christian" 3"Muslim" 77"Other"
label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"" 12"Muthaliyar" 13"Kulalar" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define castecode 1"Lowest" 2"Middle" 3"Upper" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values village village
label values villagearea villagearea 
label values religion religion
label values caste caste
destring castecode, replace
label values castecode castecode


*Clean
replace outsider="" if outsider=="66"
drop villagename

save"dta\B_intro", replace


********** Family members
use"dta\B2", clear

*Rename
rename ACodeidmember INDID2010
rename BName name
rename CMaleFemale sex
rename DRelation relationshiptohead
rename EAge age
rename FStay livinghome
rename GEducation education
rename HStudentatpresent studentpresent
rename ISkills typeeducation
drop Nuclearfamily RatioEmployment


*Label
label define sex 1"Male" 2"Female"
label define relationshiptohead 1"Head" 2"Wife" 3"Mother" 4"Father" 5"Son" 6"Daughter" 7"Daughter-in-law" 8"Son-in-law" 9"Sister" 10"Mother-in-law" 11"Father-in-law" 12"Brother elder" 13"Brother younger" 14"Grand children" 15"Nobody" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define yesno 0"No" 1"Yes" 
label define education 1"Primary" 2"High school" 3"HSC" 4"Diploma" 5"Degree" 6"Post graduate" 7"Enginering" 8"Others" 9"No education" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define typeeducation 1"Technical education" 2"Experience skill in a field" 3"Technical skill" 4"No skill" 66"Irrelevant" 77"Other" 88"DK" 99"NR", replace

label values sex sex
label values relationshiptohead relationshiptohead
label values livinghome yesno
label values education education
label values studentpresent yesno
label values typeeducation typeeducation

save"dta\B_family", replace


********** Occupations
use"dta\B3", clear

*Rename
rename ACodeidmember INDID2010
rename BPersoninvolved individ
rename COccupation occupationname
rename COccupationCode2 kindofwork
rename DAnnualIncome annualincome
rename G stopworking

*Clean
drop if kindofwork==10

*Label
label define kindofwork 1"Agriculture" 2"Coolie" 3"Agri coolie" 4"NREGS" 5"Investment" 6"Employee" 7"Service" 8"Self-employment" 9"Pension" 10"No occupation" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define yesno 0"No" 1"Yes" 

label values kindofwork kindofwork
label values stopworking yesno

save"dta\B_occupations", replace


********** Pub serv work
use"dta\B4", clear

*Rename
rename ACodeidmember INDID2010
rename BPersoninvolved individ
rename CField pubservfield
rename DSincehowlong pubservduration
rename EDesignationpost pubservpost
rename FPaid pubservpayment

*Label
label define paid 1"Payment" 2"Allowance" 3"Reimbursment" 5"No payment" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values pubservpayment paid

*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates tag HHID2010 INDID2010, gen(tag)
ta HHID2010 if tag==1
sort HHID2010
drop tag

bysort HHID2010 INDID2010: gen n=_n
reshape wide pubservfield pubservduration pubservpost pubservpayment, i(HHID2010 INDID2010) j(n)

save"dta\B_pubservwork", replace


********** Memberships
use"dta\B5", clear

*Rename
rename ACodeIdmember INDID2010
rename BEvents1 membershipsevents
rename CWhere1 membershipsplace
rename BEvents2 membershipseventstwo
rename CWhere2 membershipsplacetwo
rename DHowmanytime membershipsduration

*Label
label define events 1"Political meeting" 2"Trade union activity" 3"Demonstration" 4"Functions/anniversary" 5"Village/area association meeting" 6"Caste association meeting" 7"Meet with officials" 8"None" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values membershipsevents events
label values membershipseventstwo events


*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates tag HHID2010 INDID2010, gen(tag)
ta HHID2010 if tag==1
sort HHID2010
drop tag

bysort HHID2010 INDID2010: gen n=_n
reshape wide membershipsevents membershipsplace membershipseventstwo membershipsplacetwo membershipsduration, i(HHID2010 INDID2010) j(n)

save"dta\B_memberships", replace



********** Memberships asso
use"dta\B6", clear

*Rename
rename B INDID2010
rename C individ
rename D membershipseventsasso
rename E membershipsassoname
rename F membershipsdurationasso

*Label
label define asso 1"SHG" 2"Cooperative" 3"Sangam" 4"None" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label values membershipseventsasso asso

*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates tag HHID2010 INDID2010, gen(tag)
ta HHID2010 if tag==1
sort HHID2010
drop tag

bysort HHID2010 INDID2010: gen n=_n
reshape wide membershipseventsasso membershipsassoname membershipsdurationasso, i(HHID2010 INDID2010) j(n)

save"dta\B_membershipsasso", replace



********** Expenses
use"dta\B7", clear
rename FoodexpensesweekRs foodexpenses
rename EducationexpensesyearRs educationexpenses
rename HealthexpensesyearRs healthexpenses
rename CeremoniesexpensesyearRs ceremoniesexpenses
rename DeathexpensesyearRs deathexpenses

save"dta\B_expenses", replace


********** Loans
use"dta\B9", clear

*Rename
rename B loanid
rename C loanreasongiven
rename D lonreasongiven_str
rename E loanlender
rename F loanlendercat
rename G lenderrelatives
rename H lenderscaste
rename I lenderfrom
rename J lenderrelation
rename K otherlenderservices
rename L otherlenderservices2 
rename M loanamount
rename N loanbalance
rename O loansettled
rename P loandate
rename Q loandatemonth
rename R loandateyear

*Label
label define loanreasongiven 1"Agriculture" 2"Family expenses" 3"Health expenses" 4"Repay previous loan" 5"House expenses" 6"Investment" 7"Ceremonies" 8"Marriage" 9"Education" 10"Relatives" 11"Death"  66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define loanlender 1"WKP" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn broker" 7"Shop keeper" 8"Finance" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mills loan" 14"Nobody" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define loanlendercat 1"Informal" 2"Semi-formal" 3"Formal"
label define relatives 1"Maternal uncle" 2"Brother" 3"Paternal uncle" 4"Cousin (father side)" 5"Nephew (mother side)" 6"Father/Mother in-law" 7"Brother-in-law" 8"Wife relatives" 9"Father brother" 10"No relation" 11"Father" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"" 12"Muthaliyar" 13"Kulalar" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define native 1"Inside village" 2"Outside village" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relation 1"Colleague" 2"Relative" 3"Labour" 4"Political" 5"Religious" 6"Neighbour" 7"SHG" 8"Businessman" 9"WKP" 10"Financial" 11"Bank" 12"Don't know him" 13"Traditional" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define otherlenderservices 1"Political support" 2"Financial support" 3"Guarantor" 4"Genral informant" 5"Other" 6"None" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define yesno 0"No" 1"Yes"

label values loanreasongiven loanreasongiven
label values loanlender loanlender
destring loanlendercat, replace
label values loanlendercat loanlendercat
label values lenderrelatives relatives
label values lenderscaste caste
label values lenderfrom native
label values lenderrelation relation
label values otherlenderservices otherlenderservices
label values otherlenderservices2 otherlenderservices
label values loansettled yesno

save"dta\B_loans", replace



********** Main loans
use"dta\B10", clear

*Rename
rename B loanid
rename C loanlender2
rename D lendername
rename E lenderscaste2
rename F lenderrelation2
rename G lenderrelatives2
rename H otherlenderservices3
rename I otherlenderservices4
rename J borrowerservices
rename K responsibleforthecredit1
rename L responsibleforthecredit2
rename M responsibleforthecredit3
rename N loanutilisation
rename O loanreasondetails
rename P loaneffectivereasondetails
rename Q effectiveamount
rename R effectivereceived
rename S amountreceivedmanage
rename T organiseexpense1
rename U organiseexpense2
rename V plantorepay1
rename W plantorepay2
rename X plantorepay3
rename Y timegetcredit
rename Z amountgetcredit
rename AA timewentgetcredit
rename AB datecredittaken
rename AC datecredittakenmonth
rename AD datecredittakenyear
rename AE periodwaited
rename AF durationgivenbyyou
rename AG durationgivenbymoneylender
rename AH durationtook
rename AI dummyinterest
rename AJ interestloan
rename AK interestfrequency 
rename AL interestpaid
rename AM principalpaid
rename AN loansettled2
rename AO dummyrecommendation
rename AP dummyguarantor
rename AQ recommenddetailscaste
rename AR guarantordetailscaste
rename AS recommendloanrelation
rename AT guarantorloanrelation
rename AU samepersonreco
rename AV samepersonguarantor
rename AW dummyguarantee
rename AX loanproductpledgecat
rename AY loanproductpledge
rename AZ loanproductpledgeamount
rename BA guarantee
rename BB guaranteetype
rename BC totalrepaidprincipal
rename BD totalrepaiddummyinterest
rename BE totalrepaidinterest
rename BF repayduration1
rename BG repaydecision
rename BH termsofrepayment
rename BI problemrepayment
rename BJ dummyrepaysoldproduct
rename BK repaysoldproduct1
rename BL repaysoldproduct2
rename BM repaycreditamount
rename BN dummyrepaytakejob
rename BO repaytakejob
rename BP repaywhotakejob1
rename BQ repaywhotakejob2
rename BR repaywhotakejob3
rename BS dummysettleloanworkmore
rename BT settleloanworkmore
rename BU settleloanwhoworkmore1
rename BV settleloanwhoworkmore2
rename BW settleloanwhoworkmore3
rename BX helptosettleloan
rename BY helptosettleloanrelatives
rename BZ problemdelayrepayment
rename CA lenderaction
rename CB loanfromthesameperson

*Clean
drop loanlender2 lenderscaste2 lenderrelation2 lenderrelatives2 otherlenderservices3 otherlenderservices4 loansettled2

*Label 
label define borrowerservices 1"Free service" 2"Work for less wage" 3"Provide support" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define yesno 0"No" 1"Yes"
label define amountreceivedmanage 1"Borrowed from other" 2"Pledged the property" 3"Sold the property" 4"Managed with the received amount" 5"Other" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define organiseexpenses 1"Get from others" 2"Sell the property" 3"Pledge the property" 4"Manage with the existing" 5"Other" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define plantorepay 1"Joined a chit fund" 2"Work more" 3"Migrate" 4"Sell asssets" 5"Use normal income from labour" 6"Borrow elsewhere" 7"Nothing special" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define frequency 1"Weekly" 2"Monthly" 3"Yearly" 4"Once in six months" 5"Pay whenever have money" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"" 12"Muthaliyar" 13"Kulalar" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relation 1"Colleague" 2"Relative" 3"Labour" 4"Political" 5"Religious" 6"Neighbour" 7"SHG" 8"Businessman" 9"WKP" 10"Financial" 11"Bank" 12"Don't know him" 13"Traditional" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define used 1"Chit" 2"SHG" 3"Both" 4"No" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define usedshg 1"Guarantee of money" 2"Guarantee of trust" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define decision 1"Myself" 2"Lender"
label define terms 1"Fixed duration" 2"Pay when have money" 3"Repay when asked"
label define problem 1"Borrowing elsewhere" 2"Selling something which was not planned" 3"Lease land" 4"Consumption reduction" 5"Take an additional job" 6"Work more" 7"Relative or friends support" 8"To sell harvest in advance" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define soldproduct 1"Land" 2"Cows" 3"Others livestock" 4"Consumer items" 5"Productive items" 6"Jewels, gold" 8"No product" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define loanlender 1"WKP" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn broker" 7"Shop keeper" 8"Finance" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mills loan" 14"Nobody" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relatives 1"Maternal uncle" 2"Brother" 3"Paternal uncle" 4"Cousin (father side)" 5"Nephew (mother side)" 6"Father/Mother in-law" 7"Brother-in-law" 8"Wife relatives" 9"Father brother" 10"No relation" 11"Father" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define delay 1"Nothing" 2"Shouting" 3"Put the pressure through the guarantor/person who recommended you" 4"Compromise" 5"Inform to all your relatives" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define action 1"Give you more time for the repayment" 2"Take back collaterals" 3"Pressurize the guarantor" 4"Ask the guarantor to repay" 5"Cancel the debt" 6"Legal action" 7"Physical pressure" 8"Other" 9"No problem" 66"Irrelevant" 77"Other" 88"DK" 99"NR"


label values borrowerservices borrowerservices
label values effectiveamount yesno
label values amountreceivedmanage amountreceivedmanage
label values organiseexpense1 amountreceivedmanage
label values organiseexpense2 amountreceivedmanage
label values plantorepay1 plantorepay
label values plantorepay2 plantorepay
label values plantorepay3 plantorepay
label values dummyinterest yesno
label values interestfrequency frequency
label values dummyrecommendation yesno
label values dummyguarantor yesno
label values recommenddetailscaste caste
label values recommendloanrelation relation
label values guarantordetailscaste caste
label values guarantorloanrelation relation
label values dummyguarantee yesno
label values guarantee used
label values guaranteetype usedshg
label values totalrepaiddummyinterest yesno
label values repayduration1 frequency
label values repaydecision decision
label values dummysettleloanworkmore yesno
label values loanfromthesameperson yesno
label values dummyrepaytakejob yesno
label values termsofrepayment terms
label values problemrepayment problem
label values repaysoldproduct1 soldproduct
label values repaysoldproduct2 soldproduct
label values dummyrepaysoldproduct yesno
label values helptosettleloan loanlender
label values helptosettleloanrelatives relatives
label values problemdelayrepayment delay
label values lenderaction action

save"dta\B_mainloans", replace


********** Lenders
use"dta\B11", clear

*Rename
rename B creditid
rename C mltype
rename D mlfrequency
rename E mlaction1
rename F mlaction2
rename G mlaction3
rename H mlcontinue
rename I mlstop
rename J mlstopyear
rename K mlnberasked
rename L mlstopreason
rename M mlstrength1
rename N mlstrength2
rename O mlstrength3
rename P mlweakness1
rename Q mlweakness2
rename R mlweakness3

*Label
label define loanlender 1"WKP" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn broker" 7"Shop keeper" 8"Finance" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mills loan" 14"Nobody" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define lenderaction 1"Did not provide second loan" 2"Modify the loan contract" 3"Stop providing land to cultivate (pressure)" 4"Stop providing water (pressure)" 5"Pressure to sell propety" 6"Psychological pressure through direct contact" 7"Give you more time for the repayment" 8"Take back collaterals" 9"Pressurize the guarantor" 10"Ask the guarantor to repay" 11"Cancel the debt" 12"Send people to make pressure" 13"Nothing" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define yesno 0"No" 1"Yes"
label define stoplend 1"Stopped lending" 2"Don't have money" 3"Don't trust me" 4"Failed to produce guarantee" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define strength 1"Interest rate" 2"Amount" 3"Duration" 4"Flexibility" 5"Poss to postpone repayment" 6"Quick access" 7"Simple procedure" 8"Poss to whithdraw money" 9"Discretion" 10"Respect" 11"Limited amount of collaterals" 12"Nature of collaterals" 13"Guarantee" 14"Obligatory saving" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define weakness 1"More interest" 2"Demand money not available" 3"Need of recommendation/guarantor" 4"To be return back in exact time" 5"No possible of time extension" 6"Physical violence" 7"Mental torture" 8"Not possible to get in exact time" 66"Irrelevant" 77"Other" 88"DK" 99"NR"


label values mltype loanlender
label values mlaction1 lenderaction
label values mlaction2 lenderaction
label values mlaction3 lenderaction
label values mlcontinue yesno
label values mlstop yesno
label values mlstopreason stoplend
label values mlstrength1 strength
label values mlstrength2 strength
label values mlstrength3 strength
label values mlweakness1 weakness
label values mlweakness2 weakness
label values mlweakness3 weakness


save"dta\B_lenders", replace



********** Credit on product
use"dta\B12", clear

*Rename
rename B productname
rename C productlender
rename D productloanamount
rename E productloansettled

*Label
label define from 1"Shop keeper" 2"Credit vendor" 3"Finance company" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values productlender from
label values productloansettled yesno

*Clean
sort HHID2010
duplicates report HHID2010
drop if productname=="No product"
duplicates report HHID2010

bysort HHID2010: gen n=_n
ta n

reshape wide productname productlender productloanamount productloansettled, i(HHID2010) j(n)

save"dta\B_creditproduct", replace



********** Lend to other
use"dta\B13", clear

*Rename
rename B INDID2010
rename C borrowerscaste
rename D relationwithborrower
rename E amountlent
rename F interestlending
rename G purposeloanborrower
rename H problemrepayment

*Label
label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"" 12"Muthaliyar" 13"Kulalar" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relation 1"Colleague" 2"Relative" 3"Labour" 4"Political" 5"Religious" 6"Neighbour" 7"SHG" 8"Businessman" 9"WKP" 10"Financial" 11"Bank" 12"Don't know him" 13"Traditional" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define purpose 1"Agriculture" 2"Education" 3"Family expenses" 4"Medical expenses" 5"Funeral" 6"Marriage" 7"Repay past debt" 8"Buy consumer goods" 9"Investment" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values borrowerscaste caste
label values relationwithborrower relation
label values purposeloanborrower purpose
label values problemrepayment yesno

*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates tag HHID2010 INDID2010, gen(tag)
ta HHID2010 if tag==1
sort HHID2010
drop tag

bysort HHID2010 INDID2010: gen n=_n
reshape wide borrowerscaste relationwithborrower amountlent interestlending purposeloanborrower problemrepayment, i(HHID2010 INDID2010) j(n)

save"dta\B_lendtoother", replace



********** Outstanding
use"dta\B14", clear
rename CodeIDloan loanid
rename Balance loanbalance2

save"dta\B_outstanding", replace



********** Given reco
use"dta\B15", clear

*Rename
rename B recommendgivenlist
rename C recommendgivenrelation
rename D recommendgivencaste
rename E dummyrecommendback
rename F recommendgivenlender
rename G recommendgivenlendercaste

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define family 1"Head" 2"Wife" 3"Mother" 4"Father" 5"Son" 6"Daughter" 7"Daughter-in-law" 8"Son-in-law" 9"Sister" 10"Mother-in-law" 11"Father-in-law" 12"Brother elder" 13"Brother younger" 14"Grand children" 15"Nobody" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relation 1"Colleague" 2"Relative" 3"Labour" 4"Political" 5"Religious" 6"Neighbour" 7"SHG" 8"Businessman" 9"WKP" 10"Financial" 11"Bank" 12"Don't know him" 13"Traditional" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"" 12"Muthaliyar" 13"Kulalar" 66"Irrelevant" 77"Other" 88"DK" 99"NR"


label values recommendgivenlist family
label values recommendgivenrelation relation
label values recommendgivencaste caste 
label values dummyrecommendback yesno
label values recommendgivenlender relation
label values recommendgivenlendercaste caste

*Clean
duplicates report HHID2010
bysort HHID2010: gen n=_n

reshape wide recommendgivenlist recommendgivenrelation recommendgivencaste dummyrecommendback recommendgivenlender recommendgivenlendercaste, i(HHID2010) j(n)

save"dta\B_givenreco", replace



********** Received reco
use"dta\B16", clear

*Rename
rename B dummyrecommendrefuse
rename C reasonrefuserecommendcat
rename D reasonrefuserecommend
rename E repaycreditpersoreco
rename F repaycreditpersorecoamount
rename G repaycreditpersorecorelation
rename H repaycreditpersorecocaste
rename I repaycreditpersorecoborrower
rename J repaycreditpersorecomanage
rename K receivereco
rename L receiverecoreason

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relation 1"Colleague" 2"Relative" 3"Labour" 4"Political" 5"Religious" 6"Neighbour" 7"SHG" 8"Businessman" 9"WKP" 10"Financial" 11"Bank" 12"Don't know him" 13"Traditional" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"" 12"Muthaliyar" 13"Kulalar" 66"Irrelevant" 77"Other" 88"DK" 99"NR"


label values dummyrecommendrefuse yesno
label values repaycreditpersoreco yesno
label values repaycreditpersorecorelation relation
label values repaycreditpersorecocaste caste
label values repaycreditpersorecoborrower relation
label values receivereco yesno

*Clean
duplicates report HHID2010

save"dta\B_receivedreco", replace


********** Chit
use"dta\B17", clear

*Rename
rename ChitFund dummychitfund
rename C INDID2010
rename D chitfundtype
rename E durationchit
rename F nbermemberchit
rename G chitfundpayment
rename H chitfundamount

*Label
label define chit 1"Auction chit" 2"Jewel chit" 3"Vessels chit" 4"Tourism chit" 5"Kulukkal chit" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define chitpay 1"Weekly" 2"Monthly" 3"Yearly" 4"Once in six month" 5"Pay whenever have money" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values chitfundtype chit
label values chitfundpayment chitpay


*Clean
duplicates report HHID2010 INDID2010
bysort HHID2010 INDID2010: gen n=_n

reshape wide chitfundtype durationchit nbermemberchit chitfundpayment chitfundamount, i(HHID2010 INDID2010) j(n)

save"dta\B_chit", replace


********** Savings
use"dta\B18", clear

*Rename
rename B dummysavingaccount
rename C INDID2010
rename D savingsbankname
rename E savingsbankplace
rename F savingsamount
rename G savingspurposeone
rename H savingspurposetwo
rename I dummydebitcard
rename J dummycreditcard

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define savingpurpose 1"Saving" 2"Jewel pledge" 3"Receive credit" 4"Crop loans" 5"Sugar mills loan" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values dummysavingaccount yesno
label values savingspurposeone savingpurpose
label values savingspurposetwo savingpurpose
label values dummydebitcard yesno
label values dummycreditcard yesno

*Clean
duplicates report HHID2010 INDID2010
bysort HHID2010 INDID2010: gen n=_n

reshape wide savingsbankname savingsbankplace savingsamount savingspurposeone savingspurposetwo dummydebitcard dummycreditcard, i(HHID2010 INDID2010) j(n)

save"dta\B_savings", replace


********** Gold
use"dta\B19", clear

*Rename
rename B goldquantity
rename C goldquantitypledge
rename D goldamountpledge

*Clean
duplicates report HHID2010

save"dta\B_gold", replace


********** Insurance
use"dta\B20", clear

*Rename
rename B dummyinsurance
rename C INDID2010
rename D insurancename
rename E insurancetypetwo
rename F insurancebenefit
rename G insurancejoineddate

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define insurancetype 1"Life insurance" 2"Health insurance" 3"Crop insurance" 4"Animal insurance" 5"Saving insurance" 6"No insurance" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values dummyinsurance yesno
label values insurancetypetwo insurancetype
label values insurancebenefit yesno

*Clean
duplicates report HHID2010 INDID2010
bysort HHID2010 INDID2010: gen n=_n

reshape wide insurancename insurancetypetwo insurancebenefit insurancejoineddate, i(HHID2010 INDID2010) j(n)

save"dta\B_insurance", replace


********** House
use"dta\B21", clear

*Rename
rename B house
rename C howbuyhouse1
rename D howbuyhouse2
rename E howbuyhouse3
rename F rentalhouse
rename G housevalue
rename H housetype
rename I houseroom

*Label
label define house 1"Own house" 2"Joint house" 3"Family property" 4"Rental"
label define howbuyhouse 1"Hereditary" 2"Savings" 3"Bank loan" 4"Credit from relatives/WKP" 5"Finance" 6"Help from children" 7"Government scheme" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define housetype 1"Concrete house (non gov)" 2"Big traditional tamil house" 3"Medium house" 4"Concrete house" 5"Tile roof house" 6"Thatched roof house" 7"Government house"

label values house house 
label values howbuyhouse1 howbuyhouse
label values howbuyhouse2 howbuyhouse
label values howbuyhouse3 howbuyhouse
label values housetype housetype


save"dta\B_house", replace


********** Other facilities
use"dta\B22", clear

*Rename
rename B electricity 
rename C water
rename D housetitle
rename E ownotherhouse
rename F otherhouserent
rename G otherhouserentcat

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define electricity 1"General electricity" 2"Single line" 3"Free electricity"
label define water 1"Own tap" 2"Public tap"

label values electricity electricity
label values water water
label values housetitle yesno
label values ownotherhouse yesno

save"dta\B_otherfacilities", replace


********** Livestock
use"dta\B23", clear

*Rename
rename B dummylivestock
rename C livestocknb_cow
rename D livestockprice_cow
rename E livestockuse1_cow
rename F livestockuse2_cow
rename G livestockuse3_cow
rename H livestocknb_goat
rename I livestockprice_goat
rename J livestockuse1_goat
rename K livestockuse2_goat
rename L livestockuse3_goat
rename M dummycattleloss
rename N cattlelossnb
rename O howlost
rename P cattlelossamount
rename Q cattleinsurance
rename R cattleinsuranceamount
rename S dummymedicalexpenses
rename T medicalexpensesamount
rename U notinterestedrearing1
rename V notinterestedrearingreason1
rename W notinterestedrearing2
rename X notinterestedrearingreason2
rename Y interestedrearing1
rename Z interestedrearingreason1
rename AA interestedrearing2
rename AB interestedrearingreason2

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define livestockuse 1"To be sold" 2"For milk" 3"As saving" 4"Keep status" 5"Other" 6"Bullockcart" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define howlost 1"Dead" 2"Sold" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define animals 1"Cows" 2"Goats" 3"Plough and cart bull" 4"Buffalo" 5"Ducks" 6"No animals" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values dummylivestock yesno
label values livestockuse1_cow livestockuse
label values livestockuse2_cow livestockuse
label values livestockuse3_cow livestockuse
label values livestockuse1_goat livestockuse
label values livestockuse2_goat livestockuse
label values livestockuse3_goat livestockuse
label values dummycattleloss yesno
label values howlost howlost
label values cattleinsurance yesno
label values dummymedicalexpenses yesno
label values notinterestedrearing1 animals
label values notinterestedrearing2 animals 
label values interestedrearing1 animals
label values interestedrearing2 animals

*Clean
duplicates report HHID2010

save"dta\B_livestock", replace


********** Land
use"dta\B24", clear
duplicates report HHID2010
rename B ownland
rename C wetland
rename D landsize
rename E waterfromlandone
rename F waterfromlandtwo

bysort HHID2010: gen n=_n

reshape wide ownland wetland landsize waterfromlandone waterfromlandtwo, i(HHID2010) j(n)

*As NEEMSIS
gen ownland=.
replace ownland=0 if ownland1!=1 | ownland2!=1 | ownland3!=1
replace ownland=1 if ownland1==1 | ownland2==1 | ownland3==1
gen sizeownland=""
replace sizeownland=landsize1 if ownland1==1
replace sizeownland=landsize2 if ownland2==1
replace sizeownland=landsize3 if ownland3==1
gen drywetownland=.
replace drywetownland=wetland1 if ownland1==1
replace drywetownland=wetland2 if ownland2==1
replace drywetownland=wetland3 if ownland3==1
gen waterfromownland=.
replace waterfromownland=waterfromlandone1 if ownland1==1
replace waterfromownland=waterfromlandtwo1 if ownland1==1
replace waterfromownland=waterfromlandone2 if ownland2==1
replace waterfromownland=waterfromlandtwo2 if ownland2==1
replace waterfromownland=waterfromlandone3 if ownland3==1
replace waterfromownland=waterfromlandtwo3 if ownland3==1

gen leaseland=.
replace leaseland=0 if ownland1!=2 | ownland2!=2 | ownland3!=2
replace leaseland=1 if ownland1==2 | ownland2==2 | ownland3==2
gen sizeleaseland=""
replace sizeleaseland=landsize1 if ownland1==2
replace sizeleaseland=landsize2 if ownland2==2
replace sizeleaseland=landsize3 if ownland3==2
gen drywetleaseland=.
replace drywetleaseland=wetland1 if ownland1==2
replace drywetleaseland=wetland2 if ownland2==2
replace drywetleaseland=wetland3 if ownland3==2
gen waterfromleaseland=.
replace waterfromleaseland=waterfromlandone1 if ownland1==2
replace waterfromleaseland=waterfromlandtwo1 if ownland1==2
replace waterfromleaseland=waterfromlandone2 if ownland2==2
replace waterfromleaseland=waterfromlandtwo2 if ownland2==2
replace waterfromleaseland=waterfromlandone3 if ownland3==2
replace waterfromleaseland=waterfromlandtwo3 if ownland3==2

*Clean
drop ownland1 wetland1 landsize1 waterfromlandone1 waterfromlandtwo1 ownland2 wetland2 landsize2 waterfromlandone2 waterfromlandtwo2 ownland3 wetland3 landsize3 waterfromlandone3 waterfromlandtwo3

destring sizeownland sizeleaseland, dpcomma replace

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define drywet 1"Dry" 2"Wet"
label define water 1"Tank" 2"River/Canal" 3"Bore well" 4"Open well" 5"Only rain"

label values ownland yesno
label values leaseland yesno
label values drywetownland drywet
label values drywetleaseland drywet
label values waterfromownland water
label values waterfromleaseland water

save"dta\B_land", replace


********** Crops
use"dta\B25", clear

*Rename
rename B productlist
rename C productacre
rename D producttypeland
rename E productnbbags
rename F productpricebag
rename G productpricesold
rename H productexpenses
rename I productlabourcost

*Label
label define productlist 1"Paddy" 2"Cotton" 3"Sugarcane" 4"Savukku tree" 5"Guava" 6"Mango" 7"Sapotta fruit" 8"Plantain" 9"Ground nut" 10"Millets" 11"Ulundu" 12"Banana" 13"Cashewnut" 14"No crops" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define prodland 1"Own land" 2"Lease land" 3"No land" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values productlist productlist
label values producttypeland prodland


*Clean
split productacre, p(,)
gen productacre3=productacre if productacre2==""
egen productacre4=concat(productacre1 productacre2), p(.)
replace productacre4="" if productacre3!=""
replace productacre3=productacre4 if productacre3==""
order productacre3, after(productacre)
drop productacre1 productacre2 productacre4
destring productacre3, replace
drop productacre
rename productacre3 productacre

duplicates report HHID2010
bysort HHID2010: gen n=_n
duplicates tag HHID2010 productlist, gen(tag)
sort tag HHID2010
drop tag

reshape wide productlist productacre producttypeland productnbbags productpricebag productpricesold productexpenses productlabourcost, i(HHID2010) j(n)

save"dta\B_crops", replace


********** Land purchased
use"dta\B26", clear

*Rename
rename B dummylandpurchased
rename C landpurchasedacres
rename D landpurchasedamount
rename E landpurchasedhowbuy
rename F otherproductname
rename G otherproductsold
rename H otherproductown
rename I dummyleasedland
rename J landleasername
rename K landleasercaste
rename L landleaserrelation

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relation 1"Colleague" 2"Relative" 3"Labour" 4"Political" 5"Religious" 6"Neighbour" 7"SHG" 8"Businessman" 9"WKP" 10"Financial" 11"Bank" 12"Don't know him" 13"Traditional" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"" 12"Muthaliyar" 13"Kulalar" 66"Irrelevant" 77"Other" 88"DK" 99"NR"


label values dummylandpurchased yesno
label values dummyleasedland yesno
label values landleasercaste caste
label values landleaserrelation relation


*Clean
duplicates report HHID2010
bysort HHID2010: gen n=_n

reshape wide dummylandpurchased landpurchasedacres landpurchasedamount landpurchasedhowbuy otherproductname otherproductsold otherproductown dummyleasedland landleasername landleasercaste landleaserrelation, i(HHID2010) j(n)

save"dta\B_landpurchlease", replace


********** Land 2
use"dta\B27", clear

*Rename
rename B dummyleasingland
rename C landleasingname
rename D landleasingcaste
rename E landleasingrelation
rename F productlistintstop
rename G productintstop
rename H productintstopreason
rename I productintstopyear

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relation 1"Colleague" 2"Relative" 3"Labour" 4"Political" 5"Religious" 6"Neighbour" 7"SHG" 8"Businessman" 9"WKP" 10"Financial" 11"Bank" 12"Don't know him" 13"Traditional" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"" 12"Muthaliyar" 13"Kulalar" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define productlist 1"Paddy" 2"Cotton" 3"Sugarcane" 4"Savukku tree" 5"Guava" 6"Mango" 7"Sapotta fruit" 8"Plantain" 9"Ground nut" 10"Millets" 11"Ulundu" 12"Banana" 13"Cashewnut" 14"No crops" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define intstop 1"Interested" 2"Stopped" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values dummyleasingland yesno
label values landleasingcaste caste
label values landleasingrelation relation
label values productlistintstop productlist
label values productintstop intstop

save"dta\B_landleasecrops", replace


********** Land 3
use"dta\B28", clear

*Rename
rename B dummylabourers
rename C productworkers
rename D productlabourwage
rename E productoriginlabourers
rename F productcastelabourers1
rename G productcastelabourers2
rename H productcastelabourers3

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"" 12"Muthaliyar" 13"Kulalar" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define inside 1"Inside village" 2"Outside village" 66"Irrelevant" 77"Other" 88"DK" 99"NR"


label values dummylabourers yesno
label values productcastelabourers1 caste
label values productcastelabourers2 caste
label values productcastelabourers3 caste
label values productoriginlabourers inside

save"dta\B_labourers", replace


********* Farm equipment
use"dta\B29", clear

*Rename
rename AEquipment equipmentlist
rename BHowmany equipmentnb
rename CWhenbuy equipementyear
rename DHowpay equipmentpay
rename ECreditfrom equipmentlender
rename FCost equipmentcost
rename GPledge equipmentpledged

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define equipment 1"Tractor" 2"Bullockcart" 3"Harvster" 4"No equipment" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define pay 1"Income" 2"Savings" 3"Selling assets" 4"Help relatives" 5"Governmental scheme" 6"NGO scheme" 7"Credit" 8"One member work more" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define lender 1"WKP" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn broker" 7"Shop keeper" 8"Finance" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mills loan" 14"Nobody" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values equipmentlist equipment
label values equipmentpay pay
label values equipmentlender lender
label values equipmentpledged yesno


save"dta\B_farmequipment", replace


********** Goods
use"dta\B30", clear

*Rename
rename AGoods listgoods
rename BNber numbergoods
rename CYearofpurchase goodyearpurchased
rename DPaymenttype goodbuying

*Label
label define goods 1"Car" 2"Bike" 3"Fridge" 4"Costly furniture" 5"Tailoring machine" 6"Cell phone" 7"Land line phone" 8"DVD" 9"Camera" 10"Cooking gas" 11"Computer" 12"Dish antenna" 13"TV" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define goodbuying 1"Credit" 2"Instalment" 3"Ready cash" 4"Paid by government" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values listgoods goods
label values goodbuying goodbuying

save"dta\B_goods", replace



********** SE 1
use"dta\B31", clear

*Rename
rename B INDID2010
rename C kindselfemployment
rename D businesscastebased
rename E yearestablishment
rename F businessamountinvest
rename G businesssourceinvest
rename H businesslender
rename I relativesbusinesslender
rename J castebusinesslender
rename K lossbusinessinvest
rename L businessskill

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define sourceinvest 1"Loan" 2"Own capital" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define lender 1"WKP" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn broker" 7"Shop keeper" 8"Finance" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mills loan" 14"Nobody" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relatives 1"Maternal uncle" 2"Brother" 3"Paternal uncle" 4"Cousin (father side)" 5"Nephew (mother side)" 6"Father/Mother in-law" 7"Brother-in-law" 8"Wife relatives" 9"Father brother" 10"No relation" 11"Father" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"" 12"Muthaliyar" 13"Kulalar" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define skill 1"Family" 2"Friends" 3"School" 4"Experience" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values businesscastebased yesno
label values businesssourceinvest sourceinvest
label values businesslender lender
label values relativesbusinesslender relatives
label values castebusinesslender caste
label values lossbusinessinvest yesno
label values businessskill skill

save"dta\B_SE1", replace


********** SE 2
use"dta\B32", clear

*Rename
rename CodeIDmember INDID2010
rename C goodincomeperiod
rename D goodincomeperiodnbmonth
rename E goodincomeamount
rename F averageincomeperiod
rename G averageincomeperiodnbmonth
rename H averageincomeperiodamount
rename I lowincomeperiod
rename J lowincomeperiodnbmonth
rename K lowincomeperiodamount

save"dta\B_SE2", replace


********** SE 3
use"dta\B33", clear

*Rename
rename CodeIDMember INDID2010 
rename C ownbusinessinterested
rename D ownbusinesstype
rename E ownbusinessinvest
rename F ownbusinessinvestamount
rename G ownbusinesseduc
rename H ownbusinessexpe
rename I ownbusinessmarket
rename J ownbusinessmanpower

*Clean
destring ownbusinesseduc ownbusinessexpe ownbusinessmarket ownbusinessmanpower, replace

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values ownbusinessinterested yesno
label values ownbusinesseduc yesno
label values ownbusinessexpe yesno
label values ownbusinessmarket yesno
label values ownbusinessmanpower yesno

save"dta\B_SE3", replace


********** SE 4
use"dta\B34", clear

*Rename
rename CodeIDmember INDID2010
rename C dummybusinesslabourers
rename D namebusinesslabourer
rename E relationshipbusinesslabourer
rename F castebusinesslabourer
rename G businesslabourertypejob
rename H businesslabourerwagetype
rename I businesslabourerbonus
rename J businesslabourerinsurance
rename K businesslabourerpension

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relation 1"Colleague" 2"Relative" 3"Labour" 4"Political" 5"Religious" 6"Neighbour" 7"SHG" 8"Businessman" 9"WKP" 10"Financial" 11"Bank" 12"Don't know him" 13"Traditional" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"" 12"Muthaliyar" 13"Kulalar" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define worktypejob 1"Permanent" 2"Temporary" 3"Seasonal" 66"Irrelevant" 77"Other" 88"DK" 99"NR" 
label define wagetype 1"Daily" 2"Weekly" 3"Monthly" 4"Piece rate" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values relationshipbusinesslabourer relation
label values castebusinesslabourer caste
label values dummybusinesslabourers yesno
label values businesslabourerbonus yesno
label values businesslabourerinsurance yesno
label values businesslabourerpension yesno
label values businesslabourertypejob worktypejob
label values businesslabourerwagetype wagetype

save"dta\B_SE4", replace


********** SE 5
use"dta\B35", clear

*Rename
rename CodeIDmember INDID2010
rename C creditsell
rename D creditperiod
rename E creditcope
rename F creditpercentage
rename G creditbuy

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define creditsell 1"Never" 2"Time to time" 3"very often" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define creditperiod 1"One week" 2"One month" 3"Seasonal duration" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define creditcope 1"Add the interest on the selling price" 2"Usual practice" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values creditsell creditsell
label values creditperiod creditperiod
label values creditcope creditcope
label values creditbuy yesno

save"dta\B_SE5", replace



********** SE 6
use"dta\B36", clear

*Rename
rename CodeIDmember INDID2010
rename C dummypastbusiness
rename D pastbusinesstype
rename E pastbusinessreasonstopped

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values dummypastbusiness yesno

save"dta\B_SE6", replace


********** SJ 1
use"dta\B37", clear

*Rename
rename B INDID2010
rename C joblocation
rename D jobdistance
rename E kindsalariedjob
rename F kindsalariedjobcat
rename G casteemployer
rename H relationemployer
rename I salariedjobtype
rename J salariedjobtype2
rename K salariedwagetype

*Label

save"dta\B_SJ1", replace


********* SJ 2
use"dta\B38", clear
rename IDMember INDID2010 
rename C salariedjobdays
rename D salariedjobsalary
rename E salariedjobpension
rename F salariedjobbonus
rename G salariedjobinsurance
rename H salariedjobtenure
rename I sjdummyadvance
rename J sjadvancebalance
rename K sjadvanceamount
rename L salariedjobhow
rename M salariedjobhowknow

save"dta\B_SJ2", replace


********** Crisis
use"dta\B39", clear
rename B crisislostjob 
rename C crisislesswork
rename D crisiskindofwork
rename E crisislocation1
rename F crisislocation2

save"dta\B_crisis", replace



********** Migration
use"dta\B40", clear
rename B dummymigration
rename C INDID2010
rename D migrationduration
rename E migrationdurationmonth
rename F migrationplace
rename G migrationdistance
rename H migrationusually
rename I migrationtravelcost
rename J migrationtravelpayment
rename K migrationjoblist
rename L migrationtenure
rename M migrationfindjob
rename N migrationhelped
rename O migrationhelpedrelatives
rename P migrationjobtype
rename Q migrationjobtype2
rename R migrationwagetype
rename S dummyadvance
rename T migrationadvanceprovider
rename U migrationadvanceamount
rename V dummyadvancebalance
rename W migrationsalary
rename X migrationpension
rename Y migrationbonus
rename Z migrationinsurance

save"dta\B_migration", replace


********** Remittances received
use"dta\B41", clear
rename B dummyremrec
rename C remrecsourcename1
rename D remrecourcerelation
rename E remrecsourceplace
rename F remrecfrequency
rename G remrectotalamount
rename H remrecproduct
rename I remrectotalvalue
rename J remrechow
rename K remrecreduc

save"dta\B_remrec", replace



********** Remittances sent
use"dta\B42", clear
rename B dummyremsent
rename CodeIDmember INDID2010
rename D individ
rename E remsentlocation
rename F remsentname1 
rename G remsenttotalamount
rename H remsentfrequency


save"dta\B_remsent", replace
****************************************
* END







****************************************
* Merge all
****************************************
cd "$directory\dta"

********** Indiv level
use"B_family", clear
merge 1:1 HHID2010 INDID2010 using "B_pubservwork"

merge 1:1 HHID2010 INDID2010 using "B_memberships"

merge 1:1 HHID2010 INDID2010 using "B_membershipsasso"

merge 1:1 HHID2010 INDID2010 using "B_lendtoother"

merge 1:1 HHID2010 INDID2010 using "B_chit"

merge 1:1 HHID2010 INDID2010 using "B_savings"

merge 1:1 HHID2010 INDID2010 using "B_insurance"


********** HH
use"B_intro", clear
merge 1:1 HHID2010 using "B_expenses"
drop _merge

merge 1:1 HHID2010 using "B_creditproduct"
drop _merge

merge 1:1 HHID2010 using "B_givenreco"

merge 1:1 HHID2010 using "B_receivedreco"

merge 1:1 HHID2010 using "B_gold"

merge 1:1 HHID2010 using "B_house"

merge 1:1 HHID2010 using "B_otherfacilities"

merge 1:1 HHID2010 using "B_livestock"

merge 1:1 HHID2010 using "B_land"

merge 1:1 HHID2010 using "B_crops"

merge 1:1 HHID2010 using "B_landpurchlease"



********** Occupations
use"B_occupations", clear





********** Loans
use"B_loans", clear

merge 1:1 HHID2010 loanid using "B_mainloans"



********** Lenders
use"B_lenders", clear






****************************************
* END





/*

****************************************
* RUME check
****************************************
use"Rume.dta", clear

keep HHID2010 _1_1_village _1_1_village_code _1_2_ur_colony _1_4_head_of_family _1_5_address _1_6_a_religion _1_6_b_caste _1_6_b_caste_code _1_7_lived _1_8_village_out year code_id_member name sex _1_d_relation age _1_f_stay _1_g_education _1_h_student_at_present _1_i_skills nuclear_family _18_1_1_a_land_type1 _18_1_2_a_land_type1 _18_1_b_nber_acres1 _18_1_c_water_from_11 _18_1_c_water_from_21 _18_1_1_a_land_type2 _18_1_2_a_land_type2 _18_1_b_nber_acres2 _18_1_c_water_from_12 _18_1_c_water_from_22 _18_1_1_a_land_type3 _18_1_2_a_land_type3 _18_1_b_nber_acres3 _18_1_c_water_from_13 _18_1_c_water_from_23 _15_1_a_house _15_1_d_estimated_value_house _15_1_e_type_house _16_1_c_house_title _16_1_d_own_other_house _13_1_a_quantity_gold__gram_ food_expenses_week__rs_ education_expenses_year__rs_ health_expenses_year__rs_ ceremonies_expenses_year__rs_ death_expenses_year__rs_ _15_1_a_house _15_1_b_how_buy_1 _15_1_b_how_buy_2 _15_1_b_how_buy_3 _15_1_c_rental_amount _15_1_d_estimated_value_house _15_1_e_type_house _15_1_f_size__room_ _16_1_a_electricity _16_1_b_water _16_1_c_house_title _16_1_d_own_other_house _16_1_e_if_yes__rented_income _16_1_e_if_yes__rented_income_co _21__a_goods1 _21__b_nber1 _21__c_year_of_purchase1 _21__d_payment_type1 _21__a_goods10 _21__b_nber10 _21__c_year_of_purchase10 _21__d_payment_type10 _21__a_goods2 _21__b_nber2 _21__c_year_of_purchase2 _21__d_payment_type2 _21__a_goods3 _21__b_nber3 _21__c_year_of_purchase3 _21__d_payment_type3 _21__a_goods4 _21__b_nber4 _21__c_year_of_purchase4 _21__d_payment_type4 _21__a_goods5 _21__b_nber5 _21__c_year_of_purchase5 _21__d_payment_type5 _21__a_goods6 _21__b_nber6 _21__c_year_of_purchase6 _21__d_payment_type6 _21__a_goods7 _21__b_nber7 _21__c_year_of_purchase7 _21__d_payment_type7 _21__a_goods8 _21__b_nber8 _21__c_year_of_purchase8 _21__d_payment_type8 _21__a_goods9 _21__b_nber9 _21__c_year_of_purchase9 _21__d_payment_type9 _1_6_b_caste_code

rename _1_1_village village
rename _1_1_village_code villageid
rename _1_2_ur_colony villagearea
rename _1_4_head_of_family headname
rename _1_5_address address
rename _1_6_a_religion religion
rename _1_6_b_caste jatis
rename _1_7_lived living
rename _1_8_village_out comefrom
rename code_id_member INDID
rename _1_d_relation relationshiptohead
rename _1_f_stay livinghome
rename _1_g_education education
label define education 1"Primary" 2"HS" 3"HSC" 4"Diploma" 5"Degree" 6"Post" 7"Engineer" 8"Other" 9"No edu"
label values education education
rename _1_h_student_at_present currentlyatschool
rename _1_i_skills othertypeeducation

rename _18_1_1_a_land_type1 land1type1
rename _18_1_2_a_land_type1 land1type2
rename _18_1_b_nber_acres1 land1acres
rename _18_1_c_water_from_11 land1water
drop _18_1_c_water_from_21
rename _18_1_1_a_land_type2 land2type1
rename _18_1_2_a_land_type2 land2type2
rename _18_1_b_nber_acres2 land2acres
rename _18_1_c_water_from_12 land2water
drop _18_1_c_water_from_22
rename _18_1_1_a_land_type3 land3type1
rename _18_1_2_a_land_type3 land3type2
rename _18_1_b_nber_acres3 land3acres
rename _18_1_c_water_from_13 land3water
drop _18_1_c_water_from_23
rename _13_1_a_quantity_gold__gram_ goldquantity
rename _15_1_a_house house
rename _15_1_d_estimated_value_house housevalue
rename _15_1_e_type_house housetype2
rename _16_1_c_house_title housetitle
rename _16_1_d_own_other_house ownotherhouse
rename _15_1_b_how_buy_1 howbuyhouse
rename _15_1_b_how_buy_2 howbuyhouse2
rename _15_1_b_how_buy_3 howbuyhouse3
rename _15_1_c_rental_amount rentalhouse
rename _15_1_f_size__room_ houseroom
rename _16_1_a_electricity electricity
rename _16_1_b_water water
rename _16_1_e_if_yes__rented_income otherhouserent
drop _16_1_e_if_yes__rented_income_co 
rename food_expenses_week__rs_ foodexpenses
rename education_expenses_year__rs_ educationexpenses
rename health_expenses_year__rs_ healthexpenses
rename ceremonies_expenses_year__rs_ ceremoniesexpenses
rename death_expenses_year__rs_ deathexpenses
rename _1_6_b_caste_code caste


*Relation
label define relation 1"Head" 2"Wife" 3"Mother" 4"Father" 5"Son" 6"Daughter" 7"Daughter-in-law" 8"Son-in-law" 9"Sister" 10"Mother-in-law" 11"Father-in-law" 12"Brother elder" 13"Brother younger" 14"Grand children" 15"Nobody" 77"Other"
label values relationshiptohead relation

clonevar relationshiptohead2=relationshiptohead
recode relationshiptohead2 (8=7) (7=8) (12=10) (13=10) (10=11) (11=12) (14=13)
label define relation2 1"Head" 2"Wife" 3"Mother" 4"Father" 5"Son" 6"Daughter" 7"Son-in-law" 8"Daughter-in-law" 9"Sister" 10"Brother" 11"Mother-in-law" 12"Father-in-law" 13"Grandchild" 16"Grandmother" 17"Cousin" 77"Other"
label values relationshiptohead2 relation2

tab relationshiptohead relationshiptohead2

tab livinghome
rename livinghome livinghome2

*Caste
destring jatis, replace
ta jatis
label define jatis 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 12"Muthaliyar" 13"Kulalar" 66"Ir" 77"Other" 88"D/K" 99"N/R", replace
*13"Chettiyar" 14"Marwari" 15"Muslims" 16"Padayachi" 17"Yathavar" 77"Other", replace
label values jatis jatis
fre jatis
clonevar jatis2=jatis
recode jatis2 (12=11) (13=12) 
label define jatis2 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"Muthaliyar" 12"Kulalar" 77"Other", replace
label values jatis2 jatis2
ta jatis jatis2
rename jatis jatis_codeRUME
rename jatis2 jatis


destring caste, replace
label define castecat 1"Dalits" 2"Middle" 3"Upper"
label values caste castecat

ta jatis caste


*Edulevel
gen edulevel=.
replace edulevel=0 if education==9
replace edulevel=1 if education==1
replace edulevel=2 if education==2
replace edulevel=3 if education==3
replace edulevel=3 if education==4
replace edulevel=4 if education==5
replace edulevel=5 if education==6
replace edulevel=5 if education==7
replace edulevel=5 if education==8

tab education

label define edulevel 0"Below primary" 1"Primary completed" 2"High school (8th-10th)" 3"HSC/Diploma (11th-12th)" 4"Bachelors (13th-15th)" 5"Post graduate (15th and more)", replace
label values edulevel edulevel
tab edulevel


*Housing
recode howbuyhouse (8=7)
recode howbuyhouse2 (8=7)
recode howbuyhouse3 (8=7)

gen housetype=.
foreach x in 1 2 3 4 5{
replace housetype=1 if housetype2==`x'
}
replace housetype=2 if housetype2==7
replace housetype=3 if housetype2==6
label define housetype 1"Concrete house" 2"Government/green house" 3"Thatched roof house"
label values housetype housetype


*Gold
gen goldquantityamount=goldquantity*2000

*Own Land
destring land1acres land2acres land3acres, replace dpcomma
clonevar land1acres_own=land1acres
clonevar land2acres_own=land2acres
clonevar land3acres_own=land3acres

replace land1acres_own=0 if land1type1!=1
replace land2acres_own=0 if land2type1!=1
replace land3acres_own=0 if land3type1!=1

gen landowndry=0
gen landownwet=0

replace landowndry=land1acres_own if land1type2==1
replace landowndry=landowndry+land2acres_own if land2type2==1
replace landowndry=landowndry+land3acres_own if land3type2==1

replace landownwet=land1acres_own if land1type2==2
replace landownwet=landownwet+land2acres_own if land2type2==2
replace landownwet=landownwet+land3acres_own if land3type2==2

gen amountownlanddry=600000*landowndry
gen amountownlandwet=1100000*landownwet
gen amountownland=amountownlanddry+amountownlandwet

*Goods value
gen value1=100000
gen value2=1000
gen value3=5000
gen value4=5000
gen value5=1000
gen value6=1000
gen value7=1000
gen value8=1000
gen value9=5000
gen value10=500
gen value11=10000
gen value12=1000
gen value13=3000

forvalues i=1(1)13{
gen numbergoods_`i'=0
gen goodtotalamount_`i'=0
gen goodyearpurchased_`i'=0
gen goodbuying_`i'=0
}

forvalues j=1(1)10{
forvalues i=1(1)13{
replace numbergoods_`i'=_21__b_nber`j' if _21__a_goods`j'==`i'
replace goodyearpurchased_`i'=_21__c_year_of_purchase`j' if _21__a_goods`j'==`i'
replace goodbuying_`i'=_21__d_payment_type`j' if _21__a_goods`j'==`i'
}
}

forvalues i=1(1)13{
replace goodtotalamount_`i'=numbergoods_`i'*value`i'
drop value`i'
}
forvalues i=1(1)10{
drop _21__a_goods`i' _21__b_nber`i' _21__c_year_of_purchase`i' _21__d_payment_type`i'
}

foreach x in numbergoods goodtotalamount goodyearpurchased goodbuying{
rename `x'_1 `x'_car
rename `x'_2 `x'_bike
rename `x'_3 `x'_fridge
rename `x'_4 `x'_furniture
rename `x'_5 `x'_tailormach
rename `x'_6 `x'_phone
rename `x'_7 `x'_landline
rename `x'_8 `x'_DVD
rename `x'_9 `x'_camera
rename `x'_10 `x'_cookgas
rename `x'_11 `x'_computer
rename `x'_12 `x'_antenna
rename `x'_13 `x'_TV
}

*goodtotalamount
egen goodtotalamount=rowtotal(goodtotalamount_car goodtotalamount_bike goodtotalamount_fridge goodtotalamount_furniture goodtotalamount_tailormach goodtotalamount_phone goodtotalamount_landline goodtotalamount_DVD goodtotalamount_camera goodtotalamount_cookgas goodtotalamount_computer goodtotalamount_antenna goodtotalamount_TV)

save"RUME-HH.dta", replace
****************************************
* END






****************************************
* RUME cattle 
****************************************
use"RUME-HH.dta", clear

merge m:1 HHID2010 using "RUME-cattle.dta"
drop _merge

gen livestockamount_cow=8000*livestocknb_cow
gen livestockamount_goat=1000*livestocknb_goat

save"RUME-HH_v2.dta", replace
****************************************
* END





****************************************
* RUME farmequipment
****************************************
use"RUME-farmequipment.dta", clear

forvalues i=1(1)3{
gen equiownnb_`i'=0
gen equiownpay_`i'=0
gen equiowncost_`i'=0
gen equiownpledged_`i'=0
gen equiownyear_`i'=0
}

forvalues i=1(1)3{
replace equiownnb_`i'=equipmentnb if equipmentlist==`i'
replace equiownpay_`i'=equipmentpay if equipmentlist==`i'
replace equiowncost_`i'=equipmentcost if equipmentlist==`i'
replace equiownpledged_`i'=equipmentpledged if equipmentlist==`i'
replace equiownyear_`i'=equipmentyear if equipmentlist==`i'
}

foreach x in equiownnb equiownpay equiowncost equiownpledged equiownyear{
rename `x'_1 `x'_tractor
}
foreach x in equiownnb equiownpay equiowncost equiownpledged equiownyear{
rename `x'_2 `x'_bullockcart
}
foreach x in equiownnb equiownpay equiowncost equiownpledged equiownyear{
rename `x'_3 `x'_harvester
}

drop equipmentlist equipmentnb equipmentyear equipmentpay equipmentpaycreditfrom equipmentcost equipmentpledged

bysort HHID2010 : gen n=_n

*Reshape
reshape wide  equiownnb_tractor equiownpay_tractor equiowncost_tractor equiownpledged_tractor equiownyear_tractor equiownnb_bullockcart equiownpay_bullockcart equiowncost_bullockcart equiownpledged_bullockcart equiownyear_bullockcart equiownnb_harvester equiownpay_harvester equiowncost_harvester equiownpledged_harvester equiownyear_harvester, i(HHID2010) j(n)

*HH level
foreach x in tractor bullockcart harvester{
egen equiowncost_`x'=rowtotal(equiowncost_`x'1 equiowncost_`x'2)
}

save"RUME-farmequipment_v2.dta", replace

use"RUME-HH_v2.dta", clear
merge m:1 HHID2010 using "RUME-farmequipment_v2.dta"
drop _merge

save"RUME-HH_v3.dta", replace
****************************************
* END
















****************************************
* Others files
****************************************


********** xlsx to dta
/*
clear all
filelist, dir("$directory") pattern(*.xlsx)
gen rename=""
replace rename="RUME_crops" if filename=="T18-2 Agriculture _ Crops.xlsx"
replace rename="RUME_agri18-3-6" if filename=="T18-3_6 Agriculture.xlsx"
replace rename="RUME_agri18-7-9" if filename=="T18-7_9 Agriculture.xlsx"
replace rename="RUME_agri_wage" if filename=="T19 Agricultural wage.xlsx"
replace rename="RUME_SE1" if filename=="T22 Self Employment #1.xlsx"
replace rename="RUME_SE6" if filename=="T22-11 Self Employment #6.xlsx"
replace rename="RUME_SE2" if filename=="T22-1_2 Self Employment #2.xlsx"
replace rename="RUME_SE3" if filename=="T22-3 Self Employment #3.xlsx"
replace rename="RUME_SE4" if filename=="T22-4 Self Employment #4.xlsx"
replace rename="RUME_SE5" if filename=="T22-9 Self Employment #5.xlsx"
replace rename="RUME_SJ1" if filename=="T23 Salaried Job #1.xlsx"
replace rename="RUME_SJ2" if filename=="T23-1 Salaried Job #2.xlsx"
replace rename="RUME_pbwork" if filename=="T24 Problems in work (crisis).xlsx"
replace rename="RUME_migration" if filename=="T25 Migration Full.xlsx"
replace rename="RUME_income" if filename=="T26 Income by Family.xlsx"
replace rename="RUME_sendingmoney" if filename=="T27 Sending money.xlsx"
replace rename="RUME_cropsname" if filename=="X_Crops.xlsx"

drop if rename==""

**** Rename
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local old = filename
	local new = rename
	import excel "$directory\\`old'", firstrow clear
	save "$directory\\`new'.dta", replace
	erase "$directory\\`old'"
	tempfile save`i'
}
*/



********** HHID2010 + rename
/*
clear all
filelist, dir("$directory") pattern(*.dta)
*To keep
keep if substr(filename,1,5)=="RUME_"
*To rename
split filename, p(_)
egen filename4=concat(filename1 filename2), p(-)
replace filename4="RUME-agri_wage.dta" if filename4=="RUME-agri"
drop filename1 filename2 filename3
rename filename4 filename2

**** Varname+rename
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local old = filename
	local new = filename2
	use "$directory\\`old'", clear
	capture confirm v Codefamily
	if _rc==0 {
	rename Codefamily HHID2010
	}
	capture confirm v CodeFamily
	if _rc==0 {
	rename CodeFamily HHID2010
	}	
	save "$directory\\`new'", replace
	erase "$directory\\`old'"
	tempfile save`i'
}
*/



********* Crops + agri

***** Crops
*use"RUME-cropsname", clear
/*
N	Crops
1	Paddy
2	Cotton
3	Sugarcane
4	Savukku tree
5	Guava
6	Manguo
7	Sapotta fruit
8	Plantain
9	Ground nut
10	Millets
11	ulundu
12	banana
13	Cashwinut
14	No crops
66	Irrelevant
77	Other
88	Don't know
99	No reponse
*/
use"RUME-crops", clear
rename B crops
rename C cropsacre
rename D cropsland
rename E cropstotalharvestinbag
rename F cropsharvestprice
rename G cropssoldamount
rename H cropsproductioncost
rename I cropslabourcost

bysort HHID2010 (crops): gen n=_n
order HHID2010 n

ta crops
label define crops 1"Paddy" 2"Cotton" 3"Sugarcane" 4"Savukku tree" 5"Guava" 6"Mango" 7"Sapotta fruit" 8"Plantain" 9"Ground nut" 10"Millets" 11"Ulundu" 12"Banana" 13"Cashewnuts" 14"No crops" 77"Other"
label values crops crops
fre crops

*drop if crops==14

replace cropsacre="0,25" if cropsacre=="0.25"
destring cropsacre, dpcomma replace
ta cropsacre

bysort HHID2010: egen cropsexpenses=sum(cropsproductioncost)
bysort HHID2010: egen labourcostexpenses=sum(cropslabourcost)

save"RUME-crops_v2", replace




***** Agri wage
use"RUME-agri_wage.dta", clear

rename B dummylabourers
rename C labourersnumber
rename D labourerstotalwage
rename E labourersfrom
rename F labourerscaste1
rename G labourerscaste2
rename H labourerscaste3

label define yesno 0"No" 1"Yes"
label values dummylabourers yesno

bysort HHID2010: gen n=_n
order HHID2010 n
sort HHID2010 n
ta n
drop n

save"RUME-agri_wage_v2.dta", replace



***** Agri
use"RUME-agri18-3-6.dta", clear
drop if E=="" & F=="" & J=="66"

rename B dummyacrespurchased
rename C acrespurchasedsize
rename D acrespurchasedprice
rename E acrespurchasedhow
rename F otherproducts
rename G otherprodamntsold
rename H otherprodamntownpurp
rename I dummyleaseoutland
rename J leaseouttowhom
rename K leaseoutcaste
rename L leaseoutrelationship

bysort HHID2010: gen n=_n
order HHID2010 n
sort HHID2010 n
ta n
*drop n

save"RUME-crops_part2.dta", replace



***** Agri
use"RUME-agri18-7-9.dta", clear

rename B dummyleasedland
rename C leasedlandtowhom
rename D leasedlandcaste
rename E leasedlandrelationship
rename F cropsintereststopped
rename G intereststopped
rename H intereststoppedreason
rename I intereststoppedyear

label define intereststopped 1"Interested" 2"Stopped"
label values intereststopped intereststopped

bysort HHID2010: gen n=_n
order HHID2010 n
sort HHID2010 n
ta n
*drop n

save"RUME-crops_part3.dta", replace

****************************************
* END






















****************************************
* Assets + crisis + chit + gold + savings
****************************************
use"RUME-HH_v3.dta", clear

egen assets=rowtotal(amountownlanddry amountownlandwet livestockamount_goat livestockamount_cow housevalue goldquantityamount goodtotalamount)
gen assets1000=assets/1000

egen assets_noland=rowtotal(livestockamount_goat livestockamount_cow housevalue goldquantityamount goodtotalamount)
gen assets_noland1000=assets_noland/1000

/*
preserve
gen totalincome_HH1000=totalincome_HH/1000
bysort HHID2010: gen n=_n
keep if n==1
tabstat assets1000 totalincome_HH1000, stat(n mean sd p50) by(caste)
restore
*/

********** Crisis
/*
preserve
import excel "$directory\RUME-crisis.xlsx", sheet("T24_Problems_in_work__crisis_") firstrow clear
rename Codefamily HHID2010
rename B effectcrisislostjob
rename C effectcrisislesswork
rename D effectcrisiskindofwork
rename E effectcrisisjoblocation
rename F effectcrisisjoblocation2
save"RUME-crisis.dta", replace
restore
*/
merge m:1 HHID2010 using "RUME-crisis.dta"
drop _merge



********** Chit
/*
preserve
import delimited "$directory\RUME-chitfunds.csv", clear delimiter(";") encoding(utf8)
rename v1 HHID2010
rename v2 dummychitfund
rename v3 INDID
rename v4 chitfundtype
rename v5 durationchit
rename v6 nbermemberchit
rename v7 chitfundpayment
rename v8 chitfundamount
order dummychitfund HHID2010 INDID
keep if INDID!=""
duplicates tag HHID2010 INDID, gen(tag)
tab tag
drop tag
egen HHINDID=concat(HHID2010 INDID), p(/)
bysort HHINDID: gen n=_n
reshape wide chitfundtype durationchit nbermemberchit chitfundpayment chitfundamount, i(HHINDID) j(n)
drop HHINDID 
order dummychitfund HHID2010 INDID
save"$directory\RUME-chitfunds.dta", replace
restore
*/
merge 1:1 HHID2010 INDID using "$directory\RUME-chitfunds.dta"
drop if _merge==2
drop _merge
recode dummychitfund (.=0)
rename dummychitfund chitfundbelongerlist
bysort HHID2010: egen dummychitfund=sum(chitfundbelongerlist)
replace dummychitfund=1 if dummychitfund>1 & dummychitfund!=. & dummychitfund!=0



********** Savings
/*
preserve
import delimited "$directory\RUME-savings.csv", clear delimiter(";") encoding(utf8)
rename v1 HHID2010
rename v2 dummysavingaccount
rename v3 INDID
rename v4 savingsbankname
rename v5 savingsbankplace
rename v6 savingsamount
rename v7 savingspurpose1
rename v8 savingspurpose2
rename v9 dummydebitcard
rename v10 dummycreditcard
egen savingspurpose=concat(savingspurpose1 savingspurpose2), p(" ")
drop savingspurpose1 savingspurpose2
order dummysavingaccount HHID2010 INDID
keep if INDID!=""
duplicates tag HHID2010 INDID, gen(tag)
tab tag
drop tag
egen HHINDID=concat(HHID2010 INDID), p(/)
bysort HHINDID: gen n=_n
reshape wide savingsbankname savingsbankplace savingsamount dummydebitcard dummycreditcard savingspurpose, i(HHINDID) j(n)
drop HHINDID
order dummysavingaccount HHID2010 INDID
save "$directory\RUME-savings.dta", replace
restore
*/
merge 1:1 HHID2010 INDID using "$directory\RUME-savings.dta"
drop if _merge==2
drop _merge
recode dummysavingaccount (.=0)
rename dummysavingaccount saving
bysort HHID2010: egen dummysavingaccount=sum(saving)
tab dummysavingaccount
rename saving savingsownerlist
replace dummysavingaccount=1 if dummysavingaccount>1 & dummysavingaccount!=.
tab dummysavingaccount

********** Gold
/*
preserve
import delimited "$directory\RUME-gold.csv", clear delimiter(";") encoding(utf8)
rename v1 HHID2010
rename v2 goldquantity
rename v3 goldquantitypledge
rename v4 goldamountpledge
drop if HHID2010==""
gen dummygoldpledged=0
replace dummygoldpledged=1 if goldquantitypledge!=0 & goldquantitypledge!=.
save"$directory\RUME-gold.dta", replace
restore
*/
merge m:1 HHID2010 using "$directory\RUME-gold.dta"
drop _merge


********** Insurance
/*
preserve
import delimited "$directory\RUME-insurance.csv", clear delimiter(";") encoding(utf8)
rename v1 HHID2010
rename v2 dummyinsurance
rename v3 INDID
rename v4 insurancename
rename v5 insurancetype
rename v6 insurancebenefit
rename v7 insurancejoineddate
drop if INDID==""
recode insurancetype (1=1) (2=2) (3=3) (4=4) (5=7) (6=.) (77=77)
label define insurance 1"Life insurance" 2"Health insurance" 3"Crop insurance" 4"Animal insurance" 5"Accident insurance (vehicle/person)" 6"Bike insurance" 7"Savings insurance" 77"Other"
label values insurancetype insurance
keep if INDID!=""
bysort HHID2010 INDID: gen n=_n
tab n
egen HHINDID=concat(HHID2010 INDID), p(" ")
reshape wide insurancename insurancetype insurancebenefit insurancejoineddate, i(HHINDID) j(n)
drop HHINDID
order HHID2010 INDID
save"$directory\RUME-insurance.dta", replace
restore
*/
merge 1:1 HHID2010 INDID using "$directory\RUME-insurance.dta"
drop _merge
bysort HHID2010: egen _dummyinsurance=sum(dummyinsurance)
tab _dummyinsurance
rename dummyinsurance insuranceownerlist
rename _dummyinsurance dummyinsurance
replace dummyinsurance=1 if dummyinsurance>1 & dummyinsurance!=.



********** Crops expenses
preserve
use"RUME-crops_v2", clear
duplicates drop HHID2010, force
keep HHID2010 cropsexpenses labourcostexpenses
save"RUME_crops_v3", replace
restore
merge m:1 HHID2010 using "$directory\RUME_crops_v3.dta", keepusing( cropsexpenses labourcostexpenses)
drop if _merge==2
drop _merge
erase "RUME_crops_v3.dta"



********** Submission date
gen submissiondate=mdy(03,01,2010)
tab submissiondate
format submissiondate %d

save"RUME-HH_v4.dta", replace
****************************************
* END








****************************************
* HHID_panel
****************************************
use"RUME-HH_v4.dta", clear

merge m:m HHID2010 using "unique_identifier_panel.dta", keepusing(HHID_panel)
keep if _merge==3
drop _merge
preserve
duplicates drop HHID2010, force
tab HHID_panel
restore
preserve
duplicates drop HHID_panel, force
tab HHID2010
restore

save"RUME-HH_v5.dta", replace
****************************************
* END








****************************************
* Panel individuals
****************************************
*use"RUME-HH_v5.dta", clear
/*
********** RAW: F1 to 1
split INDID, p(F)
drop INDID1
rename INDID INDID_o
rename INDID2 INDID
destring INDID, replace
*Merge it
merge 1:1 HHID2010 INDID using "NEEMSIS_preload2016.dta", keepusing(name_p16)
drop if _merge==2
drop _merge
sort HHID2010 INDID
keep HHID2010 INDID INDID_o name name_p16
*Export excel pour vérif à la main
export excel using "RUME_name.xlsx", firstrow(variables)


********** VERIFICATION 1
import excel "RUME_name.xlsx", sheet("modif2") firstrow clear
drop K
rename J HH
keep HHID2010 INDID_o INDID_modif
rename INDID_o INDID
save"RUME-name_panel.dta", replace

*Put in the HH base
use"RUME-HH_v6.dta", clear

merge 1:1 HHID2010 INDID using "RUME-name_panel.dta"
drop _merge

*Rename
rename INDID INDID_o
rename INDID_modif INDID
egen INDID2010=concat(HHID2010 INDID), p(/)
tab INDID2010

*Merge with 2016
merge m:1 HHID2010 INDID using "NEEMSIS_preload2016.dta", keepusing(name_p16)
sort HHID2010 INDID
keep HHID2010 INDID INDID_o name name_p16
sort HHID2010 INDID
gen n=_n
drop if n<=528
drop n

*Id 0 and -99
bysort HHID2010 : egen min0=min(INDID)
sort min0 HHID2010 INDID
*verif à la main 2
export excel using "RUME_name_v2.xlsx", firstrow(variables) sheetreplace


********** VERIFICATION 2
import excel "RUME_name_v2.xlsx", sheet("Sheet1") firstrow clear
keep if INDID_o!=""
drop name name_p16 min0 INDID  H I J K
rename modif INDID_modif2
rename INDID_o INDID
save"RUME-name_panel_v2.dta", replace

*Put in the HH base
use"RUME-HH_v6.dta", clear
merge 1:1 HHID2010 INDID using "RUME-name_panel_v2.dta"
drop _merge

*Rename
rename INDID INDID_o
rename INDID_modif INDID
egen INDID2010=concat(HHID2010 INDID), p(/)
tab INDID2010

*Merge with 2016
merge m:1 HHID2010 INDID using "NEEMSIS_preload2016.dta", keepusing(name_p16)

sort HHID2010 INDID
keep HHID2010 INDID INDID_o name name_p16
sort HHID2010 INDID
gen n=_n
drop if n<=528
drop n

*Id 0 and -99
bysort HHID2010 : egen min0=min(INDID)
sort min0 HHID2010 INDID
*verif à la main 2
export excel using "RUME_name_v3.xlsx", firstrow(variables) sheetreplace

********** VERIFICATION 3
/*
OK pour la dernière version (2 donc car en 3 je vérifie 2)
*/
*/

********** MERGER LES NOUVEAUX CODE DONC
/*
use"RUME-HH_v5.dta", clear
merge 1:1 HHID2010 INDID using "RUME-name_panel_v2.dta"
drop _merge
rename INDID INDID_o
rename INDID_modif2 INDID
label var INDID "INDID for 2016 check by Arnaud 04/18/21 : 0 = indiv doesnt exist in the 2016 HH & -99 = HH doesnt exist in 2016 "

order HHID2010 INDID INDID_o name, first

merge m:1 HHID2010 INDID using "NEEMSIS_preload2016.dta", keepusing(name_p16)
drop if _merge==2
drop _merge

order HHID2010 INDID INDID_o name name_p16, first
sort HHID2010 INDID

/*
Check if INDID=0 are in tracking2016
*/
*/



**********
use"RUME-HH_v5.dta", clear
rename INDID INDID2010
merge 1:m HHID_panel INDID2010 using "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\_Miscellaneous\Individual_panel\code_indiv_2010_2016_2020_wide_v3", keepusing(INDID_panel)
keep if _merge==3
drop _merge
sort HHID_panel INDID_panel
order HHID_panel INDID_panel

save"RUME-HH_v6.dta", replace
****************************************
* END
