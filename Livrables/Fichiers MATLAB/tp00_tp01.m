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
j = 25:28;
V(i,j) = v1;

% Modélisation du conducteur 2
i = 20:21;
j = 5:22;
V(i,j) = v2;

% Figure
figure;
pcolor(V') % permet de tracer transposée de V
colormap jet % permet d'avoir un contraste de couleur (bleu->rouge)
axis equal % permet d'avoir un repère orthonormé