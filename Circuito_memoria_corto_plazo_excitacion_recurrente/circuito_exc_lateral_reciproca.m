clc
clear
close all

%Parametros del sistema
global A B a b c tao1 tao2 S
A=100;
B=120;
a=3;
b=0.7;
c=1;
tao1=20;
tao2=4000;
S=0;

x0=[0, 0, 0, 0];

% t=0:1e-3:8000;

[t,y]=ode45(@memoria_corto_plazo,[0 18000],x0);

[m1 n]=size(y);
figure
for i=1:n
    subplot(n,1,i)
    
    plot(t,y(:,i))
end

figure
plot(t,y(:,1),'b',t,y(:,2),'--r',t,y(:,3),'k',t,y(:,4),'--g')
legend('y1','y2','y3','y4')
ylabel('Frecuencia media de disparo (Hz)')
xlabel('Tiempo(ms)')
title('Patrón de actividad de un circuito de memoria de corto plazo')




function [dxdt]=memoria_corto_plazo(t,X)
    global A B a b c tao1 tao2 S
    if t>=200 && t<=500
        S=50;
    else
        S=0;
    end
    x1=X(1);
    x2=X(2);
    x3=X(3);
    x4=X(4);
    x1p=(1/tao1)*(-x1+A*(a*x2+S)^2/((B+c*x3)^2+(a*x2+S)^2));
    x2p=(1/tao1)*(-x2+A*(S+a*x1)^2/((B+c*x4)^2+(S+a*x1)^2));
    x3p=(1/tao2)*(-x3+b*x1);
    x4p=(1/tao2)*(-x4+b*x2);
    dxdt=[x1p;x2p;x3p;x4p];

end