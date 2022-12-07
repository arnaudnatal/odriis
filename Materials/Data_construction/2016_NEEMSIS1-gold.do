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


***** Merge
preserve
use"outcomes/Goldpb_wide", clear
restore

merge m:m HHID2016 using"outcomes/Goldpb_wide"
keep if _merge==3
drop _merge
drop HHID2010 HHID2020

gen corr=0


***** Realistic quantity? Excel file with Antony
compress 
order HHID2016 INDID2016 goldquantity2 goldquantitypledge2 goldamountpledge2 pbdalits_HH2016 pbnondalits_HH2016 corr goldquantity2016 goldquantitypledge2016 goldamountpledge2016 goldquantity2020 goldquantitypledge2020 goldamountpledge2020
sort HHID2016 INDID2016



********** High amount to clean
order HHID2016 INDID2016 goldquantity2 goldquantitypledge2 goldamountpledge2 pbdalits_HH2016 pbnondalits_HH2016 corr goldquantity2016 goldquantitypledge2016 goldamountpledge2016 goldquantity2020 goldquantitypledge2020 goldamountpledge2020
sort goldquantity2 HHID2016 INDID2016

*1600 1000 100000
replace goldquantity2=160 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==6
replace goldquantitypledge2=100 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==6
replace corr=1 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==6

* 600
replace goldquantity2=60 if HHID2016=="uuid:142053fe-243a-4035-8746-93dd30108d22" & INDID2016==4
replace corr=1 if HHID2016=="uuid:142053fe-243a-4035-8746-93dd30108d22" & INDID2016==4

* 520 grams for 1 indiv, 480 pledge, 900 000 pledge
replace goldquantity2=52 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" & INDID2016==2
replace goldquantitypledge2=48 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" & INDID2016==2
replace goldamountpledge2=90000 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" & INDID2016==2
replace corr=1 if HHID2016=="uuid:b7ed12c8-2cdb-43d7-8d46-a5edeb6ad919" & INDID2016==2

* 480
replace goldquantity2=48 if HHID2016=="uuid:6b162917-4b4d-4787-a719-3fe27af6f755" & INDID2016==7
replace corr=1 if HHID2016=="uuid:6b162917-4b4d-4787-a719-3fe27af6f755" & INDID2016==7

* 400 304 450000
replace goldquantity2=40 if HHID2016=="uuid:ec9900c5-b81d-45b6-8318-461db0a4a976" & INDID2016==2
replace goldquantitypledge2=30 if HHID2016=="uuid:ec9900c5-b81d-45b6-8318-461db0a4a976" & INDID2016==2
replace goldamountpledge2=45000 if HHID2016=="uuid:ec9900c5-b81d-45b6-8318-461db0a4a976" & INDID2016==2
replace corr=1 if HHID2016=="uuid:ec9900c5-b81d-45b6-8318-461db0a4a976" & INDID2016==2

* 400        344     500000
replace goldquantity2=40 if HHID2016=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" & INDID2016==5
replace goldquantitypledge2=34 if HHID2016=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" & INDID2016==5
replace goldamountpledge2=50000 if HHID2016=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" & INDID2016==5
replace corr=1 if HHID2016=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" & INDID2016==5

*400
replace goldquantity2=40 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==2
replace corr=1 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==2

* 400 184 230000
replace goldquantity2=40 if HHID2016=="uuid:6b162917-4b4d-4787-a719-3fe27af6f755" & INDID2016==4
replace goldquantitypledge2=18 if HHID2016=="uuid:6b162917-4b4d-4787-a719-3fe27af6f755" & INDID2016==4
replace goldamountpledge2=23000 if HHID2016=="uuid:6b162917-4b4d-4787-a719-3fe27af6f755" & INDID2016==4
replace corr=1 if HHID2016=="uuid:6b162917-4b4d-4787-a719-3fe27af6f755" & INDID2016==4

* 360 96 60000
replace goldquantity2=36 if HHID2016=="uuid:687461f3-df83-4e62-b125-8b2525d79f13" & INDID2016==1
replace goldquantitypledge2=10 if HHID2016=="uuid:687461f3-df83-4e62-b125-8b2525d79f13" & INDID2016==1
replace goldamountpledge2=30000 if HHID2016=="uuid:687461f3-df83-4e62-b125-8b2525d79f13" & INDID2016==1
replace corr=1 if HHID2016=="uuid:687461f3-df83-4e62-b125-8b2525d79f13" & INDID2016==1

* 320 312 500000
replace goldquantity2=20 if HHID2016=="uuid:ba25a879-1551-4520-a805-d270d69f34b0" & INDID2016==2
replace goldquantitypledge2=12 if HHID2016=="uuid:ba25a879-1551-4520-a805-d270d69f34b0" & INDID2016==2
replace goldamountpledge2=50000 if HHID2016=="uuid:ba25a879-1551-4520-a805-d270d69f34b0" & INDID2016==2
replace corr=1 if HHID2016=="uuid:ba25a879-1551-4520-a805-d270d69f34b0" & INDID2016==2

* 300
replace goldquantity2=30 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==4
replace corr=1 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==4

* 280        340     500000
replace goldquantity2=34 if HHID2016=="uuid:3502a333-6356-4267-ad32-ad6d32029c51" & INDID2016==2
replace goldquantitypledge2=28 if HHID2016=="uuid:3502a333-6356-4267-ad32-ad6d32029c51" & INDID2016==2
replace goldamountpledge2=50000 if HHID2016=="uuid:3502a333-6356-4267-ad32-ad6d32029c51" & INDID2016==2
replace corr=1 if HHID2016=="uuid:3502a333-6356-4267-ad32-ad6d32029c51" & INDID2016==2

* 250 240 150000
replace goldquantity2=25 if HHID2016=="uuid:35c893c2-0912-40b9-9c97-148255aa8a4c" & INDID2016==1
replace goldquantitypledge2=24 if HHID2016=="uuid:35c893c2-0912-40b9-9c97-148255aa8a4c" & INDID2016==1
replace goldamountpledge2=50000 if HHID2016=="uuid:35c893c2-0912-40b9-9c97-148255aa8a4c" & INDID2016==1
replace corr=1 if HHID2016=="uuid:35c893c2-0912-40b9-9c97-148255aa8a4c" & INDID2016==1

* 240 200 450000
replace goldquantity2=24 if HHID2016=="uuid:837acac5-1a51-4180-a716-bb3b1aaf5d03" & INDID2016==2
replace goldquantitypledge2=20 if HHID2016=="uuid:837acac5-1a51-4180-a716-bb3b1aaf5d03" & INDID2016==2
replace goldamountpledge2=45000 if HHID2016=="uuid:837acac5-1a51-4180-a716-bb3b1aaf5d03" & INDID2016==2
replace corr=1 if HHID2016=="uuid:837acac5-1a51-4180-a716-bb3b1aaf5d03" & INDID2016==2

* 240 216 270000
replace goldquantity2=40 if HHID2016=="uuid:55609960-a8f0-465c-b1bb-c6b4239972c6" & INDID2016==1
replace goldquantitypledge2=16 if HHID2016=="uuid:55609960-a8f0-465c-b1bb-c6b4239972c6" & INDID2016==1
replace goldamountpledge2=27000 if HHID2016=="uuid:55609960-a8f0-465c-b1bb-c6b4239972c6" & INDID2016==1
replace cor=1 if HHID2016=="uuid:55609960-a8f0-465c-b1bb-c6b4239972c6" & INDID2016==1

* 224 200 300000
replace goldquantity2=24 if HHID2016=="uuid:03448664-46ca-4519-8209-de355a7e8b31" & INDID2016==1
replace goldquantitypledge2=20 if HHID2016=="uuid:03448664-46ca-4519-8209-de355a7e8b31" & INDID2016==1
replace goldamountpledge2=30000 if HHID2016=="uuid:03448664-46ca-4519-8209-de355a7e8b31" & INDID2016==1
replace corr=1 if HHID2016=="uuid:03448664-46ca-4519-8209-de355a7e8b31" & INDID2016==1

* 240 200 200000
replace goldquantity2=24 if HHID2016=="uuid:5ddaed64-11cb-4a8a-a146-951b9d041a2a" & INDID2016==2
replace goldquantitypledge2=20 if HHID2016=="uuid:5ddaed64-11cb-4a8a-a146-951b9d041a2a" & INDID2016==2
replace goldamountpledge2=20000 if HHID2016=="uuid:5ddaed64-11cb-4a8a-a146-951b9d041a2a" & INDID2016==2
replace corr=1 if HHID2016=="uuid:5ddaed64-11cb-4a8a-a146-951b9d041a2a" & INDID2016==2

* 240 80 145000
replace goldquantity2=24 if HHID2016=="uuid:96becde9-a23f-4f80-a5d0-7adf5ef61a67" & INDID2016==7
replace goldquantitypledge2=8 if HHID2016=="uuid:96becde9-a23f-4f80-a5d0-7adf5ef61a67" & INDID2016==7
replace goldamountpledge2=14500 if HHID2016=="uuid:96becde9-a23f-4f80-a5d0-7adf5ef61a67" & INDID2016==7
replace corr=1 if HHID2016=="uuid:96becde9-a23f-4f80-a5d0-7adf5ef61a67" & INDID2016==7

* 200 grams  160 pledge      25000 pledge
replace goldquantity2=20 if HHID2016=="uuid:ba97ea13-f20c-4518-86b9-e29e4e091ce6" & INDID2016==1
replace goldquantitypledge2=16 if HHID2016=="uuid:ba97ea13-f20c-4518-86b9-e29e4e091ce6" & INDID2016==1
replace corr=1 if HHID2016=="uuid:ba97ea13-f20c-4518-86b9-e29e4e091ce6" & INDID2016==1

*200
replace goldquantity2=20 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" & INDID2016==5
replace corr=1 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" & INDID2016==5

*200
replace goldquantity2=20 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" & INDID2016==6
replace corr=1 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" & INDID2016==6

* 200
replace goldquantity2=20 if HHID2016=="uuid:142053fe-243a-4035-8746-93dd30108d22" & INDID2016==2
replace corr=1 if HHID2016=="uuid:142053fe-243a-4035-8746-93dd30108d22" & INDID2016==2

* 200 40 60000
replace goldquantity2=20 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" & INDID2016==2
replace goldquantitypledge2=4 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" & INDID2016==2
replace goldamountpledge2=6000 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" & INDID2016==2
replace corr=1 if HHID2016=="uuid:6bad1959-158b-4ed4-af07-f257fbc0feeb" & INDID2016==2

* 192 160 200000
replace goldquantity2=92 if HHID2016=="uuid:20e563c4-8f88-40b7-8279-425971394029" & INDID2016==2
replace goldquantitypledge2=60 if HHID2016=="uuid:20e563c4-8f88-40b7-8279-425971394029" & INDID2016==2
replace goldamountpledge2=120000 if HHID2016=="uuid:20e563c4-8f88-40b7-8279-425971394029" & INDID2016==2
replace corr=1 if HHID2016=="uuid:20e563c4-8f88-40b7-8279-425971394029" & INDID2016==2

* 160
replace goldquantity2=16 if HHID2016=="uuid:0e075c0e-4b4a-461b-af2c-b61c39347738" & INDID2016==5
replace corr=1 if HHID2016=="uuid:0e075c0e-4b4a-461b-af2c-b61c39347738" & INDID2016==5

* 160 120 220000
replace goldquantity2=16 if HHID2016=="uuid:8ddf086d-0993-4ff7-813b-1f63dd46b1bf" & INDID2016==2
replace goldquantitypledge2=12 if HHID2016=="uuid:8ddf086d-0993-4ff7-813b-1f63dd46b1bf" & INDID2016==2
replace goldamountpledge2=20000 if HHID2016=="uuid:8ddf086d-0993-4ff7-813b-1f63dd46b1bf" & INDID2016==2
replace corr=1 if HHID2016=="uuid:8ddf086d-0993-4ff7-813b-1f63dd46b1bf" & INDID2016==2

* 160 grams   152 pledge     24000 pledge
replace goldquantity2=60 if HHID2016=="uuid:547e37d9-20f3-4553-be74-8e7a7e162e4f" & INDID2016==2
replace goldquantitypledge2=52 if HHID2016=="uuid:547e37d9-20f3-4553-be74-8e7a7e162e4f" & INDID2016==2
replace corr=1 if HHID2016=="uuid:547e37d9-20f3-4553-be74-8e7a7e162e4f" & INDID2016==2

* 160 grams  40 pledge      50000 pledge
replace goldquantity2=60 if HHID2016=="uuid:a6097c43-dd3b-40d0-9d42-7350ecbd35ab" & INDID2016==2
replace corr=1 if HHID2016=="uuid:a6097c43-dd3b-40d0-9d42-7350ecbd35ab" & INDID2016==2

* 160 grams  40 pledge      50000 pledge
replace goldquantity2=60 if HHID2016=="uuid:b674627c-df7d-4e5c-9778-70daa8d9a262" & INDID2016==2
replace corr=1 if HHID2016=="uuid:b674627c-df7d-4e5c-9778-70daa8d9a262" & INDID2016==2

* 160 136 165000
replace goldquantity2=60 if HHID2016=="uuid:7c7e1aa9-4792-46b9-bcaa-b3d7e7b28327" & INDID2016==2
replace goldquantitypledge2=36 if HHID2016=="uuid:7c7e1aa9-4792-46b9-bcaa-b3d7e7b28327" & INDID2016==2
replace goldamountpledge2=65000 if HHID2016=="uuid:7c7e1aa9-4792-46b9-bcaa-b3d7e7b28327" & INDID2016==2
replace corr=1 if HHID2016=="uuid:7c7e1aa9-4792-46b9-bcaa-b3d7e7b28327" & INDID2016==2

*160 80 100000
replace goldquantity2=16 if HHID2016=="uuid:c2d03ebc-5c0e-415a-a655-001859f7a68f" & INDID2016==5
replace goldquantitypledge2=8 if HHID2016=="uuid:c2d03ebc-5c0e-415a-a655-001859f7a68f" & INDID2016==5
replace goldamountpledge2=10000 if HHID2016=="uuid:c2d03ebc-5c0e-415a-a655-001859f7a68f" & INDID2016==5
replace corr=1 if HHID2016=="uuid:c2d03ebc-5c0e-415a-a655-001859f7a68f" & INDID2016==5

* 152 120 20000
replace goldquantity2=52 if HHID2016=="uuid:872313d4-988a-4cd3-ba30-3d59f68cac30" & INDID2016==4
replace goldquantitypledge2=20 if HHID2016=="uuid:872313d4-988a-4cd3-ba30-3d59f68cac30" & INDID2016==4
replace goldamountpledge2=20000 if HHID2016=="uuid:872313d4-988a-4cd3-ba30-3d59f68cac30" & INDID2016==4
replace corr=1 if HHID2016=="uuid:872313d4-988a-4cd3-ba30-3d59f68cac30" & INDID2016==4

* 136 120 200000
replace goldquantity2=36 if HHID2016=="uuid:1f120ace-1042-4eec-a398-851491a11b30" & INDID2016==2
replace goldquantitypledge2=20 if HHID2016=="uuid:1f120ace-1042-4eec-a398-851491a11b30" & INDID2016==2
replace goldamountpledge2=20000 if HHID2016=="uuid:1f120ace-1042-4eec-a398-851491a11b30" & INDID2016==2
replace corr=1 if HHID2016=="uuid:1f120ace-1042-4eec-a398-851491a11b30" & INDID2016==2

* 120 104 130000
replace goldquantity2=12 if HHID2016=="uuid:64b9823b-79fc-4917-8ef1-732005a38ba0" & INDID2016==3
replace goldquantitypledge2=10 if HHID2016=="uuid:64b9823b-79fc-4917-8ef1-732005a38ba0" & INDID2016==3
replace goldamountpledge2=13000 if HHID2016=="uuid:64b9823b-79fc-4917-8ef1-732005a38ba0" & INDID2016==3
replace corr=1 if HHID2016=="uuid:64b9823b-79fc-4917-8ef1-732005a38ba0" & INDID2016==3

* 120
replace goldquantity2=12 if HHID2016=="uuid:77cb7501-b16a-4783-9f3e-c1a84460fe88" & INDID2016==3
replace corr=1 if HHID2016=="uuid:77cb7501-b16a-4783-9f3e-c1a84460fe88" & INDID2016==3

* 120
replace goldquantity2=12 if HHID2016=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" & INDID2016==7
replace corr=1 if HHID2016=="uuid:a455df85-e5c8-4fc8-9ade-1ab4d04e9185" & INDID2016==7

* 120 80 80000
replace goldquantity2=12 if HHID2016=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" & INDID2016==1
replace goldquantitypledge2=8 if HHID2016=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" & INDID2016==1
replace goldamountpledge2=8000 if HHID2016=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" & INDID2016==1
replace corr=1 if HHID2016=="uuid:e6c98c2b-5feb-415d-b265-5718af37f2f8" & INDID2016==1









********** Pledge vs Owned quantity
gen test=goldquantity2-goldquantitypledge2
/*
Neg means that pledge>total, suppose they reversed, so need to recoded:
*/
order HHID2016 INDID2016 goldquantity2 goldquantitypledge2 goldamountpledge2 pbdalits_HH2016 pbnondalits_HH2016 corr test goldquantity2016 goldquantitypledge2016 goldamountpledge2016 goldquantity2020 goldquantitypledge2020 goldamountpledge2020
sort test HHID2016 INDID2016

* 56 160 100000
replace goldquantity2=60 if HHID2016=="uuid:4e015d7e-1ce4-4f87-bc7d-a9a67c0aab86" & INDID2016==2
replace goldquantitypledge2=56 if HHID2016=="uuid:4e015d7e-1ce4-4f87-bc7d-a9a67c0aab86" & INDID2016==2
replace goldamountpledge2=20000 if HHID2016=="uuid:4e015d7e-1ce4-4f87-bc7d-a9a67c0aab86" & INDID2016==2
replace corr=1 if HHID2016=="uuid:4e015d7e-1ce4-4f87-bc7d-a9a67c0aab86" & INDID2016==2

* 14 96 250000
replace goldquantity2=96 if HHID2016=="uuid:94e1ec13-3618-4995-bd9d-eb810d9ade40" & INDID2016==2
replace goldquantitypledge2=14 if HHID2016=="uuid:94e1ec13-3618-4995-bd9d-eb810d9ade40" & INDID2016==2
replace goldamountpledge2=25000 if HHID2016=="uuid:94e1ec13-3618-4995-bd9d-eb810d9ade40" & INDID2016==2
replace corr=1 if HHID2016=="uuid:94e1ec13-3618-4995-bd9d-eb810d9ade40" & INDID2016==2

* 80 128 190000
replace goldquantity2=12 if HHID2016=="uuid:64b9823b-79fc-4917-8ef1-732005a38ba0" & INDID2016==1
replace goldquantitypledge2=8 if HHID2016=="uuid:64b9823b-79fc-4917-8ef1-732005a38ba0" & INDID2016==1
replace goldamountpledge2=19000 if HHID2016=="uuid:64b9823b-79fc-4917-8ef1-732005a38ba0" & INDID2016==1
replace corr=1 if HHID2016=="uuid:64b9823b-79fc-4917-8ef1-732005a38ba0" & INDID2016==1

* 6 32 40000
replace goldquantity2=32 if HHID2016=="uuid:bd5d1b89-9922-4d9b-b3b7-1e6a46528933" & INDID2016==2
replace goldquantitypledge2=26 if HHID2016=="uuid:bd5d1b89-9922-4d9b-b3b7-1e6a46528933" & INDID2016==2
replace corr=1 if HHID2016=="uuid:bd5d1b89-9922-4d9b-b3b7-1e6a46528933" & INDID2016==2

* 2 16 16500
replace goldquantity2=20 if HHID2016=="uuid:a45717f6-15bb-4239-bda0-93fb47584519" & INDID2016==11
replace corr=1 if HHID2016=="uuid:a45717f6-15bb-4239-bda0-93fb47584519" & INDID2016==11

* 32 40 100000
replace goldquantity2=40 if HHID2016=="uuid:65edc7ba-2951-4b8f-83f6-151c3d9da89c" & INDID2016==2
replace goldquantitypledge2=32 if HHID2016=="uuid:65edc7ba-2951-4b8f-83f6-151c3d9da89c" & INDID2016==2
replace goldamountpledge2=85000 if HHID2016=="uuid:65edc7ba-2951-4b8f-83f6-151c3d9da89c" & INDID2016==2
replace corr=1 if HHID2016=="uuid:65edc7ba-2951-4b8f-83f6-151c3d9da89c" & INDID2016==2

* 4 12 15000
replace goldquantity2=14 if HHID2016=="uuid:75d61016-374e-48fa-b53c-2b36b3408b52" & INDID2016==2
replace corr=1 if HHID2016=="uuid:75d61016-374e-48fa-b53c-2b36b3408b52" & INDID2016==2

* 1 8 12000
replace goldquantity2=10 if HHID2016=="uuid:ba25a879-1551-4520-a805-d270d69f34b0" & INDID2016==1
replace corr=1 if HHID2016=="uuid:ba25a879-1551-4520-a805-d270d69f34b0" & INDID2016==1

* 48 50 70000
replace goldquantity2=50 if HHID2016=="uuid:76939ed5-3f98-4069-974b-722e5225176b" & INDID2016==4
replace goldquantitypledge2=48 if HHID2016=="uuid:76939ed5-3f98-4069-974b-722e5225176b" & INDID2016==4
replace corr=1 if HHID2016=="uuid:76939ed5-3f98-4069-974b-722e5225176b" & INDID2016==4

drop test




********** Quantity and amount pledge
gen test=goldamountpledge2/goldquantitypledge2
/*
Higher than 2700 strange as 2700 is the gold price
So, need to check the quantity and the price to observe outliers
Below 400 too
*/
order HHID2016 INDID2016 goldquantity2 goldquantitypledge2 goldamountpledge2 pbdalits_HH2016 pbnondalits_HH2016 corr test goldquantity2016 goldquantitypledge2016 goldamountpledge2016 goldquantity2020 goldquantitypledge2020 goldamountpledge2020
sort test HHID2016 INDID2016


* 80 80 5000
replace goldamountpledge2=50000 if HHID2016=="uuid:0740a1ad-0b80-4ebd-a905-fd7dc3c82793" & INDID2016==2
replace corr=1 if HHID2016=="uuid:0740a1ad-0b80-4ebd-a905-fd7dc3c82793" & INDID2016==2

* 32 24 3000
replace goldamountpledge2=30000 if HHID2016=="uuid:343f557a-1331-481f-b59f-4cf63c4598d8" & INDID2016==2
replace corr=1 if HHID2016=="uuid:343f557a-1331-481f-b59f-4cf63c4598d8" & INDID2016==2

* 40 24 3000
replace goldamountpledge2=30000 if HHID2016=="uuid:3c4611de-ffad-4e30-8065-96922f5d47a6" & INDID2016==1
replace corr=1 if HHID2016=="uuid:3c4611de-ffad-4e30-8065-96922f5d47a6" & INDID2016==1

* 48 40 5000
replace goldamountpledge2=50000 if HHID2016=="uuid:61eebc2f-dbcf-4c8d-b1c1-db47af15e320" & INDID2016==1
replace corr=1 if HHID2016=="uuid:61eebc2f-dbcf-4c8d-b1c1-db47af15e320" & INDID2016==1

* 16 8 1350
replace goldamountpledge2=13500 if HHID2016=="uuid:5bdd78a1-ed16-42e1-b610-06fe73c0aa2e" & INDID2016==1
replace corr=1 if HHID2016=="uuid:5bdd78a1-ed16-42e1-b610-06fe73c0aa2e" & INDID2016==1

* 16 8 1350
replace goldamountpledge2=13500 if HHID2016=="uuid:5bdd78a1-ed16-42e1-b610-06fe73c0aa2e" & INDID2016==1
replace corr=1 if HHID2016=="uuid:5bdd78a1-ed16-42e1-b610-06fe73c0aa2e" & INDID2016==1

drop test


********** Clean
drop goldquantity2016 goldquantitypledge2016 goldamountpledge2016 pbdalits_HH2016 pbnondalits_HH2016 goldquantity22016 goldquantitypledge22016 goldamountpledge22016
drop goldquantity2020 goldquantitypledge2020 goldamountpledge2020 pbdalits_HH2020 pbnondalits_HH2020 goldquantity22020 goldquantitypledge22020 goldamountpledge22020
drop pbdalits_HH2010 pbnondalits_HH2010 goldquantity2010 goldquantitypledge2010 goldamountpledge2010 goldquantity22010 goldquantitypledge22010 goldamountpledge22010

ta corr
* 51 indiv corr

tabstat goldquantity goldquantity2 goldquantitypledge goldquantitypledge2 goldamountpledge goldamountpledge2, stat(n mean q)

gen goldamount=goldquantity2*2700

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
















/*
* 120 108 165500
replace goldquantity2=12 if HHID2016=="uuid:fd4ce8ff-8fea-49a8-9e17-6ad2ffe308a3" & INDID2016==2
replace goldquantitypledge2=10 if HHID2016=="uuid:fd4ce8ff-8fea-49a8-9e17-6ad2ffe308a3" & INDID2016==2
replace goldamountpledge2=16550 if HHID2016=="uuid:fd4ce8ff-8fea-49a8-9e17-6ad2ffe308a3" & INDID2016==2

* 120 24 25000
replace goldquantity2=24 if HHID2016=="uuid:7b27a673-9ef9-4e74-af9e-975dc288c90c" & INDID2016==2
replace goldquantitypledge2=12 if HHID2016=="uuid:7b27a673-9ef9-4e74-af9e-975dc288c90c" & INDID2016==2

*120 72 10000
replace goldquantity2=12 if HHID2016=="uuid:0595322c-603f-4c45-a333-9f80c0c140fc" & INDID2016==3
replace goldquantitypledge2=7 if HHID2016=="uuid:0595322c-603f-4c45-a333-9f80c0c140fc" & INDID2016==3
replace goldamountpledge2=10000 if HHID2016=="uuid:0595322c-603f-4c45-a333-9f80c0c140fc" & INDID2016==3

* 40 24 350005
replace goldamountpledge2=35000 if HHID2016=="uuid:8e0b0fc2-c75d-4646-a949-4c7749d6b3cc" & INDID2016==4

* 96 14 250000
replace goldamountpledge2=25000 if HHID2016=="uuid:94e1ec13-3618-4995-bd9d-eb810d9ade40" & INDID2016==2

* 126 116 207000
replace goldquantity2=26 if HHID2016=="uuid:f75c3ee4-1112-46c0-9f23-897b8d6b43f3" & INDID2016==2
replace goldquantitypledge2=16 if HHID2016=="uuid:f75c3ee4-1112-46c0-9f23-897b8d6b43f3" & INDID2016==2
replace goldamountpledge2=20700 if HHID2016=="uuid:f75c3ee4-1112-46c0-9f23-897b8d6b43f3" & INDID2016==2

* 126        120     200000
replace goldquantity2=26 if HHID2016=="uuid:d6989469-10af-4d6d-8827-69ed49c4719f" & INDID2016==2
replace goldquantitypledge2=20 if HHID2016=="uuid:d6989469-10af-4d6d-8827-69ed49c4719f" & INDID2016==2
replace goldamountpledge2=20000 if HHID2016=="uuid:d6989469-10af-4d6d-8827-69ed49c4719f" & INDID2016==2

* 160 100 100000
replace goldquantity2=16 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==6
replace goldquantitypledge2=10 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==6
replace goldamountpledge2=10000 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==6

* 100
replace goldquantity2=10 if HHID2016=="uuid:9020eaf9-2e69-421d-8c8f-b5bbc44b310c" & INDID2016==10
replace goldquantity2=10 if HHID2016=="uuid:87686aa6-d251-45ab-80d2-1572d07af413" & INDID2016==3
*/
