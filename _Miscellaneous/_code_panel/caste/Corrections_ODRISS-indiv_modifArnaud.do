/*
All modifications that follow are done
after discussion with Venkat
See email.
*/



****************************************
* Names
****************************************
use"$directory\ODRIIS-indiv.dta", clear

********** All names
foreach var of varlist jatis2010 jatis2016 jatis2020 {
fre `var', miss 	
}
* No missing value


********** Rename
replace jatis2010="Mudaliar" if jatis2010=="Muthaliyar"
replace jatis2010="Arunthathiyar" if jatis2010=="Arunthatiyar"

********** Backup former typology
foreach x in jatis2010 jatis2016 jatis2020 caste2010 caste2016 caste2020 {
clonevar BU_`x'=`x'
}






****************************************
* Panel consistency of jatis
****************************************

********** 2016 to 2016-17
gen pb1=1 if jatis2010!=jatis2016 & jatis2010!="" & jatis2016!=""
ta pb1
ta jatis2010 jatis2016 if pb1==1

***** Gramani in 2010 and SC in 2016
ta HHID_panel if jatis2010=="Gramani" & jatis2016=="SC"
replace jatis2010="SC" if HHID_panel=="MANAM28"

***** Other in 2010 and Kulalar in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="Kulalar"
replace jatis2010="Kulalar" if HHID_panel=="GOV38"
replace jatis2016="Kulalar" if HHID_panel=="GOV38"
replace jatis2020="Kulalar" if HHID_panel=="GOV38"

***** Other in 2010 and Muslims in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="Muslims" 
replace jatis2010="Muslims" if HHID_panel=="SEM1" |  HHID_panel=="SEM16" |  HHID_panel=="SEM26" |  HHID_panel=="SEM28" |  HHID_panel=="SEM35" |  HHID_panel=="SEM40" |  HHID_panel=="SEM43"

***** Other in 2010 and Naidu in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="Naidu"
replace jatis2010="Naidu" if HHID_panel=="SEM17"
replace jatis2010="Navithar" if HHID_panel=="ORA10"

***** Other in 2010 and Padayachi in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="Padayachi"  
replace jatis2010="Padayachi" if HHID_panel=="ELA49"

***** Other in 2010 and SC in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="SC"  
replace jatis2010="SC" if HHID_panel=="KOR23" | HHID_panel=="MAN22"

***** Other in 2010 and Vanniyar in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="Vanniyar" 
replace jatis2010="Vanniyar" if HHID_panel=="KUV52"

***** Other in 2010 and Yathavar in 2016
ta HHID_panel if jatis2010=="Other" & jatis2016=="Yathavar" 
replace jatis2010="Yathavar" if HHID_panel=="KAR48"

***** Settu in 2010 and Chettiyar in 2016
ta HHID_panel if jatis2010=="Settu" & jatis2016=="Chettiyar" 
replace jatis2010="Chettiyar" if HHID_panel=="SEM10" | HHID_panel=="SEM48"

***** Settu in 2010 and Vanniyar in 2016
ta HHID_panel if jatis2010=="Settu" & jatis2016=="Vanniyar" 
replace jatis2010="Vanniyar" if HHID_panel=="MAN18"

***** Vanniyar in 2010 and Padayachi in 2016
ta HHID_panel if jatis2010=="Vanniyar" & jatis2016=="Padayachi" 
replace jatis2010="Padayachi" if HHID_panel=="ELA5" | HHID_panel=="ORA38"



********** 2016-17 to 2020-21
gen pb2=1 if jatis2016!=jatis2020 & jatis2016!="" & jatis2020!=""
ta pb2
ta jatis2016 jatis2020 if pb2==1

***** Asarai in 2016 and Vanniyar in 2020
ta HHID_panel if jatis2016=="Asarai" & jatis2020=="Vanniyar" 
replace jatis2020="Asarai" if HHID_panel=="MANAM11"

***** Gramani in 2016 and Vanniyar in 2020
ta HHID_panel if jatis2016=="Gramani" & jatis2020=="Vanniyar" 
replace jatis2020="Gramani" if HHID_panel=="MANAM12"

***** Mudaliar in 2016 and Padayachi in 2020
ta HHID_panel if jatis2016=="Mudaliar" & jatis2020=="Padayachi" 
replace jatis2020="Mudaliar" if HHID_panel=="GOV19"

***** Mudaliar in 2016 and Vanniyar in 2020
ta HHID_panel if jatis2016=="Mudaliar" & jatis2020=="Vanniyar" 
replace jatis2020="Mudaliar" if HHID_panel=="GOV2"

***** Nattar in 2016 and SC in 2020
ta HHID_panel if jatis2016=="Nattar" & jatis2020=="SC" 
replace jatis2016="SC" if HHID_panel=="MANAM18"

***** Padayachi in 2016 and Vanniyar in 2020
ta HHID_panel if jatis2016=="Padayachi" & jatis2020=="Vanniyar" 
replace jatis2020="Padayachi" if HHID_panel=="KUV42"

***** Vanniyar in 2016 and Padayachi in 2020
ta HHID_panel if jatis2016=="Vanniyar" & jatis2020=="Padayachi" 
replace jatis2020="Vanniyar" if HHID_panel=="ELA16" | HHID_panel=="KAR30"



********** 2010 to 2020-21
gen pb3=1 if jatis2010!=jatis2020 & jatis2010!="" & jatis2020!=""
ta pb3
ta jatis2010 jatis2020 if pb3==1

***** Other in 2010 and Vanniyar in 2020
ta HHID_panel if jatis2010=="Other" & jatis2020=="Vanniyar" 
replace jatis2010="Vanniyar" if HHID_panel=="ORA37"

***** Rediyar in 2010 and Vanniyar in 2020
ta HHID_panel if jatis2010=="Rediyar" & jatis2020=="Vanniyar" 
replace jatis2020="Rediyar" if HHID_panel=="MANAM40"







****************************************
* Panel consistency of caste
****************************************

********** 2010 
ta jatis2010 caste2010 

***** Muslims as upper?
ta HHID_panel if jatis2010=="Muslims" 
replace caste2010="Dalits" if HHID_panel=="SEM1" | HHID_panel=="SEM16" | HHID_panel=="SEM26" | HHID_panel=="SEM28" 
replace caste2010="Middle" if HHID_panel=="SEM35" | HHID_panel=="SEM40" | HHID_panel=="SEM43"

***** SC as middle?
ta HHID_panel if jatis2010=="SC" & caste2010=="Middle" 
replace caste2010="Dalits" if HHID_panel=="MAN22" | HHID_panel=="MANAM28"

***** Vanniyar as upper?
ta HHID_panel if jatis2010=="Vanniyar" & caste2010=="Upper" 
replace caste2010="Middle" if HHID_panel=="MAN18"

***** Yathavar as middle?
ta HHID_panel if jatis2010=="Yathavar" 
replace caste2010="Upper" if HHID_panel=="KAR48"


******** 2016-17
ta jatis2016 caste2016

***** Muslims as middle?
ta HHID_panel if jatis2016=="Muslims" 
replace caste2016="Dalits" if HHID_panel=="SEM1" | HHID_panel=="SEM16" | HHID_panel=="SEM26" | HHID_panel=="SEM28" 

***** SC as middle?
ta HHID_panel if jatis2016=="SC" & caste2016=="Middle"
replace caste2016="Dalits" if HHID_panel=="MANAM18"


******** 2020-21
ta jatis2020 caste2020

***** Mudaliar as middle?
ta HHID_panel if jatis2020=="Mudaliar" & caste2020=="Middle"
replace caste2020="Upper" if HHID_panel=="GOV19" | HHID_panel=="GOV2"

****** Muslims as middle?
ta HHID_panel if jatis2020=="Muslims" 
replace caste2020="Dalits" if HHID_panel=="SEM1" | HHID_panel=="SEM16" | HHID_panel=="SEM26" | HHID_panel=="SEM28" 

***** Rediyar as middle?
ta HHID_panel if jatis2020=="Rediyar" & caste2020=="Middle"
replace caste2020="Upper" if HHID_panel=="MANAM40" & caste2020=="Middle"


********** Panel
ta caste2010 caste2016
*Ok
ta caste2010 caste2020
*Ok 
ta caste2016 caste2020 
*Ok


save "$directory\ODRIIS-indiv_jatis.dta", replace
****************************************
* END
