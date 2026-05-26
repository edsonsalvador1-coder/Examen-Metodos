clc;
clear;
close all;

%% DATOS EXPERIMENTALES

f = [10 12.5 15 17.5 20 22.5 25 27.5 30 32.5 ...
     35 37.5 40 42.5 45 47.5 50 52.5 55 57.5 ...
     60 62.5 65 67.5 70 72.5 75 77.5 80 82.5 ...
     85 87.5 90 92.5 95 97.5 100 102.5 105 107.5];

V = [0.842 0.911 0.986 1.062 1.143 1.227 1.314 1.401 ...
     1.482 1.551 1.216 1.048 0.866 0.689 0.521 0.364 ...
     0.223 0.103 -0.012 -0.041 -0.057 -0.034 0.018 ...
     0.096 0.197 0.318 0.452 0.579 0.700 0.809 ...
     0.611 0.688 0.756 0.811 0.856 0.894 0.926 ...
     0.954 0.980 1.004];

%% IDENTIFICACION DE CAMBIO DE SIGNO

for i = 1:length(V)-1
    
    if V(i)*V(i+1) < 0
        
        fprintf('Cambio de signo entre %.1f kHz y %.1f kHz\n',f(i),f(i+1));
        
    end
    
end

%% FUNCION SPLINE

fun = @(x) spline(f,V,x);

%% TOLERANCIA

tol = 1e-6;

%% ==============================
%% PRIMERA RAIZ - BISECCION
%% Intervalo [52.5 , 55]
%% ==============================

a = 52.5;
b = 55.0;

while abs(b-a) > tol
    
    c = (a+b)/2;
    
    if fun(a)*fun(c) < 0
        b = c;
    else
        a = c;
    end
    
end

raiz1_bis = (a+b)/2;

%% ==============================
%% SEGUNDA RAIZ - BISECCION
%% Intervalo [62.5 , 65]
%% ==============================

a = 62.5;
b = 65.0;

while abs(b-a) > tol
    
    c = (a+b)/2;
    
    if fun(a)*fun(c) < 0
        b = c;
    else
        a = c;
    end
    
end

raiz2_bis = (a+b)/2;

%% ==============================
%% REFINAMIENTO CON SPLINE
%% ==============================

xx = linspace(min(f),max(f),5000);

yy = spline(f,V,xx);

%% BUSQUEDA DE CRUCES POR CERO

indices = find(yy(1:end-1).*yy(2:end) < 0);

raiz1_spline = xx(indices(1));

raiz2_spline = xx(indices(2));

%% RESULTADOS

fprintf('\n----- METODO DE BISECCION -----\n');

fprintf('Primera raiz = %.6f kHz\n',raiz1_bis);

fprintf('Segunda raiz = %.6f kHz\n',raiz2_bis);

fprintf('\n----- SPLINE CUBICO -----\n');

fprintf('Primera raiz refinada = %.6f kHz\n',raiz1_spline);

fprintf('Segunda raiz refinada = %.6f kHz\n',raiz2_spline);

%% GRAFICA

figure;

plot(f,V,'ko','MarkerFaceColor','k');
hold on;

plot(xx,yy,'b','LineWidth',1.5);

plot(raiz1_bis,0,'r*','MarkerSize',12);
plot(raiz2_bis,0,'m*','MarkerSize',12);

plot(raiz1_spline,0,'gs','MarkerSize',10,'MarkerFaceColor','g');
plot(raiz2_spline,0,'cs','MarkerSize',10,'MarkerFaceColor','c');

yline(0,'k--');

xlabel('Frecuencia (kHz)');
ylabel('Voltaje V(f)');

title('Raices mediante Biseccion y Spline Cubico');

legend('Datos experimentales',...
       'Spline cubico',...
       'Raiz 1 - Biseccion',...
       'Raiz 2 - Biseccion',...
       'Raiz 1 - Spline',...
       'Raiz 2 - Spline');

grid on;