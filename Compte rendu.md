# Travaux pratiques 2 CEM : utilisation de la méthode DF pour la simulation CEM

## Contexte global  

### Objectifs :  

- Calcul des champs électriques / magnétiques par la méthode des différences finies
- Développement d’un code de calcul temporel

### Compétences visées :  

- Connaitre les éléments constitutifs d’un modèle électromagnétique sur un exemple de calcul
transitoire : domaine de calcul, source, conditions initiales, conditions aux limites, itérations
- Utilisation d’un outil de simulation & développement numérique (sous environnement Matlab /
Octave)
- Post-traitement des données & sensibilisation aux grandeurs CEM

### Contrôle des connaissances :  

- Rendu d’un compte-rendu des travaux suite à la séance de travaux

## Introduction  

Durant ce TP, nous traitons d'électrodynamique dans un contexte de CEM.  
Ainsi, nous allons nous intéresser à la propagation d’une onde électromagnétique et calculer, selon une unique dimension (z par exemple), ses composantes Ex et Hy via la résolution des équations de Maxwell.  
Nous obtiendrons alors les différentes valeurs de Ex et Hy au cours du temps t et en tout point de l'axe z. 

## 1. Schéma FDTD  

### 1.1 Les équations de Maxwell  

#### Généralités...  

En espace libre (faible intéraction entre les ondes et les objets environnants), l'évolution de la propagation temporelle d'ondes électromagnétiques peut être obtenue grâce aux équations de Maxwell, dont voici les expressions :

<img width="197" height="139" alt="image" src="https://github.com/user-attachments/assets/bdcdd0af-d22a-4585-abc5-0b46dfd448eb" /> 

Ou encore, de manière équivalente :

<img width="547" height="418" alt="image" src="https://github.com/user-attachments/assets/b25f2ef6-e664-4384-b633-2e1fb06ba4f2" />

#### Dans notre cas à nous... 

Dans notre cas à nous, nous nous intéresserons seulement à la propragation d'une onde selon l'axe z.  
De cela découle alors :  

$$
E = (Ex, 0, 0)
$$  

$$
H = (0, Hy, 0)  
$$  

### 1.2 Algorithmes à utiliser    

Les équations qui nous importent sont donc :  
<img width="186" height="144" alt="image" src="https://github.com/user-attachments/assets/fcaafd04-d0e3-4ddf-bc95-cda5ee6b17d1" />  

En discrétisant les équations précédentes (étape nécessaire pour appliquer la méthode des DF), nous obtenons alors les équations suivantes :  

<img width="878" height="212" alt="image" src="https://github.com/user-attachments/assets/49007832-490f-41cb-8d89-72d2f535af4c" />  

Où :  
- chaque pas d'espace est représenté par k
- chaque pas de temps est représenté par n et régit par :
- 
  <img width="198" height="30" alt="image" src="https://github.com/user-attachments/assets/b86d0ddd-cf36-4f1e-b74a-f4d9247cfdeb" />  

  avec alpha jouant le rôle de critère de stabilité, compris entre 0 et 1.  

Enfin, nous allons utiliser une source d'excitation au profil Gaussien imposée au centre du domaine de calcul, dont l'expression est la suivante : 

<img width="381" height="39" alt="image" src="https://github.com/user-attachments/assets/ea760d5d-90f6-4639-bce8-2042c784ad1b" />  

### 1.3 Test de la condition de stabilité

Dans l’algorithme présenté initialement, le coefficient $\alpha$ joue le rôle de critère de stabilité. On
sait (voir le cours FDTD) que ce critère ne doit pas dépasser 1 et est lié aux pas temporel et spatial du
schéma et aux propriétés du milieu de propagation. Ainsi, augmenter la valeur du coefficient $\alpha$ permet,
pour un même nombre d’itérations en temps (paramètre $n$ précédent) d’atteindre un temps de
simulation plus important. Toutefois, il n’est pas bon d’augmenter indéfiniment $\alpha$ sous peine de
divergence du calcul.

On considère :  
`k : indice dans l'espace`  
`n : indice temporel`  

### Exercice `scriptFTD01.m` 

#### Pour $\alpha = 1$
<!-- Ligne 1 -->
<p float="left">
  <img src="https://github.com/user-attachments/assets/ce12d775-6156-4a4c-8bd4-19c1c71f30a1" width="48%" />
  <img src="https://github.com/user-attachments/assets/02055775-f0a1-4966-9ebc-c400326bb1f2" width="48%" />
</p>

<!-- Ligne 2 -->
<p float="left">
  <img src="https://github.com/user-attachments/assets/6b32f112-e371-4e32-84bd-25f72a58eb21" width="48%" />
  <img src="https://github.com/user-attachments/assets/f6301c8a-0fa7-43b3-ad58-b0e680ea06c3" width="48%" />
</p>

#### Pour $\alpha = 0.5$
<!-- Ligne 3 -->
<p float="left">
<img src="https://github.com/user-attachments/assets/456fcd44-7c83-4cd8-a71a-74c49aff578d" width="48%" />
<img src="https://github.com/user-attachments/assets/ea9fa61e-b867-47ce-b6bf-301d402c3476" width="48%" />
</p>

#### Pour $\alpha = 1.1$
<!-- Ligne 4 -->
<p float="left">
<img src="https://github.com/user-attachments/assets/ca4df660-9abb-47b9-bb84-d2f96e9592ae" width="48%" />
<img src="https://github.com/user-attachments/assets/46157159-dc2f-40ba-8c20-12664f53eaa3" width="48%" />
</p>

>[!IMPORTANT]
> On remarque bien que lorsque l'on dépasse le critère de stabilitié, le signal explose complètement et diverge.

## 2. Les sources d’excitation => `scriptFDTD02` et `scriptFDTD03`

### 2.1 Les sources temporelles => `scriptFDTD02`

Dans le programme proposé, on utilise une source « dure » (« **hard** » source). Comme évoqué précédemment, ce type de source correspond à l’imposition d’une condition en un point spatial du domaine de calcul (ici au milieu du domaine de calcul : `center_problem_space`).

#### Pour `max_time` = 300 et `alpha` =1

<!-- Ligne 5 -->
<p float="left">
<img src="https://github.com/user-attachments/assets/3c0281f1-b197-472d-94cc-1f40c81605b0" width="32%" />
<img src="https://github.com/user-attachments/assets/fb8661cc-02a4-4da2-81b0-5bea142e214d" width="32%" />
<img src="https://github.com/user-attachments/assets/f567c141-d5cd-4866-a3a8-f1c71527ccb1" width="32%" />
</p>

#### Avec condition $n≤60$ (hard source)

<img width="1599" height="854" alt="image" src="https://github.com/user-attachments/assets/9a1432dc-b6d0-4eb1-ac58-235723003044" />
on observe que l'on a plus de relfexion au point 101. Les ondes se superposent puis continuent leur chemin respectif SANS inversion de phase.

### 2.2 Les sources spatiales => scriptFDTD03

On passe au cas d'une soft-source : 
...

Nous supprimons maintenant les sources temporelles et passons à une source spatiale.
Avec la formule : `c0^2.eps0.mu0=1` on déduit `c0`.
On observe que la source spatiale correspond à une soft source

## 3. Simulations en espace libre : les conditions de non-réflexion (« magic time-step ») => `scriptFDTD04` et `scriptFDTD05`

Nous nous proposons maintenant de modifier les conditions aux limites ie en 1 et `max_space` cf sujet.

#### Pour $\alpha=0.5$

<p float="left">
<img src="https://github.com/user-attachments/assets/a3d027ea-6dd6-4fb9-91d1-c802db7c9c08" width="32%" />
<img src="https://github.com/user-attachments/assets/97d44d5f-46b1-4f7b-80b5-e6d8a46d8745" width="32%" />
<img src="https://github.com/user-attachments/assets/7e154423-71df-47b1-8a6d-91705853ac4c" width="32%" />
</p>

- code :

```MATLAB
alpha = 0.5;
```  
```MATLAB
% On veut maintenant avoir des conditions absorbantes aux limites : 
% en z = 1 et z = max_space
Eright1 = 0;
Eright2 = 0;
Eleft1 = 0;
Eleft2 = 0;

% Début boucle temporelle
for n = 1:max_time

    % Boucle interieure sur le champ E
    for k = 2:max_space-1 
        E(k) = E(k) + alphaH*(H(k)-H(k-1));
    end
   
    E(max_space) = Eright2;
    Eright2 = Eright1;
    Eright1 = E(max_space-1);
    E(1) = Eleft2;
    Eleft2 = Eleft1;
    Eleft1 = E(2);
    
    % Hard source
    pulse = exp(-(n*dt-t0)^2/spread^2);

    % Hard source coupée à n = 60
    if n<=60
        E(center_problem_space) = pulse;
    end

    % Soft source 
    % E(center_problem_space) = E(center_problem_space) + pulse;

    % Boucle interieure sur le champ H
    for j = 1:max_space-1 % quelles valeurs ?
        H(j) = H(j) + alphaE*(E(j+1)-E(j));% quelles valeurs ?
    end

    % Trace et progression de l'onde electrique
    figure(1)
    plot([0:max_space-1]*dz,E)
    axis([0 (max_space)*dz -1.1 1.1])
    title('Simulation FDTD du champ electrique')
    xlabel('z (position en espace) [m]')
    ylabel('E_x [V/m]')
    pause(0.05)

end 
% Fin boucle temporelle
```  
- Comme nous avons paramétré notre $dt$ avec $\alpha$, en le laissant à 0.5, ous parcourons un pas spatial en deux itérations (deux pas temporels) et donc nous respectons bien notre condition de type $E(1)^n=E(2)^{n-2}$

#### Pour $\alpha = 1$

- code :

```MATLAB
alpha = 1;
```

<img width="642" height="499" alt="image" src="https://github.com/user-attachments/assets/edc76768-cddd-4ec9-94fe-9db79303c410" />  

- Rien eu besoin de modifier d'autres

## 4. Simuler la propagation d’une onde plane pour la traversée d’un diélectrique (1-D) sans pertes => `scriptFDTD05` et `scriptFDTD06`

La prise en compte d’un matériau (ou d’un objet appelé « slab » dans la suite) nécessite de revenir aux équations de Maxwell. Ainsi, on peut réécrire ces dernières en tenant compte de la permittivité diélectrique relative $\varepsilon_r$ :

<img width="657" height="149" alt="image" src="https://github.com/user-attachments/assets/d276242d-342e-4d55-9447-dc9745000b42" />

On nous demande donc de faire :
En préambule deux modifications avant d’introduire le domaine diélectrique dans la simulation :
- modifier les programmes précédents pour traiter le cas d’un domaine de calculs $L=0.5m$ (on adaptera le code pour obtenir un pas spatial $dz=0.001m$ cette fois !!),
- conserver des conditions absorbantes « magiques » comme dans le script `scriptFDTD04`,
- placer la source (pulse gaussien comme dans le script précédent au point $z=0.001$ (cela revient à exciter E(2)) ; ceci pour éviter de générer deux ondes divergentes et se concentrer sur l’onde électromagnétique se propageant dans le sens « +z »,
- lancer enfin notre code `scriptFDTD05` pour `max_time=1500 et vérifier que la propagation se déroule correctement.






