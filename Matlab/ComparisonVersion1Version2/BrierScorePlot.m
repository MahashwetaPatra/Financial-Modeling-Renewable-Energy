% NOTE: It plots the distribution of Brier score for both wind and solar
% and calculates the mean of the distrbution for version-1, version-2
% subset and version-2 all assets
tic
clc;close all; clear all;

% Plot Brier score distribution for the event: zero wind generation
Array1 = readtable('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/BrierScore/wind_BrierScoreVersion1.csv');% read a single asset
BrierScore1=Array1{:,2};
MeanBrierScore1=mean(BrierScore1)

Array2 = readtable('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/BrierScore/wind_BrierScoreVersion2Subset.csv');% read a single asset
BrierScore2=Array2{:,2};
MeanBrierScore2=mean(BrierScore2)

Array3 = readtable('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/BrierScore/wind_BrierScoreVersion2AllAssets.csv');% read a single asset
BrierScore3=Array3{:,2};
MeanBrierScore3=mean(BrierScore3)

figure(1);%plotting
subplot(1,3,1)
histogram(BrierScore1)
subplot(1,3,2)
histogram(BrierScore2)
subplot(1,3,3)
histogram(BrierScore3)

% Plot Brier score distribution for the event maximum solar generation
Array1 = readtable('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/BrierScore/Solar_BrierScoreVersion1.csv');% read a single asset
BrierScore1=Array1{:,2};
MeanBrierScore1=mean(BrierScore1)

Array2 = readtable('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/BrierScore/Solar_BrierScoreVersion2Subset.csv');% read a single asset
BrierScore2=Array2{:,2};
MeanBrierScore2=mean(BrierScore2)

Array3 = readtable('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/BrierScore/Solar_BrierScoreVersion2AllAssets.csv');% read a single asset
BrierScore3=Array3{:,2};
MeanBrierScore3=mean(BrierScore3)

figure(2);% ploting
subplot(1,3,1)
histogram(BrierScore1,20)
subplot(1,3,2)
histogram(BrierScore2,20)
subplot(1,3,3)
histogram(BrierScore3,20)
