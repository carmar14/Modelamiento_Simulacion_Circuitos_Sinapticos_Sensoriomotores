clc
clear
close all

%Parametros del sistema
global  tao K1 K2
tao=15;
K1=100;
K2=99;

x0=[11 11];

% t=0:1e-3:8000;

[t,y]=ode45(@circuito_decision,[0 400],x0);

[m1 n]=size(y);
figure
for i=1:n
    subplot(n,1,i)
    
    plot(t,y(:,i))
end

figure
plot(t,y(:,1),'b',t,y(:,2),'r')
legend('E1','E2')
ylabel('Nivel de actividad de las neuronas')
xlabel('Tiempo(ms)')
title('Mecanismo de decision por inhibicion reciproca')

function [dxdt]=circuito_decision(t,X)
    global  tao K1 K2
    
    E1=X(1);
    E2=X(2);
    
    x1p=(1/tao)*(-E1+100*(K1-3*E2)^2/(120^2+(K1-3*E2)^2));
    x2p=(1/tao)*(-E2+100*(K2-3*E1)^2/(120^2+(K2-3*E1)^2));
    
    
    dxdt=[x1p;x2p];

end