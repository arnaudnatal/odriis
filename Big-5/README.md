# Big-5 personality traits and factor analysis in NEEMSIS survey

> **Note :** J'ai calculé le biais sur tous les égos de 2016-17 (n=953) et tous les égos de 2020-21 (n=1316)
> Le taux de variation est sur les 835 égos en panel.

## Acquiescence bias

Le graphique ci-dessous nous montre très clairement que l'*acquiescence bias* est plus important pour NEEMSIS-2 que pour NEEMSIS-1.
Pour avoir un ordre de grandeur, aux alentours de 0.5, le biais est moyen (dans le sens où il n'est pas encore trop élevé), à 1, il commence à être élevé et au delà, il est très élevé.
> Le biais se mesure en faisant la moyenne des questions inversées.
> Les réponses allant de 1 à 5 (1-Almost always; 2-Quite often; 3-Sometimes; 4-Rarely; 5-Almost never), la moyenne obtenue pour un individu sans biais est de 3 (Sometimes) car il est censé répondre aux deux questions (dont une inversée) : 
> * Deux fois Sometimes;
> * ou une fois Almost always et une fois Almost never;
> * ou une fois Quite often et une fois Rarely.
> Un biais de 0.5 correspond à la combinaison d'1 modalité moins parfaite. 
> Par exemple Almost always et Rarely.
> Un biais de 1 correspond à une combinaison moins parfaite de 2 modalités.
> Par exemple Almost always et Sometimes.
> Un biais supérieur à 1 correspond à une combinaison moins parfaite de 3 ou 4 modalités.

[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/kernel_ars.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/kernel_ars.svg)

Sur le graphique suivant, il y a la distribution cumulée du biais en 2016-17 et en 2020-21.
L'idéal est d'avoir la courbe la plus plate possible.
En 2016-17, 50 % de la population a un biais inférieur à 0.3 alors qu'en 2020-21 50 % de la population a un biais inférieur à 0.5.
La valeur intéressante se trouve au troisième quartile :
* Q3 = 0.45 en 2016-17;
* Q3 = 0.75 en 2020-21.

[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/curve_ars.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/curve_ars.svg)

Pour rentrer un peu plus dans les détails, j'ai segmenté l'analyse par genre (male/female), caste (dalits/middle/upper) et age (30 ans ou moins en 2016-17/plus de 30 ans en 2016-17).
On voit encore que le biais est plus fort pour NEEMSIS-2.
En 2020-21, les femmes ont un biais plus élevé que les hommes.
La segmentation par caste est beaucoup moins marquée pour NEEMSIS-2.
Pour l'age il y a une vraie différence : le biais semble plus élevé pour les moins de 30 ans en 2016-17 donc 34 ans en 2020-21.

[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/kernel_ars_sub.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/kernel_ars_sub.svg)

Enfin, j'ai regardé la variation en segmentant directement l'analyse.
En termes relatifs, les femmes ont été plus nombreuses à être devenu biaisée comparée aux hommes, tout comme les middle-upper et les moins de 30.

[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/path_ars.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/path_ars.svg)


## Internal consistency of Big-5

Par rapport à la cohérence interne, j'utilise l'omega de McDonald's qui est meilleur que l'alpha de Cronbach (la [littérature](https://doi.org/10.7202/1067534ar) [s'entend](https://doi.org/10.3389/fpsyg.2016.00769) là-dessus.
Que j'utilise les *items* corrigés du bias ou non, la cohérence interne est plus faible pour 2020-21 que pour 2016-17.
Le premier graphique ici reprend la valeur des différents omega et le suivant représente les taux de variation.
C'est pour les *items* corrigés du biais que la variation entre NEEMSIS-1 et NEEMSIS-2 est la plus forte.
Corrigés ou non, les omega se dégradent toujours entre NEEMSIS-1 et NEEMSIS-2 (sauf pour AG et ES non corrigés).

Pour les différences entre corrigés et non corrigés, sauf pour ES, le fait de corriger le biais réduit la cohérence interne en 2020-21.
En 2016-17, la correction améliore les omega (sauf pour EX et OP).

[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/omega.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/omega.svg)

[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/omega_diff.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/omega_diff.svg)


## Stability over time

Concernant la stabilité dans le temps, j'ai trié les analyses entre *corrected items* et *non-corrected*.

Dans le premier tableau des *corrected items*, je regarde le taux de variation du score aux traits de personnalité.
Le dernier tableau (en bas à droite) représente le cumul du taux de variation absolu.
Plus la courbe est applati, plus le trait est stable entre 2016-17 et 2020-21.
Les autres tableaux représente, sous une autre forme, la variation segmenté par age, genre et caste.

Entre *corrected* et *non-corrected* on voit que les traits non-corrigés sont beaucoup plus stable entre 2016-17 et 2020-21.

### Raw items (non-corrected from acquiescence bias)

[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diffcont_raw.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diffcont_raw.svg)

#### Segmentation by age
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_age_raw.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_age_raw.svg)

#### Segmentation by caste
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_caste_raw.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_caste_raw.svg)

#### Segmentation by gender
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_gender_raw.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_gender_raw.svg)

### Corrected items from acquiescence bias

[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diffcont_cor.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diffcont_cor.svg)

#### Segmentation by age
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_age_cor.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_age_cor.svg)

#### Segmentation by caste
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_caste_cor.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_caste_cor.svg)

#### Segmentation by gender
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_gender_cor.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_gender_cor.svg)


### Cognitive skills

[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diffcont_cog.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diffcont_cog.svg)

#### Segmentation by age
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_cog_age.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_cog_age.svg)

#### Segmentation by caste
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_cog_caste.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_cog_caste.svg)

#### Segmentation by gender
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_cog_gender.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/diff_cog_gender.svg)





## Factor analysis

### NEEMSIS-1 (2016-17) data

#### 6 factors with raw items
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2016_Raw_with.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2016_Raw_with.svg)

#### 6 factors with corrected items
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2016_Corr_with.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2016_Corr_with.svg)

#### 5 factors with raw items
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2016_Raw.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2016_Raw.svg)

#### 5 factors with corrected items
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2016_Corr.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2016_Corr.svg)


### NEEMSIS-2 (2020-21) data

#### 6 factors with raw items
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2020_Raw_with.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2020_Raw_with.svg)

#### 6 factors with corrected items
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2020_Corr_with.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2020_Corr_with.svg)

#### 5 factors with raw items
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2020_Raw.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2020_Raw.svg)

#### 5 factors with corrected items
[![](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2020_Corr.svg "")](https://raw.githubusercontent.com/4rnaud/RUME-NEEMSIS/main/Big-5/factor2020_Corr.svg)