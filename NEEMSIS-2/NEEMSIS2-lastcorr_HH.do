*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 14, 2023
*-----
*NEEMSIS-2 HH last clean
*-----
********** Clear
clear all
macro drop _all
********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2"
********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\2020-NEEMSIS2\Data\4team"
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
* NEEMSIS2-HH.dta
****************************************
use"NEEMSIS2-HH", clear


*********** Educ preload
merge 1:1 HHID2020 INDID2020 using "C:\Users\Arnaud\Documents\Dropbox (IRD)\RUME II\2. Data\Constructed_data\edupreload\NEEMSIS2-edupreload", keepusing(datafromearlier data)
drop _merge
ta data
ta datafromearlier
rename datafromearlier educpreload
order educpreload, before(canread)
label var educpreload "Does the individual have preloaded data for the education module?"
label values educpreload yesno



recode subjectsafter10th (7=77) (8=77)




ta reservationgrade
split reservationgrade, destring
recode reservationgrade1 reservationgrade2 reservationgrade3 reservationgrade4 reservationgrade5 reservationgrade6 reservationgrade7 reservationgrade8 reservationgrade9 reservationgrade10 reservationgrade11 reservationgrade12 reservationgrade13 reservationgrade14 (15=13) (16=14)
forvalues i=1/14 {
gen reservationgrade_`i'=0 if reservationgrade!=""
}
forvalues i=1/14{
replace reservationgrade_`i'=1 if reservationgrade1==`i'
replace reservationgrade_`i'=1 if reservationgrade2==`i'
replace reservationgrade_`i'=1 if reservationgrade3==`i'
replace reservationgrade_`i'=1 if reservationgrade4==`i'
replace reservationgrade_`i'=1 if reservationgrade5==`i'
replace reservationgrade_`i'=1 if reservationgrade6==`i'
replace reservationgrade_`i'=1 if reservationgrade7==`i'
replace reservationgrade_`i'=1 if reservationgrade8==`i'
replace reservationgrade_`i'=1 if reservationgrade9==`i'
replace reservationgrade_`i'=1 if reservationgrade10==`i'
replace reservationgrade_`i'=1 if reservationgrade11==`i'
replace reservationgrade_`i'=1 if reservationgrade12==`i'
replace reservationgrade_`i'=1 if reservationgrade13==`i'
replace reservationgrade_`i'=1 if reservationgrade14==`i'
label var reservationgrade_`i' "reservationgrade=`i'"
label values reservationgrade_`i' yesno
}
rename reservationgrade_1 reservationgrade_1st
rename reservationgrade_2 reservationgrade_2nd
rename reservationgrade_3 reservationgrade_3rd
rename reservationgrade_4 reservationgrade_4th
rename reservationgrade_5 reservationgrade_5th
rename reservationgrade_6 reservationgrade_6th
rename reservationgrade_7 reservationgrade_7th
rename reservationgrade_8 reservationgrade_8th
rename reservationgrade_9 reservationgrade_9th
rename reservationgrade_10 reservationgrade_10th
rename reservationgrade_11 reservationgrade_11th
rename reservationgrade_12 reservationgrade_12th
rename reservationgrade_13 reservationgrade_bach
rename reservationgrade_14 reservationgrade_abov
drop reservationgrade1 reservationgrade2 reservationgrade3 reservationgrade4 reservationgrade5 reservationgrade6 reservationgrade7 reservationgrade8 reservationgrade9 reservationgrade10 reservationgrade11 reservationgrade12 reservationgrade13 reservationgrade14
order reservationgrade_1st reservationgrade_2nd reservationgrade_3rd reservationgrade_4th reservationgrade_5th reservationgrade_6th reservationgrade_7th reservationgrade_8th reservationgrade_9th reservationgrade_10th reservationgrade_11th reservationgrade_12th reservationgrade_bach reservationgrade_abov, after(reservationgrade)


ta reservationkind
split reservationkind, destring
recode reservationkind1 reservationkind2 reservationkind3 reservationkind4 (77=6)
forvalues i=1/6 {
gen reservationkind_`i'=0 if reservationkind!=""
}
forvalues i=1/6 {
replace reservationkind_`i'=1 if reservationkind1==`i'
replace reservationkind_`i'=1 if reservationkind2==`i'
replace reservationkind_`i'=1 if reservationkind3==`i'
replace reservationkind_`i'=1 if reservationkind4==`i'
label var reservationkind_`i' "reservationkind=`i'"
label values reservationkind_`i' yesno
}
rename reservationkind_1 reservationkind_quot
rename reservationkind_2 reservationkind_free
rename reservationkind_3 reservationkind_scho
rename reservationkind_4 reservationkind_spec
rename reservationkind_5 reservationkind_meal
rename reservationkind_6 reservationkind_othe
drop reservationkind1 reservationkind2 reservationkind3 reservationkind4
order reservationkind_quot reservationkind_free reservationkind_scho reservationkind_spec reservationkind_meal reservationkind_othe, after(reservationkind)



ta reasonneverattendedschool
replace reasonneverattendedschool="" if reasonneverattendedschool=="."
split reasonneverattendedschool, destring
forvalues i=1/13 {
gen reasonneverattendedschool_`i'=0 if reasonneverattendedschool!=""
}
forvalues i=1/13 {
replace reasonneverattendedschool_`i'=1 if reasonneverattendedschool1==`i'
replace reasonneverattendedschool_`i'=1 if reasonneverattendedschool2==`i'
label values reasonneverattendedschool_`i' yesno
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
order reasonneverattendedschool_fail reasonneverattendedschool_inac reasonneverattendedschool_qual reasonneverattendedschool_fina reasonneverattendedschool_heal reasonneverattendedschool_noin reasonneverattendedschool_care reasonneverattendedschool_work reasonneverattendedschool_girl reasonneverattendedschool_marr reasonneverattendedschool_noal reasonneverattendedschool_pube reasonneverattendedschool_baby, after(reasonneverattendedschool)



ta reasondropping
replace reasondropping="" if reasondropping=="."
split reasondropping, destring
recode reasondropping1 reasondropping2 (77=16)
forvalues i=1/16 {
gen reasondropping_`i'=0 if reasondropping!=""
}
forvalues i=1/16 {
replace reasondropping_`i'=1 if reasondropping1==`i'
replace reasondropping_`i'=1 if reasondropping2==`i'
label values reasondropping_`i' yesno
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
rename reasondropping_15 reasondropping_covi
rename reasondropping_16 reasondropping_othe
drop reasondropping1 reasondropping2
order reasondropping_stop reasondropping_fail reasondropping_inac reasondropping_qual reasondropping_fina reasondropping_heal reasondropping_noin reasondropping_care reasondropping_work reasondropping_girl reasondropping_marr reasondropping_noal reasondropping_pube reasondropping_baby reasondropping_covi reasondropping_othe, after(reasondropping)


destring covgoingbackschool, replace
label values covgoingbackschool yesno


ta kindofworkinactive
split kindofworkinactive, destring
forvalues i=1/8 {
gen kindofworkinactive_`i'=0 if kindofworkinactive!=""
}
forvalues i=1/8 {
replace kindofworkinactive_`i'=1 if kindofworkinactive1==`i'
replace kindofworkinactive_`i'=1 if kindofworkinactive2==`i'
label var kindofworkinactive_`i' "kindofworkinactive=`i'"
label values kindofworkinactive_`i' yesno
}
rename kindofworkinactive_1 kindofworkinactive_agri
rename kindofworkinactive_2 kindofworkinactive_se
rename kindofworkinactive_3 kindofworkinactive_sjagri
rename kindofworkinactive_4 kindofworkinactive_sjnonagri
rename kindofworkinactive_5 kindofworkinactive_uwownnonagri
rename kindofworkinactive_6 kindofworkinactive_uwothnongri
rename kindofworkinactive_7 kindofworkinactive_uwownagri
rename kindofworkinactive_8 kindofworkinactive_uwothagri
drop kindofworkinactive1 kindofworkinactive2
order kindofworkinactive_agri kindofworkinactive_se kindofworkinactive_sjagri kindofworkinactive_sjnonagri kindofworkinactive_uwownnonagri kindofworkinactive_uwothnongri kindofworkinactive_uwownagri kindofworkinactive_uwothagri, after(kindofworkinactive)




********** Migration
label values dummymigrantlist yesno


ta migrationjoblist
split migrationjoblist, destring
forvalues i=1/9 {
gen migrationjoblist_`i'=0 if migrationjoblist!=""
}
forvalues i=1/9 {
replace migrationjoblist_`i'=0 if migrationjoblist1==`i'
replace migrationjoblist_`i'=0 if migrationjoblist2==`i'
label var migrationjoblist_`i' "migrationjoblist=`i'"
label values migrationjoblist_`i' yesno
}
rename migrationjoblist_1 migrationjoblist_brick
rename migrationjoblist_2 migrationjoblist_sugar
rename migrationjoblist_3 migrationjoblist_const
rename migrationjoblist_4 migrationjoblist_nagco
rename migrationjoblist_5 migrationjoblist_agrco
rename migrationjoblist_6 migrationjoblist_priva
rename migrationjoblist_7 migrationjoblist_publi
rename migrationjoblist_8 migrationjoblist_selfe
rename migrationjoblist_9 migrationjoblist_follo
drop migrationjoblist1 migrationjoblist2
order migrationjoblist_brick migrationjoblist_sugar migrationjoblist_const migrationjoblist_nagco migrationjoblist_agrco migrationjoblist_priva migrationjoblist_publi migrationjoblist_selfe migrationjoblist_follo, after(migrationjoblist)




********** Remittances received
label values dummyremrecipientlist yesno


preserve
use"NEEMSIS2-HH", clear
keep HHID2020 INDID2020 remrecipientsourcename* remrecipientsourcenametwo* remreceivedsourcerelation* remreceivedsourceoccup* remreceivedsourceplace* remreceivedmoney* remgift* remreceivedservices* remreceivedfrequency* remreceivedamount* remreceivedtotalamount* remreceivedmean* remgiftnb* remgiftamount* remreceivedsourceoccupother* remreceivedservicesother* covremreceived*
reshape long remrecipientsourcename remrecipientsourcenametwo remreceivedsourcerelation remreceivedsourceoccup remreceivedsourceplace remreceivedmoney remgift remreceivedservices remreceivedfrequency remreceivedamount remreceivedtotalamount remreceivedmean remgiftnb remgiftamount remreceivedsourceoccupother remreceivedservicesother covremreceived, i(HHID2020 INDID2020) j(n)
drop if remrecipientsourcename==.

ta remreceivedservices
split remreceivedservices, destring
recode remreceivedservices1 remreceivedservices2 remreceivedservices3 remreceivedservices4 (77=6)
forvalues i=1/6 {
gen remreceivedservices_`i'=0 if remreceivedservices!=""
}
forvalues i=1/6 {
replace remreceivedservices_`i'=1 if remreceivedservices1==`i'
replace remreceivedservices_`i'=1 if remreceivedservices2==`i'
replace remreceivedservices_`i'=1 if remreceivedservices3==`i'
replace remreceivedservices_`i'=1 if remreceivedservices4==`i'
label var remreceivedservices_`i' "remreceivedservices=`i'"
label values remreceivedservices_`i' yesno
}
rename remreceivedservices_1 remreceivedservices_poli
rename remreceivedservices_2 remreceivedservices_fina
rename remreceivedservices_3 remreceivedservices_guar
rename remreceivedservices_4 remreceivedservices_gene
rename remreceivedservices_5 remreceivedservices_none
rename remreceivedservices_6 remreceivedservices_othe
drop remreceivedservices1 remreceivedservices2 remreceivedservices3 remreceivedservices4
order remreceivedservices_poli remreceivedservices_fina remreceivedservices_guar remreceivedservices_gene remreceivedservices_none remreceivedservices_othe, after(remreceivedservices)


ta remreceivedmean
split remreceivedmean, destring
recode remreceivedmean1 remreceivedmean2 remreceivedmean3 (77=4)
forvalues i=1/4 {
gen remreceivedmean_`i'=0 if remreceivedmean!=""
}
forvalues i=1/4 {
replace remreceivedmean_`i'=1 if remreceivedmean1==`i'
replace remreceivedmean_`i'=1 if remreceivedmean2==`i'
replace remreceivedmean_`i'=1 if remreceivedmean3==`i'
label var remreceivedmean_`i' "remreceivedmean=`i'"
label values remreceivedmean_`i' yesno
}
rename remreceivedmean_1 remreceivedmean_cash
rename remreceivedmean_2 remreceivedmean_mobi
rename remreceivedmean_3 remreceivedmean_bank
rename remreceivedmean_4 remreceivedmean_othe
drop remreceivedmean1 remreceivedmean2 remreceivedmean3
order remreceivedmean_cash remreceivedmean_mobi remreceivedmean_bank remreceivedmean_othe, after(remreceivedmean)

reshape wide remrecipientsourcename remrecipientsourcenametwo remreceivedsourcerelation remreceivedsourceoccup remreceivedsourceplace remreceivedmoney remgift remreceivedservices remreceivedservices_poli remreceivedservices_fina remreceivedservices_guar remreceivedservices_gene remreceivedservices_none remreceivedservices_othe remreceivedfrequency remreceivedamount remreceivedtotalamount remreceivedmean remreceivedmean_cash remreceivedmean_mobi remreceivedmean_bank remreceivedmean_othe remgiftnb remgiftamount remreceivedsourceoccupother remreceivedservicesother covremreceived, i(HHID2020 INDID2020) j(n)

save"_temp/_tempremrec.dta", replace
restore

drop remrecipientsourcename1 remrecipientsourcenametwo1 remreceivedsourcerelation1 remreceivedsourceoccup1 remreceivedsourceplace1 remreceivedmoney1 remgift1 remreceivedservices1 remreceivedfrequency1 remreceivedamount1 remreceivedtotalamount1 remreceivedmean1 remgiftnb1 remgiftamount1 remreceivedsourceoccupother1 remreceivedservicesother1 covremreceived1 remrecipientsourcename2 remrecipientsourcenametwo2 remreceivedsourcerelation2 remreceivedsourceoccup2 remreceivedsourceplace2 remreceivedmoney2 remgift2 remreceivedservices2 remreceivedfrequency2 remreceivedamount2 remreceivedtotalamount2 remreceivedmean2 remgiftnb2 remgiftamount2 remreceivedsourceoccupother2 remreceivedservicesother2 covremreceived2 remrecipientsourcename3 remrecipientsourcenametwo3 remreceivedsourcerelation3 remreceivedsourceoccup3 remreceivedsourceplace3 remreceivedmoney3 remgift3 remreceivedservices3 remreceivedfrequency3 remreceivedamount3 remreceivedtotalamount3 remreceivedmean3 remgiftnb3 remgiftamount3 remreceivedsourceoccupother3 remreceivedservicesother3 covremreceived3 remrecipientsourcename4 remrecipientsourcenametwo4 remreceivedsourcerelation4 remreceivedsourceoccup4 remreceivedsourceplace4 remreceivedmoney4 remgift4 remreceivedservices4 remreceivedfrequency4 remreceivedamount4 remreceivedtotalamount4 remreceivedmean4 remgiftnb4 remgiftamount4 remreceivedsourceoccupother4 remreceivedservicesother4 covremreceived4

merge 1:1 HHID2020 INDID2020 using "_temp/_tempremrec.dta"
drop _merge
order remrecipientsourcename1 remrecipientsourcenametwo1 remreceivedsourcerelation1 remreceivedsourceoccup1 remreceivedsourceplace1 remreceivedmoney1 remgift1 remreceivedservices1 remreceivedservices_poli1 remreceivedservices_fina1 remreceivedservices_guar1 remreceivedservices_gene1 remreceivedservices_none1 remreceivedservices_othe1 remreceivedfrequency1 remreceivedamount1 remreceivedtotalamount1 remreceivedmean1 remreceivedmean_cash1 remreceivedmean_mobi1 remreceivedmean_bank1 remreceivedmean_othe1 remgiftnb1 remgiftamount1 remreceivedsourceoccupother1 remreceivedservicesother1 covremreceived1 remrecipientsourcename2 remrecipientsourcenametwo2 remreceivedsourcerelation2 remreceivedsourceoccup2 remreceivedsourceplace2 remreceivedmoney2 remgift2 remreceivedservices2 remreceivedservices_poli2 remreceivedservices_fina2 remreceivedservices_guar2 remreceivedservices_gene2 remreceivedservices_none2 remreceivedservices_othe2 remreceivedfrequency2 remreceivedamount2 remreceivedtotalamount2 remreceivedmean2 remreceivedmean_cash2 remreceivedmean_mobi2 remreceivedmean_bank2 remreceivedmean_othe2 remgiftnb2 remgiftamount2 remreceivedsourceoccupother2 remreceivedservicesother2 covremreceived2 remrecipientsourcename3 remrecipientsourcenametwo3 remreceivedsourcerelation3 remreceivedsourceoccup3 remreceivedsourceplace3 remreceivedmoney3 remgift3 remreceivedservices3 remreceivedservices_poli3 remreceivedservices_fina3 remreceivedservices_guar3 remreceivedservices_gene3 remreceivedservices_none3 remreceivedservices_othe3 remreceivedfrequency3 remreceivedamount3 remreceivedtotalamount3 remreceivedmean3 remreceivedmean_cash3 remreceivedmean_mobi3 remreceivedmean_bank3 remreceivedmean_othe3 remgiftnb3 remgiftamount3 remreceivedsourceoccupother3 remreceivedservicesother3 covremreceived3 remrecipientsourcename4 remrecipientsourcenametwo4 remreceivedsourcerelation4 remreceivedsourceoccup4 remreceivedsourceplace4 remreceivedmoney4 remgift4 remreceivedservices4 remreceivedservices_poli4 remreceivedservices_fina4 remreceivedservices_guar4 remreceivedservices_gene4 remreceivedservices_none4 remreceivedservices_othe4 remreceivedfrequency4 remreceivedamount4 remreceivedtotalamount4 remreceivedmean4 remreceivedmean_cash4 remreceivedmean_mobi4 remreceivedmean_bank4 remreceivedmean_othe4 remgiftnb4 remgiftamount4 remreceivedsourceoccupother4 remreceivedservicesother4 covremreceived4, after(dummyremrecipientlist)


********** Remittances sent
label values dummyremsenderlist yesno


preserve
use"NEEMSIS2-HH", clear

keep HHID2020 INDID2020 remsentname* remsentnametwo* remsentdummyvillage* remsentrelation* remsentoccup* remsentplace* remsentmoney* remsentgift* remsentservices* remsentsourceoccupother* remsentservicesother* remsentfrequency* remsentamount* remsenttotalamount* remsentmean* remsentgiftnb* remsentgiftamount* covremsent*
reshape long remsentname remsentnametwo remsentdummyvillage remsentrelation remsentoccup remsentplace remsentmoney remsentgift remsentservices remsentsourceoccupother remsentservicesother remsentfrequency remsentamount remsenttotalamount remsentmean remsentgiftnb remsentgiftamount covremsent, i(HHID2020 INDID2020) j(n)
drop if remsentname==.

ta remsentservices
split remsentservices, destring
recode remsentservices1 remsentservices2 remsentservices3 (77=6)
forvalues i=1/6 {
gen remsentservices_`i'=0 if remsentservices!=""
}
forvalues i=1/6 {
replace remsentservices_`i'=0 if remsentservices1==`i'
replace remsentservices_`i'=0 if remsentservices2==`i'
replace remsentservices_`i'=0 if remsentservices3==`i'
label var remsentservices_`i' "remsentservices=`i'"
label values remsentservices_`i' yesno
}
rename remsentservices_1 remsentservices_poli
rename remsentservices_2 remsentservices_fina
rename remsentservices_3 remsentservices_guar
rename remsentservices_4 remsentservices_gene
rename remsentservices_5 remsentservices_none
rename remsentservices_6 remsentservices_othe
drop remsentservices1 remsentservices2 remsentservices3
order remsentservices_poli remsentservices_fina remsentservices_guar remsentservices_gene remsentservices_none remsentservices_othe, after(remsentservices)


ta  remsentmean
split  remsentmean, destring
recode  remsentmean1  remsentmean2  remsentmean3 (77=4)
forvalues i=1/4 {
gen  remsentmean_`i'=0 if  remsentmean!=""
}
forvalues i=1/4 {
replace  remsentmean_`i'=1 if  remsentmean1==`i'
replace  remsentmean_`i'=1 if  remsentmean2==`i'
replace  remsentmean_`i'=1 if  remsentmean3==`i'
label var  remsentmean_`i' " remsentmean=`i'"
label values  remsentmean_`i' yesno
}
rename  remsentmean_1  remsentmean_cash
rename  remsentmean_2  remsentmean_mobi
rename  remsentmean_3  remsentmean_bank
rename  remsentmean_4  remsentmean_othe
drop  remsentmean1  remsentmean2  remsentmean3
order  remsentmean_cash  remsentmean_mobi  remsentmean_bank  remsentmean_othe, after( remsentmean)

reshape wide remsentname remsentnametwo remsentdummyvillage remsentrelation remsentoccup remsentplace remsentmoney remsentgift remsentservices remsentservices_poli remsentservices_fina remsentservices_guar remsentservices_gene remsentservices_none remsentservices_othe remsentsourceoccupother remsentservicesother remsentfrequency remsentamount remsenttotalamount remsentmean remsentmean_cash remsentmean_mobi remsentmean_bank remsentmean_othe remsentgiftnb remsentgiftamount covremsent, i(HHID2020 INDID2020) j(n)
save "_temp/_tempremsent.dta", replace
restore

drop remsentname1 remsentnametwo1 remsentdummyvillage1 remsentrelation1 remsentoccup1 remsentplace1 remsentmoney1 remsentgift1 remsentservices1 remsentsourceoccupother1 remsentservicesother1 remsentfrequency1 remsentamount1 remsenttotalamount1 remsentmean1 remsentgiftnb1 remsentgiftamount1 covremsent1 remsentname2 remsentnametwo2 remsentdummyvillage2 remsentrelation2 remsentoccup2 remsentplace2 remsentmoney2 remsentgift2 remsentservices2 remsentsourceoccupother2 remsentservicesother2 remsentfrequency2 remsentamount2 remsenttotalamount2 remsentmean2 remsentgiftnb2 remsentgiftamount2 covremsent2 remsentname3 remsentnametwo3 remsentdummyvillage3 remsentrelation3 remsentoccup3 remsentplace3 remsentmoney3 remsentgift3 remsentservices3 remsentsourceoccupother3 remsentservicesother3 remsentfrequency3 remsentamount3 remsenttotalamount3 remsentmean3 remsentgiftnb3 remsentgiftamount3 covremsent3 remsentname4 remsentnametwo4 remsentdummyvillage4 remsentrelation4 remsentoccup4 remsentplace4 remsentmoney4 remsentgift4 remsentservices4 remsentsourceoccupother4 remsentservicesother4 remsentfrequency4 remsentamount4 remsenttotalamount4 remsentmean4 remsentgiftnb4 remsentgiftamount4 covremsent4 remsentname5 remsentnametwo5 remsentdummyvillage5 remsentrelation5 remsentoccup5 remsentplace5 remsentmoney5 remsentgift5 remsentservices5 remsentsourceoccupother5 remsentservicesother5 remsentfrequency5 remsentamount5 remsenttotalamount5 remsentmean5 remsentgiftnb5 remsentgiftamount5 covremsent5

merge 1:1 HHID2020 INDID2020 using "_temp/_tempremsent"
drop _merge
order remsentname1 remsentnametwo1 remsentdummyvillage1 remsentrelation1 remsentoccup1 remsentplace1 remsentmoney1 remsentgift1 remsentservices1 remsentservices_poli1 remsentservices_fina1 remsentservices_guar1 remsentservices_gene1 remsentservices_none1 remsentservices_othe1 remsentsourceoccupother1 remsentservicesother1 remsentfrequency1 remsentamount1 remsenttotalamount1 remsentmean1 remsentmean_cash1 remsentmean_mobi1 remsentmean_bank1 remsentmean_othe1 remsentgiftnb1 remsentgiftamount1 covremsent1 remsentname2 remsentnametwo2 remsentdummyvillage2 remsentrelation2 remsentoccup2 remsentplace2 remsentmoney2 remsentgift2 remsentservices2 remsentservices_poli2 remsentservices_fina2 remsentservices_guar2 remsentservices_gene2 remsentservices_none2 remsentservices_othe2 remsentsourceoccupother2 remsentservicesother2 remsentfrequency2 remsentamount2 remsenttotalamount2 remsentmean2 remsentmean_cash2 remsentmean_mobi2 remsentmean_bank2 remsentmean_othe2 remsentgiftnb2 remsentgiftamount2 covremsent2 remsentname3 remsentnametwo3 remsentdummyvillage3 remsentrelation3 remsentoccup3 remsentplace3 remsentmoney3 remsentgift3 remsentservices3 remsentservices_poli3 remsentservices_fina3 remsentservices_guar3 remsentservices_gene3 remsentservices_none3 remsentservices_othe3 remsentsourceoccupother3 remsentservicesother3 remsentfrequency3 remsentamount3 remsenttotalamount3 remsentmean3 remsentmean_cash3 remsentmean_mobi3 remsentmean_bank3 remsentmean_othe3 remsentgiftnb3 remsentgiftamount3 covremsent3 remsentname4 remsentnametwo4 remsentdummyvillage4 remsentrelation4 remsentoccup4 remsentplace4 remsentmoney4 remsentgift4 remsentservices4 remsentservices_poli4 remsentservices_fina4 remsentservices_guar4 remsentservices_gene4 remsentservices_none4 remsentservices_othe4 remsentsourceoccupother4 remsentservicesother4 remsentfrequency4 remsentamount4 remsenttotalamount4 remsentmean4 remsentmean_cash4 remsentmean_mobi4 remsentmean_bank4 remsentmean_othe4 remsentgiftnb4 remsentgiftamount4 covremsent4 remsentname5 remsentnametwo5 remsentdummyvillage5 remsentrelation5 remsentoccup5 remsentplace5 remsentmoney5 remsentgift5 remsentservices5 remsentservices_poli5 remsentservices_fina5 remsentservices_guar5 remsentservices_gene5 remsentservices_none5 remsentservices_othe5 remsentsourceoccupother5 remsentservicesother5 remsentfrequency5 remsentamount5 remsenttotalamount5 remsentmean5 remsentmean_cash5 remsentmean_mobi5 remsentmean_bank5 remsentmean_othe5 remsentgiftnb5 remsentgiftamount5 covremsent5, after(dummyremsenderlist)


label define covremsent 1"More" 2"Less" 3"Same"
forvalues i=1/5 {
destring covremsent`i', replace
label values covremsent`i' covremsent
}






********** Loans
label values dummyborrowerlist yesno






********** Lending money 
label values dummyhhlenderlist yesno

ta relationwithborrower
split relationwithborrower, destring
forvalues i=1/14 {
gen relationwithborrower_`i'=0 if relationwithborrower!=""
}
forvalues i=1/14 {
replace relationwithborrower_`i'=1 if relationwithborrower1==`i'
replace relationwithborrower_`i'=1 if relationwithborrower2==`i'
replace relationwithborrower_`i'=1 if relationwithborrower3==`i'
replace relationwithborrower_`i'=1 if relationwithborrower4==`i'
label values relationwithborrower_`i' yesno
label var relationwithborrower_`i' "relationwithborrower=`i'"
}
rename relationwithborrower_1 relationwithborrower_mais
rename relationwithborrower_2 relationwithborrower_chil
rename relationwithborrower_3 relationwithborrower_sibl
rename relationwithborrower_4 relationwithborrower_pare
rename relationwithborrower_5 relationwithborrower_niec
rename relationwithborrower_6 relationwithborrower_othe
rename relationwithborrower_7 relationwithborrower_neig
rename relationwithborrower_8 relationwithborrower_frie
rename relationwithborrower_9 relationwithborrower_cust
rename relationwithborrower_10 relationwithborrower_mone
rename relationwithborrower_11 relationwithborrower_shg
rename relationwithborrower_12 relationwithborrower_empl
rename relationwithborrower_13 relationwithborrower_wkp
rename relationwithborrower_14 relationwithborrower_spou
drop relationwithborrower1 relationwithborrower2 relationwithborrower3
order relationwithborrower_mais relationwithborrower_chil relationwithborrower_sibl relationwithborrower_pare relationwithborrower_niec relationwithborrower_othe relationwithborrower_neig relationwithborrower_frie relationwithborrower_cust relationwithborrower_mone relationwithborrower_shg relationwithborrower_empl relationwithborrower_wkp relationwithborrower_spou, after(relationwithborrower)





save"Last/NEEMSIS2-HH", replace
****************************************
* END















****************************************
* NEEMSIS2-occupations.dta
****************************************
use"NEEMSIS2-occupations", clear

*****
ta businessskill
split businessskill, destring
forvalues i=1/4 {
gen businessskill_`i'=0 if businessskill!=""
}
forvalues i=1/4 {
replace businessskill_`i'=1 if businessskill1==`i'
replace businessskill_`i'=1 if businessskill2==`i'
replace businessskill_`i'=1 if businessskill3==`i'
label values businessskill_`i' yesno
label var businessskill_`i' "businessskill=`i'"
}
rename businessskill_1 businessskill_fami
rename businessskill_2 businessskill_frie
rename businessskill_3 businessskill_scho
rename businessskill_4 businessskill_expe
drop businessskill1 businessskill2 businessskill3
order businessskill_fami businessskill_frie businessskill_scho businessskill_expe, after(businessskill)



ta businesslocation
split businesslocation, destring
forvalues i=1/7 {
gen businesslocation_`i'=0 if businesslocation!=""
}
forvalues i=1/7 {
replace businesslocation_`i'=1 if businesslocation1==`i'
replace businesslocation_`i'=1 if businesslocation2==`i'
replace businesslocation_`i'=1 if businesslocation3==`i'
replace businesslocation_`i'=1 if businesslocation4==`i'
replace businesslocation_`i'=1 if businesslocation5==`i'
replace businesslocation_`i'=1 if businesslocation6==`i'
replace businesslocation_`i'=1 if businesslocation7==`i'
label var businesslocation_`i' "businesslocation=`i'"
label values businesslocation_`i' yesno
}
rename businesslocation_1 businesslocation_vill
rename businesslocation_2 businesslocation_arou
rename businesslocation_3 businesslocation_rutn
rename businesslocation_4 businesslocation_town
rename businesslocation_5 businesslocation_citi
rename businesslocation_6 businesslocation_ruout
rename businesslocation_7 businesslocation_citiout
drop businesslocation1 businesslocation2 businesslocation3 businesslocation4 businesslocation5 businesslocation6 businesslocation7
order businesslocation_vill businesslocation_arou businesslocation_rutn businesslocation_town businesslocation_citi businesslocation_ruout businesslocation_citiout,after(businesslocation)





********** Salaried job
ta joblocation
split joblocation, destring
forvalues i=1/7 {
gen joblocation_`i'=0 if joblocation!=""
}
forvalues i=1/7 {
replace joblocation_`i'=1 if joblocation1==`i'
replace joblocation_`i'=1 if joblocation2==`i'
replace joblocation_`i'=1 if joblocation3==`i'
replace joblocation_`i'=1 if joblocation4==`i'
replace joblocation_`i'=1 if joblocation5==`i'
label var joblocation_`i' "joblocation=`i'"
label values joblocation_`i' yesno
}
rename joblocation_1 joblocation_vill
rename joblocation_2 joblocation_arou
rename joblocation_3 joblocation_rutn
rename joblocation_4 joblocation_town
rename joblocation_5 joblocation_citi
rename joblocation_6 joblocation_ruout
rename joblocation_7 joblocation_citiout
drop joblocation1 joblocation2 joblocation3 joblocation4 joblocation5
order joblocation_vill joblocation_arou joblocation_rutn joblocation_town joblocation_citi joblocation_ruout joblocation_citiout, after(joblocation)





save"Last/NEEMSIS2-occupations", replace
****************************************
* END



















****************************************
* NEEMSIS2-migrations.dta
****************************************
use"NEEMSIS2-migrations.dta", clear


ta migrationjobid
label define migrationjobid 1"Brick kiln" 2"Sugar cane cutting" 3"Construction work" 4"Coolie non-agri" 5"Coolie agri" 6"Work in private company" 7"Work in public institution" 8"Self-employment" 9"Following family members"
label values migrationjobid migrationjobid

foreach x in migrationarea_bigcitiestn migrationarea_citiesout migrationarea_smalltown migrationarea_ruraltn migrationarea_ruralout migrationarea_villages migrationfindjob_maistry migrationfindjob_friends migrationfindjob_knownpers migrationfindjob_advertis migrationfindjob_themselves migrationfindjob_goregular advancebalanceproblem_same advancebalanceproblem_less advancebalanceproblem_scoled advancebalanceproblem_never advancebalanceproblem_complain advancebalanceproblem_nothing migrationskill_experience migrationskill_network migrationskill_nothing migrationskill_skill migrationskill_education migrationreason_nowork migrationreason_opportunity migrationreason_money migrationreason_status migrationreason_repay migrationreason_family migrationreason_assurance migrationreason_advance migrationreason_interesting migrationreason_diversify migrationreason_someone covpressuremanage_balance covpressuremanage_borrow covmigrationagainreason_other covmigrationagainreason_nowork covmigrationagainreason_opport covmigrationagainreason_intere covmigrationagainreason_repay covmigrationagainreason_money covmigrationagainreason_famil covmigrationagainreason_advanc covmigrationagainreason_assura covmigrationagainreason_status {
label values `x' yesno
}


foreach x in migrationarea_* migrationfindjob_* migrationskill_* migrationreason_* {
recode `x' (.=0)
}


replace covpressuremanage_borrow=0 if covpressuremanage!="" & covpressuremanage_borrow==.
replace covpressuremanage_balance=0 if covpressuremanage!="" & covpressuremanage_balance==.

foreach x in covmigrationagainreason_other covmigrationagainreason_nowork covmigrationagainreason_opport covmigrationagainreason_intere covmigrationagainreason_repay covmigrationagainreason_money covmigrationagainreason_famil covmigrationagainreason_advanc covmigrationagainreason_assura covmigrationagainreason_status {
replace `x'=0 if covmigrationagainreason!="" & `x'==.
}


ta covdealcovid19
destring covdealcovid19, replace
label define covdealcovid19 1"Stay at the migration place to work" 2"Stay at the migration place without working" 3"Get back home because the work has been stopping" 4"Get back home but the work has not been stopped"
label values covdealcovid19 covdealcovid19

foreach x in covmealemployer covmigrationagain {
ta `x'
destring `x', replace
label values `x' yesno
}



save"Last/NEEMSIS2-migrations", replace
****************************************
* END






















****************************************
* NEEMSIS2-loans_mainloans.dta
****************************************
use"NEEMSIS2-loans_mainloans.dta", clear

foreach x in snmoneylenderdummyfam snmoneylenderfriend snmoneylenderwkp snmoneylenderlabourrelation {
destring `x', replace
label values `x' yesno
}

ta snmoneylenderage
label define snmoneylenderage 1"15-25" 2"26-35" 3"36-45" 4"46-55" 5"56-65" 6"More than 65"
label values snmoneylenderage snmoneylenderage

ta snmoneylenderlabourtype
label define snmoneylenderlabourtype 1"Employer" 2"Colleague" 3"Maistry" 4"Supplier"
label values snmoneylenderlabourtype snmoneylenderlabourtype

ta snmoneylendereduc
label define snmoneylendereduc 1"Primary education or below (5th std or less)" 2"Upper primary (8th std)" 3"High school/ITI (10th std)" 4"Senior secondary/Technical education (12th)" 5"Bachelor and above (15th)" 6"No education" 88"Don't know"
label values snmoneylendereduc snmoneylendereduc

ta snmoneylenderemployertype
label define snmoneylenderemployertype 1"State administration (including military)" 2"State-owned enterprise/farm or joint state-private enterprise" 3"Paid public works" 4"An individual (maistry, etc.)" 5"Private firm or plant or farm" 6"Cooperative firm/farm" 7"NGO/international, political, humanitarian organization" 77"Other"
label values snmoneylenderemployertype snmoneylenderemployertype

ta snmoneylenderruralurban
label define snmoneylenderruralurban 1"Urban area" 2"Rural area"
label values snmoneylenderruralurban snmoneylenderruralurban

ta snmoneylenderdistrict
label define snmoneylenderdistrict 2"Chengalpet" 3"Chennai" 4"Coimbatore" 5"Cuddalore" 9"Kallakurichi" 10"Kancheepuram" 17"Namakkal" 22"Salem" 32"Tiruppur" 33"Thiruvannamalai" 35"Vellore" 36"Viluppuram"
label values snmoneylenderdistrict snmoneylenderdistrict

ta snmoneylendercompared
destring snmoneylendercompared, replace
label define snmoneylendercompared 1"In a better economic situation" 2"In the same economic situation" 3"In a worst economic situation"
label values snmoneylendercompared snmoneylendercompared

ta snmoneylendermeet
label define snmoneylendermeet 1"Labour relation" 2"Neighborhood relation" 3"Introduced by family member (blood relationship)" 4"Introduced by an acquaintance (sontham)" 5"Classmate" 6"Through an association" 77"Other"
label values snmoneylendermeet snmoneylendermeet

ta snmoneylendermeetfrequency
label define snmoneylendermeetfrequency 1"At least once a week" 2"At least once a month" 3"Every 2-3 months" 4"Every 4-6 months" 5"Once a year" 6"Less than once a year"
label values snmoneylendermeetfrequency snmoneylendermeetfrequency

ta snmoneylenderinvite
label values snmoneylenderinvite yesno

ta snmoneylenderreciprocity1
label values snmoneylenderreciprocity1 yesno

ta snmoneylenderintimacy
label define snmoneylenderintimacy 1"Not intimate" 2"Intimate" 3"Very intimate"
label values snmoneylenderintimacy snmoneylenderintimacy

ta otherlenderservices
split otherlenderservices, destring
recode otherlenderservices1 otherlenderservices2 otherlenderservices3 otherlenderservices4 otherlenderservices5 (77=6)
forvalues i=1/6 {
gen otherlenderservices_`i'=0 if otherlenderservices!=""
}
forvalues i=1/6 {
replace otherlenderservices_`i'=1 if otherlenderservices1==`i'
replace otherlenderservices_`i'=1 if otherlenderservices2==`i'
replace otherlenderservices_`i'=1 if otherlenderservices3==`i'
label values otherlenderservices_`i' dummyinterest
label var otherlenderservices_`i' "otherlenderservices=`i'"
}
rename otherlenderservices_1 otherlenderservices_poli
rename otherlenderservices_2 otherlenderservices_fina
rename otherlenderservices_3 otherlenderservices_guar
rename otherlenderservices_4 otherlenderservices_gene
rename otherlenderservices_5 otherlenderservices_none
rename otherlenderservices_6 otherlenderservices_othe
drop otherlenderservices1 otherlenderservices2 otherlenderservices3 otherlenderservices4 otherlenderservices5
order otherlenderservices_poli otherlenderservices_fina otherlenderservices_guar otherlenderservices_gene otherlenderservices_none otherlenderservices_othe, after(otherlenderservices)



ta guarantee
split guarantee, destring
recode guarantee1 guarantee2 guarantee3 guarantee4 (77=7)
forvalues i=1/7 {
gen guarantee_`i'=0 if guarantee!=""
}
forvalues i=1/7 {
replace guarantee_`i'=1 if guarantee1==`i'
replace guarantee_`i'=1 if guarantee1==`i'
replace guarantee_`i'=1 if guarantee3==`i'
label values guarantee_`i' dummyinterest
label var guarantee_`i' "guarantee=`i'"
}
rename guarantee_1 guarantee_docu
rename guarantee_2 guarantee_chit
rename guarantee_3 guarantee_shg
rename guarantee_4 guarantee_pers
rename guarantee_5 guarantee_jewe
rename guarantee_6 guarantee_none
rename guarantee_7 guarantee_other
drop guarantee1 guarantee2 guarantee3 guarantee4
order guarantee_docu guarantee_chit guarantee_shg guarantee_pers guarantee_jewe guarantee_none guarantee_other, after(guarantee)


label values loansettled yesno

label values covrepaymentstop yesno



gen dummymainloan=0
replace dummymainloan=1 if additionalloan!=.
ta dummymainloan
label values dummymainloan yesno
label var dummymainloan "Is the loan a main loan?"
order dummymainloan, before(lenderfirsttime)

ta borrowerservices
split borrowerservices, destring
forvalues i=1/4 {
gen borrowerservices_`i'=0 if borrowerservices!=""
}
forvalues i=1/4 {
replace borrowerservices_`i'=1 if borrowerservices1==`i'
replace borrowerservices_`i'=1 if borrowerservices2==`i'
replace borrowerservices_`i'=1 if borrowerservices3==`i'
label var borrowerservices_`i' "borrowerservices=`i'"
label values borrowerservices_`i' yesno
}
rename borrowerservices_1 borrowerservices_free
rename borrowerservices_2 borrowerservices_work
rename borrowerservices_3 borrowerservices_supp
rename borrowerservices_4 borrowerservices_none
drop borrowerservices1 borrowerservices2 borrowerservices3
order borrowerservices_free borrowerservices_work borrowerservices_supp borrowerservices_none, after(borrowerservices)

ta plantorepay
split plantorepay, destring
recode plantorepay1 plantorepay2 plantorepay3 plantorepay4 plantorepay5 (77=7)
forvalues i=1/7{
gen plantorepay_`i'=0 if plantorepay!=""
}
forvalues i=1/7 {
replace plantorepay_`i'=1 if plantorepay1==`i'
replace plantorepay_`i'=1 if plantorepay2==`i'
replace plantorepay_`i'=1 if plantorepay3==`i'
replace plantorepay_`i'=1 if plantorepay4==`i'
replace plantorepay_`i'=1 if plantorepay5==`i'
label values plantorepay_`i' dummyinterest
label var plantorepay_`i' "plantorepay=`i'
}
rename plantorepay_1 plantorepay_chit
rename plantorepay_2 plantorepay_work
rename plantorepay_3 plantorepay_migr
rename plantorepay_4 plantorepay_asse
rename plantorepay_5 plantorepay_inco
rename plantorepay_6 plantorepay_borr
rename plantorepay_7 plantorepay_othe
drop plantorepay1 plantorepay2 plantorepay3 plantorepay4 plantorepay5
order plantorepay_chit plantorepay_work plantorepay_migr plantorepay_asse plantorepay_inco plantorepay_borr plantorepay_othe, after(plantorepay)



ta problemdelayrepayment
split problemdelayrepayment, destring
recode problemdelayrepayment1 problemdelayrepayment2 problemdelayrepayment3 problemdelayrepayment4 (77=6)
forvalues i=1/6 {
gen problemdelayrepayment_`i'=0 if problemdelayrepayment!=""
}
forvalues i=1/6 {
replace problemdelayrepayment_`i'=1 if problemdelayrepayment1==`i'
replace problemdelayrepayment_`i'=1 if problemdelayrepayment2==`i'
replace problemdelayrepayment_`i'=1 if problemdelayrepayment3==`i'
replace problemdelayrepayment_`i'=1 if problemdelayrepayment4==`i'
label var problemdelayrepayment_`i' "problemdelayrepayment=`i'"
label values problemdelayrepayment_`i' yesno
}
rename problemdelayrepayment_1 problemdelayrepayment_noth
rename problemdelayrepayment_2 problemdelayrepayment_shou
rename problemdelayrepayment_3 problemdelayrepayment_pres
rename problemdelayrepayment_4 problemdelayrepayment_comp
rename problemdelayrepayment_5 problemdelayrepayment_info
rename problemdelayrepayment_6 problemdelayrepayment_othe
drop problemdelayrepayment1 problemdelayrepayment2 problemdelayrepayment3 problemdelayrepayment4
order problemdelayrepayment_noth problemdelayrepayment_shou problemdelayrepayment_pres problemdelayrepayment_comp problemdelayrepayment_info problemdelayrepayment_othe, after(problemdelayrepayment)




ta settleloanstrategy
split settleloanstrategy, destring
recode settleloanstrategy1 settleloanstrategy2 settleloanstrategy3 settleloanstrategy4 settleloanstrategy5 settleloanstrategy6 settleloanstrategy7 (77=11)
forvalues i=1/11 {
gen settleloanstrategy_`i'=0 if settleloanstrategy!=""
}
forvalues i=1/11 {
replace settleloanstrategy_`i'=1 if settleloanstrategy1==`i'
replace settleloanstrategy_`i'=1 if settleloanstrategy2==`i'
replace settleloanstrategy_`i'=1 if settleloanstrategy3==`i'
replace settleloanstrategy_`i'=1 if settleloanstrategy4==`i'
replace settleloanstrategy_`i'=1 if settleloanstrategy5==`i'
replace settleloanstrategy_`i'=1 if settleloanstrategy6==`i'
replace settleloanstrategy_`i'=1 if settleloanstrategy7==`i'
label values settleloanstrategy_`i' yesno
label var settleloanstrategy_`i' "settleloanstrategy=`i'"
}
rename settleloanstrategy_1 settleloanstrategy_labo
rename settleloanstrategy_2 settleloanstrategy_sche
rename settleloanstrategy_3 settleloanstrategy_borr
rename settleloanstrategy_4 settleloanstrategy_sell
rename settleloanstrategy_5 settleloanstrategy_land
rename settleloanstrategy_6 settleloanstrategy_cons
rename settleloanstrategy_7 settleloanstrategy_adjo
rename settleloanstrategy_8 settleloanstrategy_work
rename settleloanstrategy_9 settleloanstrategy_supp
rename settleloanstrategy_10 settleloanstrategy_harv
rename settleloanstrategy_11 settleloanstrategy_othe
drop settleloanstrategy1 settleloanstrategy2 settleloanstrategy3 settleloanstrategy4 settleloanstrategy5 settleloanstrategy6 settleloanstrategy7
order settleloanstrategy_labo settleloanstrategy_sche settleloanstrategy_borr settleloanstrategy_sell settleloanstrategy_land settleloanstrategy_cons settleloanstrategy_adjo settleloanstrategy_work settleloanstrategy_supp settleloanstrategy_harv settleloanstrategy_othe, after(settleloanstrategy)


ta loanproductpledge
split loanproductpledge, destring
forvalues i=1/16 {
gen loanproductpledge_`i'=0 if loanproductpledge!=""
}
forvalues i=1/16 {
replace loanproductpledge_`i'=1 if loanproductpledge1==`i'
replace loanproductpledge_`i'=1 if loanproductpledge2==`i'
label values loanproductpledge_`i' yesno
label var loanproductpledge_`i' "loanproductpledge=`i'"
}
rename loanproductpledge_1 loanproductpledge_gold
rename loanproductpledge_2 loanproductpledge_land
rename loanproductpledge_3 loanproductpledge_car
rename loanproductpledge_4 loanproductpledge_bike
rename loanproductpledge_5 loanproductpledge_frid
rename loanproductpledge_6 loanproductpledge_furn
rename loanproductpledge_7 loanproductpledge_tail
rename loanproductpledge_8 loanproductpledge_cell
rename loanproductpledge_9 loanproductpledge_line
rename loanproductpledge_10 loanproductpledge_dvd
rename loanproductpledge_11 loanproductpledge_came
rename loanproductpledge_12 loanproductpledge_gas
rename loanproductpledge_13 loanproductpledge_comp
rename loanproductpledge_14 loanproductpledge_dish
rename loanproductpledge_15 loanproductpledge_silv
rename loanproductpledge_16 loanproductpledge_none
drop loanproductpledge1 loanproductpledge2
order loanproductpledge_gold loanproductpledge_land loanproductpledge_car loanproductpledge_bike loanproductpledge_frid loanproductpledge_furn loanproductpledge_tail loanproductpledge_cell loanproductpledge_line loanproductpledge_dvd loanproductpledge_came loanproductpledge_gas loanproductpledge_comp loanproductpledge_dish loanproductpledge_silv loanproductpledge_none, after(loanproductpledge)


rename loanproductpledgeaamount loanproductpledgeamount


ta helptosettleloan
replace helptosettleloan="" if helptosettleloan=="."
split helptosettleloan, destring
forvalues i=1/14 {
gen helptosettleloan_`i'=0 if helptosettleloan!=""
}
forvalues i=1/14 {
replace helptosettleloan_`i'=1 if helptosettleloan1==`i'
replace helptosettleloan_`i'=1 if helptosettleloan2==`i'
replace helptosettleloan_`i'=1 if helptosettleloan3==`i'
replace helptosettleloan_`i'=1 if helptosettleloan4==`i'
replace helptosettleloan_`i'=1 if helptosettleloan5==`i'
replace helptosettleloan_`i'=1 if helptosettleloan6==`i'
replace helptosettleloan_`i'=1 if helptosettleloan7==`i'
label values helptosettleloan_`i' yesno
label var helptosettleloan_`i' "helptosettleloan=`i'"
}
rename helptosettleloan_1 helptosettleloan_mais
rename helptosettleloan_2 helptosettleloan_chil
rename helptosettleloan_3 helptosettleloan_sibl
rename helptosettleloan_4 helptosettleloan_pare
rename helptosettleloan_5 helptosettleloan_niec
rename helptosettleloan_6 helptosettleloan_othe
rename helptosettleloan_7 helptosettleloan_neig
rename helptosettleloan_8 helptosettleloan_frie
rename helptosettleloan_9 helptosettleloan_cust
rename helptosettleloan_10 helptosettleloan_mone
rename helptosettleloan_11 helptosettleloan_shg
rename helptosettleloan_12 helptosettleloan_empl
rename helptosettleloan_13 helptosettleloan_wkp
rename helptosettleloan_14 helptosettleloan_spou
drop helptosettleloan1 helptosettleloan2 helptosettleloan3 helptosettleloan4 helptosettleloan5 helptosettleloan6 helptosettleloan7
order helptosettleloan_mais helptosettleloan_chil helptosettleloan_sibl helptosettleloan_pare helptosettleloan_niec helptosettleloan_othe helptosettleloan_neig helptosettleloan_frie helptosettleloan_cust helptosettleloan_mone helptosettleloan_shg helptosettleloan_empl helptosettleloan_wkp helptosettleloan_spou, after(helptosettleloan)





ta recommendloanrelation
replace recommendloanrelation="" if recommendloanrelation=="."
split recommendloanrelation, destring
recode recommendloanrelation1 recommendloanrelation2 recommendloanrelation3 recommendloanrelation4 recommendloanrelation5 recommendloanrelation6 (66=12) (99=13)
forvalues i=1/13 {
gen recommendloanrelation_`i'=0 if recommendloanrelation!=""
}
forvalues i=1/13 {
replace recommendloanrelation_`i'=1 if recommendloanrelation1==`i'
replace recommendloanrelation_`i'=1 if recommendloanrelation2==`i'
replace recommendloanrelation_`i'=1 if recommendloanrelation3==`i'
replace recommendloanrelation_`i'=1 if recommendloanrelation4==`i'
replace recommendloanrelation_`i'=1 if recommendloanrelation5==`i'
replace recommendloanrelation_`i'=1 if recommendloanrelation6==`i'
label var recommendloanrelation_`i' "recommendloanrelation=`i'"
label values recommendloanrelation_`i' yesno
}
rename recommendloanrelation_1 recommendloanrelation_labo
rename recommendloanrelation_2 recommendloanrelation_rela
rename recommendloanrelation_3 recommendloanrelation_poli
rename recommendloanrelation_4 recommendloanrelation_reli
rename recommendloanrelation_5 recommendloanrelation_neig
rename recommendloanrelation_6 recommendloanrelation_shg
rename recommendloanrelation_7 recommendloanrelation_busi
rename recommendloanrelation_8 recommendloanrelation_wkp
rename recommendloanrelation_9 recommendloanrelation_trad
rename recommendloanrelation_10 recommendloanrelation_frie
rename recommendloanrelation_11 recommendloanrelation_gpfin
rename recommendloanrelation_12 recommendloanrelation_na
rename recommendloanrelation_13 recommendloanrelation_nr
drop recommendloanrelation1 recommendloanrelation2 recommendloanrelation3 recommendloanrelation4 recommendloanrelation5 recommendloanrelation6
order recommendloanrelation_labo recommendloanrelation_rela recommendloanrelation_poli recommendloanrelation_reli recommendloanrelation_neig recommendloanrelation_shg recommendloanrelation_busi recommendloanrelation_wkp recommendloanrelation_trad recommendloanrelation_frie recommendloanrelation_gpfin recommendloanrelation_na recommendloanrelation_nr, after(recommendloanrelation)



ta guarantorloanrelation
split guarantorloanrelation, destring
recode guarantorloanrelation1 guarantorloanrelation2 guarantorloanrelation3 guarantorloanrelation4 guarantorloanrelation5 guarantorloanrelation6 (66=12) (99=13)
forvalues i=1/13 {
gen guarantorloanrelation_`i'=0 if guarantorloanrelation!=""
}
forvalues i=1/13 {
replace guarantorloanrelation_`i'=1 if guarantorloanrelation1==`i'
replace guarantorloanrelation_`i'=1 if guarantorloanrelation2==`i'
label values guarantorloanrelation_`i' yesno
label var guarantorloanrelation_`i' "guarantorloanrelation=`i'"
}
rename guarantorloanrelation_1 guarantorloanrelation_labo
rename guarantorloanrelation_2 guarantorloanrelation_rela
rename guarantorloanrelation_3 guarantorloanrelation_poli
rename guarantorloanrelation_4 guarantorloanrelation_reli
rename guarantorloanrelation_5 guarantorloanrelation_neig
rename guarantorloanrelation_6 guarantorloanrelation_shg
rename guarantorloanrelation_7 guarantorloanrelation_busi
rename guarantorloanrelation_8 guarantorloanrelation_wkp
rename guarantorloanrelation_9 guarantorloanrelation_trad
rename guarantorloanrelation_10 guarantorloanrelation_frie
rename guarantorloanrelation_11 guarantorloanrelation_gpfin
rename guarantorloanrelation_12 guarantorloanrelation_na
rename guarantorloanrelation_13 guarantorloanrelation_nr
drop guarantorloanrelation1 guarantorloanrelation2 guarantorloanrelation3 guarantorloanrelation4 guarantorloanrelation5 guarantorloanrelation6
order guarantorloanrelation_labo guarantorloanrelation_rela guarantorloanrelation_poli guarantorloanrelation_reli guarantorloanrelation_neig guarantorloanrelation_shg guarantorloanrelation_busi guarantorloanrelation_wkp guarantorloanrelation_trad guarantorloanrelation_frie guarantorloanrelation_gpfin guarantorloanrelation_na guarantorloanrelation_nr, after(guarantorloanrelation)


save"Last/NEEMSIS2-loans_mainloans.dta", replace
****************************************
* END







