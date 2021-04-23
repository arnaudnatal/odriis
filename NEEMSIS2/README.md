Les 9 fichiers do permettent un nettoyage relativement complet de NEEMSIS2.

Les deux premiers ("NEEMSIS2-1_Longfiles.do" & "NEEMSIS2-1_Longfiles_blankHH.do") permettent de créer un identifiant unique par ligne de chaque fichier long du questionnaire household : dans chaque fichier long, il y a une variable "setof[...]" et une variable "key". La variable "key" est unique, tandis que "setof[...]" est identique à "key" sans l'identifiant unique. Dans la base ménage, il y a qu'une variable "key" mais plusieurs "setof[...]" (une par fichier long). Lors d'un merge, Stata ne pourra pas associé les deux "setof[...]" car ils ne sont pas unique par ligne. Dans ce premier .do, je commence à inverser "key" avec "setof[...]" dans les différents longs. 
  - NEEMSIS2-1_Longfiles.do est pour les données avec preload.
  - NEEMSIS2-1_Longfiles_blankHH.do est pour les données sans preload.

Les deux .do suivants ("NEEMSIS2-2_Master.do" & "NEEMSIS2-2_Master_blankHH.do") permettent de créer l'identifiant unique dans la base ménage. Comme je l'ai dit juste avant, dans la base ménage il y a tout un tas de variable "setof[...]". Le problème est quelles sont génériques au ménage. Dans ces deux .do (comme précédemment d'ailleurs : blankHH pour les donées sans preload et l'autre pour avec preload) je vais donc :
  - Préparer le reshape en créant les code INDID et en identifiant les égos (un peu fastidieux). Il y en aura plusieurs car selon les fichiers long, Survey CTO pioche dans différentes listes :
    - INDID
    - INDID_total
    - INDID_left
    - INDID_new
    - INDID_former
  - Procéder au reshape
  - Rendre les différents "setof[...]" uniques pour pouvoir merger facilement.
  - Puis merger les fichiers long au niveau des individus afin de compléter la base (lefthome, individualid, familymembers, education, employment, migration, remittances, loans, lending, recommendation, chitfund, saving, gold, insurance, scheme). Je ne merge pas les listes intérieures (par exemple la liste des prêts), juste les listes à l'échelle des individus.

Le .do suivant ("NEEMSIS2-3_Append.do") permet de regrouper les différentes version du questionnaire, de labéliser les variables et de merger certaines listes que nous trouvons dans la base ménage de 2016 comme les chitfunds, l'épargne et les insurances. Concrétement, j'ai pris les bases de details avec la liste des comptes épargnes, des chitfunds et des assurances, reshape pour avoir une ligne par individu et merge avec la base ménage. Dans la mesure où il y a relativement peu de questions par chitfund/saving/insurance et qu'il y a peu de compte par individus, ça n'ajoute pas énormément de variables. 
Les prêts ne sont pas ici car il y a beaucoup de questions par prêt et beaucoup de prêt par individu. Un reshape+merge ajouterait énormément de variable pour rien car il est beaucoup plus pratiques de les avoir en ligne (et non en colonne si nous faisions un reshape+merge).
