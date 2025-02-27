***********************************
* Programme mcacontrib
* Marie Plessz le 24 juin 2014
/* après une MCA, calcule la contribution des variables aux axes selon les
formules de Le Roux et Rouanet (Multiple Correspondance analysis)
et comme dans R, en divisant le résultat de stata par la racine carrée
de la eigenvalue de la dimension correspondante.
*/
* à utiliser après : mca [varlist], method (indicator) normal(princ)
*********************************
program mcacontrib
version 12
preserve
* Récupérer les valeurs propres et calculer les racines carrées
*les valeurs propres sont dans e(Ev).
matrix A=e(Ev)
matrix C=J(1,`e(f)',0)
forval j = 1/ `= e(f)' {
local colnames " `colnames' rcEv`j' "
}
// a créé de jolis noms pour les colonnes
matrix colnames C = "`colnames '"
forval j = 1/ `= e(f)' {
mat C[1, `j'] = sqrt(A[1, `j'])
}
svmat2 C, name(col)
// a sauvé les racinnes carrées des Ev dans des variables
* récupérer les contributions stata
//sauver les bonnes colonnes dans de nouvelles variables
forval j = 1/ `= e(f)' {
local k = (3*`j') +3
matselrc e(cGS) Contr`j', col(`k')
svmat2 Contr`j', rname(varname`j') names(oldc`j')
}
// dispensable : sauve aussi le nom des lignes dans une seule var pour pouvoir vérifier
local j=2
while `j'<= `e(f)' {
drop varname`j'
local j=`j'+1
}
* calculer les nouvelles contributions
//calcul effectué sur les variables
quietly {
forval j = 1/ `= e(f)' {
replace rcEv`j'=rcEv`j'[1]
gen newct`j'=oldc`j' / rcEv`j'
label var newct`j' "Contrib `j' nouveau calcul"
}
}
* sauver le résultat dans une matrice NewContrib
mkmat newct* in 1/`=rowsof(e(cGS))', matrix(NewContrib) //rownames(varname1)
//donner les noms de lignes d'origine à la nouvelle matrice
local subs : rownames e(cGS)
local eqs : roweq e(cGS)
matrix rownames NewContrib = `subs'
matrix roweq NewContrib = `eqs'
//afficher le résultat
di " - Contributions calculées comme dans R - "
di "Rappel : utiliser les options method(indicator) normal(principal)"
matlist NewContrib
di _n "Résultats sauvés dans la matrice NewContrib"
* restaurer les données
restore
end
*********************************************
