*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Assets construction
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
* Gold 2020-21
***************************************
use"$data", clear

keep HHID2020 INDID2020 dummygold covsoldgold covsoldgoldquantity covlostgold dummygoldownerlist goldnumber goldquantity dummygoldpledged goldquantitypledge goldamountpledge covgoldpledged goldreasonpledge goldreasonpledgemain loanamountgold loandategold loanlendergold lenderscastegold lenderfromgold loansettledgold loanbalancegold


***** Save
gen goldquantity2=goldquantity
gen goldquantitypledge2=goldquantitypledge
gen goldamountpledge2=goldamountpledge
gen loanamountgold2=loanamountgold


***** Merge
preserve
use"outcomes/Goldpb_wide", clear
restore

merge m:m HHID2020 using"outcomes/Goldpb_wide"
keep if _merge==3
drop _merge
drop HHID2010 HHID2016

gen corr=0


***** Realistic quantity? Excel file with Antony
compress 
order HHID2020 INDID2020 goldquantity2 goldquantitypledge2 goldamountpledge2 loanamountgold2 pbdalits_HH2020 pbnondalits_HH2020 corr goldquantity2020 goldquantitypledge2020 goldamountpledge2020 goldquantity2016 goldquantitypledge2016 goldamountpledge2016
sort HHID2020 INDID2020



********** High amount to clean
order HHID2020 INDID2020 goldquantity2 goldquantitypledge2 goldamountpledge2 loanamountgold2 pbdalits_HH2020 pbnondalits_HH2020 corr goldquantity2020 goldquantitypledge2020 goldamountpledge2020 goldquantity2016 goldquantitypledge2016 goldamountpledge2016
sort goldquantity2 HHID2020 INDID2020

* 600 280 700000 40000
replace goldquantity2=60 if HHID2020=="uuid:4e9a4381-81ea-4e38-86f2-c7a3184b0d7e" & INDID2020==2
replace goldquantitypledge2=28 if HHID2020=="uuid:4e9a4381-81ea-4e38-86f2-c7a3184b0d7e" & INDID2020==2
replace goldamountpledge2=70000 if HHID2020=="uuid:4e9a4381-81ea-4e38-86f2-c7a3184b0d7e" & INDID2020==2
replace loanamountgold2=40000 if HHID2020=="uuid:4e9a4381-81ea-4e38-86f2-c7a3184b0d7e" & INDID2020==2
replace corr=1 if HHID2020=="uuid:4e9a4381-81ea-4e38-86f2-c7a3184b0d7e" & INDID2020==2

* 480
replace goldquantity2=48 if HHID2020=="uuid:3fe02e46-180b-4f5c-864b-ecda49e97656" & INDID2020==4
replace corr=1 if HHID2020=="uuid:3fe02e46-180b-4f5c-864b-ecda49e97656" & INDID2020==4

*400 160 500000 100000
replace goldquantity2=40 if HHID2020=="uuid:619e7076-c7e3-47d1-931b-24039121aa55" & INDID2020==2
replace goldquantitypledge2=16 if HHID2020=="uuid:619e7076-c7e3-47d1-931b-24039121aa55" & INDID2020==2
replace goldamountpledge2=40000 if HHID2020=="uuid:619e7076-c7e3-47d1-931b-24039121aa55" & INDID2020==2
replace loanamountgold2=10000 if HHID2020=="uuid:619e7076-c7e3-47d1-931b-24039121aa55" & INDID2020==2
replace corr=1 if HHID2020=="uuid:619e7076-c7e3-47d1-931b-24039121aa55" & INDID2020==2

* 400
replace goldquantity2=40 if HHID2020=="uuid:4e9a4381-81ea-4e38-86f2-c7a3184b0d7e" & INDID2020==6
replace corr=1 if HHID2020=="uuid:4e9a4381-81ea-4e38-86f2-c7a3184b0d7e" & INDID2020==6

* 400 320
replace goldquantity2=40 if HHID2020=="uuid:3fe02e46-180b-4f5c-864b-ecda49e97656" & INDID2020==2
replace goldquantitypledge2=32 if HHID2020=="uuid:3fe02e46-180b-4f5c-864b-ecda49e97656" & INDID2020==2
replace goldamountpledge2=85000 if HHID2020=="uuid:3fe02e46-180b-4f5c-864b-ecda49e97656" & INDID2020==2
replace loanamountgold2=85000 if HHID2020=="uuid:3fe02e46-180b-4f5c-864b-ecda49e97656" & INDID2020==2
replace corr=1 if HHID2020=="uuid:3fe02e46-180b-4f5c-864b-ecda49e97656" & INDID2020==2

*300
replace goldquantity2=30 if HHID2020=="uuid:4e9a4381-81ea-4e38-86f2-c7a3184b0d7e" & INDID2020==7
replace corr=1 if HHID2020=="uuid:4e9a4381-81ea-4e38-86f2-c7a3184b0d7e" & INDID2020==7

* 240 
replace goldquantity2=24 if HHID2020=="uuid:03eae81d-b4be-4200-b6f1-bcae0b8e2aa3" & INDID2020==2
replace corr=1 if HHID2020=="uuid:03eae81d-b4be-4200-b6f1-bcae0b8e2aa3" & INDID2020==2

*214 214
replace goldquantity2=21 if HHID2020=="uuid:be3a1fd7-1d0c-43aa-a9ff-b917f9130a7f" & INDID2020==1
replace goldquantitypledge2=21 if HHID2020=="uuid:be3a1fd7-1d0c-43aa-a9ff-b917f9130a7f" & INDID2020==1
replace goldamountpledge2=41500 if HHID2020=="uuid:be3a1fd7-1d0c-43aa-a9ff-b917f9130a7f" & INDID2020==1
replace corr=1 if HHID2020=="uuid:be3a1fd7-1d0c-43aa-a9ff-b917f9130a7f" & INDID2020==1

*208 128
replace goldquantity2=21 if HHID2020=="uuid:2a15b403-dea9-48e6-a1b8-57b067830add" & INDID2020==2
replace goldquantitypledge2=13 if HHID2020=="uuid:2a15b403-dea9-48e6-a1b8-57b067830add" & INDID2020==2
replace goldamountpledge2=25000 if HHID2020=="uuid:2a15b403-dea9-48e6-a1b8-57b067830add" & INDID2020==2
replace loanamountgold2=20000 if HHID2020=="uuid:2a15b403-dea9-48e6-a1b8-57b067830add" & INDID2020==2
replace corr=1 if HHID2020=="uuid:2a15b403-dea9-48e6-a1b8-57b067830add" & INDID2020==2

* 200 200
replace goldquantity2=20 if HHID2020=="uuid:d4b98efb-0cc6-4e82-996a-040ced0cbd52" & INDID2020==1
replace goldquantitypledge2=20 if HHID2020=="uuid:d4b98efb-0cc6-4e82-996a-040ced0cbd52" & INDID2020==1
replace goldamountpledge2=30000 if HHID2020=="uuid:d4b98efb-0cc6-4e82-996a-040ced0cbd52" & INDID2020==1
replace loanamountgold2=30000 if HHID2020=="uuid:d4b98efb-0cc6-4e82-996a-040ced0cbd52" & INDID2020==1
replace corr=1 if HHID2020=="uuid:d4b98efb-0cc6-4e82-996a-040ced0cbd52" & INDID2020==1


* 176 128 290000
replace goldquantity2=18 if HHID2020=="uuid:93a732f9-77e1-4da7-88f6-352721852510" & INDID2020==16
replace goldquantitypledge2=13 if HHID2020=="uuid:93a732f9-77e1-4da7-88f6-352721852510" & INDID2020==16
replace goldamountpledge2=29000 if HHID2020=="uuid:93a732f9-77e1-4da7-88f6-352721852510" & INDID2020==16
replace loanamountgold2=29000 if HHID2020=="uuid:93a732f9-77e1-4da7-88f6-352721852510" & INDID2020==16
replace corr=1 if HHID2020=="uuid:93a732f9-77e1-4da7-88f6-352721852510" & INDID2020==16

*200 200 500000
replace goldquantity2=40 if HHID2020=="uuid:496a8ebe-1d87-4dd8-886a-24ec26514474" & INDID2020==1
replace goldquantitypledge2=20 if HHID2020=="uuid:496a8ebe-1d87-4dd8-886a-24ec26514474" & INDID2020==1
replace goldamountpledge2=50000 if HHID2020=="uuid:496a8ebe-1d87-4dd8-886a-24ec26514474" & INDID2020==1
replace loanamountgold2=50000 if HHID2020=="uuid:496a8ebe-1d87-4dd8-886a-24ec26514474" & INDID2020==1
replace corr=1 if HHID2020=="uuid:496a8ebe-1d87-4dd8-886a-24ec26514474" & INDID2020==1

* 160 160 300000
replace goldquantity2=16 if HHID2020=="uuid:bd716ce9-7b96-4eae-a972-88c46dadc45b" & INDID2020==3
replace goldquantitypledge2=16 if HHID2020=="uuid:bd716ce9-7b96-4eae-a972-88c46dadc45b" & INDID2020==3
replace goldamountpledge2=30000 if HHID2020=="uuid:bd716ce9-7b96-4eae-a972-88c46dadc45b" & INDID2020==3
replace loanamountgold2=30000 if HHID2020=="uuid:bd716ce9-7b96-4eae-a972-88c46dadc45b" & INDID2020==3
replace corr=1 if HHID2020=="uuid:bd716ce9-7b96-4eae-a972-88c46dadc45b" & INDID2020==3

* 160 120 282000 200000
replace goldquantity2=16 if HHID2020=="uuid:05dbf9ff-89b9-418d-adc6-20705195200a" & INDID2020==2
replace goldquantitypledge2=12 if HHID2020=="uuid:05dbf9ff-89b9-418d-adc6-20705195200a" & INDID2020==2
replace goldamountpledge2=28200 if HHID2020=="uuid:05dbf9ff-89b9-418d-adc6-20705195200a" & INDID2020==2
replace loanamountgold2=20000 if HHID2020=="uuid:05dbf9ff-89b9-418d-adc6-20705195200a" & INDID2020==2
replace corr=1 if HHID2020=="uuid:05dbf9ff-89b9-418d-adc6-20705195200a" & INDID2020==2

* 120 120 250000
replace goldquantity2=12 if HHID2020=="uuid:89f0eed8-03fb-4e07-8773-90bd6e4c7530" & INDID2020==3
replace goldquantitypledge2=12 if HHID2020=="uuid:89f0eed8-03fb-4e07-8773-90bd6e4c7530" & INDID2020==3
replace goldamountpledge2=25000 if HHID2020=="uuid:89f0eed8-03fb-4e07-8773-90bd6e4c7530" & INDID2020==3
replace loanamountgold2=5000 if HHID2020=="uuid:89f0eed8-03fb-4e07-8773-90bd6e4c7530" & INDID2020==3
replace corr=1 if HHID2020=="uuid:89f0eed8-03fb-4e07-8773-90bd6e4c7530" & INDID2020==3

* 192 192 330000 80000
replace goldquantity2=19 if HHID2020=="uuid:12659065-bcc2-4803-92ae-b81b8897ee3d" & INDID2020==1
replace goldquantitypledge2=19 if HHID2020=="uuid:12659065-bcc2-4803-92ae-b81b8897ee3d" & INDID2020==1
replace goldamountpledge2=33000 if HHID2020=="uuid:12659065-bcc2-4803-92ae-b81b8897ee3d" & INDID2020==1
replace loanamountgold2=8000 if HHID2020=="uuid:12659065-bcc2-4803-92ae-b81b8897ee3d" & INDID2020==1
replace corr=1 if HHID2020=="uuid:12659065-bcc2-4803-92ae-b81b8897ee3d" & INDID2020==1

*128 128 300000 300000
replace goldquantity2=13 if HHID2020=="uuid:496a8ebe-1d87-4dd8-886a-24ec26514474" & INDID2020==2
replace goldquantitypledge2=13 if HHID2020=="uuid:496a8ebe-1d87-4dd8-886a-24ec26514474" & INDID2020==2
replace goldamountpledge2=30000 if HHID2020=="uuid:496a8ebe-1d87-4dd8-886a-24ec26514474" & INDID2020==2
replace loanamountgold2=30000 if HHID2020=="uuid:496a8ebe-1d87-4dd8-886a-24ec26514474" & INDID2020==2
replace corr=1 if HHID2020=="uuid:496a8ebe-1d87-4dd8-886a-24ec26514474" & INDID2020==2

* 160
replace goldquantity2=16 if HHID2020=="uuid:f612acf8-feb5-4d29-824f-6ec5448323e0" & INDID2020==6
replace corr=1 if HHID2020=="uuid:f612acf8-feb5-4d29-824f-6ec5448323e0" & INDID2020==6

* 160
replace goldquantity2=16 if HHID2020=="uuid:f612acf8-feb5-4d29-824f-6ec5448323e0" & INDID2020==10
replace corr=1 if HHID2020=="uuid:f612acf8-feb5-4d29-824f-6ec5448323e0" & INDID2020==10

*176 144 660000
replace goldquantity2=17 if HHID2020=="uuid:de6be2df-87c0-4f22-aaa2-43bb1b6ac4c0" & INDID2020==2
replace goldquantitypledge2=14 if HHID2020=="uuid:de6be2df-87c0-4f22-aaa2-43bb1b6ac4c0" & INDID2020==2
replace goldamountpledge2=40000 if HHID2020=="uuid:de6be2df-87c0-4f22-aaa2-43bb1b6ac4c0" & INDID2020==2
replace loanamountgold2=40000 if HHID2020=="uuid:de6be2df-87c0-4f22-aaa2-43bb1b6ac4c0" & INDID2020==2
replace corr=1 if HHID2020=="uuid:de6be2df-87c0-4f22-aaa2-43bb1b6ac4c0" & INDID2020==2

*160 24 150000 200000
replace goldquantity2=24 if HHID2020=="uuid:cb748595-aa39-4b85-9782-4d10e0e8117f" & INDID2020==5
replace goldquantitypledge2=16 if HHID2020=="uuid:cb748595-aa39-4b85-9782-4d10e0e8117f" & INDID2020==5
replace goldamountpledge2=20000 if HHID2020=="uuid:cb748595-aa39-4b85-9782-4d10e0e8117f" & INDID2020==5
replace loanamountgold2=15000 if HHID2020=="uuid:cb748595-aa39-4b85-9782-4d10e0e8117f" & INDID2020==5
replace corr=1 if HHID2020=="uuid:cb748595-aa39-4b85-9782-4d10e0e8117f" & INDID2020==5

* 160 16 32000 25000
replace goldquantity2=16 if HHID2020=="uuid:a5864c62-bf01-4313-a7b4-47985821c1e4" & INDID2020==2
replace corr=1 if HHID2020=="uuid:a5864c62-bf01-4313-a7b4-47985821c1e4" & INDID2020==2

* 120
replace goldquantity2=12 if HHID2020=="uuid:f435ac6b-11a5-4273-a5a0-d7f2bb74b5f6" & INDID2020==16
replace corr=1 if HHID2020=="uuid:f435ac6b-11a5-4273-a5a0-d7f2bb74b5f6" & INDID2020==16




********** Pledge vs Owned quantity
gen test=goldquantity2-goldquantitypledge2
/*
Neg means that pledge>total, suppose they reversed, so need to recoded:
*/
order HHID2020 INDID2020 goldquantity2 goldquantitypledge2 goldamountpledge2 loanamountgold2 pbdalits_HH2020 pbnondalits_HH2020 corr test goldquantity2020 goldquantitypledge2020 goldamountpledge2020 goldquantity2016 goldquantitypledge2016 goldamountpledge2016
sort test HHID2020 INDID2020

*64 140000 48
replace goldquantitypledge2=64 if HHID2020=="uuid:3936b5d3-2709-4669-9986-9f427fac869a" & INDID2020==2
replace goldamountpledge2=140000 if HHID2020=="uuid:3936b5d3-2709-4669-9986-9f427fac869a" & INDID2020==2
replace corr=1 if HHID2020=="uuid:3936b5d3-2709-4669-9986-9f427fac869a" & INDID2020==2

*8 80
replace goldquantity2=80 if HHID2020=="uuid:9bc0d4be-96cd-4d5e-aa71-98313b21905f" & INDID2020==2
replace loanamountgold2=173000 if HHID2020=="uuid:9bc0d4be-96cd-4d5e-aa71-98313b21905f" & INDID2020==2
replace corr=1 if HHID2020=="uuid:9bc0d4be-96cd-4d5e-aa71-98313b21905f" & INDID2020==2

*10 40
replace goldquantity2=40 if HHID2020=="uuid:a9e70587-aa67-4459-a216-4cf2c9d41779" & INDID2020==1
replace corr=1 if HHID2020=="uuid:a9e70587-aa67-4459-a216-4cf2c9d41779" & INDID2020==1

*6 32 125000 10000
replace goldquantity2=32 if HHID2020=="uuid:b311d822-6486-4be6-8134-de502f98c6f7" & INDID2020==1
replace goldquantitypledge2=16 if HHID2020=="uuid:b311d822-6486-4be6-8134-de502f98c6f7" & INDID2020==1
replace goldamountpledge2=12500 if HHID2020=="uuid:b311d822-6486-4be6-8134-de502f98c6f7" & INDID2020==1
replace loanamountgold2=10000 if HHID2020=="uuid:b311d822-6486-4be6-8134-de502f98c6f7" & INDID2020==1
replace corr=1 if HHID2020=="uuid:b311d822-6486-4be6-8134-de502f98c6f7" & INDID2020==1

*16 40
replace goldquantity2=46 if HHID2020=="uuid:5dc3364c-92ef-4756-8d98-2dd481a2d075" & INDID2020==2
replace corr=1 if HHID2020=="uuid:5dc3364c-92ef-4756-8d98-2dd481a2d075" & INDID2020==2

*8 32
replace goldquantity2=40 if HHID2020=="uuid:d3a5cc75-f7cd-4f68-b048-bac719c9313c" & INDID2020==2
replace corr=1 if HHID2020=="uuid:d3a5cc75-f7cd-4f68-b048-bac719c9313c" & INDID2020==2

*10 32
replace goldquantity2=42 if HHID2020=="uuid:edb471eb-ea16-46ba-9628-e68ff95cf64d" & INDID2020==4
replace goldamountpledge2=85000 if HHID2020=="uuid:edb471eb-ea16-46ba-9628-e68ff95cf64d" & INDID2020==4
replace loanamountgold2=85000 if HHID2020=="uuid:edb471eb-ea16-46ba-9628-e68ff95cf64d" & INDID2020==4
replace corr=1 if HHID2020=="uuid:edb471eb-ea16-46ba-9628-e68ff95cf64d" & INDID2020==2

*3 24
replace goldquantity2=27 if HHID2020=="uuid:8c4cfc51-9665-4ec5-b495-f3f4c531af66" & INDID2020==1
replace corr=1 if HHID2020=="uuid:8c4cfc51-9665-4ec5-b495-f3f4c531af66" & INDID2020==1

*3 24
replace goldquantity2=27 if HHID2020=="uuid:ba6d6ba4-b7a8-4e32-a96f-8bfba1ebd3b6" & INDID2020==1
replace corr=1 if HHID2020=="uuid:ba6d6ba4-b7a8-4e32-a96f-8bfba1ebd3b6" & INDID2020==1

*16 32
replace goldquantity2=48 if HHID2020=="uuid:bf220e69-6145-4536-9237-2912eb1dda5e" & INDID2020==2
replace corr=1 if HHID2020=="uuid:bf220e69-6145-4536-9237-2912eb1dda5e" & INDID2020==2

* 2 16
replace goldquantity2=18 if HHID2020=="uuid:8580ae36-e230-4d11-9619-5d8135f5e736" & INDID2020==1
replace loanamountgold2=40000 if HHID2020=="uuid:8580ae36-e230-4d11-9619-5d8135f5e736" & INDID2020==1
replace corr=1 if HHID2020=="uuid:8580ae36-e230-4d11-9619-5d8135f5e736" & INDID2020==1

* 10 24
replace goldquantity2=34 if HHID2020=="uuid:e12c0029-2759-42fa-8682-afbffadacdb3" & INDID2020==2
replace corr=1 if HHID2020=="uuid:e12c0029-2759-42fa-8682-afbffadacdb3" & INDID2020==2

*4 16
replace goldquantity2=20 if HHID2020=="uuid:30965eab-e285-48ce-9a2e-bedef927d3ac" & INDID2020==1
replace goldquantitypledge2=16 if HHID2020=="uuid:30965eab-e285-48ce-9a2e-bedef927d3ac" & INDID2020==1
replace goldamountpledge2=16000 if HHID2020=="uuid:30965eab-e285-48ce-9a2e-bedef927d3ac" & INDID2020==1
replace loanamountgold2=10000 if HHID2020=="uuid:30965eab-e285-48ce-9a2e-bedef927d3ac" & INDID2020==1
replace corr=1 if HHID2020=="uuid:30965eab-e285-48ce-9a2e-bedef927d3ac" & INDID2020==1

*16 28
replace goldquantity2=28 if HHID2020=="uuid:84b4b6c0-6d75-4a7f-9c3a-9c971a8a1bc6" & INDID2020==1
replace goldquantitypledge2=16 if HHID2020=="uuid:84b4b6c0-6d75-4a7f-9c3a-9c971a8a1bc6" & INDID2020==1
replace corr=1 if HHID2020=="uuid:84b4b6c0-6d75-4a7f-9c3a-9c971a8a1bc6" & INDID2020==1

*12 24
replace goldquantity2=24 if HHID2020=="uuid:930f624a-0ef6-455a-acbf-3c9ae59cb96f" & INDID2020==2
replace goldquantitypledge2=12 if HHID2020=="uuid:930f624a-0ef6-455a-acbf-3c9ae59cb96f" & INDID2020==2
replace corr=1 if HHID2020=="uuid:930f624a-0ef6-455a-acbf-3c9ae59cb96f" & INDID2020==2

* 4 16
replace goldquantity2=20 if HHID2020=="uuid:e01385a3-1bf3-46d6-a0f9-b80adf87d71b" & INDID2020==2
replace corr=1 if HHID2020=="uuid:e01385a3-1bf3-46d6-a0f9-b80adf87d71b" & INDID2020==2

*32 40
replace goldquantity2=40 if HHID2020=="uuid:30bed241-30bc-4213-81c6-0487cb913ca8" & INDID2020==2
replace goldquantitypledge2=32 if HHID2020=="uuid:30bed241-30bc-4213-81c6-0487cb913ca8" & INDID2020==2
replace corr=1 if HHID2020=="uuid:30bed241-30bc-4213-81c6-0487cb913ca8" & INDID2020==2

*16 24
replace goldquantity2=24 if HHID2020=="uuid:366ad214-48e8-41bd-9aa1-e82ba94fb99a" & INDID2020==1
replace goldquantitypledge2=16 if HHID2020=="uuid:366ad214-48e8-41bd-9aa1-e82ba94fb99a" & INDID2020==1
replace corr=1 if HHID2020=="uuid:366ad214-48e8-41bd-9aa1-e82ba94fb99a" & INDID2020==1

*2 8
replace goldquantity2=10 if HHID2020=="uuid:703c3ea8-c514-4611-8724-b03d68320fcf" & INDID2020==1
replace corr=1 if HHID2020=="uuid:703c3ea8-c514-4611-8724-b03d68320fcf" & INDID2020==1

*5 10
replace goldquantity2=15 if HHID2020=="uuid:b9ce5c9b-fdf6-40d2-9784-be3904293ee5" & INDID2020==1
replace corr=1 if HHID2020=="uuid:b9ce5c9b-fdf6-40d2-9784-be3904293ee5" & INDID2020==1

*8 4
replace goldquantity2=8 if HHID2020=="uuid:435ed027-bac6-423b-ad03-8abc0e9aecf7" & INDID2020==1
replace goldquantitypledge2=4 if HHID2020=="uuid:435ed027-bac6-423b-ad03-8abc0e9aecf7" & INDID2020==1
replace loanamountgold2=5500 if HHID2020=="uuid:435ed027-bac6-423b-ad03-8abc0e9aecf7" & INDID2020==1
replace corr=1 if HHID2020=="uuid:435ed027-bac6-423b-ad03-8abc0e9aecf7" & INDID2020==1



drop test




********** Quantity and amount pledge
gen test=goldamountpledge2/goldquantitypledge2
/*
Higher than 2700 strange as 2700 is the gold price
So, need to check the quantity and the price to observe outliers
Below 400 too
*/
order HHID2020 INDID2020 goldquantity2 goldquantitypledge2 goldamountpledge2 loanamountgold2 pbdalits_HH2020 pbnondalits_HH2020 corr test goldquantity2020 goldquantitypledge2020 goldamountpledge2020 goldquantity2016 goldquantitypledge2016 goldamountpledge2016
sort test HHID2020 INDID2020

replace goldamountpledge2=100000 if HHID2020=="uuid:4df12d9e-63a9-48e2-a962-517cc3ec8a65" & INDID2020==2
replace corr=1 if HHID2020=="uuid:4df12d9e-63a9-48e2-a962-517cc3ec8a65" & INDID2020==2

replace goldamountpledge2=75000 if HHID2020=="uuid:a2e54cd3-e9ca-4dba-945c-acb552cf74bf" & INDID2020==2
replace corr=1 if HHID2020=="uuid:a2e54cd3-e9ca-4dba-945c-acb552cf74bf" & INDID2020==2

replace goldamountpledge2=90000 if HHID2020=="uuid:f43c3bf6-4ffd-4093-860d-8efc06aa29b8" & INDID2020==2
replace loanamountgold2=90000 if HHID2020=="uuid:f43c3bf6-4ffd-4093-860d-8efc06aa29b8" & INDID2020==2
replace corr=1 if HHID2020=="uuid:f43c3bf6-4ffd-4093-860d-8efc06aa29b8" & INDID2020==2

replace goldamountpledge2=30000 if HHID2020=="uuid:3f46b232-e813-49da-870e-6427391b3429" & INDID2020==2
replace loanamountgold2=30000 if HHID2020=="uuid:3f46b232-e813-49da-870e-6427391b3429" & INDID2020==2
replace corr=1 if HHID2020=="uuid:3f46b232-e813-49da-870e-6427391b3429" & INDID2020==2

replace goldamountpledge2=40000 if HHID2020=="uuid:e6dee14b-0cdd-4c95-ab31-837aa7651b74" & INDID2020==18
replace loanamountgold2=40000 if HHID2020=="uuid:e6dee14b-0cdd-4c95-ab31-837aa7651b74" & INDID2020==18
replace corr=1 if HHID2020=="uuid:e6dee14b-0cdd-4c95-ab31-837aa7651b74" & INDID2020==18

replace goldamountpledge2=35000 if HHID2020=="uuid:1e92b7e8-0055-44a9-a77a-674c65efb544" & INDID2020==2
replace corr=1 if HHID2020=="uuid:1e92b7e8-0055-44a9-a77a-674c65efb544" & INDID2020==2

replace goldamountpledge2=30000 if HHID2020=="uuid:fbe7c190-7c95-40f4-ad97-69b66a5ceb72" & INDID2020==2
replace loanamountgold2=30000 if HHID2020=="uuid:fbe7c190-7c95-40f4-ad97-69b66a5ceb72" & INDID2020==2
replace corr=1 if HHID2020=="uuid:fbe7c190-7c95-40f4-ad97-69b66a5ceb72" & INDID2020==2

replace goldamountpledge2=50000 if HHID2020=="uuid:d69cba0a-b431-4f15-8e58-87b998d259e3" & INDID2020==2
replace loanamountgold2=50000 if HHID2020=="uuid:d69cba0a-b431-4f15-8e58-87b998d259e3" & INDID2020==2
replace corr=1 if HHID2020=="uuid:d69cba0a-b431-4f15-8e58-87b998d259e3" & INDID2020==2

replace goldamountpledge2=10000 if HHID2020=="uuid:7b70f238-d8fa-471b-8cd7-f89a30c1f9f4" & INDID2020==2
replace corr=1 if HHID2020=="uuid:7b70f238-d8fa-471b-8cd7-f89a30c1f9f4" & INDID2020==2

replace goldamountpledge2=50000 if HHID2020=="uuid:2bc1e724-7bd9-4f62-9f6f-911d5a747957" & INDID2020==2
replace loanamountgold2=30000 if HHID2020=="uuid:2bc1e724-7bd9-4f62-9f6f-911d5a747957" & INDID2020==2
replace corr=1 if HHID2020=="uuid:2bc1e724-7bd9-4f62-9f6f-911d5a747957" & INDID2020==2

replace loanamountgold2=12000 if HHID2020=="uuid:b71a4b81-2329-483e-b100-f883b48c1a91" & INDID2020==5
replace goldamountpledge2=12000 if HHID2020=="uuid:b71a4b81-2329-483e-b100-f883b48c1a91" & INDID2020==5
replace corr=1 if HHID2020=="uuid:b71a4b81-2329-483e-b100-f883b48c1a91" & INDID2020==5

replace goldquantitypledge2=10 if HHID2020=="uuid:0eacf77c-4f63-4ffc-80c9-f6b9da59fdba" & INDID2020==2
replace corr=1 if HHID2020=="uuid:0eacf77c-4f63-4ffc-80c9-f6b9da59fdba" & INDID2020==2

replace goldquantitypledge2=10 if HHID2020=="uuid:286b7eed-e160-458a-9e35-52a2507ed467" & INDID2020==2
replace loanamountgold2=15000 if HHID2020=="uuid:286b7eed-e160-458a-9e35-52a2507ed467" & INDID2020==2
replace corr=1 if HHID2020=="uuid:286b7eed-e160-458a-9e35-52a2507ed467" & INDID2020==2

replace goldquantitypledge2=20 if HHID2020=="uuid:61c1b410-c891-4c01-a18c-bafe994489f5" & INDID2020==1
replace loanamountgold2=10000 if HHID2020=="uuid:61c1b410-c891-4c01-a18c-bafe994489f5" & INDID2020==1
replace corr=1 if HHID2020=="uuid:61c1b410-c891-4c01-a18c-bafe994489f5" & INDID2020==1

replace goldamountpledge2=40000 if HHID2020=="uuid:65057613-d2d1-4b3c-a9d6-e7e1f3bbf9e7" & INDID2020==4
replace loanamountgold2=40000 if HHID2020=="uuid:65057613-d2d1-4b3c-a9d6-e7e1f3bbf9e7" & INDID2020==4
replace corr=1 if HHID2020=="uuid:65057613-d2d1-4b3c-a9d6-e7e1f3bbf9e7" & INDID2020==4

replace goldamountpledge2=50000 if HHID2020=="uuid:cb748595-aa39-4b85-9782-4d10e0e8117f" & INDID2020==2
replace loanamountgold2=35000 if HHID2020=="uuid:cb748595-aa39-4b85-9782-4d10e0e8117f" & INDID2020==2
replace corr=1 if HHID2020=="uuid:cb748595-aa39-4b85-9782-4d10e0e8117f" & INDID2020==2

replace goldamountpledge2=45000 if HHID2020=="uuid:a7632ff4-729b-4892-b701-44b74165d41a" & INDID2020==2
replace loanamountgold2=45000 if HHID2020=="uuid:a7632ff4-729b-4892-b701-44b74165d41a" & INDID2020==2
replace corr=1 if HHID2020=="uuid:a7632ff4-729b-4892-b701-44b74165d41a" & INDID2020==2

replace goldquantitypledge2=20 if HHID2020=="uuid:dcb6b6e2-b20c-4c21-aacf-f460d247b0ef" & INDID2020==2
replace goldamountpledge2=40000 if HHID2020=="uuid:dcb6b6e2-b20c-4c21-aacf-f460d247b0ef" & INDID2020==2
replace loanamountgold2=16000 if HHID2020=="uuid:dcb6b6e2-b20c-4c21-aacf-f460d247b0ef" & INDID2020==2
replace corr=1 if HHID2020=="uuid:dcb6b6e2-b20c-4c21-aacf-f460d247b0ef" & INDID2020==2

replace goldquantity2=20 if HHID2020=="uuid:5d241a40-46cf-4508-852d-d3c125e37604" & INDID2020==1
replace goldquantitypledge2=16 if HHID2020=="uuid:5d241a40-46cf-4508-852d-d3c125e37604" & INDID2020==1
replace goldamountpledge2=40000 if HHID2020=="uuid:5d241a40-46cf-4508-852d-d3c125e37604" & INDID2020==1
replace loanamountgold2=16000 if HHID2020=="uuid:5d241a40-46cf-4508-852d-d3c125e37604" & INDID2020==1
replace corr=1 if HHID2020=="uuid:5d241a40-46cf-4508-852d-d3c125e37604" & INDID2020==1

replace goldquantitypledge2=20 if HHID2020=="uuid:13eb6e71-2f36-4406-bcfa-b528a9c46d78" & INDID2020==3
replace corr=1 if HHID2020=="uuid:13eb6e71-2f36-4406-bcfa-b528a9c46d78" & INDID2020==3

replace goldamountpledge2=15000 if HHID2020=="uuid:b33ac02d-ffe0-4a63-8b4a-1ac442b86cf7" & INDID2020==2
replace loanamountgold2=15000 if HHID2020=="uuid:b33ac02d-ffe0-4a63-8b4a-1ac442b86cf7" & INDID2020==2
replace corr=1 if HHID2020=="uuid:b33ac02d-ffe0-4a63-8b4a-1ac442b86cf7" & INDID2020==2

replace goldamountpledge2=30000 if HHID2020=="uuid:79cefad2-b1d6-44ea-9d5d-12734c0dffd7" & INDID2020==1
replace loanamountgold2=30000 if HHID2020=="uuid:79cefad2-b1d6-44ea-9d5d-12734c0dffd7" & INDID2020==1
replace corr=1 if HHID2020=="uuid:79cefad2-b1d6-44ea-9d5d-12734c0dffd7" & INDID2020==1

replace goldamountpledge2=24500 if HHID2020=="uuid:b6f2cdf0-36d8-4106-905b-13b7d993c193" & INDID2020==16
replace loanamountgold2=24500 if HHID2020=="uuid:b6f2cdf0-36d8-4106-905b-13b7d993c193" & INDID2020==16
replace corr=1 if HHID2020=="uuid:b6f2cdf0-36d8-4106-905b-13b7d993c193" & INDID2020==16

replace goldamountpledge2=60000 if HHID2020=="uuid:af69024c-76b5-4331-8c4e-19874ea396e6" & INDID2020==1
replace loanamountgold2=20000 if HHID2020=="uuid:af69024c-76b5-4331-8c4e-19874ea396e6" & INDID2020==1
replace corr=1 if HHID2020=="uuid:af69024c-76b5-4331-8c4e-19874ea396e6" & INDID2020==1

replace goldamountpledge2=26000 if HHID2020=="uuid:367ad3c9-e3cb-458e-a6db-5a54e1221981" & INDID2020==3
replace loanamountgold2=10000 if HHID2020=="uuid:367ad3c9-e3cb-458e-a6db-5a54e1221981" & INDID2020==3
replace corr=1 if HHID2020=="uuid:367ad3c9-e3cb-458e-a6db-5a54e1221981" & INDID2020==3

replace goldamountpledge2=13000 if HHID2020=="uuid:cc5db495-5a2c-4ea5-9dc3-af828578c005" & INDID2020==2
replace loanamountgold2=13000 if HHID2020=="uuid:cc5db495-5a2c-4ea5-9dc3-af828578c005" & INDID2020==2
replace corr=1 if HHID2020=="uuid:cc5db495-5a2c-4ea5-9dc3-af828578c005" & INDID2020==2

replace goldquantitypledge2=18 if HHID2020=="uuid:ff95bdde-6012-4cf6-b7e8-be866fbaa68b" & INDID2020==2
replace corr=1 if HHID2020=="uuid:ff95bdde-6012-4cf6-b7e8-be866fbaa68b" & INDID2020==2

replace goldquantitypledge2=24 if HHID2020=="uuid:df35dad6-2d25-4bb4-847a-a1dde3ffa944" & INDID2020==1
replace goldamountpledge2=40000 if HHID2020=="uuid:df35dad6-2d25-4bb4-847a-a1dde3ffa944" & INDID2020==1
replace loanamountgold2=20000 if HHID2020=="uuid:df35dad6-2d25-4bb4-847a-a1dde3ffa944" & INDID2020==1
replace corr=1 if HHID2020=="uuid:df35dad6-2d25-4bb4-847a-a1dde3ffa944" & INDID2020==1

replace goldquantitypledge2=24 if HHID2020=="uuid:df35dad6-2d25-4bb4-847a-a1dde3ffa944" & INDID2020==1
replace corr=1 if HHID2020=="uuid:df35dad6-2d25-4bb4-847a-a1dde3ffa944" & INDID2020==1

replace goldamountpledge2=26000 if HHID2020=="uuid:d18158ec-d0a2-4dfb-80bd-d4109f6b0430" & INDID2020==2
replace loanamountgold2=20000 if HHID2020=="uuid:d18158ec-d0a2-4dfb-80bd-d4109f6b0430" & INDID2020==2
replace corr=1 if HHID2020=="uuid:d18158ec-d0a2-4dfb-80bd-d4109f6b0430" & INDID2020==2

replace goldquantitypledge2=24 if HHID2020=="uuid:c76f8b20-2118-499e-ba30-3666f3f6615a" & INDID2020==2
replace goldamountpledge2=25000 if HHID2020=="uuid:c76f8b20-2118-499e-ba30-3666f3f6615a" & INDID2020==2
replace loanamountgold2=20000 if HHID2020=="uuid:c76f8b20-2118-499e-ba30-3666f3f6615a" & INDID2020==2
replace corr=1 if HHID2020=="uuid:c76f8b20-2118-499e-ba30-3666f3f6615a" & INDID2020==2

replace goldamountpledge2=20000 if HHID2020=="uuid:c14788bc-235f-4690-b9bf-15bfde3788ef" & INDID2020==2
replace loanamountgold2=20000 if HHID2020=="uuid:c14788bc-235f-4690-b9bf-15bfde3788ef" & INDID2020==2
replace corr=1 if HHID2020=="uuid:c14788bc-235f-4690-b9bf-15bfde3788ef" & INDID2020==2

replace goldquantitypledge2=24 if HHID2020=="uuid:a4af1492-5ee4-4609-b17a-d12d9821f8c9" & INDID2020==2
replace goldamountpledge2=24000 if HHID2020=="uuid:a4af1492-5ee4-4609-b17a-d12d9821f8c9" & INDID2020==2
replace loanamountgold2=20000 if HHID2020=="uuid:a4af1492-5ee4-4609-b17a-d12d9821f8c9" & INDID2020==2
replace corr=1 if HHID2020=="uuid:a4af1492-5ee4-4609-b17a-d12d9821f8c9" & INDID2020==2

replace goldquantitypledge2=26 if HHID2020=="uuid:7761b0f9-98a1-42d7-8e92-f77d7fccc9e9" & INDID2020==4
replace corr=1 if HHID2020=="uuid:7761b0f9-98a1-42d7-8e92-f77d7fccc9e9" & INDID2020==4

replace goldamountpledge2=10000 if HHID2020=="uuid:7761b0f9-98a1-42d7-8e92-f77d7fccc9e9" & INDID2020==2
replace loanamountgold2=10000 if HHID2020=="uuid:7761b0f9-98a1-42d7-8e92-f77d7fccc9e9" & INDID2020==2
replace corr=1 if HHID2020=="uuid:7761b0f9-98a1-42d7-8e92-f77d7fccc9e9" & INDID2020==2

replace goldquantitypledge2=24 if HHID2020=="uuid:23fd63b5-39d4-40c9-810f-193d24449419" & INDID2020==2
replace corr=1 if HHID2020=="uuid:23fd63b5-39d4-40c9-810f-193d24449419" & INDID2020==2

replace goldamountpledge2=43000 if HHID2020=="uuid:1cc952cc-7e84-40a5-8601-221554de4586" & INDID2020==2
replace loanamountgold2=43000 if HHID2020=="uuid:1cc952cc-7e84-40a5-8601-221554de4586" & INDID2020==2
replace corr=1 if HHID2020=="uuid:1cc952cc-7e84-40a5-8601-221554de4586" & INDID2020==2

replace goldquantitypledge2=40 if HHID2020=="uuid:03e32009-5844-412d-a794-19940ae73716" & INDID2020==1
replace goldamountpledge2=100000 if HHID2020=="uuid:03e32009-5844-412d-a794-19940ae73716" & INDID2020==1
replace loanamountgold2=20000 if HHID2020=="uuid:03e32009-5844-412d-a794-19940ae73716" & INDID2020==1
replace corr=1 if HHID2020=="uuid:03e32009-5844-412d-a794-19940ae73716" & INDID2020==1

*Un peu délicat celui-ci, à voir si on doit vraiment le corriger ou pas
replace goldamountpledge2=48000 if HHID2020=="uuid:fcd7d8e8-6265-4a9c-9860-2d03def5253a" & INDID2020==1
replace loanamountgold2=48000 if HHID2020=="uuid:fcd7d8e8-6265-4a9c-9860-2d03def5253a" & INDID2020==1
replace corr=1 if HHID2020=="uuid:fcd7d8e8-6265-4a9c-9860-2d03def5253a" & INDID2020==1


*very small values
replace corr=1 if goldamountpledge2<1000
replace goldamountpledge2=loanamountgold2 if goldamountpledge2<1000

*revaloriser
replace goldamountpledge2=20000 if HHID2020=="uuid:f2e2edac-03f6-40f0-ac2a-8718fbd954e2" & INDID2020==4
replace loanamountgold2=20000 if HHID2020=="uuid:f2e2edac-03f6-40f0-ac2a-8718fbd954e2" & INDID2020==4
replace corr=1 if HHID2020=="uuid:f2e2edac-03f6-40f0-ac2a-8718fbd954e2" & INDID2020==4


drop test


********** Loan and gold amount
gen test=goldamountpledge2-loanamountgold2
/*
If neg = pb
*/
order HHID2020 INDID2020 goldquantity2 goldquantitypledge2 goldamountpledge2 loanamountgold2 pbdalits_HH2020 pbnondalits_HH2020 corr test goldquantity2020 goldquantitypledge2020 goldamountpledge2020 goldquantity2016 goldquantitypledge2016 goldamountpledge2016
sort test HHID2020 INDID2020

replace loanamountgold2=60000 if HHID2020=="uuid:e75da2e9-598c-4f8d-93f0-91d3329abf96" & INDID2020==2
replace corr=1 if HHID2020=="uuid:e75da2e9-598c-4f8d-93f0-91d3329abf96" & INDID2020==2

replace loanamountgold2=90000 if HHID2020=="uuid:17e456bc-0327-461c-9782-de911c716e4f" & INDID2020==2
replace corr=1 if HHID2020=="uuid:17e456bc-0327-461c-9782-de911c716e4f" & INDID2020==2

replace loanamountgold2=40000 if HHID2020=="uuid:a71ae1f6-84f7-4241-982d-840f9d68bf1e" & INDID2020==2
replace corr=1 if HHID2020=="uuid:a71ae1f6-84f7-4241-982d-840f9d68bf1e" & INDID2020==2

replace loanamountgold2=75000 if HHID2020=="uuid:83d1f6fc-59e8-4afe-b725-2b5eee50cce8" & INDID2020==4
replace corr=1 if HHID2020=="uuid:83d1f6fc-59e8-4afe-b725-2b5eee50cce8" & INDID2020==4

replace loanamountgold2=100000 if HHID2020=="uuid:39f64232-d9be-43c3-ba7f-307cb4caa971" & INDID2020==1
replace corr=1 if HHID2020=="uuid:39f64232-d9be-43c3-ba7f-307cb4caa971" & INDID2020==1

replace loanamountgold2=8000 if HHID2020=="uuid:ad69e5a5-278c-4190-9136-bbe08a021af8" & INDID2020==2
replace corr=1 if HHID2020=="uuid:ad69e5a5-278c-4190-9136-bbe08a021af8" & INDID2020==2

replace loanamountgold2=40000 if HHID2020=="uuid:05856ec6-7f65-4ce7-8207-a7205bfe98f4" & INDID2020==1
replace corr=1 if HHID2020=="uuid:05856ec6-7f65-4ce7-8207-a7205bfe98f4" & INDID2020==1

replace loanamountgold2=20000 if HHID2020=="uuid:6515c11e-c6e5-4ddc-beae-e7811b20d3a2" & INDID2020==2
replace corr=1 if HHID2020=="uuid:6515c11e-c6e5-4ddc-beae-e7811b20d3a2" & INDID2020==2

replace loanamountgold2=20000 if HHID2020=="uuid:72507eba-7ba3-41e6-b9c9-000fd02660eb" & INDID2020==2
replace corr=1 if HHID2020=="uuid:72507eba-7ba3-41e6-b9c9-000fd02660eb" & INDID2020==2

replace loanamountgold2=20000 if HHID2020=="uuid:a91affc5-be97-47b4-9e48-4ae070e467a2" & INDID2020==2
replace corr=1 if HHID2020=="uuid:a91affc5-be97-47b4-9e48-4ae070e467a2" & INDID2020==2

replace loanamountgold2=100000 if HHID2020=="uuid:ceff71c1-cfd4-49c1-89bb-f936c09e7b10" & INDID2020==2
replace corr=1 if HHID2020=="uuid:ceff71c1-cfd4-49c1-89bb-f936c09e7b10" & INDID2020==2

replace loanamountgold2=200000 if HHID2020=="uuid:d4a5192d-74e4-4cb8-8b48-1d971f68cb54" & INDID2020==2
replace corr=1 if HHID2020=="uuid:d4a5192d-74e4-4cb8-8b48-1d971f68cb54" & INDID2020==2

replace loanamountgold2=12000 if HHID2020=="uuid:4e56a1a6-6cde-4dbd-881f-d2d0c958ef2b" & INDID2020==2
replace corr=1 if HHID2020=="uuid:4e56a1a6-6cde-4dbd-881f-d2d0c958ef2b" & INDID2020==2

replace loanamountgold2=10000 if HHID2020=="uuid:a8f9b181-cd88-4dda-8059-6f97678fe0b5" & INDID2020==1
replace corr=1 if HHID2020=="uuid:a8f9b181-cd88-4dda-8059-6f97678fe0b5" & INDID2020==1

replace loanamountgold2=10000 if HHID2020=="uuid:de9a94b1-a3d8-4239-a78a-43a9467da0b9" & INDID2020==2
replace corr=1 if HHID2020=="uuid:de9a94b1-a3d8-4239-a78a-43a9467da0b9" & INDID2020==2

replace goldamountpledge2=18000 if HHID2020=="uuid:975dd5f4-3dcf-4502-abfb-f1bde5962657" & INDID2020==2
replace loanamountgold2=10000 if HHID2020=="uuid:975dd5f4-3dcf-4502-abfb-f1bde5962657" & INDID2020==2
replace corr=1 if HHID2020=="uuid:975dd5f4-3dcf-4502-abfb-f1bde5962657" & INDID2020==2

replace loanamountgold2=10000 if HHID2020=="uuid:63853ef1-cbc0-4a2f-9d66-46d0eb882758" & INDID2020==1
replace corr=1 if HHID2020=="uuid:63853ef1-cbc0-4a2f-9d66-46d0eb882758" & INDID2020==1

replace loanamountgold2=10000 if HHID2020=="uuid:ff2ee18b-8363-4316-96ea-5a41a37094c0" & INDID2020==1
replace corr=1 if HHID2020=="uuid:ff2ee18b-8363-4316-96ea-5a41a37094c0" & INDID2020==1

replace loanamountgold2=10000 if HHID2020=="uuid:88644fe9-66bb-41c7-afce-7e593439ff27" & INDID2020==3
replace corr=1 if HHID2020=="uuid:88644fe9-66bb-41c7-afce-7e593439ff27" & INDID2020==3

replace loanamountgold2=10000 if HHID2020=="uuid:c8079658-b595-43bd-9d2b-ff751d30580f" & INDID2020==2
replace corr=1 if HHID2020=="uuid:c8079658-b595-43bd-9d2b-ff751d30580f" & INDID2020==2

replace loanamountgold2=10000 if HHID2020=="uuid:709d60fb-5c77-48c4-a57d-8034816ae19f" & INDID2020==2
replace corr=1 if HHID2020=="uuid:709d60fb-5c77-48c4-a57d-8034816ae19f" & INDID2020==2

replace loanamountgold2=10000 if HHID2020=="uuid:7dcd5a01-7a25-47c3-b6c6-74836281cf4b" & INDID2020==2
replace corr=1 if HHID2020=="uuid:7dcd5a01-7a25-47c3-b6c6-74836281cf4b" & INDID2020==2

replace loanamountgold2=10000 if HHID2020=="uuid:8704f7a9-3b73-4ddc-b75a-6822acb20611" & INDID2020==2
replace corr=1 if HHID2020=="uuid:8704f7a9-3b73-4ddc-b75a-6822acb20611" & INDID2020==2

replace loanamountgold2=10000 if HHID2020=="uuid:c085269e-a8ea-423f-aff6-ed516652119b" & INDID2020==2
replace corr=1 if HHID2020=="uuid:c085269e-a8ea-423f-aff6-ed516652119b" & INDID2020==2

replace loanamountgold2=10000 if HHID2020=="uuid:1944c65c-4f4c-4d6a-be8a-b97086e7a0b0" & INDID2020==2
replace corr=1 if HHID2020=="uuid:1944c65c-4f4c-4d6a-be8a-b97086e7a0b0" & INDID2020==2

replace loanamountgold2=10000 if HHID2020=="uuid:845162bf-a21a-4003-910b-364e995bf863" & INDID2020==2
replace corr=1 if HHID2020=="uuid:845162bf-a21a-4003-910b-364e995bf863" & INDID2020==2


/*

************************************
************************************
************************************
************************************
************************************
************************************
************************************
************************************
************************************
************************************
************************************
************************************
************************************




27

*/





drop test











********** Clean
drop goldquantity2016 goldquantitypledge2016 goldamountpledge2016 pbdalits_HH2016 pbnondalits_HH2016 goldquantity22016 goldquantitypledge22016 goldamountpledge22016
drop goldquantity2020 goldquantitypledge2020 goldamountpledge2020 pbdalits_HH2020 pbnondalits_HH2020 goldquantity22020 goldquantitypledge22020 goldamountpledge22020
drop pbdalits_HH2010 pbnondalits_HH2010 goldquantity2010 goldquantitypledge2010 goldamountpledge2010 goldquantity22010 goldquantitypledge22010 goldamountpledge22010

ta corr
* 89 indiv corr
















***** Save
drop goldquantity_HH2016 n HHID2016
gen goldamount=goldquantity2*2700

preserve
bysort HHID2020: egen goldquantity_HH=sum(goldquantity)
bysort HHID2020: egen goldquantity2_HH=sum(goldquantity2)

keep *_HH
duplicates drop
tabstat goldquantity_HH goldquantity2_HH, stat(n mean cv q p90 p95 p99 min max)
restore

save"outcomes\NEEMSIS2-gold", replace


***** HH level
bysort HHID2020: egen goldquantity_HH=sum(goldquantity2)
bysort HHID2020: egen goldquantitypledge_HH=sum(goldquantitypledge2)
bysort HHID2020: egen goldamountpledge_HH=sum(goldamountpledge2)
bysort HHID2020: egen goldamount_HH=sum(goldamount)

keep HHID2020 goldquantity_HH goldquantitypledge_HH goldamountpledge_HH goldamount_HH
duplicates drop
save"outcomes\NEEMSIS2-gold_HH", replace
****************************************
* END










/*
* 900000
replace goldamountpledge2=90000 if HHID2020=="uuid:f43c3bf6-4ffd-4093-860d-8efc06aa29b8" & INDID2020==2
replace loanamountgold2=90000 if HHID2020=="uuid:f43c3bf6-4ffd-4093-860d-8efc06aa29b8" & INDID2020==2

* 1000000
replace goldamountpledge2=100000 if HHID2020=="uuid:4df12d9e-63a9-48e2-a962-517cc3ec8a65" & INDID2020==2

*750000
replace goldamountpledge2=75000 if HHID2020=="uuid:a2e54cd3-e9ca-4dba-945c-acb552cf74bf" & INDID2020==2

*500000
replace goldamountpledge2=50000 if HHID2020=="uuid:d69cba0a-b431-4f15-8e58-87b998d259e3" & INDID2020==2
replace loanamountgold2=50000 if HHID2020=="uuid:d69cba0a-b431-4f15-8e58-87b998d259e3" & INDID2020==2

*80 56     450000     450000 
replace goldamountpledge2=45000 if HHID2020=="uuid:a7632ff4-729b-4892-b701-44b74165d41a" & INDID2020==2
replace loanamountgold2=45000 if HHID2020=="uuid:a7632ff4-729b-4892-b701-44b74165d41a" & INDID2020==2

* 420000 30000
replace goldamountpledge2=42000 if HHID2020=="uuid:831ac2d3-8b2f-4936-9c96-515eb3940233" & INDID2020==2

* 214 214 415000 5000
replace goldquantity2=21 if HHID2020=="uuid:be3a1fd7-1d0c-43aa-a9ff-b917f9130a7f" & INDID2020==1
replace goldquantitypledge2=21 if HHID2020=="uuid:be3a1fd7-1d0c-43aa-a9ff-b917f9130a7f" & INDID2020==1
replace goldamountpledge2=15000 if HHID2020=="uuid:be3a1fd7-1d0c-43aa-a9ff-b917f9130a7f" & INDID2020==1

*400000 /10
replace goldamountpledge2=40000 if HHID2020=="uuid:e6dee14b-0cdd-4c95-ab31-837aa7651b74" & INDID2020==18
replace loanamountgold2=40000 if HHID2020=="uuid:e6dee14b-0cdd-4c95-ab31-837aa7651b74" & INDID2020==18
replace goldamountpledge2=40000 if HHID2020=="uuid:65057613-d2d1-4b3c-a9d6-e7e1f3bbf9e7" & INDID2020==4
replace loanamountgold2=40000 if HHID2020=="uuid:65057613-d2d1-4b3c-a9d6-e7e1f3bbf9e7" & INDID2020==4

* 120 40 350000 500000
replace goldquantity2=40 if HHID2020=="uuid:cb748595-aa39-4b85-9782-4d10e0e8117f" & INDID2020==2
replace goldquantitypledge2=12 if HHID2020=="uuid:cb748595-aa39-4b85-9782-4d10e0e8117f" & INDID2020==2
replace goldamountpledge2=35000 if HHID2020=="uuid:cb748595-aa39-4b85-9782-4d10e0e8117f" & INDID2020==2
replace loanamountgold2=35000 if HHID2020=="uuid:cb748595-aa39-4b85-9782-4d10e0e8117f" & INDID2020==2

* 350000
replace goldamountpledge2=35000 if HHID2020=="uuid:1e92b7e8-0055-44a9-a77a-674c65efb544" & INDID2020==2

* 300000
replace goldamountpledge2=30000 if HHID2020=="uuid:3f46b232-e813-49da-870e-6427391b3429" & INDID2020==2
replace loanamountgold2=30000 if HHID2020=="uuid:3f46b232-e813-49da-870e-6427391b3429" & INDID2020==2

*500000
replace goldamountpledge2=50000 if HHID2020=="uuid:2bc1e724-7bd9-4f62-9f6f-911d5a747957" & INDID2020==2
replace loanamountgold2=30000 if HHID2020=="uuid:2bc1e724-7bd9-4f62-9f6f-911d5a747957" & INDID2020==2

*245000
replace goldamountpledge2=24500 if HHID2020=="uuid:b6f2cdf0-36d8-4106-905b-13b7d993c193" & INDID2020==16
replace loanamountgold2=24500 if HHID2020=="uuid:b6f2cdf0-36d8-4106-905b-13b7d993c193" & INDID2020==16

* 120 80
replace goldquantity2=12 if HHID2020=="uuid:1f6677b5-5a9d-4892-b5ab-b70f32d53615" & INDID2020==2
replace goldquantitypledge2=8 if HHID2020=="uuid:1f6677b5-5a9d-4892-b5ab-b70f32d53615" & INDID2020==2
replace goldamountpledge2=23000 if HHID2020=="uuid:1f6677b5-5a9d-4892-b5ab-b70f32d53615" & INDID2020==2
replace loanamountgold2=23000 if HHID2020=="uuid:1f6677b5-5a9d-4892-b5ab-b70f32d53615" & INDID2020==2

* 120 80
replace goldquantity2=12 if HHID2020=="uuid:d4a5192d-74e4-4cb8-8b48-1d971f68cb54" & INDID2020==2
replace goldquantitypledge2=8 if HHID2020=="uuid:d4a5192d-74e4-4cb8-8b48-1d971f68cb54" & INDID2020==2
replace goldamountpledge2=30000 if HHID2020=="uuid:d4a5192d-74e4-4cb8-8b48-1d971f68cb54" & INDID2020==2
replace loanamountgold2=20000 if HHID2020=="uuid:d4a5192d-74e4-4cb8-8b48-1d971f68cb54" & INDID2020==2

* 80 80 320000 50000
replace goldamountpledge2=100000 if HHID2020=="uuid:7c99c8dc-8da1-4dda-8b93-236f99cc98d2" & INDID2020==2

*300000
replace goldamountpledge2=30000 if HHID2020=="uuid:fbe7c190-7c95-40f4-ad97-69b66a5ceb72" & INDID2020==2
replace loanamountgold2=30000 if HHID2020=="uuid:fbe7c190-7c95-40f4-ad97-69b66a5ceb72" & INDID2020==2

*30000
replace goldamountpledge2=30000 if HHID2020=="uuid:79cefad2-b1d6-44ea-9d5d-12734c0dffd7" & INDID2020==1

* 80 80 210000
replace goldquantity2=8 if HHID2020=="uuid:ea20a948-0e03-4bf5-ad8c-abe731ee2fe0" & INDID2020==1
replace goldquantitypledge2=8 if HHID2020=="uuid:ea20a948-0e03-4bf5-ad8c-abe731ee2fe0" & INDID2020==1
replace goldamountpledge2=21000 if HHID2020=="uuid:ea20a948-0e03-4bf5-ad8c-abe731ee2fe0" & INDID2020==1
replace loanamountgold2=21000 if HHID2020=="uuid:ea20a948-0e03-4bf5-ad8c-abe731ee2fe0" & INDID2020==1

* 20000 26000
replace goldamountpledge2=26000 if HHID2020=="uuid:d18158ec-d0a2-4dfb-80bd-d4109f6b0430" & INDID2020==2
replace loanamountgold2=20000 if HHID2020=="uuid:d18158ec-d0a2-4dfb-80bd-d4109f6b0430" & INDID2020==2

* 80 80 200000 200000
replace goldquantity2=8 if HHID2020=="uuid:c68d90f2-d76b-41bb-a58e-b82fd2bde6af" & INDID2020==16
replace goldquantitypledge2=8 if HHID2020=="uuid:c68d90f2-d76b-41bb-a58e-b82fd2bde6af" & INDID2020==16
replace goldamountpledge2=20000 if HHID2020=="uuid:c68d90f2-d76b-41bb-a58e-b82fd2bde6af" & INDID2020==16
replace loanamountgold2=20000 if HHID2020=="uuid:c68d90f2-d76b-41bb-a58e-b82fd2bde6af" & INDID2020==16

* 60 40 200000
replace goldquantity2=6 if HHID2020=="uuid:c14788bc-235f-4690-b9bf-15bfde3788ef" & INDID2020==2
replace goldquantitypledge2=4 if HHID2020=="uuid:c14788bc-235f-4690-b9bf-15bfde3788ef" & INDID2020==2
replace goldamountpledge2=20000 if HHID2020=="uuid:c14788bc-235f-4690-b9bf-15bfde3788ef" & INDID2020==2
replace loanamountgold2=20000 if HHID2020=="uuid:c14788bc-235f-4690-b9bf-15bfde3788ef" & INDID2020==2
*/
