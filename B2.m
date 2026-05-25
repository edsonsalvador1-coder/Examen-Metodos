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
% MALLA FINA
%% =========================

x = linspace(100,2730,5000);

%% =========================
% POLINOMIO GRADO 5
%% =========================

p5 = polyfit(f,Z,5);

y_poly = polyval(p5,x);

%% =========================
% SPLINE CUBICO
%% =========================

y_spline = spline(f,Z,x);

%% =========================
% INTERPOLACION EN 1000 Hz
%% =========================

f_int = 1000;

Z_poly_1000 = polyval(p5,f_int);

Z_spline_1000 = spline(f,Z,f_int);

fprintf('Polinomio grado 5 en 1000 Hz = %.4f ohm\n',Z_poly_1000)

fprintf('Spline cubico en 1000 Hz = %.4f ohm\n',Z_spline_1000)

%% =========================
% GRAFICA
%% =========================

figure

hold on

% Datos experimentales
plot(f,Z,'ko',...
    'MarkerFaceColor','k',...
    'MarkerSize',5)

% Polinomio grado 5
plot(x,y_poly,...
    'b',...
    'LineWidth',2)

% Spline cubico
plot(x,y_spline,...
    'r--',...
    'LineWidth',2)

% Punto interpolado polinomio
plot(f_int,Z_poly_1000,...
    'bo',...
    'MarkerFaceColor','b',...
    'MarkerSize',8)

% Punto interpolado spline
plot(f_int,Z_spline_1000,...
    'ro',...
    'MarkerFaceColor','r',...
    'MarkerSize',8)

%% TEXTO EN LA GRAFICA

text(1050,Z_poly_1000,...
    sprintf('Polinomio = %.4f \\Omega',Z_poly_1000),...
    'Color','b',...
    'FontSize',10)

text(1050,Z_spline_1000-0.5,...
    sprintf('Spline = %.4f \\Omega',Z_spline_1000),...
    'Color','r',...
    'FontSize',10)

%% CONFIGURACION

grid on
box on

xlabel('Frecuencia (Hz)')
ylabel('|Z| (\Omega)')

title('Comparacion entre Polinomio Grado 5 y Spline Cubico')

legend('Datos experimentales',...
       'Polinomio grado 5',...
       'Spline cubico',...
       'Interpolacion polinomica',...
       'Interpolacion spline',...
       'Location','best')
