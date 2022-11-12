merge 1:1 wave hhid using "C:\Users\...\cpi.dta"

drop _merge

gen hhinpc_cpi = (hhinc/hhsize)/index_new
gen buspc_cpi = (bus/hhsize)/index_new
gen agrpc_cpi = (agr/hhsize)/index_new
gen othrpc_cpi = (othr/hhsize)/index_new
gen subpc_cpi = (sub/hhsize)/index_new
gen retpc_cpi = (ret/hhsize)/index_new
gen wagepc_cpi = (wage/hhsize)/index_new

label variable hhinpc_cpi "Per capita household income (2011 prices)"
label variable buspc_cpi "Per capita business income (2011 prices)"
label variable agrpc_cpi "Per capita agricultural income (2011 prices)"
label variable othrpc_cpi "Per capita other income (2011 prices)"
label variable subpc_cpi "Per capita subsidies (2011 prices)"
label variable retpc_cpi "Per capita retirement income (2011 prices)"
label variable wagepc_cpi "Per capita wage (2011 prices)"

drop hhinc bus agr othr sub ret wage

**Statistiques descriptives
sum hhinpc_cpi
tabstat hhinpc_cpi, stat(p50 mean)
ssc install univar
univar hhinpc_cpi
univar hhinpc_cpi, by(province)

**Agregation
collapse (mean) hhinpc_cpi, by(wave)
twoway (line hhinpc_cpi wave)

**On va regarder par province et par année
collapse (mean) hhinpc_cpi, by(province wave)
twoway (line hhinpc_cpi wave), by(province)
twoway (line hhinpc_cpi wave if province==32) (line hhinpc_cpi wave if province==43) (line hhinpc_cpi wave if province==45) (line hhinpc_cpi wave if province==52)

**Concentration sur l'année 2011
keep if wave==2011
histogram hhinpc_cpi
kdensity hhinpc_cpi, normal

**On fait varier la largeur du spectre
kdensity hhinpc_cpi, bwidth(500)
kdensity hhinpc_cpi, bwidth(5000)
kdensity hhinpc_cpi, bwidth(4000) normal

*Plusieurs Kernel
keep if (wave==1989) | (wave==2000) | (wave==2011)
kdensity hhinpc_cpi if (wave==1989), plot (kdensity hhinpc_cpi if (wave==2000) || kdensity hhinpc_cpi if (wave==2011)) legend(ring(0) pos(2) label(1 "1989") label(2 "2000") label(3 "2011"))
keep if hhinpc_cpi<25000
graph twoway (kdensity hhinpc_cpi if wave==1989 || kdensity hhinpc_cpi if wave==2000 || kdensity hhinpc_cpi if wave==2011)

**Hausse du revenu agricole ?
gen part_agr = agrpc_cpi/hhinpc_cpi
gen part_non_agr = 1 - part_agr
mean part_agr part_non_agr, over(wave)

**Gain précision sur les non agricoles
gen part_bus = buspc_cpi / hhinpc_cpi
gen part_othr = othrpc_cpi / hhinpc_cpi
gen part_sub = subpc_cpi / hhinpc_cpi
gen part_ret = retpc_cpi / hhinpc_cpi
gen part_wage = wagepc_cpi / hhinpc_cpi 
mean part_bus part_othr part_sub part_ret part_wage, over(wave)

**Indices de pauvreté
gen P0 = 1
replace P0 = 0 if hhinpc_cpi >= 2300
gen P1 = (2300-hhinpc_cpi)/2300
replace P1 = 0 if hhinpc_cpi >=2300
gen P2 = ((2300-hhinpc_cpi)/2300)^2
replace P2 = 0 if hhinpc_cpi >= 2300
mean P0 P1 P2, over(wave)

keep if wave==2011
mean P0 P1 P2, over(province)

**Modules Stata de Jenkins
ssc install povdeco
povdeco hhinpc_cpi, pline(2300) by(province)

**Inégalités
**Courbe de Lorenz
ssc install glcurve
glcurve hhinpc_cpi, lorenz by(wave) split

**Indice de Gini
ginidesc
ineqdeco

**bacariabdouloihid@yahoo.fr

























