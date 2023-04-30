% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Chapter 3 Latin square design - Wear Experiment

clc
clear all
close all

%% Setup

%Data matirx
data=[235 236 218 268; 251 241 227 229; 234 273 274 226;...
    195 270 230 225];

%Material Positions
A=[0 0 0 1; 1 0 0 0; 0 0 1 0; 0 1 0 0];
B=[0 0 1 0; 0 1 0 0; 0 0 0 1; 1 0 0 0];
C=[1 0 0 0; 0 0 0 1; 0 1 0 0; 0 0 1 0];
D=[0 1 0 0; 0 0 1 0; 1 0 0 0; 0 0 0 1];

%Will use this for treatment averages
one=[1 1 1 1]';

%% Data for ANOVA Table

datac=data(:);
yddd=mean(datac);

ydjd = mean(data)';
yidd= (mean(data'))';

ydd1=mean((data.*A)*one);
ydd2=mean((data.*B)*one);
ydd3=mean((data.*C)*one);
ydd4=mean((data.*D)*one);

yddl=[ydd1 ydd2 ydd3 ydd4]';

SSRow = 4*sum((yidd-yddd).^2);
SSCol = 4*sum((ydjd-yddd).^2);
SSTre = 4*sum((yddl-yddd).^2);
SSTot = sum((datac-yddd).^2);
SSRes=SSTot-SSTre-SSCol-SSRow;

MSSRow = 1/(4-1)*SSRow;
MSSCol = 1/(4-1)*SSCol;
MSSTre = 1/(4-1)*SSTre;
MSSRes = SSRes/((4-1)*(4-2));

FRow = MSSRow/MSSRes;
FCol = MSSCol/MSSRes;
FTre = MSSTre/MSSRes;


%% t-statistics for Multiple comparisons

t = zeros(4,4);
for i=1:4
    for j=i+1:4
        t(i,j) = (yddl(i)-yddl(j))/(sqrt(MSSRes)*sqrt(1/4+1/4));
    end
end

% Tukey Method Data at 0.05
q=4.9;
CP = 4.9/sqrt(2);


%% Anova Table

fprintf('ANOVA Table, Wear Experiment');
fprintf('\n')

fprintf('%6s','Source');
fprintf('%10s','df','SS','MSS','F');
fprintf('\n')

fprintf('%6s','Appl.   ');
fprintf('%10.4f',3,SSRow,MSSRow,FRow);
fprintf('\n')

fprintf('%6s','Position');
fprintf('%10.4f',3,SSCol,MSSCol, FCol);
fprintf('\n')

fprintf('%6s','Material');
fprintf('%10.4f',3,SSTre,MSSTre,FTre);
fprintf('\n')

fprintf('%6s','Residual');
fprintf('%10.4f',6,SSRes,MSSRes);
fprintf('\n')

fprintf('%6s','Total   ');
fprintf('%10.4f',4^2-1,SSTot);
fprintf('\n')

%% Mutiple Comparison Table

names={'A','B','C','D'};
fprintf('\n\n')
fprintf('Multiple Comparison t Statistics, Wear Experiment\n')
fprintf('\n')
for i=1:4
    for l=i+1:4
            fprintf('%-8s  %10.2f',strcat(names{i},' vs. ',names{l}),t(i,l));
            fprintf('\n')
    end
end

fprintf('\n')
fprintf('The critical value for the Tukey test is ')
disp(CP)


%% ANOVA Table Ignoring Blocking

ya=((data.*A)*one);
yb=((data.*B)*one);
yc=((data.*C)*one);
yd=((data.*D)*one);
y=[ya,yb,yc,yd];

SSMat = 4*sum((yddl - yddd).^2);
TotSS = sum((y(:)-yddd).^2);
ResSS=TotSS-SSMat;

fprintf('\n\n')
fprintf('ANOVA Table (Ignoring Blocking), Wear Experiment');
fprintf('\n')

fprintf('%6s','Source');
fprintf('%10s','df','SS','MSS','F');
fprintf('\n')

fprintf('%6s','Appl.   ');
fprintf('%10.4f',3,SSMat,SSMat/3,(SSMat/3)/(ResSS/12));
fprintf('\n')

fprintf('%6s','Residual');
fprintf('%10.4f',12,ResSS,ResSS/12);
fprintf('\n')












