% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Location and dispersion modeling - leaf spring experiment


clear all
close all
clc

x = xlsread('Ch11_leafspring.xlsx','A1:D8');
thick= xlsread('Ch11_leafspring.xlsx','E1:J8');


%% factorial effects
int2 = nchoosek(1:4,2);
for i = 1:length(int2)
    x(:,4+i) = x(:,int2(i,1)).*x(:,int2(i,2));
end
Sign=x;

for i=1:8
    ybar(i,1)= mean(thick(i,:));
    s2(i,1)=var(thick(i,:));
end

ls2=log(s2);
ybar2=(ybar.*ybar);
lybar2=log(ybar2);
n=lybar2-ls2;
neg=zeros(4,10);
neglog=neg;
pos=zeros(4,10);
poslog=pos;
negcount=zeros(1,10);
poscount=zeros(1,10);
for i=1:8
    for j=1:10
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

for i=1:10
    ybareffect(i,1)=mean(pos(:,i))-mean(neg(:,i));
    ls2effect(i,1)=mean(poslog(:,i))-mean(neglog(:,i));
end
ymbeta=[ybareffect];
lns2beta=[ls2effect];
ymbetam=[ymbeta];
ymbetam(10,:) = [];
ymbetam(9,:) = [];
ymbetam(7,:) = [];
lns2betam=[lns2beta];
lns2betam(10,:) = [];
lns2betam(9,:) = [];
lns2betam(7,:) = [];

fprintf('\n')
fprintf('Factorial effects');
fprintf('\n\n')

fprintf('%14s','yi','lnsi2','lnyi','ni');
fprintf('\n');
for i=1:8
    fprintf('%14.3f',ybar(i),ls2(i),lybar2(i),n(i));
    fprintf('\n');
end


fprintf('\n\n')
effectname = {'B','C','D','E','BC','BD','CD'}';
fprintf('%15s','Effect','Y-mean','lns2');
fprintf('\n');
for i = 1:7
    fprintf('%15s',char(effectname(i)));
    fprintf('%14.3f',ymbetam(i),lns2betam(i));
    fprintf('\n');
end




%% Half-normal plot of location effects

absymbetam = abs(ymbetam);
[theta,idx] = sort(absymbetam);
p = 0.5+(0.5*(1:length(ymbetam))-0.5)/length(ymbetam);
phiinv = norminv(p,0,1);
figure('color','w')
plot(phiinv,theta,'.','MarkerSize',10);
for i = 1:length(ymbetam)
    text(phiinv(i)+0.01,theta(i)-0.0003,effectname(idx(i)));
end
xlabel('\phi^{-1}(p(i))');
ylabel('absolute effects');
title('Half-normal plot of location effects');
axis([-0.2 2 -0.005 0.4]);
%% Half-normal plot of dispersion effects

abslns2betam = abs(lns2betam);
[theta,idx] = sort(abslns2betam);
p = 0.5+(0.5*(1:length(lns2betam))-0.5)/length(lns2betam);
phiinv = norminv(p,0,1);
figure('color','w')
plot(phiinv,theta,'.','MarkerSize',10);
for i = 1:length(lns2betam)
    text(phiinv(i),theta(i)-0.003,effectname(idx(i)));
end
xlabel('\phi^{-1}(p(i))');
ylabel('absolute effects');
title('Half-normal plot of dispersion effects');
axis([-0.2 2 -0.05 3]);



