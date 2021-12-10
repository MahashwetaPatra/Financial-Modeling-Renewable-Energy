%
% NOTE:    Calls an asset, from a day and for that assets
%          calculates representative scenarios. The histogram from all scenarios 
%          and representative scenarios at different hours are compared and it matches well
% HIST:  - 12 Sep, 2021: Created by Patra
%          17th sep cleared and Added more notes to it
%          9th dec: the histogram from all scenarios and representative scenarios 
%          at different hours are compared and it matches well
%=========================================================================
tic
clc;close all; clear all;
prompt = 'What is the year range for the animation?for example 20170310 ';
year = input(prompt,'s');
prompt = 'What is asset type, for example load, solar, wind? ';
assettype = input(prompt,'s');
prompt = 'What is the Asset name in the meda data file, for example Big_Spring_Wind_Farm.csv? ';
Assetname = input(prompt,'s');

T=1:1:24;%Time steps
%files = dir('*.csv');% calls all the assets from a folder
files = dir('ORFEUS/SimDat_20170101/wind/*.csv');
filename=strcat('ORFEUS/SimDat_',year,'/',assettype,'/',Assetname)   
Array = readtable(filename); 
SizeScenario=size(Array);
b_array=zeros(1003,24);
RepScenario=100;
for k=3:SizeScenario(1)
    b=zeros(24,1);
    col = Array(k,:);
    hold on; 
    for i=1:24% put the asset in a array
        j=i+2;
        b(i)=col{1,j};
        b_array(k,i)=b(i);
    end
end
[coefficient,score]=pca(b_array(4:1003,:));
figure(1);
subplot(2,2,1)
plot(T,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
[idx, C] = kmeans(b_array(4:1003,:),RepScenario);
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

subplot(2,2,2)
hold on
plot(T,C(:,:),'.-black','MarkerSize',5);
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
hold off;
[coeffN,scoreN]=pca(C);

figure(3)
for hours=15:15
    subplot(2,1,1)
    histogram(b_array(4:1003,hours))
    subplot(2,1,2)
    histogram(C(:,hours))
end
figure(1)
subplot(2,2,3)
plot(score(:,1),score(:,2),'.b','markersize',5)%plotting the coefficient1
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
x= [score(:,1), score(:,2)];%size(x)
[idx, C] = kmeans(x,RepScenario);
subplot(2,2,4)
hold on
plot(C(:,1),C(:,2),'.blue','MarkerSize',15);
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
hold on;
plot(scoreN(:,1),scoreN(:,2),'.black','markersize',15)%plotting the coefficient1
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

toc