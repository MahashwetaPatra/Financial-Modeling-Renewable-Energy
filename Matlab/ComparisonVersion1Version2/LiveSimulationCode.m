tic
clc;close all; clear all;
Time=1:1:24; %Time steps
files = dir('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/LiveSimulation/TX_SolarWindLoad_20220503/TX_SolarWindLoad_20220427/CSV/DA/SimDat_20170101/solar/*.csv');
ColumnSolar=[];
for i=1:length(files)
    filename=files(i).name;
    name=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/LiveSimulation/TX_SolarWindLoad_20220503/TX_SolarWindLoad_20220427/CSV/DA/SimDat_20180412/solar/',filename);
    Array = readtable(name);
    c1=Array{3,3:26};
    ColumnSolar=[ColumnSolar;c1];
    figure(1);
    plot(Time, c1,'b' )
    hold on;
end
csvwrite(strcat('C:/Users/Mahashweta Patra/Dropbox/MikeLudkovski/LiveSimulation/LiveSimulationSolar.csv'),ColumnSolar,1,1);

files = dir('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/LiveSimulation/TX_SolarWindLoad_20220503/TX_SolarWindLoad_20220427/CSV/DA/SimDat_20170101/wind/*.csv');
ColumnWind=[];
for i=1:length(files)
    filename=files(i).name;
    name=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/LiveSimulation/TX_SolarWindLoad_20220503/TX_SolarWindLoad_20220427/CSV/DA/SimDat_20180412/wind/',filename);
    Array = readtable(name);
    c1=Array{3,3:26};
    ColumnWind=[ColumnWind;c1];
    figure(2);
    plot(Time, c1,'b' )
    hold on;
end
csvwrite(strcat('C:/Users/Mahashweta Patra/Dropbox/MikeLudkovski/LiveSimulation/LiveSimulationWind.csv'),ColumnWind,1,1);
