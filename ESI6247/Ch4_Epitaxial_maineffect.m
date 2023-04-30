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


%% main effect plot
zAp = mean(ym(find(x(:,1)==1)));
zAn = mean(ym(find(x(:,1)==-1)));
zBp = mean(ym(find(x(:,2)==1)));
zBn = mean(ym(find(x(:,2)==-1)));
zCp = mean(ym(find(x(:,3)==1)));
zCn = mean(ym(find(x(:,3)==-1)));
zDp = mean(ym(find(x(:,4)==1)));
zDn = mean(ym(find(x(:,4)==-1)));

mxla = [1,3,5,7,9,11,13,15];
my = [zAn, zAp, zBn, zBp, zCn, zCp, zDn, zDp];

figure('color','w');
plot(mxla(1:2),my(1:2),'.-','LineWidth',2,'MarkerSize',10);hold on;
plot(mxla(3:4),my(3:4),'.-','LineWidth',2,'MarkerSize',10);
plot(mxla(5:6),my(5:6),'.-','LineWidth',2,'MarkerSize',10);
plot(mxla(7:8),my(7:8),'.-','LineWidth',2,'MarkerSize',10);
hold off;
axis([0 16 13.8 14.5]);
set(gca,'XTick',0:16,'XTickLabel',{'';'-';'A';'+';'';'-';'B';'+';'';'-';'C';'+';'';'-';'D';'+';})
xlabel('Factor','FontSize',10,'FontWeight','bold');
title('Main Effects Plot','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',10,'FontWeight','bold');
