clc
clear
close all

warning off

%% =========================
% DATOS
%% =========================

f = [100 120 145 170 200 235 270 310 355 405 ...
460 520 585 655 730 810 895 985 1080 1180 ...
1290 1410 1540 1680 1830 1990 2160 2340 ...
2530 2730];

Z = [152.3 149.1 146.8 144.9 142.0 139.5 137.9 ...
136.1 134.8 133.6 132.7 131.9 131.4 131.1 ...
130.9 131.0 131.3 131.9 132.7 133.8 135.2 ...
136.9 138.9 141.1 143.5 146.1 149.0 152.2 ...
155.6 159.2];

%% =========================
% MALLA
%% =========================

x = linspace(100,2730,10000);

%% =========================
% POLINOMIOS
%% =========================

p5 = polyfit(f,Z,5);
p10 = polyfit(f,Z,10);
p15 = polyfit(f,Z,15);
p29 = polyfit(f,Z,29);

y5 = polyval(p5,x);
y10 = polyval(p10,x);
y15 = polyval(p15,x);
y29 = polyval(p29,x);

%% ======================================================
% FIGURA 1
% GRADOS 5 - 10 - 15
%% ======================================================

figure

hold on

plot(f,Z,'ko',...
    'MarkerFaceColor','k')

plot(x,y5,'b','LineWidth',2)

plot(x,y10,'g','LineWidth',2)

plot(x,y15,'m','LineWidth',2)

grid on
box on

xlabel('Frecuencia (Hz)')
ylabel('|Z| (\Omega)')

title('Comparacion de Polinomios de Grado 5, 10 y 15')

legend('Datos experimentales',...
       'Grado 5',...
       'Grado 10',...
       'Grado 15',...
       'Location','best')

%% ======================================================
% FIGURA 2
% GRADO 29
%% ======================================================

figure

hold on

plot(f,Z,'ko',...
    'MarkerFaceColor','k')

plot(x,y29,...
    'r',...
    'LineWidth',2)

grid on
box on

xlabel('Frecuencia (Hz)')
ylabel('|Z| (\Omega)')

title('Polinomio Global de Grado 29')

legend('Datos experimentales',...
       'Grado 29',...
       'Location','best')

% Mostrar Runge
ylim([-5e6 5e6])

warning on
