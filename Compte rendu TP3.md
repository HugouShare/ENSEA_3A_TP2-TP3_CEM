# TP3 CEM : méthode DF 3D pour la modélisation de cavités résonantes  

## Sommaire

## Contexte global  

### Objectifs :  

- Evaluation numérique des fréquences de résonance dans une cavité parallélépipédique
- Modéliser le comportement d’une cavité réverbérante (code FDTD 3D)   

### Compétences visées :  

- Connaitre les éléments constitutifs d’un modèle électromagnétique : domaine de calcul, source, conditions initiales, conditions aux limites, convergence
- Développement et utilisation d’outils de simulation numérique (sous environnement Matlab / Octave) : code de calcul analytique & code de calcul « Full-Wave » FDTD 3D
- Post-traitement des données & sensibilisation aux grandeurs CEM (modes de résonance)  

### Contrôle des connaissances :  

- Rendu d’un compte-rendu des travaux suite à la séance de travaux

### Aide

- Dans le compte rendu `<nombre>°)` (ex `1°)`) veut dire que l'on répond à une question et qu'un fichier `tp<nombre>.m` (ex `tp01.m`) est associé dans le livrable

## Introduction  

Une cavité électromagnétique peut être définie comme un volume au sein duquel un champ d’ondes stationnaires s’établit suite aux multiples réflexions sur les parois parfaitement conductrices de l’enceinte. La géométrie du volume peut être quelconque, mais nous considérerons uniquement le cas le plus courant, i.e. celui d’un parallélépipède rectangle (Figure 1). De plus, le milieu interne correspondant à l’air est assimilé au vide de permittivité électrique0 εr et de perméabilité magnétique0 μ0.

## Théorie modale d’une cage de Faraday sans pertes  

Si on excite la cavité à l’aide d’une onde électromagnétique, des champs sont générés et vérifient
l’équation de propagation de Helmholtz (voir cours) (1):

$$\boxed{\Delta\Psi+k^2\Psi=0}$$

Où $\Psi$ représente indifféremment le champ électrique $\vec E$ ou magnétique $\vec H$ et $k$ la constante de
propagation. Les solutions sont appelées les fonctions propres de l’équation et dépendent des valeurs
propres $k$ définies par (2) :

$$k^2=\dfrac{\omega^2}{c^2}$$

Où $\omega$ correspond à la pulsation de l’onde, $c$ la vitesse de la lumière dans le vide ($3.10^8$ m/s).

![cavite](./Ressources/cavitepara.png)

Pour chacune des directions de propagation (Ox), (Oy) et (Oz), il existe des solutions ou modes de type transverse électrique (TE) et de type transverse magnétique (TM). La solution générale est une combinaison linéaire de toutes ces solutions particulières.
La résolution de l’équation dans un repère cartésien en régime harmonique impose d’écrire la constante de propagation comme suit (3):

$$k^2=k_x^2+k_y^2+k_z^2$$

En appliquant les conditions aux limites sur les parois (ce qui revient à annuler les composantes tangentielles du champ électrique et normales du champ magnétique), les composantes du nombre d’onde doivent impérativement satisfaire les relations ci-dessous (4):

$$k_x=\dfrac{m\pi}{a}\hspace{1cm}k_y=\dfrac{n\pi}{a}\hspace{1cm}k_z=\dfrac{p\pi}{a}\hspace{1cm}\text{avec } (m,n,p)\in\N^3$$

Dans une cavité, chaque mode n’existe que pour une unique fréquence dépendant du mode de la résonance (caractérisé par le triplet (m; n; p)) et des dimensions de la cage. A l’aide de (2), (3) et (4), on peut alors établir son expression (5):

$$f_{mnp}=\dfrac c2\sqrt{\left(\dfrac{m}{a}\right)^2+\left(\dfrac{n}{b}\right)^2+\left(\dfrac{p}{c}\right)^2}$$

Ainsi, le champ dans la cavité s’identifie à un spectre de raies correspondant aux modes propres de résonance déterminés par les conditions aux limites.

## Code numérique : prise en main du logiciel FDTD.m  

```MATLAB 
% Parameter initiation
Lx = 6.7; Ly = 8.4; Lz = 3.5; % Cavity dimensions in meters
Nx =  67; Ny =  84; Nz =  35; % Number of cells in each direction
```  

On ajoute une fonction permettant de calculer la fréquence de résonance, dont voici le contenu :  
```MATLAB
function f = f_cavite(a, b, d, m, n, p)
% f_cavite calcule la fréquence de résonance d'une cavité rectangulaire
%
% Entrées :
% a, b, d : dimensions de la cavité (m)
% m, n, p : indices de mode
%
% Sortie :
% f : fréquence de résonance (Hz)

c = 3e8; % vitesse de la lumière (m/s)

f = (c/2) * sqrt( (m/a)^2 + (n/b)^2 + (p/d)^2 );
end
```  

<p float="left">
  <img src="https://github.com/user-attachments/assets/d82ff249-16ce-486e-874d-c552764f23ca" width="48%" />
  <img src="https://github.com/user-attachments/assets/64e3d351-f07d-42c5-a0f0-a1240c090be2" width="48%" />
</p>

### 1°) Identification des différents parties du code du calcul cf. `tp01.m`

### 2°) L’utilisation d’un code temporel de type FDTD présente plusieurs avantages majeurs :
1. Accès large bande fréquentielle
    - Une seule simulation temporelle permet, via une transformée de Fourier, d’obtenir la réponse du système sur une large gamme de fréquences (modes propres, résonances).
2. Observation directe des phénomènes transitoires
    - Le code temporel permet d’analyser la propagation des ondes, les réflexions, les interférences et l’établissement des régimes stationnaires.
3. Simplicité d’implémentation numérique
    - Les équations de Maxwell sont discrétisées directement dans le temps et l’espace sans résolution de systèmes matriciels complexes.
4. Grande flexibilité géométrique et matérielle
    - Les milieux hétérogènes, dispersifs ou dissipatifs peuvent être intégrés naturellement dans le schéma temporel.
5. Accès simultané aux champs E et H
    - Le calcul pas à pas permet une visualisation complète de l’évolution spatio-temporelle des champs électromagnétiques.

### 3°) On ne modifie pas le script car nous avons déjà ces paramètres.

### 4°) Sauvegarde des résultats de $\vec E$ dans `Ets.txt`

```MATLAB
% Sauvegarde format texte lisible
fid = fopen('Ets.txt','w');
fprintf(fid,'%% n\tEx(V/m)\t\tEy(V/m)\t\tEz(V/m)\n');
for n = 1:Nt
fprintf(fid,'%d\t%e\t%e\t%e\n',n,Ets(n,1),Ets(n,2),Ets(n,3));
end
fclose(fid);
```
## Code numérique : modélisations de cavités « vide » et « chargée »

Dans cette partie, on va retrouver numériquement les modes de résonance d’une cavité de type Chambre Réverbérante (CR) dans les cas `vide` et `chargé` (voir Figure 2).

<img width="477" height="202" alt="image" src="https://github.com/user-attachments/assets/34c72453-267b-4fff-9fa7-5a716bbefd45" />

La charge est représentée par un volume pavé diélectrique :
- Position : xmin=1m ; ymin=1m ; zmin=1m / xmax=4m ; ymax=6m ; zmax=3m
- Propriétés diélectriques : $\varepsilon_r$ = 3 dans toutes les directions

### 5°) On réalise les modèles numériques de CRBM dans deux fichiers MATLAB distincts (`FDTD_crbm_vide.m` et `FDTD_crbm_chargee.m`) en aménageant le code `FDTD.m` précédent.

<img width="1597" height="847" alt="image" src="https://github.com/user-attachments/assets/39b68238-6f2a-4618-ad88-6c279992f1ab" />

Les 2 courbes sont bien superposée et légerement décalées sur les dernières itérations.

### 6°) On va stocker les valeurs des champs Ex, Ey et Ez à chaque itération dans un fichier (respectivement `result_vide.txt` et `result_chargee.txt`) : le fichier comportera autant de lignes que d’itérations FDTD et 3 colonnes (pour Ex, Ey et Ez).

Dans quel but ?

Les champs électriques sont stockés à chaque itération temporelle afin de permettre une analyse temporelle et fréquentielle (FFT) du comportement de la cavité. La comparaison entre la cavité vide et chargée met en évidence l’influence du milieu diélectrique sur la dynamique des champs et les modes excités.

