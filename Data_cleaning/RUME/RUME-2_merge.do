cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
16/04/2021
-----
TITLE: RUME

-------------------------
*/




****************************************
* INITIALIZATION
****************************************
global directory = "C:\Users\Arnaud\Documents\MEGA\Data\Data_RUME\DATA"
cd "$directory"
****************************************
* END








****************************************
* Merge HH
****************************************
use"dta\B_family", clear

merge m:1 HHID2010 using "dta\B_intro"
drop _merge
order HHID2010 INDID2010 village villagearea householdid address religion caste castecode comefrom outsider name sex relationshiptohead age livinghome education studentpresent typeeducation
sort HHID2010 INDID2010

*
merge 1:1 HHID2010 INDID2010 using "dta\B_SE1"
sort _merge
*ADGP193	F1
drop if _merge==2
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_SE2"
sort _merge
*ADGP193	F1
drop if _merge==2
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_SE4"
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_SE5"
sort _merge
*ADGP193	F1
drop if _merge==2
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_SE6"
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_SE3"
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_SJ1"
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_SJ2"
drop _merge

merge m:1 HHID2010 using "dta\B_crisis"
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_migration"
drop _merge

merge m:1 HHID2010 using "dta\B_remrec"
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_remsent"
drop _merge

merge m:1 HHID2010 using "dta\B_creditproduct"
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_lendtoother"
drop _merge

merge m:1 HHID2010 using "dta\B_givenreco"
drop _merge

merge m:1 HHID2010 using "dta\B_receivedreco"
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_chit"
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_savings"
drop _merge

merge m:1 HHID2010 using "dta\B_gold"
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_insurance"
drop _merge

merge m:1 HHID2010 using "dta\B_land"
drop _merge

merge m:1 HHID2010 using "dta\B_landpurchased"
drop _merge

merge m:1 HHID2010 using "dta\B_leasedland"
drop _merge

merge m:1 HHID2010 using "dta\B_landleasing"
drop _merge

merge m:1 HHID2010 using "dta\B_crops"
drop _merge

merge m:1 HHID2010 using "dta\B_intstopcrops"
drop _merge

merge m:1 HHID2010 using "dta\B_otherproduct"
drop _merge

merge m:1 HHID2010 using "dta\B_labourers"
drop _merge

merge m:1 HHID2010 using "dta\B_livestock"
drop _merge

merge m:1 HHID2010 using "dta\B_farmequipment"
drop _merge

merge m:1 HHID2010 using "dta\B_expenses"
drop _merge

merge m:1 HHID2010 using "dta\B_goods"
drop _merge

merge m:1 HHID2010 using "dta\B_house"
drop _merge

merge m:1 HHID2010 using "dta\B_otherfacilities"
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_pubservwork"
sort _merge
*ANTGP237	F5
drop if _merge==2
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_memberships"
sort _merge
*ANTGP237	F5
drop if _merge==2
drop _merge

merge 1:1 HHID2010 INDID2010 using "dta\B_membershipsasso"
drop _merge


*Save
save"dta\RUME-HH_v0.dta", replace

****************************************
* END










****************************************
* Merge Occupations
****************************************
use"dta\B_occupations", clear

drop individ
duplicates report HHID2010 INDID2010 kindofwork

preserve
keep HHID2010 INDID2010
duplicates drop
gen dummyworkedpastyear=1
duplicates report HHID2010 INDID2010
*duplicates tag HHID2010 INDID2010, gen(tag)
*sort tag HHID2010 INDID2010
save"dta\B_workedpastyear", replace
restore

fre kindofwork
bysort HHID2010 INDID2010: gen occupationid=_n
order HHID2010 INDID2010 occupationid
ta occupationid


save"CLEAN\RUME-occupations.dta", replace
****************************************
* END








****************************************
* Merge Loans
****************************************
use"dta\B_loans", clear


merge 1:1 HHID2010 loanid using "dta\B_mainloans"
drop _merge

save"CLEAN\RUME-loans_mainloans.dta", replace
****************************************
* END







****************************************
* Merge Lenders
****************************************
use"dta\B_lenders", clear

preserve
bysort HHID2010 (mltype mlfrequency): gen n=_n
order HHID2010 n
drop creditid
reshape wide mltype mlfrequency mlaction1 mlaction2 mlaction3 mlcontinue mlstop mlstopyear mlnberasked mlstopreason mlstrength1 mlstrength2 mlstrength3 mlweakness1 mlweakness2 mlweakness3, i(HHID2010) j(n)
restore

save"CLEAN\RUME-lenders.dta", replace
****************************************
* END






****************************************
* Last var HH
****************************************
use"dta\RUME-HH_v0.dta", clear

merge 1:1 HHID2010 INDID2010 using "dta\B_workedpastyear"
drop _merge

recode dummyworkedpastyear dummypastbusiness (.=0)
label values dummyworkedpastyear yesno
order dummyworkedpastyear, after(typeeducation)


*Clean
rename caste jatis

rename castecode caste

fre education
recode education (9=0) (8=77)
label define educ2 0"No education" 1"Primary" 2"High school" 3"HSC" 4"Diploma" 5"Degree" 6"Post graduate" 7"Enginering" 66"Irrelevant" 77"Other"
label values education educ2

*
foreach x in dummyworkedpastyear dummybusinesslabourers dummypastbusiness sjdummyadvance1 sjdummyadvance2 sjdummyadvance3 sjdummyadvance4 dummyadvance1 dummyadvancebalance1 dummyadvance2 dummyadvancebalance2 dummymigration dummyremrec dummyremsent dummyrecommendback1 dummyrecommendback2 dummyrecommendrefuse dummychitfund chitfundbelongerdummy dummydebitcard1 dummycreditcard1 dummydebitcard2 dummycreditcard2 dummydebitcard3 dummycreditcard3 dummysavingaccount dummyinsurance dummylandpurchased dummyleasedland dummyleasingland dummylabourers dummylivestock dummycattleloss dummymedicalexpenses dummyservpub dummymemberships dummymembershipsasso {
recode `x' (.=0)
}

*Chit
fre dummychitfund chitfundbelongerdummy
drop dummychitfund
bysort HHID2010: egen dummychitfund=sum(chitfundbelongerdummy)
replace dummychitfund=1 if dummychitfund>1
label values dummychitfund yesno
label values chitfundbelongerdummy yesno
order dummychitfund, before(chitfundbelongerdummy)

*Savings
rename dummysavingaccount savingsownerdummy
bysort HHID2010: egen dummysavingaccount=sum(savingsownerdummy)
replace dummysavingaccount=1 if dummysavingaccount>1
label values dummysavingaccount yesno
label values savingsownerdummy yesno
order dummysavingaccount, before(savingsownerdummy)

*Insurance
rename dummyinsurance insuranceownerdummy
bysort HHID2010: egen dummyinsurance=sum(insuranceownerdummy)
replace dummyinsurance=1 if dummyinsurance>1
label values dummyinsurance yesno
label values insuranceownerdummy yesno
order dummyinsurance, before(insuranceownerdummy)




*Panel
preserve
use"ODRIIS-indiv_wide", clear
restore

merge 1:m HHID2010 INDID2010 using "ODRIIS-indiv_wide.dta", keepusing(name2010 age2010 sex2010 caste2010 jatis2010 name2016 agecorr2010 castecorr2010 jatiscorr2010)
keep if _merge==3
drop _merge


order HHID2010 INDID2010 name age sex jatis caste name2010 name2016 agecorr2010 age2010 sex2010 castecorr2010 jatiscorr2010 caste2010 jatis2010

preserve
keep HHID2010 caste caste2010 castecorr2010
duplicates drop
ta caste
ta caste2010
ta castecorr2010
restore

ta sex
ta sex2010
decode sex, gen(sextest)
gen pb=1 if sextest!=sex2010
order HHID2010 INDID2010 name sex sextest sex2010 pb
sort pb HHID2010 INDID2010

drop name2010 name2016 agecorr2010 age2010 sex2010 castecorr2010 jatiscorr2010 caste2010 jatis2010

order HHID2010 INDID2010 village villagearea householdid address religion jatis caste comefrom outsider name sex relationshiptohead age

fre sex
replace sex=1 if HHID2010=="VENGP179" & INDID2010=="F3"
fre sex

save"CLEAN\RUME-HH.dta", replace
****************************************
* END

