%
% NOTE:    Calls energy score from all the aggregated assets, and plots it with date for load, solar, wind, all.
%
% HIST:  - 10 Aug, 2021: Created by Patra
%         
%=========================================================================
tic
clc;close all; clear all;
datetime.setDefaultFormats('defaultdate','yyyy-MM')
t = datetime(2017,1,1:31:730);
date1=t';% generating the xticks at every month for 2017 & 2018
Array = readtable('Output/ESIntraDay1/Asset/ES_Scoville_All.csv');% calls all the assets from a folder
date=1:1:730;% plotting the energy scores against days
loadES=Array{:,2}; % considering the Load energy score
solarES=Array{:,3}; % considering the Solar energy score
windES=Array{:,4}; % considering the Wind energy score
allES=Array{:,5}; % considering the overall energy score
fig=figure(1);
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',14,'LineWidth',2.75)
xlim([1, 730]);
subplot(4,1,1)% plots the energy score for load
plot(date,loadES,'.-b')
ylabel('Load ES')
xlim([1, 730]);
grid on;
set(gca,'xticklabel',{[]})
subplot(4,1,2)% plots the energy score for solar
plot(date,solarES,'.-b')
ylabel('Solar ES')
xlim([1, 730]);
grid on;
set(gca,'xticklabel',{[]})
subplot(4,1,3)% plots the energy score for wind
plot(date,windES,'.-b')
ylabel('Wind ES')
xlim([1, 730]);
grid on;
set(gca,'xticklabel',{[]})

subplot(4,1,4)% plots the energy score for All
plot(date,allES,'.-b')
ylabel('All ES')
xticks(1:31:730);
year=char(date1);
xlim([1, 730]);
xticklabels(num2str(year));
