*****Arnaud NATAL
*****M2 - ESDP

////Construction d'indicateurs
////Mathieu Clément


/*
Avant d'effectuer une commmande collapse il est nécessaire
d'enregistrer la base de données
*/











			////// Base de données



	//// Merge 2 bases de données
merge 1:1 wave hhid using "C:\Users\anatal\Downloads\Préparation des données\cpi.dta"
drop_merge
/*
1:1 car nous restons sur le même niveau d'agrégation
wave et hhid représente les clés de liaisons pour que les données correspondes
nous lions par l'année d'enquête et le numéro du ménage
On supprime la variable merge = elle montre que tout à bien fonctionné
*/






	//// Créer des variables par tête
gen hhinpc_cpi = (hhinc/hhsize)/index_new
gen buspc_cpi = (bus/hhsize)/index_new
gen agrpc_cpi = (agr/hhsize)/index_new
gen othrpc_cpi = (othr/hhsize)/index_new
gen subpc_cpi = (sub/hhsize)/index_new
gen retpc_cpi = (ret/hhsize)/index_new
gen wagepc_cpi = (wage/hhsize)/index_new





	//// Changement des labels
label variable hhinpc_cpi "Per capita household income (2011 prices)"
label variable buspc_cpi "Per capita business income (2011 prices)"
label variable agrpc_cpi "Per capita agricultural income (2011 prices)"
label variable othrpc_cpi "Per capita other income (2011 prices)"
label variable subpc_cpi "Per capita subsidies (2011 prices)"
label variable retpc_cpi "Per capita retirement income (2011 prices)"
label variable wagepc_cpi "Per capita wage (2011 prices)"






	//// Suppression des variables en niveau pour alléger la base
drop hhinc bus agr othr sub ret wage













		////// Statistiques descriptives



	//// Variables quantitatives
sum hhinpc_cpi
**ou
tabstat hhinpc_cpi, stat(p50 mean)
**ou
ssc install univar
univar hhinpc_cpi
univar hhinpc_cpi, by(province)
**Commandes pas adaptée car on est en données de panel









		////// Agregation des données

	//// Dimension annuel (wave)
**ENREGISTREMENT**
collapse (mean) hhinpc_cpi, by(wave) 










		////// Analyse graphique des revenus
		
		

	//// Graphique général
twoway (line hhinpc_cpi wave)


	//// Graphique par province et par année
**ENREGISTREMENT**
collapse (mean) hhinpc_cpi, by(province wave)


// Plusieurs graphiques
twoway (line hhinpc_cpi wave), by(province)


// Un seul graphique
twoway (line hhinpc_cpi wave if province==32) (line hhinpc_cpi wave if province==43) (line hhinpc_cpi wave if province==45) (line hhinpc_cpi wave if province==52)
**Forte disparité entre les provinces


// Concentration sur une année particulière
keep if wave==2011








	//// Kernel density

// Un seul
kdensity hhinpc_cpi, normal
kdensity hhinpc_cpi, bwidth(500)
kdensity hhinpc_cpi, bwidth(5000) normal
/*
Spectre petit = bandwidth faible = beaucoup moins lisse
On veut quelque chose de lisse car on est dans de l'approximation
C'est la forme qui nous intéresse et non les sauts
*/
kdensity hhinpc_cpi, bwidth(5000) normal
**Etaler à droite et très pointu


// Plusieurs kernel sur un graphique
keep if (wave==1989) | (wave==2000) | (wave==2011)
kdensity hhinpc_cpi if (wave==1989), plot (kdensity hhinpc_cpi if (wave==2000) || kdensity hhinpc_cpi if (wave==2011)) legend(ring(0) pos(2) label(1 "1989") label(2 "2000") label(3 "2011"))
**ou
graph twoway (kdensity hhinpc_cpi if wave==1989 || kdensity hhinpc_cpi if wave==2000 || kdensity hhinpc_cpi if wave==2011)
/*
Bcp de ménages ont peu de rev et peu en ont beaucoup
Au fil du temps, la courbe s'applati donc il y a de moins en moins de personnes pauvres, et de plus en plus de moyen
On va couper le graph vers 25000 pour que ce soit plus lisible
*/
**Gain en précision
keep if hhinpc_cpi<25000
graph twoway (kdensity hhinpc_cpi if wave==1989 || kdensity hhinpc_cpi if wave==2000 || kdensity hhinpc_cpi if wave==2011)
/*
Réduction de la pauvreté d'un côté car applatissement
Mais distribution s'étalent plus vers le droite donc hausse
des inégalités car il y a plus de riches
2 tendances contradictoires (baisse pauvre, hausse inég)
Mais vrai qu'entre le bleu et le vert (car très étalé à droite)
Délicat à dire avec la rouge
*/




		////// Analyse des revenus


**Qu'est-ce qui fait augmenter le revenu (agricoles ou pas) ?


	//// Générer une variable de "part"

// Non agri vs agri
gen part_agr = agrpc_cpi/hhinpc_cpi
gen part_non_agr = 1 - part_agr
mean part_agr part_non_agr, over(wave)
/*
Diminution de la part des rev agri dans le temps (plus de 20 pts de pource)
Ménages ruraux deviennent de moins en moins dep des activités agricoles
Monter en puissance des acti non agri
On va aller plus précis avec les non agri
*/

// Gain en précision
gen part_bus = buspc_cpi / hhinpc_cpi
gen part_othr = othrpc_cpi / hhinpc_cpi
gen part_sub = subpc_cpi / hhinpc_cpi
gen part_ret = retpc_cpi / hhinpc_cpi
gen part_wage = wagepc_cpi / hhinpc_cpi 
mean part_bus part_othr part_sub part_ret part_wage, over(wave)
/*
Pour le business rien de ouf donc ce n'est pas ce qui explique la hausse
Concernent autres rev là c'est plus impt (forte hausse)
Subventions diminuent 
Retraite hausse mais pas ouf
Le salaire hausse un peu aussi

C'est donc la part des autres revenus qui fait diminuer la part de l'agricole
Composition autre revenu:
Transferts privés (diaspora, migrants, amis..)
Migration interne énorme donc on doit trouver la dedans l'argent
des ex travailleurs de campagne qui sont parti en ville et qui envoient
une bonne partie de leur salaire

Subv diminue = baisse d'une composante pour l'égalité
*/







		////// Indicateurs d'inégalités
		
		
		
	//// FGT à la main
/*
Pa = 1/n SOMME i=1 à q de [(Z-yi)/Z]^a
P0 = part des pauvres = incidence de la pauvreté (q/n)
P1 = intensité ou profondeur de la pauvreté (1/n) SOMME de (Z-yi)/Z
P2 = inégalité ou sévérité de la pauvreté (1/n) SOMME de (Z-yi)/Z
P2 tient plus compte des plus pauvres

Seuil de pauvreté pour la Chine rural au prix de l'année 2011 = 2300 yuan
*/

gen P0 = 1
replace P0 = 0 if hhinpc_cpi >= 2300

gen P1 = (2300-hhinpc_cpi)/2300
replace P1 = 0 if hhinpc_cpi >=2300

gen P2 = ((2300-hhinpc_cpi)/2300)^2
replace P2 = 0 if hhinpc_cpi >= 2300
**ou
gen P2 = P1^2

mean P0 P1 P2, over(wave)

/*
Avec P0 on passe de 55 à 14
Enorme diminution de la pauvreté
2 moments de forte baisse
93 97 et 06 09
Le premier correspond à l'explosion de la migration interne (fin du Hukou
stricte) = libération de la migration interne
Pauvreté baisse donc à partir des années 90
et ce tasse un peu en fin de période
*/

// Par provices
keep if wave==2011
mean P0 P1 P2, over(province)
**Presque 10* plus de pauvres dans certaines provinces que dans d'autres




	//// Module pour FGT
ssc install povdeco
povdeco hhinpc_cpi, pline(2300) by(province)
**pline = poverty line


/*
av FGT = ils sont décomposables
Pa=Pa(intragrp)+Pa(intergrp)

'share' contribution de chaque province à la 
pauvreté de l'ensemble de l'échantillon questionnée (pa)
La somme doit donc faire 100%


On va regarder les inégalités maintenant
Gini
Courbe de Lorenz

= Indices d'entropie
Theil
Coefficient de variation

= Quantiles
Quantile share
Quantile share ratio
Rapport inter quantiles
*/



	//// Courbe de Lorenz
ssc install glcurve
glcurve hhinpc_cpi, lorenz by(wave) split
/*
La distribution des rev en 2011 est plus inégalitaire que pour
les 2 autres années
On peut dire que c'est vrai parce que les deux courbes ne se croisent pas

Concernant 2000 et 2011 le classement est plus compliqué
Il ne va pas y avoir un écart trop fort
Le graphique est la chose la plus intéressante pour lire des inégalités
*/




	//// Indice de Gini
ssc install ginidesc
ginidesc hhinpc_cpi, by(wave)
/*
deuxième tableau
On voit que globalement le gini augmente dans le temps
même si on voit des variations sur le court terme
La hausse globale est assez importante quand même
+7.5 points
à partir de 1997 il y a une forte hausse quasi régulière
accroissement significatif des inégalités de revenus en zone rural
Concernant la valeur absolue de l'indice:
Am Lat parfois des coef à 0.5
Au dela de 0.4 c'est un Gini très élevé donc niveau d'inégalité très élevé
*/

// Répartition régionale
ginidesc hhinpc_cpi if wave==2011, by(province)
/*
Henan et Hubei = Gini très élevés, provinces de l'intérieur
et non cotières donc province les plus pauvres
développement spatialement inégalitaire
c'est à partir des années 2000 que le dvp est "arrivé" dans les
provinces intérieur
En 2011 elles sont donc en plein dvp = accroissement des inégalités
baisse des acti agri et hausse du non agri
donc montée en puissance des inégalités car les rev
agri sont plutôt des rev égalitaires alors que les rev non agri sont plus
inégalitaire
Modification sectorielle qui se répercute sur les revenus des ménages

Le premier tableau représente la décomposition de l'indice de Gini
Composante intra groupe (moy pond des deg d'inégalités à l'intérieur des provinces)
within
+composante inter groupe (disparité de rev moy entre les provinces)
si impt = forte disparité de rev entre les provinces
between
Overlap représente un résidu car Gini est un indice qui n'est pas 
décomposable entre les sous-groupes donc il n'y a pas de 
décomposition parfaite, d'où le résidu qui n'est pas interpretable
*/







	//// Indices d'entropie (Décomposable par groupe inter/intra groupes)
/*
Donc pour faire analyse inter/intra il ne faut pas regarder Gini mais
les indices d'entropie (GE generalize entropy)
basé sur une comparaison des rev des ménages avec la moy de tous
dépend d'un para alpha 
On aura:
GE(0) = déviation log moyenne (mean log deviation)
GE(1) = indice de Theil
GE(2) = moitié du coef de variation au carré
le coef de variation c'est l'ecart-type/moyenne
alpha nous dit sur l'ensemble de la distribution ou est ce que l'indice
sera le plus sensible
voir les notes
*/
ssc install ineqdeco
ineqdeco hhinpc_cpi if wave==2011, by(province)
/*
les 3 premiers tab = rapport interquantiles + toute la série 
des indices d'entropie
Atkinson = autre famille d'indice proche des GE
GE(1) le plus faible donc les écart de rev ne sont pas
majoritairement situé au milieu de la distrib mais plus
en bas et en haut
on ne compare pas GE et Gini
Ensuite on a les décomposition par sous groupes
Subgroup indices GE
disparité très impt entre provinces
within = intra 
between = inter
Ici indice glob = intra + inter = décompo parfaite
C'est intra qui compte le plus, et ce sera toujours le cas
si inter = au dela de 10 ou 20% la ce sera important donc disparités impt
si moins de 5% = négli
Ici on est à 10-15% donc il y a des disparités
Pour commenter on regarde les parts
La part inter représente x% de l'inégalité totale
*/







	//// Indice de Gini (Décomposable par source/composante)
/*
On revient sur Gini car il est décomposable par sources/cp (et non par grp)
ex rev agri, retraites, transf, busin...
*/
ssc install descogini
gen hhnagrpc_cpi = hhinpc_cpi - agrpc_cpi
descogini hhinpc_cpi agrpc_cpi hhnagrpc_cpi if wave==2011
** Syntaxe: descogini rev_glob cp1 cp2 cp3
/*
share = part de la compo dans l'inégalité totale
28% de l'inega tota est lié au rev agri
donc 72% rev non agri
On compare ca avec Sk
on voit que Sk pour agri = 0.39 donc Sk pour non agri = 0.61
on voit donc que la part dans l'inéga est sup à celle du rev donc
la composante rev non agri est inégalisatrice

si le rev agri augmente de 1% le Gini va baisser de 11% 
% change s'interprete comme une élasticité donc c'est surtout le signe
qui importe, si + alors inégalisatrice si - égalisatrice
*/

//On regarde d'autres années
descogini hhinpc_cpi agrpc_cpi hhnagrpc_cpi if wave==1989
**Le poids de l'agri a baissée et celle du non agri a augmenté
descogini hhinpc_cpi agrpc_cpi buspc_cpi othrpc_cpi subpc_cpi retpc_cpi wagepc_cpi if wave==2011
/*
subv = petite part car a quasiment disparu ajdh
autres rev a tendance à faire diminuer les inégalité car il y a 
notmament les transferts de fonds privés
les autres composantes sont inégalisatrices
surtout les salaires (composante inégalitaire la plus importante du rev)
sous Mao les salaires été fixé 
ouverture = grande libéralisation donc les salaires
ont rpz les écarts du ptivités donc très inégalitaires
business = même principe

On peut aussi l'appliquer à un indicateur composite de bien-être
comme l'IDH par ménage
*/








		////// Introduction aux boucles

**Les boucles on va récup pour des sous groupes la val calculée par la cmd ineqdeco
**On demande de créer l'indicateur en question dans la base de données
gen gini=.
**Puis on définit la variable de groupe
egen group=group(province)
/*
avec Stata quand on fait sum, il garde les valeurs temporaire dans R(max)
r(max)=nb d'indive par groupe
nous on veut le nombre d'obs max par sous groupes
combien de ménages est ce que j'ai par province
*/
sum group, meanonly
/*
regarder le meanonly
on lance la boucle
pour les valeurs de i allant de 1 à r(max)
*/

forval i=1/`r(max)'{
ineqdeco hhinpc_cpi if group==`i'
replace gini=r(gini) if group==`i'}
/*
Pour le r(gini) il faut bien vérfier
que (x) correspond bien à la variable qu'on veut "isoler"
ca dépend des programmes
on cherche à isoler "gini" dans la commande "ineqdeco"
on fait varier r(max) de groupe en groupe
pour monter à l'échelle spatiale on collapse pour passer à l'échelle des pro
*/



