%
% NOTE:    Calls energy score for all the assets from different zones and plots the I_1, I_2, I_3, I_4 on the same plot
%  plots for solar, wind.
%
% HIST:  - 7 Nov, 2021: Created by Patra
%         
%=========================================================================
tic
clc;close all; 
datetime.setDefaultFormats('defaultdate','yyyy-MM')
t = datetime(2017,1,1:31:730);
date1=t';% generating the xticks at every month for 2017 & 2018
zones{1}='East';zones{2}='Coast';zones{3}='Far_West';zones{4}='North';
zones{5}='North_Central';zones{6}='South';zones{7}='South_Central';zones{8}='West';
files=dir('Output/ES/ESIntraDay1Zonal/Zonal/*.csv');
for j=1:8
    for i=1:4
        Array = readtable(strcat('Output/ES/ESIntraDay',num2str(i),'Zonal/Zonal/ES_Scoville_',zones{j}));
        %Array = readtable(strcat('Output/ES/ESDAZonal/Zonal/ES_Scoville_',zones{j}));
        date=1:1:730;% plotting the energy scores against days
        loadES=Array{:,2}; % considering the Load energy score
        solarES=Array{:,3}; % considering the Solar energy score
        windES=Array{:,4}; % considering the Wind energy score
        allES=Array{:,5}; % considering the overall energy score
        figure(1);% plots the energy score for wind
        subplot(8,1,j)% plots the energy score for wind
        plot(date,solarES,'.-')
        hold on;
        ylabel(strcat('solar-',zones(j)))
        grid on;
        xticks(1:31:730);
        year=char(date1);
        xlim([1, 730]);
        xticklabels(num2str(year));
        figure(2);% plots the energy score for wind
        subplot(8,1,j)% plots the energy score for wind
        plot(date,windES,'.-')
        hold on;
        ylabel(strcat('wind-',zones(j)))
        grid on;
        xticks(1:31:730);
        year=char(date1);
        xlim([1, 730]);
        xticklabels(num2str(year));
    end
end