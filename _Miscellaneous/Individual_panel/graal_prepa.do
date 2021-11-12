cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
November 12, 2021
-----
Prepa GRAAL
-----

-------------------------
*/






****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all
********** Path to folder "data" folder.
*global directory = "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND"
*cd "$directory\CLEAN"

global git "C:\Users\Arnaud\Documents\GitHub\RUME-NEEMSIS\_Miscellaneous\Individual_panel"

global rume "D:\Documents\_Thesis\_DATA\RUME"
global neemsis1 "D:\Documents\_Thesis\_DATA\NEEMSIS1"
global neemsis2 "D:\Documents\_Thesis\_DATA\NEEMSIS2\DATA\APPEND\CLEAN\LAST"
global tracking1 "D:\Documents\_Thesis\_DATA\Tracking2019\DATA"


****************************************
* END








****************************************
* PICK-UP ALL basic details
****************************************
/*
/!\ The question of the order is important
The first best option is to do in chronological
order.
But, before cleaning tracking 1, I can NEEMSIS-2 data
So, the order for HHID_panel and INDID_panel is:
RUME
NEEMSIS1
NEEMSIS2
Tracking1
...
Tracking2
NEEMSIS3

From "..." we need to continue in the right order

*/
********** RUME
use"$rume\RUME-HH_v8.dta", clear
keep HHID_panel INDID_panel HHID2010 INDID2010 name age sex relationshiptohead jatis caste address villageid

* All string
tostring *, replace
desc

* Decode
foreach x in relationshiptohead jatis caste {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}
desc

* Replace
replace sex="Male" if sex=="1"
replace sex="Female" if sex=="2"

replace villageid="ELA" if villageid=="1"
replace villageid="GOV" if villageid=="2"
replace villageid="KAR" if villageid=="3"
replace villageid="KOR" if villageid=="4"
replace villageid="KUV" if villageid=="5"
replace villageid="MAN" if villageid=="6"
replace villageid="MANAM" if villageid=="7"
replace villageid="NAT" if villageid=="8"
replace villageid="ORA" if villageid=="9"
replace villageid="SEM" if villageid=="10"

* Wave, year and submissiondate
gen wave="RUME"
gen year="2010"
gen submissionyear="2010" 

* Order
order HHID_panel INDID_panel HHID2010 INDID2010 wave year submissionyear name age sex relationshiptohead jatis caste address villageid
compress

save"$git\RUME-HH_indiv.dta", replace



********** NEEMSIS1
use"$neemsis1\NEEMSIS1-HH_v9.dta", clear
keep HHID_panel INDID_panel HHID2016 INDID2016 name age sex relationshiptohead jatis caste address villageid submissiondate

* All string
tostring *, replace
desc

* Decode
foreach x in sex villageid relationshiptohead jatis caste {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}
desc

* Wave, year and submissiondate
gen wave="NEEMSIS-1"
gen year="2016-17"

gen submissiondate_new=dofc(submissiondate)
drop submissiondate
rename submissiondate_new submissiondate
format submissiondate %td
generate submissionyear=year(submissiondate)
drop submissiondate
tostring submissionyear, replace
desc

* Order
order HHID_panel INDID_panel HHID2016 INDID2016 wave year submissionyear name age sex relationshiptohead jatis caste address villageid
compress

save"$git\NEEMSIS1-HH_indiv.dta", replace




********** NEEMSIS2
use"$neemsis2\NEEMSIS2-HH_v21.dta", clear

keep HHID_panel INDID_panel parent_key INDID2020 name age sex relationshiptohead relationshiptoheadother jatis caste address villageid submissiondate INDID_left householdidparent householdid2020
rename parent_key HHID2020

* All string
tostring *, replace
desc

* Decode
foreach x in sex villageid relationshiptohead jatis caste {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}
desc
replace relationshiptohead="Other" if relationshiptohead=="" & INDID_left=="."

* Dummyleft
gen dummyleft="No"
replace dummyleft="Yes" if INDID_left!="."
drop INDID_left

* Wave, year and submissiondate
gen wave="NEEMSIS-2"
gen year="2020-21"

gen submissiondate_new=dofc(submissiondate)
drop submissiondate
rename submissiondate_new submissiondate
format submissiondate %td
generate submissionyear=year(submissiondate)
drop submissiondate
tostring submissionyear, replace
desc

* Order
order HHID_panel INDID_panel HHID2020 INDID2020 wave year submissionyear name age sex relationshiptohead relationshiptoheadother dummyleft jatis caste address villageid
compress

save"$git\NEEMSIS2-HH_indiv.dta", replace




********** Tracking 1
use"$tracking1\NEEMSIS-tracking_comp_v4.dta", clear
keep HHID_panel INDID_panel name sex age HHID2010 INDID2019 key relationshiptohead migrationaddress villageid namemigrant caste casteother

* Cleaning
rename key HHID2019
rename migrationaddress address

rename caste jatis
rename casteother jatisother

replace villageid="ELA" if villageid=="ELANTHALMPATTU"
replace villageid="GOV" if villageid=="GOVULAPURAM"
replace villageid="KAR" if villageid=="KARUMBUR"
replace villageid="KOR" if villageid=="KORATTORE"
replace villageid="KUV" if villageid=="KUVAGAM"
replace villageid="MAN" if villageid=="MANAPAKKAM"
replace villageid="ORA" if villageid=="ORAIYURE"
replace villageid="MANAM" if villageid=="MANAMTHAVIZHINTHAPUTHUR"
replace villageid="NAT" if villageid=="NATHAM"
replace villageid="SEM" if villageid=="SEMAKOTTAI"
rename villageid villageorigin

* All string
tostring *, replace
desc

* Decode
foreach x in sex relationshiptohead jatis {
decode `x', gen(`x'_str)
drop `x'
rename `x'_str `x'
}
desc

* Clean
replace jatis=jatisother if jatis=="Other"
drop jatisother

* Wave, year and submissiondate
gen wave="Tracking-1"
gen year="2019"
gen submissionyear="2019"

* Parent_key
encode HHID2019, gen(code)
order HHID_panel HHID2010 HHID2019 code namemigrant, last
gen test=1 if HHID2019!=""
bysort HHID_panel namemigrant: egen count=sum(test)
tab count
drop test count
bysort HHID_panel namemigrant: egen HHID2019_max=max(code)
bysort HHID_panel namemigrant: egen HHID2019_min=min(code)
label list
label values HHID2019_max code
label values HHID2019_min code
decode HHID2019_max, gen(HHID2019_main)
decode HHID2019_min, gen(HHID2019_sec)
drop HHID2019_max HHID2019_min
replace HHID2019_sec="" if HHID2019_main==HHID2019_sec
drop HHID2019
rename HHID2019_main HHID2019
rename HHID2019_sec HHID2019other

* Villageid from address
sort HHID_panel INDID_panel
tab address 
gen villageid=""

replace villageid="Chennai" if address=="317/12, Vandalur main road, near perumal temple, kelampakkam, Chennai."
replace villageid="Chennai" if address=="317/12, Vandalur main road, near perumal temple, kelampakkam, Chennai."
replace villageid="Chennai" if address=="R.S construction,kelambakkam, chennai"
replace villageid="Vellore" if address=="EKS chamber,sellenjeri,walaja,vellore district"
replace villageid="Vellore" if address=="EKS chamber,sellenjeri,walaja,vellore district"
replace villageid="Vellore" if address=="EKS chamber,sellenjeri,walaja,vellore district"
replace villageid="Anna graman" if address=="67, murugan koil street, kozhipakkam, Anna gramam"
replace villageid="Anna graman" if address=="67, murugan koil street, kozhipakkam, Anna gramam"
replace villageid="Anna graman" if address=="67, murugan koil street, kozhipakkam, Anna gramam"
replace villageid="Anna graman" if address=="67, murugan koil street, kozhipakkam, Anna gramam"
replace villageid="Anna graman" if address=="67, murugan koil street, kozhipakkam, Anna gramam"
replace villageid="Anna graman" if address=="67, murugan koil street, kozhipakkam, Anna gramam"
replace villageid="Chennai" if address=="318/67,sozhinganallur main road perumbakkam,chennai"
replace villageid="Chennai" if address=="318/67,sozhinganallur main road perumbakkam,chennai"
replace villageid="Chennai" if address=="318/67,sozhinganallur main road perumbakkam,chennai"
replace villageid="Chennai" if address=="318/67,sozhinganallur main road perumbakkam,chennai"
replace villageid="Chennai" if address=="318/67,sozhinganallur main road perumbakkam,chennai"
replace villageid="Chennai" if address=="367,Durgaiyamman koil street,pallavaram main road,chennai"
replace villageid="Chennai" if address=="367,Durgaiyamman koil street,pallavaram main road,chennai"
replace villageid="Chennai" if address=="367,Durgaiyamman koil street,pallavaram main road,chennai"
replace villageid="Thirupur" if address=="12,periya theru karimaruthanpatti, thirupur"
replace villageid="" if address=="156,next to lenovo"
replace villageid="Chennai" if address=="231/14, ambattur industrial estate campus,ambattur,chennai"
replace villageid="Chennai" if address=="231/14, ambattur industrial estate campus,ambattur,chennai"
replace villageid="Chennai" if address=="231/14, ambattur industrial estate campus,ambattur,chennai"
replace villageid="Villupuram" if address=="321Santhana gopalapuram,villupuram"
replace villageid="Villupuram" if address=="321Santhana gopalapuram,villupuram"
replace villageid="Villupuram" if address=="321Santhana gopalapuram,villupuram"
replace villageid="Chennai" if address=="Geetha Krishna archeri, poonamalli, Chennai"
replace villageid="Chennai" if address=="Geetha Krishna archeri, poonamalli, Chennai"
replace villageid="Chennai" if address=="Geetha Krishna archeri, poonamalli, Chennai"
replace villageid="Chennai" if address=="Geetha Krishna archeri, poonamalli, Chennai"
replace villageid="Chennai" if address=="Geetha Krishna archeri, poonamalli, Chennai"
replace villageid="Chennai" if address=="Geetha Krishna archeri, poonamalli, Chennai"
replace villageid="Trichy" if address=="Engineering college campus, trichy."
replace villageid="Trichy" if address=="Trichy"
replace villageid="Thirupur" if address=="138/4, KVR NAGAR, somanur, thiruppur"
replace villageid="Chennai" if address=="364, 3rd cross, GKR complex, near chindadiripet, chennai"
replace villageid="Bangalore" if address=="138/17, 4th cross, KEB colony, hoodi, bangalore"
replace villageid="Chennai" if address=="364, 3rd cross, GKR complex, near chindadiripet, chennai"
replace villageid="Chennai" if address=="364, 3rd cross, GKR complex, near chindadiripet, chennai"
replace villageid="Chennai" if address=="12,rajamani street,VGP nagar,thiruvanmayur,chennai"
replace villageid="Chennai" if address=="12,rajamani street,VGP nagar,thiruvanmayur,chennai"
replace villageid="Panruti" if address=="136, periyar nagar, panruti"
replace villageid="Panruti" if address=="136, periyar nagar, panruti"
replace villageid="Panruti" if address=="136, periyar nagar, panruti"
replace villageid="Chennai" if address=="7,periya veteran theru, red hills chennai"
replace villageid="Chennai" if address=="7,periya veteran theru, red hills chennai"
replace villageid="Chennai" if address=="7,periya veteran theru, red hills chennai"
replace villageid="Chennai" if address=="KRS travels, nungambakkam, chennai"
replace villageid="Chennai" if address=="KRS travels, nungambakkam, chennai"
replace villageid="Villupuram" if address=="437,thiru vi ka street,villupuram."
replace villageid="Villupuram" if address=="437,thiru vi ka street,villupuram."
replace villageid="Villupuram" if address=="437,thiru vi ka street,villupuram."
replace villageid="Tiruchirappalli" if address=="Office quarters, Gun industries defence colony, Tiruchirappalli"
replace villageid="Trichy" if address=="45, ponnagar, sangillyandpuram, Trichy"
replace villageid="" if address=="293,"
replace villageid="Tiruchirappalli" if address=="Office quarters, Gun industries defence colony, Tiruchirappalli"
replace villageid="Trichy" if address=="45, ponnagar, sangillyandpuram, Trichy"
replace villageid="Tiruchirappalli" if address=="Office quarters, Gun industries defence colony, Tiruchirappalli"
replace villageid="" if address=="293,"
replace villageid="Tiruchirappalli" if address=="Office quarters, Gun industries defence colony, Tiruchirappalli"
replace villageid="Trichy" if address=="45, ponnagar, sangillyandpuram, Trichy"
replace villageid="" if address=="Same village"
replace villageid="" if address=="Same village"
replace villageid="" if address=="Same village"
replace villageid="" if address=="Same village"
replace villageid="" if address=="Same village"
replace villageid="Chengalpet" if address=="VSK chamber,pazhayaseevaram, villiyampakkam,chengalpet"
replace villageid="Chengalpet" if address=="VSK chamber,pazhayaseevaram, villiyampakkam,chengalpet"
replace villageid="Chengalpet" if address=="VSK chamber,pazhayaseevaram, villiyampakkam,chengalpet"
replace villageid="Chengalpet" if address=="VSK chamber,pazhayaseevaram, villiyampakkam,chengalpet"
replace villageid="Chengalpet" if address=="EEK chambers, villiyambakkam, chengalpet"
replace villageid="Chengalpet" if address=="EEK chambers, villiyambakkam, chengalpet"
replace villageid="Chengalpet" if address=="EEK chambers, villiyambakkam, chengalpet"
replace villageid="Bangalore" if address=="167, 4th street,J.K nagar,Kappan park,Bangalore"
replace villageid="Bangalore" if address=="167,4th street,J.K nagar near kappan park,Bangalore"
replace villageid="Bangalore" if address=="167,4th street,J.K nagar near kappan park,Bangalore"
replace villageid="Bangalore" if address=="167, 4th street,J.K nagar,Kappan park,Bangalore"
replace villageid="Kallakurichi" if address=="No, 262, valluvar street, veers sozhapuram, kallakurichi"
replace villageid="Kallakurichi" if address=="No, 262, valluvar street, veers sozhapuram, kallakurichi"
replace villageid="Kallakurichi" if address=="No, 262, valluvar street, veers sozhapuram, kallakurichi"
replace villageid="Chengalpet" if address=="No,17, pudhu street, villiyambakkam, chengalpet, kanchipuram district"
replace villageid="Chengalpet" if address=="No,17, pudhu street, villiyambakkam, chengalpet, kanchipuram district"
replace villageid="Chengalpet" if address=="No,17, pudhu street, villiyambakkam, chengalpet, kanchipuram district"
replace villageid="Chengalpet" if address=="No,17, pudhu street, villiyambakkam, chengalpet, kanchipuram district"
replace villageid="Chengalpet" if address=="SKS chamber,villiyambakkam,pazhayaseevaram,chengalpet"
replace villageid="Chengalpet" if address=="SKS chamber,villiyambakkam,pazhayaseevaram,chengalpet"
replace villageid="Chengalpet" if address=="SKS chamber,villiyambakkam,pazhayaseevaram,chengalpet"
replace villageid="Chengalpet" if address=="ESK chamber, villiyambakkam, chengalpet, kanchipuram district"
replace villageid="Chengalpet" if address=="ESK chamber, villiyambakkam, chengalpet, kanchipuram district"
replace villageid="Chengalpet" if address=="ESK chamber, villiyambakkam, chengalpet, kanchipuram district"
replace villageid="Chengalpet" if address=="SKS chamber,pazhayaseevaram,villiyambakkam,chengalpet"
replace villageid="Chengalpet" if address=="SKS chamber,pazhayaseevaram,villiyambakkam,chengalpet"
replace villageid="Chengalpet" if address=="SKS chamber,pazhayaseevaram,villiyambakkam,chengalpet"
replace villageid="Chennai" if address=="Escort constructions, kelambakkam, chennai"
replace villageid="Thirupur" if address=="268,nehru nagar,2nd street near Om parish hospital"
replace villageid="Thirupur" if address=="268,nehru nagar,2nd street near Om parish hospital"
replace villageid="Thirupur" if address=="268,nehru nagar,2nd street near Om parish hospital"
replace villageid="Thirupur" if address=="268,nehru nagar,2nd street near on garish hospital,tirupur"
replace villageid="Thirupur" if address=="268,nehru nagar,2nd street near Om parish hospital"
replace villageid="Thirupur" if address=="268,nehru nagar,2nd street near on garish hospital,tirupur"
replace villageid="Thirupur" if address=="268,nehru nagar,2nd street near on garish hospital,tirupur"
replace villageid="Thirupur" if address=="268,nehru nagar,2nd street near on garish hospital,tirupur"
replace villageid="Chennai" if address=="Siruseri industrial estate,chennai"
replace villageid="Chennai" if address=="Siruseri industrial estate,chennai"
replace villageid="Chennai" if address=="Siruseri industrial estate,chennai"
replace villageid="Chengalpet" if address=="SKS chambers, palur, chengalpet"
replace villageid="Vellore" if address=="RMK chamber,walajabad,vellore district"
replace villageid="Vellore" if address=="RMK chamber,walajabad,vellore district"
replace villageid="Vellore" if address=="RMK chamber,walajabad,vellore district"
replace villageid="Vellore" if address=="RMK chamber,walajabad,vellore district"
replace villageid="Chennai" if address=="5, pallikaranai street, Perungalathur, chennai"
replace villageid="Chennai" if address=="5, pallikaranai street, Perungalathur, chennai"
replace villageid="Chennai" if address=="5, pallikaranai street, Perungalathur, chennai"
replace villageid="Chennai" if address=="5, pallikaranai street, Perungalathur, chennai"
replace villageid="" if address=="160,kalathumettu street"
replace villageid="Chengalpet" if address=="SKS chamber,pazhayaseevaram,villiyambakkam,chengalpet"
replace villageid="Chengalpet" if address=="SKS chamber,pazhayaseevaram,villiyambakkam,chengalpet"
replace villageid="Chengalpet" if address=="SKS chamber,pazhayaseevaram,villiyambakkam,chengalpet"
replace villageid="Chengalpet" if address=="SKS chamber,pazhayaseevaram,villiyambakkam,chengalpet"
replace villageid="Chennai" if address=="676,neelangarai,thiruvanmiyur main road,Chennai"
replace villageid="Chennai" if address=="676,neelangarai,thiruvanmiyur main road,Chennai"
replace villageid="Chennai" if address=="676,neelangarai,thiruvanmiyur main road,Chennai"
replace villageid="Chennai" if address=="676,neelangarai,thiruvanmiyur main road,Chennai"
replace villageid="Chennai" if address=="267, rajaji street, arumbakkam, chennai"
replace villageid="Chennai" if address=="267,rajaji street, arumbakam, chennai"
replace villageid="Chennai" if address=="267, rajaji street, arumbakkam, chennai"
replace villageid="Chennai" if address=="267,rajaji street, arumbakam, chennai"
replace villageid="Chennai" if address=="267, rajaji street, arumbakkam, chennai"
replace villageid="Chennai" if address=="267,rajaji street, arumbakam, chennai"
replace villageid="Chennai" if address=="Industrial estate, ambattur, chennai"
replace villageid="Chennai" if address=="Industrial estate, ambattur, chennai"
replace villageid="Chennai" if address=="Industrial estate, ambattur, chennai"
replace villageid="Chengalpet" if address=="SKS chambers,villiyambakkam,paalur,chengalpet"
replace villageid="Chengalpet" if address=="SKS chambers,villiyambakkam,paalur,chengalpet"
replace villageid="Chengalpet" if address=="SKS chambers,villiyambakkam,paalur,chengalpet"
replace villageid="" if address=="All over Tamil nadu"
replace villageid="Chennai" if address=="Raj mansion, kodambakkam main road, chennai"
replace villageid="Chennai" if address=="Raj mansion, kodambakkam, chennai"
replace villageid="Chennai" if address=="Raj mansion, kodambakkam, chennai"
replace villageid="Chennai" if address=="Raj mansion, kodambakkam, chennai"
replace villageid="Chennai" if address=="Raj mansion, kodambakkam main road, chennai"
replace villageid="Chennai" if address=="Raj mansion, kodambakkam, chennai"
replace villageid="Chennai" if address=="Raj mansion, kodambakkam main road, chennai"
replace villageid="Villiyambakkam" if address=="ESK chamber, palur, villiyambakkam"
replace villageid="Villiyambakkam" if address=="ESK chamber, palur, villiyambakkam"
replace villageid="Villiyambakkam" if address=="ESK chamber, palur, villiyambakkam"
replace villageid="Thotti" if address=="217, palur main road, thotti"
replace villageid="Thotti" if address=="217, palur main road, thotti"
replace villageid="Thotti" if address=="217, palur main road, thotti"
replace villageid="Thotti" if address=="217, palur main road, thotti"
replace villageid="Chennai" if address=="Oragadam chennai"
replace villageid="Chennai" if address=="Oragadam chennai"
replace villageid="MANAM" if address=="No 54 kulathu mettu street manamthavizhnthaputur"
replace villageid="MANAM" if address=="No 54 kulathu mettu street manamthavizhnthaputur"
replace villageid="MANAM" if address=="No 54 kulathu mettu street manamthavizhnthaputur"
replace villageid="Chennai" if address=="Lotus construction,OMR road,kelambakkam, chennai"
replace villageid="Panruti" if address=="Thirukammu street panruti"
replace villageid="Panruti" if address=="31 panjavarnan nagar panruti"
replace villageid="Panruti" if address=="31 panjavarnan nagar panruti"
replace villageid="Panruti" if address=="Thirukammu street panruti"
replace villageid="Panruti" if address=="Thirukammu street panruti"
replace villageid="Panruti" if address=="31 panjavarnan nagar panruti"
replace villageid="Panruti" if address=="31 panjavarnan nagar panruti"
replace villageid="Chennai" if address=="Geetha metals,ambathur real estate,chennai"
replace villageid="Chennai" if address=="Geetha metals,ambathur real estate,chennai"
replace villageid="Chennai" if address=="Saligramam chennai"
replace villageid="Chennai" if address=="Saligramam chennai"
replace villageid="Chennai" if address=="Saligramam chennai"
replace villageid="Velankkanni" if address=="Hotel paradise,ariyanattu street,velankkanni"
replace villageid="Chengalpet" if address=="ESK chamber, villiyambakkam,pazhayaseevaram,chengalpet"
replace villageid="Velankkanni" if address=="Hotel paradise,ariyanattu street,velankkanni"
replace villageid="Chengalpet" if address=="ESK chamber, villiyambakkam,pazhayaseevaram,chengalpet"
replace villageid="Chengalpet" if address=="ESK chamber, villiyambakkam,pazhayaseevaram,chengalpet"
replace villageid="Chengalpet" if address=="ESK chamber, villiyambakkam,pazhayaseevaram,chengalpet"
replace villageid="Chengalpet" if address=="ESK chamber, villiyambakkam,pazhayaseevaram,chengalpet"
replace villageid="Chennai" if address=="Neelangarai,chennai"
replace villageid="Chennai" if address=="Neelangarai,chennai"
replace villageid="Kelambakkam" if address=="89/24, shalimar company, RKN estate,kelambakkam,Tiruvallur district."
replace villageid="Kelambakkam" if address=="89/24, shalimar company, RKN estate,kelambakkam,Tiruvallur district."
replace villageid="Kelambakkam" if address=="89/24, shalimar company, RKN estate,kelambakkam,Tiruvallur district."
replace villageid="Kelambakkam" if address=="89/24, shalimar company, RKN estate,kelambakkam,Tiruvallur district."
replace villageid="" if address=="Selam"
replace villageid="Bangalore" if address=="367, Barack bara street, ghandi nagar, bangalore"
replace villageid="Bangalore" if address=="367, Barack bara street, ghandi nagar, bangalore"
replace villageid="Bangalore" if address=="367, Barack bara street, ghandi nagar, bangalore"
replace villageid="Villupuram" if address=="5, mariyamman koil street, villupuram"
replace villageid="Villupuram" if address=="5, mariyamman koil street, villupuram"
replace villageid="Villupuram" if address=="Villupuram"
replace villageid="Villupuram" if address=="Villupuram"
replace villageid="Villupuram" if address=="Villupuram"
replace villageid="Villupuram" if address=="Villupuram"
replace villageid="Villupuram" if address=="Villupuram"
replace villageid="Villupuram" if address=="5, mariyamman koil street, villupuram"
replace villageid="Villupuram" if address=="5, mariyamman koil street, villupuram"
replace villageid="Pudupet" if address=="217,2nd cross near police station pudupet"
replace villageid="Pudupet" if address=="217,2nd cross near police station pudupet"
replace villageid="Pudupet" if address=="217,2nd cross near police station pudupet"
replace villageid="Pudupet" if address=="217,2nd cross near police station pudupet"
replace villageid="Coimbatore" if address=="Coimbatore"
replace villageid="Chennai" if address=="527,RKV nagar,sriperambuthur, chennai"
replace villageid="Chennai" if address=="167,RVK nagar, Tambaram, Chennai"
replace villageid="Chennai" if address=="167,RVK nagar, Tambaram, Chennai"
replace villageid="Chennai" if address=="167,RVK nagar, Tambaram, Chennai"
replace villageid="Villupuram" if address=="67/18, 4th cross, rajaji nagar, villupuram"
replace villageid="Villupuram" if address=="67/18, 4th cross, rajaji nagar, villupuram"
replace villageid="Villupuram" if address=="67/18, 4th cross, rajaji nagar, villupuram"
replace villageid="Villupuram" if address=="67/18, 4th cross, rajaji nagar, villupuram"
replace villageid="Villupuram" if address=="67/18, 4th cross, rajaji nagar, villupuram"
replace villageid="Trichy" if address=="Dairy farm, bhel, trichy."
replace villageid="Trichy" if address=="Dairy farm, bhel, trichy."
replace villageid="Trichy" if address=="Dairy farm, bhel, trichy."
replace villageid="Trichy" if address=="Dairy farm, bhel, trichy."
replace villageid="Chengalpet" if address=="SKS chamber,pazhayaseevaram,villiyambakkam,chengalpet"
replace villageid="Chengalpet" if address=="SKS chamber,pazhayaseevaram,villiyambakkam,chengalpet"
replace villageid="Chengalpet" if address=="SKS chamber,pazhayaseevaram,villiyambakkam,chengalpet"
replace villageid="" if address==""
replace villageid="Villupuram" if address=="Sumathi hospital, villupuram"
replace villageid="" if address==""
replace villageid="" if address==""
replace villageid="Villupuram" if address=="Sumathi hospital, villupuram"
replace villageid="Villupuram" if address=="Sumathi hospital, villupuram"
replace villageid="Villupuram" if address=="Sumathi hospital, villupuram"
replace villageid="" if address==""
replace villageid="Vellore" if address=="317,RKC nagar,walaja road,walaja,vellore district"
replace villageid="Vellore" if address=="317,RKC nagar,walaja road,walaja,vellore district"
replace villageid="Vellore" if address=="317,RKC nagar,walaja road,walaja,vellore district"


* Order
order HHID_panel INDID_panel HHID2019 HHID2019other HHID2010 namemigrant INDID2019 wave year submissionyear name age sex relationshiptohead jatis address villageid
compress
drop code

save"$git\Tracking1-HH_indiv.dta", replace
****************************************
* END






****************************************
* APPEND ALL DATASETS
****************************************
use"$git\RUME-HH_indiv.dta", clear

append using "$git\NEEMSIS1-HH_indiv.dta"
append using "$git\NEEMSIS2-HH_indiv.dta"
append using "$git\Tracking1-HH_indiv.dta"

order HHID_panel INDID_panel HHID2010 HHID2016 HHID2020 HHID2019

save"$git\ODRIIS-HH_indiv.dta", replace
****************************************
* END

