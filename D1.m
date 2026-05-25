clc; clear; close all;

%% =========================
% 1. DATOS EXPERIMENTALES
%% =========================
f = [100 120 145 170 200 235 270 310 355 405 460 520 585 655 730 ...
     810 895 985 1080 1180 1290 1410 1540 1680 1830 1990 2160 ...
     2340 2530 2730];

Z = [152.3 149.1 146.8 144.9 142.0 139.5 137.9 136.1 134.8 133.6 ...
     132.7 131.9 131.4 131.1 130.9 131.0 131.3 131.9 132.7 133.8 ...
     135.2 136.9 138.9 141.1 143.5 146.1 149.0 152.2 155.6 159.2];

Zth = 150;

%% =========================
% 2. SPLINE CÚBICO
%% =========================
pp = spline(f, Z);
g = @(x) ppval(pp,x) - Zth;

%% =========================
% 3. RAÍCES (BISECCIÓN)
%% =========================
roots_bis = [];

for i = 1:length(f)-1
    if g(f(i))*g(f(i+1)) < 0
        a = f(i); b = f(i+1);

        for k = 1:50
            c = (a+b)/2;

            if g(a)*g(c) < 0
                b = c;
            else
                a = c;
            end
        end

        roots_bis(end+1) = (a+b)/2;
    end
end

%% =========================
% 4. NEWTON-RAPHSON
%% =========================
pp_der = fnder(pp);
roots_nr = roots_bis;

for i = 1:length(roots_nr)

    x = roots_nr(i);

    for k = 1:5
        x = x - (ppval(pp,x)-Zth)/ppval(pp_der,x);
    end

    roots_nr(i) = x;
end

%% =========================
% 5. RESULTADOS
%% =========================
fprintf('\n===== RESULTADOS =====\n');

fprintf('Raíces (Spline/Bisección):\n');
disp(roots_bis');

fprintf('Raíces (Newton-Raphson):\n');
disp(roots_nr');

fprintf('\nBanda de operación segura:\n');
fprintf('[%.4f ; %.4f] Hz\n', roots_nr(1), roots_nr(2));

%% =========================
% 6. SENSIBILIDAD (≈2000 Hz)
%% =========================
f0 = 2000;

dZdf = ppval(pp_der, f0);   % d|Z|/df
sensibilidad = 1/dZdf;      % df/d|Z|

fprintf('\nSensibilidad en 2000 Hz:\n');
fprintf('d|Z|/df = %.4f Ohm/Hz\n', dZdf);
fprintf('df/d|Z| = %.4f Hz/Ohm\n', sensibilidad);

%% =========================
% 7. GRÁFICA
%% =========================
ff = linspace(100,2730,600);

figure;
plot(ff, ppval(pp,ff), 'b','LineWidth',1.6); hold on;
yline(Zth,'r--','Z_{th}=150');

scatter(roots_bis, Zth*ones(size(roots_bis)),80,'ko','filled');

grid on;
xlabel('Frecuencia (Hz)');
ylabel('|Z| (Ohm)');
title('Spline cúbico y puntos de cruce con el umbral');
legend('|Z(f)|','Umbral 150 Ω','Raíces');
