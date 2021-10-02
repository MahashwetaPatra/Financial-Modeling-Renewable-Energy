%
% NOTE: This is for calculating the shows the boundary of score phase space plot, i.e., showig the extreme scenarios 
%
% HIST:  - 27 Sep, 2021: Created by Patra
%=========================================================================
tic
clc;close all; clear all;
T1=1:1:24; %Time steps 
Array = readtable('Dropbox/HighLevel-Data/SimDat_20181126/solar/solar3.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170101/solar/Adamstown_Solar.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170101/wind/Aguayo_Wind.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170101/wind/Ajax_Wind.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170101/wind/Amazon_Wind_Farm_Texas.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170101/wind/Anacacho_Wind_Farm.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170101/wind/Appaloosa_Run_Renewable_Energy_Project.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170101/wind/Aquilla_Lake.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170101/solar/Agate_Solar.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170101/solar/Angelina_Solar.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170101/solar/Angelo_Solar.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170101/solar/Angus_Solar.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170101/solar/Anson_Solar.csv');% read a single asset

a_array=[];b_array=[];
for k=3:1002
    a=[];b=[];
    col = Array(k,:);
    hold on; 
    for i=1:24% put the asset in a array
        j=i+2;
        a=[a;T1(i)];
        b=[b;col{1,j}];
    end
    figure(1)
    subplot(1,2,1)
    plot(a,b,'Color', [0.7 0.7 0.7],'markersize',5)
    hold on;
    for i=1:24
        a_array(k,i)=a(i);
        b_array(k,i)=b(i);
    end
end
a_sorted=sort(a_array);
size(a_array);size(b_array);%final array of scenarios and time
am=mean(a_array);bm=mean(b_array);% calculating the mean of all the scenarios
plot(am,bm,'.-black','markersize',20)
hold on;
[coeff,score]=pca(b_array);
subplot(1,2,2)
A=[score(:,1),score(:,2)];
B=sort(A,1);
plot(score(:,1),score(:,2), '.cyan', 'markersize', 10)
hold on;
eps=1e-22;
score_boundary=[];
for i=985:1:1000 %choosing the extreme boundary cases
    idx = find(abs(score(:,1 )-B(i,1))<eps);
    plot(score(idx,1),score(idx,2), '.red', 'markersize', 20)
    strValues = strtrim(cellstr(num2str([idx],'(%d)')));
    text(score(idx,1),score(idx,2),strValues,'VerticalAlignment','bottom'); 
    score_boundary=[score_boundary;idx];
    
    idx = find(abs(score(:,2 )-B(i,2))<eps);
    plot(score(idx,1),score(idx,2), '.red', 'markersize', 20)
    strValues = strtrim(cellstr(num2str([idx],'(%d)')));
    text(score(idx,1),score(idx,2),strValues,'VerticalAlignment','bottom');
    score_boundary=[score_boundary;idx];
end
for i=1:1:15 %choosing the extreme boundary cases
    idx = find(abs(score(:,1 )-B(i,1))<eps);
    plot(score(idx,1),score(idx,2), '.blue', 'markersize', 20)
    strValues = strtrim(cellstr(num2str([idx],'(%d)')));
    text(score(idx,1),score(idx,2),strValues,'VerticalAlignment','bottom');
    score_boundary=[score_boundary;idx];
 
    idx = find(abs(score(:,2 )-B(i,2))<eps);
    plot(score(idx,1),score(idx,2), '.blue', 'markersize', 20)
    strValues = strtrim(cellstr(num2str([idx],'(%d)')));
    text(score(idx,1),score(idx,2),strValues,'VerticalAlignment','bottom');
    score_boundary=[score_boundary;idx];
end
length(score_boundary)
a_array=[];b_array=[];
for p=1:length(score_boundary)
    k=score_boundary(p);
    a=[];b=[];
    col = Array(k,:);
    hold on; 
    for i=1:24% put the asset in a array
        j=i+2;
        a=[a;T1(i)];
        b=[b;col{1,j}];
    end
    figure(1)
    subplot(1,2,1)
    if p<25
        plot(a,b, '-red','LineWidth',0.05)
        hold on;
    else
        plot(a,b, '-blue','LineWidth',0.05)
        hold on;
    end
end
toc