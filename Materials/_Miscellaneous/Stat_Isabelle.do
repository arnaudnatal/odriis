*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*November 19, 2022
*-----
* Stat Isabelle
*-----
*-------------------------








****************************************
* Savings 2020
****************************************
use"C:\Users\Arnaud\Documents\MEGA\Thesis\Thesis_Measuring_debt\Analysis\raw\NEEMSIS2-HH", clear


* Selection
drop if dummylefthousehold==1
drop if livinghome==3
drop if livinghome==4

order HHID2020 INDID2020 dummysavingaccount dummysavingsownerlist savingsownernumber nbsavingaccounts savingsaccounttype1 savingsjointaccount1 banktype1 savingsbankname1 savingsbankplace1 savingsamount1 savingspurpose1 covsavinguse1 dummydebitcard1 dummycreditcard1 covsavinguseamount1 usedebitcard1 reasonnotusedebitcard1 usecreditcard1 savingsaccountdate1 datedebitcard1 datecreditcard1 savingsaccounttype2 savingsjointaccount2 banktype2 savingsbankname2 savingsbankplace2 savingsamount2 savingspurpose2 covsavinguse2 dummydebitcard2 dummycreditcard2 covsavinguseamount2 usedebitcard2 savingsaccountdate2 datedebitcard2 savingsaccounttype3 banktype3 savingsbankname3 savingsbankplace3 savingsamount3 savingspurpose3 covsavinguse3 dummydebitcard3 dummycreditcard3 covsavinguseamount3 usedebitcard3 savingsaccountdate3 datedebitcard3 savingsaccounttype4 banktype4 savingsbankname4 savingsbankplace4 savingsamount4 savingspurpose4 covsavinguse4 dummydebitcard4 dummycreditcard4 usedebitcard4 savingsaccountdate4 datedebitcard4
sort HHID2020 INDID2020


* How many? Amount?
/*
Un HH déclare un compte, mais personne dans le HH n'en a un visiblement
Pour d'autres, ils en déclarent, mais 0 comme amount, donc c'est bon
Mais le premier n'est pas bon, donc j'enlève
*/
drop if HHID2020=="uuid:607b5085-73ed-4c37-9c6f-55e6d4ac7875"
recode savingsamount1 savingsamount2 savingsamount3 savingsamount4 (.=0)
egen totalsaving=rowtotal(savingsamount1 savingsamount2 savingsamount3 savingsamount4)

order HHID2020 INDID2020 dummysavingaccount dummysavingsownerlist savingsamount1 savingsamount2 savingsamount3 savingsamount4 totalsaving

bysort HHID2020: egen totalsaving_HH=sum(totalsaving)

keep HHID2020 totalsaving_HH dummysavingaccount
duplicates drop
drop if dummysavingaccount==0
tabstat totalsaving_HH, stat(n mean cv q)
dis 629*100/632


/*
***
keep if HHID2020=="uuid:607b5085-73ed-4c37-9c6f-55e6d4ac7875" | HHID2020=="uuid:8de7eea7-19ac-4aa1-aea9-8165a083e930" | HHID2020=="uuid:68042374-ef71-44d1-8c27-ebbd6224d343" | HHID2020=="uuid:ae56c030-d074-47fd-98c8-f232c11f00f3"

****************************************
* END
