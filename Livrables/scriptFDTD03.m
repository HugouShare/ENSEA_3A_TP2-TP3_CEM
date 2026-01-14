%%%%%%%%%%%%%%%%%
% Fonction FDTD %
%%%%%%%%%%%%%%%%%

% function [] = foncFDTD02(time)

clear 
close all
clc

max_time  = 300;
max_space = 201;
% alpha = 0.5;

% Definition des constantes
eps0 = 8.8542e-12;
mu0  = 4*pi*1e-7;
Z0   = 120*pi;

% Definition des discretisations
L = 2;                   % longueur du domaine en m 
dz = L./(max_space-1);   % pas spatial 
alpha = 1;
dt = alpha*sqrt(eps0*mu0).*dz;
%dt = 3.2e-11;
alphaE = -1./eps0 .* dt./dz;
alphaH = -1./mu0 .* dt./dz;

% Initialisation des champs E et H
% Dimension en H = dimension en E - 1 du au schema
% Conditions aux limites imposees ici pour E(1) et E(max_space) à 0
E = zeros(max_space,1);
H = zeros(max_space-1,1);

% Largeur du pulse de la source
% spread = 12;
spread = 1.6e-10;
% Centre du pulse
center_problem_space = round(max_space/2); % spatial : au centre
t0 = 40*dt; % source en temps maximale a cet instant

% Remarque : E est 1/2 pas de temps derriere
% car le pulse est introduit dans le probleme
% entre les boucles sur E et H

% Création d'une source spatiale 
c0 = 1/sqrt(eps0*mu0);
z0 = 1.0;
for iz = 2:max_space-1
    E(iz) = exp(-(((iz-1)*dz-z0)/(c0*spread))^2);
end

% Début boucle temporelle
for n = 1:max_time

    % Boucle interieure sur le champ E
    for k = 2:max_space-1 
        E(k) = E(k) + alphaH*(H(k)-H(k-1));
    end
   
    % Hard source
    % pulse = exp(-(n*dt-t0)^2/spread^2);

    % Hard source coupée à n = 60
    % if n<=60
    %     E(center_problem_space) = pulse;
    % end

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
    % Legendes et titre pour la figure
    title('Simulation FDTD du champ electrique')
    xlabel('z (position en espace) [m]')
    ylabel('E_x [V/m]')
    pause(0.05)

end 
% Fin boucle temporelle

% Tracés des champs electriques et magnetiques au temps maximum
figure(2)
subplot(2,1,1)
plot([0.5:max_space-1.5]*dz,H,'r')
title(['Simulation du champ magnetique a t=' num2str(n*dt*1e9) 'ns'])
ylabel('H_y [A/m]')
xlabel('z (position en espace) [m]')
axis([0*dz (max_space)*dz -1.1./Z0 1.1./Z0])
subplot(2,1,2)
plot([0:max_space-1]*dz,E,'g')
title(['Simulation du champ electrique a t=' num2str(n*dt*1e9) 'ns'])
ylabel('E_x [V/m]')
xlabel('z (position en espace) [m]')
axis([0*dz (max_space)*dz -1.1 1.1])
% Fin de la fonction