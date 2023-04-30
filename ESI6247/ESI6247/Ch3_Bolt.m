% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Chapter 3 Bolt experiment - Two way ANOVA

clear all
close all
clc

y = xlsread('bolt.xlsx','bolt','A2:C21');

%% ANOVA table (bolt experiment - two way ANOVA)
[p,tbl,stats] = anova2(y,10,'off');
tbl(2,1) = {'Plating'};
tbl(3,1) = {'Test'};
tbl(5,1) = {'Residual'};
temp = tbl(2,:);
tbl(2,:) = tbl(3,:);
tbl(3,:) = temp;
disp(tbl);

%% A regression modeling approach

X = [1 0 0 0 0 0;
    1 0 1 0 0 0;
    1 0 0 1 0 0;
    1 1 0 0 0 0;
    1 1 1 0 1 0;
    1 1 0 1 0 1;];
y11 = y(1:10,1);
y12 = y(1:10,2);
y13 = y(1:10,3);
y21 = y(11:20,1);
y22 = y(11:20,2);
y23 = y(11:20,3);

CY = [y11,y12,y13,y21,y22,y23]';

CY =CY(:);
X = repmat(X,10,1);
betahat = inv(X'*X)*X'*CY;

yhat = X*betahat;
res = CY-yhat;
sigma = sqrt(sum(res.^2)/(60-6));
sebeta = sqrt(diag(inv(X'*X)))*sigma;

tbeta = betahat./sebeta;

p_beta = 2*(1-tcdf(abs(tbeta),60-6));

%% command window outputs
fprintf('\n')
fprintf('Tests, Bolt Experiments');
fprintf('\n\n')

fprintf('%10s','Effect');
fprintf('%10s','Estimate','S.E.','t stat','P value');
fprintf('\n')

fprintf('%10s','eta');
fprintf('%10.4f',betahat(1),sebeta(1),tbeta(1),p_beta(1));
fprintf('\n')

fprintf('%10s','alpha2');
fprintf('%10.4f',betahat(2),sebeta(2),tbeta(2),p_beta(2));
fprintf('\n')

fprintf('%10s','beta2');
fprintf('%10.4f',betahat(3),sebeta(3),tbeta(3),p_beta(3));
fprintf('\n')

fprintf('%10s','beta3');
fprintf('%10.4f',betahat(4),sebeta(4),tbeta(4),p_beta(4));
fprintf('\n')

fprintf('%10s','w22');
fprintf('%10.4f',betahat(5),sebeta(5),tbeta(5),p_beta(5));
fprintf('\n')

fprintf('%10s','w23');
fprintf('%10.4f',betahat(6),sebeta(6),tbeta(6),p_beta(6));
fprintf('\n')

%% residual plots
figure('color','w')
boxplot([y11-mean(y11),y12-mean(y12),y13-mean(y13),...
    y21-mean(y21),y22-mean(y22),y23-mean(y23)],...
    {'B-C&W', 'B-HT', 'B-P&O', 'M-C&W', 'M-HT','M-P&O'});
title('Box-whisker plots of residuals, Bolt experiment');
