clc
clear
close all

%Parametros del sistema
global  tao ET ED N k a
tao=20;
ET=80;
ED=79.8;
N=3;
a=120;
k=3;

x0=[0 0];

% t=0:1e-3:8000;

[t,y]=ode45(@busqueda,[0 1000],x0);

[m1 n]=size(y);
figure
for i=1:n
    subplot(n,1,i)
    
    plot(t,y(:,i))
end

figure
plot(t,y(:,1),'b',t,y(:,2),'r')
legend('Objetivo','Distractores')
ylabel('Nivel de actividad de las neuronas')
xlabel('Tiempo(ms)')
title('Busqueda visual con diferentes distractores')

function [dxdt]=busqueda(t,X)
    global  tao ET ED N k a
    
    T=X(1);
    D=X(2);
    
    x1p=(1/tao)*(-T+100*(ET-k*N*D)^2/(a^2+(ET-k*N*D)^2));
    x2p=(1/tao)*(-D+100*(ED-k*(N-1)*D-k*T)^2/(a^2+(ED-k*(N-1)*D-k*T)^2));
    
    
    dxdt=[x1p;x2p];

end