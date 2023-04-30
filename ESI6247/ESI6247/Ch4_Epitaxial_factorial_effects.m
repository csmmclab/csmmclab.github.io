% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Chapter 4 Epitaxial Experiment - Full Factorial Experiment

clear all
close all
clc

x = xlsread('adaptedlayer.xlsx','adaptedlayer','B1:E16');
thick = xlsread('adaptedlayer.xlsx','adaptedlayer','F1:K16');
ym = mean(thick')';
lns2 = log(var(thick')');


%% factorial effects, adapted epitaxial layer growth experiment
int2 = nchoosek(1:4,2);
int3 = nchoosek(1:4,3);
for i = 1:length(int2)
    x(:,4+i) = x(:,int2(i,1)).*x(:,int2(i,2));
end
for i = 1:length(int3)
    x(:,10+i) = x(:,int3(i,1)).*x(:,int3(i,2)).*x(:,int3(i,3));
end
x(:,15) = x(:,1).*x(:,2).*x(:,3).*x(:,4);

%% Factorial effects calculation using classical approach
for i = 1:15
    ymfaceff(i) = sum(x(:,i).*ym)/8;
    lns2faceff(i) = sum(x(:,i).*lns2)/8;
end
%% command window outputs
fprintf('\n')
fprintf('Factorial effects (classical approach), adapted epitaxial layer growth experiment');
fprintf('\n\n')

effectname = {'A','B','C','D','AB','AC','AD','BC','BD','CD','ABC','ABD','ACD','BCD','ABCD'}';

fprintf('%15s','Effect','Y-mean','lns2');
fprintf('\n');
for i = 1:15
    fprintf('%15s',char(effectname(i)));
    fprintf('%14.3f',ymfaceff(i),lns2faceff(i));
    fprintf('\n');
end

%% Factorial effects calculation using Regression modeling approach
stats = regress(ym,x);
ymbeta = stats.*2;
stats = regress(lns2,x);
lns2beta = stats.*2;

%% command window outputs
fprintf('\n')
fprintf('Factorial effects (regression modeling), adapted epitaxial layer growth experiment');
fprintf('\n\n')

effectname = {'A','B','C','D','AB','AC','AD','BC','BD','CD','ABC','ABD','ACD','BCD','ABCD'}';

fprintf('%15s','Effect','Y-mean','lns2');
fprintf('\n');
for i = 1:length(ymbeta)
    fprintf('%15s',char(effectname(i)));
    fprintf('%14.3f',ymbeta(i),lns2beta(i));
    fprintf('\n');
end



