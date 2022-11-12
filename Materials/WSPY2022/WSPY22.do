*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*WSPY2022
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\Materials\WSPY2022"



********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\MEGA\ODRIIS\Materials\WSPY2022\"
cd"$directory"

********** Database names
global wave1 = "RUME-HH"
global wave2 = "NEEMSIS1-HH"
global wave3 = "NEEMSIS2-HH"
global occup1 = "RUME-occupations"
global occup2 = "NEEMSIS1-occupations"
global occup3 = "NEEMSIS2-occupations"

********** Scheme
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid

********** Deflate
*https://data.worldbank.org/indicator/FP.CPI.TOTL?locations=IN
*(100/158) if year==2016
*(100/184) if year==2020