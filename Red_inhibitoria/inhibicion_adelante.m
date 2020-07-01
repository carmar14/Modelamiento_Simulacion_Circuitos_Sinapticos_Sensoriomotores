clc
clear
close all

%Parametros del sistema
global  tao M a r b c sigma
tao=10;
a=1;
b=1;
c=1;
sigma=30;
M=300;

x0=[0 0 0 0 0];

% t=0:1e-3:8000;

[t,y]=ode45(@inhibicion,[0 1000],x0);

[m1 n]=size(y);
figure
for i=1:n
    subplot(n,1,i)
    
    plot(t,y(:,i))
end

figure
plot(t,y(:,1),'r',t,y(:,2),'.g',t,y(:,3),'k',t,y(:,4),':b',t,y(:,5),'m')
legend('y1','y2','y3','y4','y5')
ylabel('Respuestas de las neuronas')
xlabel('Tiempo(ms)')
title('Red inhibitoria')

function [dxdt]=inhibicion(t,X)
    global  tao M a r b c sigma
    ran=20+(10).*rand(1,1);
    if t>=100 && t<=200 || t>=400 && t<=600
        r=ran;
    else
        r=0;
    end
    
    E1=X(1);
    E2=X(2);
    E3=X(3);
    E4=X(4);
    E5=X(5);
    
    
    x1p=(1/tao)*(-E1+r);
    x2p=(1/tao)*(-E2+a*E1);
    x3p=(1/tao)*(-E3+M*(b*E1-c*E2)^2/(sigma^2+(b*E1-c*E2)^2))*((b*E1-c*E2)>0);
    x4p=(1/tao)*(-E4+a*E1);
    x5p=(1/tao)*(-E5+M*(b*E4-c*E1)^2/(sigma^2+(b*E4-c*E1)^2))*((b*E4-c*E1)>0);
    
    
    dxdt=[x1p;x2p;x3p;x4p;x5p];

end