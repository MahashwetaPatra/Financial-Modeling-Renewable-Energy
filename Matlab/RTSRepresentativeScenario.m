%
% NOTE:    Choose the representative scenarios (i) using Kmean and knnsearch algorithm on 24 dimensional system,
%          (ii) using PCA analysis and Kmeans algorithm, knnsearch algorithm 
%          Then we compare the distribution of the generation cost with the generation cost distribution
%          The aggregated wind asset from RTS data is considered for a day
%          
% HIST:  - 18 Feb, 2021: Created by Patra
%=========================================================================
tic
%clc;close all; clear all;
%% Provide with the Input
RepScenario = input('Number of representative scenarios, e.g 100: ');
hours = input('At what hour we want to check the histogram nature? for example 10?: ');
Month=input('Month name:','s') 
[GenIdx, ExtLoad, CurIdx, GenCost, LoadShed, Curtailment,MaxGen]=RTSDailySummaryFunction;
%%get the data in array for particular asset and date
T=1:1:24;%Time steps
Array = readtable(strcat("C:\\Users\\Mahashweta Patra\\Downloads\\ProcessedData\\ProcessedData",Month,"\\WindScenariosAggregated.csv")); 
SizeScenario=size(Array);
b_array=zeros(1000,24);
for k=2:SizeScenario(1)
    b=zeros(24,1);
    col = Array(k,:);
    hold on; 
    for i=1:24% put the asset in a array
        j=i;
        b(i)=col{1,j};
        b_array(k,i)=b(i);
    end
end
%% plots the scenarios
figure();
subplot(2,2,1)
plot(T,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

%%uses the k-means algorithm
[idx, C] = kmeans(b_array,RepScenario);
[mIdx,mD] = knnsearch(b_array,C);
sizex=size(mIdx)
%%calculates the PCA factors
[coefficient,score]=pca(b_array);
%%plots the extreme scenarios
subplot(2,2,2)
plot(T,b_array(mIdx,:),'.-black','MarkerSize',5);
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

%% calculates the PCA on K-means
[coeffN,scoreN]=pca(C);

subplot(2,2,3)
plot(score(:,1),score(:,2),'.b','markersize',5)%plotting the coefficient1
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
x= [score(:,1), score(:,2)];%size(x)
[idx, C] = kmeans(x,RepScenario);
[nIdx,nD] = knnsearch(x,C);

subplot(2,2,4)
plot(score(:,1),score(:,2),'.blue','MarkerSize',15);
hold on;
plot(score(nIdx,1),score(nIdx,2),'.black','markersize',15)%plotting the coefficient1
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

%%plots the distribution of generation cost for representative scenarios
figure()
subplot(1,4,1)
h=histogram(GenCost)%,'Normalization','probability')
h.Normalization = 'probability';
h.BinWidth = 50000;
set(gca,'FontSize',10,'LineWidth',1.0)
xlim([70000,650000])
%hold on;
subplot(1,4,2)
h=histogram(GenCost(1:50),'Normalization','probability')
h.Normalization = 'probability';
h.BinWidth = 50000;
set(gca,'FontSize',10,'LineWidth',1.0)
xlim([70000,650000])

subplot(1,4,3)
h=histogram(GenCost(mIdx),'Normalization','probability')
h.Normalization = 'probability';
h.BinWidth = 50000;
set(gca,'FontSize',10,'LineWidth',1.0)
xlim([70000,650000])

subplot(1,4,4)
h=histogram(GenCost(nIdx),'Normalization','probability')
h.Normalization = 'probability';
h.BinWidth = 50000;
set(gca,'FontSize',10,'LineWidth',1.0)
xlim([70000,650000])
toc