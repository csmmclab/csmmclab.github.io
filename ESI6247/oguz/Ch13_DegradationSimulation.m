% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu
% Experiments for improving reliability from degradation data

% lognormal failure time simulation


clear all
close all
clc

time = 0:35000;

figure('color','w')
for i=1:200
    lamda = lognrnd(-10.5,0.2);
    Luminosity = -lamda*(time-100);
    big_index = find(Luminosity>log(0.6));
    plot(time(1:big_index(end)),Luminosity(1:big_index(end)));hold on;
    ftime(i) = time(big_index(end));
end

grid on;
hline = refline([0 log(0.6)]);
set(hline,'Color','r')
xlabel('Time');
ylabel('Log Relative Degradation');


figure('color','w')
[n,x] = hist(ftime,20);
bar(x,n,'hist');
%showing lognormal line
params = lognfit(ftime);
xx = linspace(0,max(ftime));
yy = lognpdf(xx,params(1),params(2)) * length(ftime) * (x(2)-x(1));
line(xx,yy,'color','r'); 
