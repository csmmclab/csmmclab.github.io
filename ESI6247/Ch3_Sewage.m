% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Chapter 3 Sewage experiment - paired comparison design vs. unpaired
% comparison design

clear all
close all
clc

BC = importdata('sewage.dat');
y1 = BC.data(:,2);
y2 = BC.data(:,3);

N = length(y1);
d = y2-y1;

t_paired = sqrt(N)*mean(d)/std(d);
t_unpaired = (mean(y2)-mean(y1))/sqrt(var(y2)/N+var(y1)/N);

% p value calculation (two-sided test) for paired t test
p_paired = 2*(1-tcdf(t_paired,8-1));

% p value calculation (two-sided test) for unpaired t test
p_unpaired = 2*(1-tcdf(t_unpaired,16-2));


fprintf('\n')
fprintf('p value calculation, sewage experiments');
fprintf('\n\n')

fprintf('%10s','Design', 'T stat','P value');
fprintf('\n')

fprintf('%10s','Paired');
fprintf('%10.4f',t_paired,p_paired);
fprintf('\n')

fprintf('%10s','Unpaired');
fprintf('%10.4f',t_unpaired,p_unpaired);
fprintf('\n\n\n')


%% ANOVA table (randomized block design (block size 2 - sewage experiment)
eta = mean([y1;y2]);
SSB = 8*(mean(y1)-eta)^2+8*(mean(y2)-eta)^2;
SSTr = sum(2*(mean([y1,y2]')-eta).^2);
SSTotal = sum(([y1;y2]-eta).^2);
SSR = SSTotal-SSTr-SSB;
fprintf('\n')
fprintf('ANOVA Table (randomized block design), sewage experiments');
fprintf('\n\n')

fprintf('%10s','Source','DoF', 'Sum sq','Mean sq', 'F','Prob>F');
fprintf('\n')

fprintf('%10s','Sample');
fprintf('%10.4f',N-1,SSTr,SSTr/(N-1),SSTr/SSR,1-fcdf(SSTr/SSR,7,7));
fprintf('\n')

fprintf('%10s','Method');
fprintf('%10.4f',2-1,SSB,SSB,SSB*(N-1)/SSR,1-fcdf(SSB*(N-1)/SSR,1,7));
fprintf('\n')

fprintf('%10s','Residual');
fprintf('%10.4f',N-1,SSR,SSR/(N-1));
fprintf('\n')

fprintf('%10s','Total');
fprintf('%10.4f',16-1,SSTotal);
fprintf('\n\n\n')

%% One-way ANOVA table (incorrectly ignoring pairing - sewage experiment)
fprintf('\n')
fprintf('ANOVA Table (incorrectly ignoring pairing), sewage experiments');
fprintf('\n\n')
[p,tbl,stats] = anova1([y1 y2],[],'off');
disp(tbl);

