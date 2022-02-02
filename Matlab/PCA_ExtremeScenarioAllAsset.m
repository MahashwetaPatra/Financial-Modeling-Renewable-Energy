%
% NOTE: This is for calling the function PCA_ExtremeScenarioWind and PCA_ExtremeScenarioSolar
%       which calculates the number of extreme scenarios for wind and solar assets 
%       and then plots the distribution
% HIST:  - 1 Dec, 2021: Created by Patra

tic
clc;close all;clear all;
year=20180808;
files = dir('ORFEUS/SimDat_20180101/wind/*.csv');% calls all the assets from a folder
l=length(files);numberset=zeros(l,1);
parfor i=1:l
    filename=strcat('ORFEUS/SimDat_',num2str(year),'/wind/',files(i).name);
    Array = readtable(filename);
    number=PCA_ExtremeScenarioWind(Array);
    numberset(i)=number;
end
figure(1)
title('Wind')
histogram(numberset,15)

files = dir('ORFEUS/SimDat_20180101/solar/*.csv');% calls all the assets from a folder
l=length(files);numberset=zeros(l,1);
parfor i=1:l
    filename=strcat('ORFEUS/SimDat_',num2str(year),'/solar/',files(i).name);
    Array = readtable(filename);
    number=PCA_ExtremeScenarioSolar(Array);
    numberset(i)=number;
end
figure(2)
title('Solar')
histogram(numberset,15)

toc
