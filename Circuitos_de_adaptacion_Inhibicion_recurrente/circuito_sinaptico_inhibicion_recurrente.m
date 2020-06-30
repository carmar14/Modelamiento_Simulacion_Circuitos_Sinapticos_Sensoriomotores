clc
clear
close all

%Parametros del sistema
global  tao1 tao2 L
tao1=10;
tao2=400;
L=10;

x0=[0, 0];

% t=0:1e-3:8000;

[t,y]=ode45(@inhibicion_recurrente,[0 1000],x0);

[m1 n]=size(y);
figure
for i=1:n
    subplot(n,1,i)
    
    plot(t,y(:,i))
end

figure
plot(t,y(:,1),'b',t,y(:,2),'r')
legend('y1','y2')
ylabel('Nivel de actividad de las unidades')
xlabel('Tiempo(ms)')
title('Mecanismo de adaptacion')

function [dxdt]=inhibicion_recurrente(t,X)
    global  tao1 tao2 L
    
    x1=X(1);
    x2=X(2);
    
    x1p=(1/tao1)*(-x1+L/(1+x2));
    x2p=(1/tao2)*(-x2+x1);
    
    dxdt=[x1p;x2p];

end