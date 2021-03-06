# NEEMSIS tracking 2022: modification

## Design of questionnaire

	- HH questionnaire (for structure of HH + details of new members)
	- Migration questionnaire for the principal migrant (husband / son)
	- Individual migrant for all the migrants of the family (sex, caste, SN, Big-5, etc.)
	
`rankingmigrant` name of the migrant.
`householdmigrantlist` name of all the migrant of the NEEMSIS HH.

### Identification of HH in label

Var hhhead ONE to 425, with, sometimes, `New household`
Format -> Name (if died, ...) (address), HHID
filter with ELACO ELAUR
It's the list of the 405 HH of RUME, with 20 `New household` 
Il y a moyen qu'on en ait pas besoin pour le questionnaire.

Var hhmemberlist 2 3
Format --> ${name}

Var householdidoriginal
Format -> HHID2010 1 to 80 with 80=new household

Var householdmigrantslist
List of household member that migrate
Format -> name one to 152 with 152=new member
Est ce que c'est la liste de tous les prénoms des mb du HH original list en drop les duplicates?
Ce sont tous les migrants d'un HH.

Who are the migrants?
Those who leave the household `dummylefthousehold` `To work permanently outside the village` + `Other`.

Who are KAR15 and KOR30?

Replace KAR15 Ind_7 par Ind_6
Replace KOR30 Ind_8 par Ind_6

J'ai déjà ajouté householdidoriginal
J'ai déjà ajouté householdmigrantlist

## Add questions

	[x] Add date of marriage
	[x] Add occupation as panel classification (Agri SE, Agri casual, Non-agri casual, Non-agri reg non-qualified, Non-agri reg qualified, Non-agri SE, NREGA) --> occuptype label
	[ ] Add text var for husband / wife name
	[ ] À voir avec Jalil, mais si jamais le migrant s'est marié après avoir migré, est-ce qu'on peut pas ajouter le module mariage en version allégée ?
	[ ] Est-ce qu'on ajoute les questions COVID?
    [ ] Ajouter pouvoir de décision de Mary?
    [ ] Ajouter les modalités de réponse pour groupe mariage l.62 des labels
    [ ] Locus of control?
	[ ] Marriage module
	[ ] Change posssibility of username

## Modify questions

	[x] Change datachoicelist for HHID, migrant name, HH members
	[ ] Mettre les others possibilities dans les groups ex: marriage

## Venkat translation
	
	1. New occupation typology of *Add questions* section.
	2. Caste spouse module (l.62 and at the end)
	
	
## Details of questions [to add?] in different modules

### Education

`canread` `newtraining` `reservation` `reservationgrade` `reservationkind` `reservationother` `decisiondropping`

### Occupation

`reservationemployment`


# Prise en main

Ok, qui est le migrant ? Est-ce qu'il y a des nouveaux membres ?

Ensuite un questionnaire HH pour les nouveaux membres avec dedans les modules à l'échelle du HH (house, land, etc). Se déclenche à condition qu'il y ait des nouveaux membres.

Questionnaire HH avec module à l'échelle du HH (house, land, etc). Se déclenche à condition qu'il n'y ait pas de nouveaux membres.

PB: Aucun des deux questionnaire ne s'est déclenché lorsque sharedmighh valait 0
Cependant, la condition semble être bonne:
relevance: nothing
Donc une fois l'abo SCTO pris, bien check que le module s'ouvre
Il y avait relevance chelou pour le begin group que j'ai supprimé, donc du coup maintenant ca doit etre bon

Questionnaire migrant pour le migrant principal
Changer la condition pour que ce soit "rankingmigrantname" ou un truc comme ça

Questionnaire individuel en suivant pour les anciens mb
ici on repose la miglist pour savoir qui on va interroger
Cependant, pourquoi est-ce qu'on ne fait pas juste un repeat
sur les householdmigrantlist
Car pb: pour des HH liste différente

Voir tout ca en détail avec Cécile pour voir si elle est d'accord avec la logique

Label locusscale en tamoul

Ajouter les actifs:
qu'est ce qui entre en compte dans le calcul des actifs ?
land + house + gold + goods + cattle