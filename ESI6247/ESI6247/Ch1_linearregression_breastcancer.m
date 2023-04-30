% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

clear all
close all
clc

BC = importdata('BreastCancerMortality.dat');
data = [BC.data(1:2,:), BC.data(3:4,:)]';
M = data(:,1);
T = data(:,2);

%% linear regression plot - with outlier (T=31.8, M=67.3)
figure('color','w')
plot(T,M,'*');
lsline
mu = mean(M);
hline = refline([0 mu]);
set(hline,'Color','r')
xlabel('Temperature');
ylabel('Mortality Index');

%% linear regression coefficients
stats = regstats(M,T);

t = stats.tstat;
CoeffTable = dataset({t.beta,'Coef'},{t.se,'StdErr'}, ...
                     {t.t,'tStat'},{t.pval,'pVal'})
fprintf('%6s','R Square and Adj R square');
fprintf('%10.4f',stats.rsquare*100, stats.adjrsquare*100);
fprintf('\n')
              
                 
%% linear regression anova table                 
f = stats.fstat;
fprintf('\n')
fprintf('Regression ANOVA');
fprintf('\n\n')

fprintf('%6s','Source');
fprintf('%10s','df','SS','MS','F','P');
fprintf('\n')

fprintf('%6s','Regr');
fprintf('%10.4f',f.dfr,f.ssr,f.ssr/f.dfr,f.f,f.pval);
fprintf('\n')

fprintf('%6s','Resid');
fprintf('%10.4f',f.dfe,f.sse,f.sse/f.dfe);
fprintf('\n')

fprintf('%6s','Total');
fprintf('%10.4f',f.dfe+f.dfr,f.sse+f.ssr);
fprintf('\n')


%% outlier detection
figure('color','w')
plot(stats.standres,'ro-');
ylabel('standardized residual (R)');
xlabel('index');
title('outlier detection from standardized residual (R)');

figure('color','w')
plot(stats.leverage,'ro-');
ylabel('leverage (X)');
xlabel('index');
title('outlier detection from leverage (X)');

[M, T]

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = [data(1:14,1); data(16,1)];
T = [data(1:14,2); data(16,2)];

%% linear regression plot - without outlier (T=31.8, M=67.3)
figure('color','w')
plot(T,M,'*');
lsline
mu = mean(M);
hline = refline([0 mu]);
set(hline,'Color','r')
xlabel('Temperature');
ylabel('Mortality Index');

%% linear regression coefficients
stats = regstats(M,T);

t = stats.tstat;
CoeffTable = dataset({t.beta,'Coef'},{t.se,'StdErr'}, ...
                     {t.t,'tStat'},{t.pval,'pVal'})
fprintf('%6s','R Square and Adj R square');
fprintf('%10.4f',stats.rsquare*100, stats.adjrsquare*100);
fprintf('\n')
              
                 
%% linear regression anova table                 
f = stats.fstat;
fprintf('\n')
fprintf('Regression ANOVA');
fprintf('\n\n')

fprintf('%6s','Source');
fprintf('%10s','df','SS','MS','F','P');
fprintf('\n')

fprintf('%6s','Regr');
fprintf('%10.4f',f.dfr,f.ssr,f.ssr/f.dfr,f.f,f.pval);
fprintf('\n')

fprintf('%6s','Resid');
fprintf('%10.4f',f.dfe,f.sse,f.sse/f.dfe);
fprintf('\n')

fprintf('%6s','Total');
fprintf('%10.4f',f.dfe+f.dfr,f.sse+f.ssr);
fprintf('\n')


%% Residual Plots After Outlier Removal
figure('color','w')
plot(stats.yhat,stats.r,'o');
hline = refline([0 0]);
set(hline,'Color','r')
xlabel('Fitted values');
ylabel('Residuals');

figure('color','w')
plot(T,stats.r,'o');
hline = refline([0 0]);
set(hline,'Color','r')
xlabel('Temperature');
ylabel('Residuals');
