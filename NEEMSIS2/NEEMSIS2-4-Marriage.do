/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
February 23, 2021
-----
SOMEONE ELSE CLEANING
-----
-------------------------
*/



****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
cls
********** Path to folder "data" folder.
global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
cd"$directory"
********** SSC to install
*ssc install dropmiss, replace
*ssc install fre, replace

****************************************
* END












****************************************
* MARRIAGE CLEANING
****************************************

********** TEMPORARY PANEL DATA BASE TO HAVE ALL INDIVIDUALS
use"$directory\CLEAN\NEEMSIS2-HH_v5.dta", clear
merge m:1 INDIDpanel using "$directory\do_not_drop\NEEMSIS_preload2016"
drop if _merge==1
*
save"$directory\CLEAN\NEEMSIS2-HH_v6.dta", replace






********* TEMPORARY CLEANING OF MARRIAGE DATABASE & LIST OF HH WITH SOMEONE ELSE
use"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup.dta", clear
keep if marriagedate!=.
drop forauto howpaymarriage_4 howpaymarriage_2 howpaymarriage_1 howpaymarriage_3 
drop marriageloanlendername1 marriageloanlendername2 marriageloanlendername3 marriageloanlendername4 marriageloanlendername5 marriageloanlendername6 marriageloanlendername7 marriageloanlendername8 marriageloanlendername9 marriageloanlendername10 marriageloanlendername11 marriageloanlendername12 marriageloanlendername13 marriageloanlendername14 marriageloanlendername15
drop marriagegiftsource_1 marriagegiftsource_2 marriagegiftsource_3 marriagegiftsource_4 marriagegiftsource_5 marriagegiftsource_6 marriagegiftsource_7 marriagegiftsource_8 marriagegiftsource_9 marriagegiftsource_10 marriagegiftsource_11 marriagegiftsource_12 marriagegiftsource_13 marriagegiftsource_14 marriagegiftsource_15

replace marriedname=marriagesomeoneelse if marriedname=="Someone else 1" & marriagesomeoneelse!=""
replace marriedname=marriagesomeoneelse if marriedname=="Someone else 2" & marriagesomeoneelse!=""

merge m:1 parent_key using "$directory\CLEAN\NEEMSIS_APPEND.dta", keepusing(householdid2020 HHID2010 HHID_panel startquestionnaire)
keep if _merge==3
drop _merge

* INTERMEDIATE SAVING
save"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v2.dta", replace

* LIST OF SOMEONE ELSE HH
keep if marriagedate!=.
sort HHID2010 marriagesomeoneelse
list HHID2010 HHID_panel if (marriedid=="31" | marriedid=="32" | marriedid=="133") & marriagesomeoneelse=="", clean noobs
list HHID2010 marriedname if marriagesomeoneelse!="" & (marriedid=="31" | marriedid=="32" | marriedid=="33"), clean noobs
/*
    HHID2010  
         103  
          55  
          64  
          68  
           7  
          71  
          99  
    ADSEM123  
     PSSEM93  
      RAEP71  
    RAMTP298  
    RANAT340  
    SISEM106  
     VENEP48  
     VENEP54  
	 
**************
      HHID2010        marriedname  
            21              Deepa  
            26             Sarasu  
            62        Mahalakshmi  
            78          Banumathy  
            78   Santhosh kumarie  
            82     Santhosh Kumar  
      ADKOR227        Porcheselvi  
     ANDMTP325          Kalaivani  
     ANDMTP329           Vasantha  
    ANTKARU278        Sivashakthi  
     RAKARU257            Kavitha  
     RAKARU257            Savitha  
     RAKARU258            Nagamma  
     RAKARU259         Mahalashmi  
       RAMPO27               Vasu  
      RAMTP301              Kuppu  
      RAMTP305            Lakshmi  
       RAOR379         Ajithkumar  
       SIGP190          Govinthan  
      SINAT333       Thamizhselvi  
      SISEM101         Sagunthala  
      VENGP177      Bhuvaneshwari  
      VENGP179            Thamizh  
     VENKOR219       Bakyalakshmi  
*/








********** BACK TO TEMPORARY PANEL DATA BASE TO CHECK ALL INDIVIDUALS
/*
Someone else without indications
*/
use"$directory\CLEAN\NEEMSIS2-HH_v6.dta", clear
gen mar=0

replace mar=1 if HHID2010=="103"  
replace mar=1 if HHID2010=="55"  
replace mar=1 if HHID2010=="64"  
replace mar=1 if HHID2010=="68"
replace mar=1 if HHID2010=="7" 
replace mar=1 if HHID2010=="71"  
replace mar=1 if HHID2010=="99" 
replace mar=1 if HHID2010=="ADSEM123"
replace mar=1 if HHID2010=="PSSEM93"
replace mar=1 if HHID2010=="RAEP71"
replace mar=1 if HHID2010=="RAMTP298" 
replace mar=1 if HHID2010=="RANAT340"   
replace mar=1 if HHID2010=="SISEM106"  
replace mar=1 if HHID2010=="VENEP48" 
replace mar=1 if HHID2010=="VENEP54" 
*
preserve
keep if mar==1
sort INDID2010
list INDID2010 INDID_left reasonlefthome name_p16 name maritalstatus_p16 maritalstatus sex_p16 _merge, clean noobs
restore
/*

Pour 103, la fille (/3) est le fils  (/4) se sont mariés : le fils est passé de unmarried à married et la fille est parti pour se marier..
Bon, je fais confiance au someone else en partant du principe que si ca avait été le fils, ils l'auraient sélectionné..
Même si lui je suis sûr qu'il s'est marié alors que la fille il peut y avoir un doute..

RAMTP298 deux filles parties pour mariage, pourquoi en avoir déclaré qu'un ?

      INDID2010   INDID_~t   reasonlef~e                 name_p16                     name      maritalstatus_p16          maritalstatus   sex_p16        _merge  
          103/1          .             .             Azhaganathan             Azhaganathan                Married                Married      Male   matched (3)  
          103/2          .             .                     Rani                     Rani                Married                Married    Female   matched (3)  
          103/3          1   Get married              Thatchayani              Thatchayani   Unmarried (above 10)                      .    Female   matched (3)  X
          103/4          .             .                  Rajavel                  Rajavel   Unmarried (above 10)                Married      Male   matched (3)  X
		  
           55/1          .             .                   Chitra                   Chitra                Married                Married    Female   matched (3)  
           55/2          .             .                Subramani                Subramani                Married                Married      Male   matched (3)  
           55/3          1   Get married                  Saranya                  Saranya                Married                      .    Female   matched (3)  X
           55/4          .             .                 Saranraj                 Saranraj   Unmarried (above 10)   Unmarried (above 10)      Male   matched (3)
		   
           64/1          .             .                     Velu                     Velu                Married                Married      Male   matched (3)
           64/2          .             .                 Pachayee                 Pachayee                Married                Married    Female   matched (3)  
           64/3          1   Get married               Padmavathy               Padmavathy                Married                      .    Female   matched (3)  X
           64/4          .             .                  Revathy                  Revathy   Unmarried (above 10)   Unmarried (above 10)    Female   matched (3)  
           64/5          .             .              Padmanathan              Padmanathan                      5   Unmarried (above 10)      Male   matched (3)  
		   
           68/7          4   Get married                  Revathi                  Revathi   Unmarried (above 10)                      .    Female   matched (3)  X
   
            7/4          1   Get married              Kamalavalli              Kamalavalli   Unmarried (above 10)                      .    Female   matched (3)  X
			
           71/3          1   Get married                Muthamizh                Muthamizh   Unmarried (above 10)                      .    Female   matched (3)  X
		   
           99/1          .             .                  Sambath                  Sambath                Married                Married      Male   matched (3)  
           99/2          .             .                   Andaal                   Andaal                Married                Married    Female   matched (3)  
           99/3          .             .            Thiruvengadam            Thiruvengadam   Unmarried (above 10)                Married      Male   matched (3)  X
           99/4          .             .             Rajamanikkam             Rajamanikkam   Unmarried (above 10)                Married      Male   matched (3)  X
           99/5          1          Died           Sanyasi pillai           Sanyasi pillai                Married                      .      Male   matched (3)  
		   
     ADSEM123/4          2   Get married                  Subshri                  Subshri   Unmarried (above 10)                      .    Female   matched (3)  X
	 
      PSSEM93/3          1   Get married           Muhammad azhar           Muhammad azhar   Unmarried (above 10)                      .      Male   matched (3)  X
	  
       RAEP71/5          2   Get married             Punithavathi             Punithavathi   Unmarried (above 10)                      .    Female   matched (3)  X
	   
     RAMTP298/3          1   Get married               Kalaiselvi               Kalaiselvi   Unmarried (above 10)                      .    Female   matched (3)  X
     RAMTP298/4          2   Get married                 Pavithra                 Pavithra   Unmarried (above 10)                      .    Female   matched (3)  X
	 
     RANAT340/3          1   Get married             Gunasundhari             Gunasundhari   Unmarried (above 10)                      .    Female   matched (3)  X
	 
     SISEM106/6          .             .               Manikandan               Manikandan   Unmarried (above 10)                Married      Male   matched (3)  X
     SISEM106/8          4   Get married                 Karthiga                 Karthiga                Married                      .    Female   matched (3)  X
	 
      VENEP48/3          1   Get married              Bremasheela              Bremasheela   Unmarried (above 10)                      .    Female   matched (3)  X

      VENEP54/3          1   Get married   Sivagami @ Sivasankari   Sivagami @ Sivasankari   Unmarried (above 10)                      .    Female   matched (3)  X
*/







********** BACK TO TEMPORARY PANEL DATA BASE TO CHECK ALL INDIVIDUALS
/*
Someone else with indications
*/
use"$directory\CLEAN\NEEMSIS2-HH_v6.dta", clear
gen mar=0

replace mar=1 if HHID2010=="21"  
replace mar=1 if HHID2010=="26"  
replace mar=1 if HHID2010=="62"  
replace mar=1 if HHID2010=="82"   
replace mar=1 if HHID2010=="ADKOR227"  
replace mar=1 if HHID2010=="ANDMTP329"  
replace mar=1 if HHID2010=="ANTKARU278" 
replace mar=1 if HHID2010=="RAKARU257" 
replace mar=1 if HHID2010=="RAKARU257" 
replace mar=1 if HHID2010=="RAKARU258" 
replace mar=1 if HHID2010=="RAKARU259" 
replace mar=1 if HHID2010=="RAMPO27"  
replace mar=1 if HHID2010=="RAMTP301" 
replace mar=1 if HHID2010=="RAOR379"  
replace mar=1 if HHID2010=="SIGP190"  
replace mar=1 if HHID2010=="SINAT333" 
replace mar=1 if HHID2010=="VENGP177" 
replace mar=1 if HHID2010=="VENGP179" 

replace mar=1 if HHID2010=="78" 
replace mar=1 if HHID2010=="78"
replace mar=1 if HHID2010=="ANDMTP325"
replace mar=1 if HHID2010=="RAMTP305"
replace mar=1 if HHID2010=="SISEM101"
replace mar=1 if HHID2010=="VENKOR219"     
*
preserve
keep if mar==1
sort INDID2010
list INDID2010 reasonlefthome name maritalstatus maritalstatus_p16 sex_p16, clean noobs
restore
/*
      HHID2010        marriedname  
            26             Sarasu  
            62        Mahalakshmi  
            78          Banumathy  
            78   Santhosh kumarie  
            82     Santhosh Kumar  
      ADKOR227        Porcheselvi  
     ANDMTP325          Kalaivani  
     ANDMTP329           Vasantha  
    ANTKARU278        Sivashakthi  
     RAKARU257            Kavitha  
     RAKARU257            Savitha  
     RAKARU258            Nagamma  
     RAKARU259         Mahalashmi  
       RAMPO27               Vasu  
      RAMTP301              Kuppu  
      RAMTP305            Lakshmi  
       RAOR379         Ajithkumar  
       SIGP190          Govinthan  
      SINAT333       Thamizhselvi  
      SISEM101         Sagunthala  
      VENGP177      Bhuvaneshwari  
      VENGP179            Thamizh  
     VENKOR219       Bakyalakshmi  


       INDID2010                            reasonlefthome                        name          maritalstatus      maritalstatus_p16   sex_p16  
            21/3                               Get married                       Deepa                      .   Unmarried (above 10)    Female  		
            26/3                               Get married                      Sarala                      .   Unmarried (above 10)    Female  
            62/5                               Get married                 Mahalakshmi                      .   Unmarried (above 10)    Female  
            78/4                               Get married                   Banumathy                      .                Married    Female  ?
            78/5                               Get married            Santhosh kumarie                      .                Married    Female  ?
            82/6                               Get married              Santhosh kumar                      .   Unmarried (above 10)      Male  
      ADKOR227/6                               Get married               Puratchiselvi                      .                Married    Female  ?
     ANDMTP325/3                               Get married          Kalaivani@jayanthi                      .                Married    Female  ?
     ANDMTP329/4                               Get married                    Vasantha                      .                Married    Female  ?
    ANTKARU278/5                               Get married                  Sivasakthi                      .   Unmarried (above 10)    Female  
     RAKARU257/2                               Get married                     Kavitha                      .                Married    Female  ?
     RAKARU257/3                               Get married                     Suvitha                      .   Unmarried (above 10)    Female  
     RAKARU258/3                               Get married                     Nagamma                      .   Unmarried (above 10)    Female  
     RAKARU259/6                               Get married                 Mahalakshmi                      .   Unmarried (above 10)    Female  
       RAMPO27/3                                         .                   Vasudevan                Married   Unmarried (above 10)      Male  ?
      RAMTP301/3                               Get married                       Kuppu                      .   Unmarried (above 10)    Female   
      RAMTP305/4                               Get married                     Lakshmi                      .   Unmarried (above 10)    Female  	  
       RAOR379/4                                         .                       Ajith                Married   Unmarried (above 10)      Male  ?
       SIGP190/6                                         .                    Govindan                Married   Unmarried (above 10)      Male  ?
      SINAT333/3                               Get married                 Thamizselvi                      .   Unmarried (above 10)    Female  
      SISEM101/3                               Get married                  Sagunthala                      .                Married    Female  ?
      VENGP177/3                               Get married                Buvaneshwari                      .   Unmarried (above 10)    Female 
      VENGP179/4                                         .                     Thamizh                Married   Unmarried (above 10)      Male  ?
     VENKOR219/2                               Get married               Bhakiyalashmi                      .                Married    Female  ?
*/	  








********** CHANGE CODE IN MARRIAGE DATA BASE
/*
Maintenant que nous avons identifié qui étaient les Someone else
Nous retournons dans la base marriage 2020 pour changer le marriedid avec
celui de 2016

Je fais avec une boucle pour gagner des lignes,
cependant, si il y a eu plus d'un mariage dans le HH je change à la main
*/
use"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v2.dta", replace
clonevar marriedid_o=marriedid

*INDID 2
foreach x in VENKOR219{
replace marriedid="2" if marriedid_o=="31" & HHID2010=="`x'"
}

*INDID 3
foreach x in 103 55 64 71 PSSEM93 RAMTP298 RANAT340 VENEP48 VENEP54 21 26 RAKARU258 RAMPO27 RAMTP301 SINAT333 VENGP177 ANDMTP325 SISEM101 {
replace marriedid="3" if marriedid_o=="31" & HHID2010=="`x'"
}

*INDID 4
foreach x in 7 99 ADSEM123 ANDMTP329 RAOR379 VENGP179 RAMTP305{
replace marriedid="4" if marriedid_o=="31" & HHID2010=="`x'"
}

*INDID 5
foreach x in RAEP71 62 ANTKARU278{
replace marriedid="5" if marriedid_o=="31" & HHID2010=="`x'"
}

*INDID 6
foreach x in SISEM106 82 ADKOR227 RAKARU259 SIGP190{
replace marriedid="6" if marriedid_o=="31" & HHID2010=="`x'"
}

*INDID 7
foreach x in 68 {
replace marriedid="7" if marriedid_o=="31" & HHID2010=="`x'"
}


*MORE THAN ONE MARRIAGE
replace marriedid="2" if marriedname=="Kavitha" & HHID2010=="RAKARU257"
replace marriedid="3" if marriedname=="Savitha" & HHID2010=="RAKARU257"

replace marriedid="4" if marriedname=="Banumathy" & HHID2010=="78"
replace marriedid="5" if marriedname=="Santhosh kumarie" & HHID2010=="78"



********** INTERMEDIATE CHECKING
destring marriedid, replace
destring marriedid_o, replace

gen verif=1 if (marriedid-marriedid_o)!=0
tab verif
drop verif

*INDID2010
egen INDID2010=concat(HHID2010 marriedid), p(/)


********** INTERMEDIATE SAVING
save"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v3.dta", replace

****************************************
* END











*********** MERGE MARRIAGE WITH HOUSEHOLD DATA BASE
use"$directory\CLEAN\NEEMSIS2-HH_v5.dta", clear
drop INDID2010 INDIDpanel
egen INDID2010=concat(HHID2010 INDID), p(/)
egen INDIDpanel=concat(HHID_panel INDID), p(/)
merge 1:1 INDID2010 using "$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v3.dta"
*list name marriedname marriagesomeoneelse if marriagedate!=., clean
drop _merge

gen dummy_marriageindivnew=0
replace dummy_marriageindivnew=1 if marriedid_o>15 & marriedid_o!=.
tab dummy_marriageindivnew

drop INDID2010 INDIDpanel
egen INDID2010=concat(HHID2010 INDID), p(/)
egen INDIDpanel=concat(HHID_panel INDID), p(/)
replace INDID2010="" if INDID_new!="."
replace INDIDpanel="" if INDID_new!="."
* INTERMEDIATE SAVING
save"$directory\CLEAN\NEEMSIS2-HH_v6.dta", replace
* BIG CLEAN
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup.dta"
erase"$directory\CLEAN\NEEMSIS_APPEND-hhquestionnaire-marriage-marriagegroup_v2.dta"

