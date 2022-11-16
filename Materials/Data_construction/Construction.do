*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to working directory directory
global path = "C:\Users\Arnaud\Documents\GitHub\odriis\Materials\Data_construction"
cd"$path"


*** Assets
do"2010_RUME-assets"
do"2016_NEEMSIS1-assets"
do"2020_NEEMSIS2-assets"

*** Occupations
do"2010_RUME-occupations"
do"2016_NEEMSIS1-occupations"
do"2020_NEEMSIS2-occupations"

*** Education
do"2010_RUME-education"
do"2016_NEEMSIS1-education"
do"2020_NEEMSIS2-education"

*** Debt
do"2010_RUME-debt"
do"2016_NEEMSIS1-debt"
do"2020_NEEMSIS2-debt"

*** Transferts
do"2010_RUME-transferts"
do"2016_NEEMSIS1-transferts"
do"2020_NEEMSIS2-transferts"

*** PTCS
do"2016_NEEMSIS1-ptcs"
do"2020_NEEMSIS2-ptcs"

*** Villages
do"2016_NEEMSIS1-villages"
