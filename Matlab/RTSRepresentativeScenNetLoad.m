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
RepScenario = input('Number of representative scenarios, e.g 100: ');
hours = input('At what hour we want to check the histogram nature? for example 10?: ');
Month=input('Month name:','s') ;
[GenIdx, ExtLoad, CurIdx, GenCost, LoadShed, Curtailment,MaxGen]=RTSDailySummaryFunction(Month);

%%get the data in array for particular asset and date
T=1:1:24;%Time steps
Array1 = readtable(strcat("C:\\Users\\Mahashweta Patra\\Downloads\\ProcessedData\\ProcessedData",Month,"\\LoadScenariosAggregated.csv")); 
Array2 = readtable(strcat("C:\\Users\\Mahashweta Patra\\Downloads\\ProcessedData\\ProcessedData",Month,"\\WindScenariosAggregated.csv")); 
Array3 = readtable(strcat("C:\\Users\\Mahashweta Patra\\Downloads\\ProcessedData\\ProcessedData",Month,"\\SolarScenariosAggregated.csv")); 
SizeScenario=size(Array1);

b_array1=zeros(1000,24);
b_array2=zeros(1000,24);
b_array3=zeros(1000,24);

for k=1:SizeScenario(1)
    b1=zeros(24,1);
    col1 = Array1(k,:);
    b2=zeros(24,1);
    col2 = Array2(k,:);
    b3=zeros(24,1);
    col3 = Array3(k,:);
    for i=1:24% put the asset in a array
        j=i;
        b1(i)=col1{1,j};
        b_array1(k,i)=b1(i);
        b2(i)=col2{1,j};
        b_array2(k,i)=b2(i);
        b3(i)=col3{1,j};
        b_array3(k,i)=b3(i);
    end
end
b_array=b_array1-b_array2-b_array3;
%% plots the scenarios
figure(1);
subplot(2,2,1)
plot(T,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

%%uses the k-means algorithm
xinit=b_array(1:50,:);
[idx, C] = kmeans(b_array,RepScenario,'MaxIter',20000,'Start',xinit);
[mIdx,mD] = knnsearch(b_array,C,'K',1);
sizex=idx;
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
x= [score(:,1), score(:,2), score(:,3),score(:,4)];%size(x)
xinit=[score(1:RepScenario,1), score(1:RepScenario,2), score(1:RepScenario,3), score(1:RepScenario,4)];
%size(xinit)
[idx, C] = kmeans(x,RepScenario,'MaxIter',20000, 'Start',xinit);
[nIdx,nD] = knnsearch(x,C,'K',1);

subplot(2,2,4)
plot(C(:,1),C(:,2),'.blue','MarkerSize',15);
hold on;
plot(scoreN(:,1),scoreN(:,2),'.black','markersize',15)%plotting the coefficient1
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

figure()%%plots the two histograms
subplot(1,2,1)
histogram(b_array(:,hours),10)
%xlim([0 20])
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

subplot(1,2,2)
histogram(b_array(mIdx,hours),10)
%xlim([0 20])
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

%%plots the distribution of generation cost for representative scenarios
figure()
cdfplot(GenCost)
hold on;
cdfplot(GenCost(1:RepScenario))
cdfplot(GenCost(mIdx))
cdfplot(GenCost(nIdx))
set(gca,'FontSize',10,'LineWidth',1.0)
[h1, p1, k1]=kstest2(GenCost, GenCost(1:RepScenario));
[h2, p2, k2]=kstest2(GenCost, GenCost(mIdx));
[h3, p3, k3]=kstest2(GenCost, GenCost(nIdx));
[k1, k2, k3]
legend('GenCost',strcat('Subsampling,','K-S score: ',num2str(k1)),strcat('K-means,','K-S score: ',num2str(k2)),strcat('PCA+Kmeans,','K-S score: ',num2str(k3)),'Location','southeast')

S=sum(b_array,2);
figure()
plot(S,GenCost,'.blue','MarkerSize',10);
hold on;
plot(S(mIdx),GenCost(mIdx),'.red','MarkerSize',10);
hold on;
plot(S(nIdx),GenCost(nIdx),'.green','MarkerSize',10);
xlabel('Net Load Gwh')
ylabel('Generation cost')
toc