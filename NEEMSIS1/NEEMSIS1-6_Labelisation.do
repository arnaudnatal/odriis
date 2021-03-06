cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
September 16, 2021
-----
TITLE: Other file
-------------------------
*/




****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "C:\Users\Arnaud\Documents\_Thesis\_DATA\NEEMSIS1"

cd"$directory"
clear all
****************************************
* END




****************************************
* Recode sex relationshiptohead + Village area + reason lefthome
****************************************
use"NEEMSIS1-HH_v8.dta", clear

fre relationshiptohead
fre sex
ta relationshiptohead sex

replace relationshiptohead=5 if HHID_panel=="KAR18" & INDID_panel=="Ind_3"
replace relationshiptohead=5 if HHID_panel=="KAR39" & INDID_panel=="Ind_4"
replace relationshiptohead=6 if HHID_panel=="KAR8" & INDID_panel=="Ind_5"
replace relationshiptohead=5 if HHID_panel=="KOR30" & INDID_panel=="Ind_5"
replace relationshiptohead=1 if HHID_panel=="KUV20" & INDID_panel=="Ind_1"
replace relationshiptohead=5 if HHID_panel=="ORA36" & INDID_panel=="Ind_4"
replace relationshiptohead=5 if HHID_panel=="ORA42" & INDID_panel=="Ind_3"

replace sex=2 if HHID_panel=="KAR45" & INDID_panel=="Ind_6"
replace sex=1 if HHID_panel=="NAT27" & INDID_panel=="Ind_3"
replace sex=1 if HHID_panel=="KAR49" & INDID_panel=="Ind_8"
replace sex=1 if HHID_panel=="ELA13" & INDID_panel=="Ind_5"
replace sex=2 if HHID_panel=="MANAM50" & INDID_panel=="Ind_6"
replace sex=1 if HHID_panel=="NAT42" & INDID_panel=="Ind_4"
replace sex=1 if HHID_panel=="ORA13" & INDID_panel=="Ind_2"
replace sex=2 if HHID_panel=="ORA26" & INDID_panel=="Ind_9"

ta relationshiptohead sex


********** Villagearea
fre villagearea
decode villagearea, gen(area)
replace area="1" if strpos(area,"UR")
replace area="2" if strpos(area,"CO")
destring area, gen(area2)
label define area2 1"Ur" 2"Colony"
label values area2 area2
drop area

ta villagearea area2
drop villagearea
rename area2 villagearea

fre villagearea



********** Reason left home
gen lefthomereason_code=.
label define lefthomereasoncode 1"Studies" 2"Work" 3"Marriage"
label values lefthomereason_code lefthomereasoncode
replace lefthomereason_code=1 if strpos(lefthomereason,"school")
replace lefthomereason_code=1 if strpos(lefthomereason,"study")
replace lefthomereason_code=1 if strpos(lefthomereason,"education")
replace lefthomereason_code=1 if lefthomereason=="For Training"
replace lefthomereason_code=1 if lefthomereason=="For training"
replace lefthomereason_code=1 if lefthomereason=="For Studying"
replace lefthomereason_code=1 if lefthomereason=="For higher studies"
replace lefthomereason_code=1 if lefthomereason=="For studies"
replace lefthomereason_code=1 if lefthomereason=="For nursing apprentice"
replace lefthomereason_code=1 if lefthomereason=="For nursing training"
replace lefthomereason_code=1 if lefthomereason=="ITI Aprentice Training"
replace lefthomereason_code=1 if lefthomereason=="Study"
replace lefthomereason_code=1 if lefthomereason=="Studying"
replace lefthomereason_code=1 if lefthomereason=="Studying in 12 Th"
replace lefthomereason_code=1 if strpos(lefthomereason,"Study and stay with sister for some m")
replace lefthomereason_code=1 if lefthomereason=="Training"

replace lefthomereason_code=2 if strpos(lefthomereason,"work")
replace lefthomereason_code=2 if strpos(lefthomereason,"job")
replace lefthomereason_code=2 if lefthomereason=="ForJob"
replace lefthomereason_code=2 if lefthomereason=="For Job"
replace lefthomereason_code=2 if lefthomereason=="Job"
replace lefthomereason_code=2 if lefthomereason=="Job and settled with his family"
replace lefthomereason_code=2 if lefthomereason=="Job for construction labour"
replace lefthomereason_code=2 if lefthomereason=="Job"
replace lefthomereason_code=2 if lefthomereason=="Job"
replace lefthomereason_code=2 if lefthomereason=="Job"
replace lefthomereason_code=2 if lefthomereason=="For Work"
replace lefthomereason_code=2 if lefthomereason=="Construction Worker"
replace lefthomereason_code=2 if lefthomereason=="Doing Worker"
replace lefthomereason_code=2 if lefthomereason=="Police training"
replace lefthomereason_code=2 if lefthomereason=="Professional"
replace lefthomereason_code=2 if lefthomereason=="Software company staff"
replace lefthomereason_code=2 if lefthomereason=="Doing Worker"
replace lefthomereason_code=2 if lefthomereason=="Doing Work"
replace lefthomereason_code=2 if lefthomereason=="Work"
replace lefthomereason_code=2 if strpos(lefthomereason,"Work , stay there and come back to th")
replace lefthomereason_code=2 if lefthomereason=="Work and setled"
replace lefthomereason_code=2 if lefthomereason=="Work and setteled"
replace lefthomereason_code=2 if lefthomereason=="Work and settled"
replace lefthomereason_code=2 if strpos(lefthomereason,"Try to get chance in cinema field")
replace lefthomereason_code=2 if lefthomereason=="To collect tamarind seeds for subramani business"

replace lefthomereason_code=3 if strpos(lefthomereason,"marriage")
replace lefthomereason_code=3 if strpos(lefthomereason,"married")
replace lefthomereason_code=3 if strpos(lefthomereason,"marriage")
replace lefthomereason_code=3 if strpos(lefthomereason,"wedding")
replace lefthomereason_code=3 if lefthomereason=="Marriage"
replace lefthomereason_code=3 if lefthomereason=="Married"
replace lefthomereason_code=3 if lefthomereason=="Got Married"
replace lefthomereason_code=3 if lefthomereason=="For Married"
replace lefthomereason_code=3 if lefthomereason=="Married and got new family"
replace lefthomereason_code=3 if lefthomereason=="Married and got nuclear family"
replace lefthomereason_code=3 if lefthomereason=="Married and left"
replace lefthomereason_code=3 if lefthomereason=="Married and settled there"

replace lefthomereason_code=. if lefthomereason=="Following her husband and also for work"
replace lefthomereason_code=. if lefthomereason=="Following his parents and also for work"
replace lefthomereason_code=. if lefthomereason=="For Husband job"
replace lefthomereason_code=. if lefthomereason=="Following her husband family and also for work"
replace lefthomereason_code=. if lefthomereason=="Following his wife's family, work localy"
replace lefthomereason_code=. if lefthomereason=="Following her parents and also for work"
replace lefthomereason_code=. if lefthomereason=="Family problem,and also for her daughter's education."
replace lefthomereason_code=. if lefthomereason=="Following her mother and also for education"

rename lefthomereason_code reasonlefthome



save"NEEMSIS1-HH_v8_bis.dta", replace

****************************************
* END



****************************************
* Variables Arnaud
****************************************
use"NEEMSIS1-HH_v8_bis.dta", clear



drop kowinc_indiv_agri kowinc_indiv_selfemp kowinc_indiv_sjagri kowinc_indiv_sjnonagri kowinc_indiv_uwhhnonagri kowinc_indiv_uwnonagri kowinc_indiv_uwhhagri kowinc_indiv_uwagri kowinc_HH_agri kowinc_HH_selfemp kowinc_HH_sjagri kowinc_HH_sjnonagri kowinc_HH_uwhhnonagri kowinc_HH_uwnonagri kowinc_HH_uwhhagri kowinc_HH_uwagri

drop assets_as2010 amountownlandwet_as2010 amountownland_as2010 HHID2010 sum_ext_HH
 

global arnaud occinc_indiv_agri occinc_indiv_agricasual occinc_indiv_nonagricasual occinc_indiv_nonagriregnonqual occinc_indiv_nonagriregqual occinc_indiv_selfemp occinc_indiv_nrega occinc_HH_agri occinc_HH_agricasual occinc_HH_nonagricasual occinc_HH_nonagriregnonqual occinc_HH_nonagriregqual occinc_HH_selfemp occinc_HH_nrega remreceivedtotalamount_indiv remreceivedtotalamount_HH incomeassets_HH incomeassets_indiv otherhouserent_HH otherhouserent_indiv pension_indiv pension_HH ra1 rab1 rb1 ra2 rab2 rb2 ra3 rab3 rb3 ra4 rab4 rb4 ra5 rab5 rb5 ra6 rab6 rb6 ra7 rab7 rb7 ra8 rab8 rb8 ra9 rab9 rb9 ra10 rab10 rb10 ra11 rab11 rb11 ra12 rab12 rb12 set_a set_ab set_b raven_tt refuse num_tt lit_tt curious_backup interestedbyart_backup repetitivetasks_backup inventive_backup liketothink_backup newideas_backup activeimagination_backup organized_backup makeplans_backup workhard_backup appointmentontime_backup putoffduties_backup easilydistracted_backup completeduties_backup enjoypeople_backup sharefeelings_backup shywithpeople_backup enthusiastic_backup talktomanypeople_backup talkative_backup expressingthoughts_backup workwithother_backup understandotherfeeling_backup trustingofother_backup rudetoother_backup toleratefaults_backup forgiveother_backup helpfulwithothers_backup managestress_backup nervous_backup changemood_backup feeldepressed_backup easilyupset_backup worryalot_backup staycalm_backup tryhard_backup stickwithgoals_backup goaftergoal_backup finishwhatbegin_backup finishtasks_backup keepworking_backup ars ars2 ars3 cr_curious cr_interestedbyart cr_repetitivetasks cr_inventive cr_liketothink cr_newideas cr_activeimagination cr_organized cr_makeplans cr_workhard cr_appointmentontime cr_putoffduties cr_easilydistracted cr_completeduties cr_enjoypeople cr_sharefeelings cr_shywithpeople cr_enthusiastic cr_talktomanypeople cr_talkative cr_expressingthoughts cr_workwithother cr_understandotherfeeling cr_trustingofother cr_rudetoother cr_toleratefaults cr_forgiveother cr_helpfulwithothers cr_managestress cr_nervous cr_changemood cr_feeldepressed cr_easilyupset cr_worryalot cr_staycalm cr_tryhard cr_stickwithgoals cr_goaftergoal cr_finishwhatbegin cr_finishtasks cr_keepworking cr_OP cr_CO cr_EX cr_AG cr_ES cr_Grit OP CO EX AG ES Grit caste edulevel s_goldquantity goldquantityamount amountownlanddry amountownlandwet amountownland goodtotalamount assets assets_noland mainocc_kindofwork_indiv mainocc_profession_indiv mainocc_occupation_indiv mainocc_sector_indiv mainocc_hoursayear_indiv mainocc_annualincome_indiv mainocc_jobdistance_indiv mainocc_occupationname_indiv annualincome_indiv nboccupation_indiv worker mainocc_kindofwork_HH mainocc_occupation_HH annualincome_HH nboccupation_HH working_pop totalincome_indiv totalincome_HH loans_indiv loans_gm_indiv loanamount_indiv loanamount_gm_indiv imp1_ds_tot_indiv imp1_is_tot_indiv loans_HH loans_gm_HH loanamount_HH loanamount_gm_HH imp1_ds_tot_HH imp1_is_tot_HH reasonlefthome

foreach x in $arnaud {
label var `x' "Construction -- Arnaud"
}


********** Order
* Generic
global ord1 HHID_panel HHID2016 dummynewHH dummydemonetisation submissiondate year INDID_panel INDID egoid jatis caste address villageid  householdid villagearea INDID2010 INDID2016 interviewplace numfamily instancename formdef_version username villagearea villageid_new villageid_new_comments tracked religion comefrom otherorigin

* Family members
global ord3 name age sex livinghome lefthomedurationlessoneyear lefthomedestination reasonlefthome lefthomereason relationshiptohead maritalstatus

* Education
global ord4 canread everattendedschool classcompleted after10thstandard durationafter10th typeofhigheredu subjectsafter10th othersubjectsafter10th    currentlyatschool educationexpenses amountschoolfees bookscost transportcost reasonneverattendedschool reasondropping otherreasondroppingschool   dummyscholarship scholarshipamount scholarshipduration converseinenglish

* Employment
global ord5 dummyworkedpastyear reasonnotworkpastyear stoppedworking

* Migration
global ord6 dummymigration migrantlist

* Remittances received
global ord7 dummyremreceived remreceivedlist remreceivedhhsource1 remreceivedothersource1 remreceivedsourcename1 remreceivedsourcerelation1 remreceivedsourceoccup1 remreceivedsourceplace1 remreceivedfrequency1 remreceivedamount1 remreceivedtotamount1 remreceivedservices1 remreceivedhhsource2 remreceivedothersource2 remreceivedsourcename2 remreceivedsourcerelation2 remreceivedsourceoccup2 remreceivedsourceplace2 remreceivedfrequency2 remreceivedamount2 remreceivedtotamount2 remreceivedservices2 demoremreceived1 demoremreceivedamo1 demoremreceivedform1 demoremreceived2 demoremreceivedamo2 demoremreceivedform2 dummygiftsreceived giftsrecipientlist giftsource giftsourcenb_WKP giftsourcenb_rel giftsourcenb_emp giftsourcenb_friends giftoccasion_WKP giftoccasion_rel giftoccasion_emp giftoccasion_friends giftoccasionother_WKP giftoccasionother_rel giftoccasionother_friends gifttype_WKP gifttype_rel gifttype_emp gifttype_friends giftamount_WKP giftamount_rel giftamount_emp giftamount_friends goldquantityasgift_rel

* Remittances sent
global ord8 dummyremsent remsenthhrecipient1 remsentotherrecipient1 remsentrecipientname1 remsentrelation1 remsentoccup1 remsentplace1 remsentfrequency1 remsentamount1 remsenttotalamount1 remsentservices1 remsentoccupother1 remsentservicesother1 remsenthhrecipient2 remsentotherrecipient2 remsentrecipientname2 remsentrelation2 remsentoccup2 remsentplace2 remsentfrequency2 remsentamount2 remsenttotalamount2 remsentservices2 remsentoccupother2 remsentservicesother2 demoremsentamount1 demoremsentform1 demoremsentamount2 demoremsentform2

* Loans
global ord9 dummyloans borrowerlist nbloansbyborrower sumhhloans loandetails1 loandetails2 loandetails3 loandetails4 loandetails5 loandetails6 loandetails7 loandetails8 loandetails9 loandetails10 loandetails11 loandetails12 loandetails13 loandetails14 loandetails15 loandetails16 loandetails17 loandetails18 loandetails19 loandetails20 loandetails21 loandetails22 loandetails23 loandetails24 loandetails25 loandetails26 loandetails27 loandetails28 loandetails29 loandetails30 loandetails31 loandetails32 loandetails33 loandetails34 loandetails35 loandetails36 loandetails37 loandetails38 loandetails39 loandetails40 loandetails41 loandetails42 loandetails43 loandetails44 loandetails45 loandetails46 loandetails47 loandetails48 loandetails49 loandetails50 loandetails51 loandetails52 loandetails53 loandetails54 loandetails55 loandetails56 loandetails57 loandetails58 loandetails59 loandetails60 loandetails61 loandetails62 loandetails63 loandetails64 loandetails65 loandetails66 loandetails67 loandetails68 loandetails69 loandetails70 loandetails71 loandetails72 loandetails73 loandetails74 loandetails75 loandetails76 loandetails77 loandetails78 loandetails79 loandetails80 threemainloans demootherinc demootherincamount demoexchangeasked demoexchangeaccepted democommissionamount dummyincomeassets incomeassets

* Lending
global ord10 dummylendingmoney hhlenderlist borrowerscaste borrowerssex relationwithborrower amountlent datelendingmoney demolendingkind demotermslending demodummyrepaylending demorepaytermslending interestlending demointerestlending purposeloanborrower problemrepayment dummyloanfromborrower

* Recommendation
global ord11 dummyrecommendgiven recommendgivenlist recommendgivenrelation recommendgivencaste dummyrecommendback recommendgivenlender recommendgivenlendercaste dummyrecommendrefuse reasonrefuserecommend

* Chitfund
global ord12 dummychitfund chitfundbelongerlist nbchitfunds chitfundtype1 chitfundtype2 durationchit1 durationchit2 nbermemberchit1 nbermemberchit2 chitfundpayment1 chitfundpaymentamount1 chitfundpayment2 chitfundpaymentamount2 chitfundamount1 chitfundamount2

* Saving
global ord13 dummysavingaccount savingsownerlist nbsavingaccounts savingsaccounttype1 savingsaccounttype2 savingsaccounttype3 savingsaccounttype4 savingsjointaccount1 savingsjointaccount2 savingsaccountdate1 savingsaccountdate2 savingsaccountdate3 banktype1 banktype2 banktype3 banktype4 savingsbankname1 savingsbankname2 savingsbankname3 savingsbankname4 savingsbankplace1 savingsbankplace2 savingsbankplace3 savingsbankplace4 savingsamount1 savingsamount2 savingsamount3 savingsamount4 savingspurpose1 savingspurpose2 savingspurpose3 savingspurpose4 dummydebitcard1 dummydebitcard2 dummydebitcard3 dummydebitcard4 dummycreditcard1 dummycreditcard2 dummycreditcard3 dummycreditcard4 datedebitcard1 datedebitcard2 datedebitcard3 datedebitcard4 usedebitcard1 usedebitcard2 usedebitcard3 usedebitcard4 reasonnotusedebitcard1 demousedebitcard1 demousedebitcard2 datecreditcard1 usecreditcard1 demousecreditcard1 demousecreditcard2

* Gold
global ord14 dummygold goldownerlist goldquantity demogoldquanti demogoldreasonbuy demogoldreasonbuyother dummygoldpledged goldquantitypledge goldamountpledge goldreasonpledge demogoldpledged demogoldreasonpledge

* Insurance
global ord15 dummyinsurance reasonnoinsurance reasonnoinsuranceother insuranceownerlist nbinsurance insurancepublic1 insurancepublic2 insurancename1 insurancename2 insurancejoineddate1 insurancejoineddate2 insurancetype1 insurancetype2 insurancepaymentfrequency1 insurancepaymentfrequency2 insuranceamount1 insuranceamount2 insurancebenefitamount insurancebenefit1 insurancebenefitamount1 insurancebenefit2 insurancebenefitamount2


* Land + end HH
global ord16 dummyeverhadland ownland sizeownland drywetownland waterfromownland leaseland sizeleaseland drywetleaseland waterfromleaseland landpurchased landpurchasedacres landpurchasedamount landpurchasedhowbuy landlost landlostreason dummyleasedland landleasername landleaserrelation landleasercaste landleaserothercaste dummyleasingland landleasingname landleasingrelation landleasingcaste landleasingrothercaste productlist productacre_paddy productacre_ragi productacre_millets productacre_tapioca productacre_cotton productacre_sugarca productacre_savukku productacre_guava productacre_groundnut productypeland_paddy productypeland_ragi productypeland_millets productypeland_tapioca productypeland_cotton productypeland_sugarca productypeland_savukku productypeland_guava productypeland_groundnut productunit_paddy productunit_ragi productunit_millets productunit_tapioca productunit_cotton productunit_sugarca productunit_savukku productunit_guava productunit_groundnut productnbbags_paddy productnbbags_ragi productnbbags_millets productnbbags_tapioca productnbbags_cotton productnbbags_sugarca productnbbags_savukku productnbbags_guava productnbbags_groundnut productselfconsumption_paddy productselfconsumption_ragi productselfconsumption_millets productselfconsumption_tapioca productselfconsumption_cotton productselfconsumption_sugarca productselfconsumption_savukku productselfconsumption_guava productselfconsumption_groundnut productnbbagssold_paddy productnbbagssold_ragi productnbbagssold_millets productnbbagssold_tapioca productnbbagssold_cotton productnbbagssold_sugarca productnbbagssold_savukku productnbbagssold_guava productnbbagssold_groundnut productpricesold_paddy productpricesold_ragi productpricesold_millets productpricesold_tapioca productpricesold_cotton productpricesold_sugarca productpricesold_savukku productpricesold_guava productpricesold_groundnut productexpenses_paddy productexpenses_ragi productexpenses_millets productexpenses_tapioca productexpenses_cotton productexpenses_sugarca productexpenses_savukku productexpenses_guava productexpenses_groundnut productpaidworkers_paddy productpaidworkers_ragi productpaidworkers_millets productpaidworkers_tapioca productpaidworkers_cotton productpaidworkers_sugarca productpaidworkers_savukku productpaidworkers_guava productpaidworkers_groundnut productnbpaidworkers_paddy productnbpaidworkers_ragi productnbpaidworkers_millets productnbpaidworkers_tapioca productnbpaidworkers_cotton productnbpaidworkers_sugarca productnbpaidworkers_savukku productnbpaidworkers_guava productnbpaidworkers_groundnut productlabourcost_paddy productlabourcost_ragi productlabourcost_millets productlabourcost_tapioca productlabourcost_cotton productlabourcost_sugarca productlabourcost_savukku productlabourcost_guava productlabourcost_groundnut productunpaidworkers_paddy productunpaidworkers_ragi productunpaidworkers_millets productunpaidworkers_tapioca productunpaidworkers_cotton productunpaidworkers_sugarca productunpaidworkers_savukku productunpaidworkers_guava productunpaidworkers_groundnut productnbunpaidworkers_paddy productnbunpaidworkers_ragi productnbunpaidworkers_millets productnbunpaidworkers_tapioca productnbunpaidworkers_cotton productnbunpaidworkers_sugarca productnbunpaidworkers_savukku productnbunpaidworkers_guava productnbunpaidworkers_groundnut productnbhhmembers_paddy productnbhhmembers_ragi productnbhhmembers_millets productnbhhmembers_tapioca productnbhhmembers_cotton productnbhhmembers_sugarca productnbhhmembers_savukku productnbhhmembers_guava productnbhhmembers_groundnut productoriginlabourers_paddy productoriginlabourers_ragi productoriginlabourers_millets productoriginlabourers_tapioca productoriginlabourers_cotton productoriginlabourers_sugarca productoriginlabourers_savukku productoriginlabourers_guava productoriginlabourers_groundnut productcastelabourers_paddy productcastelabourers_ragi productcastelabourers_millets productcastelabourers_tapioca productcastelabourers_cotton productcastelabourers_sugarca productcastelabourers_savukku productcastelabourers_guava productcastelabourers_groundnut demonbagriworkers demoagriactivity demoagrikindofjob demoagriactivityother livestocklist livestockamount_cow livestockamount_goat livestockamount_chicken livestockamount_bullock livestocknb_cow livestocknb_goat livestocknb_chicken livestocknb_bullock livestockprice_cow livestockprice_goat livestockprice_chicken livestockprice_bullock livestockuse_cow livestockuse_goat livestockuse_chicken livestockuse_bullock livestockprofit_cow livestockprofit_goat livestockprofit_chicken livestockprofit_bullock livestockspent_cow livestockspent_goat livestockspent_chicken livestockspent_bullock livestockbuy_cow livestockbuy_goat livestockbuy_chicken livestockbuy_bullock dummycattleloss cattlelossnb cattlelossamount cattleinsurance cattleinsuranceamount dummycattlesold cattlesoldnb cattlesoldamount cattlesoldreason equipmentlist equiownnb_tractor equiownnb_bullockcart equiownnb_ploughmach equiownyear_tractor equiownyear_bullockcart equiownyear_ploughmach equiownpay_tractor equiownpay_bullockcart equiownpay_ploughmach equiowncost_tractor equiowncost_bullockcart equiowncost_ploughmach equiownpledged_tractor equiownpledged_bullockcart equiownpledged_ploughmach equipmentborrowedlist equilentnb_tractor equilentnb_bullockcart equilentnb_harvester equilentnb_ploughmach equilentlender_tractor equilentlender_bullockcart equilentlender_harvester equilentlender_ploughmach foodexpenses healthexpenses ceremoniesexpenses ceremoniesrelativesexpenses deathexpenses demoexpenses democonsoless democonsomore democonsosame democonsopractices democonsoplace listgoods goodtotalamount numbergoods_car numbergoods_cookgas numbergoods_computer numbergoods_antenna numbergoods_bike numbergoods_fridge numbergoods_furniture numbergoods_tailormach numbergoods_phone numbergoods_landline numbergoods_DVD numbergoods_camera goodyearpurchased_car goodyearpurchased_cookgas goodyearpurchased_computer goodyearpurchased_antenna goodyearpurchased_bike goodyearpurchased_fridge goodyearpurchased_furniture goodyearpurchased_tailormach goodyearpurchased_phone goodyearpurchased_landline goodyearpurchased_DVD goodyearpurchased_camera goodtotalamount_car goodtotalamount_cookgas goodtotalamount_computer goodtotalamount_antenna goodtotalamount_bike goodtotalamount_fridge goodtotalamount_furniture goodtotalamount_tailormach goodtotalamount_phone goodtotalamount_landline goodtotalamount_DVD goodtotalamount_camera goodbuying_car goodbuying_cookgas goodbuying_computer goodbuying_antenna goodbuying_bike goodbuying_fridge goodbuying_furniture goodbuying_tailormach goodbuying_phone goodbuying_landline goodbuying_DVD goodbuying_camera goodsourcecredit_bike goodsourcecredit_tailormach goodcreditsettled_bike goodcreditsettled_tailormach dummymarriage marriedlist husbandwifecaste marriagedowry marriagetotalcost howpaymarriage marriageloansource marriageloannb_wellknown marriageloannb_banks marriageloannb_coopbanks marriageloannb_relatives marriageloannb_employer marriageloannb_maistry marriageloannb_colleagues marriageloannb_pawnbroker marriageloannb_monlender marriageloannb_friends marriageloanamount_wellknown marriageloanamount_banks marriageloanamount_coopbanks marriageloanamount_relatives marriageloanamount_employer marriageloanamount_maistry marriageloanamount_colleagues marriageloanamount_pawnbroker marriageloanamount_monlender marriageloanamount_friends marriageexpenses dummymarriagegift marriagegiftsource marriagegiftnb_wellknown marriagegiftnb_shg marriagegiftnb_relatives marriagegiftnb_employer marriagegiftnb_maistry marriagegiftnb_colleagues marriagegiftnb_shopkeeper marriagegiftnb_friends marriagegifttype_wellknown marriagegifttype_shg marriagegifttype_relatives marriagegifttype_employer marriagegifttype_maistry marriagegifttype_colleagues marriagegifttype_shopkeeper marriagegifttype_friends marriagegiftamount_wellknown marriagegiftamount_shg marriagegiftamount_relatives marriagegiftamount_employer marriagegiftamount_maistry marriagegiftamount_colleagues marriagegiftamount_shopkeeper marriagegiftamount_friends marriagegoldamount_wellknown marriagegoldamount_relatives marriagegoldamount_employer marriagegoldamount_friends house howbuyhouse rentalhouse housevalue housetype housesize houseroom housetitle ownotherhouse otherhouserent otherhousevalue dummysaleproperty incomesaleproperty useincomesaleproperty electricity water toiletfacility noowntoilet schemeslist nregarecipientlist nreganberdaysworked nregaincome rationcardnber rationcardmembers rationcarduse rationcardreasonnouse housingscheme housingschemetype housingschemeamount housingschemedate landschemesize landschemeyearbenefited schemerecipient_freemachine schemerecipient_cashmarriage schemerecipient_goldmarriage schemeyear_goldmarriage schemeyear_cashmarriage schemeyear_freemachine schemeyear_cashfunerals schemeyear_animals schemeyear_freegas schemeyear_educ schemeyear_farmequi schemeamount_goldmarriage schemeamount_cashmarriage schemeamount_freemachine schemeamount_cashfunerals schemeamount_animals schemeamount_freegas schemeamount_educ schemeamount_farmequi pensionrecipient_oldage pensionrecipient_widows pensionrecipient_maternity pensionrecipient_disability pensionrecipient_retirement pensionamount_retirement pensionamount_disability pensionamount_maternity pensionamount_widows pensionamount_oldage demoscheme


*Ego
drop unique_draws_ego selected_ego2position1_ego selected_ego2position2_ego selected_ego2position3_ego
ta hhmemberabove35


order $ord1 $ord3 $ord4 $ord5 $ord6 $ord7 $ord8 $ord9 $ord10 $ord11 $ord12 $ord13 $ord14 $ord15 $ord16

drop INDID2010
drop INDID2016


order $arnaud, after(hhmemberabove35)


save"$directory\CLEAN\NEEMSIS1-HH.dta", replace

****************************************
* END










****************************************
* Variables Arnaud
****************************************

********** All loans private
use"NEEMSIS1-loans_v11", clear
drop INDID2010
rename INDID2016 INDID
drop HHID2010
destring INDID, replace
order HHID2016 INDID
rename caste jatis
drop annualincome_indiv annualincome_HH
global arnaud loan_database dummymainloan loanduration lender_cat reason_cat lender2 lender3 lender4 yratepaid monthlyinterestrate debt_service interest_service imp_principal imp1_interest imp1_totalrepaid_year imp1_debt_service imp1_interest_service loans_indiv loans_HH loans_gm_indiv loans_gm_HH loanamount_indiv loanamount_HH loanamount_gm_indiv loanamount_gm_HH imp1_ds_tot_indiv imp1_is_tot_indiv imp1_ds_tot_HH imp1_is_tot_HH
foreach x in $arnaud {
label var `x' "Construction -- Arnaud"
}

drop egoid dummynewHH dummydemonetisation num submissiondate_o
order $arnaud, after(submissiondate)
save"$directory\CLEAN\NEEMSIS1-all_loans", replace


********** Migration
use"NEEMSIS-migration", clear
rename HHID HHID2016
order HHID2016 INDID dummynewHH dummydemonetisation name interviewplace caste sex age
drop HHID2010 INDID2010
rename caste jatis
save"NEEMSIS1-migration", replace


********** alter
use"NEEMSIS-alter", clear
rename HHID HHID2016
order HHID2016 INDID dummynewHH dummydemonetisation interviewplace caste sex age
rename caste jatis
save"CLEAN\NEEMSIS1-alter.dta", replace


********** occupation all wide
use"NEEMSIS-occupation_allwide_v4", clear
drop HHID2010 INDID2010 INDID2016
rename parent_key HHID2016
drop householdid 
order HHID2016 INDID name age caste sex relationshiptohead
save"CLEAN\NEEMSIS1-occupation_allwide", replace


********** remreceived
use"NEEMSIS-remittancesreceived", clear
rename parent_key HHID2016
rename namenumber INDID
save"CLEAN\NEEMSIS1-remittancesreceived", replace


********** remsent
use"NEEMSIS-remittancessent", clear
rename parent_key HHID2016
rename namenumber INDID
save"CLEAN\NEEMSIS1-remittancessent", replace


********** permanent migrant
use"NEEMSIS-permanentmigrant", clear
drop KEY SETOF*
split PARENT_KEY, p(/)
rename PARENT_KEY1 HHID2016
rename PARENT_KEY setof
split PARENT_KEY2, p([)
split PARENT_KEY22, p(])
drop PARENT_KEY2 PARENT_KEY21 PARENT_KEY22
rename PARENT_KEY221 INDID
destring INDID, replace
order HHID2016 INDID setof
save"CLEAN\NEEMSIS1-permanentmigrant", replace



********** permanent migrant SN
use"NEEMSIS-SNpermanentmigrant", clear
order PARENT_KEY KEY SETOFpermanentmigrantsndetails
save"CLEAN\NEEMSIS1-SNpermanentmigrant", replace

****************************************
* END
