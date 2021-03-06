%
% NOTE:    plots energy score for all the aggregated assets, for wind and
%          solar assets for Version 1 and version 2
%
% HIST:  - 10 Aug, 2021: Created by Patra
%           File path direction might need to be changed for different version 
%=========================================================================
tic
clc;close all;
datetime.setDefaultFormats('defaultdate','yyyy-MM')
t = datetime(2017,1,1:31:730);
date1=t';% generating the xticks at every month for 2017 & 2018
%% Getting the energy score for the verison 2
Array2 = readtable(strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Output2/ES/ESDANew/ES_Scoville_All.csv'));% calls energy score data for version-2 
loadES2=Array2{:,2}; % considering the Load energy score
solarES2=Array2{:,3}; % considering the Solar energy score
windES2=Array2{:,4}; % considering the Wind energy score
allES2=Array2{:,5}; % considering the overall energy score

%% Getting the energy score for the verison 1
Array = readtable(strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Output/ES/ESDA/Asset/ES_Scoville_All.csv'));% calls all the assets from a folder
loadES=Array{:,2}; % considering the Load energy score
solarES=Array{:,3}; % considering the Solar energy score
windES=Array{:,4}; % considering the Wind energy score
allES=Array{:,5}; % considering the overall energy score

%Array = readtable(strcat('Output/ES/ESIntraDay',num2str(day),'/Asset/ES_Scoville_All.csv'));% calls all the assets from a folder

L=length(solarES);
date=1:1:L;% plotting the energy scores against days

%% plots the energy score for solar, for version 1 and version 2

figure(1);
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',14,'LineWidth',2.75)
plot(date,solarES2,'.-r')
hold on;
plot(date,solarES,'.-b')
ylabel('Solar ES')
xlim([1, L]);
grid on;
xticks(1:31:L);
grid on;
set(gca,'xticklabel',{[]})

% plots the energy score for wind for version 1 and version 2

figure(2);
plot(date,windES2,'.-r')
hold on;
plot(date,windES,'.-b')
ylabel('Wind ES')
xlim([1, L]);
grid on;
xticks(1:31:L);
year=char(date1);
xlim([1, L]);
xticklabels(num2str(year));
MeanSolarES2=mean(solarES2)
MeanWindES2=mean(windES2)
%number of days where wind energy score for version 2 is bigger than version 1
NumDaysWindEsBigger=100-(length(windES2(abs(windES2)>abs(windES)))/730)*100
%number of days where solar energy score for version 2 is bigger than version 1
NumDaysSolarEsBigger=100-(length(solarES2(abs(solarES2)>abs(solarES)))/730)*100