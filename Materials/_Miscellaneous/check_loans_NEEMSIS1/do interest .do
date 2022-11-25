/*variables cles creees pour calculer les divers taux:
-loan_months: duration (la variable month_repaid est utilisee pour divers checks + pour loan_months pour les microcredits)
- included, outlier_yrate: loans included in the analysis of debt service and interest rates respectively
- yratepaid : annualized interest rate paid
- hh_tot_income2 pour revenu: household level. labour (with some cleaning on annualincome) + remittances + pensions. 5 hh excluded due to issue about income.
- debt/interest service to income ratios: *debt_burden*, "interest_burden* 
(- dsr/isr:  debt/interest service to income ratios with the sum of annualincome as hh income variable, to compare)
*/



cd "C:\Users\Elena\Documents\these\neemsis\interest2"

**************************************************************************************************************************************************
******************************** CONSTITUTION BASE LOANS: gold loans + other loans, submission date, lender types
**************************************************************************************************************************************************

use "NEEMSIS-HH", clear

** CLEANING
*10 cases: goldquantity<goldquantitypledge => I assumed that respondent gave the unpledged quantity of gold when answering total quantity
*verif coherence goldquantitypledge/goldamountpledge: qq cas ou semble etre en sovereign. Une correction: 24 grams pledged:
replace goldamountpledge=35000 if goldamountpledge==350005


**APPEND
keep if goldquantitypledge!=.
keep  HHID INDID goldamountpledge 
rename goldamountpledge loanamount
gen loanlender=6
gen loansettled=0
gen loanbalance=loanamount
append using  "NEEMSIS-loans_mainloans.dta"

save "ALL-LOANS.dta", replace

clear
*je ne m'en sortais pas avec le format de la date de soumission donc je suis passee  par excel pour me simplifier la vie et virer l heure:
import delimited submdate.csv

gen sub3=date(submissiondate, "DMY")
format sub3 %td

rename hhid HHID 
rename indid INDID
merge m:m HHID INDID using "ALL-LOANS"

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                         1,760
        from master                     1,760  (_merge==1)
        from using                          0  (_merge==2)

    matched                             2,046  (_merge==3)
    -----------------------------------------
*/
keep if _merge==3
drop _merge

*487 households, 2046 loans

rename HHID parent_key
rename INDID namenumber


*LENDER VARIABLE

****** LENDER VARIABLES

** grouping types in fewer categories:
gen lender2=.
replace lender2=1 if loanlender==1
replace lender2=2 if loanlender==2
*labour relation in one cat: employer, maistry, colleagues (few cases of colleagues)
replace lender2=3 if loanlender==3 | loanlender==4 | loanlender==5 
replace lender2=4 if loanlender==6
replace lender2=5 if loanlender==7
replace lender2=6 if loanlender==8
replace lender2=7 if loanlender==9
*SHG & group finance in the same category"
replace lender2=8 if loanlender==10 | loanlender==14
*Banks, coop banks and sugar mill loans (2 cases) in the same category:
replace lender2=9 if loanlender==11 | loanlender==12 | loanlender==13
label define lender2 1 "Well known pp" 2 "Relatives" 3 "Labour relation(employer/maistry/colleague)" 4 "Pawn broker" 5 "Shop keeper" 6 "Moneylenders" 7 "Friends" 8"SHG/Group fin" 9 "Banks", replace
label values lender2 lender2

** including relationship to the lender:
gen lender3=lender2
replace lender3=3 if lenderrelation=="1" |lenderrelation=="1 5"| lenderrelation=="1 7" |lenderrelation=="1 8" | lenderrelation=="1 8 10" | lenderrelation=="1 9"
replace lender3=7 if lenderrelation=="10" | lenderrelation=="3 10"
replace lender3=8 if lenderrelation=="11" | lenderrelation=="6"
replace lender3=2 if lenderrelation=="2" | lenderrelation=="2 3" | lenderrelation=="2 5"
*nvle var: neighbor
replace lender3=10 if lenderrelation=="5" | lenderrelation=="5 8"
label define lender3 1 "Well known" 2 "Relatives" 3 "Labour" 4 "Pawn broker" 5 "Shop keeper" 6 "Moneylenders" 7 "Friends" 8 "Microcredit" 9 "Bank" 10 "Neighbor"
label values lender3 lender3
tab lender3

*correction of the moneylenders category with info from the main loan variable "lendername" 
gen lender4=lender3
replace lender4=8 if  lendername=="Ujjivan" | lendername=="Ujjivan finence" | lendername=="Ujjivan5" | lendername=="Baroda bank" | lendername=="Bwda finance" | lendername=="Bwda" | lendername=="Danalakshmi finance" | lendername=="Equitos finance" | lendername=="Equitos" | lendername=="Equidos" | lendername=="Ekvidas" | lendername=="Eqvidas"
replace lender4=8 if lendername=="Fin care" | lendername=="HDFC" | lendername=="Hdfc" | lendername=="Logu finance" | lendername=="Loki management" | lendername=="Muthood fincorp" | lendername=="Muthoot finance" | lendername=="Muthu  Finance" | lendername=="Pin care" | lendername=="Rbl (finance)" | lendername=="Sriram finance" | lendername=="Sriram fainance" 
replace lender4=8 if lendername=="Mahendra finance" | lendername=="Mahi ndra finance" 
replace lender4=1 if lendername=="Therinjavanga" 
replace lender4=8 if lendername=="Sundaram finance" |  lendername=="Mahi ndra financeQ" | lendername=="Maglir Mandram"
replace lender4=8 if lendername=="Muthu  Finance" |  lendername=="Logu finance" |  lendername=="Rbl (finance)" |  lendername=="Sriram finance" |  lendername=="Sundaram finance" 
label values lender4 lender3
label var lender4 "version def (lendername)"

save "ALL-LOANS", replace



**********************************************************************************************************************************************************
****************************************************** CLEANING
**********************************************************************************************************************************************************


*NB MONTHS SINCE THE LOAN WAS TAKEN (unavailable for advances and gold loans)

gen diff_month=(sub3-loandate)/(365/12)

*diff_month==-7.4958906:
replace diff_month=4.504109 if parent_key=="uuid:6c722d1f-d5fa-4d1b-aab9-9f6e8d3bcabd" &	namenumber==2& loanid==1	
*diff_month==-6.969863:
replace diff_month=5.030137 if parent_key=="uuid:8f9bf965-cb33-4354-a047-cb029a2a43a5" & namenumber==4	& loanid==1	

*difference en mois entre interview et loandate arrondie a l entier inferieur 
gen months=floor(diff_month)


*********************************************************************************
****************** CLEANING coherence VALUES INTERESTPAID/PRINCIPALPAID/TOTALREPAID

gen test=totalrepaid-principalpaid - interestpaid

*valeurs 55,66 enregistres a la place de missing value
replace interestpaid=. if interestpaid==55 | interestpaid==66
replace principalpaid=. if principalpaid==55 | principalpaid==66 
replace totalrepaid=. if totalrepaid==66

replace interestpaid=totalrepaid - principalpaid if parent_key=="uuid:03448664-46ca-4519-8209-de355a7e8b31" & namenumber==1 & loanid==1
replace interestpaid=9000 if parent_key=="uuid:0f421b5c-b081-416c-a8ca-93c430d0961e" &	namenumber==1 &	loanid==1
replace interestpaid=9000 if parent_key=="uuid:8d63df0f-1b86-4f3a-97fc-2abcf338f8bf" &	namenumber==2 &	loanid==1
replace interestpaid=20000 if parent_key=="uuid:9f14556f-8aa4-42d1-a8e8-d82f3d40e3d3" &	namenumber==5 &	loanid==1

replace interestpaid=14400 if parent_key=="uuid:0595322c-603f-4c45-a333-9f80c0c140fc" &	namenumber==1 &	loanid==2
replace interestpaid=50000 if parent_key=="uuid:dfe09e8d-99df-4b37-a4db-e9343d9a9f13" &	namenumber==1 &	loanid==1
replace interestpaid=18000 if parent_key=="uuid:78817304-5ca2-42d3-9b67-843366b5afde" &	namenumber==1 &	loanid==2
replace interestpaid=1424 if parent_key=="uuid:e847a4d4-ea2a-4a01-95f2-25a37de516e9" &	namenumber==2 &	loanid==1
replace interestpaid=totalrepaid if parent_key=="uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006" &	namenumber==1 &	loanid==1
replace interestpaid=totalrepaid if parent_key=="uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006" &	namenumber==1 &	loanid==2
replace principalpaid=200000 if parent_key=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	namenumber==1 &	loanid==3
*instead of 1800:
replace principalpaid=18000 if parent_key=="uuid:4e3a8d00-0083-47ce-8acc-4e9e305d68b4" &	namenumber==1 &	loanid==3
*looks like a 3 paisa loan, with interest paid monthly on 14 month out of 19:
replace interestpaid=totalrepaid if parent_key=="uuid:ebfb1d75-ba54-49a7-a324-affb036c88aa" &	namenumber==1 &	loanid==1
*5 et 4 pe intervertis: (9*500=4500)
replace interestpaid=4500 if parent_key=="uuid:9fa560ab-71a7-41c5-bdaf-d53da0ad3848" &	namenumber==1 &	loanid==3

/******for loans that are not microcredit: quand difference entre interest+principal et totalrepaid, ,
privilegie breakdown interest/principal sinon pb pour attribuer la difference dans les deux cat*/
replace totalrepaid=interestpaid+principalpaid if parent_key=="uuid:3f2b9b0a-a483-4214-9970-f9e2ce19dd2f" &	namenumber==1 &	loanid==1
replace totalrepaid=interestpaid+principalpaid if parent_key=="uuid:45b98913-fe19-44bd-b909-b41246240c8a" &	namenumber==1 &	loanid==2
replace totalrepaid=interestpaid+principalpaid if parent_key=="uuid:581b659f-1eb0-42d9-90fd-24779962d15c" &	namenumber==1 &	loanid==1
replace totalrepaid=interestpaid+principalpaid if parent_key=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" &	namenumber==2 &	loanid==4
replace totalrepaid=interestpaid+principalpaid if parent_key=="uuid:49eaa858-d375-4342-b04c-8ccffa93ea76" &	namenumber==1 &	loanid==2
replace totalrepaid=interestpaid+principalpaid if parent_key=="uuid:78ace2c6-a0cf-4eb9-8e2e-aa724df3b886" &	namenumber==1 &	loanid==1
replace totalrepaid=interestpaid+principalpaid if parent_key=="uuid:b1974dc2-aad3-49fd-bc31-87bd66179c60" &	namenumber==1 &	loanid==1
replace totalrepaid=interestpaid+principalpaid if parent_key=="uuid:e93eca4e-a0b4-491a-8095-eaf70f0305c2" &	namenumber==1 &	loanid==1


******microcredits:
/* 14 months have been repaid. with totalrepaid, seems to repay 1100 per month. [with interest+principal=1177. let s consider 1100 (probable that was easier to add the monthly payments than distinguish between interest and principal]
means for 24 months, a total interest of 32%, which seems plausible. 
if we abandon the fact that interest may be repaid at the beginning: means 267 interest monthly on average (276 declared) and 833 pincipal
*ie principal: 833*14=11662 (declared: 12614); interest 3728 (3864 declared)*/
replace interestpaid=3728 if parent_key=="uuid:4ab064bb-3340-4bb9-8fe9-933e36cf60e2" &	namenumber==2 &	loanid==2
replace principalpaid=11662 if parent_key=="uuid:4ab064bb-3340-4bb9-8fe9-933e36cf60e2" &	namenumber==2 &	loanid==2

/*6 month old, seems to have repaid 4 months. (interestpaid=356, interestloan=89)
interest+principal=3728 (vs 3428 totalrepaid) => 932 monthly (vs 857, et 3072 principal); principal 843 monthly (vs 768. 20 000/24=833)
albeit total repaid may be more reliable than the breakdown, here it seems that leads to 26 months of settlement, unusual. in both cases, around 12% interest*/
replace totalrepaid=3728 if parent_key=="uuid:9dc44802-170f-4aa6-9c19-f633fe8eafc2" &	namenumber==1 &	loanid==5



****** INTERESTPAID/PRINCIPALPAID RECORDED BUT TOTALREPAID=ONLY PRINCIPALPAID/INTERESTPAID (temporarily excluded, but solved below with loanbalance)

******interest payment is recorded, but total repaid=only principal (3 cases)
/*well known person loan contracted 5 years ago with monthly interestloan 2500; totalrepaid (62500)=roughly principalpaid (65000) 
=> plausible that the interest recorded (that is 19*2500) was paid*/
replace totalrepaid=principalpaid+interestpaid if parent_key=="uuid:127cd654-d8fe-470e-811c-f322957b8a1c" &	namenumber==1 &	loanid==3
/*5 year old loan of vehicle financier: amount 400 000, to be repaid monthly
interestfreq=fixed amount, worth 3000. unlikely. total interestpaid declared=63000 (ie 3000*21)
=> likely that both  principal and declared interestpaid have been paid*/
replace totalrepaid=principalpaid+interestpaid if parent_key=="uuid:7f35c399-5e9d-4d1c-bca8-669afdb94697" &	namenumber==1 &	loanid==1
*well known person, but looks like a thandal: weekly, fixed amount interest of 10% (3000 out a loan of 30 000). 
*repay duration=20, and 8 weeks repaid, and (27000/20)*8=10800. principal paid recorded=10400 
replace totalrepaid=principalpaid+interestpaid if parent_key=="uuid:22697a91-f33b-4983-809b-c4cfd2041a6f" & namenumber==1 & loanid==4

******principal payment is recorded, but total repaid=only interest (7cas)
gen diff_tot_i=totalrepaid-interestpaid
gen iok_pabs=0
replace iok_pabs=1 if diff_tot_i==0 & principalpaid!=0 & test<-200


******principal payment is recorded, but total repaid=only interest, AND: principal repaid=loanamount but the loan is marked unsettled (4 cas)
gen diff_loan_p=loanamount-principalpaid
gen iok_set=0
replace iok_set=1 if diff_tot_i==0 & diff_loan_p==0 & test<-200






********************************************************************************
********************************** MISSING VALUES 

replace interestpaid=totalrepaid-principalpaid if parent_key=="uuid:e847a4d4-ea2a-4a01-95f2-25a37de516e9" &	namenumber==2 &	loanid==2
replace interestpaid=totalrepaid-principalpaid if parent_key=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	namenumber==1 &	loanid==1
replace interestpaid=totalrepaid-principalpaid if parent_key=="uuid:bd0c2b2a-5af6-424e-9448-bab856ba25f2" &	namenumber==1 &	loanid==3
replace principalpaid=totalrepaid-interestpaid if parent_key=="uuid:b95c98da-ac19-4b3d-92f5-57ec528ce4cf" *	namenumber==1 &	loanid==1
replace interestpaid=0 if parent_key=="uuid:2d42097c-1f31-4bb8-9a08-7bfac56c60aa" &	namenumber==1 &	loanid==1
replace interestpaid=0 if parent_key=="uuid:ffefbaf9-67e2-4a91-b067-c7e1aa134efa" &	namenumber==1 &	loanid==2


replace interestpaid=0 if totalrepaid==0 & interestpaid==. & dummyinterest==1
replace principalpaid=0 if totalrepaid==0 & principalpaid==.

replace principalpaid=0 if totalrepaid==interestpaid & principalpaid==. & totalrepaid!=. & loanbalance==loanamount


*loan contracted the month of interview, interest principal totalrepaid are missing, may not have started to repay
replace interestpaid=0 if parent_key=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" &	namenumber==1 &	loanid==3
replace principalpaid=0 if parent_key=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" &	namenumber==1 &	loanid==3
replace totalrepaid=0 if parent_key=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" &	namenumber==1 &	loanid==3 
*microcredit loan contracted 2 month ago:  interest principal totalrepaid are missing, may not have started to repay
replace interestpaid=0 if parent_key=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" &	namenumber==1 &	loanid==2
replace principalpaid=0 if parent_key=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" &	namenumber==1 &	loanid==2
replace totalrepaid=0 if parent_key=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" &	namenumber==1 &	loanid==2
*2 year old bank loan but declare that totalrepaid=0:
replace interestpaid=0 if parent_key=="uuid:b95c98da-ac19-4b3d-92f5-57ec528ce4cf" &	namenumber==4 &	loanid==1
replace principalpaid=0 if parent_key=="uuid:b95c98da-ac19-4b3d-92f5-57ec528ce4cf" &	namenumber==4 &	loanid==1

***loan less than 1 year old with yearly interest
replace interestpaid=0 if parent_key=="uuid:06a570a1-916a-419d-a8ae-5912a8d9002f" &	namenumber==1 &	loanid==1

***principal missing but totalrepaid=interestpaid
gen temp=totalrepaid-interestpaid
replace principalpaid=0 if principalpaid==. & temp==0

***interest missing but principalpaid=0 et totalrepaid=0
*1 loan of banker, interest to be repaid every six month, loan is less than 6 month old
replace interestpaid=0 if parent_key=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" &	namenumber==4 &	loanid==8


*NE FONCTIONNE PAS CAR JE NAI PAS LA VARIABLE EN QUESTION
* loans (by well known person) with interest to be paid yearly, but loan less than 1 year old
replace interestpaid=0 if interestfreq==3 & diff_month<12 & diff_month!=. & dummyinterest==1 & interestpaid==. & principal==0 & totalrepaid==0 



***interestpaid missing but principalpaid=0 et totalrepaid=0 (12 cases) - surprising that nothing has been paid in some cases (2-3 years) but may be possible
replace interestpaid=0 if dummyinterest==1 & interestpaid==. & principal==0 & totalrepaid==0 




***VARIABLE: 
/*bwda microcredit: 20 000 for 24 months. 13 month old. 20 000/24=around 833 monthly. 
interestloan=866: too large. interestpaid=10392, ie around 800 monthly. too large even if assuming that only interest has been paid since the beginning.
principal repaid: 10008. that is roughly 770 monthly.=> unable to impute*/
gen weird=0
replace weird=1 if parent_key=="uuid:390905c9-ee49-4e1e-8a4a-80e4741b7140" &	namenumber==1 &	loanid==2
/* 2 year old well known person loan: amount 500 000. yearly interest 15 0000 (0,03 yearly, quite cheap), total repaid 645 000, unsettled. 
=> the amount repaid declared seem far too big??
maybe an interest of 150 000 yearly (30% yearly)? would make something like 445000 interest, 200 000 principal, but cannot tell*/
replace weird=1 if parent_key=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	namenumber==1 &	loanid==2
*same issue: 2 year  old well knwon person loan: amount 400 000, 12 000 yearly interest (0,03 yearly),totalrepaid==588000:
replace weird=1 if parent_key=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	namenumber==1 &	loanid==1

*rien ne fait grand sens sur principalpaid, totalrepaid, loanbalance...
replace weird=1 if parent_key=="uuid:dbc0eae9-310c-42d5-b1d8-e7d15a51a784" &	namenumber==2 &	loanid==1

*emprunte 100 000: deux semaines plus tard, a paye 40 000 interet 60 000 principal. ???
replace weird=1 if parent_key=="uuid:cd65012a-e5b1-4f92-8eed-50ba485b62da" &	namenumber==2 &	loanid==1


************ VARIABLES
gen excl_interest=0
replace excl_interest=1 if dummyinterest==. |  iok_set==1 | iok_pabs==1 | weird==1 | interestpaid==. & dummyinterest==1 & weird==0

gen excl_debtservice=0
replace excl_debtservice=1 if dummyinterest==. |  iok_set==1 | iok_pabs==1 | weird==1 




***********************************************************************************
*************************************** INTEREST BEARING LOAN

*2 microcredits whose repayement has not started and recorded as without interest
replace dummyinterest=1 if lender4==8 & dummyinterest==0




*********************************************************************************
**************************************** ABERRANT VALUES OF INTEREST

*loan of 68 INR (for agri), repayduration2=12, yearly interest 1140 - idem loanbalance=68
* peut etre 68 lakh ? mais fait beaucoup. (ferait sens avec 68 000 - ie 1,7 % yearly interest, plausible pour une coop bank) 
* j ai remplace par 68 000 ici mais peut etre faudrait il mieux l exclure
replace loanamount=68000 if parent_key=="uuid:d4ece943-b0c3-457c-8328-68333afaab41" &	namenumber==1 &	loanid==1
replace loanbalance=68000 if parent_key=="uuid:d4ece943-b0c3-457c-8328-68333afaab41" &	namenumber==1 &	loanid==1

*interestloan 1500, 1-2 month old: 30 000 interestpaid
replace interestpaid=3000 if parent_key=="uuid:6ba477f3-8785-4191-a5da-9af17186dfe5" &	namenumber==3 &	loanid==6
replace totalrepaid=3000 if parent_key=="uuid:6ba477f3-8785-4191-a5da-9af17186dfe5" &	namenumber==3 &	loanid==6
*interestloan 1 200, 2 month old: 20 000 interestpaid
replace interestpaid=2000 if parent_key=="uuid:a049567e-1188-4e9a-8875-4dce306cffdf" &	namenumber==1 &	loanid==2
replace totalrepaid=2000 if parent_key=="uuid:a049567e-1188-4e9a-8875-4dce306cffdf" &	namenumber==1 &	loanid==2
*interestloan 1 800, 1 month old: 10 000 interestpaid (pay interest whenever have money)
replace interestpaid=1000 if parent_key=="uuid:a80735af-38ec-4daa-aca0-4c87c64ea92f" &	namenumber==1 &	loanid==1
replace totalrepaid=1000 if parent_key=="uuid:a80735af-38ec-4daa-aca0-4c87c64ea92f" &	namenumber==1 &	loanid==1

*moneylenders loan: (completement outliers) enleve un 0 pour tomber sur des taux a 3 paisa au lieu de 30% par mois
replace interestpaid=1500 if parent_key=="uuid:30187ee9-dd3b-4a82-b20f-6ec0db908a4c" &	namenumber==1 &	loanid==1
replace interestloan=150 if parent_key=="uuid:30187ee9-dd3b-4a82-b20f-6ec0db908a4c" &	namenumber==1 &	loanid==1
replace totalrepaid=1500 if parent_key=="uuid:30187ee9-dd3b-4a82-b20f-6ec0db908a4c" &	namenumber==1 &	loanid==1
*idem pour un well-known person:
replace interestpaid=10800 if parent_key=="uuid:a049567e-1188-4e9a-8875-4dce306cffdf" &	namenumber==1 &	loanid==1
replace interestloan=450 if parent_key=="uuid:a049567e-1188-4e9a-8875-4dce306cffdf" &	namenumber==1 &	loanid==1
replace totalrepaid=10800 if parent_key=="uuid:a049567e-1188-4e9a-8875-4dce306cffdf" &	namenumber==1 &	loanid==1

*interestpaid=0 instead of 1:
replace interestpaid=0 if parent_key=="uuid:877d0560-5981-491b-b780-6585bf924814" &	namenumber==1 &	loanid==1



/*************************************************************************************
**************************************** CHECK TEMPORALITY OF INTEREST PAYMENT (put value 7 when does not really fall in a precise category)
									+ TEST: compute the precise number of months of interest repaid (using interestloan and interestpaid) 
to check for aberrant values of interest (not taking into account the fact that some monthly repayments may have been forgotten)
=> aim: check for dubious values(to be followed later by test for outliers with the "real" duration - not a good way to do, need to mix the two)
precise number of months will then be kept only for microcredit
for the others, repayduration2 will be tested and if not usable, time between survey and loan is used*/



**** MONTLY REPAYMENT (repayduration1 & interestfreq) 

gen month_repaid=.
replace month_repaid=interestpaid/interestloan if months<=12 & excl_interest==0  & dummyinterest==1 & repayduration1==2 & interestfreq==2
*comme remboursement microcredit reguliers:
replace month_repaid=interestpaid/interestloan if months>12 & months!=. & lender4==8

replace month_repaid=months if parent_key=="uuid:ccf91767-f881-4a7c-b80a-625bde97a4d1" &	namenumber==1 &	loanid==3
replace month_repaid=3 if parent_key=="uuid:c2d03ebc-5c0e-415a-a655-001859f7a68f" *	namenumber==5 &	loanid==1
replace interestpaid=580 if parent_key=="uuid:2fed18dd-dce7-44ce-821b-164c65a718b9" &	namenumber==2 &	loanid==1
replace month_repaid=5 if parent_key=="uuid:2fed18dd-dce7-44ce-821b-164c65a718b9" &	namenumber==2 &	loanid==1
/*microcredit: avec le calcul du monthly instalment aec total repaid + interest loan:
(les deux concordent:  total interest sur 2 ans avec total repaid: 75%. total interest avec interestloan: 75%)*/
replace principalpaid=7506 if parent_key=="uuid:a0c7053d-b228-49e4-ae9e-0188603e1811" &	namenumber==1 &	loanid==2
replace interestpaid=5580 if parent_key=="uuid:a0c7053d-b228-49e4-ae9e-0188603e1811" &	namenumber==1 &	loanid==2
replace month_repaid=9 if parent_key=="uuid:a0c7053d-b228-49e4-ae9e-0188603e1811" &	namenumber==1 &	loanid==2
replace month_repaid=6 if parent_key=="uuid:e73b9bd7-f7f3-4ac0-b360-ffcd09758ff4" &	namenumber==1 &	loanid==1
replace month_repaid=7 if parent_key=="uuid:55d4d934-626c-49e7-b1ad-ee4daf8b1a4a" *	namenumber==1 &	loanid==1
replace month_repaid=10 if parent_key=="uuid:7dff3ca3-e693-4df2-a2bd-a60549a1cae7" &	namenumber==1 &	loanid==1
replace month_repaid=10 if parent_key=="uuid:c2d03ebc-5c0e-415a-a655-001859f7a68f" &	namenumber==4 &	loanid==2
gen repayduration22=repayduration2
replace repayduration22=27 if parent_key=="uuid:508123db-1452-4e98-a882-b556f8a91302" &	namenumber==1 &	loanid==1

replace month_repaid=0 if months==0 & totalrepaid==0
replace month_repaid=1 if months==0 & totalrepaid!=0 & totalrepaid!=. & repayduration1==2
replace month_repaid=0 if parent_key=="uuid:2d42097c-1f31-4bb8-9a08-7bfac56c60aa" &	namenumber==1 &	loanid==1
replace month_repaid=1 if parent_key=="uuid:544225ab-5dc2-4a81-9d0d-cd21b5d749fa" &	namenumber==1 &	loanid==3
replace month_repaid=0 if parent_key=="uuid:ffefbaf9-67e2-4a91-b067-c7e1aa134efa" &	namenumber==1 &	loanid==2
replace month_repaid=4 if parent_key=="uuid:9dc44802-170f-4aa6-9c19-f633fe8eafc2" &	namenumber==1 &	loanid==5
replace repayduration22=24 if parent_key=="uuid:9dc44802-170f-4aa6-9c19-f633fe8eafc2" &	namenumber==1 &	loanid==5


/*24 month old microcredit: interestpaid, interestloan missing; loanamount=100 000, principalpaid=70 000, totalpaid 100 0000, repayduration 24 months
unsettled. loanamount/repayduration2= roughly 4176. principalpaid/4176 = roughly 16,8.
totalrepaid/16 = 6250 (chiffre rond). principalpaid/16=4375 (idem). would mean: interestpaid=(6250-4575)*16=26800. seems plausible.*/
replace month_repaid=16 if parent_key=="uuid:8d8cacc3-38f9-4630-9719-edd639102ad0" &	namenumber==2 &	loanid==1
replace interestpaid=26800 if parent_key=="uuid:8d8cacc3-38f9-4630-9719-edd639102ad0" &	namenumber==2 &	loanid==1
replace principalpaid=totalrepaid-26800 if parent_key=="uuid:8d8cacc3-38f9-4630-9719-edd639102ad0" &	namenumber==2 &	loanid==1
replace dummyinterest=1 if parent_key=="uuid:8d8cacc3-38f9-4630-9719-edd639102ad0" &	namenumber==2 &	loanid==1


gen pb=0
***microcredits: 
*avec les instalments renseignes, le pret ne serait pas rembourse a la fin de la periode
replace pb=1 if parent_key=="uuid:b14c5315-9be2-4edf-9954-a9cee0e13162" &	namenumber==2 &	loanid==2
*idem: pour que coherence avec interestloan, il faudrait 51998 totalrepaid au lieu de 49998. mais on aurait un total d interet de 3% pour 39 mois !
replace pb=1 if parent_key=="uuid:89f0734d-db4a-4660-8c9f-c54fcd6f8ddb" &	namenumber==1 &	loanid==1
*idem: total<principal, et with interest loan, on arrive a 5% d interet poour 24 mois
*il faudrait 2083 par mois juste pour rembourser le principal; on a ici
replace pb=1 if parent_key=="uuid:0bd2d8b2-5a95-4f16-b9cc-5414151710d1" &	namenumber==1 &	loanid==1
*idem: total instalment=pile principal; et selon interest loan, on aurait un total de 5% d interet pour 17 mois
replace pb=1 if parent_key=="uuid:0742a50d-0a67-46f7-ba6b-b65092b7761b" &	namenumber==4 &	loanid==1
/*10 month old microcredit: avec interest loan (3000, a remplacer par 300): seems to have paid 10 month, but at this rythm the loan would not be settled
en se basant sur interest loan: would mean 1967 monthly, et 16% d interet pour 12 mois 
=> on pourrait potentiellement imputer completement, mais etrange que le totalrepaid ne fasse pas sens */
replace pb=1 if parent_key=="uuid:318a9c1c-e92a-4c81-bafe-eb1973e94702" &	namenumber==1 &	loanid==1
*tres etrange: 5 yearly old microcredit, with 700 yearly interest for a loan of 80 000 (0,9% pa). interestloan has been paid 5 times, but only the interest.
replace pb=1 if parent_key=="uuid:7e8b1a8c-3964-4a34-abdc-c8c605849b1f" &	namenumber==2 &	loanid==1

***autres:
*3 month old loan by relative 3 paisa (900 monthly): but 8000 paid: y a t un pb de 0 en trop ?
replace pb=1 if parent_key=="uuid:4ab064bb-3340-4bb9-8fe9-933e36cf60e2" &	namenumber==1 &	loanid==1






**** INTEREST WEEKLY REPAYMENT (interestfreq) - LESS THAN ONE YEAR:

replace month_repaid=(interestpaid/interestloan)/4 if months<=12 & excl_interest==0  & dummyinterest==1 & interestfreq==1

*bank loan: repayment interest is recorded weekly, but monthly seems more plausible with the data:
replace interestfreq=2 if parent_key=="uuid:233d292c-867e-45ef-aad1-af8ee4ef3804" &	namenumber==1 &	loanid==1
replace month_repaid=4 if parent_key=="uuid:233d292c-867e-45ef-aad1-af8ee4ef3804" &	namenumber==1 &	loanid==1
replace repayduration1=2 if parent_key=="uuid:233d292c-867e-45ef-aad1-af8ee4ef3804" &	namenumber==1 &	loanid==1



**** INTEREST ONCE IN 6 MONTHS
*16 month old friend loan: interest supposed once in 6 months, but has been paid 12 times (means 3 paisa per month for these 12 months)
replace interestfreq=2 if parent_key=="uuid:1c8ab7d5-6d4c-41eb-b440-68c930e30c72" &	namenumber==1 &	loanid==1

*interest paid more often than every six months
replace interestfreq=7 if parent_key=="uuid:8ddf086d-0993-4ff7-813b-1f63dd46b1bf" &	namenumber==1 &	loanid==1
replace interestfreq=7 if parent_key=="uuid:d1f4bc1e-b59a-4ddb-831b-266adc1ba452" &	namenumber==1 &	loanid==1
replace interestfreq=7 if parent_key=="uuid:e804beec-7f01-4be3-88d9-fa9ad870149a" &	namenumber==1 &	loanid==2
replace interestfreq=7 if parent_key=="uuid:f2a2808d-0a25-4b77-ac03-c50c501987c2" &	namenumber==1 &	loanid==2


**** INTEREST FIXED AMOUNT
**compare when interestloan different from interestpaid (supposed to be the same if fixed amount):

*4 year old loan with interestloan paid 4 times
replace interestfreq=3 if parent_key=="uuid:2fd71d69-8643-44bc-93f5-8ea6b8289cf8" &	namenumber==1 &	loanid==2

*12 month old bank loan with interestloan paid 12 times
replace interestfreq=2 if parent_key=="uuid:3f9cffe9-c7a8-4057-afd6-b2e14e4a36b8" &	namenumber==1 &	loanid==2

*19 month old moneylender loan with interestloan paid 15 times
replace interestfreq=2 if parent_key=="uuid:ebfb1d75-ba54-49a7-a324-affb036c88aa" &	namenumber==1 &	loanid==1
replace month_repaid=15 if parent_key=="uuid:ebfb1d75-ba54-49a7-a324-affb036c88aa" &	namenumber==1 &	loanid==1
 
*microcredits, weekly or monthly
replace interestfreq=1 if parent_key=="uuid:88f78363-66a3-4359-8e33-af913f9b5699" &	namenumber==1 &	loanid==2
replace month_repaid=13 if parent_key=="uuid:88f78363-66a3-4359-8e33-af913f9b5699" &	namenumber==1 &	loanid==2
replace interestfreq=2 if parent_key=="uuid:d32ae647-fc9a-40bf-8161-5919a7a1e6ea" & namenumber==1 &	loanid==1
replace month_repaid=25 if parent_key=="uuid:d32ae647-fc9a-40bf-8161-5919a7a1e6ea" & namenumber==1 &	loanid==1
replace interestfreq=2 if parent_key=="uuid:e847a4d4-ea2a-4a01-95f2-25a37de516e9" &	namenumber==2 &	loanid==1
replace month_repaid=4 if parent_key=="uuid:e847a4d4-ea2a-4a01-95f2-25a37de516e9" &	namenumber==2 &	loanid==1

/*IMPUTATION UN PEU DOUTEUSE, a voir si exclure:
microcredit:with repayduration(24 month) and instalments deducted from totalrepaid, would mean more than 100% interest
and with interestloan and interestpaid, would mean 7% interest in total on the 24 months 
--> if consider that repayduration=12 months, with instalments from total repaid, would mean 11%*/
replace interestfreq=2 if parent_key=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	namenumber==1 &	loanid==1
replace repayduration22=12 if parent_key=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	namenumber==1 &	loanid==1
replace interestpaid=193 if parent_key=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	namenumber==1 &	loanid==1
replace principalpaid=1667 if parent_key=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	namenumber==1 &	loanid==1
replace month_repaid=1 if parent_key=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	namenumber==1 &	loanid==1

/*65 month old moneylender loan with interestloan paid 21 times: peut etre monthly or whenever have money
->  l essentiel est que ce ne soit pas enregistre en fixed amount, ajout d une valeur dans interestfreq*/
replace interestfreq=7 if parent_key=="uuid:7f35c399-5e9d-4d1c-bca8-669afdb94697" & namenumber==1 &	loanid==1

*idem: 25 month old bank loan with interestloan paid roughly 13 times 
replace interestfreq=2 if parent_key=="uuid:3f9cffe9-c7a8-4057-afd6-b2e14e4a36b8" &	namenumber==1 &	loanid==1


***************** LOANS MORE THAN ONE YEAR:

**verification duree de remboursement pour microcredit
replace month_repaid=interestpaid/interestloan if lender4==8 & months>12 & months!=. & excl_interest==0 & pb==0 & repayduration1==2
*microcredit contracted 67 months before, put 18 months paid:
replace month_repaid=18 if parent_key=="uuid:89f0734d-db4a-4660-8c9f-c54fcd6f8ddb" &	namenumber==1 &	loanid==2

*IMPOSSIBLE DE FAIRE SENS DE REPAYDURATION2 (nb months repaid or total duration of the loan)




*YEARLY INTEREST

*6 year old loan, interest loan paid 12 times:
replace interestfreq=4 if parent_key=="uuid:059ce108-5334-44cd-840c-2e160267046b" &	namenumber==1 &	loanid==1
*32 month old loan, interestloan paid 20 times:
replace interestfreq=7 if parent_key=="uuid:61facd1e-9777-4333-8ec1-f00d45042f60" &	namenumber==1 &	loanid==1 & loanid==1
*between 12 and 13 month old loan, interest loan paid 13 times (to be recorded below in loan_months)
replace interestfreq=2 if parent_key=="uuid:6200de71-614d-4732-91e4-b698f362a2c3" &	namenumber==1 &	loanid==1
*13 month old loan, interestloan paid 12 times (to be recorded below in loan_months)
replace interestfreq=2 if parent_key=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	namenumber==1 &	loanid==3
*44 month old loan, interestloan paid 30 times
replace interestfreq=7 if parent_key=="uuid:7ae6bf58-39d2-42ca-a4b8-4c435e1e5a1f" &	namenumber==1 &	loanid==2
*43 month old loan, interestloan paid 50 times
replace interestfreq=2 if parent_key=="uuid:7ae6bf58-39d2-42ca-a4b8-4c435e1e5a1f" &	namenumber==1 &	loanid==3
*44 month old loan, interestloan paid around 26 times
replace interestfreq=7 if parent_key=="uuid:7ae6bf58-39d2-42ca-a4b8-4c435e1e5a1f" &	namenumber==1 &	loanid==1
*30 month old loan, interestloan paid 24 times
replace interestfreq=7 if  parent_key=="uuid:8b248da2-20f8-4d33-b1f1-48b1d1756522" &	namenumber==1 &	loanid==1
*13 month old loan, interestloan paid 12 times (to be recorded below in loan_months)
replace interestfreq=2 if parent_key=="uuid:a83605b5-7618-41a2-b2b7-0838fe3503da" &	namenumber==1 &	loanid==5
*24 month old loan, interestloan paid 12 times
replace interestfreq=7 if parent_key=="uuid:ba97ea13-f20c-4518-86b9-e29e4e091ce6" &	namenumber==1 &	loanid==1
*25 month old loan, interestloan paid 12 times
replace interestfreq=7 if parent_key=="uuid:d3f50299-ac34-4600-a662-d15ba1383d6e" &	namenumber==8 &	loanid==1
*48 month old loan, interest loan paid 30 times
replace interestfreq=7 if parent_key=="uuid:e066c0e4-863e-42fe-8f9f-d52486ee5c58" &	namenumber==1 &	loanid==3
*36 month old loan, interstloan paid 20 times
replace interestfreq=7 if parent_key=="uuid:ee73e76e-b047-4e85-85fd-b3acc589d1b8" &	namenumber==1 &	loanid==3
*24 month old loan, interestloan paid 15 times
replace interestfreq=7 if parent_key=="uuid:ee73e76e-b047-4e85-85fd-b3acc589d1b8" &	namenumber==1 &	loanid==1
*24 month old, 15 times
replace interestfreq=7 if  parent_key=="uuid:ee73e76e-b047-4e85-85fd-b3acc589d1b8" &	namenumber==1 &	loanid==2
*99 month old, around 37 times
replace interestfreq=7 if parent_key=="uuid:00b05341-085a-46ad-9776-f1272b6872e6" &	namenumber==1 &	loanid==1
*15 month old, around 6 times
replace interestfreq=7 if parent_key=="uuid:521600d7-e364-42fc-8f0d-f799e74637e1" &	namenumber==1 &	loanid==5
*43 month old, around 8 times
replace interestfreq=7 if parent_key=="uuid:3502a333-6356-4267-ad32-ad6d32029c51" &	namenumber==1 &	loanid==2
/*60 month old bank loan, 10 months repaid (repayduration 36, according to interest loans: would mean 12% yearly. 
mais on ne sait pas si commence a rembourser il y a 10 mois ou 60...) */
replace interestfreq=7 if parent_key=="uuid:c2fda044-d053-47b2-b693-58d34e7f70be" &	namenumber==1 &	loanid==1
*13 month old, 10 times
replace interestfreq=2 if parent_key=="uuid:e93eca4e-a0b4-491a-8095-eaf70f0305c2" &	namenumber==1 &	loanid==1

replace interestfreq=7 if parent_key=="uuid:94e1ec13-3618-4995-bd9d-eb810d9ade40" &	namenumber==1 &	loanid==2
replace interestfreq=2 if parent_key=="uuid:c75ad8b5-c773-408f-8066-f8327ccc6bdc" &	namenumber==1 &	loanid==2
replace interestfreq=7 if parent_key=="uuid:cb4fe354-df11-45c2-b5e8-17b4ab087187" &	namenumber==1 &	loanid==1
replace interestfreq=7 if parent_key=="uuid:f7fae8d2-4c28-44bd-957a-209ed70741f3" &	namenumber==1 &	loanid==2
replace interestfreq=7 if parent_key=="uuid:5f4c151e-62e4-4f22-b88f-2aad8e3dc0f3" &	namenumber==1 &	loanid==3



*18 month old agri coop bank, 1 time paid: but loan amount 100 000, yearly interest 600... (and repayduration2=600...)
replace pb=1 if parent_key=="uuid:da893017-2541-42dc-9dab-d517d777b92b" &	namenumber==1 &	loanid==1

replace excl_interest=1 if pb==1
replace excl_debt=1 if pb==1







***************************************************************************************************************************************************************
****************************************************** ECHANTILLON & VARIABLES - FINAL
***************************************************************************************************************************************************************

********************************************************************************
************************************************ ECHANTILLON


*pour ne pas multiplier les details, on s en tient a l echantillon ou on peut calculer le debt service et l interest service
gen included=0
replace included=1 if excl_debt==0 & excl_int==0
replace included=. if dummyinterest==.

*bilan sur les prets exclus:
gen explication=""
replace explication="principalpaid recorded, but total repaid=only interest" if iok_pabs==1
replace explication="principalpaid recorded, but total repaid=only interest, AND: principal repaid=loanamount but loan unsettled" if iok_set==1
replace explication="microcredit pb instalment" if parent_key=="uuid:390905c9-ee49-4e1e-8a4a-80e4741b7140" &	namenumber==1 &	loanid==2
replace explication="microcredit pb instalment" if parent_key=="uuid:b14c5315-9be2-4edf-9954-a9cee0e13162" &	namenumber==2 &	loanid==2
replace explication="microcredit pb instalment" if parent_key=="uuid:89f0734d-db4a-4660-8c9f-c54fcd6f8ddb" &	namenumber==1 &	loanid==1
replace explication="microcredit pb instalment" if parent_key=="uuid:0bd2d8b2-5a95-4f16-b9cc-5414151710d1" &	namenumber==1 &	loanid==1
replace explication="microcredit pb instalment" if parent_key=="uuid:0742a50d-0a67-46f7-ba6b-b65092b7761b" &	namenumber==4 &	loanid==1
replace explication="microcredit pb instalment" if parent_key=="uuid:318a9c1c-e92a-4c81-bafe-eb1973e94702" &	namenumber==1 &	loanid==1
replace explication="what has been repaid is quite higher than expected from interestloan and loanamount, and loan still unsettled" if parent_key=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	namenumber==1 &	loanid==2 | parent_key=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	namenumber==1 &	loanid==1
replace explication="incoherence between interestloan, interestpaid and duration" if parent_key=="uuid:4ab064bb-3340-4bb9-8fe9-933e36cf60e2" &	namenumber==1 &	loanid==1
replace explication="totalrepaid recorded, not interestpaid" if parent_key=="uuid:142053fe-243a-4035-8746-93dd30108d22" &	namenumber==1 &	loanid==2
replace explication="totalrepaid recorded, not interestpaid" if parent_key=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	namenumber==2 &	loanid==1
replace explication="interest far too low" if parent_key=="uuid:da893017-2541-42dc-9dab-d517d777b92b" &	namenumber==1 &	loanid==1
replace explication="microcredit only interest yearly paid, at a rate pa of 0,9%" if  parent_key=="uuid:7e8b1a8c-3964-4a34-abdc-c8c605849b1f" &	namenumber==2 &	loanid==1




********************************************************************************
************************************* LOAN DURATION



****FOR MONTHLY, WEEKLY, WHENEVER HAVE MONEY, OR IMPUTED AS UNCLEAR (interestfreq==7) 

/*for microcredit, since regular repayment, duration considered is the precise number of months repaid. 
for the others, difference between loan date and interview date - arrondi a l entier inferieur*/
gen loan_months=.
replace loan_months=months  if interestfreq==1 | interestfreq==2 | interestfreq==6 | interestfreq==7
replace loan_months=month_repaid if lender4==8 & interestfreq==2


*arrondi a l entier superieur sur la base de interestpaid/interestloan
replace loan_months=13 if parent_key=="uuid:6200de71-614d-4732-91e4-b698f362a2c3" &	namenumber==1 &	loanid==1
replace loan_months=12 if parent_key=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	namenumber==1 &	loanid==3
replace loan_months=12 if parent_key=="uuid:a83605b5-7618-41a2-b2b7-0838fe3503da" &	namenumber==1 &	loanid==5
replace loan_month=1 if loan_month<1 & interestfreq==2 & interestpaid!=0 |  loan_month<1 & interestfreq==6 & interestpaid!=0
replace loan_month=2 if parent_key=="uuid:6ba477f3-8785-4191-a5da-9af17186dfe5" &	namenumber==3 &	loanid==6



******** USE REPAYDURATION2: 

*if repayduration2 lower than the time since the loan was contracted, may designate the actual time since repayment started (rather than loan total duration)
*consider than when answered 12, 24 or 36 months, liekly to designate the total duration

***** MONTHLY

*month_repaid (or interestpaid/interestloan) and repayduration2 coherents:
replace loan_month=repayduration2 if parent_key=="uuid:07be751d-08a0-4a5c-b1e5-9634a002969b" &	namenumber==1 &	loanid==1
replace loan_month=12 if parent_key=="uuid:3f9cffe9-c7a8-4057-afd6-b2e14e4a36b8" &	namenumber==1 &	loanid==2
replace loan_month=repayduration2 if parent_key=="uuid:62ad7210-2d2c-4e4d-a8c6-6501a63d2fee" &	namenumber==1 &	loanid==2
replace loan_month=repayduration2 if parent_key=="uuid:bb9aa5b8-af37-40d9-9fab-c6e489a9bdc8" &	namenumber==1 &	loanid==1
replace loan_month=repayduration2 if parent_key=="uuid:fb2fc753-1d99-41b9-8d73-89d27b600fd1" &	namenumber==1 &	loanid==1
replace loan_month=repayduration2 if parent_key=="uuid:fb2fc753-1d99-41b9-8d73-89d27b600fd1" &	namenumber==1 &	loanid==2
replace loan_month=repayduration2 if parent_key=="uuid:f78e2a2e-280c-4f60-b991-76b5968c4b84" &	namenumber==1 &	loanid==2
replace loan_month=repayduration2 if parent_key=="uuid:a97afa4a-6283-492c-bf11-dd9269d400da" &	namenumber==2 &	loanid==2
*56 months old; repayduration1 yearly and repayduration2=2 years, and interestfreq=monthly and 19 months of interestloan paid
replace loan_months=24 if parent_key=="uuid:127cd654-d8fe-470e-811c-f322957b8a1c" &	namenumber==1 &	loanid==3
*25 month old loan, repayduration1 yearly and repayduration2=2 years, and interestfreq=monthly and 13 months of interestloan paid
replace loan_months=24 if parent_key=="uuid:3f9cffe9-c7a8-4057-afd6-b2e14e4a36b8" &	namenumber==1 &	loanid==1
*bank loan contracted 5 years before: frequency is monthly, repayduration2=7; paid nothing
replace loan_month=repayduration2 if parent_key=="uuid:c1dc5f5e-c49f-42e2-8460-3b3e2faeb9a9" &	namenumber==1 &	loanid==1

*if difference between month_repaid and time since the loan was contracted=1 month: take month_repaid 
drop temp
gen temp=loan_months-month_repaid
replace loan_month=month_repaid if temp==1 & interestfreq==2 & totalrepaid!=0 | temp==-1 & interestfreq==2  & totalrepaid!=0
drop temp



******* YEARLY INTEREST PAYMENT


gen years=.
replace years=months/12 if interestfreq==3
gen loan_years=floor(years)

replace loan_years=repayduration2 if parent_key=="uuid:9dd01961-376f-4f5d-add7-b2af01be9107" &	namenumber==1 &	loanid==1
replace loan_years=1 if parent_key=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" &	namenumber==2 &	loanid==3

*instead of 0 (because has paid):
replace loan_year=1 if parent_key=="uuid:b6802956-c0b6-442e-b416-73d9acd4d137" &	namenumber==1 &	loanid==2
replace loan_year=1 if  parent_key=="uuid:d4ece943-b0c3-457c-8328-68333afaab41" &	namenumber==1 &	loanid==1
replace loan_year=1 if parent_key=="uuid:15a2311a-c10d-462d-8a50-29a67b91b739" &	namenumber==1 &	loanid==3

**repayduration2 missing:
*consider that when start to repay bank loan, repayment is regular (dubidous)
replace loan_year=3 if parent_key=="uuid:15a2311a-c10d-462d-8a50-29a67b91b739" &	namenumber==1 &	loanid==1




******* WEEKLY: thandal. consider that interestpaid/interestloan=nb week repaid. arrondi a l entier superieur.

gen weeks=.
replace weeks=interestpaid/interestloan if interestfreq==1
gen loan_weeks=round(weeks,1)




******** FIXED AMOUNT

**repayduration1=weekly 
replace loan_weeks=repayduration2 if parent_key=="uuid:04126475-75a2-4e1e-9f0d-a5e57163a4e6" &	namenumber==1 &	loanid==3
replace loan_weeks=months*4 if parent_key=="uuid:22697a91-f33b-4983-809b-c4cfd2041a6f" &	namenumber==1 &	loanid==4
replace loan_weeks=repayduration2 if parent_key=="uuid:f39eabe6-b8cd-4bc6-af03-f6b1bf1384eb" &	namenumber==1 &	loanid==1
*4 month old thandal. repayduration 30 weeks. 600 principal paid. with 50 weekly, 3 months repaid.
replace loan_weeks=12 if parent_key=="uuid:287cdedc-cf23-44f2-8e76-55aba844250a" &	namenumber==1 &	loanid==1

replace loan_months=months if interestfreq==5 & repayduration1==. & repayduration2==. 

*mystere: 9month old microcredit with fixed amount interest. 8 mois parait le plus plausible 
replace loan_months=8 if parent_key=="uuid:318a9c1c-e92a-4c81-bafe-eb1973e94702" &	namenumber==1 &	loanid==1

*bank, repayduration1=yearly
replace loan_year=repayduration2 if parent_key=="uuid:1b1c8141-0b67-42a1-990c-78d15a624f50" &	namenumber==1 &	loanid==1


***** ONCE IN SIX MONTHS

**si rien n a ete rembourse: duree de remboursement=temps depuis que le pret a ete contracte. pose pas de probleme pour debt service
replace loan_months=months if totalrepaid==0 & repayduration2==. & interestfreq==4
replace loan_months=months if parent_key=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" &	namenumber==4 &	loanid==8

**repayduration2 plausible:
replace loan_month=repayduration2 if parent_key=="uuid:059ce108-5334-44cd-840c-2e160267046b" &	namenumber==1 &	loanid==1
replace loan_month=repayduration2 if parent_key=="uuid:241622a1-14b6-4cdd-830e-45ea031ae1f3" &	namenumber==2 &	loanid==2

***bank loan: consider than repayments are regular when start (dubious. but seems to have a lot of delay). interestloan coherent avec repayduration2.
replace loan_month=12 if parent_key=="uuid:813a12d2-a425-496e-9441-e3991adb8c30" &	namenumber==1 &	loanid==1

***repayduration2 missing:
**12 month old loan, interest paid only one time: replace loan_month==11 (vs 12; plausible) juste pour justifier le fait que rembourse une seule fois 
replace loan_month=11 if parent_key=="uuid:0f421b5c-b081-416c-a8ca-93c430d0961e" &	namenumber==1 &	loanid==1
**bank loan: consider than repayments are regular when start (dubious. but seems to have a lot of delay)
replace loan_month=18 if parent_key=="uuid:da893017-2541-42dc-9dab-d517d777b92b" &	namenumber==1 &	loanid==2
replace loan_month=48 if parent_key=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" &	namenumber==2 & loanid==4

replace loan_month=months if parent_key=="uuid:78817304-5ca2-42d3-9b67-843366b5afde" &	namenumber==1 &	loanid==2

*74 month old loan; repayduration2=36, but interestloan repaid 72 times
replace loan_month=72 if parent_key=="uuid:059ce108-5334-44cd-840c-2e160267046b" & namenumber==1 &	loanid==1



**** INTEREST WHENEVER HAVE MONEY

*repayduration2 credible:
replace loan_month=repayduration2*12 if parent_key=="uuid:5972238d-013a-411b-8e6e-14da561e45f7" &	namenumber==1 &	loanid==2
replace loan_month=13 if parent_key=="uuid:e3d5075a-9dad-4278-a125-a2dd01cdf99b" &	namenumber==1 &	loanid==1

*interestloan paid aroudn 17 times, loan 21 month old, repay principal and interest whenever have money
replace loan_month=months if parent_key=="uuid:4e015d7e-1ce4-4f87-bc7d-a9a67c0aab86" &	namenumber==1 &	loanid==2

/*si repayduration2 seems to represent the total duration of the loan, and is far lower than the time since the loan was contracted:
to limit the downward bias, set a kind of max value for number of months repaid ie repayduration2 (si coherent)*/
replace loan_month=repayduration2 if parent_key=="uuid:584cb9e3-eb1c-4e6a-b6c7-46a58eb17e46" &	namenumber==1 &	loanid==1
replace loan_month=repayduration2 if parent_key=="uuid:8380069d-0c7d-41f6-b487-dd4e66377170" &	namenumber==2 &	loanid==1



**** interestfreq=7

*repayduration2 credible:
replace loan_month=repayduration2*12 if parent_key=="uuid:3502a333-6356-4267-ad32-ad6d32029c51" &	namenumber==1 &	loanid==2
replace loan_month=repayduration2*12 if parent_key=="uuid:ba97ea13-f20c-4518-86b9-e29e4e091ce6" &	namenumber==1 &	loanid==1

/*si repayduration2 seems to represent the total duration of the loan, and is far lower than the time since the loan was contracted:
to limit the downward bias, set a kind of max value for number of months repaid ie repayduration2 (si coherent)*/
replace loan_month=repayduration2 if parent_key=="uuid:5f4c151e-62e4-4f22-b88f-2aad8e3dc0f3" &	namenumber==1 &	loanid==3
replace loan_month=repayduration2 if parent_key=="uuid:c2fda044-d053-47b2-b693-58d34e7f70be" & namenumber==1 &	loanid==1



 
replace loan_months=loan_weeks/4 if loan_weeks!=.
replace loan_months=loan_year*12 if loan_year!=.
replace loan_months=months if loan_year==0

************ INTERESTFREQ MISSING
replace loan_months=months if interestfreq==. & totalrepaid==0 & included==1
replace loan_months=months if dummyinterest==0 & repayduration2==. & included==1
*microcredit: would mean 13 % pa
replace loan_month=repayduration2 if parent_key=="uuid:8d8cacc3-38f9-4630-9719-edd639102ad0" &	namenumber==2 &	loanid==1
replace interestfreq=2 if parent_key=="uuid:8d8cacc3-38f9-4630-9719-edd639102ad0" &	namenumber==2 &	loanid==1

*repayduration2 useless (total duration)
replace loan_month=months if parent_key=="uuid:01e2263f-26de-447d-87c5-f9af8c177bbf" &	namenumber==1 &	loanid==1
replace loan_month=months if parent_key=="uuid:0e075c0e-4b4a-461b-af2c-b61c39347738" &	namenumber==1 &	loanid==2

****if repayduration2 lower than time since loan contracted, take repayduration2: either real nb of months repaid, or maximum (if coherent with interest)
replace loan_month=repayduration2*12 if parent_key=="uuid:127cd654-d8fe-470e-811c-f322957b8a1c" &	namenumber==1 &	loanid==1

*yearly payment:
gen temp=.
replace temp=repayduration2*12 - months if repayduration1==3
replace temp=. if dummyinterest!=0 | dummyinterest==0 & loan_month!=.
replace loan_month=repayduration2*12 if temp<0
drop temp
*monthly
gen temp=.
replace temp=repayduration2 - months if repayduration1==2
replace temp=. if dummyinterest!=0 | dummyinterest==0 & loan_month!=.
replace loan_month=repayduration2 if temp<0
drop temp
*one in six month:
replace loan_month=repayduration2*6 if parent_key=="uuid:2fd71d69-8643-44bc-93f5-8ea6b8289cf8" &	namenumber==1 &	loanid==3
replace loan_month=months if parent_key=="uuid:3ed13d21-3fbd-4a33-a557-48b68f5ed065" &	namenumber==1 &	loanid==2
*3 year old loan, repayduration2=2
replace loan_month=24 if parent_key=="uuid:7271ec5d-69a1-4a3f-949f-3d98fd6efa1c" &	namenumber==1 &	loanid==1
replace repayduration2=3 if parent_key=="uuid:7271ec5d-69a1-4a3f-949f-3d98fd6efa1c" &	namenumber==1 &	loanid==1



*repayduration2> time since loan contracted 
replace loan_month=months if dummyinterest==0 & loan_month==. & included==1



************************************************************************************************************************************************************
*********************************************************** USE LOANBALANCE

replace loanbalance=0 if loansettled==1

**** LOANBALANCE MISSING for unsettled loans: 8 cas


*** ISSUE of 0 in loanamount
*neighbour loan: loanamount 500 000, loanalance 50 000. with 50 000, make monthly interest of 3% instead of 0,3
replace loanamount=50000 if parent_key=="uuid:5bd7eec6-42a4-4832-abe2-137e512ee78a" &	namenumber==1 &	loanid==2
*same thing, with interest 2% instead of 0,2
replace loanamount=50000 if parent_key=="uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006" &	namenumber==1 &	loanid==1
*loan amount 3000, loan balance 20 000
replace loanamount=10*loanamount if parent_key=="uuid:a12bbf07-88f1-46fb-a255-6a6b6706f2c3" &	namenumber==1 &	loanid==2
replace loanamount=10*loanamount if parent_key=="uuid:fb4500c5-a106-4dcf-a49b-477722865e9f" &	namenumber==2 &	loanid==3
*loanamount 2000, loanbalance 20 000 
replace loanamount=loanamount*10 if parent_key=="uuid:e804beec-7f01-4be3-88d9-fa9ad870149a" &	namenumber==1 &	loanid==3
*300 neighbour loan vs 3000
replace loanamount=loanbalance if parent_key=="uuid:cd94146d-f48f-475c-8416-78e984a3dccd" &	namenumber==2 &	loanid==1
*4 ans et qq: loanamount=55, loanbalance =1 000 000, motif: house. si  55 lakh: ca veut dire qu un lakh par an est rembourse ca fait pas mal...
*a voir plus tard avec le revenu/debt service
replace loanamount=5500000 if parent_key=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" &	namenumber==3 &	loanid==1


*** ISSUE 0 in loanbalance
*12 month old bank loan 700 000 INR, with interest thereby at nearly 1% monthly; principalpaid=0, but loanbalance=60 000
*remplacer loanbalance par 600 000, mais dans le doute ne pas ajouter 100 000 INR dans principalpaid
replace loanbalance=600000 if parent_key=="uuid:3502a333-6356-4267-ad32-ad6d32029c51" &	namenumber==1 &	loanid==2
*20 INR loan; 18000 repaid, 2000 balance
replace loanamount=loanamount*1000 if parent_key=="uuid:abefe76f-bf58-4b71-ab71-1d64a7a33c5e" &	namenumber==1 &	loanid==1
*loanamount 5000, loanbalance 50 000. 10 month old loan by moneylender for education. interestpaid 1500  (=10*interestloan)
* means 3% monthly interest for a loan of 5000). also 5000 written in loaninfo.
replace loanbalance=loanbalance/10 if parent_key=="uuid:30187ee9-dd3b-4a82-b20f-6ec0db908a4c" &	namenumber==1 &	loanid==1
*loanamount 15 000 by well known. loanbalance 150 000. with 15 000, interestloan means 3% monthly.
replace loanbalance=loanbalance/10 if parent_key=="uuid:a049567e-1188-4e9a-8875-4dce306cffdf" &	namenumber==1 &	loanid==1
*DOUTEUX: loanamount=33 000, loanbalance 100 000. for agriculture. vu les tailles des prets pour ce moment, semble plus plausible que ce soit 33 000 et non 330 000.
replace loanbalance=loanbalance/10 if parent_key=="uuid:d8256128-806c-4919-8216-9226c3fdc047" &	namenumber==1 &	loanid==3



	
********* LOANBALANCE> LOANAMOUNT:

*** avec princpalpaid!=.:  reste 31 cas - dont 21 microcredit

*update loanbalance with principalpaid for microcredits (interest checked, plausible)
replace loanbalance=loanamount-principalpaid if lender4==8 & loanbalance>loanamount & loanbalance!=.

replace loanbalance=loanamount-principalpaid if parent_key=="uuid:fbe2328b-890f-4bcd-82a1-d033c9986aed" &	namenumber==1 & loanid==1

*mystere: loanamount = 350 000 (idem loaninfo) and loanbalance=800 000. even including the interest does not yield 800 000. principalpaid=0
replace loanbalance=loanamount-principalpaid if parent_key=="uuid:15a2311a-c10d-462d-8a50-29a67b91b739" &	namenumber==1 &	loanid==1
*mystere: seem to include one missed interest payment and ignore the principal repaid. comme principal paid, interestpaid, et totalrepaid coherents:
replace loanbalance=loanamount-principalpaid if parent_key=="uuid:142053fe-243a-4035-8746-93dd30108d22" &	namenumber==1 &	loanid==1
*mystere loanamount = 10 000 (idem loaninfo) and loanbalance=14200. if included missed interest payment, would mean like 14% monthly ! en desespoir de cause:
replace loanbalance=loanamount-principalpaid if parent_key=="uuid:39110c77-6bc2-4c6c-9e78-f8923d54163b" &	namenumber==1 &	loanid==2

***avec princpalpaid!=.: 3 cas

replace loanbalance=loanamount if loanbalance>loanamount & loanbalance!=. & principalpaid==. 




********* COHERENCE LOANBALANCE & PRINCIPALPAID 

drop test
gen test=loanamount-principalpaid - loanbalance
tab test
* 0 :  89.3 %
*5.9% inf, 4.8% sup
tab lender4 if test!=0 & test!=.
*moitie de microcredit dans ceux qui ne matchent pas


gen ignoreppaid=0
replace ignoreppaid=1 if test==-principalpaid
replace ignoreppaid=. if test==0 | test==.
tab ignoreppaid
* 16 cas


***what is recorded in loanbalance is what has been repaid 
** is totalrepaid:
gen btotalrepaid=0
replace btotalrepaid=1 if loanbalance==totalrepaid & test!=0 & test!=.
replace btotalrepaid=1 if parent_key=="uuid:35591049-0c3e-4dac-836a-958f07745c35" &	namenumber==2 &	loanid==1
tab btotalrepaid
*9 cas
**is the principal repaid
gen bprincipalpaid=0
replace bprincipalpaid=1 if loanbalance==principalpaid & test!=0 & test!=.
tab bprincipal
*18 cas

*what is recorded in loanbalance is difference between loanamount and what has been repaid, but including interest (surestime le principal rembourse)
gen mixip=0
replace mixip=1 if loanbalance==loanamount-totalrepaid & dummyinterest==1 & interestpaid!=0 & test!=0 & test!=.
replace mixip=1 if parent_key=="uuid:62ad7210-2d2c-4e4d-a8c6-6501a63d2fee" &	namenumber==5 &	loanid==1
replace mixip=1 if parent_key=="uuid:89f0734d-db4a-4660-8c9f-c54fcd6f8ddb" &	namenumber==1 &	loanid==2
replace mixip=1 if loanbalance==loanamount-interestpaid & dummyinterest==1 & interestpaid!=0 & test!=0 & test!=.
*29 cas

**according to principalpaid, no principal has been paid, but according to loanbalance, some has been paid (8 CAS)
gen ppaidornot=0
replace ppaidornot=1 if principalpaid==0 & loanbalance<loanamount 
*13 cas

*** RECAP
gen identified=0 
replace identified=1 if ignoreppaid==1 | btotal==1 | bprincipal==1 | mixip==1 | ppaidornot==1
*68 cas
replace test=. if identified==1



*****microcredit: 
*with instlaments recorded, means repayduration2=24 weeks and 625 principal paid monthly. means 13% interet pour 6 mois.
replace loanbalance=loanamount - principalpaid if parent_key=="uuid:1a8044af-2831-4f69-b815-1acda4e54c8b" &	namenumber==1 &	loanid==2
replace repayduration2=24 if parent_key=="uuid:1a8044af-2831-4f69-b815-1acda4e54c8b" &	namenumber==1 &	loanid==2
replace loanbalance=loanamount-principalpaid if lender4==8 & test!=0 & test!=. & included==1


********* check les excluded:
**totalrepaid recorded, not interestpaid: but can be obtained with loanbalance
replace interestpaid=totalrepaid if parent_key=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	namenumber==2 &	loanid==1
replace included=1 if parent_key=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	namenumber==2 &	loanid==1
replace interestpaid=300000 if parent_key=="uuid:142053fe-243a-4035-8746-93dd30108d22" &	namenumber==1 &	loanid==2
replace principalpaid=200000 if parent_key=="uuid:142053fe-243a-4035-8746-93dd30108d22" &	namenumber==1 &	loanid==2
replace included=1 if parent_key=="uuid:142053fe-243a-4035-8746-93dd30108d22" &	namenumber==1 &	loanid==2
replace principalpaid=loanamount-loanbalance if parent_key=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	namenumber==1 &	loanid==2
*probaly a mistake in total repaid: means 445 000 interest, while probably 345 000 (interestloan*23 for 24 month old loan) 
replace interestpaid=345000 if parent_key=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	namenumber==1 &	loanid==2
replace included=1 if parent_key=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	namenumber==1 &	loanid==2
replace principalpaid=loanamount-loanbalance if parent_key=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	namenumber==1 &	loanid==1
replace interestpaid=totalrepaid-principalpaid if parent_key=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	namenumber==1 &	loanid==1
replace included=1 if parent_key=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" &	namenumber==1 &	loanid==1

**those who had principalpaid!=0 et totalrepaid=interestpaid: according to loanbalance, no principal has been paid:
replace principalpaid=0 if parent_key=="uuid:9f650881-8382-48ff-8757-9f012a0dfe8f" &	namenumber==1 &	loanid==1
replace included=1 if parent_key=="uuid:9f650881-8382-48ff-8757-9f012a0dfe8f" &	namenumber==1 &	loanid==1
replace principalpaid=0 if parent_key=="uuid:b6802956-c0b6-442e-b416-73d9acd4d137" &	namenumber==1 &	loanid==1
replace included=1 if parent_key=="uuid:b6802956-c0b6-442e-b416-73d9acd4d137" &	namenumber==1 &	loanid==1
replace principalpaid=0 if parent_key=="uuid:d92d4760-c143-430d-848d-ae199496a356" &	namenumber==1 &	loanid==2
replace included=1 if parent_key=="uuid:d92d4760-c143-430d-848d-ae199496a356" &	namenumber==1 &	loanid==2
replace principalpaid=0 if parent_key=="uuid:c3754c17-d102-41df-93d1-f1bd78466da8" &	namenumber==1 &	loanid==1
replace included=1 if parent_key=="uuid:c3754c17-d102-41df-93d1-f1bd78466da8" &	namenumber==1 &	loanid==1
replace principalpaid=0 if parent_key=="uuid:da893017-2541-42dc-9dab-d517d777b92b" &	namenumber==1 &	loanid==3
replace included=1 if parent_key=="uuid:da893017-2541-42dc-9dab-d517d777b92b" &	namenumber==1 &	loanid==3
replace principalpaid=0 if parent_key=="uuid:d35fd473-8f07-437a-b6d2-b51962ac7c94" &	namenumber==1 &	loanid==2
replace included=1 if parent_key=="uuid:d35fd473-8f07-437a-b6d2-b51962ac7c94" &	namenumber==1 &	loanid==2

replace totalrepaid=1100 if parent_key=="uuid:8e0b0fc2-c75d-4646-a949-4c7749d6b3cc" &	namenumber==1 &	loanid==1
replace included=1 if parent_key=="uuid:8e0b0fc2-c75d-4646-a949-4c7749d6b3cc" &	namenumber==1 &	loanid==1



*** loans with pb "identified" + POSITIVE AMOUNTS of principal paid different selon principal paid et loanbalance:
*apres check: on ne peut pas faire grand chose. considere que principalpaid prevaut sur loanbalance.
drop test
gen test=loanamount-principalpaid - loanbalance
replace loanbalance=loanamount - principalpaid if test!=0 & test!=.

*(bizarre que principalpaid soit encore missing aurait du etre regle???)
replace principalpaid=totalrepaid-interestpaid if parent_key=="uuid:d00c25d5-5174-4103-aa12-d49296b6fa3c" &	namenumber==2 &	loanid==1



***********



preserve
keep if included==1
duplicates drop parent_key, force
count
*450 hh
restore

*br parent_key namenumber loanid loanamount months dummyinterest principalpaid totalrepaid loanbalance lender4 loanreasongiven loaninfo  if loanbalance>loanamount

*************************************************************************************************************************************************************
********************************************************** ANNUALIZED INTEREST RATES
**************************************************************************************************************************************************************



gen yratepaid=.
****if interest paid weekly, monthly or when have money, once in six months, or unclear (interestfreq=7)
replace yratepaid=interestpaid*100*12/(loan_months*loanamount) if interestfreq==1 | interestfreq==2 | interestfreq==6 | interestfreq==7 | interestfreq==4
****if interest paid yearly: interestpaid averaged with an integer for number of years 
gen loan_year2=loan_year
replace loan_year2=1 if loan_year2<1 
replace yratepaid=interestpaid*100/(loan_year2*loanamount) if interestfreq==3
**** if interest=fixed amount
replace yratepaid=interestpaid*100/loanamount if interestfreq==5
replace yratepaid=. if included==0 | dummyinterest==0


********** CHECK FOR OUTLIERS BY CREDIT SOURCES

*loanamount 50 000, and interestloan 10 000. actually, 500 000 [loaninfo=="Sambath 500000 for Agriculture")
replace loanamount=500000 if parent_key=="uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006" &	namenumber==1 &	loanid==1
replace loanbalance=loanamount if parent_key=="uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006" &	namenumber==1 &	loanid==1 
replace yratepaid=yratepaid/10 if parent_key=="uuid:f7c0aded-b61a-4d89-ac2b-3e245be4c006" &	namenumber==1 &	loanid==1

gen outlier_yrate=0
replace outlier_yrate=1 if yrate>=240 & lender4==1 & yrate!=.
replace explication="outlier; wkp >240 pa (highest below 115" if yrate>=240 & lender4==1 & yrate!=.
gen yrate_included=included
replace yrate_included=0 if outlier_yrate==1

tab yrate_included
*1078
tab included
*1080

*paid rates for those who started to repay:
tabstat yratepaid if  yrate_included==1 & interestpaid>0 & interestpaid!=., by(lender4) stat(n mean p50 min max)
/*

     lender4 |         N      mean       p50       min       max
-------------+--------------------------------------------------
  Well known |       324  24.28248      21.6  1.463415     115.2
   Relatives |       129  18.83321  16.27119         2        60
      Labour |        31  18.42413  16.36364         5  41.14286
 Pawn broker |         1  23.07692  23.07692  23.07692  23.07692
 Shop keeper |         2  17.32692  17.32692      12.5  22.15385
Moneylenders |        58  27.50972        24  2.907692     79.68
     Friends |        14   20.2881  19.04895   .742268      43.2
 Microcredit |        98  15.63684    13.392     .4992        54
        Bank |        31  10.61372  10.28571        .9        32
    Neighbor |        32  22.23268  22.28572  2.727273  41.14286
-------------+--------------------------------------------------
       Total |       720  21.35884        18     .4992     115.2
----------------------------------------------------------------

*/

*************************************************************************************************************************************************************
********************************************************** DEBT SERVICE
**************************************************************************************************************************************************************

*que faire avec les 8 cas de loanbalance missing ? pour le moment, remplace par loanamount
gen loanbalance2=loanbalance
replace loanbalance2=loanamount if loanbalance2==.
bysort parent_key: egen hh_unsettled_debt=sum(loanbalance2)



*****************************************************************************************************************
********************************** VARIABLES DEBT SERVICE - MAIN LOAN LEVEL

*for loans contracted less than 1 year before the interview: debt service=totalrepaid, interest service=interestpaid
*for loans contracted more than 1 year before the interview: what has been paid in total averaged and equivalent for one year imputed (hardly convincing)


gen debt_service=.
replace debt_service=totalrepaid if loan_months<=12
replace debt_service=totalrepaid*12/loan_months if loan_months>12
replace debt_service=0 if loan_months==0 & totalrepaid==0 | loan_months==0 & totalrepaid==.
replace debt_service=0 if included==0

gen interest_service=.
replace interest_service=interestpaid if loan_months<=12
replace interest_service=interestpaid*12/loan_months if loan_months>12
replace interest_service=0 if loan_months==0 & totalrepaid==0 | loan_months==0 & totalrepaid==.
replace interest_service=0 if included==0
replace interest_service=0 if dummyinterest==0 & interestpaid==0 | dummyinterest==0 & interestpaid==.




********************************** VARIABLES DEBT SERVICE - HOUSEHOLD LEVEL, with main loans

***** REPAYMENT BURDEN:
bysort parent_key: egen ds_tot=sum(debt_service)
bysort parent_key: egen is_tot=sum(interest_service)



***** SHARE OF LOANS FOR WHICH REPAYMENT BURDEN IS AVAILABLE (frequency & volume)

bysort parent_key: egen hh_nb_incl=sum(included)
gen loanamount2=loanamount
replace loanamount2=0 if included==0 | included==.
bysort parent_key: egen hh_vol_included=sum(loanamount2)
drop loanamount2

gen temp1=1
bysort parent_key: egen hh_nb_loans=sum(temp1)
bysort parent_key: egen hh_vol_loans=sum(loanamount)
drop temp1

gen freq_incl=hh_nb_incl/hh_nb_loans
gen vol_incl=hh_vol_included/hh_vol_loans



save "ALL-LOANS", replace


*************************************************************************************************
************************************************ INCOME
***************************************************************************************************


use  "NEEMSIS-HH", clear
rename HHID parent_key 
rename INDID namenumber

**** PENSIONS
local scheme "retirement disability maternity widows oldage"
foreach i of local scheme {
gen pensionamount_`i'2=pensionamount_`i'
replace pensionamount_`i'2=0 if pensionamount_`i'2==.
*bysort parent_key: egen hh_`i'=sum(pensionamount_`i'2)
}
gen tot_pensions_indiv= pensionamount_disability2 + pensionamount_maternity2 + pensionamount_widows2+ pensionamount_oldage2
bysort parent_key: egen hh_pensions=sum(tot_pensions_indiv)

**** REMITTANCES

replace remreceivedtotamount1=1200 if remreceivedtotamount1==21000 & parent_key=="uuid:064199f1-5b48-4c01-8d10-8897e2532362" 
replace remreceivedtotamount1=5000 if remreceivedtotamount1==50000 & parent_key=="uuid:5808d423-e9a2-4303-b4a7-f4a250833033" 
replace remreceivedtotamount1=10000 if remreceivedtotamount1==100000 & parent_key=="uuid:84aaf986-614e-4a31-b580-16c61e47706e"
replace remreceivedtotamount1=18000 if remreceivedtotamount1==180000 & parent_key=="uuid:a6115c68-6cd6-406e-9991-caaf0b15e029"


foreach var of varlist remreceivedtotamount1 remreceivedtotamount2 remsenttotalamount1 remsenttotalamount2 {
replace `var'=0 if `var'==.
bysort parent_key: egen `var'_hh=sum(`var')
}
gen hh_remittances_in=remreceivedtotamount1_hh+remreceivedtotamount2_hh

keep parent_key namenumber tot_pensions_indiv hh_remittances_in hh_pensions
merge 1:m parent_key namenumber using "ALL-LOANS"
keep if _merge==3
drop _merge
save  "ALL-LOANS", replace



***** CLEANING ANNUALINCOME using EGO DATA (including identification of 4 households with issues in income recording, to be excluded from the sample)

use "NEEMSIS-ego.dta" , clear
keep parent_key namenumber jobwagefrequencycash jobwageamountcash mainoccup selected_months dummyregularmainoccup inddaysayear2
rename parent_key HHID2016
rename namenumber INDID
merge 1:m HHID2016 INDID using "Panel_occupations_clean.dta" 
drop _merge
keep if year==2016
rename HHID2016 parent_key
rename INDID namenumber

gen annualincome2=annualincome
label var annualincome2 "annualincome cleaned"
replace annualincome2=0 if annualincome2==.

**CHECK VERY SMALL  (<1000 RS) OR VERY HIGH INCOMES
*after comparaison avec dummyregularmainoccup, selected_months, inddaysayear2, jobwagefrequencycash, jobwageamountcash etc
replace annualincome2=10*annualincome if parent_key=="uuid:1aa5f188-ff37-463b-9763-eb3bcb1a3e80" & namenumber==3 | parent_key=="uuid:61eebc2f-dbcf-4c8d-b1c1-db47af15e320" & namenumber==2 | parent_key=="uuid:abefe76f-bf58-4b71-ab71-1d64a7a33c5e" & namenumber==2 | parent_key=="uuid:b6368567-0a4c-4cd0-848b-7909cd3159da" & namenumber==4 
*36  nrega days at the rate of 100 Rs per day (360 Rs declared)
replace annualincome2=10*annualincome if parent_key=="uuid:491a848e-a1b6-40b3-af94-e1d15a03b529" & namenumber==1 
*48  nrega days at the rate of  100 Rs (48 Rs declares)
replace annualincome2=100*annualincome if parent_key=="uuid:b34f385e-b0db-492b-a471-6088718f8560" & namenumber==2 | parent_key=="uuid:c4fdec61-1d61-4a2d-bd47-be3d17cbc744" & namenumber==2
*construction labour: 60 day/year at 300 Rs daily: 1800000 Rs declared
replace annualincome2=annualincome/100 if parent_key=="uuid:b34f385e-b0db-492b-a471-6088718f8560" & namenumber==2

** MISSING DATA:
replace annualincome2=. if  parent_key=="uuid:5c1a711d-d214-4c67-94b7-2eb8ed6009cd" & namenumber==3 | parent_key=="uuid:5c1a711d-d214-4c67-94b7-2eb8ed6009cd" & namenumber==5 | parent_key=="uuid:77cb7501-b16a-4783-9f3e-c1a84460fe88" & namenumber==1 | parent_key=="uuid:e94ec504-d21d-401b-9523-ddb9ade5a670" & namenumber==3 | parent_key=="uuid:038e545c-f964-4b54-b888-13c91f17698a" & namenumber==2
gen temp1=0
replace temp1=1 if annualincome2==.
*4 hh with a missing income of one hh member 
bysort parent_key: egen excluded_hh=max(temp1)
label var excluded_hh "hh to be excluded (missing incomes)"
drop temp1



** VARIABLE
*celle que j utilise:
bysort parent_key namenumber: egen indiv_labour_income=sum(annualincome2)
bysort parent_key: egen hh_labour_income=sum(indiv_labour_inc)
*pour check differences Arnaud:
bysort parent_key namenumber: egen annualincome_initial=sum(annualincome)
bysort parent_key: egen hh_inc_initial=sum(annualincome_initial)



** TRANSFER IN BASE HH
duplicates drop parent_key namenumber, force
keep parent_key namenumber indiv_labour_income excluded_hh hh_labour_income hh_inc_initial
merge 1:m parent_key namenumber using "ALL-LOANS"
/*
   Result                           # of obs.
    -----------------------------------------
    not matched                         1,760
        from master                     1,760  (_merge==1)
        from using                          0  (_merge==2)

    matched                             2,046  (_merge==3)
    -----------------------------------------
*/
keep if _merge==3
drop _merge

replace excluded_hh=0 if excluded_hh==.
bysort parent_key: egen excluded2=max(excluded_hh)

*2000 INR of yearly income for a 4 members hh:
replace excluded2=1 if parent_key=="uuid:fa829dba-bbe4-4166-95db-f98251714447"

**FINAL INCOME VARIABLES 
*individual
replace indiv_labour_inc=0 if indiv_labour_inc==. 
gen indiv_tot_inc=indiv_labour_inc+tot_pensions_indiv
*household 
gen hh_tot_income1=hh_labour_inc+hh_pensions
label var hh_tot_income1 "hh labour income+pensions"
gen hh_tot_income2=hh_tot_income1+hh_remittances_in
label var hh_tot_income2 "hh labour income+pensions+remittances received"

*household per capita income (labour income + pensions + remittances)
by parent_key namenumber, sort: gen hh_size=_n==1
by parent_key: replace hh_size = sum(hh_size)
by parent_key: replace hh_size = hh_size[_N] 
gen ln_hh_size=ln(hh_size)

gen hh_percap2=hh_tot_income2/hh_size


*5 hh:
drop if excluded2==1

*482 households
save "ALL-LOANS", replace


********************************************************************************************************************************************************
************************************************************* REPAYMENT BURDEN

** HOUSEHOLDS: share of loans covered

preserve
duplicates drop parent_key, force
sum freq_i, detail
tab freq_i
tab vol_incl
restore

gen debt_burden=ds_tot*100/hh_tot_income2
gen interest_burden=is_tot*100/hh_tot_income2

*37 households:
replace debt_burden=. if vol_inc==0
replace interest_burden=. if vol_inc==0

preserve
duplicates drop parent_key, force
tabstat debt_burden interest_burden, stat (n mean sd min max p25 p50 p75)
/*

   stats |  debt_burden  interest_burden
---------+--------------------
       N |       445       445
    mean |   27.3056  19.75711
      sd |  40.64041  32.60238
     min |         0         0
     max |  332.3666  286.4322
     p25 |  4.919934  1.063385
     p50 |  13.55932  7.117438
     p75 |  33.02469  23.95038
------------------------------
*/
restore

gen dsr=ds_tot*100/hh_inc_initial
gen isr=is_tot*100/hh_inc_initial
replace isr=. if vol_inc==0
replace dsr=. if vol_inc==0

preserve
duplicates drop parent_key, force
tabstat dsr isr, stat (n mean sd min max p25 p50 p75)
/*
   stats |       dsr       isr
---------+--------------------
       N |       444       444
    mean |  29.20092  20.82461
      sd |  44.15738  34.75054
     min |         0         0
     max |  332.3666  286.4322
     p25 |  4.922878  1.161666
     p50 |   13.8213  7.491109
     p75 |  33.52437  24.53407
------------------------------
*/
restore

save "ALL-LOANS", replace

STOP

*br parent_key namenumber loanid loanamount months  month_repaid repayduration2 interest* principalpaid totalrepaid loanbalance lender4 loanreasongiven loaninfo  if outlier_yrate==1



********************************************************************************************************************************************************
************************************************************* REPAYMENT BURDEN - IMPUTATION I


*8 cas:
gen excl_imputation=0
replace excl_imp=1 if loanbalance==.  

gen imp_loan_month=.
replace imp_loan_month=floor(diff_month) if dummyinterest==.

gen imp_principal=.
replace imp_principal=loanamount-loanbalance if dummyinterest==. & imp_loan_month<=12
replace imp_principal=(loanamount-loanbalance)*12/imp_loan_month if dummyinterest==. & imp_loan_month>12


*average interet for moneylenders et microcredit:
gen imp1_interest=.
replace imp1_interest=0.275*loanamount if lender4==6 & imp_loan_month>=12 & dummyinterest==.
replace imp1_interest=0.275*loanamount*imp_loan_month/12 if  lender4==6 & imp_loan_month<12 & dummyinterest==.
replace imp1_interest=0.156*loanamount if lender4==8 & imp_loan_month>=12 & dummyinterest==.
replace imp1_interest=0.156*loanamount*imp_loan_month/12 if  lender4==8 & imp_loan_month<12 & dummyinterest==.
replace imp1_interest=0 if lender4!=6 & lender4!=8 & dummyinterest==. & loandate!=.

gen imp1_totalrepaid_year=imp_principal+imp1_interest

gen imp1_debt_service=debt_service
replace imp1_debt_service=imp1_totalrepaid_year if dummyinterest==.
replace imp1_debt_service=. if included==0 | excl_imp==1
gen imp1_interest_service=interest_service
replace imp1_interest_service=imp1_interest if dummyinterest==.
replace imp1_interest_service=. if included==0 | excl_imp==1

gen ii1=0
replace ii1=1 if imp1_debt_service!=.
bysort parent_key: egen hh_nb_ii1=sum(ii1)
gen loanamount2=loanamount
replace loanamount2=0 if ii1==0
bysort parent_key: egen hh_vol_ii1=sum(loanamount2)
drop loanamount2

gen freq_ii1=hh_nb_ii1/hh_nb_loans
gen vol_ii1=hh_vol_ii1/hh_vol_loans

bysort parent_key: egen imp1_ds_tot=sum(imp1_debt_service)
bysort parent_key: egen imp1_is_tot=sum(imp1_interest_service)

gen imp1_debt_burden=imp1_ds_tot*100/HH_annualincome
gen imp1_interest_burden=imp1_is_tot*100/HH_annualincome


preserve
duplicates drop parent_key, force
sum freq_ii1, detail
tab freq_ii1
sum vol_ii1, detail
restore

preserve
duplicates drop parent_key, force
tabstat imp1_debt_burden imp1_interest_burden if imp1_debt_burden<1000 & imp1_interest_burden<500, stat(n mean p25 p50 p75 min max)
restore

/*

   stats |  imp1_d~n  imp1_i~n
---------+--------------------
       N |       482       482
    mean |  31.54483  19.93666
     p25 |  6.291028  1.247404
     p50 |  15.86846  7.106599
     p75 |  37.60498  23.54167
     min |         0         0
     max |  358.4559  286.4322
------------------------------

*/

********************************************************************************************************************************************************
************************************************************* REPAYMENT BURDEN - IMPUTATION II


*average interet for all:
/*

     lender4 |         N      mean       p50       min       max
-------------+--------------------------------------------------
  Well known |       324  24.28248      21.6  1.463415     115.2
   Relatives |       129  18.83321  16.27119         2        60
      Labour |        31  18.42413  16.36364         5  41.14286
 Pawn broker |         1  23.07692  23.07692  23.07692  23.07692
 Shop keeper |         2  17.32692  17.32692      12.5  22.15385
Moneylenders |        58  27.50972        24  2.907692     79.68
     Friends |        14   20.2881  19.04895   .742268      43.2
 Microcredit |        98  15.63684    13.392     .4992        54
        Bank |        31  10.61372  10.28571        .9        32
    Neighbor |        32  22.23268  22.28572  2.727273  41.14286
-------------+--------------------------------------------------
       Total |       720  21.35884        18     .4992     115.2
----------------------------------------------------------------

*/
gen imp2_interest=.
replace imp2_interest=0.275*loanamount if lender4==6 & imp_loan_month>=12 & dummyinterest==.
replace imp2_interest=0.275*loanamount*imp_loan_month/12 if  lender4==6 & imp_loan_month<12 & dummyinterest==.

replace imp2_interest=0.156*loanamount if lender4==8 & imp_loan_month>=12 & dummyinterest==.
replace imp2_interest=0.156*loanamount*imp_loan_month/12 if  lender4==8 & imp_loan_month<12 & dummyinterest==.

replace imp2_interest=0.243*loanamount if lender4==1 & imp_loan_month>=12 & dummyinterest==.
replace imp2_interest=0.243*loanamount*imp_loan_month/12 if  lender4==1 & imp_loan_month<12 & dummyinterest==.

replace imp2_interest=0.188*loanamount if lender4==2 & imp_loan_month>=12 & dummyinterest==.
replace imp2_interest=0.188*loanamount*imp_loan_month/12 if  lender4==2 & imp_loan_month<12 & dummyinterest==.

replace imp2_interest=0.184*loanamount if lender4==3 & imp_loan_month>=12 & dummyinterest==. & loandate!=.
replace imp2_interest=0.184*loanamount*imp_loan_month/12 if  lender4==3 & imp_loan_month<12 & dummyinterest==.

replace imp2_interest=0.231*loanamount if lender4==4 & imp_loan_month>=12 & dummyinterest==. & loandate!=.
replace imp2_interest=0.231*loanamount*imp_loan_month/12 if  lender4==4 & imp_loan_month<12 & dummyinterest==.

replace imp2_interest=0.173*loanamount if lender4==5 & imp_loan_month>=12 & dummyinterest==. & loandate!=.
replace imp2_interest=0.173*loanamount*imp_loan_month/12 if  lender4==5 & imp_loan_month<12 & dummyinterest==.

replace imp2_interest=0.203*loanamount if lender4==7 & imp_loan_month>=12 & dummyinterest==.
replace imp2_interest=0.203*loanamount*imp_loan_month/12 if  lender4==7 & imp_loan_month<12 & dummyinterest==.

replace imp2_interest=0.106*loanamount if lender4==9 & imp_loan_month>=12 & dummyinterest==.
replace imp2_interest=0.106*loanamount*imp_loan_month/12 if  lender4==9 & imp_loan_month<12 & dummyinterest==.

replace imp2_interest=0.222*loanamount if lender4==10 & imp_loan_month>=12 & dummyinterest==.
replace imp2_interest=0.222*loanamount*imp_loan_month/12 if  lender4==10 & imp_loan_month<12 & dummyinterest==.

gen imp2_totalrepaid_year=imp_principal+imp2_interest

gen imp2_debt_service=debt_service
replace imp2_debt_service=imp2_totalrepaid_year if dummyinterest==.
replace imp2_debt_service=. if included==0 | excl_imp==1
gen imp2_interest_service=interest_service
replace imp2_interest_service=imp2_interest if dummyinterest==.
replace imp2_interest_service=. if included==0 | excl_imp==1


bysort parent_key: egen imp2_ds_tot=sum(imp2_debt_service)
bysort parent_key: egen imp2_is_tot=sum(imp2_interest_service)

gen imp2_debt_burden=imp2_ds_tot*100/HH_annualincome
gen imp2_interest_burden=imp2_is_tot*100/HH_annualincome


preserve
duplicates drop parent_key, force
tabstat imp2_debt_burden imp2_interest_burden, stat(n mean p25 p50 p75 min max)
restore

/*
  stats |  imp2_d~n  imp2_i~n
---------+--------------------
       N |       482       482
    mean |  36.64206  25.03388
     p25 |  7.894737  3.273322
     p50 |  19.44195  10.58546
     p75 |   41.2854  28.27925
     min |         0         0
     max |  358.4559  293.9696
------------------------------

*/




********************************************************************************************************************************************************
************************************************************* REPAYMENT BURDEN - IMPUTATION III

*add 2 paisa interest for gold loan assuming that all has been pledged for one year or more

gen ginterest=0
replace ginterest=loanamount*0.02*12 if months==.
bysort parent_key: egen hh_ginterest=sum(ginterest)

*****impact for each step:

*IMPUTATION 0:

gen g0_ds_tot=ds_tot+hh_ginterest
gen g0_is_tot=is_tot+hh_ginterest
gen debt_burden_g0=g0_ds_tot*100/HH_annualincome
gen interest_burden_g0=g0_is_tot*100/HH_annualincome

foreach i in 1 2 {
gen g`i'_ds_tot=imp`i'_ds_tot+hh_ginterest
gen g`i'_is_tot=imp`i'_is_tot+hh_ginterest
gen debt_burden_g`i'=g`i'_ds_tot*100/HH_annualincome
gen interest_burden_g`i'=g`i'_is_tot*100/HH_annualincome
}


preserve
duplicates drop parent_key, force
tabstat debt_burden* interest_burden*, stat(n mean p25 p50 p75 min max)
restore


/*
   stats |  debt_b~n  debt_b~0  debt_b~1  debt_b~2  inter~en  intere~0  intere~1  intere~2
---------+--------------------------------------------------------------------------------
       N |       445       482       482       482       445       482       482       482
    mean |   27.3056  31.18853  37.52383  42.62106  19.75711  24.21949  25.91566  31.01289
     p25 |  4.919934  6.411183  9.469697  11.01618  1.063385  3.544304  4.171429  5.592105
     p50 |  13.55932  16.46163  20.59526  23.72544  7.117438   10.8398   11.9994  14.65833
     p75 |  33.02469  35.28708  44.77672  49.60318  23.95038  27.97046  30.18576  35.80653
     min |         0         0         0         0         0         0         0         0
     max |  332.3666  487.4372  487.4372  487.4372  286.4322  487.4372  487.4372  487.4372
------------------------------------------------------------------------------------------
*/
