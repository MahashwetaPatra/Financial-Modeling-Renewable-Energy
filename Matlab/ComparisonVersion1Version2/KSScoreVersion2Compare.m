%
% NOTE:    For solar and wind assets, calls the function KSScoreValues and
%           calculates the KS scores and compares for version 2 (TX20220427) for the
%           smaller subset (36 solar, 115 wind assets) and all assets (226 solar and 264 wind assets)
%           using 'KSScoreValues' and plot using function named 'KSScorePlot'
% 
%           Calls the percentile for all the assets, and for each assets 
%           does the Kolmogorov-Smirnov test using function 'KSScoreValues'
%           and then shows the comparison of KS score using 'KSScorePlot'
%           
%
% HIST:  - 25 Oct, 2021: Created by Patra
%          02 Nov,2021: Added the Kolmogorov-Smirnov Test
%          Version1 and version2 simulations are compared through the
%          change in KS score
%        
%=========================================================================
clc;close all;clear all;
assettype='solar';
TotalAsset=36;
zones=7;

%% Acess percentile of version2
FileDir2=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/TX_PercentileEnergyScore20220427/Output2/Percentiles/DA',assettype,'Subset/');
KSScoreValuesVersion2=KSScoreValues(FileDir2, assettype, TotalAsset, zones);

TotalAsset=226;
zones=8;
%% Acess percentile of version1
FileDir1=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/TX_PercentileEnergyScore20220427/Output2/Percentiles/DA',assettype,'/');

%% The function KSScoreValues calculates the KS scores on zonal and aggregated assets level
KSScoreValuesVersion1=KSScoreValues(FileDir1, assettype, TotalAsset, zones);

version1Solar=KSScoreValuesVersion1;
version2Solar=KSScoreValuesVersion2;

assettype='wind';
TotalAsset=115;
zones=5;

%% Acess percentile of version2
FileDir2=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/TX_PercentileEnergyScore20220427/Output2/Percentiles/DA',assettype,'Subset/');
KSScoreValuesVersion2=KSScoreValues(FileDir2, assettype, TotalAsset, zones);

TotalAsset=264;
zones=8;
%% Acess percentile of version1
FileDir1=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/TX_PercentileEnergyScore20220427/Output2/Percentiles/DA',assettype,'/');

%% The function KSScoreValues calculates the KS scores on zonal and aggregated assets level
KSScoreValuesVersion1=KSScoreValues(FileDir1, assettype, TotalAsset, zones);

version1Wind=KSScoreValuesVersion1;
version2Wind=KSScoreValuesVersion2;

%% The function KSScorePlot shows the comparison between KS scores for Version1 and Version2
KSScorePlot=KSScorePlot(version1Solar, version2Solar, version1Wind, version2Wind)