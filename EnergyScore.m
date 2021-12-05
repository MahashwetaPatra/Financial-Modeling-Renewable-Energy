%
% NOTE:    Calls energy score from all the aggregated assets, and plots it with date for load, solar, wind, all.
%
% HIST:  - 10 Aug, 2021: Created by Patra
%         
%=========================================================================
tic
clc;close all;
datetime.setDefaultFormats('defaultdate','yyyy-MM')
t = datetime(2017,1,1:31:730);
date1=t';% generating the xticks at every month for 2017 & 2018
for day=1:4
Array = readtable(strcat('Output/ES/ESIntraDay',num2str(day),'/Asset/ES_Scoville_All.csv'));% calls all the assets from a folder
date=1:1:730;% plotting the energy scores against days
loadES=Array{:,2}; % considering the Load energy score
solarES=Array{:,3}; % considering the Solar energy score
windES=Array{:,4}; % considering the Wind energy score
allES=Array{:,5}; % considering the overall energy score
figure(1);% plots the energy score for solar
subplot(4,1,day)
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',14,'LineWidth',2.75)
plot(date,solarES,'.-b')
ylabel('Solar ES')
xlim([1, 730]);
grid on;
set(gca,'xticklabel',{[]})

figure(2);% plots the energy score for wind
subplot(4,1,day)
plot(date,windES,'.-b')
ylabel('Wind ES')
xlim([1, 730]);
grid on;
xticks(1:31:730);
year=char(date1);
xlim([1, 730]);
xticklabels(num2str(year));
end
