clc
clear
close all

%Parametros del sistema
global  tao omega N L k
tao=10;
N=24;
k=1;
omega=0:15:360-15;
t=0:0.1:100;

x0=zeros(1,N);
L=randi([1 5],24);
L=L(1,:);
L=ones(1,24);

% t=0:1e-3:8000;

[t,y]=ode45(@suma,t,x0);

[m1 n]=size(y);
figure
% for i=1:n
%     subplot(n,1,i)
%     
%     plot(t,y(:,i))
% end

plot(t,y(:,1))
% figure
% plot(t,y(:,1),'b',t,y(:,2),'r')
% legend('Objetivo','Distractores')
% ylabel('Nivel de actividad de las neuronas')
% xlabel('Tiempo(ms)')
% title('Busqueda visual con diferentes distractores')

function [dxdt]=suma(t,X)
global  tao omega N L

for i=1:N
    R(i)=X(i);
end

s1=0;
s2=0;
c=1;
for i=1:N
    for j=(omega(i)-90):15:(omega(i)+90)
        theta=j;
        if j<0
            theta=j+360;
        end
        
        if j>345
            theta=j-345;
        end
        k=find(omega==theta);
        a(c)=k;
        c=c+1;
%         cosd(omega(i)-theta)
        s1=s1+L(k)*cosd(omega(i)-theta);
    end
    
    c=1;
%     a
    %     for o=1:length(a)
    for l=1:N
        
        if a(1)~=l && a(2)~=l && a(3)~=l && a(4)~=l && a(5)~=l && a(6)~=l && a(7)~=l && a(8)~=l && a(9)~=l && a(10)~=l && a(11)~=l && a(12)~=l && a(13)~=l
%             l
            s2=s2+R(l);
        end
    end
    
    %     end
    
    Rp(i)=(-R(i)+s1-k*s2)/tao;
end
dxdt=[Rp]';

end