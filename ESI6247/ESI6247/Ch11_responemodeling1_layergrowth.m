% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% response modeling - layer growth experiment
% response model effects - D, L, HL removed

clear all
close all
clc

x = xlsread('layergrowthresponse.xlsx','A1:L128');
thick = xlsread('layergrowthresponse.xlsx','M1:M128');


%% factorial effects, adapted epitaxial layer growth experiment

int2 = nchoosek(1:12,2);
for i = 1:length(int2)
    x(:,12+i) = x(:,int2(i,1)).*x(:,int2(i,2));
end
x(:,79) = x(:,1).*x(:,2).*x(:,9);
x(:,80) = x(:,1).*x(:,2).*x(:,10);
x(:,81) = x(:,1).*x(:,2).*x(:,11);
x(:,82) = x(:,1).*x(:,2).*x(:,12);
x(:,83) = x(:,1).*x(:,3).*x(:,9);
x(:,84) = x(:,1).*x(:,3).*x(:,10);
x(:,85) = x(:,1).*x(:,3).*x(:,11);
x(:,86) = x(:,1).*x(:,3).*x(:,12);
x(:,87) = x(:,1).*x(:,4).*x(:,9);
x(:,88) = x(:,1).*x(:,4).*x(:,10);
x(:,89) = x(:,1).*x(:,4).*x(:,11);
x(:,90) = x(:,1).*x(:,4).*x(:,12);
x(:,91) = x(:,1).*x(:,5).*x(:,9);
x(:,92) = x(:,1).*x(:,5).*x(:,10);
x(:,93) = x(:,1).*x(:,5).*x(:,11);
x(:,94) = x(:,1).*x(:,5).*x(:,12);
x(:,95) = x(:,1).*x(:,6).*x(:,9);
x(:,96) = x(:,1).*x(:,6).*x(:,10);
x(:,97) = x(:,1).*x(:,6).*x(:,11);
x(:,98) = x(:,1).*x(:,6).*x(:,12);
x(:,99) = x(:,1).*x(:,7).*x(:,9);
x(:,100) = x(:,1).*x(:,7).*x(:,10);
x(:,101) = x(:,1).*x(:,7).*x(:,11);
x(:,102) = x(:,1).*x(:,7).*x(:,12);
x(:,103) = x(:,1).*x(:,8).*x(:,9);
x(:,104) = x(:,1).*x(:,8).*x(:,10);
x(:,105) = x(:,1).*x(:,8).*x(:,11);
x(:,106) = x(:,1).*x(:,8).*x(:,12);
x(:,107) = x(:,1).*x(:,9).*x(:,10);
x(:,108) = x(:,1).*x(:,9).*x(:,11);
x(:,109) = x(:,1).*x(:,9).*x(:,12);
x(:,110) = x(:,2).*x(:,9).*x(:,10);
x(:,111) = x(:,2).*x(:,9).*x(:,11);
x(:,112) = x(:,2).*x(:,9).*x(:,12);
x(:,113) = x(:,3).*x(:,9).*x(:,10);
x(:,114) = x(:,3).*x(:,9).*x(:,11);
x(:,115) = x(:,3).*x(:,9).*x(:,12);
x(:,116) = x(:,4).*x(:,9).*x(:,10);
x(:,117) = x(:,4).*x(:,9).*x(:,11);
x(:,118) = x(:,4).*x(:,9).*x(:,12);
x(:,119) = x(:,5).*x(:,9).*x(:,10);
x(:,120) = x(:,5).*x(:,9).*x(:,11);
x(:,121) = x(:,5).*x(:,9).*x(:,12);
x(:,122) = x(:,6).*x(:,9).*x(:,10);
x(:,123) = x(:,6).*x(:,9).*x(:,11);
x(:,124) = x(:,6).*x(:,9).*x(:,12);
x(:,125) = x(:,7).*x(:,9).*x(:,10);
x(:,126) = x(:,7).*x(:,9).*x(:,11);
x(:,127) = x(:,7).*x(:,9).*x(:,12);
x(:,128) = x(:,8).*x(:,9).*x(:,10);
x(:,129) = x(:,8).*x(:,9).*x(:,11);
x(:,130) = x(:,8).*x(:,9).*x(:,12);

Sign=x;

for i=1:128
  ybar(i,1)= mean(thick(i,:));
end

neg=zeros(64,130);
pos=zeros(64,130);
negcount=zeros(1,130);
poscount=zeros(1,130);
for i=1:128
    for j=1:130
        if Sign(i,j)<0
            negcount(j)=negcount(j)+1;
            neg(negcount(j),j)=neg(negcount(j),j)+ybar(i);
           else
            poscount(j)=poscount(j)+1;
            pos(poscount(j),j)=pos(poscount(j),j)+ybar(i);
         end  
        
    end
   
end

for i=1:130
    ybareffect(i,1)=mean(pos(:,i))-mean(neg(:,i));
end

ymbeta=[ybareffect];
ymbetam=[ymbeta];
ymbetam(78,:) = [];

fprintf('\n')
fprintf('Factorial effects , epitaxial layer growth experiment');
fprintf('\n\n')

effectname = {'A','B','C','D','E','F','G','H','L','Ml',...
    'Mq','Mc','AB','AC','AD','AE','AF','AG','AH','AL','AMl',...
    'AMq','AMc','BC','BD','BE','BF','BG','BH','BL','BMl',...
    'BMq','BMc','CD','CE','CF','CG','CH','CL','CMl','CMq',...
    'CMc','DE','DF','DG','DH','DL','DMl','DMq','DMc','EF',...
    'EG','EH','EL','EMl','EMq','EMc','FG','FH','FL','FMl',...
    'FMq','FMc','GH','GL','GMl','GMq','GMc','HL','HMl','HMq',...
    'HMc','LMl','LMq','LMc','MlMq','MlMc','MqMc','ABL','ABMl',...
    'ABMq','ABMc','ACL','ACMl','ACMq','ACMc','ADL','ADMl','ADMq',...
    'ADMc','AEL','AEMl','AEMq','AEMc','AFL','AFMl','AFMq','AFMc',...
    'AGL','AGMl','AGMq','AGMc','AHL','AHMl','AHMq','AHMc','ALMl',...
    'ALMq','ALMc','BLMl','BLMq','BLMc','CLMl','CLMq','CLMc','DLMl',...
    'DLMq','DLMc','ELMl','ELMq','ELMc','FLMl','FLMq','FLMc','GLMl',...
    'GLMq','GLMc','HLMl','HLMq','HLMc'}';

fprintf('%15s','Effect','Y-mean');
fprintf('\n');
for i = 1:130
    fprintf('%15s',char(effectname(i)));
    fprintf('%14.3f',ymbeta(i));
    fprintf('\n');
end


%% Half-normal plot of location effects
absymbeta = abs(ymbetam);
[theta,idx] = sort(absymbeta);
p = 0.5+(0.5*(1:length(ymbetam))-0.5)/length(ymbetam);
phiinv = norminv(p,0,1);

figure('color','w')
plot(phiinv,theta,'.','MarkerSize',10);

for i = 127:129
     text(phiinv(i)-0.11,theta(i)-0.0003,effectname(idx(i)));
end
xlabel('\phi^{-1}(p(i))');
ylabel('absolute effects');
title('Half-normal plot of location effects');
axis([-0.02 3 -0.01 1]);

