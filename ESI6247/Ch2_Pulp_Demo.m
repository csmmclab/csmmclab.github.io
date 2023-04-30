% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Example of One-Way ANOVA

clear all
close all
clc

BC = importdata('pulp.txt');
x = BC.data;
op = BC.textdata;

%% boxplot
figure('color','w')
boxplot(x,op)
xlabel('Operator');
ylabel('Reflectance values');

%% One-Way ANOVA
[p,tbl,stats] = anova1(x,op,'off');
tbl(3,1) = {'Residual'};
fprintf('One-Way ANOVA, pulp experiment\n\n');
disp(tbl);

%% Multiple Comparisons 'bonferroni method'
csubset = nchoosek(1:4,2);
fprintf('Multiple comparison t statistics, pulp experiment');
fprintf('\n')
for i = 1: length(csubset)
    fprintf('%10s  %10.2f',strcat(stats.gnames{csubset(i,1)},' vs. ',stats.gnames{csubset(i,2)}),(stats.means(csubset(i,2))-stats.means(csubset(i,1)))/(stats.s*sqrt(0.4)));
    fprintf('\n')
end

fprintf('\n Bonferroni critical value: t(N-k,alpha/k)\n');
fprintf('%8.3f',tinv(1-0.05/12,16));
fprintf('\n')

fprintf('\n Turkey critical value: q(k,N-k,alpha)/sqrt(2)\n');
fprintf('%8.3f',2.86);
fprintf('\n')

%% Residual plots
avgb = repmat(stats.means,5,1);
r = x-avgb;
figure('color','w')
plot(avgb(:),r(:),'o','MarkerFaceColor','r');
xlabel('Fitted values');
ylabel('Residuals');

avgb = repmat(stats.means,5,1);
r = x-avgb;
lop = repmat(1:4,5,1);
figure('color','w')
plot(lop(:),r(:),'o','MarkerFaceColor','r');
set(gca,'XTick',1:4);
set(gca,'XTickLabel',op);
xlim([0.8 4.2]);
xlabel('Operators');
ylabel('Residuals');

%% normalplot
res = sort(r(:));
p = ((1:20)-0.5)/20;

figure('color','w')
plot(p,res,'+','MarkerSize',10);
lsline;
xlabel('p(i)');
ylabel('r(i)');
axis([0 1 -0.5 0.6]);

phiinv = norminv(p,0,1);
figure('color','w')
plot(phiinv,res,'+','MarkerSize',10);
lsline;
xlabel('\phi^{-1}(p(i))');
ylabel('r(i)');
axis([-2.2 2.2 -0.5 0.6]);


%% standard normal distributed random number generation
nrnd = random('Normal',0,1,1,4000);

figure('color','w')
hist(nrnd,60);
xlabel('values');
ylabel('freq');
title('Histogram of standard normal distributed random numbers');

res_nr = sort(nrnd(:));
p_nr = ((1:4000)-0.5)/4000;
figure('color','w')
plot(p_nr,res_nr,'.','MarkerSize',10);
lsline;
xlabel('p(i)');
ylabel('r(i)');
title('standard normal distributed random number - p(i) vs. r(i)');

phiinv_nr = norminv(p_nr,0,1);
figure('color','w')
plot(phiinv_nr',res_nr,'.','MarkerSize',10);
lsline;
xlabel('\phi^{-1}(p(i))');
ylabel('r(i)');
title('standard normal distributed random number - \phi^{-1}(p(i)) vs. r(i)');



