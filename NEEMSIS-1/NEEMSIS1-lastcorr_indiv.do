*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 13, 2023
*-----
*NEEMSIS-1 individual last clean
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
********** Program
global prgm = "C:\Users\Arnaud\Documents\GitHub\odriis\_program"
do"$prgm\splitvarmcq.do"
do"$prgm\newn.do"
do"$prgm\repmi.do"
********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020
*-------------------------








****************************************
* NEEMSIS1-ego.dta
****************************************
use"NEEMSIS1-ego", clear

****
rename workedpastyear_ego workedpastyear
label values workedpastyear everwork




ta reasondontsearchjob
replace reasondontsearchjob="" if reasondontsearchjob=="."
split reasondontsearchjob, destring
forvalues i=1/15 {
gen reasondontsearchjob_`i'=0 if reasondontsearchjob!=""
}
forvalues i=1/15 {
replace reasondontsearchjob_`i'=1 if reasondontsearchjob1==`i'
replace reasondontsearchjob_`i'=1 if reasondontsearchjob2==`i'
label var reasondontsearchjob_`i' "reasondontsearchjob=`i'"
label values reasondontsearchjob_`i' everwork
}
rename reasondontsearchjob_1 reasondontsearchjob_stud
rename reasondontsearchjob_2 reasondontsearchjob_hodu
rename reasondontsearchjob_3 reasondontsearchjob_reti
rename reasondontsearchjob_4 reasondontsearchjob_olda
rename reasondontsearchjob_5 reasondontsearchjob_ill
rename reasondontsearchjob_6 reasondontsearchjob_disa
rename reasondontsearchjob_7 reasondontsearchjob_mili
rename reasondontsearchjob_8 reasondontsearchjob_nowa
rename reasondontsearchjob_9 reasondontsearchjob_alre
rename reasondontsearchjob_10 reasondontsearchjob_resp
rename reasondontsearchjob_11 reasondontsearchjob_reca
rename reasondontsearchjob_12 reasondontsearchjob_busy
rename reasondontsearchjob_13 reasondontsearchjob_chan
rename reasondontsearchjob_14 reasondontsearchjob_nojo
rename reasondontsearchjob_15 reasondontsearchjob_lowp
drop reasondontsearchjob1 reasondontsearchjob2
order reasondontsearchjob_stud reasondontsearchjob_hodu reasondontsearchjob_reti reasondontsearchjob_olda reasondontsearchjob_ill reasondontsearchjob_disa reasondontsearchjob_mili reasondontsearchjob_nowa reasondontsearchjob_alre reasondontsearchjob_resp reasondontsearchjob_reca reasondontsearchjob_busy reasondontsearchjob_chan reasondontsearchjob_nojo, after(reasondontsearchjob)


ta reasondontsearchjobsince15
replace reasondontsearchjobsince15="" if reasondontsearchjobsince15=="."
split reasondontsearchjobsince15, destring
forvalues i=1/15 {
gen reasondontsearchjobsince15_`i'=0 if reasondontsearchjobsince15!=""
}
forvalues i=1/15 {
replace reasondontsearchjobsince15_`i'=1 if reasondontsearchjobsince151==`i'
replace reasondontsearchjobsince15_`i'=1 if reasondontsearchjobsince152==`i'
label var reasondontsearchjobsince15_`i' "reasondontsearchjobsince15=`i'"
label values reasondontsearchjobsince15_`i' everwork
}
rename reasondontsearchjobsince15_1 reasondontsearchjobsince15_stud
rename reasondontsearchjobsince15_2 reasondontsearchjobsince15_hodu
rename reasondontsearchjobsince15_3 reasondontsearchjobsince15_reti
rename reasondontsearchjobsince15_4 reasondontsearchjobsince15_olda
rename reasondontsearchjobsince15_5 reasondontsearchjobsince15_ill
rename reasondontsearchjobsince15_6 reasondontsearchjobsince15_disa
rename reasondontsearchjobsince15_7 reasondontsearchjobsince15_mili
rename reasondontsearchjobsince15_8 reasondontsearchjobsince15_nowa
rename reasondontsearchjobsince15_9 reasondontsearchjobsince15_alre
rename reasondontsearchjobsince15_10 reasondontsearchjobsince15_resp
rename reasondontsearchjobsince15_11 reasondontsearchjobsince15_reca
rename reasondontsearchjobsince15_12 reasondontsearchjobsince15_busy
rename reasondontsearchjobsince15_13 reasondontsearchjobsince15_chan
rename reasondontsearchjobsince15_14 reasondontsearchjobsince15_nojo
rename reasondontsearchjobsince15_15 reasondontsearchjobsince15_lowp
drop reasondontsearchjobsince151 reasondontsearchjobsince152
order reasondontsearchjobsince15_stud reasondontsearchjobsince15_hodu reasondontsearchjobsince15_reti reasondontsearchjobsince15_olda reasondontsearchjobsince15_ill reasondontsearchjobsince15_disa reasondontsearchjobsince15_mili reasondontsearchjobsince15_nowa reasondontsearchjobsince15_alre reasondontsearchjobsince15_resp reasondontsearchjobsince15_reca reasondontsearchjobsince15_busy reasondontsearchjobsince15_chan reasondontsearchjobsince15_nojo reasondontsearchjobsince15_lowp , after(reasondontsearchjobsince15)





ta methodfindjob
replace methodfindjob="" if methodfindjob=="."
split methodfindjob, destring
recode methodfindjob1 methodfindjob2 methodfindjob3 methodfindjob4 methodfindjob5 methodfindjob6 methodfindjob7 methodfindjob8 methodfindjob9 (66=10) (99=11)
forvalues i=1/11 {
gen methodfindjob_`i'=0 if methodfindjob!=""
}
forvalues i=1/11 {
replace methodfindjob_`i'=1 if methodfindjob1==`i'
replace methodfindjob_`i'=1 if methodfindjob2==`i'
replace methodfindjob_`i'=1 if methodfindjob3==`i'
replace methodfindjob_`i'=1 if methodfindjob4==`i'
replace methodfindjob_`i'=1 if methodfindjob5==`i'
replace methodfindjob_`i'=1 if methodfindjob6==`i'
replace methodfindjob_`i'=1 if methodfindjob7==`i'
replace methodfindjob_`i'=1 if methodfindjob8==`i'
replace methodfindjob_`i'=1 if methodfindjob9==`i'
label var methodfindjob_`i' "methodfindjob=`i'"
label values methodfindjob_`i' everwork
}
rename methodfindjob_1 methodfindjob_snfrie
rename methodfindjob_2 methodfindjob_snrela
rename methodfindjob_3 methodfindjob_snothe
rename methodfindjob_4 methodfindjob_empdir
rename methodfindjob_5 methodfindjob_pubage
rename methodfindjob_6 methodfindjob_priage
rename methodfindjob_7 methodfindjob_univer
rename methodfindjob_8 methodfindjob_media
rename methodfindjob_9 methodfindjob_intern
rename methodfindjob_10 methodfindjob_na
rename methodfindjob_11 methodfindjob_nr
drop methodfindjob1 methodfindjob2 methodfindjob3 methodfindjob4 methodfindjob5 methodfindjob6 methodfindjob7 methodfindjob8 methodfindjob9
order methodfindjob_snfrie methodfindjob_snrela methodfindjob_snothe methodfindjob_empdir methodfindjob_pubage methodfindjob_priage methodfindjob_univer methodfindjob_media methodfindjob_intern methodfindjob_na methodfindjob_nr, after(methodfindjob)

replace unpaidinbusinessfirstjob="" if unpaidinbusinessfirstjob=="."

ta methodfindfirstjob
replace methodfindfirstjob="" if methodfindfirstjob=="."
split methodfindfirstjob, destring
recode methodfindfirstjob1 methodfindfirstjob2 methodfindfirstjob3 (66=10) (99=11)
forvalues i=1/11 {
gen methodfindfirstjob_`i'=0 if methodfindfirstjob!=""
}
forvalues i=1/11 {
replace methodfindfirstjob_`i'=1 if methodfindfirstjob1==`i'
replace methodfindfirstjob_`i'=1 if methodfindfirstjob2==`i'
replace methodfindfirstjob_`i'=1 if methodfindfirstjob3==`i'
label var methodfindfirstjob_`i' "methodfindfirstjob=`i'"
label values methodfindfirstjob_`i' everwork
}
rename methodfindfirstjob_1 methodfindfirstjob_snfrie
rename methodfindfirstjob_2 methodfindfirstjob_snrela
rename methodfindfirstjob_3 methodfindfirstjob_snothe
rename methodfindfirstjob_4 methodfindfirstjob_empdir
rename methodfindfirstjob_5 methodfindfirstjob_pubage
rename methodfindfirstjob_6 methodfindfirstjob_priage
rename methodfindfirstjob_7 methodfindfirstjob_univer
rename methodfindfirstjob_8 methodfindfirstjob_media
rename methodfindfirstjob_9 methodfindfirstjob_intern
rename methodfindfirstjob_10 methodfindfirstjob_na
rename methodfindfirstjob_11 methodfindfirstjob_nr
drop methodfindfirstjob1 methodfindfirstjob2 methodfindfirstjob3
order methodfindfirstjob_snfrie methodfindfirstjob_snrela methodfindfirstjob_snothe methodfindfirstjob_empdir methodfindfirstjob_pubage methodfindfirstjob_priage methodfindfirstjob_univer methodfindfirstjob_media methodfindfirstjob_intern methodfindfirstjob_na methodfindfirstjob_nr, after(methodfindfirstjob)


drop maxhoursayear_ego hhmainoccupID_ego hhmainoccupname_ego occupation1_ego occupation2_ego occupation3_ego occupation4_ego nbofoccupations_ego mainoccup_ego


*** 
preserve
use"_temp/NEEMSIS1-occupnew", clear
keep HHID2016 INDID2016 occupationid occupationname kindofwork dummymainoccupation_indiv mainocc_kindofwork_indiv mainocc_occupationname_indiv
codebook kindofwork
label values mainocc_kindofwork_indiv kindofwork
keep if dummymainoccupation_indiv==1
drop dummymainoccupation_indiv mainocc_kindofwork_indiv mainocc_occupationname_indiv
rename occupationid occupationid_ego
rename occupationname occupationname_ego
rename kindofwork kindofwork_ego
save"_temp/mocego", replace
restore


merge 1:1 HHID2016 INDID2016 using "_temp/mocego"
drop if _merge==2
drop _merge
order occupationid_ego occupationname_ego kindofwork_ego, before(dummyregularmainoccup)


ta reasonstoppedwagejob
replace reasonstoppedwagejob="" if reasonstoppedwagejob=="."
split reasonstoppedwagejob, destring
recode reasonstoppedwagejob1 reasonstoppedwagejob2 reasonstoppedwagejob3 (77=13)
forvalues i=1/13 {
gen reasonstoppedwagejob_`i'=0 if reasonstoppedwagejob!=""
}
forvalues i=1/13 {
replace reasonstoppedwagejob_`i'=1 if reasonstoppedwagejob1==`i'
replace reasonstoppedwagejob_`i'=1 if reasonstoppedwagejob2==`i'
replace reasonstoppedwagejob_`i'=1 if reasonstoppedwagejob3==`i'
label values reasonstoppedwagejob_`i' everwork
label var reasonstoppedwagejob_`i' "reasonstoppedwagejob=`i'"
}
rename reasonstoppedwagejob_1 reasonstoppedwagejob_fired
rename reasonstoppedwagejob_2 reasonstoppedwagejob_endco
rename reasonstoppedwagejob_3 reasonstoppedwagejob_buclo
rename reasonstoppedwagejob_4 reasonstoppedwagejob_reduc
rename reasonstoppedwagejob_5 reasonstoppedwagejob_lowwa
rename reasonstoppedwagejob_6 reasonstoppedwagejob_retir
rename reasonstoppedwagejob_7 reasonstoppedwagejob_pregn
rename reasonstoppedwagejob_8 reasonstoppedwagejob_healt
rename reasonstoppedwagejob_9 reasonstoppedwagejob_famil
rename reasonstoppedwagejob_10 reasonstoppedwagejob_moved
rename reasonstoppedwagejob_11 reasonstoppedwagejob_educa
rename reasonstoppedwagejob_12 reasonstoppedwagejob_selfe
rename reasonstoppedwagejob_13 reasonstoppedwagejob_other
drop reasonstoppedwagejob1 reasonstoppedwagejob2 reasonstoppedwagejob3
order reasonstoppedwagejob_fired reasonstoppedwagejob_endco reasonstoppedwagejob_buclo reasonstoppedwagejob_reduc reasonstoppedwagejob_lowwa reasonstoppedwagejob_retir reasonstoppedwagejob_pregn reasonstoppedwagejob_healt reasonstoppedwagejob_famil reasonstoppedwagejob_moved reasonstoppedwagejob_educa reasonstoppedwagejob_selfe reasonstoppedwagejob_other, after(reasonstoppedwagejob)



ta businesspaymentinkindlist
replace businesspaymentinkindlist="" if businesspaymentinkindlist=="."
split businesspaymentinkindlist, destring
forvalues i=1/6 {
gen businesspaymentinkindlist_`i'=0 if businesspaymentinkindlist!=""
}
forvalues i=1/6 {
replace businesspaymentinkindlist_`i'=1 if businesspaymentinkindlist1==`i'
replace businesspaymentinkindlist_`i'=1 if businesspaymentinkindlist2==`i'
label values businesspaymentinkindlist_`i' everwork
label var businesspaymentinkindlist_`i' "businesspaymentinkindlist=`i'"
}
rename businesspaymentinkindlist_1 businesspaymentinkindlist_clo
rename businesspaymentinkindlist_2 businesspaymentinkindlist_foo
rename businesspaymentinkindlist_3 businesspaymentinkindlist_tra
rename businesspaymentinkindlist_4 businesspaymentinkindlist_acc
rename businesspaymentinkindlist_5 businesspaymentinkindlist_lab
rename businesspaymentinkindlist_6 businesspaymentinkindlist_oth
drop businesspaymentinkindlist1 businesspaymentinkindlist2
order businesspaymentinkindlist_clo businesspaymentinkindlist_foo businesspaymentinkindlist_tra businesspaymentinkindlist_acc businesspaymentinkindlist_lab businesspaymentinkindlist_oth,after(businesspaymentinkindlist)



ta wagejobpaymentinkindlist
replace wagejobpaymentinkindlist="" if wagejobpaymentinkindlist=="."
split wagejobpaymentinkindlist, destring
forvalues i=1/6 {
gen wagejobpaymentinkindlist_`i'=0 if wagejobpaymentinkindlist!=""
}
forvalues i=1/6 {
replace wagejobpaymentinkindlist_`i'=1 if wagejobpaymentinkindlist1==`i'
replace wagejobpaymentinkindlist_`i'=1 if wagejobpaymentinkindlist2==`i'
replace wagejobpaymentinkindlist_`i'=1 if wagejobpaymentinkindlist3==`i'
label values wagejobpaymentinkindlist_`i' everwork
label var wagejobpaymentinkindlist_`i' "wagejobpaymentinkindlist=`i'"
}
rename wagejobpaymentinkindlist_1 wagejobpaymentinkindlist_clo
rename wagejobpaymentinkindlist_2 wagejobpaymentinkindlist_foo
rename wagejobpaymentinkindlist_3 wagejobpaymentinkindlist_tra
rename wagejobpaymentinkindlist_4 wagejobpaymentinkindlist_acc
rename wagejobpaymentinkindlist_5 wagejobpaymentinkindlist_lab
rename wagejobpaymentinkindlist_6 wagejobpaymentinkindlist_oth
drop wagejobpaymentinkindlist1 wagejobpaymentinkindlist2 wagejobpaymentinkindlist3
order wagejobpaymentinkindlist_clo wagejobpaymentinkindlist_foo wagejobpaymentinkindlist_tra wagejobpaymentinkindlist_acc wagejobpaymentinkindlist_lab wagejobpaymentinkindlist_oth,after(wagejobpaymentinkindlist)







********** Association
ta associationlist
split associationlist, destring
forvalues i=1/13 {
gen associationlist_`i'=0 if associationlist!=""
}
forvalues i=1/13 {
replace associationlist_`i'=1 if associationlist1==`i'
replace associationlist_`i'=1 if associationlist2==`i'
replace associationlist_`i'=1 if associationlist3==`i'
label var associationlist_`i' "associationlist=`i'"
label var associationlist_`i' everwork
}
rename associationlist_1 associationlist_yout
rename associationlist_2 associationlist_shg
rename associationlist_3 associationlist_trad
rename associationlist_4 associationlist_farm
rename associationlist_5 associationlist_panc
rename associationlist_6 associationlist_poli
rename associationlist_7 associationlist_prof
rename associationlist_8 associationlist_mark
rename associationlist_9 associationlist_reli
rename associationlist_10 associationlist_hobb
rename associationlist_11 associationlist_alum
rename associationlist_12 associationlist_othe
rename associationlist_13 associationlist_none
drop associationlist1 associationlist2 associationlist3
order associationlist_yout associationlist_shg associationlist_trad associationlist_farm associationlist_panc associationlist_poli associationlist_prof associationlist_mark associationlist_reli associationlist_hobb associationlist_alum associationlist_othe associationlist_none, after(associationlist)

fre dummyassohelpjob*
gen dummyassohelpjob3=.
label values dummyassohelpjob3 everwork
fre dummyassohelpbusiness*





********** contactlist
ta contactlist
split contactlist, destring
forvalues i=1/9 {
gen contactlist_`i'=0 if contactlist!=""
}
forvalues i=1/9 {
replace contactlist_`i'=1 if contactlist1==`i'
replace contactlist_`i'=1 if contactlist2==`i'
replace contactlist_`i'=1 if contactlist3==`i'
replace contactlist_`i'=1 if contactlist4==`i'
replace contactlist_`i'=1 if contactlist5==`i'
replace contactlist_`i'=1 if contactlist6==`i'
replace contactlist_`i'=1 if contactlist7==`i'
replace contactlist_`i'=1 if contactlist8==`i'
label var contactlist_`i' "contactlist=`i'"
label values contactlist_`i' everwork
}
rename contactlist_1 contactlist_busi
rename contactlist_2 contactlist_poli
rename contactlist_3 contactlist_civi
rename contactlist_4 contactlist_bank
rename contactlist_5 contactlist_panc
rename contactlist_6 contactlist_coun
rename contactlist_7 contactlist_recr
rename contactlist_8 contactlist_trad
rename contactlist_9 contactlist_none
drop contactlist1 contactlist2 contactlist3 contactlist4 contactlist5 contactlist6 contactlist7 contactlist8
order contactlist_busi contactlist_poli contactlist_civi contactlist_bank contactlist_panc contactlist_coun contactlist_recr contactlist_trad contactlist_none,after(contactlist)


label define demotrustneighborhood 1"Positive change (more trust)" 2"No change" 3"Negative change (less trust)" 99"No response"
label values demotrustneighborhood demotrustneighborhood

rename demotrustemployees_ego demotrustemployees
label values demotrustemployees demotrustneighborhood

rename demonetworkpeoplehelping_ego demonetworkpeoplehelping
label define demonetworkpeoplehelping 1"More likely to receive additionnal request" 2"Same" 3"Less likely to receive additionnal request" 99"No response"
label values demonetworkpeoplehelping demonetworkpeoplehelping

rename demonetworkhelpkinmember_ego demonetworkhelpkinmember
label define demonetworkhelpkinmember 1"I will accept even more" 2"Same" 3"I will hire even less" 99"No response"
label values demonetworkhelpkinmember demonetworkhelpkinmember

rename demotrustbank_ego demotrustbank
label define demotrustbank 1"Same, still don't trust" 2"Same, still trust" 3"Less trust" 4"More trust" 99"No response"
label values demotrustbank demotrustbank


drop interviewplace_ego hhmemberabove35

order assocotherhelpjob1, after(assohelpjob1)

ta wagejobpaymentinkindvalue6
rename wagejobpaymentinkindvalue6 wagejobpaymentinkindvalue_othe
order wagejobpaymentinkindvalue_othe, after(wagejobpaymentkindvalue_accom)

order otherwagejobemployer, after(wagejobemployer)

order dummyassohelpjob3, after(dummyassohelpjob2)


order reasondontsearchjob_lowp, after(reasondontsearchjob_nojo)


********** General effect demo
ta demogeneralperception
split demogeneralperception, destring
recode demogeneralperception1 demogeneralperception2 (88=6) (99=7)
forvalues i=1/7{
gen demogeneralperception_`i'=0 if demogeneralperception!=""
}
forvalues i=1/7{
replace demogeneralperception_`i'=1 if demogeneralperception1==`i'
replace demogeneralperception_`i'=1 if demogeneralperception2==`i'
label var demogeneralperception_`i' "demogeneralperception=`i'"
label values demogeneralperception_`i' everwork
}
rename demogeneralperception_1 demogeneralperception_bad
rename demogeneralperception_2 demogeneralperception_pba
rename demogeneralperception_3 demogeneralperception_neu
rename demogeneralperception_4 demogeneralperception_pgo
rename demogeneralperception_5 demogeneralperception_goo
rename demogeneralperception_6 demogeneralperception_dk
rename demogeneralperception_7 demogeneralperception_nr
drop demogeneralperception1 demogeneralperception2
order demogeneralperception_bad demogeneralperception_pba demogeneralperception_neu demogeneralperception_pgo demogeneralperception_goo demogeneralperception_dk demogeneralperception_nr, after(demogeneralperception)



ta demogoodexpectations
split demogoodexpectations, destring
recode demogoodexpectations1 demogoodexpectations2 demogoodexpectations3 demogoodexpectations4 demogoodexpectations5 demogoodexpectations6 demogoodexpectations7 (77=9) (88=10) (99=11)
forvalues i=1/11 {
gen demogoodexpectations_`i'=0 if demogoodexpectations!=""
}
forvalues i=1/11 {
replace demogoodexpectations_`i'=1 if demogoodexpectations1==`i'
replace demogoodexpectations_`i'=1 if demogoodexpectations2==`i'
replace demogoodexpectations_`i'=1 if demogoodexpectations3==`i'
replace demogoodexpectations_`i'=1 if demogoodexpectations4==`i'
replace demogoodexpectations_`i'=1 if demogoodexpectations5==`i'
replace demogoodexpectations_`i'=1 if demogoodexpectations6==`i'
replace demogoodexpectations_`i'=1 if demogoodexpectations7==`i'
label var demogoodexpectations_`i' "demogoodexpectations=`i'"
label values demogoodexpectations_`i' everwork
}
rename demogoodexpectations_1 demogoodexpectations_noch
rename demogoodexpectations_2 demogoodexpectations_less
rename demogoodexpectations_3 demogoodexpectations_safe
rename demogoodexpectations_4 demogoodexpectations_bank
rename demogoodexpectations_5 demogoodexpectations_easi
rename demogoodexpectations_6 demogoodexpectations_hidd
rename demogoodexpectations_7 demogoodexpectations_form
rename demogoodexpectations_8 demogoodexpectations_gift
rename demogoodexpectations_9 demogoodexpectations_othe
rename demogoodexpectations_10 demogoodexpectations_dk
rename demogoodexpectations_11 demogoodexpectations_nr
drop demogoodexpectations1 demogoodexpectations2 demogoodexpectations3 demogoodexpectations4 demogoodexpectations5 demogoodexpectations6 demogoodexpectations7
order demogoodexpectations_noch demogoodexpectations_less demogoodexpectations_safe demogoodexpectations_bank demogoodexpectations_easi demogoodexpectations_hidd demogoodexpectations_form demogoodexpectations_gift demogoodexpectations_othe demogoodexpectations_dk demogoodexpectations_nr, after(demogoodexpectations)


*
ta demobadexpectations
split demobadexpectations, destring
recode demobadexpectations1 demobadexpectations2 demobadexpectations3 demobadexpectations4 demobadexpectations5 (77=9) (88=10) (99=11)
forvalues i=1/11 {
gen demobadexpectations_`i'=0 if demobadexpectations!=""
}
forvalues i=1/11 {
replace demobadexpectations_`i'=1 if demobadexpectations1==`i'
replace demobadexpectations_`i'=1 if demobadexpectations2==`i'
replace demobadexpectations_`i'=1 if demobadexpectations3==`i'
replace demobadexpectations_`i'=1 if demobadexpectations4==`i'
replace demobadexpectations_`i'=1 if demobadexpectations5==`i'
label var demobadexpectations_`i' "demobadexpectations=`i'"
label values demobadexpectations_`i' everwork
}
rename demobadexpectations_1 demobadexpectations_noch
rename demobadexpectations_2 demobadexpectations_taxc
rename demobadexpectations_3 demobadexpectations_blac
rename demobadexpectations_4 demobadexpectations_loan
rename demobadexpectations_5 demobadexpectations_cost
rename demobadexpectations_6 demobadexpectations_jobo
rename demobadexpectations_7 demobadexpectations_inco
rename demobadexpectations_8 demobadexpectations_sche
rename demobadexpectations_9 demobadexpectations_othe
rename demobadexpectations_10 demobadexpectations_dk
rename demobadexpectations_11 demobadexpectations_nr
drop demobadexpectations1 demobadexpectations2 demobadexpectations3 demobadexpectations4 demobadexpectations5
order demobadexpectations_noch demobadexpectations_taxc demobadexpectations_blac demobadexpectations_loan demobadexpectations_cost demobadexpectations_jobo demobadexpectations_inco demobadexpectations_sche demobadexpectations_othe demobadexpectations_dk demobadexpectations_nr, after(demobadexpectations)




********** . as ""
foreach x in moveoutsideforjobreason reasondontworkmore contactleaders  {
replace `x'="" if `x'=="."
}



********** Informal network
gen HHID=HHID2016
merge 1:1 HHID egoid using "C:\Users\Arnaud\Documents\MEGA\Research\Data\Data_NEEMSIS1\DATA\NEEMSIS-ego_tomerge_panel", keepusing(sntechnicalhelp snentrustbusiness snrecruitworker snfindsuppliers snlendtools snfindjob snrecommendforjob snrecojobsuccess sndemoasked_ego sndemogiven_ego) 
drop _merge
drop HHID

destring sndemoasked_ego, replace
label define sndemoasked_ego 1"Yes" 2"No need" 3"No one to ask" 4"Asked but was refused to help" 99"N/R"
label values sndemoasked_ego sndemoasked_ego
rename sndemoasked_ego sndemoasked

label define yesno 0"No" 1"Yes"
label values sndemogiven_ego yesno
rename sndemogiven_ego sndemogiven

fre sntechnicalhelp snentrustbusiness snrecruitworker snfindsuppliers snlendtools snfindjob snrecommendforjob snrecojobsuccess sndemoasked sndemogiven


********** Other
splitvarmcq reasondontworkmore 13
newn reasondontworkmore 1 stu
newn reasondontworkmore 2 hou
newn reasondontworkmore 3 ret
newn reasondontworkmore 4 old
newn reasondontworkmore 5 ill
newn reasondontworkmore 6 dis
newn reasondontworkmore 7 mil
newn reasondontworkmore 8 cha
newn reasondontworkmore 9 dem
newn reasondontworkmore 10 irr
newn reasondontworkmore 11 fle
newn reasondontworkmore 12 cas
newn reasondontworkmore 13 alr






save"Last/NEEMSIS1-ego", replace
****************************************
* END























****************************************
* NEEMSIS1-alters.dta
****************************************
use"NEEMSIS1-alters", clear


****
replace howmetother="" if howmetother=="."


********** . as ""
foreach x in occupother howmetother  {
replace `x'="" if `x'=="."
}


********** Drop
drop alterid_byNP1 nb_ntwother snTHnamelist snEBnamelist snRWnamelist snFSnamelist snLTnamelist snFJnamelist snRJnamelist snRJSnamelist snDAnamelist snDGnamelist


********** List
*
ta relationship
split relationship, destring
forvalues i=1/15 {
gen relationship_`i'=0 if relationship!=""
}
forvalues i=1/15 {
replace relationship_`i'=1 if relationship1==`i'
replace relationship_`i'=1 if relationship2==`i'
replace relationship_`i'=1 if relationship3==`i'
label var relationship_`i' "relationship=`i'"
label define yesno 0"No" 1"Yes", replace
label values relationship_`i' yesno
}
rename relationship_1 relationship_maistry
rename relationship_2 relationship_childnot
rename relationship_3 relationship_siblingnot
rename relationship_4 relationship_parentnot
rename relationship_5 relationship_niecenot
rename relationship_6 relationship_othernot
rename relationship_7 relationship_neighbor
rename relationship_8 relationship_friend
rename relationship_9 relationship_customer
rename relationship_10 relationship_moneylender
rename relationship_11 relationship_shgmb
rename relationship_12 relationship_employer
rename relationship_13 relationship_wkp
rename relationship_14 relationship_childin
rename relationship_15 relationship_spouse
drop relationship1 relationship2 relationship3
order relationship_maistry relationship_childnot relationship_siblingnot relationship_parentnot relationship_niecenot relationship_othernot relationship_neighbor relationship_friend relationship_customer relationship_moneylender relationship_shgmb relationship_employer relationship_wkp relationship_childin relationship_spouse, after(relationship)


*
ta demohelpasked
replace demohelpasked="1 77" if demohelpasked=="1 6"
replace demohelpasked="77" if demohelpasked=="7"
ta demohelpasked
split demohelpasked, destring
foreach i in 1 2 3 4 5 77 {
gen demohelpasked_`i'=0 if demohelpasked!=""
}
foreach i in 1 2 3 4 5 77 {
replace demohelpasked_`i'=1 if demohelpasked1==`i'
replace demohelpasked_`i'=1 if demohelpasked2==`i'
label var demohelpasked_`i' "demohelpasked=`i'"
label values demohelpasked_`i' yesno
}
rename demohelpasked_1 demohelpasked_lend
rename demohelpasked_2 demohelpasked_find
rename demohelpasked_3 demohelpasked_info
rename demohelpasked_4 demohelpasked_exch
rename demohelpasked_5 demohelpasked_inte
rename demohelpasked_77 demohelpasked_othe
drop demohelpasked1 demohelpasked2
order demohelpasked_lend demohelpasked_find demohelpasked_info demohelpasked_exch demohelpasked_inte demohelpasked_othe, after(demohelpasked)

*
ta democounterpartasked
replace democounterpartasked="77" if democounterpartasked=="5"
split democounterpartasked, destring
foreach i in 1 2 3 4 77 {
gen democounterpartasked_`i'=0 if democounterpartasked!=""
}
foreach i in 1 2 3 4 77 {
replace democounterpartasked_`i'=1 if democounterpartasked1==`i'
replace democounterpartasked_`i'=1 if democounterpartasked2==`i'
label var democounterpartasked_`i' "democounterpartasked=`i'"
label values democounterpartasked_`i' yesno
}
rename democounterpartasked_1 democounterpartasked_offe
rename democounterpartasked_2 democounterpartasked_comm
rename democounterpartasked_3 democounterpartasked_serv
rename democounterpartasked_4 democounterpartasked_noco
rename democounterpartasked_77 democounterpartasked_othe
drop democounterpartasked1 democounterpartasked2
order democounterpartasked_offe democounterpartasked_comm democounterpartasked_serv democounterpartasked_noco democounterpartasked_othe, after(democounterpartasked)

drop sndemogivennber sndemoaskednber snrecommendforjobnber snfindjobnber snfindsuppliersnber sntechnicalhelpnber snrecommendassonber snrecojobsuccessnber snlendtoolsnber snrecruitworkernber snentrustbusinessnber

drop dummydemonetisation villageid villageareaid householdid dummynewHH

drop interviewplace submissiondate


replace durationknown=durationknown/12 if durationknown==206



save"Last/NEEMSIS1-alters", replace
****************************************
* END



