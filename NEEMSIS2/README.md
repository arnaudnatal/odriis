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

"NEEMSIS2-4_Marriage.do" permet d'identifier les "Someone else" des mariages et de changer l'id associé pour merger la base long des mariages.

Ensuite, "NEEMSIS2-5_Agriculture.do" merge les sous modules long de la base agriculture avec la base agriculture maître, regroupe les différentes version, labelise et merge avec la base ménage.
Finalement, elle fait comme les trois premiers .do ("NEEMSIS2-1_Longfiles", "NEEMISIS2-2_Master" & "NEEMSIS2-3_Append").

"NEEMSIS2-6_Cleaning.do" est un .do dans le nettoyage. Il ne s'agit pas de rendre les données utilisable ici, mais d'ajouter des variables pour plus de clarté et de facilité.
  - Création des variables de main occupation for individuals (en tenant compte de dummymainoccupation2 et othermainoccupation2 for egos) and households et de totalincome (total annual income) for individuals and households. Je merge avec la base ménage.
  - Merge une base "preload 2016" (que j'ai déjà fait) avec toutes les caractéristiques personnelles (notamment le genre qui n'apparait pas dans la base preload 2016 de Survey CTO).
  - Cleaning des caractéristiques personnelles :  
    - différenciation caste - jatis; 
    - variable name, sex, age unique;
    - création d'une variable education level ("edulevel") à partir des codes fournis par Anne pour le module cognition : Below primary (no education); Primary completed; High school (8th-10th); HSC/Diploma (11th-12th); Bachelors (13th-15th); Post graduate (15th and more).
  - Nettoyage des assets et création de la variable au passage (qui sera amené à changer lorsque j'aurai les valeurs manquantes que Venkat doit fournir à Isabelle). Nettoyage car je rends les variables identiques à 2016 (en remplacant les codes des assets par leurs noms: livestock_1 to livestock_cow, etc.). J'ai aussi jeté un coup d'oeil aux "others" assets et j'ai modifié les questions de bases lorsqu'un "other" pouvait entrer dans une catégorie proposée (ce qui doit arriver quand les enquêteurs ont un doute je suppose). J'ai aussi créer un assets "TV" car dans other c'est très souvent ce qui revient. Peut-être qu'il ne faut pas le faire, dans le doute je l'ai fait, quite à l'enlever.
