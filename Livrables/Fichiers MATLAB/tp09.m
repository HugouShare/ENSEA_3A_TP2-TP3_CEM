% Application au cas d'un câble coaxial

%% Commandes de nettoyage
clear
close all
clc

%% Dimensions / maillage
dx = 1; % cm
dy = 1; % cm
Nx = 201;
Ny = 201;

%% Potentiels / sources
v0 = 0; % condition aux limites (en V)
v1 = -1; % potentiel du conducteur 1
v2 = 1; % potentiel du conducteur 2

% Initialisation de la matrice de calcul
V = zeros(Nx,Ny); % mettre toute la matrice a zero

% Considération des conditions aux limites
indice = load('indice.txt');
V(indice) = v2;
V(1,:)=v1;
V(Nx-1:Nx,:)=v1;
V(:,1)=v1;
V(:,Ny-1:Ny)=v1;

% Création d'un seuil pour le calcul des itérations & variation de Nx et Ny
eps = 1e-3;
itmax = 10000;
nb_iteration = 0;
while itmax > eps

    nb_iteration = nb_iteration + 1;
    Vold = V;

    % Calcul du potentiel avec methode DF
    i = 2:Nx-1;
    j = 2:Ny-1;
    V(i,j) = 0.25*(V(i,j+1)+V(i,j-1)+V(i+1,j)+V(i-1,j));

    % On remet aux CIs 
    V(indice) = v2;
    V(1,:)=v1;
    V(Nx-1:Nx,:)=v1;
    V(:,1)=v1;
    V(:,Ny-1:Ny)=v1;

    itmax = max(max(abs(Vold-V)));
end

% Récupération du gradient de V
[Ex,Ey] = gradient (V);

% Ici, on définit une surface autour des deux conducteurs QUI NE COUPE PAS LES DEUX CONDUCTEURS !!! 
% Calcul de la valeur de la capacité des condos
EScalDs = -sum(Ey(50,50:150))+sum(Ey(150,50:150))-sum(Ex(50:150,50))+sum(Ex(50:150,150));
Q = EScalDs*8.854e-12;
C = Q/200;

%% Figure
figure;
pcolor(V') % permet de tracer transposée de V
hold on;
% colormap jet % permet d'avoir un contraste de couleur (bleu->rouge)
% axis equal % permet d'avoir un repère orthonormé
% hold on;
% contour(V') % permet de tracer transposée de V
% quiver(-Ex,-Ey) % permet de tracer les équipotentielles de V
colormap jet % permet d'avoir un contraste de couleur (bleu->rouge)
axis equal % permet d'avoir un repère orthonormé
colorbar