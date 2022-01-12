cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
January 11, 2022
-----
TITLE: Sex relationship
-------------------------
*/


****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "C:\Users\Arnaud\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
global directorybis = "C:\Users\Arnaud\Docuements\_Thesis\_DATA\NEEMSIS2\DATA"
global git = "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS"

*global directory = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*global directorybis = "C:\Users\anatal\Downloads\_Thesis\_DATA\NEEMSIS2\DATA"
*global git ="C:\Users\anatal\Downloads\Github\RUME-NEEMSIS"


cd"$directory"
clear all
****************************************
* END







****************************************
* Vérifications Mary
****************************************
use"$directory\CLEAN\_ANALYSIS_HH\NEEMSIS2-HH.dta", clear

drop if INDID_left!=.
fre livinghome
drop if livinghome==3
drop if livinghome==4

*Missings
fre relationshiptohead
ta relationshiptoheadother

*Relationshiptohead
fre relationshiptohead
sort version_HH HHID_panel INDID_panel
list version_HH parent_key INDID2020 egoid sex age indivpanel_10_16_20 if relationshiptohead==., clean noobs

fre relationshiptohead sex
ta relationshiptohead sex

*Drop good one to keep mistakes
drop if sex==2 & relationshiptohead==3
drop if sex==1 & relationshiptohead==4
drop if sex==1 & relationshiptohead==5
drop if sex==2 & relationshiptohead==6
drop if sex==1 & relationshiptohead==7
drop if sex==2 & relationshiptohead==8
drop if sex==2 & relationshiptohead==9
drop if sex==1 & relationshiptohead==10
drop if sex==2 & relationshiptohead==11
drop if sex==1 & relationshiptohead==12
drop if sex==1 & relationshiptohead==15
drop if sex==2 & relationshiptohead==16

drop if relationshiptohead==13
drop if relationshiptohead==17

drop if relationshiptohead==1
drop if relationshiptohead==2

drop if relationshiptohead==.

ta relationshiptohead sex, m

ta indivpanel_10_16_20
sort HHID_panel INDID_panel
list HHID_panel INDID_panel name sex age relationshiptohead if indivpanel_10_16_20=="Yes", clean noobs
/*
    HHID_p~l   INDID~el                       name      sex   age   relationshipt~d  
        ELA9      Ind_3                      Jothi   Female    31               Son  
       GOV51      Ind_4                       Enba   Female    23               Son  
       KAR14      Ind_5                       Guna   Female    33               Son  
       KAR49      Ind_7              Ramakirushnan   Female    16               Son  
        KAR8      Ind_5                 Sathiyaraj   Female    18               Son  
       KOR24      Ind_6              Vijayalakshmi   Female    20               Son  
       KOR24      Ind_7                   Abimanyu     Male    19          Daughter  
       KOR36      Ind_3                      Agila   Female    13               Son  
       KOR44      Ind_4              Dhivyabarathi   Female    17               Son  
       KUV12      Ind_6                   Sundhram   Female    72     Father-in-law  
       KUV19      Ind_3                  Jothimani     Male    26          Daughter  
       KUV35      Ind_5                       Anbu   Female    26               Son  
       KUV44      Ind_3   Santhosh @ Santhoshkumar     Male    24          Daughter  
        KUV6      Ind_3                     Suriya   Female    22               Son  
        KUV7      Ind_3                      Surya     Male    20          Daughter  
       MAN31      Ind_4                Veeradhivya   Female    14               Son  
     MANAM15      Ind_5                  Sundarsri     Male    16   Daughter-in-law  
     MANAM15      Ind_6                     Sundar     Male    14   Daughter-in-law  
     MANAM17      Ind_3                   Bharathi   Female    29               Son  
     MANAM22      Ind_3                Deshmugilan     Male    19          Daughter  
     MANAM49      Ind_1                   Kasthuri   Female    50       Grandfather  
       NAT11      Ind_4                     Deepan     Male    12          Daughter  
       ORA30      Ind_3                      Thamu   Female    22               Son  
       ORA30      Ind_5                     Subash     Male    16          Daughter  
       ORA39      Ind_5                    Sarathi     Male    17          Daughter  
       SEM15      Ind_4                      Vinai     Male    16          Daughter  
       SEM28      Ind_1               Kadhar basha     Male    64          Daughter  
       SEM46      Ind_1                   Selvaraj     Male    69          Daughter 

*/



***** look at 2016
keep if HHID_panel=="ELA9" & INDID_panel=="Ind_3"
ta sex
ta relationshiptohead
*Female daughter


***** look ta 2010


****************************************
* END




