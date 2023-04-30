% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu
% Experiments for improving reliability from degradation data

% Degradation model estimation


clear all
close all
clc

run1 = xlsread('Luminosity.xlsx','luminosity','B1:H6');
run2 = xlsread('Luminosity.xlsx','luminosity','B8:N13');
run3 = xlsread('Luminosity.xlsx','luminosity','B15:H20');
run4 = xlsread('Luminosity.xlsx','luminosity','B22:N27');
effectname = {'Lamp1','Lamp2','Lamp3','Lamp4','Lamp5'}';

%% [L(t)+Lamba(t-100)]^2=Epsilon^2, L(t) from table
%%take the derivation in both sides to find lamda
%%Epsilon(1)^2+Epsilon(2)^2+Epsilon(3)^2+Epsilon(4)^2+Epsilon(5)=0
%%2*(t1-100)*[L(t1)+Lamda(t1-100)]+(2*(t2-100)*[L(t2)+Lamda(t2-100)]
%%+ 2*(t3-100)*[L(t3)+Lamda(t3-100)]+2*(t4-100)*[L(t4)+Lamda(t4-100)] 
%%+2*(t5-100)*[L(t5)+Lamda(t5-100)]=0
%% RUN1 LAMDAHAT, TIMEHAT, MUHAT, SIGMAHAT 
for ii=1:7
    y(1,ii)=2*(run1(1,ii)-100);
    z(1,ii)=y(1,ii)/2;
end 
for jj=2:6
syms Lamda;
eq= (y(1,1)*(run1(jj,1)+ Lamda*z(1,1)))+(y(1,2)*(run1(jj,2)+ Lamda*z(1,2)))+...
    (y(1,3)*(run1(jj,3)+ Lamda*z(1,3)))+(y(1,4)*(run1(jj,4)+ Lamda*z(1,4)))+...
    (y(1,5)*(run1(jj,5)+ Lamda*z(1,5)))+(y(1,6)*(run1(jj,6)+ Lamda*z(1,6)))+...
    (y(1,7)*(run1(jj,7)+ Lamda*z(1,7)));
lamda = solve(eq);
lamdahatrun1(1,jj-1)= double(lamda);
timehatrun1(1,jj-1)=(-log(0.6)/lamdahatrun1(1,jj-1))+100;
end
params1 = lognfit(timehatrun1);%muhat,sigmahat
% command window outputs
fprintf('\n\n')
fprintf('%15s','Run1','Lamdahat', 'Timehat','Muhat','Sigmahat');
fprintf('\n')
for i = 1:5
    fprintf('%15s',char(effectname(i)));
    fprintf('%15.2e',lamdahatrun1(i));
    fprintf('%15.2f',timehatrun1(i));
    if i==3
    fprintf('%15.2f',params1(1));
    fprintf('%15.4f',params1(2));
    end
    fprintf('\n');
end

%% RUN2 LAMDAHAT, TIMEHAT, MUHAT, SIGMAHAT 
for kk=1:13
    x(1,kk)=2*(run2(1,kk)-100);
    t(1,kk)=x(1,kk)/2;
end 

for jj=2:6
syms Lamda;
eq= (x(1,1)*(run2(jj,1)+ Lamda*t(1,1)))+(x(1,2)*(run2(jj,2)+ Lamda*t(1,2)))+...
    (x(1,3)*(run2(jj,3)+ Lamda*t(1,3)))+(x(1,4)*(run2(jj,4)+ Lamda*t(1,4)))+...
    (x(1,5)*(run2(jj,5)+ Lamda*t(1,5)))+(x(1,6)*(run2(jj,6)+ Lamda*t(1,6)))+...
    (x(1,7)*(run2(jj,7)+ Lamda*t(1,7)))+(x(1,8)*(run2(jj,8)+ Lamda*t(1,8)))+...
    (x(1,9)*(run2(jj,9)+ Lamda*t(1,9)))+(x(1,10)*(run2(jj,10)+ Lamda*t(1,10)))+...
    (x(1,11)*(run2(jj,11)+ Lamda*t(1,11)))+(x(1,12)*(run2(jj,12)+ Lamda*t(1,12)))+...
    (x(1,13)*(run2(jj,13)+ Lamda*t(1,13)));
lamda = solve(eq);
lamdahatrun2(1,jj-1)= double(lamda);
timehatrun2(1,jj-1)=(-log(0.6)/lamdahatrun2(1,jj-1))+100;
end
params2 = lognfit(timehatrun2);%muhat,sigmahat
% command window outputs
fprintf('\n\n')
fprintf('%15s','Run2','Lamdahat', 'Timehat','Muhat','Sigmahat');
fprintf('\n')
for i = 1:5
    fprintf('%15s',char(effectname(i)));
    fprintf('%15.2e',lamdahatrun2(i));
    fprintf('%15.2f',timehatrun2(i));
    if i==3
    fprintf('%15.2f',params2(1));
    fprintf('%15.4f',params2(2));
    end
    fprintf('\n');
end
%% RUN3 LAMDAHAT, TIMEHAT, MUHAT, SIGMAHAT 
for ii=1:7
    y(1,ii)=2*(run1(1,ii)-100);
    z(1,ii)=y(1,ii)/2;
end 
for jj=2:6
syms Lamda;
eq= (y(1,1)*(run3(jj,1)+ Lamda*z(1,1)))+(y(1,2)*(run3(jj,2)+ Lamda*z(1,2)))+...
    (y(1,3)*(run3(jj,3)+ Lamda*z(1,3)))+(y(1,4)*(run3(jj,4)+ Lamda*z(1,4)))+...
    (y(1,5)*(run3(jj,5)+ Lamda*z(1,5)))+(y(1,6)*(run3(jj,6)+ Lamda*z(1,6)))+...
    (y(1,7)*(run3(jj,7)+ Lamda*z(1,7)));
lamda = solve(eq);
lamdahatrun3(1,jj-1)= double(lamda);
timehatrun3(1,jj-1)=(-log(0.6)/lamdahatrun3(1,jj-1))+100;
end
params3 = lognfit(timehatrun3);%muhat,sigmahat
% command window outputs
fprintf('\n\n')
fprintf('%15s','Run3','Lamdahat', 'Timehat','Muhat','Sigmahat');
fprintf('\n')
for i = 1:5
    fprintf('%15s',char(effectname(i)));
    fprintf('%15.2e',lamdahatrun3(i));
    fprintf('%15.2f',timehatrun3(i));
    if i==3
    fprintf('%15.2f',params3(1));
    fprintf('%15.4f',params3(2));
    end
    fprintf('\n');
end
%% RUN4 LAMDAHAT, TIMEHAT, MUHAT, SIGMAHAT 
for kk=1:13
    x(1,kk)=2*(run2(1,kk)-100);
    t(1,kk)=x(1,kk)/2;
end 

for jj=2:6
syms Lamda;
eq= (x(1,1)*(run4(jj,1)+ Lamda*t(1,1)))+(x(1,2)*(run4(jj,2)+ Lamda*t(1,2)))+...
    (x(1,3)*(run4(jj,3)+ Lamda*t(1,3)))+(x(1,4)*(run4(jj,4)+ Lamda*t(1,4)))+...
    (x(1,5)*(run4(jj,5)+ Lamda*t(1,5)))+(x(1,6)*(run4(jj,6)+ Lamda*t(1,6)))+...
    (x(1,7)*(run4(jj,7)+ Lamda*t(1,7)))+(x(1,8)*(run4(jj,8)+ Lamda*t(1,8)))+...
    (x(1,9)*(run4(jj,9)+ Lamda*t(1,9)))+(x(1,10)*(run4(jj,10)+ Lamda*t(1,10)))+...
    (x(1,11)*(run4(jj,11)+ Lamda*t(1,11)))+(x(1,12)*(run4(jj,12)+ Lamda*t(1,12)))+...
    (x(1,13)*(run4(jj,13)+ Lamda*t(1,13)));
lamda = solve(eq);
lamdahatrun4(1,jj-1)= double(lamda);
timehatrun4(1,jj-1)=(-log(0.6)/lamdahatrun4(1,jj-1))+100;
end
params4 = lognfit(timehatrun4);%muhat,sigmahat
% command window outputs
fprintf('\n\n')
fprintf('%15s','Run4','Lamdahat', 'Timehat','Muhat','Sigmahat');
fprintf('\n')
for i = 1:5
    fprintf('%15s',char(effectname(i)));
    fprintf('%15.2e',lamdahatrun4(i));
    fprintf('%15.2f',timehatrun4(i));
    if i==3
    fprintf('%15.2f',params4(1));
    fprintf('%15.4f',params4(2));
    end
    fprintf('\n');
end
%% Lognormal lot for Predicted Failure Times

figure('color','w');
subplot(2,2,1)
probplot('lognormal',timehatrun1)
title('run1'); 
xlabel('hours'); 
ylabel('Cumulative Percent');


subplot(2,2,2)
probplot('lognormal',timehatrun2)
title('run2'); 
xlabel('hours'); 
ylabel('Cumulative Percent');


subplot(2,2,3)
probplot('lognormal',timehatrun3)
title('run3'); 
xlabel('hours'); 
ylabel('Cumulative Percent');


subplot(2,2,4)
probplot('lognormal',timehatrun4)
title('run4'); 
xlabel('hours'); 
ylabel('Cumulative Percent');



