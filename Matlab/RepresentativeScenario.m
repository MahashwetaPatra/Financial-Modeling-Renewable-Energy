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
%% Provide with the Input
prompt = 'What is the year range for the animation?for example 20170310 ';
year = input(prompt,'s');
prompt = 'What is asset type, for example load, solar, wind? ';
assettype = input(prompt,'s');
prompt = 'What is the Asset name in the meda data file, for example Big_Spring_Wind_Farm.csv? ';
Assetname = input(prompt,'s');
prompt = 'How many representation scenario do you want? for example 100 ';
RepScenario = input(prompt);
prompt = 'At what hour we want to check the histogram nature? for example 10? ';
hours = input(prompt);
%%get the data in array for particular asset and date
T=1:1:24;%Time steps
files = dir('ORFEUS/SimDat_20170101/wind/*.csv');
filename=strcat('ORFEUS/SimDat_',year,'/',assettype,'/',Assetname);   
Array = readtable(filename); 
SizeScenario=size(Array);
b_array=zeros(1003,24);
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
%% plots the scenarios
figure(1);
subplot(2,2,1)
plot(T,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

%%uses the k-means algorithm
[idx, C] = kmeans(b_array(4:1003,:),RepScenario);

%%calculates the PCA factors
[coefficient,score]=pca(b_array(4:1003,:));
%%plots the extreme scenarios
subplot(2,2,2)
plot(T,C(:,:),'.-black','MarkerSize',5);
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

%% calculates the PCA on K-means
[coeffN,scoreN]=pca(C);

figure(2)%%plots the two histograms
subplot(2,1,1)
histogram(b_array(4:1003,hours),15)
xlim([0 20])
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

subplot(2,1,2)
histogram(C(:,hours),15)
xlim([0 20])
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

figure(1)
subplot(2,2,3)
plot(score(:,1),score(:,2),'.b','markersize',5)%plotting the coefficient1
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
x= [score(:,1), score(:,2)];%size(x)
[idx, C] = kmeans(x,RepScenario);

subplot(2,2,4)
plot(C(:,1),C(:,2),'.blue','MarkerSize',15);
hold on;
plot(scoreN(:,1),scoreN(:,2),'.black','markersize',15)%plotting the coefficient1
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
toc
