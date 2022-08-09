use"RUME"
keep HHID_panel jatis
rename jatis jatis2010
duplicates drop
save""

use"NEEMSIS1"
keep HHID_panel jatis
rename jatis jatis2016
duplicates drop
save"NEEMSIS1"

use"NEEMSIS2"
keep HHID_panel jatis
rename jatis jatis2020
duplicates drop
save"NEEMSIS2"

use"RUME"
merge 1:1 HHID_panel using "NEEMSIS1"
drop _merge
merge 1:1 HHID_panel using "NEEMSIS2"
drop _merge

*Organisation
foreach i in 10 16 20{
gen dummy_20`i'=.
}
foreach i in 10 16 20{
replace dummy_20`i'=1 if jatis20`i'!=.
}

gen panel_2010_2016=.
gen panel_2016_2020=.
gen panel_2010_2020=.
gen panel_2010_2016_2020=.

replace panel_2010_2016=1 if dummy_2010==1 & dummy_2016==1
replace panel_2016_2020=1 if dummy_2016==1 & dummy_2020==1
replace panel_2010_2020=1 if dummy_2010==1 & dummy_2020==1
replace panel_2010_2016_2020=1 if dummy_2010==1 & dummy_2016==1 & dummy_2020==1

recode dummy_2010 dummy_2016 dummy_2020 panel_2010_2016 panel_2016_2020 panel_2010_2020 panel_2010_2016_2020 (.=0)

tab1 dummy_2010 dummy_2016 dummy_2020 panel_2010_2016 panel_2016_2020 panel_2010_2020 panel_2010_2016_2020

drop jatis2010 jatis2016 jatis2020

save"panel_HH"
