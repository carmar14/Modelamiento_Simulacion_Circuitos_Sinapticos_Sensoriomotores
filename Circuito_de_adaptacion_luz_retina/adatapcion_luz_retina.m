clc
clear
close all

%Parametros del sistema
global  tao1 tao2 tao3 tao4 L
tao1=10;
tao2=100;
tao3=80;
tao4=4000;
L=0.4;

x0=[0 0 0 0 0 0];

% t=0:1e-3:8000;

[t,y]=ode45(@luz_retina,[0 1000],x0);

[m1 n]=size(y);
figure
for i=1:n
    subplot(n,1,i)
    
    plot(t,y(:,i))
end

figure
plot(t,y(:,6),'b')
legend('y6')
ylabel('Nivel de actividad de la unidad G')
xlabel('Tiempo(ms)')
title('Mecanismo de adaptacion a la luz en la retina')

function [dxdt]=luz_retina(t,X)
    global  tao1 tao2 tao3 tao4 L
    
    C=X(1);
    H=X(2);
    B=X(3);
    A=X(4);
    P=X(5);
    G=X(6);
    
    x1p=(1/tao1)*(-C-P*H+L);
    x2p=(1/tao2)*(-H+C);
    x3p=(1/tao1)*(-B+(6*C-5*H)/(1+9*A));
    x4p=(1/tao3)*(-A+B);
    x5p=(1/tao4)*(-P+0.1*A);
    x6p=(1/tao1)*(-G+50*B/(13+B));
    
    dxdt=[x1p;x2p;x3p;x4p;x5p;x6p];

end