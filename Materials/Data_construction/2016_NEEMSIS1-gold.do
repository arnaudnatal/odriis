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
global data = "NEEMSIS1-HH"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020



****************************************
* Gold 2016-17
***************************************
use"$data", clear

keep HHID2016 INDID2016 dummygold goldownerlist goldquantity demogoldquanti demogoldreasonbuy demogoldreasonbuyother dummygoldpledged goldquantitypledge goldamountpledge goldreasonpledge demogoldpledged demogoldreasonpledge


***** Save
gen goldquantity2=goldquantity
gen goldquantitypledge2=goldquantitypledge
gen goldamountpledge2=goldamountpledge


***** Realistic quantity?
ta goldquantity
/*
Extrems..
Need to correct after
*/

ta goldquantitypledge
/*
Same
*/


***** Manually recode outliers
/*
To check outliers, i use quantity of 2010 also
*/
merge m:m HHID2016 using "ODRIIS-HH_wide", keepusing(HHID2010)
keep if _merge==3
drop _merge
merge m:m HHID2010 using "outcomes/RUME-gold_HH", keepusing(goldquantity_HH)
drop if _merge==2
drop _merge
rename goldquantity_HH goldquantity_HH2010
order goldquantity_HH2010, after(goldquantity)
sort goldquantity2 HHID2016 INDID2016
gen n=_n
list n HHID2016 INDID2016 goldquantity_HH2010 goldquantity2 goldquantitypledge2 goldamountpledge2 if goldquantity!=., clean noobs 
/*
Above 100 grams it is strange, so check one by one
*/


* 160 grams   152 pledge     24000 pledge
replace goldquantity2=60 if HHID2016=="uuid:547e37d9-20f3-4553-be74-8e7a7e162e4f" & INDID2016==2
replace goldquantitypledge2=52 if HHID2016=="uuid:547e37d9-20f3-4553-be74-8e7a7e162e4f" & INDID2016==2

* 160 grams  40 pledge      50000 pledge
replace goldquantity2=60 if HHID2016=="uuid:a6097c43-dd3b-40d0-9d42-7350ecbd35ab" & INDID2016==2

* 160 grams  40 pledge      50000 pledge
replace goldquantity2=60 if HHID2016=="uuid:b674627c-df7d-4e5c-9778-70daa8d9a262" & INDID2016==2

* 200 grams  160 pledge      25000 pledge
replace goldquantity2=20 if HHID2016=="uuid:ba97ea13-f20c-4518-86b9-e29e4e091ce6" & INDID2016==1
replace goldquantitypledge2=16 if HHID2016=="uuid:ba97ea13-f20c-4518-86b9-e29e4e091ce6" & INDID2016==1

* 600 grams
replace goldquantity2=60 if HHID2016=="uuid:142053fe-243a-4035-8746-93dd30108d22" & INDID2016==4

* 1600 grams 1000 pledge 100 000 pledge
replace goldquantity2=160 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==6
replace goldquantitypledge2=100 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==6

* 520 grams for 1 indiv, 480 pledge, 900 000 pledge
replace goldquantity2=52 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" & INDID2016==2
replace goldquantitypledge2=48 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" & INDID2016==2
replace goldamountpledge2=90000 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" & INDID2016==2

*334 grams in HH, 320 grams for 1 indiv, 312 pledge, 500000 pledge
replace goldquantity2=20 if HHID2016=="uuid:ba25a879-1551-4520-a805-d270d69f34b0" & INDID2016==2
replace goldquantitypledge2=12 if HHID2016=="uuid:ba25a879-1551-4520-a805-d270d69f34b0" & INDID2016==2
replace goldamountpledge2=50000 if HHID2016=="uuid:ba25a879-1551-4520-a805-d270d69f34b0" & INDID2016==2

* 400        344     500000
replace goldquantity2=40 if HHID2016=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" & INDID2016==5
replace goldquantitypledge2=34 if HHID2016=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" & INDID2016==5
replace goldamountpledge2=50000 if HHID2016=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" & INDID2016==5

* 280        340     500000
replace goldquantity2=34 if HHID2016=="uuid:3502a333-6356-4267-ad32-ad6d32029c51" & INDID2016==2
replace goldquantitypledge2=28 if HHID2016=="uuid:3502a333-6356-4267-ad32-ad6d32029c51" & INDID2016==2
replace goldamountpledge2=50000 if HHID2016=="uuid:3502a333-6356-4267-ad32-ad6d32029c51" & INDID2016==2

* 400 304 450000
replace goldquantity2=40 if HHID2016=="uuid:ec9900c5-b81d-45b6-8318-461db0a4a976" & INDID2016==2
replace goldquantitypledge2=30 if HHID2016=="uuid:ec9900c5-b81d-45b6-8318-461db0a4a976" & INDID2016==2
replace goldamountpledge2=45000 if HHID2016=="uuid:ec9900c5-b81d-45b6-8318-461db0a4a976" & INDID2016==2

* 240 200 450000
replace goldquantity2=24 if HHID2016=="uuid:837acac5-1a51-4180-a716-bb3b1aaf5d03" & INDID2016==2
replace goldquantitypledge2=20 if HHID2016=="uuid:837acac5-1a51-4180-a716-bb3b1aaf5d03" & INDID2016==2
replace goldamountpledge2=45000 if HHID2016=="uuid:837acac5-1a51-4180-a716-bb3b1aaf5d03" & INDID2016==2

* 40 24 350005
replace goldamountpledge2=35000 if HHID2016=="uuid:8e0b0fc2-c75d-4646-a949-4c7749d6b3cc" & INDID2016==4

* 224 200 300000
replace goldquantity2=24 if HHID2016=="uuid:03448664-46ca-4519-8209-de355a7e8b31" & INDID2016==1
replace goldquantitypledge2=20 if HHID2016=="uuid:03448664-46ca-4519-8209-de355a7e8b31" & INDID2016==1
replace goldamountpledge2=30000 if HHID2016=="uuid:03448664-46ca-4519-8209-de355a7e8b31" & INDID2016==1

* 240 216 270000
replace goldquantity2=40 if HHID2016=="uuid:55609960-a8f0-465c-b1bb-c6b4239972c6" & INDID2016==1
replace goldquantitypledge2=16 if HHID2016=="uuid:55609960-a8f0-465c-b1bb-c6b4239972c6" & INDID2016==1
replace goldamountpledge2=27000 if HHID2016=="uuid:55609960-a8f0-465c-b1bb-c6b4239972c6" & INDID2016==1

* 96 14 250000
replace goldamountpledge2=25000 if HHID2016=="uuid:94e1ec13-3618-4995-bd9d-eb810d9ade40" & INDID2016==2

* 400 184 230000
replace goldquantity2=40 if HHID2016=="uuid:6b162917-4b4d-4787-a719-3fe27af6f755" & INDID2016==4
replace goldquantitypledge2=18 if HHID2016=="uuid:6b162917-4b4d-4787-a719-3fe27af6f755" & INDID2016==4
replace goldamountpledge2=23000 if HHID2016=="uuid:6b162917-4b4d-4787-a719-3fe27af6f755" & INDID2016==4

* 160 120 220000
replace goldquantity2=16 if HHID2016=="uuid:8ddf086d-0993-4ff7-813b-1f63dd46b1bf" & INDID2016==2
replace goldquantitypledge2=12 if HHID2016=="uuid:8ddf086d-0993-4ff7-813b-1f63dd46b1bf" & INDID2016==2
replace goldamountpledge2=20000 if HHID2016=="uuid:8ddf086d-0993-4ff7-813b-1f63dd46b1bf" & INDID2016==2

* 126 116 207000
replace goldquantity2=26 if HHID2016=="uuid:f75c3ee4-1112-46c0-9f23-897b8d6b43f3" & INDID2016==2
replace goldquantitypledge2=16 if HHID2016=="uuid:f75c3ee4-1112-46c0-9f23-897b8d6b43f3" & INDID2016==2
replace goldamountpledge2=20700 if HHID2016=="uuid:f75c3ee4-1112-46c0-9f23-897b8d6b43f3" & INDID2016==2

* 126        120     200000
replace goldquantity2=26 if HHID2016=="uuid:d6989469-10af-4d6d-8827-69ed49c4719f" & INDID2016==2
replace goldquantitypledge2=20 if HHID2016=="uuid:d6989469-10af-4d6d-8827-69ed49c4719f" & INDID2016==2
replace goldamountpledge2=20000 if HHID2016=="uuid:d6989469-10af-4d6d-8827-69ed49c4719f" & INDID2016==2

* 152 120 20000
replace goldquantity2=52 if HHID2016=="uuid:872313d4-988a-4cd3-ba30-3d59f68cac30" & INDID2016==4
replace goldquantitypledge2=20 if HHID2016=="uuid:872313d4-988a-4cd3-ba30-3d59f68cac30" & INDID2016==4
replace goldamountpledge2=20000 if HHID2016=="uuid:872313d4-988a-4cd3-ba30-3d59f68cac30" & INDID2016==4

* 240 200 200000
replace goldquantity2=24 if HHID2016=="uuid:5ddaed64-11cb-4a8a-a146-951b9d041a2a" & INDID2016==2
replace goldquantitypledge2=20 if HHID2016=="uuid:5ddaed64-11cb-4a8a-a146-951b9d041a2a" & INDID2016==2
replace goldamountpledge2=20000 if HHID2016=="uuid:5ddaed64-11cb-4a8a-a146-951b9d041a2a" & INDID2016==2

* 192 160 200000
replace goldquantity2=92 if HHID2016=="uuid:20e563c4-8f88-40b7-8279-425971394029" & INDID2016==2
replace goldquantitypledge2=60 if HHID2016=="uuid:20e563c4-8f88-40b7-8279-425971394029" & INDID2016==2
replace goldamountpledge2=120000 if HHID2016=="uuid:20e563c4-8f88-40b7-8279-425971394029" & INDID2016==2

* 136 120 200000
replace goldquantity2=36 if HHID2016=="uuid:1f120ace-1042-4eec-a398-851491a11b30" & INDID2016==2
replace goldquantitypledge2=20 if HHID2016=="uuid:1f120ace-1042-4eec-a398-851491a11b30" & INDID2016==2
replace goldamountpledge2=20000 if HHID2016=="uuid:1f120ace-1042-4eec-a398-851491a11b30" & INDID2016==2

* 120 108 165500
replace goldquantity2=12 if HHID2016=="uuid:fd4ce8ff-8fea-49a8-9e17-6ad2ffe308a3" & INDID2016==2
replace goldquantitypledge2=10 if HHID2016=="uuid:fd4ce8ff-8fea-49a8-9e17-6ad2ffe308a3" & INDID2016==2
replace goldamountpledge2=16550 if HHID2016=="uuid:fd4ce8ff-8fea-49a8-9e17-6ad2ffe308a3" & INDID2016==2

* 160 136 165000
replace goldquantity2=60 if HHID2016=="uuid:7c7e1aa9-4792-46b9-bcaa-b3d7e7b28327" & INDID2016==2
replace goldquantitypledge2=36 if HHID2016=="uuid:7c7e1aa9-4792-46b9-bcaa-b3d7e7b28327" & INDID2016==2
replace goldamountpledge2=65000 if HHID2016=="uuid:7c7e1aa9-4792-46b9-bcaa-b3d7e7b28327" & INDID2016==2

* 250 240 150000
replace goldquantity2=25 if HHID2016=="uuid:35c893c2-0912-40b9-9c97-148255aa8a4c" & INDID2016==1
replace goldquantitypledge2=24 if HHID2016=="uuid:35c893c2-0912-40b9-9c97-148255aa8a4c" & INDID2016==1
replace goldamountpledge2=50000 if HHID2016=="uuid:35c893c2-0912-40b9-9c97-148255aa8a4c" & INDID2016==1

* 240 80 145000
replace goldquantity2=24 if HHID2016=="uuid:96becde9-a23f-4f80-a5d0-7adf5ef61a67" & INDID2016==7
replace goldquantitypledge2=8 if HHID2016=="uuid:96becde9-a23f-4f80-a5d0-7adf5ef61a67" & INDID2016==7
replace goldamountpledge2=14500 if HHID2016=="uuid:96becde9-a23f-4f80-a5d0-7adf5ef61a67" & INDID2016==7


* 120 104 130000
replace goldquantity2=12 if HHID2016=="uuid:64b9823b-79fc-4917-8ef1-732005a38ba0" & INDID2016==3
replace goldquantitypledge2=10 if HHID2016=="uuid:64b9823b-79fc-4917-8ef1-732005a38ba0" & INDID2016==3
replace goldamountpledge2=13000 if HHID2016=="uuid:64b9823b-79fc-4917-8ef1-732005a38ba0" & INDID2016==3

* 160 100 100000
replace goldquantity2=16 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==6
replace goldquantitypledge2=10 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==6
replace goldamountpledge2=10000 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==6

*160 80 100000
replace goldquantity2=16 if HHID2016=="uuid:c2d03ebc-5c0e-415a-a655-001859f7a68f" & INDID2016==5
replace goldquantitypledge2=8 if HHID2016=="uuid:c2d03ebc-5c0e-415a-a655-001859f7a68f" & INDID2016==5
replace goldamountpledge2=10000 if HHID2016=="uuid:c2d03ebc-5c0e-415a-a655-001859f7a68f" & INDID2016==5

* 200 40 60000
replace goldquantity2=20 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" & INDID2016==2
replace goldquantitypledge2=4 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" & INDID2016==2
replace goldamountpledge2=6000 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" & INDID2016==2

* 360 96 60000
replace goldquantity2=36 if HHID2016=="uuid:687461f3-df83-4e62-b125-8b2525d79f13" & INDID2016==1
replace goldquantitypledge2=10 if HHID2016=="uuid:687461f3-df83-4e62-b125-8b2525d79f13" & INDID2016==1
replace goldamountpledge2=30000 if HHID2016=="uuid:687461f3-df83-4e62-b125-8b2525d79f13" & INDID2016==1

* 120 24 25000
replace goldquantity2=24 if HHID2016=="uuid:7b27a673-9ef9-4e74-af9e-975dc288c90c" & INDID2016==2
replace goldquantitypledge2=12 if HHID2016=="uuid:7b27a673-9ef9-4e74-af9e-975dc288c90c" & INDID2016==2

*120 72 10000
replace goldquantity2=12 if HHID2016=="uuid:0595322c-603f-4c45-a333-9f80c0c140fc" & INDID2016==3
replace goldquantitypledge2=7 if HHID2016=="uuid:0595322c-603f-4c45-a333-9f80c0c140fc" & INDID2016==3
replace goldamountpledge2=10000 if HHID2016=="uuid:0595322c-603f-4c45-a333-9f80c0c140fc" & INDID2016==3

* 120 80 80000
replace goldquantity2=12 if HHID2016=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" & INDID2016==1
replace goldquantitypledge2=8 if HHID2016=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" & INDID2016==1
replace goldamountpledge2=8000 if HHID2016=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" & INDID2016==1


* 480
replace goldquantity2=48 if HHID2016=="uuid:6b162917-4b4d-4787-a719-3fe27af6f755" & INDID2016==7

*400 and 300
replace goldquantity2=40 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==2
replace goldquantity2=30 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==4

*200
replace goldquantity2=20 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" & INDID2016==5
replace goldquantity2=20 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" & INDID2016==6
replace goldquantity2=20 if HHID2016=="uuid:142053fe-243a-4035-8746-93dd30108d22" & INDID2016==2

* 160
replace goldquantity2=16 if HHID2016=="uuid:0e075c0e-4b4a-461b-af2c-b61c39347738" & INDID2016==5

* 120
replace goldquantity2=12 if HHID2016=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" & INDID2016==7
replace goldquantity2=12 if HHID2016=="uuid:77cb7501-b16a-4783-9f3e-c1a84460fe88" & INDID2016==3

* 100
replace goldquantity2=10 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==10
replace goldquantity2=10 if HHID2016=="uuid:87686aa6-d251-45ab-80d2-1572d07af413" & INDID2016==3


***** HH level
bysort HHID2016: egen goldquantity_HH=sum(goldquantity2)
gen goldamount_HH=goldquantity_HH*2700
*sort goldamountpledge2 HHID2016 INDID2016
*list n HHID2016 INDID2016 goldquantity_HH2010 goldquantity_HH goldquantity2 goldquantitypledge2 goldamountpledge2 if goldquantity2!=., clean noobs 

sort goldquantity2 goldquantity_HH HHID2016 INDID2016
list n HHID2016 INDID2016 goldquantity_HH2010 goldquantity_HH goldquantity2 goldquantitypledge2 goldamountpledge2 if goldquantity2!=., clean noobs 
drop goldquantity_HH goldamount_HH



***** Pledge vs Owned quantity:
gen test=goldquantity2-goldquantitypledge2
ta test
/*
Neg means that pledge>total, suppose they reversed, so need to recoded:
*/
replace goldquantity2=goldquantitypledge2 if test<0
drop test


***** Quantity and amount pledge
gen test=goldamountpledge2/goldquantitypledge2
ta test
/*
Higher than 2700 strange as 2700 is the gold price
So, need to check the quantity and the price to observe outliers
*/
ta goldquantitypledge2 if test>2700
ta goldamountpledge2 if test>2700
/*
It seems that the quantity is good, so replace the price
*/
replace goldamountpledge2=goldquantitypledge2*2700 if test>2700
drop test


drop goldquantity_HH2010 n HHID2010
gen goldamount=goldquantity2*2700

preserve
bysort HHID2016: egen goldquantity_HH=sum(goldquantity)
bysort HHID2016: egen goldquantity2_HH=sum(goldquantity2)

keep *_HH
duplicates drop
tabstat goldquantity_HH goldquantity2_HH, stat(n mean cv q)
restore

save"outcomes\NEEMSIS1-gold", replace


***** HH level
bysort HHID2016: egen goldquantity_HH=sum(goldquantity2)
bysort HHID2016: egen goldquantitypledge_HH=sum(goldquantitypledge2)
bysort HHID2016: egen goldamountpledge_HH=sum(goldamountpledge2)
bysort HHID2016: egen goldamount_HH=sum(goldamount)

keep HHID2016 goldquantity_HH goldquantitypledge_HH goldamountpledge_HH goldamount_HH
duplicates drop
save"outcomes\NEEMSIS1-gold_HH", replace
****************************************
* END
