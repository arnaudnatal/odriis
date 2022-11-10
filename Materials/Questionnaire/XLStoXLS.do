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
global file "N1"
*global choicelist "NEEMSIS2-datachoicelist.csv"


qui do"$dodir\XLStoXLS-1_import.do"
*qui do"$dodir\XLStoXLS-1-1_choicelisttoexcel.do"
qui do"$dodir\XLStoXLS-2_groups.do"
qui do"$dodir\XLStoXLS-3_repeats.do"
qui do"$dodir\XLStoXLS-4_questions.do"
qui do"$dodir\XLStoXLS-5_notes.do"
qui do"$dodir\XLStoXLS-6_export.do"
qui do"$dodir\XLStoXLS-7_clean.do"
