% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Chapter 3 Starch experiment - Analysis of Covariance

clear all
close all
clc

strength = xlsread('starch.xlsx','starch','B2:B50');
thickness = xlsread('starch.xlsx','starch','C2:C50');
[num,starch] = xlsread('starch.xlsx','starch','A2:A50');

%% Wu and Hamada book (model eq3.74 - page129, second edition)
y = strength; %49x1 vector
x_canna = [ones(13,1),thickness(1:13),zeros(13,2)];
x_corn = [ones(19,1),thickness(14:32),ones(19,1),zeros(19,1)];
x_potato = [ones(17,1),thickness(33:49),zeros(17,1),ones(17,1)];
x = [x_canna;x_corn;x_potato];  %49x4matrix

betahat = inv(x'*x)*x'*y; % parameter estimates: eta, gamma, tau2 tau3
res = y-x*betahat;

% MSE
sigma = sqrt(sum(res.^2)/(49-4));
% 3.147

% standard error of coefficients, including intercept
sebeta = sqrt(diag(inv(x'*x)))*sigma;

% t statistic
tbeta = betahat./sebeta; % t statistic of parameters: eta, gamma, tau2 tau3
p_tbeta = 2*(1-tcdf(abs(tbeta),49-4));
varmatrix = inv(x'*x)*sigma^2;

% calculation the parts under the dash line in Table 3.35 in page 131
se_cornpotato = sqrt(varmatrix(3,3)+varmatrix(4,4)-2*varmatrix(3,4));
t_cornpotato = (betahat(4)-betahat(3))/se_cornpotato;
p_cornpotato = 2*(1-tcdf(abs(t_cornpotato),49-4));

%% command window outputs
fprintf('\n')
fprintf('Tests, analysis of covariance - Starch Experiments');
fprintf('\n\n')

fprintf('%15s','Effect');
fprintf('%10s','Estimate','S.E.','t stat','P value');
fprintf('\n')

fprintf('%15s','Intercept');
fprintf('%10.2f',betahat(1),sebeta(1),tbeta(1),p_tbeta(1));
fprintf('\n')

fprintf('%15s','Thickness');
fprintf('%10.2f',betahat(2),sebeta(2),tbeta(2),p_tbeta(2));
fprintf('\n')

fprintf('%15s','Cannavs.Corn');
fprintf('%10.2f',betahat(3),sebeta(3),tbeta(3),p_tbeta(3));
fprintf('\n')

fprintf('%15s','Cannavs.potato');
fprintf('%10.2f',betahat(4),sebeta(4),tbeta(4),p_tbeta(4));
fprintf('\n')

fprintf('%15s','Cornvs.Potato');
fprintf('%10.2f',betahat(4)-betahat(3),se_cornpotato,t_cornpotato,p_cornpotato);
fprintf('\n')

% model I: y = eta+gamma*x+epsilon;
% Model II: y = eta+tau+gamma*x+epsilon;

stats = regstats(strength,thickness);
f = stats.fstat;
fprintf('\n\n')
fprintf('ANCOVA Table, Starch Experiment');
fprintf('\n\n')

fprintf('%10s','Source');
fprintf('%11s','df','SS','MS','F');
fprintf('\n')

fprintf('%10s','Thickness');
fprintf('%11.2f',1,f.ssr,f.ssr/1,f.ssr*45/(sum(res.^2)));
fprintf('\n')

fprintf('%10s','Starch');
fprintf('%11.2f',3-1,f.sse-sum(res.^2),(f.sse-sum(res.^2))/2,(f.sse-sum(res.^2))*45/(2*sum(res.^2)));
fprintf('\n')

fprintf('%10s','Resid');
fprintf('%11.2f',49-3-1,sum(res.^2),sum(res.^2)/45);
fprintf('\n')

fprintf('%10s','Total');
fprintf('%11.2f',48,sum((y-mean(y)).^2));
fprintf('\n')


