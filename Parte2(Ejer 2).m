clc;
clear;
close all;

%% DATOS

f = [10 12.5 15 17.5 20 22.5 25 27.5 30 32.5 ...
    35 37.5 40 42.5 45 47.5 50 52.5 55 57.5 ...
    60 62.5 65 67.5 70 72.5 75 77.5 80 82.5 ...
    85 87.5 90 92.5 95 97.5 100 102.5 105 107.5];

V = [0.842 0.911 0.986 1.062 1.143 1.227 1.314 1.401 ...
    1.482 1.551 1.216 1.048 0.866 0.689 0.521 0.364 ...
    0.223 0.103 0.012 -0.041 -0.057 -0.034 0.018 ...
    0.096 0.197 0.318 0.452 0.579 0.700 0.809 ...
    0.611 0.688 0.756 0.811 0.856 0.894 0.926 ...
    0.954 0.980 1.004];

%% PASO
h = 2.5;

%% DIFERENCIA CENTRADA ORDEN 2

dV_o2 = zeros(size(V));

for i = 2:length(V)-1

    dV_o2(i) = (V(i+1)-V(i-1))/(2*h);

end

%% DIFERENCIA CENTRADA ORDEN 4

dV_o4 = zeros(size(V));

for i = 3:length(V)-2

    dV_o4(i) = (-V(i+2)+8*V(i+1)-8*V(i-1)+V(i-2))/(12*h);

end

%% INDICES IMPORTANTES

i40 = find(f==40);
i70 = find(f==70);
i100 = find(f==100);

%% RESULTADOS

fprintf('--- ORDEN 2 ---\n');

fprintf('dV/df(40) = %.5f\n',dV_o2(i40));
fprintf('dV/df(70) = %.5f\n',dV_o2(i70));
fprintf('dV/df(100) = %.5f\n\n',dV_o2(i100));

fprintf('--- ORDEN 4 ---\n');

fprintf('dV/df(40) = %.5f\n',dV_o4(i40));
fprintf('dV/df(70) = %.5f\n',dV_o4(i70));
fprintf('dV/df(100) = %.5f\n',dV_o4(i100));

%% GRAFICA

figure;

plot(f,dV_o2,'b-o','LineWidth',1.2);
hold on;

plot(f,dV_o4,'r-s','LineWidth',1.2);

plot(40,dV_o2(i40),'ko','MarkerSize',10,'MarkerFaceColor','k');
plot(70,dV_o2(i70),'ko','MarkerSize',10,'MarkerFaceColor','k');
plot(100,dV_o2(i100),'ko','MarkerSize',10,'MarkerFaceColor','k');

xlabel('Frecuencia (kHz)');
ylabel('dV/df');

title('Comparacion de Derivacion Numerica');

legend('Orden 2',...
    'Orden 4',...
    'Puntos evaluados');

grid on;