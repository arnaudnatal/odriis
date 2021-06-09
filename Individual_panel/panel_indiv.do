********** Correction
replace INDID_panel=5 if HHID_panel=="GOV19" & INDID=="3" & year==2020

replace INDID_panel=16 if HHID_panel=="GOV38" & INDID=="3" & year==2020
replace INDID_panel=17 if HHID_panel=="GOV38" & INDID=="4" & year==2020
replace INDID_panel=18 if HHID_panel=="GOV38" & INDID=="5" & year==2020
replace INDID_panel=19 if HHID_panel=="GOV38" & INDID=="6" & year==2020
replace INDID_panel=3 if HHID_panel=="GOV38" & INDID=="7" & year==2020
replace INDID_panel=4 if HHID_panel=="GOV38" & INDID=="8" & year==2020

replace INDID_panel=16 if HHID_panel=="MAN23" & INDID=="2" & year==2020
replace INDID_panel=17 if HHID_panel=="MAN23" & INDID=="3" & year==2020
replace INDID_panel=18 if HHID_panel=="MAN23" & INDID=="4" & year==2020

replace INDID_panel=16 if HHID_panel=="MAN34" & INDID=="1" & year==2020
replace INDID_panel=17 if HHID_panel=="MAN34" & INDID=="2" & year==2020
replace INDID_panel=18 if HHID_panel=="MAN34" & INDID=="3" & year==2020

replace INDID_panel=4 if HHID_panel=="MANAM18" & INDID=="2" & year==2020
replace INDID_panel=16 if HHID_panel=="MANAM18" & INDID=="3" & year==2020
replace INDID_panel=17 if HHID_panel=="MANAM18" & INDID=="4" & year==2020

replace INDID_panel=16 if HHID_panel=="SEM44" & INDID=="4" & year==2020
replace INDID_panel=17 if HHID_panel=="SEM44" & INDID=="5" & year==2020
replace INDID_panel=18 if HHID_panel=="SEM44" & INDID=="6" & year==2020
replace INDID_panel=4 if HHID_panel=="SEM44" & INDID=="7" & year==2020

replace INDID_panel=1 if HHID_panel=="ELA52" & INDID=="F3" & year==2010
replace INDID_panel=5 if HHID_panel=="ELA52" & INDID=="F1" & year==2010

replace INDID_panel=-95 if HHID_panel=="GOV10" & INDID=="F2" & year==2010
replace INDID_panel=-96 if HHID_panel=="GOV10" & INDID=="F3" & year==2010
replace INDID_panel=-97 if HHID_panel=="GOV10" & INDID=="F4" & year==2010

replace INDID_panel=-95 if HHID_panel=="GOV47" & INDID=="F2" & year==2010
replace INDID_panel=-96 if HHID_panel=="GOV47" & INDID=="F3" & year==2010
replace INDID_panel=2 if HHID_panel=="GOV47" & INDID=="F4" & year==2010

replace INDID_panel=-95 if HHID_panel=="GOV48" & INDID=="F2" & year==2010

replace INDID_panel=-95 if HHID_panel=="GOV5" & INDID=="F2" & year==2010
replace INDID_panel=-96 if HHID_panel=="GOV5" & INDID=="F3" & year==2010
replace INDID_panel=-97 if HHID_panel=="GOV5" & INDID=="F4" & year==2010

replace INDID_panel=-95 if HHID_panel=="GOV9" & INDID=="F2" & year==2010

replace INDID_panel=-95 if HHID_panel=="KAR15" & INDID=="F6" & year==2010

replace INDID_panel=-95 if HHID_panel=="ELA13" & INDID=="F3" & year==2010

replace INDID_panel=-99 if HHID_panel=="ELA7" & INDID=="F1" & year==2010

replace INDID_panel=-99 if HHID_panel=="KUV10" & INDID=="F2" & year==2010
replace INDID_panel=-98 if HHID_panel=="KUV10" & INDID=="F3" & year==2010
replace INDID_panel=-97 if HHID_panel=="KUV10" & INDID=="F4" & year==2010
replace INDID_panel=-96 if HHID_panel=="KUV10" & INDID=="F5" & year==2010
replace INDID_panel=-95 if HHID_panel=="KUV10" & INDID=="F6" & year==2010


replace INDID_panel=-99 if HHID_panel=="KUV25" & INDID=="F2" & year==2010
replace INDID_panel=-98 if HHID_panel=="KUV25" & INDID=="F3" & year==2010
replace INDID_panel=-97 if HHID_panel=="KUV25" & INDID=="F4" & year==2010

replace INDID_panel=-99 if HHID_panel=="MANAM34" & INDID=="F2" & year==2010

replace INDID_panel=-99 if HHID_panel=="MANAM40" & INDID=="F3" & year==2010


********** Reshape pour nouveau code
egen INDID_new=concat(HHID_panel INDID_panel), p(/)

reshape wide INDID name sex age maritalstatus version_HH,i(INDID_new) j(year)
drop INDID_panel
split INDID_new, p(/)
drop INDID_new2
drop INDID_new1


********** Nouveau code
bysort HHID_panel: gen n=_n
order HHID_panel n INDID2010 INDID2016 INDID2020
drop INDID_new
tostring n, replace
gen I="In"
egen INDID_panel=concat(I n)
order HHID_panel INDID_panel
drop I n