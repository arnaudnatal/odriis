/* 
CJ: I club some villages depending on some main regions of survey (especially the new one: Tiruppur region)
There is additional clubbing we coud do but I prefer not to do too much for now, as some villages with few HHs are really
quite distant from each others, and may face great differences in terms of access to bank/infrastructure.
Two HHs were found for instance near Chennai (i.e. the suburb, Ponamallee) and so clubbing it with others doesn't make sense to me
*/
 
replace villagearea="TIRUP_reg" if tracked==1 & (villageid_new=="Somanur"|villageid_new=="Tiruppur"|villageid_new=="Chinnaputhur")
tab villagearea

gen villagename2010=villagename
drop villagename
gen villagename2016=villageid_new
gen villagename2016_club=villagename2016
tab villagename2016_club

replace villagename2016_club="TIRUP_reg" if tracked==1 & (villageid_new=="Somanur"|villageid_new=="Tiruppur"|villageid_new=="Chinnaputhur")
tab villagename2016_club
order ID villagename2010 villagename2016 villagename2016_club villageid_new villageid_new_comments villagearea year tracked

/* 
CJ: I thought we might need to club the only HH found in Chengapattu with the near big village (Villiambakkam),
clubbing them all with nearby Athur
Otherwise we may not identify a dummy for Chengalpattu
But after matching, it happens that this HH is dropped. So I deactivate this line.
replace villagename2016_club="VILLIAM_reg" if tracked==1 & (villageid_new=="Villiambakkam"|villageid_new=="Chengalpattu"|villageid_new=="Athur")
*/
 
* CJ: I generate dummies for closeness to main agglomerations, so that we test effects depending on access to city Banks

gen town_close=0

replace town_close=1 if (villageid_new=="Chengalpattu"|villageid_new=="Poonamallee"|villageid_new=="Tiruppur"|villageid_new=="Somanur"|villageid_new=="ELA"|villageid_new=="MAN"|villageid_new=="NAT"|villageid_new=="ORA"|villageid_new=="SEM"|villageid_new=="MANAM"|villageid_new=="KAR")
/*
The 10 origin villages are rather all close to cities, but two different ones:
Panruti : "ELA"|"MAN"|"NAT"|"ORA"|"SEM"|"MANAM"|"KAR"
Villupuram for KUV, KOR, GOV
So I don't expect so great difference using the previous 'town_close'
instead I create dummies for closeness to certain cities (all villages are included,
except one: Chinnaputhur which is distant to all towns with at least 1h30 drive to any towns)
*/

gen near_panruti=0
replace near_panruti=1 if (villageid_new=="ELA"|villageid_new=="MAN"|villageid_new=="NAT"|villageid_new=="ORA"|villageid_new=="SEM"|villageid_new=="MANAM"|villageid_new=="KAR")

gen near_villupur=0
replace near_villupur=1 if (villageid_new=="KUV"|villageid_new=="KOR"|villageid_new=="GOV")

gen near_tirup=0
replace near_tirup=1 if (villageid_new=="Tiruppur"|villageid_new=="Somanur")

gen near_chengal=0
replace near_chengal=1 if (villageid_new=="Chengalpattu"|villageid_new=="Athur"|villageid_new=="Villiambakkam")

gen near_kanchip=0
replace near_kanchip=1 if (villageid_new=="Sembarambakkam"|villageid_new=="Walajabad")

gen near_chennai=0
replace near_chennai=1 if (villageid_new=="Poonamallee")

gen most_remote=0
replace most_remote=1 if (villageid_new=="Chinnaputhur")