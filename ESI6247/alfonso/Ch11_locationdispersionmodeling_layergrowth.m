% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Location and dispersion modeling - layer growth experiment


clear all
close all
clc

x = xlsread('layergrowthcrossarray.xlsx','A3:H18');
thick = xlsread('layergrowthcrossarray.xlsx','I3:P18');


%% factorial effects, adapted epitaxial layer growth experiment

int2 = nchoosek(1:8,2);
for i = 1:length(int2)
    x(:,8+i) = x(:,int2(i,1)).*x(:,int2(i,2));
end
Sign=x;

for i=1:16
  ybar(i,1)= mean(thick(i,:));
  s2(i,1)=var(thick(i,:));
end

ls2=log(s2);
ybar2=(ybar.*ybar);
lybar2=log(ybar2);
n=lybar2-ls2;
neg=zeros(8,15);
neglog=neg;
pos=zeros(8,15);
poslog=pos;
negcount=zeros(1,15);
poscount=zeros(1,15);
for i=1:16
    for j=1:15
        if Sign(i,j)<0
            negcount(j)=negcount(j)+1;
            neg(negcount(j),j)=neg(negcount(j),j)+ybar(i);
            neglog(negcount(j),j)=neglog(negcount(j),j)+ls2(i);
        else
            poscount(j)=poscount(j)+1;
            pos(poscount(j),j)=pos(poscount(j),j)+ybar(i);
            poslog(poscount(j),j)=poslog(poscount(j),j)+ls2(i);
        end  
        
    end
   
end

for i=1:15
ybareffect(i,1)=mean(pos(:,i))-mean(neg(:,i));
ls2effect(i,1)=mean(poslog(:,i))-mean(neglog(:,i));
end
ymbeta=[ybareffect];
lns2beta=[ls2effect];


fprintf('\n')
fprintf('Factorial effects , original epitaxial layer growth experiment');
fprintf('\n\n')

fprintf('%14s','yi','lnsi2','lnyi','ni');
fprintf('\n');
for i=1:16
  fprintf('%14.3f',ybar(i),ls2(i),lybar2(i),n(i));
  fprintf('\n');
end

 
fprintf('\n\n');
effectname = {'A','B','C','D','E','F','G','H','AB','AC','AD','AE','AF','AG','AH'}';
fprintf('%15s','Effect','Y-mean','lns2');
fprintf('\n');


for i = 1:15
    fprintf('%15s',char(effectname(i)));
    fprintf('%14.3f',ymbeta(i),lns2beta(i));
    fprintf('\n');
end


%% Half-normal plot of location effects

absymbeta = abs(ymbeta);
[theta,idx] = sort(absymbeta);
p = 0.5+(0.5*(1:length(ymbeta))-0.5)/length(ymbeta);
phiinv = norminv(p,0,1);
figure('color','w')
plot(phiinv,theta,'.','MarkerSize',10);
for i = 12:15
     text(phiinv(i)+0.01,theta(i)-0.0003,effectname(idx(i)));
end
xlabel('\phi^{-1}(p(i))');
ylabel('absolute effects');
title('Half-normal plot of location effects');
axis([-0.02 2.5 -0.01 0.9]);
%% Half-normal plot of dispersion effects

abslns2beta = abs(lns2beta);
[theta,idx] = sort(abslns2beta);
p = 0.5+(0.5*(1:length(lns2beta))-0.5)/length(lns2beta);
phiinv = norminv(p,0,1);
figure('color','w')
plot(phiinv,theta,'.','MarkerSize',10);
for i = 12:15
    text(phiinv(i),theta(i)-0.003,effectname(idx(i)));
end
xlabel('\phi^{-1}(p(i))');

ylabel('absolute effects');

title('Half-normal plot of dispersion effects');

axis([-0.2 2.5 0 2]);



