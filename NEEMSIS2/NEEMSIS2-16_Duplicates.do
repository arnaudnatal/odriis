cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
October 29, 2021
-----
TITLE: Duplicates
-------------------------
*/


****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directorybis = "D:\Docuements\_Thesis\_DATA\NEEMSIS2\DATA"
global git = "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

*global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*global directorybis = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA"
*global git ="C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"


cd"$directory"
clear all
****************************************
* END










****************************************
* Cleaning for empty parent_key and duplicates one
****************************************
*
clear all
filelist, dir("$directory\CLEAN") pattern(*.dta)
gen agri=0
replace agri=1 if strpos(filename,"Agriculture")
sort agri dirname filename
egen file=concat(dirname filename),p(\)
split dirname, p(/)
drop if dirname2=="LAST"

preserve
keep if agri==0
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = file
	local d = dirname
	local v = filename
	use "`f'", clear
	capture confirm v parent_key
	if !_rc {
	drop if parent_key==""
	***** Duplicates
	drop if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"  // householdid==36 & name1=="Natesan"
	drop if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"  // householdid==67 & name1=="Shankar"
	drop if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"  // householdid==124 & name1=="Subramani"
	drop if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"  // householdid==246 & name1=="Sornambal"
	drop if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"  // householdid==343 & name1=="Ramamoorthi"
	drop if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"  // householdid==348 & name1=="Govindan"
	drop if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"  // householdid==361 & name1=="Mallika"
	drop if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"  // householdid==391 & name1=="Balaji"
	*
	drop if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"  // householdid==532 & name1=="Shakthivel" & name2=="Revathy"
	drop if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"  // householdid==534 & name1=="Karunanidhi"
	drop if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"  // householdid==547 & name1=="Surya" (duplicates with "uuid:ae72a34f-f968-45f4-acfa-91f571f54ea8")
	}
	capture confirm v forauto
	if !_rc {
	drop forauto
	}
	save "`d'\LAST\\`v'", replace	
	tempfile save`i'
}
restore


preserve
keep if agri==1
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = file
	local d = dirname
	local v = filename
	use "`f'", clear
	capture confirm v parent_key
	if !_rc {
	drop if parent_key==""
	***** Duplicates
	drop if parent_key=="uuid:244d058e-b68a-4271-bf5f-5332dca88f8f"  // householdid==36
	drop if parent_key=="uuid:7e235580-30be-4dea-8982-68ed963b45c8"  // householdid==67
	drop if parent_key=="uuid:ece23449-7f67-4de2-b7da-3ea48d4d33dd"  // householdid==235
	drop if parent_key=="uuid:953d8941-5338-4a82-a5d7-2f6e25947e5d"  // householdid==246
	drop if parent_key=="uuid:f52b0fb0-064b-4133-a78d-83edcd80b3e1"  // householdid==343
	drop if parent_key=="uuid:08b045f7-ca13-429c-b25b-604ed8786a32"  // householdid==348
	drop if parent_key=="uuid:332b0700-6bdb-4e66-92ee-7f1e892dae6a"  // householdid==361
	drop if parent_key=="uuid:6854d50b-0b75-4b24-a3b8-ee031aa78668"  // householdid==391
	*
	drop if parent_key=="uuid:f98d6d16-e1cb-4504-8475-9414a295c014"  // householdid==534
	drop if parent_key=="uuid:0c5b2989-3bf7-49db-b6e4-ab455dfee7fe"  // householdid==547 (duplicates with "uuid:211fcb9c-19d7-4e89-9285-488a1a6588be")
	}
	capture confirm v forauto
	if !_rc {
	drop forauto
	}
	save "`d'\LAST\\`v'", replace	
	tempfile save`i'
}
restore





********** Drop les mauvais pour ne garder que les trucs à partager
clear all
filelist, dir("$directory\CLEAN\LAST") pattern(*.dta)
egen file=concat(dirname filename),p(\)

gen todrop=0
replace todrop=1 if filename=="NEEMSIS2-loans_v13.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v12.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v11.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v10.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v9.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v8.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v7.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v6.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v5.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v4.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v3.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v2.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v13_indiv.dta"
replace todrop=1 if filename=="NEEMSIS2-loans_v13_HH.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v9.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v8.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v7.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v6.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v5-_tocomp.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v5_bis.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v5.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v4.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v18.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v17.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v16.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v15.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v14.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v13.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v12.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v11.dta"
replace todrop=1 if filename=="NEEMSIS2-HH_v10.dta"
replace todrop=1 if filename=="NEEMSIS2_NEW_JUNE.dta"
replace todrop=1 if filename=="NEEMSIS2_NEW_APRIL.dta"
replace todrop=1 if filename=="NEEMSIS2_LAST.dta"
replace todrop=1 if filename=="NEEMSIS2_FEBRUARY_Agriculture.dta"
replace todrop=1 if filename=="NEEMSIS2_FEBRUARY.dta"
replace todrop=1 if filename=="NEEMSIS2_FEB_NEW_Agriculture.dta"
replace todrop=1 if filename=="NEEMSIS2_FEB.dta"
replace todrop=1 if filename=="NEEMSIS2_DECEMBER_Agriculture.dta"
replace todrop=1 if filename=="NEEMSIS2_DECEMBER.dta"
replace todrop=1 if filename=="NEEMSIS2_DEC_Agriculture.dta"
replace todrop=1 if filename=="NEEMSIS2_DEC.dta"
replace todrop=1 if filename=="NEEMSIS2_APRIL.dta"
replace todrop=1 if filename=="NEEMSIS2_Agriculture.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-selfemploy-labourers-businesslabourers.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-salaried-infoemployer.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-remsentidgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-remreceivedsourceidgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-remreceived_indiv.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations_v4.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations_v4_indiv.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations_v4_HH.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations_v3.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-occupations.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-migrationjobidgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-memberlistpreload2016.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-marriagegift.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-individualid.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension6-schemepension6group.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension5-schemepension5group.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension4-schemepension4group.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension3-schemepension3group.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension2-schemepension2group.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemepension1-schemepension1group.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-schemenrega-schemenregaind.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-goldmarriage-goldmarriagegroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-schemes-cashassistancemarriage-cashassistancemarriagegroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-savingsgroup-savings.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-loans-mainloans.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-loans-loansbyborrower.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-lendingmoneygroup-lendingmoney.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-insurancegroup-insurance.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-guaranteeandrecommendation-recommendationgiven.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-goldgroup-gold.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-financialpracticesgroup-chitfundgroup-chitfund.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-familymembers.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-employment.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-education.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-generalinformation-lefthome.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailssavingaccounts_wide.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailssavingaccounts.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailsloanbyborrower.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailsinsurance_wide.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailsinsurance.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailschitfunds_wide.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-detailschitfunds.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND.dta"
replace todrop=1 if filename=="NEEMSIS_Agriculture_APPEND_v3.dta"
replace todrop=1 if filename=="NEEMSIS_Agriculture_APPEND_v2.dta"
replace todrop=1 if filename=="NEEMSIS_Agriculture_APPEND_merge23.dta"
replace todrop=1 if filename=="NEEMSIS_Agriculture_APPEND_merge1.dta"
replace todrop=1 if filename=="NEEMSIS_Agriculture_APPEND.dta"
replace todrop=1 if filename=="indiv2020_v2.dta"
replace todrop=1 if filename=="indiv2020_temp2.dta"
replace todrop=1 if filename=="indiv2020_temp.dta"
replace todrop=1 if filename=="indiv2020.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v2.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-ego123questionnaire-socialnetworks-networkresources-contactgroup_v2_wide.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-migration-migrationgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-migration-migrationidgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-remittances-remreceived-remreceivedgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-remittances-remreceived-remreceivedidgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-remittances-remsent-remsentgroup.dta"
replace todrop=1 if filename=="NEEMSIS_APPEND-hhquestionnaire-remittances-remsent-remsentidgroup.dta"

keep if todrop==1

tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local f = file
	use "`f'", clear
	erase "`f'"	
	tempfile save`i'
}

****************************************
* END











****************************************
* Cleaning HH
****************************************
use "$directory\CLEAN\LAST\NEEMSIS2-HH_v20.dta", clear

*age
drop age agecalculation
rename age_arnaud age
order age2010 age2016 age, after(sex)
replace age=age2016+4 if age==. & age2016!=.
drop age2010 age2016

* Rename
/*
rename dummylefthousehold lefthousehold_ind

foreach x in migrantlist remrecipientlist remsenderlist borrowerlist hhlenderlist recommendgivenlist chitfundbelongerid savingsownerid goldownerid insuranceownerid marriedlist nregarecipientlist schemerecipientlist3 schemerecipientlist4 schemerecipientlist5 schemerecipientlist6 schemerecipientlist7 schemerecipientlist8 schemerecipientlist9 schemerecipientlist10 schemeslist {
rename dummy_`x' `x'_ind
}
rename amoutlent amountlent
*/

* Drop
drop ego1from2016avalaible ego1avalaible realego1available ego2from2016available ego2avalaible ego3potential

drop namenumber livinghomefromearlier 

drop setof* key 


drop ego2potential newmember9 newmember10 newmember11 newmember12 newmember13 newmember14

drop livinghome2016 kowinc_indiv_agri kowinc_indiv_selfemp kowinc_indiv_sjagri kowinc_indiv_sjnonagri kowinc_indiv_uwhhnonagri kowinc_indiv_uwnonagri kowinc_indiv_uwhhagri kowinc_indiv_uwagri kowinc_HH_agri kowinc_HH_selfemp kowinc_HH_sjagri kowinc_HH_sjnonagri kowinc_HH_uwhhnonagri kowinc_HH_uwnonagri kowinc_HH_uwhhagri kowinc_HH_uwagri sum_ext_HH

drop occinc_indiv_agri occinc_indiv_agricasual occinc_indiv_nonagricasual occinc_indiv_nonagriregnonqual occinc_indiv_nonagriregqual occinc_indiv_selfemp occinc_indiv_nrega occinc_HH_agri occinc_HH_agricasual occinc_HH_nonagricasual occinc_HH_nonagriregnonqual occinc_HH_nonagriregqual occinc_HH_selfemp occinc_HH_nrega 


drop username


**********Order as 2016

* Generic
global ord1 HHID_panel submissiondate year INDID_panel egoid jatis address villageid parent_key householdid2020 version_HH version_agri villagearea INDID2020 INDID_total INDID_former INDID_new INDID_left geopointlatitude geopointlongitude geopointaltitude geopointaccuracy compensation compensationamount villagename householdid_int interviewplace numformerfamily numleftfamily instancename formdef_version username_str Suganya_and_Malarvizhi Raichal Rajalakschmi Chithra_and_Radhika Mayan Pazani Vivek_Radja parent_key_BaseAgri address_BaseAgri submissiondate_BaseAgri geopointlatitude_BaseAgri geopointlongitude_BaseAgri geopointaltitude_BaseAgri geopointaccuracy_BaseAgri villagename_BaseAgri villagearea_BaseAgri numfamily interviewer start_HH_quest end_HH_quest start_agri_quest end_agri_quest villageareaid value_householdid_2020 newfrompanel villagenameparent villageareaparent householdidparent religion comefrom otherorigin namenewhead

* Left home
global ord2 lefthousehold dummylefthousehold othermember lefthomeid lefthomename reasonlefthome reasonlefthomeother lefthomedurationmoreoneyear

* Family members
global ord3 name age sex livinghome lefthomedurationlessoneyear lefthomedestination lefthomereason relationshiptohead maritalstatus relationshiptoheadother dummycastespouse comefromspouse dummyreligionspouse religionspouse castespouse otheroriginspouse maritalstatusdate

* Education
global ord4 canread everattendedschool classcompleted after10thstandard durationafter10th typeofhigheredu subjectsafter10th othersubjectsafter10th newtraining reservation reservationgrade reservationkind reservationother currentlyatschool educationexpenses amountschoolfees bookscost transportcost reasonneverattendedschool reasondropping otherreasondroppingschool covgoingbackschool decisiondropping decisiondroppingother dummyscholarship scholarshipamount scholarshipduration converseinenglish

* Employment
global ord5 dummyworkedpastyear reservationemployment reasonnotworkpastyear stoppedworking workpastsixmonth everworksalaried kindofworkinactive

* Migration
global ord6 dummymigration migrantlist dummy_migrantlist migrantid migrantname migrationjoblist

* Remittances received
global ord7 dummyremreceived remrecipientlist dummy_remrecipientlist remrecipientid remrecipientname

* Remittances sent
global ord8 dummyremsent remsenderlist dummy_remsenderlist remsenderid remsendername

* Loans
global ord9 dummyloans covrefusalloan borrowerlist dummy_borrowerlist sumhhloans threemainloans borrowerid borrowername nbloansbyborrower dummyincomeassets incomeassets

* Lending
global ord10 dummylendingmoney hhlenderlist dummy_hhlenderlist hhlenderid hhlendername borrowerscaste borrowerssex relationwithborrower amoutlent interestlending purposeloanborrower problemrepayment dummyloanfromborrower covlendrepayment covlending datelendingmoney

* Recommendation
global ord11 dummyrecommendgiven recommendgivenlist dummy_recommendgivenlist dummyrecommendrefuse reasonrefuserecommend recommendgivenid recommendgivenname

* Chitfund
global ord12 dummychitfund chitfundbelongerid dummy_chitfundbelongerid chitfundbelongernumber chitfundbelongername nbchitfunds chitfundtype1 durationchit1 nbermemberchit1 chitfundpayment1 chitfundpaymentamount1 chitfundamount1 covchitfundstop1 covchitfundreturn1 chitfundtype2 durationchit2 nbermemberchit2 chitfundpayment2 chitfundpaymentamount2 chitfundamount2 covchitfundstop2 covchitfundreturn2 chitfundtype3 durationchit3 nbermemberchit3 chitfundpayment3 chitfundpaymentamount3 chitfundamount3 covchitfundstop3

* Saving
global ord13 dummysavingaccount savingsownerid dummy_savingsownerid savingsownernumber savingsownername nbsavingaccounts savingsaccounttype1 savingsjointaccount1 banktype1 savingsbankname1 savingsbankplace1 savingsamount1 savingspurpose1 covsavinguse1 dummydebitcard1 dummycreditcard1 covsavinguseamount1 usedebitcard1 reasonnotusedebitcard1 usecreditcard1 savingsaccountdate1 datedebitcard1 datecreditcard1 savingsaccounttype2 savingsjointaccount2 banktype2 savingsbankname2 savingsbankplace2 savingsamount2 savingspurpose2 covsavinguse2 dummydebitcard2 dummycreditcard2 covsavinguseamount2 usedebitcard2 savingsaccountdate2 datedebitcard2 savingsaccounttype3 banktype3 savingsbankname3 savingsbankplace3 savingsamount3 savingspurpose3 covsavinguse3 dummydebitcard3 dummycreditcard3 covsavinguseamount3 usedebitcard3 savingsaccountdate3 datedebitcard3 savingsaccounttype4 banktype4 savingsbankname4 savingsbankplace4 savingsamount4 savingspurpose4 covsavinguse4 dummydebitcard4 dummycreditcard4 usedebitcard4 savingsaccountdate4 datedebitcard4

* Gold
global ord14 dummygold covsoldgold covsoldgoldquantity covlostgold goldownerid dummy_goldownerid goldnumber goldownername goldquantity dummygoldpledged goldquantitypledge goldamountpledge covgoldpledged goldreasonpledge loanamountgold lenderscastegold lenderfromgold loansettledgold loanbalancegold loandategold goldreasonpledgemain goldquantityamount

* Insurance
global ord15 dummyinsurance reasonnoinsurance insuranceownerid dummy_insuranceownerid insuranceownernumber insuranceownername nbinsurance insurancetype1 insurancename1 insurancepublic1 insurancepaymentfrequency1 insuranceamount1 insurancebenefit1 insurancebenefitamount1 insurancejoineddate1 insurancetype2 insurancename2 insurancepublic2 insurancepaymentfrequency2 insuranceamount2 insurancebenefit2 insurancebenefitamount2 insurancejoineddate2 insurancetype3 insurancename3 insurancepublic3 insurancepaymentfrequency3 insuranceamount3 insurancebenefit3 insurancebenefitamount3 insurancejoineddate3 insurancetype4 insurancename4 insurancepublic4 insurancepaymentfrequency4 insuranceamount4 insurancebenefit4 insurancejoineddate4 insurancetype5 insurancename5 insurancepublic5 insurancepaymentfrequency5 insuranceamount5 insurancebenefit5 insurancejoineddate5 insurancetype6 insurancename6 insurancepublic6 insurancepaymentfrequency6 insuranceamount6 insurancebenefit6 insurancejoineddate6

* Mobile finance
global ord15bis usemobilefinance usemobilefinancetype usemobilefinanceother

* Land
global ord16 covsellland dummyeverhadland reasonnoland reasonnolandother ownland sizeownland drywetownland waterfromownland leaseland sizeleaseland drywetleaseland waterfromleaseland landpurchased landpurchasedacres landpurchasedamount landpurchasedhowbuy landlost landlostreason dummyleasedland landleasername landleaserrelation landleasercaste dummyleasingland landleasingname landleasingrelation landleasingcaste sizedryownland sizewetownland landpurchasedhowbuy_6 landleasingrelation_5 amountownlanddry amountownlandwet amountownland

* Cropping
global ord17 productlist covsubsistence covsubsistencereason covsubsistencesize covsubsistencenext covsubsistencereasonother covharvest covselfconsumption covharvestquantity covharvestprices productother productname1 productacre1 productypeland1 productunit1 productunitchoice1 productnbchoice1 productselfconsumption1 productnbchoicesold1 productpricesold1 productexpenses1 productpaidworkers1 productnbpaidworkers1 productlabourcost1 productunpaidworkers1 productnbunpaidworkers1 productnbhhmembers1 productoriginlabourers1 productcastelabourers1 productname2 productacre2 productypeland2 productunit2 productunitchoice2 productnbchoice2 productselfconsumption2 productnbchoicesold2 productpricesold2 productexpenses2 productpaidworkers2 productnbpaidworkers2 productlabourcost2 productunpaidworkers2 productnbunpaidworkers2 productnbhhmembers2 productoriginlabourers2 productcastelabourers2 productname3 productacre3 productypeland3 productunit3 productunitchoice3 productnbchoice3 productselfconsumption3 productnbchoicesold3 productpricesold3 productexpenses3 productpaidworkers3 productnbpaidworkers3 productlabourcost3 productunpaidworkers3 productnbunpaidworkers3 productnbhhmembers3 productoriginlabourers3 productcastelabourers3 productname4 productacre4 productypeland4 productunit4 productunitchoice4 productnbchoice4 productselfconsumption4 productnbchoicesold4 productpricesold4 productexpenses4 productpaidworkers4 productnbpaidworkers4 productlabourcost4 productunpaidworkers4 productnbunpaidworkers4 productnbhhmembers4 productoriginlabourers4 productcastelabourers4 productname5 productacre5 productypeland5 productunit5 productunitchoice5 productnbchoice5 productselfconsumption5 productnbchoicesold5 productpricesold5 productexpenses5 productpaidworkers5 productnbpaidworkers5 productlabourcost5 productunpaidworkers5 productnbunpaidworkers5 productnbhhmembers5 productoriginlabourers5 productcastelabourers5 productname9 productacre9 productypeland9 productunit9 productunitchoice9 productnbchoice9 productselfconsumption9 productnbchoicesold9 productpricesold9 productexpenses9 productpaidworkers9 productnbpaidworkers9 productlabourcost9 productunpaidworkers9 productnbunpaidworkers9 productnbhhmembers9 productoriginlabourers9 productcastelabourers9 productname11 productacre11 productypeland11 productunit11 productunitchoice11 productnbchoice11 productselfconsumption11 productnbchoicesold11 productpricesold11 productexpenses11 productpaidworkers11 productnbpaidworkers11 productlabourcost11 productunpaidworkers11 productnbunpaidworkers11 productnbhhmembers11 productoriginlabourers11 productcastelabourers11 productname12 productacre12 productypeland12 productunit12 productunitchoice12 productnbchoice12 productselfconsumption12 productnbchoicesold12 productpricesold12 productexpenses12 productpaidworkers12 productnbpaidworkers12 productlabourcost12 productunpaidworkers12 productnbunpaidworkers12 productnbhhmembers12 productoriginlabourers12 productcastelabourers12 productname14 productacre14 productypeland14 productunit14 productunitchoice14 productnbchoice14 productselfconsumption14 productnbchoicesold14 productpricesold14 productexpenses14 productpaidworkers14 productnbpaidworkers14 productlabourcost14 productunpaidworkers14 productnbunpaidworkers14 productnbhhmembers14 productoriginlabourers14 productcastelabourers14 productcastelabourers_15 productcastelabourers_11

* Livestock
global ord18 livestocklist covselllivestock covselllivestock_cow covselllivestock_goat covselllivestock_chicken covselllivestock_bullock covselllivestock_bullforploughin covselllivestock_none dummycattleloss dummycattlesold cattlesoldreason livestocknb_cow livestockprice_cow livestockuse_cow livestocknb_goat livestockprice_goat livestockuse_goat livestocknb_chicken livestockprice_chicken livestockuse_chicken livestocknb_bullock livestockprice_bullock livestockuse_bullock livestocknb_bullforploughing livestockprice_bullforploughing livestockuse_bullforploughing livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock livestockamount_bullforploughing

* Farm equipment
global ord19 equipmentlist equipmentlist_tractor equipmentlist_bullockcar equipmentlist_harvester equipmentlist_plowingmac equipmentlist_none equipmentborrowedlist equipmentborrowedlist_tractor equipmentborrowedlist_bullockcar equipmentborrowedlist_harvester equipmentborrowedlist_plowingmac equipmentborrowedlist_none covsellequipment covsellequipment_tractor covsellequipment_bullockcar covsellequipment_harvester covsellequipment_plowingmac covsellequipment_none equipmentname_tractor equipmentnb_tractor equipementyear1 equipmentcost_tractor equipmentpledged_tractor equipmentname_bullockcart equipmentnb_bullockcart equipementyear2 equipmentcost_bullockcart equipmentpledged_bullockcart equipmentname_plowingmach equipmentnb_plowingmach equipementyear4 equipmentcost_plowingmach equipmentpledged_plowingmach

* Expenses
global ord20 decisionconsumption foodexpenses decisionhealth healthexpenses ceremoniesexpenses ceremoniesrelativesexpenses deathexpenses covfoodenough covfoodquality covgenexpenses covexpensesdecrease covexpensesincrease covexpensesstable covplacepurchase covsick

* Goods
global ord21 listgoods othergood covsellgoods covsellgoods_car covsellgoods_bike covsellgoods_fridge covsellgoods_furniture covsellgoods_tailormach covsellgoods_phone covsellgoods_landline covsellgoods_DVD covsellgoods_camera covsellgoods_cookgas covsellgoods_computer covsellgoods_antenna covsellgoods_other covsellgoods_none covsellgoodsother goodname_car numbergoods_car goodyearpurchased_car goodtotalamount_car goodbuying_car goodname_bike numbergoods_bike goodyearpurchased_bike goodtotalamount_bike goodbuying_bike goodsourcecredit_bike goodcreditsettled_bike goodname_fridge numbergoods_fridge goodyearpurchased_fridge goodtotalamount_fridge goodbuying_fridge goodsourcecredit_fridge goodcreditsettled_fridge goodname_furniture numbergoods_furniture goodyearpurchased_furniture goodtotalamount_furniture goodbuying_furniture goodname_tailormach numbergoods_tailormach goodyearpurchased_tailormach goodtotalamount_tailormach goodbuying_tailormach goodname_phone numbergoods_phone goodyearpurchased_phone goodtotalamount_phone goodbuying_phone goodsourcecredit_phone goodcreditsettled_phone goodname_landline numbergoods_landline goodyearpurchased_landline goodtotalamount_landline goodbuying_landline goodname_camera numbergoods_camera goodyearpurchased_camera goodtotalamount_camera goodbuying_camera goodname_cookgas numbergoods_cookgas goodyearpurchased_cookgas goodtotalamount_cookgas goodbuying_cookgas goodsourcecredit_cookgas goodcreditsettled_cookgas goodname_computer numbergoods_computer goodyearpurchased_computer goodtotalamount_computer goodbuying_computer goodname_antenna numbergoods_antenna goodyearpurchased_antenna goodtotalamount_antenna goodbuying_antenna goodtotalamount_DVD

* Marriage
global ord22 dummymarriage marriedlist dummy_marriedlist marriedname marriagesomeoneelse marriedid peoplewedding husbandwifecaste marriagetype marriageblood marriagearranged marriagedecision marriagespousefamily marriagedowry engagementtotalcost engagementhusbandcost engagementwifecost marriagetotalcost marriagehusbandcost marriagewifecost howpaymarriage marriageloannb marriageexpenses dummymarriagegift marriagegiftsource marriagedate old_marriedid marriagepb

* Housing
global ord23 house howbuyhouse covsellhouse rentalhouse housevalue housetype housesize houseroom housetitle ownotherhouse covsellplot otherhouserent otherhousevalue dummysaleproperty incomesaleproperty useincomesaleproperty electricity water toiletfacility notoiletreason noowntoilet

* Schemes
global ord24 dummy_schemeslist dummy_nregarecipientlist dummy_schemerecipientlist3 dummy_schemerecipientlist4 dummy_schemerecipientlist5 dummy_schemerecipientlist6 dummy_schemerecipientlist7 dummy_schemerecipientlist8 dummy_schemerecipientlist9 dummy_schemerecipientlist10 schemeslist	nregarecipientlist	nregarecipientid	nregarecipientname	nreganberdaysworked	nregaincome rationcardnber rationcardmembers rationcarduse covrationcarduse covproductavailability rationcardreasonnouse freehousescheme freehousebenefittype schemeamount0 schemeyearbenefited1 schemeamount1 schemeyearfreepatta schemeamountfreepatta schemeyeargirlprotection schemeamountgirlprotection schemeyearshgloan schemeamountshgloan schemeyearbenefited2 schemeamount2 schemeyearbenefited3 schemeamount3 schemeyearbenefited4 schemeamount4 schemeyearbenefited5 schemeamount5 schemelandyearbenefited schemelandsize	schemerecipientlist3	schemerecipientid3	schemerecipientname3	schemeyearbenefited7	schemeamount7	schemerecipientlist4	schemerecipientid4	schemerecipientname4	schemeyearbenefited8	schemeamount8	schemerecipientlist5	schemerecipientid5	schemerecipientname5	schemepensionamount1	schemepensionsdate1	schemerecipientlist6	schemerecipientid6	schemerecipientname6	schemepensionamount2	schemepensiondate2	schemerecipientlist7	schemerecipientid7	schemerecipientname7	schemepensionamount3	schemepensiondate3	schemerecipientlist8	schemerecipientid8	schemerecipientname8	schemepensionamount4	schemepensiondate4	schemerecipientlist9	schemerecipientid9	schemerecipientname9	schemepensionamount5	schemepensiondate5	schemerecipientlist10	schemerecipientid10	schemerecipientname10	schemepensiondate6	schemepensionamount6 housingschemesdate


*** questionnaire ego
global eg1 everwork	workpastsevendays	searchjob	startbusiness	reasondontsearchjob	searchjobsince15	businessafter15	reasondontsearchjobsince15	nbermonthsearchjob	

global eg2 kindofworkfirstjob	unpaidinbusinessfirstjob	agestartworking	agestartworkingpaidjob	methodfindfirstjob	snfindfirstjob	othermethodfindfirstjob	jobfirstwagefrequencycash	jobfirstwageamountcash	monthstofindjob maxhoursayear selected_occupposition selected_occupname	dummymainoccupation2 occupation1 occupation2 occupation3 occupation4 occupation5 occupation6 occupation7 occupation8 nbofoccupations	othermainoccupation2

global eg3	dummyseasonalmainoccup	selected_months inddaysamonth	inddaysayear2	indhoursaday2	inddaysamonth3	indhoursaday3 indhoursamonth3 indhoursayear1 indhoursayear2 indhoursayear3 indhoursayear	beforemainoccup	otherbeforemainoccup	otherbeforemainoccupduration	mainoccuptype	dummypreviouswagejob	previousjobcontract	reasonstoppedwagejob	otherreasonstoppedjob	annualincomeindself	businessamountinvest	businesslossinvest	businesslossinvestamount	covdifficulties	businesssourceinvest	otherbusinesssourceinvestment	numberbusinessloan

global eg4 snbusinesslender1 snbusinesslender2 snbusinesslender3 snbusinesslender4 snbusinesslender5 snbusinesslender6 businessnbworkers	dummybusinessunpaidworkers	businessnbunpaidworkers	businessnbfamilyworkers	dummybusinesspaidworkers	businessnbpaidworkers businessworkersfrequency	businesslaborcost	frequencygrossreceipt	amountgrossreceipt	businessfixedcosts	businessfixedcostsamount	businessexpenses	businesssocialsecurity	businesspaymentinkind	businesspaymentinkindlist	

global eg5 snrecruitworker	snrecruitworkernamelist	snrecruitworkername1 snrecruitworkername2 snrecruitworkername3 snrecruitworkername4 snrecruitworkername5

global eg6 contract	wagejobtype	wagejobsocialsecurity	jobwagefrequencycash	jobwageamountcash wageamountmonth wageamountmonth1 wageamountmonth2 wageamountmonth3 wageamountmonth4	wagejobpaymentinkind	wagejobpaymentinkindlist sumwagejobpaymentinkindvalue

global eg7	decisionwork	decisionearnwork	opinionworkingwoman	opinionactivewoman	decisionworkother	decisionearnworkother 

global eg8	readystartjob	methodfindjob	jobpreference	moveoutsideforjob	moveoutsideforjobreason	moveoutsideforjobreasonother	aspirationminimumwage	dummyaspirationmorehours	reasondontworkmore	aspirationminimumwage2	

global eg9 respect	workmate	useknowledgeatwork	satisfyingpurpose	schedule	takeholiday	agreementatwork1	agreementatwork2	agreementatwork3	agreementatwork4	changework	happywork	satisfactionsalary	executionwork1	executionwork2	executionwork3	executionwork4	executionwork5	executionwork6	executionwork7	executionwork8	executionwork9	accidentalinjury	losswork	lossworknumber	mostseriousincident	mostseriousinjury	seriousinjuryother	physicalharm	problemwork1	problemwork2	problemwork4	problemwork5	problemwork6	problemwork7	problemwork8	problemwork9	problemwork10	workexposure1	workexposure2	workexposure3	workexposure4	workexposure5	professionalequipment	break	retirementwork	verbalaggression	physicalagression	sexualharassment	sexualaggression	discrimination1	discrimination2	discrimination3	discrimination4	discrimination5	discrimination6	discrimination7	discrimination8	discrimination9	resdiscrimination1	resdiscrimination2	resdiscrimination3	resdiscrimination4	resdiscrimination5	rurallocation	lackskill	

global eg10 a1	a2	a3	a4	a5	a6	a7	a8	a9	a10	a11	a12	b1	b2	b3	b4	b5	b6	b7	b8	b9	b10	b11	b12 ab1	ab2	ab3	ab4	ab5	ab6	ab7	ab8	ab9	ab10 ab11	ab12 enjoypeople	curious	organized	managestress	interestedbyart	tryhard	workwithother	makeplans	sharefeelings	nervous	stickwithgoals	repetitivetasks	shywithpeople	workhard	changemood	understandotherfeeling	inventive	enthusiastic	feeldepressed	appointmentontime	trustingofother	goaftergoal	easilyupset	talktomanypeople	liketothink	finishwhatbegin	putoffduties	rudetoother	finishtasks	toleratefaults	worryalot	easilydistracted	keepworking	completeduties	talkative	newideas	staycalm	forgiveother	activeimagination	expressingthoughts	helpfulwithothers	canreadcard1a	canreadcard1b	canreadcard1c	canreadcard2	numeracy1	numeracy2	numeracy3	numeracy4	numeracy5	numeracy6 locuscontrol1	locuscontrol2	locuscontrol3	locuscontrol4	locuscontrol5	locuscontrol6


global eg11	associationlist	covassociationhelp	covassociationhelplist	covassociationhelplistother	covassociationhelptype	covassociationhelptypeother snrecommendassoname1 snrecommendassoname10 snrecommendassoname11 snrecommendassoname12 snrecommendassoname13 snrecommendassoname14 snrecommendassoname15 snrecommendassoname16 snrecommendassoname17 snrecommendassoname18 snrecommendassoname19 snrecommendassoname2 snrecommendassoname20 snrecommendassoname21 snrecommendassoname22 snrecommendassoname23 snrecommendassoname24 snrecommendassoname3 snrecommendassoname4 snrecommendassoname5 snrecommendassoname6 snrecommendassoname7 snrecommendassoname8 snrecommendassoname9

global eg12 snfindcurrentjob snfindcurrentjobname1 snfindcurrentjobname2 snfindcurrentjobname3 snfindcurrentjobname4 snfindcurrentjobname5 snfindcurrentjobnamelist snfindjob snfindjobname1 snfindjobname2 snfindjobname3 snfindjobname4 snfindjobname5 snfindjobnamelist snrecommendforjob snrecommendforjobnamelist snrecommendforjobname1 snrecommendforjobname2 snrecommendforjobname3 snrecommendforjobname4 snrecommendforjobname5 snrecojobsuccess snrecojobsuccessname1 snrecojobsuccessname2 snrecojobsuccessname3 snrecojobsuccessname4 snrecojobsuccessname5 snrecojobsuccessnamelist sntalkthemost sntalkthemostname1 sntalkthemostname2 sntalkthemostname3 sntalkthemostname4 snhelpemergency snhelpemergencyname1 snhelpemergencyname2 snhelpemergencyname3 snhelpemergencyname4 snhelpemergencyname5 sncloserelouthh sncloserelouthhname1 sncloserelouthhname2 sncloserelouthhname3 sncloserelouthhname4 covsnhelpreceived covsnhelpreceivedlist covsnhelpreceivedname1 covsnhelpreceivedname2 covsnhelpreceivedname3 covsnhelpreceivedname4 covsnhelpreceivedname5 covsnhelpgiven covsnhelpgivenlist 

global eg13	nbercontactphone	nberpersonfamilyevent	contactlist	dummycontactleaders	contactleaders	

global eg14 networktrustneighborhood	covneworktrustneighborhood	networktrustemployees	networkpeoplehelping	covnetworkpeoplehelping	networkhelpkinmember	covnetworkhelpkinmember	covinstit1	covinstit2	covinstit3	covinstit4	covinstit5	covcontactinstitution	covinstit6	covinstit7	covinstit8	covinstit9	covinstit10		

global eg15	covmostefficienthelp	covmostefficienthelpother	covmostefficienthelpopen


* Arnaud
global arnaud annualincome_indiv worker annualincome_HH working_pop loans_HH loanamount_HH nboccupation_indiv nboccupation_HH edulevel assets assets_noland raven_tt num_tt lit_tt cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit OP CO EX AG ES Grit totalincome_indiv totalincome_HH loans_indiv loanamount_indiv caste dummyego mainocc_kindofwork_indiv mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_hoursayear_indiv mainocc_annualincome_indiv mainocc_jobdistance_indiv mainocc_occupationname_indiv mainocc_kindofwork_HH mainocc_occupation_HH dummy_respondent2020 cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot cr_staycalm cr_tryhard cr_stickwithgoals cr_goaftergoal cr_finishwhatbegin cr_finishtasks cr_keepworking ra1 rab1 rb1 ra2 rab2 rb2 ra3 rab3 rb3 ra4 rab4 rb4 ra5 rab5 rb5 ra6 rab6 rb6 ra7 rab7 rb7 ra8 rab8 rb8 ra9 rab9 rb9 ra10 rab10 rb10 ra11 rab11 rb11 ra12 rab12 rb12 set_a set_ab set_b goodtotalamount2 refuse ars ars2 ars3

* Asso
global assoQ associationtype_shg associationname_shg assodegreeparticip_shg assosize_shg dummyassorecommendation_shg associationtype_trade associationname_trade assodegreeparticip_trade assosize_trade dummyassorecommendation_trade associationtype_farmer associationname_farmer assodegreeparticip_farmer assosize_farmer dummyassorecommendation_farmer associationtype_village associationname_village assodegreeparticip_village assosize_village dummyassorecommendation_village associationtype_politic associationname_politic assodegreeparticip_politic assosize_politic dummyassorecommendation_politic associationtype_profess associationname_profess assodegreeparticip_profess assosize_profess dummyassorecommendation_profess associationtype_hobby associationname_hobby assodegreeparticip_hobby assosize_hobby dummyassorecommendation_hobby associationtype_alumni associationname_alumni assodegreeparticip_alumni assosize_alumni dummyassorecommendation_alumni associationtype_other associationname_other assodegreeparticip_other assosize_other dummyassorecommendation_other nbcontact_headbusiness nbcontact_policeman nbcontact_civilserv nbcontact_bankemployee nbcontact_panchayatcommittee nbcontact_peoplecouncil nbcontact_recruiter nbcontact_headunion



********** Order
order $ord1 $ord2 $ord3 $ord4 $ord5 $ord6 $ord7 $ord8 $ord9 $ord10 $ord11 $ord12 $ord13 $ord14 $ord15 $ord15bis $ord16 $ord17 $ord18 $ord19 $ord20 $ord21 $ord22 $ord23 $ord24 $eg1 $eg2 $eg3 $eg4 $eg5 $eg6 $eg7 $eg8 $eg9 $eg10 $eg11 $eg12 $eg13 $eg14 $eg15 $arnaud // 

drop $assoQ

drop reasonnotworkpastyearfrom covmostefficienthelpfrom countcovsnhelpgiven countcovsnhelpreceived rationcardreasonnouse_4 rationcardreasonnouse_5 reasondropping_14 reasonneverattendedschool_2 reasonneverattendedschool_9 reasonnotusedebitcard_4 reasonnotusedebitcard_6 selected_months_monthsid

*Last label
foreach x in $arnaud {
label var `x' "Arnaud"
}


save"$directory\CLEAN\LAST\NEEMSIS2-HH_v21.dta", replace
****************************************
* END



/*






****************************************
* Check of duplicates for HH datasets
****************************************

********** Raw datasets
foreach x in APRIL DEC DECEMBER FEB FEBRUARY LAST NEW_APRIL NEW_JUNE {
use"$directorybis\NEEMSIS2_`x'\NEEMSIS2_`x'.dta", clear
gen version="`x'"
save"$directory\CLEAN\_tomove\NEEMSIS2_`x'.dta", replace
}


use"$directory\CLEAN\_tomove\NEEMSIS2_APRIL.dta", clear
foreach x in DEC DECEMBER FEB FEBRUARY LAST NEW_APRIL NEW_JUNE {
append using "$directory\CLEAN\_tomove\NEEMSIS2_`x'.dta", force
}

replace name1=namefrompreload1 if name1=="" & namefrompreload1!=""
replace name2=namefrompreload2 if name2=="" & namefrompreload2!=""
replace name3=namefrompreload3 if name3=="" & namefrompreload3!=""

rename key parent_key
destring householdid, replace
sort householdid
order parent_key householdid name1 name2 name3 submissiondate

***** Duplicates
gen todrop=0

*** Former HH
replace todrop=1 if parent_key=="uuid:73af0a16-d6f8-4389-b117-2c40d591b806"  // householdid==36 & name1=="Natesan"
replace todrop=1 if parent_key=="uuid:2cca6f5f-3ecb-4088-b73f-1ecd9586690d"  // householdid==67 & name1=="Shankar"
replace todrop=1 if parent_key=="uuid:1ea7523b-cad1-44da-9afa-8c4f96189433"  // householdid==124 & name1=="Subramani"
replace todrop=1 if parent_key=="uuid:9b931ac2-ef49-43e9-90cd-33ae0bf1928f"  // householdid==246 & name1=="Sornambal"
replace todrop=1 if parent_key=="uuid:b283cb62-a316-418a-80b5-b8fe86585ef8"  // householdid==343 & name1=="Ramamoorthi"
replace todrop=1 if parent_key=="uuid:5a19b036-4004-4c71-9e2a-b4efd3572cf3"  // householdid==348 & name1=="Govindan"
replace todrop=1 if parent_key=="uuid:7fc65842-447f-4b1d-806a-863556d03ed3"  // householdid==361 & name1=="Mallika"
replace todrop=1 if parent_key=="uuid:d0cd220f-bec1-49b8-a3ff-d70f82a3b231"  // householdid==391 & name1=="Balaji"

*** New HH
replace todrop=1 if parent_key=="uuid:b73883fb-2b91-4db1-a117-9b198de7847b"  // householdid==532 & name1=="Shakthivel" & name2=="Revathy"
replace todrop=1 if parent_key=="uuid:73333f70-a553-4cbb-8df7-59284b9fcb66"  // householdid==534 & name1=="Karunanidhi"
replace todrop=1 if parent_key=="uuid:63543454-ff4f-46f4-a07e-30e8032cf1bc"  // householdid==547 & name1=="Surya" (duplicates with "uuid:ae72a34f-f968-45f4-acfa-91f571f54ea8")

sort householdid todrop name1
order parent_key householdid todrop name1 name2 name3 submissiondate

drop if todrop==1
ta parent_key, m




********** Clean datasets
use"$directory\CLEAN\NEEMSIS2-HH_v20.dta", clear

preserve
duplicates drop HHID_panel, force
ta caste, m
restore

preserve
duplicates drop parent_key, force
ta caste, m
restore

/*
Total of 643 HH but 11 are duplicates which means that
our total sample is 632 HH
*/
****************************************
* END











****************************************
* Check of duplicates for agri datasets
****************************************

********** Raw datasets
foreach x in Agriculture DEC_Agriculture DECEMBER_Agriculture FEB_NEW_Agriculture FEBRUARY_Agriculture {
use"$directorybis\NEEMSIS2_`x'\NEEMSIS2_`x'.dta", clear
gen version="`x'"
save"$directory\CLEAN\_tomove\NEEMSIS2_`x'.dta", replace
}


use"$directory\CLEAN\_tomove\NEEMSIS2_Agriculture.dta", clear
foreach x in DEC_Agriculture DECEMBER_Agriculture FEB_NEW_Agriculture FEBRUARY_Agriculture {
append using "$directory\CLEAN\_tomove\NEEMSIS2_`x'.dta", force
}

rename key parent_key
destring householdid, replace
sort householdid
order parent_key householdid namenewhead submissiondate

***** Duplicates
gen todrop=0

*** Former HH
replace todrop=1 if parent_key=="uuid:244d058e-b68a-4271-bf5f-5332dca88f8f"  // householdid==36
replace todrop=1 if parent_key=="uuid:7e235580-30be-4dea-8982-68ed963b45c8"  // householdid==67
replace todrop=1 if parent_key=="uuid:ece23449-7f67-4de2-b7da-3ea48d4d33dd"  // householdid==235
replace todrop=1 if parent_key=="uuid:953d8941-5338-4a82-a5d7-2f6e25947e5d"  // householdid==246
replace todrop=1 if parent_key=="uuid:f52b0fb0-064b-4133-a78d-83edcd80b3e1"  // householdid==343
replace todrop=1 if parent_key=="uuid:08b045f7-ca13-429c-b25b-604ed8786a32"  // householdid==348
replace todrop=1 if parent_key=="uuid:332b0700-6bdb-4e66-92ee-7f1e892dae6a"  // householdid==361
replace todrop=1 if parent_key=="uuid:6854d50b-0b75-4b24-a3b8-ee031aa78668"  // householdid==391

*** New HH
replace todrop=1 if parent_key=="uuid:f98d6d16-e1cb-4504-8475-9414a295c014"  // householdid==534
replace todrop=1 if parent_key=="uuid:0c5b2989-3bf7-49db-b6e4-ab455dfee7fe"  // householdid==547 (duplicates with "uuid:211fcb9c-19d7-4e89-9285-488a1a6588be")

sort householdid todrop
order parent_key householdid todrop

drop if todrop==1
ta parent_key, m



********** Clean datasets
use"$directory\CLEAN\_tomove\NEEMSIS_Agriculture_APPEND_v3.dta", clear
*632

/*
Total of 642 HH but 10 are duplicates which means that
our total sample is 632 HH
*/
****************************************
* END
