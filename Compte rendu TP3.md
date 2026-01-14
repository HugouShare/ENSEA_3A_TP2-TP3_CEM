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



