%%%%%%%%%%%%%%%%%
% Fonction FDTD %
%%%%%%%%%%%%%%%%%

clear 
close all
clc

max_time  = 1500;
max_space = 501;

% Definition des constantes
eps0 = 8.8542e-12;
mu0  = 4*pi*1e-7;
Z0   = 120*pi;
c0 = 1/sqrt(eps0*mu0);

% Definition des discretisations
L = 0.5;                   % longueur du domaine en m 
dz = L./(max_space-1);   % pas spatial 
alpha = 1;
dt = alpha*dz/c0; % dt = alpha.(dz/co)
%distance = 0.5*dz;
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
center_problem_space = 3; % spatial : au centre
t0 = 400*dt; % source en temps maximale a cet instant

% Remarque : E est 1/2 pas de temps derriere
% car le pulse est introduit dans le probleme
% entre les boucles sur E et H

% Création d'une source spatiale 
% c0 = 1/sqrt(eps0*mu0);
% z0 = 1.0;
% for iz = 2:max_space-1
%     E(iz) = exp(-(((iz-1)*dz-z0)/(c0*spread))^2);
% end

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
   
    E(max_space) = Eright1;
    Eright1 = E(max_space-1);
    E(1) = Eleft1;
    Eleft1 = E(2);
    
    % Hard source
    pulse = exp(-(n*dt-t0)^2/spread^2);

    % Hard source coupée à n = 60
    % if n<=600
    %     E(center_problem_space) = pulse;
    % end

    % Soft source 
    E(center_problem_space) = E(center_problem_space) + pulse;

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
    pause(0.002)

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