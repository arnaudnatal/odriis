# Individual panel

Les fichiers "panel_" permettent donc de suivre les individus en panel selon leur code HHID_panel.
	- panel_indiv_wide pour avoir une ligne par individu
	- panel_indiv_long pour avoir une ligne par individu par année
Il y a la version 2010-2016 puis, partant de là et avec le .do, la version avec 2020.

L'ID est en string "Ind_x" pour x allant de 1 à n.
Cette version de l'ID est bien meilleur que la version précédente (que j'ai supprimé) dans la mesure où il est ordonné :
	- Commence par respecter l'ordre de 2010;
	- Puis 2016;
	- Puis 2020.

Donc tous les individus ont un code, qu'ils soient en panel ou non : j'ai listé tous les membres du ménage, quelle que soit la date, je les ai triés selon les critères précédents puis j'ai attribué un numéro.

Je ne pense pas que ce soit encore totalement parfait, donc je compte sur vous pour repasser derrière et vérifier que ça colle à chaque fois (avec la base wide).
Je dis ça dans le sens où j'ai peut-être fait des erreurs d'attribution du prénom.
Je m'en excuse par avance.

Arnaud 