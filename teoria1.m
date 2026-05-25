clc
clear
close all

% =========================
% DATOS DEL PROBLEMA
% =========================

x = [1 2 4];
y = [3 5 4];

% =========================
% VARIABLE PARA GRAFICAR
% =========================

xp = linspace(1,4,500);

% =========================
% POLINOMIO DE LAGRANGE
% =========================

n = length(x);

yp = zeros(size(xp));

for k = 1:length(xp)

    suma = 0;

    for i = 1:n

        L = 1;

        for j = 1:n

            if i ~= j

                L = L * ((xp(k)-x(j)) / (x(i)-x(j)));

            end

        end

        suma = suma + y(i)*L;

    end

    yp(k) = suma;

end

% =========================
% MOSTRAR POLINOMIO
% =========================

disp('Interpolacion de Lagrange completada')

% =========================
% GRAFICA
% =========================

figure

plot(xp,yp,...
    'b','LineWidth',2)

hold on

plot(x,y,...
    'ro',...
    'MarkerFaceColor','r',...
    'MarkerSize',8)

grid on

xlabel('x')
ylabel('P(x)')

title('Interpolacion Polinomica de Lagrange')

legend('Polinomio de Lagrange',...
    'Datos experimentales')
