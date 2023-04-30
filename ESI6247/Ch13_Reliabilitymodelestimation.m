% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu
% Experiments for improving reliability from degradation data

% Reliability model estimation


clear all
close all
clc

y = xlsread('Luminosity.xlsx','regression','A2:D6');
y=log(y);

X = [1 -1 -1 -1;
    1 -1 1 1 ;
    1 1 -1 1 ;
    1 1 1 -1 ;];

y2 = y';

y3 =y2(:);
X = repmat(X,5,1);
betahat = inv(X'*X)*X'*y3;

yhat = X*betahat;
res = y3-yhat;
sigma = sqrt(sum(res.^2)/(20));
sebeta = sqrt(diag(inv(X'*X)))*sigma;

tbeta = betahat./sebeta;

p_beta = 2*(1-tcdf(abs(tbeta),20));

%% command window outputs
fprintf('\n')
fprintf('Tests, Fluorescent Lamp Experiments');
fprintf('\n\n')

fprintf('%10s','Effect');
fprintf('%10s','Estimate','S.E.','t stat','P value');
fprintf('\n')

fprintf('%10s','intercept');
fprintf('%10.4f',betahat(1),sebeta(1),tbeta(1),p_beta(1));
fprintf('\n')

fprintf('%10s','A');
fprintf('%10.4f',betahat(2),sebeta(2),tbeta(2),p_beta(2));
fprintf('\n')

fprintf('%10s','B');
fprintf('%10.4f',betahat(3),sebeta(3),tbeta(3),p_beta(3));
fprintf('\n')

fprintf('%10s','C');
fprintf('%10.4f',betahat(4),sebeta(4),tbeta(4),p_beta(4));
fprintf('\n')

