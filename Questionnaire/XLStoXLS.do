*-------------------------
*Arnaud NATAL
*arnaud.natal@u-bordeaux.fr
*-----
*XLSform to XLSquest
*-----
*-------------------------

********** Clear
clear all
macro drop _all

********** Path to do
global dofile = "C:\Users\Arnaud\Documents\GitHub\odriis\Questionnaire"

********** Path to working directory directory
global directory = "C:\Users\Arnaud\Documents\GitHub\odriis\Questionnaire\XLSform"
cd"$directory"

global dodir = "C:\Users\Arnaud\Documents\GitHub\odriis\Questionnaire"
global file "NEEMSIS_tracking_2022_v10_trans.xlsx"



do"$dodir\XLStoXLS-1_import.do"
do"$dodir\XLStoXLS-2_groups.do"
do"$dodir\XLStoXLS-3_repeats.do"
do"$dodir\XLStoXLS-4_questions.do"
do"$dodir\XLStoXLS-5_append.do"
