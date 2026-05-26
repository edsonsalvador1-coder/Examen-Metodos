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
    0.223 0.103 0.012 -0.041 -0.057 -0.034 0.018 ...
    0.096 0.197 0.318 0.452 0.579 0.700 0.809 ...
    0.611 0.688 0.756 0.811 0.856 0.894 0.926 ...
    0.954 0.980 1.004];

Z = [182.4 178.9 175.1 171.0 166.8 162.7 158.9 155.4 ...
    152.0 149.0 146.1 145.2 145.8 147.3 149.9 153.5 ...
    158.0 163.2 168.9 174.8 180.5 186.2 191.5 196.2 ...
    200.1 203.1 205.2 206.3 206.1 204.7 198.0 194.4 ...
    190.9 187.8 185.1 183.0 181.6 180.8 180.6 180.9];

%% SPLINE CUBICO NATURAL

V41 = spline(f,V,41);
Z41 = spline(f,Z,41);

V73 = spline(f,V,73);
Z73 = spline(f,Z,73);

%% RESULTADOS

fprintf('----- SPLINE CUBICO NATURAL -----\n\n');

fprintf('V(41.0 kHz) = %.4f V\n',V41);
fprintf('|Z|(41.0 kHz) = %.4f Ohm\n\n',Z41);

fprintf('V(73.0 kHz) = %.4f V\n',V73);
fprintf('|Z|(73.0 kHz) = %.4f Ohm\n',Z73);

%% GRAFICAS

xx = linspace(min(f),max(f),1000);

figure;

subplot(2,1,1)

plot(f,V,'ko','MarkerFaceColor','k');
hold on;

plot(xx,spline(f,V,xx),'b','LineWidth',1.5);

plot(41,V41,'r*','MarkerSize',10);
plot(73,V73,'m*','MarkerSize',10);

xlabel('Frecuencia (kHz)');
ylabel('Voltaje V(f)');
title('Spline Cubico Natural - Voltaje');

legend('Datos',...
    'Spline',...
    'V(41 kHz)',...
    'V(73 kHz)');

grid on;

subplot(2,1,2)

plot(f,Z,'ko','MarkerFaceColor','k');
hold on;

plot(xx,spline(f,Z,xx),'g','LineWidth',1.5);

plot(41,Z41,'r*','MarkerSize',10);
plot(73,Z73,'m*','MarkerSize',10);

xlabel('Frecuencia (kHz)');
ylabel('|Z| (\Omega)');
title('Spline Cubico Natural - Impedancia');

legend('Datos',...
    'Spline',...
    '|Z|(41 kHz)',...
    '|Z|(73 kHz)');

grid on;