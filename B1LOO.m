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
% POLINOMIO GRADO 5
%% =========================

p5 = polyfit(f,Z,5);

% Malla fina
x = linspace(100,2730,5000);

y = polyval(p5,x);

%% =========================
% INTERPOLACION EN 1000 Hz
%% =========================

f_int = 1000;

Z_1000 = polyval(p5,f_int);

fprintf('Valor interpolado en 1000 Hz = %.4f ohm\n',Z_1000)

%% =========================
% VALIDACION LOO
%% =========================

% Puntos seleccionados aleatoriamente
indices = [3 15 19 24 29];

errores = zeros(size(indices));

Z_real = zeros(size(indices));
Z_interp = zeros(size(indices));

fprintf('\nVALIDACION LOO\n')

for k = 1:length(indices)

    i = indices(k);

    % Eliminar punto
    f_temp = f;
    Z_temp = Z;

    f_temp(i) = [];
    Z_temp(i) = [];

    % Nuevo polinomio grado 5
    p_temp = polyfit(f_temp,Z_temp,5);

    % Estimacion del punto eliminado
    Z_est = polyval(p_temp,f(i));

    % Error relativo
    error = abs((Z(i)-Z_est)/Z(i))*100;

    % Guardar valores
    Z_real(k) = Z(i);
    Z_interp(k) = Z_est;
    errores(k) = error;

end

% Error promedio
error_prom = mean(errores);

fprintf('\nError promedio LOO = %.4f %%\n',error_prom)

%% =========================
% TABLA DE RESULTADOS
%% =========================

tabla = table(...
    f(indices)',...
    Z_real',...
    Z_interp',...
    errores',...
    'VariableNames',...
    {'Frecuencia_Hz',...
     'Valor_Real',...
     'Valor_Interpolado',...
     'Error_Relativo_Porcentaje'});

disp(tabla)

%% =========================
% GRAFICA
%% =========================

figure

hold on

% Curva interpolada
plot(x,y,...
    'b',...
    'LineWidth',2)

% Datos experimentales
plot(f,Z,...
    'ko',...
    'MarkerFaceColor','k')

% Punto interpolado
plot(f_int,Z_1000,...
    'ro',...
    'MarkerFaceColor','r',...
    'MarkerSize',8)

grid on
box on

xlabel('Frecuencia (Hz)')
ylabel('|Z| (\Omega)')

title('Interpolacion Polinomica y Validacion LOO')

legend('Polinomio grado 5',...
       'Datos experimentales',...
       'Interpolacion en 1000 Hz',...
       'Location','best')
