%
% NOTE: Calls all the solar (I_2, I_3) and wind assets (I_1-I_4) 
% and for all assets calculates the Brier score
% for the max wind generation and Max solar generation 
% with the Brier scores shows histogram plot
% HIST:  - 13 Nov, 2021: Created by Patra
%         
%=========================================================================
tic
clc;close all; clear all;
Array = readtable('Scovilleriskpartners/CSV/metaData.xlsx');
for day=2:3% calculates the Brier score and its histogram for solar data
    SeriesSolar=[];
    for i=2:36 %38:151 for wind
        FileName=Array{i,2};
        BrierScoreSolar=BrierScoreCheck(FileName,day);
        SeriesSolar=[SeriesSolar;BrierScoreSolar];
    end
    figure(1)
    subplot(1,5,day)
    histogram(SeriesSolar,20)
    xlim([0 0.2])
    ylim([0 20])
    title(strcat('Intraday',num2str(day)))
end
for day=1:4%Brier score and histogram with it is generated for wind data
    SeriesWind=[];
    for i=38:151 %38:151 for wind
        FileName=Array{i,2};
        BrierScoreWind=BrierScoreCheckWind(FileName,day);
        SeriesWind=[SeriesWind;BrierScoreWind];
    end
    figure(2)
    subplot(1,5,day)
    histogram(SeriesWind,20)
    xlim([0 0.2])
    ylim([0 20])
    title(strcat('Intraday',num2str(day)))

end

toc