%
% NOTE: Calls all the wind assets for intraday 1,2,3,4 and for all the wind assets 
%       calculates the Brier score for the max wind generation and 
%       with the Brier scores shows histogram plot
% HIST:  - 13 Nov, 2021: Created by Patra
%         
%=========================================================================
tic
clc;close all; clear all;
Array = readtable('Scovilleriskpartners/CSV/metaData.xlsx');
column=Array{38:152,8};
for day=1:4
    Series=[];
    for i=38:151
        FileName=Array{i,2};
        BrierScore=BrierScoreCheck(FileName,day);
        Series=[Series;BrierScore];
    end
    figure(1)
    subplot(1,5,day)
    histogram(Series,20)
    xlim([0 0.18])
    ylim([0 20])
    title(strcat('Intraday',num2str(day)))
end
toc