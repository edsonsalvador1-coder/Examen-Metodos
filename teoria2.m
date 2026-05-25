clc
clear
close all

%% VARIABLES SIMBOLICAS

syms a1 b1 c1 d1
syms a2 b2 c2 d2
syms x

%% ECUACIONES DEL SISTEMA

% Condiciones de interpolacion

eq1 = d1 == 1;

eq2 = 8*a1 + 4*b1 + 2*c1 + d1 == 6;

eq3 = 8*a2 + 4*b2 + 2*c2 + d2 == 6;

eq4 = 125*a2 + 25*b2 + 5*c2 + d2 == 3;

%% Continuidad de primera derivada

eq5 = 12*a1 + 4*b1 + c1 ...
    == 12*a2 + 4*b2 + c2;

%% Continuidad de segunda derivada

eq6 = 12*a1 + 2*b1 ...
    == 12*a2 + 2*b2;

%% Condiciones naturales

eq7 = 2*b1 == 0;

eq8 = 30*a2 + 2*b2 == 0;

%% RESOLVER SISTEMA

sol = solve([eq1 eq2 eq3 eq4 ...
             eq5 eq6 eq7 eq8], ...
             [a1 b1 c1 d1 ...
              a2 b2 c2 d2]);

%% MOSTRAR RESULTADOS

disp(' ')
disp('Coeficientes encontrados:')

fprintf('\nSpline 1:\n')

fprintf('a1 = %.6f\n',double(sol.a1))
fprintf('b1 = %.6f\n',double(sol.b1))
fprintf('c1 = %.6f\n',double(sol.c1))
fprintf('d1 = %.6f\n',double(sol.d1))

fprintf('\nSpline 2:\n')

fprintf('a2 = %.6f\n',double(sol.a2))
fprintf('b2 = %.6f\n',double(sol.b2))
fprintf('c2 = %.6f\n',double(sol.c2))
fprintf('d2 = %.6f\n',double(sol.d2))

%% CONSTRUCCION DE LOS SPLINES

S1 = sol.a1*x^3 + sol.b1*x^2 ...
   + sol.c1*x + sol.d1;

S2 = sol.a2*x^3 + sol.b2*x^2 ...
   + sol.c2*x + sol.d2;

%% MOSTRAR SPLINES

disp(' ')
disp('Spline 1:')
pretty(S1)

disp(' ')
disp('Spline 2:')
pretty(S2)

%% GRAFICA

figure

fplot(S1,[0 2], ...
    'LineWidth',2)

hold on

fplot(S2,[2 5], ...
    'LineWidth',2)

plot([0 2 5],[1 6 3], ...
    'ro', ...
    'MarkerFaceColor','r', ...
    'MarkerSize',8)

grid on

xlabel('Tiempo (s)')

ylabel('Altura (m)')

title('Spline Cubico Natural')

legend('Spline 1', ...
       'Spline 2', ...
       'Datos experimentales')
