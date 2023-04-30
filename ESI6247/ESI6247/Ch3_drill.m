% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Chapter 3 Drill Experiment - Transformation of Responses

clear all
close all
clc

x = xlsread('drill.xlsx','drill','A2:D17');
y = xlsread('drill.xlsx','drill','E2:E17');

k = 1;
for lamda = -2:0.1:2
    if lamda == 0
        z = log(y);
    else
        z = (y.^lamda-1)/lamda;
    end
    stats = regstats(z,x,'interaction');
    t(:,k) = stats.tstat.t(2:end);
    k = k+1;
end


figure('color','w');
for i = 1:10
    plot(-2:0.1:2,t(i,:),'.-');hold on;
end
hold off;
xlabel('lamda','FontSize',10,'FontWeight','bold');
ylabel('t statistics','FontSize',10,'FontWeight','bold');
title('Scaled lamda plot','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',1,'FontSize',10,'FontWeight','bold');