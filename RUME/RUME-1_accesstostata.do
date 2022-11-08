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
label define family 1"Head" 2"Wife" 3"Mother" 4"Father" 5"Son" 6"Daughter" 7"Daughter-in-law" 8"Son-in-law" 9"Sister" 10"Mother-in-law" 11"Father-in-law" 12"Brother elder" 13"Brother younger" 14"Grand children" 15"Nobody" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define education 1"Primary" 2"High school" 3"HSC" 4"Diploma" 5"Degree" 6"Post graduate" 7"Enginering" 8"Others" 9"No education" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define typeeducation 1"Technical education" 2"Experience skill in a field" 3"Technical skill" 4"No skill" 66"Irrelevant" 77"Other" 88"DK" 99"NR", replace

label values sex sex
label values relationshiptohead family
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
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

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
ta pubservfield

bysort HHID2010 INDID2010: gen n=_n
reshape wide pubservfield pubservduration pubservpost pubservpayment, i(HHID2010 INDID2010) j(n)

save"dta\B_pubservwork", replace










********** Memberships
use"dta\B5", clear

*Rename
rename ACodeIdmember INDID2010
rename BEvents1 membershipsevents
rename CWhere1 membershipsplace
rename BEvents2 membershipsevents2
rename CWhere2 membershipsplace2
rename DHowmanytime membershipsduration

*Label
label define events 1"Political meeting" 2"Trade union activity" 3"Demonstration" 4"Functions/anniversary" 5"Village/area association meeting" 6"Caste association meeting" 7"Meet with officials" 8"None" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values membershipsevents events
label values membershipsevents2 events


*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates tag HHID2010 INDID2010, gen(tag)
sort tag HHID2010
duplicates drop
*
replace membershipsevents2=1 if HHID2010=="RAMPO27" & INDID2010=="F1"
replace membershipsplace2="MADURAI" if HHID2010=="RAMPO27" & INDID2010=="F1"
drop if HHID2010=="RAMPO27" & membershipsplace=="MADURAI" & membershipsplace2=="MADURAI"
drop tag
*
duplicates report HHID2010 INDID2010

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
sort tag HHID2010
duplicates drop
drop tag

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
rename I lendernativevillage
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
label define lender 1"WKP" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn broker" 7"Shop keeper" 8"Finance" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mills loan" 14"Nobody" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define loanlendercat 1"Informal" 2"Semi-formal" 3"Formal"
label define relatives 1"Maternal uncle" 2"Brother" 3"Paternal uncle" 4"Cousin (father side)" 5"Nephew (mother side)" 6"Father/Mother in-law" 7"Brother-in-law" 8"Wife relatives" 9"Father brother" 10"No relation" 11"Father" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"" 12"Muthaliyar" 13"Kulalar" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define native 1"Inside village" 2"Outside village" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relation 1"Colleague" 2"Relative" 3"Labour" 4"Political" 5"Religious" 6"Neighbour" 7"SHG" 8"Businessman" 9"WKP" 10"Financial" 11"Bank" 12"Don't know him" 13"Traditional" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define otherlenderservices 1"Political support" 2"Financial support" 3"Guarantor" 4"Genral informant" 5"Other" 6"None" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values loanreasongiven loanreasongiven
label values loanlender lender
destring loanlendercat, replace
label values loanlendercat loanlendercat
label values lenderrelatives relatives
label values lenderscaste caste
label values lendernativevillage yesno
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
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
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
label define lender 1"WKP" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn broker" 7"Shop keeper" 8"Finance" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mills loan" 14"Nobody" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
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
label values helptosettleloan lender
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
label define lender 1"WKP" 2"Relatives" 3"Employer" 4"Maistry" 5"Colleague" 6"Pawn broker" 7"Shop keeper" 8"Finance" 9"Friends" 10"SHG" 11"Banks" 12"Coop bank" 13"Sugar mills loan" 14"Nobody" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define lenderaction 1"Did not provide second loan" 2"Modify the loan contract" 3"Stop providing land to cultivate (pressure)" 4"Stop providing water (pressure)" 5"Pressure to sell propety" 6"Psychological pressure through direct contact" 7"Give you more time for the repayment" 8"Take back collaterals" 9"Pressurize the guarantor" 10"Ask the guarantor to repay" 11"Cancel the debt" 12"Send people to make pressure" 13"Nothing" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define yesno 0"No" 1"Yes"
label define stoplend 1"Stopped lending" 2"Don't have money" 3"Don't trust me" 4"Failed to produce guarantee" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define strength 1"Interest rate" 2"Amount" 3"Duration" 4"Flexibility" 5"Poss to postpone repayment" 6"Quick access" 7"Simple procedure" 8"Poss to whithdraw money" 9"Discretion" 10"Respect" 11"Limited amount of collaterals" 12"Nature of collaterals" 13"Guarantee" 14"Obligatory saving" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define weakness 1"More interest" 2"Demand money not available" 3"Need of recommendation/guarantor" 4"To be return back in exact time" 5"No possible of time extension" 6"Physical violence" 7"Mental torture" 8"Not possible to get in exact time" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values mltype lender
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

ta productname


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
duplicates drop

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
drop if recommendgivenlist==15 & recommendgivenrelation==66 & recommendgivencaste==66 & dummyrecommendback==66
duplicates report HHID2010
duplicates tag HHID2010, gen(tag)
sort tag HHID2010
drop tag
duplicates drop
bysort HHID2010: gen n=_n

reshape wide recommendgivenlist recommendgivenrelation recommendgivencaste dummyrecommendback recommendgivenlender recommendgivenlendercaste, i(HHID2010) j(n)

duplicates report HHID2010

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
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates tag HHID2010 INDID2010, gen(tag)
sort tag HHID2010 INDID2010
drop tag
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
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates tag HHID2010 INDID2010, gen(tag)
sort tag HHID2010 INDID2010
duplicates drop
drop tag

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
drop if INDID2010==""
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

*Clean2
duplicates report HHID2010
fre productlist
duplicates tag HHID2010 productlist, gen(tag)
sort tag HHID2010 productlist producttypeland
drop tag
drop if productlist==14

bysort HHID2010 (productlist producttypeland): gen n=_n

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

preserve
keep HHID2010 dummylandpurchased landpurchasedacres landpurchasedamount landpurchasedhowbuy
duplicates drop
drop if dummylandpurchased==0
duplicates report HHID2010
save"dta\B_landpurchased", replace
restore

preserve
keep HHID2010 dummyleasedland landleasername landleasercaste landleaserrelation
duplicates drop
drop if dummyleasedland==0
duplicates report HHID2010
save"dta\B_leasedland", replace
restore

drop dummylandpurchased landpurchasedacres landpurchasedamount landpurchasedhowbuy dummyleasedland landleasername landleasercaste landleaserrelation

drop if otherproductname==""
duplicates report HHID2010

bysort HHID2010: gen n=_n

reshape wide otherproductname otherproductsold otherproductown, i(HHID2010) j(n)

save"dta\B_otherproduct", replace











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

*Clean
preserve
keep HHID2010 dummyleasingland landleasingname landleasingcaste landleasingrelation
drop if dummyleasingland==0
duplicates report HHID2010
sort HHID2010
duplicates drop
duplicates report HHID2010
save"dta\B_landleasing", replace
restore
drop dummyleasingland landleasingname landleasingcaste landleasingrelation
drop if productintstopreason=="66" & productintstopyear==66
duplicates report HHID2010

bysort HHID2010: gen n=_n

reshape wide productlistintstop productintstop productintstopreason productintstopyear, i(HHID2010) j(n)

save"dta\B_intstopcrops", replace










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

*Clean
duplicates report HHID2010

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

*Clean
drop if equipmentlist==4
duplicates tag HHID2010, gen(tag)
sort tag HHID2010
bysort HHID2010 (equipmentlist): gen n=_n

reshape wide equipmentlist equipmentnb equipementyear equipmentpay equipmentlender equipmentcost equipmentpledged, i(HHID2010) j(n)

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

*Clean
duplicates drop
duplicates tag HHID2010 listgoods, gen(tag)
sort tag HHID2010
drop tag

bysort HHID2010: gen n=_n
reshape wide listgoods numbergoods goodyearpurchased goodbuying, i(HHID2010) j(n)

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


*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates drop
bysort HHID2010 INDID2010: gen n=_n
reshape wide kindselfemployment businesscastebased yearestablishment businessamountinvest businesssourceinvest businesslender relativesbusinesslender castebusinesslender lossbusinessinvest businessskill, i(HHID2010 INDID2010) j(n)

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

*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates drop
bysort HHID2010 INDID2010: gen n=_n
reshape wide goodincomeperiod goodincomeperiodnbmonth goodincomeamount averageincomeperiod averageincomeperiodnbmonth averageincomeperiodamount lowincomeperiod lowincomeperiodnbmonth lowincomeperiodamount, i(HHID2010 INDID2010) j(n)

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

*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates drop

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

*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates drop
bysort HHID2010 INDID2010 (relationshipbusinesslabourer castebusinesslabourer businesslabourertypejob): gen n=_n
reshape wide namebusinesslabourer relationshipbusinesslabourer castebusinesslabourer businesslabourertypejob businesslabourerwagetype businesslabourerbonus businesslabourerinsurance businesslabourerpension, i(HHID2010 INDID2010) j(n)

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

*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates drop
bysort HHID2010 INDID2010: gen n=_n
reshape wide creditsell creditperiod creditcope creditpercentage creditbuy, i(HHID2010 INDID2010) j(n)

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

*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates drop

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
rename J salariedjobfulltime
rename K salariedwagetype

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relation 1"Colleague" 2"Relative" 3"Labour" 4"Political" 5"Religious" 6"Neighbour" 7"SHG" 8"Businessman" 9"WKP" 10"Financial" 11"Bank" 12"Don't know him" 13"Traditional" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define caste 1"Vanniyar" 2"SC" 3"Arunthatiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"" 12"Muthaliyar" 13"Kulalar" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define sjtype 1"Permament" 2"Temporary" 3"Seasonal" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define wagetype 1"Daily" 2"Weekly" 3"Monthly" 4"Piece rate" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values casteemployer caste
label values relationemployer relation
label values salariedjobtype sjtype
label values salariedwagetype wagetype
label values salariedjobfulltime yesno

*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates drop

bysort HHID2010 INDID2010: gen n=_n
reshape wide joblocation jobdistance kindsalariedjob kindsalariedjobcat casteemployer relationemployer salariedjobtype salariedjobfulltime salariedwagetype, i(HHID2010 INDID2010) j(n)

save"dta\B_SJ1", replace









********* SJ 2
use"dta\B38", clear

*Rename
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

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relation 1"Colleague" 2"Relative" 3"Labour" 4"Political" 5"Religious" 6"Neighbour" 7"SHG" 8"Businessman" 9"WKP" 10"Financial" 11"Bank" 12"Don't know him" 13"Traditional" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define getjob 1"Maistry" 2"Themselves" 3"Friends" 4"Known person" 5"Advertisement" 6"Go regular" 7"Traditional job" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values salariedjobpension yesno
label values salariedjobbonus yesno
label values salariedjobinsurance yesno
label values sjdummyadvance yesno
label values sjadvancebalance yesno
label values salariedjobhow getjob
label values salariedjobhowknow relation

*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
duplicates drop
bysort HHID2010 INDID2010: gen n=_n
reshape wide salariedjobdays salariedjobsalary salariedjobpension salariedjobbonus salariedjobinsurance salariedjobtenure sjdummyadvance sjadvancebalance sjadvanceamount salariedjobhow salariedjobhowknow, i(HHID2010 INDID2010) j(n)

save"dta\B_SJ2", replace








********** Crisis
use"dta\B39", clear

*Rename
rename B crisislostjob 
rename C crisislesswork
rename D crisiskindofwork
rename E crisislocation1
rename F crisislocation2

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values crisislostjob yesno
label values crisislesswork yesno

*Clean
duplicates report HHID2010

save"dta\B_crisis", replace











********** Migration
use"dta\B40", clear

*Rename
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

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define usually 1"Several days" 2"Several weeks" 3"Several months" 4"More" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define whopay 1"Yourself" 2"Employer" 3"Maistry" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define migjob 1"Brick kiln" 2"Sugarcane" 3"Construction" 4"Coolie" 5"Agricultural related" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define getjob 1"Maistry" 2"Themselves" 3"Friends" 4"Known person" 5"Advertisement" 6"Go regular" 7"Traditional job" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relatives 1"Maternal uncle" 2"Brother" 3"Paternal uncle" 4"Cousin (father side)" 5"Nephew (mother side)" 6"Father/Mother in-law" 7"Brother-in-law" 8"Wife relatives" 9"Father brother" 10"No relation" 11"Father" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define relation 1"Colleague" 2"Relative" 3"Labour" 4"Political" 5"Religious" 6"Neighbour" 7"SHG" 8"Businessman" 9"WKP" 10"Financial" 11"Bank" 12"Don't know him" 13"Traditional" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define sjtype 1"Permament" 2"Temporary" 3"Seasonal" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define wagetype 1"Daily" 2"Weekly" 3"Monthly" 4"Piece rate" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define migjobtype 1"Part time" 2"Full time" 3"Seasonal" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define migrationadvanceprovider 1"Maistry" 2"Direct" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values dummymigration yesno
label values dummyadvance yesno
label values migrationpension yesno
label values migrationbonus yesno
label values migrationinsurance yesno
label values migrationusually usually
label values migrationtravelpayment whopay
label values migrationjoblist migjob
label values migrationfindjob getjob
label values migrationhelpedrelatives relatives
label values migrationhelped relation
label values migrationjobtype sjtype
label values migrationjobtype2 migjobtype
label values migrationwagetype wagetype
label values migrationadvanceprovider migrationadvanceprovider
label values dummyadvancebalance yesno

save"dta\B_migration", replace









********** Remittances received
use"dta\B41", clear

*Rename
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

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define remfreq 1"Monthly" 2"Seasonal" 3"During festival" 4"Annual" 5"Whenever needed" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define sendrem 1"Through relatives" 2"In person" 3"By post" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values dummyremrec yesno
label values remrecproduct yesno
label values remrecreduc yesno
label values remrecfrequency remfreq
label values remrechow sendrem

*Clean
drop if dummyremrec==0
duplicates report HHID2010
bysort HHID2010: gen n=_n
reshape wide remrecsourcename1 remrecourcerelation remrecsourceplace remrecfrequency remrectotalamount remrecproduct remrectotalvalue remrechow remrecreduc, i(HHID2010) j(n)

save"dta\B_remrec", replace








********** Remittances sent
use"dta\B42", clear

*Rename
rename B dummyremsent
rename CodeIDmember INDID2010
rename D individ
rename E remsentlocation
rename F remsentname1 
rename G remsenttotalamount
rename H remsentfrequency

*Label
label define yesno 0"No" 1"Yes" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define family 1"Head" 2"Wife" 3"Mother" 4"Father" 5"Son" 6"Daughter" 7"Daughter-in-law" 8"Son-in-law" 9"Sister" 10"Mother-in-law" 11"Father-in-law" 12"Brother elder" 13"Brother younger" 14"Grand children" 15"Nobody" 66"Irrelevant" 77"Other" 88"DK" 99"NR"
label define remfreq 1"Monthly" 2"Seasonal" 3"During festival" 4"Annual" 5"Whenever needed" 66"Irrelevant" 77"Other" 88"DK" 99"NR"

label values dummyremsent yesno
label values individ family
label values remsentfrequency remfreq
label values remsentname1 relation

*Clean
drop if INDID2010==""
duplicates report HHID2010 INDID2010
bysort HHID2010 INDID2010: gen n=_n
reshape wide individ remsentlocation remsentname1 remsenttotalamount remsentfrequency, i(HHID2010 INDID2010) j(n)

save"dta\B_remsent", replace
****************************************
* END
