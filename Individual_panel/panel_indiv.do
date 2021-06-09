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



********** Relationshiptohead2020
fre relationshiptohead
tab relationshiptoheadother 
/*

             If 'Other', please specify |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                        Anbarasan's son |          1        1.52        1.52
                       Anbarasan's wife |          1        1.52        3.03
                         Brother's wife |          2        3.03        6.06
                    Daughter's daughter |          1        1.52        7.58
                                 Huband |          1        1.52        9.09
                                Husband |         50       75.76       84.85
                      Husband's brother |          1        1.52       86.36
Mangalakshmi is sumathi's younger sis.. |          1        1.52       87.88
                          Murugan's son |          3        4.55       92.42
                         Murugan's wife |          1        1.52       93.94
                          Sister in law |          2        3.03       96.97
                  Sivakandan's daughter |          1        1.52       98.48
                      Sivakandan's wife |          1        1.52      100.00
----------------------------------------+-----------------------------------
                                  Total |         66      100.00

*/

replace relationshiptohead=20 if HHID_panel=="SEM2" & name=="Priya/Nithya?"  // daughter daughter = grandchild or grandchild in law ?

replace relationshiptohead=21 if HHID_panel=="SEM29" & name=="Valli"  // brother's wife --> sister in law
replace relationshiptohead=21 if HHID_panel=="SEM29" & name=="Sheela"  // brother's wife --> sister in law

replace relationshiptohead=22 if relationshiptoheadother=="Huband"  // husband
replace relationshiptohead=22 if relationshiptoheadother=="Husband"  // husband

replace relationshiptohead=21 if relationshiptoheadother=="Sivakandan's wife"  // sister in law

replace relationshiptohead=23 if relationshiptoheadother=="Sivakandan's daughter"  // nephew, niece

replace relationshiptohead=24 if relationshiptoheadother=="Husband's brother"  // --> brother-in-law

replace relationshiptohead=23 if relationshiptoheadother=="Mangalakshmi is sumathi's younger sister's daughter. Mangalakshmi's parents were died so sumathi taking care of her."  // niece


replace relationshiptohead=21 if relationshiptoheadother=="Anbarasan's wife"  // sister in law

replace relationshiptohead=23 if relationshiptoheadother=="Anbarasan's son"  // nephew, niece

replace relationshiptohead=21 if relationshiptoheadother=="Sister in law"  // sister in law

replace relationshiptohead=21 if relationshiptoheadother=="Murugan's wife"  // sister in law

replace relationshiptohead=23 if relationshiptoheadother=="Murugan's son"  // nephew, niece

tab relationshiptohead if relationshiptoheadother!=""



*recode
recode relationshiptohead (20=18) (21=19) (22=2) (23=20) (24=21)
label define relationshiptohead 1"Head" 2"Wife/Husband" 3"Mother" 4"Father" 5"Son" 6"Daughter" 7"Son-in-law" 8"Daughter-in-law" 9"Sister" 10"Brother" 11"Mother-in-law" 12"Father-in-law" 13"Grandchild" 15"Grandfather" 16"Grandmother" 17"Cousin" 18"Grandchild-in-law" 19"Sister-in-law" 20"Niece/nephew" 21"Brother-in-law" 77"Other", replace
label values relationshiptohead relationshiptohead
tab relationshiptohead
label define sex 1"Male" 2"Female"
label values sex sex

*merge
rename INDID INDID2020
destring INDID2020, replace
merge 1:m HHID_panel INDID2020 using"C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\Individual_panel\panel_indiv", keepusing(INDID_panel)
keep if _merge==3
drop _merge


*append
append using "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\Individual_panel\indiv2016"
append using "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\Individual_panel\indiv2020"
order HHID_panel INDID_panel year INDID name sex age relationshiptohead dummylivinghome maritalstatus egoid 
sort HHID_panel INDID_panel

egen HHINDID_panel=concat(HHID_panel INDID_panel), p(/)

********** reshape pour version wide
reshape wide INDID name sex age relationshiptohead dummylivinghome maritalstatus egoid,i(HHINDID_panel) j(year)
order HHID_panel INDID_panel
drop HHINDID_panel
