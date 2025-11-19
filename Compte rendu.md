# Travaux pratiques CEM : utilisation de la méthode DF pour la simulation CEM

## Contexte global
### Objectifs :  
- Calcul du potentiel électrique par la méthode des différences finies (potentiel scalaire)
- Calcul des grandeurs dérivées (champ électrique et capacité) illustratives sur un cas CEM
### Compétences visées :  
- Connaitre les éléments constitutifs d’un modèle électromagnétique : domaine de calcul, source, conditions initiales, conditions aux limites, convergence
- Utilisation d’un outil de simulation & développement numérique (sous environnement Matlab / Octave)
- Post-traitement des données & sensibilisation aux grandeurs CEM (capacité)
### Contrôle des connaissances :  
- Rendu d’un compte-rendu des travaux suite à la séance présentielle

## A. Introduction   
L'équation de Laplace sert à modéliser divers phénomènes physiques comme le potentiel gravitationnel, les champs électriques, la diffusion de la chaleur et les ondes sonores, en utilisant des conditions aux limites pour résoudre des problèmes en physique et en ingénierie.  

Dans le cas de la CEM, il est alors parfois nécessaire de résoudre cette équation appliquée au potentiel V dans le vide.  
On obtient alors l'équation :  

$$
\Delta V = 0
$$
  
Pour se faire, nous pouvons alors utiliser la méthode des différences finies (DF) afin de résoudre numériquement et en 2D l'équation de Laplace.  
La méthode des DF permet de trouver une solution à une équation aux dérivées partielles (EDP) en approximant le calcul d'une dérivée en un point par sa tangente.  
Dans le cas particulier de la résolution de l'équation de Laplace dans le vide on obtient (extrait du cours) : 
<img width="480" height="361" alt="image" src="https://github.com/user-attachments/assets/e4ecd982-828f-4e1f-9b46-952cece513e9" />  
Qui dans le cas particulier où dx=dy=1 devient : 

$$
V_{i,j} = 1/4*(V_{i+1,j}+V_{i-1,j}+V_{i,j+1}+V_{i,j-1})
$$  

## B. Durant la séance  
### Q1) Modélisation du problème  
Dans un premier temps, nous commençons par modéliser le problème en 2D à l'aide des conditions initiales.  
Nous modélisons deux conducteurs l'un à côté de l'autre, avec les conditions suivantes :  
- le conducteur rouge a un potentiel initial de V=+100V
- le conducteur bleu a un potentiel initial de V=-100V
- le reste est à V=0V
- l'espace considéré est de Nx=Ny=40 (nombre de cellules)

On obtient alors le résultat suivant :  

<img width="633" height="483" alt="image" src="https://github.com/user-attachments/assets/59b18a3a-9f40-4317-903f-9ffebdaf0f9d" />  

### Q2) Itération du calcul par DF pour k = 20, 50 et 200
Après avoir modélisé le problème, nous nous proposons maintenant d'exécuter itérativement 200 fois le calcul, par méthode des différences finies, du potentiel sur notre problème.  
Nous obtenons alors : 
<p align="left">
  <img width="609" height="482" alt="image" src="https://github.com/user-attachments/assets/cea66ccf-9345-4755-b84c-d15398b03221" />
  <br>
  <em>Résultat pour k = 20 itérations</em>
</p>
<p align="left">
  <img width="607" height="489" alt="image" src="https://github.com/user-attachments/assets/352a1942-7577-4e5a-ba81-fdd11062910f" />
  <br>
  <em>Résultat pour k = 50 itérations</em>
</p>
<p align="left">
  <img width="637" height="484" alt="image" src="https://github.com/user-attachments/assets/11e26412-947e-4ffd-9312-56e687597c36" />  
  <br>
  <em>Résultat pour k = 200 itérations</em>
</p>  

Nous obtenons un résultat convenable cependant, il vient assez naturellement la question : _combien d'itérations doit-on faire avant d'obtenir un résultat convenable ?_  
De fait, selon que l'on réalise 20, 50 ou 200 itérations, nous obtenons des résultats très différents.  
=> Il faut donc définir un seuil d'itération à partir duquel le résultat obtenu sera satisfaisant. 

### Q3&4) Définition de la notion de convergence, ainsi que d'un seuil et étude de l’influence de la taille du domaine de calcul
Afin de s'assurer que le résultat obtenu converge bien vers le résultat souhaité, nous allons définir un seuil et comparer l'écart de potentiel entre deux valeurs successives pour un même point donné. Puis nous allons, à chaque itération, comparer la valeur maximum de cet écart sur tous les points du plan au seuil fixé.  

Nous obtenons alors les résultats suivants :  
- seuil = 1e-2 & Nx=40 Ny=40 : nb iteration = 284
- seuil = 1e-3 & Nx=40 Ny=40 : nb iteration = 491
- seuil = 1e-4 & Nx=40 Ny=40 : nb iteration = 699
- seuil = 1e-2 & Nx=100 Ny=100 : nb iteration = 1276
- seuil = 1e-3 & Nx=100 Ny=100 : nb iteration = 4670
- seuil = 1e-4 & Nx=100 Ny=100 : nb iteration = 8555
  
De manière assez logique, nous observons donc que plus nous diminuons le seuil, ou plus nous augmentons la taille de l'espace de calcul, plus le nombre d'itérations nécessaires avant de converger vers le résultat souhaité augmente.

### Q5&6) Affichage des lignes équipotentielles et calcul du champ électrostatique  
A l'aide des fonctions matlab _contour_ et _quiver_, nous traçons respectivement les lignes d'équipotentielles et le champ électrique de notre modèle.  
ATTENTION : il faut prendre -Ex et -Ey pour la fonction quiver puisque E = -grad(V) et que la fonction quiver ne tient pas compte du signe - dans sa représentation !  
Nous obtenons alors les résultats suivants :  
<p align="left">
  <img width="510" height="487" alt="image" src="https://github.com/user-attachments/assets/28dded32-df28-454f-812f-df6c512bd06c" />
  <br>
  <em>Représentation des lignes d'équipotentielles et du champ électrique de notre modèle</em>
</p>  
<p align="left">
  <img width="512" height="482" alt="image" src="https://github.com/user-attachments/assets/0c74c19c-68ba-4176-b17c-9a1200610d92" />
  <br>
  <em>Représentation des lignes d'équipotentielles et du champ électrique d'un modèle de condensateurs</em>
</p>  

### Q7) Calculs de capacités  
Afin de calculer la valeur de la capacité modélisant l'isolation entre le conducteur 1 et le conducteur 2, nous utilisons les relations suivantes :

$$ 
\mathrm{div}\ \vec{E} = \frac{\rho}{\varepsilon_0} (1)
$$

$$ 
\iint \vec{E} \cdot d\vec{S} = \frac{Q}{\varepsilon_0} (2)
$$

$$ 
𝑄_i = 𝐶_ij(𝑉_𝑗 − 𝑉_𝑖) (3)
$$  

En 2D, pour calculer l'expression (2), il suffit de sommer les Ex et Ey en multipliant par 1 ou -1 selon le sens par rapport à l'axe.  
Suite à cela, nous pouvons déduire la valeur de Q en multipliant l'expression obtenue précédemment par ε₀.  
Enfin, il suffit de diviser le résultat obtenu par (Vj-Vi), dans notre cas : 200.  

De cette manière, nous obtenons alors une capacité C = 8.54e-12 F. Ce qui semble correcte au vu du contexte.  

## C. Compte-rendu  
### Questions finales  
Après calcul à la main, en considérant dx et dy quelconques, on obtient l'expression finale : 

$$
V_{i,j} = \dfrac{1}{2} * (V_{i+1,j}+V_{i-1,j}+V_{i,j+1}+V_{i,j-1}) * \dfrac{dy^2*dx^2}{dy^2+dx^2}
$$  

Il suffit alors de remplacer l'expression de Vi,j par celle fournie ci-dessus et de diviser par dx et dy lors du calcul de E.dS.  

Malgré les avantages que présentent la méthode des différences finies, il y a cependant des limites à cette méthode :  
- Tout d'abord, comme observé Q3 et Q4, si l'on augmente la dimension de l'espace de calcul ou que l'on diminue le seuil de comparaison, il va falloir un plus grand nombre d'itération. Par conséquent, les ressources mobilisées pour le calcul des Vi,j vont être de plus en plus importantes.
- Ensuite, du fait de l'approximation par une tangente faite lors du calcul d'une dérivée, nous introduisons à chaque calcul une erreur non-négligeable in fine.
- En cas de discontinuité, cela peut engendrer des erreurs de calculs numériques et les diffuser pour les calculs alentours du fait de l'expression même de Vi,j.
- Aussi, les géométries difficiles à modéliser représentent une des limites du modèle.
- Les conditions aux limites doivent être réelles et finies sinon le calcul se complexie voire devient impossible. 
- Enfin, la principale limite de la méthode des différences finies est la dimension dans laquelle elle reste applicable. De fait, dès que l'on passe dans un espace à plus de 2 dimensions, le calcul par DF devient très long en terme de temps et très gourmand en terme de ressources.

Nous appliquons maintenant tout ce qui a été vu durant ce TP au cas d'un câble coaxial.  
Tout d'abord, nous commençons par modéliser ce nouveau système. Nous définissons cet fois un espace de travail tel quel Nx=Ny=201 mailles, avec dx=dy=1, ainsi que v1=-1V (potentiel du conducteur extérieur), v2=1V (potentiel de l'âme du câble coaxial) et v0=0V (potentiel du milieu de propagation).  
Une fois le problème modélisé, il ne nous reste plus qu'à appliquer la méthode des DF dans notre cas, qui est celui d'un câble coaxial.  
Enfin, pour le calcul de la capacité équivalente du câble coaxial, il nous faut modifier la surface considérée.  
Suite à ces modifications, nous obtenons alors les résultats suivants :  

<p align="left">
  <img width="1122" height="819" alt="unnamed" src="https://github.com/user-attachments/assets/ab07979f-1371-4317-af3b-e9e11d5886b5" />
  <br>
  <em>Modélisation du cas d'un câble coaxial avec une tension d'âme de 1V, une tension dans le milieu de propagation de 0V et une tension de -1V pour le conducteur extérieur</em>
</p>  <p align="left">
  <img width="1030" height="813" alt="unnamed-1" src="https://github.com/user-attachments/assets/c4e71c7f-cb16-4801-9f1b-d3d52c4ae17a" />
  <br>
  <em>Application de la méthode des DF au cas d'un câble coaxial</em>
</p>  <p align="left">
  <img width="895" height="805" alt="unnamed" src="https://github.com/user-attachments/assets/66500caf-9b84-4695-b473-ca9742b0cf44" />
  <br>
  <em>Représentation des lignes d'équipotentielles et du champ électrique d'un modèle de câble coaxial</em>
</p>  
  
Après exécution du script nous obtenons, en choisissant eps = 1e-3 et itmax = 10000, un nombre de 360 itérations. Cela semble plutôt cohérent au vu de notre modèle et du seuil eps fixé.   
De plus, en procédant de manière identique à ce qui a été fait lors de la Q7, nous obtenons une capacité équivalente de câble coaxial : Cnumérique = 4.11e-13 F.  
En considérant l'expression donnée dans le sujet, nous obtenons : Cthéorique = 5.50e-11 F.  
Nous observons donc un léger écart entre la valeur obtenue numériquement et celle obtenue théoriquement. Cet écart s'explique de par les causes exposées précédemment.
