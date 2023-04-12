*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 10, 2023
*-----
*RUME last clean
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-1"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\2016-NEEMSIS1\Data\4team"
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








****************************************
* NEEMSIS1-HH.dta
****************************************
use"NEEMSIS1-HH", clear


********** Intro
replace lefthomedestination="" if lefthomedestination=="."
replace lefthomereason="" if lefthomereason=="."




********** Education
foreach x in canread everattendedschool classcompleted currentlyatschool educationexpenses amountschoolfees bookscost transportcost dummyscholarship converseinenglish {
replace `x'=. if age<=5
}
replace reasondropping="" if age<=5
replace reasonneverattendedschool="" if age<=5


ta reasonneverattendedschool
replace reasonneverattendedschool="" if reasonneverattendedschool=="."
forvalues i=1/13 {
gen reasonneverattendedschool_`i'=0 if reasonneverattendedschool!=""
}
split reasonneverattendedschool
forvalues i=1/13 {
replace reasonneverattendedschool_`i'=1 if reasonneverattendedschool1=="`i'"
replace reasonneverattendedschool_`i'=1 if reasonneverattendedschool2=="`i'"
label values reasonneverattendedschool_`i' dummymigration
label var reasonneverattendedschool_`i' "reasonneverattendedschool=`i'"
}
rename reasonneverattendedschool_1 reasonneverattendedschool_fail
rename reasonneverattendedschool_2 reasonneverattendedschool_inac
rename reasonneverattendedschool_3 reasonneverattendedschool_qual
rename reasonneverattendedschool_4 reasonneverattendedschool_fina
rename reasonneverattendedschool_5 reasonneverattendedschool_heal
rename reasonneverattendedschool_6 reasonneverattendedschool_noin
rename reasonneverattendedschool_7 reasonneverattendedschool_care
rename reasonneverattendedschool_8 reasonneverattendedschool_work
rename reasonneverattendedschool_9 reasonneverattendedschool_girl
rename reasonneverattendedschool_10 reasonneverattendedschool_marr
rename reasonneverattendedschool_11 reasonneverattendedschool_noal
rename reasonneverattendedschool_12 reasonneverattendedschool_pube
rename reasonneverattendedschool_13 reasonneverattendedschool_baby
drop reasonneverattendedschool1 reasonneverattendedschool2

ta reasondropping
replace reasondropping="" if reasondropping=="."
forvalues i=1/14 {
gen reasondropping_`i'=0 if reasondropping!=""
}
split reasondropping
forvalues i=1/14 {
replace reasondropping_`i'=1 if reasondropping1=="`i'"
replace reasondropping_`i'=1 if reasondropping2=="`i'"
label values reasondropping_`i' dummymigration
label var reasondropping_`i' "reasondropping=`i'"
}
rename reasondropping_1 reasondropping_stop
rename reasondropping_2 reasondropping_fail
rename reasondropping_3 reasondropping_inac
rename reasondropping_4 reasondropping_qual
rename reasondropping_5 reasondropping_fina
rename reasondropping_6 reasondropping_heal
rename reasondropping_7 reasondropping_noin
rename reasondropping_8 reasondropping_care
rename reasondropping_9 reasondropping_work
rename reasondropping_10 reasondropping_girl
rename reasondropping_11 reasondropping_marr
rename reasondropping_12 reasondropping_noal
rename reasondropping_13 reasondropping_pube
rename reasondropping_14 reasondropping_baby
drop reasondropping1 reasondropping2



********** Migration
recode dummymigration (.=0)
tabulate migrantlist
replace migrantlist="" if migrantlist=="."
split migrantlist
destring migrantlist*, replace
gen migrantlistdummy=0 if dummymigration==1
replace migrantlistdummy=1 if INDID2016==migrantlist1
replace migrantlistdummy=1 if INDID2016==migrantlist2
replace migrantlistdummy=1 if INDID2016==migrantlist3
replace migrantlistdummy=1 if INDID2016==migrantlist4
replace migrantlistdummy=1 if INDID2016==migrantlist5
replace migrantlistdummy=1 if INDID2016==migrantlist6
replace migrantlistdummy=1 if INDID2016==migrantlist7
replace migrantlistdummy=1 if INDID2016==migrantlist8
replace migrantlistdummy=1 if INDID2016==migrantlist9
replace migrantlistdummy=1 if INDID2016==migrantlist10
replace migrantlistdummy=1 if INDID2016==migrantlist11
replace migrantlistdummy=1 if INDID2016==migrantlist12
replace migrantlistdummy=1 if INDID2016==migrantlist13
label values migrantlistdummy dummyinsurance

keep if dummymigration==1
ta migrantlistdummy
order migrantlistdummy, after(dummymigration)

save"Last/NEEMSIS1-HH", replace
****************************************
* END






****************************************
* NEEMSIS1-occupations.dta
****************************************
use"NEEMSIS1-occupations", clear

format datestartoccup %td
ta datestartoccup

label define demooccup 1"More" 2"Less" 3"Same" 4"Constrained to stop due to demo" 5"Stopped after demo for other reasons" 6"Stopped before demo"
label values demooccup demooccup
ta demooccup
order demooccup, after(datestartoccup)


********** businessskill
ta businessskill
split businessskill
forvalues i=1/4 {
gen businessskill_`i'=0 if businessskill!=""
}
forvalues i=1/4 {
replace businessskill_`i'=1 if businessskill1=="`i'"
replace businessskill_`i'=1 if businessskill2=="`i'"
label values businessskill_`i' dummybusinesslabourers
label var businessskill_`i' "businessskill=`i'"
}
rename businessskill_1 businessskill_fami
rename businessskill_2 businessskill_frie
rename businessskill_3 businessskill_scho
rename businessskill_4 businessskill_expe
drop businessskill1 businessskill2
order businessskill_fami businessskill_frie businessskill_scho businessskill_expe, after(businessskill)


********** businesssourceinvest
ta businesssourceinvest
replace businesssourceinvest="" if businesssourceinvest=="."
split businesssourceinvest
destring businesssourceinvest1 businesssourceinvest2 businesssourceinvest3, replace
recode businesssourceinvest1 businesssourceinvest2 businesssourceinvest3 (77=9)
forvalues i=1/9 {
gen businesssourceinvest_`i'=0 if businesssourceinvest!=""
} 
forvalues i=1/9 {
replace businesssourceinvest_`i'=1 if businesssourceinvest1==`i'
replace businesssourceinvest_`i'=1 if businesssourceinvest2==`i'
replace businesssourceinvest_`i'=1 if businesssourceinvest3==`i'
label values businesssourceinvest_`i' dummybusinesslabourers
label var businesssourceinvest_`i' "businesssourceinvest=`i'"
}
rename businesssourceinvest_1 businesssourceinvest_rela
rename businesssourceinvest_2 businesssourceinvest_bank
rename businesssourceinvest_3 businesssourceinvest_info
rename businesssourceinvest_4 businesssourceinvest_savi
rename businesssourceinvest_5 businesssourceinvest_inhe
rename businesssourceinvest_6 businesssourceinvest_prof
rename businesssourceinvest_7 businesssourceinvest_inbu
rename businesssourceinvest_8 businesssourceinvest_none
rename businesssourceinvest_9 businesssourceinvest_othe
drop businesssourceinvest1 businesssourceinvest2 businesssourceinvest3
order businesssourceinvest_rela businesssourceinvest_bank businesssourceinvest_info businesssourceinvest_savi businesssourceinvest_inhe businesssourceinvest_prof businesssourceinvest_inbu businesssourceinvest_none businesssourceinvest_othe, after(businesssourceinvest)
fre businesssourceinvest*


********** otherbusinesssourceinvestment
replace otherbusinesssourceinvestment="" if otherbusinesssourceinvestment=="."


********** business lender
drop numberbusinessloan_rel namebusinesslender1_rel addressbusinesslender1_rel businesslender1_rel castebusinesslender1_rel occupbusinesslender1_rel numberbusinessloan_bank namebusinesslender1_bank addressbusinesslender1_bank businesslender1_bank castebusinesslender1_bank occupbusinesslender1_bank namebusinesslender2_bank addressbusinesslender2_bank businesslender2_bank castebusinesslender2_bank occupbusinesslender2_bank numberbusinessloan_inf namebusinesslender1_inf addressbusinesslender1_inf businesslender1_inf castebusinesslender1_inf occupbusinesslender1_inf namebusinesslender2_inf addressbusinesslender2_inf businesslender2_inf castebusinesslender2_inf occupbusinesslender2_inf namebusinesslender3_inf addressbusinesslender3_inf businesslender3_inf castebusinesslender3_inf occupbusinesslender3_inf

preserve
use"C:\Users\Arnaud\Documents\Dropbox (Personal)\2016-NEEMSIS1\Data\_raw\NEEMSIS1 Original data by module\NEEMSIS-businessinvestment", clear
sort parent_key namenumber occupationid businessloanid
reshape long namebusinesslender addressbusinesslender businesslender castebusinesslender occupbusinesslender, i(parent_key namenumber occupationid businessloanid) j(n)
drop if namebusinesslender==""
drop businessloanname parent_key_all _merge businessloanid n numberbusinessloan 
bysort parent_key namenumber occupationid: gen n=_n
reshape wide namebusinesslender addressbusinesslender businesslender castebusinesslender occupbusinesslender, i(parent_key namenumber occupationid) j(n)
rename parent_key HHID2016
rename namenumber INDID2016
save"_temp/Businessinvest", replace
restore

merge m:1 HHID2016 INDID2016 occupationid using "_temp/Businessinvest"
drop if occupationid==.
sort _merge
ta _merge
order HHID2016 INDID2016 occupationid _merge
sort HHID2016 INDID2016 occupationid
drop if _merge==2
drop _merge



********** SE labourers
label define demobusiness 1"More labourers" 2"Less labourers" 3"Same number of labourers"
label values demobusiness demobusiness



forvalues i=1/42 {
format businesslabourerdate`i' %td
}




********** Demo
replace demobusinessactivity="" if demobusinessactivity=="."
split demobusinessactivity
destring demobusinessactivity1 demobusinessactivity2 demobusinessactivity3 demobusinessactivity4 demobusinessactivity5 demobusinessactivity6, replace
recode demobusinessactivity1 demobusinessactivity2 demobusinessactivity3 demobusinessactivity4 demobusinessactivity5 demobusinessactivity6 (77=9)
forvalues i=1/9 {
gen demobusinessactivity_`i'=0 if demobusinessactivity!=""
} 
forvalues i=1/9 {
replace demobusinessactivity_`i'=1 if demobusinessactivity1==`i'
replace demobusinessactivity_`i'=1 if demobusinessactivity2==`i'
replace demobusinessactivity_`i'=1 if demobusinessactivity3==`i'
replace demobusinessactivity_`i'=1 if demobusinessactivity4==`i'
replace demobusinessactivity_`i'=1 if demobusinessactivity5==`i'
replace demobusinessactivity_`i'=1 if demobusinessactivity6==`i'
replace demobusinessactivity_`i'=1 if demobusinessactivity7==`i'
label values demobusinessactivity_`i' dummybusinesslabourers
label var demobusinessactivity_`i' "demobusinessactivity=`i'"
}
rename demobusinessactivity_1 demobusinessactivity_lesin
rename demobusinessactivity_2 demobusinessactivity_cainp
rename demobusinessactivity_3 demobusinessactivity_difse
rename demobusinessactivity_4 demobusinessactivity_caspa
rename demobusinessactivity_5 demobusinessactivity_paymo
rename demobusinessactivity_6 demobusinessactivity_frequ
rename demobusinessactivity_7 demobusinessactivity_press
rename demobusinessactivity_8 demobusinessactivity_contr
rename demobusinessactivity_9 demobusinessactivity_other
drop demobusinessactivity1 demobusinessactivity2 demobusinessactivity3 demobusinessactivity4 demobusinessactivity5 demobusinessactivity6 demobusinessactivity7
order demobusinessactivity_lesin demobusinessactivity_cainp demobusinessactivity_difse demobusinessactivity_caspa demobusinessactivity_paymo demobusinessactivity_frequ demobusinessactivity_press demobusinessactivity_contr demobusinessactivity_other, after(demobusinessactivity)

replace demobusinessactivityother="" if demobusinessactivityother=="."
replace demobusinesskindofjob="" if demobusinesskindofjob=="."



********** Salaried job
replace joblocation="" if (kindofwork==1 | kindofwork==2) & joblocation!=""
replace jobdistance=. if (kindofwork==1 | kindofwork==2)
replace relationemployer="" if relationemployer=="."
replace casteemployer="" if casteemployer=="."

split relationemployer
destring relationemployer1 relationemployer2 relationemployer3 relationemployer4 relationemployer5 relationemployer6, replace
recode relationemployer1 relationemployer2 relationemployer3 relationemployer4 relationemployer5 relationemployer6 (66=12) (99=13)
forvalues i=1/13 {
gen relationemployer_`i'=0 if relationemployer!=""
} 
forvalues i=1/13 {
replace relationemployer_`i'=1 if relationemployer1==`i'
replace relationemployer_`i'=1 if relationemployer2==`i'
replace relationemployer_`i'=1 if relationemployer3==`i'
replace relationemployer_`i'=1 if relationemployer4==`i'
replace relationemployer_`i'=1 if relationemployer5==`i'
replace relationemployer_`i'=1 if relationemployer6==`i'
label values relationemployer_`i' dummybusinesslabourers
label var relationemployer_`i' "relationemployer=`i'"
}
rename relationemployer_1 relationemployer_labo
rename relationemployer_2 relationemployer_rela
rename relationemployer_3 relationemployer_poli
rename relationemployer_4 relationemployer_reli
rename relationemployer_5 relationemployer_neig
rename relationemployer_6 relationemployer_shg
rename relationemployer_7 relationemployer_busi
rename relationemployer_8 relationemployer_wkp
rename relationemployer_9 relationemployer_trad
rename relationemployer_10 relationemployer_frie
rename relationemployer_11 relationemployer_gfin
rename relationemployer_12 relationemployer_na
rename relationemployer_13 relationemployer_nr
drop relationemployer1 relationemployer2 relationemployer3 relationemployer4 relationemployer5 relationemployer6
order relationemployer_labo relationemployer_rela relationemployer_poli relationemployer_reli relationemployer_neig relationemployer_shg relationemployer_busi relationemployer_wkp relationemployer_trad relationemployer_frie relationemployer_gfin relationemployer_na relationemployer_nr, after(relationemployer)

split casteemployer
destring casteemployer*, replace
recode casteemployer1 casteemployer2 casteemployer3 casteemployer4 casteemployer5 casteemployer6 casteemployer7 casteemployer8 casteemployer9 casteemployer10 casteemployer11 (66=17) (77=18)
forvalues i=1/18 {
gen casteemployer_`i'=0 if casteemployer!=""
} 
forvalues i=1/13 {
replace casteemployer_`i'=1 if casteemployer1==`i'
replace casteemployer_`i'=1 if casteemployer2==`i'
replace casteemployer_`i'=1 if casteemployer3==`i'
replace casteemployer_`i'=1 if casteemployer4==`i'
replace casteemployer_`i'=1 if casteemployer5==`i'
replace casteemployer_`i'=1 if casteemployer6==`i'
replace casteemployer_`i'=1 if casteemployer7==`i'
replace casteemployer_`i'=1 if casteemployer8==`i'
replace casteemployer_`i'=1 if casteemployer9==`i'
replace casteemployer_`i'=1 if casteemployer10==`i'
replace casteemployer_`i'=1 if casteemployer11==`i'
label values casteemployer_`i' dummybusinesslabourers
label var casteemployer_`i' "casteemployer=`i'"
}
rename casteemployer_1 casteemployer_vanni
rename casteemployer_2 casteemployer_sc
rename casteemployer_3 casteemployer_arunt
rename casteemployer_4 casteemployer_rediy
rename casteemployer_5 casteemployer_grama
rename casteemployer_6 casteemployer_naidu
rename casteemployer_7 casteemployer_navit
rename casteemployer_8 casteemployer_asara
rename casteemployer_9 casteemployer_settu
rename casteemployer_10 casteemployer_natta
rename casteemployer_11 casteemployer_mudal
rename casteemployer_12 casteemployer_kulal
rename casteemployer_13 casteemployer_chett
rename casteemployer_14 casteemployer_marwa
rename casteemployer_15 casteemployer_musli
rename casteemployer_16 casteemployer_paday
rename casteemployer_17 casteemployer_na
rename casteemployer_18 casteemployer_other
drop casteemployer1 casteemployer2 casteemployer3 casteemployer4 casteemployer5 casteemployer6 casteemployer7 casteemployer8 casteemployer9 casteemployer10 casteemployer11
order casteemployer_vanni casteemployer_sc casteemployer_arunt casteemployer_rediy casteemployer_grama casteemployer_naidu casteemployer_navit casteemployer_asara casteemployer_settu casteemployer_natta casteemployer_mudal casteemployer_kulal casteemployer_chett casteemployer_marwa casteemployer_musli casteemployer_paday casteemployer_na casteemployer_other, after(casteemployer)




save"Last/NEEMSIS1-occupations", replace
****************************************
* END






















****************************************
* NEEMSIS1-loans_mainloans.dta
****************************************
use"NEEMSIS1-loans_mainloans", clear




save"Last/NEEMSIS1-loans_mainloans", replace
****************************************
* END


