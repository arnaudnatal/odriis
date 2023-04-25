*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*April 25, 2023
*-----
* Nouveaux ménages à l'extérieur
*-----
cd"C:\Users\Arnaud\Documents\MEGA\Thesis\Thesis_Context_data\Analysis"
*-------------------------








****************************************
* New outside
****************************************
use"NEEMSIS2-HH", clear

* Selection
keep HHID2020 dummynewHH panelHH username villagename villageid dummyHHmigrant village_new villagearea householdid2020 newfrompanel villagenameparent villageareaparent householdidparent householdidparent_key interviewplace address villageareaparent
duplicates drop

* Stat
ta village_new dummyHHmigrant
/*
                      |    dummyHHmigrant
          village_new |         0          1 |     Total
----------------------+----------------------+----------
                Arani |         0          1 |         1 
                Athur |         0          5 |         5 
               Bavani |         0          2 |         2 
            Cengalpet |         0          1 |         1 
      Chembarambakkam |         0          1 |         1 
              Chennai |         0          4 |         4 
          Chidambaram |         0          1 |         1 
          Chithamanur |         0          1 |         1 
            Cuddalore |         0          2 |         2 
       Elanthalmpattu |        50          0 |        50 
                Erode |         0          2 |         2 
          Govulapuram |        47          0 |        47 
              Irumbai |         0          1 |         1 
             Irunthai |         0          1 |         1 
             Karukkai |         0          1 |         1 
             Karumbur |        60          0 |        60 
       Kolathancherry |         0          2 |         2 
            Korattore |        52          0 |        52 
            Kosapattu |         0          2 |         2 
  Kuchpalayam Koratur |         0          1 |         1 
        Kumarapalayam |         0          1 |         1 
              Kuvagam |        48          0 |        48 
              Lalgudi |         0          1 |         1 
Manamthavizhinthapu.. |        58          0 |        58 
           Manapakkam |        50          0 |        50 
          Manjakollai |         0          1 |         1 
         Melarungunam |         0          1 |         1 
   Nalla puli palayam |         0          1 |         1 
      Narasingapettai |         0          1 |         1 
               Natham |        55          0 |        55 
             Oraiyure |        68          0 |        68 
              Paathur |         0          1 |         1 
                Palur |         0          2 |         2 
              Panruti |         0          6 |         6 
      Pazhayaseevaram |         0          1 |         1 
      Perumal thangal |         0          1 |         1 
          Pondicherry |         0          3 |         3 
           Poonamalle |         0          5 |         5 
            Pulavanur |         0          1 |         1 
            Red hills |         0          3 |         3 
         Reddipalayam |         0          1 |         1 
              Retteri |         0          1 |         1 
       Sathirambakkam |         0          1 |         1 
                Selam |         0          1 |         1 
           Semakottai |        58          0 |        58 
       Sembarambakkam |         0          1 |         1 
         Siruvanthadu |         0          1 |         1 
              Somanur |         0          1 |         1 
       Thevayananthal |         0          1 |         1 
         Thirukovilur |         0          1 |         1 
        Thiruthurayur |         0          1 |         1 
          Thiruvallur |         0          4 |         4 
          Thiruvamoor |         0          1 |         1 
        Thiruvetriyur |         0          1 |         1 
          Thonankulam |         0          2 |         2 
        Thottapalayam |         0          1 |         1 
              Ullavur |         0          1 |         1 
         Vandipalayam |         0          1 |         1 
            Venpakkam |         0          1 |         1 
       Villiyambakkam |         0          2 |         2 
           Villupuram |         0          3 |         3 
               Walaja |         0          2 |         2 
----------------------+----------------------+----------
                Total |       546         86 |       632 
*/



ta dummyHHmigrant dummynewHH
/*
dummyHHmig |      dummynewHH
      rant |        No        Yes |     Total
-----------+----------------------+----------
         0 |       428        118 |       546 
         1 |        57         29 |        86 
-----------+----------------------+----------
     Total |       485        147 |       632
*/


ta panelHH dummynewHH
/*
                      |      dummynewHH
              panelHH |        No        Yes |     Total
----------------------+----------------------+----------
        New household |         0        147 |       147 
  NEEMSIS-1 household |       103          0 |       103 
RUME and NEEMSIS-1 ho |       382          0 |       382 
----------------------+----------------------+----------
                Total |       485        147 |       632 
*/


ta newfrompanel dummynewHH, m
/*
   Are the |
parents of |
       the |
 household |
 head part |
    of our |      dummynewHH
   sample? |        No        Yes |     Total
-----------+----------------------+----------
        No |         0         76 |        76 
       Yes |         0         61 |        61 
         . |       485         10 |       495 
-----------+----------------------+----------
     Total |       485        147 |       632 
*/
replace newfrompanel=0 if newfrompanel==. & dummynewHH==1


keep if dummynewHH==1
ta dummyHHmigrant

sort dummyHHmigrant newfrompanel village_new
br HHID2020 dummyHHmigrant village_new address newfrompanel villageareaparent



****************************************
* END
