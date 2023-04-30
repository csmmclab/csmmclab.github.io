% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu
% Experiments for improving reliability from degradation data

% Degradation data visualiztion


clear all
close all
clc

run1 = xlsread('Luminosity.xlsx','luminosity','B1:H6');
run2 = xlsread('Luminosity.xlsx','luminosity','B8:N13');
run3 = xlsread('Luminosity.xlsx','luminosity','B15:H20');
run4 = xlsread('Luminosity.xlsx','luminosity','B22:N27');

[row1 column1]=size(run1);
[row2 column2]=size(run2);
%% Degregation Paths, Fluorescent Lamp Experiment

figure('color','w');
subplot(2,2,1)
for i=2:row1
    
   plot(run1(1,:),run1(i,:));
   title('run1'); 
   xlabel('hours'); 
   ylabel('relative luminosity');
   hold all
end

subplot(2,2,3)
for i=2:row1
    
   plot(run3(1,:),run3(i,:));
   title('run3'); 
   xlabel('hours'); 
   ylabel('relative luminosity');
   hold all
end
subplot(2,2,2)
for i=2:row2
    
   plot(run2(1,:),run2(i,:));
   title('run2'); 
   xlabel('hours'); 
   ylabel('relative luminosity');
   hold all
end
subplot(2,2,4)
for i=2:row2
    
   plot(run4(1,:),run4(i,:));
   title('run4'); 
   xlabel('hours'); 
   ylabel('relative luminosity');
   hold all
end