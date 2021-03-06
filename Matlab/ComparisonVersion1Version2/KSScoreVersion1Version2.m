%
% NOTE:    For solar and wind assets, calls the function KSScoreValues and
%           calculates the KS scores and compares for version1 and version 2 for the
%           simulation generated for TX20220427 and the Fall session using 'KSScorePlot'
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
ZoneName = {'Coast' 'East' 'Far_West' 'North' 'North_Central' 'South' 'South_Central' 'West'};

assettype='solar';
TotalAsset=36;
zones=7;

%% Acess percentile of version2
FileDir2=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/TX_PercentileEnergyScore20220427/Output2/Percentiles/DA',assettype,'Subset/');
%% Acess percentile of version1
FileDir1=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Output/Percentiles/DA',assettype,'/');

%% The function KSScoreValues calculates the KS scores on zonal and aggregated assets level
KSScoreValuesVersion1=KSScoreValues(FileDir1, assettype, TotalAsset, zones);
KSScoreValuesVersion2=KSScoreValues(FileDir2, assettype, TotalAsset, zones);
version1Solar=KSScoreValuesVersion1;
version2Solar=KSScoreValuesVersion2;

assettype='wind';
TotalAsset=115;
zones=5;

%% Acess percentile of version2
FileDir2=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/TX_PercentileEnergyScore20220427/Output2/Percentiles/DA',assettype,'Subset/');
%% Acess percentile of version1
FileDir1=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Output/Percentiles/DA',assettype,'/');

%% The function KSScoreValues calculates the KS scores on zonal and aggregated assets level
[version1Wind,ZonalDistribution]=KSScoreValues(FileDir1, assettype, TotalAsset, zones);
[version2Wind,ZonalDistribution]=KSScoreValues(FileDir2, assettype, TotalAsset, zones);

%% The function KSScorePlot shows the comparison between KS scores for Version1 and Version2
[KSScorePlot1, KSScorePlot2 ]=KSScorePlot(version1Solar, version2Solar, version1Wind, version2Wind)