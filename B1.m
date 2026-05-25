clc
clear
close all

warning off

%=========================
%DATOS
%=========================

f=[100 120 145 170 200 235 270 310 355 405 ...
460 520 585 655 730 810 895 985 1080 1180 ...
1290 1410 1540 1680 1830 1990 2160 2340 ...
2530 2730];

Z=[152.3 149.1 146.8 144.9 142.0 139.5 137.9 ...
136.1 134.8 133.6 132.7 131.9 131.4 131.1 ...
130.9 131.0 131.3 131.9 132.7 133.8 135.2 ...
136.9 138.9 141.1 143.5 146.1 149.0 152.2 ...
155.6 159.2];

n=length(f);

%MUCHOS puntos
x=linspace(100,2730,50000);

%%=========================
%POLINOMIO MATRICIAL
%%=========================

p29=polyfit(f,Z,29);

y29=polyval(p29,x);

%%=========================
%LAGRANGE
%%=========================

yLag=zeros(size(x));

for k=1:length(x)

    suma=0;

    for i=1:n

        L=1;

        for j=1:n

            if i~=j

                L=L*((x(k)-f(j))/(f(i)-f(j)));

            end

        end

        suma=suma+Z(i)*L;

    end

    yLag(k)=suma;

end

%%=========================
%FIGURA
%%=========================

figure

set(gcf,'color',[0.94 0.94 0.94])

hold on

%MATRICIAL
plot(x,y29,...
    'Color',[0.8500 0.3250 0.0980],...
    'LineWidth',2)

%LAGRANGE
plot(x,yLag,...
    '--',...
    'Color',[0.4660 0.6740 0.1880],...
    'LineWidth',1.3)

%DATOS
plot(f,Z,'o',...
    'MarkerFaceColor',[0 0.4470 0.7410],...
    'MarkerEdgeColor','k',...
    'MarkerSize',6)

grid on

ax=gca;

ax.GridLineStyle=':';

xlabel('Frecuencia f (Hz)','FontSize',11)

ylabel('Magnitud de Impedancia |Z| (\Omega)',...
       'FontSize',11)

title('Comparacion de Interpolacion Global de Grado 29',...
      'FontWeight','bold')

legend('Polinomio Matricial (Grado 29)',...
       'Polinomio de Lagrange (Grado 29)',...
       'Datos experimentales originales',...
       'Location','south')

%MUY IMPORTANTE
ylim([-5.5e6 4e6])

warning on