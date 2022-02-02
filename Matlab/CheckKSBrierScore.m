%
% NOTE:    Calls all the assets, and for each assets does the Kolmogorov-Smirnov test and Brier score
%          plot the histograms for the KS score in figure 2 and the Brier score in figure 1
%          and plot KS score vs Brier score in Figure 3
%
% HIST:  - 15 Nov, 2021: Created by Patra
% Elapsed time is 3440.652007 seconds.        
%=========================================================================
tic
clc;close all; clear all;
scorevalue=BrierScoreValuesWind
IntraDayKSAll=KSScoreValuesWind
figure(3)
subplot(2,2,1)
plot(IntraDayKSAll(:,1),scorevalue(:,1),'.b', 'MarkerSize',10)
%title(IntraDay1)
subplot(2,2,2)
plot(IntraDayKSAll(:,2),scorevalue(:,2),'.b', 'MarkerSize',10)
subplot(2,2,3)
plot(IntraDayKSAll(:,3),scorevalue(:,3),'.b', 'MarkerSize',10)
subplot(2,2,4)
plot(IntraDayKSAll(:,4),scorevalue(:,4),'.b', 'MarkerSize',10)
toc
