# Les enquêtes ODRIIS

## RUME

Le volet quantitatif d'ODRIIS est principalement composé des données RUME-NEEMSIS.
L'enquête RUME s'est déroulée en 2010 sur un échantillon de 405 ménages.
Axé sur ..., l'enquête, à l'échelle des ménages...

## NEEMSIS-1

En 2016-17, l'enquête NEEMSIS a retrouvé 388 ménages (95.8 %) et en a ajouté 104 nouveaux.
Enquête plus complète, NEEMSIS s'intérèsse à ...

## NEEMSIS-2

En 2020-21, une deuxième vague NEEMSIS a été effectuée.
La vague 2016-17 porte désormais le nom de NEEMSIS-1 et celle de 2020-21, NEEMSIS-2.
Parmi les 492 ménages NEEMSIS-1, 485 ont été retrouvé (98.6 %) et 147 nouveaux ménages ont été ajouté pour un total de 632 ménages.
Parmi les 485 ménages en panel 2016-17 - 2020-21, 382 sont en panel avec 2010.

# Organisation du panel

Pour travailler avec les données de panel, un `merge` est nécessaire à partir des variables `HHID_panel` et `INDID_panel`.

## Identifiant unique ménage : `HHID_panel`

La variable `HHID_panel` est l'identifiant unique panel des ménages.
Il est composé des 3 premieres lettres du nom du village, ainsi que d'un numéro.
Le numéro a été attribué de façon arbitraire (en partant de 1) à partir des données RUME et NEEMSIS-1.
Pour les nouveaux ménages de 2020-21, il a suffit de continuer l'attribution à partir de la dernière valeur données et ajouter 1.

> Avec l'ensemble des ménages RUME et NEEMSIS-1 (405+104=509 ménages), si dans le villages de Manapakkam (MAN), la dernière attribution est "MAN47", alors pour les nouveaux ménages de 2020-21, nous continuerons l'attribution à "MAN48", puis "MAN49", etc.
> Ainsi, si à l'heure actuelle `HHID_panel` va de "MAN1" à "MAN63" dans le village de Manapakkam, alors nous pouvons dire que, depuis le début de l'enquête RUME-NEEMSIS, 63 ménages ont été enquêté dans le village de Manapakkam.

Lors des futures collectes, si un ménage est en panel, il suffira de reprendre son identifiant panel unique.
Si un ménage est nouveau, il faudra continuer la numérotation à partir de la valeur maximale et ajouter 1.


## Identifiant unique individu : `INDID_panel`

La variable `INDID_panel` est l'identifiant unique panel des individus.
Il n'a de sens qu'avec la variable `HHID_panel`.
Il est composé du prefixe "Ind_", puis d'un numéro.
Comme pour `HHID_panel`, le numéro a été attribué de façon arbitraire (en partant de 1) à partir des données RUME.
Pour NEEMSIS-1, lorsqu'un individu était présent en 2010, il a suffit de reprendre son numéro.
Si l'individu est "nouveau", alors il a fallu continuer la numérotation.
De même pour 2020-21.

> Dans le ménage "MAN25", en 2010, Panchavarnam est le quatrième membre du ménage "Ind_4".
> En 2016-17, cet individu est toujours là, donc garde son numéro.
> De même en 2020-21.
> En revanche, en 2020-21, deux nouveaux membres font leur apparition "Janani" et "Moulish".
> Ils prendront donc respectivement les numéros "Ind_5" et "Ind_6".

Lors des futures collectes, si un individu est en panel, il suffira de reprendre son identifiant panel unique.
Si il est nouveau, il faudra continuer la numérotation à partir de la valeur maximale et ajouter 1.

# Les clés

## Ménage

`ODRIIS_HH.dta` (ou `ODRIIS_HH.xlsx`) permet de faire correspondre les idenfiants spécifiques à chaque vague (`HHID2010` et `parent_key` par exemple).


## Individu

`ODRIIS_indiv.dta` (ou `ODRIIS_indiv.xslx`) qui permet de faire le panel individu.
Permet de faire correspondre les identifiants spécifiques à chaque vague (`INDID2010` et `INDID2016` par exemple).
Afin d'assurer le bon suivi des individus, des variables supplémentaires sont présentes pour les trois vagues comme le sexe, l'age, la caste, le prénom, la relation au chef de ménage, le village, la présence ou non dans le ménage.


# Sexe et relation au chef du ménage

## Intra-vague

Afin d'assurer une cohérence intra-vague, des corrections ont été effectuées.
Avec NEEMSIS (1 et 2), pour certains individus, le sexe declaré n'était pas en accord avec la relation au chef de ménage.
Par exemple, 95% des cas étaient du type: male-daughter ou female-son.
Des corrections ont donc été effectuées afin que cela soit cohérent.

Pour les ménages en panel, le premier choix a été de regarder avec ce qu'ils avaient déclaré les années précédentes.
Cela a permis de corriger tous les individus concerné.
Il fallait principalement changer la relation au chef de ménage pour son équivalent de l'autre sexe.

Pour les nouveaux ménages, il y avait beaucoup moins d'incohérence.
Sur la base du prénom et de la composition du ménage, le sexe ou la relation ont pu être corrigé.

> En 2016-17, entre 10 et 20 individus ont été corrigés (sur 2696).
> En 2020-21, entre 40 et 50 individus ont été corrigés (sur plus de 3000).

## Cohérence panel

Des incohérence ont été constatées en panel pour la relation au chef de ménage.
Il s'agit de femmes qui deviennent des cousines..
Ce ne sont des incohérences que d'un point de vue d'un chercheur occidental.
Un individu peut avoir "plusieurs" relations : être à la fois belle-soeur et cousine.
De plus, la question du chef de ménage est assez difficile à capter.
Un père defunt peut rester le chef, est donc les relations sont difficiles à capter.
Enfin, la relation reste subjective dans ce contexte.

Ainsi, aucune correction n'a été effectuée ici.


# Age en panel

Des incohérences pour l'age ont été constatée avec le panel.
Comme la relation au chef, cette incohérence n'a de sens qu'en panel.
En coupe transversale, nous n'observons pas d'incohérence.

Afin de ne pas directement modifier les données, une nouvelle variable "age*year*panel" a été créée.
Elle n'est pas 100 % arbitraire dans la mesure où une évolution de l'age entre +3 et +9 entre 2010 et 2016-17 est considéré comme juste.
La variable corrige uniquement les cas où l'age a augmenté de moins de 3 ans et où l'age a augmenté de plus de 9 ans.

Nous trouvons donc les variables "age2010panel", "age2016panel" et "age2020panel" dans la base `ODRIIS_indiv.dta` qui permettent d'avoir des ages corrigés lorsque nous travaillons en panel.


# Caste (jatis plutôt)

En vérifiant la cohérence panel, j'ai trouvé des changements de castes (ou jatis plutôt) entre 2010 et 2016-17.
Rien pour 2016-17 - 2020-21.
En regardant une base panel de Sébastien et Youna, le jatis retenu était celui de 2016-17.

| `HHID_panel` | `HHID2010` | Jatis 2010 | Jatis 2016-17 |
|--------------|------------|------------|---------------|
| MANAM28      | SIMTP297   | Gramani    | SC            |
| SEM48        | SISEM106   | Settu      | Chettiyar     |
| SEM10        | SISEM107   | Settu      | Chettiyar     |
| ORA38        | VENOR397   | Vanniyar   | Padayachi     |
| ELA5         | PSEP78     | Vanniyar   | Padayachi     |
| MAN18        | ANTMP241   | Settu      | Vanniyar      |