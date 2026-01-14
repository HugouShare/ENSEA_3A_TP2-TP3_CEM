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

## Code numérique : prise en main du logiciel FDTD.m  

```MATLAB 
% Parameter initiation
Lx = 6.7; Ly = 8.4; Lz = 3.5; % Cavity dimensions in meters
Nx =  67; Ny =  84; Nz =  35; % Number of cells in each direction
```  

On ajoute une fonction permettant de calculer la fréquence de résonance  




