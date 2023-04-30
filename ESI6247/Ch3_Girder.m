% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Chapter 3 Girder experiment - Randomized block design

clear all
close all
clc

BC = importdata('girder.dat');
y = BC.data;

[b,k] = size(y);

%% ANOVA table (randomized block design (block size 2 - sewage experiment)
eta = mean(y(:));

% block sum of squares
SSB = 0;
yim = mean(y');
for i = 1:b
    SSB = SSB+k*(yim(i)-eta).^2;
end

% treatment sum of squares
SSTr = 0;
yjm = mean(y);
for i = 1:k
    SSTr = SSTr+b*(yjm(i)-eta)^2;
end

% total sum of squares
SSTotal = sum((y(:)-eta).^2);

% Residual sum of squares
SSR = SSTotal-SSTr-SSB;

% Print ANOVA output
fprintf('\n')
fprintf('ANOVA Table (randomized block design), girder experiments');
fprintf('\n\n')

fprintf('%10s','Source','DoF', 'Sum sq','Mean sq', 'F','Prob>F');
fprintf('\n')

fprintf('%10s','Grider');
fprintf('%10.4f',b-1,SSB,SSB/(b-1),SSB*(k-1)/SSR,1-fcdf(SSB*(k-1)/SSR,b-1,(b-1)*(k-1)));
fprintf('\n')

fprintf('%10s','Method');
fprintf('%10.4f',k-1,SSTr,SSTr/(k-1),SSTr*(b-1)/SSR,1-fcdf(SSTr*(b-1)/SSR,k-1,(b-1)*(k-1)));
fprintf('\n')

fprintf('%10s','Residual');
fprintf('%10.4f',(b-1)*(k-1),SSR,SSR/((b-1)*(k-1)));
fprintf('\n')

fprintf('%10s','Total');
fprintf('%10.4f',b*k-1,SSTotal);
fprintf('\n\n\n')
s = sqrt(SSR/((b-1)*(k-1)));

%% Multiple Comparisons 'bonferroni method'
gnames = BC.textdata;
csubset = nchoosek(1:4,2);
fprintf('Multiple comparison t statistics, girder experiment');
fprintf('\n')
for i = 1: length(csubset)
    fprintf('%15s  %10.2f',strcat(gnames{csubset(i,1)},' vs. ',gnames{csubset(i,2)}),(mean(y(:,csubset(i,2)))-mean(y(:,csubset(i,1))))/(s*sqrt(2/b)));
    fprintf('\n')
end

fprintf('\n Bonferroni critical value: t((b-1)*(k-1),alpha/kk)\n');
fprintf('%8.3f',tinv(1-0.05/12,24));
fprintf('\n')

fprintf('\n Turkey critical value: q(k,(b-1)*(k-1),alpha)/sqrt(2)\n');
fprintf('%8.3f',2.758);
fprintf('\n')

