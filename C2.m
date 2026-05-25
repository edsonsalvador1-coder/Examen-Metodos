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
% PRIMERA DERIVADA
%% =========================

pp_der1 = fnder(pp,1);

%% =========================
% SEGUNDA DERIVADA
%% =========================

pp_der2 = fnder(pp,2);

%% =========================
% MALLA FINA
%% =========================

x = linspace(100,2730,5000);

% Evaluar primera derivada
dZ1 = ppval(pp_der1,x);

% Evaluar segunda derivada
dZ2 = ppval(pp_der2,x);

%% =========================
% BUSQUEDA DEL MINIMO
%% =========================

indice = find(dZ1 > 0,1);

f_min = x(indice);

%% =========================
% SEGUNDA DERIVADA EN EL MINIMO
%% =========================

valor_der2 = ppval(pp_der2,f_min);

%% =========================
% RESULTADOS
%% =========================

fprintf('Frecuencia del minimo = %.4f Hz\n',f_min)

fprintf('Segunda derivada = %.4e Ohm/Hz^2\n',valor_der2)

%% =========================
% GRAFICA SEGUNDA DERIVADA
%% =========================

figure

plot(x,dZ2,...
    'm',...
    'LineWidth',2)

hold on

% Punto critico
plot(f_min,valor_der2,...
    'ko',...
    'MarkerFaceColor','k',...
    'MarkerSize',8)

% Linea horizontal
yline(0,'k--')

grid on
box on

xlabel('Frecuencia (Hz)')
ylabel('d^2|Z| / df^2')

title('Segunda Derivada del Spline Cubico')

legend('Segunda derivada',...
       'Minimo estable',...
       'd^2|Z|/df^2 = 0',...
       'Location','best')
