%
% NOTE:    Calls all the wind/solar asset and the aggregated asset, from a day
%           and for that assets
%           Run the core PCA analysis on RTS scenarios (to double-check that we get the same patterns as for NREL-SRP output)
% HIST:  - 6 Jan, 2022: Created by Patra
%=========================================================================
tic
clc;close all; clear all;
Time=1:1:24;%Time steps
%files = dir('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/WindScenarios*.csv'); 
files = dir('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/SolarScenario*.csv'); 
l=length(files);
for i=l:l % l:l for aggregated assets %1:l-1 for all assets
    filename=files(i).name;
    Array = readtable(strcat('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/',filename)); 
    SizeScenario=size(Array);
    b_array=zeros(1001,24);
    for k=2:SizeScenario(1)
        b=zeros(24,1);
        col = Array(k,:);
        for i=1:24% put the asset in a array
            j=i+1;
            b(i)=col{1,j};
            b_array(k,i)=b(i);
        end
    end
    [coeff,score]=pca(b_array);
    CoeffMatrix=[coeff(:,1);coeff(:,2);coeff(:,3);coeff(:,4)];
    size(CoeffMatrix);
    figure(1)
    subplot(1,3,1) 
    %plot(Time,coeff(:,1), '-b', 'MarkerSize',5)              
    plot(Time,coeff(:,1), '-black', 'LineWidth',1.2)              
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    hold on;

    subplot(1,3,2)
    %plot(Time,coeff(:,2), '-b', 'MarkerSize',5) 
    plot(Time,coeff(:,2),'-black', 'LineWidth',1.2)
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    hold on;

    subplot(1,3,3)
    %plot(Time,coeff(:,3), '-b', 'MarkerSize',5) 
    plot(Time,coeff(:,3),'-black', 'LineWidth',1.2)
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    hold on;

    figure(2)
    plot(score(:,1),score(:,2),'.black', 'LineWidth',1.2)
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    hold on;
end
toc