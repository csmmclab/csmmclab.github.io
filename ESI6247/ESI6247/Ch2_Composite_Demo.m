% Dr. Hui Yang
% prepared for ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Example of One-Way ANOVA with three-level quantitative factor and orthogonal polynomial

clear all
close all
clc

BC = importdata('composite.dat');
power = BC(1,:);
strength = BC(2:end,:);

%% One-way ANOVA table
[p,tbl,stats] = anova1(strength,[],'off');
tbl(3,1) = {'Residual'};
fprintf('One-Way ANOVA, composite experiment\n\n');
disp(tbl);

%% orthogonal polynomial
% linear contrast is (-1,0,1) and quadratic contrast: (1,-2,1)
% Model matrix
M = horzcat(ones(3,1),[-1;0;1]/sqrt(2),[1;-2;1]/sqrt(6));
M = repmat(M,3,1);

y = strength';
betahat = inv(M'*M)*M'*y(:);

%intercept term     31.0322222
%linear contrast    8.6361308
%quadratic contrast -0.3810317

res = y(:)-M*betahat;

% MSE
sigma = sqrt(sum(res.^2)/(9-3));
% 3.147

% standard error of coefficients, including intercept
sebeta = sqrt(diag(inv(M'*M)))*sigma;

% t statistic
tbeta = betahat./sebeta;

% two-sided test for intercept: tstat=29.5826
p_intercept = 2*(1-tcdf(tbeta(1),9-3));

% p values for linear and quadratic effects
% two-sided test for linear effect: tstat=4.753164
p_linear_contrast = 2*(1-tcdf(tbeta(2),9-3));

% two-sided test for quadratic effect: tstat=-0.2097
p_quadratic_contrast = 2*(tcdf(tbeta(3),9-3));

% please notice the difference in p value cacluations 
% because of positive and negative t statistic


%% command window outputs
fprintf('\n')
fprintf('Tests for Polynomial Effects, Composite Experiments');
fprintf('\n\n')

fprintf('%10s','Effect');
fprintf('%10s','Estimate','S.E.','t stat','P value');
fprintf('\n')

fprintf('%10s','Intercept');
fprintf('%10.4f',betahat(1),sebeta(1),tbeta(1),p_intercept);
fprintf('\n')

fprintf('%10s','Linear');
fprintf('%10.4f',betahat(2),sebeta(2),tbeta(2),p_linear_contrast);
fprintf('\n')

fprintf('%10s','Quadratic');
fprintf('%10.4f',betahat(3),sebeta(3),tbeta(3),p_quadratic_contrast);
fprintf('\n')

