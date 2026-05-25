clc
clear
close all

%% =========================
% DATOS EXPERIMENTALES
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
% SPLINE CUBICO
%% =========================

pp = spline(f,Z);

%% =========================
% DERIVADA ANALITICA
%% =========================

pp_der = fnder(pp,1);

%% =========================
% MALLA FINA
%% =========================

x = linspace(100,2730,5000);

% Evaluacion de la derivada
dZ = ppval(pp_der,x);

%% =========================
% BUSQUEDA DEL MINIMO
%% =========================

indice = find(dZ > 0,1);

f_min = x(indice);

valor_derivada = dZ(indice);

%% =========================
% RESULTADOS
%% =========================

fprintf('Frecuencia aproximada del minimo = %.4f Hz\n',f_min)

fprintf('Valor de la derivada = %.4e Ohm/Hz\n',valor_derivada)

%% =========================
% GRAFICA
%% =========================

figure

plot(x,dZ,...
    'b',...
    'LineWidth',2)

hold on

% Linea horizontal
yline(0,'k--','LineWidth',1)

% Punto critico
plot(f_min,valor_derivada,...
    'ro',...
    'MarkerFaceColor','r',...
    'MarkerSize',8)

grid on
box on

xlabel('Frecuencia (Hz)')
ylabel('d|Z| / df')

title('Derivada Primera del Spline Cubico')

legend('Derivada del spline',...
    'd|Z|/df = 0',...
    'Punto critico',...
    'Location','best')
