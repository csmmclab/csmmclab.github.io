% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% interaction plots - layer growth experiment


clear all
close all
clc

x = xlsread('layergrowthcrossarray.xlsx','A3:H18');
thick = xlsread('layergrowthcrossarray.xlsx','I3:P18');

m1= [thick(:,1) thick(:,5)];
m2= [thick(:,2) thick(:,6)];
m3= [thick(:,3) thick(:,7)];
m4= [thick(:,4) thick(:,8)];

ym1 = mean(m1')';
ym2 = mean(m2')';
ym3 = mean(m3')';
ym4 = mean(m4')';


%% HxL interaction plot

zHnLn = mean(mean(thick(find(x(:,8)==-1),1:4)));
zHpLn = mean(mean(thick(find(x(:,8)==1),1:4)));
zHnLp = mean(mean(thick(find(x(:,8)==-1),5:8)));
zHpLp = mean(mean(thick(find(x(:,8)==1),5:8)));

figure('color','w');
plot(1:2,[zHnLn,zHnLp],'.-','LineWidth',2);hold on;
plot(1:2,[zHpLn,zHpLp],'.--','LineWidth',2);hold off;
text(2.2,zHnLp,'H-');
text(2.2,zHpLp,'H+');
set(gca,'XTick',1:2,'XTickLabel',{'-';'+'});
xlim([0 3]);
xlabel('L','FontSize',8,'FontWeight','bold');
title('HL','FontSize',8,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',8,'FontWeight','bold');


%% CxM interaction plot

zDnm1 = mean(ym1(find(x(:,3)==-1)));
zDpm1 = mean(ym1(find(x(:,3)==1)));
zDnm2 = mean(ym2(find(x(:,3)==-1)));
zDpm2 = mean(ym2(find(x(:,3)==1)));
zDnm3 = mean(ym3(find(x(:,3)==-1)));
zDpm3 = mean(ym3(find(x(:,3)==1)));
zDnm4 = mean(ym4(find(x(:,3)==-1)));
zDpm4 = mean(ym4(find(x(:,3)==1)));

figure('color','w');
plot(1:4,[zDnm1,zDnm2,zDnm3,zDnm4],'.-','LineWidth',2);hold on;
plot(1:4,[zDpm1,zDpm2,zDpm3,zDpm4],'.--','LineWidth',2);hold off;
text(4.0,zDnm4,'C-');
text(4.0,zDpm4,'C+');
set(gca,'XTick',1:4,'XTickLabel',{'1';'2';'3';'4'});
xlim([0 5]);
xlabel('M','FontSize',8,'FontWeight','bold');
title('CM','FontSize',8,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',8,'FontWeight','bold');



%% AxHxM interaction plot
zAnHnm1 = mean(ym1(find(x(:,1)==-1 & (x(:,8)==-1))));
zApHnm1 = mean(ym1(find(x(:,1)==1 & (x(:,8)==-1))));
zAnHpm1 = mean(ym1(find(x(:,1)==-1 & (x(:,8)==1))));
zApHpm1 = mean(ym1(find(x(:,1)==1 & (x(:,8)==1))));
zAnHnm2 = mean(ym2(find(x(:,1)==-1 & (x(:,8)==-1))));
zApHnm2 = mean(ym2(find(x(:,1)==1 & (x(:,8)==-1))));
zAnHpm2 = mean(ym2(find(x(:,1)==-1 & (x(:,8)==1))));
zApHpm2 = mean(ym2(find(x(:,1)==1 & (x(:,8)==1))));
zAnHnm3 = mean(ym3(find(x(:,1)==-1 & (x(:,8)==-1))));
zApHnm3 = mean(ym3(find(x(:,1)==1 & (x(:,8)==-1))));
zAnHpm3 = mean(ym3(find(x(:,1)==-1 & (x(:,8)==1))));
zApHpm3 = mean(ym3(find(x(:,1)==1 & (x(:,8)==1))));
zAnHnm4 = mean(ym4(find(x(:,1)==-1 & (x(:,8)==-1))));
zApHnm4 = mean(ym4(find(x(:,1)==1 & (x(:,8)==-1))));
zAnHpm4 = mean(ym4(find(x(:,1)==-1 & (x(:,8)==1))));
zApHpm4 = mean(ym4(find(x(:,1)==1 & (x(:,8)==1))));

figure('color','w');
plot(1:4,[zAnHnm1,zAnHnm2,zAnHnm3,zAnHnm4],'.-','LineWidth',2);hold on;
plot(1:4,[zApHpm1,zApHpm2,zApHpm3,zApHpm4],'.-','LineWidth',2);hold on;
plot(1:4,[zAnHpm1,zAnHpm2,zAnHpm3,zAnHpm4],'.-','LineWidth',2);hold on;
plot(1:4,[zApHnm1,zApHnm2,zApHnm3,zApHnm4],'.-','LineWidth',2);hold on;
text(4.0,zAnHnm4,'A- H-');
text(3.3,zApHpm3,'A+ H+');
text(3.0,zAnHpm4,'A- H+');
text(3.4,14.2,'A+ H-');
set(gca,'XTick',1:4,'XTickLabel',{'1';'2';'3';'4'});
xlim([0.8 4.5]);
xlabel('M','FontSize',8,'FontWeight','bold');
title('A H M','FontSize',8,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',8,'FontWeight','bold');



%% DxM interaction plot
zDnm1 = mean(ym1(find(x(:,4)==-1)));
zDpm1 = mean(ym1(find(x(:,4)==1)));
zDnm2 = mean(ym2(find(x(:,4)==-1)));
zDpm2 = mean(ym2(find(x(:,4)==1)));
zDnm3 = mean(ym3(find(x(:,4)==-1)));
zDpm3 = mean(ym3(find(x(:,4)==1)));
zDnm4 = mean(ym4(find(x(:,4)==-1)));
zDpm4 = mean(ym4(find(x(:,4)==1)));

figure('color','w');
plot(1:4,[zDnm1,zDnm2,zDnm3,zDnm4],'.-','LineWidth',2);hold on;
plot(1:4,[zDpm1,zDpm2,zDpm3,zDpm4],'.--','LineWidth',2);hold off;
text(4.0,zDnm4,'D-');
text(4.0,zDpm4,'D+');
set(gca,'XTick',1:4,'XTickLabel',{'1';'2';'3';'4'});
xlim([0 5]);
xlabel('M','FontSize',8,'FontWeight','bold');
title('DM','FontSize',8,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',8,'FontWeight','bold');

