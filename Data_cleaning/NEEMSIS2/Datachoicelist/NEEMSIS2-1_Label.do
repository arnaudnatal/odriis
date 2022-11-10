/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
23 février 2021
-----
TITLE: CLEANING AND MERGING NEEMSIS DATABASE

description: 	Nettoyage des fichiers long (inverser key et setof)
				Nettoyage de la base maitre
				Merging des fichiers long avec la base maitre
				Labéliser 
				
				On met dans directory le chemin vers un dossier qui contient 
				rien
				On crée un dossier dans le directory qu'on appelle MERGE_dir
				On met ce .do dans le dossier MERGE_dir et dedans on met tous 
				les .dta exportés de Survey CTO avec la choicelist.do
				
				NEEMSIS2_LAST-ego2questionnaire-_2socialnetworks-_2informalsocialcapital-_2covsntypehelpreceivedgroup
				
				typehelpreceivedgroup dans le fichier, mais pas dans la base 
				car nom trop long, donc avant de lancer ça, pour égo 2 et 3, 
				changer le .dta qui termine par sntypehelpreceivedgroup par 
				sntypehelpreceivedgrou (virer le p comme dans la base pour que
				l'automatisation fonctionne) idem pour businesspaymentinkindgroup
-------------------------
*/

global directory = "C:\Users\Arnaud\Downloads\NEEMSIS2\DATA"

global preamble "NEEMSIS2_LAST"

*Nb de caractère de preamble +2
global nbcharact "15"


global subdirectory ="MERGE_dir"

global subpath= "$directory" + "\" + "$subdirectory"






****************************************
* BEGIN: Labeling
****************************************
cd "$subpath"
clear all
*DATACHOICELIST AS DTA FILE so from do to txt 
import delimited datachoicelist.txt, clear 
egen doline=concat(v1 v2)
drop v1 v2
format %300s doline
gen n=_n
drop if strpos(doline,"_tamil")>0
gen 	varok=.
replace varok=1 if substr(doline,1,12)=="label define"
replace varok=1 if substr(doline,1,12)=="label values"
replace varok=1 if substr(doline,1,7)=="replace"
keep if varok==1
drop varok
split doline,p(" ")
duplicates tag doline3 if doline2=="values", gen(tag)
sort tag doline3 n
bysort tag doline3 : gen var=_n
list n doline3 var if tag==1, sepby(doline3) clean noo
drop if var==1 & tag==1
drop tag var
duplicates tag doline3 if doline2=="define", gen(tag)
sort tag doline3 n
bysort tag doline3 : gen var=_n
list n doline3 var if tag==2, sepby(doline3) clean noo
drop if var==1 & tag==2
drop if var==2 & tag==2
drop tag var
duplicates list doline3 if doline2=="values"
duplicates list doline3 if doline2=="values"
sort n
gen 	varname=doline2 if doline1=="replace"
replace	varname=doline3 if doline2=="values"
split varname, p(=)
drop varname varname2
rename varname1 varname
rename varname label_var
forvalues i=5(1)83{
drop doline`i'
}
save"_label_temp.dta",replace
*FAIRE MATCHER LABEL ET VAR AVEC LE FICHIER EXCEL
import delimited label_var_match.csv, delimiter(";") varnames(1) clear 
keep if substr(type,1,6)=="select"
split appearance, p(')
drop appearance1 appearance2 appearance3 appearance4 appearance5 appearance7 appearance8 appearance9
keep if appearance6!=""
keep name appearance6
rename name var_name
rename appearance label_var
split label_var, p(_)
drop label_var2 label_var
rename label_var1 label_var
tab label_var  // remove maj
replace label_var="maritalstatusid" if label_var=="Maritalstatusid"
replace label_var="religionid" if label_var=="Religionid"
replace label_var="sex1id" if label_var=="Sex1id"
replace label_var="sexid" if label_var=="Sexid"
replace label_var="subjectsid" if label_var=="Subjectsid"
save"_label_var_name.dta",replace
*CREATE LABEL VALUES
use"_label_var_name.dta", clear
merge m:m label_var using "_label_temp.dta"
sort _merge
gen 	count=1 if doline2=="define"
replace count=2 if doline1=="replace"
replace count=3 if doline2=="values"
drop if var_name==""
gen labelvalues="label values " + var_name + " " + label_var
duplicates tag labelvalues, gen(tag)
tab tag
drop tag
duplicates drop labelvalues, force
keep var_name labelvalues
rename labelvalues doline
replace doline=substr(doline, 1, length(doline) - 2)
drop if doline=="label values householdid villagearea"
replace doline="label values villagearea villagearea" if doline=="label values villagearea village"
gen 	n1_doline1="capture confirm numeric v " + var_name
gen 	n1_doline2="if !_rc {"
gen 	n1_doline3=doline
gen 	n1_doline4="}"
gen 	n1_doline5="else {"
gen 	n1_doline6=" "
gen 	n1_doline7="}"
gen n=_n
reshape long n1_doline, i(n) j(count)
save"_labelvalues.dta", replace
*CREATE LABEL DEFINE AND REPLACE
use"_label_var_name.dta", clear
merge m:m label_var using "_label_temp.dta"
sort _merge
drop if _merge==1
drop _merge
gen 	count=1 if doline2=="define"
replace count=2 if doline1=="replace"
replace count=3 if doline2=="values"
drop if count==3
duplicates tag doline if count==1, gen(tag)
sort tag
tab tag
duplicates drop doline if count==1, force
tab tag
drop tag
duplicates tag doline if count==2, gen(tag)
sort tag
tab tag
duplicates drop doline if count==2, force
tab tag
drop tag
preserve
keep if count==1 
keep doline var_name
replace doline=doline + ", replace"
save"_labeldefine.dta", replace
restore
keep if count==2
duplicates tag doline, gen(tag)
tab tag
keep label_var doline
save"_replace.dta", replace
use"_label_var_name.dta", clear
duplicates tag var_name, gen(tag)
tab tag 
drop tag
merge m:m label_var using "_replace.dta"
format %80s doline
drop if _merge==1
sort _merge
split doline, p(=) gen(temp)
drop temp1 temp3 temp4 temp5 temp6
split temp2, p(" ")
drop temp2 temp22 temp23 temp24
rename temp21 first
replace first="=" + first
split doline, p("if ") gen(temp)
drop temp1
split temp2, p(==) 
drop temp21 temp23
rename temp22 second
replace second="==" + second
replace second="" if second=="=="
split temp2, p(>) 
drop temp21
replace second=">" + temp22 if second==""
drop temp2 temp22
gen cmd="replace"
gen cmd2="if"
egen doline_new=concat(cmd var_name first cmd2 var_name second), p(" ")
keep var_name doline_new
keep if var_name!=""
rename doline_new doline
gen 	n1_doline1="capture confirm numeric v " + var_name
gen 	n1_doline2="if !_rc {"
gen 	n1_doline3=doline
gen 	n1_doline4="}"
gen 	n1_doline5="else {"
gen 	n1_doline6=" "
gen 	n1_doline7="}"
gen n=_n
reshape long n1_doline, i(n) j(count)
save"_replace.dta", replace
*CREATE DESTRING
use"_label_var_name.dta", clear
gen doline="destring " + var_name + ", replace"
gen 	n1_doline1="capture confirm v " + var_name
gen 	n1_doline2="if !_rc {"
gen 	n1_doline3=doline
gen 	n1_doline4="}"
gen 	n1_doline5="else {"
gen 	n1_doline6=" "
gen 	n1_doline7="}"
gen n=_n
reshape long n1_doline, i(n) j(count)
save"_destring.dta", replace
*APPEND _db
use"_labeldefine.dta", clear
gen n1_doline=doline
append using "_destring.dta"
append using "_replace.dta"
append using "_labelvalues.dta"
keep n1_doline
*DO FILE FORMAT
outfile n1_doline using "datachoicelist_v2.do", noquote replace
*/
*LABEL
clear all
cd "$subpath"
filelist, dir("$subpath") pattern(*.dta)
*keep if substr(filename,1,9)=="NEEMSIS2_"
*drop if filename=="$preamble.dta"
*drop if filename=="$preamble~_v2.dta"
sort filename
tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local s = filename
	use"`s'", clear
	do "_1-3-datachoicelist_v2.do"
	tempfile save`i'
	save "`s'", replace
}
****************************************
* END
