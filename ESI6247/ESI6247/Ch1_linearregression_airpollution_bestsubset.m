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

%% linear regression coefficients
stats = regstats(y,x(:,[1 4 5 7 13]));

t = stats.tstat;
CoeffTable = dataset({t.beta,'Coef'},{t.se,'StdErr'}, ...
                     {t.t,'tStat'},{t.pval,'pVal'})
fprintf('%6s','R Square and Adj R square');
fprintf('%10.4f',stats.rsquare*100, stats.adjrsquare*100);
fprintf('\n')

figure('color','w')
plot(stats.yhat,stats.r,'o');
hline = refline([0 0]);
set(hline,'Color','r')
xlabel('Fitted values');
ylabel('Residuals');
              
                 
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

%% Best subset regression
stats = regstats(y,x);
msetotl = stats.mse;

warning off all
%% linear regression coefficients
fprintf('\n')
fprintf('Best Subsets Regression');
fprintf('\n\n')
for subsetsize = 4:8
    csubset = nchoosek(1:14,subsetsize);
    [m,n] = size(csubset);
    cp = [];
    for i = 1:m
        stats = regstats(y,x(:,csubset(i,:)));
        cp(i) = stats.fstat.sse/msetotl-59+2*(subsetsize+1);
    end
    [cpmin,idx_cpmin] = min(cp);
    stats = regstats(y,x(:,csubset(idx_cpmin,:)));
    
    fprintf('%10s','Vars');
    fprintf('%10s','R-Sq','RSqa','C-p','BIC','AIC','s');
    fprintf('\n')
    
    rsq = stats.rsquare*100;
    rsqadj = stats.adjrsquare*100;
    cp = stats.fstat.sse/msetotl-59+2*(subsetsize+1);
    bic = 59*log(stats.fstat.sse/59)+(subsetsize+1)*log(59);
    aic = 59*log(stats.fstat.sse/59)+(subsetsize+1)*2;
    
    fprintf('%10.1f',subsetsize);
    fprintf('%10.2f',rsq,rsqadj,cp,bic,aic,sqrt(stats.mse));
    fprintf('\n')
    fprintf('%10s','variables');
    disp(csubset(idx_cpmin,:));
    fprintf('\n')
    
end



