%
% NOTE:    Run the core PCA analysis on RTS Wind scenarios
%          From the low PC1 component, vatic output, i.e. high generation cost,
%          Load shedding are predicted
% HIST:  - 5 Feb, 2022: Created by Patra
%=========================================================================
tic
clc;close all; clear all;
filename=input('Asset type:','s')
Month=input('Month name:','s')    
Time=1:1:24;%Time steps
[GenIdx, ExtLoad, CurIdx, GenCost, LoadShed, Curtailment,MaxGen,l]=RTSDailySummaryFunction;
for i=1:1 % l:l for aggregated assets %1:l-1 for all assets
    %Array = readtable("C:\\Users\\Mahashweta Patra\\Documents\\MikeLudkovski\\ORFEUSRTS\\type-pwrset-jan20-20211229T210546Z-001\\type-pwrset-jan20\\WindScenariosAggregated.csv");
    %Array1 = readtable(strcat("C:\\Users\\Mahashweta Patra\\Downloads\\ProcessedData\\ProcessedData",Month,"\\LoadScenariosAggregated.csv")); 
    Array = readtable(strcat("C:\\Users\\Mahashweta Patra\\Downloads\\ProcessedData\\ProcessedData",Month,"\\WindScenariosAggregated.csv")); 
    %Array3 = readtable(strcat("C:\\Users\\Mahashweta Patra\\Downloads\\ProcessedData\\ProcessedData",Month,"\\SolarScenariosAggregated.csv")); 
    
    SizeScenario=size(Array);
    b_array=zeros(1000,24);
    for k=2:SizeScenario(1)
        b=zeros(24,1);
        col = Array(k,:);
        for i=1:24% put the asset in a array
            j=i;
            b(i)=col{1,j};
            b_array(k,i)=b(i);
        end
    end
    size(b_array)
    [coeff,score]=pca(b_array);
    CoeffMatrix=[coeff(:,1);coeff(:,2);coeff(:,3);coeff(:,4)];
    size(CoeffMatrix);
    figure()
    subplot(1,2,1) 
    plot(Time,coeff(:,1), '-black', 'LineWidth',1.2)
    hold on;
    plot(Time,coeff(:,2),'-blue', 'LineWidth',1.2)
    plot(Time,coeff(:,3),'-green', 'LineWidth',1.2)
    legend('PC1','PC2','PC3')
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    xlabel('Time')
    ylabel(strcat(filename,'PCs'))
    hold on;

    subplot(1,2,2)
    plot3(score(:,1),score(:,2),score(:,3),'.black', 'MarkerSize',15)
    hold on;
    b_ArrayNew=b_array(GenIdx,:);
    [coeffN,scoreN]=pca(b_ArrayNew);
    plot3(scoreN(:,1),scoreN(:,2),scoreN(:,3),'.blue', 'markersize',15)
    
    hold on;
    x=score(:,1);y=score(:,2);z=score(:,3);%x1=score(:,3);y1=score(:,4);
    j = boundary(x,y,z,1.0);
    size(j)
    %j = convhull(x,y);
    hold on;
    plot3(x(j),y(j),z(j),'.red','markersize',10);
    strValues =strtrim(cellstr(num2str((j),'%d')));
    %text(x(j),y(j),strValues);
    set(gca,'FontSize',12,'LineWidth',1.0)
    %xlabel(strcat(filename,'PC1'))
    %ylabel(strcat(filename,'PC2'))
    hold on;

    [ExtPC3, indexPC3]=sort(z);
    Ext=indexPC3(700:1000);
    figure()
    subplot(1,2,1)
    scatter(x,GenCost)
    
    subplot(1,2,2)
    scatter(z,LoadShed)

    Ext2=[];
    [ExtPC, index]=sort(x);
    Ext2=index(1:50);
    
    sizeExt2=size(Ext2)
    A=GenCost(index(1:50));
    B=MaxGen(950:1000);
    common=length(intersect(A,B))
    figure(1)
    subplot(1,3,1)
    hold on;
    histogram(GenCost(Ext2),15)
    
    figure(1)
    subplot(1,3,2)
    hold on;
    LoadShedExt=LoadShed(indexPC3(950:1000));
    %LoadShedExt=LoadShed(index(1:50));
    histogram(LoadShedExt,15)
    ln=find(LoadShedExt>0);
    l2=length(ln);
    commonLoadShed=l2/50
    figure(1)
    subplot(1,3,3)
    hold on;
    histogram(Curtailment(Ext2))

    avggencost=mean(GenCost)
    avgcurt=mean(Curtailment)
end
toc