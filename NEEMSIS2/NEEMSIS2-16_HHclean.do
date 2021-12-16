cls
/*
-------------------------
Arnaud Natal
November 30, 2021
-----
TITLE: CLEANING HH
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
* MERGE 123
****************************************
use"$directory\CLEAN\NEEMSIS2-HH_v21.dta", clear

********** HH
preserve
use"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-mainoccupschedule-indoccupmonths_v2.dta", clear
drop key setof_2indoccupmonths setof_3indoccupmonths setofindoccupmonths
destring monthid, replace
egen indiv=concat(parent_key egoid), p(-/)
reshape wide monthname inddaysamonth indhoursaday indhoursamonth, j(monthid) i(indiv)
drop monthname1 monthname2 monthname3 monthname4 monthname5 monthname6 monthname7 monthname8 monthname9 monthname10 monthname11 monthname12
foreach x in inddaysamonth indhoursaday indhoursamonth {
rename `x'1 `x'_chithirai
rename `x'2 `x'_vaikasi
rename `x'3 `x'_aani
rename `x'4 `x'_aadi
rename `x'5 `x'_aavani
rename `x'6 `x'_purataasi
rename `x'7 `x'_iypasi
rename `x'8 `x'_karthigai
rename `x'9 `x'_maargazhi
rename `x'10 `x'_thai
rename `x'11 `x'_maasi
rename `x'12 `x'_panguni
}
destring inddaysamonth_chithirai indhoursaday_chithirai indhoursamonth_chithirai inddaysamonth_vaikasi indhoursaday_vaikasi indhoursamonth_vaikasi inddaysamonth_aani indhoursaday_aani indhoursamonth_aani inddaysamonth_aadi indhoursaday_aadi indhoursamonth_aadi inddaysamonth_aavani indhoursaday_aavani indhoursamonth_aavani inddaysamonth_purataasi indhoursaday_purataasi indhoursamonth_purataasi inddaysamonth_iypasi indhoursaday_iypasi indhoursamonth_iypasi inddaysamonth_karthigai indhoursaday_karthigai indhoursamonth_karthigai inddaysamonth_maargazhi indhoursaday_maargazhi indhoursamonth_maargazhi inddaysamonth_thai indhoursaday_thai indhoursamonth_thai inddaysamonth_maasi indhoursaday_maasi indhoursamonth_maasi inddaysamonth_panguni indhoursaday_panguni indhoursamonth_panguni, replace
drop indiv
order parent_key egoid
save"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-mainoccupschedule-indoccupmonths_wide_v2.dta", replace
ta egoid
restore
* Merge 
merge m:1 parent_key egoid using "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-mainoccupschedule-indoccupmonths_wide_v2.dta"
ta egoid
drop _merge





preserve
use"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indwagejob-wagejobpaymentinkindgroup_v2.dta", clear
drop key setof_2wagejobpaymentinkindgroup setof_3wagejobpaymentinkindgroup setofwagejobpaymentinkindgroup
destring wagejobpaymentinkindid, replace
egen indiv=concat(parent_key egoid), p(-/)
reshape wide wagejobpaymentinkindname wagejobpaymentinkindvalue, i(indiv) j(wagejobpaymentinkindid)
drop wagejobpaymentinkindname1 wagejobpaymentinkindname2 wagejobpaymentinkindname3 wagejobpaymentinkindname4 wagejobpaymentinkindname5 wagejobpaymentinkindname6
foreach x in wagejobpaymentinkindvalue {
rename `x'1 `x'_clot
rename `x'2 `x'_food
rename `x'3 `x'_trsp
rename `x'4 `x'_acco
rename `x'5 `x'_labo
}
drop indiv wagejobpaymentinkindvalue6
order parent_key egoid
save"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indwagejob-wagejobpaymentinkindgroup_wide_v2.dta", replace
ta egoid
restore
* Merge
merge m:1 parent_key egoid using "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indwagejob-wagejobpaymentinkindgroup_wide_v2.dta"
ta egoid
drop _merge


preserve
use"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemployment-businesspaymentinkindgroup_v2.dta", clear
drop key setof_2businesspaymentinkindgrou
destring businesspaymentinkindid, replace
egen indiv=concat(parent_key egoid), p(-/)
reshape wide businesspaymentinkindname businesspaymentinkindvalue, i(indiv) j(businesspaymentinkindid)
drop businesspaymentinkindname1 businesspaymentinkindname2 businesspaymentinkindname3 businesspaymentinkindname4 businesspaymentinkindname5 businesspaymentinkindname6
foreach x in businesspaymentinkindvalue {
rename `x'1 `x'_clot
rename `x'2 `x'_food
rename `x'3 `x'_trsp
rename `x'4 `x'_acco
rename `x'5 `x'_labo
}
drop indiv businesspaymentinkindvalue6
order parent_key egoid
save"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemployment-businesspaymentinkindgroup_wide_v2.dta", replace
ta egoid
restore
* Merge
merge m:1 parent_key egoid using "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-characteristicsmainjob-indselfemployment-businesspaymentinkindgroup_wide_v2.dta"
ta egoid
drop _merge
save"$directory\CLEAN\NEEMSIS2-HH_v22.dta", replace

****************************************
* END









****************************************
* MERGE 123
****************************************
preserve
use"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-covoccupationfieldlist_v2.dta", clear
drop key setofcovoccupationfieldlist setof_2covoccupationfieldlist
append using "$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-covoccupationfield_v2.dta"
drop key setof_3covoccupationfield
save"$directory\CLEAN\NEEMSIS_APPEND-ego123questionnaire-individualemployment-covoccupationfield.dta", replace
restore
****************************************
* END










****************************************
* Cleaning HH
****************************************
use "$directory\CLEAN\NEEMSIS2-HH_v22.dta", clear

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

drop key 


drop ego2potential newmember9 newmember10 newmember11 newmember12 newmember13 newmember14

drop livinghome2016 

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

global eg3	dummyseasonalmainoccup	selected_months inddaysamonth_chithirai indhoursaday_chithirai indhoursamonth_chithirai inddaysamonth_vaikasi indhoursaday_vaikasi indhoursamonth_vaikasi inddaysamonth_aani indhoursaday_aani indhoursamonth_aani inddaysamonth_aadi indhoursaday_aadi indhoursamonth_aadi inddaysamonth_aavani indhoursaday_aavani indhoursamonth_aavani inddaysamonth_purataasi indhoursaday_purataasi indhoursamonth_purataasi inddaysamonth_iypasi indhoursaday_iypasi indhoursamonth_iypasi inddaysamonth_karthigai indhoursaday_karthigai indhoursamonth_karthigai inddaysamonth_maargazhi indhoursaday_maargazhi indhoursamonth_maargazhi inddaysamonth_thai indhoursaday_thai indhoursamonth_thai inddaysamonth_maasi indhoursaday_maasi indhoursamonth_maasi inddaysamonth_panguni indhoursaday_panguni indhoursamonth_panguni inddaysayear2	indhoursaday2	inddaysamonth3	indhoursaday3 indhoursamonth3 indhoursayear1 indhoursayear2 indhoursayear3 indhoursayear	beforemainoccup	otherbeforemainoccup	otherbeforemainoccupduration	mainoccuptype	dummypreviouswagejob	previousjobcontract	reasonstoppedwagejob	otherreasonstoppedjob	annualincomeindself	businessamountinvest	businesslossinvest	businesslossinvestamount	covdifficulties	businesssourceinvest	otherbusinesssourceinvestment	numberbusinessloan

global eg4 snbusinesslender1 snbusinesslender2 snbusinesslender3 snbusinesslender4 snbusinesslender5 snbusinesslender6 businessnbworkers	dummybusinessunpaidworkers	businessnbunpaidworkers	businessnbfamilyworkers	dummybusinesspaidworkers	businessnbpaidworkers businessworkersfrequency	businesslaborcost	frequencygrossreceipt	amountgrossreceipt	businessfixedcosts	businessfixedcostsamount	businessexpenses	businesssocialsecurity	businesspaymentinkind	businesspaymentinkindlist businesspaymentinkindvalue_clot businesspaymentinkindvalue_food businesspaymentinkindvalue_trsp businesspaymentinkindvalue_acco businesspaymentinkindvalue_labo	

global eg5 snrecruitworker	snrecruitworkernamelist	snrecruitworkername1 snrecruitworkername2 snrecruitworkername3 snrecruitworkername4 snrecruitworkername5

global eg6 contract	wagejobtype	wagejobsocialsecurity	jobwagefrequencycash	jobwageamountcash wageamountmonth wageamountmonth1 wageamountmonth2 wageamountmonth3 wageamountmonth4	wagejobpaymentinkind	wagejobpaymentinkindlist wagejobpaymentinkindvalue_clot wagejobpaymentinkindvalue_food wagejobpaymentinkindvalue_trsp wagejobpaymentinkindvalue_acco wagejobpaymentinkindvalue_labo sumwagejobpaymentinkindvalue

global eg7	decisionwork	decisionearnwork	opinionworkingwoman	opinionactivewoman	decisionworkother	decisionearnworkother 

global eg8	readystartjob	methodfindjob	jobpreference	moveoutsideforjob	moveoutsideforjobreason	moveoutsideforjobreasonother	aspirationminimumwage	dummyaspirationmorehours	reasondontworkmore	aspirationminimumwage2	

global eg9 respect	workmate	useknowledgeatwork	satisfyingpurpose	schedule	takeholiday	agreementatwork1	agreementatwork2	agreementatwork3	agreementatwork4	changework	happywork	satisfactionsalary	executionwork1	executionwork2	executionwork3	executionwork4	executionwork5	executionwork6	executionwork7	executionwork8	executionwork9	accidentalinjury	losswork	lossworknumber	mostseriousincident	mostseriousinjury	seriousinjuryother	physicalharm	problemwork1	problemwork2	problemwork4	problemwork5	problemwork6	problemwork7	problemwork8	problemwork9	problemwork10	workexposure1	workexposure2	workexposure3	workexposure4	workexposure5	professionalequipment	break	retirementwork	verbalaggression	physicalagression	sexualharassment	sexualaggression	discrimination1	discrimination2	discrimination3	discrimination4	discrimination5	discrimination6	discrimination7	discrimination8	discrimination9	resdiscrimination1	resdiscrimination2	resdiscrimination3	resdiscrimination4	resdiscrimination5	rurallocation	lackskill	

global eg10 a1	a2	a3	a4	a5	a6	a7	a8	a9	a10	a11	a12	b1	b2	b3	b4	b5	b6	b7	b8	b9	b10	b11	b12 ab1	ab2	ab3	ab4	ab5	ab6	ab7	ab8	ab9	ab10 ab11	ab12 enjoypeople	curious	organized	managestress	interestedbyart	tryhard	workwithother	makeplans	sharefeelings	nervous	stickwithgoals	repetitivetasks	shywithpeople	workhard	changemood	understandotherfeeling	inventive	enthusiastic	feeldepressed	appointmentontime	trustingofother	goaftergoal	easilyupset	talktomanypeople	liketothink	finishwhatbegin	putoffduties	rudetoother	finishtasks	toleratefaults	worryalot	easilydistracted	keepworking	completeduties	talkative	newideas	staycalm	forgiveother	activeimagination	expressingthoughts	helpfulwithothers	canreadcard1a	canreadcard1b	canreadcard1c	canreadcard2	numeracy1	numeracy2	numeracy3	numeracy4	numeracy5	numeracy6 locuscontrol1	locuscontrol2	locuscontrol3	locuscontrol4	locuscontrol5	locuscontrol6


global eg11	associationlist	covassociationhelp	covassociationhelplist	covassociationhelplistother	covassociationhelptype	covassociationhelptypeother snrecommendassoname1 snrecommendassoname10 snrecommendassoname11 snrecommendassoname12 snrecommendassoname13 snrecommendassoname14 snrecommendassoname15 snrecommendassoname16 snrecommendassoname17 snrecommendassoname18 snrecommendassoname19 snrecommendassoname2 snrecommendassoname20 snrecommendassoname21 snrecommendassoname22 snrecommendassoname23 snrecommendassoname24 snrecommendassoname3 snrecommendassoname4 snrecommendassoname5 snrecommendassoname6 snrecommendassoname7 snrecommendassoname8 snrecommendassoname9 associationtype1 associationname1 assodegreeparticip1 assosize1 dummyassorecommendation1 snrecommendasso1 dummyassohelpjob1 assohelpjob1 assohelpjob_hiredyou1 assohelpjob_referredyou1 assohelpjob_sharedjob1 assohelpjob_helpwithappli1 assohelpjob_other1 assocotherhelpjob1 dummyassohelpbusiness1 assohelpbusiness1 assootherhelpbusiness1 associationtype2 associationname2 assodegreeparticip2 assosize2 dummyassorecommendation2 snrecommendasso2 dummyassohelpjob2 assohelpjob2 assohelpjob_hiredyou2 assohelpjob_referredyou2 assohelpjob_sharedjob2 assohelpjob_helpwithappli2 assohelpjob_other2 assocotherhelpjob2 dummyassohelpbusiness2 assohelpbusiness2 assootherhelpbusiness2


global eg12 snfindcurrentjob snfindcurrentjobname1 snfindcurrentjobname2 snfindcurrentjobname3 snfindcurrentjobname4 snfindcurrentjobname5 snfindcurrentjobnamelist snfindjob snfindjobname1 snfindjobname2 snfindjobname3 snfindjobname4 snfindjobname5 snfindjobnamelist snrecommendforjob snrecommendforjobnamelist snrecommendforjobname1 snrecommendforjobname2 snrecommendforjobname3 snrecommendforjobname4 snrecommendforjobname5 snrecojobsuccess snrecojobsuccessname1 snrecojobsuccessname2 snrecojobsuccessname3 snrecojobsuccessname4 snrecojobsuccessname5 snrecojobsuccessnamelist sntalkthemost sntalkthemostname1 sntalkthemostname2 sntalkthemostname3 sntalkthemostname4 snhelpemergency snhelpemergencyname1 snhelpemergencyname2 snhelpemergencyname3 snhelpemergencyname4 snhelpemergencyname5 sncloserelouthh sncloserelouthhname1 sncloserelouthhname2 sncloserelouthhname3 sncloserelouthhname4 covsnhelpreceived covsnhelpreceivedlist covsnhelpreceivedname1 covsnhelpreceivedname2 covsnhelpreceivedname3 covsnhelpreceivedname4 covsnhelpreceivedname5 covsnhelpgiven covsnhelpgivenlist 

global eg13	nbercontactphone	nberpersonfamilyevent	contactlist	dummycontactleaders	contactleaders nbcontact_headbusiness nbcontact_policeman nbcontact_civilserv nbcontact_bankemployee nbcontact_panchayatcommittee nbcontact_peoplecouncil nbcontact_recruiter nbcontact_headunion

global eg14 networktrustneighborhood	covneworktrustneighborhood	networktrustemployees	networkpeoplehelping	covnetworkpeoplehelping	networkhelpkinmember	covnetworkhelpkinmember	covinstit1	covinstit2	covinstit3	covinstit4	covinstit5	covcontactinstitution	covinstit6	covinstit7	covinstit8	covinstit9	covinstit10		

global eg15	covmostefficienthelp covmostefficienthelpother	covmostefficienthelpopen


* Arnaud
global arnaud version_HH version_agri edulevel s_goldquantity goldquantityamount amountownlanddry amountownlandwet amountownland goodtotalamount2 assets assets_noland ra1 rab1 rb1 ra2 rab2 rb2 ra3 rab3 rb3 ra4 rab4 rb4 ra5 rab5 rb5 ra6 rab6 rb6 ra7 rab7 rb7 ra8 rab8 rb8 ra9 rab9 rb9 ra10 rab10 rb10 ra11 rab11 rb11 ra12 rab12 rb12 set_a set_ab set_b raven_tt refuse num_tt lit_tt curious_backup interestedbyart_backup repetitivetasks_backup inventive_backup liketothink_backup newideas_backup activeimagination_backup organized_backup makeplans_backup workhard_backup appointmentontime_backup putoffduties_backup easilydistracted_backup completeduties_backup enjoypeople_backup sharefeelings_backup shywithpeople_backup enthusiastic_backup talktomanypeople_backup talkative_backup expressingthoughts_backup workwithother_backup understandotherfeeling_backup trustingofother_backup rudetoother_backup toleratefaults_backup forgiveother_backup helpfulwithothers_backup managestress_backup nervous_backup changemood_backup feeldepressed_backup easilyupset_backup worryalot_backup staycalm_backup tryhard_backup stickwithgoals_backup goaftergoal_backup finishwhatbegin_backup finishtasks_backup keepworking_backup ars ars2 ars3 cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot cr_staycalm cr_tryhard cr_stickwithgoals cr_goaftergoal cr_finishwhatbegin cr_finishtasks cr_keepworking cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit OP CO EX AG ES Grit mainocc_kindofwork_indiv mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_hoursayear_indiv mainocc_annualincome_indiv mainocc_jobdistance_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv occinc_indiv_agri occinc_indiv_agricasual occinc_indiv_nonagricasual occinc_indiv_nonagriregnonqual occinc_indiv_nonagriregqual occinc_indiv_selfemp occinc_indiv_nrega worker mainocc_kindofwork_HH mainocc_occupation_HH annualincome_HH nboccupation_HH occinc_HH_agri occinc_HH_agricasual occinc_HH_nonagricasual occinc_HH_nonagriregnonqual occinc_HH_nonagriregqual occinc_HH_selfemp occinc_HH_nrega working_pop remreceivedtotalamount_indiv remreceivedtotalamount_HH incomeassets_HH incomeassets_indiv otherhouserent_HH otherhouserent_indiv pension_indiv pension_HH totalincome_indiv totalincome_HH loans_indiv loans_gm_indiv loans_g_indiv loanamount_g_indiv loanamount_gm_indiv loanamount_indiv imp1_ds_tot_indiv imp1_is_tot_indiv loans_HH loans_gm_HH loans_g_HH loanamount_g_HH loanamount_gm_HH loanamount_HH imp1_ds_tot_HH imp1_is_tot_HH


********** Order
order $ord1 $ord2 $ord3 $ord4 $ord5 $ord6 $ord7 $ord8 $ord9 $ord10 $ord11 $ord12 $ord13 $ord14 $ord15 $ord15bis $ord16 $ord17 $ord18 $ord19 $ord20 $ord21 $ord22 $ord23 $ord24 $eg1 $eg2 $eg3 $eg4 $eg5 $eg6 $eg7 $eg8 $eg9 $eg10 $eg11 $eg12 $eg13 $eg14 $eg15 setof* $arnaud


drop reasonnotworkpastyearfrom covmostefficienthelpfrom countcovsnhelpgiven countcovsnhelpreceived rationcardreasonnouse_4 rationcardreasonnouse_5 reasondropping_14 reasonneverattendedschool_2 reasonneverattendedschool_9 reasonnotusedebitcard_4 reasonnotusedebitcard_6 selected_months_monthsid


*Setof
split setofmigrationjobidgroup, p(/)
drop setofmigrationjobidgroup3 setofmigrationjobidgroup
egen setofmigrationidgroup=concat(setofmigrationjobidgroup1 setofmigrationjobidgroup2), p(/)
replace setofmigrationidgroup="" if setofmigrationidgroup=="/"
drop setofmigrationjobidgroup1 setofmigrationjobidgroup2


save"$directory\CLEAN\NEEMSIS2-HH_v23.dta", replace
****************************************
* END









****************************************
* Gaston clean
****************************************
use"$directory\CLEAN\NEEMSIS2-HH_v23.dta", clear


********** New variables Gaston
*** Automatic part
* Son daughter
gen sondaughter=""
replace sondaughter="Daughter" if householdid2020==534 & namenewhead=="Kanadhasan"
replace sondaughter="Son" if householdid2020==549 & namenewhead=="Valarmathi"
replace sondaughter="Daughter" if householdid2020==536 & namenewhead=="Jenifer"
replace sondaughter="Daughter" if householdid2020==544 & namenewhead=="Gunasundari"
replace sondaughter="Daughter" if householdid2020==545 & namenewhead=="Devi"
replace sondaughter="Son" if householdid2020==542 & namenewhead=="Kalaiselvan"
replace sondaughter="Daughter" if householdid2020==530 & namenewhead=="Sobana"
replace sondaughter="Daughter" if householdid2020==530 & namenewhead=="Theiveegam"
replace sondaughter="Son" if householdid2020==530 & namenewhead=="Asaimani"
replace sondaughter="Daughter" if householdid2020==531 & namenewhead=="Bremsheela"
replace sondaughter="Daughter" if householdid2020==531 & namenewhead=="Padmavathi"
replace sondaughter="Daughter" if householdid2020==531 & namenewhead=="Kamalavalli"
replace sondaughter="Daughter" if householdid2020==532 & namenewhead=="Inbaraja"
replace sondaughter="Son" if householdid2020==532 & namenewhead=="Murugavel"
replace sondaughter="Daughter" if householdid2020==532 & namenewhead=="Amutha"
replace sondaughter="Son" if householdid2020==532 & namenewhead=="Duraimurugan"
replace sondaughter="Daughter" if householdid2020==532 & namenewhead=="Anusuya"
replace sondaughter="Son" if householdid2020==534 & namenewhead=="Karthikeyan"
replace sondaughter="Daughter" if householdid2020==534 & namenewhead=="Radhakrishnan"
replace sondaughter="Daughter" if householdid2020==534 & namenewhead=="Keerthika"
replace sondaughter="Son" if householdid2020==535 & namenewhead=="Senthil murugan"
replace sondaughter="Son" if householdid2020==535 & namenewhead=="Jayan"
replace sondaughter="Son" if householdid2020==535 & namenewhead=="Nirmal Kumar"
replace sondaughter="Daughter" if householdid2020==536 & namenewhead=="Thenaruvi"
replace sondaughter="Daughter" if householdid2020==537 & namenewhead=="Anandthavalli"
replace sondaughter="Daughter" if householdid2020==537 & namenewhead=="Mangayarkarasi"
replace sondaughter="Daughter" if householdid2020==537 & namenewhead=="Jayapriya"
replace sondaughter="Daughter" if householdid2020==538 & namenewhead=="shalini"
replace sondaughter="Daughter" if householdid2020==538 & namenewhead=="Krishnan"
replace sondaughter="Daughter" if householdid2020==538 & namenewhead=="Ananthi"
replace sondaughter="Daughter" if householdid2020==539 & namenewhead=="Venkatesan"
replace sondaughter="Daughter" if householdid2020==539 & namenewhead=="Athilakshmi"
replace sondaughter="Daughter" if householdid2020==539 & namenewhead=="Tamizselvi"
replace sondaughter="Daughter" if householdid2020==542 & namenewhead=="Indhumathi"
replace sondaughter="Daughter" if householdid2020==542 & namenewhead=="Gomathi"
replace sondaughter="Son" if householdid2020==543 & namenewhead=="Prakash"
replace sondaughter="Daughter" if householdid2020==543 & namenewhead=="Narasingaperumal"
replace sondaughter="Daughter" if householdid2020==543 & namenewhead=="Sivakozhundhu"
replace sondaughter="Daughter" if householdid2020==540 & namenewhead=="Nithiya"
replace sondaughter="Daughter" if householdid2020==540 & namenewhead=="Suganya"
replace sondaughter="Daughter" if householdid2020==540 & namenewhead=="Priya"
replace sondaughter="Daughter" if householdid2020==540 & namenewhead=="Gayathri"
replace sondaughter="Daughter" if householdid2020==540 & namenewhead=="Nirmala"
replace sondaughter="Daughter" if householdid2020==540 & namenewhead=="Panjavarnam"
replace sondaughter="Son" if householdid2020==540 & namenewhead=="Senthamizhan"
replace sondaughter="Daughter" if householdid2020==541 & namenewhead=="Kalpana"
replace sondaughter="Son" if householdid2020==541 & namenewhead=="Jayaprakash"
replace sondaughter="Daughter" if householdid2020==544 & namenewhead=="Thamizhselvi"
replace sondaughter="Daughter" if householdid2020==544 & namenewhead=="Praba"
replace sondaughter="Daughter" if householdid2020==545 & namenewhead=="Saranya"
replace sondaughter="Daughter" if householdid2020==545 & namenewhead=="Revathi"
replace sondaughter="Son" if householdid2020==546 & namenewhead=="Arunpandi"
replace sondaughter="Daughter" if householdid2020==546 & namenewhead=="Buvaneshwari"
replace sondaughter="Daughter" if householdid2020==546 & namenewhead=="Priya@Banupriya"
replace sondaughter="Son" if householdid2020==546 & namenewhead=="Marudavel"
replace sondaughter="Son" if householdid2020==547 & namenewhead=="Vijayakumar"
replace sondaughter="Daughter" if householdid2020==548 & namenewhead=="Sasireka"
replace sondaughter="Daughter" if householdid2020==548 & namenewhead=="Ezhilvani"
replace sondaughter="Daughter" if householdid2020==549 & namenewhead=="Jasmine roja"
replace sondaughter="Daughter" if householdid2020==549 & namenewhead=="Mathina begam"

* Name
gen sondaughtername=""
label var sondaughtername "(in parents records)"
replace sondaughtername="Nanthini" if householdid2020==534 & namenewhead=="Kanadhasan"
replace sondaughtername="Chandru" if householdid2020==549 & namenewhead=="Valarmathi"
replace sondaughtername="Jenifer" if householdid2020==536 & namenewhead=="Jenifer"
replace sondaughtername="Gunasundari" if householdid2020==544 & namenewhead=="Gunasundari"
replace sondaughtername="Devi" if householdid2020==545 & namenewhead=="Devi"
replace sondaughtername="Kalaiselvan " if householdid2020==542 & namenewhead=="Kalaiselvan"
replace sondaughtername="Sobana" if householdid2020==530 & namenewhead=="Sobana"
replace sondaughtername="Theivigam" if householdid2020==530 & namenewhead=="Theiveegam"
replace sondaughtername="Asaimani" if householdid2020==530 & namenewhead=="Asaimani"
replace sondaughtername="Bremasheela" if householdid2020==531 & namenewhead=="Bremsheela"
replace sondaughtername="Padmavathy" if householdid2020==531 & namenewhead=="Padmavathi"
replace sondaughtername="Kamalavalli" if householdid2020==531 & namenewhead=="Kamalavalli"
replace sondaughtername="Umamaheshwari" if householdid2020==532 & namenewhead=="Inbaraja"
replace sondaughtername="Murugavel" if householdid2020==532 & namenewhead=="Murugavel"
replace sondaughtername="Amutha" if householdid2020==532 & namenewhead=="Amutha"
replace sondaughtername="Duraimurugan" if householdid2020==532 & namenewhead=="Duraimurugan"
replace sondaughtername="Anusiya" if householdid2020==532 & namenewhead=="Anusuya"
replace sondaughtername="Karthikeyan" if householdid2020==534 & namenewhead=="Karthikeyan"
replace sondaughtername="Nandhini" if householdid2020==534 & namenewhead=="Radhakrishnan"
replace sondaughtername="Keerthiga" if householdid2020==534 & namenewhead=="Keerthika"
replace sondaughtername="Senthilmurugan" if householdid2020==535 & namenewhead=="Senthil murugan"
replace sondaughtername="Jeyan" if householdid2020==535 & namenewhead=="Jayan"
replace sondaughtername="Nimalkumar" if householdid2020==535 & namenewhead=="Nirmal Kumar"
replace sondaughtername="Thenaruvi" if householdid2020==536 & namenewhead=="Thenaruvi"
replace sondaughtername="Anandhavalli" if householdid2020==537 & namenewhead=="Anandthavalli"
replace sondaughtername="Mangayarkarasi" if householdid2020==537 & namenewhead=="Mangayarkarasi"
replace sondaughtername="Jayapriya" if householdid2020==537 & namenewhead=="Jayapriya"
replace sondaughtername="Shalini" if householdid2020==538 & namenewhead=="shalini"
replace sondaughtername="Anusuya @ Ashwiniya" if householdid2020==538 & namenewhead=="Krishnan"
replace sondaughtername="Anandhi" if householdid2020==538 & namenewhead=="Ananthi"
replace sondaughtername="Sudha" if householdid2020==539 & namenewhead=="Venkatesan"
replace sondaughtername="Athilakshmi" if householdid2020==539 & namenewhead=="Athilakshmi"
replace sondaughtername="Tamizhselvi" if householdid2020==539 & namenewhead=="Tamizselvi"
replace sondaughtername="Indumathi" if householdid2020==542 & namenewhead=="Indhumathi"
replace sondaughtername="Gomathi" if householdid2020==542 & namenewhead=="Gomathi"
replace sondaughtername="Prakash" if householdid2020==543 & namenewhead=="Prakash"
replace sondaughtername="Kuppu" if householdid2020==543 & namenewhead=="Narasingaperumal"
replace sondaughtername="Rubanya" if householdid2020==543 & namenewhead=="Sivakozhundhu"
replace sondaughtername="Nithiya" if householdid2020==540 & namenewhead=="Nithiya"
replace sondaughtername="Suganya" if householdid2020==540 & namenewhead=="Suganya"
replace sondaughtername="Priya" if householdid2020==540 & namenewhead=="Priya"
replace sondaughtername="Gayathri" if householdid2020==540 & namenewhead=="Gayathri"
replace sondaughtername="Nirmala" if householdid2020==540 & namenewhead=="Nirmala"
replace sondaughtername="Panchavarnam" if householdid2020==540 & namenewhead=="Panjavarnam"
replace sondaughtername="Senthamizhan" if householdid2020==540 & namenewhead=="Senthamizhan"
replace sondaughtername="Kalpana" if householdid2020==541 & namenewhead=="Kalpana"
replace sondaughtername="Jayapraksh" if householdid2020==541 & namenewhead=="Jayaprakash"
replace sondaughtername="Thamizselvi" if householdid2020==544 & namenewhead=="Thamizhselvi"
replace sondaughtername="Praba" if householdid2020==544 & namenewhead=="Praba"
replace sondaughtername="Saranya" if householdid2020==545 & namenewhead=="Saranya"
replace sondaughtername="Revathi" if householdid2020==545 & namenewhead=="Revathi"
replace sondaughtername="Arunpandi" if householdid2020==546 & namenewhead=="Arunpandi"
replace sondaughtername="Buvaneshvari" if householdid2020==546 & namenewhead=="Buvaneshwari"
replace sondaughtername="Priya" if householdid2020==546 & namenewhead=="Priya@Banupriya"
replace sondaughtername="Marudhavelu" if householdid2020==546 & namenewhead=="Marudavel"
replace sondaughtername="Vijaya kumar" if householdid2020==547 & namenewhead=="Vijayakumar"
replace sondaughtername="Sasiraka" if householdid2020==548 & namenewhead=="Sasireka"
replace sondaughtername="Ezhilvani" if householdid2020==548 & namenewhead=="Ezhilvani"
replace sondaughtername="Jasmin Roja" if householdid2020==549 & namenewhead=="Jasmine roja"
replace sondaughtername="Marina begam" if householdid2020==549 & namenewhead=="Mathina begam"

* Clean
encode sondaughter, gen(sondaughter_encode)
drop sondaughter
rename sondaughter_encode sondaughter


*** Issue part
gen issue_new=.
replace issue_new=0 if householdidparent!=""

replace issue_new=1 if householdid2020==536 & namenewhead=="Jenifer"
replace issue_new=1 if householdid2020==544 & namenewhead=="Gunasundari"
replace issue_new=1 if householdid2020==545 & namenewhead=="Devi"
replace issue_new=1 if householdid2020==542 & namenewhead=="Kalaiselvan"
replace issue_new=2 if householdid2020==534 & namenewhead=="Kanadhasan"
replace issue_new=2 if householdid2020==549 & namenewhead=="Valarmathi"

label define issue_new 0"No problem" 1"Real parent household different (error during input in tablet)" 2"Child name in new household (nickname, etc.)"
label values issue_new issue_new
fre issue_new

* Real parent household different
destring householdidparent, replace
clonevar householdidparent_backup=householdidparent
replace householdidparent=152 if householdid2020==536 & namenewhead=="Jenifer"
replace householdidparent=240 if householdid2020==544 & namenewhead=="Gunasundari"
replace householdidparent=459 if householdid2020==545 & namenewhead=="Devi"
replace householdidparent=64  if householdid2020==542 & namenewhead=="Kalaiselvan"

* Child name in new household
gen childname_modif=""
replace childname_modif="Nagananthi" if householdid2020==534 & namenewhead=="Kanadhasan"
replace childname_modif="Ramachandran" if householdid2020==549 & namenewhead=="Valarmathi"

order newfrompanel namenewhead householdidparent_backup householdidparent sondaughter sondaughtername issue_new childname_modif, after(value_householdid_2020)

preserve
drop if issue_new==.
drop if issue_new==0
list householdid2020 newfrompanel namenewhead householdidparent_backup householdidparent sondaughter sondaughtername issue_new childname_modif, clean noobs
restore


********** Change householdid2020 to parent_key
preserve
keep if householdidparent!=.
duplicates drop householdidparent, force
sort householdidparent
list householdidparent, clean noobs
restore

preserve
gen tokeep=.
replace tokeep=1 if householdid2020==6
replace tokeep=1 if householdid2020==12
replace tokeep=1 if householdid2020==24
replace tokeep=1 if householdid2020==33
replace tokeep=1 if householdid2020==42
replace tokeep=1 if householdid2020==43
replace tokeep=1 if householdid2020==44
replace tokeep=1 if householdid2020==53
replace tokeep=1 if householdid2020==64
replace tokeep=1 if householdid2020==65
replace tokeep=1 if householdid2020==87
replace tokeep=1 if householdid2020==89
replace tokeep=1 if householdid2020==104
replace tokeep=1 if householdid2020==123
replace tokeep=1 if householdid2020==126
replace tokeep=1 if householdid2020==130
replace tokeep=1 if householdid2020==134
replace tokeep=1 if householdid2020==145
replace tokeep=1 if householdid2020==152
replace tokeep=1 if householdid2020==165
replace tokeep=1 if householdid2020==166
replace tokeep=1 if householdid2020==180
replace tokeep=1 if householdid2020==191
replace tokeep=1 if householdid2020==193
replace tokeep=1 if householdid2020==206
replace tokeep=1 if householdid2020==238
replace tokeep=1 if householdid2020==240
replace tokeep=1 if householdid2020==246
replace tokeep=1 if householdid2020==252
replace tokeep=1 if householdid2020==271
replace tokeep=1 if householdid2020==272
replace tokeep=1 if householdid2020==279
replace tokeep=1 if householdid2020==280
replace tokeep=1 if householdid2020==298
replace tokeep=1 if householdid2020==302
replace tokeep=1 if householdid2020==314
replace tokeep=1 if householdid2020==341
replace tokeep=1 if householdid2020==354
replace tokeep=1 if householdid2020==364
replace tokeep=1 if householdid2020==369
replace tokeep=1 if householdid2020==375
replace tokeep=1 if householdid2020==396
replace tokeep=1 if householdid2020==401
replace tokeep=1 if householdid2020==402
replace tokeep=1 if householdid2020==411
replace tokeep=1 if householdid2020==443
replace tokeep=1 if householdid2020==458
replace tokeep=1 if householdid2020==459
replace tokeep=1 if householdid2020==481
replace tokeep=1 if householdid2020==487
replace tokeep=1 if householdid2020==488
replace tokeep=1 if householdid2020==502
replace tokeep=1 if householdid2020==525
replace tokeep=1 if householdid2020==527

keep if tokeep==1
duplicates drop HHID_panel, force
sort householdid2020
keep HHID_panel householdid2020 parent_key
export excel "$directory\CLEAN\_temp.xlsx", firstrow(var) replace
restore


gen householdidparent_key=""

replace householdidparent_key="uuid:8de7eea7-19ac-4aa1-aea9-8165a083e930" if householdidparent==6
replace householdidparent_key="uuid:f368294d-6102-484a-890c-908832cfd187" if householdidparent==12
replace householdidparent_key="uuid:6515c11e-c6e5-4ddc-beae-e7811b20d3a2" if householdidparent==24
replace householdidparent_key="uuid:9a535bcb-47f5-476b-825b-be28ba90623b" if householdidparent==33
replace householdidparent_key="uuid:468ce2ef-ccef-49b8-bad0-475f9dd2dbdb" if householdidparent==42
replace householdidparent_key="uuid:ceff71c1-cfd4-49c1-89bb-f936c09e7b10" if householdidparent==43
replace householdidparent_key="uuid:03eae81d-b4be-4200-b6f1-bcae0b8e2aa3" if householdidparent==44
replace householdidparent_key="uuid:45a248eb-a0b9-436a-b70a-732abe18db04" if householdidparent==53
replace householdidparent_key="uuid:782a507d-89bc-4df6-a516-4a7a96354c00" if householdidparent==64
replace householdidparent_key="uuid:d4cfb2d2-f05a-447a-97f0-0deb2f1e0198" if householdidparent==65
replace householdidparent_key="uuid:e9f06e5a-ed16-4fb4-97cf-7578ba9c7ab9" if householdidparent==87
replace householdidparent_key="uuid:496a8ebe-1d87-4dd8-886a-24ec26514474" if householdidparent==89
replace householdidparent_key="uuid:f49db603-49ba-4f05-8c79-8a6e3c36bcb8" if householdidparent==104
replace householdidparent_key="uuid:e13a8809-41a2-4a64-892d-1fb93ead21d2" if householdidparent==123
replace householdidparent_key="uuid:bf220e69-6145-4536-9237-2912eb1dda5e" if householdidparent==126
replace householdidparent_key="uuid:a32a2846-daca-4e51-9e9f-16a902864a52" if householdidparent==130
replace householdidparent_key="uuid:e5fd3b85-de2e-4842-908e-027bd523d002" if householdidparent==134
replace householdidparent_key="uuid:d2589cc6-b2a6-4e55-a544-75bfc561d101" if householdidparent==145
replace householdidparent_key="uuid:40c80fef-29fb-469a-93ec-a88c805e2df4" if householdidparent==152
replace householdidparent_key="uuid:b311d822-6486-4be6-8134-de502f98c6f7" if householdidparent==165
replace householdidparent_key="uuid:1944c65c-4f4c-4d6a-be8a-b97086e7a0b0" if householdidparent==166
replace householdidparent_key="uuid:7b70f238-d8fa-471b-8cd7-f89a30c1f9f4" if householdidparent==180
replace householdidparent_key="uuid:8ad24332-a46d-4a5a-82de-79b4a464eb00" if householdidparent==191
replace householdidparent_key="uuid:3d04313d-f28c-40c0-8e54-a21a96e9113e" if householdidparent==193
replace householdidparent_key="uuid:9e2d228c-9b26-4e9c-aabb-89711ec2c3c7" if householdidparent==206
replace householdidparent_key="uuid:31c52e14-e00c-4dcd-a2eb-eed5e6210815" if householdidparent==238
replace householdidparent_key="uuid:fe1b825c-8150-4585-aa0f-875c716387c4" if householdidparent==240
replace householdidparent_key="uuid:d7e0a08f-7602-45b0-951c-6d231c1e5dbd" if householdidparent==246
replace householdidparent_key="uuid:27d37126-3655-45f9-a79a-ec4f875bf3bd" if householdidparent==252
replace householdidparent_key="uuid:4d0712ef-e78d-4199-8498-874050c0aee4" if householdidparent==271
replace householdidparent_key="uuid:30bed241-30bc-4213-81c6-0487cb913ca8" if householdidparent==272
replace householdidparent_key="uuid:f238747c-1918-4a7c-a7ed-0f508f756e4f" if householdidparent==279
replace householdidparent_key="uuid:73f28c3e-e5f1-4951-954a-7ddfc933a11e" if householdidparent==280
replace householdidparent_key="uuid:293e3839-e5bb-4086-9bab-1490859678fb" if householdidparent==298
replace householdidparent_key="uuid:0ab75f6b-4722-465b-89e3-1a22951e3ea1" if householdidparent==302
replace householdidparent_key="uuid:af856b4c-1192-4691-8006-819d613ed77b" if householdidparent==314
replace householdidparent_key="uuid:0b312a9f-9795-423d-8002-e62fdc684775" if householdidparent==341
replace householdidparent_key="uuid:f8c72d7c-f21a-4c4b-889d-0196f3c0eabe" if householdidparent==354
replace householdidparent_key="uuid:42c4fc6d-fa57-4e26-9b0f-c66d268e48c1" if householdidparent==364
replace householdidparent_key="uuid:ff2ee18b-8363-4316-96ea-5a41a37094c0" if householdidparent==369
replace householdidparent_key="uuid:876a38fa-468b-40b7-a169-967f9d095ee8" if householdidparent==375
replace householdidparent_key="uuid:fb3e15f2-aede-49d5-8eee-514affc34b1a" if householdidparent==396
replace householdidparent_key="uuid:32e3039b-2c8c-4140-a5e0-a163f2b4e23c" if householdidparent==401
replace householdidparent_key="uuid:1d5dfec4-06f0-480f-a2de-1d4829bbd36b" if householdidparent==402
replace householdidparent_key="uuid:c73e8633-ddd2-4cc6-bf39-f25b281b146d" if householdidparent==411
replace householdidparent_key="uuid:f241d1f9-5d79-47b7-87ed-6b23f8b6aae5" if householdidparent==443
replace householdidparent_key="uuid:e0070a7a-e763-4c3b-9fa1-5b3a18f6b45e" if householdidparent==458
replace householdidparent_key="uuid:47ee7f6a-5875-4579-bd96-cfcefadd2f5c" if householdidparent==459
replace householdidparent_key="uuid:145fe4e0-2c7a-48a2-af98-8c20b0c8c300" if householdidparent==481
replace householdidparent_key="uuid:286b7eed-e160-458a-9e35-52a2507ed467" if householdidparent==487
replace householdidparent_key="uuid:04f2095d-a6dd-4251-9763-75e24bf9ba3a" if householdidparent==488
replace householdidparent_key="uuid:bd716ce9-7b96-4eae-a972-88c46dadc45b" if householdidparent==502
replace householdidparent_key="uuid:521d316a-3324-4bf7-b4c6-471e58e42962" if householdidparent==525
replace householdidparent_key="uuid:9e173be6-bc80-49e2-bd66-6909ef2a9ced" if householdidparent==527

sort householdidparent
order householdidparent_key, after(householdidparent)


save"$directory\CLEAN\NEEMSIS2-HH_v24.dta", replace
clear all
****************************************
* END
