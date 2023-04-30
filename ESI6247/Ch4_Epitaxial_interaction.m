% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Chapter 4 Epitaxial Experiment - Full Factorial Experiment

clear all
close all
clc

x = xlsread('adaptedlayer.xlsx','adaptedlayer','B1:E16');
thick = xlsread('adaptedlayer.xlsx','adaptedlayer','F1:K16');
ym = mean(thick')';
lns2 = log(var(thick')');


%% interaction plot
zAnBn = mean(ym(find(x(:,1)==-1 & x(:,2)==-1)));
zApBn = mean(ym(find(x(:,1)==1 & x(:,2)==-1)));
zAnBp = mean(ym(find(x(:,1)==-1 & x(:,2)==1)));
zApBp = mean(ym(find(x(:,1)==1 & x(:,2)==1)));

zAnCn = mean(ym(find(x(:,1)==-1 & x(:,3)==-1)));
zApCn = mean(ym(find(x(:,1)==1 & x(:,3)==-1)));
zAnCp = mean(ym(find(x(:,1)==-1 & x(:,3)==1)));
zApCp = mean(ym(find(x(:,1)==1 & x(:,3)==1)));

zAnDn = mean(ym(find(x(:,1)==-1 & x(:,4)==-1)));
zApDn = mean(ym(find(x(:,1)==1 & x(:,4)==-1)));
zAnDp = mean(ym(find(x(:,1)==-1 & x(:,4)==1)));
zApDp = mean(ym(find(x(:,1)==1 & x(:,4)==1)));

zBnCn = mean(ym(find(x(:,2)==-1 & x(:,3)==-1)));
zBpCn = mean(ym(find(x(:,2)==1 & x(:,3)==-1)));
zBnCp = mean(ym(find(x(:,2)==-1 & x(:,3)==1)));
zBpCp = mean(ym(find(x(:,2)==1 & x(:,3)==1)));

zBnDn = mean(ym(find(x(:,2)==-1 & x(:,4)==-1)));
zBpDn = mean(ym(find(x(:,2)==1 & x(:,4)==-1)));
zBnDp = mean(ym(find(x(:,2)==-1 & x(:,4)==1)));
zBpDp = mean(ym(find(x(:,2)==1 & x(:,4)==1)));

zCnDn = mean(ym(find(x(:,3)==-1 & x(:,4)==-1)));
zCpDn = mean(ym(find(x(:,3)==1 & x(:,4)==-1)));
zCnDp = mean(ym(find(x(:,3)==-1 & x(:,4)==1)));
zCpDp = mean(ym(find(x(:,3)==1 & x(:,4)==1)));

figure('color','w');
subplot(2,3,1)
plot(1:2,[zAnBn,zAnBp],'.-','LineWidth',2);hold on;
plot(1:2,[zApBn,zApBp],'.--','LineWidth',2);hold off;
text(2.2,zAnBp,'A-');
text(2.2,zApBp,'A+');
set(gca,'XTick',1:2,'XTickLabel',{'-';'+'});
xlim([0 3]);
xlabel('B','FontSize',10,'FontWeight','bold');
title('AB','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',10,'FontWeight','bold');

subplot(2,3,2)
plot(1:2,[zAnCn,zAnCp],'.-','LineWidth',2);hold on;
plot(1:2,[zApCn,zApCp],'.--','LineWidth',2);hold off;
text(2.2,zAnCp,'A-');
text(2.2,zApCp,'A+');
set(gca,'XTick',1:2,'XTickLabel',{'-';'+'});
xlim([0 3]);
xlabel('C','FontSize',10,'FontWeight','bold');
title('AC','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',10,'FontWeight','bold');

subplot(2,3,3)
plot(1:2,[zAnDn,zAnDp],'.-','LineWidth',2);hold on;
plot(1:2,[zApDn,zApDp],'.--','LineWidth',2);hold off;
text(2.2,zAnDp,'A-');
text(2.2,zApDp,'A+');
set(gca,'XTick',1:2,'XTickLabel',{'-';'+'});
xlim([0 3]);
xlabel('D','FontSize',10,'FontWeight','bold');
title('AD','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',10,'FontWeight','bold');


subplot(2,3,4)
plot(1:2,[zBnCn,zBnCp],'.-','LineWidth',2);hold on;
plot(1:2,[zBpCn,zBpCp],'.--','LineWidth',2);hold off;
text(2.2,zBnCp,'B-');
text(2.2,zBpCp,'B+');
set(gca,'XTick',1:2,'XTickLabel',{'-';'+'});
xlim([0 3]);
xlabel('C','FontSize',10,'FontWeight','bold');
title('BC','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',10,'FontWeight','bold');


subplot(2,3,5)
plot(1:2,[zBnDn,zBnDp],'.-','LineWidth',2);hold on;
plot(1:2,[zBpDn,zBpDp],'.--','LineWidth',2);hold off;
text(2.2,zBnDp,'B-');
text(2.2,zBpDp,'B+');
set(gca,'XTick',1:2,'XTickLabel',{'-';'+'});
xlim([0 3]);
xlabel('D','FontSize',10,'FontWeight','bold');
title('BD','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',10,'FontWeight','bold');


subplot(2,3,6)
plot(1:2,[zCnDn,zCnDp],'.-','LineWidth',2);hold on;
plot(1:2,[zCpDn,zCpDp],'.--','LineWidth',2);hold off;
text(2.2,zCnDp,'C-');
text(2.2,zCpDp,'C+');
set(gca,'XTick',1:2,'XTickLabel',{'-';'+'});
xlim([0 3]);
xlabel('D','FontSize',10,'FontWeight','bold');
title('CD','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',10,'FontWeight','bold');

%% C-against-D and D-against-C
zCnDn = mean(ym(find(x(:,3)==-1 & x(:,4)==-1)));
zCpDn = mean(ym(find(x(:,3)==1 & x(:,4)==-1)));
zCnDp = mean(ym(find(x(:,3)==-1 & x(:,4)==1)));
zCpDp = mean(ym(find(x(:,3)==1 & x(:,4)==1)));

figure('color','w');
subplot(1,2,1)
plot(1:2,[zCnDn,zCnDp],'.-','LineWidth',2);hold on;
plot(1:2,[zCpDn,zCpDp],'.--','LineWidth',2);hold off;
text(2.2,zCnDp,'C-');
text(2.2,zCpDp,'C+');
set(gca,'XTick',1:2,'XTickLabel',{'-';'+'});
xlim([0 3]);
xlabel('D','FontSize',10,'FontWeight','bold');
title('CD','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',10,'FontWeight','bold');

subplot(1,2,2)
plot(1:2,[zCnDn,zCpDn],'.-','LineWidth',2);hold on;
plot(1:2,[zCnDp,zCpDp],'.--','LineWidth',2);hold off;
text(2.2,zCpDn,'D-');
text(2.2,zCpDp,'D+');
set(gca,'XTick',1:2,'XTickLabel',{'-';'+'});
xlim([0 3]);
xlabel('C','FontSize',10,'FontWeight','bold');
title('DC','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',10,'FontWeight','bold');
