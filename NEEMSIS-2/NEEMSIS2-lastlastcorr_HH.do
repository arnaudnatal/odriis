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
global directory = "C:\Users\Arnaud\Documents\Dropbox (Personal)\2020-NEEMSIS2\Data\4team\Last"
cd"$directory"
********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid
********** Split var
do"C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2\splitvarmcq.do"
do"C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2\newn.do"
do"C:\Users\Arnaud\Documents\GitHub\odriis\NEEMSIS-2\repmi.do"
********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020
*-------------------------








****************************************
* NEEMSIS2-HH.dta
****************************************
use"NEEMSIS2-HH", clear



********** Migration
drop migrationjoblist_brick migrationjoblist_sugar migrationjoblist_const migrationjoblist_nagco migrationjoblist_agrco migrationjoblist_priva migrationjoblist_publi migrationjoblist_selfe migrationjoblist_follo

ta migrationjoblist
split migrationjoblist, destring

forvalues i=1/9 {
gen migrationjoblist_`i'=0 if migrationjoblist!=""
}
forvalues i=1/9 {
replace migrationjoblist_`i'=1 if migrationjoblist1==`i'
replace migrationjoblist_`i'=1 if migrationjoblist2==`i'
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

forvalues i=1/4 {
replace remreceivedsourceoccup`i'=77 if remreceivedsourceoccupother`i'!=""
}





********** Remittances sent

preserve
use"NEEMSIS2-HH", clear

keep HHID2020 INDID2020 dummyremsent dummyremsenderlist remsentname1 remsentnametwo1 remsentdummyvillage1 remsentrelation1 remsentoccup1 remsentplace1 remsentmoney1 remsentgift1 remsentservices1 remsentservices_poli1 remsentservices_fina1 remsentservices_guar1 remsentservices_gene1 remsentservices_none1 remsentservices_othe1 remsentsourceoccupother1 remsentservicesother1 remsentfrequency1 remsentamount1 remsenttotalamount1 remsentmean1 remsentmean_cash1 remsentmean_mobi1 remsentmean_bank1 remsentmean_othe1 remsentgiftnb1 remsentgiftamount1 covremsent1 remsentname2 remsentnametwo2 remsentdummyvillage2 remsentrelation2 remsentoccup2 remsentplace2 remsentmoney2 remsentgift2 remsentservices2 remsentservices_poli2 remsentservices_fina2 remsentservices_guar2 remsentservices_gene2 remsentservices_none2 remsentservices_othe2 remsentsourceoccupother2 remsentservicesother2 remsentfrequency2 remsentamount2 remsenttotalamount2 remsentmean2 remsentmean_cash2 remsentmean_mobi2 remsentmean_bank2 remsentmean_othe2 remsentgiftnb2 remsentgiftamount2 covremsent2 remsentname3 remsentnametwo3 remsentdummyvillage3 remsentrelation3 remsentoccup3 remsentplace3 remsentmoney3 remsentgift3 remsentservices3 remsentservices_poli3 remsentservices_fina3 remsentservices_guar3 remsentservices_gene3 remsentservices_none3 remsentservices_othe3 remsentsourceoccupother3 remsentservicesother3 remsentfrequency3 remsentamount3 remsenttotalamount3 remsentmean3 remsentmean_cash3 remsentmean_mobi3 remsentmean_bank3 remsentmean_othe3 remsentgiftnb3 remsentgiftamount3 covremsent3 remsentname4 remsentnametwo4 remsentdummyvillage4 remsentrelation4 remsentoccup4 remsentplace4 remsentmoney4 remsentgift4 remsentservices4 remsentservices_poli4 remsentservices_fina4 remsentservices_guar4 remsentservices_gene4 remsentservices_none4 remsentservices_othe4 remsentsourceoccupother4 remsentservicesother4 remsentfrequency4 remsentamount4 remsenttotalamount4 remsentmean4 remsentmean_cash4 remsentmean_mobi4 remsentmean_bank4 remsentmean_othe4 remsentgiftnb4 remsentgiftamount4 covremsent4 remsentname5 remsentnametwo5 remsentdummyvillage5 remsentrelation5 remsentoccup5 remsentplace5 remsentmoney5 remsentgift5 remsentservices5 remsentservices_poli5 remsentservices_fina5 remsentservices_guar5 remsentservices_gene5 remsentservices_none5 remsentservices_othe5 remsentsourceoccupother5 remsentservicesother5 remsentfrequency5 remsentamount5 remsenttotalamount5 remsentmean5 remsentmean_cash5 remsentmean_mobi5 remsentmean_bank5 remsentmean_othe5 remsentgiftnb5 remsentgiftamount5 covremsent5
reshape long remsentname remsentnametwo remsentdummyvillage remsentrelation remsentoccup remsentplace remsentmoney remsentgift remsentservices remsentservices_poli remsentservices_fina remsentservices_guar remsentservices_gene remsentservices_none remsentservices_othe remsentsourceoccupother remsentservicesother remsentfrequency remsentamount remsenttotalamount remsentmean remsentmean_cash remsentmean_mobi remsentmean_bank remsentmean_othe remsentgiftnb remsentgiftamount covremsent, i(HHID2020 INDID2020) j(n)
drop if remsentname==.

ta remsentservices
drop remsentservices_poli remsentservices_fina remsentservices_guar remsentservices_gene remsentservices_none remsentservices_othe
split remsentservices, destring
recode remsentservices1 remsentservices2 remsentservices3 (77=6)
forvalues i=1/6 {
gen remsentservices_`i'=0 if remsentservices!=""
}
forvalues i=1/6 {
replace remsentservices_`i'=1 if remsentservices1==`i'
replace remsentservices_`i'=1 if remsentservices2==`i'
replace remsentservices_`i'=1 if remsentservices3==`i'
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

reshape wide remsentname remsentnametwo remsentdummyvillage remsentrelation remsentoccup remsentplace remsentmoney remsentgift remsentservices remsentservices_poli remsentservices_fina remsentservices_guar remsentservices_gene remsentservices_none remsentservices_othe remsentsourceoccupother remsentservicesother remsentfrequency remsentamount remsenttotalamount remsentmean remsentmean_cash remsentmean_mobi remsentmean_bank remsentmean_othe remsentgiftnb remsentgiftamount covremsent, i(HHID2020 INDID2020) j(n)
save "_tempremsent.dta", replace
restore

drop remsentname1 remsentnametwo1 remsentdummyvillage1 remsentrelation1 remsentoccup1 remsentplace1 remsentmoney1 remsentgift1 remsentservices1 remsentservices_poli1 remsentservices_fina1 remsentservices_guar1 remsentservices_gene1 remsentservices_none1 remsentservices_othe1 remsentsourceoccupother1 remsentservicesother1 remsentfrequency1 remsentamount1 remsenttotalamount1 remsentmean1 remsentmean_cash1 remsentmean_mobi1 remsentmean_bank1 remsentmean_othe1 remsentgiftnb1 remsentgiftamount1 covremsent1 remsentname2 remsentnametwo2 remsentdummyvillage2 remsentrelation2 remsentoccup2 remsentplace2 remsentmoney2 remsentgift2 remsentservices2 remsentservices_poli2 remsentservices_fina2 remsentservices_guar2 remsentservices_gene2 remsentservices_none2 remsentservices_othe2 remsentsourceoccupother2 remsentservicesother2 remsentfrequency2 remsentamount2 remsenttotalamount2 remsentmean2 remsentmean_cash2 remsentmean_mobi2 remsentmean_bank2 remsentmean_othe2 remsentgiftnb2 remsentgiftamount2 covremsent2 remsentname3 remsentnametwo3 remsentdummyvillage3 remsentrelation3 remsentoccup3 remsentplace3 remsentmoney3 remsentgift3 remsentservices3 remsentservices_poli3 remsentservices_fina3 remsentservices_guar3 remsentservices_gene3 remsentservices_none3 remsentservices_othe3 remsentsourceoccupother3 remsentservicesother3 remsentfrequency3 remsentamount3 remsenttotalamount3 remsentmean3 remsentmean_cash3 remsentmean_mobi3 remsentmean_bank3 remsentmean_othe3 remsentgiftnb3 remsentgiftamount3 covremsent3 remsentname4 remsentnametwo4 remsentdummyvillage4 remsentrelation4 remsentoccup4 remsentplace4 remsentmoney4 remsentgift4 remsentservices4 remsentservices_poli4 remsentservices_fina4 remsentservices_guar4 remsentservices_gene4 remsentservices_none4 remsentservices_othe4 remsentsourceoccupother4 remsentservicesother4 remsentfrequency4 remsentamount4 remsenttotalamount4 remsentmean4 remsentmean_cash4 remsentmean_mobi4 remsentmean_bank4 remsentmean_othe4 remsentgiftnb4 remsentgiftamount4 covremsent4 remsentname5 remsentnametwo5 remsentdummyvillage5 remsentrelation5 remsentoccup5 remsentplace5 remsentmoney5 remsentgift5 remsentservices5 remsentservices_poli5 remsentservices_fina5 remsentservices_guar5 remsentservices_gene5 remsentservices_none5 remsentservices_othe5 remsentsourceoccupother5 remsentservicesother5 remsentfrequency5 remsentamount5 remsenttotalamount5 remsentmean5 remsentmean_cash5 remsentmean_mobi5 remsentmean_bank5 remsentmean_othe5 remsentgiftnb5 remsentgiftamount5 covremsent5

merge 1:1 HHID2020 INDID2020 using "_tempremsent"
drop _merge
order remsentname1 remsentnametwo1 remsentdummyvillage1 remsentrelation1 remsentoccup1 remsentplace1 remsentmoney1 remsentgift1 remsentservices1 remsentservices_poli1 remsentservices_fina1 remsentservices_guar1 remsentservices_gene1 remsentservices_none1 remsentservices_othe1 remsentsourceoccupother1 remsentservicesother1 remsentfrequency1 remsentamount1 remsenttotalamount1 remsentmean1 remsentmean_cash1 remsentmean_mobi1 remsentmean_bank1 remsentmean_othe1 remsentgiftnb1 remsentgiftamount1 covremsent1 remsentname2 remsentnametwo2 remsentdummyvillage2 remsentrelation2 remsentoccup2 remsentplace2 remsentmoney2 remsentgift2 remsentservices2 remsentservices_poli2 remsentservices_fina2 remsentservices_guar2 remsentservices_gene2 remsentservices_none2 remsentservices_othe2 remsentsourceoccupother2 remsentservicesother2 remsentfrequency2 remsentamount2 remsenttotalamount2 remsentmean2 remsentmean_cash2 remsentmean_mobi2 remsentmean_bank2 remsentmean_othe2 remsentgiftnb2 remsentgiftamount2 covremsent2 remsentname3 remsentnametwo3 remsentdummyvillage3 remsentrelation3 remsentoccup3 remsentplace3 remsentmoney3 remsentgift3 remsentservices3 remsentservices_poli3 remsentservices_fina3 remsentservices_guar3 remsentservices_gene3 remsentservices_none3 remsentservices_othe3 remsentsourceoccupother3 remsentservicesother3 remsentfrequency3 remsentamount3 remsenttotalamount3 remsentmean3 remsentmean_cash3 remsentmean_mobi3 remsentmean_bank3 remsentmean_othe3 remsentgiftnb3 remsentgiftamount3 covremsent3 remsentname4 remsentnametwo4 remsentdummyvillage4 remsentrelation4 remsentoccup4 remsentplace4 remsentmoney4 remsentgift4 remsentservices4 remsentservices_poli4 remsentservices_fina4 remsentservices_guar4 remsentservices_gene4 remsentservices_none4 remsentservices_othe4 remsentsourceoccupother4 remsentservicesother4 remsentfrequency4 remsentamount4 remsenttotalamount4 remsentmean4 remsentmean_cash4 remsentmean_mobi4 remsentmean_bank4 remsentmean_othe4 remsentgiftnb4 remsentgiftamount4 covremsent4 remsentname5 remsentnametwo5 remsentdummyvillage5 remsentrelation5 remsentoccup5 remsentplace5 remsentmoney5 remsentgift5 remsentservices5 remsentservices_poli5 remsentservices_fina5 remsentservices_guar5 remsentservices_gene5 remsentservices_none5 remsentservices_othe5 remsentsourceoccupother5 remsentservicesother5 remsentfrequency5 remsentamount5 remsenttotalamount5 remsentmean5 remsentmean_cash5 remsentmean_mobi5 remsentmean_bank5 remsentmean_othe5 remsentgiftnb5 remsentgiftamount5 covremsent5, after(dummyremsenderlist)


********** Lending
ta relationwithborrower

split relationwithborrower, destring
forvalues i=1/14 {
gen relationwithborrower_`i'=0 if relationwithborrower!=""
}
forvalues i=1/14 {
replace relationwithborrower_`i'=1 if relationwithborrower1==`i'
replace relationwithborrower_`i'=1 if relationwithborrower2==`i'
replace relationwithborrower_`i'=1 if relationwithborrower3==`i'
label var relationwithborrower_`i' "relationwithborrower=`i'"
label values relationwithborrower_`i' yesno
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

rename amoutlent amountlent
replace interestlending=. if interestlending==66
replace interestlending=9 if interestlending==900



********** Chit fund
fre covchitfundstop1 covchitfundstop2 covchitfundstop3
destring covchitfundstop1 covchitfundstop2 covchitfundstop3, replace
label values covchitfundstop1 yesno
label values covchitfundstop2 yesno
label values covchitfundstop3 yesno

fre covchitfundreturn1 covchitfundreturn2
gen covchitfundreturn3=.
order covchitfundreturn3, after(covchitfundreturn2)
destring covchitfundreturn1 covchitfundreturn2, replace
label define covchitfundreturn 1"Yes, temporarly stopped" 2"No, completely stopped" 3"Still uncertain"
label values covchitfundreturn1 covchitfundreturn
label values covchitfundreturn2 covchitfundreturn
label values covchitfundreturn3 covchitfundreturn




********** Savings
preserve
keep HHID2020 INDID2020 savingsaccounttype1 savingsjointaccount1 banktype1 savingsbankname1 savingsbankplace1 savingsamount1 savingspurpose1 covsavinguse1 dummydebitcard1 dummycreditcard1 covsavinguseamount1 usedebitcard1 reasonnotusedebitcard1 usecreditcard1 savingsaccountdate1 datedebitcard1 datecreditcard1 savingsaccounttype2 savingsjointaccount2 banktype2 savingsbankname2 savingsbankplace2 savingsamount2 savingspurpose2 covsavinguse2 dummydebitcard2 dummycreditcard2 covsavinguseamount2 usedebitcard2 savingsaccountdate2 datedebitcard2 savingsaccounttype3 banktype3 savingsbankname3 savingsbankplace3 savingsamount3 savingspurpose3 covsavinguse3 dummydebitcard3 dummycreditcard3 covsavinguseamount3 usedebitcard3 savingsaccountdate3 datedebitcard3 savingsaccounttype4 banktype4 savingsbankname4 savingsbankplace4 savingsamount4 savingspurpose4 covsavinguse4 dummydebitcard4 dummycreditcard4 usedebitcard4 savingsaccountdate4 datedebitcard4
reshape long savingsaccounttype savingsjointaccount banktype savingsbankname savingsbankplace savingsamount savingspurpose covsavinguse dummydebitcard dummycreditcard covsavinguseamount usedebitcard reasonnotusedebitcard usecreditcard savingsaccountdate datedebitcard datecreditcard, i(HHID2020 INDID2020) j(n)
keep if savingsaccounttype!=.

split savingspurpose, destring
forvalues i=1/6 {
gen savingspurpose_`i'=0 if savingspurpose!=""
}
forvalues i=1/6 {
replace savingspurpose_`i'=1 if savingspurpose1==`i'
replace savingspurpose_`i'=1 if savingspurpose2==`i'
replace savingspurpose_`i'=1 if savingspurpose3==`i'
replace savingspurpose_`i'=1 if savingspurpose4==`i'
replace savingspurpose_`i'=1 if savingspurpose5==`i'
label var savingspurpose_`i' "savingspurpose=`i'"
label values savingspurpose_`i' yesno
}
rename savingspurpose_1 savingspurpose_savi
rename savingspurpose_2 savingspurpose_jewe
rename savingspurpose_3 savingspurpose_cred
rename savingspurpose_4 savingspurpose_crop
rename savingspurpose_5 savingspurpose_suga
rename savingspurpose_6 savingspurpose_sche
drop savingspurpose1 savingspurpose2 savingspurpose3 savingspurpose4 savingspurpose5
order savingspurpose_savi savingspurpose_jewe savingspurpose_cred savingspurpose_crop savingspurpose_suga savingspurpose_sche, after(savingspurpose)

split usedebitcard, destring
foreach i in 1 2 3 4 5 6 77 {
gen usedebitcard_`i'=0 if usedebitcard!=""
}
foreach i in 1 2 3 4 5 6 77 {
replace usedebitcard_`i'=1 if usedebitcard1==`i'
replace usedebitcard_`i'=1 if usedebitcard2==`i'
replace usedebitcard_`i'=1 if usedebitcard3==`i'
replace usedebitcard_`i'=1 if usedebitcard4==`i'
replace usedebitcard_`i'=1 if usedebitcard5==`i'
label var usedebitcard_`i' "usedebitcard=`i'"
label values usedebitcard_`i' yesno
}
rename usedebitcard_1 usedebitcard_neve
rename usedebitcard_2 usedebitcard_cash
rename usedebitcard_3 usedebitcard_shop
rename usedebitcard_4 usedebitcard_tran
rename usedebitcard_5 usedebitcard_onli
rename usedebitcard_6 usedebitcard_mobi
rename usedebitcard_77 usedebitcard_othe
drop usedebitcard1 usedebitcard2 usedebitcard3 usedebitcard4 usedebitcard5
order usedebitcard_neve usedebitcard_cash usedebitcard_shop usedebitcard_tran usedebitcard_onli usedebitcard_mobi usedebitcard_othe, after(usedebitcard)


split usecreditcard, destring
foreach i in 1 2 3 4 5 6 77 {
gen usecreditcard_`i'=0 if usecreditcard!=""
}
foreach i in 1 2 3 4 5 6 77 {
replace usecreditcard_`i'=1 if usecreditcard1==`i'
replace usecreditcard_`i'=1 if usecreditcard2==`i'
label var usecreditcard_`i' "usecreditcard=`i'"
label values usecreditcard_`i' yesno
}
rename usecreditcard_1 usecreditcard_neve
rename usecreditcard_2 usecreditcard_cash
rename usecreditcard_3 usecreditcard_shop
rename usecreditcard_4 usecreditcard_tran
rename usecreditcard_5 usecreditcard_onli
rename usecreditcard_6 usecreditcard_mobi
rename usecreditcard_77 usecreditcard_othe
drop usecreditcard1 usecreditcard2
order usecreditcard_neve usecreditcard_cash usecreditcard_shop usecreditcard_tran usecreditcard_onli usecreditcard_mobi usecreditcard_othe, after(usecreditcard)

fre reasonnotusedebitcard
label define reasonnotusedebitcard 1"No need" 2"Distrust money transaction by card" 3"Prefer cash transactions" 4"Less flexibility of transactions" 5"Difficult access to ATM/banking infrastructures" 6"Afraid to use it/Don't know how to use it" 77"Other
label values reasonnotusedebitcard reasonnotusedebitcard

destring covsavinguse, replace
label values covsavinguse yesno


reshape wide savingsaccounttype banktype savingsbankname savingsbankplace savingsamount savingspurpose savingspurpose_savi savingspurpose_jewe savingspurpose_cred savingspurpose_crop savingspurpose_suga savingspurpose_sche covsavinguse dummydebitcard dummycreditcard usedebitcard usedebitcard_neve usedebitcard_cash usedebitcard_shop usedebitcard_tran usedebitcard_onli usedebitcard_mobi usedebitcard_othe savingsaccountdate datedebitcard savingsjointaccount covsavinguseamount reasonnotusedebitcard usecreditcard usecreditcard_neve usecreditcard_cash usecreditcard_shop usecreditcard_tran usecreditcard_onli usecreditcard_mobi usecreditcard_othe datecreditcard, i(HHID2020 INDID2020) j(n)
save "_tempsaving.dta", replace
restore

drop savingsaccounttype1 savingsjointaccount1 banktype1 savingsbankname1 savingsbankplace1 savingsamount1 savingspurpose1 covsavinguse1 dummydebitcard1 dummycreditcard1 covsavinguseamount1 usedebitcard1 reasonnotusedebitcard1 usecreditcard1 savingsaccountdate1 datedebitcard1 datecreditcard1 savingsaccounttype2 savingsjointaccount2 banktype2 savingsbankname2 savingsbankplace2 savingsamount2 savingspurpose2 covsavinguse2 dummydebitcard2 dummycreditcard2 covsavinguseamount2 usedebitcard2 savingsaccountdate2 datedebitcard2 savingsaccounttype3 banktype3 savingsbankname3 savingsbankplace3 savingsamount3 savingspurpose3 covsavinguse3 dummydebitcard3 dummycreditcard3 covsavinguseamount3 usedebitcard3 savingsaccountdate3 datedebitcard3 savingsaccounttype4 banktype4 savingsbankname4 savingsbankplace4 savingsamount4 savingspurpose4 covsavinguse4 dummydebitcard4 dummycreditcard4 usedebitcard4 savingsaccountdate4 datedebitcard4

merge 1:1 HHID2020 INDID2020 using "_tempsaving.dta"
drop _merge
order savingsaccounttype1 banktype1 savingsbankname1 savingsbankplace1 savingsamount1 savingspurpose1 savingspurpose_savi1 savingspurpose_jewe1 savingspurpose_cred1 savingspurpose_crop1 savingspurpose_suga1 savingspurpose_sche1 covsavinguse1 dummydebitcard1 dummycreditcard1 usedebitcard1 usedebitcard_neve1 usedebitcard_cash1 usedebitcard_shop1 usedebitcard_tran1 usedebitcard_onli1 usedebitcard_mobi1 usedebitcard_othe1 savingsaccountdate1 datedebitcard1 savingsjointaccount1 covsavinguseamount1 reasonnotusedebitcard1 usecreditcard1 usecreditcard_neve1 usecreditcard_cash1 usecreditcard_shop1 usecreditcard_tran1 usecreditcard_onli1 usecreditcard_mobi1 usecreditcard_othe1 datecreditcard1 savingsaccounttype2 banktype2 savingsbankname2 savingsbankplace2 savingsamount2 savingspurpose2 savingspurpose_savi2 savingspurpose_jewe2 savingspurpose_cred2 savingspurpose_crop2 savingspurpose_suga2 savingspurpose_sche2 covsavinguse2 dummydebitcard2 dummycreditcard2 usedebitcard2 usedebitcard_neve2 usedebitcard_cash2 usedebitcard_shop2 usedebitcard_tran2 usedebitcard_onli2 usedebitcard_mobi2 usedebitcard_othe2 savingsaccountdate2 datedebitcard2 savingsjointaccount2 covsavinguseamount2 reasonnotusedebitcard2 usecreditcard2 usecreditcard_neve2 usecreditcard_cash2 usecreditcard_shop2 usecreditcard_tran2 usecreditcard_onli2 usecreditcard_mobi2 usecreditcard_othe2 datecreditcard2 savingsaccounttype3 banktype3 savingsbankname3 savingsbankplace3 savingsamount3 savingspurpose3 savingspurpose_savi3 savingspurpose_jewe3 savingspurpose_cred3 savingspurpose_crop3 savingspurpose_suga3 savingspurpose_sche3 covsavinguse3 dummydebitcard3 dummycreditcard3 usedebitcard3 usedebitcard_neve3 usedebitcard_cash3 usedebitcard_shop3 usedebitcard_tran3 usedebitcard_onli3 usedebitcard_mobi3 usedebitcard_othe3 savingsaccountdate3 datedebitcard3 savingsjointaccount3 covsavinguseamount3 reasonnotusedebitcard3 usecreditcard3 usecreditcard_neve3 usecreditcard_cash3 usecreditcard_shop3 usecreditcard_tran3 usecreditcard_onli3 usecreditcard_mobi3 usecreditcard_othe3 datecreditcard3 savingsaccounttype4 banktype4 savingsbankname4 savingsbankplace4 savingsamount4 savingspurpose4 savingspurpose_savi4 savingspurpose_jewe4 savingspurpose_cred4 savingspurpose_crop4 savingspurpose_suga4 savingspurpose_sche4 covsavinguse4 dummydebitcard4 dummycreditcard4 usedebitcard4 usedebitcard_neve4 usedebitcard_cash4 usedebitcard_shop4 usedebitcard_tran4 usedebitcard_onli4 usedebitcard_mobi4 usedebitcard_othe4 savingsaccountdate4 datedebitcard4 savingsjointaccount4 covsavinguseamount4 reasonnotusedebitcard4 usecreditcard4 usecreditcard_neve4 usecreditcard_cash4 usecreditcard_shop4 usecreditcard_tran4 usecreditcard_onli4 usecreditcard_mobi4 usecreditcard_othe4 datecreditcard4, after(nbsavingaccounts)



********** Gold
fre dummygold
gen dummygoldindiv=0 if dummygold==1
replace dummygoldindiv=1 if goldquantity!=.
ta dummygoldindiv sex


split goldreasonpledge, destring
foreach i in 1 2 3 4 5 6 7 8 9 10 11 12 77 {
gen goldreasonpledge_`i'=0 if goldreasonpledge!=""
}
foreach i in 1 2 3 4 5 6 7 8 9 10 11 12 77 {
replace goldreasonpledge_`i'=1 if goldreasonpledge1==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge2==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge3==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge4==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge5==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge6==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge7==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge8==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge9==`i'
replace goldreasonpledge_`i'=1 if goldreasonpledge10==`i'
label var goldreasonpledge_`i' "goldreasonpledge=`i'"
label values goldreasonpledge_`i' yesno
}
rename goldreasonpledge_1 goldreasonpledge_agri
rename goldreasonpledge_2 goldreasonpledge_fami
rename goldreasonpledge_3 goldreasonpledge_heal
rename goldreasonpledge_4 goldreasonpledge_repa
rename goldreasonpledge_5 goldreasonpledge_hous
rename goldreasonpledge_6 goldreasonpledge_inve
rename goldreasonpledge_7 goldreasonpledge_cere
rename goldreasonpledge_8 goldreasonpledge_marr
rename goldreasonpledge_9 goldreasonpledge_educ
rename goldreasonpledge_10 goldreasonpledge_rela
rename goldreasonpledge_11 goldreasonpledge_deat
rename goldreasonpledge_12 goldreasonpledge_nore
rename goldreasonpledge_77 goldreasonpledge_othe
drop goldreasonpledge1 goldreasonpledge2 goldreasonpledge3 goldreasonpledge4 goldreasonpledge5 goldreasonpledge6 goldreasonpledge7 goldreasonpledge8 goldreasonpledge9 goldreasonpledge10
order goldreasonpledge_agri goldreasonpledge_fami goldreasonpledge_heal goldreasonpledge_repa goldreasonpledge_hous goldreasonpledge_inve goldreasonpledge_cere goldreasonpledge_marr goldreasonpledge_educ goldreasonpledge_rela goldreasonpledge_deat goldreasonpledge_nore goldreasonpledge_othe, after(goldreasonpledge)

order goldreasonpledgemain, before(goldreasonpledge)



********** Insurance
split reasonnoinsurance, destring 
foreach i in 1 2 3 77 {
gen reasonnoinsurance_`i'=0 if reasonnoinsurance!=""
}
foreach i in 1 2 3 77 {
replace reasonnoinsurance_`i'=1 if reasonnoinsurance1==`i'
replace reasonnoinsurance_`i'=1 if reasonnoinsurance2==`i'
label var reasonnoinsurance_`i' "reasonnoinsurance=`i'"
label values reasonnoinsurance_`i' yesno
}
rename reasonnoinsurance_1 reasonnoinsurance_noin
rename reasonnoinsurance_2 reasonnoinsurance_mone
rename reasonnoinsurance_3 reasonnoinsurance_dkno
rename reasonnoinsurance_77 reasonnoinsurance_othe
drop reasonnoinsurance1 reasonnoinsurance2
order reasonnoinsurance_noin reasonnoinsurance_mone reasonnoinsurance_dkno reasonnoinsurance_othe, after(reasonnoinsurance)


********** Mobile finance
split usemobilefinancetype, destring
foreach i in 1 2 3 4 77 {
gen usemobilefinancetype_`i'=0 if usemobilefinancetype!=""
}
foreach i in 1 2 3 4 77 {
replace usemobilefinancetype_`i'=1 if usemobilefinancetype1==`i'
replace usemobilefinancetype_`i'=1 if usemobilefinancetype2==`i'
replace usemobilefinancetype_`i'=1 if usemobilefinancetype3==`i'
replace usemobilefinancetype_`i'=1 if usemobilefinancetype4==`i'
label var usemobilefinancetype_`i' "usemobilefinancetype=`i'"
label values usemobilefinancetype_`i' yesno
}
rename usemobilefinancetype_1 usemobilefinancetype_bill
rename usemobilefinancetype_2 usemobilefinancetype_tran
rename usemobilefinancetype_3 usemobilefinancetype_debt
rename usemobilefinancetype_4 usemobilefinancetype_save
rename usemobilefinancetype_77 usemobilefinancetype_othe
drop usemobilefinancetype1 usemobilefinancetype2 usemobilefinancetype3 usemobilefinancetype4
order usemobilefinancetype_bill usemobilefinancetype_tran usemobilefinancetype_debt usemobilefinancetype_save usemobilefinancetype_othe, after(usemobilefinancetype)

destring usemobilefinance, replace
label values usemobilefinance yesno

foreach x in usemobilefinancetype_bill usemobilefinancetype_tran usemobilefinancetype_debt usemobilefinancetype_save usemobilefinancetype_othe {
replace `x'=. if usemobilefinance==0
}


********** Land
*
fre dummyeverland2010
destring dummyeverland2010, replace
label values dummyeverland2010 yesno

*
fre dummyeverhadland
destring dummyeverhadland, replace
label values dummyeverhadland yesno

*
fre covsellland
destring covsellland, replace
label define covsellland 1"Yes" 2"No" 66"N/A", replace
label values covsellland covsellland

*
fre reasonnoland
split reasonnoland, destring
foreach i in 1 2 3 4 77 {
gen reasonnoland_`i'=0 if reasonnoland!=""
}
foreach i in 1 2 3 4 77 {
replace reasonnoland_`i'=1 if reasonnoland1==`i'
replace reasonnoland_`i'=1 if reasonnoland2==`i'
label var reasonnoland_`i' "reasonnoland=`i'"
label values reasonnoland_`i' yesno
}
rename reasonnoland_1 reasonnoland_docu
rename reasonnoland_2 reasonnoland_debt
rename reasonnoland_3 reasonnoland_sell
rename reasonnoland_4 reasonnoland_gove
rename reasonnoland_77 reasonnoland_othe
drop reasonnoland1 reasonnoland2
order reasonnoland_docu reasonnoland_debt reasonnoland_sell reasonnoland_gove reasonnoland_othe, after(reasonnoland)

*
fre ownland
destring ownland, replace
label values ownland yesno

*
fre drywetownland
split drywetownland, destring
forvalues i=1/2 {
gen drywetownland_`i'=0 if drywetownland!=""
}
forvalues i=1/2 {
replace drywetownland_`i'=1 if drywetownland1==`i'
replace drywetownland_`i'=1 if drywetownland2==`i'
label var drywetownland_`i' "drywetownland=`i'"
label values drywetownland_`i' yesno
}
rename drywetownland_1 drywetownland_dry
rename drywetownland_2 drywetownland_wet
drop drywetownland1 drywetownland2
order drywetownland_dry drywetownland_wet, after(drywetownland)

*
fre waterfromownland
splitvarmcq waterfromownland 5
newn waterfromownland 1 tank 
newn waterfromownland 2 rive 
newn waterfromownland 3 bore 
newn waterfromownland 4 open 
newn waterfromownland 5 rain 

*
fre leaseland
destring leaseland, replace
label values leaseland yesno

*
fre drywetleaseland
splitvarmcq drywetleaseland 2
newn drywetleaseland 1 dry
newn drywetleaseland 2 wet

*
fre waterfromleaseland
splitvarmcq waterfromleaseland 5
newn waterfromleaseland 1 tank
newn waterfromleaseland 2 rive
newn waterfromleaseland 3 bore
newn waterfromleaseland 4 open
newn waterfromleaseland 5 rain

*
fre landpurchased
destring landpurchased, replace
label values landpurchased yesno

*
fre landpurchasedhowbuy
splitvarmcq landpurchasedhowbuy 7
newn landpurchasedhowbuy 1 here
newn landpurchasedhowbuy 2 savi
newn landpurchasedhowbuy 3 bank
newn landpurchasedhowbuy 4 cred
newn landpurchasedhowbuy 5 fina
newn landpurchasedhowbuy 6 help
newn landpurchasedhowbuy 7 sche

*
fre landlost
destring landlost, replace
label values landlost yesno

*
fre dummyleasedland
destring dummyleasedland, replace
label values dummyleasedland yesno

*
fre landleaserrelation
splitvarmcq landleaserrelation 11
newn landleaserrelation 1 labo
newn landleaserrelation 2 rela
newn landleaserrelation 3 poli
newn landleaserrelation 4 reli
newn landleaserrelation 5 neig
newn landleaserrelation 6 shg
newn landleaserrelation 7 busi
newn landleaserrelation 8 wkp
newn landleaserrelation 9 trad
newn landleaserrelation 10 frie
newn landleaserrelation 11 grou

*
fre landleasercaste
destring landleasercaste, replace
label define landleasercaste 1"Vanniyar" 2"SC" 3"Arunthathiyar" 4"Rediyar" 5"Gramani" 6"Naidu" 7"Navithar" 8"Asarai" 9"Settu" 10"Nattar" 11"Mudaliar" 12"Kulalar" 13"Chettiyar" 14"Marwari" 15"Muslims" 16"Padayachi"
label values landleasercaste landleasercaste

*
fre dummyleasingland
destring dummyleasingland, replace
label values dummyleasingland yesno

*
fre landleasingrelation
destring landleasingrelation, replace
label define landleasingrelation 1"Labour" 2"Relative" 3"Political" 4"Religious" 5"Neighbor" 6"SHG" 7"Business man" 8"WKP" 9"Traditional" 10"Friend" 11"Group finance"
label values landleasingrelation landleasingrelation

*
fre landleasingcaste
destring landleasingcaste, replace
label values landleasingcaste landleasercaste

*
fre productlist
splitvarmcq productlist 15
newn productlist 1 padd
newn productlist 2 cott
newn productlist 3 suga
newn productlist 4 savu
newn productlist 5 guav
newn productlist 6 mang
newn productlist 7 sapo
newn productlist 8 bana
newn productlist 9 grou
newn productlist 10 ragi
newn productlist 11 mill
newn productlist 12 cash
newn productlist 13 coco
newn productlist 14 othe
newn productlist 15 none

*
foreach x in paddy cotton sugarcane savukku guava groundnut millets cashew other {
fre productypeland_`x'
replace productypeland_`x'="3" if productypeland_`x'=="1 2"
destring productypeland_`x', replace
label define typeland 1"Own land" 2"Leased land" 3"Both", replace
label values productypeland_`x' typeland
}

*
foreach x in paddy cotton sugarcane savukku guava groundnut millets cashew other {
fre productpaidworkers_`x'
destring productpaidworkers_`x', replace
label values productpaidworkers_`x' yesno
}

*
foreach x in paddy cotton sugarcane savukku guava groundnut millets cashew other {
fre productunpaidworkers_`x'
destring productunpaidworkers_`x', replace
label values productunpaidworkers_`x' yesno
}

*
foreach x in paddy cotton sugarcane savukku guava groundnut millets cashew other {
fre productoriginlabourers_`x'
replace productoriginlabourers_`x'="3" if  productoriginlabourers_`x'=="1 2"
destring productoriginlabourers_`x', replace
label define originlabourers 1"Inside the village" 2"Outside the village" 3"Both", replace
label values productoriginlabourers_`x' originlabourers
}

*
foreach x in paddy cotton sugarcane savukku guava groundnut millets cashew other {
fre productcastelabourers_`x'
rename productcastelabourers_`x' prodcastelab_`x'
splitvarmcq prodcastelab_`x' 16
newn prodcastelab_`x' 1 vann
newn prodcastelab_`x' 2 sc
newn prodcastelab_`x' 3 arun
newn prodcastelab_`x' 4 redi
newn prodcastelab_`x' 5 gram
newn prodcastelab_`x' 6 naid
newn prodcastelab_`x' 7 navi
newn prodcastelab_`x' 8 asar
newn prodcastelab_`x' 9 sett
newn prodcastelab_`x' 10 natt
newn prodcastelab_`x' 11 muda
newn prodcastelab_`x' 12 kula
newn prodcastelab_`x' 13 chet
newn prodcastelab_`x' 14 marw
newn prodcastelab_`x' 15 musl
newn prodcastelab_`x' 16 pada
}


*
fre covsubsistence
destring covsubsistence, replace
label values covsubsistence yesno

*
fre covsubsistencenext
destring covsubsistencenext, replace
label values covsubsistencenext yesno

*
fre covharvest
destring covharvest, replace
label define morelesssame 1"More" 2"Less" 3"Same"
label values covharvest morelesssame

*
fre covselfconsumption
destring covselfconsumption, replace
label values covselfconsumption morelesssame

*
fre covharvestquantity
destring covharvestquantity, replace
label values covharvestquantity morelesssame

*
fre covharvestprices
destring covharvestprices, replace
label values covharvestprices morelesssame

*
fre livestocklist
replace livestocklist="" if dummyeverhadland==0
splitvarmcq livestocklist 6
newn livestocklist 1 cow
newn livestocklist 2 goa
newn livestocklist 3 chi
newn livestocklist 4 bul
newn livestocklist 5 plo
newn livestocklist 6 non

*
foreach x in cow goat chicken bullock {
fre livestockuse_`x'
splitvarmcq livestockuse_`x' 6
newn livestockuse_`x' 1 sold
newn livestockuse_`x' 2 milk
newn livestockuse_`x' 3 savi
newn livestockuse_`x' 4 stat
newn livestockuse_`x' 5 reli
newn livestockuse_`x' 6 cons
}

*
fre dummycattleloss
destring dummycattleloss, replace
label values dummycattleloss yesno

*
fre dummycattlesold
destring dummycattlesold, replace
label values dummycattlesold yesno

*
fre equipmentlist
replace equipmentlist="" if dummyeverhadland==0
splitvarmcq equipmentlist 5
newn equipmentlist 1 tractor
newn equipmentlist 2 bullockcart
newn equipmentlist 3 harvester
newn equipmentlist 4 plowingmach
newn equipmentlist 5 none



*
foreach x in tractor bullockcart plowingmach { 
fre equipmentyear_`x'
destring equipmentyear_`x', replace
fre equipmentpledged_`x'
destring equipmentpledged_`x', replace
}


*
fre equipmentborrowedlist
rename equipmentborrowedlist equipborrowedlist
splitvarmcq equipborrowedlist 5
newn equipborrowedlist 1 tractor
newn equipborrowedlist 2 bullockcart
newn equipborrowedlist 3 harvester
newn equipborrowedlist 4 plowingmach
newn equipborrowedlist 5 none

*
fre decisionconsumption
destring decisionconsumption, replace
label define decisionconsumption 1"Yourself (household head)" 2"Spouse (husband/wife)" 3"Yourself and your spouse" 4"Someone else" 5"Yourself and someone else jointly" 77"Other"
label values decisionconsumption decisionconsumption

*
fre decisionhealth
destring decisionhealth, replace
label values decisionhealth decisionconsumption

*
fre covfoodenough
destring covfoodenough, replace
label define covfoodenough 1"Yes" 2"Often" 3"Barely" 4"No"
label values covfoodenough covfoodenough

*
fre covfoodquality
destring covfoodquality, replace
label define covfoodquality 1"Increase" 2"Decrease" 3"Remain stable"
label values covfoodquality covfoodquality

*
fre covgenexpenses
destring covgenexpenses, replace
label define covgenexpenses 1"More" 2"Less" 3"Same"
label values covgenexpenses covgenexpenses

*
fre covexpensesdecrease
splitvarmcq covexpensesdecrease 9
newn covexpensesdecrease 1 food
newn covexpensesdecrease 2 tran
newn covexpensesdecrease 3 clot
newn covexpensesdecrease 4 heal
newn covexpensesdecrease 5 educ
newn covexpensesdecrease 6 gift
newn covexpensesdecrease 7 cere
newn covexpensesdecrease 8 good
newn covexpensesdecrease 9 none

*
fre covexpensesincrease
splitvarmcq covexpensesincrease 9
newn covexpensesincrease 1 food
newn covexpensesincrease 2 tran
newn covexpensesincrease 3 clot
newn covexpensesincrease 4 heal
newn covexpensesincrease 5 educ
newn covexpensesincrease 6 gift
newn covexpensesincrease 7 cere
newn covexpensesincrease 8 good
newn covexpensesincrease 9 none

*
fre covexpensesstable
splitvarmcq covexpensesstable 9
newn covexpensesstable 1 food
newn covexpensesstable 2 tran
newn covexpensesstable 3 clot
newn covexpensesstable 4 heal
newn covexpensesstable 5 educ
newn covexpensesstable 6 gift
newn covexpensesstable 7 cere
newn covexpensesstable 8 good
newn covexpensesstable 9 none

*
fre covplacepurchase
destring covplacepurchase, replace
label values covplacepurchase yesno

*
fre listgoods
splitvarmcq listgoods 13
newn listgoods 1 car
newn listgoods 2 bik
newn listgoods 3 fri
newn listgoods 4 fur
newn listgoods 5 tai
newn listgoods 6 cel
newn listgoods 7 lan
newn listgoods 8 dvd
newn listgoods 9 cam
newn listgoods 10 coo
newn listgoods 11 com
newn listgoods 12 dis
newn listgoods 13 non


* 
foreach x in car bike fridge furniture tailormach phone landline camera cookgas computer antenna {
fre goodyearpurchased_`x'
*
destring goodyearpurchased_`x', replace
*
destring goodbuying_`x', replace
label define goodbuying 1"Credit" 2"Instalment" 3"Ready cash" 4"Did not pay for this good", replace
label values goodbuying_`x' goodbuying
*
destring covsellgoods_`x', replace
label values covsellgoods_`x' yesno
}

*
fre howpaymarriage
splitvarmcq howpaymarriage 4
newn howpaymarriage 1 loan
newn howpaymarriage 2 capi
newn howpaymarriage 3 gift
newn howpaymarriage 4 both

*
fre marriagegiftsource

*
foreach x in WKP rela empl mais coll frie SHG {
fre marriagegifttype_`x'
splitvarmcq marriagegifttype_`x' 5
newn marriagegifttype_`x' 1 gold
newn marriagegifttype_`x' 2 cash
newn marriagegifttype_`x' 3 clot
newn marriagegifttype_`x' 4 alme
newn marriagegifttype_`x' 5 vess
}

*
splitvarmcq marriagegiftsource 15
newn marriagegiftsource 1 wkp
newn marriagegiftsource 2 rel
newn marriagegiftsource 3 emp
newn marriagegiftsource 4 mai
newn marriagegiftsource 5 col
newn marriagegiftsource 6 paw
newn marriagegiftsource 7 sho
newn marriagegiftsource 8 fin
newn marriagegiftsource 9 fri
newn marriagegiftsource 10 shg
newn marriagegiftsource 11 ban
newn marriagegiftsource 12 coo
newn marriagegiftsource 13 sug
newn marriagegiftsource 14 gro
newn marriagegiftsource 15 tha


*
fre house
destring house, replace
label define house 1"Own house" 2"Joint property between wife and husband's families" 3"Family property inherited at a parent's death" 4"Rental"
label values house house

*
fre howbuyhouse
splitvarmcq howbuyhouse 7
newn howbuyhouse 1 here
newn howbuyhouse 2 savi
newn howbuyhouse 3 bank
newn howbuyhouse 4 wkp
newn howbuyhouse 5 fina
newn howbuyhouse 6 help
newn howbuyhouse 7 sche

*
fre covsellhouse
destring covsellhouse, replace
label define covsellhouse 1"Yes" 2"No" 66"N/A"
label values covsellhouse covsellhouse

*
fre housetype
destring housetype, replace
label define housetype 1"Concrete house" 2"Thatched roof house"
label values housetype housetype

*
fre housetitle
destring housetitle, replace
label values housetitle yesno

*
fre ownotherhouse
destring ownotherhouse, replace
label values ownotherhouse yesno

*
fre covsellplot
destring covsellplot, replace
label define covsellplot 1"Yes" 2"No" 66"N/A"
label values covsellplot covsellplot

*
fre dummysaleproperty
destring dummysaleproperty, replace
label values dummysaleproperty yesno

*
fre electricity
destring electricity, replace
label define electricity 1"General electricity" 2"Single line" 3"No electricity"
label values electricity electricity

*
fre water
destring water, replace
label define water 1"Own tap" 2"Public tap"
label values water water

*
fre toiletfacility
destring toiletfacility, replace
label define toiletfacility 1"No facilities" 2"Traditional pit latrine" 3"Semi-flush (septic tank) latrine" 4"Flush toilet"
label values toiletfacility toiletfacility

*
fre notoiletreason
destring notoiletreason, replace
label define notoiletreason 1"Do not want to by habits" 2"Do not want to because of water problems" 3"Do not want to because there is no space" 4"Other"
label values notoiletreason notoiletreason

*
fre noowntoilet
destring noowntoilet, replace
label define noowntoilet 1"None" 2"Shared toilet in building/chawl" 3"Shared toilet outside building" 4"Public/gov. toilet"
label values noowntoilet noowntoilet

*
fre schemeslist
splitvarmcq schemeslist 23
newn schemeslist 1 nrega 
newn schemeslist 2 ratio
newn schemeslist 3 house
newn schemeslist 4 funer
newn schemeslist 5 cowgo
newn schemeslist 6 lpgga
newn schemeslist 7 educa
newn schemeslist 8 farme
newn schemeslist 9 landg
newn schemeslist 10 selfe
newn schemeslist 11 marri
newn schemeslist 12 goldm
newn schemeslist 13 oldag
newn schemeslist 14 widow
newn schemeslist 15 mater
newn schemeslist 16 disab
newn schemeslist 17 retir
newn schemeslist 18 none
newn schemeslist 19 shg
newn schemeslist 20 TODROP
newn schemeslist 21 patta
newn schemeslist 22 lapto
newn schemeslist 23 girlp
drop schemeslist_TODROP

*
fre covproductavailability
destring covproductavailability, replace
label values covproductavailability yesno

*
fre covrationcarduse
splitvarmcq covrationcarduse 3
newn covrationcarduse 1 majo
newn covrationcarduse 2 bigp
newn covrationcarduse 3 smal



********** Agri covid product
tabulate covsubsistencereason
splitvarmcq covsubsistencereason 3
newn covsubsistencereason 1 labour 
newn covsubsistencereason 2 easier
newn covsubsistencereason 3 securi



********** Livestock
/*
foreach x in cow goa chi bul plo non {
replace livestocklist_`x'=0 if livestocklist_`x'==.
}

foreach x in cow goat chicken bullock bullforploughin none {
replace covselllivestock_`x'=0 if covselllivestock_`x'==.
}
*/



********** Schemes
ta rationcardreasonnouse
splitvarmcq rationcardreasonnouse 7
newn rationcardreasonnouse 1 far
newn rationcardreasonnouse 2 time
newn rationcardreasonnouse 3 fina
newn rationcardreasonnouse 4 supp
newn rationcardreasonnouse 5 qual
newn rationcardreasonnouse 6 need
newn rationcardreasonnouse 7 quan

fre schemeamount_cashmarriage schemeamount_goldmarriage schemeamount_oldage schemeamount_widows schemeamount_maternity schemeamount_disability schemeamount_retirement schemeamount_laptop

foreach x in schemeamount_cashmarriage schemeamount_goldmarriage schemeamount_oldage schemeamount_widows schemeamount_maternity schemeamount_disability schemeamount_retirement schemeamount_laptop {
replace `x'=. if `x'==66
replace `x'=. if `x'==0
}





********** Last minute cor
drop data

order dummygoldindiv, after(dummygold)

order covproductavailability, after(covrationcarduse)


save"Lastlast/NEEMSIS2-HH.dta", replace
****************************************
* END















****************************************
* NEEMSIS2-HH.dta
****************************************
use"Lastlast/NEEMSIS2-HH", clear

**********
ta landpurchasedacres
ta landpurchasedamount if landpurchasedacres==2178
replace landpurchasedacres=21 if landpurchasedacres==2178


**********
cls
tab1 productnbchoice_*

*1000
fre productnbchoice_cotton productselfconsumption_cotton productnbchoicesold_cotton if productnbchoice_cotton==1000

*50000
fre productnbchoice_sugarcane productselfconsumption_sugarcane productnbchoicesold_sugarcane if productnbchoice_sugarcane==50000
replace productnbchoice_sugarcane=30 if productnbchoice_sugarcane==50000

*300000
fre productnbchoice_sugarcane productselfconsumption_sugarcane productnbchoicesold_sugarcane if productnbchoice_sugarcane==300000
replace productnbchoice_sugarcane=84 if productnbchoice_sugarcane==300000

*400000
fre productnbchoice_savukku productselfconsumption_savukku productnbchoicesold_savukku if productnbchoice_savukku==400000
ta productunit_savukku if productnbchoice_savukku==400000
ta ownland if productnbchoice_savukku==400000
ta leaseland if productnbchoice_savukku==400000
ta sizeleaseland if productnbchoice_savukku==400000
replace productnbchoice_savukku=400 if productnbchoice_savukku==400000
replace productnbchoicesold_savukku=400 if productnbchoicesold_savukku==400000

*10800 
fre productnbchoice_guava productselfconsumption_guava productnbchoicesold_guava if productnbchoice_guava==10800
replace productnbchoice_guava=150 if productnbchoice_guava==10800

*37500
fre productnbchoice_guava productselfconsumption_guava productnbchoicesold_guava if productnbchoice_guava==37500
ta productacre_guava if productnbchoice_guava==37500
ta productunit_guava if productnbchoice_guava==37500
ta ownland if productnbchoice_guava==37500
ta sizeownland if productnbchoice_guava==37500
ta leaseland if productnbchoice_guava==37500
ta sizeleaseland if productnbchoice_guava==37500
replace productnbchoice_guava=3750 if productnbchoice_guava==37500
replace productnbchoicesold_guava=3750 if productnbchoice_guava==37500
replace productnbchoicesold_guava=3750 if productnbchoicesold_guava==37500

*45000
fre productnbchoice_millets productselfconsumption_millets productnbchoicesold_millets if productnbchoice_millets==45000
replace productnbchoice_millets=43 if productnbchoice_millets==45000


*6000
fre productnbchoice_other productselfconsumption_other productnbchoicesold_other if productnbchoice_other==6000
replace productnbchoice_other=6 if productnbchoice_other==6000



save"Lastlast/Corrected/NEEMSIS2-HH.dta", replace
****************************************
* END













****************************************
* NEEMSIS2-migration.dta
****************************************
use"NEEMSIS2-migrations", clear

rename migrationreason_family migrationreason_debt

rename covmigrationagainreason_famil covmigrationagainreason_debt


save"Lastlast/NEEMSIS2-migrations.dta", replace
****************************************
* END
















****************************************
* NEEMSIS2-ego.dta
****************************************
use"NEEMSIS2-ego", clear

********** Workedpastyear
preserve
use"NEEMSIS2-HH", clear
ta dummyworkedpastyear
keep HHID2020 INDID2020 dummyworkedpastyear sex reasonnotworkpastyear version_HH version_agri
save"_tempworked", replace
restore

merge 1:1 HHID2020 INDID2020 using "_tempworked"
keep if _merge==3
order HHID2020 INDID2020 sex dummyworkedpastyear reasonnotworkpastyear
drop _merge
order version_HH version_agri, last

*
fre reasondontsearchjob
replace reasondontsearchjob="" if reasondontsearchjob=="."
splitvarmcq reasondontsearchjob  15
newn reasondontsearchjob 1 stud
newn reasondontsearchjob 2 hous
newn reasondontsearchjob 3 reti
newn reasondontsearchjob 4 olda
newn reasondontsearchjob 5 ill
newn reasondontsearchjob 6 disa
newn reasondontsearchjob 7 mili
newn reasondontsearchjob 8 notw
newn reasondontsearchjob 9 foun
newn reasondontsearchjob 10 resp
newn reasondontsearchjob 11 reca
newn reasondontsearchjob 12 busy
newn reasondontsearchjob 13 beli
newn reasondontsearchjob 14 nojo
newn reasondontsearchjob 15 refu

*
destring beforemainoccup, replace
label define beforemainoccup 1"Agri" 2"Self-employed" 3"SJ (agri)" 4"SJ (non-agri)" 5"UW in HH business" 6"UW in other business" 7"UW in own farm" 8"UW in another farm" 9"Unemployed" 10"Full-time student" 11"Apprenticeship" 12"Not working and not looking for a job" 77"Other"
label values beforemainoccup beforemainoccup
fre beforemainoccup

*
destring mainoccuptype, replace
label define mainoccuptype 1"Agri" 2"Self-employed" 3"SJ (agri)" 4"SJ (non-agri)" 5"UW in HH business" 6"UW in other business" 7"UW in own farm" 8"UW in another farm"
label values mainoccuptype mainoccuptype
fre mainoccuptype

*
label define afon 1"Always" 2"Frequently" 3"Occasionally" 4"Never"
label values respect afon
label values workmate afon
label values useknowledgeatwork afon
tabulate respect
tabulate workmate
tabulate useknowledgeatwork


*
fre businessafter15
destring businessafter15, replace
label define businessafter15 1"Yes, I did set a business/farm" 2"Yes I tried but did not succeed in setting up a business/farm" 3"No, I never tried"
label values businessafter15 businessafter15

*
fre reasondontsearchjobsince15
splitvarmcq reasondontsearchjobsince15 15
newn reasondontsearchjobsince15 1 stud
newn reasondontsearchjobsince15 2 hous
newn reasondontsearchjobsince15 3 reti
newn reasondontsearchjobsince15 4 olda
newn reasondontsearchjobsince15 5 ill
newn reasondontsearchjobsince15 6 disa
newn reasondontsearchjobsince15 7 mili
newn reasondontsearchjobsince15 8 notw
newn reasondontsearchjobsince15 9 foun
newn reasondontsearchjobsince15 10 resp
newn reasondontsearchjobsince15 11 reca
newn reasondontsearchjobsince15 12 busy
newn reasondontsearchjobsince15 13 beli
newn reasondontsearchjobsince15 14 nojo
newn reasondontsearchjobsince15 15 refu

*
fre kindofworkfirstjob
destring kindofworkfirstjob, replace
label define kindofworkfirstjob 1"Agri" 2"Self-emp" 3"SJ agri" 4"SJ non-agri" 5"UW non-agi in HH business" 6"UW non-agri in other business" 7"UW own farm" 8"UW another farm"
label values kindofworkfirstjob kindofworkfirstjob

*
fre unpaidinbusinessfirstjob
replace unpaidinbusinessfirstjob="" if unpaidinbusinessfirstjob=="."

*
fre methodfindfirstjob
replace methodfindfirstjob="" if methodfindfirstjob=="."
splitvarmcq methodfindfirstjob 9
newn methodfindfirstjob 1 snfrien
newn methodfindfirstjob 2 snrelat
newn methodfindfirstjob 3 snother
newn methodfindfirstjob 4 employe
newn methodfindfirstjob 5 pubagen
newn methodfindfirstjob 6 priagen
newn methodfindfirstjob 7 univers
newn methodfindfirstjob 8 medipap
newn methodfindfirstjob 9 interne

*
fre snfindfirstjob
replace snfindfirstjob="" if snfindfirstjob=="."

*
fre othermethodfindfirstjob
replace snfindfirstjob="" if snfindfirstjob=="."

*
fre maxhoursayear
destring maxhoursayear, replace

*
fre nbofoccupations
destring nbofoccupations, replace

*
fre selected_months
replace selected_months="" if selected_months=="."
splitvarmcq selected_months 12
newn selected_months 1 chithirai
newn selected_months 2 vaikasi
newn selected_months 3 aani
newn selected_months 4 aadi
newn selected_months 5 aavani
newn selected_months 6 purataasi
newn selected_months 7 iypasi
newn selected_months 8 karthigal
newn selected_months 9 maargazhi
newn selected_months 10 thai
newn selected_months 11 maasi
newn selected_months 12 panguni

*
fre indhoursayear1
destring indhoursayear1, replace

*
fre indhoursayear2
destring indhoursayear2, replace

*
fre indhoursayear3
destring indhoursayear3, replace

*
fre indhoursayear
destring indhoursayear, replace

*
fre otherbeforemainoccup
replace otherbeforemainoccup="" if otherbeforemainoccup=="."

*
fre reasonstoppedwagejob
replace reasonstoppedwagejob="" if reasonstoppedwagejob=="."
splitvarmcq reasonstoppedwagejob 12
newn reasonstoppedwagejob 1 fired
newn reasonstoppedwagejob 2 endof
newn reasonstoppedwagejob 3 busin
newn reasonstoppedwagejob 4 emplo
newn reasonstoppedwagejob 5 lowwa
newn reasonstoppedwagejob 6 retir
newn reasonstoppedwagejob 7 pregn
newn reasonstoppedwagejob 8 healt
newn reasonstoppedwagejob 9 looki
newn reasonstoppedwagejob 10 moved
newn reasonstoppedwagejob 11 educa
newn reasonstoppedwagejob 12 prefe

*
fre otherreasonstoppedjob
repmi otherreasonstoppedjob

*
fre covdifficulties
repmi covdifficulties
splitvarmcq covdifficulties 9
newn covdifficulties 1 inpu
newn covdifficulties 2 cash
newn covdifficulties 3 sell
newn covdifficulties 4 payl
newn covdifficulties 5 freq
newn covdifficulties 6 pres
newn covdifficulties 7 chan
newn covdifficulties 8 lack
newn covdifficulties 9 none

*
fre businesssourceinvest
repmi businesssourceinvest
splitvarmcq businesssourceinvest 9
newn businesssourceinvest 1 rela
newn businesssourceinvest 2 bank
newn businesssourceinvest 3 info
newn businesssourceinvest 4 savi
newn businesssourceinvest 5 inhe
newn businesssourceinvest 6 prof
newn businesssourceinvest 7 need
newn businesssourceinvest 8 capi
newn businesssourceinvest 9 sche

*
fre otherbusinesssourceinvestment
repmi otherbusinesssourceinvestment

*
forvalues i=1/6 {
fre snbusinesslender`i'
repmi snbusinesslender`i'
}

*
fre businessworkersfrequency
repmi businessworkersfrequency
destring businessworkersfrequency, replace
label define businessworkersfrequency 1"Month" 2"Fortnight (2 weeks)" 3"Week" 4"Day"
label values businessworkersfrequency businessworkersfrequency

*
fre businesspaymentinkindlist
repmi businesspaymentinkindlist
splitvarmcq businesspaymentinkindlist 5
newn businesspaymentinkindlist 1 clot
newn businesspaymentinkindlist 2 food
newn businesspaymentinkindlist 3 tran
newn businesspaymentinkindlist 4 acco
newn businesspaymentinkindlist 5 labo


*
fre snrecruitworkernamelist
repmi snrecruitworkernamelist
destring snrecruitworkernamelist, replace

*
forvalues i=1/5 {
fre snrecruitworkername`i'
repmi snrecruitworkername`i'
}

*
fre wageamountmonth wageamountmonth1 wageamountmonth2 wageamountmonth3 wageamountmonth4
destring wageamountmonth wageamountmonth1 wageamountmonth2 wageamountmonth3 wageamountmonth4, replace


*
fre wagejobpaymentinkindlist
repmi wagejobpaymentinkindlist
splitvarmcq wagejobpaymentinkindlist 5
newn wagejobpaymentinkindlist 1 clot
newn wagejobpaymentinkindlist 2 food
newn wagejobpaymentinkindlist 3 tran
newn wagejobpaymentinkindlist 4 acco
newn wagejobpaymentinkindlist 5 labo

*
fre sumwagejobpaymentinkindvalue
destring sumwagejobpaymentinkindvalue, replace


*
forvalues i=1/4 {
fre covworkeffort`i'
destring covworkeffort`i', replace
label define covworkeffort 1"More" 2"Less" 3"Same" 4"Constrained to stop due to COVID-19" 5"Never start due to COVID-19" 66"N/A", replace
label values covworkeffort`i' covworkeffort
}

*
fre decisionworkother
repmi decisionworkother

*
fre decisionearnworkother
repmi decisionearnworkother

*
fre methodfindjob
repmi methodfindjob
splitvarmcq methodfindjob 9
newn methodfindjob 1 snfrie
newn methodfindjob 2 snrela
newn methodfindjob 3 snothe
newn methodfindjob 4 employ
newn methodfindjob 5 pubage
newn methodfindjob 6 priage
newn methodfindjob 7 univer
newn methodfindjob 8 medpap
newn methodfindjob 9 intern

*
fre moveoutsideforjobreason
repmi moveoutsideforjobreason
splitvarmcq moveoutsideforjobreason 3
newn moveoutsideforjobreason 1 fami
newn moveoutsideforjobreason 2 nojo
newn moveoutsideforjobreason 3 bett

*
fre moveoutsideforjobreasonother
repmi moveoutsideforjobreasonother


*
fre reasondontworkmore
repmi reasondontworkmore
splitvarmcq reasondontworkmore 14
newn reasondontworkmore 1 schoo
newn reasondontworkmore 2 house
newn reasondontworkmore 3 retir
newn reasondontworkmore 4 oldag
newn reasondontworkmore 5 ill
newn reasondontworkmore 6 disab
newn reasondontworkmore 7 milit
newn reasondontworkmore 8 belie
newn reasondontworkmore 9 deman
newn reasondontworkmore 10 flex
newn reasondontworkmore 11 commu
newn reasondontworkmore 12 discr
newn reasondontworkmore 13 alrea
newn reasondontworkmore 14 covid

*
fre mostseriousincident
destring mostseriousincident, replace
label define mostseriousincident 1"No permanent effect" 2"Permanent effect but able to crry on" 3"Permanent effect but work altough not in the same job" 4"Permanent effect prevent you from working at all"
label values mostseriousincident mostseriousincident

*
fre mostseriousinjury
destring mostseriousinjury, replace
label define mostseriousinjury 1"Arms, hands, neck or shoulder" 2"Hips, legs or feet" 3"Back" 4"Breathing or lung problems" 5"Skin problem" 6"Hearing problem" 7"Stress, depression or anxiety" 8"Headache or eye strain" 9"Heart disease/attack, other circulatory system" 10"Infectious disease" 66"Irrelevant" 77"Other" 99"No response"
label values mostseriousinjury mostseriousinjury

*
fre seriousinjuryother
repmi seriousinjuryother

*
fre associationlist
splitvarmcq associationlist 13
newn associationlist 1 youth
newn associationlist 2 shg
newn associationlist 3 trade
newn associationlist 4 farme
newn associationlist 5 panch
newn associationlist 6 polit
newn associationlist 7 profe
newn associationlist 8 marke
newn associationlist 9 relig
newn associationlist 10 hobby
newn associationlist 11 alumn
newn associationlist 12 other
newn associationlist 13 none

*
fre covassociationhelp
destring covassociationhelp, replace
label values covassociationhelp yesno

*
fre covassociationhelplist
splitvarmcq covassociationhelplist 13
newn covassociationhelplist 1 youth
newn covassociationhelplist 2 shg
newn covassociationhelplist 3 trade
newn covassociationhelplist 4 farme
newn covassociationhelplist 5 panch
newn covassociationhelplist 6 polit
newn covassociationhelplist 7 profe
newn covassociationhelplist 8 marke
newn covassociationhelplist 9 relig
newn covassociationhelplist 10 hobby
newn covassociationhelplist 11 alumn
newn covassociationhelplist 12 other
newn covassociationhelplist 13 none


*
fre covassociationhelptype
splitvarmcq covassociationhelptype 7
newn covassociationhelptype 1 food
newn covassociationhelptype 2 meal
newn covassociationhelptype 3 cash
newn covassociationhelptype 4 loan
newn covassociationhelptype 5 help
newn covassociationhelptype 6 recr
newn covassociationhelptype 7 comm

* Reprendre ca mais mettre les numéros à la fin
/*
forvalues i=1/2 {
fre assohelpjob`i'
splitvarmcq assohelpjob`i' 5
newn assohelpjob`i' 1 hired
newn assohelpjob`i' 2 refer
newn assohelpjob`i' 3 share
newn assohelpjob`i' 4 appli
newn assohelpjob`i' 5 emoti
}
*/

*

*
fre snrecommendassoname1
* 10 11...

*
fre snfindcurrentjobnamelist

*
fre snfindcurrentjobname1

*
fre snfindjobnamelist

*
fre snfindjobname1

*
fre snrecommendforjobnamelist

*
fre snrecommendforjobname1

*
fre snrecojobsuccessnamelist

*
fre snrecojobsuccessname1

*
fre sntalkthemost

*
fre snhelpemergency

*
fre snhelpemergencyname2

*
fre contactlist
splitvarmcq contactlist 9
newn contactlist 1 head 
newn contactlist 2 poli
newn contactlist 3 civi
newn contactlist 4 bank
newn contactlist 5 panc
newn contactlist 6 coun
newn contactlist 7 recr
newn contactlist 8 trad
newn contactlist 9 none

*
fre contactleaders
repmi contactleaders


*
forvalues i=1/5 {
fre covinstit`i'
label define covinstit 1"Full confidence" 2"More like" 3"Not really" 4"Not at all", replace
label values covinstit`i' covinstit
}

*
fre covcontactinstitution
splitvarmcq covcontactinstitution 6
newn covcontactinstitution 1 coun
newn covcontactinstitution 2 tami
newn covcontactinstitution 3 poli
newn covcontactinstitution 4 trad
newn covcontactinstitution 5 reli
newn covcontactinstitution 6 none

*
fre covmostefficienthelp
label define covmostefficienthelp 1"Governmental institutions" 2"Family" 3"Community" 4"Other caste groups" 77"Any other institutions or associations"
label values covmostefficienthelp covmostefficienthelp

*
fre covmostefficienthelpother
repmi covmostefficienthelpother

*
ta businessfixedcosts
repmi businessfixedcosts


*
label define snyesno 1"Yes" 2"No need" 3"Nobody"
destring covsnhelpreceived, replace
destring covsnhelpgiven, replace
label values covsnhelpreceived snyesno
label values covsnhelpgiven snyesno

fre covsnhelpreceived covsnhelpgiven


save"Lastlast/NEEMSIS2-ego.dta", replace
****************************************
* END









****************************************
* NEEMSIS2-ego
****************************************
use"Lastlast/NEEMSIS2-ego.dta", clear


tabulate businesslossinvestamount businesslossinvest, m
replace businesslossinvest=1 if businesslossinvestamount!=.
fre businesslossinvest



save"Lastlast/Corrected/NEEMSIS2-ego.dta", replace
****************************************
* END











****************************************
* NEEMSIS2-alters
****************************************
use"NEEMSIS2-alters_networkpurpose.dta", clear

fre networkpurpose1 networkpurpose2 networkpurpose3 networkpurpose4 networkpurpose5 networkpurpose6 networkpurpose7 networkpurpose8 networkpurpose9 networkpurpose10 networkpurpose11

preserve
use"C:\Users\Arnaud\Documents\MEGA\Research\Data\Data_NEEMSIS2\DATA\APPEND\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-covsntypehelpreceivedgroup_v2.dta", clear
rename parent_key HHID2020
rename covsntypehelpreceivedgroupname namealter
rename covsntypehelpreceivedgroupid id
keep HHID2020 egoid covsntypehelpreceived namealter id
splitvarmcq covsntypehelpreceived 7
newn covsntypehelpreceived 1 food
newn covsntypehelpreceived 2 free
newn covsntypehelpreceived 3 cash
newn covsntypehelpreceived 4 loan
newn covsntypehelpreceived 5 help
newn covsntypehelpreceived 6 recr
newn covsntypehelpreceived 7 nona
duplicates report HHID2020 egoid namealter
save"_tempcovreceived", replace
restore

preserve
use"C:\Users\Arnaud\Documents\MEGA\Research\Data\Data_NEEMSIS2\DATA\APPEND\CLEAN\NEEMSIS_APPEND-ego123questionnaire-socialnetworks-informalsocialcapital-covsntypehelpgivengroup_v2.dta", clear
rename parent_key HHID2020
rename covsntypehelpgivengroupname namealter
rename covsntypehelpgivengroupid id
keep HHID2020 egoid covsntypehelpgiven namealter id
splitvarmcq covsntypehelpgiven 7
newn covsntypehelpgiven 1 food
newn covsntypehelpgiven 2 free
newn covsntypehelpgiven 3 cash
newn covsntypehelpgiven 4 loan
newn covsntypehelpgiven 5 help
newn covsntypehelpgiven 6 recr
newn covsntypehelpgiven 7 nona
save"_tempcovgiven", replace
restore

****************************************
* END



