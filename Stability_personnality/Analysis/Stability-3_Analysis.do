cls

/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
October 25, 2021
-----
Stability over time of personality traits
-----

-------------------------
*/


****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\Research-Stability_skills\Analysis"
cd"$directory"
global git "C:\Users\Arnaud\Documents\GitHub"

*Fac
*cd "C:\Users\anatal\Downloads\_Thesis\Research-Skills_and_debt\Analysis"
set scheme plotplain

*global git "C:\Users\anatal\Downloads\GitHub"
*global dropbox "C:\Users\anatal\Downloads\Dropbox"
*global thesis "C:\Users\anatal\Downloads\_Thesis\Research-Skills_and_debt\Analysis"


****************************************
* END


/*
Je vois, a priori, 3 sources de biais à vérifier:
les questions plus mal compris que d'autres
les enquêtés (age, caste, sex, education, village, expo au covid, etc.)
les enquêteurs


EFA et congruence tucker

reg biais

correlation

test-retest measure pour la reliability des data
*/




****************************************
* 1. ACQUIESCENCE BIAS
****************************************
use"panel_stab_v2", clear
keep if panel==1


********** Graph
stripplot ars3, over(time) separate(caste) ///
cumul cumprob box centre vertical refline /// 
xsize(4) xtitle("") xlabel(,angle(0))  ///
ylabel(0(.2)1.6) ymtick(0(.1)1.7) ytitle("") ///
msymbol(oh oh oh) mcolor(ply1 plr1 plb1) 

/*
Ok, on voit bien que le biais est beaucoup plus élevé en 2020-21 qu'en 2016
*/
preserve
keep if year==2016
stripplot ars3, over(username) separate() ///
cumul cumprob box centre vertical refline /// 
xsize(4) xtitle("") xlabel(,angle(45))  ///
ylabel(0(.2)1.6) ymtick(0(.1)1.7) ytitle("") ///
msymbol(oh oh oh) mcolor(ply1 plr1 plb1) 
restore

preserve
keep if year==2020
stripplot ars3, over(username) separate() ///
cumul cumprob box centre vertical refline /// 
xsize(4) xtitle("") xlabel(,angle(45))  ///
ylabel(0(.2)1.6) ymtick(0(.1)1.7) ytitle("") ///
msymbol(oh oh oh) mcolor(ply1 plr1 plb1) 
restore



********** OLS
use"panel_stab_v2_wide", clear

mdesc ars32020 ars32016 username_code2020 age2020 sex2020 caste2020 edulevel2020 mainocc_occupation_indiv2020 assets2020 annualincome_HH2020 villageid2020

reg ars2016 ib(freq).username_code2016, baselevels

fre username_code2020
reg ars2020 ib(freq).username_code2020, baselevels

reg ars32020 ars32016 ib(freq).username_code2020 age2020 i.sex2020 ib(freq).jatis2020 ib(freq).edulevel2020 ib(freq).mainocc_occupation_indiv2020 assets2020 annualincome_HH2020 ib(freq).villageid2020, baselevels



********** Simple difference pour le biais
use"panel_stab_v2_wide", clear

gen simplediff_ars3=ars32020-ars32016
tabstat simplediff_ars3, stat(n mean sd p50 min max range)
dis .05*2.428572
*.1214286

gen simplediff_cat_ars3=.
replace simplediff_cat_ars3=1 if simplediff_ars3<-0.1214286 & simplediff_ars3!=.
replace simplediff_cat_ars3=2 if simplediff_ars3>=0.1214286 & simplediff_ars3<=0.1214286 & simplediff_ars3!=.
replace simplediff_cat_ars3=3 if simplediff_ars3>0.1214286 & simplediff_ars3!=.

fre simplediff_cat_ars3

stripplot simplediff_ars3, over(caste2020) separate(sex2020) ///
cumul cumprob box centre vertical refline /// 
xsize(4) xtitle("") xlabel(,angle(45))  ///
ylabel() ymtick() ytitle("") ///
msymbol(oh oh oh) mcolor(ply1 plb1 plr1) 




esttab res_2016 using "_reg.csv", ///
	cells("b(fmt(3)star)" "se(fmt(3)par)") /// 
	star(* 0.10 ** 0.05 *** 0.01) ///
	drop() ///
	legend label varlabels(_cons constant) ///
	stats(N r2 r2_a p, fmt(0 3 3 3) labels(`"Observations"' `"\$R^2$"' `"Adjusted \$R^2$"' `"p-value"')) ///
	replace	
	
preserve
import delimited "_reg.csv", delimiter(",") varnames(nonames) clear
qui des
sca def k=r(k)
forvalues i=1(1)`=scalar(k)'{
replace v`i'=substr(v`i',3,.)
replace v`i'=substr(v`i',1,strlen(v`i')-1)
}
export excel using "OLS_username.xlsx", sheet(Class2016,replace)
restore

esttab res_2020 using "_reg.csv", ///
	cells("b(fmt(3)star)" "se(fmt(3)par)") /// 
	star(* 0.10 ** 0.05 *** 0.01) ///
	drop() ///
	legend label varlabels(_cons constant) ///
	stats(N r2 r2_a p, fmt(0 3 3 3) labels(`"Observations"' `"\$R^2$"' `"Adjusted \$R^2$"' `"p-value"')) ///
	replace	
	
preserve
import delimited "_reg.csv", delimiter(",") varnames(nonames) clear
qui des
sca def k=r(k)
forvalues i=1(1)`=scalar(k)'{
replace v`i'=substr(v`i',3,.)
replace v`i'=substr(v`i',1,strlen(v`i')-1)
}
export excel using "OLS_username.xlsx", sheet(Class2020,replace)
restore

estimates clear



****************************************
* END
