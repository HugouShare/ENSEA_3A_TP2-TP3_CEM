% Resolution equation de Laplace

%% Commandes de nettoyage
clear
close all
clc

%% Dimensions / maillage
dx = 1; % cm
dy = 1; % cm
Nx = 40;
Ny = 40;

%% Potentiels / sources
v0 = 0; % condition aux limites (en V)
v1 = 100; % potentiel du conducteur 1
v2 = -100; % potentiel du conducteur 2

% Initialisation de la matrice de calcul
V = zeros(Nx,Ny); % mettre toute la matrice a zero

% Conditions aux limites
for j = 1:Ny
    V(1,j)=v0;
    V(Nx,j)=v0;
end

for i = 1:Nx
    V(i,1)=v0;
    V(i,Ny)=v0;
end

% Modélisation du conducteur 1
i = 8:35;
j = 15:18;
V(i,j) = v1;

% Modélisation du conducteur 2
i = 8:35;
j = 20:23;
V(i,j) = v2;

% Création d'un seuil pour le calcul des itérations & variation de Nx et Ny
seuil = 1e-2;
nb_iteration = 0;
condition = 10000;
while condition > seuil

    nb_iteration = nb_iteration + 1;
    Vold = V;

    % Calcul du potentiel avec methode DF
    i = 2:Nx-1;
    j = 2:Ny-1;
    V(i,j) = 0.25*(V(i,j+1)+V(i,j-1)+V(i+1,j)+V(i-1,j));

    % On remet aux CIs 
    % Modélisation du conducteur 1
    i = 8:35;
    j = 25:28;
    V(i,j) = v1;
    % Modélisation du conducteur 2
    i = 8:35;
    j = 15:18;
    V(i,j) = v2;

    condition = max(max(abs(Vold-V)));
end

% Récupération du gradient de V
[Ex,Ey] = gradient (V');

%% Figure
figure;
contour(V') % permet de tracer transposée de V
hold on;
quiver(-Ex,-Ey) % permet de tracer les équipotentielles de V
colormap jet % permet d'avoir un contraste de couleur (bleu->rouge)
axis equal % permet d'avoir un repère orthonormé