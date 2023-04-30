% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu
% Chapter 4 Revisit original Epitaxial Layer Growth Experiment - Full Factorial Experiment

clear all
close all
clc

x = xlsread('originallayer.xlsx','B1:E16');
thick = xlsread('originallayer.xlsx','F1:K16');
ym = mean(thick')';
lns2 = log(var(thick')');


%% factorial effects, original epitaxial layer growth experiment
int2 = nchoosek(1:4,2);
int3 = nchoosek(1:4,3);
for i = 1:length(int2)
    x(:,4+i) = x(:,int2(i,1)).*x(:,int2(i,2));
end
for i = 1:length(int3)
    x(:,10+i) = x(:,int3(i,1)).*x(:,int3(i,2)).*x(:,int3(i,3));
end
x(:,15) = x(:,1).*x(:,2).*x(:,3).*x(:,4);
stats = regress(ym,x);
ymbeta = stats.*2;
stats = regress(lns2,x);
lns2beta = stats.*2;
effectname = {'A','B','C','D','AB','AC','AD','BC','BD','CD','ABC','ABD','ACD','BCD','ABCD'}';

%% command window outputs
fprintf('\n')
fprintf('Factorial effects, original epitaxial layer growth experiment');
fprintf('\n\n')

fprintf('%15s','Effect','Y-mean','lns2');
fprintf('\n');
for i = 1:length(ymbeta)
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
for i = 13:15
    text(phiinv(i)+0.03,theta(i)-0.003,effectname(idx(i)));
end
xlabel('half-normal quantiles');
ylabel('absolute effects');
title('Half-normal plot of location effects');
axis([-0.2 2.5 -0.01 0.9]);


%% Half-normal plot of dispersion effects
abslns2beta = abs(lns2beta);
[theta,idx] = sort(abslns2beta);
p = 0.5+(0.5*(1:length(lns2beta))-0.5)/length(lns2beta);
phiinv = norminv(p,0,1);
figure('color','w')
plot(phiinv,theta,'.','MarkerSize',10);
for i = 13:15
    text(phiinv(i)+0.03,theta(i)-0.03,effectname(idx(i)));
end
xlabel('half-normal quantiles');
ylabel('absolute effects');
title('Half-normal plot of dispersion effects');
axis([-0.2 2.5 -0.2 4]);


%% Lenth's method, |tPSE| values
absymbeta = abs(ymbeta);
abslns2beta = abs(lns2beta);
s0ym = 1.5*median(absymbeta);
s0lns2 = 1.5*median(abslns2beta);
PSEym = 1.5*median(absymbeta(find(absymbeta<2.5*s0ym)));
PSElns2 = 1.5*median(abslns2beta(find(abslns2beta<2.5*s0lns2)));

t_pse_ym = ymbeta./PSEym;
t_pse_lns2 = lns2beta./PSElns2;

%% command window outputs
fprintf('\n')
fprintf('Lenth method, |tPSE| values, adapted epitaxial layer growth experiment');
fprintf('\n\n')

fprintf('%15s','Effect','Y-mean','lns2');
fprintf('\n');
for i = 1:length(ymbeta)
    fprintf('%15s',char(effectname(i)));
    fprintf('%14.3f',abs(t_pse_ym(i)),abs(t_pse_lns2(i)));
    fprintf('\n');
end

