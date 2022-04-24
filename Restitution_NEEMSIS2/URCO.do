*2020-21
fre villagearea
decode villagearea, gen(area)
replace area="1" if strpos(area,"Ur")
replace area="2" if strpos(area,"Colony")
destring area, gen(area2)
label define area2 1"Ur" 2"Colony"
label values area2 area2
drop area

ta villagearea area2
drop villagearea
rename area2 villagearea
