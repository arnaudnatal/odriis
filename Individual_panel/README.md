# Individual panel

Comme Cécile a fait un identifiant unique panel pour les ménages, je me suis dit qu'il était nécessaire de faire de même avec les individus.
Je pense que pour 2010-2016 le travail avait déjà été fait, mais comme je l'ai déjà dit, avec toutes les versions sur la Dropbox, je me suis perdu, donc j'ai préféré tout reprendre.

Les fichiers permettent donc de suivre les individus en panel selon leur code HHID_panel.
	- panel_indiv_wide pour avoir une ligne par individu
	- panel_indiv_long pour avoir une ligne par individu par année
La chose la plus importante concerne donc le panel 2010-2016 pour qui les codes INDID étaient très différents.
Puis le panel avec les données non preload de 2020 car, comme Cécile m'a expliqué, ce sont des ménages qui existaient en 2016, mais pour lesquelles nous n'avions pas toutes les informations (c'est bien ça ?).

Ça a été un peu fastidieux à faire, je compte sur vous pour passer derrière moi et vérifier que les prénoms sont cohérents.

Pour l'ID, il est en string "In1" à "In16". 
L'ordre n'est pas parfait, mais fait le travail, je pense.
Le plus important étant une grille de conversion INDID2010, INDID2016, INDID2020.

Si jamais vous voyez une erreur, dites-la-moi, je modifierai.

Arnaud 