clc
clear
close all

%Parametros del sistema
global A B C D b K1 K2 tao1 tao2 tao3 tao4
A=100;
B=120;
C=1.5;
D=3.2;
b=1;
K1=150;
K2=K1;
tao1=20;
tao2=20;
tao3=600;
tao4=tao3;
x0=[25, 22, 1, 1];

% t=0:1e-3:8000;

[t,y]=ode45(@oscilador_no_lineal,[0 8000],x0);

[m1 n]=size(y);
figure
for i=1:n
    subplot(n,1,i)
    
    plot(t,y(:,i))
end

figure
plot(t,y(:,1),'b',t,y(:,2),'r')
legend('y1','y2')
ylabel('Frecuencia media de disparo (Hz)')
xlabel('Tiempo(ms)')
title('Actividad oscilatoria de un circuito con inhibici�n lateral rec�proca')

figure
plot(y(:,3),y(:,1))
ylabel('y3')
xlabel('y1')
title('Espacio de estado')


function [dxdt]=oscilador_no_lineal(t,X)
    global A B C D b K1 K2 tao1 tao2 tao3 tao4
    x1=X(1);
    x2=X(2);
    x3=X(3);
    x4=X(4);
    x1p=(1/tao1)*(-x1+A*(K1-D*x2)^2/((B+b*x3)^2+(K1-D*x2)^2));
    x2p=(1/tao2)*(-x2+A*(K2-D*x1)^2/((B+b*x4)^2+(K1-D*x1)^2));
    x3p=(1/tao3)*(-x3+C*x1);
    x4p=(1/tao4)*(-x4+C*x2);
    dxdt=[x1p;x2p;x3p;x4p];

end