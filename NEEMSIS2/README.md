# NEEMSIS 2 : création et nettoyages
Les différents `.do` permettent d'utiliser les données [NEEMSIS](https://neemsis.hypotheses.org/) 2.
Il y a deux types de `.do` :
 - Ceux qui permettent la création et l'exploitation des données et;
 - Ceux qui permettent un nettoyage des données.

La première partie de ce descriptif permet de comprendre les premiers `.do` (création des données) et la seconde partie permet d'entrer en détail dans le nettoyage.

## Création des données NEEMSIS 2

### Sortie de Survey CTO
Lorsque nous compilons les `.do` de Survey CTO, il en ressort une centaine de `.dta`. 
L'un des `.dta` est la base maître (je l'appelle *master*) qui contient le questionnaire ménage.
Les autres fichiers (*long*) sont les différentes boucles du questionnaire. 
Dans le fichier *master*, nous trouvons un identifiant unique **key**, ainsi qu'une centaine de variables commençant par **setof** et finissant par le nom d'une boucle.
Dans les fichiers *long* nous trouvons une seule variable **setof** (sauf quand la boucle en ouvre une autre, alors nous aurons autant de **setof** que de boucle), une variable **key** unique par ligne ainsi que **parent_key** qui est égale à **key** de la base *master*.

***
<ins>Exemple :</ins>
 - *Master* :
   - **key** contient `<uuid:a5864c62-bf01-4313-a7b4-47985821c1e4>`
   - **setoffamilymembers** contient `<uuid:a5864c62-bf01-4313-a7b4-47985821c1e4/householdquestionnaireold-hhquestionnaire-familymembers>`
 - *Long* familymembers :
   - **parent_key** contient `<uuid:a5864c62-bf01-4313-a7b4-47985821c1e4>`
   - **setoffamilymembers** contient `<uuid:a5864c62-bf01-4313-a7b4-47985821c1e4/householdquestionnaireold-hhquestionnaire-familymembers>`
   - **key** contient `<uuid:a5864c62-bf01-4313-a7b4-47985821c1e4/householdquestionnaireold-hhquestionnaire-familymembers[1]>`
***

L'objectif est de faire matcher les variables entre la base *master* et les bases *long* pour pouvoir merger les bases de données.
Le matching se faisant à partir d'une information unique pour les individus, nous devons utiliser le contenu de la variable **key** car il contient ET la clé ménage individuelle (**key** du *master* ou **parent_key** des *long*) ET la clé individuelle (entre crochets).

Pour cela, nous allons procéder ainsi :
 1. Dans les bases *long* nous inversons les variables **setof** et **key**.
 2. Dans la base *master* nous renommons **key** en **parent_key** puis nous ajoutons à la fin de la variable **setof** le code individuel.
Ainsi, nous pourrons merger les bases *long* avec la base *master*.

Le bricolage des fichiers *long* peut directement se faire, pas celui de la base *master*.
En effet, la base sortie de Survey CTO est à l'échelle du ménage, il faut donc la reshaper avant d'attribuer les codes individuels et de faire les merging.

### Longfiles`.do`
Nous retrouvons deux fichiers `.do` : l'un pour les versions du questionnaire avec preload et l'autre pour les versions sans (le `.do` terminant alors par "\_blankHH").
Il s'agit d'une grosse boucle qui inverse **setof** et **key**.


### Master`.do`
La première chose à faire est de reshaper la base afin d'avoir en ligne les individus et non les ménages (à la sortie de Survey CTO, la base ménage est en wide individus).
Pour que le reshape fonctionne, il faut que la base soit en vrai wide : toutes les variables aient le même nom en wide.
Ce n'est pas le cas, notamment à cause des variables égos qui sont nommées `_2varname` pour égo 2, `_3varname` pour égo 3 puis `varname`pour égo 1.
Il faut donc retrouver la\les position\s des égos afin de recréer les variables.
J'emploie le pluriel car il y a différentes positions selon les boucles que Survey CTO utilise.

La première partie de ce\s (comme pour les *long* il y en a deux selon que nous soyons dans une version avec ou sans preload) `.do` permettent donc de recréer les variables des égos en wide et de créer les différents identifiants individuels.
Pour être précis, il y en a cinq :
 1. `INDID` qui tient compte de tout le monde : présents, absents, nouveaux, etc. C'est l'identifiant "panel" dans la mesure où les anciens membres ont la même valeur qu'en 2016
 et les nouveaux membres débutent à "16".
 2. `INDID_total` qui ne tient compte que des membres présents en 2020. 
 3. `INDID_former` qui liste uniquement les membres présents ET qui étaient là en 2016.
 4. `INDID_new` qui liste les nouveaux membres de 2020.
 5. `INDID_left` qui liste les membres présents en 2016 et qui ont quitté le ménage.

Schématiquement : 
 - `INDID_former` et `INDID_new` constituent `INDID_total`.
 - `INDID_total` et `INDID_left` constituent `INDID`.

`INDID` est donc le seul identifiant commun à tous.

Une fois que nous avons toutes nos positions individuelles et les variables égos en vrai wide, nous procédons au reshaping.

Nous obtenons ainsi une ligne par individu où pour chaque individu nous avons ses différentes valeurs aux codes individuelles.

Ces différents codes individuels vont nous permettre de reconstituer les variables **setof** comme dans les bases *long*.
En partant du questionnaire form de Cécile, j'ajoute à la fin des variables **setof** le code individuel correspondant à la bonne liste de choix de la boucle :
Si la boucle ne s'ouvre que pour les nouveaux membres je complète **setof** avec `INDID_new`, si elle ne s'ouvre que pour les membres partis alors je complète avec `INDID_left`, etc.

Nous obtenons ainsi entre les *long* et la base *master*, les variables **setof** uniques.

Nous pouvons donc merger les bases *long* à l'échelle individuelle avec la base ménage reshape. 
Plus précisément :
 - lefthome;
 - individualid;
 - familymembers;
 - education;
 - employment;
 - migration;
 - remittances;
 - loans;
 - lending;
 - recommendation;
 - chitfund;
 - saving;
 - gold;
 - insurance;
 - scheme. 

Je ne merge pas les listes qui sont dans les boucles *long*.
Loans ici correspond aux individus du ménage qui empruntent de l'argent, dans cette boucle qui s'applique aux individus du ménage, s'ouvre une autre boucle pour lister tous les prêts.
Cette nouvelle liste (de prêts) n'est pas merge ici, seulement la liste à l'échelle individuelle.

### Append
Nous pouvons maintenant regrouper les différentes versions du questionnaire pour avoir une seule base ménage.
C'est ici que s'appliquent les labels.
J'en profite aussi pour reshaper sous listes présentes en 2016.
Dans les données 2016, les variables relatives aux chitfunds, aux assurances et à l'épargne sont reshaper pour être à l'échelle individuelle (alors qu'un individu peut avoir plusieurs comptes épargne) et sont donc en wide dans la base ménage.
Dans la mesure où il y a peu de questions et un faible nombre par individu, ça n'est pas dérangeant de les merger dans la base ménage comme 2016 ici.
Je ne le fais pas pour les occupations et les prêts dans la mesure où il y a beaucoup de questions pour une seule occupation ou un seul prêt et beaucoup d'occupations ou prêts par individus (en wide cela rajouterait énormément de variables).

### Marriage (someone else issue)
Étant donné la structure du questionnaire, ce `.do` permet d'identifier les "Someone else" du module mariage pour changer le code individuel du *long* associé.
Je le merge avec la base ménage une fois le bon code individuel retrouvé (et non garder le "31").

### Agriculture
Création complète de la base agriculture avec merging des sous modules associés (après reshape pour qu'ils soient wide).
Merging avec la base ménage.


## Nettoyage des données

### Gender, caste

### Education
Création d'une variable education level ("edulevel") à partir des codes fournis par Anne pour le module cognition : Below primary (no education); Primary completed; High school (8th-10th); HSC/Diploma (11th-12th); Bachelors (13th-15th); Post graduate (15th and more).

### Main occupation
Création des variables de main occupation for individuals (en tenant compte de dummymainoccupation2 et othermainoccupation2 for egos) and households et de totalincome (total annual income) for individuals and households. Je merge avec la base ménage.

### Cognition
Création des variables de cognition (Big Five; literacy; numeracy; raven) et imputation des missings de personnalité pour ne pas perdre d'individus lors des analyses factorielles. Idem, c'est de la préparation de base pour analyses, donc je laisse les codes ici, mais on peut enlever de la base ménage classique.

### Assets
Nettoyage des assets et création de la variable au passage (qui sera amené à changer lorsque j'aurai les valeurs manquantes que Venkat doit fournir à Isabelle). Nettoyage car je rends les variables identiques à 2016 (en remplaçant les codes des assets par leurs noms: livestock_1 to livestock_cow, etc.). J'ai aussi jeté un coup d'oeil aux "others" assets et j'ai modifié les questions de bases lorsqu'un "other" pouvait entrer dans une catégorie proposée (ce qui doit arriver quand les enquêteurs ont un doute je suppose). J'ai aussi créé un assets "TV" car dans other c'est très souvent ce qui revient. Peut-être qu'il ne faut pas le faire, dans le doute je l'ai fait, quitte à l'enlever.
