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
}
splitvarmcq productcastelabourers_`x' 16
newn productcastelabourers_`x' 1 van
newn productcastelabourers_`x' 2 sc
newn productcastelabourers_`x' 3 aru
newn productcastelabourers_`x' 4 red
newn productcastelabourers_`x' 5 gra
newn productcastelabourers_`x' 6 nai
newn productcastelabourers_`x' 7 nav
newn productcastelabourers_`x' 8 asa
newn productcastelabourers_`x' 9 set
newn productcastelabourers_`x' 10 nat
newn productcastelabourers_`x' 11 mud
newn productcastelabourers_`x' 12 kul
newn productcastelabourers_`x' 13 che
newn productcastelabourers_`x' 14 mar
newn productcastelabourers_`x' 15 mus
newn productcastelabourers_`x' 16 pad
}












fre covsubsistence

fre covsubsistencesize

fre covsubsistencenext

fre covharvest

fre covselfconsumption

fre covharvestquantity

fre covharvestprices

fre livestocklist

cow goat chicken bullock

fre livestockuse_cow

fre covselllivestock

fre dummycattleloss

fre dummycattlesold

fre cattlesoldreason

fre equipmentlist



tractor bullockcart plowingmach


fre equipmentyear_tractor

fre equipmentpledged_tractor



fre equipmentborrowedlist

fre covsellequipment

fre decisionconsumption


fre decisionhealth


fre covfoodenough

fre covfoodquality

fre covgenexpenses

fre covexpensesdecrease

fre covexpensesincrease

fre covexpensesstable

fre covplacepurchase

fre listgoods

car bike fridge ...

fre goodyearpurchased_car

fre goodbuying_car

covsellgoods_bike... yesno



fre howpaymarriage


fre marriagegiftsource

fre marriagegifttype_WKP

fre house

fre howbuyhouse

fre covsellhouse

fre housetype

fre housetitle

fre ownotherhouse

fre covsellplot

fre dummysaleproperty

fre electricity

fre water

fre toiletfacility

fre notoiletreason

fre noowntoilet

fre schemeslist

fre covproductavailability

fre covrationcarduse

fre 


save"Lastlast/NEEMSIS2-HH.dta", replace
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








/*


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



********** Guarantee and recommendation
label values dummyrecommendgivenlist yesno





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







