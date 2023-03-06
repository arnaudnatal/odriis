*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*Housing
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\Dropbox\RUME-NEEMSIS\Data\Construction"
cd"$directory"

********** Database names
global data = "RUME-HH"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020






****************************************
* Houing
***************************************
use"$data", clear


/*
According to "Poverty of Housing in Rural India", M. Mahadeva:
The total housing stock of the country has been classified under three categories, pucca, semi-pucca and kutcha, on the basis of the materials used to construct the walls and roof.
Kutcha housing is further classified into serviceable (having solid mud walls but a thatched root) and non-serviceable housing (with walls and roof, both made of flimsy materials) which need to be rebuilt at short intervals as they may not last long. 
*/



save"outcomes\RUME-assets", replace
****************************************
* END
