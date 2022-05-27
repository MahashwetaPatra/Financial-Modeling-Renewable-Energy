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
ZoneName = {'Coast' 'East' 'Far_West' 'North' 'North_Central' 'South' 'South_Central' 'West'};
zones=8;

%% Acess percentile of version2+solar+subset assets and calculates KS score values
assettype='solar';
TotalAsset=36;
FileDir2=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/TX_PercentileEnergyScore20220427/Output2/Percentiles/DA',assettype,'Subset/');
KSScoreValuesversion2SolarSubset=KSScoreValues(FileDir2, assettype, TotalAsset, zones, ZoneName);
version2SolarSubset=KSScoreValuesversion2SolarSubset;

%% Acess percentile of version2+solar+All assets and calculates KS score values
TotalAsset=226;
FileDir1=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/TX_PercentileEnergyScore20220427/Output2/Percentiles/DA',assettype,'/');
KSScoreValuesversion2SolarAsset=KSScoreValues(FileDir1, assettype, TotalAsset, zones, ZoneName);
version2SolarAsset=KSScoreValuesversion2SolarAsset;

%% Acess percentile of version2+wind+subset assets and calculates KS score values
assettype='wind';
TotalAsset=115;
FileDir2=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/TX_PercentileEnergyScore20220427/Output2/Percentiles/DA',assettype,'Subset/');
KSScoreValuesVersion2=KSScoreValues(FileDir2, assettype, TotalAsset, zones, ZoneName);
version2WindSubset=KSScoreValuesVersion2;

%% Acess percentile of version2+wind+All assets and calculates KS score values
TotalAsset=264;
FileDir1=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/TX_PercentileEnergyScore20220427/Output2/Percentiles/DA',assettype,'/');
KSScoreValuesVersion1=KSScoreValues(FileDir1, assettype, TotalAsset, zones, ZoneName);
version2WindAsset=KSScoreValuesVersion1;

%% The function KSScorePlot shows the comparison between KS scores for Version2: subset and all asset
[KSScorePlot1, KSScorePlot2 ]=KSScorePlot(version2SolarSubset, version2SolarAsset, version2WindSubset, version2WindAsset)