# Travaux pratiques 2 CEM : utilisation de la méthode DF pour la simulation CEM

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

## Note durant TP
On considère : k indice dans l'espace & n indice temporel  

## 1ere exec 
<img width="1652" height="862" alt="image" src="https://github.com/user-attachments/assets/ce12d775-6156-4a4c-8bd4-19c1c71f30a1" />

<img width="1623" height="874" alt="image" src="https://github.com/user-attachments/assets/02055775-f0a1-4966-9ebc-c400326bb1f2" />

<img width="1594" height="876" alt="image" src="https://github.com/user-attachments/assets/6b32f112-e371-4e32-84bd-25f72a58eb21" />

<img width="1677" height="868" alt="image" src="https://github.com/user-attachments/assets/f6301c8a-0fa7-43b3-ad58-b0e680ea06c3" />

Pour alpha = 0.5
<img width="1639" height="869" alt="image" src="https://github.com/user-attachments/assets/456fcd44-7c83-4cd8-a71a-74c49aff578d" />
<img width="1665" height="885" alt="image" src="https://github.com/user-attachments/assets/ea9fa61e-b867-47ce-b6bf-301d402c3476" />

Pour alpha = 1.1
<img width="1617" height="852" alt="image" src="https://github.com/user-attachments/assets/ca4df660-9abb-47b9-bb84-d2f96e9592ae" />
<img width="1629" height="841" alt="image" src="https://github.com/user-attachments/assets/46157159-dc2f-40ba-8c20-12664f53eaa3" />

Pour max_time = 300 et alpha =1
<img width="1601" height="841" alt="image" src="https://github.com/user-attachments/assets/3c0281f1-b197-472d-94cc-1f40c81605b0" />
<img width="1592" height="826" alt="image" src="https://github.com/user-attachments/assets/fb8661cc-02a4-4da2-81b0-5bea142e214d" />
<img width="1662" height="876" alt="image" src="https://github.com/user-attachments/assets/f567c141-d5cd-4866-a3a8-f1c71527ccb1" />

Avec condition n<=60
<img width="1599" height="854" alt="image" src="https://github.com/user-attachments/assets/9a1432dc-b6d0-4eb1-ac58-235723003044" />
on observe que l'on a plus de relfexion au point 101. Les ondes se superposent puis continuent leur chemin respectif SANS inversion de phase.

On passe au cas d'une soft-source : 
...

Nous supprimons maintenant les sources temporelles et passons à une source spatiale.
Avec la formule : c0^2.eps0.mu0=1 on déduit c0.
ON observe que la source spatiale correspond à une soft source

Nous nous proposons maintenant de modifier les codnitions aux limites ie en 1 et max_space cf sujet.
