% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu


clear all
close all
clc

BC = importdata('Pollution.dat');
x = [BC.data(:,1:4), BC.data(:,6:15)];
x(:,12) = log10(x(:,12)); % HCpot
x(:,13) = log10(x(:,13)); % NOxPot
x(:,14) = log10(x(:,14)); % SO2Pot
y = BC.data(:,5);

x = [x(1:20,:);x(22:end,:)];
y = [y(1:20,:);y(22:end,:)];

%% Scatter Plots of mortality against selected predictors
figure('color','w')
subplot(2,2,1)
plot(x(:,1),y,'.'); xlabel('JanTemp'); ylabel('Mortality');

subplot(2,2,2)
plot(x(:,5),y,'.'); xlabel('Education'); ylabel('Mortality');

subplot(2,2,3)
plot(x(:,7),y,'.'); xlabel('NonWhite'); ylabel('Mortality');

subplot(2,2,4)
plot(x(:,13),y,'.'); xlabel('Log(NOxPot)'); ylabel('Mortality');

%% linear regression coefficients
stats = regstats(y,x);

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
fprintf('%10.2f',f.dfr,f.ssr,f.ssr/f.dfr,f.f,f.pval);
fprintf('\n')

fprintf('%6s','Resid');
fprintf('%10.2f',f.dfe,f.sse,f.sse/f.dfe);
fprintf('\n')

fprintf('%6s','Total');
fprintf('%10.2f',f.dfe+f.dfr,f.sse+f.ssr);
fprintf('\n\n\n')


%% stepwise regression
stepwisefit(x,y,...
            'penter',0.15,'premove',0.15);
        
        
%% F-to-remove
stepwise(x,y,1:14,0.15,0.15);

%% F-to-enter
stepwise(x,y,[],0.15,0.15)