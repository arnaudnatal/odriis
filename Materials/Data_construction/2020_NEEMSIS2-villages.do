*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Villages construction
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox\RUME-NEEMSIS\Data\Construction"
cd"$directory"

********** Database names
global data = "NEEMSIS2-HH"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020





****************************************
* Villages
***************************************
use"$data", clear

keep HHID2020 villagename address villageid village_new villagearea villageareaid
duplicates drop

sort village_new

ta village_new




********** Area
gen area=""

*** ELA
replace area="Elanthalmpattu" if village_new=="Elanthalmpattu"

*** GOV
replace area="Govulapuram" if village_new=="Govulapuram"

*** KAR
replace area="Karumbur" if village_new=="Karumbur"

*** KOR
replace area="Korattore" if village_new=="Korattore"
replace area="Korattor" if village_new=="Kuchpalayam Koratur"

*** KUV
replace area="Kuvagam" if village_new=="Kuvagam"

*** MANAM
replace area="Manamthavizhinthaputhur" if village_new=="Manamthavizhinthaputhur"

*** MAN
replace area="Manapakkam" if village_new=="Manapakkam"

*** NAT
replace area="Natham" if village_new=="Natham"

*** ORA
replace area="Oraiyure" if village_new=="Oraiyure"

*** SEM
replace area="Semakottai" if village_new=="Semakottai"

*** Erode region
replace area="Erode area" if village_new=="Erode"
replace area="Erode area" if village_new=="Kumarapalayam"
replace area="Erode area" if village_new=="Bavani"

*** Kumbakonam region
replace area="Kumbakonam area" if village_new=="Palur"
replace area="Kumbakonam area" if village_new=="Narasingapettai"

*** Chennai region
replace area="Chennai area" if village_new=="Red hills"
replace area="Chennai area" if village_new=="Retteri"
replace area="Chennai area" if village_new=="Chennai"
replace area="Chennai area" if village_new=="Poonamalle"
replace area="Chennai area" if village_new=="Chembarambakkam"
replace area="Chennai area" if village_new=="Paathur"

*** Chengalpattu region
replace area="Chengalpattu area" if village_new=="Venpakkam"
replace area="Chengalpattu area" if village_new=="Cengalpet"
replace area="Chengalpattu area" if village_new=="Athur"
replace area="Chengalpattu area" if village_new=="Chithamanur"
replace area="Chengalpattu area" if village_new=="Sathirambakkam"
replace area="Chengalpattu area" if village_new=="Kolathancherry"
replace area="Chengalpattu area" if village_new=="Reddipalayam"
replace area="Chengalpattu area" if village_new=="Villiyambakkam"
replace area="Chengalpattu area" if village_new=="Perumal thangal"

*** Kanchipuram region
replace area="Kanchipuram area" if village_new=="Pazhayaseevaram"
replace area="Kanchipuram area" if village_new=="Thonankulam"
replace area="Kanchipuram area" if village_new=="Walaja"
replace area="Kanchipuram area" if village_new=="Ullavur"
replace area="Kanchipuram area" if village_new=="Sembarambakkam"

*** Pondicherry
replace area="Pondicherry area" if village_new=="Pondicherry"
replace area="Pondicherry area" if village_new=="Irumbai"

*** Velore
replace area="Vellore area" if village_new=="Arani"
replace area="Vellore area" if village_new=="Thottapalayam"


ta area
ta village_new if area==""






********** Urban / Rural / Half
*** Urban
gen urban=0

replace urban=1 if village_new=="Chidambaram"
replace urban=1 if village_new=="Somanur"
replace urban=1 if village_new=="Erode"
replace urban=1 if village_new=="Bavani"
replace urban=1 if village_new=="Selam"
replace urban=1 if village_new=="Thottapalayam"
replace urban=1 if village_new=="Arani"
replace urban=1 if village_new=="Thiruvallur"
replace urban=1 if village_new=="Chennai"
replace urban=1 if village_new=="Retteri"
replace urban=1 if village_new=="Red hills"
replace urban=1 if village_new=="Paathur"
replace urban=1 if village_new=="Cengalpet"
replace urban=1 if village_new=="Walaja"
replace urban=1 if village_new=="Pondicherry"
replace urban=1 if village_new=="Villupuram"
replace urban=1 if village_new=="Cuddalore"
replace urban=1 if village_new=="Panruti"
replace urban=1 if village_new=="Chithamanur"


*** Rural
gen rural=0

replace rural=1 if village_new=="Thiruvetriyur"
replace rural=1 if village_new=="Palur"
replace rural=1 if village_new=="Narasingapettai"
replace rural=1 if village_new=="Kosapattu"
replace rural=1 if village_new=="Sembarambakkam"
replace rural=1 if village_new=="Villiyambakkam"
replace rural=1 if village_new=="Sathirambakkam"
replace rural=1 if village_new=="Perumal thangal"
replace rural=1 if village_new=="Reddipalayam"
replace rural=1 if village_new=="Kolathancherry"
replace rural=1 if village_new=="Ullavur"
replace rural=1 if village_new=="Thonankulam"
replace rural=1 if village_new=="Pazhayaseevaram"
replace rural=1 if village_new=="Irumbai"
replace rural=1 if village_new=="Thevayananthal"
replace rural=1 if village_new=="Siruvanthadu"
replace rural=1 if village_new=="Pulavanur"
replace rural=1 if village_new=="Thiruthurayur"
replace rural=1 if village_new=="Thiruvamoor"
replace rural=1 if village_new=="Karukkai"
replace rural=1 if village_new=="Vandipalayam"
replace rural=1 if village_new=="Irunthai"
replace rural=1 if village_new=="Kuchpalayam Koratur"
replace rural=1 if village_new=="Elanthalmpattu"
replace rural=1 if village_new=="Govulapuram"
replace rural=1 if village_new=="Karumbur"
replace rural=1 if village_new=="Korattore"
replace rural=1 if village_new=="Kuvagam"
replace rural=1 if village_new=="Manamthavizhinthaputhur"
replace rural=1 if village_new=="Manapakkam"
replace rural=1 if village_new=="Natham"
replace rural=1 if village_new=="Oraiyure"
replace rural=1 if village_new=="Semakottai"
replace rural=1 if village_new=="Melarungunam"
replace rural=1 if village_new=="Nalla puli palayam"

*** Half 
gen half=0

replace half=1 if village_new=="Manjakollai"
replace half=1 if village_new=="Lalgudi"
replace half=1 if village_new=="Kumarapalayam"
replace half=1 if village_new=="Chembarambakkam"
replace half=1 if village_new=="Poonamalle"
replace half=1 if village_new=="Venpakkam"
replace half=1 if village_new=="Athur"
replace half=1 if village_new=="Thirukovilur"


*** Categorical variable
gen livingarea=0
replace livingarea=1 if rural==1 & urban==0 & half==0
replace livingarea=2 if rural==0 & urban==1 & half==0
replace livingarea=3 if rural==0 & urban==0 & half==1

label define livingarea 1"Rural" 2"Urban" 3"Half"
label values livingarea livingarea

fre livingarea



********** Ring
*** Original
gen originalvillage=0

replace originalvillage=1 if village_new=="Elanthalmpattu"
replace originalvillage=1 if village_new=="Govulapuram"
replace originalvillage=1 if village_new=="Karumbur"
replace originalvillage=1 if village_new=="Korattore"
replace originalvillage=1 if village_new=="Kuchpalayam Koratur"
replace originalvillage=1 if village_new=="Kuvagam"
replace originalvillage=1 if village_new=="Manamthavizhinthaputhur"
replace originalvillage=1 if village_new=="Manapakkam"
replace originalvillage=1 if village_new=="Natham"
replace originalvillage=1 if village_new=="Oraiyure"
replace originalvillage=1 if village_new=="Semakottai"

*** Neighbor villages
gen neighborvillage=0
replace neighborvillage=1 if village_new=="Irunthai"
replace neighborvillage=1 if village_new=="Vandipalayam"
replace neighborvillage=1 if village_new=="Karukkai"
replace neighborvillage=1 if village_new=="Thiruvamoor"
replace neighborvillage=1 if village_new=="Thiruthurayur"
replace neighborvillage=1 if village_new=="Pulavanur"
replace neighborvillage=1 if village_new=="Siruvanthadu"

*** Neighbor villages second belt
gen neighborvillage2=0
replace neighborvillage2=1 if village_new=="Nalla puli palayam"
replace neighborvillage2=1 if village_new=="Melarungunam"
replace neighborvillage2=1 if village_new=="Irumbai"
replace neighborvillage2=1 if village_new=="Thevayananthal"


*** Neighbor city
gen neighborcity=0
replace neighborcity=1 if village_new=="Panruti"
replace neighborcity=1 if village_new=="Pondicherry"
replace neighborcity=1 if village_new=="Cuddalore"
replace neighborcity=1 if village_new=="Villuppuram"
replace neighborcity=1 if village_new=="Thirukoilure"

*** Neighbor city second belt
gen neighborcity2=0
replace neighborcity2=1 if village_new=="Chidambaram"

*** Categorical
gen neighborarea=0
replace neighborarea=1 if originalvillage==1
replace neighborarea=2 if neighborvillage==1
replace neighborarea=3 if neighborcity==1
replace neighborarea=4 if neighborvillage2==1
replace neighborarea=5 if neighborcity2==1

label define neighborarea 0"Far from origin" 1"Original villages" 2"Neighbor villages" 3"Neighbor cities" 4"Second ring villages" 5"Second ring cities"
label values neighborarea neighborarea

fre neighborarea



keep HHID2020 villagearea villagename2010 villagename2016 villagename2016_club town_close near_panruti near_villupur near_tirup near_chengal near_kanchip near_chennai most_remote
duplicates drop

fre villagename2010
fre villagename2016
fre villagename2016_club


save"outcomes\NEEMSIS1-villages", replace
****************************************
* END
